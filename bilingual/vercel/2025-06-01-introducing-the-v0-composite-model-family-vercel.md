---
title: "Introducing the v0 composite model family - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/v0-composite-model-family"
date: "2025-06-01"
scraped_at: "2026-03-02T09:32:52.904195433+00:00"
language: "en-zh"
translated: true
description: "Learn how v0's composite AI models combine RAG, frontier LLMs, and AutoFix to build accurate, up-to-date web app code with fewer errors and faster output."
---

Jun 1, 2025

2025年6月1日

We recently launched our AI models `v0-1.5-md`, `v0-1.5-lg`, and `v0-1.0-md` in [v0](https://v0.app/). Today, we're sharing a deep dive into the composite model architecture behind those models. They combine specialized knowledge from retrieval-augmented generation (RAG), reasoning from state-of-the-art large language models (LLMs), and error fixing from a custom streaming post-processing model.

我们近期已在 [v0](https://v0.app/) 平台上发布了 AI 模型 `v0-1.5-md`、`v0-1.5-lg` 和 `v0-1.0-md`。今天，我们将深入剖析支撑这些模型的复合式模型架构。该架构融合了检索增强生成（RAG）所提供的领域专业知识、前沿大语言模型（LLM）所具备的推理能力，以及一个定制化流式后处理模型所实现的错误修正能力。

While this may sound complex, it enables v0 to achieve significantly higher quality when generating code. Further, as base models improve, we can quickly upgrade to the latest frontier model while keeping the rest of the architecture stable.

尽管这听起来较为复杂，但它使 v0 在代码生成任务中实现了显著更高的质量。此外，随着基础模型持续演进，我们可快速将底层模型升级至最新一代前沿模型，同时保持其余架构组件稳定不变。

## Why does v0 need a composite model architecture?

## 为何 v0 需要采用复合式模型架构？

Most AI models¹ are one of two things: a proprietary model from a frontier model provider or an open-source model from a third-party host.

当前绝大多数 AI 模型¹ 属于以下两类之一：由前沿模型提供商开发的专有模型，或由第三方托管的开源模型。

While building AI products like v0 and tools like the AI SDK, we’ve found limitations with both of these approaches:

在构建 v0 等 AI 产品以及 AI SDK 等工具的过程中，我们发现上述两种路径均存在明显局限性：

1. Model knowledge can quickly become outdated for topics that change fast  
1. 对于更新迅速的领域，模型知识极易迅速过时；  

2. Frontier model labs don’t have the resources or desire to focus on specific use cases like building web apps  
2. 前沿模型实验室既缺乏资源，也无意专注于构建网页应用等特定使用场景。

v0 specializes in building fast, beautiful full-stack web applications. To do so, we leverage the libraries and frameworks that make up the web ecosystem. Projects like React and Next.js are constantly evolving, and proprietary frontier models almost immediately fall behind on framework updates.

v0 专注于构建快速、美观的全栈网页应用。为此，我们深度依赖构成 Web 生态系统的各类库与框架。诸如 React 和 Next.js 等项目持续快速迭代，而专有前沿模型往往在框架更新发布后几乎立刻便陷入滞后状态。

Fine-tuning open-source models offers more flexibility, but as of today, proprietary models outperform open models on tasks relevant to v0 by a wide margin, especially code generation with multimodal input.

对开源模型进行微调虽提供了更高灵活性，但截至今日，专有模型在 v0 所关注的核心任务（尤其是支持多模态输入的代码生成）上，仍大幅领先于开源模型。

Frontier models also have little reason to focus on goals unique to building web applications like fixing errors automatically or editing code quickly. You end up needing to prompt them through every change, even for small corrections.

前沿模型也几乎没有动力去专注于构建 Web 应用所特有的目标，例如自动修复错误或快速编辑代码。结果是，你不得不通过提示词引导模型完成每一次修改，哪怕是微小的修正。

Our composite model architecture lets us decouple these pieces from the base model. We can pair a state-of-the-art base model with specialized data retrieval, an optimized Quick Edit pipeline, and a custom AutoFix model to improve output.

我们的复合模型架构使我们能够将这些功能模块与基础模型解耦。我们可以将最先进的基础模型，与专用的数据检索能力、经过优化的“快速编辑（Quick Edit）”流水线，以及定制化的 AutoFix 模型相结合，从而提升输出质量。

This allows us to adopt new state-of-the-art base models as they are released without needing to rewrite every step of the process. When you use a v0 model through our API, you get access to this entire pipeline.

这使我们能够在新一代最先进基础模型发布时，无缝集成它们，而无需重写整个流程的每一步。当你通过我们的 API 调用 v0 模型时，即可直接使用这一整套流水线。

![](images/introducing-the-v0-composite-model-family-vercel/img_001.jpg)![](images/introducing-the-v0-composite-model-family-vercel/img_002.jpg)![](images/introducing-the-v0-composite-model-family-vercel/img_003.jpg)![](images/introducing-the-v0-composite-model-family-vercel/img_004.jpg)

## How does v0’s composite model work?

## v0 复合模型是如何工作的？

**Pre-processing**

**预处理**

When you send a message to v0, we take a number of steps to prepare input before making a model call.

当你向 v0 发送一条消息时，我们会执行多个步骤，在调用模型前对输入进行预处理。

First, v0’s system prompt defines v0’s response format and includes information about v0’s capabilities. We also include recent messages from your chat to maintain continuity, and summaries of older ones to optimize the context window.

首先，v0 的系统提示词（system prompt）定义了其响应格式，并包含有关 v0 能力的信息；我们还会加入你对话中最近的消息以保持上下文连贯性，并对更早的历史消息生成摘要，以优化上下文窗口的使用效率。

Finally, we retrieve additional context based on your query from our own dataset, pulling from documentation, UI examples, your uploaded project sources, internal Vercel knowledge, and other sources to improve v0's output.

最后，我们基于你的查询，从自有数据集中检索额外上下文信息——来源包括文档、UI 示例、你上传的项目源码、Vercel 内部知识以及其他相关资源，从而进一步提升 v0 的输出质量。

**State of the art base models**

**业界领先的基础模型**

For new generations or large-scale changes, our base model handles the generation task. This is a high-capability model chosen from the current set of frontier models, depending on which v0 model you're using.

对于全新生成任务或大规模变更，我们的基础模型负责执行生成任务。该模型是从当前前沿模型集合中精选出的高能力模型，具体选用哪一个取决于您所使用的 v0 模型版本。

For smaller edits, parts of your request are routed to our Quick Edit model that is optimized for speed. Quick Edit is optimal for tasks with narrow scope, like updating text, fixing syntax errors, or reordering components.

对于较小范围的编辑，您请求中的部分任务会被路由至我们专为速度优化的 Quick Edit 模型。Quick Edit 最适合处理范围较窄的任务，例如更新文本、修复语法错误，或重新排列组件。

Because of v0’s composite architecture, base models can be updated or replaced as new models become available without needing to rebuild the entire model pipeline. For example, `v0-1.0-md` currently uses Anthropic's Sonnet 3.7 while `v0-1.5-md` uses Sonnet 4. The composite model architecture allowed us to upgrade the base model while keeping the rest of the stack stable.

得益于 v0 的复合式架构，基础模型可在新型号发布后直接更新或替换，而无需重建整个模型流水线。例如，`v0-1.0-md` 当前使用 Anthropic 的 Sonnet 3.7，而 `v0-1.5-md` 已升级为 Sonnet 4。这种复合模型架构使我们得以在保持其余技术栈稳定的同时，单独升级基础模型。

**Custom AutoFix model**

**自定义 AutoFix 模型**

While the base model streams output, v0 is constantly checking the output stream for errors, inconsistencies, and best practice violations. Our custom AutoFix model handles many of these issues mid-stream to further improve output quality.

在基础模型流式输出过程中，v0 会持续监测输出流，识别其中的错误、不一致之处及违背最佳实践的情况。我们的自定义 AutoFix 模型可在输出流传输过程中实时处理大量此类问题，从而进一步提升输出质量。

Once the model finishes streaming, we run a final pass to catch any remaining issues that couldn’t be detected mid-stream. We also run a linter on your final output to catch and fix style inconsistencies and simple errors.

当模型完成流式输出后，我们会执行一次最终校验，以捕获所有在流式传输过程中未能识别的遗留问题。此外，我们还会对您的最终输出运行代码检查器（linter），用于发现并修正风格不一致及简单错误。

## How do v0 models perform?

## v0 模型的实际表现如何？

One of our primary evaluations for v0 models measures how often their generations result in errors. We’ve designed evaluation sets from common web development tasks and measure the rate at which models can produce error-free code while performing them. From our benchmarks, v0 models substantially outperform their base model counterparts.

我们对 v0 模型的一项核心评估指标是其生成结果的出错频率。我们基于常见的网页开发任务构建了评测数据集，并统计各模型在执行这些任务时生成零错误代码的比例。根据我们的基准测试结果，v0 模型的表现显著优于其对应的基础模型。

|     |     |
| --- | --- |
| **Model** | **Error-free generation rate** |
| **模型** | **零错误生成率（%）** |
| v0-1.5-md | 93.87 |
| v0-1.5-lg | 89.80 |
| claude-4-opus-20250514 | 78.43 |
| claude-4-sonnet-20250514 | 64.71 |
| gemini-2.5-flash-preview-05-20 | 60.78 |
| gemini-2.5-pro-preview-05-06 | 58.82 |
| o3 | 58.82 |
| gpt-4.1 | 58.82 |

`v0-1.5-lg` is a bigger model than `v0-1.5-md` but can make more mistakes, a common tradeoff in scaling AI models.

`v0-1.5-lg` 是比 `v0-1.5-md` 更大的模型，但出错概率也相对更高——这正是 AI 模型规模化扩展过程中常见的性能权衡。

While error rates are similar across `v0-1.5-md` and `v0-1.5-lg`, we’ve found that `v0-1.5-lg` is better at reasoning about hyper-specialized fields like physics engines in three.js and multi-step tasks like database migrations. `v0-1.5-lg` also supports a much larger context window.

尽管 `v0-1.5-md` 与 `v0-1.5-lg` 的错误率相近，但我们发现 `v0-1.5-lg` 在推理高度专业化的领域（例如 three.js 中的物理引擎）以及多步骤任务（例如数据库迁移）方面表现更优。此外，`v0-1.5-lg` 支持显著更大的上下文窗口。

## Training our own AutoFix model

## 训练我们自有的 AutoFix 模型

Language models are stochastic, and each one comes with its own quirks. Some consistently over-format with markdown, others misplace files or introduce subtle bugs. We use a comprehensive set of evals, along with feedback from [v0.dev](http://v0.dev/) users, to track these patterns and identify areas where output consistently needs correction.

语言模型具有随机性，每种模型都有其自身的特点与缺陷：有些模型会过度使用 Markdown 格式化，有些则会错误放置文件，或引入难以察觉的 Bug。我们通过一套全面的评估基准（evals），并结合来自 [v0.dev](http://v0.dev/) 用户的反馈，持续追踪这些模式，识别出输出中反复出现、亟需修正的问题区域。

These issues led us to build a pipeline that combines deterministic rules with AI-based corrections to catch and fix common errors during generation. Early versions of this pipeline relied on Gemini Flash 2.0.

上述问题促使我们构建了一套融合确定性规则与 AI 驱动修正的处理流水线，用以在代码生成过程中实时捕获并修复常见错误。该流水线的早期版本依赖于 Gemini Flash 2.0。

To improve both speed and reliability, we trained our own custom AutoFix model, `vercel-autofixer-01`, in conjunction with Fireworks AI using reinforcement fine-tuning (RFT). Over the course of multiple training iterations, we optimized the AutoFix model to minimize error rates across a variety of tracked categories.

为同时提升处理速度与可靠性，我们联合 Fireworks AI，采用强化微调（Reinforcement Fine-Tuning, RFT）方法，训练了专属的 AutoFix 模型 `vercel-autofixer-01`。经过多轮训练迭代，我们持续优化该模型，使其在各类已追踪的错误类别中均实现错误率最小化。

**Performance optimization over training iterations**

**训练迭代过程中的性能优化**

![Each line represents a different error type being minimized during model training.](images/introducing-the-v0-composite-model-family-vercel/img_005.jpg)![Each line represents a different error type being minimized during model training.](images/introducing-the-v0-composite-model-family-vercel/img_006.jpg)![Each line represents a different error type being minimized during model training.](images/introducing-the-v0-composite-model-family-vercel/img_005.jpg)![Each line represents a different error type being minimized during model training.](images/introducing-the-v0-composite-model-family-vercel/img_006.jpg)

![每条曲线代表模型训练过程中被最小化的一种错误类型。](images/introducing-the-v0-composite-model-family-vercel/img_005.jpg)![每条曲线代表模型训练过程中被最小化的一种错误类型。](images/introducing-the-v0-composite-model-family-vercel/img_006.jpg)![每条曲线代表模型训练过程中被最小化的一种错误类型。](images/introducing-the-v0-composite-model-family-vercel/img_005.jpg)![每条曲线代表模型训练过程中被最小化的一种错误类型。](images/introducing-the-v0-composite-model-family-vercel/img_006.jpg)

Each line represents a different error type being minimized during model training.

每条曲线代表模型训练过程中被最小化的一种错误类型。

`vercel-autofixer-01` was designed to quickly apply fixes while reducing error rates. On our error incidence evals, it performs at par with gpt-4o-mini and gemini-2.5-flash, while running 10 to 40 times faster.

`vercel-autofixer-01` 的设计目标是在降低错误率的同时实现快速修复。在我们的错误发生率评估（error incidence evals）中，其输出无错误率与 gpt-4o-mini 和 gemini-2.5-flash 相当，但运行速度却快出 10 至 40 倍。

|     |     |     |
| --- | --- | --- |
| **Model Name** | **Error-free output rate** | **Chars/Sec** |
| **模型名称** | **无错误输出率** | **字符/秒** |
| vercel-autofixer-01 | 86.14 | 8,130.01 |
| gemini-2.5-flash-preview-05-20 | 89.55 | 559.05 |
| gpt-4o-mini | 83.33 | 238.9 |
| gpt-4.1-nano | 79.31 | 374.26 |
| gemini-2.0-flash | 70.3 | 627.47 |
| claude-3-5-haiku-20241922 | 61.03 | 246.05 |
| gemini-2.0-flash-lite | 26.67 | 733.55 |

## What’s next?

## 接下来是什么？

The v0 model family is available via API and in [v0.dev](https://v0.dev/). You can [use v0 models in your favorite editors](https://vercel.com/docs/v0/cursor), or build custom workflows. For instance, you can [leverage v0 to write scripts tailored to automated code migration](https://x.com/rauchg/status/1926478569892348216). We’ll continue to improve our model output and release new model classes in the upcoming months.

v0 模型系列已通过 API 及 [v0.dev](https://v0.dev/) 网站提供。您可[在您最喜爱的编辑器中使用 v0 模型](https://vercel.com/docs/v0/cursor)，或构建自定义工作流。例如，您可[利用 v0 编写专用于自动化代码迁移的脚本](https://x.com/rauchg/status/1926478569892348216)。我们将在未来几个月持续优化模型输出，并发布新的模型类别。

¹: A notable exception is [Perplexity Sonar](https://ai-sdk.dev/providers/ai-sdk-providers/perplexity), an "online" model.

¹：一个显著的例外是 [Perplexity Sonar](https://ai-sdk.dev/providers/ai-sdk-providers/perplexity)，一种“在线”模型。