---
title: "Running Next.js in ChatGPT: How to Build ChatGPT Apps - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/running-next-js-inside-chatgpt-a-deep-dive-into-native-app-integration"
date: "2025-10-15"
scraped_at: "2026-03-02T09:27:30.809760707+00:00"
language: "en-zh"
translated: true
description: "Next.js now runs natively in ChatGPT with working navigation, React Server Components, and full features. Learn how we made this possible behind ChatGPTs triple iframe architecture and deploy our star..."
---
&#123;% raw %}

2025年10月15日

2025年10月15日

When OpenAI announced the Apps SDK with Model Context Protocol (MCP) support, it opened the door to embedding web applications directly into ChatGPT. But there's a significant difference between serving static HTML in an iframe and running a full Next.js application with client-side navigation, React Server Components, and dynamic routing.

当 OpenAI 宣布推出支持模型上下文协议（Model Context Protocol，MCP）的应用 SDK 时，它为将 Web 应用直接嵌入 ChatGPT 打开了大门。但将静态 HTML 渲染在 iframe 中，与运行一个具备客户端导航、React 服务端组件（RSC）和动态路由的完整 Next.js 应用之间，存在显著差异。

This is the story of how we bridged that gap. We created a Next.js app that runs natively inside ChatGPT's triple-iframe architecture, complete with navigation and all the modern features you'd expect from a Next.js application.

这正是我们弥合这一鸿沟的故事：我们构建了一个可在 ChatGPT 的三层嵌套 iframe 架构中**原生运行**的 Next.js 应用——支持完整的页面导航，并具备你对现代 Next.js 应用所期待的所有功能。

## What ChatGPT apps and MCP enable

## ChatGPT 应用与 MCP 能实现什么

