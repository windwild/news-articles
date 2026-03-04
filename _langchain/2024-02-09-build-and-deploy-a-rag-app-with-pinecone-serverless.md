---
title: "Build and deploy a RAG app with Pinecone Serverless"
source: "LangChain Blog"
url: "https://blog.langchain.com/pinecone-serverless/"
date: "2024-02-09"
scraped_at: "2026-03-03T08:15:03.511762954+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
{% raw %}

## Key Links

## 关键链接

- Repo: [https://github.com/langchain-ai/pinecone-serverless](https://github.com/langchain-ai/pinecone-serverless?ref=blog.langchain.com)  
- 代码仓库：[https://github.com/langchain-ai/pinecone-serverless](https://github.com/langchain-ai/pinecone-serverless?ref=blog.langchain.com)

- Video: [https://youtu.be/EhlPDL4QrWY](https://youtu.be/EhlPDL4QrWY?ref=blog.langchain.com)  
- 视频教程：[https://youtu.be/EhlPDL4QrWY](https://youtu.be/EhlPDL4QrWY?ref=blog.langchain.com)

## Context

## 上下文背景

LLMs are unlocking a new era of generative AI applications, becoming the kernel process of [a new kind of operating system](https://www.youtube.com/watch?v=zjkBMFhNj_g&ref=blog.langchain.com). Just as modern computers have RAM and file access, LLMs have a context window that can be loaded with information retrieved from external data sources, such as databases or vectorstores.

大语言模型（LLM）正在开启生成式 AI 应用的新时代，正逐步成为一种[新型操作系统](https://www.youtube.com/watch?v=zjkBMFhNj_g&ref=blog.langchain.com)的核心处理机制。正如现代计算机依赖内存（RAM）和文件系统访问数据，LLM 也依赖一个“上下文窗口”（context window），该窗口可加载来自外部数据源（如数据库或向量数据库）检索出的信息。

![](https://lh7-us.googleusercontent.com/0K4VgnGcsvdoQFHavgK24FCGRgxt4_1MnIcd3Vd269yhCSCjW5MgRm5nr2Img_3NjYnyPVJsszX_NKfdNV4w6rhUYoxclyjrM4kLSxrbcQCCp_L3-o7s5mwk3DvLbD6qeZN_WTWZ0jJe0zKQtgdIjEc)

Retrieved information can be loaded into the context window and used in LLM output generation, a process called [retrieval augmented generation](https://arxiv.org/pdf/2312.10997.pdf?ref=blog.langchain.com) (RAG). RAG is [a central concept in LLM app development](https://arxiv.org/abs/2312.10997?ref=blog.langchain.com) because it can reduce hallucinations by grounding output and adds context that is not present the training data.

检索到的信息可被载入上下文窗口，并用于 LLM 的输出生成过程——这一范式称为[检索增强生成](https://arxiv.org/pdf/2312.10997.pdf?ref=blog.langchain.com)（Retrieval Augmented Generation, RAG）。RAG 是[大语言模型应用开发中的核心概念](https://arxiv.org/abs/2312.10997?ref=blog.langchain.com)，因为它能通过将输出“锚定”于真实数据来减少幻觉（hallucination），并补充训练数据中所不具备的上下文信息。

## Challenges with production

## 生产环境中的挑战

With these points in mind, vectorstores have gained considerable popularity in production RAG applications because they offer a good way to store and retrieve relevant context. In particular, [semantic similarity search](https://www.pinecone.io/learn/what-is-similarity-search/?ref=blog.langchain.com) is commonly used to retrieve chunks of information that are relevant to a user-provided input.

基于上述背景，向量数据库（vectorstore）在生产级 RAG 应用中广受欢迎，因其为存储与检索相关上下文提供了高效可靠的方案。其中，[语义相似性搜索](https://www.pinecone.io/learn/what-is-similarity-search/?ref=blog.langchain.com)被广泛用于检索与用户输入高度相关的文本片段。

A large number of RAG demos have been shared over the past months, often using tools such as Jupyter notebooks and local vectorstores. Yet, several pain points create a gap between these demos and production RAG applications. Below, we'll discuss several ways to overcome these gaps and provide both a repo and a hands-on video that builds a production RAG application from scratch.

过去数月间，大量 RAG 演示案例被公开分享，多数采用 Jupyter Notebook 和本地向量数据库等轻量级工具。然而，若干现实痛点导致这些演示与真正可投入生产的 RAG 应用之间存在显著鸿沟。下文我们将探讨弥合这些差距的多种路径，并同步提供一个完整代码仓库及实操视频，手把手带你从零构建一个生产就绪的 RAG 应用。

|     |     |     |
| --- | --- | --- |
| Pain Point | Detail | Solutions |
| 痛点 | 具体问题描述 | 解决方案 |
| Hosted vectorstore management | Usage-based-pricing and unlimited scalability | Pinecone serverless |
| 托管式向量数据库管理 | 按用量计费 + 无限弹性扩展能力 | Pinecone Serverless |
| Rapid RAG application deployment | Rapid deployment of prototype RAG applications | Hosted LangServe |
| RAG 应用快速部署 | 原型 RAG 应用的敏捷上线能力 | 托管版 LangServe |
| RAG observability | Seamless observability of the RAG application | LangSmith |
| RAG 可观测性 | RAG 应用全链路、无侵入的可观测能力 | LangSmith |

## Support for production

## 生产环境支持

### Pinecone Serverless

### Pinecone Serverless

[Pinecone](https://www.pinecone.io/?ref=blog.langchain.com) 是 LangChain 向量数据库（vectorstore）集成中最受欢迎的[合作伙伴](https://integrations.langchain.com/vectorstores?ref=blog.langchain.com)之一，因其托管支持能力而被广泛应用于生产环境。然而，我们从社区中听到了至少两个痛点：（1）用户需自行配置 Pinecone 索引；（2）无论实际使用量如何，均需按月支付固定费用。Pinecone Serverless 的发布正是为了解决这两大挑战——它通过云对象存储（例如 Amazon S3 或 Google Cloud Storage）提供“无限”索引容量，并显著降低服务成本（实现按用量付费）。

### LangServe

### LangServe

尽管 LangChain 已成为快速构建 RAG 应用原型的热门工具，但我们意识到，仍有空间支持将任意链（chain）快速部署为适用于生产环境的 Web 服务。这一需求催生了 [LangServe](https://blog.langchain.com/introducing-langserve/)。任何基于 [LCEL](https://python.langchain.com/docs/expression_language/?ref=blog.langchain.com) 构建的链都具备统一的可运行（runnable）接口，并支持一组标准化的调用方法（例如 `batch`、`stream`）。借助 LangServe，这些方法被自动映射为 Web 服务中的 HTTP 接口，且可通过托管版 LangServe（Hosted LangServe）进行统一管理。

### LangSmith

### LangSmith

[LangSmith](https://blog.langchain.com/announcing-langsmith/) 是一个面向大语言模型（LLM）可观测性的平台，与 LangServe 深度集成、无缝协同。我们可以使用 LCEL 构建一条连接 Pinecone Serverless 的 RAG 链，再通过 LangServe 将其封装为 Web 服务，并利用托管版 LangServe 完成部署；最后，借助 LangSmith 对该服务的输入与输出进行实时监控与分析。

## Example Application

## 示例应用

To show how all these pieces come together, we provide a [template repo](https://github.com/langchain-ai/pinecone-serverless?ref=blog.langchain.com).

为展示上述各项技术如何协同工作，我们提供了一个 [模板代码仓库](https://github.com/langchain-ai/pinecone-serverless?ref=blog.langchain.com)。

- It shows how to connect a Pinecone Serverless index to a RAG chain in LangChain, which includes Cohere embeddings for similarity search on the index as well as GPT-4 for answer synthesis based upon the retrieved chunks.

- 该模板展示了如何在 LangChain 中将 Pinecone Serverless 索引接入 RAG 链：包括使用 Cohere 嵌入向量在索引中执行相似性搜索，以及调用 GPT-4 基于检索到的文本片段生成最终答案。

- It shows how to convert the RAG chain into a web service with Langserve. With LangServe, the chain can then be deployed using hosted LangServe.

- 该模板还展示了如何借助 LangServe 将 RAG 链转换为 Web 服务，并通过托管版 LangServe 实现一键部署。

![](https://lh7-us.googleusercontent.com/Wg10uA_JauFp2xyN1NFEXA-a-daFk1i1p8XYFteOwM0MoPanSK2ogRUEmkfs9JelOlQkUXIJpHZPCZmADanPdyjUDapRKi3TCLbwYVZZTUshxpCoFSKcekkgIqd2WpM2K8HLpKJwkc-j0a1xNXF6lXE)

## Conclusion

## 结论

We see demand for tools that bridge the gap between prototyping and production. With usage based pricing and support for unlimited scaling, Pinecone Serverless helps to address pain points with vectorstore productionization that we've seen from the community. Pinecone Serverless pairs well with LCEL, Hosted LangServe, and LangSmith to support easly deployment of RAG applications.

我们观察到，社区对能够弥合原型开发与生产部署之间差距的工具存在明确需求。Pinecone Serverless 采用按用量计费模式，并支持无限弹性伸缩，有效解决了社区在向量数据库（vectorstore）生产化过程中所遇到的诸多痛点。Pinecone Serverless 与 LCEL、托管版 LangServe 及 LangSmith 协同配合，可轻松支持 RAG 应用的端到端部署。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/build-and-deploy-a-rag-app-with-pinecone-serverless/img_003.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/build-and-deploy-a-rag-app-with-pinecone-serverless/img_003.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/build-and-deploy-a-rag-app-with-pinecone-serverless/img_004.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中推出端到端 OpenTelemetry 支持](images/build-and-deploy-a-rag-app-with-pinecone-serverless/img_004.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中推出端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/build-and-deploy-a-rag-app-with-pinecone-serverless/img_005.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/build-and-deploy-a-rag-app-with-pinecone-serverless/img_005.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/build-and-deploy-a-rag-app-with-pinecone-serverless/img_006.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/build-and-deploy-a-rag-app-with-pinecone-serverless/img_006.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/build-and-deploy-a-rag-app-with-pinecone-serverless/img_007.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![借助 LangSmith SDK v0.2 实现更便捷的评估](images/build-and-deploy-a-rag-app-with-pinecone-serverless/img_007.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**借助 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/build-and-deploy-a-rag-app-with-pinecone-serverless/img_008.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项](images/build-and-deploy-a-rag-app-with-pinecone-serverless/img_008.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)
{% endraw %}
