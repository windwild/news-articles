---
title: "Implementing advanced RAG strategies with Neo4j"
source: "LangChain Blog"
url: "https://blog.langchain.com/implementing-advanced-retrieval-rag-strategies-with-neo4j/"
date: "2024-12-19"
scraped_at: "2026-03-03T07:45:29.524137913+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

**Editor's note: We're excited to share this blogpost as it covers several of the advanced retrieval strategies we introduced in the past month, specifically a lot of the ones that rely on changing the ingestion step. A lot of these advanced retrieval strategies can be summarized as changing how indexing of documents is done to retain some concept of hierarchy. Neo4j is an exciting database to use for these tasks since it can represent these hierarchies as part of the graph. This also allows you to switch between indexing strategies pretty easily.**

**编者按：我们非常高兴分享这篇博客文章，因为它涵盖了过去一个月中我们介绍的多项高级检索策略，尤其是大量依赖于调整数据摄入（ingestion）环节的策略。这些高级检索策略大多可概括为：通过改变文档索引方式，以保留某种层级结构（hierarchy）的概念。Neo4j 是执行此类任务极具吸引力的数据库，因为它能将这些层级关系天然地表达为图结构的一部分。这也使得你在不同索引策略之间切换变得相当便捷。**

[**Tomaz**](https://twitter.com/tb_tomaz?ref=blog.langchain.com) **has implemented a single LangChain template that contains four different RAG strategies. Check it out here:**

[**Tomaz**](https://twitter.com/tb_tomaz?ref=blog.langchain.com) **已实现一个统一的 LangChain 模板，其中集成了四种不同的 RAG 策略。欢迎在此查看：**

- [**Neo4j Advanced RAG Template**](https://github.com/langchain-ai/langchain/tree/v0.2/templates/neo4j-advanced-rag?ref=blog.langchain.com)

- [**Neo4j 高级 RAG 模板**](https://github.com/langchain-ai/langchain/tree/v0.2/templates/neo4j-advanced-rag?ref=blog.langchain.com)

Retrieval-augmented generation applications seem to be the “Hello World” of AI applications. Nowadays, you can implement a “Chat with your PDF” application in only a couple of minutes due to the help of LLM framework libraries like LangChain.

检索增强生成（RAG）应用似乎已成为 AI 应用领域的“Hello World”。如今，在 LangChain 等大语言模型（LLM）框架库的支持下，你仅需几分钟即可构建一个“与 PDF 聊天”的应用。

“Chat with your PDF” applications typically rely on vector similarity search to retrieve relevant information, which are then fed to an LLM to generate a final answer that is returned to a user.

“与 PDF 聊天”类应用通常依赖向量相似性搜索（vector similarity search）来检索相关信息，再将这些信息输入大语言模型（LLM），由其生成最终答案并返回给用户。

![](images/implementing-advanced-rag-strategies-with-neo4j/img_001.jpg)Vector similarity search is used to retrieve relevant information.

![](images/implementing-advanced-rag-strategies-with-neo4j/img_001.jpg)向量相似性搜索用于检索相关信息。

Lately, it is becoming more and more obvious that naive vector similarity search might not be accurate enough for all use cases. For example, we have seen the introduction of [step-back approach to prompting](https://arxiv.org/abs/2310.06117?ref=blog.langchain.com), which emphasizes the importance of taking a step back from the immediate details of a task to focus on a higher-level abstraction.

近期越来越明显的是，朴素的向量相似性搜索可能无法满足所有应用场景对准确性的要求。例如，我们已看到 [“回退式提示”（step-back prompting）方法](https://arxiv.org/abs/2310.06117?ref=blog.langchain.com) 的提出，该方法强调：应暂时脱离任务的具体细节，转而聚焦于更高层次的抽象概念。

![](images/implementing-advanced-rag-strategies-with-neo4j/img_002.jpg)Step-back prompting. Image from [research paper](https://arxiv.org/abs/2310.06117?ref=blog.langchain.com) licensed under CC BY 4.0.

![](images/implementing-advanced-rag-strategies-with-neo4j/img_002.jpg)回退式提示（Step-back prompting）。图片源自 [相关研究论文](https://arxiv.org/abs/2310.06117?ref=blog.langchain.com)，依据 CC BY 4.0 许可协议授权。

The step-back prompting technique is based on the observation that directly addressing intricate tasks can lead to errors, especially when there are numerous specifics to consider. Instead of plunging straight into the complexities, the model first prompts itself to ask a more generic question that encapsulates the core essence of the original query. By focusing on this broader concept or principle, it can retrieve more relevant and comprehensive facts. Once armed with this foundational knowledge, the model can then proceed to reason and deduce the answer to the specific task at hand.

回退式提示技术基于如下观察：直接处理复杂任务容易出错，尤其当任务涉及大量具体细节时。与其一头扎进复杂性之中，模型首先会自我提示，提出一个更通用的问题——该问题需涵盖原始查询的核心本质。通过聚焦于这一更宽泛的概念或原理，模型便能检索到更相关、更全面的事实。在掌握这一基础性知识后，模型便可进一步推理，并推导出针对当前具体任务的答案。

On the other hand, we have also seen the introduction of so-called parent document retrievers, where the hypothesis is that directly using a document’s vector might not be efficient.

另一方面，我们也看到了所谓“父文档检索器”（parent document retriever）的引入；其基本假设是：直接使用文档本身的向量表示可能效率不高。

![](images/implementing-advanced-rag-strategies-with-neo4j/img_003.jpg)  
![](images/implementing-advanced-rag-strategies-with-neo4j/img_003.jpg)  
Types of parent document retrieval strategies. Image by [Damien Benveniste, PhD](https://www.linkedin.com/in/ACoAAAT2LbsB3xS0kxwoZu8TsNvAXS5jonOKqiw?ref=blog.langchain.com) from [AiEdge.io](https://newsletter.theaiedge.io/?ref=blog.langchain.com)  
父文档检索策略类型。图片由 [Damien Benveniste 博士](https://www.linkedin.com/in/ACoAAAT2LbsB3xS0kxwoZu8TsNvAXS5jonOKqiw?ref=blog.langchain.com) 提供，来源：[AiEdge.io](https://newsletter.theaiedge.io/?ref=blog.langchain.com)

Large documents can be split into smaller chunks, where the smaller chunks are converted to vectors, improving indexing for similarity searches. Although these smaller vectors better represent specific concepts, the original large document is retrieved as it provides better context for answering questions. Similarly, you can use an LLM to generate questions the document answers. The document is then indexed by these question embeddings, providing closer similarity with user questions. In both examples, the full parent document is retrieved to provide complete context for answers, hence the name “Parent Document Retriever”.  
大型文档可被切分为更小的文本块（chunks），这些小文本块被转换为向量，从而提升相似性搜索的索引效果。尽管这些较小的向量更能精准表征特定概念，但在实际检索中仍会返回原始的完整大文档——因其能为问题回答提供更丰富的上下文信息。类似地，你也可以利用大语言模型（LLM）自动生成该文档所能回答的问题，并以这些问题的嵌入向量对文档进行索引，从而使其与用户提问在语义上更为贴近。在这两类示例中，均需完整检索原始父文档，以确保答案具备充分、完整的上下文支撑，因此该方法被称为“父文档检索器（Parent Document Retriever）”。

In this blog post, you will learn how to use the [neo4j-advanced-rag template](https://github.com/langchain-ai/langchain/tree/master/templates/neo4j-advanced-rag?ref=blog.langchain.com) and host it using LangServe.  
本文将介绍如何使用 [neo4j-advanced-rag 模板](https://github.com/langchain-ai/langchain/tree/master/templates/neo4j-advanced-rag?ref=blog.langchain.com)，并借助 LangServe 部署运行。

**Neo4j Environment Setup**  
**Neo4j 环境搭建**

You need to set up a Neo4j 5.11 or greater to follow along with the examples in this blog post. The easiest way is to start a free instance on [Neo4j Aura](https://neo4j.com/cloud/platform/aura-graph-database/?ref=blog.langchain.com), which offers cloud instances of the Neo4j database. Alternatively, you can also set up a local instance of the Neo4j database by downloading the [Neo4j Desktop](https://neo4j.com/download/?ref=blog.langchain.com) application and creating a local database instance.  
你需要部署 Neo4j 5.11 或更高版本，以复现本文中的全部示例。最便捷的方式是通过 [Neo4j Aura](https://neo4j.com/cloud/platform/aura-graph-database/?ref=blog.langchain.com) 免费启动一个云端 Neo4j 数据库实例。此外，你也可下载 [Neo4j Desktop](https://neo4j.com/download/?ref=blog.langchain.com) 应用程序，在本地安装并创建一个 Neo4j 数据库实例。

```
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

```
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

**Neo4j Advanced RAG template**  
**Neo4j 高级 RAG 模板**

[LangChain Templates](https://blog.langchain.com/langserve-hub/) offers a collection of easily deployable reference architectures that anyone can use. This is a new way to create, share, maintain, download, and customize chains and agents. They are all in a standard format that allows them to easily be deployed with [LangServe](https://github.com/langchain-ai/langserve?ref=blog.langchain.dev), allowing you to easily get production-ready APIs and a playground for free.  
[LangChain 模板库](https://blog.langchain.com/langserve-hub/) 提供一系列开箱即用、易于部署的参考架构，面向所有开发者开放。这是一种全新的方式，用于创建、共享、维护、下载及定制链（chains）与智能体（agents）。所有模板均采用统一标准格式，可直接通过 [LangServe](https://github.com/langchain-ai/langserve?ref=blog.langchain.dev) 快速部署，助你零成本获得生产就绪的 API 接口及交互式开发沙盒（playground）。

The [`neo4j-advanced-rag` template](https://github.com/langchain-ai/langchain/tree/master/templates/neo4j-advanced-rag?ref=blog.langchain.com) allows you to balance precise embeddings and context retention by implementing advanced retrieval strategies.  
[`neo4j-advanced-rag` 模板](https://github.com/langchain-ai/langchain/tree/master/templates/neo4j-advanced-rag?ref=blog.langchain.com) 通过实现多种高级检索策略，在向量嵌入精度与上下文信息保留之间取得良好平衡。

**Available Strategies**

**可用策略**

_1\. Typical RAG:_

_1\. 典型 RAG（检索增强生成）：_

\- Traditional method where the exact data indexed is the data retrieved.

\- 传统方法，即被索引的数据即为被检索的数据。

_2\. Parent retriever:_

_2\. 父文档检索器（Parent Retriever）：_

\- Instead of indexing entire documents, data is divided into smaller chunks, referred to as Parent and Child documents.

\- 不对整篇文档进行索引，而是将数据划分为更小的片段，称为“父文档”（Parent Document）和“子文档”（Child Document）。

\- Child documents are indexed for better representation of specific concepts, while parent documents are retrieved to ensure context retention.

\- 子文档被索引，以更精准地表征特定概念；而父文档被检索，以确保上下文信息的完整性。

_3\. Hypothetical Questions:_

_3\. 假设性问题（Hypothetical Questions）：_

\- Documents are processed to generate potential questions they might answer.

\- 对文档进行处理，生成其可能回答的潜在问题。

\- These questions are then indexed for better representation of specific concepts, while parent documents are retrieved to ensure context retention.

\- 这些问题随后被索引，以更有效地表征特定概念；同时检索对应的父文档，以保障上下文信息不丢失。

_4\. Summaries:_

_4\. 摘要（Summaries）：_

- Instead of indexing the entire document, a summary of the document is created and indexed.  
- 而不是对整个文档进行索引，而是先生成文档摘要，并对摘要进行索引。

- Similarly, the parent document is retrieved in a RAG application.  
- 类似地，在 RAG 应用中，会检索原始的父文档（即未分块的完整文档）。

To be able to use LangChain templates, you should first install the LangChain CLI:  
若要使用 LangChain 模板，您需首先安装 LangChain 命令行工具（CLI）：

```
pip install -U "langchain-cli[serve]"
```

```
pip install -U "langchain-cli[serve]"
```

Retrieving the LangChain template is then as simple as executing the following line of code:  
随后，只需运行以下命令即可获取 LangChain 模板：

```
langchain app new my-app --package neo4j-advanced-rag
```

```
langchain app new my-app --package neo4j-advanced-rag
```

This code will create a new folder called my-app, and store all the relevant code in it. Think of it as a “git clone” equivalent for LangChain templates. This will construct the following structure in your filesystem.  
该命令将创建一个名为 `my-app` 的新文件夹，并将所有相关代码存入其中。您可以将其理解为 LangChain 模板的“`git clone`”等效操作。执行后，您的文件系统中将生成如下目录结构：

![](images/implementing-advanced-rag-strategies-with-neo4j/img_004.jpg)  
![](images/implementing-advanced-rag-strategies-with-neo4j/img_004.jpg)

There are two top-level folders created:  
项目根目录下将生成两个顶层文件夹：

- App: stores the FastAPI server code  
- `App`：存放 FastAPI 服务端代码

- Packages: stores all the templates that you selected to use in this application. Remember, you can use multiple templates in a single application  
- `Packages`：存放您在本应用中选定使用的全部模板。请注意，您可在单个应用中同时集成多个模板。

Every template is a standalone project with its own poetry file, readme, and potentially also an ingest script, which you can use to populate the database.  
每个模板都是一个独立的项目，拥有自己的 `poetry` 配置文件、`README` 文件，以及（可选的）一个数据导入脚本（ingest script），可用于向数据库中填充数据。

In the `neo4j-advanced-rag` template, the ingest script will construct a small graph based on the information from the Dune wikipedia page.  
在 `neo4j-advanced-rag` 模板中，该导入脚本将基于 Dune 维基百科页面的信息构建一个小型图谱。

Before running, you need to make sure to add relevant environment variables:  
运行前，请确保已设置以下相关环境变量：

```
export OPENAI_API_KEY=sk-..
export NEO4J_USERNAME=neo4j
export NEO4J_PASSWORD=password
export NEO4J_URI=bolt://localhost:7687
```

Make sure to change the environment variables to appropriate values.  
请务必将上述环境变量替换为您的实际值。

Then, you can run the ingest script with the following command.  
随后，您可通过以下命令运行导入脚本：

```
python ingest.py
```

The ingest can take a minute as we use the LLM to generate hypothetical questions and summaries.  
由于我们使用大语言模型（LLM）生成假设性问题和摘要，整个导入过程可能耗时约一分钟。

If you inspect the generated graph in Neo4j Browser, you should get a similar visualization:  
若您在 Neo4j Browser 中查看所生成的图谱，应能看到如下类似的可视化效果：

![](images/implementing-advanced-rag-strategies-with-neo4j/img_005.jpg)

The purple nodes are the parent documents, which have a length of 512 tokens. Each parent document has multiple child nodes (orange) that contain a subsection of the parent document. Additionally, the parent nodes also have potential questions represented as blue nodes and a single summary node in red.  
紫色节点代表父文档（parent documents），每篇长度为 512 个 token；每个父文档关联多个子节点（橙色），每个子节点包含父文档的一个子章节；此外，父节点还连接若干代表潜在问题的蓝色节点，以及一个红色的摘要节点（summary node）。

As we have all the data needed for different strategies in a single store, we can easily compare the results of using different advanced retrieval strategies in the Playground application.  
由于所有高级检索策略所需的数据均已统一存储于同一图数据库中，我们便可在 Playground 应用中轻松对比不同高级检索策略的实际效果。

One thing you need to do is to change the `server.py` to include the `neo4j-advanced-rag` template as an endpoint.  
您需要完成的一项操作是：修改 `server.py` 文件，将 `neo4j-advanced-rag` 模板注册为一个服务端点。

```
from fastapi import FastAPI
from langserve import add_routes

from neo4j_advanced_rag import chain as neo4j_advanced_chain

app = FastAPI()
```

# Add this

# 添加此代码

```python
add_routes(app, neo4j_advanced_chain, path="/neo4j-advanced-rag")

if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)
```

```python
add_routes(app, neo4j_advanced_chain, path="/neo4j-advanced-rag")

if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)
```

You can now serve this template by executing the following line of code in the root application directory.

您现在可在应用根目录下执行以下命令来启动该模板：

```
langchain serve
```

```
langchain serve
```

Finally, you [can open the playground application](http://localhost:8000/neo4j-advanced-rag/playground?ref=blog.langchain.com) in your browser and compare different advanced RAG retrieval approaches.

最后，您可在浏览器中[打开 Playground 应用](http://localhost:8000/neo4j-advanced-rag/playground?ref=blog.langchain.com)，对比不同高级 RAG 检索策略的效果。

![](images/implementing-advanced-rag-strategies-with-neo4j/img_006.jpg)

![](images/implementing-advanced-rag-strategies-with-neo4j/img_006.jpg)

The playground is really nice as it offers a nice user interface to test out and inspect various LangChain Templates. For example, you can expand the “Intermediate steps” and inspect which documents were passed to the LLM, what is in the prompt, and all the other details of a chain.

Playground 界面非常友好，提供了直观的用户界面，便于测试和检查各类 LangChain 模板。例如，您可以展开“中间步骤（Intermediate steps）”区域，查看传递给大语言模型（LLM）的具体文档、提示词（prompt）内容，以及链（chain）运行过程中的所有其他细节。

Since the strategy can be selected in the dropdown menu, you can easily compare how the output differs based on the selected retrieval strategy (or inspect documents in the Intermediate steps section).

由于检索策略可通过下拉菜单选择，您可轻松对比不同策略对最终输出结果的影响（或在“中间步骤”区域中检查所检索到的文档）。

![](images/implementing-advanced-rag-strategies-with-neo4j/img_007.jpg)

![](images/implementing-advanced-rag-strategies-with-neo4j/img_007.jpg)

💡

💡

Even with such a tiny dataset (17 documents of 512 tokens), I was able to find examples where the typical RAG retrieval might fail. Therefore, it seems imperative to learn about advanced retrieval RAG strategies and implement them into your application for better user experience.

即使使用如此小的数据集（仅 17 篇文档，每篇 512 个 token），我仍能发现典型 RAG 检索可能失败的案例。因此，深入学习高级检索型 RAG 策略，并将其集成到您的应用中以提升用户体验，显得尤为必要。

### Summary

### 总结

In today’s RAG applications, the ability to retrieve accurate and contextual information from a large text corpus is crucial. The traditional approach to vector similarity search, while powerful, might sometimes overlook the specific context when longer text is embedded. By splitting longer documents into smaller vectors and indexing these for similarity, we can increase the retrieval accuracy while retaining the contextual information of parent documents to generate the answers with LLMs. Similarly, we can use LLMs to generate hypothetical questions or summaries of text and index those instead but still return the text of the parent document.

在当今的 RAG 应用中，从大规模文本语料库中准确、上下文相关地检索信息至关重要。传统的向量相似性搜索方法虽功能强大，但在对长文本进行嵌入时，有时会忽略其具体上下文。通过将长文档切分为更小的文本块并分别嵌入为向量、再建立相似性索引，我们既能提升检索准确性，又能保留原始父文档的上下文信息，从而支持大语言模型（LLM）生成高质量回答。类似地，我们也可利用 LLM 为文本生成假设性问题或摘要，并对这些问题或摘要进行索引——但最终返回的仍是原始父文档的文本内容。

Test it out and let us know how it goes!

欢迎亲自尝试，并告诉我们您的使用体验！
&#123;% endraw %}
