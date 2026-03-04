---
title: "Enhanced content management for your headless CMS - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/enhanced-content-management-for-headless-cmses"
date: "2023-06-22"
scraped_at: "2026-03-02T09:51:58.030787335+00:00"
language: "en-zh"
translated: true
description: "Draft Mode and Visual Editing for better content management making it easier to see your latest content changes before they’re published."
---
&#123;% raw %}

Jun 22, 2023

2023 年 6 月 22 日

通过 Vercel 的“草稿模式（Draft Mode）”和“可视化编辑（Visual Editing）”，您可在内容正式发布前抢先查看、审阅并实时编辑。

今天我们很高兴地宣布对 [Draft Mode（草稿模式）](https://vercel.com/docs/workflow-collaboration/draft-mode) 进行更新，让您更轻松地在内容发布前即时预览最新修改。

草稿模式与 [Visual Editing（可视化编辑）](https://vercel.com/blog/visual-editing) 紧密协同——后者是 Vercel 为采用无头内容管理系统（headless CMS）的网站提供的实时内容编辑功能。当您通过可视化编辑进行修改时，可确保这些编辑内容在下次以草稿模式访问该页面时立即呈现。

![](images/enhanced-content-management-for-your-headless-cms-vercel/img_001.jpg)![](images/enhanced-content-management-for-your-headless-cms-vercel/img_002.jpg)

## **什么是草稿模式（Draft Mode）？**

## **什么是草稿模式？**

[Draft Mode（草稿模式）](https://vercel.com/docs/workflow-collaboration/draft-mode) 是此前“预览模式（Preview Mode）”的简化升级版，已深度集成至 Vercel 部署环境的工具栏中。这不仅让所有订阅计划的发布者都能更便捷地将该功能接入自身网站，还为您带来以下能力：

- 轻松实现静态页面的服务器端渲染预览  
- 有效保护未发布内容，防止其被公众访问  
- 无缝对接您选择的任意无头内容服务提供商

When generating blog posts from a headless CMS, you can now have an unpublished draft post that bypasses [Incremental Static Regeneration](https://vercel.com/docs/concepts/incremental-static-regeneration) (ISR) and is not cached. This means that the draft content you write in the CMS is immediately available to your website so you can share a link with someone or edit the draft.

在通过无头 CMS 生成博客文章时，您现在可以创建未发布的草稿文章，该草稿将绕过[增量静态再生](https://vercel.com/docs/concepts/incremental-static-regeneration)（ISR），且不会被缓存。这意味着您在 CMS 中撰写的草稿内容会立即在您的网站上生效，便于您与他人分享链接或继续编辑草稿。

Before Draft Mode, you had to keep refreshing the page until you hit the revalidate period to see the latest draft content, or you would have to configure an API endpoint and hook up a button and use on demand revalidation.

在“草稿模式”（Draft Mode）推出之前，您必须不断刷新页面，直到触发重新验证周期，才能看到最新的草稿内容；或者，您需要自行配置一个 API 端点，添加一个按钮，并使用按需重新验证（on-demand revalidation）功能。

[**See how teams are using Draft Mode**\\
\\
Learn how the team at Formidable enabled marketers, designers, and other collaborators to edit website content without needing to involve developers with Draft Mode and Sanity CMS. \\
\\
Learn more](https://formidable.dev/blog/2023/powering-our-website-s-evolution-next-js-app-router-and-sanity-cms-in-action/)

[**查看团队如何使用草稿模式**\\
\\
了解 Formidable 团队如何借助草稿模式与 Sanity CMS，赋能市场人员、设计师及其他协作者直接编辑网站内容，无需开发者介入。\\
\\
了解更多](https://formidable.dev/blog/2023/powering-our-website-s-evolution-next-js-app-router-and-sanity-cms-in-action/)

## **Updates on Visual Editing**

## **可视化编辑更新**

Visual Editing was another big step in bringing accessible collaboration to web development with a direct connection to your headless CMS. Since [Vercel Ship](https://vercel.com/ship), we have been working to onboard new customers like HashiCorp, Sonos, and Tome and we're happy to share that Visual Editing is now in public beta for Pro and Enterprise teams.

可视化编辑（Visual Editing）是推动 Web 开发实现无障碍协作的又一重要进展，它通过与您的无头 CMS 建立直连，显著提升了协作效率。自 [Vercel Ship](https://vercel.com/ship) 发布以来，我们已陆续接入 HashiCorp、Sonos 和 Tome 等新客户。我们很高兴地宣布：可视化编辑现已面向 Pro 和 Enterprise 计划用户开放公开测试（Public Beta）。

[**Get started**\\
\\
Learn more about how you can uplevel your digital experience with Vercel's Visual Editing, currently in beta for Pro and Enterprise customers. ⁡⁣‌‍‍⁢𝅵‍‍⁡⁢⁡⁠‍𝅳⁠‌⁣𝅴𝅹⁡‍‍⁡𝅸\\
\\
Contact Us](https://vercel.com/contact/sales)

[**立即开始**\\
\\
进一步了解 Vercel 可视化编辑（目前面向 Pro 和 Enterprise 客户公测）如何助您提升数字体验。⁡⁣‌‍‍⁢𝅵‍‍⁡⁢⁡⁠‍𝅳⁠‌⁣𝅴𝅹⁡‍‍⁡𝅸\\
\\
联系我们](https://vercel.com/contact/sales)

Additionally, we’re excited that more CMSes have been able to adopt the content source-mapping technology to enable Visual Editing. In addition to our launch partner, [Sanity](https://www.sanity.io/blog/visual-editing-sanity-vercel?utm_source=vercel.com&utm_medium=referral&utm_campaign=may-vercel-launch), Visual Editing can now be used with the following headless CMSes:

此外，我们非常欣喜地看到，越来越多的 CMS 已成功集成内容源映射（content source-mapping）技术，从而支持可视化编辑功能。除首发合作伙伴 [Sanity](https://www.sanity.io/blog/visual-editing-sanity-vercel?utm_source=vercel.com&utm_medium=referral&utm_campaign=may-vercel-launch) 外，以下无头 CMS 现已支持可视化编辑：

- [Builder](https://www.builder.io/c/docs/vercel-visual-editing)

- [Builder](https://www.builder.io/c/docs/vercel-visual-editing)

- [Uniform](https://uniform.dev/blogs/visual-editing-with-vercel-uniform)

- [Uniform](https://uniform.dev/blogs/visual-editing-with-vercel-uniform)

- [DatoCMS](https://www.datocms.com/blog/introducing-visual-editing-for-vercel-and-datocms-enterprise-customers)

- [DatoCMS](https://www.datocms.com/blog/introducing-visual-editing-for-vercel-and-datocms-enterprise-customers)

- [TinaCMS](https://tina.io/docs/contextual-editing/overview/)

- [TinaCMS](https://tina.io/docs/contextual-editing/overview/)

- [Payload](https://payloadcms.com/docs/integrations/vercel-visual-editing)

- [Payload](https://payloadcms.com/docs/integrations/vercel-visual-editing)

We look forward to even more CMSes adopting the Visual Editing functionality to bring real-time content editing to everyone across the software development process. We've made the documentation public for supporting Visual Editing in your CMS, [get started](https://vercel.com/docs/workflow-collaboration/visual-editing/cms-guide) today.

我们期待更多内容管理系统（CMS）采用“可视化编辑”（Visual Editing）功能，从而在整个软件开发流程中为所有人提供实时内容编辑能力。我们已将支持 CMS 实现可视化编辑的相关文档公开，[立即开始](https://vercel.com/docs/workflow-collaboration/visual-editing/cms-guide) 吧！

Vercel Template

Vercel 模板

Deploy this template

部署此模板

### A clean Next.js + Sanity starter with visual editing, drag-and-drop page builder, live content updates, and AI-powered media support.

### 一款简洁的 Next.js + Sanity 入门模板，支持可视化编辑、拖放式页面构建器、实时内容更新以及 AI 驱动的媒体支持。

Sanity + Next.js Clean App

Sanity + Next.js 简洁应用

Vercel Template

Vercel 模板

Deploy this template

部署此模板

### Builder.io starter for Headless Shopify stores.

### 面向无头 Shopify 商店的 Builder.io 入门模板。

Builder.io Shopify Commerce

Builder.io Shopify 商务
&#123;% endraw %}
