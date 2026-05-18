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
    correct_choice_id: Optional[int] = None

class SubmitChallengeRequest(BaseModel):
    firebase_uid: str
    choice_id: int

class SubmitChallengeResponse(BaseModel):
    is_correct: bool
    explanation: str
    xp_awarded: int
    streak_updated: bool
    correct_choice_id: int

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
    
    # Auto-generate if today's challenge is missing
    if not challenge or challenge.challenge_date != now_date:
        from services.llm_challenge_generator import generate_and_save_challenge
        await generate_and_save_challenge(now_date)
        
        # Re-fetch
        stmt = select(DbDailyChallenge).where(DbDailyChallenge.challenge_date == now_date)
        result = await db.execute(stmt)
        challenge = result.scalars().first()

        if not challenge:
            raise HTTPException(status_code=404, detail="No daily challenges found and generation failed.")

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
        "explanation": None,
        "correct_choice_id": None
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
        if progress.was_correct:
            response_data["explanation"] = challenge.explanation_correct
        else:
            response_data["explanation"] = f"{challenge.explanation_incorrect}\n\n**Correct Answer Rationale:** {challenge.explanation_correct}"
        response_data["correct_choice_id"] = challenge.correct_choice_index
        
    return response_data

@router.post("/daily/submit", response_model=SubmitChallengeResponse)
async def submit_daily_challenge(req: SubmitChallengeRequest, db: AsyncSession = Depends(get_db)):
    """
    Submits an answer. Awards XP and increments streak if correct.
    """
    # 1. Fetch latest daily challenge
    now_date = datetime.now(timezone.utc).date()
    stmt = select(DbDailyChallenge).order_by(desc(DbDailyChallenge.challenge_date)).limit(1)
    result = await db.execute(stmt)
    challenge = result.scalars().first()
    
    if not challenge or challenge.challenge_date != now_date:
        raise HTTPException(status_code=400, detail="Today's challenge is not active or hasn't been generated yet.")
        
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
    if is_correct:
        explanation = challenge.explanation_correct
    else:
        explanation = f"{challenge.explanation_incorrect}\n\n**Correct Answer Rationale:** {challenge.explanation_correct}"
    xp_awarded = 50 if is_correct else 10
    
    # 4. Record progress
    new_progress = DbUserChallengeProgress(
        firebase_uid=req.firebase_uid,
        challenge_id=challenge.id,
        was_correct=is_correct
    )
    db.add(new_progress)
    
    # 5. Award XP and update stats in DbUserProfile
    from db.models import DbUserProfile
    from api.routes.social import calculate_level
    
    prof_stmt = select(DbUserProfile).where(DbUserProfile.firebase_uid == req.firebase_uid)
    prof_res = await db.execute(prof_stmt)
    profile = prof_res.scalars().first()
    
    streak_updated = False
    if profile:
        profile.total_xp += xp_awarded
        profile.weekly_xp += xp_awarded
        profile.level = calculate_level(profile.total_xp)
        profile.total_challenges_completed += 1
        
        # Simple streak logic: if correct and last activity wasn't today
        if not profile.last_activity_date or profile.last_activity_date != now_date:
            if is_correct:
                if profile.last_activity_date and (now_date - profile.last_activity_date).days == 1:
                    profile.current_streak += 1
                else:
                    profile.current_streak = 1 # Reset or start new streak
                    
                if profile.current_streak > profile.longest_streak:
                    profile.longest_streak = profile.current_streak
                streak_updated = True
            else:
                profile.current_streak = 0 # Break streak if wrong
                
        profile.last_activity_date = now_date
    else:
        # Auto-create profile if missing
        new_prof = DbUserProfile(
            firebase_uid=req.firebase_uid,
            total_xp=xp_awarded,
            weekly_xp=xp_awarded,
            level=calculate_level(xp_awarded),
            total_challenges_completed=1,
            current_streak=1 if is_correct else 0,
            longest_streak=1 if is_correct else 0,
            last_activity_date=now_date
        )
        db.add(new_prof)
        streak_updated = is_correct
    
    await db.commit()
    
    return SubmitChallengeResponse(
        is_correct=is_correct,
        explanation=explanation,
        xp_awarded=xp_awarded,
        streak_updated=streak_updated,
        correct_choice_id=challenge.correct_choice_index
    )
