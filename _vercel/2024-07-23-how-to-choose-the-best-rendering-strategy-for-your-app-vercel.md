---
title: "How to choose the best rendering strategy for your app - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/how-to-choose-the-best-rendering-strategy-for-your-app"
date: "2024-07-23"
scraped_at: "2026-03-02T09:42:45.569901708+00:00"
language: "en-zh"
translated: true
description: "Demystify Next.js rendering strategies: SSG, SSR, CSR, ISR, and PPR. Optimize your web apps for performance, SEO, and user experience. Learn when and how to use each approach with real-world examples ..."
---

render_with_liquid: false
Jul 23, 2024

2024 年 7 月 23 日

以更优方式交付代码，提升应用性能。

网页渲染已从简单的服务端渲染 HTML 页面，演进为高度交互、动态化的现代应用；如今，向用户呈现应用的方式也比以往任何时候都更加丰富多样。

静态站点生成（Static Site Generation, SSG）、服务端渲染（Server-Side Rendering, SSR）、客户端渲染（Client-Side Rendering, CSR）、增量静态再生（Incremental Static Regeneration, ISR），以及尚处于实验阶段的部分预渲染（Partial Prerendering, PPR），均旨在针对不同场景优化性能、搜索引擎优化（SEO）与用户体验。

本文将深入探讨每种渲染策略的适用场景与权衡取舍，并一窥内容交付技术的未来发展趋势。

**本文目录：**

