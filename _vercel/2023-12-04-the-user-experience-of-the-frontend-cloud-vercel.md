---
title: "The user experience of the Frontend Cloud - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/the-user-experience-of-the-frontend-cloud"
date: "2023-12-04"
scraped_at: "2026-03-02T09:49:26.037034157+00:00"
language: "en-zh"
translated: true
description: "The user experience of the Frontend Cloud: Part 2 of the developer's guide to a future-proofed stack."
---

Dec 4, 2023

2023 年 12 月 4 日

Vercel's Edge network means robust personalization without compromising on speed.

Vercel 的边缘网络意味着在不牺牲速度的前提下，实现强大的个性化能力。

The world's best websites load before you've finished this sentence.

全球最优秀的网站，在你读完这句话之前就已加载完成。

Those websites can't be static, but serving performance _and_ personalization to a global user base has historically been complex.

这些网站无法是静态的；而要面向全球用户群体，同时提供卓越的性能与个性化体验，历来都十分复杂。

The [primary goal of Vercel's Frontend Cloud](https://vercel.com/blog/the-foundations-of-the-frontend-cloud) is to collect industry-best practices into one easy-to-use workflow, integrating new and better solutions as they come.

[Vercel 前端云](https://vercel.com/blog/the-foundations-of-the-frontend-cloud) 的核心目标，是将业界最佳实践整合为一套易于使用的统一工作流，并持续集成更新、更优的解决方案。

In this article, we'll look at why speed and personalization matter to your business, and how the Frontend Cloud gives you abundant options for both.

本文将探讨速度与个性化为何对您的业务至关重要，以及前端云如何为您提供丰富多样的实现方案。

[**Speed is your bottom line.**\\
\\
Discover how the Frontend Cloud delivers lightning-fast websites that boost your business.\\
\\

[**速度就是您的底线。**  
\\  
了解前端云如何交付闪电般迅捷的网站，从而切实提升您的业务表现。  
\\  

## Why do you need speed?

## 为何您需要极致的速度？

There are many reasons to care about the load speed of your application, but how do you know when your speed _good enough_?

影响应用加载速度的因素众多，但您又该如何判断当前的速度是否“足够好”？  

Let's break it down.

我们来逐一剖析。

- [毫秒级优化， literally 能创造百万收益](https://www2.deloitte.com/content/dam/Deloitte/ie/Documents/Consulting/Milliseconds_Make_Millions_report.pdf)，页面加载时间每缩短 100 毫秒，转化率即可提升 8%。现代用户不会长时间盯着空白屏幕等待，而这种耐心正逐年递减。

![缓慢的加载时间会直接影响用户行为。](images/the-user-experience-of-the-frontend-cloud-vercel/img_001.jpg)![缓慢的加载时间会直接影响用户行为。](images/the-user-experience-of-the-frontend-cloud-vercel/img_002.jpg)缓慢的加载时间会直接影响用户行为。

- 谷歌等搜索引擎依据相关性对网页进行排名，但[相关性中很大一部分源自页面加载速度](https://vercel.com/blog/how-core-web-vitals-affect-seo)。搜索引擎优先将性能优异、可访问性强、无 Bug 的网页置于搜索结果顶部，以提升其自身用户体验（UX）。

- **全球排名前列的众多应用** [**均能在 1 秒或更短时间内完成加载**](https://www.browserstack.com/guide/how-fast-should-a-website-load)。若您的网站加载速度未达此水准，很可能无法位列搜索结果首位；若加载时间超过 5 秒，则除与您品牌高度相关的极少数精准查询外，您的网站甚至可能无法出现在搜索结果第一页。

- 即便人工智能正在重塑搜索行业，我们仍需清醒认识到：AI 对当前网络信息的获取能力，在很大程度上[仍依赖于现有搜索引擎](https://openai.com/blog/chatgpt-plugins#browsing:~:text=Browsing%20retrieves%20content%20from%20the%20web%20using%20the%20Bing%20search%20API.%C2%A0As%20a%20result%2C%20we%20inherit%20substantial%20work%20from%20Microsoft%20on%20(1)%20source%20reliability%20and%20truthfulness%20of%20information%20and%20(2)%20%E2%80%9Csafe%2Dmode%E2%80%9D%20to%20prevent%20the%20retrieval%20of%20problematic%20content.)，例如必应（Bing）和谷歌（Google）。

**换言之，如果您的网站不够快，用户就只能通过付费广告或口碑传播才能找到您。** 即便用户最终访问了您的网站，其留存意愿（stickiness）也在一定程度上取决于页面加载速度。

采用具备高速性能与弹性扩展能力的前端云（Frontend Cloud），将彻底释放您业务在自然传播（organic virality）方面的潜力，并[有效推动用户转化](https://wpostats.com/?sjid=8517968827982031122)。

## 为何动态个性化至关重要？

所有这些可发现性（discoverability）与极致速度，仅构成了故事的一半。让我们直面现实：[65% 的营收来自现有客户](https://www.nerdwallet.com/article/small-business/customer-loyalty-statistics)，而确保应用高留存率（stickiness）的最佳方式，正是深度个性化（deep personalization）。

用户会对那些让他们感觉“真正懂我”的品牌保持忠诚，并主动向朋友推荐此类体验。在充斥着无数匿名数字交互的世界里，一个个性化、可定制的用户体验，能让您的应用在竞争中脱颖而出。

Historically, personalization has been at odds with speed. Personalization requires dynamic-to-that-user data, which can’t be cached in a typical frontend.

从历史上看，个性化与速度之间一直存在矛盾。个性化需要针对每位用户的动态数据，而这类数据无法在典型的前端中被缓存。

Vercel's Frontend Cloud solves these challenges, making [access to fast-as-milliseconds external data](https://vercel.com/resources/edge-middleware-experiments-personalization-performance) unlimited. There’s no other solution that allows your apps to be as fast _and_ dynamic.

Vercel 前端云（Frontend Cloud）解决了这些挑战，使应用能够**毫秒级访问外部数据**——这一能力不再受限。目前尚无其他方案能让您的应用同时兼具极致的**速度**与**动态性**。

If you’re discoverable through performance and you _also_ delight users through personalization and good UX, your app stands apart from a crowded market.

如果用户因卓越的性能而发现您的应用，又因出色的个性化体验与良好的用户体验而感到愉悦，那么您的应用便能在竞争激烈的市场中脱颖而出。

So, the question is, how do we get there? Let's look at the Frontend Cloud's best answers.

那么问题来了：我们该如何实现这一目标？让我们来看看前端云提供的最佳实践方案。

[**Level-up your user experience.**\\
\\
Deliver deeply personalized, dynamic websites that drive customer loyalty and growth.\\
\\

[**全面提升用户体验。**  
\\  
交付高度个性化、高度动态的网站，从而提升客户忠诚度并驱动业务增长。  
\\  

## ) What is a content delivery network (CDN)?

## ) 什么是内容分发网络（CDN）？

When a user from Tokyo requests data from New York City, the one-way latency is, at minimum, around 200ms. This might not sound too bad, but the problem with requests is that they stack up.

当一位来自东京的用户向纽约市的服务器请求数据时，单向延迟至少约为 200 毫秒。这听起来似乎并不严重，但请求的问题在于——它们会逐层叠加。

Each user interaction with the server (even within the same webpage if it needs more server data) takes at least 400ms of roundtrip to accomplish—a noticeable lag on _top_ of whatever time it takes to access data, process it, and render your data-informed code for the user.

每一次用户与服务器的交互（即使在同一网页内，只要需额外获取服务端数据），都至少需要 400 毫秒的往返时间——这还不包括数据访问、处理以及为用户渲染数据驱动代码所耗费的时间；由此带来的可感知延迟，是叠加在上述所有耗时之上的。

Keep in mind that [the best websites in the world](https://www.browserstack.com/guide/how-fast-should-a-website-load) take ~1000ms to be _fully interactive_.

请记住：全球最优秀的网站，其达到**完全可交互状态**所需时间约为 1000 毫秒。

This is originally why Content Delivery Networks (CDNs) were invented. By placing data centers around the world and allowing businesses to cache their static web data inside them, websites could often shave seconds off their load times.

这正是内容分发网络（CDN）最初被发明的原因。通过在全球各地部署数据中心，并允许企业将静态网页数据缓存在其中，网站往往能将加载时间缩短数秒。

![An Edge Network sits between the internet and your deployments, acting as a CDN with the ability to execute functions as close to your user or data as possible.](images/the-user-experience-of-the-frontend-cloud-vercel/img_003.jpg)  
![An Edge Network sits between the internet and your deployments, acting as a CDN with the ability to execute functions as close to your user or data as possible.](images/the-user-experience-of-the-frontend-cloud-vercel/img_004.jpg)  
一个边缘网络（Edge Network）位于互联网与你的部署之间，既充当内容分发网络（CDN），又具备在尽可能靠近用户或数据的位置执行函数的能力。

一个边缘网络（Edge Network）位于互联网与你的部署之间，既充当内容分发网络（CDN），又具备在尽可能靠近用户或数据的位置执行函数的能力。

但其局限性在于：典型的 CDN 仅支持静态网页资源的存储，无法处理“瞬时动态”的数据。

但其局限性在于：典型的 CDN 仅支持静态网页资源的存储，无法处理“瞬时动态”的数据。

如果你需要提供任何无法被缓存的动态内容，用户的请求就必须往返于应用源服务器（origin server）——先抵达源服务器，再返回用户所在位置，从而产生额外延迟。

如果你需要提供任何无法被缓存的动态内容，用户的请求就必须往返于应用源服务器（origin server）——先抵达源服务器，再返回用户所在位置，从而产生额外延迟。

## Vercel's Edge Network

## Vercel 边缘网络

为了优化终端用户的**应用性能与可靠性**，Vercel 前端云（Frontend Cloud）采用全球分布式服务器，对用户请求进行异步计算，并以细粒度方式缓存其结果。我们将这一基础设施称为 **Edge Network（边缘网络）**。

为了优化终端用户的**应用性能与可靠性**，Vercel 前端云（Frontend Cloud）采用全球分布式服务器，对用户请求进行异步计算，并以细粒度方式缓存其结果。我们将这一基础设施称为 **Edge Network（边缘网络）**。

边缘网络的缓存机制兼具两大目标：一是[降低延迟（latency）](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud#what-is-a-global-edge-network)，二是保障服务的持续可用性——即使外部数据源发生宕机，你的应用仍能稳定运行。

边缘网络的缓存机制兼具两大目标：一是[降低延迟（latency）](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud#what-is-a-global-edge-network)，二是保障服务的持续可用性——即使外部数据源发生宕机，你的应用仍能稳定运行。

用户请求无需回传至源服务器即可得到处理；相反，边缘网络可独立完成全部请求响应，并在必要时自动调配额外基础设施、与其他服务器通信。

用户请求无需回传至源服务器即可得到处理；相反，边缘网络可独立完成全部请求响应，并在必要时自动调配额外基础设施、与其他服务器通信。

这意味着：边缘网络能够将任意动态用户请求的结果，自动以静态格式进行缓存（或重新缓存），以便快速响应后续同类请求。

这意味着：边缘网络能够将任意动态用户请求的结果，自动以静态格式进行缓存（或重新缓存），以便快速响应后续同类请求。

### Granular caching: Incremental Static Regeneration

### 细粒度缓存：增量静态再生（ISR）

边缘网络还可按需对内容进行**逐块（piecemeal）缓存**——其缓存逻辑由你在框架代码中[明确定义](https://vercel.com/blog/the-foundations-of-the-frontend-cloud#why-fit-your-frontend-into-a-framework)。我们称这一实践为 **[增量静态再生（Incremental Static Regeneration, ISR）](https://vercel.com/docs/incremental-static-regeneration)**。

边缘网络还可按需对内容进行**逐块（piecemeal）缓存**——其缓存逻辑由你在框架代码中[明确定义](https://vercel.com/blog/the-foundations-of-the-frontend-cloud#why-fit-your-frontend-into-a-framework)。我们称这一实践为 **[增量静态再生（Incremental Static Regeneration, ISR）](https://vercel.com/docs/incremental-static-regeneration)**。

For instance, in the [Next.js App Router](https://nextjs.org/docs/app/building-your-application/data-fetching/fetching-caching-and-revalidating), caching and revalidation can happen specifically at the _component_ level. This allows you to build experiences that seamlessly merge static and dynamic content—all while keeping external data fetches on the server.

例如，在 [Next.js App Router](https://nextjs.org/docs/app/building-your-application/data-fetching/fetching-caching-and-revalidating) 中，缓存与重新验证可精确发生在 _组件_ 级别。这使您能够构建无缝融合静态内容与动态内容的用户体验——同时确保所有外部数据请求均在服务器端完成。

Practices like [Partial Prerendering](https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model) then step in to make sure the user's Time to First Byte (TTFB) is as small as possible.

随后，[部分预渲染（Partial Prerendering）](https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model) 等实践介入，以确保用户首字节时间（Time to First Byte, TTFB）尽可能短。

When you have the power to choose the caching behavior of each piece of your application, you can ensure users receive top-speed, cached data in far more cases than not.

当您拥有为应用中每一部分自主选择缓存策略的能力时，您便能在绝大多数场景下，确保用户获得极速响应的缓存数据。

Caching isn’t _all_ about UX, though. By leveraging serverless functions in your codebase without having to worry about speed or concurrency, your team gets a far better [developer experience (DX)](https://vercel.com/blog/improving-developer-workflow) as well.

不过，缓存并不仅仅关乎用户体验（UX）。通过在代码库中直接使用无服务器函数（serverless functions），且无需担忧性能或并发问题，您的团队也将获得显著更优的 [开发者体验（Developer Experience, DX）](https://vercel.com/blog/improving-developer-workflow)。

![ISR allows you to generate pages on-demand instead of waiting for the entire site at build time.](images/the-user-experience-of-the-frontend-cloud-vercel/img_005.svg)![ISR allows you to generate pages on-demand instead of waiting for the entire site at build time.](images/the-user-experience-of-the-frontend-cloud-vercel/img_006.svg)ISR allows you to generate pages on-demand instead of waiting for the entire site at build time.

![ISR 允许您按需生成页面，而无需等待整个网站在构建时一次性完成。](images/the-user-experience-of-the-frontend-cloud-vercel/img_005.svg)![ISR 允许您按需生成页面，而无需等待整个网站在构建时一次性完成。](images/the-user-experience-of-the-frontend-cloud-vercel/img_006.svg)ISR（增量静态再生，Incremental Static Regeneration）允许您按需生成页面，而非等待整个网站在构建阶段一次性全部生成。

Practices like ISR, [which perform their caching magic _after_ build](https://vercel.com/docs/incremental-static-regeneration), drastically cut build times in instances where you previously needed to statically generate all dynamic pages. ISR can also allow your authors to [preview and publish new content without developer intervention](https://vercel.com/customers/hydrow).

诸如 ISR 这类实践——其缓存机制在构建 *之后* 才生效（参见 [《ISR 文档》](https://vercel.com/docs/incremental-static-regeneration)）——可在原先必须对所有动态页面执行静态生成的场景中，大幅缩短构建耗时。此外，ISR 还能让您的内容作者 [无需开发者介入，即可预览并发布新内容](https://vercel.com/customers/hydrow)。

### The lifecycle of a user request

### 用户请求的生命周期

Vercel's Edge Network also caches at all levels of the user request lifecycle:

Vercel 的边缘网络（Edge Network）同样在用户请求生命周期的各个层级实施缓存：

- When a user makes a request, all levels of that request (TLS, hostname lookup, deployment fetching, and routing) look to on-site, in-memory storage for information before making a more time-consuming database call. Cache levels include per-proxy (the instance of compute spun up to aid that particular user), by region (in a data center close to where that user is accessing from), and origin (close to long-term data storage).

- 当用户发起请求时，该请求的各环节（TLS 握手、域名解析、部署获取、路由分发）均会优先查询本地内存缓存，再决定是否发起更耗时的数据库调用。缓存层级包括：按代理（per-proxy，即为服务该特定用户而启动的计算实例）、按区域（by region，即靠近用户访问位置的数据中心）、以及源站（origin，即靠近长期数据存储的位置）。

- When a user action needs to invoke a serverless function, the Frontend Cloud infra checks yet another threefold layer of in-memory storage to see if the dynamic information needed is already available. This, at a high level, is how features like ISR work to serve users the latest static files.

- 当用户操作需要触发一个无服务器函数时，前端云（Frontend Cloud）基础设施会进一步检查三层内存缓存，以确认所需的动态信息是否已就绪。从宏观角度看，这正是 ISR 等功能得以向用户提供最新静态文件的核心机制。

![Complete flow of the deployment and request lifecycle](images/the-user-experience-of-the-frontend-cloud-vercel/img_007.jpg)![Complete flow of the deployment and request lifecycle](images/the-user-experience-of-the-frontend-cloud-vercel/img_008.jpg)![Complete flow of the deployment and request lifecycle](images/the-user-experience-of-the-frontend-cloud-vercel/img_007.jpg)![Complete flow of the deployment and request lifecycle](images/the-user-experience-of-the-frontend-cloud-vercel/img_008.jpg)  
![部署与请求生命周期的完整流程](images/the-user-experience-of-the-frontend-cloud-vercel/img_007.jpg)![部署与请求生命周期的完整流程](images/the-user-experience-of-the-frontend-cloud-vercel/img_008.jpg)![部署与请求生命周期的完整流程](images/the-user-experience-of-the-frontend-cloud-vercel/img_007.jpg)![部署与请求生命周期的完整流程](images/the-user-experience-of-the-frontend-cloud-vercel/img_008.jpg)  

Complete flow of the deployment and request lifecycle  

部署与请求生命周期的完整流程  

By allowing data to be re-cached and functions to be re-invoked behind the scenes, Vercel's Frontend Cloud provides performant consistency no matter how much dynamic data your codebase needs to access.  

Vercel 的前端云（Frontend Cloud）允许数据在后台重新缓存、函数在后台重新调用，从而无论您的代码库需要访问多少动态数据，都能提供高性能且一致的体验。  

The Frontend Cloud creates a cohesive and highly customizable caching environment for all levels of infrastructure— [from initial user request to data rendered](https://vercel.com/blog/behind-the-scenes-of-vercels-infrastructure).  

前端云为全栈基础设施各层级——从用户初始请求到数据最终渲染——构建了一个统一且高度可定制的缓存环境：[从初始用户请求到数据渲染](https://vercel.com/blog/behind-the-scenes-of-vercels-infrastructure)。  

Users see dynamic, up-to-date, personalized data, but it’s served to them as a fastest-on-the-web static page.  

用户看到的是动态、实时、个性化的数据，但这些内容是以“全网最快”的静态页面形式交付给他们的。  

There’s a _lot_ more to the caching story, including development-side tools like [Turborepo and Turbopack](https://turbo.build/), and individual [framework capabilities](https://nextjs.org/docs/app/building-your-application/caching), but this overview should help you move forward in the Frontend Cloud discussion.  

缓存机制背后还有大量值得深入的内容，包括开发侧工具（如 [Turborepo 和 Turbopack](https://turbo.build/)），以及各主流框架自身提供的 [缓存能力](https://nextjs.org/docs/app/building-your-application/caching)。不过，本概述已足以助您开启关于前端云的进一步探讨。  

## Edge Functions and Middleware  

## 边缘函数（Edge Functions）与中间件（Middleware）  

Vercel's Edge Network further differentiates itself from a typical CDN by allowing you to run dynamic server-side JavaScript as close as possible to your user with [Edge Functions](https://vercel.com/docs/functions/edge-functions), or between user request and data rendering with [Edge Middleware](https://vercel.com/docs/functions/edge-middleware).  

Vercel 的边缘网络（Edge Network）进一步区别于传统 CDN：它支持您借助 [边缘函数（Edge Functions）](https://vercel.com/docs/functions/edge-functions) 将动态服务端 JavaScript 运行在离用户最近的位置；或借助 [边缘中间件（Edge Middleware）](https://vercel.com/docs/functions/edge-middleware)，在用户请求与数据渲染之间执行逻辑。  

Across multiple frameworks, such as [Next.js, SvelteKit, Astro, Nuxt, Remix, and more](https://vercel.com/docs/frameworks), Edge Functions are Serverless Functions with the `edge` option toggled on, and in addition to running at the edge, they benefit from all the same caching and streaming capabilities.  

在 [Next.js、SvelteKit、Astro、Nuxt、Remix 等多种框架](https://vercel.com/docs/frameworks) 中，边缘函数即启用了 `edge` 选项的无服务器函数（Serverless Functions）；除运行于边缘节点外，它们还可全面复用相同的缓存与流式传输能力。  

Edge Middleware can be written in a typical middleware pattern ( [in Next.js, for example](https://nextjs.org/docs/app/building-your-application/routing/middleware)), but runs _before_ the cache, allowing you to change what is served to the user with [zero layout shift or noticeable artifacts](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config).  

边缘中间件可采用典型的中间件模式编写（例如 [Next.js 中的实现方式](https://nextjs.org/docs/app/building-your-application/routing/middleware)），但它在缓存环节 *之前* 执行，使您能够在不引发布局偏移（layout shift）或任何可察觉视觉瑕疵的前提下，动态调整返回给用户的内容：[零 CLS 实验与 Next.js 边缘配置](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config)。  

![Edge Middleware's location within the Frontend Cloud infrastructure.](images/the-user-experience-of-the-frontend-cloud-vercel/img_011.jpg)![Edge Middleware's location within the Frontend Cloud infrastructure.](images/the-user-experience-of-the-frontend-cloud-vercel/img_012.jpg)  
![边缘中间件在前端云基础设施中的位置](images/the-user-experience-of-the-frontend-cloud-vercel/img_011.jpg)![边缘中间件在前端云基础设施中的位置](images/the-user-experience-of-the-frontend-cloud-vercel/img_012.jpg)  

Edge Middleware's location within the Frontend Cloud infrastructure.  

边缘中间件在前端云基础设施中的位置。

Both Edge Functions and Middleware allow for top-speed, global personalization of your application—all without leaving your framework code.

边缘函数（Edge Functions）和中间件（Middleware）均支持以最快速度实现应用的全球个性化——全程无需脱离您的框架代码。

## Personalization meets speed

## 个性化与速度兼得

The Frontend Cloud allows you to design user-obsessed applications that offer deeply personalized experiences without sacrificing speed for dynamic content.

前端云（Frontend Cloud）让您能够构建以用户为中心的应用，提供深度个性化体验，同时不因动态内容而牺牲性能。

With boosted search engine relevancy and user engagement, your application can convert far more users.

凭借提升的搜索引擎相关性与用户参与度，您的应用可显著提高用户转化率。

[**Transform your website's potential.**\\
\\
Unlock unmatched speed and personalization for your business with the Frontend Cloud.\\
\\
Contact Us](https://vercel.com/contact/sales)

[**释放您网站的全部潜能。**\\
\\
借助前端云，为您的业务解锁无与伦比的速度与个性化能力。\\
\\
联系我们](https://vercel.com/contact/sales)

Blog post

博客文章

Sep 20, 2024

2024年9月20日

### From CDNs to Frontend Clouds

### 从 CDN 到前端云

![](images/the-user-experience-of-the-frontend-cloud-vercel/img_013.jpg)![](images/the-user-experience-of-the-frontend-cloud-vercel/img_014.jpg)

Malte and Dan

Malte 与 Dan

Blog post

博客文章

Dec 21, 2023

2023 年 12 月 21 日

### The developer experience of the Frontend Cloud

### 前端云的开发者体验

![](images/the-user-experience-of-the-frontend-cloud-vercel/img_015.jpg)

Alice Alexandra Moore

爱丽丝·亚历山德拉·摩尔