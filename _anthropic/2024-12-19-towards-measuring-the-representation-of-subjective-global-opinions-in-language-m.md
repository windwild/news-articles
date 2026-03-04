---
title: "Towards Measuring the Representation of Subjective Global Opinions in Language Models"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/towards-measuring-the-representation-of-subjective-global-opinions-in-language-models"
date: "2024-12-19"
scraped_at: "2026-03-03T06:49:28.420637815+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
&#123;% raw %}

Societal Impacts

社会影响

# Towards Measuring the Representation of Subjective Global Opinions in Language Models

# 面向衡量语言模型中主观全球观点的表征程度

Jun 29, 2023

2023年6月29日

[Read Paper](https://arxiv.org/abs/2306.16388)

[阅读论文](https://arxiv.org/abs/2306.16388)

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建了“AI 流畅度指数”（AI Fluency Index）——该指数为衡量当今人类与 AI 协作方式提供了一个基准。

## Abstract

## 摘要

Large language models (LLMs) may not equitably represent diverse global perspectives on societal issues. In this paper, we develop a quantitative framework to evaluate whose opinions model-generated responses are more similar to. We first build a dataset, GlobalOpinionQA, comprised of questions and answers from cross-national surveys designed to capture diverse opinions on global issues across different countries. Next, we define a metric that quantifies the similarity between LLM-generated survey responses and human responses, conditioned on country. With our framework, we run three experiments on an LLM trained to be helpful, honest, and harmless with Constitutional AI. By default, LLM responses tend to be more similar to the opinions of certain populations, such as those from the USA, and some European and South American countries, highlighting the potential for biases. When we prompt the model to consider a particular country's perspective, responses shift to be more similar to the opinions of the prompted populations, but can reflect harmful cultural stereotypes. When we translate GlobalOpinionQA questions to a target language, the model's responses do not necessarily become the most similar to the opinions of speakers of those languages. We release our dataset for others to use and build on. Our data is at [this URL](https://huggingface.co/datasets/Anthropic/llm_global_opinions). We also provide an interactive visualization at [this URL](https://llmglobalvalues.anthropic.com/).

大型语言模型（LLM）可能无法公平地表征全球各地关于社会议题的多元观点。本文提出一种定量评估框架，用于衡量模型生成的回答更接近哪些人群的观点。我们首先构建了一个名为 GlobalOpinionQA 的数据集，其中包含来自跨国调查的问题与答案，旨在捕捉不同国家民众对全球性议题的多样化看法。接着，我们定义了一项指标，在按国家条件化的基础上，量化 LLM 生成的调查回答与真实人类回答之间的相似度。基于该框架，我们在一个采用“宪法式人工智能”（Constitutional AI）训练、以“有益、诚实、无害”为目标的 LLM 上开展了三项实验。结果表明：默认情况下，LLM 的回答往往更接近某些特定人群（例如美国、部分欧洲及南美国家民众）的观点，凸显出潜在的偏见风险。当提示模型从某一特定国家的视角出发作答时，其回答确实会转向更贴近该国被提示人群的观点，但同时也可能反映出有害的文化刻板印象。此外，当我们将 GlobalOpinionQA 中的问题翻译为目标语言后，模型的回答并不必然变得最贴近该语言使用者的观点。我们已将本研究的数据集开源，供其他研究者使用和拓展。数据集地址为：[此链接](https://huggingface.co/datasets/Anthropic/llm_global_opinions)；交互式可视化工具则可通过 [此链接](https://llmglobalvalues.anthropic.com/) 访问。
&#123;% endraw %}
