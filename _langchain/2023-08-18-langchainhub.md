---
title: "LangChainHub"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchainhub/"
date: "2023-08-18"
scraped_at: "2026-03-03T08:55:28.227205532+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
{% raw %}

We are excited to announce the launch of the [LangChainHub](https://github.com/hwchase17/langchain-hub?ref=blog.langchain.com), a place where you can find and submit commonly used prompts, chains, agents, and more!

我们很高兴地宣布 [LangChainHub](https://github.com/hwchase17/langchain-hub?ref=blog.langchain.com) 正式上线！这是一个供您查找和提交常用提示词（prompts）、链（chains）、智能体（agents）等资源的平台！

This obviously draws a lot of inspiration from Hugging Face's Hub, which we believe has done an incredible job of fostering an amazing community.

这一构想显然深受 Hugging Face Hub 的启发；我们认为，Hugging Face Hub 在培育卓越社区方面做出了令人瞩目的贡献。

## Motivation

## 初衷与动机

Over the past few months, we’ve seen the LangChain community build a staggering number of applications using the framework. These applications use LangChain components such as prompts, LLMs, chains and agents as building blocks to create unique workflows. We wanted to make it easy to share and discover these workflows by creating a hub where users can share the components they’ve created.

过去几个月间，我们欣喜地看到 LangChain 社区基于该框架构建了数量惊人的应用。这些应用将 LangChain 的各类组件——如提示词（prompts）、大语言模型（LLMs）、链（chains）和智能体（agents）——作为基础模块，组合成各具特色的业务流程。为此，我们决定打造一个中心化平台（即 Hub），方便用户共享自己开发的组件，也便于他人发现和复用这些工作流。

Our goal with LangChainHub is to be a single stop shop for sharing prompts, chains, agents and more. As a starting point, we’re launching the hub with a repository of prompts used in LangChain. Often, the secret sauce of getting good results from an LLM is high-quality prompting, and we believe that having a collection of commonly-used prompts will make it easier for users to get great results without needing to reinvent the wheel. We hope to follow up by adding support for chains and agents shortly.

LangChainHub 的目标是成为分享提示词、链、智能体等资源的一站式平台。作为起步，我们首先在 Hub 中上线了一个涵盖 LangChain 实践中常用提示词的资源库。事实上，从大语言模型（LLM）中获得优质输出的关键往往在于高质量的提示工程（prompting）；我们相信，汇集一批经过验证的常用提示词，将显著降低用户获取理想效果的门槛，避免重复造轮子。接下来，我们将尽快扩展对链（chains）和智能体（agents）的支持。

## Usage

## 使用方式

We don't just want to build a collection of prompts, agents, and chains - we want to make it as easy and as straightforward as possible for people to actually use these. To that end, we are taking two concrete steps:

我们不仅希望构建一个提示词、智能体和链的资源集合，更致力于让这些资源的使用变得尽可能简单、直接。为此，我们已采取以下两项具体措施：

1. We will offer first-class support in the [LangChain Python library](https://github.com/hwchase17/langchain?ref=blog.langchain.com) for loading these artifacts. For example, you are able to easily load a prompt from the hub with the following snippet:

1. 我们将在 [LangChain Python 库](https://github.com/hwchase17/langchain?ref=blog.langchain.com) 中为加载这些资源提供原生级（first-class）支持。例如，您只需如下几行代码，即可轻松从 Hub 加载一个提示词：

```python
from langchain.prompts import load_prompt
prompt = load_prompt('lc://prompts/hello-world/prompt.yaml')
```

2\. We will prioritize clear documentation on how to use these artifacts. For example, all prompts contain not only the artifact itself but also a README file. This file contains information like a description of how it is to be used, the inputs it expects, and a code snippet for how to use this prompt in a chain.

2. 我们将优先确保每项资源都配有清晰详尽的使用文档。例如，每个提示词资源包不仅包含提示词本身，还附带一份 README 文件。该文件详细说明了其用途、所需输入参数，并提供一段代码示例，展示如何在链（chain）中调用该提示词。

For more detailed information on how to use the artifacts on the Hub, check out the documentation on the [Hub itself](https://github.com/hwchase17/langchain-hub?ref=blog.langchain.com).

有关如何在 Hub 上使用各类构件（artifacts）的更详细信息，请参阅 [Hub 官方文档](https://github.com/hwchase17/langchain-hub?ref=blog.langchain.com)。

## Community

## 社区共建

We highly intend this to be community driven. We have seeded the Hub with a collection of artifacts that are used in the core library, but we hope it quickly becomes filled with prompts, chains, and agents that are NOT in the core library.

我们强烈希望这一项目由社区驱动。目前 Hub 已预置了一批在 LangChain 核心库中使用的构件，但我们更期待它能迅速汇聚大量**未被纳入核心库**的提示词（prompts）、链（chains）和智能体（agents）。

Since we are using GitHub to organize this Hub, adding artifacts can best be done in one of two ways:

由于本 Hub 基于 GitHub 进行组织与管理，添加新构件的最佳方式有两种：

1. Create a fork and then open a PR against the repo.  
   1. Fork 该仓库，然后向主仓库提交 Pull Request（PR）。

2. Create an issue on the repo with details of the artifact you would like to add.  
   2. 在仓库中新建一个 Issue，详细说明您希望添加的构件内容。

### Up Next

### 后续规划

Today, LangChainHub contains all of the prompts available in the main `LangChain` Python library.

目前，LangChainHub 已收录 `LangChain` 主 Python 库中全部可用的提示词（prompts）。

In the (hopefully near) future, we plan to add:

在（希望不远的）未来，我们计划新增以下内容：

- Chains: A collection of chains capturing various LLM workflows  
  - 链（Chains）：涵盖多种大语言模型（LLM）工作流的链集合  

- Agents: A collection of agent configurations, including the underlying LLMChain as well as which tools it is compatible with.  
  - 智能体（Agents）：涵盖各类智能体配置的集合，包括其底层所依赖的 `LLMChain`，以及支持调用的工具列表  

- Custom prompts repo URI: The ability to set a custom [URI](https://www.techtarget.com/whatis/definition/URI-Uniform-Resource-Identifier?amp=1&ref=blog.langchain.com) for prompt repositories, so that users can create their own LangChain hubs.  
  - 自定义提示词仓库 URI：支持为提示词仓库设置自定义 [URI](https://www.techtarget.com/whatis/definition/URI-Uniform-Resource-Identifier?amp=1&ref=blog.langchain.com)，使用户能够构建专属的 LangChain Hub。

## Conclusion

## 总结

We are looking forward to the community's contributions and feedback as we continue to build out the Hub. Check it out [here](https://github.com/hwchase17/langchain-hub?ref=blog.langchain.com) and join the conversation on [Discord](https://discord.com/invite/6adMQxSpJS?ref=blog.langchain.com)!

我们热切期待社区在 Hub 持续建设过程中贡献智慧、提出反馈。欢迎点击此处 [访问 Hub](https://github.com/hwchase17/langchain-hub?ref=blog.langchain.com)，并加入 [Discord](https://discord.com/invite/6adMQxSpJS?ref=blog.langchain.com) 社区参与讨论！

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](https://blog.langchain.com/content/images/size/w760/format/webp/2025/12/Evaluating-Deep-Agents.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](https://blog.langchain.com/content/images/size/w760/format/webp/2025/12/Evaluating-Deep-Agents.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](https://blog.langchain.com/content/images/size/w760/format/webp/2025/03/Theme-Fractal-Matrix--Format-Blog--Colour-Green--Text-Alignment-Centred--With-Image-Text-Only.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](https://blog.langchain.com/content/images/size/w760/format/webp/2025/03/Theme-Fractal-Matrix--Format-Blog--Colour-Green--Text-Alignment-Centred--With-Image-Text-Only.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/langchainhub/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/langchainhub/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/langchainhub/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/langchainhub/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/langchainhub/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更便捷的评估](images/langchainhub/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/langchainhub/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项](images/langchainhub/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform 正式进入测试阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[作者：LangChain](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟
{% endraw %}
