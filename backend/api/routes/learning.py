from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from typing import Dict, Any

from db.database import get_db
from db.models import DbUserLearningProgress, DbUser

router = APIRouter()

@router.post("/progress/sync/{firebase_uid}")
async def sync_progress(firebase_uid: str, progress_data: Dict[Any, Any], db: AsyncSession = Depends(get_db)):
    """
    Receives JSON progress payload from the Flutter client and saves/updates it.
    """
    # Ensure user exists first
    result = await db.execute(select(DbUser).where(DbUser.firebase_uid == firebase_uid))
    user = result.scalar_one_or_none()
    
    if not user:
        user = DbUser(
            firebase_uid=firebase_uid,
            email=None,
            balance_india=10_000.0,
            balance_usa=10_000.0,
            balance_uk=10_000.0,
            balance_crypto=10_000.0,
        )
        db.add(user)
        await db.flush()

    # Check if progress exists
    prog_result = await db.execute(
        select(DbUserLearningProgress).where(DbUserLearningProgress.firebase_uid == firebase_uid)
    )
    progress_record = prog_result.scalar_one_or_none()
    
    if progress_record:
        progress_record.progress_data = progress_data
    else:
        new_record = DbUserLearningProgress(
            firebase_uid=firebase_uid,
            progress_data=progress_data
        )
        db.add(new_record)
        
    await db.commit()
    return {"status": "success"}

@router.get("/progress/{firebase_uid}")
async def get_progress(firebase_uid: str, db: AsyncSession = Depends(get_db)):
    """
    Fetches the JSON progress payload for the specified user.
    """
    prog_result = await db.execute(
        select(DbUserLearningProgress).where(DbUserLearningProgress.firebase_uid == firebase_uid)
    )
    progress_record = prog_result.scalar_one_or_none()
    
    if not progress_record:
        return {"data": None}
        
    return {"data": progress_record.progress_data}
