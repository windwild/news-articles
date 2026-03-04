---
title: "From idea to acquisition: How Potion.so shipped 4,000+ sites on Vercel - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/from-idea-to-acqusition-how-potion-shipped-4k-sites-on-vercel"
date: "2023-06-15"
scraped_at: "2026-03-02T09:52:15.384163479+00:00"
language: "en-zh"
translated: true
description: "The success of Potion's one-person team is a testament to the power of Vercel's Frontend Cloud toolkit. "
---

render_with_liquid: false
Jun 15, 2023

2023年6月15日

The success of Potion's one-person team is a testament to the power of Vercel's Frontend Cloud toolkit.

Potion 单人团队的成功，印证了 Vercel 前端云工具套件的强大能力。

#### 100K

#### 10 万

Pageviews per month

每月页面浏览量

#### 6%

#### 6%

Month-over-month revenue growth

月度营收增长率

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

[Potion.so](https://potion.so/) is a Notion-to-website builder powered by Next.js and Vercel. Founder and sole employee Noah Bragg leverages the [Platforms Starter Kit](https://vercel.com/templates/next.js/platforms-starter-kit) and [Vercel's Edge Network](https://vercel.com/docs/concepts/edge-network/overview) to serve 4,000 custom domains and over 100,000 pageviews.

[Potion.so](https://potion.so/) 是一款基于 Next.js 和 Vercel 构建的、将 Notion 页面一键生成网站的工具。创始人兼唯一员工 Noah Bragg 借助 [Platforms Starter Kit（平台入门套件）](https://vercel.com/templates/next.js/platforms-starter-kit) 和 [Vercel 边缘网络（Edge Network）](https://vercel.com/docs/concepts/edge-network/overview)，为 4,000 个自定义域名提供服务，月页面浏览量超 10 万次。

In June 2023, Potion was acquired for $300,000.

2023 年 6 月，Potion 以 30 万美元被收购。

> “With Vercel, I was able to quickly set up wildcard subdomains for my users and upsell them with custom domains.With Vercel, I was able to quickly set up wildcard subdomains for my users and upsell them with custom domains.”
>
> “借助 Vercel，我得以快速为用户配置通配符子域名，并通过提供自定义域名实现增值销售。”

> ![](images/from-idea-to-acquisition-how-potion_so-shipped-4_000-sites-on-vercel-vercel/img_001.png)
>
> ![](images/from-idea-to-acquisition-how-potion_so-shipped-4_000-sites-on-vercel-vercel/img_001.png)

> **Noah Bragg,** Founder  
>   
> **Noah Bragg**，创始人

Potion's success story was supercharged by Vercel's Frontend Cloud: a robust toolkit that ensures a seamless developer experience. With Vercel's ability to manage custom domains at scale, Potion has been able to easily support custom domain creation for users—a popular upsell feature for website builders like Potion.

Potion 的成功故事得益于 Vercel 前端云（Frontend Cloud）的强力助推：这是一套功能强大的工具集，可确保流畅无缝的开发者体验。凭借 Vercel 大规模管理自定义域名的能力，Potion 能够轻松为用户支持自定义域名创建——这一功能在 Potion 这类建站平台中广受欢迎，是极具吸引力的增值销售（upsell）选项。

"With Vercel, I was able to quickly set up [wildcard subdomains](https://vercel.com/docs/concepts/projects/domains/working-with-domains#wildcard-domain) for my users and upsell them with custom domains," says Bragg. "Being able to quickly scaffold this using the [Platforms Starter Kit](https://vercel.com/templates/next.js/platforms-starter-kit) as a starting point was immensely helpful, and it allowed me to focus on building features that delivers value to my customers instead of configuring NGINX proxies."

“借助 Vercel，我能够快速为用户配置 [通配符子域名（wildcard subdomains）](https://vercel.com/docs/concepts/projects/domains/working-with-domains#wildcard-domain)，并以此为基础向他们推广自定义域名服务。”Bragg 表示，“以 [Platforms Starter Kit（平台入门套件）](https://vercel.com/templates/next.js/platforms-starter-kit) 为起点，快速搭建起整套基础设施，极大提升了开发效率；这让我得以将精力聚焦于构建真正为客户创造价值的功能，而非耗费时间配置 NGINX 反向代理。”

[**Check out the Platforms Starter Kit**\\
\\
Next.js template for building multi-tenant applications with custom domains using App Router, Vercel Postgres, and the Vercel Domains API.⁡𝅶‍‍\\
\\
View Template](https://vercel.com/templates/next.js/platforms-starter-kit)

[**查看 Platforms Starter Kit（平台入门套件）**\\
\\
基于 App Router、Vercel Postgres 和 Vercel Domains API 构建支持自定义域名的多租户应用的 Next.js 模板。⁡𝅶‍‍\\
\\
查看模板](https://vercel.com/templates/next.js/platforms-starter-kit)

## Features for scalability and speed

## 面向可扩展性与高性能的功能特性

Site speed and SEO are also of utmost importance for Potion. By using Vercel, they ensure lightning-fast load times for all its hosted websites, so they rank higher in search results and provide a delightful user experience​. Like [mmm.page](https://vercel.com/customers/how-vercel-helps-mmm-page-manage-over-30-000-custom-domains), another platform that successfully scaled with Vercel, Potion leverages Server-Side Rendering (SSR) for efficient content delivery and optimal SEO performance​.

网站加载速度与搜索引擎优化（SEO）对 Potion 同样至关重要。借助 Vercel，Potion 确保所有托管网站均实现闪电般的加载速度，从而在搜索结果中获得更高排名，并为用户提供愉悦的浏览体验。与另一家成功依托 Vercel 实现规模化扩张的平台 [mmm.page](https://vercel.com/customers/how-vercel-helps-mmm-page-manage-over-30-000-custom-domains) 类似，Potion 采用服务端渲染（Server-Side Rendering, SSR），以实现高效的内容分发和最优的 SEO 表现。

This scalability has been crucial for Potion's growth. Vercel caches results using a technique called [Incremental Static Regeneration (ISR)](https://vercel.com/docs/concepts/incremental-static-regeneration), resulting in fewer calls to the database so Potion won’t face a database overload—even as the number of managed sites continues to grow​.

这种可扩展能力对 Potion 的持续增长至关重要。Vercel 采用名为 [增量静态再生（Incremental Static Regeneration, ISR）](https://vercel.com/docs/concepts/incremental-static-regeneration) 的缓存技术，显著减少了数据库调用次数，从而避免数据库过载——即便其托管网站数量持续攀升，系统依然稳健可靠。

## Growth milestones achieved

## 已达成的增长里程碑

In the two years following Potion's launch, it achieved several growth milestones:

Potion 自上线以来的两年间，已达成多项关键增长里程碑：

- $6,300 monthly recurring revenue (MRR)

- 月度经常性收入（MRR）达 6,300 美元

- 6% month-over-month revenue growth

- 月环比收入增长率达 6%

- 4,000 个自定义域名

- 每月 100,000 次页面浏览量

- Product Hunt「本周产品」[Product of the Week](https://www.producthunt.com/products/potion-2#potion-2)

- Product Hunt 创作者资助计划（Maker Grant）获得者

- 一笔 30 万美元的收购交易


Potion 以 30 万美元被收购的发展历程，印证了选择合适技术所蕴含的巨大能量。Vercel 前端云（Frontend Cloud）与 Next.js 在 Potion 的成功中发挥了关键作用，助力其打造了一个高性能、可扩展且用户友好的平台，让成千上万的用户得以轻松、高效地构建网站。

收购完成一个月后，Noah Bragg 再次出发，创办了另一家初创公司——[Trustscore](https://www.trustscore.gg/)，该项目同样基于 Next.js 和 Vercel 构建。

[**借助 Vercel 前端云，全面赋能您的业务**  
\\  
深入了解前端云如何助力各种规模的团队实现规模化成功。  
\\  
联系我们](https://vercel.com/contact/sales)

[![Noah Bragg 🔥](images/from-idea-to-acquisition-how-potion_so-shipped-4_000-sites-on-vercel-vercel/img_002.jpg)](https://x.com/noahwbragg/status/1664648462980497408)

[Noah Bragg 🔥](https://x.com/noahwbragg/status/1664648462980497408)

· [关注](https://x.com/intent/follow?screen_name=noahwbragg)

[在 Twitter 上查看](https://x.com/noahwbragg/status/1664648462980497408)

我有个消息要宣布……

我的 SaaS 产品 Potion 已被收购！🎉🥳

过去两年，我一直独自开发 [@potion_so](https://x.com/potion_so)。

下面就是这次收购背后的故事！  
……甚至包括出售价格。🙃

[2023 年 6 月 2 日 上午 11:01](https://x.com/noahwbragg/status/1664648462980497408) [Twitter 网站版、广告信息与隐私政策](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[1.4K](https://x.com/intent/like?tweet_id=1664648462980497408) [回复](https://x.com/intent/tweet?in_reply_to=1664648462980497408)


[阅读 262 条回复](https://x.com/noahwbragg/status/1664648462980497408)

博客文章

Jul 5, 2023

2023年7月5日

### Introducing the Vercel Platforms Starter Kit

### 推出 Vercel Platforms 入门套件

![](images/from-idea-to-acquisition-how-potion_so-shipped-4_000-sites-on-vercel-vercel/img_003.jpg)

Steven Tey

史蒂文·泰

Customer case study

客户案例研究

Feb 1, 2023

2023年2月1日

### Super serves thousands of domains from a single codebase with Next.js and Vercel

### Super 借助 Next.js 和 Vercel，仅凭一个代码库即可为数千个域名提供服务

![](images/from-idea-to-acquisition-how-potion_so-shipped-4_000-sites-on-vercel-vercel/img_004.png)![](images/from-idea-to-acquisition-how-potion_so-shipped-4_000-sites-on-vercel-vercel/img_003.jpg)

Alli and Steven

阿莉和史蒂文