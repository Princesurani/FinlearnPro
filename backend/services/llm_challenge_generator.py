import os
import json
import random
import asyncio
import logging
from datetime import datetime, timezone, timedelta
from dotenv import load_dotenv

logger = logging.getLogger(__name__)

from google import genai
from google.genai import types
from sqlalchemy.ext.asyncio import AsyncSession
from db.database import AsyncSessionLocal
from db.models import DbDailyChallenge

load_dotenv()

# Configure Gemini
api_key = os.getenv("GEMINI_API_KEY")
client = genai.Client(api_key=api_key) if api_key else genai.Client()

generation_config = types.GenerateContentConfig(
    temperature=0.7,
    top_p=0.95,
    top_k=40,
)

SYSTEM_PROMPT = """
You are an expert financial educator. Your task is to generate a dynamic, interactive "Daily Challenge" for a stock market learning app.
The challenge should look like a realistic market scenario (e.g., technical analysis, fundamental analysis, or trading psychology).

CRITICAL CONSTRAINTS FOR EDUCATION & LAYOUT:
1. SCENARIO: Keep the `scenario_text` clear and concise (under 40 words). Describe a specific setup ending with a clear question (e.g., "What is the most probable next price movement?").
2. OPTIONS: Make the choices extremely direct and concise (8-15 words max per choice). They should represent clear actions or outcomes that fit nicely inside mobile UI elements.
3. CORRECT INDEX: Ensure there is exactly one correct choice, and that the index corresponds to it (0 to 3).
4. EXPLANATION CORRECT: A concise explanation (2-3 sentences max). Start with a direct statement of why the correct option is right, followed by the educational principle.
5. EXPLANATION INCORRECT: A concise explanation (2-3 sentences max) explaining why the distractors are wrong or represent common psychological traps.
6. CHART DATA: Include a `chart_data` array containing between 7 and 12 floating-point values representing a realistic, simulated historical price trend matching the scenario context (e.g. if the scenario is a double bottom support hold, the values should decrease, bounce, decrease to the same level, and then rise).

Please output ONLY a valid JSON object matching this schema exactly:
{
    "asset_symbol": "String (e.g., BTC/USDT, AAPL, RELIANCE)",
    "timeframe": "String (e.g., 4H, Daily, 15m)",
    "scenario_text": "String describing the setup. E.g., 'The RSI is at 80 while price is making lower highs.'",
    "chart_data": [100.0, 101.5, 99.8, 102.4, 98.5, 97.0, 95.2],
    "choices": [
        {"id": 0, "text": "Choice 1"},
        {"id": 1, "text": "Choice 2"},
        {"id": 2, "text": "Choice 3"},
        {"id": 3, "text": "Choice 4"}
    ],
    "correct_choice_index": Integer (0 to 3),
    "explanation_correct": "String explaining why the correct answer is right.",
    "explanation_incorrect": "String explaining why the other choices are incorrect."
}

Ensure the distractors (wrong choices) are plausible but demonstrably incorrect to teach a valid financial lesson. Do not include any markdown format tags like ```json or trailing commentary.
"""


