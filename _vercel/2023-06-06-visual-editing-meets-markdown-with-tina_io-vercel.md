---
title: "Visual Editing meets Markdown with Tina.io - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/visual-editing-meets-markdown"
date: "2023-06-06"
scraped_at: "2026-03-02T09:52:22.385800396+00:00"
language: "en-zh"
translated: true
description: "TinaCMS adopts Visual Editing"
---

Jun 6, 2023

2023年6月6日

Learn about click-to-edit for Markdown, MDX, and JSON from Scott Gallant, CEO at Tina.io.

了解 Tina.io 首席执行官 Scott Gallant 关于 Markdown、MDX 和 JSON 的“点击即编辑”功能。

We're excited to share that [TinaCMS](http://tina.io/?utm_source=vercel_guest_post&utm_medium=partner_blog) now supports [Visual Editing](https://vercel.com/docs/workflow-collaboration/visual-editing) in Vercel Preview Deployments.

我们很高兴地宣布：[TinaCMS](http://tina.io/?utm_source=vercel_guest_post&utm_medium=partner_blog) 现已支持 Vercel 预览部署（Preview Deployments）中的 [可视化编辑（Visual Editing）](https://vercel.com/docs/workflow-collaboration/visual-editing) 功能。

The TinaCMS team is on a mission to bring visual editing to the headless CMS in a way that works for developers. So when we had the opportunity to collaborate with Vercel on this, we didn't hesitate and the results are stunning.

TinaCMS 团队的使命，是为无头 CMS（headless CMS）打造真正面向开发者的可视化编辑体验。因此，当这次与 Vercel 合作的机会来临时，我们毫不犹豫地投入其中——成果令人惊艳。

The most impressive thing about Vercel's Visual Editing is the developer experience. It can be enabled without modifying your frontend templates.

Vercel 可视化编辑最令人印象深刻之处在于其卓越的开发者体验：无需修改任何前端模板，即可轻松启用该功能。

## **What is TinaCMS?**

## **什么是 TinaCMS？**

TinaCMS is a headless CMS that stores content in files such as Markdown, MDX, JSON, and more. It stays in-sync with your Git repository and allows content editors to work on branches.

TinaCMS 是一款无头 CMS，内容以文件形式存储（如 Markdown、MDX、JSON 等），与您的 Git 仓库实时同步，并支持内容编辑人员在不同分支上协同工作。

Tina is often used to power large documentation and blog sites, such as [smashingmagazine.com](https://www.smashingmagazine.com/), but it is also a popular choice for marketing sites due to its visual editing functionality.

Tina 常被用于构建大型文档站和博客网站（例如 [smashingmagazine.com](https://www.smashingmagazine.com/)），同时因其强大的可视化编辑能力，也成为营销类网站的热门选择。

## **Why Visual Editing?**

## **为何需要可视化编辑？**

Headless CMSes are dominating the industry because of the huge boost in developer productivity. When your CMS is only concerned about the storage, delivery, and editing of content, developers are free to use any modern framework; making them much more efficient.

无头 CMS 正主导行业趋势，核心原因在于其极大提升了开发者生产力。当 CMS 仅专注于内容的存储、分发与编辑时，开发者便可自由选用任意现代前端框架，从而显著提升开发效率。

But the headless CMS movement came at the cost of the marketer’s productivity. Headless CMSes are so decoupled from the output of a site that marketers and content creators often cannot easily preview their work.  Vercel Preview Deployments improve this process significantly, but there’s still friction when it comes to finding and editing the right piece of content in a CMS, especially if it’s deeply nested inside complex content structures.

但无头 CMS 运动是以牺牲营销人员的生产力为代价的。无头 CMS 与网站最终呈现效果高度解耦，导致营销人员和内容创作者往往难以便捷地预览自己的工作成果。Vercel 预览部署（Preview Deployments）在很大程度上改善了这一流程，但在 CMS 中查找并编辑特定内容时仍存在操作摩擦——尤其是当该内容深嵌于复杂的内容结构中时。

The headless CMS UX can feel archaic to marketers who are familiar with real-time editing experiences in tools like Google Docs, Webflow, or Notion. The pendulum swung to developer productivity and now Visual Editing it’s swinging back to marketer productivity, so you can have both.

对于已习惯 Google Docs、Webflow 或 Notion 等工具实时编辑体验的营销人员而言，无头 CMS 的用户界面（UX）可能显得陈旧过时。此前，行业重心偏向开发者生产力；如今，可视化编辑（Visual Editing）正将重心重新拉回营销人员生产力——二者兼得，已然成为现实。

### A Seamless Experience with TinaCMS

### 借助 TinaCMS 实现无缝体验

Vercel’s Visual Editing experience really shines with Tina because your Vercel Preview Deployment is shown in an iframe, next to the CMS editing interface. So, you're seeing your site and the CMS side-by-side. This allows you to click & edit, then click & edit some more, all without leaving the page. Users don't need to go to a new tab and the experience is seamless. The UX feels like Wix, but under the hood it’s connected to a headless CMS and an open-source framework.

Tina 与 Vercel 的可视化编辑体验相得益彰：你的 Vercel 预览部署以 iframe 形式嵌入，紧邻 CMS 编辑界面显示——网站预览与内容编辑面板并排呈现。你只需点击即可编辑，再点击继续编辑，全程无需离开当前页面；用户不必切换至新标签页，整个体验流畅自然。其交互体验堪比 Wix，而底层却连接着一个无头 CMS 和开源框架。

### **Markdown + Visual Editing**

### **Markdown + 可视化编辑**

Tina stores content in Markdown, MDX, JSON, files and syncs with your Git repository.  Tina spins up a Data Layer so you can fetch your Markdown content just like you would with any other headless CMS. You can self-host Tina’s Data Layer using any KV store, such as [Vercel KV](https://vercel.com/docs/storage/vercel-kv).

Tina 将内容存储于 Markdown、MDX、JSON 等文件中，并与你的 Git 仓库实时同步。Tina 启动一个数据层（Data Layer），使你能够像调用其他任何无头 CMS 那样获取 Markdown 内容。你可使用任意键值（KV）存储服务（例如 [Vercel KV](https://vercel.com/docs/storage/vercel-kv)）来自行托管 Tina 的数据层。

![](images/visual-editing-meets-markdown-with-tina_io-vercel/img_001.jpg)![](images/visual-editing-meets-markdown-with-tina_io-vercel/img_002.jpg)

![](images/visual-editing-meets-markdown-with-tina_io-vercel/img_001.jpg)![](images/visual-editing-meets-markdown-with-tina_io-vercel/img_002.jpg)

This has many benefits, such as:

这带来了诸多优势，例如：

- Version control for your content  
- 内容版本控制  

- Branch workflows for content creators  
- 内容创作者的分支协作流程

- Content is not locked-into a vendor’s database  
- 内容不被锁定在某家供应商的数据库中  

- Scale Markdown to tens of thousands of pages  
- 将 Markdown 内容规模扩展至数万页  

- [Separate repositories](https://tina.io/guides/tinacms/separate-content-repo/guide/?utm_source=vercel_guest_post&utm_medium=partner_blog) for code and content  
- 为代码与内容分别设立[独立仓库](https://tina.io/guides/tinacms/separate-content-repo/guide/?utm_source=vercel_guest_post&utm_medium=partner_blog)  

- Incremental Static Regeneration ( [ISR](https://vercel.com/docs/concepts/incremental-static-regeneration/overview)) and Server-Side Rendering ( [SSR](https://nextjs.org/docs/pages/building-your-application/rendering/server-side-rendering)) for Markdown  
- 针对 Markdown 的增量静态再生（[ISR](https://vercel.com/docs/concepts/incremental-static-regeneration/overview)）与服务端渲染（[SSR](https://nextjs.org/docs/pages/building-your-application/rendering/server-side-rendering)）  

- Consistent data structure enforced across all content files with the [Tina Schema](https://tina.io/docs/schema/?utm_source=vercel_guest_post&utm_medium=partner_blog)  
- 借助 [Tina Schema](https://tina.io/docs/schema/?utm_source=vercel_guest_post&utm_medium=partner_blog)，在所有内容文件中强制执行统一的数据结构  

Tina’s unique approach of a headless CMS on top of Markdown-backed content is what makes it possible to support Vercel’s Visual Editing functionality.  
Tina 独特的架构——在基于 Markdown 的内容之上构建无头 CMS——正是其能够支持 Vercel 可视化编辑（Visual Editing）功能的关键所在。

### **Get Started**  
### **快速开始**

We’re excited to bring Visual Editing to Markdown-based content and we’re enthusiastic about this new era for the headless CMS. We no longer need to choose between the marketer or the developer. We can make both groups happy with Visual Editing on top of a headless CMS.  
我们非常激动地将可视化编辑功能引入基于 Markdown 的内容体系，并热切期待无头 CMS 迎来这一全新发展阶段。我们不再需要在营销人员与开发者之间做出取舍；借助无头 CMS 之上的可视化编辑能力，我们能让这两类用户都获得满意体验。

For more information, please see the [documentation](https://github.com/tinacms/tinacms/blob/main/packages/%40tinacms/vercel-previews/README.md?utm_source=vercel_guest_post&utm_medium=partner_blog) or contact [info@tina.io](mailto:info@tina.io).  
如需了解更多信息，请查阅[文档](https://github.com/tinacms/tinacms/blob/main/packages/%40tinacms/vercel-previews/README.md?utm_source=vercel_guest_post&utm_medium=partner_blog)，或联系 [info@tina.io](mailto:info@tina.io)。