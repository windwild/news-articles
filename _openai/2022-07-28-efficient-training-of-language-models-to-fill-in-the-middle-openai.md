---
render_with_liquid: false
title: "Efficient training of language models to fill in the middle | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/efficient-training-of-language-models-to-fill-in-the-middle"
date: "2022-07-28"
scraped_at: "2026-03-02T10:24:50.520827279+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---

July 28, 2022


# Efficient training of language models to fill in the middle

[Read paper(opens in a new window)](https://arxiv.org/abs/2207.14255)

![Efficient Training Of Language Models To Fill In The Middle](images/efficient-training-of-language-models-to-fill-in-the-middle-openai/img_001.webp)



## Abstract

We show that autoregressive language models can learn to infill text after we apply a straightforward transformation to the dataset, which simply moves a span of text from the middle of a document to its end. While this data augmentation has garnered much interest in recent years, we provide extensive evidence that training models with a large fraction of data transformed in this way does not harm the original left-to-right generative capability, as measured by perplexity and sampling evaluations across a wide range of scales. Given the usefulness, simplicity, and efficiency of training models to fill-in-the-middle (FIM), we suggest that future autoregressive language models be trained with FIM by default. To this end, we run a series of ablations on key hyperparameters, such as the data transformation frequency, the structure of the transformation, and the method of selecting the infill span. We use these ablations to prescribe strong default settings and best practices to train FIM models. We have released our best infilling model trained with best practices in our API, and release our infilling benchmarks to aid future research.

- [GPT](https://openai.com/research/index/?tags=gpt)
- [Language](https://openai.com/research/index/?tags=language)
- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)