---
title: "On Agent Frameworks and Agent Observability"
source: "LangChain Blog"
url: "https://blog.langchain.com/on-agent-frameworks-and-agent-observability/"
date: "2026-02-13"
scraped_at: "2026-03-02T10:08:09.570506268+00:00"
language: "en-zh"
translated: true
description: "Every time LLMs get better, the same question comes back: &quot;Do you still need an agent framework?&quot; It&apos;s a fair question. The best way to build agents changes as the models get more perfo..."
tags: ["Harrison's Hot Takes"]
---

Every time LLMs get better, the same question comes back: "Do you still need an agent framework?" It's a fair question. The best way to build agents changes as the models get more performant and evolve, but fundamentally, the agent is a system _around_ the model, so they will not disappear – they just need to evolve too.  
每次大语言模型（LLM）能力提升，同一个问题就会再次浮现：“我们是否仍需要智能体（agent）框架？”这是一个合理的问题。随着模型性能不断提升、能力持续演进，构建智能体的最佳方式也在变化；但从根本上说，智能体本质上是围绕模型构建的一套**系统**，因此它不会消失——只是自身也需要同步演进。

We've now built three generations of agent frameworks, and each one looked different from the last. So here's what we believe:  
截至目前，我们已构建了三代智能体框架，每一代在形态和理念上都与前一代显著不同。因此，我们坚信以下两点：

1. Agent frameworks are still useful, but only if they evolve as fast as the models do.  
1. 智能体框架依然有价值，但前提是其演进速度必须与模型本身保持同步。

2. Agent observability should work no matter how you build. That’s why LangSmith works even if you don’t use our open source (LangChain or LangGraph).  
2. 智能体可观测性（observability）应当与构建方式无关。正因如此，LangSmith 即使在您未使用我们的开源项目（LangChain 或 LangGraph）时，依然可以正常工作。

This post is about both of those bets.  
本文将围绕上述两个核心判断展开论述。

**Why agent frameworks are still relevant in 2026**  
**为何智能体框架在 2026 年依然重要**

Agent patterns have moved from chaining to workflow orchestration to tool-calling-in-a-loop with file-systems and memory. We’ve built frameworks for them all and believe each has its place based on your use case. Here’s how they’ve evolved:  
智能体模式已从最初的“链式调用”（chaining），发展为“工作流编排”（workflow orchestration），再到如今融合文件系统与记忆机制的“循环式工具调用”（tool-calling-in-a-loop）。我们为这三种范式均开发了对应框架，并认为：每种范式都有其适用场景，关键取决于您的具体用例。以下是它们的演进脉络：

### Chaining  
### 链式调用（Chaining）

The original **langchain** got popular in 2023 because few people knew how to make practical use of LLMs. The framework offered one of the easiest ways to connect foundation models to your data or APIs through a set of integrations and core abstractions. It was arguably too opinionated at the start — more of an "easy button" for learning about prompting and RAG than a production-ready tool. As the first wave of generative AI started to settle by that summer, criticism that agent frameworks were pointless grew louder.  
最初的 **LangChain** 于 2023 年走红，彼时鲜有人知晓如何将大语言模型投入实际应用。该框架通过一系列集成模块与核心抽象层，提供了当时最便捷的方式之一，将基础模型连接至用户自有数据或 API。不过，它在初期的确显得过于“强加观点”（opinionated）——更像一个用于学习提示工程（prompting）与检索增强生成（RAG）的“一键入门工具”，而非面向生产环境就绪的成熟方案。随着生成式 AI 的第一波热潮在当年夏季逐渐趋于理性，关于“智能体框架毫无意义”的批评声也日益高涨。

We heard the criticism, but it was hard to square with what we were seeing in actual usage. The vast majority of teams building LLM apps needed ways to move faster than going it completely alone. Good frameworks:  
我们听到了这些批评，但它们与我们在真实场景中观察到的现象却难以吻合。绝大多数正在构建 LLM 应用的团队，都需要比“完全从零开始”更快的落地路径。优秀的框架应能：

- Encode best practices into the framework itself  
- 将业界最佳实践直接内化于框架设计之中；

- Reduce boilerplate code  
- 显著减少模板式重复代码；

- Make it easier to reach a higher level of quality  
- 更轻松地达成更高水准的交付质量；

- Create standards and readability across large teams  
- 在大型团队中建立统一标准与代码可读性；

- Pave a cleaner path to production  
- 为通往生产环境铺设一条更清晰、更稳健的路径。

So we doubled down. On a different framework.  
于是，我们选择加倍投入——但这一次，转向了一个全新的框架。