[ChatGPT apps](https://openai.com/index/introducing-apps-in-chatgpt/) are interactive applications that run inside ChatGPT conversations. When you ask ChatGPT to "find me a hotel in Paris," a Booking.com widget appears directly in the chat with real search results you can interact with. These apps reach over 800 million ChatGPT users and appear naturally when relevant to the conversation.

[ChatGPT 应用](https://openai.com/index/introducing-apps-in-chatgpt/) 是运行于 ChatGPT 对话内部的交互式应用。当你让 ChatGPT “帮我找一家巴黎的酒店”时，Booking.com 的小部件便会直接出现在聊天窗口中，并展示真实可交互的搜索结果。这些应用触达超 8 亿 ChatGPT 用户，并在对话上下文相关时自然浮现。

ChatGPT apps are built on [Model Context Protocol](https://vercel.com/blog/model-context-protocol-mcp-explained) (MCP), an open standard that connects AI models to external tools and data. MCP works like REST or GraphQL, but for AI agents. Instead of hard-coding API calls, you define tools and resources in a structured format that models can discover and use. When ChatGPT needs to show your app, it fetches HTML from your MCP server and renders it in an iframe.

ChatGPT 应用基于 [模型上下文协议（Model Context Protocol，MCP）](https://vercel.com/blog/model-context-protocol-mcp-explained) 构建——这是一个将 AI 模型连接至外部工具与数据的开放标准。MCP 的作用类似于 REST 或 GraphQL，但专为 AI 智能体（AI agents）而设计。你无需硬编码 API 调用，而是以结构化格式定义工具与资源，使模型能够自动发现并调用它们。当 ChatGPT 需要展示你的应用时，它会从你的 MCP 服务器获取 HTML，并在 iframe 中渲染。

For Next.js developers, this means your existing application can run inside ChatGPT with the right patches, giving you immediate distribution without rebuilding from scratch. Our [starter template](https://github.com/vercel-labs/chatgpt-apps-sdk-nextjs-starter) gives you a working ChatGPT app you can [deploy to Vercel](https://vercel.com/templates/ai/chatgpt-app-with-next-js) right away.

对于 Next.js 开发者而言，这意味着：只要应用适当的补丁（patches），你现有的应用即可直接运行于 ChatGPT 内部，从而实现开箱即用的分发，无需从零重构。我们的 [入门模板（starter template）](https://github.com/vercel-labs/chatgpt-apps-sdk-nextjs-starter) 提供了一个开箱可用的 ChatGPT 应用，你可立即 [部署至 Vercel](https://vercel.com/templates/ai/chatgpt-app-with-next-js)。

[**Ready to build your own ChatGPT app?**\\
\\
Deploy our ChatGPT Apps SDK Next.js starter template to Vercel and start experimenting right away.\\
\\
Deploy now](https://vercel.com/templates/ai/chatgpt-app-with-next-js)

[**准备好构建你自己的 ChatGPT 应用了吗？**  
立即部署我们的 ChatGPT Apps SDK Next.js 入门模板至 Vercel，马上开始实验。  
立即部署](https://vercel.com/templates/ai/chatgpt-app-with-next-js)

The template handles all the browser API patches and MCP server configuration automatically. ChatGPT's nested-iframe architecture breaks several Next.js features. Understanding how the patches fix these issues helps you customize and extend your app beyond the starter.

该模板自动处理全部浏览器 API 补丁及 MCP 服务端配置。ChatGPT 的嵌套 iframe 架构会破坏多项 Next.js 功能。深入理解这些补丁如何修复问题，有助于你在入门模板基础上进一步定制与扩展你的应用。

## How ChatGPT's nested-iframe architecture breaks modern frameworks

## ChatGPT 的嵌套 iframe 架构为何破坏现代前端框架

ChatGPT renders apps in a three-layer iframe architecture to protect itself from potentially malicious apps.  
ChatGPT 采用三层 iframe 架构来渲染应用，以保护自身免受潜在恶意应用的侵害。

An iframe is an HTML element that embeds one webpage inside another, creating an isolated sandbox.  
iframe 是一种 HTML 元素，用于在一个网页中嵌入另一个网页，从而创建一个隔离的沙箱环境。

```text
chatgpt.com

2  └── web-sandbox.oaiusercontent.com (sandbox iframe)

3     └── web-sandbox.oaiusercontent.com (inner iframe)

4        └── your app's HTML
```

The sandbox domain (`web-sandbox.oaiusercontent.com`) acts as a security buffer between ChatGPT and your app. This isolates apps from ChatGPT's main interface and protects users from potentially harmful code.  
沙箱域名（`web-sandbox.oaiusercontent.com`）在 ChatGPT 和你的应用之间充当安全缓冲区。该机制将应用与 ChatGPT 的主界面隔离开来，并保护用户免受潜在有害代码的影响。

But this security model creates several technical challenges. When Next.js runs inside the deepest iframe, it thinks its origin is `web-sandbox.oaiusercontent.com` instead of your actual domain.  
但这一安全模型带来了若干技术挑战：当 Next.js 运行在最内层 iframe 中时，它会将自身来源（origin）识别为 `web-sandbox.oaiusercontent.com`，而非你的真实域名。

This behavior breaks several core features:  
该行为会导致以下几项核心功能失效：

1. **Asset loading breaks:** Next.js requests `/_next/static/chunks/app.js` from the sandbox domain instead of your actual domain, returning 404s  
1. **资源加载失败：** Next.js 向沙箱域名（而非你的真实域名）发起对 `/_next/static/chunks/app.js` 的请求，导致返回 404 错误。

2. **Relative URLs resolve incorrectly:** Images, fonts, and API calls using relative paths (like `/logo.png` or `/api/data`) resolve against the sandbox domain instead of your app's domain  
2. **相对 URL 解析错误：** 使用相对路径的图片、字体及 API 请求（例如 `/logo.png` 或 `/api/data`）会基于沙箱域名进行解析，而非你应用的真实域名。

3. **Browser history stores full URLs:** `history.pushState` saves `https://your-app.vercel.app/about`, which exposes your real domain and breaks the sandbox security model

3. **浏览器历史记录存储完整 URL：** `history.pushState` 会保存 `https://your-app.vercel.app/about`，从而暴露你的真实域名，并破坏沙箱安全模型。

4. **Client-side navigation fails:** When you click a Next.js Link, fetch requests go to the sandbox domain instead of your server

4. **客户端导航失败：** 当你点击一个 Next.js 的 `Link` 组件时，发起的 `fetch` 请求会发送至沙箱域名，而非你的实际服务器。

5. **CORS blocks React Server Components:** Cross-origin requests from the iframe to your server fail without proper headers. Browsers also send `OPTIONS` preflight requests that Next.js doesn't handle by default

5. **CORS 阻止 React Server Components：** 从 iframe 向你的服务器发起的跨域请求，若缺少正确的响应头，则会失败。此外，浏览器还会发送 `OPTIONS` 预检请求，而 Next.js 默认并不处理此类请求。

6. **Parent frames modify your HTML:** ChatGPT occasionally adds attributes to your root `<html>` element, causing React hydration mismatches

6. **父级框架修改你的 HTML：** ChatGPT 有时会向你的根 `<html>` 元素添加属性，导致 React 水合（hydration）过程出现不匹配。

7. **External links navigate inside the iframe:** Links to external sites try to load inside the constrained iframe instead of opening in the user's browser

7. **外部链接在 iframe 内跳转：** 指向外部网站的链接会尝试在受限的 iframe 内加载，而非在用户浏览器中新开标签页打开。

Let's explore how we solved each of these problems.

让我们逐一探讨我们是如何解决上述每个问题的。

## **Making static assets load from your actual domain**

## **让静态资源从你的实际域名加载**

Next.js generates asset paths like `/_next/static/chunks/app-pages-browser.js`. When running in the ChatGPT iframe, these requests resolve to `https://web-sandbox.oaiusercontent.com/_next/static/chunks/app-pages-browser.js`. But that URL doesn't exist. The assets live on your actual domain.

Next.js 会生成类似 `/_next/static/chunks/app-pages-browser.js` 的资源路径。当在 ChatGPT 的 iframe 中运行时，这些请求会被解析为 `https://web-sandbox.oaiusercontent.com/_next/static/chunks/app-pages-browser.js` —— 但该 URL 并不存在。这些静态资源实际托管于你的真实域名下。

Next.js provides `assetPrefix` for exactly this scenario. Setting `assetPrefix` to your app's URL forces all `/_next/` requests to use the correct origin:

Next.js 为此场景专门提供了 `assetPrefix` 配置项。将 `assetPrefix` 设置为你应用的实际 URL，即可强制所有以 `/_next/` 开头的资源请求使用正确的源（origin）：

```ts
next.config.ts
```

```typescript
import type { NextConfig } from "next";

import { baseURL } from "./baseUrl";



const nextConfig: NextConfig = {

5  assetPrefix: baseURL, // Forces /_next/ requests to use your-app.vercel.app

6};



export default nextConfig;
```

`baseURL` 根据运行环境动态确定：

`baseUrl.ts`

```typescript
export const baseURL =

2  process.env.NODE_ENV == "development"

3    ? "<http://localhost:3000>"

4    : "https://" +

5      (process.env.VERCEL_ENV === "production"

6        ? process.env.VERCEL_PROJECT_PRODUCTION_URL

7        : process.env.VERCEL_BRANCH_URL || process.env.VERCEL_URL);
```

这确保了资源在开发、预览和生产环境中均能正确加载。

## **为所有相对路径设置基础 URL（base URL）**

即使已配置 `assetPrefix`，其他相对 URL 仍会失效。使用相对路径的图片、字体以及 API 调用（例如 `/logo.png`、`/fonts/inter.woff2` 或 `/api/data`）均会解析到 `https://web-sandbox.oaiusercontent.com`，而非您的实际域名。Next.js 并未提供内置机制来重写应用中所有相对 URL。

The HTML `<base>` element solves this. It sets the base URL for all relative URLs in a document:

HTML `<base>` 元素可解决此问题。它为文档中所有相对 URL 设置基准 URL。

app/layout.tsx

```typescript
function NextChatSDKBootstrap({ baseUrl }: { baseUrl: string }) {

2  return (

3    <>

4      <base href={baseUrl}></base>

5      {/* Other bootstrap code... */}

6    </>

7  );

8}
```

With this single element, every relative URL automatically resolves against your actual domain. This includes images (`<img src="/logo.png">`), stylesheets (`<link href="/styles.css">`), and API calls (`fetch('/api/data')`).

通过这一单个元素，所有相对 URL 均会自动以您的实际域名作为基准进行解析。这包括图片（`<img src="/logo.png">`）、样式表（`<link href="/styles.css">`）以及 API 调用（`fetch('/api/data')`）。

## **Patching browser history to prevent URL leaks**

## **修补浏览器历史记录以防止 URL 泄露**

Next.js uses the History API (`history.pushState` and `history.replaceState`) to update the URL bar during client-side navigation. However, when running inside an iframe with a different displayed origin, these APIs store full URLs like `https://your-app.vercel.app/about`. This exposes your real domain and breaks the sandbox security model.

Next.js 利用 History API（`history.pushState` 和 `history.replaceState`）在客户端导航期间更新地址栏。然而，当在具有不同显示源（displayed origin）的 iframe 中运行时，这些 API 会存储完整 URL（例如 `https://your-app.vercel.app/about`），从而暴露您的真实域名，并破坏沙箱安全模型。

Our solution is to intercept calls to `history.pushState` and `history.replaceState`, stripping them down to just the path, search params, and hash:

我们的解决方案是拦截对 `history.pushState` 和 `history.replaceState` 的调用，将其精简为仅包含路径（path）、查询参数（search params）和哈希（hash）：

app/layout.tsx

```typescript
const originalReplaceState = history.replaceState;

history.replaceState = (state, unused, url) => {

3  const u = new URL(url ?? "", window.location.href);

4  const href = u.pathname + u.search + u.hash;

5  originalReplaceState.call(history, state, unused, href);
```

```typescript
const originalReplaceState = history.replaceState;

history.replaceState = (state, unused, url) => {

3  const u = new URL(url ?? "", window.location.href);

4  const href = u.pathname + u.search + u.hash;

5  originalReplaceState.call(history, state, unused, href);
```

```js
6};



const originalPushState = history.pushState;

history.pushState = (state, unused, url) => {

10  const u = new URL(url ?? "", window.location.href);

11  const href = u.pathname + u.search + u.hash;

12  originalPushState.call(history, state, unused, href);

13};
```

```js
6};



const originalPushState = history.pushState;

history.pushState = (state, unused, url) => {

10  const u = new URL(url ?? "", window.location.href);

11  const href = u.pathname + u.search + u.hash;

12  originalPushState.call(history, state, unused, href);

13};
```

This ensures that navigation history entries only contain relative paths like `/about` instead of full URLs, preserving the iframe's security boundary while maintaining functional browser history and back/forward buttons.

这确保了导航历史记录条目仅包含相对路径（例如 `/about`），而非完整 URL，从而在保持浏览器历史记录及后退/前进按钮功能正常的同时，维系 iframe 的安全边界。

## **Rewriting fetch requests for client-side navigation**

## **重写 fetch 请求以支持客户端导航**

Next.js uses a sophisticated client-side navigation system powered by React Server Components (RSC). When you click a Link, Next.js makes a `fetch` request to load the new page's RSC payload (a special format containing the component tree and data).

Next.js 利用 React Server Components（RSC）构建了一套精密的客户端导航系统。当你点击一个 `Link` 时，Next.js 会发起一次 `fetch` 请求，以加载新页面的 RSC 有效载荷（一种包含组件树及数据的特殊格式）。

But remember, your app runs in an iframe at `web-sandbox.oaiusercontent.com` while the server is at `your-app.vercel.app`. Without intervention, these fetch requests fail because they target the wrong domain.

但请注意，你的应用实际运行在 `web-sandbox.oaiusercontent.com` 的 iframe 中，而服务端部署在 `your-app.vercel.app`。若不加干预，这些 `fetch` 请求将因目标域名错误而失败。

Our solution is to patch `window.fetch` to rewrite same-origin requests to use the correct base URL:

我们的解决方案是劫持（patch）`window.fetch`，将同源请求重写为使用正确的基础 URL：

app/layout.tsx

`app/layout.tsx`

```typescript
const appOrigin = new URL(baseUrl).origin;

const isInIframe = window.self !== window.top;



if (isInIframe && window.location.origin !== appOrigin) {

5  const originalFetch = window.fetch;

```

7  window.fetch = (input: URL | RequestInfo, init?: RequestInit) => {

7  window.fetch = (input: URL | RequestInfo, init?: RequestInit) => {

8    // Parse the request URL from various input types

8    // 从多种输入类型中解析请求 URL

9    let url = /* ... parse input to URL ... */;

9    let url = /* …… 将 input 解析为 URL …… */;

11    // If the request targets the iframe's origin, rewrite it

11    // 如果请求的目标是 iframe 所在的源（origin），则重写该请求地址

12    if (url.origin === window.location.origin) {

12    if (url.origin === window.location.origin) {

13      const newUrl = new URL(baseUrl);

13      const newUrl = new URL(baseUrl);

14      newUrl.pathname = url.pathname;

14      newUrl.pathname = url.pathname;

15      newUrl.search = url.search;

15      newUrl.search = url.search;

16      newUrl.hash = url.hash;

16      newUrl.hash = url.hash;

18      return originalFetch.call(window, newUrl.toString(), {

18      返回 originalFetch.call(window, newUrl.toString(), {

19        ...init,

19        ...init,

20        mode: "cors", // Enable CORS for cross-origin RSC requests

20        mode: "cors", // 为跨源 RSC 请求启用 CORS

21      });

21      });

22    }



22    }



24    return originalFetch.call(window, input, init);

24    返回 originalFetch.call(window, input, init);

25  };

25  };

26}
26}

This patch only runs when:

此补丁仅在以下条件下运行：

1. The app is inside an iframe (`window.self !== window.top`)

1. 应用运行在一个 iframe 内（`window.self !== window.top`）

2. The iframe's origin differs from the app's actual origin

2. iframe 的源（origin）与应用的实际源不一致

When these conditions are met, any fetch request to the iframe's origin is transparently rewritten to use the app's real origin, with CORS mode enabled for cross-origin requests.

当满足上述条件时，所有发往 iframe 源的 `fetch` 请求将被透明地重写为使用应用的真实源，并对跨源请求启用 CORS 模式。

## Adding CORS headers for cross-origin requests

## 为跨源请求添加 CORS 响应头

With fetch patching in place, client-side navigation now makes cross-origin requests from the iframe to your server. But these requests will fail without proper CORS headers.

启用 `fetch` 补丁后，客户端导航将从 iframe 向您的服务器发起跨源请求。但若未正确配置 CORS 响应头，这些请求将失败。

Modern browsers also send `OPTIONS` preflight requests before cross-origin `POST` requests (which Next.js uses for RSC payloads). Without handling these `OPTIONS` requests, navigation hangs.

现代浏览器还会在跨源 `POST` 请求（Next.js 使用该方法传输 RSC 负载）之前发送 `OPTIONS` 预检请求。若未正确处理这些 `OPTIONS` 请求，页面导航将卡住。

Next.js middleware runs on every request before it's processed, which makes it the perfect place to add CORS headers and solve this problem:

Next.js 中间件会在每个请求被处理前执行，因此是添加 CORS 响应头、解决该问题的理想位置：

middleware.ts

`middleware.ts`

```typescript
import type { NextRequest } from "next/server";

import type { NextRequest } from "next/server";

export function middleware(request: NextRequest) {

export function middleware(request: NextRequest) {

5  // Handle OPTIONS preflight requests

5  // 处理 OPTIONS 预检请求

6  if (request.method === "OPTIONS") {

6  if (request.method === "OPTIONS") {

7    const response = new NextResponse(null, { status: 204 });

7    const response = new NextResponse(null, { status: 204 });

8    response.headers.set("Access-Control-Allow-Origin", "*");

8    response.headers.set("Access-Control-Allow-Origin", "*");

9    response.headers.set(

9    response.headers.set(

10      "Access-Control-Allow-Methods",

10      "Access-Control-Allow-Methods",

11      "GET,POST,PUT,DELETE,OPTIONS"

11      "GET,POST,PUT,DELETE,OPTIONS"
```

12    );

12    );

13    response.headers.set("Access-Control-Allow-Headers", "*");

13    response.headers.set("Access-Control-Allow-Headers", "*");

14    return response;

14    return response;

15  }

15  }

17  // Add CORS headers to all responses

17  // 为所有响应添加 CORS 头部

18  return NextResponse.next({

18  return NextResponse.next({

19    headers: {

19    headers: {

20      "Access-Control-Allow-Origin": "*",

20      "Access-Control-Allow-Origin": "*",

21      "Access-Control-Allow-Methods": "GET,POST,PUT,DELETE,OPTIONS",

21      "Access-Control-Allow-Methods": "GET,POST,PUT,DELETE,OPTIONS",

22      "Access-Control-Allow-Headers": "*",

22      “Access-Control-Allow-Headers”: “*”,

23    },

23    },

24  });

24  });

25}



25}



