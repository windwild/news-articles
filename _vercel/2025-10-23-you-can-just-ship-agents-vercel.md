---
title: "You can just ship agents - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/you-can-just-ship-agents"
date: "2025-10-23"
scraped_at: "2026-03-02T09:26:39.224613387+00:00"
language: "en-zh"
translated: true
description: "Vercel AI Cloud combines unified model routing and failover, elastic cost-efficient compute that only bills for active CPU time, isolated execution for untrusted code, and workflow durability that sur..."
---
&#123;% raw %}

Oct 23, 2025

2025年10月23日

Building agents should feel like shaping an idea rather than fighting a maze of code or infrastructure.

构建智能体（agents）应当如同雕琢一个想法，而非在代码与基础设施的迷宫中苦苦挣扎。

And we've seen this story before. A decade ago, the web moved from hand‑rolled routing and homegrown build scripts to opinionated frameworks and a platform that understood what developers were trying to do. Velocity went up, quality followed, and a generation of products appeared as if overnight.

我们此前已见证过类似的故事。十年前，Web 开发从手工编写的路由逻辑和自研构建脚本，转向了具有明确设计哲学的框架，以及一个真正理解开发者意图的平台。开发速度大幅提升，质量随之提升，一代产品仿佛一夜之间涌现。

AI is following the same arc, but the stakes and surface area are larger because what you build is no longer a set of pages. It is a system that intelligently reasons, plans, and acts.

AI 正沿着同样的发展轨迹演进，但其影响范围更广、责任更重——因为你所构建的，已不再是一组网页，而是一个能智能推理、规划与执行的系统。

