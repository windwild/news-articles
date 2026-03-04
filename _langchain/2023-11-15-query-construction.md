---
render_with_liquid: false
title: "Query Construction"
source: "LangChain Blog"
url: "https://blog.langchain.com/query-construction/"
date: "2023-11-15"
scraped_at: "2026-03-03T08:26:40.326932287+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

**Key Links**

**关键链接**

- **Text-to-metadata: Updated self-query** [**docs**](https://python.langchain.com/docs/modules/data_connection/retrievers/self_query/?ref=blog.langchain.com#constructing-from-scratch-with-lcel) **and** [**template**](https://github.com/langchain-ai/langchain/tree/master/templates/rag-self-query?ref=blog.langchain.com)  
- **文本到元数据：更新后的自查询功能** [**文档**](https://python.langchain.com/docs/modules/data_connection/retrievers/self_query/?ref=blog.langchain.com#constructing-from-scratch-with-lcel) **和** [**模板**](https://github.com/langchain-ai/langchain/tree/master/templates/rag-self-query?ref=blog.langchain.com)

- **Text-to-SQL+semantic:** [**Cookbook**](https://github.com/langchain-ai/langchain/blob/master/cookbook/retrieval_in_sql.ipynb?ref=blog.langchain.com) **and** [**template**](https://github.com/langchain-ai/langchain/tree/master/templates/sql-pgvector?ref=blog.langchain.com)  
- **文本到 SQL + 语义检索：** [**示例手册（Cookbook）**](https://github.com/langchain-ai/langchain/blob/master/cookbook/retrieval_in_sql.ipynb?ref=blog.langchain.com) **和** [**模板**](https://github.com/langchain-ai/langchain/tree/master/templates/sql-pgvector?ref=blog.langchain.com)

There's great interest in seamlessly connecting natural language with diverse types of data (structured, unstructured, and semi-structured). But, this emerging "LUI" ( [language user interface](https://www.youtube.com/watch?v=zl4EdALzktU&ref=blog.langchain.com)) has specific challenges/considerations for each data type:

人们高度关注如何将自然语言与各类数据（结构化、非结构化及半结构化数据）无缝对接。然而，这一新兴的“LUI”（[语言用户界面，Language User Interface](https://www.youtube.com/watch?v=zl4EdALzktU&ref=blog.langchain.com)）针对不同类型的数据，各自面临特定的挑战与考量：

- **Structured Data**: Predominantly housed within SQL or Graph databases, structured data is characterized by predefined schemas and organized in tables or relations, making it amenable to precise query operations.  
- **结构化数据**：主要存储于 SQL 或图数据库中，其特点是具备预定义的模式（schema），并以表或关系形式组织，因而支持精确的查询操作。

- **Semi-structured Data**: Semi-structured data blends structured elements (e.g., tables in a document or relational database) with unstructured elements (e.g., text or an embedding column in a relational database).  
- **半结构化数据**：融合了结构化元素（例如文档或关系型数据库中的表格）与非结构化元素（例如关系型数据库中的文本字段或嵌入向量列）。

- **Unstructured Data**: Typically stored in vector databases, unstructured data consists of information without a predefined model, frequently accompanied by structured metadata that enables filtering.  
- **非结构化数据**：通常存储于向量数据库中，指那些没有预定义模型的信息，常附带结构化的元数据，从而支持过滤操作。

![](https://lh7-us.googleusercontent.com/3LF54xcUcbPTofWh7fTQZCvjfQLU83fMwkCsad_S0i5OoDBfKC0RMlSpwi-h23Ze3KSqKG_PemvIukEfg_GrMjucZTVBFK7SpyPOICdVqUx7Wl4pcy-_clJeGPE9lkWgEhA5FFjAdXiWhLZ1706mqjc)

![](https://lh7-us.googleusercontent.com/3LF54xcUcbPTofWh7fTQZCvjfQLU83fMwkCsad_S0i5OoDBfKC0RMlSpwi-h23Ze3KSqKG_PemvIukEfg_GrMjucZTVBFK7SpyPOICdVqUx7Wl4pcy-_clJeGPE9lkWgEhA5FFjAdXiWhLZ1706mqjc)

To address these challenges, LLMs have great capacity for **query construction**, the process of converting natural language into a specific query syntax for each data type. For this third installment in our blog series on advanced retrieval, we'll be covering various strategies for **query construction** (see our blog posts on [**Multi-Representation Indexing**](https://blog.langchain.com/semi-structured-multi-modal-rag/) and [**Query Transformation**](https://blog.langchain.com/query-transformations/) for more.)

为应对上述挑战，大语言模型（LLM）在**查询构建（query construction）**方面展现出强大能力——即把自然语言转换为适配各类数据的特定查询语法。作为本系列关于高级检索技术博客的第三篇，本文将系统介绍多种**查询构建策略**（更多相关内容可参阅我们此前发布的博客文章：[**多表示索引（Multi-Representation Indexing）**](https://blog.langchain.com/semi-structured-multi-modal-rag/) 和 [**查询变换（Query Transformation）**](https://blog.langchain.com/query-transformations/)）。

![](images/query-construction/img_002.png)

![](images/query-construction/img_002.png)

## **What is Query Construction?**

## **什么是查询构建（Query Construction）？**

With typical retrieval augmented generation (RAG), a user query is converted into a vector representation. This vector is then compared to vector representations of the source documents to find the most similar ones. This works fairly well for unstructured data (see our blog posts on [**Multi-Representation Indexing**](https://blog.langchain.com/semi-structured-multi-modal-rag/) and [**Query Transformation**](https://blog.langchain.com/query-transformations/)), but what about structured data?

在典型的检索增强生成（RAG）流程中，用户查询首先被转化为向量表示；随后，该向量与源文档的向量表示进行比对，以找出最相似的若干文档。该方法对非结构化数据效果良好（详见我们此前发布的博客：[**多表示索引（Multi-Representation Indexing）**](https://blog.langchain.com/semi-structured-multi-modal-rag/) 和 [**查询变换（Query Transformation）**](https://blog.langchain.com/query-transformations/)），但面对结构化数据时又该如何处理？

Most data in the world has some structure. Much of this data lives in relational (e.g., SQL) or graph databases. And even unstructured data often associated structured metadata (e.g., things like the author, genre, data published, etc).

全球绝大多数数据都具有某种结构。其中大量数据存于关系型（如 SQL）或图数据库中；即便是非结构化数据，也常常关联着结构化的元数据（例如作者、类型、发布日期等）。

💡

许多用户查询的最佳回答方式，不仅在于在嵌入空间中查找语义相似的文档或数据，更在于充分利用数据本身固有的结构，以及用户查询中所体现的结构化意图。

例如，考虑查询 `1980 年关于外星人的电影有哪些`。其中一部分（`外星人`）我们希望进行语义检索，而另一部分（`"年份 == 1980"`）则需要以**精确匹配**的方式进行查找。

💡

**查询构建（Query construction）** 是指将自然语言查询转换为所交互数据库的查询语言的过程。

接下来，我们将重点介绍几种典型的查询构建场景，并为每种场景提供相应的实用指南（cookbooks）、模板及文档参考：

|     |     |     |
| --- | --- | --- |
| 示例 | 数据源 | 参考资料 |
| 文本→元数据过滤器（Text-to-metadata-filter） | 向量数据库（Vectorstores） | [文档](https://python.langchain.com/docs/modules/data_connection/retrievers/self_query/?ref=blog.langchain.com#constructing-from-scratch-with-lcel) |
| 文本→SQL（Text-to-SQL） | SQL 数据库 | [文档](https://python.langchain.com/docs/use_cases/qa_structured/sql?ref=blog.langchain.com)，[博客](https://blog.langchain.com/llms-and-sql/)，[博客](https://blog.langchain.com/incorporating-domain-specific-knowledge-in-sql-llm-solutions/) |
| 文本→SQL + 语义检索（Text-to-SQL+ Semantic） | 支持 PGVector 的 SQL 数据库 | [实用指南（Cookbook）](https://github.com/langchain-ai/langchain/blob/master/cookbook/retrieval_in_sql.ipynb?ref=blog.langchain.com) |
| 文本→Cypher（Text-to-Cypher） | 图数据库（Graph databases） | [博客](https://blog.langchain.com/using-a-knowledge-graph-to-implement-a-devops-rag-application/)，[博客](https://blog.langchain.com/implementing-advanced-retrieval-rag-strategies-with-neo4j/)，[文档](https://python.langchain.com/docs/use_cases/graph/graph_cypher_qa?ref=blog.langchain.com) |

## **文本→元数据过滤器（Text-to-metadata-filter）**

支持[元数据过滤](https://docs.trychroma.com/usage-guide?ref=blog.langchain.com#filtering-by-metadata)的向量数据库，能够对嵌入后的非结构化文档执行结构化查询与过滤。[自查询检索器（self-query retriever）](https://python.langchain.com/docs/modules/data_connection/retrievers/self_query/?ref=blog.langchain.com#constructing-from-scratch-with-lcel) 可通过若干步骤，将自然语言查询自动转化为此类结构化查询：

- **数据源定义（Data Source Definition）**：自查询检索器的核心基础，是对相关元数据字段的明确定义（例如，在歌曲检索场景中，可能包括歌手、时长、流派等字段）。
- **用户查询解析（User Query Interpretation）**：针对一条自然语言问题，自查询检索器会分离出用于语义检索的关键词（query），以及用于元数据过滤的条件（filter）。例如，对查询 `由 Taylor Swift 或 Katy Perry 演唱、主题为青少年浪漫、时长不足 3 分钟、属于舞曲流行风格的歌曲`，系统将自动拆解为语义查询部分与元数据过滤条件。
- **逻辑条件提取（Logical Condition Extraction）**：该过滤条件由向量数据库所支持的比较符与操作符（如 `eq` 表示“等于”，`lt` 表示“小于”）构建而成。
- **结构化请求生成（Structured Request Formation）**：最终，自查询检索器将组装成一个结构化请求——将语义搜索项（query）与逻辑过滤条件（filter）明确分离，从而显著提升文档检索的精准性与效率。

We can define a chain to execute the above steps, which accepts a user question and returns a StructuredQuery object that encapsulates the necessary filters:

我们可以定义一条链来执行上述步骤：该链接收用户问题，并返回一个封装了必要过滤条件的 `StructuredQuery` 对象：

```python
# Generate a prompt and parse output
prompt = get_query_constructor_prompt(document_content_description, metadata_field_info)
output_parser = StructuredQueryOutputParser.from_components()
query_constructor = prompt | llm | output_parser

# Invoke the query constructor with a sample query
query_constructor.invoke({
 "query": "Songs by Taylor Swift or Katy Perry about teenage romance under 3 minutes long in the dance pop genre"
})
```

```python
# 生成提示词并解析输出
prompt = get_query_constructor_prompt(document_content_description, metadata_field_info)
output_parser = StructuredQueryOutputParser.from_components()
query_constructor = prompt | llm | output_parser

# 使用示例查询调用查询构造器
query_constructor.invoke({
 "query": "Taylor Swift 或 Katy Perry 演唱的、时长不足3分钟、风格为舞曲流行（dance pop）的关于青少年恋爱的歌曲"
})
```

The structured request would look like:

结构化请求将如下所示：

```python
{
 "query": "teenager love",
 "filter": "and(or(eq(\"artist\", \"Taylor Swift\"), eq(\"artist\", \"Katy Perry\")), lt(\"length\", 180), eq(\"genre\", \"pop\"))"
}
```

```python
{
 "query": "青少年恋爱",
 "filter": "and(or(eq(\"artist\", \"Taylor Swift\"), eq(\"artist\", \"Katy Perry\")), lt(\"length\", 180), eq(\"genre\", \"pop\"))"
}
```

This approach can significantly improve RAG answer quality when interacting with vector databases because logical filter conditions inferred directly from the user question gate the text chunks passed to the LLM for final answer synthesis.

这一方法在与向量数据库交互时可显著提升 RAG（检索增强生成）答案的质量，因为从用户问题中直接推断出的逻辑过滤条件，能够对传递给大语言模型（LLM）用于最终答案合成的文本块进行有效筛选。

**Read more:**

**延伸阅读：**

- [Docs](https://python.langchain.com/docs/modules/data_connection/retrievers/self_query?ref=blog.langchain.com): Self-querying retriever  
- [文档](https://python.langchain.com/docs/modules/data_connection/retrievers/self_query?ref=blog.langchain.com)：自查询检索器（Self-querying Retriever）

- [Template](https://github.com/langchain-ai/langchain/tree/master/templates/self-query-supabase?ref=blog.langchain.com): Self-query Supabase vector db  
- [模板](https://github.com/langchain-ai/langchain/tree/master/templates/self-query-supabase?ref=blog.langchain.com)：基于 Supabase 向量数据库的自查询方案

- [Template](https://github.com/langchain-ai/langchain/tree/master/templates/rag-self-query?ref=blog.langchain.com): Self-query Elastic vector db  
- [模板](https://github.com/langchain-ai/langchain/tree/master/templates/rag-self-query?ref=blog.langchain.com)：基于 Elastic 向量数据库的自查询 RAG 方案

## **Text-to-SQL**

## **文本到 SQL（Text-to-SQL）**

On the other end of the data continuum, SQL / relational databases are important sources of largely structured data. Considerable effort has focused on translating natural language into SQL requests, with a few notable challenges such as:

在数据谱系的另一端，SQL / 关系型数据库是高度结构化数据的重要来源。大量研究工作聚焦于将自然语言转化为 SQL 查询语句，其中存在若干突出挑战，例如：

- **Hallucination**: LLMs are prone to ‘hallucination’ of fictitious tables or fields, thus creating invalid queries. Approaches must ground these LLMs in reality, ensuring they produce valid SQL aligned with the actual database schema.  
- **幻觉（Hallucination）**：大语言模型（LLM）容易“幻觉”出并不存在的表或字段，从而生成无效的 SQL 查询。因此，相关方法必须将这些 LLM “锚定”于现实，确保其生成的 SQL 严格符合实际数据库的 Schema。

- **User errors**: Text-to-SQL approaches should be robust to user mis-spellings or other irregularities in the user input that could results in invalid queries.  
- **用户输入错误**：文本到 SQL（Text-to-SQL）方法需具备鲁棒性，以应对用户拼写错误或其他输入不规范问题，避免由此导致无效查询。

With these challenges in mind a few tricks have emerged:  
考虑到上述挑战，业界已涌现出若干实用技巧：

- **Database Description**: To ground SQL queries, an LLM must be provided with an accurate description of the database. One common text-to-SQL [prompt](https://smith.langchain.com/hub/rlm/text-to-sql?organizationId=1fa8b1f4-fcb9-4072-9aa9-983e35ad61b8&ref=blog.langchain.com) employs an idea reported in several [papers](https://arxiv.org/pdf/2204.00498.pdf?ref=blog.langchain.com): provide the LLM with a `CREATE TABLE` description for each table, which include column names, their types, etc followed by three example rows in a SELECT statement.  
- **数据库描述（Database Description）**：为使 SQL 查询具备事实依据，必须向 LLM 提供准确、详尽的数据库描述。一种常见的 Text-to-SQL [提示模板（prompt）](https://smith.langchain.com/hub/rlm/text-to-sql?organizationId=1fa8b1f4-fcb9-4072-9aa9-983e35ad61b8&ref=blog.langchain.com) 借鉴了多篇 [研究论文](https://arxiv.org/pdf/2204.00498.pdf?ref=blog.langchain.com) 中提出的方法：为每个数据表提供标准的 `CREATE TABLE` 语句（含列名、数据类型等），再附上三条 `SELECT` 查询示例结果。

- **Few-shot examples**: Feeding the prompt with few-shot examples of question-query matches can [improve the query generation accuracy.](https://arxiv.org/abs/2204.00498?ref=blog.langchain.dev) This can be achieved by simply appending standard static examples in the prompt to guide the agent on how it should build queries based on questions.  
- **少样本示例（Few-shot examples）**：在提示中嵌入若干“问题–SQL 查询”配对的少样本示例，可显著[提升查询生成的准确性](https://arxiv.org/abs/2204.00498?ref=blog.langchain.dev)。实现方式简单直接：在 prompt 中追加若干标准化、静态的示例，用以引导模型理解如何根据自然语言问题构建对应 SQL。

- **Error Handling**: When faced with errors, data analysts don't give up—they iterate. We can use tools like SQL agents ( [here](https://python.langchain.com/docs/use_cases/qa_structured/sql?ref=blog.langchain.com#case-3-sql-agents)) to recover from errors.  
- **错误处理（Error Handling）**：面对错误时，数据分析师不会放弃——而是持续迭代调试。我们可借助 SQL Agent 等工具（[详见此处](https://python.langchain.com/docs/use_cases/qa_structured/sql?ref=blog.langchain.com#case-3-sql-agents)）实现自动容错与错误恢复。

![](https://lh7-us.googleusercontent.com/brppVAJmTMYIUPFJlhkLtV7gD4cBqhWrToZb3HdE_2jl41YBArRntr_KtrrlVwpEZL9U9DyxwEz1SKi4JvXBpZkq2rfDC-v-G03vs1T00LB3qrn8qD00Zs5FPh3zk9--aTv-D-uuaJVTTYjVISXA3ag)

- **Finding misspellings in proper nouns**: When querying for proper nouns like names, a user may inadvertently write it incorrectly (e.g. `Franc Sinatra`). We can allow an agent to search for proper nouns against a vectorstore, which houses correct spellings for relevant proper nouns in the SQL database.  
- **识别专有名词拼写错误**：当用户查询姓名等专有名词时，可能无意中拼错（例如输入 `Franc Sinatra`）。此时，可让智能体（agent）在向量数据库（vectorstore）中检索该专有名词——该向量库预先存储了 SQL 数据库中相关专有名词的标准正确拼写。

**Read more:**  
**延伸阅读：**

- [Docs](https://python.langchain.com/docs/use_cases/qa_structured/sql?ref=blog.langchain.com): QA over structured data  
- [文档](https://python.langchain.com/docs/use_cases/qa_structured/sql?ref=blog.langchain.com)：结构化数据上的问答（QA）

- [Blog](https://blog.langchain.com/llms-and-sql/): LLMs and SQL  
- [博客](https://blog.langchain.com/llms-and-sql/)：大语言模型与 SQL

- [Blog](https://blog.langchain.com/incorporating-domain-specific-knowledge-in-sql-llm-solutions/): Incorporating domain specific knowledge in SQL-LLM solutions  
- [博客](https://blog.langchain.com/incorporating-domain-specific-knowledge-in-sql-llm-solutions/)：在 SQL-LLM 解决方案中融入领域专属知识

## **Text-To-SQL+semantic**  

## **Text-To-SQL + 语义增强（Text-To-SQL+semantic）**

In the middle of the data continuum, mixed type (structured and unstructured) data storage is increasingly common. The [addition of vector support](https://x.com/swyx/status/1722520752191307826?s=20&ref=blog.langchain.com) to relational databases is a key enabler of approaches that support hybrid retrieval (see recent video from AI Engineer summit [here](https://www.youtube.com/watch?v=MDxEXKkxf2Q&ref=blog.langchain.com)). In particular, the [open-source](https://github.com/pgvector/pgvector?ref=blog.langchain.com) pgvector extension for PostgreSQL marries the expressiveness of SQL with the nuanced understanding of semantics provided by semantic search. Pgvector has reported favorable performance and cost relative to [vectorstores like Pinecone](https://supabase.com/blog/pgvector-vs-pinecone?ref=blog.langchain.com).  
在数据谱系的中间地带，混合类型（结构化与非结构化）数据共存的存储模式日益普遍。关系型数据库原生支持向量（[vector support](https://x.com/swyx/status/1722520752191307826?s=20&ref=blog.langchain.com)）已成为支撑“混合检索”（hybrid retrieval）的关键能力（参见 AI 工程师峰会近期视频 [此处](https://www.youtube.com/watch?v=MDxEXKkxf2Q&ref=blog.langchain.com)）。其中，PostgreSQL 的开源扩展 [pgvector](https://github.com/pgvector/pgvector?ref=blog.langchain.com) 尤为突出——它将 SQL 强大的表达能力与语义搜索所具备的细腻语义理解能力有机融合。相比 Pinecone 等专用向量数据库（[vectorstore](https://supabase.com/blog/pgvector-vs-pinecone?ref=blog.langchain.com)），pgvector 在性能与成本方面均展现出显著优势。

Pgvector makes it possible to execute similarity search (e.g., cosine, L2 distance, inner product) over a embeddings vector column the `<->` operator:  
pgvector 支持通过 `<->` 运算符，在 embedding 向量列上直接执行相似度搜索（例如余弦相似度、欧氏距离 L2、内积等）：

```python
SELECT * FROM tracks ORDER BY "name_embedding" <-> {sadness_embedding}
```

```python
SELECT * FROM tracks ORDER BY "name_embedding" <-> {sadness_embedding}
```

From the above query, we can use LIMIT 3 to get the top `3 saddest tracks` (similar to top\_k value from standard kNN), but also more complex operations, such as picking the saddest one, and the 90th and 50th percentile for some reason. This unlocks two important new capabilities:

上述查询中，我们可通过添加 `LIMIT 3` 获取最悲伤的前 `3 首歌曲`（其作用类似于标准 kNN 中的 `top_k` 参数），但也能支持更复杂的操作，例如：单独选出最悲伤的一首歌，或按某种需求选取第 90 百分位和第 50 百分位的歌曲。这解锁了两项关键的新能力：

- We can perform semantic searches that are infeasible with a vectorstore  
- 我们可执行向量数据库（vectorstore）难以实现的语义搜索  

- We can enhance text-to-SQL with knowledge of the semantic operator. For example, it unlocks text-to-semantic searches (e.g., finding songs with titles conveying specific feelings) and SQL queries (e.g., filtering by genre).  
- 我们可借助对语义算子（semantic operator）的理解，增强文本到 SQL（text-to-SQL）的能力。例如，它支持“文本到语义搜索”（如：查找标题传达特定情绪的歌曲），也支持语义增强的 SQL 查询（如：按流派过滤）。

Following the album-song examples, with this approach we could find albums containing the most songs matching a certain sentiment (using semantic similarity as a filter or count for tabular data) or find sad songs from albums with "lovely" titles (combining two semantic searches in one single query, which wouldn’t be possible using a vector database with metadata filtering).

沿用前述“专辑–歌曲”的示例，采用该方法，我们可找出包含最多符合某类情感（如“悲伤”）歌曲的专辑（将语义相似度用作表格数据的筛选条件或计数依据）；也可一次性查出标题含“lovely”且歌曲本身又属“悲伤”风格的专辑中的悲伤歌曲——即在一个查询中融合两项语义搜索。而若仅依赖带元数据过滤功能的向量数据库，则无法实现此类组合式语义查询。

**Read more:**  
**了解更多：**

- [Cookbook](https://github.com/langchain-ai/langchain/blob/master/cookbook/retrieval_in_sql.ipynb?ref=blog.langchain.com): Retrieval in SQL  
- [食谱（Cookbook）](https://github.com/langchain-ai/langchain/blob/master/cookbook/retrieval_in_sql.ipynb?ref=blog.langchain.com)：SQL 中的检索  

- [Template](https://github.com/langchain-ai/langchain/tree/master/templates/sql-pgvector?ref=blog.langchain.com)  
- [模板（Template）](https://github.com/langchain-ai/langchain/tree/master/templates/sql-pgvector?ref=blog.langchain.com)

## **Text-to-Cypher**  
## **文本到 Cypher（Text-to-Cypher）**

While vector stores readily handle unstructured data, they don't understand the relationships between vectors. And while SQL databases can model relationships, schema changes can be disruptive and costly. Knowledge graphs can address these challenges by modeling the relationships between data and extending the types of relationships without a major overhaul. They are desirable for data that has many-to-many relationships or hierarchies that are difficult to represent in tabular form.

尽管向量数据库能高效处理非结构化数据，却无法理解向量之间的语义关系；而关系型数据库虽可建模数据间的关系，但模式（schema）变更往往代价高昂、影响广泛。知识图谱（Knowledge Graph）则能应对这些挑战：它通过显式建模数据间的关联，并在无需大规模重构的前提下灵活扩展关系类型。对于存在多对多关系或复杂层级结构（难以用表格形式表达）的数据而言，知识图谱尤为适用。

Like relational databases often use SQL, graph databases often use a specific query language called [Cypher, which is designed to provide a visual way of matching patterns and relationships](https://blog.langchain.com/using-a-knowledge-graph-to-implement-a-devops-rag-application/). It relies on the following ascii-art type of syntax:

正如关系型数据库普遍使用 SQL，图数据库通常采用一种专用查询语言——[Cypher](https://blog.langchain.com/using-a-knowledge-graph-to-implement-a-devops-rag-application/)。Cypher 的设计初衷是提供一种可视化方式，以直观匹配图中的模式与关系。其语法采用类似 ASCII 艺术的风格，如下所示：

```python
(:Person {name:"Tomaz"})-[:LIVES_IN]->(:Country {name:"Slovenia"})
```

```python
(:Person {name:"Tomaz"})-[:LIVES_IN]->(:Country {name:"Slovenia"})
```

This pattern describes a node with a label `Person` and the name property `Tomaz` that has a `LIVES_IN` relationship to the Country node of `Slovenia`. Like the above examples, [text-to-Cypher](https://python.langchain.com/docs/use_cases/graph/graph_cypher_qa?ref=blog.langchain.dev) can translate natural language to Cypher queries:

该模式描述了一个标签为 `Person`、`name` 属性为 `Tomaz` 的节点，它通过 `LIVES_IN` 关系连接到国家节点 `Slovenia`。与上述示例类似，[文本转 Cypher（text-to-Cypher）](https://python.langchain.com/docs/use_cases/graph/graph_cypher_qa?ref=blog.langchain.dev) 可将自然语言翻译为 Cypher 查询：

```python
from langchain.chains import GraphCypherQAChain

graph.refresh_schema()

cypher_chain = GraphCypherQAChain.from_llm(
    cypher_llm = ChatOpenAI(temperature=0, model_name='gpt-4'),
    qa_llm = ChatOpenAI(temperature=0), graph=graph, verbose=True,
)
```

```python
from langchain.chains import GraphCypherQAChain

graph.refresh_schema()

cypher_chain = GraphCypherQAChain.from_llm(
    cypher_llm = ChatOpenAI(temperature=0, model_name='gpt-4'),
    qa_llm = ChatOpenAI(temperature=0), graph=graph, verbose=True,
)
```

Because generating valid Cypher can be a complex task, it is recommended to use performant LLMs like GPT-4 to generate Cypher statements as the `cypher_llm`. As shown above, we can then ask questions in natural language.

由于生成合法的 Cypher 查询是一项复杂任务，建议使用高性能大语言模型（如 GPT-4）作为 `cypher_llm` 来生成 Cypher 语句。如上所示，之后我们即可用自然语言提出问题。

```python
cypher_chain.run(
    "How many open tickets there are?"
)
```

```python
cypher_chain.run(
    "当前有多少个未关闭的工单？"
)
```

See docs  
参阅文档

- [Blog](https://blog.langchain.com/using-a-knowledge-graph-to-implement-a-devops-rag-application/): Using a Knowledge Graph to implement a DevOps RAG application  
- [博客](https://blog.langchain.com/using-a-knowledge-graph-to-implement-a-devops-rag-application/)：利用知识图谱实现 DevOps 场景下的 RAG 应用  
- [Blog](https://blog.langchain.com/implementing-advanced-retrieval-rag-strategies-with-neo4j/): Implementing advanced RAG strategies with Neo4j  
- [博客](https://blog.langchain.com/implementing-advanced-retrieval-rag-strategies-with-neo4j/)：使用 Neo4j 实现高级检索增强生成（RAG）策略  
- [Docs](https://python.langchain.com/docs/use_cases/graph/graph_cypher_qa?ref=blog.langchain.com): Neo4j DB QA chain  
- [文档](https://python.langchain.com/docs/use_cases/graph/graph_cypher_qa?ref=blog.langchain.com)：Neo4j 数据库问答链（Neo4j DB QA chain）

## **Conclusion**  
## **结语**

Seamlessly retrieving structured and unstructured data across a variety of data sources is crucial for unlocking the potential of LLMs. We summarize four popular "natural-language-to-structured query" pipelines that have emerged for various types of datastores and provide templates and cookbooks for users to get started.

在多种数据源之间无缝检索结构化与非结构化数据，对充分释放大语言模型（LLM）的潜力至关重要。本文总结了目前面向各类数据存储系统兴起的四种主流“自然语言→结构化查询”流水线，并为用户提供了开箱即用的模板与实践指南（cookbooks），助其快速上手。

![](images/query-construction/img_004.png)