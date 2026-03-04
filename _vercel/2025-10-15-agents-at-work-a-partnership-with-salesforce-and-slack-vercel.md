---
title: "Agents at work, a partnership with Salesforce and Slack - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/agents-at-work-a-partnership-with-salesforce-and-slack"
date: "2025-10-15"
scraped_at: "2026-03-02T09:26:56.023644838+00:00"
language: "en-zh"
translated: true
description: "Vercel and Salesforce are partnering to help teams build, ship, and scale AI agents across the Salesforce ecosystem, starting with Slack. "
---
&#123;% raw %}

Oct 15, 2025

2025年10月15日

Every generation of software moves interfaces closer to where people think and work. Terminals gave way to GUIs. GUIs gave way to browsers. And now, the interface is language itself. Conversation has become the most natural way to build, explore, and decide.

每一代软件都在将用户界面推向人们思考与工作的更近之处：终端让位于图形用户界面（GUI），GUI 又让位于浏览器；而如今，界面本身即是语言——对话已成为构建、探索与决策最自然的方式。

At the center of this shift is a new pattern: the AI agent. Today, software doesn’t have to wait for clicks or configuration, but understands user intent, reason about it, and takes action.

这一转变的核心是一种新模式：AI 智能体（AI agent）。如今，软件无需再等待用户点击或手动配置，而是能够理解用户意图、进行推理，并主动执行操作。

The question for enterprises isn’t _if_ they’ll adopt agents, but _where_ those agents will live. Our answer: where work already happens.

对企业而言，问题已不再是“是否采用智能体”，而是“智能体将部署在何处”。我们的答案是：就部署在工作实际发生的地方。

That’s why Vercel and Salesforce are partnering to help teams build, ship, and scale AI agents across the Salesforce ecosystem, starting with Slack. Together, we’re bringing the intelligence and flexibility of the Vercel AI Cloud to the places teams collaborate every day.

因此，Vercel 与 Salesforce 正携手合作，助力团队在 Salesforce 生态系统中构建、交付并规模化部署 AI 智能体——首站即为 Slack。双方将共同把 Vercel AI Cloud 的智能性与灵活性，带入团队每日协作的各个场景。

> “Vercel sets the bar for developer experience and agent infrastructure; Slack sets the bar for collaboration at work. This is a natural partnership as we work with more customers who want to deploy agents on Slack.Vercel sets the bar for developer experience and agent infrastructure; Slack sets the bar for collaboration at work. This is a natural partnership as we work with more customers who want to deploy agents on Slack.”
>
> “Vercel 为开发者体验与智能体基础设施树立了标杆；Slack 则为职场协作设定了行业标准。随着越来越多客户希望在 Slack 上部署智能体，此次合作水到渠成。”
>
> ![](images/agents-at-work-a-partnership-with-salesforce-and-slack-vercel/img_001.jpg)
>
> **Rob Seaman,** Chief Product Officer
>
> **罗布·西曼（Rob Seaman）**，首席产品官

### The new surface for software

### 软件的新交互界面

Slack has become the operating system for modern work. Every decision, escalation, and project update runs through its channels. It’s where teams express intent, plan, and make decisions. Historically, plans were executed in silos when the conversation ended.

Slack 已成为现代办公的操作系统：每一项决策、每一次升级处理、每一个项目进展更新，都经由其频道流转。团队在此表达意图、制定计划并作出决策。传统上，当对话结束，计划便转入各自孤立的系统中执行。

Now, with agents, that conversation is just the starting point as the agent interprets intent and takes action.

如今，借助智能体，对话本身只是起点——智能体将实时解析对话中的意图，并立即采取行动。

Agents built on Vercel AI Cloud can live directly in Slack threads. They can listen, act, and respond without breaking the flow of discussion.

基于 Vercel AI Cloud 构建的智能体可直接嵌入 Slack 对话线程中，实现倾听、执行与响应，全程不打断讨论节奏。

When a team asks for a report, an update, or a deployment, the agent can generate, fetch, or trigger it instantly. The result is a workflow that feels less like using software and more like collaboration. This shift turns the conversation itself into a living interface, to software that listens and responds as a participant.

当团队请求一份报告、一次更新或一次部署时，智能体（agent）可即时生成、获取或触发相应操作。其结果是一种工作流体验：它不再像在使用软件，而更像在协作。这一转变使对话本身成为一种“活”的交互界面——一种能够倾听并以参与者身份响应的软件。

### The agent runtime for the enterprise

### 面向企业的智能体运行时

Vercel AI Cloud combines the speed and observability of Vercel with new primitives for long-running agents, stateful sessions, and secure tool execution for production-grade, enterprise-ready systems of action.

Vercel AI Cloud 将 Vercel 的极致速度与可观测性，同面向长期运行智能体、有状态会话以及安全工具执行的新原语（primitives）相结合，构建出可用于生产环境、符合企业级要求的“行动系统”。

Developers can use frameworks like Next.js, Hono, Nitro, or Express with the AI SDK to connect models, vector stores, and tools. These frameworks can be deployed with one click, handling message routing, context persistence, and security automatically.

开发者可借助 AI SDK，将 Next.js、Hono、Nitro 或 Express 等框架与大模型、向量数据库及各类工具无缝集成。这些框架支持一键部署，自动处理消息路由、上下文持久化与安全防护。

