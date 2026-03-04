---
render_with_liquid: false
title: "Improving Document Retrieval with Contextual Compression"
source: "LangChain Blog"
url: "https://blog.langchain.com/improving-document-retrieval-with-contextual-compression/"
date: "2023-08-18"
scraped_at: "2026-03-03T09:00:35.631828592+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
render_with_liquid: false
render_with_liquid: false

_Note: This post assumes some familiarity with LangChain and is moderately technical._

_注：本文假设读者对 LangChain 有一定了解，内容具有中等技术难度。_

💡 **TL;DR**: We’ve introduced a new abstraction and a new document Retriever to facilitate the post-processing of retrieved documents. Specifically, the new abstraction makes it easy to take a set of retrieved documents and extract from them only the information relevant to the given query.

💡 **简而言之（TL;DR）**：我们引入了一种新抽象机制和一种新型文档检索器（document Retriever），以支持对已检索文档进行后处理。具体而言，该新抽象机制可轻松地从一组已检索文档中，仅提取与当前查询相关的信息。

## Introduction

## 引言

Many LLM-powered applications require some queryable document storage that allows for the retrieval of application-specific information that's not already baked into the LLM.

许多由大语言模型（LLM）驱动的应用需要一种可查询的文档存储系统，以便检索那些未被预先编码进 LLM 的、与应用特定相关的知识。

Suppose you wanted to create a chatbot that could answer questions about your personal notes. One simple approach is to embed your notes in equally-sized chunks and store the embeddings in a vector store. When you ask the system a question, it embeds your question, performs a similarity search over the vector store, retrieves the most relevant documents (chunks of text), and appends them to the LLM prompt.

假设你想构建一个能回答你个人笔记相关问题的聊天机器人。一种简单方法是：将笔记切分为等长文本块，将其嵌入向量并存入向量数据库。当你向系统提问时，系统会对问题进行嵌入，然后在向量库中执行相似性搜索，检索出最相关的文档（即若干文本块），并将这些文本块附加到 LLM 的提示词（prompt）中。

![](images/improving-document-retrieval-with-contextual-compression/img_001.png)A simple retrieval Q&A system

![](images/improving-document-retrieval-with-contextual-compression/img_001.png)一种简单的基于检索的问答系统

## Problem

## 问题

One problem with this approach is that when you ingest data into your document storage system, you often don’t know what specific queries will be used to retrieve those documents. In our notes Q&A example, we simply partitioned our text into equally-sized chunks. That means that when we get a specific user question and retrieve a document, even if the document has some relevant text it likely has some irrelevant text as well.

这种方案存在一个问题：当你将数据导入文档存储系统时，往往无法预知后续将使用哪些具体查询来检索这些文档。在上述笔记问答示例中，我们只是简单地将文本划分为等长片段。这意味着，当针对某个具体用户问题检索到某份文档时，尽管其中可能包含部分相关信息，但也很可能混杂着大量无关内容。

Inserting irrelevant information into the LLM prompt is bad because:

向 LLM 的提示词中插入无关信息会带来以下负面影响：

1. It might distract the LLM from the relevant information  
   1. 可能干扰 LLM 对关键信息的关注；  
2. It takes up precious space that could be used to insert other relevant information.  
   2. 占用宝贵的上下文空间，而这些空间本可用于容纳其他相关的重要信息。

## Solution

## 解决方案

To help with this we’ve introduced a `DocumentCompressor` abstraction which allows you to run `compress_documents(documents: List[Document], query: str)` on your retrieved documents. The idea is simple: instead of immediately returning retrieved documents as-is, we can compress them using the context of the given query so that only the relevant information is returned. “Compressing” here refers to both compressing the contents of an individual document and filtering out documents wholesale.

为解决这一问题，我们引入了 `DocumentCompressor` 抽象接口，使您能够对检索到的文档调用 `compress_documents(documents: List[Document], query: str)` 方法。其核心思想十分简洁：不直接原样返回检索结果，而是结合给定查询的上下文对文档进行“压缩”，从而仅保留与查询相关的信息。“压缩”在此处包含两层含义：一是精简单个文档的内容，二是整体过滤掉不相关的文档。

![Retrieval Q&A system with contextual document compression](images/improving-document-retrieval-with-contextual-compression/img_002.png)Retrieval Q&A system with contextual document compression

![带上下文感知文档压缩的检索式问答系统](images/improving-document-retrieval-with-contextual-compression/img_002.png)带上下文感知文档压缩的检索式问答系统

