---
render_with_liquid: false
title: "Beyond rate limits: scaling access to Codex and Sora | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/beyond-rate-limits"
date: "2026-02-13"
scraped_at: "2026-03-02T10:08:19.067859032+00:00"
language: "en-US"
translated: true
description: "How OpenAI built a real-time access system combining rate limits, usage tracking, and credits to power continuous access to Sora and Codex."
tags: ["Engineering"]
---
render_with_liquid: false
render_with_liquid: false

February 13, 2026

2026年2月13日


# Beyond rate limits: scaling access to Codex and Sora

# 超越速率限制：扩展对 Codex 和 Sora 的访问能力

By Jonah Cohen, Member of the Technical Staff

作者：Jonah Cohen，技术团队成员


In the past year, both Codex and Sora have seen rapid adoption, with usage quickly pushing beyond what we originally expected. We’ve seen a consistent pattern: users dive in, find real value, and then run into rate limits.

过去一年中，Codex 和 Sora 均经历了快速普及，其使用量迅速超出了我们最初的预期。我们观察到一种持续出现的模式：用户深入使用后切实感受到产品价值，却随即遭遇速率限制。

Rate limits can help smooth demand and ensure fair access; however, when users are getting value, hitting a hard stop can be frustrating. We wanted a way for users to keep going, while protecting system performance and user trust in our approach.

速率限制有助于平抑需求波动、保障资源公平分配；然而，当用户正从中获得实际价值时，突然被“硬性截断”难免令人沮丧。我们希望在保障系统性能与用户对我们机制信任的前提下，为用户提供持续使用的途径。

To solve this, we built a real‑time access engine that counts usage. One of the layers in that engine is the ability to purchase credits. When users exceed their rate limits, credits let them keep using our products by spending down their credit balance.

为此，我们构建了一套实时访问引擎，用于精确计量使用量。该引擎的一个关键层级，便是支持用户购买积分（credits）。当用户超出其速率限制时，可通过消耗账户中的积分余额，继续使用我们的产品。

Underneath this is a complex system that fuses limits, real‑time usage tracking, and credit balances in a single access model. This post covers why scaling Codex and Sora required rethinking access control, how a provably correct, real-time system blends rate limits and credits per request, and how that foundation now unlocks additional access for both products.

其底层是一套复杂系统，将配额限制、实时用量追踪与积分余额三者融合，统一纳入单一访问控制模型。本文将阐述：为何 Codex 和 Sora 的规模化扩展亟需重构访问控制机制；一套可形式化验证其正确性的实时系统，如何在每次请求层面无缝融合速率限制与积分机制；以及这一基础架构如今如何为两款产品释放更多访问能力。

## Why existing access models fell short

## 现有访问模型为何力不从心

Zooming out, traditional access models tend to force a choice:  

宏观来看，传统访问模型往往迫使用户做出非此即彼的选择：

- **Rate limits** can be helpful at first, but leave users with a bad experience when they run out: “come back later”  
- **使用量计费（Usage‑based billing）** 初期虽具灵活性，却让用户从第一个 token 起即开始付费——这对支持用户早期探索并不理想。

For Codex and Sora, neither was sufficient on its own. If we simply raised rate limits, we’d lose important demand-smoothing and fairness controls and run out of capacity to serve everyone. If we relied entirely on asynchronous usage billing, we’d introduce lag, overages, or reconciliation issues—exactly the kinds of problems users notice when they’re most engaged.  
对于 Codex 和 Sora 而言，二者单独使用均无法满足需求。若仅简单提高速率限制，我们将丧失关键的需求平滑调节与公平性管控能力，并最终耗尽服务所有用户的容量；若完全依赖异步的用量计费机制，则会引入延迟、超额使用或对账问题——而这恰恰是用户参与度最高时最易察觉的痛点。

What we needed instead was a single hybrid system combining real-time limits with pay-as-you-go access:  
因此，我们真正需要的是一套统一的混合系统，将实时限流机制与按需付费访问能力有机结合：