[**Build an agent with Vercel and Slack**\\
\\
Start creating your own Slack Agent using the Bolt for JavaScript and Nitro template. Deploy it on Vercel to get a live, production-ready setup in minutes.\\
\\
Deploy the template](https://vercel.com/templates/nitro/slack-agent-template)

[**使用 Vercel 与 Slack 构建智能体**\\
\\
立即基于 JavaScript 版 Bolt 框架与 Nitro 模板，创建您专属的 Slack 智能体。在 Vercel 上一键部署，几分钟内即可获得一个实时可用、具备生产就绪能力的运行环境。\\
\\
部署该模板](https://vercel.com/templates/nitro/slack-agent-template)

### From prototype to production: the v0 Slack Agent

### 从原型到生产：v0 Slack 智能体

To show what’s possible, we're bringing our own agent to Slack, v0. A collaborative, multiplayer agent that lives directly inside Slack and built on the Vercel AI Cloud, v0 makes it possible for teams to experiment, prototype, and deploy sites, apps, and agents, all from the same conversation, and at the speed of conversation.

为展示技术潜力，我们已将自研智能体 v0 带入 Slack。这是一款协作式、支持多用户实时互动的智能体，原生嵌入 Slack，并构建于 Vercel AI Cloud 之上。借助 v0，团队可在同一场对话中快速完成网站、应用及智能体的实验、原型开发与正式部署——一切节奏皆与对话同步。

The agent is a real-time collaborator that understands the full context of your Slack workspace, while respecting permissions. By turning conversations itself into apps, v0 shows how fast teams can move when the interface becomes a natural part of the workflow.

该智能体是一位实时协作者，可深度理解您 Slack 工作区的完整上下文，同时严格遵循权限管控。通过将“对话本身”转化为应用程序，v0 展示了当交互界面自然融入工作流时，团队所能达到的惊人效率。

[**Be one of the first to use v0 in Slack**\\
\\
Try collaborative agent development in Slack. Build, test, and deploy together—powered by v0 and Vercel AI Cloud.\\
\\
Signup for Early Access](https://vercel.com/go/dreamforce-2025-waitlist)

[**首批体验 v0 Slack 智能体**\\
\\
在 Slack 中尝试协作式智能体开发：共同构建、测试与部署——由 v0 与 Vercel AI Cloud 全力驱动。\\
\\
立即登记，加入早期体验等候名单](https://vercel.com/go/dreamforce-2025-waitlist)

### Frontend extensibility

### 前端可扩展性

This new way of working doesn’t end in Slack.

这种全新的工作方式，不止于 Slack。

Over the coming months, Vercel and Salesforce will work together to innovate new ways of building with Agentforce 360 and Next.js, React, and more. The opportunity: meet customers where they are, help developers build faster, and deploy more agents with less risk.

在接下来的几个月中，Vercel 将与 Salesforce 携手合作，围绕 Agentforce 360、Next.js、React 等技术共同探索构建应用的全新方式。这一合作带来的机遇在于：在客户所处的场景中即时响应、助力开发者加速开发，并以更低风险部署更多智能体（agents）。

> “The future of enterprise software is event-driven and conversational. Together with Salesforce, we’re building the runtime for that future, where agents run on Vercel AI Cloud, interface through Slack, and connect directly to business logic in Salesforce. The future of enterprise software is event-driven and conversational. Together with Salesforce, we’re building the runtime for that future, where agents run on Vercel AI Cloud, interface through Slack, and connect directly to business logic in Salesforce. ”
>
> “企业软件的未来是事件驱动的、对话式的。我们正与 Salesforce 携手共建这一未来的运行时环境——智能体运行于 Vercel AI Cloud，通过 Slack 提供交互界面，并直接对接 Salesforce 中的业务逻辑。企业软件的未来是事件驱动的、对话式的。我们正与 Salesforce 携手共建这一未来的运行时环境——智能体运行于 Vercel AI Cloud，通过 Slack 提供交互界面，并直接对接 Salesforce 中的业务逻辑。”
>
> ![](images/agents-at-work-a-partnership-with-salesforce-and-slack-vercel/img_002.png)
>
> **Guillermo Rauch,** CEO
>
> **Guillermo Rauch**，首席执行官

With this extensibility, collaboration, context, and intelligence converge into a single experience for customers build more quickly and with more impact.

凭借这一强大的可扩展性，协作能力、上下文感知与智能能力融为一体，为客户打造统一、高效、高影响力的应用构建体验。

As software becomes conversational, the systems we use every day become more adaptive, more human, and more connected to how teams actually work. The next generation of applications won’t just run in the cloud, they’ll live in the flow of conversation.

随着软件日益走向对话式交互，我们日常使用的系统也将变得更加自适应、更富人性、更紧密贴合团队真实的工作方式。下一代应用将不再仅仅“运行于云端”，而将真正“栖身于对话流之中”。

[**Build an agent with Vercel and Slack**\\
\\
Start creating your own Slack Agent using the Bolt for JavaScript and Nitro template. Deploy it on Vercel to get a live, production-ready setup in minutes.\\
\\
Deploy the template](https://vercel.com/templates/nitro/slack-agent-template)

[**使用 Vercel 和 Slack 构建智能体**  
\\  
立即基于 Bolt for JavaScript 与 Nitro 模板，创建您专属的 Slack 智能体。一键部署至 Vercel，几分钟内即可获得可投入生产的实时环境。  
\\  
部署该模板](https://vercel.com/templates/nitro/slack-agent-template)
&#123;% endraw %}
