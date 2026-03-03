---
title: "LangChain + Chroma"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-chroma/"
date: "2023-06-24"
scraped_at: "2026-03-03T09:42:00.182711038+00:00"
language: "en"
translated: false
---

Today we’re announcing LangChain's integration with Chroma, the first step on the path to the Modern A.I Stack.

### LangChain - The A.I-native developer toolkit

We started LangChain with the intent to build a modular and flexible framework for developing A.I-native applications. Some of the use cases which immediately jumped to mind are [chat bots](https://python.langchain.com/docs/use_cases/chatbots/?ref=blog.langchain.com), [question answering](https://python.langchain.com/docs/use_cases/question_answering/?ref=blog.langchain.com) services, and [agents](https://python.langchain.com/docs/use_cases/agents/?ref=blog.langchain.com). Thousands of developers are now hacking, tinkering, and building all kinds of LLM-powered applications using LangChain’s flexible, easy to use framework.

One of the key components of those of applications is embeddings, and vector stores to hold and work with those embeddings.

One pain point that we noticed with a lot of existing vector stores is they often involved connecting to an external server that stored the embeddings. While that is fine for putting applications into production, it does make it a bit tricky to easily prototype applications locally.

The best solution we had for local vector stores was using FAISS, which many community members noted had some tricky dependencies that caused installation issues.

### [Chroma](https://www.trychroma.com/?ref=blog.langchain.com) \- The A.I-native vector store

Chroma was founded to build tools which leverage the power of embeddings. Embeddings are the A.I-native way to represent any kind of data, making them the perfect fit for working with all kinds of A.I-powered tools and algorithms.

While exploring the possibilities of model embeddings at Chroma, the Chroma team needed an easy to use, performant, and lightweight vector store which could handle modern A.I workloads.

While there are already several vector database solutions, they found that these were mostly geared to other use-cases and access patterns, like large-scale semantic search. Additionally, they were often a hassle to set up and run, especially in a development environment.

In short, the Chroma team didn’t find what we needed, **so Chroma built it.**

Chroma is a vector store and embeddings database designed from the ground-up to make it easy to build AI applications with embeddings. It comes with [everything you need to get started built in](https://docs.trychroma.com/getting-started?ref=blog.langchain.com), and runs on your machine - just `pip install chromadb`!

### LangChain and Chroma

Working together, with our mutual focus on flexibility and ease of use, we found that LangChain and Chroma were a perfect fit.

Specifically, LangChain provides a framework to easily prototype LLM applications locally, and Chroma provides a vector store and embedding database that can run seamlessly during local development to power these applications.

Today, we are announcing Chroma’s integration with LangChain. Chroma aims to be the first, easiest, and best choice for most developers building LLM apps with LangChain. It’s ready to use today! Just get the latest version of LangChain, and `from langchain.vectorstores import Chroma` and you're good to go!

To help get started, we put together an [example GitHub repo](https://github.com/hwchase17/chroma-langchain?ref=blog.langchain.com) for you to play around with.

### The Future

The launch of StableDiffusion and ChatGPT sparked an explosion of A.I creativity. Today, thousands of people around the world are working on discovering and unlocking the full power of A.I. At the same time, A.I research continues at a blistering pace. More kinds of data, more ways to interact with A.I, and more insights about how the models work, are being invented every day.

There’s no doubt this is a transformative era, not just in how we build software, but in what’s possible. LangChain and Chroma will remain on the forefront.

### Tags



[![NeumAI x LangChain: Efficiently maintaining context in sync for AI applications](https://blog.langchain.com/content/images/size/w760/format/webp/2023/08/5-social--19.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain: Efficiently maintaining context in sync for AI applications**](https://blog.langchain.com/neum-x-langchain/)


[![Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination](https://blog.langchain.com/content/images/size/w760/format/webp/2023/08/5-social--18.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)


[![Chat with your data using OpenAI, Pinecone, Airbyte and Langchain](https://blog.langchain.com/content/images/size/w760/format/webp/2023/08/image20.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**Chat with your data using OpenAI, Pinecone, Airbyte and Langchain**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)


[**Yeager.ai x LangChain: Exploring GenWorlds a Framework for Coordinating AI Agents**](https://blog.langchain.com/exploring-genworlds/)


[![Conversational Retrieval Agents](https://images.unsplash.com/photo-1625794084867-8ddd239946b1?crop=entropy&cs=tinysrgb&fit=max&fm=webp&ixid=M3wxMTc3M3wwfDF8c2VhcmNofDZ8fGdvbGRlbiUyMHJldHJpZXZlcnxlbnwwfHx8fDE2OTEwNDEwOTl8MA&ixlib=rb-4.0.3&q=80&w=760)](https://blog.langchain.com/conversational-retrieval-agents/)

[**Conversational Retrieval Agents**](https://blog.langchain.com/conversational-retrieval-agents/)


[**Unifying AI endpoints with Genoss, powered by LangChain**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)