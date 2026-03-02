import asyncio
from datetime import datetime, timezone
from db.database import AsyncSessionLocal
from sqlalchemy import delete
from db.models import DbDailyChallenge, DbUserChallengeProgress, DbUserLearningProgress


async def run():
    async with AsyncSessionLocal() as db:
        now_date = datetime.now(timezone.utc).date()
        # Fetch challenge
        from sqlalchemy import select

        stmt = select(DbDailyChallenge).where(
            DbDailyChallenge.challenge_date == now_date
        )
        res = await db.execute(stmt)
        challenge = res.scalars().first()
        if challenge:
            # Delete progress constraints
            await db.execute(
                delete(DbUserChallengeProgress).where(
                    DbUserChallengeProgress.challenge_id == challenge.id
                )
            )
            # update user learning progress so we can play again
            stmt = select(DbUserLearningProgress)
            res2 = await db.execute(stmt)
            users = res2.scalars().all()
            for user in users:
                user.last_daily_challenge_date = None
                user.current_streak = 0

            await db.execute(
                delete(DbDailyChallenge).where(DbDailyChallenge.id == challenge.id)
            )
            await db.commit()
            print("Deleted challenge")
        else:
            print("None found")


asyncio.run(run())
