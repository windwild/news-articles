---
title: "Devin, Raycast, Windsurf, and Goose now supported on Vercel MCP - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/devin-raycast-windsurf-and-goose-now-supported-on-vercel-mcp"
date: "2025-08-25"
scraped_at: "2026-03-02T09:29:28.686126979+00:00"
language: "en-zh"
translated: true
description: "Use Vercel MCP with supported AI clients like Devin, Raycast, Windsurf, and Goose to explore projects, view logs, inspect deployments, and more."
---

render_with_liquid: false
Aug 25, 2025

2025 年 8 月 25 日

You can now use [Devin](https://devin.ai/), [Raycast](https://www.raycast.com/), [Windsurf](https://windsurf.com/), and [Goose](https://block.github.io/goose/) with [Vercel MCP,](https://vercel.com/docs/mcp/vercel-mcp) our official Model Context Protocol (MCP) server. For security, Vercel MCP currently supports AI clients that have been reviewed and approved by Vercel.

您现在可以将 [Devin](https://devin.ai/)、[Raycast](https://www.raycast.com/)、[Windsurf](https://windsurf.com/) 和 [Goose](https://block.github.io/goose/) 与 [Vercel MCP](https://vercel.com/docs/mcp/vercel-mcp)（我们官方的模型上下文协议（Model Context Protocol, MCP）服务器）配合使用。出于安全考虑，Vercel MCP 当前仅支持经 Vercel 审核并批准的 AI 客户端。

Follow the steps below to get started with each client:

请按以下步骤，为每个客户端完成初始化配置：

### Devin

### Devin

1. Navigate to Devin's [Settings > MCP Marketplace](https://app.devin.ai/settings/mcp-marketplace)

1. 进入 Devin 的 [设置 > MCP 应用市场](https://app.devin.ai/settings/mcp-marketplace)

2. Search for **Vercel** and select the MCP

2. 搜索 **Vercel**，然后选择对应的 MCP 插件

3. Click **Install**

3. 点击 **安装**

### Raycast

### Raycast

1. Run the **Install Server** command

1. 运行 **Install Server**（安装服务器）命令

2. Enter the following details:  

2. 输入以下详细信息：

   - **Name:** `Vercel`  
   - **名称：** `Vercel`

   - **Transport:** HTTP  
   - **传输协议：** HTTP

   - **URL:** `https://mcp.vercel.com`  
   - **URL：** `https://mcp.vercel.com`

3. Click **Install**  
3. 点击 **安装**

### Windsurf  

### Windsurf  

1. Add the snippet below to your `mcp_config.json` file  
1. 将以下代码片段添加到您的 `mcp_config.json` 文件中  

```json
1{

2  "mcpServers": {

3    "vercel": {

4      "serverUrl": "https://mcp.vercel.com"

5    }
```

6  }

7}
```

### Goose

### 鹅（Goose）

1. 点击[此处](goose://extension?url=https%3A%2F%2Fmcp.vercel.com&type=streamable_http&id=vercel&name=Vercel&description=Access%20deployments%2C%20manage%20projects%2C%20and%20more%20with%20Vercel%E2%80%99s%20official%20MCP%20server)，一键安装 Vercel MCP。

通过 Vercel MCP，您可以授予智能体[访问受保护部署的权限](https://vercel.com/changelog/give-agents-access-to-protected-deployments-via-vercels-mcp-server)、[分析构建日志](https://vercel.com/docs/deployments/logs)，以及更多功能。

了解更多关于在 Vercel MCP 中[使用 AI 工具](https://vercel.com/docs/mcp/vercel-mcp)的信息。

[**连接至 Vercel MCP**\\
\\
阅读文档，深入了解该服务\\
\\
立即开始](https://vercel.com/docs/mcp/vercel-mcp#setup)