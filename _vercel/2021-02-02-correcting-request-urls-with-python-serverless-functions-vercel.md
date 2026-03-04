---
title: "Correcting Request URLs with Python Serverless Functions - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/correcting-request-urls-with-python-serverless-functions"
date: "2021-02-02"
scraped_at: "2026-03-02T10:06:02.412322793+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Feb 2, 2021

2021 年 2 月 2 日

![](images/correcting-request-urls-with-python-serverless-functions-vercel/img_001.jpg)

At the moment, the URLs of incoming requests to Python Serverless Functions deployed on Vercel are decoded automatically.

目前，部署在 Vercel 上的 Python 无服务器函数（Serverless Functions）会自动对入站请求的 URL 进行解码。

Because this behavior is not consistent with a "standalone" Python server, Vercel will stop decoding them for newly created Serverless Functions starting **March 2nd, 2021**. Existing Deployments will not be affected.

由于该行为与“独立运行”的 Python 服务器不一致，Vercel 将自 **2021 年 3 月 2 日起**，停止对新创建的无服务器函数执行此项自动解码。已有的部署不受影响。

As an example, take a look at the Python Serverless Function code shown above and imagine that the URL of the incoming request ends in `/hi%21`:

举个例子，请查看上方所示的 Python 无服务器函数代码，并假设入站请求的 URL 以 `/hi%21` 结尾：

- With the incorrect behavior, `self.path` will be set to `/hi!`.

- 在当前有误的行为下，`self.path` 将被设为 `/hi!`。

- With the updated correct behavior, `self.path` will be set to `/hi%21`, which matches the behavior of the built-in `HTTPServer` class in Python.

- 在更新后的正确行为下，`self.path` 将被设为 `/hi%21`，这与 Python 内置 `HTTPServer` 类的行为一致。

To try out this change, define a `FORCE_RUNTIME_TAG` Environment Variable for your project, set it to `canary` and create a new Deployment.

如需试用此项变更，请为您的项目定义一个名为 `FORCE_RUNTIME_TAG` 的环境变量，将其值设为 `canary`，然后创建一次新的部署。