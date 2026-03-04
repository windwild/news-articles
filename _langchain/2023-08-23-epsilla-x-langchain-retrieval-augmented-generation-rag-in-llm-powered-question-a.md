---
title: "Epsilla x LangChain: Retrieval Augmented Generation (RAG) in LLM-Powered Question-Answering Pipelines"
source: "LangChain Blog"
url: "https://blog.langchain.com/espilla-x-langchain-retrieval-augmented-generation-rag-in-llm-powered-question-answering-pipelines/"
date: "2023-08-23"
scraped_at: "2026-03-03T08:51:31.096104139+00:00"
language: "en-zh"
translated: true
---
{% raw %}

_Editor's Note: This post was written in collaboration with the [Epsilla](https://www.epsilla.com/?ref=blog.langchain.com) team. As more apps rely on Retrieval Augmented Generation (RAG) for building personalized applications on top of proprietary data, vector databases are becoming even more important. We're really excited about what Epsilla is doing here to help builders quickly and accurately fetch the most relevant documents and data points._

_编辑者注：本文由 [Epsilla](https://www.epsilla.com/?ref=blog.langchain.com) 团队协作撰写。随着越来越多的应用依赖检索增强生成（Retrieval Augmented Generation, RAG）技术，在专有数据之上构建个性化应用，向量数据库正变得愈发关键。我们非常欣喜地看到，Epsilla 正在为此提供有力支持——助力开发者快速、精准地检索最相关的文档与数据点。_

By leveraging the strengths of both LLMs and vector databases, this integration promises richer, more accurate, and context-aware answers.

通过融合大语言模型（LLM）与向量数据库各自的优势，此次集成有望带来更丰富、更准确、且具备上下文感知能力的回答。

The landscape of artificial intelligence is ever-evolving. As developers and businesses seek more effective ways to utilize Large Language Models (LLMs), integration tools like LangChain are paving the way. In this post, we'll explore Epsilla's recent integration with LangChain and how it revolutionizes the question-answering domain.

人工智能领域持续演进。当开发者与企业寻求更高效利用大语言模型（LLM）的途径时，LangChain 等集成工具正为行业开辟新路径。本文将深入探讨 Epsilla 最近与 LangChain 的集成，以及这一合作如何重塑问答（question-answering）领域的实践方式。

Retrieval Augmented Generation (RAG) in LLM-Powered Question-Answering Pipelines

LLM 驱动的问答流水线中的检索增强生成（Retrieval Augmented Generation, RAG）

Since October 2022, there has been a huge surge in the adoption and utilization of ChatGPT and other Large Language Models (LLMs). These advanced models have emerged as frontrunners in the realm of artificial intelligence, offering unprecedented capabilities in generating human-like text and understanding nuanced queries. However, despite their prowess, ChatGPT and similar models possess inherent limitations. One of the most significant challenges is their inability to incorporate updated knowledge post their last training cut-off, rendering them unaware of events or developments that have transpired since then. Moreover, while they possess vast general knowledge, they can't access proprietary or private company data, which is often crucial for businesses looking for tailored insights or decision-making. This is where Retrieval Augmented Generation (RAG) steps in as a game-changer. RAG bridges the knowledge gap by dynamically retrieving relevant information from external sources, ensuring that the generated responses are not only factual but also up-to-date. Vector databases play an integral role in the RAG mechanism by enabling efficient and semantic retrieval of information. These databases store information as vectors, allowing RAG to quickly and accurately fetch the most relevant documents or data points based on the semantic similarity of the input query, enhancing the precision and relevance of the LLM's generated responses.

自 2022 年 10 月以来，ChatGPT 及其他大语言模型（LLM）的采用与应用呈现爆发式增长。这些先进模型已成为人工智能领域的领军者，在生成类人文本与理解复杂细微的查询方面展现出前所未有的能力。然而，尽管能力卓著，ChatGPT 等模型仍存在固有局限性。其中最显著的挑战之一，是其无法纳入最后一次训练截止日期之后更新的知识，因而对此后发生的事件或进展一无所知。此外，尽管它们拥有海量通用知识，却无法访问企业专有或私有数据——而这类数据恰恰是企业获取定制化洞察、支撑关键决策所不可或缺的。此时，检索增强生成（RAG）便成为破局的关键。RAG 通过从外部数据源动态检索相关信息，弥合了知识鸿沟，确保生成的回答不仅事实准确，而且内容最新。向量数据库在 RAG 机制中扮演着核心角色：它支持高效、语义化的信息检索。此类数据库以向量形式存储信息，使 RAG 能够基于输入查询的语义相似度，快速、精准地召回最相关的文档或数据点，从而显著提升大语言模型生成回答的准确性与相关性。

![](images/epsilla-x-langchain-retrieval-augmented-generation-rag-in-llm-powered-question-a/img_001.jpg)

## Implementing Question Answering Pipeline with LangChain and Epsilla

## 使用 LangChain 与 Epsilla 构建问答流水线

LangChain offers a unified interface and abstraction layer on top of LLM ecosystem components, simplifying the process of building generative AI applications. With LangChain, developers can avoid boilerplate code and focus on delivering value.

LangChain 在大语言模型（LLM）生态组件之上提供统一接口与抽象层，大幅简化了生成式 AI 应用的开发流程。借助 LangChain，开发者可规避大量样板代码，专注于交付实际价值。

With the Epsilla integration with LangChain, now the AI application developers can easily leverage the superior performance provided by Epsilla ( [benchmark](https://medium.com/@richard_50832/benchmarking-epsilla-with-some-of-the-top-vector-databases-543e2b7708e5?ref=blog.langchain.com)) while building the knowledge retrieval component in the AI applications.

得益于 Epsilla 与 LangChain 的集成，AI 应用开发者如今可轻松调用 Epsilla 提供的卓越性能（[基准测试报告](https://medium.com/@richard_50832/benchmarking-epsilla-with-some-of-the-top-vector-databases-543e2b7708e5?ref=blog.langchain.com)），高效构建 AI 应用中的知识检索模块。

Here is a step by step guide on implementing a question answering pipeline with LangChain and Epsilla.

以下是一份使用 LangChain 与 Epsilla 构建问答流水线的分步指南。

Step 1. Install LangChain and Epsilla

步骤 1：安装 LangChain 和 Epsilla

```
pip install langchain
pip install openai
pip install tiktoken
pip install pyepsilla
```

```
docker pull epsilla/vectordb
docker run --pull=always -d -p 8888:8888 epsilla/vectordb
```

Step 2. Provide your OpenAI key

步骤 2：提供您的 OpenAI API 密钥

```
import os

os.environ["OPENAI_API_KEY"] = "YOUR_OPENAI_API_KEY"
```

Step 3. Prepare for knowledge and embedding model

步骤 3：准备知识数据与嵌入模型

```
from langchain.embeddings import OpenAIEmbeddings
from langchain.document_loaders import WebBaseLoader
from langchain.text_splitter import CharacterTextSplitter

loader = WebBaseLoader("https://raw.githubusercontent.com/hwchase17/chat-your-data/master/state_of_the_union.txt")
documents = loader.load()

documents = CharacterTextSplitter(chunk_size=1000, chunk_overlap=0).split_documents(documents)
```

embeddings = OpenAIEmbeddings()
```

embeddings = OpenAIEmbeddings()
```

Step 4. Vectorize the knowledge documents

第 4 步：将知识文档向量化

```
from langchain.vectorstores import Epsilla
from pyepsilla import vectordb

client = vectordb.Client()
vector_store = Epsilla.from_documents(
documents,
embeddings,
client,
db_path="/tmp/mypath",
db_name="MyDB",
collection_name="MyCollection"
)
```

```
from langchain.vectorstores import Epsilla
from pyepsilla import vectordb

client = vectordb.Client()
vector_store = Epsilla.from_documents(
documents,
embeddings,
client,
db_path="/tmp/mypath",
db_name="MyDB",
collection_name="MyCollection"
)
```

Step 5. Create a RetrievalQA chain for question answering on the uploaded knowledge

第 5 步：为已上传的知识构建一个用于问答的 RetrievalQA 链

```
from langchain.chains import RetrievalQA
from langchain.llms import OpenAI

qa = RetrievalQA.from_chain_type(llm=OpenAI(), chain_type="stuff", retriever=vector_store.as_retriever())
query = "What did the president say about Ketanji Brown Jackson"
qa.run(query)
```

```
from langchain.chains import RetrievalQA
from langchain.llms import OpenAI

qa = RetrievalQA.from_chain_type(llm=OpenAI(), chain_type="stuff", retriever=vector_store.as_retriever())
query = "What did the president say about Ketanji Brown Jackson"
qa.run(query)
```

Here is the response:

以下是模型返回的回答：

|     |
| --- |
| The president said that Ketanji Brown Jackson is one of the nation's top legal minds, a former top litigator in private practice, a former federal public defender, from a family of public school educators and police officers, a consensus builder, and has received a broad range of support from the Fraternal Order of Police to former judges appointed by Democrats and Republicans. |

|     |
| --- |
| 总统表示，凯坦吉·布朗·杰克逊（Ketanji Brown Jackson）是美国顶尖的法律人才之一；她曾是私人执业领域的顶级诉讼律师，也曾担任联邦公设辩护人；她出身于一个由公立学校教育工作者和警察组成的家庭；她是一位共识缔造者，并获得了广泛支持——从“警察兄弟会”（Fraternal Order of Police）到由民主党与共和党总统任命的前任法官均对她表示支持。 |

## Conclusion

## 总结

Epsilla's integration with LangChain signifies a leap forward in the domain of question-answering systems. By leveraging the strengths of both LLMs and vector databases, this integration promises richer, more accurate, and context-aware answers. As AI continues to reshape our world, tools like LangChain, coupled with powerful vector databases like Epsilla, will be at the forefront of this transformation.

Epsilla 与 LangChain 的集成标志着问答系统领域的一次重大飞跃。通过结合大语言模型（LLM）与向量数据库各自的优势，该集成有望提供更丰富、更准确且更具上下文感知能力的回答。随着人工智能持续重塑我们的世界，LangChain 这类工具，配合 Epsilla 等强大的向量数据库，将成为这场变革的前沿力量。

For those eager to dive deeper, LangChain's source code and implementation details with Epsilla are available on [Google Colab](https://colab.research.google.com/drive/1asFJD_pNQbSQnbbjq-a7Q9SMzrpX-g-2?usp=sharing&ref=blog.langchain.com).

如需深入了解，LangChain 的源代码及与 Epsilla 的集成实现细节可在 [Google Colab](https://colab.research.google.com/drive/1asFJD_pNQbSQnbbjq-a7Q9SMzrpX-g-2?usp=sharing&ref=blog.langchain.com) 上获取。
{% endraw %}
