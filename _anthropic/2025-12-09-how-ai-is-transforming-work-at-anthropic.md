---
title: "How AI Is Transforming Work at Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/how-ai-is-transforming-work-at-anthropic"
date: "2025-12-09"
scraped_at: "2026-03-03T06:43:57.861147216+00:00"
language: "en-zh"
translated: true
description: "How AI Is Transforming Work at Anthropic"
---
&#123;% raw %}

Societal Impacts

社会影响

# How AI is transforming work at Anthropic

# 人工智能如何重塑 Anthropic 的工作方式

Dec 2, 2025

2025 年 12 月 2 日

![How AI is transforming work at Anthropic](images/how-ai-is-transforming-work-at-anthropic/img_001.svg)

![人工智能如何重塑 Anthropic 的工作方式](images/how-ai-is-transforming-work-at-anthropic/img_001.svg)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 熟练度指数”（AI Fluency Index）——这是衡量当今人类与人工智能协作水平的基准。

How is AI changing the way we work? Our [previous research](https://www.anthropic.com/economic-index) on AI’s economic impacts looked at the labor market as a whole, covering a variety of different jobs. But what if we studied some of the earliest adopters of AI technology in more detail—namely, us?

人工智能正如何改变我们的工作方式？我们此前关于人工智能经济影响的[研究](https://www.anthropic.com/economic-index)着眼于整体劳动力市场，覆盖了多种不同职业。但如果我们将镜头转向人工智能技术最早的一批采用者——也就是我们自己——并进行更深入的考察，又会发现什么？

Turning the lens inward, in August 2025 we surveyed 132 Anthropic engineers and researchers, conducted 53 in-depth qualitative interviews, and studied internal [Claude Code](https://www.anthropic.com/claude-code) usage data to find out how AI use is changing things at Anthropic. We find that AI use is radically changing the nature of work for software developers, generating both hope and concern.

2025 年 8 月，我们启动了一项向内审视的研究：面向 132 名 Anthropic 工程师与研究人员开展问卷调查，进行了 53 场深度质性访谈，并分析了内部 [Claude Code](https://www.anthropic.com/claude-code) 的使用数据，以探究人工智能应用正如何改变 Anthropic 的工作生态。研究发现，人工智能的使用正在深刻重塑软件开发人员的工作本质，既带来希望，也引发隐忧。

Our research reveals a workplace facing significant transformations: Engineers are getting a lot more done, becoming more “full-stack” (able to succeed at tasks beyond their normal expertise), accelerating their learning and iteration speed, and tackling previously-neglected tasks. This expansion in breadth also has people wondering about the trade-offs—some worry that this could mean losing deeper technical competence, or becoming less able to effectively supervise Claude’s outputs, while others embrace the opportunity to think more expansively and at a higher level. Some found that more AI collaboration meant they collaborated less with colleagues; some wondered if they might eventually automate themselves out of a job.

我们的研究揭示了一个正经历深刻变革的工作场所：工程师正在完成远超以往的工作量，变得更加“全栈化”（即能够胜任超出其原有专业领域范围的任务），学习与迭代速度显著加快，并开始着手处理此前被忽视的各类任务。这种能力边界的拓展也引发了人们对权衡取舍的思考——有人担忧这可能导致深层技术能力的弱化，或降低对 Claude 输出结果进行有效监督的能力；而另一些人则欣然拥抱这一契机，转而以更广阔的视野、更高阶的视角开展思考。部分员工发现，随着与 AI 协作增多，他们与同事之间的协作反而减少；还有人开始疑虑：自己是否终将被 AI 自动化取代，从而失去工作岗位。

We recognize that studying AI’s impact at a company building AI means representing a privileged position—our engineers have early access to cutting-edge tools, work in a relatively stable field, and are themselves contributing to the AI transformation affecting other industries. Despite this, we felt it was on balance useful to research and publish these findings, because what’s happening inside Anthropic for engineers may still be an instructive harbinger of broader societal transformation. Our findings imply some challenges and considerations that may warrant early attention across sectors (though see the Limitations section in the [Appendix](https://anthropic.com/research/how-ai-is-transforming-work-at-anthropic#appendix) for caveats). At the time this data was collected, Claude Sonnet 4 and Claude Opus 4 were the most capable models available, and capabilities have continued to advance.

我们意识到，在一家从事 AI 研发的公司内部研究 AI 的影响，本身就代表了一种相对优越的观察位置——我们的工程师能率先接触最前沿的工具，所处行业整体较为稳定，且他们自身正是推动 AI 变革、进而影响其他行业的关键力量。尽管如此，我们仍认为，系统性地开展此项研究并公开发布成果总体上具有重要价值：因为 Anthropic 内部工程师正在经历的变化，很可能预示着更广泛的社会性转型趋势。我们的研究结果揭示了一些跨行业亟需早期关注的挑战与考量因素（不过，请参阅[附录](https://anthropic.com/research/how-ai-is-transforming-work-at-anthropic#appendix)中的“局限性”章节以了解相关注意事项）。本数据采集时，Claude Sonnet 4 与 Claude Opus 4 是当时能力最强的模型，而模型能力至今仍在持续提升。

More capable AI brings productivity benefits, but it also raises questions about maintaining technical expertise, preserving meaningful collaboration, and preparing for an uncertain future that may require new approaches to learning, mentorship, and career development in an AI-augmented workplace. We discuss some initial steps we’re taking to explore these questions internally in the Looking Forward section below. We also explored potential policy responses in our recent blog post on [ideas for AI-related economic policy](https://www.anthropic.com/research/economic-policy-responses).

更强大的 AI 带来了显著的生产力提升，但也同时引发了一系列关键问题：如何维系扎实的技术专长？如何保障富有意义的人际协作不被削弱？又该如何为一个充满不确定性的未来做好准备——这一未来或将要求我们在 AI 增强型工作环境中，重新构想学习方式、导师机制与职业发展路径。我们将在下文“展望未来”一节中，介绍公司内部为探索上述问题而采取的一些初步举措。此外，我们近期发布的博客文章《[关于 AI 相关经济政策的若干构想](https://www.anthropic.com/research/economic-policy-responses)》也探讨了潜在的政策应对方案。

## Key findings

## 核心发现

In this section, we briefly summarize the findings from our survey, interviews, and Claude Code data. We provide detailed findings, methods, and caveats in the subsequent sections below.

本节简要汇总了我们通过问卷调查、深度访谈及 Claude Code 使用数据分析所得出的核心发现。后续各节将详述具体发现、研究方法及各项注意事项。

**Survey data**

**问卷调查数据**

1. **Anthropic engineers and researchers use Claude most often for fixing code errors and learning about the codebase**. Debugging and code understanding are the most common uses (Figure 1).

1. **Anthropic 的工程师与研究人员最常使用 Claude 来修复代码错误和理解代码库**。调试（debugging）与代码理解是其最普遍的两大用途（图 1）。

2. **People report increasing Claude usage and productivity gains.** Employees self-report using Claude in 60% of their work and achieving a 50% productivity boost, a 2-3x increase from this time last year. This productivity looks like slightly less time per task category, but considerably more output volume (Figure 2).

2. **员工报告 Claude 使用频率与生产力提升均持续增长。** 员工自述在 60% 的工作中使用了 Claude，并实现了约 50% 的生产力提升，较去年同期增长了 2–3 倍。这种生产力提升体现为：每类任务所耗时间略有缩短，但整体产出量显著增加（图 2）。

3. **27% of Claude-assisted work consists of tasks that wouldn't have been done otherwise**, such as scaling projects, making nice-to-have tools (e.g. interactive data dashboards), and exploratory work that wouldn't be cost-effective if done manually.

3. **27% 的借助 Claude 完成的工作，属于原本根本不会开展的任务类型**，例如项目规模化扩展、开发“锦上添花”型工具（如交互式数据看板），以及若由人工执行则成本效益过低的探索性工作。

4. **Most employees use Claude frequently while reporting they can “fully delegate” 0-20% of their work to it.** Claude is a constant collaborator but using it generally involves active supervision and validation, especially in high-stakes work—versus handing off tasks requiring no verification at all.

4. **绝大多数员工高频使用 Claude，但同时表示仅能将其“完全交托”承担 0–20% 的工作量。** Claude 已成为持续相伴的协作者，但实际使用中通常需主动监督与验证，尤其在高风险任务中——这与那种无需任何人工核查、可彻底放手交付的任务截然不同。

**Qualitative interviews**

**质性访谈发现**

1. **Employees are developing intuitions for AI delegation**. Engineers tend to delegate tasks that are easily verifiable, where they “can relatively easily sniff-check on correctness”, low-stakes (e.g. “throwaway debug or research code”), or boring (“The more excited I am to do the task, the more likely I am to not use Claude”). Many describe a trust progression, starting with simple tasks and gradually delegating more complex work—and while they’re currently keeping most design or “taste” tasks, this boundary is being renegotiated as models improve.

1. **员工正逐步形成关于 AI 任务委派的直觉判断**。工程师倾向于将那些易于验证（即能“快速嗅探式核查正确性”）、低风险（例如“一次性调试或研究用代码”）或枯燥乏味的任务交由 AI 处理（“我对某项任务越感兴趣，就越可能不使用 Claude”）。许多人描述了一种“信任演进”过程：从简单任务起步，逐步过渡到更复杂任务的委派；目前，多数设计类或涉及“品位判断”（taste）的任务仍由人类主导，但随着模型能力提升，这一边界正被不断重新界定。

2. **Skillsets are broadening into more areas, but some are getting less practice.** Claude enables people to broaden their skills into more areas (of software engineering (“I can very capably work on front-end, or transactional databases... where previously I would've been scared to touch stuff”), but some employees are also concerned, paradoxically, about the atrophy of deeper skillsets required for both writing and critiquing code—“When producing output is so easy and fast, it gets harder and harder to actually take the time to learn something.”

2. **技能广度持续拓展，但某些深层能力却面临练习不足的风险。** Claude 助力员工将能力延伸至更广泛的软件工程领域（“我如今能非常娴熟地开展前端开发或事务型数据库工作……而过去我甚至不敢轻易触碰这类任务”）；但与此同时，部分员工也矛盾地表达了对深层能力退化的隐忧——这些能力恰恰是编写与批判性评估代码所必需的：“当产出结果变得如此轻而易举、迅捷高效时，人们就越来越难真正静下心来，花时间去深入学习某项知识。”

3. **Changing relationship to coding craft.** Some engineers embrace AI assistance and focus on outcomes (“I thought that I really enjoyed writing code, and I think instead I actually just enjoy what I get out of writing code”); others say that “there are certainly some parts of \[writing code\] that I miss.”

3. **与编程技艺关系的转变。** 一些工程师欣然接纳 AI 辅助，转而聚焦于最终成果（“我原以为自己真心热爱写代码，但现在意识到，我真正享受的其实是写代码所能带来的成果”）；另一些人则坦言：“写作代码过程中，的确有某些部分让我怀念。”

4. **Workplace social dynamics may be changing.** Claude is now the first stop for questions that used to go to colleagues—some report fewer mentorship and collaboration opportunities as a result. (“I like working with people and it's sad that I ‘need’ them less now… More junior people don't come to me with questions as often.”)

4. **职场社交动态可能正在发生改变。** 过去会向同事请教的问题，如今往往首先求助于 Claude——由此，部分员工反映导师指导与协作机会有所减少。（“我喜欢与人共事，但如今‘需要’同事的程度降低了，这令我感到些许失落……初级同事也不再像以前那样频繁地向我提问。”）

5. **Career evolution and uncertainty.** Engineers report shifting toward higher-level work managing AI systems and report significant productivity gains. However, these changes also raise questions about the long-term trajectory of software engineering as a profession. Some express conflicting feelings about the future: “I feel optimistic in the short term but in the long term I think AI will end up doing everything and make me and many others irrelevant.” Others emphasize genuine uncertainty, saying only that it was “hard to say” what their roles might look like in a few years’ time.

5. **职业演进与不确定性。** 工程师报告自身工作重心正转向更高层级的 AI 系统管理，并收获了显著的生产力提升。然而，这些变化也引发了人们对软件工程作为一门职业之长期发展路径的深层追问。部分人对未来抱持矛盾心态：“短期内我持乐观态度，但长远来看，我认为 AI 最终将包揽一切，使我及许多同行变得无关紧要。”另一些人则强调真实的不确定性，仅表示“很难说清”几年之后自己的岗位职责究竟会呈现何种样貌。

**Claude Code usage trends**

**Claude Code 使用趋势**

1. **Claude is handling increasingly complex tasks more autonomously**.  
1. **Claude 正在以更高的自主性处理日益复杂的任务**。  
Six months ago, Claude Code would complete about 10 actions on its own before needing human input. Now, it generally handles around 20, needing less frequent human steering to complete more complex workflows (Figure 3). Engineers increasingly use Claude for complex tasks like code design/planning (1% to 10% of usage) and implementing new features (14% to 37%) (Figure 4).  
六个月前，Claude Code 通常在需要人工干预前仅能自主完成约 10 项操作；如今，它一般可自主完成约 20 项操作，从而更少依赖人工引导即可完成更复杂的端到端工作流（图 3）。工程师越来越多地将 Claude 应用于代码设计/规划（使用占比从 1% 上升至 10%）和新功能实现（使用占比从 14% 上升至 37%）等复杂任务（图 4）。

2. **Claude fixes a lot of “papercuts”.**  
2. **Claude 修复了大量“小痛点”（papercuts）**。  
8.6% of Claude Code tasks involve fixing minor issues that improve quality of life, like refactoring code for maintainability (that is, “fixing papercuts”) that people say would typically be deprioritized. These small fixes could add up to larger productivity and efficiency gains.  
8.6% 的 Claude Code 任务涉及修复那些提升日常开发体验的细微问题，例如为提升可维护性而重构代码（即所谓“修复小痛点”），而这类工作在传统开发流程中往往被搁置或降级处理。这些看似微小的修复日积月累，可能带来显著的整体生产力与效率提升。

3. **Everyone is becoming more “full-stack”.**  
3. **每位成员正日益向“全栈化”演进**。  
Different teams use Claude in different ways, often to augment their core expertise—Security uses it to analyze unfamiliar code, Alignment & Safety use it to build front-end visualizations of their data, and so on (Figure 5).  
不同团队以不同方式使用 Claude，通常旨在强化其核心专长：安全团队用它分析陌生代码，对齐与安全（Alignment & Safety）团队则用它构建数据的前端可视化界面，等等（图 5）。

## Survey data  
## 调研数据  

We surveyed 132 Anthropic engineers and researchers from across the organization about their Claude use, to better understand how exactly they were using it day-to-day. We distributed our survey through internal communication channels and direct outreach to employees across diverse teams representing both research and product functions. We have included a Limitations section in the Appendix with more methodological details, and we are sharing [our survey questions](https://assets.anthropic.com/m/6cd21f7d4f82afcb/original/Claude-at-Work-Survey.pdf) so others can evaluate our approach and adapt it for their own research.  
我们面向 Anthropic 全公司共 132 名工程师与研究人员开展了问卷调研，旨在深入理解他们日常工作中具体如何使用 Claude。调研通过内部通信渠道及跨研究与产品职能的多样化团队定向触达员工的方式展开。附录中已包含“局限性”章节，提供更详尽的方法论说明；同时，我们也公开了[本次调研所用问卷](https://assets.anthropic.com/m/6cd21f7d4f82afcb/original/Claude-at-Work-Survey.pdf)，以便他人评估本研究方法并据此开展自身研究。

### What coding tasks are people using Claude for?  
### 人们正将 Claude 应用于哪些编程任务？  

We asked the surveyed engineers and researchers to rate how often they used Claude for various types of coding tasks, such as “debugging” (using Claude to help fix errors in code), “code understanding” (having Claude explain existing code to help the human user understand the codebase), “refactoring” (using Claude to help restructure existing code), and “data science” (e.g. having Claude analyze datasets and make bar charts).  
我们请受访工程师与研究人员评估其使用 Claude 执行各类编程任务的频率，包括：“调试”（借助 Claude 协助修复代码错误）、“代码理解”（请 Claude 解释既有代码，以帮助人类用户理解代码库）、“重构”（借助 Claude 协助重组现有代码）以及“数据科学”（例如请 Claude 分析数据集并生成柱状图）等。

Below are the most common daily tasks. Most employees (55%) used Claude for debugging on a daily basis. 42% used Claude everyday for code understanding, and 37% used Claude everyday for implementing new features. The less-frequent tasks were high level design/planning (likely because these are tasks people tend to keep in human hands), as well as data science and front-end development (likely because they are overall less common tasks). This roughly aligns with the Claude Code usage data distribution reported in the “Claude Code usage trends” section.  
以下是使用频率最高的日常任务：多数员工（55%）每日使用 Claude 进行调试；42% 每日使用 Claude 辅助代码理解；37% 每日使用 Claude 实现新功能。相对低频的任务包括高层级设计/规划（原因可能是此类任务通常仍由人类主导决策），以及数据科学与前端开发（原因可能是整体上这些任务在日常工作中出现频次较低）。该分布大致吻合“Claude Code 使用趋势”一节中报告的使用数据分布。

![Figure 1: Proportion of daily users (x-axis) for various coding tasks (y-axis).](images/how-ai-is-transforming-work-at-anthropic/img_002.jpg)_Figure 1: Proportion of daily users (x-axis) for various coding tasks (y-axis)._  
![图 1：各类编程任务的每日使用者比例（横轴为比例，纵轴为任务类型）](images/how-ai-is-transforming-work-at-anthropic/img_002.jpg)_图 1：各类编程任务的每日使用者比例（横轴为比例，纵轴为任务类型）_

### Usage and productivity  
### 使用频率与生产力  

Employees self-reported that 12 months ago, they used Claude in 28% of their daily work and got a +20% productivity boost from it, whereas now, they use Claude in 59% of their work and achieve +50% productivity gains from it on average. (This roughly corroborates the 67% increase in merged pull requests—i.e. successfully incorporated changes to code—per engineer per day we saw when we adopted Claude Code [across our Engineering org](https://newsletter.pragmaticengineer.com/p/how-claude-code-is-built).) The year-on-year comparison is quite dramatic—this suggests a more than 2x increase in both metrics in one year. Usage and productivity are also strongly correlated, and at the extreme end of the distribution, 14% of respondents are increasing their productivity by more than 100% by using Claude—these are our internal “power users.”  
员工自评数据显示：一年前，他们在日常工作中使用 Claude 的比例为 28%，由此获得约 +20% 的生产力提升；而当前，这一使用比例已升至 59%，平均生产力提升达 +50%。（该结果与我们在工程部门全面采用 Claude Code 后观察到的现象基本一致——即每位工程师日均成功合并的 Pull Request（即代码变更被正式纳入主干）数量提升了 67%；详见[《Pragmatic Engineer》通讯报道](https://newsletter.pragmaticengineer.com/p/how-claude-code-is-built)。）同比变化极为显著——表明两项指标均在一年内实现了两倍以上的增长。此外，使用频率与生产力提升呈强相关性；在分布的高值端，有 14% 的受访者表示，借助 Claude 实现了超过 100% 的生产力提升——这部分员工即我们内部定义的“超级用户”（power users）。

To caveat this finding (and other self-reported productivity findings below), productivity is difficult to precisely measure (see [Appendix](https://anthropic.com/research/how-ai-is-transforming-work-at-anthropic#appendix) for more limitations). There is [recent work from METR](https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/), an AI research nonprofit, showing that experienced developers working with AI on highly familiar codebases overestimated their productivity boost from AI. That being said, the factors that METR identified as contributing to lower productivity than expected (e.g. AI performing worse in large, complex environments, or where there’s a lot of tacit knowledge/context necessary) closely correspond to the types of tasks our employees said they _don’t_ delegate to Claude (see [AI delegation approaches](https://anthropic.com/research/how-ai-is-transforming-work-at-anthropic#ai-delegation-approaches), below). Our productivity gains, self-reported _across_ tasks, might reflect employees developing strategic AI delegation skills—something not accounted for in the METR study.  
需特别说明的是（以下其他关于生产力的自评结果亦同理），生产力本身难以精确量化（更多方法论局限请参见[附录](https://anthropic.com/research/how-ai-is-transforming-work-at-anthropic#appendix)）。AI 研究非营利组织 METR 最近发布的一项研究指出：经验丰富的开发者在高度熟悉的代码库中借助 AI 工作时，往往会高估 AI 带来的生产力提升。但值得注意的是，METR 所识别出的导致实际生产力低于预期的关键因素（例如：AI 在大型复杂环境中的表现欠佳，或在高度依赖隐性知识/上下文的场景中效果受限），恰恰与我司员工明确表示 *不会* 交由 Claude 处理的任务类型高度吻合（详见下文[AI 任务委派策略](https://anthropic.com/research/how-ai-is-transforming-work-at-anthropic#ai-delegation-approaches)）。因此，我们所报告的、覆盖各类任务的自评生产力提升，或许正反映出员工正在系统性地发展一种“战略性 AI 委派能力”——而这一维度，在 METR 的研究中并未被纳入考量。

An interesting productivity pattern emerges when asking employees, for task categories where they currently use Claude, how it affects their overall time spent and work output volume in that task category. Across almost all task categories, we see a net decrease in time spent, and a larger net increase in output volume:

![Figure 2: Impact on time spent (left panel) and output volume (right panel) by task (y-axis). The x-axis on each plot corresponds to either a self-reported decrease (negative values), increase (positive values) or no change (vertical dashed line) in time spent or output volume for categories of Claude-assisted tasks, compared to not using Claude. Error bars show 95% confidence intervals. Circle area is proportional to the number of responses at each rating point. Only respondents who reported using Claude for each task category are included.](images/how-ai-is-transforming-work-at-anthropic/img_003.jpg)  
*图 2：各类任务（y 轴）对耗时（左图）和产出量（右图）的影响。每幅图的 x 轴表示员工自我报告的耗时或产出量变化情况（与未使用 Claude 时相比）：负值代表减少，正值代表增加，垂直虚线代表无变化。误差线表示 95% 置信区间。圆点面积与各评分点上的响应数量成正比。仅纳入报告在该任务类别中使用过 Claude 的受访者数据。*

However, when we dig deeper into the raw data, we see that the time saving responses cluster at opposite ends—some people spend significantly _more_ time on tasks that are Claude-assisted.

然而，当我们深入挖掘原始数据时发现，关于“节省时间”的反馈呈现两极分化——部分人在使用 Claude 辅助的任务上实际花费了显著**更多**的时间。

Why is that? People generally explained that they had to do more debugging and cleanup of Claude’s code (e.g. “when I vibe code myself into a corner”), and shoulder more cognitive overhead for understanding Claude’s code since they didn’t write it themselves. Some mentioned spending more time on tasks in an enabling sense—one said that using Claude helps them “persist on tasks that I previously would've given up on immediately”; another said it helps them do more thorough testing and also more learning and exploration in new codebases. It seems that generally, engineers experiencing time savings may be those who are scoping quickly-verifiable tasks for Claude, while those spending more time might be debugging AI-generated code or working in domains where Claude needs more guidance.

为什么会这样？受访者普遍解释称，他们需要投入更多精力调试和清理 Claude 生成的代码（例如，“当我靠直觉写代码把自己逼入死胡同时”），并且由于代码并非自己所写，还需承担更高的认知负荷来理解 Claude 的输出。还有一些人提到，他们在任务上花费了更多时间，但这种“增时”具有赋能性质：一位受访者表示，使用 Claude 帮助他“坚持完成那些原本会立刻放弃的任务”；另一位则指出，它促使自己开展更全面的测试，并在新代码库中进行更深入的学习与探索。总体来看，体验到时间节省的工程师，往往倾向于为 Claude 分配那些可快速验证的任务；而花费更多时间的工程师，则可能正忙于调试 AI 生成的代码，或工作在需要对 Claude 提供更多引导的领域。

It is also not clear from our data where reported time savings are being reinvested—whether into additional engineering tasks, non-engineering tasks, interacting with Claude or reviewing its output, or activities outside of work. Our task categorization framework does not capture all the ways engineers might allocate their time. Additionally, the time savings may reflect perception biases in self-reporting. Further research is needed to disentangle these effects.

此外，我们的数据尚无法明确显示这些被报告的“时间节省”究竟被重新投入到哪些活动中——是额外的工程任务、非工程类工作、与 Claude 的交互或对其输出的审阅，还是工作之外的活动？我们当前的任务分类框架并未涵盖工程师分配时间的所有可能方式。同时，这些时间节省的数据也可能受到自我报告中感知偏差的影响。要厘清上述各种效应，仍需进一步研究。

Output volume increases are more straightforward and substantial; there is a larger net increase across all task categories. This pattern makes sense when we consider that people are reporting on task categories (like “debugging” overall) rather than individual tasks—i.e. people can spend slightly less time on debugging as a category while producing much more debugging output overall. Productivity is very hard to measure directly, but this self-reported data suggests that AI enables increased productivity at Anthropic primarily through greater output volume.

产出量的提升则更为直接且显著；在所有任务类别中均观察到更大的净增长。这一现象不难理解：受访者报告的是任务大类（如整体“调试”工作），而非单个具体任务——即人们可以在“调试”这一大类任务上略微减少总耗时，却实现整体调试产出量的大幅增长。生产力本身极难直接衡量，但此类自我报告数据表明，AI 在 Anthropic 主要通过提升产出量来增强工程师的工作效率。

### Claude enabling new work

### Claude 推动全新类型的工作

One thing we were curious about: Is Claude enabling qualitatively new kinds of work, or would Claude-assisted work have been done by employees eventually (albeit potentially at a slower rate)?

我们曾好奇的一个问题是：Claude 是否正在催生**质性全新**的工作类型？抑或这些由 Claude 辅助完成的工作，本就终将由员工独立完成（尽管可能进度更慢）？

Employees estimated that 27% of their Claude-assisted work wouldn't have been done without it. Engineers cited using AI for scaling projects, nice-to-haves (e.g. interactive data dashboards), useful but tedious work like documentation and testing, and exploratory work that wouldn't be cost-effective manually. As one person explained, they can now fix more “papercuts” that previously damaged quality of life, such as refactoring badly-structured code, or building “small tools that help accomplish another task faster.” We looked for this in our usage data analysis as well, and [found that](https://anthropic.com/research/how-ai-is-transforming-work-at-anthropic#fixing-papercuts) 8.6% of Claude Code tasks involve ‘papercut fixes.’

员工估计，其借助 Claude 完成的工作中，有 **27%** 若无 Claude 就根本不会被执行。工程师们列举了多种 AI 应用场景：规模化推进项目、实现“锦上添花”型需求（例如交互式数据看板）、处理虽有价值却枯燥繁琐的任务（如文档编写与测试），以及开展人工执行成本过高、因而难以推进的探索性工作。一位受访者解释道，如今他们能修复更多此前损害工作体验的“纸割伤”（papercuts）问题，比如重构结构混乱的代码，或开发“能加速完成另一项任务的小型工具”。我们在使用数据分析中也专门考察了这一现象，并[发现](https://anthropic.com/research/how-ai-is-transforming-work-at-anthropic#fixing-papercuts)：在所有 Claude Code 任务中，有 **8.6%** 属于“纸割伤修复”类任务。

Another researcher explained that they ran many versions of Claude simultaneously, all exploring different approaches to a problem:  

另一位研究员解释道，他们曾同时运行多个 Claude 版本，让每个版本分别尝试解决同一问题的不同路径：

> People tend to think about super capable models as a single instance, like getting a faster car. But having a million horses… allows you to test a bunch of different ideas… It’s exciting and more creative when you have that extra breadth to explore.

> 人们往往将超强能力的大模型想象成一个单一实例，就像换一辆更快的汽车。但拥有一百万匹马……却能让你尝试大量不同的想法……当拥有这种额外的广度去探索时，工作变得更令人兴奋、更具创造性。

As we'll see in the following sections, this new work often involves engineers tackling tasks outside their core expertise.

正如我们在接下来的章节中所见，这类新工作常常要求工程师承担超出其核心专业领域之外的任务。

### How much work can be fully delegated to Claude?

### 克劳德（Claude）能完全接管多少工作？

Although engineers use Claude frequently, more than half said they can “fully delegate” only between 0–20% of their work to Claude. (It’s worth noting that there is variation in how respondents might interpret “fully delegate”—from tasks needing no verification at all to those that are reliable enough to require only light oversight.) When explaining why, engineers described working actively and iteratively with Claude, and validating its outputs—particularly for complex tasks or high-stakes areas where code quality standards are critical. This suggests that engineers tend to collaborate closely with Claude and check its work rather than handing off tasks without verification, and that they set a high bar for what counts as “fully delegated.”

尽管工程师频繁使用克劳德，但超过半数受访者表示，他们仅能将自身工作量的 0–20% “完全委托”给克劳德。（需注意，“完全委托”的定义在受访者中存在差异——从完全无需人工验证的任务，到仅需轻度监督即可信赖的任务，均被纳入该范畴。）在解释原因时，工程师们描述了自己如何与克劳德积极、迭代地协作，并对其输出结果进行验证——尤其在任务复杂或影响重大（如对代码质量标准要求极高的场景）时更是如此。这表明，工程师倾向于与克劳德紧密协作并审慎核查其产出，而非不经验证便直接交托任务；同时，他们对“完全委托”设定了很高的门槛。

## Qualitative interviews

## 定性访谈

While these survey findings reveal significant productivity gains and changing work patterns, they raise questions about how engineers are actually experiencing these changes day-to-day. To understand the human dimension behind these metrics, we conducted in-depth interviews with 53 of the Anthropic engineers and researchers who responded to the survey, to get more insight into how they’re thinking and feeling about these changes in the workplace.

尽管上述调查结果揭示了显著的生产力提升和工作模式转变，但也引出了一个问题：工程师在日常工作中究竟如何切身感受这些变化？为深入理解这些量化指标背后的人文维度，我们对参与本次调查的 53 名 Anthropic 工程师与研究人员开展了深度访谈，以更全面地了解他们对职场变革的思考与情绪体验。

### AI delegation approaches

### 人工智能任务委托策略

Engineers and researchers are developing a variety of strategies for productively leveraging Claude in their workflow. People generally delegate tasks that are:

工程师与研究人员正在探索多种策略，以在实际工作流中高效利用克劳德。人们通常会将以下类型的任务委托给克劳德：

|     |
| --- |
| **Outside the user’s context _and_ low complexity**: <br>“I use Claude for things where I have low context, but think that the overall complexity is also low.”<br>“The majority of the infra\[structure\] problems I have are not difficult and can be handled by Claude… I don’t know Git or Linux very well… Claude does a good job covering for my lack of experience in these areas.” |
| **用户缺乏上下文 *且* 任务复杂度较低**：<br>“我用克劳德处理那些我本身不熟悉、但整体复杂度也较低的任务。”<br>“我遇到的大多数基础设施问题并不困难，克劳德完全可以应对……我对 Git 或 Linux 并不熟悉……克劳德很好地弥补了我在这些领域的经验短板。” |
| **Easily verifiable:**“It's absolutely _amazing_ for everything where validation effort isn't large in comparison to creation effort.” |
| **易于验证**：“对于所有‘验证所需投入远小于生成所需投入’的任务，克劳德的表现简直 _惊艳_。” |
| **Well-defined or self-contained:**“If a subcomponent of the project is sufficiently decoupled from the rest, I'll get Claude to take a stab.” |
| **定义清晰或自包含**：“如果项目的某个子模块已足够解耦于其余部分，我就会让克劳德来尝试解决。” |
| **Code quality isn’t critical:**“If it's throwaway debug\[ging\] or research code, it goes straight to Claude. If it's conceptually difficult or needs some very specific type of debug injection, or a design problem, I do it myself.” |
| **代码质量并非关键**：“如果是临时调试代码或研究型代码，我会直接交给克劳德；但如果任务在概念上十分复杂，或需要某种特定类型的调试注入，又或是涉及架构设计问题，那我就亲自处理。” |
| **Repetitive or boring:**“The more excited I am to do the task, the more likely I am to not use Claude. Whereas if I'm feeling a lot of resistance… I often find it easier to start a conversation with Claude about the task.”<br>In our survey, on average people said that 44% of Claude-assisted work consisted of tasks they wouldn't have enjoyed doing themselves. |
| **重复性高或枯燥乏味**：“我对某项任务越感兴趣，就越不可能使用克劳德；反之，若我对这项任务感到强烈抵触……我往往更容易主动开启与克劳德的对话，就此任务展开协作。”<br>在我们的调查中，受访者平均表示：44% 的克劳德辅助工作，是他们本人原本就不愿亲自完成的任务。 |
| **Faster to prompt than execute:**“\[For\] a task that I anticipate will take me less than 10 minutes... I'm probably not going to bother using Claude.”<br>“The cold start problem is probably the biggest blocker right now. And by cold start, I mean there is a lot of intrinsic information that I just have about how my team's code base works that Claude will not have by default… I could spend time trying to iterate on the perfect prompt \[but\] I’m just going to go and do it myself.” |
| **提示输入比手动执行更快**：“如果某项任务我预计自己能在 10 分钟内完成……那我大概率不会费心动用克劳德。”<br>“目前最大的障碍可能是‘冷启动问题’。所谓冷启动，是指我本人天然掌握的、关于团队代码库运作方式的大量隐性知识，而克劳德默认并不具备这些信息……我本可以花时间反复打磨出最理想的提示词，但最终我还是选择直接动手去做。” |

These factors mentioned by our employees in their decisions about delegation were similar to those found to explain AI-related productivity slowdowns (such as high developer familiarity with codebase, large and complex repositories) in an [external study](https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/) from METR. The convergence on these delegation criteria across our interviews suggests that appropriate task choice is an important factor in AI productivity gains (which should be carefully controlled for in future productivity studies).

员工在决定是否委托任务时所提及的上述因素，与 METR 一项[外部研究](https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/)中揭示的导致人工智能相关生产力下降的因素高度吻合（例如：开发者对代码库高度熟悉、代码仓库规模庞大且结构复杂）。我们在多场访谈中观察到这些委托标准的高度一致性，表明“恰当的任务选择”是影响人工智能生产力提升的关键因素之一（未来有关生产力的研究应对此变量予以严格控制）。

#### Trust but verify

#### 信任但需验证

Many users described a progression in their Claude usage that involved delegating increasingly complex tasks over time: “At first I used AI tools with basic questions about Rust programming language... Lately, I've been using Claude Code for all my coding.”

许多用户描述了自己使用 Claude 的演进过程：随时间推移，逐步将越来越复杂的任务交由其处理：“起初我仅用 AI 工具提出一些关于 Rust 编程语言的基础问题……最近，我已开始用 Claude Code 完成全部编码工作。”

One engineer likened the trust progression to adopting other technologies, like Google Maps:

一位工程师将这种信任的演进过程类比为采用其他技术（例如 Google 地图）：

> In the beginning I would use \[Google Maps\] only for routes I didn't know... This is like me using Claude to write SQL that I didn't know, but not asking it to write Python that I did. Then I started using Google Maps on routes that I mostly knew, but maybe I didn't know the last mile... Today I use Google Maps all the time, even for my daily commute. If it says to take a different way I do, and just trust that it considered all options... I use Claude Code in a similar way today.

> 最初，我只在不熟悉路线时才使用［Google 地图］……这就像我让 Claude 编写自己不熟悉的 SQL，却不会让它编写自己已掌握的 Python。随后，我开始在大致熟悉、但可能对最后一段路程存疑的路线上也启用 Google 地图……如今，我随时随地都在使用 Google 地图，甚至包括每日通勤。只要它建议改走另一条路，我就会照做，并且完全信任它已综合权衡所有选项……如今，我对 Claude Code 的使用方式也与此类似。

Engineers are split on whether to use Claude within or outside their expertise. Some use it for “peripheral” domains to save implementation time; others prefer familiar territory where they can verify outputs (“I use Claude in such a way where I still have full understanding of what it’s doing”). A security engineer highlighted the importance of experience when Claude proposed a solution that was “really smart in the dangerous way, the kind of thing a very talented junior engineer might propose”. That is, it was something that could only be recognised as problematic by users with judgment and experience.

工程师们对是否应在自身专业领域内或之外使用 Claude 意见不一。部分人将其用于“边缘性”领域，以节省实现时间；另一些人则更倾向在自己熟悉的领域中使用，以便有效验证输出结果（“我使用 Claude 的方式，是确保自己始终对其所做之事拥有完整理解”）。一位安全工程师特别强调了经验的重要性——当 Claude 提出一个“聪明得危险”的方案时（即“一名极具天赋的初级工程师可能会提出的那种方案”），唯有具备判断力与经验的用户才能识别其中潜在问题。

Other engineers use Claude for both types of tasks, either in an experimental way (“I basically always use Claude to take a first crack at any coding problem”), or by adapting their approach depending on their level of expertise in the task:

另有工程师则将 Claude 同时用于两类任务：或是以实验性方式使用（“我基本总是先让 Claude 尝试解决任何编码问题”），或是根据自身对该任务的专业程度灵活调整使用策略：

> I use the tools for both things that are core to my expertise (as an accelerant, where I know what to expect and can guide the agent effectively), and for things that are slightly outside my area of expertise, where I know roughly what to expect but that Claude is able to fill in the gaps in my memory or familiarity with specific definitions.

> 我既将这些工具用于自身核心专长领域（作为加速器——此时我清楚预期结果，也能高效引导模型），也用于略超出我专业边界的任务（此时我对结果有大致预期，而 Claude 则可弥补我在特定定义或记忆细节上的不足）。

> If it's something that I am particularly versed about, I will be more assertive and tell Claude what it needs to track down. If it's something I'm not sure about I often ask it to be the expert and give me options and insights on things I should consider and research.

> 若是我特别精通的领域，我会更为主动地明确指示 Claude 需要追踪哪些信息；若是我尚不确定的内容，我则常请它担当专家角色，为我提供备选方案及应予考量和研究的洞见。

#### What tasks do people keep for themselves?

#### 哪些任务人们仍坚持亲力亲为？

People consistently said they didn’t use Claude for tasks involving high-level or strategic thinking, or for design decisions that require organizational context or “taste.” One engineer explained: “I usually keep the high-level thinking and design. I delegate anything I can from new feature development to debugging.” This is reflected in our survey data, which showed the least productivity gains for design and planning tasks (Figure 2). Many people described delegation boundaries as a “moving target,” though, regularly renegotiated as models improve (below, the Claude Code usage data shows relatively more coding design/planning usage now than six months ago).

受访者普遍表示，他们不会将涉及高层级或战略性思考的任务，以及需要组织背景或“品位判断”的设计决策交由 Claude 处理。一位工程师解释道：“我通常保留高层级思考与设计工作，而将新功能开发到调试等一切可委托的任务都交出去。” 这一点亦体现在我们的调研数据中：设计与规划类任务带来的生产力提升最小（图 2）。不过，许多人指出，委托边界实为一个“动态目标”，会随模型能力持续提升而定期重新界定（如下所示：Claude Code 的使用数据显示，当前在编码设计/规划方面的使用率，已较六个月前显著上升）。

### Skill transformations

### 技能转变

#### New capabilities…

#### 新能力……

The survey finding that 27% of Claude-assisted work wouldn't have been done otherwise reflects a broader pattern: engineers using AI to work outside their core expertise. Many employees report completing work previously outside their expertise—backend engineers building UIs; researchers creating visualizations. One backend engineer described building a complex UI by iterating with Claude: “It did a way better job than I ever would’ve. I would not have been able to do it, definitely not on time... \[The designers\] were like ‘wait, you did this?’ I said “No, Claude did this - I just prompted it.””

调查显示，27% 的借助 Claude 完成的工作若无 AI 辅助根本不会被开展——这一发现折射出一种更普遍的趋势：工程师正借助 AI 跨越自身核心专业领域开展工作。许多员工表示，他们如今能胜任过去超出自身专长范围的任务——例如后端工程师构建用户界面（UI），研究人员制作数据可视化图表。一位后端工程师描述了自己如何通过与 Claude 迭代协作开发一个复杂 UI：“它完成的效果远超我的能力所及；我根本不可能独立完成，尤其不可能按时交付……（设计师们）惊讶地问：‘等等，这是你做的？’我回答：‘不，是 Claude 做的——我只是给它写了提示词。’”

Engineers report “becoming more full-stack… I can very capably work on front-end, or transactional databases, or API code, where previously I would've been scared to touch stuff I'm less of an expert on.” This capability expansion enables tighter feedback loops and faster learning—one engineer said that a “couple week process” of building, scheduling meetings, and iterating could become “a couple hour working session” with colleagues present for live feedback.

工程师们表示：“我正变得越来越全栈化……我能非常熟练地处理前端、事务型数据库或 API 代码等工作，而过去，我对这些非专长领域的内容往往望而却步。”这种能力边界的拓展，带来了更紧密的反馈闭环和更快的学习节奏——一位工程师指出，过去需要“耗时数周”的开发、会议安排与迭代过程，如今可压缩为“仅需数小时的协作工作坊”，同事全程在场，提供实时反馈。

In general, people were enthused by their new ability to prototype quickly, parallelize work, reduce toil, and generally raise their level of ambition. One senior engineer told us, “The tools are definitely making junior engineers more productive and more bold with the types of projects they will take on.” Some also said that the reduced “activation energy” of using Claude enabled them to defeat procrastination more easily, “dramatically decreas\[ing\] the energy required for me to want to start tackling a problem and therefore I'm willing to tackle so many additional things.”

总体而言，人们对自己新获得的快速原型开发能力、并行处理任务能力、减少重复性劳动（toil）的能力，以及由此整体提升的雄心水平，普遍感到振奋。一位资深工程师告诉我们：“这些工具确实在显著提升初级工程师的生产力，也让他们更有勇气承接各类项目。”还有人提到，使用 Claude 所需的“启动能量”大幅降低，使他们更容易克服拖延症：“这极大地降低了我启动一项任务所需的内在驱动力，因此我愿意主动承担更多额外工作。”

#### …and less hands-on practice

#### ……以及实践动手机会的减少

At the same time, some were worried about “skills atrophying as \[they\] delegate more”, and losing the incidental (or “collateral”) learning that happens during manual problem-solving:

与此同时，一些人担忧“随着越来越多任务交由 AI 代理，自身技能正在退化”，并担心失去在手动解决问题过程中产生的附带（或称“连带”）学习机会：

> If you were to go out and debug a hard issue yourself, you're going to spend time reading docs and code that isn't directly useful for solving your problem—but this entire time you're building a model of how the system works. There's a lot less of that going on because Claude can just get you to the problem right away.

> 假如你亲自去调试一个棘手的问题，你将不得不花时间阅读那些并非直接有助于解决当前问题的文档和代码——但恰恰是在这段过程中，你逐步构建起对整个系统运行机制的理解模型。而如今，这类学习已大幅减少，因为 Claude 可以立刻帮你定位问题所在。

> I used to explore every config to understand what the tool can do but now I rely on AI to tell me how to use new tools and so I lack the expertise. In conversations with other teammates I can instantly recall things vs now I have to ask AI.

> 过去，我会逐一探索每项配置，以彻底理解某个工具的功能边界；如今，我则依赖 AI 告诉我如何使用新工具，结果导致自身专业知识日渐匮乏。过去与团队成员交流时，我能脱口而出各种细节；而现在，我却不得不先去询问 AI。

> Using Claude has the potential to skip the part where I learn how to perform a task by solving an easy instance, and then struggle to solve a more complicated instance later.

> 使用 Claude 可能跳过这样一个关键学习环节：即先通过解决一个简单实例来掌握某项任务的操作方法，再逐步挑战更复杂的同类问题——而后者恰恰是深化理解、巩固技能的必经之路。

One senior engineer said they’d be more worried about their skills if they were more junior:

一位资深工程师表示，如果自己资历更浅，反而会更担心自身技能的退化：

> I’m primarily using AI in cases where I know what the answer should be or should look like. I developed that ability by doing SWE ‘the hard way’... But if I were \[earlier in my career\], I would think it would take a lot of deliberate effort to continue growing my own abilities rather than blindly accepting the model output.

> 我主要在那些我已知答案“应该是什么”或“应该长什么样”的场景中使用 AI。这种判断能力，是通过以“硬核方式”从事软件工程（SWE）锻炼出来的……但倘若我正处于职业生涯早期，我会觉得：要持续提升自身能力，而非盲目接受模型输出，将需要付出大量有意识的努力。

One reason that the atrophy of coding skills is concerning is the “paradox of supervision”—as mentioned above, effectively using Claude requires supervision, and supervising Claude requires the very coding skills that may atrophy from AI overuse. One person said:

导致编程技能退化令人担忧的原因之一，是“监督悖论”（paradox of supervision）——如前所述，高效使用 Claude 需要人工监督；而要有效监督 Claude，恰恰又依赖于那些可能因过度依赖 AI 而退化的编程技能。一位受访者表示：

> Honestly, I worry much more about the oversight and supervision problem than I do about my skill set specifically… having my skills atrophy or fail to develop is primarily gonna be problematic with respect to my ability to safely use AI for the tasks that I care about versus my ability to independently do those tasks.

> 说实话，我更担心的是监督与管控问题，而非我自身的技能组合……技能退化或停滞发展，其主要危害在于：它将削弱我安全地将 AI 应用于我所关注任务的能力，而非削弱我独立完成这些任务的能力。

To combat this, some engineers deliberately practice without AI: "Every once in a while, even if I know that Claude can nail a problem, I will not ask it to. It helps me keep myself sharp.”

为应对这一挑战，一些工程师会刻意脱离 AI 进行练习：“偶尔，即便我知道 Claude 能完美解决某个问题，我也不会去问它。这有助于让我保持思维敏锐。”

#### Will we still need those hands-on coding skills?

#### 我们是否仍需这些动手编码能力？

Perhaps software engineering is moving to higher levels of abstraction, which it has done in the past. Early programmers worked much closer to the machine—manually managing memory, writing in assembly language, or even toggling physical switches to input instructions. Over time, higher-level, more human-readable languages emerged that automatically handled complex, low-level operations. Perhaps, in particular with the rise of “vibe coding”, we’re now moving to English as a programming language. One of our staff suggested that aspiring engineers “get good at having AIs \[write code\], and focus on learning higher level concepts and patterns.”

或许，软件工程正迈向更高层次的抽象——这并非首次：早期程序员的工作离机器更近——手动管理内存、用汇编语言编写程序，甚至通过拨动物理开关来输入指令。随着时间推移，更高级、更贴近人类语言的编程语言相继出现，自动处理原本复杂繁琐的底层操作。尤其随着“氛围编程”（vibe coding）兴起，我们或许正走向以英语本身作为编程语言的新阶段。我们的一位同事建议，有志成为工程师的年轻人应“熟练掌握如何让 AI 编写代码”，并把重心放在学习更高层次的概念与模式上。

A few employees said they felt that this shift empowers them to think at a higher level—“about the end product and the end user” rather than just the code. One person described the current shift by comparing it to previously having to learn linked-lists in computer science—fundamental structures that higher-level programming languages now handle automatically. “I’m very glad I knew how to do that... \[but\] doing those low level operations isn’t particularly important emotionally. I would rather care about what the code allows me to do.” Another engineer made a similar comparison, but noted that abstraction comes at a cost—with the move to higher-level languages, most engineers lost a deep understanding of memory handling.

几位员工表示，他们感到这一转变赋予了自己更高层次的思考能力——即聚焦于“最终产品与终端用户”，而不仅是代码本身。一位受访者将当前的转变类比为过去计算机科学课程中必须学习链表——这类基础数据结构如今已被高级编程语言自动处理。“我很庆幸自己曾掌握过这些知识……但就情感层面而言，执行这些底层操作本身已不那么重要了。我更在意的是：这段代码能让我实现什么。”另一位工程师也做了类似类比，但同时指出：抽象化是有代价的——随着向高级语言迁移，大多数工程师已丧失对内存管理机制的深入理解。

Continuing to develop skills in an area can lead to better supervision of Claude and more efficient work (“I notice that when it's something I'm familiar with, it's often faster for me to do it”). But engineers are divided on whether this matters. Some remain sanguine:

持续深耕某一领域的能力，有助于更有效地监督 Claude，并提升工作效率（“我发现，当我熟悉某项任务时，往往亲自完成反而更快”）。但工程师们对此是否重要尚无共识。部分人依然持乐观态度：

> I don't worry too much about skill erosion. The AI still makes me think through problems carefully and helps me learn new approaches. If anything, being able to explore and test ideas more quickly has accelerated my learning in some areas.

> 我并不太担心技能退化。AI 仍促使我审慎思考问题，并助我学习新的方法。事实上，在某些领域，能够更快地探索与验证想法，反而加速了我的学习进程。

Another was more pragmatic: “I am for sure atrophying in my skills as a software engineer... But those skills could come back if they ever needed to, and I just don't need them anymore!” One noted they only lost less-important skills like making charts, and “the kind of code that's critical I can still write very well.”

另一位工程师则更为务实：“我的软件工程师技能确实在退化……但这些技能一旦需要，随时都能捡回来；而我现在根本用不上它们了！” 一位受访者指出，自己仅丢失了一些相对不那么重要的技能（例如制作图表），而“那些关键性的编码能力，我至今仍能非常娴熟地驾驭。”

Perhaps most interestingly, one engineer challenged the premise: “The ‘getting rusty’ framing relies on an assumption that coding will someday go back to the way it was pre-Claude 3.5. And I don't think it will.”

或许最引人深思的是，一位工程师直接质疑了这一前提：“所谓‘技能生锈’的说法，隐含了一个假设——即编程终将回归 Claude 3.5 发布前的旧有模式。而我认为，这根本不会发生。”

#### The craft and meaning of software engineering

#### 软件工程的技艺本质与职业意义

Engineers diverge sharply on whether they miss hands-on coding. Some feel genuine loss—“It’s the end of an era for me - I've been programming for 25 years, and feeling competent in that skill set is a core part of my professional satisfaction.” Others worry about not enjoying the new nature of the work: “Spending your day prompting Claude is not very fun or fulfilling. It's much more fun and fulfilling to put on some music and get in the zone and implement something yourself.”

工程师们对是否怀念亲自动手写代码一事，观点截然不同。一些人真切地感到失落——“这对我而言是一个时代的终结——我已编程 25 年，而熟练掌握这项技能，始终是我职业满足感的核心来源。” 另一些人则担忧自己无法享受工作的新形态：“整天向 Claude 提示指令，并不有趣，也缺乏成就感；相比之下，戴上耳机、沉浸心流、亲手实现某个功能，才真正令人愉悦且富有意义。”

Some directly addressed the trade-off and accepted it: “There are certainly some parts of \[writing code\] that I miss - getting into a zen flow state when refactoring code, but overall I'm so much more productive now that I'll gladly give that up.”

一些人则直面取舍并坦然接受：“我确实怀念编写代码过程中的某些体验——比如重构代码时进入那种心流般的‘禅定状态’；但总体而言，我如今的工作效率已大幅提升，因此我心甘情愿放弃这部分体验。”

One person said that iterating with Claude has been _more_ fun, because they can be more picky with their feedback than with humans. Others are more interested in outcomes. One engineer said:

一位受访者表示，与 Claude 迭代协作反而更有趣，因为相比人类同事，他们可以对 AI 的输出提出更细致、更挑剔的反馈。另一些人则更关注最终成果。一位工程师说道：

> I expected that by this point I would feel scared or bored… however I don't really feel either of those things. Instead I feel quite excited that I can do significantly more. I thought that I really enjoyed writing code, and instead I actually just enjoy what I get out of writing code.

> 我原本以为，到了这个阶段，自己会感到恐惧或厌倦……但实际上，这两种情绪我都没有。相反，我感到异常兴奋——因为我现在能完成远超以往的工作量。我曾以为自己真心热爱写代码本身，但事实是，我真正享受的，其实是写代码所能带来的成果。

Whether people embrace AI assistance or mourn the loss of hands-on coding seems to depend on what aspects of software engineering they find most meaningful.

人们究竟是欣然接纳 AI 辅助，还是为失去亲自动手编码的机会而感伤，似乎取决于他们认为软件工程中哪些方面最具意义。

### Changing social dynamics in the workplace

### 职场中社会互动模式的转变

One of the more prominent themes was that Claude has become the first stop for questions that once went to colleagues. “I ask way more questions \[now\] in general, but like 80-90% of them go to Claude," one employee noted. This creates a filtering mechanism where Claude handles routine inquiries, leaving colleagues to address more complex, strategic, or context-heavy issues that exceed AI capabilities (“It has reduced my dependence on \[my team\] by 80%, \[but\] the last 20% is crucial and I go and talk to them”). People also “bounce ideas off” Claude, similar to interactions with human collaborators.

一个尤为突出的主题是：Claude 已成为员工提问的第一选择，而这些问题过去通常会直接请教同事。“我现在整体提问次数大幅增加，但其中约 80–90% 都是向 Claude 提出的。”一位员工指出。这形成了一种“过滤机制”：Claude 承担起常规性、重复性问题的解答，从而让同事得以专注于更复杂、更具战略性或高度依赖上下文的议题——而这些恰恰超出了当前 AI 的能力边界（“它使我对于团队的依赖降低了 80%，但剩下的那 20% 至关重要，我仍需主动去找他们沟通”）。此外，人们也会像与人类协作者交流一样，把想法“抛给”Claude 进行初步探讨与验证。

About half reported unchanged team collaboration patterns.  
约一半的工程师表示，团队协作模式没有发生变化。

One engineer said that he was still meeting with people, sharing context, and choosing directions, and that he thought that in the near future there’d still be a lot of collaboration, but “instead of doing your standard focus work, you’ll be talking to a lot of Claudes.”  
一位工程师表示，他仍在与同事会面、共享背景信息并共同确定工作方向；他认为，未来短期内协作仍会非常频繁，但形式将发生变化：“你不再做传统的专注型编码工作，而是要和大量 Claude 进行对话。”

However, others described experiencing less interaction with colleagues (“I work way more with Claude than with any of my colleagues.”)  
然而，另一些人则表示与同事的互动明显减少（“我与 Claude 的协作远多于与任何一位同事的协作。”）

Some appreciate the reduced social friction (“I don't feel bad about taking my colleague’s time”).  
部分人欣赏由此带来的社交摩擦减少（“我不再因占用同事时间而感到愧疚。”）

Others resist the change (“I actually don't love that the common response is ‘have you asked Claude?’ I really enjoy working with people in person and highly value that”) or miss the older way of working: “I like working with people and it is sad that I ‘need’ them less now.”  
也有人对这种转变持抵触态度（“说实话，我并不喜欢现在大家动辄就问‘你问过 Claude 了吗？’——我真的很享受面对面与人协作的过程，也非常珍视这一点”），或怀念过去的工作方式：“我喜欢与人共事，而现在我‘需要’他们变少了，这让我感到失落。”

Several pointed out the impact on traditional mentorship dynamics, because “Claude can provide a lot of coaching to junior staff” instead of senior engineers.  
还有多人指出，这一变化正冲击着传统的师徒制指导关系——因为“Claude 能为初级员工提供大量辅导”，而不再主要依赖资深工程师。

One senior engineer said:  
一位资深工程师表示：

> It's been sad that more junior people don't come to me with questions as often, though they definitely get their questions answered more effectively and learn faster.  
> > 看到越来越多初级同事不再像以前那样常来找我提问，我感到有些难过；尽管他们的确能更高效地获得问题解答，学习速度也更快了。

### Career uncertainty and adaptation  
### 职业不确定性与适应策略

Many engineers describe their role shifting from writing code to managing AIs.  
许多工程师描述自己的角色正从编写代码转向管理 AI。

Engineers increasingly see themselves as “manager[s] of AI agents”—some already “constantly have at least a few [Claude] instances running.”  
工程师们越来越将自己视为“AI 智能体的管理者”——有些人目前已“始终至少运行着几个 Claude 实例”。

One person estimated their work has shifted “70%+ to being a code reviewer/reviser rather than a net-new code writer” and another saw “taking accountability for the work of 1, 5, or 100 Claudes” as part of their future role.  
一位工程师估计，自己当前的工作中“超过 70% 已转变为代码审阅与修订，而非从零开始编写新代码”；另一位则认为，“为 1 个、5 个甚至 100 个 Claude 的工作成果承担责任”将成为自己未来职责的一部分。

In the longer term, career uncertainty is widespread.  
从长期来看，职业不确定性普遍存在。

Engineers saw these changes as harbingers of broader industry transformation, and many said that it was “hard to say” what their careers might look like a few years down the line.  
工程师们将这些变化视为整个行业更广泛转型的先兆；许多人坦言，“很难预测”几年后自己的职业路径会变成什么样。

Some expressed a conflict between short-term optimism and long-term uncertainty. “I feel optimistic in the short term but in the long term I think AI will end up doing everything and make me and many others irrelevant,” one stated.  
一些人表达了短期乐观与长期不确定之间的矛盾。“短期内我持乐观态度，但从长远看，我认为 AI 最终将包揽一切工作，使我本人以及许多同行变得无关紧要。”一位工程师如是说。

Others put a finer point on it: “It kind of feels like I'm coming to work every day to put myself out of a job.”  
另一些人说得更为直白：“每天上班的感觉，就像在亲手把自己送上失业之路。”

Some engineers were more optimistic. One said, “I fear for the junior devs, but I also appreciate that junior devs are maybe the thirstiest for new technology. I feel generally very optimistic about the trajectory of the profession.”  
也有一些工程师更为乐观。一位表示：“我为初级开发者感到担忧，但我也意识到，初级开发者或许恰恰是对新技术最渴求的一群人。总体而言，我对这个职业的发展轨迹抱有非常积极的期待。”

They argued that, while there’s a potential risk of inexperienced engineers shipping problematic code, the combination of better AI guardrails, more built-in educational resources, and natural learning from mistakes will help the field adapt over time.  
他们指出：尽管经验不足的工程师可能因过度依赖 AI 而发布存在问题的代码，但更完善的 AI 安全护栏、更丰富的内嵌学习资源，以及在实践中自然积累的经验教训，将共同推动整个领域逐步完成适应与演进。

We asked how people envision their future roles and whether they have any adaptation strategies.  
我们进一步询问了人们对其未来角色的设想，以及是否制定了相应的适应策略。

Some mentioned plans to specialize further (“developing the skill to meaningfully review AI’s work will take longer and require more specialization”),  
有人提到将进一步深耕专业能力（“掌握真正有意义地审阅 AI 工作成果的技能，将耗时更久，也需更高程度的专业化”）；

some anticipated focusing on more interpersonal and strategic work in the future (“we will spend more time finding consensus and let the AIs spend more time on the implementation”).  
也有人预计未来将更多聚焦于人际协作与战略层面的工作（“我们将花更多时间达成共识，而把实现层面的任务更多交由 AI 完成”）。

One said they use Claude specifically for career development, getting feedback from it on work and leadership skills (“The rate at which I can learn things or even just be effective without fully learning things just completely changed. I almost feel like the ceiling just shattered for me”).  
还有一位工程师表示，他专门使用 Claude 辅助自身职业发展，例如请其就工作表现与领导力技能提供反馈（“我学习新事物的速度，乃至在尚未完全掌握某项技能时即实现高效产出的能力，都发生了彻底改变。我甚至感觉，自己此前的职业天花板已被瞬间击碎。”）

Overall, many acknowledge deep uncertainty: “I have very low confidence in what specific skills I think will be useful in the future.”  
总体而言，许多人坦承自身面临深层的不确定性：“我对未来究竟哪些具体技能会真正有用，几乎毫无把握。”

A team lead said: “Nobody knows what's going to happen… the important thing is to just be really adaptable.”  
一位团队负责人表示：“没人知道未来会发生什么……关键在于保持极强的适应力。”

## Claude Code usage trends  
## Claude Code 使用趋势

The survey and interview data show that increased Claude usage is helping people work faster and take on new types of work, though this comes with tensions around AI delegation and skill development.  
调查与访谈数据显示，Claude 使用量的增加正帮助人们提升工作效率，并承担新型工作任务；但与此同时，围绕人工智能任务委派与技能发展的张力也日益凸显。

Still, self-reported data only tells part of the story. To complement this, we also analyzed actual Claude usage data across Anthropic teams. Because survey respondents reported Claude Code as the majority of their usage, we used our [privacy-preserving analysis tool](https://www.anthropic.com/research/clio) to analyze 200,000 internal transcripts from Claude Code from February and August 2025.  
然而，自我报告的数据仅揭示了部分事实。为弥补这一局限，我们还分析了 Anthropic 各团队真实的 Claude 使用数据。由于受访者在调研中指出，Claude Code 占其整体使用量的主体，我们便借助我们的[隐私保护型分析工具](https://www.anthropic.com/research/clio)，对 2025 年 2 月与 8 月采集的共计 20 万条内部 Claude Code 对话记录进行了分析。

### Tackling harder problems with less oversight  
### 以更少人工监督应对更复杂问题

Claude Code usage has shifted toward more difficult and autonomous coding tasks over the last six months: (Figure 3):  
过去六个月中，Claude Code 的使用重心已明显转向更具挑战性、更高自主性的编码任务（图 3）：

- **Employees are tackling increasingly complex tasks with Claude Code.** We estimated task complexity of each transcript on a 1-5 scale where 1 corresponds to “basic edits” and 5 is “expert-level tasks requiring weeks/months of human expert work”. Task complexity increased from 3.2 to 3.8 on average. To illustrate the difference between the scores: tasks averaging 3.2 included “Troubleshoot Python module import errors” while tasks averaging 3.8 included “Implement and optimize caching systems.”  
- **员工正借助 Claude Code 应对日益复杂的任务。** 我们采用 1–5 分制对每条对话记录的任务复杂度进行评估：1 分代表“基础编辑”，5 分代表“需人类专家投入数周乃至数月方可完成的专家级任务”。平均任务复杂度从 3.2 分上升至 3.8 分。为直观说明分数差异：平均得分为 3.2 的任务包括“排查 Python 模块导入错误”，而平均得分为 3.8 的任务则包括“实现并优化缓存系统”。

- **The maximum number of consecutive tool calls Claude Code makes per transcript increased by 116%.** Tool calls correspond to actions Claude takes using external tools like making edits to files or running commands. Claude now chains together 21.2 independent tool calls without need for human intervention versus 9.8 tool calls from six months ago.  
- **每条对话记录中 Claude Code 连续调用外部工具的最大次数增长了 116%。** “工具调用”指 Claude 借助外部工具执行的操作，例如修改文件或运行命令。当前，Claude 可在无需人工干预的情况下，将 21.2 个独立工具调用串联执行；而六个月前该数值仅为 9.8 次。

- **The number of human turns decreased by 33%.** The average number of human turns decreased from 6.2 to 4.1 per transcript, suggesting that less human input is necessary to accomplish a given task now compared to six months ago.  
- **人工交互轮次数量下降了 33%。** 每条对话记录的平均人工交互轮次由 6.2 轮降至 4.1 轮，表明相较于六个月前，完成同一项任务所需的人工介入已显著减少。

![Figure 3. Changes in Claude Code usage between August 2025 and February 2025 (x-axes). Average task complexity increased over time (left panel), average maximum consecutive tool calls per transcript increased over time (middle panel), and number of human turns decreased over time (right panel). Error bars show 95% confidence intervals. The data suggest people are increasingly delegating more autonomy to Claude over time.](images/how-ai-is-transforming-work-at-anthropic/img_004.jpg)  
![图 3. 2025 年 8 月与 2025 年 2 月间 Claude Code 使用情况的变化（横轴）。左图显示平均任务复杂度随时间推移而上升；中图显示每条对话记录中平均最大连续工具调用次数随时间推移而上升；右图显示人工交互轮次数量随时间推移而下降。误差线表示 95% 置信区间。数据表明，人们正持续将更多自主权委托给 Claude。](images/how-ai-is-transforming-work-at-anthropic/img_004.jpg)  
_Figure 3. Changes in Claude Code usage between August 2025 and February 2025 (x-axes). Average task complexity increased over time (left panel), average maximum consecutive tool calls per transcript increased over time (middle panel), and number of human turns decreased over time (right panel). Error bars show 95% confidence intervals. The data suggest people are increasingly delegating more autonomy to Claude over time._  
_图 3. 2025 年 8 月与 2025 年 2 月间 Claude Code 使用情况的变化（横轴）。左图显示平均任务复杂度随时间推移而上升；中图显示每条对话记录中平均最大连续工具调用次数随时间推移而上升；右图显示人工交互轮次数量随时间推移而下降。误差线表示 95% 置信区间。数据表明，人们正持续将更多自主权委托给 Claude。_

These usage data corroborate the survey data: engineers delegate increasingly complex work to Claude and Claude requires less oversight. It seems plausible that this is driving the observed productivity gains.  
上述使用数据印证了调研结果：工程师正将愈发复杂的任务委派给 Claude，且 Claude 所需的人工监督亦不断减少。这种趋势很可能是推动当前可观测生产力提升的关键动因。

### Distribution of tasks  
### 编码任务类型分布

We classified Claude Code transcripts into one or more types of coding tasks, studying how the uses for different tasks have evolved over the last six months:  
我们将 Claude Code 的对话记录归类为一种或多种编码任务类型，并考察了各类任务在过去六个月中的使用演变趋势：

![Figure 4. Distribution of various coding tasks (y-axis) as a percentage of the overall number of records (x-axis). We compare the distribution 6 months ago (pink) to present day (purple). The y-axis is ordered by frequency in Feb 2025.](images/how-ai-is-transforming-work-at-anthropic/img_005.jpg)  
![图 4. 各类编码任务（纵轴）占全部记录总数的百分比分布（横轴）。我们将六个月前（粉红色）的分布与当前（紫色）分布进行对比。纵轴按 2025 年 2 月的出现频率由高到低排序。](images/how-ai-is-transforming-work-at-anthropic/img_005.jpg)  
_Figure 4. Distribution of various coding tasks (y-axis) as a percentage of the overall number of records (x-axis). We compare the distribution 6 months ago (pink) to present day (purple). The y-axis is ordered by frequency in Feb 2025._  
_图 4. 各类编码任务（纵轴）占全部记录总数的百分比分布（横轴）。我们将六个月前（粉红色）的分布与当前（紫色）分布进行对比。纵轴按 2025 年 2 月的出现频率由高到低排序。_

The overall task frequency distribution estimated from usage data roughly aligns with the self-reported task frequency distribution. The most striking change between February and August 2025 is that there now are proportionately many more transcripts using Claude to implement new features (14.3% → 36.9%) and do code design or planning (1.0% → 9.9%). This shift in the relative distribution of Claude Code tasks may suggest that Claude has become better at these more complex tasks, though it could also reflect changes in how teams adopt Claude Code for different workflows rather than increases in absolute work volume (see Appendix for more limitations).  
基于实际使用数据估算的整体任务频次分布，大致与自我报告的任务频次分布相吻合。2025 年 2 月至 8 月间最显著的变化在于：当前使用 Claude 实现新功能的对话记录占比大幅上升（14.3% → 36.9%），用于代码设计或规划的记录占比亦显著提高（1.0% → 9.9%）。Claude Code 各类任务相对分布的这一转变，可能意味着 Claude 在处理此类更复杂任务方面能力有所增强；但另一方面，这也可能仅反映出各团队在不同工作流中采纳 Claude Code 的方式发生了变化，而非绝对工作量的提升（更多局限性详见附录）。

#### Fixing papercuts

#### 修复“纸割伤”式小问题

We found from the survey that engineers now spend more time making small quality-of-life improvements; in line with this, 8.6% of current Claude Code tasks are classified as “papercut fixes”. These include larger tasks such as creating performance visualization tools and refactoring code for maintainability, as well as smaller tasks like creating terminal shortcuts. This may contribute to engineers’ reported productivity gains (addressing previously neglected quality-of-life improvements may lead to more efficiency over time) and potentially reducing friction and frustration in daily work.

我们通过调研发现，工程师当前正将更多时间投入于各类细微的“生活质量提升”改进；与此一致，目前 8.6% 的 Claude Code 使用任务被归类为“纸割伤式修复”（papercut fixes）。这类任务范围广泛：既包括构建性能可视化工具、为提升可维护性而重构代码等较大型工作，也涵盖创建终端快捷方式等轻量级操作。此类改进可能有助于工程师报告的生产力提升（解决此前被忽视的生活质量类问题，长期来看有望提升整体工作效率），并有望降低日常工作的阻力与挫败感。

#### Task variation across teams

#### 各团队间任务分布差异

To study how tasks currently vary across teams, we refined our classification approach to assign each August transcript to a single primary coding task, and split the data by internal teams (y-axis). The stacked bar chart shows the breakdown of coding tasks for each team:

为探究当前各团队间任务分布的差异，我们优化了任务分类方法，为每条八月份的对话记录标注唯一的主要编码任务，并按内部团队（纵轴）对数据进行切分。下图堆叠柱状图展示了各团队在不同编码任务上的使用占比分布：

![Figure 5. Each horizontal bar represents a team (y-axis) with segments showing the proportion of that team’s Claude Code usage for different coding tasks (x-axis), color-coded by coding task (legend). Top bar (“All Teams”) represents the overall distribution.](images/how-ai-is-transforming-work-at-anthropic/img_006.jpg)_Figure 5. Each horizontal bar represents a team (y-axis) with segments showing the proportion of that team’s Claude Code usage for different coding tasks (x-axis), color-coded by coding task (legend). Top bar (“All Teams”) represents the overall distribution._

![图5：每一条横向柱形代表一个团队（纵轴），其内部色块表示该团队使用 Claude Code 执行各类编码任务的比例（横轴），不同色块对应不同编码任务（图例说明）。顶部柱形（“所有团队”）代表整体分布情况。](images/how-ai-is-transforming-work-at-anthropic/img_006.jpg)_图5：每一条横向柱形代表一个团队（纵轴），其内部色块表示该团队使用 Claude Code 执行各类编码任务的比例（横轴），不同色块对应不同编码任务（图例说明）。顶部柱形（“所有团队”）代表整体分布情况。_

The "All Teams" bar shows the overall distribution, with the most common tasks being building new features, debugging, and code understanding. This provides a baseline for team-specific comparisons.

“所有团队”柱形展示了整体任务分布，其中最常执行的任务依次为：开发新功能、调试（debugging）和代码理解（code understanding）。该分布为各团队间的对比分析提供了基准参照。

Notable team-specific patterns:

值得关注的团队特有模式如下：

1. The **Pre-training** team (who help to train Claude) often uses Claude Code for building new features (54.6%), much of which is running extra experiments.  
1. **预训练团队**（负责协助训练 Claude）高频使用 Claude Code 开发新功能（占比 54.6%），其中大部分工作是运行额外实验。

2. The **Alignment & Safety** and **Post-training** teams do the most front-end development (7.5% and 7.4%) with Claude Code, often for creating data visualizations.  
2. **对齐与安全团队**及**后训练团队**使用 Claude Code 进行前端开发的比例最高（分别为 7.5% 和 7.4%），通常用于构建数据可视化界面。

3. The **Security** team often uses Claude Code for code understanding (48.9%), specifically analyzing and understanding the security implications of different parts of the codebase.  
3. **安全团队**高频使用 Claude Code 进行代码理解（占比 48.9%），尤其聚焦于分析并理解代码库各模块潜在的安全影响。

4. **Non-technical** employees often use Claude Code for debugging (51.5%), such as troubleshooting network issues or Git operations, as well as for data science (12.7%); Claude appears to be valuable for bridging gaps in technical knowledge.  
4. **非技术岗位员工**常借助 Claude Code 进行调试（占比 51.5%），例如排查网络问题或 Git 操作异常；此外亦用于数据科学相关工作（占比 12.7%）。Claude 在弥合技术知识鸿沟方面展现出显著价值。

Many of these team-specific patterns demonstrate the same capability expansion we observed in our survey and interviews: enabling new kinds of work that those on the team either wouldn't have the time or the skillset to do otherwise. For example, the pretraining team ran lots of additional experiments and non-technical employees were able to fix errors in code. And whereas the data suggests that teams do use Claude for their core tasks (for instance, the Infrastructure team most commonly uses Claude Code for infrastructure and DevOps work), Claude often also augments their core tasks (for instance, researchers use Claude for front-end development to better visualize their data). This suggests that Claude is enabling everyone to become more full-stack in their work.

上述诸多团队特有模式，印证了我们在调研与访谈中观察到的同一趋势——能力边界的拓展：Claude 正赋能团队成员开展原本因时间不足或技能所限而无法承担的新类型工作。例如，预训练团队得以运行大量额外实验；非技术员工也能独立修复代码错误。尽管数据显示，各团队确实在核心工作中使用 Claude（例如，基础设施团队最常将 Claude Code 应用于基础设施与 DevOps 相关任务），但 Claude 更常扮演“增强型助手”角色——例如，研究人员利用 Claude 进行前端开发，以更直观地呈现其研究数据。这表明，Claude 正推动每位员工向“全栈化”工作模式演进。

## Looking forward

## 展望未来

Anthropic employees have greatly increased their use of Claude over the past year, using it to not only accelerate existing work but to learn new codebases, reduce toil, expand into new domains, and tackle previously neglected improvements.  

过去一年间，Anthropic 员工对 Claude 的使用显著增加——不仅用它加速现有工作，还借助它学习新的代码库、减少重复性劳动（toil）、拓展至全新技术领域，并推进此前被长期忽视的改进事项。

As Claude becomes more autonomous and capable, engineers are discovering new ways to use AI delegation while also figuring out what skills they’ll need in the future. These shifts bring clear productivity and learning benefits alongside genuine uncertainty about the longer-term trajectory of software engineering work.  

随着 Claude 日益自主化与能力增强，工程师们正不断探索 AI 任务委派（AI delegation）的新方式，同时也开始思考：未来自身需要掌握哪些关键技能？这些转变在显著提升工作效率与学习成效的同时，也带来了关于软件工程工作长期演进路径的真实不确定性。

Will AI resemble past software engineering transitions—from lower- to higher-level programming languages, or from individual contributor to manager, as several engineers suggested? Or will it go further?

正如多位工程师所指出的那样：AI 引发的变革，会类似于过往软件工程领域的转型——例如从低级语言向高级语言演进，或从个人贡献者（individual contributor）转向管理者角色？抑或，它将走得更远？

It’s still early days—Anthropic has many early adopters internally, the landscape is rapidly changing, and our findings likely don’t generalize to other organizations or contexts right now (see Appendix for more limitations). This research reflects that uncertainty: the findings are nuanced, with no single consensus or clear directives emerging. But it does raise questions about how we can thoughtfully and effectively navigate these changes.

目前仍处于早期阶段——Anthropic 内部已有大量先行采用者，技术生态正飞速演变，而我们的研究发现现阶段很可能尚不具备跨组织或跨场景的普适性（更多局限性详见附录）。本研究本身即映射了这种不确定性：结论细致入微，尚未形成统一共识，亦未产生明确的行动指南；但它确实提出了一个关键问题：我们应如何审慎而高效地应对这些变革？

To follow up on this initial work, we’re taking several steps. We're talking to Anthropic engineers, researchers, and leadership to address the opportunities and challenges raised. This includes examining how we bring teams together and collaborate with each other, how we support professional development, and/or how we establish best practices for AI-augmented work (e.g. guided by our [AI fluency framework](https://www.anthropic.com/learn/claude-for-you)). We're also expanding this research beyond engineers to understand how AI transformation affects roles across the organization and supporting external organizations such as CodePath as they adapt computer science curricula for an AI-assisted future. Looking ahead, we're also considering structural approaches that may become increasingly relevant as AI capabilities advance, like new pathways for role evolution or reskilling within the organization.

为持续推进此项初步研究，我们正采取多项举措：  
- 与 Anthropic 的工程师、研究人员及管理层展开深入交流，共同探讨前述机遇与挑战；  
- 具体包括：审视团队如何高效协同与协作、如何支持员工的职业发展，以及如何建立 AI 增强型工作的最佳实践（例如，以我们的 [AI 素养框架（AI fluency framework）](https://www.anthropic.com/learn/claude-for-you) 为指导）；  
- 同时，我们将研究范围从工程师群体拓展至全公司各类岗位，以理解 AI 转型对不同职能角色的影响；并支持外部机构（如 CodePath）调整计算机科学课程体系，使其适配 AI 辅助的未来；  
- 展望未来，我们也在思考若干结构性方案——随着 AI 能力持续跃升，这些方案或将日益重要，例如组织内部角色演进的新路径、系统性再培训（reskilling）机制等。

We expect to share more concrete plans in 2026 as our thinking matures. Anthropic is a laboratory for responsible workplace transition; we want to not just study how AI transforms work, but also experiment with how to navigate that transformation thoughtfully, starting with ourselves first.

我们预计将于 2026 年分享更为具体的实施计划——届时我们的思考将更加成熟。Anthropic 是负责任职场转型的“实验室”；我们不仅致力于研究 AI 如何重塑工作方式，更希望率先躬身入局，亲身实验如何审慎、务实且富有同理心地驾驭这场转型——从自身做起。

#### Bibtex

#### BibTeX 引用格式

If you’d like to cite this post you can use the following Bibtex key:

如需引用本文，请使用以下 BibTeX 条目：

```
@online{huang2025aiwork,
author = {Saffron Huang and Bryan Seethor and Esin Durmus and Kunal Handa and Miles McCain and Michael Stern and Deep Ganguli},
title = {How AI Is Transforming Work at Anthropic},
date = {2025-12-02},
year = {2025},
url = {https://anthropic.com/research/how-ai-is-transforming-work-at-anthropic/},
}
```

Copy

复制

#### Acknowledgments

#### 致谢

Saffron Huang led the project, designed and executed the surveys, interviews, and data analysis, plotted figures and wrote the blog post. Bryan Seethor co-designed the surveys and interviews, co-led survey and interview data collection, analyzed interview themes, contributed to writing, and managed the project timeline. Esin Durmus contributed to experiment design and provided detailed direction and feedback throughout. Kunal Handa contributed infrastructure for the interviewing process. Deep Ganguli provided critical guidance and organizational support. All authors provided detailed guidance and feedback throughout.

Saffron Huang 主导本项目，负责设计并执行问卷调查、深度访谈与数据分析，绘制图表并撰写本文博客。Bryan Seethor 共同设计问卷与访谈提纲，共同牵头开展问卷与访谈数据采集，分析访谈主题，参与文稿撰写，并统筹管理项目时间线。Esin Durmus 参与实验设计，并全程提供详尽的方向性指导与反馈。Kunal Handa 为访谈流程搭建了技术支持基础设施。Deep Ganguli 提供了关键性指导与组织层面的支持。全体作者均在项目全过程提供了细致入微的指导与反馈。

Additionally, we thank Ruth Appel, Sally Aldous, Avital Balwit, Drew Bent, Zoe Blumenfeld, Miriam Chaum, Jack Clark, Jake Eaton, Sarah Heck, Kamya Jagadish, Jen Martinez, Peter McCrory, Jared Mueller, Christopher Nulty, Sasha de Marigny, Sarah Pollack, Hannah Pritchett, Stuart Ritchie, David Saunders, Alex Tamkin, Janel Thamkul, Sar Warner, and Heather Whitney for their helpful ideas, discussion, feedback and support. Thank you to Casey Yamaguma for illustrating the figures. We also appreciate the productive comments and discussion from Anton Korinek, Ioana Marinescu, Silvana Tenreyro, and Neil Thompson.

此外，我们衷心感谢 Ruth Appel、Sally Aldous、Avital Balwit、Drew Bent、Zoe Blumenfeld、Miriam Chaum、Jack Clark、Jake Eaton、Sarah Heck、Kamya Jagadish、Jen Martinez、Peter McCrory、Jared Mueller、Christopher Nulty、Sasha de Marigny、Sarah Pollack、Hannah Pritchett、Stuart Ritchie、David Saunders、Alex Tamkin、Janel Thamkul、Sar Warner 和 Heather Whitney 提供的宝贵建议、深入讨论、建设性反馈与大力支持。特别感谢 Casey Yamaguma 为本文图表所作的插图绘制。我们亦十分感谢 Anton Korinek、Ioana Marinescu、Silvana Tenreyro 和 Neil Thompson 所提出的富有成效的评论与讨论。

## Appendix

## 附录

### Limitations

### 局限性

Our survey findings are subject to several methodological limitations. We selected respondents through both convenience sampling and purposive sampling (to ensure broad organizational representation). We posted the survey across multiple internal Slack channels, yielding 68 responses, and we also selected 20 diverse teams across research and product functions from the organizational chart and directly messaged 5-10 individuals per team (n=207 total outreach), getting a 31% response rate for the final 64 responses. We interviewed the first 53 people who responded. There is likely some selection bias here, as people who are particularly engaged with Claude or have strong opinions (positive or negative) may have been more likely to respond, while those with more neutral experiences may have been underrepresented.

本调查结果存在若干方法论层面的局限性。我们采用便利抽样与目的性抽样相结合的方式选取受访者（以确保组织内各部门的广泛代表性）：一方面，我们在多个内部 Slack 频道发布问卷，共回收 68 份有效回复；另一方面，我们依据组织架构图，从研究与产品职能中遴选了 20 个具有代表性的多样化团队，并向每个团队直接发送消息，联系 5–10 名成员（总计触达 207 人），最终获得 64 份有效回复，响应率为 31%。我们对最先回复的 53 位受访者进行了深度访谈。此处可能存在一定选择偏差——例如，对 Claude 高度投入或持有强烈观点（无论正面或负面）的员工更倾向于参与调研，而体验相对中立的员工则可能被低估。

Additionally, responses may be affected by social desirability bias (since responses were not anonymous and all participants are Anthropic employees, respondents may have inflated positive assessments of Claude's impact) and recency bias (asking participants to recall their productivity and usage patterns from 12 months ago is subject to memory distortion). Furthermore, as discussed, productivity is in general very difficult to estimate, so these self-reports should be taken with a grain of salt. These self-reported perceptions should be interpreted alongside our more objective Claude Code usage data, and future research would benefit from anonymous data collection and more robustly validated measurement instruments.

此外，受访者的回答可能受到社会期许偏差的影响（由于问卷并非匿名填写，且所有参与者均为 Anthropic 员工，受访者可能倾向于高估 Claude 所带来的积极影响），以及近期偏差的影响（要求参与者回忆 12 个月前的工作效率与使用模式，易受记忆失真干扰）。再者，如前所述，工作效率本身即难以准确衡量，因此这些自我报告的数据应谨慎看待。此类主观感知需结合我们更为客观的 Claude Code 使用数据共同解读；未来的研究若能采用匿名数据收集方式，并引入经过更严格效度验证的测量工具，将更具说服力。

Our Claude Code analysis uses proportionate sampling across time periods, which means we can only measure relative changes in task distribution, not absolute changes in work volume. For example, when we report that feature implementation increased from 14% to 37% of Claude Code usage, this does not necessarily indicate that more total feature work is being done.

我们对 Claude Code 的分析采用了跨时间段的比例抽样法，这意味着我们仅能衡量各类任务在总使用量中占比的相对变化，而无法反映实际工作量的绝对变化。例如，当我们指出“功能开发”类任务在 Claude Code 使用量中的占比由 14% 上升至 37%，这并不必然意味着功能开发的总体工作量有所增加。

Finally, this research was conducted in August 2025 when Claude Sonnet 4 and Claude Opus 4 were our state-of-the-art models. Given the rapid pace of AI development, the patterns we observed may have already shifted as newer models become available.

最后，本研究于 2025 年 8 月开展，当时 Claude Sonnet 4 与 Claude Opus 4 是我们最先进的模型。鉴于人工智能技术日新月异的发展速度，随着更新一代模型的陆续推出，我们所观察到的使用模式可能已发生改变。
&#123;% endraw %}
