---
title: "Sim-to-real transfer of robotic control with dynamics randomization | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/sim-to-real-transfer-of-robotic-control-with-dynamics-randomization"
date: "2017-10-18"
scraped_at: "2026-03-02T10:31:53.181400987+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---
&#123;% raw %}

October 18, 2017


# Sim-to-real transfer of robotic control with dynamics randomization

[Read paper(opens in a new window)](https://arxiv.org/abs/1710.06537)

![Sim To Real Transfer Of Robotic Control With Dynamics Randomization](images/sim-to-real-transfer-of-robotic-control-with-dynamics-randomization-openai/img_001.webp)



## Abstract

Simulations are attractive environments for training agents as they provide an abundant source of data and alleviate certain safety concerns during the training process. But the behaviours developed by agents in simulation are often specific to the characteristics of the simulator. Due to modeling error, strategies that are successful in simulation may not transfer to their real world counterparts. In this paper, we demonstrate a simple method to bridge this "reality gap". By randomizing the dynamics of the simulator during training, we are able to develop policies that are capable of adapting to very different dynamics, including ones that differ significantly from the dynamics on which the policies were trained. This adaptivity enables the policies to generalize to the dynamics of the real world without any training on the physical system. Our approach is demonstrated on an object pushing task using a robotic arm. Despite being trained exclusively in simulation, our policies are able to maintain a similar level of performance when deployed on a real robot, reliably moving an object to a desired location from random initial configurations. We explore the impact of various design decisions and show that the resulting policies are robust to significant calibration error.

- [Simulated Environments](https://openai.com/research/index/?tags=simulated-environments)
- [Robotics](https://openai.com/research/index/?tags=robotics)
&#123;% endraw %}
