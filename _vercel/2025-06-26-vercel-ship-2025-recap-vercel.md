---
render_with_liquid: false
title: "Vercel Ship 2025 recap - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-ship-2025-recap"
date: "2025-06-26"
scraped_at: "2026-03-02T09:31:39.567885077+00:00"
language: "en-zh"
translated: true
description: "Vercel Ship 2025 added new building blocks for an AI era: Fast, flexible, and secure by default. Lower costs with Fluid's Active CPU pricing, Rolling Releases for safer deployments, invisible CAPTCHA ..."
---
render_with_liquid: false
render_with_liquid: false

Jun 26, 2025

2025年6月26日

Be flexible. Move fast. Stay secure.

灵活应变。快速行动。坚守安全。

My first week at Vercel coincided with something extraordinary: Vercel Ship 2025.

我加入 Vercel 的第一周，恰逢一场非同寻常的盛事：Vercel Ship 2025。

Vercel Ship 2025 showcased better building blocks for the future of app development. AI has made this more important than ever. Over 1,200 people gathered in NYC for our third annual event, to hear the latest updates in AI, compute, security, and more.

Vercel Ship 2025 展示了面向未来应用开发的更优构建模块。在人工智能（AI）迅猛发展的今天，这一使命比以往任何时候都更加重要。超过 1,200 位参会者齐聚纽约市，参加我们第三届年度盛会，共同聆听 AI、计算能力、安全性等领域的最新进展。

![Guillermo Rauch giving the Vercel Ship 2025 keynote introduction at The Glasshouse in New York City.](images/vercel-ship-2025-recap-vercel/img_001.jpg)

![Guillermo Rauch 在纽约市 The Glasshouse 会场发表 Vercel Ship 2025 主题演讲开场致辞。](images/vercel-ship-2025-recap-vercel/img_001.jpg)

Guillermo Rauch giving the Vercel Ship 2025 keynote introduction at The Glasshouse in New York City.

Guillermo Rauch 在纽约市 The Glasshouse 会场发表 Vercel Ship 2025 主题演讲开场致辞。

As AI reshapes app development, Vercel Ship highlighted tools, infrastructure, and platform enhancements to help teams stay fast, flexible, and secure. Whether building AI-powered apps or agents, integrating LLMs, or managing high-stakes production traffic, everything focuses on giving you the tools you need to build.

随着 AI 重塑应用开发范式，Vercel Ship 聚焦于工具、基础设施与平台能力的全面升级，助力团队持续保持敏捷、灵活与安全。无论您是在构建 AI 驱动的应用或智能体（agents）、集成大语言模型（LLMs），还是管理高关键性生产流量——一切努力，皆围绕为您提供真正所需的构建工具而展开。

AI is raising expectations around performance, cost, and security. Over the past decade, Vercel defined the Frontend Cloud. Now we're building the next layer with the AI Cloud. Infrastructure designed for agents the same principles that got us here: open source, developer experience, and user experience.

AI 正在不断提升业界对性能、成本与安全性的期待标准。过去十年间，Vercel 定义并引领了“前端云”（Frontend Cloud）；如今，我们正以“AI 云”（AI Cloud）构建下一代基础设施层——专为智能体（agents）而生，延续驱动我们一路走来的核心理念：开源、卓越的开发者体验（Developer Experience）与用户体感（User Experience）。

We're building for the AI-native era on Vercel. Here’s how we’re evolving the platform to make that happen.

我们正立足 Vercel，全力构建面向 AI 原生（AI-native）时代的未来。以下是我们为实现这一愿景而持续推进的平台演进方向。

