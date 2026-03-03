---
title: "Softmax Linear Units \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/softmax-linear-units"
date: "2024-12-19"
scraped_at: "2026-03-03T06:55:56.363508082+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---

InterpretabilityResearch

可解释性研究

# Softmax Linear Units

# Softmax 线性单元

Jun 17, 2022

2022 年 6 月 17 日

[Read Paper](https://transformer-circuits.pub/2022/solu/index.html)

[阅读论文](https://transformer-circuits.pub/2022/solu/index.html)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流利度指数”（AI Fluency Index）——该指数为衡量当今人类与 AI 协作水平提供了一个基准。

## Abstract

## 摘要

In this paper, we report an architectural change which appears to substantially increase the fraction of MLP neurons which appear to be "interpretable" (i.e. respond to an articulable property of the input), at little to no cost to ML performance. Specifically, we replace the activation function with a softmax linear unit (which we term SoLU) and show that this significantly increases the fraction of neurons in the MLP layers which seem to correspond to readily human-understandable concepts, phrases, or categories on quick investigation, as measured by randomized and blinded experiments. We then study our SoLU models and use them to gain several new insights about how information is processed in transformers. However, we also discover some evidence that the superposition hypothesis is true and there is no free lunch: SoLU may be making some features more interpretable by “hiding” others and thus making them even more deeply uninterpretable. Despite this, SoLU still seems like a net win, as in practical terms it substantially increases the fraction of neurons we are able to understand.

本文报告了一种架构层面的改进：在几乎不损害机器学习性能的前提下，显著提升多层感知机（MLP）中“可解释”神经元（即对输入中某种可明确描述的属性产生响应的神经元）所占的比例。具体而言，我们将激活函数替换为一种 softmax 线性单元（我们称之为 SoLU），并通过随机化、双盲实验验证，该改动显著提高了 MLP 各层中在快速检验下即可对应于人类易于理解的概念、短语或类别的神经元比例。随后，我们深入研究了 SoLU 模型，并借此获得了若干关于信息在 Transformer 中如何处理的新见解。然而，我们也发现了一些支持“叠加假说”（superposition hypothesis）的证据，印证了“天下没有免费的午餐”这一原则：SoLU 可能通过“隐藏”某些特征，使其变得更为深层且难以解释，从而提升了另一些特征的可解释性。尽管如此，SoLU 仍具有明显的净收益——从实践角度看，它大幅增加了我们能够理解的神经元数量。