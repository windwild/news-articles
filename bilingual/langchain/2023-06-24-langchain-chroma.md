---
title: "LangChain + Chroma"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-chroma/"
date: "2023-06-24"
scraped_at: "2026-03-03T09:42:00.182711038+00:00"
language: "en-zh"
translated: true
---

Today we’re announcing LangChain's integration with Chroma, the first step on the path to the Modern A.I Stack.

今天我们宣布 LangChain 与 Chroma 的集成，这是迈向现代人工智能技术栈的第一步。

### LangChain - The A.I-native developer toolkit

### LangChain — 面向人工智能原生开发者的工具包

We started LangChain with the intent to build a modular and flexible framework for developing A.I-native applications. Some of the use cases which immediately jumped to mind are [chat bots](https://python.langchain.com/docs/use_cases/chatbots/?ref=blog.langchain.com), [question answering](https://python.langchain.com/docs/use_cases/question_answering/?ref=blog.langchain.com) services, and [agents](https://python.langchain.com/docs/use_cases/agents/?ref=blog.langchain.com). Thousands of developers are now hacking, tinkering, and building all kinds of LLM-powered applications using LangChain’s flexible, easy to use framework.

我们创建 LangChain 的初衷，是构建一个模块化、高灵活性的框架，用于开发人工智能原生（A.I-native）应用。最初浮现在我们脑海中的典型应用场景包括：[聊天机器人](https://python.langchain.com/docs/use_cases/chatbots/?ref=blog.langchain.com)、[问答系统](https://python.langchain.com/docs/use_cases/question_answering/?ref=blog.langchain.com)服务，以及[智能体（Agents）](https://python.langchain.com/docs/use_cases/agents/?ref=blog.langchain.com)。如今，已有数千名开发者正借助 LangChain 灵活且易于上手的框架，进行实验、调试，并构建各类大语言模型（LLM）驱动的应用。

One of the key components of those of applications is embeddings, and vector stores to hold and work with those embeddings.

这些应用的关键组件之一是嵌入向量（embeddings），以及用于存储和操作这些嵌入向量的向量数据库（vector stores）。

One pain point that we noticed with a lot of existing vector stores is they often involved connecting to an external server that stored the embeddings. While that is fine for putting applications into production, it does make it a bit tricky to easily prototype applications locally.

我们在许多现有向量数据库中观察到的一个痛点是：它们通常需要连接至一个托管嵌入向量的外部服务器。这种方式虽适用于生产环境部署，但在本地快速构建和验证应用原型时却略显繁琐。

The best solution we had for local vector stores was using FAISS, which many community members noted had some tricky dependencies that caused installation issues.

此前，我们针对本地向量存储的最佳解决方案是使用 FAISS；但不少社区成员指出，FAISS 存在一些棘手的依赖关系，容易导致安装失败。

### [Chroma](https://www.trychroma.com/?ref=blog.langchain.com) \- The A.I-native vector store

### [Chroma](https://www.trychroma.com/?ref=blog.langchain.com) — 面向人工智能原生的向量数据库

Chroma was founded to build tools which leverage the power of embeddings. Embeddings are the A.I-native way to represent any kind of data, making them the perfect fit for working with all kinds of A.I-powered tools and algorithms.

Chroma 创立的使命，是打造能充分发挥嵌入向量（embeddings）能力的工具。嵌入向量是人工智能原生的数据表征方式，因而天然适配各类人工智能驱动的工具与算法。

While exploring the possibilities of model embeddings at Chroma, the Chroma team needed an easy to use, performant, and lightweight vector store which could handle modern A.I workloads.

在 Chroma 探索模型嵌入向量潜力的过程中，团队亟需一种易用、高性能且轻量级的向量数据库，以应对现代人工智能工作负载。

While there are already several vector database solutions, they found that these were mostly geared to other use-cases and access patterns, like large-scale semantic search. Additionally, they were often a hassle to set up and run, especially in a development environment.

尽管目前已存在多种向量数据库方案，但 Chroma 团队发现，这些方案大多面向其他应用场景与访问模式（例如大规模语义搜索），且往往部署与运行复杂——尤其在开发环境中，这一问题尤为突出。

In short, the Chroma team didn’t find what we needed, **so Chroma built it.**

简而言之，Chroma 团队未能找到我们所需的技术方案，**因此 Chroma 自己动手构建了它。**

Chroma is a vector store and embeddings database designed from the ground-up to make it easy to build AI applications with embeddings. It comes with [everything you need to get started built in](https://docs.trychroma.com/getting-started?ref=blog.langchain.com), and runs on your machine - just `pip install chromadb`!

Chroma 是一款从零开始设计的向量数据库与嵌入（embeddings）存储系统，旨在让开发者轻松基于嵌入技术构建 AI 应用。它内置了[上手所需的一切功能](https://docs.trychroma.com/getting-started?ref=blog.langchain.com)，且可直接在本地机器运行——只需执行 `pip install chromadb`！

### LangChain and Chroma

### LangChain 与 Chroma

Working together, with our mutual focus on flexibility and ease of use, we found that LangChain and Chroma were a perfect fit.

双方秉持对灵活性与易用性的共同追求，在协作过程中发现 LangChain 与 Chroma 完美契合。

Specifically, LangChain provides a framework to easily prototype LLM applications locally, and Chroma provides a vector store and embedding database that can run seamlessly during local development to power these applications.

具体而言，LangChain 提供了一套框架，便于在本地快速原型化大语言模型（LLM）应用；而 Chroma 则提供了一个向量数据库与嵌入存储系统，可在本地开发过程中无缝运行，为这些应用提供底层支撑。

Today, we are announcing Chroma’s integration with LangChain. Chroma aims to be the first, easiest, and best choice for most developers building LLM apps with LangChain. It’s ready to use today! Just get the latest version of LangChain, and `from langchain.vectorstores import Chroma` and you're good to go!

今天，我们正式宣布 Chroma 与 LangChain 的深度集成。Chroma 致力于成为绝大多数使用 LangChain 构建 LLM 应用的开发者的首选——它开箱即用、上手最快、体验最佳！现在即可开始使用：只需安装最新版 LangChain，然后执行 `from langchain.vectorstores import Chroma`，一切就绪！

To help get started, we put together an [example GitHub repo](https://github.com/hwchase17/chroma-langchain?ref=blog.langchain.com) for you to play around with.

为帮助您快速上手，我们专门准备了一个 [示例 GitHub 仓库](https://github.com/hwchase17/chroma-langchain?ref=blog.langchain.com)，欢迎试用与探索！

### The Future

### 未来展望

The launch of StableDiffusion and ChatGPT sparked an explosion of A.I creativity. Today, thousands of people around the world are working on discovering and unlocking the full power of A.I. At the same time, A.I research continues at a blistering pace. More kinds of data, more ways to interact with A.I, and more insights about how the models work, are being invented every day.

Stable Diffusion 与 ChatGPT 的发布，引爆了人工智能领域的创造力浪潮。如今，全球成千上万的研究者与开发者正致力于探索并释放人工智能的全部潜能。与此同时，AI 研究正以惊人的速度持续推进：每天都有新型数据形态、更多人机交互方式，以及关于模型工作原理的更深层洞见被不断提出与验证。

There’s no doubt this is a transformative era, not just in how we build software, but in what’s possible. LangChain and Chroma will remain on the forefront.

毫无疑问，这正处在一个变革性时代——其影响不仅在于我们如何构建软件，更在于人类所能实现的边界本身。LangChain 与 Chroma 将始终站在这一浪潮的最前沿。

### Tags

### 标签

[![NeumAI x LangChain: Efficiently maintaining context in sync for AI applications](https://blog.langchain.com/content/images/size/w760/format/webp/2023/08/5-social--19.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain：面向 AI 应用的上下文高效同步维护**](https://blog.langchain.com/neum-x-langchain/)

[![Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination](https://blog.langchain.com/content/images/size/w760/format/webp/2023/08/5-social--18.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**让数据接入具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[![Chat with your data using OpenAI, Pinecone, Airbyte and Langchain](https://blog.langchain.com/content/images/size/w760/format/webp/2023/08/image20.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**Yeager.ai x LangChain：探索 GenWorlds——一种协调 AI 智能体的框架**](https://blog.langchain.com/exploring-genworlds/)

[![Conversational Retrieval Agents](https://images.unsplash.com/photo-1625794084867-8ddd239946b1?crop=entropy&cs=tinysrgb&fit=max&fm=webp&ixid=M3wxMTc3M3wwfDF8c2VhcmNofDZ8fGdvbGRlbiUyMHJldHJpZXZlcnxlbnwwfHx8fDE2OTEwNDEwOTl8MA&ixlib=rb-4.0.3&q=80&w=760)](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体（Conversational Retrieval Agents）**](https://blog.langchain.com/conversational-retrieval-agents/)

[**Conversational Retrieval Agents**](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体**](https://blog.langchain.com/conversational-retrieval-agents/)

[**Unifying AI endpoints with Genoss, powered by LangChain**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)

[**借助 LangChain，使用 Genoss 统一 AI 接口**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)