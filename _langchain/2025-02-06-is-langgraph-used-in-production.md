---
title: "Is LangGraph Used In Production?"
source: "LangChain Blog"
url: "https://blog.langchain.com/is-langgraph-used-in-production/"
date: "2025-02-06"
scraped_at: "2026-03-03T07:40:46.389591288+00:00"
language: "en-zh"
translated: true
description: "LinkedIn, Uber, Replit, and Elastic are just a few of the companies using LangGraph for real use cases in production. Learn how they did it below!"
---
&#123;% raw %}

[Leading companies](https://www.langchain.com/built-with-langgraph?ref=blog.langchain.com) like Uber, LinkedIn, and Replit are choosing LangGraph to build agents that are not only powerful but also reliable.  
像 Uber、LinkedIn 和 Replit 这样的领先企业正选择 LangGraph 来构建不仅功能强大、而且高度可靠的智能体（agents）。

In 2024, the focus shifted towards specialized AI agents designed for specific business needs.  
2024 年，业界的关注重点已转向为特定业务需求量身定制的专业化 AI 智能体。

But getting [AI agents](https://blog.langchain.com/what-is-an-agent/) production-ready isn’t as simple as plugging in an LLM to produce intelligent outputs.  
但要让 [AI 智能体](https://blog.langchain.com/what-is-an-agent/) 真正落地生产环境，并非仅靠接入一个大语言模型（LLM）生成“智能输出”那么简单。

Companies need solutions that provide **reliability, observability, and control.**  
企业需要的是能够提供 **可靠性、可观测性与可控性** 的解决方案。

This piece explores the key challenges of putting AI agents into production and how leading companies like Uber, LinkedIn, and Replit are overcoming them, with some help from LangGraph. 🪄  
本文将深入探讨 AI 智能体投入生产所面临的核心挑战，并介绍 Uber、LinkedIn 和 Replit 等领军企业如何在 LangGraph 的助力下成功应对这些挑战。🪄

## **Many companies are choosing LangGraph for reliable agents**

## **众多企业正选用 LangGraph 构建高可靠性智能体**

Companies across a variety of industries are turning to LangGraph to build scalable agent systems.  
来自各行各业的企业纷纷采用 LangGraph 构建可扩展的智能体系统。

**LinkedIn** streamlined hiring by building an AI-powered recruiter that automates candidate sourcing, matching, and messaging. Their hierarchical agent system, built on LangGraph, has freed up their human recruiters to focus on high-level strategy – resulting in more efficient hiring.  
**LinkedIn** 借助 LangGraph 构建了一套分层式智能体系统，打造了 AI 驱动的招聘助手，自动完成候选人搜寻、匹配与消息沟通等环节；该系统显著释放了人力招聘专员的时间，使其得以专注于高层次战略工作，从而大幅提升招聘效率。

Another example of operational efficiency — **AppFolio** created a copilot that’s [saved over 10 hours a week](https://blog.langchain.com/customers-appfolio/) for their property managers, as LangGraph helped them cut app latency and 2x the accuracy of their decisions.  
另一项提升运营效率的范例——**AppFolio** 借助 LangGraph 打造了一款智能助手（copilot），为其物业管理团队每周节省超 10 小时工作时间；LangGraph 不仅帮助他们大幅降低应用延迟，更使决策准确率提升一倍。

For **Uber** and **Replit**, LangGraph greatly sped up the development cycle when scaling up complex workflows.  
对于 **Uber** 和 **Replit** 而言，LangGraph 在扩展复杂工作流的过程中极大加速了开发周期。

Replit’s AI agent acts as a [copilot for building software from scratch](https://www.langchain.com/breakoutagents/replit?ref=blog.langchain.com); with LangGraph under the hood, they’ve architected a multi-agent system with human-in-the-loop capabilities (so users can **see their agent actions**, from package installations to file creation) - making development more transparent.  
Replit 的 AI 智能体扮演着从零开始构建软件的 [智能编程助手](https://www.langchain.com/breakoutagents/replit?ref=blog.langchain.com) 角色；其底层依托 LangGraph，构建了一套支持“人在环路中”（human-in-the-loop）的多智能体系统（用户可 **清晰查看智能体的每一步操作**，从安装依赖包到创建文件皆可追溯），从而显著提升了开发过程的透明度。

Uber integrated LangGraph to streamline large-scale code migrations within their developer platform. They carefully structured a network of specialized agents so that each step of their unit test generation was handled with precision.  
Uber 将 LangGraph 集成至其开发者平台，以优化大规模代码迁移流程；他们精心设计了一个由专业化智能体组成的网络，确保单元测试生成的每个环节都精准执行。

Similarly, **Elastic** has used LangGraph to orchestrate their network of AI agents for real-time threat detection – which has helped them respond to security risks much more quickly and effectively.  
同样，**Elastic** 也借助 LangGraph 编排其 AI 智能体网络，实现对安全威胁的实时检测，从而更快速、更高效地响应各类安全风险。

## **Why is it so hard to put AI agents into production?**

## **为何将 AI 智能体投入生产如此困难？**

While LLM-powered agents hold immense promise, getting them production-ready is challenging - especially when it comes to ensuring [performance quality](https://www.langchain.com/stateofaiagents?ref=blog.langchain.com) and reliability.  
尽管大语言模型驱动的智能体前景广阔，但将其真正推向生产环境却充满挑战——尤其在保障 [性能质量](https://www.langchain.com/stateofaiagents?ref=blog.langchain.com) 和可靠性方面。

![](images/is-langgraph-used-in-production/img_001.jpg)Performance quality was the top challenge for respondents in the "State of AI Agents" survey ran by LangChain in the tail end of 2024  
![](images/is-langgraph-used-in-production/img_001.jpg)在 LangChain 于 2024 年底开展的《AI 智能体现状》调研中，“性能质量”成为受访者反馈的首要挑战。

From working closely with hundreds of companies, we see the following key hurdles to deploying agents in production:

在与数百家公司深度合作的过程中，我们发现将 AI 智能体（agents）部署至生产环境面临以下关键障碍：

- **Unpredictability of LLMs** \- Unlike traditional software, AI agents don’t follow a fixed set of rules. Instead, they generate responses dynamically. On top of that, the UX for agents allows for free-form text input, including unpredictable human speech – making it difficult to guarantee accurate and contextually-appropriate responses.  
- **大语言模型（LLM）的不可预测性**：与传统软件不同，AI 智能体并不遵循一套固定规则，而是动态生成响应。此外，智能体的用户界面支持自由格式文本输入（包括难以预测的人类自然语言），这使得确保响应的准确性与上下文适配性变得极具挑战。

- **Complexity of orchestration -** Many real-world applications require multiple agents to work together, with each handling different tasks. Coordinating them effectively — including managing task dependencies, error recovery, and communication – adds another layer of difficulty.  
- **编排（orchestration）的复杂性**：许多实际应用场景需多个智能体协同工作，各自承担不同任务。如何高效协调它们——包括管理任务依赖关系、错误恢复及智能体间通信——又增添了一层复杂度。

- **Observability and debugging limitations**\- When an agent makes a bad decision, understanding _why_ can feel like a shot in the dark. Diagnosing failures and maintaining performance require robust tracing and monitoring, which most agent frameworks don’t have built-in.  
- **可观测性与调试能力的局限性**：当智能体做出错误决策时，要弄清其“原因”往往如同盲人摸象。故障诊断与性能维护依赖于强大的链路追踪（tracing）和监控能力，而大多数智能体框架并未内置此类功能。

Given these hurdles, we see most companies choosing a framework to have the right tool set to meet their bar for shipping to production. This is also where LangGraph comes into play.

鉴于上述障碍，我们观察到多数公司倾向于选择一个合适的框架，以获得满足其生产上线标准的工具集。这也正是 LangGraph 的用武之地。

## **What is LangGraph?**

## **什么是 LangGraph？**

[LangGraph](https://www.langchain.com/langgraph?ref=blog.langchain.com) is a controllable agent framework designed for production use. Unlike other agentic frameworks, LangGraph is:

[LangGraph](https://www.langchain.com/langgraph?ref=blog.langchain.com) 是一款面向生产环境设计、具备高度可控性的智能体框架。与其他智能体框架相比，LangGraph 具有以下特点：

- **Low-level and customizable** – LangGraph allows you to flexibly design agents for your company’s bespoke needs. LangGraph primitives are fully descriptive and, unlike higher-level abstractions, can scale beyond prototyping.  
- **底层化且高度可定制**：LangGraph 支持您灵活设计契合企业特定需求的智能体。LangGraph 的基础构建单元（primitives）具备完整可描述性；与更高层级的抽象不同，它能够支撑从原型开发迈向规模化生产。

- **Highly reliable** – Gain full control over agent actions with moderation checks, human-in-the-loop, and persisted context for long-running workflows — so your agent can stay on course.  
- **高可靠性**：通过内容审核机制（moderation checks）、人工介入（human-in-the-loop）以及长期运行工作流中的上下文持久化能力，您可对智能体行为实现全面掌控，确保其始终按既定路径执行。

- **Optimized for observability** – While LangGraph doesn’t depend on any other LangChain product, it integrates seamlessly with [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) for added visibility into agent interactions, performance monitoring, and debugging.  
- **专为可观测性优化**：尽管 LangGraph 不依赖任何其他 LangChain 产品，但它可与 [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) 无缝集成，从而显著增强对智能体交互过程、性能指标及调试信息的可见性。

When we built LangGraph in early 2024, we intentionally gave developers the choice to structure their agents without the limitations of black-box architectures. LangGraph has since become the default framework for many agentic applications in production. We learned from LangChain that while higher level abstractions helped developers get started quickly, it’s the lower level flexibility that can handle varied production queries. LangGraph has a steeper learning curve, but users find they don't scale off of it.

2024 年初我们构建 LangGraph 时，便有意赋予开发者自由设计智能体架构的权利，彻底摆脱黑盒式架构的束缚。如今，LangGraph 已成为众多生产级智能体应用的默认框架。我们从 LangChain 的实践中认识到：虽然高层级抽象有助于开发者快速上手，但真正应对多样化生产场景查询的，却是底层的灵活性。LangGraph 的学习曲线虽更陡峭，但用户普遍反馈：一旦掌握，便极少需要转向其他方案（即“不会轻易弃用”）。

## **The future of AI agents with LangGraph**

## **基于 LangGraph 的 AI 智能体未来展望**

As we enter 2025, LangGraph is poised to drive the next wave of AI agent adoption. By building on the lessons learned from these leading companies, we aim to empower more developers to build reliable, production-ready AI agents.

迈入 2025 年，LangGraph 将引领 AI 智能体应用落地的新一轮浪潮。我们将持续汲取这些领先企业的实践经验，助力更多开发者构建稳定可靠、开箱即用的生产级 AI 智能体。

Looking for more insights? Check out the [latest stories](https://www.langchain.com/built-with-langgraph?ref=blog.langchain.com) on how companies are using LangGraph, or explore our latest [video tutorial](https://www.youtube.com/watch?v=aHCDrAbH_go&ref=blog.langchain.com) on how to build effective AI agents.

希望获取更多洞见？欢迎查阅关于企业如何使用 LangGraph 的[最新案例集锦](https://www.langchain.com/built-with-langgraph?ref=blog.langchain.com)，或观看我们的最新[视频教程](https://www.youtube.com/watch?v=aHCDrAbH_go&ref=blog.langchain.com)，了解如何构建高效实用的 AI 智能体。
&#123;% endraw %}
