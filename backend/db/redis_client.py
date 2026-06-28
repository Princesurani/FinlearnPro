import os
import redis.asyncio as aioredis

REDIS_URL = os.getenv("REDIS_URL", "redis://localhost:6379/0").replace("CERT_NONE", "none")

_redis_client = None

def get_redis_client() -> aioredis.Redis:
    """
    Returns a shared, global Redis connection pool client.
    Does not need to be closed after every request.
    """
    global _redis_client
    if _redis_client is None:
        _redis_client = aioredis.from_url(REDIS_URL)
    return _redis_client
