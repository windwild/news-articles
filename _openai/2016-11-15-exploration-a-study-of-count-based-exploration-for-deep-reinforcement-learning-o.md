---
render_with_liquid: false
title: "#Exploration: A study of count-based exploration for deep reinforcement learning | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/exploration"
date: "2016-11-15"
scraped_at: "2026-03-02T10:34:12.712875747+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---

November 15, 2016


# \#Exploration: A study of count-based exploration for deep reinforcement learning

[Read paper(opens in a new window)](https://arxiv.org/abs/1611.04717)

![Exploration A Study Of Count Based Exploration For Deep Reinforcement Learning](images/exploration-a-study-of-count-based-exploration-for-deep-reinforcement-learning-o/img_001.webp)



## Abstract

Count-based exploration algorithms are known to perform near-optimally when used in conjunction with tabular reinforcement learning (RL) methods for solving small discrete Markov decision processes (MDPs). It is generally thought that count-based methods cannot be applied in high-dimensional state spaces, since most states will only occur once. Recent deep RL exploration strategies are able to deal with high-dimensional continuous state spaces through complex heuristics, often relying on optimism in the face of uncertainty or intrinsic motivation. In this work, we describe a surprising finding: a simple generalization of the classic count-based approach can reach near state-of-the-art performance on various high-dimensional and/or continuous deep RL benchmarks. States are mapped to hash codes, which allows to count their occurrences with a hash table. These counts are then used to compute a reward bonus according to the classic count-based exploration theory. We find that simple hash functions can achieve surprisingly good results on many challenging tasks. Furthermore, we show that a domain-dependent learned hash code may further improve these results. Detailed analysis reveals important aspects of a good hash function: 1) having appropriate granularity and 2) encoding information relevant to solving the MDP. This exploration strategy achieves near state-of-the-art performance on both continuous control tasks and Atari 2600 games, hence providing a simple yet powerful baseline for solving MDPs that require considerable exploration.

- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)