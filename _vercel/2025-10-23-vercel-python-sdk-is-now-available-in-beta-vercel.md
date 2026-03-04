---
title: "Vercel Python SDK is now available in beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-python-sdk-in-beta"
date: "2025-10-23"
scraped_at: "2026-03-02T09:26:45.901164305+00:00"
language: "en-zh"
translated: true
description: "Vercel now has a native Python library hosted on PyPI to simplify tasks such as executing code on Vercel Sandboxes, transferring objects to Vercel Blob, working with the Runtime Cache and retrieving p..."
---
{% raw %}

Oct 23, 2025

2025 年 10 月 23 日

The Vercel Python SDK is now available in beta, bringing first-class Python support for many Vercel features such as [Vercel Sandbox](https://vercel.com/docs/vercel-sandbox), [Blob](https://vercel.com/docs/vercel-blob), and the [Runtime Cache API](https://vercel.com/docs/functions/functions-api-reference/vercel-sdk-python).

Vercel Python SDK 现已进入 Beta 版本，为多项 Vercel 功能（例如 [Vercel Sandbox](https://vercel.com/docs/vercel-sandbox)、[Blob](https://vercel.com/docs/vercel-blob) 和 [Runtime Cache API](https://vercel.com/docs/functions/functions-api-reference/vercel-sdk-python)）提供一流的 Python 支持。

To get started, install the vercel package with `pip install vercel.`

入门之前，请运行 `pip install vercel` 安装 vercel 包。

Vercel Python SDK lets you directly interact with Vercel primitives via python code like:

Vercel Python SDK 允许你通过 Python 代码直接与 Vercel 原语交互，例如：

**Run untrusted code in isolated, ephemeral environments using Vercel Sandbox:**

**使用 Vercel Sandbox，在隔离的、临时环境中运行不受信任的代码：**

```python
from vercel.sandbox import Sandbox



with Sandbox.create(runtime="python3.13") as sandbox:

4    command = sandbox.run_command("python", ["-c", "print('hello world')"])

5    print(command.stdout())
```

**Interact with Vercel’s Blob storage API:**

**与 Vercel 的 Blob 存储 API 交互：**

```python
from vercel import blob



uploaded_file = blob.upload_file(

4    local_path="hello-world.txt",

5    path="uploaded-hello-world.txt",

6    access="public",

7)
```

```python
from vercel import blob



uploaded_file = blob.upload_file(

4    local_path="hello-world.txt",

5    path="uploaded-hello-world.txt",

6    access="public",

7)
```

And **store and retrieve data** across [Functions](https://vercel.com/docs/functions), [Routing Middleware](https://vercel.com/docs/routing-middleware), and [Builds](https://vercel.com/docs/builds) within the same region using the Runtime Cache API:

并且使用 Runtime Cache API，在同一地域内跨 [Functions](https://vercel.com/docs/functions)、[Routing Middleware](https://vercel.com/docs/routing-middleware) 和 [Builds](https://vercel.com/docs/builds) **存储与检索数据**：

```python
from vercel.cache import RuntimeCache

from vercel.cache import RuntimeCache

import requests

import requests

from fastapi import FastAPI

from fastapi import FastAPI

app = FastAPI()

app = FastAPI()

cache = RuntimeCache()

cache = RuntimeCache()

@app.get("/blog")

@app.get("/blog")

def blog():

def blog():

    key = "blog"

    key = "blog"
```

11    val = cache.get(key)

11    val = cache.get(key)

12    if val:

12    如果 val 为真：

13        return val

13        返回 val



15    res = requests.get("https://api.vercel.app/blog")

15    res = requests.get("https://api.vercel.app/blog")

16    origin_value = res.json()

16    origin_value = res.json()

17    cache.set(key, origin_value, {"ttl": 3600, "tags": ["blogs"]})

17    cache.set(key, origin_value, {"ttl": 3600, "tags": ["blogs"]})



19    return origin_value

19    返回 origin_value
```

Get started with `pip install vercel.`

使用 `pip install vercel` 快速开始。
{% endraw %}
