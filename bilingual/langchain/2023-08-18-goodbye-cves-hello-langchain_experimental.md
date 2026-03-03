---
title: "Goodbye CVEs, Hello `langchain_experimental`"
source: "LangChain Blog"
url: "https://blog.langchain.com/goodbye-cves-hello-langchain_experimental/"
date: "2023-08-18"
scraped_at: "2026-03-03T09:09:13.837008663+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---

One of the things that LangChain seeks to enable is connecting language models to external sources of data and computation. This allows language models to act as the reasoning engine and outsource knowledge and execution to other systems. Some examples of this include:

LangChain 致力实现的目标之一，是将语言模型与外部数据源和计算资源连接起来。这使得语言模型能够充当“推理引擎”，将知识获取与任务执行外包给其他系统。此类应用的典型示例包括：

- Retrieval augmented generation: Hooking a language model up to a retrieval system and using that influence the generation. This allows language models to answer questions about information other than what they were trained on.  
- 检索增强生成（Retrieval Augmented Generation）：将语言模型接入检索系统，并利用检索结果影响文本生成过程。这使语言模型能够回答其训练语料之外的信息相关问题。

- Interacting with APIs: Having a language model generate the route and parameters to call for a specific API request. This allows humans to interact with an API through natural language.  
- 与 API 交互：让语言模型自动生成特定 API 请求所需的路径（route）与参数。这使人能够通过自然语言与 API 进行交互。

- Code generation: Having a language model write and then execute code. This can enable people to generate code just by asking.  
- 代码生成：让语言模型编写代码并执行。这使得用户仅需提出需求，即可生成可用代码。

While this is powerful, it can also be dangerous. A lot has been discussed around AI safety, and there are many different types and considerations for AI safety. The type that we are most concerned with is what happens when you hook up language models to other systems. While doing this can enable lots of amazing experience (like the ones listed above) it also opens up a whole new risk vector.

尽管这一能力极为强大，但也潜藏风险。围绕 AI 安全性的讨论已十分广泛，AI 安全涵盖多种类型与考量维度。而我们最关注的一类风险，正是当语言模型被接入其他系统时所引发的问题。虽然这种集成能催生诸多惊艳体验（如上文所列），但同时也开辟了一条全新的风险通道。

This risk vector emerges when the language model generates output that is unsafe to pass downstream, whether that be an API request that deletes some data or some malicious code that deletes all files. This can occur naturally or maliciously. It can occur naturally when the language model simply messes up - as its prone to do. It can also occur maliciously, through techniques like prompt injection.

该风险通道具体表现为：语言模型生成了下游系统无法安全处理的输出——例如一条会删除部分数据的 API 请求，或一段会清空全部文件的恶意代码。此类问题既可能自然发生（即语言模型因固有局限而“出错”），也可能被恶意诱发（例如通过提示词注入（prompt injection）等攻击手段）。

LangChain started off as highly experimental and included a lot of these use cases, as those uses were the ones pushing boundary of what was possible. Some of these use cases have security concerns, some don’t. As LangChain matures, we want to better separate those uses to allow for that distinction.

LangChain 诞生之初高度强调实验性，大量纳入了上述用例——因为它们正代表着当时技术能力的前沿边界。其中部分用例存在安全隐忧，另一些则相对安全。随着 LangChain 日趋成熟，我们希望更清晰地区分这两类用途，以体现其差异性。

We’ve taken a first stab at that by releasing `langchain_experimental`, a separate Python package. We’ve moved all components that raised CVEs into that package. We’ve also moved everything previously in the `langchain.experimental` module there as well. You can find instructions on how to migrate [here](https://github.com/langchain-ai/langchain/blob/master/MIGRATE.md?ref=blog.langchain.com).

为此，我们迈出的第一步是发布独立的 Python 包 `langchain_experimental`。所有曾触发 CVE（通用漏洞披露）的安全敏感组件均已迁移至此包中；此前位于 `langchain.experimental` 模块下的全部内容也一并迁移至此。迁移指南详见[此处](https://github.com/langchain-ai/langchain/blob/master/MIGRATE.md?ref=blog.langchain.com)。

Going forward, we have the dual goals of making core `langchain` more robust and production ready, while also pushing forward rapidly with `langchain_experimental`. We’ve been slow to accept some more experimental features, but this separation will now hopefully speed that up.

未来，我们将同步推进两大目标：一方面持续强化核心 `langchain` 包的健壮性与生产就绪度；另一方面加速推进 `langchain_experimental` 的创新演进。过去我们对部分更具实验性的功能采纳较为审慎，而此次架构分离有望显著提升相关功能的落地效率。

We will also likely move more things over to `langchain_experimental` over time. When we do this, we will always give at least a week’s notice before making any breaking changes, and update the [migration guide](https://github.com/langchain-ai/langchain/blob/master/MIGRATE.md?ref=blog.langchain.com).

后续我们还可能逐步将更多组件迁移至 `langchain_experimental`。每次涉及破坏性变更前，我们都将至少提前一周发出通知，并同步更新[迁移指南](https://github.com/langchain-ai/langchain/blob/master/MIGRATE.md?ref=blog.langchain.com)。

We’d like to thank the entire community for understanding, as well as their patience as we iron out any kinks. In particular we’d like to thank some community members for their help and encouragement on this: Rich Harang (and the entire Nvidia team), Justin Flick, Or Raz, and Boaz Wasserman.

衷心感谢整个社区的理解与耐心——在我们不断打磨、修复各类问题的过程中，你们的支持弥足珍贵。特别感谢以下社区成员在此过程中给予的帮助与鼓励：Rich Harang（及 NVIDIA 全体团队）、Justin Flick、Or Raz 和 Boaz Wasserman。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/goodbye-cves-hello-langchain_experimental/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/goodbye-cves-hello-langchain_experimental/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/goodbye-cves-hello-langchain_experimental/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/goodbye-cves-hello-langchain_experimental/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/goodbye-cves-hello-langchain_experimental/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/goodbye-cves-hello-langchain_experimental/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[![Introducing OpenTelemetry support for LangSmith](images/goodbye-cves-hello-langchain_experimental/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/goodbye-cves-hello-langchain_experimental/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![Easier evaluations with LangSmith SDK v0.2](images/goodbye-cves-hello-langchain_experimental/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更简易的评估](images/goodbye-cves-hello-langchain_experimental/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更简易的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/goodbye-cves-hello-langchain_experimental/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph Platform 进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项](images/goodbye-cves-hello-langchain_experimental/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform 进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)