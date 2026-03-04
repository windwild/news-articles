---
render_with_liquid: false
title: "Estimating AI productivity gains"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/estimating-productivity-gains"
date: "2025-12-07"
scraped_at: "2026-03-03T06:43:58.111864287+00:00"
language: "en-zh"
translated: true
description: "Anthropic economic research on productivity gains"
---
render_with_liquid: false
render_with_liquid: false

Economic Research

经济研究

# Estimating AI productivity gains from Claude conversations

# 基于 Claude 对话估算人工智能带来的生产率提升

Nov 25, 2025

2025年11月25日

[Read as a PDF](https://www-cdn.anthropic.com/e5645986a7ce8fbcc48fa6d2fc67753c87642c30.pdf)

[以 PDF 格式阅读](https://www-cdn.anthropic.com/e5645986a7ce8fbcc48fa6d2fc67753c87642c30.pdf)

![Estimating AI productivity gains from Claude conversations](images/estimating-ai-productivity-gains/img_001.svg)

![基于 Claude 对话估算人工智能带来的生产率提升](images/estimating-ai-productivity-gains/img_001.svg)

#### Footnotes

#### 脚注

1\. Claude is prone to produce outlier estimates of both time horizon and cost; for example, it classifies some programming tasks as taking humans years to complete or being valued at millions of dollars. While this is possible, to produce more conservative estimates we take an average of the median value for each task, weighted by the number of conversations in each task.

1．Claude 倾向于对时间跨度和成本生成异常值估计；例如，它将某些编程任务归类为需人类耗时数年才能完成，或其价值高达数百万美元。尽管这种情况理论上可能存在，但为得出更为审慎的估计，我们对每项任务的中位数值取平均，权重为该任务所对应的对话数量。

2\. Hulten’s theorem states that in a competitive equilibrium without distortions, the contribution to total factor productivity of micro-level productivity gains are proportional to that production factor’s Domar weight to a first order approximation. A factor’s Domar weight is the ratio of its value of gross output to GDP. In the task-based model presented by Acemoglu (2024) a task’s Domar weight for labor-intensive tasks is equal to that task’s share of the wage bill multiplied by the labor share of income. See Baqaee and Farhi (2019) for a recent treatment and extension of Hulten’s Theorem. Formulaically, Hulten’s Theorem states the log change in TFP is equal to the Domar-weighted sum over the log change in micro-productivities. In our case, the log change is taken as ln(Completion time without AI) minus ln(Completion time with AI).

2．赫尔滕定理（Hulten’s Theorem）指出：在无扭曲的完全竞争均衡下，微观层面生产率提升对全要素生产率（TFP）的贡献，一阶近似地正比于该生产要素的多马权重（Domar weight）。某要素的多马权重等于该要素所对应毛产出价值与国内生产总值（GDP）之比。在 Acemoglu（2024）提出的基于任务的模型中，劳动密集型任务的多马权重等于该任务在工资总额中所占份额乘以劳动收入份额。关于赫尔滕定理的最新阐释与拓展，参见 Baqaee 和 Farhi（2019）。从公式角度看，赫尔滕定理表明：TFP 的对数变化量等于各微观生产率对数变化量按多马权重加权后的总和。在本研究中，对数变化量定义为 ln（无 AI 时的完成时间）减去 ln（有 AI 时的完成时间）。

3\. The increase in TFP is more primitive than the increase in labor productivity. Labor productivity is the ratio of output per worker and can increase due to an increase in other factors of production aside from labor even when TFP is unchanged.

3．全要素生产率（TFP）的提升比劳动生产率的提升更具根本性。劳动生产率指每位劳动者所创造的产出，即使 TFP 保持不变，只要其他生产要素（如资本）投入增加，劳动生产率也可能上升。

4\. [Acemoglu 2024](https://www.nber.org/papers/w32487) calculates the labor share in AI-exposed industries as 0.57; we use the economy-wide share of 0.6 for simplicity given how close it is.

4．[Acemoglu（2024）](https://www.nber.org/papers/w32487) 计算出受人工智能影响行业的劳动收入份额为 0.57；鉴于该数值与整体经济的劳动收入份额（0.6）非常接近，本文为简化起见，采用后者。

5. For historical data on total factor productivity see estimates from the Federal Reserve Bank of San Francisco: [https://www.frbsf.org/research-and-insights/data-and-indicators/total-factor-productivity-tfp/](https://www.frbsf.org/research-and-insights/data-and-indicators/total-factor-productivity-tfp/). The average growth in TFP from 2015 to 2024 was 0.7%. Twenty years earlier, the average growth rate in TFP from 1995 to 2004 was 1.6%.

5. 有关全要素生产率（TFP）的历史数据，请参阅旧金山联邦储备银行的估算：[https://www.frbsf.org/research-and-insights/data-and-indicators/total-factor-productivity-tfp/](https://www.frbsf.org/research-and-insights/data-and-indicators/total-factor-productivity-tfp/)。2015 至 2024 年间，TFP 的平均年增长率约为 0.7%；而二十年前（1995 至 2004 年），TFP 的平均年增长率则为 1.6%。

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千场 Claude.ai 对话中的 11 种可观测行为，构建出“AI 熟练度指数”（AI Fluency Index）—— 这是衡量当今人类如何与 AI 协作的一项基准指标。

## Overview

## 概览

_What do real conversations with Claude tell us about the effects of AI on labor productivity? Using our privacy-preserving [analysis method](https://www.anthropic.com/research/clio), we sample one hundred thousand real conversations from [Claude.ai](http://claude.ai/redirect/website.v1.ad1e2a79-c5b8-42c0-955c-e4dcc00f242e), estimate how long the tasks in these conversations would take with and without AI assistance, and study the productivity implications across the broader economy. Based on Claude’s estimates, these tasks would take on average about 90 minutes to complete without AI assistance, and Claude speeds up individual tasks by about 80%._

_真实对话中，Claude 向我们揭示了 AI 对劳动生产率的哪些影响？我们采用具备隐私保护特性的[分析方法](https://www.anthropic.com/research/clio)，从 [Claude.ai](http://claude.ai/redirect/website.v1.ad1e2a79-c5b8-42c0-955c-e4dcc00f242e) 中随机抽样十万场真实对话，估算其中各项任务在有无 AI 辅助情形下的完成时长，并研究其对更广泛经济层面的生产率影响。根据 Claude 的估算，若无 AI 辅助，这些任务平均需耗时约 90 分钟；而借助 Claude，单个任务的处理速度可提升约 80%。_

_Extrapolating these estimates out suggests **current-generation** AI models could increase US labor productivity growth by 1.8% annually over the next decade_— _roughly twice the run rate in recent years. But this isn’t a prediction of the future, since we don’t take into account the rate of adoption or the larger productivity effects that would come from much more capable AI systems._

_将上述估算外推可得：**当前一代** AI 模型有望在未来十年内，每年推动美国劳动生产率增长约 1.8%——约为近年来平均增速的两倍。但需强调，这并非对未来趋势的预测，因为我们并未纳入 AI 技术采纳速率，也未考虑能力更强的下一代 AI 系统可能带来的更广泛生产率提升效应。_

_Our analysis has limits. Most notably, we can’t account for additional time humans spend on tasks outside of their conversations with Claude, including validating the quality or accuracy of Claude's work. But as AI models get better at time estimation, we think our methods in this research note could become increasingly useful for understanding how AI is shaping real work._

_本分析存在若干局限性。最显著的一点是：我们无法计入人类在与 Claude 的对话之外所花费的额外时间，例如对 Claude 输出结果的质量或准确性进行人工校验与验证。然而，随着 AI 模型在时间估算方面的能力持续提升，我们认为本研究报告所采用的方法，将日益有助于深入理解 AI 如何切实重塑现实工作场景。_

_Here’s a more detailed summary of our results:_

_以下是我们研究结果的更详细摘要：_

- **Across one hundred thousand real world conversations, Claude estimates that AI reduces task completion time by 80%.**  
- **在十万场真实世界对话中，Claude 估计 AI 可将任务完成时间缩短 80%。**  
We use Claude to evaluate anonymized Claude.ai transcripts to estimate the productivity impact of AI. According to Claude’s estimates, people typically use AI for complex tasks that would, on average, take people 1.4 hours to complete. By matching tasks to O\*NET occupations and BLS wage data, we estimate these tasks would otherwise cost $55 in human labor.  
我们利用 Claude 对匿名化的 Claude.ai 对话记录进行评估，以估算 AI 对生产力的影响。据 Claude 估算，人们通常将 AI 应用于复杂任务——此类任务若由人类独立完成，平均耗时约 1.4 小时。通过将任务映射至 O\*NET 职业分类体系及美国劳工统计局（BLS）薪资数据，我们估算这些任务若完全依赖人力完成，其劳动力成本约为 55 美元。

- **The estimated scope, cost, and time savings of tasks varies widely by occupation.**  
- **不同职业所涉任务的估算覆盖范围、成本与时间节省幅度差异显著。**  
Based on Claude’s estimates, people use Claude for legal and management tasks that would have taken nearly two hours, but for food preparation tasks that would have taken only 30 minutes. And we find that healthcare assistance tasks can be completed 90% more quickly, whereas hardware issues see time savings of 56%. This doesn’t account for the time that humans might spend on these tasks _beyond_ their conversation on [Claude.ai](http://claude.ai/redirect/website.v1.ad1e2a79-c5b8-42c0-955c-e4dcc00f242e), however, so we think these estimates might overstate current productivity effects to at least some degree.  
根据 Claude 的估算，人们使用 Claude 处理法律与管理类任务（原本预计耗时近两小时），也用于食品准备类任务（原本仅需 30 分钟）。我们还发现，医疗辅助类任务的完成速度可提升 90%，而硬件问题解决则可节省 56% 的时间。但需注意：该估算**未计入**用户在 [Claude.ai](http://claude.ai/redirect/website.v1.ad1e2a79-c5b8-42c0-955c-e4dcc00f242e) 对话之外可能额外投入的时间，因此我们认为当前估算结果在一定程度上可能高估了 AI 当前的实际生产力效应。

- **Extrapolating these results to the economy, current generation AI models could increase annual US labor productivity growth by 1.8% over the next decade. This would double the annual growth the US has seen since 2019,** **and places our estimate towards the upper end of [recent estimates](https://www.oecd.org/content/dam/oecd/en/publications/reports/2024/11/miracle-or-myth-assessing-the-macroeconomic-productivity-gains-from-artificial-intelligence_fde2a597/b524a072-en.pdf).**  
- **将上述结果外推至整体经济，当前一代 AI 模型有望在未来十年内，使美国年均劳动生产率增长提升 1.8 个百分点。这一增幅将是美国自 2019 年以来年均增长率的两倍，且处于[近期多项研究估算](https://www.oecd.org/content/dam/oecd/en/publications/reports/2024/11/miracle-or-myth-assessing-the-macroeconomic-productivity-gains-from-artificial-intelligence_fde2a597/b524a072-en.pdf)的较高区间。**  
Taking as given Claude’s estimates of task-level efficiency gains, we use standard methods to calculate a 1.8% implied annual increase in US labor productivity over the next ten years. However, this estimate does not account for future improvements in AI models (or more sophisticated uses of current technology), which could significantly magnify AI’s economic impact.  
在采纳 Claude 所估算的任务级效率提升数据基础上，我们采用标准方法推算出：未来十年内，美国年均劳动生产率将因此提升 1.8 个百分点。但该估算**未考虑**未来 AI 模型的进一步演进（或对现有技术更深入、更精巧的应用），而这些因素可能大幅放大 AI 对经济的实际影响。

- **As AI accelerates some tasks, others may become bottlenecks**: We see large speedups for some tasks and much smaller ones in others, even within the same occupational groups. Where AI makes less of a difference, these tasks might become bottlenecks, potentially acting as a constraint on growth.  
- **随着 AI 加速部分任务，其他任务反而可能成为瓶颈：** 我们观察到，即便在同一职业类别内部，某些任务提速显著，而另一些任务提速却十分有限。在 AI 效能提升不明显之处，相关任务便可能演变为瓶颈，进而制约整体增长。

**This gives us a new lens for understanding how AI’s economic impacts over time, which we will track going forward as part of our [Economic Index](https://www.anthropic.com/economic-index):**  
**这为我们提供了一个理解 AI 经济影响随时间演变的新视角；我们将把此类分析纳入 [Anthropic 经济指数](https://www.anthropic.com/economic-index)，并持续追踪其动态变化：**  
Computing these estimates based on real-world Claude conversations gives us a new lens to understand AI productivity. This complements other approaches, like lab studies in narrow domains, or government statistics which provide more coarse-grained insights. We will track how these estimates change over time to get an evolving picture of these issues as capabilities and adoption continue to progress.  
基于真实世界中 Claude 对话所计算出的上述估算，为我们理解 AI 生产力效应提供了全新视角。该方法可与其它路径形成互补：例如聚焦特定狭窄领域的实验室研究，或提供宏观粗粒度洞察的政府统计数据。我们将持续追踪这些估算值的动态变化，从而在 AI 能力持续演进与应用不断深化的过程中，获得对相关问题日益清晰、不断更新的认知图景。

![](images/estimating-ai-productivity-gains/img_002.jpg)An overview of our method and some of our main results. See below for how we validate Claude’s estimates, the assumptions we make, and limitations of our analysis.  
![](images/estimating-ai-productivity-gains/img_002.jpg)本方法概览及部分主要结果。下文将详述我们如何验证 Claude 的估算、所作关键假设，以及本分析的局限性。

## Introduction  
## 引言  

As part of the [Anthropic Economic Index](https://www.anthropic.com/economic-index), we have documented how people use Claude across different tasks, industries, and places. We’ve captured the **breadth** of uses—how people use Claude for legal, scientific, and programming tasks—but not their **depth**. How substantial are the tasks for which people use Claude, and how much time does Claude save them?  
作为 [Anthropic 经济指数](https://www.anthropic.com/economic-index) 的一部分，我们已系统记录了人们在不同任务、行业与地域中使用 Claude 的方式。我们捕捉到了其应用的**广度**——即人们如何将 Claude 用于法律、科学与编程等各类任务——但尚未衡量其应用的**深度**：人们交予 Claude 处理的任务究竟有多重要？Claude 为其节省了多少时间？

The current version of the Economic Index can't capture this **within-task heterogeneity**—for instance, it can’t distinguish report-writing tasks that take five minutes from those that take five days, or financial modeling tasks that take an afternoon from those that take a few weeks. This makes it difficult to assess AI's economic effects: a software developer might use Claude to write ten pull requests in a day, but if nine are minor documentation updates and one is a critical infrastructure change, simply counting the number of these tasks performed with Claude misses the point.  
当前版本的经济指数尚无法刻画这种**任务内部的异质性**——例如，它无法区分耗时五分钟的报告撰写任务与耗时五天的同类任务，也无法区分需一个下午完成的财务建模任务与需数周完成的同类任务。这使得准确评估 AI 的经济效应变得困难：一名软件工程师可能一天内借助 Claude 提交十份拉取请求（pull request），但如果其中九份仅为次要文档更新，仅一份涉及关键基础设施变更，那么单纯统计“使用 Claude 完成的任务数量”便会严重偏离实质。

Not only that, but as model capabilities improve, we want to understand whether they do higher-value work. To understand how AI is reshaping work and productivity, we need to know not just _which_ tasks Claude handles, but _how substantial_ those tasks and time savings are.  
不仅如此，随着模型能力不断提升，我们更需厘清：AI 是否正越来越多地承担高价值工作？要真正理解 AI 如何重塑工作形态与生产力格局，我们不仅需要知道 Claude **处理了哪些任务**，更需明确这些任务本身及其所带来的时间节省究竟**有多重要**。

Several groups have begun conducting randomized controlled trials to measure productivity gains in narrow domains, including [software](https://arxiv.org/abs/2302.06590) [engineering](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=4945566) [tasks](https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/), [writing](https://www.science.org/doi/10.1126/science.adh2586), and [customer service](https://www.nber.org/papers/w31161). METR's work on [measuring AI’s ability to complete long tasks](https://metr.org/blog/2025-03-19-measuring-ai-ability-to-complete-long-tasks/) has demonstrated that AI systems can independently tackle extended, multi-step challenges. But these evaluations consider a narrow set of problems, rather than broad real-world use. To assess AI’s _overall_ impact on the economy, we need a way to analyze hundreds or thousands of real-world AI applications.  
已有多个研究团队开始在特定狭窄领域开展随机对照试验，以量化 AI 带来的生产力提升，涵盖 [软件](https://arxiv.org/abs/2302.06590) [工程](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=4945566) [任务](https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/)、[写作](https://www.science.org/doi/10.1126/science.adh2586) 与 [客户服务](https://www.nber.org/papers/w31161) 等方向。METR 关于 [衡量 AI 完成长周期任务能力](https://metr.org/blog/2025-03-19-measuring-ai-ability-to-complete-long-tasks/) 的研究已证实，AI 系统能够独立应对延展性强、多步骤的复杂挑战。但此类评估聚焦于一组高度限定的问题，而非广泛的真实世界应用场景。若要全面评估 AI 对**整体经济**的影响，我们必须建立一种方法，用以分析数百乃至数千个真实世界中的 AI 应用案例。

This report takes a first step toward that goal. It uses Claude to estimate how much time it would take a human to complete the tasks that Claude handles, compares that to how long Claude and the human took together, and thereby calculates how much time the AI has saved. While AI models lack context about users' expertise, workflows, and constraints, we find that model-estimated times show promising accuracy for a dataset of software engineering tasks, relative to both human-estimated completion times and time-tracked outcomes.  
本报告正是迈向该目标的第一步。我们利用 Claude 估算：人类独立完成其当前所处理任务所需的时间，并将其与“人类+Claude”协同完成同一任务所用时间进行对比，从而计算出 AI 实际节省的时间量。尽管 AI 模型缺乏关于用户专业背景、工作流程与实际约束条件的上下文信息，但我们发现，在软件工程任务数据集上，模型所估算的时间与人类自身预估的完成时间、以及实测的时间追踪结果相比，均展现出令人鼓舞的准确性。

In what follows, we present our methodology for estimating task-level time savings, validate our approach against ground-truth data, and then use these estimates to assess which tasks and occupations show the largest productivity gains from AI. We then explore what our task-level estimates imply about aggregate productivity as AI begins to be adopted throughout the economy.  
下文将依次呈现：我们用于估算任务级时间节省的完整方法论；对该方法论基于真实基准数据（ground-truth data）的验证过程；继而运用这些估算结果，识别出 AI 带来最大生产力提升的具体任务类型与职业类别；最后，探讨这些任务级估算结果对宏观经济层面整体生产力的影响启示——尤其当 AI 开始在整个经济体中加速普及与落地之时。

## Estimating task length and time savings

## 估算任务时长与时间节省

Using our [privacy-preserving analysis system](https://www.anthropic.com/research/clio), we analyzed 100,000 conversation transcripts from Claude.ai (Free, Pro, and Max tiers) to measure the length and time savings of tasks Claude handles. We generated two core estimates for each task:

我们利用[隐私保护分析系统](https://www.anthropic.com/research/clio)，分析了来自 Claude.ai（免费版、Pro 版和 Max 版）的 10 万条对话记录，以衡量 Claude 所处理任务的耗时长度及相应的时间节省效果。针对每项任务，我们生成了两个核心估算值：

- **Time estimate without AI**: The hours a human professional would need to complete the task without AI assistance  
- **Time estimate with AI:** The amount of time it took to complete the task with AI assistance  

- **无 AI 辅助下的时间估算**：一名人类专业人士在不借助 AI 协助的情况下完成该任务所需的小时数  
- **有 AI 辅助下的时间估算**：在 AI 协助下完成该任务所耗费的时间  

We used Claude to generate these estimates for each conversation. Following our [Economic Index methodology](https://www.anthropic.com/news/the-anthropic-economic-index), we then aggregated these individual chat conversations to tasks in the [O\*NET](https://www.onetcenter.org/database.html) taxonomy by taking the median of time estimates for each task. This allowed us to explore how such time estimates vary across tasks and occupations within the economy. Classification prompts are in the Appendix.

我们使用 Claude 为每段对话生成上述估算值。依据我们的[经济指数方法论](https://www.anthropic.com/news/the-anthropic-economic-index)，我们进一步将这些独立的聊天对话按[O\*NET](https://www.onetcenter.org/database.html)职业分类体系归类至具体任务，并对每项任务取其时间估算值的中位数进行聚合。这使我们得以探究此类时间估算在不同任务及经济领域内各类职业间的差异分布情况。任务分类所用提示词详见附录。

Analyzing real-world transcripts enables us to account for _intra-task variation_. For instance, even if the overall share of _designing manufacturing equipment_ tasks stays fixed, transcript-level information lets us see whether people tackle more complex, longer-timescale projects (or attain greater time savings) with AI over time. Our [Economic Index](https://www.anthropic.com/economic-index) will track how these estimates evolve over time, and share aggregate datasets that researchers can use to make their own forecasts and conclusions.

分析真实世界中的对话记录，使我们能够纳入对**任务内部差异性**（_intra-task variation_）的考量。例如，即便“设计制造设备”类任务在总体任务构成中的占比保持稳定，基于对话层级的信息仍可帮助我们观察：随着时间推移，人们是否借助 AI 开展了更复杂、周期更长的项目（或实现了更大的时间节省）。我们的[经济指数](https://www.anthropic.com/economic-index)将持续追踪这些估算值的动态演变，并公开汇总数据集，供研究人员用于自主建模预测与得出结论。

### Validation

### 验证

Estimating task duration is [notoriously difficult for humans](https://web.mit.edu/curhan/www/docs/Articles/biases/67_J_Personality_and_Social_Psychology_366,_1994.pdf). AI models have an even more difficult job, since they lack crucial context about the broader context of tasks (though we expect this context to increase over time as features like [memory](https://www.anthropic.com/news/memory) and [external integrations](https://www.anthropic.com/news/claude-and-slack) become more comprehensive). To assess whether Claude’s estimates are informative, we conducted two validation analyses.

对任务持续时间进行估算，向来是[人类公认的一大难题](https://web.mit.edu/curhan/www/docs/Articles/biases/67_J_Personality_and_Social_Psychology_366,_1994.pdf)。而对 AI 模型而言，这项任务更具挑战性——因其缺乏关于任务宏观背景的关键上下文信息（尽管随着[记忆功能](https://www.anthropic.com/news/memory)和[外部集成能力](https://www.anthropic.com/news/claude-and-slack)等特性日趋完善，我们预期此类上下文信息将逐步增强）。为评估 Claude 所生成估算值是否具备信息价值，我们开展了两项验证分析。

**Self-consistency testing:** First, we assess whether Claude produces stable estimates of task lengths across different conversation samples, or across variations in our prompts.

**自洽性测试**：首先，我们检验 Claude 在不同对话样本之间、或在提示词（prompt）不同变体之间，所生成的任务时长估算是否保持稳定。

We create multiple prompt variations—for example, asking about an "employee with appropriate skills" versus a "skilled professional"—to assess how sensitive estimates are to the way the prompt is phrased. We analyze 1,800 conversations with each variant, where users consented to share these conversations with us, and computed correlations across prompt variants. The results showed strong self-agreement, with log-scale correlations of _r_ =0.89–0.93 across variants.

我们设计了多种提示词变体——例如，分别询问“具备适当技能的员工”与“熟练的专业人士”——以评估估算结果对提示词措辞的敏感程度。我们对每种变体均分析了 1,800 条经用户授权同意共享的对话记录，并计算各提示词变体间估算值的相关性。结果显示高度自洽：各变体间对数尺度相关系数 _r_ 达 0.89–0.93。

![](images/estimating-ai-productivity-gains/img_003.jpg)**Claude’s estimated human completion times show high correlation across prompt variations.** Prompt 1 asks Claude to estimate the time it would take an "employee with appropriate skills" to complete and Prompt 2 asks about a “human worker” who is “competent in the relevant field.” The two prompts show a log-scale correlation of 0.89, indicating high agreement. Analysis performed on [Claude.ai](http://claude.ai/) transcripts where users have consented to share them with us for research purposes.

![](images/estimating-ai-productivity-gains/img_003.jpg)**Claude 对人类完成时间的估算在不同提示词变体间呈现高度相关性。** 提示词 1 要求 Claude 估算“具备适当技能的员工”完成任务所需时间；提示词 2 则要求估算一位“在相关领域具备胜任能力的人类工作者”所需时间。二者对数尺度相关系数为 0.89，表明高度一致。本分析基于用户已授权用于研究目的的 [Claude.ai](http://claude.ai/) 对话记录。

**External benchmarking:** Self-agreement doesn’t matter much if a model’s predictions don’t correspond well to reality. To check this, we tested Claude's time estimation capabilities against a dataset of thousands of real-world [software development tasks](https://zenodo.org/records/7022735) gathered from JIRA tickets for open-source repositories, with both developer estimates and actual tracked completion times.

**外部基准测试：** 如果模型的预测与现实情况严重不符，那么其内部一致性（self-agreement）意义甚微。为验证这一点，我们将 Claude 的时间预估能力，与一个包含数千个真实世界[软件开发任务](https://zenodo.org/records/7022735)的数据集进行了比对——这些任务数据源自开源代码仓库的 JIRA 工单，每项任务均包含开发者预估耗时和实际追踪记录的完成时间。

This is a very challenging task for Claude, given that Claude receives only the title and description of the JIRA tickets, while the human developers have full context on the codebase and the ticket, and have seen how long similar tasks take to complete. On a subset of 1000 tasks from this benchmark:

这是一项对 Claude 极具挑战性的任务：Claude 仅能获取 JIRA 工单的标题与描述，而人类开发者则完全了解代码库上下文、工单背景，并且清楚类似任务以往的实际耗时。在该基准测试中随机选取的 1000 项任务子集上：

- Human developers themselves achieved ρ=0.50 Spearman correlation with actual times, and a Pearson correlation of r\_log=0.67 on the log values, indicating a moderate-strength correlation (higher is better for both values).
- 人类开发者自身预估时间与实际耗时的 Spearman 相关系数为 ρ = 0.50；对耗时取以 10 为底的对数后，Pearson 相关系数为 r\_log = 0.67，表明二者存在中等强度的相关性（两个指标值越高越好）。
- Claude Sonnet 4.5 achieved ρ=0.44 and r\_log=0.46  
- Claude Sonnet 4.5 达到 ρ = 0.44，r\_log = 0.46  
- Claude Sonnet 4.5 with ten examples of tasks and their ground-truth time lengths showed a worse ρ=0.39, but improved r\_log=0.48  
- 在提示词中提供 10 个任务及其真实耗时作为示例时，Claude Sonnet 4.5 的 ρ 下降至 0.39，但 r\_log 略有提升至 0.48  

This analysis suggests that Claude’s estimates provide _directional_ information that is only slightly worse than software developers’ own estimates. However, we observe that Claude’s estimates are much more compressed than humans—predicting comparatively long times for shorter tasks, and vice versa—and are overall more prone to overestimates. This suggests that the actual differences in task lengths across tasks may be larger than we report, and that actual task lengths may be slightly shorter. Overall, these findings demonstrate that model predictions have meaningful correlation with real-world outcomes, at least in this domain, making them useful for comparing one task to another or tracking changes over time. We also observe higher correlation from Claude Sonnet 4.5 compared to Claude Sonnet 4, suggesting that these estimates may continue to improve with model capabilities.

上述分析表明，Claude 的预估结果提供了具有**方向性**的信息，其质量仅略逊于软件开发人员自身的预估。然而我们观察到，Claude 的预估结果比人类预估更为“压缩”——即对短任务倾向于高估、对长任务倾向于低估；整体上更易出现高估倾向。这暗示：不同任务间真实耗时的差异可能比我们报告的更大，而实际任务耗时可能略短于预估。总体而言，这些发现证实：至少在该领域内，模型预测与现实结果之间存在显著相关性，因而可用于任务间的横向比较，或用于随时间推移追踪变化趋势。此外，我们还观察到 Claude Sonnet 4.5 的相关性高于 Claude Sonnet 4，表明此类预估能力有望随模型能力提升而持续增强。

![](images/estimating-ai-productivity-gains/img_004.jpg)Correlation of actual time spent on software engineering tasks with developer and Claude estimates. Left: correlation with developers’ initial time estimates with the final time-tracked outcomes. Developers are familiar with the full codebase and understand the full context behind the request and how long similar tasks have taken. Middle: correlation with Claude Sonnet 4.5’s estimates, given just the task title and description of the JIRA ticket. Right: Correlation with Claude Sonnet 4.5’s estimates, given 10 examples in the prompt to calibrate on. Overall, Claude’s estimates have similar directional correlation to developers: Spearman’s _ρ_ =0.44, compared to _ρ_ =0.50 for developers, though Claude significantly overestimates short tasks and underestimates long ones. Axes are log (base 10) scaled. Error bars are 95% CIs per bin.

![](images/estimating-ai-productivity-gains/img_004.jpg)软件工程任务实际耗时与开发者及 Claude 预估耗时的相关性图。左图：开发者初始预估耗时与最终实际追踪耗时之间的相关性。开发者熟悉整个代码库，充分理解需求背景及类似任务的历史耗时。中图：仅基于 JIRA 工单标题与描述，Claude Sonnet 4.5 的预估耗时与实际耗时的相关性。右图：在提示词中提供 10 个任务示例（含其真实耗时）进行校准后，Claude Sonnet 4.5 的预估耗时与实际耗时的相关性。总体而言，Claude 的预估与开发者预估具有相近的方向性相关性：Spearman 相关系数 _ρ_ = 0.44，略低于开发者的 _ρ_ = 0.50；但 Claude 对短任务显著高估、对长任务显著低估。横纵坐标均采用以 10 为底的对数刻度。误差线表示各分箱（bin）的 95% 置信区间（CIs）。

## Results

## 结果

We first use the methods above to estimate task-level savings, then aggregate these into estimates of economy-wide effects.

我们首先运用上述方法估算**任务层级的效率提升**，再将这些结果汇总，推导出对**整体经济层面影响**的估计。

### Task-level savings

### 任务层级的效率提升

![](images/estimating-ai-productivity-gains/img_005.jpg)Claude’s estimated task time, average hourly wage of the occupation, implied task cost, and time savings for nine different tasks. **Task time** is estimated by having Claude predict how long a professional would take to perform the task without AI assistance. **Hourly wage** is derived from the Occupational Employment and Wage Statistics (OEWS) May 2024 data. **Task cost** is computed by multiplying the task time by the hourly wage. **Time savings** is computed by estimating the time the human took to complete the task and computing _1 - time\_with\_ai / time\_without\_ai_.

![](images/estimating-ai-productivity-gains/img_005.jpg)Claude 对九项不同任务的预估耗时、对应职业的平均时薪、隐含任务成本及时间节省量。**任务耗时**由 Claude 预估一名专业人士在无 AI 协助下完成该任务所需的时间得出。**时薪**数据源自美国劳工统计局《职业就业与工资统计》（OEWS）2024 年 5 月发布数据。**任务成本**通过将任务耗时乘以时薪计算得出。**时间节省量**则通过预估人类完成该任务的耗时，并按公式 _1 −（使用 AI 耗时）/（未使用 AI 耗时）_ 计算得出。

#### Example tasks demonstrate a range of time savings

#### 示例任务展示了多样化的效率提升幅度

Looking at individual tasks within occupations provides concrete examples of where and how AI might be delivering time savings. At the most extreme end, we see users complete curriculum development tasks that Claude thinks would take 4.5 hours in just 11 minutes. Such tasks have an implied labor cost of $115 based on the average hourly wage of teachers.

考察职业内部的单个任务，可提供具体实例，说明人工智能（AI）可能在哪些场景、以何种方式节省时间。在最极端的情况下，用户借助 Claude 完成课程开发任务仅需 11 分钟，而 Claude 估计人类单独完成该任务需耗时 4.5 小时。按教师平均时薪计算，此类任务隐含的人力成本为 115 美元。

People also use AI to save 87% of the time it would take to write invoices, memos, and other documents (at least for the type of documents Claude is asked to handle). Finally, AI saves 80% of time on financial analyst tasks like interpreting financial data for tasks that would ordinarily cost $31 in wages.

人们还利用 AI 将开具发票、撰写备忘录及其他文档（至少就 Claude 所处理的文档类型而言）所需时间缩短了 87%。最后，在财务分析师类任务（例如解读财务数据）上，AI 节省了 80% 的时间；此类任务若由人工完成，通常需支付 31 美元工资。

#### Task length varies dramatically across occupations

#### 不同职业间任务耗时差异显著

Human time estimates show that Claude handles tasks of very different lengths depending on the occupation. In the below plots, we show averages for each occupation category among the subset of tasks that Claude is used for¹. The average management task where Claude is used (e.g. selecting investments) is estimated to take humans 2.0 hours to complete, followed by legal (1.8 hours), education (1.7), and arts/media tasks (1.6). At the other end of the spectrum, food preparation tasks (e.g. planning or pricing menu items), installation/maintenance, and transportation tasks all take 0.3–0.5 hrs on average, suggesting more circumscribed tasks, or tasks with less waiting time. Given that Claude’s time estimates tend to underestimate long tasks and overestimate short tasks, it is possible that these differences might be even greater in practice.

人类对任务耗时的估算显示，Claude 所处理任务的长度因职业而异，差异极大。下图展示了在 Claude 实际被用于处理的任务子集中，各职业类别任务耗时的平均值¹。在管理类任务中（例如选择投资标的），Claude 辅助下的人类平均耗时估计为 2.0 小时；法律类任务为 1.8 小时；教育类为 1.7 小时；艺术/媒体类为 1.6 小时。而在另一端，食品准备类任务（例如菜单规划或菜品定价）、安装与维护类任务，以及交通运输类任务的平均耗时则仅为 0.3–0.5 小时，表明这些任务范围更窄，或等待时间更少。由于 Claude 对长任务的耗时估算往往偏低，而对短任务的估算又往往偏高，因此实践中这些差异可能更为显著。

![](images/estimating-ai-productivity-gains/img_006.jpg)Various figures derived from Claude’s time estimates for SOC major groups. Human time estimates vary substantially across occupations — People use Claude for management and legal tasks estimated to take humans around 2h unassisted, while healthcare support and food prep tasks average around a half-hour. Average hourly wage for the occupational category is retrieved from OEWS 2024 data. Average task cost is computed by multiplying each occupation’s hourly wage by its median task time and computing an average weighted by each task’s prevalence in our sample. Time savings are computed via _1 - time\_with\_ai / time\_without\_ai_.

![](images/estimating-ai-productivity-gains/img_006.jpg)基于 Claude 对标准职业分类（SOC）各大类任务的耗时估算所生成的多项指标。人类耗时估算在不同职业间差异巨大——人们使用 Claude 处理管理类和法律类任务，其人类独立完成耗时估计约为 2 小时；而医疗支持类与食品准备类任务则平均仅需约半小时。各职业类别的平均时薪数据源自美国劳工统计局（OEWS）2024 年数据。任务平均成本通过将各职业类别的时薪乘以其任务中位耗时得出，并按样本中各项任务出现频次加权平均计算。时间节省比例按公式 _1 −（使用 AI 耗时 / 未使用 AI 耗时）_ 计算。

Cost estimates amplify this variation in the impact of AI: the tasks with the longest time estimates also tend to be the tasks with the highest labor costs. We compute these cost estimates by multiplying the median time for each task by the associated occupation’s average wage in the OEWS May 2024 data. The average management task would cost $133 for a professional compared to $119 for legal tasks and $8 for tasks relating to food preparation and serving. Business and financial tasks average $69 while computer and mathematical tasks average $82.

成本估算进一步放大了 AI 影响力的这种差异：耗时估算最长的任务，往往也是人力成本最高的任务。我们通过将每项任务的中位耗时乘以对应职业在 OEWS 2024 年 5 月数据中的平均时薪，来计算这些成本估算值。一项典型的管理类任务，其专业人力成本为 133 美元；法律类任务为 119 美元；而食品准备与服务类任务仅为 8 美元。商业与金融类任务平均成本为 69 美元，计算机与数学类任务则为 82 美元。

Across all tasks we observe, we estimate Claude handles work that would cost a median of $54 in professional labor to hire an expert to perform the work in each conversation. Of course, the actual performance of current models will likely be worse than a human expert for many tasks, though recent research suggests [the gap is closing](https://openai.com/index/gdpval/) across a wide range of different applications.

在我们观测到的所有任务中，我们估算：Claude 所处理的工作，若聘请专家人工完成，每轮对话对应的中位专业人力成本为 54 美元。当然，当前模型在许多任务上的实际表现仍可能逊于人类专家；不过近期研究表明，[二者差距正在不断缩小](https://openai.com/index/gdpval/)，且这一趋势已覆盖大量不同应用场景。

Across major occupational groups, we observe a positive correlation between average hourly wage among tasks/occupations in our sample and the human-time-equivalent duration of the tasks Claude is asked to handle. For example, the Management and Legal occupational categories rank at the top of the classification in terms of average hourly wage—aligning with Claude’s strengths in complex knowledge work.

在主要职业大类中，我们观察到：样本内各任务/职业的平均时薪，与其对应任务的人类等效耗时之间呈正相关关系。例如，管理类与法律类职业在平均时薪排名中位居前列——这与 Claude 在复杂知识工作方面的优势高度吻合。

![](images/estimating-ai-productivity-gains/img_007.jpg)Correlation between average hourly wage of an occupation category and the average Claude-estimated task duration in our sample. Higher-wage occupations categories (e.g. Management and Legal) have tasks with more complex usage in our sample ( _r_ = 0.8).

![](images/estimating-ai-productivity-gains/img_007.jpg)职业类别平均时薪与本样本中 Claude 估算的平均任务耗时之间的相关性。高薪职业类别（例如管理类与法律类）在本样本中所对应的任务具有更高的复杂度（相关系数 _r_ = 0.8）。

#### Time savings are highly uneven across occupations

#### 时间节省程度在不同职业间极不均衡

Our human time and cost estimates capture the _magnitude_ of tasks people tackle with AI. But the time _savings_—Claude’s estimate for how much faster work gets done with AI—reflects the productivity gains that might come from using AI for those tasks.

我们的人力时间与成本估算捕捉了人们借助 AI 所处理任务的**规模（magnitude）**；而**时间节省量（time savings）**——即 Claude 对使用 AI 后工作提速程度的估算——则反映了在执行这些任务时，可能因采用 AI 而获得的生产率提升。

The median conversation experienced an estimated 84% time savings, though we see considerable variation across tasks and categories. For example, the task of checking diagnostic images only shows 20% time savings, likely because this is already a task that can be done quickly by experts without AI assistance. By contrast, the task of compiling information from reports sees approximately 95% time savings, likely because AI systems can read, extract, and cite information much more quickly than people. Overall, the distribution of time saved by task is concentrated within the 50–95% range, peaking between 80–90%.

中位数对话对应的时间节省量估算为 **84%**，但不同任务及类别之间存在显著差异。例如，“检查诊断影像”这一任务仅体现约 **20% 的时间节省**，原因很可能是该任务本身已可由专家在无 AI 协助下快速完成；相比之下，“从多份报告中汇编信息”这一任务则实现了约 **95% 的时间节省**，这很可能得益于 AI 系统在阅读、提取和引用信息方面远超人类的速度。总体而言，各任务所实现的时间节省量主要集中于 **50%–95% 区间**，峰值出现在 **80%–90% 区间**。

These large time savings align with Claude’s abilities to read and write far faster than people can. However, our approach doesn’t take into account the additional work people need to do to refine Claude’s outputs to a finished state, or whether they continue iterating on the work product across multiple sessions—both of which would result in smaller time savings. Past randomized controlled trials have typically found smaller time savings, including [56%](https://arxiv.org/abs/2302.06590), [40%](https://www.science.org/doi/10.1126/science.adh2586), [26%](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=4945566), [14%](https://www.nber.org/papers/w31161) and even [negative](https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/) time savings across different applications—perhaps due to these effects or because these studies examined earlier generations of models.

此类大幅时间节省与 Claude 远超人类的读写速度高度一致。然而，我们的方法**未计入**人们为将 Claude 的输出打磨至最终可用状态所需投入的额外工作量，也**未考虑**用户是否在多个会话中持续迭代优化成果——这两类因素均会导致实际时间节省量下降。过往多项随机对照试验所报告的时间节省量普遍更低，例如：[56%](https://arxiv.org/abs/2302.06590)、[40%](https://www.science.org/doi/10.1126/science.adh2586)、[26%](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=4945566)、[14%](https://www.nber.org/papers/w31161)，甚至出现过[负向节省（即耗时增加）](https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/)——这或许正源于上述因素，抑或因为这些研究考察的是更早期版本的模型。

![](images/estimating-ai-productivity-gains/img_008.jpg)Density plot of time savings across O\*NET tasks in our sample. We see that Claude’s estimated time savings are uneven across tasks in our sample, with most falling between 50 and 95%. The overall median savings is 81%. Time savings are computed by _1 - time\_with\_ai / time\_without\_ai_. Our estimates do not take into account the time spent refining Claude’s output outside of the chat window.

![](images/estimating-ai-productivity-gains/img_008.jpg)本样本中 O\*NET 各项任务的时间节省量密度分布图。可见，Claude 对各样本任务的时间节省量估算呈现不均衡分布，其中大多数集中于 **50% 至 95%** 区间；整体中位数节省量为 **81%**。时间节省量按公式 **1 −（启用 AI 耗时 / 未启用 AI 耗时）** 计算得出。需注意：我们的估算**未包含**用户在聊天窗口之外为精修 Claude 输出所花费的时间。

### From task-level efficiency gains to economy-wide productivity effects

### 从任务层级的效率提升到全社会层面的生产率影响

The above estimates capture AI-driven productivity gains at the task level. To understand macro-level impacts, this section models how these gains could aggregate across the entire economy, assuming they play out according to Claude’s estimates.

上述估算刻画了 AI 在**任务层级**所驱动的生产率提升。为理解其**宏观层面影响**，本节基于 Claude 的估算结果，建模分析此类提升如何在整个经济体中加总体现。

#### Methodology

#### 方法论

To estimate economy-wide productivity effects, we use Hulten’s theorem, a standard method that allows us to aggregate efficiency gains at the task-level to the broader US economy². As in [Acemoglu (2024)](https://economics.mit.edu/sites/default/files/2024-04/The%20Simple%20Macroeconomics%20of%20AI.pdf)’s “baseline” approach, we model the implied increase in labor productivity as a weighted average over task-level productivity gains—a modeling choice that implicitly assumes that capital investment will increase as a result of an increase in total factor productivity (TFP) associated with AI adoption. In this framework, the implied increase TFP is the gain in labor productivity multiplied by the labor share of income³.

为估算全社会层面的生产率影响，我们采用标准方法——**Hulten 定理**²，以将任务层级的效率提升加总至更广阔的美国经济体系。本方法沿用 [Acemoglu（2024）](https://economics.mit.edu/sites/default/files/2024-04/The%20Simple%20Macroeconomics%20of%20AI.pdf) 提出的“基准”路径：将隐含的劳动生产率提升建模为各项任务级生产率提升的**加权平均值**——该建模选择隐含地假设：伴随 AI 采用而带来的全要素生产率（TFP）提升，将带动资本投资增长。在此框架下，隐含的 TFP 提升等于劳动生产率提升乘以劳动收入占总收入的比重³。

**Task composition**: For each occupation, we obtain a list of work tasks from O\*NET. We then use Claude to estimate what fraction of workers' time is spent on each of those tasks. For example, Claude estimates that programmers spend 23% of their time writing and maintaining code, 15% analyzing and rewriting programs, and smaller fractions on testing, documentation, and meetings.

**任务构成（Task composition）**：针对每类职业，我们从 O\*NET 获取其对应的工作任务清单；随后利用 Claude 估算劳动者在每项任务上所花费的时间占比。例如，Claude 估算程序员将其 **23% 的时间**用于编写与维护代码，**15% 的时间**用于分析与重写程序，其余时间则较少地分配于测试、文档撰写及会议等任务。

**Task-level productivity improvements**: In the previous section, we provided estimates we can use to compute how much more quickly each task is completed with AI assistance. We take the log difference between time without AI and the time _with_ AI to generate a productivity improvement value, and conservatively assign tasks not observed in our sample a null improvement.

**任务层级的生产率提升**：前文已提供相关估算，可用于计算在 AI 辅助下每项任务完成速度的提升幅度。我们通过取“无 AI 时长”与“启用 AI 时长”的**对数差值**，生成一项生产率提升指标；对于本样本中未观测到的任务，则保守地赋予其 **零提升值（null improvement）**。

**Economy-wide estimate**: We weight each task's implied productivity gains by its economic importance using two factors: (i) the fraction of time that Claude estimates the occupation spends on that task (as above), and (ii) the occupation's share of the total US wage bill (the number of people employed in that occupational category multiplied by the average wage, then divided by total wage bill across all occupations). For the total wage bill, we use May 2024 OEWS data. This approach implicitly assumes the time estimates that Claude produces represent reliable averages across all instances of each task, and that Claude or similar AI systems will be adopted across the entire US economy.

**全经济体层面的估算**：我们依据两项指标，按每项任务的经济重要性对其隐含的生产率提升进行加权：（i）Claude 估算出该职业在该项任务上所花费的时间占比（如前所述）；（ii）该职业占美国全部工资总额的比重（即该职业类别的就业人数乘以平均工资，再除以所有职业类别的工资总额）。工资总额数据采用美国劳工统计局（BLS）2024年5月《职业就业与工资统计》（OEWS）数据。该方法隐含地假设：Claude 给出的时间估算值能可靠地代表每项任务在所有实际场景中的平均耗时，且 Claude 或类似人工智能系统将在整个美国经济中得到全面应用。

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F7ecf9cf6974d57657fffe7952e6de57077c3a768-9168x5164.png&w=3840&q=75)**US economy-wide labor productivity impact: top ten occupations.** Overall, Claude’s estimates imply a 1.8% annualized increase (dotted line) in US labor productivity assuming current AI systems were adopted universally for all tasks we observe, driven by software, management, marketing, and customer service tasks. This corresponds to an implied 1.08% annualized increase in TFP. The average _ln(time estimate ratio)_ represents the time-weighted productivity gain across all tasks in each occupation, where _time estimate ratio = time with AI / time without AI_. Labor statistics derived from OEWS 2024 data.

**美国全经济体劳动生产率影响：十大职业**。总体而言，Claude 的估算表明：若当前人工智能系统在我们所观察到的所有任务中实现全面应用，则美国劳动生产率将实现年化 1.8% 的增长（虚线所示），其主要驱动力来自软件开发、管理、市场营销及客户服务等任务。这一增长对应全要素生产率（TFP）年化约 1.08% 的提升。“平均 _ln(时间估算比)_” 表示各职业所有任务的加权时间生产率增益，其中 _时间估算比 = 使用 AI 所需时间 / 不使用 AI 所需时间_。相关劳动力统计数据源自 2024 年 OEWS 数据。

### Findings

### 主要发现

Assuming 10 years for AI to reach universal adoption across the US economy—and using current models—we calculate that Claude’s estimates imply an annual increase in US labor productivity of 1.8%. This would nearly double the current long-term growth rate, which has averaged 2.1% per year since 1947 and 1.8% since 2019. Assuming that labor’s share of total factor productivity is 0.64, this implies an overall total factor productivity increase of 1.1% per year. Given that TFP growth has tended to be less than 1% since the early 2000s, these estimates suggest that, even broad deployment of current AI systems could cause growth to double: achieving the rates of the late 1990s, and of the 1960s and 1970s5.

假设人工智能需 10 年时间在美国经济中实现全面普及——并基于当前模型——我们测算得出：Claude 的估算意味着美国劳动生产率将实现年均 1.8% 的增长。这一增速将接近当前长期增长率的两倍；而当前长期增长率自 1947 年以来平均为每年 2.1%，自 2019 年以来则为 1.8%。若假定劳动要素在全要素生产率（TFP）中的份额为 0.64，则上述结果对应整体 TFP 年均提升约 1.1%。鉴于 2000 年代初以来 TFP 增速普遍低于 1%，这些估算表明：即使仅部署当前一代人工智能系统，也足以推动经济增长率翻倍——达到 1990 年代末期，以及 1960–1970 年代的水平⁵。

This estimated increase in aggregate labor productivity implied by task-level efficiency gains is within the range of recent estimates of AI’s potential impact on productivity, though it lies towards the upper end (Filippucci, Gal, and Schief, 2024).

该估算所反映的、由任务级效率提升驱动的总体劳动生产率增长，处于近期关于人工智能对生产率潜在影响研究的估算区间之内，但偏向该区间的上限（Filippucci、Gal 和 Schief，2024）。

Importantly, this exercise assumes that AI capabilities (and humans’ effectiveness in using AI) remain the same over the next 10 years as when we took our sample. This, though, seems unlikely to hold: we think that AI will [continue to improve rapidly](https://www.anthropic.com/news/core-views-on-ai-safety) over the coming years.

尤为重要的是，本分析假设人工智能能力（以及人类使用人工智能的有效性）在未来十年内将维持在我们采样时的水平。然而，这一假设很可能不成立：我们认为，人工智能将在未来数年内[持续快速进步](https://www.anthropic.com/news/core-views-on-ai-safety)。

Therefore, this estimate should be taken as an exercise exploring what might happen based on _current usage patterns,_ not a prediction of the impact on productivity that is actually most likely to happen. As we have written about in other work, we remain extremely alert to the possibility that AI causes significant labor market disruptions, which would likely be associated with larger increases in productivity due to AI. As models progress, this could represent an approximate lower bound on the productivity effects of AI, although our estimate does not account for unevenness in adoption, which might reduce real-world productivity gains in the short term.

因此，本估算应被视作一项基于_当前使用模式_的情景推演，而非对未来最可能发生之生产率影响的预测。正如我们在其他研究中所指出的，我们始终高度警惕人工智能可能引发重大劳动力市场冲击的风险——此类冲击往往伴随更大幅度的生产率提升。随着模型持续演进，本估算或可近似视为人工智能生产率效应的下限；但需注意，我们的估算未考虑采纳程度的不均衡性，而这种不均衡性可能在短期内削弱现实世界中的生产率提升效果。

![](images/estimating-ai-productivity-gains/img_010.jpg)Labor productivity growth in the nonfarm business sector. The chart shows five year moving averages of the year-over-year percent change in labor productivity. We see a general decline from almost 3% in the 1960s to around 1.5% the last few years.

![](images/estimating-ai-productivity-gains/img_010.jpg)非农企业部门劳动生产率增长。图表显示劳动生产率同比变化率的五年移动平均值。我们可见，该指标总体呈下降趋势：从 1960 年代近 3% 降至最近几年约 1.5%。

Reflecting the fact that [some tasks and occupations appear much more frequently in our data than others](https://assets.anthropic.com/m/218c82b858610fac/original/Economic-Index.pdf), we observe similar phenomena in occupations’ contributions to labor productivity as well.Software developers contribute most (19%) to the total labor productivity gain attributable to AI. General and Operations Managers (about 6%), Market Research Analysts and Marketing Specialists (5%), Customer Service Representatives (4%) and Secondary School Teachers (3%) round out the top five.

这反映出一个事实：[某些任务和职业在我们的数据中出现频率远高于其他任务和职业](https://assets.anthropic.com/m/218c82b858610fac/original/Economic-Index.pdf)，同样现象也体现在各职业对劳动生产率提升的贡献度上。软件开发人员对人工智能驱动的劳动生产率总提升贡献最大（19%）；紧随其后的是：通用及运营经理（约 6%）、市场调研分析师与营销专家（5%）、客户服务代表（4%）以及中学教师（3%），共同构成前五名。

In contrast, restaurants, healthcare delivery, construction, and retail contribute much less to the overall productivity effect. This is mostly because few of their tasks appear in our data—largely because these occupations have few associated tasks in our sample.

相比之下，餐饮业、医疗服务交付、建筑业和零售业对整体生产率提升的贡献则小得多。这主要是因为这些行业中的多数任务并未出现在我们的数据集中——很大程度上是由于在我们的样本中，这些职业所关联的任务数量本身就非常有限。

### How might AI change how workers spend their time?

### 人工智能可能如何改变劳动者的时间分配方式？

If workers are able to accelerate a subset of their occupational tasks with AI, the tasks where AI provides less speedup may come to represent a larger and thus more important share of those occupations’ work. For example, AI might help a home inspector prepare reports, but if the inspector still has to spend the same amount of time physically traveling to the property to perform the inspection in person, this could make inspections a greater fraction of the job overall.

如果劳动者能够借助人工智能加速其职业任务中的一部分，那么那些人工智能提速效果较弱的任务，就可能在整体工作中占据更大、因而也更关键的比重。例如，AI 可能协助房屋检验员撰写检验报告，但如果检验员仍需花费同样多的时间亲自前往房产现场执行实地检验，那么实地检验环节在整个工作中的占比反而可能上升。

The figure below illustrates this for a few occupations. For software developers, AI speeds up the process of software development, testing, documentation, and manipulating data. But we do not currently see meaningful AI use for coordinating system installation or supervising the work of other technologists or engineers. For teachers, we see that AI assists with lesson and activity planning, but not with sponsoring extracurricular clubs or enforcing rules in the classroom.

下图以若干职业为例说明了这一现象：对软件开发者而言，AI 加速了软件开发、测试、文档编写及数据处理等环节；但目前尚未观察到 AI 在协调系统部署或监督其他技术人员与工程师工作等方面有实质性应用。对教师而言，AI 可辅助课程与教学活动设计，却无法替代其组织课外社团或在课堂中维持纪律等职责。

From a growth perspective, these observations align well with a recent observation from [Aghion, Jones, and Jones](https://www.nber.org/papers/w23928): “growth may be constrained not by what we are good at but rather by what is essential and yet hard to improve.”

从增长视角看，这些发现与 [Aghion、Jones 和 Jones](https://www.nber.org/papers/w23928) 近期提出的观点高度契合：“经济增长的瓶颈，未必在于我们擅长什么，而更可能在于那些至关重要却又难以提升的环节。”

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F4bf1b7050affa87212a5182b3ccbc615e78bf4d0-9168x8096.png&w=3840&q=75)Four different occupations along with “accelerated” tasks that show large potential time savings, and potential “bottleneck” tasks that do not appear in our sample. For example, software engineers see large estimated time savings in developing and debugging software, but not in supervising programmers. Weekly time fractions are estimated by Claude (see previous section).

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F4bf1b7050affa87212a5182b3ccbc615e78bf4d0-9168x8096.png&w=3840&q=75)四种不同职业，及其对应“已加速”任务（显示显著潜在时间节省）与潜在“瓶颈”任务（未出现在本样本中）。例如，软件工程师在软件开发与调试环节预估节省大量时间，但在指导程序员方面则无明显节省。每周各任务所占时间比例由 Claude 估算得出（参见前一节）。

## Limitations

## 局限性

Our approach has several limitations that we think warrant further research on this topic:

我们的方法存在若干局限性，我们认为这些局限值得针对该主题开展进一步研究：

- **Claude’s predictions are imperfect and we lack real-world validation of Claude’s time estimates**: AI systems are imperfect predictors, and can’t see activity that happens after the user finishes their interaction with the model. While we expect these estimates will improve with models capabilities, using model estimates introduces a significant source of noise. While our estimates show that models are approaching human performance at estimating task times, and humans are far from perfect themselves, we lack real-world data to validate the estimates that Claude provides.

- **Claude 的预测并不完美，且我们缺乏对其时间估算的现实世界验证**：AI 系统作为预测工具本身存在缺陷，且无法观测用户结束与模型交互后所发生的后续活动。尽管我们预期随着模型能力提升，此类估算将不断优化，但依赖模型估算本身即引入了显著的噪声源。虽然我们的估算显示，当前模型在任务耗时估计方面已接近人类水平——而人类自身也远非完美——但我们尚无真实世界数据来验证 Claude 所提供估算的准确性。

- **Task taxonomy limitations**: Real jobs are more complex than an O\*NET task list, and the time allocations we estimate for each task are only approximate. Many important aspects of work—tacit knowledge, relationships, judgment under uncertainty—don't appear in these formal task descriptions, and the connections _between_ tasks may matter just as much or more to productivity as the time savings for those tasks in isolation. While we show large predicted time savings for individual tasks, [a recent randomized controlled trial](https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/) studying end-to-end software features did not see time savings due to AI.

- **任务分类体系的局限性**：真实工作远比 O\*NET 任务清单复杂，我们为每项任务估算的时间分配仅属近似值。许多工作的重要维度——如默会知识、人际关系、不确定性下的判断力——并未体现在这些形式化的任务描述中；而任务之间的关联性，对生产力的影响甚至可能不亚于甚至超过单个任务独立节省的时间。尽管我们展示了单个任务上可观的预估时间节省，但一项近期关于端到端软件功能的随机对照试验（[详见此处](https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/)）却未观察到 AI 带来的实际时间节省。

- **Structural assumptions:** In our calculations above, we compare the time it would take a professional to complete a given task without AI to the time it took with AI. But this could either _understate_ the productivity gains – since it takes additional resources we’re not accounting for to hire an employee and communicate context, and possibly overstate it, if the quality of the AI’s work is worse than a human’s.

- **结构性假设的局限性**：在上述计算中，我们将专业人士在无 AI 辅助下完成某项任务所需时间，与使用 AI 后的实际耗时进行对比。但这种比较可能既**低估**也可能**高估**真实生产力提升：若忽略雇佣员工及传递上下文所需的额外资源，则可能低估增益；而若 AI 工作质量低于人类水平，则又可能高估增益。

- **Restructuring of organizations:** Historically, the largest productivity gains for individual firms have followed from [restructuring business operations](https://www.jstor.org/stable/2006600) to adopt new technologies. Our model can help predict the _effects_ of such a restructuring, but it cannot predict how companies might decide to restructure, or how quickly this process might happen.

- **组织重构的影响**：历史上，单个企业实现的最大生产力提升，往往源于为采用新技术而对业务运营进行重构（[参见此处](https://www.jstor.org/stable/2006600)）。我们的模型有助于预测此类重构可能带来的**影响**，却无法预测企业将如何决策重构，亦无法判断该过程推进的速度。

- **The role of innovation:** Technological innovation is [the engine](https://www.jstor.org/stable/1926047) of economic growth. Our model does not capture how AI systems could accelerate or even automate the scientific process, nor the effects that would have on productivity, growth, and the structure of work.

- **创新的作用**：技术创新是[经济增长的引擎](https://www.jstor.org/stable/1926047)。我们的模型并未涵盖 AI 系统如何加速乃至自动化科学发现过程，也未反映此类变革对生产力、经济增长及工作结构所产生的深远影响。

- **Limited data**: Our dataset is derived from [Claude.ai](http://claude.ai/redirect/website.v1.ad1e2a79-c5b8-42c0-955c-e4dcc00f242e) conversations only. This sample is not representative of the full spectrum of AI uses, and there’s likely some selection effect where the instances of tasks people use Claude for are the ones they think Claude will be most useful. Additionally, due to our finite sample size, we likely miss some less common AI tasks.

- **数据有限性**：本数据集仅来源于 [Claude.ai](http://claude.ai/redirect/website.v1.ad1e2a79-c5b8-42c0-955c-e4dcc00f242e) 的对话记录。该样本无法代表 AI 应用的全部光谱，且可能存在选择偏差——即用户倾向于仅在自认为 Claude 最具价值的任务上启用它。此外，受限于样本规模，我们很可能遗漏了一些使用频率较低的 AI 任务。

The measurement infrastructure we develop here enables continuous tracking of the effect of AI on time savings at large scale. As models improve and better methods address these limitations, we can re-estimate these time savings and identify how these capability improvements translate into broader economic impacts. We expect to track these changes in the months and years ahead.

我们在此构建的测量基础设施，支持大规模持续追踪 AI 对时间节省的影响。随着模型能力提升及更优方法逐步克服上述局限，我们将重新估算时间节省量，并厘清这些能力进步如何转化为更广泛的经济影响。我们预计将在未来数月乃至数年内持续追踪这些变化。

## Conclusion

## 结论

Claude handles tasks of widely varying complexity—from simple food preparation questions that would take a few minutes to complete, to complex legal and management tasks that would take multiple hours. But what is the aggregate effect of this work?

Claude 能够处理复杂度差异极大的各类任务——从只需几分钟即可完成的简单烹饪问题，到需耗时数小时的复杂法律与管理任务。但此类工作的总体影响究竟如何？

Based on Claude’s time estimates per task (and assuming universal adoption over the next 10 years), we find that use of _current_ models implies a potential increase in US labor productivity of 1.8% per year—a doubling of the recent rate of labor productivity growth. Based on current AI use, these gains would be concentrated in technology, education, and professional services, while retail, restaurants, and transportation sectors would see minimal impact. We’ll be tracking these changes over time as part of our [Economic Index](https://www.anthropic.com/economic-index) as model capabilities, products, and adoption continue to progress.

基于 Claude 对每项任务所估算的时间（并假设未来十年内实现全面普及），我们发现：采用 _当前_ 模型有望使美国劳动力生产率每年提升 1.8%——相当于近期劳动力生产率增速的两倍。依据当前 AI 的应用情况，这些增益将主要集中于科技、教育及专业服务行业；而零售、餐饮和交通运输等行业则几乎不会受到显著影响。随着模型能力、产品形态与普及程度的持续演进，我们将把这些变化纳入我们的 [经济指数](https://www.anthropic.com/economic-index) 进行长期追踪。

These productivity gains come from making existing tasks faster to complete. Historically, though, transformative productivity improvements—from electrification, computing, or the internet—came not from speeding up old tasks, but from fundamentally reorganizing production. In futures like these, AI not only makes implementing features faster, but companies restructure meetings and code review to validate and ship those features faster, whether using AI or through other means.

上述生产率提升源于让既有任务完成得更快。然而，历史经验表明，真正具有变革意义的生产率跃升——无论是来自电气化、计算机还是互联网——并非源于对旧有任务的加速，而是源于对整个生产方式的根本性重构。在这样的未来图景中，AI 不仅加快了功能开发的速度，更促使企业重新设计会议机制与代码评审流程，从而更高效地验证并交付这些功能——无论是否直接依赖 AI 技术本身。

Our framework could be used to help estimate the effects of such restructuring, but it cannot predict which changes will occur, or how quickly. An important direction for future work is understanding this question—to get a better understanding of when and how firms are reorganizing themselves around emerging AI capabilities. The answer will determine when AI makes the jump from providing significant but bounded productivity boosts, to representing the kind of structural transformation that has historically defined technological revolutions.

我们的分析框架可用于辅助估算此类组织重构可能带来的影响，却无法预测具体哪些变革将发生，亦无法判断其发生速度。未来一项关键研究方向，正是深入探究这一问题——即更清晰地理解企业究竟会在何时、以何种方式围绕新兴 AI 能力进行自我重构。这一问题的答案，将决定 AI 是止步于提供显著但有限的生产率提升，还是最终演变为一种堪比历史上历次技术革命的结构性变革力量。

### Bibtex

### BibTeX 引用格式

If you'd like to cite this post, you can use the following Bibtex key:

如需引用本文，请使用以下 BibTeX 条目：

```
@online{tamkinmccrory2025productivity,
author = {Alex Tamkin and Peter McCrory},
title = {Estimating AI productivity gains from Claude conversations},
date = {2025-11-05},
year = {2025},
url = {https://www.anthropic.com/research/estimating-productivity-gains},
}
```

复制

## Appendix

## 附录

### Comparison of Claude’s estimates to other estimates

### Claude 估算结果与其他估算的对比

![](images/estimating-ai-productivity-gains/img_012.jpg)  
![](images/estimating-ai-productivity-gains/img_012.jpg)  
AI 技术在未来 10 年内预计带来的年度劳动生产率增长率提升。图表引自 Filippucci、Gal 和 Schief（2024）。虚线代表 1.8%，该数值源自 Claude 的估算。

### 我们用于时间估算的提示词（Prompts）

### 用于人工耗时估算的提示词（Prompt）

**人工耗时估算提示词（Human time estimation prompt）**

```
Human: Consider the following conversation:

<conversation>
{{TRANSCRIPT}}
</conversation>

Estimate how many hours a competent professional would need to complete the tasks done by the Assistant.
Assume they have:
- The necessary domain knowledge and skills
- All relevant context and background information
- Access to required tools and resources

Before providing your final answer, use <thinking> tags to break down your reasoning process:
<thinking>
2-5 sentences of reasoning estimating how many hours would be needed to complete the tasks.
</thinking>

Provide your output in the following format:
<answer>A number representing hours (can use decimals like 0.5 for shorter tasks)</answer>

: <thinking>
```

```
Human：请考虑以下对话：

<conversation>
{{TRANSCRIPT}}
</conversation>

请估算一名能力胜任的专业人士完成助理所执行任务所需的时间（单位：小时）。
假设该专业人士：
- 具备所需的领域知识与技能；
- 拥有全部相关背景信息与上下文；
- 可随时访问完成任务所需的工具与资源。

在给出最终答案前，请使用 `<thinking>` 标签展开你的推理过程：
<thinking>
用 2–5 句话说明你如何估算完成这些任务所需的小时数。
</thinking>

请严格按如下格式输出结果：
<answer>一个表示小时数的数字（可使用小数，例如 0.5 表示较短任务）</answer>

: <thinking>
```

**Interaction time estimation prompt**

**交互时间估算提示**

```
Human: Consider the following conversation:

<conversation>
{{TRANSCRIPT}}
</conversation>

Estimate how many minutes the user spent completing the tasks in the prompt with the model.
Consider:
- Number and complexity of human messages
- Time reading Claude's responses
- Time thinking and formulating questions
- Time reviewing outputs and iterating
- Realistic typing/reading speeds
- Time implementing suggestions or running code outside of the converesation (only if directly relevant to the tasks)

Before providing your final answer, use <thinking> tags to break down your reasoning process:
<thinking>
2-5 sentences of reasoning about how many minutes the user spent.
</thinking>

Provide your output in the following format:
<answer>A number representing minutes</answer>

Assistant: <thinking>
```

```
Human：请参考以下对话：

<conversation>
{{TRANSCRIPT}}
</conversation>

请估算用户在该提示中，为完成各项任务而与模型交互所花费的总时长（单位：分钟）。
需综合考虑：
- 用户发送消息的数量及其复杂程度；
- 阅读 Claude 回复所用时间；
- 思考并组织问题所用时间；
- 审阅输出结果及进行多轮迭代所用时间；
- 符合实际的打字与阅读速度；
- 在对话之外实施建议或运行代码所用时间（仅当该操作与提示中的任务直接相关时计入）。

在给出最终答案前，请使用 `<thinking>` 标签分步阐述你的推理过程：
<thinking>
用 2–5 句话说明你如何估算用户所花费的分钟数。
</thinking>

请严格按如下格式输出结果：
<answer>一个代表分钟数的数字</answer>

Assistant: <thinking>
```

**Software development time estimation prompt**

**软件开发时间估算提示**

```
Human: You are estimating software development tasks for open-source projects. Provide ONLY a number in hours (e.g., 0.3, 1.6, 15). Do not explain.
Task: {task}
Description: {description}:
Estimate (hours):
Assistant:
```

```
Human：你正在为开源项目中的软件开发任务进行工时估算。请仅输出一个以“小时”为单位的数字（例如：0.3、1.6、15），不要附加任何解释。
任务：{task}
描述：{description}：
估算（小时）：
Assistant：
```

Copy

**Task time estimation prompt**

复制

**任务耗时估算提示词**

```
You are estimating how much time workers in the occupation "{occupation_title}" spend on each of their job tasks.

你正在估算从事“{occupation_title}”这一职业的工作者在各项工作任务上所花费的时间。

Below is the complete list of tasks for this occupation. For each task, estimate how many hours per week a typical worker spends on it.

以下是该职业的全部工作任务列表。请针对每项任务，估算一名典型工作者每周在该任务上花费的小时数。

Important: Don't worry about making the hours sum to exactly 40 or any specific total - we'll normalize the results afterward. Just give your best estimate for each task independently based on what seems realistic.

重要提示：无需刻意使各任务小时数之和恰好为40小时（或任何特定总数）——我们后续会统一归一化处理结果。请仅根据现实合理性，独立地为每项任务提供你最合理的估算值。

Tasks:
{tasks}

工作任务：
{tasks}

Return ONLY a JSON object mapping each task_id to your estimated hours per week, with no additional text, explanations, or commentary. Format:
请仅返回一个 JSON 对象，将每个 task_id 映射至你估算的每周小时数，不包含任何额外文字、解释或说明。格式如下：
{{
  "task_id_1": hours,
  "task_id_2": hours,
  ...
}}"""
```