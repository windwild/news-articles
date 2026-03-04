---
title: "Neon x LangChain: HNSW in Postgres with pg_embedding"
source: "LangChain Blog"
url: "https://blog.langchain.com/neon-x-langchainhnsw-in-postgres-with-pg_embedding/"
date: "2023-07-12"
scraped_at: "2026-03-03T09:32:41.630084988+00:00"
language: "en-zh"
translated: true
---
{% raw %}

**_Editor’s Note: This blog post was written in collaboration with the Neon team (Raouf Chebri in particular). The vectorstore space is on fire, and we’re excited to highlight new implementations and options. We’re also really excited by the detailed analysis done here, bringing some solid stats and insights to a novel space._**

**_编辑注：本文由 LangChain 团队与 Neon 团队（特别是 Raouf Chebri）合作撰写。当前向量数据库（vectorstore）领域热度高涨，我们非常高兴能借此机会介绍新的实现方案与可选技术。同时，我们也尤为赞赏本文所开展的深入分析工作——它为这一新兴领域带来了扎实的数据支撑与深刻洞见。_**

We’re very excited to announce Neon’s collaboration with LangChain to release the pg\_embedding extension and PGEmbedding integration in LangChain for vector similarity search in Postgres.

我们非常激动地宣布：Neon 与 LangChain 展开合作，正式发布 `pg_embedding` 扩展以及 LangChain 中对 `PGEmbedding` 的集成支持，以在 PostgreSQL 中实现高效的向量相似性搜索。

But wait. Aren’t they already two other vector stores in LangChain using Postgres and PGVector? Why did the Neon team add another?

但请稍等——LangChain 中不是已有另外两个基于 PostgreSQL 和 PGVector 的向量存储实现吗？Neon 团队为何还要新增一个？

The short answer is: the Neon team built and added it for faster execution time and scalable LLM applications.

简而言之：Neon 团队开发并引入 `PGEmbedding`，旨在显著提升执行速度，并更好地支撑大规模、可扩展的大语言模型（LLM）应用。

PGVector is great, it does exact similarity search by default, which results in 100% accuracy (recall). At scale, however, exact search is costly. Neon found that you can use PGVector with the IVFFlat index to improve query execution time, but that often comes at the cost of accuracy, which increases the chance of hallucination.

PGVector 非常优秀，默认执行精确相似性搜索，召回率（recall）可达 100%。然而，在数据规模扩大时，精确搜索的计算开销十分高昂。Neon 发现，虽然可通过为 PGVector 配置 IVFFlat 索引来加快查询执行速度，但这通常会牺牲部分准确性，从而增加模型“幻觉”（hallucination）的风险。

The Neon team carried out benchmark tests to compare the performance of pgvector and PGEmbedding, and they found out that PGEmbedding performs 20x faster for 99% accuracy.

Neon 团队开展了基准性能测试，对比了 `pgvector` 与 `PGEmbedding` 的实际表现；结果表明：在保持 99% 召回率的前提下，`PGEmbedding` 的查询速度比 `pgvector` 快达 20 倍。

![](images/neon-x-langchain-hnsw-in-postgres-with-pg_embedding/img_001.png)

![](images/neon-x-langchain-hnsw-in-postgres-with-pg_embedding/img_001.png)

