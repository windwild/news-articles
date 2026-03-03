---
title: "Scaling Laws and Interpretability of Learning from Repeated Data"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/scaling-laws-and-interpretability-of-learning-from-repeated-data"
date: "2024-12-19"
scraped_at: "2026-03-03T06:57:12.648867846+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---

InterpretabilityResearch

可解释性研究

# Scaling Laws and Interpretability of Learning from Repeated Data

# 从重复数据中学习的缩放定律与可解释性

May 21, 2022

2022年5月21日

[Read Paper](https://arxiv.org/abs/2205.10487)

[阅读论文](https://arxiv.org/abs/2205.10487)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流利度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。


## Abstract

## 摘要

Recent large language models have been trained on vast datasets, but also often on repeated data, either intentionally for the purpose of upweighting higher quality data, or unintentionally because data deduplication is not perfect and the model is exposed to repeated data at the sentence, paragraph, or document level. Some works have reported substantial negative performance effects of this repeated data. In this paper we attempt to study repeated data systematically and to understand its effects mechanistically. To do this, we train a family of models where most of the data is unique but a small fraction of it is repeated many times. We find a strong double descent phenomenon, in which repeated data can lead test loss to increase midway through training. A predictable range of repetition frequency leads to surprisingly severe degradation in performance. For instance, performance of an 800M parameter model can be degraded to that of a 2x smaller model (400M params) by repeating 0.1% of the data 100 times, despite the other 90% of the training tokens remaining unique. We suspect there is a range in the middle where the data can be memorized and doing so consumes a large fraction of the model's capacity, and this may be where the peak of degradation occurs. Finally, we connect these observations to recent mechanistic interpretability work - attempting to reverse engineer the detailed computations performed by the model - by showing that data repetition disproportionately damages copying and internal structures associated with generalization, such as induction heads, providing a possible mechanism for the shift from generalization to memorization. Taken together, these results provide a hypothesis for why repeating a relatively small fraction of data in large language models could lead to disproportionately large harms to performance.

近期的大语言模型虽在海量数据集上训练，但也常遭遇重复数据：或是为提升高质量数据权重而有意重复；或是因去重不彻底而无意引入——模型可能在句子、段落乃至文档层面反复接触相同内容。已有研究指出，此类重复数据会显著损害模型性能。本文旨在系统性地研究重复数据，并从机制层面理解其影响。为此，我们训练了一系列模型：其中绝大多数训练数据是唯一的，仅一小部分被高频重复。实验发现强烈的“双下降”（double descent）现象——即重复数据会导致测试损失在训练中期异常上升。在某一可预测的重复频次范围内，模型性能会出现出人意料的严重退化。例如，对一个参数量为 8 亿（800M）的模型，仅将 0.1% 的数据重复 100 次，其性能便退化至参数量仅为一半（4 亿，400M）的模型水平，而其余 90% 的训练 token 仍保持唯一性。我们推测，在中间某一段重复频次区间内，模型倾向于记忆这些重复数据，而该过程会占用模型大量容量，这或许正是性能退化达到峰值的区域。最后，我们将上述发现与近期的**机制可解释性**（mechanistic interpretability）研究相联系——即尝试逆向工程模型所执行的精细计算过程——并证明：数据重复尤其损害模型的“复制”能力及与泛化能力相关的关键内部结构（如归纳头，induction heads），从而为模型从泛化能力主导转向记忆能力主导提供了一种潜在机制。综上，这些结果共同提出一种假说：在大语言模型中，即使仅重复相对少量的数据，也可能引发远超比例的、严重的性能损害。