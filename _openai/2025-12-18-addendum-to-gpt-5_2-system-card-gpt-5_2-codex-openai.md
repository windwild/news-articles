---
title: "Addendum to GPT-5.2 System Card: GPT-5.2-Codex | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/gpt-5-2-codex-system-card"
date: "2025-12-18"
scraped_at: "2026-03-02T10:08:38.498320543+00:00"
language: "en-US"
translated: true
description: "This system card outlines the comprehensive safety measures implemented for GPT‑5.2-Codex. It details both model-level mitigations, such as specialized safety training for harmful tasks and prompt i..."
tags: ["Publication"]
---
&#123;% raw %}

December 18, 2025

2025年12月18日

[Publication](https://openai.com/research/index/publication/) [Safety](https://openai.com/news/safety-alignment/)

[出版物](https://openai.com/research/index/publication/) [安全](https://openai.com/news/safety-alignment/)

# Addendum to GPT‑5.2 System Card: GPT‑5.2‑Codex

# GPT‑5.2 系统卡附录：GPT‑5.2‑Codex

[Read the System Card(opens in a new window)](https://deploymentsafety.openai.com/gpt-5-2-codex)

[查看系统卡（在新窗口中打开）](https://deploymentsafety.openai.com/gpt-5-2-codex)

## Introduction

## 引言

GPT‑5.2‑Codex is our most advanced agentic coding model yet for complex, real-world software engineering. A version of [GPT‑5.2⁠](https://openai.com/index/introducing-gpt-5-2/) optimized for agentic coding in Codex, it includes further improvements on long-horizon work through context compaction, stronger performance on project-scale tasks like refactors and migrations, and improved performance in Windows environments—and significantly stronger cybersecurity capabilities.

GPT‑5.2‑Codex 是我们迄今最先进、面向复杂现实世界软件工程的智能体式编程模型。它是 [GPT‑5.2⁠](https://openai.com/index/introducing-gpt-5-2/) 的一个专门针对 Codex 平台智能体式编程任务优化的版本，通过上下文压缩技术进一步提升了长周期任务处理能力，在重构、迁移等项目级任务上表现更优，在 Windows 环境下的运行性能也得到改善——尤其显著增强了网络安全能力。

This system card outlines the comprehensive safety measures implemented for GPT‑5.2‑Codex. It details both model-level mitigations, such as specialized safety training for harmful tasks and prompt injections, and product-level mitigations like agent sandboxing and configurable network access.

本系统卡概述了为 GPT‑5.2‑Codex 实施的全面安全措施，既涵盖模型层面的缓解策略（例如针对有害任务与提示注入的专项安全训练），也包括产品层面的防护机制（例如智能体沙箱隔离与可配置的网络访问控制）。

GPT‑5.2‑Codex was evaluated under our Preparedness Framework. It is very capable in the cybersecurity domain but does not reach High capability on cybersecurity. We expect current trends of rapidly increasing capability to continue, and for models to cross the High cybersecurity threshold in the near future. Like other recent models, it is being treated as High capability on biology, and is being deployed with the corresponding suite of safeguards we use for other models in the GPT‑5 family. It does not reach High capability on AI self-improvement.

GPT‑5.2‑Codex 已依据我们的“就绪性框架”（Preparedness Framework）完成评估。该模型在网络安全领域能力极强，但尚未达到“高能力”（High capability）等级；我们预计当前能力快速提升的趋势将持续，模型有望在近期跨越网络安全领域的“高能力”阈值。与其他近期发布的模型类似，GPT‑5.2‑Codex 在生物学领域被认定为具备“高能力”，因此部署时将启用 GPT‑5 系列其他模型所采用的全套对应安全防护措施。该模型在 AI 自我改进领域尚未达到“高能力”等级。

- [2025](https://openai.com/research/index/?tags=2025)
- [System Cards](https://openai.com/research/index/?tags=system-cards)

- [2025](https://openai.com/research/index/?tags=2025)
- [系统卡](https://openai.com/research/index/?tags=system-cards)
&#123;% endraw %}
