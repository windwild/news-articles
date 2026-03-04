---
title: "Embeddings Drive the Quality of RAG: Voyage AI in Chat LangChain"
source: "LangChain Blog"
url: "https://blog.langchain.com/voyage-embeddings-in-langchain-and-chat-langchain/"
date: "2023-11-02"
scraped_at: "2026-03-03T08:30:12.595366299+00:00"
language: "en-zh"
translated: true
---
{% raw %}

_Editor's Note: This post was written by the [_Voyage AI_](https://www.voyageai.com/?ref=blog.langchain.com) team._

_编辑注：本文由 [_Voyage AI_](https://www.voyageai.com/?ref=blog.langchain.com) 团队撰写。_

This post demonstrates that the choice of embedding models significantly impacts the overall quality of a chatbot based on [Retrieval-Augmented Generation (RAG)](https://www.pinecone.io/learn/retrieval-augmented-generation/?ref=blog.langchain.com). We focus on the case of [Chat LangChain](https://chat.langchain.com/?ref=blog.langchain.com), the LangChain chatbot for answering questions about LangChain documentation, which currently uses fine-tuned Voyage embeddings in production. We finish by showing how to access general Voyage embedding models via LangChain.

本文表明，嵌入模型（embedding model）的选择会显著影响基于[检索增强生成（RAG）](https://www.pinecone.io/learn/retrieval-augmented-generation/?ref=blog.langchain.com)架构的聊天机器人的整体质量。我们以 [Chat LangChain](https://chat.langchain.com/?ref=blog.langchain.com) 为例——这是 LangChain 官方推出的、用于解答 LangChain 文档相关问题的聊天机器人，目前在生产环境中使用经微调的 Voyage 嵌入模型。最后，我们将展示如何通过 LangChain 访问通用版 Voyage 嵌入模型。

## Brief background on RAG, retrieval system, and embeddings

## RAG、检索系统与嵌入模型简要背景

**Retrieval-augmented generation**, commonly called RAG, is a powerful design pattern for chatbots where a **retrieval system** fetches validated sources/documents that are pertinent to the query, in real-time, and inputs them to a generative model (e.g., GPT-4) to generate a response. With high-quality retrieved data, RAG can ensure that generated responses are not just intelligent, but also contextually accurate and informed.

**检索增强生成（Retrieval-Augmented Generation，简称 RAG）** 是一种强大的聊天机器人设计范式：其中 **检索系统（retrieval system）** 实时获取与用户查询高度相关的、经过验证的资料或文档，并将其输入生成式模型（例如 GPT-4），从而生成回答。借助高质量的检索结果，RAG 不仅能确保生成的回答具备智能性，更能保障其上下文准确性与信息可靠性。

Modern retrieval system are empowered by semantic search using dense-vector representations of the data. **Embedding models,** which are neural nets models, transform the queries and documents into vectors, which are called embeddings. Then, the documents whose embeddings are closest to the embedding of the query are retrieved. The quality of the retrieval is thus solely decided by how the data are represented as vectors; vice versa, the effectiveness of embedding models is evaluated based on their accuracy in retrieving relevant information.

现代检索系统依托语义搜索技术，利用数据的稠密向量表示（dense-vector representation）实现高效匹配。**嵌入模型（embedding models）** 是一类神经网络模型，可将查询语句和文档分别映射为向量（即“嵌入”，embeddings）。随后，系统检索出与查询向量距离最近的文档向量所对应的文档。因此，检索质量完全取决于数据被表征为向量的方式；反之，嵌入模型的有效性也正由其在检索相关信息时的准确率来衡量。

Please check out this introduction post to [RAG](https://www.pinecone.io/learn/retrieval-augmented-generation/?ref=blog.langchain.com) for more details.

更多详情，请参阅这篇关于 [RAG](https://www.pinecone.io/learn/retrieval-augmented-generation/?ref=blog.langchain.com) 的入门介绍文章。

![](images/embeddings-drive-the-quality-of-rag-voyage-ai-in-chat-langchain/img_001.png)

![](images/embeddings-drive-the-quality-of-rag-voyage-ai-in-chat-langchain/img_001.png)

## Evaluating the effect of embeddings in the RAG stack

## 评估嵌入模型在 RAG 架构中的作用

**Methodology.** RAG has two main AI components, embedding models and generative models. We ablate the effect of embedding models by keeping the generative model component to be the state-of-the-art model, GPT-4. We measure two metrics, (1) the retrieval quality, which is a modular evaluation of embedding models, and (2) the end-to-end quality of the response of the RAG. We will show that retrieval quality directly affects end-to-end response quality.

**方法论。** RAG 架构包含两大核心 AI 组件：嵌入模型与生成模型。为隔离嵌入模型的影响，我们固定生成模型组件为当前最先进的模型 GPT-4。我们采用两项评估指标：（1）检索质量（retrieval quality），即对嵌入模型能力的模块化评估；（2）RAG 系统端到端（end-to-end）的回答质量。我们将证明：检索质量直接决定端到端回答质量。

**Evaluation scenarios.** In this post, we focus on the scenario of the Chat LangChain bot that answers questions about [LangChain](https://python.langchain.com/?ref=blog.langchain.com) documentation. The [open-source](https://github.com/langchain-ai/chat-langchain?ref=blog.langchain.com) chatbot uses a RAG stack with a pool of 6,522 documents sourced directly from the LangChain docs. From the partnership with [LangChain](https://www.langchain.com/?ref=blog.langchain.com), we obtained a collection of 50 pairs of queries and corresponding gold standard answers, which are the main dataset for evaluating the response quality.

**评估场景。** 本文聚焦于 **Chat LangChain** 聊天机器人这一具体场景——它专为解答关于 [LangChain](https://python.langchain.com/?ref=blog.langchain.com) 文档的问题而设计。该 [开源](https://github.com/langchain-ai/chat-langchain?ref=blog.langchain.com) 聊天机器人采用 RAG 架构，其知识库由直接来自 LangChain 官方文档的 6,522 篇文档构成。依托与 [LangChain](https://www.langchain.com/?ref=blog.langchain.com) 的合作，我们获得了一组包含 50 个查询及其对应权威标准答案（gold standard answers）的数据集，该数据集是评估回答质量的主要基准。

**Models.**  
**模型。**  
We consider three embedding models, OpenAI’s industry-leading embedding model [`text-embedding-ada-002`](https://openai.com/blog/new-and-improved-embedding-model?ref=blog.langchain.com) , Voyage’s generalist model [`voyage-01`](https://docs.voyageai.com/embeddings/?ref=blog.langchain.com) , and an enhanced version fine-tuned on LangChain docs , `voyage-langchain-01`.  
我们考虑了三种嵌入模型：OpenAI 行业领先的嵌入模型 [`text-embedding-ada-002`](https://openai.com/blog/new-and-improved-embedding-model?ref=blog.langchain.com)，Voyage 的通用型模型 [`voyage-01`](https://docs.voyageai.com/embeddings/?ref=blog.langchain.com)，以及一个在 LangChain 文档上微调增强的版本 `voyage-langchain-01`。

**Measuring response quality.**  
**响应质量评估方法。**  
To evaluate the response’s quality, we compare the semantic similarity between the generated responses and the gold standard responses by asking GPT-4 to evaluate the similarity with a score out of 10. A score of 1 indicates that the generated answer is incorrect and bears no relevance to the gold standard answer, while a score of 10 signifies a perfect alignment with the gold standard answer.  
为评估生成响应的质量，我们请 GPT-4 对生成响应与标准答案（gold standard）之间的语义相似度进行打分（满分 10 分）。得分为 1 表示生成答案完全错误，且与标准答案毫无相关性；得分为 10 则表示生成答案与标准答案完全一致。

**Measuring retrieval quality.**  
**检索质量评估方法。**  
For the 50 queries, we manually curate the gold-standard documents that are most relavent to the queries. We retrieve 10 documents for each queries, and use the standard [NDCG@10](https://en.wikipedia.org/wiki/Discounted_cumulative_gain?ref=blog.langchain.com) metric to calculate the relevance of the retrieve docs to the gold-stand document.  
针对 50 个查询，我们人工筛选出与各查询最相关的标准文档（gold-standard documents）。对每个查询，我们均检索 10 篇文档，并采用标准指标 [NDCG@10](https://en.wikipedia.org/wiki/Discounted_cumulative_gain?ref=blog.langchain.com) 来衡量所检索文档相对于标准文档的相关性。

**Results.**  
**实验结果。**  
The table below shows that `voyage-01` surpasses OpenAI’s `text-embedding-ada-002` in both the retrieval quality and response quality. Furthermore,  `voyage-langchain-01`, which was specifically fine-tuned on LangChain documents, has the highest retrieval and response quality. The data suggest that indeed the quality of the final response is highly correlated with the retrieval quality, and `voyage-01` and `voyage-langchain-01` improve the final response’s quality by improving the retrieval quality.  
下表显示：`voyage-01` 在检索质量和响应质量两方面均优于 OpenAI 的 `text-embedding-ada-002`；而专门在 LangChain 文档上微调的 `voyage-langchain-01`，则在两项指标上均取得最高分。数据表明，最终响应质量确实与检索质量高度相关；`voyage-01` 和 `voyage-langchain-01` 正是通过提升检索质量，从而提升了最终响应的质量。

| Model Name | Response quality(1-10) ↑ | Retrieval quality ↑ |
| --- | --- | --- |
| Voyage (`voyage-langchain-01`) | 6.25 | 52.40 |
| Voyage (`voyage-01`) | 5.08 | 47.55 |
| OpenAI (`text-embedding-ada-002`) | 4.34 | 45.81 |

| 模型名称 | 回答质量（1–10 分）↑ | 检索质量 ↑ |
| --- | --- | --- |
| Voyage (`voyage-langchain-01`) | 6.25 | 52.40 |
| Voyage (`voyage-01`) | 5.08 | 47.55 |
| OpenAI (`text-embedding-ada-002`) | 4.34 | 45.81 |

## Demonstrating examples  
## 示例演示  

We support the quantitive results above by showcasing a few intuitive examples where more accurate retrieval with Voyage’s embeddings enables more accurate responses.  
我们通过展示若干直观示例，佐证上述量化结果——即 Voyage 嵌入模型带来的更精准检索，可直接促成更准确的响应。

### **Example 1:  `voyage-01` vs [**`text-embedding-ada-002`**](https://openai.com/blog/new-and-improved-embedding-model?ref=blog.langchain.com)**  
### **示例 1：`voyage-01` vs [`text-embedding-ada-002`](https://openai.com/blog/new-and-improved-embedding-model?ref=blog.langchain.com)**  

**Query** _: “What is html2texttransformer? Does it omit urls?”_  
**查询**：“`html2texttransformer` 是什么？它是否会省略 URL？”  

Given the query above, `voyage-01` (left) fetches the correct document, the detailed description of the `html2texttransformer` function, whereas `text-embedding-ada-002` (right) retrieves a less relavent document, the documentation of `html2text` which contains `html2texttransformer` as a method. The latter document does contain the string `html2texttransformer` but only in an exemplar code block.  
针对上述查询，`voyage-01`（左图）成功检索到正确文档——即对 `html2texttransformer` 函数的详细说明；而 `text-embedding-ada-002`（右图）则检索到相关性较低的文档——即 `html2text` 的文档，其中仅将 `html2texttransformer` 列为一个方法。该文档虽包含字符串 `html2texttransformer`，但仅出现在一个示例代码块中。

![](images/embeddings-drive-the-quality-of-rag-voyage-ai-in-chat-langchain/img_002.png)

![](images/embeddings-drive-the-quality-of-rag-voyage-ai-in-chat-langchain/img_003.png)

**Left**: Top-1 doc retrieved by `voyage-01`.  
**左**：由 `voyage-01` 检索出的排名第一的文档。

**Right**: Top-1 doc retrieved by `text-embedding-ada-002`.  
**右**：由 `text-embedding-ada-002` 检索出的排名第一的文档。

Consequently, the response generated by RAG using the `voyage-01` (left) is accurate, whereas the response with `text-embedding-ada-002` (right) confuses `html2texttransformer` with the class that contains it.  
因此，使用 `voyage-01`（左图）进行检索增强生成（RAG）所生成的回答是准确的；而使用 `text-embedding-ada-002`（右图）时，模型却将 `html2texttransformer` 与其所属的类混淆了。

![](images/embeddings-drive-the-quality-of-rag-voyage-ai-in-chat-langchain/img_004.png)

![](images/embeddings-drive-the-quality-of-rag-voyage-ai-in-chat-langchain/img_005.png)

### **Example 2: `voyage-01` vs `voyage-langchain-01`**

### **示例 2：`voyage-01` 对比 `voyage-langchain-01`**

The fine-tuned model `voyage-langchain-01` has a superior retrieval quality and response quality than `voyage-01`. The examples below demonstrate how `voyage-langchain-01` can fetch documents with more pertinent information given the query below.  
微调模型 `voyage-langchain-01` 在检索质量与响应质量方面均优于 `voyage-01`。以下示例展示了：针对下方查询，`voyage-langchain-01` 能够检索到信息更相关、更贴切的文档。

**Query**: _“I’m running my own model using vllm. How do I connect it to LangChain?”_  
**查询**：_“我正使用 vLLM 运行自己的模型。如何将其接入 LangChain？”_

As we can see below, `voyage-01` (left) doesn’t give a document that is relevant to vLLM, whereas `voyage-langchain-01` (right) retrieves the correct document. Here the reason is that vLLM is a highly specialized concept that a generalist embedding model is difficult to grasp; but a fine-tuned model has seen the LangChain documentation and thus can catch up with the terminology and concept.  
如图所示，`voyage-01`（左图）未能返回与 vLLM 相关的文档，而 `voyage-langchain-01`（右图）则成功检索到了正确文档。其原因在于：vLLM 是一个高度专业化的概念，通用型嵌入模型难以准确理解；而经过微调的模型已在 LangChain 文档上进行过训练，因而能够准确捕捉相关术语与概念。

![](images/embeddings-drive-the-quality-of-rag-voyage-ai-in-chat-langchain/img_006.png)

![](images/embeddings-drive-the-quality-of-rag-voyage-ai-in-chat-langchain/img_007.png)

**Left**: Top-1 doc retrieved by `voyage-01`.  
**右图**: 由 `voyage-01` 检索出的排名第一的文档。

**Right**: Top-1 doc retrieved by `voyage-langchain-01`.  
**右图**: 由 `voyage-langchain-01` 检索出的排名第一的文档。

Not surprisingly, the RAG with `voyage-langchain-01` (right) accurately answers the question. On the other hand, without retrieving the correct document, RAG with `voyage-01` (left) hallucinates an answer.  
不出所料，使用 `voyage-langchain-01`（右图）的 RAG 准确回答了问题；而使用 `voyage-01`（左图）的 RAG 因未能检索到正确文档，生成了幻觉答案（hallucinates an answer）。

![](images/embeddings-drive-the-quality-of-rag-voyage-ai-in-chat-langchain/img_008.png)

![](images/embeddings-drive-the-quality-of-rag-voyage-ai-in-chat-langchain/img_009.png)

## Using Voyage in LangChain

## 在 LangChain 中使用 Voyage

As of `langchain >= 0.0.327`, Voyage is integrated into the LangChain Python package, allowing anyone to access the `voyage-01` model for their own applications.  
自 `langchain >= 0.0.327` 起，Voyage 已集成至 LangChain Python 包中，用户可直接在自己的应用中调用 `voyage-01` 模型。

You can get a Voyage API key [here](https://www.voyageai.com/?ref=blog.langchain.com), which should be set as an environment variable:  
您可在此处获取 Voyage API 密钥：[点击获取](https://www.voyageai.com/?ref=blog.langchain.com)，并需将其设为环境变量：

```bash
export VOYAGE_API_KEY="..."
```

Install the latest version of LangChain:

安装最新版本的 LangChain：

```bash
pip install -U langchain
```

```bash
pip install -U langchain
```

And you can start using `VoyageEmbeddings`. Here's a simple example of how to use Voyage to power KNN retrieval:

接着即可开始使用 `VoyageEmbeddings`。以下是一个使用 Voyage 实现 KNN 检索的简单示例：

```python
from langchain.embeddings import VoyageEmbeddings
from langchain.retrievers import KNNRetriever

texts = [\
  "Caching embeddings enables the storage or temporary caching of embeddings, eliminating the necessity to recompute them each time.",\
  "The agent executor is the runtime for an agent. This is what actually calls the agent and executes the actions it chooses",\
  "A Runnable represents a generic unit of work that can be invoked, batched, streamed, and/or transformed."\
]

embeddings = VoyageEmbeddings(model="voyage-01", batch_size=8)
retriever = KNNRetriever.from_texts(texts, embeddings, k=1)

result = retriever.get_relevant_documents(
  "How do I build an agent?"
)
print(result[0].page_content)
```

```python
from langchain.embeddings import VoyageEmbeddings
from langchain.retrievers import KNNRetriever

texts = [\
  "Caching embeddings enables the storage or temporary caching of embeddings, eliminating the necessity to recompute them each time.",\
  "The agent executor is the runtime for an agent. This is what actually calls the agent and executes the actions it chooses",\
  "A Runnable represents a generic unit of work that can be invoked, batched, streamed, and/or transformed."\
]

embeddings = VoyageEmbeddings(model="voyage-01", batch_size=8)
retriever = KNNRetriever.from_texts(texts, embeddings, k=1)

result = retriever.get_relevant_documents(
  "How do I build an agent?"
)
print(result[0].page_content)
```

```output
The agent executor is the runtime for an agent. This is what actually calls the agent and executes the actions it chooses
```

```output
代理执行器（agent executor）是代理（agent）的运行时环境，它实际调用代理并执行其所选择的操作。
```

You can find the full [LangChain integration docs](https://python.langchain.com/docs/integrations/text_embedding/voyageai?ref=blog.langchain.com) [here](https://python.langchain.com/docs/integrations/text_embedding/voyageai?ref=blog.langchain.com) and the [Voyage docs here](http://docs.voyageai.com/?ref=blog.langchain.com).

完整版 [LangChain 集成文档](https://python.langchain.com/docs/integrations/text_embedding/voyageai?ref=blog.langchain.com) [请点击此处](https://python.langchain.com/docs/integrations/text_embedding/voyageai?ref=blog.langchain.com)，[Voyage 官方文档](http://docs.voyageai.com/?ref=blog.langchain.com) 请参见此处。

## Takeaways

## 要点总结

The retrieval quality of the embedding models is highly correlated with the quality of the final responses — to make your RAG more successful, you should consider improving your embeddings!

嵌入模型的检索质量与最终响应的质量高度相关——若想让您的 RAG 更加成功，就应考虑提升嵌入效果！

Try Voyage embeddings `voyage-01` or contact us for early access to the fine-tuned models at [contact@voyageai.com](mailto:contact@voyagei.com).

请尝试使用 Voyage 嵌入模型 `voyage-01`，或通过 [contact@voyageai.com](mailto:contact@voyagei.com) 联系我们，申请提前体验微调后的模型。

Follow up on [twitter](https://twitter.com/voyage_ai_?ref=blog.langchain.com) and/or [linkedin](https://www.linkedin.com/company/voyageai?ref=blog.langchain.com) for more updates!

欢迎关注 [Twitter](https://twitter.com/voyage_ai_?ref=blog.langchain.com) 和/或 [LinkedIn](https://www.linkedin.com/company/voyageai?ref=blog.langchain.com)，获取更多最新动态！
{% endraw %}
