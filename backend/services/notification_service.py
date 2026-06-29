from sqlalchemy.ext.asyncio import AsyncSession
from db.models import DbNotification
from datetime import datetime, timezone

async def create_db_notification(db: AsyncSession, firebase_uid: str, title: str, description: str, category: str):
    """
    Asynchronously creates and persists a notification record in PostgreSQL.
    """
    notification = DbNotification(
        firebase_uid=firebase_uid,
        title=title,
        description=description,
        category=category,
        timestamp=datetime.now(timezone.utc),
        is_read=False
    )
    db.add(notification)
