---
render_with_liquid: false
title: "Query Transformations"
source: "LangChain Blog"
url: "https://blog.langchain.com/query-transformations/"
date: "2023-10-24"
scraped_at: "2026-03-03T08:32:27.915212422+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

Naive RAG typically splits documents into chunks, embeds them, and retrieves chunks with high semantic similarity to a user question. But, this present a few problems: (1) document chunks may contain irrelevant content that degrades retrieval, (2) user questions may be poorly worded for retrieval, and (3) structured queries may need to be generated from the user question (e.g., for querying a vectorstore with metadata filtering or a SQL db).

朴素 RAG 通常将文档切分为块（chunks），对这些块进行嵌入（embedding），然后检索与用户问题语义相似度最高的若干文本块。但这种方法存在几个问题：（1）文档块中可能包含与问题无关的内容，从而降低检索质量；（2）用户提问的措辞可能不利于检索；（3）有时需从用户问题中生成结构化查询（例如，用于带元数据过滤的向量数据库查询，或 SQL 数据库查询）。

LangChain has many [advanced retrieval methods](https://python.langchain.com/docs/modules/data_connection/retrievers/?ref=blog.langchain.com) to help address these challenges. (1) **Multi representation indexing**: Create a document representation (like a summary) that is well-suited for retrieval (read about this using the Multi Vector Retriever in [a blog post](https://blog.langchain.com/semi-structured-multi-modal-rag/) from last week). (2) **Query transformation**: in this post, we'll review a few approaches to transform humans questions in order to improve retrieval. (3) **Query construction**: convert human question into a particular query syntax or language, which will be covered in a future post.

LangChain 提供了多种[高级检索方法](https://python.langchain.com/docs/modules/data_connection/retrievers/?ref=blog.langchain.com)，可帮助应对上述挑战：（1）**多表征索引（Multi-representation indexing）**：构建更适配检索的文档表征（例如摘要），详见上周发布的博客文章中关于 [Multi Vector Retriever](https://blog.langchain.com/semi-structured-multi-modal-rag/) 的介绍；（2）**查询变换（Query transformation）**：本文将介绍几种用于优化人类提问以提升检索效果的变换方法；（3）**查询构建（Query construction）**：将人类自然语言提问转换为特定查询语法或语言（例如 SQL 或向量数据库查询 DSL），该主题将在后续文章中详述。

If you think of a naive RAG pipeline, the general flow is that you take the users question and pass that directly to an embedding model. That embedding is then compared to documents stored in the vectorstore, and the top `k` most similar ones are returned.

若回顾朴素 RAG 流程，其典型执行路径是：直接将用户提问送入嵌入模型（embedding model）；该模型生成的嵌入向量再与向量数据库（vectorstore）中已存储的文档嵌入进行比对，最终返回最相似的前 `k` 个文档。

![](images/query-transformations/img_001.png)

Query transformation deals with transformations of the user's question before passing to the embedding model.

查询变换（Query transformation）指在将用户提问送入嵌入模型之前，对其所做的一系列变换处理。

💡

Although this is not a new phenomenon ([query expansion](https://www.searchenginejournal.com/what-is-google-query-expansion-cases-and-examples/7924/?ref=blog.langchain.com) has been used in search for years) what is new is the ability to use LLMs to do it.

💡

尽管这一思路并非全新（[查询扩展，query expansion](https://www.searchenginejournal.com/what-is-google-query-expansion-cases-and-examples/7924/?ref=blog.langchain.com) 已在搜索引擎领域应用多年），但真正的新颖之处在于：如今可借助大语言模型（LLM）自动完成此类任务。

Below are a few variations of papers and retrieval methods that take advantage of this. They are all using an LLM to generate a new (or multiple new) queries, and the main difference is the prompt they use to do that generation.

以下列举了几种利用该能力的代表性论文与检索方法变体。它们均依赖大语言模型生成一个（或多个）新查询，核心差异仅在于所采用的提示词（prompt）设计。

## Rewrite-Retrieve-Read

## 重写—检索—阅读（Rewrite-Retrieve-Read）

This paper uses an LLM to **rewrite** a user query, rather than using the raw user query to retrieve directly.

该论文提出使用大语言模型对用户原始提问进行**重写（rewrite）**，而非直接使用原始提问执行检索。

> Because the original query can not be always optimal to retrieve for the LLM, especially in the real world... we first prompt an LLM to rewrite the queries, then conduct retrieval-augmented reading.

> 由于原始查询并不总能为大语言模型（LLM）提供最优的检索效果，尤其是在真实世界场景中……我们首先调用一个大语言模型对查询进行重写，再执行检索增强式阅读。

![](images/query-transformations/img_002.png)

The prompt used is a relatively simple one (on the Hub [here](https://blog.langchain.com/query-transformations/smith.langchain.com/hub/langchain-ai/rewrite)):

所使用的提示词相对简单（可在 Hub 上查看：[此处](https://blog.langchain.com/query-transformations/smith.langchain.com/hub/langchain-ai/rewrite)）：

![](images/query-transformations/img_003.png)

Links:

链接：

- [Paper](https://arxiv.org/pdf/2305.14283.pdf?ref=blog.langchain.com)  
- [论文](https://arxiv.org/pdf/2305.14283.pdf?ref=blog.langchain.com)

- [LangChain Implementation](https://github.com/langchain-ai/langchain/blob/master/cookbook/rewrite.ipynb?ref=blog.langchain.com)  
- [LangChain 实现代码](https://github.com/langchain-ai/langchain/blob/master/cookbook/rewrite.ipynb?ref=blog.langchain.com)

## Step back prompting

## “后退一步”提示法（Step Back Prompting）

This paper uses an LLM to generate a "step back" question. This can be use with or without retrieval. With retrieval, both the "step back" question and the original question are used to do retrieval, and then both results are used to ground the language model response.

该论文利用大语言模型生成一个“后退一步”式的问题。该方法既可单独使用，也可与检索结合使用。在结合检索时，“后退一步”问题和原始问题均用于检索，随后将两次检索结果共同作为依据，支撑大语言模型生成最终回答。

![](images/query-transformations/img_004.png)

[Here](https://smith.langchain.com/hub/langchain-ai/stepback-answer?ref=blog.langchain.com) is the prompt used:  

所使用的提示词见[此处](https://smith.langchain.com/hub/langchain-ai/stepback-answer?ref=blog.langchain.com)：

![](images/query-transformations/img_005.png)

链接：

- [论文](https://arxiv.org/pdf/2310.06117.pdf?ref=blog.langchain.com)  
- [LangChain 实现代码](https://github.com/langchain-ai/langchain/blob/master/cookbook/stepback-qa.ipynb?ref=blog.langchain.com)

## 后续问题（Follow Up Questions）

查询变换（query transformation）最基础、最核心的应用场景，是在对话式链（conversational chains）中处理后续问题（follow-up questions）。在处理后续问题时，本质上存在三种策略：

1. **仅对后续问题本身进行嵌入（embed）**。这意味着：如果该后续问题依赖或指涉此前的对话上下文，那么这部分上下文信息将完全丢失。例如，我先问：“我在意大利可以做些什么？”，接着又问：“那里有什么类型的食物？”——如果仅对“那里有什么类型的食物？”这一句做嵌入，模型将无法获知“那里”究竟指代何处。

2. **对整段对话（或最近 `k` 条消息）进行嵌入**。这种做法的问题在于：若某条后续问题与此前对话完全无关，则嵌入结果可能召回大量毫不相关的文档，反而在生成阶段造成干扰。

3. **使用大语言模型（LLM）执行查询变换！**

在第三种方案中，我们将截至目前的完整对话历史（包括最新提出的后续问题）一并输入 LLM，并要求其生成一个独立、自包含的搜索关键词或查询语句。这正是我们在 [WebLangChain](https://blog.langchain.com/weblangchain/) 中所采用的方法，也是绝大多数基于聊天界面的检索应用（chat-based retrieval applications）普遍采用的策略。

随之而来的问题是：**应使用怎样的提示词（prompt），才能将整段对话准确转化为高质量的搜索查询？** 这正是提示工程（prompt engineering）需要重点发力之处。下方是我们为 WebLangChain 设计的 prompt（它将“查询生成”任务表述为“构造一个独立、自包含的问题”）。您可在 LangChain Hub 上查看该 prompt 的完整版本：[点击此处](https://smith.langchain.com/hub/langchain-ai/weblangchain-search-query?ref=blog.langchain.com)。

![](images/query-transformations/img_006.png)

## 多查询检索（Multi Query Retrieval）

In this strategy, an LLM is used to generate multiple search queries. These search queries can then be executed in parallel, and the retrieved results passed in altogether. This is really useful when a single question may rely on multiple sub questions.

在此策略中，大语言模型（LLM）被用于生成多个搜索查询。这些搜索查询可并行执行，然后将检索到的结果一并传入。当单个问题依赖于多个子问题时，该方法尤为有效。

For example consider the following question:

例如，请考虑以下问题：

> Who won a championship more recently, the Red Sox or the Patriots?

> 红袜队（Red Sox）和爱国者队（Patriots）中，哪支队伍最近一次夺得冠军的时间更近？

This really requires two sub-questions:

这实际上需要分解为两个子问题：

- "When was the last time the Red Sox won a championship?"
- “红袜队上一次夺得冠军是什么时候？”

- "When was the last time the Patriots won a championship?"
- “爱国者队上一次夺得冠军是什么时候？”

Links:

相关链接：

- [LangChain Implementation](https://python.langchain.com/docs/modules/data_connection/retrievers/MultiQueryRetriever?ref=blog.langchain.com)

- [LangChain 实现方案](https://python.langchain.com/docs/modules/data_connection/retrievers/MultiQueryRetriever?ref=blog.langchain.com)

## RAG-Fusion

## RAG-Fusion

A recent article builds off the idea of Multi-Query Retrieval. However, rather than passing in all the documents, they use reciprocal rank fusion to reorder the documents.

一篇近期发表的文章在“多查询检索”（Multi-Query Retrieval）理念基础上进行了拓展。但与直接传入全部文档不同，该方法采用**互惠秩融合**（Reciprocal Rank Fusion, RRF）对检索出的文档进行重新排序。

![](images/query-transformations/img_007.webp)

Links:

链接：

- [Blog Post](https://towardsdatascience.com/forget-rag-the-future-is-rag-fusion-1147298d8ad1?ref=blog.langchain.com)  
- [博客文章](https://towardsdatascience.com/forget-rag-the-future-is-rag-fusion-1147298d8ad1?ref=blog.langchain.com)

- [LangChain Implementation](https://github.com/langchain-ai/langchain/blob/master/cookbook/rag_fusion.ipynb?ref=blog.langchain.com)  
- [LangChain 实现代码](https://github.com/langchain-ai/langchain/blob/master/cookbook/rag_fusion.ipynb?ref=blog.langchain.com)

## Conclusion

## 结论

As you can see, there are many different ways to do query transformation. Again, this is not a new topic - but what is new is using LLMs to do this. The differences in the methods comes down to the prompts used. It's very easy to write prompts - almost as easy as it to think of them. Which begs the question - what query transformations are YOU going to come up with? Let us know!

如您所见，查询变换（query transformation）有多种不同的实现方式。这本身并非一个新话题——真正的新颖之处在于利用大语言模型（LLM）来完成这一任务。不同方法之间的差异，归根结底在于所使用的提示词（prompts）。编写提示词非常简单——几乎与构思它们一样轻松。这也引出了一个问题：**您将设计出哪些查询变换方案？** 欢迎告诉我们！