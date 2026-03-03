---
title: "LangChain Templates"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-templates/"
date: "2023-11-10"
scraped_at: "2026-03-03T08:28:05.636124989+00:00"
language: "en-zh"
translated: true
---

Today we're excited to announce the release of LangChain Templates. LangChain Templates offers a collection of easily deployable reference architectures that anyone can use. We've worked with some of our partners to create a set of easy-to-use templates to help developers get to production more quickly. We will continue to add to this over time. This is a new way to create, share, maintain, download, and customize chains and agents. They are all in a standard format with allows them to easily be deployed with [LangServe](https://github.com/langchain-ai/langserve?ref=blog.langchain.com), allowing you to easily get production-ready APIs and a playground for free.

今天，我们非常高兴地宣布 LangChain Templates 正式发布。LangChain Templates 提供了一系列开箱即用的参考架构，任何人都可轻松部署使用。我们携手部分合作伙伴，精心打造了一批易于上手的模板，助力开发者更快地将应用推向生产环境。未来，我们将持续扩充模板库。这是一种全新的方式——用于创建、共享、维护、下载和定制链（chains）与智能体（agents）。所有模板均采用统一标准格式，可直接通过 [LangServe](https://github.com/langchain-ai/langserve?ref=blog.langchain.com) 快速部署，让您免费获得生产就绪的 API 及交互式开发沙盒（playground）。

![](images/langchain-templates/img_001.png)

## **Key Links**

## **核心链接**

[**Quick Start**](https://github.com/langchain-ai/langchain/blob/master/templates/README.md?ref=blog.langchain.com) **: Go here for a guide on how to get started with LangChain Templates.**

[**快速入门**](https://github.com/langchain-ai/langchain/blob/master/templates/README.md?ref=blog.langchain.com) **：点击此处查看 LangChain Templates 的入门指南。**

[**YouTube Walkthrough**](https://youtu.be/aA6KZ4L_ono?ref=blog.langchain.com) **: We filmed a quick walkthrough of how to use LangChain Templates.**

[**YouTube 演示视频**](https://youtu.be/aA6KZ4L_ono?ref=blog.langchain.com) **：我们录制了一段简短的操作演示视频，介绍如何使用 LangChain Templates。**

[**LangSmith**](https://smith.langchain.com/?ref=blog.langchain.com) **: LangChain Templates seamlessly integrate with LangSmith - our logging and debugging tool. [**Sign up here**](https://smith.langchain.com/?ref=blog.langchain.com).**

[**LangSmith**](https://smith.langchain.com/?ref=blog.langchain.com) **：LangChain Templates 与 LangSmith（我们的日志记录与调试工具）无缝集成。[**立即注册**](https://smith.langchain.com/?ref=blog.langchain.com)。**

[**Hosted LangServe**](https://airtable.com/app0hN6sd93QcKubv/shrAjst60xXa6quV2?ref=blog.langchain.com) **: We will be releasing a hosted version of LangServe for one-click deployments of LangChain applications. [**Sign up here**](https://airtable.com/app0hN6sd93QcKubv/shrAjst60xXa6quV2?ref=blog.langchain.com).**

[**托管版 LangServe**](https://airtable.com/app0hN6sd93QcKubv/shrAjst60xXa6quV2?ref=blog.langchain.com) **：我们将推出托管版 LangServe，支持一键部署 LangChain 应用。[**立即注册**](https://airtable.com/app0hN6sd93QcKubv/shrAjst60xXa6quV2?ref=blog.langchain.com)。**

## Additional Resources

## 其他资源

[**Featured Templates**](https://github.com/langchain-ai/langchain/blob/master/templates/docs/INDEX.md?ref=blog.langchain.com) **: Explore the many templates available to use - from advanced RAG to agents.**

[**精选模板**](https://github.com/langchain-ai/langchain/blob/master/templates/docs/INDEX.md?ref=blog.langchain.com) **：探索众多可用模板——涵盖高级 RAG（检索增强生成）到各类智能体（agents）。**

[**All Templates**](https://github.com/langchain-ai/langchain/tree/master/templates?ref=blog.langchain.com) **: Explore all templates available.**

[**全部模板**](https://github.com/langchain-ai/langchain/tree/master/templates?ref=blog.langchain.com) **：浏览当前所有可用模板。**

[**Contributing**](https://github.com/langchain-ai/langchain/blob/master/templates/docs/CONTRIBUTING.md?ref=blog.langchain.com) **: 想要贡献您自己的模板吗？其实非常简单！这些说明将一步步指导您如何操作。**

[**LangServe**](https://github.com/langchain-ai/langserve?ref=blog.langchain.com) **: 了解部署 LangChain 链（chains）和智能体（agents）的最佳实践。**

[**LangServe Webinar**](https://www.crowdcast.io/c/zcl2p0y0wrvd?ref=blog.langchain.com) **: 我们将于本周四举办一场网络研讨会，深入探讨 LangServe 和 LangChain 模板。请在此处 [**注册**](https://www.crowdcast.io/c/zcl2p0y0wrvd?ref=blog.langchain.com)。**

## Motivation

## 设计初衷

What was our motivation LangChain Templates? These templates can be either chains or agents, and represent a full-features _context-aware reasoning applications_. Over time we've seen:

LangChain 模板的设计初衷是什么？这些模板既可以是链（chains），也可以是智能体（agents），代表了功能完备的、具备上下文感知能力的推理应用（_context-aware reasoning applications_）。长期以来，我们观察到以下趋势：

- Developers want to create **many different types** of applications  
  开发者希望构建**多种不同类型**的应用程序；

- Developers want to better **understand** internals of applications  
  开发者希望更深入地**理解**应用程序的内部机制；

- Developers want to **modify** internal of applications  
  开发者希望**修改**应用程序的内部逻辑；

- Developers want an **easy way to deploy** application  
  开发者希望拥有**便捷的部署方式**。

### Developers want to create many different types of applications

### 开发者希望构建多种不同类型的应用程序

We've recently seen a proliferation of chains and agents being added to LangChain. There are a few different flavors:

近期，我们看到大量链（chains）与智能体（agents）被持续加入 LangChain 生态系统。它们大致可分为几类：

- Tool specific chains  
  面向特定工具的链；

- Language model specific chains  
  面向特定大语言模型的链；

- New architectures  
  新型架构。  

It's natural that all these types of chains are added, and says something about the current state of the field.

将上述各类链纳入 LangChain 是顺理成章之举，也从侧面反映出当前该领域的发展现状。

**Tool Specific Chains**

**面向特定工具的链（Chains）**

We are seeing a lot of chains/agents aimed at best interacting with particular tools. This is consistent with what we know about language models: they are fantastic generalists, so of course it makes sense that we would want to use with different tools. The exact chain/agent that makes the most sense for one particular tool may actually differ subtly from another.

我们正看到大量链（chains）和智能体（agents）被专门设计用于最优地与特定工具交互。这与我们对大语言模型的认知一致：它们是卓越的通才，因此自然适合与各类工具协同工作。然而，针对某一特定工具效果最佳的链或智能体，其具体实现可能与另一工具所用的链/智能体存在细微差异。

**Language Model Specific Chains**

**面向特定语言模型的链（Chains）**

We are seeing that not all language models are interchangeable for all tasks. At the most obvious level, they may require different prompts. But they may also require different output parsing, maybe even slightly different context to be provided.

我们发现，并非所有语言模型在所有任务中都可互换使用。最直观的差异体现在提示词（prompts）需求不同；但更深层次上，它们还可能要求不同的输出解析方式，甚至需要提供略有差异的上下文信息。

**New Architectures**

**新型架构**

We are seeing new architectures emerge for how best to build applications. We will discuss this in a future post. This implies the field is still very early and people are trying to figure out how best to work with language models.

我们正见证着构建应用的新架构不断涌现。我们将在后续文章中深入探讨这一主题。这也表明该领域仍处于早期阶段，开发者们仍在积极探索如何最有效地利用语言模型。

This had lead to a proliferation of chains and agents getting contributed to LangChain. We realized a while ago we couldn't accept every possible variation (or LangChain would become incredibly bloated). We started moving more and more to cookbooks, but those aren't as discoverable or as usable.

这导致大量链与智能体被贡献至 LangChain。我们很早就意识到，无法接纳每一种可能的变体（否则 LangChain 将变得异常臃肿）。于是我们逐步转向以“食谱（cookbooks）”形式组织内容，但这类资源的可发现性与易用性仍显不足。

### Developers want to understand internals of applications

### 开发者希望理解应用的内部工作机制

While it's convenient to have an entire chain wrapped up in a class, it does obfuscate what exactly is going on inside. We've introduced [LangSmith](https://smith.langchain.com/o/ebbaf2eb-769b-4505-aca2-d11de10372a4/?ref=blog.langchain.com) to help with debugging and observability, and while that helps it's not the same as being able to easily see that code.

尽管将整条链封装在一个类中十分便捷，但这同时也掩盖了其内部实际运行逻辑。为此我们推出了 [LangSmith](https://smith.langchain.com/o/ebbaf2eb-769b-4505-aca2-d11de10372a4/?ref=blog.langchain.com)，以提升调试能力与可观测性；然而，即便如此，它仍无法替代直接、清晰地查看底层代码所带来的理解深度。

### Developers want to modify internals of applications

### 开发者希望修改应用的内部实现

We've seen a lot of developers wanting to modify the internals of chains. This could be changing some of the orchestration, changing some of the context loading, changing some of the prompts. This is extremely related to the first point.

我们已看到大量开发者希望修改链（chain）的内部实现，例如调整部分编排逻辑、更改上下文加载方式，或修改提示词（prompt）。这与前述第一点密切相关。

As such we've seen a lot of people fork LangChain and modify the code internally. Some of them open up a PR with more minor changes for prompts/output parsers. This raises an interesting challenge for us though: it's extremely tough to evaluate language model applications, so even though these prompt/output parser changes may be helpful for one person's application, we're hesitant to merge these in for fear that it may affect some other unsuspecting user.

因此，我们观察到许多人选择 fork LangChain 并在本地修改源码。其中一部分人会针对提示词或输出解析器（output parser）提交较小改动的 Pull Request。但这对我们提出了一个颇具挑战性的问题：评估大语言模型应用的效果本身极为困难；即便这些提示词或输出解析器的改动对某位开发者的应用确有帮助，我们仍对其合并持谨慎态度——唯恐无意中影响其他毫无防备的用户。

### Developers want an easy way to deploy chains

### 开发者希望拥有便捷的链部署方式

There are two drivers here.

此处存在两大动因。

One driver: we see that one of the things that successful teams do is deploy an application quickly, to gather user interaction data. This user interaction data is useful for many purposes.

其一：我们发现，成功的团队往往能快速部署应用，以尽早收集用户交互数据。这类用户交互数据具有多重价值：

- First: are people even interacting with it? If no, then that may imply this particular product/feature does not have product market fit and you'd want to investigate that.  
  - 首先：用户是否真的在使用该应用？若无人使用，则可能意味着该产品或功能尚未实现产品市场匹配（product-market fit），需进一步调研原因。

- Second: how are people using? If they are using it in unexpected ways, that may change some of the focus for development.  
  - 其次：用户如何使用？若其使用方式出乎意料，则可能需要重新调整开发重点。

- Third: where is the chain not performing well? It's often tough to now how exactly to improve the chain without seeing concrete datapoints on where is performing well.  
  - 第三：链在哪些环节表现不佳？若缺乏具体数据点（例如明确指出链在哪些场景下表现良好或欠佳），通常很难精准优化链的整体性能。

Therefore, the faster we can allow teams to deploy their applications, the quicker they can iterate.

因此，我们越快帮助团队完成应用部署，他们就能越快开展迭代优化。

A second driver: a lot of organizations typically have not deployed Python applications in their infrastructure, and are looking for a battle-tested way to do so.

其二：许多组织以往并未在其基础设施中部署过 Python 应用，正寻求一种经过实战检验的可靠部署方案。

## What are LangChain Templates

## 什么是 LangChain 模板（LangChain Templates）

In response to the above, we began working on LangChain Templates. LangChain Templates offers a collection of easily deployable reference architectures that anyone can use. We have created a collection of end-to-end templates for creating different types of applications. These templates are in a standard format that makes them easy to deploy with LangServe. We've also exposed an easy way to create new projects and load templates in.

为回应上述需求，我们启动了 LangChain Templates 项目。LangChain Templates 提供一系列开箱即用、易于部署的参考架构（reference architecture），供所有开发者直接使用。我们已构建了一套端到端模板集合，覆盖多种类型的应用开发场景。这些模板采用统一标准格式，可轻松通过 LangServe 进行部署。此外，我们也提供了便捷的接口，支持用户快速创建新项目并加载所需模板。

How you consume these modules? You can first create a project, which contains a folder for chains. You can then easily download a module into that application project. You can easily inspect and modify a chain (since it is being downloaded, rather than `pip` installed). You can then deploy the whole project using `langserve`.

您如何使用这些模块？您可以首先创建一个项目，其中包含一个用于存放链（chains）的文件夹。接着，您可以轻松地将某个模块下载到该应用项目中。由于模块是被下载而非通过 `pip` 安装，因此您可以方便地查看和修改某条链。最后，您可使用 `langserve` 部署整个项目。

## What is in LangChain Templates

## LangChain 模板包含哪些内容？

![](images/langchain-templates/img_002.png)

One of the things that we are most excited about with LangChain Templates is that it enables us to much more easily add a variety of chains and agents. Some of the ones we're particularly excited by:

LangChain 模板最令我们振奋的一点在于：它让我们能更便捷地添加各类链（chains）与智能体（agents）。以下是我们尤为期待的几类：

**OSS Models**

**开源模型（OSS Models）**

We've heard a lot that LangChain seems OpenAI-centric. That is not our intention, but it is true that the default prompts for most chains are designed to work well with OpenAI. With LangChain Templates, we're incredibly excited to be able to add templates that work best for other models — especially open source. We've already added some for [RAG](https://github.com/langchain-ai/langchain/tree/master/templates/rag-chroma-private?ref=blog.langchain.com) and [SQL-question-answering](https://github.com/langchain-ai/langchain/tree/master/templates/sql-ollama?ref=blog.langchain.com), and we're excited to add more.

我们常听到一种反馈：LangChain 似乎过度聚焦于 OpenAI。这并非我们的初衷；但确实，目前大多数链的默认提示词（prompts）主要针对 OpenAI 模型进行了优化。借助 LangChain 模板，我们非常激动地能够引入专为其他模型（尤其是开源模型）量身定制的模板。我们已上线了面向 [RAG](https://github.com/langchain-ai/langchain/tree/master/templates/rag-chroma-private?ref=blog.langchain.com) 和 [SQL 问答](https://github.com/langchain-ai/langchain/tree/master/templates/sql-ollama?ref=blog.langchain.com) 的若干模板，并将持续扩充更多支持。

**Advanced RAG**

**高级 RAG**

There are a lot of different methods and algorithms for advanced RAG, and we're excited to be able to highlight them more properly. We've added templates for all the papers we highlighted last week in our blog post on [Query Transformations](https://blog.langchain.com/query-transformations/). We've also worked with partners to take some of the heuristics we've developed (like [Parent Document Retriever](https://python.langchain.com/docs/modules/data_connection/retrievers/parent_document_retriever?ref=blog.langchain.com)) and get them to work with their database — see the [Neo4J Parent Document Retriever](https://github.com/langchain-ai/langchain/tree/master/templates/neo4j-parent?ref=blog.langchain.com) template.

高级 RAG 涵盖大量不同的方法与算法，我们很高兴能借此更系统、更清晰地呈现它们。我们已为上周博客文章《[查询变换（Query Transformations）](https://blog.langchain.com/query-transformations/)》中重点介绍的所有论文，全部配套开发了相应模板。此外，我们还携手合作伙伴，将团队自主研发的一些启发式策略（例如 [父文档检索器（Parent Document Retriever）](https://python.langchain.com/docs/modules/data_connection/retrievers/parent_document_retriever?ref=blog.langchain.com)）适配至其数据库系统——详见 [Neo4j 父文档检索器模板](https://github.com/langchain-ai/langchain/tree/master/templates/neo4j-parent?ref=blog.langchain.com)。

**Use Case Specific Chains**

**面向特定用例的链**

We hope this opens the path for highlighting more and more use case specific chains. For example, we worked with [Sphinx Bio](https://www.sphinxbio.com/?ref=blog.langchain.com) to add a [template](https://github.com/langchain-ai/langchain/tree/master/templates/plate-chain?ref=blog.langchain.com) aimed at identifying coordinates of plate data within a messy Excel file. Something like this would have been too specific to include in the core LangChain package, but fits perfectly here.

我们希望此举能为持续发掘并展示更多面向具体业务场景的链铺平道路。例如，我们与 [Sphinx Bio](https://www.sphinxbio.com/?ref=blog.langchain.com) 合作，开发了一个 [模板](https://github.com/langchain-ai/langchain/tree/master/templates/plate-chain?ref=blog.langchain.com)，专门用于从结构混乱的 Excel 文件中识别微孔板（plate）数据的坐标位置。此类高度特化的功能若纳入 LangChain 核心包，显然过于小众；但在此类模板体系中，却恰如其分、大放异彩。

## How does LangChain Templates solve the earlier problems?

## LangChain 模板如何解决前述问题？

Above we had listed out a few different problems we were observing. We think LangChain Templates goes a long way in addressing these problems.

上文我们已列举出所观察到的若干不同问题。我们认为，LangChain 模板在很大程度上能够有效应对这些问题。

**Developers want to create many different types of applications**

**开发者希望构建多种类型的应用程序**

By adding templates for chains and agents in this format, we are no longer putting them in LangChain which should prevent bloat. This is also more organized and easier to work with than cookbooks.

通过以这种格式添加链（chains）和智能体（agents）模板，我们不再将它们直接纳入 LangChain 主库，从而避免了主库膨胀。相比“食谱”（cookbooks）式文档，这种方式也更结构化、更易于使用。

**Developers want to better understand internals of applications**

**开发者希望更深入地理解应用程序的内部机制**

By downloading chains (rather than `pip` \- installing) the source code for chains and agents is right in your application. That makes it easy to inspect it.

通过下载链（而非通过 `pip` 安装），链与智能体的源代码将直接置于您的应用程序中，便于您随时查看和分析。

**Developers want to modify internal of applications**

**开发者希望灵活修改应用程序的内部逻辑**

Again, by downloading chains (rather than `pip` \- installing) the source code for chains and agents is right in your application. That makes it easy to modify it.

同样地，通过下载链（而非 `pip` 安装），链与智能体的源代码直接集成于您的应用中，便于您按需定制与修改。

**Developers want an easy way to deploy applications**

**开发者希望拥有便捷的应用部署方式**

All templates are in a standard format which makes it easy to deploy them with LangServe.

所有模板均采用统一标准格式，因此可轻松借助 LangServe 进行部署。

## Conclusion

## 结论

The goal of LangChain is to make it as easy as possible for developers to build context-aware reasoning applications. We believe this is a big step in that direction. We're incredibly grateful to our partners who have helped provide initial templates, and we look forward to working with the community to add more!

LangChain 的目标是让开发者尽可能轻松地构建具备上下文感知能力的推理应用。我们相信，这正是迈向该目标的重要一步。我们由衷感谢各位合作伙伴为初始模板提供的支持，并期待与社区携手，持续丰富模板库！

Big thank you to:

衷心感谢以下各位：

- All our ecosystem partners who contributed templates  
  所有贡献了模板的生态合作伙伴  

- Jason Liu for suggesting this method of adding templates  
  Jason Liu 提出了这一模板添加方式  

- Rajtilak Bhattacharjee for helping us with the `langchain-cli` package name  
  Rajtilak Bhattacharjee 协助我们确定了 `langchain-cli` 包名  

- All our community members who helped test this: Greg Kamradt, Ryan Brandt, Misbah Syed, Hai, Lucas Hänke de Cansino, Hamel Husain  
  所有参与本次测试的社区成员：Greg Kamradt、Ryan Brandt、Misbah Syed、Hai、Lucas Hänke de Cansino、Hamel Husain