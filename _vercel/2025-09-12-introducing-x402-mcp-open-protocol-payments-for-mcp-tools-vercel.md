---
title: "Introducing x402-mcp: Open protocol payments for MCP tools - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-x402-mcp-open-protocol-payments-for-mcp-tools"
date: "2025-09-12"
scraped_at: "2026-03-02T09:28:32.388015335+00:00"
language: "en-zh"
translated: true
description: "We built x402-mcp to integrate x402 payments with Model Context Protocol (MCP) servers and the Vercel AI SDK."
---
&#123;% raw %}

Sep 12, 2025

2025 年 9 月 12 日

AI agents are improving at handling complex tasks, but a recurring limitation emerges when they need to access paid external services. The current model requires pre-registering with every API, managing keys, and maintaining separate billing relationships. This workflow breaks down if an agent needs to autonomously discover and interact with new services.

AI 智能体在处理复杂任务方面正持续进步，但当它们需要访问付费的外部服务时，一个反复出现的局限性便显现出来：当前模式要求预先向每个 API 注册、管理密钥，并分别维护计费关系。若智能体需自主发现并调用新服务，这一工作流便会失效。

[x402](https://www.x402.org/) is an open protocol that addresses this by adding payment directly into HTTP requests. It uses the [402 Payment Required status code](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Status/402) to let any API endpoint request payment without prior account setup.

[x402](https://www.x402.org/) 是一项开放协议，通过将支付能力直接嵌入 HTTP 请求来解决上述问题。它利用 [402 Payment Required（需付款）状态码](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Status/402)，使任意 API 端点均可在无需预先创建账户的前提下发起付款请求。

We built `x402-mcp` to integrate x402 payments with Model Context Protocol (MCP) servers and the Vercel AI SDK.

我们开发了 `x402-mcp`，以实现 x402 支付与模型上下文协议（Model Context Protocol, MCP）服务器及 Vercel AI SDK 的集成。

## How does x402 help?

## x402 如何提供帮助？

Developers building agents often encounter the same barrier: the agent can call APIs or MCPs, but integrating payments still requires manual setup such as registering accounts, exchanging keys, and configuring billing. The x402 protocol enables programmatic payments as part of the standard HTTP request flow.

构建智能体的开发者常面临同一道障碍：智能体虽可调用 API 或 MCP，但集成支付功能仍需人工操作，例如注册账户、交换密钥、配置计费方式等。x402 协议则使程序化支付成为标准 HTTP 请求流程的自然组成部分。

Unlike vendor-specific payment APIs, x402 is designed as an open web protocol. It is not tied to any centralized payment provider and can support different payment networks or schemes.

与厂商专属的支付 API 不同，x402 被设计为一项开放的 Web 协议。它不依赖任何中心化支付提供商，可兼容多种支付网络或结算方案。

## Paid API routes

## 付费 API 路由

For APIs, protecting routes is as simple as declaring middleware:

对于 API，保护路由只需声明中间件即可：

```tsx
import { paymentMiddleware } from "x402-next";
```

```ts
export const middleware = paymentMiddleware(
  {
    "/protected": {
      price: 0.01,
      config: {
        description: "Access to protected content"
      }
    }
  }
);
```

```ts
export const middleware = paymentMiddleware(
  {
    "/protected": {
      price: 0.01,
      config: {
        description: "访问受保护的内容"
      }
    }
  }
);
```

12);
```

在客户端，调用这些 API 只需一个封装了支付逻辑的 `fetch` 函数：

```tsx
import { wrapFetchWithPayment } from "x402-fetch";

const fetchWithPay = wrapFetchWithPayment(fetch, client);

const response = await fetchWithPay("https://api.example.com/paid-endpoint");
```

## 付费 MCP 工具

对于 MCP 服务器，`x402-mcp` 是对现有 `mcp-handler` 包的一个轻量级封装。它增加了定义 `paidTool` 的能力——这类工具在被调用时会附带指定价格。

api/mcp/route.ts

```tsx
import { createPaidMcpHandler } from "x402-mcp";
```

```ts
import z from "zod";
```

```ts
import z from "zod";
```

```ts
const handler = createPaidMcpHandler(
  (server) => {
    server.paidTool(
      "add_numbers",
      {
        // declare a price of $0.001
        price: 0.001
      },
```

```ts
const handler = createPaidMcpHandler(
  (server) => {
    server.paidTool(
      "add_numbers",
      {
        // 声明价格为 0.001 美元
        price: 0.001
      },
```

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

17  },

18  { recipient: process.env.WALLET_ADDRESS }

18  { recipient: process.env.WALLET_ADDRESS }

19);



19);



export { handler as GET, handler as POST };
``` 

export { handler as GET, handler as POST };
```

在客户端，支付功能通过一个封装器即可添加：

```tsx
import { experimental_createMCPClient as createMCPClient } from "ai";

import { StreamableHTTPClientTransport } from "@modelcontextprotocol/sdk/client/streamableHttp.js";

import { withPayment } from "x402-mcp";



const mcpClient = await createMCPClient({

6  transport: new StreamableHTTPClientTransport(url),

7}).then((client) => withPayment(client, { account }));



const tools = await mcpClient.tools();
```

This adds additional tools which enable agents to decide when and how to authorize tool payments over MCP in a transport-agnostic way.

这增加了额外的工具，使智能体能够以与传输协议无关的方式，自主决定何时以及如何在 MCP 上授权工具支付。

## How the protocol works

## 协议工作原理

The protocol follows the standard HTTP exchange:

该协议遵循标准的 HTTP 交互流程：

1. The client requests a protected resource

1. 客户端请求受保护的资源

2. The server responds with a 402 status code and payment instructions

2. 服务器返回 402 状态码及支付指令

3. The client submits payment authorization in a header and retries the request

3. 客户端在请求头中提交支付授权，并重试该请求

4. The server verifies and settles the request with an external payment “facilitator”

4. 服务器验证请求，并通过外部支付“中介方”完成结算

5. The server returns the resource to the client with payment outcomes in a header

5. 服务器将资源返回给客户端，并在响应头中附带支付结果

Right now most implementations settle as exact, one-time payments in USDC on the Base blockchain, which enables fast and accountless transactions. However, the x402 standard itself is payment-network agnostic and supports other currencies and schemes, including non-crypto payments.

目前，大多数实现均基于 Base 区块链以 USDC 进行精确、单次支付结算，从而实现快速且无需账户的交易。然而，x402 标准本身与支付网络无关，支持其他货币与支付方案，包括非加密货币支付方式。

## Try the starter template

## 尝试入门模板

We created the [x402 AI Starter](https://vercel.com/templates/ai/x402-ai-starter) template that demonstrates x402 in use with our wider suite of AI developer tools: [Next.js](https://nextjs.org/), [AI SDK](https://ai-sdk.dev/), [AI Elements](https://ai-elements.dev/), and [AI Gateway](https://vercel.com/ai-gateway). It has:

我们创建了 [x402 AI Starter](https://vercel.com/templates/ai/x402-ai-starter) 模板，用于演示 x402 如何与我们更广泛的 AI 开发者工具套件协同工作：[Next.js](https://nextjs.org/)、[AI SDK](https://ai-sdk.dev/)、[AI Elements](https://ai-elements.dev/) 和 [AI Gateway](https://vercel.com/ai-gateway)。该模板包含：

- An API route protected by `paymentMiddleware`

- 一条受 `paymentMiddleware` 保护的 API 路由

- An MCP server with a `paidTool`

- 一个配备 `paidTool` 的 MCP 服务器

- An MCP client extended with `withPayment`

- 一个通过 `withPayment` 扩展的 MCP 客户端

- A normal page which charges crawlers using x402

- 一个普通页面，使用 x402 向网络爬虫收取费用

- Secure server managed wallets through Coinbase's developer platform

- 通过 Coinbase 开发者平台安全托管的服务器钱包

- A frontend AI Chat + API playground to see x402 in action

- 一个前端 AI 聊天界面 + API 沙盒环境，直观展示 x402 的实际运行效果

![](images/introducing-x402-mcp-open-protocol-payments-for-mcp-tools-vercel/img_001.jpg)

![](images/introducing-x402-mcp-open-protocol-payments-for-mcp-tools-vercel/img_001.jpg)

The template deploys to Vercel with [one click](https://vercel.com/new/clone?demo-description=A%20fullstack%20template%20for%20using%20x402%20with%20MCP%20and%20AI%20SDK&demo-image=%2F%2Fimages.ctfassets.net%2Fe5382hct74si%2FRySDRkLC7OpZaTg9gNXRg%2F6010713a043bc3eec14160e796f09acf%2Fscreenshot.png&demo-title=x402%20AI%20Starter&demo-url=https%3A%2F%2Fx402-ai-starter.labs.vercel.dev%2F&env=CDP_API_KEY_ID%2CCDP_API_KEY_SECRET%2CCDP_WALLET_SECRET&envDescription=Coinbase%20Developer%20Platform%20credentials%20are%20needed%20to%20create%20and%20fund%20server%20wallets%2C%20and%20use%20the%20Coinbase%20x402%20facilitator&envLink=https%3A%2F%2Fdocs.cdp.coinbase.com%2Fapi-reference%2Fv2%2Fauthentication&from=templates&project-name=x402%20AI%20Starter&project-names=Comma%20separated%20list%20of%20project%20names%2Cto%20match%20the%20root-directories&repository-name=x402-ai-starter&repository-url=https%3A%2F%2Fgithub.com%2Fvercel-labs%2Fx402-ai-starter&root-directories=List%20of%20directory%20paths%20for%20the%20directories%20to%20clone%20into%20projects&skippable-integrations=1&teamSlug=ethannisers) and comes with everything needed to start experimenting. Install the package with `npm install x402-mcp` and [check out our live example](https://x402-ai-starter.vercel.app/).

该模板支持通过 [一键部署](https://vercel.com/new/clone?demo-description=A%20fullstack%20template%20for%20using%20x402%20with%20MCP%20and%20AI%20SDK&demo-image=%2F%2Fimages.ctfassets.net%2Fe5382hct74si%2FRySDRkLC7OpZaTg9gNXRg%2F6010713a043bc3eec14160e796f09acf%2Fscreenshot.png&demo-title=x402%20AI%20Starter&demo-url=https%3A%2F%2Fx402-ai-starter.labs.vercel.dev%2F&env=CDP_API_KEY_ID%2CCDP_API_KEY_SECRET%2CCDP_WALLET_SECRET&envDescription=Coinbase%20Developer%20Platform%20credentials%20are%20needed%20to%20create%20and%20fund%20server%20wallets%2C%20and%20use%20the%20Coinbase%20x402%20facilitator&envLink=https%3A%2F%2Fdocs.cdp.coinbase.com%2Fapi-reference%2Fv2%2Fauthentication&from=templates&project-name=x402%20AI%20Starter&project-names=Comma%20separated%20list%20of%20project%20names%2Cto%20match%20the%20root-directories&repository-name=x402-ai-starter&repository-url=https%3A%2F%2Fgithub.com%2Fvercel-labs%2Fx402-ai-starter&root-directories=List%20of%20directory%20paths%20for%20the%20directories%20to%20clone%20into%20projects&skippable-integrations=1&teamSlug=ethannisers) 直接发布至 Vercel，并已预置所有实验所需组件。请运行 `npm install x402-mcp` 安装对应包，并[查看我们的在线示例](https://x402-ai-starter.vercel.app/)。

## What's next

## 下一步计划

x402 offers a new approach to programmatic payments in AI applications.

x402 为 AI 应用中的程序化支付提供了一种新方法。

If you're building agents that need to pay for services, or APIs that want to charge agents, the starter template is a good place to begin exploring.

如果您正在构建需要为服务付费的智能体（agents），或希望向智能体收费的 API，那么该入门模板是开始探索的良好起点。
&#123;% endraw %}
