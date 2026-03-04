---
title: "Launching LangGraph Templates"
source: "LangChain Blog"
url: "https://blog.langchain.com/launching-langgraph-templates/"
date: "2024-09-19"
scraped_at: "2026-03-03T07:52:54.660208086+00:00"
language: "en-zh"
translated: true
---
{% raw %}

**Today we are excited to announce** [**LangGraph templates**](https://langgraph-studio.vercel.app/?ref=blog.langchain.com) **, available in both Python and JS. These template repositories address common use cases and are designed for easy configuration and deployment to** [**LangGraph Cloud**](https://langchain-ai.github.io/langgraph/cloud/?ref=blog.langchain.com) **. The best way to use these is to download the newest version of** [**LangGraph Studio**](https://github.com/langchain-ai/langgraph-studio?ref=blog.langchain.com) **, but you can also use them as standalone GitHub repos.**

**今天，我们非常高兴地宣布推出** [**LangGraph 模板**](https://langgraph-studio.vercel.app/?ref=blog.langchain.com) **，支持 Python 和 JavaScript 双语言。这些模板仓库覆盖了常见应用场景，专为便捷配置与一键部署至** [**LangGraph Cloud**](https://langchain-ai.github.io/langgraph/cloud/?ref=blog.langchain.com) **而设计。使用这些模板的最佳方式是下载最新版的** [**LangGraph Studio**](https://github.com/langchain-ai/langgraph-studio?ref=blog.langchain.com) **，当然您也可以将它们作为独立的 GitHub 仓库直接使用。**

/0:12

1×

Over the past year, we've repeatedly seen that real-world "agentic" applications require careful crafting. Developers need to build controlled workflows and adapt patterns to their specific needs.

过去一年中，我们反复观察到：真实世界中的“智能体（agentic）”应用需要精心设计。开发者必须构建受控的工作流，并根据自身具体需求调整架构模式。

This led us to invest in developing [LangGraph](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com), our low-level framework for orchestrating agentic apps that provides fine-grained control over your applications.

这促使我们投入资源开发 [LangGraph](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com) —— 我们面向智能体应用编排的底层框架，可为您提供对应用行为的细粒度控制。

But this focus on low-level control comes with a tradeoff. We've created fewer high-level, end-to-end abstractions. While we've seen these abstractions generally need to be modified en route to production, they are still a helpful starting point for any new project.

但这种对底层控制的专注也带来了一定权衡：我们构建的高层、端到端抽象相对较少。尽管我们发现这类抽象在通往生产环境的过程中通常仍需调整，但它们仍是任何新项目极有价值的起点。

That's why we're introducing [LangGraph Templates.](https://langgraph-studio.vercel.app/?ref=blog.langchain.com) They offer easy entry points for new and experienced developers alike, clearly exposing the agent's low-level functionality, so you can maintain detailed control as your project grows. We're releasing these today to help you build and deploy sophisticated agentic applications to solve real problems.

因此，我们正式推出 [LangGraph 模板](https://langgraph-studio.vercel.app/?ref=blog.langchain.com)。无论新手还是资深开发者，都能借此快速上手；模板清晰暴露智能体的底层功能，让您在项目演进过程中始终保有精细控制能力。我们今日发布这些模板，旨在助您构建并部署功能强大的智能体应用，切实解决现实问题。

## Why templates?

## 为何选择模板？

We chose templates because this makes it easy to modify the inner functionality of the agents. With templates, you clone the repo — you then have access to all the code, so you can change prompts, chaining logic, and do anything else you want!

我们选择模板形式，是因为它让修改智能体内部功能变得轻而易举。使用模板时，您只需克隆代码仓库——即可获得全部源码，从而自由调整提示词（prompts）、链式逻辑（chaining logic），或执行任何其他自定义操作！

To us, this provides a good balance between making it easy to get started while still allowing for this controllability. If these high level interfaces were in a library (like LangChain) that may make it easier to get started, but it’s much trickier to modify the underlying code (you’d have to go find the source code and copy-paste that). As we were preparing this launch, a tweet from Andrzej Dabrowski summed it up nicely: ["We don't need abstractions, we need templates"](https://x.com/hwchase17/status/1836603904899060165?ref=blog.langchain.com).

对我们而言，模板在“快速入门”与“高度可控”之间取得了良好平衡。倘若这些高层接口被封装进某个库（例如 LangChain），虽可能略微简化初始上手流程，却会极大增加底层代码的修改难度（您不得不去查找源码并手动复制粘贴）。在本次发布筹备期间，Andrzej Dabrowski 在推特上的一句话精准概括了这一理念：[“我们不需要抽象，我们需要模板”](https://x.com/hwchase17/status/1836603904899060165?ref=blog.langchain.com)。

With templates, we can also set them up in a way where they are as easy to debug and deploy as possible. All templates are structured in a way where they can be loaded in LangGraph Studio for debugging or deployed with one-click to LangGraph Cloud.

借助模板，我们还可以以尽可能便于调试和部署的方式对其进行配置。所有模板均采用统一结构设计，既可直接在 LangGraph Studio 中加载用于调试，也可一键部署至 LangGraph Cloud。

## Configurable templates

## 可配置的模板

These templates will naturally use language models, vector stores, and tools. There are a lot of options to choose from! We want to make these templates configurable, so you can the providers you want.

这些模板天然集成了大语言模型、向量数据库和各类工具，且提供了丰富的选项供您选择！我们的目标是让这些模板具备高度可配置性，使您能自由选用自己偏好的服务提供商。

The way we will do this by making certain fields configurable in the graph itself. We will then provide descriptions of the options you can choose as part of this configuration. If you are loading a template as part of LangGraph Studio, you will be walked through a set up step in which you select the providers you want.

我们将通过在图（graph）本身中设置若干可配置字段来实现这一目标；同时，我们会为每个可选配置项提供清晰的说明文档。若您在 LangGraph Studio 中加载模板，系统将引导您完成初始化配置流程，让您轻松选定所需的服务提供商。

![](images/launching-langgraph-templates/img_001.png)

![](images/launching-langgraph-templates/img_001.png)

To start, we do not want to have templates that are specific to a singular provider. Our hope is that all templates are written in a way where they do not depend on the peculiarities of a provider. We will work on our base abstractions in LangChain to make sure this is the case.

初始阶段，我们刻意避免设计仅适配单一服务商的模板。我们的愿景是：所有模板均以通用、解耦的方式编写，不依赖任何特定服务商的独特实现细节。为此，我们将持续完善 LangChain 中的基础抽象层，确保这一目标得以实现。

We are purposefully starting with a small number of providers, but will gradually expand the number.

我们有意从少量优质服务商起步，后续将逐步扩大支持范围。

## A small number of high quality templates

## 少而精的高质量模板

For this initial launch we are explicitly focusing on a small number of high quality templates. We are only launching with three templates, but will slowly add more over time. The three templates we are starting with are:

本次首发，我们明确聚焦于数量精简但质量上乘的模板。首批仅上线三款模板，后续将循序渐进地持续扩充。首批推出的三款模板为：

**RAG Chatbot**

**RAG 聊天机器人**

This is common architecture we see - a chatbot over a specific source of data. This chatbot will do a retrieval step from an Elastic or other search index and then generate a response based on the retrieved data.

这是我们常见的架构——一个面向特定数据源的聊天机器人。该聊天机器人将首先从 Elastic 或其他搜索索引中执行检索步骤，然后基于检索到的数据生成响应。

**ReAct Agent**

**ReAct 代理**

The ReAct agent architecture is the most generic agent architecture out there. This architecture will use tool calling to select the correct tools to call, and loop until done.

ReAct 代理架构是目前最通用的代理架构。该架构通过工具调用（tool calling）来选择需调用的正确工具，并持续循环执行，直至任务完成。

**Data Enrichment Agent**

**数据增强代理**

This is a slightly more specific agent that is aimed at conducting research to fill out a specific form. It uses a [ReAct](https://arxiv.org/abs/2210.03629?ref=blog.langchain.com) agent architecture with search tools to do the research, and then a reflection step to check whether its response is accurate or more research need to be done. You can see a YouTube walkthrough of this agent [here](https://youtu.be/mNxAM1ETBvs?ref=blog.langchain.com).

这是一种稍具针对性的代理，旨在开展研究工作以填写特定表单。它采用基于 [ReAct](https://arxiv.org/abs/2210.03629?ref=blog.langchain.com) 的代理架构，结合搜索类工具开展研究，并在后续加入“反思”（reflection）步骤，以检验其响应是否准确，或是否还需进一步研究。您可在此处观看该代理的 YouTube 演示视频：[点击观看](https://youtu.be/mNxAM1ETBvs?ref=blog.langchain.com)。

We’ve also included a fourth template that is **empty**. This can be used to start building a LangGraph application from scratch.

我们还额外提供了一个**空白模板**。该模板可用于从零开始构建 LangGraph 应用。

## Conclusion

## 结论

LangGraph has proven to be very configurable and very customizable, and we’re confident that it is a solid foundation for agent architectures. We’re excited about pushing forward on templates as a way to make it easier to get started with LangGraph. While we are launching with a small number of templates, we have more in the backlog that we are working on adding.

LangGraph 已被证实具备高度可配置性与高度可定制性，我们坚信它是构建各类代理架构的坚实基础。我们非常期待以“模板”为切入点，进一步降低 LangGraph 的上手门槛。尽管本次发布仅包含少量模板，但我们已有更多模板列入开发计划，正持续推进中。

**Key Links:**

**关键链接：**

- [**YouTube walkthrough of templates**](https://youtu.be/RYJoh63n8R4?ref=blog.langchain.com)  
- [**YouTube 模板演示视频**](https://youtu.be/RYJoh63n8R4?ref=blog.langchain.com)

- [**YouTube walkthrough of data enrichment agent**](https://youtu.be/mNxAM1ETBvs?ref=blog.langchain.com)  
- [**YouTube 数据增强代理演示视频**](https://youtu.be/mNxAM1ETBvs?ref=blog.langchain.com)

- [**Templates homepage**](https://langgraph-studio.vercel.app/?ref=blog.langchain.com)  
- [**模板主页**](https://langgraph-studio.vercel.app/?ref=blog.langchain.com)

- [**LangGraph Studio**](https://github.com/langchain-ai/langgraph-studio?ref=blog.langchain.com)  
- [**LangGraph Studio**](https://github.com/langchain-ai/langgraph-studio?ref=blog.langchain.com)

- [**LangGraph**](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com)  
- [**LangGraph 官方文档**](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com)
{% endraw %}
