---
render_with_liquid: false
title: "Cursor now supported on Vercel MCP - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/cursor-now-supported-on-vercel-mcp"
date: "2025-08-09"
scraped_at: "2026-03-02T09:30:00.532240326+00:00"
language: "en-zh"
translated: true
description: "Connect Cursor to Vercel MCP to manage projects and deployments, analyze logs, search docs, and more"
---
render_with_liquid: false
render_with_liquid: false

Aug 9, 2025

2025年8月9日

![](images/cursor-now-supported-on-vercel-mcp-vercel/img_001.jpg)![](images/cursor-now-supported-on-vercel-mcp-vercel/img_002.jpg)

You can now use [Cursor](https://vercel.com/docs/mcp/vercel-mcp#cursor) with Vercel MCP, our official [Model Context Protocol (MCP) server](https://vercel.com/docs/mcp/vercel-mcp). To ensure secure access, Vercel MCP currently supports AI clients that have been reviewed and approved by Vercel.

您现在可以在 Vercel MCP（我们官方的 [Model Context Protocol（MCP）服务器](https://vercel.com/docs/mcp/vercel-mcp)）中使用 [Cursor](https://vercel.com/docs/mcp/vercel-mcp#cursor)。为确保访问安全，Vercel MCP 当前仅支持经 Vercel 审核并批准的 AI 客户端。

With Vercel MCP you can explore projects, inspect failed deployments, fetch logs, and more, now all without leaving Cursor.

借助 Vercel MCP，您可在不离开 Cursor 的前提下，浏览项目、检查部署失败原因、获取日志等。

To connect, either use click [here for a one-click setup](cursor://anysphere.cursor-deeplink/mcp/install?name=vercel&config=eyJ1cmwiOiJodHRwczovL21jcC52ZXJjZWwuY29tIn0%3D) or add the following to your `.cursor/mcp.json`:

如需连接，请点击 [此处一键配置](cursor://anysphere.cursor-deeplink/mcp/install?name=vercel&config=eyJ1cmwiOiJodHRwczovL21jcC52ZXJjZWwuY29tIn0%3D)，或在您的 `.cursor/mcp.json` 文件中添加以下内容：

mcp.json

```json
1{

2  "mcpServers": {

3    "vercel": {

4      "url": "https://mcp.vercel.com"
```

5    }

6  }

7}
```

添加完成后，Cursor 将提示您使用 Vercel 账户登录。

有关在 Vercel MCP 中使用 Cursor 的更多信息，请参阅 [Cursor 在 Vercel MCP 中的使用](https://vercel.com/docs/mcp/vercel-mcp#cursor)。