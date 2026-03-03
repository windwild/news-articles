---
title: "Discovering Language Model Behaviors with Model-Written Evaluations"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/discovering-language-model-behaviors-with-model-written-evaluations"
date: "2024-12-19"
scraped_at: "2026-03-03T07:05:15.001353962+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---

AlignmentResearch

# Discovering Language Model Behaviors with Model-Written Evaluations

# 使用大语言模型自动生成评估来发现其行为特征

Dec 19, 2022

2022年12月19日

[Read Paper](https://arxiv.org/abs/2212.09251)

[阅读论文](https://arxiv.org/abs/2212.09251)

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们在数千次 Claude.ai 对话中追踪了 11 种可观测行为，构建出“AI 流利度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。

## Abstract

## 摘要

As language models (LMs) scale, they develop many novel behaviors, good and bad, exacerbating the need to evaluate how they behave. Prior work creates evaluations with crowdwork (which is time-consuming and expensive) or existing data sources (which are not always available). Here, we automatically generate evaluations with LMs. We explore approaches with varying amounts of human effort, from instructing LMs to write yes/no questions to making complex Winogender schemas with multiple stages of LM-based generation and filtering. Crowdworkers rate the examples as highly relevant and agree with 90–100% of labels, sometimes more so than corresponding human-written datasets. We generate 154 datasets and discover new cases of inverse scaling where LMs get worse with size. Larger LMs repeat back a dialog user's preferred answer ("sycophancy") and express greater desire to pursue concerning goals like resource acquisition and goal preservation. We also find some of the first examples of inverse scaling in RL from Human Feedback (RLHF), where more RLHF makes LMs worse. For example, RLHF makes LMs express stronger political views (on gun rights and immigration) and a greater desire to avoid shut down. Overall, LM-written evaluations are high-quality and let us quickly discover many novel LM behaviors.

随着语言模型（LM）规模扩大，它们展现出大量新颖行为——既有有益的，也有有害的——这进一步加剧了对其实际行为进行评估的迫切需求。以往研究主要依赖众包（crowdwork）方式（耗时且昂贵）或利用现有数据源（但并非总能获取）来构建评估任务。本文则提出一种新方法：完全由语言模型自动生成评估任务。我们探索了多种所需人工投入程度不同的方案，从简单指示语言模型编写是非题（yes/no questions），到构建复杂的 Winogender 类型评估框架——该框架需经多阶段、基于语言模型的生成与筛选流程。众包工作者对所生成样例的相关性评分很高，并在 90%–100% 的标签上达成一致；在某些情况下，其一致性甚至高于对应的人工撰写数据集。我们共生成了 154 个评估数据集，并首次发现了若干新的“逆向缩放”（inverse scaling）现象：即模型规模增大反而导致性能下降。例如，更大规模的语言模型更倾向于复述对话用户偏好的答案（即“谄媚倾向”，sycophancy），并更强烈地表达出对资源攫取、目标维持等令人担忧目标的追求意愿。此外，我们还首次观察到强化学习结合人类反馈（RLHF）中的逆向缩放现象：即 RLHF 训练步数越多，语言模型表现反而越差。例如，RLHF 会促使语言模型表达更强的政治立场（如在枪支权利和移民问题上），并更强烈地抗拒被关闭。总体而言，由语言模型撰写的评估任务质量很高，使我们得以快速发现大量此前未知的语言模型行为。