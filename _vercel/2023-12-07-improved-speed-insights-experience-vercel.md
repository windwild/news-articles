---
title: "Improved Speed Insights experience - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/improved-speed-insights-experience"
date: "2023-12-07"
scraped_at: "2026-03-02T09:49:11.848689675+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
&#123;% raw %}

Dec 7, 2023

2023 年 12 月 7 日

![](images/improved-speed-insights-experience-vercel/img_001.jpg)![](images/improved-speed-insights-experience-vercel/img_002.jpg)

Speed Insights measures site performance and helps you understand areas for improvement. This includes Core Web Vitals like [First Contentful Paint](https://vercel.com/docs/speed-insights#first-contentful-paint-fcp), [Largest Contentful Paint](https://vercel.com/docs/speed-insights#largest-contentful-paint-lcp), [Cumulative Layout Shift](https://vercel.com/docs/speed-insights#cumulative-layout-shift-cls), and more.

Speed Insights 用于衡量网站性能，并帮助您识别可优化的关键领域。这包括各项核心网络指标（Core Web Vitals），例如 [首次内容绘制（First Contentful Paint，FCP）](https://vercel.com/docs/speed-insights#first-contentful-paint-fcp)、[最大内容绘制（Largest Contentful Paint，LCP）](https://vercel.com/docs/speed-insights#largest-contentful-paint-lcp)、[累积布局偏移（Cumulative Layout Shift，CLS）](https://vercel.com/docs/speed-insights#cumulative-layout-shift-cls) 等。

The Speed Insights experience has been improved to include:

Speed Insights 的使用体验已全面升级，新增以下功能：

- **Support for all frontend frameworks:** You can now use Speed Insights with any framework using the new `@vercel/speed-insights` package. This includes supporting dynamic route segments in frameworks like SvelteKit and Remix.

- **对所有前端框架的支持**：现在您可通过全新的 `@vercel/speed-insights` 包，在任意前端框架中使用 Speed Insights，包括支持 SvelteKit 和 Remix 等框架中的动态路由段（dynamic route segments）。

- **First-party data ingestion**: Data will now be processed directly through your own domain, eliminating the third-party domain lookup.

- **第一方数据采集**：数据现将直接通过您自己的域名进行处理，从而避免第三方域名的 DNS 查询。

- **Updated scoring criteria:** All previous and future metrics measured by Speed Insights are now updated with new weights, based on the latest guidance from Core Web Vitals and Lighthouse.

- **更新的评分标准**：Speed Insights 所有历史及未来测量的指标均已采用新权重重新计算，该调整依据 Core Web Vitals 与 Lighthouse 的最新官方指南。

- **UI improvements:** You can now view performance data by region. Displayed metrics now default to p75 (the experience of the fastest 75% of your users).

- **用户界面改进**：您现在可按地域维度查看性能数据；所展示的各项指标默认采用第 75 百分位（p75）值，即反映您最快 75% 用户的实际体验。

- **Time to First Byte (TTFB):** This metric is now measured, providing visibility into how quickly the server responds to the first request.

- **首字节时间（Time to First Byte，TTFB）**：该指标现已纳入测量范围，助您了解服务器响应首个请求的速度。

- **Advanced customization**: New tools to [intercept requests](https://vercel.com/docs/speed-insights/package#beforesend) and [set sample rates](https://vercel.com/docs/speed-insights/package#samplerate) on a per-project basis.

- **高级自定义能力**：新增工具，支持按项目粒度 [拦截请求](https://vercel.com/docs/speed-insights/package#beforesend) 与 [设置采样率](https://vercel.com/docs/speed-insights/package#samplerate)。

Speed Insights is [available on all plans](https://vercel.com/docs/speed-insights).  

Speed Insights 在所有套餐中均可用：[https://vercel.com/docs/speed-insights](https://vercel.com/docs/speed-insights)。

Learn more about [upgrading to the new package](https://vercel.com/docs/speed-insights/migrating-from-legacy) and see how to take advantage of the new features.

了解更多关于[升级至新版本包](https://vercel.com/docs/speed-insights/migrating-from-legacy)的信息，并查看如何充分利用新功能。
&#123;% endraw %}
