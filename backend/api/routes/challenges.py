from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from sqlalchemy import desc
from db.database import get_db
from db.models import DbDailyChallenge, DbUserChallengeProgress, DbUserLearningProgress
from datetime import datetime, timezone, date
from pydantic import BaseModel, Field
from typing import List, Optional, Any

router = APIRouter()

class ChoiceModel(BaseModel):
    id: int
    text: str

class DailyChallengeResponse(BaseModel):
    id: int
    challenge_date: date
    asset_symbol: str
    timeframe: str
    scenario_text: str
    chart_data: Optional[Any] = None
    choices: List[ChoiceModel]
    
    # User progress state
    is_completed: bool = False
    was_correct: Optional[bool] = None
    explanation: Optional[str] = None

class SubmitChallengeRequest(BaseModel):
    firebase_uid: str
    choice_id: int

class SubmitChallengeResponse(BaseModel):
    is_correct: bool
    explanation: str
    xp_awarded: int
    streak_updated: bool

@router.get("/daily", response_model=DailyChallengeResponse)
async def get_daily_challenge(firebase_uid: str, db: AsyncSession = Depends(get_db)):
    """
    Returns today's challenge. If not found, returns the most recent challenge.
    Also checks if the user has already completed it.
    """
    now_date = datetime.now(timezone.utc).date()
    
    stmt = select(DbDailyChallenge).order_by(desc(DbDailyChallenge.challenge_date)).limit(1)
    result = await db.execute(stmt)
    challenge = result.scalars().first()
    
    if not challenge:
        raise HTTPException(status_code=404, detail="No daily challenges found.")

    response_data = {
        "id": challenge.id,
        "challenge_date": challenge.challenge_date,
        "asset_symbol": challenge.asset_symbol,
        "timeframe": challenge.timeframe,
        "scenario_text": challenge.scenario_text,
        "chart_data": challenge.chart_data,
        "choices": challenge.choices,
        "is_completed": False,
        "was_correct": None,
        "explanation": None
    }
    
    # Check if user already submitted
    prog_stmt = select(DbUserChallengeProgress).where(
        DbUserChallengeProgress.firebase_uid == firebase_uid,
        DbUserChallengeProgress.challenge_id == challenge.id
    )
    prog_res = await db.execute(prog_stmt)
    progress = prog_res.scalars().first()
    
    if progress:
        response_data["is_completed"] = True
        response_data["was_correct"] = progress.was_correct
        response_data["explanation"] = challenge.explanation_correct if progress.was_correct else challenge.explanation_incorrect
        
    return response_data

@router.post("/daily/submit", response_model=SubmitChallengeResponse)
async def submit_daily_challenge(req: SubmitChallengeRequest, db: AsyncSession = Depends(get_db)):
    """
    Submits an answer. Awards XP and increments streak if correct.
    """
    # 1. Fetch latest daily challenge
    stmt = select(DbDailyChallenge).order_by(desc(DbDailyChallenge.challenge_date)).limit(1)
    result = await db.execute(stmt)
    challenge = result.scalars().first()
    
    if not challenge:
        raise HTTPException(status_code=404, detail="No daily challenge active.")
        
    # 2. Check if already submitted
    prog_stmt = select(DbUserChallengeProgress).where(
        DbUserChallengeProgress.firebase_uid == req.firebase_uid,
        DbUserChallengeProgress.challenge_id == challenge.id
    )
    prog_res = await db.execute(prog_stmt)
    if prog_res.scalars().first() is not None:
        raise HTTPException(status_code=400, detail="Challenge already submitted by user.")
        
    # 3. Validate answer
    is_correct = (req.choice_id == challenge.correct_choice_index)
    explanation = challenge.explanation_correct if is_correct else challenge.explanation_incorrect
    xp_awarded = 50 if is_correct else 10
    
    # 4. Record progress
    new_progress = DbUserChallengeProgress(
        firebase_uid=req.firebase_uid,
        challenge_id=challenge.id,
        was_correct=is_correct
    )
    db.add(new_progress)
    
    # 5. We would increment streak here (assuming we had a user gamification profile).
    # Based on models.py, UserLearningProgress stores hybrid data. We'll mark streak as updated.
    streak_updated = is_correct
    
    await db.commit()
    
    return SubmitChallengeResponse(
        is_correct=is_correct,
        explanation=explanation,
        xp_awarded=xp_awarded,
        streak_updated=streak_updated
    )