### Orchestration and run-time

### 编排与运行时

**langgraph** 层级更低，也更灵活。它内置了一个运行时（runtime），支持持久化（durability）和有状态性（statefulness），而这恰恰对人类-智能体协作（human-agent collaboration）以及智能体-智能体协作（agent-agent collaboration）至关重要。它解决了人们针对 **langchain** 提出的诸多控制流（control flow）方面的担忧。我们最终确实在 2025 年重写了最初的 **langchain**，使其更加精简；但与此同时，我们也认识到：不同问题需要不同的工具。

### Harness

### 智能体运行框架（Harness）

最近，我们构建了 **deepagents**：一个“开箱即用”（batteries-included）、性能更强、灵活性更高的智能体运行框架。它支持长周期任务的规划（planning for long-horizon tasks）、循环式工具调用（tool-calling-in-a-loop）、将上下文卸载至文件系统（context offloading to a filesystem），以及子智能体编排（subagent orchestration）。如今，智能体运行框架之所以可行，是因为大语言模型（LLMs）的推理能力持续提升——你可将更多决策权交由 LLM 自主完成，而无需像过去那样硬编码大量编排逻辑。在理念上，它最接近 Claude Agent SDK，但关键区别在于：**deepagents 是模型无关的（model-agnostic）**。据我们所知，它是目前唯一一个不绑定任何特定大语言模型（LLM）或应用技术栈的智能体运行框架。

今天，我们针对不同使用场景推荐不同的框架：**langchain 和 deepagents 均基于 langgraph 的运行时构建**，以支持长时间运行的任务执行。

![](images/on-agent-frameworks-and-agent-observability/img_001.png)

这听起来或许有些戏剧化，但过去三年中，我们确实见证了智能体演进的三个代际：最初是 RAG（检索增强生成），随后发展为具备工作流能力的智能体（agentic workflows），再进一步演变为更自主的、支持循环式工具调用的智能体（autonomous tool-calling-in-a-loop agents）。

框架面临的最大质疑在于：AI 领域变化太快，难以形成稳定标准。这一说法确有道理。但我们同样坚信：坐等 AI 格局尘埃落定再入场，是一种注定失败的策略。框架能助你快速入局、加速构建，并显著提升成功概率。即便如此，工具本身仍将持续迭代演进；而且，并非所有场景都需要框架——若仅需发起一个简单的 LLM 请求，引入框架反而可能过度复杂、得不偿失。

## **Why LangSmith is independent from LangChain open source**

## **为何 LangSmith 独立于 LangChain 开源项目**

