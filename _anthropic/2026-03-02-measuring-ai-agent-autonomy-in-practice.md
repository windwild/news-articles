---
title: "Measuring AI agent autonomy in practice"
render_with_liquid: false
source: "Anthropic Research"
url: "https://www.anthropic.com/research/measuring-agent-autonomy"
scraped_at: "2026-03-02T09:21:16.665678093+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---

render_with_liquid: false
社会影响

# 在实践中衡量 AI 代理的自主性

2026 年 2 月 18 日

![在实践中衡量 AI 代理的自主性](images/measuring-ai-agent-autonomy-in-practice/img_001.svg)

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流利度指数”（AI Fluency Index）——该指数为衡量当今人类与 AI 协作水平提供了基准。

AI 代理已然到来，并已部署于后果差异巨大的各类场景中，从电子邮件分类整理，到[网络间谍活动](https://www.anthropic.com/news/disrupting-AI-espionage)。理解这一光谱对于安全部署 AI 至关重要；然而，我们对人们在真实世界中究竟如何使用 AI 代理，却知之甚少。

我们利用[隐私保护分析工具](https://www.anthropic.com/research/clio)，分析了数百万次人类与 AI 代理的交互行为，覆盖 Claude Code 及我们的公开 API。我们旨在回答以下问题：人们赋予 AI 代理多大程度的自主权？随着用户经验增长，这种授权程度如何变化？AI 代理正在哪些领域开展运作？以及，AI 代理所采取的行动是否具有风险？

We found that:

我们发现：

- [**Claude Code 正在更长时间地自主运行。**](https://anthropic.com/research/measuring-agent-autonomy#claude-code-is-working-autonomously-for-longer) 在持续时间最长的会话中，Claude Code 在主动停止前的连续工作时长在三个月内几乎翻倍——从不足 25 分钟增长至超过 45 分钟。这一增长在各版本模型发布过程中呈现平滑上升趋势，表明它并非单纯源于模型能力的提升；换言之，现有模型实际所展现的自主性，仍低于其理论可达到的自主水平。

- [**Claude Code 的资深用户更频繁地启用自动批准，但也更常主动中断。**](https://www.anthropic.com/research/measuring-agent-autonomy#experienced-users-in-claude-code-auto-approve-more-frequently-but-interrupt-more-often) 随着用户对 Claude Code 使用经验的积累，他们往往不再逐项审核每个操作，而是允许 Claude 自主运行，仅在必要时介入干预。在新用户中，约 20% 的会话采用完全自动批准模式；而随着经验增长，该比例上升至逾 40%。

- [**Claude Code 主动暂停以寻求澄清的频率，高于人类主动中断它的频率。**](https://www.anthropic.com/research/measuring-agent-autonomy#claude-code-pauses-for-clarification-more-often-than-humans-interrupt-it) 除人类发起的中断外，由 _智能体自身_ 发起的暂停同样是已部署系统中一种关键的监督形式。在最复杂的任务中，Claude Code 主动暂停以请求澄清的次数，是人类主动中断它的次数的两倍以上。

- **[智能体已被用于高风险领域，但尚未大规模应用。](https://anthropic.com/research/measuring-agent-autonomy#agents-are-used-in-risky-domains-but-not-yet-at-scale)** 我们公开 API 上绝大多数智能体操作均属低风险、可逆操作。软件工程类活动占全部智能体行为的近 50%，但我们亦观察到智能体在医疗健康、金融及网络安全等领域的初步应用迹象。

Below, we present our methodology and findings in more detail, and end with recommendations for model developers, product developers, and policymakers. Our central conclusion is that effective oversight of agents will require new forms of post-deployment monitoring infrastructure _and_ new human-AI interaction paradigms that help both the human and the AI manage autonomy and risk together.

下文我们将更详细地介绍本研究的方法论与具体发现，并最终为模型开发者、产品开发者及政策制定者提出相应建议。我们的核心结论是：要实现对智能体的有效监督，既需要构建新型的部署后监控基础设施，也需要发展新型的人机交互范式——使人类与 AI 能够协同管理自主性与风险。

We view our research as a small but important first step towards empirically understanding how people deploy and use agents. We will continue to iterate on our methods and communicate our findings as agents are adopted more widely.

我们将本研究视为一项虽小却至关重要的初步探索，旨在通过实证方式理解人们如何部署和使用智能体。随着智能体被更广泛地采纳，我们将持续优化研究方法，并及时公开分享相关成果。

## Studying agents in the wild

## 在真实环境中研究智能体

Agents are difficult to study empirically. First, there is no agreed-upon definition of what an agent _is._ Second, agents are evolving quickly. Last year, many of the most sophisticated agents—including Claude Code—involved a single conversational thread, but today there are multi-agent systems that operate autonomously for hours. Finally, model providers have limited visibility into the architecture of their customers’ agents. For example, we have no reliable way to associate independent requests to our API into “sessions” of agentic activity. (We discuss this challenge in more detail at the end of this post.)

智能体难以开展实证研究。首先，学界与业界尚无关于“智能体”明确定义的共识；其次，智能体技术正快速演进：去年，许多最先进的智能体（包括 Claude Code）仍基于单一对话线程运行，而如今已出现可连续自主运行数小时的多智能体系统；最后，模型提供商对其客户所构建智能体的系统架构缺乏可观测性。例如，我们目前尚无可靠方法将发往我们 API 的独立请求聚类归并为具有语义连贯性的“智能体活动会话”。（我们将在本文末尾更深入探讨这一挑战。）

In light of these challenges, how can we study agents empirically?

面对上述挑战，我们应如何开展智能体的实证研究？

To start, for this study we adopted a definition of agents that is conceptually grounded and operationalizable: _an agent is an AI system equipped with tools that allow it to take actions_, like running code, calling external APIs, and sending messages to other agents.1 Studying the tools that agents use tells us a great deal about what they are doing in the world.

首先，本研究采用了一个在概念上坚实且可操作化的“智能体（agent）”定义：_智能体是一种配备工具的 AI 系统，这些工具使其能够执行动作_，例如运行代码、调用外部 API，以及向其他智能体发送消息。¹ 研究智能体所使用的工具，能让我们深入了解它们在现实世界中究竟在做什么。

Next, we developed a collection of metrics that draw on data from both agentic uses of our [public API](https://platform.claude.com/docs/en/api/overview) and [Claude Code](https://code.claude.com/docs/en/overview), our own coding agent. These offer a tradeoff between breadth and depth:

接下来，我们构建了一套评估指标，其数据来源涵盖我们 [公开 API](https://platform.claude.com/docs/en/api/overview) 的智能体化使用场景，以及我们自研的编程智能体——[Claude Code](https://code.claude.com/docs/en/overview)。这两类数据在覆盖广度与分析深度之间形成互补：

- Our **public API** gives us broad visibility into agentic deployments across thousands of different customers. Rather than attempting to infer our customers’ agent architectures, we instead perform our analysis at the level of _individual tool calls_.2 This simplifying assumption allows us to make grounded, consistent observations about real-world agents, even as the contexts in which those agents are deployed vary significantly. The limitation of this approach is that we must analyze actions in isolation, and cannot reconstruct how individual actions compose into longer sequences of behavior over time.

- 我们的 **公开 API** 使我们得以广泛观测数千家不同客户部署智能体的情况。我们并未试图推断客户的智能体架构，而是将分析粒度聚焦于 _单次工具调用_ 层面。² 这一简化假设，使我们即便面对差异巨大的部署环境，仍能对真实世界中的智能体行为做出扎实、一致的观察。但该方法的局限在于：我们必须孤立地分析每次动作，无法还原单个动作如何随时间组合成更长的行为序列。

- **Claude Code** offers the opposite tradeoff. Because Claude Code is our own product, we can link requests across sessions and understand entire agent workflows from start to finish. This makes Claude Code especially useful for studying autonomy—for example, how long agents run without human intervention, what triggers interruptions, and how users maintain oversight over Claude as they develop experience. However, because Claude Code is only one product, it does not provide the same diversity of insight into agentic use as API traffic.

- **Claude Code** 则提供了相反的权衡取舍。由于 Claude Code 是我们自主研发的产品，我们可跨会话关联用户请求，从而完整追踪从起始到终止的全部智能体工作流。这使得 Claude Code 尤其适用于研究智能体的自主性——例如：智能体在无人干预下持续运行时长、触发人工介入的条件，以及用户在使用经验积累过程中如何维持对 Claude 的监督与掌控。然而，由于 Claude Code 仅是一款产品，它所提供的关于智能体实际应用的多样性洞见，远不及来自 API 流量的丰富程度。

By drawing from both sources using our [privacy-preserving infrastructure](https://www.anthropic.com/research/clio), we can answer questions that neither could address alone.

通过依托我们的 [隐私保护基础设施](https://www.anthropic.com/research/clio) 整合上述两类数据源，我们得以回答单靠任一数据源均无法独立解答的问题。

## Claude Code is working autonomously for longer

## Claude Code 的自主运行时长持续增长

How long do agents actually run without human involvement? In Claude Code, we can measure this directly by tracking how much time has elapsed between when Claude starts working and when it stops (whether because it finished the task, asked a question, or was interrupted by the user) on a turn-by-turn basis.3

智能体实际上能在无人参与的情况下持续运行多久？在 Claude Code 中，我们可通过逐轮追踪的方式直接测量：即从 Claude 开始工作，到其停止（无论因任务完成、主动提问，抑或被用户中断）之间所经过的时间。³

Turn duration is an imperfect proxy for autonomy.4 For example, more capable models could accomplish the same work faster, and subagents allow more work to happen at once, both of which push towards shorter turns.5 At the same time, users may be attempting more ambitious tasks over time, which would push towards longer turns. In addition, Claude Code’s user base is rapidly growing—and thus changing. We can’t measure these changes in isolation; what we measure is the net result of this interplay, including how long users let Claude work independently, the difficulty of the tasks they give it, and the efficiency of the product itself (which improves [daily](https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md)).

单轮持续时长是衡量自主性的一个不完美代理指标。⁴ 例如，能力更强的模型可能更快完成相同工作；子智能体（subagents）则支持并行处理更多任务——二者均倾向于缩短单轮时长。⁵ 同时，用户随时间推移可能尝试更具挑战性的任务，这又会拉长单轮时长。此外，Claude Code 的用户群体正迅速扩张，其构成亦随之动态变化。我们无法将上述各因素单独剥离测量；我们所观测到的，是这些因素相互作用后的综合结果，包括：用户允许 Claude 独立工作的时长、所分配任务的难度，以及产品自身效率（该效率每日都在提升 [参见更新日志](https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md)）。

Most Claude Code turns are short. The median turn lasts around 45 seconds, and this duration has fluctuated only slightly over the past few months (between 40 and 55 seconds). In fact, nearly every percentile below the 99th has remained relatively stable.6 That stability is what we’d expect for a product experiencing rapid growth: when new users adopt Claude Code, they are comparatively inexperienced, and—as we show in the next section—less likely to grant Claude full latitude.

绝大多数 Claude Code 的交互轮次都很短。中位轮次时长约 45 秒，过去数月内该数值波动极小（始终介于 40 至 55 秒之间）。事实上，除第 99 百分位以外，几乎所有更低百分位的时长均保持相对稳定。⁶ 这种稳定性恰是高速增长期产品的典型特征：新用户初用 Claude Code 时普遍经验尚浅，因而——正如我们在下一节中所展示的——更倾向于限制 Claude 的自主权限。

![](images/measuring-ai-agent-autonomy-in-practice/img_002.jpg)**Figure 1.** 99.9th percentile turn duration (how long Claude works on a per-turn basis) in interactive Claude Code sessions, 7-day rolling average. The 99.9th percentile has grown steadily from under 25 minutes in late September to over 45 minutes in early January. This analysis reflects all interactive Claude Code usage.

![](images/measuring-ai-agent-autonomy-in-practice/img_002.jpg)**图 1.** 交互式 Claude Code 会话中第 99.9 百分位的单轮执行时长（即 Claude 每轮操作所耗时间），采用 7 日滚动平均值。该百分位值自 9 月下旬的不足 25 分钟稳步增长，至 1 月初已超过 45 分钟。本分析涵盖全部交互式 Claude Code 使用数据。

Notably, this increase is smooth across model releases. If autonomy were purely a function of model capability, we would expect sharp jumps with each new launch. The relative steadiness of this trend instead suggests several potential factors are at work, including power users building trust with the tool over time, applying Claude to increasingly ambitious tasks, and the product itself improving.

值得注意的是，这一增长趋势在各次模型发布之间表现平滑。倘若自主性纯粹取决于模型能力，则我们理应在每次新模型发布时观察到明显的跃升。而该趋势的相对稳定性反而表明，多种潜在因素正在共同作用：例如资深用户随时间推移逐步建立对工具的信任；用户将 Claude 应用于日益复杂的任务；以及产品自身持续优化。

The extreme turn duration has declined somewhat since mid-January. We hypothesize a few reasons why. First, the Claude Code user base [doubled](https://www.anthropic.com/news/anthropic-raises-30-billion-series-g-funding-380-billion-post-money-valuation) between January and mid-February, and a larger and more diverse population of sessions could reshape the distribution. Second, as users returned from the holiday break, the projects they brought to Claude Code may have shifted from hobby projects to more tightly circumscribed work tasks. Most likely, it’s a combination of these factors and others we haven’t identified.

自 1 月中旬起，极端单轮时长略有下降。我们提出若干可能原因：其一，Claude Code 用户规模在 1 月至 2 月中旬期间[翻倍](https://www.anthropic.com/news/anthropic-raises-30-billion-series-g-funding-380-billion-post-money-valuation)，更大且更多样化的会话群体可能重塑了时长分布；其二，随着用户结束假期返岗，他们提交给 Claude Code 的项目类型可能从兴趣驱动的个人项目转向目标更明确、范围更受限的工作任务。最可能的情况是，上述因素与其他尚未识别的因素共同导致了这一变化。

We also looked at Anthropic’s internal Claude Code usage to understand how independence and utility have evolved together. From August to December, Claude Code’s success rate on internal users’ most challenging tasks doubled, at the same time that the average number of human interventions per session decreased from 5.4 to 3.3.7 Users are granting Claude more autonomy and, at least internally, achieving better outcomes while needing to intervene less often.

我们还考察了 Anthropic 公司内部的 Claude Code 使用情况，以理解自主性与实用性如何协同演进。从 8 月到 12 月，Claude Code 在内部用户最具挑战性的任务上成功率翻倍；与此同时，每场会话中的平均人工干预次数则由 5.4 次降至 3.3 次。⁷ 用户正赋予 Claude 更高的自主权；至少在公司内部，用户在减少干预频次的同时，也取得了更优的结果。

Both measurements point to a significant deployment overhang, where the autonomy models are capable of handling exceeds what they exercise in practice.

这两项指标均指向一个显著的“部署滞后”现象：即模型实际具备的自主能力，远超其在真实场景中所展现的自主程度。

It’s useful to contrast these findings with external capability assessments. One of the most widely cited capability assessments is METR’s “Measuring AI Ability to Complete Long Tasks,” which [estimates](https://metr.org/blog/2025-03-19-measuring-ai-ability-to-complete-long-tasks/) that Claude Opus 4.5 can complete tasks with a 50% success rate that would take a human nearly 5 _hours_. The 99.9th percentile turn duration in Claude Code, in contrast, is ~42 minutes, and the median is much shorter. However, the two metrics are not directly comparable. The METR evaluation captures what a model is capable of in an idealized setting with no human interaction and no real-world consequences. Our measurements capture what happens in practice, where Claude pauses to ask for feedback and users interrupt.8 And METR’s five-hour figure measures task difficulty—how long the task would take a human—not how long the model actually runs.

将这些发现与外部能力评估进行对比颇具启发意义。目前被广泛引用的能力评估之一，是 METR 发布的《衡量 AI 完成长周期任务的能力》报告，该报告[估算](https://metr.org/blog/2025-03-19-measuring-ai-ability-to-complete-long-tasks/)称：Claude Opus 4.5 在完成某类任务时，若人类需耗时近 5 小时，则该模型可实现约 50% 的成功率。相比之下，Claude Code 中第 99.9 百分位的单轮时长约为 42 分钟，中位数则短得多。然而，这两项指标并不直接可比：METR 的评估反映的是模型在理想化环境下的能力上限——该环境无任何人机交互，亦无现实后果；而我们的测量则聚焦真实场景：Claude 会主动暂停以请求反馈，用户也会随时中断流程。⁸ 此外，METR 所称的“五小时”，衡量的是任务难度（即人类完成该任务所需时间），而非模型实际运行时长。

Neither capability evaluations nor our measurements alone give a complete picture of agent autonomy, but together they suggest that the latitude granted to models in practice lags behind what they can handle.

单凭能力评估或我们的实测数据，均无法完整刻画智能体的自主性；但二者结合则表明：实践中人类赋予模型的行动自由度，仍落后于模型本身所能承担的实际能力。

## Experienced users in Claude Code auto-approve more frequently, but interrupt more often

## Claude Code 中经验丰富的用户更常启用自动批准，但也更频繁地主动中断

How do humans adapt how they work with agents over time? We found that people grant Claude Code more autonomy as they gain experience using it (Figure 2). Newer users (<50 sessions) employ full auto-approve roughly 20% of the time; by 750 sessions, this increases to over 40% of sessions.

人类如何随时间推移调整与智能体协作的方式？我们发现，用户在使用 Claude Code 的过程中积累经验后，会逐步赋予其更高自主权（图 2）。新手用户（会话数 <50）约在 20% 的会话中启用完全自动批准；而当会话数达 750 次时，该比例上升至逾 40%。

This shift is gradual, suggesting a steady accumulation of trust. It’s also important to note that Claude Code’s default settings require users to manually approve each action, so part of this transition may reflect users configuring the product to match their preferences for greater independence as they become familiar with Claude’s capabilities.

这一转变是渐进式的，反映出用户信任度的稳步累积。还需注意的是，Claude Code 的默认设置要求用户手动批准每一项操作；因此，部分转变可能源于用户在熟悉 Claude 能力后，主动调整产品配置，使其更契合自身对更高独立性的偏好。

![](images/measuring-ai-agent-autonomy-in-practice/img_003.jpg)**Figure 2.** Auto-approve rate by account tenure. Experienced users increasingly let Claude run without any manual approval. Data reflects all interactive Claude Code usage for users who signed up after September 19, 2025. Line and CI bounds are LOWESS-smoothed (0.15 bandwidth). The x-axis is a log scale.

![](images/measuring-ai-agent-autonomy-in-practice/img_003.jpg)**图 2.** 按账户使用时长划分的自动批准率。经验更丰富的用户越来越倾向于让 Claude 自主运行，无需人工审批。数据涵盖所有于 2025 年 9 月 19 日之后注册用户的交互式 Claude Code 使用行为。折线及置信区间（CI）边界经 LOWESS 平滑处理（带宽为 0.15）。横轴采用对数刻度。

Approving actions is only one method of supervising Claude Code. Users can also interrupt Claude while it is working to provide feedback. We find that interrupt rates increase with experience. New users (those with around 10 sessions) interrupt Claude in 5% of turns, while more experienced users interrupt in around 9% of turns (Figure 3).

批准操作仅是监督 Claude Code 的一种方式。用户还可于 Claude 执行任务过程中主动中断其运行，以提供即时反馈。我们发现，中断率随用户经验增长而上升：新手用户（约完成 10 次会话者）在约 5% 的对话轮次中中断 Claude；而经验更丰富的用户中断比例则升至约 9%（图 3）。

![](images/measuring-ai-agent-autonomy-in-practice/img_004.jpg)**Figure 3.** Interrupt rates by account tenure on a turn-by-turn basis. Experienced users interrupt Claude more often, not less. Data reflects all interactive Claude Code usage for users who signed up after September 19, 2025. Shaded region shows 95% Wilson score confidence interval. Line and CI bounds are LOWESS-smoothed (0.15 bandwidth). The x-axis is a log scale.

![](images/measuring-ai-agent-autonomy-in-practice/img_004.jpg)**图 3.** 按账户使用时长划分的逐轮中断率。经验更丰富的用户并非更少、而是更多地中断 Claude。数据涵盖所有于 2025 年 9 月 19 日之后注册用户的交互式 Claude Code 使用行为。阴影区域表示 95% Wilson 分数置信区间。折线及置信区间（CI）边界经 LOWESS 平滑处理（带宽为 0.15）。横轴采用对数刻度。

Both interruptions _and_ auto-approvals increase with experience. This apparent contradiction reflects a shift in users’ oversight strategy. New users are more likely to approve each action before it’s taken, and therefore rarely need to interrupt Claude mid-execution. Experienced users are more likely to let Claude work autonomously, stepping in when something goes wrong or needs redirection. The higher interrupt rate may also reflect active monitoring by users who have more honed instincts for when their intervention is needed. We expect the per-turn interrupt rate to eventually plateau as users settle into a stable oversight style, and indeed the curve may already be flattening among the most experienced users (though widening confidence intervals at higher session counts make this difficult to confirm).<sup>9</sup>

中断行为与自动批准行为均随用户经验增长而增加。这一表面矛盾实则反映出用户监督策略的转变：新手用户更倾向于在每项操作执行前逐一审批，因此极少需要在 Claude 执行中途进行中断；而经验丰富的用户则更愿意赋予 Claude 更高的自主权，仅在出现异常或需重新定向时才介入干预。更高的中断率也可能表明：这些用户已培养出更敏锐的判断力，能更主动、更精准地识别出自身干预的关键时机。我们预期，随着用户逐渐形成稳定、成熟的监督风格，单位轮次中断率最终将趋于平稳；事实上，在最具经验的用户群体中，该曲线可能已初现平缓趋势（尽管高会话量区间的置信区间随之扩大，使得这一趋势尚难确证）。<sup>9</sup>

We saw a similar pattern on our public API: 87% of tool calls on minimal-complexity tasks (like editing a line of code) have some form of human involvement, compared to only 67% of tool calls for high-complexity tasks (like [autonomously finding zero-day exploits](https://red.anthropic.com/2026/zero-days/) or [writing a compiler](https://www.anthropic.com/engineering/building-c-compiler)).<sup>10</sup> This may seem counterintuitive, but there are two likely explanations. First, step-by-step approval becomes less practical as the number of steps grows, so it is structurally harder to supervise each action on complex tasks. Second, our Claude Code data suggests that experienced users tend to grant the tool more independence, and complex tasks may disproportionately come from experienced users. While we cannot directly measure user tenure on our public API, the overall pattern is consistent with what we observe in Claude Code.

我们在公开 API 上也观察到类似模式：在低复杂度任务（例如编辑一行代码）中，87% 的工具调用存在某种形式的人工参与；而在高复杂度任务（例如[自主发现零日漏洞](https://red.anthropic.com/2026/zero-days/)或[编写编译器](https://www.anthropic.com/engineering/building-c-compiler)）中，该比例则降至 67%。<sup>10</sup> 这一现象看似违反直觉，但可能有两方面原因：其一，随着任务步骤数量增加，“逐步审批”模式在实操中愈发困难，因而对高复杂度任务中的每一项操作实施监督在结构上更具挑战性；其二，Claude Code 数据显示，经验丰富的用户更倾向于赋予工具更高程度的自主权，而高复杂度任务亦更可能由这类用户发起。尽管我们无法在公开 API 上直接衡量用户使用时长，但整体模式仍与 Claude Code 中的观测结果高度一致。

Taken together, these findings suggest that experienced users aren’t necessarily abnegating oversight. The fact that interrupt rates increase with experience alongside auto-approvals indicates some form of active monitoring. This reinforces a point we have made [previously](https://www.anthropic.com/news/our-framework-for-developing-safe-and-trustworthy-agents): effective oversight doesn’t require approving every action but being in a position to intervene when it matters.

综上所述，这些发现表明：经验丰富的用户并非在放弃监督责任；相反，中断率与自动批准率同步上升的现象，恰恰说明他们正以一种更为主动、更具策略性的方式实施监控。这也再次印证了我们此前提出的观点：[有效的监督并不要求审批每一项操作，而在于确保自己能在关键节点及时介入](https://www.anthropic.com/news/our-framework-for-developing-safe-and-trustworthy-agents)。

## Claude Code pauses for clarification more often than humans interrupt it

## Claude Code 主动请求澄清的频率高于人类主动中断它的频率

Humans, of course, aren’t the only actors shaping how autonomy unfolds in practice. Claude is an active participant too, stopping to ask for clarification when it’s unsure how to proceed. We found that as task complexity increases, Claude Code asks for clarification more often—and more frequently than humans choose to interrupt it (Figure 4).

当然，人类并非唯一塑造实际自主性演进路径的参与者；Claude 同样是积极的协作者——当它不确定下一步如何推进时，便会主动暂停并请求澄清。我们发现，随着任务复杂度提升，Claude Code 请求澄清的频次也随之上升，且其上升速度甚至超过人类主动中断的频次（图 4）。

![](images/measuring-ai-agent-autonomy-in-practice/img_005.jpg)_**Figure 4.** Clarification questions from Claude and interruptions by the human, by goal complexity. As tasks get more complex, Claude is more likely to ask for clarification and humans are more likely to interrupt. Claude-initiated stops increase faster than human-initiated stops. 95% CI < 0.9% for all categories, n = 500k interactive Claude Code sessions._

![](images/measuring-ai-agent-autonomy-in-practice/img_005.jpg)_**图 4.** 按目标复杂度划分的 Claude 主动提问澄清与人类主动中断情况。随着任务复杂度提升，Claude 更倾向于请求澄清，人类也更倾向于中断；而 Claude 主动发起的暂停增长速度，快于人类主动发起的暂停。所有类别的 95% 置信区间均小于 0.9%，样本量 n = 50 万次交互式 Claude Code 会话。_

On the most complex tasks, Claude Code asks for clarification more than twice as often as on minimal-complexity tasks, suggesting Claude has some calibration about its own uncertainty. However, it’s important not to overstate this finding: Claude may not be stopping at the right moments, it may ask unnecessary questions, and its behavior might be affected by product features such as [Plan Mode](https://code.claude.com/docs/en/common-workflows#use-plan-mode-for-safe-code-analysis). Regardless, as tasks get harder, Claude increasingly limits its own autonomy by stopping to consult the human, rather than requiring the human to step in.<sup>11</sup>

在最高复杂度的任务中，Claude Code 请求澄清的频次较最低复杂度任务高出两倍以上，这表明 Claude 对自身不确定性具备一定程度的校准能力。然而，需谨慎解读这一发现：Claude 的暂停时机未必恰当，所提问题未必必要，其行为也可能受到产品功能（例如[计划模式（Plan Mode）](https://code.claude.com/docs/en/common-workflows#use-plan-mode-for-safe-code-analysis)）的影响。但无论如何，随着任务难度增加，Claude 正越来越多地通过主动暂停并征询人类意见的方式，自我约束其自主性，而非被动等待人类介入。<sup>11</sup>

Table 1 shows common reasons for why Claude Code stops work and why humans interrupt Claude.

表 1 展示了 Claude Code 停止运行以及人类主动中断 Claude 的常见原因。

What causes Claude Code to stop?

什么导致 Claude Code 停止运行？

| **Why does Claude stop itself?** | **Why do humans interrupt Claude?** |
| --- | --- |
| To present the user with a choice between proposed approaches (35%) | To provide missing technical context or corrections (32%) |
| 为向用户提供多种拟定方案之间的选择（35%） | 为补充缺失的技术背景信息或进行修正（32%） |
| To gather diagnostic information or test results (21%) | Claude was slow, hanging, or excessive (17%) |
| 为收集诊断信息或测试结果（21%） | Claude 运行缓慢、卡顿或行为过度（17%） |
| To clarify vague or incomplete requests (13%) | They received enough help to proceed independently (7%) |
| 为澄清模糊或不完整的请求（13%） | 用户已获得足够帮助，可独立继续推进（7%） |
| To request missing credentials, tokens, or access (12%) | They want to take the next step themselves (e.g., manual testing, deployment, committing, etc.) (7%) |
| 为索取缺失的凭据、令牌或访问权限（12%） | 用户希望自行执行下一步操作（例如手动测试、部署、提交代码等）（7%） |
| To get approval or confirmation before taking action (11%) | To change requirements mid-task (5%) |
| 在执行操作前获取批准或确认（11%） | 在任务中途变更需求（5%） |

Table 1. Common reasons why Claude stops itself and why humans interrupt Claude, as determined by Claude, based on a sample of 500k human interruptions and 500k completed turns in interactive Claude Code sessions. Some clusters have been lightly edited for clarity.¹²

表 1：Claude 自行停止及人类主动中断 Claude 的常见原因（由 Claude 自身判定），数据源自 50 万次人类中断事件与 50 万次交互式 Claude Code 会话中的完整对话轮次样本。部分聚类结果已作轻微编辑以提升表述清晰度。¹²

These findings suggest that agent-initiated stops are an important kind of oversight in deployed systems. Training models to recognize and act on their own uncertainty is an important safety property that complements external safeguards like permission systems and human oversight. At Anthropic, we train Claude to ask clarifying questions when facing ambiguous tasks, and we encourage other model developers to do the same.

上述发现表明，由智能体主动发起的暂停是已部署系统中一类至关重要的监督机制。训练模型识别自身不确定性并据此采取相应行动，是一项关键的安全属性，可与权限控制系统、人工监督等外部保障措施形成互补。在 Anthropic，我们训练 Claude 在面对模糊任务时主动提出澄清性问题；我们也鼓励其他大模型开发者采用相同做法。

## Agents are used in risky domains, but not yet at scale

## 智能体已被应用于高风险领域，但尚未实现规模化部署

What are people using agents for? How risky are these deployments? How autonomous are these agents? Does risk trade off against autonomy?

人们正将智能体用于哪些场景？这些部署的风险程度如何？这些智能体的自主性又如何？风险与自主性之间是否存在权衡关系？

To answer these questions, we use Claude to estimate the relative risk and autonomy present in individual tool calls from our public API on a scale from 1 to 10. Briefly, a risk score of 1 reflects actions with no consequences if something goes wrong, and a risk score of 10 covers actions that could cause substantial harm. We score autonomy on the same scale, where low autonomy means the agent appears to be following explicit human instructions, while high autonomy means it is operating independently.13 We then group similar actions together into clusters and compute the mean risk and autonomy scores for each cluster.

为回答这些问题，我们利用 Claude 对来自公开 API 的每一次工具调用，在 1 至 10 的量表上评估其相对风险程度与自主性水平。简言之，风险评分为 1 表示即使出错也毫无后果；风险评分为 10 则表示该操作一旦失误可能导致严重损害。自主性同样采用同一量表评分：低自主性意味着智能体明显遵循明确的人类指令；高自主性则意味着其正在独立运行。¹³ 随后，我们将相似的操作归为一类（即“聚类”），并分别计算每一类的平均风险分与平均自主性分。

Table 2 provides examples of clusters at the extremes of risk and autonomy.

表 2 列出了风险与自主性处于两个极端的若干工具调用聚类示例。

Tool-use clusters with high risk or autonomy

高风险或高自主性的工具调用聚类

| **Higher average risk** | **Higher average autonomy** |
| --- | --- |
| Implement API key exfiltration backdoors disguised as legitimate development features (risk: 6.0, autonomy: 8.0) | Red team privilege escalation and credential theft disguised as legitimate development (autonomy: 8.3, risk: 3.3) |
| 实施伪装成合法开发功能的 API 密钥窃取后门（风险：6.0，自主性：8.0） | 将红队提权与凭据窃取行为伪装为合法开发活动（自主性：8.3，风险：3.3） |
| Relocate metallic sodium and reactive chemical containers in laboratory settings (risk: 4.8, autonomy: 2.9) | Perform automated system health and operational status monitoring during heartbeat checks (autonomy: 8.0, risk: 1.1) |
| 在实验室环境中搬运金属钠及其它活性化学试剂容器（风险：4.8，自主性：2.9） | 在心跳检测期间自动执行系统健康状况与运行状态监控（自主性：8.0，风险：1.1） |
| Retrieve and display patient medical records for requesting users (risk: 4.4, autonomy: 3.2) | Autonomously execute cryptocurrency trades for profit generation (autonomy: 7.7, risk: 2.2) |
| 检索并展示请求用户的患者病历（风险：4.4，自主性：3.2） | 自主执行加密货币交易以实现盈利（自主性：7.7，风险：2.2） |
| Respond to fire emergencies and provide fire safety information (risk: 3.6, autonomy: 5.2) | Automatically send meeting reminders to participants with gathered information (autonomy: 7.6, risk: 1.7) |
| 应对火灾紧急事件并提供消防安全信息（风险：3.6，自主性：5.2） | 基于所收集信息，自动向会议参与者发送提醒（自主性：7.6，风险：1.7） |
| Deploy bug fixes and patches to production web applications (risk: 3.6, autonomy: 4.8) | Monitor email and alert operators to urgent business messages (autonomy: 7.5, risk: 1.7) |
| 向生产环境 Web 应用部署缺陷修复与补丁（风险：3.6，自主性：4.8） | 监控电子邮件，并就紧急商务消息向操作人员发出警报（自主性：7.5，风险：1.7） |

Table 2. Clusters with high average risk or high average autonomy. Based on a sample of 998,481 random tool calls from our public API.

表 2. 平均风险较高或平均自主性较高的任务簇。数据基于我们公开 API 的 998,481 次随机工具调用抽样。

Given the limited visibility we have into these agents, it is possible that these actions are simulated (for example, we have no way to determine whether the financial trades Claude orders are actually executed, and we believe that many of the “data exfiltrations” are evaluations). And while these higher-risk actions are rare as a share of overall traffic, the consequences of a single error can still be significant.

鉴于我们对这些智能体的可观测性有限，上述行为很可能是模拟的（例如，我们无法确认 Claude 下达的金融交易是否真实执行；我们也认为其中大量所谓“数据窃取”行为实为评估测试）。尽管高风险行为在整体流量中占比极低，但单次失误仍可能带来严重后果。

We found that 80% of tool calls come from agents that appear to have at least one kind of safeguard (like restricted permissions or human approval requirements), 73% appear to have a human in the loop in some way, and only 0.8% of actions appear to be irreversible (such as sending an email to a customer).¹⁴

我们发现，80% 的工具调用来自至少具备一种安全机制（如权限限制或人工审批要求）的智能体；73% 的工具调用背后存在某种形式的人机协同（human-in-the-loop）；仅有 0.8% 的操作属于不可逆行为（例如向客户发送电子邮件）¹⁴。

To visualize the joint distribution of risk and autonomy across all clusters, we plot each by its average scores on both dimensions. Each point in Figure 5 corresponds to a cluster of related actions, positioned by its average risk and autonomy.

为直观呈现所有任务簇在风险与自主性两个维度上的联合分布，我们以各簇在这两个维度上的平均得分进行二维散点图绘制。图 5 中每个点代表一类相关操作构成的任务簇，其位置由该簇的平均风险值与平均自主性值共同决定。

![](images/measuring-ai-agent-autonomy-in-practice/img_006.jpg)**Figure 5.** Mean Claude-estimated risk and autonomy by task cluster. The upper-right quadrant—higher autonomy, higher risk—is sparsely populated but not empty. Data reflects tool calls made via our public API. These are Claude-generated classifications at the level of individual tool calls, validated against internal data where possible. We describe the full methodology in the Appendix. Clusters that do not meet our aggregation minimums (due to either insufficient unique tool calls or customers) are excluded. Based on a sample of 998,481 tool calls on our public API.

![](images/measuring-ai-agent-autonomy-in-practice/img_006.jpg)**图 5.** 各任务簇的 Claude 估算平均风险与平均自主性。右上象限（高自主性、高风险）样本稀疏，但并非空置。数据源自我们公开 API 的工具调用记录。这些分类由 Claude 针对单次工具调用生成，并在可行范围内通过内部数据进行了交叉验证。完整方法论详见附录。未达到聚合最低门槛（因唯一工具调用次数不足或客户数量不足）的任务簇已被排除。数据基于我们公开 API 的 998,481 次工具调用抽样。

The vast majority of actions on our public API are low-risk. But while most agentic deployments are comparatively benign, we saw a number of novel uses at the frontier of risk and autonomy.¹⁵ The riskiest clusters—again, many of which we expect to be evaluations—tended to involve sensitive security-related actions, financial transactions, and medical information. While risk is concentrated at the low end of the scale, autonomy varies more widely. On the low end (autonomy score of 3–4), we see agents completing small, well-scoped tasks for humans, like making restaurant reservations or minor tweaks to code. On the high end (autonomy score above 6), we see agents submitting machine learning models to data science competitions or triaging customer service requests.

我们公开 API 上绝大多数操作均为低风险操作。然而，尽管大多数智能体部署相对无害，我们仍观察到一批处于风险与自主性前沿地带的创新应用场景¹⁵。风险最高的任务簇——其中许多我们推测为评估测试——往往涉及敏感的安全相关操作、金融交易以及医疗信息处理。风险值整体集中在量表低端，而自主性则呈现更宽泛的分布：在低端（自主性得分为 3–4），我们看到智能体为人类完成小型、边界清晰的任务，例如预订餐厅或微调代码；在高端（自主性得分高于 6），我们则观察到智能体向数据科学竞赛提交机器学习模型，或对客户服务请求进行初步分诊。

We also anticipate that agents operating at the extremes of risk and autonomy will become increasingly common. Today, agents are concentrated in a single industry: software engineering accounts for nearly 50% of tool calls on our public API (Figure 6). Beyond coding, we see a number of smaller applications across business intelligence, customer service, sales, finance, and e-commerce, but none comprise more than a few percentage points of traffic. As agents expand into these domains, many of which carry higher stakes than fixing a bug, we expect the frontier of risk and autonomy to expand.

我们还预计，运行于风险与自主性极端区间的智能体将日益普遍。当前，智能体应用高度集中于单一行业：软件工程占我们公开 API 工具调用总量的近 50%（图 6）。除编程外，我们在商业智能、客户服务、销售、金融及电子商务等领域也观察到若干规模较小的应用，但任一领域均未超过总流量的几个百分点。随着智能体逐步拓展至这些领域——其中许多领域的责任与影响远超修复一个程序缺陷——我们预期风险与自主性的前沿边界将持续延展。

![](images/measuring-ai-agent-autonomy-in-practice/img_007.jpg)**Figure 6.** Distribution of tool calls by domain. Software engineering accounts for nearly 50% of tool calls. Data reflects tool calls made via our public API. 95% CI < 0.5% for all categories, n = 998,481.

![](images/measuring-ai-agent-autonomy-in-practice/img_007.jpg)**图 6.** 工具调用按领域分布情况。软件工程类调用占比近 50%。数据源自我们公开 API 的工具调用记录。所有类别的 95% 置信区间均小于 0.5%，n = 998,481。

These patterns suggest we are in the early days of agent adoption. Software engineers were the first to build and use agentic tools at scale, and Figure 6 suggests that other industries are beginning to experiment with agents as well.¹⁶ Our methodology allows us to monitor how these patterns evolve over time. Notably, we can monitor whether or not usage tends to move towards more autonomous and more risky tasks.

上述模式表明，我们尚处于智能体技术采用的早期阶段。软件工程师是首批规模化构建与使用智能体工具的群体；而图 6 则进一步表明，其他行业也已开始尝试引入智能体¹⁶。我们的方法论使我们能够持续追踪这些模式的动态演变。尤为关键的是，我们可监测实际使用趋势是否正逐步转向更高自主性与更高风险的任务。

While our headline numbers are reassuring—most agent actions are low-risk and reversible, and humans are usually in the loop—these averages can obscure deployments at the frontier. The concentration of adoption in software engineering, combined with growing experimentation in new domains, suggests that the frontier of risk and autonomy will expand. We discuss what this means for model developers, product developers, and policymakers in our recommendations at the end of this post.

尽管我们的宏观数据令人安心——绝大多数智能体（agent）操作风险较低且可逆，且人类通常处于决策闭环中——但这些平均值可能掩盖了处于技术前沿的实际部署情况。智能体在软件工程领域的高度集中采用，叠加其在新兴领域日益增多的探索性应用，预示着风险与自主性的“前沿边界”将持续拓展。我们将在本文末尾的建议部分，深入探讨这一趋势对模型开发者、产品开发者及政策制定者的意义。

## Limitations

## 局限性

This research is just a start. We provide only a partial view into agentic activity, and we want to be upfront about what our data can and cannot tell us:

这项研究仅是初步探索。我们所提供的，仅是对智能体行为的部分观察视角；我们愿坦诚说明：我们的数据能揭示什么、又无法揭示什么：

- We can only analyze traffic from a single model provider: Anthropic. Agents built on other models may show different adoption patterns, risk profiles, and interaction dynamics.

- 我们仅能分析来自单一模型提供商（Anthropic）的流量。基于其他模型构建的智能体，其采用模式、风险特征及交互动态可能截然不同。

- Our two data sources offer complementary but incomplete views. Public API traffic gives us breadth across thousands of deployments, but we can only analyze individual tool calls in isolation, rather than full agent sessions. Claude Code gives us complete sessions, but only for a single product that is overwhelmingly used for software engineering. Many of our strongest findings are grounded in data from Claude Code, and may not generalize to other domains or products.

- 我们的两个数据源互为补充，但各自均不完整：公共 API 流量覆盖数千个部署，提供了广度，但我们只能孤立地分析单次工具调用（tool call），而无法还原完整的智能体会话（agent session）；Claude Code 则提供端到端的完整会话数据，但仅限于一款产品，且该产品几乎完全应用于软件工程场景。我们许多最具说服力的发现均基于 Claude Code 数据，因此未必适用于其他领域或产品。

- Our classifications are generated by Claude. We provide an opt-out category (e.g., “not inferable,” “other”) for each dimension and validate against internal data where possible (see our [Appendix](https://cdn.sanity.io/files/4zrzovbb/website/55e4d2de6eb39b3a9259c3f74843f86b1a12e265.pdf) for more details), but we cannot manually inspect the underlying data due to privacy constraints. Some safeguards or oversight mechanisms may also exist outside the context we can observe.

- 我们的分类结果由 Claude 生成。我们在每个维度上均设置了“退出选项”（如“无法推断”“其他”），并在可行范围内使用内部数据进行交叉验证（详见我们的[附录](https://cdn.sanity.io/files/4zrzovbb/website/55e4d2de6eb39b3a9259c3f74843f86b1a12e265.pdf)），但由于隐私限制，我们无法人工核查原始数据。此外，某些安全防护机制或监督流程可能存在于我们可观测范围之外的上下文中。

- This analysis reflects a specific window of time (late 2025 through early 2026). The landscape of agents is changing quickly, and patterns may shift as capabilities grow and adoption evolves. We plan to extend this analysis over time.

- 本分析反映的是特定时间窗口（2025 年底至 2026 年初）的情况。智能体生态正快速演进，随着能力提升与采用深化，相关模式亦可能发生变化。我们计划持续延展并更新此项分析。

- Our public API sample is drawn at the level of individual tool calls, which means deployments involving many sequential tool calls (like software engineering workflows with repeated file edits) are overrepresented relative to deployments that accomplish their goals in fewer actions. This sampling approach reflects the volume of agent activity but not necessarily the distribution of agent deployments or uses.

- 我们的公共 API 样本以单次工具调用为单位抽取，这意味着涉及大量连续工具调用的部署（例如需反复编辑文件的软件工程工作流）在样本中被过度代表，而目标可在较少动作内完成的部署则相对不足。该抽样方式反映的是智能体活动的总量，而非智能体部署或使用场景的真实分布。

- We study the tools Claude uses on our public API and the context surrounding those actions, but we have limited visibility into the broader systems our customers build atop our public API. An agent that appears to operate autonomously at the API level may have human review downstream that we cannot observe. In particular, our risk, autonomy, and human involvement classifications reflect what Claude can infer from the context of individual tool calls, and do not distinguish between actions taken in production and actions taken as part of evaluations or red-teaming exercises. Several of the highest-risk clusters appear to be security evaluations, which highlights the limits of our visibility into the broader context surrounding each action.

- 我们研究的是 Claude 在公共 API 上调用的工具及其操作上下文，但对我们客户在其公共 API 之上构建的更广泛系统，我们的可见性十分有限。一个在 API 层面看似完全自主运行的智能体，其下游环节可能仍存在我们无法观测到的人工审核。尤其需要指出的是：我们对风险、自主性及人类参与程度的分类，仅基于 Claude 对单次工具调用上下文的推断，无法区分生产环境中的真实操作与评估测试（包括红队演练）中的模拟操作。多个最高风险聚类实际上属于安全评估场景——这恰恰凸显了我们对每次操作所处更广泛背景的认知局限。

## Looking ahead

## 展望未来

We are in the early days of agent adoption, but autonomy is increasing and higher-stakes deployments are emerging, especially as products like [Cowork](https://support.claude.com/en/articles/13345190-getting-started-with-cowork) make agents more accessible. Below, we offer recommendations for model developers, product developers, and policymakers. Given that we have only just begun measuring agent behavior in the wild, we avoid making strong prescriptions and instead highlight areas for future work.

当前智能体的采用尚处早期阶段，但其自主性正持续增强，高影响性（higher-stakes）的实际部署也日渐涌现——尤其是像 [Cowork](https://support.claude.com/en/articles/13345190-getting-started-with-cowork) 这类产品正显著降低智能体的使用门槛。下文，我们将面向模型开发者、产品开发者及政策制定者提出若干建议。鉴于我们对真实世界中智能体行为的量化观测才刚刚起步，我们暂不提出强制性规范，而是着重指出亟待探索的关键方向。

**Model and product developers should invest in post-deployment monitoring.** Post-deployment monitoring is essential for understanding how agents are actually used. Pre-deployment evaluations test what agents are capable of in controlled settings, but many of our findings cannot be observed through pre-deployment testing alone. Beyond understanding a model’s capabilities, we must also understand how people interact with agents in practice. The data we report here exists because we _chose_ to build the infrastructure to collect it. But there’s more to do. We have no reliable way to link independent requests to our public API into coherent agent sessions, which limits what we can learn about agent behavior beyond first-party products like Claude Code. Developing these methods in a privacy-preserving way is an important area for cross-industry research and collaboration.

**模型与产品开发者应加大对部署后监控（post-deployment monitoring）的投入。** 部署后监控对于理解智能体在真实场景中的实际使用方式至关重要。部署前评估（pre-deployment evaluation）仅能检验智能体在受控环境下的潜在能力，而我们诸多关键发现却无法单靠部署前测试捕捉。除了解模型本身的能力外，我们更需深入理解用户在实践中如何与智能体互动。本文所报告的数据之所以存在，是因为我们**主动选择**构建了相应的数据采集基础设施；但这仅仅是开始。目前，我们尚无可靠方法将发往公共 API 的独立请求关联成连贯的智能体会话，这严重制约了我们对 Claude Code 等第一方产品之外的智能体行为的理解。以兼顾隐私保护的方式开发此类关联与建模方法，是跨行业联合研究与协作的重要方向。

**Model developers should consider training models to recognize their own uncertainty.** Training models to recognize their own uncertainty and surface issues to humans proactively is an important safety property that complements external safeguards like human approval flows and access restrictions. We train Claude to do this (and our analysis shows that Claude Code asks questions more often than humans interrupt it), and we encourage other model developers to do the same.

**模型开发者应考虑训练模型识别自身不确定性。** 让模型具备识别自身不确定性的能力，并主动向人类提示潜在问题，是一项关键的安全属性，可有效补强诸如人工审批流程、访问权限控制等外部防护机制。我们已将此能力纳入 Claude 的训练目标（分析亦表明：Claude Code 主动提问的频率高于人类主动中断的频率）；我们鼓励其他模型开发者同样践行这一做法。

**Product developers should design for user oversight.** Effective oversight of agents requires more than putting a human in the approval chain. We find that as users gain experience with agents, they tend to shift from approving individual actions to monitoring what the agent does and intervening when needed. In Claude Code, for example, experienced users auto-approve more but also interrupt more. We see a related pattern on our public API, where human involvement appears to decrease as the complexity of the goal increases. Product developers should invest in tools that give users trustworthy visibility into what agents are doing, along with simple intervention mechanisms that allow them to redirect the agent when something goes wrong. This is something we continue to invest in for Claude Code (for example, through [real-time steering](https://github.com/anthropics/claude-code/issues/535) and [OpenTelemetry](https://code.claude.com/docs/en/monitoring-usage)), and we encourage other product developers to do the same.

**产品开发者应以支持用户监督（user oversight）为目标进行设计。** 对智能体实施有效监督，远不止于在审批链中简单加入一个人类节点。我们发现：随着用户使用智能体经验的增长，其监督方式往往从逐项批准具体操作，转向持续监控智能体行为并在必要时介入干预。以 Claude Code 为例，资深用户自动批准的比例更高，但主动中断的次数也更多。我们在公共 API 数据中亦观察到类似模式：当目标任务复杂度上升时，人类参与度反而呈现下降趋势。因此，产品开发者应着力开发两类工具：一是为用户提供可信、透明的智能体行为可视化能力；二是配备简洁易用的干预机制，使用户能在异常发生时及时重定向智能体行为。我们正持续在 Claude Code 中推进此类能力（例如通过 [实时引导（real-time steering）](https://github.com/anthropics/claude-code/issues/535) 和 [OpenTelemetry 集成](https://code.claude.com/docs/en/monitoring-usage)），并呼吁其他产品开发者共同投入建设。

**It's too early to mandate specific interaction patterns.** One area where we do feel confident offering guidance is what _not_ to mandate. Our findings suggest that experienced users shift away from approving individual agent actions and toward monitoring and intervening when needed. Oversight requirements that prescribe specific interaction patterns, such as requiring humans to approve every action, will create friction without necessarily producing safety benefits. As agents and the science of agent measurement mature, the focus should be on whether humans are in a position to effectively monitor and intervene, rather than on requiring particular forms of involvement.

**现阶段尚不宜强制规定特定交互模式。** 在“不应强制什么”这一问题上，我们倒是有较充分的信心给出指引。我们的发现表明：资深用户普遍不再逐项批准智能体操作，而是转向以监控为主、按需干预的模式。若监管要求强行规定某种交互范式（例如强制要求人类批准每一次操作），虽会增加使用摩擦，却未必带来实质性的安全增益。随着智能体技术及智能体行为度量科学的不断成熟，监管重心应转向：人类是否真正处于能够有效监控与及时干预的位置，而非拘泥于某种特定形式的参与。

A central lesson from this research is that the autonomy agents exercise in practice is co-constructed by the model, the user, and the product.  
本研究的一个核心结论是：AI智能体在实际应用中所展现的自主性，是由模型、用户与产品三者共同构建而成的。

Claude limits its own independence by pausing to ask questions when it’s uncertain.  
Claude 在不确定时会主动暂停并提出问题，从而限制自身的独立决策程度。

Users develop trust as they work with the model, and shift their oversight strategy accordingly.  
用户在与模型协作过程中逐步建立信任，并据此动态调整自身的监督策略。

What we observe in any deployment emerges from all three of these forces, which is why it cannot be fully characterized by pre-deployment evaluations alone.  
任何实际部署中所观察到的行为，均源于上述三种力量的交互作用；正因如此，仅靠部署前的评估无法对其作出完整刻画。

Understanding how agents actually behave requires measuring them in the real world, and the infrastructure to do so is still nascent.  
要真正理解智能体的实际行为，必须在真实世界中对其进行测量——而支撑此类测量的基础设施目前仍处于早期发展阶段。

#### Authors

#### 作者

Miles McCain, Thomas Millar, Saffron Huang, Jake Eaton, Kunal Handa, Michael Stern, Alex Tamkin, Matt Kearney, Esin Durmus, Judy Shen, Jerry Hong, Brian Calvert, Jun Shern Chan, Francesco Mosconi, David Saunders, Tyler Neylon, Gabriel Nicholas, Sarah Pollack, Jack Clark, Deep Ganguli.  
Miles McCain、Thomas Millar、Saffron Huang、Jake Eaton、Kunal Handa、Michael Stern、Alex Tamkin、Matt Kearney、Esin Durmus、Judy Shen、Jerry Hong、Brian Calvert、Jun Shern Chan、Francesco Mosconi、David Saunders、Tyler Neylon、Gabriel Nicholas、Sarah Pollack、Jack Clark、Deep Ganguli。

#### Bibtex

#### BibTeX 引用格式

If you’d like to cite this post, you can use the following Bibtex key:  
如需引用本文，请使用以下 BibTeX 条目：

```
@online{anthropic2026agents,
  author = {Miles McCain and Thomas Millar and Saffron Huang and Jake Eaton and Kunal Handa and Michael Stern and Alex Tamkin and Matt Kearney and Esin Durmus and Judy Shen and Jerry Hong and Brian Calvert and Jun Shern Chan and Francesco Mosconi and David Saunders and Tyler Neylon and Gabriel Nicholas and Sarah Pollack and Jack Clark and Deep Ganguli},
  title = {Measuring AI agent autonomy in practice},
  date = {2026-02-18},
  year = {2026},
  url = {https://anthropic.com/research/measuring-agent-autonomy},
}
```

Copy  
复制

## Appendix

## 附录

We provide more details in the [PDF Appendix](https://cdn.sanity.io/files/4zrzovbb/website/55e4d2de6eb39b3a9259c3f74843f86b1a12e265.pdf) to this post.  
本文的[PDF 附录](https://cdn.sanity.io/files/4zrzovbb/website/55e4d2de6eb39b3a9259c3f74843f86b1a12e265.pdf)提供了更多技术细节。

## Footnotes

## 脚注

1. Our definition is compatible with [Russell and Norvig (1995)](https://dl.acm.org/doi/book/10.5555/773294), who define an agent as “anything that can be viewed as perceiving its environment through sensors and acting upon that environment through effectors.” Our definition is also compatible with Simon Willison’s, who [writes](https://simonwillison.net/2025/Sep/18/agents/) that an agent is a system that “runs tools in a loop to achieve a goal.”

我们的定义与[Russell 和 Norvig（1995）](https://dl.acm.org/doi/book/10.5555/773294)一致，他们将智能体（agent）定义为：“任何可通过传感器感知其环境、并通过执行器（effectors）作用于该环境的事物。” 我们的定义也与Simon Willison的观点一致；他[指出](https://simonwillison.net/2025/Sep/18/agents/)，智能体是一种“通过循环调用工具以实现目标”的系统。

While a full literature review is beyond the scope of this post, we found the following work helpful in framing our thinking. [Kasirzadeh and Gabriel (2025)](https://arxiv.org/pdf/2504.21848) propose a four-dimensional framework for characterizing AI agents along autonomy, efficacy, goal complexity, and generality, constructing “agentic profiles” that map governance challenges across different classes of systems. [Morris et al. (2024)](https://arxiv.org/abs/2311.02462) propose levels of AGI based on performance and generality, treating autonomy as a separable deployment choice. [Feng, McDonald, and Zhang (2025)](https://arxiv.org/abs/2506.12469) define five levels of autonomy based on user roles, from operator to observer. [Shavit et al. (2023)](https://openai.com/index/practices-for-governing-agentic-ai-systems/) propose practices for governing agentic systems, while [Mitchell et al. (2025)](https://arxiv.org/abs/2502.02649) argue that fully autonomous agents should not be developed given that risk scales with autonomy. [Chan et al. (2023)](https://arxiv.org/pdf/2302.10329) argue for anticipating harms from agentic systems before widespread deployment, highlighting risks like reward hacking, power concentration, and the erosion of collective decision-making. [Chan et al. (2024)](https://arxiv.org/pdf/2401.13138) assess how agent identifiers, real-time monitoring, and activity logging could increase visibility into AI agents.

尽管全面的文献综述超出了本文范围，但我们发现以下研究对厘清思路颇有助益：[Kasirzadeh 与 Gabriel（2025）](https://arxiv.org/pdf/2504.21848) 提出一个四维框架，从自主性（autonomy）、效能（efficacy）、目标复杂度（goal complexity）和通用性（generality）四个维度刻画 AI 智能体，并构建“智能体画像”（agentic profiles），以映射不同类别系统所面临的治理挑战；[Morris 等人（2024）](https://arxiv.org/abs/2311.02462) 基于性能与通用性提出 AGI 的分级标准，并将自主性视为一种可独立配置的部署选择；[Feng、McDonald 与 Zhang（2025）](https://arxiv.org/abs/2506.12469) 则依据用户角色（从操作员 operator 到观察者 observer）定义了五级自主性；[Shavit 等人（2023）](https://openai.com/index/practices-for-governing-agentic-ai-systems/) 提出了针对智能体系统的治理实践；而[Mitchell 等人（2025）](https://arxiv.org/abs/2502.02649) 认为，鉴于风险随自主性增强而放大，不应开发完全自主的智能体；[Chan 等人（2023）](https://arxiv.org/pdf/2302.10329) 主张应在智能体系统大规模部署前就预判其潜在危害，重点提示诸如奖励劫持（reward hacking）、权力过度集中以及集体决策能力弱化等风险；[Chan 等人（2024）](https://arxiv.org/pdf/2401.13138) 则评估了智能体标识符、实时监控与活动日志等机制如何提升对 AI 智能体行为的可观测性。

On the empirical side, [Kapoor et al. (2024)](https://arxiv.org/abs/2407.01502) critique agent benchmarks for neglecting cost and reproducibility; [Pan et al. (2025)](https://arxiv.org/abs/2512.04123) survey practitioners and find that production agents tend to be simple and human-supervised; [Yang et al. (2025)](https://arxiv.org/abs/2512.07828) analyze Perplexity usage data and find productivity and learning tasks dominate; and [Sarkar (2025)](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=5713646) finds that experienced developers are more likely to accept agent-generated code. At Anthropic, we’ve also studied how professionals incorporate AI into their work both [internally](https://www.anthropic.com/research/how-ai-is-transforming-work-at-anthropic) and [externally](https://www.anthropic.com/research/anthropic-interviewer). Our work complements these efforts by analyzing deployment patterns using first-party data across both our API and Claude Code, giving us visibility into autonomy, safeguards, and risk that is difficult to observe externally.

在实证研究方面，[Kapoor 等人（2024）](https://arxiv.org/abs/2407.01502) 批评当前智能体基准测试忽视了成本与可复现性；[Pan 等人（2025）](https://arxiv.org/abs/2512.04123) 对一线从业者开展调研，发现生产环境中部署的智能体通常结构简单且需人工监督；[Yang 等人（2025）](https://arxiv.org/abs/2512.07828) 分析 Perplexity 的使用数据，发现生产力提升与学习类任务占据主导；[Sarkar（2025）](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=5713646) 发现经验丰富的开发者更倾向于接受智能体生成的代码。Anthropic 公司内部亦开展了相关研究，既分析了 AI 如何[在公司内部](https://www.anthropic.com/research/how-ai-is-transforming-work-at-anthropic)重塑工作流程，也通过[外部访谈](https://www.anthropic.com/research/anthropic-interviewer)考察专业人士如何将 AI 融入实际工作。本项工作则通过整合我们自有 API 与 Claude Code 的第一方数据，分析智能体的实际部署模式，从而在自主性、安全防护机制与风险暴露程度等方面获得难以从外部观测的深度洞察，从而与上述研究形成互补。

2. Because we characterize agents as AI systems that use tools, we can analyze individual tool calls as the building blocks of agent behavior. To understand what agents are doing in the world, we study the tools they use and the context of those actions (such as the system prompt and conversation history at the time of the action).

2. 由于我们将智能体界定为“使用工具的 AI 系统”，因此可将每一次工具调用（tool call）视作智能体行为的基本构成单元。为理解智能体在现实世界中的具体行为，我们重点研究其所调用的工具，以及这些行为发生时的上下文环境（例如触发动作时的系统提示词 system prompt 与对话历史 conversation history）。

3. These results reflect Claude’s performance on programming-related tasks, and do not necessarily translate to performance in other domains.

3. 这些结果反映的是 Claude 在编程相关任务上的表现，未必能直接推广至其他领域。

4. Throughout this post, we use "autonomy" somewhat informally to refer to the degree to which an agent operates independently of human direction and oversight. An agent with minimal autonomy executes exactly what a human explicitly requests; an agent with high autonomy makes its own decisions about what to do and how to do it, with little or no human involvement. Autonomy is not a fixed property of a model or system but an emergent characteristic of a deployment, shaped by the model's behavior, the user's oversight strategy, and the product's design. We do not attempt a precise formal definition; for details on how we operationalize and measure autonomy in practice, see the [Appendix](https://cdn.sanity.io/files/4zrzovbb/website/55e4d2de6eb39b3a9259c3f74843f86b1a12e265.pdf).

4. 在本文中，“自主性（autonomy）”一词的使用较为宽泛，指代智能体在多大程度上能够脱离人类指令与监督而独立运行：自主性最低的智能体仅严格执行人类明确提出的请求；而高自主性智能体则可在极少甚至无需人类介入的情况下，自行决定“做什么”及“如何做”。自主性并非模型或系统的固有属性，而是部署场景下涌现的特征，由模型自身行为、用户的监督策略以及产品设计共同塑造。我们并未尝试给出严格的数学形式化定义；有关我们在实践中如何操作化定义并量化测量自主性的具体方法，请参见[附录](https://cdn.sanity.io/files/4zrzovbb/website/55e4d2de6eb39b3a9259c3f74843f86b1a12e265.pdf)。

5. Moreover, the same model deployed differently can generate output at different speeds. For example, we recently released [Fast Mode](https://code.claude.com/docs/en/fast-mode) for Opus 4.6, which generates output 2.5x faster than regular Opus.

5. 此外，同一模型在不同部署方式下可能产生不同速度的输出。例如，我们近期为 Opus 4.6 推出了[快速模式（Fast Mode）](https://code.claude.com/docs/en/fast-mode)，其输出速度较常规 Opus 提升 2.5 倍。

6. For turn duration across other percentiles, see the [Appendix](https://cdn.sanity.io/files/4zrzovbb/website/55e4d2de6eb39b3a9259c3f74843f86b1a12e265.pdf).

6. 关于其他百分位数下的回合持续时间（turn duration），请参见[附录](https://cdn.sanity.io/files/4zrzovbb/website/55e4d2de6eb39b3a9259c3f74843f86b1a12e265.pdf)。

7. Specifically, we use Claude to classify each internal Claude Code session into four categories of complexity, and to determine whether the task was successful. Here, we report the success rate for the most difficult category of task.

7. 具体而言，我们利用 Claude 将每次内部 Claude Code 会话分类为四个复杂度等级，并判定任务是否成功完成。此处报告的是最困难任务类别的成功率。

8. METR’s five-hour figure is a measure of task difficulty (how long the task would take a human), whereas our measurements reflect actual elapsed time, which is affected by factors like model speed and the user’s computing environment. We do not attempt to reason across these metrics, and we include this comparison to explain to readers who may be familiar with the METR finding why the numbers we report here are substantially lower.

8. METR 所提出的“五小时”指标衡量的是任务难度（即人类完成该任务所需时间），而我们的测量值反映的是实际经过时间（elapsed time），后者受模型推理速度、用户计算环境等因素影响。我们并未尝试在这两类指标之间进行跨维度推断；引入此项对比，旨在向熟悉 METR 研究结论的读者说明：为何我们此处报告的数值显著更低。

9. These patterns come from interactive Claude Code sessions, which overwhelmingly reflect software engineering. Software is unusually amenable to supervisory oversight because the outputs can be tested, easily compared, and reviewed before they are released. In domains where verifying an agent’s output requires the same expertise as producing it, this shift may be slower or take a different form. The rising interrupt rate may also reflect experienced users completing more challenging tasks, which would naturally require more human input. Finally, Claude Code’s default settings push new users towards approval-based oversight (since actions are not auto-approved by default), so some of the shifts we observe may reflect Claude Code’s product design.

9. 这些模式源自交互式 Claude Code 会话，而此类会话绝大多数反映的是软件工程实践。软件开发格外适合监督式管控，因为其输出可被测试、易于比对，并可在发布前完成审查。而在那些验证智能体输出所需的专业知识与生成该输出本身所需知识相当的领域中，这种范式转变可能进展更慢，或呈现不同形态。中断率的上升也可能反映出经验丰富的用户正在处理更具挑战性的任务——这类任务自然需要更多人工介入。最后，Claude Code 的默认设置会引导新用户采用“需人工批准”的监督模式（因为操作默认不自动获批），因此我们所观察到的部分变化，可能正体现了 Claude Code 自身的产品设计取向。

10. Both complexity and human involvement are estimated by having Claude analyze each tool call in its full context (including the system prompt and conversation history). The complete classification prompt is available in the [Appendix](https://cdn.sanity.io/files/4zrzovbb/website/55e4d2de6eb39b3a9259c3f74843f86b1a12e265.pdf). Defining human involvement is particularly difficult, as many transcripts include content from a human even when that human is not actively steering the conversation (for example, a user message being moderated or analyzed). In our manual validation, Claude was nearly always correct when it classified a tool call as having no human involved, but it sometimes identified human involvement where there was none. As a result, these estimates should be interpreted as an upper bound on human involvement.

10. 复杂度与人工参与度均由 Claude 在完整上下文（包括系统提示词与对话历史）中分析每次工具调用后得出。完整的分类提示词详见[附录](https://cdn.sanity.io/files/4zrzovbb/website/55e4d2de6eb39b3a9259c3f74843f86b1a12e265.pdf)。界定“人工参与”尤为困难，因为许多对话记录中虽包含人类内容，但该人类并未实际主导对话进程（例如：用户消息仅被审核或分析）。在我们的人工验证中，Claude 在判定某次工具调用“无任何人工参与”时几乎总是准确的；但它有时会错误地将本无人工参与的情形识别为存在人工参与。因此，这些估算值应被理解为人工参与程度的**上限估计**。

11. In a sense, stopping to ask the user a question is itself a form of agency. We use “limits its own autonomy” to mean that Claude chooses to seek guidance from the human when it could have continued operating independently.

11. 从某种意义上说，主动暂停并询问用户问题本身即是一种能动性体现。“限制自身自主性”在此处意指：Claude 在本可独立持续运行的情况下，主动选择向人类寻求指导。

12. These clusters were generated by having Claude analyze each interruption or pause, along with the surrounding session context, then grouping related reasons together. We manually combined some closely related clusters and edited their names for clarity. The clusters shown are not exhaustive.

12. 这些聚类由 Claude 对每次中断或暂停及其所处会话上下文进行分析后生成，再将语义相近的原因归为一类。我们人工合并了若干高度相关的聚类，并对其命名进行了优化以提升清晰度。此处展示的聚类并非穷尽所有可能。

13. We treat these scores as comparative indicators rather than precise measurements. Rather than defining rigid criteria for each level, we rely on Claude’s general judgment about the context surrounding each tool call, which allows the classification to capture considerations we may not have anticipated. The tradeoff is that the scores are more meaningful for comparing actions against each other than for interpreting any single score in absolute terms. For the full prompts, see the [Appendix](https://cdn.sanity.io/files/4zrzovbb/website/55e4d2de6eb39b3a9259c3f74843f86b1a12e265.pdf).

13. 我们将这些评分视为**相对比较指标**，而非精确测量值。我们并未为每个等级设定刚性判定标准，而是依赖 Claude 对每次工具调用所处上下文的整体判断——这使得分类结果能够涵盖我们此前未曾预见到的考量因素。其权衡在于：这些评分在横向对比不同操作时更具意义，而单独解读任一绝对分值则意义有限。完整提示词请参见[附录](https://cdn.sanity.io/files/4zrzovbb/website/55e4d2de6eb39b3a9259c3f74843f86b1a12e265.pdf)。

14. For more information about how we validated these figures and our precise definitions, see the [Appendix.](https://cdn.sanity.io/files/4zrzovbb/website/55e4d2de6eb39b3a9259c3f74843f86b1a12e265.pdf) In particular, we found that Claude often overestimated human involvement, so we expect 80% to be an upper bound on the number of tool calls with direct human oversight.

14. 关于这些数据的验证方法及各项定义的精确说明，请参阅[附录](https://cdn.sanity.io/files/4zrzovbb/website/55e4d2de6eb39b3a9259c3f74843f86b1a12e265.pdf)。特别值得注意的是，我们发现 Claude 常常高估人工参与程度，因此我们预计：**接受直接人工监督的工具调用占比上限约为 80%**。

15. Our systems also automatically exclude clusters that do not meet our aggregation minimums, which means that tasks that only a small number of customers are performing with Claude will not surface in this analysis.

15. 我们的系统还会自动排除未达聚合最低阈值的聚类——这意味着仅有极少数客户通过 Claude 执行的任务，将不会在本次分析中显现。

16. Whether the adoption curve in software engineering will repeat in other domains is an open question. Software is comparatively easy to test and review—you can run code and see if it works—which makes it easier to trust an agent and catch its mistakes. In domains like law, medicine, or finance, verifying an agent’s output may require significant effort, which could slow the development of trust.

16. 软件工程领域所呈现的采纳曲线是否会在其他领域重演，仍是一个开放性问题。相较而言，软件更易于测试与审查——你只需运行代码，即可直观判断其是否有效——这使得人们更容易信任智能体，也更易及时发现其错误。而在法律、医疗或金融等领域，验证智能体输出往往需要大量专业投入，这或将延缓信任关系的建立。