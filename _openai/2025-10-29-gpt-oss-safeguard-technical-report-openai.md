---
title: "gpt-oss-safeguard technical report | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/gpt-oss-safeguard-technical-report"
date: "2025-10-29"
scraped_at: "2026-03-02T10:09:26.367705573+00:00"
language: "en-US"
translated: false
description: "gpt-oss-safeguard-120b and gpt-oss-safeguard-20b are two open-weight reasoning models post-trained from the gpt-oss models and trained to reason from a provided policy in order to label content under ..."
---
&#123;% raw %}

October 29, 2025

[Safety](https://openai.com/news/safety-alignment/) [Release](https://openai.com/research/index/release/)

# gpt-oss-safeguard technical report

Performance and baseline evaluations of gpt-oss-safeguard-120b and gpt-oss-safeguard-20b

[Read technical report(opens in a new window)](https://cdn.openai.com/pdf/08b7dee4-8bc6-4955-a219-7793fb69090c/Technical_report__Research_Preview_of_gpt_oss_safeguard.pdf)


## Introduction

gpt-oss-safeguard-120b and gpt-oss-safeguard-20b are two open-weight reasoning models post-trained from the gpt-oss models and trained to reason from a provided policy in order to label content under that policy. They are available under the Apache 2.0 license and our gpt-oss usage policy. Developed with feedback from the open-source community, these text-only models are compatible with our Responses API. The models are customizable, provide full chain-of-thought (CoT), can be used with different reasoning efforts (low, medium, high), and support Structured Outputs.

In this report, we describe gpt-oss-safeguard’s capabilities and provide our baseline safety evaluations on the gpt-oss-safeguard models, using the underlying gpt-oss models as a baseline. For more information about the development and architecture of the underlying gpt-oss models, see the original [gpt-oss model model card⁠](https://openai.com/index/gpt-oss-model-card/).

We recommend using these models to classify content against a provided policy, and not as the core functionality with which end users interact; the original gpt-oss models are better for those applications. The safety metrics provided below describe how gpt-oss-safeguard models function in chat settings. The gpt-oss-safeguard models are not intended for this use, but since they are open models, it is possible for someone to use the models in this way. Because of that possibility, we wanted to verify that they met our safety standards in such usage; this report shares the results of those tests. We also share an initial evaluation of multi-language performance in a chat setting; note that this does not directly assess performance during content classification with a provided policy.

The gpt-oss-safeguard models are fine-tunes of their gpt-oss counterparts, and were trained without any additional biological or cybersecurity data. As a result, we determined that the previous work [estimating worst case scenarios⁠](https://openai.com/index/estimating-worst-case-frontier-risks-of-open-weight-llms/) from gpt-oss release cross applies to these new models.

- [2025](https://openai.com/news/?tags=2025)
&#123;% endraw %}
