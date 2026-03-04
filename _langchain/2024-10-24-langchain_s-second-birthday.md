---
title: "LangChain's Second Birthday"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-second-birthday/"
date: "2024-10-24"
scraped_at: "2026-03-03T07:51:04.160600787+00:00"
language: "en-zh"
translated: true
description: "Reflections on how LangChain has evolved — including our products, ecosystem, and community — over the past two years, and where we're headed next."
tags: ["Harrison Chase", "![What is an AI agent?", "**What is an AI agent?**"]
---
&#123;% raw %}

Today marks two years since the `langchain` Python package was released into the wild. Two years is both a long and short amount of time. On one hand, it still feels very early in our collective journey to build applications with LLMs. Yet, so much has also changed in that time. With the rapid pace of change in the industry, we’ve mostly been heads-down building. But on the second anniversary of our first release, we want to take stock and reflect on how `langchain` has evolved and where we’re headed next.

今天标志着 `langchain` Python 包正式发布已满两年。两年，既是一段漫长的时光，又显得转瞬即逝。一方面，我们共同探索如何利用大语言模型（LLM）构建应用的旅程，仍处于非常早期的阶段；但另一方面，这两年间，变化又如此之巨。在行业技术飞速演进的节奏下，我们大多埋头于开发工作。值此首个版本发布两周年之际，我们希望驻足回望，梳理 `langchain` 的发展历程，并展望未来方向。

## New tooling, same mission: Enabling applications that can reason

## 新工具，老使命：赋能具备推理能力的应用

The original tagline of `langchain` was to “connect LLMs to external sources of computation and data”. This predated the term “agent”, but that’s essentially what the 1-liner described. Our mission from the beginning has been consistent: We want to make it as easy as possible to build context-aware, agentic applications.

`langchain` 最初的标语是“将大语言模型（LLM）连接至外部计算与数据源”。这一提法甚至早于“智能体（agent）”概念的普及，但那句简洁的标语，本质上描述的正是如今所称的“智能体”。自创立之初，我们的使命始终如一：让开发者能够以最便捷的方式，构建具备上下文感知能力与自主行为能力（agentic）的应用。

However, what **has** changed is the tooling we offer to accomplish that mission. First and foremost, what started as `langchain` , the Python/JS open source library, has evolved into LangChain, the company! While `langchain` remains our most popular product, we've expanded with two additional key products — [LangGraph](https://langchain.com/langgraph?ref=blog.langchain.com) and [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com).

