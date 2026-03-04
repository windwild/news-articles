---
title: "Visual Editing: Click-to-edit content for headless CMSes on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/visual-editing"
date: "2023-05-03"
scraped_at: "2026-03-02T09:52:49.235939425+00:00"
language: "en-zh"
translated: true
description: "Visual Editing"
---
&#123;% raw %}

May 3, 2023

2023 年 5 月 3 日

更快协作的下一步现已登陆 Vercel 前端云。

在 Vercel 预览部署（Preview Deployments）中添加协作式[评论](https://vercel.com/docs/concepts/deployments/comments)，是我们将 Google Docs 和 Figma 的协作工作流引入网页开发的第一步。

今天，我们为您的预览部署界面带来了**可视化内容编辑（Visual Editing）**功能。

无论是开发者还是市场营销团队，任何人都能通过直观的视觉方式直接编辑内容，从而实现更快速的迭代。

该功能由 Vercel 与可组合式内容云 [Sanity](https://www.sanity.io/blog/visual-editing-sanity-vercel?utm_source=vercel.com&utm_medium=referral&utm_campaign=may-vercel-launch) 联合开发。借助我们自主研发的内容源映射（content source-mapping）技术，您无需修改任何网站代码，即可对来自[无头 CMS](https://vercel.com/blog/your-guide-to-headless-commerce) 的内容进行简洁高效的可视化编辑——全面支持**任意 Web 框架**。我们正在制定一项开放的内容源映射规范，未来将使任意 CMS、电商系统或内容源均可原生支持可视化编辑。

[**立即开始**\\
\\
可视化编辑目前处于限量私测阶段，仅面向采用 Sanity 作为内容编辑工作流的企业团队开放。欢迎联系我们了解详情。 \\
\\
联系我们](https://vercel.com/contact/sales)

## 面向全团队的可视化编辑

在单体架构中，直接在服务器上修改内容十分简单，通常借助“所见即所得”（WYSIWYG）编辑器即可完成。然而，在无头技术栈（headless tech stack）中，内容管理与整体系统相互解耦。这种分离使得内容作者难以快速定位并更新网站上的内容。

借助[可视化编辑（Visual Editing）](https://vercel.com/docs/workflow-collaboration/visual-editing)，您将获得一条直达内容的“直连通道”。

You can click-to-edit content on your Vercel site, synchronizing changes back to your headless CMS, without needing to open the CMS dashboard. For more in-depth updates, you have a direct link to where any content lives in your CMS and can make edits there.

您可以在 Vercel 网站上直接点击编辑内容，所做修改将自动同步回您的无头 CMS，无需打开 CMS 后台管理界面。如需进行更深入的内容更新，您还可通过直达链接快速跳转至 CMS 中对应内容所在位置，并在 CMS 内完成编辑。

![](images/visual-editing-click-to-edit-content-for-headless-cmses-on-vercel-vercel/img_001.jpg)![](images/visual-editing-click-to-edit-content-for-headless-cmses-on-vercel-vercel/img_002.jpg)

### Fast content, now collaborative

### 快速交付内容，如今更支持协同协作

Vercel’s frontend cloud has made huge strides for marketing and content-heavy websites. By making the backend modular and providing a home for headless content, we focused on what matters most: the user experience. Now modern sites are fast _and_ dynamic, and with innovations like [Incremental Static Regeneration](https://vercel.com/docs/concepts/incremental-static-regeneration/overview) (ISR), content updates get reflected instantly.

Vercel 的前端云已极大推动了营销类及内容密集型网站的发展。我们通过将后端模块化，并为无头内容提供统一托管环境，聚焦于最核心的要素：用户体验。如今，现代网站既具备极致加载速度，又保持高度动态性；借助 [增量静态再生（Incremental Static Regeneration, ISR）](https://vercel.com/docs/concepts/incremental-static-regeneration/overview) 等创新技术，内容更新可即时生效。

Vercel enables faster feedback loops with [Preview Deployments](https://vercel.com/docs/concepts/deployments/preview-deployments) that automatically update with every commit. Designers, developers, marketers, and other stakeholders can come together in real-time, directly in the UI, to consolidate discussions and make decisions. With everyone working together to refine and optimize the frontend experience you’re able to ship higher quality work faster.

Vercel 依托 [预览部署（Preview Deployments）](https://vercel.com/docs/concepts/deployments/preview-deployments)，实现每次代码提交后自动更新预览环境，从而显著缩短反馈周期。设计师、开发者、营销人员及其他相关方可在用户界面中实时协作，集中讨论并快速决策。当整个团队共同致力于优化前端体验时，您便能以更高效率交付更高质量的成果。

### Visual Editing with Sanity

### 借助 Sanity 实现可视化编辑

Activating Visual Editing with Sanity's modern CMS does not require any changes to how your site is programmed. CMS providers can simply add an additional argument when calling your CMS' API, and visual editing becomes available.

启用 Sanity 这一现代化 CMS 的可视化编辑功能，无需修改您网站现有的任何代码逻辑。CMS 提供方只需在调用其 API 时额外传入一个参数，即可开启可视化编辑能力。

We’re so excited to be partnering with Sanity to launch this feature. Visual Editing, currently in a limited private beta, is accessible for Enterprise Teams using [Sanity](https://www.sanity.io/enterprise?utm_source=vercel.com&utm_medium=referral&utm_campaign=may-vercel-launch) as their content editing workflow. You can see how it works [here](https://youtu.be/ZslEtOdsL1Q).

我们非常荣幸能与 Sanity 联合推出此项功能。目前，可视化编辑功能正处于限量私测阶段，面向采用 [Sanity](https://www.sanity.io/enterprise?utm_source=vercel.com&utm_medium=referral&utm_campaign=may-vercel-launch) 作为内容编辑工作流的企业级团队开放。您可点击此处 [观看演示视频](https://youtu.be/ZslEtOdsL1Q) 了解其实际运作方式。

As of May 18th, Visual Editing is now also available for [Enterprise customers using Builder.io as their CMS](https://vercel.com/changelog/visual-editing-can-now-be-used-with-builder-io).

自 5 月 18 日起，可视化编辑功能亦已向采用 [Builder.io](https://vercel.com/changelog/visual-editing-can-now-be-used-with-builder-io) 作为其 CMS 的企业客户开放。

[**Get started**\\
\\
Visual Editing, currently in a limited private beta, is accessible for Enterprise Teams using Sanity as their content editing workflow. Contact us to learn more. \\
\\
Contact us](https://vercel.com/contact/sales)

[**立即开始**\\
\\
可视化编辑功能目前处于限量私测阶段，面向采用 Sanity 作为内容编辑工作流的企业团队开放。欢迎联系我们，了解更多详情。\\
\\
联系我们](https://vercel.com/contact/sales)

For CMS providers interested to integrate with Visual Editing, [visit our docs for more information.](https://vercel.com/docs/workflow-collaboration/visual-editing/cms-guide)

对于有意与“可视化编辑（Visual Editing）”功能集成的内容管理系统（CMS）提供商，请[访问我们的文档了解更多信息。](https://vercel.com/docs/workflow-collaboration/visual-editing/cms-guide)

Vercel.com landing page

Vercel.com 官网落地页

### See how teams ship faster with frontend cloud

### 了解团队如何借助前端云（Frontend Cloud）更快交付产品

Blog post

博客文章

Feb 27, 2023

2023 年 2 月 27 日

### Your guide to headless commerce

### 无头电商（Headless Commerce）入门指南

![](images/visual-editing-click-to-edit-content-for-headless-cmses-on-vercel-vercel/img_003.jpg)![](images/visual-editing-click-to-edit-content-for-headless-cmses-on-vercel-vercel/img_004.jpg)

Kiana and Peter

Kiana 和 Peter
&#123;% endraw %}
