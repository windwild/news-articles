---
render_with_liquid: false
title: "Python package manager uv is now available for builds with zero configuration - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/python-package-manager-uv-is-now-available-for-builds-with-zero"
date: "2025-10-03"
scraped_at: "2026-03-02T09:27:28.413966317+00:00"
language: "en-zh"
translated: true
description: "Vercel now uses uv, a fast Python package manager written in Rust, as the default package manager during the installation step for all Python builds."
---
render_with_liquid: false
render_with_liquid: false

Oct 3, 2025

2025 年 10 月 3 日

![](images/python-package-manager-uv-is-now-available-for-builds-with-zero-configuration-ve/img_001.jpg)![](images/python-package-manager-uv-is-now-available-for-builds-with-zero-configuration-ve/img_002.jpg)

Vercel 现在在所有 Python 构建的安装阶段默认使用 [`uv`](https://docs.astral.sh/uv/) —— 一款用 Rust 编写的高性能 Python 包管理器。

这一变更使构建速度提升 **30–65%**，并增强了对更多依赖项格式的支持。除原有的 `requirements.txt` 或 `Pipfile` 外，项目现在还可通过 `uv.lock` 或 `pyproject.toml` 文件声明依赖项。

了解更多关于 [Vercel 上的 Python 运行时](https://vercel.com/docs/functions/runtimes/python)。