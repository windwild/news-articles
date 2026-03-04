---
title: "Sharing LangSmith Benchmarks"
source: "LangChain Blog"
url: "https://blog.langchain.com/public-langsmith-benchmarks/"
date: "2023-11-22"
scraped_at: "2026-03-03T08:24:50.145628060+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

The single biggest pain point we hear from developers taking their apps into production is around testing and evaluation. This difficulty is felt more acutely due to the constant onslaught of new models, new retrieval techniques, new agent types, and new cognitive architectures.

开发者在将应用投入生产时，向我们反馈的最突出痛点，集中在测试与评估环节。而这一难题因新模型、新检索技术、新智能体类型以及新认知架构的持续涌现而愈发凸显。

Over the past months, we've made LangSmith the best place to go for LLM architecture evaluation ( [test comparison view](https://blog.langchain.com/test-run-comparisons/), [dataset curation](https://blog.langchain.com/announcing-data-annotation-queue/)). Today we're making it possible to share evaluation datasets and results, to more easily enable community-driven evaluation and benchmarks. We're also excited to share the new [`langchain-benchmarks`](https://langchain-ai.github.io/langchain-benchmarks/index.html?ref=blog.langchain.com) package so you can reproduce these results and easily experiment with your architecture.

过去数月，我们已将 LangSmith 打造成评估大语言模型（LLM）架构的最佳平台（[测试对比视图](https://blog.langchain.com/test-run-comparisons/)、[数据集构建](https://blog.langchain.com/announcing-data-annotation-queue/)）。今天，我们正式支持共享评估数据集与结果，从而更便捷地推动社区共建式评估与基准测试。我们还很高兴推出全新的 [`langchain-benchmarks`](https://langchain-ai.github.io/langchain-benchmarks/index.html?ref=blog.langchain.com) 工具包，助您复现这些结果，并快速对您自己的架构开展实验。

Test sharing makes it easy for anyone on LangSmith to publish all the data and metrics on how different architectures perform on the same set of tasks. As an added benefit, we're not just logging the end results - each evaluation result includes the full accompanying traces for the tested chains. This means you can go beyond aggregate statistics and system-level outputs and see the step-by-step execution of different systems on the same data point.

测试共享功能让 LangSmith 上的任何用户都能轻松发布全部数据与指标，展示不同架构在同一组任务上的表现。额外优势在于：我们记录的不只是最终结果——每个评估结果均附带被测链路（chains）的完整执行追踪（traces）。这意味着，您不仅能获取聚合统计与系统级输出，更能深入观察不同系统在相同数据点上的逐步执行过程。

🦜

The first benchmark we are releasing is a [Q&A dataset](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d?ref=blog.langchain.com) over the LangChain python docs. Answering these questions requires the system to synthesize answers from different documents in a logical way. You can review the [performance](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/compare?selectedSessions=5beb3728-2fb4-4091-b72e-277597284339%2C10e6ece8-a65b-45a4-ac38-9554a16daca4%2C7f0a7983-a6dc-49a1-892d-5b0fdc264bb4%2C10cda074-76f8-4e87-8c21-b6499cb6d83d%2Cb4908c09-f670-4737-bc59-abbd4245c9f6%2Cab3f6db1-3b73-49a1-8538-c4a9dff1b78c%2Ccebda59c-eda5-46dd-bd2b-9d1435bae132%2C1fd06cde-3cc2-4234-9a2a-cf1bdb3ee0ed%2C3490783c-06e2-4b3f-aeaf-da1bed128047%2C4bfcbd94-aefe-4e22-8567-a17788cd0c73&ref=blog.langchain.com) of common approaches in the linked page and try out the performance of your own application using the [langchain-benchmarks](https://langchain-ai.github.io/langchain-benchmarks/notebooks/retrieval/langchain_docs_qa.html?ref=blog.langchain.com) package.

我们发布的首个基准测试，是基于 LangChain Python 文档构建的 [问答（Q&A）数据集](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d?ref=blog.langchain.com)。回答其中的问题，要求系统能以合乎逻辑的方式，从多份文档中综合提炼答案。您可通过链接页面查看主流方法的 [性能对比](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/compare?selectedSessions=5beb3728-2fb4-4091-b72e-277597284339%2C10e6ece8-a65b-45a4-ac38-9554a16daca4%2C7f0a7983-a6dc-49a1-892d-5b0fdc264bb4%2C10cda074-76f8-4e87-8c21-b6499cb6d83d%2Cb4908c09-f670-4737-bc59-abbd4245c9f6%2Cab3f6db1-3b73-49a1-8538-c4a9dff1b78c%2Ccebda59c-eda5-46dd-bd2b-9d1435bae132%2C1fd06cde-3cc2-4234-9a2a-cf1bdb3ee0ed%2C3490783c-06e2-4b3f-aeaf-da1bed128047%2C4bfcbd94-aefe-4e22-8567-a17788cd0c73&ref=blog.langchain.com)，并借助 [langchain-benchmarks](https://langchain-ai.github.io/langchain-benchmarks/notebooks/retrieval/langchain_docs_qa.html?ref=blog.langchain.com) 工具包，快速验证您自身应用的性能表现。

![](images/sharing-langsmith-benchmarks/img_001.png)LangChain Docs Q&A dataset view.

![](images/sharing-langsmith-benchmarks/img_001.png)LangChain 文档问答（Q&A）数据集视图。

## Background

## 背景

Over the past year, the tooling and model quality for building with LLMs has continued to improve with breakneck speed. Each week, dozens of new prompting and compositional techniques are proposed by developers and researchers, all claiming superior performance characteristics. The LangChain community has [implemented](https://github.com/kyrolabs/awesome-langchain?ref=blog.langchain.com) many of these, from simple prompting techniques like [chain of density](https://smith.langchain.com/hub/langchain-ai/chain-of-densit?ref=blog.langchain.com) and [step-back prompting](https://smith.langchain.com/hub/langchain-ai/stepback-answer?ref=blog.langchain.com), to [advanced RAG techniques](https://github.com/langchain-ai/langchain/tree/master/templates/neo4j-advanced-rag?ref=blog.langchain.com) all the way to [RL chains](https://github.com/langchain-ai/langchain/blob/master/cookbook/learned_prompt_optimization.ipynb?ref=blog.langchain.com), [generative agents](https://github.com/langchain-ai/langchain/blob/master/cookbook/generative_agents_interactive_simulacra_of_human_behavior.ipynb?ref=blog.langchain.com), and autonomous agents like [BabyAGI](https://github.com/langchain-ai/langchain/blob/master/cookbook/baby_agi.ipynb?ref=blog.langchain.com). For structured generation alone, we have (thankfully) evolved from [emotion prompting](https://arxiv.org/abs/2307.11760?ref=blog.langchain.com) techniques to fine-tuned APIs like [function calling](https://python.langchain.com/docs/modules/chains/how_to/openai_functions?ref=blog.langchain.com) and [grammar-based sampling](https://python.langchain.com/docs/integrations/llms/llamacpp?ref=blog.langchain.com#grammars).

过去一年间，面向大语言模型（LLM）开发的工具链与模型质量正以惊人的速度持续提升。每周，开发者与研究人员都会提出数十种新的提示工程（prompting）与组合式（compositional）技术，且均宣称具备更优的性能特征。LangChain 社区已 [实现](https://github.com/kyrolabs/awesome-langchain?ref=blog.langchain.com) 其中大量方案：从基础提示技术（如 [密度链（chain of density）](https://smith.langchain.com/hub/langchain-ai/chain-of-densit?ref=blog.langchain.com) 与 [回退提示（step-back prompting）](https://smith.langchain.com/hub/langchain-ai/stepback-answer?ref=blog.langchain.com)），到 [高级 RAG 技术](https://github.com/langchain-ai/langchain/tree/master/templates/neo4j-advanced-rag?ref=blog.langchain.com)，再到 [强化学习链（RL chains）](https://github.com/langchain-ai/langchain/blob/master/cookbook/learned_prompt_optimization.ipynb?ref=blog.langchain.com)、[生成式智能体（generative agents）](https://github.com/langchain-ai/langchain/blob/master/cookbook/generative_agents_interactive_simulacra_of_human_behavior.ipynb?ref=blog.langchain.com)，以及 [BabyAGI](https://github.com/langchain-ai/langchain/blob/master/cookbook/baby_agi.ipynb?ref=blog.langchain.com) 等自主智能体。仅就结构化生成而言，我们（庆幸地）已从 [情绪提示（emotion prompting）](https://arxiv.org/abs/2307.11760?ref=blog.langchain.com) 等早期方法，演进至函数调用（[function calling](https://python.langchain.com/docs/modules/chains/how_to/openai_functions?ref=blog.langchain.com)）与基于语法规则的采样（[grammar-based sampling](https://python.langchain.com/docs/integrations/llms/llamacpp?ref=blog.langchain.com#grammars)）等精细化 API。

With the launch of [Hub](https://smith.langchain.com/hub?ref=blog.langchain.com) and [LangChain Templates](https://blog.langchain.com/langserve-hub/), the release rate of new architectures continues to accelerate. But which of these approaches will translate to performance gains in YOUR application? What tradeoffs are assumed by each technique?

随着 [Hub](https://smith.langchain.com/hub?ref=blog.langchain.com) 与 [LangChain 模板库（LangChain Templates）](https://blog.langchain.com/langserve-hub/) 的发布，新型架构的发布节奏进一步加快。但问题随之而来：这些方法中，哪些真正在**您的应用**中带来性能提升？每种技术又隐含了哪些权衡取舍？

It can be hard to separate the signal from the noise, and the abundance of options makes reliable and relevant benchmarks that much more important. When it comes to grading language models on general tasks, public benchmarks like [HELM](https://crfm.stanford.edu/helm/latest/?ref=blog.langchain.com) or [EleutherAI’s Test Harness](https://www.eleuther.ai/projects/large-language-model-evaluation?ref=blog.langchain.com) are great options. For measuring LLM inference speed and throughput, AnyScale’s [LLMPerf benchmarks](https://www.anyscale.com/blog/reproducible-performance-metrics-for-llm-inference?ref=blog.langchain.com) can be a guiding light. These tools are excellent for comparing the underlying capability of language models, but they don't necessarily reflect their real-world behavior within your application.

在纷繁复杂的技术噪音中甄别真正有效的信号并非易事；而可选方案的爆炸式增长，更使得可靠、贴合实际的基准测试变得前所未有的重要。在通用任务上评估语言模型能力时，[HELM](https://crfm.stanford.edu/helm/latest/?ref=blog.langchain.com) 或 [EleutherAI 测试框架（Test Harness）](https://www.eleuther.ai/projects/large-language-model-evaluation?ref=blog.langchain.com) 等公开基准测试是极佳选择；而在衡量大语言模型推理速度与吞吐量方面，AnyScale 推出的 [LLMPerf 基准测试](https://www.anyscale.com/blog/reproducible-performance-metrics-for-llm-inference?ref=blog.langchain.com) 则堪称指路明灯。这些工具虽能出色地比对语言模型的底层能力，却未必能真实反映其在您具体应用场景中的实际行为。

LangChain’s mission is to make it as easy as possible to build with LLMs, and that means helping you stay up to date on the **relevant** advancements in the field. LangSmith’s evaluation and tracing experience helps you easily compare approaches in aggregate and on a sample level, and it makes it easy to drill down into each step to identify the root cause for changes in behavior.

LangChain 的使命是让基于大语言模型（LLM）的开发尽可能简单，而这意味着帮助您及时掌握该领域中**相关**的最新进展。LangSmith 提供的评估与追踪功能，让您能够轻松地从整体和样本两个层面比较不同方法，并可逐层深入每个执行步骤，快速定位行为变化的根本原因。

With public datasets and evals, you can see the performance characteristics of any reference architecture on a relevant dataset so you can easily separate the signal from the noise.

借助公开数据集与评估工具，您可以在相关数据集上直观了解任意参考架构的性能特征，从而轻松区分有效信号与干扰噪声。

## 📑 LangChain Docs Q&A Dataset

## 📑 LangChain 文档问答数据集

The first benchmark task we are including is a [Q&A dataset over LangChain's documentation](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d?ref=blog.langchain.com). This is a set of hand-crafted question-answer pairs we wrote over [LangChain’s python docs](https://python.langchain.com/?ref=blog.langchain.com). The questions are written to test RAG systems' ability to answer correctly, even if an answer requires information from multiple documents or when the question conflicts with the document's knowledge.

我们纳入的第一个基准测试任务，是面向 [LangChain 文档的问答数据集](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d?ref=blog.langchain.com)。该数据集由我们人工精心构建，问题与答案均基于 [LangChain 的 Python 文档](https://python.langchain.com/?ref=blog.langchain.com) 设计而成。所设问题旨在检验 RAG（检索增强生成）系统准确作答的能力——无论答案需综合多个文档信息，还是问题本身与文档知识存在冲突。

As a part of the initial release, we have evaluated various implementations that differ across a few dimensions:

作为本次初始发布的组成部分，我们已对若干在以下维度上存在差异的实现方案进行了评估：

- The language model used (OpenAI, Anthropic, OSS models)  
- 所采用的语言模型（OpenAI、Anthropic、开源模型）

- The "cognitive architecture" used (conversational retrieval chain, agents)  
- 所采用的“认知架构”（对话式检索链、智能体）

You can check out the [link](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d?ref=blog.langchain.com) above to review the results or continue with the information below!

您可通过上方的 [链接](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d?ref=blog.langchain.com) 查看详细评测结果，或继续阅读下方内容！

## 🦜💪 LangChain Benchmarks

## 🦜💪 LangChain 基准测试套件

To help you experiment with your own architectures on the Q&A dataset, we are publishing a new [langchain-benchmarks](https://pypi.org/project/langchain-benchmarks/?ref=blog.langchain.com) package ( [docs](https://langchain-ai.github.io/langchain-benchmarks/index.html?ref=blog.langchain.com) link). This package facilitates experimentation and benchmarking for key functionality when building with LLMs. In addition to the are publishing benchmarks [extraction](https://langchain-ai.github.io/langchain-benchmarks/notebooks/extraction/intro.html?ref=blog.langchain.com), [agent tool use,](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/intro.html?ref=blog.langchain.com) and [retrieval-based question answering.](https://langchain-ai.github.io/langchain-benchmarks/notebooks/retrieval/intro.html?ref=blog.langchain.com)

为助力您在该问答数据集上实验自定义架构，我们正式发布全新 [langchain-benchmarks](https://pypi.org/project/langchain-benchmarks/?ref=blog.langchain.com) 软件包（配套 [文档](https://langchain-ai.github.io/langchain-benchmarks/index.html?ref=blog.langchain.com)）。该软件包旨在简化基于大语言模型开发过程中的关键功能实验与基准测试。除上述问答任务外，我们同步发布了针对 [信息抽取](https://langchain-ai.github.io/langchain-benchmarks/notebooks/extraction/intro.html?ref=blog.langchain.com)、[智能体工具调用](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/intro.html?ref=blog.langchain.com) 和 [基于检索的问答](https://langchain-ai.github.io/langchain-benchmarks/notebooks/retrieval/intro.html?ref=blog.langchain.com) 的基准测试套件。

For each dataset, we provide functionality to easily test different LLMs, prompts, indexing techniques, and other tooling so you can quickly weigh the tradeoffs in different design decisions and pick the best solution for your application.

针对每个数据集，我们都提供便捷的功能支持，助您快速测试不同的大语言模型、提示词（prompt）、索引技术及其他工具组件，从而高效权衡各类设计取舍，并为您的具体应用场景选出最优解。

💡

💡

Try it yourself using the [links](https://langchain-ai.github.io/langchain-benchmarks/index.html?ref=blog.langchain.com) above or open a feature request in the [LangChain Benchmarks](https://github.com/langchain-ai/langchain-benchmarks?ref=blog.langchain.com) repository to request new tasks.

请通过上方的[链接](https://langchain-ai.github.io/langchain-benchmarks/index.html?ref=blog.langchain.com)亲自尝试，或在 [LangChain Benchmarks](https://github.com/langchain-ai/langchain-benchmarks?ref=blog.langchain.com) 仓库中提交功能请求，以申请新增评测任务。

In this post, we'll review some results from one of the question-answering tasks to show how it works!

本文将回顾某项问答任务的部分评测结果，以展示其工作原理！

### Comparing Simple RAG Approaches

### 简单 RAG 方法对比

In our initial benchmarks, we evaluated LLM architectures based on the following templates:

在初始基准测试中，我们基于以下模板对大语言模型（LLM）架构进行了评估：

| Cognitive Architecture | Test | Score ⬆️ | Cosine Dist ⬇️ | 🔗 |
| --- | --- | --- | --- | --- |
| Conversational Retrieval Chain | zephyr-7b-beta a2f3 | 0.31 | 0.18 | [link](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/compare?selectedSessions=20f78340-a5a8-4193-92ba-eb6c0849ab3b&ref=blog.langchain.com) |
|  | mistral-7b-instruct-4k 0826 | 0.46 | 0.13 | [link](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/compare?selectedSessions=80501c49-6845-4a1e-980d-8e36dddba230&ref=blog.langchain.com) |
|  | gpt-4-chat f4cd | 0.50 | 0.15 | [link](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/compare?selectedSessions=cced8db6-5a08-4076-84b6-67282d718441&ref=blog.langchain.com) |
|  | chat-gpt-3.5 1098 | 0.56 | 0.12 | [link](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/compare?selectedSessions=653f5f0c-b250-41bd-b235-ad7e460ef9ba&ref=blog.langchain.com) |
|  | anthropic-chat f290 | 0.56 | 0.13 | [link](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/compare?selectedSessions=d21fe3ec-719c-44bf-a6dd-c0f6bc414e9c&ref=blog.langchain.com) |
| Agent | openai-functions-agent dc91 | 0.47 | 0.13 | [link](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/compare?selectedSessions=20b3ae59-9eee-43f0-9776-1c1f41b15aa2&ref=blog.langchain.com) |
|  | gpt-4-preview-openai-functions-agent 5832 | 0.58 | 0.142 | [link](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/compare?selectedSessions=544a8e44-49fc-4fcb-a976-713ec0d2e9b2&ref=blog.langchain.com) |
|  | anthropic-iterative-search 1fdf | 0.50 | 0.14 | [link](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/compare?selectedSessions=b01cedc1-e2e4-456c-a442-bd1b27cc4788&ref=blog.langchain.com) |
| Assistant | openai-assistant af8e | 0.62 | 0.13 | [link](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/compare?selectedSessions=9ea0c6d3-31dd-4943-a96d-0d9ee320daae&ref=blog.langchain.com) |

The links above let you view the results for each configuration and compare each using the automatic metrics. For these tests, we measure the [cosine distance](https://python.langchain.com/docs/guides/evaluation/string/embedding_distance?ref=blog.langchain.com) between the predicted and reference responses as well as an accuracy "score" using LangChain’s LLM-based [scoring evaluator](https://python.langchain.com/docs/guides/evaluation/string/scoring_eval_chain?ref=blog.langchain.com). For the accuracy score, a larger number is better (⬆️) and for the cosine distance, a _lower_ number is better (⬇️). Below, we describe the tests in more detail. See the prompt used for the evaluator [here](https://github.com/langchain-ai/langchain-benchmarks/blob/5f2ce54b4025006d12755e1cc112627ae539e81f/langchain-docs-benchmarking/run_evals.py?ref=blog.langchain.com#L58).

上方链接可查看每种配置的评测结果，并借助自动化指标进行横向对比。本次测试采用两项指标：一是预测答案与参考答案之间的[余弦距离（cosine distance）](https://python.langchain.com/docs/guides/evaluation/string/embedding_distance?ref=blog.langchain.com)，二是基于 LangChain 的大语言模型驱动的[打分评估器（scoring evaluator）](https://python.langchain.com/docs/guides/evaluation/string/scoring_eval_chain?ref=blog.langchain.com)所生成的准确率“得分”。其中，准确率得分越高越好（⬆️），而余弦距离则越低越好（⬇️）。下文将更详细地介绍各项测试。评估器所用提示词（prompt）详见[此处](https://github.com/langchain-ai/langchain-benchmarks/blob/5f2ce54b4025006d12755e1cc112627ae539e81f/langchain-docs-benchmarking/run_evals.py?ref=blog.langchain.com#L58)。

**Conversational retrieval chains**

**对话式检索链（Conversational Retrieval Chains）**

The following experiments use different models within a simple retrieval chain implementation. The input query is directly embedded using OpenAI's `text-embedding-ada-002`, and the four most relevant docs are retrieved from a ChromaDB vectorstore based on semantic similarity. We compare the following LLMs below:

以下实验均基于一种简易的检索链（retrieval chain）实现，使用 OpenAI 的 `text-embedding-ada-002` 模型直接对输入查询进行嵌入编码，并在 ChromaDB 向量数据库中依据语义相似度检索出最相关的四篇文档。我们对比如下大语言模型（LLM）：

- `mistral-7b-instruct-4k 0826`: 采用开源的 [Mistral 7B 模型](https://app.fireworks.ai/models/fireworks/mistral-7b-instruct-4k?ref=blog.langchain.com)（上下文窗口为 4K），结合检索所得文档生成回答；该模型经指令微调（instruction tuning）优化。
- `zephyr-7b-beta a2f3`: 采用开源的 [Zephyr 7B Beta](https://huggingface.co/HuggingFaceH4/zephyr-7b-beta?ref=blog.langchain.com) 模型——即 Mistral 7B 的指令微调版本——结合检索所得文档生成回答。
- `chat-3.5-3.5 1098`: 使用 OpenAI 的 `gpt-3.5-turbo-16k` 模型，结合检索所得文档生成回答。
- `gpt-4-chat f4cd`: 使用 OpenAI 的 `gpt-4` 模型，结合检索所得文档生成回答。
- `anthropic-chat f290`: 使用 Anthropic 的 `claude-2` 模型，结合检索所得文档生成回答。

💡

All of the above runs use the same retriever, meaning that any differences in results are due to the LLM's ability to reason over the retrieved data.

💡

以上所有运行均使用相同的检索器，因此结果间的任何差异均源于大语言模型（LLM）对所检索数据的推理能力。

**Agents**

The following tests apply `agent` architectures to answer the questions. The agents are given a single retriever tool, which wraps the same vector store retriever described above. Agents are able to respond directly or call the retriever any number of times with their own queries to answer a question. In practice, we find that the agents typically call the tool once and then respond.

**智能体（Agents）**

以下测试将 `agent`（智能体）架构应用于问题回答。这些智能体被赋予一个单一的检索工具，该工具封装了上文所述的同一向量数据库检索器。智能体可直接作答，也可根据自身生成的查询多次调用该检索工具以回答问题。实践中我们发现，智能体通常仅调用该工具一次，随后即给出最终回答。

- `openai-functions-agent dc91`: uses the [function calling API](https://python.langchain.com/docs/modules/agents/agent_types/openai_functions_agent?ref=blog.langchain.com) from OpenAI (now called the 'tool calling' API) to interact with the documentation retriever. In this case, the agent is driven by the `gpt-3.5-turbo-16k` model.

- `openai-functions-agent dc91`：使用 OpenAI 的 [函数调用 API](https://python.langchain.com/docs/modules/agents/agent_types/openai_functions_agent?ref=blog.langchain.com)（现称“工具调用 API”）与文档检索器交互；本例中，该智能体由 `gpt-3.5-turbo-16k` 模型驱动。

- `gpt-4-preview-openai-functions-agent 5832`: same as above but uses the new `gpt-4-1106-preview` model, which is a larger, more capable model than gpt-3.5.

- `gpt-4-preview-openai-functions-agent 5832`：同上，但改用新型 `gpt-4-1106-preview` 模型；该模型规模更大、能力更强，优于 `gpt-3.5` 系列。

- `anthropic-iterative-searche 1fdf`: applies the [iterative search](https://python.langchain.com/docs/templates/anthropic-iterative-search?ref=blog.langchain.com) agent, which prompts Anthropic's `claude-2` model to call the retrieval tool and uses XML formatting to improve reliability of the structured text generation.

- `anthropic-iterative-searche 1fdf`：采用 [迭代搜索（Iterative Search）](https://python.langchain.com/docs/templates/anthropic-iterative-search?ref=blog.langchain.com) 智能体，通过提示 Anthropic 的 `claude-2` 模型调用检索工具，并借助 XML 格式提升结构化文本生成的可靠性。

💡

Compared to the **conversational retrieval chain**, the above results vary in their **retrieval** methods. Namely, they use the LLM to generate relevant search queries.

💡

与 **对话式检索链（conversational retrieval chain）** 相比，上述结果在 **检索方式** 上存在差异：它们依赖大语言模型（LLM）生成相关搜索查询。

**Assistant API**

Finally, we tested OpenAI's new assistants API in `openai-assistant af83`. This still uses our same retrieval tool, but it uses OpenAI's execution logic to decide the query and final response. This agent ended up earning the highest performance of all our tests.

**助手 API（Assistant API）**

最后，我们在 `openai-assistant af83` 中测试了 OpenAI 全新的助手 API（Assistants API）。该方案仍复用我们原有的检索工具，但其查询生成与最终响应均由 OpenAI 自身的执行逻辑决定。该智能体在全部测试中取得了最高性能表现。

## Reviewing the Results

## 结果回顾

The comparison views also make it easy to manually review the outputs to get a better sense for how the models behave, so you can make adjustments to your cognitive architecture and update the evaluation techniques to address any failure modes you identify.

比较视图还便于您手动审阅模型输出，从而更深入地理解各模型的行为特征；据此，您可以调整自身的认知架构，并更新评估方法，以应对所发现的任何失效模式。

To illustrate, let's compare the conversational retrieval chain powered by Mistral-7b RAG application to similarly architected application powered by GPT-3.5: ( [comparison link)](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/compare?selectedSessions=80501c49-6845-4a1e-980d-8e36dddba230%2C653f5f0c-b250-41bd-b235-ad7e460ef9ba&ref=blog.langchain.com). Using the tested prompts, GPT-3.5's performance handily outperforms the Mistral 7B model in terms of the aggregate metrics generated for this example (0.01 difference in average cosine difference but lags the average "accuracy" score by 0.1).

为说明这一点，我们来对比由 Mistral-7B 驱动的对话式检索链（RAG 应用）与采用相似架构、但由 GPT-3.5 驱动的应用：（[对比链接](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/compare?selectedSessions=80501c49-6845-4a1e-980d-8e36dddba230%2C653f5f0c-b250-41bd-b235-ad7e460ef9ba&ref=blog.langchain.com)）。在本例中，使用经测试的提示词时，GPT-3.5 在综合指标上显著优于 Mistral-7B 模型（平均余弦距离相差仅 0.01，但在平均“准确率”得分上落后 0.1）。

_Note: None of the open-source models tested in these experiments matched the aggregate performance of the proprietary APIs off-the-shelf, though additional prompt engineering may close the gap._

_注：在本次实验中测试的所有开源模型，其开箱即用的综合性能均未达到专有 API 的水平；不过，通过进一步的提示词工程，或许可缩小这一差距。_

This is interesting, but in order to decide how to improve, you'll need to look at the data. LangSmith makes this easy. Take the following challenging example:

这很有趣，但若要确定如何改进，您必须深入分析数据。LangSmith 让这项工作变得轻而易举。请看以下这个具有挑战性的示例：

![](images/sharing-langsmith-benchmarks/img_002.png)Challenge question requiring knowledge of the scope of the package.

![](images/sharing-langsmith-benchmarks/img_002.png)一道需了解该软件包适用范围的挑战性问题。

For this data point, neither model was able to answer correctly; the question itself requires knowledge of absence, which is a challenging task for RAG applications that often leads to hallucinations.

针对该数据点，两个模型均未能给出正确答案；该问题本身要求模型具备对“缺失信息”的认知能力——这对 RAG 应用而言是一项极具挑战性的任务，极易引发幻觉（hallucination）。

When inspecting this by eye, the `gpt-3.5-turbo` model clearly hallucinates, even providing a nice made-up link ( [https://docs.langchain.com/java-sdk](https://docs.langchain.com/java-sdk?ref=blog.langchain.com)). The `mistral` models' response is preferable, since it doesn't generate inaccuracies (no official LangChain java SDK exists).

人工检查时可明显看出，`gpt-3.5-turbo` 模型产生了明确的幻觉，甚至编造了一个看似合理的链接（[https://docs.langchain.com/java-sdk](https://docs.langchain.com/java-sdk?ref=blog.langchain.com)）。相比之下，`mistral` 模型的回答更可取，因其未生成错误信息（目前 LangChain 官方并无 Java SDK）。

To diagnose why the models responded the way they did, you can click through to view the full trace of that architecture.

为诊断模型为何如此响应，您可点击进入，查看该架构的完整执行轨迹（trace）。

![](images/sharing-langsmith-benchmarks/img_003.png)The response generator

![](images/sharing-langsmith-benchmarks/img_003.png)响应生成器

It's clear from the trace ( [link](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/80501c49-6845-4a1e-980d-8e36dddba230/p/r/1abd725d-d2ce-45b7-9476-54e46e08da31?ref=blog.langchain.com)) that the retrieved documents are all quite irrelevant to the original query. If you are using a model like `gpt-3.5` and getting hallucinations like this, you can try adding an additional system prompt reminding the model to only respond based on the retrieved content, and you can work to improve the retriever to filter out irrelevant documents.

从该执行轨迹（[链接](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/80501c49-6845-4a1e-980d-8e36dddba230/p/r/1abd725d-d2ce-45b7-9476-54e46e08da31?ref=blog.langchain.com)）中可以清晰看出，所有被检索出的文档均与原始查询高度不相关。若您正使用 `gpt-3.5` 类模型并遭遇此类幻觉现象，可尝试添加一条额外的系统提示（system prompt），提醒模型仅依据已检索到的内容作答；同时，您还可优化检索器（retriever），以更有效地过滤掉无关文档。

Let's review another data point, this one where `gpt-3.5` responded correctly but `mistral` did not. If you [compare the outputs](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/compare?selectedSessions=80501c49-6845-4a1e-980d-8e36dddba230%2C653f5f0c-b250-41bd-b235-ad7e460ef9ba&peek=fa9f8beb-0cb3-4d67-8ed7-cab5dae0d615&ref=blog.langchain.com), you can see that `mistral` was influenced too much by the document content and mentioned the class from the docs rather than the direct answer.

让我们再回顾另一个数据点：在此例中，`gpt-3.5` 给出了正确回答，而 `mistral` 却没有。如果你[对比两者的输出结果](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/compare?selectedSessions=80501c49-6845-4a1e-980d-8e36dddba230%2C653f5f0c-b250-41bd-b235-ad7e460ef9ba&peek=fa9f8beb-0cb3-4d67-8ed7-cab5dae0d615&ref=blog.langchain.com)，会发现 `mistral` 过度受到文档内容的影响，错误地引用了文档中提到的类名，而非直接给出问题的答案。

![](images/sharing-langsmith-benchmarks/img_004.png)

![](images/sharing-langsmith-benchmarks/img_004.png)

If you look at the [trace](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/80501c49-6845-4a1e-980d-8e36dddba230/p/r/965f74aa-6c87-490c-98aa-158db8358fe9?ref=blog.langchain.com), you can see that "SelfQueryRetriever" is only mentioned in Document 5 of the retrieved docs, meaning it's the least relevant document. That the LLM hinges its response based on this document signals that perhaps we could improve its performance by re-ordering the input.

如果你查看该调用的[执行追踪（trace）](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/80501c49-6845-4a1e-980d-8e36dddba230/p/r/965f74aa-6c87-490c-98aa-158db8358fe9?ref=blog.langchain.com)，会发现字符串 `"SelfQueryRetriever"` 仅出现在检索出的文档第 5 篇中——即相关性最低的一篇文档。大语言模型却以此为依据生成回答，这提示我们：或许可通过调整输入文档的排序来提升其表现。

To check this hypothesis, you can [open the LLM run in the playground](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/80501c49-6845-4a1e-980d-8e36dddba230/p/r/965f74aa-6c87-490c-98aa-158db8358fe9/playground?ref=blog.langchain.com). By swapping documents 1 and 5, we can see that the LLM responds with the correct answer. Based on this check, we could update the order we present the documents and re-run evaluation!

为验证这一假设，你可[在 Playground 中打开该 LLM 调用](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/80501c49-6845-4a1e-980d-8e36dddba230/p/r/965f74aa-6c87-490c-98aa-158db8358fe9/playground?ref=blog.langchain.com)。将第 1 篇与第 5 篇文档互换位置后，LLM 即能给出正确答案。基于这一验证结果，我们可以更新文档呈现顺序，并重新运行评估！

![](images/sharing-langsmith-benchmarks/img_005.png)

![](images/sharing-langsmith-benchmarks/img_005.png)

Apart from response accuracy, latency is another important metric when building an LLM application. In our case, `mistral-7b`'s median response time was 18 seconds, 11 seconds faster than `gpt-3.5`'s.

除响应准确率外，延迟（latency）也是构建大语言模型应用时另一项关键指标。本例中，`mistral-7b` 的中位响应时间为 18 秒，比 `gpt-3.5` 快了 11 秒。

![](images/sharing-langsmith-benchmarks/img_006.png)

![](images/sharing-langsmith-benchmarks/img_006.png)

Measuring quality metrics alongside "system metrics" can help you pick the "right-sized" model and architecture for the job.

将质量类指标与“系统类指标”（如延迟、吞吐量等）一并衡量，有助于你为具体任务选择尺寸适配、架构合理的模型。

Finally, let's compare the `openai-assistant af83` with the similar `gpt-4-preview-openai-functions-agent 5832` test. They use the same underlying model and retriever tool and work as an agent, but the former test uses OpenAI's assistant API. You can view the comparison here: [link](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/compare?selectedSessions=544a8e44-49fc-4fcb-a976-713ec0d2e9b2%2C9ea0c6d3-31dd-4943-a96d-0d9ee320daae&ref=blog.langchain.com).

最后，我们来对比 `openai-assistant af83` 与结构相似的 `gpt-4-preview-openai-functions-agent 5832` 测试。二者底层模型与检索工具相同，均以 Agent 模式运行；区别在于前者使用的是 OpenAI 的 Assistant API。你可在此处查看对比结果：[链接](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/compare?selectedSessions=544a8e44-49fc-4fcb-a976-713ec0d2e9b2%2C9ea0c6d3-31dd-4943-a96d-0d9ee320daae&ref=blog.langchain.com)。

An example data point where the assistant out-performs the agent is this ( [example](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/compare?selectedSessions=544a8e44-49fc-4fcb-a976-713ec0d2e9b2%2C9ea0c6d3-31dd-4943-a96d-0d9ee320daae&peek=429e58f2-6e9d-4aa6-a8b1-b67b7531bea5&ref=blog.langchain.com)). Both say that they cannot see an explicit answer to the question (since the retriever is the same), but the assistant is willing to provide context on how `strict` is used in other contexts as a pointer for the user.

一个体现 Assistant 表现优于 Agent 的典型示例见此（[示例链接](https://smith.langchain.com/public/452ccafc-18e1-4314-885b-edd735f17b9d/d/compare?selectedSessions=544a8e44-49fc-4fcb-a976-713ec0d2e9b2%2C9ea0c6d3-31dd-4943-a96d-0d9ee320daae&peek=429e58f2-6e9d-4aa6-a8b1-b67b7531bea5&ref=blog.langchain.com)）。由于两者使用相同的检索器，因此都表示“无法在检索结果中找到问题的明确答案”；但 Assistant 还进一步提供了 `strict` 在其他上下文中的使用方式作为参考线索，从而更主动地辅助用户理解。

![](images/sharing-langsmith-benchmarks/img_007.png)

## More to come

## 更多内容即将推出

Over the coming weeks, we plan to add benchmarks for each of LangChain’s most popular [use cases](https://python.langchain.com/docs/use_cases?ref=blog.langchain.com) to make it easier.

在接下来的几周内，我们计划为 LangChain 最受欢迎的各类 [使用场景](https://python.langchain.com/docs/use_cases?ref=blog.langchain.com) 添加基准测试，以进一步简化评估流程。

Check in on the [LangChain](https://github.com/langchain-ai/langchain-benchmarks?ref=blog.langchain.com) benchmarks repository for updates and open a feature request to ensure that your use cases are covered.

请持续关注 [LangChain](https://github.com/langchain-ai/langchain-benchmarks?ref=blog.langchain.com) 基准测试代码仓库以获取最新动态；您也可提交功能请求（feature request），确保您的具体使用场景被纳入支持范围。

You can also download the [langchain-benchmarks](https://langchain-ai.github.io/langchain-benchmarks/index.html?ref=blog.langchain.com) [package](https://langchain-ai.github.io/langchain-benchmarks/index.html?ref=blog.langchain.com) to try out **your** RAG application on this and other tasks.

您还可以下载 [langchain-benchmarks](https://langchain-ai.github.io/langchain-benchmarks/index.html?ref=blog.langchain.com) [软件包](https://langchain-ai.github.io/langchain-benchmarks/index.html?ref=blog.langchain.com)，在本任务及其他任务上测试 **您自己的** RAG 应用。
&#123;% endraw %}
