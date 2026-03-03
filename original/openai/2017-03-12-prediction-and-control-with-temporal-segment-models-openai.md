---
title: "Prediction and control with temporal segment models | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/prediction-and-control-with-temporal-segment-models"
date: "2017-03-12"
scraped_at: "2026-03-02T10:48:05.142803663+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---

March 12, 2017


# Prediction and control with temporal segment models

[Read paper(opens in a new window)](https://arxiv.org/abs/1703.04070)

![Prediction And Control With Temporal Segment Models](images/prediction-and-control-with-temporal-segment-models-openai/img_001.webp)



## Abstract

We introduce a method for learning the dynamics of complex nonlinear systems based on deep generative models over temporal segments of states and actions. Unlike dynamics models that operate over individual discrete timesteps, we learn the distribution over future state trajectories conditioned on past state, past action, and planned future action trajectories, as well as a latent prior over action trajectories. Our approach is based on convolutional autoregressive models and variational autoencoders. It makes stable and accurate predictions over long horizons for complex, stochastic systems, effectively expressing uncertainty and modeling the effects of collisions, sensory noise, and action delays. The learned dynamics model and action prior can be used for end-to-end, fully differentiable trajectory optimization and model-based policy optimization, which we use to evaluate the performance and sample-efficiency of our method.

- [Generative Models](https://openai.com/research/index/?tags=generative-models)