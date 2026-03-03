---
title: "Spam detection in the physical world | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/spam-detection-in-the-physical-world"
date: "2017-04-01"
scraped_at: "2026-03-02T10:33:09.189290356+00:00"
language: "en-US"
translated: false
description: "We’ve created the world’s first Spam-detecting AI trained entirely in simulation and deployed on a physical robot."
tags: ["Research"]
---

April 1, 2017


# Spam detection in the physical world

We’ve created the world’s first Spam-detecting AI trained entirely in simulation and deployed on a physical robot.

![Video recording still of a robotic arm picking up a mixture of items on a small square table](images/spam-detection-in-the-physical-world-openai/img_001.webp)

Loading…


![Video recording still of a robotic arm picking up a mixture of items on a small square table](images/spam-detection-in-the-physical-world-openai/img_002.gif)

## Sim-to-real transfer

Deep learning-driven robotic systems are bottlenecked by data collection: it’s extremely costly to obtain the hundreds of thousands of images needed to train the perception system alone. It’s cheap to generate simulated data, but simulations diverge enough from reality that people typically retrain models from scratch when moving to the physical world.

We’ve [shown⁠(opens in a new window)](https://arxiv.org/abs/1703.06907) that domain randomization, an existing idea for making detectors trained on simulated images transfer to real images, works well for cluttered scenes. The method is simple: we randomly vary colors, textures, lighting conditions, and camera settings in simulated scenes. The resulting dataset is sufficiently variable to allow a deep neural network trained on it to generalize to reality.

![Train](images/spam-detection-in-the-physical-world-openai/img_003.gif)

Randomly generated scenes. Each frame contains Spam, often hidden among distractor objects. Our Spam model is sourced from the YCB dataset.

## Our implementation

The detector is a neural network based on the [VGG16⁠(opens in a new window)](https://www.cs.toronto.edu/~frossard/post/vgg16/) architecture that predicts the precise 3-D location of Spam in simulated images. Though it has only been trained on simulated scenes, the resulting network is able to detect Spam in real images, even in the presence of never-before-seen “distractor” items arranged in random configurations.

The video below demonstrates the system in action:

## Future work

In the future, we plan to extend this work to detect [phishing⁠(opens in a new window)](https://en.wikipedia.org/wiki/Phishing) and to defend against [adversarial⁠](https://openai.com/index/attacking-machine-learning-with-adversarial-examples/) Spam.

![Video recording still of a can of tuna next to a can of spam wearing costume glasses](images/spam-detection-in-the-physical-world-openai/img_004.jpg)

If you’d like to sink your teeth into compelling applied research problems like Spam detection, consider [joining us⁠](https://openai.com/careers/) at OpenAI.

- [Simulated Environments](https://openai.com/research/index/?tags=simulated-environments)
- [Robotics](https://openai.com/research/index/?tags=robotics)