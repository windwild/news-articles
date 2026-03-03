---
title: "Incremental Static Regeneration (ISR): A flexible way to cache dynamic content - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/isr-a-flexible-way-to-cache-dynamic-content"
date: "2024-09-16"
scraped_at: "2026-03-02T09:42:04.419674901+00:00"
language: "en-zh"
translated: true
description: "Explore how Incremental Static Regeneration (ISR) enhances your caching strategy. Learn its benefits, implementation across frameworks, and real-world applications. Optimize performance with this hybr..."
---

Sep 16, 2024

2024 年 9 月 16 日

在各行业与各类框架中高效运用 ISR。

在各行业与各类框架中高效运用 ISR（增量静态再生）。

Incremental Static Regeneration (ISR) is a caching strategy that combines the perks of multiple rendering techniques to bring users dynamic content at cached speeds.

增量静态再生（ISR）是一种缓存策略，它融合了多种渲染技术的优势，使用户能在缓存速度下获取动态内容。

This guide explores how ISR fits into your overall caching strategy, how it can benefit your architecture, and how to implement it effectively. We'll compare ISR to traditional caching methods and provide real-world examples to illustrate its advantages.

本指南将探讨 ISR 如何融入您的整体缓存策略、它如何为您的架构带来收益，以及如何高效地实现 ISR。我们将把 ISR 与传统缓存方法进行对比，并提供真实案例来说明其优势。

## Benefits of caching

## 缓存的优势

Caching is a technique in web development that involves storing and reusing previously fetched or computed data. It helps improve website performance by:

缓存是 Web 开发中的一项技术，指存储并重复使用先前获取或计算得到的数据。它通过以下方式提升网站性能：

- **Reducing server load:** By serving cached content, fewer requests reach the server, allowing it to handle more traffic.

- **降低服务器负载：** 通过提供缓存内容，可减少抵达服务器的请求量，从而让服务器能够处理更多流量。

- **Saving bandwidth:** Serving cached content reduces the data transferred between servers and clients, which can also decrease costs.

- **节省带宽：** 提供缓存内容可减少服务器与客户端之间传输的数据量，从而也可能降低运营成本。

- **Decreasing latency:** Cached responses are typically served much faster than generating new responses, resulting in quicker page loads, more responsive applications, and better user engagement.

- **降低延迟：** 缓存响应通常比生成新响应快得多，从而加快页面加载速度、提升应用响应性，并增强用户参与度。

- **Content availability:** Cached content can remain available for end users even if providers go down.

- **内容可用性：** 即便内容提供方出现故障，缓存的内容仍可继续向终端用户提供。

Effective caching is key to build fast, scalable web apps.

高效缓存是构建快速、可扩展 Web 应用的关键。

## ISR: A modern server-side caching strategy

## ISR：一种现代化的服务端缓存策略

ISR is a hybrid cache that combines the benefits of static site generation (SSG) and server-side rendering (SSR). It allows for:

ISR 是一种混合型缓存机制，融合了静态站点生成（SSG）与服务端渲染（SSR）二者的优势。它支持以下能力：

- **Cached speeds with live content:** Quickly serve edge-cached static content to users while updating data in the background. (This is known as "stale-while-revalidate" in HTTP caching.)

- **缓存速度 + 实时内容**：向用户快速提供边缘缓存的静态内容，同时在后台异步更新数据。（HTTP 缓存中称此模式为“过期后验证”，即 *stale-while-revalidate*。）

