---
render_with_liquid: false
title: "Gathering human feedback | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/gathering-human-feedback"
date: "2017-08-03"
scraped_at: "2026-03-02T10:32:33.996382416+00:00"
language: "en-US"
translated: false
description: "RL-Teacher is an open-source implementation of our interface to train AIs via occasional human feedback rather than hand-crafted reward functions. The underlying technique was developed as a step towa..."
tags: ["Research"]
---

August 3, 2017


# Gathering human feedback

[View code(opens in a new window)](https://github.com/nottombrown/rl-teacher)

![Gathering Human Feedback](images/gathering-human-feedback-openai/img_001.webp)



RL-Teacher is an open-source implementation of our interface to train AIs via occasional human feedback rather than hand-crafted reward functions. The underlying technique was developed as a step towards safe AI systems, but also applies to reinforcement learning problems with rewards that are hard to specify.

This simulated robot is being trained to do ballet via a human giving feedback. It’s not obvious how to specify a reward function to achieve the same behavior.

The release contains three main components:

- A [reward predictor⁠(opens in a new window)](https://github.com/nottombrown/rl-teacher/blob/master/rl_teacher/teach.py) that can be plugged into any agent and learns to predict the actions the agent could take that a human would approve of.
- An [example agent⁠(opens in a new window)](https://github.com/nottombrown/rl-teacher/tree/master/agents) that learns via a function specified by a reward predictor. RL-Teacher ships with three pre-integrated algorithms, including [OpenAI Baselines PPO⁠(opens in a new window)](https://blog.openai.com/openai-baselines-ppo/).
- A [web-app⁠(opens in a new window)](https://github.com/nottombrown/rl-teacher/tree/master/human-feedback-api) that humans can use to give feedback, providing the data used to train the reward predictor.

The entire system consists of less than 1,000 lines of Python code (excluding the agents). After you’ve set up your web server you can launch an experiment by running:

#### Bash

`1$ python rl_teacher/teach.py -p human --pretrain_labels 175 -e Reacher-v1 -n human-175

`

Humans can give feedback via a simple web interface (shown above), which can be run locally (not recommended) or on a separate machine. Full documentation is available on the project’s [GitHub repository⁠(opens in a new window)](https://github.com/nottombrown/rl-teacher). We’re excited to see what AI researchers and engineers do with this technology—please [get in touch⁠](mailto:jack@openai.com?Subject=RL_Teacher) with any experimental results!

- [Community & Collaboration](https://openai.com/research/index/?tags=community-collaboration)
- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)