---
title: "xAI and Vercel partner to bring zero-friction AI to developers - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/xai-and-vercel-partner-to-bring-zero-friction-ai-to-developers"
date: "2025-03-20"
scraped_at: "2026-03-02T09:35:21.462225332+00:00"
language: "en-zh"
translated: true
description: "Vercel partners with xAI to bring Grok models directly to your Vercel projects through the Vercel Marketplace—and soon v0—with no additional signup required. xAI adds a new free tier through Verce..."
---
&#123;% raw %}

Mar 20, 2025

2025 年 3 月 20 日

在 Vercel、AI SDK 和 v0 中使用 xAI 的 Grok 模型

Vercel 提供构建 AI 原生 Web 应用所需的工具与基础设施。我们正与 [xAI](https://x.ai/) 展开合作，通过 [Vercel Marketplace](https://vercel.com/marketplace/xai)（并即将支持 [v0](https://v0.dev/)），将 xAI 强大的 Grok 模型直接集成至 Vercel 项目中——全程无需额外注册。

为帮助您快速上手，xAI 将通过 Vercel 推出全新免费套餐，助力您高效开展原型设计与实验探索。目前，这些 Grok 模型已驱动我们的官方 [Next.js AI 聊天机器人模板](https://vercel.com/templates/next.js/nextjs-ai-chatbot)，并深度集成于 [AI SDK](https://sdk.vercel.ai/)。

此举是我们持续致力于在 Vercel 平台上实现“零摩擦 AI 使用体验”战略的重要组成部分。

![](images/xai-and-vercel-partner-to-bring-zero-friction-ai-to-developers-vercel/img_001.jpg)![](images/xai-and-vercel-partner-to-bring-zero-friction-ai-to-developers-vercel/img_002.jpg)

## Vercel Marketplace

随着 [Grok 模型现已上线](https://vercel.com/marketplace/xai) Vercel Marketplace，开发者可快速接入并使用 xAI 的对话式大模型进行开发。

![](images/xai-and-vercel-partner-to-bring-zero-friction-ai-to-developers-vercel/img_003.jpg)![](images/xai-and-vercel-partner-to-bring-zero-friction-ai-to-developers-vercel/img_004.jpg)

- 即刻启用 xAI 免费套餐——通过 Marketplace 注册，无需额外单独注册

- Access Grok's large language models (LLMs) directly from your Vercel projects

- 直接从您的 Vercel 项目中访问 Grok 的大语言模型（LLM）

- Simplify authentication and API key management through automatically configured environment variables

- 通过自动配置的环境变量，简化身份验证和 API 密钥管理

- Pay only for what you use with integrated billing through Vercel

- 仅为您实际使用的资源付费，账单通过 Vercel 统一结算

If you're already working in a Vercel project, you can also install xAI through the Marketplace from the Vercel CLI:

如果您已在 Vercel 项目中开展工作，您还可以通过 Vercel CLI 从 Vercel Marketplace 安装 xAI：

```bash
vercel install xai
```

[**Explore AI on the Vercel Marketplace**\\
\\
Play, test, and integrate with a wide range of AI model types, sizes, and specializations in the Vercel Marketplace.\\
\\
Get started](https://vercel.com/marketplace?category=ai)

[**在 Vercel Marketplace 探索 AI 工具**\\
\\
在 Vercel Marketplace 中体验、测试并集成多种类型、尺寸与专业方向的 AI 模型。\\
\\
立即开始](https://vercel.com/marketplace?category=ai)

## More ways to get started with AI

## 更多 AI 入门方式

We've streamlined AI experimentation and development through the AI SDK, ready-to-use templates, and our model playground.

我们通过 AI SDK、开箱即用的模板以及模型 Playground，大幅简化了 AI 实验与开发流程。

### The Next.js AI Chatbot, now powered by xAI

### Next.js AI 聊天机器人，现已由 xAI 提供支持

The [Next.js AI Chatbot](https://github.com/vercel/ai-chatbot) is a free open-source chatbot template built by the creators of Next.js, AI SDK, and shadcn/ui. It features tool calling, retrieval, code execution, artifacts, and genUI examples—the UI infrastructure you need to build your own ChatGPT or [grok.com](http://grok.com/).

[Next.js AI 聊天机器人](https://github.com/vercel/ai-chatbot) 是一款免费开源的聊天机器人模板，由 Next.js、AI SDK 和 shadcn/ui 的开发者共同打造。它支持工具调用（tool calling）、信息检索（retrieval）、代码执行（code execution）、产物生成（artifacts）以及 genUI 示例——为您提供构建属于自己的 ChatGPT 或 [grok.com](http://grok.com/) 所需的完整 UI 基础设施。

![](images/xai-and-vercel-partner-to-bring-zero-friction-ai-to-developers-vercel/img_005.jpg)![](images/xai-and-vercel-partner-to-bring-zero-friction-ai-to-developers-vercel/img_006.jpg)

### AI SDK

### AI SDK

The [AI SDK](https://sdk.vercel.ai/docs) is a free open-source library that gives you the tools you need to build AI-powered products and agents.  
[AI SDK](https://sdk.vercel.ai/docs) 是一个免费的开源库，为您提供构建 AI 驱动型产品与智能体所需的全部工具。

It offers a unified API for integrating almost any language model, so you can experiment, test, and change models and providers with just one or two lines of code.  
它提供统一的 API，支持接入几乎任何语言模型，让您仅需一两行代码即可完成模型与服务商的实验、测试与切换。

```tsx
import { xai } from "@ai-sdk/xai";

import { streamtext } from "ai";



const result = streamText({

5  model: xai("grok-2-1212"),

6  prompt: "What is the meaning of life?",

7});
```

```javascript
for await (const textPart of result.textStream) {

10  process.stdout.write(textPart); // The answer is 42.

11}
```

```javascript
for await (const textPart of result.textStream) {

10  process.stdout.write(textPart); // 答案是 42。

11}
```

The AI SDK also has a [playground](https://sdk.vercel.ai/playground) where you can compare output from different models and providers. xAI is the default provider and you can compare xAI’s Grok models against others from Anthropic, Google, OpenAI, and many more.

AI SDK 还提供一个 [在线体验平台（Playground）](https://sdk.vercel.ai/playground)，您可在其中对比不同模型与服务商的输出结果。xAI 是默认服务商，您可将 xAI 的 Grok 系列模型与 Anthropic、Google、OpenAI 等多家厂商的模型直接对比。

## A peek at what's next

## 下一步展望

When you’re vibe coding with [v0](https://v0.dev/), you'll soon be able to leverage the xAI Vercel Marketplace integration right in v0's chat interface (which is currently possible with [Vercel Marketplace storage integrations](https://vercel.com/changelog/vercel-marketplace-integrations-now-available-in-v0)).

当您使用 [v0](https://v0.dev/) 进行“氛围编程（vibe coding）”时，很快即可在 v0 的聊天界面中直接调用 xAI 与 Vercel Marketplace 的集成能力（目前，Vercel Marketplace 的存储类集成已支持该功能，详见 [Vercel Marketplace 集成现已接入 v0](https://vercel.com/changelog/vercel-marketplace-integrations-now-available-in-v0)）。

Soon, we'll be adding more AI integrations in the Vercel Marketplace. If you're a service provider interested in joining, you can reach out to us at integrations@vercel.com.

不久之后，我们将在 Vercel Marketplace 中陆续上线更多 AI 相关集成。如果您是服务提供商，并有意加入生态合作，请通过 integrations@vercel.com 与我们联系。

### Get started today

### 立即开始

With xAI now in the Vercel Marketplace, developers have more flexibility to build AI-powered applications with industry-leading models. Whether you're integrating Grok into your chatbot, experimenting with new AI workflows and agents, or scaling existing workloads, Vercel makes it easy to start shipping.

随着 xAI 正式入驻 Vercel Marketplace，开发者现在能更灵活地借助业界领先的 AI 模型构建人工智能应用。无论您是将 Grok 集成至聊天机器人、探索全新的 AI 工作流与智能体（agents），还是扩展现有工作负载，Vercel 都能让您轻松开启交付之旅。

[**Explore AI on Vercel**  
**在 Vercel 上探索 AI**

Vercel offers everything you need to get started with AI.  
Vercel 提供了您开始使用 AI 所需的一切。

Start building  
立即开始构建](https://vercel.com/ai)
&#123;% endraw %}
