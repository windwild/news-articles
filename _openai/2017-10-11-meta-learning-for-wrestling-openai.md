---
title: "Meta-learning for wrestling | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/meta-learning-for-wrestling"
date: "2017-10-11"
scraped_at: "2026-03-02T10:32:08.718109645+00:00"
language: "en-US"
translated: false
description: "We show that for the task of simulated robot wrestling, a meta-learning agent can learn to quickly defeat a stronger non-meta-learning agent, and also show that the meta-learning agent can adapt to ph..."
tags: ["Research"]
---
&#123;% raw %}

October 11, 2017


# Meta-learning for wrestling

[View code(opens in a new window)](https://github.com/openai/robosumo) [Read paper(opens in a new window)](https://arxiv.org/abs/1710.03641)

![Two spidery 3D renders wrestling on a stage](images/meta-learning-for-wrestling-openai/img_001.jpg)



We show that for the task of simulated robot wrestling, a meta-learning agent can learn to quickly defeat a stronger non-meta-learning agent, and also show that the meta-learning agent can adapt to physical malfunction.

We’ve extended the [Model-Agnostic Meta-Learning (MAML)⁠(opens in a new window)](https://arxiv.org/abs/1703.03400) algorithm by basing its objective function on optimizing against pairs of environments, rather than single ones as in stock MAML. MAML initializes the policies of our agents so that after only a small number of parameter updates during execution on a new environment (or task) the agents learn to do better in that environment. The policy parameter updates at execution are done via gradient ascent steps on the reward collected during the few episodes of initial interaction with a new environment. By training on pairs we’re able to create policies that quickly adapt to previously unseen environments, as long as the environment doesn’t diverge too wildly from previous ones.

To test our continuous adaptation approach we designed 3 types of agents—Ant (4-leg), Bug (6-leg), and Spider (8-leg)—and set up a multi-round game where each agent played several matches against the same opponent and adapted its policy parameters between the rounds to better counter the opponent’s policy. In tests, we found that agents that could adapt their tactics are much better competitors than agents that have fixed policies. After training over a hundred agents, some of which learned fixed policies and others learned to adapt, we evaluated the fitness of each agent.

Learning on the fly can also let agents deal with unusual changes in their own bodies as well, like adapting to some of their own limbs losing functionality over time. This suggests we can use techniques like this to develop agents that can handle both changes in their external environment and also changes in their own bodies or internal states.

We’re exploring meta-learning as part of our work on large-scale multi-agent research. Additionally, we’re [releasing the MuJoCo environments and trained policies⁠(opens in a new window)](https://github.com/openai/robosumo) used in this work so that others can experiment with these systems.

- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)
- [Multi-agent](https://openai.com/research/index/?tags=multi-agent)
- [Exploration & Games](https://openai.com/research/index/?tags=exploration-game)
- [Simulated Environments](https://openai.com/research/index/?tags=simulated-environments)
&#123;% endraw %}
