---
render_with_liquid: false
title: "Equivalence between policy gradients and soft Q-learning | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/equivalence-between-policy-gradients-and-soft-q-learning"
date: "2017-04-21"
scraped_at: "2026-03-02T10:32:55.017356437+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---

April 21, 2017


# Equivalence between policy gradients and soft Q-learning

[Read paper(opens in a new window)](https://arxiv.org/abs/1704.06440)

![Equivalence Between Policy Gradients And Soft Q Learning](images/equivalence-between-policy-gradients-and-soft-q-learning-openai/img_001.webp)



## Abstract

Two of the leading approaches for model-free reinforcement learning are policy gradient methods and Q-learning methods. Q-learning methods can be effective and sample-efficient when they work, however, it is not well-understood why they work, since empirically, the Q-values they estimate are very inaccurate. A partial explanation may be that Q-learning methods are secretly implementing policy gradient updates: we show that there is a precise equivalence between Q-learning and policy gradient methods in the setting of entropy-regularized reinforcement learning, that "soft" (entropy-regularized) Q-learning is exactly equivalent to a policy gradient method. We also point out a connection between Q-learning methods and natural policy gradient methods. Experimentally, we explore the entropy-regularized versions of Q-learning and policy gradients, and we find them to perform as well as (or slightly better than) the standard variants on the Atari benchmark. We also show that the equivalence holds in practical settings by constructing a Q-learning method that closely matches the learning dynamics of A3C without using a target network or ϵ-greedy exploration schedule.

- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)