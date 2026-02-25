import asyncio
from apscheduler.schedulers.asyncio import AsyncIOScheduler
from services.llm_challenge_generator import generate_and_save_challenge
from datetime import datetime, timezone, timedelta

async def run_daily_generation():
    # Schedule generation for the next day
    tomorrow = datetime.now(timezone.utc).date() + timedelta(days=1)
    print(f"Running scheduled LLM generation for {tomorrow}...")
    await generate_and_save_challenge(tomorrow)

def start_cron():
    scheduler = AsyncIOScheduler()
    # Run every day at 00:00 UTC (or immediately for demo purposes)
    scheduler.add_job(run_daily_generation, 'cron', hour=0, minute=0)
    scheduler.start()
    print("Background cron started for daily challenges.")

if __name__ == "__main__":
    start_cron()
    asyncio.get_event_loop().run_forever()
