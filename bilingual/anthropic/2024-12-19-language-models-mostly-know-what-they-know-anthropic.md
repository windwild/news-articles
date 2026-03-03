---
title: "Language Models (Mostly) Know What They Know \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/language-models-mostly-know-what-they-know"
date: "2024-12-19"
scraped_at: "2026-03-03T07:02:30.722175843+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---

AlignmentResearch

AlignmentResearch（对齐研究）

# Language Models (Mostly) Know What They Know

# 语言模型（在很大程度上）了解自身所知

Jul 11, 2022

2022年7月11日

[Read Paper](https://arxiv.org/abs/2207.05221)

[阅读论文](https://arxiv.org/abs/2207.05221)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千场 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流利度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。

## Abstract

## 摘要

We study whether language models can evaluate the validity of their own claims and predict which questions they will be able to answer correctly. We first show that larger models are well-calibrated on diverse multiple choice and true/false questions when they are provided in the right format. Thus we can approach self-evaluation on open-ended sampling tasks by asking models to first propose answers, and then to evaluate the probability "P(True)" that their answers are correct. We find encouraging performance, calibration, and scaling for P(True) on a diverse array of tasks. Performance at self-evaluation further improves when we allow models to consider many of their own samples before predicting the validity of one specific possibility. Next, we investigate whether models can be trained to predict "P(IK)", the probability that "I know" the answer to a question, without reference to any particular proposed answer. Models perform well at predicting P(IK) and partially generalize across tasks, though they struggle with calibration of P(IK) on new tasks. The predicted P(IK) probabilities also increase appropriately in the presence of relevant source materials in the context, and in the presence of hints towards the solution of mathematical word problems. We hope these observations lay the groundwork for training more honest models, and for investigating how honesty generalizes to cases where models are trained on objectives other than the imitation of human writing.

我们研究了语言模型是否能够评估自身主张的有效性，并预测其能正确回答哪些问题。首先，我们发现：当以恰当格式呈现时，更大规模的语言模型在多种多样的选择题和判断题任务上均表现出良好的概率校准性（well-calibrated）。因此，对于开放式采样类任务，我们可采用一种自评方法：先让模型生成答案，再令其评估该答案为正确的概率——即“P(True)”。我们在一系列多样化的任务中观察到，P(True) 在性能、校准性及随模型规模扩展的表现方面均令人鼓舞。若允许模型在预测某一特定答案的有效性之前，先审视自身生成的多个候选答案，则其自评性能将进一步提升。接下来，我们探究模型能否被训练以直接预测“P(IK)”——即模型“知道”某问题答案的概率，且无需依赖任何已提出的特定答案。实验表明，模型在预测 P(IK) 方面表现良好，并能在不同任务间实现一定程度的泛化；但面对新任务时，其对 P(IK) 的校准能力仍显不足。此外，当上下文中包含相关参考资料，或数学应用题中出现解题提示时，模型所预测的 P(IK) 概率也会相应合理地上升。我们希望这些发现能为训练更诚实（honest）的语言模型奠定基础，并进一步推动对“诚实性”泛化能力的研究——尤其在模型训练目标不限于模仿人类文本写作，而拓展至其他优化目标的情形下。