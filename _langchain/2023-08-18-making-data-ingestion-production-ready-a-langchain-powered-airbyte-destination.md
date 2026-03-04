---
title: "Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination"
source: "LangChain Blog"
url: "https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/"
date: "2023-08-18"
scraped_at: "2026-03-03T09:10:52.097448838+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
&#123;% raw %}

A big focus of ours over the past few months has been enabling teams to go from prototype to production.  
过去几个月，我们的一大工作重心是助力团队将应用从原型阶段推进至生产环境。

To take apps they developed in an hour and get them into a place where they can actually be reliably used.  
让那些在一小时内开发出的应用，真正进入可稳定、可靠使用的生产状态。

Arguably the biggest category of applications LangChain helps enable is retrieval based applications (where you connect LLMs to your own data).  
可以说，LangChain 最主要赋能的应用类型是基于检索的应用（即把大语言模型与您自己的数据连接起来）。

There are a few things that are needed to take retrieval based applications from prototype to production.  
要将基于检索的应用从原型推进到生产环境，需要解决几个关键问题。

One component of that is everything related to the querying of the data.  
其中一项核心环节，是与数据查询相关的一切。

That’s why we launched [LangSmith](https://blog.langchain.com/announcing-langsmith/) \- to help debug and monitor how LLMs interact with the user query as well as the retrieved documents.  
因此我们推出了 [LangSmith](https://blog.langchain.com/announcing-langsmith/)——用于调试和监控大语言模型如何响应用户查询，以及如何与检索出的文档进行交互。

Another huge aspect is the querying algorithms and UX around that - which is why we’re pushing on things like [Conversational Retrieval Agents](https://blog.langchain.com/conversational-retrieval-agents/).  
另一项至关重要的方面，则是查询算法及其用户体验（UX）设计——这也是我们大力推动 [Conversational Retrieval Agents（对话式检索智能体）](https://blog.langchain.com/conversational-retrieval-agents/) 的原因。

(If you are interested in this part in particular, we’re doing a webinar on “ [Advanced Retrieval](https://www.crowdcast.io/c/kqz7nl8nps42?ref=blog.langchain.com)” on August 9th).  
（若您特别关注这一方向，我们将于 8 月 9 日举办一场主题为“[高级检索（Advanced Retrieval）](https://www.crowdcast.io/c/kqz7nl8nps42?ref=blog.langchain.com)”的线上研讨会。）

A third - and arguably the most important part - is the ingestion logic itself.  
第三项——也是 arguably 最重要的一项——则是数据摄入（ingestion）逻辑本身。

When taking an application into production, you want the data it’s connecting to be refreshed on some schedule in a reliable and efficient way.  
当将一个应用投入生产时，您希望它所连接的数据能够以某种周期、可靠且高效地完成刷新。

Our first stab at tackling this is another, deeper integration with Airbyte.  
我们应对这一挑战迈出的第一步，是与 Airbyte 实现更深层次的集成。

The [previous Airbyte integration](https://python.langchain.com/docs/integrations/document_loaders/airbyte_json?ref=blog.langchain.com) showed how to use one of their sources as a Document Loader within LangChain.  
此前的 [Airbyte 集成](https://python.langchain.com/docs/integrations/document_loaders/airbyte_json?ref=blog.langchain.com) 展示了如何将 Airbyte 的某类数据源作为 LangChain 中的 Document Loader（文档加载器）来使用。

This integration goes the other direction, and adds a LangChain destination within Airbyte.  
而本次新集成则反向推进：在 Airbyte 内部新增一个 LangChain 目标端（destination），即 LangChain 向量数据库接收器。

To read more about this integration, you can check out Airbyte’s release blog [here](https://airbyte.com/blog/airbyte-now-supports-vector-databases-powered-by-langchain?ref=blog.langchain.com).  
如需深入了解该集成，请参阅 Airbyte 官方发布的博客文章：[此处](https://airbyte.com/blog/airbyte-now-supports-vector-databases-powered-by-langchain?ref=blog.langchain.com)。

We will try not to repeat too much of that blog, but rather cover why we think this is an important step.  
本文将尽量避免重复该博客内容，而是聚焦阐述：为何我们认为这是一次意义重大的进展。

LangChain provides “sources” and “destinations” of our own - we have hundreds of document loaders and 50+ vectorstore/retriever integrations.  
LangChain 自身已提供丰富的“数据源（sources）”与“目标端（destinations）”——包括数百种文档加载器，以及 50 多种向量数据库/检索器集成。

But far from being replacements for one another, this is rather a mutually beneficial integration that provides a lot of benefits for the community.  
但二者绝非彼此替代关系；相反，这是一次互利共赢的深度协同，将为整个开发者社区带来诸多切实价值。

First, Airbyte provides [hundreds more sources](https://docs.airbyte.com/integrations/?ref=blog.langchain.com), a robust orchestration logic, as well as [tooling](https://docs.airbyte.com/connector-development/connector-builder-ui/overview?ref=blog.langchain.com) to create more sources.  
首先，Airbyte 提供了 [数百种额外的数据源](https://docs.airbyte.com/integrations/?ref=blog.langchain.com)，一套健壮的数据编排（orchestration）逻辑，以及用于快速构建新数据源的 [开发工具](https://docs.airbyte.com/connector-development/connector-builder-ui/overview?ref=blog.langchain.com)。

Let’s focus on the orchestration logic.  
让我们重点关注其编排逻辑。

When you create a chatbot that has access to an index of your data, you don’t just want to index your data there once and forget about it.  
当您构建一个能访问您自有数据索引的聊天机器人时，绝不仅满足于一次性建立索引后便置之不理。

You want to reindex it on some schedule, so that it stays up to date.  
您需要按一定周期自动重新索引，确保数据始终最新、准确。

This type of data pipelines is exactly what Airbyte excels at and has been building.  
这类数据流水线（data pipeline）正是 Airbyte 擅长并长期深耕的核心能力。

Second, the ingestion process isn’t only about moving data from a source to a destination.  
其次，数据摄入过程远不止于将数据从源端搬运至目标端。

There’s also some important, non-trivial and nuanced transformations that are necessary to enable effective retrieval.  
其中还包含若干关键、非平凡且高度精细化的数据转换步骤，它们对实现高效检索至关重要。

Two of the most important - text splitting and embedding.  
其中两项最关键的操作是：文本切分（text splitting）与向量化嵌入（embedding）。

Splitting text is important because you need to create chunks of data to put in the vectorstore.  
文本切分之所以重要，是因为您需要将原始文本切分为多个语义合理的“块（chunks）”，才能存入向量数据库。

You want these chunks to be semantically meaningful by themselves - so that they make sense when retrieved.  
您期望每个文本块自身具备独立、完整的语义——这样在被检索出来时，才能真正可理解、可使用。

This is why it’s often a bit trickier than just splitting a text every 1000 characters.  
正因如此，文本切分往往比简单地每 1000 字符切一刀要复杂得多。

LangChain provides implementations of 15+ different ways to split text, powered by different algorithms and optimized for different text types (markdown vs Python code, etc).  
LangChain 已内置 15 种以上文本切分方法的实现，由不同算法驱动，并针对各类文本（如 Markdown、Python 代码等）做了专门优化。

To assist in the exploration of what these different text splitters offer, we've [open-source](https://github.com/langchain-ai/text-split-explorer?ref=blog.langchain.com) and [hosted](https://langchain-text-splitter.streamlit.app/?ref=blog.langchain.com) a playground for easy exploration.  
为帮助大家直观对比不同切分器的效果，我们已将文本切分探索工具 [开源](https://github.com/langchain-ai/text-split-explorer?ref=blog.langchain.com)，并 [在线部署](https://langchain-text-splitter.streamlit.app/?ref=blog.langchain.com) 供随时体验。

Embeddings are important to enable retrieval of those chunks, which is often done by comparing embeddings of a user query to embeddings of ingested documents.  
嵌入向量（embeddings）对于实现这些文本块的有效检索至关重要——通常通过比对用户查询的嵌入向量与已摄入文档的嵌入向量来完成检索。

There are many different embedding providers and hosting platforms - and LangChain provides integrations with 50+ of them.  
目前市场上存在众多嵌入服务提供商与托管平台；LangChain 已与其中 50 多家实现了开箱即用的集成。

Overall, we’re really excited about this LangChain - Airbyte integration.  
总体而言，我们对此次 LangChain × Airbyte 的联合集成感到无比振奋。

It provides robust orchestration and scheduling for ingestion jobs while leveraging LangChain’s transformation logic and integrations.  
它既借助 Airbyte 提供强大可靠的数据摄入任务编排与调度能力，又深度融合 LangChain 在数据转换逻辑与生态集成方面的深厚积累。

We also think there’s more features (and integrations) to add to make data ingestion production ready - keep on the lookout for more of those over the next few weeks.  
我们也相信，要真正实现生产就绪（production-ready）的数据摄入能力，还需持续补充更多功能与集成——敬请关注未来几周内陆续推出的重磅更新！

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain《2024 年人工智能现状》报告](images/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![借助 LangSmith SDK v0.2 实现更便捷的评估](images/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**借助 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph Platform 进入 Beta 测试阶段：面向可扩展智能体基础设施的新部署选项](images/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform 进入 Beta 测试阶段：面向可扩展智能体基础设施的新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟
&#123;% endraw %}
