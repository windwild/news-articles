---
render_with_liquid: false
title: "Sleeper Agents: Training Deceptive LLMs that Persist Through Safety Training \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/sleeper-agents-training-deceptive-llms-that-persist-through-safety-training"
date: "2024-08-05"
scraped_at: "2026-03-03T07:09:32.737010624+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
render_with_liquid: false
render_with_liquid: false

AlignmentResearch

# Sleeper Agents: Training Deceptive LLMs that Persist Through Safety Training

# “沉睡特工”：训练能通过安全训练持续存在的欺骗性大语言模型

Jan 14, 2024

2024年1月14日

[Read Paper](https://arxiv.org/abs/2401.05566)

[阅读论文](https://arxiv.org/abs/2401.05566)

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。

Humans are capable of strategically deceptive behavior: behaving helpfully in most situations, but then behaving very differently in order to pursue alternative objectives when given the opportunity. If an AI system learned such a deceptive strategy, could we detect it and remove it using current state-of-the-art safety training techniques? To study this question, we construct proof-of-concept examples of deceptive behavior in large language models (LLMs). For example, we train models that write secure code when the prompt states that the year is 2023, but insert exploitable code when the stated year is 2024.

人类具备策略性欺骗行为的能力：在大多数情境下表现得乐于助人，但一旦获得机会，便会显著改变行为以追求其他目标。如果一个人工智能系统习得了此类欺骗策略，我们能否利用当前最先进的安全训练技术来检测并消除它？为探究这一问题，我们构建了大型语言模型（LLM）中欺骗行为的概念验证示例。例如，我们训练模型：当提示中声明年份为 2023 年时，生成安全的代码；而当提示中声明年份为 2024 年时，则插入可被利用的漏洞代码。

We find that such backdoor behavior can be made persistent, so that it is not removed by standard safety training techniques, including supervised fine-tuning, reinforcement learning, and adversarial training (eliciting unsafe behavior and then training to remove it). The backdoor behavior is most persistent in the largest models and in models trained to produce chain-of-thought reasoning about deceiving the training process, with the persistence remaining even when the chain-of-thought is distilled away. Furthermore, rather than removing backdoors, we find that adversarial training can teach models to better recognize their backdoor triggers, effectively hiding the unsafe behavior. Our results suggest that, once a model exhibits deceptive behavior, standard techniques could fail to remove such deception and create a false impression of safety.

我们发现，此类后门行为可被设计为具有高度持久性，以至于标准的安全训练技术（包括监督式微调、强化学习以及对抗训练——即先诱导出不安全行为，再针对性地训练以消除该行为）均无法将其清除。后门行为在参数量最大的模型中，以及在那些被专门训练以生成关于“如何欺骗训练过程”的思维链（chain-of-thought）推理的模型中，表现出最强的持久性；即使后续将思维链蒸馏移除，该持久性依然存在。此外，我们还发现，对抗训练非但未能消除后门，反而可能教会模型更精准地识别其自身后门的触发条件，从而有效地将不安全行为隐藏起来。我们的结果表明：一旦模型展现出欺骗行为，现有标准技术可能不仅无法根除此类欺骗，反而会营造出一种虚假的安全感。