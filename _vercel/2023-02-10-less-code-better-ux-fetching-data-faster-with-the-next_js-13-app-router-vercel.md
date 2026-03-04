---
title: "Less code, better UX: Fetching data faster with the Next.js 13 App Router - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/nextjs-app-router-data-fetching"
date: "2023-02-10"
scraped_at: "2026-03-02T09:55:08.114083322+00:00"
language: "en-zh"
translated: true
description: "Fetching data in Next.js 13 has been vastly improved with Server Components, smarter caching, and Loading UI."
---

render_with_liquid: false
Feb 10, 2023

2023 年 2 月 10 日

在 React Server Components 内部直接获取并渲染动态数据。

Next.js 13 的发布带来了诸多令人振奋的新特性，例如自动自托管的 [`@next/font`](https://nextjs.org/blog/next-13#nextfont?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster)，以及高度优化的 [`next/image` 组件](https://nextjs.org/docs/basic-features/image-optimization?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster)。今天，我们将聚焦于 `app` 目录，探讨 React Server Components 与嵌套布局（nested layouts）如何为开发者和终端用户双方节省时间——尤其是在 Vercel 上获取与提供数据的过程中。

[**准备好亲自尝试 App Router 了吗？**  
单击一下即可部署该模板，立即体验 Next.js 13 的 App Router。  
立即部署](https://vercel.com/templates/next.js/app-directory)

借助 Next.js 13 的 App Router，我们可在相关组件内部直接获取数据，而非仅限于页面（page）层级；由此可显著减少重复代码。此外，得益于 [布局（layouts）](https://beta.nextjs.org/docs/routing/pages-and-layouts#layouts?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster)，我们只需在共享同一布局的所有页面之间，一次性渲染动态页眉（dynamic header）即可。请看示例：

Next.js 引入了 `app` 目录（Beta 版），支持你在 Server Components 中直接获取数据。观看 Sam Selikoff 在三分钟内完成演示。

另外，借助 Next.js 13 的 [Loading UI](https://www.youtube.com/watch?v=2o5m1ovfl3c?utm_source=vercel_site&utm_medium=blog&utm_campaign=yt_fetching_data_faster)，即使是服务端获取的数据，现在也能拥有专属的自定义加载骨架（loading skeleton）。此前，用户必须等待服务端数据返回后，才能看到静态 UI 或最大内容绘制（Largest Contentful Paint, LCP）。这一改进不仅缩短了 LCP 和首次交互时间（Time to Interactive），提升了用户体验（UX），同时也优化了应用的 [Core Web Vitals](https://web.dev/vitals/#core-web-vitals)，从而有助于在 Google 搜索中获得更高排名。

接下来，让我们深入对比分析：在页面（page）层级进行数据获取，与使用 Next.js 13 的 `app` 目录进行数据获取，二者在性能与开发体验上的具体改进。

## 使用 `pages` 目录进行数据获取

在页面层级，数据获取可通过多种方式实现：

1. **Server-side rendered (SSR) data.** For data that you want to pre-render on the server before showing it to the user, you use [`getServerSideProps()`](https://nextjs.org/docs/basic-features/data-fetching/get-server-side-props?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster), which runs at page request. This can only be used at the `page` level in your Next.js app. You can then separately configure your [`Cache-Control` headers](https://nextjs.org/docs/basic-features/data-fetching/get-server-side-props#caching-with-server-side-rendering-ssr?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster) to cache data at a set interval and speed up UX.

1. **服务端渲染（SSR）数据。** 对于希望在向用户展示前就在服务器端预先渲染的数据，您应使用 [`getServerSideProps()`](https://nextjs.org/docs/basic-features/data-fetching/get-server-side-props?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster)，该函数在每次页面请求时执行。此方法仅可在 Next.js 应用的 `page` 级别中使用。随后，您可单独配置 [`Cache-Control` 响应头](https://nextjs.org/docs/basic-features/data-fetching/get-server-side-props#caching-with-server-side-rendering-ssr?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster)，以指定时间间隔缓存数据，从而提升用户体验速度。

2. **Static-site generated (SSG) data.** If you wish to pre-render pages that use dynamic data to serve them to the user at static speed, you can use [`getStaticProps()`](https://nextjs.org/docs/basic-features/data-fetching/get-static-props?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster), which only runs on build. This is great for large amounts of non user-specific data (from a CMS, for example) that can be publicly cached.

2. **静态站点生成（SSG）数据。** 如果您希望利用动态数据预先渲染页面，并以静态页面的速度向用户交付，可使用 [`getStaticProps()`](https://nextjs.org/docs/basic-features/data-fetching/get-static-props?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster)，该函数仅在构建（build）阶段运行。这对于大量非用户专属的数据（例如来自内容管理系统 CMS 的数据）尤为适用，且此类数据可被公开缓存。

3. **Incremental statically-generated (ISR) data.** Next.js offers the option to update content incrementally without needing to redeploy, as well as deferring generating static pages to runtime instead of buildtime. To opt-in to this ISR, simply [add a revalidate prop](https://nextjs.org/docs/basic-features/data-fetching/incremental-static-regeneration?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster) to `getStaticProps()`.

3. **增量式静态生成（ISR）数据。** Next.js 提供了无需重新部署即可增量更新内容的能力，同时也支持将静态页面的生成延迟至运行时（runtime），而非构建时（build time）。如需启用 ISR 功能，只需在 `getStaticProps()` 中[添加 `revalidate` 属性](https://nextjs.org/docs/basic-features/data-fetching/incremental-static-regeneration?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster)即可。

4. **Dynamic client-side data.** Data that the client needs to update can be fetched at the page level (at initial page load) or component level (at component mount). You can use the [`useEffect() hook`](https://nextjs.org/docs/basic-features/data-fetching/client-side#client-side-data-fetching-with-useeffect?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster) or the [SWR library](https://nextjs.org/docs/basic-features/data-fetching/client-side#client-side-data-fetching-with-swr?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster) (which we highly recommend).

4. **动态客户端数据。** 客户端需要实时更新的数据，既可在页面级别（首次加载时）获取，也可在组件级别（组件挂载时）获取。您可以使用 [`useEffect()` Hook](https://nextjs.org/docs/basic-features/data-fetching/client-side#client-side-data-fetching-with-useeffect?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster)，或采用我们强烈推荐的 [SWR 库](https://nextjs.org/docs/basic-features/data-fetching/client-side#client-side-data-fetching-with-swr?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster)。

While these data-fetching methods are sufficient, we felt there were ways to reduce boilerplate, improve performance, and simplify Next.js-specific APIs by aligning with React and the Web platform.

尽管上述数据获取方式已足够完备，但我们认为，通过与 React 及 Web 平台标准对齐，仍有空间进一步减少样板代码、提升性能，并简化 Next.js 特有的 API 设计。

## Vastly improved data fetching with App Router

## 借助 App Router 实现大幅改进的数据获取

With the new Next.js 13 `app` directory, all components are now Server Components by default, meaning you can fetch your data inside layouts, pages, and individual components. In addition to saving development time through reducing boilerplate and duplicate code, this also provides a more responsive user experience through smarter [caching](https://beta.nextjs.org/docs/data-fetching/fundamentals#caching-data?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster) and [deduping](https://beta.nextjs.org/docs/data-fetching/fundamentals#automatic-fetch-request-deduping?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster), as well as the new [Loading UI](https://www.youtube.com/watch?v=2o5m1ovfl3c?utm_source=vercel_site&utm_medium=blog&utm_campaign=yt_fetching_data_faster).

借助 Next.js 13 新增的 `app` 目录，所有组件默认均为服务端组件（Server Components），这意味着您可在布局（layout）、页面（page）乃至单个组件内部直接获取数据。此举不仅通过减少样板代码和重复逻辑节省开发时间，还借助更智能的[缓存机制](https://beta.nextjs.org/docs/data-fetching/fundamentals#caching-data?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster)与[自动请求去重](https://beta.nextjs.org/docs/data-fetching/fundamentals#automatic-fetch-request-deduping?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster)，配合全新的[加载界面（Loading UI）](https://www.youtube.com/watch?v=2o5m1ovfl3c?utm_source=vercel_site&utm_medium=blog&utm_campaign=yt_fetching_data_faster)，显著提升了用户交互的响应性。

### Server Components

### 服务端组件

Whenever possible, we [recommend fetching data inside Server Components](https://beta.nextjs.org/docs/rendering/server-and-client-components#why-server-components?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster), which **always fetch data on the server**. Not only does this give you direct access to your backend data, but it's also secure by default, preventing sensitive environment variables from leaking to the client.

只要条件允许，我们都[建议在服务端组件中获取数据](https://beta.nextjs.org/docs/rendering/server-and-client-components#why-server-components?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster)，因为服务端组件**始终在服务器端执行数据获取**。这不仅让您能直接访问后端数据，而且默认即具备安全性——可防止敏感环境变量意外泄露至客户端。

Server-side fetches mean you fetch and render in the same environment, which reduces the back-and-forth between server and client, freeing up the main client thread for other computation. It also means that you can make multiple fetches in the same roundtrip, rather than having them come one-by-one from the client. This lets the request resolve in parallel and helps prevent unwanted waterfalls, where requests stack up on top of one another.

服务端获取意味着数据拉取与页面渲染均在同一环境中完成，从而减少了服务器与客户端之间的来回通信，释放了客户端主线程以处理其他计算任务。此外，您还可于单次往返（roundtrip）中并行发起多个请求，而非由客户端逐个发起。这使得请求得以并行解析，有效避免了“瀑布式请求”（waterfall requests）——即请求彼此堆叠、依次阻塞的问题。

### Static vs. dynamic data

### 静态数据与动态数据

![Dynamic data requires data to be fetched anew on each request. Static data allows cached data to be reused on each request.](images/less-code-better-ux-fetching-data-faster-with-the-next_js-13-app-router-vercel/img_001.jpg)![Dynamic data requires data to be fetched anew on each request. Static data allows cached data to be reused on each request.](images/less-code-better-ux-fetching-data-faster-with-the-next_js-13-app-router-vercel/img_002.jpg)Dynamic data requires data to be fetched anew on each request. Static data allows cached data to be reused on each request.

动态数据要求每次请求时都重新获取数据；静态数据则允许缓存的数据在每次请求中重复使用。

The new data fetching in Next.js 13 is built on top of the [`fetch()` Web API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API) and makes use of `async` / `await` in Server Components.

Next.js 13 引入的全新数据获取机制基于 [`fetch()` Web API](https://developer.mozilla.org/zh-CN/docs/Web/API/Fetch_API)，并在服务端组件（Server Components）中原生支持 `async` / `await`。

Now, instead of using `getServerSideProps()` and `getStaticProps()`, **all fetched data is static by default**, meaning it's rendered at build time. However, Next.js extends the `fetch` options object to allow each request to set its own [caching and revalidating rules](https://beta.nextjs.org/docs/data-fetching/caching?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster).

如今，无需再使用 `getServerSideProps()` 和 `getStaticProps()`，**所有通过 `fetch` 获取的数据默认均为静态数据**，即在构建时完成渲染。不过，Next.js 扩展了 `fetch` 的配置对象，使每个请求均可自定义其 [缓存与重新验证规则](https://beta.nextjs.org/docs/data-fetching/caching?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster)。

With the [`{next: revalidate}` option](https://beta.nextjs.org/docs/data-fetching/revalidating?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster), you are able to refresh any piece of your static data, either at a set interval or when that piece changes in your backend.

借助 [`{next: revalidate}` 选项](https://beta.nextjs.org/docs/data-fetching/revalidating?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster)，您可以按固定时间间隔自动刷新任意静态数据，或在后端该数据发生变更时即时触发更新。

For dynamic data that changes often or is specific to users, you can pass the [`{cache: no-store}` option](https://beta.nextjs.org/docs/data-fetching/fetching#dynamic-data-fetching?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster) in the `fetch` request.

对于频繁变动或与用户身份强相关的动态数据，您可在 `fetch` 请求中传入 [`{cache: no-store}` 选项](https://beta.nextjs.org/docs/data-fetching/fetching#dynamic-data-fetching?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_fetching_data_faster)，以禁用缓存。

## Fetch your own data

## 获取您自己的数据

Ready to try out these new features? Get started with our [Next.js 13 App Playground](https://vercel.com/templates/next.js/app-directory) or [deploy your own Next.js app to Vercel](https://vercel.com/new).

准备好体验这些新特性了吗？立即通过我们的 [Next.js 13 应用沙盒](https://vercel.com/templates/next.js/app-directory) 开始上手，或 [将您的 Next.js 应用部署至 Vercel](https://vercel.com/new)。

To learn more about how Vercel can serve your dynamic data at the speed of static, [take a product tour](https://vercel.com/product-tour?thankyou) or [get in touch with our team](https://vercel.com/contact/sales) today.

如需进一步了解 Vercel 如何以静态数据的速度交付动态内容，[立即观看产品演示](https://vercel.com/product-tour?thankyou)，或 [今天就联系我们的销售团队](https://vercel.com/contact/sales)。

\[ [These links](https://status-code-test-server.vercel.app/discovery) are [temporarily displayed](https://status-code-test-server.vercel.app/discovery-alternative) for SEO testing purposes.\]

\[ 这些链接](https://status-code-test-server.vercel.app/discovery) 是为搜索引擎优化（SEO）测试目的而 [临时展示](https://status-code-test-server.vercel.app/discovery-alternative) 的。］

Vercel Template

Vercel 模板

Deploy this template

部署此模板

### Examples of many Next.js App Router features.

### Next.js App Router 的多项功能示例。

Next.js App Router Playground

Next.js App Router 交互式体验平台

Twitter post

Twitter 帖子

### If you were looking for examples of Next.js 13 + \`app/\` directory in a real-world, prod, OSS site 👇

### 如果你正在寻找一个真实世界、生产环境、开源（OSS）网站中 Next.js 13 + \`app/\` 目录的实际应用示例 👇

![Guillermo Rauch's avatar](images/less-code-better-ux-fetching-data-faster-with-the-next_js-13-app-router-vercel/img_003.jpg)Guillermo Rauch@rauchg

![Guillermo Rauch 的头像](images/less-code-better-ux-fetching-data-faster-with-the-next_js-13-app-router-vercel/img_003.jpg)Guillermo Rauch@rauchg