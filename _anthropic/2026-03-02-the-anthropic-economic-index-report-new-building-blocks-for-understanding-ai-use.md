---
title: "The Anthropic Economic Index report: New building blocks for understanding AI use"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/economic-index-primitives"
scraped_at: "2026-03-02T09:21:25.196726076+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
{% raw %}

经济研究

# Anthropic 经济指数：理解 AI 应用的新基石

2026 年 1 月 15 日

[阅读完整报告](https://www.anthropic.com/research/anthropic-economic-index-january-2026-report)

![Anthropic 经济指数：理解 AI 应用的新基石](images/the-anthropic-economic-index-report-new-building-blocks-for-understanding-ai-use/img_001.svg)

#### 脚注

1. 与以往各期报告一致，本报告所有分析均基于隐私保护型分析方法。全文所分析的数据包括：从 Claude.ai 免费版、Pro 版与 Max 版用户对话中随机抽取的 100 万条对话（我们亦称其为“消费者数据”，因其主要反映消费者端使用场景）；以及来自我们第一方（1P）API 流量的 100 万条对话转录文本（我们亦称其为“企业数据”，因其主要反映企业级使用场景）。

2. 更具体而言：
1. **任务复杂度**（Task complexity）：反映不同任务在复杂程度上的差异，包括完成所需时间及难度。例如，O\*NET 分类体系中的“调试”（debugging）任务，在实际中可能指 Claude 修复某函数中的一个微小错误，也可能指对整个代码库进行系统性重构——二者对劳动力需求的影响截然不同。我们通过以下三方面衡量复杂度：人类在无 AI 协助下完成该任务的预估耗时、人类在 AI 协助下完成该任务的实际耗时，以及用户是否在单次对话中处理多个任务。
2. **人类与 AI 技能要求**（Human and AI skills）：探讨自动化如何与技能层级相互作用。若 AI 主要替代低专业门槛的任务，同时增强高技能工作的效能，则可能构成一种新型“技能偏向型技术变革”（skill-biased technical change）——即提升对高技能劳动者的需求，同时挤出低技能岗位。我们通过两个维度衡量：用户是否能在不借助 Claude 的情况下独立完成该任务；以及理解用户提问与 Claude 回答所需的受教育年限。
3. **应用场景**（Use case）：区分专业用途、教育用途与个人用途。劳动力市场影响最直接源于职场应用；而教育用途则可能预示未来劳动力正在习得哪些可与 AI 协同互补的技能。
4. **AI 自主性**（AI autonomy）：衡量用户将决策权委托给 Claude 的程度。我们最新一期报告已记录到“指令式”（directive）使用行为持续上升——即用户将整项任务完全交由 Claude 执行。追踪自主性水平的变化（从主动协作到全权委托），有助于预测自动化进程的推进速度。
5. **任务成功率**（Task success）：指 Claude 对自身是否成功完成任务的评估结果。任务成功率既关乎自动化可行性（某项任务是否可被自动化？），也关乎自动化效率（实现自动化需多少次尝试？）。换言之，任务成功率同时影响着劳动力任务自动化的“可行性”与“成本”。

3. 实际上，部分[历史证据](https://www.michaelwebb.co/webb_ai.pdf)表明：当专利数据中首次出现可自动化特定工作岗位任务的技术时，相关职业群体随后往往面临就业人数与工资水平的双重下降。

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流利度指数”（AI Fluency Index）——该指数为衡量当今人类与 AI 协作水平提供了基准。

Is artificial intelligence really making people faster at work? What sort of tasks does AI support best? And how might it change the nature of people’s occupations?

人工智能真的让人在工作中变得更高效了吗？AI 最擅长支持哪类任务？它又将如何改变人们职业的本质？

At Anthropic, we’re measuring real-world AI use on an ongoing basis to answer questions exactly like these. Our privacy-preserving [analysis method](https://www.anthropic.com/research/clio) allows us to learn more about conversations on [Claude.ai](http://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835) (capturing uses by consumers) and our first-party API (mostly capturing uses by businesses).1 In past reports, we’ve assessed AI tasks by [occupation and wage level](https://www.anthropic.com/news/the-anthropic-economic-index), looked more closely at [software development](https://www.anthropic.com/research/impact-software-development), and studied AI use [by country and by US state](https://www.anthropic.com/research/economic-index-geography).

在 Anthropic，我们持续监测 AI 在真实世界中的使用情况，以回答诸如此类的问题。我们采用兼顾隐私保护的[分析方法](https://www.anthropic.com/research/clio)，从而更深入地了解 [Claude.ai](http://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835) 平台上的对话（主要反映消费者使用场景）以及我们的一方 API（主要反映企业用户使用场景）。¹ 此前的报告中，我们曾按[职业与薪资水平](https://www.anthropic.com/news/the-anthropic-economic-index)评估 AI 所承担的任务，更深入地考察了[软件开发领域](https://www.anthropic.com/research/impact-software-development)中的 AI 应用，并研究了 AI 使用情况的[国别及美国各州分布](https://www.anthropic.com/research/economic-index-geography)。

We’re now adding a new level of detail to our Economic Index. In our fourth report, we’re introducing what we’ve called **economic primitives**: a set of five simple, foundational measurements to track the economic impacts of Claude over time. Our initial set includes task complexity, skill level, purpose (work, education, or personal use), AI autonomy, and success.2 We derive these primitives from asking Claude to answer a common set of questions about every conversation in our sample for this report.

如今，我们正为“经济指数”（Economic Index）增添一个全新维度的细节。在第四份报告中，我们提出了所谓 **“经济原语”（economic primitives）** 的概念：即一组五个简明、基础的度量指标，用于长期追踪 Claude 所产生的经济影响。我们初步确立的五项原语包括：任务复杂度（task complexity）、技能层级（skill level）、使用目的（工作、教育或个人用途）、AI 自主性（AI autonomy）以及任务成功率（success）。² 这些原语均源自本报告所采样的每一场对话——我们要求 Claude 回答一套标准化问题，再据此提炼得出。

These primitives provide a leading indicator of AI’s potential economic impacts—and allow us to answer far more complex questions about how AI is already changing jobs. Our latest report, which samples conversations from November 2025 (predominantly using Claude Sonnet 4.5), uses our primitives to explore a wide range of questions that we wouldn’t otherwise be able to answer—including how Claude’s task-level success rates change for more complex tasks, and whether the use of Claude to date might portend a net-deskilling effect on many jobs.

这些原语构成了 AI 潜在经济影响的先行指标，使我们得以回答更为复杂的问题：AI 当下正如何重塑工作岗位？我们最新发布的报告采集了 2025 年 11 月的对话样本（主要使用 Claude Sonnet 4.5），并借助上述原语，探索了一系列此前难以触及的关键问题——例如：随着任务复杂度提升，Claude 在具体任务层面的成功率如何变化；又如：截至目前 Claude 的使用趋势，是否预示着许多岗位将面临整体性的技能降级（net-deskilling）效应。

You can read the fourth Economic Index report [here](https://www.anthropic.com/research/anthropic-economic-index-january-2026-report). Below, we summarize its results.

您可在此处阅读第四份《经济指数》报告：[链接](https://www.anthropic.com/research/anthropic-economic-index-january-2026-report)。下文将对其核心成果进行概要总结。

## **What we’ve learned from our economic primitives**

## **从“经济原语”中我们获得了哪些发现**

We applied our economic primitives to questions about individual tasks, occupations, and then the possible aggregate impacts of the changes we observe. (Our full methodology—including details on how we tested the accuracy of our primitives—is described in chapter two of the [full report](https://www.anthropic.com/research/anthropic.com/research/anthropic-economic-index-january-2026-report).)

我们将“经济原语”应用于三类问题：单个任务层面、职业层面，以及我们所观察到的变化可能带来的总体性影响。（关于完整的方法论——包括我们如何检验各项原语准确性的详细说明——详见[完整报告](https://www.anthropic.com/research/anthropic.com/research/anthropic-economic-index-january-2026-report)第二章。）

### Tasks

### 任务层面

#### **Which tasks does AI speed up, and by how much?**

#### **AI 加速了哪些任务？提速幅度有多大？**

We found that more complex tasks were sped up the most by Claude. We measure this by what Claude estimates as the number of years of schooling required to understand the conversation’s inputs: in Claude.ai, tasks with prompts requiring a high school education (12 years) were sped up by a factor of 9, while those requiring a college degree (16 years) were sped up by a factor of 12. (On the API, the speedup was greater still.) These results imply that AI’s productivity gains are currently accruing in tasks that require relatively high human capital, which is consistent with the [evidence](https://www.nber.org/papers/w32966) that white collar professionals are more likely to use AI at work.

我们发现，Claude 对更复杂的任务加速效果最为显著。这一结论基于 Claude 对理解对话输入内容所需受教育年限的估算：在 Claude.ai 平台上，需高中学历（12 年）才能理解的任务，处理速度提升了 9 倍；而需本科学历（16 年）的任务，处理速度则提升了 12 倍。（在 API 接口中，加速效果甚至更为显著。）这些结果表明，当前 AI 所带来的生产力提升主要集中于对人力资本要求相对较高的任务，这与一项[实证研究](https://www.nber.org/papers/w32966)的发现一致——即白领专业人士在工作中更有可能使用 AI。

This same trend holds—albeit in weaker form—when we adjust for tasks’ success rates. Claude successfully completes tasks that require a college degree 66% of the time, compared to 70% for those tasks that require less than a high school education. This reduces, but doesn’t eliminate, the overall effect: Claude’s impact on task speedup scales more sharply with complexity than complexity correlates with a decrease in success rate.

即使在调整任务成功率后，上述趋势依然存在——尽管强度有所减弱。Claude 完成需本科学历任务的成功率为 66%，而对低于高中学历要求的任务，成功率为 70%。这一差异削弱了但并未消除整体效应：Claude 对任务提速的影响随任务复杂度上升而急剧增强，其增幅远超复杂度上升所导致的成功率下降幅度。

![](images/the-anthropic-economic-index-report-new-building-blocks-for-understanding-ai-use/img_002.svg)_**Speedup and success rate vs. human years of schooling.** The chart on the left shows a scatterplot of the relationship between speedup and human years of schooling, measured at the O\*NET task level. The dashed lines show the line of best fit. The chart on the right shows the relationship with the success rate._

![](images/the-anthropic-economic-index-report-new-building-blocks-for-understanding-ai-use/img_002.svg)_**加速比与成功率 vs. 人类受教育年限**。左侧图表展示了在 O\*NET 任务层级上，任务加速比与人类受教育年限之间的散点关系图；虚线表示最佳拟合线。右侧图表则展示了成功率与受教育年限之间的关系。_

#### **What are the time horizons over which Claude can support tasks?**

#### **Claude 能支持多长时间跨度的任务？**

[METR](https://metr.org/)’s measure of AI’s [task horizons](https://metr.org/blog/2025-03-19-measuring-ai-ability-to-complete-long-tasks/) shows that longer tasks are harder for AI models to complete. But the length of time over which AI models can work is steadily increasing as models get better: this measure has now become a key indicator of AI progress.

[METR](https://metr.org/) 对 AI 的[任务时间跨度](https://metr.org/blog/2025-03-19-measuring-ai-ability-to-complete-long-tasks/)评估显示，任务耗时越长，AI 模型完成难度越大。但随着模型能力持续提升，AI 可胜任的任务时间跨度也在稳步增长；该指标目前已成为衡量 AI 进展的关键指标之一。

We’re able to complement METR’s analysis using our economic primitives. In the graph below, we show Claude’s task-level success rates relative to the amount of time a human would take to do the same task, both on [Claude.ai](http://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835) and on our API:

我们可借助自身的经济基础变量，对 METR 的分析形成有力补充。下图展示了在 [Claude.ai](http://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835) 平台及我们的 API 接口上，Claude 在各任务层级上的成功率与其对应的人类单独完成该任务所需时间之间的关系：

![](images/the-anthropic-economic-index-report-new-building-blocks-for-understanding-ai-use/img_003.jpg)_**Task success vs. human-only time.** This chart shows the relationship between task success (%) and the time the task would require a human to complete alone, all measured at the O\*NET task level and split by platform. The dashed lines show the fit from a linear regression._

![](images/the-anthropic-economic-index-report-new-building-blocks-for-understanding-ai-use/img_003.jpg)_**任务成功率 vs. 纯人工耗时**。本图表展示了任务成功率（%）与人类单独完成该任务所需时间之间的关系，所有数据均在 O\*NET 任务层级上测量，并按平台分组呈现。虚线表示线性回归拟合结果。_

METR’s benchmark suggests that Claude Sonnet 4.5 (the model in our own analysis) achieves 50% success rates on tasks of 2 hours. By contrast, our own API data finds that Claude is 50% successful at tasks that take nearly twice as long (around 3.5 hours), and on Claude.ai, the duration is vastly longer still—around 19 hours. But this might not be as discordant as it seems: our methodology is different to METR’s in some important ways. In our sample, users can break down complex tasks into smaller steps, creating a feedback loop that allows Claude to correct course. And rather than a fixed set of tasks, our sample contains a form of selection bias: users bring tasks to Claude that they’re more confident will work.

METR 的基准测试表明，Claude Sonnet 4.5（即我们本次分析所用模型）在耗时 2 小时的任务上能达到 50% 的成功率。相比之下，我们 API 的实测数据显示，Claude 在耗时近两倍（约 3.5 小时）的任务上仍能保持 50% 的成功率；而在 Claude.ai 平台上，这一阈值更高达约 19 小时。但这种差异未必如表面看来那般矛盾：我们的研究方法与 METR 存在若干关键区别。在我们的样本中，用户可将复杂任务拆解为多个小步骤，从而构建反馈闭环，使 Claude 能够动态调整执行路径；此外，我们的样本并非基于固定任务集，而是存在一定选择偏差——用户倾向于将他们更有信心能成功的任务提交给 Claude 处理。

Our analysis shows how Claude’s _effective_ time horizons might look different to those found in a study with a consistent set of tasks. We’ll track this indicator in further reports.

我们的分析揭示了 Claude 的*实际有效时间跨度*可能与采用统一任务集的研究所得结果存在差异。我们将在后续报告中持续追踪这一指标。

#### **How does the nature of Claude’s work vary across countries?**

#### **Claude 的工作性质在不同国家间有何差异？**

We find that Claude completes very different kinds of tasks in countries at different stages of economic development.  
我们发现，Claude 在处于不同经济发展阶段的国家中所完成的任务类型差异显著。

In countries with higher GDP per capita, Claude is used much more frequently for work or for personal use—whereas countries at the other end of the spectrum are more likely to use it for educational coursework.  
在人均 GDP 较高的国家，Claude 更常被用于工作或个人用途；而处于该光谱另一端的国家，则更倾向于将其用于教育类课程作业。

This fits a straightforward “adoption curve” story, in which lower-income countries show a large share of AI use on education and on a smaller number of work tasks, while AI use diversifies towards personal purposes as countries become richer.  
这一现象符合一个直观的“采用曲线”叙事：低收入国家将人工智能大量应用于教育领域，且仅覆盖少量工作任务；而随着国家日益富裕，人工智能的应用则逐步向更广泛、更多元的个人用途拓展。

These results align with recent work [by Microsoft](http://microsoft.com/en-us/research/wp-content/uploads/2025/12/New-Future-Of-Work-Report-2025.pdf) that associates AI use in education with lower per-capita income, and AI use for leisure with higher incomes.  
这些结果与微软近期的一项研究[成果](http://microsoft.com/en-us/research/wp-content/uploads/2025/12/New-Future-Of-Work-Report-2025.pdf)相吻合：该研究指出，教育领域的人工智能应用与较低的人均收入相关，而休闲领域的人工智能应用则与较高收入相关。

Our [recent partnership](https://www.anthropic.com/news/rwandan-government-partnership-ai-education) with the Rwandan government and ALX, a technology training provider, is designed with this in mind: participants begin by developing AI literacy, and we’re piloting a program for granting some graduates year-long access to Claude Pro, supporting the transition from educational use to a broader range of applications.  
基于上述洞察，我们近期与卢旺达政府及科技培训提供商 ALX 达成[合作](https://www.anthropic.com/news/rwandan-government-partnership-ai-education)：参与者首先培养人工智能素养；同时，我们正试点一项计划，为部分毕业生提供为期一年的 Claude Pro 使用权限，以支持其从教育用途顺利过渡至更广泛的实际应用场景。

![](images/the-anthropic-economic-index-report-new-building-blocks-for-understanding-ai-use/img_004.svg)_**Per capita income predicts how Claude is used across countries.** Each plot shows the relationship between the share of a specific kind of use (work, coursework, or personal) for Claude.ai conversations, and log GDP per capita._  
![](images/the-anthropic-economic-index-report-new-building-blocks-for-understanding-ai-use/img_004.svg)_**人均收入可预测各国对 Claude 的使用方式。** 每张图表均展示了 Claude.ai 对话中某一类用途（工作、课程作业或个人用途）的占比与人均 GDP 对数值之间的关系。_

### Occupations  
### 职业

#### **Coverage**  
#### **覆盖范围**

In our [first report](https://www.anthropic.com/news/the-anthropic-economic-index), with data from January 2025, we found that 36% of jobs in our sample saw Claude being used for at least a quarter of their tasks. Pooling data across reports, this has risen to 49%. But once we account for Claude’s _success_ _rate_ (which we weight according to how often workers do that task and how long the task takes), we get a different picture of which jobs are most affected by the use of AI.  
在我们的[首份报告](https://www.anthropic.com/news/the-anthropic-economic-index)（数据截至2025年1月）中，我们发现样本中36%的职业已将 Claude 应用于至少四分之一的任务；综合多期报告数据后，这一比例已上升至49%。但若进一步纳入 Claude 的**成功率**（我们依据任务执行频次与耗时进行加权），我们便能获得一幅关于人工智能影响程度截然不同的职业图景。

On the graph below, we plot that earlier measure of occupations’ task coverage along the _x_ axis, and our new, adjusted measure on the _y_ axis. Although the two are certainly correlated, we now find that some occupations (like data entry keyers and radiologists) are much more heavily affected by AI than task coverage alone would suggest, while others (like teachers and software developers) are relatively less affected.  
下图中，横轴（_x_ 轴）表示此前衡量的职业任务覆盖度，纵轴（_y_ 轴）则表示我们新提出的、经调整后的指标。尽管二者显然存在相关性，但我们如今发现：某些职业（如数据录入员和放射科医师）受人工智能的影响程度远超单纯的任务覆盖度所显示的水平；而另一些职业（如教师和软件开发人员）所受影响则相对较小。

![](images/the-anthropic-economic-index-report-new-building-blocks-for-understanding-ai-use/img_005.svg)_**Effective AI coverage vs. task coverage.** The plot shows the relationship between task effective AI coverage (%) and task coverage, measured at the occupation level. Effective AI coverage tracks the share of a worker’s time-weighted duties that AI could successfully perform, based on Claude.ai data. Task coverage is the share of tasks that appear in Claude.ai usage. The dashed line shows where effective AI coverage share equals task coverage._  
![](images/the-anthropic-economic-index-report-new-building-blocks-for-understanding-ai-use/img_005.svg)_**有效人工智能覆盖度 vs. 任务覆盖度。** 本图展示了职业层面“任务有效人工智能覆盖度（%）”与“任务覆盖度”之间的关系。“有效人工智能覆盖度”指：根据 Claude.ai 数据，人工智能能够成功完成的、经时间加权后占劳动者全部职责的比例；“任务覆盖度”则指出现在 Claude.ai 使用记录中的任务占比。虚线表示“有效人工智能覆盖度”等于“任务覆盖度”的临界点。_

That said, even our revised assessment is still limited: we only assess tasks that are performed on Claude.ai, and it’s not always clear how these conversations might map onto changes in the real world. This is an area we plan to dig into further in future.  
话虽如此，即便经过此次修订，我们的评估仍存在局限：目前仅涵盖在 Claude.ai 平台上实际执行的任务，而这些对话究竟如何映射到现实世界中的行为变化，尚不明确。这正是我们未来计划深入探究的重点方向之一。

#### **Task content**  
#### **任务内容**

A further question we asked is whether the tasks that AI covers represent the higher- or the lower-skilled components of a given occupation. Using an estimate that we create of the skill level required for each task, we find that Claude is relatively more likely to cover the tasks that require _higher_ education levels—specifically, tasks that require an average of 14.4 years of education (equivalent to a US associate’s degree), relative to the economy’s average of 13.2 (shown below). This aligns with our earlier finding that Claude is used more frequently by white-collar workers.

我们进一步提出的问题是：AI 所覆盖的任务，究竟代表某一职业中技能要求更高还是更低的部分？我们为每项任务构建了所需技能水平的估算值，结果发现，Claude 相对更可能覆盖那些需要**更高教育程度**的任务——具体而言，这些任务平均需要 14.4 年教育年限（相当于美国副学士学位），而整个经济体的平均教育年限仅为 13.2 年（如下图所示）。这一发现与我们此前的结论一致：即 Claude 在白领工作者中使用更为频繁。

![](images/the-anthropic-economic-index-report-new-building-blocks-for-understanding-ai-use/img_006.svg)_**Education level of all tasks vs. Claude-covered tasks.** The blue bars give the distribution of the predicted task-level education required for all tasks in the O\*NET database, weighted by employment. The orange bars show the same, restricting to tasks that appear in Claude.ai data._

![](images/the-anthropic-economic-index-report-new-building-blocks-for-understanding-ai-use/img_006.svg)  
**所有任务与 Claude 覆盖任务的教育程度对比**。蓝色柱状图表示 O\*NET 数据库中全部任务的预测任务级教育年限分布，并按就业人数加权；橙色柱状图则仅限于出现在 Claude.ai 数据中的任务，其余统计方式相同。

As an experiment, we estimated how removing these Claude-covered tasks would shift the task composition of people’s jobs. As a first-order effect, this would _deskill_ jobs on average, since it would remove those higher-education tasks. Professions like technical writers, travel agents, and teachers would be affected (as we discuss further in [the report](https://www.anthropic.com/research/anthropic.com/research/anthropic-economic-index-january-2026-report)), though a rarer few (like real estate managers) would see effects going the other way.

作为一项实验，我们估算了：若将这些由 Claude 覆盖的任务从工作中移除，会对从业者的工作任务构成产生何种影响。初步来看，这将平均意义上导致工作的“去技能化”（*deskill*），因为被移除的恰是那些高教育门槛的任务。技术作家、旅行社代理和教师等职业将受到显著影响（我们在[该报告](https://www.anthropic.com/research/anthropic.com/research/anthropic-economic-index-january-2026-report)中对此有进一步讨论），尽管极少数职业（如房地产经理）可能呈现相反趋势。

We’re not necessarily _predicting_ that this deskilling will occur: it’s possible that _even if_ AI fully automated the tasks it currently supports, the labor market would dynamically adjust in ways that this analysis doesn’t account for. (Of course, as models improve, the composition of tasks that AI covers will change, too.) That said, we think this offers a useful signal as to the most immediate effects that AI might have on occupations in the near future.3

我们并非必然在“预测”这种去技能化现象必将发生：即便 AI 完全自动化了其当前所支持的所有任务，劳动力市场仍可能以本分析尚未涵盖的方式进行动态调整。（当然，随着模型能力持续提升，AI 所覆盖任务的构成本身也会随之变化。）尽管如此，我们认为，这一分析仍为研判 AI 在近期对各类职业可能产生的最直接影响，提供了有价值的信号。³

### **Aggregate impact**

### **总体影响**

In our earlier research, we [estimated](https://www.anthropic.com/research/estimating-productivity-gains) that the widespread adoption of AI could increase US labor productivity growth by 1.8 percentage points per year over the next ten years—around double the trend rate. Our new primitives allow us to revisit this analysis.

在我们早期的研究中，我们曾[估算](https://www.anthropic.com/research/estimating-productivity-gains)：AI 的广泛采用有望在未来十年间，使美国劳动生产率年增长率提升 1.8 个百分点——约为长期趋势增速的两倍。借助本次构建的新基础指标（primitives），我们得以重新审视这一分析。

Based on our estimates of task speedups alone, we replicated our earlier finding of a 1.8 percentage point increase (even when we added in our API data). But when we account for task _reliability_—that is, when we adjust our estimate of task-level time savings by the probability that the task is _successful_, our estimate falls by about one-third for tasks completed on [Claude.ai](http://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835) (to 1.2 percentage points per year), and by slightly more (to 1.0 percentage points) for the typically more challenging tasks completed on our API.

仅基于我们对各项任务加速效应的估算，我们复现了此前 1.8 个百分点的增长结论（即使纳入 API 数据后亦然）。但当我们进一步纳入任务“可靠性”（*reliability*）因素——即根据任务成功完成的概率，对任务级时间节省量进行校准后，估算结果便出现下调：在 [Claude.ai](http://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835) 上完成的任务，其增长贡献下降约三分之一，至每年 1.2 个百分点；而在我们的 API 上完成的通常更具挑战性的任务，其贡献则进一步降至每年 1.0 个百分点。

Even a 1 percentage point increase in annual labor productivity growth would still be notable: it would return US productivity growth to the rates of the late 1990s and early 2000s. And, as we mentioned in our [earlier research](https://www.anthropic.com/research/estimating-productivity-gains), this top-line estimate does not account for the possibilities that AI models become much more powerful, or that the use of AI at work becomes much more sophisticated—which could push the number much higher. Indeed, since our survey, Claude has become substantially more powerful, with the release of Claude Opus 4.5.

即便年劳动生产率增长率仅提升 1 个百分点，也已意义显著：这将使美国生产率增速回升至上世纪 90 年代末至本世纪初的水平。此外，正如我们在[早期研究](https://www.anthropic.com/research/estimating-productivity-gains)中所指出，这一顶层估算并未考虑两种可能性：一是 AI 模型能力大幅增强；二是职场中 AI 的应用方式变得远为成熟——而这两种情形均可能将实际增幅推升至更高水平。事实上，自我们开展本次调研以来，Claude 已凭借 Claude Opus 4.5 的发布而显著增强其能力。

## **Updates on our previous measures**

## **对既有衡量指标的更新**

In addition to our primitives, we collected a new round of data on the measures we’ve been tracking in our previous reports. This allows us to pick out trends in AI use over the course of 2025, from January to November. Here, we mostly find only small evolutions from the results of previous analyses, which pointed to an uneven distribution of Claude use.

除上述新构建的基础指标外，我们还围绕此前报告中持续追踪的各项指标，采集了新一轮数据。这使我们得以梳理出 2025 年 1 月至 11 月期间 AI 使用趋势的变化。总体来看，相较于此前分析所揭示的 Claude 使用分布不均这一结论，本次更新结果仅呈现出细微演进。

First, we find that the use of Claude has remained highly concentrated among certain tasks: even though our sample includes 3,000 unique work tasks on Claude.ai, the top ten account for 24% of the set, which has steadily increased from 21% in January 2025. More specifically, computer and mathematical tasks continue to dominate Claude use: they’re about a third of all conversations on Claude.ai, and nearly half of our API traffic.

首先，我们发现 Claude 的使用持续高度集中于某些特定任务：尽管我们的样本涵盖了 Claude.ai 上的 3,000 项独立工作任务，但排名前十的任务已占全部任务的 24%，这一比例较 2025 年 1 月的 21% 持续上升。更具体而言，计算机与数学类任务持续主导 Claude 的使用：它们约占 Claude.ai 上全部对话的三分之一，且接近我们 API 流量的一半。

Second, our new report finds that augmentation (52% of conversations) has overtaken automation (45%) as the most popular pattern of interaction with Claude on [Claude.ai](http://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835). This is a reversal of what we saw in our August sample (when automation led by 49% to 47%), but, when we assess this question over a longer time-frame, we still see a slow rise in _automation_’s share of tasks: augmentation led by 55% to 41% in January of last year, and by 55% to 42% in March.

其次，我们最新报告发现，在 [Claude.ai](http://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835) 上，增强型（augmentation）交互模式（占全部对话的 52%）已超越自动化（automation）模式（45%），成为用户与 Claude 互动的最主要方式。这与我们去年 8 月样本中观察到的趋势相反（当时自动化以 49% 对 47% 领先）；但若将时间维度拉长来看，自动化任务占比仍呈现缓慢上升趋势：去年 1 月，增强型与自动化之比为 55% 对 41%，今年 3 月则为 55% 对 42%。

Third, our latest analysis shows that the geographic concentration of AI use (as we [discussed last time](https://www.anthropic.com/research/economic-index-geography)) remains evident. The US, India, Japan, the UK, and South Korea still lead in overall Claude.ai use, and adoption remains well-explained by GDP per capita. That said, in the US, we’ve observed greater changes: Claude use has become noticeably more evenly distributed across US states. In fact, if this trend was sustained, our model predicts that Claude use would be equalized across the country within two to five years. We discuss this model in more detail [in the report](https://www.anthropic.com/research/anthropic.com/research/anthropic-economic-index-january-2026-report).

第三，我们最新分析表明，人工智能使用的地理集中性（正如我们[上一次讨论](https://www.anthropic.com/research/economic-index-geography)所指出）依然显著。美国、印度、日本、英国和韩国在 Claude.ai 总体使用量上仍居前列，而各国采用率与人均 GDP 之间仍保持良好相关性。不过，在美国，我们观察到了更明显的变化：Claude 的使用在各州之间正变得显著更加均衡。事实上，若该趋势持续下去，我们的模型预测，全美范围内的 Claude 使用量将在两至五年内趋于均等化。我们将在[报告中](https://www.anthropic.com/research/anthropic.com/research/anthropic-economic-index-january-2026-report)更详细地阐述这一模型。

## **Conclusion**

## **结论**

The most immediate conclusion from our latest Economic Index report is that the impact of AI on the global workforce remains a highly uneven one: AI use remains concentrated in specific countries and occupations, and it affects some occupations in a very different way to others, as the evidence on task coverage suggests.

我们最新《经济指数》报告最直接的结论是：人工智能对全球劳动力的影响仍极不均衡——AI 的使用持续集中于特定国家与特定职业；同时，不同职业受其影响的方式差异显著，这一点从任务覆盖情况的实证证据中即可看出。

More generally, this report has given us a new baseline against which to compare our future surveys. As Claude improves, we expect it’ll be asked to take on harder tasks, and that it’ll likely find greater success. We also expect that tasks might move from [Claude.ai](http://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835) to the API (that is, from predominantly consumers to predominantly businesses) as they become more reliable—and if this happens, it’ll give us another possible indication of coming economic impacts, given the importance of business adoption for AI’s effect on productivity. Through our primitives, we’ll be able to measure how changes like these are beginning to impact real-world outcomes, including the nature of people’s work, and which people (and where) are likely to be most affected during this period of rapid technological transition.

更广泛而言，本报告为我们后续调研确立了一个全新基准。随着 Claude 能力的持续提升，我们预计它将被委以更具挑战性的任务，并有望取得更大成功。我们还预期，随着任务可靠性不断提高，越来越多任务将从 [Claude.ai](http://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835) 迁移至 API 接口（即用户构成将从以消费者为主转向以企业用户为主）；若此趋势成真，鉴于企业采纳对 AI 提升生产力的关键作用，这将成为预判未来经济影响的又一重要信号。借助我们的基础能力（primitives），我们将能够量化此类变化如何开始影响现实世界的结果，包括人们工作性质的演变，以及在此轮快速技术转型过程中，哪些人群（及其所在地区）最可能受到显著影响。

In the meantime, researchers, journalists, and the public can use our data to inform their own research and thinking, and to provide an empirical foundation for the potential policy responses we might need. For much more detail on each of the areas we’ve discussed above, see our [full report](https://www.anthropic.com/research/anthropic-economic-index-january-2026-report).

与此同时，研究人员、记者及公众均可利用我们的数据开展自身研究与思考，并为其所需潜在政策响应提供实证基础。关于上述各议题的更详尽分析，请参阅我们的[完整报告](https://www.anthropic.com/research/anthropic-economic-index-january-2026-report)。
{% endraw %}
