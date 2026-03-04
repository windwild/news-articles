---
title: "Javascript SEO: How Google Crawls, Renders & Indexes JS - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-google-handles-javascript-throughout-the-indexing-process"
date: "2024-07-31"
scraped_at: "2026-03-02T09:42:08.809377886+00:00"
language: "en-zh"
translated: true
description: "Over the years, Google's treatment of JavaScript has changed, leaving us with misconceptions of how it's indexed. Here, we debunk the myths."
---
&#123;% raw %}

Jul 31, 2024

2024 年 7 月 31 日

MERJ 与 Vercel 联合开展研究，以实证方式揭开 Google 渲染机制的神秘面纱。

理解搜索引擎如何抓取、渲染和索引网页，对于网站的搜索引擎优化（SEO）至关重要。多年来，随着 Google 等搜索引擎不断调整其处理流程，开发者很难持续跟踪哪些技术有效、哪些已失效——尤其是涉及客户端 JavaScript 时。

我们注意到，一些陈旧的认知仍在业内广泛流传，导致社区对现代应用 SEO 的最佳实践始终存疑：

1. “Google 无法渲染客户端 JavaScript。”

2. “Google 对含 JavaScript 的网页采取不同处理方式。”

3. “渲染队列及渲染时机对 SEO 有显著影响。”

4. “重度依赖 JavaScript 的网站页面发现速度更慢。”

