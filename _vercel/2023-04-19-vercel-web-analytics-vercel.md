---
title: "Vercel Web Analytics - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-web-analytics-is-now-generally-available"
date: "2023-04-19"
scraped_at: "2026-03-02T09:53:26.189630359+00:00"
language: "en-zh"
translated: true
description: "Get detailed, first-party page views, traffic analytics"
---
{% raw %}

Apr 19, 2023

2023 年 4 月 19 日

借助 Vercel Web Analytics，获取详尽的一方页面浏览量、流量分析数据及自定义事件。

Vercel Web Analytics 现已全面开放，可为您提供热门页面、主要引荐来源以及用户人口统计信息（如国家/地区、操作系统、浏览器信息等）的深入洞察。我们还很高兴地宣布两项新功能：[数据筛选](https://vercel.com/changelog/filter-analytics-traffic-data) 和 [自定义事件](https://vercel.com/docs/concepts/analytics/custom-events)。

[Web Analytics](https://vercel.com/docs/concepts/analytics/limits-and-pricing) 在所有订阅计划中均可用；而自定义事件功能则面向 Pro 与 Enterprise 计划用户开放。

### 隐私友好型的一方分析，更少 JavaScript 代码

Vercel Web Analytics 作为一方分析工具，并不依赖 Cookie，而是通过对接入请求进行哈希运算生成唯一标识符，从而识别用户。该哈希值由系统动态生成，既保障了访客的隐私权益——确保其无法在不同网站或应用间被跨站追踪，又实现了数据仅保留 24 小时后即自动清除。采用 Vercel Web Analytics，您无需部署 Cookie 追踪机制，也无需引入任何第三方脚本。

仅需三步，您即可在项目中快速启用 Web Analytics，即时获取流量洞察——且完全不影响网页加载速度。Vercel Web Analytics 的体积仅为 Google Analytics 的 **1/44**，助您持续保持卓越的网站性能。

> “分析功能所释放的应用数据价值，远超创建一条 JIRA 工单来配置它所需的时间。分析功能所释放的应用数据价值，远超创建一条 JIRA 工单来配置它所需的时间。”
>
> ![](images/vercel-web-analytics-vercel/img_001.png)
>
> **Michelle Bakels**，React Miami 联合组织者

### 框架原生支持的分析数据采集与报表呈现

`Analytics` 组件是对底层追踪脚本的封装，为 Next.js 及其他主流框架提供了更无缝、更自然的集成体验：

- [Next.js](https://vercel.com/docs/concepts/analytics/package)

- [Next.js](https://vercel.com/docs/concepts/analytics/package)

- [React](https://vercel.com/docs/concepts/analytics/package)

- [React](https://vercel.com/docs/concepts/analytics/package)

- [SvelteKit](https://vercel.com/docs/concepts/analytics/package)

- [SvelteKit](https://vercel.com/docs/concepts/analytics/package)

- [Nuxt](https://vercel.com/docs/concepts/analytics/package)

- [Nuxt](https://vercel.com/docs/concepts/analytics/package)

- [Remix](https://vercel.com/docs/concepts/analytics/package)

- [Remix](https://vercel.com/docs/concepts/analytics/package)

- Or any website through a [script tag](https://vercel.com/docs/concepts/analytics/package)

- 或通过 [script 标签](https://vercel.com/docs/concepts/analytics/package) 接入任意网站


```tsx
import type { AppProps } from 'next/app';

import { Analytics } from '@vercel/analytics/react';



function MyApp({ Component, pageProps }: AppProps) {

5  return (

5  返回（

6    <>

6    <>

7      <Component {...pageProps} />

7      <Component {...pageProps} />

8      <Analytics />

8      <Analytics />

9    </>

9    </>

10  );

10  ）；

11}

11}

export default MyApp;
```

export default MyApp;
```

If you are using the pages directory, add this component to your main app file.

如果您使用的是 `pages` 目录，请将此组件添加到您的主应用文件中。

### Now with Custom Event Tracking

### 现已支持自定义事件跟踪

Vercel Web Analytics also gives Pro and Enterprise users the ability to track custom events. With custom events, you can track things like newsletter signups or what CTAs your customers are clicking the most to dive deeper into understanding your user's journey.

Vercel Web Analytics 还为 Pro 和 Enterprise 用户提供了跟踪自定义事件的能力。借助自定义事件，您可以追踪诸如新闻简报注册、客户点击频率最高的行动号召（CTA）等行为，从而更深入地理解用户的使用路径。

```tsx
import va from '@vercel/analytics';



function SignupButton() {

4  return (

5    <button

6      onClick={() => {

7        va.track('Signup', {

8          location: 'US'
```

9        });

10      };

11    >

12      注册

13    </button>

14  );

15};
```

这将追踪一个名为 “Signup”（注册）的事件。

理解用户对于打造优秀产品至关重要。借助 Vercel 的 Web Analytics（网页分析）功能，您可以快速、轻松地获取有关目标受众的洞察，从而确保为他们构建最佳的用户体验。[立即开始使用](https://vercel.com/docs/concepts/analytics)。

Vercel 模板

Deploy this template

部署此模板

### A collection of components, hooks, and utilities built on Next.js, Typescript, Tailwind, Radix, Framer Motion, Prisma, and PostgreSQL.

### 基于 Next.js、TypeScript、Tailwind、Radix、Framer Motion、Prisma 和 PostgreSQL 构建的一套组件、自定义 Hook 与工具函数。

Precedent – Next.js Starter

Precedent — Next.js 启动模板

Vercel Template

Vercel 模板

Deploy this template

部署此模板

### HTML5 template with analytics and advanced routing configuration.

### 支持分析统计与高级路由配置的 HTML5 模板。

HTML Starter

HTML 启动模板
{% endraw %}
