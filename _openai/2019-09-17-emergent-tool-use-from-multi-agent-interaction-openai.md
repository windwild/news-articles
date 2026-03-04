---
title: "Emergent tool use from multi-agent interaction | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/emergent-tool-use"
date: "2019-09-17"
scraped_at: "2026-03-02T10:28:34.816383329+00:00"
language: "en-US"
translated: false
description: "We’ve observed agents discovering progressively more complex tool use while playing a simple game of hide-and-seek. Through training in our new simulated hide-and-seek environment, agents build a se..."
tags: ["Research"]
---
{% raw %}

September 17, 2019


# Emergent tool use from multi-agent interaction

[Read paper(opens in a new window)](https://arxiv.org/abs/1909.07528) [Environment generation(opens in a new window)](https://github.com/openai/multi-agent-emergence-environments) [Worldgen(opens in a new window)](https://github.com/openai/mujoco-worldgen)

![Isometric view of a gray grid with multi-agents playing hide and seek in each square](images/emergent-tool-use-from-multi-agent-interaction-openai/img_001.png)

Illustration: Ben Barry



We’ve observed agents discovering progressively more complex tool use while playing a simple game of hide-and-seek. Through training in our new simulated hide-and-seek environment, agents build a series of six distinct strategies and counterstrategies, some of which we did not know our environment supported. The self-supervised emergent complexity in this simple environment further suggests that multi-agent co-adaptation may one day produce extremely complex and intelligent behavior.

![3D depictions of multi-agents playing hide and seek, one red and one blue](images/emergent-tool-use-from-multi-agent-interaction-openai/img_002.jpg)

00:00

In our environment, agents play a team-based hide-and-seek game. Hiders (blue) are tasked with avoiding line-of-sight from the seekers (red), and seekers are tasked with keeping vision of the hiders. There are objects scattered throughout the environment that hiders and seekers can grab and lock in place, as well as randomly generated immovable rooms and walls that agents must learn to navigate. Before the game begins, hiders are given a preparation phase where seekers are immobilized to give hiders a chance to run away or change their environment.

The agents can **move** by setting a force on themselves in the x and y directions as well as rotate along the z-axis.

The agents can **see** objects in their line of sight and within a frontal cone.

The agents can **sense** distance to objects, walls, and other agents around them using a lidar-like sensor.

The agents can **grab and move** objects in front of them.

The agents can **lock** objects in place. Only the team that locked an object can unlock it.

There are no explicit incentives for agents to interact with objects in the environment; the only supervision given is through the hide-and-seek objective. Agents are given a team-based reward; hiders are given a reward of +1 if all hiders are hidden and -1 if any hider is seen by a seeker. Seekers are given the opposite reward, -1 if all hiders are hidden and +1 otherwise. To confine agent behavior to a reasonable space, agents are penalized if they go too far outside the play area. During the preparation phase, all agents are given zero reward.

## Autocurricula and emergent behavior

As agents train against each other in hide-and-seek, **as many as six distinct strategies emerge**. Each new strategy creates a previously nonexistent pressure for agents to progress to the next stage. Note that there are no direct incentives for agents to interact with objects or to explore; rather, the emergent strategies shown below are a result of the [_autocurriculum_ ⁠(opens in a new window)](https://arxiv.org/pdf/1903.00742.pdf) induced by multi-agent competition and the simple dynamics of hide-and-seek.

### Emergence in a simple environment We first show emergent

We first show emergent strategies learned in a simple environment with 2 hiders, 2 seekers, 2 boxes, 1 ramp, and a room that has between 1–2 randomly placed doors.

###### Rewards per episode

Seekers

Hiders

chart = RuntimeError: Failed to fetch

Games played

![](images/emergent-tool-use-from-multi-agent-interaction-openai/img_003.svg)

![](images/emergent-tool-use-from-multi-agent-interaction-openai/img_004.svg)

![](images/emergent-tool-use-from-multi-agent-interaction-openai/img_005.svg)

![](images/emergent-tool-use-from-multi-agent-interaction-openai/img_006.svg)

![](images/emergent-tool-use-from-multi-agent-interaction-openai/img_007.svg)

### Emergence in the full environment

Next, we show emergent strategies learned in an environment with far more randomization, including 1–3 hiders, 1–3 seekers, 3–9 blocks, 2 ramps, and randomized rooms and doors. In this full environment, agents go through two more phases of emergent strategy than in the previous simple environment.

###### Rewards per episode

Seekers

Hiders

chart = RuntimeError: Failed to fetch

Games played

![](images/emergent-tool-use-from-multi-agent-interaction-openai/img_008.svg)

![](images/emergent-tool-use-from-multi-agent-interaction-openai/img_009.svg)

![](images/emergent-tool-use-from-multi-agent-interaction-openai/img_010.svg)

![](images/emergent-tool-use-from-multi-agent-interaction-openai/img_011.svg)

![](images/emergent-tool-use-from-multi-agent-interaction-openai/img_012.svg)

![](images/emergent-tool-use-from-multi-agent-interaction-openai/img_013.svg)

![](images/emergent-tool-use-from-multi-agent-interaction-openai/img_014.svg)

## Training hide-and-seek agents

We use the same training infrastructure and algorithms used to train [OpenAI Five⁠](https://openai.com/index/openai-five/) and [Dactyl⁠](https://openai.com/index/learning-dexterity/). However, in our environment each agent acts independently, using its own observations and hidden memory state. Agents use an entity-centric state-based representation of the world, which is _permutation invariant_ with respect to objects and other agents.

Each object is embedded and then passed through a masked residual self attention block, similar to those used in [transformers⁠(opens in a new window)](https://arxiv.org/pdf/1706.03762.pdf), where the attention is over objects instead of over time. Objects that are not in line-of-sight and in front of the agent are masked out such that the agent has no information of them.

![Diagram of multi agent policy architecture](images/emergent-tool-use-from-multi-agent-interaction-openai/img_015.png)

Agent policies are trained with [self-play⁠](https://openai.com/index/competitive-self-play/) and [Proximal Policy Optimization⁠](https://openai.com/index/openai-baselines-ppo/). During optimization, agents can use privileged information about obscured objects and other agents in their value function.

We found that large scale training was critical in agents progressing through the various stages of emergence. Below we show both the time and number of episodes it takes agents to reach stage 4 (ramp defense) for various batch sizes. We find increasing batch size gives a drastic speedup in wall-clock time to convergence, though doesn’t affect the sample efficiency greatly at or above 32k. However, we found that batch sizes of 8k and 16k never reached stage 4 in the allotted number of episodes.

# Increasing batch size speeds up time to convergence

chart = RuntimeError: Failed to fetch

Note: We report batch size in number of contiguous chunks of transitions used in backpropagation through time, each of which contains 10 transitions, meaning that a reported batch size of 64k actually contains 640k transitions.

## Multi-agent competition vs. intrinsic motivation

In this work we show evidence that agents learn complex strategies and counterstrategies through a self-supervised autocurriculum in hide-and-seek. Another method to learn skills in an unsupervised manner is _intrinsic motivation_, which incentivizes agents to explore with various metrics such as model error or state counts. We ran count-based exploration in our environment, in which agents keep an explicit count of states they’ve visited and are incentivized to go to infrequently visited states. The primary modeling choice to tune in this setting is the state representation; for instance, in our first baseline we only include 2-D box positions in the state, such that agents are only incentivized to interact with and move boxes to novel positions. We then compare this to a count-based policy which takes the full state given to the agents that play hide-and-seek.

**Multi-agent**

**Count-based exploration** with selected observations

**Count-based exploration** with full observations

As can be seen, agents trained in hide-and-seek qualitatively center around far more human interpretable behaviors such as shelter construction, whereas agents trained with intrinsic motivation move objects around in a seemingly undirected fashion. Furthermore, as the state space increases in complexity, we find that intrinsic motivation methods have less and less meaningful interactions with the objects in their environment. For this reason, we believe multi-agent competition will be a more scalable method for generating human-relevant skills in an unsupervised manner as environments continue to increase in size and complexity.

## Transfer and fine-tuning as evaluation

In the previous section, we qualitatively compare behaviors learned in hide-and-seek to those learned with intrinsic motivation. However, as environments increase in scale, so will the difficulty in qualitatively measuring progress. Tracking reward is an insufficient evaluation metric in multi-agent settings, as it can be ambiguous in indicating whether agents are improving evenly or have stagnated. Metrics like ELO or Trueskill can more reliably measure whether performance is improving relative to previous policy versions or other policies in a population; however, these metrics still do not give insight into whether improved performance is caused by new adaptations or improving previously learned skills. Finally, using environment-specific statistics such as object movement can also be ambiguous (for example, the choice to track absolute movement does not illuminate which direction agents moved), and designing sufficient metrics will become difficult and costly as environments scale.

We propose using a suite of domain-specific intelligence tests that target capabilities we believe agents may eventually acquire. Transfer performance in these settings can act as a quantitative measure of representation quality or skill, and we compare against pretraining with count-based exploration as well as a trained from scratch baseline.

**Object counting** The agent is pinned in place and asked to predict how many objects have gone right or left, testing the agent's memory and sense of object permanence.

chart = RuntimeError: Failed to fetch

**Lock and return** The agent must find the box, lock it, and return to its original position, which tests the agent’s long term memory of its location.

chart = RuntimeError: Failed to fetch

**Sequential lock** The agent must lock boxes in an order unobserved to the agent. Boxes can only be locked in the correct order, so the agent must remember the status of boxes it has seen.

chart = RuntimeError: Failed to fetch

**Blueprint construction** The agent must move boxes to the target locations.

chart = RuntimeError: Failed to fetch

**Shelter construction** The agent must construct a shelter around the cylinder.

chart = RuntimeError: Failed to fetch

Though the hide-and-seek agent performs better on many of the transfer tasks, it does not drastically improve performance or convergence time. From viewing its behavior, we know it has the latent skill to move objects in a precise manner to construct shelter in the hide-and-seek game; however, it does not have the capability to use this skill in other contexts when trained with a low number of samples.

We believe the cause for the mixed transfer results is rooted in agents learning skill representations that are entangled and difficult to fine-tune. As future environments become more diverse and agents must use skills in more contexts, we believe we will see more generalizable skill representations and more significant signal in this evaluation approach. We additionally open-source the evaluation tasks as a way to evaluate learning progress in our environment.

## Surprising behaviors

We’ve shown that agents can learn sophisticated tool use in a high fidelity physics simulator; however, there were many lessons learned along the way to this result. Building environments is not easy and it is quite often the case that agents find a way to exploit the environment you build or the physics engine in an unintended way.

**Box surfing** Since agents move by applying forces to themselves, they can grab a box while on top of it and “surf” it to the hider’s location.

**Endless running** Without adding explicit negative rewards for agents leaving the play area, in rare cases hiders will learn to take a box and endlessly run with it.

**Ramp exploitation (hiders)** Reinforcement learning is amazing at finding small mechanics to exploit. In this case, hiders abuse the contact physics and remove ramps from the play area.

**Ramp exploitation (seekers)** In this case, seekers learn that if they run at a wall with a ramp at the right angle, they can launch themselves upward.

- [OpenAI Five](https://openai.com/research/index/?tags=openai-five)
- [Dactyl](https://openai.com/research/index/?tags=dactyl)
- [Exploration & Games](https://openai.com/research/index/?tags=exploration-game)
- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)
- [Multi-agent](https://openai.com/research/index/?tags=multi-agent)
- [Robotics](https://openai.com/research/index/?tags=robotics)
- [Simulated Environments](https://openai.com/research/index/?tags=simulated-environments)
{% endraw %}
