---
title: "Graph-based metadata filtering for improving vector search in RAG applications"
source: "LangChain Blog"
url: "https://blog.langchain.com/graph-based-metadata-filtering-for-improving-vector-search-in-rag-applications/"
date: "2024-04-25"
scraped_at: "2026-03-03T08:03:35.597133282+00:00"
language: "en-zh"
translated: true
tags: ["Partner Post"]
---

### Optimizing vector retrieval with advanced graph-based metadata techniques using LangChain and Neo4j

### 使用 LangChain 和 Neo4j，借助先进的基于图的元数据技术优化向量检索

_Editor's Note: the following is a guest blog post from Tomaz Bratanic, who focuses on Graph ML and GenAI research at_ [_Neo4j_](https://neo4j.com/?utm_source=Google&utm_medium=PaidSearch&utm_campaign=Evergreenutm_content%3DAMS-Search-SEMBrand-Evergreen-None-SEM-SEM-NonABM&utm_term=neo4j&utm_adgroup=core-brand&gad_source=1&gclid=CjwKCAjw48-vBhBbEiwAzqrZVOnH2D4WOkRLH78FtQAFitObkbJNs34kTFw4bbBX0VzwqSalQUV2UhoCrFcQAvD_BwE) _._ _Neo4j is a graph database and analytics company which helps organizations find hidden relationships and patterns across billions of data connections deeply, easily, and quickly._