- [什么是渲染策略？](https://vercel.com/blog/how-to-choose-the-best-rendering-strategy-for-your-app#what-is-a-rendering-strategy)

- [各渲染策略的定义](https://vercel.com/blog/how-to-choose-the-best-rendering-strategy-for-your-app#defining-each-rendering-strategy)

- [何时使用哪种渲染策略？](https://vercel.com/blog/how-to-choose-the-best-rendering-strategy-for-your-app#when-to-use-each-rendering-strategy)

- [在 Next.js 中实现渲染](https://vercel.com/blog/how-to-choose-the-best-rendering-strategy-for-your-app#rendering-with-next.js)

- [Real-world product rendering strategies](https://vercel.com/blog/how-to-choose-the-best-rendering-strategy-for-your-app#real-world-product-rendering-strategies)

- [真实世界中的产品渲染策略](https://vercel.com/blog/how-to-choose-the-best-rendering-strategy-for-your-app#real-world-product-rendering-strategies)


## What is a rendering strategy?

## 什么是渲染策略？

The term _rendering_ may seem like jargon, but at its core, it’s just a way to solve the web's fundamental challenge: **How do we turn** _**code**_ **into** _**content**_ **users can see and interact with in their browsers?**

术语 _rendering_（渲染）看似专业术语，但其本质只是解决 Web 领域的根本性挑战的一种方式：**我们如何将** _**代码**_ **转化为用户能在浏览器中看到并与其交互的** _**内容**_ **？**

If it helps, think of rendering strategies like different ways to serve a meal. You could:

如果类比有助于理解，不妨将渲染策略想象成提供一顿餐食的不同方式。例如，你可以：

- Pre-cook everything (static rendering)

- 提前做好所有菜品（静态渲染）

- Refire cold plates (incremental static revalidation)

- 对已上桌的冷菜重新加热（增量式静态重新验证）

- Cook dishes as orders come in (server-side rendering)

- 根据订单实时烹饪（服务端渲染）

- Give customers ingredients to prepare themselves (client-side rendering)

- 将食材交给顾客，由其自行烹制（客户端渲染）

Each approach has its place, depending on the type of meal and the dining experience you want to create. And the best restaurants use a _combination_ of approaches to ensure timeliness, freshness, and allowing for customer preference.

每种方式都有其适用场景，取决于你提供的“餐食”类型以及期望营造的“用餐体验”。而最出色的餐厅往往采用 _多种方式相结合_ 的策略，以兼顾上菜的及时性、菜品的新鲜度，并满足顾客的个性化偏好。

Different rendering strategies work for different apps. Combining them together helps you balance factors like speed, data freshness, and interactivity. Understanding these strategies isn't about memorizing technical terms—it's about choosing the right tools at the right time to create the best possible user (and developer) experience.

不同的渲染策略适用于不同类型的 App。将它们组合使用，有助于你在速度、数据新鲜度和交互性等因素之间取得平衡。理解这些策略，关键不在于死记硬背技术术语——而在于在恰当的时机选用恰当的工具，从而打造最佳的用户体验（以及开发者体验）。

## Defining each rendering strategy

## 定义每种渲染策略

Let’s explore each rendering method in detail, focusing on its ideal use cases, benefits, and implementation considerations.

让我们深入探讨每种渲染方法，重点关注其最适用的场景、优势以及实现时需考虑的因素。

### What is Static Site Generation (SSG)?

### 什么是静态站点生成（SSG）？

SSG prerenders pages at build time, resulting in static HTML files that can be cached at the edge and served quickly and efficiently.

SSG 在构建时预先渲染页面，生成静态 HTML 文件，这些文件可在边缘节点缓存，并快速、高效地提供给用户。

SSG fetches dynamic data from your origin server and puts it into your application at build time. Then, users get all fast, static data on request.

SSG 在构建阶段从源服务器获取动态数据，并将其注入应用程序中；之后，用户在请求时即可获得全部快速响应的静态内容。

**Ideal use cases:**

**理想使用场景：**

- Any page with content that changes very infrequently

- 内容极少更新的任何页面

- Site layouts

- 网站布局页

- Performance-critical marketing pages

- 对性能要求极高的营销落地页

- Documentation or other sites that quickly rebuild

- 文档类网站，或其他可快速重建的网站

**Benefits:**

**优势：**

- Fastest possible page loads

- 页面加载速度最快

- Excellent SEO performance

- 搜索引擎优化（SEO）效果极佳

- Reduced server load

- 服务器负载降低

- Lowest infrastructure costs

- 基础设施成本最低


**Implementation considerations:**

**实施注意事项：**

- Increased build times for sites with a large number of pages

- 页面数量较多的网站，构建时间会延长

- Content updates require a new build and deployment

- 内容更新需要重新构建并部署

- Can be combined with client-side data fetching for dynamic elements, but this is slower than server-side fetching since each data request initiates a new roundtrip to the server

- 可与客户端数据获取（client-side data fetching）结合以支持动态元素，但这种方式比服务端获取（server-side fetching）更慢，因为每次数据请求都会触发一次新的客户端到服务器的往返通信（roundtrip）


**Best practices:**

**最佳实践：**

- Consider ISR for frequently changing content or long build times

- 对于频繁更新的内容或构建时间过长的情况，请考虑使用增量静态再生（ISR）。

### ) What is Incremental Static Regeneration (ISR)?

### ) 什么是增量静态再生（ISR）？

ISR allows you to update specific pages after you’ve built your site, meaning you don't have to rebuild to get new cached data. This combines the benefits of static generation with the ability to scale to millions of pages.

ISR 允许你在网站构建完成后更新特定页面，即无需重新构建整个站点即可获取新的缓存数据。这种方式融合了静态生成（Static Generation）的优势与可扩展至百万级页面的能力。

Incremental Static Regeneration builds much more quickly than SSG, and then caches server data with the first client request, meaning that each request after that gets data at the same speed as SSG. Data can then be revalidated on demand.

相较于静态站点生成（SSG），增量静态再生（ISR）的构建速度快得多；并且会在首次客户端请求时缓存服务端数据，此后所有后续请求均可获得与 SSG 相当的数据响应速度。数据还可按需重新验证（revalidate）。

**Ideal use cases:**

**理想适用场景：**

- When builds with SSG are too long

- 静态站点生成（SSG）构建耗时过长时

- Ecommerce product pages

- 电商平台商品详情页

- New websites

- 新上线的网站

- Large-scale content sites

- 大型内容型网站

**Benefits:**

**优势：**

- Maintains the fast page loads of SSG  
- 保持静态站点生成（SSG）的快速页面加载性能

- Allows for on-demand content updates without full rebuilds  
- 支持按需更新内容，无需完整重建整个站点

- Scales to large numbers of pages efficiently  
- 能够高效扩展至海量页面

- Can be more cost-effective than SSR in some cases  
- 在某些场景下，相比服务端渲染（SSR）更具成本效益


**Implementation considerations:**  
**实施注意事项：**

- Carefully manage [cache invalidation strategies](https://nextjs.org/docs/app/building-your-application/data-fetching/fetching-caching-and-revalidating)  
- 精心管理[缓存失效策略](https://nextjs.org/docs/app/building-your-application/data-fetching/fetching-caching-and-revalidating)

- Understand how [ISR differs from cache-control headers](https://vercel.com/docs/incremental-static-regeneration#differences-between-isr-and-cache-control-headers)  
- 理解[增量静态再生（ISR）与 `Cache-Control` 响应头的区别](https://vercel.com/docs/incremental-static-regeneration#differences-between-isr-and-cache-control-headers)


**Best practices:**  
**最佳实践：**

- Favor on-demand over time-based revalidation—there’s almost always a _reason_ to change content that’s not a timer  
- 优先采用按需重新验证，而非基于时间的重新验证——内容更新几乎总有一个明确的触发原因，而非单纯依赖计时器

- Use static loading skeletons (React Suspense) for instances where the user misses the cache  
- 在用户未命中缓存时，使用静态加载骨架（React Suspense）

[**See ISR in action.**  
**亲眼见证增量静态再生（ISR）的实际效果。**  

Learn how to instantly update cached content on demand—without redeploying.  
了解如何按需即时更新缓存内容——无需重新部署。  

See Demo  
查看演示](https://vercel.com/templates/next.js/on-demand-incremental-static-regeneration)

### What is Server-Side Rendering (SSR)?  
### 什么是服务端渲染（SSR）？

SSR generates the full HTML for a page on each request, allowing for real-time data and personalized content.  
SSR 在每次请求时动态生成页面的完整 HTML，从而支持实时数据与个性化内容。

Server Side Rendering ensures data is always fresh, but the user does have to wait to get data from the server on each request.  
服务端渲染可确保数据始终最新，但用户每次请求时都需等待服务器返回数据。

**Ideal use cases:**  
**理想适用场景：**

- When you are already revalidating ISR on the majority of user requests (i.e., you almost always need fresh data)  
- 大多数用户请求中已启用 ISR 重新验证（即几乎始终需要最新数据）

- Highly personalized dashboard pages  
- 高度个性化的仪表盘页面

- Social media feeds  
- 社交媒体信息流

- Real-time data visualizations  
- 实时数据可视化图表

**Benefits:**  
**优势：**

- Always serves fresh, up-to-date content  
- 始终提供新鲜、实时更新的内容  

- Better for SEO and data load time than client-side fetches  
- 相较于客户端获取，更有利于 SEO 和数据加载时间  

**Implementation considerations:**  
**实现注意事项：**  

- Slower load than SSG or ISR  
- 加载速度慢于静态站点生成（SSG）或增量静态再生（ISR）  

- [Time to First Byte (TTFB)](https://vercel.com/resources/how-vercel-improves-your-websites-search-engine-ranking#network-response-time-to-first-byte-(ttfb)) can be lacking  
- [首字节时间（TTFB）](https://vercel.com/resources/how-vercel-improves-your-websites-search-engine-ranking#network-response-time-to-first-byte-(ttfb)) 可能表现不佳  

- Consumes more server resources  
- 消耗更多服务器资源  

**Best practices:**  
**最佳实践：**  

- Implement efficient caching strategies (e.g. Vercel KV) for frequently accessed data  
- 为高频访问的数据实施高效的缓存策略（例如 Vercel KV）  

- Use streaming SSR to improve perceived performance (this is the default behavior with the Next.js App Router)  
- 使用流式服务端渲染（streaming SSR）以提升用户感知性能（Next.js App Router 中此为默认行为）  

- [Use React Suspense](https://vercel.com/blog/improving-interaction-to-next-paint-with-react-18-and-suspense) to render static pieces of your application while the client waits for server data  
- [使用 React Suspense](https://vercel.com/blog/improving-interaction-to-next-paint-with-react-18-and-suspense)，在客户端等待服务端数据时，先渲染应用中的静态部分

- Optimize database queries and API calls to reduce render times  
- 优化数据库查询和 API 调用，以缩短渲染时间  

[**See React Server Components in action.**  
**亲身体验 React Server Components 的实际效果。**  

The Next.js App Router allows you to opt into better rendering patterns with streaming by default. This template can show you how.  
Next.js App Router 默认支持流式传输（streaming），助您轻松采用更优的渲染模式。本模板将为您演示具体实现方式。  

View Demo  
查看演示  

](https://vercel.com/templates/next.js/app-directory)

### ) What is Client-Side Rendering (CSR)?  
### ) 什么是客户端渲染（CSR）？

CSR relies on JavaScript to render content in the browser (on the user’s device), offering high interactivity and responsiveness but with trade-offs in initial load time.  
CSR 依赖 JavaScript 在浏览器（即用户设备）中完成内容渲染，具备高度交互性与响应性，但初始加载时间相对较长。

Importantly, CSR is not mutually exclusive with any other rendering strategy. Rather, it can be used on top of them to augment existing functionality.  
重要的是，CSR 并不与其他任何渲染策略互斥；相反，它可叠加于其他策略之上，以增强现有功能。

**Ideal use cases:**  
**理想适用场景：**

- User interactions with elements on the page that require immediate feedback, where JavaScript can provide a faster response than waiting for a server roundtrip in SSR.  
- 页面元素需即时反馈的用户交互场景——此时 JavaScript 的响应速度远超服务端渲染（SSR）所需的服务器往返延迟。

- Admin dashboards with real-time data, such as the graphs in Vercel Analytics  
- 实时数据驱动的管理后台（如 Vercel Analytics 中的数据图表）

- Ongoing background tasks after initial load, such as an app like [Notion](https://www.notion.so/) which syncs content back to the server as the user writes  
- 初始加载完成后持续运行的后台任务，例如 [Notion](https://www.notion.so/) 这类应用——用户编辑内容时即实时同步至服务器

**Benefits:**  
**优势：**

- Highly interactive user experiences  
- 高度交互式的用户体验  

- Seamless transitions between application states  
- 应用状态之间的无缝过渡  

- Real-time interactions with external data  
- 与外部数据的实时交互  


**Implementation considerations:**  
**实现注意事项：**  

- Initial load can be slower due to the JavaScript bundle needing to download before fetch can start  
- 初始加载可能较慢，因为需先下载 JavaScript 包，然后才能启动数据获取（fetch）  

- Optimizing Core Web Vitals can be challenging  
- 优化核心网页指标（Core Web Vitals）可能具有挑战性  

- Requires careful state management on the client  
- 需要在客户端进行精细的状态管理  


**Best practices:**  
**最佳实践：**  

- Lean on [Next.js code splitting](https://nextjs.org/learn/dashboard-app/navigating-between-pages#automatic-code-splitting-and-prefetching) to reduce initial bundle size  
- 借助 [Next.js 的代码分割](https://nextjs.org/learn/dashboard-app/navigating-between-pages#automatic-code-splitting-and-prefetching) 以减小初始包体积  

- User server-side rendering for the initial load, then hydrate for interactivity (this can help with [Largest Contentful Paint](https://vercel.com/resources/how-vercel-improves-your-websites-search-engine-ranking))  
- 对初始加载采用服务端渲染（SSR），随后进行水合（hydration）以启用交互性（此举有助于改善[最大内容绘制（LCP）](https://vercel.com/resources/how-vercel-improves-your-websites-search-engine-ranking)）

### ) What is Partial Prerendering (PPR)?

### ) 什么是部分预渲染（Partial Prerendering，PPR）？

While still experimental, PPR aims to automatically optimize rendering strategies, potentially simplifying development decisions.

尽管目前仍处于实验阶段，PPR 旨在自动优化渲染策略，从而可能简化开发决策。

It does this by prerendering any static part of your page and then streaming in the dynamic content based on React Suspense boundaries.

它通过预渲染页面中的所有静态部分，再基于 React 的 Suspense 边界按需流式传输动态内容来实现这一目标。

You get all the benefits of static and dynamic in a single page.

你可以在单个页面中同时获得静态渲染与动态渲染的全部优势。

**Ideal use cases:**

**理想适用场景：**

PPR is an enhancement on top of the other rendering strategies. Although it's still in development, we're hopeful that it will be something you'll want to toggle on by default for any Next.js application.

PPR 是对其他渲染策略的一种增强。尽管目前仍在开发中，我们仍希望它最终能成为任何 Next.js 应用默认启用的功能。

**Benefits:**

**优势：**

- Instant page load (like SSG)

- 页面即时加载（类似静态站点生成，SSG）

- Seamlessly stream dynamic content in the order that makes sense (augmenting SSR)

- 按逻辑顺序无缝流式传输动态内容（增强服务端渲染，SSR）

- Improved performance with reduced development overhead

- 性能更优，同时降低开发负担

**Current considerations:**

**当前注意事项：**

- Still in research and development

- 仍处于研究与开发阶段

- May require code refactoring to opt in

- 启用该功能可能需要对代码进行重构

**Preparation strategies:**

**准备策略：**

- Begin drawing better Suspense boundaries in your application, fully distinguishing between static and dynamic content

- 开始在应用中更合理地划定 Suspense 边界，清晰区分静态内容与动态内容

[**See Partial Prerendering in action.**\\
\\
Partial Prerendering combines ultra-quick static edge delivery with fully dynamic capabilities, and we believe it will become the default rendering model for web applications.\\
\\
View Demo](https://vercel.com/templates/next.js/partial-prerendering-nextjs)

[**亲身体验部分预渲染（Partial Prerendering）效果。**\\
\\
部分预渲染将超快速的静态边缘交付能力与完整的动态能力相结合，我们相信它将成为 Web 应用的默认渲染模型。\\
\\
查看演示](https://vercel.com/templates/next.js/partial-prerendering-nextjs)

## When to use each rendering strategy

## 各渲染策略的适用场景

When deciding on a rendering strategy, consider the following factors.

在选择渲染策略时，请综合考虑以下因素：

- **How often does this content change?** SSG is good for static content, ISR is great for periodically changing content, and SSR or CSR is best for real-time data. Lean on SSG and ISR as much as possible, and only introduce SSR when you need fresh to that moment data. (Note that these days, CSR is almost exclusively for responsive interactions— _not_ fetching external data.)

- **该内容更新频率如何？** 静态站点生成（SSG）适用于静态内容；增量静态再生（ISR）适用于周期性变化的内容；服务端渲染（SSR）或客户端渲染（CSR）则最适合实时数据。应尽可能优先采用 SSG 和 ISR；仅当确实需要“毫秒级新鲜”的数据时，才引入 SSR。（请注意：如今 CSR 几乎仅用于响应式交互——_而非_获取外部数据。）

- **Is the page critical for search engine visibility?** Even though Google can render client-side JavaScript, [your Core Web Vitals are still a major factor in determining your ranking](https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://vercel.com/blog/how-core-web-vitals-affect-seo&ved=2ahUKEwjHpdq0-4-HAxXs8LsIHUesACoQFnoECBMQAQ&usg=AOvVaw3m3_s1uz4qA3I6HBxcH9Fx). Healthy CWVs are much easier to achieve on static- and server-rendered pages than on pages with client-side fetches to external data.

- **该页面是否对搜索引擎可见性至关重要？** 尽管 Google 能够渲染客户端 JavaScript，但[您的核心网页指标（Core Web Vitals，CWV）仍是影响搜索排名的关键因素之一](https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://vercel.com/blog/how-core-web-vitals-affect-seo&ved=2ahUKEwjHpdq0-4-HAxXs8LsIHUesACoQFnoECBMQAQ&usg=AOvVaw3m3_s1uz4qA3I6HBxcH9Fx)。相比依赖客户端发起外部数据请求的页面，静态渲染和服务器端渲染的页面更容易实现健康的核心网页指标（CWV）。

- **How much user interaction is expected?** If your page is mostly static with minimal interaction, lean on SSG or ISR plus a little client-side JS. Otherwise, you may need SSR (with client-side hydration).

- **预期用户交互程度如何？** 如果您的页面以静态内容为主、交互极少，建议采用静态站点生成（SSG）或增量静态再生（ISR），并辅以少量客户端 JavaScript。否则，您可能需要服务端渲染（SSR）（配合客户端水合）。

- **What are the load time requirements?** For the fastest possible initial load, use SSG or infrequently-invalidated ISR. To balance fresh data and speed, use ISR or SSR (for up-to-date data). CSR can get you real-time data, but it often costs initial load.

- **加载时间要求是什么？** 若追求最快的首屏加载速度，请使用 SSG 或更新频率较低的 ISR；若需在数据新鲜度与加载速度之间取得平衡，可选用 ISR 或 SSR（确保数据实时更新）；客户端渲染（CSR）可提供实时数据，但通常会牺牲首屏加载性能。

- **Does the content vary by user?** If you need personalized content, you'll likely use SSR or CSR. ISR can work in cases where you can cache personalized content, such as web app settings. SSG will not allow for personalization.

- **内容是否因用户而异？** 若需个性化内容，您很可能需采用 SSR 或 CSR；ISR 在某些场景下也可支持个性化（例如缓存 Web 应用设置等用户专属内容）；而 SSG 则完全不支持个性化。

You can break down the key characteristics of each strategy a bit like this:

您可将每种渲染策略的关键特性大致归纳如下：

| Feature | SSG | ISR | SSR | CSR\*\* |
| --- | --- | --- | --- | --- |
| Build Time | Long | Varies | Short | Short |
| Time to First Byte | Fastest | Fastest\* | Slowest | Medium |
| Largest Contentful Paint | Fastest | Fastest\* | Medium | Slowest |
| Data Freshness | Static | Periodic/On-demand | Real-time | Real-time |
| Server Time / Compute | Lowest | Low | High | Lowest |
| Client-side Performance | Excellent | Excellent | Good | Varies |
| Interactivity | Limited\*\*\* | Limited\*\*\* | Full | Full |

| 特性 | SSG | ISR | SSR | CSR\*\* |
| --- | --- | --- | --- | --- |
| 构建时间 | 较长 | 视情况而定 | 较短 | 较短 |
| 首字节时间（TTFB） | 最快 | 最快\* | 最慢 | 中等 |
| 最大内容绘制（LCP） | 最快 | 最快\* | 中等 | 最慢 |
| 数据新鲜度 | 静态 | 周期性/按需更新 | 实时 | 实时 |
| 服务器耗时 / 计算资源 | 最低 | 较低 | 较高 | 最低 |
| 客户端性能 | 极佳 | 极佳 | 良好 | 视情况而定 |
| 交互能力 | 有限\*\*\* | 有限\*\*\* | 完整 | 完整 |

\\* The first request after revalidation is equal to SSR speeds. All other requests equal SSG speeds.

\\* 首次重新验证后的请求响应速度等同于 SSR；其余请求则与 SSG 速度一致。

\\*\\* Enhancement on top of other rendering strategies.

\\*\\* 在其他渲染策略基础上的增强方案。

\\*\\*\\* Can be enhanced with client-side JavaScript.

\\*\\*\\* 可通过客户端 JavaScript 进行增强。

## Rendering with Next.js

## 使用 Next.js 进行渲染

As your web application grows and you want to mix and match rendering strategies, you'll need a flexible, powerful framework to handle all of them.

随着您的 Web 应用不断扩展，并希望灵活组合多种渲染策略，您将需要一个兼具灵活性与强大功能的框架来统一支持所有这些策略。

Next.js allows developers to leverage different rendering methods within a single application, as appropriate, on a per-page basis.

Next.js 允许开发者在单个应用中，根据需要按页面粒度灵活采用不同的渲染方式。

Key benefits of Next.js include:

Next.js 的核心优势包括：

- **Performance optimization**: Built-in optimizations for images, fonts, scripts, code-splitting, data fetching, and more.

- **性能优化**：内置针对图片、字体、脚本、代码分割、数据获取等的优化能力。

- **Scalability**: Easily scales from small projects to large, complex applications.

- **可扩展性**：轻松支持从小型项目到大型复杂应用的演进。

- **Consistent component architecture:** Use self-contained modules with all required reusable data anywhere. Unlike other frameworks, data isn't limited to page-level fetching.

- **统一的组件架构**：使用自包含模块，在任意位置复用所需的数据。与其他框架不同，数据获取不再局限于页面层级。

- **Future-ready**: Continuous updates to support emerging web standards and technologies. This includes the recent innovations behind PPR (experimental).

- **面向未来**：持续更新以支持新兴的 Web 标准与技术，包括近期推出的 PPR（实验性功能）背后的一系列创新。

Most importantly, Next.js allows you to **choose your rendering strategy on a per-page basis**, giving you the most performant frontends on the web.

最重要的是，Next.js 让你能够**按页面粒度自主选择渲染策略**，从而构建出 Web 上性能最优的前端应用。

## Real-world product rendering strategies

## 真实场景中的产品渲染策略

Understanding rendering strategies in theory is one thing, but the true value lies in applying them effectively in real-world scenarios.

从理论上理解渲染策略是一回事，而其真正价值则体现在真实场景中的高效落地。

Let's explore how different industries can leverage component-level rendering methods with Next.js to create optimized, high-performance web applications.

让我们探讨不同行业如何借助 Next.js 的组件级渲染能力，打造经过优化、高性能的 Web 应用。

### Ecommerce

### 电子商务

Ecommerce platforms require a delicate balance between performance, SEO, and dynamic content. Here's how different rendering strategies can be applied:

电子商务平台需要在性能、SEO 和动态内容之间取得精妙的平衡。以下是不同渲染策略的具体应用方式：

**Static Site Generation (SSG):**

**静态站点生成（SSG）：**

- Homepage layout and static content

- 首页布局与静态内容

- Category page templates

- 分类页面模板

- Static parts of product pages (descriptions, specifications)

- 商品页面中的静态部分（如描述、规格参数）

**Incremental Static Regeneration (ISR):**

**增量式静态再生（ISR）：**

- Product listings with periodic updates

- 定期更新的商品列表

- Product pages with semi-frequent changes (price, stock status)

- 更新频率中等的商品页面（如价格、库存状态）

- User reviews and ratings (regenerated periodically)

- 用户评论与评分（定期重新生成）

**Server-Side Rendering (SSR):**

**服务端渲染（SSR）：**

- 搜索结果页面

- 个性化商品推荐

- 结账过程中的实时库存查询


**Client-Side Rendering (CSR):**

**客户端渲染（CSR）：**

- 购物车功能

- 商品图片画廊及缩放功能

- “加入购物车”与“收藏夹”交互操作


**Implementation Example:** A product page could use SSR and cache the server response, ISR for price and inventory information (revalidated as those pieces of information change on the backend), dynamic SSR for personalized recommendations, and CSR for the add-to-cart functionality and image gallery. Soon, a product page’s layout and page could be statically rendered with PPR.

**实施示例：** 商品详情页可采用 SSR 并缓存服务器响应；对价格和库存信息采用增量静态再生（ISR），并在后端数据变更时重新验证；对个性化推荐采用动态 SSR；而“加入购物车”功能与图片画廊则采用 CSR。不久之后，商品页的布局与整页内容还可通过部分预渲染（PPR）实现静态化。

[**面向大众的电商解决方案。**\\
\\
如果您希望亲眼见证其实际效果，或仅需参考业界最佳实践，请查阅我们持续更新的 Next.js 电商模板。\\
\\
立即部署](https://vercel.com/templates/next.js/nextjs-commerce)

### Web application

### 网页应用

Data-heavy applications, such as analytics providers, require static performance and real-time interactivity. Here's an approach:

数据密集型应用（例如分析服务提供商）需要兼顾静态性能与实时交互性。以下是一种可行方案：

**Static Site Generation (SSG):**

**静态站点生成（SSG）：**

- Marketing pages and documentation

- 营销页面和文档

- Dashboard templates and layouts

- 仪表板模板与布局

- Static help content and FAQs

- 静态帮助内容与常见问题解答（FAQ）

**Incremental Static Regeneration (ISR):**

**增量式静态再生（ISR）：**

- Periodic reports and summaries (daily/weekly updates)

- 定期报告与摘要（每日/每周更新）

- User account settings pages

- 用户账户设置页面

- Billing and subscription information pages

- 账单与订阅信息页面

**Server-Side Rendering (SSR):**

**服务端渲染（SSR）：**

- 实时数据可视化

- 自定义报表生成

- 用户身份认证流程


**Client-Side Rendering (CSR):**

**客户端渲染（CSR）：**

- 交互式数据探索工具

- 实时数据筛选与排序

- 仪表盘自定义界面


**Implementation Example:** A dashboard could use SSR and cache the server response for the overall layout, ISR for summary widgets updated daily (or when the user clicks refresh), dynamic SSR for real-time data feeds, and CSR for interactive data exploration tools. This is similar to how Vercel's dashboard works, for instance.

**实现示例：** 一个仪表盘可采用 SSR 渲染整体布局并缓存服务器响应；对每日更新（或用户点击“刷新”时更新）的汇总小部件采用增量静态再生（ISR）；对实时数据流采用动态 SSR；对交互式数据探索工具则采用 CSR。例如，Vercel 的仪表盘即采用类似架构。

### Full-stack AI Application

### 全栈 AI 应用

AI applications often require a balance between static content and dynamic, computationally intensive features:

AI 应用通常需要在静态内容与动态、计算密集型功能之间取得平衡：

**Static Site Generation (SSG):**

**静态站点生成（SSG）：**

- Landing pages and marketing content

- 着陆页和营销内容

- Documentation and tutorials

- 文档和教程

- Pre-computed model outputs for common queries

- 常见查询的预计算模型输出

**Incremental Static Regeneration (ISR):**

**增量式静态再生（ISR）：**

- Frequently asked questions with AI-generated answers

- 由 AI 生成答案的常见问题（FAQ）

- Galleries of AI-generated content (refreshed periodically)

- AI 生成内容图库（定期刷新）

- User-submitted content showcases

- 用户提交内容展示区

**Server-Side Rendering (SSR):**

**服务端渲染（SSR）：**

- Personalized AI model responses streamed to the user  
- 个性化 AI 模型响应实时流式传输至用户

- User-specific dashboards and settings  
- 用户专属仪表板与设置


**Client-Side Rendering (CSR):**  
**客户端渲染（CSR）：**

- Interactive AI model parameter adjustments  
- 交互式 AI 模型参数调节

- Real-time input processing (e.g., text, image uploads)  
- 实时输入处理（例如：文本、图片上传）

- Progressive display of AI-generated content  
- AI 生成内容的渐进式展示


**Implementation Example:** An AI image generation app could use SSG and experimental PPR for the main interface, ISR for galleries of popular generations, SSR for personalized results and settings, and CSR for the real-time image generation interface.  
**实现示例：** 一款 AI 图像生成应用可对主界面采用静态站点生成（SSG）与实验性部分预渲染（PPR），对热门生成图像画廊采用增量静态再生（ISR），对个性化结果与设置采用服务端渲染（SSR），而对实时图像生成界面则采用客户端渲染（CSR）。


[**Our flagship AI app.**\\  
[**我们的旗舰 AI 应用。**\\  
\\  
We built v0 from the ground up with the Next.js App Router to take advantage of the best possible rendering patterns.\\  
我们基于 Next.js App Router 从零构建了 v0，以充分利用最优的渲染模式。\\  
\\  
Visit v0](https://v0.dev/)  
访问 v0](https://v0.dev/)


### ) Optimizing for the future with Partial Prerendering (PPR)  
### ) 借助部分预渲染（PPR）面向未来优化  

While PPR is still in development, it's worth considering how it might simplify these architectures in the future:  
尽管 PPR 尚处于开发阶段，但值得思考它未来可能如何简化上述架构：

- **Ecommerce:** PPR 可自动优化商品页面，在服务端预渲染关键内容，同时将“加入购物车”按钮等动态元素留待客户端渲染。

- **Dashboards:** 组件可进行部分预渲染，为实时数据预留占位符，由客户端填充实际数据。

- **AI:** PPR 可预渲染应用外壳（application shell）及通用 AI 输出结果，同时为个性化、动态生成的内容保留空间。

To prepare for PPR:

为采用 PPR 做好准备：

1. Adopt React Server Components where possible.

1. 尽可能采用 React Server Components（RSC）。

2. Structure your application with clear separation between static and dynamic content.

2. 在应用架构中清晰分离静态内容与动态内容。

3. Use Suspense boundaries to define loading states for dynamic content.

3. 使用 Suspense 边界定义动态内容的加载状态。

## Choosing the right rendering strategies for your application

## 为您的应用选择合适的渲染策略

The evolution of web rendering reflects the changing demands of modern web applications. From traditional server-side rendering to cutting-edge techniques, each strategy offers unique benefits for performance, user experience, and developer productivity.

Web 渲染技术的发展历程，映射出当代 Web 应用不断变化的需求。从传统的服务端渲染（SSR），到前沿的新兴技术，每种渲染策略都在性能、用户体验和开发效率方面提供独特的价值。

### Key Takeaways

### 核心要点

1. **Combine strategies**: The most effective applications often combine rendering methods to optimize different components.

1. **组合多种策略**：最有效的应用通常会结合多种渲染方法，以针对不同组件进行优化。

2. **Performance matters**: The right rendering strategy significantly impacts user engagement and business outcomes.

2. **性能至关重要**：恰当的渲染策略会显著影响用户参与度和业务成果。

3. **Flexibility is key**: Frameworks like Next.js allow for tailored solutions within a single application.

3. **灵活性是关键**：Next.js 等框架支持在单个应用内实现量身定制的解决方案。

4. **Stay future-ready**: Build flexible architectures that can adapt to emerging technologies like Partial Prerendering.

4. **面向未来而建**：构建灵活的架构，使其能够适应诸如部分预渲染（Partial Prerendering）等新兴技术。

5. **Let data guide you**: Use real-world performance metrics to inform your decisions.

5. **让数据驱动决策**：借助真实场景下的性能指标来指导技术选型与优化。

### Moving forward

### 向前迈进

As you develop your rendering strategy:

在制定您的渲染策略时：

1. Assess your specific needs and start with the simplest effective solution.

1. 评估您的具体需求，并从最简单但行之有效的方案入手。

2. Continuously measure performance and iterate based on data.

2. 持续测量性能表现，并依据数据反馈不断迭代优化。

3. Invest in your team's knowledge of modern rendering techniques.

3. 投入资源提升团队对现代渲染技术的理解与掌握。

4. Stay informed about emerging trends in web development.

4. 关注网页开发领域的新趋势。

Remember, the goal is to create the best possible user experience while maintaining developer productivity and business agility. By thoughtfully applying these strategies, you'll be well-equipped to deliver exceptional, future-ready web applications.

请牢记：我们的目标是在保障开发者生产力和企业业务敏捷性的同时，打造尽可能出色的用户体验。通过审慎应用这些策略，您将具备充分能力，交付卓越且面向未来的网页应用。

[Get started with Next.js](https://vercel.com/new) in just a few clicks, or [talk to our experts](https://vercel.com/contact/sales) about migrating your large codebase Next.js on Vercel, to give your users the best possible web experience.

只需几下点击，即可[开始使用 Next.js](https://vercel.com/new)；或[联系我们的专家](https://vercel.com/contact/sales)，探讨如何将您的大型代码库迁移至 Vercel 上的 Next.js，从而为您的用户带来最佳的网页体验。

Blog post

博客文章

Jan 19, 2024

2024 年 1 月 19 日

### How Core Web Vitals affect SEO

### 核心网页指标（Core Web Vitals）如何影响搜索引擎优化（SEO）

![](images/how-to-choose-the-best-rendering-strategy-for-your-app-vercel/img_001.jpg)![](images/how-to-choose-the-best-rendering-strategy-for-your-app-vercel/img_002.jpg)

Malte and Alice

Malte 与 Alice

Vercel.com landing page

Vercel.com 官网落地页

### The managed, global rendering layer for modern web applications

### 面向现代网页应用的托管式全球渲染层