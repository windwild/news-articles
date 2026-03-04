---
title: "Evaluating and Mitigating Discrimination in Language Model Decisions \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/evaluating-and-mitigating-discrimination-in-language-model-decisions"
date: "2024-08-05"
scraped_at: "2026-03-03T07:09:06.055284084+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
&#123;% raw %}

Societal Impacts

社会影响

# Evaluating and Mitigating Discrimination in Language Model Decisions

# 评估与缓解语言模型决策中的歧视问题

Dec 7, 2023

2023年12月7日

[Read Paper](http://arxiv.org/abs/2312.03689)

[阅读论文](http://arxiv.org/abs/2312.03689)

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。

## Abstract

## 摘要

As language models (LMs) advance, interest is growing in applying them to high-stakes societal decisions, such as determining financing or housing eligibility. However, their potential for discrimination in such contexts raises ethical concerns, motivating the need for better methods to evaluate these risks. We present a method for proactively evaluating the potential discriminatory impact of LMs in a wide range of use cases, including hypothetical use cases where they have not yet been deployed. Specifically, we use an LM to generate a wide array of potential prompts that decision-makers may input into an LM, spanning 70 diverse decision scenarios across society, and systematically vary the demographic information in each prompt. Applying this methodology reveals patterns of both positive and negative discrimination in the Claude 2.0 model in select settings when no interventions are applied. While we do not endorse or permit the use of language models to make automated decisions for the high-risk use cases we study, we demonstrate techniques to significantly decrease both positive and negative discrimination through careful prompt engineering, providing pathways toward safer deployment in use cases where they may be appropriate. Our work enables developers and policymakers to anticipate, measure, and address discrimination as language model capabilities and applications continue to expand. We release our dataset and prompts [here](https://huggingface.co/datasets/Anthropic/discrim-eval).

随着语言模型（LMs）的持续进步，人们日益关注将其应用于高风险的社会决策场景，例如判定融资资格或住房准入资格。然而，此类应用中潜在的歧视风险引发了伦理关切，亟需更完善的方法来评估这些风险。本文提出一种前瞻性方法，用于广泛评估语言模型在各类应用场景（包括尚未实际部署的假设性场景）中可能产生的歧视性影响。具体而言，我们利用一个语言模型生成大量潜在提示（prompts），模拟决策者可能输入至语言模型的各类指令；这些提示覆盖社会中 70 种多样化的决策场景，并在每个提示中系统性地调整人口统计学信息（如种族、性别、年龄等）。应用该方法后发现：在未施加任何干预措施的特定设置下，Claude 2.0 模型呈现出正向与负向歧视并存的模式。尽管我们既不支持也不允许将语言模型用于本文所研究的高风险决策场景之自动化判断，但我们展示了如何通过审慎的提示工程（prompt engineering）显著降低正向与负向歧视，从而为语言模型在适宜场景下的更安全部署提供可行路径。本研究有助于开发者与政策制定者在语言模型能力与应用持续拓展的过程中，提前预判、量化评估并有效应对歧视问题。我们的数据集与全部提示词已开源发布于 [此处](https://huggingface.co/datasets/Anthropic/discrim-eval)。

## Policy Memo

## 政策备忘录

[Evaluating and Mitigating Discrimination in Language Model Decisions Policy Memo](https://www-cdn.anthropic.com/f0dfb70b9b309d7c52845f73da8d964140669ff7/Anthropic_DiscriminationEval.pdf)

[评估与缓解语言模型决策中的歧视问题——政策备忘录](https://www-cdn.anthropic.com/f0dfb70b9b309d7c52845f73da8d964140669ff7/Anthropic_DiscriminationEval.pdf)
&#123;% endraw %}
