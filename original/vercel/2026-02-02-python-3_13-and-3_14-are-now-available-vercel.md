---
title: "Python 3.13 and 3.14 are now available  - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/python-3-13-and-3-14-are-now-available"
date: "2026-02-02"
scraped_at: "2026-03-02T09:21:39.747944218+00:00"
language: "en"
translated: false
description: "Python versions 3.13 and 3.14 are now available for use in Vercel Builds and Vercel Functions.  Python 3.14 is the new default version for new projects and deployments."
---




Feb 2, 2026

![](images/python-3_13-and-3_14-are-now-available-vercel/img_001.jpg)![](images/python-3_13-and-3_14-are-now-available-vercel/img_002.jpg)

Builds and Functions now support Python 3.13 and Python 3.14 alongside the previously supported Python 3.12. Projects without a specified Python version continue using Python 3.12 by default.

The default will switch to Python 3.14 in the coming months. To continue using Python 3.12, specify an upper bound in your project manifest (`pyproject.toml` or `Pipfile`) as shown in the examples below.

pyproject.toml

```text
1[project]

2...

requires-python = "~=3.12.0"
```

Specifying Python version in pyproject.toml

Pipfile

```text
1[requires]

2...

python_version = "3.12"
```

Specifying Python version in Pipfile

See the [Python documentation](https://vercel.com/docs/functions/runtimes/python) to learn more about Python support on Vercel.