_编辑注：以下为 Neo4j 公司 Graph ML 与生成式 AI（GenAI）研究员 Tomaz Bratanic 撰写的客座博客文章。_ [_Neo4j_](https://neo4j.com/?utm_source=Google&utm_medium=PaidSearch&utm_campaign=Evergreenutm_content%3DAMS-Search-SEMBrand-Evergreen-None-SEM-SEM-NonABM&utm_term=neo4j&utm_adgroup=core-brand&gad_source=1&gclid=CjwKCAjw48-vBhBbEiwAzqrZVOnH2D4WOkRLH78FtQAFitObkbJNs34kTFw4bbBX0VzwqSalQUV2UhoCrFcQAvD_BwE) _是一家图数据库与分析公司，致力于帮助组织深入、高效、快速地从数十亿级数据连接中发现隐藏的关系与模式。_

Text embeddings and vector similarity search help us find documents by understanding their meanings and how similar they are to each other. However, text embeddings aren’t as effective when sorting information based on specific criteria like dates or categories; for example, if you need to find all documents created in a particular year or documents tagged under a specific category like “science fiction.” This is where metadata filtering or filtered vector search comes into play, as it can effectively handle those structured filters, allowing users to narrow their search results according to specific attributes.

文本嵌入（text embeddings）与向量相似性搜索（vector similarity search）使我们能够基于语义理解及彼此间的语义相似度来查找文档。然而，当需要依据特定结构化条件（如日期、类别等）对信息进行筛选时，纯文本嵌入的效果往往有限；例如，若需检索某一年份创建的所有文档，或标记为“科幻小说”的所有文档，仅靠文本嵌入便难以胜任。此时，元数据过滤（metadata filtering）或称“带过滤的向量搜索”（filtered vector search）便应运而生——它能高效处理此类结构化筛选条件，使用户可依据具体属性精准缩小搜索结果范围。

![](images/graph-based-metadata-filtering-for-improving-vector-search-in-rag-applications/img_001.png)Metadata filtering using the pre-filtering approach, where you first narrow down the set of relevant documents and then apply vector similarity search on the narrowed set. Image by author.

![](images/graph-based-metadata-filtering-for-improving-vector-search-in-rag-applications/img_001.png)采用预过滤（pre-filtering）方式的元数据过滤：先缩小相关文档集合，再在该子集中执行向量相似性搜索。图片由作者提供。

In the image provided, the process starts with a user asking whether any new policies were implemented in 2021. A metadata filter is then used to sort through a larger pool of indexed documents by the specified year, which in this case is 2021. This results in a filtered subset of documents from that year only. To further hone in on the most relevant documents, a vector similarity search is performed within this subset. This method allows the system to find documents closely related to the topic of interest from within the contextually relevant pool of documents from the year 2021. This two-step process, metadata filtering followed by vector similarity search, increases the accuracy and relevance of the search results.

图中所示流程始于用户提问：“2021 年是否出台了任何新政策？”随后，系统利用元数据过滤器，在已索引的全部文档池中按指定年份（此处为 2021 年）进行筛选，从而得到仅包含该年度文档的过滤子集。为进一步聚焦最相关的文档，系统在此子集内执行向量相似性搜索。该方法使系统得以在 2021 年这一上下文高度相关的文档池中，精准定位与用户查询主题高度语义匹配的文档。这种“元数据过滤 + 向量相似性搜索”的两阶段流程，显著提升了搜索结果的准确性与相关性。

Recently, we introduced [LangChain support for metadata filtering](https://python.langchain.com/docs/integrations/vectorstores/neo4jvector/?ref=blog.langchain.com#metadata-filtering) in Neo4j based on node properties. However, graph databases like [Neo4j](https://neo4j.com/docs/getting-started/get-started-with-neo4j/?ref=blog.langchain.com) can store highly complex and connected structured data alongside unstructured data. Let’s take a look at the following example:

近期，我们在 Neo4j 中正式推出对元数据过滤的 [LangChain 支持](https://python.langchain.com/docs/integrations/vectorstores/neo4jvector/?ref=blog.langchain.com#metadata-filtering)，该功能基于图节点（node）的属性实现。然而，像 [Neo4j](https://neo4j.com/docs/getting-started/get-started-with-neo4j/?ref=blog.langchain.com) 这样的图数据库，不仅能存储非结构化数据（如文本），更能同时承载高度复杂且深度关联的结构化数据。请参见如下示例：

![](images/graph-based-metadata-filtering-for-improving-vector-search-in-rag-applications/img_002.png)Graph representation of highly connected data alongside unstructured data. Image by author.

![](images/graph-based-metadata-filtering-for-improving-vector-search-in-rag-applications/img_002.png)高度关联的结构化数据与非结构化数据的图谱化表示。图片由作者提供。

The unstructured part of the dataset represents articles and their text chunks, located at the top right of the visualization. Text chunk nodes contain text and their text embedding values and are linked to the article nodes, where more information about the article, such as the date, sentiment, author, etc., is present. However, the articles are then further linked to the organizations they mention. In this example, the article mentions Neo4j. Additionally, our dataset includes a wealth of structured information about Neo4j such as its investors, board members, suppliers, and beyond.

数据集中的非结构化部分表现为文章及其文本分块（text chunks），位于图谱可视化右上方。每个文本分块节点包含原始文本内容及其对应的文本嵌入向量，并与“文章节点”相连；后者则存储了更丰富的结构化信息，如发布日期、情感倾向、作者等。进一步地，这些文章节点还与文中提及的组织机构建立关联。本例中，该文章提到了 Neo4j。此外，我们的数据集还包含了大量关于 Neo4j 的结构化信息，例如其投资方、董事会成员、供应商等。

Thus, we can leverage this extensive structured information to execute sophisticated metadata filtering, allowing us to precisely refine our document selection using structured criteria such as:

因此，我们可以充分利用这些丰富而精细的结构化信息，实现更高级别的元数据过滤，从而依据如下结构化条件，精准细化文档筛选：

- Did any of the companies where Rod Johnson is the board member implement a new work-from-home policy?  
  - 罗德·约翰逊（Rod Johnson）担任董事会成员的公司中，是否有任何一家实施了新的远程办公政策？

- Are there any negative news about companies that Neo4j invested in?  
  - 关于 Neo4j 所投资的公司，是否存在负面新闻？

- Were there any notable news in connection with supply chain problems for companies that supply Hyundai?  
  - 为现代汽车（Hyundai）供货的公司中，是否出现过与供应链问题相关的重大新闻？

With all these example questions, you can greatly narrow down the relevant document subset using a structured graph-based metadata filter.

借助所有这些示例问题，您可利用结构化的基于图的元数据过滤器，大幅缩小相关文档子集的范围。

In this blog post, I will show you how to implement graph-based metadata filtering using LangChain in combination with OpenAI function-calling agent. The code is available on [GitHub](https://github.com/tomasonjo/blogs/blob/master/llm/graph_based_prefiltering.ipynb?ref=blog.langchain.com).

在本篇博客中，我将向您演示如何结合 LangChain 与 OpenAI 的函数调用（function-calling）智能体，实现基于图的元数据过滤。相关代码已发布在 [GitHub](https://github.com/tomasonjo/blogs/blob/master/llm/graph_based_prefiltering.ipynb?ref=blog.langchain.com) 上。

### Agenda

### 议程

We will use the so-called _companies_ graph dataset, available on a public demo server hosted by Neo4j. You can access it by using the following credentials.

我们将使用 Neo4j 托管的公共演示服务器上提供的所谓 _companies_（公司）图数据集。您可通过以下凭据访问该数据集。

```python
Neo4j Browser URI: https://demo.neo4jlabs.com:7473/browser/
username: companies
password: companies
database: companies
```

```python
Neo4j 浏览器 URI：https://demo.neo4jlabs.com:7473/browser/
用户名：companies
密码：companies
数据库：companies
```

The complete schema of the dataset is the following:

该数据集的完整图模式如下所示：

![](images/graph-based-metadata-filtering-for-improving-vector-search-in-rag-applications/img_003.png)Graph schema. Image by author.

![](images/graph-based-metadata-filtering-for-improving-vector-search-in-rag-applications/img_003.png)图模式。图片由作者提供。

The graph schema revolves around **Organization** nodes. There is vast information available regarding their suppliers, competitors, location, board members, and more. As mentioned before, there also articles mentioning particular organizations with their corresponding text chunks.

该图模式以 **Organization**（组织）节点为核心，涵盖大量相关信息，包括其供应商、竞争对手、地理位置、董事会成员等。如前所述，图中还包含提及特定组织的相关文章及其对应的文本片段。

We will implement an OpenAI agent with a single tool, which can dynamically generate Cypher statements based on user input and retrieve relevant text chunks from the graph database. In this example, the tool will have four optional input parameters:

我们将实现一个配备单一工具的 OpenAI 智能体，该工具可根据用户输入动态生成 Cypher 查询语句，并从图数据库中检索相关的文本片段。在本示例中，该工具支持以下四个可选输入参数：

- topic: Any specific information or topic besides organization, country, and sentiment that the user is interested in.  
- topic（主题）：除组织、国家和情感之外，用户感兴趣的任何特定信息或主题。

- organization: Organization that the user wants to find information about  
- organization（组织）：用户希望查询信息的具体组织。

- country: Country of organizations that the user is interested in. Use full names like United States of America and France.  
- country（国家）：用户感兴趣的组织所属的国家。请使用全称，例如 United States of America（美利坚合众国）、France（法国）。

- sentiment: Sentiment of articles  
- sentiment（情感倾向）：文章的情感倾向（如正面、负面、中性）。

Based on the four input parameters, we will dynamically, but deterministically, construct a corresponding Cypher statement to retrieve relevant information from the graph and use it as context to generate the final answer using an LLM.

根据四个输入参数，我们将动态地（但确定性地）构建一条对应的 Cypher 语句，以从图数据库中检索相关信息，并将这些信息作为上下文，交由大语言模型（LLM）生成最终答案。

You will require an [OpenAI API key](https://openai.com/blog/openai-api?ref=blog.langchain.com) to follow along with the code.

您需要一个 [OpenAI API 密钥](https://openai.com/blog/openai-api?ref=blog.langchain.com)，才能运行本文中的代码。

### Function Implementation

### 函数实现

We will begin by defining credentials and relevant connections to Neo4j.

我们首先定义连接 Neo4j 所需的凭据及相关配置。

```python
import os

os.environ["OPENAI_API_KEY"] = "sk-"
os.environ["NEO4J_URI"] = "neo4j+s://demo.neo4jlabs.com"
os.environ["NEO4J_USERNAME"] = "companies"
os.environ["NEO4J_PASSWORD"] = "companies"
os.environ["NEO4J_DATABASE"] = "companies"

embeddings = OpenAIEmbeddings()
graph = Neo4jGraph()
vector_index = Neo4jVector.from_existing_index(
    embeddings,
    index_name="news"
)
```

As mentioned, we will be using the OpenAI embeddings, for which you require their API key. Next, we define the graph connection to Neo4j, allowing us to execute arbitrary Cypher statements. Lastly, we instantiate a Neo4jVector connection, which can retrieve information by querying the existing vector index. At the time of writing this article, you cannot use the vector index in combination with the pre-filtering approach; you can only apply post-filtering in combination with the vector index. However, debating post-filtering is beyond the scope of this article as we will focus on pre-filtering approaches combined with an exhaustive vector similarity search.

如前所述，我们将使用 OpenAI 提供的嵌入模型（embeddings），因此您需要其 API 密钥。接下来，我们建立与 Neo4j 图数据库的连接，以便执行任意 Cypher 查询语句。最后，我们实例化一个 `Neo4jVector` 连接对象，它可通过查询已有的向量索引（vector index）来检索信息。在撰写本文时，向量索引尚不支持与预过滤（pre-filtering）方式联用；目前仅支持与后过滤（post-filtering）结合使用。不过，关于后过滤的讨论已超出本文范围——本文将聚焦于预过滤策略，并辅以穷举式的向量相似性搜索（exhaustive vector similarity search）。

More or less, the whole blog post boils down to the following `get_organization_news` function, which dynamically generates a Cypher statement and retrieves relevant information. For clarity, I will split the code into multiple parts.

整体而言，本篇博客的核心即以下 `get_organization_news` 函数：它动态生成 Cypher 查询语句并检索相关信息。为便于理解，我将该函数代码拆分为多个部分进行说明。

```python
def get_organization_news(
    topic: Optional[str] = None,
    organization: Optional[str] = None,
    country: Optional[str] = None,
    sentiment: Optional[str] = None,
) -> str:
    # If there is no prefiltering, we can use vector index
    if topic and not organization and not country and not sentiment:
        return vector_index.similarity_search(topic)
    # Uses parallel runtime where available
    base_query = (
        "CYPHER runtime = parallel parallelRuntimeSupport=all "
        "MATCH (c:Chunk)<-[:HAS_CHUNK]-(a:Article) WHERE "
    )
    where_queries = []
    params = {"k": 5} # Define the number of text chunks to retrieve
```

We begin by defining the input parameters. As you can observe, all of them are optional strings. The `topic` parameter is used to find specific information within documents. In practice, we embed the value of the `topic` parameter and use it as input for vector similarity search. The other three parameters will be used to demonstrate the pre-filtering approach.

我们首先定义输入参数。如您所见，所有参数均为可选字符串。`topic` 参数用于在文档中查找特定信息。在实际应用中，我们会对 `topic` 参数的值进行嵌入（embedding），并将其作为向量相似性搜索的输入。其余三个参数则用于演示预过滤（pre-filtering）方法。

If all of the pre-filtering parameters are empty, we can find the relevant documents using the existing vector index. Otherwise, we start preparing the base Cypher statement that will be used for the pre-filtered metadata approach. The clause `CYPHER runtime = parallel parallelRuntimeSupport=all` instructs the Neo4j database to use [parallel runtime](https://neo4j.com/developer-blog/speed-up-queries-neo4j-parallel-runtime/?ref=blog.langchain.com) where available. Next, we prepare a match statement that selects `Chunk` nodes and their corresponding `Article` nodes.

若所有预过滤参数均为空，则可直接利用现有向量索引查找相关文档；否则，我们将开始构建用于元数据预过滤方法的基础 Cypher 语句。子句 `CYPHER runtime = parallel parallelRuntimeSupport=all` 指示 Neo4j 数据库在支持时启用[并行运行时（parallel runtime）](https://neo4j.com/developer-blog/speed-up-queries-neo4j-parallel-runtime/?ref=blog.langchain.com)。接下来，我们构建一条 MATCH 语句，用于匹配 `Chunk` 节点及其对应的 `Article` 节点。

Now we are ready to dynamically append metadata filters to the Cypher statement. We will begin with `Organization`filter.

现在，我们已准备好动态地将元数据过滤条件追加至 Cypher 语句中。我们首先处理 `Organization`（组织）过滤器。

```python
if organization:
    # Map to database
    candidates = get_candidates(organization)
    if len(candidates) > 1:  # Ask for follow up if too many options
        return (
         "Ask a follow up question which of the available organizations "
         f"did the user mean. Available options: {candidates}"
        )
    where_queries.append(
        "EXISTS {(a)-[:MENTIONS]->(:Organization {name: $organization})}"
    )
    params["organization"] = candidates[0]
```

```python
if organization:
    # 映射到数据库
    candidates = get_candidates(organization)
    if len(candidates) > 1:  # 若候选结果过多，则需追问用户确认
        return (
         "请向用户追问：以下可选组织中，您具体指的是哪一个？可选项：{candidates}"
        ).format(candidates=candidates)
    where_queries.append(
        "EXISTS {(a)-[:MENTIONS]->(:Organization {name: $organization})}"
    )
    params["organization"] = candidates[0]
```

If the LLM identifies any particular organization the user is interested in, we must first map the value to the database with the `get_candidates`function. Under the hood, the `get_candidates`function uses [keyword search utilizing a full-text index](https://neo4j.com/docs/cypher-manual/current/indexes/semantic-indexes/full-text-indexes/?ref=blog.langchain.com) to find candidate nodes. If multiple candidates are found, we instruct the LLM to ask a follow-up question to the user to clarify which organization they meant exactly. Otherwise we append an [existential subquery](https://neo4j.com/developer/cypher/subqueries/?ref=blog.langchain.com#existential-subqueries) that filters the articles which mention the particular organization to the list of filters. To prevent any Cypher injection, we use query parameters instead of concatenating the query.

若大语言模型（LLM）识别出用户感兴趣的特定组织，我们必须首先通过 `get_candidates` 函数将该组织名称映射至数据库。该函数底层使用基于[全文索引（full-text index）的关键词搜索](https://neo4j.com/docs/cypher-manual/current/indexes/semantic-indexes/full-text-indexes/?ref=blog.langchain.com)，以查找候选节点。若返回多个候选结果，我们将指示 LLM 向用户发起追问，以明确其确切所指的组织；否则，我们将添加一个[存在性子查询（existential subquery）](https://neo4j.com/developer/cypher/subqueries/?ref=blog.langchain.com#existential-subqueries)，用于筛选提及该特定组织的 `Article` 节点，并将其加入过滤条件列表。为防止任何 Cypher 注入攻击，我们采用查询参数（query parameters）而非字符串拼接方式构造查询。

Next, we handle situations when a user wants to pre-filter text chunks based on the country of the mentioned organizations.

接下来，我们处理用户希望依据被提及组织所属国家（country）对文本块进行预过滤的情形。

```python
if country:
    # No need to disambiguate
    where_queries.append(
        "EXISTS {(a)-[:MENTIONS]->(:Organization)-[:IN_CITY]->()-[:IN_COUNTRY]->(:Country {name: $country})}"
    )
    params["country"] = country
```

```python
if country:
    # 无需消歧义
    where_queries.append(
        "EXISTS {(a)-[:MENTIONS]->(:Organization)-[:IN_CITY]->()-[:IN_COUNTRY]->(:Country {name: $country})}"
    )
    params["country"] = country
```

Since countries follow standard naming, we don’t have to map values to the database, as LLMs are familiar with most country naming standards.

由于国家名称遵循标准化命名规范，我们无需将输入值映射至数据库——当前主流大语言模型已普遍熟悉绝大多数国家的标准命名方式。

Similarly, we also handle sentiment metadata filtering.

同理，我们还支持情感倾向（sentiment）元数据的过滤。

```python
if sentiment:
    if sentiment == "positive":
        where_queries.append("a.sentiment > $sentiment")
        params["sentiment"] = 0.5
    else:
        where_queries.append("a.sentiment < $sentiment")
        params["sentiment"] = -0.5
```

```python
if sentiment:
    if sentiment == "positive":
        where_queries.append("a.sentiment > $sentiment")
        params["sentiment"] = 0.5
    else:
        where_queries.append("a.sentiment < $sentiment")
        params["sentiment"] = -0.5
```

We will instruct the LLM to only use two values for a sentiment input value, either positive or negative. We then map these two values to appropriate filter values.

我们将指示大语言模型（LLM）在情感输入值中仅使用两个取值：positive（正面）或 negative（负面）。随后，我们将这两个取值映射为相应的过滤条件值。

We handle the `topic` parameter slightly differently as it’s not used for prefiltering but rather vector similarity search.

我们对 `topic` 参数的处理方式略有不同，因为它不用于预过滤（prefiltering），而是用于向量相似性搜索（vector similarity search）。

```python
if topic:  # Do vector comparison
    vector_snippet = (
        " WITH c, a, vector.similarity.cosine(c.embedding,$embedding) AS score "
        "ORDER BY score DESC LIMIT toInteger($k) "
    )
    params["embedding"] = embeddings.embed_query(topic)
else:  # Just return the latest data
    vector_snippet = " WITH c, a ORDER BY a.date DESC LIMIT toInteger($k) "
```

```python
if topic:  # 执行向量比对
    vector_snippet = (
        " WITH c, a, vector.similarity.cosine(c.embedding,$embedding) AS score "
        "ORDER BY score DESC LIMIT toInteger($k) "
    )
    params["embedding"] = embeddings.embed_query(topic)
else:  # 仅返回最新数据
    vector_snippet = " WITH c, a ORDER BY a.date DESC LIMIT toInteger($k) "
```

If the LLM identifies that the user is interested in a particular topic in the news, we use the topic input’s text embedding to find the most relevant documents. On the other hand, if no specific topic is identified, we simply return the latest couple of articles and avoid vector similarity search altogether.

如果大语言模型（LLM）识别出用户对新闻中的某个特定主题感兴趣，我们将使用该主题输入文本的嵌入向量（text embedding）来查找最相关的文档；反之，若未识别出任何具体主题，则直接返回最近发布的几篇文章，并完全跳过向量相似性搜索。

Now, we have to put the Cypher statement together and use it to retrieve information from the database.

接下来，我们需要将各部分 Cypher 片段组合成完整语句，并用它从数据库中检索信息。

```python
return_snippet = "RETURN '#title ' + a.title + '\n#date ' + toString(a.date) + '\n#text ' + c.text AS output"

complete_query = (
    base_query + " AND ".join(where_queries) + vector_snippet + return_snippet
)

# Retrieve information from the database
data = graph.query(complete_query, params)
print(f"Cypher: {complete_query}\n")
# Safely remove embedding before printing
params.pop('embedding', None)
print(f"Parameters: {params}")
return "###Article: ".join([el["output"] for el in data])
```

```python
return_snippet = "RETURN '#title ' + a.title + '\n#date ' + toString(a.date) + '\n#text ' + c.text AS output"

complete_query = (
    base_query + " AND ".join(where_queries) + vector_snippet + return_snippet
)

# 从数据库中检索信息
data = graph.query(complete_query, params)
print(f"Cypher: {complete_query}\n")
# 安全地移除 embedding 字段（打印前）
params.pop('embedding', None)
print(f"参数: {params}")
return "###Article: ".join([el["output"] for el in data])
```

We construct the final `complete_query` by combining all the query snippets. After that, we use the dynamically generated Cypher statement to retrieve information from the database and return it to the LLM. Let’s examine the generated Cypher statement for an example input.

我们通过拼接所有查询片段来构建最终的 `complete_query`。随后，利用动态生成的 Cypher 语句从数据库中检索信息，并将结果返回给大语言模型（LLM）。下面以一个示例输入为例，查看所生成的 Cypher 语句：

```python
get_organization_news(
  organization='neo4j',
  sentiment='positive',
  topic='remote work'
)
```

```python
get_organization_news(
  organization='neo4j',
  sentiment='positive',
  topic='remote work'
)
```

# Cypher: CYPHER runtime = parallel parallelRuntimeSupport=all  
# Cypher：CYPHER 运行时 = 并行 parallelRuntimeSupport=all  

# MATCH (c:Chunk)<-[:HAS_CHUNK]-(a:Article) WHERE  
# MATCH (c:Chunk)<-[:HAS_CHUNK]-(a:Article) WHERE  

# EXISTS {(a)-[:MENTIONS]->(:Organization {name: $organization})} AND  
# EXISTS {(a)-[:MENTIONS]->(:Organization {name: $organization})} AND  

# a.sentiment > $sentiment  
# a.sentiment > $sentiment  

# WITH c, a, vector.similarity.cosine(c.embedding,$embedding) AS score  
# WITH c, a, vector.similarity.cosine(c.embedding, $embedding) AS score  

# ORDER BY score DESC LIMIT toInteger($k)  
# ORDER BY score DESC LIMIT toInteger($k)  

# RETURN '#title ' + a.title + '\ndate ' + toString(a.date) + '\ntext ' + c.text AS output  
# RETURN '#title ' + a.title + '\ndate ' + toString(a.date) + '\ntext ' + c.text AS output  

# Parameters: {'k': 5, 'organization': 'Neo4j', 'sentiment': 0.5}  
# 参数：{'k': 5, 'organization': 'Neo4j', 'sentiment': 0.5}  

```

The dynamic query generations works as expected, and is able to retrieve relevant information from the database.  

动态查询生成按预期工作，能够从数据库中检索出相关信息。

### Defining OpenAI agent  
### 定义 OpenAI 智能体  

Next, we need to wrap the function as an Agent tool. First, we will add input parameter descriptions.  

接下来，我们需要将该函数封装为一个智能体（Agent）工具。首先，我们将添加输入参数的描述。

```python
fewshot_examples = """{Input:What are the health benefits for Google employees in the news? Query: Health benefits}
{Input: What is the latest positive news about Google? Query: None}
{Input: Are there any news about VertexAI regarding Google? Query: VertexAI}
{Input: Are there any news about new products regarding Google? Query: new products}
"""

fewshot_examples = """{输入：新闻中提到的谷歌员工健康福利有哪些？ 查询：健康福利}
{输入：关于谷歌的最新正面新闻是什么？ 查询：无}
{输入：是否有任何关于 VertexAI 与谷歌相关的新闻？ 查询：VertexAI}
{输入：是否有任何关于谷歌新产品的新闻？ 查询：新产品}
"""

class NewsInput(BaseModel):
    topic: Optional[str] = Field(
        description="Any specific information or topic besides organization, country, and sentiment that the user is interested in. Here are some examples: "
        + fewshot_examples
    )
    organization: Optional[str] = Field(
        description="Organization that the user wants to find information about"
    )
    country: Optional[str] = Field(
        description="Country of organizations that the user is interested in. Use full names like United States of America and France."
    )
    sentiment: Optional[str] = Field(
        description="Sentiment of articles", enum=["positive", "negative"]
    )

class NewsInput(BaseModel):
    topic: Optional[str] = Field(
        description="除组织、国家和情感倾向外，用户感兴趣的特定信息或主题。以下是一些示例："
        + fewshot_examples
    )
    organization: Optional[str] = Field(
        description="用户希望查询信息的组织名称"
    )
    country: Optional[str] = Field(
        description="用户感兴趣的组织所属国家。请使用全称，例如“美国”（United States of America）和“法国”（France）"
    )
    sentiment: Optional[str] = Field(
        description="文章的情感倾向", enum=["positive", "negative"]
    )
```

The pre-filtering parameters were quite simple to describe, but I had some problems with getting the `topic` parameter to work as expected. In the end, I decided to add some examples so that the LLM would understand it better. Additionally, you can observe that we give the LLM information about the `country` naming format as well as provide enumeration for `sentiment`.  

预过滤参数的描述相对简单，但在使 `topic` 参数按预期工作时我遇到了一些困难。最终，我决定加入若干示例，以帮助大语言模型（LLM）更准确地理解其用途。此外，你还可以注意到：我们向 LLM 明确说明了 `country` 的命名格式，并为 `sentiment` 提供了枚举值（即限定取值范围）。

Now, we can define a custom tool by giving it a name and description containing instructions for an LLM on when to use it.  

现在，我们可以通过为其指定名称和描述来定义一个自定义工具；该描述中需包含指导大语言模型（LLM）在何种场景下调用该工具的说明。

```python
class NewsTool(BaseTool):
    name = "NewsInformation"
    description = (
        "useful for when you need to find relevant information in the news"
    )
    args_schema: Type[BaseModel] = NewsInput

class NewsTool(BaseTool):
    name = "NewsInformation"
    description = (
        "当需要在新闻中查找相关信息时非常有用"
    )
    args_schema: Type[BaseModel] = NewsInput
```

```python
    def _run(
        self,
        topic: Optional[str] = None,
        organization: Optional[str] = None,
        country: Optional[str] = None,
        sentiment: Optional[str] = None,
        run_manager: Optional[CallbackManagerForToolRun] = None,
    ) -> str:
        """Use the tool."""
        return get_organization_news(topic, organization, country, sentiment)
```

```python
    def _run(
        self,
        topic: Optional[str] = None,
        organization: Optional[str] = None,
        country: Optional[str] = None,
        sentiment: Optional[str] = None,
        run_manager: Optional[CallbackManagerForToolRun] = None,
    ) -> str:
        """调用该工具。"""
        return get_organization_news(topic, organization, country, sentiment)
```

One last thing is to define the Agent executor. I just reuse the [LCEL implementation](https://python.langchain.com/docs/expression_language/?ref=blog.langchain.com) of an OpenAI agent I implemented some time ago.

最后一步是定义 Agent 执行器（Agent executor）。我直接复用了此前实现的一个 OpenAI Agent 的 [LCEL 实现](https://python.langchain.com/docs/expression_language/?ref=blog.langchain.com)。

```python
llm = ChatOpenAI(temperature=0, model="gpt-4-turbo", streaming=True)
tools = [NewsTool()]

llm_with_tools = llm.bind(functions=[format_tool_to_openai_function(t) for t in tools])

prompt = ChatPromptTemplate.from_messages(
    [\
        (\
            "system",\
            "You are a helpful assistant that finds information about movies "\
            " and recommends them. If tools require follow up questions, "\
            "make sure to ask the user for clarification. Make sure to include any "\
            "available options that need to be clarified in the follow up questions "\
            "Do only the things the user specifically requested. ",\
        ),\
        MessagesPlaceholder(variable_name="chat_history"),\
        ("user", "{input}"),\
        MessagesPlaceholder(variable_name="agent_scratchpad"),\
    ]
)

agent = (
    {
        "input": lambda x: x["input"],
        "chat_history": lambda x: _format_chat_history(x["chat_history"])
        if x.get("chat_history")
        else [],
        "agent_scratchpad": lambda x: format_to_openai_function_messages(
            x["intermediate_steps"]
        ),
    }
    | prompt
    | llm_with_tools
    | OpenAIFunctionsAgentOutputParser()
)

agent_executor = AgentExecutor(agent=agent, tools=tools)
```

```python
llm = ChatOpenAI(temperature=0, model="gpt-4-turbo", streaming=True)
tools = [NewsTool()]

llm_with_tools = llm.bind(functions=[format_tool_to_openai_function(t) for t in tools])

prompt = ChatPromptTemplate.from_messages(
    [\
        (\
            "system",\
            "你是一位乐于助人的助手，负责查找电影相关信息并为其提供推荐。若工具调用需进一步提问，请务必向用户寻求澄清；在后续问题中，须明确列出所有待确认的可选参数。仅执行用户明确要求的操作。",\
        ),\
        MessagesPlaceholder(variable_name="chat_history"),\
        ("user", "{input}"),\
        MessagesPlaceholder(variable_name="agent_scratchpad"),\
    ]
)

agent = (
    {
        "input": lambda x: x["input"],
        "chat_history": lambda x: _format_chat_history(x["chat_history"])
        if x.get("chat_history")
        else [],
        "agent_scratchpad": lambda x: format_to_openai_function_messages(
            x["intermediate_steps"]
        ),
    }
    | prompt
    | llm_with_tools
    | OpenAIFunctionsAgentOutputParser()
)

agent_executor = AgentExecutor(agent=agent, tools=tools)
```

The agent has a single tool it can use to retrieve information about the news. We also added the `chat_history` message placeholder, making the agent conversational and allowing follow-up questions and replies.

该 Agent 仅配备一个工具，用于检索新闻相关信息。我们还添加了 `chat_history` 消息占位符，使 Agent 具备对话能力，从而支持后续追问与响应。

### Implementation testing

### 实现测试

Let’s run a couple of inputs and examine the generated Cypher statements and parameters.

让我们输入几个示例请求，并检查所生成的 Cypher 语句及其参数。

```python
agent_executor.invoke(
  {"input": "What are some positive news regarding neo4j?"}
)

# Cypher: CYPHER runtime = parallel parallelRuntimeSupport=all
# MATCH (c:Chunk)<-[:HAS_CHUNK]-(a:Article) WHERE
# EXISTS {(a)-[:MENTIONS]->(:Organization {name: $organization})} AND
# a.sentiment > $sentiment WITH c, a
# ORDER BY a.date DESC LIMIT toInteger($k)
# RETURN '#title ' + a.title + 'date ' + toString(a.date) + 'text ' + c.text AS output
# Parameters: {'k': 5, 'organization': 'Neo4j', 'sentiment': 0.5}
```

生成的 Cypher 语句语法正确。由于我们未指定特定主题，该查询将返回提及 Neo4j 的正面文章中最近的五段文本片段（chunks）。接下来，我们尝试一个更复杂的查询：

```python
agent_executor.invoke(
   {"input": "What are some of the latest negative news about employee happiness for companies from France?"}
)

# Cypher: CYPHER runtime = parallel parallelRuntimeSupport=all
# MATCH (c:Chunk)<-[:HAS_CHUNK]-(a:Article) WHERE
# EXISTS {(a)-[:MENTIONS]->(:Organization)-[:IN_CITY]->()-[:IN_COUNTRY]->(:Country {name: $country})} AND
# a.sentiment < $sentiment
# WITH c, a, vector.similarity.cosine(c.embedding,$embedding) AS score
# ORDER BY score DESC LIMIT toInteger($k)
# RETURN '#title ' + a.title + 'date ' + toString(a.date) + 'text ' + c.text AS output
# Parameters: {'k': 5, 'country': 'France', 'sentiment': -0.5, 'topic': 'employee happiness'}
```

语言模型代理（LLM agent）正确生成了预过滤参数，并且还识别出具体的 _employee happiness_（员工幸福感）主题。该主题被用作向量相似性搜索的输入，从而进一步精细化检索过程。

### Summary

### 总结

在本文中，我们实现了基于图结构的元数据过滤器示例，显著提升了向量搜索的准确性。然而，该数据集本身具有高度丰富且相互关联的属性，支持构建远为复杂和精细的预过滤查询。借助图数据表示形式，再结合 LLM 的函数调用（function-calling）能力动态生成 Cypher 查询语句，结构化过滤的潜力几乎是无限的。

此外，您的代理不仅可以配备用于检索非结构化文本的工具（如本文所示），还可集成其他工具以[检索结构化信息](https://towardsdatascience.com/enhancing-interaction-between-language-models-and-graph-databases-via-a-semantic-layer-0a78ad3eba49?ref=blog.langchain.com)，这使得知识图谱成为众多 RAG（检索增强生成）应用的理想解决方案。

相关代码已发布在 [GitHub](https://github.com/tomasonjo/blogs/blob/master/llm/graph_based_prefiltering.ipynb?ref=blog.langchain.com) 上。

### Tags

### 标签

[Partner Post](https://blog.langchain.com/tag/partner-post/)

[合作伙伴文章](https://blog.langchain.com/tag/partner-post/)

[![Enhancing RAG-based application accuracy by constructing and leveraging knowledge graphs](images/graph-based-metadata-filtering-for-improving-vector-search-in-rag-applications/img_004.webp)](https://blog.langchain.com/enhancing-rag-based-applications-accuracy-by-constructing-and-leveraging-knowledge-graphs/)

[![通过构建和利用知识图谱提升基于 RAG 的应用程序准确性](images/graph-based-metadata-filtering-for-improving-vector-search-in-rag-applications/img_004.webp)](https://blog.langchain.com/enhancing-rag-based-applications-accuracy-by-constructing-and-leveraging-knowledge-graphs/)

[**Enhancing RAG-based application accuracy by constructing and leveraging knowledge graphs**](https://blog.langchain.com/enhancing-rag-based-applications-accuracy-by-constructing-and-leveraging-knowledge-graphs/)

[**通过构建和利用知识图谱提升基于 RAG 的应用程序准确性**](https://blog.langchain.com/enhancing-rag-based-applications-accuracy-by-constructing-and-leveraging-knowledge-graphs/)

[Partner Post](https://blog.langchain.com/tag/partner-post/) 7 min read

[合作伙伴文章](https://blog.langchain.com/tag/partner-post/) 7 分钟阅读