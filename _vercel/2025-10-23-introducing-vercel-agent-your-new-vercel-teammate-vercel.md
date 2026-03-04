---
render_with_liquid: false
title: "Introducing Vercel Agent: Your new Vercel teammate - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-vercel-agent"
date: "2025-10-23"
scraped_at: "2026-03-02T09:26:41.542636155+00:00"
language: "en-zh"
translated: true
description: "Vercel Agent provides AI-powered code reviews and production investigations, delivering accurate, context-aware insights to help you ship reliable software."
---
render_with_liquid: false
render_with_liquid: false

Oct 23, 2025

2025 年 10 月 23 日

我们正式推出 Vercel Agent —— 您开发工作流中的 AI 同事。Vercel Agent 融合人工智能、深厚的平台专业知识、您的应用代码，以及来自整个 Vercel 平台的遥测数据，助您以更高品质更快交付产品。

即日起，Vercel Agent 进入公开测试阶段（Public Beta），首发两大核心能力：**代码审查（Code Review）** 与 **问题排查（Investigations）**。

## 什么是 Vercel Agent

## 什么是 Vercel Agent

[Vercel Agent](https://vercel.com/agent) 是一款多用途智能体（agent），其能力将随时间持续扩展与增强。Agent 提出的每一条建议、每一次问题排查，均经过端到端验证，并基于对您项目代码、所用框架及基础设施的深度理解而生成。Agent 提供的是经过验证、可直接落地的优化方案，而非未经证实的推测性输出。

## 代码审查：由 AI 驱动的 Pull Request 审查

## Code Review: AI-powered pull request reviews

Vercel Agent 的“代码审查”能力直接集成于您的 GitHub 工作流中，在保障审查质量的同时显著提升协作效率。它以一位熟悉您全栈技术栈的同事般的深度审查代码，并在 Vercel Sandbox 中运行模拟构建，确保所有建议在呈现给您之前均已通过实际验证——您收到的绝非未经测试的猜测，而是每一项都经严格验证的可靠建议。

Agent 执行一套多步骤推理流程，全面分析代码变更（diffs）、依赖关系及项目中各类框架模式；同时参考代码规范（lint）与测试结果，执行定向验证，并自动生成符合框架层面校验要求的 Pull Request 反馈。最终产出的审查意见具备高度上下文感知能力，深刻反映您的应用在生产环境中的真实运行逻辑。

在实际开发中，这意味着无需妥协即可实现更快速的合并。Agent 能在问题合入前识别潜在回归、发现代码检查工具（linter）遗漏的性能隐患，并推荐安全、开箱即用的生产级修复方案。对开发者而言，这就像拥有一位从不丢失上下文、且始终会验证自身建议的资深审阅者。

![高信噪比、非高信息量的 Pull Request 反馈：Vercel Agent 的每条建议均在真实上下文中完成验证，并于 Sandbox 中实测通过。](images/introducing-vercel-agent-your-new-vercel-teammate-vercel/img_001.jpg)  
![高信噪比、非高信息量的 Pull Request 反馈：Vercel Agent 的每条建议均在真实上下文中完成验证，并于 Sandbox 中实测通过。](images/introducing-vercel-agent-your-new-vercel-teammate-vercel/img_002.jpg)  
Pull request 反馈追求高信噪比，而非高信息量。Vercel Agent 的每一条建议均在真实上下文中完成验证，并于 Sandbox 中实测通过。

## Investigations: AI-powered debugging for production issues

## 调查功能：面向生产问题的 AI 驱动调试

Announced today, Investigations extends that same reasoning to your application's runtime.

今日正式发布——“调查功能”（Investigations）将同样的推理能力延伸至您应用的运行时环境。

Triggered by unusual application activity, Agent analyzes real-time and historical data to uncover why an event occurred. Powered by Framework-defined infrastructure, Agent has deep context about your application, allowing it to interpret the full underlying data and identify why something spiked, slowed, failed, or changed unexpectedly.

当检测到异常应用行为时，Vercel Agent 会自动触发，实时分析当前与历史数据，以揭示事件成因。依托框架定义的基础设施，Agent 深度理解您的应用上下文，因而能够全面解读底层数据，精准定位性能突增、响应变慢、服务失败或行为异常的根本原因。

Investigations will explore questions like why a deployment slowed down, which function is throwing errors in production, and what changed between any two builds to quickly understand the root cause and provide actionable next steps when available.

调查功能将深入探究各类关键问题：例如某次部署为何变慢、生产环境中哪个函数持续抛出错误、任意两次构建之间发生了哪些变更——从而快速定位根因，并在可行时提供切实可行的后续操作建议。

Each investigation is grounded in the actual state of your app. Not guesses, but validated analysis.

每一次调查均基于您应用的真实运行状态展开——不是凭空猜测，而是经过验证的严谨分析。

For engineering teams, Investigations turn what used to be hours of debugging into a few seconds of reasoning. It transforms observability from a maze of dashboards into a simple conversation, helping you fix problems faster and understand your system more deeply.

对工程团队而言，调查功能将过去耗时数小时的调试工作，压缩为几秒钟的智能推理。它将原本如迷宫般繁杂的仪表盘式可观测性，转变为一场简洁直观的对话，助您更快修复问题，并更深入地理解系统行为。

![When anomalies occur, Vercel Agent investigates automatically to separate signal from noise, surface what deserves your attention, and suggest next steps. ](images/introducing-vercel-agent-your-new-vercel-teammate-vercel/img_003.jpg)![When anomalies occur, Vercel Agent investigates automatically to separate signal from noise, surface what deserves your attention, and suggest next steps. ](images/introducing-vercel-agent-your-new-vercel-teammate-vercel/img_004.jpg)When anomalies occur, Vercel Agent investigates automatically to separate signal from noise, surface what deserves your attention, and suggest next steps.

![当异常发生时，Vercel Agent 自动启动调查，帮助您区分信号与噪声，凸显值得关注的关键信息，并建议后续操作步骤。](images/introducing-vercel-agent-your-new-vercel-teammate-vercel/img_003.jpg)![当异常发生时，Vercel Agent 自动启动调查，帮助您区分信号与噪声，凸显值得关注的关键信息，并建议后续操作步骤。](images/introducing-vercel-agent-your-new-vercel-teammate-vercel/img_004.jpg)当异常发生时，Vercel Agent 自动启动调查，帮助您区分信号与噪声，凸显值得关注的关键信息，并建议后续操作步骤。

## **What’s next**

## **下一步计划**

Vercel Agent represents our first product in a new category: Agent-as-a-Service. Just as Software-as-a-Service abstracted the complexity of infrastructure, Agent-as-a-Service means you can rely on a production-grade agent that runs securely on your behalf. You don't need to build or host it yourself. It works for you, seamlessly integrated into your workflow. We're making it even easier to get started with our [agentic marketplace](https://vercel.com/marketplace/category/agents), also available today.

Vercel Agent 是我们推出的全新产品类别——“Agent-as-a-Service”（Agent 即服务）的首款产品。正如软件即服务（SaaS）抽象并简化了基础设施的复杂性，“Agent 即服务”意味着您可以信赖一个企业级、安全可靠、代表您运行的智能 Agent。您无需自行开发或托管；它已深度集成于您的工作流中，为您无缝服务。我们还同步上线了 [Agent 市场（agentic marketplace）](https://vercel.com/marketplace/category/agents)，让上手使用更加轻松便捷。

With Code Review and Investigations available today, Vercel Agent is already changing how teams ship. But this is just the beginning. Soon, Agent will go beyond identifying and diagnosing issues. It will create pull requests, propose fixes, and automate the workflow from detection to deployment.

随着代码审查（Code Review）与调查功能（Investigations）今日全面可用，Vercel Agent 已开始重塑团队交付软件的方式。但这仅仅是个开端。很快，Agent 将不再局限于识别与诊断问题——它还将自动生成 Pull Request、提出修复方案，并实现从问题发现到最终部署的全流程自动化。

Vercel Agent is not just another AI tool. It is a teammate that understands your stack, your context, and your goals. It's built on the same infrastructure that powers Vercel itself, giving you the confidence to move fast without cutting corners.

Vercel Agent 不只是一款普通的 AI 工具，它更是懂你技术栈、懂你上下文、也懂你目标的团队成员。它构建于支撑 Vercel 自身运行的同一套基础设施之上，让你在疾速推进的同时，无需牺牲质量与可靠性。

The future of building is not just faster. It is smarter.

构建的未来，不仅在于更快，更在于更智能。

[**Start using Vercel Agent today**\\
\\
See how it feels to work with AI that truly ships with you. \\
\\
Try Vercel Agent](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fvercel-agent)

[**今天就开始使用 Vercel Agent**\\
\\
亲身体验与真正“与你并肩交付”的 AI 协作是什么感觉。\\
\\
立即试用 Vercel Agent](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fvercel-agent)