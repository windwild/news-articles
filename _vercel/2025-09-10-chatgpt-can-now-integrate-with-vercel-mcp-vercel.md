---
render_with_liquid: false
title: "ChatGPT can now integrate with Vercel MCP - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/chatgpt-is-now-supported-on-vercel-mcp"
date: "2025-09-10"
scraped_at: "2026-03-02T09:28:57.345375261+00:00"
language: "en-zh"
translated: true
description: "Use Vercel MCP with ChatGPT to explore projects, view logs, share access to protected deployments, and more."
---
render_with_liquid: false
render_with_liquid: false

Sep 10, 2025

2025年9月10日

![](images/chatgpt-can-now-integrate-with-vercel-mcp-vercel/img_001.jpg)![](images/chatgpt-can-now-integrate-with-vercel-mcp-vercel/img_002.jpg)

You can now use ChatGPT with [Vercel MCP,](https://vercel.com/docs/mcp/vercel-mcp) our official Model Context Protocol (MCP) server. For security, Vercel MCP currently supports AI clients that have been reviewed and approved by Vercel.

您现在可以在 ChatGPT 中使用 [Vercel MCP](https://vercel.com/docs/mcp/vercel-mcp) —— 我们官方的模型上下文协议（Model Context Protocol, MCP）服务器。出于安全考虑，Vercel MCP 当前仅支持经 Vercel 审核并批准的 AI 客户端。

Connectors within ChatGPT are available in [beta to Pro and Plus accounts](https://platform.openai.com/docs/guides/developer-mode) on the web.

ChatGPT 中的连接器（Connectors）目前以测试版形式向网页端的 Pro 和 Plus 账户开放：[详情请见](https://platform.openai.com/docs/guides/developer-mode)。

Follow the steps below to set up Vercel as a connector within ChatGPT:

请按以下步骤在 ChatGPT 中将 Vercel 配置为连接器：

- **Enable developer mode:** Go to [Settings → Connectors](https://chatgpt.com/#settings/Connectors) → Advanced → Developer mode.

- **启用开发者模式**：前往 [设置 → 连接器](https://chatgpt.com/#settings/Connectors) → 高级 → 开发者模式。

- **Add Vercel MCP**

- **添加 Vercel MCP**

  - Open [ChatGPT settings](https://chatgpt.com/#settings)

  - 打开 [ChatGPT 设置页面](https://chatgpt.com/#settings)

  - In the Connectors tab, click `Create`

    - 在“连接器”（Connectors）标签页中，点击 `创建`（Create）

    - Name: `Vercel`

    - 名称（Name）：`Vercel`

- MCP server URL: `https://mcp.vercel.com`.

- MCP 服务器地址：`https://mcp.vercel.com`。

- Authentication: `OAuth`

- 认证方式：`OAuth`

- Click `Create`

- 点击 `Create`（创建）

You should now be able to select Vercel as a connector in [Developer Mode](https://platform.openai.com/docs/guides/developer-mode) chats.

现在，您即可在 [开发者模式](https://platform.openai.com/docs/guides/developer-mode) 对话中将 Vercel 选为连接器。

With Vercel MCP you can give agents [access to protected deployments](https://vercel.com/changelog/give-agents-access-to-protected-deployments-via-vercels-mcp-server), [analyze build logs](https://vercel.com/docs/deployments/logs), and more.

借助 Vercel MCP，您可以授予智能体 [访问受保护部署的权限](https://vercel.com/changelog/give-agents-access-to-protected-deployments-via-vercels-mcp-server)、[分析构建日志](https://vercel.com/docs/deployments/logs)，以及更多功能。

Read more about using [AI tools with Vercel MCP](https://vercel.com/docs/mcp/vercel-mcp).

了解更多关于在 Vercel MCP 中使用 [AI 工具](https://vercel.com/docs/mcp/vercel-mcp) 的信息。

[**Connect to Vercel MCP**\\
\\
Read the docs to learn more about the server\\
\\
Get started](https://vercel.com/docs/mcp/vercel-mcp#setup)

[**连接至 Vercel MCP**\\
\\
阅读文档，深入了解该服务器\\
\\
立即开始](https://vercel.com/docs/mcp/vercel-mcp#setup)