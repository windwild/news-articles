---
title: "Using a Knowledge Graph to implement a DevOps RAG application"
source: "LangChain Blog"
url: "https://blog.langchain.com/using-a-knowledge-graph-to-implement-a-devops-rag-application/"
date: "2023-10-10"
scraped_at: "2026-03-03T08:39:02.399684146+00:00"
language: "en-zh"
translated: true
---
{% raw %}

_Editor's Note: This post was written in collaboration with the [_Neo4J_](https://neo4j.com/?ref=blog.langchain.com) team._

_编辑注：本文由 [_Neo4J_](https://neo4j.com/?ref=blog.langchain.com) 团队与作者合作撰写。_

RAG applications are all the rage at the moment. Everyone is building their company documentation chatbot or similar. Mostly, they all have in common that their source of knowledge is unstructured text, which gets chunked and embedded in one way or another. However, not all information arrives as unstructured text.

当前，RAG（检索增强生成）应用正风靡一时。几乎每家公司都在构建自己的企业文档聊天机器人，或类似的应用。这些应用大多有一个共同点：其知识来源是**非结构化文本**，这些文本通常被切分为若干片段（chunked），再以某种方式嵌入（embedded）。然而，并非所有信息都以非结构化文本的形式存在。

Say, for example, you wanted to create a chatbot that could answer questions about your microservice architecture, ongoing tasks, and more. Tasks are mostly defined as unstructured text, so there wouldn’t be anything different from the usual RAG workflow there. However, how could you prepare information about your microservices architecture so the chatbot can retrieve up-to-date information? One option would be to create daily snapshots of the architecture and transform them into text that the LLM would understand. However, what if there is a better approach? Meet knowledge graphs, which can store both structured and unstructured information in a single database.

例如，假设你想构建一个聊天机器人，用于回答有关你公司微服务架构、正在进行的任务等问题。任务本身多以非结构化文本形式定义（如任务描述），因此这部分可直接沿用常规 RAG 流程，无需额外改动。但问题来了：如何组织你的微服务架构信息，才能让聊天机器人实时获取最新、准确的架构数据？一种思路是每天生成一份架构快照，并将其转换为大语言模型（LLM）可理解的文本。但——是否存在更优方案？答案是：**知识图谱（Knowledge Graph）**。它能将**结构化信息**与**非结构化信息**统一存储于单一数据库中。

![](images/using-a-knowledge-graph-to-implement-a-devops-rag-application/img_001.png)Knowledge graph schema representing microservice architecture and their tasks. Image by author.

![](images/using-a-knowledge-graph-to-implement-a-devops-rag-application/img_001.png)表示微服务架构及其关联任务的知识图谱模式图。图片由作者提供。

Nodes and relationships are used to describe data in a knowledge graph. Typically, nodes are used to represent entities or concepts like people, organizations, and locations. In the microservice graph example, nodes describe people, teams, microservices, and tasks. On the other hand, relationships are used to define connections between these entities, like dependencies between microservices or task owners.

在知识图谱中，数据通过**节点（Nodes）** 和 **关系（Relationships）** 来建模。通常，节点用于表示实体或概念，例如人、组织、地理位置等。在本例的微服务图谱中，节点代表人员、团队、微服务和任务；而关系则用于刻画这些实体之间的关联，例如微服务之间的依赖关系、任务的负责人等。

Both nodes and relationships can have property values stored as key-value pairs.

节点和关系均可携带属性（Properties），以键值对（key-value pairs）形式存储。

![](images/using-a-knowledge-graph-to-implement-a-devops-rag-application/img_002.png)Node properties of a Microservice and Task nodes. Image by author.

![](images/using-a-knowledge-graph-to-implement-a-devops-rag-application/img_002.png)Microservice 节点与 Task 节点的属性示意图。图片由作者提供。

The microservice nodes have two node properties describing their name and technology. On the other hand, task nodes are more complex. They have the the name, status, description, as well as embedding properties. By storing text embedding values as node properties, you can perform a vector similarity search of task descriptions identical to if you had the tasks stored in a vector database. Therefore, knowledge graphs allow you to store and retrieve both structured and unstructured information to power your RAG applications.

Microservice 节点包含两个属性：`name`（名称）与 `technology`（所用技术）；而 Task 节点则更为丰富，包含 `name`（名称）、`status`（状态）、`description`（描述）以及 `embedding`（嵌入向量）等属性。将文本嵌入向量作为节点属性直接存储后，即可对任务描述执行向量相似性搜索——其效果与将任务存入专用向量数据库完全一致。因此，知识图谱使你能够**在同一系统中统一存储并高效检索结构化与非结构化信息**，从而为 RAG 应用提供强大支撑。

In this blog post, I’ll walk you through a scenario of implementing a knowledge graph based RAG application with LangChain to support your DevOps team. The code is available on [GitHub](https://github.com/tomasonjo/blogs/blob/master/llm/devops_rag.ipynb?ref=blog.langchain.com).

本文将带你完整实现一个基于知识图谱的 RAG 应用，借助 LangChain 为你的 DevOps 团队赋能。全部代码已开源，详见 [GitHub](https://github.com/tomasonjo/blogs/blob/master/llm/devops_rag.ipynb?ref=blog.langchain.com)。

## Neo4j Environment Setup

## Neo4j 环境搭建

You need to set up a Neo4j 5.11 or greater to follow along with the examples in this blog post. The easiest way is to start a free instance on [Neo4j Aura](https://neo4j.com/cloud/platform/aura-graph-database/?ref=blog.langchain.com), which offers cloud instances of Neo4j database. Alternatively, you can also set up a local instance of the Neo4j database by downloading the [Neo4j Desktop](https://neo4j.com/download/?ref=blog.langchain.com) application and creating a local database instance.  
你需要搭建一个 Neo4j 5.11 或更高版本的数据库，以便跟随本文中的示例操作。最简便的方式是在 [Neo4j Aura](https://neo4j.com/cloud/platform/aura-graph-database/?ref=blog.langchain.com) 上启动一个免费实例——该平台提供托管在云端的 Neo4j 数据库服务。你也可以选择通过下载 [Neo4j Desktop](https://neo4j.com/download/?ref=blog.langchain.com) 应用程序，在本地部署 Neo4j 数据库并创建一个本地数据库实例。

```python
from langchain.graphs import Neo4jGraph

url = "neo4j+s://databases.neo4j.io"
username ="neo4j"
password = ""

graph = Neo4jGraph(
    url=url,
    username=username,
    password=password
)
```

```python
from langchain.graphs import Neo4jGraph

url = "neo4j+s://databases.neo4j.io"
username ="neo4j"
password = ""

graph = Neo4jGraph(
    url=url,
    username=username,
    password=password
)
```

## Dataset

## 数据集

Knowledge graphs are excellent at connecting information from multiple data sources. You could fetch information from cloud services, task management tools, and more when developing a DevOps RAG application.  
知识图谱非常擅长整合来自多个数据源的信息。在开发面向 DevOps 场景的 RAG（检索增强生成）应用时，你可以从云服务、任务管理工具等各类系统中获取信息。

![](images/using-a-knowledge-graph-to-implement-a-devops-rag-application/img_003.png)Combining multiple data sources into a knowledge graph. Image by author.  
![](images/using-a-knowledge-graph-to-implement-a-devops-rag-application/img_003.png)将多个数据源整合为一个知识图谱。图片由作者提供。

```python
import requests

url = "https://gist.githubusercontent.com/tomasonjo/08dc8ba0e19d592c4c3cde40dd6abcc3/raw/da8882249af3e819a80debf3160ebbb3513ee962/microservices.json"
import_query = requests.get(url).json()['query']
graph.query(
    import_query
)
```

```python
import requests

url = "https://gist.githubusercontent.com/tomasonjo/08dc8ba0e19d592c4c3cde40dd6abcc3/raw/da8882249af3e819a80debf3160ebbb3513ee962/microservices.json"
import_query = requests.get(url).json()['query']
graph.query(
    import_query
)
```

If you inspect the graph in Neo4j Browser, you should get a similar visualization.  
如果你在 Neo4j Browser 中查看该图谱，应能看到与下图相似的可视化效果。

![](images/using-a-knowledge-graph-to-implement-a-devops-rag-application/img_004.png)DevOps 图的一个子集。图片由作者提供。

![](images/using-a-knowledge-graph-to-implement-a-devops-rag-application/img_004.png)DevOps 图的一个子集。图片由作者提供。

蓝色节点表示微服务。这些微服务之间可能存在依赖关系，即某一微服务的功能或输出可能依赖于另一微服务的运行。另一方面，棕色节点代表与这些微服务直接关联的任务。除了展示系统架构及其关联任务外，我们的图谱还标明了各团队分别负责哪些部分。

蓝色节点表示微服务。这些微服务之间可能存在依赖关系，即某一微服务的功能或输出可能依赖于另一微服务的运行。另一方面，棕色节点代表与这些微服务直接关联的任务。除了展示系统架构及其关联任务外，我们的图谱还标明了各团队分别负责哪些部分。

## Neo4j Vector index

## Neo4j 向量索引

We will begin by implementing a vector index search for finding relevant tasks by their name and description. If you are unfamiliar with vector similarity search, let me give you a quick refresher. The key idea is to calculate the text embedding values for each task based on their description and name. Then, at query time, find the most similar tasks to the user input using a similarity metric like a cosine distance.

我们将首先实现一个向量索引搜索功能，用于根据任务名称和描述查找相关任务。若您不熟悉向量相似性搜索，下面简要回顾一下其核心思想：首先，基于每个任务的名称和描述计算其文本嵌入（embedding）值；然后，在查询时，使用余弦距离等相似度度量方法，找出与用户输入最相似的任务。

![](images/using-a-knowledge-graph-to-implement-a-devops-rag-application/img_005.png)Vector similarity search in a RAG application. Image by author.

![](images/using-a-knowledge-graph-to-implement-a-devops-rag-application/img_005.png)RAG 应用中的向量相似性搜索。图片由作者提供。

The retrieved information from the vector index can then be used as context to the LLM so it can generate accurate and up-to-date answers.

随后，向量索引检索出的信息可作为上下文输入大语言模型（LLM），从而使其生成准确且时效性强的回答。

The tasks are already in our knowledge graph. However, we need to calculate the embedding values and create the vector index. This can be achieved with the `from_existing_graph` method.

任务已存在于我们的知识图谱中。但我们需要为其计算嵌入值并构建向量索引。这可通过 `from_existing_graph` 方法实现。

```python
import os
from langchain.vectorstores.neo4j_vector import Neo4jVector
from langchain.embeddings.openai import OpenAIEmbeddings

os.environ['OPENAI_API_KEY'] = "OPENAI_API_KEY"

vector_index = Neo4jVector.from_existing_graph(
    OpenAIEmbeddings(),
    url=url,
    username=username,
    password=password,
    index_name='tasks',
    node_label="Task",
    text_node_properties=['name', 'description', 'status'],
    embedding_node_property='embedding',
)
```

In this example, we used the following graph-specific parameters for the `from_existing_graph` method.

在本示例中，我们为 `from_existing_graph` 方法使用了以下图专属参数。

- index\_name: name of the vector index  
- index\_name：向量索引的名称  

- node\_label: node label of relevant nodes  
- node\_label：相关节点的节点标签  

- text\_node\_properties: properties to be used to calculate embeddings and retrieve from the vector index  
- text\_node\_properties：用于计算嵌入向量以及从向量索引中检索的节点属性  

- embedding\_node\_property: which property to store the embedding values to  
- embedding\_node\_property：指定将嵌入向量值存储到哪个节点属性中  

Now that the vector index has been initiated, we can use it as any other vector index in LangChain.

现在，向量索引已成功初始化，我们可以像使用 LangChain 中其他任何向量索引一样使用它。

```python
response = vector_index.similarity_search(
    "How will RecommendationService be updated?"
)
print(response[0].page_content)
# name: BugFix
# description: Add a new feature to RecommendationService to provide ...
# status: In Progress
```

You can observe that we construct a response of a map or dictionary-like string with defined properties in the `text_node_properties` parameter.

您可观察到，我们构建的响应是一个类似字典（map）的字符串，其中包含 `text_node_properties` 参数所定义的属性。

Now we can easily create a chatbot response by wrapping the vector index into a `RetrievalQA` module.

现在，我们只需将向量索引封装进 `RetrievalQA` 模块，即可轻松构建聊天机器人响应。

```python
from langchain.chains import RetrievalQA
from langchain.chat_models import ChatOpenAI

vector_qa = RetrievalQA.from_chain_type(
    llm=ChatOpenAI(),
    chain_type="stuff",
    retriever=vector_index.as_retriever()
)
vector_qa.run(
    "How will recommendation service be updated?"
)
# The RecommendationService is currently being updated to include a new feature
# that will provide more personalized and accurate product recommendations to
# users. This update involves leveraging user behavior and preference data to
# enhance the recommendation algorithm. The status of this update is currently
# in progress.
```

One limitation of vector indexes, in general, is that they don’t provide the ability to aggregate information like you would with a structured query language like Cypher. Take, for example, the following example:

向量索引普遍存在一个局限性：它们无法像 Cypher 这类结构化查询语言那样对信息进行聚合操作。例如，考虑以下示例：

```python
vector_qa.run(
    "How many open tickets there are?"
)
# There are 4 open tickets.
```

The response seems valid, and the LLM uses assertive language, making you believe the result is correct.  
该响应看似合理，且大语言模型（LLM）使用了肯定性措辞，使你倾向于相信其结果是正确的。

However, the problem is that the response directly correlates to the number of retrieved documents from the vector index, which is four by default.  
然而，问题在于：该响应直接取决于向量索引所检索出的文档数量——而该数量默认为四。

What actually happens is that the vector index retrieves four open tickets, and the LLM unquestioningly believes that those are all the open tickets.  
实际情况是：向量索引仅检索出了四个“待处理”（Open）工单，而大语言模型不加质疑地将这四个工单认定为全部的待处理工单。

However, the truth is different, and we can validate it using a Cypher statement.  
但事实并非如此，我们可通过一条 Cypher 语句来验证这一点。

```python
graph.query(
    "MATCH (t:Task {status:'Open'}) RETURN count(*)"
)
# [{'count(*)': 5}]
```

There are five open tasks in our toy graph.  
我们的示例图数据库中实际存在五个状态为“待处理”的任务（Task）。

While vector similarity search is excellent for sifting through relevant information in unstructured text, it lacks the capability to analyze and aggregate structured information.  
尽管向量相似性搜索在从非结构化文本中筛选相关信息方面表现出色，但它无法对结构化数据进行分析与聚合。

Using Neo4j, this problem can be easily solved by employing Cypher, which is a structured query language for graph databases.  
借助 Neo4j，我们可轻松通过 Cypher（一种专为图数据库设计的结构化查询语言）解决这一问题。

## Graph Cypher search

## 图数据库 Cypher 查询

Cypher is a structured query language designed to interact with graph databases and provides a visual way of matching patterns and relationships.  
Cypher 是一种专为图数据库交互而设计的结构化查询语言，它以可视化方式匹配图中的模式与关系。

It relies on the following **ascii**- **art** type of syntax:  
其语法采用如下类 ASCII 艺术（ASCII-art）风格：

```python
(:Person {name:"Tomaz"})-[:LIVES_IN]->(:Country {name:"Slovenia"})
```

This patterns describes a node with a label **Person** and the name property **Tomaz** that has a **LIVES\_IN** relationship to the **Country** node of **Slovenia**.  
该模式描述了一个标签为 **Person**、属性 `name` 为 `"Tomaz"` 的节点；该节点通过名为 **LIVES\_IN** 的关系，指向另一个标签为 **Country**、属性 `name` 为 `"Slovenia"` 的节点。

The neat thing about LangChain is that it provides a [GraphCypherQAChain](https://python.langchain.com/docs/use_cases/more/graph/graph_cypher_qa?ref=blog.langchain.com), which generates the Cypher queries for you, so you don’t have to learn Cypher syntax in order to retrieve information from a graph database like Neo4j.  
LangChain 的一大亮点在于它提供了 [GraphCypherQAChain](https://python.langchain.com/docs/use_cases/more/graph/graph_cypher_qa?ref=blog.langchain.com)，可自动为您生成 Cypher 查询语句——这意味着您无需学习 Cypher 语法，即可从 Neo4j 等图数据库中检索信息。

The following code will refresh the graph schema and instantiate the Cypher chain.  
以下代码将刷新图数据库的 Schema，并初始化 Cypher 查询链（Cypher chain）。

```python
from langchain.chains import GraphCypherQAChain
```

```python
graph.refresh_schema()

cypher_chain = GraphCypherQAChain.from_llm(
    cypher_llm = ChatOpenAI(temperature=0, model_name='gpt-4'),
    qa_llm = ChatOpenAI(temperature=0), graph=graph, verbose=True,
)
```

```python
graph.refresh_schema()

cypher_chain = GraphCypherQAChain.from_llm(
    cypher_llm = ChatOpenAI(temperature=0, model_name='gpt-4'),
    qa_llm = ChatOpenAI(temperature=0), graph=graph, verbose=True,
)
```

Generating valid Cypher statements is a complex task. Therefore, it is recommended to use state-of-the-art LLMs like gpt-4 to generate Cypher statements, while generating answers using the database context can be left to gpt-3.5-turbo.

生成有效的 Cypher 语句是一项复杂任务。因此，建议使用 gpt-4 等当前最先进的大语言模型（LLM）来生成 Cypher 语句；而利用数据库上下文生成最终答案的任务，则可交由 gpt-3.5-turbo 完成。

Now, you can ask the same question about how many tickets are open.

现在，你可以提出相同的问题：“当前有多少张工单处于开启状态？”

```python
cypher_chain.run(
    "How many open tickets there are?"
)
```

```python
cypher_chain.run(
    "How many open tickets there are?"
)
```

_Result is the following_

_结果如下所示_

![](images/using-a-knowledge-graph-to-implement-a-devops-rag-application/img_006.png)

![](images/using-a-knowledge-graph-to-implement-a-devops-rag-application/img_006.png)

You can also ask the chain to aggregate the data using various grouping keys, like the following example.

你还可以要求该链式流程基于不同分组键对数据进行聚合，例如以下示例：

```python
cypher_chain.run(
    "Which team has the most open tasks?"
)
```

```python
cypher_chain.run(
    "Which team has the most open tasks?"
)
```

_Result is the following_

_结果如下所示_

![](images/using-a-knowledge-graph-to-implement-a-devops-rag-application/img_007.png)

![](images/using-a-knowledge-graph-to-implement-a-devops-rag-application/img_007.png)

你可能会说，这些聚合操作并非基于图的操作——你的说法完全正确。当然，我们也可以执行更多真正基于图的操作，例如遍历微服务之间的依赖关系图。

我们当然可以执行更多基于图的操作，例如遍历微服务之间的依赖关系图。

```python
cypher_chain.run(
    "Which services depend on Database directly?"
)
```

```python
cypher_chain.run(
    "哪些服务直接依赖于 Database？"
)
```

_Result is the following_

_结果如下所示_

![](images/using-a-knowledge-graph-to-implement-a-devops-rag-application/img_008.png)

![](images/using-a-knowledge-graph-to-implement-a-devops-rag-application/img_008.png)

当然，你还可以让该链执行[可变长度路径遍历](https://graphaware.com/graphaware/2015/05/19/neo4j-cypher-variable-length-relationships-by-example.html?ref=blog.langchain.com)（variable-length path traversals），只需提出类似以下的问题即可：

当然，你还可以通过提出类似以下的问题，让该链执行[可变长度路径遍历](https://graphaware.com/graphaware/2015/05/19/neo4j-cypher-variable-length-relationships-by-example.html?ref=blog.langchain.com)：

```python
cypher_chain.run(
    "Which services depend on Database indirectly?"
)
```

```python
cypher_chain.run(
    "哪些服务间接依赖于 Database？"
)
```

![](images/using-a-knowledge-graph-to-implement-a-devops-rag-application/img_009.png)

![](images/using-a-knowledge-graph-to-implement-a-devops-rag-application/img_009.png)

部分所列出的服务与“直接依赖”问题中的服务相同。这源于依赖关系图本身的结构，而非 Cypher 语句有误。

部分所列出的服务与“直接依赖”问题中的服务相同。这源于依赖关系图本身的结构，而非 Cypher 语句有误。

## Knowledge graph agent

## 知识图谱智能体

Since we have implemented separate tools for the structured and unstructured parts of the knowledge graph, we can add an agent that can use these two tools to explore the knowledge graph.

由于我们已为知识图谱的结构化部分和非结构化部分分别实现了独立的工具，因此可以添加一个能够利用这两个工具来探索知识图谱的智能体（agent）。

```python
from langchain.agents import initialize_agent, Tool
from langchain.agents import AgentType

tools = [\
    Tool(\
        name="Tasks",\
        func=vector_qa.run,\
        description="""Useful when you need to answer questions about descriptions of tasks.\
        Not useful for counting the number of tasks.\
        Use full question as input.\
        """,\
    ),\
    Tool(\
        name="Graph",\
        func=cypher_chain.run,\
        description="""Useful when you need to answer questions about microservices,\
        their dependencies or assigned people. Also useful for any sort of\
        aggregation like counting the number of tasks, etc.\
        Use full question as input.\
        """,\
    ),\
]

mrkl = initialize_agent(
    tools,
    ChatOpenAI(temperature=0, model_name='gpt-4'),
    agent=AgentType.OPENAI_FUNCTIONS, verbose=True
)
```

```python
from langchain.agents import initialize_agent, Tool
from langchain.agents import AgentType

tools = [\
    Tool(\
        name="Tasks",\
        func=vector_qa.run,\
        description="""当需要回答有关任务描述的问题时非常有用。\
        不适用于统计任务数量。\
        请将完整问题作为输入。\
        """,\
    ),\
    Tool(\
        name="Graph",\
        func=cypher_chain.run,\
        description="""当需要回答有关微服务、其依赖关系或指派人员的问题时非常有用；\
        同样适用于各类聚合类查询，例如统计任务数量等。\
        请将完整问题作为输入。\
        """,\
    ),\
]

mrkl = initialize_agent(
    tools,
    ChatOpenAI(temperature=0, model_name='gpt-4'),
    agent=AgentType.OPENAI_FUNCTIONS, verbose=True
)
```

Let’s try out how well does the agent works.

我们来测试一下该智能体的实际表现效果。

我们来测试一下该智能体的实际表现效果。

```python
response = mrkl.run("Which team is assigned to maintain PaymentService?")
print(response)
```

```python
response = mrkl.run("哪个团队被指派负责维护 PaymentService？")
print(response)
```

_Result is the following_

_结果如下所示_

![](images/using-a-knowledge-graph-to-implement-a-devops-rag-application/img_010.png)

![](images/using-a-knowledge-graph-to-implement-a-devops-rag-application/img_010.png)

Let’s now try to invoke the **Tasks** tool.

接下来，我们尝试调用 **Tasks** 工具。

接下来，我们尝试调用 **Tasks** 工具。

```python
response = mrkl.run("Which tasks have optimization in their description?")
print(response)
```

```python
response = mrkl.run("哪些任务的描述中包含 ‘optimization’？")
print(response)
```

_Result is the following_

_结果如下所示_

![](images/using-a-knowledge-graph-to-implement-a-devops-rag-application/img_011.png)

One thing is certain. I have to work on my agent prompt engineering skills. There is definitely room for improvement in tools description. Additionally, you can also customize the agent prompt.

有一点是确定的：我需要提升自己的智能体提示工程（agent prompt engineering）能力。工具描述部分显然还有很大的优化空间。此外，你也可以自定义智能体提示。

## Conclusion

## 结论

Knowledge graphs are an excellent fit when you require structured and unstructured data to power your RAG applications. With the approach shown in this blog post, you can avoid polyglot architectures, where you must maintain and sync multiple types of databases. Learn more about graph-based search in LangChain [here](https://medium.com/neo4j/langchain-cypher-search-tips-tricks-f7c9e9abca4d?ref=blog.langchain.com).

当你的 RAG 应用需要同时利用结构化与非结构化数据时，知识图谱（Knowledge Graphs）是非常理想的选择。通过本文所介绍的方法，你可以避免采用“多语言架构”（polyglot architectures）——即无需维护和同步多种不同类型的数据库。有关 LangChain 中基于图的搜索的更多内容，请参阅[此处](https://medium.com/neo4j/langchain-cypher-search-tips-tricks-f7c9e9abca4d?ref=blog.langchain.com)。

The code is available on [GitHub](https://github.com/tomasonjo/blogs/blob/master/llm/devops_rag.ipynb?ref=blog.langchain.com).

源代码托管在 [GitHub](https://github.com/tomasonjo/blogs/blob/master/llm/devops_rag.ipynb?ref=blog.langchain.com) 上。

If you are eager to learn more about building AI applications with graphs, join us at the [NODES, online, 24h conference](https://neo4j.registration.goldcast.io/events/6fb85147-ca27-4310-9dec-cb345c53bd6f?ref=blog.langchain.com) organized by Neo4j on October 26th, 2023.

如果你渴望深入了解如何借助图技术构建 AI 应用，欢迎参加 Neo4j 于 2023 年 10 月 26 日举办的线上全天候会议——[NODES 大会](https://neo4j.registration.goldcast.io/events/6fb85147-ca27-4310-9dec-cb345c53bd6f?ref=blog.langchain.com)。
{% endraw %}
