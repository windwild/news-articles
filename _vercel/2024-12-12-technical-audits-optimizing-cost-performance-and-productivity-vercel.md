---
title: "Technical audits: Optimizing cost, performance, and productivity - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/technical-audits"
date: "2024-12-12"
scraped_at: "2026-03-02T09:38:28.521286738+00:00"
language: "en-zh"
translated: true
description: "See what we've learned from hundreds of real-world audits—what to look for and what you can do to improve your applications."
---
&#123;% raw %}

Dec 12, 2024

2024 年 12 月 12 日

How we identify the bottlenecks that impact your bottom line.

我们如何识别影响您利润的关键瓶颈。

Every 100ms of latency can cost ecommerce applications up to [8% in sales conversion](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud). At scale, this can cost millions in revenue.

每增加 100 毫秒的延迟，就可能导致电商应用的销售转化率下降多达 [8%](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud)。在大规模业务场景下，这可能意味着数百万美元的营收损失。

Complexity compounds as applications grow, making these performance issues harder to diagnose and fix. Audits help teams navigate these challenges systematically.

随着应用规模扩大，系统复杂性呈指数级增长，使得此类性能问题愈发难以诊断与修复。性能审计（Audits）帮助团队系统性地应对这些挑战。

This article covers strategies we've developed across hundreds of real-world audits.

本文汇总了我们在数百次真实世界性能审计中所积累并验证有效的优化策略。

## The tipping point: When performance meets scale

## 转折点：性能与规模相遇之时

Recently, one of our enterprise ecommerce customers hit a common inflection point.

近期，我们的一家大型电商企业客户遭遇了一个典型的发展拐点。

Their Next.js application launched with great performance metrics, but as they added personalization features to drive engagement, complexity grew. Simple A/B testing evolved into sophisticated user recommendations and dynamic pricing, which hurt their metrics.

其 Next.js 应用上线初期性能表现优异，但随着为提升用户参与度而持续引入个性化功能，系统复杂性迅速攀升：原本简单的 A/B 测试，逐步演变为复杂的用户推荐系统与动态定价机制，最终拖累了关键性能指标。

The impact was immediate and severe:

影响立竿见影且十分严重：

- Time to First Byte (TTFB) jumped 300%  
- 首字节时间（TTFB）激增 300%

- Conversions dropped 15%  
- 转化率下降了 15%

- Server costs doubled in three months  
- 服务器成本在三个月内翻倍

The issue wasn't technical debt or poor architecture. It was the inherent challenge of balancing static optimization with dynamic features.  
问题并非源于技术债务或架构设计不佳，而在于静态优化与动态功能之间固有的平衡难题。

![Slow load times have direct impact on user behavior.](images/technical-audits-optimizing-cost-performance-and-productivity-vercel/img_001.jpg)![Slow load times have direct impact on user behavior.](images/technical-audits-optimizing-cost-performance-and-productivity-vercel/img_002.jpg)Slow load times have direct impact on user behavior.  
![缓慢的加载时间会直接影响用户行为。](images/technical-audits-optimizing-cost-performance-and-productivity-vercel/img_001.jpg)![缓慢的加载时间会直接影响用户行为。](images/technical-audits-optimizing-cost-performance-and-productivity-vercel/img_002.jpg)缓慢的加载时间会直接影响用户行为。

Through our technical audit, we helped them keep their new features while restoring performance. This resulted in cutting TTFB by 70%, returning conversions to previous levels, and reducing server costs by 40%. Most importantly, we helped them establish patterns to maintain performance while adding new dynamic features.  
通过本次技术审计，我们帮助他们在保留新功能的同时恢复了性能：首字节时间（TTFB）降低 70%，转化率回升至原有水平，服务器成本减少 40%。最重要的是，我们协助他们建立起一套可持续的实践模式——在持续添加新动态功能的同时，长期保障应用性能。

Technical audits deliver the most value at specific inflection points in your application's lifecycle. Let's explore how you can identify these opportunities.  
技术审计在应用生命周期中的特定拐点上能带来最大价值。接下来，我们将探讨如何识别这些关键机会。

