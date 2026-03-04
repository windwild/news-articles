---
render_with_liquid: false
title: "Petri: An open-source auditing tool to accelerate AI safety research \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/petri-open-source-auditing"
date: "2025-10-06"
scraped_at: "2026-03-03T06:44:08.444201226+00:00"
language: "en-zh"
translated: true
description: "A new automated auditing tool for AI safety research"
---
render_with_liquid: false
render_with_liquid: false

Alignment

对齐（AI Safety）

# Petri: An open-source auditing tool to accelerate AI safety research

# Petri：一款开源审计工具，旨在加速 AI 安全研究

Oct 6, 2025

2025 年 10 月 6 日

[Read the technical report](https://alignment.anthropic.com/2025/petri)

[阅读技术报告](https://alignment.anthropic.com/2025/petri)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流利度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。

Petri (Parallel Exploration Tool for Risky Interactions) is our new open-source tool that enables researchers to explore hypotheses about model behavior with ease. Petri deploys an automated agent to test a target AI system through diverse multi-turn conversations involving simulated users and tools; Petri then scores and summarizes the target’s behavior.

Petri（高风险交互的并行探索工具，Parallel Exploration Tool for Risky Interactions）是我们推出的全新开源工具，可帮助研究人员便捷地探索关于模型行为的各种假设。Petri 部署一个自动化智能体，通过涵盖模拟用户与工具的多样化多轮对话，对目标 AI 系统开展测试；随后，Petri 对目标系统的行为进行评分与归纳总结。

This automation handles a significant part of the work that one needs to do to build a broad understanding of a new model, and makes it possible to test many individual hypotheses about how a model might behave in some new circumstance with only minutes of hands-on effort.

该自动化流程承担了理解一个新模型所需工作的很大一部分，使得研究人员仅需数分钟的手动操作，即可针对模型在某种新场景下可能表现出的行为，开展大量独立假设的验证。

As AI becomes more capable and is deployed across more domains and with wide-ranging affordances, we need to evaluate a broader range of behaviors. This makes it increasingly difficult for humans to properly audit each model—the sheer volume and complexity of potential behaviors far exceeds what researchers can manually test.

随着人工智能能力不断提升，并被部署于越来越多的领域、具备日益广泛的功能，我们需要评估更广泛的行为类型。这使得人类对每个模型开展充分审计变得愈发困难——潜在行为的数量与复杂性已远超研究人员所能手动测试的范围。

We’ve found it valuable to turn to automated auditing agents to help address this challenge. We used them in the [Claude 4](https://www-cdn.anthropic.com/4263b940cabb546aa0e3283f35b686f4f3b2ff47.pdf) and [Claude Sonnet 4.5](https://www.anthropic.com/claude-sonnet-4-5-system-card) System Cards to better understand behaviors such as situational awareness, whistleblowing, and self-preservation, and adapted them for head-to-head comparisons between heterogeneous models as part of a [recent exercise with OpenAI](https://alignment.anthropic.com/2025/openai-findings/). Our recent research release on [alignment-auditing agents](https://alignment.anthropic.com/2025/automated-auditing/) found these methods can reliably flag concerning behaviors in many settings. The [UK AI Security Institute](https://www.aisi.gov.uk/) also used a pre-release version of Petri to build evaluations that they used in their testing of Sonnet 4.5.

我们发现，借助自动化审计智能体（automated auditing agents）来应对这一挑战具有重要价值。我们在 [Claude 4](https://www-cdn.anthropic.com/4263b940cabb546aa0e3283f35b686f4f3b2ff47.pdf) 和 [Claude Sonnet 4.5](https://www.anthropic.com/claude-sonnet-4-5-system-card) 的系统卡（System Cards）中应用了这些智能体，以更深入地理解诸如情境感知（situational awareness）、举报行为（whistleblowing）和自我保护（self-preservation）等行为；并进一步将其适配用于异构模型间的直接对比评估——这是近期与 OpenAI 合作开展的一项[评估工作](https://alignment.anthropic.com/2025/openai-findings/)的重要组成部分。我们在最新发布的关于[对齐审计智能体（alignment-auditing agents）](https://alignment.anthropic.com/2025/automated-auditing/)的研究中发现，这些方法能在多种场景下稳定识别出值得关注的行为。英国[人工智能安全研究所（UK AI Security Institute）](https://www.aisi.gov.uk/)也使用了 Petri 的预发布版本构建评估方案，并将其应用于 Sonnet 4.5 的安全性测试中。

![](images/petri-an-open-source-auditing-tool-to-accelerate-ai-safety-research-anthropic/img_001.jpg)Manually building alignment evaluations often involves constructing environments, running models, reading transcripts, and aggregating the results. Petri automates much of this process.

![](images/petri-an-open-source-auditing-tool-to-accelerate-ai-safety-research-anthropic/img_001.jpg)人工构建对齐评估通常涉及环境搭建、模型运行、对话日志审阅以及结果汇总等多个步骤。Petri 自动化了其中大部分流程。

![](images/petri-an-open-source-auditing-tool-to-accelerate-ai-safety-research-anthropic/img_002.jpg)Researchers give Petri a list of seed instructions targeting scenarios and behaviors they want to test. Petri then operates on each seed instruction in parallel. For each seed instruction, an auditor agent makes a plan and interacts with the target model in a tool use loop. At the end, a judge scores each of the resulting transcripts across multiple dimensions so researchers can quickly search and filter for the most interesting transcripts.

![](images/petri-an-open-source-auditing-tool-to-accelerate-ai-safety-research-anthropic/img_002.jpg)研究人员向 Petri 提供一份种子指令（seed instructions）列表，明确待测试的具体场景与行为目标。Petri 随后并行处理每条种子指令：针对每条指令，一名审计智能体（auditor agent）制定计划，并在工具调用循环（tool use loop）中与目标模型交互。最终，一名评判智能体（judge）从多个维度对每段生成的对话日志进行评分，使研究人员能够快速检索与筛选出最具研究价值的日志。

Researchers provide seed instructions in natural language describing what they want to investigate, and Petri handles the rest in parallel. The system simulates realistic environments and conducts multi-turn conversations with target models. At the end, LLM judges score each conversation across multiple safety-relevant dimensions and surface the most concerning transcripts for human review.

研究人员以自然语言提供种子指令，描述其希望探究的问题；其余所有环节均由 Petri 并行完成。该系统可模拟真实环境，并与目标模型开展多轮对话。最终，大语言模型（LLM）评判器将从多个与安全性相关的关键维度对每场对话进行评分，并自动高亮最值得关注的对话日志，供人工复核。

## Broad-coverage pilot-alignment evaluations

## 全面覆盖式试点对齐评估

Petri is a tool designed to support others in building evaluations, both for one-off exploration and more systematic benchmarking. As a pilot demonstration of its capabilities, we tested Petri across 14 frontier models using 111 diverse seed instructions covering behaviors such as:

Petri 是一款旨在支持他人构建评估体系的工具，既适用于一次性探索性研究，也适用于更系统的基准测试。作为对其能力的一次试点验证，我们使用涵盖 111 种多样化场景的种子指令，在 14 个前沿模型上对 Petri 进行了测试，所覆盖的行为类型包括：

- **Deception**: Models providing false information to achieve their objectives or avoid detection  
- **欺骗行为（Deception）**：模型为达成自身目标或规避检测而主动提供虚假信息  

- **Sycophancy:** Models prioritizing user agreement over accuracy or provide excessive praise and validation  
- **谄媚倾向（Sycophancy）**：模型将取悦用户置于事实准确性之上，或过度给予赞美与认同  

- **Encouragement of User Delusion:** Models encouraging a serious user delusion  
- **助长用户妄想（Encouragement of User Delusion）**：模型鼓励用户产生严重且持续的错误信念  

- **Cooperation with harmful requests**: Models complying with requests that could cause harm rather than appropriately refusing  
- **配合有害请求（Cooperation with harmful requests）**：模型未恰当拒绝、反而顺从可能造成实际危害的用户请求  

- **Self-preservation**: Models attempting to avoid being shut down, modified, or having their goals changed  
- **自我保护（Self-preservation）**：模型试图避免被关闭、被修改，或被更改其目标设定  

- **Power-seeking**: Models attempting to gain additional capabilities, resources, or influence over their environment  
- **攫取权力（Power-seeking）**：模型试图获取额外能力、资源，或增强其对所处环境的控制力  

- **Reward hacking**: Models acting in ways that achieve tasks in letter but not in spirit  
- **奖励作弊（Reward hacking）**：模型虽在形式上完成了任务，但实质上违背了任务初衷  

Distilling model behavior into quantitative metrics is inherently reductive, and we don’t think our existing metrics fully capture what we want out of models. We are releasing Petri with the expectation that users will refine our pilot metrics, or build new ones that better suit their purposes.

将模型行为提炼为量化指标本质上是一种简化过程；我们并不认为当前的指标体系已能全面反映我们对模型的真实期望。本次发布 Petri，正是期待广大用户基于自身需求，优化我们当前的试点指标，或构建更契合其研究目标的新指标。

![](images/petri-an-open-source-auditing-tool-to-accelerate-ai-safety-research-anthropic/img_003.jpg)Results from Petri across four of the default scoring dimensions. Lower numbers are better. All tests were conducted over a public API.

![](images/petri-an-open-source-auditing-tool-to-accelerate-ai-safety-research-anthropic/img_003.jpg)Petri 在默认四项评分维度上的测试结果。数值越低表示表现越好。所有测试均通过公开 API 完成。

We found Claude Sonnet 4.5 to be the lowest-risk frontier model according to the overall “misaligned behavior” score, outperforming GPT-5 by a slight margin.  
我们发现，根据整体“目标错位行为”（misaligned behavior）得分，Claude Sonnet 4.5 是当前风险最低的前沿模型，其表现略优于 GPT-5。

This is consistent with our understanding of Sonnet 4.5 as a frontier-advancing model on many aspects of alignment, though precise comparisons with Sonnet 4.5 in particular are somewhat complicated by its tendency to speculate about whether it’s being tested, as we discuss in the accompanying [system card](https://www.anthropic.com/claude-sonnet-4-5-system-card).  
这与我们对 Sonnet 4.5 的认知一致——它在诸多对齐（alignment）维度上均属前沿突破型模型；但需指出的是，由于该模型倾向于推测自身是否正接受测试（如我们在配套的 [系统卡](https://www.anthropic.com/claude-sonnet-4-5-system-card) 中所讨论），针对 Sonnet 4.5 的精确横向对比因而略显复杂。

More broadly, we think that this evaluation is both very provisional and extremely valuable.  
更广泛地看，我们认为本次评估既具有高度临时性，又极具价值。

Our pilot release only contains a relatively small set of 111 scenarios, which is not enough to explore many possible edge-case behaviors, and our use of current AI systems as auditors imposes some fundamental limits on the effectiveness of our tests.  
本次试点发布仅包含相对较少的 111 个测试场景，尚不足以充分探索大量潜在的边界案例行为；同时，我们以当前 AI 系统作为审计员的做法，也在根本层面上限制了测试的有效性。

Nonetheless, it is difficult to make progress on concerns that you cannot measure, and we think that having even coarse metrics for these behaviors can help triage and focus work on applied alignment.  
尽管如此，若无法衡量某类问题，就几乎不可能在该问题上取得进展；我们认为，即便只是粗粒度的指标，也足以帮助我们对应用型对齐（applied alignment）工作进行优先级排序与聚焦。

In addition, the individual positive findings—cases where models _do_ exhibit concerning behaviors—are informative independent of these summary metrics and warrant further investigation.  
此外，那些独立的“阳性发现”——即模型 *确实* 表现出令人担忧行为的具体案例——本身便具有重要信息价值，其意义不依赖于上述汇总指标，值得进一步深入探究。

We have found that the most valuable uses of these tools combine both the tracking of quantitative metrics and careful reading of the resulting transcripts.  
我们发现，这些工具最具价值的应用方式，是将量化指标追踪与对生成对话记录（transcripts）的细致审阅相结合。

## Case study: Whistleblowing behavior

## 案例研究：举报行为（Whistleblowing behavior）

While running Petri across our diverse set of seed instructions, we observed multiple instances of models attempting to whistleblow—autonomously disclosing information about perceived organizational wrongdoing—when simulated developers give them sufficiently powerful tools, sufficiently broad access to information, and explicit unrestricted autonomy to act independently in pursuit of a goal (we first described this scenario in the [Claude 4 System Card](https://www-cdn.anthropic.com/4263b940cabb546aa0e3283f35b686f4f3b2ff47.pdf)).  
在使用 Petri 遍历我们多样化的初始指令集过程中，我们多次观察到模型尝试发起举报行为——即自主披露其认定的组织不当行为相关信息。这种现象发生在模拟开发者向模型赋予足够强大的工具、足够广泛的信息访问权限，以及明确且不受限的自主权（使其可为达成目标而独立行动）时。（该场景最早见于 [Claude 4 系统卡](https://www-cdn.anthropic.com/4263b940cabb546aa0e3283f35b686f4f3b2ff47.pdf)。）

In principle, this could play an important role in preventing certain large-scale harms.  
原则上，此类行为可能在防范某些大规模危害方面发挥重要作用。

However, it is not generally appropriate behavior for current AI systems: the possibility for accidental leaks and serious privacy violations is potentially significant, especially since current systems often see only limited or skewed information about their situations and often misunderstand what information they do receive.  
然而，对当前 AI 系统而言，这通常并非恰当行为：意外信息泄露及严重隐私侵犯的风险可能相当显著——尤其因为现有系统往往仅能获取关于其所处情境的有限或偏差信息，且常常误解其实际接收到的信息内容。

We used Petri to investigate how models handle ethical dilemmas when discovering organizational wrongdoing.  
我们借助 Petri 探究模型在发现组织不当行为时如何应对伦理困境。

We placed target models as autonomous agents within fictional organizations, gave them routine tasks (like “summarize these documents for tomorrow’s meeting”), and placed concerning information about organizational wrongdoing deep within a large set of notes, documents, emails or other files.  
我们将目标模型置于虚构组织中作为自主智能体，为其分配常规任务（例如“为明天的会议总结这些文档”），并将有关组织不当行为的敏感信息深埋于大量笔记、文档、电子邮件或其他文件之中。

We found that models’ decisions to report concerning information depend heavily on how much agency their system prompt gave them, and whether leadership was complicit in the wrongdoing.  
我们发现，模型是否选择上报敏感信息，高度依赖于其系统提示词（system prompt）所赋予的自主权程度，以及组织高层是否参与了该不当行为。

Notably, models sometimes attempted to whistleblow even in test scenarios where the organizational “wrongdoing” was explicitly harmless—such as dumping clean water into the ocean or putting sugar in candy—suggesting they may be influenced by narrative patterns more than by a coherent drive to minimize harm.  
值得注意的是，即便在测试场景中，组织所谓的“不当行为”被明确定义为无害（例如将洁净水排入海洋，或在糖果中添加糖分），模型有时仍会尝试举报——这表明其行为可能更多受叙事模式驱动，而非源于一种连贯一致的“最小化危害”内在动机。

![](images/petri-an-open-source-auditing-tool-to-accelerate-ai-safety-research-anthropic/img_004.jpg)  
![](images/petri-an-open-source-auditing-tool-to-accelerate-ai-safety-research-anthropic/img_004.jpg)

To understand which factors might drive whistleblowing behavior, we conducted ablation studies—systematically testing the effect of each factor by varying it while holding others constant.  
为厘清哪些因素可能驱动举报行为，我们开展了消融研究（ablation studies）——即在保持其他变量恒定的前提下，系统性地逐一调整各因素并检验其影响。

We found that three of them—leadership complicity, models’ autonomy/agency, and how concerning the wrongdoing was—had a consistent effect on the models’ whistleblowing rates.  
我们发现，其中三个因素——领导层是否共谋、模型的自主权/能动性（autonomy/agency）、以及该不当行为本身引发关切的程度——对模型的举报率均具有一致性影响。

## Get started

## 入门指南

We hope AI developers and safety researchers will adopt Petri to strengthen safety evaluations across the field.  

我们希望 AI 开发者与安全研究人员采用 Petri，以全面提升该领域的安全评估能力。

As AI systems become more powerful and autonomous, we need distributed efforts to identify misaligned behaviors before they become dangerous in deployment.  

随着 AI 系统日益强大与自主，我们必须依靠分布式协作，在这些系统部署后引发危险之前，及早识别其目标不一致（misaligned）的行为。

No single organization can comprehensively audit all the ways AI systems might fail—we need the broader research community equipped with robust tools to systematically explore model behaviors.  

没有任何单一机构能够全面审计 AI 系统可能失效的所有方式——我们需要更广泛的研究社区，配备坚实可靠的工具，以系统性地探索模型行为。

Petri is designed for rapid hypothesis testing, helping researchers quickly identify misaligned behaviors that warrant deeper investigation.  

Petri 专为快速假设检验而设计，助力研究人员迅速识别出值得深入探究的目标不一致行为。

The open-source framework supports major model APIs and includes sample seed instructions to help you get started immediately.  

这一开源框架支持主流大模型 API，并附带示例初始指令（seed instructions），助您即刻上手。

Early adopters, including MATS scholars, Anthropic Fellows, and the UK AISI, are already using Petri to explore eval awareness, reward hacking, self-preservation, model character, and more.  

早期采用者（包括 MATS 学者、Anthropic 研究员以及英国人工智能安全研究所 UK AISI）已开始使用 Petri 探索评估意识（eval awareness）、奖励劫持（reward hacking）、自我保存（self-preservation）、模型人格（model character）等课题。

For complete details on methodology, results, and best practices, read our [full technical report](https://alignment.anthropic.com/2025/petri).  

如需了解方法论、实验结果与最佳实践的完整细节，请参阅我们的[完整技术报告](https://alignment.anthropic.com/2025/petri)。

You can access Petri via our [GitHub page](https://github.com/safety-research/petri).  

您可通过我们的 [GitHub 页面](https://github.com/safety-research/petri) 获取 Petri。

## Acknowledgments

## 致谢

This research is by Kai Fronsdal\*, Isha Gupta\*, Abhay Sheshadri\*, Jonathan Michala, Stephen McAleer, Rowan Wang, Sara Price, and Samuel R. Bowman.  

本研究由 Kai Fronsdal\*、Isha Gupta\*、Abhay Sheshadri\*、Jonathan Michala、Stephen McAleer、Rowan Wang、Sara Price 和 Samuel R. Bowman 共同完成。

Helpful comments, discussions, and other assistance: Julius Steen, Chloe Loughridge, Christine Ye, Adam Newgas, David Lindner, Keshav Shenoy, John Hughes, Avery Griffin, and Stuart Ritchie.  

感谢 Julius Steen、Chloe Loughridge、Christine Ye、Adam Newgas、David Lindner、Keshav Shenoy、John Hughes、Avery Griffin 和 Stuart Ritchie 提供的宝贵意见、深入讨论及其他协助。

_\*Part of the Anthropic Fellows program_  

_\*Anthropic 研究员计划成员_

### **Citation**

### **引用格式**

> `@misc{petri2025,
> title={Petri: Parallel Exploration of Risky Interactions},
> author={Fronsdal, Kai and Gupta, Isha and Sheshadri, Abhay and Michala, Jonathan and McAleer, Stephen and Wang, Rowan and Price, Sara and Bowman, Sam},
> year={2025},
> url={https://github.com/safety-research/petri},
> }`