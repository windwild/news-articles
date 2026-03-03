---
title: "Vercel: The anti-vendor-lock-in cloud - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-the-anti-vendor-lock-in-cloud"
date: "2025-11-10"
scraped_at: "2026-03-02T09:26:09.784074269+00:00"
language: "en-zh"
translated: true
description: "Framework-defined infrastructure interprets your code and provisions what you need, keeping your application portable across any platform."
---

Nov 10, 2025

2025年11月10日

Vendor lock-in matters when choosing a cloud platform. Cloud platforms can lock you in by requiring you to build against their specific primitives. Vercel takes a different approach: you write code for your framework, not for Vercel.

选择云平台时，厂商锁定（vendor lock-in）至关重要。云平台可能通过强制您基于其专有原语（primitives）进行开发，从而将您锁定在其生态中。Vercel 采取了截然不同的路径：您为所用框架编写代码，而非为 Vercel 编写代码。

On AWS, you configure Lambda functions, NAT Gateways, and DynamoDB tables. On Cloudflare, you write Workers, use KV stores, Durable Objects, and bind services with Worker Service Bindings. These primitives only exist with that vendor, which means migrating to another platform requires rewriting your application architecture.

在 AWS 上，您需配置 Lambda 函数、NAT 网关和 DynamoDB 表；在 Cloudflare 上，您需编写 Workers、使用 KV 存储、Durable Objects，并通过 Worker Service Bindings 绑定服务。这些原语仅存在于对应厂商的平台中，这意味着迁移到另一平台时，必须重写整个应用架构。

Too often, cloud platforms make these choices for you. They define proprietary primitives, APIs, and services that pull your code deeper into their ecosystem until leaving becomes impractical.

太多时候，云平台替您做了这些技术选型：它们定义专有的原语、API 和服务，将您的代码越拉越深地嵌入其生态体系，直至退出变得不切实际。

At Vercel, we believe the opposite approach creates better software and a healthier web. We want developers to stay because they want to, not because they have to. That means building open tools, embracing standards, and ensuring your code remains portable no matter where it runs.

在 Vercel，我们坚信相反的路径才能构建更优质的软件、打造更健康的网络生态。我们希望开发者留下，是因为他们愿意，而不是因为他们别无选择。这意味着构建开放工具、拥抱开放标准，并确保您的代码无论运行于何处，都始终具备可移植性。

So Vercel works differently. It interprets your framework code and provisions infrastructure automatically. Your application does not need to know it runs on Vercel. You do not need to import Vercel modules or call Vercel APIs. This is [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure).

