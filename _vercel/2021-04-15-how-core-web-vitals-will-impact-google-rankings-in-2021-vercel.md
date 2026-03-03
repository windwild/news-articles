---
title: "How Core Web Vitals Will Impact Google Rankings in 2021 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/core-web-vitals"
date: "2021-04-15"
scraped_at: "2026-03-02T10:05:13.709959726+00:00"
language: "en-zh"
translated: true
description: "Landing a top spot on Google can have a multi-million dollar impact on your business. Starting in June 2021, the performance of your site (determined by Core Web Vitals) will be critical to your searc..."
---

Apr 15, 2021

2021年4月15日

Beginning this June, Google will add [Core Web Vitals](https://web.dev/vitals/) to its [Page Experience](https://developers.google.com/search/docs/guides/page-experience) ranking signal. Google [announced](https://developers.google.com/search/blog/2020/05/evaluating-page-experience) last year that changes were coming to the way its algorithm ranks pages that went beyond how quickly pages were loaded, safe-browsing, HTTPS, and their mobile-friendliness.

从今年6月起，Google 将把 [Core Web Vitals（核心网页指标）](https://web.dev/vitals/) 纳入其 [Page Experience（页面体验）](https://developers.google.com/search/docs/guides/page-experience) 排名信号体系。Google 去年曾[宣布](https://developers.google.com/search/blog/2020/05/evaluating-page-experience)，其搜索算法对网页的排名机制将发生调整——今后不仅会考量页面加载速度、安全浏览（safe browsing）、HTTPS 使用情况以及移动设备适配性，还将纳入更多维度。

Core Web Vitals evaluate speed, responsiveness, and visual stability of pages and prioritize the site in rankings based on the outcomes of these scores. This means your site performance has a direct impact on SEO and your business.

Core Web Vitals 用于评估网页的速度、交互响应性与视觉稳定性，并依据这些指标的得分结果对网站进行排名排序。这意味着，您的网站性能将直接影响搜索引擎优化（SEO）效果及业务表现。

![Search signals are the characteristics of your webpage that determine its Google ranking. Soon, the components of Core Web Vitals will be added to the list of signals to keep in mind when looking to improve SEO. ](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_001.jpg)![Search signals are the characteristics of your webpage that determine its Google ranking. Soon, the components of Core Web Vitals will be added to the list of signals to keep in mind when looking to improve SEO. ](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_002.jpg)Search signals are the characteristics of your webpage that determine its Google ranking. Soon, the components of Core Web Vitals will be added to the list of signals to keep in mind when looking to improve SEO.

![搜索信号（Search signals）是指决定您网页在 Google 中排名的关键特征。不久之后，Core Web Vitals 的各项指标也将被加入这一信号列表，成为您开展 SEO 优化工作时需重点关注的因素。](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_001.jpg)![搜索信号（Search signals）是指决定您网页在 Google 中排名的关键特征。不久之后，Core Web Vitals 的各项指标也将被加入这一信号列表，成为您开展 SEO 优化工作时需重点关注的因素。](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_002.jpg)搜索信号（Search signals）是指决定您网页在 Google 中排名的关键特征。不久之后，Core Web Vitals 的各项指标也将被加入这一信号列表，成为您开展 SEO 优化工作时需重点关注的因素。

In this post, we’ll take a look at:

本文将重点探讨以下内容：

- [What are Core Web Vitals and How Do They Impact SEO?](https://vercel.com/blog/core-web-vitals#what-are-core-web-vitals-and-how-do-they-impact-seo)

- [什么是 Core Web Vitals？它们如何影响 SEO？](https://vercel.com/blog/core-web-vitals#what-are-core-web-vitals-and-how-do-they-impact-seo)

- [Improving Website Performance to Increase Google Ranking](https://vercel.com/blog/core-web-vitals#improving-website-performance-to-increase-google-ranking)

- [如何提升网站性能以提高 Google 排名](https://vercel.com/blog/core-web-vitals#improving-website-performance-to-increase-google-ranking)

- [How to Measure Core Web Vitals and Understand Scoring](https://vercel.com/blog/core-web-vitals#how-to-measure-core-web-vitals-and-understand-scoring)

- [如何测量 Core Web Vitals 并理解评分机制](https://vercel.com/blog/core-web-vitals#how-to-measure-core-web-vitals-and-understand-scoring)


## What are Core Web Vitals and How Do They Impact SEO?

## 什么是 Core Web Vitals？它们如何影响 SEO？

Core Web Vitals help you understand the impact your application performance has on the end-user. There are three main components to Core Web Vitals that optimize for the quality of your page experience:

Core Web Vitals 帮助您理解应用性能对终端用户实际体验的影响。其包含三大核心指标，共同致力于提升网页的整体用户体验质量：

### Largest Contentful Paint

### 最大内容绘制（LCP）

[The Largest Contentful Paint (LCP)](https://web.dev/lcp/) metric looks at the _perceived_ loading speed of your page. LCP measures the time it takes to get the largest element on the page visible within the viewport. This could be a large text block, video, or image that takes up the primary real estate on the page. This is not [First Contentful Paint (FCP)](https://web.dev/fcp/), which measures the time from when the page begins to load to when the first element is rendered on screen.

[Largest Contentful Paint（LCP）](https://web.dev/lcp/) 指标关注的是用户**感知到的**页面加载速度。LCP 衡量的是页面中最大元素在视口内完成渲染所需的时间。该最大元素可能是占据页面主要可视区域的大段文字、视频或图片。这与 [First Contentful Paint（FCP，首次内容绘制）](https://web.dev/fcp/) 不同——FCP 衡量的是从页面开始加载到屏幕上首次渲染出任意内容元素所经过的时间。

![As the DOM is rendered, the largest element on the page may change. Here, the Largest Contentful Paint is counted until the image is seen on-screen. According to Google, a good LCP is below 2.5 seconds.  ](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_003.jpg)![As the DOM is rendered, the largest element on the page may change. Here, the Largest Contentful Paint is counted until the image is seen on-screen. According to Google, a good LCP is below 2.5 seconds.  ](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_004.jpg)As the DOM is rendered, the largest element on the page may change. Here, the Largest Contentful Paint is counted until the image is seen on-screen. According to Google, a good LCP is below 2.5 seconds.

![随着 DOM 渲染进行，页面上最大的元素可能发生变化。本例中，LCP 的计时持续到图像在屏幕上显示为止。根据 Google 的标准，良好的 LCP 应低于 2.5 秒。](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_003.jpg)![随着 DOM 渲染进行，页面上最大的元素可能发生变化。本例中，LCP 的计时持续到图像在屏幕上显示为止。根据 Google 的标准，良好的 LCP 应低于 2.5 秒。](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_004.jpg)随着 DOM 渲染进行，页面上最大的元素可能发生变化。本例中，LCP 的计时持续到图像在屏幕上显示为止。根据 Google 的标准，良好的 LCP 应低于 2.5 秒。

Minimizing your LCP demonstrates your page is usable and getting content on the screen quickly. Aim for an LCP below 2.5 seconds.

尽可能降低 LCP 值，表明您的页面具备良好的可用性，且能快速将内容呈现至屏幕。目标是将 LCP 控制在 2.5 秒以内。

![The lower your LCP metric, the better your page experience will be. ](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_005.jpg)![The lower your LCP metric, the better your page experience will be. ](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_006.jpg)The lower your LCP metric, the better your page experience will be.

![LCP 数值越低，用户的页面体验就越好。](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_005.jpg)![LCP 数值越低，用户的页面体验就越好。](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_006.jpg)LCP 数值越低，用户的页面体验就越好。

### First Input Delay

### 首次输入延迟（FID）

The [First Input Delay (FID)](https://web.dev/fid/) metric is the perception of an end user’s experience interacting with a web page. Imagine clicking inside an input box only for nothing to happen – this frustration with the interactivity and responsiveness of a site is caused by large input delays.

[First Input Delay（FID）](https://web.dev/fid/) 指标反映终端用户与网页交互时的主观体验。试想：你点击一个输入框，却毫无响应——这种因网站交互性与响应性差而产生的挫败感，正是由较大的输入延迟所导致。

![First Input Delay (FID) is measured from the time a user interaction occurred to when the event handler was finally invoked. ](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_007.jpg)![First Input Delay (FID) is measured from the time a user interaction occurred to when the event handler was finally invoked. ](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_008.jpg)First Input Delay (FID) is measured from the time a user interaction occurred to when the event handler was finally invoked.

![FID 的测量方式为：从用户发生交互操作起，到事件处理函数最终被调用为止所经历的时间。](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_007.jpg)![FID 的测量方式为：从用户发生交互操作起，到事件处理函数最终被调用为止所经历的时间。](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_008.jpg)FID 的测量方式为：从用户发生交互操作起，到事件处理函数最终被调用为止所经历的时间。

FID happens when the browser’s main thread is performing other tasks and is unable to respond to the user’s request. The lower your FID score, the more usable your page will be to your end-user. Aim for an FID below 100ms.

当浏览器主线程正忙于执行其他任务，无法及时响应用户请求时，便会发生 FID。FID 分数越低，您的页面对终端用户的可用性就越高。目标是将 FID 控制在 100 毫秒以内。

![According to Google, aim for an FID below 100ms for a better page experience. ](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_009.jpg)![According to Google, aim for an FID below 100ms for a better page experience. ](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_010.jpg)According to Google, aim for an FID below 100ms for a better page experience.

![根据 Google 的标准，为获得更佳的页面体验，应将 FID 控制在 100 毫秒以内。](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_009.jpg)![根据 Google 的标准，为获得更佳的页面体验，应将 FID 控制在 100 毫秒以内。](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_010.jpg)根据 Google 的标准，为获得更佳的页面体验，应将 FID 控制在 100 毫秒以内。

### Cumulative Layout Shift

### 累积布局偏移（CLS）

The [Cumulative Layout Shift (CLS)](https://web.dev/cls/) metric is a measure of your site’s overall layout stability. A site that unexpectedly shifts layout as the page loads can lead to accidental user error and distraction.

[累积布局偏移（CLS）](https://web.dev/cls/) 是衡量网站整体布局稳定性的指标。当页面加载过程中布局意外发生偏移时，可能导致用户误操作和注意力分散。

![Cumulative Layout Shift (CLS) occurs when elements have been shifted after initially being rendered by the DOM. Here, a button was rendered to the screen after the text block, causing the block to shift downward. The combination of impact and distance is what is considered when calculating CLS. ](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_011.jpg)![Cumulative Layout Shift (CLS) occurs when elements have been shifted after initially being rendered by the DOM. Here, a button was rendered to the screen after the text block, causing the block to shift downward. The combination of impact and distance is what is considered when calculating CLS. ](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_012.jpg)  
累积布局偏移（CLS）发生在 DOM 首次渲染元素后，这些元素又发生了位置偏移的情形。本例中，按钮在文本块之后才被渲染到屏幕，导致文本块向下偏移。CLS 的计算综合考虑了偏移的“影响范围”（impact fraction）与“移动距离”（distance fraction）。

Each element’s individual [layout shift score](https://web.dev/cls/#layout-shift-score) is only counted toward the CLS if unexpected movement occurs. If a new element is added to the DOM or an existing element changes size, it doesn’t count toward layout shift if the loaded elements maintain their position. Aim for a CLS less than 0.1.

只有当元素发生**意外移动**时，其各自的 [布局偏移得分（layout shift score）](https://web.dev/cls/#layout-shift-score) 才会被计入 CLS 总分。若新元素被添加至 DOM，或现有元素尺寸发生变化，只要已加载的元素位置未发生变动，则不构成布局偏移。建议将 CLS 控制在 **0.1 以下**。

![A good Cumulative Layout Shift (CLS) metric is one that has barely perceptible layout shift. According to Google, aim for a metric below 0.1. ](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_013.jpg)![A good Cumulative Layout Shift (CLS) metric is one that has barely perceptible layout shift. According to Google, aim for a metric below 0.1. ](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_014.jpg)  
一个良好的累积布局偏移（CLS）指标，意味着布局偏移几乎不可察觉。根据 Google 的标准，目标值应低于 **0.1**。

## Improving Website Performance to Increase Google Ranking

## 提升网站性能以提高 Google 排名

Improving your vitals helps your site rank higher in comparison to your competitors. Let’s look at strategies for improving your Core Web Vitals: pre-rendering content, image optimization, and font optimization.

优化核心网络指标（Core Web Vitals）有助于提升网站在搜索引擎结果页中相较竞争对手的排名。接下来，我们将探讨三项关键优化策略：内容预渲染、图片优化与字体优化。

![The metrics that make up the Core Web Vitals:  Largest Contentful Paint, First Input Delay, and Cumulative Layout Shift. In addition to previous signals, these will now be considered in determining your overall Google Search ranking. ](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_015.jpg)![The metrics that make up the Core Web Vitals:  Largest Contentful Paint, First Input Delay, and Cumulative Layout Shift. In addition to previous signals, these will now be considered in determining your overall Google Search ranking. ](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_016.jpg)  
构成核心网络指标（Core Web Vitals）的三大指标为：最大内容绘制（Largest Contentful Paint, LCP）、首次输入延迟（First Input Delay, FID）与累积布局偏移（Cumulative Layout Shift, CLS）。除原有排名信号外，这些指标现已被纳入 Google 搜索整体排名算法的考量范围。

### Pre-rendering Content

### 内容预渲染

One of the first things you can do to optimize your SEO and improve Core Web Vitals is to pre-render your content. By [pre-rendering content](https://nextjs.org/docs/basic-features/pages#pre-rendering), you can generate HTML in advance on the server for each page so that the initial request contains the markup and can immediately be indexed by Google.

优化 SEO 并提升核心网络指标的首要举措之一，便是对内容进行预渲染。通过 [预渲染内容](https://nextjs.org/docs/basic-features/pages#pre-rendering)，您可在服务端为每个页面预先生成 HTML，确保用户首次请求即获得完整 HTML 标记，从而被 Google 即时抓取与索引。

Next.js pre-renders every page [by default](https://nextjs.org/docs/advanced-features/automatic-static-optimization), maximizing performance and SEO.

Next.js 默认对每个页面进行预渲染（[pre-rendering](https://nextjs.org/docs/advanced-features/automatic-static-optimization)），从而最大限度地提升性能和搜索引擎优化（SEO）效果。

It’s true Google can crawl JavaScript for client-side rendered applications. However, they recommend using [server-side or pre-rendering](https://developers.google.com/web/updates/2019/02/rendering-on-the-web) to not only make your site faster for users and crawlers, but to account for those bots not using JavaScript.

确实，Google 能够爬取客户端渲染（CSR）应用中的 JavaScript。但 Google 建议采用服务端渲染（SSR）或预渲染（[server-side or pre-rendering](https://developers.google.com/web/updates/2019/02/rendering-on-the-web)），这不仅能让网站对用户和爬虫都加载得更快，还能兼顾那些不支持 JavaScript 的搜索引擎爬虫。

Services that aim to add pre-rendering on top of single-page applications will likely result in worse Core Web Vitals.

在单页应用（SPA）之上额外叠加预渲染功能的服务，往往反而会导致核心网页指标（Core Web Vitals）变差。

### Image Optimization

### 图像优化

There are several ways to optimize your images to improve Core Web Vitals and SEO.

有多种方式可优化图像，以提升核心网页指标（Core Web Vitals）和搜索引擎优化（SEO）效果。

1. Use the `height` and `width` attributes on your [Image component in Next.js](https://nextjs.org/docs/basic-features/image-optimization) or `<img>` element in HTML to prevent layout shift. Adding these attributes to your markup will tell the browser how much space to allocate.

1. 在 Next.js 的 [`Image` 组件](https://nextjs.org/docs/basic-features/image-optimization) 或 HTML 中的 `<img>` 元素上设置 `height` 和 `width` 属性，以防止布局偏移（layout shift）。在标记中添加这些属性，可告知浏览器为该图像预留多少空间。

2. Lazy-load images as they enter the viewport.

2. 当图像进入视口（viewport）时再进行懒加载（lazy-load）。

3. Use modern image formats (WebP, AVIF).

3. 使用现代图像格式（如 WebP、AVIF）。

4. Serve correctly sized images using `srcset`.

4. 利用 `srcset` 属性提供尺寸适配的图像。

5. Provide blur-up placeholders.

5. 提供模糊渐显（blur-up）占位图。

Next.js includes almost all these optimizations out of the box. Stay tuned for blur-up placeholder support.

Next.js 开箱即用，已内置了上述绝大多数优化功能。敬请期待对 blur-up 占位图（blur-up placeholder）的支持。

### Font Optimization

### 字体优化

Eighty-two percent of pages on desktop use web fonts. Here are some tips to improve your Core Web Vitals when loading fonts:

桌面端网页中，有 82% 使用了网络字体（web fonts）。以下是一些在加载字体时提升核心网页指标（Core Web Vitals）的建议：

1. Use a variable font so that you will only have one file that contains every width, weight, and style of your font choice.

1. 使用可变字体（variable font），这样只需一个文件即可涵盖所选字体的所有字宽、字重和字形样式。

2. Preconnect to your font file in the head of your HTML document and define it in your CSS.

2. 在 HTML 文档 `<head>` 中通过 `preconnect` 提前建立与字体文件所在域名的连接，并在 CSS 中正确定义该字体。

3. Self-host your font instead of depending on Google fonts.

3. 自行托管字体文件，而非依赖 Google Fonts 等第三方服务。

4. Use `font-display: optional` to prevent layout shift (CLS).

4. 使用 `font-display: optional` 属性，以避免布局偏移（Cumulative Layout Shift, CLS）。

5. Have a fallback font in case the initial choice fails to load.

5. 设置备用字体（fallback font），以防首选字体加载失败。

Next.js has [Automatic Webfont Optimization](https://nextjs.org/blog/next-10-2#automatic-webfont-optimization) which handles #2 and #3 with support for Google Fonts and Typekit. We are also working on a built-in solution for #4 and #5.

Next.js 提供了[自动网络字体优化（Automatic Webfont Optimization）](https://nextjs.org/blog/next-10-2#automatic-webfont-optimization)，可原生支持 Google Fonts 和 Typekit，并自动完成上述第 2 条和第 3 条优化。目前我们也在为第 4 条和第 5 条开发内置解决方案。

For more information, check out [Web Fonts in 2021](https://leerob.io/blog/fonts).

如需了解更多详情，请参阅 [Web Fonts in 2021](https://leerob.io/blog/fonts)。

## How to Measure Core Web Vitals and Understand Scoring

## 如何测量核心网页指标并理解评分机制

After implementing improvements to your site, it is beneficial to measure how your site is performing. [Google Lighthouse](https://developers.google.com/web/tools/lighthouse) is available to audit a web page in five key areas: performance, best practices, accessibility, SEO, and Progressive Web Apps (PWAs). Core Web Vitals are a main part of the performance analysis.

在对网站实施优化改进后，评估网站的实际运行表现十分有益。[Google Lighthouse](https://developers.google.com/web/tools/lighthouse) 可对网页进行五大关键维度的审查：性能、最佳实践、可访问性、搜索引擎优化（SEO）以及渐进式网络应用（PWA）。核心网页指标（Core Web Vitals）是性能分析中的核心组成部分。

[Vercel Analytics](https://vercel.com/analytics) takes Lighthouse a step further by providing real-user monitoring and assigning a [Real Experience Score (RES)](https://vercel.com/docs/analytics). This score gives you an overall health check of the Core Web Vitals your users experience.

[Vercel Analytics](https://vercel.com/analytics) 在 Lighthouse 基础上更进一步，提供真实用户监控（Real-User Monitoring），并生成一个 [真实体验评分（Real Experience Score, RES）](https://vercel.com/docs/analytics)。该评分可全面反映您的用户实际体验到的核心网页指标健康状况。

![The Vercel dashboard has an Analytics tab where you can go to inspect your Real Experience Score if you are a Pro or Enterprise customer. ](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_017.jpg)![The Vercel dashboard has an Analytics tab where you can go to inspect your Real Experience Score if you are a Pro or Enterprise customer. ](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_018.jpg)The Vercel dashboard has an Analytics tab where you can go to inspect your Real Experience Score if you are a Pro or Enterprise customer.

![Vercel 控制台中设有 Analytics（分析）标签页，若您为 Pro 或 Enterprise 计划用户，可在此查看您的真实体验评分（RES）。](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_017.jpg)![Vercel 控制台中设有 Analytics（分析）标签页，若您为 Pro 或 Enterprise 计划用户，可在此查看您的真实体验评分（RES）。](images/how-core-web-vitals-will-impact-google-rankings-in-2021-vercel/img_018.jpg)Vercel 控制台中设有 Analytics（分析）标签页，若您为 Pro 或 Enterprise 计划用户，可在此查看您的真实体验评分（RES）。

Based on these metrics, you can see whether a performance regression was introduced at any given time and immediately revert back to the previous commit.

借助这些指标，您可及时识别任意时间点是否引入了性能退化问题，并立即回滚至前一版本提交（commit）。

Additionally, you can see a breakdown of each vital and the various routes inside your application. This enables you to analyze and improve the SEO and performance of your site.

此外，您还可查看各项核心指标的详细分解数据，以及应用内各路由路径的表现。这有助于您深入分析并持续优化网站的 SEO 效果与整体性能。

For more information, check out [this guide on Core Web Vitals](https://web.dev/vitals/) from Google. To start measuring your site’s performance today, [enable Vercel Analytics](https://vercel.com/analytics) for any Next.js, Nuxt, or Gatsby application. You can also watch the [video](https://www.youtube.com/watch?v=9SVe7TigqVg) that inspired this blog.

如需了解更多详情，请参阅 Google 官方发布的 [《核心网页指标指南》](https://web.dev/vitals/)。即刻开始监测您网站的性能表现：请为任意 Next.js、Nuxt 或 Gatsby 应用 [启用 Vercel Analytics](https://vercel.com/analytics)。您也可观看启发本文撰写的 [视频](https://www.youtube.com/watch?v=9SVe7TigqVg)。

_Thanks to_ [_Shubhie Panicker_](https://twitter.com/shubhie) _for reviewing this post._

感谢 [_Shubhie Panicker_](https://twitter.com/shubhie) 对本文的审阅。