---
render_with_liquid: false
title: "Python 3.9 is now available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/python-3-9-is-now-available"
date: "2021-11-23"
scraped_at: "2026-03-02T10:04:10.588109718+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Nov 23, 2021

2021 年 11 月 23 日

![](images/python-3_9-is-now-available-vercel/img_001.jpg)

自即日起，使用 Python Serverless Functions 的新部署将默认采用 Python 版本 [3.9](https://www.python.org/dev/peps/pep-0596/)，而旧版 [3.6](https://www.python.org/dev/peps/pep-0494/) 将逐步停止支持。

如您仍需继续使用 Python 3.6 进行部署，请确保您的 `Pipfile` 及对应的 `Pipfile.lock` 文件中 `python_version` 字段**精确设置为 `3.6`**。

Python 3.6 将于 **2021 年 12 月正式终止支持（End of Life）**（参见 [PEP 0494](https://www.python.org/dev/peps/pep-0494/)）。在完全移除对该版本的支持之前，我们将另行发布公告，明确标注其最终停用日期。

您也可查阅相关[文档](https://vercel.com/docs/runtimes#official-runtimes/python/python-version)以获取更多信息。