---
title: "Next.js 11, Next.js Live and more: A recap of Next.js Conf Special Edition - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/nextjs-special-event-recap"
date: "2021-06-22"
scraped_at: "2026-03-02T10:04:54.314807483+00:00"
language: "en-zh"
translated: true
description: "Learn more about the latest releases announced at Next.js Conf, including Next.js 11 and Next.js Live."
---

render_with_liquid: false
Jun 22, 2021

2021年6月22日

Last week, over 65,000 members of the Next.js community tuned in to watch a special edition of [Next.js Conf](http://nextjs.org/conf) where we shared our progress toward building a faster web.

上周，超过 65,000 名 Next.js 社区成员观看了特别版的 [Next.js Conf](http://nextjs.org/conf)，我们借此分享了构建更快速网络的最新进展。

Missed it? Here's what you need to know.

错过直播？以下是您需要了解的关键内容。

## Improving User and Developer Experience with Next.js 11

## 借助 Next.js 11 提升用户体验与开发者体验

Next.js 11 continues our mission to provide the best user and developer experience possible.

Next.js 11 延续了我们一贯的使命：为用户和开发者提供尽可能卓越的体验。

With Next.js 11 we introduced a new [Script component](https://nextjs.org/docs/basic-features/script), designed to improve loading performance and give developers greater flexibility when adding third-party scripts to their applications.

借助 Next.js 11，我们推出了全新的 [Script 组件](https://nextjs.org/docs/basic-features/script)，旨在提升页面加载性能，并赋予开发者在向应用中添加第三方脚本时更大的灵活性。

Next.js expert [Lydia Hallie](https://twitter.com/lydiahallie) demonstrated the updated [Image component](https://nextjs.org/docs/basic-features/image-optimization), which now has automatic size detection and support for [blur-up placeholders](https://nextjs.org/docs/api-reference/next/image#placeholder). These updates create a smoother loading experience for end-users and reduce [Cumulative Layout Shift](https://vercel.com/blog/core-web-vitals#cumulative-layout-shift), a Core Web Vital.

Next.js 专家 [Lydia Hallie](https://twitter.com/lydiahallie) 演示了升级后的 [Image 组件](https://nextjs.org/docs/basic-features/image-optimization)，该组件现已支持自动尺寸检测及 [blur-up 占位图](https://nextjs.org/docs/api-reference/next/image#placeholder)。这些改进显著提升了终端用户的加载体验，并降低了核心网页指标（Core Web Vital）之一——[累积布局偏移（CLS）](https://vercel.com/blog/core-web-vitals#cumulative-layout-shift)。

> “Images are often the largest part of web pages, especially in eCommerce. The Community has done a great job improving the Next.js image component since it was released in October. Our focus has been on automating best practices and optimizing for each device viewport the image is delivered to.Images are often the largest part of web pages, especially in eCommerce. The Community has done a great job improving the Next.js image component since it was released in October. Our focus has been on automating best practices and optimizing for each device viewport the image is delivered to.”
>
> “图片通常是网页中体积最大的部分，尤其在电商类网站中尤为明显。自去年 10 月发布以来，社区已为 Next.js 图片组件的持续优化做出了卓越贡献。我们的工作重心始终是自动化最佳实践，并针对图片所交付的每种设备视口进行专门优化。”
>
> ![](images/next_js-11-next_js-live-and-more-a-recap-of-next_js-conf-special-edition-vercel/img_001.jpg)
>
> **Lydia Hallie,** Software Engineer
>
> **Lydia Hallie**，软件工程师

Image, Script, and Font Optimizations were built in partnership with the Google Chrome team and backed by performance research. They were designed to improve loading performance while still allowing developers the flexibility to choose what's right for their application.

图片、脚本与字体优化功能由 Vercel 与 Google Chrome 团队联合开发，并基于深入的性能研究。这些功能旨在提升加载性能，同时仍为开发者保留充分的灵活性，使其能根据自身应用需求自主选择最合适的方案。

Read more about the latest updates on the [Next.js blog](http://nextjs.org/11).

更多关于本次更新的详细信息，请参阅 [Next.js 博客](http://nextjs.org/11)。

## Conformance for Next.js

## Next.js 的一致性规范（Conformance）

Shubhie Panicker 和 Houssein Djirdeh 来自 [Google 的 Aurora 团队](https://web.dev/aurora)，他们与我们共同介绍了 [Next.js 11](https://nextjs.org/11) 中引入的若干基础性优化，并正式宣布 **Next.js 一致性规范（Conformance for Next.js）**。

**一致性规范（Conformance）** 是一套内置于框架中的约束机制与默认配置，旨在帮助开发者为其应用做出最优决策。它将赋能开发者，使其在关乎性能的关键选择上更加自信；同时助力团队在规模化扩张过程中持续保障一致的高质量交付。

> “我学到最重要的一点是：若要让开发者达成并长期维持最佳的应用质量，框架本身必须深度参与，并承担繁重的基础工作。在 Google，我们将原本由开发者承担的复杂任务，迁移至框架层来完成。这意味着，每一位使用该框架的开发者，都能在其所参与的每个项目中，直接获得开箱即用的完整解决方案。”  
>  
> ![](images/next_js-11-next_js-live-and-more-a-recap-of-next_js-conf-special-edition-vercel/img_002.jpg)  
>  
> **Shubhie Panicker**，Google Chrome

[了解更多关于 Next.js 一致性规范的信息。](https://nextjs.org/blog/next-11#conformance)

## Real-time collaboration with Next.js Live

## 借助 Next.js Live 实现实时协作

我们通过发布 **Next.js Live** 的预览版，在构建更快速、更具协作性的 Web 开发流程之路上迈出了重要一步。

Next.js Live 将整个开发流程带入浏览器中，不仅显著提升开发效率，也让组织内更广泛的成员——而不仅是工程师——能够便捷参与。借助 Next.js Live，您可以向团队成员共享协作链接，实现实时聊天、协同绘图与联合编码——全程无需安装任何依赖或下载额外软件。

这意味着真正的实时开发体验：当您在 Next.js Live 中编辑代码时，您与协作者将即时看到所有变更效果，完全无需重新部署。

[立即在我们的 Next.js Commerce 模板中，与团队一起试用 Next.js Live。](http://nextjs.org/live)

![](images/next_js-11-next_js-live-and-more-a-recap-of-next_js-conf-special-edition-vercel/img_003.jpg)

[观看整场特别版主题演讲](https://nextjs.org/conf)，包括 Next.js 11 和 Next.js Live 的演示。

我们非常期待在今年晚些时候与您相约完整的 Next.js Conf 大会，共同庆祝 Next.js 问世五周年。敬请关注后续更多详情。