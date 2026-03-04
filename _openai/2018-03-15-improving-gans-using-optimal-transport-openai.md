---
render_with_liquid: false
title: "Improving GANs using optimal transport | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/improving-gans-using-optimal-transport"
date: "2018-03-15"
scraped_at: "2026-03-02T10:31:18.591242332+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---

March 15, 2018


# Improving GANs using optimal transport

[Read paper(opens in a new window)](https://arxiv.org/abs/1803.05573)

![Improving Gans Using Optimal Transport](images/improving-gans-using-optimal-transport-openai/img_001.webp)



## Abstract

We present Optimal Transport GAN (OT-GAN), a variant of generative adversarial nets minimizing a new metric measuring the distance between the generator distribution and the data distribution. This metric, which we call mini-batch energy distance, combines optimal transport in primal form with an energy distance defined in an adversarially learned feature space, resulting in a highly discriminative distance function with unbiased mini-batch gradients. Experimentally we show OT-GAN to be highly stable when trained with large mini-batches, and we present state-of-the-art results on several popular benchmark problems for image generation.

- [Generative Models](https://openai.com/research/index/?tags=generative-models)