---
title: "Anthropic Education Report: The AI Fluency Index"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/AI-fluency-index"
scraped_at: "2026-03-02T09:21:16.646480348+00:00"
language: "en-zh"
translated: true
description: "Anthropic's AI Fluency Index measures 11 observable behaviors across thousands of Claude.ai conversations to understand how people develop AI collaboration skills."
tags: ["Announcements"]
---
{% raw %}

Announcements

公告

# Anthropic Education Report: The AI Fluency Index

# Anthropic 教育报告：AI 熟练度指数

Feb 23, 2026

2026 年 2 月 23 日

![Anthropic Education Report: The AI Fluency Index](images/anthropic-education-report-the-ai-fluency-index/img_001.svg)

![Anthropic 教育报告：AI 熟练度指数](images/anthropic-education-report-the-ai-fluency-index/img_001.svg)

#### Footnotes

#### 脚注

1 When researching how people use AI models, protecting user privacy is paramount. For this project, we used our [privacy-preserving analysis tool](https://www.anthropic.com/research/clio), which enables bottom-up discovery of AI usage patterns by distilling user conversations into high-level usage summaries, such as “troubleshoot code” or “explain economic concepts.” For this analysis, we ran 11 separate binary classifiers (one per behavioral indicator) using Claude Sonnet 4 for behavioral classification and Claude Haiku 3.5 for language detection. This means a single conversation could indicate multiple AI fluency behavioral indicators. Conversations were filtered to substantive exchanges with multiple back-and-forths using a screener that excluded greetings, single-word exchanges, test messages, and pure chitchat. Manual review of 200 chats that were screened out indicated that chats of this nature did not qualify for any AI Fluency indicators, so we feel confident that the screener did not influence the relative rankings of AI fluency behaviors observed in the study. No personally identifiable information appears in the analysis.

1 在研究人们如何使用 AI 模型时，保护用户隐私至关重要。本项目中，我们采用了我们的[隐私保护分析工具](https://www.anthropic.com/research/clio)，该工具通过对用户对话进行提炼，生成高层次的使用摘要（例如“调试代码”或“解释经济学概念”），从而实现自下而上地发现 AI 使用模式。在本次分析中，我们运行了 11 个独立的二元分类器（每个行为指标对应一个），其中行为分类采用 Claude Sonnet 4，语言检测则采用 Claude Haiku 3.5。这意味着单次对话可能同时体现多个 AI 熟练度行为指标。对话经筛选后仅保留具有实质内容、包含多次来回交互的交流；筛选器排除了问候语、单字回复、测试消息及纯闲聊内容。我们人工复核了 200 条被筛除的聊天记录，结果表明此类对话均不符合任何 AI 熟练度指标的判定标准。因此，我们有充分信心认为，该筛选机制并未影响本研究中所观察到的 AI 熟练度行为的相对排序。分析中未出现任何个人身份可识别信息（PII）。

2 Behavioral indicators were calculated across a one-week sample (January 20–26, 2025) and held stable day-to-day, with most behaviors varying by only 1–5 percentage points. Saturday rates were slightly lower for some behaviors (e.g., iteration and refinement was 81.4% for Saturday compared to a weekday peak of 87.9%), suggesting modest differences in casual versus purposeful use, but no day showed meaningful structural deviation. Rates were also consistent across six languages (English, French, Spanish, Chinese, Japanese, and German), with most behaviors varying by 3 percentage points or fewer across language groups. Together, these findings suggest that the behavioral patterns captured here reflect consistent habits in how people engage with AI, rather than being artifacts of timing, day of week, or linguistic and cultural context.

2 行为指标基于为期一周的样本（2025 年 1 月 20 日至 26 日）计算得出，日间波动稳定，大多数行为指标的日变化幅度仅为 1–5 个百分点。部分行为在周六的发生率略低（例如，“迭代与优化”行为在周六为 81.4%，而工作日峰值达 87.9%），这暗示休闲性使用与目标导向型使用之间存在细微差异；但没有任何一天呈现出显著的结构性偏离。此外，六种语言（英语、法语、西班牙语、中文、日语和德语）下的指标也保持高度一致，多数行为在不同语种群体间的差异不超过 3 个百分点。综上所述，这些发现表明，本报告所捕捉到的行为模式真实反映了人们与 AI 互动的稳定习惯，而非受时间点、星期几或语言文化背景等外部因素干扰所产生的偶然结果。

People are integrating AI tools into their daily routines at a pace that would have been difficult to predict even a year ago. But adoption alone doesn’t tell us much about the impact of these tools. **A further, equally important question is: as AI becomes part of everyday life, are individuals developing the skills to use it well?**

人们正以一种甚至在一年前都难以预料的速度，将 AI 工具融入日常生活中。但仅看采用率，并不能充分反映这些工具的实际影响。**另一个同样重要、且亟待回答的问题是：当 AI 日益成为日常生活的一部分时，个体是否正在发展出善用它的能力？**

Previous Anthropic Education Reports have studied how [university students](https://www.anthropic.com/news/anthropic-education-report-how-university-students-use-claude) and [educators](https://www.anthropic.com/news/anthropic-education-report-how-educators-use-claude) use Claude. We found that students use it to create reports and analyze lab results; educators use it to build lesson materials and automate routine work. But we know that _any_ person who uses AI is likely to improve at what they do. We wanted to explore this further, and to understand how people using AI develop “fluency” with this technology over time.

此前，Anthropic 教育系列报告已分别研究了[大学生](https://www.anthropic.com/news/anthropic-education-report-how-university-students-use-claude)和[教育工作者](https://www.anthropic.com/news/anthropic-education-report-how-educators-use-claude)如何使用 Claude。我们发现，学生用它撰写报告、分析实验结果；教育工作者则用它开发教学材料、自动化常规任务。但我们深知：**任何使用 AI 的人，其相关能力都可能随之提升。** 为此，我们希望进一步探究这一现象，理解人们在长期使用 AI 的过程中，如何逐步发展出对这项技术的“熟练度”（fluency）。

In this report, we begin answering that question. We track the presence or absence of a taxonomy of behaviors that we take to represent AI fluency across a large sample of anonymized conversations.

本报告即是对该问题的初步回应。我们基于大量匿名对话样本，追踪一组被我们视为“AI 熟练度”表征的行为分类体系（taxonomy）的出现或缺失情况。

In line with our recent [Economic Index](https://www.anthropic.com/research/economic-index-primitives), we find that the most common expression of AI fluency is _augmentative_—treating AI as a thought partner, rather than delegating work entirely. In fact, these conversations exhibit more than double the number of AI fluency behaviors than quick, back-and-forth chats.

与我们近期发布的[经济指数](https://www.anthropic.com/research/economic-index-primitives)一致，我们发现：AI 熟练度最普遍的表现形式是**增强式（augmentative）**——即将 AI 视为思维伙伴，而非全盘委托任务。事实上，此类对话中所展现的 AI 熟练度行为数量，是简短、来回式聊天的两倍以上。

But we also find that when AI produces artifacts—including apps, code, documents, or interactive tools—users are _less_ likely to question its reasoning (-3.1 percentage points) or identify missing context (-5.2pp). This aligns with related patterns we observed in our [recent study on coding skills](https://www.anthropic.com/research/AI-assistance-coding-skills).

但我们同时也发现：当 AI 生成具体产出物（如应用程序、代码、文档或交互式工具）时，用户质疑其推理过程的可能性降低（-3.1 个百分点），识别上下文缺失的可能性也更低（-5.2 个百分点）。这一现象与我们在[近期编程技能研究报告](https://www.anthropic.com/research/AI-assistance-coding-skills)中观察到的相关模式相吻合。

These initial findings present us with a baseline that we can use to study the development of AI fluency over time.

这些初步发现为我们提供了衡量 AI 熟练度随时间演进的基准线。

## **Measuring AI fluency**

## **衡量 AI 熟练度**

To quantify AI fluency, we use the [4D AI Fluency Framework](https://anthropic.skilljar.com/ai-fluency-framework-foundations), developed by Professors Rick Dakan and Joseph Feller in collaboration with Anthropic. This framework helps us define 24 specific behaviors that we take to exemplify safe and effective human-AI collaboration.

为量化 AI 熟练度，我们采用由 Rick Dakan 教授与 Joseph Feller 教授联合 Anthropic 共同开发的[4D AI 熟练度框架](https://anthropic.skilljar.com/ai-fluency-framework-foundations)。该框架帮助我们界定 24 种具体行为，用以体现安全、高效的人机协作。

Of these 24 behaviors, 11 (listed in the graph below) are directly observable when humans interact with Claude on Claude.ai or Claude Code. The other 13 (including things like being honest about AI’s role in work, or considering the consequences of sharing AI-generated output), happen outside Claude.ai’s chat interface, so they’re much harder for us to track. These unobservable behaviors are arguably some of the most consequential dimensions of AI fluency, so in future work we plan to use qualitative methods to assess them.

在这 24 种行为中，有 11 种（如下图所列）可在人类于 Claude.ai 或 Claude Code 平台与 Claude 交互时被直接观察到；其余 13 种（例如：如实说明 AI 在工作中的角色，或审慎评估分享 AI 生成内容可能带来的后果）则发生于 Claude.ai 聊天界面之外，因而更难被我们追踪。这些不可观测的行为，恰恰可能是 AI 熟练度中最具实质影响的维度；因此，在后续研究中，我们将计划采用定性方法对其展开评估。

For this study, we focused on the 11 directly observable behaviors. We used our [privacy-preserving analysis tool](https://www.anthropic.com/research/clio) to study 9,830 conversations that included several back-and-forths with Claude on Claude.ai during a 7-day window in January 2026.¹ We then measured the presence or absence of the 11 behaviors; each conversation could display evidence of multiple behaviors. We assessed the reliability of our sample by checking whether our results were consistent across each day of the week, and across the different languages in our sample (we found that they were).² This, finally, gave us the AI Fluency Index: a baseline measurement of how people collaborate with AI today, and a foundation for tracking how those behaviors evolve over time as models change.

本研究聚焦于11种可直接观察的行为。我们使用[隐私保护分析工具](https://www.anthropic.com/research/clio)，对2026年1月某连续7天窗口期内发生在Claude.ai平台上的9,830次对话进行了分析——这些对话均包含用户与Claude之间多次往复交互。¹ 随后，我们逐一检测这11种行为在每场对话中是否出现；单场对话可能同时呈现多种行为特征。为评估样本的可靠性，我们检验了结果在一周七天内是否保持一致，以及在样本所涵盖的不同语言群体中是否具有一致性（结果证实二者均成立）。² 最终，我们由此构建出“AI素养指数”（AI Fluency Index）：它既是对当下人类与AI协作方式的一项基线测量，也为未来持续追踪此类行为随模型演进而发生的变化奠定了基础。

![](images/anthropic-education-report-the-ai-fluency-index/img_002.jpg)_Prevalence of each AI fluency behavioral indicator across 9,830 Claude.ai conversations, ranked from most to least common and color-coded by competency._

![](images/anthropic-education-report-the-ai-fluency-index/img_002.jpg)_9,830场Claude.ai对话中各项AI素养行为指标的出现频率，按从高到低排序，并依所属能力维度以颜色编码。_

## **Results**

## **研究结果**

With our first study, we’ve found two main patterns in Claude use: a strong relationship between AI fluency and iteration and refinement through longer conversations with Claude, and changes in users’ fluency behaviors when coding or building other outputs.

通过本次初步研究，我们发现了Claude使用过程中的两大核心模式：其一，AI素养水平与用户通过更长对话持续迭代、精炼提示之间存在显著正相关；其二，当用户进行编程或构建其他产出物时，其AI素养相关行为模式会发生明显变化。

### **Fluency is strongly associated with conversations that exhibit iteration and refinement**

### **AI素养水平与体现“迭代与精炼”的对话高度相关**

One of the strongest patterns in the data is the relationship between iteration and refinement and every other AI fluency behavior. 85.7% of the conversations in our sample exhibited iteration and refinement: building on previous exchanges to refine the user’s work, rather than accepting the first response and moving to a new task. These conversations showed substantially higher rates of other fluency behaviors, as the chart below shows:

数据中最显著的模式之一，是“迭代与精炼”与其他所有AI素养行为之间的强关联性。在我们的样本中，85.7%的对话体现了迭代与精炼特征：即用户基于此前交互持续优化自身任务目标，而非简单接受首次回复后即转向新任务。如以下图表所示，这类对话中其他各项素养行为的发生率也显著更高：

![The iteration and refinement effect: Comparison table or visual showing behavior rates with/without iteration and refinement]](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F995a58d356ab28738abc3c1313296b298e4b77dc-1920x1080.png&w=3840&q=75)_Behavioral indicator prevalence in conversations where the user iterates and refines (n=8,424) versus conversations without iteration and refinement (n=1,406). All behaviors are substantially more prevalent in conversations with iteration and refinement._

![迭代与精炼效应：对比图（显示有/无迭代与精炼行为的对话中各项行为发生率）](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F995a58d356ab28738abc3c1313296b298e4b77dc-1920x1080.png&w=3840&q=75)_用户实施迭代与精炼的对话（n = 8,424）与未实施迭代与精炼的对话（n = 1,406）中各项行为指标的出现频率对比。所有行为在具备迭代与精炼特征的对话中均显著更常见。_

On average, conversations with iteration and refinement exhibit 2.67 additional fluency behaviors—roughly double the non-iterative rate of 1.33. This is especially pronounced for fluency behaviors related to evaluating Claude’s outputs. Conversations with iteration and refinement are 5.6x more likely to involve users questioning Claude’s reasoning, and 4x more likely to see them identify missing context.

平均而言，具备迭代与精炼特征的对话展现出2.67项额外的AI素养行为——约为非迭代型对话（1.33项）的两倍。这一差异在涉及“评估Claude输出”的素养行为上尤为突出：在具备迭代与精炼特征的对话中，用户质疑Claude推理过程的可能性高出5.6倍；识别上下文缺失的可能性则高出4倍。

### **When creating outputs, users become more directive but less evaluative**

### **在产出构建类任务中，用户指令性增强，但评估性减弱**

12.3% of conversations in our sample involved [artifacts](https://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835/catalog/artifacts), including code, documents, interactive tools, and other outputs. In these conversations, people collaborated with AI quite differently.

我们样本中12.3%的对话涉及[产出物（artifacts）](https://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835/catalog/artifacts)，包括代码、文档、交互式工具及其他形式的输出成果。在这些对话中，用户与AI的协作方式呈现出明显差异。

# Specifically, we found substantially higher rates of behaviors that fall within the broader themes of “description” and “delegation.” For instance, these conversations are more likely to see users clarify their goal (+14.7pp), specify a format (+14.5pp), provide examples (+13.4pp), and iterate (+9.7pp) compared to non-artifact conversations. In other words, they’re doing more to direct AI at the outset of their work.

# 具体而言，我们发现，在更宽泛的“描述”与“委派”主题下，相关行为的发生率显著更高。例如，相较于非产物型对话（non-artifact conversations），在产物型对话中，用户更倾向于明确自身目标（+14.7个百分点）、指定输出格式（+14.5个百分点）、提供示例（+13.4个百分点）以及进行迭代（+9.7个百分点）。换言之，用户在工作初始阶段就更主动地引导AI。

But this directiveness doesn’t correspond with greater levels of evaluation or discernment. **In fact, it’s the opposite: in conversations where artifacts are created, users are _less_ likely to identify missing context (-5.2pp), check facts (-3.7pp), or question the model’s reasoning by asking it to explain its rationale (-3.1pp).** Our [Economic Index](https://www.anthropic.com/research/anthropic-economic-index-january-2026-report) finds that—unsurprisingly—the most complex tasks are where Claude struggles the most, so this seems particularly noteworthy.

但这种“引导性”并未伴随更高水平的评估或审辨能力。**事实上，情况恰恰相反：在生成产物的对话中，用户识别上下文缺失（-5.2个百分点）、核查事实（-3.7个百分点）、或通过要求模型解释其推理依据来质疑其推理过程（-3.1个百分点）的可能性反而更低。** 我们的[经济指数报告](https://www.anthropic.com/research/anthropic-economic-index-january-2026-report)指出——这并不令人意外——Claude 在最复杂的任务上表现最弱，因此这一现象尤为值得关注。

![Artifact vs. non-artifact comparison table or paired bar chart](images/anthropic-education-report-the-ai-fluency-index/img_003.jpg)_Behavioral indicator prevalence in conversations with artifacts (n=1,209) versus without artifacts (n=8,621). Description and delegation behaviors increase in artifact conversations, while all three discernment behaviors decrease._

![产物型对话与非产物型对话对比表格或成对柱状图](images/anthropic-education-report-the-ai-fluency-index/img_003.jpg)_产物型对话（n=1,209）与非产物型对话（n=8,621）中各类行为指标的出现率。在产物型对话中，“描述”与“委派”类行为增多，而全部三项“审辨”类行为均减少。_

There are several possible explanations for this pattern. It might be that Claude is creating polished, functional-looking outputs, for which it doesn’t seem necessary to question things further: if the work _looks_ finished, users might treat it as such. But it’s also possible that artifact conversations involve tasks where factual precision matters less than aesthetics or functionality (designing a UI, for instance, versus writing a legal analysis). Or users might be evaluating artifacts through channels we can’t observe—running code, testing an app elsewhere, sharing a draft with a colleague—rather than expressing their evaluation within that same initial conversation.

针对这一模式，存在若干可能的解释。一种可能是：Claude 生成了外观精良、功能完备的输出，使用户觉得无需进一步质疑——若某项成果“看上去”已完成，用户便可能直接将其视作终稿。另一种可能是：产物型对话所涉及的任务，其审美性或功能性往往比事实精确性更重要（例如设计用户界面，而非撰写法律分析）。还有一种可能是：用户正通过我们无法观测的渠道评估这些产物——例如运行代码、在其他环境中测试应用程序、或将初稿分享给同事审阅——而非在初始对话中直接表达其评估过程。

Whatever the explanation, the pattern is worth paying attention to. As AI models become increasingly capable of producing polished-looking outputs, the ability to critically evaluate those outputs, whether in direct conversation or through other means, will become more valuable rather than less.

无论真实原因为何，这一模式都值得高度关注。随着AI模型日益擅长生成外观精良的输出，人们能否对其输出展开批判性评估——无论是在直接对话中，还是借助其他方式——将变得愈发重要，而非日趋式微。

Developing your own AI fluency

提升您自身的AI素养（AI Fluency）

| As with all skills, AI fluency is a matter of degree—for most of us, it’s possible to develop our techniques much further. Based on the patterns in our data, there are three areas where we’ve found many users could improve their skills: |
| --- |
| **Staying in the conversation.** Iteration and refinement is the single strongest correlate of all other fluency behaviors in our data. So, when you get an initial response, it’s worth treating it as only a starting point: ask follow-up questions, push back on any parts that don’t feel right, and refine what you’re looking for. |
| **Questioning polished outputs.** When AI models produce something that _looks_ good, it’s the perfect moment to pause and ask: is this accurate? Is anything missing? Does this reasoning hold up? As we discussed above, our data show that polished outputs coincide with lower rates of critical evaluation, even though users go to greater lengths to direct Claude’s work at the outset. |
| **Setting the terms of the collaboration.** In only 30% of conversations do users tell Claude how they’d like it to interact with them. Try being explicit by adding instructions like, “Push back if my assumptions are wrong,” “Walk me through your reasoning before giving me the answer,” or, “Tell me what you’re uncertain about.” Establishing these expectations up front can change the dynamic of the rest of the conversation. |

| 就像所有技能一样，AI素养是一个程度问题——对我们大多数人而言，提升相关技巧的空间依然很大。基于我们数据中呈现的规律，我们发现用户可在以下三个方向显著提升自身能力： |
| --- |
| **持续深入对话。** 迭代与优化是本研究中与所有其他AI素养行为相关性最强的单一行为。因此，当您收到初步回复时，应将其仅视为起点：提出跟进问题，对任何令您存疑的部分予以质疑，并不断澄清和细化您的需求。 |
| **质疑外观精良的输出。** 当AI模型产出看似优质的内容时，正是暂停反思的最佳时机：它准确吗？是否遗漏关键信息？其推理过程是否经得起推敲？如前所述，我们的数据显示，尽管用户在对话初期会更积极地引导Claude的工作，但外观精良的输出却往往伴随着更低的批判性评估频率。 |
| **明确协作规则。** 在仅有30%的对话中，用户会向Claude明确说明自己期望的交互方式。建议您主动设定规则，例如添加如下指令：“若我的假设存在错误，请及时指出”、“请先向我阐释推理过程，再给出最终答案”或“请告诉我您尚不确定之处”。提前确立这些预期，可从根本上改变后续整场对话的互动动态。 |

## **Limitations**

## **研究局限性**

This research comes with important caveats:

本研究存在若干重要前提与限制：

- **Sample limitations:** Our sample reflects Claude.ai users who engaged in multi-turn conversations during a single week in January 2026. Since we think this is still relatively early on in the diffusion of AI tools, these users likely skew towards early adopters who are already comfortable with AI—i.e., who may not represent the broader population. Our sample should be understood as providing a baseline for _this_ population, not as a universal benchmark. Because the data comes from a single week, it is also unable to capture any seasonal or longitudinal effects. And because it’s focused on [Claude.ai](http://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835), we don’t capture how users interact with other AI platforms.

- **样本局限性：** 本研究样本仅涵盖2026年1月某一周内在Claude.ai平台上开展多轮对话的用户。鉴于我们认为当前AI工具的普及仍处于相对早期阶段，这些用户很可能偏向于已熟悉AI技术的早期采用者——即未必能代表更广泛的人群。因此，该样本应被理解为针对“此类人群”的基准参考，而非普适性衡量标准。由于数据仅来自单周，故无法反映季节性变化或长期趋势；又因其聚焦于[Claude.ai](http://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835)，故未涵盖用户与其他AI平台的交互行为。

- **Partial framework coverage:** In this study, we only assessed the 11 of the 24 behavioral indicators that are directly observable in conversations on Claude.ai. All behaviors related to the responsible and ethical use of AI outputs occur outside of these conversations, and are not captured.

- **框架覆盖不全：** 本研究仅评估了24项行为指标中的11项——即那些可在Claude.ai对话中直接观察到的行为。所有与AI输出之负责任、合伦理使用相关的行为均发生于对话之外，因而未被纳入本研究范围。

- **Binary classification:** For each conversation in our sample, we classify each behavior as either present or absent. But this likely misses significant nuance—like arguable or partial demonstrations of behaviors, or overlapping signals between them.

- **二元分类法：** 对于样本中的每一场对话，我们仅将各项行为判定为“存在”或“不存在”。但这种方法很可能忽略了大量细微差别——例如存在争议或部分体现的行为，或不同行为之间信号重叠的情形。

- **Implicit behaviors:** Users might demonstrate fluency behaviors mentally (such as fact-checking Claude’s claims against their own knowledge) without expressing these behaviors in conversation. This seems especially relevant for our data on artifacts—users might be evaluating Claude’s outputs through testing and practical use, rather than through conversation-visible behaviors.

- **隐性行为：** 用户可能在思维层面展现出AI素养行为（例如，依据自身知识核查Claude所陈述内容的真实性），却未在对话中显性表达。这一点在关于“产物”的数据分析中尤为突出——用户或许正通过实际测试与应用来评估Claude的输出，而非依赖对话中可观察到的行为。

- **Correlational findings:** The relationships we identify are correlational. We don’t know whether one behavior _causes_ another, or whether they both reflect some common underlying factor, like task complexity or user preferences.

- **相关性发现：** 我们所识别出的关系均为相关性关系。我们尚无法判断某项行为是否“导致”另一项行为，抑或二者共同反映了某种潜在共因（例如任务复杂度或用户偏好）。

## **Looking ahead**

## **展望未来**

This study offers us a baseline that we can use to assess how AI fluency is changing over time. As AI capabilities evolve and adoption increases, we’re aiming to learn whether users are developing more sophisticated behaviors, which skills are emerging naturally with experience, and which will require more intentional development.

本研究为我们提供了一个基线，可用于评估人工智能素养（AI fluency）随时间推移的变化趋势。随着人工智能能力的持续演进与应用普及程度不断提高，我们希望探究：用户是否正在发展出更复杂的交互行为；哪些技能能够通过实践经验自然习得；而哪些技能则需通过更有针对性的设计与引导才能有效培养。

In future work, we plan to extend our analysis in several directions. First, we plan to conduct “cohort analyses,” comparing new users to experienced ones in order to understand how familiarity with AI is correlated with fluency development. Second, we plan to use qualitative research methods to assess the behaviors that aren’t directly observable in Claude.ai conversations. And third, we aim to explore the _causal_ questions that this work raises—like whether encouraging iterative conversations leads to greater critical evaluation, or whether there are other interventions that could encourage this more effectively.

在后续工作中，我们计划从多个方向拓展本研究的分析维度。第一，开展“队列分析”（cohort analyses），对比新用户与资深用户的行为差异，以理解用户对人工智能的熟悉程度与其素养发展之间的关联；第二，采用定性研究方法，深入考察那些无法直接从 Claude.ai 对话记录中观察到的用户行为；第三，着力探讨本研究引出的若干**因果性问题**——例如：鼓励用户开展迭代式对话，是否真能提升其批判性评估能力？是否存在其他干预方式，能更有效地促进此类能力的发展？

In addition, we’d like to explore AI fluency behaviors in Claude Code, a platform mostly used by software developers. In preparation for this study, we conducted some initial analysis that found consistency between Claude Code conversations and ones in [Claude.ai](http://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835). But this is still preliminary, and Claude Code’s very different user base and functionality implies that more substantial research is necessary.

此外，我们还希望将人工智能素养行为的研究拓展至 **Claude Code** 平台——该平台主要面向软件开发者群体。为筹备此项研究，我们已开展初步分析，发现 Claude Code 中的对话行为与 [Claude.ai](http://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835) 上的对话行为具有一定一致性。但该结论仍属初步探索；鉴于 Claude Code 拥有截然不同的用户群体与功能定位，我们判断仍需开展更为系统、深入的研究。

We expect that the nature of AI fluency will develop and evolve substantially over time. With this and future research, we’re aiming to make that development visible, measurable, and actionable.

我们预期，人工智能素养的内涵与外延将在未来发生显著而持续的演进。依托本项研究及后续工作，我们的目标是让这一演进过程变得**可见、可测、可行动**。

## **Bibtex**

## **BibTeX 引用格式**

If you’d like to cite this post, you can use the following Bibtex key:

如需引用本文，请使用以下 BibTeX 条目：

```
@online{swanson2026aifluency,
author = {Kristen Swanson, Drew Bent, and Zoe Ludwig and Rick Dakan and Joe Feller},
title = {Anthropic Education Report: The AI Fluency Index},
date = {2026-02-16},
year = {2026},
url = {https://www.anthropic.com/news/anthropic-education-report-the-ai-fluency-index},
}
```

```
@online{swanson2026aifluency,
author = {Kristen Swanson, Drew Bent, Zoe Ludwig, Rick Dakan, Joe Feller},
title = {Anthropic 教育报告：人工智能素养指数（The AI Fluency Index）},
date = {2026-02-16},
year = {2026},
url = {https://www.anthropic.com/news/anthropic-education-report-the-ai-fluency-index},
}
```

Copy

（复制）

## **Acknowledgements**

## **致谢**

Kristen Swanson designed the research, led the analysis, and wrote this report.  
克里斯滕·斯旺森（Kristen Swanson）设计了本项研究，主导了数据分析，并撰写了本报告。

Zoe Ludwig and Drew Bent contributed to framework alignment, messaging, and review.  
佐伊·路德维希（Zoe Ludwig）和德鲁·本特（Drew Bent）参与了框架对齐、信息传达及审阅工作。

The 4D Framework for AI Fluency was developed by Rick Dakan and Joe Feller.  
“AI 熟练度四维框架”（4D Framework for AI Fluency）由里克·达坎（Rick Dakan）和乔·费勒（Joe Feller）共同开发。

Zack Lee provided technical support.  
扎克·李（Zack Lee）提供了技术支持。

Hanah Ho helped visualize the data.  
哈娜·何（Hanah Ho）协助完成了数据可视化。

Keir Bradwell, Rebecca Hiscott, Ryan Donegan and Sarah Pollack provided communications review and guidance.  
凯尔·布拉德韦尔（Keir Bradwell）、丽贝卡·希斯科特（Rebecca Hiscott）、瑞安·多纳根（Ryan Donegan）和莎拉·波拉克（Sarah Pollack）提供了传播层面的审阅与指导。
{% endraw %}
