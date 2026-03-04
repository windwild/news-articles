---
render_with_liquid: false
title: "Deconstructing RAG"
source: "LangChain Blog"
url: "https://blog.langchain.com/deconstructing-rag/"
date: "2023-11-30"
scraped_at: "2026-03-03T08:22:46.430861971+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

### Context

### 上下文

In a [recent overview](https://www.youtube.com/watch?v=zjkBMFhNj_g&ref=blog.langchain.com) on the state of large language models (LLMs), [Karpathy](https://x.com/karpathy/status/1727731541781152035?s=20&ref=blog.langchain.com) described LLMs as the kernel process of a new kind of operating system. Just as modern computers have RAM and access to files, LLMs have a context window that can be loaded with information retrieved from numerous data sources.

在近期关于大语言模型（LLM）发展现状的一期[综述视频](https://www.youtube.com/watch?v=zjkBMFhNj_g&ref=blog.langchain.com)中，[Karpathy](https://x.com/karpathy/status/1727731541781152035?s=20&ref=blog.langchain.com)将 LLM 比喻为一种新型操作系统的内核进程。正如现代计算机拥有内存（RAM）并可访问文件系统，LLM 也具备一个上下文窗口（context window），该窗口可加载从多种数据源检索而来的信息。

![](images/deconstructing-rag/img_001.jpg)Retrieval is a core component of the new LLM operating system

![](images/deconstructing-rag/img_001.jpg)检索是新型 LLM 操作系统的核心组件

This retrieved information is loaded into the context window and used in LLM output generation, a process typically called retrieval augmented generation (RAG). RAG is one of the most important concepts in LLM app development because it is an easy way to pass external information to an LLM with advantages over more complex / complex fine-tuning on problems that [require](https://www.youtube.com/watch?v=hhiLw5Q_UFg&ref=blog.langchain.com) [factual](https://github.com/openai/openai-cookbook/blob/main/examples/Question_answering_using_embeddings.ipynb?ref=blog.langchain.dev) [recall](https://www.anyscale.com/blog/fine-tuning-is-for-form-not-facts?ref=blog.langchain.dev).

这些被检索出的信息被载入上下文窗口，并用于 LLM 的输出生成过程——这一过程通常被称为“检索增强生成”（Retrieval Augmented Generation, RAG）。RAG 是 LLM 应用开发中最重要的概念之一，因为它提供了一种简便方式，将外部信息传递给 LLM；相较于针对需[事实性回忆](https://www.youtube.com/watch?v=hhiLw5Q_UFg&ref=blog.langchain.com)能力的问题所采用的更复杂、成本更高的微调（fine-tuning）方法，RAG 具有显著优势——例如在[事实召回](https://github.com/openai/openai-cookbook/blob/main/examples/Question_answering_using_embeddings.ipynb?ref=blog.langchain.dev)和[形式适配而非事实修正](https://www.anyscale.com/blog/fine-tuning-is-for-form-not-facts?ref=blog.langchain.dev)等场景中。

Typically, RAG systems involve: a question (often from a user) that determines what information to retrieve, a process of retrieving that information from a data source (or sources), and a process of passing the retrieved information directly to the LLM as part of the prompt (see an example prompt in LangChain hub [here](https://smith.langchain.com/hub/rlm/rag-prompt?ref=blog.langchain.com)).

典型的 RAG 系统包含三个环节：一个（通常来自用户的）问题，用于确定需要检索哪些信息；一个从数据源（或多个数据源）中检索相关信息的过程；以及一个将检索结果直接作为提示词（prompt）的一部分传入 LLM 的过程（参见 LangChain Hub 中的一个示例 prompt：[此处](https://smith.langchain.com/hub/rlm/rag-prompt?ref=blog.langchain.com)）。

## Challenge

## 挑战

The landscape of RAG methods has expanded greatly in recent months, resulting in some degree of overload or confusion among users about where to start and how to think about the various approaches. Over the past few months, we have worked to group RAG concepts into a few categories and have released guides for each. Below we'll provide a round-up of these concepts and present some future work.

近几个月来，RAG 方法体系迅速扩展，导致用户在“从何处入手”及“如何理解各类方法”方面面临一定程度的信息过载与困惑。过去数月间，我们致力于将 RAG 相关概念归纳为若干类别，并已为每一类发布配套指南。下文将系统梳理这些核心概念，并介绍后续工作规划。

![](images/deconstructing-rag/img_002.jpg)Major RAG themes

![](images/deconstructing-rag/img_002.jpg)RAG 的主要主题

* * *

## Query Transformations

## 查询变换

A first question to ask when thinking about RAG: _how can we make retrieval robust to variability in user input?_  
思考 RAG 时首先要提出的问题是：_我们如何让检索对用户输入的多样性具备鲁棒性？_

For example, user questions may be poorly worded for the challenging task of retrieval. Query transformations are a set of approaches focused on modifying the user input in order to improve retrieval.  
例如，用户提问可能措辞不当，难以应对检索这一具有挑战性的任务。查询变换（Query transformations）是一系列旨在修改用户输入以提升检索效果的方法。

### **Query expansion**  
### **查询扩展**

Consider the question _"Who won a championship more recently, the Red Sox or the Patriots?"_ Answering this can benefit from asking two specific sub-questions:  
考虑这个问题：“红袜队和爱国者队，哪支队伍最近赢得了冠军？” 回答该问题可受益于提出两个具体的子问题：

- _"When was the last time the Red Sox won a championship?"_  
- _“红袜队上一次赢得冠军是什么时候？”_

- _"When was the last time the Patriots won a championship?"_  
- _“爱国者队上一次赢得冠军是什么时候？”_

Query expansion decomposes the input into sub-questions, each of which is a more narrow retrieval challenge. The [multi-query retriever](https://python.langchain.com/docs/modules/data_connection/retrievers/MultiQueryRetriever?ref=blog.langchain.dev) performs sub-question generation, retrieval, and returns the unique union of the retrieved docs. [RAG fusion](https://github.com/langchain-ai/langchain/blob/master/cookbook/rag_fusion.ipynb?ref=blog.langchain.dev) builds on by ranking of the returned docs from each of the sub-questions. [Step-back prompting](https://github.com/langchain-ai/langchain/blob/master/cookbook/stepback-qa.ipynb?ref=blog.langchain.dev) offers a third approach in this vein, generating a step-back question to ground an answer synthesis in higher-level concepts or principles (see [paper](https://arxiv.org/pdf/2310.06117.pdf?ref=blog.langchain.dev)). For example, a question about physics can be stepped-back into a question (and LLM-generated answer) about the physical principles behind the user query.  
查询扩展将原始输入分解为多个子问题，每个子问题都构成一个范围更窄、更具针对性的检索任务。[多查询检索器（multi-query retriever）](https://python.langchain.com/docs/modules/data_connection/retrievers/MultiQueryRetriever?ref=blog.langchain.dev) 负责生成子问题、执行检索，并返回所有检索结果文档的去重并集。[RAG Fusion](https://github.com/langchain-ai/langchain/blob/master/cookbook/rag_fusion.ipynb?ref=blog.langchain.dev) 在此基础上进一步对各子问题所返回的文档进行排序整合。[回溯式提示（Step-back prompting）](https://github.com/langchain-ai/langchain/blob/master/cookbook/stepback-qa.ipynb?ref=blog.langchain.dev) 则提供了第三种思路：生成一个更高层次的“回溯问题”，使答案合成能扎根于更宏观的概念或原理（参见 [论文](https://arxiv.org/pdf/2310.06117.pdf?ref=blog.langchain.dev)）。例如，一个关于物理学的具体问题，可被回溯为一个探讨其背后物理原理的问题（以及由大语言模型生成的相应解答）。

### **Query re-writing**  
### **查询重写**

To address poorly framed or worded user inputs, Rewrite-Retrieve-Read (see [paper](https://arxiv.org/pdf/2305.14283.pdf?ref=blog.langchain.dev)) is an approach [re-writes user questions](https://github.com/langchain-ai/langchain/blob/master/cookbook/rewrite.ipynb?ref=blog.langchain.dev) in order to improve retrieval.  
为应对表述不清或结构欠佳的用户输入，“重写—检索—阅读”（Rewrite-Retrieve-Read，参见 [论文](https://arxiv.org/pdf/2305.14283.pdf?ref=blog.langchain.dev)）是一种通过[重写用户问题](https://github.com/langchain-ai/langchain/blob/master/cookbook/rewrite.ipynb?ref=blog.langchain.dev)来提升检索效果的方法。

### **Query compression**  
### **查询压缩**

In some RAG applications, such as [WebLang](https://blog.langchain.com/weblangchain/) (our open source research assistant), a user question follows a broader chat conversation. In order to properly answer the question, the full conversational context may be required. To address this, we use [this prompt](https://smith.langchain.com/hub/langchain-ai/weblangchain-search-query?ref=blog.langchain.dev&organizationId=1fa8b1f4-fcb9-4072-9aa9-983e35ad61b8) to compress chat history into a final question for retrieval.  
在某些 RAG 应用中——例如 [WebLang](https://blog.langchain.com/weblangchain/)（我们开源的研究助手）——用户提问往往出现在一段更长的对话上下文之后。为准确回答该问题，可能需要完整利用整个对话历史。为此，我们采用 [此提示模板](https://smith.langchain.com/hub/langchain-ai/weblangchain-search-query?ref=blog.langchain.dev&organizationId=1fa8b1f4-fcb9-4072-9aa9-983e35ad61b8)，将聊天历史压缩为一个最终用于检索的精炼问题。

### **Further reading**  
### **延伸阅读**

- See our blog post on [query transformations](https://blog.langchain.com/query-transformations/)  
- 查看我们关于[查询变换（query transformations）](https://blog.langchain.com/query-transformations/)的博客文章  

- See our blog post on OpenAI's [RAG strategies](https://blog.langchain.com/applying-openai-rag/)  
- 查看我们关于 OpenAI [RAG 策略](https://blog.langchain.com/applying-openai-rag/)的博客文章  

* * *

## Routing  

## 路由（Routing）

A second question to ask when thinking about RAG: _where does the data live?_  
思考 RAG 时需提出的第二个问题是：_数据存放在哪里？_

In many RAG demos, data lives in a single vectorstore but this is often not the case in production settings.  
在许多 RAG 演示中，数据仅存于单一向量数据库（vectorstore），但在实际生产环境中，情况往往并非如此。

When operating across a set of various datastores, incoming queries need to be routed.  
当系统需跨多种数据存储（datastore）运行时，传入的查询必须被合理路由。

LLMs can be used to support dynamic query routing effectively (see [here](https://python.langchain.com/docs/expression_language/how_to/routing?ref=blog.langchain.dev)), as discussed in our recent review of OpenAI's [RAG strategies](https://blog.langchain.com/applying-openai-rag/).  
大语言模型（LLM）可高效支持动态查询路由（参见[此处](https://python.langchain.com/docs/expression_language/how_to/routing?ref=blog.langchain.dev)），这一点已在我们近期对 OpenAI [RAG 策略](https://blog.langchain.com/applying-openai-rag/)的综述中详细探讨。

* * *

## Query Construction  

## 查询构建（Query Construction）

A third question to ask when thinking about RAG: _what syntax is needed to query the data?_  
思考 RAG 时需提出的第三个问题是：_查询数据所需的语法是什么？_

While routed questions are in natural language, data is stored in sources such as relational or graph databases that require specific syntax to retrieve.  
尽管经路由后的查询以自然语言表达，但数据通常存储在关系型数据库或图数据库等数据源中，这些系统需要特定语法才能检索数据。

And even vectorstores utilize structured metadata for filtering.  
即使是向量数据库（vectorstore），也依赖结构化元数据（structured metadata）实现过滤。

In all cases, natural language from the query needs to be converted into a query syntax for retrieval.  
在所有这些场景中，查询中的自然语言都必须转换为适配目标数据源的查询语法，方可完成检索。

![](images/deconstructing-rag/img_003.jpg)

### **Text-to-SQL**  

### **文本到 SQL（Text-to-SQL）**

Considerable effort has focused on translating natural language into SQL requests.  
大量研究工作聚焦于将自然语言翻译为 SQL 查询请求。

Text-to-SQL can be done easily ( [here](https://python.langchain.com/docs/expression_language/cookbook/sql_db?ref=blog.langchain.com)) by providing an LLM the natural language question along with relevant table information;  
通过向大语言模型（LLM）提供自然语言问题及相关的表结构信息，即可轻松实现文本到 SQL 的转换（参见[此处](https://python.langchain.com/docs/expression_language/cookbook/sql_db?ref=blog.langchain.com)）；

open source LLMs have proven effective at this task, enabling data privacy (see our templates [here](https://github.com/langchain-ai/langchain/tree/master/templates/sql-ollama?ref=blog.langchain.com) and [here](https://github.com/langchain-ai/langchain/tree/master/templates/sql-llama2?ref=blog.langchain.com)).  
开源大语言模型在此任务上已展现出优异效果，有助于保障数据隐私（参见我们的模板：[此处](https://github.com/langchain-ai/langchain/tree/master/templates/sql-ollama?ref=blog.langchain.com) 和 [此处](https://github.com/langchain-ai/langchain/tree/master/templates/sql-llama2?ref=blog.langchain.com)）。

Mixed type (structured and unstructured) data storage in relational databases is increasingly common (see [here](https://www.youtube.com/watch?v=MDxEXKkxf2Q&ref=blog.langchain.dev)); an embedded document column can be included using the [open-source](https://github.com/pgvector/pgvector?ref=blog.langchain.dev) pgvector extension for PostgreSQL. It's also possible to interact with this semi-structured data using natural language, marrying the expressiveness of SQL with semantic search (see our [cookbook](https://github.com/langchain-ai/langchain/blob/master/cookbook/retrieval_in_sql.ipynb?ref=blog.langchain.dev) and [template](https://github.com/langchain-ai/langchain/tree/master/templates/sql-pgvector?ref=blog.langchain.dev)).

关系型数据库中混合存储结构化与非结构化数据正变得日益普遍（参见[此处](https://www.youtube.com/watch?v=MDxEXKkxf2Q&ref=blog.langchain.dev)）；借助开源的 [pgvector 扩展](https://github.com/pgvector/pgvector?ref=blog.langchain.dev)，可在 PostgreSQL 中添加嵌入式文档列。此外，还可通过自然语言与这类半结构化数据进行交互，将 SQL 的表达能力与语义搜索相结合（参见我们的 [示例手册（cookbook）](https://github.com/langchain-ai/langchain/blob/master/cookbook/retrieval_in_sql.ipynb?ref=blog.langchain.dev) 和 [模板](https://github.com/langchain-ai/langchain/tree/master/templates/sql-pgvector?ref=blog.langchain.dev)）。

### **Text-to-Cypher**

### **文本转 Cypher（Text-to-Cypher）**

While vector stores readily handle unstructured data, they don't understand the relationships between vectors. While SQL databases can model relationships, schema changes can be disruptive and costly. Knowledge graphs can address these challenges by modeling the relationships between data and extending the types of relationships without a major overhaul. They are desirable for data that has many-to-many relationships or hierarchies that are difficult to represent in tabular form.

尽管向量数据库能轻松处理非结构化数据，却无法理解向量之间的关联关系；而 SQL 数据库虽可建模数据间的关系，但模式（schema）变更往往带来较大干扰且成本高昂。知识图谱则可通过建模数据间的关联关系、并在无需大规模重构的前提下扩展关系类型，来应对上述挑战。对于存在多对多关系或难以用表格形式表达的层级结构的数据而言，知识图谱尤为适用。

Like relational databases, graph databases benefit from a natural language interface using text-to-Cypher, a structured query language [designed to provide a visual way of matching patterns and relationships](https://blog.langchain.com/using-a-knowledge-graph-to-implement-a-devops-rag-application/) (see templates [here](https://github.com/langchain-ai/langchain/tree/master/templates/neo4j-cypher?ref=blog.langchain.com) and [here](https://github.com/langchain-ai/langchain/tree/master/templates/neo4j-advanced-rag?ref=blog.langchain.com)).

与关系型数据库类似，图数据库也可借助“文本转 Cypher”（text-to-Cypher）这一自然语言接口获益——Cypher 是一种结构化查询语言，[专为以可视化方式匹配模式与关系而设计](https://blog.langchain.com/using-a-knowledge-graph-to-implement-a-devops-rag-application/)（参见模板：[此处](https://github.com/langchain-ai/langchain/tree/master/templates/neo4j-cypher?ref=blog.langchain.com) 和 [此处](https://github.com/langchain-ai/langchain/tree/master/templates/neo4j-advanced-rag?ref=blog.langchain.com)）。

### **Text-to-metadata filters**

### **文本转元数据过滤器（Text-to-metadata filters）**

Vectorstores equipped with [metadata filtering](https://docs.trychroma.com/usage-guide?ref=blog.langchain.dev#filtering-by-metadata) enable structured queries to filter embedded unstructured documents. The [self-query retriever](https://python.langchain.com/docs/modules/data_connection/retrievers/self_query/?ref=blog.langchain.dev#constructing-from-scratch-with-lcel) can translate natural language into these structured queries with metadata filters using a specification for the metadata fields present in the vectorstore (see our self-query [template](https://github.com/langchain-ai/langchain/tree/master/templates/rag-self-query?ref=blog.langchain.com)).

配备[元数据过滤功能](https://docs.trychroma.com/usage-guide?ref=blog.langchain.dev#filtering-by-metadata)的向量数据库，支持使用结构化查询对已嵌入的非结构化文档进行筛选。“自查询检索器”（self-query retriever）可根据向量数据库中所含元数据字段的规范说明，将自然语言自动转换为带元数据过滤条件的结构化查询（参见我们的自查询 [模板](https://github.com/langchain-ai/langchain/tree/master/templates/rag-self-query?ref=blog.langchain.com)）。

### **Further reading**

### **延伸阅读**

- See our blog post on [query construction](https://blog.langchain.com/query-construction/)

- 请参阅我们关于 [查询构建（query construction）](https://blog.langchain.com/query-construction/) 的博客文章。

* * *

## Indexing

## 索引（Indexing）

A fourth question to ask when thinking about RAG: _how to design my index?_  
思考 RAG 时需要提出的第四个问题是：_如何设计我的索引？_

For vectorstores, there is considerable opportunity to tune parameters like the chunk size and / or the document embedding strategy to support variable data types.  
对于向量数据库（vectorstores），我们有大量机会通过调整参数（例如分块大小（chunk size）和/或文档嵌入策略（document embedding strategy））来适配不同类型的数据。

### **Chunk size**  
### **分块大小**

In our review of OpenAI's [RAG strategies](https://blog.langchain.com/applying-openai-rag/), we highlight the notable boost in performance that they saw simply from experimenting with the chunk size during document embedding. This makes sense, because chunk size controls how much information we load into the context window (or "RAM" in our LLM OS analogy).  
在我们对 OpenAI [RAG 策略](https://blog.langchain.com/applying-openai-rag/) 的综述中，我们重点指出：仅通过在文档嵌入阶段尝试不同分块大小，OpenAI 就观察到了性能的显著提升。这不难理解，因为分块大小决定了我们向上下文窗口（即我们在类比 LLM 操作系统时所称的“内存”/RAM）中加载多少信息。

Since this is a central step in index building, we have an [open source](https://github.com/langchain-ai/text-split-explorer?ref=blog.langchain.dev) [Streamlit app](https://x.com/hwchase17/status/1689015952623771648?s=20&ref=blog.langchain.dev) where you can test various chunk sizes to gain some intuition; in particular, it's worth examining where the document is split using various split sizes or strategies and whether semantically related content is unnaturally split.  
由于这是构建索引的核心步骤之一，我们提供了一个开源的 [Streamlit 应用](https://github.com/langchain-ai/text-split-explorer?ref=blog.langchain.dev)，你可借此测试多种分块大小，从而建立直观认知；尤其值得关注的是：不同分块尺寸或分块策略下文档的具体切分位置，以及语义上紧密关联的内容是否被人为割裂。

### **Document embedding strategy**  
### **文档嵌入策略**

One of the simplest and most useful ideas in index design is to decouple what you embed (for retrieval) from what you pass to the LLM (for answer synthesis). For example, consider a large passage of text with lots of redundant detail. We can embed a few different representations of this to improve retrieval, such as a _summary_ or _small chunks to narrow the scope of information that is embedded_. In either case, we can then retrieve the _full text_ to pass to the LLM. These can be implemented using [multi-vector](https://blog.langchain.com/semi-structured-multi-modal-rag/) and [parent-document](https://python.langchain.com/docs/modules/data_connection/retrievers/parent_document_retriever?ref=blog.langchain.com) retriever, respectively.  
索引设计中最简单却也最实用的思想之一，是将“用于检索而嵌入的内容”与“用于答案生成而传给大语言模型（LLM）的内容”解耦。例如，考虑一段冗长且细节繁复的文本：我们可以为此文本嵌入若干种不同形式的表示，以提升检索效果——比如嵌入其 _摘要_，或嵌入 _更小的文本块_，从而缩小嵌入信息的覆盖范围。无论采用哪种方式，最终均可检索出该文本的 _完整原文_ 并传给 LLM 进行答案合成。这两种方法分别可通过 [多向量检索器（multi-vector retriever）](https://blog.langchain.com/semi-structured-multi-modal-rag/) 和 [父文档检索器（parent-document retriever）](https://python.langchain.com/docs/modules/data_connection/retrievers/parent_document_retriever?ref=blog.langchain.com) 实现。

The multi-vector retriever also works well for semi-structured documents that contain a mix of text and tables (see our [cookbook](https://github.com/langchain-ai/langchain/blob/master/cookbook/Semi_Structured_RAG.ipynb?ref=blog.langchain.dev) and [template](https://github.com/langchain-ai/langchain/tree/master/templates/rag-semi-structured?ref=blog.langchain.dev)). In these cases, it's possible to extract each table, produce a summary of the table that is well suited for retrieval, but return the raw table to the LLM for answer synthesis.  
多向量检索器同样适用于包含文本与表格混合内容的半结构化文档（参见我们的 [食谱（cookbook）](https://github.com/langchain-ai/langchain/blob/master/cookbook/Semi_Structured_RAG.ipynb?ref=blog.langchain.dev) 和 [模板（template）](https://github.com/langchain-ai/langchain/tree/master/templates/rag-semi-structured?ref=blog.langchain.dev)）。在此类场景中，我们可以逐个提取表格，为其生成适合检索的摘要，但在答案合成阶段，仍向 LLM 返回原始表格数据。

![MVR.png](images/deconstructing-rag/img_004.png)

We can take this one step further: with the advent of [multi-modal LLMs](https://openai.com/research/gpt-4v-system-card?ref=blog.langchain.com), it's possible to use generate and embed image summaries as one means of image retrieval for documents that contain text and images (see diagram below).  
我们还可更进一步：随着 [多模态大语言模型（multi-modal LLMs）](https://openai.com/research/gpt-4v-system-card?ref=blog.langchain.com) 的兴起，一种可行的图像检索方式是：为图文混合文档中的图像生成并嵌入其文本摘要（image summaries）（参见下方示意图）。

This may be appropriate for cases where multi-modal embeddings are not expected to reliably retrieve the images, as may be the case with complex figures or table. As an example, in our [cookbook](https://github.com/langchain-ai/langchain/blob/master/cookbook/Multi_modal_RAG.ipynb?ref=blog.langchain.com) we use this approach with figures from a financial analysis blog ( [@jaminball](https://twitter.com/jaminball?ref=blog.langchain.com)'s Clouded Judgement). However, we also have another [cookbook](https://github.com/langchain-ai/langchain/blob/master/cookbook/multi_modal_RAG_chroma.ipynb?ref=blog.langchain.com) using open source ( [OpenCLIP](https://github.com/mlfoundations/open_clip?ref=blog.langchain.com)) multi-modal embeddings for retrieval of images based on more straightforward visual concepts.  
当多模态嵌入难以稳定检索图像时（例如面对复杂图表或表格），这种基于图像摘要的方法尤为适用。例如，在我们的 [食谱（cookbook）](https://github.com/langchain-ai/langchain/blob/master/cookbook/Multi_modal_RAG.ipynb?ref=blog.langchain.com) 中，我们便将该方法应用于金融分析博客（[@jaminball](https://twitter.com/jaminball?ref=blog.langchain.com) 的 *Clouded Judgement*）中的图表。不过，我们也提供了另一份 [食谱（cookbook）](https://github.com/langchain-ai/langchain/blob/master/cookbook/multi_modal_RAG_chroma.ipynb?ref=blog.langchain.com)，其中使用开源的 [OpenCLIP](https://github.com/mlfoundations/open_clip?ref=blog.langchain.com) 多模态嵌入技术，针对更直观的视觉概念（如物体、颜色、布局等）进行图像检索。

![](images/deconstructing-rag/img_005.jpg)

### **Further reading**

### **延伸阅读**

- See our blog post on [multi-vector retriever](https://blog.langchain.com/semi-structured-multi-modal-rag/)

- 查阅我们关于 [多向量检索器（multi-vector retriever）](https://blog.langchain.com/semi-structured-multi-modal-rag/) 的博客文章。

* * *

## Post-Processing

## 后处理（Post-Processing）

A final question to ask when thinking about RAG: _how to combine the documents that I have retrieved?_ This is important, because the context window has limited size and redundant documents (e.g., from different sources) will utilize tokens without providing unique information to the LLM. A number of approaches for document post-processing (e.g., to improve diversity or filter for recency) have emerged, some of which we discuss in our blog post on OpenAI's [RAG strategies](https://blog.langchain.com/applying-openai-rag/).

在思考 RAG 时，最后一个关键问题是：_我所检索到的文档应如何组合？_ 这一点至关重要，因为大语言模型（LLM）的上下文窗口容量有限；而冗余文档（例如来自不同来源但内容高度重叠的文档）会占用宝贵的 token，却无法为 LLM 提供额外的独特信息。目前已有多种文档后处理方法涌现（例如提升结果多样性、按时效性过滤等），其中部分方法我们在关于 OpenAI [RAG 策略](https://blog.langchain.com/applying-openai-rag/) 的博客文章中进行了探讨。

### **Re-ranking**

### **重排序（Re-ranking）**

The [Cohere ReRank](https://python.langchain.com/docs/integrations/retrievers/cohere-reranker?ref=blog.langchain.dev) endpoint can be used for document compression (reduce redundancy) in cases where we are retrieving a large number of documents. Relatedly, RAG-fusion uses reciprocal rank fusion (see [blog](https://towardsdatascience.com/forget-rag-the-future-is-rag-fusion-1147298d8ad1?ref=blog.langchain.dev) and [implementation](https://github.com/langchain-ai/langchain/blob/master/cookbook/rag_fusion.ipynb?ref=blog.langchain.dev)) to ReRank documents returned from a retriever (similar to [multi-query](https://github.com/langchain-ai/langchain/blob/master/cookbook/rag_fusion.ipynb?ref=blog.langchain.dev)).

[Cohere 重排序（ReRank）](https://python.langchain.com/docs/integrations/retrievers/cohere-reranker?ref=blog.langchain.dev) 接口可用于文档压缩（即降低冗余度），尤其适用于需检索大量文档的场景。与此相关的是 RAG-Fusion 方法，它采用**倒数排名融合（reciprocal rank fusion）**（参见 [相关博客](https://towardsdatascience.com/forget-rag-the-future-is-rag-fusion-1147298d8ad1?ref=blog.langchain.dev) 和 [实现代码](https://github.com/langchain-ai/langchain/blob/master/cookbook/rag_fusion.ipynb?ref=blog.langchain.dev)），对检索器返回的文档进行重排序——其思路与 [多查询（multi-query）](https://github.com/langchain-ai/langchain/blob/master/cookbook/rag_fusion.ipynb?ref=blog.langchain.dev) 方法类似。

### **Classification**

### **分类（Classification）**

OpenAI classified each retrieved document based upon its content and then chose a different prompt depending on that classification. This marries [tagging](https://python.langchain.com/docs/modules/chains/how_to/openai_functions?ref=blog.langchain.dev) [of](https://github.com/langchain-ai/langchain/tree/master/templates/extraction-openai-functions?ref=blog.langchain.dev) [text](https://python.langchain.com/docs/modules/chains/how_to/openai_functions?ref=blog.langchain.dev) for classification with [logical routing](https://python.langchain.com/docs/expression_language/how_to/routing?ref=blog.langchain.dev) (in this case, for the prompt) based on a tag.

OpenAI 首先依据内容对每一份检索到的文档进行分类，再根据该分类结果选择不同的提示词（prompt）。这一做法将面向分类任务的 [文本标注（tagging）](https://python.langchain.com/docs/modules/chains/how_to/openai_functions?ref=blog.langchain.dev)（参见 [标注模板示例](https://github.com/langchain-ai/langchain/tree/master/templates/extraction-openai-functions?ref=blog.langchain.dev) 和 [文本标注教程](https://python.langchain.com/docs/modules/chains/how_to/openai_functions?ref=blog.langchain.dev)）与基于标签的 [逻辑路由（logical routing）](https://python.langchain.com/docs/expression_language/how_to/routing?ref=blog.langchain.dev)（本例中用于动态选择 prompt）有机结合起来。

* * *

## Future Plans

## 未来计划

Going forward, we will focus on at least two areas that extend these themes.

接下来，我们将至少聚焦于两个能够延展上述主题的方向。

### Open source

### 开源

Many of these tasks to improve RAG are narrow and well-defined. For example, query expansion (sub-question generation) or structured query construction for metadata filtering are narrow, well-defined tasks that also may be done repeatedly. In turn, they may not require large (and most costly) generalist models to achieve acceptable performance. Instead, smaller open source models (potentially with fine-tuning) may be sufficient. We will be releasing a series of templates that showcases how to use open source models into the RAG stack where appropriate.

许多用于提升 RAG 效果的任务范围较窄、定义明确。例如，查询扩展（子问题生成）或面向元数据过滤的结构化查询构建，均属于这类边界清晰、可重复执行的任务；因此，它们未必需要庞大（且成本最高）的通用大模型即可达到可接受的性能水平。相反，更轻量的开源模型（或经微调后的版本）可能已足够胜任。我们将陆续发布一系列模板，展示如何在 RAG 流水线中恰当地集成开源模型。

### Benchmarks

### 基准测试

Hand-in-hand with our effort to test open source LLMs, we recently launched [public datasets](https://blog.langchain.com/public-langsmith-benchmarks/) that can serve ground truth for evaluation. We will be expanding these to include some more specific RAG challenges and using them to assess the merits of the above approaches as well as the incorporation of open source LLMs.

在开展开源大语言模型（LLM）评测工作的同时，我们近期推出了 [公开数据集](https://blog.langchain.com/public-langsmith-benchmarks/)，为效果评估提供可靠的真实标注（ground truth）。后续，我们将进一步扩充这些数据集，纳入更具针对性的 RAG 挑战任务，并利用它们系统性地评估前述方法的有效性，以及开源 LLM 在 RAG 中的整合价值。