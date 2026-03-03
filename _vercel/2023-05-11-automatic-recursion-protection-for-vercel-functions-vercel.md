---
title: "Automatic recursion protection for Vercel Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/automatic-recursion-protection-for-vercel-serverless-functions"
date: "2023-05-11"
scraped_at: "2026-03-02T09:52:36.019491817+00:00"
language: "en-zh"
translated: true
description: "Vercel now has automatic recursion protection for Vercel Functions. This provides safety against your code inadvertently triggering itself repeatedly, incurring unintentional usage."
---

May 11, 2023

2023 年 5 月 11 日

![](images/automatic-recursion-protection-for-vercel-functions-vercel/img_001.jpg)![](images/automatic-recursion-protection-for-vercel-functions-vercel/img_002.jpg)

Vercel now has automatic recursion protection for Vercel Functions.

Vercel 现已为 Vercel Functions 提供自动递归防护功能。

This provides safety against your code inadvertently triggering itself repeatedly, incurring unintentional usage. Recursion protection supports using the `http` module or `fetch` in the Node.js runtime for Serverless Functions, both for user-defined code and dependencies. Requests using the bare `Socket` constructor are not protected against recursion.

该功能可防止您的代码意外地反复触发自身，从而避免产生非预期的资源用量。递归防护支持在 Serverless Functions 的 Node.js 运行时中，对用户自定义代码及第三方依赖所发起的、基于 `http` 模块或 `fetch` API 的请求进行防护；但直接使用原生 `Socket` 构造函数发起的请求不在此防护范围内。

Recursion protection is available free on all plans. It does not require any code changes in your application, but does require a new deployment. Outbound requests now include the `x-vercel-id` header of the request that originated the new fetch.

递归防护功能在所有套餐中均免费提供。您无需修改应用代码，但需重新部署一次。此后，所有出站请求将自动携带 `x-vercel-id` 请求头，其值为触发本次 `fetch` 调用的原始请求的 ID。

We’re continuing to invest in platform improvements to help developers [understand and monitor usage](https://vercel.com/changelog/usage-notification-settings-is-now-generally-available) and avoid unintended usage on the Vercel platform.

我们正持续投入平台优化，助力开发者更好地[理解与监控资源用量](https://vercel.com/changelog/usage-notification-settings-is-now-generally-available)，从而避免在 Vercel 平台上产生非预期的资源消耗。