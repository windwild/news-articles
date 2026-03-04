---
title: "Introducing GPT-5.3-Codex-Spark | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/introducing-gpt-5-3-codex-spark"
date: "2026-02-12"
scraped_at: "2026-03-02T10:08:20.135809013+00:00"
language: "en-US"
translated: true
description: "Introducing GPT-5.3-Codex-Spark—our first real-time coding model. 15x faster generation, 128k context, now in research preview for ChatGPT Pro users."
tags: ["Product"]
---
&#123;% raw %}

February 12, 2026

2026年2月12日

[Product](https://openai.com/news/product-releases/) [Release](https://openai.com/research/index/release/) [Company](https://openai.com/news/company-announcements/)

[产品动态](https://openai.com/news/product-releases/) [发布信息](https://openai.com/research/index/release/) [公司公告](https://openai.com/news/company-announcements/)

# Introducing GPT‑5.3‑Codex‑Spark

# 推出 GPT‑5.3‑Codex‑Spark

An ultra-fast model for real-time coding in Codex.

一款专为 Codex 实时编程打造的超高速模型。

[Join the Codex app waitlist](https://openai.com/form/codex-app/)

[加入 Codex 应用等待名单](https://openai.com/form/codex-app/)

Today, we’re releasing a research preview of GPT‑5.3‑Codex‑Spark, a smaller version of GPT‑5.3‑Codex, and our first model designed for real-time coding. Codex-Spark marks the first milestone in our partnership with Cerebras, which [we announced in January⁠](https://openai.com/index/cerebras-partnership/). Codex-Spark is optimized to feel near-instant when served on ultra-low latency hardware—delivering more than 1000 tokens per second while remaining highly capable for real-world coding tasks.

今天，我们面向开发者推出 GPT‑5.3‑Codex‑Spark 的研究预览版——这是 GPT‑5.3‑Codex 的轻量级版本，也是我们首款专为实时编程设计的大模型。Codex-Spark 标志着我们与 Cerebras 合作的重要里程碑，该合作已于[今年一月正式宣布](https://openai.com/index/cerebras-partnership/)。Codex-Spark 针对超低延迟硬件进行了深度优化，响应近乎瞬时——在保持强大现实编码能力的同时，可实现每秒输出超过 1000 个 token。

We’re sharing Codex-Spark on Cerebras as a research preview to ChatGPT Pro users so that developers can start experimenting early while we work with Cerebras to ramp up datacenter capacity, harden the end-to-end user experience, and deploy our larger frontier models.

我们将通过 Cerebras 平台向 ChatGPT Pro 用户开放 Codex-Spark 的研究预览版，以便开发者尽早开展实验；与此同时，我们正与 Cerebras 紧密协作，持续扩充数据中心算力、全面加固端到端用户体验，并部署更大规模的前沿模型。

Our latest frontier models have shown particular strengths in their ability to do long-running tasks, working autonomously for hours, days or weeks without intervention. Codex-Spark is our first model designed specifically for working with Codex in real-time—making targeted edits, reshaping logic, or refining interfaces and seeing results immediately. With Codex-Spark, Codex now supports both long-running, ambitious tasks and getting work done in the moment. We hope to learn from how developers use it and incorporate feedback as we continue to expand access.

我们最新一代前沿模型在执行长时间任务方面展现出突出优势，可自主运行数小时、数天乃至数周而无需人工干预。Codex-Spark 则是我们首款专为 Codex 实时协同而设计的模型——支持精准编辑、逻辑重构、界面优化等操作，并即时呈现结果。借助 Codex-Spark，Codex 现已同时支持两类关键场景：一是耗时长、目标宏大的复杂任务；二是即刻响应、立竿见影的即时开发工作。我们期待从开发者的真实使用中汲取经验，并将宝贵反馈融入后续迭代，逐步扩大访问范围。

At launch, Codex-Spark has a 128k context window and is text-only. During the research preview, Codex-Spark will have its own rate limits and usage will not count towards standard rate limits. However, when demand is high, you may see limited access or temporary queuing as we balance reliability across users.

首发版本中，Codex-Spark 支持 128K 上下文窗口，且仅支持文本输入。在研究预览阶段，Codex-Spark 将启用独立的调用频率限制，其用量不计入标准配额。但当请求量激增时，为保障全体用户的系统稳定性，您可能会遇到访问受限或临时排队的情况。

## Speed and intelligence

## 速度与智能

Codex-Spark is optimized for interactive work where latency matters as much as intelligence. You can collaborate with the model in real time, interrupting or redirecting it as it works, and rapidly iterate with near-instant responses. Because it’s tuned for speed, Codex-Spark keeps its default working style lightweight: it makes minimal, targeted edits and doesn’t automatically run tests unless you ask it to.

Codex-Spark 针对交互式工作场景进行了优化，在此类场景中，延迟与智能同等重要。您可以实时与模型协同工作——在它运行过程中随时中断或调整其方向，并借助近乎即时的响应快速迭代。由于专为速度而调优，Codex-Spark 默认采用轻量级工作模式：仅执行最少、最精准的编辑操作；除非您明确要求，否则不会自动运行测试。

00:00

00:00

## Coding

## 编程能力

Codex-Spark is a highly capable small model optimized for fast inference. On SWE-Bench Pro and Terminal-Bench 2.0, two benchmarks evaluating agentic software engineering capability, GPT‑5.3‑Codex‑Spark demonstrates strong performance while accomplishing the tasks in a fraction of the time compared to GPT‑5.3‑Codex.

Codex-Spark 是一款能力卓越的小型模型，专为高速推理而优化。在评估智能体式软件工程能力的两大基准测试——SWE-Bench Pro 和 Terminal-Bench 2.0 上，GPT-5.3-Codex-Spark 展现出强劲性能，完成任务所耗时间仅为 GPT-5.3-Codex 的一小部分。

SWE-Bench Pro

SWE-Bench Pro

024681012141618Task duration (minutes)30%40%50%60%AccuracyGPT-5.3-Codex-SparkGPT-5.3-CodexGPT-5.1-Codex-mini

024681012141618任务耗时（分钟）30%40%50%60%准确率GPT-5.3-Codex-SparkGPT-5.3-CodexGPT-5.1-Codex-mini

Duration is estimated as the sum of (1) output generation time (output tokens ÷ sampling speed), (2) prefill time (prefill tokens ÷ prefill speed), (3) total tool execution time, and (4) total network overhead.

耗时估算公式为：(1) 输出生成时间（输出 token 数 ÷ 采样速度） + (2) 预填充时间（预填充 token 数 ÷ 预填充速度） + (3) 所有工具执行总耗时 + (4) 全部网络开销。

Terminal-Bench 2.0

Terminal-Bench 2.0

GPT-5.3-Codex-SparkGPT-5.3-CodexGPT-5.1-Codex-mini0%20%40%60%80%Accuracy58.4%77.3%46.1%

GPT-5.3-Codex-SparkGPT-5.3-CodexGPT-5.1-Codex-mini0%20%40%60%80%准确率58.4%77.3%46.1%

## Latency improvements for all models

## 所有模型的延迟优化

As we trained Codex-Spark, it became apparent that model speed was just part of the equation for real-time collaboration—we also needed to reduce latency across the full request-response pipeline. We implemented end-to-end latency improvements in our harness that will benefit all models. Under the hood, we streamlined how responses stream from client to server and back, rewrote key pieces of our inference stack, and reworked how sessions are initialized so that the first visible token appears sooner and Codex stays responsive as you iterate. Through the introduction of a persistent WebSocket connection and targeted optimizations inside of Responses API, we reduced overhead per client/server roundtrip by 80%, per-token overhead by 30%, and time-to-first-token by 50%. The WebSocket path is enabled for Codex-Spark by default and will become the default for all models soon.

在训练 Codex-Spark 的过程中，我们逐渐意识到：模型本身的推理速度仅是实现实时协作的一部分；我们还需全面降低整个请求-响应链路的延迟。为此，我们在底层运行框架（harness）中实施了端到端的延迟优化，这些改进将惠及所有模型。具体而言，我们优化了响应在客户端与服务器之间的流式传输机制，重构了推理栈中的关键组件，并重新设计了会话初始化流程，使首个可见 token 更快呈现，同时确保你在迭代过程中 Codex 始终保持高度响应性。通过引入持久化 WebSocket 连接，并在 Responses API 内部进行针对性优化，我们将每次客户端/服务器往返通信的开销降低了 80%，每个 token 的处理开销降低了 30%，首 token 延迟（time-to-first-token）降低了 50%。目前，WebSocket 通信路径已默认启用在 Codex-Spark 上，并将在近期成为所有模型的默认通信方式。

## Powered by Cerebras

## 由 Cerebras 提供支持

Codex-Spark runs on Cerebras’ [Wafer Scale Engine 3⁠(opens in a new window)](https://www.cerebras.ai/chip)—a purpose-built AI accelerator for high-speed inference giving Codex a latency-first serving tier. We partnered with Cerebras to add this low-latency path to the same production serving stack as the rest of our fleet, so it works seamlessly across Codex and sets us up to support future models.

Codex-Spark 运行于 Cerebras 公司的 [晶圆级引擎 3（Wafer Scale Engine 3）⁠(在新窗口中打开)](https://www.cerebras.ai/chip)——这是一款专为高速推理打造的人工智能加速器，为 Codex 构建了以低延迟为首要目标的服务层级。我们与 Cerebras 合作，将这条低延迟通路无缝集成至与现有全部模型共用的生产级服务栈中，从而确保其在 Codex 全系列产品中一致、可靠地运行，并为未来模型的支持奠定坚实基础。

> “What excites us most about GPT-5.3-Codex-Spark is partnering with OpenAI and the developer community to discover what fast inference makes possible—new interaction patterns, new use cases, and a fundamentally different model experience. This preview is just the beginning.”

> “GPT-5.3-Codex-Spark 最令我们振奋之处，在于与 OpenAI 及广大开发者社区携手探索‘快速推理’所能开启的新可能——全新的交互范式、前所未有的应用场景，以及一种根本不同的模型使用体验。本次预览，仅仅是个开始。”

— Sean Lie, CTO and Co-Founder of Cerebras  
— Sean Lie，Cerebras 首席技术官兼联合创始人

GPUs remain foundational across our training and inference pipelines and deliver the most cost effective tokens for broad usage. Cerebras complements that foundation by excelling at workflows that demand extremely low latency, tightening the end-to-end loop so Codex feels more responsive as you iterate. GPUs and Cerebras can be combined for single workloads to reach the best performance.

GPU 仍是我们在训练与推理全流程中的核心基础设施，能以最具成本效益的方式提供大规模通用 token 服务。Cerebras 则在此基础上形成有力补充——它专精于对端到端延迟要求极高的工作负载，进一步收窄全链路响应周期，让你在编码迭代过程中切实感受到 Codex 更加迅捷流畅。针对单一任务负载，GPU 与 Cerebras 可协同部署，以实现最优综合性能。

## Availability & details

## 上线情况与详细信息

Codex-Spark is rolling out today as a research preview for ChatGPT Pro users in the latest versions of the Codex app, CLI, and VS Code extension. Because it runs on specialized low-latency hardware, usage is governed by a separate rate limit that may adjust based on demand during the research preview. In addition, we are making Codex-Spark available in the API for a small set of design partners to understand how developers want to integrate Codex-Spark into their products. We’ll expand access over the coming weeks as we continue tuning our integration under real workloads.

Codex-Spark 即日起面向 ChatGPT Pro 用户推出研究预览版，支持最新版本的 Codex 应用程序、命令行工具（CLI）及 VS Code 插件。由于其运行于专用的超低延迟硬件之上，其调用受独立的速率限制管控；该限制将在研究预览期间根据实际需求动态调整。此外，我们还面向一小批设计合作伙伴开放了 Codex-Spark 的 API 接入权限，旨在深入理解开发者希望如何将 Codex-Spark 集成至自身产品中。随着我们在真实工作负载下持续调优集成方案，我们将在未来数周内逐步扩大访问范围。

Codex-Spark is currently text-only at a 128k context window and is the first in a family of ultra-fast models. As we learn more with the developer community about where fast models shine for coding, we’ll introduce even more capabilities–including larger models, longer context lengths, and multimodal input.

当前，Codex-Spark 仅支持纯文本输入，上下文窗口为 128K，是“超高速模型”产品家族中的首款成员。随着我们与开发者社区共同探索快速模型在编程场景中的优势所在，后续将陆续推出更多能力——包括更大规模的模型、更长的上下文长度，以及多模态输入支持。

Codex-Spark includes the same safety training as our mainline models, including cyber-relevant training. We evaluated Codex-Spark as part of our standard deployment process, which includes baseline evaluations for cyber and other capabilities, and determined that it does not have a plausible chance of reaching our Preparedness Framework threshold for high capability in cybersecurity or biology.

Codex-Spark 与我们的主干模型一样，接受了相同的安全训练，包括面向网络安全的相关训练。我们在标准部署流程中对 Codex-Spark 进行了评估——该流程涵盖针对网络安全及其他能力的基线评估——并确认其在网络安全或生物学领域均无合理可能达到我们“准备就绪框架”（Preparedness Framework）所设定的高能力阈值。

## What’s next

## 下一步

Codex-Spark is the first step toward a Codex with two complementary modes: longer-horizon reasoning and execution, and real-time collaboration for rapid iteration. Over time, the modes will blend—Codex can keep you in a tight interactive loop while delegating longer-running work to sub-agents in the background, or fanning out tasks to many models in parallel when you want breadth and speed, so you don’t have to choose a single mode up front.

Codex-Spark 是迈向具备两种互补模式的 Codex 的第一步：一种是面向更长视野的推理与执行能力，另一种是支持快速迭代的实时协作能力。未来，这两种模式将逐步融合——Codex 可在保持紧密交互循环的同时，将耗时较长的任务委托给后台的子智能体（sub-agents）；当你需要广度与速度时，它亦可将任务并行分发至多个模型，从而让你无需在初始阶段就限定于某一种单一模式。

As models become more capable, interaction speed becomes a clear bottleneck. Ultra-fast inference tightens that loop, making Codex feel more natural to use and expanding what’s possible for anyone turning an idea into working software.

随着模型能力不断提升，交互速度正日益成为明显的瓶颈。超高速推理（ultra-fast inference）显著缩短了这一反馈闭环，使 Codex 的使用体验更加自然，并进一步拓展了任何一位将创意转化为可运行软件的开发者的可能性边界。

- [2026](https://openai.com/news/?tags=2026)  
- [2026](https://openai.com/news/?tags=2026)

- [Codex](https://openai.com/news/?tags=codex)  
- [Codex](https://openai.com/news/?tags=codex)
&#123;% endraw %}
