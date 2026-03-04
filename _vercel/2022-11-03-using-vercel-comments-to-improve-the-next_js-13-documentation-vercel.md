---
render_with_liquid: false
title: "Using Vercel comments to improve the Next.js 13 documentation - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/using-vercel-comments-to-improve-the-next-js-13-documentation"
date: "2022-11-03"
scraped_at: "2026-03-02T10:00:00.389267393+00:00"
language: "en-zh"
translated: true
description: "Help us build the Next.js 13 documentation by commenting directly on the docs themselves."
---
render_with_liquid: false
render_with_liquid: false

Nov 3, 2022

2022 年 11 月 3 日

一种协作式工作流，让 Next.js 社区能直接在文档页面上发声。

撰写文档是一项协作性工作——而反馈也理应如此。随着 Next.js 13 的发布，我们积极倾听社区声音，以确保文档尽可能清晰、易读且全面。

为助力这一目标，我们在 Next.js 13 文档中启用了全新的 Vercel 评论功能（Beta 版）。截至目前，已有 2,286 名参与者加入、发起 509 个讨论话题，并解决了 347 个问题。由社区驱动的文档质量正朝着历史最高水平稳步迈进。

欢迎访问 [beta.nextjs.org/docs](https://beta.nextjs.org/docs) 亲自体验。

## 更快速响应用户反馈

我们[近期发布了](https://vercel.com/blog/introducing-commenting-on-preview-deployments) 在[预览部署（Preview Deployments）](https://vercel.com/docs/concepts/deployments/preview-deployments) 上添加评论的功能，旨在通过简化的反馈闭环帮助团队更快交付成果。开发者现在只需推送代码，即可在生产基础设施上获得网站的预览部署版本，并允许相关方直接从终端用户视角，对文案、UI 元素及交互流程进行评论。

当所有反馈都集中于同一平台，无需额外引入工具或定义新的协作流程时，开发者便能轻松追踪待修复与待优化事项，从而助力团队更早交付更高品质的成果。

> “评论功能最初是为私有场景设计的，因此我一度犹豫是否该将其应用于一个公开、高曝光度的网站，并设置‘任何拥有公开链接者均可评论’的权限。但我的担忧被证明是多余的。社区反馈所赋予的价值，实在令人惊叹。”  
>  
> ![](images/using-vercel-comments-to-improve-the-next_js-13-documentation-vercel/img_001.png)  
>  
> **Malte Ubl — Vercel 首席技术官（CTO）**

Vercel 内部各团队已成功将评论功能应用于各类场景：从 [Next.js Conf 官网](https://nextjs.org/conf) 和每周更新日志，到诸如 [监控日志（logs for monitoring）](https://vercel.com/changelog/monitoring-is-in-public-beta-for-enterprise-teams) 等新产品体验。鉴于文档在打造卓越开发者体验过程中扮演着至关重要的角色，我们不仅在内部预览部署版本上启用评论功能，更进一步将其扩展至 Next.js 13 文档的正式发布版。

### Improved context

### 上下文更清晰

In the past, we've taken feedback for the Next.js docs from Twitter, shared Slack workspaces, GitHub, Discord, and anywhere else we can hear back from the community. We wanted to try tracking feedback where proper context could be given to product owners, especially with such a large community wanting to share observations.

过去，我们通过 Twitter、共享的 Slack 工作区、GitHub、Discord 以及任何能听到社区反馈的渠道，收集 Next.js 文档的用户意见。我们希望尝试一种新的反馈追踪方式，使产品负责人能够获得充分、准确的上下文信息——尤其当有如此庞大的社区群体渴望分享他们的观察与见解时。

![A screenshot of the Next.js 13 beta docs with many preview comments. Even with this much feedback, we can quickly understand the exact parts of the UI that need improving.](images/using-vercel-comments-to-improve-the-next_js-13-documentation-vercel/img_002.jpg)  
一张 Next.js 13 Beta 版文档页面截图，显示了大量预览评论。即便收到如此多的反馈，我们也能迅速定位 UI 中亟需优化的具体部分。

With comments on Preview Deployments, we can more clearly address the exact piece of UI or content that a commenter is focused on. A reviewer doesn’t have to go through the process of taking screenshots, posting in other channels, or going out of their way to give extra detail to their product owner about the circumstances of their feedback.

借助预览部署（Preview Deployment）上的评论功能，我们能更精准地响应评论者所关注的 UI 元素或具体内容。评审者无需再费力截取屏幕、在其他渠道发帖，或额外花时间向产品负责人详细说明反馈发生的具体情境。

With a comment on a Preview Deployment, proper context is the default.

在预览部署上添加评论时，“具备完整上下文”已成为默认设置。

### Greater feedback volume—with a tighter cycle

### 反馈量更大——反馈周期更短

The ability to comment on Preview Deployments means a low barrier to entry when it comes to feedback. Because of this ease, over 2,000 reviewers felt empowered to express their thoughts so far. With 509 discussion threads started, the Next.js community was eager to answer each other's questions as well as leave thoughtful comments for the Next.js team.

支持在预览部署上直接评论，显著降低了用户提交反馈的门槛。正因如此便捷，截至目前已有超过 2,000 名评审者主动表达了自己的想法；共发起 509 个讨论主题，Next.js 社区成员不仅积极互答疑问，也纷纷为 Next.js 团队留下富有洞见的评论。

With a greater centralization of feedback happening all in one place, we're able to handle the larger amount of feedback without feeling overwhelmed.

随着所有反馈进一步集中于同一平台，我们得以高效处理激增的反馈量，而不会感到不堪重负。

![A screenshot of preview comments showing a conversation between Next.js team member and community.](images/using-vercel-comments-to-improve-the-next_js-13-documentation-vercel/img_003.jpg)  
![A screenshot of preview comments showing a conversation between Next.js team member and community.](images/using-vercel-comments-to-improve-the-next_js-13-documentation-vercel/img_004.jpg)  
一张预览评论截图，展示了 Next.js 团队成员与社区成员之间的对话。

But the communication loop doesn’t end there. Preview Deployments notify reviewers when a new deployment is available on the git branch so they can refresh the page for the latest changes. Additionally, reviewers receive emails when their comments have been resolved, confirming that their voice has been heard.

但沟通闭环并未止步于此。当 Git 分支上有新部署就绪时，预览部署会主动通知评审者，方便他们刷新页面查看最新变更；此外，当评审者的评论被处理完毕后，系统还会自动发送邮件通知，切实确认“他们的声音已被听见”。

### Fewer, faster iterations

### 更少的迭代次数，更快的迭代速度

With comments, we were able to act on feedback faster and more precisely, while spending less time trying to figure out _**where**_ the issue is so that we can address it. A comment marks exactly in the UI where things need to improve as it's actually attached to the underlying DOM element.

借助评论功能，我们能够更快速、更精准地响应反馈，同时大幅减少用于定位问题 _**所在位置**_ 的时间，从而更高效地解决问题。评论直接绑定在底层 DOM 元素上，因此能在用户界面（UI）中精确定位需要改进的具体位置。

At a greater feedback volume, we've had more information to work with so we can address interrelated comments and iterate on improvements faster than ever.

当反馈量增大时，我们可利用的信息也更加丰富，因而能更有效地处理彼此关联的评论，并以前所未有的速度推进改进与迭代。

## **Get started with better feedback on your Preview Deployments**

## **通过预览部署获取更优质的反馈**

Using comments on the Next.js docs is just one example of this feature in action. To use comments on your Vercel Preview Deployments, [enable the comments public beta](https://vercel.com/enable-comments), deploy a preview branch, and start streamlining your team's internal feedback process.

在 Next.js 官方文档中使用评论功能，只是该特性的其中一个实际应用示例。如需在您的 Vercel 预览部署中启用评论功能，请[开启评论公测版](https://vercel.com/enable-comments)，部署一个预览分支，即可开始优化团队内部的反馈流程。

To get started use a [template](https://vercel.com/templates) or sign up for a [free Vercel account](https://vercel.com/signup).

立即开始：使用一个 [模板](https://vercel.com/templates)，或注册一个 [免费的 Vercel 账户](https://vercel.com/signup)。