![Dashboard UI with two buttons labeled “Rate-limits” and “Credits,” and a card below titled “Rate-Limit with Credit Fallback.”](images/beyond-rate-limits-scaling-access-to-codex-and-sora-openai/img_001.svg)  
![仪表盘界面，含两个按钮：“Rate-limits”（速率限制）和“Credits”（积分），下方卡片标题为“Rate-Limit with Credit Fallback”（带积分回退机制的速率限制）。](images/beyond-rate-limits-scaling-access-to-codex-and-sora-openai/img_001.svg)

This system had to:  
该系统必须满足以下要求：

- Enforce rate limits _until_ they’re reached  
- 在速率限制被耗尽前，持续执行限流策略  

- Seamlessly transition to credits _within the same request_  
- 在**同一请求内**无缝切换至积分机制  

- Make that decision in real time  
- 实时完成上述切换决策  

- Be rigorously accurate and auditable when tracking credit consumption  
- 在追踪积分消耗时，确保高度精确且可审计  

## Access as a waterfall, not a gate  
## 访问机制：瀑布式分流，而非闸门式拦截  

One of the key conceptual shifts we made was modeling access as a **decision waterfall**. Instead of asking “is this allowed?”, we ask “how much is allowed, and from where?” When counting usage, the system goes through the following sequence:  
我们实现的关键理念转变之一，是将访问控制建模为一个**决策瀑布流（decision waterfall）**。我们不再仅问“是否允许？”，而是追问：“最多允许多少？来源是哪里？” 在统计用量时，系统将按如下顺序逐层评估：

![Decision tree for evaluating access to our features ](images/beyond-rate-limits-scaling-access-to-codex-and-sora-openai/img_002.svg)  
![用于评估访问我们各项功能的决策树](images/beyond-rate-limits-scaling-access-to-codex-and-sora-openai/img_002.svg)

This model reflects how users actually experience the product. Rate limits, free tiers, credits, promotions, and enterprise entitlements are all just layers in the same decision stack. From a user’s perspective, they don’t “switch systems”—they just keep using Codex and Sora. That’s why credits feel invisible: they’re just another element in the waterfall.  
该模型真实还原了用户的实际产品体验：速率限制、免费额度、积分、促销权益及企业专属配额，本质上都是同一决策栈中的不同层级。对用户而言，他们并未“在不同系统间切换”，而只是持续使用 Codex 和 Sora。正因如此，积分机制才显得“隐形”——它不过是瀑布流中自然存在的一环。

## Why we built this in‑house

## 为何我们选择自研此系统

We evaluated third‑party usage billing and metering platforms to handle credit consumption. They’re well‑suited for invoicing and reporting, but didn’t meet two critical requirements:

我们评估了多家第三方用量计费与计量平台，以应对信用额度消耗场景。这些平台虽非常适合开票和报表生成，却无法满足以下两项关键需求：

#### Real‑time correctness

#### 实时准确性

When a user hits a limit and has credits available, the system must know _immediately_. Best‑effort or delayed counting shows up as surprise blocks, inconsistent balances, and incorrect charges. For interactive products like Codex and Sora, those failures become visible and frustrating.

当用户触达配额限制但仍有可用信用额度时，系统必须 _即时_ 得知这一状态。尽力而为（best-effort）或延迟统计会导致意外的请求拦截、账户余额不一致以及错误计费。对于 Codex 和 Sora 这类交互式产品，此类故障会直接暴露给用户，造成明显困扰。

#### Reconcilability and trust

#### 可对账性与可信度

We also needed to offer transparency into every outcome:

我们也需要确保每一项决策结果都具备充分透明度：

- Why a request was allowed or blocked  
- 请求被允许或拦截的原因  
- How much usage it consumed  
- 该请求消耗了多少用量  
- Which limits or balances were applied  
- 应用了哪些配额限制或账户余额  

This capability needed to be tightly integrated into our decision waterfall rather than solved in isolation in a separate usage billing platform that only saw one piece of what was happening. To let users access our products without compromising trust, we needed full control over correctness, timing, and observability. That pushed us toward an in‑house solution.

这一能力必须深度嵌入我们的决策流水线（decision waterfall），而非交由一个孤立运行、仅能观测局部事件的独立用量计费平台来解决。为确保用户在无障碍使用我们产品的同时，不损害其对系统的信任，我们必须对准确性、时效性与可观测性拥有完全掌控权——这促使我们选择了自研方案。

