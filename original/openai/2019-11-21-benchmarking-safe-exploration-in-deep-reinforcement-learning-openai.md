---
title: "Benchmarking safe exploration in deep reinforcement learning | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/benchmarking-safe-exploration-in-deep-reinforcement-learning"
date: "2019-11-21"
scraped_at: "2026-03-02T10:27:31.647234177+00:00"
language: "en-US"
translated: false
tags: ["Safety & Alignment"]
---

November 21, 2019


# Benchmarking safe exploration in deep reinforcement learning

[Read paper(opens in a new window)](https://cdn.openai.com/safexp-short.pdf)

![Benchmarking Safe Exploration In Deep Reinforcement Learning](images/benchmarking-safe-exploration-in-deep-reinforcement-learning-openai/img_001.webp)



## Abstract

Reinforcement learning (RL) agents need to explore their environments in order to learn optimal policies by trial and error. In many environments, safety is a critical concern and certain errors are unacceptable: for example, robotics systems that interact with humans should never cause injury to the humans while exploring. While it is currently typical to train RL agents mostly or entirely in simulation, where safety concerns are minimal, we anticipate that challenges in simulating the complexities of the real world (such as human-AI interactions) will cause a shift towards training RL agents directly in the real world, where safety concerns are paramount. Consequently we take the position that safe exploration should be viewed as a critical focus area for RL research, and in this work we make three contributions to advance the study of safe exploration. First, building on a wide range of prior work on safe reinforcement learning, we propose to standardize constrained RL as the main formalism for safe exploration. Second, we present the Safety Gym benchmark suite, a new slate of high-dimensional continuous control environments for measuring research progress on constrained RL. Finally, we benchmark several constrained deep RL algorithms on Safety Gym environments to establish baselines that future work can build on.

- [Ethics & Safety](https://openai.com/research/index/?tags=ethics-safety)