async def generate_and_save_challenge(target_date: datetime.date):
    """
    Calls the LLM to generate a challenge and saves it to the DB for the given target_date.
    """
    # 1. Check if challenge for this date already exists in DB
    async with AsyncSessionLocal() as db:
        from sqlalchemy import select

        stmt = select(DbDailyChallenge).where(
            DbDailyChallenge.challenge_date == target_date
        )
        res = await db.execute(stmt)
        if res.scalars().first():
            logger.info(
                f"Challenge for {target_date} already exists. Skipping LLM generation."
            )
            return

    topics = [
        "Bearish divergence on RSI",
        "Bull flag breakout",
        "Earnings report beat but weak guidance trap",
        "Head and Shoulders pattern",
        "Fed interest rate hike impact on growth stocks",
        "Value vs Growth investing dynamic",
        "Double bottom support hold",
    ]
    selected_topic = random.choice(topics)

    prompt = f"Generate a challenge focusing on: {selected_topic}."

    logger.info(f"Generating challenge for {target_date} on topic: {selected_topic}...")

    attempts = 3
    data = None

    for attempt in range(attempts):
        try:
            response = client.models.generate_content(
                model="gemini-2.5-flash",
                contents=[SYSTEM_PROMPT, prompt],
                config=generation_config,
            )
            content = response.text.strip()
            if content.startswith("```json"):
                content = content[7:]
            elif content.startswith("```"):
                content = content[3:]
            if content.endswith("```"):
                content = content[:-3]
            content = content.strip()

            # Parse JSON
            logger.debug(f"DEBUG raw LLM output: {repr(content)}")
            data = json.loads(content)
            break
        except Exception as e:
            logger.warning(f"Attempt {attempt + 1} to generate challenge failed: {e}")
            if attempt < attempts - 1:
                await asyncio.sleep(2 ** (attempt + 1))

    fallback_used = False
    if not data:
        logger.error("Failed to generate daily challenge via LLM. Loading fallback challenge...")
        data = random.choice(FALLBACK_CHALLENGES)
        fallback_used = True

    try:
        async with AsyncSessionLocal() as db:
            challenge = DbDailyChallenge(
                challenge_date=target_date,
                asset_symbol=data["asset_symbol"],
                timeframe=data["timeframe"],
                scenario_text=data["scenario_text"],
                chart_data=data.get("chart_data"),
                choices=data["choices"],
                correct_choice_index=data["correct_choice_index"],
                explanation_correct=data["explanation_correct"],
                explanation_incorrect=data["explanation_incorrect"],
            )
            db.add(challenge)
            await db.commit()
            logger.info(f"Successfully saved challenge for {target_date} (fallback_used={fallback_used}).")
    except Exception as e:
        logger.error(f"Error saving daily challenge to DB: {e}")


FALLBACK_CHALLENGES = [
    {
        "asset_symbol": "AAPL",
        "timeframe": "Daily",
        "scenario_text": "AAPL's price makes higher highs, but the RSI is forming lower highs. What is the most probable next price movement?",
        "chart_data": [100.0, 101.5, 100.8, 102.3, 101.7, 103.0, 102.5, 104.2, 103.5],
        "choices": [
            {"id": 0, "text": "Price will likely reverse downwards soon."},
            {"id": 1, "text": "Price will continue its strong upward trend."},
            {"id": 2, "text": "Price will consolidate sideways before moving higher."},
            {"id": 3, "text": "Price movement is unpredictable; no clear signal."}
        ],
        "correct_choice_index": 0,
        "explanation_correct": "This is a classic bearish divergence, signaling weakening momentum despite price gains. The market is likely to reverse downwards, making it prudent to exit long positions or initiate a short trade.",
        "explanation_incorrect": "Buying more or holding ignores the critical warning of bearish divergence, risking significant losses if the price reverses. While a stop-loss is good risk management, it doesn't address the primary signal to actively position for a downside move."
    },
    {
        "asset_symbol": "RELIANCE",
        "timeframe": "Daily",
        "scenario_text": "RELIANCE has formed a double bottom pattern and is currently testing the neckline resistance with strong volume. What is the most probable next move?",
        "chart_data": [2500.0, 2400.0, 2380.0, 2450.0, 2385.0, 2400.0, 2480.0, 2520.0],
        "choices": [
            {"id": 0, "text": "A bullish breakout above neckline resistance."},
            {"id": 1, "text": "A sharp drop back to the double bottom support level."},
            {"id": 2, "text": "Sideways consolidation for several weeks."},
            {"id": 3, "text": "A breakdown below the double bottom support level."}
        ],
        "correct_choice_index": 0,
        "explanation_correct": "A double bottom is a classic bullish reversal pattern. Testing neckline resistance with high volume strongly supports a breakout and continuation of the new upward trend.",
        "explanation_incorrect": "While resistance can reject price, the pattern formation combined with strong volume makes a bullish breakout much more probable than a breakdown or sideways movement."
    }
]


if __name__ == "__main__":
    # If run directly as a script, generate a challenge for today
    today = datetime.now(timezone.utc).date()
    # It requires python 3.7+ asyncio.run
    asyncio.run(generate_and_save_challenge(today))
