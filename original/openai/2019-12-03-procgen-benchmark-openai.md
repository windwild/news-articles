---
title: "Procgen Benchmark | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/procgen-benchmark"
date: "2019-12-03"
scraped_at: "2026-03-02T10:27:38.727338244+00:00"
language: "en-US"
translated: false
description: "We’re releasing Procgen Benchmark, 16 simple-to-use procedurally-generated environments which provide a direct measure of how quickly a reinforcement learning agent learns generalizable skills."
tags: ["Research"]
---

December 3, 2019


# Procgen Benchmark

We’re releasing Procgen Benchmark, 16 simple-to-use procedurally-generated environments which provide a direct measure of how quickly a reinforcement learning agent learns generalizable skills.

[Read paper(opens in a new window)](https://arxiv.org/abs/1912.01588) [Environment code(opens in a new window)](https://github.com/openai/procgen) [Training code(opens in a new window)](https://github.com/openai/train-procgen)

![A colorful collage of square-dimension 2D maze game interfaces](images/procgen-benchmark-openai/img_001.png)



Your browser does not support the video tag.

00:00

## Getting started

#### Bash

`1$ pip install procgen # install

2$ python -m procgen.interactive --env-name starpilot # human

3$ python &lt;&lt;EOF # random AI agent

4import gym

5env = gym.make('procgen:procgen-coinrun-v0')

6obs = env.reset()

7while True:

8    obs, rew, done, info = env.step(env.action_space.sample())

9    env.render()

10    if done:

11        break

12EOF

`

Using the environment is easy whether you’re a human or AI:

We’ve found that all of the Procgen environments require training on 500–1000 different levels before they can generalize to new levels, which suggests that standard RL benchmarks need much more diversity within each environment. Procgen Benchmark has become the standard research platform used by the OpenAI RL team, and we hope that it accelerates the community in creating better RL algorithms.

## Environment diversity is key

[In⁠(opens in a new window)](https://arxiv.org/abs/1804.06893) [several⁠](https://openai.com/index/quantifying-generalization-in-reinforcement-learning/) [environments⁠(opens in a new window)](https://arxiv.org/abs/1806.10729), it has been observed that agents can overfit to remarkably large training sets. This evidence raises the possibility that overfitting pervades classic benchmarks like the [Arcade Learning Environment⁠(opens in a new window)](https://arxiv.org/abs/1207.4708), which has long served as a gold standard in reinforcement learning (RL). While the diversity between different games in the ALE is one of the benchmark’s greatest strengths, the low emphasis on generalization presents a significant drawback. In each game the question must be asked: are agents robustly learning a relevant skill, or are they approximately memorizing specific trajectories?

[CoinRun⁠](https://openai.com/index/quantifying-generalization-in-reinforcement-learning/) was designed to address precisely this issue, by using procedural generation to construct distinct sets of training levels and test levels. While CoinRun has helped us better quantify generalization in RL, it is still only a single environment. It’s likely that CoinRun is not fully representative of the many challenges RL agents must face. We want the best of both worlds: a benchmark comprised of many diverse environments, each of which fundamentally requires generalization. To fulfill this need, we have created Procgen Benchmark. CoinRun now serves as the inaugural environment in Procgen Benchmark, contributing its diversity to a greater whole.

Previous work, including the [Obstacle Tower Challenge⁠(opens in a new window)](https://arxiv.org/abs/1902.01378) and the [General Video Game AI framework⁠(opens in a new window)](https://arxiv.org/abs/1802.10363), has also encouraged using procedural generation to better evaluate generalization in RL. We’ve designed environments in a similar spirit, with two Procgen environments drawing direct inspiration from [GVGAI-based work⁠(opens in a new window)](https://arxiv.org/abs/1806.10729). Other environments like Dota and StarCraft also provide lots of per-environment complexity, but these environments are hard to rapidly iterate with (and it’s even harder to use more than one such environment at a time). With Procgen Benchmark, we strive for all of the following: experimental convenience, high diversity within environments, and high diversity across environments.

## Procgen Benchmark

Procgen Benchmark consists of 16 unique environments designed to measure both sample efficiency and generalization in reinforcement learning. This benchmark is ideal for evaluating generalization since distinct training and test sets can be generated in each environment. This benchmark is also well-suited to evaluate sample efficiency, since all environments pose diverse and compelling challenges for RL agents. The environments’ intrinsic diversity demands that agents learn robust policies; overfitting to narrow regions in state space will not suffice. Put differently, the ability to generalize becomes an integral component of success when agents are faced with ever-changing levels.

## Design principles

We’ve designed all Procgen environments to satisfy the following criteria:

- **High Diversity**: Environment generation logic is given maximal freedom, subject to basic design constraints. The diversity in the resulting level distributions presents agents with meaningful generalization challenges.
- **Fast Evaluation**: Environment difficulty is calibrated such that baseline agents make significant progress after training for 200M timesteps. Moreover, the environments are optimized to perform thousands of steps per second on a single CPU core, enabling a fast experimental pipeline.
- **Tunable Difficulty**: All environments support two well-calibrated difficulty settings: easy and hard. While we report results using the hard difficulty setting, we make the easy difficulty setting available for those with limited access to compute power. Easy environments require approximately an eighth of the resources to train.
- **Emphasis on Visual Recognition and Motor Control**: In keeping with precedent, environments mimic the style of many Atari and Gym Retro games. Performing well primarily depends on identifying key assets in the observation space and enacting appropriate low level motor responses.

Your browser does not support the video tag.

00:00

## Evaluating generalization

We came to appreciate how hard RL generalization can be while conducting the [Retro Contest⁠](https://openai.com/index/first-retro-contest-retrospective/), as agents continually failed to generalize from the limited data in the training set. Later, our CoinRun experiments painted an even clearer picture of our agents’ struggle to generalize. We’ve now expanded on those results, conducting our most thorough study of RL generalization to date using all 16 environments in Procgen Benchmark.

We first measured how the size of the training set impacts generalization. In each environment, we generated training sets ranging in size from 100 to 100,000 levels. We trained agents for 200M timesteps on these levels using [Proximal Policy Optimization⁠](https://openai.com/index/openai-baselines-ppo/), and we measured performance on unseen test levels.

Generalization performance

Score over 100k levels, log scale

Train

Test

CoinRun

1001k10k100k56789

StarPilot

1001k10k100k0510152025

CaveFlyer

1001k10k100k246810

Dodgeball

1001k10k100k246810

Fruitbot

1001k10k100k0510152025

Chaser

1001k10k100k456789

Miner

1001k10k100k6810121416182022

Jumper

1001k10k100k2345678

Leaper

1001k10k100k0246810

Maze

1001k10k100k2345678910

BigFish

1001k10k100k0510152025

Heist

1001k10k100k0246810

Climber

1001k10k100k4681012

Plunder

1001k10k100k5101520

Ninja

1001k10k100k45678910

BossFight

1001k10k100k8.59.09.510.010.511.011.512.0

We found that agents strongly overfit to small training sets in almost all environments. In some cases, agents need access to as many as 10,000 levels to close the generalization gap. We also saw a peculiar trend emerge in many environments: past a certain threshold, training performance improves as the training sets grows! This runs counter to trends found in supervised learning, where training performance commonly decreases with the size of the training set. We believe this increase in training performance comes from an implicit curriculum provided by a diverse set of levels. A larger training set can improve training performance if the agent learns to generalize _even across levels in the training set_. We previously noticed this effect with CoinRun, and have found it often occurs in many Procgen environments as well.

## An ablation with deterministic levels

Train and test performance

Score over 200M timesteps

Train

Test

CoinRun

0M50M100M150M200M02004006008001,0001,200

StarPilot

0M50M100M150M200M0100200300400500

CaveFlyer

0M50M100M150M200M0100200300400500600

Dodgeball

0M50M100M150M200M050100150200250

Fruitbot

0M50M100M150M200M0200400600800

Chaser

0M50M100M150M200M020406080100120140160180

Miner

0M50M100M150M200M050100150200250

Jumper

0M50M100M150M200M050100150200250300

Leaper

0M50M100M150M200M020406080100

Maze

0M50M100M150M200M050100150200

BigFish

0M50M100M150M200M0100200300400500

Heist

0M50M100M150M200M05101520253035

Climber

0M50M100M150M200M050100150200250

Plunder

0M50M100M150M200M050100150200250

Ninja

0M50M100M150M200M020406080100

BossFight

0M50M100M150M200M020406080100

At test time, we remove the determinism in the sequence of levels, instead choosing level sequences at random. We find that agents become competent over the first several training levels in most games, giving an illusion of meaningful progress. However, test performance demonstrates that the agents have in fact learned almost nothing about the underlying level distribution. We believe this vast gap between training and test performance is worth highlighting. It reveals a crucial hidden flaw in training on environments that follow a fixed sequence of levels. These results show just how essential it is to use diverse environment distributions when training and evaluating RL agents.

## Next steps

We expect many insights gleaned from this benchmark to apply in more complex settings, and we’re excited to use these new environments to design more capable and efficient agents.

_If you’re interested in helping develop diverse environments,_ [_we’re hiring_ ⁠](https://openai.com/careers/) _!_

- [Exploration & Games](https://openai.com/research/index/?tags=exploration-game)
- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)
- [Simulated Environments](https://openai.com/research/index/?tags=simulated-environments)
- [Software & Engineering](https://openai.com/research/index/?tags=software-engineering)