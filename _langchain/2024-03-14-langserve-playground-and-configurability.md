---
title: "LangServe Playground and Configurability"
source: "LangChain Blog"
url: "https://blog.langchain.com/langserve-playground-and-configurability/"
date: "2024-03-14"
scraped_at: "2026-03-03T08:08:08.987279730+00:00"
language: "en-zh"
translated: true
tags: ["![Extraction Benchmarking", "**Extraction Benchmarking**", "**The Prompt Landscape**", "![Building Chat LangChain", "**Building Chat LangChain**"]
---
{% raw %}

Last week we launched [LangServe](https://blog.langchain.com/introducing-langserve/), a way to easily deploy chains and agents in a production-ready manner. Specifically, it takes a chain and easily spins up a FastAPI server with streaming and batch endpoints, as well as providing a way to stream intermediate steps.

上周，我们推出了 [LangServe](https://blog.langchain.com/introducing-langserve/)，一种轻松以生产就绪方式部署链（chains）和智能体（agents）的方案。具体而言，LangServe 接收一个链，并可快速启动一个配备流式传输（streaming）与批量处理（batch）端点的 FastAPI 服务器，同时还支持流式输出中间步骤。

This week, we're making some additions – a playground and configurability. Both are centered around the same ideas: common architectures, experimentation, and collaboration.

本周，我们新增了两项功能：交互式 Playground（沙盒环境）与可配置性（configurability）。这两项更新均围绕同一核心理念展开：通用架构设计、实验探索与团队协作。

## Playground

## Playground（交互式沙盒）

Now when you use LangServe to deploy your chain you get for free a playground experience. In this playground you can change the values of certain, configurable parameters (more on that later) as well as try out different inputs and get the response streamed back in real time.

现在，当你使用 LangServe 部署自己的链时，将自动获得一个免费的 Playground 体验。在该 Playground 中，你可以修改某些可配置参数的值（后文将详述），同时尝试不同输入，并实时接收流式返回的响应。

The screenshot below is from a playground for [WebLangChain](https://blog.langchain.com/weblangchain/), which you can access [here](https://weblangchain.fly.dev/chat/playground/?ref=blog.langchain.com).

下方截图来自 [WebLangChain](https://blog.langchain.com/weblangchain/) 的 Playground，你可通过此链接访问：[https://weblangchain.fly.dev/chat/playground/?ref=blog.langchain.com](https://weblangchain.fly.dev/chat/playground/?ref=blog.langchain.com)。

![](images/langserve-playground-and-configurability/img_001.png)

![](images/langserve-playground-and-configurability/img_001.png)

Why is this useful?

这一功能为何有用？

First, this immediately provides a (simple) UI for your chains and agents. Although simple, this UI does have necessary things like:

首先，它立即为你的链与智能体提供了一个（简洁的）用户界面（UI）。尽管界面简洁，却已涵盖以下关键功能：

- Streaming outputs  
- 流式输出  
- Full log of intermediate steps  
- 完整的中间步骤日志  
- Configurable options  
- 可配置选项  

This will make it possible to share a link with colleagues and let them interact with in the UI, facilitating collaboration among a larger team. Specifically, we imagine this being a way for engineers to easily expose a way for non-technical folks to interact with their chains/agents (without having to connect it to the frontend).

这使得你可以将链接分享给同事，让他们直接通过 UI 进行交互，从而促进更大规模团队间的协作。具体而言，我们设想这一功能将成为工程师向非技术人员便捷开放其链/智能体交互能力的重要途径（无需将其接入前端系统）。

Second, this provides a way to experiment with different parameters. In the WebLangChain examples, we've exposed multiple different models (Anthropic and OpenAI) as well as multiple different retrievers:

第二，这为尝试不同参数提供了便利途径。在 WebLangChain 示例中，我们已开放了多种模型（Anthropic 和 OpenAI）以及多种检索器：

- [Tavily](https://python.langchain.com/docs/integrations/retrievers/tavily?ref=blog.langchain.com)  
- [You.com](https://blog.langchain.com/you-com-x-langchain/)  
- Google  
- [Kay SEC Retriever](https://python.langchain.com/docs/integrations/retrievers/sec_filings?ref=blog.langchain.com)  
- [Kay Press Release Retriever](https://github.com/langchain-ai/langchain/blob/master/cookbook/press_releases.ipynb?ref=blog.langchain.com)  

This makes it super easy for any one — technical or non-technical — to experiment to different components.

这使得任何人——无论是否具备技术背景——都能极其便捷地尝试不同的组件。

## Configurability

## 可配置性

One new feature which makes this experimentation possible is configuration of runnables. Specifically, we recently added syntax to allow for any components (or parts of components) to be configurable. This is doable whether you are using LangServe or not — it's just part of LangChain Expression Language. See our cookbook for this [here](https://python.langchain.com/docs/expression_language/how_to/configure?ref=blog.langchain.com).

使上述实验成为可能的一项新特性是“可运行组件（runnables）”的可配置性。具体而言，我们近期新增了语法支持，允许任意组件（或组件的任意部分）均可配置。该功能无需依赖 LangServe 即可使用——它本身就是 LangChain 表达式语言（LangChain Expression Language）的一部分。相关用法请参阅我们的[配方指南（cookbook）](https://python.langchain.com/docs/expression_language/how_to/configure?ref=blog.langchain.com)。

We've now exposed this configuration in a few places. First, as seen above, we've easily exposed this in the playground. However, this configuration can be used outside of the playground. We've also exposed it in our main WebLangChain app.

目前，我们已在多个位置开放了此项配置能力。首先，如上文所示，我们在 Playground 中已便捷地开放了该配置；但该配置能力不仅限于 Playground 内部使用，我们也已在主 WebLangChain 应用中全面开放。

![](images/langserve-playground-and-configurability/img_002.png)

With configuration, you can save different versions of configurations via a URL. This can be used in a few ways. With WebLangChain, we expose this to the end user so that they can use that configuration in the UI. We imagine this more being used for internal apps, where you want to let internal users choose between different configuration options. We also expose this functionality in the playground, as seen below where you can copy a URL for a given configuration.

借助配置能力，您可通过 URL 保存不同版本的配置。其用途多样：在 WebLangChain 中，我们将此能力向终端用户开放，使其可在 UI 中直接应用对应配置；我们更预期该能力将广泛应用于企业内部应用——例如，让内部用户在多种预设配置间自由切换。此外，Playground 同样集成了该功能，如下图所示，您可一键复制当前配置对应的 URL。

![](images/langserve-playground-and-configurability/img_003.png)

Note that for configuration options, the configuration is currently not persisted. We are currently alpha testing a deployment platform where the configuration is persisted — and can be persisted for multiple different users. If this is interesting to you, please reach out to sales@langchain.dev.

请注意：当前配置选项**不会被持久化保存**。我们正在对一个支持配置持久化的部署平台进行 Alpha 测试——该平台可为多位不同用户分别持久化保存其个性化配置。若您对此感兴趣，欢迎联系 sales@langchain.dev。

## Common Architectures

## 常见架构

We see that there are common architectures for LLM applications fast emerging. These architectures are fairly generalizable, and can parametrized in a few different ways. This observation is motivating a lot of this work.

我们观察到，大语言模型（LLM）应用的常见架构正迅速涌现。这些架构具有较强的通用性，且可通过若干不同方式进行参数化。这一观察推动了当前大量相关工作的开展。

For example, let's look at at our [WebLangChain](https://github.com/langchain-ai/weblangchain?ref=blog.langchain.com) app from last week. This is a cognitive architecture aimed at retrieval augmented generation, and the ways it can be configured are:

例如，让我们回顾上周发布的 [WebLangChain](https://github.com/langchain-ai/weblangchain?ref=blog.langchain.com) 应用。这是一个面向检索增强生成（RAG）的认知架构，其可配置项包括：

- LLM to use to answer  
  用于生成答案的大语言模型  
- Prompt to use to generate the search query for followups  
  用于生成后续检索查询的提示词（Prompt）  
- Prompt to use to generate the answer  
  用于生成最终答案的提示词（Prompt）  
- Retriever to use to look up queries  
  用于执行查询检索的检索器（Retriever）

We see that the architecture of the app often takes a lot of engineering to get up and running. But after that, a lot of the configuration is best done in some sort of GUI. This enables easier collaboration.

我们发现，该应用架构的搭建与部署往往需要大量工程投入；但一旦完成基础建设，大部分配置工作更适合通过某种图形用户界面（GUI）来完成——这有助于提升团队协作效率。

This insight - and belief that this is a good path towards application development - is driving a lot of our work in this vein.

这一洞见——以及我们对“GUI 辅助配置是应用开发的合理路径”这一理念的坚定信念——正成为我们在该方向持续投入的核心驱动力。

### Tags

### 标签

[![Extraction Benchmarking](images/langserve-playground-and-configurability/img_004.jpg)](https://blog.langchain.com/extraction-benchmarking/)

[**Extraction Benchmarking**](https://blog.langchain.com/extraction-benchmarking/)

[![Applying OpenAI's RAG Strategies](images/langserve-playground-and-configurability/img_005.png)](https://blog.langchain.com/applying-openai-rag/)

[**Applying OpenAI's RAG Strategies**](https://blog.langchain.com/applying-openai-rag/)

[**应用 OpenAI 的 RAG 策略**](https://blog.langchain.com/applying-openai-rag/)


[![A Chunk by Any Other Name: Structured Text Splitting and Metadata-enhanced RAG](images/langserve-playground-and-configurability/img_006.png)](https://blog.langchain.com/a-chunk-by-any-other-name/)

[**A Chunk by Any Other Name: Structured Text Splitting and Metadata-enhanced RAG**](https://blog.langchain.com/a-chunk-by-any-other-name/)

[**换一个名字还叫“块”吗？结构化文本切分与元数据增强的 RAG**](https://blog.langchain.com/a-chunk-by-any-other-name/)


[**The Prompt Landscape**](https://blog.langchain.com/the-prompt-landscape/)

[**提示词生态全景图**](https://blog.langchain.com/the-prompt-landscape/)


[![Building Chat LangChain](images/langserve-playground-and-configurability/img_007.png)](https://blog.langchain.com/building-chat-langchain-2/)

[**Building Chat LangChain**](https://blog.langchain.com/building-chat-langchain-2/)

[**构建 Chat LangChain**](https://blog.langchain.com/building-chat-langchain-2/)
{% endraw %}
