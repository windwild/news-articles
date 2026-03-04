---
title: "Open-sourcing circuit-tracing tools \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/open-source-circuit-tracing"
date: "2025-05-29"
scraped_at: "2026-03-03T06:44:13.320118591+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
&#123;% raw %}

Interpretability

可解释性

# Open-sourcing circuit tracing tools

# 开源电路追踪工具

May 29, 2025

2025 年 5 月 29 日

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们分析了数千次 Claude.ai 对话，追踪了 11 种可观测行为，从而构建出“AI 流利度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。

In our recent interpretability research, we introduced a new method to [trace the thoughts](https://www.anthropic.com/research/tracing-thoughts-language-model) of a large language model. Today, we’re open-sourcing the method so that anyone can build on our research.

在我们近期的可解释性研究中，我们提出了一种新方法，用于[追溯大语言模型的“思维过程”](https://www.anthropic.com/research/tracing-thoughts-language-model)。今天，我们正式将该方法开源，以便任何研究人员都能在此基础上开展进一步探索。

Our approach is to generate _attribution graphs_, which (partially) reveal the steps a model took internally to decide on a particular output. The open-source [library](https://github.com/safety-research/circuit-tracer) we’re releasing supports the generation of attribution graphs on popular open-weights models—and a frontend hosted by Neuronpedia lets you explore the graphs interactively.

我们的方法是生成_归因图_（attribution graphs），它（部分地）揭示了模型在生成某一特定输出时所经历的内部推理步骤。本次开源的[代码库](https://github.com/safety-research/circuit-tracer)支持在主流开源权重模型上生成归因图；同时，由 Neuronpedia 托管的交互式前端界面，使您能够直观、动态地探索这些图表。

This project was led by participants in our [Anthropic Fellows](https://alignment.anthropic.com/2024/anthropic-fellows-program/) program, in collaboration with [Decode Research](https://www.decoderesearch.org/).

本项目由我们[Anthropic 研究员计划](https://alignment.anthropic.com/2024/anthropic-fellows-program/)的参与者主导，并与[Decode Research](https://www.decoderesearch.org/)合作完成。

![](images/open-sourcing-circuit-tracing-tools-anthropic/img_001.jpg)An overview of the interactive graph explorer UI on Neuronpedia.

![](images/open-sourcing-circuit-tracing-tools-anthropic/img_001.jpg)Neuronpedia 上交互式图谱浏览器界面概览。

To get started, you can visit the [Neuronpedia interface](https://www.neuronpedia.org/gemma-2-2b/graph) to generate and view your own attribution graphs for prompts of your choosing. For more sophisticated usage and research, you can view the [code repository](https://github.com/safety-research/circuit-tracer). This release enables researchers to:

入门指南：您可访问 [Neuronpedia 界面](https://www.neuronpedia.org/gemma-2-2b/graph)，为任意输入提示（prompt）生成并查看专属的归因图谱（attribution graphs）。如需更高级的应用与研究，欢迎查阅 [代码仓库](https://github.com/safety-research/circuit-tracer)。本次开源使研究人员能够：

1. **Trace circuits** on supported models, by generating their own attribution graphs;  
1. **追踪电路**（circuit tracing）：在支持的模型上，通过生成自定义归因图谱来识别功能电路；  

2. **Visualize, annotate, and share** graphs in an interactive frontend;  
2. **可视化、标注与共享**图谱：借助交互式前端界面完成图谱的可视化呈现、人工标注及协作分享；  

3. **Test hypotheses** by modifying feature values and observing how model outputs change.  
3. **验证假设**：通过修改特定特征值，观察模型输出的变化，从而检验关于模型行为的科学假设。

We’ve already used these tools to study interesting behaviors like multi-step reasoning and multilingual representations in Gemma-2-2b and Llama-3.2-1b—see our demo [notebook](https://github.com/safety-research/circuit-tracer/blob/main/demos/circuit_tracing_tutorial.ipynb) for examples and analysis. We also invite the community to help us find additional interesting circuits—as inspiration, we provide additional attribution graphs that we haven’t yet analyzed in the demo notebook and on Neuronpedia.

我们已利用这些工具研究了 Gemma-2-2b 和 Llama-3.2-1b 中若干有趣现象，例如多步推理（multi-step reasoning）与多语言表征（multilingual representations）——详见我们的演示 [Notebook](https://github.com/safety-research/circuit-tracer/blob/main/demos/circuit_tracing_tutorial.ipynb)，其中包含具体示例与深入分析。我们也诚挚邀请社区成员共同参与，协助我们发现更多有意义的功能电路；作为启发，我们在演示 Notebook 及 Neuronpedia 平台上额外提供了若干尚未分析的归因图谱。

Our CEO Dario Amodei [wrote recently](https://www.darioamodei.com/post/the-urgency-of-interpretability) about the urgency of interpretability research: at present, our understanding of the inner workings of AI lags far behind the progress we’re making in AI capabilities. By open-sourcing these tools, we're hoping to make it easier for the broader community to study what’s going on inside language models. We’re looking forward to seeing applications of these tools to understand model behaviors—as well as extensions that improve the tools themselves.

本公司首席执行官 Dario Amodei 近期撰文 [《可解释性研究的紧迫性》](https://www.darioamodei.com/post/the-urgency-of-interpretability)，强调了可解释性（interpretability）研究的迫切需求：当前，我们对人工智能内在工作机制的理解，已远远落后于其能力层面的飞速发展。此次开源这些工具，旨在降低研究门槛，助力更广泛的学术与工程社区深入探究大语言模型的内部运作机制。我们热切期待看到这些工具被应用于各类模型行为分析任务中，也欢迎社区贡献功能扩展与性能优化，共同推动工具本身的持续演进。

_The open-source-circuit-finding library was developed by [Anthropic Fellows](https://alignment.anthropic.com/2024/anthropic-fellows-program/) Michael Hanna and Mateusz Piotrowski with mentorship from Emmanuel Ameisen and Jack Lindsey. The Neuronpedia integration was implemented by [Decode Research](https://www.decoderesearch.org/) (Neuronpedia lead: Johnny Lin; Science lead/director: Curt Tigges). Our Gemma graphs are based on transcoders trained as part of the [GemmaScope](https://ai.google.dev/gemma/docs/gemma_scope) project. For questions or feedback, please open an issue on GitHub._

_本开源电路发现（circuit-finding）库由 [Anthropic 研究员计划](https://alignment.anthropic.com/2024/anthropic-fellows-program/) 成员 Michael Hanna 与 Mateusz Piotrowski 主导开发，并在 Emmanuel Ameisen 与 Jack Lindsey 的指导下完成。Neuronpedia 集成工作由 [Decode Research](https://www.decoderesearch.org/) 团队实现（Neuronpedia 项目负责人：Johnny Lin；科研负责人/总监：Curt Tigges）。本项目中的 Gemma 图谱基于 [GemmaScope](https://ai.google.dev/gemma/docs/gemma_scope) 项目训练所得的转码器（transcoder）构建。如有任何问题或建议，欢迎在 GitHub 上提交 Issue。_
&#123;% endraw %}
