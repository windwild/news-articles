---
title: "Fine-tuning ChatGPT: Surpassing GPT-4 Summarization Performance–A 63% Cost Reduction and 11x Speed Enhancement using Synthetic Data and LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/fine-tuning-chatgpt-surpassing-gpt-4-summarization/"
date: "2023-10-10"
scraped_at: "2026-03-03T08:38:29.488713396+00:00"
language: "en-zh"
translated: true
---
{% raw %}

_Editor's Note: This post was written by [_Charlie George_](https://twitter.com/__Charlie_G?ref=blog.langchain.com), machine learning engineer at [_Elicit_](https://elicit.com/?ref=blog.langchain.com)._

_编辑注：本文作者为 [_Charlie George_](https://twitter.com/__Charlie_G?ref=blog.langchain.com)，Elicit 公司的机器学习工程师。_

### Summary

### 摘要

- 使用仅含合成数据（synthetic data）进行微调的 ChatGPT，在新闻文章摘要任务上超越了 GPT-4。  
- 我们借助人类水平的自动化评估方法量化了这一提升效果，具体采用 [ScoreStringEvalChain](https://python.langchain.com/docs/guides/evaluation/string/scoring_eval_chain?ref=blog.langchain.com) 和改进版的 [PairwiseStringEvalChain](https://python.langchain.com/docs/guides/evaluation/comparison/pairwise_string?ref=blog.langchain.com)。

### Context

### 背景

GPT-4 被广泛视为全球最先进的语言模型，常能在少于 1000 字描述的任务中胜过普通人类。这使其成为法律、医疗及科学研究等领域的理想工具——在这些领域中，复杂推理与对细微语义的深刻理解至关重要。

然而，这一接近通用人工智能（AGI）水平的模型也并非没有挑战。许多开发者虽能利用 GPT-4 制作出令人印象深刻的演示，却在将其部署至真实应用场景时遭遇重重障碍。这些障碍包括低速率限制（low rate limits）、高昂成本以及显著延迟。例如，GPT-4 的响应延迟常常以分钟计，严重影响用户体验。

为应对上述挑战，部分开发者选择改用规模更小的模型，如 ChatGPT、Claude 或 LLaMA。但这类模型通常性能不及 GPT-4；加之大语言模型（LLM）评估本身存在难度，实际部署后可能意外出现性能大幅下滑。

解决这些问题的一种潜在方案是**模型微调（fine-tuning）**——即调整模型权重，使其更契合特定任务需求。该方法可在提升性能的同时，有效控制成本与延迟。然而，人工标注数据的收集既昂贵又耗时；此外，传统机器学习指标（如困惑度 perplexity 或 BLEU 分数）无法准确反映真实用户体验，因而难以客观评估微调后模型的实际有效性。

### Synthetic data generation

### 合成数据生成

生成合成数据最简单的方法，是使用更强的“教师模型”（teacher model）输出作为训练目标，来训练一个较弱的“学生模型”（student model）。但这种方法存在固有局限：经此方式微调出的学生模型，其性能上限最多只能与教师模型持平，而实践中往往略逊一筹。

A more interesting approach is to take the data from the teacher model to filter it or improve it in some way before fine-tuning. Filtering could for example involve detecting obviously false answers with some simple rules or using [self-consistency](https://arxiv.org/abs/2203.11171?ref=blog.langchain.com).

一种更有趣的方法是：在微调之前，先从教师模型（teacher model）中提取数据，并对其进行过滤或以某种方式优化。例如，过滤过程可借助一些简单规则识别明显错误的答案，或采用 [自洽性（self-consistency）](https://arxiv.org/abs/2203.11171?ref=blog.langchain.com) 方法。

In this post, we’ll explore using the teacher model to improve the data before fine-tuning. Specifically, we’ll use [chain of density](https://arxiv.org/pdf/2309.04269.pdf?ref=blog.langchain.com)(CoD) prompting. This technique asks GPT-4 to iteratively improve its answer (in this case summaries) step by step. The summaries become more information-dense and are preferred by humans.

本文将探讨如何利用教师模型在微调前提升训练数据质量。具体而言，我们将采用 [密度链（chain of density, CoD）](https://arxiv.org/pdf/2309.04269.pdf?ref=blog.langchain.com) 提示技术。该方法要求 GPT-4 逐步迭代优化其输出（本例中为新闻摘要），使摘要内容愈发精炼、信息密度更高，从而更符合人类偏好。

### Creating the dataset with LangSmith

### 使用 LangSmith 构建数据集

This part is relatively straightforward. We define a CoD news article summarization chain. We then run it over several hundred articles taking the final summary using the [dataset](https://python.langchain.com/docs/guides/langsmith/walkthrough?ref=blog.langchain.com) method to send the results to LangSmith. You can then export it for fine-tuning from the LangSmith UI. The details for fine-tuning ChatGPT can be found [here](https://platform.openai.com/docs/guides/fine-tuning?ref=blog.langchain.com). Because this is a generation rather than classification task, it’s better to use 1 epoch to avoid overfitting.

这部分操作相对直接：我们首先定义一条基于密度链（CoD）的新闻文章摘要生成链；随后，将其应用于数百篇新闻文章，并通过 [dataset](https://python.langchain.com/docs/guides/langsmith/walkthrough?ref=blog.langchain.com) 方法提取最终摘要，上传至 LangSmith。之后，您即可通过 LangSmith 用户界面导出该数据集用于微调。有关 ChatGPT 微调的详细说明，请参阅 [此处](https://platform.openai.com/docs/guides/fine-tuning?ref=blog.langchain.com)。由于本任务属于生成式（而非分类式）任务，为避免过拟合，建议仅使用 1 个训练轮次（epoch）。

### Evaluation

### 评估方法

For final evaluation traditional metrics such as BLEU and ROUGE, while useful, often fall short of accurately capturing the nuances of modern language models. On the other hand, human evaluation, though generally more reliable, is time-consuming and costly. Designing an automated evaluation system seems like an ideal solution, but it too requires human validation to ensure its effectiveness. Thankfully, researchers have already developed automated testing solutions validated against real humans.

在最终评估阶段，传统指标（如 BLEU 和 ROUGE）虽有一定参考价值，却往往难以精准捕捉现代大语言模型的细微表现差异。另一方面，人工评估虽通常更为可靠，但耗时且成本高昂。设计一套自动化评估系统看似理想，但其本身仍需经由真实人类验证，方能确保有效性。所幸，研究人员已开发出若干经人类实证验证的自动化评测方案。

As part of this project, the [PairwiseStringEvalChain](https://python.langchain.com/docs/guides/evaluation/comparison/pairwise_string?ref=blog.langchain.com) has been revamped to more closely follow the [LLM-as-a-judge paper](https://arxiv.org/pdf/2306.05685.pdf?ref=blog.langchain.com). This paper introduced the automated ranking framework for [Chatbot Arena](https://chat.lmsys.org/?ref=blog.langchain.com). We’ve also added the 1-10 scoring method from the paper (see [ScoreStringEvalChain](https://python.langchain.com/docs/guides/evaluation/string/scoring_eval_chain?ref=blog.langchain.com)). Both chains achieved 85% agreement with humans in the paper when using GPT-4. This is higher than the agreement between different humans. We test GPT-4 zero-shot, GPT-4 w/ CoD and ChatGPT fine-tuned on chain of density summaries. We used the same zero-shot prompt as the chain of density paper.

作为本项目的一部分，[PairwiseStringEvalChain](https://python.langchain.com/docs/guides/evaluation/comparison/pairwise_string?ref=blog.langchain.com) 已依据 [LLM-as-a-judge 论文](https://arxiv.org/pdf/2306.05685.pdf?ref=blog.langchain.com) 进行重构，该论文提出了面向 [Chatbot Arena](https://chat.lmsys.org/?ref=blog.langchain.com) 的自动化排序框架。我们还引入了该论文提出的 1–10 分制评分方法（参见 [ScoreStringEvalChain](https://python.langchain.com/docs/guides/evaluation/string/scoring_eval_chain?ref=blog.langchain.com)）。当使用 GPT-4 时，上述两种评估链在论文中均实现了与人类评估者 85% 的一致率——这一数值甚至高于不同人类评估者之间的一致率。我们对比测试了三种模型：GPT-4 零样本（zero-shot）、GPT-4 + 密度链（CoD）以及在密度链摘要数据上微调后的 ChatGPT。所有实验均采用与密度链论文一致的零样本提示模板。

### Results

### 实验结果

![](images/fine-tuning-chatgpt-surpassing-gpt-4-summarization-performance_a-63-cost-reducti/img_001.png)Caption: _Fine-tuned ChatGPT surpasses GPT-4 zero-shot and is close to GPT-4 w/ CoD_

![](images/fine-tuning-chatgpt-surpassing-gpt-4-summarization-performance_a-63-cost-reducti/img_001.png)图注：_微调后的 ChatGPT 性能超越 GPT-4 零样本模式，且接近 GPT-4 + 密度链（CoD）模式_

![](images/fine-tuning-chatgpt-surpassing-gpt-4-summarization-performance_a-63-cost-reducti/img_002.png)Caption: _Fine-tuned ChatGPT is over 11x faster than GPT-4 zero-shot and 33x faster than GPT-4 w/ CoD_

![](images/fine-tuning-chatgpt-surpassing-gpt-4-summarization-performance_a-63-cost-reducti/img_002.png)图注：_微调后的 ChatGPT 运行速度比 GPT-4 零样本模式快 11 倍以上，比 GPT-4 + 密度链（CoD）模式快 33 倍_

![](images/fine-tuning-chatgpt-surpassing-gpt-4-summarization-performance_a-63-cost-reducti/img_003.png)Caption: _Fine-tuned ChatGPT is 63% cheaper than GPT-4 zero-shot and 84% cheaper than GPT-4 w/ CoD_

![](images/fine-tuning-chatgpt-surpassing-gpt-4-summarization-performance_a-63-cost-reducti/img_003.png)图注：_微调后的 ChatGPT 成本比 GPT-4 零样本模式低 63%，比 GPT-4 + 密度链（CoD）模式低 84%_

Fine-tuned ChatGPT also achieves a win rate of 96% against GPT-4 zero-shot in pairwise evaluation. In summary, while the performance of fine-tuned ChatGPT is still slightly below that of GPT-4 with chain of density prompting for summarization it far surpasses zero-shot GPT-4 while being 63% cheaper and 11x faster.

在成对比较评估（pairwise evaluation）中，微调后的 ChatGPT 对阵 GPT-4 零样本模式的胜率达 96%。综上所述：尽管微调后的 ChatGPT 在摘要任务上的性能仍略逊于采用密度链（CoD）提示的 GPT-4，但它已显著超越 GPT-4 零样本模式，同时成本降低 63%，推理速度提升 11 倍。

### A LangChain to production workflow

### 从 LangChain 到生产环境的工作流

- 使用 LangChain 快速搭建一个 MVP 应用。你可以实现 RAG、多链（multiple chains）、少样本提示（few-shot prompts）、智能体（agents）等——暂无需担心成本或延迟问题。  
- 使用 LangChain 快速搭建一个 MVP 应用。你可以实现检索增强生成（RAG）、多链（multiple chains）、少样本提示（few-shot prompts）、智能体（agents）等——暂无需担心成本或延迟问题。

- 验证该 MVP 是否满足用户需求。若不满足，可借助 LangSmith 快速迭代与调试。  
- 验证该 MVP 是否满足用户需求。若不满足，可借助 LangSmith 快速迭代与调试。

- 当你对 MVP 的性能感到满意后，即可利用 LangSmith，基于现有应用输出的数据，将逻辑蒸馏（distil）至 ChatGPT 或 Llama 等更轻量级模型。  
- 当你对 MVP 的性能感到满意后，即可利用 LangSmith，基于现有应用输出的数据，将逻辑蒸馏（distil）至 ChatGPT 或 Llama 等更轻量级模型。

- 使用评估链（eval chains）——例如 [ScoreStringEvalChain](https://python.langchain.com/docs/guides/evaluation/string/scoring_eval_chain?ref=blog.langchain.com) 和 [PairwiseStringEvalChain](https://python.langchain.com/docs/guides/evaluation/comparison/pairwise_string?ref=blog.langchain.com) ——将蒸馏后的模型与原始应用进行对比评估。  
- 使用评估链（eval chains）——例如 [ScoreStringEvalChain](https://python.langchain.com/docs/guides/evaluation/string/scoring_eval_chain?ref=blog.langchain.com) 和 [PairwiseStringEvalChain](https://python.langchain.com/docs/guides/evaluation/comparison/pairwise_string?ref=blog.langchain.com) ——将蒸馏后的模型与原始应用进行对比评估。

- 将这一快速、可扩展的版本部署至生产环境。  
- 将这一快速、可扩展的版本部署至生产环境。

### Conclusion

### 结论

The results from our study indicate that synthetic data, when used effectively, is an extremely powerful tool in enhancing the capabilities of language models. The use of chain of density prompting to fine-tune ChatGPT, yielded significant improvements in performance surpassing GPT-4. The fine-tuned version of ChatGPT also outperformed GPT-4 in terms of cost and latency making it a realistic option for real-world deployment.

本研究结果表明，合成数据在被有效使用时，是提升语言模型能力的一项极为强大的工具。“密度链式提示”（chain of density prompting）用于微调 ChatGPT 后，其性能显著提升，甚至超越了 GPT-4。此外，该微调后的 ChatGPT 版本在成本和延迟方面也优于 GPT-4，因而成为真实场景部署中切实可行的选择。

It is worth noting that there’s nothing special about this particular summarization approach. This method could be applied to distill any complicated set of GPT-4 steps. LangChain is the ideal tool for creating complex chains, distilling them into smaller models with LangSmith and finally doing automated evaluations as described above.

值得指出的是，这种特定的摘要方法本身并无特殊之处；该方法可广泛应用于蒸馏任意复杂的 GPT-4 处理流程。LangChain 正是构建复杂链式逻辑的理想工具；配合 LangSmith，可将这些复杂链蒸馏为更小、更高效的模型；再结合上文所述的自动化评估流程，形成端到端的优化闭环。

Utilizing automated human-level evaluation in LangChain, particularly with the revamped PairwiseStringEvalChain and the newly added ScoreStringEvalChain, provides a fast, reliable and cost-effective assessment of real-world performance.

在 LangChain 中采用自动化、类人级别的评估机制——尤其是重构升级后的 PairwiseStringEvalChain 以及新加入的 ScoreStringEvalChain——可为真实场景下的模型表现提供快速、可靠且高性价比的评估。

In conclusion, fine-tuning ChatGPT using synthetic data exhibits great potential in yielding high-performing yet fast and cost-effective language models. This approach opens pathways for the next generation of AI-first apps to scale millions of users while maintaining performance.

综上所述，利用合成数据对 ChatGPT 进行微调，展现出巨大潜力：既能获得高性能，又兼具低延迟与低成本优势。这一方法为下一代以 AI 为先（AI-first）的应用铺平道路，使其得以服务数百万用户，同时持续保障性能水准。
{% endraw %}
