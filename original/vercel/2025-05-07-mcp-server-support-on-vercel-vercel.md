---
title: "MCP server support on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/mcp-server-support-on-vercel"
date: "2025-05-07"
scraped_at: "2026-03-02T09:33:36.123610154+00:00"
language: "en"
translated: false
description: "Run MCP servers on with Next.js or Node.js in your Vercel project with 1st class support for Anthropic's MCP SDK"
---




May 7, 2025

![](images/mcp-server-support-on-vercel-vercel/img_001.jpg)![](images/mcp-server-support-on-vercel-vercel/img_002.jpg)

[Model Context Protocol (MCP)](https://modelcontextprotocol.io/introduction) is a way to build integrations for AI models.

Vercel now supports deploying MCP servers (which AI models can connect to) as well as MCP clients ( [AI chatbot](https://chat-sdk.dev/) applications which call the servers).

Get started with our [Next.js MCP template](https://vercel.com/templates/next.js/model-context-protocol-mcp-with-next-js) today.

## How is MCP different than APIs?

APIs allow different services to communicate together. MCP is slightly different.

Rather than thinking about MCP like a REST API, you can instead think about it like a tailored toolkit that helps an AI achieve a particular task. There may be multiple APIs and other business logic used behind the scenes for a single MCP tool.

If you are already familiar with [tool-calling in AI](https://ai-sdk.dev/docs/ai-sdk-core/tools-and-tool-calling), MCP is a way to invoke tools hosted on a different server.

MCP now supports a protocol similar to other web APIs, namely using HTTP and OAuth. This is an improvement from the previous stateful [Server-Sent Events (SSE)](https://v0.dev/chat/QokL3arwn1E) protocol.

## Deploying MCP servers to Vercel

To simplify building MCP servers on Vercel, we’ve published a [new package](https://www.npmjs.com/package/@vercel/mcp-adapter), `@vercel/mcp-adapter`, which supports both the older SSE transport and the newer stateless HTTP transport.

Update: The [@vercel/mcp-adapter](https://www.npmjs.com/package/@vercel/mcp-adapter) package has been renamed to [mcp-handler](https://github.com/vercel/mcp-adapter).

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

The majority of MCP clients currently only support the SSE transport option. To handle state required for the SSE transport, you can integrate a Redis server through any provider in our [marketplace](https://vercel.com/marketplace/category/storage) like Upstash and Redis Labs.

We’ve already seen customers successfully deploying MCP servers in production. One customer has seen [over 90% savings](https://x.com/rauchg/status/1919413544568701138) using [Fluid compute](https://vercel.com/fluid) on Vercel versus traditional serverless. Fluid enables you to have full Node.js or Python compatibility, while having a more cost effective and performant platform for AI inference and agentic workloads.

## Get started with MCP

Vercel's [AI SDK has built-in support](https://ai-sdk.dev/cookbook/next/mcp-tools) for connecting your Node.js or Next.js apps to MCP servers.

We’re looking forward to future MCP servers built with the HTTP transport and starting to explore the latest developments like OAuth support.

[Other Vercel projects like shadcn/ui](https://x.com/shadcn/status/1917597228513853603) are exploring ways to integrate MCP. If you have suggestions for MCP server use cases on Vercel, you can share your feedback in our [community](https://community.vercel.com/).

[**MCP Server with Next.js**\\
\\
Get started building your first MCP server on Vercel.\\
\\
Deploy now](https://vercel.com/templates/next.js/model-context-protocol-mcp-with-next-js)