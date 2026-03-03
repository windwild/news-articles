---
title: "Evaluating and Mitigating Discrimination in Language Model Decisions \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/evaluating-and-mitigating-discrimination-in-language-model-decisions"
date: "2024-08-05"
scraped_at: "2026-03-03T07:09:06.055284084+00:00"
language: "en"
translated: false
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---

Societal Impacts

# Evaluating and Mitigating Discrimination in Language Model Decisions

Dec 7, 2023

[Read Paper](http://arxiv.org/abs/2312.03689)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.


## Abstract

As language models (LMs) advance, interest is growing in applying them to high-stakes societal decisions, such as determining financing or housing eligibility. However, their potential for discrimination in such contexts raises ethical concerns, motivating the need for better methods to evaluate these risks. We present a method for proactively evaluating the potential discriminatory impact of LMs in a wide range of use cases, including hypothetical use cases where they have not yet been deployed. Specifically, we use an LM to generate a wide array of potential prompts that decision-makers may input into an LM, spanning 70 diverse decision scenarios across society, and systematically vary the demographic information in each prompt. Applying this methodology reveals patterns of both positive and negative discrimination in the Claude 2.0 model in select settings when no interventions are applied. While we do not endorse or permit the use of language models to make automated decisions for the high-risk use cases we study, we demonstrate techniques to significantly decrease both positive and negative discrimination through careful prompt engineering, providing pathways toward safer deployment in use cases where they may be appropriate. Our work enables developers and policymakers to anticipate, measure, and address discrimination as language model capabilities and applications continue to expand. We release our dataset and prompts [here](https://huggingface.co/datasets/Anthropic/discrim-eval).

## Policy Memo

[Evaluating and Mitigating Discrimination in Language Model Decisions Policy Memo](https://www-cdn.anthropic.com/f0dfb70b9b309d7c52845f73da8d964140669ff7/Anthropic_DiscriminationEval.pdf)