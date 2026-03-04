---
render_with_liquid: false
title: "Making frontier cybersecurity capabilities available to defenders"
source: "Anthropic News"
url: "https://www.anthropic.com/news/claude-code-security"
scraped_at: "2026-03-02T09:21:04.903760846+00:00"
language: "en-zh"
translated: true
description: "Claude Code Security is one step towards our goal of more secure codebases and a higher security baseline across the industry."
tags: ["Announcements"]
---
render_with_liquid: false
render_with_liquid: false

Announcements

公告

# Making frontier cybersecurity capabilities available to defenders

# 让前沿网络安全能力惠及防御方

Feb 20, 2026

2026 年 2 月 20 日

![Making frontier cybersecurity capabilities available to defenders](images/making-frontier-cybersecurity-capabilities-available-to-defenders/img_001.svg)

![让前沿网络安全能力惠及防御方](images/making-frontier-cybersecurity-capabilities-available-to-defenders/img_001.svg)











**Claude Code Security**, a new capability built into Claude Code on the web, is now available in a limited research preview. It scans codebases for security vulnerabilities and suggests targeted software patches for human review, allowing teams to find and fix security issues that traditional methods often miss.

**Claude Code Security** 是一项集成于网页版 Claude Code 的全新功能，目前正以有限研究预览形式开放。它可扫描代码库中的安全漏洞，并为人工审核生成针对性的软件补丁建议，帮助团队发现并修复传统方法常常遗漏的安全问题。

Security teams face a common challenge: too many software vulnerabilities and not enough people to address them. Existing analysis tools help, but only to a point, as they usually look for known patterns. Finding the subtle, context-dependent vulnerabilities that are often exploited by attackers requires skilled human researchers, who are dealing with ever-expanding backlogs.

安全团队面临一个普遍挑战：软件漏洞数量过多，而能够应对它们的安全人员却严重不足。现有的分析工具虽有一定帮助，但作用有限，因为它们通常仅能识别已知的漏洞模式。发现那些常被攻击者利用的细微、依赖上下文的漏洞，则需要经验丰富的安全研究人员——而这类专家正深陷于日益增长的待处理任务积压之中。

