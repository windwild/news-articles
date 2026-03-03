---
title: "Analyzing User Interactions with LLMs to Improve our Documentation"
source: "LangChain Blog"
url: "https://blog.langchain.com/llms-to-improve-documentation/"
date: "2023-08-18"
scraped_at: "2026-03-03T09:02:40.357099706+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---

### Introduction

### 简介

We're strongly committed to consistently enhancing our [documentation](https://python.langchain.com/docs/get_started/introduction.html?ref=blog.langchain.com) and its navigability. Using [Mendable](https://www.mendable.ai/?ref=blog.langchain.com), a AI-enabled chat application, users can search our documentation using keywords or questions. Over time, Mendable has collected a large dataset of questions that highlights areas for documentation improvement.

我们始终致力于持续改进我们的[文档](https://python.langchain.com/docs/get_started/introduction.html?ref=blog.langchain.com)，并提升其可导航性。借助 AI 驱动的聊天应用 [Mendable](https://www.mendable.ai/?ref=blog.langchain.com)，用户可通过关键词或自然语言问题搜索我们的文档。随着时间推移，Mendable 已积累了大量用户提问数据，这些数据清晰揭示了当前文档中亟待完善的部分。

### Challenge

### 挑战

Distilling common themes from tens of thousands of questions per month is a significant challenge. Manual labeling can be effective, but is slow and laborious. [Statistical methods](https://en.wikipedia.org/wiki/Latent_Dirichlet_allocation?ref=blog.langchain.com) can analyze word distributions to infer common topics, but may not capture the semantic richness and context of the questions.

每月从数以万计的用户提问中提炼共性主题是一项重大挑战。人工标注虽有效，但速度慢、工作量大；而[统计方法](https://en.wikipedia.org/wiki/Latent_Dirichlet_allocation?ref=blog.langchain.com)（例如潜在狄利克雷分配）可通过分析词频分布推断常见主题，却往往难以充分捕捉问题背后的语义深度与上下文信息。

### Proposal

### 方案构想

LLMs can help us [summarize](https://www.youtube.com/watch?v=qaPMdcCqtWk&ref=blog.langchain.com)  and identify documentation gaps from the questions collected by [Mendable](https://www.mendable.ai/?ref=blog.langchain.com). We experimented with two methods to pass large question datasets to an LLM: 1) Group similar questions via clustering before summarizing each group and 2) Apply a map-reduce approach that splits questions into small segments, summarizes each, and then combines them into a final synthesis.

大语言模型（LLM）可协助我们[汇总分析](https://www.youtube.com/watch?v=qaPMdcCqtWk&ref=blog.langchain.com)由 [Mendable](https://www.mendable.ai/?ref=blog.langchain.com) 收集的用户提问，并识别文档中的知识缺口。我们尝试了两种将大规模提问数据集输入 LLM 的方法：  
1) 先通过聚类将相似问题分组，再对每组分别生成摘要；  
2) 采用“映射-归约”（map-reduce）方式，先将问题切分为小片段并逐个摘要，再将各摘要整合为最终的综合结论。

![](https://blog.langchain.com/content/images/2023/07/summary.png)Approaches for summarizing large datasets of user questions

![](https://blog.langchain.com/content/images/2023/07/summary.png)面向大规模用户提问数据集的摘要方法

There are tradeoffs between the approaches, which we wanted to examine:

两种方法各有权衡，我们希望深入考察其差异：

![](images/analyzing-user-interactions-with-llms-to-improve-our-documentation/img_002.png)Trade-offs between clustering and map-reduce

![](images/analyzing-user-interactions-with-llms-to-improve-our-documentation/img_002.png)聚类法与映射-归约法的权衡对比

### Results

### 结果

We tested an end-to-end LLM summarization pipeline that uses [LangChain’s map-reduce chain](https://python.langchain.com/docs/modules/chains/popular/summarize?ref=blog.langchain.com) to split questions into groups based on the context window of either [GPT-3.5-16k](https://openai.com/blog/function-calling-and-other-api-updates?ref=blog.langchain.com) (16k tokens) or [Claude-2](https://www.anthropic.com/index/claude-2?ref=blog.langchain.com) (100k tokens), summarize each (map), and then distill the group summaries into a final synthesis (reduce).

我们测试了一条端到端的 LLM 摘要流水线，该流水线采用 [LangChain 的 map-reduce 链](https://python.langchain.com/docs/modules/chains/popular/summarize?ref=blog.langchain.com)，依据 [GPT-3.5-16k](https://openai.com/blog/function-calling-and-other-api-updates?ref=blog.langchain.com)（16k token）或 [Claude-2](https://www.anthropic.com/index/claude-2?ref=blog.langchain.com)（100k token）的上下文窗口，将用户提问分组；随后对每组分别进行摘要（map），再将各组摘要进一步提炼为最终综合摘要（reduce）。

We also tested [k-Means clustering](https://en.wikipedia.org/wiki/K-means_clustering?ref=blog.langchain.com) of embedded questions followed by [GPT-4](https://openai.com/research/gpt-4?ref=blog.langchain.com) to summarize each cluster, an approach [similar to what OpenAI](https://github.com/openai/openai-cookbook/blob/main/examples/Clustering.ipynb?ref=blog.langchain.com) reported in one of their cookbooks. For consistency, we use the same input dataset as map-reduce.

我们还测试了对嵌入后的提问进行 [k-Means 聚类](https://en.wikipedia.org/wiki/K-means_clustering?ref=blog.langchain.com)，再使用 [GPT-4](https://openai.com/research/gpt-4?ref=blog.langchain.com) 对每个聚类分别生成摘要的方法——该方法与 OpenAI 在其某本 [Cookbook 示例](https://github.com/openai/openai-cookbook/blob/main/examples/Clustering.ipynb?ref=blog.langchain.com) 中所报告的方案类似。为确保可比性，我们对 k-Means 方法也采用了与 map-reduce 相同的输入数据集。

We open sourced the notebooks and the data (see repo [here](https://github.com/mendableai/QA_clustering?ref=blog.langchain.com)) so that this analysis can be reproduced. [Here](https://docs.google.com/spreadsheets/d/1z-LakOhgP7Oskf29Q3nmud0e6fQqjraSAmFrvI_5UGM/edit?usp=sharing&ref=blog.langchain.com) is a sheet with detailed results, which we summarize in the table below; we asked both methods to summarize the major question themes being asked by users with a proportion of questions that fall into each bucket:

我们已将相关 Jupyter Notebook 和全部数据开源（代码仓库见 [此处](https://github.com/mendableai/QA_clustering?ref=blog.langchain.com)），以便复现本分析。[此处](https://docs.google.com/spreadsheets/d/1z-LakOhgP7Oskf29Q3nmud0e6fQqjraSAmFrvI_5UGM/edit?usp=sharing&ref=blog.langchain.com) 是一份包含完整实验结果的电子表格；下表为我们对两套方法输出结果的汇总：二者均被要求归纳用户提问的主要主题，并统计落入各主题的问题比例：

![](images/analyzing-user-interactions-with-llms-to-improve-our-documentation/img_003.png)Distribution of question themes summarized in different experiments

![](images/analyzing-user-interactions-with-llms-to-improve-our-documentation/img_003.png)不同实验中归纳出的问题主题分布

Specific themes can be interrogated using alternative summarization prompts; for example, using map-reduce was can ask the reduce stage to return top questions on a specific theme (e.g., data processing). For example, using this reduce prompt:

针对特定主题，可通过定制化的摘要提示词进行深入探查；例如，在 map-reduce 流程中，我们可在 reduce 阶段指定返回某一主题（如“数据处理”）下的高频问题。例如，使用如下 reduce 提示词：

```
The following is a list of summaries for questions entered into a Q+A system:
{question_summaries}

Take these and distill it into a final, consolidated list with:
(1) the top 10 question related to loading, processing, and manipulating different types of data and documents.
(2) estimate the proportion of each question
```

```
以下是用户在问答系统中提出的若干问题摘要：
{question_summaries}

请据此提炼出一份最终、整合后的清单，包含：
(1) 与加载、处理及操作各类数据和文档最相关的前 10 个问题；
(2) 估算每个问题在原始数据中所占的比例。
```

We get granular thematic breakdown of the Top 10 Questions Related to Loading, Processing, and Manipulating Different Types of Data and Documents:

我们由此获得了“加载、处理及操作各类数据和文档”这一主题下前 10 大高频问题的细粒度主题分解结果：

```
1. "How can I load a PDF file and split it into chunks using langchain?" - 15%`
2. "How do I load and process a CSV file using Langchain?" - 12%
3. "How do I use the 'readfiletool' to load a text file?" - 11%
4. "How do I use Langchain to summarize a PDF document using the LLM model?" - 10%
5. "What are the different data loaders available in Langchain, and how do I choose the right one for my use case?" - 9%
6. "How do I load and process multiple PDFs?" - 9%
7. "How do I load all documents in a folder?" - 8%
8. "How do I split a string into a list of words in Python?" - 8%
9. "How do I load and process HTML content using BeautifulSoup?" - 8%
10. "How can I add metadata to the Pinecone upsert?" - 10%
```

```
1. “如何使用 LangChain 加载 PDF 文件并将其切分为文本块？” — 15%  
2. “如何使用 LangChain 加载并处理 CSV 文件？” — 12%  
3. “如何使用 'readfiletool' 加载纯文本文件？” — 11%  
4. “如何使用 LangChain 结合大语言模型（LLM）对 PDF 文档进行摘要？” — 10%  
5. “LangChain 提供了哪些不同类型的数据加载器？我该如何根据实际场景选择合适的加载器？” — 9%  
6. “如何加载并处理多个 PDF 文件？” — 9%  
7. “如何加载某个文件夹下的全部文档？” — 8%  
8. “如何在 Python 中将字符串分割为单词列表？” — 8%  
9. “如何使用 BeautifulSoup 加载并处理 HTML 内容？” — 8%  
10. “如何为 Pinecone 的 upsert 操作添加元数据？” — 10%  
```

To get better diagnostic analysis of the cost, we use soon-to-launch LangChain tooling to compare diagnostics (token usage, etc) for the approaches. For example, we quantify token usage, which shows that map-reduce indeed has higher cost:

为更精准地诊断各项成本，我们借助即将发布的 LangChain 工具链，对上述两种方法的关键指标（如 token 使用量等）进行了对比分析。例如，量化结果显示：map-reduce 方法的 token 消耗确实更高。

- ~500k tokens  
- ~50 万个 token  

- ~80k tokens (~8k / cluster with 10 clusters)  
- ~8 万个 token（每簇约 8k token，共 10 个簇）

### Summary  

### 总结  

As expected, there are trade-offs between the approaches. Map-Reduce provides high customizability because questions can be split into arbitrarily granular groups and summarized with tunable map-reduce prompts. However, the cost may be considerably higher as noted by token usage.  
正如预期，不同方法之间存在权衡。Map-Reduce 方法具备高度可定制性，因为问题可被划分为任意精细粒度的组，并通过可调的 Map-Reduce 提示进行汇总。然而，如 token 使用量所示，其成本可能显著更高。

Clustering risks information loss due to hand-tuning (e.g., of the cluster number) in the preprocessing stage, but it offers lower cost and may be a sensible way to quickly compress very large datasets prior to more granular (and high cost) LLM summarization.  
聚类方法在预处理阶段需人工调优（例如簇的数量），因而存在信息丢失的风险；但其成本更低，可作为快速压缩超大规模数据集的合理手段，为后续更精细（且高成本）的 LLM 汇总做好准备。

The thoughtful union of these two methods offers considerable promise for addressing this challenge.  
将这两种方法审慎结合，有望为应对这一挑战提供极具前景的解决方案。

### Tags  

### 标签  

[By LangChain](https://blog.langchain.com/tag/by-langchain/)  
[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/analyzing-user-interactions-with-llms-to-improve-our-documentation/img_004.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)  
[![评估深度智能体：我们的经验总结](images/analyzing-user-interactions-with-llms-to-improve-our-documentation/img_004.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)  
[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read  
[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/analyzing-user-interactions-with-llms-to-improve-our-documentation/img_005.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)  
[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/analyzing-user-interactions-with-llms-to-improve-our-documentation/img_005.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中推出端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/analyzing-user-interactions-with-llms-to-improve-our-documentation/img_006.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/analyzing-user-interactions-with-llms-to-improve-our-documentation/img_006.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/analyzing-user-interactions-with-llms-to-improve-our-documentation/img_007.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/analyzing-user-interactions-with-llms-to-improve-our-documentation/img_007.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/analyzing-user-interactions-with-llms-to-improve-our-documentation/img_008.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![借助 LangSmith SDK v0.2 实现更便捷的评估](images/analyzing-user-interactions-with-llms-to-improve-our-documentation/img_008.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**借助 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/analyzing-user-interactions-with-llms-to-improve-our-documentation/img_009.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入公测阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)