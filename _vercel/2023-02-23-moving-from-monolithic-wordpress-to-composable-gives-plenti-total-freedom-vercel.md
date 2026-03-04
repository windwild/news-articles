---
title: "Moving from monolithic WordPress to composable gives Plenti total freedom - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/from-monolith-to-composable-equipping-a-financial-services-ipo"
date: "2023-02-23"
scraped_at: "2026-03-02T09:54:28.188353411+00:00"
language: "en-zh"
translated: true
description: "Plenti"
---
&#123;% raw %}

Feb 23, 2023

2023 年 2 月 23 日

[Plenti](https://www.plenti.com.au/) 是一家以技术为驱动的消费信贷与投资公司，致力于帮助借款人将宏大的构想变为现实。Plenti 于 2014 年在澳大利亚成立，迄今已向逾 55,000 名借款人发放贷款超 9 亿澳元，并吸引了逾 22,000 名注册投资者。

消费者对金融服务提供商抱有极高的期望，因此采用 Vercel 与 Next.js 构建的前端，成为 Plenti 塑造全新品牌形象、为用户打造可信赖体验的关键举措。

正因如此，在筹备品牌重塑与首次公开募股（IPO）之际，将原有基于 WordPress 的单体架构迁移至基于 Vercel 的可组合式 Next.js 前端，成为 Plenti 最高优先级的技术任务。

而整个迁移与上线过程，仅由一名开发人员完成。

## 全面灵活：Next.js 成为 Plenti 品牌重塑的基石

Plenti 前身为 RateSetter Australia。2020 年启动 IPO 与品牌重塑时，Plenti 团队即意识到必须全面升级其技术栈。作为品牌重塑的一部分，其官网所有内容均经过重新设计、重构与重写。

Plenti 软件工程师 Matt Milburn 主导了此次技术栈迁移。他表示：“我曾认真评估过所有可行方案，但最终 Next.js 显然成为不二之选。它不仅界面美观，而且上手极快——你几乎无需任何配置，即可立即着手构建真正想要的功能。”

Milburn 补充道：“很高兴我们终于摆脱了旧有的单体式 WordPress 技术栈。如今，我们拥有了真正的自由。”

## 一切皆经优化：Vercel API 与 Analytics

One of Milburn’s favorite features is the [Vercel API](https://vercel.com/docs/integrations/vercel-api-overview), a REST API that empowers you to gauge the capabilities of the entire Vercel platform including the Integrations. He uses the Vercel API to make a plugin for [Strapi](https://strapi.io/), Plenti’s Headless CMS provider, which triggers deployments automatically.

米尔伯恩最钟爱的功能之一是 [Vercel API](https://vercel.com/docs/integrations/vercel-api-overview)——一个 REST API，使您能够全面评估整个 Vercel 平台（包括各类集成）的能力。他利用 Vercel API 为 Plenti 的无头 CMS 服务商 [Strapi](https://strapi.io/) 开发了一个插件，该插件可自动触发部署。

![The Vercel API allows you to leverage plugins, integrations, and more to enhance your workflow.](images/moving-from-monolithic-wordpress-to-composable-gives-plenti-total-freedom-vercel/img_001.jpg)![The Vercel API allows you to leverage plugins, integrations, and more to enhance your workflow.](images/moving-from-monolithic-wordpress-to-composable-gives-plenti-total-freedom-vercel/img_002.jpg)The Vercel API allows you to leverage plugins, integrations, and more to enhance your workflow.

![Vercel API 可让您借助插件、集成等工具增强工作流。](images/moving-from-monolithic-wordpress-to-composable-gives-plenti-total-freedom-vercel/img_001.jpg)![Vercel API 可让您借助插件、集成等工具增强工作流。](images/moving-from-monolithic-wordpress-to-composable-gives-plenti-total-freedom-vercel/img_002.jpg)Vercel API 可让您借助插件、集成等工具增强工作流。

Milburn also values [Vercel Analytics](https://vercel.com/analytics)–particularly the [Real Experience Score (RES)](https://vercel.com/docs/concepts/analytics/web-vitals#real-experience-score-res) feature. “RES helps us narrow down a variety of optimizations we can make proactively,” he says. With RES, Plenti is able to collect web vitals from the actual devices their visitors are using. Because of that, it provides a real grade of how users actually experience what Plenti builds.

米尔伯恩同样高度认可 [Vercel Analytics](https://vercel.com/analytics)——尤其是其中的 [真实体验评分（Real Experience Score, RES）](https://vercel.com/docs/concepts/analytics/web-vitals#real-experience-score-res) 功能。“RES 帮助我们前瞻性地聚焦于一系列可实施的优化项，”他说道。借助 RES，Plenti 能够从访客实际使用的设备中直接采集核心网页指标（Web Vitals），从而真实反映用户在使用 Plenti 所构建产品时的实际体验质量。

![While other performance measuring tools like Lighthouse estimate your user's experience by running a simulation in a lab, Vercel's Real Experience Score is calculated using real data points collected from the devices of the actual users of your application.](images/moving-from-monolithic-wordpress-to-composable-gives-plenti-total-freedom-vercel/img_003.jpg)While other performance measuring tools like Lighthouse estimate your user's experience by running a simulation in a lab, Vercel's Real Experience Score is calculated using real data points collected from the devices of the actual users of your application.

![其他性能测量工具（如 Lighthouse）通过在实验室环境中运行模拟来估算用户体验，而 Vercel 的真实体验评分（RES）则基于您应用真实用户设备所采集的真实数据点进行计算。](images/moving-from-monolithic-wordpress-to-composable-gives-plenti-total-freedom-vercel/img_003.jpg)其他性能测量工具（如 Lighthouse）通过在实验室环境中运行模拟来估算用户体验，而 Vercel 的真实体验评分（RES）则基于您应用真实用户设备所采集的真实数据点进行计算。

## Zero-configuration empowers a team of one

## 零配置赋能单人团队

But perhaps the most impressive part of Plenti’s successful composable frontend is that it’s managed by a single software engineer: Milburn. “My team is just me…I credit that to using [Next.js](https://vercel.com/solutions/nextjs) and [Strapi](https://strapi.io/). I can manage both, all on my own,” he says.

但或许 Plenti 成功构建可组合式前端中最令人印象深刻的一点在于：整套系统仅由一名软件工程师——米尔伯恩——独立运维。“我的团队就只有我一个人……这要归功于采用了 [Next.js](https://vercel.com/solutions/nextjs) 和 [Strapi](https://strapi.io/)。这两者我都能独自管理。”他说道。

And when it comes to harnessing the power of Vercel in tandem with Next.js, he concludes, “using Next.js and Vercel together? Of course. They make the thing. It’s zero-configuration.”

而谈及如何协同发挥 Vercel 与 Next.js 的强大能力时，他总结道：“将 Next.js 与 Vercel 结合使用？当然！它们本身就是一体的——开箱即用，零配置。”

- See how [Vercel Analytics](https://vercel.com/analytics) gives you better insights for peak performance

- 查看 [Vercel Analytics](https://vercel.com/analytics) 如何为您提供更深入的洞察，助力实现极致性能

- Why are innovators going composable (also known as headless)? [Get the guide.](https://vercel.com/try/ebook-why-innovators-are-going-headless)

- 为何创新者纷纷转向可组合架构（即“无头”架构）？[立即获取指南](https://vercel.com/try/ebook-why-innovators-are-going-headless)

- Want to ensure a great developer and user experience by going composable with Next.js? [Get in touch](https://vercel.com/contact/sales).

- 想通过采用 Next.js 实现可组合架构，同时保障卓越的开发者体验与终端用户体验？[联系我们](https://vercel.com/contact/sales)
&#123;% endraw %}
