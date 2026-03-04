---
render_with_liquid: false
title: "GPT Researcher x LangChain"
source: "LangChain Blog"
url: "https://blog.langchain.com/gpt-researcher-x-langchain/"
date: "2023-08-17"
scraped_at: "2026-03-03T09:10:56.539141973+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
render_with_liquid: false
render_with_liquid: false

Here at LangChain we think that web research is fantastic use case for LLMs. So much so that we wrote a [blog on it](https://blog.langchain.com/automating-web-research/) about a month ago. In that blog we mentioned the leading open-source implementation of a research assistant - [gpt-researcher](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com). Today we're excited to announce that GPT Researcher is integrated with LangChain. Specifically, it is integrated with our OpenAI adapter, which allows (1) easy usage of other LLM models under the hood, (2) easy logging with LangSmith.

在 LangChain，我们认为网络研究是大语言模型（LLM）一项极为出色的应用场景。其价值之高，促使我们约一个月前专门撰写了相关[博客文章](https://blog.langchain.com/automating-web-research/)。该文中，我们提到了当前领先的开源研究助手实现——[gpt-researcher](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com)。今天，我们非常高兴地宣布：GPT Researcher 已正式集成至 LangChain。具体而言，它已与我们的 OpenAI 适配器完成集成，从而支持：（1）底层便捷切换使用其他大语言模型；（2）与 LangSmith 无缝对接，实现便捷的日志记录。

What is GPT Researcher? From the GitHub repo:

GPT Researcher 是什么？根据其 GitHub 仓库说明：

> The main idea is to run "planner" and "execution" agents, whereas the planner generates questions to research, and the execution agents seek the most related information based on each generated research question. Finally, the planner filters and aggregates all related information and creates a research report. The agents leverage both gpt3.5-turbo-16k and gpt-4 to complete a research task.
>
> More specifcally:
>
> \- Generate a set of research questions that together form an objective opinion on any given task.
>
> \- For each research question, trigger a crawler agent that scrapes online resources for information relevant to the given task.
>
> \- For each scraped resources, summarize based on relevant information and keep track of its sources.
>
> \- Finally, filter and aggregate all summarized sources and generate a final research report.

> 其核心设计是运行两类智能体：“规划器”（planner）与“执行器”（execution）。“规划器”负责生成一系列待研究的问题，而“执行器”则针对每个问题，检索并获取最相关的信息。最终，“规划器”对所有相关信息进行筛选与整合，并生成一份完整的研究报告。整个流程中，系统同时调用 `gpt-3.5-turbo-16k` 和 `gpt-4` 模型协同完成研究任务。
>
> 更具体地说：
>
> \- 生成一组研究问题，使这些问题共同构成对任一给定任务的客观分析视角；
>
> \- 针对每个研究问题，触发一个爬虫智能体，从网络资源中抓取与该任务高度相关的信息；
>
> \- 对每条抓取到的资源，依据其相关内容进行摘要提炼，并完整保留其原始来源信息；
>
> \- 最终，对所有摘要内容进行筛选与聚合，生成一份最终研究报告。

An image of the architecture can be seen below.

下图展示了该系统的整体架构：

![](images/gpt-researcher-x-langchain/img_001.png)

Under the hood this uses OpenAI's `ChatCompletion` endpoint. As number of viable models has started to increase (Anthropic, Llama2, Vertex models) we've been chatting with the GPT Researcher team about integrating LangChain. This would allow them to take advantage of the [~10 different Chat Model integrations](https://python.langchain.com/docs/integrations/chat/?ref=blog.langchain.com) that we have. It would also allow users to take advantage of [LangSmith](https://blog.langchain.com/announcing-langsmith/) \- our recently announced debugging/logging/monitoring platform.

该实现底层调用的是 OpenAI 的 `ChatCompletion` 接口。随着可用大模型数量持续增长（如 Anthropic 的 Claude、Llama2、Google Vertex AI 等），我们一直与 GPT Researcher 团队积极沟通，探讨 LangChain 集成方案。此举将使其能够充分利用 LangChain 目前提供的[约 10 种不同聊天模型接入能力](https://python.langchain.com/docs/integrations/chat/?ref=blog.langchain.com)；同时也将使用户受益于我们最新发布的 [LangSmith](https://blog.langchain.com/announcing-langsmith/) 平台——一个专为调试、日志记录与系统监控打造的统一工具平台。

In order to make this transition as seamless as possible we added an OpenAI adapter that can serve as a drop-in replacement for OpenAI. For a full walkthrough of this adapter, see the documentation [here](https://python.langchain.com/docs/guides/adapters/openai?ref=blog.langchain.com). This adapter can be use by the following code swap:

为最大限度降低迁移成本，我们新增了一个 OpenAI 适配器（OpenAI Adapter），可作为 OpenAI 官方 SDK 的即插即用式替代方案。关于该适配器的完整使用指南，请参阅[此处文档](https://python.langchain.com/docs/guides/adapters/openai?ref=blog.langchain.com)。只需进行如下代码替换即可启用：

```
- import openai
+ from langchain.adapters import openai
```

See [here](https://github.com/assafelovic/gpt-researcher/pull/124?ref=blog.langchain.com) for the full PR enabling it on the GPT Researcher repo.

有关该功能在 GPT Researcher 仓库中的完整 Pull Request，请见[此处](https://github.com/assafelovic/gpt-researcher/pull/124?ref=blog.langchain.com)。

The first benefit this provides is enabling easy usage of other models. By passing in `provider="ChatAnthropic", model="claude-2",` to create, you easily use Anthropic's Claude model.

这一集成带来的首要优势，便是轻松支持多种模型切换。例如，在初始化时传入参数 `provider="ChatAnthropic", model="claude-2"`，即可便捷调用 Anthropic 公司的 Claude 模型。

The second benefit this provides is seamless integration with LangSmith.  
这一功能带来的第二个好处是与 LangSmith 的无缝集成。

Under the hood, GPT Researcher makes many separate LLM calls. This complexity is a big part of why it's able to perform so well. As the same time, this complexity can also make it more difficult to debug and understand what is going on. By enabling LangSmith, you can easily track that.  
在底层，GPT Researcher 会发起大量独立的 LLM 调用。这种复杂性正是其卓越性能的关键原因之一；但与此同时，这种复杂性也使得调试和理解系统内部运行机制变得更加困难。启用 LangSmith 后，您便能轻松追踪整个调用过程。

For example, here is the [LangSmith trace](https://smith.langchain.com/public/84fb4bdc-f228-4192-a265-06f169b7d657/r?ref=blog.langchain.com) for the call to the language model when it's generating an agent description to use:  
例如，以下是语言模型在生成待用 Agent 描述时所触发的 [LangSmith 追踪记录](https://smith.langchain.com/public/84fb4bdc-f228-4192-a265-06f169b7d657/r?ref=blog.langchain.com)：

And here is the [LangSmith trace](https://smith.langchain.com/public/37aa9e0a-ed65-4f9e-97eb-866b1bfa61f3/r?ref=blog.langchain.com) for the final call to the language model — when it asks it to write the final report:  
而以下是语言模型在最终撰写报告时所触发的 [LangSmith 追踪记录](https://smith.langchain.com/public/37aa9e0a-ed65-4f9e-97eb-866b1bfa61f3/r?ref=blog.langchain.com)：

![](images/gpt-researcher-x-langchain/img_002.png)

We're incredibly excited to be supporting GPT Researcher. We think this is one of the biggest opportunities for LLMs. We also think GPT Researcher strikes an appropriate balance, where the architecture is certainly very complex but it's more focused than a completely autonomous agent. We think applications that manage to strike that balance are the future, and we're very excited to be able to partner with and support them in any way.  
我们非常激动能够支持 GPT Researcher。我们认为，这是大语言模型（LLM）最具潜力的应用方向之一。同时我们也认为，GPT Researcher 在架构设计上实现了恰到好处的平衡：其系统固然高度复杂，但又比完全自主的 Agent 更加聚焦、可控。我们认为，能够实现这种平衡的应用代表了未来的发展方向；而我们亦十分期待能以任何形式与之合作并提供支持。

### Tags  
### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)  
[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/gpt-researcher-x-langchain/img_003.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)  
[![深度 Agent 评估：我们的经验总结](images/gpt-researcher-x-langchain/img_003.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)  
[**深度 Agent 评估：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 分钟阅读

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/gpt-researcher-x-langchain/img_004.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 分钟阅读

[![LangChain State of AI 2024 Report](images/gpt-researcher-x-langchain/img_005.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能发展报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[![Introducing OpenTelemetry support for LangSmith](images/gpt-researcher-x-langchain/img_006.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![Easier evaluations with LangSmith SDK v0.2](images/gpt-researcher-x-langchain/img_007.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更轻松的评估](images/gpt-researcher-x-langchain/img_007.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**LangSmith SDK v0.2：更轻松的评估体验**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/gpt-researcher-x-langchain/img_008.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项](images/gpt-researcher-x-langchain/img_008.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台正式开启 Beta 测试：为可扩展智能体基础设施提供全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