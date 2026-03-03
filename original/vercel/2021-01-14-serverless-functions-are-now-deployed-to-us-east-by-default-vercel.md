---
title: "Serverless Functions are now deployed to US East by default - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/serverless-functions-are-now-deployed-to-us-east-by-default"
date: "2021-01-14"
scraped_at: "2026-03-02T10:05:59.092481143+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jan 14, 2021

![](images/serverless-functions-are-now-deployed-to-us-east-by-default-vercel/img_001.jpg)

Many Serverless Functions communicate with third-party services. Because most of these services are available in the US East region, deploying Serverless Functions to US West leads to slower response times.

For that reason (and to decrease the latency for requests arriving from Europe), newly created projectswill default to the **US East** region (Washington, D.C., USA) instead of **US West** (San Francisco, USA) when deploying Serverless Functions.

Existing projects will be unaffected, but can be switched to the new default from the new "Serverless Functions" page in the Project Settings.

Check out [the documentation](https://vercel.com/docs/serverless-functions/regions) as well.