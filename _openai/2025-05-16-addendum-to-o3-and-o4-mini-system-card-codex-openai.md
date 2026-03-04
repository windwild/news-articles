---
render_with_liquid: false
title: "Addendum to o3 and o4-mini system card: Codex | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/o3-o4-mini-codex-system-card-addendum"
date: "2025-05-16"
scraped_at: "2026-03-02T10:12:21.873036715+00:00"
language: "en-US"
translated: false
description: "Codex is a cloud-based coding agent. Codex is powered by codex-1, a version of OpenAI o3 optimized for software engineering. codex-1 was trained using reinforcement learning on real-world coding tasks..."
---

May 16, 2025

[Safety](https://openai.com/news/safety-alignment/) [Publication](https://openai.com/research/index/publication/)

# Addendum to OpenAI o3 and o4-mini system card: Codex

[Read the System Card(opens in a new window)](https://cdn.openai.com/pdf/8df7697b-c1b2-4222-be00-1fd3298f351d/codex_system_card.pdf)


Codex is a cloud-based coding agent. Codex is powered by codex-1, a version of OpenAI o3 optimized for software engineering. codex-1 was trained using reinforcement learning on real-world coding tasks in a variety of environments to generate code that closely mirrors human style and PR preferences, adheres precisely to instructions, and iteratively runs tests until passing results are achieved.

Users can ask Codex to perform coding tasks or to answer questions about a codebase. Each agent runs in its own cloud container with no internet access. The container is preloaded with the user’s code and a development environment defined by the user, including any dependencies, configuration, or tooling they specify. After setup, internet access is disabled and the model trajectory begins. Within that environment, Codex can read and edit files, as well as execute commands including tests, linters, and type checkers.

Codex is trained to provide verifiable evidence of its actions through citations of terminal logs and files, allowing the user to validate the model’s work. Once a task is complete, users can inspect the results, request refinements, or export the generated diff—either by converting it into a GitHub pull request or copying it for local testing and development.

Read the full OpenAI o3 and o4-mini System Card [here⁠](https://openai.com/index/o3-o4-mini-system-card/).

- [System Cards](https://openai.com/news/?tags=system-cards)