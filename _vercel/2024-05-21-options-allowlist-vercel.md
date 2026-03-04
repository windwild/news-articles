---
render_with_liquid: false
title: "OPTIONS Allowlist - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/options-allowlist"
date: "2024-05-21"
scraped_at: "2026-03-02T09:45:08.301913504+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

May 21, 2024

2024 年 5 月 21 日

![](images/options-allowlist-vercel/img_001.jpg)![](images/options-allowlist-vercel/img_002.jpg)

The OPTIONS Allowlist improves the security of deployments on Vercel by limiting CORS preflight `OPTIONS` requests to specified paths.

“OPTIONS 白名单”功能通过将跨域资源共享（CORS）预检 `OPTIONS` 请求限制在指定路径上，提升了在 Vercel 上部署应用的安全性。

Before the OPTIONS Allowlist, all `OPTIONS` requests to deployments bypassed Deployment Protection in compliance with [CORS specifications](https://developer.mozilla.org/docs/Web/HTTP/CORS).

在引入“OPTIONS 白名单”之前，所有发往部署实例的 `OPTIONS` 请求均会绕过部署保护机制，以符合 [CORS 规范](https://developer.mozilla.org/docs/Web/HTTP/CORS)。

The new OPTIONS Allowlist feature is available on all plans.

该全新的“OPTIONS 白名单”功能面向所有订阅计划开放。

Learn more about the [OPTIONS Allowlist](https://vercel.com/docs/security/deployment-protection/methods-to-bypass-deployment-protection/options-allowlist).

了解更多关于 [OPTIONS 白名单](https://vercel.com/docs/security/deployment-protection/methods-to-bypass-deployment-protection/options-allowlist) 的信息。