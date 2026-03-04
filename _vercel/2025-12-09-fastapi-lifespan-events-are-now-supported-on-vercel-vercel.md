---
title: "FastAPI Lifespan Events are now supported on Vercel - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/fastapi-lifespan-events-are-now-supported-on-vercel"
date: "2025-12-09"
scraped_at: "2026-03-02T09:24:28.976228552+00:00"
language: "en-zh"
translated: true
description: "Vercel now supports lifespan events on FastAPI apps, allowing you to define startup and shutdown logic such as setting up and shutting down database connections or flushing external logs."
---

render_with_liquid: false
Dec 9, 2025

2025 年 12 月 9 日

Vercel now supports [lifespan events](https://fastapi.tiangolo.com/advanced/events/) for FastAPI apps. This allows you to define logic that can execute on startup and graceful shutdown—such as managing database connections or flushing external logs.

Vercel 现已为 FastAPI 应用支持 [生命周期事件（lifespan events）](https://fastapi.tiangolo.com/advanced/events/)。这使您能够定义在应用启动和优雅关闭时执行的逻辑——例如管理数据库连接或刷新外部日志。

```python
from contextlib import asynccontextmanager

from fastapi import FastAPI



4@asynccontextmanager

async def lifespan(app: FastAPI):

6    # Startup logic

7    print("Starting up...")

8    await startup_tasks()
```

9    yield

9    生成（yield）

10    # Shutdown logic

10    # 关机逻辑（关闭时执行的逻辑）

11    await cleanup_tasks()

11    await cleanup_tasks()

```
app = FastAPI(lifespan=lifespan)
```

```
app = FastAPI(lifespan=lifespan)
```

Deploy FastAPI on Vercel or visit the [FastAPI on Vercel documentation](https://vercel.com/docs/frameworks/backend/fastapi).

在 Vercel 上部署 FastAPI，或访问 [FastAPI on Vercel 文档](https://vercel.com/docs/frameworks/backend/fastapi)。