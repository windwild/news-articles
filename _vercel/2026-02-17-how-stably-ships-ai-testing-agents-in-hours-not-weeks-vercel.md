---
title: "How Stably ships AI testing agents in hours, not weeks - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/How-Stably-ships-AI-testing-agents-in-hours-not-weeks"
date: "2026-02-17"
scraped_at: "2026-03-02T09:21:30.110161367+00:00"
language: "en-zh"
translated: true
description: "How Stably, a 6-person team, ships AI testing agents faster with Vercel, moving from weeks to hours. Their shift highlights how Vercel's platform eliminates infrastructure anxiety, boosting autonomous..."
---

render_with_liquid: false
Feb 17, 2026

2026年2月17日

A 6-person startup learned their bottleneck wasn’t AI. It was infrastructure anxiety. Then they won Vercel’s AI Accelerator.

一家六人初创公司发现，其发展瓶颈并非AI本身，而是基础设施焦虑。随后，他们成功入选Vercel AI加速器计划。

How the 6-person team at Stably ships AI testing agents faster with Vercel—moving from weeks to hours. Their shift highlights how Vercel's platform eliminates infrastructure anxiety, boosting autonomous testing and enabling quick enterprise growth.

Stably这家六人团队如何借助Vercel更快地交付AI测试智能体——将上线周期从数周缩短至数小时。这一转变凸显了Vercel平台如何消除基础设施焦虑，提升自动化测试能力，并加速企业级业务拓展。

Jinjing Liang, co-founder and CEO of Stably, was building something technically ambitious: AI agents that run autonomous end-to-end tests by deploying on preview URLs, reading code diffs, and validating whether changes actually work. Testing is the bottleneck for autonomous coding: AI can write code fast, but without validation, teams get stuck checking everything manually.

Stably联合创始人兼CEO梁晶晶（Jinjing Liang）正在构建一项技术上极具挑战性的产品：AI智能体——它们通过部署至预览URL、读取代码差异（code diffs），并验证变更是否真正生效，从而实现端到端的自主测试。测试是自主编程的最大瓶颈：AI虽能快速生成代码，但若缺乏有效验证，团队便只能陷入手动逐项检查的泥潭。

But Stably had their own bottleneck. Every new feature meant infrastructure decisions. Every new agent meant deployment anxiety. For a team of six, that DevOps overhead was unsustainable.

但Stably自身也面临瓶颈：每新增一项功能，都意味着一次基础设施决策；每上线一个新智能体，都带来一次部署焦虑。对于一支仅六人的团队而言，如此沉重的DevOps负担难以为继。

## Impact at a glance

## 关键成效速览

- **Launch** new product lines in hours instead of weeks  
- **上线**新产品线仅需数小时，而非数周  

- **Ship** internal tools (Slack bots, dashboards) without worrying about deployment  
- **交付**内部工具（如Slack机器人、数据看板）时，无需担忧部署问题  

- **Scale** from early product to enterprise contracts on the same infrastructure  
- **扩展**业务规模——从早期产品平稳过渡至企业级合同，全程依托同一套基础设施  

- **Entire stack** run by a 6-person team, revenue-generating and lean  
- **全栈系统**由六人团队运维，已实现盈利且高度精简

![Vercel meeting with the Stably team](images/how-stably-ships-ai-testing-agents-in-hours-not-weeks-vercel/img_001.jpg)  
Vercel 与 Stably 团队的会议

## **基础设施税**

## **基础设施税**

“Stably 是一个端到端 AI 测试框架，可直接与 Claude Code 等编码智能体（coding agents）集成。” Jinjing 解释道，“我们测试的是真实的应用程序，像真实用户一样逐页点击操作。你的智能体调用 Stably 来验证自身产出结果的正确性，因此你可以并行运行多个智能体，在规模化交付的同时保障功能质量。”

在创立 Stably 之前，Jinjing 曾在 Google Chrome 团队负责基础设施建设，而她的联合创始人 Neil 则曾在 Uber 安全团队工作。两人都曾构建过对微小故障极为敏感的系统——哪怕是一处细微失误，也可能引发远超预期的严重后果。这段经历深刻影响了他们打造 Stably 的方式：**可靠性是底线要求，哪怕团队规模很小**。Stably 当时已实现营收，但始终以极轻量模式运营，尽可能采用 AI 工具提升效率。他们负担不起在 DevOps 上浪费工程资源。

其前端与后端均部署于 Vercel 平台，借助 **AI Gateway** 实现 AI 调用的弹性扩展与高 TPM（每分钟请求数）上限，并利用 **Sandbox** 支持智能体驱动的代码执行。

