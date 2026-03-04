---
render_with_liquid: false
title: "Studying Large Language Model Generalization with Influence Functions \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/studying-large-language-model-generalization-with-influence-functions"
date: "2024-12-19"
scraped_at: "2026-03-03T06:52:23.066951038+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
render_with_liquid: false
render_with_liquid: false

AlignmentResearch

AlignmentResearch（对齐研究）

# Studying Large Language Model Generalization with Influence Functions

# 使用影响函数研究大语言模型的泛化能力

Aug 8, 2023

2023年8月8日

[Read Paper](https://arxiv.org/abs/2308.03296)

[阅读论文](https://arxiv.org/abs/2308.03296)

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流利度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。

## Abstract

## 摘要

When trying to gain better visibility into a machine learning model in order to understand and mitigate the associated risks, a potentially valuable source of evidence is: which training examples most contribute to a given behavior? Influence functions aim to answer a counterfactual: how would the model's parameters (and hence its outputs) change if a given sequence were added to the training set? While influence functions have produced insights for small models, they are difficult to scale to large language models (LLMs) due to the difficulty of computing an inverse-Hessian-vector product (IHVP). We use the Eigenvalue-corrected Kronecker-Factored Approximate Curvature (EK-FAC) approximation to scale influence functions up to LLMs with up to 52 billion parameters. In our experiments, EK-FAC achieves similar accuracy to traditional influence function estimators despite the IHVP computation being orders of magnitude faster. We investigate two algorithmic techniques to reduce the cost of computing gradients of candidate training sequences: TF-IDF filtering and query batching. We use influence functions to investigate the generalization patterns of LLMs, including the sparsity of the influence patterns, increasing abstraction with scale, math and programming abilities, cross-lingual generalization, and role-playing behavior. Despite many apparently sophisticated forms of generalization, we identify a surprising limitation: influences decay to near-zero when the order of key phrases is flipped. Overall, influence functions give us a powerful new tool for studying the generalization properties of LLMs.

在试图更深入地理解机器学习模型、从而识别并缓解其相关风险时，一个潜在的重要证据来源是：哪些训练样本对某一特定行为的产生贡献最大？影响函数（influence functions）旨在回答一个反事实问题：若将某条样本序列加入训练集，模型的参数（进而其输出）将发生怎样的变化？尽管影响函数已在小型模型上产出诸多洞见，但将其扩展至大语言模型（LLMs）却面临巨大挑战，主要难点在于逆海森-向量积（inverse-Hessian-vector product, IHVP）的计算开销过大。为此，我们采用“特征值校正的克罗内克分解近似曲率”（Eigenvalue-corrected Kronecker-Factored Approximate Curvature, EK-FAC）近似方法，成功将影响函数扩展至参数量高达 520 亿的大语言模型。实验表明，EK-FAC 在 IHVP 计算速度提升数个数量级的同时，仍能保持与传统影响函数估计器相当的精度。我们还探索了两种降低候选训练序列梯度计算成本的算法技术：TF-IDF 过滤与查询批处理（query batching）。我们利用影响函数系统考察了 LLM 的泛化模式，包括影响模式的稀疏性、随模型规模增长而增强的抽象能力、数学与编程能力、跨语言泛化能力，以及角色扮演行为。尽管 LLM 展现出许多看似高度复杂的泛化形式，我们却意外发现了一项显著局限：当关键短语的顺序被调换时，其影响迅速衰减至接近零。总体而言，影响函数为我们提供了一种强大而新颖的工具，用以深入探究大语言模型的泛化特性。