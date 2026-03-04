---
title: "Advancing science and math with GPT-5.2 | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/gpt-5-2-for-science-and-math"
date: "2025-12-11"
scraped_at: "2026-03-02T10:47:53.307700716+00:00"
language: "en-US"
translated: true
description: "GPT-5.2 is OpenAI’s strongest model yet for math and science, setting new state-of-the-art results on benchmarks like GPQA Diamond and FrontierMath. This post shows how those gains translate into re..."
tags: ["Publication"]
---
{% raw %}

December 11, 2025

2025年12月11日

[Publication](https://openai.com/research/index/publication/) [出版物](https://openai.com/research/index/publication/)  
[Product](https://openai.com/news/product-releases/) [产品动态](https://openai.com/news/product-releases/)  
[Company](https://openai.com/news/company-announcements/) [公司公告](https://openai.com/news/company-announcements/)

# Advancing science and math with GPT‑5.2

# 借助 GPT‑5.2 推进科学与数学研究

GPT‑5.2 is our strongest model yet for math and science work.

GPT‑5.2 是我们迄今在数学与科学研究任务中性能最强的模型。

[Read the paper(opens in a new window)](https://cdn.openai.com/pdf/a3f3f76c-98bd-47a5-888f-c52c932a8942/colt-monotonicity-problem.pdf)

[阅读论文（在新窗口中打开）](https://cdn.openai.com/pdf/a3f3f76c-98bd-47a5-888f-c52c932a8942/colt-monotonicity-problem.pdf)

One of our hopes for strong AI is that it will accelerate scientific research for the benefit of everyone, helping researchers explore more ideas, test them faster, and turn discoveries into impact.

我们对强人工智能的一大期望，是它能加速科学研究进程，惠及全人类——助力研究人员探索更多想法、更快开展验证，并将科学发现切实转化为实际影响。

Over the past year, we’ve been working closely with scientists across math, physics, biology, and computer science to understand where AI can help—and where it still falls short. Last month, we [published a paper⁠](https://openai.com/index/accelerating-science-gpt-5/) that compiles early case studies across math, physics, biology, computer science, astronomy, and materials science in which GPT‑5 helped researchers showing how GPT‑5 has already begun contributing to real scientific work. With [GPT‑5.2](https://openai.com/index/introducing-gpt-5-2/), we’re starting to see those gains become more consistent and more reliable.

过去一年间，我们与数学、物理、生物及计算机科学等领域的科学家密切合作，深入理解人工智能可在哪些环节提供切实帮助，又在哪些方面仍存在不足。上月，我们[发布了一篇论文](https://openai.com/index/accelerating-science-gpt-5/)，汇总了 GPT‑5 在数学、物理、生物、计算机科学、天文学和材料科学等领域中助力科研人员的早期案例研究，展示了 GPT‑5 如何已开始实质性地参与真实科研工作。而随着 [GPT‑5.2](https://openai.com/index/introducing-gpt-5-2/) 的推出，这些助益正变得愈发稳定、愈发可靠。

## Stronger performance where precision matters

## 在精度至关重要的场景中表现更优

GPT‑5.2 Pro and GPT‑5.2 Thinking are our strongest models yet for scientific and mathematical work.

GPT‑5.2 Pro 与 GPT‑5.2 Thinking 是我们迄今在科学与数学任务中性能最强的两款模型。

Strong mathematical reasoning is a foundation for reliability in scientific and technical work.  
强大的数学推理能力是科学与技术工作中可靠性的基石。

It enables models to follow multi-step logic, keep quantities consistent, and avoid subtle errors that can compound in real analyses—from simulations and statistics to forecasting and modeling.  
它使模型能够遵循多步逻辑、保持量纲一致，并避免在实际分析中可能不断累积的细微错误——从仿真与统计，到预测与建模。

Improvements on benchmarks like FrontierMath reflect not a narrow skill, but stronger general reasoning and abstraction, capabilities that carry directly into scientific workflows such as coding, data analysis, and experimental design.  
在 FrontierMath 等基准测试中的提升，反映的并非某项狭窄技能，而是更强大的通用推理与抽象能力；这些能力可直接迁移到科学工作流中，例如编程、数据分析和实验设计。

These capabilities are also closely tied to progress toward general intelligence.  
这些能力也与通向通用人工智能（AGI）的进展密切相关。

A system that can reliably reason through abstraction, maintain consistency across long chains of thought, and generalize across domains is exhibiting traits that are foundational to AGI—not task-specific tricks, but broad, transferable reasoning skills that matter across science, engineering, and real-world decision-making.  
一个能可靠地通过抽象进行推理、在长链思维中保持一致性、并在不同领域间泛化的系统，正展现出通向 AGI 的核心特质——这并非针对特定任务的技巧，而是广泛适用、可迁移的推理能力，其价值贯穿于科学、工程及现实世界决策之中。

We believe GPT‑5.2 Pro and GPT‑5.2 Thinking are the world’s best models for assisting and accelerating scientists.  
我们相信，GPT‑5.2 Pro 与 GPT‑5.2 Thinking 是目前全球最出色的科学家辅助与加速模型。

On **GPQA Diamond,** a graduate-level Google-proof Q&A benchmark, GPT‑5.2 Pro achieves 93.2%, followed closely by GPT‑5.2 Thinking at 92.4%.  
在 **GPQA Diamond**（一项面向研究生水平、经“谷歌验证”的问答基准测试）中，GPT‑5.2 Pro 达到 93.2% 的准确率，GPT‑5.2 Thinking 紧随其后，达 92.4%。

GPQA Diamond  
GPQA Diamond  

Science questions  
科学问题  

GPT-5.2 Pro GPT-5.2 Thinking GPT-5.1 Thinking  
GPT-5.2 Pro GPT-5.2 Thinking GPT-5.1 Thinking  

0% 20% 40% 60% 80% 100%  
0% 20% 40% 60% 80% 100%  

Accuracy 92.4% 88.1% 93.2%  
准确率 92.4% 88.1% 93.2%  

In [GPQA Diamond⁠(opens in a new window)](https://arxiv.org/abs/2311.12022), models answer multiple choice questions about physics, chemistry, and biology. No tools were enabled and reasoning effort was set to maximum.  
在 [GPQA Diamond⁠（新窗口打开）](https://arxiv.org/abs/2311.12022) 中，模型需回答关于物理学、化学与生物学的多项选择题。测试中未启用任何工具，且推理努力程度设为最高。

On **FrontierMath (Tier 1–3),** an evaluation of expert-level mathematics, GPT‑5.2 Thinking set a new state of the art, solving 40.3% of problems.  
在 **FrontierMath（第 1–3 级）**——一项面向专家级数学能力的评测中，GPT‑5.2 Thinking 创下新纪录，成功解答了 40.3% 的题目。

FrontierMath (Tier 1–3)  
FrontierMath（第 1–3 级）

Advanced mathematics  
高等数学  

GPT-5.2 Thinking GPT-5.1 Thinking  
GPT-5.2 Thinking GPT-5.1 Thinking  

0% 10% 20% 30% 40% 50%  
0% 10% 20% 30% 40% 50%  

Accuracy 40.3% 31.0%  
准确率 40.3% 31.0%  

In [FrontierMath⁠(opens in a new window)](https://epoch.ai/frontiermath), models solve expert-level mathematics problems. A Python tool was enabled and reasoning effort was set to maximum.  
在 [FrontierMath⁠（新窗口打开）](https://epoch.ai/frontiermath) 中，模型需求解专家级数学问题。测试中启用了 Python 工具，且推理努力程度设为最高。

## Case study

## 案例研究

GPT‑5.2 is not only strong at graduate-level science problems. We now regularly see our frontier models contributing solutions to previously unsolved—and increasingly subtle—questions in mathematics and the sciences.

GPT‑5.2 不仅在研究生水平的科学问题上表现出色，我们如今还经常看到前沿模型为数学与科学领域中此前悬而未决、且日益精微的问题提供解决方案。

In this case study, we describe how GPT‑5.2 Pro helped resolve an open research problem in statistical learning theory, documented in a new paper, [**_On Learning-Curve Monotonicity for Maximum Likelihood Estimators_** ⁠(opens in a new window)](https://cdn.openai.com/pdf/a3f3f76c-98bd-47a5-888f-c52c932a8942/colt-monotonicity-problem.pdf) **_._**

本案例研究介绍 GPT‑5.2 Pro 如何助力解决统计学习理论中一个长期开放的研究问题，相关成果已发表于新论文：[**《关于最大似然估计器的学习曲线单调性》** ⁠（在新窗口中打开）](https://cdn.openai.com/pdf/a3f3f76c-98bd-47a5-888f-c52c932a8942/colt-monotonicity-problem.pdf)。

The question (“If you collect more data, do your results reliably get better?”) shows up any time you fit a model from data. You can draw a learning curve that tracks average error as you add more examples. In the best case, the curve is monotone. More data means less error, every step of the way. That is the behavior people hope for, and often assume.

这一问题——“若收集更多数据，结果是否必然更可靠？”——在任何基于数据拟合模型的场景中都会出现。你可以绘制一条学习曲线，用以追踪随样本数量增加而变化的平均误差。在理想情况下，该曲线是单调的：每增加一份数据，误差就减少一分。这正是人们所期望、也常常默认的行为模式。

But over the last few years, researchers have learned that this intuition can fail. A line of work kicked off by an open problem posed at the Conference on Learning Theory (COLT) in 2019 by Viering, Mey, and Loog showed that the answer is often no. Even very simple, well-behaved toy setups can have non-monotonic learning curves, where adding data increases expected error. That surprise triggered a wave of follow-up papers. They expanded the list of settings where these reversals happen and proposed increasingly elaborate methods designed to restore monotone behavior.

但过去几年间，研究人员发现这种直觉并不总是成立。2019 年，Viering、Mey 与 Loog 在计算学习理论会议（Conference on Learning Theory, COLT）上提出的一个开放性问题，开启了一条研究脉络，表明答案往往是否定的。即便是极为简单、性质良好的玩具模型，其学习曲线也可能呈现非单调性——即增加数据反而导致期望误差上升。这一反直觉现象引发了一系列后续研究：它们不断拓展此类“逆转”现象发生的场景，并提出了愈发复杂的修正方法，旨在恢复单调行为。

Still, one of the most basic cases remained unresolved. What happens in the cleanest textbook situation, where the statistical model is actually correct and the data follow the familiar bell curve pattern, with a known mean but unknown standard deviation? Researchers already knew that small changes to this setup could break monotonic behavior. But the answer remained unknown in this core case.

然而，最基础的情形之一却始终悬而未决：在教科书般“干净”的设定下——即统计模型本身完全正确，数据严格服从熟悉的钟形分布（正态分布），均值已知而标准差未知——学习曲线是否单调？研究人员早已知道，对该设定做细微改动便足以破坏单调性；但在此核心情形下，答案却一直未知。

Our new paper demonstrates that in this clean setting, intuition prevails: learning is predictably improved by more data, rather than behaving in surprising or unstable ways. What makes this paper unusual is how the proof was obtained. The authors did not work out a strategy and then ask the model to fill in steps. They did not provide intermediate arguments or a proof outline. Instead, they asked GPT‑5.2 Pro to solve the open problem directly, and then carefully verified the proof, including review and validation by external subject-matter experts.

我们的新论文证明，在这一“干净”设定下，直觉终获证实：学习效果可被数据量的增加所稳定提升，而非表现出令人意外或不稳定的特性。本论文的独特之处在于其证明的获取方式：作者并未自行设计证明策略再让模型补全步骤，也未提供中间论证或证明提纲；而是直接要求 GPT‑5.2 Pro 解决该开放性问题，随后对所得证明进行了严谨验证——包括邀请外部领域专家进行审阅与确认。

The authors then asked simple follow-up questions to see how far the idea could go. GPT‑5.2 Pro extended the result beyond the original problem to higher dimensional settings and other common statistical models. Throughout, the human role stayed focused on verification and clear writing, rather than supplying mathematical scaffolding.

随后，作者又提出若干简单的延伸问题，以检验该思路的适用边界。GPT‑5.2 Pro 将该结论推广至更高维设定及其他常见统计模型。整个过程中，人类角色始终聚焦于验证与清晰表述，而非提供数学上的框架性支持。

## Looking ahead

## 展望未来

This result suggests a useful direction for how AI systems can support scientific research, particularly in domains with axiomatic theoretical foundations such as mathematics and theoretical computer science. In settings like these, frontier models can help explore proofs, test hypotheses, and identify connections that might otherwise take substantial human effort to uncover.

这一成果为人工智能系统如何助力科学研究指明了一条切实可行的路径——尤其适用于数学、理论计算机科学等具有公理化理论基础的领域。在这些领域中，前沿模型可协助探索证明思路、检验假设、发现潜在关联，而这些工作若单靠人力完成，往往需要耗费大量精力。

At the same time, these systems are not independent researchers. Expert judgment, verification, and domain understanding remain essential. Even highly capable models can make mistakes or rely on unstated assumptions. But they can also produce detailed, structured arguments that merit careful human study and refinement. Making reliable progress with AI therefore depends on workflows that keep validation, transparency, and collaboration firmly in the loop.

与此同时，这些系统并非独立的研究者。专家判断、验证与领域理解依然不可或缺。即使能力极强的模型也可能出错，或依赖于未明言的假设。但它们同样能够生成细致、结构清晰的论证，值得人类研究者审慎研读与进一步完善。因此，借助 AI 实现可靠进展，关键在于构建将验证、透明性与协作牢牢纳入其中的工作流程。

Viewed as a case study, this result illustrates an emerging mode of research practice. Models like GPT‑5.2 can serve as tools for supporting mathematical reasoning and accelerating early-stage exploration, while responsibility for correctness, interpretation, and context remains with human researchers. Used carefully, such systems may help streamline significant aspects of theoretical work without displacing the central role of human judgment in scientific inquiry.

将这一结果视为一个典型案例，它揭示了一种正在兴起的研究实践范式：诸如 GPT‑5.2 之类的模型可作为辅助数学推理、加速初期探索的工具；而对正确性、解释与语境的最终责任，仍由人类研究者承担。若审慎使用，此类系统有望显著简化理论工作的诸多环节，却不会削弱人类判断在科学探究中的核心地位。

- [GPT](https://openai.com/research/index/?tags=gpt)  
- [GPT](https://openai.com/research/index/?tags=gpt)

- [Reasonings & Policy](https://openai.com/research/index/?tags=reasoning-policy)  
- [推理与策略（Reasonings & Policy）](https://openai.com/research/index/?tags=reasoning-policy)

- [2025](https://openai.com/research/index/?tags=2025)  
- [2025](https://openai.com/research/index/?tags=2025)
{% endraw %}
