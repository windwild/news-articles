---
render_with_liquid: false
title: "LangSmith: Production Monitoring & Automations"
source: "LangChain Blog"
url: "https://blog.langchain.com/langsmith-production-logging-automations/"
date: "2024-04-02"
scraped_at: "2026-03-03T08:04:24.776621843+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

**Key Links:**

**关键链接：**

- [**YouTube 演示视频合集**](https://www.youtube.com/playlist?list=PLfaIDFEXuae0bYV1_60f0aiM0qI7e1zSf&ref=blog.langchain.com)  
- [**立即注册 LangSmith**](https://smith.langchain.com/?ref=blog.langchain.com)

If 2023 was a [breakthrough year for LLMs](https://simonwillison.net/2023/Dec/31/ai-in-2023/?ref=blog.langchain.com), then 2024 is shaping up to be the year that a significant amount of LLM-powered applications make their way into production. From the [Elastic AI Assistant](https://blog.langchain.com/langchain-partners-with-elastic-to-launch-the-elastic-ai-assistant/) to [CommandBar's Copilot User Assistant](https://blog.langchain.com/langchain-partners-with-commandbar-on-their-copilot-user-assistant/) \- more and more complex applications are shipping to production and providing real business value. Many of these applications use LangSmith to [test](https://docs.smith.langchain.com/evaluation?ref=blog.langchain.com) and [debug](https://docs.smith.langchain.com/tracing?ref=blog.langchain.com) their applications, and today we're announcing a set of new features aimed at helping applications post production-deployment.

如果说 2023 年是大语言模型（LLM）的[突破之年](https://simonwillison.net/2023/Dec/31/ai-in-2023/?ref=blog.langchain.com)，那么 2024 年正逐步成为大量 LLM 驱动应用大规模投入生产的元年。从 [Elastic AI 助手](https://blog.langchain.com/langchain-partners-with-elastic-to-launch-the-elastic-ai-assistant/) 到 [CommandBar 的 Copilot 用户助手](https://blog.langchain.com/langchain-partners-with-commandbar-on-their-copilot-user-assistant/)，越来越多结构复杂的应用正陆续上线生产环境，并切实创造商业价值。其中许多应用借助 LangSmith 进行[测试](https://docs.smith.langchain.com/evaluation?ref=blog.langchain.com)与[调试](https://docs.smith.langchain.com/tracing?ref=blog.langchain.com)，而今天，我们正式发布一系列全新功能，旨在助力应用在部署至生产环境后持续优化与演进。

As an [AI Engineer](https://www.ai.engineer/worldsfair?ref=blog.langchain.com), your job doesn't stop once an application is launched to production. Once it's in production you start getting real user data flowing through the system, allowing you to try to answer all sorts of questions. How are people using it? Where is the application messing up? Where is it performing well? How can I improve my application based on this data? How can I start to build a [data flywheel](https://www.ai.engineer/worldsfair?ref=blog.langchain.com)?

作为一位 [AI 工程师](https://www.ai.engineer/worldsfair?ref=blog.langchain.com)，您的工作远不止于将应用部署上线。一旦进入生产环境，真实用户数据便开始持续流入系统，从而为您带来一系列亟待解答的关键问题：用户如何使用该应用？应用在哪些环节出现故障？又在哪些场景下表现优异？我该如何基于这些真实数据持续改进应用？我又该如何着手构建一个[数据飞轮](https://www.ai.engineer/worldsfair?ref=blog.langchain.com)？

In order to make it as easy as possible to address these questions, we're releasing a new set of features around production logging and automations. _Production monitoring_ allows you to more easily manually explore and identify your data, while _automations_ allow you to start acting on this data in an automated way. Like all LangSmith features, these work whether you are using LangChain or not. In the rest of this blog, we will walk through what these features are. You can also check out our [YouTube Playlist](https://www.youtube.com/playlist?list=PLfaIDFEXuae0bYV1_60f0aiM0qI7e1zSf&ref=blog.langchain.com) for video walkthroughs.

为最大限度简化上述问题的解决过程，我们此次推出一组围绕**生产日志记录**与**自动化机制**的新功能。“**生产监控**”（Production Monitoring）让您更轻松地手动探索与识别数据；而“**自动化**”（Automations）则支持您以自动化方式对数据采取行动。与所有 LangSmith 功能一样，这些新特性完全兼容 LangChain —— 同时也**无需依赖 LangChain** 即可独立使用。本文后续将逐一介绍这些功能。您也可观看我们的 [YouTube 视频合集](https://www.youtube.com/playlist?list=PLfaIDFEXuae0bYV1_60f0aiM0qI7e1zSf&ref=blog.langchain.com)，获取直观的操作演示。

## Filtering

## 筛选功能

We've revamped our infrastructure and invested a lot in being able to support advanced filters. These advanced filters are **crucial** for being able to efficiently and thoroughly inspect your data. As a starting point, we support basic filtering of runs based on:

我们已全面重构底层基础设施，并大力投入以支持高级筛选能力。这些高级筛选功能对于**高效、深入地分析您的数据至关重要**。目前，我们已支持基于以下维度对运行记录（runs）进行基础筛选：

- **Latency:** can be used to identify runs that took an inordinate amount of time  
- **延迟（Latency）**：用于识别耗时异常的运行记录  
- **Errors:** can be used to identify runs that hit a breaking error  
- **错误（Errors）**：用于识别触发严重错误的运行记录  
- **Feedback:** can be used to identify runs that users identified as particularly good or bad  
- **反馈（Feedback）**：用于识别用户标记为特别优质或特别糟糕的运行记录  
- **Metadata/Tags:** can be used to filter into subsets of runs based on their configuration  
- **元数据 / 标签（Metadata/Tags）**：用于根据配置信息筛选特定子集的运行记录  
- **Full Text Search:** can be used to search for keywords  
- **全文搜索（Full Text Search）**：支持通过关键词检索运行记录  

![](images/langsmith-production-monitoring-automations/img_001.png)

We also have added in a few more advanced forms of filtering. These include  

此外，我们还新增了若干更高级的筛选方式，包括

**By Trace Attributes**: sometimes you may want to filter for runs based on attributes of the root run of the trace they are a part of. This is especially common when working with chains or agents, where there are multiple sub-runs that make up a larger trace. Oftentimes, you are only collecting feedback on the high level trace. You may want to look for particular types of sub-runs whose parent trace has positive or negative feedback. An example of this might be filtering for runs with name `"ChatOpenAI"` that in which the root run of the trace has a `user_score` equal to `0`.

**按追踪属性筛选（By Trace Attributes）**: 有时您可能希望根据某条追踪（trace）的根运行（root run）的属性来筛选运行记录（runs）。这种情况在处理链（chains）或智能体（agents）时尤为常见——此时一条追踪由多个子运行（sub-runs）组成。通常，您仅在顶层追踪级别收集反馈。因此，您可能希望查找那些父追踪具有正向或负向反馈的特定类型子运行。例如：筛选出名称为 `"ChatOpenAI"` 的运行，且其所属追踪的根运行的 `user_score` 值为 `0`。

**By Tree Attributes**: The reverse of the above. You may want to filter for root runs of traces that have a particular type of sub-run. This can be useful in identifying high level traces that called a particular tool, for example.

**按树状结构属性筛选（By Tree Attributes）**: 这是上述方式的反向操作。您可能希望筛选出那些包含某种特定类型子运行的追踪的根运行。例如，该功能可用于识别调用了某个特定工具的高层级追踪。

**AI Query**: Don't know how to construct your trace in the UI? Type in what you want to search for in natural language and we will use an LLM to convert it to our filtering language! (Yes, we monitor this with LangSmith)

**AI 查询（AI Query）**: 不知道如何在用户界面中构建您的追踪筛选条件？只需用自然语言输入您想搜索的内容，我们将调用大语言模型（LLM）将其自动转换为我们的筛选查询语言！（是的，我们使用 LangSmith 对此功能进行监控。）

## Monitoring

## 监控（Monitoring）

Filtering is useful to be able to identify and look at individual datapoints. Oftentimes, you may want an even more birds eye view of what is happening. In the `Monitoring` tab you can view aggregate statistics over time. These statistics include LLM specific metrics like latency, time-to-first-token, cost, tokens, feedback, etc.

筛选功能有助于识别并查看单个数据点；但很多时候，您可能需要更宏观的全局视角来把握整体运行状况。在 `Monitoring`（监控）标签页中，您可以随时间查看聚合统计指标。这些指标包括面向大语言模型（LLM）的特有指标，例如延迟（latency）、首 Token 延迟（time-to-first-token）、成本（cost）、Token 数量（tokens）、反馈（feedback）等。

![](images/langsmith-production-monitoring-automations/img_002.png)

![](images/langsmith-production-monitoring-automations/img_002.png)

One of the more advanced features here is that you can group runs by metadata attributes. What this means is that you add a metadata tag to runs representing a particular configuration. A concrete example of this is with [ChatLangChain](https://chat.langchain.com/?ref=blog.langchain.com), where we rotate between five different LLM providers. We insert as metadata a key tracking which LLM we chose. In LangSmith, you can then group the monitoring dashboards by this metadata key. This allows us to easily compare all those same stats (latency, feedback, etc) across the five different model providers.

此处一项更高级的功能是：您可依据元数据（metadata）属性对运行记录进行分组。这意味着您可以为运行添加代表特定配置的元数据标签。一个具体示例来自 [ChatLangChain](https://chat.langchain.com/?ref=blog.langchain.com) —— 我们在此项目中轮换使用五种不同的大语言模型提供商。我们会在元数据中插入一个键值，用于记录本次调用所选用的 LLM。在 LangSmith 中，您即可基于该元数据键对监控仪表板进行分组，从而轻松对比这五种不同模型提供商在各项指标（如延迟、反馈等）上的表现。

![](images/langsmith-production-monitoring-automations/img_003.png)

![](images/langsmith-production-monitoring-automations/img_003.png)

Another incredibly useful feature of these charts is that they are all interactive. What this means is that you can click into any particular point in the chart and that will bring you to the `Runs` page automatically filtered to only show datapoints in the timebin you just clicked on.

这些图表另一项极为实用的特性是全部支持交互式操作：您可点击图表中的任意数据点，系统将自动跳转至 `Runs`（运行记录）页面，并已预先筛选，仅显示您刚刚点击的时间区间（timebin）内的所有数据点。

## Threads

## 对话线程（Threads）

The dominant UX for LLM applications is still chat.  
目前，聊天界面仍是大语言模型（LLM）应用的主流用户体验（UX）。

In chat applications, there is a back and forth between human messages and an AI response. Each AI response is a trace (and can consist of many sub-runs).  
在聊天类应用中，人类用户消息与 AI 回复之间持续交替进行。每一次 AI 回复都对应一个 trace（追踪记录），而该 trace 可能包含多个子运行（sub-runs）。

With `Threads`, we've now introduced a way to view the whole back-and-forth of a conversation in a single view. This can be done by attaching a special metadata key to each trace with the unique identifier for that conversation. This makes it much easier to debug conversations as you can see the whole thread in one place.  
借助 `Threads`（会话线程）功能，我们现在支持将整段对话的来回交互在一个视图中完整呈现。实现方式是在每个 trace 中附加一个特殊的元数据键（metadata key），其值为该对话唯一的标识符。这极大简化了对话调试工作——您只需在一个位置即可查看完整的对话线程。

![](images/langsmith-production-monitoring-automations/img_004.png)

## Automations

## 自动化（Automations）

The previous features all make it easy to manually inspect datapoints. With `Automations`, you can now act upon datapoints of interest in an automated fashion.  
前述所有功能均旨在简化对数据点（datapoint）的手动检查。而借助 `Automations`（自动化），您现在可针对感兴趣的特定数据点，自动执行相应操作。

Automations consist of three points: a filter, a sampling rate, and an action. The filter determines which subset of datapoints you want to act on. We talked about filters above, and we can reuse the same UI components to create an automation. After constructing the desired filter, you can then click on the `Add Rule` button to create an automation.  
自动化由三个要素构成：筛选器（filter）、采样率（sampling rate）和动作（action）。筛选器用于确定您希望作用于哪些子集的数据点。前文已介绍过筛选器的概念，此处可复用相同的 UI 组件来构建自动化规则。完成筛选器配置后，点击 `Add Rule`（添加规则）按钮即可创建一条自动化规则。

![](images/langsmith-production-monitoring-automations/img_005.png)

The sampling rate is the next thing to set. This is a rate between 0 and 1 which represents the fraction of the datapoints that meet the filter that you want want to take action on.  
接下来需设置采样率。它是一个介于 0 到 1 之间的数值，表示您希望对“满足筛选条件的数据点”中多大比例的数据点执行后续动作。

There are three actions you can choose from: `Add to Dataset`, `Add to Annotation Queue`, and `Online Evaluation`.  
您可从以下三种动作中任选其一：`Add to Dataset`（加入数据集）、`Add to Annotation Queue`（加入标注队列）和 `Online Evaluation`（在线评估）。

### Add to Dataset

### 加入数据集（Add to Dataset）

The `Add to Dataset` action does exactly what the name suggests: it automatically adds all selected runs to a dataset. The inputs of the run become the inputs of the datapoints, the outputs the outputs, and any metadata or feedback is also copied over.  
`Add to Dataset` 动作正如其名：它会自动将所有符合条件的运行（run）加入指定数据集。其中，运行的输入（inputs）成为数据点的输入，输出（outputs）成为数据点的输出；同时，所有相关元数据（metadata）及用户反馈（feedback）也将一并复制到新生成的数据点中。

This can be used to automatically construct datasets that you can use for testing, few-shot examples, or finetuning. A typical workflow here involves filtering for datapoints that received positive feedback and moving those into a dataset.

这可用于自动构建数据集，供您用于测试、少样本（few-shot）示例或微调（finetuning）。典型的流程包括：筛选出获得正面反馈的数据点，并将这些数据点移入数据集。

### Add to Annotation Queue

### 加入标注队列

The `Add to Annotation Queue` action is also self explanatory. It moves all selected datapoints into an annotation queue. An annotation queue is a user-friendly way to easily inspect datapoints. You can leave feedback, notes, or add to a dataset manually from this queue.

`加入标注队列`（Add to Annotation Queue）操作顾名思义：它会将所有选中的数据点移入一个标注队列。标注队列是一种用户友好的方式，便于快速检查数据点；您可在其中提交反馈、添加备注，或手动将数据点加入数据集。

A common workflow is to send any datapoints with negative feedback into an annotation queue. This allows a reviewer to inspect all datapoints and optionally annotate them with the correct answer and move them to a dataset.

一种常见工作流是：将所有收到负面反馈的数据点送入标注队列。这使审核人员能够集中检查全部数据点，并可选择为其标注正确答案，再将其加入数据集。

### Online Evaluation

### 在线评估

Online evaluation is a brand new feature we're adding, and one we're very excited about. While it may be tough for a human to look at a large number of datapoints — it's quite easy for a language model to do!

在线评估（Online Evaluation）是我们全新推出的、令人倍感振奋的一项功能。虽然人类难以逐一审视大量数据点，但对大语言模型（LLM）而言，这项任务却轻而易举！

The basic idea of `Online Evaluation` is that each run is sent to an LLM to evaluate it according to some criteria. This criteria can be things like "rudeness" (checking if the LLM responded in a rude way) or something completely different like "topic" (classifying the user input into a variety of topics). The criteria is completely configurable.

`在线评估` 的基本思路是：将每一次运行结果发送给一个大语言模型（LLM），由其依据预设标准进行评估。这些标准可以是“粗鲁程度”（判断 LLM 是否做出了不礼貌的回应），也可以是完全不同的维度，例如“主题”（将用户输入分类至多种预设主题中）。所有评估标准均完全可配置。

![](images/langsmith-production-monitoring-automations/img_006.png)

![](images/langsmith-production-monitoring-automations/img_006.png)

## Use Case: Optimization

## 应用场景：优化

We've also added an example use case showing how to combine all these features into a relatively advanced use case. The use case we put together shows how to create an app that can learn over time how to tweet in a style that you like. It does this using a few technologies:

我们还新增了一个示例应用场景，展示如何将上述所有功能整合起来，实现一个相对高级的应用目标。该示例演示了如何构建一款应用——它能随时间推移不断学习，并逐步掌握您所偏好的推文（tweet）风格。其实现依托于若干关键技术：

- Log all traces to LangSmith  
- 将所有追踪记录（traces）记录到 LangSmith  
- Log all feedback to LangSmith, associated with the particular trace  
- 将所有用户反馈记录到 LangSmith，并与对应的追踪记录关联  
- For all traces with positive feedback, move into a dataset  
- 对所有获得正向反馈的追踪记录，将其移入数据集  
- For all traces with negative feedback, move into an annotation queue  
- 对所有获得负向反馈的追踪记录，将其移入标注队列  
- Use the aforementioned dataset as few-shot examples in the application  
- 在应用中将上述数据集用作少样本（few-shot）示例  

You can see a detailed walkthrough [here](https://docs.smith.langchain.com/monitoring/use_cases/optimization?ref=blog.langchain.com).  
您可在此处查看详细操作指南：[此处](https://docs.smith.langchain.com/monitoring/use_cases/optimization?ref=blog.langchain.com)。

## Conclusion  

## 结论  

Launching an LLM application to production is just the first step. With that, you have the gift of beginning to get real user interactions and feedback. It is crucial to capture this information and then also take advantage of it. The more easily you can do that, the more quickly your application can improve. With these "Production Logging & Automations" features, we're making it as easy as possible for you to do that.  

将大语言模型（LLM）应用部署至生产环境，仅仅是第一步。由此，您便拥有了获取真实用户交互与反馈的宝贵机会。及时捕获这些信息并加以有效利用，至关重要。您完成这一过程越便捷，您的应用迭代优化的速度就越快。借助这些“生产环境日志记录与自动化”功能，我们正竭尽所能，让这一切变得尽可能简单。