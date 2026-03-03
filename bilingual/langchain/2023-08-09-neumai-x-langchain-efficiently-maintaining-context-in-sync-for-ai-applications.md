---
title: "NeumAI x LangChain: Efficiently maintaining context in sync for AI applications"
source: "LangChain Blog"
url: "https://blog.langchain.com/neum-x-langchain/"
date: "2023-08-09"
scraped_at: "2026-03-03T09:18:18.146643874+00:00"
language: "en-zh"
translated: true
---

_Editors Note: This post was written by the [NeumAI](https://www.neum.ai/?ref=blog.langchain.com) team and cross-posted from their blog. Keeping source data relevant and up-to-date efficiently is a challenge many builders are facing. It's especially painful for teams that are building on top of datasources constantly changing like team documentation (a use-case we see a lot of). Following up on our blog yesterday about making ingestion pipelines more production ready, we're really excited to highlight this because it continues in that vein. It adds scheduling and orchestration onto the ingestion pipeline, part of which is powered by LangChain text splitters._

编辑注：本文由 [NeumAI](https://www.neum.ai/?ref=blog.langchain.com) 团队撰写，并同步发布于其博客。如何高效地保持源数据的相关性与时效性，是当前众多开发者共同面临的挑战。对于那些构建在持续变化的数据源（例如团队内部文档——这是我们高频遇到的用例）之上的团队而言，这一问题尤为棘手。继我们昨日发布关于如何让数据摄取（ingestion）流水线更具备生产就绪（production-ready）能力的博客之后，我们非常兴奋地推出本文——它延续了该主题的深入探索：为摄取流水线新增调度（scheduling）与编排（orchestration）能力，其中部分功能由 LangChain 文本切分器（text splitters）提供支持。

Last week, we released a [blogpost](https://www.neum.ai/post/q-a-with-1000-documents?ref=blog.langchain.com) about doing Q&A with thousands of documents and how Neum AI can help developers build large-scale AI apps to support that scenario. In this post, we want to dive deeper into a common problem with building large scale AI applications: Keeping context up to date in a cost-effectively way.

上周，我们发布了一篇 [博客文章](https://www.neum.ai/post/q-a-with-1000-documents?ref=blog.langchain.com)，探讨了如何基于数千份文档实现问答（Q&A），以及 Neum AI 如何助力开发者构建支撑该场景的大规模 AI 应用。本文将进一步深入探讨构建大规模 AI 应用时一个普遍存在的难题：**如何以高性价比的方式，持续保持上下文（context）的时效性与相关性**。

## Intro

## 引言

Let’s set up some context first (see what we did there ;)). Data is the most important part when building AI applications. If the data you are training the model with is of low quality, then your model with perform poorly. If the data you are using for your prompts is low quality, then your model responses will not be accurate. There are many more examples on why data is important but it is really the fundamental part for bringing accuracy to our AI models.

我们先来“设定一下上下文”（您发现这个双关语了吗？😉）。数据是构建 AI 应用中最关键的一环。若用于训练模型的数据质量低下，模型性能必将大打折扣；若用于构造提示词（prompts）的数据质量不佳，则模型输出的响应也将失准。数据重要性的例证不胜枚举，但归根结底，它是保障 AI 模型准确性的基石。

Specifically here, let’s delve in **context**. Many have done chatbots where a massive prompt is passed to the model. This can become problematic for a [couple of reasons](https://www.pinecone.io/blog/why-use-retrieval-instead-of-larger-context/?ref=blog.langchain.com).

此处我们聚焦于 **上下文（context）** 这一概念。许多开发者已构建过聊天机器人，其典型做法是将一个极其庞大的提示词整体传给模型。然而，这种做法会因以下[若干原因](https://www.pinecone.io/blog/why-use-retrieval-instead-of-larger-context/?ref=blog.langchain.com)而面临严峻挑战：

1. You might reach a context limit depending on the model you use  
   1. 您可能触及所用模型的上下文长度限制；  
2. The more tokens you pass the more costly your operation becomes  
   2. 传递的 token 数量越多，操作成本就越高。

And so, people have started to include context in the prompt that is fetched depending on the user’s query so as to only pass a subset of **relevant information** to the model for it to perform accurately. This is also called Retrieval Augmented Generation (RAG). Those who have built this know what I’m talking about but if you aren’t you can check these two blog posts by [Pinecone](https://www.pinecone.io/learn/retrieval-augmented-generation/?ref=blog.langchain.com) and [LangChain](https://blog.langchain.com/retrieval/) for more information.

因此，业界逐渐转向一种新范式：仅根据用户查询动态检索并注入**相关上下文**至提示词中，从而只向模型传递最精简、最相关的子集信息，以确保其响应准确。这一范式即所谓“检索增强生成”（Retrieval-Augmented Generation, RAG）。有经验的开发者对此心领神会；若您尚不熟悉，可参考 [Pinecone](https://www.pinecone.io/learn/retrieval-augmented-generation/?ref=blog.langchain.com) 和 [LangChain](https://blog.langchain.com/retrieval/) 发布的这两篇博客获取更多详情。

![](images/neumai-x-langchain-efficiently-maintaining-context-in-sync-for-ai-applications/img_001.png)_Source: Pinecone_ [_docs_](https://www.pinecone.io/learn/retrieval-augmented-generation/?ref=blog.langchain.com)

![](images/neumai-x-langchain-efficiently-maintaining-context-in-sync-for-ai-applications/img_001.png)_来源：Pinecone_ [_文档_](https://www.pinecone.io/learn/retrieval-augmented-generation/?ref=blog.langchain.com)

One problem not too many seem to talk about is **how relevant this context is**.

目前鲜有讨论却至关重要的一大问题是：**这些上下文究竟有多相关？**

## **Relevant and up-to-date context**

## **相关且实时更新的上下文**

Imagine you are creating a chatbot over a constantly-changing data source like a restaurant’s menu or some team documentation. You can easily build a chatbot with some of the libraries and tools explained in the [previous post](https://www.neum.ai/post/q-a-with-1000-documents?ref=blog.langchain.com) \- like LangChain, Pinecone, etc. I won’t go into too many details but at a high level it goes something like this:

想象你正在为一个持续变化的数据源（例如餐厅菜单或团队内部文档）构建一个聊天机器人。你可以轻松地利用上一篇博文 [《Q&A with 1000 Documents》](https://www.neum.ai/post/q-a-with-1000-documents?ref=blog.langchain.com) 中介绍的某些库和工具（如 LangChain、Pinecone 等）来实现这一目标。此处不再深入细节，但整体流程大致如下：

1. Get your source data  
2. Vectorize it using some embedding model (This is crucial so that whenever we bring context to the prompt, the “search” based on the user query is done **semantically** and **fast**)  
3. Bring the context to the prompt of your model (like GPT-4 for example) and run the model.  
4. Output to the user  

1. 获取原始数据  
2. 使用某种嵌入模型（embedding model）对数据进行向量化（这至关重要：只有完成向量化，当我们将上下文注入提示词（prompt）时，基于用户查询的“检索”才能做到**语义化**且**高效**）  
3. 将检索到的上下文注入模型（例如 GPT-4）的提示词中，并运行模型  
4. 将结果输出给用户  

This poses a trivial question. **What if your source data changes?**

这引出一个看似简单却十分关键的问题：**如果原始数据发生了变更，该怎么办？**

It could be that the restaurant is no longer offering an item from the menu. That an internal documents or wiki was just updated with some new content.

比如，餐厅可能已下架某道菜品；又或者，团队内部文档或 Wiki 刚刚更新了部分内容。

**Will our chatbot respond with high accuracy?**

**我们的聊天机器人还能保持高准确率响应吗？**

Chances are, no. Unless you have a way to give your AI model, up to date context, it probably won’t know that the pepperoni pizza is no longer available or that the documentation for onboarding a new team member to the team changed. It will respond with whatever context had been stored before in the vector store (or even without any context!)

大概率不会。除非你有办法为 AI 模型持续提供最新鲜的上下文，否则它很可能并不知道“意大利香肠披萨”已经下架，也不知道“新成员入职流程”的文档已被更新。它只会依据向量数据库中此前存储的旧上下文（甚至完全不依赖上下文！）来生成回复。

![](images/neumai-x-langchain-efficiently-maintaining-context-in-sync-for-ai-applications/img_002.png)ChatGPT response with no context

![](images/neumai-x-langchain-efficiently-maintaining-context-in-sync-for-ai-applications/img_002.png)ChatGPT 在无上下文情况下的响应

## **Enter Neum**

## **迎来 Neum**

With Neum we automatically **synchronize** your source data with your vector store. This means that whenever an AI application wants to query the vector db for semantic search or bringing context to an AI model, the information will always be updated. It is important to note that the quality of your model also depends on how you vectorize the data. At Neum, we leverage different LangChain tools to partition the source data depending on the use case.‍

借助 Neum，我们可自动将你的原始数据与向量数据库保持**同步**。这意味着，无论何时 AI 应用需要在向量数据库中执行语义搜索，或为 AI 模型注入上下文，所获取的信息始终是最新的。需要特别指出的是：模型效果的好坏，不仅取决于向量数据库本身，也高度依赖于你对原始数据的向量化方式。在 Neum，我们根据具体应用场景，灵活调用多种 LangChain 工具对原始数据进行分块（partitioning）。

![](images/neumai-x-langchain-efficiently-maintaining-context-in-sync-for-ai-applications/img_003.png)_Neum pipeline builder example for syncing your data between Notion and Pinecone_

![](images/neumai-x-langchain-efficiently-maintaining-context-in-sync-for-ai-applications/img_003.png)_Neum 管道构建器示例：在 Notion 与 Pinecone 之间同步您的数据_

‍

‍

These are amongst the top things that are needed when building this synchronization for your LLM data.

在为大语言模型（LLM）数据构建此类同步功能时，以下几项是至关重要的需求：

1. Setting up the infrastructure required to sync the sources  
1. 搭建用于同步数据源所需的基础设施  

2. Setting up your scheduler or real-time pipelines to update the data  
2. 配置调度器或实时数据管道，以更新数据  

3. Handling errors if something goes wrong at any given point  
3. 在任意环节出错时进行异常处理  

4. And most importantly, **efficiently vectorizing to reduce costs**  
4. 而且最重要的是，**高效向量化以降低成本**

Now, let’s briefly talk about costs.

接下来，我们简要谈谈成本问题。

OpenAI embeddings pricing model currently is [$0.0001/1k tokens](https://openai.com/pricing?ref=blog.langchain.com). That might not look like much but at large scale, it translates roughly to 10k per 1TB of data. If your source data is not large, you might get away with it by constantly vectorizing and storing your data in the vector store.

目前 OpenAI 的嵌入（embeddings）定价模型为 [每 1000 个 token 收费 $0.0001](https://openai.com/pricing?ref=blog.langchain.com)。单看这一数字似乎微不足道，但在大规模场景下，其成本大致相当于每 1TB 数据约 1 万美元。如果您的原始数据量不大，持续对全部数据执行向量化并将其存入向量数据库，或许尚可接受。

But what if you have lots of documents? What if you have millions and millions of rows in your database? Vectorizing everything all the time will not only be **inefficient but very costly**!

但若您拥有海量文档呢？若您数据库中包含数百万甚至上千万行记录呢？持续对全部内容执行向量化，不仅**效率低下，而且成本极高**！

At Neum, we’ve developed tech to help detect differences and only vectorize the necessary information, thus **_keeping the context up-to-date but in an efficient and cost-saving way._**

在 Neum，我们已研发出专门技术，可自动识别数据差异，并仅对必要信息执行向量化，从而 **_在保障上下文始终最新之余，实现高效性与成本节约的双重目标。_**

## See it to believe it

## 眼见为实

To prove this we created a sample chatbot for our Notion workspace that is updated automatically as the Notion is updated with more content. It allows users to ask questions and get **up-to-date** responses if something changed internally. The sample is built with Vercel as frontend and Pinecone as the vector store. Internally, Neum leverages LangChain for its text splitter tools.

为验证该能力，我们为自己的 Notion 工作区构建了一个示例聊天机器人：当 Notion 中新增或更新内容时，该机器人将自动同步更新。用户可随时提问，一旦内部数据发生变更，即可获得**最新、最准确**的响应。该示例前端采用 Vercel 构建，向量存储使用 Pinecone；Neum 内部则借助 LangChain 提供的文本切分（text splitter）工具完成关键处理。

Behind the scenes, Neum is not only ensuring that updates are extracted, embedded and loaded into Pinecone, but also makes sure that we are only updating data that needs to be. If a section of the Notion workspace didn’t change, we don’t re-embed it. If a section changed, then it is re-embedded. This approach delivers a better user experience by having up to date data that is also more cost effective by only using resources where needed.

在幕后，Neum 不仅确保更新内容被提取、嵌入并加载至 Pinecone，还确保我们仅更新真正需要更新的数据。如果 Notion 工作区的某一部分未发生变化，Neum 就不会对其重新执行嵌入；只有当某一部分确实发生了变更时，才会重新嵌入。这种策略既保障了数据的实时性，从而提升用户体验，又通过按需调用计算资源显著降低了成本。

Take a look at the 2min video below for an in-depth look of how it works!

请观看下方这段时长约 2 分钟的视频，深入了解其工作原理！

![](images/neumai-x-langchain-efficiently-maintaining-context-in-sync-for-ai-applications/img_004.gif)

You can reach out to [founders@tryneum.com](mailto:founders@tryneum.com) if interested in these topics!

如您对上述话题感兴趣，欢迎联系 [founders@tryneum.com](mailto:founders@tryneum.com)！

### Tags

### 标签

[![Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination](images/neumai-x-langchain-efficiently-maintaining-context-in-sync-for-ai-applications/img_005.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**让数据接入具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[![Chat with your data using OpenAI, Pinecone, Airbyte and Langchain](images/neumai-x-langchain-efficiently-maintaining-context-in-sync-for-ai-applications/img_006.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**Chat with your data using OpenAI, Pinecone, Airbyte and Langchain**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**Yeager.ai x LangChain: Exploring GenWorlds a Framework for Coordinating AI Agents**](https://blog.langchain.com/exploring-genworlds/)

[**Yeager.ai × LangChain：探索 GenWorlds——一个用于协调 AI 智能体的框架**](https://blog.langchain.com/exploring-genworlds/)


[![Conversational Retrieval Agents](https://images.unsplash.com/photo-1625794084867-8ddd239946b1?crop=entropy&cs=tinysrgb&fit=max&fm=webp&ixid=M3wxMTc3M3wwfDF8c2VhcmNofDZ8fGdvbGRlbiUyMHJldHJpZXZlcnxlbnwwfHx8fDE2OTEwNDEwOTl8MA&ixlib=rb-4.0.3&q=80&w=760)](https://blog.langchain.com/conversational-retrieval-agents/)

[![对话式检索智能体](https://images.unsplash.com/photo-1625794084867-8ddd239946b1?crop=entropy&cs=tinysrgb&fit=max&fm=webp&ixid=M3wxMTc3M3wwfDF8c2VhcmNofDZ8fGdvbGRlbiUyMHJldHJpZXZlcnxlbnwwfHx8fDE2OTEwNDEwOTl8MA&ixlib=rb-4.0.3&q=80&w=760)](https://blog.langchain.com/conversational-retrieval-agents/)


[**Conversational Retrieval Agents**](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体**](https://blog.langchain.com/conversational-retrieval-agents/)


[**Unifying AI endpoints with Genoss, powered by LangChain**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)

[**借助 LangChain，使用 Genoss 统一 AI 接口端点**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)


[![LangChain Expression Language](https://images.unsplash.com/photo-1619431843665-54babc76ac8c?crop=entropy&cs=tinysrgb&fit=max&fm=webp&ixid=M3wxMTc3M3wwfDF8c2VhcmNofDZ8fGV4cHJlc3Npb258ZW58MHx8fHwxNjkwNTk0MTk5fDA&ixlib=rb-4.0.3&q=80&w=760)](https://blog.langchain.com/langchain-expression-language/)

[![LangChain 表达式语言（LCEL）](https://images.unsplash.com/photo-1619431843665-54babc76ac8c?crop=entropy&cs=tinysrgb&fit=max&fm=webp&ixid=M3wxMTc3M3wwfDF8c2VhcmNofDZ8fGV4cHJlc3Npb258ZW58MHx8fHwxNjkwNTk0MTk5fDA&ixlib=rb-4.0.3&q=80&w=760)](https://blog.langchain.com/langchain-expression-language/)


[**LangChain Expression Language**](https://blog.langchain.com/langchain-expression-language/)

[**LangChain 表达式语言（LCEL）**](https://blog.langchain.com/langchain-expression-language/)