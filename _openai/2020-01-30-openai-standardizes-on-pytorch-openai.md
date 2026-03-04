---
title: "OpenAI standardizes on PyTorch | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/openai-pytorch"
date: "2020-01-30"
scraped_at: "2026-03-02T10:27:21.851112404+00:00"
language: "en-US"
translated: false
description: "We are standardizing OpenAI’s deep learning framework on PyTorch."
tags: ["Company"]
---
&#123;% raw %}

January 30, 2020


# OpenAI standardizes on PyTorch

We are standardizing OpenAI’s deep learning framework on PyTorch.

![A softly textured landscape painting showing a wide field of pink and yellow hues under a pale blue sky with light purple and rose-colored clouds.](images/openai-standardizes-on-pytorch-openai/img_001.jpg)



We are standardizing OpenAI’s deep learning framework on [PyTorch⁠(opens in a new window)](https://pytorch.org/). In the past, we implemented projects in many frameworks depending on their relative strengths. We’ve now chosen to standardize to make it easier for our team to create and share optimized implementations of our models.

As part of this move, we’ve just released a [PyTorch-enabled version⁠(opens in a new window)](https://github.com/openai/spinningup) of [Spinning Up in Deep RL⁠](https://openai.com/index/spinning-up-in-deep-rl/), an open-source educational resource produced by OpenAI that makes it easier to learn about deep reinforcement learning. We are also in the process of writing PyTorch bindings for our highly-optimized [blocksparse kernels⁠](https://openai.com/index/block-sparse-gpu-kernels/), and will open-source those bindings in upcoming months.

The main reason we’ve chosen PyTorch is to increase our research productivity at scale on GPUs. It is very easy to try and execute new research ideas in PyTorch; for example, switching to PyTorch decreased our iteration time on research ideas in generative modeling from weeks to days. We’re also excited to be joining a rapidly-growing developer community, including organizations like Facebook and Microsoft, in pushing scale and performance on GPUs.

Going forward we’ll primarily use PyTorch as our deep learning framework but sometimes use other ones when there’s a specific technical reason to do so. Many of our teams have already made the switch, and we look forward to contributing to the PyTorch community in upcoming months.

- [Framework](https://openai.com/news/?tags=framework)
- [2020](https://openai.com/news/?tags=2020)
&#123;% endraw %}
