---
title: "A General Language Assistant as a Laboratory for Alignment"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/a-general-language-assistant-as-a-laboratory-for-alignment"
date: "2024-12-19"
scraped_at: "2026-03-03T07:06:30.074729618+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
&#123;% raw %}

AlignmentResearch

对齐研究

# A General Language Assistant as a Laboratory for Alignment

# 作为对齐研究实验室的通用语言助手

Dec 1, 2021

2021年12月1日

[Read Paper](https://arxiv.org/abs/2112.00861)

[阅读论文](https://arxiv.org/abs/2112.00861)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千场 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。

## Abstract

## 摘要

Given the broad capabilities of large language models, it should be possible to work towards a general-purpose, text-based assistant that is aligned with human values, meaning that it is helpful, honest, and harmless. As an initial foray in this direction we study simple baseline techniques and evaluations, such as prompting. We find that the benefits from modest interventions increase with model size, generalize to a variety of alignment evaluations, and do not compromise the performance of large models. Next we investigate scaling trends for several training objectives relevant to alignment, comparing imitation learning, binary discrimination, and ranked preference modeling. We find that ranked preference modeling performs much better than imitation learning, and often scales more favorably with model size. In contrast, binary discrimination typically performs and scales very similarly to imitation learning. Finally we study a \`preference model pre-training' stage of training, with the goal of improving sample efficiency when finetuning on human preferences.

鉴于大语言模型所具备的广泛能力，我们有望构建一种通用型、基于文本的智能助手，使其在价值观上与人类保持一致——即做到有益（helpful）、诚实（honest）且无害（harmless）。作为朝此方向迈出的第一步，我们研究了若干基础性技术与评估方法，例如提示工程（prompting）。结果表明：适度干预所带来的收益随模型规模增大而提升，这些收益可泛化至多种对齐评估任务，且不会损害大模型本身的性能。接下来，我们考察了若干与对齐目标相关的训练目标的扩展规律，对比分析了模仿学习（imitation learning）、二元判别（binary discrimination）和排序式偏好建模（ranked preference modeling）。我们发现，排序式偏好建模的表现显著优于模仿学习，且其性能通常也更随模型规模扩大而提升；相比之下，二元判别在表现和扩展规律上则与模仿学习高度相似。最后，我们研究了一种“偏好模型预训练”（preference model pre-training）阶段，旨在提升后续基于人类偏好的微调过程中的样本利用效率。
&#123;% endraw %}
