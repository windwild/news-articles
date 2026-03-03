---
title: "Point-E: A system for generating 3D point clouds from complex prompts | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/point-e"
date: "2022-12-16"
scraped_at: "2026-03-02T10:24:26.640203815+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---

December 16, 2022


# Point-E: A system for generating 3D point clouds from complex prompts

[Read paper(opens in a new window)](https://arxiv.org/abs/2212.08751) [View code(opens in a new window)](https://github.com/openai/point-e) [View model card(opens in a new window)](https://github.com/openai/point-e/blob/main/model-card.md)

![Point E A System For Generating 3d Point Clouds From Complex Prompts](images/point-e-a-system-for-generating-3d-point-clouds-from-complex-prompts-openai/img_001.webp)



## Abstract

While recent work on text-conditional 3D object generation has shown promising results, the state-of-the-art methods typically require multiple GPU-hours to produce a single sample. This is in stark contrast to state-of-the-art generative image models, which produce samples in a number of seconds or minutes. In this paper, we explore an alternative method for 3D object generation which produces 3D models in only 1-2 minutes on a single GPU. Our method first generates a single synthetic view using a text-to-image diffusion model, and then produces a 3D point cloud using a second diffusion model which conditions on the generated image. While our method still falls short of the state-of-the-art in terms of sample quality, it is one to two orders of magnitude faster to sample from, offering a practical trade-off for some use cases. We release our pre-trained point cloud diffusion models, as well as evaluation code and models, at [this https URL⁠(opens in a new window)](https://github.com/openai/point-e).

- [Point-E](https://openai.com/research/index/?tags=point-e)
- [Generative Models](https://openai.com/research/index/?tags=generative-models)
- [Software & Engineering](https://openai.com/research/index/?tags=software-engineering)