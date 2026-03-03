---
title: "Cursor now supported on Vercel MCP - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/cursor-now-supported-on-vercel-mcp"
date: "2025-08-09"
scraped_at: "2026-03-02T09:30:00.532240326+00:00"
language: "en"
translated: false
description: "Connect Cursor to Vercel MCP to manage projects and deployments, analyze logs, search docs, and more"
---




Aug 9, 2025

![](images/cursor-now-supported-on-vercel-mcp-vercel/img_001.jpg)![](images/cursor-now-supported-on-vercel-mcp-vercel/img_002.jpg)

You can now use [Cursor](https://vercel.com/docs/mcp/vercel-mcp#cursor) with Vercel MCP, our official [Model Context Protocol (MCP) server](https://vercel.com/docs/mcp/vercel-mcp). To ensure secure access, Vercel MCP currently supports AI clients that have been reviewed and approved by Vercel.

With Vercel MCP you can explore projects, inspect failed deployments, fetch logs, and more, now all without leaving Cursor.

To connect, either use click [here for a one-click setup](cursor://anysphere.cursor-deeplink/mcp/install?name=vercel&config=eyJ1cmwiOiJodHRwczovL21jcC52ZXJjZWwuY29tIn0%3D) or add the following to your `.cursor/mcp.json`:

mcp.json

```json
1{

2  "mcpServers": {

3    "vercel": {

4      "url": "https://mcp.vercel.com"

5    }

6  }

7}
```

Once added, Cursor will prompt you to log in with your Vercel account.

Read more about using [Cursor in Vercel MCP](https://vercel.com/docs/mcp/vercel-mcp#cursor).