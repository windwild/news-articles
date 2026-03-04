---
title: "Predictability and Surprise in Large Generative Models \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/predictability-and-surprise-in-large-generative-models"
date: "2025-11-20"
scraped_at: "2026-03-03T06:44:06.522638279+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
&#123;% raw %}

Societal Impacts

社会影响

# Predictability and Surprise in Large Generative Models

# 大型生成式模型中的可预测性与意外性

Feb 15, 2022

2022年2月15日

[Read Paper](https://arxiv.org/abs/2202.07785)

[阅读论文](https://arxiv.org/abs/2202.07785)

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建了“AI 流畅度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。

## Abstract

## 摘要

Large-scale pre-training has recently emerged as a technique for creating capable, general purpose, generative models such as GPT-3, Megatron-Turing NLG, Gopher, and many others. In this paper, we highlight a counterintuitive property of such models and discuss the policy implications of this property. Namely, these generative models have an unusual combination of predictable loss on a broad training distribution (as embodied in their "scaling laws"), and unpredictable specific capabilities, inputs, and outputs. We believe that the high-level predictability and appearance of useful capabilities drives rapid development of such models, while the unpredictable qualities make it difficult to anticipate the consequences of model deployment. We go through examples of how this combination can lead to socially harmful behavior with examples from the literature and real world observations, and we also perform two novel experiments to illustrate our point about harms from unpredictability. Furthermore, we analyze how these conflicting properties combine to give model developers various motivations for deploying these models, and challenges that can hinder deployment. We conclude with a list of possible interventions the AI community may take to increase the chance of these models having a beneficial impact. We intend this paper to be useful to policymakers who want to understand and regulate AI systems, technologists who care about the potential policy impact of their work, and academics who want to analyze, critique, and potentially develop large generative models.

大规模预训练近年来已成为一种关键技术，用于构建能力强大、通用性强的生成式模型，例如 GPT-3、Megatron-Turing NLG、Gopher 以及众多其他模型。本文重点揭示了此类模型一种反直觉的特性，并探讨该特性所引发的政策含义。具体而言，这些生成式模型呈现出一种非同寻常的组合特征：一方面，在宽泛的训练分布上，其损失函数表现出高度可预测性（体现为其“缩放定律”，scaling laws）；另一方面，其具体能力、输入响应及输出内容却难以预测。我们认为，这种高层次的可预测性及其展现出的实用能力，推动了此类模型的快速发展；而其不可预测性则使得模型部署后的潜在后果难以事先评估。本文通过文献研究与现实观察中的实例，说明这种可预测性与不可预测性的并存如何导致社会危害；同时，我们还设计并开展了两项新颖实验，以直观阐释不可预测性可能带来的风险。此外，我们进一步分析了上述矛盾特性如何共同作用，既为模型开发者提供了多种部署动机，也带来了阻碍部署的实际挑战。最后，我们提出一系列人工智能社区可采取的潜在干预措施，以提升这些模型产生积极社会影响的可能性。本文旨在为以下三类读者提供参考：希望理解并监管 AI 系统的政策制定者、关注自身技术工作潜在政策影响的工程师与技术人员，以及致力于分析、批判乃至开发大型生成式模型的学术研究者。

### Policy Memo

### 政策备忘录

[Predictability and Surprise Memo](https://www-cdn.anthropic.com/4ff80d7f8a98bf096cd543ec61ddc50de3ad8b16/Anthropic_PredictabilityAndSurprise.pdf)
&#123;% endraw %}
