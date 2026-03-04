---
title: "Simplifying, stabilizing, and scaling continuous-time consistency models | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/simplifying-stabilizing-and-scaling-continuous-time-consistency-models"
date: "2024-10-23"
scraped_at: "2026-03-02T10:16:33.233404991+00:00"
language: "en-US"
translated: false
description: "We’ve simplified, stabilized, and scaled continuous-time consistency models, achieving comparable sample quality to leading diffusion models, while using only two sampling steps."
tags: ["Research"]
---
{% raw %}

October 23, 2024


# Simplifying, stabilizing, and scaling continuous-time consistency models

Continuous-time consistency models with sample quality comparable to leading diffusion models in just two sampling steps.

[Read paper(opens in a new window)](https://arxiv.org/abs/2410.11081)



Diffusion models have revolutionized generative AI, enabling remarkable advances in generating realistic images, 3D models, audio, and video. However, despite their impressive results, these models are slow at sampling.

We are sharing a new approach, called sCM, which simplifies the theoretical formulation of continuous-time consistency models, allowing us to stabilize and scale their training for large scale datasets. This approach achieves comparable sample quality to leading diffusion models, while using only two sampling steps. We are also sharing our [research paper⁠(opens in a new window)](https://arxiv.org/abs/2410.11081) to support further progress in this field.

Your browser does not support the video tag.

00:00

Sampling procedure of consistency models. Sampling time measured on a single A100 GPU with batch size = 1.

Your browser does not support the video tag.

00:00

Sampling procedure of diffusion models. Sampling time measured on a single A100 GPU with batch size = 1.

## Introduction

Current sampling approaches of diffusion models often require dozens to hundreds of sequential steps to generate a single sample, which limits their efficiency and scalability for real-time applications. Various distillation techniques have been developed to accelerate sampling, but they often come with limitations, such as high computational costs, complex training, and reduced sample quality.

Extending our previous research on consistency models [1](https://openai.com/index/simplifying-stabilizing-and-scaling-continuous-time-consistency-models/#citation-bottom-1),[2](https://openai.com/index/simplifying-stabilizing-and-scaling-continuous-time-consistency-models/#citation-bottom-2), we have simplified the formulation and further stabilized the training process of continuous-time consistency models. Our new approach, called sCM, has enabled us to scale the training of continuous-time consistency models to an unprecedented 1.5 billion parameters on ImageNet at 512×512 resolution. sCMs can generate samples with quality comparable to diffusion models using only two sampling steps, resulting in a ~50x wall-clock speedup. For example, our largest model, with 1.5 billion parameters, generates a single sample in just 0.11 seconds on a single A100 GPU without any inference optimization. Additional acceleration is easily achievable through customized system optimization, opening up possibilities for real-time generation in various domains such as image, audio, and video.

For rigorous evaluation, we benchmarked sCM against other state-of-the-art generative models by comparing both sample quality, using the standard Fréchet Inception Distance (FID) scores (where lower is better), and effective sampling compute, which estimates the total compute cost for generating each sample. As shown below, our 2-step sCM produces samples with quality comparable to the best previous methods while using less than 10% of the effective sampling compute, significantly accelerating the sampling process.

![Scatter plot comparing Frechet Inception Distance (lower is better) and Effective Sampling Compute for various models. Notable models include sCM (ours), BigGAN, StyleGAN-XL, ADM-G, U-ViT-H/4, MaskGIT, and DiT-XL/2.](images/simplifying-stabilizing-and-scaling-continuous-time-consistency-models-openai/img_001.svg)

## How it works

Consistency models offer a faster alternative to traditional diffusion models for generating high-quality samples. Unlike diffusion models, which generate samples gradually through a large number of denoising steps, consistency models aim to convert noise directly into noise-free samples in a single step. This difference is visualized by paths in the diagram: the blue line represents the gradual sampling process of a diffusion model, while the red curve illustrates the more direct, accelerated sampling of a consistency model. Using techniques like consistency training or consistency distillation [1](https://openai.com/index/simplifying-stabilizing-and-scaling-continuous-time-consistency-models/#citation-bottom-1),[2](https://openai.com/index/simplifying-stabilizing-and-scaling-continuous-time-consistency-models/#citation-bottom-2), consistency models can be trained to generate high-quality samples with significantly fewer steps, making them appealing for practical applications that require fast generation.

![Diagram illustrating ODE trajectories between data and noise, showing points connected by curved and straight paths labeled  𝑥 0 x  0 ​  ,  𝑥 𝜃 x  θ ​  ,  𝑥 𝑡 − Δ 𝑡 x  t−Δt ​  , and  𝑥 𝑡 x  t ​  , with mathematical notations.](images/simplifying-stabilizing-and-scaling-continuous-time-consistency-models-openai/img_002.svg)

Illustration on diffusion model sampling (red) and consistency model sampling (blue).

We've trained a continuous-time consistency model with 1.5B parameters on ImageNet 512x512, and provided two-step samples from this model to demonstrate its capabilities.

![Consistency Model > Media carousel > Gallery > Image 54 > Asset](images/simplifying-stabilizing-and-scaling-continuous-time-consistency-models-openai/img_003.png)

![Consistency Model > Media carousel > Gallery > Image 89 > Asset ](images/simplifying-stabilizing-and-scaling-continuous-time-consistency-models-openai/img_004.png)

![Jellyfish floating underwater with long, thin tentacles and a transparent, circular body.](images/simplifying-stabilizing-and-scaling-continuous-time-consistency-models-openai/img_005.png)

![Underwater view of a bright, white sea anemone with tentacles spread out.](images/simplifying-stabilizing-and-scaling-continuous-time-consistency-models-openai/img_006.png)

![A conch shell on wet sand with a striped pattern.](images/simplifying-stabilizing-and-scaling-continuous-time-consistency-models-openai/img_007.png)

![ A snail on a green leaf, with a spiral-patterned shell.](images/simplifying-stabilizing-and-scaling-continuous-time-consistency-models-openai/img_008.png)

![A hermit crab with a red body, emerging from a shell on wet sand.](images/simplifying-stabilizing-and-scaling-continuous-time-consistency-models-openai/img_009.png)

![A white wolf resting on a rock, looking alert.](images/simplifying-stabilizing-and-scaling-continuous-time-consistency-models-openai/img_010.png)

![Close-up of a snow leopard’s face with spotted fur.](images/simplifying-stabilizing-and-scaling-continuous-time-consistency-models-openai/img_011.png)

![Close-up of a lion’s face with a thick mane.](images/simplifying-stabilizing-and-scaling-continuous-time-consistency-models-openai/img_012.png)

![A black beetle crawling on the ground.](images/simplifying-stabilizing-and-scaling-continuous-time-consistency-models-openai/img_013.png)

![A yellow and black beetle with long antennae on a green leaf.](images/simplifying-stabilizing-and-scaling-continuous-time-consistency-models-openai/img_014.png)

![A monarch butterfly with bright orange and black wings on a green plant.](images/simplifying-stabilizing-and-scaling-continuous-time-consistency-models-openai/img_015.png)

![A lionfish with long, spiky fins swimming near a coral reef.](images/simplifying-stabilizing-and-scaling-continuous-time-consistency-models-openai/img_016.png)

![A car’s side mirror reflecting a countryside view with hills and trees.](images/simplifying-stabilizing-and-scaling-continuous-time-consistency-models-openai/img_017.png)

![A large, ancient stone structure composed of stacked rocks in a grassy landscape.](images/simplifying-stabilizing-and-scaling-continuous-time-consistency-models-openai/img_018.png)

![A ceramic teapot and two small cups on a wooden table.](images/simplifying-stabilizing-and-scaling-continuous-time-consistency-models-openai/img_019.png)

![Close-up of a cheeseburger with melted cheese and a soft bun.](images/simplifying-stabilizing-and-scaling-continuous-time-consistency-models-openai/img_020.png)

![A scenic view of snow-capped mountains with lush green meadows and pine trees.](images/simplifying-stabilizing-and-scaling-continuous-time-consistency-models-openai/img_021.png)

![Aerial view of a coastal bay with turquoise water surrounded by cliffs.](images/simplifying-stabilizing-and-scaling-continuous-time-consistency-models-openai/img_022.png)

![A fast-flowing turquoise river cutting through rocky hills with dense green vegetation.](images/simplifying-stabilizing-and-scaling-continuous-time-consistency-models-openai/img_023.png)

Our sCM distills knowledge from a pre-trained diffusion model. A key finding is that sCMs improve proportionally with the teacher diffusion model as both scale up. Specifically, the relative difference in sample quality, measured by the ratio of FID scores, remains consistent across several orders of magnitude in model sizes, causing the absolute difference in sample quality to diminish at scale. Additionally, increasing the sampling steps for sCMs further reduces the quality gap. Notably, two-step samples from sCMs are already comparable (with less than a 10% relative difference in FID scores) to samples from the teacher diffusion model, which requires hundreds of steps to generate.

![Line graph comparing FID against single forward flops for three methods: 1-step SCM (red), 2-step SCM (blue), and Diffusion (orange), across model sizes (S, M, L, XL, XXL). All lines show decreasing FID as flops increase, with Diffusion performing best.](images/simplifying-stabilizing-and-scaling-continuous-time-consistency-models-openai/img_024.svg)

sCM scales commensurately with teacher diffusion models.

## Limitations

The best sCMs still rely on pre-trained diffusion models for initialization and distillation, resulting in a small but consistent gap in sample quality compared to the teacher diffusion model. Additionally, FID as a metric for sample quality has its own limitations; being close in FID scores does not always reflect actual sample quality, and vice versa. Therefore, the quality of sCMs may need to be assessed differently depending on the requirements of specific applications.

## What's next

We will continue to work toward developing better generative models with both improved inference speed and sample quality. We believe these advancements will unlock new possibilities for real-time, high-quality generative AI across a wide range of domains.

- [Glow](https://openai.com/research/index/?tags=glow)
- [Generative Models](https://openai.com/research/index/?tags=generative-models)
- [Software & Engineering](https://openai.com/research/index/?tags=software-engineering)
- [Simulated Environments](https://openai.com/research/index/?tags=simulated-environments)
{% endraw %}
