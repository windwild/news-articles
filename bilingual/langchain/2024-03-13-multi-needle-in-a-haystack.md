---
title: "Multi Needle in a Haystack"
source: "LangChain Blog"
url: "https://blog.langchain.com/multi-needle-in-a-haystack/"
date: "2024-03-13"
scraped_at: "2026-03-03T08:08:43.267701831+00:00"
language: "en-zh"
translated: true
---

## Key Links

## 关键链接

- [视频](https://youtu.be/UlmyyYQGhzc?ref=blog.langchain.com)
- [代码](https://github.com/gkamradt/LLMTest_NeedleInAHaystack/tree/main?ref=blog.langchain.com)

## Overview

## 概述

随着上下文窗口持续扩大至 [100 万](https://www.anthropic.com/news/claude-3-family?ref=blog.langchain.com) [token](https://blog.google/technology/ai/google-gemini-next-generation-model-february-2024/?ref=blog.langchain.com)，业界对长上下文大语言模型（LLM）的关注度正急剧上升。目前，用于评估长上下文 LLM 检索能力的最流行、被引用最多的基准测试之一，是 [Greg Kamradt](https://twitter.com/GregKamradt?ref=blog.langchain.com) 提出的 [“大海捞针”（Needle in A Haystack）](https://twitter.com/GregKamradt/status/1722386725635580292?lang=en&ref=blog.langchain.com)：将一个事实（“针”）嵌入一段长文本（“ haystack”，例如 Paul Graham 的[随笔集](https://www.ycombinator.com/library/carousel/Essays%20by%20Paul%20Graham?ref=blog.langchain.com)），然后向 LLM 提出一个与该事实相关的问题。该方法旨在考察模型在不同上下文长度及不同文档位置下的事实检索能力。

然而，这一测试并不能完全反映许多[检索增强生成（RAG）](https://github.com/langchain-ai/rag-from-scratch?ref=blog.langchain.com)应用的真实场景——RAG 通常需要从索引中检索多个事实，并在此基础上进行综合推理。为此，我们提出了一种全新基准测试，专门评估这一能力。在我们的 `Multi-Needle + Reasoning`（多针+推理）基准中，我们揭示了两项新发现：

1. 当要求 LLM 检索更多事实时，其性能显著下降；  
2. 当 LLM 需要对已检索出的多个事实进行推理时，性能进一步恶化。

下图总结了实验结果：随着“针”的数量增加，检索准确率下降；而对这些“针”进行**推理**的表现，比单纯执行检索任务更差。

![](images/multi-needle-in-a-haystack/img_001.png)

我们还复现了类似[先前基准测试](https://twitter.com/GregKamradt/status/1722386725635580292?lang=en&ref=blog.langchain.com)的结论：即输入上下文越长，模型整体性能越低。但除此之外，我们进一步深入探究了——当需同时检索多个“针”时，性能下降的**根本原因**是什么？通过分析下方的结果热力图可见：GPT-4 在多针检索任务中始终倾向于召回位于文本末尾的“针”，却系统性地忽略开头部分的“针”。这一现象与此前[单针研究](https://twitter.com/GregKamradt/status/1722386725635580292?lang=en&ref=blog.langchain.com)中观察到的模式高度一致。

![](images/multi-needle-in-a-haystack/img_002.png)

Below we'll walk through benchmark usage and discuss results on GPT-4.

下面我们来逐步介绍基准测试的使用方法，并讨论在 GPT-4 上的测试结果。

## Usage

## 使用方法

To perform a `Multi-Needle + Reasoning` evaluation, a user only needs three things: (1) A `question` that requires multiple needles to answer, (2) an `answer` derived from the needles, and (3) `list of needles` to be inserted into the context.

要执行一次 `Multi-Needle + Reasoning`（多针+推理）评估，用户只需准备三样内容：(1) 一个需结合多个“针”（关键信息片段）才能回答的 `question`（问题），(2) 一个基于这些“针”推导出的 `answer`（答案），以及 (3) 一份待插入上下文中的 `list of needles`（“针”的列表）。

We extended Greg Kamradt's [`LLMTest_NeedleInAHaystack`](https://github.com/gkamradt/LLMTest_NeedleInAHaystack?ref=blog.langchain.com) repo to support multi-needle evaluation and [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) as an valuator. Using LangSmith for evaluation, we [create](https://docs.smith.langchain.com/evaluation/faq/datasets-webapp?ref=blog.langchain.com) a LangSmith eval set with items (1) `question` and (2) `answer` above.

我们对 Greg Kamradt 的 [`LLMTest_NeedleInAHaystack`](https://github.com/gkamradt/LLMTest_NeedleInAHaystack?ref=blog.langchain.com) 仓库进行了扩展，以支持多针评估，并将 [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) 用作评估器（valuator）。借助 LangSmith 进行评估时，我们[创建](https://docs.smith.langchain.com/evaluation/faq/datasets-webapp?ref=blog.langchain.com)一个 LangSmith 评估数据集（eval set），其中包含上述两项内容：(1) `question`（问题）和 (2) `answer`（答案）。

As an example, lets use [this](https://twitter.com/alexalbert__/status/1764722513014329620?ref=blog.langchain.com) case study where the needle was a combination of pizza ingredients. We create a new LangSmith eval set ( [here](https://smith.langchain.com/public/d6b47e6e-8279-4452-bd22-d6c8b839f1a0/d?paginationState=%7B%22pageIndex%22%3A0%2C%22pageSize%22%3A10%7D&chartedColumn=latency_p50&ref=blog.langchain.com)) named `multi-needle-eval-pizza-3` with our `question` and `answer`:

举个例子，我们采用[这篇](https://twitter.com/alexalbert__/status/1764722513014329620?ref=blog.langchain.com)案例研究——其中“针”是一组披萨配料的组合。我们新建一个名为 `multi-needle-eval-pizza-3` 的 LangSmith 评估数据集（[链接](https://smith.langchain.com/public/d6b47e6e-8279-4452-bd22-d6c8b839f1a0/d?paginationState=%7B%22pageIndex%22%3A0%2C%22pageSize%22%3A10%7D&chartedColumn=latency_p50&ref=blog.langchain.com)），并填入如下 `question` 和 `answer`：

```
question:
What are the secret ingredients needed to build the perfect pizza?

answer:
The secret ingredients needed to build the perfect pizza are figs, prosciutto, and goat cheese.
```

```
question:
构建完美披萨所需的秘密配料有哪些？

answer:
构建完美披萨所需的秘密配料是无花果、帕尔玛火腿和山羊奶酪。
```

Question, Answer pairs for LangSmith `multi-needle-eval-pizza-3` eval set

LangSmith `multi-needle-eval-pizza-3` 评估数据集中的问题–答案对

Once we've created a dataset, we with few flags:

创建完数据集后，我们只需传入以下若干参数（flags）：

- `document_depth_percent_min` \- the depth of the first needle. The remaining needles are inserted at roughly equally spaced intervals after the first.  
- `document_depth_percent_min`：首个“针”插入位置的深度（占全文长度的百分比）。其余“针”将大致等间距地插入在首个“针”之后。

- `multi_needle` \- flag to run multi-needle evaluation  
- `multi_needle`：启用多针评估的开关标志。

- `needles` \- the full list of needles to inject into the context  
- `needles`：待注入上下文中的全部“针”列表。

- `evaluator` \- choose `langsmith`  
- `evaluator`：选择评估器为 `langsmith`。

- `eval_set` \- choose the eval set we created `multi-needle-eval-pizza-3`  
- `eval_set`：选择我们创建的评估数据集 `multi-needle-eval-pizza-3`。

- `context_lengths_num_intervals` \- number of context lengths to test  
- `context_lengths_num_intervals`：待测试的上下文长度数量（即采样点个数）。

- `context_lengths_min` (and max) - context length bounds to test  
- `context_lengths_min`（及 `max`）：待测试的上下文长度范围（最小值与最大值）。

We can run this to execute the evaluation:

我们可以运行以下命令来执行评估：

```
python main.py --evaluator langsmith --context_lengths_num_intervals 6 --document_depth_percent_min 5 --document_depth_percent_intervals 1 --provider openai --model_name "gpt-4-0125-preview" --multi_needle True --eval_set multi-needle-eval-pizza-3 --needles '[ " Figs are one of the secret ingredients needed to build the perfect pizza. ", " Prosciutto is one of the secret ingredients needed to build the perfect pizza. ",  " Goat cheese is one of the secret ingredients needed to build the perfect pizza. "]'  --context_lengths_min 1000 --context_lengths_max 120000
```

```
python main.py --evaluator langsmith --context_lengths_num_intervals 6 --document_depth_percent_min 5 --document_depth_percent_intervals 1 --provider openai --model_name "gpt-4-0125-preview" --multi_needle True --eval_set multi-needle-eval-pizza-3 --needles '[ " Figs are one of the secret ingredients needed to build the perfect pizza. ", " Prosciutto is one of the secret ingredients needed to build the perfect pizza. ",  " Goat cheese is one of the secret ingredients needed to build the perfect pizza. "]'  --context_lengths_min 1000 --context_lengths_max 120000
```

Command to run multi-needle evaluation using LangSmith

使用 LangSmith 运行多针（multi-needle）评估的命令

This will kick off a workflow below. It will insert the needles into the haystack, prompt the LLM to generate a response to the `question` using the context with the inserted needles, and evaluate whether the generation correctly retrieved the needles using the ground truth `answer` and the logged needles that were inserted.

这将启动下方所示的工作流：首先将“针”（needles）插入“干草堆”（haystack），然后提示大语言模型（LLM）基于包含这些“针”的上下文，对 `question` 生成回答；最后，利用真实答案（ground truth `answer`）以及记录在案的已插入“针”，评估模型生成结果是否成功检索到了全部“针”。

![](images/multi-needle-in-a-haystack/img_003.png)Workflow for `Multi-Needle + Reasoning` evaluation

![](images/multi-needle-in-a-haystack/img_003.png)`Multi-Needle + Reasoning`（多针+推理）评估工作流

## GPT-4 Retrieval Results

## GPT-4 检索结果

To test multi-needle retrieval for GPT-4, we built three LangSmith eval sets:

为测试 GPT-4 的多针检索能力，我们构建了三个 LangSmith 评估数据集：

- `multi-needle-eval-pizza-1` [here](https://smith.langchain.com/public/af0f1c89-3993-4ded-91c2-29eebef67582/d?ref=blog.langchain.com) \- Insert a single needle  
- `multi-needle-eval-pizza-1` [此处](https://smith.langchain.com/public/af0f1c89-3993-4ded-91c2-29eebef67582/d?ref=blog.langchain.com) —— 插入单根“针”

- `multi-needle-eval-pizza-3` [here](https://smith.langchain.com/public/d6b47e6e-8279-4452-bd22-d6c8b839f1a0/d?ref=blog.langchain.com) \- Insert three needles  
- `multi-needle-eval-pizza-3` [此处](https://smith.langchain.com/public/d6b47e6e-8279-4452-bd22-d6c8b839f1a0/d?ref=blog.langchain.com) —— 插入三根“针”

- `multi-needle-eval-pizza-10` [here](https://smith.langchain.com/public/74d2af1c-333d-4a73-87bc-a837f8f0f65c/d?ref=blog.langchain.com)\- Insert ten needles  
- `multi-needle-eval-pizza-10` [此处](https://smith.langchain.com/public/74d2af1c-333d-4a73-87bc-a837f8f0f65c/d?ref=blog.langchain.com) —— 插入十根“针”

We evaluate the ability of [GPT4](https://openai.com/blog/new-models-and-developer-products-announced-at-devday?ref=blog.langchain.com) (128k token context length) to retrieve 1, 3, or 10 needles in a single turn for small (1000 token) and large (120,000 token) context lengths. All commands run are [here](https://mirror-feeling-d80.notion.site/Multi-Needle-Evaluation-528e8e976a264ef3be2b145003c010e0?pvs=4&ref=blog.langchain.com). All resulting generations with public links to LangSmith traces are [here](https://github.com/gkamradt/LLMTest_NeedleInAHaystack/blob/main/viz/multi-needle-datasets/gpt4_retrieval.csv?ref=blog.langchain.com). Here is a summary figure of our results:

我们评估了 [GPT-4](https://openai.com/blog/new-models-and-developer-products-announced-at-devday?ref=blog.langchain.com)（支持 128K token 上下文长度）在小规模（1000 token）和大规模（120,000 token）上下文长度下，单次推理中检索出 1 根、3 根或 10 根“针”的能力。所有实际运行的命令详见 [此处](https://mirror-feeling-d80.notion.site/Multi-Needle-Evaluation-528e8e976a264ef3be2b145003c010e0?pvs=4&ref=blog.langchain.com)；所有生成结果及其对应的公开 LangSmith trace 链接汇总于 [此处](https://github.com/gkamradt/LLMTest_NeedleInAHaystack/blob/main/viz/multi-needle-datasets/gpt4_retrieval.csv?ref=blog.langchain.com)。以下是本次实验结果的汇总图表：

![](images/multi-needle-in-a-haystack/img_004.png)

有明确的观察结果：

- 当“针”（needles）数量从 1 增加到 10 时，模型性能下降；  
- 当上下文长度从 1,000 个 token 增加到 120,000 个 token 时，模型性能同样下降。

为深入探究并验证这些结果，我们可以分析 LangSmith 的调用追踪（traces）：[此处](https://smith.langchain.com/public/dddfcdc1-bc9a-4299-a5a6-55ba13d54a77/r/ca6e02a2-b472-49ff-af12-b70f44c0de1f?ref=blog.langchain.com) 是一条 LangSmith 追踪记录，其中我们向上下文中插入了 10 根“针”。以下是该次调用中 `GPT-4` 的生成结果：

```
The secret ingredients needed to build the perfect pizza include espresso-soaked dates, gorgonzola dolce, candied walnuts, and pear slices.
```

```
构建完美披萨所需的秘密配料包括：意式浓缩咖啡浸泡的枣子、戈贡佐拉甜味奶酪、糖渍胡桃和梨片。
```

GPT-4 在第 1 次重复实验中、针对含 10 根“针”与 24,800 token 上下文的生成结果

在生成结果中，仅出现了 **四种** “秘密配料”。根据 [该条 trace](https://smith.langchain.com/public/dddfcdc1-bc9a-4299-a5a6-55ba13d54a77/r/5c8da4fe-9294-456f-9620-7d59dde0809f?ref=blog.langchain.com)，我们确认全部 10 根“针”均已成功置入上下文；同时，我们也在 [日志表](https://docs.google.com/spreadsheets/d/1FAxyJHi2CyrfYoupFz46xvT4AgyI2akBVxQ_ykFtZKo/edit?usp=sharing&ref=blog.langchain.com) 中记录了各“针”的插入顺序：

```
* Figs
* Prosciutto
* Smoked applewood bacon
* Lemon
* Goat cheese
* Truffle honey
* Pear slices
* Espresso-soaked dates
* Gorgonzola dolce
* Candied walnuts
```

```
* 无花果  
* 帕尔马火腿  
* 熏苹果木培根  
* 柠檬  
* 山羊奶酪  
* 松露蜂蜜  
* 梨片  
* 意式浓缩咖啡浸泡的枣子  
* 戈贡佐拉甜味奶酪  
* 糖渍胡桃
```

插入上下文中的 10 根“针”的顺序

由此可确认：生成结果中出现的四种“秘密配料”，恰好对应我们插入上下文中的**最后四根“针”**。这一现象引出一个值得深思的问题：**检索失败究竟发生在上下文的哪个位置？**  
Greg 的 [单“针”分析](https://twitter.com/GregKamradt/status/1722386725635580292?lang=en&ref=blog.langchain.com) 表明：当“针”被置于文档靠前位置时，GPT-4 会出现检索失败。

由于我们已完整记录每根“针”的插入位置，因此也可对此展开进一步分析：下方热力图展示了在不同上下文长度下，GPT-4 对 10 根“针”的检索成功率。每一列代表一次独立实验——在该次实验中，我们要求 GPT-4 从上下文中检索全部 10 根“针”。

As the context length grows, we also see retrieval failure towards the start of the document. The effect appears to start earlier in the multi-needle case (around 25k tokens) than the single needle case (which started around 73k tokens for GPT-4).

随着上下文长度增加，我们也在文档开头观察到检索失败现象。该效应在“多针”场景下出现得更早（约 25k token 处），而“单针”场景下则较晚（GPT-4 约在 73k token 处开始出现）。

![](images/multi-needle-in-a-haystack/img_005.png)

## GPT-4 Retrieval & Reasoning

## GPT-4 的检索与推理能力

RAG is often focused on retrieving multiple facts (from an indexed corpus of documents) and then reasoning over them. To test this, we build 3 datasets that build on the above by asking for the **first letter** of all secret ingredients. This requires retrieval of ingredients and reasoning about them to answer the question.

RAG 通常侧重于从已索引的文档语料库中检索多个事实，并在此基础上进行推理。为测试这一能力，我们在前述基准任务基础上构建了 3 个新数据集，要求模型输出所有“秘密配料”的**首字母**。这既需要成功检索出各配料，又需对它们进行逻辑推理才能作答。

- `multi-needle-eval-pizza-reasoning-1` \- [此处](https://smith.langchain.com/public/a85db85f-ee45-4a39-a1ac-52f7279134ac/d?paginationState=%7B%22pageIndex%22%3A0%2C%22pageSize%22%3A10%7D&chartedColumn=latency_p50&ref=blog.langchain.com)  
- `multi-needle-eval-pizza-reasoning-3` \- [此处](https://smith.langchain.com/public/270cd9cd-154d-4ba9-8b34-7b6537007867/d?paginationState=%7B%22pageIndex%22%3A0%2C%22pageSize%22%3A10%7D&chartedColumn=latency_p50&ref=blog.langchain.com)  
- `multi-needle-eval-pizza-reasoning-10`\- [此处](https://smith.langchain.com/public/00658b64-6199-48fc-9443-1478aadbe19a/d?paginationState=%7B%22pageIndex%22%3A0%2C%22pageSize%22%3A10%7D&chartedColumn=latency_p50&ref=blog.langchain.com)

Note that this is an extremely simple form of reasoning. For future benchmarks, we want to include different levels of reasoning.

请注意，这是一种极为基础的推理形式。在后续基准测试中，我们计划纳入不同复杂度层级的推理任务。

We compared the fraction of correct answers for 3 replicates between retrieval and **retrieval + reasoning**. All data with traces is [here](https://github.com/gkamradt/LLMTest_NeedleInAHaystack/blob/main/viz/multi-needle-datasets/gpt4_reasoning.csv?ref=blog.langchain.com). Retrieval and reasoning both degrade as the context length increases, reasoning lags retrieval. This suggests that retrieval may set an upper bound on reasoning performance, as expected.

我们对比了 3 组重复实验中仅“检索”与“检索 + 推理”两类任务的正确率。所有带执行轨迹（traces）的原始数据见[此处](https://github.com/gkamradt/LLMTest_NeedleInAHaystack/blob/main/viz/multi-needle-datasets/gpt4_reasoning.csv?ref=blog.langchain.com)。结果表明：随着上下文长度增加，检索与推理性能均下降，且推理性能的退化滞后于检索性能——这印证了预期结论：检索能力可能构成推理性能的上限。

![](images/multi-needle-in-a-haystack/img_006.png)

## Conclusion

## 结论

The emergence of long context LLMs is extremely promising. In order to use them with or in place of external retrieval systems, it is critical to understand their limitations. The `Multi-Needle + Reasoning` benchmark can characterize the performance of long context retrieval relative to using a traditional RAG approach.

长上下文大语言模型（LLM）的出现前景极为广阔。若要将其与外部检索系统协同使用，或直接替代后者，深入理解其固有局限性至关重要。`Multi-Needle + Reasoning`（多针+推理）基准测试，可有效刻画长上下文检索能力，并与传统 RAG 方法形成性能对照。

We can draw a few general insights, but further testing is needed:

我们可以得出一些普遍性见解，但仍需进一步测试：

- `No retrieval guarantees` \- Multiple facts are not guaranteed to be retrieved, especially as the number of needles and context size increases.

- `无检索保障`：无法保证能检索到多个“针”（即目标事实），尤其当“针”的数量和上下文长度增加时。

- `Different patterns of retrieval failure` \- GPT-4 fails to retrieve needles towards the start of documents as context length increases.

- `检索失败模式各异`：随着上下文长度增加，GPT-4 越来越难以检索到位于文档开头附近的“针”。

- `Prompting matters` \- Following insights mentioned [here](https://www.youtube.com/watch?v=aswbFKE_0Dg&ref=blog.langchain.com) and [here](https://www.anthropic.com/news/claude-2-1-prompting?ref=blog.langchain.com), specific prompt formulations may be needed to improve recall with certain LLMs.

- `提示词设计至关重要`：参考[此处](https://www.youtube.com/watch?v=aswbFKE_0Dg&ref=blog.langchain.com)和[此处](https://www.anthropic.com/news/claude-2-1-prompting?ref=blog.langchain.com)提到的见解，针对某些大语言模型（LLM），可能需要精心设计特定的提示词形式，以提升召回率。

- `Retrieval vs reasoning` \- Performance degrades when the LLM is asked to reason about the retrieved facts.

- `检索 vs 推理`：当要求大语言模型对已检索出的事实进行推理时，其性能会下降。