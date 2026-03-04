---
render_with_liquid: false
title: "Measuring Faithfulness in Chain-of-Thought Reasoning \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/measuring-faithfulness-in-chain-of-thought-reasoning"
date: "2024-12-19"
scraped_at: "2026-03-03T07:01:16.252794676+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
render_with_liquid: false
render_with_liquid: false

AlignmentResearch

# Measuring Faithfulness in Chain-of-Thought Reasoning

# 衡量思维链推理的忠实性

Jul 18, 2023

2023年7月18日

[Download Paper](https://www-cdn.anthropic.com/827afa7dd36e4afbb1a49c735bfbb2c69749756e/measuring-faithfulness-in-chain-of-thought-reasoning.pdf)

[下载论文](https://www-cdn.anthropic.com/827afa7dd36e4afbb1a49c735bfbb2c69749756e/measuring-faithfulness-in-chain-of-thought-reasoning.pdf)

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作方式的一项基准指标。

## Abstract

## 摘要

Large language models (LLMs) perform better when they produce step-by-step, “Chain-ofThought” (CoT) reasoning before answering a question, but it is unclear if the stated reasoning is a faithful explanation of the model’s actual reasoning (i.e., its process for answering the question). We investigate hypotheses for how CoT reasoning may be unfaithful, by examining how the model predictions change when we intervene on the CoT (e.g., by adding mistakes or paraphrasing it). Models show large variation across tasks in how strongly they condition on the CoT when predicting their answer, sometimes relying heavily on the CoT and other times primarily ignoring it. CoT’s performance boost does not seem to come from CoT’s added test-time compute alone or from information encoded via the particular phrasing of the CoT. As models become larger and more capable, they produce less faithful reasoning on most tasks we study. Overall, our results suggest that CoT can be faithful if the circumstances such as the model size and task are carefully chosen.

当大语言模型（LLM）在回答问题前生成逐步的“思维链”（Chain-of-Thought, CoT）推理时，其表现往往更优；但目前尚不清楚，模型所呈现的推理过程是否真实、忠实地反映了其实际推理路径（即其回答问题的真实决策过程）。我们通过干预思维链（例如，在其中引入错误或对其进行改写），观察模型预测结果如何变化，从而检验若干关于 CoT 推理可能“不忠实”的假设。实验发现，不同任务中，模型在预测答案时对 CoT 的依赖程度差异巨大：有时高度依赖 CoT，有时则几乎完全忽略它。CoT 带来的性能提升，似乎并非单纯源于其在推理阶段额外引入的计算开销，也非来自 CoT 特定措辞所编码的信息。随着模型规模增大、能力增强，我们在多数研究任务中观察到，其生成的推理反而变得越来越不忠实。总体而言，我们的结果表明：只要谨慎选择模型规模与具体任务等条件，CoT 推理仍可具备较高的忠实性。