---
title: "Red Teaming Language Models to Reduce Harms: Methods, Scaling Behaviors, and Lessons Learned \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/red-teaming-language-models-to-reduce-harms-methods-scaling-behaviors-and-lessons-learned"
date: "2024-12-19"
scraped_at: "2026-03-03T06:58:07.381454784+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
{% raw %}

Societal Impacts

社会影响

# Red Teaming Language Models to Reduce Harms: Methods, Scaling Behaviors, and Lessons Learned

# 通过“红队演练”语言模型以减少危害：方法、规模扩展规律与经验总结

Aug 22, 2022

2022年8月22日

[Read Paper](https://arxiv.org/abs/2209.07858)

[阅读论文](https://arxiv.org/abs/2209.07858)

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数（AI Fluency Index）”——用于衡量当今人类与 AI 协作水平的基准指标。

## Abstract

## 摘要

We describe our early efforts to red team language models in order to simultaneously discover, measure, and attempt to reduce their potentially harmful outputs. We make three main contributions. First, we investigate scaling behaviors for red teaming across 3 model sizes (2.7B, 13B, and 52B parameters) and 4 model types: a plain language model (LM); an LM prompted to be helpful, honest, and harmless; an LM with rejection sampling; and a model trained to be helpful and harmless using reinforcement learning from human feedback (RLHF). We find that the RLHF models are increasingly difficult to red team as they scale, and we find a flat trend with scale for the other model types. Second, we release our dataset of 38,961 red team attacks for others to analyze and learn from. We provide our own analysis of the data and find a variety of harmful outputs, which range from offensive language to more subtly harmful non-violent unethical outputs. Third, we exhaustively describe our instructions, processes, statistical methodologies, and uncertainty about red teaming. We hope that this transparency accelerates our ability to work together as a community in order to develop shared norms, practices, and technical standards for how to red team language models.

本文介绍了我们早期开展的语言模型“红队演练”工作，旨在同步发现、评估并尝试减少其潜在有害输出。本研究主要有三方面贡献：  
第一，我们在三种模型规模（2.7B、13B 和 52B 参数量）及四种模型类型上系统考察了红队演练的规模扩展规律，这四类模型分别为：基础语言模型（LM）；经提示（prompting）引导以实现“有益、诚实、无害”的语言模型；采用拒绝采样（rejection sampling）机制的语言模型；以及通过人类反馈强化学习（RLHF）训练而成、旨在兼具“有益性与无害性”的模型。结果表明，随着规模增大，RLHF 模型越来越难以被红队攻破，而其余三类模型则呈现出与规模无关的稳定（平缓）趋势。  
第二，我们公开发布包含 38,961 条红队攻击样本的数据集，供社区分析与学习。我们对数据集进行了自主分析，发现其中存在多种有害输出，涵盖从明显冒犯性语言，到更为隐晦、非暴力但违背伦理的不当内容。  
第三，我们详尽阐述了红队演练所用指令、操作流程、统计方法，以及对红队演练本身存在的不确定性认知。我们期望这种透明化实践，能加速整个社区协同合作的进程，共同建立关于语言模型红队演练的共识性规范、最佳实践与技术标准。

## Policy Memo

## 政策备忘录

[Red Teaming Policy Memo](https://www-cdn.anthropic.com/82564d4ec2451b2eed2e0796b7c658fc989f0c1a/Anthropic_RedTeaming.pdf)
{% endraw %}
