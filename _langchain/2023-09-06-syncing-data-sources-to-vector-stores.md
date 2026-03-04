---
title: "Syncing data sources to vector stores"
source: "LangChain Blog"
url: "https://blog.langchain.com/syncing-data-sources-to-vector-stores/"
date: "2023-09-06"
scraped_at: "2026-03-03T08:47:26.327529717+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

Most complex and knowledge-intensive LLM applications require runtime data retrieval for Retrieval Augmented Generation (RAG). A core component of the typical RAG stack is a vector store, which is used to power document retrieval.

大多数复杂且知识密集型的大型语言模型（LLM）应用都需要在运行时进行数据检索，以支持检索增强生成（Retrieval Augmented Generation, RAG）。典型的 RAG 技术栈中，一个核心组件是向量数据库（vector store），它用于支撑文档检索功能。

![](images/syncing-data-sources-to-vector-stores/img_001.jpg)

Using a vector store requires setting up an indexing pipeline to load data from sources (a website, a file, etc.), transform the data into documents, embed those documents, and insert the embeddings and documents into the vector store.

使用向量数据库需要构建一条索引流水线（indexing pipeline）：从数据源（例如网站、文件等）加载数据，将数据转换为文档，对这些文档进行嵌入（embedding），最后将嵌入向量及对应文档插入向量数据库中。

If your data sources or processing steps change, the data needs to be re-indexed. If this happens regularly, and the changes are incremental, it becomes valuable to de-duplicate the content being indexed with the content already in the vector store. This avoids spending time and money on redundant work. It also becomes important to set up vector store cleanup processes to remove stale data from your vector store.

若您的数据源或处理流程发生变化，则需对数据重新建立索引。若此类变更频繁发生，且属于增量式更新，那么在索引新内容时，与向量数据库中已存在的内容进行去重就变得尤为关键——这可避免在重复工作上耗费额外的时间与成本。同时，建立向量数据库的清理机制（cleanup processes）以移除过时（stale）数据，也变得至关重要。

## LangChain Indexing API

## LangChain 索引 API

The new LangChain Indexing API makes it easy to load and keep in sync documents from any source into a vector store. Specifically, it helps:

LangChain 全新推出的索引 API（Indexing API）可轻松将来自任意数据源的文档加载并持续同步至向量数据库。具体而言，该 API 能够：

- Avoid writing duplicated content into the vector store  
- 避免向向量数据库写入重复内容  

- Avoid re-writing unchanged content  
- 避免重写未发生变化的内容  

- Avoid re-computing embeddings over unchanged content  
- 避免对未发生变化的内容重复计算嵌入向量  

Crucially, the indexing API will work even with documents that have gone through several transformation steps (e.g., via text chunking) with respect to the original source documents.

尤为关键的是，该索引 API 即便面对经过多步转换（例如通过文本分块，text chunking）处理后的文档，仍能正常工作——只要这些文档源自原始源文档。

## How it works

## 工作原理

LangChain indexing makes use of a record manager (`RecordManager`) that keeps track of document writes into a vector store.

LangChain 的索引机制依赖于一个记录管理器（`RecordManager`），用于追踪所有写入向量数据库的文档操作。

When indexing content, hashes are computed for each document, and the following information is stored in the record manager:

在索引内容时，系统会为每个文档计算哈希值，并将以下信息存储在记录管理器中：

- the document hash (hash of both page content and metadata)  
- 文档哈希值（页面内容与元数据的联合哈希）

- write time  
- 写入时间

- the source id -- each document should include information in its metadata to allow us to determine the ultimate source of this document  
- 源 ID —— 每个文档的元数据中应包含足够信息，以便我们确定该文档的最终来源

### Cleanup modes

### 清理模式

When re-indexing documents into a vector store, it's possible that some existing documents in the vector store should be deleted. If you’ve made changes to how documents are processed before insertion or source documents have changed, you’ll want to remove any existing documents that come from the same source as the new documents being indexed. If some source documents have been deleted, you’ll want to delete all existing documents in the vector store and replace them with the re-indexed documents.

在将文档重新索引到向量数据库时，部分已存在的文档可能需要被删除。例如：若您修改了文档插入前的预处理逻辑，或原始源文档本身已发生变更，则应移除向量数据库中所有与新索引文档来源相同的既有文档；若某些原始源文档已被删除，则应清空向量数据库中的全部现有文档，并以重新索引后的新文档取而代之。

The indexing API cleanup modes let you pick the behavior you want:

索引 API 提供了多种清理模式，供您按需选择相应的行为：

![](images/syncing-data-sources-to-vector-stores/img_002.png)

