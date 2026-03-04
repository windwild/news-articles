---
render_with_liquid: false
title: "Variance reduction for policy gradient with action-dependent factorized baselines | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/variance-reduction-for-policy-gradient-with-action-dependent-factorized-baselines"
date: "2018-03-20"
scraped_at: "2026-03-02T10:30:42.368671341+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---

March 20, 2018


# Variance reduction for policy gradient with action-dependent factorized baselines

[Read paper(opens in a new window)](https://arxiv.org/abs/1803.07246)

![Variance Reduction For Policy Gradient With Action Dependent Factorized Baselines](images/variance-reduction-for-policy-gradient-with-action-dependent-factorized-baseline/img_001.webp)



## Abstract

Policy gradient methods have enjoyed great success in deep reinforcement learning but suffer from high variance of gradient estimates. The high variance problem is particularly exasperated in problems with long horizons or high-dimensional action spaces. To mitigate this issue, we derive a bias-free action-dependent baseline for variance reduction which fully exploits the structural form of the stochastic policy itself and does not make any additional assumptions about the MDP. We demonstrate and quantify the benefit of the action-dependent baseline through both theoretical analysis as well as numerical results, including an analysis of the suboptimality of the optimal state-dependent baseline. The result is a computationally efficient policy gradient algorithm, which scales to high-dimensional control problems, as demonstrated by a synthetic 2000-dimensional target matching task. Our experimental results indicate that action-dependent baselines allow for faster learning on standard reinforcement learning benchmarks and high-dimensional hand manipulation and synthetic tasks. Finally, we show that the general idea of including additional information in baselines for improved variance reduction can be extended to partially observed and multi-agent tasks.

- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)