---
render_with_liquid: false
title: "LangChain <> MongoDB Atlas"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-x-mongodb-atlas/"
date: "2023-07-25"
scraped_at: "2026-03-03T09:32:28.027701083+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

Today we’re announcing LangChain’s integration with MongoDB Atlas, adding support for one of the most popular developer data platforms in the world. This is an integration so anticipated that a few developers added the integration before we were ready to announce it :)

今天我们宣布 LangChain 与 MongoDB Atlas 的集成，为全球最受欢迎的开发者数据平台之一提供支持。这一集成备受期待，以至于部分开发者甚至在我们正式发布之前就已自行完成了集成 😊

### Overview

### 概述

One of the key components of AI powered applications is semantic search powered by embeddings and vector stores. Semantic Search is a capability that allows you to query your data based on its meaning rather than the data itself.  This is made possible by being able to represent any form of data numerically as a Vector which can then be compared to one another through sophisticated algorithms.

AI 驱动型应用的关键组件之一，是依托嵌入（embeddings）和向量数据库（vector stores）实现的语义搜索（Semantic Search）。语义搜索是一种能力，它允许你基于数据的“含义”而非字面内容来查询数据。这种能力之所以成为可能，是因为任何类型的数据均可被数值化地表示为一个向量（Vector），再通过复杂的算法对这些向量进行相互比对。

While building semantic search capabilities in your production application, vector stores will need to work in conjunction with an application database. One of the largest pain points associated with having a separate vector search engine from your application database is the added complexity around syncing the data between these systems and managing the additional infrastructure. And this doesn’t even include the challenges around security and compliance as you get ready for selling to enterprises.  All of this adds friction to both the process of building applications as well as the work to manage and maintain them in production.

在生产环境中构建语义搜索能力时，向量数据库需与应用数据库协同工作。若将向量搜索引擎与应用数据库分离，最大的痛点之一便是：需额外投入精力同步二者之间的数据，并管理一套全新的基础设施。这甚至尚未涵盖面向企业客户销售时所面临的安全部署与合规性挑战。所有这些因素，都显著增加了应用开发、运维及长期维护的复杂度与摩擦成本。

### **MongoDB Atlas - The Developer Data Platform**

### **MongoDB Atlas — 开发者数据平台**

MongoDB Atlas was released in 2016 to provide a cloud native, fully managed database service offering, helping developers build applications faster than ever before.  Over the years, Atlas has grown into a full fledged developer data platform, satisfying workloads from transactional to search to analytical and streaming.  MongoDB Atlas is a battle-tested platform that provides for high availability, horizontal and vertical scale out, and world class security.  And now it is thrilled to add native support for vectors in the form of Atlas Vector Search to streamline building the next generation of applications.

MongoDB Atlas 于 2016 年发布，旨在提供一款云原生、全托管的数据库服务，助力开发者以前所未有的速度构建应用。多年来，Atlas 已发展成为一个功能完备的开发者数据平台，全面支持事务处理、搜索、分析及流式数据等多种工作负载。作为一款历经实战检验的平台，MongoDB Atlas 提供高可用性、水平与垂直弹性伸缩能力，以及业界领先的安全保障。如今，Atlas 更激动地推出原生向量支持——Atlas Vector Search，以大幅简化下一代应用的构建流程。

### **Introducing Atlas Vector Search**

### **隆重推出 Atlas Vector Search**

Atlas Vector Search is natively built into MongoDB Atlas, so you don’t need to copy and transform your data, learn some new stack and syntax, or manage a whole new set of infrastructure.  Atlas Vector Search allows you to store your vector embeddings right alongside your operational data, dynamically update your vector entries when your data changes using Atlas Triggers, and your application only needs to interact with a single query interface. This drastically reduces the overhead of adding support for vector search and you can utilize these powerful new capabilities all within a world class and battle tested platform to build applications faster than ever before.

Atlas Vector Search 原生集成于 MongoDB Atlas，因此你无需复制或转换数据，不必学习新的技术栈与语法，也无需运维一整套全新基础设施。借助 Atlas Vector Search，你可以将向量嵌入（vector embeddings）直接与业务数据共存于同一数据库；当业务数据发生变化时，还可利用 Atlas Triggers 动态更新对应向量条目；你的应用只需对接单一查询接口即可。这极大降低了引入向量搜索能力的开销——你可以在一个世界级、经实战验证的成熟平台上，直接启用这些强大新特性，以前所未有的速度构建应用。

