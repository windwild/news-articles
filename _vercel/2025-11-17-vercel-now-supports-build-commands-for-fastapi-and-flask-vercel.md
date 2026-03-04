---
render_with_liquid: false
title: "Vercel now supports Build Commands for FastAPI and Flask - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-now-supports-build-commands-for-fastapi-and-flask"
date: "2025-11-17"
scraped_at: "2026-03-02T09:25:30.139333748+00:00"
language: "en-zh"
translated: true
description: "In addition to defining a Build Command in the project Settings dashboard, you can also define a build script in [tool.vercel.scripts] inside your pyproject.toml to run after dependencies are installe..."
---
render_with_liquid: false
render_with_liquid: false

Nov 17, 2025

2025 年 11 月 17 日

You can now can easily deploy FastAPI and Flask with custom Build Commands, expanding support for Python projects on Vercel.

现在，您可借助自定义构建命令（Build Command）轻松部署 FastAPI 和 Flask 应用，从而进一步扩展 Vercel 对 Python 项目的支持。

In addition to defining a [Build Command](https://vercel.com/docs/builds/configure-a-build#build-command) in the project Settings dashboard, you can also define a `build` script in`[tool.vercel.scripts]`inside your `pyproject.toml`.

除了在项目设置（Settings）控制台中配置 [构建命令](https://vercel.com/docs/builds/configure-a-build#build-command) 外，您还可以在 `pyproject.toml` 文件的 `[tool.vercel.scripts]` 段中定义一个 `build` 脚本。

This script will run after dependencies are installed, but before your application is deployed.

该脚本将在依赖项安装完成后、应用部署前执行。

pyproject.toml

`pyproject.toml`

```text
1[tool.vercel.scripts]

build = "python build.py"
```

```text
1[tool.vercel.scripts]

build = "python build.py"
```

Learn more about the [Build Command](https://vercel.com/docs/frameworks/backend/fastapi#build-command) for Python projects.

了解更多关于 Python 项目的 [构建命令](https://vercel.com/docs/frameworks/backend/fastapi#build-command)。