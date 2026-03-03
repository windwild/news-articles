---
title: "ChatGPT can now integrate with Vercel MCP - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/chatgpt-is-now-supported-on-vercel-mcp"
date: "2025-09-10"
scraped_at: "2026-03-02T09:28:57.345375261+00:00"
language: "en"
translated: false
description: "Use Vercel MCP with ChatGPT to explore projects, view logs, share access to protected deployments, and more."
---




Sep 10, 2025

![](images/chatgpt-can-now-integrate-with-vercel-mcp-vercel/img_001.jpg)![](images/chatgpt-can-now-integrate-with-vercel-mcp-vercel/img_002.jpg)

You can now use ChatGPT with [Vercel MCP,](https://vercel.com/docs/mcp/vercel-mcp) our official Model Context Protocol (MCP) server. For security, Vercel MCP currently supports AI clients that have been reviewed and approved by Vercel.

Connectors within ChatGPT are available in [beta to Pro and Plus accounts](https://platform.openai.com/docs/guides/developer-mode) on the web.

Follow the steps below to set up Vercel as a connector within ChatGPT:

- **Enable developer mode:** Go to [Settings → Connectors](https://chatgpt.com/#settings/Connectors) → Advanced → Developer mode.

- **Add Vercel MCP**

  - Open [ChatGPT settings](https://chatgpt.com/#settings)

  - In the Connectorstab, click `Create`

    - Name: `Vercel`

    - MCP server URL: `https://mcp.vercel.com`.

    - Authentication: `OAuth`
  - Click `Create`

You should now be able to select Vercel as a connector in [Developer Mode](https://platform.openai.com/docs/guides/developer-mode) chats.

With Vercel MCP you can give agents [access to protected deployments](https://vercel.com/changelog/give-agents-access-to-protected-deployments-via-vercels-mcp-server), [analyze build logs](https://vercel.com/docs/deployments/logs), and more.

Read more about using [AI tools with Vercel MCP](https://vercel.com/docs/mcp/vercel-mcp).

[**Connect to Vercel MCP**\\
\\
Read the docs to learn more about the server\\
\\
Get started](https://vercel.com/docs/mcp/vercel-mcp#setup)