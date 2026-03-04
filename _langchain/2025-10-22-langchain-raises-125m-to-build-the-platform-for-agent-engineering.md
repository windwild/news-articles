---
title: "LangChain raises $125M to build the platform for agent engineering"
source: "LangChain Blog"
url: "https://blog.langchain.com/series-b/"
date: "2025-10-22"
scraped_at: "2026-03-03T07:21:46.234634299+00:00"
language: "en-zh"
translated: true
description: "We raised $125M at a $1.25B valuation to build the platform for agent engineering."
---
{% raw %}

# Today, we’re announcing we’ve raised $125M at a $1.25B valuation to build the **platform for agent engineering.** We’re also releasing new capabilities to accelerate the path to reliable agents, including LangChain and LangGraph 1.0 releases, a new Insights Agent, and a no code agent builder. IVP led the round alongside existing investors Sequoia, Benchmark, and Amplify, as well as new investors CapitalG and Sapphire Ventures.

# 今天，我们宣布已完成 1.25 亿美元融资，估值达 12.5 亿美元，致力于打造 **面向智能体工程（agent engineering）的平台**。同时，我们还推出多项新功能，以加速构建高可靠性智能体的进程，包括 LangChain 和 LangGraph 1.0 正式版、全新 Insights 智能体（Insights Agent），以及一款零代码智能体构建工具（no-code agent builder）。本轮融资由 IVP 领投，现有投资方红杉资本（Sequoia）、Benchmark 和 Amplify，以及新晋投资方 CapitalG 与 Sapphire Ventures 跟投。

From AI-native startups to global enterprises, builders trust LangChain's products to engineer reliable agents. Today, we’re grateful to power AI teams at Replit, Clay, Harvey, Rippling, Cloudflare, Workday, Cisco, and more.

从原生 AI 创业公司到全球性企业，开发者信赖 LangChain 的产品来构建高可靠性智能体。今天，我们深感荣幸能为 Replit、Clay、Harvey、Rippling、Cloudflare、Workday、Cisco 等众多企业的 AI 团队提供支持。

The core ideas we had when we made the first commit to the `langchain` package three years ago still hold true today: LLMs will change what applications can do, but the real power comes from turning LLM applications into **agents** with access to data and APIs. Agents will function as complex systems that require new tooling and infrastructure to harness the power of generative AI.

三年前，我们在 `langchain` 包中提交首个代码时所秉持的核心理念，至今依然成立：大语言模型（LLM）将重塑应用程序的能力边界，但真正的力量在于——将 LLM 应用升级为可访问数据与 API 的 **智能体（agents）**。智能体将作为复杂系统运行，需要全新的工具链与基础设施，方能充分释放生成式 AI 的潜能。

Today’s reality is that agents are easy to prototype but hard to ship to production. That’s because any input or change to an agent can create a host of unknown outcomes. Building reliable agents requires a new approach, one that combines product, engineering, and data science thinking. We call this discipline **agent engineering** \- the iterative process of refining non-deterministic LLM systems into reliable experiences.

当前的现实是：智能体易于原型验证，却难以交付至生产环境。这是因为任何输入或对智能体的修改，都可能引发一系列不可预知的结果。构建高可靠性智能体，需要一种融合产品思维、工程实践与数据科学方法的全新范式。我们将这一学科命名为 **智能体工程（agent engineering）**——即通过持续迭代，将非确定性的大语言模型系统打磨为稳定、可靠的用户体验。

**We are building the platform for agent engineering.**

**我们正在打造面向智能体工程的平台。**

We’ve evolved our offerings from the original `langchain` library based on feedback from millions of developers and thousands of customers in our community. We’ve always let you choose the best model for the job, no matter the vendor. Today, we are launching an expanded platform for the complete lifecycle of agent engineering.

我们基于数百万开发者及数千名社区客户的反馈，持续演进最初发布的 `langchain` 库，不断优化产品形态。我们始终秉持开放原则：无论供应商是谁，您均可自由选择最适合任务需求的大模型。今天，我们正式推出覆盖智能体工程全生命周期的扩展型平台。

The LangChain community can build agents with our **open source frameworks – LangChain and LangGraph**.

LangChain 社区可通过我们的 **开源框架——LangChain 与 LangGraph** 构建智能体。

- **LangChain** helps you get started building agents quickly with any model provider of your choice. We’ve completely rewritten `langchain` in its 1.0 release to be opinionated, focused, and powered by `langgraph`’s runtime.

- **LangChain** 帮助您快速上手，使用任意您选定的模型服务商构建智能体。在 1.0 版本中，我们已对 `langchain` 进行全面重写，使其具备明确的设计主张（opinionated）、高度聚焦的功能定位，并以内置 `langgraph` 运行时为核心驱动力。

- **LangGraph** allows you to control every step of your custom agent with low-level orchestration, memory, and human-in-the-loop support. You can manage long-running tasks with durable execution.

- **LangGraph** 提供底层编排能力、状态记忆（memory）及人工介入（human-in-the-loop）支持，让您精准掌控自定义智能体的每一步执行流程；借助持久化执行（durable execution）机制，您还可高效管理长周期运行任务。

