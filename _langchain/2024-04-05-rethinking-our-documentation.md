---
title: "Rethinking Our Documentation"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-documentation-refresh/"
date: "2024-04-05"
scraped_at: "2026-03-03T08:04:23.455634167+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

[LangChain](https://github.com/langchain-ai/langchain?ref=blog.langchain.com)  
[LangChain](https://github.com/langchain-ai/langchain?ref=blog.langchain.com)

has seen some incredible growth in the last year and half. The Python open-source library is now downloaded over **7 million times per month**, and has had more than **20,000 pull requests** and **2,500 contributors**!

过去一年半以来，LangChain 实现了令人瞩目的增长。这款 Python 开源库目前每月下载量已超 **700 万次**，累计提交 Pull Request 超过 **20,000 次**，贡献者达 **2,500 人**！

The community is truly what makes LangChain incredible, and we're beyond thankful to everyone who has pitched in. But this exponential growth has also exponentially increased the surface area our documentation has had to cover. This has led to some issues with organization and discoverability at times.

真正让 LangChain 卓越非凡的，是其充满活力的社区；我们由衷感谢每一位参与共建的贡献者！然而，这种指数级的增长，也使得文档需要覆盖的知识广度呈指数级扩大，一度导致文档在组织结构与内容可发现性方面出现挑战。

We're excited to announce that we've launched new-look docs that address some of these issues! In addition to a facelift, we're embracing a more robust framework for organization and structure that will guide us going forwards.

我们很高兴地宣布：全新改版的文档现已正式上线！此次升级不仅是一次视觉焕新（facelift），更引入了一套更稳健、可持续演进的文档组织与架构框架，将为未来的内容建设提供清晰指引。

[Have a look for yourself](https://python.langchain.com/?ref=blog.langchain.com), or continue reading for information on some of the guiding principles and thought processes we used!

[欢迎亲自体验](https://python.langchain.com/?ref=blog.langchain.com)，或继续阅读，了解本次重构所遵循的核心理念与设计思路！

![](images/rethinking-our-documentation/img_001.png)  
![](images/rethinking-our-documentation/img_001.png)  
The extraction use-case quickstart  
抽取类用例快速入门

## Philosophy  
## 哲学理念

The guiding philosophy behind this refactor is called [Diátaxis](https://diataxis.fr/?ref=blog.langchain.com). Under Diátaxis, all documentation should be organized around one of four categories:

本次重构所依托的核心理念名为 [Diátaxis](https://diataxis.fr/?ref=blog.langchain.com)。依据 Diátaxis 理论，所有技术文档均应围绕以下四类之一进行组织：

- **Tutorials**: Lessons that take the reader by the hand through a series of conceptual steps to complete a project.  
  - **教程（Tutorials）**：以手把手方式引导读者完成一系列概念性步骤，最终实现一个完整项目。  
  - An example of this is our [streaming page](https://python.langchain.com/docs/expression_language/streaming?ref=blog.langchain.com).  
    - 典型示例是我们的 [流式处理页面](https://python.langchain.com/docs/expression_language/streaming?ref=blog.langchain.com)。  
  - Our guides on [custom components](https://python.langchain.com/docs/modules/model_io/chat/custom_chat_model?ref=blog.langchain.com) could be seen as another example.  
    - 我们关于 [自定义组件](https://python.langchain.com/docs/modules/model_io/chat/custom_chat_model?ref=blog.langchain.com) 的指南亦属此类。

- **How-to guides**: Guides that take the reader through the steps required to solve a real-world problem.  
  - **操作指南（How-to guides）**：指导读者按步骤解决某一真实世界中的具体问题。  
  - The clearest examples of this are our [Use case](https://python.langchain.com/docs/use_cases/?ref=blog.langchain.com) quickstart pages.  
    - 最典型的例子是我们的 [用例（Use case）快速入门页面](https://python.langchain.com/docs/use_cases/?ref=blog.langchain.com)。

- **Reference**: Technical descriptions of the machinery and how to operate it.  
  - **参考文档（Reference）**：对系统机制及其使用方法的技术性说明。  
  - Our [Runnable interface](https://python.langchain.com/docs/expression_language/interface?ref=blog.langchain.com) page is an example of this.  
    - 我们的 [Runnable 接口页面](https://python.langchain.com/docs/expression_language/interface?ref=blog.langchain.com) 即属此类。  
  - The [API reference pages](https://api.python.langchain.com/?ref=blog.langchain.com) are another.  
    - [API 参考文档](https://api.python.langchain.com/?ref=blog.langchain.com) 同样属于此类。

- **Explanation**: Explanations that clarify and illuminate a particular topic.  
  - **阐释说明（Explanation）**：对特定主题进行深入浅出的解析与阐释，帮助读者建立清晰理解。  
  - The new [LCEL primitives pages](https://python.langchain.com/docs/expression_language/primitives/sequence?ref=blog.langchain.com) are an example of this.  
    - 新上线的 [LCEL 原语页面](https://python.langchain.com/docs/expression_language/primitives/sequence?ref=blog.langchain.com) 即为此类代表。

Each category serves a distinct purpose and requires a specific approach to writing and structuring the content.  
每一类文档均有其独特目标，也相应要求特定的写作方式与内容组织逻辑。

## Taxonomy  
## 分类体系

Keeping the above in mind, we have resorted and reorganized pages into the following categories:

考虑到以上原则，我们对页面进行了重新分类与整理，划分为以下几类：

### Getting started

### 入门指南

The [getting started section](https://python.langchain.com/docs/get_started/introduction?ref=blog.langchain.com) includes a high-level introduction to LangChain, a quickstart that aims to be a tour of various concepts, and logistical instructions around installation and project setup.

[入门指南](https://python.langchain.com/docs/get_started/introduction?ref=blog.langchain.com) 包含 LangChain 的高层级概览介绍、一个旨在全面浏览各项核心概念的快速上手教程（quickstart），以及关于安装和项目搭建等实操性说明。

It contains elements of **How-to guides** and **Explanations**.

该部分融合了 **操作指南（How-to guides）** 和 **原理阐释（Explanations）** 的内容要素。

### Use cases

### 应用场景

[Use cases](https://python.langchain.com/docs/use_cases/?ref=blog.langchain.com) are guides that are meant to show how to use LangChain to accomplish a specific task (RAG, information extraction, etc.).

[应用场景](https://python.langchain.com/docs/use_cases/?ref=blog.langchain.com) 是一系列指导性文档，旨在展示如何使用 LangChain 完成特定任务（如 RAG、信息抽取等）。

The quickstarts should be good entrypoints for first-time LangChain developers who prefer to learn by getting something practical prototyped,  
then taking the pieces apart retrospectively. These should mirror what LangChain is good at.

这些快速上手教程应成为初次接触 LangChain 的开发者的理想入门入口——他们倾向于通过快速构建一个可运行的实用原型来学习，再回溯性地拆解各组件。这些内容应充分体现 LangChain 的核心优势与典型能力。

The quickstart pages here should fit the **How-to guide** category, with the other pages intended to be **Explanations** of more  
in-depth concepts and strategies that accompany the main happy paths.

此处的快速上手页面应归入 **操作指南（How-to guide）** 类别；其余页面则旨在作为 **原理阐释（Explanations）**，深入讲解伴随主干流程（即典型成功路径，“happy paths”）的核心概念与进阶策略。

> **Note:** The below sections are listed roughly in order of increasing level of abstraction.

> **注意：** 以下各节大致按抽象层级由低到高的顺序排列。

### Expression Language

### 表达式语言

[LangChain Expression Language (LCEL)](https://python.langchain.com/docs/expression_language/?ref=blog.langchain.com) is the fundamental way that most LangChain components fit together, and this section is designed to teach

[LangChain 表达式语言（LCEL）](https://python.langchain.com/docs/expression_language/?ref=blog.langchain.com) 是大多数 LangChain 组件协同工作的基础机制，本节旨在帮助开发者掌握如何高效运用 LangChain 的基础构件（primitives）构建应用。

developers how to use it to build with LangChain's primitives effectively.

本节应包含以下内容：**教程（Tutorials）**，讲解如何流式处理及使用 LCEL 基础构件完成更高层次的任务；**说明（Explanations）**，解析特定行为背后的原理；以及部分**参考文档（References）**，介绍 `Runnable` 接口各类方法的使用方式。

This section should contains **Tutorials** that teach how to stream and use LCEL primitives for more abstract tasks, **Explanations** of specific behaviors,

and some **References** for how to use different methods in the Runnable interface.

### Components

### 组件

The [components section](https://python.langchain.com/docs/modules?ref=blog.langchain.com) covers concepts one level of abstraction higher than LCEL.

[组件（Components）章节](https://python.langchain.com/docs/modules?ref=blog.langchain.com) 所涵盖的概念，其抽象层级比 LCEL 高一级。

Abstract base classes like `BaseChatModel` and `BaseRetriever` should be covered here, as well as core implementations of these base classes,

诸如 `BaseChatModel` 和 `BaseRetriever` 等抽象基类应在此处介绍，同时涵盖这些基类的核心实现，例如 `ChatPromptTemplate` 和 `RecursiveCharacterTextSplitter`；

such as `ChatPromptTemplate` and `RecursiveCharacterTextSplitter`. Customization guides belong here too.

定制化指南（Customization guides）也应归入本节。

This section should contain mostly conceptual **Tutorials**, **References**, and **Explanations** of the components they cover.

本节应主要包含所涉组件的概念性**教程（Tutorials）**、**参考文档（References）** 和 **说明（Explanations）**。

> **Note:** As a general rule of thumb, everything covered in the `Expression Language` and `Components` sections (with the exception of the `Composition` section of components) should cover only components that exist in `langchain_core`.

> **注意：** 一般而言，`表达式语言（Expression Language）` 和 `组件（Components）` 章节（组件的 `组合（Composition）` 小节除外）中涵盖的所有内容，应仅限于 `langchain_core` 中实际存在的组件。

### Integrations

### 集成（Integrations）

The [integrations](https://python.langchain.com/docs/integrations/platforms/?ref=blog.langchain.com) are specific implementations of components. These often involve third-party APIs and services.

[集成（Integrations）](https://python.langchain.com/docs/integrations/platforms/?ref=blog.langchain.com) 是组件的具体实现，通常涉及第三方 API 和服务。

If this is the case, as a general rule, these are maintained by the third-party partner.

若属此类情况，一般由第三方合作伙伴负责维护。

This section should contain mostly **Explanations** and **References**, though the actual content here is more flexible than other sections and more at the  
discretion of the third-party provider.

本节应主要包含 **说明（Explanations）** 和 **参考文档（References）**；不过，此处的实际内容相较于其他章节更为灵活，其具体形式更多取决于第三方提供商的自主决定。

> **Note:** Concepts covered in `Integrations` should generally exist in `langchain_community` or specific partner packages.

> **注意：** `集成（Integrations）` 章节中涵盖的概念，通常应存在于 `langchain_community` 或特定合作伙伴的独立软件包中。

### Guides and Ecosystem

### 指南与生态（Guides and Ecosystem）

The [Guides](https://python.langchain.com/docs/guides?ref=blog.langchain.com) and [Ecosystem](https://python.langchain.com/docs/langsmith/?ref=blog.langchain.com) sections should contain guides that address higher-level problems than the sections above.

[指南（Guides）](https://python.langchain.com/docs/guides?ref=blog.langchain.com) 和 [生态（Ecosystem）](https://python.langchain.com/docs/langsmith/?ref=blog.langchain.com) 章节应包含面向更高层次问题的指南，其抽象层级高于前述各章节。

This includes, but is not limited to, considerations around productionization and development workflows.

这包括但不限于有关规模化部署（productionization）和开发工作流的考量。

These should contain mostly **How-to guides**, **Explanations**, and **Tutorials**.

这些内容应主要包含**操作指南（How-to guides）**、**原理说明（Explanations）** 和 **教程（Tutorials）**。

### API references

### API 参考文档

LangChain's [API references](https://api.python.langchain.com/?ref=blog.langchain.com). Should act as **References** (as the name implies) with some **Explanation**-focused content as well.

LangChain 的 [API 参考文档](https://api.python.langchain.com/?ref=blog.langchain.com)，应主要承担**参考手册（References）** 的功能（顾名思义），同时也需包含部分以**原理说明（Explanation）** 为重点的内容。

## Sample developer journey

## 示例开发者学习路径

We've tried to organize everything for a new LangChain developer. Let's walk through the intended path:

我们已尽力为新加入 LangChain 的开发者梳理出一条清晰的学习路径。下面一起来看看我们建议的入门流程：

- The developer lands on [https://python.langchain.com](https://python.langchain.com/?ref=blog.langchain.com), and reads through the introduction and the diagram.

- 开发者首先访问 [https://python.langchain.com](https://python.langchain.com/?ref=blog.langchain.com)，通读首页的简介文字与架构图。

- If they are just curious, they may be drawn to the [Quickstart](https://python.langchain.com/docs/get_started/quickstart?ref=blog.langchain.com) to get a high-level tour of what LangChain contains.

- 如果只是初步了解，他们可能会被 [快速入门（Quickstart）](https://python.langchain.com/docs/get_started/quickstart?ref=blog.langchain.com) 吸引，从而获得对 LangChain 功能范围的宏观概览。

- If they have a specific task in mind that they want to accomplish, they will be drawn to the Use-Case section. The use-case should provide a good, concrete hook that shows the value LangChain can provide them and be a good entrypoint to the framework.

- 如果已有明确目标或具体任务，他们将更倾向于进入“用例（Use-Case）”章节——该章节应提供切实、具体的切入点，清晰展现 LangChain 能为其带来的实际价值，并成为其深入使用框架的良好起点。

- They can then move to learn more about the fundamentals of LangChain through the Expression Language sections.

- 接下来，他们可通过“表达式语言（Expression Language）”章节进一步掌握 LangChain 的核心基础概念。

- Next, they can learn about LangChain's various components and integrations.

- 随后，他们可系统学习 LangChain 的各类组件及其集成能力。

- Finally, they can get additional knowledge through the Guides.

- 最后，他们可通过“指南（Guides）”获取更深入、更场景化的知识补充。

This is only an ideal of course - sections will inevitably reference lower or higher-level concepts that are documented in other sections. We will also try to add more internal links to pages to help developers learn concepts in context.

当然，这仅是一个理想化的学习路径——各章节不可避免地会涉及其他章节中定义的低阶或高阶概念。我们也将努力增加更多站内链接，帮助开发者在具体上下文中理解相关概念。

## Thank you!

## 感谢！

Thank you for reading! Making our docs awesome will be an ongoing process, and we appreciate your continued support. We still have a lot of work to do, especially on outdated content, but we hope this will help our documentation scale over the coming years.

感谢您的阅读！打造卓越的文档是一项持续进行的工作，我们衷心感谢您一如既往的支持。目前仍有许多待办事项，尤其是大量陈旧内容亟待更新；但我们相信，这一规划将助力我们的文档体系在未来数年中不断扩展与完善。

Expect to see similar improvements to [LangChain.js](https://github.com/langchain-ai/langchainjs?ref=blog.langchain.com) over the next few weeks too!

未来几周内，您也将看到对 [LangChain.js](https://github.com/langchain-ai/langchainjs?ref=blog.langchain.com) 的类似改进！

We have also added thumbs up and thumbs down buttons to individual pages, which we will use to monitor sentiment. And if you have any specific comments, feel free to reach out via [Twitter](https://twitter.com/langchainai?ref=blog.langchain.com).

我们还在各页面新增了“点赞”和“点踩”按钮，用于监测用户情绪反馈。如果您有任何具体意见或建议，欢迎通过 [Twitter](https://twitter.com/langchainai?ref=blog.langchain.com) 与我们联系。

Stay tuned for more!

敬请期待更多更新！
&#123;% endraw %}
