---
title: "Variational option discovery algorithms | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/variational-option-discovery-algorithms"
date: "2018-07-26"
scraped_at: "2026-03-02T10:29:42.289134427+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---
&#123;% raw %}

July 26, 2018


# Variational option discovery algorithms

[Read paper(opens in a new window)](https://arxiv.org/abs/1807.10299)

![Variational Option Discovery Algorithms](images/variational-option-discovery-algorithms-openai/img_001.webp)



## Abstract

We explore methods for option discovery based on variational inference and make two algorithmic contributions. First: we highlight a tight connection between variational option discovery methods and variational autoencoders, and introduce Variational Autoencoding Learning of Options by Reinforcement (VALOR), a new method derived from the connection. In VALOR, the policy encodes contexts from a noise distribution into trajectories, and the decoder recovers the contexts from the complete trajectories. Second: we propose a curriculum learning approach where the number of contexts seen by the agent increases whenever the agent's performance is strong enough (as measured by the decoder) on the current set of contexts. We show that this simple trick stabilizes training for VALOR and prior variational option discovery methods, allowing a single agent to learn many more modes of behavior than it could with a fixed context distribution. Finally, we investigate other topics related to variational option discovery, including fundamental limitations of the general approach and the applicability of learned options to downstream tasks.

- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)
&#123;% endraw %}
