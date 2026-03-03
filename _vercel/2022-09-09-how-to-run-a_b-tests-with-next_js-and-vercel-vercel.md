---
title: "How to run A/B tests with Next.js and Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/ab-testing-with-nextjs-and-vercel"
date: "2022-09-09"
scraped_at: "2026-03-02T10:00:43.940552523+00:00"
language: "en-zh"
translated: true
description: "Learn how to run A/B tests with Next.js and Vercel Edge Middleware."
---

Sep 9, 2022

2022 年 9 月 9 日

Running A/B tests is hard.

A/B 测试很难开展。

We all know how important it is for our business–it helps us understand how users are interacting with our products in the real world.

我们都知道 A/B 测试对业务至关重要——它能帮助我们了解用户在真实场景中如何与我们的产品进行交互。

However, a lot of the A/B testing solutions are done on the client side, which introduces [layout shift](https://vercel.com/blog/core-web-vitals#cumulative-layout-shift) as variants are dynamically injected after the initial page load. This negatively impacts your websites performance and creates a subpar user experience.

然而，许多 A/B 测试方案是在客户端实现的，当变体（variants）在初始页面加载后被动态注入时，就会引发 [布局偏移（layout shift）](https://vercel.com/blog/core-web-vitals#cumulative-layout-shift)。这会严重损害网站性能，并导致用户体验下降。

To get the best of both worlds, we built [Edge Middleware](https://vercel.com/features/edge-functions): code that runs _before_ serving requests from the edge cache. This enables developers to perform rewrites at the edge to show different variants of the same page to different users.

为了兼顾性能与灵活性，我们推出了 [Edge Middleware（边缘中间件）](https://vercel.com/features/edge-functions)：一段在从边缘缓存（edge cache）响应请求**之前**即运行的代码。这使得开发者可在边缘节点执行重写（rewrites），从而向不同用户展示同一页面的不同版本（变体）。

Today, we'll take a look at a real-world example of how we used Edge Middleware to A/B test our new Templates page.

今天，我们将通过一个真实案例，介绍我们如何利用 Edge Middleware 对新版“模板（Templates）”页面开展 A/B 测试。

## Redesigning the Template Marketplace

## 重构模板市场（Template Marketplace）

Earlier this year, we kickstarted the redesign of our [Templates page](https://vercel.com/templates).

今年早些时候，我们启动了 [模板页面（Templates page）](https://vercel.com/templates) 的重构工作。

Our old Templates page had a limited scope that focused mainly on the different [frameworks](https://github.com/vercel/vercel/tree/main/examples) that were supported on Vercel:

我们旧版的模板页面覆盖范围有限，主要聚焦于 Vercel 所支持的各类 [框架（frameworks）](https://github.com/vercel/vercel/tree/main/examples)：

![Old version: limited selection of templates that focused mainly on framework starters.](images/how-to-run-a_b-tests-with-next_js-and-vercel-vercel/img_001.jpg)![Old version: limited selection of templates that focused mainly on framework starters.](images/how-to-run-a_b-tests-with-next_js-and-vercel-vercel/img_002.jpg)  
![旧版：模板选择有限，主要围绕各类框架的入门模板。](images/how-to-run-a_b-tests-with-next_js-and-vercel-vercel/img_001.jpg)![旧版：模板选择有限，主要围绕各类框架的入门模板。](images/how-to-run-a_b-tests-with-next_js-and-vercel-vercel/img_002.jpg)  
Old version: limited selection of templates that focused mainly on framework starters.  
旧版：模板选择有限，主要围绕各类框架的入门模板。

For the new version, we wanted to build a marketplace to showcase all the different types of applications that can be built on Vercel – blogs, e-commerce storefronts, etc.

在新版本中，我们希望构建一个应用市场，以展示所有可在 Vercel 上构建的不同类型的应用——例如博客、电商 storefront（商品展示页）等。

We also improved search to allow for partial matching of search terms and added category filters to make discovering new templates much easier:

我们还优化了搜索功能，支持搜索词的模糊匹配，并新增了分类筛选器，使用户更轻松地发现新模板：

![New version: wider selection of templates with fuzzy search & filters.](images/how-to-run-a_b-tests-with-next_js-and-vercel-vercel/img_003.jpg)![New version: wider selection of templates with fuzzy search & filters.](images/how-to-run-a_b-tests-with-next_js-and-vercel-vercel/img_004.jpg)新版本：支持模糊搜索与分类筛选，模板选择范围更广。

Since this was a major change of one of our most popular pages, we decided to break down the launch into multiple release phases:

由于这是对我们最受欢迎页面之一的重大改版，我们决定将上线过程划分为多个发布阶段：

1. **Early Access**: Only 20% of visitors to `/templates` will see the new variant.

1. **早期访问（Early Access）**：仅 20% 访问 `/templates` 页面的用户将看到新版本。

2. **Public Beta**: An equal 50:50 split between the new and old variant.

2. **公开测试版（Public Beta）**：新旧版本各面向 50% 的用户开放，实现均等分流。

3. **General Availability**: Public launch–everyone gets the new variant.

3. **正式发布（General Availability）**：全面上线——所有用户都将使用新版本。

![We used Vercel's Edge Middleware to stagger our launch into 3 phases.](images/how-to-run-a_b-tests-with-next_js-and-vercel-vercel/img_005.jpg)![We used Vercel's Edge Middleware to stagger our launch into 3 phases.](images/how-to-run-a_b-tests-with-next_js-and-vercel-vercel/img_006.jpg)我们使用 Vercel 的 Edge Middleware 将本次上线分三阶段逐步推进。

We leveraged [Edge Middleware](https://vercel.com/blog/vercel-edge-middleware-dynamic-at-the-speed-of-static) to perform the A/B test at the edge, which allowed us to gather insightful user feedback without sacrificing performance.

我们借助 [Edge Middleware](https://vercel.com/blog/vercel-edge-middleware-dynamic-at-the-speed-of-static) 在边缘网络层执行 A/B 测试，既高效收集了富有价值的用户反馈，又未对性能造成任何影响。

## Catch-all Routes & On-demand Revalidation

## 全匹配路由（Catch-all Routes）与按需重新验证（On-demand Revalidation）

Since we were using Next.js, we decided to create the new templates marketplace using the following [optional catch-all route](https://nextjs.org/docs/routing/dynamic-routes#optional-catch-all-routes): `/templates/[[...slug]].tsx`.

由于我们使用的是 Next.js，因此决定采用以下[可选的捕获全部路由（optional catch-all route）](https://nextjs.org/docs/routing/dynamic-routes#optional-catch-all-routes)来构建新的模板市场：`/templates/[[...slug]].tsx`。

This allowed us to programmatically generate new static pages when new templates are added using [On-Demand Incremental Static Regeneration (ISR)](https://nextjs.org/docs/basic-features/data-fetching/incremental-static-regeneration#on-demand-revalidation) and navigate between them using [shallow-routing](https://nextjs.org/docs/routing/shallow-routing).

这使我们能够借助[按需增量静态再生（On-Demand Incremental Static Regeneration, ISR）](https://nextjs.org/docs/basic-features/data-fetching/incremental-static-regeneration#on-demand-revalidation)在新增模板时动态生成新的静态页面，并通过[浅层路由（shallow routing）](https://nextjs.org/docs/routing/shallow-routing)在这些页面之间导航。

Here are some examples:

以下是一些示例：

- [/templates/next.js/nextjs-boilerplate](https://vercel.com/templates/next.js/nextjs-boilerplate): Next.js boilerplate template

- [`/templates/next.js/nextjs-boilerplate`](https://vercel.com/templates/next.js/nextjs-boilerplate)：Next.js 脚手架模板

- [/templates/svelte/sveltekit-boilerplate](https://vercel.com/templates/svelte/sveltekit-boilerplate): SvelteKit boilerplate template

- [`/templates/svelte/sveltekit-boilerplate`](https://vercel.com/templates/svelte/sveltekit-boilerplate)：SvelteKit 脚手架模板

We also generated dynamic landing pages for each filter option to capture long-tail SEO traffic:

我们还为每个筛选选项动态生成了专属落地页，以捕获长尾 SEO 流量：

- [/templates/next.js](https://vercel.com/templates/next.js): [Next.js](https://nextjs.org/) templates

- [`/templates/next.js`](https://vercel.com/templates/next.js)：[Next.js](https://nextjs.org/) 模板

- [/templates/blog](https://vercel.com/templates/blog): Blog templates

- [`/templates/blog`](https://vercel.com/templates/blog)：博客模板

- [/templates/tailwind](https://vercel.com/templates/tailwind): Templates that use [Tailwind CSS](https://tailwindcss.com/)

- [`/templates/tailwind`](https://vercel.com/templates/tailwind)：使用 [Tailwind CSS](https://tailwindcss.com/) 的模板

We then moved the old templates marketplace to the `/templates-old.tsx` route.

随后，我们将旧版模板市场迁移至 `/templates-old.tsx` 路由。

## Experimenting at the Edge

## 在边缘端进行实验

To perform the A/B test, we created a `middleware.ts` file with the following code:

为执行 A/B 测试，我们创建了一个包含以下代码的 `middleware.ts` 文件：

middleware.ts

middleware.ts

```javascript
import { type NextRequest, NextResponse } from 'next/server';



3// make sure the middleware only runs when

3// 确保中间件仅在满足以下条件时运行：

4// the requested url starts with `/templates`

4// 请求的 URL 以 `/templates` 开头时才运行。

export const config = {

6  matcher: ['/templates(.*)'],

7};
```

```ts
const THRESHOLD = 0.2; // initial threshold for the new variant (20%)

const THRESHOLD = 0.2; // 新变体的初始阈值（20%）

const COOKIE_NAME = 'tm_var'; // name of the cookie to store the variant

const COOKIE_NAME = 'tm_var'; // 用于存储变体信息的 Cookie 名称

export function middleware(req: NextRequest) {

export function middleware(req: NextRequest) {

13  // get the variant from the cookie

13  // 从 Cookie 中获取变体

14  // if not found, randomly set a variant based on threshold

14  // 若未找到，则根据阈值随机设定一个变体

15  const variant =

15  const variant =

16    req.cookies.get(COOKIE_NAME) || (Math.random() < THRESHOLD ? 'new' : 'old');

16    req.cookies.get(COOKIE_NAME) || (Math.random() < THRESHOLD ? 'new' : 'old');
```

18  const url = req.nextUrl.clone();

18  const url = req.nextUrl.clone();

20  // if it's the old variant, rewrite to the old templates marketplace

20  // 如果是旧版本，则重写为旧模板市场页面

21  if (variant === 'old') {

21  if (variant === 'old') {

22    url.pathname = '/templates-old';

22    url.pathname = '/templates-old';

23  }

23  }

25  const res = NextResponse.rewrite(url);

25  const res = NextResponse.rewrite(url);

27  // set the variant in the cookie if not already set

27  // 如果 Cookie 中尚未设置该版本标识，则将其写入 Cookie

28  if (!req.cookies.get(COOKIE_NAME)) {

29    res.cookies.set(COOKIE_NAME, variant);

30  }

31  return res;

32}
```

在边缘执行 A/B 测试的中间件代码。

以下是该中间件执行步骤的详细说明：

1. 根据当前阈值（第一阶段为 `0.2`），为每位首次访问 `/templates` 页面的访客打上 `old` 或 `new` 变体标签；

2. 若用户属于 `old` 变体，则将请求重写至 `/templates-old.tsx` 路由；

3. 将用户的变体标识保存至 `tm_var` Cookie 中，以确保该用户在后续访问时始终获得同一版本的内容。

## Avoiding layout shift with Edge Middleware

## 使用 Edge Middleware 避免布局偏移

As we developed the new templates page, we ran into an interesting problem–data fetching had to be done on the client side for three reasons:

在开发新模板页面的过程中，我们遇到了一个有趣的问题：数据获取必须在客户端进行，原因有三：

1. We were using query parameters to preserve the filter state  
1. 我们使用查询参数（query parameters）来保持筛选器状态  

2. The pages were generated statically  
2. 这些页面是静态生成的  

3. You can't read query parameters inside `getStaticProps`  
3. 你无法在 `getStaticProps` 中读取查询参数  

To avoid layout shift, we decided to use skeleton loaders to buffer the loading state before showing the templates that match the configured filters.

为避免布局偏移（layout shift），我们决定采用骨架加载器（skeleton loaders），在显示匹配所配置筛选条件的模板之前，先缓冲加载状态。

For instance, if you go to [vercel.com/templates?framework=svelte](https://vercel.com/templates?framework=svelte), you first receive a set of skeleton loaders while the data is fetched on the client side, and then the list of Svelte templates:

例如，当你访问 [vercel.com/templates?framework=svelte](https://vercel.com/templates?framework=svelte) 时，页面会先向你呈现一组骨架加载器；与此同时，数据在客户端异步获取；待数据就绪后，再展示 Svelte 模板列表：

![](images/how-to-run-a_b_tests-with-next_js-and-vercel-vercel/img_007.jpg)![](images/how-to-run-a_b_tests-with-next_js-and-vercel-vercel/img_008.jpg)

However, for the dynamic landing pages for each filter option (e.g. [vercel.com/templates/svelte](https://vercel.com/templates/svelte)), we wanted to avoid skeleton loaders since we already know the set of templates that match the given filter at build time.

然而，对于每个筛选选项对应的动态落地页（例如 [vercel.com/templates/svelte](https://vercel.com/templates/svelte)），我们希望避免使用骨架加载器——因为在构建时，我们已经确切知道哪些模板匹配该筛选条件。

To get the best of both worlds, we used Edge Middleware. Since Edge Middleware is [executed before a request is processed on a site](https://vercel.com/docs/concepts/functions/edge-middleware#what-is-edge-middleware), we are able to detect if there are any query parameters present right when the user requests the page.

为兼顾两者优势，我们采用了 Edge Middleware。由于 Edge Middleware 是在请求被网站处理**之前**执行的（参见 [Edge Middleware 简介](https://vercel.com/docs/concepts/functions/edge-middleware#what-is-edge-middleware)），因此我们可在用户发起页面请求的**第一时间**检测是否存在查询参数。

Then, if there are query parameters present, we perform a rewrite to `/templates/skeleton`, which is a special route that shows a skeleton loader.

然后，如果存在查询参数，我们将执行重写操作，跳转至 `/templates/skeleton` —— 这是一个用于显示骨架加载器（skeleton loader）的特殊路由。

Here's the middleware code from earlier, with the addition of this logic:

以下是此前的中间件代码，并已加入上述逻辑：

middleware.ts

```javascript
import { type NextRequest, NextResponse } from 'next/server';



3// make sure the middleware only runs when

3// 确保该中间件仅在以下情况下运行：

4// the requested url starts with `/templates`

4// 请求的 URL 以 `/templates` 开头时才执行。

export const config = {

6  matcher: ['/templates(.*)'],

7};
```

```javascript
const THRESHOLD = 0.2; // initial threshold for the new variant (20%)

const THRESHOLD = 0.2; // 新变体的初始阈值（20%）

const COOKIE_NAME = 'tm_var'; // name of the cookie to store the variant

const COOKIE_NAME = 'tm_var'; // 用于存储变体信息的 Cookie 名称

export function middleware(req: NextRequest) {

export function middleware(req: NextRequest) {

13  // get the variant from the cookie

13  // 从 Cookie 中获取变体

14  // if not found, randomly set a variant based on threshold

14  // 若未找到，则根据阈值随机设定一个变体

15  const variant =

15  const variant =

16    req.cookies.get(COOKIE_NAME) || (Math.random() < THRESHOLD ? 'new' : 'old');

16    req.cookies.get(COOKIE_NAME) || (Math.random() < THRESHOLD ? 'new' : 'old');
```

18  const url = req.nextUrl.clone();

18  const url = req.nextUrl.clone();

20  // if it's the old variant, rewrite to the old templates marketplace

20  // 如果是旧版本，则重写为旧模板市场页面

21  if (variant === 'old') {

21  if (variant === 'old') {

22    url.pathname = '/templates-old';

22    url.pathname = '/templates-old';

23  } else {

23  } else {

24    // for the new variant, we need to perform a rewrite to /template/skeleton

24    // 对于新版本，我们需要将请求重写至 `/template/skeleton`

25    // if there are query paramters in the request URL

25    // 如果请求 URL 中包含查询参数

26    const hasQueryParams = req.nextUrl.search.length > 0;

26    const hasQueryParams = req.nextUrl.search.length > 0;

28    if (hasQueryParams) {

28    如果存在查询参数：

29      url.pathname = `/templates/skeleton`;

29      url.pathname = `/templates/skeleton`;

30    }

30    }

31  }

31  }



33  const res = NextResponse.rewrite(url);

33  const res = NextResponse.rewrite(url);



35  // set the variant in the cookie if not already set

35  // 如果 Cookie 中尚未设置变体，则将其写入 Cookie

36  if (!req.cookies.get(COOKIE_NAME)) {

36  if (!req.cookies.get(COOKIE_NAME)) {

37    res.cookies.set(COOKIE_NAME, variant);

37    res.cookies.set(COOKIE_NAME, variant);

38  }

39  return res;

40}
```

38  }

39  返回 res；

40}
```

用于执行边缘重写以避免布局偏移的中间件代码。

然后，在客户端，我们使用 SWR 检测数据是否已完成获取，并渲染最终的卡片列表：

templates/\[\[...slug\]\].tsx

templates/\[\[...slug\]\].tsx

```javascript
import useSWR from "swr"

import { useRouter } from "next/router"

import { Card, PlaceholderCard, CardProps } from '@/components/cards'

```

```tsx
export default function Templates({ skeleton } : { skeleton: boolean }) {

export default function Templates({ skeleton }: { skeleton: boolean }) {

6  const router = useRouter()

6  const router = useRouter()

7  const { data } = useSWR<CardProps[]>("/api/templates")

7  const { data } = useSWR<CardProps[]>("/api/templates")

9  // if skeleton is true and the router is still loading, show a skeleton

9  // 如果启用骨架加载（skeleton 为 true）且路由尚未就绪，则显示骨架占位符

10  if (!data || (skeleton && !router.isReady)) {

10  if (!data || (skeleton && !router.isReady)) {

11    return (

11    return (

12      <div>

12      <div>

13      	{[...Array(6).keys()].map((i: number) => (

13      	{[...Array(6).keys()].map((i: number) => (

14        	<PlaceholderCard key={i}/>

14        	<PlaceholderCard key={i}/>
```

15        ))}

15        ))}

16      </div>

16      </div>

17		)

17		)

18  }

18  }

20  return (

20  return (

21    <div>

21    <div>

22    	{data.map((d: CardProps, i) => (

22    	{data.map((d: CardProps, i) => (

23       <Card key={i} data={d} />

23       <Card key={i} data={d} />

24       ))}

24       ))}

25    </div>

25    </div>

26  )

26  )

27}

27}

export function getStaticProps(context) {

export function getStaticProps(context) {

30  const skeleton = context.params?.slug?.includes('skeleton')

30  const skeleton = context.params?.slug?.includes('skeleton')

31  return {

31  return {

32    props: {

32    props: {

33      skeleton,

33      skeleton,

34    },

34    },

35  }

35  }

35  }

35  }

36}
```

36}
```

Simplified version of the code that shows how we use SWR and middleware to conditionally render loader skeletons on the client side if there are query parameters present in the request URL.

简化版代码，展示了我们如何使用 SWR 和中间件，在请求 URL 中存在查询参数时，有条件地在客户端渲染加载器骨架（loader skeletons）。

## Collecting data & iterating

## 数据收集与迭代优化

Throughout our **Early Access** and **Public Beta** phases, we collected a series of data points that helped us understand how our new Templates Marketplace was performing in the real world.

在 **早期访问（Early Access）** 和 **公开测试版（Public Beta）** 阶段，我们持续收集了一系列数据指标，帮助我们了解新版模板市场（Templates Marketplace）在真实场景中的实际表现。

### Tracking conversion rates with Heap

### 借助 Heap 追踪转化率

We used [Heap](https://heap.io/) to track our conversion rates: how likely is a user to successfully deploy a template after seeing it on the new vs. old Templates pages.

我们使用 [Heap](https://heap.io/) 追踪转化率：用户在新旧模板页面上浏览某一模板后，成功完成部署的概率分别是多少。

Based on the data from Heap, we were able to make some tweaks to our implementation to increase conversion rates by 16% with the new variant.

基于 Heap 提供的数据，我们对实现方案进行了若干优化调整，使新版模板页面的转化率提升了 16%。

### Tracking search & filter usage Stats with Algolia

### 借助 Algolia 追踪搜索与筛选使用情况

Algolia's [Search Without Results](https://www.algolia.com/doc/guides/getting-analytics/search-analytics/understand-reports/#searches-without-results) feature was also instrumental for us to understand which templates users were interested in. Based on the data, we were getting >30 searches a week for WordPress templates that yielded no results.

Algolia 的 [“无结果搜索”（Search Without Results）](https://www.algolia.com/doc/guides/getting-analytics/search-analytics/understand-reports/#searches-without-results) 功能，对我们理解用户关注哪些模板起到了关键作用。数据显示，每周有超过 30 次针对 WordPress 模板的搜索未返回任何结果。

This prompted us to add a few WordPress templates before releasing the Templates Marketplace to **General Availability**.

这促使我们在将 Templates Marketplace 推向**正式发布（General Availability）**之前，预先添加了若干 WordPress 模板。

![](images/how-to-run-a_b-tests-with-next_js-and-vercel-vercel/img_009.jpg)

## Edge Middleware: Run A/B tests without the tradeoffs

## Edge Middleware：无需权衡取舍即可运行 A/B 测试

[Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware) allowed us to streamline the release of our new Templates Marketplace by putting the new version behind a feature flag until it's fully tested and optimized.

[Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware) 使我们能够优化新 Templates Marketplace 的发布流程——通过功能开关（feature flag）将新版本暂行隔离，直至其完成全面测试与性能调优。

Check out our [Templates Marketplace](https://vercel.com/templates) today to jumpstart your app development process with our pre-built solutions.

欢迎立即访问我们的 [Templates Marketplace](https://vercel.com/templates)，借助我们预构建的解决方案，快速启动您的应用开发流程。