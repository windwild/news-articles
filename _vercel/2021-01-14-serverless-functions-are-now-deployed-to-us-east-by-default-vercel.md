---
title: "Serverless Functions are now deployed to US East by default - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/serverless-functions-are-now-deployed-to-us-east-by-default"
date: "2021-01-14"
scraped_at: "2026-03-02T10:05:59.092481143+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Jan 14, 2021

2021 年 1 月 14 日

![](images/serverless-functions-are-now-deployed-to-us-east-by-default-vercel/img_001.jpg)

![](images/serverless-functions-are-now-deployed-to-us-east-by-default-vercel/img_001.jpg)

Many Serverless Functions communicate with third-party services. Because most of these services are available in the US East region, deploying Serverless Functions to US West leads to slower response times.

许多无服务器函数（Serverless Functions）需要与第三方服务通信。由于大多数此类服务均部署在美国东部（US East）区域，若将无服务器函数部署至美国西部（US West），则会导致响应时间变长。

For that reason (and to decrease the latency for requests arriving from Europe), newly created projects will default to the **US East** region (Washington, D.C., USA) instead of **US West** (San Francisco, USA) when deploying Serverless Functions.

因此（同时也为了降低来自欧洲的请求的延迟），新创建的项目在部署无服务器函数时，其默认区域将由原先的**美国西部**（美国旧金山）更改为**美国东部**（美国华盛顿特区）。

Existing projects will be unaffected, but can be switched to the new default from the new "Serverless Functions" page in the Project Settings.

现有项目不受影响，但您可在项目设置（Project Settings）中新增的“无服务器函数”（Serverless Functions）页面，手动切换至这一新默认区域。

Check out [the documentation](https://vercel.com/docs/serverless-functions/regions) as well.

也欢迎查阅[相关文档](https://vercel.com/docs/serverless-functions/regions)。