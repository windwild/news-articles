---
title: "Vercel collaborates with OpenAI for GPT-5 launch - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-collaborates-with-openai-for-gpt-5-launch"
date: "2025-08-07"
scraped_at: "2026-03-02T09:30:12.676199315+00:00"
language: "en-zh"
translated: true
description: "The GPT-5 family of models released today, are now available through AI Gateway and are in production on our own v0.dev applications. Thanks to OpenAI, Vercel has been testing these models for a few w..."
---
&#123;% raw %}

Aug 7, 2025

2025 年 8 月 7 日

The GPT-5 family of models, released today, is now available through [AI Gateway](https://vercel.com/ai-gateway/models/gpt-5) and in production on [v0.dev](https://v0.dev/). Thanks to OpenAI, Vercel has been testing these models over the past few weeks in v0, Next.js, AI SDK, and [Vercel Sandbox.](https://vercel.com/docs/vercel-sandbox)

今日发布的 GPT-5 系列模型现已通过 [AI Gateway](https://vercel.com/ai-gateway/models/gpt-5) 提供，并已在 [v0.dev](https://v0.dev/) 上投入生产环境使用。感谢 OpenAI 的支持，Vercel 过去数周已在 v0、Next.js、AI SDK 及 [Vercel Sandbox](https://vercel.com/docs/vercel-sandbox) 中对这些模型展开测试。

From our testing, GPT-5 is noticeably better at frontend design than previous models. It generates polished, balanced UIs with clean, composable code. Internally, we’ve already started using GPT-5 for Vercel's in-dashboard Agent and for [v0.dev/gpt-5](https://v0.dev/gpt-5). GPT-5 shows strong performance in agent-based workflows. We have been impressed with it's long-context reasoning and ability to handle multiple tools in parallel have been especially effective in powering Vercel Agent.

根据我们的测试，GPT-5 在前端设计方面明显优于此前各代模型：它能生成精致、均衡的用户界面，并输出简洁、可组合的代码。在内部，我们已开始将 GPT-5 应用于 Vercel 控制台内的 Agent 功能，以及 [v0.dev/gpt-5](https://v0.dev/gpt-5)。GPT-5 在基于 Agent 的工作流中表现出色——其长上下文推理能力，以及并行调用多个工具的能力，尤其为 Vercel Agent 提供了强大支撑。

### How we're using GPT-5 in production with v0

### 我们如何在 v0 中将 GPT-5 投入生产应用

We evaluated GPT-5 as part of v0's composite model architecture, and it consistently impressed us. Its code quality matches or exceeds the best models available, and its frontend sensibilities stand out. It creates well-structured UIs from short prompts, often better than older models even with prompt tuning.

我们将 GPT-5 纳入 v0 的复合模型架构中进行评估，其表现持续令人印象深刻：代码质量达到甚至超越当前最优模型水平；其前端设计直觉尤为突出。仅凭简短提示词，GPT-5 即可生成结构清晰的 UI，效果往往优于经精细调优的老版本模型。

The smaller GPT-5 variants, mini and nano, also excel in low-latency delivery and their consistency. They’re already in use for our speed-sensitive codegen workloads, and perform well across tool calling and generation tasks.

更轻量的 GPT-5 变体（mini 和 nano）同样在低延迟交付与响应一致性方面表现卓越。它们目前已部署于对响应速度高度敏感的代码生成任务中，并在各类工具调用与内容生成任务中展现出优异性能。

To demonstrate what’s possible with GPT-5 on our AI infrastructure, we’ve built two interactive environments you can immediately get your hands on to put it to the test.

为展示 GPT-5 在我们 AI 基础设施上所能实现的能力，我们构建了两个交互式环境，您可立即上手体验并亲自验证其效果。

### See for yourself

### 亲身体验

The first, is a dedicated model playground within Gateway itself. Every model can be tested, for free, including GPT-5, and gpt-oss-20b, and gpt-oss-120b released earlier this week, with a simple chat interface that lets you put it to the test. From the same page you grab the model string, pop it into AI SDK, and begin using it with AI Gateway's higher rate limits, performance and reliability, and built-in observability.

首个环境是集成于 Gateway 内部的专属模型 Playground。所有模型（包括 GPT-5、以及本周早些时候发布的 gpt-oss-20b 和 gpt-oss-120b）均可免费试用——只需一个简洁的聊天界面，即可快速上手测试。您还可直接从该页面获取模型标识字符串（model string），将其粘贴至 AI SDK，即可借助 AI Gateway 更高的调用配额、更优的性能与可靠性，以及内置可观测性能力，立即开始使用。

[**GPT-5 Playground**\\
\\
Try GPT-5 on AI Gateway instantly, with no setup or install necessary. Open the playground and start prompting.\\
\\
Try GPT-5](https://vercel.com/gpt-5)

[**GPT-5 Playground**  
\\  
无需任何配置或安装，立即在 AI Gateway 上体验 GPT-5：打开 Playground，即刻开始输入提示词。  
\\  
立即体验 GPT-5](https://vercel.com/gpt-5)

Second, we are sharing a new open-source vibe-coding platform built on the [Vercel AI Cloud](https://vercel.com/blog/the-ai-cloud-a-unified-platform-for-ai-workloads) that uses GPT-5 and other models to generate real applications, from prompt to live preview. This platform shows what’s possible not just with GPT-5, but with our end-to-end AI infrastructure that many production AI apps rely on today.

第二，我们正在开源一款全新的、基于 [Vercel AI Cloud](https://vercel.com/blog/the-ai-cloud-a-unified-platform-for-ai-workloads) 的“氛围编程”（vibe-coding）平台。该平台利用 GPT-5 及其他大模型，从用户输入提示词（prompt）开始，自动生成真实可用的应用，并即时呈现可交互的实时预览。这一平台不仅展示了 GPT-5 的能力边界，更体现了我们端到端 AI 基础设施的强大实力——而如今，众多投入生产的 AI 应用正依赖于这套基础设施。

We’re essentially open-sourcing a v0-like app that you can clone, customize, and build on. An open-source code-generation platform, that shows the full flow: you enter a prompt, responses stream in as code is generated, and a live preview spins up in a secure sandbox.

本质上，我们开源的是一个类似 v0 的应用：你可以克隆它、按需定制，并在其基础上持续开发。这是一个开源的代码生成平台，完整呈现了端到端工作流——你输入提示词，代码便实时流式生成并返回；与此同时，一个安全沙箱环境中的实时预览页面随即启动。

[**Now open source: Vibe coding platform**\\
\\
The Vibe Coding Platform is a new open-source app that combines GPT-5 and Vercel AI infrastructure so anyone can build apps that build apps. Under the hood it uses AI SDK, AI Gateway, Vercel Functions, Sandbox, BotID, and more.\\
\\
See the Platform](https://vercel.fyi/vibe-coding-platform)

[**现已开源：Vibe 编程平台**\\
\\
Vibe 编程平台是一款全新的开源应用，融合了 GPT-5 与 Vercel AI 基础设施，让任何人都能构建“会造应用的应用”。其底层集成了 AI SDK、AI 网关（AI Gateway）、Vercel Functions、沙箱（Sandbox）、BotID 等多项技术。\\
\\
查看平台](https://vercel.fyi/vibe-coding-platform)

The model handles reasoning, file creation, dependency installation, and shell commands. Everything runs in an isolated environment that’s safe to use in production.

模型负责逻辑推理、文件创建、依赖安装及 Shell 命令执行。所有操作均在完全隔离的环境中运行，确保生产环境下的安全性。

Prompt handling is powered by [Fluid compute](https://vercel.com/fluid) on [Vercel Functions](https://vercel.com/docs/functions), with code execution handled by the sandbox. The entire stack is built for speed, security, and extensibility.

提示词处理由部署在 [Vercel Functions](https://vercel.com/docs/functions) 上的 [Fluid compute](https://vercel.com/fluid) 驱动，而代码执行则交由沙箱完成。整套技术栈专为高性能、高安全性与强可扩展性而设计。

### Building an open-source vibe coding platform with GPT-5 and Vercel AI Cloud

### 使用 GPT-5 与 Vercel AI Cloud 构建开源的 Vibe 编程平台

The vibe coding platform’s frontend is built with Next.js and AI SDK. Setup only takes a few lines of code.

Vibe 编程平台的前端基于 Next.js 与 AI SDK 构建，仅需数行代码即可完成初始化配置。

When a user submits a message, the `sendMessage` API is triggered. Both the prompt and selected model, which defaults to GPT-5, are sent to the backend. Once deployed to Vercel, the framework-defined infrastructure determines the right resources to serve the frontend quickly through the Vercel CDN and handle API calls with Vercel Functions.

当用户提交消息时，`sendMessage` API 即被触发。提示词与所选模型（默认为 GPT-5）一并发送至后端。一旦部署至 Vercel，框架预定义的基础设施将自动调度最优资源：通过 Vercel CDN 快速交付前端内容，并借助 Vercel Functions 高效处理 API 请求。

The backend is a simple function running on Fluid compute, optimized for prompt-based workloads. Since AI calls often involve idle time while the model is reasoning, Fluid compute can reallocate those cycles to serve other requests or avoid charging for unused CPU.

后端是一个运行在 Fluid compute 上的轻量函数，专为提示词驱动型工作负载优化。由于 AI 调用过程中常存在模型推理导致的空闲等待时间，Fluid compute 可动态回收这些计算周期，用于服务其他请求，或避免对未使用的 CPU 资源计费。

```tsx
const result = streamText({
```

2  model: "openai/gpt-5",

2  model: "openai/gpt-5",

3  system: prompt,

3  system: prompt,

4  messages,

4  messages,

5  stopWhen: stepCountIs(20),

5  stopWhen: stepCountIs(20),

6  tools

6  tools

7});

7});

The API call is powered by AI SDK. It receives the full message history, verifies the user with [Vercel BotID](https://vercel.com/docs/botid), and forwards the request. Specifying the model as a string automatically uses AI Gateway, which removes the need to manage separate API keys.

该 API 调用由 AI SDK 驱动。它接收完整的消息历史记录，使用 [Vercel BotID](https://vercel.com/docs/botid) 验证用户身份，并将请求转发出去。将模型指定为字符串会自动启用 AI Gateway，从而无需单独管理 API 密钥。

As responses start streaming back from the model, the code is executed inside a freshly provisioned sandbox. This environment is stateless, isolated, and expires after a short timeout. It has no access to your projects or data, making it safe to run arbitrary code.

当模型开始流式返回响应时，代码将在一个全新配置的沙箱环境中执行。该环境无状态、相互隔离，且在短暂超时后即自动失效；它无法访问您的任何项目或数据，因此可安全地执行任意代码。

The sandbox streams real-time updates back to the frontend. As commands run in the backend, the frontend reflects their progress instantly:

沙箱将实时更新流式传输回前端。当命令在后端执行时，前端会即时反映其执行进度：

```tsx
1{

2  type: "data-run-command",

2  类型："data-run-command",

3  data: {

3  数据：{

4    status: "done",

4    状态："done",

5    sandboxId: "sbx_123",

5    沙箱 ID："sbx_123",

6    command: "npm install",

6    命令："npm install",

7    commandId: "cmd_abc",

7    命令 ID："cmd_abc",

8  }

8  }

9}

9}

This approach keeps the UI responsive and transparent without waiting for the full task chain to complete.

该方法无需等待整个任务链完成，即可保持用户界面的响应性和透明性。

Finally, it's important with potentially high-value API calls to mitigate abuse with sophisticated bot protection powered by [BotID](https://vercel.com/docs/botid) and rate limiting with Vercel Firewall.

最后，对于潜在高价值的 API 调用，必须通过由 [BotID](https://vercel.com/docs/botid) 驱动的高级机器人防护机制，以及 Vercel Firewall 提供的速率限制功能，来防范滥用行为。

## Get started with GPT-5 via AI Gateway

## 通过 AI 网关快速开始使用 GPT-5

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "openai/gpt-5",

5  prompt: "why is the sky blue?"

6})
```

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "openai/gpt-5",

5  prompt: "为什么天空是蓝色的？"

6})
```

The vibe coding platform lets you compare all three GPT-5 models: main, mini, and nano. You can also evaluate models from other providers side by side.

vibe 编码平台支持您同时对比全部三种 GPT-5 模型：main、mini 和 nano；您还可以并排评估来自其他供应商的模型。

## Use v0.dev, or build your own

## 使用 v0.dev，或自行构建

[v0.dev](https://v0.dev/) now offers GPT-5 as an available model for improved UI generation, and this platform shows you how to build your own version from scratch.

[v0.dev](https://v0.dev/) 现已将 GPT-5 作为可选模型上线，以提升 UI 生成效果；本平台则向您展示如何从零开始构建属于您自己的版本。

Whether you're scaffolding backend APIs, generating infrastructure as code, or building fullstack starter kits, the system gives you a clear and repeatable pattern you can use in production.

无论您是在搭建后端 API、生成基础设施即代码（IaC），还是构建全栈入门套件，该系统都为您提供了一种清晰且可复用的模式，可直接用于生产环境。

All components, AI Gateway, AI SDK, Sandbox, and BotID are part of the Vercel AI Cloud. They are designed to work on their own or as part of a complete stack. Everything runs at the Edge and can be integrated into existing applications.

所有组件——包括 AI 网关（AI Gateway）、AI 软件开发工具包（AI SDK）、沙盒（Sandbox）和 BotID——均属于 Vercel AI Cloud。它们既可独立运行，也可组合成完整的技术栈。全部服务均在边缘（Edge）运行，并可无缝集成至现有应用程序中。

## Get started

## 快速上手

Clone the vibe coding platform, change the model, swap in your own tools, or connect it to a database. The infrastructure is in place to support it.

克隆 vibe 编程平台，更换模型、替换为您自己的工具，或将其连接至数据库——所需基础设施均已就绪，随时可用。

- [Explore the code](https://github.com/vercel/examples/tree/main/apps/vibe-coding-platform) on GitHub

- 在 GitHub 上 [浏览源代码](https://github.com/vercel/examples/tree/main/apps/vibe-coding-platform)

- Learn more about [AI Gateway](https://vercel.com/gpt-5)

- 进一步了解 [AI 网关（AI Gateway）](https://vercel.com/gpt-5)

[Vercel AI Cloud](https://vercel.com/ai) is designed for developers shaping how software is created; building with models, not just using them.

[Vercel AI Cloud](https://vercel.com/ai) 专为重塑软件开发方式的开发者而设计：它支持您“基于模型构建”，而不仅仅是“使用模型”。
&#123;% endraw %}
