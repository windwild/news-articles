---
render_with_liquid: false
title: "Evaluating large language models trained on code | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/evaluating-large-language-models-trained-on-code"
date: "2021-07-07"
scraped_at: "2026-03-02T10:26:24.344955507+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---

July 7, 2021


# Evaluating large language models trained on code

[Read paper(opens in a new window)](https://arxiv.org/abs/2107.03374) [Read blog](https://openai.com/index/openai-codex/)

![Evaluating Large Language Models Trained On Code](images/evaluating-large-language-models-trained-on-code-openai/img_001.webp)



_**Update on May 16, 2025:**_ _We launched Codex, a cloud-based software engineering agent that can work on many tasks in parallel._ [_Learn more_ ⁠](https://openai.com/index/introducing-codex/) _._

* * *

## Abstract

We introduce Codex, a GPT language model fine-tuned on publicly available code from GitHub, and study its Python code-writing capabilities. A distinct production version of Codex powers GitHub Copilot. On HumanEval, a new evaluation set we release to measure functional correctness for synthesizing programs from docstrings, our model solves 28.8% of the problems, while GPT‑3 solves 0% and GPT‑J solves 11.4%. Furthermore, we find that repeated sampling from the model is a surprisingly effective strategy for producing working solutions to difficult prompts. Using this method, we solve 70.2% of our problems with 100 samples per problem. Careful investigation of our model reveals its limitations, including difficulty with docstrings describing long chains of operations and with binding operations to variables. Finally, we discuss the potential broader impacts of deploying powerful code generation technologies, covering safety, security, and economics.

- [Codex](https://openai.com/research/index/?tags=codex)
- [Software & Engineering](https://openai.com/research/index/?tags=software-engineering)
- [Transformers](https://openai.com/research/index/?tags=transformers)
- [Compute Scaling](https://openai.com/research/index/?tags=compute-scaling)
- [Language](https://openai.com/research/index/?tags=language)
- [Generative Models](https://openai.com/research/index/?tags=generative-models)