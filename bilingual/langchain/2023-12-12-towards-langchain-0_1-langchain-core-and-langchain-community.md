---
title: "Towards LangChain 0.1: LangChain-Core and LangChain-Community"
source: "LangChain Blog"
url: "https://blog.langchain.com/the-new-langchain-architecture-langchain-core-v0-1-langchain-community-and-a-path-to-langchain-v0-1/"
date: "2023-12-12"
scraped_at: "2026-03-03T08:21:01.700377577+00:00"
language: "en-zh"
translated: true
---

The goal of LangChain has always been to make it as easy as possible to develop context-aware reasoning applications with LLMs.  
LangChain 的目标始终是让开发者能够以最简便的方式，利用大语言模型（LLMs）构建具备上下文感知能力的推理应用。

LangChain started as a side project, and purely as a Python package. Over the past year it has grown tremendously. This growth has been a forcing function to rethink the architecture of the package.  
LangChain 最初只是一个副业项目，且纯粹是一个 Python 包。过去一年间，它实现了迅猛发展。这种快速增长倒逼我们重新思考该包的整体架构。

We’ve been listening to the community and are announcing a re-architecture of the package into multiple packages (done in a completely backwards compatible way), a path towards a stable `0.1` release, and also taking the opportunity to highlight the ecosystem that has emerged around LangChain.  
我们持续倾听社区反馈，现正式宣布：将原单一包重构为多个独立包（全程保持完全向后兼容），明确通向稳定版 `0.1` 的演进路径，并借此契机重点展示围绕 LangChain 已然蓬勃发展的生态系统。

**TL;DR:**  
**简而言之：**

**We've split the old `langchain` package into three separate packages to improve developer experience**  
**我们将原有的 `langchain` 单一包拆分为三个独立包，以全面提升开发者体验。**

**`langchain-core` contains simple, core abstractions that have emerged as a standard, as well as LangChain Expression Language as a way to compose these components together. This package is now at version `0.1` and all breaking changes will be accompanied by a minor version bump.**  
**`langchain-core` 包含已逐步成为行业标准的简洁核心抽象，以及用于组合这些组件的 LangChain 表达式语言（LangChain Expression Language）。该包当前版本为 `0.1`，所有不兼容变更均将伴随次版本号（minor version）升级。**

**`langchain-community` contains all third party integrations. We will work with partners on splitting key integrations out into standalone packages over the next month.**  
**`langchain-community` 包含全部第三方集成。未来一个月内，我们将与合作伙伴协作，将关键集成进一步拆分为独立的专用包。**

**`langchain` contains higher-level and use-case specific chains, agents, and retrieval algorithms that are at the core of your application's cognitive architecture. We are targeting a launch of a stable `0.1` release for `langchain` in early January.**  
**`langchain` 包含面向具体用例的高级链（chains）、智能体（agents）及检索算法（retrieval algorithms）——它们共同构成您应用认知架构的核心。我们计划于 1 月初发布 `langchain` 的稳定版 `0.1`。**

**This is done to support a burgeoning ecosystem around `langchain`: LangChain Templates, LangServe, LangSmith, other packages built on top.**  
**此举旨在支撑围绕 `langchain` 快速成长的生态系统：包括 LangChain Templates、LangServe、LangSmith，以及众多在其之上构建的其他工具包。**

**All done in a backwards compatible way.**  
**所有调整均严格保证向后兼容。**

![](images/towards-langchain-0_1-langchain-core-and-langchain-community/img_001.png)Overview of the LangChain ecosystem.  
![](images/towards-langchain-0_1-langchain-core-and-langchain-community/img_001.png)LangChain 生态系统概览。

## The LangChain SDKs  
## LangChain 软件开发工具包（SDKs）

The LangChain Python and JavaScript SDKs have three main parts:

LangChain 的 Python 和 JavaScript SDK 包含三个主要部分：

- A base set of interfaces for common components needed in building LLM applications and a way to join those components together  
  —— 一组构建大语言模型（LLM）应用所需通用组件的基础接口，以及将这些组件组合在一起的机制。

- Integrations and/or implementations for those components  
  —— 这些组件的集成方案和/或具体实现。

- Preconfigured ways to compose those components together to accomplish a particular use case  
  —— 针对特定使用场景预配置的组件组合方式。

Previously, these three parts were all part of the same library. While this worked at the start, as the number of integrations and use cases has grown over time the complexity has become unsustainable. A main part of the re-architecture is to separate these out into distinct packages: `langchain-core`, `langchain-community`, and `langchain`. At the same time, we want to be conscious of the large LangChain user base and try to do so in a backwards compatible way.

此前，这三个部分全部包含在同一个库中。这种设计在初期是可行的；但随着集成数量和使用场景持续增长，其复杂度已变得难以长期维护。本次架构重构的核心举措之一，便是将这三部分拆分为三个独立的软件包：`langchain-core`、`langchain-community` 和 `langchain`。与此同时，我们也高度重视庞大的 LangChain 用户群体，力求以向后兼容（backwards compatible）的方式完成此次演进。

💡

Our two main considerations were long term stability and scalability, as well as short term backwards compatibility.

我们的两大核心考量是：长期稳定性与可扩展性，以及短期的向后兼容性。

![](images/towards-langchain-0_1-langchain-core-and-langchain-community/img_002.png)

## LangChain Core

## LangChain 核心模块（`langchain-core`）

