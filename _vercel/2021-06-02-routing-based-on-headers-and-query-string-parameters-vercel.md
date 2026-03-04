---
title: "Routing based on Headers and Query String Parameters - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/routing-based-on-headers-and-query-string-parameters"
date: "2021-06-02"
scraped_at: "2026-03-02T10:04:42.561890942+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Jun 2, 2021

2021 年 6 月 2 日

![](images/routing-based-on-headers-and-query-string-parameters-vercel/img_001.jpg)

At Vercel, our goal is to provide you with the best performance for your web projects, while still allowing for the most flexibility possible when it comes to tailoring responses to users.

在 Vercel，我们的目标是在为您的 Web 项目提供最佳性能的同时，仍尽可能灵活地根据用户需求定制响应。

As part of these efforts, we're now launching a new sub property called `has` for `rewrites`, `redirects`, and `headers` (in `vercel.json` or `next.config.js`), which allows for routing conditionally based on the values of headers, cookies, and query string parameters.

作为这些努力的一部分，我们现正式推出一项新子属性 `has`，适用于 `rewrites`（重写）、`redirects`（重定向）和 `headers`（响应头）配置（位于 `vercel.json` 或 `next.config.js` 文件中），支持基于请求头（headers）、Cookie 和查询字符串参数（query string parameters）的值进行条件化路由。

Combined with features like SSG, ISR, or cached SSR, it can be used in cases like these:

结合静态站点生成（SSG）、增量静态再生（ISR）或缓存的服务器端渲染（cached SSR）等功能，该特性可应用于以下场景：

- Responding differently based on a cookie that was set in the visitor's browser (`Cookie` header) or the type of device the visitor is using (`User-Agent` header).

- 根据访客浏览器中设置的 Cookie（`Cookie` 请求头）或其使用的设备类型（`User-Agent` 请求头）返回不同的响应。

- Responding differently based on the geographical location of the visitor ( [Geo-IP headers](https://vercel.com/changelog/ip-geolocation-for-serverless-functions)).

- 根据访客的地理位置（[Geo-IP 请求头](https://vercel.com/changelog/ip-geolocation-for-serverless-functions)）返回不同的响应。

- Redirecting users directly to their dashboard if they're logged in (`Cookie` header).

- 若用户已登录（通过 `Cookie` 请求头判断），则直接将其重定向至个人仪表板。

- Redirecting old browsers to prevent serving unsupported pages (`User-Agent` header).

- 将旧版浏览器用户重定向，以避免向其提供不支持的页面（通过 `User-Agent` 请求头判断）。

Check out the [documentation](https://vercel.com/docs/configuration#project/redirects) and [Next.js announcement](https://nextjs.org/blog/next-10-2#routing-based-on-headers-and-query-string-parameters) to learn more.

请查阅 [官方文档](https://vercel.com/docs/configuration#project/redirects) 和 [Next.js 公告](https://nextjs.org/blog/next-10-2#routing-based-on-headers-and-query-string-parameters) 了解更多信息。