---
title: "New features for SvelteKit: Optimize your application with ease - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/feature-complete-sveltekit"
date: "2023-06-20"
scraped_at: "2026-03-02T09:52:00.600534136+00:00"
language: "en-zh"
translated: true
description: "Get the most out of your SvelteKit app with pre-route configuration, Incremental Static Regeneration, and data at the Edge."
---

render_with_liquid: false
Jun 20, 2023

2023年6月20日

Vercel 上的框架定义基础设施（Framework-Defined Infrastructure，FDI）将原本仅限 Next.js 的功能带到了 SvelteKit。

Svelte 凭借其将组件编译为高度优化的 JavaScript 模块的独特方式，在 Web 开发框架领域声名鹊起。这种创新的应用渲染方式消除了传统框架中常见的运行时开销，从而构建出性能更强、效率更高的应用程序。

随着 [SvelteKit 1.0 版本的发布](https://vercel.com/blog/using-sveltekit-1-0-on-vercel)，开发者可以放心使用全栈式 Svelte 功能，而无需担忧破坏性变更。此外，SvelteKit 持续演进，提供了一套功能完备的特性集，并与包括 Vercel 在内的多种部署环境实现无缝集成。

Vercel 借助 [框架定义基础设施（FDI）](https://vercel.com/blog/framework-defined-infrastructure) 拥抱了 SvelteKit，并近期新增了对以下特性的支持：面向 Serverless 和 Edge Functions 的[按路由配置](https://vercel.com/docs/frameworks/sveltekit#configure-your-sveltekit-deployment)、[增量静态再生（ISR）](https://vercel.com/docs/frameworks/sveltekit#incremental-static-regeneration-isr)，以及更便捷地兼容[一系列 Vercel 产品](https://vercel.com/docs/frameworks/sveltekit#web-analytics)（例如 Web Analytics）。本文将探讨如何让您的应用具备更高性能、更强可扩展性及更佳用户体验。

## SvelteKit 适配器

## SvelteKit 适配器

首先，了解 [SvelteKit 的适配器系统](https://kit.svelte.dev/docs/adapters) 是很有帮助的。SvelteKit 应用会构建为平台无关的 JavaScript，因此我们需要借助适配器将其部署到目标平台。

SvelteKit 的适配器通过向部署环境提供项目所需的精确能力信息，来助力框架定义基础设施（FDI）。这使得单一代码库具备极强的灵活性：您只需更换适配器，即可将应用部署至任意数量的平台。

默认情况下，执行 `npm create svelte@latest` 生成的 SvelteKit 应用已内置 `adapter-auto`。该适配器适用于绝大多数项目，其主要作用是在构建过程中自动识别项目所需的具体适配器并完成下载。

![An example SvelteKit deployment to Vercel.](images/new-features-for-sveltekit-optimize-your-application-with-ease-vercel/img_001.jpg)![An example SvelteKit deployment to Vercel.](images/new-features-for-sveltekit-optimize-your-application-with-ease-vercel/img_002.jpg)一个将 SvelteKit 部署至 Vercel 的示例。

However, if you know your deployment environment ahead of time, it's best to install the appropriate adapter, since this both clarifies your `package.json` and slightly improves build times.

然而，如果你事先已知部署环境，则最好安装对应的适配器（adapter），因为这既能让你的 `package.json` 更清晰明确，又能略微提升构建速度。

In addition to `adapter-auto`, the Svelte team have built adapters for:

除 `adapter-auto` 外，Svelte 团队还为以下平台构建了适配器：

- Vercel

- [Netlify](https://vercel.com/kb/guide/vercel-vs-netlify)

- Cloudflare 和 Cloudflare Workers

- Node

- 静态网站生成（Static site generation）

The community has also built numerous adapters for other deployments, such as a standalone Deno or Bun server, an Electron desktop app, a browser extension, and even a "multi-adapter" that allows your application to automatically build to multiple deployments. For a full listing of adapters, check out the official [Svelte Society listing](https://sveltesociety.dev/components#adapters).

社区也开发了大量面向其他部署场景的适配器，例如：独立运行的 Deno 或 Bun 服务器、Electron 桌面应用、浏览器扩展，甚至还有一个“多适配器”（multi-adapter），可让应用自动构建并适配多种部署目标。如需查看适配器的完整列表，请访问官方 [Svelte Society 适配器页面](https://sveltesociety.dev/components#adapters)。

## Per-route data fetching and rendering

## 按路由的数据获取与渲染

SvelteKit's new deployment configuration gives you full control over how your routes are deployed to Vercel as functions. Learn how to deploy some parts of your app as Edge functions, some as serverless functions, and some utilizing ISR.

SvelteKit 的新部署配置让你能完全掌控各路由在 Vercel 上以函数形式部署的方式。了解如何将应用的不同部分分别部署为 Edge 函数、无服务器函数（serverless functions），以及启用增量静态再生（ISR）。

Now that we've covered how adapters work, it’s time to zoom in on some of the benefits your SvelteKit application gains when deploying to Vercel.

在了解了适配器（adapters）的工作原理之后，现在是时候聚焦于将 SvelteKit 应用部署到 Vercel 时所能获得的诸多优势了。

Any route in your SvelteKit app (`+page.svelte`) can access data returned by a `load` function colocated in the same directory in a `+page.js` or `+page.server.js` file. The `load` function has access to dynamic parameters, such as URL, and can send them to any server- or client-side request, including HTML-native fetches.

SvelteKit 应用中的任意路由（`+page.svelte`）均可访问同目录下 `+page.js` 或 `+page.server.js` 文件中定义的 `load` 函数所返回的数据。该 `load` 函数可获取动态参数（例如 URL），并能将这些参数传递给任意服务端或客户端请求——包括原生 HTML 的 `fetch` 调用。

The [`load` function](https://kit.svelte.dev/docs/load?utm_source=svelte_site&utm_medium=web&utm_campaign=improving_sveltekit_apps) can run on the client or the server, depending on if it's coming from a `+page.js` or `+page.server.js`, but your page will not render until data has been acquired. This is useful to avoid layout shift and other issues that come from loading data after page render. You can also fetch data at the Layout level, providing data for all child routes. For times you need to fetch on the client side after the component renders, you can do so within SvelteKit's `onMount()`.

[`load` 函数](https://kit.svelte.dev/docs/load?utm_source=svelte_site&utm_medium=web&utm_campaign=improving_sveltekit_apps) 可根据其定义位置（`+page.js` 或 `+page.server.js`）选择在客户端或服务端执行；但无论在哪执行，页面都**必须等待数据加载完成之后才开始渲染**。这一机制有助于避免因页面渲染后才加载数据而导致的布局偏移（layout shift）等问题。你还可以在 Layout 层级（即 `+layout.js` 或 `+layout.server.js`）中获取数据，从而为所有子路由统一提供共享数据。若需在组件挂载后、于客户端发起数据请求，则可在 SvelteKit 的 `onMount()` 生命周期钩子中实现。

While there's always been a lot of flexibility in how to fetch and render data in SvelteKit, it’s now possible to adjust your Vercel-specific settings for each individual route.

尽管 SvelteKit 历来就支持高度灵活的数据获取与渲染方式，但现在你已可针对 Vercel 平台，为**每个独立路由**单独配置专属设置。

You can choose whether a route uses Serverless or Edge Functions, and whether that route dynamically renders data (SSR), pre-renders data (SSG), or uses [Incremental Static Regeneration (ISR)](https://vercel.com/docs/concepts/incremental-static-regeneration/overview) to do the best of both.

你可以自主选择某一路由使用 Serverless 函数还是 Edge 函数；同时，还可指定该路由采用哪种渲染策略：服务端渲染（SSR）、静态站点生成（SSG），抑或结合两者优势的[增量静态再生（ISR）](https://vercel.com/docs/concepts/incremental-static-regeneration/overview)。

### Serverless vs. Edge Functions

### Serverless 函数 vs. Edge 函数

Serverless and Edge Functions each have their distinct advantages. In general, Edge Functions are cheaper, faster, and feature longer timeouts (to stay active for slower data such as OpenAI's API), but you often need Serverless Functions for larger tasks like dynamic content generation or handling authentication. [Check the docs](https://vercel.com/docs/concepts/limits/overview#functions-comparison) for a full comparison.

Serverless 函数与 Edge 函数各具优势。总体而言，Edge 函数成本更低、响应更快，且支持更长的超时时间（适用于调用 OpenAI 等响应较慢的 API 场景）；但对于内容动态生成、身份认证等计算密集型任务，通常仍需依赖 Serverless 函数。[请查阅文档](https://vercel.com/docs/concepts/limits/overview#functions-comparison) 获取完整对比说明。

Now that you know when to use each type of function, here's how to configure your individual routes for SvelteKit on Vercel.

现在你已了解各类函数的适用场景，接下来我们将介绍如何在 Vercel 上为 SvelteKit 应用的各个路由进行具体配置。

The `+page.js` / `+layout.js` and `+page.server.js` / `+layout.server.js` files can export a `config` constant that determines the rendering strategy of your dynamic data.

`+page.js` / `+layout.js` 及 `+page.server.js` / `+layout.server.js` 文件均可导出一个 `config` 常量，用于指定对应动态数据的渲染策略。

page.server.js

```javascript
export const config = {

2  runtime: 'edge',

3};



export const load = ({ cookies }) => {

6  // Load function code here

7};
```

```javascript
export const config = {

2  runtime: 'edge',

3};



export const load = ({ cookies }) => {

6  // 加载函数的代码在此处

7};
```

A SvelteKit load function running on Vercel's edge network.

在 Vercel 边缘网络上运行的 SvelteKit `load` 函数。

To use Serverless instead of edge, `runtime` can also take `'nodejs16.x'` or `'nodejs18.x'`, depending on which node environment you're running your application. SvelteKit apps default to Serverless Functions.

若要改用 Serverless 而非边缘运行时，`runtime` 也可设为 `'nodejs16.x'` 或 `'nodejs18.x'`，具体取决于您的应用所运行的 Node.js 环境。SvelteKit 应用默认使用 Serverless 函数。

To opt your entire application into the `edge` runtime, you can configure your `svelte.config.js` and then override these settings on individual routes.

如需将整个应用切换至 `edge` 运行时，您可在 `svelte.config.js` 中进行全局配置，再针对个别路由覆盖该设置。

`svelte.config.js`

`svelte.config.js`

```javascript
import adapter from '@sveltejs/adapter-vercel';



const config = {

4  kit: {

5    adapter: adapter({

6      runtime: 'edge',

7    }),

8  },

9};
```

```js
export default config;
```

```js
export default config;
```

在应用程序的 Svelte 配置中调整运行时设置，将为整个应用设定默认行为。

默认情况下，Serverless 函数从华盛顿特区运行，而 Edge 函数则在全球范围内选择距离用户最近的位置运行。您可以在应用程序的任意位置[修改此行为](https://vercel.com/docs/frameworks/sveltekit#regions)，使函数更靠近您的数据源运行。[访问文档](https://vercel.com/docs/frameworks/sveltekit#configure-your-sveltekit-deployment)可查看完整的配置选项列表。

### 增量静态再生（Incremental Static Regeneration, ISR）

增量静态再生（ISR）是一种现代 Web 开发策略，允许开发者在初始构建完成后，按需创建和更新静态页面。

![ISR 在构建时间（开发者体验 DevEx）和静态生成（用户体验 UX）两方面均带来显著提升。](images/new-features-for-sveltekit-optimize-your-application-with-ease-vercel/img_003.jpg)![ISR 在构建时间（开发者体验 DevEx）和静态生成（用户体验 UX）两方面均带来显著提升。](images/new-features-for-sveltekit-optimize-your-application-with-ease-vercel/img_004.jpg)ISR 在构建时间（开发者体验 DevEx）和静态生成（用户体验 UX）两方面均带来显著提升。

该方案融合了静态站点生成（SSG）与服务端渲染（SSR）二者的优势：既保障终端用户的快速加载体验，又减轻服务器负载，并支持在无需全量重建的前提下更新内容。由于 ISR 对终端用户而言与 SSG 高度相似，它还能大幅改善[搜索引擎排名效果](https://vercel.com/blog/nextjs-seo-playbook#rendering-and-why-it-matters)。

![对终端用户而言，ISR 的效果与静态站点生成无异，且由 Vercel 的边缘网络提供服务。](images/new-features-for-sveltekit-optimize-your-application-with-ease-vercel/img_005.jpg)![对终端用户而言，ISR 的效果与静态站点生成无异，且由 Vercel 的边缘网络提供服务。](images/new-features-for-sveltekit-optimize-your-application-with-ease-vercel/img_006.jpg)对终端用户而言，ISR 的效果与静态站点生成无异，且由 Vercel 的边缘网络提供服务。

自今年年初起，SvelteKit 已正式支持与 Vercel 协同使用的 ISR 功能。如需配置 ISR，您需在服务端配置对象（例如上文所述的 Serverless 函数与 Edge 函数配置）中添加 `isr` 属性。

For example, you may have a blog where all the articles are pulled from a CMS:

例如，您可能有一个博客，其中所有文章都从 CMS 中获取：

blog/\[slug\]/+page.server.js

blog/\[slug\]/+page.server.js

```javascript
export const config = {

2  isr: {

3    // Expiration time (in seconds) before the cached asset

4    // will be regenerated by invoking the Serverless Function.

5    // Setting the value to `false` means it will never expire.

6    expiration: 60,

7};
```

```javascript
export const config = {

2  isr: {

3    // 缓存资源的过期时间（单位：秒），超过该时间后，

4    // 将通过调用无服务器函数重新生成该资源。

5    // 将该值设为 `false` 表示永不过期。

6    expiration: 60,

7};
```

Setting up ISR also occurs within the config object of a \`page.server.js\` file.

在 \`page.server.js\` 文件的 `config` 对象中同样可配置增量静态再生（ISR）。

You can also include a `bypassToken` to programmatically bypass or refresh the ISR cache. [Take a look at the docs](https://vercel.com/docs/frameworks/sveltekit#incremental-static-regeneration-isr) to learn more about these advanced options.

您还可以传入一个 `bypassToken`，以编程方式绕过或刷新 ISR 缓存。[请参阅相关文档](https://vercel.com/docs/frameworks/sveltekit#incremental-static-regeneration-isr)，了解这些高级选项的更多详情。

## Other Vercel gains

## 其他 Vercel 优势

Vercel Developer Advocate Steph Dietz explains how to optimize web forms with Vercel KV and SvelteKit form actions.

Vercel 开发者倡导者 Steph Dietz 介绍了如何使用 Vercel KV 和 SvelteKit 表单操作来优化网页表单。

- **Data at the edge.** Your app is only as fast as its slowest piece, so earlier this year, we introduced [Edge Config](https://vercel.com/blog/edge-config-ultra-low-latency-data-at-the-edge), a near-0ms latency data store associated with your Vercel account that enables you to read data at the edge without querying an external database. Now, we're rolling out [Vercel KV, Postgres, and Blob](https://vercel.com/blog/vercel-storage) to give you a suite of fully-integrated data products at the Edge.

- **边缘数据。** 您的应用性能受限于其最慢的组件；因此，今年早些时候，我们推出了 [Edge Config](https://vercel.com/blog/edge-config-ultra-low-latency-data-at-the-edge) —— 一种与您的 Vercel 账户关联、延迟接近 0 毫秒的数据存储服务，让您无需查询外部数据库即可在边缘读取数据。如今，我们正全面推出 [Vercel KV、Postgres 和 Blob](https://vercel.com/blog/vercel-storage)，为您提供一套完全集成的边缘数据产品组合。

- **Preview Deployments.** SvelteKit users on Vercel have always had access to immutable, per-`git commit` deployments that run live on Vercel's Edge Network. We introduced our [Figma-like commenting feature](https://vercel.com/docs/concepts/deployments/comments) last year, and now we're introducing [Visual Editing](https://vercel.com/blog/visual-editing), so you can edit CMS-generated elements of your site directly on the webpage.

- **预览部署（Preview Deployments）。** 使用 Vercel 的 SvelteKit 用户始终可获得基于每次 `git commit` 的不可变部署，这些部署直接运行于 Vercel 边缘网络之上。去年，我们推出了类似 Figma 的[评论功能](https://vercel.com/docs/concepts/deployments/comments)；如今，我们进一步推出 [可视化编辑（Visual Editing）](https://vercel.com/blog/visual-editing)，让您可直接在网页上编辑由 CMS 生成的内容元素。

- **Analytics.** Vercel Web Analytics can be integrated in your SvelteKit project with

[just three lines of code](https://vercel.com/docs/frameworks/sveltekit#web-analytics). This enables you to visualize and monitor your application's traffic over time, and when paired with [Speed Insights](https://vercel.com/docs/frameworks/sveltekit#speed-insights), gives a clear picture of your app's performance for your users.

- **分析（Analytics）。** Vercel Web Analytics 可通过仅需 [三行代码](https://vercel.com/docs/frameworks/sveltekit#web-analytics) 集成至您的 SvelteKit 项目中。这使您能够随时间推移直观呈现并监控应用流量；当与 [Speed Insights](https://vercel.com/docs/frameworks/sveltekit#speed-insights) 结合使用时，更能清晰展现您的应用面向终端用户的实际性能表现。

## Bringing it all together

## 整合所有优势

Deploying SvelteKit on Vercel means more flexibility, faster data fetching, and better team tools than ever. You have:

在 Vercel 上部署 SvelteKit，意味着前所未有的灵活性、更快的数据获取速度，以及更强大的团队协作工具。您将拥有：

- Edge-based, native Vercel data solutions such as Vercel KV, Postgres, and Edge Config.

- 基于边缘的原生 Vercel 数据解决方案，例如 Vercel KV、Postgres 和 Edge Config。

- Per-route fetching and rendering configuration for Edge Functions, Serverless Functions, and ISR.  
- 针对边缘函数（Edge Functions）、无服务器函数（Serverless Functions）和增量静态再生（ISR）的按路由获取与渲染配置。

- A true-to-production Preview Deployment of your application, with live editing and commenting from your whole team.  
- 与生产环境完全一致的应用预览部署（Preview Deployment），支持整个团队实时编辑与评论。

- Native analytics and reporting to monitor your application's performance.  
- 原生分析与报表功能，助您持续监控应用性能。

- Many more features, such as [Cron Jobs](https://vercel.com/docs/cron-jobs) or [Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware#), that we haven't touched on in this article.  
- 更多强大功能——例如 [Cron Jobs（定时任务）](https://vercel.com/docs/cron-jobs) 或 [Edge Middleware（边缘中间件）](https://vercel.com/docs/concepts/functions/edge-middleware#)，本文尚未一一详述。

Plus, Vercel offers native integrations with a [host of popular tools](https://vercel.com/integrations) so you can compose your team's ideal workflow.  
此外，Vercel 提供与[众多流行工具](https://vercel.com/integrations)的原生集成，助您灵活构建团队专属的理想工作流。

We'll be continuing to develop SvelteKit on Vercel with new and better features, so be sure to check back soon.  
我们将持续在 Vercel 平台上深化 SvelteKit 的开发，不断推出新功能与优化体验，敬请期待！

[**Figuring out if SvelteKit works for you?**\\  
\\  
Reach out to us with your team's unique needs.\\  
\\  
Contact Us](https://vercel.com/solutions/svelte)  
[**SvelteKit 是否适合您的项目？**\\  
\\  
欢迎联系我们，告诉我们您团队的具体需求。\\  
\\  
立即联系](https://vercel.com/solutions/svelte)