export const config = {

export const config = {

28  matcher: "/:path*", // Apply to all routes

28  matcher: "/:path*", // 应用于所有路由

29};
```

29};
```

This middleware:

该中间件：

1. **Responds to OPTIONS requests** with a 204 status and appropriate CORS headers

1. **响应 OPTIONS 请求**，返回 204 状态码，并附带适当的 CORS 响应头

2. **Adds CORS headers to all responses** so cross-origin fetch requests succeed

2. **为所有响应添加 CORS 头**，以确保跨源 `fetch` 请求能够成功。

Now when Next.js makes an RSC request during navigation, the browser's preflight check passes and the actual request receives the data it needs.

现在，当 Next.js 在导航过程中发起 RSC 请求时，浏览器的预检（preflight）检查能够通过，且实际请求可正常接收所需数据。

## **Preventing parent frame interference with DOM mutations**

## **防止父级框架干扰 DOM 变更**

ChatGPT's parent frames occasionally modify the root `<html>` element by adding attributes. When React tries to hydrate, the server-rendered HTML doesn't match the DOM, causing hydration mismatch errors.

ChatGPT 的父级框架偶尔会通过添加属性的方式修改根 `<html>` 元素。当 React 尝试执行水合（hydration）时，服务端渲染的 HTML 与当前 DOM 不一致，从而引发水合不匹配错误。

Our solution is to use a `MutationObserver` to watch for attribute changes on the root element and immediately remove unauthorized modifications:

我们的解决方案是使用 `MutationObserver` 监听根元素上的属性变更，并立即移除未授权的修改：

app/layout.tsx

```typescript
const htmlElement = document.documentElement;

const observer = new MutationObserver((mutations) => {

3  mutations.forEach((mutation) => {

4    if (

```javascript
5      mutation.type === "attributes" &&

5      mutation.type === "attributes" &&

6      mutation.target === htmlElement

6      mutation.target === htmlElement

7    ) {

7    } {

8      const attrName = mutation.attributeName;

8      const attrName = mutation.attributeName;

9      if (attrName && attrName !== "suppresshydrationwarning") {

9      if (attrName && attrName !== "suppresshydrationwarning") {

10        htmlElement.removeAttribute(attrName);

10        htmlElement.removeAttribute(attrName);

11      }

11      }

12    }

