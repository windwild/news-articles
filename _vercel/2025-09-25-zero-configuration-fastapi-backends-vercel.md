---
render_with_liquid: false
title: "Zero-configuration FastAPI backends - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/zero-config-fastapi-backends"
date: "2025-09-25"
scraped_at: "2026-03-02T09:27:46.295220655+00:00"
language: "en-zh"
translated: true
description: "FastAPI, a modern, high-performance, web framework for building APIs with Python based on standard Python type hints, is now supported with zero-configuration."
---
render_with_liquid: false
render_with_liquid: false

Sep 25, 2025

2025 年 9 月 25 日

![](images/zero-configuration-fastapi-backends-vercel/img_001.jpg)![](images/zero-configuration-fastapi-backends-vercel/img_002.jpg)

[FastAPI](https://fastapi.tiangolo.com/) 是一个现代、高性能的 Web 框架，用于基于 [Python](https://vercel.com/docs/functions/runtimes/python) 构建 API，现已支持零配置部署。

[FastAPI](https://fastapi.tiangolo.com/) 是一个现代、高性能的 Web 框架，用于基于 [Python](https://vercel.com/docs/functions/runtimes/python) 构建 API，现已支持零配置部署。

app.py

```python
from fastapi import FastAPI



app = FastAPI()



5@app.get("/")

def read_root():

7    return {"Hello": "World"}
```

A "Hello World" FastAPI app on Vercel

在 Vercel 上运行的 “Hello World” FastAPI 应用

Vercel's [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure) now recognizes and deeply understands FastAPI applications. This update removes the need for redirects in `vercel.json` or using the `/api` folder.

Vercel 的 [框架定义基础设施（Framework-Defined Infrastructure）](https://vercel.com/blog/framework-defined-infrastructure) 现已原生识别并深度支持 FastAPI 应用。此更新消除了在 `vercel.json` 中配置重定向或强制将代码放在 `/api` 目录下的必要。

Backends on Vercel use [Fluid compute](https://vercel.com/fluid) with [Active CPU pricing](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute) by default. This means your FastAPI app will automatically scale up and down based on traffic, and you only pay for what you use.

Vercel 上的后端默认采用 [Fluid Compute](https://vercel.com/fluid) 与 [Active CPU 定价模式](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute)。这意味着您的 FastAPI 应用将根据流量自动弹性伸缩，您只需为实际使用的计算资源付费。

[Deploy FastAPI on Vercel](https://vercel.com/templates/python/fastapi-python-boilerplate) or visit the [FastAPI on Vercel documentation](https://vercel.com/docs/frameworks/backend/fastapi).

[在 Vercel 上部署 FastAPI](https://vercel.com/templates/python/fastapi-python-boilerplate)，或查阅 [Vercel 上的 FastAPI 文档](https://vercel.com/docs/frameworks/backend/fastapi)。