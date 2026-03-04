---
title: "Evolution through large models | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/evolution-through-large-models"
date: "2022-06-17"
scraped_at: "2026-03-02T10:25:37.455177120+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---
&#123;% raw %}

June 17, 2022


# Evolution through large models

[Read paper(opens in a new window)](https://arxiv.org/abs/2206.08896)

![Evolution Through Large Models](images/evolution-through-large-models-openai/img_001.webp)



## Abstract

This paper pursues the insight that large language models (LLMs) trained to generate code can vastly improve the effectiveness of mutation operators applied to programs in genetic programming (GP). Because such LLMs benefit from training data that includes sequential changes and modifications, they can approximate likely changes that humans would make. To highlight the breadth of implications of such evolution through large models (ELM), in the main experiment ELM combined with MAP-Elites generates hundreds of thousands of functional examples of Python programs that output working ambulating robots in the Sodarace domain, which the original LLM had never seen in pre-training. These examples then help to bootstrap training a new conditional language model that can output the right walker for a particular terrain. The ability to bootstrap new models that can output appropriate artifacts for a given context in a domain where zero training data was previously available carries implications for open-endedness, deep learning, and reinforcement learning. These implications are explored here in depth in the hope of inspiring new directions of research now opened up by ELM.

- [GPT](https://openai.com/research/index/?tags=gpt)
- [Language](https://openai.com/research/index/?tags=language)
- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)
- [Exploration & Games](https://openai.com/research/index/?tags=exploration-game)
- [Multi-agent](https://openai.com/research/index/?tags=multi-agent)
- [Simulated Environments](https://openai.com/research/index/?tags=simulated-environments)
- [Robotics](https://openai.com/research/index/?tags=robotics)
&#123;% endraw %}