## Three types of technical audits  
## 三种类型的技术审计

### 1. Code Review Audits: When architecture needs validation  
### 1. 代码审查型审计：当架构需要验证时  

Code Review Audits help you optimize rendering and caching strategies during major transitions. When a large ecommerce platform needed to migrate from Pages Router to App Router, we helped them identify optimization opportunities:  
代码审查型审计有助于您在重大架构演进阶段优化渲染与缓存策略。例如，当一家大型电商平台需从 Pages Router 迁移至 App Router 时，我们协助其识别出以下优化机会：

- React Server Components (RSC) payloads that were 3x larger than necessary  
- React Server Components（RSC）的有效载荷体积是实际所需大小的三倍

- Data fetching waterfalls impacting page performance  
- 数据获取瀑布流影响页面性能  

- Suboptimal caching strategies affecting performance  
- 次优的缓存策略影响性能  

Our comprehensive analysis delivered:  
我们的全面分析交付了以下成果：  

- Code and framework best practices  
- 代码与框架最佳实践  

- Framework-optimized code examples, patterns, and strategies  
- 针对框架优化的代码示例、模式与策略  

- Prioritized and detailed action plan  
- 经优先级排序且详尽的行动方案  

- A detailed migration roadmap with milestones  
- 包含关键里程碑的详细迁移路线图  

After following our action plan, they completed their migration 40% faster than estimated while improving key performance metrics.  
在遵循我们的行动方案后，他们比原计划提前40%完成了迁移，同时显著提升了关键性能指标。  

### 2\. Web Performance Audits: When performance impacts revenue  
### 2. 网页性能审计：当性能问题直接影响营收  

A major retailer approached us with a problem: their conversion rates were dropping fast. While their initial analysis suggested performance issues, pinpointing the exact cause proved challenging. Our Web Performance Audit revealed three performance issues:  
一家大型零售商向我们提出了一个问题：其转化率正急剧下滑。尽管初步分析已提示存在性能问题，但准确定位根本原因却颇具挑战。我们的网页性能审计揭示了三大性能问题：

- 第三方脚本拖累核心网页指标（Core Web Vitals）

- 图片优化不足，导致最大内容绘制（Largest Contentful Paint, LCP）缓慢

- 关键用户流程中存在低效的 API 级联请求（API waterfall）


通过直面并解决这些问题，我们帮助客户重回正轨：

- 交互时间（Time to Interactive, TTI）缩短 45%

- 转化率提升 6%

- 各项核心网页指标（Core Web Vitals）全面改善


网站性能审计（Web Performance Audits）在以下场景中价值尤为突出：网站上线前评估、任何前端框架迁移期间，以及衡量真实用户实际体验时。

