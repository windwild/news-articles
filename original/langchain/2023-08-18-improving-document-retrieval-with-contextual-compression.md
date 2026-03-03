---
title: "Improving Document Retrieval with Contextual Compression"
source: "LangChain Blog"
url: "https://blog.langchain.com/improving-document-retrieval-with-contextual-compression/"
date: "2023-08-18"
scraped_at: "2026-03-03T09:00:35.631828592+00:00"
language: "en"
translated: false
tags: ["By LangChain"]
---

_Note: This post assumes some familiarity with LangChain and is moderately technical._

💡 **TL;DR**: We’ve introduced a new abstraction and a new document Retriever to facilitate the post-processing of retrieved documents. Specifically, the new abstraction makes it easy to take a set of retrieved documents and extract from them only the information relevant to the given query.

## Introduction

Many LLM-powered applications require some queryable document storage that allows for the retrieval of application-specific information that's not already baked into the LLM.

Suppose you wanted to create a chatbot that could answer questions about your personal notes. One simple approach is to embed your notes in equally-sized chunks and store the embeddings in a vector store. When you ask the system a question, it embeds your question, performs a similarity search over the vector store, retrieves the most relevant documents (chunks of text), and appends them to the LLM prompt.

![](images/improving-document-retrieval-with-contextual-compression/img_001.png)A simple retrieval Q&A system

## Problem

One problem with this approach is that when you ingest data into your document storage system, you often don’t know what specific queries will be used to retrieve those documents. In our notes Q&A example, we simply partitioned our text into equally-sized chunks. That means that when we get a specific user question and retrieve a document, even if the document has some relevant text it likely has some irrelevant text as well.

Inserting irrelevant information into the LLM prompt is bad because:

1. It might distract the LLM from the relevant information
2. It takes up precious space that could be used to insert other relevant information.

## Solution

To help with this we’ve introduced a `DocumentCompressor` abstraction which allows you to run `compress_documents(documents: List[Document], query: str)` on your retrieved documents. The idea is simple: instead of immediately returning retrieved documents as-is, we can compress them using the context of the given query so that only the relevant information is returned. “Compressing” here refers to both compressing the contents of an individual document and filtering out documents wholesale.

![Retrieval Q&A system with contextual document compression](images/improving-document-retrieval-with-contextual-compression/img_002.png)Retrieval Q&A system with contextual document compression

The goal of compressors is to make it easy to pass **only** the relevant information to the LLM. By doing this, it also enables you to pass along **more** information to the LLM, since in the initial retrieval step you can focus on recall (e.g. by increasing the number of documents returned) and let the compressors handle precision.

## Features

We’ve implemented a couple new features in the LangChain Python package:

- A set of DocumentCompressors that you can use out of the box.
- A `ContextualCompressionRetriever` which wraps another Retriever along with a DocumentCompressor and automatically compresses the retrieved documents of the base Retriever.

Some example DocumentCompressors:

- The `LLMChainExtractor` uses an LLMChain to extract from each document only the statements that are relevant to the query.
- The `EmbeddingsFilter` embeds both the retrieved documents and the query and filters out any documents whose embeddings aren’t sufficiently similar to the embedded query. On it’s own this compressor does something very similar to most VectorStore retrievers, but it becomes more useful as a component in…
- … the `DocumentCompressorPipeline`, which makes it easy to create a pipeline of transformations and compressors and run them in sequence. A simple example of this is you may want to combine a `TextSplitter` and an `EmbeddingsFilter` to first break up your documents into smaller pieces and then filter out the split documents that are no longer relevant.

You can try these out with any existing Retriever (whether VectorStore based or otherwise) with something like:

```python
from langchain.llms import OpenAI
from langchain.retrievers import ContextualCompressionRetriever
from langchain.retrievers.document_compressors import LLMChainExtractor

# base_retriever defined somewhere above...

compressor = LLMChainExtractor.from_llm(OpenAI(temperature=0))
compression_retriever = ContextualCompressionRetriever(base_compressor=compressor, base_retriever=retriever)
contextual_retriever.get_relevant_documents("insert query here")
```

Head to the walkthrough [here](https://python.langchain.com/docs/modules/data_connection/retrievers/how_to/contextual_compression?ref=blog.langchain.com) to get started!

### Tags

[By LangChain](https://blog.langchain.com/tag/by-langchain/)



[![Evaluating Deep Agents: Our Learnings](images/improving-document-retrieval-with-contextual-compression/img_003.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/improving-document-retrieval-with-contextual-compression/img_004.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[![LangChain State of AI 2024 Report](images/improving-document-retrieval-with-contextual-compression/img_005.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[![Introducing OpenTelemetry support for LangSmith](images/improving-document-retrieval-with-contextual-compression/img_006.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[![Easier evaluations with LangSmith SDK v0.2](images/improving-document-retrieval-with-contextual-compression/img_007.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/improving-document-retrieval-with-contextual-compression/img_008.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read