Read the full article to learn more about the benchmark [here](https://neon.tech/blog/pg-embedding-extension-for-vector-search?ref=blog.langchain.com).

欢迎点击[此处](https://neon.tech/blog/pg-embedding-extension-for-vector-search?ref=blog.langchain.com)，阅读完整文章，深入了解本次基准测试的详细信息。

## Why is PGEmbedding faster?

## 为什么 PGEmbedding 更快？

The PGEmbedding integration uses the Hierarchical Navigable Small World (HNSW) index graph-based approach to indexing high-dimensional data. It constructs a hierarchy of graphs, where each layer is a subset of the previous one, which results in a time complexity of O(log(rows)). Search with IVFFlat optimal parameters, however, often has a time complexity of O(sqrt(rows)).

`PGEmbedding` 集成采用基于图结构的“分层可导航小世界”（Hierarchical Navigable Small World, HNSW）索引方法，对高维数据进行索引。该方法构建多层图结构，其中每一层均为上一层的子集，最终实现 O(log(rows)) 的时间复杂度。相比之下，即便采用最优参数配置的 IVFFlat 索引，其搜索时间复杂度通常仍为 O(√rows)。

## How to get started with PGEmbedding

## 如何开始使用 PGEmbedding

1. The first step is to login to your Neon account and create a project:

第一步是登录您的 Neon 账户并创建一个项目：

```bash
npx neonctl auth
```

The command above will direct you to the sign-up if you do not already have a Neon account.

如果尚未注册 Neon 账户，上述命令将引导您进入注册页面。

Once logged in, create a project using the following command:

登录后，使用以下命令创建项目：

```bash
npx neonctl projects create
```

Expected output:

预期输出如下：

```bash
┌─────────────────┬─────────────────┬───────────────┬──────────────────────┐
│ Id              │ Name            │ Region Id     │ Created At           │
├─────────────────┼─────────────────┼───────────────┼──────────────────────┤
│ dawn-sun-749604 │ dawn-sun-749604 │ aws-us-east-2 │ 2023-07-11T20:55:32Z │
└─────────────────┴─────────────────┴───────────────┴──────────────────────┘
┌───────────────────────────────────────────────────────────────────────────────────────┐
│ Connection Uri                                                                        │
├───────────────────────────────────────────────────────────────────────────────────────┤
│ postgres://<user>:<password>@ep-lingering-moon-792025.us-east-2.aws.neon.tech/neondb │
└───────────────────────────────────────────────────────────────────────────────────────┘
```

2\. Follow the instructions in the documentation to [install LangChain](https://python.langchain.com/docs/get_started/installation?ref=blog.langchain.com) if you haven’t done so already.

2. 如果您尚未安装，请参照文档中的说明 [安装 LangChain](https://python.langchain.com/docs/get_started/installation?ref=blog.langchain.com)。

3\. The code below initializes the PGEmbedding vector store, and executes a similarity analysis

3. 下方代码用于初始化 PGEmbedding 向量存储，并执行相似性分析。

```python
import os
from typing import List, Tuple

from langchain.embeddings.openai import OpenAIEmbeddings
from langchain.text_splitter import CharacterTextSplitter
from langchain.vectorstores import PGEmbedding
from langchain.document_loaders import TextLoader
from langchain.docstore.document import Document

loader = TextLoader('state_of_the_union.txt')
raw_docs = loader.load()
text_splitter = CharacterTextSplitter(chunk_size=1000, chunk_overlap=0)
docs = text_splitter.split_documents(raw_docs)
embeddings = OpenAIEmbeddings()
CONNECTION_STRING = os.environ["DATABASE_URL"]

# Initialize the vectorstore, create tables and store embeddings and
# metadata.
db = PGEmbedding.from_documents(
    embedding=embeddings,
    documents=docs,
    collection_name="state_of_the_union",
    connection_string=CONNECTION_STRING,
)

# Create the index using HNSW. This step is optional. By default the
# vectorstore uses exact search.
db.create_hnsw_index(max_elements=10000, dims=1536, m=8, ef_construction =16, ef_search=16)

# Execute the similarity search and return documents
query = "What did the president say about Ketanji Brown Jackson"
docs_with_score = db.similarity_search_with_score(query)

print('query done')

print("Results:")
for doc, score in docs_with_score:
    print("-" * 80)
    print("Score: ", score)
    print(doc.page_content)
    print("-" * 80)
```

```python
import os
from typing import List, Tuple

from langchain.embeddings.openai import OpenAIEmbeddings
from langchain.text_splitter import CharacterTextSplitter
from langchain.vectorstores import PGEmbedding
from langchain.document_loaders import TextLoader
from langchain.docstore.document import Document

loader = TextLoader('state_of_the_union.txt')
raw_docs = loader.load()
text_splitter = CharacterTextSplitter(chunk_size=1000, chunk_overlap=0)
docs = text_splitter.split_documents(raw_docs)
embeddings = OpenAIEmbeddings()
CONNECTION_STRING = os.environ["DATABASE_URL"]

# 初始化向量数据库，创建表并存储嵌入向量及元数据。
db = PGEmbedding.from_documents(
    embedding=embeddings,
    documents=docs,
    collection_name="state_of_the_union",
    connection_string=CONNECTION_STRING,
)

# 使用 HNSW 创建索引。此步骤为可选操作；默认情况下，向量数据库执行精确搜索。
db.create_hnsw_index(max_elements=10000, dims=1536, m=8, ef_construction=16, ef_search=16)

# 执行相似性搜索并返回匹配文档
query = "What did the president say about Ketanji Brown Jackson"
docs_with_score = db.similarity_search_with_score(query)

print('查询完成')

print("搜索结果：")
for doc, score in docs_with_score:
    print("-" * 80)
    print("相似度得分：", score)
    print(doc.page_content)
    print("-" * 80)
```

## PGEmbedding vs PGVector: Which vector store should you pick?

## PGEmbedding 与 PGVector：应如何选择向量数据库？

The Neon team compared both indexes using five criteria:  

Neon 团队从以下五个维度对这两种索引方案进行了对比：

- Search speed  
- 搜索速度  

- Accuracy  
- 准确率  

- Memory usage  
- 内存占用  

- Index construction speed  
- 索引构建速度  

- Distance metrics  
- 距离度量  

![](images/neon-x-langchain-hnsw-in-postgres-with-pg_embedding/img_002.png)

|     |     |     |
| --- | --- | --- |
|  | PGVector / SupabaseVectorStore | PGEmbedding |
| Search Speed | Fast, but the search speed depends on the number of clusters examined. More clusters mean higher accuracy but slower search times. | Typically faster than IVFFlat, especially in high-dimensional spaces, thanks to its graph-based nature. |
| 搜索速度 | 较快，但搜索速度取决于所检查的聚类数量；聚类越多，准确率越高，但搜索耗时也越长。 | 通常比 IVFFlat 更快，尤其在高维空间中，这得益于其基于图（graph-based）的结构特性。 |
| Accuracy | Can achieve high accuracy but at the cost of examining more clusters and hence longer search times. | Generally achieves higher accuracy for the same memory footprint compared to IVFFlat. |
| 准确率 | 可实现较高准确率，但需以检查更多聚类、进而延长搜索时间为代价。 | 在相同内存占用下，通常比 IVFFlat 实现更高的准确率。 |
| Memory Usage | It uses relatively less memory since it only stores the centroids of clusters and the lists of vectors within these clusters. | Generally uses more memory because it maintains a graph structure with multiple layers. |
| 内存占用 | 内存占用相对较低，因其仅存储各聚类的质心及对应向量列表。 | 内存占用通常更高，因其需维护包含多层结构的图（graph）索引。 |
| Index Construction Speed | Index building process is relatively fast. The data points are assigned to the nearest centroid, and inverted lists are constructed. | Index construction involves building multiple layers of graphs, which can be computationally intensive, especially if you choose high values for the parameter `ef_construction`. |
| 索引构建速度 | 索引构建过程相对较快：数据点被分配至最近的质心，并构建倒排列表。 | 索引构建需逐层构建图结构，计算开销较大，尤其当 `ef_construction` 参数设为较高值时。 |
| Distance Metrics | Typically used for L2 distances, but pgvector supports inner product and cosine distance as well. | Only uses L2 distance metrics at the moment. |
| 距离度量 | 通常用于 L2 距离，但 pgvector 同时支持内积（inner product）和余弦（cosine）距离。 | 当前仅支持 L2 距离度量。 |

## Conclusion  

## 结论  

With the introduction of the PGEmbedding integration, you now have a powerful new tool at your disposal for your LLM apps.  PGVector remains a viable choice for applications with stringent memory constraints but at the expense of recall.  

随着 PGEmbedding 集成的推出，您现在拥有了一个功能强大的新工具，可用于构建您的大语言模型（LLM）应用。PGVector 仍适用于对内存有严格限制的应用场景，但需以召回率（recall）为代价。

Ultimately, the choice between PGEmbedding and other vector stores should be informed by the specific demands of your application. We encourage you to experiment with both approaches to find the one that best meets your needs.  

最终，PGEmbedding 与其他向量数据库之间的选择，应由您应用的具体需求决定。我们鼓励您尝试这两种方案，从而选出最契合您需求的那一个。

We are excited to see what you are going to build with PGEmbedding and look forward to your feedback!  

我们非常期待看到您基于 PGEmbedding 所构建的精彩应用，并热切期盼您的反馈！

Happy coding!  

祝编码愉快！

### Tags  

### 标签

[![NeumAI x LangChain: Efficiently maintaining context in sync for AI applications](images/neon-x-langchain-hnsw-in-postgres-with-pg_embedding/img_003.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain：面向 AI 应用的高效上下文同步维护**](https://blog.langchain.com/neum-x-langchain/)


[![Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination](images/neon-x-langchain-hnsw-in-postgres-with-pg_embedding/img_004.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**让数据接入具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)


[![Chat with your data using OpenAI, Pinecone, Airbyte and Langchain](images/neon-x-langchain-hnsw-in-postgres-with-pg_embedding/img_005.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)


[**Yeager.ai x LangChain：探索 GenWorlds——一个协调 AI 智能体的框架**](https://blog.langchain.com/exploring-genworlds/)


[![Conversational Retrieval Agents](https://images.unsplash.com/photo-1625794084867-8ddd239946b1?crop=entropy&cs=tinysrgb&fit=max&fm=webp&ixid=M3wxMTc3M3wwfDF8c2VhcmNofDZ8fGdvbGRlbiUyMHJldHJpZXZlcnxlbnwwfHx8fDE2OTEwNDEwOTl8MA&ixlib=rb-4.0.3&q=80&w=760)](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体（Conversational Retrieval Agents）**](https://blog.langchain.com/conversational-retrieval-agents/)


[**借助 LangChain，通过 Genoss 统一 AI 接口**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)
{% endraw %}
