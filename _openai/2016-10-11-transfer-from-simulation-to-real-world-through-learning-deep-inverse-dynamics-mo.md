---
render_with_liquid: false
title: "Transfer from simulation to real world through learning deep inverse dynamics model | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/transfer-from-simulation-to-real-world-through-learning-deep-inverse-dynamics-model"
date: "2016-10-11"
scraped_at: "2026-03-02T10:33:59.076730221+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---

October 11, 2016


# Transfer from simulation to real world through learning deep inverse dynamics model

[Read paper(opens in a new window)](https://arxiv.org/abs/1610.03518)

![Transfer From Simulation To Real World Through Learning Deep Inverse Dynamics Model](images/transfer-from-simulation-to-real-world-through-learning-deep-inverse-dynamics-mo/img_001.webp)



## Abstract

Developing control policies in simulation is often more practical and safer than directly running experiments in the real world. This applies to policies obtained from planning and optimization, and even more so to policies obtained from reinforcement learning, which is often very data demanding. However, a policy that succeeds in simulation often doesn't work when deployed on a real robot. Nevertheless, often the overall gist of what the policy does in simulation remains valid in the real world. In this paper we investigate such settings, where the sequence of states traversed in simulation remains reasonable for the real world, even if the details of the controls are not, as could be the case when the key differences lie in detailed friction, contact, mass and geometry properties. During execution, at each time step our approach computes what the simulation-based control policy would do, but then, rather than executing these controls on the real robot, our approach computes what the simulation expects the resulting next state(s) will be, and then relies on a learned deep inverse dynamics model to decide which real-world action is most suitable to achieve those next states. Deep models are only as good as their training data, and we also propose an approach for data collection to (incrementally) learn the deep inverse dynamics model. Our experiments shows our approach compares favorably with various baselines that have been developed for dealing with simulation to real world model discrepancy, including output error control and Gaussian dynamics adaptation.

- [Robotics](https://openai.com/research/index/?tags=robotics)