Built on the foundations of Framework-defined Infrastructure, [Vercel AI Cloud](https://vercel.com/blog/the-ai-cloud-a-unified-platform-for-ai-workloads) provides the tooling, infrastructure primitives, developer experience, and platform to bypass the complexity. You focus entirely on what you're building, with confidence in what's powering it under the hood.

基于“框架定义基础设施”（Framework-defined Infrastructure）这一理念，[Vercel AI Cloud](https://vercel.com/blog/the-ai-cloud-a-unified-platform-for-ai-workloads) 提供了完备的工具链、底层基础设施原语、卓越的开发者体验及统一平台，助你绕过复杂性。你只需全神贯注于构建本身，而对其背后强大、可靠的支撑能力充满信心。

## From single model calls to real workflows

## 从单次模型调用，迈向真实工作流

![How an agent reasons, plans, and acts to produce an output.](images/you-can-just-ship-agents-vercel/img_001.jpg)![How an agent reasons, plans, and acts to produce an output.](images/you-can-just-ship-agents-vercel/img_002.jpg)![How an agent reasons, plans, and acts to produce an output.](images/you-can-just-ship-agents-vercel/img_003.jpg)![How an agent reasons, plans, and acts to produce an output.](images/you-can-just-ship-agents-vercel/img_004.jpg)How an agent reasons, plans, and acts to produce an output.

![智能体如何推理、规划并执行以生成输出。](images/you-can-just-ship-agents-vercel/img_001.jpg)![智能体如何推理、规划并执行以生成输出。](images/you-can-just-ship-agents-vercel/img_002.jpg)![智能体如何推理、规划并执行以生成输出。](images/you-can-just-ship-agents-vercel/img_003.jpg)![智能体如何推理、规划并执行以生成输出。](images/you-can-just-ship-agents-vercel/img_004.jpg)智能体如何推理、规划并执行以生成输出。

The earliest AI features were simple.

最早的 AI 功能十分简单。

You picked a provider, called their API, streamed a response, and stitched the result into your app. But that simplicity did not last.

你选择一家服务商，调用其 API，流式接收响应，并将结果嵌入你的应用。但这种简单性并未持续太久。

Real products need to swap between models, call multiple providers at once, handle rate limits and outages, and reconcile billing and observability across a growing catalog of services. Most importantly, the logic itself evolves from a one‑off prediction into a loop that thinks over time, pulls in context, chooses tools, and tries again when it is not satisfied with the answer.

真正的产品需要在不同模型间灵活切换，同时调用多家服务商，应对速率限制与服务中断，并在日益扩大的服务目录中统一管理计费与可观测性。最重要的是，其核心逻辑本身已从一次性的预测，演变为一个随时间持续思考的闭环：动态引入上下文、自主选择工具，并在对答案不满意时主动重试。

This is why we created [AI SDK](https://ai-sdk.dev/). We were building [v0](https://v0.app/), a production AI platform at scale that pushes any single provider to its limits and needed to be agile, with resiliency.

这正是我们创建 [AI SDK](https://ai-sdk.dev/) 的原因。当时我们正在构建 [v0](https://v0.app/) —— 一个大规模运行的生产级 AI 平台，它将任一单一服务商的能力推向极限，同时要求具备敏捷性与韧性。

AI SDK provides a single TypeScript surface for defining agent logic, connecting tools, and switching among providers with minimal code changes. You get end-to-end type safety, a predictable agent loop, and an interface that stays stable even as the model landscape changes.

AI SDK 提供统一的 TypeScript 接口，用于定义智能体（agent）逻辑、连接工具，并在不同服务商之间切换——仅需极少代码改动。你将获得端到端的类型安全、可预测的智能体执行循环，以及一个即使模型生态持续演进也保持稳定的接口。

It's currently the 2nd most popular JS/TS package for AI programming, behind OpenAI's, and it's the way our own teams ship agents. It exists so you can concentrate on outcomes rather than the mechanics of calling models. Over 3 million developers download it weekly from npm.

目前，它是仅次于 OpenAI 官方 SDK 的第二大 JavaScript/TypeScript AI 编程包；也是我们内部团队发布智能体所采用的标准方式。它的存在，是为了让你专注于结果，而非调用模型的底层细节。每周有超过 300 万开发者从 npm 下载它。

## The platform that runs it in production

## 用于生产环境部署的平台

![Architecture of an agent powered by Vercel AI Cloud.](images/you-can-just-ship-agents-vercel/img_005.jpg)![Architecture of an agent powered by Vercel AI Cloud.](images/you-can-just-ship-agents-vercel/img_006.jpg)![Architecture of an agent powered by Vercel AI Cloud.](images/you-can-just-ship-agents-vercel/img_007.jpg)![Architecture of an agent powered by Vercel AI Cloud.](images/you-can-just-ship-agents-vercel/img_008.jpg)Architecture of an agent powered by Vercel AI Cloud.

![由 Vercel AI Cloud 驱动的智能体架构图。](images/you-can-just-ship-agents-vercel/img_005.jpg)![由 Vercel AI Cloud 驱动的智能体架构图。](images/you-can-just-ship-agents-vercel/img_006.jpg)![由 Vercel AI Cloud 驱动的智能体架构图。](images/you-can-just-ship-agents-vercel/img_007.jpg)![由 Vercel AI Cloud 驱动的智能体架构图。](images/you-can-just-ship-agents-vercel/img_008.jpg)由 Vercel AI Cloud 驱动的智能体架构图。

Agents need a home that treats reliability and cost as first-class concerns.

智能体需要一个“家园”，在那里，可靠性与成本被视作头等要务。

The Vercel AI Cloud is that home, bringing together model routing, elastic compute, isolated execution, and workflow durability. Each piece is simple yet powerful on its own, and together they remove the usual tradeoff between speed, safety, and confidence.

Vercel AI Cloud 正是这样一个家园：它整合了模型路由（model routing）、弹性计算（elastic compute）、隔离执行（isolated execution）与工作流持久性（workflow durability）。每个组件本身都简洁而强大；组合起来，则彻底消除了传统方案中速度、安全性与确定性之间常见的取舍困境。

- [AI Gateway](https://vercel.com/ai-gateway) gives you one key for many models and providers, with automatic failover and clear visibility into latency and usage

- [AI 网关（AI Gateway）](https://vercel.com/ai-gateway) 为你提供一套密钥，即可接入多种模型与服务商，并支持自动故障转移，同时清晰呈现延迟与用量数据。

- [Fluid compute](https://vercel.com/fluid) scales up quickly when your agent is thinking, then scales to zero when it waits for a response, so [you only pay for active CPU time](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute)

- [弹性计算（Fluid compute）](https://vercel.com/fluid) 在智能体进行推理（thinking）时快速扩容，而在等待响应时自动缩容至零，因此你[仅需为实际占用的 CPU 时间付费](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute)。

- [Sandbox](https://vercel.com/changelog/run-untrusted-code-with-vercel-sandbox) executes generated or untrusted code in microVMs that are fast to start and safe to run

- [沙箱（Sandbox）](https://vercel.com/changelog/run-untrusted-code-with-vercel-sandbox) 在启动迅速、运行安全的微虚拟机（microVM）中执行生成代码或不受信任的代码。

- [Workflow](https://useworkflow.dev/) 工具将可靠性转化为可通过代码表达的东西，而非一堆调度器与队列交织而成的复杂系统。

## What to build: productivity that compounds

## 要构建什么：呈复利式增长的生产力

最显著的短期收益，来自于移除那些拖慢团队进度的任务。生产力智能体（productivity agents）并不会取代人类判断，而是为判断扫清障碍、铺平跑道。

我们意识到的一点是：只要为团队提供合适的工具，他们就会自主构建所需功能，以减少重复性工作，从而将精力聚焦于真正想做的事情上。

在 Vercel 内部，我们采用了一个简单流程来识别最适合自动化的任务。我们向每个团队提问：工作中最不喜欢哪一部分？哪一个重复性任务，你希望永远不必再做一次？这些回答直接对应到如今已上线并切实节省时间的各类智能体。

我们的客户体验团队构建了一个支持智能体（support agent），使工单数量减少了三分之一。该智能体可即时解决工单，或从我们的文档中精准提取并返回正确答案。

支持智能体实时解决客户问题。

我们的安全团队构建了一个滥用检测智能体（abuse platform agent），它能自动接收潜在侵权或高风险 URL，执行视觉分析，理解网页意图，并返回推荐操作方案。

滥用检测智能体对高风险 URL 进行分析并提出处置建议。

我们的内容团队构建了一个内容智能体（content agent）。许多内容创意最初都诞生于 Slack 群组讨论中。如今，我们只需在相关讨论线程中提及该内容智能体，它便会基于该线程自动生成一篇初稿博客——自动化完成背景信息收集阶段，大幅缩短从灵感到成文的路径，让你无需面对空白页面，即可快速将想法构建成一篇完整的博客文章。

Content agent turning Slack ideas into publishable drafts.

内容代理将 Slack 中的创意转化为可发布的初稿。

The shared pattern is time returned to the team. You shorten the path from idea to artifact, reduce waiting on busywork, and convert parallel effort into compounding progress.

其共通模式是——将时间归还给团队。您缩短了从创意到成果的路径，减少了因琐事而产生的等待，并将并行工作转化为复利式进展。

The gain is more than just speed. It increases the number of bets your team can place, the surface area of experiments you can run, and the bandwidth you recover for deeper thinking.

这种提升远不止于速度。它增加了团队可尝试的“押注”数量、可开展实验的广度，以及为深度思考所腾出的认知带宽。

### Quality that rises with every iteration

### 质量随每次迭代持续提升

Productivity gains without quality is just noise. The second pillar is agents that raise the floor for correctness, security, and polish.

缺乏质量保障的效率提升只是噪音。第二根支柱，是能提升正确性、安全性与完成度下限的智能代理。

Quality agents help concentrate judgment, not try to eliminate it.

质量型代理旨在聚焦人类判断力，而非试图取代它。

By standardizing the checks that are easy to miss when people are tired or rushed, they reserve human time for decisions that shape the product and the business. Over time, the bar rises because the system learns from what your team accepts, edits, or rejects.

通过将那些人在疲惫或匆忙时容易忽略的检查项标准化，它们把宝贵的人力时间留给真正塑造产品与业务的关键决策。久而久之，质量基准线自然抬升——因为系统会持续从团队接受、修改或拒绝的内容中学习。

Each agent started small, then grew in scope as trust increased. The reason that growth felt safe is the foundation. AI SDK gives a single surface for reasoning and tooling, and AI Cloud provides reliability and scale without extra work. You write the logic once and it grows from a successful one-off project into a durable part of daily operations.

每个代理均从小处起步，随着信任加深逐步拓展能力边界。这种渐进式增长之所以令人安心，源于坚实的基础：AI SDK 提供统一的推理与工具调用接口；AI Cloud 则在无需额外投入的前提下，保障系统可靠性与可扩展性。您只需编写一次逻辑，即可将其从一次成功的独立项目，演进为日常运营中稳定可靠的一环。

## A reliable backbone for long-running work

## 支撑长期运行任务的可靠基石

![](images/you-can-just-ship-agents-vercel/img_009.jpg)![](images/you-can-just-ship-agents-vercel/img_010.jpg)![](images/you-can-just-ship-agents-vercel/img_011.jpg)![](images/you-can-just-ship-agents-vercel/img_012.jpg)

Agents that plan and act over time need durability.  
需要长期规划与执行的智能体（Agents）必须具备持久性（durability）。

Work often pauses for human approval or an external event, then resumes hours or days later.  
工作流程常常因需人工审批或等待外部事件而暂停，数小时乃至数天后才继续执行。

Traditional approaches require you to wire timers, queues, and state storage by hand, which leads to complex control flow and hard‑to‑debug edge cases.  
传统方案要求开发者手动集成定时器、消息队列和状态存储，导致控制流复杂、边界情况难以调试。

Today we released [Workflow Development Kit](https://useworkflow.dev/).  
今天我们正式发布 [Workflow Development Kit（工作流开发工具包）](https://useworkflow.dev/)。

It lets you express durability directly in TypeScript.  
它允许你直接使用 TypeScript 声明式地表达持久性逻辑。

Mark boundaries that should persist and define how steps should retry or fail in a controlled way.  
你可以标记需要持久化的执行边界，并以可控方式定义各步骤的重试策略或失败处理机制。

Behind the scenes, when deployed to Vercel, the workflow persists progress at each step.  
在后台，当工作流部署至 Vercel 时，系统会在每一步自动保存执行进度。

It can resume after a crash or deploy, and it exposes traces so you can see what happened at each step.  
即使遭遇崩溃或重新部署，工作流也能从中断处恢复；同时提供完整执行轨迹（traces），让你清晰掌握每一步发生了什么。

You keep the clarity of async code while gaining the resilience of a production orchestrator.  
你既能保有异步代码的简洁可读性，又能获得生产级编排器（orchestrator）级别的容错与韧性。

## A clear path to your first agent

## 迈向首个智能体的清晰路径

If you are deciding where to begin, start with an interview loop:  
如果你正犹豫从何处入手，建议先开展一轮访谈循环（interview loop）：

- Talk to support, sales, finance, operations, marketing, and engineering  
  - 与客服、销售、财务、运营、市场及工程团队交流  

- Listen for the ten- to fifteen-minute tasks that happen dozens of times a day, or the one hour tasks that block follow‑through on important work  
  - 留意那些每天重复数十次、耗时约 10–15 分钟的任务，或那些耗时约一小时、却阻碍关键工作持续推进的瓶颈任务  

- Pick a candidate where the inputs and guardrails are clear, the output can be reviewed before it goes live, and the value of saving time is easy to measure  
  - 选择一个输入明确、约束条件（guardrails）清晰的候选场景：其输出可在上线前人工审核，且节省的时间价值易于量化  

- Use a template as a starting point, connect one or two tools, run it with a small group, and let their edits teach the system how to do better next time  
  - 以模板为起点，接入一至两个工具，在小范围内试运行，并让使用者的反馈与修改持续“训练”系统，使其下次表现更优  

With that first success in place, you will see the next two or three opportunities immediately.  
一旦实现首个成功案例，你将立刻识别出后续两到三个高潜力机会。

The playbook repeats and the returns stack.  
这套方法论可不断复用，而收益也将持续叠加。

## Build or buy without friction

## 无缝构建或采购

Many teams will start by adopting a proven agent instead of building one from scratch. Whether you buy or build, look for the same things: productivity gains and quality.

许多团队将首先选择采用一个经过验证的智能体（agent），而非从零开始自行构建。无论你是采购还是自研，都应关注相同的核心指标：生产力提升与输出质量。

That is why we are introducing an [agentic marketplace](https://vercel.com/marketplace/category/agents) where you can discover and run production‑ready agents that connect to your projects securely and extend through tools.

因此，我们推出了一个 [智能体市场（Agentic Marketplace）](https://vercel.com/marketplace/category/agents)，让你能够发现并直接运行开箱即用、可投入生产的智能体——它们可安全接入你的项目，并通过工具链灵活扩展。

![Agentic marketplace for finding and running AI agents securely.](images/you-can-just-ship-agents-vercel/img_013.jpg)![Agentic marketplace for finding and running AI agents securely.](images/you-can-just-ship-agents-vercel/img_014.jpg)Agentic marketplace for finding and running AI agents securely.

![用于安全查找与运行 AI 智能体的智能体市场。](images/you-can-just-ship-agents-vercel/img_013.jpg)![用于安全查找与运行 AI 智能体的智能体市场。](images/you-can-just-ship-agents-vercel/img_014.jpg)用于安全查找与运行 AI 智能体的智能体市场。

With the new agentic marketplace, you can install an agent in the dashboard, configure the access it needs, and run it on the same platform that powers your applications. When you reach the point where custom logic will create outsized value, pick up the SDK and shape the agent to your workflows.

借助全新的智能体市场，你只需在控制台中一键安装智能体，配置其所需访问权限，即可在支撑你全部应用的同一平台上直接运行它。当你进入需要定制逻辑以释放显著业务价值的阶段时，便可启用 SDK，按自身工作流深度定制智能体行为。

Some general guidance: buy when standard is enough and build when differentiation matters. The platform supports both paths.

一些通用建议：当标准化方案已足够满足需求时，优先采购；当差异化能力成为关键竞争力时，则着手自研。本平台全面支持这两种路径。

## The next era

## 下一个时代

Agents will become part of every product the way frontends did. The teams that benefit first will be the ones who pair fast iteration with a platform that keeps promises about correctness, security, and total cost. The combination of AI SDK and Vercel AI Cloud gives you that platform. It is a simple surface for complex work, and it is ready when you are.

正如前端（frontend）已成为每个产品的标配一样，智能体也将融入每一款产品之中。率先受益的团队，将是那些既能快速迭代、又能依托一个切实兑现“正确性、安全性与总体成本”承诺的平台开展工作的团队。AI SDK 与 Vercel AI Cloud 的深度融合，正为你提供这样一套平台——它以极简的接口承载复杂任务，且已整装待发，随时可用。

If you are ready to explore what an agent could do for your team, start with a [template](https://vercel.com/templates?type=ai), adapt it to your workflow, and deploy it on the same infrastructure that serves your customers every day. When you are ready to go deeper, the [marketplace](https://vercel.com/marketplace/category/agents), the [SDK](https://ai-sdk.dev/), and the [cloud](https://vercel.com/blog/the-ai-cloud-a-unified-platform-for-ai-workloads) will meet you where you are and scale with you as you grow.

如果你已准备好探索智能体能为你的团队带来哪些价值，不妨从一个 [模板](https://vercel.com/templates?type=ai) 入手，按需适配你的工作流，并将其部署在每日服务你客户的同一套基础设施之上。当你希望进一步深入时，[智能体市场（Marketplace）](https://vercel.com/marketplace/category/agents)、[AI SDK](https://ai-sdk.dev/) 和 [AI Cloud](https://vercel.com/blog/the-ai-cloud-a-unified-platform-for-ai-workloads) 将在你当前所处的位置与你相遇，并随你的业务成长而持续扩展。
&#123;% endraw %}