Sign up for Atlas [here](https://www.mongodb.com/pricing?ref=blog.langchain.com) with our Free Forever Tier

立即注册 Atlas [点击此处](https://www.mongodb.com/pricing?ref=blog.langchain.com)，享受我们的永久免费版（Free Forever Tier）

### **LangChain and MongoDB Atlas**

### **LangChain 与 MongoDB Atlas**

LangChain and MongoDB Atlas are a natural fit, and it’s been demonstrated by the organic community enthusiasm which has led to several integrations in LangChain for MongoDB.  
LangChain 与 MongoDB Atlas 天然契合，这一点已通过社区自发的热情得到印证——这种热情推动了 LangChain 中多个面向 MongoDB 的集成实现。

In addition to now supporting Atlas Vector Search as a Vector Store there is already support to utilize MongoDB as a chat log history.  
除了现已支持将 Atlas Vector Search 作为向量存储（Vector Store）之外，LangChain 还早已支持将 MongoDB 用作聊天记录历史（chat log history）。

Both LangChain and MongoDB are keenly focused on developer productivity with both our core missions centralized around ensuring an amazing developer experience.  
LangChain 与 MongoDB 均高度关注开发者生产力；双方的核心使命均聚焦于打造卓越的开发者体验。

With today’s announcement you can head over to MongoDB Atlas, setup Vector Search, and then connect LangChain and start prompting!  
借助今日发布的公告，您可立即前往 MongoDB Atlas，配置 Vector Search，再连接 LangChain，即刻开始构建提示（prompting）！

To simplify your first time setup, we’ve added some pre-embedded data (using text-embedding-ada-002 from Open AI) to our [MongoDB Atlas sample data](https://www.mongodb.com/developer/products/atlas/atlas-sample-datasets/?ref=blog.langchain.com) (sample\_mflix.embedded\_movies), so it’s as easy as loading the sample data, defining a vector index, and start finding those neighbors with our approximate nearest neighbors algorithm.  
为简化您的首次配置流程，我们已在 [MongoDB Atlas 示例数据集](https://www.mongodb.com/developer/products/atlas/atlas-sample-datasets/?ref=blog.langchain.com) 中预置了嵌入向量数据（使用 OpenAI 的 `text-embedding-ada-002` 模型生成），对应数据集为 `sample_mflix.embedded_movies`。您只需加载该示例数据、定义向量索引，即可借助我们的近似最近邻（approximate nearest neighbors, ANN）算法快速查找相似向量。

### **The Future**

### **未来展望**

We are extremely excited about this new capability, but it is just the beginning!  
我们对这一全新能力倍感振奋，但这仅仅是个开端！

The MongoDB team is going to be moving fast in this space and we’ll be making some additional announcements in the coming months to further evolve this capability.  
MongoDB 团队将在该领域加速推进，未来数月内还将陆续发布更多公告，持续增强并拓展此项能力。

Most importantly though we are extremely excited to stay engaged with the community to ensure we’re providing the capabilities you need, so don’t be a stranger!  
但最重要的是，我们热切期待持续与社区保持紧密互动，确保所提供的功能切实满足您的需求——请随时与我们联系，切勿见外！

A big thank you and shout out to @P-E-B who kicked off the Python implementation and @floomby who started the JavaScript support!  
衷心感谢 @P-E-B 启动了 Python 版本的实现，以及 @floomby 开启了 JavaScript 支持！

### Tags

### 标签

[![NeumAI x LangChain: Efficiently maintaining context in sync for AI applications](images/langchain-mongodb-atlas/img_001.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain: Efficiently maintaining context in sync for AI applications**](https://blog.langchain.com/neum-x-langchain/)

[![Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination](images/langchain-mongodb-atlas/img_002.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[![让数据摄取具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端](images/langchain-mongodb-atlas/img_002.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**让数据摄取具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)


[![Chat with your data using OpenAI, Pinecone, Airbyte and Langchain](images/langchain-mongodb-atlas/img_003.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[![使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话](images/langchain-mongodb-atlas/img_003.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**Chat with your data using OpenAI, Pinecone, Airbyte and Langchain**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)


[**Yeager.ai x LangChain: Exploring GenWorlds a Framework for Coordinating AI Agents**](https://blog.langchain.com/exploring-genworlds/)

[**Yeager.ai × LangChain：探索 GenWorlds——一个用于协调 AI 智能体的框架**](https://blog.langchain.com/exploring-genworlds/)


[![Conversational Retrieval Agents](images/langchain-mongodb-atlas/img_004.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[![对话式检索智能体](images/langchain-mongodb-atlas/img_004.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[**Conversational Retrieval Agents**](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体**](https://blog.langchain.com/conversational-retrieval-agents/)


[**Unifying AI endpoints with Genoss, powered by LangChain**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)

[**借助 LangChain 支持的 Genoss 统一 AI 接口**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)