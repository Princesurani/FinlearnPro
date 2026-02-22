from fastapi import APIRouter, WebSocket, WebSocketDisconnect
import json
import asyncio
from typing import Set

router = APIRouter()

class ConnectionManager:
    def __init__(self):
        self.active_connections: Set[WebSocket] = set()

    async def connect(self, websocket: WebSocket):
        await websocket.accept()
        self.active_connections.add(websocket)

    def disconnect(self, websocket: WebSocket):
        self.active_connections.discard(websocket)

    async def broadcast(self, message: str):
        for connection in list(self.active_connections):
            try:
                await connection.send_text(message)
            except Exception:
                self.disconnect(connection)

manager = ConnectionManager()

import os
import redis.asyncio as redis

# Using the redis interface
REDIS_URL = os.getenv("REDIS_URL", "redis://localhost:6379/0")

@router.websocket("/stream")
async def websocket_endpoint(websocket: WebSocket):
    """
    WebSocket endpoint for real-time market data streaming.
    Clients connect and receive the global feed from Redis.
    """
    await manager.connect(websocket)
    redis_client = await redis.from_url(REDIS_URL)
    pubsub = redis_client.pubsub()
    
    # Subscribe to the global market ticks channel
    await pubsub.subscribe("market:ticks:global")
    
    try:
        # Acknowledge connection
        await websocket.send_json({"type": "system", "message": "Connected to Market Stream"})
        
        # Async generator to read messages from redis pubsub and forward them
        async def redis_listener():
            async for message in pubsub.listen():
                if message['type'] == 'message':
                    data = message['data'].decode('utf-8')
                    try:
                        await websocket.send_text(data)
                    except Exception:
                        break

        # Start the listener task
        listener_task = asyncio.create_task(redis_listener())
        
        while True:
            # Wait for client messages (e.g., {"action": "subscribe", "symbol": "AAPL"})
            # To handle unsubs or heartbeat
            data = await websocket.receive_text()
            pass
                
    except WebSocketDisconnect:
        manager.disconnect(websocket)
        listener_task.cancel()
        await pubsub.unsubscribe("market:ticks:global")
        await redis_client.close()
