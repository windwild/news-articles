---
title: "MCP server support on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/mcp-server-support-on-vercel"
date: "2025-05-07"
scraped_at: "2026-03-02T09:33:36.123610154+00:00"
language: "en-zh"
translated: true
description: "Run MCP servers on with Next.js or Node.js in your Vercel project with 1st class support for Anthropic's MCP SDK"
---
{% raw %}

May 7, 2025

2025年5月7日

![](images/mcp-server-support-on-vercel-vercel/img_001.jpg)![](images/mcp-server-support-on-vercel-vercel/img_002.jpg)

[Model Context Protocol (MCP)](https://modelcontextprotocol.io/introduction) is a way to build integrations for AI models.

[模型上下文协议（Model Context Protocol，MCP）](https://modelcontextprotocol.io/introduction) 是一种为 AI 模型构建集成能力的方式。

Vercel now supports deploying MCP servers (which AI models can connect to) as well as MCP clients ( [AI chatbot](https://chat-sdk.dev/) applications which call the servers).

Vercel 现已支持部署 MCP 服务器（供 AI 模型连接）以及 MCP 客户端（即调用这些服务器的 [AI 聊天机器人](https://chat-sdk.dev/) 应用）。

Get started with our [Next.js MCP template](https://vercel.com/templates/next.js/model-context-protocol-mcp-with-next-js) today.

今天即可通过我们的 [Next.js MCP 模板](https://vercel.com/templates/next.js/model-context-protocol-mcp-with-next-js) 快速上手。

## How is MCP different than APIs?

## MCP 与传统 API 有何不同？

APIs allow different services to communicate together. MCP is slightly different.

API 使不同服务之间能够相互通信；而 MCP 则略有不同。

Rather than thinking about MCP like a REST API, you can instead think about it like a tailored toolkit that helps an AI achieve a particular task. There may be multiple APIs and other business logic used behind the scenes for a single MCP tool.

与其将 MCP 视为一种 REST API，不如将其理解为一套量身定制的工具包，旨在帮助 AI 完成特定任务。单个 MCP 工具背后可能调用多个 API 及其他业务逻辑。

If you are already familiar with [tool-calling in AI](https://ai-sdk.dev/docs/ai-sdk-core/tools-and-tool-calling), MCP is a way to invoke tools hosted on a different server.

如果你已熟悉 [AI 中的工具调用（tool-calling）](https://ai-sdk.dev/docs/ai-sdk-core/tools-and-tool-calling)，那么 MCP 就是一种调用托管在远程服务器上的工具的方式。

MCP now supports a protocol similar to other web APIs, namely using HTTP and OAuth. This is an improvement from the previous stateful [Server-Sent Events (SSE)](https://v0.dev/chat/QokL3arwn1E) protocol.

MCP 当前已支持一种与其他 Web API 类似的协议，即基于 HTTP 和 OAuth 的协议。这相比此前有状态的 [服务端推送事件（Server-Sent Events，SSE）](https://v0.dev/chat/QokL3arwn1E) 协议是一次重要改进。

## Deploying MCP servers to Vercel

## 将 MCP 服务器部署到 Vercel

To simplify building MCP servers on Vercel, we’ve published a [new package](https://www.npmjs.com/package/@vercel/mcp-adapter), `@vercel/mcp-adapter`, which supports both the older SSE transport and the newer stateless HTTP transport.

为了简化在 Vercel 上构建 MCP 服务器的过程，我们发布了一个[新包](https://www.npmjs.com/package/@vercel/mcp-adapter)——`@vercel/mcp-adapter`，它同时支持较早的 SSE 传输协议和更新的无状态 HTTP 传输协议。

Update: The [@vercel/mcp-adapter](https://www.npmjs.com/package/@vercel/mcp-adapter) package has been renamed to [mcp-handler](https://github.com/vercel/mcp-adapter).

更新：[@vercel/mcp-adapter](https://www.npmjs.com/package/@vercel/mcp-adapter) 包已更名为 [mcp-handler](https://github.com/vercel/mcp-adapter)。

app/\[transport\]/route.ts

`app/[transport]/route.ts`

```javascript
import { createMcpHandler } from '@vercel/mcp-adapter';



const handler = createMcpHandler(server => {

4  server.tool(

5    'roll_dice',

6    'Rolls an N-sided die',
```

7    { sides: z.number().int().min(2) },

7    { sides: z.number().int().min(2) },

8    async ({ sides }) => {

8    async ({ sides }) => {

9      const value = 1 + Math.floor(Math.random() * sides);

9      const value = 1 + Math.floor(Math.random() * sides);

10      return { content: [{ type: 'text', text: `🎲 You rolled a ${value}!` }] };

10      return { content: [{ type: 'text', text: `🎲 您掷出了 ${value}！` }] };

11    }

11    }

12  );

12  );

13});



13});



export { handler as GET, handler as POST, handler as DELETE };

export { handler as GET, handler as POST, handler as DELETE };

An example MCP server with a single tool call.

一个仅包含单个工具调用的 MCP 服务器示例。

The majority of MCP clients currently only support the SSE transport option. To handle state required for the SSE transport, you can integrate a Redis server through any provider in our [marketplace](https://vercel.com/marketplace/category/storage) like Upstash and Redis Labs.

目前，大多数 MCP 客户端仅支持 SSE 传输方式。为处理 SSE 传输所需的状态，您可通过我们 [应用市场](https://vercel.com/marketplace/category/storage) 中的任意服务商（例如 Upstash 和 Redis Labs）集成 Redis 服务器。

We’ve already seen customers successfully deploying MCP servers in production. One customer has seen [over 90% savings](https://x.com/rauchg/status/1919413544568701138) using [Fluid compute](https://vercel.com/fluid) on Vercel versus traditional serverless. Fluid enables you to have full Node.js or Python compatibility, while having a more cost effective and performant platform for AI inference and agentic workloads.

我们已见证多家客户成功将 MCP 服务器投入生产环境。其中一位客户使用 Vercel 的 [Fluid 计算](https://vercel.com/fluid) 替代传统无服务器架构，实现了 [超过 90% 的成本节省](https://x.com/rauchg/status/1919413544568701138)。Fluid 不仅提供完整的 Node.js 或 Python 兼容性，还为 AI 推理与智能体（agentic）工作负载提供了更具成本效益且性能更优的平台。

## Get started with MCP

## 快速开始使用 MCP

Vercel's [AI SDK has built-in support](https://ai-sdk.dev/cookbook/next/mcp-tools) for connecting your Node.js or Next.js apps to MCP servers.

Vercel 的 [AI SDK 内置支持](https://ai-sdk.dev/cookbook/next/mcp-tools)，可轻松将您的 Node.js 或 Next.js 应用连接至 MCP 服务器。

We’re looking forward to future MCP servers built with the HTTP transport and starting to explore the latest developments like OAuth support.

我们期待未来基于 HTTP 传输构建的 MCP 服务器，并正积极探索 OAuth 支持等最新进展。

[Other Vercel projects like shadcn/ui](https://x.com/shadcn/status/1917597228513853603) are exploring ways to integrate MCP. If you have suggestions for MCP server use cases on Vercel, you can share your feedback in our [community](https://community.vercel.com/).

[包括 shadcn/ui 在内的其他 Vercel 项目](https://x.com/shadcn/status/1917597228513853603) 正在探索 MCP 的集成方式。如果您有关于 MCP 服务器在 Vercel 上的应用场景建议，欢迎在我们的 [社区](https://community.vercel.com/) 中分享反馈。

[**MCP Server with Next.js**\\
\\
Get started building your first MCP server on Vercel.\\
\\
Deploy now](https://vercel.com/templates/next.js/model-context-protocol-mcp-with-next-js)

[**使用 Next.js 构建 MCP 服务器**\\
\\
立即开始，在 Vercel 上构建您的首个 MCP 服务器。\\
\\
立即部署](https://vercel.com/templates/next.js/model-context-protocol-mcp-with-next-js)
{% endraw %}
