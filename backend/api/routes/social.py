from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from sqlalchemy import desc, update, delete, func
from db.database import get_db
from db.models import DbUserProfile, DbTradeShare, DbTradeShareLike
from models.schemas import (
    UserProfileResponse, UserProfileUpdateRequest, LeaderboardEntry, 
    TradeShareRequest, TradeShareResponse
)
from datetime import datetime, timezone, date
import math
from typing import List, Optional

router = APIRouter()

@router.get("/search", response_model=List[LeaderboardEntry])
async def search_users(
    q: str = Query(..., min_length=1, description="Search query for username"),
    limit: int = Query(20, le=50),
    db: AsyncSession = Depends(get_db)
):
    """Search users by username (case-insensitive partial match)"""
    stmt = (
        select(DbUserProfile)
        .where(DbUserProfile.username.ilike(f"%{q}%"))
        .order_by(desc(DbUserProfile.total_xp))
        .limit(limit)
    )
    result = await db.execute(stmt)
    profiles = result.scalars().all()
    
    return [
        LeaderboardEntry(
            firebase_uid=p.firebase_uid,
            username=p.username,
            avatar_url=p.avatar_url,
            level=p.level,
            total_xp=p.total_xp,
            weekly_xp=p.weekly_xp,
            current_streak=p.current_streak,
            total_trades=p.total_trades,
            win_rate=p.win_rate,
            rank=idx + 1
        ) for idx, p in enumerate(profiles)
    ]

def calculate_level(total_xp: int) -> int:
    """Level = floor(sqrt(total_xp / 100)) + 1"""
    if total_xp < 0:
        return 1
    return math.floor(math.sqrt(total_xp / 100.0)) + 1

@router.get("/profile/{uid}", response_model=UserProfileResponse)
async def get_profile(uid: str, db: AsyncSession = Depends(get_db)):
    stmt = select(DbUserProfile).where(DbUserProfile.firebase_uid == uid)
    result = await db.execute(stmt)
    profile = result.scalars().first()
    
    if not profile:
        # Auto-create if doesn't exist
        profile = DbUserProfile(
            firebase_uid=uid,
            username=f"Trader_{uid[:6]}",
            total_xp=0,
            weekly_xp=0,
            level=1
        )
        db.add(profile)
        await db.commit()
        await db.refresh(profile)
        
    return UserProfileResponse(
        firebase_uid=profile.firebase_uid,
        username=profile.username,
        avatar_url=profile.avatar_url,
        bio=profile.bio,
        total_xp=profile.total_xp,
        weekly_xp=profile.weekly_xp,
        level=profile.level,
        current_streak=profile.current_streak,
        longest_streak=profile.longest_streak,
        total_trades=profile.total_trades,
        total_courses_completed=profile.total_courses_completed,
        total_challenges_completed=profile.total_challenges_completed,
        win_rate=profile.win_rate,
        last_activity_date=profile.last_activity_date.isoformat() if profile.last_activity_date else None
    )

@router.put("/profile/{uid}", response_model=UserProfileResponse)
async def update_profile(uid: str, req: UserProfileUpdateRequest, db: AsyncSession = Depends(get_db)):
    stmt = select(DbUserProfile).where(DbUserProfile.firebase_uid == uid)
    result = await db.execute(stmt)
    profile = result.scalars().first()
    
    if not profile:
        profile = DbUserProfile(
            firebase_uid=uid,
            username=req.username if req.username is not None else f"Trader_{uid[:6]}",
            avatar_url=req.avatar_url,
            bio=req.bio,
            total_xp=0,
            weekly_xp=0,
            level=1
        )
        db.add(profile)
    else:
        if req.username is not None:
            profile.username = req.username
        if req.avatar_url is not None:
            profile.avatar_url = req.avatar_url
        if req.bio is not None:
            profile.bio = req.bio
        
    await db.commit()
    await db.refresh(profile)
    
    return UserProfileResponse(
        firebase_uid=profile.firebase_uid,
        username=profile.username,
        avatar_url=profile.avatar_url,
        bio=profile.bio,
        total_xp=profile.total_xp,
        weekly_xp=profile.weekly_xp,
        level=profile.level,
        current_streak=profile.current_streak,
        longest_streak=profile.longest_streak,
        total_trades=profile.total_trades,
        total_courses_completed=profile.total_courses_completed,
        total_challenges_completed=profile.total_challenges_completed,
        win_rate=profile.win_rate,
        last_activity_date=profile.last_activity_date.isoformat() if profile.last_activity_date else None
    )

