---
render_with_liquid: false
title: "Building efficient MCP servers - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/building-efficient-mcp-servers"
date: "2025-06-12"
scraped_at: "2026-03-02T09:32:27.099097257+00:00"
language: "en-zh"
translated: true
description: "MCP is becoming the standard for building AI model integrations. See how you can use Vercel's open-source MCP adapter to quickly build your own MCP server, like the teams at Zapier, Composio, and Sola..."
---
render_with_liquid: false
render_with_liquid: false

Jun 12, 2025

2025年6月12日

The [Model Context Protocol (MCP)](https://modelcontextprotocol.io/introduction) standardizes how to build integrations for AI models.  
[模型上下文协议（Model Context Protocol，MCP）](https://modelcontextprotocol.io/introduction) 标准化了面向 AI 模型构建集成的方式。

We built the [MCP adapter](https://vercel.com/changelog/mcp-server-support-on-vercel) to help developers create their own MCP servers using popular frameworks such as Next.js, Nuxt, and SvelteKit.  
我们开发了 [MCP 适配器（MCP adapter）](https://vercel.com/changelog/mcp-server-support-on-vercel)，帮助开发者借助 Next.js、Nuxt 和 SvelteKit 等主流框架快速构建自有 MCP 服务器。

Production apps like [Zapier](https://mcp.zapier.com/mcp), [Composio](https://mcp.composio.dev/), [Vapi](https://mcp.vapi.ai/), and [Solana](https://mcp.solana.com/) use the MCP adapter to deploy their own MCP servers on Vercel, and they've seen substantial growth in the past month.  
[Zapier](https://mcp.zapier.com/mcp)、[Composio](https://mcp.composio.dev/)、[Vapi](https://mcp.vapi.ai/) 和 [Solana](https://mcp.solana.com/) 等已投入生产的应用，均使用 MCP 适配器在 Vercel 上部署自有 MCP 服务器；过去一个月中，这些应用均实现了显著增长。

MCP has been adopted by popular clients like Cursor, Claude, and Windsurf. These now support connecting to MCP servers and calling tools. Companies create their own MCP servers to make their tools available in the ecosystem.  
Cursor、Claude 和 Windsurf 等主流客户端均已采用 MCP 协议。它们现已支持连接至 MCP 服务器并调用其中的工具。企业则通过构建自有 MCP 服务器，将其工具开放至整个 MCP 生态系统中。

The growing adoption of MCP shows its importance, but scaling MCP servers reveals limitations in the original design. Let's look at how the MCP specification has evolved, and how the MCP adapter can help.  
MCP 日益广泛的采用印证了其重要性；但当 MCP 服务器需要规模化扩展时，其原始设计的局限性也逐渐显现。接下来，我们将梳理 MCP 规范的演进历程，并探讨 MCP 适配器如何助力应对这些挑战。

## What's changed in MCP

## MCP 规范有哪些变化？

When the first version of the [MCP specification](https://modelcontextprotocol.io/specification/2024-11-05/basic/transports) was published in November 2024, it supported Standard IO (stdio) and [Server-Sent Events](https://v0.dev/chat/server-sent-events-QokL3arwn1E) (SSE) as methods of transport between clients and servers. Stdio required running the MCP server locally, while SSE allowed servers to be hosted and accessed remotely.  
2024 年 11 月发布的首个 [MCP 规范](https://modelcontextprotocol.io/specification/2024-11-05/basic/transports) 版本，支持标准输入输出（stdio）和 [服务端推送事件（Server-Sent Events，SSE）](https://v0.dev/chat/server-sent-events-QokL3arwn1E) 作为客户端与服务器之间的通信传输方式。其中，stdio 要求 MCP 服务器必须本地运行；而 SSE 则允许服务器远程托管并被访问。

However, SSE is an inefficient transport. It keeps a persistent connection open between client and server, even when idle. While Vercel's [Fluid compute](https://vercel.com/fluid) reduces overhead by reusing already allocated servers, SSE remains an unsustainable choice for MCP servers at scale.  
然而，SSE 是一种低效的传输方式：它会在客户端与服务器之间维持一条长期活跃的连接，即使在空闲状态下亦不释放。尽管 Vercel 的 [Fluid 计算](https://vercel.com/fluid) 机制可通过复用已分配的服务器资源来降低开销，SSE 在大规模部署 MCP 服务器的场景下仍属不可持续的选择。

### A new MCP server transport: Streamable HTTP

### 全新 MCP 服务器传输方式：可流式传输的 HTTP（Streamable HTTP）

In March 2025, a [new version of the MCP specification](https://modelcontextprotocol.io/specification/2025-03-26/basic/transports) introduced Streamable HTTP as the recommended transport, replacing SSE. This change improves efficiency by removing the need for persistent client-server connections.  
2025 年 3 月，[新版 MCP 规范](https://modelcontextprotocol.io/specification/2025-03-26/basic/transports) 正式将“可流式传输的 HTTP（Streamable HTTP）”列为推荐传输方式，以取代 SSE。该变更通过消除对持久化客户端-服务器连接的依赖，显著提升了传输效率。

Existing investments and lack of resources have slowed the adoption of Streamable HTTP by both MCP client developers and MCP server developers. As a result, many existing MCP clients continue to support only stdio and SSE.  
既有技术投入与资源限制，拖慢了 MCP 客户端及服务器开发者对 Streamable HTTP 的采纳进程。因此，当前大量已有的 MCP 客户端仍仅支持 stdio 和 SSE。

Server developers building with the Vercel MCP adapter get built-in support for both Streamable HTTP and SSE, with the option to disable SSE, to fully align with the officially supported and more efficient transport.

使用 Vercel MCP 适配器构建服务端的开发者，将获得对 Streamable HTTP 和 SSE 的内置支持；同时可选择禁用 SSE，从而完全契合官方支持且更高效的传输协议。

app/\[transport\]/route.ts

```javascript
import { createMcpHandler } from '@vercel/mcp-adapter';



const handler = createMcpHandler(server => {

4  server.tool(

5    'roll_dice',

6    'Rolls an N-sided die',

7    { sides: z.number().int().min(2) },

8    async ({ sides }) => {
```

使用 Vercel MCP 适配器构建服务端的开发者，将获得对 Streamable HTTP 和 SSE 的内置支持；同时可选择禁用 SSE，从而完全契合官方支持且更高效的传输协议。

app/\[transport\]/route.ts

```javascript
import { createMcpHandler } from '@vercel/mcp-adapter';



const handler = createMcpHandler(server => {

4  server.tool(

5    'roll_dice',

6    'Rolls an N-sided die',

7    { sides: z.number().int().min(2) },

8    async ({ sides }) => {
```

9      const value = 1 + Math.floor(Math.random() * sides);

10      return { content: [{ type: 'text', text: `🎲 You rolled a ${value}!` }] };

11    }

12  );

13});



export { handler as GET, handler as POST, handler as DELETE };
```

一个仅包含单个工具调用的 MCP 服务器示例。

## 优化 MCP 服务器以提升效率

支持流式传输的 HTTP（Streamable HTTP）采用标准 HTTP 传输协议，并同时支持无状态与有状态服务器模型，是远程托管 MCP 服务器的明确发展方向。

To support clients that do not yet handle Streamable HTTP, the [mcp-remote](https://www.npmjs.com/package/mcp-remote) package can proxy it over stdio. With a small [server setup change](https://www.npmjs.com/package/@vercel/mcp-adapter#:~:text=Connecting%20to%20your%20MCP%20server%20via%20stdio), like the approach used by [Solana](https://mcp.solana.com/), developers can benefit from Streamable HTTP's efficiency without waiting for full client support.

为支持尚未兼容 Streamable HTTP 的客户端，[mcp-remote](https://www.npmjs.com/package/mcp-remote) 包可通过标准输入/输出（stdio）对其进行代理。只需进行少量[服务端配置调整](https://www.npmjs.com/package/@vercel/mcp-adapter#:~:text=Connecting%20to%20your%20MCP%20server%20via%20stdio)（例如 [Solana](https://mcp.solana.com/) 所采用的方式），开发者即可立即享受 Streamable HTTP 带来的性能优势，无需等待客户端全面支持。

This approach provides forward compatibility while client support continues to evolve. In most cases, `mcp-remote` will no longer be needed once native support for Streamable HTTP is more widely adopted.

该方案在客户端支持持续演进的过程中，提供了面向未来的兼容性保障。大多数情况下，一旦 Streamable HTTP 的原生支持得到更广泛的采用，`mcp-remote` 将不再需要。

One MCP server deployed on Vercel was able to cut over to Streamable HTTP completely and cut CPU usage in half, even with continued user growth.

部署于 Vercel 的一个 MCP 服务器已全面迁移至 Streamable HTTP，在用户量持续增长的同时，CPU 使用率降低了一半。

![Migrating to Streamable HTTP reduced CPU consumption by over 50%](images/building-efficient-mcp-servers-vercel/img_001.jpg)![Migrating to Streamable HTTP reduced CPU consumption by over 50%](images/building-efficient-mcp-servers-vercel/img_002.jpg)

![迁移到 Streamable HTTP 后 CPU 消耗降低超 50%](images/building-efficient-mcp-servers-vercel/img_001.jpg)![迁移到 Streamable HTTP 后 CPU 消耗降低超 50%](images/building-efficient-mcp-servers-vercel/img_002.jpg)

Migrating to Streamable HTTP reduced CPU consumption by over 50%

迁移到 Streamable HTTP 后 CPU 消耗降低超 50%

## Building for the future

## 面向未来构建

The MCP ecosystem is evolving quickly. With Fluid compute and the MCP adapter, you can ship MCP servers that support both current and future clients.

MCP 生态系统正快速发展。借助 Fluid Compute 与 MCP Adapter，您可构建同时兼容当前及未来客户端的 MCP 服务器。

We are committed to supporting every team adopting MCP. Explore the [MCP Adapter](https://www.npmjs.com/package/@vercel/mcp-adapter) and try the Next.js MCP template to build your MCP server.

我们致力于支持所有采用 MCP 的团队。请探索 [MCP Adapter](https://www.npmjs.com/package/@vercel/mcp-adapter)，并尝试使用 Next.js MCP 模板来构建您的 MCP 服务器。

[**MCP Server with Next.js**\\
\\
Get started building your first MCP server on Vercel.\\
\\
Deploy now](https://vercel.com/templates/next.js/model-context-protocol-mcp-with-next-js)

[**基于 Next.js 的 MCP 服务器**\\
\\
立即开始在 Vercel 上构建您的首个 MCP 服务器。\\
\\
立即部署](https://vercel.com/templates/next.js/model-context-protocol-mcp-with-next-js)