Previously, LangSmith helped you understand and test your agent. Now, **LangSmith** is a comprehensive platform for agent engineering that helps AI teams use live production data for continuous testing and improvement. LangSmith provides:

此前，LangSmith 主要用于帮助您理解并测试智能体行为。如今，**LangSmith** 已全面升级为面向智能体工程的一站式平台，助力 AI 团队利用真实线上生产数据，开展持续性测试与迭代优化。LangSmith 提供以下核心能力：

- **Observability** to see exactly how your agent thinks and acts with detailed tracing and aggregate trend metrics.

- **可观测性（Observability）**：通过详尽的执行追踪（tracing）与聚合趋势指标，清晰呈现智能体的思考逻辑与行为路径。

- **Evaluation** to test and score agent behavior on production data and offline datasets for continuous improvement.

- **评估（Evaluation）**：基于线上生产数据与离线数据集，对智能体行为进行测试与评分，支撑持续优化。

- **Deployment** (formerly LangGraph Platform) to ship your agent in one click, using scalable infrastructure built for long-running tasks.

- **部署（Deployment）**（原 LangGraph Platform）：一键发布您的智能体，依托专为长周期任务设计的弹性可扩展基础设施。

- **Agent Builder**(now in private preview) to reduce the barrier to building agents with a no code text-to-agent experience.

- **智能体构建器（Agent Builder）**（目前处于私测阶段）：通过“文本即智能体”（text-to-agent）的零代码交互方式，大幅降低智能体开发门槛。

Open is part of our ethos, so you can use LangSmith whether you build your agent with our open source frameworks or not. If you do use our stack together, you’ll be able to iterate faster towards reliable agents.

开放是我们的核心理念之一，因此无论您是否使用我们的开源框架来构建智能体（agent），都可以使用 LangSmith。若您将我们的技术栈整合使用，将能更快速地迭代，从而构建出更可靠的智能体。

The space evolves rapidly, and so do we. Today we’re announcing:

这一领域正以前所未有的速度演进，而我们亦然。今天，我们正式宣布：

- [**LangChain 与 LangGraph 的重大 1.0 版本发布**](https://docs.langchain.com/oss/python/langchain/overview?ref=blog.langchain.com) —— 标志着产品进入稳定阶段：全新重构的 `langchain` 包聚焦于为常见智能体模式提供开箱即用的架构、增强模型集成能力，并承诺在 2.0 版本之前不引入任何破坏性变更。此外，还推出了全新文档！
- [**Insights Agent（洞察智能体）**](https://youtu.be/9aX8ETgSp0w?ref=blog.langchain.com)，LangSmith 可观测性平台中新增的一款智能体，可自动对智能体行为模式进行分类。
- [**Agent Builder（智能体构建器）**](http://langchain.com/langsmith-agent-builder-waitlist?ref=blog.langchain.com) **（目前处于私有预览阶段）**，面向业务用户推出的“文本转智能体”无代码构建体验，大幅降低智能体开发门槛。

The momentum we’ve seen is just the beginning. Today, `langchain` and `langgraph` have a combined 90M monthly downloads, and 35 percent of the Fortune 500 use our services. Monthly trace volume for our commercial LangSmith platform has 12x’d year over year.

我们所见证的增长势头，才刚刚拉开序幕。截至目前，`langchain` 与 `langgraph` 合计月下载量已达 9000 万次；《财富》全球 500 强企业中，已有 35% 在使用我们的服务。商业化 LangSmith 平台的月度追踪（trace）数据量，同比激增 12 倍。

We’d love you to be a part of the story. Head on over to the [docs](http://docs.langchain.com/?ref=blog.langchain.com) to see what’s available, stay tuned on [our blog](https://blog.langchain.com/) for deep dives on every launch this week and next, take a [course](http://academy.langchain.com/?ref=blog.langchain.com) to uplevel your skills, and if building the future of agent engineering sounds fun, come join us. [We're hiring.](http://langchain.com/careers?ref=blog.langchain.com)

诚挚邀请您加入这段旅程。欢迎访问 [文档中心](http://docs.langchain.com/?ref=blog.langchain.com)，了解当前全部可用功能；持续关注我们的 [官方博客](https://blog.langchain.com/)，获取本周及下周每项发布的深度解析；报名参加 [在线课程](http://academy.langchain.com/?ref=blog.langchain.com)，全面提升您的技能水平；若您也热衷于构建智能体工程的未来，欢迎加入我们！[我们正在招聘。](http://langchain.com/careers?ref=blog.langchain.com)

_Thank you to our new investors, many of whom are already customers or partners, that help make this journey possible – ServiceNow Ventures, Workday Ventures, Cisco Investments, Datadog Ventures, Databricks Ventures, and Frontline._

衷心感谢我们的新投资人——其中许多已是我们的客户或合作伙伴，正是他们让这段征程成为可能：ServiceNow Ventures、Workday Ventures、Cisco Investments、Datadog Ventures、Databricks Ventures 以及 Frontline。
{% endraw %}
