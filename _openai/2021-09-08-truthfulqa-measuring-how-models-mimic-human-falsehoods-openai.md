---
title: "TruthfulQA: Measuring how models mimic human falsehoods | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/truthfulqa"
date: "2021-09-08"
scraped_at: "2026-03-02T10:26:06.719595712+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---
{% raw %}

September 8, 2021


# TruthfulQA: Measuring how models mimic human falsehoods

[Read paper(opens in a new window)](https://arxiv.org/abs/2109.07958)

![Truthfulqa Measuring How Models Mimic Human Falsehoods](images/truthfulqa-measuring-how-models-mimic-human-falsehoods-openai/img_001.webp)



## Abstract

We propose a benchmark to measure whether a language model is truthful in generating answers to questions. The benchmark comprises 817 questions that span 38 categories, including health, law, finance and politics. We crafted questions that some humans would answer falsely due to a false belief or misconception. To perform well, models must avoid generating false answers learned from imitating human texts. We tested GPT‑3, GPT‑Neo/J, GPT‑2 and a T5-based model. The best model was truthful on 58% of questions, while human performance was 94%. Models generated many false answers that mimic popular misconceptions and have the potential to deceive humans. The largest models were generally the least truthful. This contrasts with other NLP tasks, where performance improves with model size. However, this result is expected if false answers are learned from the training distribution. We suggest that scaling up models alone is less promising for improving truthfulness than fine-tuning using training objectives other than imitation of text from the web.

- [Language](https://openai.com/research/index/?tags=language)
{% endraw %}
