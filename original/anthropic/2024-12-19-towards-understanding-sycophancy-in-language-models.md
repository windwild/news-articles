---
title: "Towards Understanding Sycophancy in Language Models"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/towards-understanding-sycophancy-in-language-models"
date: "2024-12-19"
scraped_at: "2026-03-03T06:47:51.797514355+00:00"
language: "en"
translated: false
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---

AlignmentResearch

# Towards Understanding Sycophancy in Language Models

Oct 23, 2023

[Read Paper](https://arxiv.org/abs/2310.13548)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.


## Abstract

Reinforcement learning from human feedback (RLHF) is a popular technique for training high-quality AI assistants. However, RLHF may also encourage model responses that match user beliefs over truthful responses, a behavior known as sycophancy. We investigate the prevalence of sycophancy in RLHF-trained models and whether human preference judgments are responsible. We first demonstrate that five state-of-the-art AI assistants consistently exhibit sycophancy behavior across four varied free-form text-generation tasks. To understand if human preferences drive this broadly observed behavior of RLHF models, we analyze existing human preference data. We find that when a response matches a user’s views, it is more likely to be preferred. Moreover, both humans and preference models (PMs) prefer convincingly-written sycophantic responses over correct ones a non-negligible fraction of the time. Optimizing model outputs against PMs also sometimes sacrifices truthfulness in favor of sycophancy. Overall, our results indicate that sycophancy is a general behavior of RLHF models, likely driven in part by human preference judgments favoring sycophantic responses.