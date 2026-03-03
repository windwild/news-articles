---
title: "Test Run Comparisons"
source: "LangChain Blog"
url: "https://blog.langchain.com/test-run-comparisons/"
date: "2023-10-17"
scraped_at: "2026-03-03T08:34:20.422546234+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---

> One pattern I noticed is that great AI researchers are willing to manually inspect lots of data. And more than that, they build infrastructure that allows them to manually inspect data quickly. Though not glamorous, manually examining data gives valuable intuitions about the problem.  
>   
> [\- Jason Wei, OpenAI](https://twitter.com/_jasonwei/status/1708921475829481683?s=20&ref=blog.langchain.com)

> 我注意到一个现象：顶尖的 AI 研究者乐于人工检查大量数据；不仅如此，他们还会构建基础设施，以支持快速人工检查数据。尽管这项工作并不光鲜，但人工审视数据却能带来关于问题的宝贵直觉。  
>   
> [\- Jason Wei，OpenAI](https://twitter.com/_jasonwei/status/1708921475829481683?s=20&ref=blog.langchain.com)

Evaluations continue to be one of the hardest parts of building LLM applications. It's really tough to evaluate in a quantitative way the effect of changes to your prompt, chain, or agent. We're bullish on [LLM-assisted evaluation](https://docs.smith.langchain.com/evaluation/evaluator-implementations?ref=blog.langchain.com), but, at the same time, we definitely recognize that it's hard to have complete trust in them.

评估环节至今仍是构建大语言模型（LLM）应用过程中最具挑战性的环节之一。要以量化方式评估提示词（prompt）、链（chain）或智能体（agent）变更所带来的影响，难度极大。我们对[大语言模型辅助评估（LLM-assisted evaluation）](https://docs.smith.langchain.com/evaluation/evaluator-implementations?ref=blog.langchain.com)持乐观态度；但与此同时，我们也清醒地认识到：完全信任这类评估结果仍十分困难。

Jason's tweet above sums up what we see a lot of the best researchers (and engineers) doing. They want to manually inspect data to gain intuition about the problem. At LangChain, we want to build the infrastructure to help do that - which is why we're excited to announce Test Run Comparisons today.

杰森（Jason）上述推文精准概括了我们观察到的众多顶尖研究人员（及工程师）的共性做法：他们希望通过人工检查数据来加深对问题的理解与直觉。在 LangChain，我们的目标正是构建支撑此类工作的基础设施——正因如此，我们非常高兴地宣布今日正式推出「测试运行对比（Test Run Comparisons）」功能。

In the [initial release of LangSmith](https://blog.langchain.com/announcing-langsmith/) we had support for running tests, including scoring them with LLM-assisted feedback. However, each test was run in isolation. We quickly saw two usage patterns emerge:

- People are still hesitant to trust the LLM-assisted feedback directly  
- Users often wanted to not only score their test run in isolation, but also compare it to previous iterations  

在 [LangSmith 的初始发布版本](https://blog.langchain.com/announcing-langsmith/) 中，我们已支持运行测试，并可通过大语言模型辅助反馈（LLM-assisted feedback）为测试结果打分。然而，当时每次测试均彼此隔离、独立运行。我们很快观察到两类典型使用模式：

- 用户仍对直接采信大语言模型辅助反馈持谨慎甚至犹豫态度；  
- 用户不仅希望对单次测试运行进行独立评分，更常需要将其与历史迭代版本进行横向对比。

When building Test Run Comparisons, we kept both of these insights in mind. We wanted to create an easy UX to see multiple test runs side-by-side. We also wanted to create an easy UX where people could use LLM-assisted evals (or regex/other eval) to get an initial score, then manually explore those datapoints for further insights.

在设计「测试运行对比」功能时，我们始终将上述两点洞察铭记于心：一方面，我们致力于打造简洁直观的用户体验（UX），让用户能轻松并排查看多次测试运行结果；另一方面，我们也希望提供便捷的交互路径——用户可先借助大语言模型辅助评估（或正则表达式/其他评估方式）获得初步分数，再人工深入探索相关数据点，从而挖掘更深层次的洞见。

So how does it work?

那么，它具体如何运作？

First, you need to set up a dataset and run some tests. See [documentation here](https://docs.smith.langchain.com/evaluation?ref=blog.langchain.com) for instructions on how to do that. Nothing new here, so if you've already done that for an existing project you're all good.

首先，您需创建一个数据集并运行若干测试。具体操作步骤请参阅[此处文档](https://docs.smith.langchain.com/evaluation?ref=blog.langchain.com)。该流程并无新意——若您已在现有项目中完成过此步骤，则可直接进入下一步。

Inside a dataset, you can easily select two (or more) test runs, then click `Compare`.

在数据集界面内，您可轻松选中两次（或更多次）测试运行，随后点击 `Compare`（对比）按钮。

![](images/test-run-comparisons/img_001.png)

From there, you will be brought into the Test Run Comparison view. This should look like the below

从那里，您将进入“测试运行对比”视图。界面应如下所示：

![](images/test-run-comparisons/img_002.png)

![](images/test-run-comparisons/img_002.png)

You can easily see the inputs, the reference output, and then the actual output for each datapoint — along with any eval metrics, time and latency for that run.

您可以清晰地查看每个数据点的输入、参考输出和实际输出，以及该次运行所对应的评估指标、耗时和延迟。

This view is designed to make it easy to quickly compare test runs across the same inputs. If you want a deeper look at a particular datapoint, you can click on that row and sidebar will pop up allowing you to drill down into the details of those runs.

该视图旨在帮助您快速对比相同输入下的不同测试运行。若您希望深入查看某个特定数据点，只需点击对应行，右侧边栏便会弹出，供您进一步查看这些运行的详细信息。

![](images/test-run-comparisons/img_003.png)

![](images/test-run-comparisons/img_003.png)

On that sidebar, we've also added up and down carets (▲ and ▼) to easily flip between runs.

在该侧边栏中，我们还添加了上下箭头（▲ 和 ▼），方便您在不同运行间快速切换。

This view should hopefully make it easy to compare runs for a particular datapoint. But how do you know what datapoints to be looking at?

该视图应能帮助您轻松对比某一特定数据点在各次运行中的表现。但您该如何确定该重点关注哪些数据点呢？

We've added filters for each column — similar to Excel. Using these filters, you can filter the rows according to any criteria.

我们为每一列都添加了筛选器（功能类似于 Excel）。借助这些筛选器，您可以按任意条件对行进行过滤。

💡

💡

The criteria we recommend using to start? Filter one test run to datapoints it got correct, and the other one to datapoints that it got incorrect. This allows you to quickly drill on places of significant difference between the two test runs, which should more easily allow you to discover what has changed.

我们建议的初始筛选策略是什么？将一次测试运行筛选为“结果正确的数据点”，另一次则筛选为“结果错误的数据点”。这样，您便能快速聚焦于两次测试运行之间差异显著的位置，从而更高效地识别出发生了哪些变化。

![](images/test-run-comparisons/img_004.png)

![](images/test-run-comparisons/img_004.png)

Building an LLM application is hard. A big part of that is understanding how the LLM is working on a particular task. Setting up an evaluation dataset and then being able to easily compare runs on that dataset is crucial for developing the understanding needed to improve the application. Test Run Comparison in LangSmith aimed at solving this problem. Please let us know any feedback you have!

构建一个大语言模型（LLM）应用非常困难。其中一大难点在于理解 LLM 在特定任务上的实际工作方式。建立评估数据集，并能便捷地在该数据集上对比不同运行结果，对于深入理解应用表现、进而持续优化至关重要。LangSmith 中的“测试运行对比”（Test Run Comparison）功能正是为解决这一问题而设计。欢迎随时向我们反馈您的意见和建议！

LangSmith is in private beta - [sign up here](https://smith.langchain.com/?ref=blog.langchain.com). We'll be rolling out more access over the next few weeks, as well as continuing to add features like this.

LangSmith 目前处于私测阶段 —— [立即注册体验](https://smith.langchain.com/?ref=blog.langchain.com)。未来几周我们将逐步扩大访问权限，同时持续新增此类实用功能。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/test-run-comparisons/img_005.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/test-run-comparisons/img_005.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/test-run-comparisons/img_006.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中全面支持 OpenTelemetry 端到端追踪](images/test-run-comparisons/img_006.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中推出端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/test-run-comparisons/img_007.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/test-run-comparisons/img_007.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/test-run-comparisons/img_008.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/test-run-comparisons/img_008.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/test-run-comparisons/img_009.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![借助 LangSmith SDK v0.2 实现更便捷的评估](images/test-run-comparisons/img_009.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**借助 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/test-run-comparisons/img_010.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项](images/test-run-comparisons/img_010.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)