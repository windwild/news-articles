---
title: "Introducing Commenting on Preview Deployments - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-commenting-on-preview-deployments"
date: "2022-09-22"
scraped_at: "2026-03-02T10:00:30.899110009+00:00"
language: "en-zh"
translated: true
description: "Commenting in Vercel Preview Deployment"
---
&#123;% raw %}

Sep 22, 2022

2022 年 9 月 22 日

将来自组织各处的协作者汇聚一堂。

将来自组织各处的协作者汇聚一堂。

Vercel 致力于通过协作推动创新。自创立之初，我们便通过“预览部署（Preview Deployments）”功能，让团队成员轻松查看代码在真实运行环境中的效果，从而赋能协作。今天，我们迈出关键一步：面向公众开放预览部署的**全新评论功能（Comments）测试版**，进一步提升预览部署的协作能力。通过将所有相关人员纳入开发流程——在预览环境中直接添加评论、并在真实、生产级基础设施上审阅 UI，您能更高效地交付专业成果。

借助 Vercel 自动生成的预览部署中的[评论功能](https://vercel.com/docs/concepts/deployments/comments)，只需分享一个链接，即可前所未有地便捷实现跨团队协作。预览部署持续重塑整个软件开发体验：从创意构思、原型实现，到质量保障（QA），您始终在真实环境中进行测试。

任何被添加至您项目的成员，均可在预览环境中，以终端用户视角，就文案（copy）、组件（components）、交互行为（interactions）等具体元素，在上下文中直接发表评论。所有反馈均集中于同一位置——即该预览部署页面，极大简化了开发者对各类待修复问题的追踪与管理。

## 为何构建此功能？

## 为何构建此功能？

代码审查（Code Review）与拉取请求（Pull Request）是现代软件开发流程中不可或缺的一环。然而，在缺乏完整视觉上下文的情况下，仅凭代码难以给出精准的 UI 反馈。借助预览部署，每个拉取请求都附带一个可实时访问的链接，呈现真实的用户体验；而如今新增的评论功能，则让反馈真正发生于它本该发生的地方。

> “在预览环境中开展评审，使反馈更加一致、更贴近最终交付物，从而加快我们的交付速度。”  
> “在预览环境中开展评审，使反馈更加一致、更贴近最终交付物，从而加快我们的交付速度。”  
>   
> ![](images/introducing-commenting-on-preview-deployments-vercel/img_001.jpg)  
>   
> **Yuhan Luo**，dagster.io 工程师

我们希望确保每一位相关人员都能真正参与开发过程。这意味着，无论技术背景如何，所有利益相关方不仅能发现缺陷（bugs），更能提出新想法，共同推动产出最高质量的工作成果。您甚至可以安装 [Chrome 扩展程序](https://chrome.google.com/webstore/detail/vercel/lahhiofdgnbcgmemekkmjnpifojdaelb)，在任意评论中便捷添加截图，提供更详尽、更具针对性的反馈。

在预览部署中使用评论收集反馈，意味着将协作深度融入您的全部工作空间——评论、截图与通知均可与 [Slack](https://vercel.com/integrations/slack-beta) 实时同步，确保团队始终信息对齐。启用 Slack 集成后，评论线程将在部署页面与 Slack 中双向同步，整场讨论既可在部署页查看与回复，也可在 Slack 中完成。您还可为启用了评论功能的拉取请求配置一项**非阻断式检查（non-blocking check）**，在代码对外发布前，自动提醒作者处理尚未解决的评论。

Get your whole team involved in the development process.

让整个团队都参与到开发流程中来。

[Enable the comments public beta](https://vercel.com/enable-comments) in your projects today to get started.

今天就在您的项目中[启用评论功能公开测试版](https://vercel.com/enable-comments)，立即开始使用。
&#123;% endraw %}
