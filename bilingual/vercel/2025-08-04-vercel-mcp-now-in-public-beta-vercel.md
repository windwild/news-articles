---
title: "Vercel MCP now in Public Beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercels-mcp"
date: "2025-08-04"
scraped_at: "2026-03-02T09:30:52.877685538+00:00"
language: "en-zh"
translated: true
description: "Connect your AI tools to Vercel using the Model Context Protocol (MCP), an open standard that lets AI assistants interact with your Vercel projects"
---

Aug 4, 2025

2025年8月4日

![](images/vercel-mcp-now-in-public-beta-vercel/img_001.jpg)![](images/vercel-mcp-now-in-public-beta-vercel/img_002.jpg)

Vercel 的 [官方 MCP（Model Control Protocol，模型控制协议）服务器](https://vercel.com/docs/mcp/vercel-mcp) 现已上线，并进入公开测试阶段，访问地址为：[mcp.vercel.com](https://mcp.vercel.com/)。该服务器提供基于 OAuth 授权的远程接口，使 AI 工具能够安全地与您的 Vercel 项目进行交互。

该服务器可与 Claude.ai、Claude Code、Claude 桌面版等 AI 助手，以及 VS Code 等开发工具集成，支持以下功能：

- 搜索并浏览 Vercel 官方文档  
- 管理项目与部署  
- 分析部署日志  

Vercel MCP 全面实现了最新的 [MCP 授权规范](https://modelcontextprotocol.io/specification/2025-06-18/basic/authorization) 和 [可流式传输的 HTTP 协议（Streamable HTTP）规范](https://modelcontextprotocol.io/specification/2025-06-18/basic/transports#streamable-http)，从而显著提升安全性与性能表现。

本次更新进一步强化了 AI 驱动工作流与 Vercel 生态系统之间的协同能力。

如需了解更多信息，请查阅我们的 [文档](https://vercel.com/docs/mcp/vercel-mcp)。