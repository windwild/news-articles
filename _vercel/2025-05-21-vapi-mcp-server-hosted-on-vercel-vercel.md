---
title: "Vapi MCP server hosted on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vapi-mcp-server-on-vercel"
date: "2025-05-21"
scraped_at: "2026-03-02T09:33:16.003820691+00:00"
language: "en-zh"
translated: true
description: "Vapi has used Vercel's MCP Adapter to deploy and host their MCP server on Vercel, leveraging the benefits of Fluid Compute"
---

May 21, 2025

2025 年 5 月 21 日

Vercel 最近发布了一个 [模型上下文协议（MCP）适配器](https://vercel.com/changelog/mcp-server-support-on-vercel-4FowFVUeMI2SORXwOBOMfo)，可帮助用户在主流框架上轻松启动 MCP 服务器。

[Vapi](https://vapi.ai/) 正在构建一个用于开发实时语音智能体（voice agents）的 API。它负责编排（orchestration）、弹性伸缩（scaling）和电话通信（telephony），从而提供一种完全与模型无关、可自由替换的接口，以支持智能体开发。

Vapi 基于 Vercel 重建了其 [MCP 服务器](https://docs.vapi.ai/sdk/mcp-server)，使用户能够创建智能体、自动化测试、分析通话转录文本（transcripts）、构建工作流，并让智能体访问 Vapi 提供的全部端点。

## 什么是 MCP 服务器？

## 什么是 MCP 服务器？

MCP 服务器是 AI 模型用于接入外部能力的集成组件。

与其将 MCP 理解为一种 REST API，不如将其视作一套量身定制的工具包（toolkit），旨在协助 AI 完成特定任务。单个 MCP 工具背后，可能调用多个 API 及其他业务逻辑。

若您已熟悉 [AI 中的工具调用（tool-calling）](https://ai-sdk.dev/docs/ai-sdk-core/tools-and-tool-calling)，那么 MCP 就是一种调用托管在远程服务器上的工具的方式。

## 迁移至 Vercel

## 迁移至 Vercel

Vapi 的 MCP 服务器此前仅支持 [服务端推送事件（Server-Sent Events, SSE）](https://v0.dev/chat/QokL3arwn1E) 传输协议。通过采用 [Vercel 的 MCP 适配器](https://www.npmjs.com/package/@vercel/mcp-adapter) 重建其 MCP 服务器，Vapi 现在开箱即用地同时支持 SSE 传输协议以及更新的可流式传输 HTTP（Streamable HTTP）协议。

Rebuilding their server was accelerated using the Vercel MCP Adapter. Compared to other ways to write and deploy MCP servers, the MCP Adapter is a simple package anyone can drop into a route endpoint of any Node.js compatible framework. It utilizes [widely available web standards](https://vercel.com/blog/evolving-vercel-functions-2Boy2rUPGkv708ud0QsFjj) and, when deployed on Vercel, enables MCP clients to instantly connect and use the server.

借助 Vercel MCP 适配器，Vapi 加速了其服务器的重建工作。相较于其他编写和部署 MCP 服务器的方式，MCP 适配器是一个轻量级软件包，可轻松集成至任意兼容 Node.js 的框架的路由端点中。它基于[广泛采用的 Web 标准](https://vercel.com/blog/evolving-vercel-functions-2Boy2rUPGkv708ud0QsFjj)，当部署在 Vercel 平台上时，可使 MCP 客户端即时连接并使用该服务器。

Deploying on Vercel allows Vapi to to leverage [Fluid Compute](https://vercel.com/fluid). Fluid Compute maximizes available compute time and resources, which significantly optimizes your compute footprint and efficiency. Specifically for MCP workloads, Fluid will intelligently re-use existing resources to handle multiple MCP client connections before scaling up new ones.

部署于 Vercel 平台使 Vapi 能够充分利用 [Fluid Compute（弹性计算）](https://vercel.com/fluid)。Fluid Compute 可最大化利用可用的计算时间与资源，从而显著优化计算资源占用率与运行效率。针对 MCP 工作负载，Fluid 会智能复用现有资源来同时处理多个 MCP 客户端连接，仅在必要时才扩展新的计算实例。

> “We're betting on MCP to make integrating Vapi into workflows frictionless. Building on Vercel let us deliver a seamless, reliable experience for our users. Setup was fast, and we're excited for new features like observability and OAuth as our MCP server grows!”  
>  
> “我们坚定看好 MCP 技术，致力于让 Vapi 无缝融入各类工作流。依托 Vercel 构建，我们得以向用户交付流畅、可靠的体验。初始配置极为迅速；随着 MCP 服务器持续演进，我们亦热切期待可观测性（Observability）、OAuth 等新功能的落地！”  
>  
> ![](images/vapi-mcp-server-hosted-on-vercel-vercel/img_001.jpg)  
>  
> **Elizabeth Trykin**  
>  
> **伊丽莎白·特里金**

## Conclusion

## 结语

Vapi is going all in on Vercel for their MCP server infrastructure. Vercel's suite of products including the MCP Adapter, [Observability](https://vercel.com/changelog/vercel-observability-is-now-generally-available-532QrzDhXIw7fPR1PRhTV1), Fluid Compute, and [Firewall](https://vercel.com/changelog/improved-traffic-visibility-on-firewall-overview-page-3oxkdIUeQgEr35vKHWwYhG) make it easier for Vapi to focus on building their product instead of managing infrastructure.

Vapi 已全面采用 Vercel 作为其 MCP 服务器基础设施的核心平台。Vercel 提供的一整套产品——包括 MCP 适配器、[可观测性（Observability）](https://vercel.com/changelog/vercel-observability-is-now-generally-available-532QrzDhXIw7fPR1PRhTV1)、Fluid Compute（弹性计算）以及[防火墙（Firewall）](https://vercel.com/changelog/improved-traffic-visibility-on-firewall-overview-page-3oxkdIUeQgEr35vKHWwYhG)——大幅降低了基础设施运维负担，使 Vapi 能够更专注于核心产品的开发与创新。

Check out [Vapi's MCP server](https://mcp.vapi.ai/), their [blog post](https://vapi.ai/blog/vapi-s-mcp-server-is-live-on-vercel), and get started deploying MCP servers with our [Next.js MCP template](https://github.com/vercel-labs/mcp-for-next.js/) today.

欢迎访问 [Vapi 的 MCP 服务器](https://mcp.vapi.ai/)，阅读其[技术博客文章](https://vapi.ai/blog/vapi-s-mcp-server-is-live-on-vercel)，并立即使用我们的 [Next.js MCP 模板](https://github.com/vercel-labs/mcp-for-next.js/) 开始部署您自己的 MCP 服务器！