---
title: "Teaching models to express their uncertainty in words | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/teaching-models-to-express-their-uncertainty-in-words"
date: "2022-05-28"
scraped_at: "2026-03-02T10:25:20.824415135+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---
&#123;% raw %}

May 28, 2022


# Teaching models to express their uncertainty in words

[Read paper(opens in a new window)](https://arxiv.org/abs/2205.14334)

![Teaching Models To Express Their Uncertainty In Words](images/teaching-models-to-express-their-uncertainty-in-words-openai/img_001.png)



## Abstract

We show that a GPT‑3 model can learn to express uncertainty about its own answers in natural language—without use of model logits. When given a question, the model generates both an answer and a level of confidence (e.g. "90% confidence" or "high confidence"). These levels map to probabilities that are well calibrated. The model also remains moderately calibrated under distribution shift, and is sensitive to uncertainty in its own answers, rather than imitating human examples. To our knowledge, this is the first time a model has been shown to express calibrated uncertainty about its own answers in natural language. For testing calibration, we introduce the CalibratedMath suite of tasks. We compare the calibration of uncertainty expressed in words ("verbalized probability") to uncertainty extracted from model logits. Both kinds of uncertainty are capable of generalizing calibration under distribution shift. We also provide evidence that GPT‑3's ability to generalize calibration depends on pre-trained latent representations that correlate with epistemic uncertainty over its answers.

- [GPT](https://openai.com/research/index/?tags=gpt)
- [Language](https://openai.com/research/index/?tags=language)
- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)
&#123;% endraw %}
