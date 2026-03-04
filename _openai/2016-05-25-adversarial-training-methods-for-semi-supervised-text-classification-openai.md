---
title: "Adversarial training methods for semi-supervised text classification | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/adversarial-training-methods-for-semi-supervised-text-classification"
date: "2016-05-25"
scraped_at: "2026-03-02T10:34:31.124199483+00:00"
language: "en-US"
translated: false
tags: ["Safety & Alignment"]
---
&#123;% raw %}

May 25, 2016


# Adversarial training methods for semi-supervised text classification

[Read paper(opens in a new window)](https://arxiv.org/abs/1605.07725)

![Adversarial Training Methods For Semi Supervised Text Classification](images/adversarial-training-methods-for-semi-supervised-text-classification-openai/img_001.png)



## Abstract

Adversarial training provides a means of regularizing supervised learning algorithms while virtual adversarial training is able to extend supervised learning algorithms to the semi-supervised setting. However, both methods require making small perturbations to numerous entries of the input vector, which is inappropriate for sparse high-dimensional inputs such as one-hot word representations. We extend adversarial and virtual adversarial training to the text domain by applying perturbations to the word embeddings in a recurrent neural network rather than to the original input itself. The proposed method achieves state of the art results on multiple benchmark semi-supervised and purely supervised tasks. We provide visualizations and analysis showing that the learned word embeddings have improved in quality and that while training, the model is less prone to overfitting. Code is available at [this https URL⁠(opens in a new window)](https://github.com/tensorflow/models/tree/master/research/adversarial_text).

- [Ethics & Safety](https://openai.com/research/index/?tags=ethics-safety)
&#123;% endraw %}
