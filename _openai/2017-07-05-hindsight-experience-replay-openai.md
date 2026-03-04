---
title: "Hindsight Experience Replay | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/hindsight-experience-replay"
date: "2017-07-05"
scraped_at: "2026-03-02T10:32:38.347834665+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---
{% raw %}

July 5, 2017


# Hindsight Experience Replay

[Read paper(opens in a new window)](https://arxiv.org/abs/1707.01495)

![Hindsight Experience Replay](images/hindsight-experience-replay-openai/img_001.png)



## Abstract

Dealing with sparse rewards is one of the biggest challenges in Reinforcement Learning (RL). We present a novel technique called Hindsight Experience Replay which allows sample-efficient learning from rewards which are sparse and binary and therefore avoid the need for complicated reward engineering. It can be combined with an arbitrary off-policy RL algorithm and may be seen as a form of implicit curriculum.

We demonstrate our approach on the task of manipulating objects with a robotic arm. In particular, we run experiments on three different tasks: pushing, sliding, and pick-and-place, in each case using only binary rewards indicating whether or not the task is completed. Our ablation studies show that Hindsight Experience Replay is a crucial ingredient which makes training possible in these challenging environments. We show that our policies trained on a physics simulation can be deployed on a physical robot and successfully complete the task.

- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)
{% endraw %}
