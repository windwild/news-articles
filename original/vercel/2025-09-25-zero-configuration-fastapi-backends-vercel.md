---
title: "Zero-configuration FastAPI backends - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/zero-config-fastapi-backends"
date: "2025-09-25"
scraped_at: "2026-03-02T09:27:46.295220655+00:00"
language: "en"
translated: false
description: "FastAPI, a modern, high-performance, web framework for building APIs with Python based on standard Python type hints, is now supported with zero-configuration."
---




Sep 25, 2025

![](images/zero-configuration-fastapi-backends-vercel/img_001.jpg)![](images/zero-configuration-fastapi-backends-vercel/img_002.jpg)

[FastAPI](https://fastapi.tiangolo.com/), a modern, high-performance, web framework for building APIs with [Python](https://vercel.com/docs/functions/runtimes/python), is now supported with zero-configuration.

app.py

```python
from fastapi import FastAPI



app = FastAPI()



5@app.get("/")

def read_root():

7    return {"Hello": "World"}
```

A "Hello World" FastAPI app on Vercel

Vercel's [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure) now recognizes and deeply understands FastAPI applications. This update removes the need for redirects in `vercel.json` or using the `/api` folder.

Backends on Vercel use [Fluid compute](https://vercel.com/fluid) with [Active CPU pricing](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute) by default. This means your FastAPI app will automatically scale up and down based on traffic, and you only pay for what you use.

[Deploy FastAPI on Vercel](https://vercel.com/templates/python/fastapi-python-boilerplate) or visit the [FastAPI on Vercel documentation](https://vercel.com/docs/frameworks/backend/fastapi).