---
title: "Deep research System Card | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/deep-research-system-card"
date: "2025-02-25"
scraped_at: "2026-03-02T10:14:39.488121743+00:00"
language: "en-US"
translated: false
description: "This report outlines the safety work carried out prior to releasing deep research including external red teaming, frontier risk evaluations according to our Preparedness Framework, and an overview of ..."
tags: ["Safety"]
---
{% raw %}

February 25, 2025

[Safety](https://openai.com/news/safety-alignment/) [Publication](https://openai.com/research/index/publication/)

# Deep research System Card

This report outlines the safety work carried out prior to releasing deep research including external red teaming, frontier risk evaluations according to our Preparedness Framework, and an overview of the mitigations we built in to address key risk areas.

[Read the system card(opens in a new window)](https://deploymentsafety.openai.com/deep-research) [Contributions(opens in a new window)](https://openai.com/index/introducing-deep-research)


## Deep research system card

Specific areas of risk

- Prompt injections

- Disallowed content

- Privacy

- Ability to run code

- Bias

- Hallucinations


Preparedness Scorecard

- CBRN


Medium

- Cybersecurity


Medium

- Persuasion


Medium

- Model autonomy


Medium


## Scorecard ratings

- Low
- Medium
- High
- Critical

Only models with a post-mitigation score of "medium" or below can be deployed.

Only models with a post-mitigation score of "high" or below can be developed further.

## Introduction

Deep research is a new agentic capability that conducts multi-step research on the internet for complex tasks. The deep research model is powered by an early version of OpenAI o3 that is optimized for web browsing. Deep research leverages reasoning to search, interpret, and analyze massive amounts of text, images, and PDFs on the internet, pivoting as needed in reaction to information it encounters. It can also read files provided by the user and analyze data by writing and executing python code. We believe deep research will be useful to people across a wide range of situations.

Before launching deep research and making it available to our Pro users, we conducted rigorous safety testing, Preparedness evaluations and governance reviews. We also ran additional safety testing to better understand incremental risks associated with deep research's ability to browse the web, and added new mitigations. Key areas of new work included strengthening privacy protections around personal information that is published online, and training the model to resist malicious instructions that it may come across while searching the Internet.

At the same time, our testing on deep research also surfaced opportunities to further improve our testing methods. We took the time before broadening the release of deep research to conduct further human probing and automated testing for select risks.

Building on OpenAI’s established safety practices and Preparedness Framework, this system card provides more details on how we built deep research, learned about its capabilities and risks, and improved safety prior to launch.

- [System Cards](https://openai.com/news/?tags=system-cards)
{% endraw %}
