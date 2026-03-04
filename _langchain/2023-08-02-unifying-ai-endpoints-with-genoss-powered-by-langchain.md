---
title: "Unifying AI endpoints with Genoss, powered by LangChain"
source: "LangChain Blog"
url: "https://blog.langchain.com/unifying-ai-endpoints-with-genoss/"
date: "2023-08-02"
scraped_at: "2026-03-03T09:26:30.130960663+00:00"
language: "en-zh"
translated: true
---
{% raw %}

**_Editor’s Note: This blog post was written by [Matt Carey](https://twitter.com/mattzcarey?ref=blog.langchain.com), one of the builders of Genoss. We're sharing it on our blog too because we hear from a lot of people that don't want to get locked in to a single model. We think tools like Genoss that provide clean interfaces for interoperability will help more builders get robust apps into production fast. We're also incredibly excited about the integration it has with [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) to enable easy debugging, logging, monitoring, and observability!_**

**_编者按：本文由 Genoss 的构建者之一 [Matt Carey](https://twitter.com/mattzcarey?ref=blog.langchain.com) 撰写。我们也在本博客同步发布此文，因为许多用户向我们反馈：他们不希望被锁定在某一个模型供应商上。我们认为，像 Genoss 这样提供清晰互操作接口的工具，将帮助更多开发者快速将健壮的应用投入生产。此外，我们对 Genoss 与 [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) 的深度集成也倍感振奋——它让调试、日志记录、监控和可观测性变得轻而易举！_**

![](images/unifying-ai-endpoints-with-genoss-powered-by-langchain/img_001.jpg)

**Introducing** [**Genoss GPT**](https://genoss.ai/?ref=blog.langchain.com) **: One line GPT application portability with the Genoss model gateway.**

**隆重推出** [**Genoss GPT**](https://genoss.ai/?ref=blog.langchain.com) **：借助 Genoss 模型网关，仅需一行代码即可实现 GPT 应用的可移植性。**

_TL;DR: GenossGPT offers a universal interface for interacting with GPT models, simplifying the task of integrating and switching between models in your GenAI-powered application. It gives businesses control over their model usage, while leveraging LangSmith to provide enhanced observability and analytics in production._

_简而言之：GenossGPT 为调用各类 GPT 模型提供了统一接口，极大简化了在生成式 AI（GenAI）应用中集成与切换不同模型的操作流程。它赋予企业对其模型使用方式的完全掌控权，同时依托 LangSmith 实现生产环境中的增强可观测性与分析能力。_

Development in the generative AI space continues to pick up steam, with an ever-expanding range of uses being found for large language models (LLMs). These uses span diverse domains including personal assistants, document retrieval, as well as image and text generation. Groundbreaking apps like ChatGPT have paved the way for companies to dive into the space and start building with this technology.

生成式 AI 领域的发展势头持续增强，大语言模型（LLM）的应用场景正不断拓展——涵盖个人助理、文档检索，以及图像与文本生成等多元领域。ChatGPT 等开创性应用已为各家企业铺平道路，使其得以深入该领域并着手基于此技术构建产品。

Big players are building their own models such as AWS with their Titan models, Meta with their newly released Llama 2, and Microsoft with their partnerships with both OpenAI and Meta, showing that there is serious investment in the space.

科技巨头正纷纷自研大模型：AWS 推出 Titan 系列模型，Meta 发布全新 Llama 2，微软则分别与 OpenAI 和 Meta 建立深度合作。这充分表明，业界对该领域正进行着大规模、高优先级的战略投入。

Unicorn startups like Hugging Face, [raising money at a $4 billion valuation](https://www.forbes.com/sites/alexkonrad/2023/07/13/ai-startup-hugging-face-raising-funds-4-billion-valuation/?ref=blog.langchain.com), have dominated the open-source space and allow anyone to deploy models with ease. Universities will continue to push the envelope of what is possible on a budget, and these innovations will feed back into open-source projects. However, it is unlikely that smaller companies will be able to compete with big tech giants in building production LLMs from scratch due to the high costs.

Hugging Face 等独角兽初创公司——[最新融资估值已达 40 亿美元](https://www.forbes.com/sites/alexkonrad/2023/07/13/ai-startup-hugging-face-raising-funds-4-billion-valuation/?ref=blog.langchain.com)——已在开源生态中占据主导地位，使任何人都能轻松部署各类模型。高校将持续以有限预算挑战技术边界，其创新成果也将反哺开源项目。然而，受限于高昂成本，中小型企业几乎不可能在从零开始构建可用于生产的 LLM 方面，与科技巨头展开正面竞争。

Ecosystems like [LangChain](https://python.langchain.com/docs/get_started/introduction.html?ref=blog.langchain.com) provide a set of helpful utilities for developers interacting with these third-party LLMs, or foundational models as they are often called. LangChain classes help developers leverage models with I/O and memory, as well as providing model chains to accomplish specific tasks such as document retrieval. Additionally, LangChain establishes a standard vocabulary, introducing terms like ‘RetrievalChain’ and ‘MemoryStore’ with well-defined meanings in the ecosystem, thereby streamlining discourse among AI engineers.

[LangChain](https://python.langchain.com/docs/get_started/introduction.html?ref=blog.langchain.com) 等生态系统，为开发者对接第三方大语言模型（常被称为“基础模型”）提供了一套实用工具集。LangChain 的各类类库，助力开发者便捷地为模型集成输入/输出（I/O）与记忆机制（memory），并支持构建模型链（model chains）以完成特定任务（如文档检索）。此外，LangChain 还确立了一套标准术语体系，明确定义了 “RetrievalChain”（检索链）、“MemoryStore”（记忆存储）等关键概念，从而显著提升了 AI 工程师之间的沟通效率与协作一致性。

# The integration problem

# 集成难题

A discernible gap, still resides in the current tooling designed to facilitate integrations with LLM providers. As newer and improved models are introduced and the technology progresses, engineers want the freedom to be able to quickly implement new features with these models.

当前面向大语言模型服务商的集成工具链中，仍存在一个明显缺口。随着更新、更优模型的不断涌现与技术持续演进，工程师迫切需要一种自由度更高的能力——能够快速利用这些新模型实现新功能。

LangChain provides classes for a huge amount of models, such as OpenAI and Hugging Face, based on a common LLM class. However it requires using different classes for each provider. These classes have various methods and properties and although you would hope they are directly plug and play, the actual solution is rarely that simple.

LangChain 基于一个通用的 LLM 类，为大量模型（如 OpenAI 和 Hugging Face）提供了对应的封装类。然而，它要求为每个服务商使用不同的类。这些类各自拥有不同的方法和属性；尽管我们期望它们能即插即用，但现实中的解决方案往往远非如此简单。

Factors such as model streaming and nested chains further complicate the problem. LangChain does a great job at building interoperability between composable pieces (e.g. VectorStores, DocumentLoaders & Retrievers) but we need to improve the developer experience when it comes to switching between LLM models.

模型流式响应（streaming）与嵌套链（nested chains）等因素进一步加剧了这一问题。LangChain 在构建可组合组件（例如 VectorStore、DocumentLoader 和 Retriever）之间的互操作性方面表现出色，但在切换不同大语言模型（LLM）时，开发者体验仍有待提升。

# Genoss is the solution

# Genoss：问题的解决方案

Genoss is a model gateway powered by LangChain. It standardises the process of calling any supported LLM into one unified interface, compatible with the OpenAI API specification. By simply changing your base URL to your Genoss endpoint, you have the power of any LLM model at your fingertips. Direct integration with any 3rd party tool that supports the OpenAI interface is enabled out of the box.

Genoss 是一个由 LangChain 驱动的模型网关。它将调用任意受支持 LLM 的流程标准化为统一接口，并完全兼容 OpenAI API 规范。只需将你的基础 URL 切换为 Genoss 的端点地址，即可随时调用任一 LLM 模型。任何原生支持 OpenAI 接口的第三方工具均可开箱即用地与 Genoss 直接集成。

Genoss does the heavy lifting for you to provide a single cohesive interface for interacting with both Completions and Embeddings models across multiple providers. You can switch between local open-source models, OpenAI models, AWS Bedrock models or any Hugging Face model with just a simple change to the model name.

Genoss 替你承担了繁重的底层工作，为你提供了一个统一、连贯的接口，用于与来自多个服务商的文本生成（Completions）和向量嵌入（Embeddings）模型进行交互。你只需简单修改模型名称，即可在本地开源模型、OpenAI 模型、AWS Bedrock 模型或任意 Hugging Face 模型之间自由切换。

![](images/unifying-ai-endpoints-with-genoss-powered-by-langchain/img_002.png)[https://genoss.ai/](https://genoss.ai/?ref=blog.langchain.com)

![](images/unifying-ai-endpoints-with-genoss-powered-by-langchain/img_002.png)[https://genoss.ai/](https://genoss.ai/?ref=blog.langchain.com)

When using Genoss in an enterprise setting, an admin can update the model with a singular change on the dashboard ( _coming soon)_. There is no need to update any application code to point towards new providers, the mapping is handled entirely by Genoss. This is useful for applications which use different models for different tasks or even users tiers. Paid users of your application could be given access to a choice of models with varying benefits such as enhanced privacy or fine-tuning using specific knowledge, whereas demo users would use a generic and cheaper model.

在企业级部署场景中，管理员仅需在管理控制台（*即将上线*）中做一次配置变更，即可完成模型更新。无需修改任何应用代码来适配新的模型服务商——所有模型映射均由 Genoss 全权处理。该能力特别适用于需为不同任务甚至不同用户等级分配不同模型的应用场景。例如，付费用户可被授予多种模型选择权，以获得差异化优势（如更强的数据隐私保障，或基于特定领域知识的微调能力）；而演示用户则可默认使用通用且成本更低的基础模型。

# Usage in production

# 生产环境中的使用

Genoss is open-source and is free to use via the hosted version or to self-host on your own infrastructure. Think of Genoss like [Supabase](https://supabase.com/?ref=blog.langchain.com) for LLM applications. It empowers developers to go from a weekend side-project straight to production using the same infrastructure and tech stack.

Genoss 是一款开源工具，既可通过其托管版本免费使用，也可部署在你自己的基础设施上。你可以将 Genoss 视为面向大语言模型（LLM）应用的 [Supabase](https://supabase.com/?ref=blog.langchain.com) —— 它赋能开发者，让一个周末启动的原型项目，能够直接复用相同的基础设施与技术栈，无缝跃迁至生产环境。

Genoss leverages LangChain’s new tool, LangSmith. LangSmith provides observability, debugging and testing on the inputs and outputs of the models at each stage of the workflow. Analytics of LLM calls can be performed to help improve the usage and effectiveness of the model and the prompts. This allows companies to run LLM based workflows in production with higher confidence in their models and their outputs than ever before.

Genoss 深度集成了 LangChain 的全新工具 LangSmith。LangSmith 提供全流程可观测性、调试与测试能力，覆盖工作流各阶段中模型的输入与输出。通过对 LLM 调用行为的数据分析，可有效优化模型使用效率与提示词（prompt）效果。这使得企业得以以前所未有的信心，在生产环境中稳定运行基于 LLM 的各类工作流，并对其模型表现与输出质量保持高度可控。

When using Genoss as your model gateway, LangSmith is automatically setup and ready to use. Companies can also use LangSmith to track token usage, manage costs of their LLM calls and keep an eye on latencies directly from the Genoss console.

当使用 Genoss 作为您的模型网关时，LangSmith 将自动完成配置并立即可用。企业还可借助 LangSmith 直接从 Genoss 控制台追踪 Token 使用量、管理大语言模型（LLM）调用成本，并实时监控响应延迟。

# Conclusion

# 结论

The lack of consistency between model interfaces makes building with LLMs unnecessary complicated. As cloud providers, commercial and open-source models are not aligned on a standard interface, Genoss provides interface unification. Genoss reduces the learning curve for developers starting to build, and for organisations scaling applications harnessing the power of Generative AI.

模型接口之间缺乏一致性，使得基于大语言模型（LLM）的开发变得毫无必要地复杂。由于云服务提供商、商业模型与开源模型尚未就统一标准接口达成一致，Genoss 提供了接口层的统一方案。Genoss 降低了开发者初次上手构建应用的学习门槛，也助力企业在规模化部署生成式 AI 应用时提升效率。

Given the rapid pace of LLM advancements, developers will use Genoss to test the latest models, experiment with fine-tuning and run private models locally. Enterprises will use Genoss to control the model usage of their users in both internal and production apps whilst utilising LangSmith for observability, debugging and testing.

鉴于大语言模型技术日新月异的发展速度，开发者将借助 Genoss 快速试用最新模型、开展微调实验，并在本地运行私有模型；企业则可通过 Genoss 统一管控用户在内部系统及生产环境应用中对模型的调用行为，同时结合 LangSmith 实现可观测性、调试与测试能力。

**Find the code repository for Genoss** [**here**](https://github.com/OpenGenenerativeAI/GenossGPT?ref=blog.langchain.com) **. We look forward to seeing what you will build with it.**

**欢迎访问 Genoss 的代码仓库** [**此处**](https://github.com/OpenGenenerativeAI/GenossGPT?ref=blog.langchain.com) **。我们热切期待您用它构建出的精彩应用！**

**Thanks to the team** [**Stan Girard**](https://twitter.com/_StanGirard?ref=blog.langchain.com) **,** [**Maxime Thoosen**](https://twitter.com/maxthoon?ref=blog.langchain.com) **,** [**Arnault Chazareix**](https://twitter.com/Arnault_Chaz?ref=blog.langchain.com) **for all your hard work.**

**衷心感谢以下团队成员的辛勤付出：** [**Stan Girard**](https://twitter.com/_StanGirard?ref=blog.langchain.com) **、** [**Maxime Thoosen**](https://twitter.com/maxthoon?ref=blog.langchain.com) **、** [**Arnault Chazareix**](https://twitter.com/Arnault_Chaz?ref=blog.langchain.com) **。**

### Tags

### 标签

[![NeumAI x LangChain: Efficiently maintaining context in sync for AI applications](images/unifying-ai-endpoints-with-genoss-powered-by-langchain/img_003.png)](https://blog.langchain.com/neum-x-langchain/)

[![NeumAI × LangChain：面向 AI 应用高效同步维护上下文](images/unifying-ai-endpoints-with-genoss-powered-by-langchain/img_003.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain: Efficiently maintaining context in sync for AI applications**](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI × LangChain：面向 AI 应用高效同步维护上下文**](https://blog.langchain.com/neum-x-langchain/)

[![Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination](images/unifying-ai-endpoints-with-genoss-powered-by-langchain/img_004.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**让数据摄取具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)


[![Chat with your data using OpenAI, Pinecone, Airbyte and Langchain](images/unifying-ai-endpoints-with-genoss-powered-by-langchain/img_005.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**Chat with your data using OpenAI, Pinecone, Airbyte and Langchain**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)


[**Yeager.ai x LangChain: Exploring GenWorlds a Framework for Coordinating AI Agents**](https://blog.langchain.com/exploring-genworlds/)

[**Yeager.ai × LangChain：探索 GenWorlds —— 一个用于协调 AI 智能体的框架**](https://blog.langchain.com/exploring-genworlds/)


[![Conversational Retrieval Agents](https://images.unsplash.com/photo-1625794084867-8ddd239946b1?crop=entropy&cs=tinysrgb&fit=max&fm=webp&ixid=M3wxMTc3M3wwfDF8c2VhcmNofDZ8fGdvbGRlbiUyMHJldHJpZXZlcnxlbnwwfHx8fDE2OTEwNDEwOTl8MA&ixlib=rb-4.0.3&q=80&w=760)](https://blog.langchain.com/conversational-retrieval-agents/)

[**Conversational Retrieval Agents**](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体**](https://blog.langchain.com/conversational-retrieval-agents/)


[![LangChain Expression Language](images/unifying-ai-endpoints-with-genoss-powered-by-langchain/img_007.jpg)](https://blog.langchain.com/langchain-expression-language/)

[**LangChain Expression Language**](https://blog.langchain.com/langchain-expression-language/)

[**LangChain 表达式语言（LCEL）**](https://blog.langchain.com/langchain-expression-language/)
{% endraw %}
