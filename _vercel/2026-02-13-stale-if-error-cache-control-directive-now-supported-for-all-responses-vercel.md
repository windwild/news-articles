---
title: "Stale-if-error cache-control directive now supported for all responses - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/stale-if-error-cache-control-header-is-now-supported"
date: "2026-02-13"
scraped_at: "2026-03-02T09:21:32.768447528+00:00"
language: "en-zh"
translated: true
description: "Stale-if-error directive now supported with Cache-control header for all responses, which allows the cache serves a stale response when an error is encountered instead of returning a hard error to the..."
---

render_with_liquid: false
Feb 13, 2026

2026 年 2 月 13 日

Vercel CDN 现在支持 `stale-if-error` 指令（配合 Cache-Control 响应头使用），可在源站故障期间实现更具韧性的缓存行为。

您现在可以使用 `stale-if-error` 指令，指定当向源站发起的请求失败时，过期的缓存响应仍可继续提供服务的时间长度（单位：秒）。当该指令存在且源站返回错误时，CDN 可选择返回此前已缓存的响应，而非将错误直接返回给客户端。此类过期响应可在发生 500 内部服务器错误、网络连接失败或 DNS 解析错误等情形时被提供。

这使得应用程序在上游服务临时不可用时，仍能保持可用性，并以更优雅的方式响应用户请求。

欲了解更多信息，请参阅 [`stale-if-error` 文档](https://vercel.com/docs/headers/cache-control-headers#stale-if-error)。