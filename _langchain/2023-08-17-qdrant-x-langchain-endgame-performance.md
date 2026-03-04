---
render_with_liquid: false
title: "Qdrant x LangChain: Endgame Performance"
source: "LangChain Blog"
url: "https://blog.langchain.com/qdrant-x-langchain-endgame-performance/"
date: "2023-08-17"
scraped_at: "2026-03-03T09:14:32.225532809+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

_Editor's Note: This post was written by the [Qdrant](https://qdrant.tech/?ref=blog.langchain.com) team and cross-posted from their blog. As more LLM applications move into production, speed, stability and costs are going to become even more important features of the LLM tech stack. And, as more LLM applications take advantage of RAG (and longterm memory), this becomes even more of a challenge. We're really excited about what Qdrant is doing to help with that–their async support is particularly helpful!_

_编辑注：本文由 [Qdrant](https://qdrant.tech/?ref=blog.langchain.com) 团队撰写，并同步发布于其官方博客。随着越来越多的大语言模型（LLM）应用进入生产环境，速度、稳定性与成本将成为 LLM 技术栈中愈发关键的特性；而当更多 LLM 应用采用检索增强生成（RAG）及长期记忆机制时，这一挑战将进一步加剧。我们非常看好 Qdrant 在此方面所做出的努力——其异步（async）支持能力尤为突出！_

LangChain currently supports 40+ vector stores, each offering their own features and capabilities. When it comes to crafting a prototype, some truly stellar options are at your disposal. However, while some may outshine others in terms of performance and suitability, selecting the best option for your application’s production scenario requires careful consideration.

LangChain 目前已支持 40 多种向量数据库，每种均具备各自独特的功能与能力。在构建原型阶段，您手头已有若干极为出色的选项可供选择。然而，尽管某些向量数据库在性能或适用性方面可能更胜一筹，但要为您的应用选定最适合生产环境的方案，仍需审慎评估与权衡。

If you are looking to scale up and keep the same level of performance, Qdrant and LangChain are a rock-solid combination. [Getting started with both is a breeze](https://www.youtube.com/watch?v=VL6MAAgwSDM&ref=blog.langchain.com) and the [documentation](https://python.langchain.com/docs/integrations/vectorstores/qdrant.html?ref=blog.langchain.com) covers a broad number of cases. However, the main strength of Qdrant is that it can consistently support the user way past the prototyping and launch phases. For example, you only need a maximum of 18GB RAM, and a minimum of 2GB to support 1 million OpenAI Vectors! This makes Qdrant the best vector store for maximizing resource usage and data connection.

若您希望实现规模化扩展并维持同等性能水平，Qdrant 与 LangChain 的组合堪称坚如磐石。[二者上手极其简单](https://www.youtube.com/watch?v=VL6MAAgwSDM&ref=blog.langchain.com)，且 [官方文档](https://python.langchain.com/docs/integrations/vectorstores/qdrant.html?ref=blog.langchain.com) 覆盖了大量典型应用场景。不过，Qdrant 的核心优势在于：它能持续稳定地支撑用户跨越原型开发与上线发布阶段，直至大规模生产部署。例如，仅需最多 18 GB 内存、最低仅需 2 GB，即可高效支持 100 万个 OpenAI 向量！这使得 Qdrant 成为资源利用率最高、数据接入最高效的向量数据库。

At its core, Qdrant vector database excels at semantic search. When supported by LangChain, Qdrant can help you set up effective [QA systems](https://github.com/openai/openai-cookbook/blob/main/examples/vector_databases/qdrant/QA_with_Langchain_Qdrant_and_OpenAI.ipynb?ref=blog.langchain.com), detection systems and chatbots that leverage [Retrieval Augmented Generation](https://arxiv.org/abs/2005.11401?ref=blog.langchain.com) (RAG) to its full potential. Qdrant streamlines the process of retrieval augmentation, making it faster, easier to scale and efficient. Adding relevant context to LLMs can vastly improve user experience especially in most business cases, where LLMs haven’t accessed such data before. Vector search is better at sorting through relevant context, when the available data is vast, at times in hundreds or thousands of documents.

本质上，Qdrant 向量数据库专精于语义搜索。在 LangChain 的协同支持下，Qdrant 可助您快速搭建高性能的 [问答系统（QA systems）](https://github.com/openai/openai-cookbook/blob/main/examples/vector_databases/qdrant/QA_with_Langchain_Qdrant_and_OpenAI.ipynb?ref=blog.langchain.com)、检测系统及聊天机器人，充分释放 [检索增强生成（Retrieval Augmented Generation, RAG）](https://arxiv.org/abs/2005.11401?ref=blog.langchain.com) 的全部潜力。Qdrant 极大简化了检索增强流程，使其更快速、更易扩展、也更高效。为大语言模型注入相关上下文，可显著提升用户体验——尤其在多数商业场景中，LLM 往往此前从未接触过此类数据。当可用数据规模庞大（有时达数百甚至数千份文档）时，向量搜索在筛选相关上下文方面，远优于传统方法。

## **How Does Qdrant Work With LangChain?**

## **Qdrant 如何与 LangChain 协同工作？**

Qdrant vector database functions as long-term memory for AI models. As a vector store, it manages the efficient storage and retrieval of vectors, which represent user data.

Qdrant 向量数据库充当 AI 模型的“长期记忆”。作为向量存储系统，它负责对代表用户数据的向量进行高效存储与检索。

In terms of RAG, LangChain receives a query, dispatches it to a vector database such as Qdrant, retrieves relevant documents, and then sends both the query and the retrieved documents into the large language model to generate an answer.

在 RAG 架构中，LangChain 接收用户查询，将其分发至 Qdrant 等向量数据库，检索出相关文档，再将原始查询与检索所得文档一并送入大语言模型，以生成最终答案。

![](https://blog.langchain.com/content/images/2023/08/image.png)

![](https://blog.langchain.com/content/images/2023/08/image.png)

Augmenting your AI application with retrieval systems reduces hallucinations, a situation where AI models produce legitimate-sounding but made-up responses.

为 AI 应用引入检索系统，有助于减少“幻觉”（hallucinations）现象——即 AI 模型生成看似合理实则虚构的响应。

When it comes to long-term memory storage for LLM applications, developers can easily add relevant documents, chat history memory & rich user data to LLM app prompts. Qdrant takes care of document and chat history storage, embedding, enrichment, and more.

在面向大语言模型应用的长期记忆存储场景中，开发者可轻松将相关文档、对话历史记录以及丰富的用户数据注入 LLM 应用的提示词（prompts）中。Qdrant 全面承担起文档与对话历史的存储、向量化嵌入（embedding）、内容增强（enrichment）等多重职责。

## **Optimizing Resource Use**

## **优化资源使用**

Retrieval Augmented Generation is not without its challenges and limitations. One of the main setbacks for app developers is managing the complexity of the model. The integration of a retriever and a generator into a single model can lead to a raised level of complexity, thus increasing the computational resources required.

检索增强生成（RAG）并非没有挑战与局限性。对应用开发者而言，主要难点之一在于管理模型的复杂性：将检索器（retriever）与生成器（generator）整合进单一模型，会显著提升系统复杂度，从而增加所需的计算资源。

Qdrant’s is completely optimized for performance and continually adds new features that reduce the computational load required to run your application. In particular, Qdrant is the only vector store offered by LangChain that supports asynchronous operations. [Qdrant supports full async API](https://python.langchain.com/docs/modules/data_connection/vectorstores/?ref=blog.langchain.com#asynchronous-operations) based on GRPC protocol.

Qdrant 在性能方面经过全面优化，并持续引入新功能以降低运行应用所需的计算负载。尤其值得一提的是，Qdrant 是 LangChain 所支持的向量数据库中，**唯一原生支持异步操作**的选项。[Qdrant 提供基于 gRPC 协议的完整异步 API](https://python.langchain.com/docs/modules/data_connection/vectorstores/?ref=blog.langchain.com#asynchronous-operations)。

This functionality is available with our [open source Qdrant](https://github.com/qdrant/qdrant?ref=blog.langchain.com) vector database as well as the [Qdrant Cloud](https://cloud.qdrant.io/?ref=blog.langchain.com) SaaS product. This causes performance benefits as applications maximize compute use and don't waste time waiting for responses from external services.

该功能同时适用于我们的 [开源 Qdrant 向量数据库](https://github.com/qdrant/qdrant?ref=blog.langchain.com) 和 [Qdrant Cloud](https://cloud.qdrant.io/?ref=blog.langchain.com) SaaS 服务。这带来了显著的性能优势：应用可充分压榨计算资源，避免因等待外部服务响应而空转耗时。

Vector stores run as separate services, which makes them I/O bound from the perspective of an LLM-based application. Using \`async\` lets you utilize the resources better, primarily if the LangChain is combined with an \`async\` framework, such as FastAPI. Using async API is easy - all the methods have their counterpart async definitions (similarity\_search -> asimilarity\_search, etc.). FastAPI describes [asynchronous operations](https://fastapi.tiangolo.com/async/?h=async&ref=blog.langchain.com#asynchronous-code) quite well in their documentation.

向量数据库作为独立服务运行，因此从大语言模型（LLM）应用的视角来看，其性能瓶颈通常在于 I/O。采用 `async`（异步）方式能更高效地利用系统资源——尤其当 LangChain 与 FastAPI 等异步框架协同使用时效果更佳。调用异步 API 极其简便：所有同步方法均有对应的异步版本（例如 `similarity_search` → `asimilarity_search` 等）。FastAPI 官方文档对 [异步操作](https://fastapi.tiangolo.com/async/?h=async&ref=blog.langchain.com#asynchronous-code) 做了非常清晰的说明。

![](https://blog.langchain.com/content/images/2023/08/image-3.png)

![](https://blog.langchain.com/content/images/2023/08/image-3.png)

The application doesn't wait for I/O operations and that pays off when applications interact with external systems, such as any database. In this way, compute power does not sit idle and is used to its fullest potential.

应用无需阻塞式等待 I/O 操作完成，这一特性在与数据库等外部系统交互时尤为关键。由此，计算能力不会闲置，而是被充分利用至极限。

The implementation of [io\_uring](https://qdrant.tech/articles/io_uring/?ref=blog.langchain.com) is a testament to Qdrant’s focus on performance and resource usage. One of the great optimizations Qdrant offers is quantization (either [scalar](https://qdrant.tech/articles/scalar-quantization/?ref=blog.langchain.com) or [product](https://qdrant.tech/articles/product-quantization/?ref=blog.langchain.com)-based). Uring complements these by mitigating the use of disk IO, via improved async throughput wherever the OS syscall overhead gets too high, which tends to occur in situations where software becomes IO bound.

[io_uring](https://qdrant.tech/articles/io_uring/?ref=blog.langchain.com) 的实现，印证了 Qdrant 对性能与资源效率的极致追求。Qdrant 提供的一项重要优化是量化（quantization）技术——包括 [标量量化（scalar quantization）](https://qdrant.tech/articles/scalar-quantization/?ref=blog.langchain.com) 和 [乘积量化（product quantization）](https://qdrant.tech/articles/product-quantization/?ref=blog.langchain.com)。而 io_uring 则进一步强化了这些优化：它通过提升异步吞吐能力，有效缓解磁盘 I/O 压力——尤其在操作系统系统调用（syscall）开销过高、软件趋于 I/O 瓶颈的场景下效果卓著。

## What is Your Endgame?

## 你的终极目标是什么？

The wise adage of "trying before buying" holds true in the realm of vector store selection. With numerous options available on LangChain, it's imperative to try whether this option fits your use case the best.

“先试后买”这一明智格言，在向量数据库选型领域同样适用。LangChain 提供了多种向量存储方案，因此务必亲自验证：Qdrant 是否真正契合你的具体应用场景？

The best way to get started is to sign up for our [Qdrant Cloud Free Tier](https://qdrant.to/cloud?ref=blog.langchain.com). Join the official [Discord community](https://qdrant.to/discord?ref=blog.langchain.com) for tech support and integration advice.

开始使用的最佳方式是注册我们的 [Qdrant Cloud 免费套餐](https://qdrant.to/cloud?ref=blog.langchain.com)。欢迎加入官方 [Discord 社区](https://qdrant.to/discord?ref=blog.langchain.com)，获取技术支持与集成建议。

_“We are all-in on performance and reliability. Every release we make Qdrant faster, more stable and cost-effective for the user. When others focus on prototyping, we are already ready for production. Very soon, our users will build successful products and go to market. At this point, I anticipate a great need for a reliable vector store. Qdrant is there for LangChain and the entire community.” ––David Myriel, Director of Product Education, Qdrant_

_“我们全力聚焦于性能与可靠性。每一次发布，我们都让 Qdrant 运行更快、更稳定，也更具成本效益。当其他厂商还在专注原型开发时，Qdrant 已为生产环境做好准备。很快，我们的用户将打造出成功的产品并推向市场。此时，我预见到市场对一个可靠向量数据库的迫切需求。Qdrant 将始终支持 LangChain 及整个开发者社区。”——David Myriel，Qdrant 产品教育总监_

## Relevant Links:

## 相关链接：

- Qdrant is open source and you can quickstart in [local mode](https://qdrant.tech/documentation/quick-start/?ref=blog.langchain.com), install it [via Docker](https://qdrant.tech/documentation/quick-start/?ref=blog.langchain.com), or to [Kubernetes](https://github.com/qdrant/qdrant-helm?ref=blog.langchain.com). SDKs are available for [Python](https://github.com/qdrant/qdrant-client?ref=blog.langchain.com), [TypeScript](https://github.com/qdrant/qdrant-js?ref=blog.langchain.com), [Rust](https://github.com/qdrant/rust-client?ref=blog.langchain.com) and [GoLang](https://github.com/qdrant/go-client?ref=blog.langchain.com).

- Qdrant 是开源项目，您可通过 [本地模式](https://qdrant.tech/documentation/quick-start/?ref=blog.langchain.com) 快速上手，也可通过 [Docker](https://qdrant.tech/documentation/quick-start/?ref=blog.langchain.com) 或 [Kubernetes](https://github.com/qdrant/qdrant-helm?ref=blog.langchain.com) 部署。官方提供 [Python](https://github.com/qdrant/qdrant-client?ref=blog.langchain.com)、[TypeScript](https://github.com/qdrant/qdrant-js?ref=blog.langchain.com)、[Rust](https://github.com/qdrant/rust-client?ref=blog.langchain.com) 和 [GoLang](https://github.com/qdrant/go-client?ref=blog.langchain.com) 的 SDK。

- A [free-tier of Qdrant Cloud](https://cloud.qdrant.io/?ref=blog.langchain.com) is also recommended for prototyping and testing.

- 我们同样推荐使用 [Qdrant Cloud 免费套餐](https://cloud.qdrant.io/?ref=blog.langchain.com) 进行原型开发与测试。

- For more info, check out the official [Qdrant documentation](https://qdrant.tech/documentation/integrations/langchain/?ref=blog.langchain.com).

- 如需更多信息，请查阅官方 [Qdrant 文档](https://qdrant.tech/documentation/integrations/langchain/?ref=blog.langchain.com)。

- For best integration with LangChain, check the official [LangChain documentation](https://python.langchain.com/docs/integrations/vectorstores/qdrant?ref=blog.langchain.com) as well as [LangChain’s API specification for the Qdrant vector store](https://api.python.langchain.com/en/latest/vectorstores/langchain.vectorstores.qdrant.Qdrant.html?ref=blog.langchain.com).

- 为实现与 LangChain 的最佳集成，请同时参考官方 [LangChain 文档](https://python.langchain.com/docs/integrations/vectorstores/qdrant?ref=blog.langchain.com)，以及 [LangChain 关于 Qdrant 向量数据库的 API 规范](https://api.python.langchain.com/en/latest/vectorstores/langchain.vectorstores.qdrant.Qdrant.html?ref=blog.langchain.com)。