from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from sqlalchemy import desc, update, delete, func
from db.database import get_db
from db.models import DbUserProfile, DbFollower, DbTradeShare, DbTradeShareLike
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
    q: str = Query(..., min_length=1, description="Search query for display name"),
    limit: int = Query(20, le=50),
    db: AsyncSession = Depends(get_db)
):
    """Search users by display name (case-insensitive partial match)"""
    stmt = (
        select(DbUserProfile)
        .where(DbUserProfile.display_name.ilike(f"%{q}%"))
        .order_by(desc(DbUserProfile.total_xp))
        .limit(limit)
    )
    result = await db.execute(stmt)
    profiles = result.scalars().all()
    
    return [
        LeaderboardEntry(
            firebase_uid=p.firebase_uid,
            display_name=p.display_name,
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
            display_name=f"Trader_{uid[:6]}",
            total_xp=0,
            weekly_xp=0,
            level=1
        )
        db.add(profile)
        await db.commit()
        await db.refresh(profile)
        
    return UserProfileResponse(
        firebase_uid=profile.firebase_uid,
        display_name=profile.display_name,
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
        raise HTTPException(status_code=404, detail="Profile not found")
        
    if req.display_name is not None:
        profile.display_name = req.display_name
    if req.avatar_url is not None:
        profile.avatar_url = req.avatar_url
    if req.bio is not None:
        profile.bio = req.bio
        
    await db.commit()
    await db.refresh(profile)
    
    return UserProfileResponse(
        firebase_uid=profile.firebase_uid,
        display_name=profile.display_name,
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
            display_name=p.display_name,
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

@router.post("/follow/{follower_uid}/{target_uid}")
async def follow_user(follower_uid: str, target_uid: str, db: AsyncSession = Depends(get_db)):
    if follower_uid == target_uid:
        raise HTTPException(status_code=400, detail="Cannot friend yourself")
        
    # Check existing A -> B
    stmt = select(DbFollower).where(
        DbFollower.follower_uid == follower_uid, 
        DbFollower.following_uid == target_uid
    )
    res = await db.execute(stmt)
    if not res.scalars().first():
        new_follow_1 = DbFollower(follower_uid=follower_uid, following_uid=target_uid)
        db.add(new_follow_1)

    # Check existing B -> A
    stmt2 = select(DbFollower).where(
        DbFollower.follower_uid == target_uid, 
        DbFollower.following_uid == follower_uid
    )
    res2 = await db.execute(stmt2)
    if not res2.scalars().first():
        new_follow_2 = DbFollower(follower_uid=target_uid, following_uid=follower_uid)
        db.add(new_follow_2)
        
    await db.commit()
    return {"status": "ok", "message": "Friends added successfully"}

@router.delete("/follow/{follower_uid}/{target_uid}")
async def unfollow_user(follower_uid: str, target_uid: str, db: AsyncSession = Depends(get_db)):
    # Delete A -> B
    stmt = select(DbFollower).where(
        DbFollower.follower_uid == follower_uid, 
        DbFollower.following_uid == target_uid
    )
    res = await db.execute(stmt)
    follow_1 = res.scalars().first()
    if follow_1:
        await db.delete(follow_1)

    # Delete B -> A
    stmt2 = select(DbFollower).where(
        DbFollower.follower_uid == target_uid, 
        DbFollower.following_uid == follower_uid
    )
    res2 = await db.execute(stmt2)
    follow_2 = res2.scalars().first()
    if follow_2:
        await db.delete(follow_2)
        
    await db.commit()
    return {"status": "ok", "message": "Unfriended successfully"}

@router.get("/followers/{uid}")
async def get_followers(uid: str, db: AsyncSession = Depends(get_db)):
    # People who follow me
    stmt1 = select(DbFollower.follower_uid).where(DbFollower.following_uid == uid)
    res1 = await db.execute(stmt1)
    followers = res1.scalars().all()
    
    # People I follow
    stmt2 = select(DbFollower.following_uid).where(DbFollower.follower_uid == uid)
    res2 = await db.execute(stmt2)
    following = res2.scalars().all()
    
    return {
        "followers": list(followers),
        "following": list(following)
    }

@router.get("/friends/{uid}", response_model=List[LeaderboardEntry])
async def get_friends(uid: str, db: AsyncSession = Depends(get_db)):
    # People I follow
    stmt = select(DbFollower.following_uid).where(DbFollower.follower_uid == uid)
    res = await db.execute(stmt)
    following_uids = res.scalars().all()
    
    if not following_uids:
        return []
        
    stmt2 = select(DbUserProfile).where(DbUserProfile.firebase_uid.in_(following_uids))
    res2 = await db.execute(stmt2)
    profiles = res2.scalars().all()
    
    friends = []
    for p in profiles:
        friends.append(LeaderboardEntry(
            firebase_uid=p.firebase_uid,
            display_name=p.display_name,
            avatar_url=p.avatar_url,
            level=p.level,
            total_xp=p.total_xp,
            weekly_xp=p.weekly_xp,
            current_streak=p.current_streak,
            total_trades=p.total_trades,
            win_rate=p.win_rate,
            rank=0
        ))
    # Sort friends by XP
    friends.sort(key=lambda x: x.total_xp, reverse=True)
    return friends


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
        author_name=profile.display_name,
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
    # Get people I follow
    stmt_following = select(DbFollower.following_uid).where(DbFollower.follower_uid == uid)
    res_following = await db.execute(stmt_following)
    following_uids = res_following.scalars().all()
    
    # Include myself in feed
    uids_to_fetch = list(following_uids) + [uid]
    
    # Fetch trade shares
    stmt_shares = (
        select(DbTradeShare, DbUserProfile)
        .join(DbUserProfile, DbTradeShare.firebase_uid == DbUserProfile.firebase_uid)
        .where(DbTradeShare.firebase_uid.in_(uids_to_fetch))
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
            author_name=profile.display_name,
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
            display_name=f"Trader_{uid[:6]}",
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