12    }

13  });

13  });

14});

14});
```

```typescript
observer.observe(htmlElement, {

17  attributes: true,

18  attributeOldValue: true,

19});
```

```typescript
observer.observe(htmlElement, {

17  属性监听启用：true,

18  记录属性旧值：true,

19});
```

We also add `suppressHydrationWarning` to the `<html>` tag to prevent React from logging warnings:

我们还在 `<html>` 标签中添加 `suppressHydrationWarning` 属性，以阻止 React 输出水合警告：

app/layout.tsx

app/layout.tsx

```typescript
1<html lang="en" suppressHydrationWarning>
```

```typescript
1<html lang="en" suppressHydrationWarning>
```

While this isn't a perfect solution (the parent frame shouldn't modify our HTML), it prevents the console from being flooded with hydration warnings.

尽管这不是一个完美的解决方案（父框架本不应修改我们的 HTML），但它能有效避免控制台被大量水合警告刷屏。

## **Opening external links in the user's browser**

## **在用户浏览器中打开外部链接**

Without intervention, links to external sites try to navigate inside the constrained iframe. This creates a poor user experience when users click on documentation, blog posts, or other external resources.

若不加干预，指向外部网站的链接会尝试在受限的 iframe 内进行导航。当用户点击文档、博客文章或其他外部资源时，这将导致糟糕的用户体验。

ChatGPT provides an `openai.openExternal()` API specifically to handle this case. Our solution is to intercept clicks on external links and use this API to open them in the user's browser:

ChatGPT 提供了一个专门用于处理此场景的 `openai.openExternal()` API。我们的解决方案是拦截对外部链接的点击事件，并通过该 API 在用户的浏览器中打开这些链接：

app/layout.tsx

app/layout.tsx

```typescript
window.addEventListener(

2  "click",

3  (e) => {

4    const a = (e?.target as HTMLElement)?.closest("a");

5    if (!a || !a.href) return;



7    const url = new URL(a.href, window.location.href);
```

8    if (

8    如果（

9      url.origin !== window.location.origin &&

9      url.origin !== window.location.origin &&

10      url.origin !== appOrigin

10      url.origin !== appOrigin

11    ) {

11    ）{

12      try {

12      尝试 {

13        if (window.openai) {

13        如果 window.openai 存在 {

14          window.openai.openExternal({ href: a.href });

14          window.openai.openExternal({ href: a.href });

15          e.preventDefault();

15          e.preventDefault();

16        }

16        }

17      } catch {

17      } catch {

18        console.warn("openExternal failed, likely not in OpenAI client");

18        console.warn("openExternal 调用失败，很可能当前环境并非 OpenAI 客户端");

19      }

19      }

20    }

20    }

21  },

21  },

22  true // Use capture phase to intercept before Next.js Link components

22  true // 使用捕获阶段，在 Next.js 的 Link 组件处理前进行拦截

23);
```

23);
```

This ensures external links open in the user's browser instead of navigating inside the constrained iframe.

这确保了外部链接将在用户的浏览器中打开，而非在受限的 iframe 内进行导航。

## **Connecting your Next.js app to ChatGPT with MCP**

## **使用 MCP 将您的 Next.js 应用连接至 ChatGPT**

With all the browser API patches in place, the final step is implementing the MCP server that connects ChatGPT to your Next.js app. MCP servers expose two main primitives: resources (content that can be displayed) and tools (actions the model can invoke).

在完成所有浏览器 API 补丁后，最后一步是实现将 ChatGPT 与您的 Next.js 应用连接起来的 MCP 服务器。MCP 服务器对外暴露两类核心原语：资源（resource，即可展示的内容）和工具（tool，即模型可调用的操作）。

### How MCP resources serve HTML to ChatGPT

### MCP 资源如何向 ChatGPT 提供 HTML

Resources serve HTML content that ChatGPT renders in iframes.  
资源提供 HTML 内容，ChatGPT 在 iframe 中渲染这些内容。

We fetch the homepage HTML and register it as a resource:  
我们获取首页 HTML 并将其注册为一个资源：

app/mcp/route.ts  
app/mcp/route.ts

```typescript
const html = await getAppsSdkCompatibleHtml(baseURL, "/");



server.registerResource(

4  "content-widget",

5  "ui://widget/content-template.html",

6  {

7    title: "Show Content",

8    description: "Displays the homepage content",
```

9    mimeType: "text/html+skybridge",

9    mimeType: "text/html+skybridge",

10    _meta: {

10    _meta: {

11      "openai/widgetDescription": "Displays the homepage content",

11      "openai/widgetDescription": "显示主页内容",

12      "openai/widgetPrefersBorder": true,

12      "openai/widgetPrefersBorder": true,

13    },

13    },

14  },

14  },

15  async (uri) => ({

15  async (uri) => ({

16    contents: [\
\
16    contents: [\
\

17      {\
\
17      {\
\

18        uri: uri.href,\
\
18        uri: uri.href,\
\

19        mimeType: "text/html+skybridge",\
\
19        mimeType: "text/html+skybridge",\
\

20        text: `<html>${html}</html>`,\
\
20        text: `<html>${html}</html>`,\
\

21        _meta: {\
\
21        _meta: {\
\

22          "openai/widgetDescription": "Displays the homepage content",\
\
22          "openai/widgetDescription": "显示主页内容",\
\

23          "openai/widgetPrefersBorder": true,\
\
23          "openai/widgetPrefersBorder": true,\
\

24        },\
\
24        },\
\

25      },\
\
25      },\
\

26    ],

26    ],

27  })

27  })

28);
```

The `mimeType` of `text/html+skybridge` tells ChatGPT to render this as an interactive widget. The `_meta` object contains OpenAI-specific configuration like the widget description and whether to show a border.

`text/html+skybridge` 这一 `mimeType` 告知 ChatGPT 将此内容渲染为一个交互式小部件（widget）。`_meta` 对象则包含 OpenAI 特有的配置项，例如小部件的描述信息以及是否显示边框。

### How MCP tools trigger app displays

### MCP 工具如何触发应用界面显示

Tools are actions ChatGPT can invoke. By linking a tool to a resource via `openai/outputTemplate`, ChatGPT knows to render the widget after the tool is called:

工具是 ChatGPT 可调用的操作。通过使用 `openai/outputTemplate` 将工具与某个资源关联，ChatGPT 即可在该工具被调用后自动渲染对应的小部件：

app/mcp/route.ts

```typescript
server.registerTool(

2  "show_content",

3  {

4    title: "Show Content",

5    description: "Fetch and display the homepage content with the name of the user",

6    inputSchema: {

7      name: z.string().describe("The name of the user to display"),

7      name: z.string().describe("要显示的用户名"),

8    },

8    },

9    _meta: {

9    _meta: {

10      "openai/outputTemplate": "ui://widget/content-template.html",

10      "openai/outputTemplate": "ui://widget/content-template.html",

11      "openai/toolInvocation/invoking": "Loading content...",

11      "openai/toolInvocation/invoking": “正在加载内容……”,

12      "openai/toolInvocation/invoked": "Content loaded",

12      "openai/toolInvocation/invoked": “内容已加载”,

13      "openai/widgetAccessible": false,

13      "openai/widgetAccessible": false,

14      "openai/resultCanProduceWidget": true,

14      "openai/resultCanProduceWidget": true,

15    },

15    },

16  },

16  },

17  async ({ name }) => {

17  async ({ name }) => {

18    return {

18    返回 {

19      content: [\
\
20        {\
\
21          type: "text",\
\
22          text: name,\
\
23        },\
\
24      ],

19      content: [\
\
20        {\
\
21          type: "text",\
\
22          text: name,\
\
23        },\
\
24      ],

25      structuredContent: {

25      structuredContent: {

26        name: name,

26        name: name,

27        timestamp: new Date().toISOString(),

27        timestamp: new Date().toISOString(),

28      },

28      },

29      _meta: {

29      _meta: {

30        "openai/outputTemplate": "ui://widget/content-template.html",

30        "openai/outputTemplate": "ui://widget/content-template.html",

31        "openai/toolInvocation/invoking": "Loading content...",

31        "openai/toolInvocation/invoking": "正在加载内容...",

32        "openai/toolInvocation/invoked": "Content loaded",

32        “openai/toolInvocation/invoked”：“内容已加载”，

33        "openai/widgetAccessible": false,

33        “openai/widgetAccessible”：false，

34        "openai/resultCanProduceWidget": true,

34        “openai/resultCanProduceWidget”：true，

35      },

35      }，

36    };

36    }；

37  }

37  }

38);
```

38);
```

The `_meta` object contains OpenAI-specific configuration:

`_meta` 对象包含 OpenAI 特有的配置：

- **`openai/outputTemplate`** **:** Links to the registered resource URI

- **`openai/outputTemplate`** **：** 指向已注册资源的 URI。

- **`openai/toolInvocation/invoking`** **:** Text shown while the tool is executing

- **`openai/toolInvocation/invoking`** **：** 工具执行过程中显示的文本。

- **`openai/toolInvocation/invoked`** **:** Text shown after completion  
- **`openai/toolInvocation/invoked`** **：** 工具调用完成之后显示的文本

- **`openai/widgetAccessible`** **:** Whether the widget should be keyboard/screen reader accessible  
- **`openai/widgetAccessible`** **：** 指示该小部件是否应支持键盘操作和屏幕阅读器访问

- **`openai/resultCanProduceWidget`** **:** Signals that this tool can render a widget  
- **`openai/resultCanProduceWidget`** **：** 表明该工具能够渲染一个小部件

## How your app receives data from ChatGPT

## 你的应用如何从 ChatGPT 接收数据

The app can receive data from tool invocations via the `window.openai.toolOutput` property. ChatGPT automatically populates this object with the `structuredContent` from the tool's response:  
应用可通过 `window.openai.toolOutput` 属性接收来自工具调用的数据。ChatGPT 会自动将工具响应中的 `structuredContent` 填充到该对象中：

app/page.tsx

```typescript
const [name, setName] = useState<string | null>(null);



useEffect(() => {

4  if (typeof window === "undefined") return;
```

6  if (!window.openai) {

6  如果 `window.openai` 不存在：

7    (window as any).openai = {};

7    将 `(window as any).openai` 初始化为空对象。

8  }



10  let currentValue = (window as any).openai.toolOutput;

10  声明变量 `currentValue`，其值为 `(window as any).openai.toolOutput`。

12  Object.defineProperty((window as any).openai, "toolOutput", {

12  调用 `Object.defineProperty` 为 `(window as any).openai` 定义属性 `"toolOutput"`：

13    get() {

13    `get()` 访问器函数：

14      return currentValue;

14      返回 `currentValue` 的当前值。

15    },

15    },

16    set(newValue: any) {

16    set(newValue: any) {

17      currentValue = newValue;

17      currentValue = newValue;

18      if (newValue?.name) {

18      如果 `newValue` 存在且具有 `name` 属性：

19        setName(newValue.name);

19        调用 `setName(newValue.name)`；

20      }

20      }

21    },

21    },

22    configurable: true,

22    configurable: true,

23    enumerable: true,

23    enumerable: true,

24  });

24  });

26  if (currentValue?.name) {

27    setName(currentValue.name);

28  }

29}, []);
```

这种响应式模式使得应用能够在 ChatGPT 调用工具时实时更新其用户界面。属性 setter 拦截对 `toolOutput` 的变更，并相应地更新 React 状态。

## 使用 React Hooks 管理 ChatGPT 集成

上述手动调用 [`window.openai`](https://developers.openai.com/apps-sdk/reference) 的方式虽可行，但代码冗长，且每个需要集成 ChatGPT 的组件都需重复编写样板代码。针对生产环境应用，我们构建了一组 React Hooks，将浏览器 API 封装为类型安全的抽象模式。

这些 Hooks 支持服务端渲染（SSR）、优化重渲染，并提供完善的类型安全保证。其中三个核心 Hooks 覆盖了绝大多数使用场景：

**`useSendMessage`** **向 ChatGPT 发送后续消息：**

`app/page.tsx`

`app/page.tsx`

```typescript
const sendMessage = useSendMessage();



3// Trigger a new ChatGPT message from user interaction

4<button onClick={() => sendMessage("Show me more examples")}>

5  More Examples

6</button>
```

```typescript
const sendMessage = useSendMessage();



3// 通过用户交互触发一条新的 ChatGPT 消息

4<button onClick={() => sendMessage("Show me more examples")}>

5  更多示例

6</button>
```

**`useWidgetProps`** **accesses tool call outputs with type safety:**

**`useWidgetProps`** **以类型安全的方式访问工具调用的输出：**

`app/page.tsx`

`app/page.tsx`

```typescript
const toolOutput = useWidgetProps<{ name?: string }>();
```

```typescript
const toolOutput = useWidgetProps<{ name?: string }>();
```

3// 从工具调用中访问结构化数据

const name = toolOutput?.name;
```

**`useDisplayMode`** **根据显示模式自定义您的界面：**

app/page.tsx

```typescript
const displayMode = useDisplayMode();



3// 根据 ChatGPT 如何显示该应用，渲染不同的布局

return displayMode === "fullscreen" ? <FullView /> : <CompactView />;
```

所有可用 Hook 的完整列表，请参见 [ChatGPT Apps SDK Next.js Starter](https://github.com/vercel-labs/chatgpt-apps-sdk-nextjs-starter/tree/main/app/hooks)。

## **The advantages this approach unlocks**

## **此方法所释放的优势**

This approach provides several significant advantages over simpler iframe embedding.

这种方法相比简单的 iframe 嵌入，具有多项显著优势。

### Native Next.js navigation

### 原生 Next.js 导航

Users can click links and navigate between pages using Next.js's client-side routing. The browser's back and forward buttons work correctly. Navigation is fast thanks to React Server Components streaming page updates instead of reloading the entire iframe.

用户可点击链接，并利用 Next.js 的客户端路由在页面间导航；浏览器的“后退”和“前进”按钮均可正常工作；得益于 React Server Components 对页面更新的流式传输（而非重新加载整个 iframe），导航体验极为迅速。

Without these patches, you'd be limited to serving a single static page or adding yet another iframe layer, which would introduce even more complexity.

若未应用这些补丁，您将只能提供单个静态页面，或不得不额外嵌套一层 iframe，从而进一步增加系统复杂性。

### Full Next.js feature set

### 完整的 Next.js 功能集

You're not limited to static HTML. All of Next.js's features work normally:

您不再局限于静态 HTML；Next.js 的全部功能均可正常使用：

- React Server Components and streaming

- React Server Components 及流式渲染

- Server Actions for forms

- 表单的 Server Actions

- Incremental Static Regeneration (ISR)

- 增量静态再生（ISR）

- Dynamic routing with `[slug]` patterns  
- 使用 `[slug]` 模式实现动态路由  

- API routes  
- API 路由  

- Middleware  
- 中间件  


### Unchanged developer experience  

### 开发者体验保持不变  

The patches are applied once in `layout.tsx`. The rest of your codebase uses familiar Next.js patterns without workarounds. You can develop locally with `next dev` and deploy to Vercel like any other Next.js app.  

补丁仅需在 `layout.tsx` 中应用一次。代码库其余部分沿用您熟悉的 Next.js 模式，无需任何变通方案。您可以像开发任意其他 Next.js 应用一样，本地使用 `next dev` 进行开发，并部署到 Vercel。


### Performance that matches standard Next.js apps  

### 性能媲美标准 Next.js 应用  

Client-side navigation is faster than full page reloads because only the new page's data transfers over the network, not the entire document. React Server Components enable streaming, so users see content faster on slower connections.  

客户端导航比整页重载更快，因为仅需通过网络传输新页面的数据，而非整个文档。React 服务端组件（RSC）支持流式传输，因此即使在网络较慢的情况下，用户也能更快看到内容。


### Native-feeling user experience  

### 原生般的用户体验  

The app feels integrated into ChatGPT rather than bolted on. Users can:  

该应用与 ChatGPT 深度集成，而非简单拼接。用户可以：  

- Navigate naturally with working back/forward buttons  
- 顺畅地使用浏览器的后退/前进按钮进行导航

- See instant page transitions

- 查看即时页面过渡效果

- Open external links in their browser

- 在其原生浏览器中打开外部链接

- Experience smooth interactions without iframe nesting issues

- 体验流畅的交互，避免 iframe 嵌套问题


## Getting started with Next.js in ChatGPT

## 在 ChatGPT 中开始使用 Next.js

These seven patches solve the fundamental incompatibilities between ChatGPT's iframe architecture and Next.js's expectations. The [starter template](https://github.com/vercel-labs/chatgpt-apps-sdk-nextjs-starter) implements all of them, so you can focus on building your app's features instead of wrestling with browser APIs.

这七个补丁解决了 ChatGPT 的 iframe 架构与 Next.js 预期行为之间的根本性不兼容问题。[入门模板](https://github.com/vercel-labs/chatgpt-apps-sdk-nextjs-starter) 已全部集成这些补丁，让你能专注于构建应用功能，而非与浏览器 API 较劲。

Whether you're building productivity tools, data visualizations, or interactive experiences, this foundation brings the full power of Next.js to ChatGPT's 800 million users.

无论你正在开发效率工具、数据可视化应用，还是交互式体验，这一基础架构都将 Next.js 的全部能力带给了 ChatGPT 的 8 亿用户。

[**Ready to build your own ChatGPT app?**\\
\\
Deploy our ChatGPT Apps SDK Next.js starter template to Vercel and start experimenting right away.\\
\\
Deploy now](https://vercel.com/templates/ai/chatgpt-app-with-next-js)

[**准备好构建你自己的 ChatGPT 应用了吗？**\\
\\
将我们的 ChatGPT Apps SDK Next.js 入门模板一键部署至 Vercel，立即开始实验。\\
\\
立即部署](https://vercel.com/templates/ai/chatgpt-app-with-next-js)
&#123;% endraw %}
