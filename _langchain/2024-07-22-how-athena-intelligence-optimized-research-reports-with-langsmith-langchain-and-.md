---
title: "How Athena Intelligence optimized research reports with LangSmith, LangChain, and LangGraph"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-athena-intelligence/"
date: "2024-07-22"
scraped_at: "2026-03-03T07:57:55.784100861+00:00"
language: "en-zh"
translated: true
description: "See how an AI-powered employee for enterprise analytics used the LangSmith playground and debugging features to quickly identify LLM issues and to generate complex research reports."
tags: ["Case Studies"]
---
&#123;% raw %}

Athena Intelligence is an AI-powered employee that is transforming enterprise analytics by automating time-consuming data tasks  and democratizing data analysis for data scientists and business users alike. Their natural language interface, Olympus, aims to connect all data sources and applications so that users can query complex datasets easily, much like asking a question to a colleague.

Athena Intelligence 是一位由人工智能驱动的“员工”，正通过自动化耗时的数据任务，推动企业分析领域的变革，并让数据科学家与业务用户 alike（同样）能够平等地开展数据分析。其自然语言交互界面“Olympus”旨在连接所有数据源与应用程序，使用户能像向同事提问一样轻松查询复杂数据集。

One of Athena’s most powerful features is the ability to generate high-quality enterprise reports. In this case study, we will go over what this feature entails and how LangSmith helped during the development process.

Athena 最强大的功能之一，便是生成高质量的企业级报告。本案例研究将详细介绍该功能的具体内涵，以及 LangSmith 在开发过程中所提供的支持。

## **Generating reports on complex topics**

## **面向复杂主题的报告生成**

Generating elaborate reports on complex topics requires pulling information from various sources, both web-based and internal. Having proper source citation and data-rich reports was especially important to Athena's customers.

面向复杂主题生成详尽报告，需从多种来源（包括网络公开数据与企业内部系统）提取信息。对 Athena 的客户而言，准确标注信息来源、并确保报告内容数据翔实，尤为关键。

![](images/how-athena-intelligence-optimized-research-reports-with-langsmith-langchain-and-/img_001.jpg)_Example of types of research reports Athena can create_

![](images/how-athena-intelligence-optimized-research-reports-with-langsmith-langchain-and-/img_001.jpg)_Athena 可生成的研究报告类型示例_

Building a product to reliably generate these types of reports is hard work. It may be easy to build a prototype of a report writer and make something that passes as a Twitter demo — but as with many GenAI applications, it's significantly more difficult to build a reliable production system like Athena’s.

构建一款能稳定生成此类报告的产品，绝非易事。开发一个报告生成器原型、甚至做出一个足以在 Twitter 上展示的演示版本，或许并不困难；但正如许多生成式 AI 应用所面临的挑战一样，要打造像 Athena 这样稳定可靠的生产级系统，则要困难得多。

![](images/how-athena-intelligence-optimized-research-reports-with-langsmith-langchain-and-/img_002.jpg)_Example of a research report generated with Athena’s Olympus platform_

![](images/how-athena-intelligence-optimized-research-reports-with-langsmith-langchain-and-/img_002.jpg)_借助 Athena 的 Olympus 平台生成的研究报告示例_

To bridge the gap between prototype and production, Athena turned to LangChain, LangGraph, and LangSmith. They used LangChain to stay agnostic to the underlying LLM they used and manage integrations with thousands of tools. LangGraph helped them orchestrate complex custom agent architectures. They used LangSmith first to rapidly iterate during the development process, and then to observe their applications in production.

为弥合原型与生产系统之间的鸿沟，Athena 借助了 LangChain、LangGraph 与 LangSmith。他们利用 LangChain 实现底层大语言模型（LLM）的无关性，并统一管理与数千种工具的集成；LangGraph 则助力其编排复杂的自定义智能体（agent）架构；而 LangSmith 首先被用于加速开发过程中的快速迭代，随后则用于对生产环境中的应用进行可观测性监控。

### **Maximum flexibility and interoperability with LangChain**

### **借助 LangChain 实现极致灵活性与互操作性**

