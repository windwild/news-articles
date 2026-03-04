---
title: "LangSmith for the full product lifecycle: How Wordsmith quickly builds, debugs, and evaluates LLM performance in production"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-wordsmith/"
date: "2024-07-17"
scraped_at: "2026-03-03T07:58:48.425241125+00:00"
language: "en-zh"
translated: true
description: "Learn how WordSmith, an AI assistant for legal teams, uses LangSmith across its entire product lifecycle — from prototyping, to evaluation, to debugging, to experimentation."
tags: ["Case Studies"]
---
&#123;% raw %}

[Wordsmith](https://link.wordsmith.ai/Rp33gza?ref=blog.langchain.com) is an AI assistant for in-house legal teams, reviewing legal docs, drafting emails, and generating contracts using LLMs powered by the customer’s knowledge base. Unlike other legal AI tools, Wordsmith has deep domain knowledge from leading law firms and is easy to install and use. It integrates seamlessly into email and messaging systems to automatically draft responses for the legal team, mimicking what it’s like to work with another person on the team.

[Wordsmith](https://link.wordsmith.ai/Rp33gza?ref=blog.langchain.com) 是一款面向企业内部法务团队的 AI 助手，利用客户自有知识库驱动的大语言模型（LLM），完成法律文件审阅、邮件草拟及合同生成等任务。与其他法律领域 AI 工具不同，Wordsmith 深度融合了顶尖律所的专业领域知识，且安装与使用极为简便。它可无缝集成至电子邮件和即时通讯系统，自动为法务团队草拟回复，体验接近与团队中另一位同事协同工作。

Having experienced an exponential growth in LLM-powered features over the past few months, WordSmith’s engineering team needed better visibility into LLM performance and interactions. [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) has been vital to understanding what’s happening in production and measuring experiment impact on key parameters. Below, we’ll walk through how LangSmith has provided value at each stage of the product development life cycle.

过去几个月，Wordsmith 的 LLM 驱动功能呈现爆发式增长，其工程团队亟需更清晰地洞察大语言模型的性能表现与交互细节。[LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) 在此过程中发挥了关键作用——帮助团队理解生产环境中的真实运行状况，并量化各类实验对核心指标的影响。下文将分阶段阐述 LangSmith 如何在产品全生命周期各环节持续赋能。

## **Prototyping & Development: Wrangling complexity through hierarchical tracing**

## **原型设计与开发：借助分层追踪驾驭复杂性**

Wordsmith’s first feature was a configurable RAG pipeline for Slack. It has now evolved to support complex multistage inferences over a wide variety of data sources and objectives. Wordsmith ingests Slack messages, Zendesk tickets, pull requests, and legal documents, delivering accurate results over a heterogeneous set of domains and NLP tasks. Beyond just getting the right results, their team needed to optimize for cost and latency using LLMs from OpenAI, Anthropic, Google, and Mistral.

Wordsmith 的首个功能是面向 Slack 的可配置 RAG（检索增强生成）流水线；如今，该能力已演进为支持跨多种数据源与业务目标的复杂多阶段推理。Wordsmith 接入 Slack 消息、Zendesk 工单、代码拉取请求（pull requests）以及各类法律文档，在高度异构的领域与自然语言处理（NLP）任务中交付精准结果。除确保结果正确性外，团队还需借助来自 OpenAI、Anthropic、Google 和 Mistral 的各类大语言模型，在成本与延迟之间实现精细优化。

LangSmith has become crucial to Wordsmith's growth, enabling engineers to work quickly and confidently. With its foundational value-add as a tracing service, LangSmith helps the Wordsmith team transparently assess _what the LLM is receiving and producing_ at each step of their complex multi-stage inference chains. The hierarchical organization of inferences lets them quickly iterate during the development cycle, far faster than when they relied solely on Cloudwatch logs for debugging.

LangSmith 已成为 Wordsmith 快速成长的关键支撑，使工程师得以高效、自信地开展工作。作为一款基础性追踪服务，LangSmith 帮助 Wordsmith 团队清晰透明地评估：在其复杂的多阶段推理链中，大语言模型在每一步究竟“接收了什么”与“输出了什么”。推理过程的分层组织结构，显著加快了开发周期内的迭代速度——远超此前仅依赖 CloudWatch 日志进行调试的效率。

Consider the following snapshot of an agentic workflow in which GPT-4 crafts a bad Dynamo query:

请看以下一个智能体（agentic）工作流的截图示例：GPT-4 生成了一条错误的 DynamoDB 查询语句：

![](images/langsmith-for-the-full-product-lifecycle-how-wordsmith-quickly-builds-debugs-and/img_001.jpg)Invalid Dynamo query in an agentic workflow

![](images/langsmith-for-the-full-product-lifecycle-how-wordsmith-quickly-builds-debugs-and/img_001.jpg)智能体工作流中的无效 DynamoDB 查询

These workflows can contain up to 100 nested inferences, making it time-consuming and painful to sift through general logs to find the root cause of an errant response. With LangSmith’s out-of-the-box [tracing](https://docs.smith.langchain.com/concepts/tracing?ref=blog.langchain.com) interface, diagnosing poor performance at an intermediate step is seamless, enabling much faster feature development.

此类工作流可能包含多达 100 层嵌套推理，若仅依靠通用日志排查异常响应的根本原因，将极其耗时且痛苦。借助 LangSmith 开箱即用的 [追踪（tracing）](https://docs.smith.langchain.com/concepts/tracing?ref=blog.langchain.com) 界面，工程师可轻松定位中间环节的性能瓶颈，从而极大加速新功能的开发进程。

## **Performance Measurement: Establishing baselines with LangSmith datasets**

## **性能度量：依托 LangSmith 数据集建立基准线**

Reproducible measurement helps differentiate a promising GenAI demo from a production-ready product. Using LangSmith, Wordsmith has published a variety of evaluation sets for various tasks like RAG, agentic workloads, attribute extractions, and even XML-based changeset targeting — facilitating their deployment to production.

可复现的性能度量，是区分一个颇具潜力的生成式 AI（GenAI）演示原型与真正具备投产能力产品的关键所在。借助 LangSmith，Wordsmith 已发布涵盖多种任务类型的评估数据集，包括 RAG、智能体（agentic）工作负载、属性抽取，甚至基于 XML 的变更集（changeset）定向任务——有力支撑了其产品向生产环境的顺利部署。

These static evaluation sets provide the following key benefits:

这些静态评估集提供了以下关键优势：

1. Eval sets crystalize the requirements for Wordsmith’s feature. By forcing the team to write a set of correct questions and answers, they set clear expectations and requirements for the LLM.

1. 评估集明确了 Wordsmith 功能的需求。通过强制团队编写一组正确的问题与答案，它们为大语言模型（LLM）设定了清晰的预期和要求。

2. Eval sets enable the engineering team to iterate quickly and with confidence. For example, when Claude 3.5 was released, the Wordsmith team was able to compare its performance to GPT-4o within an hour and release it to production the same day. Without well-defined evaluation sets, they would have to rely on ad-hoc queries, lacking a standard baseline to confidently assess if a proposed change improved user outcomes.

2. 评估集使工程团队能够快速、自信地进行迭代。例如，在 Claude 3.5 发布后，Wordsmith 团队仅用一小时就完成了其与 GPT-4o 的性能对比，并于当日将其投入生产环境。若缺乏明确定义的评估集，团队将不得不依赖临时性查询，缺少统一基准，因而无法确信地判断某项改动是否真正提升了用户效果。

3. Eval sets let the Wordsmith team optimize on cost and latency with accuracy as the key constraint. Task complexities are not uniform, and using faster and cheaper models where possible has reduced cost on particular tasks by up to 10x. Similar to (2), this optimization would be time-consuming and error-prone without a predefined set of evaluation criteria.

3. 评估集使 Wordsmith 团队能在确保准确率这一核心约束的前提下，对成本与延迟进行优化。不同任务的复杂度并不一致；在可行场景下采用更快、更廉价的模型，已使部分任务的成本降低高达 10 倍。与第（2）点类似，若无预先定义的评估标准，此类优化将耗时且易出错。

![](images/langsmith-for-the-full-product-lifecycle-how-wordsmith-quickly-builds-debugs-and/img_002.jpg)Tracking the accuracy of an agentic workflow over time

![](images/langsmith-for-the-full-product-lifecycle-how-wordsmith-quickly-builds-debugs-and/img_002.jpg)长期追踪智能体工作流（agentic workflow）的准确率

## **Operational Monitoring: Rapid debugging via LangSmith filters**

## **运行监控：借助 LangSmith 筛选器实现快速调试**

The same visibility features that make LangSmith ideal for development also make it a core part of Wordsmith’s online monitoring suite. The team can immediately link a production error to its LangSmith trace, reducing time to debug an inference from minutes to seconds by simply following a LangSmith URL instead of perusing logs.

LangSmith 提供的可观测性能力，不仅使其成为开发阶段的理想工具，也使其成为 Wordsmith 在线监控体系的核心组件。团队可立即将线上错误关联至对应的 LangSmith 追踪记录（trace），从而将推理问题的调试时间从数分钟缩短至数秒——只需点击一条 LangSmith 链接，而无需翻阅冗长日志。

LangSmith’s indexed queries also make it easy to isolate production errors related to inference issues:

LangSmith 的索引化查询功能，也让定位与推理问题相关的线上错误变得轻而易举：

![](images/langsmith-for-the-full-product-lifecycle-how-wordsmith-quickly-builds-debugs-and/img_003.jpg)What’s breaking in prod? LangSmith makes it easy to isolate issues

![](images/langsmith-for-the-full-product-lifecycle-how-wordsmith-quickly-builds-debugs-and/img_003.jpg)线上环境哪里出问题了？LangSmith 让问题隔离变得简单直观

## **Online Experimentation: Enabling experiment analyses via tags**

## **线上实验：借助标签（tags）支持实验分析**

Wordsmith uses [Statsig](https://www.statsig.com/?ref=blog.langchain.com) as their feature flag / experiment exposure library. Leveraging LangSmith tags, it’s simple to map each exposure to the appropriate tag in LangSmith for simplified experiment analyses.

Wordsmith 使用 [Statsig](https://www.statsig.com/?ref=blog.langchain.com) 作为其功能开关（feature flag）与实验曝光（experiment exposure）管理库。借助 LangSmith 的标签（tags）机制，可轻松将每次实验曝光映射至 LangSmith 中对应的标签，从而大幅简化实验分析流程。

A few lines of code are all it takes for us to associate each experiment exposure to an appropriate LangSmith tag:

仅需几行代码，即可将每次实验曝光关联至恰当的 LangSmith 标签：

|     |
| --- |
| `def get_runnable_config() -> RunnableConfig:`<br>        `llm_flags = get_all_llm_features()` # fetch experiments from Statsig<br>        `return {`<br>            `"metadata": {`<br>                `"env": ENV,`<br>            `},`<br>            `"tags": [f"{flag}:{value}" for (flag, value) in llm_flags.items()] + [ENV],` # associate experiments with inferences<br>        `}` |
|  |

|     |
| --- |
| `def get_runnable_config() -> RunnableConfig:`<br>        `llm_flags = get_all_llm_features()` # 从 Statsig 获取实验配置<br>        `return {`<br>            `"metadata": {`<br>                `"env": ENV,`<br>            `},`<br>            `"tags": [f"{flag}:{value}" for (flag, value) in llm_flags.items()] + [ENV],` # 将实验标识关联至推理调用<br>        `}` |
|  |

In LangSmith, these exposures are queryable via tags, allowing for seamless analysis and comparison between experiment groups:

在 LangSmith 中，这些实验曝光可通过标签（tags）进行查询，从而实现不同实验组之间的无缝分析与对比：

![](images/langsmith-for-the-full-product-lifecycle-how-wordsmith-quickly-builds-debugs-and/img_004.jpg)Test![](images/langsmith-for-the-full-product-lifecycle-how-wordsmith-quickly-builds-debugs-and/img_005.jpg)Comparison

![](images/langsmith-for-the-full-product-lifecycle-how-wordsmith-quickly-builds-debugs-and/img_004.jpg)测试![](images/langsmith-for-the-full-product-lifecycle-how-wordsmith-quickly-builds-debugs-and/img_005.jpg)对比

Using basic filters, they can fetch all experiment exposures in LangSmith, save them to a new dataset, and export the dataset for downstream analysis. LangSmith thus plays a crucial role in the Wordsmith product’s iterative experimentation and improvement.

借助基础筛选器，团队可在 LangSmith 中检索全部实验曝光记录，将其保存为新数据集，并导出该数据集以供下游分析。因此，LangSmith 在 Wordsmith 产品的迭代式实验与持续优化中发挥了关键作用。

## **What’s Next: Customer-specific hyperparameter optimization**

## **下一步：面向客户的超参数优化**

At each stage of the product life cycle, LangSmith has enhanced the Wordsmith team’s speed and visibility into the quality of their product. Moving forward, they plan to integrate LangSmith even more deeply into the product life cycle and tackle more complex optimization challenges.

在产品生命周期的每个阶段，LangSmith 均显著提升了 Wordsmith 团队的工作效率及其对产品质量的可观测性。未来，团队计划将 LangSmith 更深度地融入产品生命周期，并着手应对更复杂的优化挑战。

Wordsmith’s RAG pipelines contain a broad and ever-increasing set of parameters that govern how the pipelines work. These include embedding models, chunk sizes, ranking and re-ranking configurations, etc. By mapping these hyperparameters to LangSmith tag (using a similar technique to their online experimentation), Wordsmith aims to create online datasets to optimize these parameters for each customer and use case. As datasets grow, they envision a world in which each customer’s RAG experience is automatically optimized based on their datasets and query patterns.

Wordsmith 的 RAG 流水线包含大量且持续增长的参数，用以调控流水线行为，例如嵌入模型（embedding models）、文本分块大小（chunk sizes）、排序与重排序（ranking and re-ranking）配置等。Wordsmith 计划借鉴其线上实验所采用的类似技术，将这些超参数映射为 LangSmith 的标签（tags），从而构建在线数据集，针对每位客户及具体使用场景动态优化上述参数。随着数据集规模不断扩大，他们构想的未来是：每位客户的 RAG 体验均可基于其专属数据集与查询模式实现自动优化。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith：从第一天起构建以代码为中心的评估策略](images/langsmith-for-the-full-product-lifecycle-how-wordsmith-quickly-builds-debugs-and/img_006.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为中心的评估策略**](https://blog.langchain.com/customers-monday/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 8 分钟

[![Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成入驻流程](images/langsmith-for-the-full-product-lifecycle-how-wordsmith-quickly-builds-debugs-and/img_007.png)](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 5 分钟

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/langsmith-for-the-full-product-lifecycle-how-wordsmith-quickly-builds-debugs-and/img_008.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 7 分钟

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/langsmith-for-the-full-product-lifecycle-how-wordsmith-quickly-builds-debugs-and/img_009.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业支持赋能个体创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/langsmith-for-the-full-product-lifecycle-how-wordsmith-quickly-builds-debugs-and/img_010.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对其客户成功专员的可观测性**](images/langsmith-for-the-full-product-lifecycle-how-wordsmith-quickly-builds-debugs-and/img_010.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对其客户成功专员的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/langsmith-for-the-full-product-lifecycle-how-wordsmith-quickly-builds-debugs-and/img_011.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/langsmith-for-the-full-product-lifecycle-how-wordsmith-quickly-builds-debugs-and/img_011.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟
&#123;% endraw %}
