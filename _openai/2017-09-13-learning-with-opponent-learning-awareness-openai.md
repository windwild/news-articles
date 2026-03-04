---
title: "Learning with opponent-learning awareness | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/learning-with-opponent-learning-awareness"
date: "2017-09-13"
scraped_at: "2026-03-02T10:32:34.562596268+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---
&#123;% raw %}

September 13, 2017


# Learning with opponent-learning awareness

[Read paper(opens in a new window)](https://arxiv.org/abs/1709.04326)

![Learning With Opponent Learning Awareness](images/learning-with-opponent-learning-awareness-openai/img_001.webp)



## Abstract

Multi-agent settings are quickly gathering importance in machine learning. This includes a plethora of recent work on deep multi-agent reinforcement learning, but also can be extended to hierarchical RL, generative adversarial networks and decentralised optimisation. In all these settings the presence of multiple learning agents renders the training problem non-stationary and often leads to unstable training or undesired final results. We present Learning with Opponent-Learning Awareness (LOLA), a method in which each agent shapes the anticipated learning of the other agents in the environment. The LOLA learning rule includes a term that accounts for the impact of one agent's policy on the anticipated parameter update of the other agents. Results show that the encounter of two LOLA agents leads to the emergence of tit-for-tat and therefore cooperation in the iterated prisoners' dilemma, while independent learning does not. In this domain, LOLA also receives higher payouts compared to a naive learner, and is robust against exploitation by higher order gradient-based methods. Applied to repeated matching pennies, LOLA agents converge to the Nash equilibrium. In a round robin tournament we show that LOLA agents successfully shape the learning of a range of multi-agent learning algorithms from literature, resulting in the highest average returns on the IPD. We also show that the LOLA update rule can be efficiently calculated using an extension of the policy gradient estimator, making the method suitable for model-free RL. The method thus scales to large parameter and input spaces and nonlinear function approximators. We apply LOLA to a grid world task with an embedded social dilemma using recurrent policies and opponent modelling. By explicitly considering the learning of the other agent, LOLA agents learn to cooperate out of self-interest. The code is at [this http URL⁠(opens in a new window)](https://github.com/alshedivat/lola).

- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)
&#123;% endraw %}
