---
title: "LangChain State of AI 2024 Report"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-state-of-ai-2024/"
date: "2025-01-22"
scraped_at: "2026-03-03T07:43:42.129709928+00:00"
language: "en-zh"
translated: true
description: "Dive into LangSmith product usage patterns that show how the AI ecosystem and the way people are building LLM apps is evolving."
tags: ["By LangChain"]
---

Another year of building with LLMs is coming to an end — and 2024 didn’t disappoint. With nearly 30k users signing up for [LangSmith](http://langchain.com/langsmith?ref=blog.langchain.com) every month, we’re lucky to have front row seats to what’s happening in the industry.

又一年基于大语言模型（LLM）的构建工作即将落幕——而2024年不负众望。每月近3万名用户注册 [LangSmith](http://langchain.com/langsmith?ref=blog.langchain.com)，让我们有幸站在行业前沿，亲历技术演进的每一刻。

As [we did last year](https://blog.langchain.com/langchain-state-of-ai-2023/), we want to share some product usage patterns that showcase how the AI ecosystem and practice of building LLM apps are evolving. As folks have traced, evaluated, and iterated their way around LangSmith, we’ve seen a few notable changes. These include the dramatic rise of open-source model adoption and a shift from predominantly retrieval workflows to AI agent applications with multi-step, agentic workflows.

正如我们[去年所做的那样](https://blog.langchain.com/langchain-state-of-ai-2023/)，我们希望分享一些产品使用模式，以展现AI生态及LLM应用开发实践的演进趋势。随着开发者在LangSmith中持续开展链路追踪（tracing）、效果评估（evaluation）与迭代优化（iteration），我们观察到若干显著变化：开源模型采用率大幅攀升；应用范式也正从以检索（retrieval）为主的流程，转向具备多步骤、自主性（agentic）特征的AI智能体（AI agent）应用。

Dive into the stats below to learn exactly what developers are building, testing, and prioritizing.

请深入下方数据，了解开发者当前正在构建、测试和优先推进的具体方向。

## **Infrastructure usage**

## **基础设施使用情况**

With Large Language Models (LLMs) eating the world, everyone’s asking the mirror-mirror-on-the-wall question: “Which model is the most utilized of them all?” Let’s unpack what we’ve seen.

随着大语言模型（LLM）席卷全球，所有人都在向“魔镜”发问：“究竟哪一款模型的使用率最高？”接下来，让我们逐一解析所观察到的趋势。

### Top LLM providers

### 主流LLM服务商排名

Like [last year’s results](https://blog.langchain.com/langchain-state-of-ai-2023/), **OpenAI** reigns as the most used LLM provider among LangSmith users — used more than 6x as much as Ollama, the next-most popular provider (counted by LangSmith organization usage).

与[去年的结果](https://blog.langchain.com/langchain-state-of-ai-2023/)一致，**OpenAI** 仍是LangSmith用户中使用率最高的LLM服务商——其调用量是位列第二的Ollama（按LangSmith组织级使用量统计）的6倍以上。

![](images/langchain-state-of-ai-2024-report/img_001.png)

![](images/langchain-state-of-ai-2024-report/img_001.png)

Interestingly, **Ollama** and **Groq** (which both allow users to run open source models, with the former focusing on local execution and the latter on cloud deployment) have accelerated in momentum this year, breaking into the top 5. This shows a growing interest in more flexible deployment options and customizable AI infrastructure.

值得关注的是，**Ollama** 与 **Groq**（二者均支持运行开源模型，前者侧重本地部署，后者专注云上加速）今年势头迅猛，双双跻身前五。这反映出开发者对更灵活的部署方式及可定制化AI基础设施日益增长的需求。

![](images/langchain-state-of-ai-2024-report/img_002.png)

![](images/langchain-state-of-ai-2024-report/img_002.png)

When it comes to providers that offer open-source models, the top providers have stayed relatively consistent compared to last year - Ollama, Mistral, and Hugging Face have made it easy for developers to run open source models on their platforms. These OSS providers’ collective usage represents **20%** of the top 20 LLM providers (by the number of organizations using them).

在提供开源模型的厂商中，头部厂商相较于去年基本保持稳定——Ollama、Mistral 和 Hugging Face 均为开发者在其平台上运行开源模型提供了极大便利。这些开源软件（OSS）厂商的合计使用量，占全部前 20 名大语言模型（LLM）供应商（按使用组织数量排名）的 **20%**。

### Top Retrievers / Vector Stores

### 主流检索器 / 向量数据库

Performing retrieval is still critical for many GenAI workflows. The top 3 vector stores have remained the same as last year, with Chroma and FAISS as the most popular choices. This year, Milvus, MongoDB, and Elastic’s vector databases have also entered the top 10.

对许多生成式 AI（GenAI）工作流而言，检索能力依然至关重要。前三名向量数据库与去年一致，Chroma 和 FAISS 仍是使用最广泛的选项。今年，Milvus、MongoDB 及 Elastic 的向量数据库也跻身前十。

![](images/langchain-state-of-ai-2024-report/img_003.png)

![](images/langchain-state-of-ai-2024-report/img_003.png)

## Building with LangChain products

## 基于 LangChain 产品构建应用

As developers have gained more experience utilizing generative AI, they are also building more dynamic applications. From the growing sophistication of workflows, to the rise of AI agents — we’re seeing a few trends that point to an evolving ecosystem of innovation.

随着开发者在生成式 AI 应用方面的经验日益丰富，他们所构建的应用也日趋动态化。从工作流复杂度不断提升，到 AI 智能体（AI agents）兴起——我们观察到若干趋势，反映出一个持续演进的创新生态体系。

![](images/langchain-state-of-ai-2024-report/img_004.png)

![](images/langchain-state-of-ai-2024-report/img_004.png)

### Observability isn’t limited to LangChain applications

### 可观测性不仅限于 LangChain 应用

While `langchain` (our open source framework) is central to many folks’ LLM app development journeys, **15.7%** of LangSmith traces this year come from **non-`langchain`** frameworks. This reflects a broader trend where observability is needed regardless of what framework you’re using to build the LLM app — and that interoperability is supported by LangSmith.

尽管 `langchain`（我们的开源框架）是众多开发者构建大语言模型（LLM）应用的核心工具，但今年 LangSmith 的追踪数据中，有 **15.7%** 来源于 **非 `langchain`** 框架。这反映出一个更广泛的趋势：无论你采用何种框架开发 LLM 应用，可观测性都是不可或缺的能力；而 LangSmith 正通过良好的互操作性支持这一需求。

### Python remains dominant, while JavaScript usage grows

### Python 仍占主导地位，JavaScript 使用量持续增长

Debugging, testing, and monitoring certainly has a special place in our Python developers’ hearts, with 84.7% usage coming from the Python SDK. But there is a notable and growing interest in JavaScript as developers pursue web-first applications — the JavaScript SDK accounts for 15.3% of LangSmith usage this year, increasing 3x compared to the previous year.

调试、测试与监控在 Python 开发者心中无疑占据着特殊地位，其中 84.7% 的使用量来自 Python SDK。但随着开发者日益聚焦于“以 Web 为先”的应用构建，JavaScript 也正展现出显著且持续增长的兴趣——今年 JavaScript SDK 占 LangSmith 总使用量的 15.3%，较去年增长了 3 倍。

### AI agents are gaining traction

### AI 智能体正日益普及

As companies are getting more serious about [incorporating AI agents across various industries](https://www.langchain.com/stateofaiagents?ref=blog.langchain.com), adoption of our controllable agent framework, LangGraph, is also on the rise. Since its release in March 2024, LangGraph has steadily gained traction — with **43%** of LangSmith organizations are now **sending LangGraph traces**. These traces represent complex, orchestrated tasks that go beyond basic LLM interactions.

随着企业愈发认真地推进[AI 智能体在各行业的落地应用](https://www.langchain.com/stateofaiagents?ref=blog.langchain.com)，我们可控的智能体框架 LangGraph 的采用率也在持续攀升。自 2024 年 3 月发布以来，LangGraph 的影响力稳步扩大——目前已有 **43%** 的 LangSmith 组织开始**上报 LangGraph 追踪数据（traces）**。这些追踪数据代表的是超越基础大语言模型（LLM）交互的复杂、协同式任务。

![](images/langchain-state-of-ai-2024-report/img_005.png)

![](images/langchain-state-of-ai-2024-report/img_005.png)

This growth aligns with the rise in agentic behavior: we see that on average **21.9% of traces now involve tool calls,** up from an average of 0.5% in 2023. Tool calling allows a model to autonomously invoke functions or external resources, signaling more agentic behavior where the model decides when to take action. Increased use of tool calling can enhance an agent’s ability to interact with external systems and perform tasks like writing to databases.

这一增长趋势与“具身智能行为”（agentic behavior）的兴起高度一致：我们观察到，当前平均 **21.9% 的追踪数据涉及工具调用（tool calls）**，远高于 2023 年平均仅 0.5% 的水平。工具调用使模型能够自主调用函数或外部资源，标志着更典型的智能体行为——即模型可自主判断并决定何时执行动作。工具调用使用率的提升，有助于增强智能体与外部系统交互的能力，并支持诸如向数据库写入数据等具体任务。

![](images/langchain-state-of-ai-2024-report/img_006.png)

![](images/langchain-state-of-ai-2024-report/img_006.png)

## Performance and optimization

## 性能与优化

Balancing speed and sophistication is a key challenge when developing applications — especially those leveraging LLM resources. Below, we explore how organizations are interacting with their applications to align the complexity of their needs with efficient performance.

在应用开发过程中，如何兼顾响应速度与功能复杂性是一大关键挑战——尤其对于依赖大语言模型（LLM）资源的应用而言更是如此。下文我们将探讨各组织如何与其应用交互，以实现业务需求的复杂性与运行性能高效性的统一。

### Complexity is growing, but tasks are being handled efficiently

### 复杂性持续上升，但任务处理日趋高效

The average number of steps per trace has more than doubled over the past year, **rising** from **on** **average 2.8 steps (2023) to 7.7 steps (2024).** We define a step as a distinct operation within a trace, such as a call to an LLM, retriever, or tool. This growth in steps signals that organizations are leveraging more complex and multi-faceted workflows. Rather than a simple question-answer interaction, users are building systems that chain together multiple tasks, such as retrieving information, processing it, and generating actionable results.

过去一年中，每条追踪数据（trace）所含的平均步骤数已增长逾两倍，**从 2023 年的平均 2.8 步升至 2024 年的 7.7 步**。我们定义“一步”（step）为追踪数据内一项独立操作，例如一次 LLM 调用、检索器（retriever）调用或工具调用。步骤数的增长表明，各组织正越来越多地采用更复杂、多维度的工作流。用户不再满足于简单的问答式交互，而是构建起将多项任务串联起来的系统——例如依次完成信息检索、内容处理，最终生成可执行结果。

![](images/langchain-state-of-ai-2024-report/img_007.png)

![](images/langchain-state-of-ai-2024-report/img_007.png)

In contrast, the average number of LLM calls per trace has grown more modestly— from **on average 1.1 to 1.4 LLM calls.** This speaks to how developers are designing systems to achieve more with fewer LLM calls, balancing functionality while keeping expensive LLM requests in check.

相比之下，每条追踪（trace）所调用的大语言模型（LLM）平均次数增长较为平缓——从**平均每条追踪调用 1.1 次上升至 1.4 次**。这反映出开发者正着力设计更高效的系统：在保障功能完备性的同时，以更少的 LLM 调用达成更高目标，从而有效控制高成本的 LLM 请求。

## LLM testing & evaluation

## 大语言模型测试与评估

What are organizations doing to test their LLM applications to guard against inaccurate or low-quality LLM-generated responses? While it’s no easy feat to [keep the quality of your LLM app high](https://www.langchain.com/testing-guide-ebook?ref=blog.langchain.com), we see organizations using LangSmith’s evaluation capabilities to automate testing and generate user feedback loops to create more robust, reliable applications.

为防范大语言模型生成不准确或低质量响应，各组织正采取哪些措施来测试其 LLM 应用？尽管[持续保障 LLM 应用的高质量](https://www.langchain.com/testing-guide-ebook?ref=blog.langchain.com)绝非易事，但我们观察到，许多组织正借助 LangSmith 的评估能力，实现测试自动化，并构建用户反馈闭环，从而打造更健壮、更可靠的 LLM 应用。

### LLM-as-Judge: Evaluating what matters

### LLM 作为裁判：聚焦关键指标的评估

LLM-as-Judge evaluators capture grading rules into an LLM prompt and use the LLM to score whether the output adheres to specific criteria. We see developers testing for these characteristics the most: **Relevance**, **Correctness**, **Exact Match**, and **Helpfulness**

LLM-as-Judge（以大语言模型为裁判）评估器将评分规则编码进 LLM 提示词（prompt），再由 LLM 对输出是否符合特定标准进行打分。目前开发者最常测试的四项特性是：**相关性（Relevance）**、**正确性（Correctness）**、**精确匹配（Exact Match）** 和 **有用性（Helpfulness）**。

These highlight that most developers are doing coarse checks for response quality to make sure AI generated outputs don’t completely miss the mark.

这表明，大多数开发者当前主要进行的是粗粒度的质量检查，旨在确保 AI 生成的输出不至于严重偏离预期目标。

![](images/langchain-state-of-ai-2024-report/img_008.png)

![](images/langchain-state-of-ai-2024-report/img_008.png)

### Iterating with human feedback

### 基于人工反馈的迭代优化

Human feedback is a key part of the iteration loop for folks building LLM apps. LangSmith speeds up the process of [collecting and incorporating human feedback](https://docs.smith.langchain.com/evaluation/how_to_guides?ref=blog.langchain.com#annotation-queues-and-human-feedback) on traces and runs (i.e. spans) – so that users can create rich datasets for improvement and optimization. Over the past year, annotated runs grew **18x**, scaling linearly with growth in LangSmith usage.

人工反馈是构建 LLM 应用过程中迭代优化的关键环节。LangSmith 加速了在追踪（traces）和运行（runs，即 spans）上[收集与整合人工反馈](https://docs.smith.langchain.com/evaluation/how_to_guides?ref=blog.langchain.com#annotation-queues-and-human-feedback)的流程，使用户得以构建丰富、高质量的数据集，用于模型改进与性能优化。过去一年中，已标注的运行（annotated runs）数量增长了 **18 倍**，其增速与 LangSmith 的使用量增长呈线性正相关。

Feedback volume per run also increased slightly, rising from **2.28 to 2.59 feedback entries per run**. Still, feedback is relatively sparse per run. Users may be prioritizing speed in reviewing runs over providing comprehensive feedback, or commenting on only the most critical or problematic runs that need attention.

每次运行的反馈量也略有上升，从 **每运行 2.28 条反馈** 增至 **每运行 2.59 条反馈**。但总体而言，每次运行所获得的反馈仍相对稀疏。用户可能更注重快速审阅运行结果，而非提供全面细致的反馈；也可能仅针对最关键或问题最突出、亟需关注的运行进行评论。

## Conclusion

## 结论

In 2024, developers leaned into complexity with multi-step agents, sharpened efficiency by doing more with fewer LLM calls, and added quality checks to their apps using methods of feedback and evaluation. As more LLM apps are created, we’re excited to see how folks dig into smarter workflows, better performance, and stronger reliability.

2024 年，开发者积极拥抱复杂性，采用多步骤智能体（multi-step agents）；通过减少大语言模型（LLM）调用次数却完成更多任务，进一步提升了效率；并借助反馈与评估等手段，在应用中嵌入质量校验机制。随着越来越多的大语言模型应用问世，我们热切期待看到大家如何深入探索更智能的工作流、更优的性能表现，以及更强的系统可靠性。

[Learn more here](https://langchain.com/langsmith?ref=blog.langchain.com) about how LangSmith can bring more visibility into your LLM app development and improve performance over time — from debugging bottlenecks to evaluating response quality to monitoring regressions.

[点击此处了解更多信息](https://langchain.com/langsmith?ref=blog.langchain.com)，了解 LangSmith 如何为您的大语言模型应用开发提供更高可见性，并随时间推移持续提升性能——无论是定位性能瓶颈、评估响应质量，还是监控模型退化（regressions）。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/langchain-state-of-ai-2024-report/img_009.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**深度智能体评估：我们的实践心得**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/langchain-state-of-ai-2024-report/img_010.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/langchain-state-of-ai-2024-report/img_010.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![Introducing OpenTelemetry support for LangSmith](images/langchain-state-of-ai-2024-report/img_011.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/langchain-state-of-ai-2024-report/img_011.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/langchain-state-of-ai-2024-report/img_012.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更轻松的评估](images/langchain-state-of-ai-2024-report/img_012.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更轻松的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/langchain-state-of-ai-2024-report/img_013.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项](images/langchain-state-of-ai-2024-report/img_013.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入公测阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Few-shot prompting to improve tool-calling performance](images/langchain-state-of-ai-2024-report/img_014.png)](https://blog.langchain.com/few-shot-prompting-to-improve-tool-calling-performance/)

[![利用少样本提示提升工具调用性能](images/langchain-state-of-ai-2024-report/img_014.png)](https://blog.langchain.com/few-shot-prompting-to-improve-tool-calling-performance/)

[**Few-shot prompting to improve tool-calling performance**](https://blog.langchain.com/few-shot-prompting-to-improve-tool-calling-performance/)

[**利用少样本提示提升工具调用性能**](https://blog.langchain.com/few-shot-prompting-to-improve-tool-calling-performance/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 8 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：8 分钟