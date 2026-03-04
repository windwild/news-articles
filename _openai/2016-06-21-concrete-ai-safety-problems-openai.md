---
title: "Concrete AI safety problems | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/concrete-ai-safety-problems"
date: "2016-06-21"
scraped_at: "2026-03-02T10:34:50.654296500+00:00"
language: "en-US"
translated: false
description: "We (along with researchers from Berkeley and Stanford) are co-authors on today’s paper led by Google Brain researchers, Concrete Problems in AI Safety. The paper explores many research problems aro..."
tags: ["Safety & Alignment"]
---
&#123;% raw %}

June 21, 2016


# Concrete AI safety problems

[Read Paper(opens in a new window)](https://arxiv.org/abs/1606.06565)

![Concrete AI Safety Problems](images/concrete-ai-safety-problems-openai/img_001.png)



We (along with researchers from Berkeley and Stanford) are co-authors on today’s paper led by Google Brain researchers, [Concrete Problems in AI Safety⁠(opens in a new window)](https://arxiv.org/abs/1606.06565). The paper explores many research problems around ensuring that modern machine learning systems operate as intended.

We (along with researchers from Berkeley and Stanford) are co-authors on today’s paper led by Google Brain researchers, [Concrete Problems in AI Safety⁠(opens in a new window)](https://arxiv.org/abs/1606.06565). The paper explores many research problems around ensuring that modern machine learning systems operate as intended. (The problems are very practical, and we’ve already seen some being integrated into [OpenAI Gym⁠(opens in a new window)](https://gym.openai.com/envs#safety).)

Advancing AI requires making AI systems smarter, but it also requires preventing accidents—that is, ensuring that AI systems do what people actually want them to do. There’s been an increasing focus on [safety research⁠(opens in a new window)](http://futureoflife.org/background/benefits-risks-of-artificial-intelligence/) from the machine learning community, such as a recent [paper⁠(opens in a new window)](https://intelligence.org/files/Interruptibility.pdf) from [DeepMind⁠(opens in a new window)](https://deepmind.com/) and [FHI⁠(opens in a new window)](https://www.fhi.ox.ac.uk/). Still, many machine learning researchers have wondered just how much safety research can be done today.

The authors discuss five areas:

- **Safe exploration**. _Can_ [_reinforcement learning_ ⁠(opens in a new window)](http://karpathy.github.io/2016/05/31/rl/) _(RL) agents learn about their environment without executing catastrophic actions?_ For example, can an RL agent learn to navigate an environment without ever falling off a ledge?
- **Robustness to distributional shift**. _Can machine learning systems be robust to changes in the data distribution, or at least fail gracefully?_ For example, can we build [image classifiers⁠(opens in a new window)](https://www.tensorflow.org/versions/r0.9/tutorials/deep_cnn/index.html) that indicate appropriate uncertainty when shown new kinds of images, instead of confidently trying to use its [potentially inapplicable⁠(opens in a new window)](http://arxiv.org/abs/1412.6572) learned model?
- **Avoiding negative side effects**. _Can we transform an RL agent’s_ [_reward function_ ⁠(opens in a new window)](https://webdocs.cs.ualberta.ca/~sutton/book/ebook/node9.html) _to avoid undesired effects on the environment?_ For example, can we build a robot that will move an object while avoiding knocking anything over or breaking anything, without manually programming a separate penalty for each possible bad behavior?
- **Avoiding “reward hacking” and “** [**wireheading** ⁠(opens in a new window)](http://www.agroparistech.fr/mmip/maths/laurent_orseau/papers/ring-orseau-AGI-2011-delusion.pdf) **”**. _Can we prevent agents from “gaming” their reward functions, such as by distorting their observations?_ For example, can we train an RL agent to minimize the number of dirty surfaces in a building, without causing it to avoid looking for dirty surfaces or to create new dirty surfaces to clean up?
- **Scalable oversight**. _Can RL agents efficiently achieve goals for which feedback is very expensive?_ For example, can we build an agent that tries to clean a room in the way the user would be happiest with, even though feedback from the user is very rare and we have to use cheap approximations (like the presence of visible dirt) during training? The divergence between cheap approximations and what we actually care about is an important source of accident risk.

Many of the problems are not new, but the paper explores them in the context of cutting-edge systems. We hope they’ll inspire more people to work on AI safety research, whether [at OpenAI⁠](https://openai.com/careers/) or elsewhere.

We’re particularly excited to have participated in this paper as a cross-institutional collaboration. We think that broad AI safety collaborations will enable everyone to build better machine learning systems. [Let us know⁠(opens in a new window)](https://gitter.im/openai/research) if you have a future paper you’d like to collaborate on!

- [Ethics & Safety](https://openai.com/research/index/?tags=ethics-safety)
&#123;% endraw %}
