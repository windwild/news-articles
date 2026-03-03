---
title: "Vercel WAF rate limiting now generally available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-waf-rate-limiting-now-generally-available"
date: "2024-10-02"
scraped_at: "2026-03-02T09:40:49.195709975+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Oct 2, 2024

2024 年 10 月 2 日

![](images/vercel-waf-rate-limiting-now-generally-available-vercel/img_001.jpg)![](images/vercel-waf-rate-limiting-now-generally-available-vercel/img_002.jpg)

Vercel Web Application Firewall (WAF) rate limiting is now generally available, giving you precise control over request volumes to your applications.

Vercel Web 应用防火墙（WAF）的请求速率限制功能现已正式全面开放，让您能够精准控制发送至您应用的请求量。

With over 15 parameters, including target path, headers, method, and cookies, you can define the business logic for rate limiting. Then, apply a rate-limiting algorithm tied to IP, JA4 digest, headers, or user agent to control the frequency of matching traffic within your set limits.

借助超过 15 种可配置参数（包括目标路径、请求头、HTTP 方法和 Cookie），您可以灵活定义速率限制的业务逻辑；随后，可选择基于 IP 地址、JA4 摘要、请求头或用户代理（User Agent）的速率限制算法，在设定阈值内管控匹配流量的访问频次。

When paired with [persistent actions](https://vercel.com/changelog/vercel-waf-now-supports-persistent-actions), rate limiting can help reduce resource abuse across Edge Requests, Middleware, Data Transfer, and Function execution.

当与 [持久化操作（Persistent Actions）](https://vercel.com/changelog/vercel-waf-now-supports-persistent-actions) 配合使用时，速率限制可有效缓解边缘请求（Edge Requests）、中间件（Middleware）、数据传输（Data Transfer）及函数执行（Function execution）等环节中的资源滥用问题。

Rate limiting with a fixed-window algorithm is available today for Pro customers, with an additional token-bucket algorithm available to Enterprise customers. [Pricing for rate limiting](https://vercel.com/docs/security/vercel-waf/rate-limiting#pricing) is regional starting at $.50 per 1 million allowed requests.

目前，固定窗口（Fixed-Window）算法的速率限制功能已面向 Pro 计划用户开放；企业版（Enterprise）客户还可额外使用令牌桶（Token-Bucket）算法。[速率限制定价](https://vercel.com/docs/security/vercel-waf/rate-limiting#pricing) 按地域计费，起价为每百万次允许请求 $0.50。

Add rate limiting [using a template](https://vercel.com/templates/vercel-firewall/rate-limit-api-requests-firewall-rule) or read the [rate limiting documentation](https://vercel.com/docs/security/vercel-waf/rate-limiting) to learn more.

您可通过 [模板](https://vercel.com/templates/vercel-firewall/rate-limit-api-requests-firewall-rule) 快速添加速率限制规则，或查阅 [速率限制文档](https://vercel.com/docs/security/vercel-waf/rate-limiting) 了解更多信息。