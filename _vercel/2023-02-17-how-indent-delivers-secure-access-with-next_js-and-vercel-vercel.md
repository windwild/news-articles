---
title: "How Indent delivers secure access with Next.js and Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-indent-delivers-secure-access-with-next.js-and-vercel"
date: "2023-02-17"
scraped_at: "2026-03-02T09:55:05.287975947+00:00"
language: "en-zh"
translated: true
description: "Indent"
---
{% raw %}

Feb 17, 2023

2023 年 2 月 17 日

[Indent](https://indent.com/) 是一家安全公司，致力于帮助团队更快速、更安全地执行关键业务操作。他们协助 HackerOne、Modern Treasury 和 PlanetScale 等组织，为工程团队提供云基础设施的临时访问权限，并为 IT 与安全团队提供管理员权限提升（admin escalation）管理能力。

其客户最看重的核心优势之一，是公司全员均可通过 Slack 或 Web 控制台轻松发起、审批和撤销访问权限——整个流程直观易用。为此，Indent 选择了 [Next.js](https://vercel.com/solutions/nextjs)，以提供卓越的开发者体验，同时确保终端用户在使用其应用及面向公众的网站时获得高性能、低延迟的体验。

> “客户给予我最喜爱的用户体验反馈是：‘这个应用怎么这么快？’ 正因为我们从第一天起就基于 Next.js 和 Vercel 构建，页面几乎瞬时加载——这对关乎任务成败的关键型软件而言至关重要。”  
> “客户给予我最喜爱的用户体验反馈是：‘这个应用怎么这么快？’ 正因为我们从第一天起就基于 Next.js 和 Vercel 构建，页面几乎瞬时加载——这对关乎任务成败的关键型软件而言至关重要。”  
>   
> ![](images/how-indent-delivers-secure-access-with-next_js-and-vercel-vercel/img_001.png)  
>   
> **Fouad Matin，联合创始人兼首席执行官**

### 借助预览部署（Preview Deployments）加速反馈周期

Indent 所有产品与市场工作最终都会生成一个 Vercel [预览部署（Preview Deployment）](https://vercel.com/docs/concepts/deployments/preview-deployments)，可供实时反馈——即便团队成员分布在全球各地。当工程师需要获取设计或交互层面的反馈时，只需将预览链接分享给相关干系人；该链接支持直接在页面上留下实时评论。短短几分钟内，即可完成首轮反馈；而在正式上线前，还可邀请真实客户验证变更是否符合预期。

**预览部署将反馈周期缩短了 80%。** 过去需等待功能上线生产环境后才能收集用户意见，如今反馈已深度融入开发流程本身。

![通过评论功能，接收来自团队成员及受邀协作者对您的预览部署的反馈。](images/how-indent-delivers-secure-access-with-next_js-and-vercel-vercel/img_002.jpg)  
通过评论功能，接收来自团队成员及受邀协作者对您的预览部署的反馈。

Indent 的工程团队无需再耗费大量时间手动管理配置变更，也无需操心 React 版本升级——这得益于 Next.js 开箱即用的智能默认配置。作为一家安全公司，及时更新软件版本、修补已知漏洞至关重要；而 Next.js 极大地简化了这一过程。

> “Next.js 团队对‘零迁移成本特性’（zero-migration features）的持续投入——例如迁移到 Webpack 5、集成 SWC 编译器、内置 TypeScript 支持与代码检查（linting）——为我们源源不断地带来免费且显著提升开发体验的改进。”  
> “Next.js 团队对‘零迁移成本特性’（zero-migration features）的持续投入——例如迁移到 Webpack 5、集成 SWC 编译器、内置 TypeScript 支持与代码检查（linting）——为我们源源不断地带来免费且显著提升开发体验的改进。”  
>   
> ![](images/how-indent-delivers-secure-access-with-next_js-and-vercel-vercel/img_003.png)  
>   
> **Natalie Marleny，软件工程师**

Along with faster feedback, running Next.js on Vercel allows Indent to take full advantage of a modern CMS like [Sanity](https://vercel.com/integrations/sanity). Non-technical team members can contribute to marketing content without touching code, and Preview Deployments ensure feedback stays just as fast. Preview URLs automatically update when new content is created, so changes don't require a redeploy or engineering support. For Indent, that means faster iteration and time saved for the most critical projects.

除了更快的反馈速度外，在 Vercel 上运行 Next.js 还使 Indent 能够充分利用 [Sanity](https://vercel.com/integrations/sanity) 等现代 CMS 的全部能力。非技术团队成员无需编写代码即可参与营销内容创作，而预览部署（Preview Deployments）则确保反馈速度同样迅捷。每当新内容发布时，预览 URL 会自动更新，因此内容变更无需重新部署，也无需工程师支持。对 Indent 而言，这意味着更快速的迭代周期，以及为最关键项目节省宝贵时间。

Want to see how your team could achieve a better workflow? [Get in touch](https://vercel.com/contact/sales).

想了解您的团队如何实现更高效的工作流？[联系我们](https://vercel.com/contact/sales)。
{% endraw %}
