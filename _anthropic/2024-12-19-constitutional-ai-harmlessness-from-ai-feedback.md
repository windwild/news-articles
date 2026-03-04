---
title: "Constitutional AI: Harmlessness from AI Feedback"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/constitutional-ai-harmlessness-from-ai-feedback"
date: "2024-12-19"
scraped_at: "2026-03-03T07:05:51.423945965+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
&#123;% raw %}

AlignmentResearch

AlignmentResearch（对齐研究）

# Constitutional AI: Harmlessness from AI Feedback

# 宪法式人工智能：借助 AI 反馈实现无害性

Dec 15, 2022

2022 年 12 月 15 日

[Read Paper](https://arxiv.org/abs/2212.08073)

[阅读论文](https://arxiv.org/abs/2212.08073)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——该指数为衡量当今人类与 AI 协作水平提供了一个基准。

## Abstract

## 摘要

As AI systems become more capable, we would like to enlist their help to supervise other AIs. We experiment with methods for training a harmless AI assistant through self-improvement, without any human labels identifying harmful outputs. The only human oversight is provided through a list of rules or principles, and so we refer to the method as 'Constitutional AI'. The process involves both a supervised learning and a reinforcement learning phase. In the supervised phase we sample from an initial model, then generate self-critiques and revisions, and then finetune the original model on revised responses. In the RL phase, we sample from the finetuned model, use a model to evaluate which of the two samples is better, and then train a preference model from this dataset of AI preferences. We then train with RL using the preference model as the reward signal, i.e. we use 'RL from AI Feedback' (RLAIF). As a result we are able to train a harmless but non-evasive AI assistant that engages with harmful queries by explaining its objections to them. Both the SL and RL methods can leverage chain-of-thought style reasoning to improve the human-judged performance and transparency of AI decision making. These methods make it possible to control AI behavior more precisely and with far fewer human labels.

随着 AI 系统能力日益增强，我们希望借助其自身能力来监督其他 AI 系统。本文探索了一种通过自我改进训练无害 AI 助理的方法，整个过程无需人工标注来识别有害输出。唯一的人类监督形式是一份规则或原则清单，因此我们将该方法称为“宪法式人工智能”（Constitutional AI）。该流程包含监督学习（SL）和强化学习（RL）两个阶段：在监督学习阶段，我们从初始模型中采样输出，随后生成自我批评与修订结果，并基于修订后的响应对原始模型进行微调；在强化学习阶段，我们从微调后的模型中采样输出，利用另一个模型评估两个采样结果的优劣，再基于这批由 AI 给出的偏好数据训练一个偏好模型；最后，以该偏好模型作为奖励信号开展强化学习训练，即采用“基于 AI 反馈的强化学习”（RL from AI Feedback, RLAIF）。最终，我们成功训练出一个既无害又不回避问题的 AI 助理——它面对有害提问时，会主动解释自身反对的理由。监督学习与强化学习两种方法均可借助“思维链”（chain-of-thought）式推理，提升人类评估所认可的 AI 决策性能与透明度。这些方法使我们能够更精准地调控 AI 行为，同时大幅减少所需的人工标注量。

## Policy Memo

## 政策备忘录

[Constitutional AI Policy Memo](https://www-cdn.anthropic.com/7512771452629584566b6303311496c262da1006/Anthropic_ConstitutionalAI_v2.pdf)
&#123;% endraw %}