## Building a high‑scale usage and balance system

## 构建高并发用量与余额系统

To power this, we built a distributed usage and balance system designed specifically for synchronous access decisions.

为此，我们构建了一套分布式用量与余额系统，专为支持同步化的访问决策而设计。

At a high level, the system:

- Tracks per‑user, per‑feature usage  
- Maintains rate‑limit windows  
- Maintains real‑time credit balances  
- Debits balances idempotently through a streaming async processor  

从宏观层面看，该系统：

- 跟踪每位用户对每项功能的使用情况  
- 维护速率限制的时间窗口  
- 维护实时信用余额  
- 通过流式异步处理器以幂等方式扣减余额  

Every request passes through a single evaluation path that makes a real‑time decision about how much usage is allowed by synchronously consuming from rate limits and, if needed, verifying sufficient credits; it then returns one definitive outcome while settling any credit debits asynchronously. This ensures consistent behavior across products and eliminates duplicated logic across teams.

每个请求均经过统一的评估路径：该路径实时判定允许的使用量——首先同步消耗速率限制配额，必要时再验证用户是否拥有足够信用额度；随后返回唯一确定的结果，同时异步完成所有信用扣减操作。此举确保了各产品间行为的一致性，并消除了跨团队重复实现逻辑的问题。

![Access system: Combining real-time rate-limits and asynchronous credit & balance tracking.](images/beyond-rate-limits-scaling-access-to-codex-and-sora-openai/img_003.svg)

![接入系统：融合实时速率限制与异步信用及余额追踪](images/beyond-rate-limits-scaling-access-to-codex-and-sora-openai/img_003.svg)

## A provably correct billing system

## 一个可形式化验证其正确性的计费系统

One of the key design principles of this system is that we must be able to _prove_ that our billing is correct. This reflects the roots of our credit support, which originated with enterprise customers. In the above system diagram, we have three separate datasets that all tie together:

该系统的一项核心设计原则是：我们必须能够 _证明_ 计费结果的正确性。这一理念源于我们信用体系的初始定位——面向企业客户。在上图所示的系统架构中，存在三组相互关联的独立数据集：

- **Product usage events:** What the user actually did  
- **Monetization events:** What we charge the user for their usage  
- **Balance updates:** How much we adjusted the user’s credit balance and why  

- **产品使用事件（Product usage events）**：用户实际执行的操作  
- **货币化事件（Monetization events）**：我们针对用户使用行为所收取的费用  
- **余额更新记录（Balance updates）**：我们对用户信用余额所做的调整金额及其原因  

These datasets aren’t a casual by-product; they actually drive the system, with each dataset triggering the next. Separating what occurred, any associated charges, and what we debited lets us independently audit, replay, and reconcile every layer. This is an intentional trade-off where we are prioritizing provable correctness, at the cost of credit balance updates being slightly delayed. How we accomplished this:

这些数据集并非随意生成的副产品；它们实质上驱动着整个系统运行，且每一类数据都会触发下一类数据的生成。将“发生了什么”、“对应收取了哪些费用”以及“我们扣减了哪些信用额度”三者明确分离，使我们能够对每一层进行独立审计、重放与对账。这是一种有意为之的权衡取舍：我们优先保障可验证的正确性，而接受信用余额更新存在轻微延迟。具体实现方式如下：

- Product usage events are published for all user activity, whether it drives credit consumption or not. This provides an audit trail for user activity and allows us to explain why we charged, or didn’t charge, credits.  
- 所有用户活动（无论是否引发信用消耗）均会发布对应的产品使用事件。这为用户行为提供了完整的审计线索，也使我们能清晰解释为何收费或未收费。  

- Every event carries a stable idempotency key, so retries, replays, or worker restarts can never double‑debit a balance, which prevents double‑charging. This also lets us run a batch reconciliation to verify our work offline.  
- 每个事件均携带一个稳定的幂等性密钥（idempotency key），从而确保重试、重放或工作节点重启绝不会导致余额被重复扣减，彻底杜绝重复计费。这也使我们能够离线执行批量对账，以验证系统处理结果的准确性。  

