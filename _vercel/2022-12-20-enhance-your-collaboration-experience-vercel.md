---
title: "Enhance your collaboration experience - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/making-live-reviews-a-reality-enhanced-preview-experience"
date: "2022-12-20"
scraped_at: "2026-03-02T09:57:16.249549158+00:00"
language: "en-zh"
translated: true
description: "Vercel Preview Deployments"
---
&#123;% raw %}

Dec 20, 2022

2022 年 12 月 20 日

让实时评审成为现实。

当团队能够轻松共享正在进行中的工作并即时评论时，重大创意便能更快涌现。今天，我们面向所有使用 Vercel 的团队推出“预览部署（Preview Deployments）评论功能”，让网站与应用的协作体验，如同编辑 Google 文档或 Figma 文件一般流畅自然。

[预览部署（Preview Deployments）](https://vercel.com/docs/concepts/deployments/preview-deployments) 为您的网站提供一个可共享、具备生产环境质量的 URL；而新增的评论功能，则让您能在所构建产品的实际上下文中进行实时反馈。其结果是：迭代周期大幅缩短，开发者、设计师、产品经理、利益相关方等各方所贡献的反馈质量显著提升。

### 为何选择预览部署（Preview Deployments）？

[预览部署（Preview Deployments）](https://vercel.com/features/previews) 常被我们的客户誉为最喜爱的 Vercel 功能之一，它能快速赋能团队实现高效迭代。

无需耗费数天时间手动配置预发布环境（如 Staging 环境），Vercel 会在每次代码变更后自动创建一个可共享的实时 [预览 URL（Preview URL）](https://vercel.com/docs/concepts/deployments/preview-deployments#preview-urls)，让任何人皆可即时体验您的网站——且体验效果与生产环境完全一致。

![面向 GitHub、GitLab 和 Bitbucket 的零配置预览，原生集成支持。](images/enhance-your-collaboration-experience-vercel/img_001.jpg)![面向 GitHub、GitLab 和 Bitbucket 的零配置预览，原生集成支持。](images/enhance-your-collaboration-experience-vercel/img_002.jpg)面向 GitHub、GitLab 和 Bitbucket 的零配置预览，原生集成支持。

随着预览部署评论功能的加入，您现在可以：

- 在每一页上全面评审最终 UI 设计，包括所有交互细节。

- Test across browsers, with browser and device metadata attached to every comment.

- 跨浏览器测试，每个评论均附带浏览器和设备元数据。

- Receive comments from your team that are tracked in your PRs.

- 接收团队成员的评论，这些评论将被追踪并关联至您的 Pull Request（PR）中。

- Use comments in a [CLI workflow](https://vercel.com/docs/cli/deploying-from-cli)—deployments created via CLI, not from `main`, will generate Preview Deployments with comments enabled.

- 在 [CLI 工作流](https://vercel.com/docs/cli/deploying-from-cli) 中使用评论功能——通过 CLI 创建（而非从 `main` 分支触发）的部署，将自动生成已启用评论功能的预览部署（Preview Deployment）。

> “Comments have greatly improved our feedback process both internally among our marketers and designers and externally with our global clients—everything happens in the Preview and nothing gets lost in screenshots being sent back and forth.”  
>  
> “评论功能极大优化了我们的反馈流程：无论是在内部营销与设计团队之间，还是在面向全球客户的外部协作中——所有讨论均在预览环境中进行，再也不会因来回发送截图而遗漏任何信息。”

> ![](images/enhance-your-collaboration-experience-vercel/img_003.jpg)  
>  
> **Wunderman Thompson**  
>  
> **Wunderman Thompson**

### Importance of a centralized async feedback process

### 集中式异步反馈流程的重要性

With an increasing number of teams going remote, the tools we work with need to be collaborative and remove barrier to entry.

随着越来越多的团队转向远程办公，我们所使用的工具必须具备协作能力，并尽可能降低使用门槛。

Using comments for feedback in your Preview Deployments removes fragmented reporting in additional tools, Slack, and email with out-of-context screenshots. Additionally, being able to pinpoint visual issues right in the browser instead of having to dive into code means you get to production faster.

在预览部署中使用评论功能收集反馈，可避免将问题分散报告至其他工具、Slack 或邮件中，并杜绝脱离上下文的截图沟通。此外，您可直接在浏览器中精确定位视觉问题，无需反复查阅源代码，从而显著加快上线速度。

> “Using comments on our Preview Deployments for feedback means our team has reduced time spent going back and forth by up to 80%. There are so many questions that don't need to be answered when you have the context of a comment right on your screen.”  
>  
> “在预览部署中使用评论功能收集反馈，使我们团队在反复沟通上耗费的时间减少了高达 80%。当评论上下文直接呈现在屏幕上时，大量问题便不再需要额外解释。”

> ![](images/enhance-your-collaboration-experience-vercel/img_004.svg)  
>  
> **Viable**  
>  
> **Viable**

### What rapid iteration means for high-growth teams

### 快速迭代对高增长团队的意义

Waiting for new changes to update or collecting unorganized feedback from across various channels adds unnecessary wasted time to your workflows. With Vercel, you can make an update, see it in a live pre-production environment, and share it immediately with your team. Feedback and brainstorming become more accessible, allowing teams like marketing and design to share ideas directly with those implementing them.

等待新变更生效，或从多个渠道零散收集反馈，都会为工作流引入不必要的耗时。借助 Vercel，您只需完成一次更新，即可立即在实时的预生产环境中查看效果，并即时与团队共享。反馈与头脑风暴因此变得更加便捷高效，使市场、设计等团队能够直接将创意传达给实际执行的开发人员。

You keep your momentum and big ideas happen faster—together.

您保持前进的动力，伟大的创意便能更快地共同实现。

All Pro and Enterprise teams will have the ability to use comments on their Preview Deployments, by default, for free.

所有 Pro 和 Enterprise 团队将默认免费获得在预览部署（Preview Deployments）中使用评论功能的能力。

[Get started today](https://vercel.com/docs/concepts/deployments/comments).

[立即开始使用](https://vercel.com/docs/concepts/deployments/comments)
&#123;% endraw %}
