---
render_with_liquid: false
title: "Retrieval"
source: "LangChain Blog"
url: "https://blog.langchain.com/retrieval/"
date: "2023-08-18"
scraped_at: "2026-03-03T08:58:26.641801542+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
render_with_liquid: false
render_with_liquid: false

TL;DR: We are adjusting our abstractions to make it easy for other retrieval methods besides the LangChain `VectorDB` object to be used in LangChain. This is done with the goals of (1) allowing retrievers [constructed elsewhere](https://github.com/openai/chatgpt-retrieval-plugin?ref=blog.langchain.com) to be used more easily in LangChain, (2) encouraging more experimentation with alternative retrieval methods (like [hybrid search](https://www.pinecone.io/learn/hybrid-search-intro/?ref=blog.langchain.com)). This is backwards compatible, so all existing chains should continue to work as before. However, we recommend updating from `VectorDB` chains to the new `Retrieval` chains as soon as possible, as those will be the ones most fully supported going forward.

TL;DR：我们正在调整抽象层，以便在 LangChain 中更便捷地支持除 LangChain `VectorDB` 对象之外的其他检索方法。此举旨在：（1）更轻松地将[在其他地方构建的检索器](https://github.com/openai/chatgpt-retrieval-plugin?ref=blog.langchain.com)集成到 LangChain 中；（2）鼓励对替代性检索方法（例如 [混合搜索（hybrid search）](https://www.pinecone.io/learn/hybrid-search-intro/?ref=blog.langchain.com)）开展更多实验。本次变更向后兼容，因此所有现有链（chains）将继续按原有方式正常运行。不过，我们建议尽快将 `VectorDB` 链迁移至新的 `Retrieval` 链，因为后者将成为未来获得最全面支持的实现方式。

[Python Docs](https://python.langchain.com/docs/modules/data_connection/retrievers/?ref=blog.langchain.com)

[Python 文档](https://python.langchain.com/docs/modules/data_connection/retrievers/?ref=blog.langchain.com)

[JS Docs](https://hwchase17.github.io/langchainjs/docs/modules/indexes/retrievers/vectorstore?ref=blog.langchain.com)

[JavaScript 文档](https://hwchase17.github.io/langchainjs/docs/modules/indexes/retrievers/vectorstore?ref=blog.langchain.com)

* * *

## Introduction

## 引言

Ever since ChatGPT came out, people have been building a personalized ChatGPT for their data. We even wrote [a tutorial on this](https://blog.langchain.com/tutorial-chatgpt-over-your-data/), and then [ran a competition](https://blog.langchain.com/chat-your-data-challenge/) about this a few months ago. The desire and demand for this highlights an important limitation of ChatGPT - it doesn't know about YOUR data, and most people would find it more useful if it did. So how do you go about building a chatbot that knows about your data?

自 ChatGPT 发布以来，人们一直在为其自有数据构建个性化的 ChatGPT。我们甚至为此撰写过[一篇教程](https://blog.langchain.com/tutorial-chatgpt-over-your-data/)，并在几个月前举办了[一场相关竞赛](https://blog.langchain.com/chat-your-data-challenge/)。“个性化 ChatGPT”的强烈需求凸显了 ChatGPT 的一个重要局限：它不了解**你的数据**；而对大多数人而言，若它能了解你的数据，其价值将显著提升。那么，如何构建一个“懂你数据”的聊天机器人呢？

The main way of doing this is through a process commonly referred to as "Retrieval Augmented Generation". In this process, rather than just passing a user question directly to a language model, the system "retrieves" any documents that could be relevant in answering the question, and then passes those documents (along with the original question) to the language model for a "generation" step.

实现这一目标的主要方式是采用一种通常称为“检索增强生成（Retrieval Augmented Generation，RAG）”的技术流程。在此流程中，系统并非直接将用户问题提交给语言模型，而是首先“检索”出所有可能有助于回答该问题的相关文档，再将这些文档（连同原始问题）一并送入语言模型，执行后续的“生成（generation）”步骤。

The main way most people - including us at LangChain - have been doing retrieval is by using semantic search. In this process, a numerical vector (an embedding) is calculated for all documents, and those vectors are then stored in a vector database (a database optimized for storing and querying vectors). Incoming queries are then vectorized as well, and the documents retrieved are those who are closest to the query in embedding space. We're not going to go into too much detail on that here - but [here](https://blog.langchain.com/tutorial-chatgpt-over-your-data/) is a more in depth tutorial on the topic, and below is a diagram which nicely summarizes this.

目前，绝大多数人（包括 LangChain 团队）所采用的主流检索方式是语义搜索（semantic search）。该方法为所有文档计算一个数值向量（即嵌入向量，embedding），并将这些向量存入向量数据库（vector database）——一种专为高效存储与查询向量而优化的数据库。当有新查询输入时，系统同样将其向量化，然后从向量空间中检索出与该查询向量距离最近的若干文档。此处我们不深入展开技术细节，但可参考[这篇更详尽的教程](https://blog.langchain.com/tutorial-chatgpt-over-your-data/)；下方图示则清晰概括了该过程。

![](https://blog.langchain.com/content/images/2023/03/image-1.png)Diagram of typical retrieval step

![](https://blog.langchain.com/content/images/2023/03/image-1.png)典型检索步骤示意图

## Problems

## 存在的问题

This process works pretty well, and a lot of the components and abstractions we've built (embeddings, vectorstores) are aimed at facilitating this process.

这一流程运行得相当良好，而我们构建的许多组件和抽象（如 embeddings、vectorstores）正是为了促进这一流程。

But we've noticed two problems.

但我们也注意到了两个问题。

**First:** there a lot of different variations in how you do this retrieval step. People want to do things beyond semantic search. To be concrete:

**第一：** 检索步骤存在大量不同的实现方式。用户的需求早已超越了单纯的语义搜索。具体而言：

- We support two different query methods: one that just optimizes similarity, another with optimizes for [maximal marginal relevance](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/~jgc/publication/the_use_mmr_diversity_based_ltmir_1998.pdf?ref=blog.langchain.com).

  我们支持两种不同的查询方法：一种仅优化相似度，另一种则优化[最大边际相关性（Maximal Marginal Relevance, MMR）](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/~jgc/publication/the_use_mmr_diversity_based_ltmir_1998.pdf?ref=blog.langchain.com)。

- Users often want to specify metadata filters to filter results before doing semantic search

  用户常常希望指定元数据过滤器，在执行语义搜索前对结果进行筛选。

- Other types of indexes, [like graphs](https://python.langchain.com/docs/modules/chains/additional/graph_qa?ref=blog.langchain.com), have piqued user's interests

  其他类型的索引（例如[图索引](https://python.langchain.com/docs/modules/chains/additional/graph_qa?ref=blog.langchain.com)）也引起了用户的浓厚兴趣。

**Second:** we also realized that people may construct a retriever outside of LangChain - for example OpenAI released their `ChatGPT Retrieval Plugin`. We want to make it as easy as possible for people to use whatever retriever they created within LangChain.

**第二：** 我们还意识到，用户可能在 LangChain 之外构建自己的检索器——例如 OpenAI 发布了其 `ChatGPT Retrieval Plugin`。我们希望尽可能简化流程，让用户能轻松地将自己创建的任意检索器集成进 LangChain 使用。

We realized we made a mistake - by making our abstractions centered around VectorDBQA we were limiting to use of our chains, making them hard to use (1) for users who wanted to experiment with other retrieval methods, (2) for users who created a retriever outside the LangChain ecosystem.

我们意识到此前犯了一个错误：将抽象设计围绕 `VectorDBQA` 展开，无形中限制了我们链式组件（chains）的适用范围，导致它们难以被以下两类用户使用：（1）希望尝试其他检索方法的用户；（2）在 LangChain 生态系统之外自行构建检索器的用户。

## Solution

## 解决方案

So how did we fix this?

那么，我们是如何解决这个问题的呢？

In our most recent Python and TypeScript releases, we've:

在我们最新发布的 Python 和 TypeScript 版本中，我们完成了以下改进：

1. Introduced the concept of a `Retriever`. Retrievers are expected to expose a `get_relevant_documents` method with the following signature: `def get_relevant_documents(self, query: str) -> List[Document]`. That's the only assumption we make about Retrievers. See more about this interface below.

   1. 引入了 `Retriever`（检索器）的概念。所有检索器均需暴露一个名为 `get_relevant_documents` 的方法，其函数签名如下：`def get_relevant_documents(self, query: str) -> List[Document]`。这是我们对检索器所作的唯一假设。有关该接口的更多细节，请参见下文。

2. Changed all our chains that used VectorDBs to now use Retrievers. `VectorDBQA` is now `RetrievalQA`, `ChatVectorDBChain` is now `ConversationalRetrievalChain`, etc. _Note that, moving forward, we are intentionally using the `Conversational` prefix to indicate that the chain is using memory and the `Chat` prefix to indicate the chain is using a chat model._

   2. 将所有原先依赖 VectorDB 的链式组件全部重构为基于 `Retriever` 实现。例如，`VectorDBQA` 现已更名为 `RetrievalQA`，`ChatVectorDBChain` 现已更名为 `ConversationalRetrievalChain`，等等。_请注意：今后我们将有意识地采用 `Conversational` 前缀表示该链使用了记忆机制（memory），而采用 `Chat` 前缀表示该链使用了聊天模型（chat model）。_

3. Added the first instance of a non-LangChain Retriever - the `ChatGPT Retrieval Plugin`. This was a module open-sourced yesterday by OpenAI to help companies expose retrieval endpoints to hook into ChatGPT. NB: for all intents and purposes, the inner workings of the `ChatGPT Retrieval Plugin` are extremely similar to our VectorStores, but we are still extremely excited to integrate this as a way highlighting the new flexibility that exists.

   3. 新增首个非 LangChain 原生的检索器实现——即 `ChatGPT Retrieval Plugin`。这是 OpenAI 昨日开源的一个模块，旨在帮助各公司对外暴露检索端点，以便与 ChatGPT 对接。注：从功能本质上看，`ChatGPT Retrieval Plugin` 的内部机制与我们的 `VectorStore` 高度相似；但我们仍非常兴奋能将其集成进来——这正凸显了当前架构所具备的新灵活性。

Expanding on the `Retriever` interface:

扩展 `Retriever` 接口：

- We purposefully only require one method (`get_relevant_documents`) in order to be as permissive as possible. We do not (yet) require any uniform methods around construction of these retrievers.

- 我们有意仅要求一个方法（`get_relevant_documents`），以尽可能保持接口的宽松性。我们目前（尚）不要求这些检索器在构造方式上遵循统一的方法。

- We purposefully enforce `query: str` as the only argument. For all other parameters - including metadata filtering - this should be stored as parameters on the retriever itself. This is because we anticipate the retrievers often being used nested inside chains, and we do not want to have plumb around other parameters.

- 我们有意强制规定 `query: str` 是唯一参数。所有其他参数——包括元数据过滤条件——均应作为检索器自身的属性进行存储。这是因为我们预期检索器常被嵌套在链（chains）中使用，而不希望为传递其他参数而额外增加调用链路的复杂性。

**_This is all done with the end goal of making it easier for alternative retrievers (besides the LangChain VectorStore) to be used in chains and agents, and encouraging innovation in alternative retrieval methods._**

**_上述设计的最终目标是：降低除 LangChain `VectorStore` 之外的其他检索器在链（chains）和智能体（agents）中使用的门槛，并鼓励探索与创新更多样化的检索方法。_**

## Q&A

## 常见问题解答（Q&A）

**Q: What's the difference between an index and a retriever?**

**Q：索引（index）与检索器（retriever）有何区别？**

**A:** An index is a data structure that supports efficient searching, and a retriever is the component that uses the index to find and return relevant documents in response to a user's query. The index is a key component that the retriever relies on to perform its function.

**A：** 索引是一种支持高效搜索的数据结构；而检索器则是利用该索引、针对用户查询查找并返回相关文档的组件。索引是检索器赖以实现其功能的关键组成部分。

**Q: If I was using a VectorStore before in `VectorDBQA` chain (or other `VectorDB`-type chains), what do I now use in `RetrievalQA` chain?**

**Q：如果我此前在 `VectorDBQA` 链（或其他 `VectorDB` 类型的链）中使用了 `VectorStore`，那么现在在 `RetrievalQA` 链中应使用什么？**

**A:** You can use a `VectorStoreRetriever`, which you can create from an existing vectorstore by doing `vectorstore.as_retriever()`

**A：** 您可以使用 `VectorStoreRetriever`，它可通过已有向量数据库（vectorstore）调用 `vectorstore.as_retriever()` 方法创建。

**Q: Does `VectorDBQA` chain (or other `VectorDB`-type chains) still exist?**

**Q：`VectorDBQA` 链（或其他 `VectorDB` 类型的链）是否仍然存在？**

**A:** Yes, although we will be no be focusing on it any more. Expect any future development to be done on `RetrievalQA` chain.

**A：** 是的，该链依然存在；但我们今后将不再重点维护它。未来所有新功能开发都将集中在 `RetrievalQA` 链上。

**Q: Can I contribute a new retrieval method to the library?**

**Q：我可以为该库贡献一种新的检索方法吗？**

**A:** Yes! We started a new `langchain/retrievers` module exactly for this purpose

**A：** 可以！我们专门为此目的新建了一个 `langchain/retrievers` 模块。

**Q: What are real world examples this enables?**

**Q：这在现实世界中有哪些典型应用场景？**

**A:** The main one is better question-answering over your documents. However, if start to ingest and then retrieve previous messages, this can then be thought of as better long term memory for AI.

**A：** 主要应用场景是提升您文档上的问答效果。此外，若您开始摄入并随后检索过往消息，这种能力便可视为为 AI 提供更优的长期记忆。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](https://blog.langchain.com/content/images/size/w760/format/webp/2025/12/Evaluating-Deep-Agents.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](https://blog.langchain.com/content/images/size/w760/format/webp/2025/12/Evaluating-Deep-Agents.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/retrieval/img_003.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/retrieval/img_003.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/retrieval/img_004.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/retrieval/img_004.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/retrieval/img_005.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/retrieval/img_005.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/retrieval/img_006.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更便捷的评估](images/retrieval/img_006.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更简易的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/retrieval/img_007.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项](images/retrieval/img_007.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