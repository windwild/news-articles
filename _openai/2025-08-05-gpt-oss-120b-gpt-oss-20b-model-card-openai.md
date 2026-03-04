---
render_with_liquid: false
title: "gpt-oss-120b & gpt-oss-20b Model Card | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/gpt-oss-model-card"
date: "2025-08-05"
scraped_at: "2026-03-02T10:10:38.506634959+00:00"
language: "en-US"
translated: false
description: "We introduce gpt-oss-120b and gpt-oss-20b, two open-weight reasoning models available under the Apache 2.0 license and our gpt-oss usage policy."
---

August 5, 2025

[Publication](https://openai.com/research/index/publication/) [Safety](https://openai.com/news/safety-alignment/)

# gpt-oss-120b & gpt-oss-20b Model Card

[Read the model card(opens in a new window)](https://arxiv.org/abs/2508.10925)


## Introduction

We introduce gpt-oss-120b and gpt-oss-20b, two open-weight reasoning models available under the Apache 2.0 license and our gpt-oss usage policy. Developed with feedback from the open-source community, these text-only models are compatible with our Responses API and are designed to be used within agentic workflows with strong instruction following, tool use like web search and Python code execution, and reasoning capabilities—including the ability to adjust the reasoning effort for tasks that don’t require complex reasoning. The models are customizable, provide full chain-of-thought (CoT), and support Structured Outputs.

Safety is foundational to our approach to open models. They present a different risk profile than proprietary models: Once they are released, determined attackers could fine-tune them to bypass safety refusals or directly optimize for harm without the possibility for OpenAI to implement additional mitigations or to revoke access.

In some contexts, developers and enterprises will need to implement extra safeguards in order to replicate the system-level protections built into models served through our API and products. We’re terming this document a model card, rather than a system card, because the gpt-oss models will be used as part of a wide range of systems, created and maintained by a wide range of stakeholders. While the models are designed to follow OpenAI’s safety policies by default, other stakeholders will also make and implement their own decisions about how to keep those systems safe.

We ran scalable capability evaluations on gpt-oss-120b, and confirmed that the default model does not reach our indicative thresholds for High capability in any of the three Tracked Categories of our Preparedness Framework (Biological and Chemical capability, Cyber capability, and AI Self-Improvement). We also investigated two additional questions:

- _Could adversarial actors fine-tune gpt-oss-120b to reach High capability in the Biological and Chemical or Cyber domains?_ Simulating the potential actions of an attacker, we adversarially fine-tuned the gpt-oss-120b model for these two categories. OpenAI’s Safety Advisory Group (“SAG”) reviewed this testing and concluded that, even with robust fine-tuning that leveraged OpenAI’s field-leading training stack, gpt-oss-120b did not reach High capability in Biological and Chemical Risk or Cyber risk.
- _Would releasing gpt-oss-120b significantly advance the frontier of biological capabilities in open foundation models?_ We found that the answer is no: For most of the evaluations, the default performance of one or more existing open models comes near to matching the adversarially fine-tuned performance of gpt-oss-120b.

As part of this launch, OpenAI is reaffirming its commitment to advancing beneficial AI and raising safety standards across the ecosystem.

- [System Cards](https://openai.com/research/index/?tags=system-cards)
- [2025](https://openai.com/research/index/?tags=2025)