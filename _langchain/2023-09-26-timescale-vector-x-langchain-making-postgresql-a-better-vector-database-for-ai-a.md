---
title: "Timescale Vector x LangChain: Making PostgreSQL A Better Vector Database for AI Applications"
source: "LangChain Blog"
url: "https://blog.langchain.com/timescale-vector-x-langchain-making-postgresql-a-better-vector-database-for-ai-applications/"
date: "2023-09-26"
scraped_at: "2026-03-03T08:41:11.182688689+00:00"
language: "en-zh"
translated: true
---
{% raw %}

_Editor's Note: This post was written in collaboration with the Timescale Vector team. Their integration with LangChain supports PostgreSQL as your vector database for faster similarity search, time-based context retrieval for RAG, and self-querying capabilities. And they're [offering a free 90 day trial!](https://console.cloud.timescale.com/signup?utm_campaign=vectorlaunch&utm_source=langchain&utm_medium=referral)_

_编辑注：本文由 LangChain 团队与 Timescale Vector 团队联合撰写。Timescale Vector 与 LangChain 的集成支持将 PostgreSQL 作为您的向量数据库，从而实现更快的相似性搜索、面向 RAG 的基于时间的上下文检索，以及自查询（self-querying）能力。目前他们正[提供为期 90 天的免费试用！](https://console.cloud.timescale.com/signup?utm_campaign=vectorlaunch&utm_source=langchain&utm_medium=referral)_

Introducing the [Timescale Vector](https://www.timescale.com/ai?ref=blog.langchain.com) integration for LangChain. Timescale Vector enables LangChain developers to build better AI applications with PostgreSQL as their vector database: with faster vector similarity search, efficient time-based search filtering, and the operational simplicity of a single, easy-to-use cloud PostgreSQL database for not only vector embeddings, but an AI application’s relational and time-series data too.

隆重推出 [Timescale Vector](https://www.timescale.com/ai?ref=blog.langchain.com) 与 LangChain 的集成。Timescale Vector 使 LangChain 开发者能够以 PostgreSQL 作为向量数据库，构建更出色的 AI 应用：不仅支持更快的向量相似性搜索与高效的时间维度搜索过滤，还凭借单一、易用的云托管 PostgreSQL 数据库，为 AI 应用同时承载向量嵌入（vector embeddings）、关系型数据和时序数据，显著简化运维复杂度。

PostgreSQL is the world’s most loved database, according to the [Stack Overflow 2023 Developer Survey](https://survey.stackoverflow.co/2023/?ref=blog.langchain.com#section-most-popular-technologies-databases). And for a good reason: it’s been battle-hardened by production use for over three decades, it’s robust and reliable, and it has a rich ecosystem of tools, drivers, and connectors.

根据 [Stack Overflow 2023 年开发者调查报告](https://survey.stackoverflow.co/2023/?ref=blog.langchain.com#section-most-popular-technologies-databases)，PostgreSQL 是全球最受开发者喜爱的数据库。这绝非偶然：它已在生产环境中历经三十余年实战锤炼，具备极高的稳定性与可靠性，并拥有丰富完善的工具链、驱动程序与连接器生态。

And while pgvector, the open-source extension for vector data on PostgreSQL, is a wonderful extension (and is offered as part of Timescale Vector), it is just one piece of the puzzle in providing a production-grade experience for AI application developers on PostgreSQL. After speaking with numerous developers at nimble startups and established industry giants, we saw the need to enhance pgvector to cater to the performance and operational needs of developers building AI applications.

尽管 pgvector —— PostgreSQL 上用于向量数据的开源扩展 —— 是一款极为出色的工具（且已作为 Timescale Vector 的一部分提供），但它仅是构建面向 AI 应用开发者的、企业级 PostgreSQL 向量数据库体验中的一环。在与众多敏捷初创公司及成熟行业巨头的开发者深入交流后，我们意识到：必须对 pgvector 进行增强，以切实满足 AI 应用开发者在性能与运维方面提出的更高要求。

Here’s the TL;DR on how Timescale Vector helps you build better AI applications with LangChain:

以下是 Timescale Vector 如何助力您借助 LangChain 构建更优 AI 应用的简明概览（TL;DR）：

- **Faster similarity search on millions of vectors:** Thanks to the introduction of a new search index inspired by the DiskANN algorithm, [Timescale Vector achieves 243% faster search speed at ~99 % recall than Weaviate, a specialized database,](https://www.timescale.com/blog/how-we-made-postgresql-the-best-vector-database/?utm_campaign=vectorlaunch&utm_source=langchain&utm_medium=referral) and outperforms all existing PostgreSQL search indexes by between 39.39% and 1,590.33% on a dataset of one million OpenAI embeddings. Plus, enabling product quantization yields a [10x index space savings compared to pgvector](https://www.timescale.com/blog/how-we-made-postgresql-the-best-vector-database/?utm_campaign=vectorlaunch&utm_source=langchain&utm_medium=referral). Timescale Vector also offers pgvector’s Hierarchical Navigable Small Worlds (HNSW) and Inverted File Flat (IVFFlat) indexing algorithms.

- **千万级向量上的更快相似性搜索：** 得益于一种受 DiskANN 算法启发而全新设计的搜索索引，[Timescale Vector 在约 99% 召回率下，搜索速度比专用向量数据库 Weaviate 快 243%](https://www.timescale.com/blog/how-we-made-postgresql-the-best-vector-database/?utm_campaign=vectorlaunch&utm_source=langchain&utm_medium=referral)；在包含一百万条 OpenAI 嵌入向量的数据集上，其性能较所有现有 PostgreSQL 搜索索引提升幅度达 39.39% 至 1590.33%。此外，启用乘积量化（product quantization）后，索引存储空间可[相比 pgvector 减少 10 倍](https://www.timescale.com/blog/how-we-made-postgresql-the-best-vector-database/?utm_campaign=vectorlaunch&utm_source=langchain&utm_medium=referral)。Timescale Vector 同样支持 pgvector 提供的分层可导航小世界（HNSW）与倒排文件平面（IVFFlat）索引算法。

- **Similarity search with efficient time-based filtering:** Timescale Vector optimizes time-based vector search, leveraging the automatic time-based partitioning and indexing of [Timescale’s hypertables](https://docs.timescale.com/use-timescale/latest/hypertables/?ref=blog.langchain.com) to efficiently find recent embeddings, constrain vector search by a time range or document age, and store and retrieve large language model (LLM) response and chat history with ease. Time-based semantic search also enables you to use Retrieval Augmented Generation (RAG) with time-based context retrieval to give users more useful LLM responses.

- **支持高效时间过滤的相似性搜索：** Timescale Vector 对基于时间的向量搜索进行了深度优化，充分利用 [Timescale 超表（hypertables）](https://docs.timescale.com/use-timescale/latest/hypertables/?ref=blog.langchain.com) 所提供的自动按时间分区与索引能力，从而高效定位最新嵌入向量、按时间范围或文档时效性约束向量搜索，并轻松存储与检索大语言模型（LLM）响应及对话历史。基于时间的语义搜索，还可赋能 Retrieval Augmented Generation（RAG）实现“基于时间的上下文检索”，为用户提供更具实用价值的 LLM 回答。

- **Simplified AI infra stack:** By combining vector embeddings, relational data, and time-series data in one PostgreSQL database, Timescale Vector eliminates the operational complexity that comes with managing multiple database systems at scale.

- **简化的 AI 基础设施栈：** Timescale Vector 将向量嵌入、关系型数据与时序数据统一整合于单个 PostgreSQL 数据库之中，彻底消除了大规模部署中需运维多个数据库系统所带来的复杂性。

- **Simplified metadata handling and multi-attribute filtering:** You can leverage all PostgreSQL data types to store and filter metadata, and JOIN vector search results with relational data for more contextually relevant responses. In future releases, Timescale Vector will also support rich multi-attribute filtering, enabling even faster similarity searches when filtering on metadata.

- **简化的元数据管理与多属性过滤：** 您可充分利用 PostgreSQL 全系列数据类型来存储与过滤元数据，并通过 JOIN 将向量搜索结果与关系型数据关联，从而生成上下文更相关、语义更丰富的响应。在后续版本中，Timescale Vector 还将支持功能完备的多属性过滤能力，进一步加速基于元数据条件的相似性搜索。

On top of these innovations for vector workloads, Timescale Vector provides a robust, production-ready PostgreSQL platform with flexible pricing, enterprise-grade security, and free expert support.

除上述面向向量工作负载的关键创新外，Timescale Vector 还提供一个稳健可靠、开箱即用的企业级 PostgreSQL 平台，具备灵活的定价方案、企业级安全防护，以及免费的专业技术支持。

In the rest of this post, we’ll dive deeper (with code!) into the unique capabilities Timescale Vector enables for developers wanting to use PostgreSQL as their vector database with LangChain:

在本文后续部分，我们将（附带完整代码！）深入探讨 Timescale Vector 为希望将 PostgreSQL 作为向量数据库与 LangChain 协同使用的开发者所解锁的独特能力：

- Faster similarity search with DiskANN, HNSW and IVFFlat index types.  
- 使用 DiskANN、HNSW 与 IVFFlat 等多种索引类型实现更快的相似性搜索。

- Efficient similarity search when filtering vectors by time.  
- 按时间维度过滤向量时的高效相似性搜索。

- Retrieval Augmented Generation (RAG) with time-based context retrieval.  
- 支持基于时间的上下文检索的检索增强生成（RAG）。

- Advanced self-querying capabilities.  
- 高级自查询（self-querying）能力。

(If you’d prefer to jump into the code, explore [this tutorial](https://python.langchain.com/docs/integrations/vectorstores/timescalevector?ref=blog.langchain.com)).

（若您希望直接动手实践，请参阅 [本教程](https://python.langchain.com/docs/integrations/vectorstores/timescalevector?ref=blog.langchain.com)）。

**🎉** [**LangChain 用户可免费获得 3 个月 Timescale Vector 服务**](https://console.cloud.timescale.com/signup?utm_campaign=vectorlaunch&utm_source=langchain&utm_medium=referral)

**🎉** [**LangChain 用户可免费获得 3 个月 Timescale Vector 服务**](https://console.cloud.timescale.com/signup?utm_campaign=vectorlaunch&utm_source=langchain&utm_medium=referral)

Timescale 正为 LangChain 用户提供长达 90 天的 Timescale Vector 免费试用期。这使您能轻松测试和开发基于 Timescale Vector 的应用——在试用期内，您所创建的任何云 PostgreSQL 数据库均不产生费用。[立即免费试用 Timescale Vector](https://console.cloud.timescale.com/signup?utm_campaign=vectorlaunch&utm_source=langchain&utm_medium=referral)。

Timescale 正为 LangChain 用户提供长达 90 天的 Timescale Vector 免费试用期。这使您能轻松测试和开发基于 Timescale Vector 的应用——在试用期内，您所创建的任何云 PostgreSQL 数据库均不产生费用。[立即免费试用 Timescale Vector](https://console.cloud.timescale.com/signup?utm_campaign=vectorlaunch&utm_source=langchain&utm_medium=referral)。

# Faster Vector Similarity Search in PostgreSQL

# PostgreSQL 中更快的向量相似性搜索

Timescale Vector 通过引入一种受 [DiskANN](https://www.microsoft.com/en-us/research/publication/diskann-fast-accurate-billion-point-nearest-neighbor-search-on-a-single-node/?ref=blog.langchain.com) 算法启发的、业界领先的近似最近邻（ANN）索引，显著加速了大规模向量数据集上的近似最近邻（ANN）搜索，从而增强了 pgvector 的能力。Timescale Vector 同样支持 pgvector 提供的 HNSW 和 IVFFlat 索引算法，让开发者能够根据具体应用场景灵活选择最合适的索引类型。

Timescale Vector 通过引入一种受 [DiskANN](https://www.microsoft.com/en-us/research/publication/diskann-fast-accurate-billion-point-nearest-neighbor-search-on-a-single-node/?ref=blog.langchain.com) 算法启发的、业界领先的近似最近邻（ANN）索引，显著加速了大规模向量数据集上的近似最近邻（ANN）搜索，从而增强了 pgvector 的能力。Timescale Vector 同样支持 pgvector 提供的 HNSW 和 IVFFlat 索引算法，让开发者能够根据具体应用场景灵活选择最合适的索引类型。

我们使用 [ANN benchmarks](https://github.com/erikbern/ann-benchmarks/?ref=blog.langchain.com) 套件进行的性能基准测试表明：在 100 万条 OpenAI 嵌入构成的数据集上，Timescale Vector 在约 99% 召回率下，其搜索速度比所有现有 PostgreSQL 搜索索引快 39.43% 至 1590.33%，且比 Weaviate 等专用向量数据库快 243.77%。您可[在此处详细了解性能基准测试的方法论与结果](https://www.timescale.com/blog/how-we-made-postgresql-the-best-vector-database/?utm_campaign=vectorlaunch&utm_source=langchain&utm_medium=referral)。

我们使用 [ANN benchmarks](https://github.com/erikbern/ann-benchmarks/?ref=blog.langchain.com) 套件进行的性能基准测试表明：在 100 万条 OpenAI 嵌入构成的数据集上，Timescale Vector 在约 99% 召回率下，其搜索速度比所有现有 PostgreSQL 搜索索引快 39.43% 至 1590.33%，且比 Weaviate 等专用向量数据库快 243.77%。您可[在此处详细了解性能基准测试的方法论与结果](https://www.timescale.com/blog/how-we-made-postgresql-the-best-vector-database/?utm_campaign=vectorlaunch&utm_source=langchain&utm_medium=referral)。

![](https://lh3.googleusercontent.com/ESs73TJ4vXgthy9CL1y94rTOF5SK87iqEJum2zchQKkS7dnyXik0gVWmEvkarbP77zI7_Ft8KZEMz0CvUatuKnyH6vbWFon551PvW89_Hs3IFUx2Nm0rwqYGU-cFRuUBjrAoP872AycZsHiOCQvwcPw)

_图注：Timescale Vector 新增的索引在对 100 万条 OpenAI 嵌入执行 99% 召回率下的近似最近邻搜索时，性能比专用向量数据库 Weaviate 高出 243%，且优于所有现有 PostgreSQL 索引类型。_

_图注：Timescale Vector 新增的索引在对 100 万条 OpenAI 嵌入执行 99% 召回率下的近似最近邻搜索时，性能比专用向量数据库 Weaviate 高出 243%，且优于所有现有 PostgreSQL 索引类型。_

在 LangChain 中使用 Timescale Vector 的 DiskANN、HNSW 或 IVFFLAT 索引极为简单直接。

只需按如下方式创建一个 Timescale Vector 向量存储：

在 LangChain 中使用 Timescale Vector 的 DiskANN、HNSW 或 IVFFLAT 索引极为简单直接。

只需按如下方式创建一个 Timescale Vector 向量存储：

```
from langchain.vectorstores.timescalevector import TimescaleVector
```

# Create a Timescale Vector instance from the collection of documents  
# 从文档集合创建一个 Timescale Vector 实例

```python
db = TimescaleVector.from_documents(
   embedding=embeddings,
   documents=docs,
   collection_name=COLLECTION_NAME,
   service_url=SERVICE_URL,
)
```

```

And then run:  
然后运行：

```
# create an index  
# by default this will create a Timescale Vector (DiskANN) index  
# 创建索引  
# 默认情况下，这将创建一个 Timescale Vector（DiskANN）索引  
db.create_index()
```

This will create a timescale-vector index with the default parameters.  
这将使用默认参数创建一个 timescale-vector 索引。

We should point out that the term “index” is a bit overloaded. For many vector databases, an index is the thing that stores your data (in relational databases this is often called a table), but in the PostgreSQL world an index is something that speeds up search, and we are using the latter meaning here.  
需要特别说明的是，“index”（索引）一词在此处存在语义过载。在许多向量数据库中，“index”指代存储数据的结构（在关系型数据库中通常称为“表”），但在 PostgreSQL 语境中，“index”特指用于加速查询的辅助数据结构；本文采用的是后一种含义。

We can also specify the exact parameters for index creation in the `create_index` command as follows:  
我们还可以在 `create_index` 命令中显式指定索引创建的具体参数，如下所示：

```
# create an timescale vector index (DiskANN) with specified parameters  
# 使用指定参数创建一个 Timescale Vector（DiskANN）索引  
db.create_index(index_type="tsv", max_alpha=1.0, num_neighbors=50)
```

Advantages to this Timescale Vector’s new DiskANN-inspired vector search index include the following:  
Timescale Vector 这一受 DiskANN 启发的新向量搜索索引具备以下优势：

- Faster vector search at high accuracy in PostgreSQL.  
  - 在 PostgreSQL 中实现高精度下的更快向量搜索。  
- Optimized for running on disks, not only in memory use.  
  - 针对磁盘运行进行了优化，而不仅限于内存使用。  
- Quantization optimization compatible with PostgreSQL, reducing the vector size and consequently shrinking the index size ( [by 10x in some cases](https://www.timescale.com/blog/how-we-made-postgresql-the-best-vector-database/?utm_campaign=vectorlaunch&utm_source=llamaindex&utm_medium=referral)!) and expediting searches.  
  - 支持与 PostgreSQL 兼容的量化优化，可减小向量尺寸，从而显著缩小索引体积（[某些场景下可达 10 倍压缩](https://www.timescale.com/blog/how-we-made-postgresql-the-best-vector-database/?utm_campaign=vectorlaunch&utm_source=llamaindex&utm_medium=referral)！），并加快搜索速度。  
- Efficient hybrid search or filtering additional dimensions.  
  - 支持高效的混合搜索（hybrid search），或对额外维度进行过滤。

For more on DiskANN and how Timescale Vector’s new index works, [see this blog post](https://www.timescale.com/blog/how-we-made-postgresql-the-best-vector-database/?utm_campaign=vectorlaunch&utm_source=langchain&utm_medium=referral).  
如需深入了解 DiskANN 及 Timescale Vector 新索引的工作原理，[请参阅这篇博客文章](https://www.timescale.com/blog/how-we-made-postgresql-the-best-vector-database/?utm_campaign=vectorlaunch&utm_source=langchain&utm_medium=referral)。

Pgvector is packaged as part of Timescale Vector, so you can also access pgvector’s HNSW and IVFFLAT indexing algorithms in your LangChain applications. The ability to conveniently create database indexes from your LangChain application code makes it easy to create different indexes and compare their performance.

Pgvector 作为 Timescale Vector 的一部分进行打包发布，因此您也可以在 LangChain 应用中直接使用 pgvector 提供的 HNSW 和 IVFFLAT 索引算法。通过 LangChain 应用代码便捷地创建数据库索引，使您能够轻松构建多种索引并对比其性能表现。

```
# Create an HNSW index.
# Note: you don't need to specify m and ef_construction parameters as we set smart defaults.
db.create_index(index_type="hnsw", m=16, ef_construction=64)

# Create an IVFFLAT index
# Note:you don't need to specify num_lists and num_records parameters as we set smart defaults.
db.create_index(index_type="ivfflat", num_lists=20, num_records=1000)
```

```
# 创建一个 HNSW 索引。
# 注意：无需显式指定 m 和 ef_construction 参数，因为我们已预设了智能默认值。
db.create_index(index_type="hnsw", m=16, ef_construction=64)

# 创建一个 IVFFLAT 索引。
# 注意：无需显式指定 num_lists 和 num_records 参数，因为我们已预设了智能默认值。
db.create_index(index_type="ivfflat", num_lists=20, num_records=1000)
```

# Add Efficient Time-Based Search Functionality to Your LangChain AI Application

# 为您的 LangChain AI 应用添加高效的时间感知搜索功能

Timescale Vector optimizes time-based vector search, leveraging the automatic time-based partitioning and indexing of [Timescale’s hypertables](https://docs.timescale.com/use-timescale/latest/hypertables/?ref=blog.langchain.com) to efficiently search vectors by time and similarity.

Timescale Vector 针对“时间感知”的向量搜索进行了深度优化，充分利用 [Timescale 超表（hypertables）](https://docs.timescale.com/use-timescale/latest/hypertables/?ref=blog.langchain.com) 所提供的自动按时间分区与索引能力，从而实现对向量数据既按时间、又按语义相似度的高效检索。

Time is often an important metadata component for vector embeddings. Sources of embeddings, like documents, images, and web pages, often have a timestamp associated with them, for example, their creation date, publishing date, or the date they were last updated, to name but a few.

时间通常是向量嵌入（vector embeddings）中一项至关重要的元数据维度。各类嵌入来源——如文档、图像、网页等——通常都附带时间戳信息，例如创建时间、发布时间或最后更新时间等。

We can take advantage of this time metadata in our collections of vector embeddings to enrich the quality and applicability of search results by retrieving vectors that are not just semantically similar but also pertinent to a specific time frame.

我们可在向量嵌入集合中充分利用此类时间元数据，不仅检索语义上相似的向量，更进一步限定其所属的时间范围，从而显著提升搜索结果的质量与实际适用性。

Here are some examples where time-based retrieval of vectors can improve your LangChain applications:

以下是一些时间感知向量检索可增强 LangChain 应用效果的典型场景：

- **Chat history:** Storing and retrieving LLM response history. For example, chatbot chat history.  
- **聊天历史记录**：存储与检索大语言模型（LLM）的历史响应。例如，聊天机器人对话历史。

- **Finding recent embeddings:** Finding the most recent embeddings similar to a query vector. For example, finding the most recent news, documents, or social media posts related to elections.  
- **检索最新嵌入**：查找与查询向量最相似且时间最近的嵌入。例如，检索与选举主题相关的最新新闻、文档或社交媒体帖子。

- **Search within a time range:** Constraining similarity search to only vectors within a relevant time range. For example, asking time-based questions about a knowledge base (“What new features were added between January and March 2023?”).  
- **限定时间范围内的搜索**：将相似度搜索约束在特定相关时间段内。例如，针对知识库提出基于时间的问题（“2023 年 1 月至 3 月期间新增了哪些功能？”）。

Let’s look at an example of performing time-based searches on a [git log dataset](https://chat.openai.com/share/0612295b-a408-4e02-9ac2-3dc231fa89d1?ref=blog.langchain.com). In a git log, each entry has a timestamp, an author, and some information about the commit.

下面我们以一个 [git 日志数据集](https://chat.openai.com/share/0612295b-a408-4e02-9ac2-3dc231fa89d1?ref=blog.langchain.com) 为例，演示如何执行时间感知搜索。在 git 日志中，每条记录均包含一个时间戳、作者信息以及关于该次提交的简要说明。

To illustrate how to use TimescaleVector's time-based vector search functionality, we'll ask questions about the git log history for TimescaleDB. Each git commit entry has a timestamp associated with it, as well as a message and other metadata (e.g., author).

为说明如何使用 TimescaleVector 的基于时间的向量搜索功能，我们将围绕 TimescaleDB 的 Git 日志历史提出若干问题。每条 Git 提交记录均附带一个时间戳，以及提交信息和其他元数据（例如作者）。

### Load text and extract metadata

### 加载文本并提取元数据

First, we load in the git log using LangChain’s [JSON Loader](https://python.langchain.com/docs/modules/data_connection/document_loaders/json?ref=blog.langchain.com).

首先，我们使用 LangChain 的 [JSON Loader](https://python.langchain.com/docs/modules/data_connection/document_loaders/json?ref=blog.langchain.com) 加载 Git 日志。

```
# Load data from JSON file and extract metadata
loader = JSONLoader(
   file_path=FILE_PATH,
   jq_schema='.commit_history[]',
   text_content=False,
   metadata_func=extract_metadata
)
documents = loader.load()
```

```
# 从 JSON 文件加载数据并提取元数据
loader = JSONLoader(
   file_path=FILE_PATH,
   jq_schema='.commit_history[]',
   text_content=False,
   metadata_func=extract_metadata
)
documents = loader.load()
```

Notice how we provide a function named \`extract\_metadata\` as an argument to the JSONLoader. This function enables us to store not just the contents of the JSON in vectorized form but metadata about an embedding. It is in this function that we’ll specify the timestamp of the git log entry to be used in our time-based vector search.

请注意，我们将一个名为 \`extract\_metadata\` 的函数作为参数传入 JSONLoader。该函数不仅支持将 JSON 内容以向量化形式存储，还能同时保存与嵌入向量相关的元数据。正是在此函数中，我们将指定 Git 日志条目的时间戳，以便在后续基于时间的向量搜索中使用。

### Create time-based identifiers for Documents

### 为 Document 创建基于时间的标识符

For time-based search in LangChain, Timescale Vector uses the ‘datetime’ portion of a UUID v1 to place vectors in the correct time partition. [Timescale Vector’s Python client library](https://github.com/timescale/python-vector?ref=blog.langchain.com) provides a simple-to-use function named \`uuid\_from\_time\` to create a UUID v1 from a Python \`datetime\` object, which you can then pass to the Timescale Vector vector store constructor as we’ll see in the code snippet further down. Here’s how we use the \`uuid\_from\_time\` helper functions:

在 LangChain 中实现基于时间的搜索时，Timescale Vector 利用 UUID v1 的“datetime”部分，将向量分配至正确的时间分区。[Timescale Vector 的 Python 客户端库](https://github.com/timescale/python-vector?ref=blog.langchain.com) 提供了一个便捷易用的辅助函数 \`uuid\_from\_time\`，可将 Python 的 \`datetime\` 对象转换为 UUID v1；随后，您可将该 UUID 传入 Timescale Vector 向量存储的构造函数中（详见后文代码片段）。以下是如何使用 \`uuid\_from\_time\` 辅助函数的示例：

```
from timescale_vector import client
# Function to take in a date string in the past and return a uuid v1
def create_uuid(date_string: str):
   if date_string is None:
       return None
   time_format = '%a %b %d %H:%M:%S %Y %z'
   datetime_obj = datetime.strptime(date_string, time_format)
   uuid = client.uuid_from_time(datetime_obj)
   return str(uuid)
```

```
from timescale_vector import client
# 函数：接收一个过去日期的字符串，返回一个 UUID v1
def create_uuid(date_string: str):
   if date_string is None:
       return None
   time_format = '%a %b %d %H:%M:%S %Y %z'
   datetime_obj = datetime.strptime(date_string, time_format)
   uuid = client.uuid_from_time(datetime_obj)
   return str(uuid)
```

Here’s the \`extract\_metdata()\` function we pass to the JSONLoader specifying the fields we want in the metadata for each vector embedding in our vector collection:

以下是传递给 JSONLoader 的 \`extract\_metadata()\` 函数，用于指定向量集合中每个向量嵌入所应包含的元数据字段：

```
# Metadata extraction function to extract metadata from a JSON record
def extract_metadata(record: dict, metadata: dict) -> dict:
   record_name, record_email = split_name(record["author"])
   metadata["id"] = create_uuid(record["date"])
   metadata["date"] = create_date(record["date"])
   metadata["author_name"] = record_name
   metadata["author_email"] = record_email
   metadata["commit_hash"] = record["commit"]
   return metadata
```

```
# 元数据提取函数：从 JSON 记录中提取元数据
def extract_metadata(record: dict, metadata: dict) -> dict:
   record_name, record_email = split_name(record["author"])
   metadata["id"] = create_uuid(record["date"])
   metadata["date"] = create_date(record["date"])
   metadata["author_name"] = record_name
   metadata["author_email"] = record_email
   metadata["commit_hash"] = record["commit"]
   return metadata
```

**Note:** The code above references two helper functions to get things in the right format (`split_name()` and `create_date()`) which we’ve omitted for brevity. The full code is included in the tutorial linked in the Resources section at the end of this post.

**注意：** 上述代码引用了两个辅助函数（`split_name()` 和 `create_date()`），用于将数据转换为正确格式；为简洁起见，此处省略其实现。完整代码详见本文末尾“资源”（Resources）部分所链接的教程。

Next, we'll create a Timescale Vector instance from the collection of documents we loaded into the JSONLoader above.

接下来，我们将基于上文通过 `JSONLoader` 加载的文档集合，创建一个 Timescale Vector 实例。

### Load vectors and metadata into Timescale Vector

### 将向量与元数据加载至 Timescale Vector

Finally, we'll create the Timescale Vector instance from the set of documents we loaded in.

最后，我们将基于上文已加载的文档集，创建 Timescale Vector 实例。

To take advantage of Timescale Vector’s efficient time-based search, we need to specify the `time_partition_interval` argument when creating a Timescale Vector vector store. This argument represents the length of each interval for partitioning the data by time. Each partition will consist of data that falls within the specified length of time.

为充分利用 Timescale Vector 高效的基于时间的检索能力，在创建 Timescale Vector 向量存储时，需指定 `time_partition_interval` 参数。该参数定义了按时间划分数据时每个分区的时间跨度；每个分区将包含落在该时间长度范围内的数据。

In the example below, we use seven days for simplicity, but you can pick whatever value makes sense for your use case—for example, if you query recent vectors frequently, you might want to use a smaller time delta (like one day), or if you query vectors over a decade-long time period, then you might want to use a larger time delta like six months or one year. As a rule of thumb, common queries should touch only a couple of partitions and at the same time your full dataset should fit within a 1000 partitions, but don’t stress too much – the system is not very sensitive to this value.

下方示例中，我们为简化起见采用七天作为时间间隔；但您可根据实际使用场景灵活选择——例如，若频繁查询近期向量，可选用更小的时间粒度（如一天）；若需在长达十年的时间范围内查询向量，则可选用更大的时间粒度（如六个月或一年）。经验法则是：常见查询应仅涉及少数几个分区，同时整个数据集应能容纳于约 1000 个分区以内；不过无需过度担忧——该系统对这一参数值并不十分敏感。

We specify the `ids` argument to be a list of the UUID v1s we created in the pre-processing step above and stored in the ID field of our metadata. We do this because we want the time part of our UUIDs to reflect past dates. If we want the current date and time to be associated with our document, we can remove the `id` argument, and UUIDs will be automatically created with the current date and time.

我们将 `ids` 参数指定为上述预处理步骤中生成、并存于元数据 `ID` 字段中的 UUID v1 的列表。这样做的目的是使 UUID 中的时间戳部分准确反映文档的历史时间。若您希望文档关联当前日期与时间，则可省略 `id` 参数，系统将自动生成以当前时间戳为基础的 UUID。

```
# Define collection name
COLLECTION_NAME = "timescale_commits"
embeddings = OpenAIEmbeddings()

# Create a Timescale Vector instance from the collection of documents
db = TimescaleVector.from_documents(
     embedding=embeddings,
     ids = [doc.metadata["id"] for doc in docs],
     documents=docs,
     collection_name=COLLECTION_NAME,
     service_url=SERVICE_URL,
     time_partition_interval=timedelta(days = 7),)
```

```
# 定义集合名称
COLLECTION_NAME = "timescale_commits"
embeddings = OpenAIEmbeddings()

# 基于文档集合创建 Timescale Vector 实例
db = TimescaleVector.from_documents(
     embedding=embeddings,
     ids = [doc.metadata["id"] for doc in docs],
     documents=docs,
     collection_name=COLLECTION_NAME,
     service_url=SERVICE_URL,
     time_partition_interval=timedelta(days = 7),)
```

### Efficient similarity search with time filters

### 带时间过滤器的高效相似性搜索

Now that we’ve loaded our vector data and metadata into a Timescale Vector vector store, and enabled automatic time-based partitioning on the table our vectors and metadata are stored in, we can query our vector store with time-based filters as follows:

在将向量数据和元数据加载到 Timescale Vector 向量存储中，并对存储向量及元数据的表启用自动基于时间的分区后，我们可以按如下方式使用基于时间的过滤器查询该向量存储：

```
start_dt = datetime(2023, 8, 1, 22, 10, 35)
end_dt = datetime(2023, 8, 30, 22, 10, 35)
query = "What's new with TimescaleDB functions?"
```

```
docs_with_score = db.similarity_search_with_score(query, start_date=start_dt, end_date=end_dt)
```

```
--------------------------------------------------------------------------------
Score:  0.17487859725952148
Date:  Tue Aug 29 18:13:24 2023 +0200
{"commit": " e4facda540286b0affba47ccc63959fefe2a7b26", "author": "Sven Klemm<sven@timescale.com>", "date": "Tue Aug 29 18:13:24 2023 +0200", "change summary": "Add compatibility layer for _timescaledb_internal functions", "change details": "With timescaledb 2.12 ..."}
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
Score:  0.17487859725952148
Date:  Tue Aug 29 18:13:24 2023 +0200
{"commit": " e4facda540286b0affba47ccc63959fefe2a7b26", "author": "Sven Klemm<sven@timescale.com>", "date": "Tue Aug 29 18:13:24 2023 +0200", "change summary": "Add compatibility layer for _timescaledb_internal functions", "change details": "With timescaledb 2.12 all the functions... "}
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
Score:  0.18100780248641968
Date:  Sun Aug 20 22:47:10 2023 +0200
{"commit": " 0a66bdb8d36a1879246bd652e4c28500c4b951ab", "author": "Sven Klemm<sven@timescale.com>", "date": "Sun Aug 20 22:47:10 2023 +0200", "change summary": "Move functions to _timescaledb_functions schema", "change details": "To increase schema security we do ..."}
--------------------------------------------------------------------------------
```

Success! Notice how only vectors with timestamps within the specified start and end date ranges of 1 August 2023 and 30 August 2023 are included in the results.

成功！请注意，结果中仅包含时间戳落在指定起止日期范围（即 2023 年 8 月 1 日至 2023 年 8 月 30 日）内的向量。

We can also specify a time filter with a provided start date and time delta later:

我们还可以通过指定一个起始日期及之后的时间偏移量（`time_delta`）来设置时间过滤器：

```
start_dt = datetime(2023, 8, 1, 22, 10, 35)
td = timedelta(days=7)
query = "What's new with TimescaleDB functions?"

docs_with_score = db.similarity_search_with_score(query, start_date=start_dt, time_delta=td)
```

And specify a time filter within a provided end\_date and time delta earlier:

也可通过指定一个截止日期及之前的时间偏移量（`time_delta`）来设置时间过滤器：

```
end_dt = datetime(2023, 8, 30, 22, 10, 35)
td = timedelta(days=7)
query = "What's new with TimescaleDB functions?"
```

```python
docs_with_score = db.similarity_search_with_score(query, end_date=end_dt, time_delta=td)
```

### What’s happening behind the scenes

### 幕后发生了什么

Here’s some intuition for why Timescale Vector’s time-based partitioning speeds up ANN queries with time-based filters:

以下是对 Timescale Vector 基于时间的分区机制为何能加速带时间过滤条件的近似最近邻（ANN）查询的直观解释：

Timescale Vector partitions the data by time and creates ANN indexes on each partition individually. Then, during search, we perform a three-step process:

Timescale Vector 按时间对数据进行分区，并在每个分区上单独构建 ANN 索引。在查询执行时，我们按以下三步进行：

- Step 1: filter our partitions that don’t match the time predicate.  
- 步骤 1：筛选出不满足时间谓词（time predicate）的分区并排除。

- Step 2: perform the similarity search on all matching partitions.  
- 步骤 2：仅在所有满足时间条件的分区上执行相似性搜索。

- Step 3: combine all the results from each partition in step 2, rerank, and filter out results by time.  
- 步骤 3：合并步骤 2 中各分区返回的所有结果，重新排序（rerank），并按时间进一步过滤结果。

Timescale Vector leverages [TimescaleDB’s hypertables](https://docs.timescale.com/use-timescale/latest/hypertables/?ref=blog.langchain.com), which automatically partition vectors and associated metadata by a timestamp. This enables efficient querying on vectors by both similarity to a query vector and time, as partitions not in the time window of the query are ignored, making the search a lot more efficient by filtering out whole swaths of data in one go.

Timescale Vector 借助了 [TimescaleDB 的超表（hypertables）](https://docs.timescale.com/use-timescale/latest/hypertables/?ref=blog.langchain.com)，后者会自动依据时间戳对向量及其关联元数据进行分区。这使得系统能够同时基于“与查询向量的相似度”和“时间”两个维度高效地查询向量——因为查询时会直接忽略不在指定时间窗口内的整个分区，从而一次性过滤掉大量无关数据，显著提升搜索效率。

# Powering Retrieval Augmented Generation With Time-Based Context Retrieval in LangChain Applications with Timescale Vector

# 使用 Timescale Vector 在 LangChain 应用中实现基于时间的上下文检索，赋能检索增强生成（RAG）

Let’s put everything together and look at how to use the Timescale Vector to power Retrieval Augmented Generation (RAG) on the git log dataset we examined above.

现在我们将前述内容整合起来，具体看看如何利用 Timescale Vector，在我们此前分析过的 Git 日志数据集上实现检索增强生成（Retrieval Augmented Generation, RAG）。

Timescale Vector helps with time-based context retrieval, where we want to find the most relevant vectors within a specified time range to use as context for answering a user query. Let's take a look at an example below, using Timescale Vector as a retriever.

Timescale Vector 支持基于时间的上下文检索：即在指定时间范围内查找最相关的向量，作为回答用户问题的上下文依据。下面我们将以 Timescale Vector 作为检索器（retriever），通过一个示例来说明其用法。

First we create a retriever from the TimescaleVector store.

首先，我们从 `TimescaleVector` 向量存储中创建一个检索器。

# Set timescale vector as a retriever and specify start and end dates via kwargs

# 将 Timescale Vector 设置为检索器，并通过 kwargs 指定起始与结束日期

```python
retriever = db.as_retriever(search_kwargs={"start_date": start_dt, "end_date": end_dt})
```

When creating the retriever, we can constrain the search to a relevant time range by passing our time filter parameters for Timescale Vector as `search_kwargs`.

创建检索器时，我们可通过向 Timescale Vector 传入时间过滤参数（作为 `search_kwargs`），将搜索范围限制在相关的时间区间内。

Then we’ll create a [RetrievalQA chain](https://python.langchain.com/docs/use_cases/question_answering/how_to/vector_db_qa?ref=blog.langchain.com) from a [Stuff chain](https://python.langchain.com/docs/modules/chains/document/stuff?ref=blog.langchain.com), by passing our retriever and the LLM we want to use to generate a response:

接着，我们将基于 [Stuff 链](https://python.langchain.com/docs/modules/chains/document/stuff?ref=blog.langchain.com) 构建一个 [RetrievalQA 链](https://python.langchain.com/docs/use_cases/question_answering/how_to/vector_db_qa?ref=blog.langchain.com)，方法是传入我们已定义的检索器以及用于生成响应的大语言模型（LLM）：

```python
from langchain.chat_models import ChatOpenAI
llm = ChatOpenAI(temperature = 0.1, model = 'gpt-3.5-turbo-16k')

from langchain.chains import RetrievalQA
qa_stuff = RetrievalQA.from_chain_type(
   llm=llm,
   chain_type="stuff",
   retriever=retriever,
   verbose=True,
)
```

Then we can query the RetrievalQA chain and it will use the retriever backed by Timescale Vector to answer your the query with the most relevant documents within the time ranged specified:

随后，我们可以向该 RetrievalQA 链发起查询；它将调用由 Timescale Vector 支持的检索器，在您指定的时间范围内，检索出最相关的文档并据此回答问题：

```python
query = "What's new with the timescaledb functions? Tell me when these changes were made."
response = qa_stuff.run(query)
print(response)
```

**> Entering new RetrievalQA chain...**

**> 进入新的 RetrievalQA 链...**

**> Finished chain.**

**> 链执行完毕。**

> The following changes were made to the timescaledb functions:

> 以下是对 `timescaledb` 函数所做的更改：

> 1\. "Add compatibility layer for \_timescaledb\_internal functions" - This change was made on Tue Aug 29 18:13:24 2023 +0200.

> 1. “为 `_timescaledb_internal` 函数添加兼容性层”——该更改于 2023 年 8 月 29 日星期二 18:13:24（UTC+2）完成。

> 2\. "Move functions to \_timescaledb\_functions schema" - This change was made on Sun Aug 20 22:47:10 2023 +0200.

> 2. “将函数迁移至 `_timescaledb_functions` 模式”——该更改于 2023 年 8 月 20 日星期日 22:47:10（UTC+2）完成。

> 3\. "Move utility functions to \_timescaledb\_functions schema" - This change was made on Tue Aug 22 12:01:19 2023 +0200.

> 3. “将工具函数迁移至 `_timescaledb_functions` 模式”——该更改于 2023 年 8 月 22 日星期二 12:01:19（UTC+2）完成。

> 4\. "Move partitioning functions to \_timescaledb\_functions schema" - This change was made on Tue Aug 29 10:49:47 2023 +0200.

> 4. “将分区函数迁移至 `_timescaledb_functions` 模式”——该更改于 2023 年 8 月 29 日星期二 10:49:47（UTC+2）完成。

Success! Note that the context the LLM uses to compose an answer are from retrieved documents only within the specified date range.

成功！请注意，大语言模型（LLM）用于生成答案的上下文，仅来源于在指定日期范围内检索到的文档。

This is a simple example of a powerful concept – using time-based context retrieval in your RAG applications can help provide more relevant answers to your users. This time-based context retrieval can be helpful to any dataset with a natural language and time component. Timescale Vector uniquely enables this thanks to its efficient time-based similarity search capabilities and taking advantage of it in your LangChain applications is easy thanks to the Timescale Vector integration.

这是一个强大概念的简单示例——在您的 RAG 应用中使用基于时间的上下文检索，可帮助您向用户提供更相关的答案。这种基于时间的上下文检索，适用于任何同时具备自然语言和时间维度的数据集。Timescale Vector 凭借其高效的基于时间的相似性搜索能力，独树一帜地支持该功能；而借助 Timescale Vector 与 LangChain 的深度集成，您可在 LangChain 应用中轻松启用这一能力。

# Advanced LangChain Self-Querying Capabilities With Timescale Vector

# 借助 Timescale Vector 实现 LangChain 高级自查询（Self-Querying）能力

Timescale Vector also supports one of LangChain’s coolest features: the [Self-Querying retriever](https://python.langchain.com/docs/modules/data_connection/retrievers/self_query/?ref=blog.langchain.com).

Timescale Vector 同样支持 LangChain 最具创新性的功能之一：[自查询检索器（Self-Querying Retriever）](https://python.langchain.com/docs/modules/data_connection/retrievers/self_query/?ref=blog.langchain.com)。

Here’s how it works: We create a retriever from the Timescale Vector vector store and feed it a natural language query with a query statement and filters (single or composite). The retriever then uses a query constructing LLM chain to write a SQL query and applies it to the underlying PostgreSQL database in the Timescale Vector vector store.

其工作原理如下：我们从 Timescale Vector 向量存储中创建一个检索器，并向其输入一条包含查询语句及过滤条件（单个或复合）的自然语言查询。该检索器随后调用一个用于构建查询的 LLM 链，自动生成对应的 SQL 查询，并将其应用于 Timescale Vector 向量存储所依托的底层 PostgreSQL 数据库。

With Timescale Vector, you can ask queries with limit, metadata, and time-based filters using the self-query retriever. Let’s take a look at an example of using self-querying on a git log dataset.

使用 Timescale Vector，您可以通过自查询检索器（self-query retriever）执行带限制（limit）、元数据（metadata）和基于时间的过滤条件的查询。下面我们以 Git 日志数据集为例，演示自查询功能。

First, we instantiate our TimescaleVector vector store:

首先，我们实例化 TimescaleVector 向量存储：

```
COLLECTION_NAME = "timescale_commits"
vectorstore = TimescaleVector(
   embedding_function=OpenAIEmbeddings(),
   collection_name=COLLECTION_NAME,
   service_url=SERVICE_URL,
)
```

Second, let’s create the self-query retriever from an LLM, passing the following parameters to it:

其次，我们基于一个大语言模型（LLM）创建自查询检索器，并向其传入以下参数：

- \`llm\`: the LLM we want our self-query retriever to use to construct the queries.  
- \`llm\`：我们希望自查询检索器用来构造查询的大语言模型。

- \`vectorstore\`: our TimescaleVector vectorstore, instantiated above.  
- \`vectorstore\`：上一步中已实例化的 TimescaleVector 向量存储。

- \`document\_content\_description\`: a description of the content associated with our vector embeddings. In this case, it is information about the git log entries.  
- \`document\_content\_description\`：对向量嵌入所关联文档内容的描述；此处即 Git 日志条目的相关信息。

- \`metadata\_field\_info\`: a list of AttributeInfo objects, which give the LLM information about the metadata fields in our collection of vectors.  
- \`metadata\_field\_info\`：一组 `AttributeInfo` 对象列表，用于向大语言模型提供向量集合中元数据字段的信息。

- \`enable\_limit\`: setting this to ‘true’ enables us to ask questions with an implied limit, which helps constrain the number of results returned.  
- \`enable\_limit\`：设为 `True` 后，即可支持隐含数量限制（implied limit）的问题，从而控制返回结果的数量。

```
from langchain.llms import OpenAI
from langchain.retrievers.self_query.base import SelfQueryRetriever
from langchain.chains.query_constructor.base import AttributeInfo

# Give LLM info about the metadata fields
metadata_field_info = [\
   AttributeInfo(\
       name="id",\
       description="A UUID v1 generated from the date of the commit",\
       type="uuid",\
   ),\
   AttributeInfo(\
       name="date",\
       description="The date of the commit in timestamptz format",\
       type="timestamptz",\
   ),\
   AttributeInfo(\
       name="author_name",\
       description="The name of the author of the commit",\
       type="string",\
   ),\
   AttributeInfo(\
       name="author_email",\
       description="The email address of the author of the commit",\
       type="string",\
   )\
]
document_content_description = "The git log commit summary containing the commit hash, author, date of commit, change summary and change details"

# Instantiate the self-query retriever from an LLM
llm = OpenAI(temperature=0)
retriever = SelfQueryRetriever.from_llm(
   llm, vectorstore, document_content_description, metadata_field_info, enable_limit=True, verbose=True
)
```

Now for the fun part, let’s query our self-query retriever.

现在进入有趣的部分：让我们来查询这个自查询检索器。

### Self-querying example: Query and metadata filter

### 自查询示例：查询与元数据过滤

Here’s an example of a simple metadata filter specified in natural language. In this case, we’re asking for commits added by a specific person:

这是一个以自然语言指定的简单元数据过滤器示例。此处，我们查询的是由特定人员提交的代码变更（commits）：

```
retriever.get_relevant_documents("What commits about timescaledb_functions did Sven Klemm add?")
```

```
retriever.get_relevant_documents("Sven Klemm 添加了哪些关于 timescaledb_functions 的提交？")
```

Here’s the verbose output of the LLM chain, showing what query parameters the natural language query got translated into:

以下是大语言模型（LLM）链的详细输出，展示了该自然语言查询被转换成的查询参数：

```
query='timescaledb_functions' filter=Comparison(comparator=<Comparator.EQ: 'eq'>, attribute='author_name', value='Sven Klemm') limit=None
```

```
query='timescaledb_functions' filter=Comparison(comparator=<Comparator.EQ: 'eq'>, attribute='author_name', value='Sven Klemm') limit=None
```

### Self-querying example:: Time-based filter

### 自查询示例：基于时间的过滤器

Here’s an example of a question that uses a time-based filter. The query to fetch the results to answer this question will take advantage of Timescale Vector’s efficient time-based partitioning.

以下是一个使用基于时间过滤器的问题示例。为回答该问题而执行的查询将充分利用 Timescale Vector 高效的按时间分区能力。

```
# This example specifies a time-based filter
retriever.get_relevant_documents("What commits were added in July 2023?")
```

```
# 此示例指定了一个基于时间的过滤器
retriever.get_relevant_documents("2023 年 7 月添加了哪些提交？")
```

Here’s the verbose explanation from LangChain’s self-query retriever about the SQL query parameters that the natural language query gets translated into:

以下是 LangChain 自查询检索器（self-query retriever）提供的详细说明，解释了该自然语言查询被转换成的 SQL 查询参数：

```
query=' ' filter=Operation(operator=<Operator.AND: 'and'>, arguments=[Comparison(comparator=<Comparator.GTE: 'gte'>, attribute='date', value='2023-07-01T00:00:00Z'), Comparison(comparator=<Comparator.LTE: 'lte'>, attribute='date', value='2023-07-31T23:59:59Z')]) limit=None
```

```
query=' ' filter=Operation(operator=<Operator.AND: 'and'>, arguments=[Comparison(comparator=<Comparator.GTE: 'gte'>, attribute='date', value='2023-07-01T00:00:00Z'), Comparison(comparator=<Comparator.LTE: 'lte'>, attribute='date', value='2023-07-31T23:59:59Z')]) limit=None
```

And here’s a snippet of the results:

以下是查询结果的片段：

```
[Document(page_content='{"commit": " 5cf354e2469ee7e43248bed382a4b49fc7ccfecd", "author": "Markus Engel<engel@sero-systems.de>", "date": "Mon Jul 31 11:28:25 2023 +0200",...\
\
[Document(page_content='{"commit": " 88aaf23ae37fe7f47252b87325eb570aa417c607", "author": "noctarius aka Christoph Engelbert<me@noctarius.com>", "date": "Wed Jul 12 14:53:40 2023 +0200", . . .\
\
[Document(page_content='{"commit": " d5268c36fbd23fa2a93c0371998286e8688247bb", "author": "Alexander Kuzmenkov<36882414+akuzm@users.noreply.github.com>", "date": "Fri Jul 28 13:35:05 2023 +0200",...\
```

```
[Document(page_content='{"commit": " 5cf354e2469ee7e43248bed382a4b49fc7ccfecd", "author": "Markus Engel<engel@sero-systems.de>", "date": "2023年7月31日 星期一 11:28:25 +0200",...\
\
[Document(page_content='{"commit": " 88aaf23ae37fe7f47252b87325eb570aa417c607", "author": "noctarius（即 Christoph Engelbert）<me@noctarius.com>", "date": "2023年7月12日 星期三 14:53:40 +0200", . . .\
\
[Document(page_content='{"commit": " d5268c36fbd23fa2a93c0371998286e8688247bb", "author": "Alexander Kuzmenkov<36882414+akuzm@users.noreply.github.com>", "date": "2023年7月28日 星期五 13:35:05 +0200",...\
```

Note how you can specify a query, filter, and composite filter (filters with AND, OR) in natural language and the self-query retriever will translate that query into SQL and perform the search on the Timescale Vector (PostgreSQL) vector store.

请注意：您可以用自然语言指定查询（query）、过滤条件（filter）以及组合过滤条件（composite filter，例如含 AND、OR 的复合条件），而自查询检索器（self-query retriever）会自动将该查询翻译为 SQL，并在 Timescale Vector（基于 PostgreSQL 的向量数据库）中执行检索。

This illustrates the power of the self-query retriever. You can use it to perform complex searches over your vector store without you or your users having to write any SQL directly.

这充分展现了自查询检索器的强大能力：您可借助它对向量数据库执行复杂的检索操作，而您或您的用户均无需直接编写任何 SQL 语句。

What’s more, you can combine the self-query retriever with the LangChain [RetrievalQA chain](https://python.langchain.com/docs/use_cases/question_answering/how_to/vector_db_qa?ref=blog.langchain.com) to power an RAG application!

更进一步，您还可将自查询检索器与 LangChain 的 [RetrievalQA 链](https://python.langchain.com/docs/use_cases/question_answering/how_to/vector_db_qa?ref=blog.langchain.com) 相结合，构建一个完整的 RAG（检索增强生成）应用！

## Resources and next steps

## 资源与后续学习步骤

Now that you’ve learned how Timescale Vector can help you power AI applications with PostgreSQL, it’s your turn to dive in. Take the next step in your learning journey by following one of the tutorials or reading one of the blog posts in the following resources set:

如今，您已了解 Timescale Vector 如何借助 PostgreSQL 赋能 AI 应用开发——接下来，就轮到您亲自上手实践了！请从以下资源中任选一项教程或博客文章，迈出您学习旅程的下一步：

- **[**快速上手教程（Up and Running Tutorial）**](https://python.langchain.com/docs/integrations/vectorstores/timescalevector?ref=blog.langchain.com):** 学习如何将 Timescale Vector 作为 LangChain 的向量存储使用，并对向量执行基于时间的相似性搜索。  
- [**自查询检索器教程（Self-query retriever tutorial）:**](https://python.langchain.com/docs/modules/data_connection/retrievers/self_query/timescalevector_self_query?ref=blog.langchain.com) 学习如何将 Timescale Vector 用作自查询检索器。  
- [**Timescale Vector 原理解析（Timescale Vector explainer）**](https://www.timescale.com/blog/how-we-made-postgresql-the-best-vector-database/?utm_campaign=vectorlaunch&utm_source=langchain&utm_medium=referral): 深入了解 Timescale Vector 的内部实现机制。  
- **[**Timescale Vector 官网**](https://www.timescale.com/ai?ref=blog.langchain.com): 了解更多关于 Timescale Vector 及 Timescale “AI 启动周（AI Launch Week）” 的信息。**

**🎉 温馨提醒：** [**LangChain 用户可免费试用 Timescale Vector 3 个月**](https://console.cloud.timescale.com/signup?utm_campaign=vectorlaunch&utm_source=langchain&utm_medium=referral)

**🎉 温馨提醒：** [**LangChain 用户可免费试用 Timescale Vector 3 个月**](https://console.cloud.timescale.com/signup?utm_campaign=vectorlaunch&utm_source=langchain&utm_medium=referral)

Timescale is giving LangChain users an extended 90-day trial of Timescale Vector. This makes it easy to test and develop your applications with Timescale Vector, as you won’t be charged for any cloud PostgreSQL databases you spin up during your trial period. [Try Timescale Vector for free today](https://console.cloud.timescale.com/signup?utm_campaign=vectorlaunch&utm_source=langchain&utm_medium=referral).

Timescale 正为 LangChain 用户提供长达 90 天的 Timescale Vector 免费试用期。在此试用期内，您创建的任意云 PostgreSQL 数据库均不产生费用，让您能够轻松开展 Timescale Vector 的测试与应用开发工作。[立即免费试用 Timescale Vector](https://console.cloud.timescale.com/signup?utm_campaign=vectorlaunch&utm_source=langchain&utm_medium=referral)。
{% endraw %}
