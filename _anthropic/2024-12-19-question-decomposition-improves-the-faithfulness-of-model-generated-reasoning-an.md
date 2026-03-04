---
render_with_liquid: false
title: "Question Decomposition Improves the Faithfulness of Model-Generated Reasoning \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/question-decomposition-improves-the-faithfulness-of-model-generated-reasoning"
date: "2024-12-19"
scraped_at: "2026-03-03T06:58:31.784898704+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
render_with_liquid: false
render_with_liquid: false

AlignmentResearch

AlignmentResearch（对齐研究）

# Question Decomposition Improves the Faithfulness of Model-Generated Reasoning

# 问题分解可提升模型生成推理的保真度

Jul 18, 2023

2023年7月18日

[Download Paper](https://www-cdn.anthropic.com/8154fb1d828cdc390dc1fa442d84034948679c47/question-decomposition-improves-the-faithfulness-of-model-generated-reasoning.pdf)

[下载论文](https://www-cdn.anthropic.com/8154fb1d828cdc390dc1fa442d84034948679c47/question-decomposition-improves-the-faithfulness-of-model-generated-reasoning.pdf)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千场 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——该指数为衡量当今人类与 AI 协作水平提供了一个基准。

## Abstract

## 摘要

As large language models (LLMs) perform more difficult tasks, it becomes harder to verify the correctness and safety of their behavior. One approach to help with this issue is to prompt LLMs to externalize their reasoning, e.g., by having them generate step-by-step reasoning as they answer a question (Chain-of-Thought; CoT). The reasoning may enable us to check the process that models use to perform tasks. However, this approach relies on the stated reasoning faithfully reflecting the model’s actual reasoning, which is not always the case. To improve over the faithfulness of CoT reasoning, we have models generate reasoning by decomposing questions into subquestions. Decomposition-based methods achieve strong performance on question-answering tasks, sometimes approaching that of CoT while improving the faithfulness of the model’s stated reasoning on several recently-proposed metrics. By forcing the model to answer simpler subquestions in separate contexts, we greatly increase the faithfulness of model-generated reasoning over CoT, while still achieving some of the performance gains of CoT. Our results show it is possible to improve the faithfulness of model-generated reasoning; continued improvements may lead to reasoning that enables us to verify the correctness and safety of LLM behavior.

随着大语言模型（LLM）承担日益复杂的任务，验证其行为的正确性与安全性也愈发困难。一种应对该挑战的方法是引导 LLM 将其推理过程显式地外化出来，例如：要求模型在回答问题时生成逐步推理（即“思维链”，Chain-of-Thought；CoT）。此类推理有助于我们检验模型执行任务所依赖的具体过程。然而，该方法的有效性高度依赖于模型所陈述的推理是否真实、忠实地反映了其内部实际的推理路径——而这一前提并不总能成立。为提升推理过程的保真度（faithfulness），我们提出让模型通过将原始问题分解为若干子问题的方式生成推理。基于分解的方法在问答任务中展现出强劲性能，有时可媲美 CoT，同时在多个近期提出的评估指标上显著提升了模型所陈述推理的保真度。通过强制模型在相互独立的上下文中分别回答更简单的子问题，我们大幅提高了模型生成推理相对于 CoT 的保真度，同时仍保留了 CoT 所带来的部分性能增益。我们的实验结果表明：提升模型生成推理的保真度是可行的；持续改进有望催生出真正可被人类检验的推理过程，从而助力我们验证 LLM 行为的正确性与安全性。