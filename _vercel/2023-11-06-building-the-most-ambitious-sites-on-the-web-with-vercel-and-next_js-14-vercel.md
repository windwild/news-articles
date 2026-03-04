---
title: "Building the most ambitious sites on the Web with Vercel and Next.js 14 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/building-the-most-ambitious-sites-on-the-web-with-vercel-and-next-js-14"
date: "2023-11-06"
scraped_at: "2026-03-02T09:49:49.572273459+00:00"
language: "en-zh"
translated: true
description: "Vercel and Next.js 14: Server Actions, Experimental Partial Prerendering, Next.js faster startups, and other announcements."
---
&#123;% raw %}

Nov 6, 2023

2023 年 11 月 6 日

At this year's [Next.js Conf](https://www.youtube.com/watch?v=gfU1iZnjRZM&list=PLBnKlKpPeagl57K9bCw_IXShWQXePnXjY&index=1), thousands of community members tuned in to learn about updates to the framework thousands of developers deploy with everyday. Among the announcements were:

在今年的 [Next.js Conf](https://www.youtube.com/watch?v=gfU1iZnjRZM&list=PLBnKlKpPeagl57K9bCw_IXShWQXePnXjY&index=1) 大会上，数千名社区成员在线参与，了解这一被成千上万开发者日常用于部署应用的框架的最新更新。本次大会宣布的重要消息包括：

- Server Actions in Next.js are now stable.

- Next.js 中的 Server Actions 现已正式稳定（stable）。

- Experimental Partial Prerendering will be introduced into Next.js 14.

- 实验性功能“部分预渲染”（Experimental Partial Prerendering）将引入 Next.js 14。

- Next.js is **22% faster** to start up your local server and **29% faster** to see code updates after making changes.

- Next.js 启动本地开发服务器的速度提升了 **22%**，修改代码后通过 Fast Refresh 查看更新的速度提升了 **29%**。

- Turbopack is **53.3% faster** to start up your local server and **94.7% faster** to see code updates with Fast Refresh.

- Turbopack 启动本地开发服务器的速度提升了 **53.3%**，借助 Fast Refresh 查看代码更新的速度提升了 **94.7%**。

- A new course on Next.js Learn is available to teach the latest Next.js features.

- Next.js Learn 平台已上线一门全新课程，专门讲解最新的 Next.js 功能特性。

## The community that built Next.js

## 构建 Next.js 的社区

We have seen the Next.js community consistently growing over the years, and today, we're proud to say that over 850,000 developers choose to deploy with Next.js every day.

多年来，我们见证了 Next.js 社区持续壮大；今天，我们自豪地宣布：每天有超过 85 万名开发者选择使用 Next.js 进行应用部署。

![](images/building-the-most-ambitious-sites-on-the-web-with-vercel-and-next_js-14-vercel/img_001.jpg)![](images/building-the-most-ambitious-sites-on-the-web-with-vercel-and-next_js-14-vercel/img_002.jpg)

Our community continues to build some of the most ambitious sites on the web. Sites like Nike, Notion, Adobe, and even some of the most revolutionary AI projects like ChatGPT and Claude.

我们的社区持续构建着网络上最具雄心的网站，例如 Nike、Notion、Adobe，甚至包括 ChatGPT 和 Claude 等一些最具革命性的 AI 项目。

Thanks to the feedback and collaboration from the community as a whole, we've been able to release Next.js features incrementally like:

得益于整个社区的反馈与协作，我们得以逐步发布 Next.js 的各项新功能，例如：

- The App Router, with more **flexibility,** support for nested routes and layouts.

- 应用路由（App Router），具备更强的**灵活性**，支持嵌套路由与嵌套布局。

- **Powerful** integrated system to fetch, cache, and revalidate data.

- **强大**的集成化数据获取、缓存与重新验证系统。

- A **fast** foundation, built on streaming HTTP responses.

- 基于流式 HTTP 响应构建的**快速**底层基础。

![](images/building-the-most-ambitious-sites-on-the-web-with-vercel-and-next_js-14-vercel/img_003.jpg)![](images/building-the-most-ambitious-sites-on-the-web-with-vercel-and-next_js-14-vercel/img_004.jpg)

As we’ve moved from the original [Layouts RFC](https://nextjs.org/blog/layouts-rfc), to Beta, to stabilizing the APIs, we’ve seen continued adoption of the App Router across the top one million websites on the internet.

随着我们从最初的 [Layouts RFC](https://nextjs.org/blog/layouts-rfc) 提案，历经 Beta 阶段，再到 API 的逐步稳定，App Router 已持续被互联网排名前一百万的网站广泛采用。

![](images/building-the-most-ambitious-sites-on-the-web-with-vercel-and-next_js-14-vercel/img_005.jpg)![](images/building-the-most-ambitious-sites-on-the-web-with-vercel-and-next_js-14-vercel/img_006.jpg)

We want Next.js to be easy to use and easy to adopt. To help, we’ve updated [Next.js Learn](https://nextjs.org/learn) to teach the latest Next.js features mentioned above, as well as authentication, using a database, state management, and more to build a real application. This course will help the community to be able to explore and incrementally adopt new features we announced starting with Next.js 13.

我们希望 Next.js 易于使用、易于采纳。为此，我们已全面更新了 [Next.js Learn](https://nextjs.org/learn)，用于讲解上述最新 Next.js 功能，以及身份认证、数据库使用、状态管理等实用技术，助你构建真实可用的应用程序。本课程将帮助社区成员深入探索并逐步采纳自 Next.js 13 起陆续发布的各项新特性。

![](images/building-the-most-ambitious-sites-on-the-web-with-vercel-and-next_js-14-vercel/img_007.jpg)

[**Start learning the App Router today**  
今天就开始学习 App Router  

Go from beginner to expert by learning the foundations of Next.js and building a fully functional application that uses all the latest features.  
通过学习 Next.js 的核心基础，并构建一个完整可用、融合所有最新特性的应用程序，您将从初学者成长为专家。  

Get Started  
立即开始](https://nextjs.org/learn)

## Introducing Next.js 14  
## Next.js 14 正式发布

In introducing Next.js 14 to the world, we're excited to say it contains _no new APIs_.  
在向全球发布 Next.js 14 之际，我们非常高兴地宣布：本次版本**不引入任何新 API**。

![](images/building-the-most-ambitious-sites-on-the-web-with-vercel-and-next_js-14-vercel/img_008.jpg)![](images/building-the-most-ambitious-sites-on-the-web-with-vercel-and-next_js-14-vercel/img_009.jpg)

We want to continue simplifying the framework and even make it possible to leave some APIs behind when you use Next.js App Router. With App Router's new fetching patterns, there is no need to learn Next.js specific functions, like `getServerSideProps`.  
我们的目标是持续简化框架，甚至让您在使用 Next.js App Router 时，可以彻底告别部分旧有 API。借助 App Router 全新的数据获取模式，您无需再学习 Next.js 特有的函数（例如 `getServerSideProps`）。

With Next.js 14, we also announced that **Server Actions in Next.js are now stable.** This is our recommended way of mutating data, that’s integrated into the fetching and caching layer in Next.js.  
借助 Next.js 14，我们还正式宣布：**Next.js 中的 Server Actions 现已进入稳定版**。这是我们推荐的数据变更方式，它深度集成于 Next.js 的数据获取与缓存层中。

Companies like Clerk, Supabase, Shopify, Payload, Sanity, Okta, and more have embraced Server Components and soon Server Actions.  
Clerk、Supabase、Shopify、Payload、Sanity、Okta 等众多公司均已采用 Server Components，并即将全面启用 Server Actions。

![](images/building-the-most-ambitious-sites-on-the-web-with-vercel-and-next_js-14-vercel/img_010.jpg)![](images/building-the-most-ambitious-sites-on-the-web-with-vercel-and-next_js-14-vercel/img_011.jpg)

The performance improvements seen from adopting the App Router and Server Components have been promising. For example, the App Router helped luxury brand Jennifer Fisher move from a heavy ecommerce theme to a much faster headless storefront, built with Next.js.  
采用 App Router 和 Server Components 后所取得的性能提升令人振奋。例如，高端珠宝品牌 Jennifer Fisher 借助 App Router，成功将其原先臃肿的电商主题迁移为基于 Next.js 构建的、响应速度大幅提升的无头 storefront（前端独立架构）。

Server Components helped them shift more work away from the device and back to the server, resulting in a faster initial paint _and_ interactivity. This means their customers can more quickly add products to their cart, helping improve conversion rates and increase sales.  
Server Components 帮助他们将更多计算任务从用户设备端转移至服务端，从而显著加快了首屏渲染（initial paint）和交互就绪时间（interactivity）。这意味着顾客能更快地将商品加入购物车，进而提升转化率并带动销售额增长。

[**Data Fetching with Next.js**  
**使用 Next.js 进行数据获取**

Learn how React Server Components make data fetching \*even easier\* in Next.js 14  
了解 React 服务端组件如何让 Next.js 14 中的数据获取变得\*更加轻松\*

Learn More  
了解更多](https://vercel.com/blog/understanding-react-server-components)

## Continued performance improvements  
## 持续的性能优化

Since Next.js Conf 2022, we have made incredible strides in improving the compiler infrastructure. At the time, we announced that we were rewriting the Next.js CLI and bundler in Rust. We shipped a 22% faster initial compile (booting up the dev server and navigating to the first page) and a 29% faster code updates (saving code changes and seeing them on the screen).  
自 2022 年 Next.js Conf 以来，我们在编译器基础设施优化方面取得了巨大进展。当时我们宣布正使用 Rust 重写 Next.js 的命令行工具（CLI）和打包器（bundler）。由此实现了初始编译速度提升 22%（即启动开发服务器并首次访问页面所需时间），以及代码更新速度提升 29%（即保存代码变更后在页面上看到效果所需时间）。

![](images/building-the-most-ambitious-sites-on-the-web-with-vercel-and-next_js-14-vercel/img_012.jpg)![](images/building-the-most-ambitious-sites-on-the-web-with-vercel-and-next_js-14-vercel/img_013.jpg)

In order to see the Next.js Compiler succeed with this new infrastructure, there are three things we will continue to monitor:  
为确保 Next.js 编译器在这一全新基础设施下取得成功，我们将持续关注以下三项指标：

1. Fast dev server  
1. 快速的开发服务器  

2. Fast code updates  
2. 快速的代码更新  

3. Fast builds  
3. 快速的构建  

We’re running the entire test suite of Next.js that we've accumulated over seven years. We’ve seen that 90% of our 5,000 tests are passing with the Rust based Next.js Compiler. These tests allow us to continue to evolve and improve the Next.js Compiler while ensuring we’re not making regressions on expected functionality.  
我们正在运行 Next.js 过去七年积累的全部测试套件。目前观察到，在基于 Rust 的 Next.js 编译器上，5,000 个测试用例中已有 90% 顺利通过。这些测试使我们能够持续演进与优化 Next.js 编译器，同时确保不会对预期功能引入任何回归问题。

Let's talk about some of the performance improvements the Next.js Compiler is going to unlock. First, we're seeing 53% faster initial compile with the most recent introduction of Turbopack and up to 94% faster code updates. Again these apply to both routers (the Pages router and the App router).  
让我们来谈谈 Next.js 编译器即将解锁的部分性能提升：首先，随着最新版 Turbopack 的引入，初始编译速度提升了 53%；而代码更新速度最高可提升达 94%。上述优化同样适用于两种路由系统（Pages Router 和 App Router）。

![](images/building-the-most-ambitious-sites-on-the-web-with-vercel-and-next_js-14-vercel/img_014.jpg)![](images/building-the-most-ambitious-sites-on-the-web-with-vercel-and-next_js-14-vercel/img_015.jpg)

This is the new baseline of performance and we will keep getting faster in the future. You can track our ongoing progress at [AreWeTurboYet.com](https://areweturboyet.com/).

这便是全新的性能基准，而未来我们还将持续提速。您可随时访问 [AreWeTurboYet.com](https://areweturboyet.com/) 跟踪我们的最新进展。

The goal of Next.js has always been to abstract away all of the complexity to get to a great developer experience in a way where you really didn't have to do anything else other than upgrade the framework to the latest version.

Next.js 的一贯目标，是将所有复杂性封装隐藏起来，从而为开发者提供卓越的开发体验——您只需将框架升级至最新版本，无需额外操作即可获益。

## Announcing Partial Prerendering

## 发布“部分预渲染”（Partial Prerendering）

[Partial Prerendering](https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model) is a new rendering model that combines the benefits of fast Static Rendering and the personalization ability of Dynamic Rendering. It’s a natural progression of years of research into these previously at-odds rendering strategies—All without introducing any new APIs.

[部分预渲染（Partial Prerendering）](https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model) 是一种全新的渲染模型，融合了静态渲染（Static Rendering）的高速优势与动态渲染（Dynamic Rendering）的个性化能力。它是多年来对这两种曾彼此冲突的渲染策略深入研究后的自然演进成果——整个过程无需引入任何新 API。

Here’s how it works:

其工作原理如下：

When you build your application, Next.js will prerender a static _shell_ for each page of your application, leaving _holes_ for the dynamic content.

构建应用时，Next.js 会为每个页面预先渲染一个静态的 _外壳（shell）_，同时为动态内容预留出 _空位（holes）_。

![](images/building-the-most-ambitious-sites-on-the-web-with-vercel-and-next_js-14-vercel/img_016.jpg)![](images/building-the-most-ambitious-sites-on-the-web-with-vercel-and-next_js-14-vercel/img_017.jpg)

When a user visits a page, the fast static shell is served from a [Vercel Region](https://vercel.com/products/managed-infrastructure), allowing the user to start consuming the page, and the client and server to work in parallel. The client can start parsing scripts, stylesheets, fonts, and static markup while the server renders dynamic chunks using React’s new streaming architecture.

当用户访问某页面时，快速的静态外壳即从 [Vercel Region](https://vercel.com/products/managed-infrastructure) 直接交付，使用户能立即开始浏览页面内容，同时客户端与服务端并行工作：客户端可立即开始解析脚本、样式表、字体及静态标记，而服务端则借助 React 全新的流式（streaming）架构来渲染动态区块。

For Next.js applications, this means:  

对于 Next.js 应用而言，这意味着：

1. **Fast Initial Visual** — a cached static shell that loads swiftly for the user.

1. **快速初始视觉呈现** — 一个缓存的静态外壳，可为用户快速加载。

2. **Fast Dynamic Visual** — the client and server can work in parallel due to streaming, which facilitates quick rendering of dynamic content.

2. **快速动态视觉呈现** — 借助流式传输（streaming），客户端与服务器可并行工作，从而加速动态内容的渲染。

3. **Great DX** — It introduces no new APIs, making it easy to adopt without steep learning curves.

3. **卓越的开发者体验（DX）** — 它不引入任何新 API，因此易于采用，学习曲线平缓。

Partial Prerendering is the next step towards our ambitious goal of **dynamic at the speed of static.** Soon you’ll be able to leverage its benefits of a more personal, interactive, and dynamic web application without worrying about runtimes or regions.

部分预渲染（Partial Prerendering）是我们迈向宏伟目标——“**静态般的速度，动态般的能力**”——的下一步。很快，您就能享受它带来的优势：构建更具个性化、交互性与动态性的 Web 应用，而无需操心运行时环境或部署区域。

## Get started today

## 立即开始

Catch up on the rest of the [videos from Next.js Conf 2023](https://www.youtube.com/playlist?list=PLBnKlKpPeagl57K9bCw_IXShWQXePnXjY), browse our updated [documentation](https://nextjs.org/docs) and [courses](https://nextjs.org/learn), and most importantly—tell us what you think. This community and this framework is stronger with your feedback and your ideas. Thanks for being part of this journey.

请观看 [Next.js Conf 2023 的其余视频](https://www.youtube.com/playlist?list=PLBnKlKpPeagl57K9bCw_IXShWQXePnXjY)，浏览我们更新后的 [文档](https://nextjs.org/docs) 和 [教程课程](https://nextjs.org/learn)，最重要的是——告诉我们您的想法！这个社区与这个框架，因您的反馈与创意而更加强大。感谢您一路同行！
&#123;% endraw %}
