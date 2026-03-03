---
title: "Introducing Anthropic Interviewer"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/anthropic-interviewer"
date: "2026-02-19"
scraped_at: "2026-03-03T06:43:57.544503541+00:00"
language: "en-zh"
translated: true
description: "What 1,250 professionals told us about working with AI"
---

Societal Impacts

社会影响

# Introducing Anthropic Interviewer: What 1,250 professionals told us about working with AI

# 推出 Anthropic Interviewer：1,250 名专业人士告诉我们他们如何与 AI 协作

Dec 4, 2025

2025 年 12 月 4 日

![Introducing Anthropic Interviewer: What 1,250 professionals told us about working with AI ](images/introducing-anthropic-interviewer/img_001.svg)

![推出 Anthropic Interviewer：1,250 名专业人士告诉我们他们如何与 AI 协作](images/introducing-anthropic-interviewer/img_001.svg)

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建了“AI 熟练度指数”（AI Fluency Index）——这是衡量当今人们如何与 AI 协作的一项基准指标。

_We’re launching a new tool, Anthropic Interviewer, to help understand people’s perspectives on AI. In this research post, we introduce the tool, describe a test of it on a sample of professionals, and discuss our early findings. We also discuss future work in this direction that we can now explore with the development of this tool and through partnerships with creatives, scientists, and teachers._

_我们正推出一款新工具——Anthropic Interviewer，以帮助理解公众对 AI 的看法。在本篇研究报告中，我们将介绍该工具，描述其在一组专业人士样本上的测试过程，并探讨初步研究发现。此外，我们还将讨论未来可借助该工具的开发以及与创意工作者、科学家和教师等群体的合作而深入探索的研究方向。_

## Introduction

## 引言

Millions of people now use AI every day. As a company developing AI systems, we want to know how and why they’re doing so, and how it affects them. In part, this is because we want to use people’s feedback to develop better products—but it’s also because understanding people’s interactions with AI is one of the great sociological questions of our time.

如今，全球每天有数百万人使用 AI。作为一家从事 AI 系统研发的公司，我们希望了解人们使用 AI 的方式与动因，以及这种使用如何影响他们的生活。部分原因在于，我们希望借助用户反馈来打造更优质的产品；但更深层的原因是：理解人类与 AI 的互动，本身就是我们这个时代最重要的社会学议题之一。

