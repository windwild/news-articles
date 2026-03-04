---
title: "From Traces to Insights: Understanding Agent Behavior at Scale"
source: "LangChain Blog"
url: "https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/"
date: "2026-01-20"
scraped_at: "2026-03-03T07:14:31.214983202+00:00"
language: "en-zh"
translated: true
tags: ["Harrison's Hot Takes", "![Deep Agents", "**Deep Agents**"]
---
{% raw %}

> Visibility is the easiest piece. The hard part is analyzing and understanding what you’re observing. I’ve spoken to teams recording 100k+ traces every single day. What are they doing with those traces? Literally nothing. Because it’s impossible to read and summarize 100,000 traces at any human scale.

> 可观测性（Visibility）是最容易实现的部分；真正困难的是对所观察内容的分析与理解。我曾与一些团队交流过，他们每天记录超过 10 万条追踪（traces）。那么，他们用这些追踪数据做了什么？事实上——什么也没做。因为以人类的认知能力，根本无法阅读并归纳总结 10 万条追踪。

[\- Dev Shah](https://x.com/0xDevShah/status/2010435036584333514?s=20&ref=blog.langchain.com)

[\- Dev Shah](https://x.com/0xDevShah/status/2010435036584333514?s=20&ref=blog.langchain.com)

Tracing is [critical for agent development](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/) \- it powers evaluation, debugging, and annotation. But when you have agents in production generating thousands of traces daily, manual review doesn't scale.

追踪（Tracing）是[智能体（agent）开发的关键环节](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)——它支撑着效果评估、问题调试和人工标注。但当你的智能体已上线运行、每天生成数千条追踪时，人工审查便完全不可扩展。

![](images/from-traces-to-insights-understanding-agent-behavior-at-scale/img_001.jpg)

![](images/from-traces-to-insights-understanding-agent-behavior-at-scale/img_001.jpg)

When building traditional software, we have product analytics to help with this problem. You [can track agent metrics too](https://docs.langchain.com/langsmith/dashboards?ref=blog.langchain.com)—latency, error rates, feedback. But these metrics only surface problems. To understand the patterns behind them, you need to analyze unstructured conversations—not predefined event flows. Traditional product analytics wasn't built for this. This is exactly why we built [LangSmith Insights Agent](https://docs.langchain.com/langsmith/insights?ref=blog.langchain.com).

在构建传统软件时，我们依赖产品分析（product analytics）来应对这类挑战。你[同样可以追踪智能体的各项指标](https://docs.langchain.com/langsmith/dashboards?ref=blog.langchain.com)——例如延迟（latency）、错误率（error rates）、用户反馈（feedback）等。但这些指标仅能暴露表层问题；若要深入理解其背后的行为模式，你需要分析的是非结构化的对话内容，而非预定义的事件流（event flows）。传统的产品分析工具并非为此类任务而设计。这正是我们打造 [LangSmith Insights Agent](https://docs.langchain.com/langsmith/insights?ref=blog.langchain.com) 的根本原因。

## Why You Can't Predict Agent Behavior

## 为何你无法预测智能体的行为

Building agents is different than building software. There are three key differences from traditional software:

构建智能体与构建传统软件截然不同。二者存在三大关键差异：

**Non-determinism.** When you run software multiple times, you get the same result. This doesn’t happen with agents. Each call to an LLM may produce different results. When you let an agent run for a while and make hundreds of calls in a row, it is highly likely that the same input may produce very different paths.

**非确定性（Non-determinism）**：运行传统软件多次，结果始终一致；而智能体则不然。每次调用大语言模型（LLM）都可能产生不同输出。当一个智能体持续运行、连续发起数百次调用时，同一输入极有可能触发完全不同的执行路径。

**Prompt sensitivity.** Software doesn't change dramatically with small input changes. It is robust to small changes in user input. LLMs have a characteristic called [“prompt sensitivity”](https://arxiv.org/abs/2410.12405?ref=blog.langchain.com). This means small changes in the prompt space can produce large changes in output.

**提示敏感性（Prompt sensitivity）**：传统软件对输入的微小变动不敏感，具备较强的鲁棒性；而大语言模型具有一种被称为[“提示敏感性”](https://arxiv.org/abs/2410.12405?ref=blog.langchain.com)的特性——提示词（prompt）空间中的细微调整，就可能导致输出结果发生巨大变化。

**Unbounded input space.** Software structures user input through UIs. The input space is naturally bounded and scoped by what is in the UI. Agents accept natural language, which is unbounded. Users can enter anything.

**无界输入空间（Unbounded input space）**：传统软件通过用户界面（UI）对用户输入进行结构化约束，因此输入空间天然受限，且由 UI 所定义的范围严格界定；而智能体直接接收自然语言输入——这是一种无界的输入形式，用户可自由输入任何内容。

|  | Software | Agents |
| --- | --- | --- |
| Deterministic | Yes | No |
| 确定性 | 是 | 否 |
| Robust to small changes in user input | Yes | No |
| 对用户输入的微小变化具有鲁棒性 | 是 | 否 |
| Bounded input space | Yes | No |
| 输入空间有界 | 是 | 否 |

_💡 **由于 Agent 具有非确定性，且接受无界输入，因此在投入生产环境之前，你无法预测其行为，也无法预知用户将如何使用它们。**_

## **你需要面向生产环境的分析能力**

## **你需要面向生产环境的分析能力**

Software is deterministic, robust to small changes in user input, and bounded in input space. As a result, you can be pretty sure software is behaving as you expect before you launch to production, and have a suite of tests to assert that. You can discover user behavior by observing production events, but this is constrained by the actions they can take in the UI (this is traditional product analytics).

软件具有确定性，对用户输入的微小变化具备鲁棒性，且输入空间有界。因此，在上线生产环境前，你基本可以确信软件会按预期运行，并可通过一套测试用例加以验证。你也可以通过观察生产环境中的事件来了解用户行为，但这种观察受限于用户在 UI 中所能执行的操作（这属于传统产品分析范畴）。

Agents are non-deterministic and sensitive to small changes in user input. As a result — you don't know what agents will actually do until production. Agents also usually have a natural language interface, giving them a completely unbounded input space. This means there is way more user intent you can capture and analyze.

Agent 具有非确定性，且对用户输入的微小变化高度敏感。因此——你只有在生产环境中才能真正知道 Agent 的实际行为。此外，Agent 通常采用自然语言接口，使其输入空间完全无界。这意味着你能捕获并分析的用户意图远比传统软件丰富得多。

**_💡 在构建 Agent 时，你必须比开发传统软件更频繁地基于生产数据进行迭代。_**

**_💡 在构建 Agent 时，你必须比开发传统软件更频繁地基于生产数据进行迭代。_**

**You need to iterate on how agents fail.** With software, you catch correctness issues pre-production with tests. Maybe some edge cases slip through. With agents, it's the opposite — most failures emerge in production.

**你需要围绕 Agent 的失败方式进行迭代。** 对于软件，你可通过测试在上线前发现正确性问题；尽管某些边界情况可能被遗漏。而对于 Agent，情况恰恰相反——大多数问题只会在生产环境中暴露。

**You need to iterate on how users actually use agents.** With software, users can only use the product as you let them. With agents, natural language means they can use it in far more ways.

**你需要围绕用户实际使用 Agent 的方式来迭代。** 对于软件，用户只能以你设定的方式使用产品；而对于 Agent，自然语言接口意味着用户可用的方式要多得多。

## **传统产品分析是 Agent 迭代的必要条件，但并不充分**

## **传统产品分析是 Agent 迭代的必要条件，但并不充分**

Traditional software generates tons of events (clicks, page views, sessions). Product analytics tools (Mixpanel, Amplitude, etc.) solve the "too much data" problem by:

传统软件会生成海量事件（如点击、页面浏览、会话等）。产品分析工具（如 Mixpanel、Amplitude 等）通过以下方式解决“数据过载”问题：

- Aggregating discrete events into metrics  
- 将离散事件聚合为指标  

- Building funnels and cohorts  
- 构建漏斗分析与用户群组分析  

- A/B testing  
- A/B 测试  

You can (and should) do this with agents as well. We’ve found that most companies in production track end user feedback, latency and tool calls.  
你也可以（而且应当）对智能体（agents）执行此类操作。我们发现，大多数已投入生产的公司都会追踪终端用户反馈、延迟（latency）以及工具调用（tool calls）。

These metrics help you understand what is going on, but not why. In order to understand why these metrics are moving, you need to analyze the traces themselves.  
这些指标有助于你了解“发生了什么”，但无法解释“为何发生”。要理解指标变动背后的原因，你需要直接分析追踪记录（traces）本身。

Online evals help with known questions. You can run evaluators over traces to score for specific things — user frustration, topic tags, success criteria. But online evals require you to know what you're looking for upfront.  
在线评估（online evals）适用于已有明确目标的问题。你可以在追踪记录上运行评估器，对特定维度打分——例如用户挫败感、主题标签、成功标准等。但在线评估的前提是你必须事先明确自己想检测什么。

What about exploratory questions? 'How are users actually using my agent?' 'What failure patterns exist?' You can't write an evaluator for patterns you haven't discovered yet.  
那么，对于探索性问题又该如何应对？例如：“用户究竟如何使用我的智能体？”“存在哪些失败模式？”对于尚未被发现的模式，你根本无法预先编写对应的评估器。

So what does agent analytics actually look like? You need a tool that:  
那么，真正的智能体分析（agent analytics）究竟该是什么样？你需要一款具备以下能力的工具：  

- Analyzes unstructured conversations, not discrete events  
- 分析非结构化的对话内容，而非仅处理离散事件  

- Discovers patterns you didn't know to look for  
- 发现你此前未曾意识到需要关注的模式  

- Surfaces clusters at scale  
- 在海量数据规模下自动呈现有意义的聚类结果  

This is [LangSmith Insights Agent](https://docs.langchain.com/langsmith/insights?ref=blog.langchain.com).  
这就是 [LangSmith Insights Agent](https://docs.langchain.com/langsmith/insights?ref=blog.langchain.com)。

## **LangSmith Insights Agent**  

## **LangSmith Insights Agent**

[LangSmith Insights Agent](https://docs.langchain.com/langsmith/insights?ref=blog.langchain.com) uses clustering to automatically discover patterns in your traces. Instead of defining what to look for upfront, it analyzes thousands of conversations and surfaces the clusters that matter — usage patterns, error modes, or any dimension you specify. It handles the exploratory questions that would otherwise require manually reviewing hundreds of traces.  
[LangSmith Insights Agent](https://docs.langchain.com/langsmith/insights?ref=blog.langchain.com) 借助聚类技术，自动在你的追踪记录中发现潜在模式。它无需你预先定义分析目标，而是直接分析成千上万条对话，自动呈现关键聚类结果——例如使用模式、错误类型，或你指定的任意分析维度。它能高效应对那些原本需人工审阅数百条追踪记录才能回答的探索性问题。

Insights Agent will look for patterns and produce a report. The report will be based around a clustered analysis of the runs. There will be multiple different hierarchies of clusters. There will be top level clusters, then a second level of more detailed groupings, and then individual runs beneath that. You can click through those levels to explore the data at whatever level you think best. This lets you zoom in on specific issues or zoom out for high-level patterns.

Insights Agent 将识别模式并生成报告。该报告将围绕对运行（runs）的聚类分析构建。聚类将呈现多层级结构：顶层聚类、第二层更细致的分组，以及位于其下的单个运行实例。您可逐级点击，按自认为最合适的粒度探索数据——既可聚焦于具体问题，也可宏观把握整体模式。

![](images/from-traces-to-insights-understanding-agent-behavior-at-scale/img_002.png)

You can configure Insights Agent to look for whatever patterns you want. The two most common patterns we see people looking for are:

- How are user’s using my agent?
- How might my agent be failing?

We have prebuilt prompts for these two use cases, but if you want to configure it to look for something else you can specify an arbitrary prompt. Because every agent is different — you might care about compliance, tone, accuracy, or domain-specific failures.

您可以按需配置 Insights Agent 以识别任意模式。目前用户最常关注的两类模式是：

- 用户如何使用我的智能体（agent）？
- 我的智能体可能在哪些方面出现故障？

我们已为这两类典型场景预置了提示词（prompt），但若您希望识别其他模式，也可自定义任意提示词。由于每个智能体各不相同，您可能更关注合规性、语气风格、回答准确性，或特定领域内的故障类型。

![](images/from-traces-to-insights-understanding-agent-behavior-at-scale/img_003.png)

Sometimes you may only want to run Insights Agent over a specific subset of runs. This lets you combine Insights Agent with online evals or traditional product analytics. For example, you may only want to investigate runs that had negative end user feedback (e.g. a thumbs down). You can do this by specifying a filtered set of runs to run Insights Agent over. Combine quantitative signals (thumbs down) with qualitative analysis (what patterns exist in those thumbs down).

有时，您可能仅希望在特定子集的运行上执行 Insights Agent。这使您能将 Insights Agent 与在线评估（online evals）或传统产品分析工具相结合。例如，您或许只想深入分析收到负面终端用户反馈（如“踩”/“拇指向下”）的运行。您可通过指定一个经过筛选的运行集合来实现这一点。将量化信号（如“踩”）与定性分析（这些“踩”的背后存在哪些共性模式）结合起来。

![](images/from-traces-to-insights-understanding-agent-behavior-at-scale/img_004.png)

You can also filter by attributes that don't exist yet. Example: 'Why are users frustrated?' LangSmith Insights Agent can calculate 'user is frustrated' on the fly, then filter and cluster based on it.

您甚至可以基于尚未显式存在的属性进行筛选。例如：“用户为何感到沮丧？” LangSmith Insights Agent 可实时推断出“用户感到沮丧”这一属性，并据此进行筛选与聚类。

![](images/from-traces-to-insights-understanding-agent-behavior-at-scale/img_005.png)

When clusters are produced, it will then aggregate attributes associated with the traces in those groups so you can quickly spot outlier clusters. You can also specify attributes to calculate on the fly (that are then also included in the aggregated stats). Discover patterns you didn't know to track.

当生成聚类后，系统会自动聚合各聚类中追踪（traces）所关联的属性，助您快速识别异常聚类。您还可指定需实时计算的属性（这些属性也将一并纳入聚合统计结果中）。发掘那些您此前未曾意识到需要追踪的行为模式。

![](images/from-traces-to-insights-understanding-agent-behavior-at-scale/img_006.png)

## Try LangSmith Insights Agent

## 尝试 LangSmith Insights Agent

Agents generate thousands of unstructured traces daily. Traditional metrics tell you that something changed, but not what or why. Manual review doesn't scale.

智能体（Agents）每天生成数千条非结构化追踪数据。传统指标仅能告诉您“发生了变化”，却无法说明“发生了什么”或“为何发生”。人工审查则难以应对规模增长。

[LangSmith Insights Agent](https://docs.langchain.com/langsmith/insights?ref=blog.langchain.com) makes pattern discovery practical - surfacing usage patterns and failure modes automatically. It's what makes iterating on production agent data possible.

[LangSmith Insights Agent](https://docs.langchain.com/langsmith/insights?ref=blog.langchain.com) 让模式发现真正落地——自动揭示使用模式与故障模式。这正是实现基于生产环境智能体数据持续迭代的关键所在。

Try it today in LangSmith today.

今天就前往 LangSmith 体验吧。

### Tags

### 标签

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)

[Harrison 的犀利观点](https://blog.langchain.com/tag/in-the-loop/)

[![On Agent Frameworks and Agent Observability](images/from-traces-to-insights-understanding-agent-behavior-at-scale/img_007.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**On Agent Frameworks and Agent Observability**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**关于智能体框架与智能体可观测性**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟

[![In software, the code documents the app. In AI, the traces do.](images/from-traces-to-insights-understanding-agent-behavior-at-scale/img_008.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[![在软件中，代码记录应用行为；在 AI 中，追踪记录（traces）承担这一角色。](images/from-traces-to-insights-understanding-agent-behavior-at-scale/img_008.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**在软件中，代码记录应用行为；在 AI 中，追踪记录（traces）承担这一角色。**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![Agent Frameworks, Runtimes, and Harnesses- oh my!](images/from-traces-to-insights-understanding-agent-behavior-at-scale/img_009.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[![智能体框架、运行时与封装器——天哪！](images/from-traces-to-insights-understanding-agent-behavior-at-scale/img_009.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses- oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**智能体框架、运行时与封装器——天哪！**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：3 分钟

[![Reflections on Three Years of Building LangChain](images/from-traces-to-insights-understanding-agent-behavior-at-scale/img_010.png)](https://blog.langchain.com/three-years-langchain/)

[![构建 LangChain 三年来的思考与感悟](images/from-traces-to-insights-understanding-agent-behavior-at-scale/img_010.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[**构建 LangChain 三年来的思考与感悟**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 分钟阅读

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 6 分钟阅读

[![Not Another Workflow Builder](images/from-traces-to-insights-understanding-agent-behavior-at-scale/img_011.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[![又一个工作流构建器？](images/from-traces-to-insights-understanding-agent-behavior-at-scale/img_011.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[**又一个工作流构建器？**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读

[![Deep Agents](images/from-traces-to-insights-understanding-agent-behavior-at-scale/img_012.png)](https://blog.langchain.com/deep-agents/)

[![深度智能体](images/from-traces-to-insights-understanding-agent-behavior-at-scale/img_012.png)](https://blog.langchain.com/deep-agents/)

[**Deep Agents**](https://blog.langchain.com/deep-agents/)

[**深度智能体**](https://blog.langchain.com/deep-agents/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读
{% endraw %}
