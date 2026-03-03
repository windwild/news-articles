---
title: "Privileged Bases in the Transformer Residual Stream \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/privileged-bases-in-the-transformer-residual-stream"
date: "2024-12-19"
scraped_at: "2026-03-03T06:59:29.030050876+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---

InterpretabilityResearch

可解释性研究

# Privileged Bases in the Transformer Residual Stream

# Transformer 残差流中的特权基

Mar 16, 2023

2023 年 3 月 16 日

[Read Paper](https://transformer-circuits.pub/2023/privileged-basis/index.html)

[阅读论文](https://transformer-circuits.pub/2023/privileged-basis/index.html)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流利度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。

## Abstract

## 摘要

Our mathematical theories of the Transformer architecture suggest that individual coordinates in the residual stream should have no special significance (that is, the basis directions should be in some sense "arbitrary" and no more likely to encode information than random directions). Recent work has shown that this observation is false in practice. We investigate this phenomenon and provisionally conclude that the per-dimension normalizers in the Adam optimizer are to blame for the effect.

我们对 Transformer 架构的数学理论表明，残差流中各个坐标本身不应具有特殊意义（即：基向量的方向在某种意义上应是“任意的”，其编码信息的能力不应强于随机方向）。但近期研究表明，这一推论在实践中并不成立。我们对这一现象展开研究，并初步得出结论：Adam 优化器中按维度进行的归一化操作（per-dimension normalizers）正是导致该效应的根源。

We explore two other obvious sources of basis dependency in a Transformer: Layer normalization, and finite-precision floating-point calculations. We confidently rule these out as being the source of the observed basis-alignment.

我们探讨了 Transformer 中另外两个明显的基依赖性来源：层归一化（Layer normalization）和有限精度浮点数计算。我们有充分把握排除这两者作为所观察到的基对齐现象的成因。