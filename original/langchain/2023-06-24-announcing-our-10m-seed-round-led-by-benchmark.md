---
title: "Announcing our $10M seed round led by Benchmark"
source: "LangChain Blog"
url: "https://blog.langchain.com/announcing-our-10m-seed-round-led-by-benchmark/"
date: "2023-06-24"
scraped_at: "2026-03-03T09:45:56.375794086+00:00"
language: "en"
translated: false
---

It was only six months ago that we released the first version of LangChain, but it seems like several years. When we launched, generative AI was starting to go mainstream: stable diffusion had [just been released](https://stability.ai/blog/stable-diffusion-public-release?ref=blog.langchain.com) and was captivating people’s imagination and fueling an explosion in developer activity, Jasper [announced a funding round](https://www.prnewswire.com/news-releases/jasper-announces-125m-series-a-funding-round-bringing-total-valuation-to-1-5b-and-launches-new-browser-extension-301651733.html?ref=blog.langchain.com), and investors released the first [Gen AI market maps](https://www.sequoiacap.com/article/generative-ai-a-creative-new-world/?ref=blog.langchain.com).

Alongside this boon in content creation, people started to realize that the true power of this technology was not using a language model in isolation, but using the language model as part of a new, more intelligent system. Developers were discussing how to connect language models to their own proprietary documents, APIs, and structured data. Research papers like [Self-Ask with Search](https://twitter.com/OfirPress/status/1577302733383925762?s=20&ref=blog.langchain.com) and [ReAct](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2210.xml?ref=blog.langchain.com) were published, demonstrating the power of these approaches.

Amongst these early tremors of a tectonic shift in computing, we released the first version of the LangChain Python package on October 24th, 2022. In the very first [tweet thread](https://twitter.com/hwchase17/status/1584925380976091137?s=20&ref=blog.langchain.com), Harrison said:

- “a python package aimed at helping build LLM applications through composability”
- “The real power comes when you are able to combine \[LLMs\] with other things.”
- “LangChain aims to help with that by creating… a comprehensive collection of pieces you would ever want to combine… a flexible interface for combining pieces into a single comprehensive ‘chain’”

## **Why Raise Funding?**

This all started as an open-source side project, without any intention of building a company. It began by noticing common patterns in how people were approaching problems, and attempting to create abstractions that made it easier. These first simple abstractions struck a chord and the project took off, thanks largely to your community support and contributions. LangChain now has over 20K stars on GitHub, 10K active Discord members, over 30K followers on Twitter, and - most importantly - over 350 contributors.

It became clear that the combination of LangChain + LLMs blows open the frontier of amazing products and applications to be built. And, it also is clear that far more work and tooling are needed to make these applications work well (particularly in production). You’re asking us every day for more (400+ GitHub issues, 100 open PRs) and we want to help!

With that in mind, we are excited to publicly announce that we have raised $10 million in seed funding. Benchmark led the round and we’re thrilled to have their counsel as they’ve been the first lead investors in some of the iconic open source software we all use including Docker, Confluent, Elastic, Clickhouse and more. With this capital we are going to invest aggressively to keep up with the ground breaking work the community is doing building intelligent apps. Our goal is simple: empower developers to build useful applications powered by language models.

So what can you expect from us?

## **LangChain Today**

LangChain is a framework for developing applications powered by language models, offered as both a [Python](https://github.com/hwchase17/langchain?ref=blog.langchain.com) and a [TypeScript](https://github.com/hwchase17/langchainjs?ref=blog.langchain.com) package. We believe that the most powerful and differentiated language model applications will:

1. Be data-aware: connect a language model to other sources of data
2. Be agentic: allow a language model to interact with its environment

The LangChain framework is designed with the above objective principles in mind. We believe that the two main value props it provides are:

### **Components**

LangChain offers a modular set of abstractions and components that provide everything developers need to build applications using language models. It also includes collections of implementations for these abstractions.

These components are largely community driven. There are over 300 contributors on the Python repo alone. Some highlights:

- Integrations with [20+ different model providers](https://python.langchain.com/docs/modules/model_io/models/?ref=blog.langchain.com) or hosting platforms
- Collection of [50+ Document Loaders](https://python.langchain.com/docs/modules/data_connection/document_loaders/?ref=blog.langchain.com) to load data from different sources
- Collection of [10+ methods for splitting text](https://python.langchain.com/docs/modules/data_connection/document_transformers/?ref=blog.langchain.com) data into chunks so that a Language Model can easily use it
- Integrations with [10+ different vector databases](https://python.langchain.com/docs/modules/data_connection/vectorstores/?ref=blog.langchain.com)
- Collection of [15+ different tools](https://python.langchain.com/docs/modules/agents/tools/?ref=blog.langchain.com) to let Language Models use

### **Pre-built Chains and Agents**

Chains allow developers to assemble components in a specific manner to accomplish a particular task, such as summarizing a large pdf document or querying a SQL database. Agents can be thought of as “dynamic chains” in which the sequence of steps taken are determined by a language model on the fly. In addition to providing a high-level interface that makes it easy for developers to create custom chains and agents, LangChain provides many pre-built ones that can be used out-of-the-box.

Again, these components are largely community driven. Some highlights:

- Implementations of [~20 different chains](https://python.langchain.com/docs/modules/chains/?ref=blog.langchain.com)
- Implementations of [6 different generic agent types](https://python.langchain.com/docs/modules/agents/?ref=blog.langchain.com) (chains specifically designed to use tools and interact with the outside world)
- Implementations of [7 different “Agent Toolkits”](https://python.langchain.com/docs/modules/agents/toolkits/?ref=blog.langchain.com) (agents equipped with a specific set of tools to accomplish a specific task)

## **Future Plans**

As mentioned earlier, we believe that language models are unlocking new types of high-value applications, and it is still non-trivial to create and maintain these applications — particularly in production settings. Some of our more recent releases are focused on addressing these problems:

- Bringing the TypeScript package up to feature parity with Python to enable more full-stack and frontend developers to create LLM applications
- Implementing several types of [OutputParsers](https://python.langchain.com/docs/modules/model_io/output_parsers/?ref=blog.langchain.com), to allow for more safety and guidance on the text returned by a LLM
- Introducing a [Retriever abstraction](https://blog.langchain.com/retrieval/) to enable more complicated and necessary types of document retrieval
- Building integrations with solutions like Weights & Biases, AIM, ClearML to enable more observability and experimentation with LLM applications

We will continue to add features to LangChain and provide other offerings that will:

1. Make it easy to quickly prototype applications.
2. Bridge the gap between prototyping and putting something into production.

We’re incredibly excited to see what will be built and to do more to support you. We are also especially grateful to the entire LangChain community. LangChain will continue to be open-source and focused on developers — our funding allows us to allocate more resources to take it to the next level. If this mission and journey sounds interesting to you, we are [actively hiring founding engineers](https://docs.google.com/forms/d/e/1FAIpQLScrz8YeKJI6F5bnM1Mvq4wkK91f0RQPVIvXBDULeqbQSwJ0tQ/viewform?usp=sf_link&ref=blog.langchain.com). If you have suggestions on new features or are interested in evaluating and running your LangChain applications in production, we’d especially love to hear from you at support@langchain.dev!

Thank you for everything so far, and let’s build some cool stuff 🙂

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