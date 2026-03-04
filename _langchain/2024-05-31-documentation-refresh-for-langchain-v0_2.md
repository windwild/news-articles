---
title: "Documentation Refresh for LangChain v0.2"
source: "LangChain Blog"
url: "https://blog.langchain.com/documentation-refresh-for-langchain-v0-2/"
date: "2024-05-31"
scraped_at: "2026-03-03T08:02:00.166361662+00:00"
language: "en-zh"
translated: true
description: "Learn about the docs refresh for LangChain v0.2. There's now versioned docs and a clearer structure — with tutorials, how-to guides, conceptual guides, and API docs"
---
{% raw %}

**_LangChain v0.2 现已向所有用户开放（有关此次发布的动机与详细信息，请点击此处了解_** [**_详情_**](https://blog.langchain.com/langchain-v02-leap-to-stability/) **_）。本次发布的一大亮点是我们的文档全面焕新。我们想借此机会，详细介绍此次文档更新的具体内容，并特别感谢社区成员长期以来的积极反馈与推动。_**

## 社区驱动的文档反馈

你们发声了，我们倾听了。在持续收到来自 LangChain 社区开发者关于“文档亟需改进”的一致反馈后，我们决定直面其中若干关键问题，并说明我们为改善这些问题所做出的努力。同时，我们也要特别感谢几位社区成员——他们不仅提供了宝贵意见，还积极参与共建。

我们所听到并着力解决的主要问题包括：

- **文档频繁变动**。跟上变更节奏令人疲惫——因此我们引入了**版本化文档（versioned docs）**。现在，每个次要版本（minor version）都配有专属、精准匹配的文档。
- **难以快速定位相关信息**。过去文档结构如迷宫般错综复杂；如今，新版文档采用极简扁平化结构，清晰划分为四大板块：**教程（Tutorials）**、**操作指南（How-to Guides）**、**概念指南（Conceptual Guides）** 以及 **API 参考（API Reference）**，让信息检索更高效、更一致。
- **内容陈旧且重复冗余**。我们已全面“大扫除”。新版文档结构对相关内容进行了整合归并，彻底剔除了重复冗余内容。精简后的文档集将显著降低误用过时信息的风险。
- **缺乏清晰的升级指引**。为提供一套长期有效、可持续更新的操作指南，我们专门编写了 [《LangChain 演进历程》文档](https://python.langchain.com/v0.2/docs/versions/overview/?ref=blog.langchain.com)，系统梳理 LangChain 最新版本的变更要点，并详述迁移步骤与方法。

本文博客将概览部分新特性；若您希望获得更直观、实操性更强的体验，欢迎观看我们制作的 [YouTube 视频讲解](https://www.youtube.com/watch?v=JivDaHOEXpk&ref=blog.langchain.com)，带您逐页浏览全新文档！

## 版本化文档

自 2022 年 10 月 Python 包首次发布以来，LangChain 已历经显著演进，其配套文档亦同步持续迭代。这些更新反映了我们对“如何更优地使用 LangChain”这一问题日益深化的认知模型，但同时也可能令部分用户感到困惑或迷失方向。

自 v0.2 版本起，我们将为**所有次要版本（minor versions）提供独立、可追溯的版本化文档**。这意味着，v0.1 版本的文档仍将完整保留并可供访问，方便习惯该版本的用户继续使用。当前所有可用文档版本列表，均可在页面顶部导航栏中查看。

![](images/documentation-refresh-for-langchain-v0_2/img_001.png)

We hope this strikes a balance between updating our documentation, while not throwing off everyone’s mental model.

我们希望此举能在更新文档的同时，不至于打乱每位用户的既有认知模型。

## Documentation structure

## 文档结构

In this iteration, we’ve embraced the Diataxis taxonomy to make our docs more clear and user-friendly.  Previously, we only partially implemented this, which [wasn’t enough](https://www.reddit.com/r/LangChain/comments/1by72bo/new_documentation_is_still_bad/?ref=blog.langchain.com). We’ve now adopted this approach fully and have our main documentation fully separated out accordingly.

在本次迭代中，我们全面采用 Diataxis 分类法，以使文档更加清晰、更易于用户使用。此前，我们仅部分实施了该分类法，而实践证明这[尚不足够](https://www.reddit.com/r/LangChain/comments/1by72bo/new_documentation_is_still_bad/?ref=blog.langchain.com)。如今，我们已全面采纳这一方法，并据此将主文档彻底分门别类。

![](images/documentation-refresh-for-langchain-v0_2/img_002.png)

**Tutorials** are step-by-step guides for how to build specific applications from start to finish with LangChain, like a chatbot, RAG application, or agent. See the image below for an example of a tutorial.

**教程（Tutorials）** 是面向 LangChain 的端到端分步指南，指导用户从零开始构建特定应用，例如聊天机器人、RAG 应用或智能体（agent）。下方图片即为一个教程示例。

![](images/documentation-refresh-for-langchain-v0_2/img_003.png)

**How-to guides** are detailed instruction guides for how to do particular tasks. This goes more in-depth than a tutorial, covering slightly more advanced topics.

**操作指南（How-to guides）** 是针对特定任务的详细操作说明，其内容比教程更为深入，涵盖稍具进阶性的主题。

![](images/documentation-refresh-for-langchain-v0_2/img_004.png)

Our brand-new **conceptual guide** is a handy glossary of terminology and a list of different techniques. This is ideal for referencing new concepts or getting the bigger picture of how LangChain works.

我们全新推出的**概念指南（Conceptual guide）**，既是一份实用的术语词典，也是一份不同技术方法的汇总清单。它非常适合用于查阅新概念，或整体把握 LangChain 的工作原理。

![](images/documentation-refresh-for-langchain-v0_2/img_005.png)

Finally, our **API docs** contain detailed technical reference documentation.

最后，我们的 **API 文档** 包含详尽的技术参考文档。

![](images/documentation-refresh-for-langchain-v0_2/img_006.png)

![](images/documentation-refresh-for-langchain-v0_2/img_006.png)

Together, these changes make the docs structure much more flat (easier to find things) and more consolidated (less likely to have duplicated content).

综上所述，这些变更使文档结构更加扁平化（更易于查找内容），也更加统一集中（显著减少内容重复）。

## LangChain over time

## LangChain 的演进历程

Our new “LangChain over time” section in the docs helps you stay on top of changes. There are guides on how LangChain has changed, how to upgrade, and how to map previous concepts from old versions to new ones. This has been a much-requested community feature — and we agree that it’s much needed!

我们在文档中新增的“LangChain 的演进历程”（LangChain over time）板块，助您及时掌握各项变更。其中包含 LangChain 的演进说明、升级指南，以及旧版本概念到新版本概念的映射对照。这一功能是社区长期呼吁的重要需求——我们完全认同其必要性！

![](images/documentation-refresh-for-langchain-v0_2/img_007.png)

![](images/documentation-refresh-for-langchain-v0_2/img_007.png)

## A huge thank you

## 衷心感谢

Improving the docs has been a team and community effort at LangChain. A big shoutout to [Leo Gan](https://github.com/leo-gan?ref=blog.langchain.com), our top contributor to the docs. And thank you to everyone in the community for your feedback and help. We will continue to iterate and develop our documentation to help all devs better navigate this new world of LLM applications.

文档的优化完善，是 LangChain 团队与整个社区通力协作的成果。特别鸣谢 [Leo Gan](https://github.com/leo-gan?ref=blog.langchain.com)，他是本次文档建设贡献最多的成员。同时，衷心感谢社区每一位朋友提出的宝贵反馈与鼎力支持。我们将持续迭代与完善文档，助力所有开发者更从容地驾驭大语言模型（LLM）应用这一全新领域。

* * *

* * *

**_LangChain v0.2 is all about improving stability and discoverability. Check out the new docs (_** [**_Python_**](https://python.langchain.com/v0.2/docs/introduction/?ref=blog.langchain.com) **_and_** [**_JS_**](https://js.langchain.com/v0.2/docs/introduction/?ref=blog.langchain.com) **_) – and drop us a line in_** [**_GitHub_**](https://github.com/langchain-ai/langchain/discussions/21716?ref=blog.langchain.com) **_. You can also read more about LangChain v0.2_** [**_here_**](https://blog.langchain.com/langchain-v02-leap-to-stability/) **_._**

**LangChain v0.2 的核心目标是提升稳定性与可发现性。欢迎访问全新文档：**[**Python 版本**](https://python.langchain.com/v0.2/docs/introduction/?ref=blog.langchain.com) **与** [**JS 版本**](https://js.langchain.com/v0.2/docs/introduction/?ref=blog.langchain.com) **——也欢迎随时在** [**GitHub 讨论区**](https://github.com/langchain-ai/langchain/discussions/21716?ref=blog.langchain.com) **与我们交流！您还可点击此处** [**进一步了解 LangChain v0.2**](https://blog.langchain.com/langchain-v02-leap-to-stability/) **。**
{% endraw %}
