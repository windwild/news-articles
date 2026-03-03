---
title: "Migrating Grep from Create React App to Next.js - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/migrating-grep-from-create-react-app-to-next-js"
date: "2025-04-14"
scraped_at: "2026-03-02T09:34:54.674848924+00:00"
language: "en-zh"
translated: true
description: "We migrated grep​.app from Create React App to Next.js. We break down how we combined single-page app speed with React Server Component efficiency. 70% faster First Contentful Paint, 73% quicker net..."
---

Apr 14, 2025

2025 年 4 月 14 日

[Grep](https://grep.app/) 是一款极速的代码搜索工具。你可以在超过一百万个代码仓库中，快速查找特定的代码片段、文件或路径。搜索结果必须瞬时呈现，无需加载动画（loading spinner）。

Grep 最初基于 Create React App（CRA）构建，是一个完全客户端渲染的单页应用（SPA），本身已非常快速；但随着 [CRA 已正式弃用](https://react.dev/blog/2025/02/14/sunsetting-create-react-app)，我们希望对代码库进行现代化升级，使其更快、更易维护。

以下是 Grep 迁移至 Next.js 的全过程——在保留 SPA 交互体验的同时，借助 React Server Components 实现性能跃升。

## 为何选择 Next.js 和 React Server Components？

传统的 SPA 页面跳转极为迅速，但代价是需下载并解析体积庞大的客户端 JavaScript 包，才能使页面具备交互能力。

我们追求极致的首屏加载速度，同时又不牺牲后续页面间的快速导航体验。Next.js 可对页面主体内容进行预渲染（prerendering），从而保障可预测且高速的首次加载；同时还能智能地预取（prefetch）其他页面资源，延续 SPA 那般丝滑的导航感受。

接下来，我们将详细介绍此次迁移到 Next.js 的过程，并同步实现搜索输入框更快响应交互、彻底消除不必要的布局偏移（layout shift）。

## 保持“即时搜索”的用户体验

Grep 对搜索速度的要求极高：用户在首页开始输入，页面跳转至 `/search` 后，应持续输入且焦点不丢失。请留意视频演示：搜索框从首页中央位置平滑过渡至 `/search` 页面顶部的导航栏中。

With a traditional SPA, the search state stays on the client and the UI remains intact. But when moving state to the server, we needed to keep the search input state consistent across page navigations.

在传统的单页应用（SPA）中，搜索状态保留在客户端，UI 也保持不变。但当将状态迁移至服务器端时，我们需要确保搜索输入状态在页面导航之间保持一致。

### **Root layout and repositioning**

### **根布局与重新定位**

You could place the search bar in Next.js’ [root layout](https://nextjs.org/docs/app/getting-started/layouts-and-pages#creating-a-layout). This would prerender the search bar in one place and then you could quickly reposition it on the client after hydration.

你可将搜索栏放置在 Next.js 的 [根布局](https://nextjs.org/docs/app/getting-started/layouts-and-pages#creating-a-layout) 中。这样，搜索栏将在服务端预先渲染于固定位置，随后可在客户端完成 hydration 后快速将其重新定位。

layout.tsx

```javascript
export default function RootLayout({ children }) {

2  return (

3    <>

4      <script dangerouslySetInnerHTML={{ __html: "..repositioning logic.." }} />

5      <SearchBar />

6      <main>{children}</main>
```

7    </>

8  );

9}
```

然而，这将导致水合不匹配（hydration mismatches），并引发布局偏移（layout shift）。此外，我们还需通过 URL 的查询参数（search params）来同步状态。若在根布局（root layout）中直接从传入的请求中读取 `searchParams`，将限制我们对页面大部分内容进行预渲染（prerendering）的能力。

### **条件渲染与共享状态**

与其重新定位该元素，不如为搜索输入框创建两个引用，并根据需要条件性地渲染它们。

1. **首页（客户端渲染）**：将搜索栏居中显示，以提供简洁、类似 Google 的用户体验  

2. **页眉（服务端渲染）**：在除首页外的所有路由中显示搜索栏  

这样既保持了首页的极简风格，又确保用户在离开首页导航至其他页面时，搜索栏能立即出现在顶部导航栏中——无布局偏移，无闪烁。

其工作原理如下：我们的页眉中包含搜索栏，但仅在 `/search` 路由下才渲染该搜索栏。

`components/header.tsx`

`components/header.tsx`

```jsx
1"use client";



export function Header() {

4  const pathname = usePathname();



6  return (

7    <header>

8      <Logo />

9      {pathname !== '/' && <SearchBar />}
```

10      <ThemeToggle />

10      <ThemeToggle />

11    </header>

11    </header>

12  );

12  );

13}
```

13}
```

The header is rendered in the root layout, keeping it server-rendered across pages:

该页眉在根布局中渲染，从而确保其在所有页面上均以服务端渲染方式呈现：

layout.tsx

layout.tsx

```jsx
import { Header } from '@/components/header';



export default function RootLayout({ children }) {

4  return (
```jsx
import { Header } from '@/components/header';



export default function RootLayout({ children }) {

4  return (

```
5    <html>

5    <html>

6      <body>

6      <body>

7        <Header />

7        <Header />

8        {children}

8        {children}

9      </body>

9      </body>

10    </html>

10    </html>

11  );

11  );

12}
```

12}
```

Meanwhile, the homepage renders its own version of the `SearchBar` component:

与此同时，首页渲染其自身版本的 `SearchBar` 组件：

page.tsx

page.tsx
```

```jsx
export function Homepage() {

2  return (

3    <div className="search-centered">

4      <SearchBar />

5    </div>

6  );

7}
```

这使得用户可以在首页开始输入，且在跳转到下一页时不会丢失输入框的焦点（即使其位置发生了变化）。

### **保持搜索状态同步**

### **保持搜索状态同步**

如果同时渲染两个搜索输入框，则需要确保它们的状态保持同步。关键在于结合基于 URL 的状态与轻量级的共享状态管理。

1. **Homepage**: `<SearchBar>` updates query string, navigating to `/search?q=...`

1. **首页**：`<SearchBar>` 组件更新查询字符串，导航至 `/search?q=...`

2. **Navbar**: `<SearchBar>` reads from URL query parameters, synchronizing on mount

2. **导航栏**：`<SearchBar>` 组件从 URL 查询参数中读取值，并在组件挂载时完成同步。

To provide more responsive local feedback, especially during rapid typing, we also manage local input state through React Context and hooks.

为了提供更灵敏的本地反馈（尤其是在快速输入时），我们还通过 React Context 和自定义 Hook 来管理本地输入状态。

## Server-first, client-second data fetching

## 服务端优先、客户端次之的数据获取策略

Now, we need to instantly display the search results. The challenge is the handoff between the server and client. Going back to the server for every keystroke could be slow, and doing all data fetching on the client means a slower initial loading experience.

现在，我们需要即时展示搜索结果。其中的关键挑战在于服务端与客户端之间的数据交接：每次按键都向服务端发起请求会导致响应迟缓；而将全部数据获取逻辑放在客户端，则会使首屏加载变慢。

Luckily, there's great solutions in the React community for data fetching like [SWR](https://swr.vercel.app/) and [TanStack Query](https://tanstack.com/query/latest). These abstractions allow you to prefetch data on the server and then hydrate the client-side cache.

幸运的是，React 社区已提供了优秀的数据获取解决方案，例如 [SWR](https://swr.vercel.app/) 和 [TanStack Query](https://tanstack.com/query/latest)。这些抽象层支持在服务端预取数据，并在客户端“注水”（hydrate）缓存。

### **Server-side initial fetch and hydration**

### **服务端初始获取与客户端缓存注水**

When you first visit the search results page (e.g., `/search?q=react`), the server starts fetching data immediately—without blocking. HTML begins streaming to the client while the query is still in-flight.

当你首次访问搜索结果页面（例如 `/search?q=react`）时，服务端会立即启动数据获取——且不阻塞渲染。HTML 在查询仍在进行中时便开始流式传输至客户端。

This is possible because React Server Components can serialize Promises and pass them through a `HydrationBoundary`, allowing TanStack Query to resume the query on the client without redundant fetches.

这之所以可行，是因为 React 服务端组件（RSC）能够序列化 Promise，并通过 `HydrationBoundary` 将其传递给客户端，从而使 TanStack Query 可在客户端无缝续查，避免重复请求。

search/page.tsx

```jsx
import { /* ... */} from "@tanstack/react-query";

import { ResultsClient } from "@/components/results";

import { apiSearch } from "@/lib/api";

import { getFiltersFromRawSearchParams } from "@/lib/utils";

import { /* ... */} from "@tanstack/react-query";

导入 { ResultsClient } 来自 "@/components/results";

导入 { apiSearch } 来自 "@/lib/api";

导入 { getFiltersFromRawSearchParams } 来自 "@/lib/utils";

const queryClient = new QueryClient({

const queryClient = new QueryClient({

7  defaultOptions: {

7  defaultOptions: {

8    dehydrate: {

8    dehydrate: {

9      // Include pending queries so the client can pick them up

9      // 包含待处理的查询，以便客户端能够接管它们

10      shouldDehydrateQuery: (query) =>
10      shouldDehydrateQuery: (query) =>
```

11        defaultShouldDehydrateQuery(query) || query.state.status === 'pending'

11        默认是否应使查询失活（dehydrate）：`defaultShouldDehydrateQuery(query)`，或查询状态为 `'pending'`

12    }

12    }

13  }

13  }

14});

14});


const searchOptions = (filters) => ({

const searchOptions = (filters) => ({

17  queryKey: ["search", filters],

17  queryKey: ["search", filters],

18  queryFn: () => apiSearch(filters),

18  queryFn: () => apiSearch(filters),

19});

19});

```javascript
export default function SearchPage({ searchParams }) {

export default function 搜索页面({ searchParams }) {

22  const filters = getFiltersFromRawSearchParams(searchParams);

22  const filters = getFiltersFromRawSearchParams(searchParams);

23  // Kick off the query on the server without 'await'

23  // 在服务端发起查询，但不使用 'await'

24  queryClient.prefetchQuery(searchOptions(filters));

24  queryClient.prefetchQuery(searchOptions(filters));

26  return (

26  return (

27    // Pass promise to client

27    // 将 Promise 传递给客户端

28    <HydrationBoundary state={dehydrate(queryClient)}>

28    <HydrationBoundary state={dehydrate(queryClient)}>

29      <ResultsClient />

29      <ResultsClient />

30    </HydrationBoundary>
```

31  );

32}
```

在客户端，`useSuspenseQuery` 会从服务器发起的请求中进行水合（hydrate），并随着数据流式传输而解析。一旦服务器返回的初始数据加载完成，后续所有搜索操作均在客户端执行，以避免不必要的服务器往返。

components/results.tsx

```jsx
1"use client";



import { useSuspenseQuery } from "@tanstack/react-query";

import { searchOptions } from "@/lib/queries";



export function ResultsClient() {

7  const filters = useFilters(); // 客户端过滤器 + 输入状态

8  const { data } = useSuspenseQuery(searchOptions(filters));

9  return <Hits data={data} />;

10}
```

### **使用 TanStack Query 实现渐进式客户端数据获取**

### **使用 TanStack Query 实现渐进式客户端数据获取**

初始服务端渲染完成后，后续的请求（例如由输入、筛选或分页触发）将通过 TanStack Query 的 `useSuspenseQuery` 在客户端执行。为避免发出过多请求，我们使用 React 的 `useDeferredValue` 对输入变更进行防抖处理：

components/results.tsx

```javascript
1'use client';



import { useSuspenseQuery } from '@tanstack/react-query';

```tsx
import { useDeferredValue, Suspense } from 'react';

import { searchQueryOptions } from '@/lib/queries';

import { useNonOptimisticFilters } from '@/hooks/filters';

import { Hits } from '@/components/hits';

import { useDeferredValue, Suspense } from 'react';

导入 { useDeferredValue, Suspense } 从 'react';

import { searchQueryOptions } from '@/lib/queries';

导入 { searchQueryOptions } 从 '@/lib/queries';

import { useNonOptimisticFilters } from '@/hooks/filters';

导入 { useNonOptimisticFilters } 从 '@/hooks/filters';

import { Hits } from '@/components/hits';

导入 { Hits } 从 '@/components/hits';

function ResultsInner({ filters }) {

function ResultsInner({ filters }) {

10  const { data } = useSuspenseQuery(searchQueryOptions(filters));

10  const { data } = useSuspenseQuery(searchQueryOptions(filters));

11  return <Hits data={data} />;

11  返回 <Hits data={data} />;
```

```typescript
export function ResultsClient() {

15  const filters = useNonOptimisticFilters();

15  const filters = useNonOptimisticFilters();

16  const deferredFilters = useDeferredValue(filters);

16  const deferredFilters = useDeferredValue(filters);



18  return (

18  return (

19    <Suspense fallback={<ResultsSkeleton />}>

19    <Suspense fallback={<ResultsSkeleton />}>

20      <ResultsInner filters={deferredFilters} />

20      <ResultsInner filters={deferredFilters} />

21    </Suspense>

21    </Suspense>

22  );

22  );

23}
```

This ensures new results load smoothly while preventing unnecessary network calls during input changes.

这确保了新结果能够平滑加载，同时避免在输入变化期间触发不必要的网络请求。

### **Preventing stale or out-of-order results**

### **防止陈旧或乱序的结果**

Rapid typing introduced another challenge: older network responses sometimes arrive after newer ones, briefly displaying outdated results. For example, typing `"foo"`, then deleting back to `"f"`, could cause `"foo"` results to reappear after `"f"` was already rendered.

快速输入带来了另一个挑战：较早发出的网络响应有时会晚于较新的响应到达，从而短暂地显示过时的结果。例如，先输入 `"foo"`，再退格删减至 `"f"`，就可能导致 `"foo"` 的搜索结果在 `"f"` 的结果已渲染完成后重新出现。

To prevent this, we combined two key strategies:

为防止此类问题，我们结合使用了两种关键策略：

1. **Optimistic UI updates with**`useOptimistic` **:** React’s `useOptimistic` hook handles optimistic state across async updates, ensuring that the UI always reflects the latest user input—regardless of network latency

1. **借助 `useOptimistic` 实现乐观 UI 更新：** React 的 `useOptimistic` Hook 能够在异步更新过程中统一管理乐观状态，确保 UI 始终反映用户最新的输入——无论网络延迟如何。

2. **Query caching with TanStack Query keys:** Using unique cache keys (`["search", filters]`), TanStack Query ensures only the latest request updates the UI, discarding stale responses

2. **基于 TanStack Query 键的查询缓存：** 通过使用唯一缓存键（如 `["search", filters]`），TanStack Query 确保仅最新请求的结果更新 UI，自动丢弃陈旧的响应。

Here’s how we implemented `useOptimistic` alongside React’s `useTransition` for instant, reliable feedback:

以下是我们在实现 `useOptimistic` 的同时，结合 React 的 `useTransition` 来提供即时、可靠反馈的具体方式：

hooks/filters.ts

`hooks/filters.ts`

```javascript
1"use client";

1"use client";
```

```typescript
import { useRouter, usePathname, useSearchParams } from "next/navigation";

import { useOptimistic, useTransition } from "react";



export function useFilters() {

7  const currentFilters = /* ... */;



9  const [optimisticFilters, setOptimisticFilters] = useOptimistic(

10    currentFilters,

11    (_, updatedFilters) => updatedFilters

12  );
```

```typescript
导入 { useRouter, usePathname, useSearchParams } 来自 "next/navigation";

导入 { useOptimistic, useTransition } 来自 "react";



导出函数 useFilters() {

7  const currentFilters = /* ... */;



9  const [optimisticFilters, setOptimisticFilters] = useOptimistic(

10    currentFilters,

11    (_, updatedFilters) => updatedFilters

12  );
```

14  const [isPending, startTransition] = useTransition();

14  const [isPending, startTransition] = useTransition();

16  const updateFilters = (updateFn) => {

16  const updateFilters = (updateFn) => {

17    const newFilters = updateFn(currentFilters);

17    const newFilters = updateFn(currentFilters);

18    setOptimisticFilters(newFilters);

18    setOptimisticFilters(newFilters);

20    // ...

20    // …

21    startTransition(() => {

21    startTransition(() => {

22       router.replace("/search?" + params.toString());

22       router.replace("/search?" + params.toString());

23    });

24  };

26  return { filters: optimisticFilters, updateFilters, isPending };

27}
```

这消除了在快速输入变化期间出现的陈旧或闪烁的搜索结果。

### **预取动态搜索路由**

最后一项优化对于实现瞬时页面跳转至关重要。Next.js 会自动预取静态路由，但不会预取 `/search?q=react` 这样的动态路由。为了使搜索结果呈现“即时”效果，我们显式地预取共享布局：

components/prefetch-search-layout.tsx

```javascript
1"use client";

```typescript
import { useEffect } from "react";

import { useRouter } from "next/navigation";



export function PrefetchSearchLayout() {

7  const router = useRouter();



9  useEffect(() => {

10    router.prefetch("/search?q=");

11  }, [router]);
```

```typescript
import { useEffect } from "react";

import { useRouter } from "next/navigation";



export function PrefetchSearchLayout() {

7  const router = useRouter();



9  useEffect(() => {

10    router.prefetch("/search?q=");

11  }, [router]);
```

13  return null;

14}
```

该组件与首页的搜索栏一同渲染。当用户开始输入并导航至 `/search` 时，布局已预先缓存——使得页面切换感觉瞬时完成，甚至在查询结果返回之前即已完成。

## 解决移动端特有挑战

移动端 Safari 上仍存在一个布局问题：聚焦搜索输入框会引发不可预测的滚动和缩放行为，从而破坏页面布局。为稳定输入框行为，我们引入了一个 `usePreventScroll` 自定义 Hook：

usePreventScroll.tsx

```javascript
1"use client";



import { useEffect } from "react";

```ts
export function usePreventScroll(isFocused: boolean) {

6  useEffect(() => {

7    document.body.style.overflow = isFocused ? "hidden" : "";

8  }, [isFocused]);

9}
```

通过将该 Hook 添加到首页的客户端组件中，可锁定页面的溢出行为，防止布局跳动，从而在移动设备上保持搜索体验的稳定性。

## 利用部分预渲染（Partial Prerendering）进一步提升性能

为更进一步提升 Grep 的性能，我们启用了 Next.js 全新的实验性功能——[部分预渲染（Partial Prerendering, PPR）](https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model)。PPR 将静态预渲染与动态流式传输相结合，在无需重构代码的前提下实现快速的首屏加载。

在启用 PPR 之前，搜索栏的交互性会因客户端水合（hydration）而短暂延迟；启用 PPR 后，搜索体验几乎达到即时响应。

- **Static shell:** Core UI loads instantly, providing immediate visual feedback  
- **静态壳层（Static shell）：** 核心 UI 瞬间加载，提供即时的视觉反馈  

- **Dynamic streaming:** Search results stream in milliseconds later, keeping the page interactive without delay  
- **动态流式渲染（Dynamic streaming）：** 搜索结果在几毫秒后即以流式方式返回，页面全程保持交互性，无任何延迟  

By enabling PPR, we combined static prerendering with dynamic streaming—with no additional code changes. The first-load experience became instant, with search interactivity arriving only milliseconds later. No refactoring. No tradeoffs. Just faster page loads with a single flag.  

启用 PPR 后，我们将静态预渲染与动态流式渲染无缝结合——无需修改任何代码。首屏加载体验变为瞬时完成，搜索交互能力仅需几毫秒即可就绪。无需重构，无需取舍，仅需一个配置标志，即可实现更快的页面加载速度。

[PPR is an experimental feature](https://nextjs.org/docs/app/building-your-application/rendering/partial-prerendering#using-partial-prerendering) only available on canary and is not ready for production use.  

[PPR 是一项实验性功能](https://nextjs.org/docs/app/building-your-application/rendering/partial-prerendering#using-partial-prerendering)，目前仅在 Next.js Canary 版本中提供，尚未达到生产环境可用标准。

## Final results and what’s next for Grep  

## 最终成果及 Grep 的后续规划  

Migrating to Next.js transformed Grep into a fast, search-as-you-type experience—reducing client-side execution while maintaining SPA-level responsiveness.  

迁移到 Next.js 后，Grep 已升级为一款响应迅捷、支持“边输边搜”的搜索工具——在大幅降低客户端执行负担的同时，依然保持单页应用（SPA）级别的响应速度。

- **Instant, persistent input**: The search bar remains focused across pages with no flickers or layout shifts  
- **瞬时、持久的输入体验：** 搜索栏在跨页面跳转时始终保持聚焦状态，无闪烁、无布局偏移  

- **Optimized data fetching**: Server-side prefetching and incremental client-side updates ensure fast, real-time search  
- **优化的数据获取机制：** 服务端预取 + 客户端增量更新，保障快速、实时的搜索体验  

- **Improved performance:** Fewer blocking scripts and targeted hydration reduce bundle sizes and speed up rendering  
- **性能全面提升：** 阻塞脚本更少、水合（hydration）更精准，显著减小包体积并加速页面渲染  

- **Enhanced experience:** While we were at it, we shipped dark mode and expanded our search index from 500,000 to 1,000,000 GitHub repos  
- **体验全面增强：** 借此契机，我们同步上线了深色模式，并将搜索索引覆盖范围从 50 万个 GitHub 仓库扩展至 100 万个

We also achieved measurable performance gains by enabling PPR, leading to faster initial loads by combining static UI with streamed dynamic content. Combined with broader improvements from migrating to Next.js, the result was a faster, more stable experience—especially on mobile.

我们还通过启用 PPR（Partial Pre-Rendering）实现了可衡量的性能提升，该技术将静态 UI 与流式动态内容相结合，从而加快了初始加载速度。再结合迁移到 Next.js 带来的整体优化，最终显著提升了应用速度与稳定性——尤其在移动设备上表现更为突出。

| Metric | CRA (Mobile) | Next.js (Mobile) | Results |
| --- | --- | --- | --- |
| First Contentful Paint (FCP) | 3.0 seconds | 0.9 seconds | 70% faster |
| 首次内容绘制（FCP） | 3.0 秒 | 0.9 秒 | 提升 70% |
| Largest Contentful Paint (LCP) | 3.7 seconds | 3.2 seconds | 13.51% faster |
| 最大内容绘制（LCP） | 3.7 秒 | 3.2 秒 | 提升 13.51% |
| Speed Index | 4.7 seconds | 2.9 seconds | 38.3% faster |
| 速度指数（Speed Index） | 4.7 秒 | 2.9 秒 | 提升 38.3% |
| Network Request Finish | 1.49 seconds | 0.4 seconds | 73.15% faster |
| 网络请求完成时间 | 1.49 秒 | 0.4 秒 | 提升 73.15% |

The results show good improvement due to smarter, more flexible rendering strategies and the ability to fetch data on the server. With this new, stable foundation established, we’re already exploring further improvements:

上述结果表明，得益于更智能、更灵活的渲染策略，以及服务端数据获取能力，整体性能已取得显著进步。在此全新且稳定的基础之上，我们已在积极探索以下进一步优化方向：

- **Private repository indexing**: Secure authentication for private code search, using serverless functions and Edge Middleware for security  
- **私有仓库索引**：借助无服务器函数（serverless functions）与边缘中间件（Edge Middleware）实现安全认证，支持私有代码搜索  

- **Advanced query syntax**: Support for GitHub-style filters like `repo:vercel/next.js` or `language:typescript`  
- **高级查询语法**：支持 GitHub 风格的过滤器，例如 `repo:vercel/next.js` 或 `language:typescript`

The move to Next.js wasn’t just about performance—it was about setting Grep up for the future. Faster queries, smoother interactions, and a stronger foundation for what’s next.

迁移到 Next.js 并不仅仅关乎性能提升——更是为 Grep 的未来发展铺平道路。更快的查询响应、更流畅的交互体验，以及更坚实的技术基础，共同支撑着“下一步”的无限可能。

[Try Grep](http://grep.app/) for yourself.

[立即体验 Grep](http://grep.app/)