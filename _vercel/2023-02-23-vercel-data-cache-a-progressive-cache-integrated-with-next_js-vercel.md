---
title: "Vercel Data Cache: A progressive cache, integrated with Next.js - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-cache-api-nextjs-cache"
date: "2023-02-23"
scraped_at: "2026-03-02T09:54:25.730752635+00:00"
language: "en-zh"
translated: true
description: "Cache only part of your page as static data, while fully dynamically rendering the rest of your application, including accessing real-time and personalized data."
---

Feb 23, 2023

2023 年 2 月 23 日

框架定义的、开箱即用的全局缓存基础设施。

在今天之前，开发者只能在完全静态页面与完全动态页面之间二选一。

借助 [Next.js 13.2](https://nextjs.org/13-2)，我们很高兴地宣布推出 **Next.js Cache（测试版）** 以及全新的 **Vercel Data Cache（测试版）**。该功能支持仅将页面中 _部分_ 内容以静态数据形式缓存，而其余部分则完全动态渲染——包括实时数据访问与个性化内容呈现。

**Vercel Data Cache**

- 专为任意前端或全栈框架设计，兼容性强

- 原生集成至 [Next.js Cache](https://vercel.com/blog/vercel-cache-api-nextjs-cache#how-the-next.js-cache-works)，自 Next.js 13.2 及 App Router 起即全面支持

- 支持基于标签（tag）的细粒度缓存失效机制

- 在静态渲染与动态渲染之间共享后端缓存

我们继承了增量式静态再生（ISR）的所有优势——快速构建与极速页面加载——并进一步将其精细化至数据获取层面。

[Try Next.js 13.2](https://nextjs.org/13-2) or continue reading to learn about how the Next.js Cache and Vercel Data Cache were created to evolve ISR.

[Try Next.js 13.2](https://nextjs.org/13-2)，或继续阅读，了解 Next.js Cache 与 Vercel Data Cache 是如何被设计出来以推动增量静态再生（ISR）进一步发展的。

## ) What is Incremental Static Regeneration (ISR)?

## ) 什么是增量静态再生（ISR）？

We released [Incremental Static Regeneration (ISR)](https://vercel.com/docs/concepts/incremental-static-regeneration/overview) in 2020 in [Next.js](https://nextjs.org/blog/next-9-4#incremental-static-regeneration-beta) and as part of the Vercel platform to help developers scale their static workloads to [millions of pages](https://vercel.com/customers/super-serves-thousands-of-domains-on-one-project-with-next-js-and-vercel).

我们于 2020 年在 [Next.js](https://nextjs.org/blog/next-9-4#incremental-static-regeneration-beta) 中推出 [增量静态再生（ISR）](https://vercel.com/docs/concepts/incremental-static-regeneration/overview)，并将其作为 Vercel 平台的一部分，助力开发者将静态工作负载扩展至 [数百万页面](https://vercel.com/customers/super-serves-thousands-of-domains-on-one-project-with-next-js-and-vercel)。

ISR allows you to create or update content _without_ redeploying your site. This enables better performance, improved security, and faster build times for developers:

ISR 允许你在 _无需重新部署网站_ 的前提下创建或更新内容。这为开发者带来了更优的性能、更强的安全性以及更快的构建速度：

- **Better Performance:** Static pages can be consistently fast by caching generated pages in every region on Vercel's [Edge Network](https://vercel.com/docs/concepts/edge-network/overview) and persisting files into durable storage

- **更优的性能：** 静态页面可通过在 Vercel [边缘网络（Edge Network）](https://vercel.com/docs/concepts/edge-network/overview) 的每个区域缓存已生成页面，并将文件持久化存储至高可靠性存储中，从而始终保持高速响应。

- **Faster Builds:** Pages can defer generation on request or through an API instead of during the build, helping keep build times fast as your application grows

- **更快的构建：** 页面可延迟至请求时或通过 API 触发生成，而非在构建阶段完成，从而在应用规模持续增长时仍能保持构建速度。

With SvelteKit, Nuxt, and Gatsby now supporting ISR, it’s easier than ever to speed up previously static-only workloads and start moving towards a dynamic-first model. However, we knew there were opportunities to improve the foundations of ISR we laid out three years ago.

如今，SvelteKit、Nuxt 和 Gatsby 均已支持 ISR，让原本仅支持静态渲染的工作负载加速变得前所未有的简单，也让我们得以更顺利地迈向“以动态为先（dynamic-first）”的开发范式。然而，我们也清楚地意识到：三年前所奠定的 ISR 基础，仍有诸多可优化的空间。

## The good, the bad, and the ugly of ISR

## ISR 的优势、缺陷与痛点

When we released ISR, the feedback from developers was clear: they _loved_ the speed boost that ISR provided, both in page performance and faster builds.

自 ISR 发布以来，开发者反馈非常明确：他们 _极其喜爱_ ISR 所带来的双重提速——既显著提升了页面加载性能，又大幅缩短了构建耗时。

The native integration with Next.js made it easy to opt into using ISR on a per-route basis, using `getStaticProps` to define a `revalidate` time in seconds, and using `getStaticPaths` to defer the generation of new pages on demand.

Next.js 原生集成的特性，使得按路由粒度启用 ISR 变得极为便捷：开发者只需在 `getStaticProps` 中定义以秒为单位的 `revalidate` 时长，并借助 `getStaticPaths` 实现新页面的按需生成。

pages/products/[id].js

pages/products/[id].js

```jsx
export async function getStaticProps() {

```jsx
export async function getStaticProps() {

2  let product = await getProduct()

2  let product = await getProduct()

4  return {

4  return {

5    props: { product },

5    props: { product },

6    // Next.js will attempt to re-generate the page:

6    // Next.js 将尝试重新生成该页面：

7    // - When a request comes in

7    // - 当有请求到达时

8    // - At most once every 10 seconds

8    // - 最多每 10 秒一次

9    revalidate: 10, // In seconds

9    revalidate: 10, // 单位：秒

10  }

10  }

11}

11}

13// Generates `/products/1` and `/products/2`

13// 生成 `/products/1` 和 `/products/2`

export async function getStaticPaths() {

export async function getStaticPaths() {

15  // The developer has full flexibility to control

15  // 开发者拥有完全的灵活性来控制

16  // what pages are generated during the build or on-demand

16  // 在构建期间或按需生成哪些页面

17  // For example, you could only generate the top products

17  // 例如，你可能仅生成最热门的商品页面

18  // const topProducts = await getTopProducts()

18  // const topProducts = await getTopProducts()

19  return {

19  return {

20    paths: [{ params: { id: '1' } }, { params: { id: '2' } }],

20    路径：[{ params: { id: '1' } }, { params: { id: '2' } } }],

21    fallback: 'blocking', // generate new product pages on-demand

21    fallback: 'blocking', // 按需生成新的商品页面

22  }

22  }

23}
23}

```

Using ISR inside of the Next.js pages directory.

```
在 Next.js 的 `pages` 目录中使用增量静态再生（ISR）。

However, developers wanted further flexibility. How could you programmatically invalidate a specific route that had been previously statically generated?

然而，开发者希望获得更高的灵活性：如何以编程方式使某个先前已静态生成的路由失效？

With Next.js 12.1, and the corresponding [global Edge infrastructure](https://vercel.com/blog/behind-the-scenes-of-vercels-infrastructure) on Vercel, we released [on-demand ISR](https://on-demand-isr.vercel.app/). This allowed developers to easily update their content [globally in 300ms](https://vercel.com/changelog/faster-and-more-reliable-global-propagation).

借助 Next.js 12.1 版本，以及 Vercel 上配套的[全球边缘基础设施](https://vercel.com/blog/behind-the-scenes-of-vercels-infrastructure)，我们推出了[按需增量静态再生（on-demand ISR）](https://on-demand-isr.vercel.app/)。这使得开发者能够轻松地在[全球范围内 300 毫秒内](https://vercel.com/changelog/faster-and-more-reliable-global-propagation)更新其内容。

pages/products/\[id\].js

`pages/products/[id].js`

```jsx
export async function getStaticProps() {

```jsx
export async function getStaticProps() {

2  let product = await getProduct()

2  let product = await getProduct()

4  return {

4  返回 {

5    props: { product },

5    props: { product },

6    // `revalidate` is no longer needed, content is only updated

6    // `revalidate` 已不再需要，内容仅在通过 API 编程方式使缓存失效时更新

7    // when programmatically invalidated through the API

7    // when programmatically invalidated through the API

8    // revalidate: 10

8    // revalidate: 10

9  }

9  }

10}

10}

```

```

Using revalidate is not necessary when programmatically updating content.

在通过编程方式更新内容时，无需使用 `revalidate`。

pages/api/revalidate.js

pages/api/revalidate.js

```jsx
export default async function handler(req, res) {

2  // ...

3  await res.revalidate('/products/1');

4  // ...

5}
```

```jsx
export default async function handler(req, res) {

2  // ...

3  await res.revalidate('/products/1');

4  // ...

5}
```

An API Route that uses On-Demand ISR.

使用按需增量静态再生（On-Demand ISR）的 API 路由。

This was a major improvement, but still left room for further iteration.

这是一项重大改进，但仍为后续迭代留下了空间。

- What if I wanted to invalidate just a specific component instead of the entire route?

- 如果我想使某个特定组件失效，而非整个路由，该怎么办？

- What if I wanted to re-use the cache across deployments?

- 如果我想在不同部署间复用缓存，该怎么办？

- What if I wanted to change how the cache was keyed?

- 如果我想更改缓存的键生成方式，该怎么办？

- What if parts of my page required dynamic code like user personalization?

- 如果我的页面中某些部分需要动态代码（例如用户个性化）怎么办？

Developers wanted _dynamic_ at the speed of static.

开发者希望以静态网站的速度实现 _动态_ 功能。

## The new App Router, designed for incremental adoption

## 新的 App Router，专为渐进式采用而设计

With [Next.js 13](https://nextjs.org/blog/next-13), we released the foundation for the [App Router](https://beta.nextjs.org/docs) – a new routing, rendering, and data-fetching engine for Next.js – built on the latest React innovations. The best part? The App Router is designed for incremental adoption, meaning you can update to Next.js 13 and continue using `pages` without any major changes.

在 [Next.js 13](https://nextjs.org/blog/next-13) 发布后的过去六个月里，我们发布了 [App Router](https://beta.nextjs.org/docs) 的基础架构——这是一个基于最新 React 创新技术构建的、面向 Next.js 的全新路由、渲染与数据获取引擎。最棒的是？App Router 专为渐进式采用而设计，这意味着你可以直接升级到 Next.js 13，同时继续使用 `pages` 目录，无需进行任何重大改动。

In the past six months since Next.js 13 has been released, we’ve been working hard to build new primitives on top of the App Router foundations. One of these major improvements is around how developers fetch, cache, and invalidate data.

自 Next.js 13 发布以来的过去六个月中，我们在 App Router 基础之上持续构建新的核心能力。其中一项重大改进，正是围绕开发者如何获取、缓存与失效数据展开。

## Improved data fetching with React Server Components

## 借助 React Server Components 实现更优的数据获取

We started by deeply integrating the Next.js App Router with React features like [Server Components](https://beta.nextjs.org/docs/rendering/server-and-client-components), [Suspense](https://beta.nextjs.org/docs/data-fetching/streaming-and-suspense), and [Transitions](https://beta.reactjs.org/reference/react/useTransition).

我们首先将 Next.js App Router 深度集成至 React 的多项特性之中，例如 [Server Components（服务端组件）](https://beta.nextjs.org/docs/rendering/server-and-client-components)、[Suspense（悬念）](https://beta.nextjs.org/docs/data-fetching/streaming-and-suspense) 和 [Transitions（过渡）](https://beta.reactjs.org/reference/react/useTransition)。

Rather than using Next-specific APIs like `getStaticProps` or `getServerSideProps`, you can now use familiar `async` / `await` to fetch data inside pages, layouts, or any Server Component.

你不再需要使用 Next.js 特有的 API（例如 `getStaticProps` 或 `getServerSideProps`），而是可以直接在页面（page）、布局（layout）或任意服务端组件中，使用熟悉的 `async` / `await` 语法来获取数据。

app/page.jsx

```jsx
export default async function Page() {

2  let notes = await db.query('select * from notes');

2  let notes = await db.query('select * from notes');

3  return (

3  return (

4    <ul>

4    <ul>

5      {notes.map((note) => (

5      {notes.map((note) => (

6        <li key={note.id}>{note.body}</li>

6        <li key={note.id}>{note.body}</li>

7      ))}

7      ))}

8    </ul>

8    </ul>

9  );

9  );

10}
```

10}
```

With React Server Components, you can fetch data directly inside of your components.

借助 React 服务端组件（React Server Components），你可以在组件内部直接获取数据。

[This](https://twitter.com/dan_abramov/status/1341217154566402050) allows you to use the Web `fetch` API to easily retrieve data in the `app` directory, as any `Promise` can be used to retrieve data:

[此链接](https://twitter.com/dan_abramov/status/1341217154566402050) 允许你直接在 `app` 目录中使用 Web 原生 `fetch` API 轻松获取数据，因为任意 `Promise` 均可用于数据获取：

app/page.js

```jsx
export default async function Page() {

2  const [staticData, dynamicData, revalidatedData] = await Promise.all([\
\
3    // Cached until manually invalidated\
\
4    fetch(`https://...`),\
\
5    // Refetched on every request\
\
6    fetch(`https://...`, { cache: 'no-store' }),\
\
7    // Cached with a lifetime of 10 seconds\
\
8    fetch(`https://...`, { next: { revalidate: 10 } }),\
\
9  ]);



11  return <div>...</div>;

12}
```

app/page.js

```jsx
export default async function Page() {

2  const [staticData, dynamicData, revalidatedData] = await Promise.all([\
\
3    // 缓存直至被手动失效\
\
4    fetch(`https://...`),\
\
5    // 每次请求均重新获取\
\
6    fetch(`https://...`, { cache: 'no-store' }),\
\
7    // 缓存有效期为 10 秒\
\
8    fetch(`https://...`, { next: { revalidate: 10 } }),\
\
9  ]);



11  return <div>...</div>;

12}
```

The data fetching API inside of the App Router has been simplified.

App Router 内的数据获取 API 已大幅简化。

By default, `fetch` will automatically fetch and [cache data](https://beta.nextjs.org/docs/data-fetching/caching). Similar to the Service Worker API, which extends the Fetch API by intercepting and handling network requests, the Next.js Cache extends the `fetch` options object to allow each request to provide its own [caching and revalidating](https://beta.nextjs.org/docs/data-fetching/caching).

默认情况下，`fetch` 将自动发起请求并[缓存数据](https://beta.nextjs.org/docs/data-fetching/caching)。与 Service Worker API（通过拦截和处理网络请求来扩展 Fetch API）类似，Next.js Cache 扩展了 `fetch` 的 options 对象，使每个请求均可自行指定其[缓存策略与重新验证机制](https://beta.nextjs.org/docs/data-fetching/caching)。

This new server-first programming model and React architecture mean that data fetching can be colocated with any Server Component. This enabled us to build the next generation of ISR: a [progressive, durable cache](https://vercel.com/blog/vercel-cache-api-nextjs-cache#how-the-next.js-cache-works) that’s granular at the data fetching level.

这一全新的“服务端优先”编程模型与 React 架构，意味着数据获取逻辑可与任意 Server Component 紧密共置（colocated）。这使我们得以构建下一代增量静态再生（ISR）：一种[渐进式、持久化的缓存](https://vercel.com/blog/vercel-cache-api-nextjs-cache#how-the-next.js-cache-works)，其粒度精细至数据获取层面。

## The Next Generation of ISR: Next.js Cache

## 下一代 ISR：Next.js 缓存

With the foundation of React Server Components and colocated data fetching in the Next.js App Router, you can now encapsulate static or dynamic data alongside the components that consume them.

借助 Next.js App Router 中 React Server Components 和同址数据获取（colocated data fetching）的基础能力，你现在可以将静态或动态数据与其所消费的组件一同封装。

This is the next generation of Incremental Static Regeneration (ISR) and caching in Next.js.

这正是 Next.js 中增量静态再生（ISR）与缓存机制的下一代演进。

app/page.tsx

app/page.tsx

```jsx
async function Tweet({ id }) {

async function Tweet({ id }) {

2  // Tweets are static unless programmatically revalidated

2  // 推文默认为静态内容，除非通过编程方式显式重新验证

3  let tweet = await fetch(`https://.../${id}`).then(res => res.json());

3  let tweet = await fetch(`https://.../${id}`).then(res => res.json());

4  return (

4  return (

5    <div>

5    <div>

6      <p>{tweet.author}</p>

6      <p>{tweet.author}</p>
```

7    </div>

8  );

9}



async function Categories() {

12  // Fetch the latest categories at most every 60 seconds

12  // 最多每 60 秒获取一次最新分类列表

13  let trendingCategories = await fetch('https://...', {

14    next: { revalidate: 60 },

15  }.then(res => res.json());

16  return (

17    <ul>

17    <ul>

18      {trendingCategories.map((category) => (

18      {trendingCategories.map((category) => (

19        <li key={category.id}>{category.name}</li>

19        <li key={category.id}>{category.name}</li>

20      ))}

20      ))}

21    </ul>

21    </ul>

22  );

22  );

23}
```

23}
```

You can revalidate a single fetch at most every 60 seconds.

单次数据获取（fetch）最多每 60 秒可重新验证一次。

## How the Next.js Cache Works

## Next.js 缓存机制原理

Next.js on Vercel gives you [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure). You write application code, like component-level data fetching with `fetch`, and we scaffold globally distributed infrastructure for you with no additional effort.

Vercel 上的 Next.js 为您提供 [框架定义的基础设施（framework-defined infrastructure）](https://vercel.com/blog/framework-defined-infrastructure)。您只需编写应用代码（例如使用 `fetch` 在组件级别获取数据），我们便会为您自动构建一套全球分布式基础设施，全程无需额外操作。

Regardless of where you are deploying, sensitive data that Next.js can infer (such as `Authorization` headers) are _not_ cached by default. However, any request can still opt into caching and override these defaults. We recommend adding the appropriate headers to sensitive requests to ensure data is never accidentally cached.

无论您在何处部署，Next.js 能够推断出的敏感数据（例如 `Authorization` 请求头）默认情况下 _不会_ 被缓存。但任何请求仍可主动选择启用缓存，并覆盖这些默认行为。我们建议为敏感请求添加适当的响应头，以确保数据绝不会被意外缓存。

### Next.js Cache with the Vercel Data Cache

### Next.js 缓存与 Vercel 数据缓存

The new Next.js Cache makes changing code independent from changing data. This can drastically speed up the redeployment of static pages since the page generation can use the existing cache.

全新的 Next.js 缓存机制使代码变更与数据变更相互解耦。由于页面生成过程可复用现有缓存，静态页面的重新部署速度可显著提升。

For pages that are _entirely static_, ISR works the same way as today:

对于 _完全静态_ 的页面，增量静态再生（ISR）的工作方式与当前一致：

- Generated pages are cached in every Vercel region. In the case of a cache `MISS`, it looks up the value in a single, global bucket. This means ISR has “cache shielding” built-in automatically, which helps improve the cache `HIT` ratio, making your application faster for visitors everywhere in the world.

- 生成的页面会在每个 Vercel 区域中被缓存。当发生缓存 `MISS` 时，系统会从一个统一的全局存储桶中查找对应值。这意味着 ISR 自动具备“缓存防护”（cache shielding）能力，有助于提升缓存 `HIT` 率，从而让全球各地的访问者都能获得更快的应用体验。

- Generated pages are also persisted in durable storage, enabling [instant rollbacks](https://vercel.com/docs/concepts/deployments/instant-rollback) without losing your previously cached entries.

- 生成的页面还会持久化保存至高可靠性存储中，支持 [即时回滚](https://vercel.com/docs/concepts/deployments/instant-rollback)，且不会丢失此前已缓存的条目。

- When content is updated, the Vercel Cache API is called and all regions globally are brought up to date with the newest content within 300ms.

- 当内容更新时，Vercel 缓存 API 将被调用，所有全球区域均将在 300 毫秒内同步至最新内容。

For pages that have more _granular_ data fetching, mixing static and dynamic, the Next.js Cache on Vercel (using the Vercel Data Cache) uses a more granular, ephemeral cache close to the visitor. A revalidation will cause entries in each region to be marked stale. The subsequent fetch will use the stale entry and trigger a background fetch to the origin to set the updated value in the cache.

对于需进行更 _细粒度_ 数据获取、同时混合静态与动态内容的页面，Vercel 上的 Next.js 缓存（基于 Vercel 数据缓存）将采用一种更精细、临时性更强的缓存策略，该缓存更靠近终端用户。一次重新验证（revalidation）操作会使各区域中的对应缓存条目标记为过期（stale）。随后的请求将先使用该过期条目，并在后台异步向源站发起请求，以获取新数据并更新缓存。

### Self-Hosted Next.js

### 自托管的 Next.js

The Next.js Cache also works fully self-hosted. When self-hosting, an LRU cache is used, which defaults to 50 MB (which can be increased). All entries in the cache are automatically written to disk by default. This filesystem cache can be shared between nodes if they have the same cache key, similar to [how ISR works today](https://nextjs.org/docs/basic-features/data-fetching/incremental-static-regeneration#self-hosting-isr).

Next.js 缓存同样完整支持自托管模式。在自托管场景下，系统默认采用 LRU 缓存策略，初始容量为 50 MB（该值可手动调高）。缓存中的所有条目默认自动写入磁盘。若多个节点使用相同的缓存键（cache key），则该基于文件系统的缓存可在节点间共享，其工作机制与 [当前 ISR 的自托管方式](https://nextjs.org/docs/basic-features/data-fetching/incremental-static-regeneration#self-hosting-isr) 类似。

For developers looking to further customize and modify the core of the Next.js Cache, they can modify underlying cache keys and change how and where cache entries are persisted, including disabling persistence entirely.

对于希望进一步定制和修改 Next.js 缓存核心功能的开发者，他们可以调整底层缓存键（cache keys），并更改缓存条目的存储方式与位置，甚至可完全禁用持久化存储。

## Revalidating components with cache tags

## 使用缓存标签（Cache Tags）重新验证组件

With Next.js 13.2, the core of the Next.js Cache has been released and is ready for experimentation today (in beta).

随着 Next.js 13.2 的发布，Next.js 缓存的核心功能已正式推出，现即可投入实验性使用（处于 Beta 阶段）。

Next up, we plan to implement programmatic updates to specific [paths](https://nextjs.org/docs/app/api-reference/functions/revalidatePath) or [cache tags](https://nextjs.org/docs/app/api-reference/functions/revalidateTag).

接下来，我们计划实现对特定 [路径](https://nextjs.org/docs/app/api-reference/functions/revalidatePath) 或 [缓存标签](https://nextjs.org/docs/app/api-reference/functions/revalidateTag) 的编程式更新。

```javascript
revalidatePath(`/posts/[slug]`);

revalidateTag(`post-${id}`);
```

```javascript
revalidatePath(`/posts/[slug]`);

revalidateTag(`post-${id}`);
```

An upcoming API for allowing revalidation of content by tag.

一个即将推出的、支持按标签（tag）触发内容重新验证的 API。

Cache tags can be added to specific `fetch` requests, enabling you to have more granular revalidation of content (potentially across multiple different paths).

缓存标签可添加至特定的 `fetch` 请求中，使您能够对内容执行更精细的重新验证（该操作可能跨越多个不同路径）。

```jsx
fetch(url, { next: { tags: [...] } });
```

```jsx
fetch(url, { next: { tags: [...] } });
```

Cache tags can be added to the fetch request.

可在 `fetch` 请求中添加缓存标签。

## Getting started with the Next.js Cache

## 开始使用 Next.js 缓存

The future is dynamic at the speed of static. While the Next.js Cache is available in beta today with 13.2, we are actively working on further improvements revalidating by cache tag and more generalized usage of the Vercel Data Cache.

未来已来：动态性能，静态速度。Next.js 缓存目前已随 Next.js 13.2 进入 Beta 阶段；我们正积极优化其功能，包括基于缓存标签（cache tag）的重新验证机制，以及 Vercel 数据缓存（Vercel Data Cache）更通用化的使用方式。

As we move towards stability for the Next.js Cache and general availability for the Vercel Data Cache, you will be able to pay for expanded storage and larger cache sizes on Vercel. The max item size for the Vercel Data Cache is 1 MB during the beta period.

随着 Next.js 缓存逐步走向稳定、Vercel 数据缓存迈向正式发布（General Availability），您将可在 Vercel 平台上付费升级存储容量与缓存大小。在 Beta 阶段，Vercel 数据缓存的单个缓存项最大尺寸为 1 MB。

The Next.js Cache is opt-in and only used when static and dynamic workloads are used on the same route. Otherwise, the current page-level ISR continues the work the same as today.

Next.js 缓存为按需启用（opt-in）机制，仅当同一路由中同时存在静态与动态工作负载时才会启用；否则，当前基于页面级别的增量静态再生（ISR）机制将继续按现有方式运行。

Learn more about [Next.js 13.2](https://nextjs.org/13-2) or [deploy your first Next.js application today](https://vercel.com/templates/next.js).

了解更多关于 [Next.js 13.2](https://nextjs.org/13-2) 的信息，或 [立即部署您的首个 Next.js 应用](https://vercel.com/templates/next.js)。

Vercel.com landing page

Vercel.com 官网落地页

Twitter post

Twitter 帖子

### Next.js 13.2

### Next.js 13.2

![Vercel's avatar](images/vercel-data-cache-a-progressive-cache-integrated-with-next_js-vercel/img_001.jpg)Vercel@vercel