[**See all the Ship 2025 announcements**\\
\\
Watch the full keynote to hear all the new features we announced.\\
\\
Watch the Keynote](https://vercel.com/ship)

[**浏览 Ship 2025 全部发布内容**\\
\\
观看完整主题演讲，了解本次发布的所有新功能。\\
\\
观看主题演讲](https://vercel.com/ship)

## **Simplifying model access with AI Gateway**

## **借助 AI 网关简化模型访问**

The [AI SDK](https://ai-sdk.dev/) simplifies AI development by unifying interaction patterns and helping developers integrate models without worrying about vendor-specific APIs. Now, we’re going further with [AI Gateway](https://vercel.com/changelog/ai-gateway-is-now-in-beta).

[AI SDK](https://ai-sdk.dev/) 通过统一交互模式，帮助开发者无缝集成各类模型，无需操心各厂商特有的 API，从而大幅简化 AI 开发流程。如今，我们更进一步推出 [AI 网关（AI Gateway）](https://vercel.com/changelog/ai-gateway-is-now-in-beta)。

AI Gateway gives you a single endpoint to access a wide range of AI models across providers, with better uptime, faster responses, and no lock-in. Switch providers with one line of code, route requests intelligently, and set up fallbacks to improve uptime.

AI 网关为您提供一个统一接入点，即可调用来自多家供应商的丰富 AI 模型，同时享有更高可用性、更低延迟响应，且完全避免厂商锁定。您只需修改一行代码即可切换模型供应商，支持智能请求路由，并可配置故障转移机制以进一步提升服务可用性。

Developers can use models from providers like OpenAI, Anthropic, Google, xAI, and more with usage-based billing at provider list prices, Bring-Your-Own-Key support, improved observability (including per-model usage and latency metrics), and simplified authentication.

开发者可便捷接入 OpenAI、Anthropic、Google、xAI 等多家供应商的模型，按实际用量计费（价格与各厂商官方标价一致），支持自带 API 密钥（Bring-Your-Own-Key），并提供更完善的可观测性能力（包括按模型维度统计的调用量与延迟指标），以及简化的身份认证流程。

As newer models are introduced, AI Gateway helps your app stay flexible, without code rewrites or infrastructure changes. But accessing models is only half the equation. Running them efficiently requires a different approach to compute.

随着新一代模型持续发布，AI 网关助您的应用保持高度灵活性——无需重写代码，也无需调整基础设施。但仅实现模型“可访问”还只完成了一半；要高效运行这些模型，则需对计算资源采用全新的调度与计费范式。

## **Smarter compute with Fluid and Active CPU pricing**

## **借助 Fluid 与 Active CPU 定价实现更智能的计算**

Traditional serverless platforms are not designed to efficiently handle I/O bound workloads like AI inference, agents, and MCP servers. They need to scale instantly, but often remain idle between operations.

传统无服务器（serverless）平台并非为高效处理 I/O 密集型工作负载（如 AI 推理、智能体（agents）、MCP 服务器等）而设计。它们虽需瞬时扩缩容，却常在任务间隙处于空闲状态。

[Fluid compute](https://vercel.com/fluid) breaks away from the one-to-one serverless model. Instead of spinning up separate instances for each invocation, Fluid intelligently orchestrates compute across invocations. Multiple concurrent requests can share the same underlying resources. Teams saw up to 85% cost savings through optimizations like in-function concurrency.

[Fluid 计算（Fluid compute）](https://vercel.com/fluid) 打破了传统“一次调用对应一个实例”的无服务器范式。它不再为每次调用单独启动新实例，而是跨调用智能编排计算资源——多个并发请求可共享同一底层资源池。借助函数内并发（in-function concurrency）等优化手段，团队最高实现了 85% 的成本节约。

Now, we’re introducing a new pricing model that builds on Fluid: [Active CPU](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute).

如今，我们在 Fluid 基础上推出全新计费模式：[Active CPU](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute)。

- **Active CPU** charges for the time your code is actually executing  
- **Active CPU** 仅对您的代码实际执行时间计费

- **Provisioned Memory** covers the time your function is waiting, charged at 1/11th the rate  

- **预置内存（Provisioned Memory）** 覆盖函数处于等待状态的时间，按常规费率的 1/11 计费。

- **Invocations** counts per function call (just like in traditional serverless)  

- **调用次数（Invocations）** 按每次函数调用计数（与传统 Serverless 模式一致）。

If your AI call takes 30s to respond, but only uses 300ms of compute, you only pay for those 300ms. The rest is covered efficiently with Fluid and memory reuse.  

如果你的 AI 调用响应耗时 30 秒，但实际仅占用 300 毫秒的计算时间，你只需为这 300 毫秒付费；其余等待时间则通过 Fluid 技术与内存复用高效覆盖。

![Fluid compute bills by execution time, not wall time.](images/vercel-ship-2025-recap-vercel/img_002.jpg)![Fluid compute bills by execution time, not wall time.](images/vercel-ship-2025-recap-vercel/img_003.jpg)![Fluid compute bills by execution time, not wall time.](images/vercel-ship-2025-recap-vercel/img_004.jpg)![Fluid compute bills by execution time, not wall time.](images/vercel-ship-2025-recap-vercel/img_005.jpg)Fluid compute bills by execution time, not wall time.  

![Fluid 计算按执行时间计费，而非挂钟时间。](images/vercel-ship-2025-recap-vercel/img_002.jpg)![Fluid 计算按执行时间计费，而非挂钟时间。](images/vercel-ship-2025-recap-vercel/img_003.jpg)![Fluid 计算按执行时间计费，而非挂钟时间。](images/vercel-ship-2025-recap-vercel/img_004.jpg)![Fluid 计算按执行时间计费，而非挂钟时间。](images/vercel-ship-2025-recap-vercel/img_005.jpg)Fluid 计算按执行时间（execution time）计费，而非挂钟时间（wall time）。

Vercel Functions using Fluid compute now have [longer execution times, more memory, and more CPU](https://vercel.com/changelog/higher-defaults-and-limits-for-vercel-functions-running-fluid-compute). The default execution time for all projects is now 300s, up from 60s-90s previously.  

采用 Fluid 计算的 Vercel Functions 现已支持[更长的执行时间、更大的内存容量和更强的 CPU 性能](https://vercel.com/changelog/higher-defaults-and-limits-for-vercel-functions-running-fluid-compute)。所有项目的默认执行时间现已提升至 300 秒，此前为 60–90 秒。

This is modern compute pricing for the AI era. Fine-grained, usage-based, and optimized for inference. Infrastructure that is ideal for your backend and API code.  

这是面向 AI 时代的现代计算定价模型：粒度精细、按需计费，并针对推理（inference）场景深度优化。该基础设施完美适配你的后端服务与 API 代码。

## **Run untrusted code with Vercel Sandbox**  

## **使用 Vercel Sandbox 安全运行不可信代码**

With AI agents generating executable code, you need a way to safely run that code you didn't write, without compromising your infrastructure. That’s why we’re introducing [Vercel Sandbox](https://vercel.com/changelog/run-untrusted-code-with-vercel-sandbox).  

随着 AI 智能体不断生成可执行代码，你需要一种安全运行他人编写代码的方式，同时不危及自身基础设施。为此，我们正式推出 [Vercel Sandbox](https://vercel.com/changelog/run-untrusted-code-with-vercel-sandbox)。

Sandbox is an isolated, ephemeral execution environment for untrusted code. It supports Node.js and Python, scales to hundreds of concurrent environments, and lets developers stream logs, install dependencies, and control runtime behavior in a secure container.  

Sandbox 是一个隔离、临时的执行环境，专为运行不可信代码而设计。它支持 Node.js 和 Python，可横向扩展至数百个并发环境，并允许开发者在安全容器中实时流式传输日志、安装依赖项，以及控制运行时行为。

These environments are isolated microVMs supporting execution times up to 45 minutes. Sandbox is a standalone SDK that works anywhere, including non-Vercel platforms, and uses Fluid's Active CPU pricing.  

这些环境基于隔离的微虚拟机（microVM），单次执行最长支持 45 分钟。Sandbox 是一套独立的 SDK，可在任意平台（包括非 Vercel 平台）运行，并采用 Fluid 的“活跃 CPU”（Active CPU）计价模式。

We built it for ourselves while working on [v0](https://v0.dev/), and now it’s available to you.

我们是在开发 [v0](https://v0.dev/) 的过程中为自己构建的，现在它已向您开放。

```javascript
import { Sandbox } from "@vercel/sandbox";

import { generateText } from 'ai';



const result = await generateText({

5    model: "anthropic/claude-4-sonnet-20250514",

6    prompt: `Write a Node.js script that prints a Haiku poem to stdout.`,

7    system: `

8      You are a developer that responds with the content of a single Node.js script.

9      You must include only the code without any markdown, nothing else.
```

```javascript
import { Sandbox } from "@vercel/sandbox";

import { generateText } from 'ai';



const result = await generateText({

5    model: "anthropic/claude-4-sonnet-20250514",

6    prompt: `编写一个 Node.js 脚本，将一首俳句诗打印到标准输出（stdout）。`,

7    system: `

8      你是一位开发者，仅以单个 Node.js 脚本的内容作为响应。

9      你必须只包含代码，不使用任何 Markdown 格式，其他内容一概不要。`

10      Just include Javascript code and no characters before or after the code.

10      仅包含 JavaScript 代码，代码前后不要有任何字符。

11    `,

11    `,

12  });

12  });

14  const sandbox = await Sandbox.create();

14  const sandbox = await Sandbox.create();

16  await sandbox.writeFiles([\
\
17    { path: "script.js", stream: Buffer.from(result.text) },\
\
18  ]);

16  await sandbox.writeFiles([\
\
17    { path: "script.js", stream: Buffer.from(result.text) },\
\
18  ]);

20  await sandbox.runCommand({

20  await sandbox.runCommand({

21    cmd: "node",

21    cmd: "node",

22    args: ["script.js"],

22    参数：["script.js"]，

23    stdout: process.stdout,

23    标准输出：process.stdout，

24    stderr: process.stderr,

24    标准错误：process.stderr，

25  });
```

An example of using Vercel Sandbox to run generated code.

使用 Vercel Sandbox 运行生成代码的示例。

Once you're running code safely, the next challenge is deploying it safely.

一旦你已安全地运行代码，下一个挑战便是安全地部署它。

## **Rolling Releases for safer deployments**

## **滚动发布：实现更安全的部署**

Speed is more than code or compute performance. It’s about shipping with confidence.

速度不仅关乎代码或计算性能，更在于以信心交付产品。

[Rolling Releases](https://vercel.com/changelog/rolling-releases-are-now-generally-available) allow safe, incremental rollouts of new deployments to a subset of users with built-in monitoring, rollout controls, and no custom routing required. If metrics like Time to First Byte (TTFB) degrade or errors spike, the rollout can be paused or aborted entirely.

[滚动发布（Rolling Releases）](https://vercel.com/changelog/rolling-releases-are-now-generally-available) 支持将新部署安全、渐进地推送给部分用户，内置监控与发布控制机制，且无需自定义路由。若首字节时间（TTFB）等指标出现劣化，或错误率激增，即可随时暂停或彻底中止发布。

You configure rollout stages per project and decide how each stage progresses. Updates propagate globally in under 300ms through our fast propagation pipeline. Each rollout includes real-time monitoring to compare error rates and Speed Insights between versions, plus flexible controls via REST API, CLI, dashboard, or Terraform.

你可以为每个项目配置发布阶段，并自主决定各阶段的推进方式。更新通过我们高速传播管道在全球范围内同步，耗时低于 300 毫秒。每次发布均包含实时监控功能，可对比不同版本间的错误率与 Speed Insights（速度洞察），并支持通过 REST API、命令行工具（CLI）、控制台仪表板或 Terraform 灵活调控。

![](images/vercel-ship-2025-recap-vercel/img_006.jpg)![](images/vercel-ship-2025-recap-vercel/img_007.jpg)

它是一道内建的安全网，在不增加风险的前提下，持续保障你的开发速度。对于管理多个应用的大型团队而言，对各应用进行独立部署控制变得尤为关键。

## **面向团队自主性的微前端（Microfrontends）**

大型团队既需要速度，也同样需要自主权。[Vercel 微前端（Microfrontends）](https://vercel.com/changelog/vercel-microfrontends-is-now-in-limited-beta) 使你能够将大型应用拆分为更小、可独立部署的单元。每个团队均可基于自身技术栈完成构建、测试与部署，而 Vercel 则负责统一处理集成与路由。

这种方式通过更小的单元加速开发进程，并显著缩短构建时间；各团队拥有彼此独立的工作流，还可按需分阶段迁移，逐步以模块化方式现代化遗留系统。从基础设施到用户界面，所有内容均在 Vercel 控制台中实现统一管理，让开发者即使在处理相互隔离的应用时，也能获得完整上下文。

随着团队交付节奏加快、部署频率提升，安全性已成为首要关注点。

## 借助 BotID 实现无感机器人识别

我们构建了 [Bot 管理（Bot Management）](https://vercel.com/docs/bot-management) 套件，用以抵御各类自动化滥用行为——从高频爬虫到隐蔽的凭据填充（credential stuffing）攻击。但如今高度进化的恶意机器人已不再“形似机器人”：它们能执行 JavaScript、自动破解验证码（CAPTCHA），并像真实用户一样操作浏览器。仅依赖请求头校验或速率限制等传统防御手段，往往已力不从心。

为此，我们联合 [Kasada](https://www.kasada.io/) 推出 [Vercel BotID](https://vercel.com/blog/introducing-botid)，进一步扩展防护覆盖范围。BotID 是一种“无感式验证码”，专为保护关键路径而设计，例如结算页（checkout）、登录页、注册页、API 接口，以及会触发高成本后端调用的操作（如由大语言模型驱动的端点）。

BotID 注入轻量级、混淆加密的客户端代码，该代码每次页面加载均动态演化，有效抵御重放攻击、篡改及静态分析。其后台执行深度信号分析，全程无需用户交互——再无须点击交通灯式验证码。

```tsx
import { checkBotId } from "botid/server";

```tsx
导入 { checkBotId } 模块来自 "botid/server"；

export async function POST(req: Request) {

export async function POST(req: Request) {

4  const { isBot } = await checkBotId();

4  const { isBot } = await checkBotId();

6  if (isBot) {

6  如果 (isBot) {

7    return new Response("Access Denied", { status: 403 });

7    返回 new Response("访问被拒绝", { status: 403 });

8  }

8  }

10  const result = await expensiveOrCriticalOperation();

10  const result = await expensiveOrCriticalOperation();
```

12  return new Response("Success!");

12  返回新的响应：“Success!”（成功！）

13}
```

13}
```

Setup is simple with no config files or tuning required. Install the package, setup rewrites, mount the client, and verify requests server-side.

配置非常简单，无需任何配置文件或调优。只需安装软件包、设置重写规则、挂载客户端，并在服务端验证请求。

BotID traffic appears in the Firewall dashboard with filtering by verdict, user agent, country, and IP address.

BotID 流量会显示在防火墙仪表板中，支持按判定结果（verdict）、用户代理（user agent）、国家/地区和 IP 地址进行筛选。

Beyond preventing attacks, visibility into your applications becomes important as they grow in complexity. It's a top priority to make BotID available to everyone, even if you don't host on Vercel.

除了防范攻击之外，随着应用复杂度不断提升，对应用运行状态的可观测性也日益重要。让 BotID 惠及所有开发者——无论您是否将应用托管在 Vercel 上——是我们当前的首要任务。

## Meet Vercel Agent: AI that investigates so you don't have to

## 认识 Vercel Agent：替您开展调查的 AI 助手

[Vercel Agent](https://vercel.com/changelog/vercel-agent-now-in-limited-beta) is an AI assistant built into the Vercel dashboard that analyzes your app performance and security data.

[Vercel Agent](https://vercel.com/changelog/vercel-agent-now-in-limited-beta) 是深度集成于 Vercel 仪表板的一款 AI 助手，可分析您的应用性能与安全数据。

Agent focuses on Observability. It summarizes anomalies, identifies likely causes, and recommends specific actions. These actions can span across the platform, including managing firewall rules in response to traffic spikes or geographic anomalies, and identifying optimization opportunities within your app.

Agent 的核心聚焦于可观测性（Observability）：它自动汇总异常事件、识别潜在成因，并推荐具体可行的操作建议。这些建议覆盖平台多个层面，例如：针对流量激增或地域性异常动态调整防火墙规则，或在您的应用内部发现性能优化机会。

![Insights appear contextually as detailed notebooks with no configuration required.](images/vercel-ship-2025-recap-vercel/img_008.jpg)![Insights appear contextually as detailed notebooks with no configuration required.](images/vercel-ship-2025-recap-vercel/img_009.jpg)

![洞察信息以详尽的笔记本形式上下文化呈现，且无需任何配置。](images/vercel-ship-2025-recap-vercel/img_008.jpg)![洞察信息以详尽的笔记本形式上下文化呈现，且无需任何配置。](images/vercel-ship-2025-recap-vercel/img_009.jpg)

Insights appear contextually as detailed notebooks with no configuration required.

洞察信息以详尽的 Notebook 形式上下文化呈现，无需任何配置。

## Offload work to the background with Vercel Queues

## 使用 Vercel Queues 将任务卸载至后台

[Vercel Queues](https://vercel.com/changelog/vercel-queues-is-now-in-limited-beta) 允许您将工作卸载至后台执行，从而确保耗时较长或运行时间较久的任务得以顺利完成。这意味着用户在发起请求时无需等待缓慢操作完成，同时您的应用也能更可靠地处理重试与失败场景。

```tsx
import { send, receive } from "@vercel/queue";

await send("topic", { message: "Hello World!" });

await receive("topic", "consumer", (m) => {
  console.log(m.message); // Logs "Hello World!"
});
```

An example of sending and receiving message with a queue.

一个通过队列发送和接收消息的示例。

It's good for background jobs like AI video processing, sending emails, or updating external services. It uses an append-only log to store messages and ensures tasks are persisted and never lost.

它非常适合处理后台任务，例如 AI 视频处理、发送电子邮件或更新外部服务。它采用仅追加日志（append-only log）来存储消息，确保任务持久化且永不丢失。

## The foundation for AI Cloud development

## AI 云开发的基础架构

This is the future of the Vercel platform. It’s already the foundation for some of the most ambitions platforms in production today. It’s not only powering AI apps. It’s also powering the act of building those apps with AI. A platform for both developers and AI agents. It's brings together everything we've built.

这是 Vercel 平台的未来。它目前已是当今一些最具雄心的生产级平台的基础架构。它不仅为 AI 应用提供动力，更在赋能“利用 AI 构建这些应用”的整个过程。这是一个面向开发者与 AI 智能体的统一平台，汇聚了我们迄今所构建的一切。

The shift from Frontend Cloud to AI Cloud represents more than new features. It's the next evolution toward software that thinks, plans, and adapts. Fast, flexible, and secure by default.

从前端云（Frontend Cloud）迈向 AI 云，远不止新增功能那么简单；它标志着软件向具备思考、规划与自适应能力的方向迈出的下一代演进。默认即快速、灵活且安全。

Thanks for joining us at Ship 2025. Stay tuned for recordings of the keynotes, customer panels, sessions, and workshops coming soon. See you next year.

感谢您参与 Ship 2025！主题演讲、客户圆桌论坛、技术分会场及工作坊的录制视频即将上线，敬请期待。明年见！

[**Let us know how we can help**\\
\\
Whether you're starting a migration, need help optimizing, or want to add AI to your apps and workflows, we're here to partner with you.\\
\\
Contact Us](https://vercel.com/contact/sales)

[**告诉我们如何为您提供帮助**\\
\\
无论您正启动迁移项目、需要性能优化支持，还是希望为您的应用与工作流集成 AI 能力，我们都愿与您携手合作。\\
\\
联系我们](https://vercel.com/contact/sales)