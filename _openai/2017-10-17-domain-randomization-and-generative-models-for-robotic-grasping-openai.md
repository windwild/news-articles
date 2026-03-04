---
title: "Domain randomization and generative models for robotic grasping | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/domain-randomization-and-generative-models-for-robotic-grasping"
date: "2017-10-17"
scraped_at: "2026-03-02T10:31:47.201213307+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---
&#123;% raw %}

October 17, 2017


# Domain randomization and generative models for robotic grasping

[Read paper(opens in a new window)](https://arxiv.org/abs/1710.06425)

![Domain Randomization And Generative Models For Robotic Grasping](images/domain-randomization-and-generative-models-for-robotic-grasping-openai/img_001.png)



## Abstract

Deep learning-based robotic grasping has made significant progress thanks to algorithmic improvements and increased data availability. However, state-of-the-art models are often trained on as few as hundreds or thousands of unique object instances, and as a result generalization can be a challenge.

In this work, we explore a novel data generation pipeline for training a deep neural network to perform grasp planning that applies the idea of domain randomization to object synthesis. We generate millions of unique, unrealistic procedurally generated objects, and train a deep neural network to perform grasp planning on these objects.Since the distribution of successful grasps for a given object can be highly multimodal, we propose an autoregressive grasp planning model that maps sensor inputs of a scene to a probability distribution over possible grasps. This model allows us to sample grasps efficiently at test time (or avoid sampling entirely).

We evaluate our model architecture and data generation pipeline in simulation and the real world. We find we can achieve a >90% success rate on previously unseen realistic objects at test time in simulation despite having only been trained on random objects. We also demonstrate an 80% success rate on real-world grasp attempts despite having only been trained on random simulated objects.

- [Generative Models](https://openai.com/research/index/?tags=generative-models)
- [Robotics](https://openai.com/research/index/?tags=robotics)
&#123;% endraw %}
