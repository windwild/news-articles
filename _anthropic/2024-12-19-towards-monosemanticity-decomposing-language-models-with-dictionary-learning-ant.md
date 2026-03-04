---
title: "Towards Monosemanticity: Decomposing Language Models With Dictionary Learning \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/towards-monosemanticity-decomposing-language-models-with-dictionary-learning"
date: "2024-12-19"
scraped_at: "2026-03-03T06:48:05.217342627+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
{% raw %}

InterpretabilityResearch

可解释性研究

# Towards Monosemanticity: Decomposing Language Models With Dictionary Learning

# 走向单义性：利用字典学习分解语言模型

Oct 5, 2023

2023年10月5日

[Read Paper](https://transformer-circuits.pub/2023/monosemantic-features/index.html)

[阅读论文](https://transformer-circuits.pub/2023/monosemantic-features/index.html)

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。

## Abstract

## 摘要

In our latest paper, [_Towards Monosemanticity: Decomposing Language Models With Dictionary Learning_](https://transformer-circuits.pub/2023/monosemantic-features), we outline evidence that there are better units of analysis than individual neurons, and we have built machinery that lets us find these units in small transformer models. These units, called features, correspond to patterns (linear combinations) of neuron activations. This provides a path to breaking down complex neural networks into parts we can understand, and builds on previous efforts to interpret high-dimensional systems in neuroscience, machine learning, and statistics. In a transformer language model, we decompose a layer with 512 neurons into more than 4000 features which separately represent things like DNA sequences, legal language, HTTP requests, Hebrew text, nutrition statements, and much, much more. Most of these model properties are invisible when looking at the activations of individual neurons in isolation.

在我们最新发表的论文《[走向单义性：利用字典学习分解语言模型](https://transformer-circuits.pub/2023/monosemantic-features)》中，我们提出了有力证据，表明存在比单个神经元更优的分析单元；同时，我们已构建出一套工具，可在小型 Transformer 模型中识别出这些单元。这些单元被称为“特征”（features），对应于神经元激活模式（即神经元激活值的线性组合）。该方法为将复杂神经网络拆解为人类可理解的组成部分提供了可行路径，并延续了神经科学、机器学习及统计学等领域对高维系统开展可解释性研究的既有工作。在某一 Transformer 语言模型中，我们将一个含 512 个神经元的层分解为超过 4000 个特征，每个特征分别表征诸如 DNA 序列、法律文本、HTTP 请求、希伯来语文本、营养成分声明等各类语义内容——且远不止于此。而上述绝大多数模型特性，在仅观察单个神经元激活状态时是完全不可见的。
{% endraw %}
