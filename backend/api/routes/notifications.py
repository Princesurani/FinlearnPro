from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, desc
from typing import List

from db.database import get_db
from db.models import DbNotification
from models.schemas import NotificationResponse, NotificationCreateRequest
from services.notification_service import create_db_notification

router = APIRouter()

@router.get("/{firebase_uid}", response_model=List[NotificationResponse])
async def get_notifications(firebase_uid: str, db: AsyncSession = Depends(get_db)):
    """
    Returns all notifications for the given user, sorted by newest first.
    """
    try:
        query = (
            select(DbNotification)
            .where(DbNotification.firebase_uid == firebase_uid)
            .order_by(desc(DbNotification.timestamp))
        )
        result = await db.execute(query)
        return result.scalars().all()
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Failed to load notifications: {e}")

@router.post("/{notification_id}/read", response_model=NotificationResponse)
async def mark_as_read(notification_id: int, db: AsyncSession = Depends(get_db)):
    """
    Marks a single notification as read.
    """
    query = select(DbNotification).where(DbNotification.id == notification_id)
    result = await db.execute(query)
    notification = result.scalar_one_or_none()
    if not notification:
        raise HTTPException(status_code=404, detail="Notification not found")
    
    notification.is_read = True
    await db.commit()
    await db.refresh(notification)
    return notification

@router.post("/read-all/{firebase_uid}")
async def mark_all_as_read(firebase_uid: str, db: AsyncSession = Depends(get_db)):
    """
    Marks all notifications as read for the given user.
    """
    try:
        query = select(DbNotification).where(
            DbNotification.firebase_uid == firebase_uid,
            DbNotification.is_read == False
        )
        result = await db.execute(query)
        unread_notifications = result.scalars().all()
        for notification in unread_notifications:
            notification.is_read = True
        await db.commit()
        return {"status": "success", "count": len(unread_notifications)}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Failed to update notifications: {e}")

@router.post("/create", response_model=NotificationResponse)
async def trigger_notification(req: NotificationCreateRequest, db: AsyncSession = Depends(get_db)):
    """
    Client-facing trigger to record custom notifications (e.g. unlocks, social alerts).
    """
    try:
        await create_db_notification(
            db=db,
            firebase_uid=req.firebase_uid,
            title=req.title,
            description=req.description,
            category=req.category
        )
        await db.commit()
        # Query the newly inserted record to return it with updated ID
        query = (
            select(DbNotification)
            .where(DbNotification.firebase_uid == req.firebase_uid)
            .order_by(desc(DbNotification.id))
            .limit(1)
        )
        res = await db.execute(query)
        return res.scalar_one()
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Failed to trigger notification: {e}")