@router.get("/leaderboard", response_model=List[LeaderboardEntry])
async def get_leaderboard(
    type: str = Query("xp", description="xp, trades, streak, win_rate"),
    period: str = Query("allTime", description="weekly, allTime"),
    limit: int = Query(50, le=100),
    db: AsyncSession = Depends(get_db)
):
    query = select(DbUserProfile)
    
    if type == "xp":
        if period == "weekly":
            query = query.order_by(desc(DbUserProfile.weekly_xp))
        else:
            query = query.order_by(desc(DbUserProfile.total_xp))
    elif type == "trades":
        query = query.order_by(desc(DbUserProfile.total_trades))
    elif type == "streak":
        query = query.order_by(desc(DbUserProfile.current_streak))
    elif type == "win_rate":
        query = query.where(DbUserProfile.total_trades >= 5).order_by(desc(DbUserProfile.win_rate))
    else:
        query = query.order_by(desc(DbUserProfile.total_xp))
        
    query = query.limit(limit)
    result = await db.execute(query)
    profiles = result.scalars().all()
    
    leaderboard = []
    for idx, p in enumerate(profiles):
        leaderboard.append(LeaderboardEntry(
            firebase_uid=p.firebase_uid,
            username=p.username,
            avatar_url=p.avatar_url,
            level=p.level,
            total_xp=p.total_xp,
            weekly_xp=p.weekly_xp,
            current_streak=p.current_streak,
            total_trades=p.total_trades,
            win_rate=p.win_rate,
            rank=idx + 1
        ))
        
    return leaderboard



@router.post("/share", response_model=TradeShareResponse)
async def share_trade(req: TradeShareRequest, uid: str = Query(...), db: AsyncSession = Depends(get_db)):
    # 1. Fetch user profile
    stmt = select(DbUserProfile).where(DbUserProfile.firebase_uid == uid)
    res = await db.execute(stmt)
    profile = res.scalars().first()
    if not profile:
        raise HTTPException(status_code=404, detail="User profile not found")
        
    # 2. Create share
    share = DbTradeShare(
        firebase_uid=uid,
        trade_id=req.trade_id,
        symbol=req.symbol,
        side=req.side,
        quantity=req.quantity,
        price=req.price,
        pnl_percent=req.pnl_percent,
        caption=req.caption,
        likes_count=0,
        comments_count=0
    )
    db.add(share)
    
    # 3. Award XP for sharing
    profile.total_xp += 10
    profile.weekly_xp += 10
    profile.level = calculate_level(profile.total_xp)
    
    await db.commit()
    await db.refresh(share)
    
    return TradeShareResponse(
        id=share.id,
        firebase_uid=uid,
        author_name=profile.username,
        author_avatar=profile.avatar_url,
        author_level=profile.level,
        trade_id=share.trade_id,
        symbol=share.symbol,
        side=share.side,
        quantity=share.quantity,
        price=share.price,
        pnl_percent=share.pnl_percent,
        caption=share.caption,
        likes_count=0,
        comments_count=0,
        is_liked_by_me=False,
        created_at=share.created_at
    )