Jinjing 的团队对技术栈中每一环节都进行了详尽的供应商评估。但每次评估结果都指向同一个结论：Vercel 胜出。每当他们审视替代方案时，权衡逻辑始终如一：更优的开发者体验、更少的 Bug、更少的使用限制、更快的功能迭代速度。

> “总会这样：Vercel 始终提供最佳的开发者体验，Bug 更少、限制更少；而且我们明显看到，他们新功能的上线速度越来越快。”  
> “总会这样：Vercel 始终提供最佳的开发者体验，Bug 更少、限制更少；而且我们明显看到，他们新功能的上线速度越来越快。”  
>   
> ![](images/how-stably-ships-ai-testing-agents-in-hours-not-weeks-vercel/img_002.jpg)  
> **Jinjing Liang，CEO**

她的理念非常简洁：“除非你有充分理由不这么做，否则就该信任社区生态。你的默认立场应是：我必须主动说明——为什么 *不该* 基于 Vercel 构建。”

## **文化范式转变**

## **文化范式转变**

当基础设施不再成为需要反复权衡的决策点时，一件意想不到的事发生了：整个团队的运作节奏彻底改变了。

“We过去常说，‘如果你看到什么，就说出什么’，”金晶回忆道，“但现在我们把它改成了：‘如果你看到什么，就直接去做。’”

“我们过去常说，‘如果你看到什么，就说出什么’，”金晶回忆道，“但现在我们把它改成了：‘如果你看到什么，就直接去做。’”

工程师们不再纠结部署是否会成为瓶颈，产品构想当天就能变成上线功能。原本被列为“有朝一日再做”的内部工具，几小时内便完成了开发。

原本被列为“有朝一日再做”的内部工具，几小时内便完成了开发。

Stably 基于同一套 Vercel 技术栈，快速构建了 Slack 机器人（可搜索数据库并回答问题）、数据看板以及新型 AI 智能体。“我们不再担心发布新产品，因为我们知道部署环节绝不会成为阻碍，”她表示。

Stably 基于同一套 Vercel 技术栈，快速构建了 Slack 机器人（可搜索数据库并回答问题）、数据看板以及新型 AI 智能体。“我们不再担心发布新产品，因为我们知道部署环节绝不会成为阻碍，”她表示。

团队甚至打造了可全自动部署整套服务的内部 AI 智能体。“有人可能会说，‘哦，我特别想加一个新功能’，然后立刻动手实现——所有 DevOps 工作你都能独立完成，而且不再困难。你还可以直接向我们的 Slack 机器人发出请求；这个机器人完全运行在 Vercel 上，它会自动介入、为你构建全部内容，并为你提交 Pull Request。”

团队甚至打造了可全自动部署整套服务的内部 AI 智能体。“有人可能会说，‘哦，我特别想加一个新功能’，然后立刻动手实现——所有 DevOps 工作你都能独立完成，而且不再困难。你还可以直接向我们的 Slack 机器人发出请求；这个机器人完全运行在 Vercel 上，它会自动介入、为你构建全部内容，并为你提交 Pull Request。”

## **借助 Vercel 加速器实现加速发展**

## **借助 Vercel 加速器实现加速发展**

五个月前，Stably 申请加入 Vercel 的 AI 加速器时，公司正处于一个关键拐点。此前数年，他们一直在持续迭代：第一阶段聚焦于用户访谈与问题理解，所构建的产品版本将测试视为事后补救措施——仅作为开发流水线末端附加的一个独立流程。

五个月前，Stably 申请加入 Vercel 的 AI 加速器时，公司正处于一个关键拐点。此前数年，他们一直在持续迭代：第一阶段聚焦于用户访谈与问题理解，所构建的产品版本将测试视为事后补救措施——仅作为开发流水线末端附加的一个独立流程。

但就在正式提交申请前，他们突然意识到：真正的突破点在于将测试能力深度嵌入开发者工作流本身。于是，他们迅速开发出新版产品的初步版本，获得早期用户反馈，并借着这股势头提交了加速器申请。

但就在正式提交申请前，他们突然意识到：真正的突破点在于将测试能力深度嵌入开发者工作流本身。于是，他们迅速开发出新版产品的初步版本，获得早期用户反馈，并借着这股势头提交了加速器申请。

进入加速器项目后，各类研讨会议深刻影响了他们的产品策略与商业思维。在一场由 Vercel、MongoDB 与 HubSpot 联合主办的炉边谈话中，金晶对定价策略获得了全新认知。其中一次分享让她铭记至今：“定价即产品。”

