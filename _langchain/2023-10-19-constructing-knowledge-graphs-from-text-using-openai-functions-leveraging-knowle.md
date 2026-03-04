---
render_with_liquid: false
title: "Constructing knowledge graphs from text using OpenAI functions: Leveraging knowledge graphs to power LangChain Applications"
source: "LangChain Blog"
url: "https://blog.langchain.com/constructing-knowledge-graphs-from-text-using-openai-functions/"
date: "2023-10-19"
scraped_at: "2026-03-03T08:33:44.958523651+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

_Editor's Note: This post was written by [_Tomaz Bratanic_](https://twitter.com/tb_tomaz?ref=blog.langchain.com) from the Neo4j team._

_编辑者注：本文由 Neo4j 团队的 [_Tomaz Bratanic_](https://twitter.com/tb_tomaz?ref=blog.langchain.com) 撰写。_

Extracting structured information from unstructured data like text has been around for some time and is nothing new. However, LLMs brought a significant shift to the field of information extraction. If before you needed a team of machine learning experts to curate datasets and train custom models, you only need access to an LLM nowadays. The barrier to entry has dropped significantly, making what was just a couple of years ago reserved for domain experts more accessible to even non-technical people.

从非结构化数据（如文本）中提取结构化信息，这一任务已存在多年，并非新鲜事物。然而，大语言模型（LLM）为信息抽取领域带来了显著变革。过去，你需要一支机器学习专家团队来整理数据集并训练定制模型；而如今，你只需接入一个 LLM 即可。入门门槛大幅降低，使得几年前还仅限于领域专家才能完成的任务，如今连非技术人员也能轻松上手。

![](images/constructing-knowledge-graphs-from-text-using-openai-functions-leveraging-knowle/img_001.jpg)The goal of information extraction pipeline is to extract structured information from unstructured text. Image by the author.

![](images/constructing-knowledge-graphs-from-text-using-openai-functions-leveraging-knowle/img_001.jpg)信息抽取流水线的目标是从非结构化文本中提取结构化信息。图片由作者提供。

The image depicts the transformation of unstructured text into structured information. This process, labeled as the information extraction pipeline, results in a graph representation of information. The nodes represent key entities, while the connecting lines denote the relationships between these entities. Knowledge graphs are useful for [multi-hop question-answering](https://medium.com/neo4j/knowledge-graphs-llms-multi-hop-question-answering-322113f53f51?ref=blog.langchain.com), [real-time analytics](https://medium.com/neo4j/knowledge-graphs-llms-real-time-graph-analytics-89b392eaaa95?ref=blog.langchain.com), or when you want to [combine structured and unstructured data in a single database](https://blog.langchain.com/using-a-knowledge-graph-to-implement-a-devops-rag-application/).

该图展示了将非结构化文本转化为结构化信息的过程。这一流程被称为“信息抽取流水线”，其输出结果是一种以图形式表示的信息——图中的节点代表关键实体，连接节点的边则表示这些实体之间的关系。知识图谱在以下场景中极具价值：[多跳问答（multi-hop question-answering）](https://medium.com/neo4j/knowledge-graphs-llms-multi-hop-question-answering-322113f53f51?ref=blog.langchain.com)、[实时图分析（real-time analytics）](https://medium.com/neo4j/knowledge-graphs-llms-real-time-graph-analytics-89b392eaaa95?ref=blog.langchain.com)，或当你希望在**单一数据库中融合结构化与非结构化数据**时（参见：[使用知识图谱构建 DevOps RAG 应用](https://blog.langchain.com/using-a-knowledge-graph-to-implement-a-devops-rag-application/)）。

While extracting structured information from text has been made more accessible due to LLMs, it is by no means a solved problem. In this blog post, we will use [OpenAI functions in combination with LangChain](https://python.langchain.com/docs/modules/chains/how_to/openai_functions?ref=blog.langchain.com) to construct a knowledge graph from a sample Wikipedia page. Along the way, we will discuss best practices as well as some limitations of current LLMs.

尽管 LLM 极大地提升了文本结构化信息抽取的易用性，但该问题远未得到彻底解决。在本文中，我们将结合 [OpenAI 函数与 LangChain](https://python.langchain.com/docs/modules/chains/how_to/openai_functions?ref=blog.langchain.com)，从一篇示例 Wikipedia 页面中构建知识图谱。过程中，我们将探讨相关最佳实践，以及当前 LLM 存在的一些局限性。

tldr; The code is available on [GitHub](https://github.com/tomasonjo/blogs/blob/master/llm/openaifunction_constructing_graph.ipynb?ref=blog.langchain.com).

简言之：代码已开源至 [GitHub](https://github.com/tomasonjo/blogs/blob/master/llm/openaifunction_constructing_graph.ipynb?ref=blog.langchain.com)。

# Neo4j Environment setup

# Neo4j 环境搭建

You need to setup a Neo4j to follow along with the examples in this blog post. The easiest way is to start a free instance on [Neo4j Aura](https://neo4j.com/cloud/platform/aura-graph-database/?ref=blog.langchain.com), which offers cloud instances of Neo4j database. Alternatively, you can also setup a local instance of the Neo4j database by downloading the [Neo4j Desktop](https://neo4j.com/download/?ref=blog.langchain.com) application and creating a local database instance.

为顺利运行本文中的示例，你需要部署一个 Neo4j 数据库。最便捷的方式是通过 [Neo4j Aura](https://neo4j.com/cloud/platform/aura-graph-database/?ref=blog.langchain.com) 免费启动一个云端 Neo4j 实例。此外，你也可以下载 [Neo4j Desktop](https://neo4j.com/download/?ref=blog.langchain.com) 应用程序，在本地安装并创建一个 Neo4j 数据库实例。

The following code will instantiate a LangChain wrapper to connect to Neo4j Database.

以下代码将实例化一个 LangChain 封装器，用于连接 Neo4j 数据库。

```
from langchain.graphs import Neo4jGraph
```

```python
url = "neo4j+s://databases.neo4j.io"
username ="neo4j"
password = ""
graph = Neo4jGraph(
    url=url,
    username=username,
    password=password
)
```

# Information extraction pipeline  
# 信息抽取流程

A typical information extraction pipeline contains the following steps.  
典型的**信息抽取流程**包含以下步骤。

![](images/constructing-knowledge-graphs-from-text-using-openai-functions-leveraging-knowle/img_002.png)Multiple steps of information extraction pipeline. Image by author.  
![](images/constructing-knowledge-graphs-from-text-using-openai-functions-leveraging-knowle/img_002.png)信息抽取流程的多个步骤。图片由作者提供。

In the first step, we run the input text through a coreference resolution model. The coreference resolution is the task of finding all expressions that refer to a specific entity. Simply put, it links all the pronouns to the referred entity. In the named entity recognition part of the pipeline, we try to extract all the mentioned entities. The above example contains three entities: Tomaz, Blog, and Diagram. The next step is the entity disambiguation step, an essential but often overlooked part of an information extraction pipeline. Entity disambiguation is the process of accurately identifying and distinguishing between entities with similar names or references to ensure the correct entity is recognized in a given context. In the last step, the model tried to identify various relationships between entities. For example, it could locate the **LIKES** relationship between **Tomaz** and **Blog** entities.  
第一步中，我们将输入文本送入共指消解（coreference resolution）模型。共指消解任务旨在识别所有指向同一特定实体的语言表达式；简而言之，它将代词等指代表达与所指实体进行关联。在流程的命名实体识别（Named Entity Recognition, NER）环节，我们尝试抽取出文本中提及的所有实体。上述示例包含三个实体：`Tomaz`、`Blog` 和 `Diagram`。下一步是**实体消歧（entity disambiguation）**——这是信息抽取流程中至关重要却常被忽视的一环。实体消歧是指在上下文中准确识别并区分名称相似或指代模糊的实体，从而确保正确识别出目标实体。最后一步中，模型尝试识别实体之间的各类关系。例如，它可定位出 `Tomaz` 与 `Blog` 实体之间存在的 **`LIKES`** 关系。

## Extracting structured information with OpenAI functions  
## 使用 OpenAI 函数抽取结构化信息

[OpenAI functions](https://openai.com/blog/function-calling-and-other-api-updates?ref=blog.langchain.com) are a great fit to extract structured information from natural language. The idea behind OpenAI functions is to have an LLM output a predefined JSON object with populated values. The predefined JSON object can be used as input to other functions in so-called RAG applications, or it can be used to extract predefined structured information from text.  
[OpenAI 函数（OpenAI functions）](https://openai.com/blog/function-calling-and-other-api-updates?ref=blog.langchain.com) 非常适合从自然语言中抽取结构化信息。其核心思想是：让大语言模型（LLM）直接输出一个预定义格式的 JSON 对象，且其中字段均已填充具体值。该预定义 JSON 对象既可作为所谓 RAG（检索增强生成）应用中其他函数的输入，也可用于从文本中提取预先设定好的结构化信息。

In LangChain, you can [pass a Pydantic class as description](https://python.langchain.com/docs/modules/chains/how_to/openai_functions?ref=blog.langchain.com) of the desired JSON object of the OpenAI functions feature. Therefore, we will start by defining the desired structure of information we want to extract from text. LangChain already has [definitions of nodes and relationship as Pydantic classes that we can reuse](https://github.com/langchain-ai/langchain/blob/master/libs/langchain/langchain/graphs/graph_document.py?ref=blog.langchain.com).  
在 LangChain 中，你可以[将一个 Pydantic 类作为参数传入](https://python.langchain.com/docs/modules/chains/how_to/openai_functions?ref=blog.langchain.com)，用以描述 OpenAI 函数功能所期望输出的 JSON 对象结构。因此，我们将首先定义希望从文本中抽取的信息结构。LangChain 已内置了[可复用的节点（node）与关系（relationship）的 Pydantic 类定义](https://github.com/langchain-ai/langchain/blob/master/libs/langchain/langchain/graphs/graph_document.py?ref=blog.langchain.com)。

```python
class Node(Serializable):
    """Represents a node in a graph with associated properties.

    Attributes:
        id (Union[str, int]): A unique identifier for the node.
        type (str): The type or label of the node, default is "Node".
        properties (dict): Additional properties and metadata associated with the node.
    """
```  
```python
class Node(Serializable):
    """表示图中一个带有属性的节点。

    属性：
        id (Union[str, int])：该节点的唯一标识符。
        type (str)：节点的类型或标签，默认为 "Node"。
        properties (dict)：与该节点关联的其他属性和元数据。
    """
```

```python
id: Union[str, int]
id：联合类型 str 或 int

type: str = "Node"
type：str 类型，默认值为 "Node"

properties: dict = Field(default_factory=dict)
properties：字典类型，使用 Field 指定默认工厂函数生成空字典
```

class Relationship(Serializable):
class Relationship(Serializable)：

    """Represents a directed relationship between two nodes in a graph.

    Attributes:
        source (Node): The source node of the relationship.
        target (Node): The target node of the relationship.
        type (str): The type of the relationship.
        properties (dict): Additional properties associated with the relationship.
    """

    """表示图中两个节点之间的有向关系。

    属性：
        source（Node）：该关系的源节点。
        target（Node）：该关系的目标节点。
        type（str）：该关系的类型。
        properties（dict）：与该关系关联的额外属性。
    """

    source: Node
    source：Node 类型

    target: Node
    target：Node 类型

    type: str
    type：str 类型

    properties: dict = Field(default_factory=dict)
    properties：字典类型，使用 Field 指定默认工厂函数生成空字典
```

Unfortunately, it turns out that OpenAI functions don’t currently support a dictionary object as a value. Therefore, we have to overwrite the **properties** definition to adhere to the limitations of the functions’ endpoint.

遗憾的是，目前 OpenAI 函数尚不支持将字典对象作为参数值。因此，我们必须重写 **properties** 的定义，以适配函数接口（functions’ endpoint）的限制。
```

from langchain.graphs.graph_document import (
    Node as BaseNode,
    Relationship as BaseRelationship
)
from typing import List, Dict, Any, Optional
from langchain.pydantic_v1 import Field, BaseModel

from langchain.graphs.graph_document import (
    Node as BaseNode,
    Relationship as BaseRelationship
)
from typing import List, Dict, Any, Optional
from langchain.pydantic_v1 import Field, BaseModel

class Property(BaseModel):
  """A single property consisting of key and value"""
  key: str = Field(..., description="key")
  value: str = Field(..., description="value")

class Property(BaseModel)：
    """一个由键（key）和值（value）组成的单一属性"""
    key：str 类型，必填字段，描述为 "key"
    value：str 类型，必填字段，描述为 "value"

class Node(BaseNode):
    properties: Optional[List[Property]] = Field(
        None, description="List of node properties")

class Node(BaseNode)：
    properties：Optional[List[Property]] 类型，使用 Field 指定默认值为 None，描述为“节点属性列表”

class Relationship(BaseRelationship):
    properties: Optional[List[Property]] = Field(
        None, description="List of relationship properties"
    )

class Relationship(BaseRelationship)：
    properties：Optional[List[Property]] 类型，使用 Field 指定默认值为 None，描述为“关系属性列表”
```

Here, we have overwritten the properties value to be a list of **Property** classes instead of a dictionary to overcome the limitations of the API. Because you can only pass a single object to the API, we can to combine the nodes and relationships in a single class called **KnowledgeGraph**.

此处，我们将 `properties` 的类型由字典改为 **Property** 类的列表，以规避 API 的限制。由于 API 仅允许传入单个对象，我们可以将节点（nodes）和关系（relationships）整合到一个名为 **KnowledgeGraph** 的单一类中。
```

```python
class KnowledgeGraph(BaseModel):
    """Generate a knowledge graph with entities and relationships."""
    nodes: List[Node] = Field(
        ..., description="List of nodes in the knowledge graph")
    rels: List[Relationship] = Field(
        ..., description="List of relationships in the knowledge graph"
    )
```

```python
class KnowledgeGraph(BaseModel):
    """生成一个包含实体与关系的知识图谱。"""
    nodes: List[Node] = Field(
        ..., description="知识图谱中的节点列表")
    rels: List[Relationship] = Field(
        ..., description="知识图谱中的关系列表"
    )
```

The only thing left is to do a bit of prompt engineering and we are good to go. How I usually go about prompt engineering is the following:

剩下的工作就是进行一些提示词工程（prompt engineering），之后便可正式启用。

我通常采用如下方式开展提示词工程：

- 迭代优化提示词，通过自然语言不断改进输出效果；  
- 若某部分未能按预期工作，可请 ChatGPT 将任务描述改写得更清晰，以便大语言模型（LLM）准确理解；  
- 最后，当提示词已完整涵盖所有必要指令时，请 ChatGPT 将全部指令以 Markdown 格式进行总结——此举既可节省 token 消耗，也可能使指令更清晰明确。

I specifically chose the markdown format as I have seen somewhere that OpenAI models respond better to markdown syntax in prompts, and it seems to be at least plausible from my experience.

我特意选用 Markdown 格式，是因为曾看到相关说法：OpenAI 模型在提示词中遇到 Markdown 语法时响应效果更佳；而根据我的实际经验，这一说法至少是可信的。

Iterating over prompt engineering, I came up with the following system prompt for an information extraction pipeline.

经过多轮提示词工程迭代，我为信息抽取流水线设计了如下系统提示（system prompt）：

```python
llm = ChatOpenAI(model="gpt-3.5-turbo-16k", temperature=0)

def get_extraction_chain(
    allowed_nodes: Optional[List[str]] = None,
    allowed_rels: Optional[List[str]] = None
    ):
    prompt = ChatPromptTemplate.from_messages(
    [(\
      "system",\
      f"""# Knowledge Graph Instructions for GPT-4\
## 1. Overview\
You are a top-tier algorithm designed for extracting information in structured formats to build a knowledge graph.\
- **Nodes** represent entities and concepts. They're akin to Wikipedia nodes.\
- The aim is to achieve simplicity and clarity in the knowledge graph, making it accessible for a vast audience.\
## 2. Labeling Nodes\
- **Consistency**: Ensure you use basic or elementary types for node labels.\
  - For example, when you identify an entity representing a person, always label it as **"person"**. Avoid using more specific terms like "mathematician" or "scientist".\
- **Node IDs**: Never utilize integers as node IDs. Node IDs should be names or human-readable identifiers found in the text.\
{'- **Allowed Node Labels:**' + ", ".join(allowed_nodes) if allowed_nodes else ""}\
{'- **Allowed Relationship Types**:' + ", ".join(allowed_rels) if allowed_rels else ""}\
## 3. Handling Numerical Data and Dates\
- Numerical data, like age or other related information, should be incorporated as attributes or properties of the respective nodes.\
- **No Separate Nodes for Dates/Numbers**: Do not create separate nodes for dates or numerical values. Always attach them as attributes or properties of nodes.\
- **Property Format**: Properties must be in a key-value format.\
- **Quotation Marks**: Never use escaped single or double quotes within property values.\
- **Naming Convention**: Use camelCase for property keys, e.g., `birthDate`.\
## 4. Coreference Resolution\
- **Maintain Entity Consistency**: When extracting entities, it's vital to ensure consistency.\
If an entity, such as "John Doe", is mentioned multiple times in the text but is referred to by different names or pronouns (e.g., "Joe", "he"),\
always use the most complete identifier for that entity throughout the knowledge graph. In this example, use "John Doe" as the entity ID.\
Remember, the knowledge graph should be coherent and easily understandable, so maintaining consistency in entity references is crucial.\
## 5. Strict Compliance\
Adhere to the rules strictly. Non-compliance will result in termination."""),\
        ("human", "Use the given format to extract information from the following input: {input}"),\
        ("human", "Tip: Make sure to answer in the correct format"),\
    ])
    return create_structured_output_chain(KnowledgeGraph, llm, prompt, verbose=False)
```

```python
llm = ChatOpenAI(model="gpt-3.5-turbo-16k", temperature=0)

def get_extraction_chain(
    allowed_nodes: Optional[List[str]] = None,
    allowed_rels: Optional[List[str]] = None
    ):
    prompt = ChatPromptTemplate.from_messages(
    [(\
      "system",\
      f"""# GPT-4 知识图谱构建指令\
## 1. 概述\
你是一个顶级算法，专为以结构化格式抽取信息、构建知识图谱而设计。\
- **节点（Nodes）** 表示实体与概念，类似于维基百科中的词条节点。\
- 目标是确保知识图谱简洁明了，便于广大用户理解与使用。\
## 2. 节点标注规范\
- **一致性原则**：节点标签应始终使用基础或通用类型。\
  - 例如，识别出代表“人”的实体时，一律标注为 **"person"**；避免使用“数学家”“科学家”等更具体的术语。\
- **节点 ID 规范**：严禁使用整数作为节点 ID；ID 必须是文本中出现的名称或人类可读的标识符。\
{'- **允许的节点类型：**' + ", ".join(allowed_nodes) if allowed_nodes else ""}\
{'- **允许的关系类型：**' + ", ".join(allowed_rels) if allowed_rels else ""}\
## 3. 数值与日期数据处理\
- 年龄等数值型信息，应作为对应节点的属性（attribute）或性质（property）嵌入，而非独立节点。\
- **禁止为日期/数字创建独立节点**：切勿将日期或数值单独建模为节点；必须将其作为节点的属性或性质附加。\
- **属性格式**：属性必须采用键值对（key-value）形式。\
- **引号使用**：属性值中禁止使用转义的单引号或双引号。\
- **命名规范**：属性键（key）须采用驼峰命名法（camelCase），例如 `birthDate`。\
## 4. 共指消解（Coreference Resolution）\
- **实体一致性维护**：抽取实体时，务必确保指代一致。\
例如，若文本中多次提及同一实体（如 "John Doe"），但使用了不同称谓或代词（如 "Joe"、"he"），\
则在整个知识图谱中，始终应以该实体最完整、最明确的标识符（本例中为 "John Doe"）作为其唯一 ID。\
请牢记：知识图谱需具备逻辑连贯性与易理解性，因此实体指代的一致性至关重要。\
## 5. 严格合规要求\
必须严格遵守上述全部规则。任何违规行为都将导致流程终止。"""),\
        ("human", "请严格依照指定格式，从以下输入中抽取信息：{input}"),\
        ("human", "提示：请确保答案符合正确格式要求"),\
    ])
    return create_structured_output_chain(KnowledgeGraph, llm, prompt, verbose=False)
```

You can see that we are using the 16k version of the GPT-3.5 model. The main reason is that the OpenAI function output is a structured JSON object, and structured JSON syntax adds a lot of token overhead to the result. Essentially, you are paying for the convenience of structured output in increased token space.

你可以看到，我们选用的是 GPT-3.5 的 16k 上下文版本。主要原因在于：OpenAI 的函数调用（function calling）输出为结构化 JSON 对象，而 JSON 语法本身会带来显著的 token 开销。本质上，你是在为结构化输出的便利性，额外支付 token 成本。

Besides the general instructions, I have also added the option to limit which node or relationship types should be extracted from text. You’ll see through examples why this might come in handy.

除通用指令外，我还增加了限制可抽取节点类型与关系类型的选项。后续示例将说明这一功能为何十分实用。

We have the Neo4j connection and LLM prompt ready, which means we can define the information extraction pipeline as a single function.

Neo4j 连接与大语言模型提示词均已就绪，这意味着我们可以将整条信息抽取流水线封装为一个单一函数。

```python
def extract_and_store_graph(
    document: Document,
    nodes:Optional[List[str]] = None,
    rels:Optional[List[str]]=None) -> None:
    # Extract graph data using OpenAI functions
    extract_chain = get_extraction_chain(nodes, rels)
    data = extract_chain.run(document.page_content)
    # Construct a graph document
    graph_document = GraphDocument(
      nodes = [map_to_base_node(node) for node in data.nodes],
      relationships = [map_to_base_relationship(rel) for rel in data.rels],
      source = document
    )
    # Store information into a graph
    graph.add_graph_documents([graph_document])
```

该函数接收一个 LangChain `Document` 对象，以及可选的 `nodes`（节点）和 `rels`（关系）参数，用于限制大语言模型（LLM）需识别与提取的对象类型。大约一个月前，我们在 Neo4j 图对象中新增了 `add_graph_documents` 方法，此处即可直接调用，以无缝导入图结构数据。

## Evaluation  
## 评估

我们将从“Walt Disney”维基百科页面中提取信息，并构建知识图谱，以测试整条处理流程。此处将使用 LangChain 提供的 Wikipedia 加载器（`WikipediaLoader`）和文本分块（text chunking）模块。

```python
from langchain.document_loaders import WikipediaLoader
from langchain.text_splitter import TokenTextSplitter

# Read the wikipedia article
raw_documents = WikipediaLoader(query="Walt Disney").load()
# Define chunking strategy
text_splitter = TokenTextSplitter(chunk_size=2048, chunk_overlap=24)

# Only take the first the raw_documents
documents = text_splitter.split_documents(raw_documents[:3])
```

你可能已经注意到，我们设置了相对较大的 `chunk_size` 值。其原因在于：我们希望为单个句子提供尽可能丰富的上下文，从而让共指消解（coreference resolution）环节发挥最佳效果。请记住，共指消解仅在实体及其指代表达（如代词或别名）同时出现在同一文本块中时才有效；否则，大语言模型缺乏足够信息来建立二者之间的关联。

接下来，我们可以将文档送入信息抽取流水线，正式运行处理流程。

```python
from tqdm import tqdm
```

```python
for i, d in tqdm(enumerate(documents), total=len(documents)):
    extract_and_store_graph(d)
```

```python
for i, d in tqdm(enumerate(documents), total=len(documents)):
    extract_and_store_graph(d)
```

该过程耗时约 5 分钟，速度相对较慢。因此，在生产环境中，你很可能需要采用并行 API 调用以解决此问题，并实现一定程度的可扩展性。

我们先来看一下大语言模型（LLM）所识别出的节点类型和关系类型。

![](images/constructing-knowledge-graphs-from-text-using-openai-functions-leveraging-knowle/img_003.png)

由于图谱模式（graph schema）并未预先提供，LLM 需在运行时动态决定将使用哪些节点标签（node labels）和关系类型（relationship types）。例如，我们可以观察到存在 **Company** 和 **Organization** 两类节点标签——这两者在语义上很可能高度相似甚至完全等价，因此我们更希望仅用一个统一的节点标签来表示它们。这一问题在关系类型中表现得更为明显：例如，我们同时存在 **CO-FOUNDER** 和 **COFOUNDEROF** 关系，以及 **DEVELOPER** 和 **DEVELOPEDBY** 关系。

对于任何更严肃的项目，你都应明确定义 LLM 应当提取的节点标签与关系类型。幸运的是，我们已在提示词（prompt）中增加了限制类型的选项，可通过传入额外参数来实现。

```
# 指定 LLM 应提取的节点标签
allowed_nodes = ["Person", "Company", "Location", "Event", "Movie", "Service", "Award"]

for i, d in tqdm(enumerate(documents), total=len(documents)):
    extract_and_store_graph(d, allowed_nodes)
```

```
# 指定 LLM 应提取的节点标签
allowed_nodes = ["Person", "Company", "Location", "Event", "Movie", "Service", "Award"]

for i, d in tqdm(enumerate(documents), total=len(documents)):
    extract_and_store_graph(d, allowed_nodes)
```

本例中，我仅限制了节点标签；但你同样可以轻松地通过向 `extract_and_store_graph` 函数传入另一个参数，来限制关系类型。

所提取子图（subgraph）的可视化结果具有如下结构。

![](images/constructing-knowledge-graphs-from-text-using-openai-functions-leveraging-knowle/img_004.png)

The graph turned out better than expected (after five iterations :) ). I couldn’t catch the whole graph nicely in the visualization, but you can explore it on your own in Neo4j Browser other tools.

该图的效果比预期更好（经过五次迭代后 :)）。我在可视化中未能完整呈现整张图，但你可以在 Neo4j Browser 或其他工具中自行探索。

## Entity disambiguation

## 实体消歧

One thing I should mention is that we partly skipped entity disambiguation part. We used a large chunk size and added a specific instruction for coreference resolution and entity disambiguation in the system prompt. However, since each chunk is processed separately, there is no way to ensure consistency of entities between different text chunks. For example, you could end up with two nodes representing the same person.

有一点需要说明：我们部分跳过了实体消歧环节。我们采用了较大的文本分块（chunk）尺寸，并在系统提示词（system prompt）中加入了针对共指消解（coreference resolution）和实体消歧的明确指令。然而，由于每个文本块是独立处理的，因此无法保证不同文本块之间实体表示的一致性。例如，最终可能生成两个分别代表同一人物的节点。

![](images/constructing-knowledge-graphs-from-text-using-openai-functions-leveraging-knowle/img_005.png)Multiple nodes representing the same entity.

![](images/constructing-knowledge-graphs-from-text-using-openai-functions-leveraging-knowle/img_005.png)同一实体对应多个节点。

In this example, Walt Disney and Walter Elias Disney refer to the same real-world person. The entity disambiguation problem is nothing new and there has been various solution proposed to solve it:

本例中，“Walt Disney”与“Walter Elias Disney”指向同一位现实世界中的人物。实体消歧问题早已存在，学界与工业界已提出多种解决方案：

- Using [entity linking](https://wikifier.org/about.html?ref=blog.langchain.com) or [entity disambiguation](https://github.com/SapienzaNLP/extend?ref=blog.langchain.com) NLP models  
- 使用 [实体链接（entity linking）](https://wikifier.org/about.html?ref=blog.langchain.com) 或 [实体消歧（entity disambiguation）](https://github.com/SapienzaNLP/extend?ref=blog.langchain.com) 等自然语言处理模型  
- Doing a [second pass through an LLM](https://medium.com/neo4j/creating-a-knowledge-graph-from-video-transcripts-with-gpt-4-52d7c7b9f32c?ref=blog.langchain.com) and asking it to perform entity disambiguation  
- 通过大语言模型（LLM）进行 [第二轮处理](https://medium.com/neo4j/creating-a-knowledge-graph-from-video-transcripts-with-gpt-4-52d7c7b9f32c?ref=blog.langchain.com)，并要求其执行实体消歧任务  
- [Graph-based approaches](https://neo4j.com/developer-blog/exploring-supervised-entity-resolution-in-neo4j/?ref=blog.langchain.com)  
- [基于图的方法（graph-based approaches）](https://neo4j.com/developer-blog/exploring-supervised-entity-resolution-in-neo4j/?ref=blog.langchain.com)

Which solution you should use depends on your domain and use case. However, have in mind that entity disambiguation step should not be overlooked as it can have a significant impact on the accuracy and effectiveness of your RAG applications.

具体采用哪种方案，取决于你的应用领域与实际用例。但请务必注意：实体消歧环节不容忽视，它会显著影响你所构建的 RAG（检索增强生成）应用的准确性与有效性。

## Rag Application

## RAG 应用

The last thing we will do is show you how you can browse information in a knowledge graph by constructing Cypher statements. Cypher is a structured query language used to work with graph databases, similar to how SQL is used for relational databases. LangChain has a [GraphCypherQAChain](https://medium.com/neo4j/langchain-cypher-search-tips-tricks-f7c9e9abca4d?ref=blog.langchain.com) that reads the schema of the graph and constructs appropriate Cypher statements based on the user input.

最后，我们将向你演示如何通过构造 Cypher 查询语句来浏览知识图谱中的信息。Cypher 是一种结构化查询语言，专用于图数据库，其作用类似于关系型数据库中的 SQL。LangChain 提供了 [GraphCypherQAChain](https://medium.com/neo4j/langchain-cypher-search-tips-tricks-f7c9e9abca4d?ref=blog.langchain.com)，它能自动读取图数据库的 Schema，并根据用户输入生成恰当的 Cypher 查询语句。

# Query the knowledge graph in a RAG application

# 在 RAG 应用中查询知识图谱

```python
from langchain.chains import GraphCypherQAChain

graph.refresh_schema()

cypher_chain = GraphCypherQAChain.from_llm(
    graph=graph,
    cypher_llm=ChatOpenAI(temperature=0, model="gpt-4"),
    qa_llm=ChatOpenAI(temperature=0, model="gpt-3.5-turbo"),
    validate_cypher=True, # Validate relationship directions
    verbose=True
)
cypher_chain.run("When was Walter Elias Disney born?")
```

_Result is the following_

_结果如下所示_

![](images/constructing-knowledge-graphs-from-text-using-openai-functions-leveraging-knowle/img_006.png)

## Summary

## 总结

Knowledge graphs are a great fit when you need a combination of structured and structured data to power your RAG applications. In this blog post, you have learned how to construct a knowledge graph in Neo4j on an arbitrary text using OpenAI functions. OpenAI functions provide the convenience of neatly structured outputs, making them an ideal fit for extracting structured information. To have a great experience constructing graphs with LLMs, make sure to define the graph schema as detailed as possible and make sure you add an entity disambiguation step after the extraction.

当您的 RAG 应用需要结构化与半结构化（原文误作“structured and structured”，应为“structured and semi-structured”）数据相结合时，知识图谱是一种非常理想的解决方案。在本文中，您已学习如何借助 OpenAI 函数，基于任意文本在 Neo4j 中构建知识图谱。OpenAI 函数能提供格式清晰、结构规整的输出，因此特别适合用于提取结构化信息。若希望借助大语言模型（LLM）高效构建图谱，请务必尽可能详尽地定义图谱 Schema，并在信息抽取完成后加入实体消歧（entity disambiguation）步骤。

If you are eager to learn more about building AI applications with graphs, join us at the [NODES, online, 24h conference](https://neo4j.registration.goldcast.io/events/6fb85147-ca27-4310-9dec-cb345c53bd6f?ref=blog.langchain.dev) organized by Neo4j on October 26th, 2023.

如果您希望进一步了解如何结合图技术构建 AI 应用，欢迎参加 Neo4j 于 2023 年 10 月 26 日举办的线上会议——[NODES 全天候大会（24 小时）](https://neo4j.registration.goldcast.io/events/6fb85147-ca27-4310-9dec-cb345c53bd6f?ref=blog.langchain.dev)。

The code is available on [GitHub](https://github.com/tomasonjo/blogs/blob/master/llm/openaifunction_constructing_graph.ipynb?ref=blog.langchain.com).

相关代码已在 [GitHub](https://github.com/tomasonjo/blogs/blob/master/llm/openaifunction_constructing_graph.ipynb?ref=blog.langchain.com) 上开源。