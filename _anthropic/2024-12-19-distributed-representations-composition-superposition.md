---
title: "Distributed Representations: Composition & Superposition"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/distributed-representations-composition-superposition"
date: "2024-12-19"
scraped_at: "2026-03-03T07:05:08.686413624+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
{% raw %}

InterpretabilityResearch

可解释性研究

# Distributed Representations: Composition & Superposition

# 分布式表征：组合性与叠加性

May 4, 2023

2023年5月4日

[Read Paper](https://transformer-circuits.pub/2023/superposition-composition/index.html)

[阅读论文](https://transformer-circuits.pub/2023/superposition-composition/index.html)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千场 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——该指数为衡量当今人类与 AI 协作水平提供了一个基准。

## Abstract

## 摘要

Distributed representations are a classic idea in both neuroscience and connectionist approaches to AI. We're often asked how our work on superposition relates to it. Since publishing our [original paper](https://transformer-circuits.pub/2022/toy_model/index.html) on superposition, we've had more time to reflect on the relationship between the topics and discuss it with people, and wanted to expand on our [earlier discussion](https://transformer-circuits.pub/2022/toy_model/index.html#related-codes) in the related work section and share a few thoughts. (We care a lot about superposition and the structure of distributed representations because decomposing representations into independent components [is necessary to escape the curse of dimensionality](https://transformer-circuits.pub/2022/mech-interp-essay/index.html) and understand neural networks.)

分布式表征（distributed representations）是神经科学与联结主义人工智能方法中的一个经典概念。人们常问：我们关于“叠加性”（superposition）的研究与这一概念有何关联？自我们发布首篇关于叠加性的[原始论文](https://transformer-circuits.pub/2022/toy_model/index.html)以来，我们有了更多时间深入思考该主题之间的关系，并与同行展开讨论；因此，我们希望在先前“相关工作”（related work）部分的[初步探讨](https://transformer-circuits.pub/2022/toy_model/index.html#related-codes)基础上进一步展开，并分享若干见解。（我们之所以高度重视叠加性及分布式表征的结构，是因为唯有将表征分解为相互独立的成分，[才能摆脱维度灾难（curse of dimensionality）](https://transformer-circuits.pub/2022/mech-interp-essay/index.html)，进而真正理解神经网络。）

It seems to us that "distributed representations" might be understood as containing two different ideas, which we'll call "composition" and "superposition". 1 These two different notions of distributed representations have very different properties in terms of generalization and what functions can be linearly computed from them. And while a representation can use both, there's a trade-off that puts them fundamentally in tension! 2

在我们看来，“分布式表征”（distributed representations）这一概念可能蕴含两种不同的思想，我们将其分别称为“组合性”（composition）和“叠加性”（superposition）。¹ 这两种关于分布式表征的不同理解，在泛化能力以及可从其中线性计算出的函数类型方面，展现出截然不同的性质。尽管一种表征可以同时利用二者，但二者之间却存在一种根本性的权衡关系，使其本质上相互制约！²

To make this concrete, we'll consider a few potential ways neurons might represent shapes of different colors. These lovely examples are borrowed from [Thorpe (1989)](https://persee.fr/doc/intel_0769-4113_1989_num_8_2_873), who created them to demonstrate various possibilities between the idea of a "local code" and a "distributed code" in neuroscience. Thorpe provides four example codes – "local", "semi-local", "semi-distributed", and "high-distributed". These might traditionally be seen as being on a spectrum between being "local" and "distributed". We'll consider these examples again and offer an alternative view in which the examples instead vary on two different dimensions of superposition and composition.

为使讨论具体化，我们将考察神经元表征不同颜色形状的若干潜在方式。这些精妙的示例取自[Thorpe（1989）](https://persee.fr/doc/intel_0769-4113_1989_num_8_2_873)，他最初构建这些示例，旨在阐明神经科学中“局部编码”（local code）与“分布式编码”（distributed code）之间的多种可能性。Thorpe 提出了四种典型编码方式——“局部编码”（local）、“半局部编码”（semi-local）、“半分布式编码”（semi-distributed）和“高度分布式编码”（high-distributed）。传统上，这些编码常被视为处于“局部性”与“分布式”这一连续谱上的不同位置。我们将重新审视这些示例，并提出一种替代性视角：即这些示例并非仅沿单一“局部–分布式”维度变化，而是分别在“叠加性”与“组合性”这两个独立维度上发生变化。

Following Thorpe, this note will focus on examples where neurons have binary activations. This significantly simplifies the space of possibilities, but it's still a rich enough space to have interesting questions.

遵循 Thorpe 的设定，本文将聚焦于神经元具有二值激活（binary activations）的情形。这一简化显著缩小了可能性空间，但其仍足够丰富，足以引出诸多有趣的问题。
{% endraw %}
