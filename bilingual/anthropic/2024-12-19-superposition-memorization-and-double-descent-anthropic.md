---
title: "Superposition, Memorization, and Double Descent \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/superposition-memorization-and-double-descent"
date: "2024-12-19"
scraped_at: "2026-03-03T06:52:22.869476200+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---

InterpretabilityResearch

可解释性研究

# Superposition, Memorization, and Double Descent

# 过参数化、记忆化与双重下降

Jan 5, 2023

2023年1月5日

[Read Paper](https://transformer-circuits.pub/2023/toy-double-descent/index.html)

[阅读论文](https://transformer-circuits.pub/2023/toy-double-descent/index.html)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流利度指数”（AI Fluency Index）——这是衡量当今人类如何与 AI 协作的一项基准指标。

## Abstract

## 摘要

In a [recent paper](https://transformer-circuits.pub/2022/toy_model/index.html), we found that simple neural networks trained on toy tasks often exhibit a phenomenon called superposition, where they represent more features than they have neurons. Our investigation was limited to the infinite-data, underfitting regime. But there's reason to believe that understanding overfitting might be important if we want to succeed at mechanistic interpretability, and that superposition might be a central part of the story.

在一篇[近期论文](https://transformer-circuits.pub/2022/toy_model/index.html)中，我们发现：在简单任务（toy tasks）上训练的简单神经网络常表现出一种称为“过参数化”（superposition）的现象，即网络所表征的特征数量多于其神经元数量。此前的研究局限于“数据无限、欠拟合”的情形。然而，若希望在机制可解释性（mechanistic interpretability）方向取得突破，深入理解过拟合现象可能至关重要；而“过参数化”很可能是这一故事的核心环节。

Why should mechanistic interpretability care about overfitting?  
为什么机制可解释性（mechanistic interpretability）应当关注过拟合问题？

Despite overfitting being a central problem in machine learning, we have little mechanistic understanding of what exactly is going on when deep learning models overfit or memorize examples. Additionally, previous work has hinted that there may be an important link between overfitting and learning interpretable features.  
尽管过拟合是机器学习中的核心问题，但我们对深度学习模型发生过拟合或记忆样本时其内部究竟发生了什么，仍缺乏机制层面的理解。此外，先前的研究已暗示，过拟合与学习可解释特征之间可能存在重要关联。

So understanding overfitting is important, but why should it be relevant to superposition? Consider the case of a language model which verbatim memorizes text. How can it do this? One naive idea is that it might use neurons to create a lookup table mapping sequences to arbitrary continuations. For every sequence of tokens it wishes to memorize, it could dedicate one neuron to detecting that sequence, and then implement arbitrary behavior when it fires. The problem with this approach is that it's extremely inefficient – but it seems like a perfect candidate for superposition, since each case is mutually exclusive and can't interfere.  
因此，理解过拟合固然重要；但为何它又与叠加（superposition）相关？考虑一个逐字逐句记忆文本的语言模型：它是如何实现这一点的？一种朴素的想法是，模型可能利用神经元构建一张“查找表”，将输入词元序列映射到任意后续内容。对于每一个它希望记忆的词元序列，模型可分配一个专用神经元来检测该序列，并在该神经元激活时执行任意行为。这种方案的问题在于效率极低——但它似乎恰恰是叠加现象的理想候选：因为每个待记忆的序列彼此互斥，不会相互干扰。

In this note, we offer a very preliminary investigation of training the same toy models in our previous paper on limited datasets. Despite being extremely simple, the toy model turns out to be a surprisingly rich case study for overfitting. In particular, we find the following:  
本文中，我们对前一篇论文中使用的相同简化模型（toy models）在受限数据集上进行训练，开展一项非常初步的探索性研究。尽管该简化模型极为简单，它却意外地成为研究过拟合现象的丰富案例。具体而言，我们发现以下现象：

- Overfitting corresponds to storing data points, rather than features, in superposition.  
- 过拟合对应于在叠加中存储具体的数据点，而非抽象特征。

- Depending on dataset size, our models fall into two different regimes: an overfitting regime (characterized by storing data points in superposition), and a generalizing regime (characterized by storing features in superposition).  
- 根据数据集规模的不同，我们的模型会落入两种截然不同的状态：过拟合状态（以在叠加中存储数据点为特征）和泛化状态（以在叠加中存储特征为特征）。

- We observe double descent as the model transitions between these regimes.  
- 当模型在这两种状态之间转换时，我们观察到了“双下降”（double descent）现象。