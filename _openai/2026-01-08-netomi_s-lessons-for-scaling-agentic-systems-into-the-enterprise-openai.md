---
render_with_liquid: false
title: "Netomi’s lessons for scaling agentic systems into the enterprise | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/netomi"
date: "2026-01-08"
scraped_at: "2026-03-02T10:08:34.965882515+00:00"
language: "en-US"
translated: true
description: "How Netomi scales enterprise AI agents using GPT-4.1 and GPT-5.2—combining concurrency, governance, and multi-step reasoning for reliable production workflows."
tags: ["API"]
---
render_with_liquid: false
render_with_liquid: false

January 8, 2026

2026年1月8日

[API](https://openai.com/stories/api/) Startup

[API](https://openai.com/stories/api/) 创业公司

# Netomi’s lessons for scaling agentic systems into the enterprise

# Netomi 面向企业规模化部署智能体系统的核心经验

Built with OpenAI GPT‑4.1 and GPT‑5.2, Netomi provides a blueprint for scaling safe, predictable agentic systems across the enterprise.

Netomi 基于 OpenAI GPT‑4.1 和 GPT‑5.2 构建，为企业范围内规模化部署安全、可预测的智能体系统提供了可复用的实践蓝图。

![Netomi logo on green background](images/netomi_s-lessons-for-scaling-agentic-systems-into-the-enterprise-openai/img_001.png)

![绿色背景上的 Netomi 标志](images/netomi_s-lessons-for-scaling-agentic-systems-into-the-enterprise-openai/img_001.png)

Enterprises expect AI agents to handle messy workflows reliably, honor policies by default, operate under heavy load, and show their work.

企业期望 AI 智能体能够可靠地处理纷繁复杂的业务流程，开箱即用即符合各项合规与安全策略，能在高负载下稳定运行，并清晰展现其推理与执行过程（即“show their work”）。

[Netomi⁠(opens in a new window)](https://www.netomi.com/) builds systems that meet that high bar, serving Fortune 500 customers like United Airlines and DraftKings. Their platform pairs GPT‑4.1 for low-latency, reliable tool use with GPT‑5.2 for deeper, multi-step planning, running both inside a governed execution layer designed to keep model-driven actions predictable under real production conditions.

[Netomi⁠（在新窗口中打开）](https://www.netomi.com/) 构建的系统正满足这一高标准，服务包括美国联合航空（United Airlines）和 DraftKings 在内的《财富》500 强客户。其平台将 GPT‑4.1 用于低延迟、高可靠的工具调用，同时以 GPT‑5.2 支持更深入、多步骤的规划任务；二者均运行于一个受管控的执行层内——该执行层专为保障模型驱动行为在真实生产环境下的可预测性而设计。

Running agentic systems at this scale has given Netomi a blueprint for what makes these deployments work inside the enterprise.

在如此大规模运行智能体系统的过程中，Netomi 积累了宝贵经验，形成了一套行之有效的、面向企业级落地的智能体系统部署方法论。

## Lesson 1: Build for real-world complexity, not idealized flows

## 经验一：面向真实世界的复杂性构建，而非理想化的流程

A single enterprise request rarely maps to a single API. Real workflows span booking engines, loyalty databases, CRM systems, policy logic, payments, and knowledge sources. The data is often incomplete, conflicting, or time-sensitive. Systems that depend on brittle flows collapse under this variability.

单个企业级请求极少仅对应一个 API。真实的业务流程横跨预订引擎、忠诚度数据库、客户关系管理系统（CRM）、策略逻辑、支付系统以及知识库等多重系统。相关数据常常不完整、相互冲突，或具有严格的时间敏感性。依赖脆弱流程的系统，在面对这种高度可变性时极易崩溃。

Netomi designed its Agentic OS so OpenAI models sit at the center of a governed orchestration pipeline built for this level of ambiguity. The platform uses GPT‑4.1 for fast, reliable reasoning and tool-calling—critical for real-time workflows—and GPT‑5.2 when multi-step planning or deeper reasoning is required.

Netomi 设计了其“智能体操作系统”（Agentic OS），将 OpenAI 模型置于一套受管控的编排流水线中央——该流水线专为应对上述程度的模糊性而构建。平台在需要快速、可靠的推理与工具调用（这对实时工作流至关重要）时采用 GPT‑4.1；而在需执行多步规划或更深层次推理时，则启用 GPT‑5.2。

> “Our goal was to orchestrate the many systems a human agent would normally juggle and do it safely at machine speed.”

> “我们的目标是协调人类客服代表通常需同时处理的多个系统，并以机器速度安全地完成这一任务。”

—Puneet Mehta, CEO, Netomi  
—Puneet Mehta，Netomi 首席执行官

To ensure consistent agent behavior across long, complex tasks, Netomi follows the agentic prompting patterns recommended by OpenAI:

为确保智能体在长期、复杂任务中行为一致，Netomi 采用 OpenAI 推荐的智能体式提示（agentic prompting）模式：

- **Persistence reminders** to help GPT‑5.2 carry reasoning across long, multi-step workflows  
- **持久性提醒**：帮助 GPT‑5.2 在漫长、多步骤的工作流中持续保持推理连贯性  

- **Explicit tool-use expectations**, suppressing hallucinated answers by steering GPT‑4.1 to call tools for authoritative information during transactional operations  
- **明确的工具调用预期**：通过引导 GPT‑4.1 在事务性操作中主动调用工具以获取权威信息，从而抑制幻觉式回答  

- **Structured planning**, which leverages GPT‑5.2’s deeper reasoning to outline and execute multi-step tasks  
- **结构化规划**：利用 GPT‑5.2 更强的深层推理能力，对多步骤任务进行整体规划并分步执行  

- **Agent-driven rich media decisions**, relying on GPT‑5.2 to detect and signal when a tool call should return images, videos, forms, or other rich, multimodal elements  
- **智能体驱动的富媒体决策**：依托 GPT‑5.2 自动识别并发出信号，指示某次工具调用应返回图像、视频、表单或其他富媒体、多模态内容  

Together, these patterns help the model reliably map unstructured requests to multi-step workflows and maintain state across discontinuous interactions.

上述模式协同作用，使模型能够可靠地将非结构化用户请求映射至多步骤工作流，并在非连续交互过程中持续维护上下文状态。

Few industries expose the need for multi-step reasoning as clearly as airlines, where one interaction routinely spans multiple systems and policy layers. A single question may require checking fare rules, recalculating loyalty benefits, initiating ticket changes, and coordinating with flight operations.

极少有行业能像航空业一样清晰凸显多步推理的必要性——在这里，一次客户交互往往需横跨多个系统与政策层级。一个简单问题，就可能涉及查询票价规则、重新计算常旅客权益、发起机票变更，以及与航班运控部门协调。

“In airlines, context changes by the minute. AI has to reason about the scene the customer is in—not just execute a siloed task,” said Mehta. “That’s why situational awareness matters way more than just workflows, and why a context-led ensemble architecture is essential.”

“在航空业，上下文每分钟都在变化。AI 必须理解客户所处的具体场景，而不仅仅是执行孤立的任务。”Mehta 表示，“正因如此，情境感知能力远比单纯的工作流编排更为关键；也正因如此，以情境为中心的集成式架构（context-led ensemble architecture）不可或缺。”

With GPT‑4.1 and GPT‑5.2, Netomi can keep extending these patterns into richer multi-step automations—using the models not just to answer questions, but to plan tasks, sequence actions, and coordinate the backend systems a major airline depends on.

依托 GPT‑4.1 与 GPT‑5.2，Netomi 能持续将上述模式拓展至更丰富的多步自动化场景——不仅让大模型用于回答问题，更使其承担任务规划、动作编排，以及协调大型航司所依赖的各类后端系统等关键职能。

## Lesson 2: Parallelize everything to meet enterprise latency expectations

## 第二课：全面并行化，以满足企业级延迟要求

In high-pressure moments—rebooking during a storm, resolving a billing issue, or handling sudden spikes in demand—users will abandon any system that hesitates. Latency defines trust.

在高压场景下——例如风暴期间紧急改签、解决账单问题，或应对突发的流量激增——用户会毫不犹豫地放弃任何响应迟疑的系统。延迟，即信任。

Most AI systems fail because they execute tasks sequentially: classify → retrieve → validate → call tools → generate output. Netomi instead designed for concurrency, taking advantage of low-latency streaming and tool-calling stability of GPT‑4.1.

大多数 AI 系统失败，是因为它们按顺序执行任务：分类 → 检索 → 验证 → 调用工具 → 生成输出。而 Netomi 则从设计之初就面向并发，充分利用 GPT‑4.1 的低延迟流式响应能力与稳定可靠的工具调用特性。

![Flowchart illustrating an enterprise AI customer support workflow. A customer query about rebooking a canceled flight enters through multiple channels (social, chat, SMS, email, search, voice). The system identifies the request as a rebooking scenario, applies safety guardrails, orchestrates tool calls to retrieve alternatives and apply fare and loyalty rules, executes actions across booking and CRM systems, and assembles a validated response. The final output delivers personalized rebooking options and loyalty compensation to the customer.](images/netomi_s-lessons-for-scaling-agentic-systems-into-the-enterprise-openai/img_002.png)

![展示企业级 AI 客户支持工作流的流程图：一条关于“为已取消航班办理改签”的客户咨询，通过多个渠道（社交平台、在线聊天、短信、邮件、搜索、语音）进入系统；系统识别该请求为改签场景，施加安全防护机制，协调调用各类工具以检索可选航班、应用票价及忠诚度规则，在预订系统和 CRM 系统中执行相应操作，并整合生成经验证的响应；最终输出向客户提供个性化的改签方案与忠诚度补偿。](images/netomi_s-lessons-for-scaling-agentic-systems-into-the-enterprise-openai/img_002.png)

GPT‑4.1 provides fast time-to-first-token and predictable tool-calling behavior, which make this architecture viable at scale; while GPT‑5.2 provides deeper multi-step reasoning paths when needed. Netomi’s concurrency framework ensures the _total system_, not just the model, stays under critical latency thresholds.

GPT‑4.1 提供极快的首字节响应时间（time-to-first-token）与可预测的工具调用行为，使该架构得以在大规模部署中切实可行；而当需要更复杂的多步推理时，GPT‑5.2 则可提供更深层次的推理路径。Netomi 的并发框架确保整个系统——而不仅仅是大语言模型本身——始终维持在关键延迟阈值之内。

These concurrency demands aren’t unique to airlines. Any system exposed to sudden, extreme traffic surges needs the same architectural discipline. DraftKings, for instance, regularly stress-tests this model, with traffic during major sporting events spiking above 40,000 concurrent customer requests per second.

此类并发需求绝非航空业独有。任何可能遭遇突发性、极端流量高峰的系统，都需要同等严格的架构规范。以 DraftKings 为例，该公司定期对该模型进行压力测试：在大型体育赛事期间，其每秒并发客户请求数峰值常超过 40,000。

During such events, Netomi has sustained sub-three-second responses with 98% intent classification accuracy, even as workflows touch accounts, payments, knowledge lookups, and regulatory checks.

在此类事件中，即便工作流需同步访问账户系统、支付网关、知识库查询及合规性检查等多个环节，Netomi 仍能持续实现低于三秒的端到端响应，并保持高达 98% 的意图识别准确率。

“AI is central and critical to how we support customers in the moments that matter most,” said Paul Liberman, Co-Founder and President of Operations at DraftKings. “Netomi’s platform helps us handle massive spikes in activity with agility and precision.”

DraftKings 联合创始人兼运营总裁 Paul Liberman 表示：“AI 是我们于关键时刻服务客户的核心与关键所在。Netomi 的平台助力我们以敏捷性与精准度从容应对海量并发活动。”

At scale, Netomi’s concurrency model depends on the fast, predictable tool-calling of GPT‑4.1, which keeps multi-step workflows responsive under extreme load.

在规模化部署中，Netomi 的并发模型高度依赖 GPT‑4.1 快速且可预测的工具调用能力，从而确保多步骤工作流在极端负载下依然响应迅捷。

## Lesson 3: Make governance an intrinsic part of the runtime

## 第三课：将治理机制内嵌为运行时的固有组成部分

Enterprise AI must be trustworthy by design, with governance woven directly into the runtime—not added as an external layer.

企业级 AI 必须从设计之初就具备可信性，其治理机制需原生嵌入运行时环境，而非作为外部附加层事后添加。

When intent confidence drops below threshold, or when a request cannot be classified with high certainty, Netomi’s governance mechanisms kick in to determine how the request is handled, ensuring the system backs off from free-form generation in favor of controlled execution paths.

当意图置信度低于预设阈值，或请求无法被高置信度归类时，Netomi 的治理机制即刻启动，决定该请求的处理方式，确保系统主动退出自由式生成，转而采用受控的执行路径。

At a technical level, the governance layer handles:

在技术层面，治理层负责以下功能：

- **Schema validation**, which validates every tool call against expected arguments and OpenAPI contracts before execution  
- **模式校验（Schema validation）**：在每次工具调用执行前，依据预期参数及 OpenAPI 合约对其进行校验  

- **Policy enforcement** that applies topic filters, brand restrictions, and compliance checks inline during reasoning and tool use  
- **策略执行（Policy enforcement）**：在推理与工具调用过程中实时应用主题过滤、品牌限制及合规性检查  

- **PII protection** to detect and mask sensitive data as part of pre-processing and response handling  
- **个人身份信息（PII）保护**：在预处理与响应生成环节自动识别并屏蔽敏感数据  

- **Deterministic fallback**, routing back to known-safe behaviors when intent, data, or tool calls are ambiguous  
- **确定性回退（Deterministic fallback）**：当意图、数据或工具调用存在歧义时，自动回退至已知安全的行为模式  

- **Runtime observability,** exposing token traces, reasoning steps, and tool-chain logs for real-time inspection and debugging  
- **运行时可观测性（Runtime observability）**：暴露 token 轨迹、推理步骤及工具链日志，支持实时审查与调试  

In highly regulated domains like dental insurance, this kind of governance is non-negotiable. A Netomi customer in the insurance industry processes close to two million provider requests each year across all 50 states, including eligibility checks, benefits lookups, and claim status inquiries where a single incorrect response can create downstream regulatory or service risk.

在牙科保险等强监管领域，此类治理能力是不可妥协的刚性要求。一家使用 Netomi 的保险行业客户，每年需在全美 50 个州处理近两百万条医疗机构请求，涵盖参保资格核查、福利查询及理赔状态问询等场景——任一错误响应均可能引发下游监管风险或服务风险。

During open enrollment, when scrutiny and volume peaked, the company needed AI that enforced policy as part of the runtime itself. Netomi’s architecture was up to that complex requirement.

在开放投保期（open enrollment），当监管审查强度与业务请求量双双达到峰值时，该公司亟需一种能将策略执行内化为运行时固有行为的 AI 系统。Netomi 的架构完全满足这一复杂需求。

“We built the system so that if the agent ever reaches uncertainty, it knows exactly how to back off safely,” said Mehta. “The governance is not bolted on—it’s part of the runtime.”

“我们构建该系统时即确保：一旦智能体进入不确定状态，它便能精准、安全地主动回退。”Mehta 表示，“这种治理能力并非后期‘打补丁’式添加——它本身就是运行时不可或缺的一部分。”

## A blueprint for building agentic systems that work for the enterprise

## 构建面向企业的智能体系统：一份可落地的蓝图

Netomi’s path shows what it takes to earn enterprise trust: build for complexity, parallelize to meet latency demands, and bake governance into every workflow. OpenAI models form the reasoning backbone, while Netomi’s systems engineering ensures that intelligence is operationally safe, auditable, and ready for Fortune 500 environments.

Netomi 的实践揭示了赢得企业信任的关键所在：以应对复杂性为目标进行构建，通过并行化满足低延迟要求，并将治理能力深度融入每一个工作流。OpenAI 模型构成推理的核心支柱，而 Netomi 的系统工程能力则确保该智能具备运行安全性、可审计性，并能无缝适配《财富》500 强企业的严苛环境。

These principles helped Netomi scale across some of the world’s most demanding industries—and offer a blueprint for any startup looking to turn agentic AI into production-grade infrastructure.

这些原则助力 Netomi 成功拓展至全球最具挑战性的多个行业；同时也为所有希望将智能体 AI 转化为生产级基础设施的初创公司，提供了一份切实可行的参考蓝图。