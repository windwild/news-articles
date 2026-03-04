---
title: "Enhancing RAG-based application accuracy by constructing and leveraging knowledge graphs"
source: "LangChain Blog"
url: "https://blog.langchain.com/enhancing-rag-based-applications-accuracy-by-constructing-and-leveraging-knowledge-graphs/"
date: "2024-03-15"
scraped_at: "2026-03-03T08:06:23.166279316+00:00"
language: "en-zh"
translated: true
tags: ["Partner Post"]
---
{% raw %}

### A practical guide to constructing and retrieving information from knowledge graphs in RAG applications with Neo4j and LangChain

### 使用 Neo4j 和 LangChain 在 RAG 应用中构建知识图谱并从中检索信息的实用指南

_Editor's Note: the following is a guest blog post from Tomaz Bratanic, who focuses on Graph ML and GenAI research at_ [_Neo4j_](https://neo4j.com/?utm_source=Google&utm_medium=PaidSearch&utm_campaign=Evergreenutm_content%3DAMS-Search-SEMBrand-Evergreen-None-SEM-SEM-NonABM&utm_term=neo4j&utm_adgroup=core-brand&gad_source=1&gclid=CjwKCAjw48-vBhBbEiwAzqrZVOnH2D4WOkRLH78FtQAFitObkbJNs34kTFw4bbBX0VzwqSalQUV2UhoCrFcQAvD_BwE) _._ _Neo4j is a graph database and analytics company which helps organizations find hidden relationships and patterns across billions of data connections deeply, easily, and quickly._