AI is beginning to change that calculus. We’ve recently shown that [Claude can detect novel, high-severity vulnerabilities](https://red.anthropic.com/2026/zero-days/). But the same capabilities that help defenders find and fix vulnerabilities could help attackers exploit them.

人工智能正开始改变这一局面。我们近期已证实，[Claude 能够检测新型高危漏洞](https://red.anthropic.com/2026/zero-days/)。然而，同样这些赋能防御方发现并修复漏洞的能力，也可能被攻击者用于挖掘和利用漏洞。

Claude Code Security is intended to put this power squarely in the hands of defenders and protect code against this new category of AI-enabled attack. We’re releasing it as a limited research preview to Enterprise and Team customers, with expedited access for maintainers of open-source repositories, so we can work together to refine its capabilities and ensure it is deployed responsibly.

Claude Code Security 的设计初衷，是将这一能力切实交到防御方手中，以抵御此类新型“AI 驱动型攻击”。我们正面向企业客户（Enterprise）和团队客户（Team）以**限量研究预览版**形式发布该产品；同时为开源仓库维护者提供优先访问权限，以便我们携手优化其功能，并确保其负责任地部署与应用。

## **How Claude Code Security works**

## **Claude Code Security 的工作原理**

Static analysis—a widely deployed form of automated security testing—is typically rule-based, meaning it matches code against known vulnerability patterns. That catches common issues, like exposed passwords or outdated encryption, but often misses more complex vulnerabilities, like flaws in business logic or broken access control.

静态分析（Static Analysis）是一种广泛应用的自动化安全测试方式，通常基于规则——即通过将代码与已知漏洞模式进行匹配来识别问题。这种方式可有效捕获常见风险，例如明文暴露的密码或过时的加密算法，却往往遗漏更复杂的漏洞，如业务逻辑缺陷或访问控制失效。

Rather than scanning for known patterns, Claude Code Security reads and reasons about your code the way a human security researcher would: understanding how components interact, tracing how data moves through your application, and catching complex vulnerabilities that rule-based tools miss.

Claude Code Security 并不局限于扫描已知模式，而是像人类安全研究员一样阅读并推理您的代码：理解各组件间的交互关系，追踪数据在应用程序中的流转路径，并识别出基于规则的工具所遗漏的复杂漏洞。

Every finding goes through a multi-stage verification process before it reaches an analyst. Claude re-examines each result, attempting to prove or disprove its own findings and filter out false positives. Findings are also assigned severity ratings so teams can focus on the most important fixes first.

每项检测结果在呈递给安全分析师前，均需经过多阶段验证流程。Claude 会重新审视每一项结果，尝试自证或证伪其自身判断，从而过滤掉误报（false positives）。同时，所有发现均被赋予严重性评级（severity rating），以便团队优先处理最关键的问题。

Validated findings appear in the Claude Code Security dashboard, where teams can review them, inspect the suggested patches, and approve fixes. Because these issues often involve nuances that are difficult to assess from source code alone, Claude also provides a confidence rating for each finding. Nothing is applied without human approval: Claude Code Security identifies problems and suggests solutions, but developers always make the call.

经验证的发现将呈现在 Claude Code Security 仪表盘中，供团队审阅、检查建议的补丁，并批准修复方案。由于此类问题往往涉及仅凭源代码难以准确评估的细微之处，Claude 还为每项发现提供置信度评分（confidence rating）。**任何变更均须经人工确认后方可实施**：Claude Code Security 负责识别问题并提出解决方案，但最终决策权始终掌握在开发者手中。

## **Using Claude for cybersecurity**

## **将 Claude 应用于网络安全领域**

Claude Code Security builds on more than a year of research into Claude’s cybersecurity capabilities. Our Frontier Red Team has been stress-testing these abilities systematically: entering Claude in [competitive Capture-the-Flag events](https://red.anthropic.com/2025/ai-for-cyber-defenders/), partnering with Pacific Northwest National Laboratory to [experiment with using AI to defend critical infrastructure](https://red.anthropic.com/2026/critical-infrastructure-defense/), and refining Claude’s ability to find and patch real vulnerabilities in code.

Claude Code Security 建立在对 Claude 网络安全能力长达一年以上的深入研究基础之上。我们的前沿红队（Frontier Red Team）已系统性地对这些能力开展压力测试：包括让 Claude 参加 [高水平攻防对抗赛（Capture-the-Flag）](https://red.anthropic.com/2025/ai-for-cyber-defenders/)；与美国西北太平洋国家实验室（Pacific Northwest National Laboratory）合作，[探索利用 AI 保护关键基础设施的可行性](https://red.anthropic.com/2026/critical-infrastructure-defense/)；以及持续提升 Claude 在真实代码中发现并修复实际漏洞的能力。

Claude’s cyberdefensive abilities have improved substantially as a result.  

因此，Claude 的网络防御能力得到了显著提升。

Using [Claude Opus 4.6](https://www.anthropic.com/news/claude-opus-4-6), released earlier this month, our team [found over 500 vulnerabilities](https://red.anthropic.com/2026/zero-days/) in production open-source codebases—bugs that had gone undetected for decades, despite years of expert review.  

借助本月早些时候发布的 [Claude Opus 4.6](https://www.anthropic.com/news/claude-opus-4-6)，我们的团队在多个投入生产的开源代码库中[发现了 500 多个漏洞](https://red.anthropic.com/2026/zero-days/)——这些缺陷已潜伏数十年之久，即便历经多年专家审查也始终未被发现。

We’re working through triage and responsible disclosure with maintainers now, and we plan to expand our security work with the open-source community.  

目前，我们正与各项目维护者协同开展漏洞分级评估（triage）和负责任披露（responsible disclosure），并计划进一步深化与开源社区在安全领域的合作。

We also use Claude to review our own code, and we’ve found it to be extremely effective at securing Anthropic’s systems.  

我们还利用 Claude 审查自身代码，实践表明，它在保障 Anthropic 系统安全方面极为高效。

We built Claude Code Security to make those same defensive capabilities more widely available.  

为此，我们推出了 Claude Code Security，旨在将这些防御能力更广泛地提供给开发者社区。

And since it’s built on Claude Code, teams can review findings and iterate on fixes within the tools they already use.  

由于该工具基于 Claude Code 构建，开发团队可在其日常使用的现有工具中直接审阅检测结果，并持续迭代修复方案。

## **The road ahead**

## **前行之路**

This is a pivotal time for cybersecurity. We expect that a significant share of the world’s code will be scanned by AI in the near future, given how effective models have become at finding long-hidden bugs and security issues.  

当前正处于网络安全发展的关键节点。鉴于大模型在挖掘长期潜藏的缺陷与安全问题方面已展现出卓越能力，我们预计：在不久的将来，全球相当大比例的代码将由 AI 进行扫描。

Attackers will use AI to find exploitable weaknesses faster than ever. But defenders who move quickly can find those same weaknesses, patch them, and reduce the risk of an attack.  

攻击者将利用 AI 以前所未有的速度定位可利用的弱点；但响应迅速的防御方同样能够抢先发现这些弱点、及时修补，并大幅降低遭受攻击的风险。

Claude Code Security is one step towards our goal of more secure codebases and a higher security baseline across the industry.  

Claude Code Security 正是我们迈向“构建更安全的代码库”及“全面提升行业安全基线”这一目标的重要一步。

## **Getting started**

## **快速入门**

We’re opening a limited research preview of Claude Code Security to Enterprise and Team customers today.  

即日起，我们将面向企业客户（Enterprise）和团队客户（Team）开放 Claude Code Security 的限量研究预览版。

Participants will get early access and collaborate directly with our team to hone the tool’s capabilities.  

参与用户将获得早期访问权限，并可直接与我们的团队协作，共同打磨和完善该工具的功能。

We also encourage open-source maintainers to apply for free, expedited access.  

我们也诚挚邀请开源项目维护者申请免费且优先审核的访问权限。

[Apply for access here](https://claude.com/contact-sales/security).  

[立即申请访问权限](https://claude.com/contact-sales/security)。

To learn more, visit [claude.com/solutions/claude-code-security](http://claude.com/solutions/claude-code-security).  

欲了解更多信息，请访问 [claude.com/solutions/claude-code-security](http://claude.com/solutions/claude-code-security)。