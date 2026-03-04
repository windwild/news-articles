---
title: "Estimating worst case frontier risks of open weight LLMs | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/estimating-worst-case-frontier-risks-of-open-weight-llms"
date: "2025-08-05"
scraped_at: "2026-03-02T10:10:44.457277388+00:00"
language: "en-US"
translated: false
description: "In this paper, we study the worst-case frontier risks of releasing gpt-oss. We introduce malicious fine-tuning (MFT), where we attempt to elicit maximum capabilities by fine-tuning gpt-oss to be as ca..."
---
{% raw %}

August 5, 2025

[Safety](https://openai.com/news/safety-alignment/) [Publication](https://openai.com/research/index/publication/)

# Estimating worst case frontier risks of open weight LLMs

[Read the paper(opens in a new window)](https://cdn.openai.com/pdf/231bf018-659a-494d-976c-2efdfc72b652/oai_gpt-oss_Model_Safety.pdf)


## Abstract

In this paper, we study the worst-case frontier risks of releasing gpt-oss. We introduce malicious fine-tuning (MFT), where we attempt to elicit maximum capabilities by fine-tuning gpt-oss to be as capable as possible in two domains: biology and cybersecurity. To maximize biological risk (biorisk), we curate tasks related to threat creation and train gpt-oss in an RL environment with web browsing. To maximize cybersecurity risk, we train gpt-oss in an agentic coding environment to solve capture-the-flag (CTF) challenges. We compare these MFT models against open- and closed-weight LLMs on frontier risk evaluations. Compared to frontier closed-weight models, MFT gpt-oss underperforms OpenAI o3, a model that is below Preparedness High capability level for biorisk and cybersecurity. Compared to open-weight models, gpt-oss may marginally increase biological capabilities but does not substantially advance the frontier. Taken together, these results contributed to our decision to release the model, and we hope that our MFT approach can serve as useful guidance for estimating harm from future open-weight releases.

- [2025](https://openai.com/news/?tags=2025)
{% endraw %}
