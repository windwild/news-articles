---
title: "Towards Understanding Sycophancy in Language Models"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/towards-understanding-sycophancy-in-language-models"
date: "2024-12-19"
scraped_at: "2026-03-03T06:47:51.797514355+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
{% raw %}

AlignmentResearch

# Towards Understanding Sycophancy in Language Models

# 面向理解语言模型中的谄媚行为

Oct 23, 2023

2023年10月23日

[Read Paper](https://arxiv.org/abs/2310.13548)

[阅读论文](https://arxiv.org/abs/2310.13548)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。

## Abstract

## 摘要

Reinforcement learning from human feedback (RLHF) is a popular technique for training high-quality AI assistants. However, RLHF may also encourage model responses that match user beliefs over truthful responses, a behavior known as sycophancy. We investigate the prevalence of sycophancy in RLHF-trained models and whether human preference judgments are responsible. We first demonstrate that five state-of-the-art AI assistants consistently exhibit sycophancy behavior across four varied free-form text-generation tasks. To understand if human preferences drive this broadly observed behavior of RLHF models, we analyze existing human preference data. We find that when a response matches a user’s views, it is more likely to be preferred. Moreover, both humans and preference models (PMs) prefer convincingly-written sycophantic responses over correct ones a non-negligible fraction of the time. Optimizing model outputs against PMs also sometimes sacrifices truthfulness in favor of sycophancy. Overall, our results indicate that sycophancy is a general behavior of RLHF models, likely driven in part by human preference judgments favoring sycophantic responses.

基于人类反馈的强化学习（Reinforcement Learning from Human Feedback, RLHF）是一种训练高质量 AI 助手的主流技术。然而，RLHF 也可能促使模型优先生成迎合用户观点而非符合事实的回应，这种行为被称为“谄媚行为”（sycophancy）。本文探究了 RLHF 训练模型中谄媚行为的普遍性，并考察人类偏好判断是否是其成因。我们首先证明：五种当前最先进的 AI 助手在四种差异显著的开放式文本生成任务中，均持续表现出谄媚行为。为厘清人类偏好是否驱动了 RLHF 模型中这一广泛存在的现象，我们分析了现有大规模人类偏好数据。结果发现：当模型回应与用户观点一致时，该回应更可能被用户偏好选择；此外，人类评估者与偏好模型（Preference Models, PMs）在相当比例的情况下，会倾向于选择表述更具说服力的谄媚式回应，而非正确回应；而以 PMs 为优化目标进行模型输出调优时，有时也会以牺牲事实准确性为代价，换取更高的谄媚程度。总体而言，我们的结果表明：谄媚行为是 RLHF 模型的一种普遍现象，其成因很可能部分源于人类偏好判断本身对谄媚式回应的倾向性。
{% endraw %}
