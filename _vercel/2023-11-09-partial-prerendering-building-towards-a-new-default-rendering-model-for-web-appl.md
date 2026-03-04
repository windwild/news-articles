---
title: "Partial prerendering: Building towards a new default rendering model for web applications - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model"
date: "2023-11-09"
scraped_at: "2026-03-02T09:49:36.494865026+00:00"
language: "en-zh"
translated: true
description: "PPR combines ultra-quick static delivery with fully dynamic capabilities and we believe it has the potential to become the default rendering model for web applications, bringing together the best of s..."
---
&#123;% raw %}

Nov 9, 2023

2023 年 11 月 9 日

在 Vercel 上使用 Next.js 14 探索部分预渲染（Partial Prerendering）。

在今年的 [Next.js Conf](https://www.youtube.com/watch?v=gfU1iZnjRZM) 大会上，我们探讨了动态 Web 应用在全球分发过程中所面临的开发者与用户体验挑战：如何在避免昂贵的“瀑布式”数据请求（expensive waterfalls）的前提下获取数据，同时又能直接从边缘节点（edge）交付内容？

应对所有这些当前挑战的答案是：**部分预渲染（Partial Prerendering，简称 PPR）**。

PPR 将超快速的静态边缘交付能力与完全动态的功能相结合。我们相信，PPR 具备成为 Web 应用默认渲染模型的潜力，从而融合静态站点生成（SSG）与动态交付二者之长。

今天，您即可在 Vercel 上 [试用 PPR 的实验性预览版](https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model#try-ppr-on-vercel-today)，配合 Next.js 14；[或访问我们的演示站点](https://www.partialprerendering.com/)，第一时间体验 PPR 的实际效果。

## 理解被消除的权衡取舍

PPR 汇聚了主流渲染模式的最佳特性，既支持快速的边缘交付，又支持从核心数据中心动态获取数据。

![该表格对比了常见渲染策略的特性与 PPR 的特性，凸显 PPR 如何消除了其他方法中不得不面对的权衡取舍。](images/partial-prerendering-building-towards-a-new-default-rendering-model-for-web-appl/img_001.jpg)  
![该表格对比了常见渲染策略的特性与 PPR 的特性，凸显 PPR 如何消除了其他方法中不得不面对的权衡取舍。](images/partial-prerendering-building-towards-a-new-default-rendering-model-for-web-appl/img_002.jpg)  
该表格对比了常见渲染策略的特性与 PPR 的特性，凸显 PPR 如何消除了其他方法中不得不面对的权衡取舍。

## 一套久经考验的编程模型

With Partial Prerendering in Next.js, rendering happens in a single React render tree. Static optimization is on-by-default and covers all components until the app accesses incoming request information like headers or cookies, which is a clear signal that dynamic rendering is needed. Next.js then changes the smallest possible section of the page to be dynamic while keeping static optimization for everything else.

在 Next.js 的部分预渲染（Partial Prerendering）机制下，整个页面的渲染发生在单个 React 渲染树中。静态优化默认启用，并覆盖所有组件，直到应用访问请求相关的信息（例如请求头或 Cookie）——这明确表明需要动态渲染。此时，Next.js 仅将页面中尽可能小的区域切换为动态渲染，其余部分则继续保持静态优化。

You may be thinking: “We did this in the 90s with [server-side includes](https://en.wikipedia.org/wiki/Server_Side_Includes)”. That is true, but in that world static and dynamic were separated into completely different technology worlds and we didn’t have incremental updates of static content.

你或许会想：“我们在 90 年代就用过 [服务端包含（SSI）](https://zh.wikipedia.org/wiki/%E6%9C%8D%E5%8A%A1%E5%99%A8%E7%AB%AF%E5%8C%85%E5%90%AB) 做过类似的事。” 这确实没错，但在那个时代，静态与动态内容被严格划分到完全不同的技术体系中，我们也没有对静态内容进行渐进式更新的能力。

Consider the following ecommerce page:

请看下面这个电商页面示例：

```jsx
export default function Page() {

2  return (

3    <main>

4      <header>

5        <h1>My Store</h1>

6        <Suspense fallback={<CartSkeleton />}>

7          <ShoppingCart />
```

8        </Suspense>

8        </Suspense>

9      </header>

9      </header>

10      <Banner />

10      <Banner />

11      <Suspense fallback={<ProductListSkeleton />}>

11      <Suspense fallback={<ProductListSkeleton />}>

12        <Recommendations />

12        <Recommendations />

13      </Suspense>

13      </Suspense>

14      <NewProducts />

14      <NewProducts />

15    </main>

15    </main>

16  );

16  );

17}
```
17}
```

With PPR enabled, this page generates a static shell based on your `<Suspense />` boundaries. The `fallback` provided to React Suspense is prerendered.

启用 PPR 后，本页面会基于您的 `<Suspense />` 边界生成一个静态外壳（shell）。React Suspense 所提供的 `fallback` 内容将被预渲染。

Suspense fallbacks in the shell are then replaced with dynamic components, like reading cookies to determine the cart, or showing a banner based on the user.

随后，外壳中 Suspense 的 `fallback` 将被动态组件所替换，例如读取 Cookie 以确定购物车内容，或根据用户身份展示横幅广告。

## Under the hood of PPR

## PPR 的底层机制

When you build your application, Next.js will prerender a static _shell_ for each page of your application, leaving _holes_ for the dynamic content.

构建应用时，Next.js 会为每个页面预渲染一个静态的“外壳”（shell），并在其中为动态内容预留“空洞”（holes）。

When a user visits a page, the fast static shell is served from the end-user’s nearest [Vercel Region](https://vercel.com/docs/edge-network/overview), allowing the user to start consuming the page, and the client and server to work in parallel. The client can start parsing scripts, stylesheets, fonts, and static markup while the server renders dynamic chunks using [React’s new streaming architecture](https://vercel.com/blog/understanding-react-server-components).

当用户访问某页面时，该快速静态外壳将从离用户最近的 [Vercel 区域节点（Region）](https://vercel.com/docs/edge-network/overview) 提供服务，使用户能立即开始浏览页面，同时客户端与服务器并行工作：客户端可立即开始解析脚本、样式表、字体及静态标记，而服务器则利用 [React 全新的流式渲染架构（streaming architecture）](https://vercel.com/blog/understanding-react-server-components) 渲染动态区块。

PPR offers a unified model that blends the reliability and speed of [Incremental Static Regeneration (ISR)](https://vercel.com/docs/incremental-static-regeneration) and the dynamic capabilities of [Server-Side Rendering (SSR)](https://vercel.com/docs/frameworks/nextjs#server-side-rendering-ssr). In fact, this is exactly how PPR is implemented. Because PPR takes advantage of React <Suspense> boundary, _you_ decide whether the boundary is static or dynamic.

PPR 提供了一种统一模型，融合了 [增量静态再生（ISR）](https://vercel.com/docs/incremental-static-regeneration) 的可靠性与速度，以及 [服务端渲染（SSR）](https://vercel.com/docs/frameworks/nextjs#server-side-rendering-ssr) 的动态能力。事实上，PPR 正是按此方式实现的。由于 PPR 借助了 React 的 `<Suspense>` 边界机制，**您**可自主决定该边界是静态还是动态。

- The static shell retains the ability to be updated via Incremental Static Regeneration (ISR).

- 静态外壳仍可通过增量静态再生（ISR）进行更新。

- If you use features that require dynamic rendering, such as accessing cookies, Next.js automatically switches to dynamic rendering up to the closest Suspense boundary.

- 如果您使用了需要动态渲染的功能（例如读取 Cookie），Next.js 将自动向上回溯至最近的 `<Suspense>` 边界，并在此边界内启用动态渲染。

## Not just for app shells

## 不仅适用于应用外壳

PPR can be leveraged for any app along the static/dynamic spectrum. Whether you have a dashboard containing mostly dynamic content and a relatively barebones shell around it, or a page that contains mostly static content with dynamic elements throughout.

PPR 可应用于静态与动态光谱上任意类型的应用：无论您构建的是一个以动态内容为主、外壳相对精简的仪表盘，还是一个以静态内容为主体、但嵌入多处动态元素的页面。

For example, in our [product detail page example](https://www.partialprerendering.com/) almost all content is part of the static prerender. Only the customer reviews section, shopping cart count, the personalized delivery time based on user zip code, and the below-the-fold recommendations stream in via dynamic streaming.

例如，在我们的[商品详情页示例](https://www.partialprerendering.com/)中，几乎所有内容都属于静态预渲染部分。仅客户评价区域、购物车数量、基于用户邮政编码的个性化配送时间，以及折叠区域以下的推荐内容流，是通过动态流式传输加载的。

This wireframe of a typical product detail page shows elements that are typically static in purple and elements that are often dynamic in blue. With PPR the vast majority of content for such a page can get delivered instantly from the edge.

该典型商品详情页的线框图中，通常为静态的内容以紫色标出，而通常为动态的内容则以蓝色标出。借助部分预渲染（PPR），此类页面的绝大部分内容均可直接从边缘节点即时交付。

![](images/partial-prerendering-building-towards-a-new-default-rendering-model-for-web-appl/img_003.jpg)![](images/partial-prerendering-building-towards-a-new-default-rendering-model-for-web-appl/img_004.jpg)![](images/partial-prerendering-building-towards-a-new-default-rendering-model-for-web-appl/img_003.jpg)![](images/partial-prerendering-building-towards-a-new-default-rendering-model-for-web-appl/img_004.jpg)

![](images/partial-prerendering-building-towards-a-new-default-rendering-model-for-web-appl/img_003.jpg)![](images/partial-prerendering-building-towards-a-new-default-rendering-model-for-web-appl/img_004.jpg)![](images/partial-prerendering-building-towards-a-new-default-rendering-model-for-web-appl/img_003.jpg)![](images/partial-prerendering-building-towards-a-new-default-rendering-model-for-web-appl/img_004.jpg)

Additionally, because PPR is based on ISR, you can take advantage of the same on-demand, time-based, and tag-based revalidation for the static shell [that is available to ISR today](https://nextjs.org/docs/app/building-your-application/data-fetching/fetching-caching-and-revalidating#revalidating-data).

此外，由于 PPR 基于增量静态再生（ISR），您可对静态外壳（static shell）复用当前 ISR 所支持的按需再生、定时再生及基于标签的再生机制——参见 [ISR 当前支持的再生方式](https://nextjs.org/docs/app/building-your-application/data-fetching/fetching-caching-and-revalidating#revalidating-data)。

## Open to all frameworks

## 面向所有前端框架开放

The [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure) primitive that Partial Prerendering leverages when used on Vercel can be natively adopted by any frontend framework through [Vercel’s Build Output API](https://vercel.com/docs/build-output-api/v3). Framework authors can get in touch with us to talk about how to integrate PPR into their framework.

Partial Prerendering 在 Vercel 上运行时所依赖的 “[框架定义的基础设施](https://vercel.com/blog/framework-defined-infrastructure)” 这一基础能力，可通过 [Vercel 的构建输出 API（Build Output API）](https://vercel.com/docs/build-output-api/v3) 原生集成至任意前端框架。框架作者可随时联系我们，探讨如何将 PPR 集成到其框架中。

## Try PPR on Vercel today

## 立即在 Vercel 上体验 PPR

You can try Partial Prerendering with the latest Next.js 14 Canary using the app directory on Vercel today.

您今天即可在 Vercel 上，使用最新版 Next.js 14 Canary（配合 `app` 目录）体验 Partial Prerendering（PPR）功能。

```bash
npm install next@canary
```

```bash
npm install next@canary
```

Add the following configuration to your `next.config.js` file or check out the [template](https://vercel.com/templates/next.js/partial-prerendering-nextjs) to get started.

请将以下配置添加至您的 `next.config.js` 文件中，或参考 [模板项目](https://vercel.com/templates/next.js/partial-prerendering-nextjs) 快速上手。

`next.config.js`

`next.config.js`

```javascript
experimental: {

2  ppr: true,

3},
```

```javascript
experimental: {

2  ppr: true,

3},
```

Please note that PPR is truly an experimental technology that is **not yet recommended for production use**.

请注意，PPR 确实是一项实验性技术，**目前尚不建议在生产环境中使用**。

You may run into some developer experience issues, especially on larger code bases, and known issues such that client-side navigations do not yet perform a streaming render (coming soon).

您可能会遇到一些开发者体验方面的问题，尤其是在较大的代码库中；目前已知的问题包括：客户端导航尚不支持流式渲染（即将推出）。

Partial Prerendering is a major step in web application delivery.

部分预渲染（Partial Prerendering）是 Web 应用交付领域的一项重大进展。

We’re excited to see what the community builds on it, and we will continue to iterate on the best developer experience and best user experience for modern websites and web applications.

我们非常期待社区基于它构建出的各种创新应用，同时将持续优化开发体验与终端用户体验，为现代网站和 Web 应用提供更佳支持。
&#123;% endraw %}
