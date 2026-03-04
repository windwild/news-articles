---
title: "Clients blocked by persistent actions now receive a 403 Forbidden response - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/clients-blocked-by-persistent-actions-now-receive-a-403-forbidden-response"
date: "2025-01-28"
scraped_at: "2026-03-02T09:37:18.111852234+00:00"
language: "en-zh"
translated: true
description: "The Vercel Web Application Firewall blocks clients by persistent actions with a 403 Forbidden response "
---

render_with_liquid: false
Jan 28, 2025

2025 年 1 月 28 日

Starting today, when the [Vercel Web Application Firewall (WAF)](https://vercel.com/docs/security/vercel-waf) blocks a client with a persistent action, it will respond with a 403 Forbidden status instead of failing silently. This change now makes it clear that the connection is being intentionally denied.

从今天起，当 [Vercel Web 应用防火墙（WAF）](https://vercel.com/docs/security/vercel-waf) 使用“持久化操作”（persistent action）拦截某个客户端时，将返回 `403 Forbidden` 状态码，而非静默失败。这一变更使连接被主动拒绝的状态更加明确。

Persistent actions in the WAF help reduce edge request load and stop malicious traffic earlier, cutting down unnecessary processing for your applications.

WAF 中的“持久化操作”有助于降低边缘节点的请求负载，并更早地拦截恶意流量，从而减少您的应用所承受的不必要处理开销。

Learn more about [persistent actions](https://vercel.com/docs/security/vercel-waf/custom-rules#persistent-actions).

了解更多关于 [持久化操作](https://vercel.com/docs/security/vercel-waf/custom-rules#persistent-actions) 的信息。