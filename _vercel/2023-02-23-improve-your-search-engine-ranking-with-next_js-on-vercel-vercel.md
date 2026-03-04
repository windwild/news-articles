---
title: "Improve your search engine ranking with Next.js on Vercel - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/nextjs-seo-playbook"
date: "2023-02-23"
scraped_at: "2026-03-02T09:54:38.224819044+00:00"
language: "en-zh"
translated: true
description: "SEO is a critical priority in Next.js on Vercel, letting you rank higher in search engine results and better optimize your content for users."
---

render_with_liquid: false
Feb 23, 2023

2023 年 2 月 23 日

Your app deserves a bigger audience.

你的应用值得拥有更广阔的受众。

Search engine optimization (SEO) lets customers find and trust you more easily. And yet, improving your application's SEO is too often an opaque process. When SEO success feels like magic, you’re not always sure how to repeat or better it.

搜索引擎优化（SEO）能让客户更轻松地发现并信任你。然而，提升应用的 SEO 效果往往是一个不透明的过程。当 SEO 成功仿佛“魔法”一般时，你便难以确定如何复现或进一步优化它。

In this article, we'll demystify SEO, clarifying some of the most technical aspects of the process. SEO doesn't have to be a chore, and with Next.js on Vercel as your solid foundation, you're ready to build up best practices, seeing exponential gains in the process.

本文将揭开 SEO 的神秘面纱，厘清这一过程中一些最具技术性的环节。SEO 不必成为一项苦差事；而以部署在 Vercel 上的 Next.js 为坚实基础，你已准备好构建并践行最佳实践，并在此过程中收获指数级的增长。

So, let’s start from the beginning.

那么，让我们从头开始。

