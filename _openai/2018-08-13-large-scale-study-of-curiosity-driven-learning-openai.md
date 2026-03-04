---
title: "Large-scale study of curiosity-driven learning | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/large-scale-study-of-curiosity-driven-learning"
date: "2018-08-13"
scraped_at: "2026-03-02T10:29:40.217173837+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---
{% raw %}

August 13, 2018


# Large-scale study of curiosity-driven learning

[Read paper(opens in a new window)](https://arxiv.org/abs/1808.04355)

![Large Scale Study Of Curiosity Driven Learning](images/large-scale-study-of-curiosity-driven-learning-openai/img_001.webp)



## Abstract

Reinforcement learning algorithms rely on carefully engineering environment rewards that are extrinsic to the agent. However, annotating each environment with hand-designed, dense rewards is not scalable, motivating the need for developing reward functions that are intrinsic to the agent. Curiosity is a type of intrinsic reward function which uses prediction error as reward signal. In this paper: (a) We perform the first large-scale study of purely curiosity-driven learning, i.e. without any extrinsic rewards, across 54 standard benchmark environments, including the Atari game suite. Our results show surprisingly good performance, and a high degree of alignment between the intrinsic curiosity objective and the hand-designed extrinsic rewards of many game environments. (b) We investigate the effect of using different feature spaces for computing prediction error and show that random features are sufficient for many popular RL game benchmarks, but learned features appear to generalize better (e.g. to novel game levels in Super Mario Bros.). (c) We demonstrate limitations of the prediction-based rewards in stochastic setups. Game-play videos and code are at [this https URL⁠(opens in a new window)](https://pathak22.github.io/large-scale-curiosity/).

- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)
{% endraw %}
