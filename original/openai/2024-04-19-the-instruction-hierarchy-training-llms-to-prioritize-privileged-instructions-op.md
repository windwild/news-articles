---
title: "The Instruction Hierarchy: Training LLMs to Prioritize Privileged Instructions | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/the-instruction-hierarchy"
date: "2024-04-19"
scraped_at: "2026-03-02T10:19:50.684074793+00:00"
language: "en-US"
translated: false
description: "Today's LLMs are susceptible to prompt injections, jailbreaks, and other attacks that allow adversaries to overwrite a model's original instructions with their own malicious prompts."
tags: ["Research"]
---

April 19, 2024


# The Instruction Hierarchy: Training LLMs to Prioritize Privileged Instructions

[Read paper(opens in a new window)](https://arxiv.org/abs/2404.13208)

![An abstract image with soft, flowing brushstrokes in warm beige, light brown, and pale blue. The smooth blending of colors creates a calming, fluid composition, evoking a sense of movement and serenity.](images/the-instruction-hierarchy-training-llms-to-prioritize-privileged-instructions-op/img_001.png)


## Abstract

Today's LLMs are susceptible to prompt injections, jailbreaks, and other attacks that allow adversaries to overwrite a model's original instructions with their own malicious prompts. In this work, we argue that one of the primary vulnerabilities underlying these attacks is that LLMs often consider system prompts (e.g., text from an application developer) to be the same priority as text from untrusted users and third parties. To address this, we propose an instruction hierarchy that explicitly defines how models should behave when instructions of different priorities conflict. We then propose a data generation method to demonstrate this hierarchical instruction following behavior, which teaches LLMs to selectively ignore lower-privileged instructions. We apply this method to GPT‑3.5, showing that it drastically increases robustness -- even for attack types not seen during training -- while imposing minimal degradations on standard capabilities.

- [GPT](https://openai.com/research/index/?tags=gpt)
- [Language](https://openai.com/research/index/?tags=language)
- [Reasonings & Policy](https://openai.com/research/index/?tags=reasoning-policy)
- [Ethics & Safety](https://openai.com/research/index/?tags=ethics-safety)