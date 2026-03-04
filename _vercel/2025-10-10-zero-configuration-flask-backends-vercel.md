---
title: "Zero-configuration Flask backends - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/zero-configuration-flask-backends"
date: "2025-10-10"
scraped_at: "2026-03-02T09:27:18.155326703+00:00"
language: "en-zh"
translated: true
description: "Flask, one of the most popular Python web application frameworks, can now be deployed instantly at Vercel with no configuration changes needed."
---
{% raw %}

Oct 10, 2025

2025年10月10日

![](images/zero-configuration-flask-backends-vercel/img_001.jpg)![](images/zero-configuration-flask-backends-vercel/img_002.jpg)

[Flask](https://flask.palletsprojects.com/) 是最流行的 [Python](https://vercel.com/docs/functions/runtimes/python) Web 应用框架之一，现在可无需任何配置更改，直接一键部署至 Vercel。

[Flask](https://flask.palletsprojects.com/) 是最流行的 [Python](https://vercel.com/docs/functions/runtimes/python) Web 应用框架之一，现在可无需任何配置更改，直接一键部署至 Vercel。

app.py

```python
from flask import Flask



app = Flask(__name__)



5@app.route("/")

def hello_world():

7    return "<p>Hello, World!</p>"
```

A "Hello World" Flask app on Vercel

在 Vercel 上运行的 “Hello World” Flask 应用

Vercel's [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure) now recognizes and deeply understands Flask applications. This update removes the need for redirects in `vercel.json` or using the `/api` folder.

Vercel 的 [框架定义基础设施（Framework-Defined Infrastructure）](https://vercel.com/blog/framework-defined-infrastructure) 现已原生识别并深度理解 Flask 应用。此次更新消除了在 `vercel.json` 中配置重定向或强制将代码放入 `/api` 目录的需要。

Backends on Vercel use [Fluid compute](https://vercel.com/fluid) with [Active CPU pricing](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute) by default. This means your Flask app will automatically scale up and down based on traffic, and you only pay for time where your code is actively using CPU.

Vercel 上的后端默认采用 [Fluid Compute](https://vercel.com/fluid) 与 [Active CPU 计费模式](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute)。这意味着您的 Flask 应用将根据流量自动扩缩容，且您仅需为代码实际占用 CPU 的时间付费。

[Deploy Flask on Vercel](https://vercel.com/templates/python/flask-python-boilerplate) or visit the [Flask on Vercel documentation](https://vercel.com/docs/frameworks/backend/flask).

[在 Vercel 上部署 Flask](https://vercel.com/templates/python/flask-python-boilerplate)，或查阅 [Vercel 上的 Flask 文档](https://vercel.com/docs/frameworks/backend/flask)。
{% endraw %}
