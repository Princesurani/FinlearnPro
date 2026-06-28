from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from typing import Dict, Any

from db.database import get_db
from db.models import DbUserLearningProgress, DbUser, DbInstructor
from models.schemas import InstructorResponse

router = APIRouter()

from services.user_service import get_or_create_user

@router.post("/progress/sync/{firebase_uid}")
async def sync_progress(firebase_uid: str, progress_data: Dict[Any, Any], db: AsyncSession = Depends(get_db)):
    """
    Receives JSON progress payload from the Flutter client and saves/updates it.
    """
    # Ensure user exists first using the central user service helper
    await get_or_create_user(db, firebase_uid)
    await db.commit()

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


COURSE_INSTRUCTOR_MAP = {
    "foundations": "sarah",
    "stock_market": "rajesh",
    "c3-crypto": "elena",
    "c4-forex": "michael",
    "c5-commodities": "michael",
    "c6-technical": "sarah",
    "c7-fundamental": "rajesh",
    "c8-risk": "sarah",
    "c9-practice": "sarah",
    "c10-derivatives": "michael",
    "c11-styles": "sarah",
    "c12-setup": "rajesh",
    "c13-consistent": "sarah"
}

@router.get("/instructor/{course_id}", response_model=InstructorResponse)
async def get_instructor(course_id: str, db: AsyncSession = Depends(get_db)):
    """
    Fetches the instructor profile details for a given course ID.
    """
    instructor_id = COURSE_INSTRUCTOR_MAP.get(course_id, "sarah")
    result = await db.execute(select(DbInstructor).where(DbInstructor.id == instructor_id))
    instructor = result.scalar_one_or_none()
    if not instructor:
        raise HTTPException(status_code=404, detail="Instructor profile not found")
    return instructor
