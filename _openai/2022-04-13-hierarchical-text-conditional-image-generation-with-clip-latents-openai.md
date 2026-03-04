---
render_with_liquid: false
title: "Hierarchical text-conditional image generation with CLIP latents | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/hierarchical-text-conditional-image-generation-with-clip-latents"
date: "2022-04-13"
scraped_at: "2026-03-02T10:26:03.028256319+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---

April 13, 2022


# Hierarchical text-conditional image generation with CLIP latents

[Read paper(opens in a new window)](https://arxiv.org/abs/2204.06125)

![Hierarchical Text Conditional Image Generation With Clip Latents](images/hierarchical-text-conditional-image-generation-with-clip-latents-openai/img_001.jpg)



## Abstract

Contrastive models like CLIP have been shown to learn robust representations of images that capture both semantics and style. To leverage these representations for image generation, we propose a two-stage model: a prior that generates a CLIP image embedding given a text caption, and a decoder that generates an image conditioned on the image embedding. We show that explicitly generating image representations improves image diversity with minimal loss in photorealism and caption similarity. Our decoders conditioned on image representations can also produce variations of an image that preserve both its semantics and style, while varying the non-essential details absent from the image representation. Moreover, the joint embedding space of CLIP enables language-guided image manipulations in a zero-shot fashion. We use diffusion models for the decoder and experiment with both autoregressive and diffusion models for the prior, finding that the latter are computationally more efficient and produce higher-quality samples.

- [CLIP](https://openai.com/research/index/?tags=technology-clip)
- [Generative Models](https://openai.com/research/index/?tags=generative-models)
- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)