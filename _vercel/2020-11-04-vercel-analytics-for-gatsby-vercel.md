---
title: "Vercel Analytics for Gatsby - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/gatsby-analytics"
date: "2020-11-04"
scraped_at: "2026-03-02T10:06:34.643231367+00:00"
language: "en-zh"
translated: true
description: "Starting today, Vercel Analytics is available for Gatsby projects – without any configuration."
---
{% raw %}

Nov 4, 2020

2020 年 11 月 4 日

Monitor your page speeds over time with reporting from real user experiences.

通过真实用户访问体验生成的性能报告，持续监测您网页的加载速度。

At Next.js Conf, we announced [Next.js Analytics](https://nextjs.org/analytics?utm_source=vercel&utm_medium=blog&utm_campaign=gatsbyanalytics), providing developers with their Real Experience Score through data from actual visitors. Today we're expanding Vercel's analytics offerings to include Gatsby.

在 Next.js Conf 大会上，我们宣布推出 [Next.js Analytics](https://nextjs.org/analytics?utm_source=vercel&utm_medium=blog&utm_campaign=gatsbyanalytics)，借助真实访客的数据，为开发者提供“真实体验评分”（Real Experience Score）。今天，我们进一步扩展 Vercel 的分析能力，正式支持 Gatsby。

## Get Started

## 快速开始

Starting today, Gatsby analytics for projects deployed to Vercel are available with zero configuration:

即日起，部署至 Vercel 的 Gatsby 项目可零配置启用 Gatsby 分析功能：

- 1\. **Open a Gatsby project in your** [**Vercel dashboard**](https://vercel.com/dashboard?analytics=1)

- 1. 在您的 [Vercel 控制台](https://vercel.com/dashboard?analytics=1) 中打开一个 Gatsby 项目

- 2\. **Select the "Analytics" tab and follow the flow**

- 2. 点击顶部导航栏中的 **“Analytics（分析）”** 标签页，并按引导流程操作

No code changes are required ( [docs](https://vercel.com/docs/analytics?utm_source=vercel&utm_medium=blog&utm_campaign=gatsbyanalytics)), and [options for self-hosted applications](https://vercel.com/contact/sales?utm_source=vercel&utm_medium=blog&utm_campaign=gatsbyanalytics) are available for enterprises.

无需修改任何代码（[文档说明](https://vercel.com/docs/analytics?utm_source=vercel&utm_medium=blog&utm_campaign=gatsbyanalytics)），企业用户还可选择 [私有化部署方案](https://vercel.com/contact/sales?utm_source=vercel&utm_medium=blog&utm_campaign=gatsbyanalytics)。

### Performance Is Critical

### 性能至关重要

To your visitors, it's essential that your application is fast. Over 50% of site visitors will abandon a page that takes more than 3 seconds to load, and a 0.1-second delay can cause a 1% drop in ecommerce conversions.

对您的访客而言，应用的响应速度至关重要。超过 50% 的网站访客会在页面加载时间超过 3 秒时直接离开；而仅仅 0.1 秒的延迟，就可能导致电商转化率下降 1%。

As developers, we often focus on performance when we first develop, preview, and ship, but then it's easy to lose focus on continued performance.

作为开发者，我们通常在初次开发、预览和上线时高度关注性能，但之后却很容易忽视对性能的持续优化。

Vercel solves this by allowing developers to [track performance continuously](https://vercel.com/docs/analytics?utm_source=vercel&utm_medium=blog&utm_campaign=gatsbyanalytics#real-experience-score) and track changes over time, with insights on the [Core Web Vitals](https://vercel.com/docs/analytics#web-vitals?utm_source=vercel&utm_medium=blog&utm_campaign=gatsbyanalytics) from real user data across devices and regions, page by page, for every deployment.

Vercel 通过支持开发者[持续追踪性能表现](https://vercel.com/docs/analytics?utm_source=vercel&utm_medium=blog&utm_campaign=gatsbyanalytics#real-experience-score)，并随时间推移监测性能变化，从而解决这一问题；同时，它还能基于真实用户在不同设备与地区访问所产生的数据，逐页分析每次部署的[核心网页指标（Core Web Vitals）](https://vercel.com/docs/analytics#web-vitals?utm_source=vercel&utm_medium=blog&utm_campaign=gatsbyanalytics)。

![An example of the Analytics tab on the project view.](images/vercel-analytics-for-gatsby-vercel/img_001.jpg)  
项目视图中 Analytics（分析）标签页的示例界面。

### Start with the Developer

### 从开发者体验出发

Performance starts with the developer experience, and Vercel is the best place to deploy any frontend app. Deploy with zero configuration to our global edge network and scale to millions of pages without breaking a sweat.

性能优化始于开发者体验，而 Vercel 是部署任意前端应用的最佳平台。您只需零配置，即可将应用部署至我们的全球边缘网络，并轻松扩展至百万级页面，全程无需额外操心。

Starting today, Gatsby analytics for projects on Vercel are available with zero configuration required.

即日起，Vercel 上的 Gatsby 项目可直接启用分析功能，全程零配置。

By expanding our analytics features to enable Real Experience Score (RES) collection to both Next.js and Gatsby apps, we expect developers on these frameworks to create consistently fast user experiences.

通过将分析功能拓展至支持 Next.js 和 Gatsby 应用的“真实体验评分（Real Experience Score, RES）”采集，我们期望使用这些框架的开发者能够持续交付高速流畅的用户体验。

And to enable more developers to perform at the highest level, we'll continue releasing analytics for other frameworks, enabling RES for as many sites as possible. [Follow us](https://twitter.com/vercel) on Twitter for updates.

为助力更多开发者达到卓越水准，我们将持续为其他框架推出分析功能，尽可能覆盖更多网站并支持 RES。欢迎在 Twitter 上[关注我们](https://twitter.com/vercel)获取最新动态。

## How It Works

## 工作原理

In the build step of your Gatsby deployments, Vercel automatically installs the [gatsby-plugin-vercel](https://www.npmjs.com/package/gatsby-plugin-vercel) npm package and modifies your `gatsby-config.js` file to inform Gatsby about the newly added plugin. You do not need to add it manually.

在 Gatsby 项目的部署构建阶段，Vercel 会自动安装 [gatsby-plugin-vercel](https://www.npmjs.com/package/gatsby-plugin-vercel) npm 包，并修改您的 `gatsby-config.js` 文件，以告知 Gatsby 已新增该插件——您无需手动添加。

Once deployed, your application will automatically report [Core Web Vitals](https://vercel.com/docs/analytics#web-vitals?utm_source=vercel&utm_medium=blog&utm_campaign=gatsbyanalytics) to Vercel.

部署完成后，您的应用将自动向 Vercel 上报 [核心网页指标（Core Web Vitals）](https://vercel.com/docs/analytics#web-vitals?utm_source=vercel&utm_medium=blog&utm_campaign=gatsbyanalytics)。

Next.js and Gatsby are the first two [frameworks supported](https://vercel.com/docs/analytics#supported-frameworks), with more are coming soon. [Let us know on Twitter](https://twitter.com/vercel) which frameworks you'd like to see support for.

Next.js 和 Gatsby 是首批获得支持的 [框架](https://vercel.com/docs/analytics#supported-frameworks)，更多框架即将加入。欢迎在 [Twitter 上告诉我们](https://twitter.com/vercel)，您希望后续支持哪些框架。

Next.js and Gatsby analytics are new essentials for ensuring your sites continue to perform beyond Lighthouse scores. Not yet on Vercel? [Import your Gatsby project today](https://vercel.com/import/git).

Next.js 与 Gatsby 的分析功能，是保障网站性能持续超越 Lighthouse 评分的新利器。尚未使用 Vercel？[立即导入您的 Gatsby 项目](https://vercel.com/import/git)。
{% endraw %}
