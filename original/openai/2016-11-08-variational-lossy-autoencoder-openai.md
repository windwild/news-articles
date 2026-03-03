---
title: "Variational lossy autoencoder | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/variational-lossy-autoencoder"
date: "2016-11-08"
scraped_at: "2026-03-02T10:34:16.546130068+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---

November 8, 2016


# Variational lossy autoencoder

[Read paper(opens in a new window)](https://arxiv.org/abs/1611.02731)

![Variational Lossy Autoencoder](images/variational-lossy-autoencoder-openai/img_001.webp)



## Abstract

Representation learning seeks to expose certain aspects of observed data in a learned representation that's amenable to downstream tasks like classification. For instance, a good representation for 2D images might be one that describes only global structure and discards information about detailed texture. In this paper, we present a simple but principled method to learn such global representations by combining Variational Autoencoder (VAE) with neural autoregressive models such as RNN, MADE and PixelRNN/CNN. Our proposed VAE model allows us to have control over what the global latent code can learn and , by designing the architecture accordingly, we can force the global latent code to discard irrelevant information such as texture in 2D images, and hence the VAE only "autoencodes" data in a lossy fashion. In addition, by leveraging autoregressive models as both prior distribution p(z) and decoding distribution p(x\|z), we can greatly improve generative modeling performance of VAEs, achieving new state-of-the-art results on MNIST, OMNIGLOT and Caltech-101 Silhouettes density estimation tasks.

- [Generative Models](https://openai.com/research/index/?tags=generative-models)