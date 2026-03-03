---
title: "Applying OpenAI's RAG Strategies"
source: "LangChain Blog"
url: "https://blog.langchain.com/applying-openai-rag/"
date: "2024-03-14"
scraped_at: "2026-03-03T08:08:36.798946186+00:00"
language: "en-zh"
translated: true
tags: ["![Extraction Benchmarking", "**Extraction Benchmarking**", "**The Prompt Landscape**", "![Building Chat LangChain", "**Building Chat LangChain**"]
---

## Context

## 背景

在 OpenAI 的 Demo Day 上，他们[报告](https://www.youtube.com/watch?v=ahnGLM-RC1Y&ref=blog.langchain.com#t=16m8s)了一系列与某客户合作开展的 RAG 实验。尽管评估指标取决于您的具体应用场景，但了解哪些方法奏效、哪些未达预期仍颇具启发性。下文我们将逐一展开介绍每种方法，并说明您如何在自己的应用中实现它们。深入理解这些方法并将其适配到您自身的应用中至关重要：通过与众多合作伙伴及用户交流我们发现，不存在“放之四海而皆准”的通用方案——因为不同问题需要不同的检索技术。

![](https://lh7-us.googleusercontent.com/VfU_vZaRh5fXVXdWtuQvUaBuAZOY8y0LRZwhuqI0HjdH5o65mokzrii_tyU97iGvzOYa4kBExEeEhsZ8otWmnS3wjZCTk3exh-oHPavgMY6w53G946pT-evU7H-m4CWBQFLD-TnvZOw0AOe2OHqvQAk)

## How these fit into the RAG stack

## 这些方法在 RAG 架构中的定位

首先，我们可以将上述方法归类到若干 RAG 类别中。下图展示了每项 RAG 实验所属的类别，并将其置于整体 RAG 架构中的对应位置：

![](images/applying-openai_s-rag-strategies/img_002.png)

### Baseline

### 基线方法（Baseline）

基于距离的向量数据库检索，是将查询（query）嵌入（即表示）为高维空间中的向量，并依据“距离”度量来查找语义相近的文档向量。OpenAI 在该研究中采用的基线检索方法为余弦相似度（cosine similarity）。LangChain 提供了[超过 60 种](https://integrations.langchain.com/vectorstores?ref=blog.langchain.com)向量数据库集成，其中许多支持自定义相似性搜索所用的距离函数。关于各类距离度量的实用博客文章，可参考 [Weaviate](https://weaviate.io/blog/distance-metrics-in-vector-search?ref=blog.langchain.com) 和 [Pinecone](https://www.pinecone.io/learn/vector-similarity/?ref=blog.langchain.com) 的相关分享。

### Query Transformations

### 查询变换（Query Transformations）

然而，由于查询措辞的细微变化，或因嵌入未能充分捕捉数据语义，检索结果可能产生显著差异。查询变换是一类旨在修改用户原始输入以提升检索效果的技术方法。有关该主题的最新博文，请参见[此处](https://blog.langchain.com/query-transformations/)。

**OpenAI reported two methods, which you can try**:

**OpenAI 报告了两种方法，您可以尝试**：

- **Query expansion**: LangChain’s [Multi-query retriever](https://python.langchain.com/docs/modules/data_connection/retrievers/MultiQueryRetriever?ref=blog.langchain.com) achieves query expansion using an LLM to generate multiple queries from different perspectives for a given user input query. For each query, it retrieves a set of relevant documents and takes the unique union across all queries.

- **查询扩展（Query Expansion）**：LangChain 的 [Multi-query retriever（多查询检索器）](https://python.langchain.com/docs/modules/data_connection/retrievers/MultiQueryRetriever?ref=blog.langchain.com) 利用大语言模型（LLM）对用户输入的原始查询从多个角度生成多个变体查询，从而实现查询扩展。针对每个生成的查询，系统分别检索一组相关文档，并最终取所有查询结果的去重并集。

- **HyDE**: LangChain’s [HyDE](https://python.langchain.com/docs/templates/hyde?ref=blog.langchain.com) (Hypothetical Document Embeddings) retriever generates hypothetical documents for an incoming query, embeds them, and uses them in retrieval (see [paper](https://arxiv.org/abs/2212.10496?ref=blog.langchain.com)). The idea is that these simulated documents may have more similarity to the desired source documents than the question.

- **HyDE（假设性文档嵌入）**：LangChain 的 [HyDE](https://python.langchain.com/docs/templates/hyde?ref=blog.langchain.com)（Hypothetical Document Embeddings）检索器会为输入查询生成一份“假设性文档”，对其执行嵌入（embedding），再将该嵌入用于后续检索（参见 [论文](https://arxiv.org/abs/2212.10496?ref=blog.langchain.com)）。其核心思想是：这类人工构造的假设性文档，可能比原始问题本身与目标源文档具有更高的语义相似性。

**Other ideas to consider**:

**其他值得考虑的方法**：

- **Step back prompting**: For reasoning tasks, this [paper](https://arxiv.org/pdf/2310.06117.pdf?ref=blog.langchain.dev) shows that a step-back question can be used to ground an answer synthesis in higher-level concepts or principles. For example, a question about physics can be abstracted into a question and answer about the physical principles behind the user query. The final answer can be derived from the input question as well as the step-back answer. The this [blog post](https://cobusgreyling.medium.com/a-new-prompt-engineering-technique-has-been-introduced-called-step-back-prompting-b00e8954cacb?ref=blog.langchain.com) and the [LangChain implementation](https://github.com/langchain-ai/langchain/blob/master/cookbook/stepback-qa.ipynb?ref=blog.langchain.dev) to learn more.

- **“后退一步”提示（Step-back Prompting）**：针对推理类任务，这篇 [论文](https://arxiv.org/pdf/2310.06117.pdf?ref=blog.langchain.dev) 表明，可通过提出一个更高层次的“后退一步”式问题，将答案合成锚定在更抽象的概念或原理层面。例如，一个关于具体物理现象的问题，可被抽象为对该现象背后物理原理的提问与回答。最终答案可同时结合原始问题和“后退一步”所得的答案共同推导得出。更多细节请参阅这篇 [博客文章](https://cobusgreyling.medium.com/a-new-prompt-engineering-technique-has-been-introduced-called-step-back-prompting-b00e8954cacb?ref=blog.langchain.com) 及其 [LangChain 实现示例](https://github.com/langchain-ai/langchain/blob/master/cookbook/stepback-qa.ipynb?ref=blog.langchain.dev)。

- **Rewrite-Retrieve-Read**: This [paper](https://arxiv.org/pdf/2305.14283.pdf?ref=blog.langchain.dev) re-writes user questions in order to improve retrieval. See the [LangChain implementation](https://github.com/langchain-ai/langchain/blob/master/cookbook/rewrite.ipynb?ref=blog.langchain.dev) to learn more.

- **重写–检索–阅读（Rewrite-Retrieve-Read）**：这篇 [论文](https://arxiv.org/pdf/2305.14283.pdf?ref=blog.langchain.dev) 提出通过重写用户提问来提升检索效果。更多详情请参阅 [LangChain 的实现示例](https://github.com/langchain-ai/langchain/blob/master/cookbook/rewrite.ipynb?ref=blog.langchain.dev)。

### Routing

### 路由（Routing）

When querying across multiple datastores, routing questions to the appropriate source become critical. The OpenAI presentation reported that they needed to route question between two vectorstores and single SQL database. LangChain has [support for routing](https://python.langchain.com/docs/expression_language/how_to/routing?ref=blog.langchain.com) using an LLM to gate user-input into a set of defined sub-chains, which - as in this case - could be different vectorstores.

当跨多个数据存储源进行查询时，将问题精准路由至最合适的源至关重要。OpenAI 在其分享中提到，他们需将问题在两个向量数据库（vectorstore）与一个 SQL 数据库之间进行路由。LangChain 提供了基于大语言模型（LLM）的 [路由支持](https://python.langchain.com/docs/expression_language/how_to/routing?ref=blog.langchain.com)，可将用户输入智能分发至一组预定义的子链（sub-chain）——正如本例所示，这些子链可分别对应不同的向量数据库。

### Query Construction

### 查询构建（Query Construction）

Because one of the datasources mentioned in the OpenAI study is a relational (SQL) database, valid SQL needed to be generated from the user input in order to extract the necessary information. LangChain has support for [text-to-sql](https://blog.langchain.com/llms-and-sql/), which is reviewed in depth in our recent [recent blog](https://blog.langchain.com/query-construction/) focused on query construction.

由于 OpenAI 研究中提及的数据源之一是关系型（SQL）数据库，因此必须从用户输入中生成合法、有效的 SQL 语句，才能提取所需信息。LangChain 支持 [文本到 SQL（text-to-SQL）](https://blog.langchain.com/llms-and-sql/) 功能，我们近期发布的 [专题博客](https://blog.langchain.com/query-construction/) 对查询构建（query construction）技术进行了深入探讨。

**Other ideas to consider**:

**其他值得考虑的方法**：

- [Text-to-metadata filter](https://python.langchain.com/docs/modules/data_connection/retrievers/self_query/?ref=blog.langchain.dev#constructing-from-scratch-with-lcel) for vectorstores

- 面向向量数据库的 [文本到元数据过滤器（Text-to-metadata filter）](https://python.langchain.com/docs/modules/data_connection/retrievers/self_query/?ref=blog.langchain.dev#constructing-from-scratch-with-lcel)

- [Text-to-Cypher](https://python.langchain.com/docs/use_cases/graph/graph_cypher_qa?ref=blog.langchain.dev) for graph databases

- 面向图数据库的 [文本到 Cypher（Text-to-Cypher）](https://python.langchain.com/docs/use_cases/graph/graph_cypher_qa?ref=blog.langchain.dev)

- [Text-to-SQL+semantic](https://github.com/langchain-ai/langchain/blob/master/cookbook/retrieval_in_sql.ipynb?ref=blog.langchain.dev) for semi-structured data in [Postgres with Pgvector](https://supabase.com/docs/guides/database/extensions/pgvector?ref=blog.langchain.com)

- 面向 [Postgres + Pgvector](https://supabase.com/docs/guides/database/extensions/pgvector?ref=blog.langchain.com) 中半结构化数据的 [文本到 SQL + 语义检索（Text-to-SQL+semantic）](https://github.com/langchain-ai/langchain/blob/master/cookbook/retrieval_in_sql.ipynb?ref=blog.langchain.dev)

![](images/applying-openai_s-rag-strategies/img_003.png)

### Building the Index

### 构建索引

OpenAI reported an notable boost in performance simply from experimenting with the chunk size during document embedding. Because this is a central step in index building, we have an [open source](https://github.com/langchain-ai/text-split-explorer?ref=blog.langchain.com) [Streamlit app](https://x.com/hwchase17/status/1689015952623771648?s=20&ref=blog.langchain.com) where you can test chunk sizes.

OpenAI 仅通过调整文档嵌入时的分块（chunk）大小，就观察到性能显著提升。由于这是构建索引的核心步骤之一，我们提供了一个开源的 [Streamlit 应用](https://github.com/langchain-ai/text-split-explorer?ref=blog.langchain.com)，您可借此测试不同分块尺寸的效果。

While they did not report a considerable boost in performance from embedding fine-tuning, [favorable results](https://www.glean.com/blog/how-to-build-an-ai-assistant-for-the-enterprise?ref=blog.langchain.com) have been reported. While OpenAI notes that this is probably not advised as "low-hanging-fruit", we have shared [guides for fine-tuning](https://blog.langchain.com/using-langsmith-to-support-fine-tuning-of-open-source-llms/) and there are some [very](https://huggingface.co/blog/getting-started-with-embeddings?ref=blog.langchain.com) [good](https://huggingface.co/blog/how-to-train-sentence-transformers?ref=blog.langchain.com) tutorials from HuggingFace that go deeper on this.

尽管 OpenAI 并未报告嵌入模型微调（embedding fine-tuning）能带来显著的性能提升，但已有其他团队报告了[积极成果](https://www.glean.com/blog/how-to-build-an-ai-assistant-for-the-enterprise?ref=blog.langchain.com)。OpenAI 指出，该方法可能并非典型的“低垂果实”（low-hanging fruit），即投入产出比未必最优；不过，我们已分享了[嵌入微调指南](https://blog.langchain.com/using-langsmith-to-support-fine-tuning-of-open-source-llms/)，HuggingFace 也提供了若干深入浅出的优质教程：[嵌入入门](https://huggingface.co/blog/getting-started-with-embeddings?ref=blog.langchain.com) 和 [如何训练 Sentence Transformers 模型](https://huggingface.co/blog/how-to-train-sentence-transformers?ref=blog.langchain.com)。

### Post-Processing

### 后处理

Processing documents following retrieval, but prior to LLM ingestion, is an important strategy for many applications. We can use post-processing to enforce diversity or recency among our retrieved documents, which can be especially important when we are pooling documents from multiple sources.

在检索完成之后、送入大语言模型（LLM）之前对文档进行处理，是许多应用中的关键策略。我们可通过后处理机制，主动保障所检索文档的多样性或时效性——当文档来源广泛、跨多个异构渠道时，这一点尤为关键。

**OpenAI reported two methods**:

**OpenAI 报告了两种方法**：

- **Re-rank**: LangChain’s integration with the [Cohere ReRank](https://python.langchain.com/docs/integrations/retrievers/cohere-reranker?ref=blog.langchain.com) endpoint is one approach, which can be used for document compression (reduce redundancy) in cases where we are retrieving a large number of documents. Relatedly, RAG-fusion uses reciprocal rank fusion (see [blog](https://towardsdatascience.com/forget-rag-the-future-is-rag-fusion-1147298d8ad1?ref=blog.langchain.com) and [implementation](https://github.com/langchain-ai/langchain/blob/master/cookbook/rag_fusion.ipynb?ref=blog.langchain.dev)) to ReRank documents returned from a retriever similar to [multi-query](https://github.com/langchain-ai/langchain/blob/master/cookbook/rag_fusion.ipynb?ref=blog.langchain.dev) (discussed above).

- **重排序（Re-rank）**：LangChain 集成了 [Cohere ReRank](https://python.langchain.com/docs/integrations/retrievers/cohere-reranker?ref=blog.langchain.com) 接口，这是一种可行方案，尤其适用于需返回大量文档的场景，可用于文档压缩（即降低冗余度）。与此相关的是 RAG-Fusion 方法，它采用互惠秩融合（Reciprocal Rank Fusion，RRF）对检索器返回的文档进行重排序（参见 [技术博客](https://towardsdatascience.com/forget-rag-the-future-is-rag-fusion-1147298d8ad1?ref=blog.langchain.com) 及 [实现示例](https://github.com/langchain-ai/langchain/blob/master/cookbook/rag_fusion.ipynb?ref=blog.langchain.dev)），其思想与前述的 [多查询（multi-query）](https://github.com/langchain-ai/langchain/blob/master/cookbook/rag_fusion.ipynb?ref=blog.langchain.dev) 策略类似。

- **Classification**: OpenAI classified each retrieved document based upon its content and then chose a different prompt depending on the classification. This marries two ideas: LangChain supports [tagging](https://python.langchain.com/docs/modules/chains/how_to/openai_functions?ref=blog.langchain.com) [of](https://github.com/langchain-ai/langchain/tree/master/templates/extraction-openai-functions?ref=blog.langchain.com) [text](https://python.langchain.com/docs/modules/chains/how_to/openai_functions?ref=blog.langchain.com) (e.g., using function calling to enforce the output schema) for classification. As mentioned above, [logical routing](https://python.langchain.com/docs/expression_language/how_to/routing?ref=blog.langchain.com) can also be used to route based on a tag (or include the process of semantic tagging in the logical routing chain itself).

- **分类（Classification）**：OpenAI 根据每篇检索所得文档的内容对其进行分类，并依据分类结果选择不同的提示词（prompt）。这一做法融合了两个重要理念：一方面，LangChain 支持对文本进行[标注（tagging）](https://python.langchain.com/docs/modules/chains/how_to/openai_functions?ref=blog.langchain.com)（例如，利用 OpenAI 函数调用能力强制输出符合预定义结构的分类标签）；另一方面，如前所述，[逻辑路由（logical routing）](https://python.langchain.com/docs/expression_language/how_to/routing?ref=blog.langchain.com) 也可基于标签实现动态分支，甚至可将语义标注过程本身嵌入逻辑路由链中。

**Other ideas to consider**:

**其他值得考虑的方法**：

- **MMR**: To balance between relevance and diversity, many vectorstores offer [max-marginal-relevance](https://t.co/dUKfHdPy46?ref=blog.langchain.com) [search](https://python.langchain.com/docs/integrations/vectorstores/pinecone?ref=blog.langchain.com#maximal-marginal-relevance-searches) (see blog post [here](https://medium.com/tech-that-works/maximal-marginal-relevance-to-rerank-results-in-unsupervised-keyphrase-extraction-22d95015c7c5?ref=blog.langchain.com)).

- **最大边际相关性（MMR）**：为兼顾检索结果的相关性与多样性，多数向量数据库均支持 [最大边际相关性（Max-Marginal-Relevance, MMR）搜索](https://t.co/dUKfHdPy46?ref=blog.langchain.com)（参见 [Pinecone 文档](https://python.langchain.com/docs/integrations/vectorstores/pinecone?ref=blog.langchain.com#maximal-marginal-relevance-searches) 及 [技术博客](https://medium.com/tech-that-works/maximal-marginal-relevance-to-rerank-results-in-unsupervised-keyphrase-extraction-22d95015c7c5?ref=blog.langchain.com)）。

- **Clustering**: Some approaches have used [clustering](https://python.langchain.com/docs/integrations/retrievers/merger_retriever?ref=blog.langchain.com) of embedded documents with sampling, which may be helpful in cases where we are consolidating documents across a wide range sources.

- **聚类（Clustering）**：部分方法尝试对嵌入后的文档进行[聚类分析](https://python.langchain.com/docs/integrations/retrievers/merger_retriever?ref=blog.langchain.com)，并辅以抽样策略，这在需整合来自大量异构信源的文档时尤为有效。

![Image](images/applying-openai_s-rag-strategies/img_004.jpg)

## Conclusion

## 结论

It's instructive to see what OpenAI has tried on the topic of RAG. The approaches can be reproduced in your own hands as shown above: trying different methods is crucial because application performance can vary widely on the RAG setup.

看到 OpenAI 在 RAG（检索增强生成）这一主题上所作的探索，颇具启发意义。如上文所示，这些方法均可由你亲自复现：尝试不同方法至关重要，因为应用在 RAG 架构下的性能表现可能差异极大。

However, the OpenAI results also show that evaluation is critically important to avoid wasted time and effort on approaches that yield little or no benefit. For RAG evaluation, [LangSmith](https://docs.smith.langchain.com/evaluation/evaluator-implementations?ref=blog.langchain.com) offers a great deal of support: for example, [here](https://github.com/langchain-ai/langchain/blob/master/cookbook/advanced_rag_eval.ipynb?ref=blog.langchain.com) is a cookbook using LangSmith to evaluate several advanced RAG chains.

然而，OpenAI 的实验结果也表明：评估环节至关重要——否则极易将大量时间与精力耗费在收效甚微甚至毫无价值的方法上。针对 RAG 的评估，[LangSmith](https://docs.smith.langchain.com/evaluation/evaluator-implementations?ref=blog.langchain.com) 提供了极为丰富的支持：例如，[此处](https://github.com/langchain-ai/langchain/blob/master/cookbook/advanced_rag_eval.ipynb?ref=blog.langchain.com) 是一份使用 LangSmith 评估多种高级 RAG 链的实用指南（cookbook）。

### Tags

### 标签

[![Extraction Benchmarking](images/applying-openai_s-rag-strategies/img_005.jpg)](https://blog.langchain.com/extraction-benchmarking/)

[**Extraction Benchmarking**](https://blog.langchain.com/extraction-benchmarking/)

[![LangServe Playground and Configurability](images/applying-openai_s-rag-strategies/img_006.png)](https://blog.langchain.com/langserve-playground-and-configurability/)

[**LangServe Playground and Configurability**](https://blog.langchain.com/langserve-playground-and-configurability/)

[![A Chunk by Any Other Name: Structured Text Splitting and Metadata-enhanced RAG](images/applying-openai_s-rag-strategies/img_007.png)](https://blog.langchain.com/a-chunk-by-any-other-name/)

[![换个名字还叫“块”？——结构化文本切分与元数据增强的 RAG](images/applying-openai_s-rag-strategies/img_007.png)](https://blog.langchain.com/a-chunk-by-any-other-name/)

[**A Chunk by Any Other Name: Structured Text Splitting and Metadata-enhanced RAG**](https://blog.langchain.com/a-chunk-by-any-other-name/)

[**换个名字还叫“块”？——结构化文本切分与元数据增强的 RAG**](https://blog.langchain.com/a-chunk-by-any-other-name/)

[**The Prompt Landscape**](https://blog.langchain.com/the-prompt-landscape/)

[**提示工程全景图**](https://blog.langchain.com/the-prompt-landscape/)

[![Building Chat LangChain](images/applying-openai_s-rag-strategies/img_008.png)](https://blog.langchain.com/building-chat-langchain-2/)

[![构建 Chat LangChain](images/applying-openai_s-rag-strategies/img_008.png)](https://blog.langchain.com/building-chat-langchain-2/)

[**Building Chat LangChain**](https://blog.langchain.com/building-chat-langchain-2/)

[**构建 Chat LangChain**](https://blog.langchain.com/building-chat-langchain-2/)