_编辑注：以下为 Neo4j 公司 Graph ML 与生成式 AI（GenAI）研究员 Tomaz Bratanic 撰写的客座博客文章。_ [_Neo4j_](https://neo4j.com/?utm_source=Google&utm_medium=PaidSearch&utm_campaign=Evergreenutm_content%3DAMS-Search-SEMBrand-Evergreen-None-SEM-SEM-NonABM&utm_term=neo4j&utm_adgroup=core-brand&gad_source=1&gclid=CjwKCAjw48-vBhBbEiwAzqrZVOnH2D4WOkRLH78FtQAFitObkbJNs34kTFw4bbBX0VzwqSalQUV2UhoCrFcQAvD_BwE) _是一家图数据库与分析公司，致力于帮助组织深入、高效、快速地从数十亿数据连接中发现隐藏的关系与模式。_

Graph retrieval augmented generation ( [Graph RAG](https://www.microsoft.com/en-us/research/blog/graphrag-unlocking-llm-discovery-on-narrative-private-data/?ref=blog.langchain.com)) is gaining momentum and emerging as a powerful addition to traditional vector search retrieval methods. This approach leverages the structured nature of graph databases, which organize data as nodes and relationships, to enhance the depth and contextuality of retrieved information.

图检索增强生成（[Graph RAG](https://www.microsoft.com/zh-cn/research/blog/graphrag-unlocking-llm-discovery-on-narrative-private-data/?ref=blog.langchain.com)）正日益受到关注，成为传统向量搜索检索方法的一项强大补充。该方法充分利用图数据库的结构化特性——即以节点（nodes）和关系（relationships）组织数据——从而提升所检索信息的深度与上下文相关性。

![](images/enhancing-rag-based-application-accuracy-by-constructing-and-leveraging-knowledg/img_001.jpg)Example knowledge graph.

![](images/enhancing-rag-based-application-accuracy-by-constructing-and-leveraging-knowledg/img_001.jpg)示例知识图谱。

Graphs are great at representing and storing heterogeneous and interconnected information in a structured manner, effortlessly capturing complex relationships and attributes across diverse data types. In contrast, vector databases often struggle with such structured information, as their strength lies in handling unstructured data through high-dimensional vectors. In your RAG application, you can combine structured graph data with vector search through unstructured text to achieve the best of both worlds, which is exactly what we will do in this blog post.

图在以结构化方式表示和存储异构、互连的信息方面极具优势，能够轻松捕捉跨多种数据类型的复杂关系与属性。相比之下，向量数据库通常难以有效处理此类结构化信息，因其核心优势在于通过高维向量处理非结构化数据。在您的 RAG 应用中，可将结构化的图数据与针对非结构化文本的向量搜索相结合，从而兼收二者之长——这正是本文将要实现的目标。

**Knowledge graphs are great, but how do you create one?** Constructing a knowledge graph is typically the most challenging step in leveraging the power of graph-based data representation. It involves gathering and structuring the data, which requires a deep understanding of both the domain and graph modeling. To simplify this process, we have been experimenting with LLMs. LLMs, with their profound understanding of language and context, can automate significant parts of the knowledge graph creation process. By analyzing text data, these models can identify entities, understand the relationships between them, and suggest how they might be best represented in a graph structure. As a result of these experiments, we have added the first version of the graph construction module to LangChain, which we will demonstrate in this blog post.

**知识图谱虽好，但如何构建一个？** 构建知识图谱通常是发挥基于图的数据表示能力过程中最具挑战性的环节。它涉及数据的采集与结构化，要求对特定领域知识及图建模方法均有深入理解。为简化这一过程，我们一直在探索大语言模型（LLM）的应用。凭借其对语言与上下文的深刻理解，LLMs 能够自动化完成知识图谱构建中的大量关键任务：通过分析文本数据，识别其中的实体、理解实体间的语义关系，并建议其在图结构中最优的表达方式。基于这些实验成果，我们已在 LangChain 中集成了首个版本的知识图谱构建模块，并将在本篇博文中进行演示。

The code is available on [GitHub](https://github.com/tomasonjo/blogs/blob/master/llm/enhancing_rag_with_graph.ipynb?ref=blog.langchain.com).

代码已发布于 [GitHub](https://github.com/tomasonjo/blogs/blob/master/llm/enhancing_rag_with_graph.ipynb?ref=blog.langchain.com)。

### Neo4j Environment Setup

### Neo4j 环境配置

You need to set up a Neo4j instance follow along with the examples in this blog post. The easiest way is to start a free instance on [Neo4j Aura](https://neo4j.com/cloud/platform/aura-graph-database/?ref=blog.langchain.com), which offers cloud instances of Neo4j database. Alternatively, you can also set up a local instance of the Neo4j database by downloading the [Neo4j Desktop](https://neo4j.com/download/?ref=blog.langchain.com) application and creating a local database instance.

您需要部署一个 Neo4j 实例，以便运行本文中的示例代码。最便捷的方式是通过 [Neo4j Aura](https://neo4j.com/cloud/platform/aura-graph-database/?ref=blog.langchain.com) 创建一个免费的云端 Neo4j 数据库实例。此外，您也可下载 [Neo4j Desktop](https://neo4j.com/download/?ref=blog.langchain.com) 应用程序，在本地搭建 Neo4j 数据库实例。

```python
os.environ["OPENAI_API_KEY"] = "sk-"
os.environ["NEO4J_URI"] = "bolt://localhost:7687"
os.environ["NEO4J_USERNAME"] = "neo4j"
os.environ["NEO4J_PASSWORD"] = "password"
```

graph = Neo4jGraph()
```

此外，您还需提供一个 [OpenAI API 密钥](https://openai.com/?ref=blog.langchain.com)，因为本文将使用 OpenAI 的模型。

## 数据摄取（Data ingestion）

在本次演示中，我们将使用 [伊丽莎白一世](https://en.wikipedia.org/wiki/Elizabeth_I?ref=blog.langchain.com) 的 Wikipedia 页面。我们可以借助 [LangChain 文档加载器（loaders）](https://python.langchain.com/docs/modules/data_connection/document_loaders/?ref=blog.langchain.com)，无缝地从 Wikipedia 抓取并切分文档。

```python
# 读取 Wikipedia 文章
raw_documents = WikipediaLoader(query="Elizabeth I").load()

# 定义文本分块策略
text_splitter = TokenTextSplitter(chunk_size=512, chunk_overlap=24)
documents = text_splitter.split_documents(raw_documents[:3])
```

接下来，我们将基于已获取的文档构建图结构。为此，我们实现了一个 `LLMGraphTransformer` 模块，该模块可显著简化知识图谱在图数据库中的构建与存储过程。

```python
llm = ChatOpenAI(temperature=0, model_name="gpt-4-0125-preview")
llm_transformer = LLMGraphTransformer(llm=llm)

# 提取图数据
graph_documents = llm_transformer.convert_to_graph_documents(documents)

# 存入 Neo4j
graph.add_graph_documents(
  graph_documents,
  baseEntityLabel=True,
  include_source=True
)
```

You can define which LLM you want the knowledge graph generation chain to use.  
您可以指定知识图谱生成链所使用的大型语言模型（LLM）。

At the moment, we support only function calling models from OpenAI and Mistral. However, we plan to expand the LLM selection in the future.  
目前，我们仅支持来自 OpenAI 和 Mistral 的具备函数调用能力的模型。但未来我们计划扩展所支持的 LLM 类型。

In this example, we are using the latest GPT-4. Note that the quality of generated graph significantly depends on the model you are using. In theory, you always want to use the most capable one.  
本示例中，我们使用最新版的 GPT-4。请注意，生成图谱的质量在很大程度上取决于您所选用的模型。理论上，您应始终选择能力最强的模型。

The LLM graph transformers returns graph documents, which can be imported to Neo4j via the `add_graph_documents` method.  
LLM 图谱转换器（LLM graph transformers）返回图文档（graph documents），可通过 `add_graph_documents` 方法将其导入 Neo4j。

The `baseEntityLabel` parameter assigns an additional `__Entity__` label to each node, enhancing indexing and query performance.  
`baseEntityLabel` 参数会为每个节点额外添加一个 `__Entity__` 标签，从而提升索引效率与查询性能。

The `include_source` parameter links nodes to their originating documents, facilitating data traceability and context understanding.  
`include_source` 参数将节点与其原始文档关联起来，有助于实现数据可追溯性及上下文理解。

You can inspect the generated graph in Neo4j Browser.  
您可在 Neo4j Browser 中查看生成的知识图谱。

![](images/enhancing-rag-based-application-accuracy-by-constructing-and-leveraging-knowledg/img_002.png)  
![](images/enhancing-rag-based-application-accuracy-by-constructing-and-leveraging-knowledg/img_002.png)

Part of the generated graph.  
生成图谱的一部分。

Note that this image represents only a part of the generated graph for clarity.  
请注意，为便于理解，该图仅展示生成图谱的一部分。

## Hybrid Retrieval for RAG  

## 面向 RAG 的混合检索

After the graph generation, we will use a hybrid retrieval approach that combines vector and keyword indexes with graph retrieval for RAG applications.  
图谱生成完成后，我们将采用一种混合检索策略，将向量索引、关键词索引与图谱检索相结合，服务于 RAG 应用。

![](images/enhancing-rag-based-application-accuracy-by-constructing-and-leveraging-knowledg/img_003.png)  
![](images/enhancing-rag-based-application-accuracy-by-constructing-and-leveraging-knowledg/img_003.png)

Combining hybrid (vector + keyword) and graph retrieval methods. Image by author.  
融合混合检索（向量 + 关键词）与图谱检索方法。图片由作者提供。

The diagram illustrates a retrieval process beginning with a user posing a question, which is then directed to an RAG retriever. This retriever employs keyword and vector searches to search through unstructured text data and combines it with the information it collects from the knowledge graph. Since Neo4j features both keyword and vector indexes, you can implement all three retrieval options with a single database system. The collected data from these sources is fed into an LLM to generate and deliver the final answer.  
该示意图展示了检索流程：用户首先提出问题，问题被送入 RAG 检索器；该检索器一方面通过关键词和向量搜索在非结构化文本数据中检索，另一方面从知识图谱中获取相关信息，并将二者结果融合。由于 Neo4j 原生支持关键词索引与向量索引，因此您可借助单一数据库系统实现全部三种检索方式。最终，这些来源汇总的数据被输入至大语言模型（LLM），以生成并输出最终答案。

### Unstructured data retriever  

### 非结构化数据检索器

You can use the `Neo4jVector.from_existing_graph` method to add both keyword and vector retrieval to documents. This method configures keyword and vector search indexes for a hybrid search approach, targeting nodes labeled `Document`. Additionally, it calculates text embedding values if they are missing.  
您可使用 `Neo4jVector.from_existing_graph` 方法，为文档同时启用关键词检索与向量检索。该方法会针对标签为 `Document` 的节点，配置关键词与向量搜索索引，以支持混合检索；此外，若文本嵌入值缺失，该方法还会自动计算补全。

```python
vector_index = Neo4jVector.from_existing_graph(
    OpenAIEmbeddings(),
    search_type="hybrid",
    node_label="Document",
    text_node_properties=["text"],
    embedding_node_property="embedding"
)
```

```python
vector_index = Neo4jVector.from_existing_graph(
    OpenAIEmbeddings(),
    search_type="hybrid",
    node_label="Document",
    text_node_properties=["text"],
    embedding_node_property="embedding"
)
```

随后，可通过 `similarity_search` 方法调用该向量索引。

随后，可通过 `similarity_search` 方法调用该向量索引。

### Graph retriever

### 图检索器

On the other hand, configuring a graph retrieval is more involved but offers more freedom. In this example, we will use a full-text index to identify relevant nodes and then return their direct neighborhood.

另一方面，配置图检索器过程更复杂，但灵活性更高。在本示例中，我们将使用全文索引识别相关节点，然后返回这些节点的直接邻域。

![](images/enhancing-rag-based-application-accuracy-by-constructing-and-leveraging-knowledg/img_004.png)Graph retriever. Image by author.

![](images/enhancing-rag-based-application-accuracy-by-constructing-and-leveraging-knowledg/img_004.png)图检索器。作者供图。

The graph retriever starts by identifying relevant entities in the input. For simplicity, we instruct the LLM to identify people, organizations, and locations. To achieve this, we will use LCEL with the newly added `with_structured_output` method to achieve this.

图检索器首先从输入中识别相关实体。为简化起见，我们指示大语言模型（LLM）识别人物、组织和地点三类实体。为此，我们将使用 LCEL（LangChain Expression Language），并借助新引入的 `with_structured_output` 方法实现该目标。

```python
# Extract entities from text
class Entities(BaseModel):
    """Identifying information about entities."""

    names: List[str] = Field(
        ...,
        description="All the person, organization, or business entities
        that " "appear in the text",
    )

prompt = ChatPromptTemplate.from_messages(
    [\
        (\
            "system",\
            "You are extracting organization and person entities from the\
            text.",\
        ),\
        (\
            "human",\
            "Use the given format to extract information from the\
             following"\
            "input: {question}",\
        ),\
    ]
)

entity_chain = prompt | llm.with_structured_output(Entities)
```

```python
# 从文本中提取实体
class Entities(BaseModel):
    """关于实体的识别信息。"""

    names: List[str] = Field(
        ...,
        description="文本中出现的所有人物、组织或企业实体",
    )

prompt = ChatPromptTemplate.from_messages(
    [\
        (\
            "system",\
            "你正在从文本中提取组织和人物实体。",\
        ),\
        (\
            "human",\
            "请按指定格式，从以下输入中提取信息：{question}",\
        ),\
    ]
)

entity_chain = prompt | llm.with_structured_output(Entities)
```

让我们来测试一下：

```python
entity_chain.invoke({"question": "Where was Amelia Earhart born?"}).names
# ['Amelia Earhart']
```

很好！现在我们已经能够从问题中识别出实体，接下来让我们使用全文索引（full-text index）将这些实体映射到知识图谱中。首先，我们需要创建一个全文索引，并定义一个用于生成容错型全文查询的函数（该函数允许一定程度的拼写错误），此处我们暂不深入细节。

```python
graph.query(
    "CREATE FULLTEXT INDEX entity IF NOT EXISTS FOR (e:__Entity__) ON EACH [e.id]")

def generate_full_text_query(input: str) -> str:
    """
    为给定输入字符串生成全文搜索查询。

    该函数构建一个适用于全文搜索的查询字符串。
    它将输入字符串按空格拆分为单词，并为每个单词附加一个相似度阈值（~2 表示最多允许 2 个字符差异），
    然后用 AND 操作符连接所有单词。该方法适用于将用户问题中的实体映射到数据库中的值，且能容忍少量拼写错误。
    """
    full_text_query = ""
    words = [el for el in remove_lucene_chars(input).split() if el]
    for word in words[:-1]:
        full_text_query += f" {word}~2 AND"
    full_text_query += f" {words[-1]}~2"
    return full_text_query.strip()
```

现在，让我们把所有部分整合起来。

```python
# 全文索引查询函数
def structured_retriever(question: str) -> str:
    """
    收集问题中提及的各实体在知识图谱中的邻域信息
    """
    result = ""
    entities = entity_chain.invoke({"question": question})
    for entity in entities.names:
        response = graph.query(
            """CALL db.index.fulltext.queryNodes('entity', $query,
            {limit:2})
            YIELD node,score
            CALL {
              MATCH (node)-[r:!MENTIONS]->(neighbor)
              RETURN node.id + ' - ' + type(r) + ' -> ' + neighbor.id AS
              output
              UNION
              MATCH (node)<-[r:!MENTIONS]-(neighbor)
              RETURN neighbor.id + ' - ' + type(r) + ' -> ' +  node.id AS
              output
            }
            RETURN output LIMIT 50
            """,
            {"query": generate_full_text_query(entity)},
        )
        result += "\n".join([el['output'] for el in response])
    return result
```

`structured_retriever` 函数首先检测用户问题中提及的实体；随后，它遍历每个识别出的实体，并借助 Cypher 查询模板检索与之关联的图谱邻域节点。我们来实际测试一下！

```python
print(structured_retriever("Who is Elizabeth I?"))
# Elizabeth I - BORN_ON -> 7 September 1533
# Elizabeth I - DIED_ON -> 24 March 1603
# Elizabeth I - TITLE_HELD_FROM -> Queen Of England And Ireland
# Elizabeth I - TITLE_HELD_UNTIL -> 17 November 1558
# Elizabeth I - MEMBER_OF -> House Of Tudor
# Elizabeth I - CHILD_OF -> Henry Viii
# 以及更多...
```

### Final retriever

### 最终检索器

As we mentioned at the start, we’ll combine the unstructured and graph retriever to create the final context that will be passed to an LLM.

如开头所述，我们将结合非结构化检索器与图谱检索器，构建最终上下文，并将其传递给大语言模型（LLM）。

```python
def retriever(question: str):
    print(f"Search query: {question}")
    structured_data = structured_retriever(question)
    unstructured_data = [el.page_content for el in vector_index.similarity_search(question)]
    final_data = f"""Structured data:
{structured_data}
Unstructured data:
{"#Document ". join(unstructured_data)}
    """
    return final_data
```

```python
def retriever(question: str):
    print(f"Search query: {question}")
    structured_data = structured_retriever(question)
    unstructured_data = [el.page_content for el in vector_index.similarity_search(question)]
    final_data = f"""Structured data:
{structured_data}
Unstructured data:
{"#Document ". join(unstructured_data)}
    """
    return final_data
```

As we are dealing with Python, we can simply concatenate the outputs using the f-string.

由于我们使用的是 Python，因此可直接通过 f-string 简单拼接各部分输出。

## Defining the RAG chain

## 定义 RAG 链

We have successfully implemented the retrieval component of the RAG. Next, we introduce a prompt that leverages the context provided by the integrated hybrid retriever to produce the response, completing the implementation of the RAG chain.

我们已成功实现 RAG 的检索组件。接下来，我们将引入一个提示模板（prompt），该模板利用集成式混合检索器所提供的上下文生成回答，从而完成整个 RAG 链的实现。

```python
template = """Answer the question based only on the following context:
{context}

Question: {question}
"""
prompt = ChatPromptTemplate.from_template(template)

chain = (
    RunnableParallel(
        {
            "context": _search_query | retriever,
            "question": RunnablePassthrough(),
        }
    )
    | prompt
    | llm
    | StrOutputParser()
)
```

```python
template = """Answer the question based only on the following context:
{context}

Question: {question}
"""
prompt = ChatPromptTemplate.from_template(template)

chain = (
    RunnableParallel(
        {
            "context": _search_query | retriever,
            "question": RunnablePassthrough(),
        }
    )
    | prompt
    | llm
    | StrOutputParser()
)
```

Finally, we can go ahead and test our hybrid RAG implementation.

最后，我们可以正式启动并测试这一混合式 RAG 实现。

```python
chain.invoke({"question": "Which house did Elizabeth I belong to?"})
# Search query: Which house did Elizabeth I belong to?
# 'Elizabeth I belonged to the House of Tudor.'
```

```python
chain.invoke({"question": "伊丽莎白一世属于哪个王朝？"})
# 搜索查询：伊丽莎白一世属于哪个王朝？
# “伊丽莎白一世属于都铎王朝。”
```

I’ve also incorporated a query rewriting feature, enabling the RAG chain to adapt to conversational settings that allow follow-up questions. Given that we use vector and keyword search methods, we must rewrite follow-up questions to optimize our search process.

我还整合了查询重写（query rewriting）功能，使 RAG 链能够适应支持后续提问的对话式场景。由于我们同时采用向量搜索与关键词搜索方法，因此必须对后续问题进行重写，以优化检索过程。

```python
chain.invoke(
    {
        "question": "When was she born?",
        "chat_history": [("Which house did Elizabeth I belong to?",\
        "House Of Tudor")],
    }
)
# Search query: When was Elizabeth I born?
# 'Elizabeth I was born on 7 September 1533.'
```

```python
chain.invoke(
    {
        "question": "她出生于何时？",
        "chat_history": [("伊丽莎白一世属于哪个王朝？", "都铎王朝")],
    }
)
# 搜索查询：伊丽莎白一世出生于何时？
# “伊丽莎白一世出生于1533年9月7日。”
```

You can observe that `When was she born?` was first rewritten to `When was Elizabeth I born?` . The rewritten query was then used to retrieve relevant context and answer the question.

您可以看到，`When was she born?` 首先被重写为 `When was Elizabeth I born?`；随后，该重写后的查询被用于检索相关上下文并生成答案。

## Summary

## 总结

With the introduction of the `LLMGraphTransformer`, the process of generating knowledge graphs should now be smoother and more accessible, making it easier for anyone looking to enhance their RAG-based applications with the depth and context that knowledge graphs provide. This is just a start as we have a lot of improvements planned.

随着 `LLMGraphTransformer` 的引入，知识图谱的构建流程现已更加顺畅、更易上手，让任何希望借助知识图谱所赋予的深度与上下文能力来增强其 RAG 应用的开发者都能更轻松地实现目标。这仅仅是一个起点——我们已规划了大量后续改进。

If you have insights, suggestions, or questions about our generating graphs with LLMs, please don’t hesitate to reach out.

如果您对本系列使用大语言模型（LLM）构建知识图谱的方法有任何见解、建议或疑问，欢迎随时与我们联系。

The code is available on [GitHub](https://github.com/tomasonjo/blogs/blob/master/llm/enhancing_rag_with_graph.ipynb?ref=blog.langchain.com).

代码已在 [GitHub](https://github.com/tomasonjo/blogs/blob/master/llm/enhancing_rag_with_graph.ipynb?ref=blog.langchain.com) 上公开。

### Tags

### 标签

[Partner Post](https://blog.langchain.com/tag/partner-post/)  
[合作伙伴文章](https://blog.langchain.com/tag/partner-post/)

[![Graph-based metadata filtering for improving vector search in RAG applications](images/enhancing-rag-based-application-accuracy-by-constructing-and-leveraging-knowledg/img_005.webp)](https://blog.langchain.com/graph-based-metadata-filtering-for-improving-vector-search-in-rag-applications/)

[![基于图的元数据过滤以提升 RAG 应用中的向量搜索效果](images/enhancing-rag-based-application-accuracy-by-constructing-and-leveraging-knowledg/img_005.webp)](https://blog.langchain.com/graph-based-metadata-filtering-for-improving-vector-search-in-rag-applications/)

[**Graph-based metadata filtering for improving vector search in RAG applications**](https://blog.langchain.com/graph-based-metadata-filtering-for-improving-vector-search-in-rag-applications/)

[**基于图的元数据过滤以提升 RAG 应用中的向量搜索效果**](https://blog.langchain.com/graph-based-metadata-filtering-for-improving-vector-search-in-rag-applications/)

[Partner Post](https://blog.langchain.com/tag/partner-post/) 11 min read

[合作伙伴文章](https://blog.langchain.com/tag/partner-post/) 阅读时长：11 分钟
{% endraw %}