然而，为践行这一使命而提供的**工具体系**已然发生深刻变化。首当其冲的是：`langchain`——最初仅是一个 Python/JS 开源库——如今已发展为一家名为 LangChain 的公司！尽管 `langchain` 仍是目前最受欢迎的产品，但我们已拓展出另外两大核心产品：[LangGraph](https://langchain.com/langgraph?ref=blog.langchain.com) 和 [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com)。

In 2022, developers primarily needed an easy way to learn to build with this new technology and quickly get started. Today, the greater challenge is creating high-quality applications that work reliably and make a real impact. The evolution of all three of our products reflects this shift.

2022 年，开发者最迫切的需求是快速上手这项新技术、轻松开启构建之旅；而今天，更大的挑战在于：打造高质量、高可靠性、能真正产生业务价值的应用。我们三大产品的演进路径，正清晰映射了这一重心转移。

## How the ecosystem has evolved

## 生态系统如何演进

Two years ago, the whole generative AI ecosystem was incredibly nascent — ChatGPT hadn’t even launched. `langchain` took off because it gave developers an easy entry point to build LLM apps quickly and keep up with the latest research. At that point, we had all the most popular LLM integrations (a whopping 3!) and off-the-shelf chains that made it possible to get started with 5 lines of code and tinker with common use cases.

两年前，整个生成式 AI 生态尚处于极度稚嫩的萌芽阶段——彼时 ChatGPT 甚至尚未发布。`langchain` 迅速走红，正因为它为开发者提供了便捷的入门路径：可快速构建 LLM 应用，并紧跟前沿研究进展。当时，我们已集成了当时所有主流的 LLM（共计 3 个！），并提供了开箱即用的链（chains），使得开发者仅需 5 行代码即可启动开发，轻松尝试各类常见应用场景。

Since then, the ecosystem has evolved in three significant ways:

此后，整个生态系统在三个方面发生了显著演进：

- The ecosystem has stabilized. While we still believe it is early days, the GenAI landscape is not nearly as nascent as it was two years ago. LLM applications are no longer being built solely in hackathons — they are being shipped to production.

- 生态系统趋于稳定。尽管我们依然坚信当前仍属早期阶段，但生成式 AI（GenAI）格局已远非两年前那般稚嫩。LLM 应用不再仅限于黑客松中的原型演示，而是正被大规模部署至生产环境。

- The ecosystem has exploded. When `langchain` first launched, there were approximately 3 LLM providers. Today, there are over 70 model providers, along with countless integrations (document loaders, vector stores, and more) - totaling over 700 different integrations in `langchain`.

- 生态系统迅猛扩张。`langchain` 初次发布时，全球仅有约 3 家 LLM 服务商；而今，模型提供商已逾 70 家，配套集成组件（如文档加载器、向量数据库等）更是不计其数——仅 `langchain` 中就已收录超过 700 种不同集成。

- Most importantly, the ecosystem has matured. For enterprises and startups alike, the focus has shifted from simply building a prototype to making their LLM app production-ready.

- 最重要的是，生态系统日趋成熟。无论大型企业还是初创公司，关注焦点均已从“能否做出一个原型”，转向“如何让 LLM 应用真正具备生产就绪（production-ready）能力”。

Let’s dive into that last point. Our original open-source library`langchain` made (and still makes) it easy to get started with common LLM app use cases in just a few lines of code. But as the ecosystem has matured, it's become apparent that easy to get started != easy to get to production.

让我们深入探讨最后一点。我们最初的开源库 `langchain`，让开发者仅用寥寥数行代码即可快速上手常见 LLM 应用场景（至今依然如此）。但随着生态日益成熟，一个关键现实愈发清晰：**易于起步 ≠ 易于投产**。

当然，这促使我们提出一个问题：究竟是什么阻碍了开发者将他们的应用交付给真实用户？

## LangSmith 与 LangGraph 的必要性

### LangSmith：面向生产就绪型大语言模型（LLM）应用的测试与可观测性工具

在与早期 `langchain` 用户及合作伙伴的交流中，我们反复听到一个关键痛点：大语言模型（LLM）的不可靠性已成为一大障碍。对大多数工程师而言，仅仅集成一个模型远远不够；要让 LLM 持续、稳定地做出正确决策，需要付出大量努力。由此，“提示工程”（Prompt Engineering）也逐渐发展为一门独立的学科。

我们很早就意识到这一挑战，并于 2023 年初启动了 [**LangSmith**](https://docs.smith.langchain.com/?ref=blog.langchain.com) 的开发工作，旨在解决两大核心需求：**可观测性（Observability）** 与 **评估（Evaluation）**。引入可观测性，可帮助开发者精准定位其 LLM 应用出错的具体环节；而评估机制则能防止性能退化，并确保应用持续优化。这两大支柱——识别 LLM 应用问题、系统性提升性能——至今仍是 LangSmith 的核心使命。

在 LangSmith 的开发过程中，我们与 Moody’s、[Elastic](https://blog.langchain.com/langchain-partners-with-elastic-to-launch-the-elastic-ai-assistant/)、[Podium](https://blog.langchain.com/customers-podium/) 和 [Rakuten](https://blog.langchain.com/customers-rakuten/) 等客户紧密合作，不断打磨产品。在此过程中，我们持续汇总并沉淀 [LLM 应用测试与评估的最佳实践指南](https://www.langchain.com/testing-guide-ebook?ref=blog.langchain.com)，并观察到 LangSmith 不仅帮助 AI/ML 团队深度洞察其 AI 助手与聊天机器人的交互细节，更赋能团队快速开展测试、精准调试棘手问题。

### LangGraph：具备灵活编排能力的智能体（Agent）控制框架

在与优秀开发者、初创公司及大型企业的协作中，另一项挑战逐渐浮现。至 2023 年初夏，我们清晰地认识到：LangChain 中高层级的预构建组件已难以满足实际生产场景的需求。我们频繁听到反馈——现成的链（Chains）过于僵化，而预配置的智能体（Agents）又缺乏规模化部署所必需的可靠性。

我们意识到，若要提升系统可靠性，开发者**必须**对其应用的认知架构（Cognitive Architecture）拥有更强的掌控力。基于大量用户反馈，我们打造了 [**LangGraph**](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com) —— 一个灵活的编排框架，支持开发者构建从严格定义的工作流，到高度自主、自适应的智能体等全谱系智能体。LangGraph 提供高度可定制的架构，使用户能根据自身或业务的具体需求，精细调整智能体行为。借助“人在环路”（Human-in-the-loop）支持与内容审核循环（Moderation Loops），LangGraph 用户可更有效地管控智能体输出，保障结果的可靠性。

目前，已有诸多令人振奋的 LangGraph 实践案例落地：从 [Replit 的编程智能体](https://blog.langchain.com/customers-replit/)，到 [Unify 基于 LangGraph 与 LangSmith 构建的销售智能体](https://blog.langchain.com/unify-launches-agents-for-account-qualification-using-langgraph-and-langsmith/)，这些案例不仅验证了 LangGraph 的强大能力，更印证了业界对智能体可靠处理复杂任务的迫切需求。

## LangChain open source today

## LangChain 开源现状

So where does this leave the LangChain open source packages today, and what’s changed from two years ago? Today, `langchain` is:

那么，当前 LangChain 的开源包处于怎样的状态？与两年前相比又有哪些变化？如今，`langchain` 具备以下特点：

- **更加稳定**。随着生成式 AI 生态系统的逐步成熟，`langchain` 也日趋稳定。我们在 2024 年初发布了首个稳定版本（v0.1.0），此后仅发布过两次含不兼容变更（breaking changes）的版本。
- **更加全面**。伴随生成式 AI（GenAI）的爆发式发展，集成能力持续成为 `langchain` 的核心重点之一。在此方面，我们极大受益于卓越而活跃的社区。LLM 可连接的对象种类繁多——从向量数据库、检索器到文档加载器——我们由衷感谢每一位为 `langchain` 集成包贡献代码的开发者。目前，我们已为头部合作伙伴推出[专属集成包](https://python.langchain.com/docs/integrations/providers/?ref=blog.langchain.com)，并为各类组件建立了标准化测试体系。
- **更贴近生产环境需求**。随着开发者重心从原型验证转向实际生产应用，我们也相应地对 `langchain` 进行了优化升级。在构建 LangSmith（面向 LLM 应用的业界领先可观测性与测试平台）过程中，我们确保其与 `langchain` 实现了无缝集成；而在打造 `langgraph` 框架以支持强大、可定制的认知架构时，我们亦充分展示了如何将 `langchain` 组件融入其中，并将原有 `langchain` 链（chains）平滑迁移至更健壮的 LangGraph 应用中。

As `langchain` has grown, our community has grown alongside us. This past year:

随着 `langchain` 的持续发展，我们的社区也同步壮大。过去一年中：

- 我们在 LangChain（涵盖 Python 和 JavaScript 版本）的**贡献者数量翻倍**，从 2000 人增长至 **4000 人**；
- 基于 LangChain 构建的**应用数量增长四倍**，从 3 万款跃升至 **13.2 万款**；
- **总下载量**（Python + JavaScript）从 2000 万次飙升至 **超 1.3 亿次**。

A special shoutout to our LangChain community champions and ambassadors, who’ve helped us squash bugs, tackle issues, and have made educational content to make LangChain products accessible for everyone:

特别致谢以下 LangChain 社区杰出贡献者与大使，他们协助我们修复缺陷、解决各类问题，并制作了大量优质教育内容，让 LangChain 产品真正惠及每一位开发者：

**_Aditya Thomas (sepiatone), Allen Firstenberg (afirstenberg), Andres Torres, Christophe Bornet (cbornet), Clemens Peters (clemenspeters), Colin McNamara (colinmcnamara), Daniel Nastase (js\_craft\_hq), Eden Marco (emarco177), Francisco Ingham (fpingham), gbaian10, Greg Kamradt (gregkamradt), Harry Zhang (zhanghaili0610), Marlene Mhangami (marlenezw), Rick Garcia (gitmaxd), Tom Spencer, Virat Singh (virattt)_**

## The road ahead for LangChain

## LangChain 的未来之路

When I launched `langchain` two years ago, the goal was to make it as easy as possible to build LLM applications that reason. Now as a company, that same goal has motivated us over the past two years to improve `langchain` **and** to create orthogonal products that solve different needs.

两年前我首次发布 `langchain` 时，目标是让开发者能以最简单的方式构建具备推理能力的 LLM 应用。如今作为一家公司，这一初心在过去两年持续驱动我们：一方面不断优化 `langchain` 本身，另一方面也同步打造功能正交（orthogonal）、面向不同需求的配套产品。

We think this space is still in its early days and that there is a LOT of tooling to be built to make it enable developers to create game-changing applications. We think `langchain`, LangGraph, and LangSmith are key pieces of that puzzle — and we're confident that more components will surface over time. With the support and feedback from our incredible community, we'll continue to push LangChain forwards, exploring new directions while staying true to the vision of `langchain` that started it all.

我们认为，这一领域仍处于早期阶段，仍有大量工具亟待开发，方能真正赋能开发者打造出颠覆性的应用。我们坚信，`langchain`、LangGraph 与 LangSmith 正是构成这幅宏大图景的关键拼图；同时我们也确信，随着时间推移，更多关键组件必将陆续浮现。依托我们卓越社区的支持与宝贵反馈，我们将坚定推进 LangChain 的演进，在探索全新方向的同时，始终坚守 `langchain` 初心所定义的愿景。

## Join the LangChain community

## 加入 LangChain 社区

We'd love to have you along for the journey as we build the future of LLM applications — together! Here are some ways to get involved:

我们诚挚邀请您加入我们，共同构建大语言模型（LLM）应用的未来！以下是几种参与方式：

- Join the Slack community: [langchain.com/join-community](https://www.langchain.com/join-community?ref=blog.langchain.com)  
  加入 Slack 社区：[langchain.com/join-community](https://www.langchain.com/join-community?ref=blog.langchain.com)

- Contribute to the open source project: [python.langchain.com/docs/contributing/](https://python.langchain.com/docs/contributing/?ref=blog.langchain.com)  
  为开源项目贡献代码：[python.langchain.com/docs/contributing/](https://python.langchain.com/docs/contributing/?ref=blog.langchain.com)

- Attend an event: [lu.ma/langchain](http://lu.ma/langchain?ref=blog.langchain.com)  
  参加线下或线上活动：[lu.ma/langchain](http://lu.ma/langchain?ref=blog.langchain.com)

- Get the latest product updates: [changelog.langchain.com](http://changelog.langchain.com/?ref=blog.langchain.com)  
  获取最新产品动态：[changelog.langchain.com](http://changelog.langchain.com/?ref=blog.langchain.com)

- Learn more: [langchain.com/community](https://www.langchain.com/community?ref=blog.langchain.com)  
  了解更多：[langchain.com/community](https://www.langchain.com/community?ref=blog.langchain.com)

### Tags

### 标签

[Harrison Chase](https://blog.langchain.com/tag/harrison-chase/)  
[Harrison Chase](https://blog.langchain.com/tag/harrison-chase/)

[![Introducing Interrupt: The AI Agent Conference by LangChain](images/langchain_s-second-birthday/img_001.png)](https://blog.langchain.com/introducing-interrupt-langchain-conference/)

[![推出 Interrupt：LangChain 主办的 AI Agent 大会](images/langchain_s-second-birthday/img_001.png)](https://blog.langchain.com/introducing-interrupt-langchain-conference/)

[**Introducing Interrupt: The AI Agent Conference by LangChain**](https://blog.langchain.com/introducing-interrupt-langchain-conference/)

[**推出 Interrupt：LangChain 主办的 AI Agent 大会**](https://blog.langchain.com/introducing-interrupt-langchain-conference/)

[Harrison Chase](https://blog.langchain.com/tag/harrison-chase/) 2 min read  
[Harrison Chase](https://blog.langchain.com/tag/harrison-chase/) 阅读时长：2 分钟

[![Why you should outsource your agentic infrastructure, but own your cognitive architecture](images/langchain_s-second-birthday/img_002.png)](https://blog.langchain.com/why-you-should-outsource-your-agentic-infrastructure-but-own-your-cognitive-architecture/)

[![为何应将 Agent 基础设施外包，但须自主掌控认知架构](images/langchain_s-second-birthday/img_002.png)](https://blog.langchain.com/why-you-should-outsource-your-agentic-infrastructure-but-own-your-cognitive-architecture/)

[**Why you should outsource your agentic infrastructure, but own your cognitive architecture**](https://blog.langchain.com/why-you-should-outsource-your-agentic-infrastructure-but-own-your-cognitive-architecture/)

[**为什么你应该将智能体基础设施外包，但必须自主掌控认知架构**](https://blog.langchain.com/why-you-should-outsource-your-agentic-infrastructure-but-own-your-cognitive-architecture/)

[Harrison Chase](https://blog.langchain.com/tag/harrison-chase/) 3 min read

[Harrison Chase](https://blog.langchain.com/tag/harrison-chase/) 阅读时长：3 分钟

[![What is a "cognitive architecture"?](images/langchain_s-second-birthday/img_003.png)](https://blog.langchain.com/what-is-a-cognitive-architecture/)

[![什么是“认知架构”？](images/langchain_s-second-birthday/img_003.png)](https://blog.langchain.com/what-is-a-cognitive-architecture/)

[**What is a "cognitive architecture"?**](https://blog.langchain.com/what-is-a-cognitive-architecture/)

[**什么是“认知架构”？**](https://blog.langchain.com/what-is-a-cognitive-architecture/)

[Harrison Chase](https://blog.langchain.com/tag/harrison-chase/) 3 min read

[Harrison Chase](https://blog.langchain.com/tag/harrison-chase/) 阅读时长：3 分钟

[![What is an AI agent?](images/langchain_s-second-birthday/img_004.png)](https://blog.langchain.com/what-is-an-agent/)

[![什么是 AI 智能体？](images/langchain_s-second-birthday/img_004.png)](https://blog.langchain.com/what-is-an-agent/)

[**What is an AI agent?**](https://blog.langchain.com/what-is-an-agent/)

[**什么是 AI 智能体？**](https://blog.langchain.com/what-is-an-agent/)

[Harrison Chase](https://blog.langchain.com/tag/harrison-chase/) 4 min read

[Harrison Chase](https://blog.langchain.com/tag/harrison-chase/) 阅读时长：4 分钟
&#123;% endraw %}
