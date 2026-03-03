---
title: "Softmax Linear Units \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/softmax-linear-units"
date: "2024-12-19"
scraped_at: "2026-03-03T06:55:56.363508082+00:00"
language: "en"
translated: false
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---

InterpretabilityResearch

# Softmax Linear Units

Jun 17, 2022

[Read Paper](https://transformer-circuits.pub/2022/solu/index.html)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.


## Abstract

In this paper, we report an architectural change which appears to substantially increase the fraction of MLP neurons which appear to be "interpretable" (i.e. respond to an articulable property of the input), at little to no cost to ML performance. Specifically, we replace the activation function with a softmax linear unit (which we term SoLU) and show that this significantly increases the fraction of neurons in the MLP layers which seem to correspond to readily human-understandable concepts, phrases, or categories on quick investigation, as measured by randomized and blinded experiments. We then study our SoLU models and use them to gain several new insights about how information is processed in transformers. However, we also discover some evidence that the superposition hypothesis is true and there is no free lunch: SoLU may be making some features more interpretable by “hiding” others and thus making them even more deeply uninterpretable. Despite this, SoLU still seems like a net win, as in practical terms it substantially increases the fraction of neurons we are able to understand.