早期，我们就已意识到：[质量](https://www.langchain.com/state-of-agent-engineering?ref=blog.langchain.com#biggest-barriers-to-production) 是将智能体推向生产环境的最大障碍。我们始终坚信（且至今未变）：专为智能体设计的可观测性（agent observability）与评估能力（evals）是工程化工具链中不可或缺的一环。

We called it [LangSmith](https://www.langchain.com/langsmith/observability?ref=blog.langchain.com), because we had the intuition that there wouldn't be only one agent framework. And even if there were a dominant one, it would have to evolve at a pace that would make early versions unrecognizable. We acknowledged not everyone would use our frameworks, but wanted them still to be able to use this platform.

我们将其命名为 [LangSmith](https://www.langchain.com/langsmith/observability?ref=blog.langchain.com)，因为我们直觉地意识到，未来不会只存在一种智能体（agent）框架。即便某一种框架最终占据主导地位，其演进速度也势必快到令早期版本面目全非。我们承认，并非所有人都会采用我们的开源框架，但我们仍希望他们也能使用这一平台。

So we built LangSmith to work regardless of whether you used **langchain**, any of our other frameworks, or nothing at all. This wasn't an obvious decision at the time. We drew inspiration from companies like Vercel, which supports many frontend frameworks beyond their own [Next.js](http://next.js/?ref=blog.langchain.com).

因此，我们构建了 LangSmith，使其无论您是否使用 **langchain**、我们其他任一框架，甚至完全不使用任何框架，都能正常运行。这一决策在当时并非显而易见。我们从 Vercel 等公司获得启发——Vercel 除支持自家的 [Next.js](http://next.js/?ref=blog.langchain.com) 外，还兼容众多前端框架。

Today, LangSmith integrates with [a number of frameworks out of the box](https://docs.langchain.com/langsmith/integrations?ref=blog.langchain.com) — AutoGen, Claude Agent SDK, CrewAI, Mastra, OpenAI Agents, PydanticAI, Vercel AI SDK, and more. It supports OpenTelemetry-based tracing, so anything that emits the OTEL spec can be ingested by LangSmith. And it works with agents built using no framework at all. Many LangSmith customers, including Clay, Harvey, and Vanta, don't use our open source frameworks but rely on LangSmith for observability and evals.

如今，LangSmith 开箱即用地支持 [多种框架](https://docs.langchain.com/langsmith/integrations?ref=blog.langchain.com)——包括 AutoGen、Claude Agent SDK、CrewAI、Mastra、OpenAI Agents、PydanticAI、Vercel AI SDK 等。它支持基于 OpenTelemetry（OTEL）的追踪，因此任何符合 OTEL 规范的数据均可被 LangSmith 接入。它同样适用于完全不依赖任何框架构建的智能体。许多 LangSmith 客户（如 Clay、Harvey 和 Vanta）并未使用我们的开源框架，却高度依赖 LangSmith 实现可观测性与评估（evals）。

## **Building and testing converge in agent engineering**

## **构建与测试在智能体工程中深度融合**

Regardless of your agent framework, traces are critical to understanding agent behavior. We've been writing about [how important the agent trace](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/) is because it's the foundation for agent debugging, monitoring, evals, and more. With agents, your app logic is documented in traces, not code. Building the agent is only the first step. Agents are non-deterministic systems, so you have no idea what inputs or outputs to expect until you ship it. That’s why debugging, testing, and monitoring are critical parts of [agent engineering](https://blog.langchain.com/agent-engineering-a-new-discipline/) and the building process itself.

无论您采用何种智能体框架，追踪（traces）对于理解智能体行为都至关重要。我们持续撰文强调 [智能体追踪的重要性](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)，因为它是智能体调试、监控、评估（evals）等一切工作的基石。在智能体系统中，应用逻辑由追踪记录，而非代码本身。构建智能体仅是第一步；由于智能体属于非确定性系统，您在真正上线部署前，根本无法预知其将接收何种输入、产生何种输出。正因如此，调试、测试与监控已成为 [智能体工程（agent engineering）](https://blog.langchain.com/agent-engineering-a-new-discipline/) 的核心环节，也是整个构建流程中不可或缺的一部分。

So if you’re not using our OSS frameworks, we’d like to hear why! But, don’t let it stop you from figuring out how and why your agent is failing with LangSmith.

因此，若您尚未采用我们的开源框架，我们非常期待了解您的原因！但请切勿因此阻碍您借助 LangSmith 深入探究智能体失败的具体表现与根本原因。

### Tags

### 标签

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)

[Harrison 的犀利观点](https://blog.langchain.com/tag/in-the-loop/)

[![From Traces to Insights: Understanding Agent Behavior at Scale](images/on-agent-frameworks-and-agent-observability/img_002.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**从追踪到洞察：大规模理解智能体行为**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![In software, the code documents the app. In AI, the traces do.](images/on-agent-frameworks-and-agent-observability/img_003.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[![在软件中，代码记录应用行为；在 AI 中，追踪记录行为。](images/on-agent-frameworks-and-agent-observability/img_003.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**在软件中，代码记录应用行为；在 AI 中，追踪记录行为。**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![Agent Frameworks, Runtimes, and Harnesses- oh my!](images/on-agent-frameworks-and-agent-observability/img_004.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[![智能体框架、运行时与编排工具——天哪！](images/on-agent-frameworks-and-agent-observability/img_004.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses- oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**智能体框架、运行时与编排工具——天哪！**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：3 分钟

[![Reflections on Three Years of Building LangChain](images/on-agent-frameworks-and-agent-observability/img_005.png)](https://blog.langchain.com/three-years-langchain/)

[![构建 LangChain 三年来的思考](images/on-agent-frameworks-and-agent-observability/img_005.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[**构建 LangChain 三年来的思考**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 分钟阅读

[![Not Another Workflow Builder](images/on-agent-frameworks-and-agent-observability/img_006.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[![并非又一个工作流构建器](images/on-agent-frameworks-and-agent-observability/img_006.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[**并非又一个工作流构建器**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读

[![Deep Agents](images/on-agent-frameworks-and-agent-observability/img_007.png)](https://blog.langchain.com/deep-agents/)

[![深度智能体](images/on-agent-frameworks-and-agent-observability/img_007.png)](https://blog.langchain.com/deep-agents/)

[**Deep Agents**](https://blog.langchain.com/deep-agents/)

[**深度智能体**](https://blog.langchain.com/deep-agents/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读