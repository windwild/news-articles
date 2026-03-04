---
title: "Prediction and control with temporal segment models | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/prediction-and-control-with-temporal-segment-models"
date: "2017-03-12"
scraped_at: "2026-03-02T10:48:05.142803663+00:00"
language: "en-US"
translated: true
tags: ["Research"]
---
&#123;% raw %}

March 12, 2017

2017年3月12日


# Prediction and control with temporal segment models

# 基于时间片段模型的预测与控制

[Read paper(opens in a new window)](https://arxiv.org/abs/1703.04070)

[阅读论文（在新窗口中打开）](https://arxiv.org/abs/1703.04070)

![Prediction And Control With Temporal Segment Models](images/prediction-and-control-with-temporal-segment-models-openai/img_001.webp)

![基于时间片段模型的预测与控制](images/prediction-and-control-with-temporal-segment-models-openai/img_001.webp)


## Abstract

## 摘要

We introduce a method for learning the dynamics of complex nonlinear systems based on deep generative models over temporal segments of states and actions. Unlike dynamics models that operate over individual discrete timesteps, we learn the distribution over future state trajectories conditioned on past state, past action, and planned future action trajectories, as well as a latent prior over action trajectories. Our approach is based on convolutional autoregressive models and variational autoencoders. It makes stable and accurate predictions over long horizons for complex, stochastic systems, effectively expressing uncertainty and modeling the effects of collisions, sensory noise, and action delays. The learned dynamics model and action prior can be used for end-to-end, fully differentiable trajectory optimization and model-based policy optimization, which we use to evaluate the performance and sample-efficiency of our method.

我们提出一种基于状态与动作时间片段的深度生成模型来学习复杂非线性系统动力学的方法。与仅在单个离散时间步上运行的动力学模型不同，我们学习的是未来状态轨迹的分布，该分布以过去的状态、过去的行为、规划的未来行为轨迹以及行为轨迹的潜在先验为条件。本方法基于卷积自回归模型和变分自编码器（VAE），能够对复杂随机系统进行长期、稳定且精确的预测，有效表达不确定性，并建模碰撞、感知噪声及动作延迟等效应。所学习到的动力学模型与行为先验可用于端到端、完全可微的轨迹优化和基于模型的策略优化，我们借此评估了本方法的性能与样本效率。

- [Generative Models](https://openai.com/research/index/?tags=generative-models)

- [生成模型](https://openai.com/research/index/?tags=generative-models)
&#123;% endraw %}
