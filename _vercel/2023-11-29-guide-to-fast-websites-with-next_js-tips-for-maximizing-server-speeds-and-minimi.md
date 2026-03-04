---
title: "Guide to fast websites with Next.js: Tips for maximizing server speeds and minimizing client burden - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/guide-to-fast-websites-with-next-js-tips-for-maximizing-server-speeds"
date: "2023-11-29"
scraped_at: "2026-03-02T09:49:19.276993914+00:00"
language: "en-zh"
translated: true
description: "A collection of tips to make faster Next.js websites by maximizing work on the server and minimizing the burden on the client."
---
{% raw %}

Nov 29, 2023

2023 年 11 月 29 日

Tinloof 联合创始人 Seif Ghezala 分享了其团队如何依据最佳实践测量网站速度，并打造更快的网站。

[Tinloof](https://tinloof.com/) 是一家专注于交付高速网站的数字机构，服务客户包括珠宝品牌 [Jennifer Fisher](https://jenniferfisher.com/) —— 该品牌网站从基于 Shopify 的主题模板，重构为现代化的 [Next.js](https://nextjs.org/) 应用，实现秒级加载，且 JavaScript 体积减少 80%。

在评估网站速度时，他们聚焦于典型用户旅程中的几项关键指标：

1. **服务器响应时间（Server response time）：** 用户访问页面后，首次获得任何反馈所需的时间。

2. **页面渲染时间（Page render time）：** 页面完全呈现并具备完整交互能力所需的时间。

3. **用户交互时间（User interaction time）：** 用户完成关键操作（例如页面跳转或加入购物车）所需的时间。

本文将介绍一系列实用技巧，帮助您精准测量并极致优化用户旅程中每一环节的速度表现。

## **网站速度基础：如何正确测量数据**

## **网站速度的基础：正确地测量数据**

让您的网站不仅“快”，而且在任意设备、面向任意用户时都能持续保持“快”的核心，在于——数据。

Speed is more than just a way to gauge user experience, it's crucial for getting the top spot on any search platform and winning organic page views.

速度不仅是一种衡量用户体验的方式，更是赢得任何搜索平台首页排名、获取自然流量的关键。

To ensure they're measuring the right data correctly, tools like [Google PageSpeed Insights](https://pagespeed.web.dev/) and [Vercel Speed Insights](https://vercel.com/docs/speed-insights) are able to provide objective metrics. These tools can be used to diagnose page performance issues, providing insights into aspects like loading times, interactivity, and visual stability.

为确保准确测量关键数据，[Google PageSpeed Insights](https://pagespeed.web.dev/) 和 [Vercel Speed Insights](https://vercel.com/docs/speed-insights) 等工具可提供客观的性能指标。这些工具可用于诊断页面性能问题，并深入分析加载时间、交互响应性及视觉稳定性等维度。

It's also equally important to test the user journey under various network conditions.

同样重要的是，在不同网络条件下测试用户旅程。

Combining objective tools with a hands-on approach provides a comprehensive view of a website experience, ensuring it’s optimised for all users.

将客观工具与亲身体验式测试相结合，能够全面评估网站体验，从而确保其对所有用户均经过充分优化。

[**Vercel Speed Insights**\\
\\
Learn how to get a detailed view of your website's performance metrics to help facilitate informed decisions on optimization. \\
\\
Get Started](https://vercel.com/docs/speed-insights)

[**Vercel Speed Insights**\\
\\
了解如何获取您网站性能指标的详细视图，以支持您在性能优化方面做出明智决策。\\
\\
立即开始](https://vercel.com/docs/speed-insights)

## How to speed up server response: Make use of Next.js’ rendering toolbox

## 如何提升服务器响应速度：善用 Next.js 的渲染工具箱

Once key performance metrics are evaluated, the team is able to pinpoint where and how to make improvements in things like server response.

在完成关键性能指标评估后，团队即可精准定位服务器响应等环节的优化点与改进方式。

### When possible: Pre-render the entire page

### 在可行情况下：全页预渲染

Pre-rendering the page at build-time ensures it is served from a CDN instead of your origin server, resulting in the fastest server response possible. This is done automatically by Next.js if you don’t use the `edge` runtime and the page doesn’t rely on cookies, headers, or search parameters.

在构建时预渲染页面，可确保页面直接从 CDN 而非源服务器提供服务，从而实现最快的服务器响应。只要您未使用 `edge` 运行时，且页面不依赖 cookie、请求头或查询参数，Next.js 就会自动执行此操作。

### Else: Partial Prerender

### 否则：部分预渲染

Pre-rendering an entire page might not be always possible.

对整个页面进行预渲染并不总是可行的。

With [Partial Prerendering](https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model) (PPR) in Next.js, it's possible to pre-render a shell of the page that is served from a CDN while streaming the dynamic bits at the same time.

借助 Next.js 中的 [部分预渲染](https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model)（Partial Prerendering，简称 PPR），你可以预渲染页面的“外壳”（shell），该外壳由 CDN 提供服务；与此同时，动态内容则通过流式传输（streaming）方式实时加载。

Partial Prerendering is currently [an experimental feature](https://twitter.com/leeerob/status/1723039087391543654) that allows you to render a route with a static loading shell, while keeping some parts dynamic. In other words, you can isolate the dynamic parts of a page instead of a whole route.

目前，部分预渲染仍是一项 [实验性功能](https://twitter.com/leeerob/status/1723039087391543654)，它允许你以静态加载外壳（static loading shell）渲染某个路由，同时保留其中部分区域的动态性。换言之，你可将页面中的动态部分单独隔离出来，而无需让整个路由都变为动态。

### Final resort: Render a loading shell while waiting for the final response

### 最后手段：在等待最终响应期间渲染加载外壳（loading shell）

When a page is rendered at request time, it’s better to immediately show the user a UI hint that indicates a page is loading, rather than unresponsive links.

当页面在请求时动态渲染（on-demand rendering）时，相比呈现无响应的链接，更佳的做法是立即向用户展示一个 UI 提示，表明页面正在加载中。

It’s best to make the loading UI resemble as much as possible the final one.

最佳实践是让加载 UI 尽可能接近最终页面的外观与布局。

In Next.js, there are two places where you can render the loading UI:

Next.js 提供了两处可渲染加载 UI 的位置：

- In a [loading.tsx](https://nextjs.org/docs/app/building-your-application/routing/loading-ui-and-streaming) file inside the page route folder.

- 在页面路由文件夹内创建一个 [loading.tsx](https://nextjs.org/docs/app/building-your-application/routing/loading-ui-and-streaming) 文件。

- Inside the fallback prop of the [Suspense boundary](https://nextjs.org/docs/app/building-your-application/routing/loading-ui-and-streaming#streaming-with-suspense) that wraps async component making requests inside the page.

- 在包裹页面内发起异步请求的组件的 [Suspense 边界](https://nextjs.org/docs/app/building-your-application/routing/loading-ui-and-streaming#streaming-with-suspense) 的 `fallback` 属性中。

### Cache fetch requests for fast server responses when using loading spinners

### 为加载指示器（loading spinner）启用 fetch 请求缓存，以加快服务端响应速度

Loading shells are not an excuse for slow server responses. Most server responses can be cached instead of making the user wait for them on every page visit.

加载占位符（loading shells）并不能成为服务器响应缓慢的借口。大多数服务器响应都可以被缓存，从而避免用户在每次访问页面时都不得不等待响应。

Although this is the default behaviour of `fetch` requests in Next.js, you can still control the freshness of this data:

尽管这是 Next.js 中 `fetch` 请求的默认行为，你仍可自主控制该数据的新鲜度：

- By revalidating the server response every x number seconds.

- 每隔 x 秒重新验证一次服务器响应。

app/page.tsx

```tsx
export default function Home() {

2  // The CMS data is guaranteed to be fresh every 2 minutes

3  const cmsData = await fetch(`https://...`, { next: { revalidate: 120 } });



5  return <h1>{cmsData.title}</h1>

6}
```

- Or by revalidating the server response when a certain event happens. Here’s an example where a CMS response is revalidated whenever a new CMS page gets published.

- 或者，在特定事件发生时重新验证服务器响应。以下示例展示了每当发布新的 CMS 页面时，如何重新验证 CMS 响应。

app/page.tsx

```jsx
export default function Home() {

2 // The CMS data is cached until the tag is revalidated

3  const cmsData = await fetch(`https://...`, { next: { tags: ['landing-page']);



5  return <h1>{cmsData.title}</h1>

6}
```

app/page.tsx

```jsx
export default function Home() {

2 // CMS 数据将被缓存，直至该标签被重新验证

3  const cmsData = await fetch(`https://...`, { next: { tags: ['landing-page']);



5  return <h1>{cmsData.title}</h1>

6}
```

app/api/revalidate/route.ts

```tsx
import { revalidateTag } from 'next/cache';
```

app/api/revalidate/route.ts

```tsx
import { revalidateTag } from 'next/cache';
```

```typescript
import { NextRequest, NextResponse } from 'next/server';

import { NextRequest, NextResponse } from 'next/server';

export async function POST(req: NextRequest): Promise<NextResponse> {

export async function POST(req: NextRequest): Promise<NextResponse> {

5  const secret = req.nextUrl.searchParams.get('secret');

5  const secret = req.nextUrl.searchParams.get('secret');

6  const tag = req.nextUrl.searchParams.get('landing-page');

6  const tag = req.nextUrl.searchParams.get('landing-page');

8  if(!tag || !isValid(secret)) {

8  如果 `tag` 为空或 `secret` 无效，则：

9		return NextResponse.json({ status: 400});

9		返回状态码为 400 的 JSON 响应。

10  }

10  }
```

12  return revalidate(tag);

13}
```

The [Next.js guide on caching and revalidation](https://nextjs.org/docs/app/building-your-application/data-fetching/fetching-caching-and-revalidating) and the [App Router explainer video](https://www.youtube.com/watch?v=gSSsZReIFRk&t=577s&ab_channel=Vercel) are perfect to help understand these concepts.

[Next.js 关于缓存与重新验证的指南](https://nextjs.org/docs/app/building-your-application/data-fetching/fetching-caching-and-revalidating) 和 [App Router 解析视频](https://www.youtube.com/watch?v=gSSsZReIFRk&t=577s&ab_channel=Vercel) 是深入理解这些概念的理想学习资源。

## How to speed up the page render: Minimize client burden

## 如何加快页面渲染：最小化客户端负担

**Short answer:** Make the browser do the least amount of work to render the page.

**简明回答：** 让浏览器在渲染页面时执行尽可能少的工作。

Once the browser receives a response from the server, it still has to paint the entire page and make it ready for user interactions (e.g. button clicks).

当浏览器从服务器接收到响应后，仍需完成整页的绘制，并使其具备响应用户交互（例如按钮点击）的能力。

While parsing the HTML and rendering, the browser is also downloading resources such as CSS, JavaScript, font, or image files.

在解析 HTML 并进行渲染的同时，浏览器还会下载各类资源，例如 CSS、JavaScript、字体或图像文件。

The following tips help make page render fast by making the browser do as little work as possible.

以下建议可通过最大限度减少浏览器所需执行的工作量，从而加快页面渲染速度。

### Reduce the JavaScript bundle size and minimize the impact of hydration

### 减小 JavaScript 包体积，并降低水合（hydration）的影响

The JavaScript shipped with React websites usually consists of React, Next.js, the application code including the JSX of every single React component, and third-party dependencies.

React 网站所交付的 JavaScript 通常包含 React 框架本身、Next.js 运行时、应用代码（含每个 React 组件的 JSX）、以及第三方依赖库。

Once the page HTML is rendered and the JavaScript is downloaded, React goes through a process called “ [hydration](https://chat.openai.com/share/4bf8f74b-1681-40c6-aae3-dc1ae00013db)” where it attaches event listeners and state to the components of the page.

当页面 HTML 渲染完成且 JavaScript 下载完毕后，React 会执行一个称为“[水合（hydration）](https://chat.openai.com/share/4bf8f74b-1681-40c6-aae3-dc1ae00013db)”的过程，为页面中的各个组件挂载事件监听器并初始化状态。

Just by using [React Server Components](https://nextjs.org/docs/app/building-your-application/rendering/server-components) you already get a speed bump because:

仅通过使用 [React Server Components](https://nextjs.org/docs/app/building-your-application/rendering/server-components)，你就能获得性能提升，原因如下：

1. Their JavaScript (including application code, JSX, and third-party dependencies) is not shipped to the browser.

1. 它们的 JavaScript（包括应用代码、JSX 及第三方依赖）不会发送至浏览器。

2. React skips their hydration.

2. React 跳过对它们的水合（hydration）过程。

When a component requires interactivity (e.g. state, event listeners), a `use client` directive can be used to convert it to a client component which in addition of being rendered in the server, also has its JavaScript shipped to the browser and is hydrated by React.

当某个组件需要交互能力（例如：状态管理、事件监听器）时，可使用 `use client` 指令将其转换为客户端组件——该组件不仅在服务端渲染，其 JavaScript 代码也会被发送至浏览器，并由 React 进行水合（hydration）。

## Reduce the impact of client components on page speed

## 降低客户端组件对页面加载速度的影响

### Only use client components when necessary

### 仅在必要时使用客户端组件

URLs can be used to store a component state without having to make it a client component that relies on React’s state.

可通过 URL 存储组件状态，从而避免将其设为依赖 React 状态的客户端组件。

It requires less code to manage the state, turns state buttons to links that work even without JavaScript, and makes it possible to persist the state on page refresh or when sharing the URL.

这种方式所需的状态管理代码更少；可将状态切换按钮转化为即使禁用 JavaScript 也能正常工作的链接；并且支持在页面刷新或分享 URL 时持久化状态。

### Place client components in the leaves of the page tree

### 将客户端组件置于页面树的叶节点位置

To minimize the JavaScript footprint of imported child components, it’s a good practice to place client components the furthest possible at the bottom of the components tree.

为最小化所导入子组件的 JavaScript 体积，最佳实践是将客户端组件尽可能置于组件树的最底层。

### Be mindful of third-party dependencies’ bundle sizes

### 注意第三方依赖的包体积

Any client component dependency is more JavaScript for the browser to download, parse, and execute.

任何客户端组件的依赖都会增加浏览器需要下载、解析和执行的 JavaScript 代码量。

Tools such as [pkg-size](https://pkg-size.dev/) can be used to determine the size impact of NPM packages based on what’s imported from them and help decide between alternatives.

诸如 [pkg-size](https://pkg-size.dev/) 之类的工具可根据实际从 NPM 包中导入的内容，评估其对最终包体积的影响，从而辅助你在多个备选方案之间做出取舍。

![](images/guide-to-fast-websites-with-next_js-tips-for-maximizing-server-speeds-and-minimi/img_001.jpg)

### Lazy-load client components when possible

### 在可能的情况下懒加载客户端组件

Even when a client component is necessarily heavy, it’s still possible to only download its JavaScript once it’s rendered.

即使某个客户端组件本身必然较重，我们仍可做到仅在其被渲染时才下载其 JavaScript 代码。

For example, [the stockists page on Jennifer Fisher](https://jenniferfisher.com/pages/stockists) uses `mapbox-gl`, an extremely heavy package, to display interactive maps.

例如，[Jennifer Fisher 官网的销售商页面](https://jenniferfisher.com/pages/stockists) 使用了 `mapbox-gl`（一个极其庞大的包）来渲染交互式地图。

Since `mapbox-gl` is only used to display maps, its wrapper client component is lazy-loaded so the package bundle is only downloaded when the component is rendered.

由于 `mapbox-gl` 仅用于显示地图，其封装用的客户端组件采用了懒加载方式，确保该包的代码仅在组件实际渲染时才被下载。

You can lazy-load a client component either via `next/dynamic` or a combination of `React.lazy` and `Suspense` , more details can be found on [Next.js guide on the topic](https://nextjs.org/docs/app/building-your-application/optimizing/lazy-loading).

你可以通过 `next/dynamic`，或结合使用 `React.lazy` 与 `Suspense` 来实现客户端组件的懒加载。更多详细信息请参阅 [Next.js 关于该主题的官方指南](https://nextjs.org/docs/app/building-your-application/optimizing/lazy-loading)。

### Efficiently load third-party scripts

### 高效加载第三方脚本

Some third-party dependencies like Google Tag Manager are injected via script tags instead of imports in client components.

一些第三方依赖（例如 Google Tag Manager）是通过 `<script>` 标签注入的，而非在客户端组件中以 `import` 方式引入。

[@next/third-parties](https://nextjs.org/docs/app/building-your-application/optimizing/third-party-libraries) can be used to reduce their impact on page render speed and if dependency is not supported, [next/script](https://nextjs.org/docs/app/api-reference/components/script) is also a great option.

可使用 [@next/third-parties](https://nextjs.org/docs/app/building-your-application/optimizing/third-party-libraries) 来降低其对页面渲染速度的影响；若某依赖未被该包支持，[next/script](https://nextjs.org/docs/app/api-reference/components/script) 也是一个极佳的替代方案。

## How to load fonts more efficiently

## 如何更高效地加载字体

Some web fonts are unnecessarily heavy because they include characters not even needed by the website.

某些网页字体体积过大，原因在于它们包含了网站根本用不到的字符。

In the case of Jennifer Fisher, Tinloof was able to trim out more than 50% of font files using tools such as [transfonter](https://transfonter.org/).

以 Jennifer Fisher 网站为例，Tinloof 借助 [transfonter](https://transfonter.org/) 等工具成功将字体文件体积削减了 50% 以上。

[next/font](https://nextjs.org/docs/app/building-your-application/optimizing/fonts) makes it possible to load local and Google Fonts while providing the following optimizations:

[next/font](https://nextjs.org/docs/app/building-your-application/optimizing/fonts) 支持加载本地字体和 Google Fonts，并提供以下优化能力：

1. Only load fonts on pages where they are used.

1. 仅在实际使用字体的页面上加载对应字体。

2. [Preload](https://web.dev/articles/codelab-preload-web-fonts) fonts to make them available early on when rendering.

2. [预加载（Preload）](https://web.dev/articles/codelab-preload-web-fonts) 字体，使其在页面渲染初期即可就绪。

3. Use display strategies such as [swap](https://developer.mozilla.org/en-US/docs/Web/CSS/@font-face/font-display) to avoid blocking text rendering by using a fallback font.

3. 使用 `font-display` 等显示策略（例如 [swap](https://developer.mozilla.org/en-US/docs/Web/CSS/@font-face/font-display)），通过回退字体避免阻塞文本渲染。

## How to load images more efficiently

## 如何更高效地加载图片

**Short answer:** use [next/image](https://nextjs.org/docs/app/building-your-application/optimizing/images) when you can.

**简短回答：** 尽可能使用 [next/image](https://nextjs.org/docs/app/building-your-application/optimizing/images)。

The `next/image` component provides so many optimizations for local or remote images.

`next/image` 组件为本地或远程图片提供了大量优化功能。

A detailed guide is available on [Next.js docs](https://nextjs.org/docs/app/building-your-application/optimizing/images) so I’ll only highlight some of them:

详细的使用指南请参阅 [Next.js 官方文档](https://nextjs.org/docs/app/building-your-application/optimizing/images)，此处仅重点介绍其中几项：

1. Images are automatically served in modern efficient formats such as AVIF or WebP that preserve quality and dramatically reduce the download size.

1. 图片会自动以现代高效的格式（如 AVIF 或 WebP）提供，既保持画质，又显著减小下载体积。

2. Images are only loaded when visible in the viewport and a `lazy` boolean prop is available  
[to do the opposite for critical images](https://web.dev/articles/lcp-lazy-loading).

2. 图片仅在进入视口时才加载；同时提供 `lazy` 布尔型属性，  
[以便对关键图片禁用懒加载](https://web.dev/articles/lcp-lazy-loading)。

3. A `preload` prop is available to make the browser load critical images ASAP.

3. 提供 `preload` 属性，使浏览器能尽快预加载关键图片。

4. Images are automatically served in different sizes based on the viewport and props such as `sizes` or `loader` are available to customise the behaviour.

4. 图片会根据视口尺寸自动提供不同尺寸的版本；同时支持 `sizes` 和 `loader` 等属性，用于自定义行为。

5. Local images can automatically show a placeholder while loading and you can provide a

5. 本地图片在加载过程中可自动显示占位符，你也可以自定义占位符。

`blurDataURL` to achieve the same with remote images.

使用 `blurDataURL` 可对远程图片实现相同效果。

The `next/image` component is just a very handy utility and is not required to achieve the benefits above:

`next/image` 组件仅是一个非常便捷的工具，并非实现上述优化效果所必需：

1. Images can still be served in modern formats by using CDNs that can convert them on the fly.

1. 仍可通过支持实时转码的 CDN，以现代图像格式（如 WebP、AVIF）提供图片。

2. Lazy-loading images is a native browser attribute that can be used by default.

2. 图片懒加载是浏览器原生支持的属性，可直接默认启用。

3. Images can be preloaded using a preload link

3. 可通过预加载链接 `<link rel="preload" as="image" href="..." />` 在文档的 `<head>` 中，或使用 `ReactDOM.preload` 提前加载图片。

`<link rel="preload" as="image" href="..." />` in the document’s `head` or using `ReactDOM.preload.`

4. When loading images from a different domain, it’s a good practice to use

4. 当从不同域名加载图片时，建议使用 [预连接链接（preconnect links）](https://web.dev/articles/preconnect-and-dns-prefetch)，以便浏览器尽早与图片服务提供商的域名建立连接。

[preconnect links](https://web.dev/articles/preconnect-and-dns-prefetch) to inform the browser to establish a connection with the image provider domain early-on.


## How to load videos more efficiently

## 如何更高效地加载视频

Solutions such as [Mux](https://www.mux.com/blog/multi-cdn-support-in-mux-video-for-improved-performance-and-reliability), [Cloudinary](https://cloudinary.com/), or CDNs such as [Fastly](https://www.fastly.com/products/streaming-media/video-on-demand) can be used to help optimise video delivery by serving videos as close as possible to users.

可采用 [Mux](https://www.mux.com/blog/multi-cdn-support-in-mux-video-for-improved-performance-and-reliability)、[Cloudinary](https://cloudinary.com/) 等解决方案，或 [Fastly](https://www.fastly.com/products/streaming-media/video-on-demand) 等支持流媒体的 CDN，通过将视频尽可能就近分发给用户，从而优化视频传输性能。

A poster image is a must-have for any video and you can either manually set it or easily extract the first frame of the video to be the poster image when using any video CDN.

视频海报图（poster image）是任何视频的必备元素；使用任意视频 CDN 时，您既可手动指定海报图，也可轻松提取视频的第一帧作为海报图。

The best part is that you can use the same image optimizations tips discussed earlier to render the poster image efficiently.

最棒的是，您可以沿用前文讨论过的相同图片优化技巧，高效地渲染海报图。

Here’s an example Mux video component that utilises these optimizations and it’s only rendered on the server:

以下是一个利用了这些优化措施的 Mux 视频组件示例，且该组件仅在服务端渲染：

```tsx
import { preload } from "react-dom";

import { unstable_getImgProps as getImgProps } from "next/image";

type Props = {
  playbackId: string;
  loading: "lazy" | "eager";
  resolution: "SD" | "HD";
}
```

8};



export default function MuxVideo({ playBackId, loading, loading }: Props) {

8}；



export default function MuxVideo({ playBackId, loading, loading }: Props) {

11  const mp4Url = `https://stream.mux.com/${playbackId}/${

11  const mp4Url = `https://stream.mux.com/${playbackId}/${

12    resolution === "SD" ? "medium" : "high"

12    resolution === "SD" ? "medium" : "high"

13  }.mp4`;

13  }.mp4`;



15  const webmUrl = `https://stream.mux.com/${playbackId}/${

15  const webmUrl = `https://stream.mux.com/${playbackId}/${

16    resolution === "SD" ? "medium" : "high"

16    resolution === "SD" ? "medium" : "high"

17  }.webm`;

17  }.webm`;

19  // Use `getImgProps` to convert the video poster image to WebP  
19  // 使用 `getImgProps` 将视频封面图转换为 WebP 格式  

20  const {  
20  const {  

21    props: { src: poster },  
21    props: { src: poster },  

22  } = getImgProps({  
22  } = getImgProps({  

23    src: `https://image.mux.com/${playbackId}/thumbnail.webp?fit_mode=smartcrop&time=0`,  
23    src: `https://image.mux.com/${playbackId}/thumbnail.webp?fit_mode=smartcrop&time=0`,  

24    alt: "",  
24    alt: "",  

25    fill: true,  
25    fill: true,  

26  });  
26  });

28  // 在适用时预加载海报图

28  // Preload the poster when applicable

29  if (loading === "eager") {

29  如果加载策略为“立即加载”（eager）：

30    preload(poster, {

30    preload(poster, {

31      as: "image",

31      as: "image",

32      fetchPriority: "high",

32      fetchPriority: "high",

33    });

33    });

34  }

34  }

36  return (

36  return (

37    <video

37    <video

38      autoPlay

38      自动播放

39      playsInline

39      内联播放

40      loop

40      循环播放

41      controls={false}

41      controls={false}

42      muted

42      静音

43      preload="none"

43      preload="none"

44    >

44    >

45      <source src={mp4Url} type="video/mp4" />

45      <source src={mp4Url} type="video/mp4" />

46      <source src={webmUrl} type="video/webm" />

46      <source src={webmUrl} type="video/webm" />

47    </video>

47    </video>

48  );

49}
```

对于无需立即加载的视频，你可以采用懒加载方式，从而避免任何布局偏移（layout shift）：

```tsx
1'use client';



import Image from 'next/image';

import { useEffect, useState } from 'react';

import useInView from '~/hooks/useInView';

import Video, { VideoProps } from './Video';

```tsx
export default function LazyLoadedVideo(props: VideoProps) {

export default function LazyLoadedVideo(props: VideoProps) {

9  const { ref, inView } = useInView({ triggerOnce: true });

9  const { ref, inView } = useInView({ triggerOnce: true });

11  return (

11  return (

12    <>

12    <>

13      {!inView ? (

13      {!inView ? (

14        <Image

14        <Image

15          ref={ref as React.RefObject<HTMLImageElement>}

15          ref={ref as React.RefObject<HTMLImageElement>}

16          alt={'Video poster'}

16          alt={'视频封面图'}

17          src={props.poster ?? ''}

17          src={props.poster ?? ''}
```

18          className={props.className}

18          className={props.className}

19          style={props.style}

19          style={props.style}

20          loading={'lazy'}

20          loading={'lazy'}

21          layout="fill"

21          layout="fill"

22        />

22        />

23      ) : (

23      ) : (

24        <Video {...props} />

24        <Video {...props} />

25      )}

25      )}

26    </>

26    </>

27  );

27  );

28}
```

## How to reduce the HTML document size

## 如何减小 HTML 文档体积

The HTML document is a critical resource the browser has to download and parse.

HTML 文档是浏览器必须下载并解析的关键资源。

### **Use virtualization**

### **使用虚拟化（Virtualization）**

Components such as carousels/sliders, tables, and lists are also usual culprits.

轮播图/滑块、表格和列表等组件也常常是导致性能问题的“元凶”。

You can use libraries such [TanStack Virtual](https://tanstack.com/virtual/v3) to only render items when they are visible in the viewport while avoiding any layout shifts.

你可以使用诸如 [TanStack Virtual](https://tanstack.com/virtual/v3) 这样的库，仅在元素进入视口时才渲染它们，从而避免任何布局偏移（layout shifts）。

## How to speed up user interactions

## 如何加快用户交互响应速度

**Short answer:** Provide feedback to the user as early as possible.

**简答：** 尽可能早地向用户提供反馈。

Some user interactions such as URL state navigations when filtering or adding an item to the cart rely on server responses, which are not always immediate, causing slow interactions or leaving the user puzzled on whether something went wrong.

某些用户交互（例如筛选时的 URL 状态跳转，或向购物车添加商品）依赖服务器响应——而这些响应并不总是即时的，从而导致交互迟缓，甚至让用户困惑：究竟是否出错了？

Optimistic UI techniques can be used to make such interactions snappy and provide immediate feedback to users.

此时可采用乐观 UI（Optimistic UI）技术，让这类交互变得迅捷，并立即向用户提供反馈。

The idea is to use JavaScript to show the predicted result to the user without waiting the server to return a response.

该思路是利用 JavaScript 向用户即时展示预测结果，而无需等待服务器返回响应。

It can be achieved either through normal React state management or using [React’s useOptimistic hook](https://nextjs.org/docs/app/building-your-application/data-fetching/forms-and-mutations#optimistic-updates).

这既可通过常规的 React 状态管理实现，也可借助 [React 的 `useOptimistic` Hook](https://nextjs.org/docs/app/building-your-application/data-fetching/forms-and-mutations#optimistic-updates) 完成。

## The importance of a performant website

## 高性能网站的重要性

Fast websites are more pleasant to use, more engaging to users, and it’s no surprise they directly impact success metrics such as conversion rate and search engine indexation.

加载迅速的网站使用体验更佳，对用户更具吸引力；毫不意外，它们会直接影响转化率、搜索引擎索引等关键成功指标。

Although the tips above are focused on Next.js, the concepts behind them can be used to make any website faster.

尽管上述优化建议聚焦于 Next.js，但其背后的核心理念同样适用于提升任意网站的性能。

[**Want to talk to an expert?**\\
\\
Brainstorm with our team about your unique use case of Next.js.\\
\\
Send us a message](https://vercel.com/contact/sales)

[**想与专家交流？**\\
\\
与我们的团队一起，围绕您在 Next.js 中的独特应用场景展开头脑风暴。\\
\\
给我们发送消息](https://vercel.com/contact/sales)

[![Will Thomson](images/guide-to-fast-websites-with-next_js-tips-for-maximizing-server-speeds-and-minimi/img_002.jpg)](https://x.com/willthomson__/status/1704137045159911477)

[![威尔·汤姆森](images/guide-to-fast-websites-with-next_js-tips-for-maximizing-server-speeds-and-minimi/img_002.jpg)](https://x.com/willthomson__/status/1704137045159911477)

[Will Thomson](https://x.com/willthomson__/status/1704137045159911477)

[威尔·汤姆森](https://x.com/willthomson__/status/1704137045159911477)


· [Follow](https://x.com/intent/follow?screen_name=willthomson__)

· [关注](https://x.com/intent/follow?screen_name=willthomson__)

[View on Twitter](https://x.com/willthomson__/status/1704137045159911477)

[在 Twitter 上查看](https://x.com/willthomson__/status/1704137045159911477)

Caching turns god-mode on for your website.

缓存为您的网站开启“上帝模式”。

Look at the speed of [@Tinloof](https://x.com/Tinloof)'s website.

看看 [@Tinloof](https://x.com/Tinloof) 网站的加载速度。

You type, hit enter, site appears.

您输入网址，按下回车键，网站瞬间呈现。

No loading spinners. No waiting.

没有加载旋转图标，无需等待。

Optimisation is why I choose code over no-code.

正是优化能力，让我选择手写代码而非无代码方案。

P.S They have epic developer resources on their site.

附言：他们的网站上提供了极为出色的开发者资源。

[Watch on X](https://x.com/willthomson__/status/1704137045159911477)

[在 X 上观看](https://x.com/willthomson__/status/1704137045159911477)

[10:15 AM · Sep 19, 2023](https://x.com/willthomson__/status/1704137045159911477) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[上午 10:15 · 2023 年 9 月 19 日](https://x.com/willthomson__/status/1704137045159911477) [面向网站的 X（原 Twitter）服务、广告信息与隐私政策](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[25](https://x.com/intent/like?tweet_id=1704137045159911477) [Reply](https://x.com/intent/tweet?in_reply_to=1704137045159911477)

[25 次点赞](https://x.com/intent/like?tweet_id=1704137045159911477) [回复](https://x.com/intent/tweet?in_reply_to=1704137045159911477)


[Read 4 replies](https://x.com/willthomson__/status/1704137045159911477)

[查看 4 条回复](https://x.com/willthomson__/status/1704137045159911477)

[![Alex Sidorenko](images/guide-to-fast-websites-with-next_js-tips-for-maximizing-server-speeds-and-minimi/img_003.jpg)](https://x.com/asidorenko_/status/1696549318495178887)

[![Alex Sidorenko](images/guide-to-fast-websites-with-next_js-tips-for-maximizing-server-speeds-and-minimi/img_003.jpg)](https://x.com/asidorenko_/status/1696549318495178887)

[Alex Sidorenko](https://x.com/asidorenko_/status/1696549318495178887)

[Alex Sidorenko](https://x.com/asidorenko_/status/1696549318495178887)

· [Follow](https://x.com/intent/follow?screen_name=asidorenko_)

· [关注](https://x.com/intent/follow?screen_name=asidorenko_)

[View on Twitter](https://x.com/asidorenko_/status/1696549318495178887)

在 Twitter 上查看

"I have one server component that fetches a lot of data and makes the entire page slow to load in Next.js 13"

“我在 Next.js 13 中有一个服务端组件，它需要获取大量数据，导致整个页面加载变慢。”

Wrap it with Suspense

用 `<Suspense>` 包裹它

[Watch on X](https://x.com/asidorenko_/status/1696549318495178887)

在 X 上观看

[11:44 AM · Aug 29, 2023](https://x.com/asidorenko_/status/1696549318495178887) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[2023年8月29日 上午11:44](https://x.com/asidorenko_/status/1696549318495178887) [X 网站版、广告信息与隐私政策](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[934](https://x.com/intent/like?tweet_id=1696549318495178887) [Reply](https://x.com/intent/tweet?in_reply_to=1696549318495178887)

[934 次点赞](https://x.com/intent/like?tweet_id=1696549318495178887) [回复](https://x.com/intent/tweet?in_reply_to=1696549318495178887)

[Read 18 replies](https://x.com/asidorenko_/status/1696549318495178887)

阅读 18 条回复

[![Guillermo Rauch](images/guide-to-fast-websites-with-next_js-tips-for-maximizing-server-speeds-and-minimi/img_004.jpg)](https://x.com/rauchg/status/1696944713708757065)

[![吉列尔莫·劳赫（Guillermo Rauch）](images/guide-to-fast-websites-with-next_js-tips-for-maximizing-server-speeds-and-minimi/img_004.jpg)](https://x.com/rauchg/status/1696944713708757065)

[Guillermo Rauch](https://x.com/rauchg/status/1696944713708757065)

[吉列尔莫·劳赫（Guillermo Rauch）](https://x.com/rauchg/status/1696944713708757065)


· [Follow](https://x.com/intent/follow?screen_name=rauchg)

· [关注](https://x.com/intent/follow?screen_name=rauchg)

[View on Twitter](https://x.com/rauchg/status/1696944713708757065)

[在 Twitter 上查看](https://x.com/rauchg/status/1696944713708757065)

We moved our Web Analytics dashboard pages to [@nextjs](https://x.com/nextjs) App Router and shaved off 800ms of LCP.

我们将 Web Analytics 仪表板页面迁移至 [@nextjs](https://x.com/nextjs) App Router，使最大内容绘制（LCP）时间缩短了 800 毫秒。

What a time to be alive.

生逢其时，何其幸哉！

[![Web Analytics running on App Router is much faster](images/guide-to-fast-websites-with-next_js-tips-for-maximizing-server-speeds-and-minimi/img_005.jpg)](https://x.com/rauchg/status/1696944713708757065)

[![基于 App Router 运行的 Web Analytics 快得多](images/guide-to-fast-websites-with-next_js-tips-for-maximizing-server-speeds-and-minimi/img_005.jpg)](https://x.com/rauchg/status/1696944713708757065)

[1:55 PM · Aug 30, 2023](https://x.com/rauchg/status/1696944713708757065) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[下午 1:55 · 2023 年 8 月 30 日](https://x.com/rauchg/status/1696944713708757065) [面向网站的 Twitter、广告信息与隐私政策](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[589](https://x.com/intent/like?tweet_id=1696944713708757065) [Reply](https://x.com/intent/tweet?in_reply_to=1696944713708757065)

[589 次点赞](https://x.com/intent/like?tweet_id=1696944713708757065) [回复](https://x.com/intent/tweet?in_reply_to=1696944713708757065)


[Read 22 replies](https://x.com/rauchg/status/1696944713708757065)

[查看 22 条回复](https://x.com/rauchg/status/1696944713708757065)

[![Lee Robinson](images/guide-to-fast-websites-with-next_js-tips-for-maximizing-server-speeds-and-minimi/img_006.jpg)](https://x.com/leerob/status/1688639192723521536)

[李·罗宾逊（Lee Robinson）](https://x.com/leerob/status/1688639192723521536)


· [关注](https://x.com/intent/follow?screen_name=leerob)

在 Twitter 上查看

从 `useState` 到 URL 状态。

我们无需依赖客户端 React 状态，而可将颜色、尺寸乃至所选图片等状态提升至 URL 中进行管理。

额外好处是：你现在可以为特定变体生成“深度链接”（deep link）。万岁，善用 Web 平台！

在 X 上观看

[2023 年 8 月 7 日 下午 3:52](https://x.com/leerob/status/1688639192723521536) [X 网站版说明、广告信息与隐私政策](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[97](https://x.com/intent/like?tweet_id=1688639192723521536) [回复](https://x.com/intent/tweet?in_reply_to=1688639192723521536)

[Read 6 replies](https://x.com/leerob/status/1688639192723521536)

[阅读 6 条回复](https://x.com/leerob/status/1688639192723521536)

[![Alex Sidorenko](images/guide-to-fast-websites-with-next_js-tips-for-maximizing-server-speeds-and-minimi/img_003.jpg)](https://x.com/asidorenko_/status/1693631458982650286)

[![阿列克谢·西多连科](images/guide-to-fast-websites-with-next_js-tips-for-maximizing-server-speeds-and-minimi/img_003.jpg)](https://x.com/asidorenko_/status/1693631458982650286)

[Alex Sidorenko](https://x.com/asidorenko_/status/1693631458982650286)

[阿列克谢·西多连科](https://x.com/asidorenko_/status/1693631458982650286)


· [Follow](https://x.com/intent/follow?screen_name=asidorenko_)

· [关注](https://x.com/intent/follow?screen_name=asidorenko_)

[View on Twitter](https://x.com/asidorenko_/status/1693631458982650286)

[在 X（原 Twitter）上查看](https://x.com/asidorenko_/status/1693631458982650286)

Move client components to the leaves of the component tree where possible.

尽可能将客户端组件移至组件树的叶子节点处。

[Watch on X](https://x.com/asidorenko_/status/1693631458982650286)

[在 X 上观看](https://x.com/asidorenko_/status/1693631458982650286)

[10:29 AM · Aug 21, 2023](https://x.com/asidorenko_/status/1693631458982650286) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[2023 年 8 月 21 日 上午 10:29](https://x.com/asidorenko_/status/1693631458982650286) [X（原 Twitter）网站集成、广告信息与隐私政策](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[1.1K](https://x.com/intent/like?tweet_id=1693631458982650286) [Reply](https://x.com/intent/tweet?in_reply_to=1693631458982650286)

[1.1K 次点赞](https://x.com/intent/like?tweet_id=1693631458982650286) [回复](https://x.com/intent/tweet?in_reply_to=1693631458982650286)


[Read 11 replies](https://x.com/asidorenko_/status/1693631458982650286)

[阅读 11 条回复](https://x.com/asidorenko_/status/1693631458982650286)

[![Alex Sidorenko](images/guide-to-fast-websites-with-next_js-tips-for-maximizing-server-speeds-and-minimi/img_003.jpg)](https://x.com/asidorenko_/status/1705586291788730412)

[亚历克斯·西多连科（Alex Sidorenko）](https://x.com/asidorenko_/status/1705586291788730412)


· [关注](https://x.com/intent/follow?screen_name=asidorenko_)

在 Twitter 上查看

Next.js 13 中的乐观更新（Optimistic Updates）

在 X 上观看

[2023 年 9 月 23 日 上午 10:13](https://x.com/asidorenko_/status/1705586291788730412) [X 网站版、广告信息与隐私政策](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[1.0K 次点赞](https://x.com/intent/like?tweet_id=1705586291788730412) [回复](https://x.com/intent/tweet?in_reply_to=1705586291788730412)


[阅读 12 条回复](https://x.com/asidorenko_/status/1705586291788730412)
{% endraw %}
