---
title: "LangChain Integrates NVIDIA NIM for GPU-optimized LLM Inference in RAG"
source: "LangChain Blog"
url: "https://blog.langchain.com/nvidia-nim/"
date: "2024-03-18"
scraped_at: "2026-03-03T08:06:09.332820620+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
{% raw %}

Roughly a year and a half ago, OpenAI launched ChatGPT and the generative AI era really kicked off. Since then we’ve seen rapid growth and widespread adoption by all types of industries and all types of enterprises. As enterprises turn their attention from prototyping LLM applications to productionizing them, they often want to turn from third-party model services to self-hosted solutions. We’ve seen many folks struggle with this, and that’s why LangChain is so excited to integrate the new [NVIDIA NIM](https://nvidianews.nvidia.com/news/generative-ai-microservices-for-developers?ref=blog.langchain.com) inference microservices.

大约一年半前，OpenAI 推出了 ChatGPT，生成式 AI 时代由此真正开启。此后，我们见证了生成式 AI 在各行各业、各类企业中的迅猛发展与广泛采用。随着企业关注点从大语言模型（LLM）应用的原型开发转向规模化生产部署，它们往往希望从第三方模型服务转向自托管（self-hosted）解决方案。我们已看到许多团队在此过程中面临挑战，这正是 LangChain 对集成全新的 [NVIDIA NIM](https://nvidianews.nvidia.com/news/generative-ai-microservices-for-developers?ref=blog.langchain.com) 推理微服务倍感振奋的原因。

## What is NVIDIA NIM?

## 什么是 NVIDIA NIM？

[NVIDIA NIM](https://developer.nvidia.com/blog/nvidia-nim-offers-optimized-inference-microservices-for-deploying-ai-models-at-scale/?ref=blog.langchain.com) is a set of easy-to-use microservices designed to accelerate the deployment of generative AI across enterprises. This versatile runtime supports a broad spectrum of AI models—from open-source community models to NVIDIA AI foundation models, as well as custom AI models. Leveraging industry-standard APIs, developers can quickly build enterprise-grade AI applications with just a few lines of code. Built on robust foundations including inference engines like [NVIDIA Triton Inference Server](https://www.nvidia.com/en-us/ai-data-science/products/triton-inference-server/?ref=blog.langchain.com), NVIDIA TensorRT, [NVIDIA TensorRT-LLM](https://developer.nvidia.com/blog/optimizing-inference-on-llms-with-tensorrt-llm-now-publicly-available/?ref=blog.langchain.com), and PyTorch, NIM is engineered to facilitate seamless AI inferencing at scale, ensuring that you can deploy AI applications anywhere with confidence. Whether working on premises or in the cloud, NIM is the fastest way to achieve accelerated generative AI inference at scale.

[NVIDIA NIM](https://developer.nvidia.com/blog/nvidia-nim-offers-optimized-inference-microservices-for-deploying-ai-models-at-scale/?ref=blog.langchain.com) 是一套开箱即用、易于使用的微服务，旨在加速生成式 AI 在企业级环境中的部署。这一灵活的运行时环境支持广泛的 AI 模型——涵盖开源社区模型、NVIDIA AI 基础模型，以及用户自定义 AI 模型。借助行业标准 API，开发者仅需数行代码即可快速构建企业级 AI 应用。NIM 构建于坚实的技术基础之上，包括推理引擎如 [NVIDIA Triton Inference Server](https://www.nvidia.com/en-us/ai-data-science/products/triton-inference-server/?ref=blog.langchain.com)、NVIDIA TensorRT、[NVIDIA TensorRT-LLM](https://developer.nvidia.com/blog/optimizing-inference-on-llms-with-tensorrt-llm-now-publicly-available/?ref=blog.langchain.com) 和 PyTorch，专为实现大规模、无缝的 AI 推理而设计，确保您可自信地在任意环境（本地或云端）部署 AI 应用。无论您是在本地数据中心还是在云环境中工作，NIM 都是实现加速化、规模化生成式 AI 推理的最快途径。

## Why are we excited about NVIDIA NIM?

## 为何我们对 NVIDIA NIM 如此兴奋？

There are a few reasons we are excited about NIM.

我们对 NIM 充满期待，原因有以下几点：

First, the big one: It’s all self-hosted. This means any data you send to NVIDIA-based models will never leave your premises. This is particularly exciting for RAG-based applications where you are often passing in sensitive data.

第一，也是最重要的一点：它完全支持自托管。这意味着您发送给基于 NVIDIA 的模型的所有数据，将永远不会离开您的本地环境。这对基于检索增强生成（RAG）的应用尤为关键——此类应用通常需要传入敏感数据。

Second: It comes with several prebuilt containers out of the box. This makes it so that you can choose from the latest generative AI models without having to do much work.

第二：它开箱即附带多个预构建容器。这意味着您可以直接选用最新的生成式 AI 模型，几乎无需额外配置或开发工作。

Third: It’s scalable. It’s one thing to run models locally on your laptop. It’s another to host them as a service with the same reliability and uptime as you get from a managed service provider. Luckily, NIM is taking on this challenge for you.

第三：它具备出色的可扩展性。在笔记本电脑上本地运行模型是一回事；而将其作为一项服务进行托管，并达到与托管服务提供商同等的可靠性与正常运行时间，则是另一回事。幸运的是，NIM 正在为您应对这一挑战。

## How can I get access to NVIDIA NIM?

## 如何获取 NVIDIA NIM 的访问权限？

Getting started with NIM is straightforward. Within the NVIDIA API catalog, developers can access a wide range of AI models to build and deploy generative AI applications. NIM is available as part of [NVIDIA AI Enterprise](https://www.nvidia.com/en-us/data-center/products/ai-enterprise/?ref=blog.langchain.com), an end-to-end, cloud-native software platform that streamlines the development and deployment of production-grade AI applications. Check out [this blog](https://developer.nvidia.com/blog/nvidia-nim-offers-optimized-inference-microservices-for-deploying-ai-models-at-scale/?ref=blog.langchain.com) for a step-by-step guide on how to get started.

启动 NIM 十分简单。开发者可通过 NVIDIA API 目录，便捷地访问一系列 AI 模型，用于构建和部署生成式 AI 应用。NIM 是 [NVIDIA AI Enterprise](https://www.nvidia.com/en-us/data-center/products/ai-enterprise/?ref=blog.langchain.com) 的组成部分——这是一个端到端、云原生的软件平台，可显著简化生产级 AI 应用的开发与部署流程。请参阅 [这篇博客文章](https://developer.nvidia.com/blog/nvidia-nim-offers-optimized-inference-microservices-for-deploying-ai-models-at-scale/?ref=blog.langchain.com)，获取详细的入门操作指南。

## How can I use NVIDIA NIM with LangChain?

## 如何将 NVIDIA NIM 与 LangChain 结合使用？

Finally, for the fun stuff. We’ve added a new integration package that supports NIM. To get started with the integration, you will need to install our dedicated integration package:

最后，进入有趣的部分！我们新增了一个支持 NIM 的集成包。要开始使用该集成，您需要安装我们专用的集成包：

```python
pip install langchain_nvidia_ai_endpoints
```

```python
pip install langchain_nvidia_ai_endpoints
```

After that, you can import models like:

安装完成后，您可以按如下方式导入模型：

```python
from langchain_nvidia_ai_endpoints import NVIDIAEmbeddings, ChatNVIDIA
```

```python
from langchain_nvidia_ai_endpoints import NVIDIAEmbeddings, ChatNVIDIA
```

## Integration Example

## 集成示例

For the rest of this document we will focus on building an example application. If you are more of a visual learner, you can find a video walkthrough [here](https://www.loom.com/share/d92b3cb9d86c4787ada2adb148e9a96b?ref=blog.langchain.com).

本文档其余部分将聚焦于构建一个示例应用。如果您更倾向于通过视频学习，可点击此处观看操作演示视频：[视频链接](https://www.loom.com/share/d92b3cb9d86c4787ada2adb148e9a96b?ref=blog.langchain.com)。

We will build a RAG application over part of the LangSmith documentation. To make it a little more interesting we will use an advanced retrieval method: hypothetical document embeddings (HyDE). The motivation for HyDE is that a search query may not be in a similar embedding space as the documents we are retrieving over. In order to fix this, we can use an LLM to generate a hypothetical document and then retrieve documents similar to that hypothetical document.

我们将基于 LangSmith 文档的部分内容构建一个 RAG（检索增强生成）应用。为了让示例更具趣味性，我们将采用一种高级检索方法：假设性文档嵌入（HyDE，Hypothetical Document Embeddings）。HyDE 的设计初衷在于：用户的搜索查询可能与其所检索的文档并不处于相似的嵌入空间中。为解决这一问题，我们可以利用大语言模型（LLM）生成一份“假设性文档”，再检索与该假设性文档语义相近的实际文档。

To get started, we will need to install some other packages.

接下来，我们需要安装其他一些依赖包：

```python
pip install langchain-community langchain-text-splitters faiss-cpu
```

```python
pip install langchain-community langchain-text-splitters faiss-cpu
```

We will then load some data we want to do RAG over - the LangSmith docs!

然后，我们将加载一些要用于 RAG 的数据——LangSmith 文档！

```python
from langchain_community.document_loaders import WebBaseLoader
loader = WebBaseLoader("https://docs.smith.langchain.com/user_guide")

docs = loader.load()
```

```python
from langchain_community.document_loaders import WebBaseLoader
loader = WebBaseLoader("https://docs.smith.langchain.com/user_guide")

docs = loader.load()
```

Before indexing the documents, we can then initialize our embedding model.

在对文档进行索引之前，我们可以先初始化嵌入模型。

```python
from langchain_nvidia_ai_endpoints import NVIDIAEmbeddings
embeddings = NVIDIAEmbeddings()
```

```python
from langchain_nvidia_ai_endpoints import NVIDIAEmbeddings
embeddings = NVIDIAEmbeddings()
```

We can now perform the indexing step, using the FAISS vectorstore.

接下来，我们可以使用 FAISS 向量数据库执行索引操作。

```python
from langchain_community.vectorstores import FAISS
from langchain_text_splitters import RecursiveCharacterTextSplitter

text_splitter = RecursiveCharacterTextSplitter(chunk_size=500, chunk_overlap=50)
documents = text_splitter.split_documents(docs)
vector = FAISS.from_documents(documents, embeddings)
retriever = vector.as_retriever()
```

```python
from langchain_community.vectorstores import FAISS
from langchain_text_splitters import RecursiveCharacterTextSplitter

text_splitter = RecursiveCharacterTextSplitter(chunk_size=500, chunk_overlap=50)
documents = text_splitter.split_documents(docs)
vector = FAISS.from_documents(documents, embeddings)
retriever = vector.as_retriever()
```

We can then initialize our LLM:

接着，我们可以初始化大语言模型（LLM）：

```python
from langchain_core.prompts import ChatPromptTemplate
from langchain_nvidia_ai_endpoints import ChatNVIDIA
from langchain_core.output_parsers import StrOutputParser
```

```python
from langchain_core.prompts import ChatPromptTemplate
from langchain_nvidia_ai_endpoints import ChatNVIDIA
from langchain_core.output_parsers import StrOutputParser
```

```python
model = ChatNVIDIA(model="mistral_7b")
```

```python
model = ChatNVIDIA(model="mistral_7b")
```

Now, we will create our hypothetical document generator. This chain consists of a prompt, LLM, and a simple output parser.

接下来，我们将构建一个假设性文档生成器。该链由一个提示模板（prompt）、一个大语言模型（LLM）以及一个简单的输出解析器（output parser）组成。

```python
hyde_template = """Even if you do not know the full answer, generate a one-paragraph hypothetical answer to the below question:

{question}"""
hyde_prompt = ChatPromptTemplate.from_template(hyde_template)
hyde_query_transformer = hyde_prompt | model | StrOutputParser()
```

```python
hyde_template = """即使你并不知道完整答案，也请针对以下问题生成一段假设性的、单段落的回答：

{question}"""
hyde_prompt = ChatPromptTemplate.from_template(hyde_template)
hyde_query_transformer = hyde_prompt | model | StrOutputParser()
```

We can then wrap this chain and the original retriever into a new chain:

随后，我们可以将该链与原始的检索器（retriever）封装为一条新链：

```python
from langchain_core.runnables import chain

@chain
def hyde_retriever(question):
    hypothetical_document = hyde_query_transformer.invoke({"question": question})
    return retriever.invoke(hypothetical_document)
```

```python
from langchain_core.runnables import chain

@chain
def hyde_retriever(question):
    hypothetical_document = hyde_query_transformer.invoke({"question": question})
    return retriever.invoke(hypothetical_document)
```

We can then create the chain that will take the retrieved documents and the question to produce a final answer:

接着，我们可以构建另一条链，它接收检索到的文档和原始问题，并生成最终答案：

```python
template = """Answer the question based only on the following context:
{context}

Question: {question}
"""
prompt = ChatPromptTemplate.from_template(template)
answer_chain = prompt | model | StrOutputParser()
```

```python
template = """仅基于以下上下文回答问题：
{context}

问题：{question}
"""
prompt = ChatPromptTemplate.from_template(template)
answer_chain = prompt | model | StrOutputParser()
```

Finally, we can combine this with the hypothetical document retriever to create a final chain:

最后，我们可以将此与假设性文档检索器（hypothetical document retriever）结合，构建最终的链式调用（final chain）：

```python
@chain
def final_chain(question):
    documents = hyde_retriever.invoke(question)
    for s in answer_chain.stream({"question": question, "context": documents}):
        yield s
```

```python
@chain
def final_chain(question):
    documents = hyde_retriever.invoke(question)
    for s in answer_chain.stream({"question": question, "context": documents}):
        yield s
```

Notice that we yield back tokens so that we can stream this final chain! Let’s give it a go:

请注意，我们通过 `yield` 返回 token，从而实现对这一最终链的流式输出（streaming）！现在来试一试：

```python
for s in final_chain.stream("how can langsmith help with testing"):
    print(s, end="")
```

```python
for s in final_chain.stream("how can langsmith help with testing"):
    print(s, end="")
```

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)


[![Evaluating Deep Agents: Our Learnings](images/langchain-integrates-nvidia-nim-for-gpu-optimized-llm-inference-in-rag/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/langchain-integrates-nvidia-nim-for-gpu-optimized-llm-inference-in-rag/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 7 分钟阅读

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/langchain-integrates-nvidia-nim-for-gpu-optimized-llm-inference-in-rag/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中推出端到端 OpenTelemetry 支持](images/langchain-integrates-nvidia-nim-for-gpu-optimized-llm-inference-in-rag/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中推出端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/langchain-integrates-nvidia-nim-for-gpu-optimized-llm-inference-in-rag/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain《2024 年人工智能现状》报告](images/langchain-integrates-nvidia-nim-for-gpu-optimized-llm-inference-in-rag/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain《2024 年人工智能现状》报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/langchain-integrates-nvidia-nim-for-gpu-optimized-llm-inference-in-rag/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/langchain-integrates-nvidia-nim-for-gpu-optimized-llm-inference-in-rag/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/langchain-integrates-nvidia-nim-for-gpu-optimized-llm-inference-in-rag/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更便捷的评估](images/langchain-integrates-nvidia-nim-for-gpu-optimized-llm-inference-in-rag/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更简易的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/langchain-integrates-nvidia-nim-for-gpu-optimized-llm-inference-in-rag/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项](images/langchain-integrates-nvidia-nim-for-gpu-optimized-llm-inference-in-rag/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟
{% endraw %}
