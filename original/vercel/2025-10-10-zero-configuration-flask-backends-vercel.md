---
title: "Zero-configuration Flask backends - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/zero-configuration-flask-backends"
date: "2025-10-10"
scraped_at: "2026-03-02T09:27:18.155326703+00:00"
language: "en"
translated: false
description: "Flask, one of the most popular Python web application frameworks, can now be deployed instantly at Vercel with no configuration changes needed."
---




Oct 10, 2025

![](images/zero-configuration-flask-backends-vercel/img_001.jpg)![](images/zero-configuration-flask-backends-vercel/img_002.jpg)

[Flask](https://flask.palletsprojects.com/), one of the most popular [Python](https://vercel.com/docs/functions/runtimes/python) web application frameworks, can now be deployed instantly on Vercel with no configuration changes needed.

app.py

```python
from flask import Flask



app = Flask(__name__)



5@app.route("/")

def hello_world():

7    return "<p>Hello, World!</p>"
```

A "Hello World" Flask app on Vercel

Vercel's [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure) now recognizes and deeply understands Flask applications. This update removes the need for redirects in `vercel.json` or using the `/api` folder.

Backends on Vercel use [Fluid compute](https://vercel.com/fluid) with [Active CPU pricing](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute) by default. This means your Flask app will automatically scale up and down based on traffic, and you only pay for time where your code is actively using CPU.

[Deploy Flask on Vercel](https://vercel.com/templates/python/flask-python-boilerplate) or visit the [Flask on Vercel documentation](https://vercel.com/docs/frameworks/backend/flask).