---
title: "Python package manager uv is now available for builds with zero configuration - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/python-package-manager-uv-is-now-available-for-builds-with-zero"
date: "2025-10-03"
scraped_at: "2026-03-02T09:27:28.413966317+00:00"
language: "en"
translated: false
description: "Vercel now uses uv, a fast Python package manager written in Rust, as the default package manager during the installation step for all Python builds."
---




Oct 3, 2025

![](images/python-package-manager-uv-is-now-available-for-builds-with-zero-configuration-ve/img_001.jpg)![](images/python-package-manager-uv-is-now-available-for-builds-with-zero-configuration-ve/img_002.jpg)

Vercel now uses [`uv`](https://docs.astral.sh/uv/), a fast Python package manager written in Rust, as the default package manager during the installation step for all Python builds.

This change makes builds **30-65%** faster and adds support for more dependency formats. In addition to `requirements.txt` or `Pipfile`, projects can now declare dependencies with a `uv.lock` or `pyproject.toml` file.

Learn more about the [Python runtime on Vercel](https://vercel.com/docs/functions/runtimes/python).