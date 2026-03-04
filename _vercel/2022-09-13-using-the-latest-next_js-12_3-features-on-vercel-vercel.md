---
title: "Using the latest Next.js 12.3 features on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/using-the-latest-next-js-12-3-features-on-vercel"
date: "2022-09-13"
scraped_at: "2026-03-02T10:00:40.820442984+00:00"
language: "en-zh"
translated: true
description: "Vercel natively supports and extends Next.js 12.3, allowing teams to improve their workflow and iterate faster."
---
{% raw %}

Sep 13, 2022

2022 年 9 月 13 日

When we created Next.js in [2016](https://vercel.com/blog/next), we set out to make it easier for developers to create fast and scalable web applications, and over the years, Next.js has become one of the most popular React frameworks. We’re excited to release [Next.js 12.3](https://nextjs.org/blog/next-12-3) which includes Fast Refresh for `.env` files, improvements to the Image Component, and updates to upcoming routing features.

2016 年，我们创建了 Next.js（参见 [博客文章](https://vercel.com/blog/next)），初衷是让开发者更轻松地构建快速、可扩展的 Web 应用；多年来，Next.js 已发展成为最受欢迎的 React 框架之一。我们很高兴地推出 [Next.js 12.3](https://nextjs.org/blog/next-12-3)，该版本新增了对 `.env` 文件的 Fast Refresh 支持、优化了 Image 组件，并更新了即将推出的路由功能。

While these Next.js features work out of the box when self-hosting, Vercel natively supports and extends them, allowing teams to improve their workflow and iterate faster while building and sharing software with the world.

尽管这些 Next.js 功能在自托管场景下开箱即用，Vercel 则原生支持并进一步扩展了这些能力，助力团队优化工作流、加速迭代，从而更高效地构建和向全球共享软件。

Let’s take a look at how these new Next.js features are enhanced on Vercel.

下面我们来看看这些全新的 Next.js 功能在 Vercel 平台上是如何得到增强的。

## Environment Variables

## 环境变量

Environment variables allow you to store and use secrets in your applications without exposing them. Next.js and Vercel have built-in support to conveniently manage environment variables across teams and the project lifecycle.

环境变量使您能够在应用中安全地存储与使用密钥（secrets），而无需将其暴露在外。Next.js 与 Vercel 均内置了对环境变量的便捷管理支持，覆盖团队协作与项目全生命周期。

The latest release of Next.js extends [Fast Refresh](https://nextjs.org/docs/basic-features/fast-refresh) to some configuration files, including when you [make changes to environment variables inside .env files](https://twitter.com/nextjs/status/1567923180295053312?s=20&t=yIEhU3s7rjv9Hty651C7tQ).

Next.js 最新版本将 [Fast Refresh](https://nextjs.org/docs/basic-features/fast-refresh) 功能扩展至部分配置文件，包括当您[修改 `.env` 文件中的环境变量时](https://twitter.com/nextjs/status/1567923180295053312?s=20&t=yIEhU3s7rjv9Hty651C7tQ)。

On Vercel, you can easily enhance your workflow from local machine into the cloud without using an external tool or building custom infrastructure to manage your secrets. Environment variables can be configured in your project settings on the Vercel dashboard.

在 Vercel 上，您无需借助外部工具或自行搭建定制化基础设施来管理密钥，即可轻松将本地开发工作流无缝延伸至云端。您可在 Vercel 控制台的项目设置中直接配置环境变量。

![](images/using-the-latest-next_js-12_3-features-on-vercel-vercel/img_001.jpg)

![](images/using-the-latest-next_js-12_3-features-on-vercel-vercel/img_001.jpg)

These values are encrypted and [only visible to individuals with the correct privileges](https://vercel.com/docs/concepts/teams/roles-and-permissions), making it safe to add sensitive data like authentication tokens or private keys.

这些值均经过加密处理，且[仅对具备相应权限的人员可见](https://vercel.com/docs/concepts/teams/roles-and-permissions)，因此您可以安全地添加认证令牌（authentication tokens）、私钥（private keys）等敏感数据。

Finally, when developing locally, you can [pull environment variables](https://vercel.com/docs/cli#commands/env) from Vercel into your Next.js application, which will automatically create a `.env` file in your local project.

最后，在本地开发时，您可以从 Vercel [拉取环境变量](https://vercel.com/docs/cli#commands/env) 到您的 Next.js 应用中，这将自动在本地项目中创建一个 `.env` 文件。

To learn more about environment variables on Vercel, read our [documentation](https://vercel.com/docs/concepts/projects/environment-variables).

如需进一步了解 Vercel 上的环境变量，请查阅我们的 [文档](https://vercel.com/docs/concepts/projects/environment-variables)。

## Image Optimization

## 图像优化

Images are a fundamental part of the web but significantly contribute to a page’s weight and overall site speed. This makes it important to optimize images for faster site performance, better user experience, and healthier [Core Web Vitals](https://vercel.com/docs/concepts/analytics/web-vitals#core-web-vitals).

图像是网页的基本组成部分，但同时也显著增加了页面体积和整体网站加载时间。因此，对图像进行优化对于提升网站性能、改善用户体验以及保障更健康的 [核心网页指标（Core Web Vitals）](https://vercel.com/docs/concepts/analytics/web-vitals#core-web-vitals) 至关重要。

However, optimizing images is a multi-step process that can be difficult to scale manually and consistently enforce. For example, some steps may include: converting image formats, reducing file sizes, updating code to follow the latest best practices, uploading files to a Content Delivery Network, and connecting everything to a live website.

然而，图像优化是一个多步骤流程，手动规模化执行并保持一致性颇具挑战。例如，部分步骤可能包括：转换图像格式、减小文件体积、更新代码以遵循最新的最佳实践、将文件上传至内容分发网络（CDN），以及将所有环节集成到线上网站中。

The Next.js [Image Component](https://nextjs.org/docs/basic-features/image-optimization) is an extension of the HTML `<img>` element. It includes built-in optimizations to help you achieve great performance by default. Adding a new image is as simple as [importing the image component](https://nextjs.org/docs/basic-features/image-optimization#using-the-image-component) and pointing it to the local or remote source of the file.

Next.js 的 [Image 组件](https://nextjs.org/docs/basic-features/image-optimization) 是 HTML `<img>` 元素的扩展，内置多项优化功能，可让您开箱即用地获得优异的性能表现。添加一张新图像只需 [导入 Image 组件](https://nextjs.org/docs/basic-features/image-optimization#using-the-image-component)，并指定其本地或远程图像源即可。

When using the Image Component, Next.js will automatically:

使用 Image 组件时，Next.js 将自动完成以下操作：

- Generate a correctly sized image for multiple devices

- 为多种设备生成尺寸适配的图像

- Lazy load images when they enter the viewport

- 在图像进入视口时进行懒加载（lazy loading）

- Prevent [Cumulative Layout Shift](https://nextjs.org/learn/seo/web-performance/cls) of the page as images load

- 防止图像加载过程中引发页面的 [累积布局偏移（Cumulative Layout Shift, CLS）](https://nextjs.org/learn/seo/web-performance/cls)

When deploying, Vercel will automatically:

部署时，Vercel 将自动执行以下操作：

- Optimize and transform source images into multiple variations

- 对源图像进行优化并转换为多种变体

- Cache images around the world on [Vercel’s Edge Network](https://vercel.com/docs/concepts/edge-network/overview)

- 将图像缓存至全球各地的 [Vercel 边缘网络（Edge Network）](https://vercel.com/docs/concepts/edge-network/overview)

- Serve the correct format, size, and quality for each site visitor from the location closest to them

- 根据每位访问者所在地理位置，就近为其提供最适配的格式、尺寸与画质的图像


Furthermore, you can monitor the impact of your images with [Vercel’s Usage tab.](https://vercel.com/docs/concepts/limits/usage) This will provide you with the insight to take any actions to optimize your images or let you know if any large image files are consuming too much bandwidth.

此外，您可通过 [Vercel 的用量（Usage）标签页](https://vercel.com/docs/concepts/limits/usage) 监控图像对整体资源消耗的影响。该工具将为您提供深入洞察，助您采取相应措施优化图像；同时也会提醒您是否存在过大图像文件过度占用带宽的情况。

![](images/using-the-latest-next_js-12_3-features-on-vercel-vercel/img_002.jpg)

Overall, deploying Next.js projects on Vercel gives you improved performance and a better developer experience across your entire workflow.

总体而言，在 Vercel 上部署 Next.js 项目，可显著提升应用性能，并在整个开发工作流中为您带来更优质的开发者体验。

To learn more about image optimization on Vercel, read our [documentation](https://vercel.com/docs/concepts/image-optimization).

如需深入了解 Vercel 上的图像优化功能，请查阅我们的 [文档](https://vercel.com/docs/concepts/image-optimization)。

## The future of Next.js

## Next.js 的未来

Earlier this year, we published our [Layouts RFC](https://nextjs.org/blog/layouts-rfc) which introduced the biggest update to Next.js since it was released. When these features are available, you can expect a full integration with Vercel’s infrastructure primitives such as [Serverless Functions](https://vercel.com/docs/concepts/functions/serverless-functions) and [Edge Functions](https://vercel.com/docs/concepts/functions/edge-functions).

今年早些时候，我们发布了 [布局（Layouts）RFC](https://nextjs.org/blog/layouts-rfc)，这是自 Next.js 首次发布以来最具突破性的更新。待这些功能正式上线后，您将获得与 Vercel 基础设施原语（infrastructure primitives）的完整集成，例如 [无服务器函数（Serverless Functions）](https://vercel.com/docs/concepts/functions/serverless-functions) 和 [边缘函数（Edge Functions）](https://vercel.com/docs/concepts/functions/edge-functions)。

For more insights on the future of layouts and more in Next.js, you’re invited to the global Next.js community conference on October 25th. [Claim your free ticket](https://nextjs.org/conf) and follow [@nextjs](https://twitter.com/nextjs) for more announcements soon.

如需深入了解 Next.js 中布局功能的未来发展方向及其他新特性，诚邀您参加将于 10 月 25 日举办的全球 Next.js 社区大会。[立即领取您的免费门票](https://nextjs.org/conf)，并关注 [@nextjs](https://twitter.com/nextjs)，以及时获取更多最新公告。

## Try Next.js 12.3

## 尝试 Next.js 12.3

- [Join us for an in-depth look at Next.js 12.3](https://vercel.com/try/wbn-live-nextjs-12-3-q-and-a) with VP of Developer Experience Lee Robinson on **Sep. 14 9am PT.**

- 请于 **9 月 14 日（太平洋时间上午 9 点）** 参加由开发者体验副总裁 Lee Robinson 主讲的深度分享活动，全面了解 Next.js 12.3：[点击加入](https://vercel.com/try/wbn-live-nextjs-12-3-q-and-a)。

- And in the meantime, explore the power of Next.js 12.3 on Vercel, get started with our [Next.js template](https://vercel.com/new/clone?s=https%3A%2F%2Fgithub.com%2Fvercel%2Fvercel%2Ftree%2Fmain%2Fexamples%2Fnextjs&template=nextjs&id=67753070&b=main&from=templates).

- 此外，您可立即在 Vercel 上体验 Next.js 12.3 的强大能力——从我们的 [Next.js 模板](https://vercel.com/new/clone?s=https%3A%2F%2Fgithub.com%2Fvercel%2Fvercel%2Ftree%2Fmain%2Fexamples%2Fnextjs&template=nextjs&id=67753070&b=main&from=templates) 开始您的项目。
{% endraw %}
