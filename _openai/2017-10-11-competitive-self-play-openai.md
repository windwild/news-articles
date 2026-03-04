---
render_with_liquid: false
title: "Competitive self-play | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/competitive-self-play"
date: "2017-10-11"
scraped_at: "2026-03-02T10:31:58.135534976+00:00"
language: "en-US"
translated: false
description: "We’ve found that self-play allows simulated AIs to discover physical skills like tackling, ducking, faking, kicking, catching, and diving for the ball, without explicitly designing an environment wi..."
tags: ["Research"]
---

October 11, 2017


# Competitive self-play

[View code(opens in a new window)](https://github.com/openai/multiagent-competition) [Read paper(opens in a new window)](https://arxiv.org/abs/1710.03748)

![Competitive Self Play](images/competitive-self-play-openai/img_001.jpg)

Illustration: Ben Barry



We’ve found that self-play allows simulated AIs to discover physical skills like tackling, ducking, faking, kicking, catching, and diving for the ball, without explicitly designing an environment with these skills in mind. Self-play ensures that the environment is always the right difficulty for an AI to improve. Taken alongside our Dota 2 self-play results, we have increasing confidence that self-play will be a core part of powerful AI systems in the future.

![3D render of two human figures on a round platform engaging physically with each other](images/competitive-self-play-openai/img_002.jpg)

00:00

We set up competitions between multiple simulated 3D robots on a range of basic games, trained each agent with simple goals (push the opponent out of the sumo ring, reach the other side of the ring while preventing the other agent from doing the same, kick the ball into the net or prevent the other agent from doing so, and so on), then analyzed the different strategies that emerged.

Agents initially receive dense rewards for behaviours that aid exploration like standing and moving forward, which are eventually annealed to zero in favor of being rewarded for just winning and losing. Despite the simple rewards, the agents learn subtle behaviors like tackling, ducking, faking, kicking and catching, and diving for the ball. Each agent’s neural network policy is independently trained with [Proximal Policy Optimization⁠(opens in a new window)](https://arxiv.org/abs/1707.06347).

To understand how complex behaviors can emerge through a combination of simple goals and competitive pressure, let’s analyze the sumo wrestling task. Here we took the dense reward defined in [previous work⁠(opens in a new window)](https://arxiv.org/abs/1506.02438) for training a humanoid to walk, removed the term for velocity, added the negative L2 distance from the center of the ring and took this as a dense exploration reward for our sumo agents. The agents were allowed to use this reward for exploration in the ring initially, then we slowly annealed it to zero so the agents would learn to optimize for the competition reward — pushing the other player out of the ring — for the remaining training iterations.

Though it is possible to design tasks and environments that require each of these skills, this requires effort and ingenuity on the part of human designers, and the agents’ behaviors will be bounded in complexity by the problems that the human designer can pose for them. By developing agents through thousands of iterations of matches against successively better versions of themselves, we can create AI systems that successively bootstrap their own performance; we saw a similar phenomenon in our [Dota 2 project⁠](https://openai.com/index/more-on-dota-2/), where self-play let us create an RL agent that could beat top human players at a solo version of the e-sport.

## Transfer Learning

Agent trained on sumo wrestling, and then subjected to a variable unknown “wind”.

These agents also exhibit transfer learning, applying skills learned in one setting to succeed in another never-before-seen one. In one case, we took the agent trained on the self-play sumo wrestling task and faced it with the task of standing while being perturbed by “wind” forces. The agent managed to stay upright despite never seeing the windy environment or observing wind forces, while agents trained to walk using classical reinforcement learning would fall over immediately.

Agent trained to walk using classical reinforcement learning, and then subjected to a variable unknown “wind”.

## Overfitting

Our agents were overfitting by co-learning policies that were precisely tailored to counter specific opponents, but would fail when facing new ones with different characteristics. We dealt with this by pitting each agent against several different opponents rather than just one. These possible opponents come from an ensemble of policies that were trained in parallel as well as policies from earlier in the training process. Given this diversity of opponents, agents needed to learn general strategies and not just ones targeted to a specific opponent.

Additionally, we’re [releasing⁠(opens in a new window)](https://github.com/openai/multiagent-competition) the MuJoCo environments and trained policies used in this work so that others can experiment with these systems. If you’d like to work on self-play systems, we’re [hiring⁠](https://openai.com/careers/)!

- [Simulated Environments](https://openai.com/research/index/?tags=simulated-environments)
- [Exploration & Games](https://openai.com/research/index/?tags=exploration-game)
- [Transformers](https://openai.com/research/index/?tags=transformers)
- [Multi-agent](https://openai.com/research/index/?tags=multi-agent)