- We do asynchronous (but still near-real-time) balance updates instead of synchronous updates to create an audit trail. We tolerate a small delay in updating the user’s balance so that we can prove that the system is functioning and assure our users that we are not misbilling them. When that brief delay causes us to overshoot a user’s credit balance, we automatically refund it; we choose provable correctness and user trust over strict enforcement.  
- 我们采用异步（但仍接近实时）而非同步的方式更新余额，以构建完整可追溯的审计链。我们容忍用户余额更新存在微小延迟，以便向用户证明系统运行正常，并确保我们未发生错误计费。当该短暂延迟导致信用余额被超额扣减时，系统将自动退款；我们选择“可验证的正确性”与“用户信任”，而非严苛的即时强制执行。  

- We decrease the _Credit Balance_ and insert a _Balance Update_ record in a single atomic database transaction. Balance updates are serialized per account, so concurrent requests can never race to spend the same credits. The _Balance Update_ record contains both the debit amount as well as attribution back to the monetization event that triggered the update; wrapping this in a single database transaction guarantees we have an audit trail for every adjustment to the credit balance.  
- 我们在一个原子数据库事务中，同步完成 _信用余额（Credit Balance）_ 的扣减与 _余额更新记录（Balance Update）_ 的插入。余额更新按账户序列化执行，因此并发请求绝不可能竞争消耗同一笔信用额度。该 _余额更新记录_ 同时包含扣减金额及其归属的货币化事件（即触发本次更新的计费事件）；将二者封装于单个数据库事务中，确保每一次信用余额调整都具备完整可追溯的审计线索。  

All of this rigor supports one objective: to make access simple and safe. When people are creating or coding, they shouldn’t have to wonder whether a request will go through, if they’ll be overcharged, or whether their balance is accurate. By making usage, billing, and balances provably correct, we give users a system that doesn’t distract from their experience. That’s what lets us replace hard stops with continuous access—and it’s what makes credits usable in the middle of real work, not just on an invoice.

上述所有严谨设计，共同服务于一个目标：让资源访问变得简单而安全。当用户正在创作或编写代码时，他们无需担忧请求是否会成功、是否会遭遇超额计费，或当前余额是否准确。通过确保使用量、计费逻辑与余额状态均可被形式化验证其正确性，我们为用户提供了一个不干扰其核心体验的系统。正因如此，我们得以用“持续可用”取代“硬性中断”；也正是这种可靠性，使得信用额度真正融入用户的实际工作流之中——而不仅停留在月末账单之上。

## Architecture in service of momentum

## 为持续动力而构建的架构

The guiding principle behind our approach is protecting user momentum. Every architectural decision maps back to a user-facing outcome: real-time balances prevent unnecessary interruptions, atomic consumption prevents double-charging, and unified access logic ensures predictable behavior. The result is that people can work longer, explore more deeply, and take projects further without facing hard stops or premature plan changes.

我们方法背后的指导原则是保护用户的操作连续性。每一项架构决策都对应着一个面向用户的实际效果：实时余额避免了不必要的中断，原子化用量计量防止重复扣费，统一的访问逻辑确保行为可预期。最终效果是，用户能够更长时间地专注工作、更深入地探索创意，并将项目推进得更远，而不会遭遇强制中断或被迫提前变更订阅计划。

When users are engaged, the system should help them continue, not get in the way. Limits and credits disappear into the background.

当用户处于深度投入状态时，系统应当助力其持续前行，而非横加阻碍。配额限制与信用额度悄然隐入后台，不再干扰体验。

Building that experience required rethinking access, usage, and billing as a single system and building infrastructure that treats correctness as a first‑class product feature. The same foundation can extend to more products over time; Codex and Sora are just the beginning.

打造这一体验，要求我们将访问控制、用量管理与计费机制重新构想为一个统一系统，并建设一套将“正确性”视为头等产品特性的基础设施。这一基础架构未来可逐步扩展至更多产品；Codex 和 Sora，仅仅是个开始。

- [Codex](https://openai.com/news/?tags=codex)  
- [Codex](https://openai.com/news/?tags=codex)  
- [Sora](https://openai.com/news/?tags=sora)  
- [Sora](https://openai.com/news/?tags=sora)  
- [2026](https://openai.com/news/?tags=2026)  
- [2026](https://openai.com/news/?tags=2026)