因此，Vercel 的工作方式与众不同：它解析您的框架代码，并自动配置基础设施。您的应用无需知晓自身运行于 Vercel 之上；您既不必导入 Vercel 模块，也无需调用 Vercel API。这便是所谓的[框架定义基础设施（Framework-Defined Infrastructure）](https://vercel.com/blog/framework-defined-infrastructure)。

## What vendor lock-in actually means

## 厂商锁定的实际含义

Vendor lock-in happens when a platform builds features that deviate from open standards, which are accessed in your application code via proprietary APIs. If your application uses those features, you cannot move to another platform without rewriting code.

厂商锁定发生于某平台构建的功能偏离开放标准，且这些功能需通过专有 API 在您的应用代码中调用。一旦您的应用使用了这些功能，便无法在不重写代码的前提下迁移至其他平台。

When you build against vendor primitives like AWS Step Functions or Cloudflare Durable Objects, those dependencies live in your application code. Your business logic ties to platform APIs, which means moving requires rewriting that logic to work with different primitives.

当您基于 AWS Step Functions 或 Cloudflare Durable Objects 等厂商原语进行开发时，这些依赖便直接嵌入您的应用代码之中。您的业务逻辑与平台 API 紧密耦合，这意味着迁移时必须重写该逻辑，以适配另一套原语。

Framework conventions like the Next.js App Router, Remix loaders, SvelteKit endpoints, and Nitro storage adapters work differently. You build against the framework, not the platform. Multiple platforms can run the same framework code, keeping your application portable across any infrastructure that supports it.

而 Next.js App Router、Remix loaders、SvelteKit endpoints 和 Nitro 存储适配器等框架约定则截然不同：您面向的是框架本身，而非特定平台。多个平台均可运行同一套框架代码，从而确保您的应用在任何支持该框架的基础设施上均保持可移植性。

![Framework-defined Infrastructure means developers define infrastructure through their framework, not through vendor-specific code or logic.](images/vercel-the-anti-vendor-lock-in-cloud-vercel/img_001.jpg)  
![框架定义的基础设施（Framework-defined Infrastructure）意味着开发者通过其框架定义基础设施，而非通过供应商特定的代码或逻辑。](images/vercel-the-anti-vendor-lock-in-cloud-vercel/img_001.jpg)  

![Framework-defined Infrastructure means developers define infrastructure through their framework, not through vendor-specific code or logic.](images/vercel-the-anti-vendor-lock-in-cloud-vercel/img_002.jpg)  
![框架定义的基础设施（Framework-defined Infrastructure）意味着开发者通过其框架定义基础设施，而非通过供应商特定的代码或逻辑。](images/vercel-the-anti-vendor-lock-in-cloud-vercel/img_002.jpg)  

Framework-defined Infrastructure means developers define infrastructure through their framework, not through vendor-specific code or logic.  

框架定义的基础设施（Framework-defined Infrastructure）意味着开发者通过其框架定义基础设施，而非通过供应商特定的代码或逻辑。

## Framework-defined infrastructure means portable code  

## 框架定义的基础设施意味着代码可移植

This portability is possible because of framework-defined infrastructure (FDI). FDI means that the platform reads your code and determines what infrastructure you need. You follow your framework's patterns, Vercel handles the rest.  

这种可移植性得益于框架定义的基础设施（Framework-defined Infrastructure，简称 FDI）。FDI 意味着平台会读取你的代码，并据此自动推断你所需的基础设施。你只需遵循所用框架的约定，其余工作由 Vercel 自动完成。

Complex production applications run on Vercel without mentioning `vercel` anywhere in their codebase. They follow Next.js conventions (or Remix, SvelteKit, Nuxt, or one of 40+ supported frameworks). Vercel analyzes the build output and provisions middleware, functions, static assets, and caching accordingly.  

许多复杂的生产级应用在 Vercel 上运行，但其代码库中**完全不出现任何 `vercel` 相关的代码或配置**。它们严格遵循 Next.js 的约定（或 Remix、SvelteKit、Nuxt，或其他 40+ 种受支持框架的约定）。Vercel 会分析构建产物，并据此自动配置中间件（middleware）、函数（functions）、静态资源（static assets）和缓存策略（caching）。

### Local development requires no Vercel tooling  

### 本地开发无需安装 Vercel 工具链

Platforms built on vendor primitives need complex simulators for local development. Cloudflare provides Wrangler to simulate Workers locally. AWS developers use LocalStack or SAM CLI to mock Lambda and other services. These tools approximate production behavior but never match it exactly.  

基于供应商原语（vendor primitives）构建的平台，往往需要复杂的模拟器来支持本地开发：Cloudflare 提供 Wrangler 用于本地模拟 Workers；AWS 开发者则依赖 LocalStack 或 SAM CLI 来模拟 Lambda 及其他云服务。这些工具虽能近似还原生产环境行为，却永远无法做到完全一致。

With FDI, you run your framework's standard development server. For Next.js, run `next dev`. For Remix, `remix dev`. The code you write runs the same way locally and in production. There's no Vercel CLI to install and no simulation layer creating differences between environments.  

而在 FDI 架构下，你只需运行框架自带的标准开发服务器：Next.js 项目执行 `next dev`，Remix 项目执行 `remix dev`。你编写的代码在本地与生产环境中以**完全相同的方式运行**——无需安装 Vercel CLI，也不存在任何模拟层导致环境差异。

This architectural choice has a direct impact on portability. When you write against framework standards instead of platform primitives, your code can run elsewhere without modification.  

这一架构选择直接提升了代码的可移植性。当你面向框架标准（而非平台原语）编写代码时，你的应用便可在其他兼容该框架的平台上**无需修改即可运行**。

## Most Next.js apps already run outside of Vercel  

## 大多数 Next.js 应用早已运行于 Vercel 之外

Next.js is the most widely deployed framework on Vercel. Because of this, some might assume that this creates lock-in, but the data shows otherwise.  

Next.js 是目前在 Vercel 上部署最广泛的框架。正因如此，有人可能误以为这会导致厂商锁定（vendor lock-in），但实际数据恰恰表明：事实并非如此。

Based on Next.js telemetry tracking distinct projects, approximately 70% of Next.js applications run outside of Vercel. This also likely undercounts non-Vercel deployments because Vercel deployments rarely disable telemetry, while self-hosted deployments often opt out and won't appear in the data.

根据 Next.js 的遥测数据（该数据按独立项目进行统计），约 70% 的 Next.js 应用运行在 Vercel 之外。这一比例很可能低估了非 Vercel 部署的实际规模，因为 Vercel 上的部署极少禁用遥测功能，而自托管部署则常常选择退出遥测，因而不会出现在统计数据中。

Many companies currently self-host Next.js on their own infrastructure, proving this portability in practice. Walmart.com serves millions of shoppers daily on self-hosted Next.js, Nike.com operates at global scale on their own systems, and Claude.ai also built their application with Next.js on their own infrastructure. These are large-scale production applications handling massive traffic on infrastructure that these companies control.

目前，许多公司已在自有基础设施上自托管 Next.js，从而在实践中验证了其可移植性。Walmart.com 每日通过自托管的 Next.js 服务数百万消费者；Nike.com 在其自有系统上实现全球规模运营；Claude.ai 同样基于自有基础设施，使用 Next.js 构建其应用。这些均为大规模生产级应用，承载海量流量，并完全运行于各公司自主掌控的基础设施之上。

Every major cloud vendor provides Next.js deployment options. [Netlify](https://vercel.com/kb/guide/vercel-vs-netlify), Cloudflare, AWS Amplify, Google Cloud, and Azure all support Next.js natively. For custom infrastructure setups, open source projects like OpenNext enable Next.js to run with serverless architectures similar to Vercel.

所有主流云服务商均提供 Next.js 部署选项：[Netlify](https://vercel.com/kb/guide/vercel-vs-netlify)、Cloudflare、AWS Amplify、Google Cloud 和 Azure 均原生支持 Next.js。对于定制化基础设施场景，开源项目（如 OpenNext）可使 Next.js 运行于与 Vercel 类似的无服务器架构之上。

## Next.js adapters formalize the framework-platform contract

## Next.js 适配器正式定义框架与平台间的契约关系

Platform providers told us integration was harder than it should be. This is why the [Next.js team built Build Adapters](https://nextjs.org/blog/next-16#build-adapters-api-alpha) as explicit versioned APIs to formalize the contract between framework and platform. Adapters define what Next.js outputs, what infrastructure features each route needs, and how platforms should handle them.

平台提供商向我们反馈，集成过程比预期更复杂。正因如此，[Next.js 团队构建了构建适配器（Build Adapters）](https://nextjs.org/blog/next-16#build-adapters-api-alpha)，将其作为明确的、带版本控制的 API，以正式确立框架与平台之间的契约关系。适配器明确定义了 Next.js 的输出内容、每条路由所需的基础设施能力，以及平台应如何处理这些输出。

Every Next.js 16 application deployed on Vercel uses the same adapter API available to other platforms. Vercel does not have special access or different integration points. The test suite Vercel uses to validate features is available to all platform providers.

所有部署在 Vercel 上的 Next.js 16 应用，均使用与其他平台完全一致的适配器 API。Vercel 并不享有特殊访问权限，也不存在差异化的集成入口点。Vercel 用于功能验证的测试套件，对所有平台提供商均开放可用。

This is part of our broader [Open SDK strategy](https://vercel.com/blog/open-sdk-strategy): building frameworks, SDKs, and tools that are open, portable, and usable on any platform.

这是我们在更广泛层面推行的 [Open SDK 战略](https://vercel.com/blog/open-sdk-strategy) 的一部分：构建开放、可移植、且可在任意平台上使用的框架、SDK 与工具。

## Standards first, portable always

## 标准优先，始终可移植

We prioritize standard protocols wherever possible. Databases offered on the Vercel Marketplace use standard protocols like Postgres and Redis. These are provided through marketplace partners like Neon, Supabase, and Upstash, or you can connect to any instance you operate. AWS is our preferred cloud provider, so when you connect to databases hosted in the same AWS region as your application, you get low-latency connectivity.

我们尽可能优先采用标准协议。Vercel Marketplace 中提供的数据库均基于 Postgres、Redis 等标准协议。这些数据库由 Neon、Supabase 和 Upstash 等 Marketplace 合作伙伴提供；您亦可连接至自行运维的任意数据库实例。AWS 是我们首选的云服务商，因此当您的应用与数据库同处于同一 AWS 区域时，即可获得低延迟的网络连接。

The same philosophy extends to our AI infrastructure. [AI Gateway](https://vercel.com/ai-gateway) supports the OpenAI API format, which has been established as a de-facto industry standard by OpenAI, Anthropic, and most other model providers. Switching between calling OpenAI directly or routing through the AI Gateway requires only changing the API endpoint URL in your configuration, with no code changes needed.

这一理念同样贯穿于我们的 AI 基础设施设计之中。[AI Gateway](https://vercel.com/ai-gateway) 支持 OpenAI API 格式——该格式已被 OpenAI、Anthropic 及绝大多数其他大模型提供商确立为事实上的行业标准。在直接调用 OpenAI 与通过 AI Gateway 路由之间切换，仅需修改配置中的 API 端点 URL，无需任何代码变更。

Some services require proprietary APIs because no industry standard exists yet. [Vercel Sandbox](https://vercel.com/docs/vercel-sandbox) provides secure execution of untrusted code. [Edge Config](https://vercel.com/docs/edge-config) offers ultra-low latency reads with a simple `get(key)` interface for distributed configuration. Moving to alternatives would require updating your code to use their APIs. However, the difference is that these services can be called from any infrastructure, including EC2 or your own servers, without requiring you to use Vercel for hosting. When industry-standard APIs emerge for these use cases, we will implement them.

某些服务需要专有 API，因为目前尚无行业标准。[Vercel Sandbox](https://vercel.com/docs/vercel-sandbox) 提供对不可信代码的安全执行能力。[Edge Config](https://vercel.com/docs/edge-config) 为分布式配置提供超低延迟的读取能力，并通过简洁的 `get(key)` 接口即可调用。若迁移到其他替代方案，则需更新您的代码以适配其 API。但关键区别在于：这些服务可从任意基础设施（包括 EC2 或您自有的服务器）调用，而无需将应用托管于 Vercel。一旦这些使用场景出现行业标准 API，我们将立即予以支持。

## Why we build this way

## 我们为何如此构建

Building portable open source software is a core value at Vercel. We build open source to create an enduring business that enables us to keep developing great open source software. Our goal is to improve the default quality of software for everyone, everywhere, whether they are Vercel customers or not.

构建可移植的开源软件是 Vercel 的核心价值观。我们投身开源，旨在打造一家可持续发展的企业，从而持续开发优秀的开源软件。我们的目标是提升全球每一位开发者的默认软件质量——无论他们是否为 Vercel 的客户。

When developers learn Next.js, Nuxt, or the AI SDK, they need to trust that investment won't trap them on a single platform. That trust drives broader adoption. Broader adoption creates a larger ecosystem. A larger ecosystem makes every platform better, including Vercel.

当开发者学习 Next.js、Nuxt 或 AI SDK 时，他们需要确信：这一技术投入不会将其锁定在单一平台之上。这种信任推动更广泛的采用；更广泛的采用催生更繁荣的生态系统；而更繁荣的生态系统则让所有平台（包括 Vercel）都变得更强大。

We want you to stay with Vercel because you choose to, not because you have to. The best way to earn that choice is to build tools that work everywhere and a platform that makes those tools better.

我们希望您留在 Vercel，是出于主动选择，而非别无他选。赢得这份选择的最佳方式，就是打造“随处可用”的工具，以及一个能让这些工具发挥更大价值的平台。