[**核心网页指标影响搜索引擎排名。**  
\\  
了解核心网页指标与 Google 搜索排名之间的紧密关联。  
\\  
了解更多](https://vercel.com/blog/how-core-web-vitals-affect-seo)

### 3. 使用量审计：当规模扩张推高成本

What works for thousands of users can break down at millions. We saw this firsthand when an enterprise customer's serverless costs increased dramatically due to inefficient async operations. Our Usage Audit pinpointed three issues:

对于数千名用户行之有效的方案，在面对数百万用户时可能彻底失效。我们曾亲历过这样一幕：某企业客户因异步操作效率低下，导致其无服务器（serverless）成本急剧攀升。我们的“用量审计”（Usage Audit）精准定位了三大问题：

- Async waterfalls in product and category data fetching causing redundant serverless executions  
- 异步请求链式调用（async waterfalls）在商品与类目数据获取过程中引发大量冗余的无服务器函数执行

- Static pages regenerating too frequently due to short Incremental Static Regeneration (ISR) times  
- 因增量静态再生（Incremental Static Regeneration, ISR）时间设置过短，静态页面被过于频繁地重新生成

- Inefficient data caching patterns causing unnecessary API calls  
- 低效的数据缓存策略导致大量不必要的 API 调用


By implementing targeted optimizations based on real usage data, they reduced their infrastructure costs:

通过基于真实用量数据实施针对性优化，该客户显著降低了基础设施成本：

- Serverless function executions dropped by 60% through parallel data fetching  
- 借助并行数据获取，无服务器函数执行次数下降了 60%

- Cache hit rates improved by extending ISR times and implementing on-demand revalidation  
- 通过延长 ISR 时间并引入按需重新验证（on-demand revalidation），缓存命中率得以提升

- API calls reduced by 40% through optimized caching strategies  
- 借助优化后的缓存策略，API 调用次数减少了 40%


Usage Audits help you optimize infrastructure before costs spiral. You get clear data about how your application consumes resources, letting you make informed optimization decisions. Most importantly, they help establish patterns that maintain performance while adding new features.

用量审计可在成本失控前助您优化基础设施。您将获得清晰、直观的数据，全面了解应用如何消耗各类资源，从而做出有据可依的优化决策。最重要的是，它能帮助您建立可持续的开发模式——在持续新增功能的同时，始终保障系统性能。

## A diagnostic-first approach

## 以诊断为先的方法

Effective technical audits begin by analyzing the gap between intended goals and actual production performance, rather than starting with code review. We assess:

有效的技术审计始于分析预期目标与实际生产性能之间的差距，而非从代码审查入手。我们评估以下方面：

- **User experience:** The application's real-world performance, identify friction points in user flows, and pinpoint where performance metrics start to degrade

- **用户体验：** 应用在真实场景中的性能表现，识别用户操作流程中的卡点，并准确定位性能指标开始下降的环节

- **Resource efficiency:** How effectively the app uses platform resources, uncovers areas driving unexpected costs, and identifies usage patterns that need optimization

- **资源效率：** 应用对平台资源的利用效率，发现导致意外成本增加的环节，并识别亟需优化的资源使用模式

- **Development velocity:** Deployment frequency and identify developer roadblocks that add friction to delivery

- **开发效能：** 部署频率，以及识别阻碍开发者交付、增加交付摩擦的关键瓶颈

This analysis often surfaces key issues impacting application performance and developer productivity.

该分析通常能揭示影响应用性能与开发者生产力的关键问题。

- **Performance bottlenecks:** High TTFB, slow navigations/interactions, and redundant resource preloads

- **性能瓶颈：** 首字节时间（TTFB）过高、页面导航/交互响应缓慢，以及冗余的资源预加载

- **Resource waste:** Overactive page generations, bandwidth spikes from unoptimized images, unoptimized RSC payloads, and inefficient Edge Middleware patterns

- **资源浪费：** 过度频繁的页面生成、未优化图像引发的带宽激增、未优化的 RSC（React Server Components）载荷，以及低效的 Edge Middleware 模式

- **Developer friction:** Misunderstanding of React and Next.js best practices, slow build times, and unintentional security oversights

- **开发者摩擦：** 对 React 和 Next.js 最佳实践的理解偏差、构建速度缓慢，以及无意间造成安全疏漏

This diagnostic-first approach ensures we target improvements that deliver the most value. Understanding the impact on business goals helps prioritize fixes effectively.

这种以诊断为先的方法，确保我们聚焦于能带来最大价值的改进项。深入理解各项问题对业务目标的影响，有助于我们高效地对修复工作进行优先级排序。

[**See if the time is right.**\\
\\
If you're struggling to identify bottlenecks in your app's performance, we can help.\\
\\
Start a Conversation](https://vercel.com/contact/sales)

[**现在是否恰逢其时？**\\
\\
若您正难以定位应用性能中的瓶颈，我们可为您提供帮助。\\
\\
开启对话](https://vercel.com/contact/sales)

## Common patterns that impact performance

## 影响性能的常见模式

After conducting hundreds of technical audits, we've identified key patterns that consistently affect applications. Let's explore some of the most impactful ones and their solutions.

在完成数百次技术审计后，我们识别出若干持续影响应用性能的关键模式。接下来，我们将探讨其中影响最为显著的几种模式及其解决方案。

### Dynamic features vs. static optimization

### 动态功能 vs. 静态优化

Teams often achieve great initial performance through static optimization, only to see it degrade as they add dynamic features. This pattern emerges frequently in ecommerce, where personalization, A/B testing, and inaccurate data directly impact revenue.

团队常通过静态优化实现优异的初始性能，但随着动态功能的引入，性能却随之下降。这一模式在电商领域尤为常见——个性化推荐、A/B 测试以及不准确的数据会直接影响营收。

**Negative business impact:**

**对业务的负面影响：**

- [Misaligned rendering strategies](https://vercel.com/blog/how-to-choose-the-best-rendering-strategy-for-your-app), such as using server-side rendering (SSR) where static would suffice or missing SSR on dynamic paths

- 渲染策略错配，例如在本可采用静态渲染（Static Rendering）的场景下错误使用服务端渲染（SSR），或在动态路由路径上遗漏 SSR

- Lower conversions from slower page loads

- 页面加载变慢导致转化率下降

- Degraded user experience from increased TTFB

- 首字节时间（TTFB）增加导致用户体验下降

**Common implementation issues:**

**常见的实现问题：**

- Static optimization disabled across entire routes

- 整条路由路径上全局禁用了静态优化

- Page-level data fetches that block rendering

- 阻塞渲染的页面级数据获取

- Client-side A/B testing impacting performance

- 影响性能的客户端 A/B 测试

**Recommended solutions:**

**推荐解决方案：**

- Use Edge Middleware with ISR for auth flows

- 在认证流程中结合使用 Edge Middleware 与增量静态再生（ISR）

- Push data fetching down to the component level, often with [SWR](https://swr.vercel.app/)

- 将数据获取下放到组件层级，通常借助 [SWR](https://swr.vercel.app/) 实现

- Move [A/B testing to the server](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config) using Edge Middleware for pre-computed variants

- 利用 Edge Middleware 将 [A/B 测试迁移至服务端](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config)，以预计算实验变体

**Typical outcomes:**

**典型成效：**

- 40-60% reduction in server costs

- 服务器成本降低 40–60%

- Return to baseline conversion rates

- 转化率恢复至基准水平

- Significant TTFB improvements across global regions

- 全球各区域的首字节时间（TTFB）显著改善

![We encourage customers to keep as much of their application as possible static or incrementally revalidated, only opting into dynamic rendering for the small pieces that need it. Next.js, SvelteKit, and many other modern frameworks allow for this hybrid approach.](images/technical-audits-optimizing-cost-performance-and-productivity-vercel/img_003.jpg)  
![我们鼓励客户尽可能将应用保持为静态或增量式重新验证，仅对确实需要动态渲染的少量模块启用动态渲染。Next.js、SvelteKit 以及许多其他现代框架均支持这种混合渲染方式。](images/technical-audits-optimizing-cost-performance-and-productivity-vercel/img_003.jpg)  

![We encourage customers to keep as much of their application as possible static or incrementally revalidated, only opting into dynamic rendering for the small pieces that need it. Next.js, SvelteKit, and many other modern frameworks allow for this hybrid approach.](images/technical-audits-optimizing-cost-performance-and-productivity-vercel/img_004.jpg)  
![我们鼓励客户尽可能将应用保持为静态或增量式重新验证，仅对确实需要动态渲染的少量模块启用动态渲染。Next.js、SvelteKit 以及许多其他现代框架均支持这种混合渲染方式。](images/technical-audits-optimizing-cost-performance-and-productivity-vercel/img_004.jpg)  

We encourage customers to keep as much of their application as possible static or incrementally revalidated, only opting into dynamic rendering for the small pieces that need it. Next.js, SvelteKit, and many other modern frameworks allow for this hybrid approach.  

我们鼓励客户尽可能将应用保持为静态或增量式重新验证，仅对确实需要动态渲染的少量模块启用动态渲染。Next.js、SvelteKit 以及许多其他现代框架均支持这种混合渲染方式。

### Resource optimization  

### 资源优化  

As applications scale, resource usage patterns become increasingly important. We consistently see this with serverless functions and third-party integrations, where small inefficiencies compound into significant costs.  

随着应用规模扩大，资源使用模式变得愈发关键。我们在无服务器函数（serverless functions）和第三方集成中屡见此现象：微小的低效问题会不断累积，最终导致显著的成本增加。

**Negative business impact:**  

**对业务的负面影响：**  

- Increased bandwidth costs from inefficient CDN configurations  

- 因 CDN 配置不当导致的带宽成本上升  

- Higher serverless costs that grow exponentially with increased traffic  

- 无服务器函数成本随流量增长呈指数级上升  

- Degraded performance in global markets  

- 全球各地区性能下降  

**Common implementation issues:**  

**常见的实现问题：**  

- Unoptimized images creating larger page size  

- 图片未经过优化，导致页面体积增大

- Images missing width and height attributes causing layout shift  
- 图片缺少 `width` 和 `height` 属性，导致页面布局偏移（Layout Shift）

- Autoplay videos loading on page load, often from the `public` folder  
- 页面加载时自动播放视频（常来自 `public` 文件夹）

- Sequential API calls instead of parallel API calls in serverless functions  
- 在无服务器函数中采用串行 API 调用，而非并行调用

- Using an additional CDN in front of Vercel's already-optimized Edge Network  
- 在 Vercel 本身已高度优化的边缘网络（Edge Network）之前额外叠加一层 CDN

- Inefficient authentication patterns in middleware affecting all traffic  
- 中间件中低效的身份验证模式，影响全部流量

- Dynamic routes without cache control  
- 动态路由未配置缓存控制（Cache Control）

- Inconsistent data fetching patterns across components, which can lead to redundant requests and increased load times  
- 各组件间数据获取模式不统一，易引发重复请求及加载时间增加

**Recommended solutions:**  
**推荐解决方案：**

- Define image dimensions and use optimized image formats, which [Next.js's Image component](https://nextjs.org/docs/app/api-reference/components/image) can help enforce and serve automatically  
- 明确定义图片尺寸，并采用优化的图片格式；[Next.js 的 Image 组件](https://nextjs.org/docs/app/api-reference/components/image) 可帮助强制执行该规范并自动提供优化服务

- Load video content via blob storage or CDN with lazy loading and/or chunked streaming  
- 通过 Blob 存储或 CDN 加载视频内容，并启用懒加载（lazy loading）和/或分块流式传输（chunked streaming）

- Establish consistent and parallel data fetching patterns

- 建立一致且并行的数据获取模式

- Implement efficient authentication patterns across edge middleware, components, and API endpoints and target specific routes

- 在边缘中间件、组件及 API 端点中实现高效的认证模式，并精准作用于特定路由

- Add strategic caching to minimize function calls

- 引入策略性缓存，以最大限度减少函数调用

**Typical outcomes:**

**典型成果：**

- 30-40% reduction in bandwidth usage

- 带宽使用量降低 30–40%

- 50% fewer serverless function executions

- 无服务器函数执行次数减少 50%

- 90% cache hit rates globally

- 全球缓存命中率达 90%

![A "waterfall" refers to a sequence of network requests that depend on the completion of previous requests. In the case of data fetching, each request can only begin once the previous request has returned data. This is a common pattern we fix in audits to keep sites feeling responsive.](images/technical-audits-optimizing-cost-performance-and-productivity-vercel/img_005.jpg)![A "waterfall" refers to a sequence of network requests that depend on the completion of previous requests. In the case of data fetching, each request can only begin once the previous request has returned data. This is a common pattern we fix in audits to keep sites feeling responsive.](images/technical-audits-optimizing-cost-performance-and-productivity-vercel/img_006.jpg)

A "waterfall" refers to a sequence of network requests that depend on the completion of previous requests. In the case of data fetching, each request can only begin once the previous request has returned data. This is a common pattern we fix in audits to keep sites feeling responsive.

“瀑布流”（waterfall）指一系列依赖前序请求完成才能发起的网络请求。在数据获取场景中，每个请求仅能在前一个请求返回数据后才可开始。这是我们在性能审计中常修复的一种模式，旨在确保网站始终具备良好的响应感。

### Migrating from Pages Router to App Router

### 从 Pages Router 迁移至 App Router

The transition to Next.js App Router unlocks powerful new capabilities, but requires careful planning and a change in patterns.

迁移到 Next.js App Router 可释放强大的新功能，但也需要周密的规划以及开发模式的转变。

**Negative business impact:**

**对业务的负面影响：**

- Delayed feature delivery during extended migrations

- 在长期迁移过程中导致功能交付延迟

- Higher resource costs from inefficient patterns

- 因低效模式导致资源成本上升

- Performance drops affecting user experience and revenue

- 性能下降影响用户体验与收入

**Common implementation issues:**

**常见的实现问题：**

- Oversized RSC payloads sending unnecessary data to clients

- RSC 有效载荷过大，向客户端发送了不必要的数据

- Incorrect client/server component boundaries causing excess client-side JavaScript

- 客户端/服务端组件边界划分不当，导致客户端 JavaScript 过量

- Missing cache configurations in data fetching

- 数据获取中缺少缓存配置

- Props passing entire objects between server/client boundaries instead of specific fields, causing unnecessary re-rendering

- 属性（props）在服务端与客户端边界间传递整个对象，而非特定字段，从而引发不必要的重新渲染

- Legacy patterns, such as not relocating asynchronous functions to the server, blocking static optimization  

- 传统模式，例如未将异步函数迁移至服务端、阻碍静态优化  

**Recommended solutions:**  

**推荐解决方案：**  

- Incrementally migrate from Pages Router to App Router instead of all at once (you can use both in Next.js at the same time)  

- 逐步将应用从 Pages Router 迁移至 App Router，而非一次性全部迁移（Next.js 允许两者共存）  

- Profile RSC payload size using Chrome DevTools and minimize where possible  

- 使用 Chrome DevTools 分析服务端组件（RSC）的响应负载大小，并在可能的情况下尽量减小其体积  

- Use Suspense boundaries for effective client/server rendering  

- 使用 `<Suspense>` 边界实现高效的客户端/服务端渲染协作  

- Implement granular caching with [`use cache`](https://nextjs.org/docs/canary/app/api-reference/directives/use-cache), [`revalidatePath`](https://nextjs.org/docs/app/api-reference/functions/revalidatePath), and [`revalidateTag`](https://nextjs.org/docs/app/api-reference/functions/revalidateTag)  

- 通过 [`use cache`](https://nextjs.org/docs/canary/app/api-reference/directives/use-cache)、[`revalidatePath`](https://nextjs.org/docs/app/api-reference/functions/revalidatePath) 和 [`revalidateTag`](https://nextjs.org/docs/app/api-reference/functions/revalidateTag) 实现细粒度缓存控制  

- Use `React.cache()` and Suspense boundaries to manage complex calls more effectively  

- 利用 `React.cache()` 与 `<Suspense>` 边界更高效地管理复杂数据请求  

**Typical outcomes:**  

**典型成效：**  

- 40% faster migration completion  

- 迁移完成速度提升 40%  

- 50% reduction in client-side JavaScript  

- 客户端 JavaScript 体积减少 50%

- Improved Core Web Vitals across all metrics

- 所有指标的 Core Web Vitals 均得到提升


### Development experience improvements

### 开发体验优化

Improving developer velocity means your users get new features faster and your developers can ship fixes quickly, resulting in a better experience for everyone.

提升开发人员效率，意味着用户能更快用上新功能，开发人员也能更迅速地发布修复，从而为所有人带来更佳的体验。

**Negative business impact:**

**对业务的负面影响：**

- Extended build times blocking rapid iteration

- 构建时间延长，阻碍快速迭代

- Inability to address critical issues during crucial business times (like Black Friday-Cyber Monday)

- 在关键业务时段（例如“黑色星期五—网络星期一”）无法及时处理严重问题

- Technical debt compounding over time

- 技术债务随时间不断累积


**Common implementation issues:**

**常见实施问题：**

- Unoptimized Next.js configurations causing slow builds, particularly from missing [bytecode caching](https://vercel.com/blog/introducing-bytecode-caching-for-vercel-functions)

- Next.js 配置未优化导致构建缓慢，尤其是缺少 [字节码缓存（bytecode caching）](https://vercel.com/blog/introducing-bytecode-caching-for-vercel-functions)

- Inefficient module imports

- 模块导入方式低效

- Trade-offs between DX and performance  
- DX 与性能之间的权衡

- Excessive use of third-party libraries, which can weigh down local development  
- 过度使用第三方库，可能拖慢本地开发体验

**Recommended solutions:**  
**推荐解决方案：**

- Optimize build configurations for your use case  
- 针对您的具体使用场景优化构建配置

- Avoiding barrel files for better bundle times and smaller client-side JavaScript  
- 避免使用 barrel 文件，以缩短打包时间、减小客户端 JavaScript 包体积

- Balance developer experience with performance needs  
- 在开发者体验与性能需求之间取得平衡

- Audit and remove any unnecessary third-party code  
- 审查并移除所有不必要的第三方代码

**Typical outcomes:**  
**典型成效：**

- Build times cut in half  
- 构建时间减少 50%

- Bundle size reduced by 33%  
- 包体积缩减 33%

- Measurable increase in deployment frequency  
- 部署频率的可量化提升  

## Building sustainable patterns  
## 构建可持续的实践模式  

Technical audits work best as catalysts for sustainable improvement, not one-time fixes. They provide value at every stage of your application's lifecycle—before, during, and after major migrations. The goal is to establish patterns that help you build better applications for the long term.  
技术审计最有效的定位是作为推动可持续改进的催化剂，而非一次性修复手段。它们在应用生命周期的各个阶段——重大迁移之前、之中和之后——均能持续创造价值。其目标是建立一套行之有效的实践模式，助您长期构建更优质的应用。

While audits can help identify optimization opportunities during migrations, comprehensive migration support is available through our additional consulting services. This includes guidance for monolith-to-headless transitions and framework migrations.  
尽管审计可在迁移过程中帮助识别优化机会，但我们还提供更全面的迁移支持服务，涵盖单体架构向无头架构（monolith-to-headless）的演进指导，以及框架迁移的专业建议。

To help you implement our recommendations effectively, each audit includes four 30-minute weekly office hours sessions. During these sessions, our experts can answer questions and provide guidance on implementing audit recommendations.  
为助力您高效落实审计建议，每次技术审计均包含四次每周30分钟的专家线上答疑时段（Office Hours）。在此期间，我们的专家将为您答疑解惑，并就如何落地审计建议提供具体指导。

[**Let us know how we can help**  
\\  
Whether you're starting a migration, need help optimizing, or want to add AI to your apps and workflows, we're here to partner with you.  
\\  
Contact Us](https://vercel.com/contact/sales)  
[**告诉我们如何为您提供帮助**  
\\  
无论您正启动架构迁移、需要性能优化支持，还是希望为您的应用与工作流集成 AI 能力，我们都愿成为您值得信赖的合作伙伴。  
\\  
联系我们](https://vercel.com/contact/sales)  

Blog post  
博客文章  

Dec 3, 2024  
2024年12月3日  

### Billions of dollars, billions of requests: Black Friday-Cyber Monday 2024  
### 数十亿美元交易额，数十亿次请求：2024 年黑色星期五—网络星期一  

![](images/technical-audits-optimizing-cost-performance-and-productivity-vercel/img_007.jpg)

Dan Fein

丹·芬恩

Blog post

博客文章

Nov 27, 2024

2024年11月27日

### Retailer sees $10M increase in sales on Vercel

### 零售商在 Vercel 平台上实现销售额增长 1000 万美元

![](images/technical-audits-optimizing-cost-performance-and-productivity-vercel/img_008.jpg)

Alina Weinstein

阿莉娜·魏因斯坦
&#123;% endraw %}
