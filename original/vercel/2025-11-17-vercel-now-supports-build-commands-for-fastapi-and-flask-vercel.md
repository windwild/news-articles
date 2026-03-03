---
title: "Vercel now supports Build Commands for FastAPI and Flask - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-now-supports-build-commands-for-fastapi-and-flask"
date: "2025-11-17"
scraped_at: "2026-03-02T09:25:30.139333748+00:00"
language: "en"
translated: false
description: "In addition to defining a Build Command in the project Settings dashboard, you can also define a build script in [tool.vercel.scripts] inside your pyproject.toml to run after dependencies are installe..."
---




Nov 17, 2025

You can now can easily deploy FastAPI and Flask with custom Build Commands, expanding support for Python projects on Vercel.

In addition to defining a [Build Command](https://vercel.com/docs/builds/configure-a-build#build-command) in the project Settings dashboard, you can also define a `build` script in`[tool.vercel.scripts]`inside your `pyproject.toml`.

This script will run after dependencies are installed, but before your application is deployed.

pyproject.toml

```text
1[tool.vercel.scripts]

build = "python build.py"
```

Learn more about the [Build Command](https://vercel.com/docs/frameworks/backend/fastapi#build-command) for Python projects.