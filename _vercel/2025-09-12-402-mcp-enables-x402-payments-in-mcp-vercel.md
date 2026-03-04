---
title: "402-mcp enables x402 payments in MCP - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/402-mcp-enables-x402-payments-in-mcp"
date: "2025-09-12"
scraped_at: "2026-03-02T09:28:32.469162002+00:00"
language: "en-zh"
translated: true
description: "Introducing x402-mcp, a library that integrates with the AI SDK to bring x402 paywalls to Model Context Protocol (MCP) servers to let agents discover and call pay for MCP tools easily and securely."
---

render_with_liquid: false
Sep 12, 2025

2025 年 9 月 12 日

Introducing [`x402-mcp`](https://github.com/ethanniser/x402-mcp), a library that integrates with the AI SDK to bring [x402](https://www.x402.org/) paywalls to Model Context Protocol (MCP) servers to let agents discover and call pay for MCP tools easily and securely.

隆重推出 [`x402-mcp`](https://github.com/ethanniser/x402-mcp) —— 一个与 AI SDK 集成的库，可将 [x402](https://www.x402.org/) 支付墙能力引入 Model Context Protocol（MCP）服务器，使 AI 智能体能够轻松、安全地发现并调用需付费的 MCP 工具。

With x402-mcp, you can define MCP servers with `paidTools` that require payment to run, enabling account-less, low-latency, anonymous payments directly in AI workflows. Payments confirm in ~100–200ms, with fees under $0.01 and support for minimums under $0.001.

借助 x402-mcp，您可定义包含 `paidTools` 的 MCP 服务器——这些工具在执行前需完成支付，从而实现在 AI 工作流中无需账户、低延迟、完全匿名的直接支付。支付确认耗时约 100–200 毫秒，手续费低于 0.01 美元，并支持最低支付额低至 0.001 美元。

Getting started is easy, here's how you can define a paid tool:

入门非常简单，以下是如何定义一个付费工具的示例：

```tsx
import { createPaidMcpHandler } from "x402-mcp";

import z from "zod";



const handler = createPaidMcpHandler(

5  (server) => {

6    server.paidTool(
```

7      "add_numbers",

7      “add_numbers”，

8      {

8      {

9        // declare a price of $0.001

9        // 声明价格为 0.001 美元

10        price: 0.001

10        price: 0.001

11      },

11      },

12      { a: z.number(), b: z.number() },

12      { a: z.number(), b: z.number() },

13      async (args) => {

13      async (args) => {

14        // ...your tool call

14        // ……你的工具调用

15      }

15      }

16    );

16    );

17  },

18  { recipient: process.env.WALLET_ADDRESS }

19);



export { handler as GET, handler as POST };
```

而与 AI SDK 的 MCP 客户端集成仅需一个函数即可启用支付功能：

```tsx
import { experimental_createMCPClient as createMCPClient } from "ai";

import { StreamableHTTPClientTransport } from "@modelcontextprotocol/sdk/client/streamableHttp.js";

import { withPayment } from "x402-mcp";
```

```javascript
const mcpClient = await createMCPClient({

6  transport: new StreamableHTTPClientTransport(url),

7}).then((client) => withPayment(client, { account: process.env.PRIVATE_KEY }));


const tools = await mcpClient.tools();
```

```javascript
const mcpClient = await createMCPClient({

6  transport: new StreamableHTTPClientTransport(url),

7}).then((client) => withPayment(client, { account: process.env.PRIVATE_KEY }));


const tools = await mcpClient.tools();
```

Read more about [x402](https://vercel.com/blog/introducing-x402-mcp-open-protocol-payments-for-mcp-tools) or try our full stack [x402 AI Starter Kit](https://x402-ai-starter.vercel.app/).

了解更多关于 [x402](https://vercel.com/blog/introducing-x402-mcp-open-protocol-payments-for-mcp-tools) 的信息，或尝试我们的全栈 [x402 AI 启动套件](https://x402-ai-starter.vercel.app/)。

[**x402 AI Starter**\\
\\
Fullstack AI demo of x402 with Next.js, AI SDK, AI Gateway, AI Elements and the Coinbase CDP\\
\\
Deploy](https://vercel.com/templates/ai/x402-ai-starter)

[**x402 AI 启动套件**\\
\\
基于 Next.js、AI SDK、AI 网关、AI Components 及 Coinbase CDP 构建的 x402 全栈 AI 演示应用\\
\\
立即部署](https://vercel.com/templates/ai/x402-ai-starter)