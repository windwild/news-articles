---
title: "Training a Helpful and Harmless Assistant with Reinforcement Learning from Human Feedback"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/training-a-helpful-and-harmless-assistant-with-reinforcement-learning-from-human-feedback"
date: "2024-12-19"
scraped_at: "2026-03-03T06:47:00.110756037+00:00"
language: "en"
translated: false
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---

AlignmentResearch

# Training a Helpful and Harmless Assistant with Reinforcement Learning from Human Feedback

Apr 12, 2022

[Read Paper](https://arxiv.org/abs/2204.05862)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.


## Abstract

We apply preference modeling and reinforcement learning from human feedback (RLHF) to finetune language models to act as helpful and harmless assistants. We find this alignment training improves performance on almost all NLP evaluations, and is fully compatible with training for specialized skills such as python coding and summarization. We explore an iterated online mode of training, where preference models and RL policies are updated on a weekly cadence with fresh human feedback data, efficiently improving our datasets and models. Finally, we investigate the robustness of RLHF training, and identify a roughly linear relation between the RL reward and the square root of the KL divergence between the policy and its initialization. Alongside our main results, we perform peripheral analyses on calibration, competing objectives, and the use of OOD detection, compare our models with human writers, and provide samples from our models using prompts appearing in recent related work.