The goal of compressors is to make it easy to pass **only** the relevant information to the LLM. By doing this, it also enables you to pass along **more** information to the LLM, since in the initial retrieval step you can focus on recall (e.g. by increasing the number of documents returned) and let the compressors handle precision.

压缩器的目标是让您能轻松地将**仅限相关**的信息传递给大语言模型（LLM）。通过这种方式，您还能向 LLM 传递**更多**信息——因为在初始检索阶段，您可以专注于提升召回率（例如，增加返回的文档数量），而将精确度（precision）交由压缩器来保障。

## Features

## 功能特性

We’ve implemented a couple new features in the LangChain Python package:

我们在 LangChain Python 包中实现了若干新功能：

- A set of DocumentCompressors that you can use out of the box.  
  一组开箱即用的 `DocumentCompressor` 实现。

- A `ContextualCompressionRetriever` which wraps another Retriever along with a DocumentCompressor and automatically compresses the retrieved documents of the base Retriever.  
  一个 `ContextualCompressionRetriever`，它封装另一个 `Retriever` 和一个 `DocumentCompressor`，并自动对底层 `Retriever` 检索出的文档执行压缩。

Some example DocumentCompressors:

以下是一些 `DocumentCompressor` 的示例实现：

- The `LLMChainExtractor` uses an LLMChain to extract from each document only the statements that are relevant to the query.  
  `LLMChainExtractor` 利用 `LLMChain` 从每个文档中仅提取与查询相关的内容片段。

- The `EmbeddingsFilter` embeds both the retrieved documents and the query and filters out any documents whose embeddings aren’t sufficiently similar to the embedded query. On it’s own this compressor does something very similar to most VectorStore retrievers, but it becomes more useful as a component in…  
  `EmbeddingsFilter` 对检索到的文档和查询分别进行嵌入（embedding），然后滤除那些嵌入向量与查询嵌入向量相似度不足的文档。单独使用时，该压缩器的行为与大多数向量数据库（VectorStore）检索器非常相似；但作为更复杂流程的组件时，其价值更为凸显……

- … the `DocumentCompressorPipeline`, which makes it easy to create a pipeline of transformations and compressors and run them in sequence. A simple example of this is you may want to combine a `TextSplitter` and an `EmbeddingsFilter` to first break up your documents into smaller pieces and then filter out the split documents that are no longer relevant.  
  …即 `DocumentCompressorPipeline`，它支持便捷地构建由多种转换器（transformer）和压缩器组成的处理流水线，并按序执行。一个简单示例是：您可将 `TextSplitter` 与 `EmbeddingsFilter` 组合使用——先将原始文档切分为更小的文本块，再滤除其中与查询不再相关的分块文档。

You can try these out with any existing Retriever (whether VectorStore based or otherwise) with something like:

您可将上述功能与任意现有 `Retriever`（无论是否基于 VectorStore）配合使用，例如：

```python
from langchain.llms import OpenAI
from langchain.retrievers import ContextualCompressionRetriever
from langchain.retrievers.document_compressors import LLMChainExtractor

# base_retriever defined somewhere above...

compressor = LLMChainExtractor.from_llm(OpenAI(temperature=0))
compression_retriever = ContextualCompressionRetriever(base_compressor=compressor, base_retriever=retriever)
contextual_retriever.get_relevant_documents("insert query here")
```

前往此处的[操作指南](https://python.langchain.com/docs/modules/data_connection/retrievers/how_to/contextual_compression?ref=blog.langchain.com)，立即开始使用！

### 标签

[作者：LangChain](https://blog.langchain.com/tag/by-langchain/)

[![评估深度智能体：我们的经验总结](images/improving-document-retrieval-with-contextual-compression/img_003.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[作者：LangChain](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/improving-document-retrieval-with-contextual-compression/img_004.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中推出端到端 OpenTelemetry 支持](images/improving-document-retrieval-with-contextual-compression/img_004.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中推出端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长约 3 分钟

[![LangChain State of AI 2024 Report](images/improving-document-retrieval-with-contextual-compression/img_005.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain《2024 年人工智能现状》报告](images/improving-document-retrieval-with-contextual-compression/img_005.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain《2024 年人工智能现状》报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长约 6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/improving-document-retrieval-with-contextual-compression/img_006.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/improving-document-retrieval-with-contextual-compression/img_006.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长约 4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/improving-document-retrieval-with-contextual-compression/img_007.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![借助 LangSmith SDK v0.2 实现更便捷的评估](images/improving-document-retrieval-with-contextual-compression/img_007.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更轻松的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/improving-document-retrieval-with-contextual-compression/img_008.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的新部署选项](images/improving-document-retrieval-with-contextual-compression/img_008.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