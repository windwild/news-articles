---
title: "How to build zero-CLS A/B tests with Next.js and Vercel Edge Config - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config"
date: "2023-03-23"
scraped_at: "2026-03-02T09:53:51.218920628+00:00"
language: "en-zh"
translated: true
description: "Create a powerful, statically-rendered experimentation engine at scale."
---

render_with_liquid: false
Mar 23, 2023

2023 年 3 月 23 日

A recipe for powerful, statically-rendered experiments at scale.

一种面向大规模、高性能、静态渲染式实验的构建方案。

A/B testing and experiments help you build a culture of growth. Instead of guessing what experiences will work best for your users, you can **build, iterate, and adapt** **with data-driven insights** to produce the most effective UI possible.

A/B 测试与实验有助于你构建一种以增长为导向的文化。与其凭直觉猜测哪种用户体验对用户最有效，不如基于数据驱动的洞察，持续**构建、迭代与优化**，从而打造出效果最佳的用户界面（UI）。

In this article, you'll learn how we built a high-performance experimentation engine for vercel.com using [Next.js](https://nextjs.org/?utm_source=vercel_site&utm_medium=blog&utm_campaign=edge_config_nextjs_experimentation_engine) and [Vercel Edge Config](https://vercel.com/docs/concepts/edge-network/edge-config), allowing our developers to create experiments that load instantly with zero [Cumulative Layout Shift (CLS)](https://vercel.com/docs/concepts/analytics/web-vitals#cumulative-layout-shift-cls) and a great developer experience.