We recently designed [a tool](https://www.anthropic.com/research/clio) to investigate patterns of AI use while protecting our users’ privacy. It enabled us to analyze changing patterns of AI use [across the economy](https://www.anthropic.com/economic-index). But the tool only allowed us to understand what was happening within conversations with Claude. What about what comes afterwards? How are people actually _using_ Claude’s outputs? How do they feel about it? What do they imagine the role of AI to be in their future? If we want a comprehensive picture of AI’s changing role in people’s lives, and to center humans in the development of models, we need to _ask people directly_.

近期，我们开发了一款名为 [Clio](https://www.anthropic.com/research/clio) 的工具，用于在严格保护用户隐私的前提下，探究 AI 使用行为的模式。该工具帮助我们分析了 AI 在[整个经济领域](https://www.anthropic.com/economic-index)中的应用趋势变化。然而，它仅能揭示用户与 Claude 对话过程中的行为特征——对话之后呢？人们究竟如何**实际使用**Claude 的输出结果？他们对此有何感受？他们又如何看待 AI 在自己未来生活中的角色？若要全面把握 AI 在人类生活中不断演进的角色，并真正将“人”置于模型研发的核心位置，我们就必须**直接向人们提问**。

Such a project would require us to run many hundreds of interviews. Here, we enlisted AI to help us do so. We built an interview tool called Anthropic Interviewer. Powered by Claude, Anthropic Interviewer runs detailed interviews automatically at unprecedented scale, feeding its results back to human researchers for analysis. This is a new step in understanding the wants and needs of our users, as well as gathering data for the analysis of AI’s societal and economic impacts.

开展这样一项研究，需要完成数百场深度访谈。为此，我们引入 AI 协助完成这项工作——开发出一款名为 **Anthropic Interviewer（Anthropic 访谈助手）** 的自动化访谈工具。该工具以 Claude 为驱动引擎，能够以前所未有的规模自动执行结构严谨、内容深入的访谈，并将访谈结果实时回传至人类研究人员进行后续分析。这标志着我们在理解用户真实需求与期待方面迈出了全新一步，同时也为系统评估 AI 对社会与经济的深远影响提供了宝贵的数据基础。

To test Anthropic Interviewer, we had it run 1,250 interviews with professionals—the general workforce (N=1,000), scientists (N=125), and creatives (N=125)—about their views on AI. We’re [publicly releasing](https://huggingface.co/datasets/Anthropic/AnthropicInterviewer) all interview data from this initial test (with participant consent) for researchers to explore; we provide our own analysis below. Briefly, here are some examples of what we found:

为验证 Anthropic Interviewer 的有效性，我们利用该工具对 1,250 名专业人士开展了访谈，受访者包括：普通职场从业者（N=1,000）、科研人员（N=125）和创意工作者（N=125），主题聚焦于他们对 AI 的看法。我们已将本次初步测试中收集的全部访谈数据（均已获得参与者知情同意）[面向公众开放](https://huggingface.co/datasets/Anthropic/AnthropicInterviewer)，供全球研究者自由探索；下文即为我们团队的初步分析结论。简要而言，我们发现以下几点：

- **In our sample, people are optimistic about the role AI plays in their work.** Positive sentiments characterized the majority of topics discussed. However, a small number of topics such as educational integration, artist displacement, and security concerns, came with more pessimistic outlooks.

- **在我们的样本中，人们对 AI 在自身工作中的作用普遍持乐观态度。** 绝大多数讨论话题均呈现积极情绪。但也有少数议题——例如教育领域的 AI 融合、艺术家职业替代风险，以及安全隐忧——引发了相对悲观的看法。

- **People from the general workforce want to preserve tasks that define their professional identity while delegating routine work to AI.** They envision futures where routine tasks are automated and their role shifts to overseeing AI systems.

- **普通职场从业者希望保留那些定义其职业身份的核心任务，同时将重复性工作交由 AI 承担。** 他们所设想的未来图景是：常规事务全面自动化，而自身角色则转向对 AI 系统的监督与管理。

- **Creatives are using AI to increase their productivity despite peer judgement and anxiety about the future.** They are navigating both the immediate stigma of AI use in creative communities and deeper concerns about economic displacement and the erosion of human creative identity.

- **创意工作者正顶着同行质疑与对未来的焦虑，积极运用 AI 提升工作效率。** 他们既要应对 AI 在创意社群中当下所承受的污名化压力，也需直面更深层的忧虑：经济层面的职业替代风险，以及人类原创性与创造性身份认同的弱化危机。

- **Scientists want AI partnership but can't yet trust it for core research.** Scientists uniformly expressed a desire for AI that could generate hypotheses and design experiments. But at present, they confined their actual use to other tasks like writing manuscripts or debugging analysis code.

- **科研人员渴望与 AI 建立协作关系，却尚无法将其用于核心科研环节。** 所有受访科学家均明确表示，期望 AI 能够辅助提出科学假说、设计实验方案；但现实中，他们目前仅将 AI 应用于撰写论文、调试分析代码等辅助性任务。

General workforce  
普通职场从业者  

Creatives  
创意工作者  

Scientists  
科研人员  

![](images/introducing-anthropic-interviewer/img_002.jpg)  
![](images/introducing-anthropic-interviewer/img_002.jpg)  

The different topics people discussed in their interviews with Anthropic Interviewer. Across all three samples we studied—the general workforce, scientists, and creatives—participants expressed predominantly positive sentiments about AI’s impact on their professional activities. Certain topics did introduce pause, particularly around questions of personal control, job displacement, and autonomy. In this diagram, topics are roughly ordered from more pessimistic to more optimistic.

受访者在与 Anthropic Interviewer 的访谈中所讨论的不同主题。在我们研究的三类群体——普通职场从业者、科研人员与创意工作者——中，绝大多数参与者均对 AI 对其职业活动的影响表达了积极看法。但某些议题确实引发了审慎反思，尤其是涉及个人掌控力、职业替代风险与工作自主性等问题。本图中，各主题大致按悲观程度由高到低（即从更悲观到更乐观）排序。

![](images/introducing-anthropic-interviewer/img_003.jpg)  
![](images/introducing-anthropic-interviewer/img_003.jpg)  

The different topics people discussed in their interviews with Anthropic Interviewer. Across all three samples we studied—the general workforce, scientists, and creatives—participants expressed predominantly positive sentiments about AI’s impact on their professional activities. Certain topics did introduce pause, particularly around questions of personal control, job displacement, and autonomy. In this diagram, topics are roughly ordered from more pessimistic to more optimistic.

受访者在与 Anthropic Interviewer 的访谈中所讨论的不同主题。在我们研究的三类群体——普通职场从业者、科研人员与创意工作者——中，绝大多数参与者均对 AI 对其职业活动的影响表达了积极看法。但某些议题确实引发了审慎反思，尤其是涉及个人掌控力、职业替代风险与工作自主性等问题。本图中，各主题大致按悲观程度由高到低（即从更悲观到更乐观）排序。

![](images/introducing-anthropic-interviewer/img_004.jpg)  
![](images/introducing-anthropic-interviewer/img_004.jpg)  

The different topics people discussed in their interviews with Anthropic Interviewer. Across all three samples we studied—the general workforce, scientists, and creatives—participants expressed predominantly positive sentiments about AI’s impact on their professional activities. Certain topics did introduce pause, particularly around questions of personal control, job displacement, and autonomy. In this diagram, topics are roughly ordered from more pessimistic to more optimistic.

受访者在与 Anthropic Interviewer 的访谈中所讨论的不同主题。在我们研究的三类群体——普通职场从业者、科研人员与创意工作者——中，绝大多数参与者均对 AI 对其职业活动的影响表达了积极看法。但某些议题确实引发了审慎反思，尤其是涉及个人掌控力、职业替代风险与工作自主性等问题。本图中，各主题大致按悲观程度由高到低（即从更悲观到更乐观）排序。

General workforce  
普通职场从业者

| Pessimistic | Optimistic |
| --- | --- |
| **Career adaptation.** Trucking dispatcher: “I'm always trying to figure out things that humans offer to the industry that can't be automated and really hone in on that aspect like the personalized human interactions. However, that is not something that I think will be necessary in the long run. I'm still trying to figure out what skills would be good to work on that AI can't ‘take over.’” | **Societal perspectives.** Office assistant: “It's a tool to me like a computer was, or a typewriter was in the day—computers didn't get rid of mathematicians, they just made them able to do more and that is where I see AI going in the best possible future.” |
| **职业适应性。** 卡车调度员：“我总在思考人类能为行业提供哪些无法被自动化替代的价值，并着力强化这些方面，比如个性化的真人互动。然而，我认为从长远来看，这类能力可能终将不再必要。我仍在努力探索：哪些技能是AI难以‘接管’的，值得我重点培养？” | **社会视角。** 办公室助理：“对我而言，AI就像当年的计算机或打字机——计算机并未取代数学家，反而让数学家能够完成更多工作；我也希望AI在最理想的发展路径中，发挥同样的作用。” |
| **Writing independence.** Salesperson: “I hear from colleagues that they can tell when email correspondence is AI generated and they have a slightly negative regard for the sender. They feel slighted that the sender is ‘too lazy’ to send them a personal note and push it onto AI to do it.” | **Educational integration.** Special education teacher: “I am hoping that AI will be a more collaborative partner that will help me better manage my time and help me expand creatively so I can offer my students a wide variety of activities and assignments that I may not have been able to come up with on my own.” |
| **写作自主性。** 销售人员：“我听同事说，他们能轻易分辨出邮件是否由AI生成，对发件人也略带负面观感——他们觉得发件人‘太懒’，不愿亲自写一封个性化信息，却把这项任务推给AI代劳。” | **教育融合。** 特殊教育教师：“我希望AI能成为更富协作性的伙伴，助我更高效地管理时间、更富创意地拓展教学，从而为学生提供更加丰富多样的活动与作业形式——而这些，单靠我个人可能很难独立构思出来。” |

Example quotations from professionals in the general workforce, organized by topic. This research aims to both unpack the optimism and navigate the underlying anxieties to better understand how AI is actually reshaping work across different professional contexts.

面向普通职场从业者的代表性引述，按主题分类整理。本研究旨在深入剖析其中的乐观预期，同时审慎应对潜藏的焦虑情绪，以更全面地理解AI如何在不同职业场景中切实重塑工作形态。

Creatives  
创意从业者  

| Pessimistic | Optimistic |
| --- | --- |
| **Control boundaries.** Gamebook writer: “During these storytelling sessions, I would say that there's only the illusion of collaboration for the most part… there’s rarely a point where I’ve really felt like the AI is driving the creative decision-making.” | **Workflow automation.** Social media manager: “I’m less stressed, honestly. It has created a ton of efficiency for me so I can focus on my favorite aspects of the job (filming and editing).” |
| **控制边界。** 互动小说作家：“在这些叙事协作过程中，我感觉大部分时候所谓的‘协作’只是一种幻觉……极少有时刻让我真切感受到AI正在主导创意决策。” | **工作流程自动化。** 社交媒体经理：“说实话，我的压力减轻了不少。AI为我带来了极高的效率，使我得以专注于工作中最喜爱的部分（如视频拍摄与剪辑）。” |
| **Writer displacement.** Creative fiction writer: “A novel written by AI might have a great plot and be technically brilliant. But it won’t have the deeper nuances that only a human can weave throughout the story.” | **Music production.** Music producer: “Sometimes, when it comes time to add lyrics, I’ll ask ChatGPT or Claude for lists of interesting word pairings. Just getting a long list to try out over the instrumental often leads to finding a hook or at least a seed for a song idea.” |
| **作者角色替代。** 创意小说作家：“AI所写的长篇小说或许情节精彩、技术精湛，但它无法具备唯有人才能在故事中自然编织的深层微妙之处。” | **音乐制作。** 音乐制作人：“有时到了填词阶段，我会请ChatGPT或Claude列出一些富有新意的词语组合。仅凭这样一份长长的备选词表，在伴奏上反复尝试，往往就能找到一句抓耳的副歌，或至少获得一个歌曲创意的雏形。” |

Example quotations from creatives, organized by topic.  
创意从业者的代表性引述，按主题分类整理。

Scientists  
科研工作者  

| Pessimistic | Optimistic |
| --- | --- |
| **Security concerns.** Medical scientist: “Our confidence in AI just isn’t high enough at the moment to trust it with our data. We’re also a commercial entity so there’s a bit of concern over confidentiality with data that we might share with an AI system.” | **Research assistance.** Molecular biologist: “If AI could integrate and normalize all this data in a single repository, it could be a very exciting thing for biological discovery. You could see how expression dynamics change across cell models, tissue types, disease states, and more.” |
| **安全隐忧。** 医学科学家：“目前我们对AI的信任度仍不够高，尚不敢将其用于处理我们的核心数据。此外，我们是一家商业机构，因此对于可能向AI系统共享的数据之保密性，也存在一定顾虑。” | **科研辅助。** 分子生物学家：“倘若AI能将所有这些数据整合并标准化，统一存入单一知识库，那将极大推动生物学发现进程。例如，我们便可清晰观察基因表达动态如何随细胞模型、组织类型、疾病状态等变量而变化。” |
| **Content verification.** Economist: “What I would really like from an AI would be the ability to accurately grab information, summarise it and use it to write the core of a funding application. AI generally writes well; the problem now is that I just can’t rely on it not hallucinating, or to put it bluntly, lying.” | **Code development.** Food scientist: “Honestly I wouldn’t have known how to help my student with her code if something was off without AI tools.” |
| **内容可信度验证。** 经济学家：“我对AI最迫切的期待，是它能准确提取信息、精准概括，并据此撰写资助申请书的核心内容。AI的文字表达通常很出色；但当前的问题在于——我根本无法确信它不会‘幻觉’（即无中生有），说得直白些，就是无法保证它不‘撒谎’。” | **代码开发支持。** 食品科学家：“坦白讲，若没有AI工具，一旦学生的代码出了问题，我根本不知道该如何协助她排查和修正。” |

Example quotations from scientists, organized by topic.  
科研工作者的代表性引述，按主题分类整理。

## Method  
## 方法  

This initial test explored how workers integrate AI into their professional practice and how they feel about its role in their future. We ran interviews to produce qualitative data, and supplemented them with quantitative data from surveys where participants answered questions on their behavioral and occupational backgrounds. We also had [a separate AI analysis tool](https://www.anthropic.com/research/clio) read the interview transcripts and cluster together emergent, overarching themes from the unstructured data—for example, on the percentage of participants who mentioned a specific topic or expressed a specific view in their interview.  

本次初步调研旨在探究从业者如何将AI融入其专业实践，以及他们如何看待AI在未来工作中的角色。我们通过深度访谈采集定性数据，并辅以问卷调查获取定量数据——问卷内容涵盖受访者的日常行为模式与职业背景信息。此外，我们还借助[一款独立的AI分析工具](https://www.anthropic.com/research/clio)，对全部访谈文本进行语义解析，从中自动聚类提炼出具有共性与代表性的核心主题——例如，统计在访谈中提及某一特定话题或表达某种特定观点的受访者比例。

### Participants

### 参与者

We used Anthropic Interviewer to conduct interviews with 1,250 professionals. We intend for the tool to interview general [Claude.ai](http://claude.ai/redirect/website.v1.027b498d-e1f8-4e85-aef7-b109dbd4c9f4) users, but for this initial test, we sought participants working across a range of professions and engaged them through crowdworker platforms (all participants had an occupation other than crowdworking that was their main job).

我们使用 Anthropic Interviewer 对 1,250 名专业人士开展了访谈。本工具的设计初衷是面向普通 [Claude.ai](http://claude.ai/redirect/website.v1.027b498d-e1f8-4e85-aef7-b109dbd4c9f4) 用户开展访谈；但在本次初步测试中，我们面向多个职业领域的从业者招募参与者，并通过众包工作者平台（crowdworker platforms）进行招募（所有参与者均以非众包工作为自己的主要职业）。

1,000 of our participants were recruited from a general sample of occupations (that is, we did not select participants from specific jobs). Of that group, the largest subgroups came from educational instruction (17%), computer and mathematical occupations (16%), and arts, design, entertainment, and media (14%).

其中 1,000 名参与者来自涵盖广泛职业类别的通用样本（即我们并未限定特定职业岗位进行招募）。在该群体中，占比最大的三个子群体分别来自教育与教学领域（17%）、计算机与数学类职业（16%），以及艺术、设计、娱乐与媒体行业（14%）。

We also recruited two specialist samples of 125 participants each. The first was from creative professions: predominantly writers and authors (48% of the sample), and visual artists (21%), with smaller groups of filmmakers, designers, musicians, and craft workers. The second was from science, which included physicists (9%), chemists (9%), chemical engineers (7%), and data scientists (6%), with representation across 50+ other distinct scientific disciplines.

此外，我们还分别招募了两个各含 125 名参与者的专业领域样本。第一个样本来自创意行业：以作家与作者为主（占该样本的 48%），其次是视觉艺术家（21%），其余则包括电影制作人、设计师、音乐家及手工艺人等较小规模群体。第二个样本来自科学界：包括物理学家（9%）、化学家（9%）、化学工程师（7%）和数据科学家（6%），此外还有来自 50 余个其他不同科学学科的代表性参与者。

We chose to add these two specialist subgroups because these represent professional domains where AI’s role remains contested and is rapidly evolving. We hypothesized that creatives and scientists would reveal distinct patterns of AI adoption and professional concerns.

我们选择增设这两个专业子群体，是因为创意与科学领域正是当前人工智能角色尚存争议、且其影响正快速演进的职业领域。我们假设，创意工作者与科研人员在人工智能采纳模式及职业关切方面将呈现出明显不同的特征。

All participants provided informed consent for us to analyze their interview data for research purposes and for us to release the transcripts publicly.

所有参与者均签署知情同意书，授权我们出于研究目的分析其访谈数据，并允许我们将访谈文字记录公开发布。

### How Anthropic Interviewer works

### Anthropic Interviewer 的工作原理

Anthropic Interviewer operates in three stages: planning, interviewing, and analysis. Below, we describe each of them in turn.

Anthropic Interviewer 的运行分为三个阶段：规划（Planning）、访谈（Interviewing）与分析（Analysis）。下文将依次介绍这三个阶段。

![](images/introducing-anthropic-interviewer/img_005.jpg)The three stages of Anthropic Interviewer's process.

![](images/introducing-anthropic-interviewer/img_005.jpg)Anthropic Interviewer 工作流程的三个阶段。

#### Planning

#### 规划

In this phase, Anthropic Interviewer creates an interview rubric that allows it to focus on the same overall research questions across hundreds or thousands of interviews, but which is still flexible enough to accommodate variations and tangents that might occur in individual interviews.

在此阶段，Anthropic Interviewer 创建一份访谈评分标准（interview rubric），使其能够在成百上千次访谈中始终聚焦于相同的总体研究问题，同时仍保有足够的灵活性，以适应单次访谈中可能出现的变通与偏离。

We developed a system prompt—a set of overall instructions for how the AI model is to work—to give Anthropic Interviewer its methodology. This was where we included hypotheses regarding each sample, as well as best practices for creating an interview plan (this was established in collaboration with our user research team).

我们设计了一套系统提示（system prompt）——即一组指导该 AI 模型如何运作的总体指令——以此赋予 Anthropic Interviewer 其方法论。在此提示中，我们纳入了针对每个样本的假设，以及制定访谈计划的最佳实践（该部分由我们用户研究团队共同确立）。

After putting the system prompt in place, Anthropic Interviewer used its knowledge of our research goal (see section below) to generate specific questions and a planned conversation flow. There was then a review phase where human researchers collaborated with Anthropic Interviewer to make any necessary edits to finalize the plan.

在部署系统提示后，Anthropic Interviewer 基于其对本研究目标的理解（参见下文相关章节），生成具体问题及预设的对话流程。随后进入审核阶段：人类研究员与 Anthropic Interviewer 协同工作，对计划进行必要修改，最终定稿。

#### Interviewing

#### 访谈实施

Anthropic Interviewer then conducted real-time, adaptive interviews following its interview plan. At this stage, we included a system prompt to instruct Anthropic Interviewer how to use best practices for interviews.

此后，Anthropic Interviewer 严格依据其访谈计划，开展实时、自适应的访谈。在此阶段，我们额外嵌入了一条系统提示，用以指导 Anthropic Interviewer 如何运用访谈最佳实践。

The interviews conducted by Anthropic Interviewer appeared on Claude.ai and lasted about 10–15 minutes with each participant.

Anthropic Interviewer 所开展的访谈在 [Claude.ai](https://claude.ai/) 平台上进行，每位参与者访谈时长约 10–15 分钟。

![](images/introducing-anthropic-interviewer/img_006.jpg)The interviews were conducted on an interface like this on [claude.ai](http://claude.ai/) (above is the module now live for users).

![](images/introducing-anthropic-interviewer/img_006.jpg)访谈通过类似上图所示的界面在 [claude.ai](https://claude.ai/) 上进行（上方即当前已面向用户正式上线的功能模块）。

#### Analysis

#### 分析环节

Once interviews were complete, a human researcher collaborated with Anthropic Interviewer to analyze the transcripts. Anthropic Interviewer’s analysis step takes as input the initial interview plan and outputs answers to the research questions alongside illustrative quotations. At this stage, we also used our [automated AI analysis tool](https://www.anthropic.com/research/clio) to identify emergent themes and quantify their prevalence across participants.

访谈全部完成后，人类研究员与 Anthropic Interviewer 协同分析访谈转录文本。Anthropic Interviewer 的分析步骤以初始访谈计划为输入，输出针对各项研究问题的答案，并辅以具有代表性的引述。在此阶段，我们还运用了自身的 [自动化 AI 分析工具（Clio）](https://www.anthropic.com/research/clio)，用于识别新兴主题，并量化其在不同参与者中的出现频次。

### Research goals

### 研究目标

As described above, Anthropic Interviewer was made aware of the research goals through its system prompt, and ran its interviews in such a way as to address them. Note that, in this initial study, our main intention was to perform a practical test of Anthropic Interviewer; the goals below nonetheless provided interesting data which we analyze below.

如上所述，Anthropic Interviewer 通过其系统提示（system prompt）获知了本研究的目标，并据此开展访谈以回应这些目标。需注意的是，在本次初步研究中，我们的主要目的在于对 Anthropic Interviewer 进行一次实践性测试；尽管如此，下述研究目标仍为我们提供了富有启发性的数据，我们将在后文予以分析。

The following were the main research goals for each subsample:

以下为各子样本的主要研究目标：

- **General workforce.** “Understand how individuals integrate AI tools into their professional workflows, exploring usage patterns, task preferences, and interaction styles to gain insights into the evolving relationship between humans and AI in workplace contexts.”  
- **普通职场从业者。** “了解个体如何将 AI 工具融入其职业工作流，探究其使用模式、任务偏好与交互风格，从而深入理解人类与 AI 在职场环境中的动态关系演变。”

- **Creatives.** “To understand how creative professionals currently integrate AI into their creative processes, their experiences with AI’s impact on their work, and their vision for the future relationship between AI and human creativity.”  
- **创意从业者。** “了解创意专业人士当前如何将 AI 融入其创作流程，他们在工作中体验到的 AI 影响，以及他们对未来 AI 与人类创造力关系的构想。”

- **Scientists.** “To understand how AI systems integrate into scientists' daily research workflows, examining their current usage patterns, perceived value, trust levels, and barriers to adoption across different stages of the scientific process.”  
- **科研人员。** “了解 AI 系统如何融入科学家的日常科研工作流，考察其当前使用模式、感知价值、信任程度，以及在科学过程不同阶段所面临的采纳障碍。”

## Results

## 研究结果

Below we discuss what we discovered in our interviews and provide quantitative data from our survey and thematic analysis.

下文我们将讨论访谈中发现的关键现象，并呈现来自问卷调查与主题分析的量化数据。

### AI’s impact in the general workforce

### AI 对普通职场从业者的影响

Overall, the members of our general sample of professionals described AI as a boost to their productivity. In the survey, 86% of professionals reported that AI saves them time and 65% said they were satisfied with the role AI plays in their work.

总体而言，我们面向普通职场从业者的抽样受访者普遍将 AI 描述为提升其工作效率的助力。在问卷调查中，86% 的从业者表示 AI 为其节省了时间，65% 表示对 AI 在其工作中所扮演的角色感到满意。

One theme that surfaced is how workplace dynamics affect the adoption of AI. 69% of professionals mentioned the social stigma that can come with using AI tools at work—one fact-checker told Anthropic Interviewer: “A colleague recently said they hate AI and I just said nothing. I don’t tell anyone my process because I know how a lot of people feel about AI.”

一个浮现的主题是职场人际动态如何影响 AI 的采纳。69% 的从业者提到了在工作中使用 AI 工具可能招致的社会污名——一位事实核查员向 Anthropic Interviewer 表示：“最近一位同事说他讨厌 AI，我当时什么也没说。我不会向任何人透露自己的工作流程，因为我清楚很多人对 AI 的真实态度。”

Whereas 41% of interviewees said they felt secure in their work and believed human skills are irreplaceable, 55% expressed anxiety about AI’s impact on their future. 25% of the group expressing anxiety said they set boundaries around AI use (e.g. an educator always creating lesson plans themselves), while 25% adapted their workplace roles, taking on additional responsibilities or pursuing more specialized tasks.

相比之下，41% 的受访者表示对自己的工作前景感到安心，并坚信人类技能不可替代；而 55% 则表达了对 AI 未来影响自身职业发展的焦虑。在表达焦虑的群体中，25% 表示主动为 AI 使用设定了边界（例如，一名教育工作者始终坚持独立设计教案），另有 25% 则调整了自身职场角色，承担更多职责或转向更专业化的任务。

Approaches to AI use varied widely. One data quality manager deliberately chose learning over automation: “I try to think about it like studying a foreign language—just using a translator app isn’t going to teach you anything, but having a tutor who can answer questions and customize for your needs is really going to help.” A marketer took a flexible approach: “I am trying to diversify while keeping a strong niche.” An interpreter was already preparing to leave the field entirely: “I believe AI will eventually replace most interpreters... so I’m already preparing for a career switch, possibly by getting a diploma and getting into a different trade.” Notably, only 8% of professionals expressed anxiety without any clear remediation plan.

人们对 AI 的使用方式差异显著。一位数据质量经理明确选择“学习优先于自动化”：“我尝试把它当作学习一门外语来对待——仅靠翻译 App 并不能教会你任何东西，但若有一位能答疑解惑、并根据你的需求定制教学的导师，那才真正有助益。” 一位市场营销人员则采取灵活策略：“我正努力拓展业务广度，同时坚守自身核心专长领域。” 而一位口译员已着手彻底转行：“我相信 AI 最终将取代大多数口译员……因此我已在为职业转型做准备，比如考取相关文凭，进入另一个行业。” 值得注意的是，仅有 8% 的从业者表达了焦虑，却未提出任何明确的应对方案。

Education & Library  
教育与图书馆  

Computer & Math  
计算机与数学  

Art, Design, & Media  
艺术、设计与媒体  

Business & Financial  
商业与金融  

Office & Admin  
办公与行政  

Sales  
销售  

![](images/introducing-anthropic-interviewer/img_007.jpg)  
![](images/introducing-anthropic-interviewer/img_007.jpg)  

Intensity of the top six emotions—hope, worry, satisfaction, frustration, relief, and trust—surfaced during interviews with professionals in the general workforce from six major occupational categories from the O\*NET database. Each axis represents one emotion, with distance from the center indicating the percentage of interviews in which participants expressed that emotion; points farther from the center reflect higher prevalence. We analyzed these emotions across the six most prominent occupational categories in our sample.  
在对来自 O\*NET 数据库六大主要职业类别的普通职场专业人士所开展的访谈中，浮现出了六种最突出的情绪——希望、担忧、满足感、挫败感、释然感和信任感。图表中每条轴代表一种情绪，距中心点的距离表示在多少比例的访谈中受访者表达了该情绪；离中心越远的点，表明该情绪出现的频率越高。我们针对样本中最具代表性的六大职业类别分析了这些情绪的强度。

![](images/introducing-anthropic-interviewer/img_008.jpg)  
![](images/introducing-anthropic-interviewer/img_008.jpg)  

Intensity of the top six emotions—hope, worry, satisfaction, frustration, relief, and trust—surfaced during interviews with professionals in the general workforce from six major occupational categories from the O\*NET database. Each axis represents one emotion, with distance from the center indicating the percentage of interviews in which participants expressed that emotion; points farther from the center reflect higher prevalence. We analyzed these emotions across the six most prominent occupational categories in our sample.  
在对来自 O\*NET 数据库六大主要职业类别的普通职场专业人士所开展的访谈中，浮现出了六种最突出的情绪——希望、担忧、满足感、挫败感、释然感和信任感。图表中每条轴代表一种情绪，距中心点的距离表示在多少比例的访谈中受访者表达了该情绪；离中心越远的点，表明该情绪出现的频率越高。我们针对样本中最具代表性的六大职业类别分析了这些情绪的强度。

![](images/introducing-anthropic-interviewer/img_009.jpg)  
![](images/introducing-anthropic-interviewer/img_009.jpg)  

Intensity of the top six emotions—hope, worry, satisfaction, frustration, relief, and trust—surfaced during interviews with professionals in the general workforce from six major occupational categories from the O\*NET database. Each axis represents one emotion, with distance from the center indicating the percentage of interviews in which participants expressed that emotion; points farther from the center reflect higher prevalence. We analyzed these emotions across the six most prominent occupational categories in our sample.  
在对来自 O\*NET 数据库六大主要职业类别的普通职场专业人士所开展的访谈中，浮现出了六种最突出的情绪——希望、担忧、满足感、挫败感、释然感和信任感。图表中每条轴代表一种情绪，距中心点的距离表示在多少比例的访谈中受访者表达了该情绪；离中心越远的点，表明该情绪出现的频率越高。我们针对样本中最具代表性的六大职业类别分析了这些情绪的强度。

![](images/introducing-anthropic-interviewer/img_010.jpg)  
![](images/introducing-anthropic-interviewer/img_010.jpg)  

Intensity of the top six emotions—hope, worry, satisfaction, frustration, relief, and trust—surfaced during interviews with professionals in the general workforce from six major occupational categories from the O\*NET database. Each axis represents one emotion, with distance from the center indicating the percentage of interviews in which participants expressed that emotion; points farther from the center reflect higher prevalence. We analyzed these emotions across the six most prominent occupational categories in our sample.  
在对来自 O\*NET 数据库六大主要职业类别的普通职场专业人士所开展的访谈中，浮现出了六种最突出的情绪——希望、担忧、满足感、挫败感、释然感和信任感。图表中每条轴代表一种情绪，距中心点的距离表示在多少比例的访谈中受访者表达了该情绪；离中心越远的点，表明该情绪出现的频率越高。我们针对样本中最具代表性的六大职业类别分析了这些情绪的强度。

![](images/introducing-anthropic-interviewer/img_011.jpg)  
![](images/introducing-anthropic-interviewer/img_011.jpg)  

Intensity of the top six emotions—hope, worry, satisfaction, frustration, relief, and trust—surfaced during interviews with professionals in the general workforce from six major occupational categories from the O\*NET database. Each axis represents one emotion, with distance from the center indicating the percentage of interviews in which participants expressed that emotion; points farther from the center reflect higher prevalence. We analyzed these emotions across the six most prominent occupational categories in our sample.  
在对来自 O\*NET 数据库六大主要职业类别的普通职场专业人士所开展的访谈中，浮现出了六种最突出的情绪——希望、担忧、满足感、挫败感、释然感和信任感。图表中每条轴代表一种情绪，距中心点的距离表示在多少比例的访谈中受访者表达了该情绪；离中心越远的点，表明该情绪出现的频率越高。我们针对样本中最具代表性的六大职业类别分析了这些情绪的强度。

![](images/introducing-anthropic-interviewer/img_012.jpg)  
![](images/introducing-anthropic-interviewer/img_012.jpg)  

Intensity of the top six emotions—hope, worry, satisfaction, frustration, relief, and trust—surfaced during interviews with professionals in the general workforce from six major occupational categories from the O\*NET database. Each axis represents one emotion, with distance from the center indicating the percentage of interviews in which participants expressed that emotion; points farther from the center reflect higher prevalence. We analyzed these emotions across the six most prominent occupational categories in our sample.  
在对来自 O\*NET 数据库六大主要职业类别的普通职场专业人士所开展的访谈中，浮现出了六种最突出的情绪——希望、担忧、满足感、挫败感、释然感和信任感。图表中每条轴代表一种情绪，距中心点的距离表示在多少比例的访谈中受访者表达了该情绪；离中心越远的点，表明该情绪出现的频率越高。我们针对样本中最具代表性的六大职业类别分析了这些情绪的强度。

We also classified the intensity of different emotions exhibited within professionals’ interviews (see figure above). Different professions exhibited remarkably uniform emotional profiles characterized by high levels of satisfaction. However, this was coupled with frustration, suggesting professionals are finding AI useful while encountering significant implementation challenges.  
我们还对专业人士访谈中所展现的不同情绪强度进行了分类（参见上图）。不同职业群体展现出高度一致的情绪特征：普遍表现出强烈的满足感；但与此同时，挫败感也十分显著。这表明专业人士普遍认可 AI 的实用价值，却在实际落地过程中面临诸多挑战。

### Augmentation versus automation  
### 增强型应用 vs. 自动化替代  

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F663272ce4341caa37614dbf16908c75d6e89b70d-1920x1200.jpg&w=3840&q=75)  
![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F663272ce4341caa37614dbf16908c75d6e89b70d-1920x1200.jpg&w=3840&q=75)  

Augmentation versus automation in professionals' self-reports to Anthropic Interviewer compared with observed Claude usage in the Anthropic Economic Index. Professionals described their AI use as 65% augmentative and 35% automative, while actual Claude conversations showed 47% augmentation and 49% automation. Economic Index percentages do not sum to 100% as some interactions were unclassified.  
专业人士向 Anthropic Interviewer 所作的自我报告中关于“增强型应用”与“自动化替代”的比例，与 Anthropic 经济指数中实际观测到的 Claude 使用情况对比。在自我报告中，专业人士将自身 AI 使用描述为 65% 属于增强型（augmentative）、35% 属于自动化（automative）；而实际 Claude 对话数据显示，增强型应用占 47%，自动化替代占 49%。经济指数中的百分比总和不足 100%，因为部分交互未被归类。

In a [previous analysis](https://arxiv.org/pdf/2503.04761), we categorized AI uses into either _augmentation_ (where AI collaborates with a user to perform a task), or _automation_ (where AI directly performs tasks).  
在一项[先前的分析](https://arxiv.org/pdf/2503.04761)中，我们将人工智能的用途划分为两类：_增强型_（即 AI 与用户协作完成任务）和_自动化型_（即 AI 直接执行任务）。

In the Anthropic Interviewer data, 65% of participants described AI’s primary role as augmentative; 35% described it as automative.  
在 Anthropic Interviewer 数据中，65% 的受访者将 AI 的主要作用描述为“增强型”，35% 描述为“自动化型”。

Notably, this differed from our [latest analysis](https://www.anthropic.com/research/economic-index-geography) of how people use Claude, which showed a much more even split: 47% of tasks involved augmentation and 49% automation.  
值得注意的是，这与我们关于人们如何使用 Claude 的[最新分析](https://www.anthropic.com/research/economic-index-geography)结果不同——后者显示两类用途比例更为均衡：47% 的任务属于增强型，49% 属于自动化型。

There are multiple potential explanations for this difference:  
造成这一差异的潜在原因有多种：

- There could be sample differences between Anthropic Interviewer study respondents and the users in our previous study;  
- Anthropic Interviewer 研究的受访者与我们先前研究中的用户可能存在样本差异；

- People’s conversations on Claude may _look_ more automative than they actually are—users might refine or adapt Claude’s outputs after the chat ends;  
- 用户在 Claude 上的对话可能表面上看起来更偏向自动化，而实际并非如此——用户很可能在聊天结束后进一步修改或调整 Claude 的输出；

- The participants might use different AI providers for different tasks;  
- 受访者可能针对不同任务选用不同的 AI 提供商；

- Self-reported interaction styles might diverge from real-world usage;  
- 受访者自我报告的交互方式可能与其真实使用行为存在偏差；

- Professionals might perceive their AI use as more collaborative than their Claude conversation patterns indicate.  
- 专业人士可能主观上认为自己对 AI 的使用更具协作性，但其在 Claude 上的实际对话模式却未必体现这一点。

Professionals envisioned a future with both augmentation and automation—the automation of routine, administrative tasks with the maintenance of human oversight.  
专业人士所构想的未来兼具增强与自动化——即在保持人类监督的前提下，将常规性、行政类任务交由 AI 自动完成。

48% of interviewees considered transitioning their careers toward positions that focus on managing and overseeing AI systems rather than performing direct technical work.  
48% 的受访者考虑转向以管理与监督 AI 系统为核心职责的职业路径，而非从事直接的技术性工作。

...if I use AI and up my skills with it, it can save me so much time on the admin side which will free me up to be with the people.  
……如果我使用 AI 并借此提升自身能力，它就能为我在行政事务上节省大量时间，从而让我有更多机会陪伴他人。

A pastor said that “...if I use AI and up my skills with it, it can save me so much time on the admin side which will free me up to be with the people”. They also emphasized the importance of “good boundaries”, and avoiding becoming “so dependent on AI that I can't live without \[it\] or do what I'm called to do.”  
一位牧师表示：“……如果我使用 AI 并借此提升自身能力，它就能为我在行政事务上节省大量时间，从而让我有更多机会陪伴他人。”他还特别强调了设立“良好边界”的重要性，并提醒要避免“对 AI 过度依赖，以至于离开它就无法生活，或无法履行自己被赋予的使命”。

A communications professional said: “I believe the majority of my job will probably be overtaken by AI one day. I think my role will eventually become focused around prompting, overseeing, training and quality-controlling the models rather than actually doing the work myself”.  
一位传播专业人士表示：“我相信，终有一天，我工作的大部分内容将被 AI 所取代。我认为，我的角色最终将聚焦于提示工程（prompting）、监督、模型训练以及质量管控，而非亲自执行具体工作。”

Professionals who were currently barred from using AI at work—for example, some lawyers, accountants, and healthcare workers—anticipated policy changes that would let them automate many tasks in the future.  
目前因政策限制而无法在工作中使用 AI 的专业人士——例如部分律师、会计师及医疗从业者——普遍预期相关政策将发生改变，使他们未来得以实现诸多任务的自动化。

### AI’s impact on creative professions  

### AI 对创意行业的影响  

Our sample of creative professionals also reported that AI made them more productive. 97% reported that AI saved them time and 68% said it increased their work’s quality.  
我们所调研的创意从业者同样表示，AI 提升了他们的工作效率。97% 的受访者表示 AI 为其节省了时间，68% 认为 AI 提高了其作品质量。

One novelist explained “I feel like I can write faster because the research isn’t as daunting,” while a web content writer reported they’ve “gone from being able to produce 2,000 words of polished, professional content to well over 5,000 words each day.”  
一位小说家解释道：“我觉得自己写作速度变快了，因为资料搜集不再那么令人望而生畏。”一位网络内容撰稿人则表示，其日均产出已“从原先每天能完成 2,000 字左右精修润色的专业内容，跃升至如今轻松突破 5,000 字”。

A photographer noted how AI handled routine editing tasks—reducing turnaround time from “12 weeks to about 3”—allowing them to “intentionally make edits and tweaks that I may have missed before or not had time for.”  
一位摄影师指出，AI 承担了大量常规图像编辑任务，使其交付周期从“原本的 12 周缩短至约 3 周”，从而得以“有意识地进行此前可能忽略、或因时间不足而无法完成的精细调整与优化”。

Similarly to the general sample, 70% of creatives mentioned trying to manage peer judgment around AI use.  
与整体样本情况类似，70% 的创意从业者提到，他们曾努力应对同行围绕 AI 使用所产生的评判压力。

One map artist said: “I don't want my brand and my business image to be so heavily tied to AI and the stigma that surrounds it.”  
一位地图艺术家表示：“我不希望自己的个人品牌与商业形象过度绑定于 AI，以及它所附带的社会偏见。”

Certain sectors of voice acting have essentially died due to the rise of AI.  
受 AI 兴起影响，配音行业的某些细分领域实际上已走向消亡。

Economic anxiety appeared throughout creatives’ interviews.  
经济焦虑贯穿于创意从业者的访谈之中。

A voice actor stated that: “Certain sectors of voice acting have essentially died due to the rise of AI, such as industrial voice acting.”  
一位配音演员表示：“由于人工智能的兴起，配音行业的某些领域实际上已经消亡，例如工业类配音。”

A composer worried about platforms that might “leverage AI tech along with their publishing libraries [to] infinitely generate new music,” flooding markets with cheap alternatives to human-produced music.  
一位作曲家担忧某些平台可能“利用人工智能技术结合其出版曲库，无限生成新音乐”，从而以廉价替代品充斥市场，挤压人类创作音乐的生存空间。

Another artist captured similar concerns: “Realistically, I’m worried I'll need to keep using generative AI and even start selling generated content just to keep up in the marketplace so I can make a living.”  
另一位艺术家表达了类似忧虑：“现实地说，我担心自己将不得不持续使用生成式 AI，甚至开始销售 AI 生成的内容，才能在市场中勉强维持生计。”

A creative director said: “I fully understand that my gain is another creative’s loss. That product photographer that I used to have to pay $2,000 per day is now not getting my business.”  
一位创意总监表示：“我完全明白，我的获益意味着另一位创意从业者的损失。过去我每天需支付 2000 美元聘请的产品摄影师，如今已不再获得我的业务。”

(Note that Claude does not produce images, videos, or music—participants’ expressed anxieties are therefore about AI writ large, and not specific to Claude).  
（需注意：Claude 并不生成图像、视频或音乐——因此参与者所表达的焦虑针对的是广义的人工智能整体，而非特指 Claude。）

All 125 participants mentioned wanting to remain in control of their creative outputs.  
全部 125 名参与者均提到，希望始终掌控自己的创意产出。

Yet this boundary proved unstable in practice: Many participants acknowledged moments where AI drove creative decisions.  
然而，这一边界在实践中却显得不稳定：许多参与者承认，AI 曾在某些时刻主导了创意决策。

One artist admitted: “The AI is driving a good bit of the concepts; I simply try to guide it… 60% AI, 40% my ideas”.  
一位艺术家坦言：“AI 主导了相当一部分创意构思；我仅尝试加以引导……其中约 60% 来自 AI，40% 源于我的想法。”

A musician said: “I hate to admit it, but the plugin has most of the control when using this.”  
一位音乐人表示：“我虽不愿承认，但使用该插件时，控制权大多掌握在插件手中。”

Writers  
作家  

Visual artists  
视觉艺术家  

Craftspeople  
手工艺人  

Designers  
设计师  

Filmmakers  
电影制作人  

Game developers  
游戏开发者  

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2Ff44912bbbe2f514dc867a3fb6a506aa440e241d5-2880x1800.jpg&w=3840&q=75)Intensity of the top six emotions—hope, worry, satisfaction, frustration, relief, and trust—reported during interviews with creative professionals. The axis denotes the percentage of interviews in which the participant expressed the given emotion. We analyzed these emotions across the six most prominent creative disciplines in our sample.  
![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2Ff44912bbbe2f514dc867a3fb6a506aa440e241d5-2880x1800.jpg&w=3840&q=75)创意从业者访谈中报告的六大主要情绪——希望、担忧、满足感、挫败感、释然感与信任感——的强度分布图。纵轴表示在多少比例的访谈中，参与者表达了该种情绪。我们针对样本中最具代表性的六大创意职业类别分析了这些情绪。

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F1c46cdd7d11bfcc87e55499a593a80beba22e119-2882x1800.jpg&w=3840&q=75)Intensity of the top six emotions—hope, worry, satisfaction, frustration, relief, and trust—reported during interviews with creative professionals. The axis denotes the percentage of interviews in which the participant expressed the given emotion. We analyzed these emotions across the six most prominent creative disciplines in our sample.  
![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F1c46cdd7d11bfcc87e55499a593a80beba22e119-2882x1800.jpg&w=3840&q=75)创意从业者访谈中报告的六大主要情绪——希望、担忧、满足感、挫败感、释然感与信任感——的强度分布图。纵轴表示在多少比例的访谈中，参与者表达了该种情绪。我们针对样本中最具代表性的六大创意职业类别分析了这些情绪。

![](images/introducing-anthropic-interviewer/img_016.jpg)Intensity of the top six emotions—hope, worry, satisfaction, frustration, relief, and trust—reported during interviews with creative professionals. The axis denotes the percentage of interviews in which the participant expressed the given emotion. We analyzed these emotions across the six most prominent creative disciplines in our sample.  
![](images/introducing-anthropic-interviewer/img_016.jpg)创意从业者访谈中报告的六大主要情绪——希望、担忧、满足感、挫败感、释然感与信任感——的强度分布图。纵轴表示在多少比例的访谈中，参与者表达了该种情绪。我们针对样本中最具代表性的六大创意职业类别分析了这些情绪。

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F313b1a2bcd56f924cd26716b5f25889c2fa001dc-2880x1800.jpg&w=3840&q=75)Intensity of the top six emotions—hope, worry, satisfaction, frustration, relief, and trust—reported during interviews with creative professionals. The axis denotes the percentage of interviews in which the participant expressed the given emotion. We analyzed these emotions across the six most prominent creative disciplines in our sample.  
![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F313b1a2bcd56f924cd26716b5f25889c2fa001dc-2880x1800.jpg&w=3840&q=75)创意从业者访谈中报告的六大主要情绪——希望、担忧、满足感、挫败感、释然感与信任感——的强度分布图。纵轴表示在多少比例的访谈中，参与者表达了该种情绪。我们针对样本中最具代表性的六大创意职业类别分析了这些情绪。

![](images/introducing-anthropic-interviewer/img_018.jpg)Intensity of the top six emotions—hope, worry, satisfaction, frustration, relief, and trust—reported during interviews with creative professionals. The axis denotes the percentage of interviews in which the participant expressed the given emotion. We analyzed these emotions across the six most prominent creative disciplines in our sample.  
![](images/introducing-anthropic-interviewer/img_018.jpg)创意从业者访谈中报告的六大主要情绪——希望、担忧、满足感、挫败感、释然感与信任感——的强度分布图。纵轴表示在多少比例的访谈中，参与者表达了该种情绪。我们针对样本中最具代表性的六大创意职业类别分析了这些情绪。

![](images/introducing-anthropic-interviewer/img_019.jpg)Intensity of the top six emotions—hope, worry, satisfaction, frustration, relief, and trust—reported during interviews with creative professionals. The axis denotes the percentage of interviews in which the participant expressed the given emotion. We analyzed these emotions across the six most prominent creative disciplines in our sample.  
![](images/introducing-anthropic-interviewer/img_019.jpg)创意从业者访谈中报告的六大主要情绪——希望、担忧、满足感、挫败感、释然感与信任感——的强度分布图。纵轴表示在多少比例的访谈中，参与者表达了该种情绪。我们针对样本中最具代表性的六大创意职业类别分析了这些情绪。

Disciplines exhibited divergent emotional profiles as seen in the figure above: game developers and visual artists reported high satisfaction, paradoxically paired with elevated worry.  
各职业类别的感情图谱如上图所示，呈现显著差异：游戏开发者与视觉艺术家报告了较高的满足感，却矛盾地同时伴有强烈的担忧。

Designers showed an inverse pattern dominated by frustration with notably low satisfaction.  
设计师则呈现出相反的模式：以高度挫败感为主导，且满足感明显偏低。

Across all disciplines, trust remained consistently low, suggesting shared uncertainty about AI’s long-term implications for creative work.  
在所有职业类别中，信任感均持续处于低位，反映出创意从业者对人工智能长期影响创意工作的普遍不确定性。

The tension between satisfaction and worry may highlight the position of creative professionals who simultaneously embrace AI tools while grappling with concerns about the future of human creativity.  
满足感与担忧之间的张力，或许凸显了创意从业者的双重处境：他们一方面积极采纳 AI 工具，另一方面又深切忧虑人类创造力的未来走向。

The wide dispersion across the emotional spectrum confirmed that different creative professions experienced AI integration through very different emotional lenses.  
情绪光谱上的广泛离散分布印证了一点：不同创意职业在接纳人工智能的过程中，经历了截然不同的情感体验。

### AI’s impact on scientific work

### AI 对科研工作的影响

Our interviews with researchers in chemistry, physics, biology, and computational fields identified that in many cases, AI could not yet handle core elements of their research like hypothesis generation and experimentation. Scientists primarily reported using AI for other tasks like literature review, coding, and writing. This is an area where AI companies, [including Anthropic](https://www.anthropic.com/news/claude-for-life-sciences), are working to improve their tools and capabilities.

我们对化学、物理、生物及计算领域研究人员的访谈发现，在许多情况下，当前 AI 尚无法胜任科研中的核心环节，例如提出假说和开展实验。科学家们主要将 AI 应用于文献综述、编程和论文写作等其他任务。这一领域正是包括 Anthropic 在内的 AI 公司正着力提升其工具与能力的方向。

Trust and reliability concerns were the primary barrier in 79% of interviews; the technical limitations of current AI systems appeared in 27% of interviews. One information security researcher noted: “If I have to double check and confirm every single detail the \[AI\] agent is giving me to make sure there are no mistakes, that kind of defeats the purpose of having the agent do this work in the first place.” A mathematician echoed this frustration: “After I have to spend the time verifying the AI output, it basically ends up being the same \[amount of\] time.” A chemical engineer noted concerns about sycophancy, explaining that: “AI tends to pander to \[user\] sensibilities and changes its answer depending on how they phrase a question. The inconsistency tends to make me skeptical of the AI response.”

在 79% 的访谈中，“信任与可靠性”是首要障碍；而当前 AI 系统的技术局限性则在 27% 的访谈中被提及。一位信息安全研究员指出：“如果我必须逐一复核并确认 \[AI\] 智能体提供的每一个细节，以确保毫无差错，那么让该智能体承担这项工作的初衷实际上就被消解了。”一位数学家表达了相似的挫败感：“在我花费时间验证 AI 输出之后，最终所耗时间基本与不使用 AI 时相当。”一位化学工程师则表达了对“谄媚性”（sycophancy）问题的担忧，解释道：“AI 往往迎合 \[用户\] 的主观倾向，并会因用户提问措辞的不同而改变答案。这种不一致性常令我对 AI 的回应持怀疑态度。”

Chemists  
Physicists  
Chemical engineers  
Data scientists  
Mechanical engineers  
Astronomers  

化学家  
物理学家  
化学工程师  
数据科学家  
机械工程师  
天文学家  

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F158146f808a8480ab382bd84499572ba7dabb209-2880x1800.jpg&w=3840&q=75)Intensity of the top six emotions—hope, satisfaction, frustration, worry, doubt, and trust—reported during interviews with scientists. The axis denotes the percentage of interviews in which the participant expressed the given emotion. We analyzed these emotions across the six most prominent scientific disciplines in our sample.

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F158146f808a8480ab382bd84499572ba7dabb209-2880x1800.jpg&w=3840&q=75)科学家访谈中报告的六大主要情绪——希望、满足、挫败、担忧、疑虑与信任——的强度分布图。纵轴表示在访谈中表达该情绪的受访者所占百分比。我们针对样本中最具代表性的六个科学学科分析了这些情绪。

![](images/introducing-anthropic-interviewer/img_021.jpg)Intensity of the top six emotions—hope, satisfaction, frustration, worry, doubt, and trust—reported during interviews with scientists. The axis denotes the percentage of interviews in which the participant expressed the given emotion. We analyzed these emotions across the six most prominent scientific disciplines in our sample.

![](images/introducing-anthropic-interviewer/img_021.jpg)科学家访谈中报告的六大主要情绪——希望、满足、挫败、担忧、疑虑与信任——的强度分布图。纵轴表示在访谈中表达该情绪的受访者所占百分比。我们针对样本中最具代表性的六个科学学科分析了这些情绪。

![](images/introducing-anthropic-interviewer/img_022.jpg)Intensity of the top six emotions—hope, satisfaction, frustration, worry, doubt, and trust—reported during interviews with scientists. The axis denotes the percentage of interviews in which the participant expressed the given emotion. We analyzed these emotions across the six most prominent scientific disciplines in our sample.

![](images/introducing-anthropic-interviewer/img_022.jpg)科学家访谈中报告的六大主要情绪——希望、满足、挫败、担忧、疑虑与信任——的强度分布图。纵轴表示在访谈中表达该情绪的受访者所占百分比。我们针对样本中最具代表性的六个科学学科分析了这些情绪。

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F59a65d3fb75628ffdb8ab3015a9a00384b230dc8-2880x1800.jpg&w=3840&q=75)Intensity of the top six emotions—hope, satisfaction, frustration, worry, doubt, and trust—reported during interviews with scientists. The axis denotes the percentage of interviews in which the participant expressed the given emotion. We analyzed these emotions across the six most prominent scientific disciplines in our sample.

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F59a65d3fb75628ffdb8ab3015a9a00384b230dc8-2880x1800.jpg&w=3840&q=75)科学家访谈中报告的六大主要情绪——希望、满足、挫败、担忧、疑虑与信任——的强度分布图。纵轴表示在访谈中表达该情绪的受访者所占百分比。我们针对样本中最具代表性的六个科学学科分析了这些情绪。

![](images/introducing-anthropic-interviewer/img_024.jpg)Intensity of the top six emotions—hope, satisfaction, frustration, worry, doubt, and trust—reported during interviews with scientists. The axis denotes the percentage of interviews in which the participant expressed the given emotion. We analyzed these emotions across the six most prominent scientific disciplines in our sample.

![](images/introducing-anthropic-interviewer/img_024.jpg)科学家访谈中报告的六大主要情绪——希望、满足、挫败、担忧、疑虑与信任——的强度分布图。纵轴表示在访谈中表达该情绪的受访者所占百分比。我们针对样本中最具代表性的六个科学学科分析了这些情绪。

![](images/introducing-anthropic-interviewer/img_025.jpg)Intensity of the top six emotions—hope, satisfaction, frustration, worry, doubt, and trust—reported during interviews with scientists. The axis denotes the percentage of interviews in which the participant expressed the given emotion. We analyzed these emotions across the six most prominent scientific disciplines in our sample.

![](images/introducing-anthropic-interviewer/img_025.jpg)科学家访谈中报告的六大主要情绪——希望、满足、挫败、担忧、疑虑与信任——的强度分布图。纵轴表示在访谈中表达该情绪的受访者所占百分比。我们针对样本中最具代表性的六个科学学科分析了这些情绪。

Most scientific fields reported high satisfaction, but with divergent frustration patterns: physicists and data scientists showed higher frustration, whereas chemical and mechanical engineers displayed minimal frustration.  
大多数科学领域均报告了较高的满意度，但挫折感模式存在明显差异：物理学家和数据科学家的挫折感较高，而化学工程师与机械工程师则表现出极低的挫折感。

This potentially reflects differences in how computational versus experimental fields attempt to integrate AI into core research workflows: scientists whose work requires real-world interaction might not yet be trying to use AI for their core scientific experimentation.  
这或许反映出计算型学科与实验型学科在将AI融入核心科研工作流时的不同路径：那些工作高度依赖真实世界交互的科学家，可能尚未尝试将AI用于其核心科学实验环节。

Trust remains relatively low across all fields, indicating widespread reliability concerns regardless of discipline.  
各学科领域的信任度普遍偏低，表明无论所属学科如何，研究者对AI的可靠性普遍存在广泛担忧。

Unlike creative professionals who express high levels of concern about AI’s impact, scientists show relatively low worry levels.  
与对AI影响表达高度关切的创意从业者不同，科学家整体忧虑水平相对较低。

This coheres with their stated frustrations regarding AI’s ability to complete hypothesis generation and experimentation tasks.  
这与其所陈述的挫败感相一致——即AI目前尚难以胜任假设生成与实验执行等关键科研任务。

Scientists didn’t, in general, fear job displacement due to AI.  
总体而言，科学家并不担心AI会导致自身岗位被取代。

Some pointed to tacit knowledge that resists digitization, with one microbiologist explaining: “I worked with one bacterial strain where you had to initiate various steps when the cells reached specific colors. The differences in color have to be seen to be understood and \[instructions are\] seldom written down anywhere.”  
一些人指出，存在难以数字化的默会知识（tacit knowledge）。一位微生物学家举例道：“我曾研究一种细菌菌株，需在细胞呈现特定颜色时启动不同操作步骤。颜色差异必须通过肉眼观察才能准确理解，而这类操作要领几乎从不以文字形式记录下来。”

Others emphasized the inherently human nature of research decision-making, with one bioengineer stating: “Experimentation and research is also… inherently up to me”, and noted that “certain parts of the research process are unfortunately just not compatible with AI even though they are the part that would be most convenient to automate, like running experiments”.  
另一些人则强调科研决策本质上是人类独有的活动。一位生物工程师表示：“实验与研究……本质上完全取决于我个人判断”，并指出：“研究流程中某些环节很遗憾地根本无法与AI兼容——尽管这些环节恰恰是最适合自动化的部分，比如实际开展实验。”

External constraints also created barriers to AI replacement—researchers in classified environments noted that “there are a lot of ‘do's and don'ts’ with lots of security-oriented processes that must be put in place before the organization can allow us to use agentic frameworks, and even LLMs for example.”  
外部约束同样构成了AI替代的障碍——从事涉密研究的科研人员指出：“存在大量‘可为’与‘不可为’的规定，组织必须先建立一系列以安全为导向的流程，才允许我们使用智能体框架（agentic frameworks），甚至像大语言模型（LLMs）这样的基础工具亦不例外。”

A mechanical engineer managing limited resources explained that, although “AI is good at coming up with an experimental design,” in reality “most of my research has budget/time/specimen limits so the ‘ideal’ design isn't always viable.”  
一位资源受限的机械工程师解释道：“尽管AI擅长提出实验设计方案，但现实中我的多数研究都面临预算、时间或样本数量的硬性限制，因此所谓‘理想’的设计方案并不总是可行。”

Nevertheless, regulatory compliance constraints, concerns about skill atrophy, and cost barriers were each brought up in less than 10% of interviews.  
然而，监管合规要求、技能退化担忧以及成本障碍等问题，在全部访谈中各自提及的比例均不足10%。

I would love an AI which could feel like a valuable research partner… that could bring something new to the table.  
我非常期待一款能成为真正有价值的科研伙伴的AI……它能为科研工作带来全新的视角与洞见。

91% of scientists expressed a desire for more AI assistance in their research, even if they didn’t feel today’s products fit the bill.  
91%的科学家表示希望在科研工作中获得更多的AI支持，即便他们认为当前的产品尚不能满足需求。

Roughly one-third envisioned assistance primarily with writing tasks, but the majority wanted support across all of their research: critiquing experimental design, accessing scientific databases, and running analyses.  
约三分之一的科学家主要期待AI辅助写作类任务；但大多数科学家则希望AI能覆盖整个科研流程——包括评估实验设计、检索科学数据库、执行数据分析等。

A common desire was for an AI that could produce new scientific ideas.  
一个普遍的愿望是：AI能够产出全新的科学构想。

One medical scientist said: “I wish AI could… help generate or support hypotheses or look for novel interactions/relationships that are not immediately evident for humans”.  
一位医学科学家表示：“我希望AI能够……协助生成或支撑科学假设，或主动发现那些人类难以直观察觉的新颖相互作用/关联。”

Another echoed this sentiment, saying: “I would love an AI which could feel like a valuable research partner… that could bring something new to the table.”  
另一位科学家呼应了这一观点，说道：“我非常期待一款能成为真正有价值的科研伙伴的AI……它能为科研工作带来全新的视角与洞见。”

## Looking forward  

## 展望未来  

This initial test demonstrated that Anthropic Interviewer shows promise at scale—we were able to conduct 1,250 interviews with a range of professionals to understand their feelings regarding AI at work.  
本次初步测试表明，Anthropic Interviewer 具备大规模应用潜力——我们成功对来自各行各业的专业人士开展了1,250场访谈，深入理解他们对AI在职场中应用的真实感受。

Research with this many participants would have been expensive and time-consuming with traditional “manual” interview methods.  
若采用传统“人工”访谈方式开展同等规模的研究，将耗费大量资金与时间。

But the significance of Anthropic Interviewer extends beyond methodology: it fundamentally shifts what questions we can ask and answer about AI’s role in society, and how interviews about any topic can happen at this new scale.  
但Anthropic Interviewer 的意义远不止于方法论层面：它从根本上重塑了我们所能提出与回答的问题范畴——关于AI在社会中扮演何种角色，以及任何主题的访谈如何以这种全新规模展开。

Our effort to conduct meaningful research at scale with Anthropic Interviewer is only just beginning.  
我们借助Anthropic Interviewer 开展大规模有意义研究的努力，才刚刚起步。

Previously, we only had insight into how people were using Claude within the chat window.  
过去，我们仅能了解用户如何在聊天窗口中使用Claude。

We didn't know how people _felt_ about using AI, what they _wanted to change_ about their interactions with the technology, or how they _envisioned AI's future role_ in their lives.  
我们并不清楚人们在使用AI时的**真实感受**、他们希望**改变哪些人机交互方式**，或他们如何**构想AI在未来生活中的角色**。

The findings from this initial survey provide us with new insights beyond our Economic Index work to understand how people are using AI in their workplace.  
本次初步调查的成果，为我们理解人们在职场中如何使用AI提供了超越“经济指数”（Economic Index）研究范畴的新洞见。

We are sharing these initial findings for discussion with our [Economic Advisory Council](https://www.anthropic.com/news/introducing-the-anthropic-economic-advisory-council) and [Higher Education Advisory Board](https://www.anthropic.com/news/anthropic-higher-education-initiatives).  
我们正将这些初步发现分享给我们的[经济咨询委员会](https://www.anthropic.com/news/introducing-the-anthropic-economic-advisory-council)与[高等教育咨询委员会](https://www.anthropic.com/news/anthropic-higher-education-initiatives)，以供深入研讨。

As we continue this research, we’ll publicly share our pilot results, along with how the findings inform our future work.  
随着研究持续推进，我们将公开发布试点成果，并说明这些发现将如何指导我们后续的工作方向。

Anthropic Interviewer is our latest step to center human voices in the conversation about the development of AI models—something we began with our work on [Collective Constitutional AI](https://www.anthropic.com/research/collective-constitutional-ai-aligning-a-language-model-with-public-input), which gathered public perspectives to shape Claude’s behavior.  
Anthropic Interviewer 是我们最新一步举措，旨在让人类声音真正成为AI模型发展对话的核心——这一理念始于我们关于[集体宪法式AI](https://www.anthropic.com/research/collective-constitutional-ai-aligning-a-language-model-with-public-input)（Collective Constitutional AI）的研究，该研究通过收集公众意见来塑造Claude的行为准则。

These conversations can help us improve the character and training process of Claude itself as well as inform future policies that Anthropic champions and adopts.  
这些对话有助于我们优化Claude自身的性格特质与训练流程，同时为Anthropic倡导并采纳的未来政策提供重要依据。

Below are some of the practical steps we’ve taken to explore partnerships with specific communities, helping us develop AI informed by their expertise:  
以下是我们为探索与特定社群合作而采取的部分务实举措，旨在借助他们的专业智慧，推动更富洞见的AI研发：

- **Creatives.** We’re supporting the development of exhibitions, workshops, and events to understand how AI is augmenting creativity. We have partnerships with leading cultural institutions including the [LAS Art Foundation](https://www.las-art.foundation/programme/pierre-huyghe), [Mori Art Museum](https://www.mori.art.museum/jp/index.html), and [Tate](https://www.tate.org.uk/whats-on/tate-modern/electric-dreams), and creative communities such as [Rhizome](https://rhizome.org/events/rhizome-presents-vibe-shift/) and [Socratica](https://www.socratica.info/). In addition, we are collaborating with the companies behind popular creative tools to explore how Claude can augment creatives’ work via the [Model Context Protocol](https://www.anthropic.com/news/model-context-protocol).  
- **创意工作者。** 我们正支持各类展览、工作坊及活动的开发，以深入理解人工智能如何增强人类创造力。我们已与多家顶尖文化机构建立合作，包括[LAS艺术基金会](https://www.las-art.foundation/programme/pierre-huyghe)、[森美术馆](https://www.mori.art.museum/jp/index.html)和[泰特美术馆](https://www.tate.org.uk/whats-on/tate-modern/electric-dreams)，以及[Rhizome](https://rhizome.org/events/rhizome-presents-vibe-shift/)和[Socratica](https://www.socratica.info/)等富有活力的创意社群。此外，我们正与多款广受欢迎的创意工具背后的公司协作，探索Claude如何借助[模型上下文协议（Model Context Protocol）](https://www.anthropic.com/news/model-context-protocol)赋能创意工作者。

- **Scientists.** We’re partnering with our [AI for Science grantees](https://www.anthropic.com/news/ai-for-science-program) to understand how AI can best serve their research. Using Anthropic Interviewer, we’re gathering scientists’ perspectives on AI and their hopes for the program (we’ll also use our privacy-preserving analysis tool to assess whether their Claude conversations align with these expectations). Combining quantitative and qualitative data will help us both improve Claude for scientists and measure the impacts of our grants.  
- **科研人员。** 我们正与[“AI for Science”项目资助对象](https://www.anthropic.com/news/ai-for-science-program)合作，探究人工智能如何最有效地服务于其科研工作。借助Anthropic Interviewer，我们正在收集科学家对AI的看法及其对该项目的期待（同时，我们还将运用隐私保护型分析工具，评估他们与Claude的对话是否契合这些期待）。通过融合定量与定性数据，我们既能持续优化Claude在科研场景中的表现，也能科学衡量资助项目的实际影响。

- **Teachers.** We’ve [recently partnered](https://www.aft.org/press-release/aft-launch-national-academy-ai-instruction-microsoft-openai-anthropic-and-united) with the American Federation of Teachers (AFT) to reshape teacher training in an age of increasingly capable AI. This program aims to support 400,000 teachers in AI education and introduce their perspective in the development of AI systems. In addition, we previewed some findings from Anthropic Interviewer regarding how AI is transforming software engineering at Anthropic. Sharing qualitative stories about our own workplace transformation led us to find much common ground between software engineers and teachers, bringing everyone together at the same table to brainstorm what kinds of AI induced work transformations we actually want.  
- **教育工作者。** 我们已[近期携手](https://www.aft.org/press-release/aft-launch-national-academy-ai-instruction-microsoft-openai-anthropic-and-united)美国教师联合会（AFT），共同重塑AI能力日益增强背景下的教师培训体系。该项目旨在支持40万名教师开展AI教育，并将一线教师的视角纳入AI系统的设计与开发过程。此外，我们还初步分享了Anthropic Interviewer关于AI如何重塑Anthropic内部软件工程实践的部分调研发现。通过分享自身职场转型的定性故事，我们发现软件工程师与教师之间存在诸多共通之处——这促使双方齐聚一堂，共同探讨：我们真正希望由AI驱动的工作方式变革究竟应为何种形态？

Using Anthropic Interviewer, we can conduct targeted research that informs specific policies, participatory research that involves different communities in conversations about AI, and regular studies that track the evolving relationship between humans and AI.  
借助Anthropic Interviewer，我们可开展三类研究：一是聚焦特定议题的定向研究，为具体政策制定提供依据；二是包容多元社群参与的协作式研究，推动社会各界围绕AI展开深度对话；三是周期性开展的追踪研究，持续记录人与AI关系的动态演进。

### Take part  
### 参与调研  

We are continuing to use Anthropic Interviewer to better understand how people envision AI’s role in their lives and work. To that end, we are launching a public pilot interview, exploring what experiences, values and needs drive people’s vision for AI’s future role in their lives.  
我们正持续运用Anthropic Interviewer，以更深入地理解公众如何看待AI在其生活与工作中所应扮演的角色。为此，我们正式启动一项面向公众的试点访谈，重点探究哪些亲身经历、核心价值与现实需求，正在塑造人们对于AI未来角色的构想。

**Ready to share your perspective?** You can participate in a 10–15 minute interview at [this link](http://claude.ai/redirect/website.v1.027b498d-e1f8-4e85-aef7-b109dbd4c9f4/interviewer) to take part in this research. We plan to analyze the anonymized insights from this study as part of our societal impacts research and publish a report on insights from this data. For more information on this study, please see the FAQ section below.  
**您是否愿意分享您的见解？** 欢迎点击[此链接](http://claude.ai/redirect/website.v1.027b498d-e1f8-4e85-aef7-b109dbd4c9f4/interviewer)，用10–15分钟参与本次调研。我们将对本次调研所获的匿名化洞察进行分析，并将其纳入社会影响研究范畴，最终形成一份专题报告予以公开发布。如需了解本项研究的更多详情，请参阅下方常见问题（FAQ）部分。

## Conclusions and limitations  
## 结论与局限性  

Our interviews with 1,250 professionals reveal a workforce actively negotiating its relationship with AI. Our participants generally preserved tasks central to their professional identity while delegating routine work for productivity gains. Creatives embraced AI’s efficiency despite peer stigma and economic anxieties, while scientists remained selective about which research tasks they entrusted to AI.  
我们对1,250名专业人士的访谈揭示：当前职场人群正积极地与AI重新协商彼此关系。受访者普遍选择保留那些关乎其职业身份的核心任务，而将常规性工作交由AI处理以提升效率。创意工作者虽面临同行偏见与经济焦虑，仍欣然接纳AI带来的效率提升；而科研人员则对可托付给AI的研究任务保持高度审慎与选择性。

We conducted this research to understand AI’s impact on people’s lives beyond what happens in the chat window. Like all qualitative analysis, our interpretation of these interviews reflects the questions we chose to ask and the patterns we looked for in the data. By making this large-scale dataset of interview transcripts publicly available, we hope to advance collective understanding of how human-AI relationships are evolving. And by deploying Anthropic Interviewer at scale, we can create a feedback loop between what people experience with AI and how we develop it—with the goal of building AI systems that reflect public perspectives and needs.  
本研究旨在超越聊天窗口内的交互，深入理解AI对人们生活的广泛影响。与所有定性分析一样，我们对访谈内容的解读，不可避免地受到所设问题及所关注数据模式的影响。通过向公众开放这一大规模访谈转录文本数据集，我们期望推动全社会对人机关系演进路径的共同认知；而通过规模化部署Anthropic Interviewer，我们亦能构建起“用户真实体验—AI系统研发”的双向反馈闭环，最终实现以公众视角与切实需求为导向的AI系统建设目标。

### Limitations  
### 局限性  

Our initial use of Anthropic Interviewer has some important limitations that affect the scope and generalizability of our findings. Our findings should be interpreted as early signals of AI’s impact on work, rather than definitive conclusions about its long-term effects on professional practice and identity.  
Anthropic Interviewer的初期应用存在若干重要局限，影响了本研究发现的适用范围与普适性。因此，我们的研究结果应被视作AI对工作产生影响的早期信号，而非对其长期作用于专业实践与职业认同的确定性结论。

- _Selection bias._ Because they were engaged through crowdworker platforms, the experiences of the participants in our study might differ significantly from those of the general workforce, biasing responses toward more positive or experienced perspectives on the subject.  
- _选择偏差（Selection bias）_：由于参与者是通过众包工作者平台招募的，其经历可能与整体劳动力群体存在显著差异，从而导致受访者的回答偏向于更积极或更具经验的观点。

- _Demand characteristics._ Participants knew they were being interviewed by an AI system about their AI usage, which could have changed their willingness to engage, or changed the kinds of responses they gave compared to an interview with a human.  
- _需求特征（Demand characteristics）_：参与者知晓自己正接受一个AI系统关于其AI使用情况的访谈，这可能影响其参与意愿，或使其回应方式不同于面对人类访谈者时的表现。

- _Static analysis._ We captured a snapshot of professionals’ current AI usage and attitudes, but with these data, we can’t track how these relationships develop over time, or how initial enthusiasm might change with extended use.  
- _静态分析（Static analysis）_：我们仅捕捉了专业人士当前AI使用状况与态度的“快照”，但凭借这些数据，无法追踪此类关系随时间的演变过程，也无法判断初始热情是否会随着长期使用而发生变化。

- _Emotional analysis._ As Anthropic Interview is text-only and can’t read tone of voice, facial expressions, or body language, it might miss emotional cues that affect the meaning of our interviewee’s statements.  
- _情感分析（Emotional analysis）_：由于Anthropic Interview为纯文本交互，无法识别语调、面部表情或肢体语言，因此可能遗漏影响受访者陈述含义的情感线索。

- _Self-report versus objective measures._ We noted above that participants’ descriptions of their AI usage might differ from their actual practices (as has been found to be [the case](https://www.sciencedirect.com/science/article/pii/S277250302300021X) for [smartphone use](https://www.sciencedirect.com/science/article/pii/S2451958824002021)). This could be due to social desirability bias, imperfect recall, or evolving workplace norms around AI disclosure.  
- _自我报告 vs. 客观测量（Self-report versus objective measures）_：如前所述，参与者对其AI使用行为的描述可能与其实际行为存在差异（类似研究已在[智能手机使用](https://www.sciencedirect.com/science/article/pii/S2451958824002021)领域被证实，参见[此处](https://www.sciencedirect.com/science/article/pii/S277250302300021X)）。这种差异可能源于社会期许偏差（social desirability bias）、记忆不准确，或职场中围绕AI披露所形成的动态规范。

  - Indeed, our interview data revealed key discrepancies when compared with real usage data. This gap between perception and practice reinforces the inherent ambiguity in self-reports: for example, interview responses may capture aspirational usage or social desirability effects. Understanding these discrepancies will be crucial for interpreting the findings in this kind of research.  
  - 实际上，将我们的访谈数据与真实使用数据对比后，发现了若干关键差异。这种“认知”与“实践”之间的鸿沟，进一步凸显了自我报告固有的模糊性：例如，访谈回应可能反映的是理想化使用场景，或受到社会期许效应的影响。理解这些差异，对解读此类研究的发现至关重要。

- _Researcher interpretation._ Like all qualitative research, our analysis reflects our own interests and perspectives as researchers. Although we used systematic methods to identify patterns, different researchers might emphasize different aspects of these interviews or draw alternative conclusions.  
- _研究者解释（Researcher interpretation）_：如同所有质性研究一样，我们的分析不可避免地反映了我们自身作为研究者的兴趣与立场。尽管我们采用了系统性方法识别模式，但不同研究者仍可能关注访谈中不同的侧面，或得出相异的结论。

- _Global generalizability_. Our sample primarily reflects Western-based workers, and cultural attitudes toward AI, workplace dynamics, and professional identity likely vary significantly across global contexts.  
- _全球普适性（Global generalizability）_：本研究样本主要代表西方国家的从业者，而不同文化背景下人们对AI的态度、职场互动模式及职业身份认同可能存在显著差异。

- _Non-experimental research._ Although many participants reported productivity gains and quality improvements, we cannot determine whether AI usage directly _caused_ these outcomes or the extent to which other factors contributed.  
- _非实验性研究（Non-experimental research）_：尽管许多参与者报告了生产力提升与工作质量改善，但我们无法确定AI使用是否直接*导致*了这些结果，亦无法评估其他因素在其中所起的作用程度。

## Contributions and acknowledgements  
## 贡献与致谢  

Kunal Handa led the project, designed and prototyped Anthropic Interviewer, executed the surveys, interviews, and data analysis, plotted figures, and wrote the blog post. Michael Stern led the implementation of Anthropic Interviewer within [Claude.ai](http://claude.ai/redirect/website.v1.027b498d-e1f8-4e85-aef7-b109dbd4c9f4), managed the project timeline, and provided feedback throughout. Saffron Huang led the public pilot of Anthropic Interviewer. Jerry Hong led the visual design of Anthropic Interviewer and contributed to technical figures. Esin Durmus contributed to experimental design and provided key feedback. Miles McCain co-led implementation of technical infrastructure underlying prototypes of Anthropic Interviewer. Grace Yun, AJ Alt, and Thomas Millar implemented Anthropic Interviewer within [Claude.ai](http://claude.ai/redirect/website.v1.027b498d-e1f8-4e85-aef7-b109dbd4c9f4) and provided the technical infrastructure necessary for the public pilot. Alex Tamkin provided key feedback on early iterations of the project. Jane Leibrock contributed to all methodology for Anthropic Interviewer. Stuart Ritchie contributed to the framing and writing of the blog post. Deep Ganguli provided critical research guidance, feedback, and organizational support. All authors provided detailed guidance and feedback throughout.  
Kunal Handa 主导本项目，设计并构建了 Anthropic Interviewer 的原型，执行了问卷调查、访谈与数据分析，绘制图表，并撰写了本篇博客文章。Michael Stern 主导 Anthropic Interviewer 在 [Claude.ai](http://claude.ai/redirect/website.v1.027b498d-e1f8-4e85-aef7-b109dbd4c9f4) 平台上的工程实现，统筹项目时间线，并全程提供反馈。Saffron Huang 主导 Anthropic Interviewer 的公开试点。Jerry Hong 主导 Anthropic Interviewer 的视觉设计，并参与技术图表制作。Esin Durmus 参与实验设计并提供了关键反馈。Miles McCain 共同主导支撑 Anthropic Interviewer 原型的技术基础设施建设。Grace Yun、AJ Alt 与 Thomas Millar 在 [Claude.ai](http://claude.ai/redirect/website.v1.027b498d-e1f8-4e85-aef7-b109dbd4c9f4) 平台上实现了 Anthropic Interviewer，并为公开试点提供了必要的技术基础设施。Alex Tamkin 就项目的早期版本提供了关键反馈。Jane Leibrock 全程参与 Anthropic Interviewer 的方法论设计。Stuart Ritchie 协助完成博客文章的整体框架搭建与文字撰写。Deep Ganguli 提供了关键的研究指导、反馈与组织支持。全体作者均在项目全过程提供了详尽的指导与反馈。

Additionally, we thank Sally Aldous, Drew Bent, Shan Carter, Jack Clark, Miriam Chaum, Jake Eaton, Matt Galivan, Savina Hawkins, Sarah Heck, Hanah Ho, Mo Julapalli, Matthew Kearney, Mike Krieger, Chelsea Larsson, Joel Lewenstein, Jennifer Martinez, Wes Mitchell, Jared Mueller, Christopher Nulty, Adam Pearce, Sarah Pollack, Ankur Rathi, Drew Roper, David Saunders, Kevin Troy, Molly Villagra, Brett Wittmershaus, and Casey Yamaguma for their helpful ideas, discussion, feedback, and support. We also appreciate the comments, discussion, and feedback from Matthew Conlen, Deb Roy, and Diyi Yang.  
此外，我们衷心感谢 Sally Aldous、Drew Bent、Shan Carter、Jack Clark、Miriam Chaum、Jake Eaton、Matt Galivan、Savina Hawkins、Sarah Heck、Hanah Ho、Mo Julapalli、Matthew Kearney、Mike Krieger、Chelsea Larsson、Joel Lewenstein、Jennifer Martinez、Wes Mitchell、Jared Mueller、Christopher Nulty、Adam Pearce、Sarah Pollack、Ankur Rathi、Drew Roper、David Saunders、Kevin Troy、Molly Villagra、Brett Wittmershaus 和 Casey Yamaguma 提出的宝贵想法、深入讨论、建设性反馈与鼎力支持。我们同样感谢 Matthew Conlen、Deb Roy 与 Diyi Yang 所提供的评论、讨论与反馈。

## Citation  
## 引用格式  

If you’d like to cite this post you can use the following Bibtex key:  
如需引用本文，请使用以下 BibTeX 条目：

```
@online{handa2025interviewer,
author = {Kunal Handa and Michael Stern and Saffron Huang and Jerry Hong and Esin Durmus and Miles McCain and Grace Yun and AJ Alt and Thomas Millar and Alex Tamkin and Jane Leibrock and Stuart Ritchie and Deep Ganguli},
title = {Introducing Anthropic Interviewer: What 1,250 professionals told us about working with AI},
date = {2025-12-04},
year = {2025},
url = {https://anthropic.com/research/anthropic-interviewer},
}
```

Copy  

## Appendix  
## 附录  

### Participant experience with Anthropic Interviewer  
### 参与者使用 Anthropic Interviewer 的体验

After the interviews, we surveyed participants on their interview experience. We asked: (1) _How satisfied were you with this conversation?_, (2) _How well did this conversation capture your thoughts on {the domain}?_ (both on a 1-7 Likert scale), and (3) _Would you recommend this interview format to others?_ (yes/no).

访谈结束后，我们对参与者就其访谈体验开展了问卷调查。问题包括：(1) 您对本次对话的满意度如何？；(2) 本次对话在多大程度上准确反映了您对{该领域}的看法？（两项均采用1–7级李克特量表）；以及(3) 您是否会向他人推荐这种访谈形式？（是/否）。

We found that participants were remarkably positive about Anthropic Interviewer. 97.6% of participants rated their satisfaction as 5 or higher, with 49.6% giving the highest rating. Similarly, 96.96% felt the conversation captured their thoughts well (5-7 rating). 99.12% of participants said they would recommend this interview format to others.

我们发现，参与者对 Anthropic Interviewer 的评价极为积极：97.6% 的参与者给出的满意度评分为 5 分或更高，其中 49.6% 给出了最高分（7 分）；同样，96.96% 的参与者认为本次对话较好地捕捉了他们的想法（评分为 5–7 分）；99.12% 的参与者表示愿意向他人推荐这一访谈形式。

## Sharing your perspective: FAQ

## 分享您的观点：常见问题解答

**1\. How do we access the study?**

**1. 我们如何参与本研究？**

Starting today, if you are a Free, Pro, or Max Claude.ai subscriber who signed up prior to two weeks ago, you might notice a pop-up in Claude.ai asking you to participate. You can access it at: [https://claude.ai/interviewer](https://claude.ai/redirect/website.v1.027b498d-e1f8-4e85-aef7-b109dbd4c9f4/interviewer). The study will be open for a week.

即日起，若您是两周前已注册的 Claude.ai 免费版、Pro 版或 Max 版订阅用户，您可能会在 Claude.ai 界面中看到弹出提示，邀请您参与本研究。您可通过以下链接访问：[https://claude.ai/interviewer](https://claude.ai/redirect/website.v1.027b498d-e1f8-4e85-aef7-b109dbd4c9f4/interviewer)。本研究将持续开放一周。

**2\. What will this study ask me?**

**2. 本研究将向我提出哪些问题？**

We will use Anthropic Interviewer to ask you about your vision for AI's role in your life, what experiences, values, and needs shape this, as well as what might help or hinder that vision.

我们将通过 Anthropic Interviewer 向您了解：您对人工智能在自身生活中所扮演角色的愿景；塑造这一愿景的个人经历、价值观与实际需求；以及可能助力或阻碍该愿景实现的因素。

**3\. How will you use the data?**

**3. 您将如何使用所收集的数据？**

We will analyze the insights from this study as part of our Societal Impacts research, publish our findings, and use this to improve our models and services in a way that reflects what we've learned. The data we collect through this study will be treated as Feedback and will be processed according to our [Privacy Policy](https://www.anthropic.com/legal/privacy). We may also include anonymized responses in published findings. [**Learn more.**](https://privacy.claude.com/en/articles/12996960-how-does-anthropic-interviewer-collect-and-use-my-data)

我们将把本研究所得洞见纳入“社会影响”（Societal Impacts）研究项目进行分析，公开发布研究成果，并据此优化我们的模型与服务，使其切实反映研究中获得的见解。本研究中收集的所有数据将被归类为“用户反馈”（Feedback），并严格依据我们的[隐私政策](https://www.anthropic.com/legal/privacy)进行处理。此外，我们还可能在公开发布的成果中使用经匿名化处理的用户应答内容。[**了解更多。**](https://privacy.claude.com/en/articles/12996960-how-does-anthropic-interviewer-collect-and-use-my-data)

**4\. Why don’t I see the Anthropic Interviewer invitation in [Claude.ai](http://claude.ai/redirect/website.v1.027b498d-e1f8-4e85-aef7-b109dbd4c9f4)?**

**4. 为什么我在 [Claude.ai](http://claude.ai/redirect/website.v1.027b498d-e1f8-4e85-aef7-b109dbd4c9f4) 中没有看到 Anthropic Interviewer 的邀请？**

The interview is only available for existing [Claude.ai](http://claude.ai/redirect/website.v1.027b498d-e1f8-4e85-aef7-b109dbd4c9f4) Free, Pro, and Max users who signed up 2+ weeks ago.

该访谈仅面向已注册满两周及以上的现有 [Claude.ai](http://claude.ai/redirect/website.v1.027b498d-e1f8-4e85-aef7-b109dbd4c9f4) 免费版、Pro 版和 Max 版用户。

_If you have questions, reach out via the message icon in the lower right corner of our [Help Center](https://links.email.claude.com/s/c/cGkT1SXSNgcdo1m1Jg5ubLKEl9K6sdfmpEYqg1hKZUyGgcl4dwPfeO18GyKSSqXjh6VJYoL1jUZK6AD2BWJz4p6OxoEug7KO9W2Yl7UuTqBou7dHkuDUR9lSrGIwoWBHBu-wkEktomJDbUAT2u8a6E6foGoE2H3RIurvO9epWQ7AJsKe_0FNVxLk4ygbQL3j7y1jjTEiC2qM5p0y1YCjCVAFED8I6wYqldfi9BKBYq993W-nOs45JbAMQkT6sZUFTHhEwJTV__gENvsItJqLkEOWFL9lrz48UJTC33i6n3SqYgI6stnpAsjLF66P_qtdOX888L-0h2qzKpxlrtGvrvuqEtl5pLNkPQUulHsITd7MyVL3tf-Ubi3dJVc1h9rB7v04z5j16n5-Kbp-iwCpz3RIbNot86fAZNPdfMqyBxFRDZlAUH-iEQ7h8wY1x6k8mnegW7y77GhLsqTJiZxqIi9o511wHl1Ltu-XLpeOVd80/ql5MQfX8py3XUgI4Usb8PWvj6gyGGxly/16)._

_如您有任何疑问，请通过我们的 [帮助中心](https://links.email.claude.com/s/c/cGkT1SXSNgcdo1m1Jg5ubLKEl9K6sdfmpEYqg1hKZUyGgcl4dwPfeO18GyKSSqXjh6VJYoL1jUZK6AD2BWJz4p6OxoEug7KO9W2Yl7UuTqBou7dHkuDUR9lSrGIwoWBHBu-wkEktomJDbUAT2u8a6E6foGoE2H3RIurvO9epWQ7AJsKe_0FNVxLk4ygbQL3j7y1jjTEiC2qM5p0y1YCjCVAFED8I6wYqldfi9BKBYq993W-nOs45JbAMQkT6sZUFTHhEwJTV__gENvsItJqLkEOWFL9lrz48UJTC33i6n3SqYgI6stnpAsjLF66P_qtdOX888L-0h2qzKpxlrtGvrvuqEtl5pLNkPQUulHsITd7MyVL3tf-Ubi3dJVc1h9rB7v04z5j16n5-Kbp-iwCpz3RIbNot86fAZNPdfMqyBxFRDZlAUH-iEQ7h8wY1x6k8mnegW7y77GhLsqTJiZxqIi9o511wHl1Ltu-XLpeOVd80/ql5MQfX8py3XUgI4Usb8PWvj6gyGGxly/16) 右下角的消息图标联系我们。_