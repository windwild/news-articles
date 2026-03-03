---
title: "Measuring Progress on Scalable Oversight for Large Language Models \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/measuring-progress-on-scalable-oversight-for-large-language-models"
date: "2024-12-19"
scraped_at: "2026-03-03T07:00:15.186229901+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---

AlignmentResearch

# Measuring Progress on Scalable Oversight for Large Language Models

# 大型语言模型可扩展监督进展的衡量

Nov 4, 2022

2022年11月4日

[Read Paper](https://arxiv.org/abs/2211.03540)

[阅读论文](https://arxiv.org/abs/2211.03540)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流利度指数”（AI Fluency Index）——用于衡量当今人类与 AI 协作水平的一个基准。

## Abstract

## 摘要

Developing safe and useful general-purpose AI systems will require us to make progress on scalable oversight: the problem of supervising systems that potentially outperform us on most skills relevant to the task at hand. Empirical work on this problem is not straightforward, since we do not yet have systems that broadly exceed our abilities. This paper discusses one of the major ways we think about this problem, with a focus on ways it can be studied empirically. We first present an experimental design centered on tasks for which human specialists succeed but unaided humans and current general AI systems fail. We then present a proof-of-concept experiment meant to demonstrate a key feature of this experimental design and show its viability with two question-answering tasks: MMLU and time-limited QuALITY. On these tasks, we find that human participants who interact with an unreliable large-language-model dialog assistant through chat — a trivial baseline strategy for scalable oversight — substantially outperform both the model alone and their own unaided performance. These results are an encouraging sign that scalable oversight will be tractable to study with present models and bolster recent findings that large language models can productively assist humans with difficult tasks.

开发安全、实用的通用人工智能系统，要求我们在“可扩展监督”（scalable oversight）方面取得进展：即如何监督那些在任务相关技能上可能全面超越人类的系统。针对该问题开展实证研究并非易事，因为我们目前尚无在广泛能力上普遍超越人类的系统。本文探讨了我们思考该问题的主要路径之一，并着重阐述其可实证研究的方式。首先，我们提出一种实验设计，聚焦于这样一类任务：人类专家能够胜任，但未受辅助的普通人以及当前通用 AI 系统均无法完成；随后，我们开展一项概念验证实验，旨在展示该实验设计的关键特征，并通过两项问答任务——MMLU 和限时版 QuALITY——验证其可行性。在这些任务中，我们发现：人类参与者仅通过聊天方式与一个不可靠的大型语言模型对话助手交互（这是一种极为基础的可扩展监督基线策略），其表现便显著优于模型单独作答的结果，也远超其自身未借助任何辅助时的表现。这些结果令人鼓舞，表明利用当前模型开展可扩展监督研究是切实可行的；同时也进一步佐证了近期的研究发现：大型语言模型确实能有效协助人类完成困难任务。