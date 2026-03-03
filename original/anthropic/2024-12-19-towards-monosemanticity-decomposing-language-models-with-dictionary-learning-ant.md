---
title: "Towards Monosemanticity: Decomposing Language Models With Dictionary Learning \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/towards-monosemanticity-decomposing-language-models-with-dictionary-learning"
date: "2024-12-19"
scraped_at: "2026-03-03T06:48:05.217342627+00:00"
language: "en"
translated: false
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---

InterpretabilityResearch

# Towards Monosemanticity: Decomposing Language Models With Dictionary Learning

Oct 5, 2023

[Read Paper](https://transformer-circuits.pub/2023/monosemantic-features/index.html)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.


## Abstract

In our latest paper, [_Towards Monosemanticity: Decomposing Language Models With Dictionary Learning_](https://transformer-circuits.pub/2023/monosemantic-features), we outline evidence that there are better units of analysis than individual neurons, and we have built machinery that lets us find these units in small transformer models. These units, called features, correspond to patterns (linear combinations) of neuron activations. This provides a path to breaking down complex neural networks into parts we can understand, and builds on previous efforts to interpret high-dimensional systems in neuroscience, machine learning, and statistics. In a transformer language model, we decompose a layer with 512 neurons into more than 4000 features which separately represent things like DNA sequences, legal language, HTTP requests, Hebrew text, nutrition statements, and much, much more. Most of these model properties are invisible when looking at the activations of individual neurons in isolation.