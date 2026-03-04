---
title: "Neo4j x LangChain: Deep dive into the new Vector index implementation"
source: "LangChain Blog"
url: "https://blog.langchain.com/neo4j-x-langchain-new-vector-index/"
date: "2023-09-07"
scraped_at: "2026-03-03T08:46:38.827805382+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

### Learn how to customize LangChain’s wrapper of Neo4j vector index

### 如何自定义 LangChain 对 Neo4j 向量索引的封装

_Editor's Note: This post was written in collaboration with the [Neo4j](https://neo4j.com/?ref=blog.langchain.com) team. We've been working closely with them on their new vector index and we're really impressed with its ability to efficiently perform semantic search over unstructured text or other embedded data modalities, unlocking support for RAG applications and more customization._

_编辑注：本文由 [Neo4j](https://neo4j.com/?ref=blog.langchain.com) 团队与我们合作撰写。我们一直紧密协作，共同推进其全新向量索引的开发；我们对其高效执行非结构化文本或其他嵌入式数据模态语义搜索的能力深感钦佩——这为 RAG（检索增强生成）应用及更多定制化场景提供了有力支持。_

[Neo4j](https://neo4j.com/?ref=blog.langchain.com) 过去和现在都是 [处理结构化信息](https://towardsdatascience.com/langchain-has-added-cypher-search-cb9d821120d5?ref=blog.langchain.com) 的绝佳选择，但由于其采用暴力遍历（brute-force）方式，语义搜索能力一度受限。然而，这一挑战已成为历史：Neo4j 已在 [5.11 版本中正式推出全新向量索引](https://neo4j.com/blog/vector-search-deeper-insights/?ref=blog.langchain.com)，专为高效执行非结构化文本或其他嵌入式数据模态的语义搜索而设计。新增的向量索引使 Neo4j 成为绝大多数 RAG 应用的理想选择——它如今可同时出色地支持结构化与非结构化数据。

![](images/neo4j-x-langchain-deep-dive-into-the-new-vector-index-implementation/img_001.png)图片由作者提供。

本文旨在系统性地介绍 LangChain 中 Neo4j 向量索引实现所支持的全部自定义选项。

相关代码已开源，详见 [GitHub](https://github.com/tomasonjo/blogs/blob/master/llm/neo4jvector_langchain_deepdive.ipynb?ref=blog.langchain.com)。

## Neo4j Environment setup

## Neo4j 环境搭建

为顺利运行本文中的示例，您需部署 Neo4j 5.11 或更高版本。最便捷的方式是通过 [Neo4j Aura](https://neo4j.com/cloud/platform/aura-graph-database/?ref=blog.langchain.com) 免费启动一个云端实例——Aura 提供托管式 Neo4j 图数据库服务。此外，您也可通过下载 [Neo4j Desktop](https://neo4j.com/download/?ref=blog.langchain.com) 桌面应用，在本地部署并创建一个 Neo4j 数据库实例。

## Example dataset

## 示例数据集

为便于演示，本文将使用 `WikipediaLoader` 加载《巫师》（The Witcher）维基百科页面的文本内容。

```tsx
from langchain.document_loaders import WikipediaLoader
from langchain.text_splitter import CharacterTextSplitter

# Read the wikipedia article
raw_documents = WikipediaLoader(query="The Witcher").load()
# Define chunking strategy
text_splitter = CharacterTextSplitter.from_tiktoken_encoder(
    chunk_size=1000, chunk_overlap=20
)
# Chunk the document
documents = text_splitter.split_documents(raw_documents)
# Remove the summary
for d in documents:
    del d.metadata["summary"]
```

```tsx
from langchain.document_loaders import WikipediaLoader
from langchain.text_splitter import CharacterTextSplitter

# 读取维基百科文章
raw_documents = WikipediaLoader(query="The Witcher").load()
# 定义分块策略
text_splitter = CharacterTextSplitter.from_tiktoken_encoder(
    chunk_size=1000, chunk_overlap=20
)
# 对文档进行分块
documents = text_splitter.split_documents(raw_documents)
# 删除摘要信息
for d in documents:
    del d.metadata["summary"]
```

### Neo4j Vector index customization

### Neo4j 向量索引自定义配置

Each text chunk is stored in Neo4j as a single isolated node.

每个文本块在 Neo4j 中均以一个独立的节点形式存储。

![](images/neo4j-x-langchain-deep-dive-into-the-new-vector-index-implementation/img_002.png)Graph schema of imported documents.

![](images/neo4j-x-langchain-deep-dive-into-the-new-vector-index-implementation/img_002.png)已导入文档的图谱结构示意图。

By default, Neo4j vector index implementation in LangChain represents the documents using the `Chunk` node label, where the `text` property stores the text of the document, and the `embedding` property holds the vector representation of the text. The implementation allows you to customize the node label, text and embedding property names.

默认情况下，LangChain 中的 Neo4j 向量索引实现使用 `Chunk` 节点标签来表示文档：其中 `text` 属性用于存储文档文本内容，`embedding` 属性则保存该文本的向量表示。该实现支持自定义节点标签名称，以及文本和嵌入向量所对应的属性名。

```tsx
neo4j_db = Neo4jVector.from_documents(
    documents,
    OpenAIEmbeddings(),
    url=url,
    username=username,
    password=password,
    database="neo4j",  # neo4j by default
    index_name="wikipedia",  # vector by default
    node_label="WikipediaArticle",  # Chunk by default
    text_node_property="info",  # text by default
    embedding_node_property="vector",  # embedding by default
    create_id_index=True,  # True by default
)
```

```tsx
neo4j_db = Neo4jVector.from_documents(
    documents,
    OpenAIEmbeddings(),
    url=url,
    username=username,
    password=password,
    database="neo4j",  // 默认为 "neo4j"
    index_name="wikipedia",  // 默认为 "vector"
    node_label="WikipediaArticle",  // 默认为 "Chunk"
    text_node_property="info",  // 默认为 "text"
    embedding_node_property="vector",  // 默认为 "embedding"
    create_id_index=True,  // 默认为 true
)
```

In this example, we have specified that we want to store text chunks under the `WikipediaArticle` node label, where the `info` property is used to store text, and the `vector` property holds the text embedding representation. If you run the above examples, you should see the following information in the database.

本例中，我们指定将文本块存储在 `WikipediaArticle` 节点标签下，其中 `info` 属性用于存储文本内容，`vector` 属性则用于保存文本的嵌入向量表示。若运行上述示例代码，您将在数据库中看到如下信息。

![](images/neo4j-x-langchain-deep-dive-into-the-new-vector-index-implementation/img_003.png)Node information.

![](images/neo4j-x-langchain-deep-dive-into-the-new-vector-index-implementation/img_003.png)节点信息。

As mentioned, we define the `info` property to contain the text information, while the `vector` property is used to store the embedding. Any other properties like the `source` and `title` are treated as document metadata.

如前所述，我们通过 `info` 属性承载文本内容，而 `vector` 属性用于存储嵌入向量；其余属性（例如 `source` 和 `title`）则被视作文档元数据。

By default, we also create a [unique node property constraint](https://neo4j.com/docs/cypher-manual/current/constraints/?ref=blog.langchain.com) on the id property of the specified node label for faster imports.  
默认情况下，我们还会在指定节点标签的 `id` 属性上创建一个[唯一节点属性约束](https://neo4j.com/docs/cypher-manual/current/constraints/?ref=blog.langchain.com)，以加快数据导入速度。

If you don’t want to create a unique constraint, you can set the `create_id_index` to false.  
如果您不希望创建该唯一约束，可将 `create_id_index` 参数设为 `false`。

You can verify that the constraint has been created by using the following Cypher statement:  
您可通过以下 Cypher 语句验证该约束是否已成功创建：

```tsx
neo4j_db.query("SHOW CONSTRAINTS")
#[{'id': 4,\
#  'name': 'constraint_e5da4d45',\
#  'type': 'UNIQUENESS',\
#  'entityType': 'NODE',\
#  'labelsOrTypes': ['WikipediaArticle'],\
#  'properties': ['id'],\
#  'ownedIndex': 'constraint_e5da4d45',\
#  'propertyType': None}]
```

As you would expect, we also create a vector index that will allow us to perform fast ANN searches.  
正如您所预期的，我们还会创建一个向量索引，从而支持快速的近似最近邻（ANN）搜索。

```tsx
neo4j_db.query(
    """SHOW INDEXES
       YIELD name, type, labelsOrTypes, properties, options
       WHERE type = 'VECTOR'
    """
)
#[{'name': 'wikipedia',\
#  'type': 'VECTOR',\
#  'labelsOrTypes': ['WikipediaArticle'],\
#  'properties': ['vector'],\
#  'options': {'indexProvider': 'vector-1.0',\
#   'indexConfig': {'vector.dimensions': 1536,\
#    'vector.similarity_function': 'cosine'}}}]
```

The LangChain implementation created a vector index named `wikipedia` , which indexes the `vector` property of `WikipediaArticle` nodes. Additionally, the provided configuration informs us that the vector embedding dimension is `1536` and uses the `cosine` similarity function.  
LangChain 的实现创建了一个名为 `wikipedia` 的向量索引，用于索引 `WikipediaArticle` 节点的 `vector` 属性。此外，该配置还表明：向量嵌入维度为 `1536`，且使用 `cosine`（余弦）相似度函数。

## Loading additional documents

## 加载更多文档

You can use the `add_documents` method to load additional documents into an instantiated vector index.  
您可以使用 `add_documents` 方法，将更多文档加载到已实例化的向量索引中。

```tsx
neo4j_db.add_documents(
    [\
        Document(\
            page_content="LangChain is the coolest library since the Library of Alexandria",\
            metadata={"author": "Tomaz", "confidence": 1.0}\
        )\
    ],
    ids=["langchain"],
)
```

LangChain allows you to provide document ids to the `add_document` method, which can be used to sync information across different system and make it easier to update or delete relevant text chunks.  
LangChain 允许您通过 `add_documents` 方法（注：原文误写为 `add_document`，此处按实际 API 名称 `add_documents` 翻译并加注说明）为文档指定 ID，以便在不同系统间同步信息，并更便捷地更新或删除相关文本片段。

![](images/neo4j-x-langchain-deep-dive-into-the-new-vector-index-implementation/img_004.png)

## Loading existing index

## 加载现有索引

If you have an existing vector index in Neo4j with populated data, you can use the `from_existing_method` to connect to it.

如果您已在 Neo4j 中创建了包含数据的向量索引，可使用 `from_existing_method` 连接到该索引。

```tsx
existing_index = Neo4jVector.from_existing_index(
    OpenAIEmbeddings(),
    url=url,
    username=username,
    password=password,
    index_name="wikipedia",
    text_node_property="info",  # Need to define if it is not default
)
```

```tsx
existing_index = Neo4jVector.from_existing_index(
    OpenAIEmbeddings(),
    url=url,
    username=username,
    password=password,
    index_name="wikipedia",
    text_node_property="info",  # 若非默认值（"text"），需显式指定
)
```

First, the `from_existing_method` checks if the index with the provided name actually exists in the database. If it exists, it can retrieve the node label and embedding node property from index configuration map, which means that you don’t have to manually set those.

首先，`from_existing_method` 会检查数据库中是否确实存在指定名称的索引。若存在，它将从索引的配置映射中自动提取节点标签（node label）和嵌入向量节点属性（embedding node property），因此您无需手动设置这两项。

```tsx
print(existing_index.node_label) # WikipediaArticle
print(existing_index.embedding_node_property) # vector
```

```tsx
print(existing_index.node_label) # WikipediaArticle
print(existing_index.embedding_node_property) # vector
```

However, the index information does not contain the text node property information. Therefore, if you use any property besides the default one (`text`), specify it using the `text_node_property` parameter.

然而，索引元信息中并不包含文本节点属性（text node property）的信息。因此，若您使用的文本属性不是默认的 `text`，请务必通过 `text_node_property` 参数显式指定。

## Custom retrieval queries

## 自定义检索查询

Since Neo4j is a native graph database, the vector index implementation in LangChain allows customization and enrichment of the returned information. However, this feature is intended for more advanced users as you are responsible for custom data loading as well as retrieval.

由于 Neo4j 是原生图数据库，LangChain 中的向量索引实现支持对检索结果进行自定义与增强。但该功能面向高级用户，因为您需自行负责定制化的数据加载及检索逻辑。

The `retrieval_query` parameter allows you to collect, transform, or calculate any additional graph information you want to return from the similarity search. To better understand it, we can look at the actual implementation in the code.

`retrieval_query` 参数允许您在相似性搜索结果中收集、转换或计算任意额外的图数据信息。为更清晰地理解其作用，我们可参考代码中的实际实现：

```tsx
read_query = (
    "CALL db.index.vector.queryNodes($index, $k, $embedding) "
    "YIELD node, score "
) + retrieval_query
```

```tsx
read_query = (
    "CALL db.index.vector.queryNodes($index, $k, $embedding) "
    "YIELD node, score "
) + retrieval_query
```

From the code, we can observe that the vector similarity search is hardcoded. However, we then have the option to add any intermediate steps and return additional information. The retrieval query must return the following three columns:

从代码中我们可以观察到，向量相似性搜索是硬编码的。但随后，我们可以选择添加任意中间步骤，并返回额外信息。检索查询必须返回以下三列：

- text (String): This is usually the textual data that is associated with the node that has been retrieved. This could be the main content of the node, a name, a description, or any other text-based information.

- text（字符串）：这通常是与所检索节点相关联的文本数据。它可以是节点的主要内容、名称、描述，或任何其他基于文本的信息。

- score (Float): This represents the similarity score between the query vector and the vector associated with the returned node. The score quantifies how similar the query is to the returned nodes, often on a scale from 0 to 1.

- score（浮点数）：表示查询向量与所返回节点对应向量之间的相似度得分。该得分量化了查询与返回节点的相似程度，通常取值范围为 0 到 1。

- metadata (Dictionary): This is a more flexible column that can contain additional information about the node or the search. It can be a dictionary (or map) that includes various attributes or properties that give more context to the returned node.

- metadata（字典）：这是一个更灵活的列，可用于承载关于该节点或本次搜索的附加信息。它可以是一个字典（或映射），包含各种属性或字段，从而为返回的节点提供更丰富的上下文。

We will add a relationship to a `WikipediaArticle` node to demonstrate this functionality.

我们将为 `WikipediaArticle` 节点添加一个关系，以演示此功能。

```tsx
existing_index.query(
    """MATCH (w:WikipediaArticle {id:'langchain'})
       MERGE (w)<-[:EDITED_BY]-(:Person {name:"Galileo"})
    """
)
```

We have added an `EDITED_BY` relationship to the `WikipediaArticle` node with the given id. Let’s now test out a custom retrieval option.

我们已为指定 ID 的 `WikipediaArticle` 节点添加了一个 `EDITED_BY` 关系。现在让我们测试一个自定义的检索选项。

```tsx
retrieval_query = """
OPTIONAL MATCH (node)<-[:EDITED_BY]-(p)
WITH node, score, collect(p) AS editors
RETURN node.info AS text,
       score,
       node {.*, vector: Null, info: Null, editors: editors} AS metadata
"""

existing_index_return = Neo4jVector.from_existing_index(
    OpenAIEmbeddings(),
    url=url,
    username=username,
    password=password,
    database="neo4j",
    index_name="wikipedia",
    text_node_property="info",
    retrieval_query=retrieval_query,
)
```

I won’t go too much into the specifics of Cypher. You can use many resources to learn the basic syntax and more like the [Neo4j Graph Academy](https://graphacademy.neo4j.com/?ref=blog.langchain.com). To construct a valid retrieval query, you must know that the relevant node from the vector similarity search is available under the `node` reference variable, while the similarity metric value is available under the `score` reference.

我不会过多深入 Cypher 的具体细节。你可以借助大量资源学习其基础语法及进阶用法，例如 [Neo4j Graph Academy](https://graphacademy.neo4j.com/?ref=blog.langchain.com)。要构建一个有效的检索查询，你需明确两点：向量相似性搜索所得的相关节点可通过 `node` 引用变量访问；而相似度指标值则通过 `score` 引用变量获取。

Let’s try it out.

让我们来实际运行一下。

```tsx
existing_index_return.similarity_search(
    "What do you know about LangChain?", k=1)
```

#[
#   Document("page_content=""LangChain is the coolest library since the Library of Alexandria",\
#   "metadata="{\
#      "author":"Tomaz",\
#      "confidence":1.0,\
#      "id":"langchain",\
#      "editors":[\
#         {\
#            "name":"Galileo"\
#         }\
#      ]\
#   }")"\
#]

#[
#   Document("page_content=""LangChain 是自亚历山大图书馆以来最酷的库",\
#   "metadata="{\
#      "author":"Tomaz",\
#      "confidence":1.0,\
#      "id":"langchain",\
#      "editors":[\
#         {\
#            "name":"Galileo"\
#         }\
#      ]\
#   }")"\
#]

You can observe that the metadata information contains the `editor` property, which was calculated from graph information.

您可以观察到，元数据信息中包含 `editor` 属性，该属性是从图数据中计算得出的。

## Summary

## 总结

The newly added vector index implementation in Neo4j allows it to support RAG applications that rely on both structured and unstructured data, making it a perfect fit for highly-complex and connected datasets.

Neo4j 新增的向量索引实现，使其能够支持依赖结构化与非结构化数据的 RAG（检索增强生成）应用，因而非常适用于高度复杂且相互关联的数据集。

The code is available on GitHub.

代码已在 GitHub 上开源。
&#123;% endraw %}
