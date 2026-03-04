---
render_with_liquid: false
title: "Benchmarking Query Analysis in High Cardinality Situations"
source: "LangChain Blog"
url: "https://blog.langchain.com/high-cardinality/"
date: "2024-03-15"
scraped_at: "2026-03-03T08:07:04.090950171+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

Several key use cases for LLMs involve returning data in a structured format. Extraction is one such use case - we recently highlighted this with [updated documentation](https://python.langchain.com/docs/use_cases/extraction/?ref=blog.langchain.com) and [a dedicated repo](https://github.com/langchain-ai/langchain-extract?ref=blog.langchain.com). Query analysis is another - we’ve also [updated our documentation](https://python.langchain.com/docs/use_cases/query_analysis/?ref=blog.langchain.com) around this recently. When returning information in a structured format the fields can be a myriad of types: string, boolean, integers. One of the hardest types to correctly handle is high-cardinality categorical values (or enums).

大语言模型（LLM）的若干关键应用场景涉及以结构化格式返回数据。信息抽取（Extraction）便是其中之一——我们近期通过[更新后的文档](https://python.langchain.com/docs/use_cases/extraction/?ref=blog.langchain.com)和[一个专用代码仓库](https://github.com/langchain-ai/langchain-extract?ref=blog.langchain.com)重点介绍了该用例。查询分析（Query Analysis）是另一典型场景——我们近期也[更新了相关文档](https://python.langchain.com/docs/use_cases/query_analysis/?ref=blog.langchain.com)。当以结构化格式返回信息时，字段类型多种多样：字符串（string）、布尔值（boolean）、整数（integer）等。其中最难正确处理的类型之一，便是高基数分类值（high-cardinality categorical values），即枚举值（enums）。

What does “high cardinality categorical values” mean? “Categorical values” refers to values that need to be one of several possible values - e.g. they cannot be an arbitrary number or string, they have to be in an allowed set. By “High cardinality” we mean that there are many valid values.

“高基数分类值”（high cardinality categorical values）是什么意思？“分类值”（categorical values）指必须从若干预定义选项中选取的取值——例如，它不能是任意数字或任意字符串，而必须属于某个被允许的集合。“高基数”（high cardinality）则意味着该集合中存在大量合法取值。

Why is this hard? This is hard because the LLM does not intrinsically know what the possible values the field could be actually are. Therefore, you need to provide information to the LLM about the range of possible values. If you do not do this, then it will make up values. For a small number of possible categorical values, this is easy - you can just put those values in the prompt and ask the LLM nicely to only use those values. However, for a large amount of values it gets tricker.

为何这如此困难？难点在于：大语言模型本身并不天然知晓某字段可能取哪些值。因此，你必须向模型显式提供关于该字段所有可能取值范围的信息；否则，模型便会“凭空编造”值。若可能取值数量较少，这一任务相对简单——你只需将全部可选值列在提示词（prompt）中，并礼貌地要求模型仅从中选择。但当可选值数量极大时，问题便显著复杂化。

As the number of possible values increases, it becomes harder and harder for the LLM to fill in the correct value. First, if the number of possible values gets high enough then they may not fit in context. Second, even if all possible values could fit in context, stuffing them all in would cause issues with speed, cost, and the ability of the LLM to reason over all of that context.

随着可能取值数量持续增加，大语言模型准确填充正确值的难度也逐级攀升。第一，当可选值数量足够庞大时，它们可能根本无法全部容纳于模型上下文窗口（context window）之内；第二，即便所有可选值理论上都能塞进上下文，强行全部注入也会引发响应延迟、成本上升，以及模型难以有效推理如此庞杂上下文等多重问题。

We’ve spent a lot of time thinking about query analysis recently, and when we revamped the documentation for this use case we explicitly added in a page on [how to deal with high cardinality categorical values](https://python.langchain.com/docs/use_cases/query_analysis/how_to/high_cardinality?ref=blog.langchain.com). In this blog, we want to deep dive into a few of the approaches we experimented with and provide concrete benchmarks for how they perform.

近期，我们投入大量精力深入思考查询分析这一场景；在全面重构该用例的文档时，我们特别增设了一篇专题页面，专门介绍[如何应对高基数分类值](https://python.langchain.com/docs/use_cases/query_analysis/how_to/high_cardinality?ref=blog.langchain.com)。本文将深入剖析我们实验验证过的若干方法，并提供具体、可量化的性能基准测试结果。

Here’s a preview of the results, which you can also view in [LangSmith](https://smith.langchain.com/public/8c0a4c25-426d-4582-96fc-d7def170be76/d?ref=blog.langchain.com). Read on for more details:

以下为本次基准测试结果的概览，您亦可在 [LangSmith](https://smith.langchain.com/public/8c0a4c25-426d-4582-96fc-d7def170be76/d?ref=blog.langchain.com) 中查看完整交互式报告。请继续阅读，了解详细分析：

![](images/benchmarking-query-analysis-in-high-cardinality-situations/img_001.jpg)

## The Dataset

## 数据集

You can [view the dataset here.](https://smith.langchain.com/public/8c0a4c25-426d-4582-96fc-d7def170be76/d?ref=blog.langchain.com)

您可[在此查看该数据集](https://smith.langchain.com/public/8c0a4c25-426d-4582-96fc-d7def170be76/d?ref=blog.langchain.com)。

In order to simulate this problem we will imagine a situation where we want to look up books by an author. The author field is a high cardinality categorical variable - there are many different values it could take on, but they should be specific valid author names. In order to test this, we created a dataset of author names and common aliases. For example, Harry Chase could be an alias for Harrison Chase. We would hope that an intelligent system would be able to handle these types of aliases. Once we had this list of names and aliases, we then generated 10,000 other random names. Note that 10,000 is not even really that high of cardinality - for enterprise systems, this could perhaps be in the millions.

为模拟该问题，我们设想一个典型场景：按作者姓名检索图书。“作者”（author）字段即为一个高基数分类变量——其可能取值众多，但每一取值都必须是特定且有效的作者姓名。为开展测试，我们构建了一个包含作者真实姓名及其常见别名的数据集。例如，“Harry Chase”可能是“Harrison Chase”的别名；我们期望一个智能系统能妥善处理此类别名映射关系。在完成该姓名与别名列表后，我们进一步生成了额外的 10,000 个随机姓名。需注意：10,000 远非真正意义上的“高基数”——在企业级系统中，此类分类值的基数往往可达百万量级。

With this dataset created, we then would ask questions like “what are books by Harry Chase about aliens?”. Our query analysis system would be expected to parse this into a structured format, with two fields: topic and author. In this case, the expected result would be {“topic”: “aliens”, “author”: “Harrison Chase”}. We would expect our system to recognize that there was no author named Harry Chase, but that Harrison Chase was probably what the user meant.

在构建完该数据集后，我们随后会提出类似“Harry Chase 写的关于外星人的书有哪些？”这样的问题。我们的查询分析系统应能将此类问题解析为结构化格式，包含两个字段：`topic`（主题）和 `author`（作者）。本例中，期望输出为 `{“topic”: “aliens”, “author”: “Harrison Chase”}`。我们期望系统能识别出并不存在名为 “Harry Chase” 的作者，而用户实际想指的很可能是 “Harrison Chase”。

With this setup, we could run this exercise for the dataset of aliases we created, seeing if they were correctly mapped to the true name. We would also track latency and cost. This type of query analysis system would often be used for search, which means that we would care a reasonable amount about both those factors. For this reason we also restricted all approaches to only make a **single** LLM call. We may benchmark approaches with multiple LLM calls in a future post.

基于这一设定，我们可在前述构建的别名数据集上运行该测试，检验各别名是否被正确映射到其真实姓名。同时，我们还会追踪延迟（latency）与成本（cost）。此类查询分析系统常用于搜索场景，因此我们对这两项指标均给予相当程度的关注。正因如此，我们限定所有方法**仅允许调用一次大语言模型（LLM）**。未来文章中，我们或将对支持多次 LLM 调用的方法进行基准测试。

Below, we present a few different approaches and how they performed.

下文我们将介绍几种不同方法及其表现。

You can see the [full results in LangSmith here](https://smith.langchain.com/public/8c0a4c25-426d-4582-96fc-d7def170be76/d?paginationState=%7B%22pageIndex%22%3A0%2C%22pageSize%22%3A10%7D&chartedColumn=latency_p50&ref=blog.langchain.com), and [code to reproduce them here](https://langchain-ai.github.io/langchain-benchmarks/notebooks/extraction/high_cardinality.html?ref=blog.langchain.com).

您可在此处查看 [LangSmith 中的完整评测结果](https://smith.langchain.com/public/8c0a4c25-426d-4582-96fc-d7def170be76/d?paginationState=%7B%22pageIndex%22%3A0%2C%22pageSize%22%3A10%7D&chartedColumn=latency_p50&ref=blog.langchain.com)，以及 [用于复现实验的代码](https://langchain-ai.github.io/langchain-benchmarks/notebooks/extraction/high_cardinality.html?ref=blog.langchain.com)。

## Baseline

## 基线方法（Baseline）

First, we benchmarked the baseline of just asking the LLM to do query analysis without giving it knowledge of what valid names could be. As expected, this did not get a single response correct. This is by construction - we are benchmarking a dataset which explicitly asks for authors by their aliases.

首先，我们以“仅让 LLM 执行查询分析、但不向其提供任何合法姓名知识”作为基线方法进行评测。不出所料，该方法未在任一测试样本上给出正确答案。这实属设计使然——我们所评测的数据集本身即刻意要求模型根据作者别名来识别其真实姓名。

## Context Stuffing

## 上下文填充法（Context Stuffing）

In this approach we stuffed all the 10,000 legitimate author names into the prompt and asked the LLM to do the query analysis keeping in mind that those are the legimate author names. Some models (like GPT-3.5) were not even able to run this at all (due to context window limitations). For other models that had longer context windows, they struggled to accurately choose the right name. GPT-4 only chose the right name on **26%** of examples. The biggest mistake that it would make was extract the name without correcting it. This method was also fairly slow and costly, taking on average **5 seconds** to run and costing **$8.44** in total.

该方法将全部 10,000 个合法作者姓名硬编码进提示词（prompt），并要求 LLM 在执行查询分析时牢记这些才是有效的作者姓名。部分模型（如 GPT-3.5）甚至根本无法运行此方法（受限于上下文窗口长度）。对于上下文窗口更长的其他模型，其仍难以准确选出正确的姓名；GPT-4 仅在 **26%** 的样本中选对了作者名。其最常见错误是直接提取输入中的名字（如 “Harry Chase”），却未将其纠正为真实姓名（如 “Harrison Chase”）。此外，该方法运行速度较慢、成本较高：平均耗时 **5 秒**，总花费达 **8.44 美元**。

## Pre-LLM Filtering

## LLM 前置过滤法（Pre-LLM Filtering）

The next approach we benchmarked was filtering the list of possible values that we passed to the LLM. This would have the benefit of passing a subset of the possible names to the LLM, which would mean that there would be far less names for it to have to consider, hopefully allowing it to do the query analysis more quickly, cheaply, and accurately. This does add in a separate potential failure mode - what if the initial filtering is wrong?

我们评测的下一个方法是对传入 LLM 的候选值列表预先进行过滤。该策略的优势在于：仅向 LLM 提供一小部分可能的姓名，从而大幅减少其需考虑的候选数量，有望提升查询分析的速度、降低成本并增强准确性。但该方法也引入了一种新的潜在失败模式——若初始过滤环节出错，又当如何？

### Filter by Embedding Similarity

### 按嵌入相似度筛选

For the initial filtering we used an embedding based approach and selected the 10 most similar names to the query. Note that here we are comparing the whole query to the name — this isn’t a great comparison!

初始筛选阶段，我们采用基于嵌入（embedding）的方法，选出与查询最相似的 10 个姓名。注意：此处我们将整个查询语句与单个姓名进行比对——这种比对方式并不理想！

We found that with this approach GPT-3.5 managed to get **57%** of examples correct. This was also much faster and cheaper than the previous method, taking **0.76 seconds** to run on average and costing **$.002** total.

实验发现，采用该方法时，GPT-3.5 在测试样例中准确率为 **57%**。同时，该方法也显著快于并便宜于此前的方法：平均运行耗时仅 **0.76 秒**，总成本仅为 **$0.002**。

### Filter by NGram Similarity

### 按 N 元语法（N-gram）相似度筛选

The second filtering approach we used was to fit a TF-IDF vectorizer to 3-gram character sequences of all the valid names, and to use cosine similarity between the vectorized valid names and the vectorized user input to select the top 10 most relevant valid names to add to the model prompt. Note that here we are comparing the whole query to the name — this isn’t a great comparison!

第二种筛选方法是：针对所有有效姓名，提取其字符级三元组（3-gram）序列，并以此拟合一个 TF-IDF 向量化器；随后，计算向量化后的有效姓名与向量化后的用户输入之间的余弦相似度，从中选取最相关的前 10 个有效姓名，加入模型提示（prompt）中。注意：此处仍是将整个查询语句与单个姓名进行比对——这种比对方式同样不够理想！

We found that with this approach GPT-3.5 managed to get **65%** of examples correct. This was also much faster and cheaper than the previous method, taking **0.57 seconds** to run on average and costing **$.002** total.

实验发现，采用该方法时，GPT-3.5 的准确率提升至 **65%**。该方法同样比此前方法更快、更经济：平均运行耗时降至 **0.57 秒**，总成本仍为 **$0.002**。

## Post-LLM Selection

## 大语言模型后处理筛选（Post-LLM Selection）

The final method we benchmarked involved doing query analysis with the LLM to start and then trying to correct any mistakes after the fact. We first ran a query analysis on the user input and did not put ANY information about what valid author names could be into the prompt. This was the same as the baseline we ran initially. We then ran a step after that which took the name that was in the author field and found the most similar valid name.

我们最终评测的方法是：先由大语言模型（LLM）完成查询分析，再在输出结果基础上进行事后纠错。具体而言，我们首先对用户输入执行查询分析，且在提示中**完全不提供**任何关于有效作者姓名的信息——这与我们最初设定的基线（baseline）完全一致。随后，我们额外增加一个后处理步骤：提取输出中“作者”（author）字段所含的姓名，并在有效姓名库中检索与其最相似的条目。

### Select by Embedding Similarity

### 按嵌入相似度选取

First we did this similarity check by using embeddings.

第一步，我们通过嵌入（embedding）技术执行该相似度比对。

We found that with this approach GPT-3.5 managed to get **83%** of examples correct. This was also much faster and cheaper than the previous method, taking **0.66 seconds** to run on average and costing **$.001** total.

我们发现，采用该方法时，GPT-3.5 在示例中准确率达 **83%**。该方法也比之前的方法快得多、成本更低：平均运行耗时仅 **0.66 秒**，总成本仅为 **$0.001**。

### Select by NGram Similarity

### 基于 N-Gram 相似度的选择

Lastly we tried doing this similarity check using our 3-gram vectorizer.

最后，我们尝试使用自研的 3-gram 向量化器（3-gram vectorizer）执行该相似度检查。

We found that with this approach GPT-3.5 managed to get **74%** of examples correct. This was also much faster and cheaper than the previous method, taking **0.48 seconds** to run on average and costing **$.001** total.

我们发现，采用该方法时，GPT-3.5 在示例中准确率为 **74%**。该方法同样显著快于并便宜于先前的方法：平均运行耗时仅 **0.48 秒**，总成本亦为 **$0.001**。

## Conclusion

## 结论

We benchmarked a variety of methods for doing query analysis with high cardinality categoricals. We constrained ourselves to only being allowed to make a single LLM call, which prevented us from using chaining or agent techniques. This was done to mimic real-world latency constraints. We found that using post-LLM selection via embedding similarity performed best.

我们对多种面向高基数分类变量（high cardinality categoricals）的查询分析方法进行了基准测试。我们限制自身仅能调用大语言模型（LLM）一次，从而排除了链式调用（chaining）或智能体（agent）等技术的使用——此举旨在模拟真实场景中的延迟约束。结果表明，**在 LLM 调用后、基于嵌入向量相似度进行筛选（post-LLM selection via embedding similarity）的效果最佳**。

There are other methods to benchmark. In particular, there are many methods to consider for finding the most similar categorical value (before or after the LLM call). The category used in this dataset is also not as high cardinality as the ones many enterprise systems have to deal with. This dataset had ~10k values, many real world ones have millions. It would be worthwhile to benchmark on higher cardinality data, and more of it.

仍有其他方法值得纳入基准测试。尤其值得注意的是，针对“如何找出最相似的分类值”这一任务（无论发生在 LLM 调用前还是调用后），存在大量可选方案。此外，本数据集所用的分类字段基数（cardinality）远低于许多企业系统实际面临的水平：该数据集仅含约 **10,000 个取值**，而现实中诸多系统需处理**数百万量级**的取值。因此，未来非常有必要在**更高基数、更大规模**的数据上开展进一步基准测试。