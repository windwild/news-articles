---
title: "Python 3.13 and 3.14 are now available  - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/python-3-13-and-3-14-are-now-available"
date: "2026-02-02"
scraped_at: "2026-03-02T09:21:39.747944218+00:00"
language: "en-zh"
translated: true
description: "Python versions 3.13 and 3.14 are now available for use in Vercel Builds and Vercel Functions.  Python 3.14 is the new default version for new projects and deployments."
---
&#123;% raw %}

Feb 2, 2026

2026年2月2日

![](images/python-3_13-and-3_14-are-now-available-vercel/img_001.jpg)![](images/python-3_13-and-3_14-are-now-available-vercel/img_002.jpg)

Builds and Functions now support Python 3.13 and Python 3.14 alongside the previously supported Python 3.12. Projects without a specified Python version continue using Python 3.12 by default.

构建（Builds）与函数（Functions）现已支持 Python 3.13 和 Python 3.14，同时继续支持此前已支持的 Python 3.12。未明确指定 Python 版本的项目默认仍使用 Python 3.12。

The default will switch to Python 3.14 in the coming months. To continue using Python 3.12, specify an upper bound in your project manifest (`pyproject.toml` or `Pipfile`) as shown in the examples below.

未来几个月内，默认 Python 版本将切换为 Python 3.14。如需继续使用 Python 3.12，请在项目清单文件（`pyproject.toml` 或 `Pipfile`）中指定版本上限，具体示例如下所示。

pyproject.toml

`pyproject.toml`

```text
1[project]

2...

requires-python = "~=3.12.0"
```

Specifying Python version in pyproject.toml

在 `pyproject.toml` 中指定 Python 版本

Pipfile

`Pipfile`

```text
1[requires]

2...

python_version = "3.12"
```

在 Pipfile 中指定 Python 版本

请参阅 [Python 文档](https://vercel.com/docs/functions/runtimes/python)，了解 Vercel 上 Python 支持的更多信息。
&#123;% endraw %}
