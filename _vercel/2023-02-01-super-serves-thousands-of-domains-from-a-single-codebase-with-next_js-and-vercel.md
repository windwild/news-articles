---
render_with_liquid: false
title: "Super serves thousands of domains from a single codebase with Next.js and Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/super-serves-thousands-of-domains-on-one-project-with-next-js-and-vercel"
date: "2023-02-01"
scraped_at: "2026-03-02T09:55:39.979130417+00:00"
language: "en-zh"
translated: true
description: "How Super uses Next.js and Vercel to power thousands of Notion-based websites with custom domains from a single codebase."
---
render_with_liquid: false
render_with_liquid: false

Feb 1, 2023

2023 年 2 月 1 日

[Super](https://super.so/) 是仅使用 Notion 创建网站的最简单方式。不到一分钟，Super 就能帮你搭建出一款外观时尚、易于管理的网站，具备即时页面加载、SEO 优化以及零代码开发等特性。

首席执行官兼创始人 Jason Werner 很早就从 Gatsby 和 [Netlify](https://vercel.com/kb/guide/vercel-vs-netlify) 迁移至 Next.js 与 Vercel，并且从未回头。“由于 Vercel 正是 Next.js 的创建者和维护者，我深知其托管解决方案与各项功能将始终与该框架完美集成——二者配合得天衣无缝。”Werner 表示。

Werner 使用 [Vercel 的 API](https://vercel.com/docs/rest-api)，让用户能够 [为其 Super 项目添加](https://github.com/vercel/examples/blob/main/solutions/domains-api/pages/api/add-domain.js) 或 [移除](https://github.com/vercel/examples/blob/main/solutions/domains-api/pages/api/remove-domain.js) 自定义域名。借助该 API，他还能 [实时检测用户域名的任何配置变更](https://github.com/vercel/examples/blob/main/solutions/domains-api/pages/api/check-domain.js)，并即时更新。

[**试用 Domains API 模板**：利用 Vercel 的 Domains API，在你的 Vercel Platform 项目中以编程方式添加或删除域名。](https://vercel.com/templates/next.js/domains-api)

## 面向多个——甚至数千个——子域名的功能特性

借助 Next.js 与 Vercel 构建前端，Super 能够高效地为超过 15,000 个自定义域名提供服务。“迄今为止，我最钟爱的 Vercel 功能，就是能将任意数量的域名绑定到单个项目上。”Werner 解释道。

如果你的域名由 Vercel 托管（即使用 Vercel 的域名服务器），那么你可通过 [Vercel 命令行工具（CLI）](https://vercel.com/docs/cli) 添加域名系统（DNS）记录，将某个子域名指向外部服务。

此外，Vercel 提供的 GitHub 集成、增量静态再生（ISR）、Domains API 及边缘中间件（Edge Middleware）等功能，共同助力 Super 为其用户提供最佳体验。

### GitHub 集成：默认每次推送均自动部署

“The way Vercel syncs up with GitHub is really nice–the GitHub integration is amazing,” says Werner. [Vercel for GitHub](https://vercel.com/docs/concepts/git/vercel-for-github) automatically deploys your GitHub projects with Vercel, providing [Preview Deployment](https://vercel.com/features/previews) URLs, and automatic Custom Domain updates.

“Vercel 与 GitHub 的同步方式非常出色——GitHub 集成令人惊叹。”Werner 表示。[Vercel for GitHub](https://vercel.com/docs/concepts/git/vercel-for-github) 可自动将您的 GitHub 项目部署至 Vercel，提供 [预览部署（Preview Deployment）](https://vercel.com/features/previews) URL，并自动更新自定义域名。

### On-demand ISR for faster build times and better performance

### 按需增量静态再生（On-demand ISR）：缩短构建时间，提升性能

With over 17 million page views per month, Super makes heavy use of Vercel’s On-demand [Incremental Static Regeneration](https://vercel.com/docs/concepts/incremental-static-regeneration/overview) (ISR). ISR allows Super to leverage [Vercel's global cache](https://vercel.com/docs/concepts/edge-network/caching) while maintaining full dynamism over their content – meaning users can easily create or update content without redeploying the site. Overall, ISR has three main benefits for developers: better performance, lower database load, and faster build times.

Super 每月页面浏览量超 1700 万次，因此深度依赖 Vercel 的按需 [增量静态再生（Incremental Static Regeneration，ISR）](https://vercel.com/docs/concepts/incremental-static-regeneration/overview) 功能。ISR 使 Super 能充分利用 [Vercel 全球缓存](https://vercel.com/docs/concepts/edge-network/caching)，同时保持内容的完全动态性——这意味着用户可轻松创建或更新内容，而无需重新部署整个网站。总体而言，ISR 为开发者带来三大核心优势：更优性能、更低数据库负载，以及更快的构建速度。

### Edge Middleware gives users speed _and_ personalization

### 边缘中间件（Edge Middleware）：兼顾速度与个性化体验

[Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware) allows you to deliver content to your site's visitors with speed and personalization. They are deployed globally on Vercel's [Edge Network](https://vercel.com/docs/concepts/edge-network/overview) and enable you to move server-side logic to the Edge, close to your visitor's origin. Super currently uses Middleware for custom routing on their landing page, and is actively working on moving their whole platform to the Edge.

[边缘中间件（Edge Middleware）](https://vercel.com/docs/concepts/functions/edge-middleware) 可帮助您以极快速度向网站访客交付内容，并实现个性化体验。这些中间件在全球范围内部署于 Vercel 的 [边缘网络（Edge Network）](https://vercel.com/docs/concepts/edge-network/overview)，让您能将服务端逻辑迁移至靠近访客地理位置的边缘节点。目前，Super 在其落地页（landing page）中使用中间件实现自定义路由，并正积极推进将整个平台全面迁移至边缘网络。

### Domains API for programmatic domain management

### 域名 API（Domains API）：实现编程化域名管理

Super adds and removes custom domains programmatically on behalf of their customers, via Vercel’s [Domains API](https://vercel.com/templates/next.js/domains-api). The Domains API also auto-generates SSL certificates and re-aliases thousands of domains whenever there’s a new production deployment–in mere seconds.

Super 代表其客户，通过 Vercel 的 [域名 API（Domains API）](https://vercel.com/templates/next.js/domains-api) 编程化地添加或移除自定义域名。该 API 还可在每次新生产环境部署时，自动为数千个域名生成 SSL 证书并重新配置别名——整个过程仅需数秒。

## Easily build multi-tenant apps with Next.js and Vercel

## 借助 Next.js 与 Vercel 轻松构建多租户应用

By using Next.js and Vercel, Super has fast, globally distributed sites. Their customers get all the benefits of Next.js without touching any code.

借助 Next.js 与 Vercel，Super 构建了高性能、全球分布式部署的网站。其客户无需编写任何代码，即可尽享 Next.js 的全部优势。

You and your business can harness this technology to build your own multi-tenant apps. Check out the below resources, and get your platform started on Vercel today.

您和您的企业也可利用这一技术，打造属于自己的多租户应用。请查阅下方资源，即刻在 Vercel 上启动您的平台！

- Build your own multi-tenant site with the [Platforms Starter Kit](https://demo.vercel.pub/platforms-starter-kit)

- 使用 [Platforms Starter Kit](https://demo.vercel.pub/platforms-starter-kit) 构建您自己的多租户网站

- [Check out our guide](https://vercel.com/guides/nextjs-multi-tenant-application) on building apps with custom domains

- 查阅我们关于[使用自定义域名构建应用的指南](https://vercel.com/guides/nextjs-multi-tenant-application)

- See our [Platforms on Github](https://github.com/vercel/platforms)

- 查看我们的 [Platforms 项目源码（GitHub）](https://github.com/vercel/platforms)


[![Jason Werner](images/super-serves-thousands-of-domains-from-a-single-codebase-with-next_js-and-vercel/img_001.jpg)](https://x.com/TrillCyborg/status/1499498835281735696)

[![Jason Werner](images/super-serves-thousands-of-domains-from-a-single-codebase-with-next_js-and-vercel/img_001.jpg)](https://x.com/TrillCyborg/status/1499498835281735696)

[Jason Werner](https://x.com/TrillCyborg/status/1499498835281735696)

[Jason Werner](https://x.com/TrillCyborg/status/1499498835281735696)


· [Follow](https://x.com/intent/follow?screen_name=TrillCyborg)

· [关注](https://x.com/intent/follow?screen_name=TrillCyborg)

[View on Twitter](https://x.com/TrillCyborg/status/1499498835281735696)

在 Twitter 上查看

Performance on [@super\_](https://x.com/super_) sites is looking pretty good

[@super\_](https://x.com/super_) 网站的性能表现非常出色


[4:35 PM · Mar 3, 2022](https://x.com/TrillCyborg/status/1499498835281735696) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[2022年3月3日 下午4:35](https://x.com/TrillCyborg/status/1499498835281735696) [Twitter 网站工具、广告信息与隐私政策](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[46](https://x.com/intent/like?tweet_id=1499498835281735696) [Reply](https://x.com/intent/tweet?in_reply_to=1499498835281735696)

[46 次点赞](https://x.com/intent/like?tweet_id=1499498835281735696) [回复](https://x.com/intent/tweet?in_reply_to=1499498835281735696)

[Read 3 replies](https://x.com/TrillCyborg/status/1499498835281735696)

[阅读 3 条回复](https://x.com/TrillCyborg/status/1499498835281735696)