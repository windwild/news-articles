---
title: "On the quantitative analysis of decoder-based generative models | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/on-the-quantitative-analysis-of-decoder-based-generative-models"
date: "2016-11-14"
scraped_at: "2026-03-02T10:33:51.064446884+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---
&#123;% raw %}

November 14, 2016


# On the quantitative analysis of decoder-based generative models

[Read paper(opens in a new window)](https://arxiv.org/abs/1611.04273)

![On The Quantitative Analysis Of Decoder Based Generative Models](images/on-the-quantitative-analysis-of-decoder-based-generative-models-openai/img_001.webp)



## Abstract

The past several years have seen remarkable progress in generative models which produce convincing samples of images and other modalities. A shared component of many powerful generative models is a decoder network, a parametric deep neural net that defines a generative distribution. Examples include variational autoencoders, generative adversarial networks, and generative moment matching networks. Unfortunately, it can be difficult to quantify the performance of these models because of the intractability of log-likelihood estimation, and inspecting samples can be misleading. We propose to use Annealed Importance Sampling for evaluating log-likelihoods for decoder-based models and validate its accuracy using bidirectional Monte Carlo. The evaluation code is provided at [this https URL⁠(opens in a new window)](https://github.com/tonywu95/eval_gen). Using this technique, we analyze the performance of decoder-based models, the effectiveness of existing log-likelihood estimators, the degree of overfitting, and the degree to which these models miss important modes of the data distribution.

- [Generative Models](https://openai.com/research/index/?tags=generative-models)
&#123;% endraw %}
