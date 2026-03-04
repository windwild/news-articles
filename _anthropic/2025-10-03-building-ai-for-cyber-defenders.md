---
title: "Building AI for cyber defenders"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/building-ai-cyber-defenders"
date: "2025-10-03"
scraped_at: "2026-03-03T06:44:12.978084125+00:00"
language: "en-zh"
translated: true
description: "How we've improved Claude's cyber defense skills"
---
&#123;% raw %}

Policy

政策

# Building AI for cyber defenders

# 为网络防御者构建人工智能

Oct 3, 2025

2025年10月3日

![Building AI for cyber defenders](images/building-ai-for-cyber-defenders/img_001.svg)

![为网络防御者构建人工智能](images/building-ai-for-cyber-defenders/img_001.svg)

#### Footnotes

#### 脚注

1\. Andy K Zhang et al., "Cybench: A Framework for Evaluating Cybersecurity Capabilities and Risks of Language Models," in The Thirteenth International Conference on Learning Representations (2025), [https://openreview.net/forum?id=tc90LV0yRL](https://openreview.net/forum?id=tc90LV0yRL).

1. Andy K Zhang 等，“Cybench：一种评估语言模型网络安全能力与风险的框架”，载于第十三届国际学习表征会议（2025年），[https://openreview.net/forum?id=tc90LV0yRL](https://openreview.net/forum?id=tc90LV0yRL)。

2\. Zhun Wang et al., "CyberGym: Evaluating AI Agents' Cybersecurity Capabilities with Real-World Vulnerabilities at Scale," arXiv preprint arXiv:2506.02548 (2025), [https://arxiv.org/abs/2506.02548](https://arxiv.org/abs/2506.02548).

2. Zhun Wang 等，“CyberGym：基于大规模真实世界漏洞评估 AI 智能体的网络安全能力”，arXiv 预印本 arXiv:2506.02548（2025年），[https://arxiv.org/abs/2506.02548](https://arxiv.org/abs/2506.02548)。

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们在数千次 Claude.ai 对话中追踪了 11 种可观测行为，构建了“AI 流利度指数”（AI Fluency Index）——这一指标为衡量当今人类与 AI 协作的现状提供了基准。

**AI models are now useful for cybersecurity tasks in practice, not just theory. As research and experience demonstrated the utility of frontier AI as a tool for cyber attackers, we invested in improving Claude’s ability to help defenders detect, analyze, and remediate vulnerabilities in code and deployed systems. This work allowed Claude Sonnet 4.5 to match or eclipse Opus 4.1, our frontier model released only two months prior, in discovering code vulnerabilities and other cyber skills. Adopting and experimenting with AI will be key for defenders to keep pace.**

**如今，AI 模型已切实可用于网络安全任务，而不仅停留在理论层面。** 随着研究与实践不断证实前沿 AI 可被网络攻击者用作高效工具，我们加大投入，持续提升 Claude 协助防御方检测、分析和修复代码及已部署系统中安全漏洞的能力。这项工作使 Claude Sonnet 4.5 在发现代码漏洞及其他网络安全技能方面，达到甚至超越了仅两个月前发布的前沿模型 Claude Opus 4.1。对 AI 的采纳与实验，将成为防御方跟上威胁演进节奏的关键。

\[@portabletext/react\] Unknown block type "horizontalRule", specify a component for it in the \`components.types\` prop

\[@portabletext/react\] 未知区块类型 “horizontalRule”，请在 `components.types` 属性中为其指定对应组件。

We believe we are now at an inflection point for AI’s impact on cybersecurity.

我们相信，AI 对网络安全的影响目前已步入一个关键拐点。

For several years, our team has carefully tracked the cybersecurity-relevant capabilities of AI models. Initially, we found models to be not particularly powerful for advanced and meaningful capabilities. However, over the past year or so, we’ve noticed a shift. For example:

多年来，我们的团队持续细致地追踪 AI 模型在网络安全领域的相关能力。起初，我们发现这些模型在执行高级、有实际意义的任务时并不特别强大。然而，过去一年左右，我们观察到了显著转变。例如：

- We showed that models could [reproduce one of the costliest cyberattacks](https://red.anthropic.com/2025/cyber-toolkits/) in history—the 2017 Equifax breach—in simulation.  
  - 我们已证明，AI 模型可在模拟环境中复现历史上代价最惨重的网络攻击之一——2017 年的 Equifax 数据泄露事件。[参见相关报告](https://red.anthropic.com/2025/cyber-toolkits/)

- We entered Claude into cybersecurity competitions, and it [outperformed human teams](https://red.anthropic.com/2025/cyber-competitions/) in some cases.  
  - 我们将 Claude 推入多项网络安全竞赛，在某些场景下其表现[超越人类团队](https://red.anthropic.com/2025/cyber-competitions/)。

- Claude has helped us [discover vulnerabilities in our own code](https://www.anthropic.com/news/automate-security-reviews-with-claude-code) and fix them before release.  
  - Claude 已协助我们[在自有代码中发现安全漏洞](https://www.anthropic.com/news/automate-security-reviews-with-claude-code)，并在发布前完成修复。

In this summer’s DARPA [AI Cyber Challenge](https://aicyberchallenge.com/), teams used LLMs (including Claude) to build “cyber reasoning systems” that examined millions of lines of code for vulnerabilities to patch. In addition to inserted vulnerabilities, teams found (and sometimes patched) [previously undiscovered, non-synthetic vulnerabilities](https://aicyberchallenge.com/Finals-winners-announcement/). Beyond a competition setting, other frontier labs now apply models to [discover and report novel vulnerabilities](https://blog.google/technology/safety-security/cybersecurity-updates-summer-2025/).

在今年夏季举行的美国国防高级研究计划局（DARPA）[AI 网络挑战赛（AI Cyber Challenge）](https://aicyberchallenge.com/)中，各参赛团队利用大语言模型（包括 Claude）构建了“网络推理系统”，对数百万行代码进行扫描，以识别并修补安全漏洞。除主办方预设的漏洞外，团队还发现了（部分甚至成功修补了）[此前未被发现、非人工构造的真实漏洞](https://aicyberchallenge.com/Finals-winners-announcement/)。在竞赛之外，其他前沿实验室也正将 AI 模型应用于[发现并披露新型漏洞](https://blog.google/technology/safety-security/cybersecurity-updates-summer-2025/)。

At the same time, as part of our Safeguards work, we have found and disrupted threat actors on our own platform who leveraged AI to scale their operations. Our [Safeguards](https://www.anthropic.com/news/building-safeguards-for-claude) team recently discovered (and disrupted) a case of “ [vibe hacking](https://www.anthropic.com/news/detecting-countering-misuse-aug-2025),” in which a cybercriminal used Claude to build a large-scale data extortion scheme that previously would have required an entire team of people. Safeguards has also detected and countered Claude's use in increasingly [complex espionage operations](https://www-cdn.anthropic.com/b2a76c6f6992465c09a6f2fce282f6c0cea8c200.pdf), including the targeting of critical telecommunications infrastructure, by an actor that demonstrated characteristics consistent with Chinese APT operations.

与此同时，作为我们“防护机制”（Safeguards）工作的一部分，我们已在自身平台上识别并阻断了若干滥用 AI 扩大规模化恶意活动的威胁行为体。我们的[Safeguards 团队](https://www.anthropic.com/news/building-safeguards-for-claude)近期发现并成功阻断了一起“[氛围操控”（vibe hacking）](https://www.anthropic.com/news/detecting-countering-misuse-aug-2025)案例：一名网络犯罪分子利用 Claude 构建了一套大规模数据勒索方案——此类方案若在以往，需动用一整支人力团队方可实施。此外，Safeguards 还侦测并反制了 Claude 被用于日益[复杂的间谍行动](https://www-cdn.anthropic.com/b2a76c6f6992465c09a6f2fce282f6c0cea8c200.pdf)的情况，包括针对关键电信基础设施的定向攻击；该攻击者的战术、技术与流程（TTPs）特征与已知中国高级持续性威胁（APT）组织高度一致。

All of these lines of evidence lead us to think we are at an important inflection point in the cyber ecosystem, and progress from here could become quite fast or usage could grow quite quickly.

上述所有证据共同表明：我们正处于网络生态演进的一个重要拐点；此后的发展速度可能极为迅猛，AI 在该领域的应用规模也可能急速扩大。

Therefore, now is an important moment to accelerate defensive use of AI to secure code and infrastructure. **We should not cede the cyber advantage derived from AI to attackers and criminals.** While we will continue to invest in detecting and disrupting malicious attackers, we think the most scalable solution is to build AI systems that empower those safeguarding our digital environments—like security teams protecting businesses and governments, cybersecurity researchers, and maintainers of critical open-source software.

因此，当下正是加速推进 AI 在防御端应用、以保障代码与基础设施安全的关键时刻。**我们绝不能将 AI 带来的网络优势拱手让予攻击者与犯罪分子。** 尽管我们将持续投入资源，用于识别与阻断恶意攻击者，但我们认为最具可扩展性的解决方案，是构建能够赋能数字环境守护者的 AI 系统——包括保护企业与政府机构的安全团队、网络安全研究人员，以及关键开源软件的维护者。

In the run-up to the release of Claude Sonnet 4.5, we started to do just that.

在 Claude Sonnet 4.5 发布前夕，我们便已着手开展这项工作。

## Claude Sonnet 4.5: emphasizing cyber skills

## Claude Sonnet 4.5：聚焦网络安全能力

As LLMs scale in size, “ [emergent abilities](https://arxiv.org/abs/2206.07682)”—skills that were not evident in smaller models and were not necessarily an explicit target of model training—appear. Indeed, Claude’s abilities to execute cybersecurity tasks like finding and exploiting software vulnerabilities in Capture-the-Flag (CTF) challenges have been byproducts of developing generally useful AI assistants.

随着大语言模型（LLM）规模不断扩大，“[涌现能力](https://arxiv.org/abs/2206.07682)”——即在较小模型中未显现、且未必是模型训练明确目标的能力——开始浮现。事实上，Claude 在网络安全任务（例如在夺旗赛（CTF）挑战中发现并利用软件漏洞）方面的表现，正是开发通用型 AI 助手过程中产生的副产品。

But we don’t want to rely on general model progress alone to better equip defenders. Because of the urgency of this moment in the evolution of AI and cybersecurity, we dedicated researchers to making Claude better at key skills like code vulnerability discovery and patching.

但我们并不希望仅依赖通用模型的整体进步来提升防御方的能力。鉴于当前 AI 与网络安全协同演进的关键节点所具有的紧迫性，我们专门投入研究人员，着力提升 Claude 在代码漏洞发现与修复等核心能力上的表现。

The results of this work are reflected in Claude Sonnet 4.5. It is comparable or superior to Claude Opus 4.1 in many aspects of cybersecurity while also being less expensive and faster.

这项工作的成果体现在 Claude Sonnet 4.5 中：它在诸多网络安全指标上达到甚至超越了 Claude Opus 4.1 的水平，同时具备更低的成本与更快的响应速度。

## Evidence from evaluations

## 评估结果佐证

In building Sonnet 4.5, we had a small research team focus on enhancing Claude’s ability to find vulnerabilities in codebases, patch them, and test for weaknesses in simulated deployed security infrastructure. We chose these because they reflect important tasks for defensive actors. We deliberately avoided enhancements that clearly favor offensive work—such as advanced exploitation or writing malware. We hope to enable models to find insecure code before deployment and to find and fix vulnerabilities in deployed code. There are, of course, many more critical security tasks we did not focus on; at the end of this post, we elaborate on future directions.

在构建 Sonnet 4.5 的过程中，我们组建了一支小型研究团队，专注于增强 Claude 在以下三方面的能力：在代码库中识别漏洞、修复漏洞，以及在模拟部署的安全基础设施中检测薄弱环节。我们之所以选择这些方向，是因为它们切实反映了防御方的关键任务。我们刻意避免引入明显偏向攻击性用途的增强功能——例如高级漏洞利用或恶意软件编写。我们的目标是让模型能在代码部署前识别出不安全的代码，并在已部署代码中主动发现并修复漏洞。当然，还有许多其他至关重要的安全任务尚未纳入本次工作范围；本文末尾将详述未来的研究方向。

To test the effects of our research, we ran industry-standard evaluations of our models. These enable clear comparisons across models, measure the speed of AI progress, and—especially in the case of novel, externally developed evaluations—provide a good metric to ensure that we are not simply teaching to our own tests.

为验证研究成果的实际效果，我们对模型开展了业界标准的评估。此类评估不仅支持跨模型的清晰对比、量化 AI 技术的发展速度，而且——尤其对于由外部机构开发的新颖评估方案而言——还能提供一项良好指标，确保我们并非仅仅“应试训练”自身模型。

As we ran these evaluations, one thing that stood out was the importance of running them many times. Even if it is computationally expensive for a large set of evaluation tasks, it better captures the behavior of a motivated attacker or defender on any particular real-world problem. Doing so reveals impressive performance not only from Claude Sonnet 4.5, but also from models several generations older.

在开展这些评估的过程中，一个突出发现是：重复多次运行评估至关重要。即便对大量评估任务而言计算开销高昂，这种做法仍能更真实地反映一名动机充分的攻击者或防御者在特定现实问题上的行为表现。如此操作所揭示的性能提升令人印象深刻——不仅体现在 Claude Sonnet 4.5 上，也体现在数代之前的模型中。

### Cybench

### Cybench

One of the evaluations we have tracked for over a year is [Cybench](https://cybench.github.io/), a benchmark drawn from CTF competition challenges.1  
我们持续跟踪评估已逾一年的项目之一是 [Cybench](https://cybench.github.io/)，该基准测试源自 CTF 竞赛挑战题。¹

On this evaluation, we see striking improvement from Claude Sonnet 4.5, not just over Claude Sonnet 4, but even over Claude Opus 4 and 4.1 models.  
在该项评估中，Claude Sonnet 4.5 表现出显著提升——不仅大幅超越 Claude Sonnet 4，甚至超过了 Claude Opus 4 和 4.1。

Perhaps most striking, _Sonnet 4.5 achieves a higher probability of success given one attempt per task than Opus 4.1 when given ten attempts per task_.  
尤为引人注目的是：_在每项任务仅允许一次尝试的前提下，Sonnet 4.5 的成功率已高于 Opus 4.1 在每项任务允许十次尝试时的表现。_

The challenges that are part of this evaluation reflect somewhat complex, long-duration workflows.  
本评估所涵盖的挑战任务反映的是具有一定复杂度、耗时较长的工作流。

For example, one challenge involved analyzing network traffic, extracting malware from that traffic, and decompiling and decrypting the malware.  
例如，其中一道挑战题要求分析网络流量、从中提取恶意软件，并对恶意软件进行反编译与解密。

We estimate that this would have taken a skilled human at least an hour, and possibly much longer; Claude took 38 minutes to solve it.  
我们估计，一名经验丰富的安全人员完成此项任务至少需一小时，甚至更久；而 Claude 仅用 38 分钟即成功解决。

When we give Claude Sonnet 4.5 10 attempts at the Cybench evaluation, it succeeds on 76.5% of the challenges.  
当为 Claude Sonnet 4.5 提供每次任务最多 10 次尝试机会参与 Cybench 评估时，其在 76.5% 的挑战题上取得成功。

This is particularly noteworthy because we have doubled this success rate in just the past six months (Sonnet 3.7, released in February 2025, had only a 35.9% success rate when given 10 trials).  
这一成果尤为值得关注：过去六个月间，该成功率实现翻倍（2025 年 2 月发布的 Sonnet 3.7 在同样 10 次尝试条件下，成功率仅为 35.9%）。

![Claude Sonnet 4.5 outperforms other models at Cybench](images/building-ai-for-cyber-defenders/img_002.jpg)Model Performance on Cybench. Claude Sonnet 4.5 significantly outperforms all previous models given k=1, 10, or 30 trials, where probability of success is measured as the expectation over the proportion of problems where at least one of k trials succeeds. Note that these results are on a subset of 37 of the 40 original Cybench problems, where 3 problems were excluded due to implementation difficulties.  
![Claude Sonnet 4.5 在 Cybench 上超越其他模型](images/building-ai-for-cyber-defenders/img_002.jpg)Cybench 模型性能对比图。Claude Sonnet 4.5 在 k = 1、10 或 30 次尝试条件下，均显著优于所有先前模型；此处“成功率”定义为：在全部题目中，至少有一次尝试成功的题目所占比例的期望值。需注意，本结果基于原始 40 道 Cybench 题目中的 37 道子集，其余 3 道因实现困难被排除。

### CyberGym

### CyberGym

In another external evaluation, we evaluated Claude Sonnet 4.5 on [CyberGym](https://www.cybergym.io/), a benchmark that evaluates the ability of agents to (1) find (previously-discovered) vulnerabilities in real open-source software projects given a high-level description of the weakness, and (2) discover new (previously-undiscovered) vulnerabilities.2  
在另一项外部评估中，我们在 [CyberGym](https://www.cybergym.io/) 基准测试平台上对 Claude Sonnet 4.5 进行了评测。该基准旨在评估智能体两项能力：(1) 根据对漏洞弱点的高层级描述，在真实开源软件项目中定位（此前已被发现的）安全漏洞；(2) 发现全新的（此前未被披露的）安全漏洞。²

The CyberGym team previously found that Claude Sonnet 4 was the strongest model on their [public leaderboard](https://www.cybergym.io/).  
CyberGym 团队此前发现，Claude Sonnet 4 是其 [公开排行榜](https://www.cybergym.io/) 上表现最强的模型。

Claude Sonnet 4.5 scores significantly better than either Claude Sonnet 4 or Claude Opus 4.  
Claude Sonnet 4.5 的得分显著优于 Claude Sonnet 4 和 Claude Opus 4。

When using the same cost constraints as the public CyberGym leaderboard (i.e., a limit of $2 of LLM API queries per vulnerability) we find that Sonnet 4.5 achieves a new state-of-the-art score of 28.9%.  
在采用与 CyberGym 公开排行榜一致的成本约束条件（即：每个漏洞检测任务最多消耗 2 美元的 LLM API 调用费用）下，Sonnet 4.5 取得了 28.9% 的新 SOTA（当前最优）分数。

But true attackers are rarely limited in this way: they can attempt many attacks, for far more than $2 per trial.  
但真实攻击者极少受此类限制：他们可发起大量攻击尝试，单次尝试成本远超 2 美元。

When we remove these constraints and give Claude 30 trials per task, we find that Sonnet 4.5 reproduces vulnerabilities in 66.7% of programs.  
当我们取消上述成本限制，并为 Claude 每项任务提供 30 次尝试机会时，Sonnet 4.5 在 66.7% 的程序中成功复现了已知漏洞。

And although the relative price of this approach is higher, the absolute cost—about $45 to try one task 30 times—remains quite low.  
尽管该方法的单位相对成本更高，但其绝对成本仍极低——即：单个任务尝试 30 次，总花费约为 45 美元。

![Model Performance on CyberGym — Sonnet 4.5 is more likely to be successful, both after one trial and after thirty.](images/building-ai-for-cyber-defenders/img_003.jpg)Model Performance on CyberGym. Sonnet 4.5 outperforms all previous models, including Opus 4.1. \*Note that Opus 4.1, given its higher price, did not follow the same $2 cost constraint as the other models in the 1 trial scenario.  
![CyberGym 模型性能对比——Sonnet 4.5 在单次及三十次尝试后均更可能成功](images/building-ai-for-cyber-defenders/img_003.jpg)CyberGym 模型性能对比图。Sonnet 4.5 在所有先前模型（包括 Opus 4.1）中表现最佳。\*注：Opus 4.1 因单价更高，在单次尝试场景中未遵循与其他模型相同的 2 美元成本约束。

Equally interesting is the rate at which Claude Sonnet 4.5 discovers new vulnerabilities.  
同样值得关注的是 Claude Sonnet 4.5 发现全新漏洞的速率。

While the CyberGym leaderboard shows that Claude Sonnet 4 only discovers vulnerabilities in about 2% of targets, Sonnet 4.5 discovers new vulnerabilities in 5% of cases.  
CyberGym 公开排行榜显示，Claude Sonnet 4 仅能在约 2% 的目标中发现漏洞；而 Sonnet 4.5 在 5% 的案例中成功发现了全新漏洞。

By repeating the trial 30 times it discovers new vulnerabilities in over 33% of projects.  
若将单任务尝试次数提升至 30 次，则 Sonnet 4.5 可在超过 33% 的项目中发现全新漏洞。

![Model Performance on CyberGym new vulnerability discovery](images/building-ai-for-cyber-defenders/img_004.jpg)Model Performance on CyberGym. Sonnet 4.5 outperforms Sonnet 4 at new vulnerability discovery with only one trial and dramatically outstrips its performance when given 30 trials.  
![CyberGym 新漏洞发现能力对比](images/building-ai-for-cyber-defenders/img_004.jpg)CyberGym 新漏洞发现能力对比图。Sonnet 4.5 在仅一次尝试条件下即优于 Sonnet 4；而在给予 30 次尝试机会时，其性能优势更为显著。

### Further research into patching

### 关于补丁修复的进一步研究

We are also conducting preliminary research into Claude's ability to generate and review patches that fix vulnerabilities. Patching vulnerabilities is a harder task than finding them because the model has to make surgical changes that remove the vulnerability without altering the original functionality. Without guidance or specifications, the model has to infer this intended functionality from the code base.

我们还在初步研究 Claude 生成和审查修复漏洞补丁的能力。修补漏洞比发现漏洞更难，因为模型必须进行精准的修改：既要消除漏洞，又不能改变原有功能。在缺乏明确指导或规范的情况下，模型只能从代码库中推断出程序本应实现的功能。

In our experiment we tasked Claude Sonnet 4.5 with patching vulnerabilities in the CyberGym evaluation set based on a description of the vulnerability and information about what the program was doing when it crashed. We used Claude to judge its own work, asking it to grade the submitted patches by comparing them to human-authored reference patches. 15% of the Claude-generated patches were judged to be semantically equivalent to the human-generated patches. However, this comparison-based approach has an important limitation: because vulnerabilities can often be fixed in multiple valid ways, patches that differ from the reference may still be correct, leading to false negatives in our evaluation.

在本次实验中，我们要求 Claude Sonnet 4.5 基于漏洞描述以及程序崩溃时的行为信息，为 CyberGym 评估集中的漏洞生成补丁。我们让 Claude 自行评估其工作成果，即通过将其生成的补丁与人工编写的参考补丁进行比对，对其打分。结果显示，15% 的 Claude 生成补丁被判定为在语义上等价于人工补丁。然而，这种基于比对的评估方法存在一个重要局限：由于同一漏洞往往存在多种有效的修复方式，与参考补丁不同的补丁仍可能是正确的，从而导致评估中出现“假阴性”（false negatives）。

We manually analyzed a sample of the highest-scoring patches and found them to be functionally identical to reference patches that have been merged into the open-source software on which the CyberGym evaluation is based. This work reveals a pattern consistent with our broader findings: Claude develops cyber-related skills as it generally improves. Our preliminary results suggest that patch generation—like vulnerability discovery before it—is an emergent capability that could be enhanced with focused research. Our next step is to systematically address the challenges we've identified to make Claude a reliable patch author and reviewer.

我们人工分析了一组得分最高的补丁样本，发现它们在功能上与已合并进 CyberGym 评估所依托的开源软件中的参考补丁完全一致。这项工作揭示了一个与我们更广泛研究结论一致的规律：随着 Claude 整体能力的提升，其网络安全相关技能也随之增强。我们的初步结果表明，补丁生成——正如此前的漏洞发现一样——是一种涌现能力（emergent capability），有望通过有针对性的研究进一步提升。下一步，我们将系统性地应对已识别的挑战，使 Claude 成为一名可靠的补丁作者与评审者。

## Conferring with trusted partners

## 与值得信赖的合作伙伴协同研讨

Real world defensive security is more complicated in practice than our evaluations can capture. We’ve consistently found that real problems are more complex, challenges are harder, and implementation details matter a lot. Therefore, we feel it is important to work with the organizations actually using AI for defense to get feedback on how our research could accelerate them. In the lead-up to Sonnet 4.5 we worked with a number of organizations who applied the model to their real challenges in areas like vulnerability remediation, testing network security, and threat analysis.

现实世界中的防御型安全实践，远比我们的评估所能涵盖的更为复杂。我们持续观察到：真实问题更加错综复杂，实际挑战更为艰巨，而实施细节则至关重要。因此，我们认为，与真正将 AI 应用于安全防御的组织合作、听取其反馈，以了解我们的研究如何助力其加速发展，具有重要意义。在 Sonnet 4.5 发布前，我们已与多家机构展开合作，协助其将该模型应用于漏洞修复、网络安全性测试、威胁分析等真实业务场景。

Nidhi Aggarwal, Chief Product Officer of HackerOne, said, “Claude Sonnet 4.5 reduced average vulnerability intake time for our Hai security agents by 44% while improving accuracy by 25%, helping us reduce risk for businesses with confidence.” According to Sven Krasser, Senior Vice President for Data Science and Chief Scientist at CrowdStrike, “Claude shows strong promise for red teaming—generating creative attack scenarios that accelerate how we study attacker tradecraft. These insights strengthen our defenses across endpoints, identity, cloud, data, SaaS, and AI workloads.”

HackerOne 首席产品官 Nidhi Aggarwal 表示：“Claude Sonnet 4.5 将我们 Hai 安全代理团队处理漏洞的平均耗时降低了 44%，同时准确率提升了 25%，帮助我们更有信心地为企业降低安全风险。” CrowdStrike 数据科学高级副总裁兼首席科学家 Sven Krasser 指出：“Claude 在红队演练（red teaming）方面展现出巨大潜力——它能生成富有创意的攻击场景，从而加快我们对攻击者战术、技术和流程（TTPs）的研究进程。这些洞见强化了我们在终端、身份、云、数据、SaaS 及 AI 工作负载等各层面的防御能力。”

These testimonials made us more confident in the potential for applied, defensive work with Claude.

这些评价进一步增强了我们对 Claude 在实战化防御工作中应用潜力的信心。

## What's next?

## 下一步计划？

Claude Sonnet 4.5 represents a meaningful improvement, but we know that many of its capabilities are nascent and do not yet match those of security professionals and established processes. We will keep working to improve the defense-relevant capabilities of our models and enhance the threat intelligence and mitigations that safeguard our platforms. In fact, we have already been using results of our investigations and evaluations to continually refine our ability to catch misuse of our models for harmful cyber behavior. This includes using techniques like organization-level [summarization](https://alignment.anthropic.com/2025/summarization-for-monitoring/) to understand the bigger picture beyond just a singular prompt and completion; this helps disaggregate dual-use behavior from nefarious behavior, particularly for the most damaging use-cases involving large scale automated activity.

Claude Sonnet 4.5 代表了一次显著进步，但我们深知，其诸多能力尚处萌芽阶段，尚未达到专业安全人员及成熟流程的水平。我们将持续优化模型中与防御相关的各项能力，并加强威胁情报建设与缓解措施，以更好地保障平台安全。事实上，我们已开始将调查与评估结果用于持续改进自身能力，以更有效地识别模型被滥用于有害网络行为的情形。这包括采用诸如组织级 [摘要技术（summarization）](https://alignment.anthropic.com/2025/summarization-for-monitoring/) 等方法，在单个提示词与输出之外，把握更宏观的行为图景；该方法有助于区分“两用行为”（dual-use behavior）与恶意行为，尤其适用于那些危害最大、涉及大规模自动化活动的滥用场景。

**But we believe that now is the time for as many organizations as possible to start experimenting with how AI can improve their security posture and build the evaluations to assess those gains.** [Automated security reviews](https://www.anthropic.com/news/automate-security-reviews-with-claude-code) in Claude Code show how AI can be integrated into the CI/CD pipeline. We would specifically like to enable researchers and teams to experiment with applying models in areas like Security Operations Center (SOC) automation, Security Information and Event Management (SIEM) analysis, secure network engineering, or active defense. We would like to see and use more evaluations for defensive capabilities as part of the growing [third-party ecosystem](https://www.anthropic.com/news/a-new-initiative-for-developing-third-party-model-evaluations) for model evaluations.

**但我们坚信，现在正是尽可能多的组织着手探索 AI 如何提升自身安全态势，并构建相应评估体系以衡量成效的关键时机。** Claude Code 中的 [自动化安全审查（Automated security reviews）](https://www.anthropic.com/news/automate-security-reviews-with-claude-code) 展示了 AI 如何融入 CI/CD 流水线。我们特别希望赋能研究人员与各类团队，使其能在安全运营中心（SOC）自动化、安全信息与事件管理（SIEM）分析、安全网络工程或主动防御等领域开展模型应用实验。我们也期待看到并使用更多面向防御能力的评估方案，共同推动日益壮大的 [第三方模型评估生态体系（third-party ecosystem）](https://www.anthropic.com/news/a-new-initiative-for-developing-third-party-model-evaluations) 不断发展完善。

But even building and adopting to advantage defenders is only part of the solution. We also need conversations about making digital infrastructure more resilient and new software secure by design—including with help from frontier AI models. We look forward to these discussions with industry, government, and civil society as we navigate the moment when AI’s impact on cybersecurity transitions from being a future concern to a present-day imperative.

但即便构建并充分利用防御者能力，也仅是解决方案的一部分。我们还需展开对话，探讨如何提升数字基础设施的韧性，以及如何通过“安全设计”（secure by design）理念保障新软件的安全性——这其中也包括借助前沿 AI 模型提供支持。在人工智能对网络安全的影响正从未来议题转变为当下紧迫要务的关键时刻，我们期待与产业界、政府部门及民间社会共同深入探讨这些议题。

_This article was originally posted on September 29 2025 on the Frontier Red Team's blog, [red.anthropic.com](https://red.anthropic.com/)._

_本文最初于 2025 年 9 月 29 日发布于 Frontier Red Team 博客：[red.anthropic.com](https://red.anthropic.com/)。_
&#123;% endraw %}