为验证并澄清上述认知，我们携手领先的 SEO 与数据工程咨询公司 [MERJ](https://merj.com/)，针对 Google 的抓取行为开展了新一轮实验研究。我们分析了跨多个网站的逾 10 万次 Googlebot 抓取请求，系统性地测试并验证了 Google 当前的 SEO 能力。

接下来，我们将回顾 Google 渲染机制的演进历程；随后，深入探讨本次研究的关键发现，及其对现代 Web 应用在真实场景中 SEO 表现的实际影响。

**Article contents:**

**文章目录：**

- [The evolution of Google's rendering capabilities](https://vercel.com/blog/how-google-handles-javascript-throughout-the-indexing-process#the-evolution-of-google%E2%80%99s-rendering-capabilities)

- [Google 渲染能力的演进历程](https://vercel.com/blog/how-google-handles-javascript-throughout-the-indexing-process#the-evolution-of-google%E2%80%99s-rendering-capabilities)

- [Methodology](https://vercel.com/blog/how-google-handles-javascript-throughout-the-indexing-process#methodology)

- [研究方法](https://vercel.com/blog/how-google-handles-javascript-throughout-the-indexing-process#methodology)

- [Myth 1: "Google can't render JavaScript content"](https://vercel.com/blog/how-google-handles-javascript-throughout-the-indexing-process#myth-1-%E2%80%9Cgoogle-can%E2%80%99t-render-javascript-content%E2%80%9D)

- [误区 1：“Google 无法渲染 JavaScript 内容”](https://vercel.com/blog/how-google-handles-javascript-throughout-the-indexing-process#myth-1-%E2%80%9Cgoogle-can%E2%80%99t-render-javascript-content%E2%80%9D)

- [Myth 2: "Google treats JavaScript pages differently"](https://vercel.com/blog/how-google-handles-javascript-throughout-the-indexing-process#myth-2-%E2%80%9Cgoogle-treats-javascript-pages-differently%E2%80%9D)

- [误区 2：“Google 对含 JavaScript 的网页区别对待”](https://vercel.com/blog/how-google-handles-javascript-throughout-the-indexing-process#myth-2-%E2%80%9Cgoogle-treats-javascript-pages-differently%E2%80%9D)

- [Myth 3: "Rendering queue and timing significantly impact SEO"](https://vercel.com/blog/how-google-handles-javascript-throughout-the-indexing-process#myth-3-%E2%80%9Crendering-queue-and-timing-significantly-impact-seo)

- [误区 3：“渲染队列与时机对 SEO 有显著影响”](https://vercel.com/blog/how-google-handles-javascript-throughout-the-indexing-process#myth-3-%E2%80%9Crendering-queue-and-timing-significantly-impact-seo)

- [Myth 4: "JavaScript-heavy sites have slower page discovery"](https://vercel.com/blog/how-google-handles-javascript-throughout-the-indexing-process#myth-4-%E2%80%9Cjavascript-heavy-sites-have-slower-page-discovery%E2%80%9D)

- [误区 4：“重度依赖 JavaScript 的网站页面发现速度更慢”](https://vercel.com/blog/how-google-handles-javascript-throughout-the-indexing-process#myth-4-%E2%80%9Cjavascript-heavy-sites-have-slower-page-discovery%E2%80%9D)

- [Overall implications and recommendations](https://vercel.com/blog/how-google-handles-javascript-throughout-the-indexing-process#overall-implications-and-recommendations)

- [总体影响与建议](https://vercel.com/blog/how-google-handles-javascript-throughout-the-indexing-process#overall-implications-and-recommendations)

- [Moving forward with new information](https://vercel.com/blog/how-google-handles-javascript-throughout-the-indexing-process#moving-forward-with-new-information)

- [基于新信息展望未来](https://vercel.com/blog/how-google-handles-javascript-throughout-the-indexing-process#moving-forward-with-new-information)

- [About MERJ](https://vercel.com/blog/how-google-handles-javascript-throughout-the-indexing-process#about-merj)

- [关于 MERJ](https://vercel.com/blog/how-google-handles-javascript-throughout-the-indexing-process#about-merj)

## The evolution of Google’s rendering capabilities

## 谷歌渲染能力的演进

Over the years, Google’s ability to crawl and index web content has significantly changed. Seeing this evolution is important to understand the current state of SEO for modern web applications.

多年来，谷歌抓取和索引网页内容的能力发生了显著变化。了解这一演进过程，对于把握现代 Web 应用当前的 SEO 现状至关重要。

### **Pre-2009: Limited JavaScript support**

### **2009 年之前：JavaScript 支持极为有限**

In the early days of search, Google primarily indexed static HTML content. JavaScript-generated content was largely invisible to search engines, leading to the widespread use of static HTML for SEO purposes.

在搜索引擎发展的早期阶段，谷歌主要索引静态 HTML 内容。由 JavaScript 生成的内容对搜索引擎而言基本不可见，因此业界普遍采用静态 HTML 来满足 SEO 需求。

### **2009–2015: AJAX crawling scheme**

### **2009–2015 年：AJAX 抓取方案**

Google introduced the AJAX crawling scheme, allowing websites to provide HTML snapshots of dynamically generated content. This was a stopgap solution that required developers to create separate, crawlable versions of their pages.

谷歌推出了 AJAX 抓取方案（AJAX Crawling Scheme），允许网站为动态生成的内容提供 HTML 快照。这是一种临时性解决方案，要求开发者为其页面额外构建独立的、可供爬虫抓取的版本。

### **2015–2018: Early JavaScript rendering**

### **2015–2018 年：初步的 JavaScript 渲染能力**

Google began rendering pages using a headless Chrome browser, marking a significant step forward. However, this older browser version still had limitations in processing modern JS features.

谷歌开始使用无头 Chrome 浏览器进行页面渲染，这标志着重大进步。然而，该较旧版本的浏览器在处理现代 JavaScript 特性方面仍存在局限性。

### **2018–present: Modern rendering capabilities**

### **2018 年至今：现代化渲染能力**

Today, Google uses an up-to-date version of Chrome for rendering, keeping pace with the latest web technologies. Key aspects of the current system include:

如今，谷歌采用最新版 Chrome 进行页面渲染，从而持续跟进最新的 Web 技术。当前系统的关键特性包括：

1. **Universal rendering:** Google now attempts to render all HTML pages, not just a subset.

1. **通用渲染：** Google 现在会尝试渲染所有 HTML 页面，而不仅限于其中一部分。

2. **Up-to-date browser:** Googlebot uses the latest stable version of Chrome/Chromium, supporting modern JS features.

2. **最新版浏览器：** Googlebot 使用最新稳定版的 Chrome/Chromium，支持现代 JavaScript 特性。

3. **Stateless rendering:** Each page render occurs in a fresh browser session, without retaining cookies or state from previous renders. Google will generally not click on items on the page, [such as tabbed content](https://merj.com/blog/12-experiments-for-tabbed-content-seo) or cookie banners.

3. **无状态渲染：** 每次页面渲染均在全新的浏览器会话中进行，不会保留此前渲染所生成的 Cookie 或其他状态信息。Google 通常不会点击页面上的任何元素，例如[标签式内容](https://merj.com/blog/12-experiments-for-tabbed-content-seo)或 Cookie 提示横幅。

4. **Cloaking**: Google prohibits showing different content to users and search engines to manipulate rankings. Avoid code that alters content based on `User-Agent`. Instead, optimize your app's stateless rendering for Google, and implement personalization through stateful methods.

4. **隐藏（Cloaking）：** Google 明令禁止向用户和搜索引擎展示不同内容，以操纵搜索排名。请避免编写依据 `User-Agent` 动态更改内容的代码。相反，应针对 Google 优化应用的无状态渲染能力，并通过有状态（stateful）方式实现个性化功能。

5. **Asset caching:** Google speeds up webpage rendering by caching assets, which is useful for pages sharing resources and for repeated renderings of the same page. Instead of using HTTP `Cache-Control` headers, [Google's Web Rendering Service employs its own internal heuristics](https://developers.google.com/search/docs/crawling-indexing/javascript/javascript-seo-basics#caching) to determine when cached assets are still fresh and when they need to be downloaded again.

5. **资源缓存：** Google 通过缓存网页资源来加速页面渲染，这对共享资源的多个页面以及同一页面的多次重复渲染尤为有益。Google 的网页渲染服务（Web Rendering Service）并不依赖 HTTP `Cache-Control` 响应头，而是[采用自身内部启发式算法](https://developers.google.com/search/docs/crawling-indexing/javascript/javascript-seo-basics#caching)来判断已缓存资源是否仍为最新，以及何时需要重新下载。

![Today, Google's indexing process looks something like this.](images/javascript-seo-how-google-crawls-renders-indexes-js-vercel/img_001.jpg)![Today, Google's indexing process looks something like this.](images/javascript-seo-how-google-crawls-renders-indexes-js-vercel/img_002.jpg)![Today, Google's indexing process looks something like this.](images/javascript-seo-how-google-crawls-renders-indexes-js-vercel/img_003.jpg)![Today, Google's indexing process looks something like this.](images/javascript-seo-how-google-crawls-renders-indexes-js-vercel/img_004.jpg)Today, Google's indexing process looks something like this.

![今天，Google 的索引构建流程大致如下所示。](images/javascript-seo-how-google-crawls-renders-indexes-js-vercel/img_001.jpg)![今天，Google 的索引构建流程大致如下所示。](images/javascript-seo-how-google-crawls-renders-indexes-js-vercel/img_002.jpg)![今天，Google 的索引构建流程大致如下所示。](images/javascript-seo-how-google-crawls-renders-indexes-js-vercel/img_003.jpg)![今天，Google 的索引构建流程大致如下所示。](images/javascript-seo-how-google-crawls-renders-indexes-js-vercel/img_004.jpg)今天，Google 的索引构建流程大致如下所示。

With a better understanding of what Google is capable of, let's look at some common myths and how they impact SEO.

在更深入理解 Google 当前能力的基础上，我们来探讨一些常见误区，以及它们对 SEO 的实际影响。

## Methodology

## 研究方法

To investigate the following myths, we conducted a study using Vercel’s infrastructure and MERJ’s Web Rendering Monitor (WRM) technology. Our research focused on [`nextjs.org`](http://nextjs.org/), with supplemental data from [`monogram.io`](http://monogram.io/) and [`basement.io`](http://basement.io/), spanning from April 1 to April 30, 2024.

为验证下述各项误区，我们依托 Vercel 的基础设施与 MERJ 的网页渲染监控（Web Rendering Monitor, WRM）技术开展了一项实证研究。本研究以 [`nextjs.org`](http://nextjs.org/) 为主要观测对象，并辅以 [`monogram.io`](http://monogram.io/) 和 [`basement.io`](http://basement.io/) 的补充数据，时间跨度为 2024 年 4 月 1 日至 4 月 30 日。

### Data collection

### 数据采集

We placed a custom [Edge Middleware](https://vercel.com/docs/functions/edge-middleware) on these sites to intercept and analyze requests from search engine bots. This middleware allowed us to:

我们在这些网站上部署了自定义的 [Edge Middleware](https://vercel.com/docs/functions/edge-middleware)，用于拦截并分析来自搜索引擎爬虫的请求。该中间件使我们能够：

1. Identify and track requests from various search engines and AI crawlers. (No user data was included in this query.)

1. 识别并追踪来自各类搜索引擎及 AI 爬虫的请求。（该查询中未包含任何用户数据。）

2. Inject a [lightweight JavaScript library](https://github.com/merj/wrm-research-vercel) in HTML responses for bots.

2. 向面向爬虫返回的 HTML 响应中注入一个 [轻量级 JavaScript 库](https://github.com/merj/wrm-research-vercel)。

The JavaScript library, triggered when a page finished rendering, sent data back to a long-running server, including:

该 JavaScript 库在页面完成渲染后被触发，并将数据回传至一个长期运行的服务器，所发送的数据包括：

- The page URL.

- 页面 URL。

- The unique request identifier (to match the page rendering against regular server access logs).

- 唯一请求标识符（用于将页面渲染事件与常规服务器访问日志进行匹配）。

- The timestamp of the rendering completion (this is calculated using the JavaScript Library request reception time on the server).

- 渲染完成的时间戳（该时间戳基于服务器接收到 JavaScript 库请求的时间计算得出）。

### Data analysis

### 数据分析

By comparing the initial request present in server access logs with the data sent from our middleware to an external beacon server, we could:

通过将服务器访问日志中记录的初始请求，与我们的中间件发送至外部信标（beacon）服务器的数据进行比对，我们得以：

1. Confirm which pages were successfully rendered by search engines.

1. 确认哪些页面已被搜索引擎成功渲染。

2. Calculate the time difference between the initial crawl and the completed render.

2. 计算初始抓取与完成渲染之间的时间差。

3. Analyze patterns in how different types of content and URLs were processed.

3. 分析不同类型内容和 URL 的处理模式。

### Data scope

### 数据范围

For this article, we primarily focused on data from Googlebot, which provided the largest and most reliable dataset. Our analysis included over 37,000 rendered HTML pages matched with server-beacon pairs, giving us a robust sample from which to draw conclusions.

本文主要聚焦于 Googlebot 的数据，因其提供了规模最大、最可靠的可用数据集。我们的分析涵盖了超过 37,000 个已渲染的 HTML 页面，并将其与服务端信标（server-beacon）配对，从而构建了一个足够稳健的样本，以支撑可靠结论。

We are still gathering data about other search engines, including AI providers like OpenAI and Anthropic, and hope to talk more about our findings in the future.

我们仍在持续收集其他搜索引擎（包括 OpenAI 和 Anthropic 等 AI 服务商）的相关数据，未来将就这些发现展开更深入的探讨。

In the following sections, we’ll dive into each myth, providing more relevant methodology as necessary.

在接下来的章节中，我们将逐一剖析每一条误解，并在必要时补充更相关的研究方法。

## Myth 1: “Google can’t render JavaScript content”

## 误解 1：“Google 无法渲染 JavaScript 内容”

This myth has led many developers to avoid JS frameworks or resort to complex workarounds for SEO.

这一误解导致许多开发者回避使用 JavaScript 框架，或为满足 SEO 需求而采用复杂变通方案。

### The test

### 测试方法

To test Google’s ability to render JavaScript content, we focused on three key aspects:

为验证 Google 渲染 JavaScript 内容的能力，我们重点关注以下三个核心维度：

1. **JS framework compatibility:** We analyzed Googlebot's interactions with Next.js using data from `nextjs.org`, which uses a mix of static prerendering, server-side rendering, and client-side rendering.

1. **JS 框架兼容性**：我们利用 `nextjs.org` 的数据，分析了 Googlebot 与 Next.js 的交互行为。该网站采用了静态预渲染、服务端渲染和客户端渲染相结合的方式。

2. **Dynamic content indexing**: We examined pages on `nextjs.org` that load content asynchronously via API calls. This allowed us to determine if Googlebot could process and index content not present in the initial HTML response.

2. **动态内容索引**：我们检查了 `nextjs.org` 上通过 API 调用异步加载内容的页面，借此判断 Googlebot 是否能够处理并索引初始 HTML 响应中未包含的内容。

3. **Streamed content via React Server Components (RSCs):** Similar to the above, much of `nextjs.org` is built with the [Next.js App Router](https://nextjs.org/docs/app) and [RSCs](https://vercel.com/blog/understanding-react-server-components?nxtPslug=understanding-react-server-components). We could see how Googlebot processed and indexed content incrementally streamed to the page.

3. **通过 React Server Components（RSC）流式传输的内容**：与上述类似，`nextjs.org` 的大部分页面基于 [Next.js App Router](https://nextjs.org/docs/app) 和 [RSC](https://vercel.com/blog/understanding-react-server-components?nxtPslug=understanding-react-server-components) 构建。我们得以观察 Googlebot 如何处理并索引逐步流式传输至页面的内容。

4. **Rendering success rate**: We compared the number of Googlebot requests in our server logs to the number of successful rendering beacons received. This gave us insight into what percentage of crawled pages were fully rendered.

4. **渲染成功率**：我们将服务器日志中的 Googlebot 请求次数与接收到的成功渲染信标（rendering beacon）数量进行了对比，从而了解被爬取页面中完成完整渲染的比例。

### Our findings

### 我们的发现

1. Out of over 100,000 Googlebot fetches analyzed on `nextjs.org`, excluding status code errors and non-indexable pages, **100% of HTML pages resulted in full-page renders, including pages with complex JS interactions.**

1. 在对 `nextjs.org` 超过 10 万次 Googlebot 抓取请求的分析中（排除状态码错误及不可索引页面），**所有 HTML 页面均完成了整页渲染，包括含有复杂 JavaScript 交互的页面。**

2. All content loaded asynchronously via API calls was successfully indexed, demonstrating Googlebot's ability to process dynamically loaded content.

2. 所有通过 API 调用异步加载的内容均被成功索引，证明 Googlebot 具备处理动态加载内容的能力。

3. Next.js, a React-based framework, was fully rendered by Googlebot, confirming compatibility with modern JavaScript frameworks.

3. 基于 React 的框架 Next.js 已被 Googlebot 完全渲染，证实其与现代 JavaScript 框架完全兼容。

4. Streamed content via RSCs was also fully rendered, confirming that [streaming does not adversely impact SEO](https://vercel.com/guides/does-streaming-affect-seo).

4. 通过 RSC 流式传输的内容同样实现了完整渲染，证实了 [流式传输不会对 SEO 造成负面影响](https://vercel.com/guides/does-streaming-affect-seo)。

5. Google attempts to render virtually all HTML pages it crawls, not just a subset of JavaScript-heavy pages.

5. Google 会尝试渲染其抓取的几乎所有 HTML 页面，而不仅限于部分 JavaScript 密集型页面。

## Myth 2: “Google treats JavaScript pages differently”

## 迷思 2：“Google 对含 JavaScript 的网页区别对待”

A common misconception is that Google has a separate process or criteria for JavaScript-heavy pages. Our research, combined with [official statements from Google](https://www.youtube.com/watch?v=XBT_DUzUbOI), debunks this myth.

一个常见的误解是：Google 对 JavaScript 密集型网页拥有一套独立的处理流程或评判标准。我们的研究结合了 [Google 的官方声明](https://www.youtube.com/watch?v=XBT_DUzUbOI)，有力地驳斥了这一迷思。

### The test

### 测试方法

To test where Google treats JS-heavy pages differently, we took several targeted approaches:

为验证 Google 是否在某些环节对 JavaScript 密集型网页区别对待，我们采用了若干有针对性的测试方法：

1. **CSS** **`@import`** **test:** We created a test page _without_ JavaScript, but _with_ a CSS file that `@imports` a second CSS file (which would only be downloaded and present in server logs upon rendering the first CSS file). By comparing this behavior to JS-enabled paged, we could verify if Google’s renderer processes CSS any differently with and without JS enabled.

1. **CSS `@import` 测试**：我们构建了一个 *不含 JavaScript* 的测试页面，但其 CSS 文件中使用 `@import` 引入了第二个 CSS 文件（该文件仅在浏览器（或渲染器）解析并渲染第一个 CSS 文件时才会被下载，并出现在服务器日志中）。通过将此行为与启用 JavaScript 的页面进行对比，我们得以验证 Google 渲染器在启用/禁用 JavaScript 的情况下，对 CSS 的处理是否存在差异。

2. **Status code and meta tag handling:** We developed a Next.js application with middleware to test various HTTP status codes with Google. Our analysis focused on how Google processes pages with different status codes (200, 304, 3xx, 4xx, 5xx) and those with `noindex` meta tags. This helped us understand if JavaScript-heavy pages are treated differently in these scenarios.

2. **HTTP 状态码与 meta 标签处理**：我们开发了一个带中间件（middleware）的 Next.js 应用，用于向 Google 测试多种 HTTP 状态码。我们的分析聚焦于 Google 如何处理不同状态码（200、304、3xx、4xx、5xx）的页面，以及包含 `noindex` meta 标签的页面。这有助于我们判断在这些场景下，JavaScript 密集型网页是否受到区别对待。

3. **JavaScript complexity analysis**: We compared Google's rendering behavior across pages with varying levels of JS complexity on [nextjs.org](http://nextjs.org/). This included pages with minimal JS, those with moderate interactivity, and highly dynamic pages with extensive client-side rendering. We also calculated and compared the time between the initial crawl and the completed render to see if more complex JS led to longer rendering queues or processing times.

3. **JavaScript 复杂度分析**：我们在 [nextjs.org](http://nextjs.org/) 上对比了 Google 对不同 JavaScript 复杂度页面的渲染行为。测试对象包括：JavaScript 极少的页面、具备中等交互性的页面，以及大量依赖客户端渲染的高度动态页面。我们还计算并比较了“初始抓取”到“渲染完成”之间的时间间隔，以观察更复杂的 JavaScript 是否会导致更长的渲染排队时间或处理耗时。

### Our findings

### 我们的发现

1. Our CSS `@import` test confirmed that Google successfully renders pages with or without JS.

1. CSS `@import` 测试证实：无论页面是否包含 JavaScript，Google 均能成功完成渲染。

2. Google renders _all_ 200 status HTML pages, regardless of JS content. Pages with 304 status are rendered using the content of the original 200 status page. Pages with other 3xx, 4xx, and 5xx errors were not rendered.

2. Google 会渲染 *所有* 返回 200 状态码的 HTML 页面，且不受其中 JavaScript 内容多少的影响；返回 304 状态码的页面，则复用原始 200 状态页的内容进行渲染；而其他 3xx、4xx 和 5xx 类错误状态的页面则 *不会被渲染*。

3. 初始 HTML 响应中包含 `noindex` meta 标签的页面不会被渲染，无论其 JavaScript 内容如何。**在客户端移除 `noindex` 标签对 SEO _无效_；** 如果页面在初始 HTML 响应中即包含 `noindex` 标签，则该页面不会被渲染，用于移除该标签的 JavaScript 代码也不会被执行。

4. 我们未发现 Google 渲染不同 JavaScript 复杂度页面的成功率存在显著差异。在 `nextjs.org` 的规模下，我们也未发现 JavaScript 复杂度与渲染延迟之间存在相关性。然而，在规模大得多的网站上，更复杂的 JavaScript **可能影响抓取效率**（[参见相关文档](https://developers.google.com/search/docs/crawling-indexing/large-site-managing-crawl-budget)）。

## Myth 3: “渲染队列与时机对 SEO 有重大影响”

## 误区三：“渲染队列与时机对 SEO 有重大影响”

许多 SEO 从业者认为，JavaScript 密集型页面会因渲染队列而面临显著的索引延迟。我们的研究为此过程提供了更清晰的认识。

### 测试方案

### 测试方案

为探究渲染队列与时机对 SEO 的影响，我们开展了以下调查：

1. **渲染延迟：** 我们利用 `nextjs.org` 上超过 37,000 对匹配的服务器—信标（server-beacon）数据，分析了 Google 首次抓取某页面与其完成渲染之间的时间差。

2. **URL 类型：** 我们对比分析了带查询参数（query string）与不带查询参数的 URL 的渲染耗时，并考察了 `nextjs.org` 不同版块（例如 `/docs`、`/learn`、`/showcase`）的渲染时间。

3. **频率模式：** 我们研究了 Google 对页面进行重新渲染的频次，并分析了不同类型内容的渲染频次是否存在特定规律。

### 我们的发现

### 我们的发现

The rendering delay distribution was as follows:

渲染延迟分布如下：

- 50th percentile (median): 10 seconds.

- 第50百分位数（中位数）：10 秒。

- 75th percentile: 26 seconds

- 第75百分位数：26 秒

- 90th percentile: ~3 hours

- 第90百分位数：约 3 小时

- 95th percentile: ~6 hours

- 第95百分位数：约 6 小时

- 99th percentile: ~18 hours

- 第99百分位数：约 18 小时


![The exact rendering delay distribution we found across over 37,000 matched server-beacon pairs.](images/javascript-seo-how-google-crawls-renders-indexes-js-vercel/img_005.jpg)![The exact rendering delay distribution we found across over 37,000 matched server-beacon pairs.](images/javascript-seo-how-google-crawls-renders-indexes-js-vercel/img_006.jpg)![The exact rendering delay distribution we found across over 37,000 matched server-beacon pairs.](images/javascript-seo-how-google-crawls-renders-indexes-js-vercel/img_007.jpg)![The exact rendering delay distribution we found across over 37,000 matched server-beacon pairs.](images/javascript-seo-how-google-crawls-renders-indexes-js-vercel/img_008.jpg)The exact rendering delay distribution we found across over 37,000 matched server-beacon pairs.

![我们通过对超过 37,000 对匹配的服务器–信标（server-beacon）数据所得到的精确渲染延迟分布。](images/javascript-seo-how-google-crawls-renders-indexes-js-vercel/img_005.jpg)![我们通过对超过 37,000 对匹配的服务器–信标（server-beacon）数据所得到的精确渲染延迟分布。](images/javascript-seo-how-google-crawls-renders-indexes-js-vercel/img_006.jpg)![我们通过对超过 37,000 对匹配的服务器–信标（server-beacon）数据所得到的精确渲染延迟分布。](images/javascript-seo-how-google-crawls-renders-indexes-js-vercel/img_007.jpg)![我们通过对超过 37,000 对匹配的服务器–信标（server-beacon）数据所得到的精确渲染延迟分布。](images/javascript-seo-how-google-crawls-renders-indexes-js-vercel/img_008.jpg)我们通过对超过 37,000 对匹配的服务器–信标（server-beacon）数据所得到的精确渲染延迟分布。

Surprisingly, the 25th percentile of pages were rendered within 4 seconds of the initial crawl, challenging the notion of a long “queue.”

令人惊讶的是，有 25% 的页面在首次抓取后 4 秒内即完成渲染，这挑战了“长队列”这一固有认知。

While some pages faced significant delays (up to ~18 hours at the 99th percentile), these were the exception and not the rule.

尽管部分页面遭遇了显著延迟（第99百分位数达约 18 小时），但这些属于例外情况，而非普遍规律。

We also observed interesting patterns related to how quickly Google renders URLs with query strings (?param=xyz):

我们还观察到一些有趣的现象，涉及 Google 渲染带查询参数（`?param=xyz`）的 URL 的速度：

| **URL Type** | **50th Percentile** | **75th Percentile** | **90th Percentile** |
| --- | --- | --- | --- |
| **All URLs** | 10 seconds | 26 seconds | ~3 hours |
| **All URLs（所有 URL）** | 10 秒 | 26 秒 | 约 3 小时 |
| **URLs without Query String** | 10 seconds | 22 seconds | ~2.5 hours |
| **不含查询字符串的 URL（URLs without Query String）** | 10 秒 | 22 秒 | 约 2.5 小时 |
| **URLs with Query String** | 13 seconds | 31 minutes | ~8.5 hours |
| **含查询字符串的 URL（URLs with Query String）** | 13 秒 | 31 分钟 | 约 8.5 小时 |

This data suggests that Google treats URLs differently if they have query strings that don't affect the content. For example, on `nextjs.org`, pages with `?ref=` parameters experienced longer rendering delays, especially at higher percentiles.

该数据表明，当 URL 中包含不影响页面内容的查询字符串时，Google 会以不同方式处理这些 URL。例如，在 `nextjs.org` 网站上，带有 `?ref=` 参数的页面渲染延迟更长，且在更高百分位（如 90th Percentile）下尤为明显。

Additionally, we noticed that frequently updated sections like `/docs` had shorter median rendering times compared to more static sections. For example, the `/showcase` page, despite being frequently linked, showed longer rendering times, suggesting that Google may slow down re-rendering for pages that don't change significantly.

此外，我们注意到，像 `/docs` 这类频繁更新的版块，其中位数渲染耗时明显短于更静态的版块。例如，尽管 `/showcase` 页面被大量链接引用，其渲染耗时却更长——这表明 Google 可能会降低对内容变化不显著页面的重新渲染频率。

## Myth 4: “JavaScript-heavy sites have slower page discovery”

## 误区 4：“JavaScript 密集型网站的页面发现速度更慢”

A persistent belief in the SEO community is that JavaScript-heavy sites, especially those relying on client-side rendering (CSR) like Single Page Applications (SPAs), suffer from slower page discovery by Google. Our research provides new insights here.

SEO 社区中长期存在一种观点：JavaScript 密集型网站（尤其是依赖客户端渲染（CSR）的单页应用（SPA））会被 Google 更慢地发现页面。我们的研究为此提供了新的洞见。

### The test

### 测试方案

To investigate the impact of JavaScript on page discovery, we:

为探究 JavaScript 对页面发现的影响，我们进行了以下操作：

1. **Analyzed link discovery in different rendering scenarios:** We compared how quickly Google discovered and crawled links in server-rendered, statically generated, and client-side rendered pages on [nextjs.org](http://nextjs.org/).

1. **在不同渲染场景下分析链接发现情况：** 我们对比了 Google 在 [nextjs.org](http://nextjs.org/) 网站上对服务端渲染（SSR）、静态生成（SSG）和客户端渲染（CSR）页面中链接的发现与抓取速度。

2. **Tested non-rendered JavaScript payloads:** We added a JSON object similar to a React Server Component (RSC) payload to the `/showcase` page of [nextjs.org](http://nextjs.org/), containing links to new, previously undiscovered pages. This allowed us to test if Google could discover links in JavaScript data that wasn’t rendered.

2. **测试未渲染的 JavaScript 负载：** 我们在 [nextjs.org](http://nextjs.org/) 的 `/showcase` 页面中添加了一个类似 React Server Component（RSC）负载的 JSON 对象，其中包含指向若干全新且此前未被 Google 发现页面的链接。此举旨在验证 Google 是否能从未经渲染的 JavaScript 数据中识别并发现链接。

3. **Compared discovery times:** We monitored how quickly Google discovered and crawled new pages linked in different ways: standard HTML links, links in client-side rendered content, and links in non-rendered JavaScript payloads.

3. **对比页面发现耗时：** 我们监测了 Google 发现并抓取新页面的速度，这些新页面分别通过三种方式被链接：标准 HTML 链接、客户端渲染内容中的链接，以及未渲染 JavaScript 负载中的链接。

### Our findings

### 我们的发现

1. Google 成功发现并抓取了完全渲染页面中的链接，且不受渲染方式影响。

2. Google 能够发现页面中未渲染的 JavaScript 有效载荷（payload）内的链接，例如 React Server Components（RSC）或类似结构中的链接。

3. 在初始 HTML 和渲染后的 HTML 中，Google 均通过识别形似 URL 的字符串来解析内容，并以当前主机名和端口作为相对 URL 的基准。（Google _并未_ 在我们模拟 RSC 的有效载荷中发现经过编码的 URL——例如 `https%3A%2F%2Fwebsite.com`——表明其链接解析机制极为严格。）

4. 链接的来源与格式（例如是否位于 `<a>` 标签内，抑或嵌入 JSON 有效载荷中）并不影响 Google 对其抓取优先级的判定；无论 URL 是在初始 HTML 抓取阶段还是在页面渲染后被发现，其抓取优先级均保持一致。

5. 尽管 Google 能成功发现客户端渲染（CSR）页面中的链接，但这些页面仍需先完成渲染。相较而言，服务端渲染（SSR）页面或部分预渲染页面在链接的即时发现方面具备轻微优势。

6. Google 明确区分“链接发现”（link discovery）与“链接价值评估”（link value assessment）：对链接在网站架构及抓取优先级中所起作用的价值评估，是在整页完成渲染之后进行的。

7. 拥有最新更新的 `sitemap.xml` 文件可显著缩短（甚至完全消除）不同渲染模式之间在链接发现时效性上的差异。

## Overall implications and recommendations

## 整体影响与建议

Our research has debunked several common myths about Google's handling of JavaScript-heavy websites. Here are the key takeaways and actionable recommendations:

本研究已证伪多个关于 Google 如何处理重度依赖 JavaScript 网站的常见误解。以下是核心结论与可落地的优化建议：

### Implications

### 影响与启示

1. **JavaScript 兼容性：** Google 能够有效渲染并索引 JavaScript 内容，包括复杂的单页应用（SPA）、动态加载的内容以及流式传输的内容。

2. **渲染一致性：** Google 处理重度依赖 JavaScript 的页面与处理静态 HTML 页面之间，并无本质区别——所有页面均会被渲染。

3. **渲染队列的实际情况：** 尽管确实存在渲染队列，但其实际影响远小于以往认知。大多数页面可在数分钟内完成渲染，而非数天或数周。

4. **页面发现机制：** 重度依赖 JavaScript 的网站（包括 SPA）在 Google 的页面发现过程中，并不天然处于劣势。

5. **内容时机的重要性：** 某些元素（例如 `noindex` 标签）被添加到页面中的时间点至关重要，因为 Google 可能无法识别或处理客户端运行时的变更。

6. **链接价值评估机制：** Google 明确区分“链接发现”（link discovery）与“链接价值评估”（link value assessment）；后者仅在整页完成渲染后才进行。

7. **渲染优先级机制：** Google 的渲染过程并非严格遵循先入先出（FIFO）原则。内容的新鲜度和更新频率，比 JavaScript 的复杂程度更能影响渲染优先级排序。

8. **渲染性能与抓取配额：** 尽管 Google 能够高效地渲染 JavaScript 密集型页面，但该过程对您自身服务器及 Google 的资源消耗均高于静态 HTML 页面。对于大型网站（拥有 10,000+ 个唯一且频繁更新的页面），这可能[影响网站的抓取配额（crawl budget）](https://developers.google.com/search/docs/crawling-indexing/large-site-managing-crawl-budget)。优化应用性能、减少不必要的 JavaScript，有助于加快渲染速度、提升抓取效率，并可能使更多页面得以被成功抓取、渲染和索引。

### Recommendations

### 建议

1. **Embrace JavaScript:** Leverage JavaScript frameworks freely for enhanced user and developer experiences, but prioritize performance and adhere to [Google's best practices for lazy-loading](https://developers.google.com/search/docs/crawling-indexing/javascript/lazy-loading).

1. **拥抱 JavaScript：** 可自由使用 JavaScript 框架以提升用户体验和开发者体验，但须优先保障性能，并遵循 [Google 关于懒加载的最佳实践](https://developers.google.com/search/docs/crawling-indexing/javascript/lazy-loading)。

2. **Error handling:** Implement [error boundaries](https://react.dev/reference/react/Component#catching-rendering-errors-with-an-error-boundary) in React applications to prevent total render failures due to individual component errors.

2. **错误处理：** 在 React 应用中实现 [错误边界（error boundaries）](https://react.dev/reference/react/Component#catching-rendering-errors-with-an-error-boundary)，防止因单个组件出错而导致整个页面渲染失败。

3. **Critical SEO elements:** Use server-side rendering or static generation for critical SEO tags and important content to ensure they're present in the initial HTML response.

3. **关键 SEO 元素：** 对关键 SEO 标签及重要内容，采用服务端渲染（SSR）或静态生成（SSG），确保其在初始 HTML 响应中即已存在。

4. **Resource management:** Ensure [critical resources for rendering](https://merj.com/blog/managing-webpages-resources-for-efficient-crawling-and-rendering) (APIs, JavaScript files, CSS files) are not blocked by `robots.txt`.

4. **资源管理：** 确保 [渲染所依赖的关键资源](https://merj.com/blog/managing-webpages-resources-for-efficient-crawling-and-rendering)（如 API、JavaScript 文件、CSS 文件）未被 `robots.txt` 屏蔽。

5. **Content updates:** For content that needs to be quickly re-indexed, ensure changes are reflected in the server-rendered HTML, not just in client-side JavaScript. Consider strategies like [Incremental Static Regeneration](https://vercel.com/docs/incremental-static-regeneration#differences-between-isr-and-cache-control-headers) to balance content freshness with SEO and performance.

5. **内容更新：** 对需快速重新索引的内容，确保变更体现在服务端渲染的 HTML 中，而不仅限于客户端 JavaScript。可考虑采用 [增量静态再生（ISR）](https://vercel.com/docs/incremental-static-regeneration#differences-between-isr-and-cache-control-headers) 等策略，在内容时效性、SEO 效果与性能之间取得平衡。

6. **Internal linking and URL structure:** Create a clear, logical internal linking structure. Implement important navigational links as real HTML anchor tags (`<a href="...">`) rather than JavaScript-based navigation. This approach aids both user navigation and search engine crawling efficiency while potentially reducing rendering delays.

6. **内部链接与 URL 结构：** 构建清晰、合乎逻辑的内部链接结构。将重要导航链接实现为真实的 HTML 锚点标签（`<a href="...">`），而非基于 JavaScript 的导航。该方式既有利于用户浏览，也提升搜索引擎爬取效率，同时可能减少渲染延迟。

7. **Sitemaps:** [Use and regularly update sitemaps](https://developers.google.com/search/docs/crawling-indexing/sitemaps/overview). For large sites or those with frequent updates, use the `<lastmod>` tag in XML sitemaps to guide Google's crawling and indexing processes. Remember to update the `<lastmod>` only when a significant content update occurs.

7. **站点地图（Sitemaps）：** [使用并定期更新站点地图](https://developers.google.com/search/docs/crawling-indexing/sitemaps/overview)。对于大型网站或内容频繁更新的网站，可在 XML 站点地图中使用 `<lastmod>` 标签，以指导 Google 的爬取与索引行为。请注意：仅当发生实质性内容更新时，才需更新 `<lastmod>` 字段。

8. **Monitoring:** Use Google Search Console's [URL Inspection Tool](https://support.google.com/webmasters/answer/9012289?hl=en) or [Rich Results Tool](https://search.google.com/test/rich-results) to verify how Googlebot sees your pages. Monitor crawl stats to ensure your chosen rendering strategy isn't causing unexpected issues.

8. **监控：** 使用 Google 搜索中心的 [URL 检查工具](https://support.google.com/webmasters/answer/9012289?hl=zh-cn) 或 [富媒体搜索结果测试工具](https://search.google.com/test/rich-results)，验证 Googlebot 如何解析您的网页。持续监测爬取统计信息，确保所选渲染策略未引发意外问题。

## Moving forward with new information

## 基于新信息持续推进

As we’ve explored, there are some differences between [rendering strategies](https://vercel.com/blog/how-to-choose-the-best-rendering-strategy-for-your-app) when it comes to Google’s abilities:

正如我们所探讨的，就 Google 的能力而言，各类 [渲染策略](https://vercel.com/blog/how-to-choose-the-best-rendering-strategy-for-your-app) 之间存在一定差异：

| **Feature** | **Static Site Generation (SSG)** | **Incremental Static Regeneration (ISR)** | **Server-Side Rendering (SSR)** | **Client-Side Rendering (CSR)** |
| --- | --- | --- | --- | --- |
| **Crawl efficiency:** How quickly and effectively Google can access, render, and retrieve webpages. | Excellent | Excellent | Very Good | Poor |
| **抓取效率：** Google 访问、渲染和获取网页的速度与有效性。 | 优秀 | 优秀 | 很好 | 较差 |
| **Discovery:** The process of finding new URLs to crawl.\* | Excellent | Excellent | Excellent | Average |
| **发现（Discovery）：** 查找待抓取新 URL 的过程。\* | 优秀 | 优秀 | 优秀 | 一般 |
| **Rendering completeness (errors, failures, etc):** How accurately and completely Google can load and process your web pages without errors. | Robust | Robust | Robust | Might fail\*\* |
| **渲染完整性（错误、失败等）：** Google 加载并处理您网页时的准确性与完整性，即是否无错误完成。 | 稳健 | 稳健 | 稳健 | 可能失败\*\* |
| **Rendering time:** How long Google takes to fully render and process web pages. | Excellent | Excellent | Excellent | Poor |
| **渲染耗时：** Google 完全渲染并处理网页所需的时间。 | 优秀 | 优秀 | 优秀 | 较差 |
| **Link structure evaluation:** How Google assesses links to understand the website architecture and pages' importance. | After rendering | After rendering | After rendering | After rendering, links might be missing if rendering fails |
| **链接结构评估：** Google 如何通过分析链接来理解网站架构及各页面的重要性。 | 渲染完成后 | 渲染完成后 | 渲染完成后 | 渲染完成后；若渲染失败，则部分链接可能缺失 |
| **Indexing:** The process by which Google stores and organizes your site's content. | Robust | Robust | Robust | Might not be indexed if rendering fails |
| **索引（Indexing）：** Google 存储并组织您网站内容的过程。 | 稳健 | 稳健 | 稳健 | 若渲染失败，则可能无法被索引 |

\\* Having an updated `sitemap.xml` significantly reduces, if not eliminates, the time-to-discovery differences between different rendering patterns.  
\\* 若拥有更新及时的 `sitemap.xml`，不同渲染模式之间的“发现时间”差异将大幅缩短，甚至完全消除。

\\*\\* Rendering in Google usually doesn't fail, as proven in our research; when it does, it's often due to blocked resources in `robots.txt` or specific edge cases.  
\\*\\* 根据我们的研究，Google 的渲染通常不会失败；若发生失败，往往源于 `robots.txt` 中屏蔽了必要资源，或某些特定边缘情况。

These fine-grained differences exist, but Google will quickly discover and index your site regardless of rendering strategy. Focus on creating performant web applications that benefit users more than worrying about special accommodations for Google's rendering process.  
尽管存在上述细微差异，但无论采用何种渲染策略，Google 都能快速发现并索引您的网站。请将重心放在构建高性能的 Web 应用上——这更能惠及用户，远比为适配 Google 渲染流程而做特殊调整更有价值。

After all, **page speed is still a ranking factor,** since Google’s page experience ranking system evaluates the performance of your site based on Google’s [Core Web Vitals](https://developers.google.com/search/docs/appearance/core-web-vitals) metrics.  
毕竟，**页面加载速度仍是影响搜索排名的关键因素之一**，因为 Google 的“页面体验（Page Experience）”排名系统正是基于其 [核心网页指标（Core Web Vitals）](https://developers.google.com/search/docs/appearance/core-web-vitals) 来评估您网站的性能表现。

Plus, page speed is linked to good user experience—with every 100ms of load time saved [correlated to an 8% uptick in website conversion](https://www2.deloitte.com/content/dam/Deloitte/ie/Documents/Consulting/Milliseconds_Make_Millions_report.pdf). Fewer users bouncing off your page means Google treats it as more relevant. Performance compounds; milliseconds matter.  
此外，页面速度与良好的用户体验密切相关——每减少 100 毫秒的加载时间，[网站转化率平均提升约 8%](https://www2.deloitte.com/content/dam/Deloitte/ie/Documents/Consulting/Milliseconds_Make_Millions_report.pdf)。跳出率越低，Google 越倾向于认为该页面更具相关性。性能优势具有累积效应；毫秒之差，至关重要。

### Further resources  
### 延伸阅读资源

To learn more about these topics, we recommend:  
如需深入了解上述主题，我们推荐以下资源：

- [**How Core Web Vitals affect your SEO**](https://vercel.com/blog/how-core-web-vitals-affect-seo-giuMUCEQOZjD5Q1z65gix) **:** Provides a comprehensive overview of how Core Web Vitals (CWVs) affect SEO, explaining Google's page experience ranking system and the difference between field data (used for ranking) and lab data (Lighthouse scores).  
- [**核心网页指标（CWV）如何影响您的 SEO**](https://vercel.com/blog/how-core-web-vitals-affect-seo-giuMUCEQOZjD5Q1z65gix) **：** 全面解析核心网页指标（CWV）对 SEO 的影响，详解 Google 的“页面体验”排名机制，并阐明用于排名的“现场数据（Field Data）”与用于诊断的“实验室数据（Lab Data，如 Lighthouse 分数）”之间的区别。

- [**How to choose the right rendering strategy**](https://vercel.com/blog/how-to-choose-the-best-rendering-strategy-for-your-app) **:** Guides developers in choosing optimal rendering strategies for web applications, explaining various methods like SSG, ISR, SSR, and CSR, their use cases, and implementation considerations using Next.js.  
- [**如何为您的应用选择最合适的渲染策略**](https://vercel.com/blog/how-to-choose-the-best-rendering-strategy-for-your-app) **：** 为开发者提供 Web 应用渲染策略选型指南，详细说明静态站点生成（SSG）、增量静态再生（ISR）、服务端渲染（SSR）与客户端渲染（CSR）等各类方案的适用场景及使用 Next.js 实现时的关键考量。

- [**The user experience of the Frontend Cloud**](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud-43fi9hfOeVbRkJN0nZiik7) **:** Explains how Vercel's Frontend Cloud enables fast, personalized web experiences by combining advanced caching strategies, Edge Network capabilities, and flexible rendering options to optimize both user experience and developer productivity.

- [**前端云的用户体验**](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud-43fi9hfOeVbRkJN0nZiik7) **：** 本文阐述了 Vercel 前端云如何通过融合先进的缓存策略、边缘网络（Edge Network）能力以及灵活的渲染选项，实现快速、个性化的网页体验，从而同时优化终端用户使用体验与开发者生产力。

[**Trusted by performance-critical applications.**\\  
\\  
Next.js and Vercel automatically optimize the performance of your application to meet today’s high standards. We can walk you through how it works for your application.\\  
\\  
Contact Us](https://vercel.com/contact/sales)

[**备受高性能关键型应用信赖。**\\  
\\  
Next.js 与 Vercel 可自动优化您应用的性能，以满足当今严苛的性能标准。我们可为您详细讲解该优化机制在您具体应用中的运作方式。\\  
\\  
联系我们](https://vercel.com/contact/sales)

## About MERJ

## 关于 MERJ

MERJ is a leading SEO and data engineering consultancy specializing in technical SEO and performance optimization for complex web applications.

MERJ 是一家领先的 SEO 与数据工程咨询公司，专注于为复杂 Web 应用提供技术型 SEO 与性能优化服务。

With a track record of success across various industries, MERJ brings cutting-edge expertise to help businesses navigate the ever-evolving landscape of search engine optimization.

凭借在多个行业成功落地的丰富经验，MERJ 以前沿的专业能力，助力企业从容应对搜索引擎优化（SEO）领域持续演进的挑战。

If you need assistance with any of the SEO topics raised in this research, or if you're looking to optimize your web application for better search visibility and performance, don't hesitate to [contact MERJ](https://merj.com/).

若您需要就本项研究中提及的任一 SEO 话题获得支持，或希望优化您的 Web 应用以提升搜索可见性与整体性能，请随时 [联系 MERJ](https://merj.com/)。
&#123;% endraw %}