- **Selective regeneration:** Update specific pages without rebuilding the entire site. This can significantly reduce build times, [especially for content-heavy sites like Sonos](https://vercel.com/blog/how-sonos-amplified-their-devex).

- **选择性重新生成**：仅更新特定页面，无需重建整个站点。这可显著缩短构建时间，[尤其适用于 Sonos 这类内容密集型网站](https://vercel.com/blog/how-sonos-amplified-their-devex)。

- **On-demand invalidation:** Trigger updates for specific pages as needed, such as when new content is published.

- **按需失效**：根据需要触发特定页面的更新，例如在发布新内容时。

- **Guaranteed cache durability:** Your data remains cached for the duration you specify. Only you or your team can invalidate this cache—unless it goes unaccessed for 31 days.

- **可靠的缓存持久性**：您的数据将按您指定的时长持续保留在缓存中。该缓存仅可由您或您的团队主动失效——除非连续 31 天未被访问。

ISR pairs best with [hybrid rendering frameworks](https://vercel.com/blog/isr-a-flexible-way-to-cache-dynamic-content#framework-adoption), which allow you to create apps with some content prerendered (SSG) and some content served per request (SSR).

ISR 与 [混合渲染框架](https://vercel.com/blog/isr-a-flexible-way-to-cache-dynamic-content#framework-adoption) 配合效果最佳，这类框架支持您构建部分预渲染（SSG）、部分按请求动态生成（SSR）的应用。

[**Too many acronyms?**\\
\\
Learn the differences between rendering strategies like SSG, SSR, CSR, ISR, and PPR—and see real-world examples of each.\\
\\
Read More](https://vercel.com/blog/how-to-choose-the-best-rendering-strategy-for-your-app)

[**缩写词太多？**\\
\\
了解 SSG、SSR、CSR、ISR 和 PPR 等不同渲染策略的区别，并查看每种策略的真实应用案例。\\
\\
了解更多](https://vercel.com/blog/how-to-choose-the-best-rendering-strategy-for-your-app)

### ISR and modern web architecture

### ISR 与现代 Web 架构

Caching requires careful configuration to work properly. Vercel's implementation of ISR uses [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure), meaning there's no extra configuration outside your framework code.

缓存需要经过仔细配置才能正常工作。Vercel 的增量静态再生（ISR）实现采用[框架定义的基础设施（Framework-Defined Infrastructure）](https://vercel.com/blog/framework-defined-infrastructure)，这意味着你无需在框架代码之外进行额外配置。

Also, Vercel's ISR cache scales automatically with your traffic. Its asynchronous, serverless nature means it can be used without worrying about downtime. In fact, the cache can help _prevent_ downtime by [taking the load off your backend services](https://vercel.com/blog/the-resiliency-of-the-frontend-cloud#high-availability-by-default) to begin with. This can also reduce the costs of calling third-party APIs, such as AI providers.

此外，Vercel 的 ISR 缓存会随你的流量自动扩容。其异步、无服务器（serverless）的特性意味着你可以放心使用，无需担忧服务中断。事实上，该缓存甚至能通过[分担后端服务负载](https://vercel.com/blog/the-resiliency-of-the-frontend-cloud#high-availability-by-default)来**主动防止**服务中断。这同时还能降低调用第三方 API（例如 AI 服务提供商）所产生的费用。

**ISR can act as a full replacement for** [**HTTP caching**](https://developer.mozilla.org/en-US/docs/Web/HTTP/Caching) **at the edge.** Instead of thinking about how to cache your application, you can focus on which pieces of your app would benefit from caching.

**ISR 可在边缘网络（Edge）完全替代**[**HTTP 缓存**](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Caching)**。** 你无需再纠结“如何缓存整个应用”，而可将精力集中于思考：应用中哪些部分最能从缓存中获益。

A visual walkthrough of ISR.

ISR 的可视化流程图解。

### How ISR fits in the caching stack

### ISR 在整体缓存架构中的定位

Vercel enhances caching strategies with several approaches:

Vercel 通过多种方式增强缓存策略：

- **Static Assets:** [Automatically cached on Vercel's CDN](https://vercel.com/docs/edge-network/caching), persisting across deployments if unchanged.

- **静态资源（Static Assets）：** [在 Vercel 的 CDN 上自动缓存](https://vercel.com/docs/edge-network/caching)，若内容未变更，则跨部署持续有效。

- **ISR:** Vercel's solution for caching dynamic content not requiring real-time updates, leveraging the Edge Network for [global low latency](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud).

- **增量静态再生（ISR）：** Vercel 针对**无需实时更新的动态内容**所提供的缓存方案，依托边缘网络（Edge Network）实现[全球范围内的低延迟访问](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud)。

- **Application-level:** For specific needs like storing frequently accessed data in memory (e.g., using Redis from the [Vercel Marketplace](https://vercel.com/marketplace?category=databases)).

- **应用层（Application-level）：** 满足特定需求，例如将高频访问的数据暂存于内存中（如通过 [Vercel Marketplace](https://vercel.com/marketplace?category=databases) 中提供的 Redis 服务）。

- **Client-side:** Recommended libraries like [SWR](https://swr.vercel.app/) optimize browser caching, minimizing network requests.

- **客户端（Client-side）：** 推荐使用 [SWR](https://swr.vercel.app/) 等库优化浏览器缓存，最大限度减少网络请求。

Combining these with ISR optimizes performance while maintaining up-to-date content.

将这些技术与 ISR 结合使用，可在确保内容实时更新的同时优化性能。

[**Ready to try ISR yourself?**  
**现在就亲自尝试 ISR 吧？**

This demo of on-demand ISR in Next.js shows you the basics by revalidating displayed GitHub issues from a webhook.  
这个 Next.js 按需 ISR 演示通过 Webhook 重新验证已展示的 GitHub Issues，向您介绍其基本用法。

Deploy Now](https://vercel.com/templates/next.js/on-demand-incremental-static-regeneration)  
立即部署](https://vercel.com/templates/next.js/on-demand-incremental-static-regeneration)

### Framework adoption

### 框架支持情况

Several popular frameworks currently support ISR:

目前，多个主流框架已支持 ISR：

- [Next.js](https://vercel.com/docs/frameworks/nextjs#incremental-static-regeneration)

- [SvelteKit](https://vercel.com/docs/frameworks/sveltekit#incremental-static-regeneration-isr)

- [Nuxt](https://vercel.com/blog/nuxt-on-vercel#static-and-isr-support-for-nuxt)

- [Astro](https://vercel.com/docs/frameworks/astro#incremental-static-regeneration)

- [Gatsby (through Deferred Static Generation)](https://vercel.com/docs/frameworks/gatsby#deferred-static-generation)

- [Remix (partial support via `Cache-Control` headers)](https://vercel.com/docs/frameworks/remix#cache-control-headers)

If you don't see ISR in your favorite framework and want it, consider creating or upvoting a GitHub issue. Framework authors can implement ISR using Vercel's [Build Output API](https://vercel.com/blog/build-your-own-web-framework).

如果您在最喜爱的框架中尚未看到 ISR 支持，且希望其加入，请考虑创建或为相关 GitHub Issue 投票。框架作者可通过 Vercel 的 [构建输出 API（Build Output API）](https://vercel.com/blog/build-your-own-web-framework) 实现 ISR。

## Real-world scenarios where ISR shines

## ISR 大放异彩的真实应用场景

> “我们不想对业务方说：‘嘿，您想修复首页上的那个错别字？即使所有内容都已审批通过，我们也得花上数小时才能上线。’因此，能够仅对部分内容进行增量式静态再生——尤其是当您的网站拥有 10,000 个页面时——是我们评估和选择平台时一项极为关键的考量因素。”  
> “我们不想对业务方说：‘嘿，您想修复首页上的那个错别字？即使所有内容都已审批通过，我们也得花上数小时才能上线。’因此，能够仅对部分内容进行增量式静态再生——尤其是当您的网站拥有 10,000 个页面时——是我们评估和选择平台时一项极为关键的考量因素。”  
>  
> ![](images/incremental-static-regeneration-isr-a-flexible-way-to-cache-dynamic-content-verc/img_001.png)  
>  
> **高级软件工程师**，强生公司（Johnson & Johnson）

### Ecommerce

### 电子商务

Ecommerce sites with large inventories benefit greatly from ISR. For instance, Mecum, an online retailer with millions of assets and hundreds of thousands of pages, [uses ISR to keep product information up-to-date without rebuilding the entire site](https://vercel.com/blog/managing-275-thousand-pages-and-8-million-assets-with-isr).

拥有海量商品库存的电商网站能从 ISR 中获益显著。例如，线上拍卖平台 Mecum 拥有数百万数字资产与数十万网页，[借助 ISR 在无需重建整个站点的前提下，持续保持商品信息的实时更新](https://vercel.com/blog/managing-275-thousand-pages-and-8-million-assets-with-isr)。

When product details change (e.g., price, quantity on hand), only the affected pages are regenerated and re-cached. This ensures customers always see the latest information while maintaining fast page loads.

当商品详情发生变化（例如价格、库存数量等），系统仅重新生成并缓存受影响的页面。这既确保用户始终看到最新信息，又维持了极快的页面加载速度。

Stripe was also able to use ISR (in combination with client-side caching and static site generation) to serve a viral Black Friday micro-site with [17 million edge requests at launch](https://vercel.com/blog/architecting-reliability-stripes-black-friday-site).

Stripe 同样结合 ISR、客户端缓存与静态站点生成（SSG），成功支撑了一个在“黑色星期五”期间爆火的微型活动站点——上线首日即处理了 [1700 万次边缘请求](https://vercel.com/blog/architecting-reliability-stripes-black-friday-site)。

### News websites

### 新闻网站

News sites with frequently updating content are ideal candidates for ISR. News outlets like [The Washington Post use ISR](https://vercel.com/blog/washington-post-next.js-vercel-engineering-at-the-speed-of-breaking-news) to serve breaking news quickly while efficiently managing server resources.

内容高频更新的新闻类网站是 ISR 的理想适用场景。《华盛顿邮报》（The Washington Post）等新闻机构 [采用 ISR 技术](https://vercel.com/blog/washington-post-next.js-vercel-engineering-at-the-speed-of-breaking-news)，在保障服务器资源高效利用的同时，极速发布突发新闻。

Hydrow [uses ISR to update its blog](https://vercel.com/blog/hydrow) every time a new article is published in their headless CMS. Users and authors always see the latest content, but the site only has to request data when a post updates.

Hydrow 公司 [借助 ISR 实现博客自动更新](https://vercel.com/blog/hydrow)：每当其无头 CMS（headless CMS）中发布一篇新文章，博客页面即被刷新。用户与作者始终能看到最新内容，而网站仅需在文章更新时才向后端请求数据。

### AI-powered applications

### AI 驱动的应用

Applications integrating AI can leverage ISR to optimize performance and costs. For example, a company using AI for product recommendations can cache the results of expensive AI computations with ISR.

集成 AI 的应用可借助增量静态再生（ISR）优化性能与成本。例如，一家利用 AI 提供商品推荐服务的公司，可通过 ISR 缓存高开销 AI 计算的结果。

The recommendations can be regenerated periodically or when the underlying data changes, ensuring users receive personalized content quickly without overloading the AI service or incurring unnecessary AI costs.

这些推荐结果可按固定周期重新生成，也可在底层数据发生变化时触发更新，从而确保用户能快速获取个性化内容，同时避免 AI 服务过载或产生不必要的 AI 调用成本。

Leonardo.ai uses ISR to cache recent user-generated content, allowing visitors to see the latest content without waiting on a loading skeleton. This has also helped them [drop build times from ten minutes to two](https://vercel.com/blog/leonardo-ai-performantly-generates-4-5-million-images-daily-with-next-js-and-vercel).

Leonardo.ai 利用 ISR 缓存近期用户生成的内容，使访客无需等待加载骨架屏即可即时查看最新内容。此举还帮助他们[将构建时间从十分钟缩短至两分钟](https://vercel.com/blog/leonardo-ai-performantly-generates-4-5-million-images-daily-with-next-js-and-vercel)。

## How to implement ISR

## 如何实现 ISR

ISR uses three invalidation techniques.

ISR 采用三种缓存失效（invalidation）机制。

### Time-based ISR

### 基于时间的 ISR

Time-based ISR regenerates pages at specified intervals. Use it when:

基于时间的 ISR 按预设时间间隔重新生成页面。适用于以下场景：

- On-demand regeneration would be too frequent

- 按需再生过于频繁

- Data sources lack webhook support

- 数据源不支持 Webhook

- Content changes follow a predictable pattern

- 内容更新遵循可预测的模式

For example, using [SvelteKit's implementation of ISR with the Vercel adapter](https://kit.svelte.dev/docs/adapter-vercel#incremental-static-regeneration), we could update a news homepage from a third-party API every 10 minutes:

例如，使用 [SvelteKit 结合 Vercel 适配器实现的增量静态再生（ISR）](https://kit.svelte.dev/docs/adapter-vercel#incremental-static-regeneration)，我们可以每 10 分钟通过第三方 API 更新一次新闻首页：

src/routes/+page.server.ts

src/routes/+page.server.ts

```jsx
import { error } from "@sveltejs/kit";

import type { PageServerLoad } from "./$types";



export const load: PageServerLoad = async () => {

5  try {

6    const res = await fetch("<https://api.news.com/headlines>");

7    const headlines: any = await res.json();
```

9    return {

9    返回 {

10      headlines,

10      headlines,

11      // Revalidate every 10 minutes

11      // 每 10 分钟重新验证一次

12      cache: { maxage: 600 },

12      cache: { maxage: 600 },

13    };

13    };

14  } catch (err) {

14  } catch (err) {

15    throw error(500, "Failed to fetch headlines");

15    throw error(500, "获取头条新闻失败");

16  }

16  }

17};

17};

In SvelteKit, we use a `+page.server.ts` file to handle server-side data fetching. The `load` function fetches and returns data, which will be available to the page component. The `cache` option sets the revalidation interval.

在 SvelteKit 中，我们使用 `+page.server.ts` 文件来处理服务端数据获取。`load` 函数负责获取并返回数据，这些数据将可供页面组件使用。`cache` 选项用于设置重新验证（revalidation）的时间间隔。

Be careful when using time-based ISR at too frequent an interval (60 seconds, for example). Although ISR can provide a needed buffer in severe traffic to help you save costs, revalidating _too_ often—writing to the cache almost as often as you're reading from it—can be cost-inefficient, and you may need to rethink your strategy.

请谨慎使用时间驱动型增量静态再生（ISR），尤其是当设定的刷新间隔过短时（例如 60 秒）。尽管 ISR 可在流量高峰期间提供必要的缓冲，从而帮助您节省成本，但若**过于频繁地重新验证**——即写入缓存的频率几乎与读取缓存的频率相当——反而会导致成本效益低下，此时您可能需要重新评估和调整您的缓存策略。

### On-demand ISR

### 按需 ISR（On-demand ISR）

On-demand ISR regenerates pages in response to specific events. It's preferred to time-based because it:

按需 ISR 会在特定事件触发时重新生成页面。相比时间驱动型 ISR，它具有以下优势：

- Provides the most up-to-date content  
  - 提供最新鲜的内容  

- Is more efficient, regenerating only when necessary  
  - 效率更高，仅在必要时才执行重新生成  

- Allows for immediate updates to changes  
  - 支持对内容变更进行即时更新  

For example, using [Astro's on-demand ISR implementation](https://docs.astro.build/en/guides/integrations-guide/vercel/#isr) you can revalidate an article page when you update the corresponding content in your CMS:

例如，借助 [Astro 的按需 ISR 实现](https://docs.astro.build/en/guides/integrations-guide/vercel/#isr)，当您在 CMS 中更新某篇文章的对应内容时，即可对该文章页面执行重新验证：

First, enable ISR in your Astro `astro.config.mjs`:

首先，在 Astro 项目的 `astro.config.mjs` 中启用 ISR：

astro.config.mjs

```jsx
import { defineConfig } from "astro/config";

import vercel from "@astrojs/vercel/serverless";



export default defineConfig({

5  output: "server",

6  adapter: vercel({

7    isr: {

8      // Create a secret token for revalidation

9      bypassToken: import.meta.env.VERCEL_REVALIDATE_TOKEN,

10    },
```

```jsx
import { defineConfig } from "astro/config";

import vercel from "@astrojs/vercel/serverless";



export default defineConfig({

5  output: "server",

6  adapter: vercel({

7    isr: {

8      // 为重新验证创建一个密钥令牌

9      bypassToken: import.meta.env.VERCEL_REVALIDATE_TOKEN,

10    },
```

11  }),

12});
```

然后，在您的文章获取逻辑所在的位置：

src/pages/posts/\[slug\].astro

```jsx
1---

2// ... your现有代码 ...


export const prerender = true;

5---
```

7{/* ... your page content ... */}
7{/* ……你的页面内容…… */}

```

Now, you can trigger revalidation by sending a `GET` or `HEAD` request to the page's URL with the **`x-prerender-revalidate`** header:

现在，你可以通过向页面 URL 发送带 **`x-prerender-revalidate`** 请求头的 `GET` 或 `HEAD` 请求来触发重新验证：

```bash
curl -H "x-prerender-revalidate: <YOUR_BYPASS_TOKEN>" https://your-site.com/posts/my-article-slug
```

```bash
curl -H "x-prerender-revalidate: <YOUR_BYPASS_TOKEN>" https://your-site.com/posts/my-article-slug
```

This will tell Vercel to revalidate the `/posts/my-article-slug` page, ensuring the next visitor sees the fresh content. You can trigger this request from a webhook in your CMS or any other part of your application.

这将通知 Vercel 对 `/posts/my-article-slug` 页面执行重新验证，确保下一位访问者看到的是最新内容。你可以在 CMS 的 Webhook 中，或应用程序的任意其他位置发起该请求。

### Tag-based ISR

### 基于标签的增量静态再生（Tag-based ISR）

Next.js supports [tag-based revalidation](https://nextjs.org/docs/app/building-your-application/data-fetching/incremental-static-regeneration#on-demand-revalidation-with-revalidatetag) for on-demand ISR. This allows you to invalidate multiple pages that share the same tag. Let's explore a real-world ecommerce example using a Server Component for a product page:

Next.js 支持 [基于标签的重新验证](https://nextjs.org/docs/app/building-your-application/data-fetching/incremental-static-regeneration#on-demand-revalidation-with-revalidatetag)，用于按需增量静态再生（ISR）。这使你能一次性使所有共享同一标签的多个页面失效。下面我们以电商场景为例，使用 Server Component 构建一个商品详情页：

app/products/\[id\]/page.tsx

`app/products/[id]/page.tsx`

```tsx
import { revalidateTag } from "next/cache";



async function getProduct(id) {
```

4  // ...（使用标签 [`product-${id}`, "product-list"] 的获取逻辑）

5}



export default async function ProductPage({ params: { id } }) {

8  const product = await getProduct(id);



10  async function addToCart(formData) {

11    const quantityToAdd = Number(formData.get("quantity"));

12    if (quantityToAdd > 0 && quantityToAdd <= product.quantity) {

13      await updateProductQuantity(id, product.quantity - quantityToAdd);

14      revalidateTag(`product-${id}`);

14      重新验证标签 `product-${id}`；

15      revalidateTag("product-list");

15      重新验证标签 "product-list"；

16      // ... (add to cart logic)

16      // ……（加入购物车逻辑）

17    }

17    }

18  }

18  }

20  return (

20  返回（

21    <div>

21    <div>

22      <h1>{product.name}</h1>

22      <h1>{product.name}</h1>

23      <p>Price: ${product.price}</p>

23      <p>价格：${product.price} 美元</p>

24      {product.quantity > 0 ? (

24      {product.quantity > 0 ? (

25        <form action={addToCart}>

25        <form action={addToCart}>

26          <input

26          <input

27            type="number"

27            type="number"

28            name="quantity"

28            name="quantity"

29            min="1"

29            min="1"

30            max={product.quantity}

30            max={product.quantity}

31            defaultValue="1"

31            defaultValue="1"

32          />

32          />

33          <button type="submit">Add to Cart</button>

33          <button type="submit">加入购物车</button>

34        </form>

34        </form>

35      ) : (

35      ) : (

36        <p>Out of Stock</p>

36        <p>缺货</p>

37      )}

37      )}

38    </div>

38    </div>

39  );

39  );

40}



40}



42// Server-side function to update quantity

42// 用于更新商品数量的服务器端函数

async function updateProductQuantity(id, newQuantity) {

44  "use server";

44  “use server”;

45  // ... (update database logic)

45  // ……（更新数据库逻辑）

46}
```

46}
```

This approach improves efficiency by allowing you to update related product pages simultaneously. When a product's inventory is updated:

该方法通过支持同时更新相关产品页面，提升了效率。当某款产品的库存发生变化时：

1. The specific product page is revalidated using the `product-${id}` tag.

1. 使用 `product-${id}` 标签对对应的具体产品页面进行重新验证。

2. All pages listing multiple products (e.g., homepage, category pages) are revalidated using the `product-list` tag.

2. 所有展示多个产品的页面（例如首页、分类页）均使用 `product-list` 标签进行重新验证。

This ensures that inventory changes are reflected across the site for all users.

此举确保所有用户在全站范围内都能即时看到库存变更。

## The future of ISR

## ISR 的未来

ISR has been around for a few years now, and we've made a lot of observations of how it could be improved.

ISR 面世已有数年，我们已积累大量关于其优化方向的观察与思考。

One of the most significant features currently in development is [Partial Prerendering (PPR)](https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model), which allows static and dynamic content to coexist at the component level. PPR can simplify the developer experience by reducing the number of concepts and rendering modes to consider.

当前正在开发的最重要特性之一是[部分预渲染（Partial Prerendering, PPR）](https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model)，它支持静态内容与动态内容在组件级别共存。PPR 能够通过减少开发者需掌握的概念数量和渲染模式种类，显著简化开发体验。

While [PPR is experimental](https://nextjs.org/docs/app/api-reference/next-config-js/ppr), it's an exciting step forward in building dynamic web applications.

虽然 [PPR 尚处于实验阶段](https://nextjs.org/docs/app/api-reference/next-config-js/ppr)，但它标志着构建动态 Web 应用迈出了令人振奋的一步。

## Takeaways

## 关键要点

ISR is a powerful hybrid caching strategy that offers improved performance, reduced server load, and better scalability for modern web applications. By implementing ISR, you can serve static-like content with dynamic data freshness, enhancing user experience and SEO.

ISR 是一种强大的混合缓存策略，可为现代 Web 应用带来更优的性能、更低的服务器负载以及更强的可扩展性。通过实施 ISR，您既能提供类似静态页面的快速响应，又能确保数据的动态实时性，从而提升用户体验与搜索引擎优化（SEO）效果。

To get started with ISR on Vercel, check out our [ISR template](https://vercel.com/templates/next.js/on-demand-incremental-static-regeneration) for a hands-on experience.

如需在 Vercel 上快速开始使用 ISR，请查看我们的 [ISR 模板](https://vercel.com/templates/next.js/on-demand-incremental-static-regeneration)，亲自动手实践。