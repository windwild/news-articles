---
title: "Promptim: an experimental library for prompt optimization"
source: "LangChain Blog"
url: "https://blog.langchain.com/promptim/"
date: "2024-11-13"
scraped_at: "2026-03-03T07:48:45.130491519+00:00"
language: "en-zh"
translated: true
---

[Promptim](https://github.com/hinthornw/promptimizer?ref=blog.langchain.com) is an experimental **prompt** **optimization** library to help you systematically improve your AI systems.

[Promptim](https://github.com/hinthornw/promptimizer?ref=blog.langchain.com) 是一个实验性的**提示词（prompt）优化**库，旨在帮助您系统性地提升 AI 系统性能。

[Promptim](https://github.com/hinthornw/promptimizer?ref=blog.langchain.com) automates the process of improving prompts on specific tasks. You provide initial prompt, a dataset, and custom evaluators (and optional human feedback), and `promptim` runs an optimization loop to produce a refined prompt that aims to outperform the original.

[Promptim](https://github.com/hinthornw/promptimizer?ref=blog.langchain.com) 自动化了在特定任务上优化提示词的过程。您只需提供初始提示词、一个数据集、自定义评估器（以及可选的人工反馈），`promptim` 就会运行一个优化循环，生成一个经过精炼的提示词，力求超越原始版本。

## From evaluation-driven development to prompt optimization

## 从“评估驱动开发”到提示词优化

A core responsibility of AI engineers is prompt engineering. This involves manually tweaking the prompt to produce better results.

AI 工程师的一项核心职责是提示词工程（prompt engineering），即通过人工调整提示词来获得更优结果。

A useful way to approach this is through **evaluation-driven development**. This involves first creating a dataset of inputs (and optionally, expected outputs) and then defining a number of evaluation metrics. Every time you make a change to the prompt, you can run it over the dataset and then score the outputs. In this way, you can measure the performance of your prompt and make sure its improving, or at the very least not regressing. Tools like [LangSmith](https://smith.langchain.com/?ref=blog.langchain.com) help with dataset curation and evaluation.

一种行之有效的方法是采用**评估驱动开发（evaluation-driven development）**：首先构建一个包含输入（以及可选的期望输出）的数据集，再定义若干评估指标；每次修改提示词后，均可在该数据集上运行并对其输出进行打分。由此，您便能量化提示词的性能表现，确保其持续改进，或至少不发生退化。[LangSmith](https://smith.langchain.com/?ref=blog.langchain.com) 等工具可协助完成数据集构建与评估工作。

The idea behind prompt optimization is to use these well-defined datasets and evaluation metrics to automatically improve the prompt. You can suggest changes to the prompt in an automated way, and then score the new prompt with this evaluation method. Tools like [DSPy](https://github.com/stanfordnlp/dspy?ref=blog.langchain.com) have been pioneering efforts like this for a while.

提示词优化的核心思想，正是利用这些明确定义的数据集和评估指标，自动改进提示词。您可以借助自动化方式提出提示词修改建议，并用上述评估方法对新提示词进行打分。[DSPy](https://github.com/stanfordnlp/dspy?ref=blog.langchain.com) 等工具已在此方向上进行了长期探索与实践。

## Why do prompt optimization?

## 为何要开展提示词优化？

There are several motivations for prompt optimization:

提示词优化具有多重动因：

**Save time**: Manual prompt engineering can often be a time-intensive process. Automated prompt optimization can speed up prompt engineering efforts and save engineering time.

**节省时间**：人工提示词工程往往耗时较长；自动化提示词优化可显著加快工程迭代速度，节约工程师时间。

**Bring rigor**: Prompt engineering is sometimes more of an art than a science – so this brings some rigor to the process. Note that evaluation-driven development in general can help accomplish this.

**增强严谨性**：提示词工程有时更像一门艺术而非科学——而提示词优化则为其注入了更多科学性与严谨性。需指出的是，广义上的评估驱动开发本身亦有助于实现这一目标。

**Facilitate swapping between models:** Different models often require different prompting strategies. Switching model providers isn't as simple as changing the URL you are calling; you also often need to change the prompt. Prompt optimization can speed up that process, as you focus most of your effort on developing evals (which are model agnostic) as opposed to prompting (which is not model agnostic).

**便于在不同模型间切换：** 不同模型通常需要不同的提示策略。切换模型提供商并非仅需更改所调用的 URL 那么简单；你往往还需调整提示词本身。提示优化可加速这一过程——你可将主要精力集中于开发评估指标（evals，与模型无关），而非反复调试提示词（提示词本身高度依赖具体模型）。

## How Promptim works

## Promptim 的工作原理

We're excited to release our first attempt at prompt optimization. It is an open source library ( [promptim](https://github.com/hinthornw/promptimizer?ref=blog.langchain.com)) that integrates with LangSmith (which we use for dataset management, prompt management, tracking results, and (optionally) human labeling.

我们很高兴推出首个提示优化尝试。这是一个开源库（[promptim](https://github.com/hinthornw/promptimizer?ref=blog.langchain.com)），与 LangSmith 深度集成（我们使用 LangSmith 进行数据集管理、提示词管理、结果追踪，以及（可选的）人工标注）。

The core algorithm is as follows:

核心算法如下：

- Specify a LangSmith dataset, a prompt in LangSmith, and evaluators defined locally. Optionally, you can specify `train`/`dev`/`test` dataset splits.
- 指定一个 LangSmith 数据集、一个 LangSmith 中的提示词，以及本地定义的评估器。可选地，你可指定 `train`/`dev`/`test` 数据集划分。
- We run the initial prompt over the `dev` (or full) dataset to get a baseline score.
- 我们在 `dev`（或完整）数据集上运行初始提示词，以获得基准得分。
- We then loop over all examples in the `train` (or full) dataset. We run the prompt over all examples, then score them. We then pass the results (inputs, outputs, expected outputs, scores) to a **metaprompt** and ask it to suggest changes to the current prompt
- 接着，我们遍历 `train`（或完整）数据集中的所有样本：对每个样本运行当前提示词并评分；随后将结果（输入、输出、期望输出、得分）传入一个 **元提示（metaprompt）**，请其为当前提示词提出修改建议。
- We then use the new updated prompt to compute metrics again on the `dev` split.
- 然后，我们使用更新后的提示词，在 `dev` 划分上重新计算各项指标。
- If the metrics show improvement, the the updated prompt is retained. If no improvement, then the original prompt is kept.
- 若指标显示提升，则保留更新后的提示词；若未提升，则维持原始提示词。
- This is repeated `N` times
- 此流程重复执行 `N` 次。

Optionally, you can add a step where you leave human feedback. This is useful when you don't have good automated metrics, or want to optimize the prompt based on feedback beyond what the automated metrics can provide. This uses [LangSmith's Annotation Queues](https://docs.smith.langchain.com/evaluation/how_to_guides/human_feedback/annotation_queues?ref=blog.langchain.com).

可选地，你可加入人工反馈环节。当缺乏可靠的自动化评估指标，或希望依据超出自动化指标覆盖范围的反馈来优化提示词时，该步骤尤为有用。此功能依托 [LangSmith 的标注队列（Annotation Queues）](https://docs.smith.langchain.com/evaluation/how_to_guides/human_feedback/annotation_queues?ref=blog.langchain.com) 实现。

## Limitations of prompt optimization

## 提示优化的局限性

Although we are excited by prompt optimization, we don't think this is a silver bullet. It's still worthwhile to have a human-in-the-loop in this process - even if it's just to provide a sanity check for the final result. That's part of the reason why we use [LangSmith's Prompt Hub](https://docs.smith.langchain.com/prompt_engineering/concepts?ref=blog.langchain.com) to store prompts — so you can easily review the prompts afterwards.

尽管我们对提示优化充满期待，但并不认为它是一剂“万能灵药”。在此过程中，仍有必要保持人工参与——哪怕仅用于对最终结果进行合理性校验。这正是我们采用 [LangSmith 的提示中心（Prompt Hub）](https://docs.smith.langchain.com/prompt_engineering/concepts?ref=blog.langchain.com) 来存储提示词的原因之一：便于后续轻松审阅所有提示词。

## Comparing Promptim to DSPy

## Promptim 与 DSPy 的对比

DSPy is the leading tool in the optimization space. It's worth comparing our approach to theirs.

DSPy 是当前优化领域最领先的工具。将我们的方法与其进行对比颇具价值。

First, this initial effort is focused on just optimizing a single prompt. DSPy focuses on optimizing your whole "compound AI system". We chose to focus on a single prompt for now as we think it is a more tractable problem at the moment.

首先，本次初步尝试聚焦于仅优化单个提示词（prompt）。而 DSPy 则专注于优化您的整个“复合 AI 系统”。我们现阶段选择聚焦于单个 prompt，是因为我们认为这是一个当前更易处理的问题。

Second, we focus more on still having the human in-the-loop, while DSPy removes the human a bit more. One example of this through hooking this up to annotation queues for human feedback as part of the optimization process. Another example is storing these prompts in LangSmith for easy review after the fact. A final example is tracking evaluation results in LangSmith.

其次，我们更强调保持“人在环路中”（human-in-the-loop），而 DSPy 则在一定程度上弱化了人的参与。一个体现该理念的例子是：将本工具接入标注队列（annotation queues），以便在优化过程中纳入人工反馈；另一个例子是将这些提示词存储在 LangSmith 中，便于后续快速审查；最后一个例子是在 LangSmith 中追踪评估结果。

Third, we focus solely on rewriting the prompt and aim to be really good at that, while DSPy offers a wider breadth of solutions to optimize your system (finetuning, few shot prompting).

第三，我们专注于提示词重写本身，并力求在此单一任务上做到极致；而 DSPy 则提供了更广泛的系统级优化方案（例如模型微调、少样本提示等）。

💡

💡

Because of these differences, we view `promptim` and `dspy` as different tools for different problems.

正因上述差异，我们将 `promptim` 和 `dspy` 视为面向不同问题的两类工具。

## Future work

## 未来工作

As the foundation models stabilize, we are getting more and more excited about prompt optimization. Things we are looking forward to:

随着基础模型日趋稳定，我们对提示词优化愈发充满期待。以下是我们重点关注的方向：

- Pushing more on [dynamic few shot prompting](https://blog.langchain.com/dynamic-few-shot-examples-langsmith-datasets/)
- 深入探索 [动态少样本提示（dynamic few-shot prompting）](https://blog.langchain.com/dynamic-few-shot-examples-langsmith-datasets/)；
- Integrating `promptim` into the LangSmith UI
- 将 `promptim` 集成至 LangSmith 用户界面；
- Adding more optimization methods to `promptim`
- 为 `promptim` 增加更多优化方法；
- Optimizing LangGraph graphs as a whole, not just prompts (ideally through an integration with DSPy)
- 对 LangGraph 图结构进行端到端优化（而不仅限于提示词），理想情况下通过与 DSPy 的集成来实现。

You can [try out Promptim](https://github.com/hinthornw/promptimizer?ref=blog.langchain.com) today: `pip install promptim`. Check out [this YouTube video](https://youtu.be/18ltU1hJ7Dw?ref=blog.langchain.com) for a walkthrough, and drop us a line on [GitHub](https://github.com/langchain-ai/langchain/discussions?ref=blog.langchain.com) or [Twitter](https://x.com/LangChainAI?ref=blog.langchain.com) with any feedback.

您可立即 [试用 Promptim](https://github.com/hinthornw/promptimizer?ref=blog.langchain.com)：运行 `pip install promptim` 即可安装。欢迎观看 [此 YouTube 教程视频](https://youtu.be/18ltU1hJ7Dw?ref=blog.langchain.com)，也欢迎通过 [GitHub 讨论区](https://github.com/langchain-ai/langchain/discussions?ref=blog.langchain.com) 或 [Twitter（X）](https://x.com/LangChainAI?ref=blog.langchain.com) 向我们反馈任何意见或建议。