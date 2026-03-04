---
title: "Deploy Remix without limits on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-remix-integration-with-edge-functions-support"
date: "2023-03-22"
scraped_at: "2026-03-02T09:53:57.751111858+00:00"
language: "en-zh"
translated: true
description: "Vercel now has advanced Remix support, including SSR streaming with Edge Functions and multi-runtime support."
---
&#123;% raw %}

Mar 22, 2023

2023 年 3 月 22 日

部署并弹性伸缩任意规模与复杂度的 Remix 应用。

我们很高兴地宣布推出 **高级 Remix 集成**，支持以下功能：

- **流式服务端渲染（Streaming SSR）：** 支持在 Node.js 和 Edge 运行时环境中动态流式传输内容

- **API 路由（API Routes）：** 借助 Remix 及其 `loader` 路由轻松构建无服务器 API

- **高级缓存（Advanced Caching）：** 使用强大的缓存响应头，例如 `stale-while-revalidate`

- **数据变更（Data Mutations）：** 在无服务器函数或 Edge 函数中运行 `actions`

## Remix 适配器（Remixing Adapters）

## Remix 适配器

[Remix](https://remix.run/) 是一个以 Web 基础能力为核心理念的服务器端渲染 React 框架。由于 Remix 的请求处理器基于 [Web Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API)，因此它可被 _适配_ 以兼容任意部署平台。

借助 Vercel 全新推出的高级 Remix 集成（`@vercel/remix`），您无需任何适配器即可快速上手。Vercel 现已原生支持最轻量、最强大的 Remix 集成方案——既不需要 `server.js` 文件，也无需自定义 `vercel.json` 配置。

This integration has been designed for use in our serverless environment, including support for both the Node.js runtime (Serverless Functions) and the Edge runtime (Edge Functions).

该集成专为在我们的无服务器环境中使用而设计，同时支持 Node.js 运行时（Serverless Functions）和 Edge 运行时（Edge Functions）。

We've abstracted away runtime-specific needs, like how to handle cookies or streaming in different environments, and made it easily consumable. To take advantage of this, instances of `@remix-run/node` can be replaced with `@vercel/remix`.

我们已将运行时特定的需求（例如在不同环境中如何处理 Cookie 或流式响应）进行了抽象封装，使集成更简单易用。为此，您只需将代码中所有 `@remix-run/node` 的实例替换为 `@vercel/remix` 即可启用此能力。

We are collaborating with the Remix team to [contribute changes back upstream](https://github.com/remix-run/remix/pulls/TooTallNate) and help make the Remix build outputs more modular.

我们正与 Remix 团队合作，[将相关改进贡献回上游](https://github.com/remix-run/remix/pulls/TooTallNate)，以推动 Remix 构建产物进一步模块化。

## Server-Rendering with Edge Functions

## 使用 Edge Functions 进行服务端渲染

Until today, deploying Remix applications meant choosing between **two different runtimes for the entire application**: choosing all Node.js, or all Web/Edge-oriented runtimes.

在此前，部署 Remix 应用意味着必须在整个应用层面**二选一**：全部采用 Node.js 运行时，或全部采用面向 Web/Edge 的运行时。

With Vercel's advanced Remix support, applications can now choose their runtime on a per-route basis. This means you get the best parts of both Node.js and Web APIs – all in one application on one platform.

借助 Vercel 对 Remix 的深度支持，如今应用可以按路由粒度灵活选择运行时。这意味着您能在同一个应用、同一平台之上，兼得 Node.js 与 Web API 各自的优势。

For example, by adding one line of code to a route in `app/routes`, you can change the rendering runtime to use Edge Functions:

例如，只需在 `app/routes` 下某个路由文件中添加一行代码，即可将该路由的渲染运行时切换为 Edge Functions：

app/routes/edge.tsx

```tsx
import { json } from '@vercel/remix';
```

```ts
export const config = { runtime: "edge" };
```

```ts
export const config = { runtime: "edge" };
```

5// This `loader` now runs as an Edge Function

5// 此 `loader` 现在作为边缘函数（Edge Function）运行

export async function loader({ request }) {

export async function loader({ request }) {

7  // You have access to the incoming request headers

7  // 您可以访问传入请求的请求头（headers）

8  // including powerful geolocation headers added by Vercel

8  // 包括 Vercel 添加的强大地理位置相关请求头

9  // e.g. request.headers.get('x-vercel-ip-city')

9  // 例如：request.headers.get('x-vercel-ip-city')

11  return json({ ... })​;

11  return json({ ... })​;
```

You can now server-render routes using Vercel Edge Functions

现在，您可使用 Vercel Edge Functions 对路由进行服务端渲染。

## Advanced Caching

## 高级缓存

Vercel supports caching `loader` responses using our Edge Network Cache by providing `cache-control` headers to a given route. This includes support for newer [caching headers](https://vercel.com/docs/concepts/edge-network/caching) like `stale-while-revalidate` and `stale-if-error`.

Vercel 支持通过为指定路由提供 `cache-control` 响应头，利用我们的边缘网络缓存（Edge Network Cache）对 `loader` 的响应进行缓存。这包括对较新的 [缓存响应头](https://vercel.com/docs/concepts/edge-network/caching)（例如 `stale-while-revalidate` 和 `stale-if-error`）的支持。

For example, the following `headers` tell Vercel:

例如，以下 `headers` 配置向 Vercel 表明：

- If a request is repeated within the next second, the previously cached value is still fresh.

- 若同一请求在接下来 1 秒内重复发生，则此前缓存的值仍被视为新鲜（fresh）。

- If the request is repeated between 1 and 60 seconds later, the cached value will be marked as stale but still shown.

- 若该请求在 1 至 60 秒后再次发生，则缓存值将被标记为过时（stale），但仍会返回给用户。

- In the background, a revalidation will be made to populate the cache with a fresh value from the `loader`.

- 同时，系统将在后台发起一次重新验证（revalidation），以从 `loader` 获取最新值并更新缓存。

```jsx
export function headers() {

2  return {

3    "Cache-Control": "s-maxage=1, stale-while-revalidate=59",
```

4  };

5}
```

添加缓存响应头（caching headers）有助于提升 Remix 应用的服务器端渲染（SSR）性能。

你可以进一步增强应用的容错能力，使用 `stale-if-error` 响应头。该头指示 Vercel 边缘缓存（Edge Cache）：当 `loader` 执行出错时，可复用一份过期（stale）的缓存响应。例如，当你尝试从数据库或 CMS 获取数据，而该后端服务恰好出现短暂宕机时，你的网站 _不会_ 因 `loader` 抛出错误而中断服务。

```javascript
export function headers() {

2  return {

3    "Cache-Control": "s-max-age=2592000, stale-while-revalidate=86400, stale-if-error=604800",

4  };

5}
```

轻松让你的 Remix 应用具备应对后端或数据库瞬时故障的韧性。

This `cache-control` value uses a `max-age` value of 30 days, a `stale-if-revalidate` value of 1 day, and a `stale-if-error` value of 7 days.

该 `cache-control` 值设置了 `max-age` 为 30 天、`stale-if-revalidate` 为 1 天，以及 `stale-if-error` 为 7 天。

[Jenna Smith](https://twitter.com/jjenzz) has created a [fantastic package](https://github.com/jjenzz/pretty-cache-header) to make working with `cache-control` values easier called `pretty-cache-header`. For example, the previous example would become:

[Jenna Smith](https://twitter.com/jjenzz) 创建了一个非常出色的工具包 [fantastic package](https://github.com/jjenzz/pretty-cache-header)，名为 `pretty-cache-header`，可让 `cache-control` 值的使用变得更加简便。例如，前述示例将变为：

```javascript
import { cacheHeader } from 'pretty-cache-header';



export function headers() {

4  return {

5    "Cache-Control": cacheHeader({

6      sMaxAge: '30days',

7      staleWhileRevalidate: '1day',

8      staleIfError: '7days'
```

9    })

10  };

11}
```

轻松使用此社区包处理 `cache-control` 字符串

## 在 Vercel 上实现流式 SSR

Vercel 的 Remix 集成支持流式服务端渲染（SSR），包括在 Edge 和 Node.js 运行时中的使用。

默认情况下，Vercel 集成会自动添加 `app/entry.server.tsx` 文件（若未明确定义），且该文件已配置为支持流式渲染。现有的 Remix 项目也可采用以下入口文件，以实现同构流式渲染：

`app/entry.server.tsx`

```tsx
import { handleRequest } from '@vercel/remix';

import { RemixServer } from '@remix-run/react';

```typescript
import type { EntryContext } from '@vercel/remix';

import type { EntryContext } from '@vercel/remix';

export default function (
  request: Request,
  responseStatusCode: number,
  responseHeaders: Headers,
  remixContext: EntryContext
) {
  const remixServer = <RemixServer context={remixContext} url={request.url} />;
  return handleRequest(
```

```typescript
export default function (
  request: Request,
  responseStatusCode: number,
  responseHeaders: Headers,
  remixContext: EntryContext
) {
  const remixServer = <RemixServer context={remixContext} url={request.url} />;
  return handleRequest(
```

默认导出函数：
```typescript
export default function (
  request: Request,
  responseStatusCode: number,
  responseHeaders: Headers,
  remixContext: EntryContext
) {
  const remixServer = <RemixServer context={remixContext} url={request.url} />;
  return handleRequest(
```

13    request,

13    请求，

14    responseStatusCode,

14    响应状态码，

15    responseHeaders,

15    响应头，

16    remixServer

16    Remix 服务器

17  );

17  );

18}

18}

Isomorphic support for streaming in both Node.js and Edge runtimes.

在 Node.js 和 Edge 运行时中均支持同构流式传输。

Powerful Remix features like `defer()` and `<Await>`, built on top of React 18 and `Suspense`, are now supported in both runtimes. For example, [in our demo](https://remix-on-the-edge.vercel.app/), we're able to simulate a throttled network by delaying our `Promise` by one second. Then, we can use the deferred result inside our React component.

基于 React 18 和 `Suspense` 构建的强大 Remix 功能（例如 `defer()` 和 `<Await>`）现已在两种运行时中均受支持。例如，在[我们的演示](https://remix-on-the-edge.vercel.app/)中，我们可通过将 `Promise` 延迟一秒来模拟网络限速场景；随后即可在 React 组件中使用该延迟加载的结果。

```javascript
import { Suspense } from 'react';

import { Await, useLoaderData } from '@remix-run/react';
```

```javascript
export async function loader({ request }) {

5  const version = process.versions.node;



7  return defer({

8    version: sleep(version, 1000),

9  });

10}



function sleep(val, ms) {
```

```javascript
export async function loader({ request }) {

5  const version = process.versions.node;



7  return defer({

8    version: sleep(version, 1000),

9  });

10}



function sleep(val, ms) {
```

13  return new Promise((resolve) => setTimeout(() => resolve(val), ms));

13  return new Promise((resolve) => setTimeout(() => resolve(val), ms));

14}

14}

export default function App() {

export default function App() {

17  const { version } = useLoaderData();

17  const { version } = useLoaderData();

19  return (

19  return (

20    <Suspense fallback={'Loading…'}>

20    <Suspense fallback={'加载中…'}>

21      <Await resolve={version}>

21      <Await resolve={version}>

22        {(version) => <strong>{version}</strong>}

22        {(version) => <strong>{version}</strong>}

23      </Await>

23      </Await>

24    </Suspense>

24    </Suspense>

25  );

25  );

26}
```

26}
```

To simulate slow network speeds, we can delay the promise to retrieve the Node.js version.

为模拟较慢的网络速度，我们可以延迟获取 Node.js 版本的 Promise。

With Vercel, your Remix application is fast globally. With a cache `MISS`, we frequently see under 100ms latency for a dynamic server-rendered page.

借助 Vercel，您的 Remix 应用在全球范围内都能实现极速访问。即使发生缓存 `MISS`，动态服务端渲染页面的延迟也通常低于 100 毫秒。

## Try Remix on Vercel today

## 今天就试用 Vercel 上的 Remix

Remix on Vercel, now with our powerful integration containing Edge rendering support, is truly dynamic at the speed of static. With [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure), your Remix application automatically takes advantage of the best infrastructure primitives.

Vercel 上的 Remix 现已支持强大的集成能力，包括边缘渲染（Edge rendering）；它真正实现了“静态般的速度，动态般的能力”。借助 [框架定义的基础设施（Framework-Defined Infrastructure）](https://vercel.com/blog/framework-defined-infrastructure)，您的 Remix 应用将自动采用最优的底层基础设施原语。

We're continuing to invest in further improvements to Remix on Vercel and we'd love to hear your feedback on what you want to see.

我们正持续投入资源，进一步优化 Vercel 上的 Remix 体验；也非常期待听到您对未来功能的期待与反馈。

Twitter post

Twitter 帖子

### Deploying @remix_run to @vercel is now zero config thanks to collaborative efforts. Remix + Vercel = 🖤

### 得益于多方协作，将 @remix_run 部署到 @vercel 现已实现零配置。Remix + Vercel = 🖤

![Kent C. Dodds's avatar](images/deploy-remix-without-limits-on-vercel-vercel/img_001.jpg)Kent C. Dodds@kentcdodds

![Kent C. Dodds 的头像](images/deploy-remix-without-limits-on-vercel-vercel/img_001.jpg)Kent C. Dodds@kentcdodds

Vercel Template

Vercel 模板

Deploy this template

部署此模板

### A new Remix app — the result of running `npx create-remix`.

### 一个全新的 Remix 应用——运行 `npx create-remix` 后生成的结果。

Remix Boilerplate

Remix 项目脚手架
&#123;% endraw %}