@router.get("/feed/{uid}", response_model=List[TradeShareResponse])
async def get_feed(uid: str, page: int = 1, limit: int = 20, db: AsyncSession = Depends(get_db)):
    # Fetch all trade shares (global feed)
    stmt_shares = (
        select(DbTradeShare, DbUserProfile)
        .join(DbUserProfile, DbTradeShare.firebase_uid == DbUserProfile.firebase_uid)
        .order_by(desc(DbTradeShare.created_at))
        .offset((page - 1) * limit)
        .limit(limit)
    )
    
    res_shares = await db.execute(stmt_shares)
    rows = res_shares.all()
    
    if not rows:
        return []
        
    share_ids = [row[0].id for row in rows]
    
    # Check which ones I liked
    stmt_likes = select(DbTradeShareLike.share_id).where(
        DbTradeShareLike.share_id.in_(share_ids),
        DbTradeShareLike.firebase_uid == uid
    )
    res_likes = await db.execute(stmt_likes)
    liked_share_ids = set(res_likes.scalars().all())
    
    response = []
    for share, profile in rows:
        response.append(TradeShareResponse(
            id=share.id,
            firebase_uid=share.firebase_uid,
            author_name=profile.username,
            author_avatar=profile.avatar_url,
            author_level=profile.level,
            trade_id=share.trade_id,
            symbol=share.symbol,
            side=share.side,
            quantity=share.quantity,
            price=share.price,
            pnl_percent=share.pnl_percent,
            caption=share.caption,
            likes_count=share.likes_count,
            comments_count=share.comments_count,
            is_liked_by_me=(share.id in liked_share_ids),
            created_at=share.created_at
        ))
        
    return response

@router.post("/like/{share_id}")
async def like_share(share_id: int, uid: str = Query(...), db: AsyncSession = Depends(get_db)):
    # Check if already liked
    stmt = select(DbTradeShareLike).where(
        DbTradeShareLike.share_id == share_id,
        DbTradeShareLike.firebase_uid == uid
    )
    res = await db.execute(stmt)
    if res.scalars().first():
        return {"status": "ok"}
        
    # Add like
    like = DbTradeShareLike(share_id=share_id, firebase_uid=uid)
    db.add(like)
    
    # Increment count
    stmt_share = select(DbTradeShare).where(DbTradeShare.id == share_id)
    res_share = await db.execute(stmt_share)
    share = res_share.scalars().first()
    if share:
        share.likes_count += 1
        
    await db.commit()
    return {"status": "ok"}

@router.delete("/like/{share_id}")
async def unlike_share(share_id: int, uid: str = Query(...), db: AsyncSession = Depends(get_db)):
    stmt = select(DbTradeShareLike).where(
        DbTradeShareLike.share_id == share_id,
        DbTradeShareLike.firebase_uid == uid
    )
    res = await db.execute(stmt)
    like = res.scalars().first()
    
    if like:
        await db.delete(like)
        
        # Decrement count
        stmt_share = select(DbTradeShare).where(DbTradeShare.id == share_id)
        res_share = await db.execute(stmt_share)
        share = res_share.scalars().first()
        if share and share.likes_count > 0:
            share.likes_count -= 1
            
        await db.commit()
        
    return {"status": "ok"}

@router.post("/xp/award")
async def award_xp(uid: str = Query(...), xp: int = Query(...), db: AsyncSession = Depends(get_db)):
    """Internal endpoint or utility route to award XP"""
    stmt = select(DbUserProfile).where(DbUserProfile.firebase_uid == uid)
    res = await db.execute(stmt)
    profile = res.scalars().first()
    
    if not profile:
        profile = DbUserProfile(
            firebase_uid=uid,
            username=f"Trader_{uid[:6]}",
            total_xp=xp,
            weekly_xp=xp,
            level=calculate_level(xp)
        )
        db.add(profile)
    else:
        profile.total_xp += xp
        profile.weekly_xp += xp
        profile.level = calculate_level(profile.total_xp)
        
    await db.commit()
    return {"status": "ok", "total_xp": profile.total_xp, "level": profile.level}
