---
render_with_liquid: false
title: "Mitigating the risk of prompt injections in browser use"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/prompt-injection-defenses"
date: "2025-11-24"
scraped_at: "2026-03-03T06:43:57.142377504+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
render_with_liquid: false
render_with_liquid: false

Product

# Mitigating the risk of prompt injections in browser use

# 在浏览器使用场景中缓解提示注入风险

Nov 24, 2025

2025年11月24日

![Mitigating the risk of prompt injections in browser use](images/mitigating-the-risk-of-prompt-injections-in-browser-use/img_001.svg)

![在浏览器使用场景中缓解提示注入风险](images/mitigating-the-risk-of-prompt-injections-in-browser-use/img_001.svg)

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千场 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——该指数为衡量当今人类与 AI 协作水平提供了一个基准。

Claude Opus 4.5 sets a new standard in robustness to _prompt injections_—adversarial instructions hidden within the content that AI models process. Our new model is a major improvement over previous ones in both its core performance and in the safeguards surrounding its use. But prompt injection is far from a solved problem, particularly as models take more real-world actions. We expect to continue our progress—aiming for a future where AI models (or "agents") can handle high-value tasks without significant prompt injection risk.

Claude Opus 4.5 在抵御**提示注入**（_prompt injections_）方面树立了新标杆——所谓提示注入，是指隐藏于 AI 模型所处理内容中的对抗性指令。相较于此前版本，我们的新模型不仅在核心性能上实现显著提升，其使用过程中的安全防护能力也大幅增强。然而，提示注入远非已解决的问题，尤其当模型越来越多地执行现实世界中的具体任务时，这一挑战愈发突出。我们将持续推进相关工作，致力于实现一个未来愿景：AI 模型（或称“智能体”，agents）能够在无显著提示注入风险的前提下，可靠地完成高价值任务。

## What is prompt injection?

## 什么是提示注入？

For AI agents to be genuinely useful, they need to be able to act on your behalf—to browse websites, complete tasks, and work with your context and data. But this comes with risk: every webpage an agent visits is a potential vector for attack.

为了让 AI 智能体真正具备实用价值，它们必须能够代表您执行操作——例如浏览网页、完成任务，并结合您的上下文与数据开展工作。但这也带来了风险：智能体访问的每一个网页，都可能成为攻击的潜在入口。

By that, we mean that when an agent browses the internet, it encounters content it cannot fully trust. Among legitimate search results, documents, and applications, an attacker might have embedded malicious instructions to hijack the agent and change its behavior. These prompt injection attacks represent one of the most significant security challenges for browser-based AI agents.

具体而言，当智能体在互联网上浏览时，它所接触到的内容并非全部可信。在合法的搜索结果、文档和应用程序之中，攻击者可能已嵌入恶意指令，用以劫持智能体并篡改其行为。这类“提示注入”（prompt injection）攻击，已成为基于浏览器的 AI 智能体所面临最严峻的安全挑战之一。

Below, we explain how prompt injections threaten browser agents, and the improvements we've made to Claude's robustness in response.

下文将阐述提示注入如何威胁浏览器智能体，以及我们为提升 Claude 的鲁棒性所做出的改进。

