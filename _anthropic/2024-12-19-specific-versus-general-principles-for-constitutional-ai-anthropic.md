---
title: "Specific versus General Principles for Constitutional AI \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/specific-versus-general-principles-for-constitutional-ai"
date: "2024-12-19"
scraped_at: "2026-03-03T06:54:47.524907164+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
&#123;% raw %}

AlignmentResearch

# Specific versus General Principles for Constitutional AI

# 宪法 AI 中的具体原则与一般原则

Oct 24, 2023

2023 年 10 月 24 日

[Read Paper](https://arxiv.org/abs/2310.13798)

[阅读论文](https://arxiv.org/abs/2310.13798)

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——这是衡量当今人类如何与 AI 协作的一项基准指标。

## Abstract

## 摘要

Human feedback can prevent overtly harmful utterances in conversational models, but may not automatically mitigate subtle problematic behaviors such as a stated desire for self-preservation or power. Constitutional AI offers an alternative, replacing human feedback with feedback from AI models conditioned only on a list of written principles. We find this approach effectively prevents the expression of such behaviors. The success of simple principles motivates us to ask: can models learn general ethical behaviors from only a single written principle? To test this, we run experiments using a principle roughly stated as "do what's best for humanity." We find that the largest dialogue models can generalize from this short constitution, resulting in harmless assistants with no stated interest in specific motivations like power. A general principle may thus partially avoid the need for a long list of constitutions targeting potentially harmful behaviors. However, more detailed constitutions still improve fine-grained control over specific types of harms. This suggests both general and specific principles have value for steering AI safely.

人类反馈可防止对话模型输出明显有害的语句，但未必能自动缓解一些隐性的、有问题的行为（例如明确表达出自保或攫取权力的意愿）。宪法 AI（Constitutional AI）提供了一种替代方案：以仅基于一组书面原则进行条件化训练的 AI 模型所生成的反馈，取代人类反馈。我们发现，该方法能有效阻止上述行为的表达。简单原则的成功促使我们提出一个问题：模型能否仅从一条书面原则中学习到普遍的伦理行为？为验证这一点，我们开展了一系列实验，所采用的原则大致表述为：“做对人类最有利之事”。结果表明，最大的对话模型能够从这条简短的“宪法”中进行泛化，从而生成无害的助手，且这些助手不会明确表现出对权力等特定动机的兴趣。因此，一条一般性原则或许能在一定程度上避免罗列大量针对性宪法以防范各类潜在危害的需要。然而，更详尽的宪法仍有助于在特定类型危害上实现更精细的管控。这表明，一般性原则与具体原则对于安全引导 AI 均具有重要价值。
&#123;% endraw %}
