---
title: "The Capacity for Moral Self-Correction in Large Language Models"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/the-capacity-for-moral-self-correction-in-large-language-models"
date: "2024-12-19"
scraped_at: "2026-03-03T06:49:50.717887091+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
&#123;% raw %}

Societal Impacts

社会影响

# The Capacity for Moral Self-Correction in Large Language Models

# 大型语言模型的道德自我修正能力

Feb 15, 2023

2023年2月15日

[Read Paper](https://arxiv.org/abs/2302.07459)

[阅读论文](https://arxiv.org/abs/2302.07459)

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——该指数为衡量当今人类与 AI 协作水平提供了一个基准。

## Abstract

## 摘要

We test the hypothesis that language models trained with reinforcement learning from human feedback (RLHF) have the capability to "morally self-correct" -- to avoid producing harmful outputs -- if instructed to do so. We find strong evidence in support of this hypothesis across three different experiments, each of which reveal different facets of moral self-correction. We find that the capability for moral self-correction emerges at 22B model parameters, and typically improves with increasing model size and RLHF training. We believe that at this level of scale, language models obtain two capabilities that they can use for moral self-correction: (1) they can follow instructions and (2) they can learn complex normative concepts of harm like stereotyping, bias, and discrimination. As such, they can follow instructions to avoid certain kinds of morally harmful outputs. We believe our results are cause for cautious optimism regarding the ability to train language models to abide by ethical principles.

我们检验了如下假设：经人类反馈强化学习（RLHF）训练的语言模型具备“道德自我修正”能力——即在接收到相应指令时，能够主动避免生成有害内容。我们在三项不同实验中均发现了强有力的支持证据，每项实验分别揭示了道德自我修正能力的不同维度。研究发现，该能力在模型参数量达 220 亿（22B）时开始显现，并通常随模型规模扩大及 RLHF 训练的深入而持续增强。我们认为，在这一规模层级上，语言模型获得了两种可用于道德自我修正的关键能力：（1）遵循指令的能力；（2）学习复杂规范性“伤害”概念的能力，例如刻板印象、偏见与歧视。因此，它们能够依指令规避特定类型的道德上有害输出。我们相信，本研究结果为“通过训练使语言模型遵循伦理原则”这一目标提供了审慎乐观的理由。

## Policy Memo

## 政策备忘录

[Moral Self-Correction Policy Memo](https://www-cdn.anthropic.com/d14f58fe8f611858bc37ff8686bbda71e4927ce6/Anthropic_MoralSelfCorrection_v3.pdf)

[《道德自我修正政策备忘录》](https://www-cdn.anthropic.com/d14f58fe8f611858bc37ff8686bbda71e4927ce6/Anthropic_MoralSelfCorrection_v3.pdf)
&#123;% endraw %}
