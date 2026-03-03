---
title: "Agents can now access protected deployments via Vercel’s MCP server - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/give-agents-access-to-protected-deployments-via-vercels-mcp-server"
date: "2025-08-19"
scraped_at: "2026-03-02T09:29:35.986001694+00:00"
language: "en"
translated: false
description: "Vercel's MCP server now lets agents access deployments behind authentication, enabling them to act on your behalf."
---




Aug 19, 2025

Two new tools are now available in Vercel’s MCP server:

- **`get_access_to_vercel_url`** Generates a [shareable URL](https://vercel.com/docs/deployment-protection/methods-to-bypass-deployment-protection/sharable-links) that allows agent tools such as web fetch or Playwright to access deployments protected by [Vercel Authentication](https://vercel.com/docs/deployment-protection/methods-to-protect-deployments/vercel-authentication). The URL is temporary and grants access without requiring login credentials.

- **`web_fetch_vercel_url`** Allows agents to directly fetch content from deployments [protected by Vercel Authentication](https://vercel.com/docs/deployment-protection/methods-to-protect-deployments), even if a normal fetch would return `401 Unauthorized` or `403 Forbidden`.


Get started with the [Vercel MCP server](https://vercel.com/docs/mcp/vercel-mcp).

[**Connect to Vercel MCP**\\
\\
Read the docs to learn more about the server\\
\\
Get started](https://vercel.com/docs/mcp/vercel-mcp#setup)