[**Want to follow along?**\\
\\
Use this Next.js template to start your own SEO journey.\\
\\
Deploy Now](https://vercel.com/templates/next.js/nextjs-boilerplate)

[**想边学边练？**\\
\\
使用此 Next.js 模板开启你自己的 SEO 之旅。\\
\\
立即部署](https://vercel.com/templates/next.js/nextjs-boilerplate)

## Competing for better SEO with Next.js

## 借助 Next.js 实现更优 SEO 竞争力

Next.js treats SEO as a critical priority, bringing together tools and recommendations for developers to most easily implement good SEO patterns. Analytics are built into the framework itself, making it easy to monitor your application's performance. When paired with [Vercel's Edge Network](https://vercel.com/docs/concepts/edge-network/overview), you get automated, per-deployment performance statistics for improved decision making.

Next.js 将 SEO 视为关键优先事项，整合各类工具与开发建议，帮助开发者最便捷地落实良好的 SEO 实践。分析功能原生集成于框架之中，使监控应用性能变得轻而易举。再结合 [Vercel 边缘网络（Edge Network）](https://vercel.com/docs/concepts/edge-network/overview)，你将获得自动化的、按每次部署生成的性能统计数据，从而支持更明智的决策。

Here's some more SEO best practices and how you can use Next.js tools to accomplish them.

以下是一些其他 SEO 最佳实践，以及你可如何借助 Next.js 工具来实现它们。

![Adopting SEO is an incremental process where each step allows you to rank higher in search engines while bettering your user experience.](https://vercel.com/vc-ap-vercel-marketing/_next/image?url=https%3A%2F%2Fassets.vercel.com%2Fimage%2Fupload%2Fcontentful%2Fimage%2Fe5382hct74si%2F5yk52RKKsbSOUA8qehIuQ6%2Fa4058911b3cbc5ba151c07acd8238e61%2FInline_Graphic-Light.png&w=1920&q=75)![Adopting SEO is an incremental process where each step allows you to rank higher in search engines while bettering your user experience.](images/improve-your-search-engine-ranking-with-next_js-on-vercel-vercel/img_002.jpg)Adopting SEO is an incremental process where each step allows you to rank higher in search engines while bettering your user experience.

![采用 SEO 是一个渐进式过程：每一步都能助你在搜索引擎中获得更高排名，同时提升用户体验。](https://vercel.com/vc-ap-vercel-marketing/_next/image?url=https%3A%2F%2Fassets.vercel.com%2Fimage%2Fupload%2Fcontentful%2Fimage%2Fe5382hct74si%2F5yk52RKKsbSOUA8qehIuQ6%2Fa4058911b3cbc5ba151c07acd8238e61%2FInline_Graphic-Light.png&w=1920&q=75)![采用 SEO 是一个渐进式过程：每一步都能助你在搜索引擎中获得更高排名，同时提升用户体验。](images/improve-your-search-engine-ranking-with-next_js-on-vercel-vercel/img_002.jpg)采用 SEO 是一个渐进式过程：每一步都能助你在搜索引擎中获得更高排名，同时提升用户体验。

### Rendering and why it matters

### 渲染及其重要性

Instead of browsing websites through clicking, search engines crawl source code in the order it's written, queueing up links to index next. Client-side JavaScript, meanwhile, is sent to a render queue and takes a bit longer (and more compute power) to index.

搜索引擎并非像用户那样通过点击来浏览网站，而是按源代码书写顺序抓取内容，并将发现的链接排队以供后续索引。与此同时，客户端 JavaScript 被送入渲染队列，其索引过程耗时更长，且需要更多计算资源。

This means that prerendering your site statically or on the server is the best practice for SEO, since it makes the crawler willing to reindex your site more frequently. Prerendering methods, however, also have their downfalls, since Static Site Generation (SSG) can often mean slow build times, and Server-side Rendering (SSR) can, without proper caching, lead to slow initial page load performance while blocking rendering for your data being retrieved.

这意味着，对网站进行静态预渲染（static prerendering）或服务端预渲染（server-side prerendering）是 SEO 的最佳实践，因为它能促使爬虫更频繁地重新索引你的网站。然而，各类预渲染方法也各有短板：静态站点生成（SSG）往往导致构建时间过长；而服务端渲染（SSR）若缺乏恰当的缓存机制，则可能在获取数据期间阻塞页面渲染，造成首屏加载缓慢。

To combine the strengths of SSR and SSG, [Next.js offers Incremental Static Regeneration (ISR)](https://vercel.com/docs/concepts/incremental-static-regeneration/overview), which pre-renders all your pages like SSG but also allows you to update specific pages as needed, without redeploying your app. You get your dynamic content at the speed—and crawler indexability—of static.

为融合 SSR 与 SSG 的优势，[Next.js 提供了增量静态再生（Incremental Static Regeneration, ISR）](https://vercel.com/docs/concepts/incremental-static-regeneration/overview)：它像 SSG 那样预先渲染所有页面，同时又支持按需更新特定页面，而无需重新部署整个应用。你得以用静态页面的速度——以及对爬虫的同等可索引性——交付动态内容。

Check out [this deep dive into the Next.js 13 App Router](https://vercel.com/blog/next-js-13-data-fetching) to learn more about rendering dynamically fetched data.

请参阅 [这篇关于 Next.js 13 App Router 的深度解析文章](https://vercel.com/blog/next-js-13-data-fetching)，进一步了解如何渲染动态获取的数据。

### Speed across all platforms

### 全平台性能优化

ISR with Next.js doesn’t just mean that your page can be crawled more easily. It means that your pages will load near-instantly for users. And in SEO, speed affects everything:

Next.js 的 ISR 不仅意味着你的页面更容易被爬虫抓取，更意味着用户访问时页面几乎瞬时加载。而在 SEO 领域，速度影响着方方面面：

1. **User experience.** Faster websites keep users engaged with content for longer, leading to higher conversion rates. Milliseconds of time shaved can, quite literally, [make millions](https://web.dev/milliseconds-make-millions/).

1. **用户体验**：更快的网站能让用户更长时间沉浸于内容之中，从而提升转化率。哪怕只是节省几毫秒——这真的可以[创造数百万美元的价值](https://web.dev/milliseconds-make-millions/)。

2. **Search engine ranking.** Google considers site speed as [a strong ranking factor](https://nextjs.org/learn/seo/web-performance?utm_source=vercel_site&utm_medium=social&utm_campaign=blog_seo_playbook) in their algorithms. Given equal relevance to a topic, your faster website will always rank higher in results, driving organic traffic your way.

2. **搜索引擎排名**：Google 将网站速度视为其算法中[一项关键的排名因素](https://nextjs.org/learn/seo/web-performance?utm_source=vercel_site&utm_medium=social&utm_campaign=blog_seo_playbook)。当内容相关性相当时，速度更快的网站总能在搜索结果中获得更高排名，从而为你带来更多的自然流量。

3. **Mobile optimization.** Most users discover new websites on mobile devices, and Google crawls websites on a mobile browser by default. Your mobile speed affects your search rank on both mobile and desktop devices.

3. **移动端优化**：大多数用户通过移动设备发现新网站，而 Google 默认使用移动版浏览器抓取网页。因此，你的移动端加载速度不仅影响移动搜索排名，也会影响桌面端的搜索排名。

So, besides its rendering strategy, how can Next.js help?

那么，除了其渲染策略之外，Next.js 还能提供哪些帮助？

1. **Image optimization.** Next.js features a plug-and-play [`next/image` component](https://nextjs.org/docs/basic-features/image-optimization?utm_source=vercel_site&utm_medium=social&utm_campaign=blog_seo_playbook) that appropriately formats images based on the user’s device—with minimal additional JavaScript. Since serving oversized images to your user is often the largest speed throttle of an application, `next/image` enhances UX for free.

1. **图像优化**。Next.js 提供开箱即用的 [`next/image` 组件](https://nextjs.org/docs/basic-features/image-optimization?utm_source=vercel_site&utm_medium=social&utm_campaign=blog_seo_playbook)，可根据用户设备自动适配图像格式，且仅需极少额外 JavaScript。由于向用户交付过大的图像通常是拖慢应用加载速度的最主要因素，`next/image` 能在零成本前提下显著提升用户体验（UX）。

2. **Code splitting with dynamic imports.** As your application grows in size, you don’t need to ask your user to load more JavaScript. With [dynamic imports](https://nextjs.org/learn/seo/improve/dynamic-imports?utm_source=vercel_site&utm_medium=social&utm_campaign=blog_seo_playbook), you can choose to defer scripts ( [third-party](https://nextjs.org/learn/seo/improve/third-party-scripts?utm_source=vercel_site&utm_medium=social&utm_campaign=blog_seo_playbook) included) all the way down to the component level, only serving code that will actually be used.

2. **借助动态导入实现代码分割**。随着应用体积不断增大，您无需让用户一次性加载全部 JavaScript。通过 [动态导入（dynamic imports）](https://nextjs.org/learn/seo/improve/dynamic-imports?utm_source=vercel_site&utm_medium=social&utm_campaign=blog_seo_playbook)，您可以将脚本（包括 [第三方脚本](https://nextjs.org/learn/seo/improve/third-party-scripts?utm_source=vercel_site&utm_medium=social&utm_campaign=blog_seo_playbook)）延迟加载至组件级别，仅向用户交付实际会用到的代码。

3. **Font optimization.** Your brand’s custom fonts are heavy, but that doesn’t mean you need to change your look. Next.js has built-in [Automatic Webfont Optimization](https://nextjs.org/docs/basic-features/font-optimization?utm_source=vercel_site&utm_medium=social&utm_campaign=blog_seo_playbook), which eliminates extraneous data fetches and ensures your font always renders on time.

3. **字体优化**。您品牌的自定义字体往往体积较大，但这并不意味着您必须为此牺牲视觉风格。Next.js 内置了 [自动网页字体优化（Automatic Webfont Optimization）](https://nextjs.org/docs/basic-features/font-optimization?utm_source=vercel_site&utm_medium=social&utm_campaign=blog_seo_playbook)，可消除冗余的数据请求，并确保字体始终按时渲染。

4. **Develop once, deploy everywhere.** Gone are the days of creating separate Accelerated Mobile Pages (AMP) for your application. Your codebase on Next.js, when following principles of responsive design, will run quickly across all desktop and mobile devices alike.

4. **一次开发，随处部署**。为您的应用单独构建加速移动页面（AMP）的时代已经一去不返。只要遵循响应式设计原则，您的 Next.js 代码库即可在所有桌面端与移动端设备上快速运行。

Each speed increase is an SEO win, and you can [track your results](https://vercel.com/analytics) in realtime.

每一次性能提升都是一次 SEO 收益；您还可通过 [Vercel Analytics](https://vercel.com/analytics) 实时追踪优化效果。

### Content strategies

### 内容策略

Headers matter. But so do subheaders, lists, tables, and any other elements that visually break up your text for the user. Search engine crawlers use the same types of information to gain context. The more you strategize content, the higher you can rank for specific topics.

标题至关重要；但副标题、列表、表格以及任何能为用户视觉上分隔文本的其他元素也同样重要。搜索引擎爬虫同样依赖这些信息来理解页面上下文。您对内容架构规划得越周密，就越有可能在特定主题上获得更高的搜索排名。

Additionally, make use of structured data, which means following [Schema recommendations](http://schema.org/) for things like events, business information, places, products, and reviews. This allows your data to be [shown natively in Google](https://developers.google.com/search/docs/appearance/structured-data/intro-structured-data), differentiating you from your competition and allowing your users to navigate directly to relevant content.

此外，请善用结构化数据（structured data），即遵循 [Schema.org 的规范](http://schema.org/)，为活动、企业信息、地点、商品、评论等内容添加语义标记。这能让您的数据以原生形式直接呈现在 Google 搜索结果中，从而在竞争中脱颖而出，并帮助用户直达相关核心内容。

While a full exploration of content architecture is beyond the scope of this Next.js-focused article, check out [Google's SEO docs](https://developers.google.com/search/docs/appearance) for the most up-to-date and comprehensive information. For structured data, you can also use [Google’s Structured Data Markup Helper](https://www.google.com/webmasters/markup-helper/u/0/), which generates usable HTML based on your content requirements.

尽管全面探讨内容架构已超出本文聚焦 Next.js 的范畴，我们仍推荐您查阅 [Google 官方 SEO 文档](https://developers.google.com/search/docs/appearance)，获取最新、最全面的权威指南。针对结构化数据，您还可使用 [Google 结构化数据标记助手（Structured Data Markup Helper）](https://www.google.com/webmasters/markup-helper/u/0/)，它能根据您的内容需求自动生成可用的 HTML 标记代码。

### Engineering your way to success

### 以工程化思维铺就成功之路

Writing well-structured content goes a long way to boost your application’s SEO, but there’s even more you can do. When you have a clear vision of your application’s structure, including a knowledge of what pillar pages you want users to engage with most, you can echo that vision in Next.js in a way that doesn’t just improve SEO, but also improves user flow.

精心编写结构清晰的内容，对提升应用的搜索引擎优化（SEO）效果大有裨益；但你还能做得更多。当你对应用的整体架构拥有清晰规划——例如明确哪些“支柱页面”（pillar pages）是希望用户重点访问的核心内容——你便可在 Next.js 中精准复现这一架构愿景：这不仅有助于 SEO，更能显著优化用户浏览路径与交互体验。

**Dynamic metadata**

**动态元数据**

In any application, the HTML `head` component offers a unique SEO opportunity: you can add a huge amount of information about your page to help search engines easily understand where to slot your content and how to display it. Titles, descriptions, meta tags, logos, open graph images, structured data markup, and more all play into the story you want Google to tell about your application.

在任何应用中，HTML 的 `<head>` 组件都蕴含着独特的 SEO 机遇：你可向其中注入大量页面相关信息，帮助搜索引擎快速理解内容定位及其展示方式。标题（titles）、描述（descriptions）、meta 标签、网站 Logo、Open Graph 图片、结构化数据标记（structured data markup）等，共同构建起你希望 Google 向用户讲述的应用故事。

Configuring individual head components for each of your pages can get tedious and messy, so Next.js offers a [dynamic `next/head`](https://nextjs.org/docs/api-reference/next/head?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_seo_playbook) that allows you to separate the logic of your `head` out into as many components as needed. With the built-in `key` attribute, you can make sure your application doesn’t have any duplicate properties fighting for attention.

为每个页面单独配置 `<head>` 组件容易变得繁琐且难以维护。为此，Next.js 提供了 [动态 `next/head`](https://nextjs.org/docs/api-reference/next/head?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_seo_playbook)，让你能将 `<head>` 的逻辑拆分至任意数量的独立组件中。借助内置的 `key` 属性，你还能确保应用中不会出现重复的元数据属性相互冲突。

With the recently introduced App Router, you can [take your metadata a step further](https://beta.nextjs.org/docs/api-reference/metadata?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_seo_playbook), dynamically generating it at a component level, and exporting it all together based on the structure of your application.

随着近期推出的 App Router，你还可以 [将元数据能力再进一步](https://beta.nextjs.org/docs/api-reference/metadata?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_seo_playbook)：在组件级别动态生成元数据，并依据应用自身的目录与路由结构，统一导出全部元信息。

And the best news? We’re currently rolling out [updates to built-in support for SEO in metadata](https://www.youtube.com/watch?v=UfNMlhu3L4I?utm_source=youtube&utm_medium=blog&utm_campaign=blog_seo_playbook) that help your tags be far more legible and flexible.

最令人振奋的消息是什么？我们正逐步推出 [元数据中内置 SEO 支持的更新](https://www.youtube.com/watch?v=UfNMlhu3L4I?utm_source=youtube&utm_medium=blog&utm_campaign=blog_seo_playbook)，让您的标签更易读、更灵活、更具表现力。

**Smarter navigation**

**更智能的导航**

Search engine crawlers map out your site based on which pages link to which. This map includes an overall prioritization of your content, largely through understanding what pages are most often linked.

搜索引擎爬虫通过分析页面之间的链接关系来绘制你的网站地图。这张地图不仅呈现页面拓扑结构，更隐含着内容优先级的整体排序——其核心依据，正是各页面被其他页面链接引用的频次。

Think about your homepage. It’s likely back-linked from every page on your application, which tells the crawler to give it a high priority. Or maybe your landing pages are back-linked from all their subpages, meaning they can be indexed as next highest.

试想你的首页：它很可能被应用内所有页面反向链接（back-linked），这向爬虫明确传递出“高优先级”的信号；又或者，你的落地页（landing pages）被各自所有子页面反向链接，那么它们便会被视为次高优先级内容，从而获得更及时的索引。

Keep in mind that getting linked from sites that aren’t your own also goes a long way toward building up the search engine rank of your content.

请记住，被其他非你所属的网站链接，对提升你内容的搜索引擎排名也大有裨益。

Carefully planning your site structure can feel arduous, but Next.js offers some tools to help:

精心规划网站结构可能令人望而生畏，但 Next.js 提供了一些工具来助你一臂之力：

1. **App Router.** The new [Next.js 13 `app` directory](https://beta.nextjs.org/docs/routing/fundamentals?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_seo_playbook) offers the most intuitive way to structure your website, mirroring its final build right inside the directory. Directory-based routing means that you’re always thinking about page hierarchy, and your SEO will reflect those choices.

1. **App Router（应用路由）**。全新的 [Next.js 13 `app` 目录](https://beta.nextjs.org/docs/routing/fundamentals?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_seo_playbook) 提供了最直观的网站结构组织方式，目录结构即最终构建结果的直接映射。基于目录的路由机制意味着你始终在思考页面层级关系，而你的 SEO 表现也将自然反映这些设计决策。

2. **Layouts.** Within the App Router, you can use [layouts and nested layouts](https://beta.nextjs.org/docs/routing/pages-and-layouts?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_seo_playbook) to template pages for your site and individual sections of it. This means you can implement repeating elements, such as nav bars, footers, or backlinks, in just one central location.

2. **布局（Layouts）**。在 App Router 中，你可以使用 [布局与嵌套布局](https://beta.nextjs.org/docs/routing/pages-and-layouts?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_seo_playbook)，为整个网站或其特定板块统一设置页面模板。这意味着导航栏、页脚或返回链接等重复性元素，只需在一个中心位置实现即可。

3. **Dynamic routing.** Sensible, indexable URLs also play into good SEO, and when you have a site with a lot of content from your CMS, you can quickly run into the chore of naming. [Next.js Dynamic Segments](https://beta.nextjs.org/docs/routing/defining-routes#dynamic-segments?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_seo_playbook) allow you to programmatically name and template all subpages of a directory, regardless of the number of items.

3. **动态路由（Dynamic Routing）**。合理且可被索引的 URL 同样是良好 SEO 的关键要素；当你拥有一个由 CMS 驱动、内容量庞大的网站时，手动为每个页面命名很快就会变成一项繁琐任务。[Next.js 动态段（Dynamic Segments）](https://beta.nextjs.org/docs/routing/defining-routes#dynamic-segments?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_seo_playbook) 允许你以编程方式为目录下所有子页面自动命名并生成模板，无论其数量多少。

4. **The** **`Link`** **component.** Next.js uses React’s [`Link` component](https://beta.nextjs.org/docs/routing/linking-and-navigating#link-component?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_seo_playbook) to provide prefetching (loading pages in the background to make user navigation feel faster) and the ability to link to dynamic routes from one central place in the codebase. If you require an even more advanced dynamic linking strategy, [the `useRouter()` hook](https://beta.nextjs.org/docs/routing/linking-and-navigating#userouter-hook?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_seo_playbook) allows you to programmatically change routes for your users on-demand.

4. **`Link` 组件**。Next.js 借助 React 的 [`Link` 组件](https://beta.nextjs.org/docs/routing/linking-and-navigating#link-component?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_seo_playbook)，提供页面预取功能（在后台提前加载页面，使用户导航更流畅），并支持从代码库中一个统一位置链接至动态路由。若需更高级的动态链接策略，[`useRouter()` Hook](https://beta.nextjs.org/docs/routing/linking-and-navigating#userouter-hook?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_seo_playbook) 可让你按需以编程方式动态切换用户当前路由。

Consistent linking goes a long way to boosting your site’s SEO, and it can also help you locate instances of near-duplicate content or places your navigation feels inconsistent. Better SEO always means a better user experience.

一致的内部链接策略对提升网站 SEO 效果大有裨益，同时也有助于你识别近似重复的内容，或发现导航逻辑不一致之处。更优的 SEO 始终意味着更佳的用户体验。

In case you do want to keep two versions of similar content, choose one to be the preferred version, and let Google know which version to show users through [canonical linking](https://developers.google.com/search/docs/crawling-indexing/consolidate-duplicate-urls).

如果你确实需要保留相似内容的两个版本，请指定其中一个作为首选版本，并通过 [规范链接（canonical linking）](https://developers.google.com/search/docs/crawling-indexing/consolidate-duplicate-urls) 告知 Google 应向用户展示哪一个版本。

**Fixing dead ends**

**修复“死胡同”页面**

Implementing smarter navigation site-wide can also help you find those broken links and orphaned pages. Dead ends like these in your codebase deteriorate user experience and, as importantly, confuse search engine crawlers.

在整个网站范围内实施更智能的导航机制，还能帮你发现那些失效链接和孤立页面（orphaned pages）。这类“死胡同”存在于代码库中，不仅损害用户体验，更重要的是会干扰搜索引擎爬虫的正常抓取。

An organized Next.js codebase goes a long way to help you fix dead ends, but Google’s [Page Indexing report](https://support.google.com/webmasters/answer/7440203?hl=en&ref_topic=9456557) can provide you with a deeper understanding of which pages Google is struggling to find.

一个组织良好的 Next.js 代码库能极大帮助你规避开发中的死胡同；但谷歌的[页面索引报告](https://support.google.com/webmasters/answer/7440203?hl=en&ref_topic=9456557)则可让你更深入地了解谷歌在哪些页面上遇到了抓取和索引困难。

**Don't let errors slow down your users**

**切勿让错误拖慢用户访问速度**

Every application needs good errors. Next.js provides [sensible defaults](https://nextjs.org/docs/advanced-features/custom-error-page?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_seo_playbook) that can be tweaked with your application’s branding to ease the user experience. Here are some other best practices:

每个应用都需要设计得当的错误处理机制。Next.js 提供了[合理的默认错误页](https://nextjs.org/docs/advanced-features/custom-error-page?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_seo_playbook)，你可结合自身应用的品牌风格进行定制，从而优化用户体验。以下是一些其他最佳实践：

- If a requested page isn’t found, route users to a 404 Page, instead of looping them back to the homepage or anywhere else. This keeps users and crawlers alike from getting confused about site structure.

- 若请求的页面不存在，应将用户导向 404 页面，而非将其重定向回首页或其他任意页面。此举可避免用户与搜索引擎爬虫对网站结构产生混淆。

- Your 404 Page shouldn’t beat around the bush. Let the user know they’ve encountered an error. A light touch of humor never hurts.

- 你的 404 页面不应含糊其辞——应明确告知用户已发生错误。恰到好处的幽默感往往锦上添花。

- Link from your 404 Page to your best site content. Don’t let the user journey end with the error.

- 在 404 页面中链接至你网站最优质的内容。切勿让用户因一次错误而终止浏览旅程。

- Keep the page simple and informative. Don’t let your user spend too long on this part of the journey.

- 保持该页面简洁且信息明确。切勿让用户在此环节停留过久。

Sometimes, you have partially-built pages that you’d like to ship for user testing, or private information you don’t want search engines to index. In both cases, you can [block search indexing](https://developers.google.com/search/docs/crawling-indexing/block-indexing) through the inclusion of a `noindex` attribute.

有时，你可能希望上线尚未完全开发完成的页面以开展用户测试；又或存在某些不希望被搜索引擎索引的私密信息。在这两种情况下，你均可通过添加 `noindex` 属性来[屏蔽搜索引擎索引](https://developers.google.com/search/docs/crawling-indexing/block-indexing)。

### Ranking regionally

### 按地域提升搜索排名

Internationalization (i18n) and localization are two complementary processes that allow your site to climb the search engine rankings across the globe.

国际化（i18n）与本地化（localization）是两个相辅相成的过程，可助力你的网站在全球范围内提升搜索引擎排名。

I18n is the technical side of the process, which involves prepping your codebase to accept various types of languages and serve proper versions of your pages to users and search engines alike.

国际化（i18n）是该流程中的技术环节，涉及对代码库进行预处理，使其能够支持多种语言，并向用户和搜索引擎提供相应语言版本的页面。

You'll need to implement [modern CSS](https://css-tricks.com/control-layout-in-a-multi-directional-website/) to make sure any directionality of language is supported without breaking your UI. Then, Next.js provides an even more advanced feature set to [help optimize your site for any region](https://nextjs.org/docs/advanced-features/i18n-routing?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_seo_playbook). After opting into the `i18n` configuration, Next.js will automatically detect current locale, smartly transition between locales, and even auto-add the proper `lang` attribute to the `<html>` tag.

您需要采用[现代 CSS](https://css-tricks.com/control-layout-in-a-multi-directional-website/)，以确保您的 UI 能够正确支持各类文字书写方向（如从左到右或从右到左），而不会出现布局错乱。随后，Next.js 提供了一套更高级的功能，可[帮助您针对任意地区优化网站](https://nextjs.org/docs/advanced-features/i18n-routing?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_seo_playbook)。启用 `i18n` 配置后，Next.js 将自动检测当前区域设置（locale）、智能地在不同 locale 之间切换，甚至自动为 `<html>` 标签添加正确的 `lang` 属性。

Next.js doesn't know about language variants of a page, so it's up to you to add the `hreflang` meta tags using [`next/head`](https://nextjs.org/docs/api-reference/next/head). You can learn more about `hreflang` in the [Google Webmasters documentation](https://developers.google.com/search/docs/specialty/international/localized-versions).

Next.js 并不了解某页面的语言变体（language variants），因此您需借助 [`next/head`](https://nextjs.org/docs/api-reference/next/head) 手动添加 `hreflang` 元标签。有关 `hreflang` 的更多详情，请参阅 [Google 搜索中心文档](https://developers.google.com/search/docs/specialty/international/localized-versions)。

For localization, many applications opt into auto-translation by the user’s browser, which can work well once your site is properly internationalized. However, if you know you want to attract users in a specific region, it’s worth humanly adapting your content to best fit the market of that region. No machine can fully understand all the linguistic, political, cultural, and legal nuances.

就本地化（localization）而言，许多应用选择依赖用户浏览器的自动翻译功能——这一方案在网站已完成良好国际化（internationalization）的前提下往往效果不错。但若您明确希望吸引特定地区的用户，则值得投入人力对内容进行本地化适配，使其真正契合该地区市场的语言习惯、文化背景与用户预期。没有任何机器能完全理解所有语言、政治、文化及法律层面的细微差别。

## Shipping with Vercel gives you a clear picture

## 借助 Vercel 部署，助您全面掌握真实表现

![Vercel Analytics provides a Real Experience Score: realtime data from your actual users.](images/improve-your-search-engine-ranking-with-next_js-on-vercel-vercel/img_003.jpg)![Vercel Analytics provides a Real Experience Score: realtime data from your actual users.](images/improve-your-search-engine-ranking-with-next_js-on-vercel-vercel/img_004.jpg)Vercel Analytics provides a Real Experience Score: realtime data from your actual users.

![Vercel Analytics 提供“真实体验分”（Real Experience Score）：来自您真实用户的实时数据。](images/improve-your-search-engine-ranking-with-next_js-on-vercel-vercel/img_003.jpg)![Vercel Analytics 提供“真实体验分”（Real Experience Score）：来自您真实用户的实时数据。](images/improve-your-search-engine-ranking-with-next_js-on-vercel-vercel/img_004.jpg)Vercel Analytics 提供“真实体验分”（Real Experience Score）：来自您真实用户的实时数据。

Through this marathon of SEO for Next.js, you might be wondering: how do I track my progress?

在本次围绕 Next.js 的 SEO 实践长跑中，您或许会思考：我该如何追踪优化成效？

[Next.js Analytics](https://nextjs.org/analytics?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_seo_playbook) enables you to easily analyze and measure the performance of pages using Lighthouse and Core Web Vitals. And since Vercel is the native Next.js platform, we build support for all Next.js features the day they’re released.

[Next.js Analytics](https://nextjs.org/analytics?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_seo_playbook) 让您能轻松借助 Lighthouse 和核心网页指标（Core Web Vitals）分析并衡量各页面性能。而由于 Vercel 是 Next.js 的原生平台，我们会在 Next.js 每一项新功能发布当天即完成对其的全面支持。

That means you can start collecting your [Real Experience Score](https://vercel.com/docs/concepts/analytics/web-vitals#real-experience-score-res)—a continuous measure of how your site is performing for your actual users—with zero additional configuration on Vercel deployments.

这意味着，您可在 Vercel 部署环境中零配置即开始采集[真实体验分（Real Experience Score）](https://vercel.com/docs/concepts/analytics/web-vitals#real-experience-score-res)——该指标持续反映您的网站在真实用户访问场景下的实际运行表现。

Add to that features like our [Git-centric workflow](https://vercel.com/docs/concepts/deployments/git), [live team commenting](https://vercel.com/docs/concepts/deployments/comments) on Preview Deployments, and [advanced notifications](https://vercel.com/blog/building-a-powerful-notification-system-for-vercel-with-knock-app), and you have a full-featured feedback center without changing your codebase.

再加上我们的[以 Git 为中心的工作流](https://vercel.com/docs/concepts/deployments/git)、预览部署（Preview Deployment）中的[团队实时评论功能](https://vercel.com/docs/concepts/deployments/comments)，以及[高级通知系统](https://vercel.com/blog/building-a-powerful-notification-system-for-vercel-with-knock-app)，您便拥有了一个功能完备的反馈中心——且全程无需修改您的代码库。

[**Have more questions about SEO?**  
\\  
Our team specializes in helping large teams migrate to Vercel without losing current search engine rankings.  
\\  
Talk with an Expert](https://vercel.com/contact/sales)

[**关于 SEO 还有更多疑问？**  
\\  
我们的团队专精于协助大型团队迁移到 Vercel，同时确保当前搜索引擎排名不受影响。  
\\  
立即联系专家](https://vercel.com/contact/sales)

## Start ranking higher today

## 今天就开始提升搜索排名

Give your website the boost it needs by [deploying to Next.js on Vercel](https://vercel.com/solutions/nextjs).

通过在 Vercel 上[部署 Next.js 应用](https://vercel.com/solutions/nextjs)，为您的网站注入所需的增长动力。

After a quick deploy, you can follow along with the [Next.js SEO course](https://nextjs.org/learn/seo/introduction-to-seo?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_seo_playbook), which takes you step-by-step to better SEO implementation.

完成快速部署后，您可同步学习 [Next.js SEO 课程](https://nextjs.org/learn/seo/introduction-to-seo?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_seo_playbook)，该课程将手把手指导您实现更优的 SEO 实践。

Have more questions? Feel free to [take a product tour](https://vercel.com/product-tour?thankyou) or [chat with an SEO expert](https://vercel.com/contact/sales) today.

还有其他疑问？欢迎立即[体验产品导览](https://vercel.com/product-tour?thankyou)，或[与 SEO 专家在线交流](https://vercel.com/contact/sales)。

Vercel.com landing page

Vercel.com 着陆页

### Talk with an SEO expert

### 与 SEO 专家交流

Vercel.com landing page

Vercel.com 着陆页

### Dive deeper

### 深入了解