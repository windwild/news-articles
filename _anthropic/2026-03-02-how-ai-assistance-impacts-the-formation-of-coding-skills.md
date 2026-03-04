---
title: "How AI assistance impacts the formation of coding skills"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/AI-assistance-coding-skills"
scraped_at: "2026-03-02T09:21:18.652503412+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
&#123;% raw %}

Alignment

对齐

# How AI assistance impacts the formation of coding skills

# AI 辅助如何影响编程技能的形成

Jan 29, 2026

2026 年 1 月 29 日

[Read the paper](https://arxiv.org/abs/2601.20245)

[阅读论文](https://arxiv.org/abs/2601.20245)

![How AI assistance impacts the formation of coding skills](images/how-ai-assistance-impacts-the-formation-of-coding-skills/img_001.svg)

![AI 辅助如何影响编程技能的形成](images/how-ai-assistance-impacts-the-formation-of-coding-skills/img_001.svg)

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 熟练度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。

Research shows AI helps people do [parts](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=4945566) of their job faster. In an observational [study](https://www.anthropic.com/research/estimating-productivity-gains) of [Claude.ai](http://claude.ai/redirect/website.v1.027b498d-e1f8-4e85-aef7-b109dbd4c9f4) data, we found AI can speed up some tasks by 80%. But does this increased productivity come with trade-offs? Other research shows that when people use AI assistance, they become [less engaged with their work](https://www.nature.com/articles/s41598-025-98385-2) and [reduce](https://www.microsoft.com/en-us/research/wp-content/uploads/2025/01/lee_2025_ai_critical_thinking_survey.pdf) the effort they put into doing it—in other words, they offload their thinking to AI.

研究表明，AI 能帮助人们更快地完成工作的[某些环节](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=4945566)。在一项针对 [Claude.ai](http://claude.ai/redirect/website.v1.027b498d-e1f8-4e85-aef7-b109dbd4c9f4) 数据开展的观察性[研究](https://www.anthropic.com/research/estimating-productivity-gains)中，我们发现 AI 可将部分任务的完成速度提升达 80%。但这种生产力提升是否伴随权衡取舍？其他研究指出，当人们使用 AI 辅助时，会对其工作[投入程度降低](https://www.nature.com/articles/s41598-025-98385-2)，并[减少](https://www.microsoft.com/en-us/research/wp-content/uploads/2025/01/lee_2025_ai_critical_thinking_survey.pdf)自身在任务执行中所付出的努力——换言之，他们将本应由自己承担的思考过程转嫁给了 AI。

It’s unclear whether this cognitive offloading can prevent people from growing their skills on the job, or—in the case of coding—understanding the systems they’re building. Our latest study, a randomized controlled trial with software developers as participants, investigates this potential downside of using AI at work.

目前尚不清楚，这种认知卸载是否会阻碍人们在工作中提升技能，或——以编程为例——妨碍他们理解自己正在构建的系统。我们最新开展的一项随机对照试验，以软件开发者为参与者，专门探究了职场中使用 AI 可能带来的这一潜在负面影响。

This question has broad implications—for how to design AI products that facilitate learning, for how workplaces should approach AI policies, and for broader societal resilience, among others. We focused on coding, a field where AI tools have rapidly become standard. Here, AI creates a potential tension: as coding grows more automated and speeds up work, humans will still need the skills to catch errors, guide output, and ultimately provide oversight for AI deployed in high-stakes environments. Does AI provide a shortcut to _both_ skill development and increased efficiency? Or do productivity increases from AI assistance undermine skill development?

这一问题具有广泛影响——涉及如何设计有助于学习的 AI 产品、企业应如何制定 AI 使用政策，以及更宏观的社会韧性建设等。我们将研究聚焦于编程领域，这正是 AI 工具已迅速成为行业标配的典型场景。在此背景下，AI 带来了一种潜在张力：尽管编程正变得越来越自动化、工作节奏不断加快，人类仍需掌握识别错误、引导模型输出，并最终对部署于高风险环境中的 AI 系统实施有效监督等关键能力。那么，AI 是否能同时成为技能习得与效率提升的“捷径”？抑或，AI 辅助所带来的生产力提升，反而会侵蚀人的技能发展？

In a randomized controlled trial, we examined 1) how quickly software developers picked up a new skill (in this case, a Python library) with and without AI assistance; and 2) whether using AI made them less likely to understand the code they’d just written.

在一项随机对照试验中，我们考察了：1）软件开发者在有无 AI 辅助条件下，掌握一项新技能（本研究中为一个 Python 库）的速度差异；以及 2）使用 AI 是否降低了他们对自己刚刚编写的代码的理解程度。

We found that using AI assistance led to a statistically significant decrease in mastery. On a quiz that covered concepts they’d used just a few minutes before, participants in the AI group scored 17% lower than those who coded by hand, or the equivalent of nearly two letter grades. Using AI sped up the task slightly, but this didn’t reach the threshold of statistical significance.

研究发现，使用 AI 辅助显著降低了参与者的技能掌握水平。在一场涵盖其几分钟前刚使用过的核心概念的测验中，AI 组参与者的得分比纯手写编码组低 17%，相当于相差近两个字母等级（如从 B+ 降至 C）。虽然使用 AI 确实略微加快了任务完成速度，但该提速效应未达到统计学显著性水平。

Importantly, using AI assistance didn’t guarantee a lower score. _How_ someone used AI influenced how much information they retained. The participants who showed stronger mastery used AI assistance not just to produce code but to build comprehension while doing so—whether by asking follow-up questions, requesting explanations, or posing conceptual questions while coding independently.

尤为重要的是，使用 AI 辅助并不必然导致得分下降。*使用者如何使用 AI*，才真正决定了其知识保留程度。那些展现出更强掌握能力的参与者，并非仅将 AI 视为代码生成器，而是将其作为同步构建理解的工具——例如，在编码过程中主动提出跟进问题、请求原理性解释，或在独立编写代码时提出概念性问题。

## Study design

## 研究设计

We recruited 52 (mostly junior) software engineers, each of whom had been using Python at least once a week for over a year. We also made sure they were at least somewhat familiar with AI coding assistance, and were unfamiliar with Trio, the Python library on which our tasks were based.

我们招募了 52 名（以初级工程师为主）软件工程师，所有人均已持续每周至少使用 Python 一次达一年以上。此外，我们确保每位参与者对 AI 编程辅助工具有一定了解，但均不熟悉本研究任务所基于的 Python 库——Trio。

We split the study into three parts: a warm-up; the main task consisting of coding two different features using Trio (which requires understanding concepts related to asynchronous programming, a skill often learned in a professional setting); and a quiz. We told participants that a quiz would follow the task, but encouraged them to work as quickly as possible.

整个研究分为三个阶段：热身环节；主体任务环节——使用 Trio 编写两个不同功能（该任务要求理解异步编程相关概念，而这类技能通常在职业环境中习得）；以及后续测验。我们事先告知参与者任务后将进行测验，但同时鼓励他们尽可能快速完成任务。

We designed the coding task to mimic how someone might learn a new tool through a self-guided tutorial. Each participant was given a problem description, starter code, and a brief explanation of the Trio concepts needed to solve it. We used an online coding platform with an AI assistant in the sidebar which had access to participants’ code and could at any time produce the correct code if asked.¹

我们设计的编程任务模拟了人们通过自助式教程学习新工具的过程。每位参与者均获得一份问题描述、一段起始代码，以及一段关于解决该问题所需 Trio 概念的简要说明。我们采用了一个在线编程平台，其侧边栏集成了一款 AI 助手；该助手可实时访问参与者的代码，并可在被请求时随时生成正确代码。¹

![](images/how-ai-assistance-impacts-the-formation-of-coding-skills/img_002.jpg)

### Evaluation design

### 评估设计

In our evaluation design, we drew on [research in computer science education](https://ieeexplore.ieee.org/document/9962584) to identify four types of questions commonly used to assess mastery of coding skills:

在我们的评估设计中，我们借鉴了[计算机科学教育领域的研究](https://ieeexplore.ieee.org/document/9962584)，归纳出四类常用于评估编程技能掌握程度的问题：

- **Debugging**: The ability to identify and diagnose errors in code. This skill is crucial for detecting when AI-generated code is incorrect and understanding why it fails.  
- **调试能力（Debugging）**：识别并诊断代码中错误的能力。这一能力对于发现 AI 生成代码中的错误、并理解其失败原因至关重要。

- **Code reading**: The ability to read and comprehend what code does. This skill enables humans to understand and verify AI-written code before deployment.  
- **代码阅读能力（Code reading）**：阅读并理解代码功能的能力。该能力使人类能够在部署前充分理解并验证 AI 编写的代码。

- **Code writing:** The ability to write or select the correct approach to writing code. Low-level code writing, like remembering the syntax of functions, will be less important with the further integration of AI coding tools than high-level system design.  
- **代码编写能力（Code writing）**：编写代码或选择恰当编码方法的能力。随着 AI 编程工具的进一步普及，低层次的代码编写（例如记忆函数语法）将变得不那么重要，而高层次的系统设计则更为关键。

- **Conceptual**: The ability to understand the core principles behind tools and libraries. Conceptual understanding is critical for assessing whether AI-generated code uses appropriate software design patterns that adhere to how the library is intended to be used.  
- **概念性理解能力（Conceptual）**：理解工具与库背后核心原理的能力。这种概念性理解对于判断 AI 生成的代码是否采用了恰当的软件设计模式、是否符合该库的预期使用方式，具有决定性意义。

Our assessment focused most heavily on debugging, code reading, and conceptual problems, as we considered these the most important for providing oversight of what is increasingly likely to be AI-generated code.

我们的评估重点聚焦于调试、代码阅读和概念性问题，因为我们认为这三类能力对于监督日益由 AI 生成的代码而言最为关键。

## Results

## 结果

On average, participants in the AI group finished about two minutes faster, although the difference was not statistically significant. There was, however, a significant difference in test scores: the AI group averaged 50% on the quiz, compared to 67% in the hand-coding group—or the equivalent of nearly two letter grades (Cohen's _d_ = 0.738, _p_ = 0.01). The largest gap in scores between the two groups was on debugging questions, suggesting that the ability to understand when code is incorrect and why it fails may be a particular area of concern if AI impedes coding development.

AI 组参与者平均完成时间快约两分钟，但该差异未达到统计显著性水平。然而，两组在测验成绩上存在显著差异：AI 组平均得分为 50%，而手写代码组为 67%——相当于相差近两个字母等级（Cohen’s _d_ = 0.738，_p_ = 0.01）。两组得分差距最大的题型是调试类题目，这表明：若 AI 的使用阻碍了编程能力的发展，那么“识别代码错误及其成因”的能力可能成为尤为值得担忧的薄弱环节。

![](images/how-ai-assistance-impacts-the-formation-of-coding-skills/img_003.jpg)

### Qualitative analysis: AI interaction modes

### 定性分析：AI 交互模式

We were particularly interested in understanding _how_ participants went about completing the tasks we designed. In our qualitative analysis, we manually annotated screen recordings to identify how much time participants spent composing queries, what types of questions they asked, the types of errors they made, and how much time they spent actively coding.

我们尤其关注参与者**如何**完成我们所设计的任务。在定性分析中，我们通过人工标注屏幕录制视频，识别出参与者在构造查询（prompt）上花费的时间、所提问题的类型、所犯错误的类型，以及实际进行编码的时间。

One surprising result was how much time participants spent interacting with the AI assistant. Several took up to 11 minutes (30% of the total time allotted) composing up to 15 queries. This helped to explain why, on average, participants using AI finished faster although the productivity improvement was not statistically significant. We expect AI would be more likely to significantly increase productivity when used on repetitive or familiar tasks.

一个出人意料的发现是：参与者与 AI 助理互动所耗费的时间之长。部分参与者花费多达 11 分钟（占总时长的 30%）来构造最多 15 条查询。这有助于解释为何使用 AI 的参与者平均完成更快，但生产率提升却未达统计显著性。我们预计，当 AI 应用于重复性或熟悉度较高的任务时，更有可能带来显著的生产力提升。

Unsurprisingly, participants in the No AI group encountered more errors. These included errors in syntax and in Trio concepts, the latter of which mapped directly to topics tested on the evaluation. Our hypothesis is that the participants who encountered more Trio errors (namely, the control group) likely improved their debugging skills through resolving these errors independently.

不出所料，未使用 AI 的参与者遇到了更多错误。这些错误包括语法错误以及 Trio 概念性错误，后者直接对应于评估中所测试的知识点。我们假设，遇到更多 Trio 错误的参与者（即对照组）很可能通过独立解决这些错误而提升了自身的调试能力。

We then grouped participants by how they interacted with AI, identifying distinct patterns that led to different outcomes in completion time and learning.

随后，我们依据参与者与 AI 的互动方式对其分组，识别出若干具有明显差异的互动模式，这些模式在任务完成时间和学习效果上产生了不同结果。

**Low-scoring interaction patterns**: The low-scoring patterns generally involved a heavy reliance on AI, either through code generation or debugging. The average quiz scores in this group were less than 40%. They showed less independent thinking and more cognitive offloading. We further separated them into:

**低分互动模式**：低分模式普遍表现为对 AI 的高度依赖，主要体现在代码生成或调试环节。该组参与者的平均测验得分低于 40%。他们表现出较弱的独立思考能力，更多地将认知负担转移给 AI。我们进一步将其细分为以下三类：

- **AI delegation** ( _n_ =4): Participants in this group wholly relied on AI to write code and complete the task. They completed the task the fastest and encountered few or no errors in the process.  
- **AI 代劳型**（*n* = 4）：该组参与者完全依赖 AI 编写代码并完成任务。他们完成任务的速度最快，过程中几乎未遇到任何错误。

- **Progressive AI reliance** ( _n_ =4): Participants in this group started by asking one or two questions but eventually delegated all code writing to the AI assistant. They scored poorly on the quiz largely due to not mastering any of the concepts on the second task.  
- **渐进式 AI 依赖型**（*n* = 4）：该组参与者起初仅向 AI 提出一两个问题，但最终将全部代码编写工作交由 AI 助理完成。他们在测验中得分偏低，主要原因在于未能掌握第二项任务所涉及的任何核心概念。

- **Iterative AI debugging** ( _n_ =4): Participants in this group relied on AI to debug or verify their code. They asked more questions, but relied on the assistant to solve problems, rather than to clarify their own understanding. They scored poorly as a result, and were also slower at completing the two tasks.  
- **迭代式 AI 调试型**（*n* = 4）：该组参与者依赖 AI 进行代码调试或验证。他们提问次数较多，但其目的主要是让助手替自己解决问题，而非借此澄清自身理解。因此，他们测验成绩较差，且完成两项任务的速度也更慢。

**High-scoring interaction patterns:** We considered high-scoring quiz patterns to be behaviors where the average quiz score was 65% or higher. Participants in these clusters used AI both for code generation and conceptual queries.

**高分互动模式**：我们将平均测验得分达 65% 或更高的行为模式定义为高分模式。这些组别的参与者既利用 AI 生成代码，也借助 AI 提出概念性问题。

- **Generation-then-comprehension** ( _n_ =2): Participants in this group first generated code and then manually copied or pasted the code into their work. After their code was generated, they asked the AI assistant follow-up questions to improve understanding. These participants were not particularly fast when using AI, but showed a higher level of understanding on the quiz. Interestingly, this approach looked nearly the same as that of the AI delegation group, except for the fact that they used AI to check their own understanding.  
- **先生成、后理解型**（*n* = 2）：该组参与者首先生成代码，再手动复制或粘贴至自己的项目中；代码生成完成后，他们会向 AI 助理提出后续问题以深化理解。这些参与者使用 AI 并不特别高效，但在测验中展现出更高水平的理解力。有趣的是，这种做法在表象上与“AI 代劳型”极为相似，区别仅在于他们使用 AI 的目的是检验和巩固自身理解，而非替代自身思考。

- **Hybrid code-explanation** ( _n_ =3): Participants in this group composed hybrid queries in which they asked for code generation along with explanations of the generated code. Reading and understanding the explanations they asked for took more time, but helped in their comprehension.  
- **代码-解释混合型**（*n* = 3）：该组参与者提出混合式查询，即在请求生成代码的同时，也要求提供相应代码的解释说明。阅读并理解这些解释耗时更长，却显著促进了他们的知识内化。

- **Conceptual inquiry** ( _n_ =7): Participants in this group only asked conceptual questions and relied on their improved understanding to complete the task. Although this group encountered many errors, they also independently resolved them. On average, this mode was the fastest among high-scoring patterns and second fastest overall, after AI delegation.  
- **概念探究型**（*n* = 7）：该组参与者仅提出概念性问题，并依靠自身提升后的理解力完成任务。尽管他们遭遇了大量错误，但也全部独立解决了这些问题。平均而言，该模式是所有高分模式中最快的，整体速度则仅次于“AI 代劳型”，位居第二。

Our qualitative analysis does not draw a causal link between interaction patterns and learning outcomes, but it does point to behaviors associated with different learning outcomes.

我们的定性分析并未确立互动模式与学习成效之间的因果关系，但它确实揭示了与不同学习成效相关联的具体行为特征。

## Conclusion

## 结论

Our results suggest that incorporating AI aggressively into the workplace, particularly with respect to software engineering, comes with trade-offs. The findings highlight that not all AI-reliance is the same: the way we interact with AI while trying to be efficient affects how much we learn. Given time constraints and organizational pressures, junior developers or other professionals may rely on AI to complete tasks as fast as possible at the cost of skill development—and notably the ability to debug issues when something goes wrong.

我们的研究结果表明，在职场（尤其是软件工程领域）激进地引入 AI 带来的是权衡取舍。研究发现强调：并非所有形式的 AI 依赖都是等价的——我们在追求效率的同时与 AI 互动的方式，深刻影响着我们所能获得的学习成效。在时间压力与组织绩效要求下，初级开发者或其他专业人士可能倾向于依赖 AI 尽快完成任务，却以牺牲技能发展为代价；尤为值得关注的是，当系统出现异常时，他们可能丧失独立排查与修复问题的能力。

Though preliminary, these results suggest important considerations as companies transition to a greater ratio of AI-written to human-written code. Productivity benefits may come at the cost of skills necessary to validate AI-written code if junior engineers’ skill development has been stunted by using AI in the first place. Managers should think intentionally about how to deploy AI tools at scale, and consider systems or intentional design choices that ensure engineers continue to learn as they work—and are thus able to exercise meaningful oversight over the systems they build.

尽管尚属初步结论，这些结果已为企业在向“AI 生成代码占比持续提升”的转型过程中，提出了亟需重视的关键考量。若初级工程师因过早、过度依赖 AI 而导致技能成长受阻，则伴随生产力提升而来的，可能是验证 AI 生成代码所必需的核心能力的缺失。管理者应审慎规划 AI 工具的大规模部署策略，并主动设计配套机制或制度安排，确保工程师在日常工作中持续学习成长——唯有如此，他们才能真正胜任其所构建系统的实质性监督职责。

For novice workers in software engineering or any other industry, our study can be viewed as a small piece of evidence toward the value of intentional skill development with AI tools. Cognitive effort—and even getting painfully stuck—is likely important for fostering mastery. This is also a lesson that applies to how individuals choose to work with AI, and which tools they use. Major LLM services also provide learning modes (e.g., [Claude Code Learning and Explanatory](https://code.claude.com/docs/en/output-styles) mode or [ChatGPT Study Mode](https://openai.com/index/chatgpt-study-mode/)) designed to foster understanding. Knowing how people learn when using AI can also help guide how we design it; AI assistance should enable humans to work more efficiently _and_ develop new skills at the same time.

对于软件工程或其他行业的新手从业者而言，本研究可视为支持“有意识地借助 AI 工具开展技能培养”这一理念的一小块实证依据。认知投入——甚至经历令人痛苦的卡壳过程——很可能是促进精熟掌握的关键因素。这一洞见同样适用于个体如何选择与 AI 协作、以及选用哪些工具。主流大语言模型（LLM）服务也提供了专门面向学习的设计模式（例如 [Claude Code 学习与解释模式](https://code.claude.com/docs/en/output-styles)，或 [ChatGPT 学习模式](https://openai.com/index/chatgpt-study-mode/)），旨在促进深度理解。了解人们在使用 AI 过程中的学习机制，亦有助于指导 AI 的设计方向：AI 辅助应既能提升人类的工作效率，又能同步支持新技能的发展。

Prior studies have found mixed results on whether AI [helps](https://arxiv.org/abs/2302.06590) or [hinders](https://arxiv.org/abs/2507.09089) coding productivity. Our own [research](https://www.anthropic.com/research/estimating-productivity-gains) found that AI can reduce the time it takes to complete some work tasks by 80%—a result that may seem in tension with the findings presented here. But the two studies ask different questions and use different methods: our earlier observational work measured productivity on tasks where participants already had the relevant skills, while this study examines what happens when people are learning something new. It is possible that AI both accelerates productivity on well-developed skills and hinders the acquisition of new ones, though more research is needed to understand this relationship.

此前的研究对 AI 究竟[提升](https://arxiv.org/abs/2302.06590)还是[阻碍](https://arxiv.org/abs/2507.09089)编程生产力得出了不一致的结论。我们此前的[研究](https://www.anthropic.com/research/estimating-productivity-gains)发现，AI 可将部分工作任务的完成时间缩短达 80%——这一结果看似与本文呈现的发现存在张力。但这两项研究关注的问题不同、采用的方法也不同：此前的观察性研究测量的是参与者已具备相关技能的任务上的生产力；而本研究则聚焦于人们学习全新知识时所发生的变化。AI 或许既能在已有熟练技能上加速生产力提升，又可能妨碍新技能的习得——不过，要厘清这种双重效应的具体机制，仍需更多研究予以验证。

This study is only a first step towards uncovering how human-AI collaboration affects the experience of workers. Our sample was relatively small, and our assessment measured comprehension shortly after the coding task. Whether immediate quiz performance predicts longer-term skill development is an important question this study does not resolve. There remain many unanswered questions we hope future studies will investigate, for example the effects of AI on tasks beyond coding, whether this effect dissipates longitudinally as engineers develop greater fluency, and whether AI assistance differs from human assistance while learning.

本研究仅是探索人机协作如何影响从业者工作体验的第一步。我们的样本量相对较小，且评估是在编码任务完成后不久即刻进行的理解度测试。即时测验表现能否预测长期技能发展，是一个本研究尚未解答的重要问题。此外，尚有许多悬而未决的问题亟待未来研究深入探讨，例如：AI 对非编程类任务的影响；随着工程师熟练度持续提升，上述效应是否会随时间推移而减弱；以及在学习过程中，AI 辅助与人类辅助是否存在本质差异。

Ultimately, to accommodate skill development in the presence of AI, we need a more expansive view of the impacts of AI on workers. In an AI-augmented workplace, productivity gains matter, but so does the long-term development of the expertise those gains depend on.

最终，若要在 AI 普及的背景下切实支持技能成长，我们必须以更广阔的视角审视 AI 对从业者产生的综合影响。在 AI 增强型工作场所中，生产力提升固然重要，但支撑这些提升所依赖的专业能力的长期发展，同样至关重要。

Read the [full paper](https://arxiv.org/abs/2601.20245) for details.

详情请参阅[完整论文](https://arxiv.org/abs/2601.20245)。

### Acknowledgments

### 致谢

This project was led by Judy Hanwen Shen and Alex Tamkin. Editorial support for this blog post was provided by Jake Eaton, Stuart Ritchie, and Sarah Pollack.

本项目由 Judy Hanwen Shen 和 Alex Tamkin 主导。本篇博客文章的编辑支持由 Jake Eaton、Stuart Ritchie 与 Sarah Pollack 提供。

We would like to thank Ethan Perez, Miranda Zhang, and Henry Sleight for making this project possible through the Anthropic Safety Fellows Program. We would also like to thank Matthew Jörke, Juliette Woodrow, Sarah Wu, Elizabeth Childs, Roshni Sahoo, Nate Rush, Julian Michael, and Rose Wang for experimental design feedback.

我们衷心感谢 Ethan Perez、Miranda Zhang 与 Henry Sleight 通过 Anthropic 安全研究员计划（Anthropic Safety Fellows Program）使本项目得以开展。同时，我们也要感谢 Matthew Jörke、Juliette Woodrow、Sarah Wu、Elizabeth Childs、Roshni Sahoo、Nate Rush、Julian Michael 与 Rose Wang 在实验设计方面提供的宝贵反馈。

```
@misc{aiskillformation2026,
  author = {Shen, Judy Hanwen and Tamkin, Alex},
  title = {How AI Impacts Skill Formation},
  year = {2026},
  eprint = {2601.20245},
  archivePrefix = {arXiv},
  primaryClass = {cs.LG},
  eprinttype = {arxiv}
}
```

```  
@misc{aiskillformation2026,  
  author = {Shen, Judy Hanwen 和 Tamkin, Alex},  
  title = {AI 如何影响技能形成},  
  year = {2026},  
  eprint = {2601.20245},  
  archivePrefix = {arXiv},  
  primaryClass = {cs.LG},  
  eprinttype = {arxiv}  
}  
```

### Footnotes

### 脚注

1. Importantly, this setup is different from agentic coding products like Claude Code; we expect that the impacts of such programs on skill development are likely to be more pronounced than the results here.

1. 重要的是，这种设置不同于 Claude Code 等具备自主代理能力的编程产品；我们预计，此类程序对技能发展的影响可能比本研究的结果更为显著。
&#123;% endraw %}
