---
title: "Recap: Next.js Conf 2024 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/recap-next-js-conf-2024"
date: "2024-10-25"
scraped_at: "2026-03-02T09:40:11.709967757+00:00"
language: "en-zh"
translated: true
description: "Next.js Conf 2024"
---
{% raw %}

Oct 25, 2024

2024 年 10 月 25 日

A quick recap of the biggest highlights from Next.js Conf 2024 in San Fransisco.

快速回顾旧金山举办的 Next.js Conf 2024 最重磅亮点。

Our fifth annual [Next.js Conf](https://nextjs.org/conf) finished yesterday, where we shared our research and upcoming improvements to the framework, as well as what's new in the community and Next.js ecosystem. Over 1,000 people in the Next.js community gathered in San Francisco and tens of thousands around the world watched online to see what's new with Next.js.

我们第五届年度 [Next.js Conf](https://nextjs.org/conf) 昨日圆满落幕。会上，我们分享了团队的最新研究成果、框架即将推出的改进功能，以及社区与 Next.js 生态系统的最新动态。逾千名 Next.js 社区成员齐聚旧金山，全球更有数万名观众在线观看，共同见证 Next.js 的全新进展。

Since last year's conference, we’ve:

自去年大会以来，我们已：

- Released **5 new versions** of Next.js  
- 发布了 **5 个新版本** 的 Next.js  

- Merged **4,000+ pull requests**  
- 合并了 **4,000+ 个 Pull Request**  

- Welcomed **570 new community contributors**  
- 迎来了 **570 位新社区贡献者**  

- Crossed over **7 million downloads per week**, making it the world’s most popular frontend framework according to [StackOverflow Developer Survey](https://stackoverflow.blog/2024/07/24/developers-want-more-more-more-the-2024-results-from-stack-overflow-s-annual-developer-survey/) and [State of JavaScript](https://2023.stateofjs.com/en-US/libraries/front-end-frameworks/)  
- 周下载量突破 **700 万次**，据 [Stack Overflow 开发者调查报告](https://stackoverflow.blog/2024/07/24/developers-want-more-more-more-the-2024-results-from-stack-overflow-s-annual-developer-survey/) 与 [State of JavaScript](https://2023.stateofjs.com/en-US/libraries/front-end-frameworks/) 显示，Next.js 已成为全球最受欢迎的前端框架。

![Next.js isn't possible without our community—thank you.](images/recap-next_js-conf-2024-vercel/img_001.jpg)  
![没有社区，就没有 Next.js——衷心感谢！](images/recap-next_js-conf-2024-vercel/img_001.jpg)  
Next.js isn't possible without our community—thank you.  
没有社区，就没有 Next.js——衷心感谢！

We also released a new [Next.js community GitHub organization](https://github.com/nextjs), which to start contains ten different templates for deploying Next.js to your favorite providers. In the future, we hope to also include community adapters and other resources here.  
我们还正式推出了全新的 [Next.js 社区 GitHub 组织](https://github.com/nextjs)，初期已收录十套面向不同云服务商的 Next.js 部署模板。未来，我们计划在此组织中持续加入社区开发的适配器（adapters）及其他实用资源。

As a thank you to our community, all Next.js Conf ticket proceeds have been donated back to open source projects that make Next.js possible.

为感谢我们的社区，Next.js Conf 门票的所有收入均已捐赠给支撑 Next.js 发展的开源项目。

## Keynote: Make it work, make it right, make it fast

## 主题演讲：先让它运行起来，再让它正确无误，最后让它飞速运转

This year’s keynote outlined how Next.js aligns with three simple principles:

今年的主题演讲阐述了 Next.js 如何契合以下三条简洁原则：

- **Make it work:** More predictable data fetching and rendering with a refined App Router model

- **先让它运行起来：** 借助更完善的 App Router 模型，实现更可预测的数据获取与渲染

- **Make it right:** Turbopack for development is now stable—reduction in memory usage, faster initial compilation for large pages, improved error messages and trace stacks, and more to help you iterate with confidence

- **再让它正确无误：** 开发模式下的 Turbopack 已正式进入稳定版——内存占用降低、大型页面的首次编译速度提升、错误提示与调用栈追踪显著优化，助您更有信心地快速迭代

- **Make it fast:** Fewer, more powerful, and more flexible APIs for easier caching

- **最后让它飞速运转：** 更少、更强大、更灵活的 API，让缓存操作更加轻松

Watch the Next.js Conf 2024 opening keynote.

观看 Next.js Conf 2024 开幕主题演讲。

### Simplifying complexity

### 化繁为简

Complexity can be a blocker. To address this, we’re changing how we present the framework through progressive disclosure of complexity. Meaning, if you’re building something simple, you won’t be overloaded with unnecessary details. And if you need advanced features, they’ll be available when you’re ready.

复杂性可能成为开发障碍。为此，我们正通过“渐进式揭示复杂性”（progressive disclosure of complexity）的方式重构框架的呈现逻辑：若您正在构建简单应用，则不会被冗余细节所淹没；而当您需要高级功能时，它们将随时待命、即取即用。

Based on your feedback, we've re-evaluated [Next.js App Routers caching semantics](https://nextjs.org/blog/next-15#caching-semantics). With Next.js 15, we're changing `GET` Route Handlers and the Client Router Cache from cached by default to uncached by default.

根据大家的反馈，我们已重新评估了 [Next.js App Router 的缓存语义](https://nextjs.org/blog/next-15#caching-semantics)。在 Next.js 15 中，我们将 `GET` 路由处理器（Route Handlers）和客户端路由缓存（Client Router Cache）的默认行为从“默认启用缓存”调整为“默认禁用缓存”。

We're continuing to improve caching in Next.js. Learn more about what's next in [our journey with caching](https://nextjs.org/blog/our-journey-with-caching). This is still experimental and not ready for production. If you try it out, we'd love your feedback.

我们正持续改进 Next.js 中的缓存机制。了解更多关于缓存演进路线的信息，请参阅[我们的缓存探索之旅](https://nextjs.org/blog/our-journey-with-caching)。当前功能仍处于实验阶段，尚未达到生产就绪状态。如果您尝试使用，我们非常期待您的反馈！

Next.js remains a powerful tool for projects of all sizes, but we’re committed to making it feel _effortless_ for every stage of development.

Next.js 依然是适用于各种规模项目的强大工具；但我们致力于让开发流程的**每个阶段**都变得 _轻松自如_。

### Turbopack Dev is now stable

### Turbopack 开发模式现已稳定

Turbopack is now stable for development. With the latest version of Turbopack, you can expect up to **90% faster code updates** versus our previous version, thanks to incremental builds and optimized caching. That means fewer interruptions and faster iterations, so you can stay in your flow.

Turbopack 的开发模式现已正式稳定。借助最新版 Turbopack，得益于增量构建与优化后的缓存机制，代码更新速度相较此前版本最高可提升 **90%**。这意味着更少的中断、更快的迭代，助您始终沉浸于高效开发流中。

Learn more about [Turbopack Dev reaching stability](https://nextjs.org/blog/turbopack-for-development-stable). With this milestone accomplished, we’re shifting our focus to Turbopack for builds. You can track our progress by visiting [areweturboyet.com/build](http://areweturboyet.com/build).

了解更多关于[Turbopack 开发模式达成稳定](https://nextjs.org/blog/turbopack-for-development-stable)的信息。在完成这一里程碑后，我们的工作重心已转向构建（build）场景下的 Turbopack。您可通过访问 [areweturboyet.com/build](http://areweturboyet.com/build) 跟踪进展。

### Better education for self-hosting

### 更完善的自托管教学资源

We released a new [video tutorial](https://www.youtube.com/watch?v=sIVL4JMqRfc) showing how to configure Next.js features like improved image optimization, caching, ISR, streaming, middleware, server components, and more in a self-hosted setup.

我们发布了一则全新[视频教程](https://www.youtube.com/watch?v=sIVL4JMqRfc)，演示如何在自托管环境中配置 Next.js 各项特性，包括增强的图像优化、缓存、增量静态再生（ISR）、流式渲染（streaming）、中间件（middleware）、服务端组件（server components）等。

Full walkthrough on how to self-hosting Next.js.

完整讲解如何自托管 Next.js。

Additionally, in Next.js 15, you can now configure the [`expireTime`](https://nextjs.org/docs/app/api-reference/next-config-js/expireTime) value in `next.config.js`. This was previously the `experimental.swrDelta` option and updating the default value to one year, ensuring most CDNs can fully apply the `stale-while-revalidate` semantics as intended. This is important for self-hosting applications when you may need more control over `Cache-Control` directives.

此外，在 Next.js 15 中，您现在可在 `next.config.js` 中直接配置 [`expireTime`](https://nextjs.org/docs/app/api-reference/next-config-js/expireTime) 选项。该选项此前名为 `experimental.swrDelta`；此次更新将默认值设为一年，确保大多数 CDN 能够按预期完整支持 `stale-while-revalidate` 缓存语义。对于需要精细控制 `Cache-Control` 指令的自托管应用而言，这一点尤为关键。

### ​ **And so much more**

### ​ **还有更多新特性**

Next.js 15 is officially stable and ready for production. Learn more about all the latest features and improvements in our [blog post](https://nextjs.org/blog/next-15).

Next.js 15 已正式发布稳定版，现已可用于生产环境。欢迎通过我们的[博客文章](https://nextjs.org/blog/next-15)了解所有最新特性和改进。

## Thank you Next.js community

## 感谢 Next.js 社区

The community's dedication to open-source contributions, innovative ideas, and constant support is what drives Next.js forward. Every line of code contributed, every issue reported, every feature request, and feedback helps us improve and evolve—we can’t wait to see where the next year takes us.

社区对开源贡献的热忱、富有创意的想法以及持续不断的支持，正是推动 Next.js 不断前行的核心动力。每一行提交的代码、每一个报告的问题、每一项功能请求，以及每一条反馈意见，都在帮助我们持续优化与演进——我们无比期待未来一年将带领我们走向何方。

Check out the recorded sessions [here](https://nextjs.org/conf#sessions).

请在此处查看已录制的会议回放：[此处](https://nextjs.org/conf#sessions)。

· [Follow](https://x.com/intent/follow?screen_name=timneutkens)

· [关注](https://x.com/intent/follow?screen_name=timneutkens)

[View on Twitter](https://x.com/timneutkens/status/1849432262380499445)

[在 Twitter 上查看](https://x.com/timneutkens/status/1849432262380499445)

A developer reached out after enabling Turbopack in Next.js 15:

一位开发者在 Next.js 15 中启用 Turbopack 后主动联系我们：

"The results have been spectacular"

“效果令人惊叹”

Initial compile: 85% faster  
首次编译速度提升 85%

Opening their heaviest page: 97% faster  
打开其最重的页面：速度提升 97%

Fast Refresh on that page: 98% faster  
该页面上的 Fast Refresh：速度提升 98%

We use fairly old Windows machines, and honestly, this change for

我们使用的是相当老旧的 Windows 机器，坦白说，这一改动对……

[8:46 AM · Oct 24, 2024](https://x.com/timneutkens/status/1849432262380499445) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[8:46 上午 · 2024 年 10 月 24 日](https://x.com/timneutkens/status/1849432262380499445) [面向网站的 Twitter、广告信息与隐私政策](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[392](https://x.com/intent/like?tweet_id=1849432262380499445) [Reply](https://x.com/intent/tweet?in_reply_to=1849432262380499445)

[392 次点赞](https://x.com/intent/like?tweet_id=1849432262380499445) [回复](https://x.com/intent/tweet?in_reply_to=1849432262380499445)


[Read 33 replies](https://x.com/timneutkens/status/1849432262380499445)

[查看 33 条回复](https://x.com/timneutkens/status/1849432262380499445)
{% endraw %}