Athena Intelligence began its journey with [LangChain](https://python.langchain.com/v0.2/docs/introduction/?ref=blog.langchain.com), relying on its interoperability to swap in different models and build their AI apps. LangChain's architecture allowed Athena to be completely LLM-agnostic throughout their platform, reducing their dependency on any one model provider.

Athena Intelligence 的技术演进始于 [LangChain](https://python.langchain.com/v0.2/docs/introduction/?ref=blog.langchain.com)，依托其出色的互操作性，灵活切换不同大语言模型，高效构建自身的 AI 应用。LangChain 的架构设计，使 Athena 能在整个平台层面彻底实现 LLM 无关性，从而显著降低对任一模型供应商的依赖。

Athena also heavily used LangChain’s document, retriever, and tool abstractions.  
Athena 还大量使用了 LangChain 的文档（document）、检索器（retriever）和工具（tool）抽象层。

By using the standard LangChain document format, Athena could ensure that documents they passed around were always in the same format.  
通过采用标准的 LangChain 文档格式，Athena 能够确保其在系统内部流转的文档始终遵循统一格式。

LangChain’s retriever interface made this even easier, exposing a common way to access these documents.  
LangChain 的检索器接口进一步简化了这一过程，为访问这些文档提供了统一、标准化的方式。

Athena’s research reports also heavily relied on tool usage — by using LangChain’s tool interface they could easily manage the collection of tools they had and pass them in the same manner to all LLMs.  
Athena 的研究报也高度依赖工具调用——借助 LangChain 的工具接口，团队可轻松管理其工具集合，并以一致的方式将这些工具传递给所有大语言模型（LLM）。

### **Building production-ready agent architecture with LangGraph**

### **使用 LangGraph 构建面向生产的智能体（agent）架构**

_As_ Athena developed more agentic capabilities, they turned to [LangGraph](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com).  
随着 Athena 不断增强其智能体能力，团队转向了 [LangGraph](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com)。

The agentic architecture they adopted was highly customized for their use case.  
他们所采用的智能体架构高度定制化，专为其具体应用场景而设计。

LangGraph provided low-level controllability, allowing the team to build out complex agent architectures that orchestrated hundreds of LLM calls.  
LangGraph 提供了底层可控性，使团队能够构建出复杂的智能体架构，协调调度数百次大语言模型调用。

LangGraph provides Athena engineers with a stateful environment to build production-ready agentic architectures.  
LangGraph 为 Athena 工程师提供了一个具备状态管理能力的开发环境，用于构建面向生产的智能体架构。

It enables them to create specialized nodes with tuned prompts, and then quickly assemble them into complex multi-agent workflows.  
它支持工程师创建带有精细调优提示词（prompt）的专用节点，并快速将其组合成复杂的多智能体工作流。

The composability of LangGraph, with its stateful arguments, allows the team to reuse components across different applications in their cognitive stack.  
LangGraph 基于有状态参数（stateful arguments）的高度可组合性，使得团队能够在整个认知技术栈（cognitive stack）的不同应用中复用各类组件。

To manage computationally intensive workflows with hundreds of LLM calls introduced by their agentic system, Athena then also LangSmith to improve observability in their development lifecycle.  
为应对智能体系统引入的、包含数百次 LLM 调用的计算密集型工作流，Athena 进一步引入 LangSmith，以提升其开发全生命周期中的可观测性（observability）。

### **Rapid iteration in development using LangSmith**

### **借助 LangSmith 实现开发过程中的快速迭代**

[LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) played a crucial role in Athena's development process.  
[LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) 在 Athena 的开发流程中发挥了关键作用。

To give an example of this, let’s consider the feature in the research reports that cited where the data came from.  
举一个典型例子：研究报告中需标注数据来源的“文中引用”（in-text citation）功能。

Doing in-text source citation properly typically takes a lot of prompt engineering effort.  
正确实现文中引用通常需要大量提示工程（prompt engineering）工作。

LangSmith greatly accelerated this process.  
LangSmith 极大地加速了这一过程。

With tracing in LangSmith, the Athena team had logs of all runs that generated reports and could quickly identify runs where citations had failed.  
借助 LangSmith 的追踪（tracing）功能，Athena 团队可完整记录所有生成研究报告的运行实例，并迅速定位其中引用失败的执行案例。

Instead of pushing code to production and testing, Athena developers could just then just open up the LangSmith Playground from a specific run and adjust their prompts on the fly.  
开发人员无需先将代码部署至生产环境再进行测试，而是可直接从某次具体运行实例中打开 LangSmith Playground，在线实时调整提示词。

This made it easier to isolate an LLM call to see cause-and-effect, in a way that was tailored for Athena’s complex and bespoke stack — saving countless development hours for the Athena team as they iterated quickly on prompts before shipping to production.  
这种方式使工程师能精准隔离单次 LLM 调用，清晰观察输入与输出之间的因果关系；且该调试体验深度适配 Athena 复杂而高度定制化的技术栈——显著节省了 Athena 团队在投产前反复优化提示词所耗费的海量开发工时。

![](images/how-athena-intelligence-optimized-research-reports-with-langsmith-langchain-and-/img_003.jpg)

_Caption: 使用 LangSmith Playground 视图优化市场调研报告_

通过调优提示词（prompts）以准确理解并正确引用数据源，Athena 工程师能够将名称相似的数据点精准关联回其对应的应用场景，从而显著提升开发质量与速度。

### **借助 LangSmith 在生产环境中进行监控**

当应用正式上线投入生产后，Athena 团队借助 LangSmith 的 trace 功能，对多项关键指标的运行表现进行了持续监控。在引入 LangSmith 之前，Athena 工程师需人工查阅服务器日志、手动搭建监控看板来定位生产环境中的问题——这一过程耗时冗长且操作繁琐。

LangSmith 提供了开箱即用的多项核心指标，例如错误率（error rate）、延迟（latency）以及首 token 延迟（time-to-first-token），助力 Athena 团队实时掌握其大语言模型（LLM）应用的服务可用性。这一能力在文档检索类任务中尤为突出：通过 trace 追踪，团队可清晰查看系统实际检索到的具体文档，并深入分析检索流程中各环节对响应时间的影响。

正如 Athena Intelligence 首席平台工程师 Ben Reilly 所指出：

> “ _若非拥有 LangSmith 这样一套端到端的可观测性平台，我们绝不可能实现当前如此高速的迭代节奏。它为我们的开发者节省了数不清的工时，更让原本几乎无法完成的任务变得切实可行。”_

## **总结**

Athena Intelligence 成功依托 LangChain、LangGraph 与 LangSmith，构建起一个功能强大的 AI 驱动型分析平台。借助这些工具，Athena 实现了开发过程的快速迭代、系统问题的高效调试与精准优化，并最终向企业客户交付了高质量、高可靠性的分析报告。

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-athena-intelligence-optimized-research-reports-with-langsmith-langchain-and-/img_004.png)](https://blog.langchain.com/customers-monday/)

[![monday Service + LangSmith：从第一天起构建以代码为先的评估策略](images/how-athena-intelligence-optimized-research-reports-with-langsmith-langchain-and-/img_004.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-athena-intelligence-optimized-research-reports-with-langsmith-langchain-and-/img_005.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph，借助 AI 完成数千名客户的入职流程](images/how-athena-intelligence-optimized-research-reports-with-langsmith-langchain-and-/img_005.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph，借助 AI 完成数千名客户的入职流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-athena-intelligence-optimized-research-reports-with-langsmith-langchain-and-/img_006.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/how-athena-intelligence-optimized-research-reports-with-langsmith-langchain-and-/img_006.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 分钟阅读

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-athena-intelligence-optimized-research-reports-with-langsmith-langchain-and-/img_007.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/how-athena-intelligence-optimized-research-reports-with-langsmith-langchain-and-/img_007.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-athena-intelligence-optimized-research-reports-with-langsmith-langchain-and-/img_008.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对客户成功专员工作状态的可观测性](images/how-athena-intelligence-optimized-research-reports-with-langsmith-langchain-and-/img_008.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对客户成功专员工作状态的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-athena-intelligence-optimized-research-reports-with-langsmith-langchain-and-/img_009.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/how-athena-intelligence-optimized-research-reports-with-langsmith-langchain-and-/img_009.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读
&#123;% endraw %}
