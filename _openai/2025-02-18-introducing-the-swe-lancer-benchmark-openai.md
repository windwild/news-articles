---
render_with_liquid: false
title: "Introducing the SWE-Lancer benchmark | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/swe-lancer"
date: "2025-02-18"
scraped_at: "2026-03-02T10:14:35.336799030+00:00"
language: "en-US"
translated: false
description: "Can frontier LLMs earn $1 million from real-world freelance software engineering?"
---

February 18, 2025


# Introducing the SWE-Lancer benchmark

Can frontier LLMs earn $1 million from real-world freelance software engineering?

[Read paper(opens in a new window)](http://arxiv.org/abs/2502.12115) [Access repository(opens in a new window)](https://github.com/openai/preparedness)



We introduce SWE-Lancer, a benchmark of over 1,400 freelance software engineering tasks from Upwork, valued at $1 million USD total in real-world payouts. SWE-Lancer encompasses both independent engineering tasks—ranging from $50 bug fixes to $32,000 feature implementations—and managerial tasks, where models choose between technical implementation proposals. Independent tasks are graded with end-to-end tests triple-verified by experienced software engineers, while managerial decisions are assessed against the choices of the original hired engineering managers. We evaluate model performance and find that frontier models are still unable to solve the majority of tasks. To facilitate future research, we open-source a unified Docker image and a public evaluation split, SWE-Lancer Diamond. By mapping model performance to monetary value, we hope SWE-Lancer enables greater research into the economic impact of AI model development.

* * *

_**Update on July 28, 2025:**_ _Dataset and results updated as of July 17, 2025, available at:_ [_https://github.com/openai/preparedness_ ⁠(opens in a new window)](https://github.com/openai/preparedness) [_⁠_ ⁠(opens in a new window)](https://github.com/openai/preparedness%E2%81%A0) _and in our system cards. The updated dataset removes the requirement for Internet connectivity during execution, eliminating a primary source of variability in model performance._