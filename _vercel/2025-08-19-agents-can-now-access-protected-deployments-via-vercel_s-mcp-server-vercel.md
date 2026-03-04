---
title: "Agents can now access protected deployments via Vercel’s MCP server - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/give-agents-access-to-protected-deployments-via-vercels-mcp-server"
date: "2025-08-19"
scraped_at: "2026-03-02T09:29:35.986001694+00:00"
language: "en-zh"
translated: true
description: "Vercel's MCP server now lets agents access deployments behind authentication, enabling them to act on your behalf."
---

render_with_liquid: false
Aug 19, 2025

2025 年 8 月 19 日

Vercel 的 MCP 服务器现已上线两款新工具：

- **`get_access_to_vercel_url`** 生成一个[可共享的 URL](https://vercel.com/docs/deployment-protection/methods-to-bypass-deployment-protection/sharable-links)，使代理工具（例如 web fetch 或 Playwright）能够访问受 [Vercel 身份验证](https://vercel.com/docs/deployment-protection/methods-to-protect-deployments/vercel-authentication) 保护的部署。该 URL 为临时性链接，无需登录凭据即可授予访问权限。

- **`web_fetch_vercel_url`** 允许代理直接从受 [Vercel 身份验证](https://vercel.com/docs/deployment-protection/methods-to-protect-deployments) 保护的部署中获取内容，即使常规 fetch 请求会返回 `401 Unauthorized`（未授权）或 `403 Forbidden`（禁止访问）状态码。

立即开始使用 [Vercel MCP 服务器](https://vercel.com/docs/mcp/vercel-mcp)。

[**连接至 Vercel MCP**\\
\\
阅读文档，深入了解该服务器\\
\\
快速上手](https://vercel.com/docs/mcp/vercel-mcp#setup)