---
title: "Asymmetric actor critic for image-based robot learning | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/asymmetric-actor-critic-for-image-based-robot-learning"
date: "2017-10-18"
scraped_at: "2026-03-02T10:31:51.876247093+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---
&#123;% raw %}

October 18, 2017


# Asymmetric actor critic for image-based robot learning

[(opens in a new window)](https://arxiv.org/abs/1710.06542)

![Asymmetric Actor Critic For Image Based Robot Learning](images/asymmetric-actor-critic-for-image-based-robot-learning-openai/img_001.webp)



## Abstract

Deep reinforcement learning (RL) has proven a powerful technique in many sequential decision making domains. However, Robotics poses many challenges for RL, most notably training on a physical system can be expensive and dangerous, which has sparked significant interest in learning control policies using a physics simulator. While several recent works have shown promising results in transferring policies trained in simulation to the real world, they often do not fully utilize the advantage of working with a simulator. In this work, we exploit the full state observability in the simulator to train better policies which take as input only partial observations (RGBD images). We do this by employing an actor-critic training algorithm in which the critic is trained on full states while the actor (or policy) gets rendered images as input. We show experimentally on a range of simulated tasks that using these asymmetric inputs significantly improves performance. Finally, we combine this method with domain randomization and show real robot experiments for several tasks like picking, pushing, and moving a block. We achieve this simulation to real world transfer without training on any real world data.

- [Robotics](https://openai.com/research/index/?tags=robotics)
&#123;% endraw %}
