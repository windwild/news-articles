---
title: "Incremental migration from WordPress for a dev-first approach - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/incremental-migration-from-wordpress-for-a-dev-first-approach"
date: "2023-04-14"
scraped_at: "2026-03-02T09:53:28.854116188+00:00"
language: "en-zh"
translated: true
description: "Gearbox"
---

Apr 14, 2023

2023年4月14日

Navigating the agency world can be complicated, with each agency claiming to offer the most innovative solutions. Enter [Gearbox](https://www.gearboxbuilt.com/), a five-person team that crafts stunning sites and apps while empowering their clients to retain complete control over their brand. The secret to their success: a "dev-first approach" that sets them apart from typical marketing and design-focused competitors.

在代理机构林立的市场中，选择往往令人困惑——每家机构都宣称自己提供最具创新性的解决方案。此时，[Gearbox](https://www.gearboxbuilt.com/) 应运而生：这支仅由五人组成的精干团队，不仅能为客户打造惊艳的网站与应用，更致力于赋能客户全面掌控自身品牌。其成功秘诀在于独树一帜的“以开发者为先（dev-first）”理念，使其显著区别于传统以营销和设计为导向的竞争者。

Flexible enough to power both their small team and larger brands, Next.js and Vercel are Gearbox's go-to solutions—even for clients who may not be ready to transition to a headless stack all at once.

Next.js 与 Vercel 兼具高度灵活性，既可支撑 Gearbox 自身的小型团队，亦能满足大型品牌的复杂需求——甚至对那些尚不具备一步到位迁移到无头架构（headless stack）条件的客户，它们同样是 Gearbox 的首选方案。

## Features to power an incremental migration

## 支持渐进式迁移的功能特性

When he first founded Gearbox, CEO Troy McGinnis served his clients using WordPress, which was the tech he was accustomed to from his previous agency. After two years of working around security, maintenance, and performance issues with Wordpress—the Gearbox team endeavored to move to a [headless tech stack](https://vercel.com/blog/your-guide-to-headless-commerce).

Gearbox 创始人兼 CEO Troy McGinnis 在创业初期沿用 WordPress 为其客户服务——这正是他此前在另一家代理机构所熟悉的主流技术。然而，在两年间持续应对 WordPress 带来的安全漏洞、维护负担与性能瓶颈后，Gearbox 团队决心转向一套[无头技术栈（headless tech stack）](https://vercel.com/blog/your-guide-to-headless-commerce)。

> “Coming from the WordPress world to the Vercel world, everything in our life has become more efficient. Things like cloning an existing project or onboarding a new developer used to take many hours. Compare this against Next.js and Vercel, which takes less than five minutes. We clone the repo from GitHub, hook it up to Sanity CMS, and then we are up and running. It’s insanely fast.
>
> “从 WordPress 生态转入 Vercel 生态后，我们工作中的方方面面都变得更加高效。过去，克隆一个既有项目或为新开发者配置环境动辄耗费数小时；而借助 Next.js 与 Vercel，整个过程耗时不到五分钟——我们只需从 GitHub 克隆代码仓库，将其接入 Sanity CMS，即可立即启动并运行。速度简直惊人。
>
> Coming from the WordPress world to the Vercel world, everything in our life has become more efficient. Things like cloning an existing project or onboarding a new developer used to take many hours. Compare this against Next.js and Vercel, which takes less than five minutes. We clone the repo from GitHub, hook it up to Sanity CMS, and then we are up and running. It’s insanely fast.
>
> 从 WordPress 生态转入 Vercel 生态后，我们工作中的方方面面都变得更加高效。过去，克隆一个既有项目或为新开发者配置环境动辄耗费数小时；而借助 Next.js 与 Vercel，整个过程耗时不到五分钟——我们只需从 GitHub 克隆代码仓库，将其接入 Sanity CMS，即可立即启动并运行。速度简直惊人。
>
> ”
>
> ![](images/incremental-migration-from-wordpress-for-a-dev-first-approach-vercel/img_001.jpg)
>
> **Troy McGinnis,** Gearbox CEO
>
> **Troy McGinnis**，Gearbox 首席执行官

They initially chose Gatsby as their frontend framework. But “Gatsby and WordPress were still too restrictive. Gatsby was falling off the radar. That’s when we found Next.js and Vercel. We loved it from the get-go, and with all the recent features, it just keeps getting better and better.”

他们最初选用 Gatsby 作为前端框架。但“Gatsby 与 WordPress 的组合仍过于受限；Gatsby 本身也正逐渐淡出业界视野。就在此时，我们发现了 Next.js 与 Vercel——从第一眼起便深深爱上。而随着近期一系列新特性的持续推出，这套方案正变得愈发强大、愈发完善。”

## Going headless at the edge

## 在边缘计算层实现无头架构

![Vercel's Edge Network gives you access to powerful compute without added latency. Test locally, deploy globally, with zero configuration.](images/incremental-migration-from-wordpress-for-a-dev-first-approach-vercel/img_002.jpg)Vercel's Edge Network gives you access to powerful compute without added latency. Test locally, deploy globally, with zero configuration.

![Vercel 边缘网络让您无需额外延迟即可享受强大计算能力：本地测试，全球部署，零配置起步。](images/incremental-migration-from-wordpress-for-a-dev-first-approach-vercel/img_002.jpg)Vercel 边缘网络（Edge Network）让您无需额外延迟即可享受强大计算能力：本地测试，全球部署，零配置起步。

Gearbox uses [Edge Middleware](https://vercel.com/features/edge-functions) to incrementally adopt Next.js. One advantage of this is in managing blog redirects, to maintain SEO. With Edge Middleware, the new posts automatically rewrite to an existing WordPress blog under the hood, filter traffic, and point to other services and websites—all while masking the URL and without complicated server setup. Eventually, they will move everything from that WordPress blog and this allows the team to incrementally migrate in phases and manage scopes accordingly.

Gearbox 借助 [Edge Middleware（边缘中间件）](https://vercel.com/features/edge-functions) 实现 Next.js 的渐进式采用。其中一大优势在于博客重定向管理，从而保障搜索引擎优化（SEO）效果不受影响。通过 Edge Middleware，新发布的博文可在底层自动重写至现有 WordPress 博客，同时完成流量过滤，并将请求导向其他服务或网站——整个过程全程隐藏真实 URL，且无需复杂的服务器配置。最终，Gearbox 将把全部内容从该 WordPress 博客中迁移出来；而这一机制，使团队得以分阶段、按范围有序推进迁移工作。

## Security, streamlined

## 安全，更简捷

The Gearbox team deeply values the security of their clients’ apps and sites. Security vulnerabilities are common with legacy WordPress sites, so the team often pushes clients to migrate to Vercel with this in mind.

Gearbox 团队高度重视客户应用与网站的安全性。传统 WordPress 网站普遍存在安全漏洞，因此团队常以此为出发点，积极推动客户迁移到 Vercel。

McGinnis shares, “We actually just had a client run a penetration test with their legacy WordPress stack, and it failed within a few hours. **The first thing that popped into my head was, ‘if this was on Vercel and Next.js, we wouldn’t be having this problem.' We’d be locked down on security, and Vercel would be handling all this for us.”**

麦金尼斯（McGinnis）分享道：“我们最近刚协助一位客户对其传统 WordPress 技术栈开展渗透测试，结果几小时内就宣告失败。**我脑海中闪过的第一个念头就是：‘如果这套系统部署在 Vercel 和 Next.js 上，根本就不会出现这个问题。’ 我们的安全防护将坚如磐石，而所有底层安全运维工作都将由 Vercel 代为处理。”**

With Vercel, sites are secure by default: requests are handled in isolation and content is replicated globally, ensuring stability by design.

借助 Vercel，网站默认即具备安全性：每个请求均被隔离处理，内容在全球范围内自动复制，从架构设计层面保障了系统稳定性。

## Getting to production faster

## 更快交付上线

The Gearbox team also loves [Vercel Preview Deployments.](https://vercel.com/features/previews) “I was just raving to our team that it’s so nice to have Preview URLs. Previously we would have to pull down the database from the server to be able to view development content, or hook it up to another database and then pull down files, and it was all very time consuming even just to review code," says McGinnis, "whereas with Vercel and our Preview URLs, it’s just there. It’s so integrated into our workflow.

Gearbox 团队同样十分青睐 [Vercel 预览部署（Preview Deployments）功能。](https://vercel.com/features/previews) 麦金尼斯表示：“我刚刚还在向团队盛赞预览 URL 的便利性。过去，我们若想查看开发中的内容，必须先从服务器拉取数据库，或将其连接至另一套数据库再下载文件——哪怕仅为了代码评审，整个过程也极其耗时。而如今借助 Vercel 及其预览 URL，一切唾手可得，已深度融入我们的工作流。”

## A revamped workflow for continued success

## 全新工作流，成就持续成功

Gearbox has been all-in on Vercel and Next.js for almost three years now. They have a growing and diverse client base, from breweries to government agencies. Even if their clients can’t switch to a composable tech stack all at once, they experience the benefits of Next.js and Vercel with each increment of their migration.

Gearbox 已全面采用 Vercel 与 Next.js 近三年之久。其客户群体持续扩大且高度多元，涵盖精酿啤酒厂、政府机构等各类组织。即便客户无法一步到位地切换至可组合式技术栈，也能在迁移的每一步中切实感受到 Next.js 与 Vercel 带来的优势。

“It has completely reshaped how we approach development workflow,” says McGinnis.

“它彻底重塑了我们对开发工作流的设计与实践方式。”麦金尼斯表示。

[**Ready to go headless at the edge?**\\
\\
Talk to a Next.js expert about reshaping your team's workflow.\\
\\
Get in touch](https://vercel.com/contact)

[**准备好迈向边缘端无头架构了吗？**\\
\\
联系 Next.js 专家，共同重构您团队的开发工作流。\\
\\
立即联络](https://vercel.com/contact)