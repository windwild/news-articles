---
title: "Training a Helpful and Harmless Assistant with Reinforcement Learning from Human Feedback"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/training-a-helpful-and-harmless-assistant-with-reinforcement-learning-from-human-feedback"
date: "2024-12-19"
scraped_at: "2026-03-03T06:47:00.110756037+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
{% raw %}

AlignmentResearch

# Training a Helpful and Harmless Assistant with Reinforcement Learning from Human Feedback

# 使用基于人类反馈的强化学习训练有益且无害的助手

Apr 12, 2022

2022年4月12日

[Read Paper](https://arxiv.org/abs/2204.05862)

[阅读论文](https://arxiv.org/abs/2204.05862)

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建了“AI 流畅度指数”（AI Fluency Index）——该指数为衡量当今人类与 AI 协作水平提供了一个基准。

## Abstract

## 摘要

We apply preference modeling and reinforcement learning from human feedback (RLHF) to finetune language models to act as helpful and harmless assistants. We find this alignment training improves performance on almost all NLP evaluations, and is fully compatible with training for specialized skills such as python coding and summarization. We explore an iterated online mode of training, where preference models and RL policies are updated on a weekly cadence with fresh human feedback data, efficiently improving our datasets and models. Finally, we investigate the robustness of RLHF training, and identify a roughly linear relation between the RL reward and the square root of the KL divergence between the policy and its initialization. Alongside our main results, we perform peripheral analyses on calibration, competing objectives, and the use of OOD detection, compare our models with human writers, and provide samples from our models using prompts appearing in recent related work.

我们应用偏好建模（preference modeling）和基于人类反馈的强化学习（Reinforcement Learning from Human Feedback, RLHF），对语言模型进行微调，使其能够充当有益且无害的助手。我们发现，此类对齐训练（alignment training）几乎在所有自然语言处理（NLP）评测任务上均提升了模型性能，并且完全兼容面向特定技能（如 Python 编程与文本摘要）的专项训练。我们探索了一种迭代式在线训练模式：偏好模型与强化学习策略每周利用最新的人类反馈数据进行更新，从而高效地提升数据集与模型质量。最后，我们考察了 RLHF 训练的鲁棒性，发现强化学习奖励（RL reward）与策略（policy）与其初始状态之间 KL 散度的平方根大致呈线性关系。除主要成果外，我们还开展了若干辅助性分析，涵盖模型校准（calibration）、多目标冲突（competing objectives）、分布外检测（OOD detection）的应用；将我们的模型与人类作者进行对比；并使用近期相关工作中出现的提示词（prompts）生成模型输出样例。
{% endraw %}