These improvements have informed our decision to expand the [Claude for Chrome](https://www.claude.com/blog/claude-for-chrome) extension from research preview to beta. It's now available for all users on the Max plan.

上述改进促使我们决定将 [Claude for Chrome](https://www.claude.com/blog/claude-for-chrome) 浏览器扩展从研究预览版升级为公开测试版（beta）。目前，所有订阅 Max 套餐的用户均可使用该扩展。

## **Why browser use creates unique prompt injection risks**

## **为何浏览器使用会带来独特的提示注入风险**

To understand the threat of prompt injections, consider a routine task: you ask Claude to read through your recent emails and draft replies to any meeting requests. One of those emails—ostensibly a vendor inquiry—contains hidden instructions embedded in white text, invisible to you but processed by the agent. These instructions direct the agent to forward emails containing the word "confidential" to an external address before drafting the replies you requested. A successful injection would exfiltrate sensitive communications while you wait for your responses.

要理解提示注入的威胁，不妨设想一个日常任务：您请 Claude 阅读您最近的电子邮件，并为其中所有会议邀约草拟回复。其中一封邮件看似是某供应商的常规咨询，实则在白色文字中隐藏了指令——这些文字对您不可见，却会被智能体完整解析。该指令要求智能体在为您草拟回复前，先将所有包含“confidential”（机密）一词的邮件转发至外部地址。一旦注入成功，敏感通信内容便会在您静候回复的同时被悄然窃取。

While all agents that process untrusted content are subject to prompt injection risks, browser use amplifies this risk in two ways. First, the attack surface is vast: every webpage, embedded document, advertisement, and dynamically loaded script represents a potential vector for malicious instructions. Second, browser agents can take a lot of different actions —navigating to URLs, filling forms, clicking buttons, downloading files—that attackers can exploit if they gain influence over the agent's behavior.

尽管所有处理不可信内容的智能体均面临提示注入风险，但浏览器环境会从两方面显著加剧这一风险。第一，攻击面极为广阔：每一张网页、嵌入式文档、广告以及动态加载的脚本，都可能成为恶意指令的传播载体；第二，浏览器智能体可执行多种操作——例如跳转 URL、填写表单、点击按钮、下载文件等——一旦攻击者获得对智能体行为的操控权，便可利用这些能力实施攻击。

## **Claude's progress on browser use robustness**

## **Claude 在浏览器使用场景下的鲁棒性进展**

We have made significant progress on prompt injection robustness since launching [Claude for Chrome](https://www.claude.com/blog/claude-for-chrome) in research preview. The chart below compares the version of the Claude browser extension that we’re launching today against our original launch configuration, when evaluated against an internal adaptive "Best-of-N" attacker that tries and combines many different prompt injection techniques that are known to be effective.

自 [Claude for Chrome](https://www.claude.com/blog/claude-for-chrome) 作为研究预览版发布以来，我们在抵御提示注入攻击方面的鲁棒性已取得显著进展。下方图表对比了今日发布的 Claude 浏览器扩展新版与最初发布版本，在面对内部自适应型“Best-of-N”攻击者时的表现差异。该攻击者会尝试并组合多种已知有效的提示注入技术。

![](images/mitigating-the-risk-of-prompt-injections-in-browser-use/img_002.jpg)**Attack success rate (ASR) of our internal Best-of-N attacker.** Lower is better. An adaptive attacker is given 100 attempts per environment. ASR is computed as a percentage of attacks encountered by each model.

![](images/mitigating-the-risk-of-prompt-injections-in-browser-use/img_002.jpg)**我方内部 Best-of-N 攻击者的攻击成功率（ASR）**。数值越低越好。每位自适应攻击者在每个环境中拥有 100 次攻击尝试机会。ASR 按各模型所遭遇的攻击次数占总攻击次数的百分比计算。

Claude Opus 4.5 demonstrates stronger prompt injection robustness in browser use than previous models. In addition, since the original preview of the browser extension, we've implemented new safeguards that substantially improve safety across all Claude models.

Claude Opus 4.5 在浏览器环境中的提示注入（prompt injection）鲁棒性，较此前各版本模型有明显增强。此外，自浏览器扩展最初发布预览版以来，我们已部署多项新增防护机制，显著提升了所有 Claude 模型的整体安全性。

A 1% attack success rate—while a significant improvement—still represents meaningful risk. No browser agent is immune to prompt injection, and we share these findings to demonstrate progress, not to claim the problem is solved.

尽管攻击成功率已降至 1%——这已是重大进步——但该数值仍意味着不可忽视的风险。目前尚无任何浏览器智能体能够完全免疫提示注入攻击；我们公开这些成果，旨在展示阶段性进展，而非宣称该问题业已彻底解决。

Our work has focused on the following areas:

我们的工作主要聚焦于以下三个方向：

**Training Claude to resist prompt injection.** We use reinforcement learning to build prompt injection robustness directly into Claude's capabilities. During model training, we expose Claude to prompt injections embedded in simulated web content, and "reward" it when it correctly identifies and refuses to comply with malicious instructions—even when those instructions are designed to appear authoritative or urgent.

**训练 Claude 抵御提示注入。** 我们采用强化学习方法，将提示注入鲁棒性直接内建于 Claude 的能力之中。在模型训练过程中，我们向 Claude 展示嵌入于模拟网页内容中的各类提示注入样本，并在其准确识别出恶意指令、并拒绝执行时给予“奖励”——即便这些指令刻意伪装成具有权威性或紧迫性。

**Improving our classifiers.** We scan all untrusted content that enters the model's context window, and flag potential prompt injections with [classifiers](https://www.anthropic.com/news/constitutional-classifiers). These classifiers detect adversarial commands embedded in various forms—hidden text, manipulated images, deceptive UI elements—and adjust Claude's behavior when they identify an attack. We’ve improved the classifiers we pair with Claude for Chrome since its initial research preview, alongside improvements to the intervention that guides model behavior after they detect an attempted attack.

**优化分类器系统。** 我们对所有进入模型上下文窗口的不可信内容进行扫描，并借助 [分类器](https://www.anthropic.com/news/constitutional-classifiers) 标记潜在的提示注入行为。这些分类器可识别以多种形式嵌入的对抗性指令——例如隐藏文本、篡改图像、欺骗性用户界面元素等；一旦检测到攻击，即动态调整 Claude 的响应行为。自 Chrome 版本首次发布研究预览版以来，我们已持续优化与 Claude 配合使用的分类器，并同步改进了检测到攻击尝试后引导模型行为的干预机制。

**Scaled expert human red teaming.** Human security researchers consistently outperform automated systems at discovering creative attack vectors. Our internal red team continuously probes our browser agent for vulnerabilities. We also participate in external [Arena-style challenges](https://app.grayswan.ai/arena/challenge/indirect-prompt-injection/rules) that benchmark robustness across the industry.

**规模化专家级人工红队演练。** 在发现新颖攻击路径方面，人类安全研究人员始终优于自动化系统。我司内部红队持续对浏览器智能体开展渗透测试，主动挖掘潜在漏洞。同时，我们也积极参与外部 [Arena 形式挑战赛](https://app.grayswan.ai/arena/challenge/indirect-prompt-injection/rules)，以行业通用基准衡量并验证模型鲁棒性。

## **The path forward**

## **未来方向**

The web is an adversarial environment, and building browser agents that can operate safely within it requires ongoing vigilance. Prompt injection remains an active area of research, and we are committed to investing in defenses as attack techniques evolve.

网络本身即为对抗性环境；构建可在其中安全运行的浏览器智能体，需长期保持高度警惕。提示注入仍是当前活跃的研究领域，我们将持续投入资源，随攻击技术演进而不断升级防御能力。

We will continue to publish our progress transparently, both to help customers make informed deployment decisions and to encourage broader industry investment in this critical challenge.

我们将持续以透明方式公开研发进展：一方面助力客户做出更审慎的部署决策，另一方面也推动整个行业加大对这一关键挑战的投入力度。

If you're interested in helping make our models and products more robust to prompt injection, consider [applying to join our team](https://job-boards.greenhouse.io/anthropic/jobs/4949336008).

若您希望参与提升我司模型与产品抵御提示注入的能力，欢迎 [申请加入我们的团队](https://job-boards.greenhouse.io/anthropic/jobs/4949336008)。