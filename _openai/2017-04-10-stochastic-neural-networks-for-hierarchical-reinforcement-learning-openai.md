---
render_with_liquid: false
title: "Stochastic Neural Networks for hierarchical reinforcement learning | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/stochastic-neural-networks-for-hierarchical-reinforcement-learning"
date: "2017-04-10"
scraped_at: "2026-03-02T10:32:59.300488551+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---

April 10, 2017


# Stochastic Neural Networks for hierarchical reinforcement learning

[Read paper(opens in a new window)](https://arxiv.org/abs/1704.03012)

![Stochastic Neural Networks For Hierarchical Reinforcement Learning](images/stochastic-neural-networks-for-hierarchical-reinforcement-learning-openai/img_001.png)



## Abstract

Deep reinforcement learning has achieved many impressive results in recent years. However, tasks with sparse rewards or long horizons continue to pose significant challenges. To tackle these important problems, we propose a general framework that first learns useful skills in a pre-training environment, and then leverages the acquired skills for learning faster in downstream tasks. Our approach brings together some of the strengths of intrinsic motivation and hierarchical methods: the learning of useful skill is guided by a single proxy reward, the design of which requires very minimal domain knowledge about the downstream tasks. Then a high-level policy is trained on top of these skills, providing a significant improvement of the exploration and allowing to tackle sparse rewards in the downstream tasks. To efficiently pre-train a large span of skills, we use Stochastic Neural Networks combined with an information-theoretic regularizer. Our experiments show that this combination is effective in learning a wide span of interpretable skills in a sample-efficient way, and can significantly boost the learning performance uniformly across a wide range of downstream tasks.

- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)