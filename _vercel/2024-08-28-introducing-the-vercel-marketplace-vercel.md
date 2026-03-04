---
render_with_liquid: false
title: "Introducing the Vercel Marketplace - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-the-vercel-marketplace"
date: "2024-08-28"
scraped_at: "2026-03-02T09:41:51.869862299+00:00"
language: "en-zh"
translated: true
description: "The Vercel Marketplace adds support for EdgeDB, Redis, and Supabase with unified billing and simpler installations."
---
render_with_liquid: false
render_with_liquid: false

Aug 28, 2024

2024 年 8 月 28 日

我们推出 Vercel Marketplace 的首个版本，新增对三种数据库选项的支持。

Last year, we added [storage solutions](https://vercel.com/blog/vercel-storage) to our platform, introducing our first-party Blob and Edge Config, as well as partner solutions like Postgres by Neon and KV by Upstash. We heard your feedback—you want more providers and different types of integrations.

去年，我们在平台中新增了[存储解决方案](https://vercel.com/blog/vercel-storage)，推出了自研的 Blob 和 Edge Config，以及由 Neon 提供的 Postgres、Upstash 提供的 KV 等合作伙伴解决方案。我们认真听取了大家的反馈——你们希望支持更多服务提供商，并接入更多类型的集成。

Today, we’re launching the first version of the Vercel Marketplace. It supports storage solutions from [Supabase](https://vercel.com/marketplace/supabase), [Redis](https://vercel.com/marketplace/redis-cloud), and [EdgeDB](https://vercel.com/marketplace/edgedb), at the same price as going direct. These integrations come with features like integrated billing, direct connections to provider consoles, and more.

今天，我们正式发布 Vercel Marketplace 的首个版本。它支持来自 [Supabase](https://vercel.com/marketplace/supabase)、[Redis](https://vercel.com/marketplace/redis-cloud) 和 [EdgeDB](https://vercel.com/marketplace/edgedb) 的存储解决方案，价格与直接向服务商购买完全一致。这些集成还提供统一账单管理、直连服务商控制台等便捷功能。

## One platform, many products

## 一个平台，多种产品

Managing multiple logins, setup configurations, and billing systems can be a hassle. The Vercel Marketplace helps you find and integrate services that work well with your Vercel projects.

管理多个登录账号、配置流程和计费系统往往令人头疼。Vercel Marketplace 帮助你轻松发现并集成与 Vercel 项目高度兼容的服务。

You can log into provider dashboards without needing separate logins, making access easier. Managing your subscriptions and billing is straightforward since it’s all handled directly in the Vercel dashboard. Plus, you can explore pricing options and free plans that can grow with your projects.

你无需单独登录，即可直接访问服务商控制台，大幅提升访问效率；订阅管理和账单结算全部在 Vercel 控制台内一站式完成，操作更简单；此外，你还可以浏览各类定价方案及免费计划，灵活适配项目不同发展阶段的需求。

![](images/introducing-the-vercel-marketplace-vercel/img_001.jpg)![](images/introducing-the-vercel-marketplace-vercel/img_002.jpg)

## Focusing on flexible and reliable storage first

## 首先聚焦灵活、可靠的存储能力

We're starting with storage integrations given how important databases are for building applications. These storage solutions are available on Hobby, Pro, and Enterprise plans through a self-service flow. Our initial integrations include:

鉴于数据库在应用开发中的核心地位，我们首先从存储类集成入手。这些存储解决方案已面向 Hobby、Pro 和 Enterprise 计划用户开放，可通过自助式流程快速启用。首批集成包括：

- **Supabase:** 一家领先的面向开发者的 Postgres 数据库服务提供商，提供身份认证（auth）、实时（real-time）和向量（vector）服务，专注于性能与可靠性。

- **Redis:** 非常适合构建快速、动态且可无缝扩展的应用程序，例如 AI 智能体、聊天机器人及个性化引擎，同时确保您的数据始终可访问且响应迅速。

- **EdgeDB:** 一款基于 Postgres 的现代关系型数据库，具备高级对象数据模型、内置迁移引擎、高性能查询语言等特性。


![](images/introducing-the-vercel-marketplace-vercel/img_003.jpg)![](images/introducing-the-vercel-marketplace-vercel/img_004.jpg)

## Vercel Postgres 和 Vercel KV 的下一步计划是什么？

自去年发布以来，由 Neon 提供支持的 Vercel Postgres 和由 Upstash 提供支持的 Vercel KV 已获得数十万开发者的信赖。

Neon 和 Upstash 的合作伙伴团队一直在积极优化其平台并推出新功能。从 11 月起，我们将开始自动将所有 Vercel Postgres 和 Vercel KV 实例迁移至 Vercel Marketplace，以便开发者能够使用这些新功能。

- **Vercel Postgres** 将过渡至 **Neon**，从而获得更强的可扩展性、灵活性以及更多高级功能。

- **Vercel KV** 将过渡至 **Upstash** —— 一款以成本效益高、性能卓越著称的无服务器 Redis 解决方案。


在 11 月之前，您仍可照常使用现有服务；新项目则将在后续完成迁移。

These transitions will happen with no downtime and no work needed on your part. After the migration, you’ll have full access to the Neon and Upstash feature sets, and you’ll manage new stores through their Marketplace integrations. Pricing and limits will match what you’d get by going direct to Neon and Upstash.

这些迁移将零停机、无需您执行任何操作。迁移完成后，您将完全访问 Neon 和 Upstash 的全部功能，并可通过其 Marketplace 集成来管理新数据库实例。定价与配额将与您直接向 Neon 和 Upstash 采购时保持一致。

## How to get started

## 如何开始使用

The Vercel Marketplace, featuring Supabase, Redis, and EdgeDB is live today. You can explore the integrations at [vercel.com/marketplace](https://vercel.com/marketplace), where detailed documentation will help you get started quickly.

Vercel Marketplace 现已上线，首批集成包括 Supabase、Redis 和 EdgeDB。您可前往 [vercel.com/marketplace](https://vercel.com/marketplace) 浏览相关集成，详尽的文档将助您快速上手。

We'll be adding more integrations to the Marketplace based on your feedback. Our goal is to build a simple, convenient place to get access to the best developer tools in the ecosystem.

我们将持续根据您的反馈，在 Marketplace 中新增更多集成服务。我们的目标是打造一个简洁、便捷的一站式平台，让您轻松获取生态系统中最优秀的开发者工具。

If you're a service provider interested in joining the Marketplace, feel free to reach out to us at integrations@vercel.com.

如果您是希望入驻 Marketplace 的服务提供商，欢迎通过 integrations@vercel.com 与我们联系。