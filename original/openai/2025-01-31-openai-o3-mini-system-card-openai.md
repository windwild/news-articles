---
title: "OpenAI o3-mini System Card | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/o3-mini-system-card"
date: "2025-01-31"
scraped_at: "2026-03-02T10:15:18.101702407+00:00"
language: "en-US"
translated: false
description: "This report outlines the safety work carried out for the OpenAI o3-mini model, including safety evaluations, external red teaming, and Preparedness Framework evaluations."
tags: ["Research"]
---

January 31, 2025


# OpenAI o3‑mini System Card

[Read the System Card(opens in a new window)](https://cdn.openai.com/o3-mini-system-card-feb10.pdf) [Contributions](https://openai.com/index/openai-o3-mini/)



## OpenAI o3-mini System Card

Specific areas of risk

- Disallowed content

- Jailbreaks

- Hallucinations


Preparedness Scorecard

- CBRN


Medium

- Cybersecurity


Low

- Persuasion


Medium

- Model Autonomy


Medium


## Scorecard ratings

- Low
- Medium
- High
- Critical

Only models with a post-mitigation score of "medium" or below can be deployed.

Only models with a post-mitigation score of "high" or below can be developed further.

## Introduction

The OpenAI o model series is trained with large-scale reinforcement learning to reason using chain of thought. These advanced reasoning capabilities provide new avenues for improving the safety and robustness of our models. In particular, our models can reason about our safety policies in context when responding to potentially unsafe prompts, through deliberative alignment. This brings OpenAI o3‑mini to parity with state-of-the-art performance on certain benchmarks for risks such as generating illicit advice, choosing stereotyped responses, and succumbing to known jailbreaks. Training models to incorporate a chain of thought before answering has the potential to unlock substantial benefits, while also increasing potential risks that stem from heightened intelligence.

Under the [Preparedness Framework⁠(opens in a new window)](https://cdn.openai.com/openai-preparedness-framework-beta.pdf), OpenAI’s Safety Advisory Group (SAG) recommended classifying the OpenAI o3‑mini (Pre-Mitigation) model as Medium risk overall. It scores Medium risk for Persuasion, CBRN (chemical, biological, radiological, nuclear), and Model Autonomy, and Low risk for Cybersecurity. Only models with a post-mitigation score of Medium or below can be deployed, and only models with a post-mitigation score of High or below can be developed further.

Due to improved coding and research engineering performance, OpenAI o3‑mini is the first model to reach Medium risk on Model Autonomy. However, it still performs poorly on evaluations designed to test real-world ML research capabilities relevant for self improvement, which is required for a High classification. Our results underscore the need for building robust alignment methods, extensively stress-testing their efficacy, and maintaining meticulous risk management protocols.

This report outlines the safety work carried out for the OpenAI o3‑mini model, including safety evaluations, external red teaming, and Preparedness Framework evaluations.

- [System Cards](https://openai.com/research/index/?tags=system-cards)