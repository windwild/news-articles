---
title: "Auto-Evaluation of Anthropic 100k Context Window"
source: "LangChain Blog"
url: "https://blog.langchain.com/auto-evaluation-of-anthropic-100k-context-window/"
date: "2023-08-18"
scraped_at: "2026-03-03T09:02:18.324677043+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
{% raw %}

[Lance Martin](https://twitter.com/RLanceMartin?ref=blog.langchain.com)

[兰斯·马丁](https://twitter.com/RLanceMartin?ref=blog.langchain.com)

### Retrieval Architectures

### 检索架构

LLM question answering (Q+A) typically involves **retrieval** of documents relevant to the question followed by **synthesis** of the retrieved chunks into an answer by an LLM.  In practice, the retrieval step is necessary because the LLM context window is limited relative to the size of most text corpus of interest (e.g., LLM context windows range from ~2k-4k tokens for many models and [up 8k-32k for GPT4](https://www.reddit.com/r/ChatGPT/comments/125fi1h/gpt4_context_window_and_token_limit/?ref=blog.langchain.com)). Anthropic [recently released](https://www.anthropic.com/index/100k-context-windows?ref=blog.langchain.com) a Claude model with a 100k token context window.  With the advent of models with larger context windows, it is reasonable to wonder whether the document retrieval stage is necessary for many Q+A or chat use-cases.

大语言模型（LLM）问答（Q+A）通常包含两个阶段：首先**检索**与问题相关的文档，再由 LLM 对检索出的文本片段进行**综合生成**，从而得出答案。实践中，检索环节必不可少，因为 LLM 的上下文窗口容量相对于大多数目标文本语料库而言十分有限（例如，许多模型的上下文窗口约为 2k–4k 个 token；而 GPT-4 的上下文窗口则可达 [8k–32k 个 token](https://www.reddit.com/r/ChatGPT/comments/125fi1h/gpt4_context_window_and_token_limit/?ref=blog.langchain.com)）。Anthropic 公司[最近发布](https://www.anthropic.com/index/100k-context-windows?ref=blog.langchain.com)了一款支持 100k token 上下文窗口的 Claude 模型。随着更大上下文窗口模型的出现，人们自然会思考：在许多问答或聊天应用场景中，是否仍需依赖文档检索这一环节？

Here’s a taxonomy of retriever architectures with this retriever-less option highlighted:

以下是一种检索器架构分类法，其中特别标出了“无需检索器”（retriever-less）这一选项：

- **Lexical / Statistical**: [TF-IDF](https://towardsdatascience.com/tf-idf-explained-and-python-sklearn-implementation-b020c5e83275?ref=blog.langchain.com), [Elastic](https://www.elastic.co/what-is/elasticsearch?ref=blog.langchain.com), etc  
- **词法 / 统计型**：[TF-IDF](https://towardsdatascience.com/tf-idf-explained-and-python-sklearn-implementation-b020c5e83275?ref=blog.langchain.com)、[Elasticsearch](https://www.elastic.co/what-is/elasticsearch?ref=blog.langchain.com) 等  

- **Semantic**: [Pinecone](https://support.pinecone.io/hc/en-us/articles/9500075821981-Differences-between-Lexical-and-Semantic-Search-regarding-relevancy?ref=blog.langchain.com), [Chroma](https://www.trychroma.com/?ref=blog.langchain.com), etc  
- **语义型**：[Pinecone](https://support.pinecone.io/hc/en-us/articles/9500075821981-Differences-between-Lexical-and-Semantic-Search-regarding-relevancy?ref=blog.langchain.com)、[Chroma](https://www.trychroma.com/?ref=blog.langchain.com) 等  

- **Semantic with metadata filtering**: [Pinecone](https://docs.pinecone.io/docs/metadata-filtering?ref=blog.langchain.com), etc with filtering tools ( [self-querying](https://python.langchain.com/docs/modules/data_connection/retrievers/how_to/self_query/?ref=blog.langchain.com), [kor](https://github.com/eyurtsev/kor?ref=blog.langchain.com), etc)  
- **带元数据过滤的语义检索**：[Pinecone](https://docs.pinecone.io/docs/metadata-filtering?ref=blog.langchain.com) 等，配合过滤工具（如 [自查询（self-querying）](https://python.langchain.com/docs/modules/data_connection/retrievers/how_to/self_query/?ref=blog.langchain.com)、[KOR](https://github.com/eyurtsev/kor?ref=blog.langchain.com) 等）  

- **kNN on document summaries**: [Llama-Index](https://www.google.com/url?q=https://medium.com/llamaindex-blog/a-new-document-summary-index-for-llm-powered-qa-systems-9a32ece2f9ec&sa=D&source=editors&ust=1683909530941725&usg=AOvVaw2Sonxx4fbHJe7EnvuxOrPi), etc  
- **基于文档摘要的 k 近邻（kNN）检索**：[Llama-Index](https://www.google.com/url?q=https://medium.com/llamaindex-blog/a-new-document-summary-index-for-llm-powered-qa-systems-9a32ece2f9ec&sa=D&source=editors&ust=1683909530941725&usg=AOvVaw2Sonxx4fbHJe7EnvuxOrPi) 等  

- **Post-processing**: [Cohere re-rank](https://txt.cohere.com/rerank/?ref=blog.langchain.com), etc  
- **后处理**：[Cohere 重排序（re-rank）](https://txt.cohere.com/rerank/?ref=blog.langchain.com) 等  

- **Retriever-less**: Anthropic [100k context](https://www.anthropic.com/index/100k-context-windows?ref=blog.langchain.com) window, etc  
- **无需检索器**：Anthropic [100k token 上下文窗口](https://www.anthropic.com/index/100k-context-windows?ref=blog.langchain.com) 等  

![](images/auto-evaluation-of-anthropic-100k-context-window/img_001.png)

![](images/auto-evaluation-of-anthropic-100k-context-window/img_001.png)

### Evaluation strategy

### 评估策略

We previously introduced [auto-evaluator](https://blog.langchain.com/auto-evaluator-opportunities/), a [hosted app](https://autoevaluator.langchain.com/playground?ref=blog.langchain.com) and [open-source](https://github.com/langchain-ai/auto-evaluator?ref=blog.langchain.com) repo for grading LLM question-answer chains. This provides an good testing ground for comparing Anthropic 100k for Q+A against other retrieval methods, such as kNN on a VectorDB, [SVMs](https://github.com/karpathy/randomfun/blob/master/knn_vs_svm.ipynb?ref=blog.langchain.com), etc.

我们此前已推出 [Auto-Evaluator](https://blog.langchain.com/auto-evaluator-opportunities/) —— 一款用于评估大语言模型问答链质量的[托管应用](https://autoevaluator.langchain.com/playground?ref=blog.langchain.com)及[开源仓库](https://github.com/langchain-ai/auto-evaluator?ref=blog.langchain.com)。这为对比评估 Anthropic 100k 在问答任务中的表现与其他检索方法（如基于向量数据库的 kNN 检索、[支持向量机（SVM）](https://github.com/karpathy/randomfun/blob/master/knn_vs_svm.ipynb?ref=blog.langchain.com) 等）提供了理想的测试平台。

### Results

### 实验结果

On a test set of 5 questions for the 75 page GPT3 paper ( [here](https://github.com/langchain-ai/auto-evaluator/tree/main/api/docs/gpt3?ref=blog.langchain.com)), we see that the `Anthropic 100k` model performs as well as `kNN (FAISS) + GPT3.5-Turbo`. Of course, this is impressive because the full pdf doc is simply passed to Anthropic 100k directly in the prompt. But, we can also see that this comes at the cost of latency (e.g., ~50s for `Anthropic 100k` vs < ~10s for others).

在针对 75 页《GPT-3 论文》所构建的含 5 个问题的测试集上（[详见此处](https://github.com/langchain-ai/auto-evaluator/tree/main/api/docs/gpt3?ref=blog.langchain.com)），我们发现 `Anthropic 100k` 模型的表现与 `kNN（FAISS）+ GPT-3.5-Turbo` 相当。这一结果令人印象深刻，因为整个 PDF 文档是直接作为提示（prompt）完整输入给 Anthropic 100k 的。但同时我们也观察到，该方案显著增加了响应延迟（例如，`Anthropic 100k` 耗时约 50 秒，而其他方法均低于约 10 秒）。

![](images/auto-evaluation-of-anthropic-100k-context-window/img_002.png)

我们还在一份长达 51 页的[旧金山建筑规范 PDF](https://www.notion.so/906c128e8d494c33a642667d12316473?ref=blog.langchain.com)上进行了测试，并提出一个特定的许可审批问题——该问题此前已在其他评估中使用过（参见[此处](https://www.notion.so/906c128e8d494c33a642667d12316473?ref=blog.langchain.com)）。在此测试中，`Anthropic 100k` 的表现逊于 SVM 和 kNN 检索器；详细结果请参见[此处](https://docs.google.com/spreadsheets/d/1zYZt0rmyKMUTySz-meEQGLy3uEGGUeCIonWqSzEm04o/edit?usp=sharing&ref=blog.langchain.com)。`Anthropic 100k` 给出了一个更为冗长、且接近正确但仍有偏差的答案（它指出：后院棚屋若面积超过 120 平方英尺则需申请许可；而正确阈值实为超过 100 平方英尺）。无检索器架构的一个明显缺陷是：我们无法检查被模型“检索”到的具体文本片段，因而难以诊断模型为何给出错误答案。

![](images/auto-evaluation-of-anthropic-100k-context-window/img_003.png)

### 亲自测试

我们已将 Anthropic 100k 部署至[我们的托管应用](https://autoevaluator.langchain.com/?ref=blog.langchain.com)，您可自行尝试，并将其性能与其他方法进行基准对比。更多细节请参阅我们的 [README](https://github.com/langchain-ai/auto-evaluator?ref=blog.langchain.com)，简要步骤如下：

- 添加您感兴趣的文档  
- 选择 `Anthropic-100k` 检索器  
- （可选）添加您自己的测试集（若您未提供，该应用将自动为您[生成一个](https://blog.langchain.com/auto-evaluator-opportunities/)）

![](images/auto-evaluation-of-anthropic-100k-context-window/img_004.png)

### 结论

无检索器架构因其简洁性，以及在我们尝试过的若干任务中展现出的优异性能，颇具吸引力。当然，也存在几点需要注意的局限：1）其延迟高于基于检索器的方法；2）许多实际应用场景（尤其是生产环境）所面对的语料库规模，仍远超 100k token 的上下文窗口容量。对于延迟要求不高、且语料库规模适中的应用场景（例如：在少量文档集合上进行问答），无检索器方法具有显著优势——尤其随着大语言模型上下文窗口持续扩大、推理速度不断提升，这一优势还将进一步增强。

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/auto-evaluation-of-anthropic-100k-context-window/img_005.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![深度智能体评估：我们的经验总结](images/auto-evaluation-of-anthropic-100k-context-window/img_005.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**深度智能体评估：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/auto-evaluation-of-anthropic-100k-context-window/img_006.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![LangSmith 正式支持端到端 OpenTelemetry](images/auto-evaluation-of-anthropic-100k-context-window/img_006.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**LangSmith 正式支持端到端 OpenTelemetry**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/auto-evaluation-of-anthropic-100k-context-window/img_007.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain《2024 年人工智能现状》报告](images/auto-evaluation-of-anthropic-100k-context-window/img_007.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain《2024 年人工智能现状》报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[![Introducing OpenTelemetry support for LangSmith](images/auto-evaluation-of-anthropic-100k-context-window/img_008.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/auto-evaluation-of-anthropic-100k-context-window/img_008.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![Easier evaluations with LangSmith SDK v0.2](images/auto-evaluation-of-anthropic-100k-context-window/img_009.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更简易的评估](images/auto-evaluation-of-anthropic-100k-context-window/img_009.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更简易的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/auto-evaluation-of-anthropic-100k-context-window/img_010.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph Platform 进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项](images/auto-evaluation-of-anthropic-100k-context-window/img_010.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform 进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)
{% endraw %}
