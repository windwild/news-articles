---
title: "On first-order meta-learning algorithms | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/on-first-order-meta-learning-algorithms"
date: "2018-03-08"
scraped_at: "2026-03-02T10:30:56.297598934+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---

March 8, 2018


# On first-order meta-learning algorithms

[Read paper(opens in a new window)](https://arxiv.org/abs/1803.02999)

![On First Order Meta Learning Algorithms](images/on-first-order-meta-learning-algorithms-openai/img_001.webp)



## Abstract

This paper considers meta-learning problems, where there is a distribution of tasks, and we would like to obtain an agent that performs well (i.e., learns quickly) when presented with a previously unseen task sampled from this distribution. We analyze a family of algorithms for learning a parameter initialization that can be fine-tuned quickly on a new task, using only first-order derivatives for the meta-learning updates. This family includes and generalizes first-order MAML, an approximation to MAML obtained by ignoring second-order derivatives. It also includes Reptile, a new algorithm that we introduce here, which works by repeatedly sampling a task, training on it, and moving the initialization towards the trained weights on that task. We expand on the results from Finn et al. showing that first-order meta-learning algorithms perform well on some well-established benchmarks for few-shot classification, and we provide theoretical analysis aimed at understanding why these algorithms work.

- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)