`langchain-core` consists of core abstractions and a runtime to join those components together ( [LangChain Expression Language](https://python.langchain.com/docs/expression_language/?ref=blog.langchain.com)).

`langchain-core` 包含核心抽象层，以及用于连接各组件的运行时环境（即 [LangChain 表达式语言（LangChain Expression Language）](https://python.langchain.com/docs/expression_language/?ref=blog.langchain.com)）。

### Simple and Modular Abstractions

### 简洁且模块化的抽象

The base abstractions of LangChain are designed to be as modular and simple as possible. Examples of these abstractions include those for language models, document loaders, embedding models, vectorstores, retrievers, and more. The benefit of having these abstractions is that any provider can implement the required interface and then easily be used in the rest of LangChain.

LangChain 的基础抽象被设计为尽可能模块化与简洁。这些抽象的典型示例包括：语言模型（language models）、文档加载器（document loaders）、嵌入模型（embedding models）、向量数据库（vectorstores）、检索器（retrievers）等。采用此类抽象的好处在于：任何服务提供商只需实现对应接口，即可无缝接入 LangChain 生态系统并被其余模块直接调用。

These are NOT high level or end-to-end abstractions. They simply represent common interfaces for the necessary components. For example: LLMs are just text in, text out. Retrievers are text in, documents out.

这些**并非**高层级或端到端的抽象。它们仅表示必要组件的通用接口。例如：大语言模型（LLM）就是“文本输入、文本输出”；检索器（Retriever）则是“文本输入、文档输出”。

💡

💡

These low-level and flexible abstractions have made LangChain the standard for how providers and partners expose their services to the whole GenAI ecosystem, leading to over 700 different integrations to date.

这些低层级、高灵活性的抽象，已使 LangChain 成为各类服务提供商与合作伙伴向整个生成式 AI（GenAI）生态系统开放其服务的事实标准，迄今已实现 **700 多种不同集成**。

Many frameworks AND applications are either built on top of or are interoperable with these abstractions. This includes frameworks like [funcchain](https://github.com/shroominic/funcchain?ref=blog.langchain.com), [langchain-decorators](https://github.com/ju-bezdek/langchain-decorators?ref=blog.langchain.com), [gpt-researcher](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com), [gpt-engineer](https://github.com/AntonOsika/gpt-engineer?ref=blog.langchain.com), [llama-index](https://github.com/run-llama/llama_index?ref=blog.langchain.com), [pandas-ai](https://github.com/gventuri/pandas-ai?ref=blog.langchain.com), and [CrewAI](https://github.com/joaomdmoura/CrewAI?ref=blog.langchain.com). Having a LangChain integration is the most effective way to make sure your tool is compatible with a large part of the ecosystem. In addition, over 30k applications are built on top of LangChain. Some of these need to implement custom components. By making our abstractions simple and modular we have made this easy and painless to do.

大量框架与应用，或直接构建于这些抽象之上，或与其保持互操作性。其中包括：[funcchain](https://github.com/shroominic/funcchain?ref=blog.langchain.com)、[langchain-decorators](https://github.com/ju-bezdek/langchain-decorators?ref=blog.langchain.com)、[gpt-researcher](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com)、[gpt-engineer](https://github.com/AntonOsika/gpt-engineer?ref=blog.langchain.com)、[llama-index](https://github.com/run-llama/llama_index?ref=blog.langchain.com)、[pandas-ai](https://github.com/gventuri/pandas-ai?ref=blog.langchain.com) 和 [CrewAI](https://github.com/joaomdmoura/CrewAI?ref=blog.langchain.com) 等框架。为您的工具提供 LangChain 集成，是确保其与生态中大部分组件兼容的最有效方式。此外，已有 **超过 3 万个应用**基于 LangChain 构建。其中部分应用需实现自定义组件；而我们通过将抽象设计得简洁且模块化，极大简化并消除了这一过程的复杂性与负担。

### LangChain Expression Language

### LangChain 表达式语言（LCEL）

The initial LangChain release didn’t really have a common way to join these fundamental components together. Although the tagline was “building LLM applications through composability”, the original LangChain was actually not that composable.

LangChain 的初始版本实际上并未提供一种统一的方式，将这些基础组件组合起来。尽管其宣传语是“通过可组合性构建大语言模型应用”，但最初的 LangChain 在实践中**并不真正具备良好的可组合性**。

💡

💡

Over the past five months we’ve worked hard to add a runtime that _is_ composable: [LangChain Expression Language](https://python.langchain.com/docs/expression_language/?ref=blog.langchain.com).

过去五个月里，我们全力开发并引入了一个真正支持可组合性的运行时系统：[LangChain 表达式语言（LangChain Expression Language, LCEL）](https://python.langchain.com/docs/expression_language/?ref=blog.langchain.com)。

This runtime allows users to compose arbitrary sequences together and get several benefits that are important when building LLM applications. We call these sequences “runnables”.

该运行时允许用户将任意组件序列自由组合，并在构建大语言模型应用时获得多项关键优势。我们将这类可组合序列称为“可运行对象（runnables）”。

All runnables expose the same interface with single, batch, streaming and async methods. This design is useful because when building an LLM application it is not enough to have a single sync interface. Batch is needed for efficient processing of many inputs. Streaming (and streaming of intermediate steps) is needed to show the user that progress is being made. Async interfaces are nice when moving into production. Rather than having to write multiple implementations for all of those, LangChain Expression Language allows you to write a runnable once and invoke it in many different ways.

所有可运行对象（runnables）均暴露统一接口，支持单次调用（single）、批量处理（batch）、流式响应（streaming）以及异步调用（async）四种方法。这一设计极具实用性——因为构建大语言模型应用时，仅提供单一同步接口远远不够：批量处理对于高效处理大量输入至关重要；流式响应（包括中间步骤的流式输出）能让用户实时感知任务进展；而异步接口则在生产环境部署中尤为便利。借助 LangChain 表达式语言，您只需编写一次可运行对象，即可通过多种方式灵活调用，无需为每种模式重复实现。

We have also written runnables to do orchestration of common (but annoying) tasks.  
我们还编写了可运行对象（runnables），用于编排那些常见但烦琐的任务。

All runnables expose a `.map` method, which applies that runnable to all elements of a list in parallel.  
所有可运行对象均暴露一个 `.map` 方法，该方法可将该可运行对象并行应用于列表中的每个元素。

All runnables also expose a `.with_fallbacks` method that allows you to define fallbacks in case the runnable errors.  
所有可运行对象还暴露一个 `.with_fallbacks` 方法，允许你在可运行对象执行出错时定义备用逻辑（fallbacks）。

These are orchestration tasks that are common and helpful when building LLM applications.  
这些编排任务在构建大语言模型（LLM）应用时十分常见且极具实用价值。

These runnables are also far more inspectable and customizable than previous “chains”.  
相较于以往的“链（chains）”，这些可运行对象具备更强的可观测性与可定制性。

Previous chains were largely custom classes in the `langchain` source code.  
以往的链大多是 `langchain` 源码中定义的自定义类。

This made it very difficult to understand what was happening inside them (including what prompts were used) and even more difficult to change the behavior of the chain (without completely rewriting them).  
这使得理解其内部行为（包括所使用的提示词）变得极为困难；而若想修改其行为（又不彻底重写），则更是难上加难。

We’ve rewritten several chains (and will rewrite more in the future) using runnables.  
我们已使用可运行对象重写了多个链（未来还将继续重写更多）。

Runnables are defined in a declarative way, which makes it easier to understand the logic and modify parts.  
可运行对象采用声明式方式定义，使逻辑更清晰、局部修改更便捷。

Finally, runnables have best-in-class observability through a seamless integration with [LangSmith](https://smith.langchain.com/?ref=blog.langchain.com).  
最后，得益于与 [LangSmith](https://smith.langchain.com/?ref=blog.langchain.com) 的无缝集成，可运行对象具备业界领先的可观测性。

LLM applications are incredibly tricky to debug.  
LLM 应用的调试难度极高。

Understanding what the exact sequence of steps is, what exactly the inputs are, and what exactly the outputs are can greatly increase your prompt velocity.  
准确掌握每一步的执行顺序、每一环节的确切输入与输出，可显著提升你的提示工程（prompt engineering）效率。

We built LangSmith to greatly facilitate that — more on that later.  
我们构建 LangSmith 正是为了大幅简化这一过程——后文将详述。

### Benefits of separate package

### 独立包的优势

These abstractions and runtime are pretty stable, and whenever we do make changes, we have largely done so in a backwards compatible way.  
这些抽象层与运行时机制整体非常稳定；即便进行更新，我们也基本确保向后兼容。

Still, because these are so crucial to the LangChain ecosystem we want to be especially careful and communicative around changes to these abstractions.  
然而，鉴于它们对 LangChain 生态系统至关重要，我们在调整这些抽象层时将格外审慎，并保持充分透明与沟通。

As of today these abstractions are part of `langchain-core` which just released a `0.1` version.  
截至目前，这些抽象层已归属新发布的 `langchain-core` 包（版本号 `0.1`）。

Now that `langchain-core` is `0.1`, any future breaking changes will be accompanied by a minor version bump.  
既然 `langchain-core` 已达 `0.1` 版本，今后任何不兼容的变更都将伴随次版本号（minor version）升级。

This creates stability for these core abstractions which will allow others to have confidence in building on top of them.  
此举为这些核心抽象层提供了稳定性保障，使开发者能更有信心地在其之上构建应用。

## LangChain Community

## LangChain 社区

A huge part of LangChain is our partners.  
合作伙伴是 LangChain 极其重要的一环。

We have nearly 700 integrations, from document loaders to LLMs to vectorstores to toolkits.  
我们已拥有近 700 种集成，涵盖文档加载器、大语言模型（LLMs）、向量数据库（vectorstores）及各类工具包（toolkits）等。

In all cases, we have strived to make it as easy to add integrations as possible, and thank the community and our partners for working with us.  
在所有场景中，我们都致力于最大限度降低新增集成的门槛；在此衷心感谢社区成员与各位合作伙伴的鼎力支持。

As empowering for developers as this large selection of integrations is, it does not come without its downsides.  
尽管如此丰富的集成选项极大地赋能了开发者，但它也带来了一些不容忽视的弊端。

With so many integrations we’ve made all dependencies optional (to make LangChain lightweight).  
为保持 LangChain 轻量化，我们已将全部依赖设为可选（optional）。

This unfortunately makes it confusing to know which dependencies are needed for a given integration.  
但这不幸导致了一个问题：开发者难以明确某项特定集成究竟需要哪些依赖。

Having so many integrations in the same package also makes it next to impossible to properly version them.  
将如此多的集成打包在同一模块中，也几乎无法对它们进行合理、独立的版本管理。

The underlying integrations are themselves changing at a rapid rate (a necessary reality given the rate-of-change of the field).  
底层集成本身正以极快速度演进（这是该领域高速发展的必然现实）。

This has contributed to instability for these integrations, as it’s hard to know when one may have changed.  
这也加剧了集成模块的不稳定性——开发者往往难以及时察觉某项集成是否已发生变更。

Since these integrations were bundled in with other parts of LangChain, they contributed to instability of the overall package.  
由于这些集成曾与其他 LangChain 组件捆绑发布，它们的不稳定性也波及了整个包。

With so many integrations, there is naturally a wide spectrum of reliability and robustness of these integrations.  
集成数量如此庞大，其可靠性与健壮性自然参差不齐。

If they are all in one package there is no way for developers to reliably know which integrations are well-supported and well-tested.  
若全部集成都置于同一包中，开发者便无法可靠地判断哪些集成获得了良好支持与充分测试。

We’re excited to announce some changes to the architecture of LangChain that will address these issues.  
我们很高兴地宣布：LangChain 架构将迎来若干重要调整，以系统性解决上述问题。

First, in the recent release we have moved all integrations into a separate `langchain-community` package.  
首先，在最近的版本中，我们已将全部集成迁移至独立的 `langchain-community` 包中。

This will help separate and distinguish integration code — which often requires different setup, different testing practices, and different maintenance.  
此举有助于将集成代码与其他核心逻辑分离并加以区分——因为集成代码通常需要不同的环境配置、测试策略与维护方式。

Again, this is done in a completely backwards compatible way.  
同样，该调整完全保持向后兼容。

### Integration-Specific Packages

### 面向特定集成的独立包

Over the next few weeks we will work on splitting out integrations with some of the largest audiences and most critical functionalities. These will exist in standalone packages for their particular integration. For example: `langchain-openai`, `langchain-anthropic`, etc. These packages will either live inside the LangChain monorepo or in their own individual repositories (depending on the desire of the integration partner). This will provide several benefits. It will let us version these packages by themselves, and if breaking changes are made they can be reflected by appropriate version bumps. It will simplify the testing process, increasing test coverage for these key integrations. It will let us make third party dependencies required for these packages, making installation easier. For packages that are split out into their own repo, it will let other companies own their integration.

在未来几周内，我们将着手将面向用户规模最大、功能最关键的若干集成拆分为独立包。每个集成将拥有专属的独立软件包，例如：`langchain-openai`、`langchain-anthropic` 等。这些包将根据集成合作伙伴的意愿，要么保留在 LangChain 单体仓库（monorepo）中，要么迁移至各自独立的代码仓库。此举将带来多重优势：  
- 可对各集成包进行独立版本管理；若发生不兼容变更（breaking changes），可通过恰当的版本号升级予以体现；  
- 简化测试流程，从而提升这些关键集成的测试覆盖率；  
- 允许为各包声明必需的第三方依赖，使安装过程更便捷；  
- 对于已拆分至独立仓库的包，可由其他公司完全自主维护和演进其集成。

💡

One of the largest benefits of LangChain is the vast number of integrations provided. This step makes the developer experience around them even better.

LangChain 最显著的优势之一，便是其海量的集成支持。这一步举措将进一步优化围绕这些集成的开发者体验。

## LangChain

## LangChain 核心包

Remaining in the `langchain` package will be chains, agents, advanced retrieval methods, and other generalizable orchestration pieces that make up an application’s cognitive architecture.

`langchain` 包中将保留链（chains）、智能体（agents）、高级检索方法，以及其他构成应用程序“认知架构”的通用编排组件。

Some of these will be the old legacy Chains - like `ConversationalRetrievalChain`, which is one of our most popular chains for doing retrieval augmented generation. We will continue to support and maintain these types of chains. More and more though, we will move towards chains constructed with LangChain Expression Language.

其中一部分仍为传统遗留链（legacy Chains），例如 `ConversationalRetrievalChain` —— 这是我们最受欢迎的检索增强生成（RAG）链之一。我们将持续支持并维护此类链。但与此同时，我们将越来越多地转向基于 LangChain 表达式语言（LangChain Expression Language）构建的新一代链。

We are defaulting to LangChain Expression Language for many of the reasons listed in the previous section. Top of mind are ease of creating new chains, transparency of what steps are involved, ease of editing those steps, and ease of exposure of streaming, batch, and async interfaces.

我们默认采用 LangChain 表达式语言，原因即前文所述：它极大简化了新链的创建流程；清晰展现链中每一步骤的执行逻辑；便于灵活编辑各步骤；也更易于暴露流式（streaming）、批量（batch）及异步（async）等接口能力。

Over the past few months we've largely been focused on getting LangChain Expression Language and `langchain-core` in a solid spot. Now that we believe that to be the case, we will increase the focus on higher level abstractions and chains (all powered by LangChain Expression Language).

过去数月，我们的工作重心主要放在夯实 LangChain 表达式语言与 `langchain-core` 的稳定性与可用性上。如今，我们确信二者已趋于成熟，因此将加大投入，着力构建更高层级的抽象能力与链式组件——而所有这些都将由 LangChain 表达式语言提供底层支撑。

## Example

## 示例

Let's take a look at what this looks like in practice! To do so, we can look at a [recently added template](https://github.com/langchain-ai/langchain/tree/master/templates/openai-functions-agent-gmail?ref=blog.langchain.com) for responding to emails. Let's look at the imports and see what we're importing from each package:

让我们实际看看这究竟长什么样！为此，我们可以查看一个[最近新增的模板](https://github.com/langchain-ai/langchain/tree/master/templates/openai-functions-agent-gmail?ref=blog.langchain.com)，该模板用于自动回复电子邮件。我们先来看一下导入语句，弄清楚每个包中我们具体引入了哪些内容：

```
from langchain_core.messages import AIMessage, HumanMessage
from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder
from langchain_core.tools import tool
```

```
from langchain_core.messages import AIMessage, HumanMessage
from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder
from langchain_core.tools import tool
```

From `langchain_core` we are importing a few things. First, we are importing message types like `AIMessage` and `HumanMessage` that we will use to abstract away how different model providers deal with these objects. Next, will import `ChatPromptTemplate` and `MessagesPlaceholder`. These are a way to encapsulate the logic required to take the user input and produce a list of messages to pass to the chat model. Finally, we will import `tool`. This is a decorator we can put on any function to automatically turn it into a LangChain tool object. All of these objects are core to working with LangChain.

从 `langchain_core` 中，我们导入了几项内容。首先，我们导入了消息类型（如 `AIMessage` 和 `HumanMessage`），用于屏蔽不同大模型提供商在处理此类对象时的底层差异。其次，我们导入 `ChatPromptTemplate` 和 `MessagesPlaceholder` —— 它们提供了一种封装机制，可将用户输入转化为一组可供聊天模型接收的消息。最后，我们导入 `tool`：这是一个装饰器，可添加到任意函数上，使其自动转换为 LangChain 的工具（`Tool`）对象。所有这些对象都是使用 LangChain 的核心基础组件。

```
from langchain_community.chat_models import ChatOpenAI
from langchain_community.tools.gmail import (
    GmailCreateDraft,
    GmailGetMessage,
    GmailGetThread,
    GmailSearch,
    GmailSendMessage,
)
```

```
from langchain_community.chat_models import ChatOpenAI
from langchain_community.tools.gmail import (
    GmailCreateDraft,
    GmailGetMessage,
    GmailGetThread,
    GmailSearch,
    GmailSendMessage,
)
```

From `langchain_community` we are importing third party integrations. First, with OpenAI - we will be using their chat model. Next, we import a bunch of tools for working with `Gmail`. These are specific instantiations of base LangChain abstractions (`ChatModel` and `Tool`, respectively).

从 `langchain_community` 中，我们导入的是第三方集成模块。首先是 OpenAI 相关模块——我们将使用其聊天模型（`ChatOpenAI`）。接着，我们导入一系列用于操作 `Gmail` 的工具类，例如 `GmailCreateDraft`、`GmailGetMessage` 等。这些类均是对 LangChain 基础抽象（分别是 `ChatModel` 和 `Tool`）的具体实现。

```
from langchain.agents import AgentExecutor
from langchain.agents.format_scratchpad import format_to_openai_function_messages
from langchain.agents.output_parsers import OpenAIFunctionsAgentOutputParser
from langchain.tools.render import format_tool_to_openai_function
```

```
from langchain.agents import AgentExecutor
from langchain.agents.format_scratchpad import format_to_openai_function_messages
from langchain.agents.output_parsers import OpenAIFunctionsAgentOutputParser
from langchain.tools.render import format_tool_to_openai_function
```

From `langchain` we import a few things. First, we import `AgentExecutor`. This is a specific cognitive architecture to run agents and tools. Next, we import utils for working with a particular type of agent (one that uses OpenAI Functions). This includes (a) logic to format the `agent_scratchpad` (intermediate steps an agent may take) to messages to pass to the chat model, (b) an output parser to parse the output of the LLM into an agent action, and (c) a function to convert the list of tools into a format that OpenAI functions expects.

从 `langchain` 包中，我们导入若干关键组件。首先，导入 `AgentExecutor` —— 这是一种特定的认知架构，用于运行智能体（agent）及其关联工具。其次，我们导入专用于“基于 OpenAI 函数调用的智能体”（OpenAI Functions Agent）的一系列工具函数，包括：(a) 将 `agent_scratchpad`（即智能体执行过程中的中间步骤）格式化为可传入聊天模型的消息；(b) 一个输出解析器（`OpenAIFunctionsAgentOutputParser`），用于将大语言模型（LLM）的原始输出解析为标准的智能体动作（`AgentAction`）；以及 (c) 一个工具格式化函数（`format_tool_to_openai_function`），用于将工具列表转换为 OpenAI 函数调用接口所要求的 JSON Schema 格式。

Previously, all of these were imported from the same `langchain` package, even though they represent three different types of imports (base logic, third party integrations, and cognitive architectures). Part of the value of splitting up `langchain` is to make it more clear how to think of each type of module.

过去，所有这些模块都统一从同一个 `langchain` 包中导入，尽管它们实际上代表了三类截然不同的功能模块（基础逻辑、第三方集成、认知架构）。此次将 `langchain` 拆分为多个独立包，其核心价值之一，正是为了更清晰地界定每类模块的定位与职责。

## Parity of Python and JS

## Python 与 JavaScript 版本的对等性

We've gotten a lot of questions about the Python and JS packages and how they relate to each other. Splitting the packages in this way (`langchain-core`, `langchain-community`, and `langchain`) can explain our philosophy around that.

我们收到了大量关于 Python 与 JavaScript 版本包之间关系的问题。以当前方式拆分包（即划分为 `langchain-core`、`langchain-community` 和 `langchain`）正体现了我们在这一问题上的整体设计哲学。

`langchain-core` is very close to feature parity between the two languages already. Keeping the Python and JavaScript packages at feature parity is a priority for us. We are working on a serializable syntax (which we are already using in some places); maintaining cross-language support for core functionality is very important.

`langchain-core` 在两种语言之间的功能一致性已非常接近。保持 Python 与 JavaScript 版本的功能一致性，是我们当前的优先事项。我们正在开发一种可序列化的语法（该语法目前已在部分场景中投入使用）；确保核心功能在跨语言环境下的持续支持，对我们而言至关重要。

With regards to integrations in `langchain-community` (and their own packages), most of these will be at the discretion of either language, and it's not expected that all will be ported over. There are a few key ones (mainly LLM providers at the moment) that we are interested in achieving feature parity for.

关于 `langchain-community` 中的集成（及其各自独立发布的包），大多数将由各语言社区自主决定是否实现，我们并不预期所有集成都会被完整移植到另一语言。不过，有少数关键集成（目前主要集中于大语言模型提供商）是我们希望达成跨语言功能一致性的重点目标。

`langchain` is somewhere in the middle - it's not nearly as close to feature parity as `langchain-core` is, but it's more of a goal to get it there than `langchain-community`.

`langchain` 处于中间位置——其功能一致性远不如 `langchain-core` 成熟，但相比 `langchain-community`，我们将它列为更明确的“需达成功能一致”的演进目标。

## LangChain Experimental

## LangChain 实验性模块

`langchain-experimental` will remain as a place to put more experimental tools, chains, and agents. “Experimental” can mean several things. Currently most of the implementations in `langchain-experimental` are either (1) newer and more more “out-there” ideas that we want to encourage people to use and play around with but aren’t sure if they are the proper abstractions, or (2) potentially risky and could introduce CVEs (Python REPL, writing and executing SQL). We separate these tools, chains, and agents to convey their experimental nature to end users.

`langchain-experimental` 将继续作为存放更具实验性质的工具、链（chains）和智能体（agents）的模块。“实验性”一词具有多重含义。目前，该模块中的大部分实现属于以下两类之一：（1）较新且更具前瞻性的构想——我们鼓励用户试用并探索，但尚不确定其是否为最恰当的抽象形式；或（2）潜在风险较高、可能引入安全漏洞（CVE）的功能（例如 Python REPL、SQL 编写与执行）。我们将这些工具、链与智能体单独归类，旨在向终端用户清晰传达其“实验性”本质。

## LangChain Templates

## LangChain 模板

We launched [LangChain Templates](https://github.com/langchain-ai/langchain/tree/master/templates?ref=blog.langchain.com) two months ago as the easiest way to get started building a GenAI application. These are end-to-end applications that can be easily deployed with LangServe. These are distinct from chains and agents in the `langchain` library in a few ways.

两个月前，我们推出了 [LangChain 模板](https://github.com/langchain-ai/langchain/tree/master/templates?ref=blog.langchain.com)，作为构建生成式 AI（GenAI）应用最便捷的入门方式。这些是端到端的完整应用，可借助 LangServe 快速部署。它们与 `langchain` 库中的链（chains）和智能体（agents）存在若干关键区别。

First, they are not part of a Python library but are rather code that is downloaded and part of your application. This has a huge benefit in that they are easily modifiable. One of the main things that we observed over time is that as users would bring LangChain applications into production they had to do some customization of the chain or agent that they started from. At a minimum they had to edit the prompts used, and often they had to modify the internals of the chain, how data flowed through. By putting this logic (both the prompts and orchestration) as part of your application - rather than as part of a library's source code - it is MUCH more modifiable.

首先，模板并非 Python 库的一部分，而是可下载并直接纳入您自身应用的代码。这一设计带来显著优势：高度可定制化。我们在长期观察中发现，当用户将 LangChain 应用投入生产环境时，往往需要对初始选用的链或智能体进行一定程度的定制。至少需修改所用提示词（prompts），而更多情况下还需调整链的内部逻辑及数据流转方式。通过将此类逻辑（包括提示词与编排逻辑）置于您的应用中——而非嵌入库的源代码里——其可修改性得到极大提升。

The second big difference is that these come pre-configured with various integrations. While chains and agents often require you pass in LLMs or VectorStores to make them work, templates come with those in place already. Since different LLMs may require different prompting strategies, and different vectorstores may have different parameters, this makes it possible for us to partner with integration partners to deliver templates that best take advantage of their particular tech.

第二大区别在于：模板已预先配置好各类集成组件。虽然链与智能体通常需要您手动传入大语言模型（LLM）或向量数据库（VectorStore）才能运行，但模板已内置这些依赖。鉴于不同 LLM 可能需适配差异化的提示策略，不同向量数据库也可能具备各异的参数配置，这种预集成模式使我们得以与生态合作伙伴协同，推出能充分发挥其特定技术优势的定制化模板。

💡

We’ve already added over 50 different templates - check them out [here](https://templates.langchain.com/?ref=blog.langchain.com).

我们已上线超过 50 种不同模板——欢迎在此处查看：[此处](https://templates.langchain.com/?ref=blog.langchain.com)。

## LangServe

## LangServe

Three months ago we launched [LangServe](https://github.com/langchain-ai/langserve?ref=blog.langchain.com) as the best way to deploy LangChain applications. LangServe is an open source Python library that essentially wraps FastAPI to automatically add in endpoints for your LangChain object. It automatically adds in multiple endpoints (streaming, batch) as well as automatically infers the inputs/outputs of those endpoints - all because we know the underlying LangChain object so well. This also allows us to automatically spin up simple UIs for these chains and agents. This makes it easy to expose a particular chain to end users to try out.

三个月前，我们推出了 [LangServe](https://github.com/langchain-ai/langserve?ref=blog.langchain.com)，作为部署 LangChain 应用的最佳方式。LangServe 是一个开源 Python 库，其核心是对 FastAPI 进行封装，从而自动为您的 LangChain 对象生成 API 端点。它会自动生成多种端点（如流式响应、批量处理），并自动推断这些端点的输入与输出格式——这得益于我们对底层 LangChain 对象的深度理解。此外，LangServe 还能自动为这些链（chains）和智能体（agents）生成简易用户界面（UI），让开发者可以轻松地将特定链开放给终端用户试用。

💡

💡

We have found that the best teams rapidly iterate on their LLM applications. This means exposing to end users as quickly as possible, gathering feedback, and then adjusting accordingly. LangServe aims to make it easy to enable all teams to do that. Furthermore, it seamlessly integrates with LangSmith (see below) to make that feedback collection and iteration process even easier.

我们发现，最高效的团队往往能快速迭代其大语言模型（LLM）应用：即尽早向终端用户开放功能、及时收集反馈，并据此快速调整优化。LangServe 的设计目标正是让所有团队都能轻松实现这一流程。此外，LangServe 与 LangSmith（见下文）无缝集成，进一步简化了反馈收集与迭代优化的过程。

(We’re also working on a hosted version of LangServe, allowing for 1-click deploys of LangChain apps - sign up for the waitlist [here](https://airtable.com/app0hN6sd93QcKubv/shrAjst60xXa6quV2?ref=blog.langchain.com))

（我们还在开发 LangServe 的托管版本，支持一键部署 LangChain 应用——欢迎在此处登记加入等候名单：[此处](https://airtable.com/app0hN6sd93QcKubv/shrAjst60xXa6quV2?ref=blog.langchain.com)）

## LangSmith

## LangSmith

The final piece of the LangChain ecosystem is LangSmith - the control center for your LLM applications.

LangChain 生态系统的最后一环是 LangSmith——您大语言模型（LLM）应用的控制中心。

💡

💡

[LangSmith](https://smith.langchain.com/?ref=blog.langchain.com) is a platform that complements the GenAI development experience throughout all steps of the journey. It integrates seamlessly with LangChain but is also easily usable by itself. It is still in private beta (we are working towards GA) and you can get on the waitlist [here](https://smith.langchain.com/?ref=blog.langchain.com).

[LangSmith](https://smith.langchain.com/?ref=blog.langchain.com) 是一个贯穿生成式 AI（GenAI）开发全流程的协作平台，全面增强各阶段的开发体验。它与 LangChain 深度集成，同时也可独立使用、开箱即用。目前 LangSmith 仍处于私有 Beta 阶段（我们正全力推进正式版 GA 上线），您可通过此处登记加入等候名单：[此处](https://smith.langchain.com/?ref=blog.langchain.com)。

LangSmith comes in handy with a best-in-class debugging experience. By logging all steps of chains and agents, you can easily:

通过记录链（chains）和智能体（agents）的所有执行步骤，LangSmith 提供业界领先的调试体验，让您轻松实现：

- See exactly what steps were taken and in what order  
- 清晰查看每一步的执行顺序及具体内容

- See what the exact inputs to those steps were  
- 精确获知每一步所接收的输入内容

- See what the exact outputs of those steps were  
- 精确获知每一步所产生的输出结果

- Enter in a playground for a given step where you can modify the inputs and see how that changes the output  
- 进入指定步骤的交互式 Playground，在其中修改输入并实时观察输出变化

When you are building these complex chains and agents, where the main part is this non-deterministic language model, this type of observability is CRUCIAL. From the moment you get started building, LangSmith will massively increase your iteration speed.

当您构建这类复杂链与智能体时，其核心组件——非确定性的大语言模型——使得此类可观测性变得**至关重要**。从您开始构建的第一刻起，LangSmith 就将极大提升您的迭代速度。

LangSmith also contains a suite of additional tools aimed at taking your application from prototype to production. This includes:

LangSmith 还提供一整套进阶工具，助力您的应用从原型快速迈向生产环境。具体包括：

- Feedback collection – important to understand how users are interacting with your product  
- 用户反馈收集——深入理解用户如何与您的产品互动

- Datasets and testing – see our [recent](https://github.com/langchain-ai/langchain-benchmarks?ref=blog.langchain.com) [work](https://blog.langchain.com/public-langsmith-benchmarks/) [on evaluations](https://blog.langchain.com/extraction-benchmarking/) that uses this  
- 数据集与测试能力——参见我们近期利用该功能开展的[评估研究](https://github.com/langchain-ai/langchain-benchmarks?ref=blog.langchain.com)、[公开 LangSmith 基准测试](https://blog.langchain.com/public-langsmith-benchmarks/)以及[抽取任务基准评测](https://blog.langchain.com/extraction-benchmarking/)

- Monitoring – usage, feedback scores, latency, tokens  
- 运行监控——涵盖调用量、反馈评分、响应延迟、Token 消耗等指标

- Data annotation queue – for labeling data quickly  
- 数据标注队列——支持高效、批量的数据标注

- Hub – for collaborating on prompts  
- Prompt Hub——用于团队协作管理与共享 Prompt

For more information on all these features, check out the [YouTube highlight series](https://www.youtube.com/watch?v=bOaDQUCgKjw&list=PLfaIDFEXuae2CjNiTeqXG5r8n9rld9qQu&ref=blog.langchain.com) we recently released.

如需深入了解上述全部功能，请观看我们最新发布的 [YouTube 精选系列视频](https://www.youtube.com/watch?v=bOaDQUCgKjw&list=PLfaIDFEXuae2CjNiTeqXG5r8n9rld9qQu&ref=blog.langchain.com)。

## Roadmap

## 路线图

We have been thinking about, working on, and discussing this roadmap for a little over a month now. Below is summary of what steps we’ve taken, and what remains to come:

我们已就该路线图进行了一个多月的思考、开发与讨论。以下是目前已完成的工作及后续计划概览：

\[11/8 - DONE\] Split out `langchain-core`  
［11月8日 — 已完成］拆分出 `langchain-core`

\[12/11 - DONE\] Split out all integrations into `langchain-community`, release `langchain-core v0.1`  
［12月11日 — 已完成］将全部集成模块迁移至 `langchain-community`，并发布 `langchain-core v0.1`

\[12/11–1/5\] 将核心集成模块拆分为独立的软件包  

\[1/9\] 发布 `langchain v0.1`  

`langchain v0.1` 版本预计与当前所有现有功能完全兼容。我们暂未于今日发布 0.1 版本，原因在于：一方面，我们明确还有若干功能亟待加入；另一方面，我们也希望评估 `langchain` 中部分逻辑是否更适合迁移至 `langchain-core`。

## 这一举措带来的能力提升

此举最主要的意义在于推动生成式 AI（GenAI）生态系统的蓬勃发展。大语言模型（LLM）的应用场景看似无穷无尽。我们真正需要的是对这些场景开展更广泛的探索与深度优化，而非将精力耗费在重复实现流式响应、多模型支持、调用追踪等通用能力上。

这种包架构设计，不仅为上层应用开发铺平了道路，也为构建其他库和框架奠定了坚实基础——它们既可基于 LangChain 构建，也可与 LangChain 深度集成。目前，这一趋势已在 GPT Researcher、CrewAI、LlamaIndex、PandasAI 等诸多框架中初见端倪。

同时，这也使集成合作伙伴能够更全面地掌控其集成方案本身，乃至围绕该集成所构建的整套框架。DataStax 团队推出的 [RAGStack](https://www.datastax.com/blog/why-datastax-loves-langchain?ref=blog.langchain.com) 框架便是一个绝佳范例。该框架以 LangChain 为基础，聚焦两大方向：（1）提供业界领先的 AstraDB 与 CassandraDB 集成能力；（2）针对 CassandraDB 提出更具实践指导意义的架构选型与最佳实践。这使得 DataStax 能为其软件用户提供极致体验，同时也可无缝融入整个 LangChain 生态系统——无需重复造轮子，例如重新实现 LLM 接入、文档加载器、调用追踪等功能。

## 总结

我们对生成式 AI 领域最核心的认知是：它仍处于极早期阶段，且变化速度极快。随着该领域持续演进，整个 LangChain 生态系统也将同步进化。LangChain 早已不是一年前、甚至三个月前的模样。我们坚信，近期引入 `langchain-core` 与 `langchain-community` 等关键变更，正是为整个社区构筑坚实根基、共同迈向未来的必要之举。期待看到你用 LangChain 打造的精彩成果！🙂

# 常见问题（FAQs）

**Q: Which package should I start with?**

**Q：我应该从哪个包开始？**

A: If you are looking to get started from scratch, LangChain is probably still the best one to start with. It uses `langchain-core` and `langchain-community` under the hood, so exposes the largest collection of functionality.

A：如果您希望从零开始构建应用，LangChain 目前可能仍是最佳起点。它底层依赖 `langchain-core` 和 `langchain-community`，因此提供了最丰富的功能集合。

**Q: Are there compatibility considerations amongst the three packages or are versions interoperable?**

**Q：这三个包之间是否存在兼容性问题？不同版本是否可互操作？**

A: Right now, we have the current version of LangChain depending on `langchain-core>=0.1,<0.2`.

A：目前，LangChain 当前版本依赖 `langchain-core>=0.1,<0.2`。

**Q: What will happen to LangChain's chains and agents e.g. ConversationalRetrievalQA chain?**

**Q：LangChain 的 Chains 和 Agents（例如 `ConversationalRetrievalQA` Chain）将如何演进？**

A: They are sticking around as an easy way to get started with particular use cases! We’ll be transitioning more and more of them use LCEL under the hood (or creating LCEL equivalents) to gain the benefits of LCEL, but these higher level interfaces will always be there (and are a focus of ours over the next month).

A：它们将继续保留，作为快速上手特定用例的便捷方式！我们将逐步让越来越多的 Chains 和 Agents 在底层采用 LCEL（LangChain Expression Language），或为其创建对应的 LCEL 实现，从而获得 LCEL 带来的各项优势；但这些高层级接口将始终可用（并且未来一个月内，它们也是我们的重点优化方向）。

**Q: Which version should I upgrade to?**

**Q：我应该升级到哪个版本？**

A: `langchain>=0.0.350` has all the updates!

A：`langchain>=0.0.350` 已包含全部更新！

**Q: Do I need to upgrade?**

**Q：我必须升级吗？**

A: You don't NEED to! All these changes were done in a backwards compatible way, so you can safely ignore should you choose.

A：您**无需强制升级**！所有这些变更均以向后兼容的方式实现，因此若您选择不升级，也可完全放心，不会产生任何影响。

**Q: I'm a contributor to a LangChain integration and would like to create a separate package. How can I do so?**

**Q：我是 LangChain 集成项目的贡献者，希望为其创建一个独立的软件包。我该如何操作？**

A: We will be adding instructions and a CLI to help with that over the next few days - keep an eye on the GitHub discussions for that.

A：我们将在未来几天内提供相关说明及命令行工具（CLI）来协助完成此任务——请持续关注 GitHub 上的相关讨论。