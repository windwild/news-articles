---
title: "A General Language Assistant as a Laboratory for Alignment"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/a-general-language-assistant-as-a-laboratory-for-alignment"
date: "2024-12-19"
scraped_at: "2026-03-03T07:06:30.074729618+00:00"
language: "en"
translated: false
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---

AlignmentResearch

# A General Language Assistant as a Laboratory for Alignment

Dec 1, 2021

[Read Paper](https://arxiv.org/abs/2112.00861)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.


## Abstract

Given the broad capabilities of large language models, it should be possible to work towards a general-purpose, text-based assistant that is aligned with human values, meaning that it is helpful, honest, and harmless. As an initial foray in this direction we study simple baseline techniques and evaluations, such as prompting. We find that the benefits from modest interventions increase with model size, generalize to a variety of alignment evaluations, and do not compromise the performance of large models. Next we investigate scaling trends for several training objectives relevant to alignment, comparing imitation learning, binary discrimination, and ranked preference modeling. We find that ranked preference modeling performs much better than imitation learning, and often scales more favorably with model size. In contrast, binary discrimination typically performs and scales very similarly to imitation learning. Finally we study a \`preference model pre-training' stage of training, with the goal of improving sample efficiency when finetuning on human preferences.