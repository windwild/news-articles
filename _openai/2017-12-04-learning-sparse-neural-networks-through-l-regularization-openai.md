---
render_with_liquid: false
title: "Learning sparse neural networks through L₀ regularization | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/learning-sparse-neural-networks-through-l0-regularization"
date: "2017-12-04"
scraped_at: "2026-03-02T10:31:33.170391668+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---

December 4, 2017


# Learning sparse neural networks through L₀ regularization

[Read paper(opens in a new window)](https://arxiv.org/abs/1712.01312)

![Learning Sparse Neural Networks Through L Regularization](images/learning-sparse-neural-networks-through-l-regularization-openai/img_001.webp)



## Abstract

We propose a practical method for L₀ norm regularization for neural networks: pruning the network during training by encouraging weights to become exactly zero. Such regularization is interesting since (1) it can greatly speed up training and inference, and (2) it can improve generalization. AIC and BIC, well-known model selection criteria, are special cases of L₀ regularization. However, since the L₀ norm of weights is non-differentiable, we cannot incorporate it directly as a regularization term in the objective function. We propose a solution through the inclusion of a collection of non-negative stochastic gates, which collectively determine which weights to set to zero. We show that, somewhat surprisingly, for certain distributions over the gates, the expected L₀ norm of the resulting gated weights is differentiable with respect to the distribution parameters. We further propose the _hard concrete_ distribution for the gates, which is obtained by "stretching" a binary concrete distribution and then transforming its samples with a hard-sigmoid. The parameters of the distribution over the gates can then be jointly optimized with the original network parameters. As a result our method allows for straightforward and efficient learning of model structures with stochastic gradient descent and allows for conditional computation in a principled way. We perform various experiments to demonstrate the effectiveness of the resulting approach and regularizer.

- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)