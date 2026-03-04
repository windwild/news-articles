---
title: "Plan online, learn offline: Efficient learning and exploration via model-based control | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/plan-online-learn-offline"
date: "2018-11-05"
scraped_at: "2026-03-02T10:29:14.829757101+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---
{% raw %}

November 5, 2018


# Plan online, learn offline: Efficient learning and exploration via model-based control

[Read paper(opens in a new window)](https://arxiv.org/abs/1811.01848)

![Plan Online Learn Offline Efficient Learning And Exploration Via Model Based Control](images/plan-online-learn-offline-efficient-learning-and-exploration-via-model-based-con/img_001.webp)



## Abstract

We propose a plan online and learn offline (POLO) framework for the setting where an agent, with an internal model, needs to continually act and learn in the world. Our work builds on the synergistic relationship between local model-based control, global value function learning, and exploration. We study how local trajectory optimization can cope with approximation errors in the value function, and can stabilize and accelerate value function learning. Conversely, we also study how approximate value functions can help reduce the planning horizon and allow for better policies beyond local solutions. Finally, we also demonstrate how trajectory optimization can be used to perform temporally coordinated exploration in conjunction with estimating uncertainty in value function approximation. This exploration is critical for fast and stable learning of the value function. Combining these components enable solutions to complex simulated control tasks, like humanoid locomotion and dexterous in-hand manipulation, in the equivalent of a few minutes of experience in the real world.

- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)
{% endraw %}
