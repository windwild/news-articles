---
title: "Improving support with every interaction at OpenAI | OpenAI"
render_with_liquid: false
source: "OpenAI Blog"
url: "https://openai.com/index/openai-support-model"
date: "2025-09-29"
scraped_at: "2026-03-02T10:47:39.876646221+00:00"
language: "en-US"
translated: true
description: "Learn how OpenAI uses AI to enhance support, cutting response times, improving quality, and scaling to meet hypergrowth."
tags: ["API"]
---

render_with_liquid: false
September 29, 2025

2025年9月29日

[API](https://openai.com/stories/api/) OpenAI on OpenAI

[API](https://openai.com/stories/api/) OpenAI 的 OpenAI 实践

# Improving support with every interaction at OpenAI

# 每一次交互，都在提升 OpenAI 的客户支持能力

00:00

00:00

_This is part of our series sharing internal examples of how OpenAI is using its own technology and APIs. These tools are being used internally, only at OpenAI, and are shared here as illustrative examples of how frontier AI is supporting use cases across our teams. We’re also sharing the internal tool names for a clearer look at how frontier AI helps our teams get work done._

_这是本系列文章的一部分，旨在分享 OpenAI 内部如何运用自身技术与 API 的实际案例。这些工具目前仅在 OpenAI 内部使用，本文分享它们仅为说明前沿人工智能（frontier AI）如何赋能公司各团队的具体应用场景。我们同时公开了内部工具的名称，以便更清晰地展现前沿 AI 是如何切实帮助团队提升工作效率的。_

## More than tickets, a new operating model

## 不止于工单：一种全新的运营模式

Support has historically meant queues, tickets, and throughput. But at OpenAI, that wasn’t enough. We serve hundreds of millions of users, handle millions of requests each year, and see that volume grow by multiples annually.

传统上，客户支持意味着队列、工单和处理吞吐量。但在 OpenAI，这远远不够。我们服务数亿用户，每年处理数百万请求，且该请求量正以倍数级逐年增长。

Lots of organizations deal with scale. Fewer deal with scale **and** hypergrowth. Almost none face both—while also building the very technology that could change the equation. That combination uniquely positioned us to rethink support from the ground up.

许多组织应对规模挑战；更少的组织同时应对规模与超高速增长（hypergrowth）；而几乎没有任何组织在面临这两重挑战的同时，还在构建可能彻底改写游戏规则的底层技术。正是这种独特组合，使我们得以从零开始重新构想客户支持体系。

> “Support has never really been about replying to just tickets. It’s about whether people get what they need, whether it actually serves them well.”

> “客户支持的本质，从来就不是简单回复工单。它关乎用户是否真正获得了所需，以及我们的服务是否真正有效地满足了他们的需求。”

Glen Worthington, Head of User Ops

格伦·沃辛顿，用户运营负责人

Support isn’t a volume challenge. It’s an engineering and operational design challenge. So we built something different: an operating model where every interaction improves the next.

支持并非单纯的“量”的挑战，而是一项工程与运营设计的挑战。因此，我们构建了一种全新的模式：一个让每一次交互都推动下一次交互更优的运营模型。

## Connecting a system of interactions

## 连接一整套交互系统

The Ops team wanted to go well beyond using a chatbot to deflect support questions. The team has a vision: reimagine support as an AI operating model that continuously learns and improves.

运营团队的目标远不止于用聊天机器人分流支持问题。团队怀揣着一个愿景：将支持重塑为一种持续学习、持续进化的 AI 运营模型。

At the center are three building blocks:

核心由三大构成模块组成：

- **Surfaces.** Where support systems are interacted with. Chat, email, and phone, but increasingly, help embedded directly inside the product.  
- **交互界面（Surfaces）**：用户与支持系统发生交互的触点。包括聊天、邮件和电话；而如今，越来越多的帮助内容正直接嵌入产品内部。

- **Knowledge.** Not just static docs, but living and continuously improving guidance drawn from real conversations, policies, and context.  
- **知识体系（Knowledge）**：不只是静态文档，而是源自真实对话、政策与上下文的、动态演进且持续优化的指导性内容。

- **Evals and classifiers.** Shared definitions of quality built by software and humans in unison, plus tools to measure, improve, and highlight feedback.  
- **评估机制与分类器（Evals and classifiers）**：由软件与人类协同共建的质量共识标准，辅以用于度量、优化及凸显反馈的工具。

These pieces don’t sit in isolation. They form a loop. A pattern spotted in an enterprise conversation can inform a developer FAQ. An eval written for one case strengthens the model for thousands more. And because the same primitives power every surface — chat, email, voice — improvements scale across channels automatically.

这些模块并非彼此割裂，而是构成一个闭环系统：企业客户对话中发现的某种模式，可反哺开发者常见问题解答（FAQ）；为某一案例编写的评估规则，能强化模型对成千上万个相似案例的处理能力；又因所有交互界面——聊天、邮件、语音——均由同一套底层能力驱动，任何改进均可自动跨渠道规模化复用。

## Support reps as systems thinkers

## 支持代表作为系统思考者

The role of a support rep is changing. Our aim is to shift the model from primarily focusing on processing transactional work to being a part of the overall build. They’re empowered to contribute to the architecture itself, both directly through bottom up shipping of changes and indirectly through the natural motions of their day to day work.

支持代表的角色正在转变。我们的目标是，将原有以处理事务性工作为主的模式，升级为深度参与整体系统构建的模式。他们被充分赋权，既可通过自下而上地交付变更，直接参与系统架构建设；也可在日常工作的自然流程中，间接贡献于架构演进。

Reps flag interactions that should become test cases, propose and ship classifiers when they see new patterns, and even prototype lightweight automations to close workflow gaps in days. Training shifts too, it’s not just about policies, but about evaluating interactions, identifying structural gaps, and feeding improvements back.

支持代表会主动标记值得纳入测试用例的交互场景；在发现新行为模式时，提出并上线新的分类器；甚至可在数日内快速搭建轻量级自动化原型，填补工作流中的关键缺口。培训内容也随之转变——不再仅聚焦于政策宣贯，更强调交互评估能力、结构性短板识别能力，以及将改进建议有效反馈至系统的能力。

The new approach strives to ensure that support reps are builders as much as responders.

这种新方法致力于确保支持代表既是响应者，也是建设者。

> “Agents aren’t just responding to tickets. They’re informing our knowledge base and our policies. They have an ear to the ground that we don’t.”

> “智能体（Agents）不只是在处理工单，他们还在持续丰富我们的知识库、塑造我们的政策。他们拥有我们所不具备的‘接地气’的一线洞察力。”

Shimul Sachdeva, Engineering Manager

希穆尔·萨奇德瓦（Shimul Sachdeva），工程经理

The result is a support organization defined less by throughput and more by its capacity to evolve. Every person is not only serving users but also actively improving the machinery that serves _all_ users.

最终形成的是一种不再以吞吐量为核心指标、而更强调进化能力的支持组织。每一位成员不仅服务于用户，更在主动优化服务**所有**用户的基础系统。

## From primitives to production

## 从基础组件到生产落地

Building support this way is only possible because we’re built on OpenAI’s stack.

之所以能以这种方式构建支持体系，根本原因在于我们基于 OpenAI 的技术栈构建而成。

- Agents SDK gives us step-level traces and observability by default. We can replay runs, inspect tool calls, and debug root causes instantly.

- Agents SDK 默认提供细粒度的步骤级追踪与可观测性：我们可以回放执行过程、检查工具调用，并即时定位根本原因。

- Responses API powers classifiers for tone, correctness, and policy adherence.

- Responses API 驱动语气、准确性及合规性等多维度分类器。

- Realtime API makes voice support possible.

- Realtime API 使语音支持成为可能。

- OpenAI’s Evals dashboard makes quality measurable and easy to visualize over time.

- OpenAI 的 Evals 仪表盘让服务质量可量化，并便于长期可视化追踪。

Because the platform primitives come ready-made, we spend less time stitching systems together and more time focusing on the work that matters: defining what good looks like, measuring it, and improving it.

由于平台的基础组件已开箱即用，我们得以大幅减少系统集成耗时，将更多精力聚焦于真正关键的工作：定义“优质服务”的标准、衡量其实现程度，并持续改进。

We started with a simple Q&A answerer that worked well. With Agents SDK, we quickly expanded into dynamic actions for things like refunds, invoices, incident lookups. As the models continue to improve with larger context windows, Deep Research, and stronger agentic capabilities, we can adopt those advances immediately.

我们最初仅部署了一个效果良好的简单问答应答器；借助 Agents SDK，我们迅速拓展至退款、发票开具、事件查询等动态操作场景。随着模型持续演进——上下文窗口不断扩大、Deep Research 能力日益增强、智能体（agentic）行为愈发成熟——我们能够即刻采纳这些前沿进展。

## Learning that compounds

## 复利式学习

Evals turn everyday conversations into production tests. They codify what “great” means—not just solving the issue, but doing it politely, clearly, and consistently. Reps play a direct role here, flagging strong and weak examples that become evals, and those evals run continuously in production to steer model behavior.

评估（Evals）将日常对话转化为生产环境中的测试用例。它们将“卓越服务”的标准明确编码化——不仅在于解决问题，更在于以礼貌、清晰且一致的方式完成。一线支持人员（Reps）在此过程中发挥直接作用：甄别表现优异与欠佳的对话范例，将其转化为评估用例；这些评估用例持续在生产环境中运行，从而引导大模型的行为。

“Usually when you have a problem, you just want help as quickly as possible. By using our AI tools, we’re able to get those responses much more quickly—and just as importantly, we know when the model shouldn’t answer,” says Jay Patel, Software Engineer, Support Automation.

“通常，当你遇到问题时，你只希望尽快获得帮助。借助我们的 AI 工具，我们能显著加快响应速度——而同样重要的是，我们清楚地知道模型何时不应作答。”——Jay Patel，软件工程师，支持自动化团队

Learning doesn’t stop at resolution. Patterns feed back into knowledge, automation, and product design. The system compounds: faster answers for users, tighter feedback loops for builders, and a consistently higher bar for quality across every surface.

学习不会止步于问题解决。从对话中提炼出的模式会反哺知识库建设、自动化流程优化及产品设计迭代。整个系统由此形成正向复利效应：用户获得更快响应，构建者获得更紧密的反馈闭环，而每一处用户触点的质量基准也持续提升。

And it’s not just the AI that learns. The organization learns alongside it. Specialists see where models fall short, shape new classifiers, and contribute datasets for fine-tuning. Observability dashboards make quality measurable, showing how performance improves over time.

学习的主体并不仅限于 AI，组织自身也在同步成长。领域专家能敏锐识别模型能力的短板，主导设计新的分类器，并贡献高质量数据集用于模型微调。可观测性仪表盘让服务质量变得可衡量，直观呈现性能随时间推移的持续提升。

## A blueprint for the future of support

## 支持体系未来的蓝图

The most profound shift isn’t the tooling, it’s the people and how the organization measures success. Support specialists are recognized not just for solving problems, but for refining knowledge, improving models, and extending the system itself. Leaders look for a new kind of teammate: someone who pairs frontline empathy with design instincts, combining support craft with curiosity to improve the system.

最深刻的变革并非来自工具本身，而在于人，以及组织衡量成功的方式。支持专家的价值不再仅体现于问题解决，更体现在知识精炼、模型优化与系统拓展之中。领导者正在寻找一种新型团队成员：他们既具备一线服务的共情力，又拥有产品设计的直觉；既能深耕支持专业，又能以好奇心驱动系统进化。

> “We’re starting to see this marriage between deep craft expertise and deep engineering expertise. That’s the future of how departments run.”

> “我们正开始见证‘深厚的专业技艺’与‘深厚的工程能力’之间的融合。这正是未来各部门运转方式的雏形。”

Glen Worthington, Head of User Ops  
Glen Worthington，用户运营负责人

And our vision is support stops being a destination you go to. It becomes an action, woven into every product surface. Users don’t “open a ticket.” They simply get what they need, where they are.

我们的愿景是：支持不再是一个你需要“前往”的终点，而是一种自然发生的行动，无缝融入每一处产品界面。用户无需“提交工单”，而是在当下所处的位置，即刻获得所需。

What began as a response to scale has become a blueprint for how people and AI can work together: collaborative, adaptive, and continuously improving.

这一探索最初源于对规模化服务需求的回应，如今已升华为人与 AI 协同工作的范式蓝图：协作式、自适应、持续进化。

## Ready to put ChatGPT to work in your business?

## 准备好在您的业务中应用 ChatGPT 了吗？

[Talk with our team](https://openai.com/contact-sales/)

[与我们的团队联系](https://openai.com/contact-sales/)