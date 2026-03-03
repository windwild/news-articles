---
title: "Devin, Raycast, Windsurf, and Goose now supported on Vercel MCP - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/devin-raycast-windsurf-and-goose-now-supported-on-vercel-mcp"
date: "2025-08-25"
scraped_at: "2026-03-02T09:29:28.686126979+00:00"
language: "en"
translated: false
description: "Use Vercel MCP with supported AI clients like Devin, Raycast, Windsurf, and Goose to explore projects, view logs, inspect deployments, and more."
---




Aug 25, 2025

You can now use [Devin](https://devin.ai/), [Raycast](https://www.raycast.com/), [Windsurf](https://windsurf.com/), and [Goose](https://block.github.io/goose/) with [Vercel MCP,](https://vercel.com/docs/mcp/vercel-mcp) our official Model Context Protocol (MCP) server. For security, Vercel MCP currently supports AI clients that have been reviewed and approved by Vercel.

Follow the steps below to get started with each client:

### Devin

1. Navigate to Devin's [Settings > MCP Marketplace](https://app.devin.ai/settings/mcp-marketplace)

2. Search for **Vercel** and select the MCP

3. Click **Install**


### Raycast

1. Run the **Install Server** command

2. Enter the following details:

   - **Name:**`Vercel`

   - **Transport:** HTTP

   - **URL:**`https://mcp.vercel.com`
3. Click **Install**


### Windsurf

1. Add the snippet below to your `mcp_config.json` file


```json
1{

2  "mcpServers": {

3    "vercel": {

4      "serverUrl": "https://mcp.vercel.com"

5    }

6  }

7}
```

### Goose

1. Click [here](goose://extension?url=https%3A%2F%2Fmcp.vercel.com&type=streamable_http&id=vercel&name=Vercel&description=Access%20deployments%2C%20manage%20projects%2C%20and%20more%20with%20Vercel%E2%80%99s%20official%20MCP%20server) for a one-click installation of the Vercel MCP.


With Vercel MCP you can give agents [access to protected deployments](https://vercel.com/changelog/give-agents-access-to-protected-deployments-via-vercels-mcp-server), [analyze build logs](https://vercel.com/docs/deployments/logs), and more.

Read more about using [AI tools with Vercel MCP](https://vercel.com/docs/mcp/vercel-mcp).

[**Connect to Vercel MCP**\\
\\
Read the docs to learn more about the server\\
\\
Get started](https://vercel.com/docs/mcp/vercel-mcp#setup)