进入加速器项目后，各类研讨会议深刻影响了他们的产品策略与商业思维。在一场由 Vercel、MongoDB 与 HubSpot 联合主办的炉边谈话中，金晶对定价策略获得了全新认知。其中一次分享让她铭记至今：“定价即产品。”

> “过去，我把定价模块直接交给了实习生来处理，”她坦言，“但那次之后，我亲自审阅整个定价方案。如今，我是团队中唯一比其他人更熟悉定价代码的人。这种转变让我真切体会到：原来定价背后竟蕴含如此多深思熟虑。”

> “过去，我把定价模块直接交给了实习生来处理，”她坦言，“但那次之后，我亲自审阅整个定价方案。如今，我是团队中唯一比其他人更熟悉定价代码的人。这种转变让我真切体会到：原来定价背后竟蕴含如此多深思熟虑。”

> _Ready to join this year's Vercel Accelerator?_ [_Applications are open_](https://vercel.com/ai-accelerator) _now until February 16th._

> _今年的 Vercel 加速器正在招募中！_ [_申请通道现已开启_](https://vercel.com/ai-accelerator)，_截止日期为 2 月 16 日。_

Winning the accelerator (and the investment from Vercel Ventures that came with it) shifted Stably's trajectory in ways that went beyond funding. The brand validation opened doors in enterprise sales conversations. "There have been many times where a customer said, 'Oh, you guys were invested by Vercel, right? That's a great signal.' It reinforced what we were already building, and gave enterprise buyers extra confidence."

赢得加速器项目（以及随之而来的 Vercel Ventures 投资）在诸多方面重塑了 Stably 的发展轨迹，其影响远不止于资金支持。这一品牌背书为 Stably 打开了企业销售对话的大门。“曾多次有客户问：‘哦，你们是被 Vercel 投资的，对吧？这真是个极佳的信号。’ 这一认可强化了我们已有的建设方向，也进一步增强了企业买家对我们的信心。”

The LinkedIn announcement about winning the accelerator generated multiple inbound leads, some of which are now closing as contracts.

在 LinkedIn 上宣布赢得加速器项目的公告带来了多条主动咨询线索，其中部分线索目前已进入合同签署阶段。

Since the accelerator, Stably's trajectory has shifted in two main ways. "First,” Jinjing says, “We've started to open-source more of our core product and the tools we've built for our company. We're following the Vercel playbook, Next.js, Turborepo, building a business while empowering developers with open tools. That open-source ethos is exactly what drew us to Vercel in the first place. Second, real revenue traction. Enterprise pilots from the accelerator are converting to contracts."

自加入加速器项目以来，Stably 的发展轨迹主要在两个方向上发生了转变。“第一，” Jinjing 表示，“我们开始将更多核心产品及公司内部构建的工具开源。我们正效仿 Vercel 的发展路径——Next.js、Turborepo——在打造商业业务的同时，以开放工具赋能开发者。这种开源精神，恰恰正是我们最初被 Vercel 吸引的根本原因。第二，切实的营收进展。加速器期间启动的企业试点项目，正陆续转化为正式合同。”

## **What infrastructure should feel like**

## **基础设施本应呈现的模样**

For Stably, infrastructure was never supposed to be the story. The product was the story. Vercel just made sure the infrastructure stayed out of the way.

对 Stably 而言，基础设施从来都不该成为主角；产品本身才是故事的核心。Vercel 所做的，只是确保基础设施始终隐于幕后、不喧宾夺主。

That focus is paying off. A team of six, revenue-generating and lean, is now converting enterprise pilots to contracts, preparing to open-source their testing framework, and shipping new product lines in hours instead of weeks.

这一专注正结出硕果：一支仅六人的精干团队，已实现盈利，并正将企业试点转化为合同，同时筹备开源其测试框架，还能以“小时级”而非“周级”节奏交付新产品线。

The motto that started as an internal culture shift, _if you see something, just do it_, has become the operating principle for the whole company.

最初作为内部文化变革口号提出的“发现问题，立即行动”，如今已成为整家公司的运营准则。

**About Stably:** Stably builds AI-powered end-to-end testing that integrates directly into developer workflows, enabling coding agents to validate their own work at scale.

**关于 Stably：** Stably 致力于构建由 AI 驱动的端到端测试解决方案，可直接嵌入开发者工作流，使编程智能体（coding agents）能够规模化地自主验证自身产出。