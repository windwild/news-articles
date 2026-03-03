---
title: "Domains can now be redirected with a custom status code - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/domains-can-now-be-redirected-with-a-custom-status-code"
date: "2021-02-18"
scraped_at: "2026-03-02T10:05:25.967772405+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Feb 18, 2021

2021 年 2 月 18 日

![](images/domains-can-now-be-redirected-with-a-custom-status-code-vercel/img_001.jpg)

You can now select a temporary or permanent **status code** for [Domain Redirects](https://vercel.com/blog/redirecting-domains).

您现在可以为[域名重定向（Domain Redirects）](https://vercel.com/blog/redirecting-domains)选择临时或永久的**状态码（status code）**。

这些[状态码（status codes）](https://developer.mozilla.org/en-US/docs/Web/HTTP/Redirections)之间存在一些细微差别：

- **307 Temporary Redirect（临时重定向）：** 不会被客户端缓存；请求方法（method）和请求体（body）均保持不变。

- **302 Found（已找到）：** 不会被客户端缓存；请求方法可能被更改为 GET，也可能保持不变。

- **308 Permanent Redirect（永久重定向）：** 会被客户端缓存；请求方法和请求体均保持不变。

- **301 Moved Permanently（永久移动）：** 会被客户端缓存；请求方法可能被更改为 GET，也可能保持不变。

我们建议使用状态码 307 或 308，以避免对非 GET 方法重定向时产生的歧义——当您的应用需要重定向公开 API 时，这一点尤为关键。

也欢迎查阅[相关文档](https://vercel.com/docs/custom-domains#redirecting-domains)。