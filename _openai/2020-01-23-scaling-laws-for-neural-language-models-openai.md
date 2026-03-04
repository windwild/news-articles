---
title: "Scaling laws for neural language models | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/scaling-laws-for-neural-language-models"
date: "2020-01-23"
scraped_at: "2026-03-02T10:27:22.507245383+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---
{% raw %}

January 23, 2020


# Scaling laws for neural language models

[Read paper(opens in a new window)](https://arxiv.org/abs/2001.08361)

![Scaling Laws For Neural Language Models](images/scaling-laws-for-neural-language-models-openai/img_001.webp)



## Abstract

We study empirical scaling laws for language model performance on the cross-entropy loss. The loss scales as a power-law with model size, dataset size, and the amount of compute used for training, with some trends spanning more than seven orders of magnitude. Other architectural details such as network width or depth have minimal effects within a wide range. Simple equations govern the dependence of overfitting on model/dataset size and the dependence of training speed on model size. These relationships allow us to determine the optimal allocation of a fixed compute budget. Larger models are significantly more sample-efficient, such that optimally compute-efficient training involves training very large models on a relatively modest amount of data and stopping significantly before convergence.

- [Compute Scaling](https://openai.com/research/index/?tags=compute-scaling)
{% endraw %}