For more detailed documentation of the API and its limitations, check out the docs: [https://python.langchain.com/docs/modules/data\_connection/indexing](https://python.langchain.com/docs/modules/data_connection/indexing?ref=blog.langchain.com)

有关该 API 的更详细说明及其限制，请参阅官方文档：[https://python.langchain.com/docs/modules/data\_connection/indexing](https://python.langchain.com/docs/modules/data_connection/indexing?ref=blog.langchain.com)

## Seeing it in action

## 实际演示

First let’s initialize our vector store. We’ll demo with the `ElasticsearchStore`, since it satisfies the pre-requisites of supporting insertion and deletion. See the [Requirements](https://python.langchain.com/docs/modules/data_connection/indexing?ref=blog.langchain.com#requirements) docs section for more on vector store requirements.

首先，我们初始化向量数据库。本例将使用 `ElasticsearchStore` 进行演示，因为它满足支持插入与删除操作的前提条件。有关向量数据库的具体要求，请参阅文档中的 [Requirements（要求）](https://python.langchain.com/docs/modules/data_connection/indexing?ref=blog.langchain.com#requirements) 章节。

```python
# !pip install openai elasticsearch
```

```python
from langchain.embeddings import OpenAIEmbeddings
from langchain.vectorstores import ElasticsearchStore

collection_name = "test_index"

# Set env var OPENAI_API_KEY
embedding = OpenAIEmbeddings()

# Run an Elasticsearch instance locally:
# !docker run -p 9200:9200 -e "discovery.type=single-node" -e "xpack.security.enabled=false" -e "xpack.security.http.ssl.enabled=false" docker.elastic.co/elasticsearch/elasticsearch:8.9.0
vector_store = ElasticsearchStore(
    collection_name,
    es_url="<http://localhost:9200>",
    embedding=embedding
)
```

```python
从 langchain.embeddings 导入 OpenAIEmbeddings
从 langchain.vectorstores 导入 ElasticsearchStore

collection_name = "test_index"

# 设置环境变量 OPENAI_API_KEY
embedding = OpenAIEmbeddings()

# 在本地运行一个 Elasticsearch 实例：
# !docker run -p 9200:9200 -e "discovery.type=single-node" -e "xpack.security.enabled=false" -e "xpack.security.http.ssl.enabled=false" docker.elastic.co/elasticsearch/elasticsearch:8.9.0
vector_store = ElasticsearchStore(
    collection_name,
    es_url="<http://localhost:9200>",
    embedding=embedding
)
```

And now we’ll initialize and create a schema for our record manager, for which we’ll just use a SQLite table:

接下来，我们将初始化记录管理器（record manager）并为其创建数据库表结构；此处我们仅使用一个 SQLite 表：

```python
from langchain.indexes import SQLRecordManager

namespace = f"elasticsearch/{collection_name}"
record_manager = SQLRecordManager(
    namespace, db_url="sqlite:///record_manager_cache.sql"
)
record_manager.create_schema()
```

```python
from langchain.indexes import SQLRecordManager

namespace = f"elasticsearch/{collection_name}"
record_manager = SQLRecordManager(
    namespace, db_url="sqlite:///record_manager_cache.sql"
)
record_manager.create_schema()
```

Suppose we want to index the [reuters.com](http://reuters.com/?ref=blog.langchain.com) front page. We can load and split the url contents with:

假设我们要索引 [reuters.com](http://reuters.com/?ref=blog.langchain.com) 的首页内容。我们可以使用以下代码加载并切分该网页的内容：

```python
# !pip install beautifulsoup4 tiktoken

import bs4
```

```python
# !pip install beautifulsoup4 tiktoken

import bs4
```

```python
from langchain.document_loaders import RecursiveUrlLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter

raw_docs = RecursiveUrlLoader(
    "<https://www.reuters.com>",
    max_depth=0,
    extractor=lambda x: BeautifulSoup(x, "lxml").text
).load()
processed_docs = RecursiveCharacterTextSplitter.from_tiktoken_encoder(
    chunk_size=200
).split_documents(raw_docs)
```

```python
from langchain.document_loaders import RecursiveUrlLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter

raw_docs = RecursiveUrlLoader(
    "<https://www.reuters.com>",
    max_depth=0,
    extractor=lambda x: BeautifulSoup(x, "lxml").text
).load()
processed_docs = RecursiveCharacterTextSplitter.from_tiktoken_encoder(
    chunk_size=200
).split_documents(raw_docs)
```

And now we’re ready to index! Suppose when we first index only the first 10 documents are on the front page:

现在我们已准备好进行索引！假设首次索引时，仅有前 10 篇文档位于首页：

```python
from langchain.indexes import index

index(
    processed_docs[:10],
    record_manager,
    vector_store,
    cleanup="full",
    source_id_key="source"
)
```

```python
from langchain.indexes import index

index(
    processed_docs[:10],
    record_manager,
    vector_store,
    cleanup="full",
    source_id_key="source"
)
```

```python
{'num_added': 10, 'num_updated': 0, 'num_skipped': 0, 'num_deleted': 0}
```

```python
{'num_added': 10, 'num_updated': 0, 'num_skipped': 0, 'num_deleted': 0}
```

And if we index an hour later, maybe 2 of the documents have changed:

如果一小时后再次执行索引，可能其中 2 篇文档已更新：

```python
index(
    process_docs[2:10] + processed_docs[-2:],
    record_manager,
    vector_store,
    cleanup="full",
    source_id_key="source",
)
```

```python
index(
    process_docs[2:10] + processed_docs[-2:],
    record_manager,
    vector_store,
    cleanup="full",
    source_id_key="source",
)
```

```python
{'num_added': 2, 'num_updated': 0, 'num_skipped': 8, 'num_deleted': 2}
```

```python
{'num_added': 2, 'num_updated': 0, 'num_skipped': 8, 'num_deleted': 2}
```

Looking at the output, we can see that while 10 documents were indexed the actual work we did was 2 additions and 2 deletions — we added the new documents, removed the old ones and skipped all the duplicate ones.

观察输出结果可知：尽管本次索引操作共处理了 10 篇文档，但实际执行的操作仅为 2 次新增和 2 次删除——即添加了两篇新文档、移除了两篇旧文档，其余 8 篇重复文档则被跳过。

For more in-depth examples, head to: [https://python.langchain.com/docs/modules/data_connection/indexing](https://python.langchain.com/docs/modules/data_connection/indexing?ref=blog.langchain.com)

如需更深入的示例，请访问：[https://python.langchain.com/docs/modules/data_connection/indexing](https://python.langchain.com/docs/modules/data_connection/indexing?ref=blog.langchain.com)

## ChatLangChain + Indexing API

## ChatLangChain + 索引 API

We’ve recently revamped the [https://github.com/langchain-ai/chat-langchain](https://github.com/langchain-ai/chat-langchain?ref=blog.langchain.com) chatbot for questions about LangChain. As part of the revamp, we revived the hosted version [https://chat.langchain.com](https://chat.langchain.com/?ref=blog.langchain.com) and set up a daily indexing job using the new API to make sure the chatbot is up to date with the latest LangChain developments.

我们近期全面重构了面向 LangChain 相关问题的聊天机器人项目 [https://github.com/langchain-ai/chat-langchain](https://github.com/langchain-ai/chat-langchain?ref=blog.langchain.com)。作为重构的一部分，我们重新上线了托管版聊天机器人 [https://chat.langchain.com](https://chat.langchain.com/?ref=blog.langchain.com)，并借助全新的索引 API 配置了每日自动索引任务，以确保聊天机器人始终同步最新的 LangChain 动态。

Doing this was very straightforward — all we had to do was:

这一过程非常简单——我们只需完成以下三步：

1. Set up a Supabase Postgres database to be used as a record manager,  
1. 配置一个 Supabase PostgreSQL 数据库，用作记录管理器（record manager）；  
2. Update our ingestion script to use the indexing API instead of inserting documents to the vector store directly,  
2. 更新数据摄取脚本，改用索引 API 进行文档处理，而非直接向向量数据库插入文档；  
3. Set up a scheduled Github Action to run the ingestion script daily. You can check out the GHA workflow [here](https://github.com/langchain-ai/chat-langchain/blob/master/.github/workflows/index.yml?ref=blog.langchain.com).

3. 配置一个定时 GitHub Action，每日自动运行该摄取脚本。您可在此查看该 GitHub Action 工作流：[https://github.com/langchain-ai/chat-langchain/blob/master/.github/workflows/index.yml?ref=blog.langchain.com](https://github.com/langchain-ai/chat-langchain/blob/master/.github/workflows/index.yml?ref=blog.langchain.com)。

![](images/syncing-data-sources-to-vector-stores/img_003.png)

![](images/syncing-data-sources-to-vector-stores/img_003.png)

## Conclusion

## 总结

As you move your apps from prototype to production, be able to re-indexing efficiently and keep documents in your vector in sync with their source becomes very important. LangChain's new indexing API provides a clean and scalable way to do this.

当您的应用从原型阶段迈向生产环境时，能否高效地重新索引数据、并确保向量数据库中的文档与其原始数据源保持同步，将变得至关重要。LangChain 全新推出的索引 API 为此提供了一种简洁且可扩展的解决方案。

Try it out and let us know what you think!

欢迎尝试，并告诉我们您的想法！
&#123;% endraw %}
