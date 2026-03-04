---
render_with_liquid: false
title: "Langchain x Predibase: The easiest way to fine-tune and productionize OSS LLMs"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-predibase-the-easiest-way-to-fine-tune-and-productionize-oss-llms/"
date: "2023-08-18"
scraped_at: "2026-03-03T09:10:55.057087751+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

_Editor's Note: This post was written in collaboration with the Predibase team. We're really excited about the way their integration with LangChain helps bring production-grade standards and workflows to open-source models._

_编辑者注：本文由 LangChain 团队与 Predibase 团队联合撰写。我们非常兴奋地看到，Predibase 与 LangChain 的集成正助力开源模型迈向生产级标准与工作流。_

Today, we’re announcing a Langchain Integration for [Predibase](https://predibase.com/?ref=blog.langchain.com). This integration allows Langchain developers to seamlessly integrate hosted OSS models on Predibase into their workflows.

今天，我们正式宣布 LangChain 与 [Predibase](https://predibase.com/?ref=blog.langchain.com) 的集成。该集成使 LangChain 开发者能够无缝将 Predibase 托管的开源大语言模型（OSS LLMs）接入自身工作流。

## What is Predibase?

## Predibase 是什么？

Predibase is a Developer platform for OSS LLMs. Predibase allows builders to:

Predibase 是一个面向开源大语言模型（OSS LLMs）的开发者平台。Predibase 使开发者能够：

- Deploy and query pre-trained or custom open source LLMs without the hassle  
- 无需繁琐操作，即可部署并调用预训练或自定义的开源大语言模型；  
- Operationalize an end-to-end Retrieval Augmented Generation (RAG) system  
- 实现端到端检索增强生成（Retrieval-Augmented Generation, RAG）系统的工程化落地；  
- Fine-tune their own LLM in just a few lines of code  
- 仅需数行代码，即可完成自有大语言模型的微调。

If using commercial LLM providers like OpenAI / Anthropic / Cohere might not be a good fit due to privacy or cost, Predibase might be a natural choice to explore. While Predibase is focused on helping you productionize open-source LLMs, the platform itself is also built on top of open-source foundations including Ludwig and Horovod. It supports multiple interfaces including a UI and a Python SDK, making it accessible to users of all levels. Best of all, the platform can be deployed on Predibase-managed infrastructure or securely inside your own Cloud VPC so your data and models stay within your secure environment.

若您因数据隐私或成本考量，难以采用 OpenAI / Anthropic / Cohere 等商业大语言模型服务，Predibase 或将成为您值得探索的自然之选。尽管 Predibase 的核心使命是助您将开源大语言模型投入生产环境，其平台本身亦构建于开源技术栈之上——包括 Ludwig 和 Horovod。平台提供多种交互方式，涵盖图形用户界面（UI）与 Python SDK，适配各层次用户需求。尤为值得一提的是，Predibase 既可部署于 Predibase 托管的基础设施上，也可安全部署于您自有云环境的虚拟私有云（Cloud VPC）内，确保您的数据与模型始终保留在受控、安全的环境中。

## Langchain + Predibase

## LangChain + Predibase

Setup:

配置步骤：

1. Sign up for Predibase for free: [https://predibase.com/free-trial](https://predibase.com/free-trial?ref=blog.langchain.com)  
1. 免费注册 Predibase：[https://predibase.com/free-trial](https://predibase.com/free-trial?ref=blog.langchain.com)  
2. Create an Account  
2. 创建账户  
3. Go to Settings > My profile and Generate a new API Token  
3. 进入「设置」>「我的资料」，生成新的 API Token  

### Q/A Example ( [Colab Notebook](https://colab.research.google.com/drive/1ASRX6BOVMfgAEkTmcCDYATCSbfzfg3S4?usp=sharing&ref=blog.langchain.com))

### 问答示例（[Colab 笔记本](https://colab.research.google.com/drive/1ASRX6BOVMfgAEkTmcCDYATCSbfzfg3S4?usp=sharing&ref=blog.langchain.com)）

Below is an example of a simple Q/A system you can build using Langchain and Predibase-hosted LLMs.

以下是一个使用 LangChain 和 Predibase 托管的大语言模型（LLM）构建的简单问答（Q/A）系统的示例。

```
pip install predibase
pip install langchain
pip install chromadb
pip install sentence_transformers

# Replace with your Predibase API Token
import os
os.environ[“PREDIBASE_API_TOKEN”] = “{PREDIBASE_API_TOKEN}”

from langchain.document_loaders import WebBaseLoader
from langchain.indexes import VectorstoreIndexCreator
from langchain.llms import Predibase

# Document loader
from langchain.document_loaders import WebBaseLoader
loader = WebBaseLoader("https://lilianweng.github.io/posts/2023-06-23-agent/")
data = loader.load()

# Split into Chunks
from langchain.text_splitter import RecursiveCharacterTextSplitter
text_splitter = RecursiveCharacterTextSplitter(chunk_size = 500, chunk_overlap = 0)
all_splits = text_splitter.split_documents(data)

# Store Embeddings in Chroma
from langchain.vectorstores import Chroma
from langchain.embeddings import HuggingFaceEmbeddings
vectorstore = Chroma.from_documents(documents=all_splits,embedding = HuggingFaceEmbeddings())

# Pull in any LLM from Predibase, including fine-tuned LLM’s
llm = Predibase(model="llama-2-13b", predibase_api_key=os.environ.get("PREDIBASE_API_TOKEN"))

# Fetch relevant chunks into LLM
from langchain.chains import RetrievalQA
qa_chain = RetrievalQA.from_chain_type(llm,retriever=vectorstore.as_retriever())
qa_chain({"query": question})
```

```
pip install predibase
pip install langchain
pip install chromadb
pip install sentence_transformers

# 请将此处替换为您自己的 Predibase API Token
import os
os.environ[“PREDIBASE_API_TOKEN”] = “{PREDIBASE_API_TOKEN}”

from langchain.document_loaders import WebBaseLoader
from langchain.indexes import VectorstoreIndexCreator
from langchain.llms import Predibase

# 文档加载器
from langchain.document_loaders import WebBaseLoader
loader = WebBaseLoader("https://lilianweng.github.io/posts/2023-06-23-agent/")
data = loader.load()

# 分割为文本块（Chunks）
from langchain.text_splitter import RecursiveCharacterTextSplitter
text_splitter = RecursiveCharacterTextSplitter(chunk_size = 500, chunk_overlap = 0)
all_splits = text_splitter.split_documents(data)

# 将嵌入向量（Embeddings）存入 Chroma 向量数据库
from langchain.vectorstores import Chroma
from langchain.embeddings import HuggingFaceEmbeddings
vectorstore = Chroma.from_documents(documents=all_splits, embedding = HuggingFaceEmbeddings())

# 从 Predibase 加载任意 LLM（包括已微调的 LLM）
llm = Predibase(model="llama-2-13b", predibase_api_key=os.environ.get("PREDIBASE_API_TOKEN"))

# 将相关文本块传入 LLM 进行问答
from langchain.chains import RetrievalQA
qa_chain = RetrievalQA.from_chain_type(llm, retriever=vectorstore.as_retriever())
qa_chain({"query": question})
```

We’re very excited to make these capabilities available for all LangChain users and we couldn’t be more excited to see what the community builds!

我们非常激动地将这些能力开放给所有 LangChain 用户，也无比期待社区将创造出怎样的精彩成果！

If you have ideas, comments, or questions, feel free to reach out on the [LangChain](https://discord.gg/6adMQxSpJS?ref=blog.langchain.com) Discord or via [support@predibase.com](mailto:support@predibase.com).

如果您有任何想法、意见或疑问，欢迎通过 [LangChain Discord](https://discord.gg/6adMQxSpJS?ref=blog.langchain.com) 或邮件 [support@predibase.com](mailto:support@predibase.com) 与我们联系。