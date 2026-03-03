---
title: "Building efficient MCP servers - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/building-efficient-mcp-servers"
date: "2025-06-12"
scraped_at: "2026-03-02T09:32:27.099097257+00:00"
language: "en"
translated: false
description: "MCP is becoming the standard for building AI model integrations. See how you can use Vercel's open-source MCP adapter to quickly build your own MCP server, like the teams at Zapier, Composio, and Sola..."
---




Jun 12, 2025

The [Model Context Protocol (MCP)](https://modelcontextprotocol.io/introduction) standardizes how to build integrations for AI models. We built the [MCP adapter](https://vercel.com/changelog/mcp-server-support-on-vercel) to help developers create their own MCP servers using popular frameworks such as Next.js, Nuxt, and SvelteKit. Production apps like [Zapier](https://mcp.zapier.com/mcp), [Composio](https://mcp.composio.dev/), [Vapi](https://mcp.vapi.ai/), and [Solana](https://mcp.solana.com/) use the MCP adapter to deploy their own MCP servers on Vercel, and they've seen substantial growth in the past month.

MCP has been adopted by popular clients like Cursor, Claude, and Windsurf. These now support connecting to MCP servers and calling tools. Companies create their own MCP servers to make their tools available in the ecosystem.

The growing adoption of MCP shows its importance, but scaling MCP servers reveals limitations in the original design. Let's look at how the MCP specification has evolved, and how the MCP adapter can help.

## What's changed in MCP

When the first version of the [MCP specification](https://modelcontextprotocol.io/specification/2024-11-05/basic/transports) was published in November 2024, it supported Standard IO (stdio) and [Server-Sent Events](https://v0.dev/chat/server-sent-events-QokL3arwn1E) (SSE) as methods of transport between clients and servers. Stdio required running the MCP server locally, while SSE allowed servers to be hosted and accessed remotely.

However, SSE is an inefficient transport. It keeps a persistent connection open between client and server, even when idle. While Vercel's [Fluid compute](https://vercel.com/fluid) reduces overhead by reusing already allocated servers, SSE remains an unsustainable choice for MCP servers at scale.

### A new MCP server transport: Streamable HTTP

In March 2025, a [new version of the MCP specification](https://modelcontextprotocol.io/specification/2025-03-26/basic/transports) introduced Streamable HTTP as the recommended transport, replacing SSE. This change improves efficiency by removing the need for persistent client-server connections.

Existing investments and lack of resources have slowed the adoption of Streamable HTTP by both MCP client developers and MCP server developers. As a result, many existing MCP clients continue to support only stdio and SSE.

Server developers building with the Vercel MCP adapter get built-in support for both Streamable HTTP and SSE, with the option to disable SSE, to fully align with the officially supported and more efficient transport.

app/\[transport\]/route.ts

```javascript
import { createMcpHandler } from '@vercel/mcp-adapter';



const handler = createMcpHandler(server => {

4  server.tool(

5    'roll_dice',

6    'Rolls an N-sided die',

7    { sides: z.number().int().min(2) },

8    async ({ sides }) => {

9      const value = 1 + Math.floor(Math.random() * sides);

10      return { content: [{ type: 'text', text: `🎲 You rolled a ${value}!` }] };

11    }

12  );

13});



export { handler as GET, handler as POST, handler as DELETE };
```

An example MCP server with a single tool call.

## Optimizing MCP servers for efficiency

Streamable HTTP, with its standard HTTP transport and support for both stateless and stateful server models, is the clear path forward for remote-hosted MCP servers.

To support clients that do not yet handle Streamable HTTP, the [mcp-remote](https://www.npmjs.com/package/mcp-remote) package can proxy it over stdio. With a small [server setup change](https://www.npmjs.com/package/@vercel/mcp-adapter#:~:text=Connecting%20to%20your%20MCP%20server%20via%20stdio), like the approach used by [Solana](https://mcp.solana.com/), developers can benefit from Streamable HTTP's efficiency without waiting for full client support.

This approach provides forward compatibility while client support continues to evolve. In most cases, `mcp-remote` will no longer be needed once native support for Streamable HTTP is more widely adopted.

One MCP server deployed on Vercel was able to cut over to Streamable HTTP completely and cut CPU usage in half, even with continued user growth.

![Migrating to Streamable HTTP reduced CPU consumption by over 50%](images/building-efficient-mcp-servers-vercel/img_001.jpg)![Migrating to Streamable HTTP reduced CPU consumption by over 50%](images/building-efficient-mcp-servers-vercel/img_002.jpg)

Migrating to Streamable HTTP reduced CPU consumption by over 50%

## Building for the future

The MCP ecosystem is evolving quickly. With Fluid compute and the MCP adapter, you can ship MCP servers that support both current and future clients.

We are committed to supporting every team adopting MCP. Explore the [MCP Adapter](https://www.npmjs.com/package/@vercel/mcp-adapter) and try the Next.js MCP template to build your MCP server.

[**MCP Server with Next.js**\\
\\
Get started building your first MCP server on Vercel.\\
\\
Deploy now](https://vercel.com/templates/next.js/model-context-protocol-mcp-with-next-js)