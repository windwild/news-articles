---
render_with_liquid: false
title: "Weight normalization: A simple reparameterization to accelerate training of deep neural networks | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/weight-normalization"
date: "2016-02-25"
scraped_at: "2026-03-02T10:34:40.536622909+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---

February 25, 2016


# Weight normalization: A simple reparameterization to accelerate training of deep neural networks

[Read paper(opens in a new window)](https://arxiv.org/abs/1602.07868)

![Weight Normalization A Simple Reparameterization To Accelerate Training Of Deep Neural Networks](images/weight-normalization-a-simple-reparameterization-to-accelerate-training-of-deep-/img_001.png)



## Abstract

We present weight normalization: a reparameterization of the weight vectors in a neural network that decouples the length of those weight vectors from their direction. By reparameterizing the weights in this way we improve the conditioning of the optimization problem and we speed up convergence of stochastic gradient descent. Our reparameterization is inspired by batch normalization but does not introduce any dependencies between the examples in a minibatch. This means that our method can also be applied successfully to recurrent models such as LSTMs and to noise-sensitive applications such as deep reinforcement learning or generative models, for which batch normalization is less well suited. Although our method is much simpler, it still provides much of the speed-up of full batch normalization. In addition, the computational overhead of our method is lower, permitting more optimization steps to be taken in the same amount of time. We demonstrate the usefulness of our method on applications in supervised image recognition, generative modelling, and deep reinforcement learning.

- [Exploration & Games](https://openai.com/research/index/?tags=exploration-game)