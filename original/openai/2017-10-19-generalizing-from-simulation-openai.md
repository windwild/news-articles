---
title: "Generalizing from simulation | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/generalizing-from-simulation"
date: "2017-10-19"
scraped_at: "2026-03-02T10:32:05.627055192+00:00"
language: "en-US"
translated: false
description: "Our latest robotics techniques allow robot controllers, trained entirely in simulation and deployed on physical robots, to react to unplanned changes in the environment as they solve simple tasks. Tha..."
tags: ["Research"]
---

October 19, 2017


# Generalizing from simulation

[Read paper (dynamics randomization)(opens in a new window)](https://arxiv.org/abs/1710.06537) [Read paper (image-based learning)(opens in a new window)](https://arxiv.org/abs/1710.06542)

![Colorful 3D render of a robot simulation interacting with a red cube on a platform](images/generalizing-from-simulation-openai/img_001.jpg)



Our latest robotics techniques allow robot controllers, trained entirely in simulation and deployed on physical robots, to react to unplanned changes in the environment as they solve simple tasks. That is, we’ve used these techniques to build closed-loop systems rather than open-loop ones as before.

The simulator need not match the real-world in appearance or dynamics; instead, we randomize relevant aspects of the environment, from friction to action delays to sensor noise. Our new results provide more evidence that general-purpose robots can be built by training entirely in simulation, followed by a small amount of self-calibration in the real world.

This robot was trained in simulation with dynamics randomization to push a puck to a goal. In the real world, we put the puck on a bag of chips, and the robot still achieves the goal despite the bag changing the sliding properties in an unfamiliar way.

## Dynamics randomization

We developed [dynamics randomization⁠(opens in a new window)](https://arxiv.org/abs/1710.06537) to train a robot to adapt to unknown real-world dynamics. During training, we randomize a large set of ninety-five properties that determine the dynamics of the environment, such as altering the mass of each link in the robot’s body; the friction and damping of the object it is being trained on; the height of the table the object is on; the latency between actions; the noise in its observations; and so on.

We used this approach to train an [LSTM⁠(opens in a new window)](http://colah.github.io/posts/2015-08-Understanding-LSTMs/)-based policy to push a hockey puck around a table. Our feed-forward networks [fail⁠](https://openai.com/index/generalizing-from-simulation/#pusher_fail) at this task, whereas LSTMs can use their past observations to analyze the dynamics of the world and adjust their behavior accordingly.

## From vision to action

We also trained a robot end-to-end in simulation using reinforcement learning (RL), and deployed the resulting policy on a physical robot. The resulting system maps vision directly to action without special sensors, and can adapt to visual feedback.

View from the robot’s camera. The policy for picking up blocks is trained end-to-end from vision to action, on randomized visuals. Note that in simulation, the gripper moves up slightly as the block slides down in order to keep the block in the desired position. The gripper doesn’t do this in the physical world as the block does not slide.

The abundance of RL results with simulated robots can make it seem like RL easily solves most robotics tasks. But common RL algorithms work well only on tasks where small perturbations to your action can provide an incremental change to the reward. Some robotics tasks have simple rewards, like walking, where you can be scored on distance traveled. But most tasks do [not⁠](https://openai.com/index/learning-from-human-preferences/)—to define a dense reward for block stacking, you’d need to encode that the arm is close to the block, that the arm approaches the block in the correct orientation, that the block is lifted off the ground, the distance of block to the desired position, etc.

We spent a number of months unsuccessfully trying to get conventional RL algorithms working on pick-and-place tasks before ultimately developing a new reinforcement learning algorithm, [Hindsight Experience Replay⁠(opens in a new window)](https://arxiv.org/pdf/1707.01495.pdf) (HER), which allows agents to learn from a binary reward by pretending that a failure was what they wanted to do all along and learning from it accordingly. (By analogy, imagine looking for a gas station but ending up at a pizza shop. You still don’t know where to get gas, but you’ve now learned where to get pizza.) We also used [domain randomization⁠](https://openai.com/index/spam-detection-in-the-physical-world/) on the visual shapes to learn a vision system robust enough for the physical world.

Our HER implementation uses the actor-critic technique with asymmetric information. (The _actor_ is the policy, and the _critic_ is a network which receives action/state pairs and estimates their Q-value, or sum of future rewards, providing training signal to the actor.) While the critic has access to the full state of the simulator, the actor only has access to RGB and depth data. Thus the critic can provide fully accurate feedback, while the actor uses only data present in the real world.

## Costs

Both techniques increase the computational requirements: dynamics randomization slows training down by a factor of 3x, while learning from images rather than states is about 5–10x slower.

We see three approaches to building general-purpose robots: training on huge fleets of physical robots, making simulators increasingly match the real world, and randomizing the simulator to allow the model to generalize to the real-world. We increasingly believe that the third will be the most important part of the solution.

If you’re interested in helping us push towards general-purpose robots, consider [joining our team at OpenAI⁠](https://openai.com/careers/).

A naive feed-forward policy is unable to adapt to the real-world puck environment despite solving the task in simulation.

- [Simulated Environments](https://openai.com/research/index/?tags=simulated-environments)
- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)
- [Robotics](https://openai.com/research/index/?tags=robotics)