本文将介绍我们如何借助 [Next.js](https://nextjs.org/?utm_source=vercel_site&utm_medium=blog&utm_campaign=edge_config_nextjs_experimentation_engine) 和 [Vercel Edge Config](https://vercel.com/docs/concepts/edge-network/edge-config)，为 vercel.com 构建一套高性能实验引擎——该引擎支持开发者创建瞬时加载的实验，完全规避[累积布局偏移（CLS）](https://vercel.com/docs/concepts/analytics/web-vitals#cumulative-layout-shift-cls)，并提供卓越的开发体验。

[**Want to build better experiments?**\\
\\
We're happy to help.\\
\\
Get in Touch](https://vercel.com/contact/sales)

[**希望构建更优质的实验？**\\
\\
我们很乐意为您提供帮助。\\
\\
立即联系](https://vercel.com/contact/sales)

## Great experiments matter

## 优质的实验至关重要

Experiments are a way to test how distinct versions of your application perform with your users. With one deployment, you can present different experiences for different users.

实验是一种评估应用不同版本在真实用户场景中表现的方法。仅需一次部署，即可面向不同用户呈现差异化体验。

While experiments can be incredibly insightful, it's historically been difficult to run great tests on the Web:

尽管实验能带来极具价值的洞见，但在 Web 端长期难以开展高质量的测试：

- **Client-side rendering (CSR)** your experiments will evaluate which version of your app a user will see _after_ the page has loaded. This results in poor UX since your users will have to wait for loaders while the experiment is evaluated and eventually rendered, creating layout shift.

- **客户端渲染（CSR）**：实验逻辑在页面加载完成之后才执行，用以判断用户应看到哪个版本的应用。这会导致糟糕的用户体验——用户需等待加载指示器（loader），直至实验逻辑完成评估并最终渲染内容，从而引发布局偏移（layout shift）。

- **Server-side rendering (SSR)** can slow page response times as experiments are evaluated on demand. Users have to wait for the experiments along a similar timeline as CSR—but stare at a blank page until all of the work is done to build and serve the page.

- **服务器端渲染（SSR）**：实验逻辑按需执行，会拖慢页面响应速度。用户等待实验完成的时间线与 CSR 类似；但区别在于，他们面对的是一片空白页面，直至所有构建与服务工作全部完成。

These strategies end up with a poor user experience and **give you bad data** about your experiments. Because you’re making your load times worse, you are negatively impacting what _should have been_ your control group.

这些策略最终会导致糟糕的用户体验，并且**为你关于实验的数据带来严重偏差**。由于你进一步恶化了页面加载时间，实际上对本应作为对照组（control group）的用户产生了负面影响。

[Milliseconds make millions](https://web.dev/milliseconds-make-millions), so using the right rendering strategies makes a big difference. Slow load times give you inaccurate results and false impressions about your experiments.

[毫秒决定百万收益](https://web.dev/milliseconds-make-millions)，因此采用正确的渲染策略至关重要。加载缓慢会导致实验结果失真，并让你对实验效果产生错误认知。

![Slow load times have direct impact on user behavior.¹](images/how-to-build-zero-cls-a_b-tests-with-next_js-and-vercel-edge-config-vercel/img_001.jpg)![Slow load times have direct impact on user behavior.¹](images/how-to-build-zero-cls-a_b-tests-with-next_js-and-vercel-edge-config-vercel/img_002.jpg)Slow load times have direct impact on user behavior.¹

![缓慢的加载时间会直接影响用户行为。¹](images/how-to-build-zero-cls-a_b-tests-with-next_js-and-vercel-edge-config-vercel/img_001.jpg)![缓慢的加载时间会直接影响用户行为。¹](images/how-to-build-zero-cls-a_b-tests-with-next_js-and-vercel-edge-config-vercel/img_002.jpg)缓慢的加载时间会直接影响用户行为。¹

## Defining the experiment engine

## 定义实验引擎

For our engineers who aren’t working with experimentation every day, we wanted a simple, standardized path to effective, high-performance experiments. Our requirements were:

对于我们那些并非每天都在开展实验工作的工程师，我们希望提供一条简单、标准化的路径，以实现高效、高性能的实验。我们的核心要求包括：

- Zero impact on end-users  
- 对终端用户零影响  

- Automatically keep users in their "experiment bucket" using our feature flag vendor  
- 借助我们所用的特性标志（feature flag）服务商，自动将用户保留在其所属的“实验分桶”中  

- Send events to our data warehouse when users have given consent  
- 在用户明确授权后，将相关事件发送至我们的数据仓库  

- Excellent "out-of-the-box" developer experience  
- 出色的“开箱即用”开发者体验  

Using the right tools, we knew we could improve both our internal developer experience _and_ end-user experience.

借助恰当的工具，我们确信既能提升内部开发者的体验，也能优化终端用户的体验。

## Leveraging Edge Config for read speed

## 利用 Edge Config 提升读取速度

[Vercel Edge Config](https://vercel.com/docs/concepts/edge-network/edge-config) is a JSON data store that allows you to read dynamic data as geographically close to your users as possible. Edge Config reads complete within 15ms [at P99](https://vercel.com/docs/concepts/analytics/web-vitals#how-the-percentages-are-calculated) or as low as 0ms in some scenarios.

[Vercel Edge Config](https://vercel.com/docs/concepts/edge-network/edge-config) 是一个 JSON 数据存储服务，可让您尽可能在地理上靠近用户的位置读取动态数据。Edge Config 的读取操作在 P99（即 99% 的请求）场景下可在 15 毫秒内完成（[参见百分位数计算方式](https://vercel.com/docs/concepts/analytics/web-vitals#how-the-percentages-are-calculated)），某些情况下甚至可低至 0 毫秒。

middleware.ts

```tsx
import { NextResponse, NextRequest } from 'next/server'

import { get } from '@vercel/edge-config'



export async function middleware(request: NextRequest) {

5  if (await get("showNewDashboard")) {

6    return NextResponse.rewrite(new URL("/new-dashboard", request.url))

7  }
```

8}
```

使用 Edge Config 重写至新仪表板设计。

我们正在利用 [Statsig 的 Edge Config 集成](https://vercel.com/integrations/statsig)，自动将实验的评估规则填充到与本项目关联的 Edge Config 中。随后，我们便可在代码中轻松获取实验配置。

getExperiments.ts

```tsx
import { createClient } from '@vercel/edge-config'

import { EdgeConfigDataAdapter } from 'statsig-node-vercel'

import Statsig from 'statsig-node'



async function initializeStatsig() {

6  const edgeConfigClient = createClient(process.env.EDGE_CONFIG)

```javascript
7  const dataAdapter = new EdgeConfigDataAdapter({
8    edgeConfigClient: edgeConfigClient,
9    edgeConfigItemKey: process.env.STATSIG_EDGE_CONFIG_ITEM_KEY,
10  })

7  const dataAdapter = new EdgeConfigDataAdapter({
8    edgeConfigClient: edgeConfigClient,
9    edgeConfigItemKey: process.env.STATSIG_EDGE_CONFIG_ITEM_KEY,
10  })

12  await Statsig.initialize(process.env.STATSIG_SERVER_KEY, { dataAdapter })
13}

12  await Statsig.initialize(process.env.STATSIG_SERVER_KEY, { dataAdapter })
13}

async function getExperiment(userId, experimentName) {

async function getExperiment(userId, experimentName) {

16  await initializeStatsig()

16  await initializeStatsig()
```

17  return Statsig.getExperiment({ userId }, experimentName)

17  返回 Statsig.getExperiment({ userId }, experimentName)

18}
18}

Populating our runtime with our experimentation configuration.

使用实验配置填充我们的运行时环境。

## Using Next.js for high-performance, flexible experiences

## 使用 Next.js 构建高性能、高灵活性的用户体验

As a high-level overview, we are going to:

作为总体概览，我们将：

- [Create type safety for our code](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config#creating-experiments-in-code)

- [为代码建立类型安全性](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config#creating-experiments-in-code)

- [Pre-render our experiments on the server](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config#prerendering-experiment-variations)

- [在服务端预渲染实验变体](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config#prerendering-experiment-variations)

- [Serve the correct page variations to our users using their cookies](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config#serving-experiments-to-users)

- [借助用户的 Cookie 向其提供正确的页面变体](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config#serving-experiments-to-users)

- [Automatically capture events with a React Context](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config#measuring-success)

- [通过 React Context 自动捕获事件](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config#measuring-success)


### Creating experiments in code

### 在代码中创建实验

To create the most predictable developer experience for ourselves and our teammates, we created a typesafe, single source of truth for our monorepo. Each experiment defines possible values for each parameter along with the paths where the experiment is active. The first value in each array is the default value for a parameter.

为了为我们自身及团队成员打造最可预测的开发者体验，我们为单体仓库（monorepo）构建了一个类型安全、唯一可信源（single source of truth）的实验配置体系。每个实验均明确定义了各参数的可取值范围，以及该实验生效的路径列表；每个数组中的首个值即为对应参数的默认值。

`experiments.ts`

```tsx
export const EXPERIMENTS = {

2  pricing_redesign: {

3    params: {

4      enabled: [false, true],

5      bgGradientFactor: [1, 42]

6    },

7    paths: ['/pricing']

8  },
```

9  skip_button: {

9  skip_button：{

10    params: {

10    params：{

11      skip: [false, true]

11      skip: [false, true]

12    },

12    },

13    // A client-side experiment won't need path values

13    // 客户端实验不需要路径值

14    paths: []

14    paths: []

15  }

15  }

16} as const

16} as const

```

Creating static types for our source code.

```

为我们的源代码创建静态类型。

### Pre-rendering experiment variations

### 预渲染实验变体

[Dynamic routes](https://nextjs.org/docs/routing/dynamic-routes?utm_source=vercel_site&utm_medium=blog&utm_campaign=edge_config_nextjs_experimentation_engine)

[动态路由](https://nextjs.org/docs/routing/dynamic-routes?utm_source=vercel_site&utm_medium=blog&utm_campaign=edge_config_nextjs_experimentation_engine)

Dynamic routes allow Next.js users to create page templates that change what they render using parameters in the route. For our purposes, we encode the experiment variations into the page's pathname. We’ll supply that data through Next.js’ powerful data fetching APIs: `getStaticProps` and `getStaticPaths`.

动态路由允许 Next.js 用户创建页面模板，这些模板可根据路由中的参数动态改变所渲染的内容。在我们的场景中，我们将实验变体（experiment variations）编码进页面的路径名（pathname）中，并通过 Next.js 强大的数据获取 API —— `getStaticProps` 和 `getStaticPaths` —— 提供该数据。

The engine we built offers a wrapped version of `getStaticPaths` which builds the paths for all of the variations of the page. Each path is an encoded version of the hash of the experiment values for that particular path, meaning we store experiment values in the URL itself.

我们构建的引擎提供了一个封装版的 `getStaticPaths`，用于为页面的所有变体生成对应路径。每条路径都是该路径所对应实验值哈希值的编码形式，这意味着我们将实验值直接存储在 URL 中。

Each experiment parameter has multiple options because a page can have many experiments. [All possible combinations](https://en.wikipedia.org/wiki/Cartesian_product) of experiment values for each path could create long build times if a page has many experiments with many variations. To solve this, we calculate the first `n` combinations with a [generator function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/function*) and only pre-render those variations, defaulting to 100 page variations per path.

每个实验参数都包含多个可选项，因为一个页面可能同时运行多个实验。若某页面包含大量实验且每个实验又有多种变体，则所有实验值的[全部可能组合](https://zh.wikipedia.org/wiki/%E7%9B%B4%E7%A7%AF)（笛卡尔积）可能导致构建时间显著延长。为解决此问题，我们采用[生成器函数](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/function*)仅计算前 `n` 种组合，并仅对这些变体进行预渲染；默认情况下，每个路径最多预渲染 100 个页面变体。

![Dynamic routes using encoded experiment values for their parameter slugs.](images/how-to-build-zero-cls-a_b-tests-with-next_js-and-vercel-edge-config-vercel/img_003.jpg)![Dynamic routes using encoded experiment values for their parameter slugs.](images/how-to-build-zero-cls-a_b-tests-with-next_js-and-vercel-edge-config-vercel/img_004.jpg)Dynamic routes using encoded experiment values for their parameter slugs.

![使用编码后的实验值作为参数片段的动态路由。](images/how-to-build-zero-cls-a_b-tests-with-next_js-and-vercel-edge-config-vercel/img_003.jpg)![使用编码后的实验值作为参数片段的动态路由。](images/how-to-build-zero-cls-a_b-tests-with-next_js-and-vercel-edge-config-vercel/img_004.jpg)使用编码后的实验值作为参数片段的动态路由。

Paths not generated at build time fall back to Next.js' Incremental Static Generation or [Incremental Static Regeneration](https://nextjs.org/docs/basic-features/data-fetching/incremental-static-regeneration#fallback-blocking?utm_source=vercel_site&utm_medium=blog&utm_campaign=edge_config_nextjs_experimentation_engine) patterns depending on if you've supplied a `revalidation` interval. Deciding how many pages you want to pre-render is a tradeoff between build time and impact of the delayed initial render for the first visitor to an incrementally static rendered page.

构建时未生成的路径将回退至 Next.js 的“增量静态生成”（Incremental Static Generation）或[增量静态再生](https://nextjs.org/docs/basic-features/data-fetching/incremental-static-regeneration#fallback-blocking?utm_source=vercel_site&utm_medium=blog&utm_campaign=edge_config_nextjs_experimentation_engine)（ISR）机制，具体取决于是否配置了 `revalidation`（重新验证）间隔。决定预渲染多少页面，本质上是在构建耗时与首次访问增量静态生成页面的用户所遭遇的初始渲染延迟之间做出权衡。

The engine also has a wrapper for `getStaticProps` where we decode the parameter from the URL to get the experiment values to use in our pages. We also made sure to give our wrapper the same type as `getStaticProps` so our teammates could use a familiar API.

该引擎还提供了 `getStaticProps` 的封装版本：我们从 URL 中解码参数，从而获取页面中实际使用的实验值。此外，我们确保该封装函数具有与原生 `getStaticProps` 完全一致的 TypeScript 类型定义，以便团队成员能无缝沿用熟悉的 API。

Because these are statically generated pages, the values are available at build time. Putting together our engine's `getStaticPaths` and `getStaticProps` wrappers, our code comes out to look something like:

由于这些是静态生成的页面，相关值在构建时即可获得。将我们引擎提供的 `getStaticPaths` 与 `getStaticProps` 封装函数组合使用后，代码大致如下所示：

experiments/engine/data-fetchers.ts

experiments/engine/data-fetchers.ts

```tsx
1// Your encoding implementation

import { encodeVariations, decodeVariations } from './encoders'
```

```javascript
export function experimentGetStaticPaths(
export function experimentGetStaticPaths（

5  path,
5  path，

6  maxGeneratedPaths = 100
6  maxGeneratedPaths = 100

7) {
7) {

8  return (context) => {
8  return (context) => {

9    const paths = encodeVariations(path, maxGeneratedPaths)
9    const paths = encodeVariations(path, maxGeneratedPaths)

11    return {
11    return {

12      paths,
12      paths，
```

13      fallback: 'blocking',

13      回退策略：'blocking'，

14    }

14    }

15  }

15  }

16}

16}


export function experimentGetStaticProps(pageGetStaticProps) {

export function experimentGetStaticProps(pageGetStaticProps) {

20  return async (context) => {

20  return async (context) => {

21    const { props: pageProps, revalidate } = await pageGetStaticProps(context)

21    const { props: pageProps, revalidate } = await pageGetStaticProps(context)

22	  const encodedRoute = context.params?.experiments

22	  const encodedRoute = context.params?.experiments

24    // Read from URL or use default values  
24    // 从 URL 读取，或使用默认值  

25    const experiments = decodeVariations(encodedRoute) ?? EXPERIMENT_DEFAULTS  
25    const experiments = decodeVariations(encodedRoute) ?? EXPERIMENT_DEFAULTS  

27    return {  
27    返回 {  

28      props: {  
28      props: {  

29        ...pageProps,  
29        ...pageProps,  

30        experiments  
30        experiments  

31      },  
31      },  

32      revalidate  
32      revalidate

33    }

34}
```

创建数据获取工具函数。

现在，当我们着手实现一个实验时，可以这样编写：

pages/pricing/[experiments].ts

```tsx
export const getStaticPaths = experimentGetStaticPaths("/pricing")

export const getStaticProps = experimentGetStaticProps(async () => {
  const { prices } = await fetchPricingMetadata()
```

6  return {

7    props: {

8      prices

9    }

10  }

11})
```

使用我们引擎的数据获取工具。

### 向用户提供实验版本（A/B 测试）

为确保用户被路由至正确的页面变体，我们利用 [Next.js 中间件中的重写（rewrites）功能](https://nextjs.org/docs/api-reference/next/server#static-methods?utm_source=vercel_site&utm_medium=blog&utm_campaign=edge_config_nextjs_experimentation_engine)。

- 如果用户此前已访问过 vercel.com，则重写逻辑由该用户已存在的 Cookie 驱动。

- If a user doesn't have a cookie, the Middleware reads from Edge Config and encodes the values, determining the route for the variation. Thanks to the speed of Edge Config, we know our user won’t have a delayed page load.

- 如果用户没有 Cookie，中间件（Middleware）将从 Edge Config 中读取并编码相应值，从而确定该变体（variation）的路由。得益于 Edge Config 的高速响应，我们可确保用户不会遭遇页面加载延迟。

When you use a rewrite in Middleware, your user still sees `/pricing` in their browser bar even though you served `/pricing/0p0v0`, the statically pre-rendered version of the page with their experiment values.

当您在中间件（Middleware）中使用重写（rewrite）时，用户浏览器地址栏中仍显示 `/pricing`，而实际向其提供的是 `/pricing/0p0v0` —— 即已根据其实验（experiment）参数静态预渲染完成的页面版本。

middleware.ts

middleware.ts

```tsx
import { NextResponse } from 'next/server'



async function getExperimentsForRequest(req) {

4  const cookie = getExperimentsCookie(req)

5  const experiments = cookie

6    ? parseExperiments(cookie)

7    : readExperimentsFromEdgeConfigAndUpdateCookie(req)
```

9  return experiments

9  返回实验配置

10}

10}

export async function middleware(req) {

export async function middleware(req) {

13  const experiments = await getExperimentsForRequest(req)

13  const experiments = await getExperimentsForRequest(req)

14  const path = getPathForExperiment(experiments, req)

14  const path = getPathForExperiment(experiments, req)

16  return NextResponse.rewrite(new URL(path, req.url))

16  return NextResponse.rewrite(new URL(path, req.url))

17}

17}

```ts
export const config = {

20  matcher: '/pricing'

21}
```

```ts
export const config = {

20  matcher: '/pricing'

21}
```

The cookie's value is the experiment parameters assigned through the [Statsig Edge Config integration](https://vercel.com/integrations/statsig) that we set up earlier. Our users will end up in "buckets" based on the values that our Statsig integration assigns them, intelligently handling which users receive which experiments.

Cookie 的值是通过我们此前配置的 [Statsig Edge Config 集成](https://vercel.com/integrations/statsig) 分配的实验参数。我们的用户将根据 Statsig 集成为其分配的值被划分到不同的“分桶（buckets）”中，从而智能地决定哪些用户参与哪些实验。

It's possible for a client's cookie to go stale and end up out of sync with our experiment configuration. We'll get into how we keep the cookie fresh [in a moment](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config#ensuring-experiments-stay-fresh).

客户端 Cookie 可能过期，导致其与当前实验配置不同步。稍后我们将介绍[如何保持 Cookie 始终最新](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config#ensuring-experiments-stay-fresh)。

A user receives a page that was rendered on the server so our React components that use our engine's `useExperiment` hook will already know their values, resulting in no layout shift.

用户接收到的是服务端渲染的页面，因此使用我们引擎中 `useExperiment` Hook 的 React 组件在初始渲染时即已获知实验参数值，从而避免了布局偏移（layout shift）。

Pricing.tsx

Pricing.tsx

```tsx
function Pricing({ prices }) {

2  const { enabled, bgGradientFactor } = useExperiment("pricing_redesign")
```

```tsx
function Pricing({ prices }) {

2  const { enabled, bgGradientFactor } = useExperiment("pricing_redesign")
```

4  return (

4  返回 (

5    <div>

5    <div>

6      <h1>Pricing</h1>

6      <h1>价格</h1>

7      {

7      {

8        enabled ?

8        已启用 ?

9          <GradientPricingTable factor={bgGradientFactor} prices={prices} />

9          <GradientPricingTable factor={bgGradientFactor} prices={prices} />

10          : <PricingTable prices={prices} />

10          : <PricingTable prices={prices} />

11      }

11      }

12      </div>

12      </div>

13    )

14}
```

使用钩子（hook）实现静态渲染的实验。

现在我们已具备理想的用户体验（UX），接下来需要收集、探索并分析实验数据，以评估其实验效果。

### 衡量成功与否

借助之前构建的类型安全辅助函数，我们创建了一个 React Context，用于在当前页面中保存实验值，并自动向我们的数据仓库上报 `EXPERIMENT_VIEWED` 事件。

analyticsContext.ts

```tsx
export function trackExperiment(experimentName) {

2  analytics(EXPERIMENT_VIEWED, getTrackingMetadataForExperiment(experimentName))

3}

```javascript
const Context = createContext()



export function ExperimentContext({

8  experiments,

9  path,

10  children

11}) {

12  useEffect(() => {

13    for (const experimentName of getExperimentsForPath(path)) {
```

14      trackExperiment(experimentName);

14      跟踪实验（experimentName）；

15    }

15    }

16  }, [])

16  }, [])

18  return (

18  return (

19    <Context.Provider experiments={experiments}>

19    <Context.Provider experiments={experiments}>

20      {children}

20      {children}

21    </Context.Provider>

21    </Context.Provider>

22  )

22  )

23}
```

23}
```

Building a React Context to easily track analytics.

构建一个 React Context，以便轻松跟踪分析数据。

After we’ve collected enough data, we can visit our internal data visualization tools to evaluate the performance of our experiments and confidently decide what to ship next.

在收集到足够多的数据后，我们可以访问内部的数据可视化工具，评估实验效果，并自信地决定下一步要上线的功能。

## Handling client-side experiments

## 处理客户端实验

Not every experiment will happen on the first page load so we still need to be able to handle client side experiments. For example, an experiment can be rendered in a modal or pop-in prompt.

并非所有实验都会在首次页面加载时触发，因此我们仍需支持客户端实验。例如，某个实验可能在模态框（modal）或弹出式提示（pop-in prompt）中渲染。

In these cases, we use our client-side React hook since we don't have to worry about the initial loading experience.

在这些场景下，我们使用客户端 React Hook，因为无需顾虑首屏加载体验。

components/PricingModal.ts

components/PricingModal.ts

```tsx
function PricingModal() {

2  // Fully-typed `skip` from EXPERIMENTS constant under the hood

3  const { skip } = useClientSideExperiment("skip_button")

```

5  return (

5  返回（

6    <Modal>

6    <Modal>

7      <Modal.Title>Invite Teammates</Modal.Title>

7      <Modal.Title>邀请团队成员</Modal.Title>

8      <Modal.Description>Add members to your team.</Modal.Description>

8      <Modal.Description>向您的团队添加成员。</Modal.Description>

9      <Modal.Button>Ok</Modal.Button>

9      <Modal.Button>确定</Modal.Button>

10      {skip ? <Modal.Button>Skip</Modal.Button> : null}

10      {skip ? <Modal.Button>跳过</Modal.Button> : null}

11    </Modal>

11    </Modal>

12  )

12  ）

13}
```

13}
```

With this hook, we read directly from the cookie to find out what experimentation bucket our user belongs to and render the desired UI for that experiment. We won’t need server-side rendering, static generation, or routing for these experiments since the user is already interacting with our UI.

借助此 Hook，我们直接从 Cookie 中读取信息，以确定用户所属的实验分组（experimentation bucket），并为该实验渲染对应的用户界面。由于用户已在与我们的 UI 进行交互，因此这些实验无需服务端渲染（SSR）、静态生成（SSG）或路由处理。

## Ensuring experiments stay fresh

## 确保实验始终保持最新状态

It’s possible for a user to end up with a stale or outdated cookie in their browser while we update our experiments behind the scenes. To fix this, we keep cookies warm with a background fetcher that has an interval of 10 minutes.

在后台更新实验时，用户浏览器中可能残留过期或陈旧的 Cookie。为解决此问题，我们通过一个间隔为 10 分钟的后台获取器（background fetcher）持续“预热”这些 Cookie。

![](images/how-to-build-zero-cls-a_b-tests-with-next_js-and-vercel-edge-config-vercel/img_005.jpg)![](images/how-to-build-zero-cls-a_b-tests-with-next_js-and-vercel-edge-config-vercel/img_006.jpg)

![](images/how-to-build-zero-cls-a_b-tests-with-next_js-and-vercel-edge-config-vercel/img_005.jpg)![](images/how-to-build-zero-cls-a_b-tests-with-next_js-and-vercel-edge-config-vercel/img_006.jpg)

Because we are using an [Edge Function](https://vercel.com/docs/concepts/functions/edge-functions) combined with an [Edge Config](https://vercel.com/docs/concepts/edge-network/edge-config), we can trust that this background refresh executes lightning fast, avoiding cold starts and leveraging Edge Config's instant reads.

由于我们结合使用了 [Edge Function](https://vercel.com/docs/concepts/functions/edge-functions) 和 [Edge Config](https://vercel.com/docs/concepts/edge-network/edge-config)，因此可确保该后台刷新操作执行极快——既避免冷启动，又能充分利用 Edge Config 的即时读取能力。

## Effective experiments, every time

## 每次都高效运行的实验

With Next.js and Edge Config, we've built an experimentation engine where:

借助 Next.js 和 Edge Config，我们构建了一套实验引擎，具备以下特性：

- Our users won’t experience Cumulative Layout Shift as a result of an experiment.

- 用户不会因实验而遭遇累积布局偏移（Cumulative Layout Shift，CLS）。

- We can run multiple page and component-level experiments per page and across pages.

- 我们可在单页及跨页面范围内，同时运行多个页面级与组件级实验。

- We can ship and iterate on experiments at Vercel more quickly and safely.

- 我们能在 Vercel 上更快速、更安全地部署和迭代实验。

- We can collect high-value knowledge on what works best for our users without sacrificing page performance.

- 我们可在不牺牲页面性能的前提下，收集关于“何种方案最契合用户需求”的高价值洞见。

For the past few months, we’ve shipped many different zero-CLS experiments on [vercel.com](http://vercel.com/) and we’re excited to continue improving your experience with new insights.

过去几个月，我们已在 [vercel.com](http://vercel.com/) 上上线了多项零累积布局偏移（zero-CLS）实验，我们非常期待借助新的洞见持续优化您的使用体验。

[**Build better experiments**\\
\\
Get started today.\\
\\
Let's Talk](https://vercel.com/contact/sales)

[**构建更优的实验**\\
\\
立即开始。\\
\\
联系我们](https://vercel.com/contact/sales)

¹ ["Milliseconds Make Millions" report, Deloitte Digital](https://www2.deloitte.com/content/dam/Deloitte/ie/Documents/Consulting/Milliseconds_Make_Millions_report.pdf)

¹ 德勤数字（Deloitte Digital）《毫秒成就百万》报告：[https://www2.deloitte.com/content/dam/Deloitte/ie/Documents/Consulting/Milliseconds_Make_Millions_report.pdf](https://www2.deloitte.com/content/dam/Deloitte/ie/Documents/Consulting/Milliseconds_Make_Millions_report.pdf)

Vercel Template

Vercel 模板

Deploy this template

部署此模板

### Reduce CLS and improve performance from client-loaded experiments at the edge with Statsig

### 借助 Statsig，在边缘端优化客户端加载实验的 CLS 并提升性能

Experimentation with Statsig

使用 Statsig 进行实验

Blog post

博客文章

Jan 13, 2023

2023 年 1 月 13 日

### Sanity balances experimentation and performance with Vercel Edge Middleware

### Sanity 借助 Vercel 边缘中间件，在实验与性能之间实现平衡

![](images/how-to-build-zero-cls-a_b-tests-with-next_js-and-vercel-edge-config-vercel/img_007.jpg)

格蕾丝·马德林格