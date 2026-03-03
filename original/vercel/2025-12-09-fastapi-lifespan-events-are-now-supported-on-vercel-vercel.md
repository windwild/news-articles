---
title: "FastAPI Lifespan Events are now supported on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/fastapi-lifespan-events-are-now-supported-on-vercel"
date: "2025-12-09"
scraped_at: "2026-03-02T09:24:28.976228552+00:00"
language: "en"
translated: false
description: "Vercel now supports lifespan events on FastAPI apps, allowing you to define startup and shutdown logic such as setting up and shutting down database connections or flushing external logs."
---




Dec 9, 2025

Vercel now supports [lifespan events](https://fastapi.tiangolo.com/advanced/events/) for FastAPI apps. This allows you to define logic that can execute on startup and graceful shutdown—such as managing database connections or flushing external logs.

```python
from contextlib import asynccontextmanager

from fastapi import FastAPI



4@asynccontextmanager

async def lifespan(app: FastAPI):

6    # Startup logic

7    print("Starting up...")

8    await startup_tasks()

9    yield

10    # Shutdown logic

11    await cleanup_tasks()



app = FastAPI(lifespan=lifespan)
```

Deploy FastAPI on Vercel or visit the [FastAPI on Vercel documentation](https://vercel.com/docs/frameworks/backend/fastapi).