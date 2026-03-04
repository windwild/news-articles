---
title: "Introducing the AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/ai-gateway"
date: "2025-05-20"
scraped_at: "2026-03-02T09:33:22.339864485+00:00"
language: "en-zh"
translated: true
description: "With the AI Gateway, build with any model instantly. No API keys, no configuration, no vendor lock-in."
---
{% raw %}

May 20, 2025

2025 年 5 月 20 日

**Note**: This blog is outdated, please reference [this page](https://vercel.com/ai-gateway) for the latest information or read the docs [here](https://vercel.com/docs/ai-gateway).

**注意**：本博客内容已过时，请参考[此页面](https://vercel.com/ai-gateway)获取最新信息，或查阅[此处](https://vercel.com/docs/ai-gateway)的文档。

The Vercel AI Gateway is now available for alpha testing.

Vercel AI 网关现已开放 Alpha 测试。

Built on the [AI SDK 5 alpha](https://ai-sdk.dev/docs/announcing-ai-sdk-5-alpha), the Gateway lets you switch between ~100 AI models without needing to manage API keys, rate limits, or provider accounts. The Gateway handles authentication, usage tracking, and in the future, billing.

该网关基于 [AI SDK 5 Alpha 版本](https://ai-sdk.dev/docs/announcing-ai-sdk-5-alpha) 构建，支持在约 100 种 AI 模型之间自由切换，无需自行管理 API 密钥、速率限制或供应商账户。网关将统一处理身份认证、用量追踪，并将在未来支持计费功能。

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: 'xai/grok-3', // defaults to Vercel AI Gateway

5  prompt: 'Tell me the history of the San Francisco Mission-style burrito'

6})
```

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: 'xai/grok-3', // 默认使用 Vercel AI 网关

5  prompt: '请告诉我旧金山米慎区（Mission）风格卷饼的历史'

6})
```

Write code in an app route or a script like the code above

在应用路由或类似上述代码的脚本中编写代码。

Get started with [AI SDK 5](https://ai-sdk.dev/docs/announcing-ai-sdk-5-alpha) and the [Gateway](https://ai-sdk.dev/model-library), or continue reading to learn more.

立即开始使用 [AI SDK 5](https://ai-sdk.dev/docs/announcing-ai-sdk-5-alpha) 和 [Gateway](https://ai-sdk.dev/model-library)，或继续阅读以了解更多信息。

Terminal

终端

```bash
pnpm install ai@beta
```

## Why we’re building the AI Gateway

## 我们为何构建 AI Gateway

The current speed of AI development is fast and is **only getting faster**.

当前 AI 发展的速度极快，而且**只会越来越快**。

There's a new state-of-the-art model released almost every week. Frustratingly, this means developers have been locked into a specific provider or model API in their application code. We want to help developers ship fast and keep up with AI progress, without needing 10 different API keys and provider accounts.

几乎每周都会发布一款新的前沿模型。令人沮丧的是，这导致开发者在应用代码中被锁定于某个特定供应商或模型 API。我们希望帮助开发者快速交付产品、紧跟 AI 发展步伐，而无需管理多达 10 个不同的 API 密钥和供应商账户。

Production AI applications often run into capacity issues or rate limiting due to high demand. Infrastructure providers move quickly to bring models online and keep up with this demand, but this can come at the expense of performance or availability.

生产环境中的 AI 应用常因高并发请求而遭遇容量瓶颈或速率限制问题。基础设施提供商虽能迅速上线模型以满足需求，但此举可能以牺牲性能或可用性为代价。

The AI Gateway will allow you to load balance across providers, or fail over if a provider has downtime or degradation in performance. Model inference costs keep dropping and providers are competing on quality, performance, and price. The Gateway helps you quickly take advantage of these cost savings.

AI Gateway 可让您在多个供应商之间实现负载均衡，或在某供应商出现宕机或性能下降时自动故障转移。模型推理成本持续降低，各供应商正围绕质量、性能与价格展开激烈竞争。Gateway 帮助您快速享受这些成本优势。

We're taking what we've learned scaling [v0](https://v0.dev/) to millions of users, by quickly load balancing and switching between a mixture of providers, and turning that infrastructure into the AI Gateway.

我们正将支撑 [v0](https://v0.dev/) 扩展至数百万用户过程中积累的经验——包括快速负载均衡与在多种供应商间灵活切换的能力——转化为 AI Gateway 这一基础设施。

## Integration with the AI SDK

## 与 AI SDK 的集成

We built the [AI SDK](https://ai-sdk.dev/) to create a common abstraction for AI model APIs across modalities like text, images, and audio.

我们构建了 [AI SDK](https://ai-sdk.dev/)，旨在为文本、图像、音频等多模态 AI 模型 API 提供统一的抽象层。

The AI SDK is free and open source, and works with any model or infrastructure provider. The AI Gateway is a separate Vercel product built _on top_ of the AI SDK.

AI SDK 免费且开源，兼容任意模型或基础设施提供商。AI Gateway 是 Vercel 推出的另一款独立产品，构建于 AI SDK 之上。

We're building these products with high cohesion, but loose coupling. The Gateway will take full advantage of AI SDK features like tool calling, function arguments, streaming, retries, attachments, and structured outputs.

我们以高内聚、低耦合的方式开发这些产品。Gateway 将充分运用 AI SDK 的各项能力，例如工具调用（tool calling）、函数参数（function arguments）、流式响应（streaming）、自动重试（retries）、附件支持（attachments）以及结构化输出（structured outputs）。

## Pricing

## 定价

During the AI Gateway alpha, usage is free with rate limits based on your Vercel plan tier. These rate limits are similar to the current [AI SDK Playground](https://ai-sdk.dev/playground).

在 AI Gateway 的 Alpha 测试阶段，使用完全免费，但会根据您的 Vercel 套餐等级施加调用频率限制。这些限制与当前的 [AI SDK Playground](https://ai-sdk.dev/playground) 类似。

We plan to support pay-as-you-go pricing when the Gateway reaches general availability. Model pricing will follow the provider’s market rates, updated regularly. We are also planning to explore bring-your-own-key in the future.

待 Gateway 正式发布（General Availability）后，我们将支持按量付费（pay-as-you-go）模式。模型定价将遵循各服务商的市场价格，并定期更新。此外，我们未来还计划支持“自带 API 密钥”（bring-your-own-key）方案。

## What’s coming next

## 即将推出的功能

- Load balancing and model failover

- 负载均衡与模型故障转移（failover）

- Pay-as-you-go billing

- 按量计费

- Bring-your-own-key support  
- 支持自带密钥（BYOK）

- Unified logging, usage tracking, and observability  
- 统一日志记录、用量追踪与可观测性

- OpenAI-compatible API  
- 兼容 OpenAI 的 API


## Start exploring AI Gateway  

## 开始探索 AI Gateway  

We’re shipping this in alpha to get your input and early feedback. [Tag us on X](https://x.com/intent/post?screen_name=vercel) to share your work and tell us what you want to see from the AI Gateway.  

我们正以 Alpha 版本发布此产品，旨在收集您的意见与早期反馈。欢迎在 X 平台 [@vercel](https://x.com/intent/post?screen_name=vercel) 上标记我们，分享您的实践成果，并告诉我们您希望 AI Gateway 提供哪些功能。

For more information, get started with our demo applications:  

如需了解更多，请从我们的演示应用入手：

- [Next.js demo](https://github.com/vercel-labs/ai-sdk-gateway-demo)  
- [Next.js 演示应用](https://github.com/vercel-labs/ai-sdk-gateway-demo)

- [Svelte demo](https://github.com/vercel-labs/ai-sdk-gateway-demo-svelte)  
- [Svelte 演示应用](https://github.com/vercel-labs/ai-sdk-gateway-demo-svelte)


For model support and more usage examples, visit [ai-sdk.dev/model-library](https://ai-sdk.dev/model-library).  

如需了解模型支持详情及更多使用示例，请访问 [ai-sdk.dev/model-library](https://ai-sdk.dev/model-library)。

Vercel AI Gateway is not yet ready for production use or migrating existing projects.  

Vercel AI Gateway 当前尚未达到生产环境就绪状态，也不适用于现有项目的迁移。
{% endraw %}
