---
title: "Scale to one: How Fluid solves cold starts - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/scale-to-one-how-fluid-solves-cold-starts"
date: "2025-09-18"
scraped_at: "2026-03-02T09:28:11.103884389+00:00"
language: "en-zh"
translated: true
description: "Learn how Vercel solves serverless cold starts with scale to one, Fluid compute, predictive scaling, and caching to keep functions warm and fast."
---

render_with_liquid: false
Sep 18, 2025

2025 年 9 月 18 日

First impressions matter

第一印象至关重要

Cold starts have long been the Achilles’ heel of traditional serverless. It’s not just the delay itself, but _when_ the delay happens. Cold starts happen when someone new discovers your app, when traffic is just starting to pick up, or during those critical first interactions that shape whether people stick around or convert.

冷启动长期以来一直是传统无服务器架构的致命弱点。问题不仅在于延迟本身，更在于**延迟发生的时间点**：当新用户首次发现你的应用、流量刚刚开始上升，或在那些决定用户是否留存或转化的关键初次交互过程中，冷启动便不期而至。

Traditional serverless platforms shut down inactive instances after a few minutes to save costs. But then when traffic returns, users are met with slow load times while new instances spin up. This is where developers would normally have to make a choice. Save money at the expense of unpredictable performance, or pay for always-on servers that increase costs and slow down scalability.

传统无服务器平台为节省成本，通常在数分钟后关闭闲置实例；但当流量再次涌入时，用户却不得不面对新实例启动期间漫长的加载延迟。此时，开发者往往被迫做出取舍：要么牺牲性能稳定性以降低成本，要么为始终在线的服务器付费——而这既推高了成本，又制约了可扩展性。

But what if you didn't have to choose? That’s why we built a better way.

但如果无需取舍呢？正因如此，我们构建了一种更优的方案。

Powered by [Fluid compute](https://vercel.com/blog/introducing-fluid-compute), Vercel delivers **zero cold starts for 99.37% of all requests. Fewer than one request in a hundred will ever experience a cold start.** If they do happen, they are faster and shorter-lived than on a traditional serverless platform.

依托 [Fluid Compute（弹性计算）](https://vercel.com/blog/introducing-fluid-compute) 技术，Vercel 实现了**99.37% 的请求零冷启动**——每百次请求中，冷启动发生的概率不足一次。即便偶有发生，其耗时也比传统无服务器平台更短、更迅速。

Through a combination of platform-level optimizations, we've made cold starts a solved problem in practice. What follows is how that’s possible and why it works at every scale.

通过一系列平台级优化，冷启动在实践中已成为一个已被解决的问题。下文将详解其实现原理，以及为何该方案能在任意规模下稳定生效。

## What a cold start is and why it matters

## 什么是冷启动？为何它至关重要？

A cold start happens when a serverless function instance must initialize from scratch to handle a request. The platform allocates compute resources, loads your application code, initializes the runtime environment, and establishes network connections. This process can take up to several seconds.

冷启动是指无服务器函数实例为响应请求而必须从零开始初始化的过程：平台需分配计算资源、加载你的应用代码、初始化运行时环境，并建立网络连接。整个过程可能长达数秒。

For users, [this translates to blank screens, loading spinners, or unresponsive interfaces](https://v0-cold-start-demo.vercel.sh/) during what should be instant interactions.

对用户而言，这直接表现为本应瞬时完成的交互中出现**空白页面、加载转圈图标，或界面无响应**等体验断层。[点击此处亲身体验](https://v0-cold-start-demo.vercel.sh/)。

The unpredictability makes it hard to debug and explain to stakeholders. You can't easily reproduce them in development, since your local environment stays warm, and they're difficult to monitor because they happen sporadically.

不可预测性使得调试和向相关方解释问题变得困难。由于本地开发环境始终处于“预热”状态，你很难在开发中复现这些问题；又因为冷启动是偶发事件，因此也难以对其进行有效监控。

![Cold starts solved from every angle](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_001.jpg)![Cold starts solved from every angle](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_002.jpg)![Cold starts solved from every angle](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_003.jpg)![Cold starts solved from every angle](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_004.jpg)Cold starts solved from every angle

![冷启动问题，全方位解决](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_001.jpg)![冷启动问题，全方位解决](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_002.jpg)![冷启动问题，全方位解决](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_003.jpg)![冷启动问题，全方位解决](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_004.jpg)冷启动问题，全方位解决

## How Vercel prevents cold starts: The complete solution stack

## Vercel 如何防止冷启动：完整的解决方案栈

Our approach tackles cold starts from five angles:

我们的方案从五个维度应对冷启动问题：

- **预防（Prevention）**：Scale to one 在实例被实际需要之前就保持其“预热”状态  
- **降低发生频率（Frequency reduction）**：Fluid compute 复用已有实例处理多个请求  
- **提前预判（Anticipation）**：[预测式扩缩容（Predictive scaling）](https://vercel.com/docs/functions/concurrency-scaling) 在流量需求到来之前预先预热实例  
- **减轻影响（Impact reduction）**：[字节码缓存（Bytecode caching）](https://vercel.com/blog/introducing-bytecode-caching-for-vercel-functions) 加速那些不可避免的冷启动过程  
- **发布管理（Release management）**：[滚动发布（Rolling releases）](https://vercel.com/docs/rolling-releases) 避免部署期间引发大规模冷启动  

Each layer compounds the others. The result is cold starts becoming a non-issue at any scale.

各层能力相互增强、协同作用。最终效果是：无论系统规模如何，冷启动都不再成为实际问题。

## Scale to one: Eliminating first visitor cold starts

## 缩容至一：消除首访者冷启动

Most serverless platforms scale to zero when idle. Resources that have not received traffic for a few minutes are shut down to improve efficiency. On Vercel, production deployments on Pro and Enterprise plans work differently.

大多数无服务器平台在空闲时会缩容至零。若资源在几分钟内未收到任何流量，便会自动关闭以提升资源利用效率。而在 Vercel 上，Pro 和 Enterprise 计划下的生产环境部署则采用不同的机制。

![Keeping one instance warm prevents first-visitor cold starts](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_005.jpg)![Keeping one instance warm prevents first-visitor cold starts](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_006.jpg)![Keeping one instance warm prevents first-visitor cold starts](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_007.jpg)![Keeping one instance warm prevents first-visitor cold starts](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_008.jpg)Keeping one instance warm prevents first-visitor cold starts

![保持一个实例常驻可防止首访者冷启动](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_005.jpg)![保持一个实例常驻可防止首访者冷启动](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_006.jpg)![保持一个实例常驻可防止首访者冷启动](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_007.jpg)![保持一个实例常驻可防止首访者冷启动](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_008.jpg)保持一个实例常驻可防止首访者冷启动

### How it works and architecture fit

### 其工作原理与架构适配性

We always keep at least one function instance running. Instead of scaling to zero, we scale to one. This works automatically for qualifying deployments; there is nothing you need to configure or enable.

我们始终至少保持一个函数实例处于运行状态。与其缩容至零，不如缩容至一。该机制对符合条件的部署自动生效，无需您手动配置或启用任何设置。

Pre-warming prevents a third of potential cold starts. It applies to single-region functions, middlewares, and multi-region functions, providing the foundation that other optimizations build upon.

预热机制可避免约三分之一的潜在冷启动。它适用于单区域函数、中间件（middleware）以及多区域函数，为其他性能优化措施提供基础支撑。

### Real-world scenarios

### 真实场景示例

If your app receives very little traffic, scaling to zero would mean almost all initial interactions are cold starts. This produces a poor experience when performance matters most.

如果您的应用流量极低，缩容至零将导致几乎每一次初始交互都触发冷启动——而这恰恰发生在用户体验最敏感、性能表现至关重要的时刻。

Imagine a stealth startup with 20 trusted testers. Each tester's session lasts about five minutes. Testers access the app at random times, often leaving hours between visits. On a traditional serverless platform, each tester experiences a cold start at the most important moment: their first impression of your product.

设想一家处于保密阶段的初创公司，拥有 20 名可信测试人员。每位测试者的会话持续约五分钟，且访问时间随机分布，两次访问之间往往间隔数小时。在传统无服务器平台上，每位测试者在最关键的一刻——即他们对您产品的第一印象——都会遭遇冷启动。

With scale to one, when a user visits your app, even if no one else has been around in a while, they experience a quick response, from a warm function.

启用“缩容至一”后，当用户访问您的应用时——即便此前已长时间无人访问——他们仍将获得来自已预热函数的快速响应。

The same problem happens at the enterprise scale with preview deployments. You build a new feature, deploy it to a preview URL, and share it with stakeholders for review. On traditional platforms, if the CEO clicks that preview link hours later, they wait 3-4 seconds for the page to load while the function cold starts. They don't know it's a cold start. They just know your feature feels slow.

同样的问题在企业级预览部署（preview deployments）场景中也会发生。你开发了一个新功能，将其部署到一个预览 URL，并将该链接分享给相关干系人进行评审。在传统平台上，如果 CEO 数小时后点击该预览链接，页面加载需等待 3–4 秒——此时函数正经历冷启动（cold start）。他们并不知道这是冷启动，只觉得你的功能“反应迟缓”。

For teams on Enterprise plans, scale to one also applies to the most recent deployment of any branch URL for up to three days. That means when executives or other collaborators review feature branches, even at midnight or over the weekend, the experience is instant and responsive. No awkward delays during the demos that matter most.

对于订阅企业版（Enterprise）计划的团队，“缩放至一”（Scale to One）策略同样适用于任意分支 URL 的最新一次部署，且该部署将保持热态（warm）长达三天。这意味着，当高管或其他协作者在午夜或周末审查功能分支时，体验依然即时、响应迅速——在那些至关重要的演示环节中，再也不会出现令人尴尬的延迟。

### Coverage and conditions

### 覆盖范围与适用条件

Scale to one applies automatically under these conditions:

“缩放至一”（Scale to One）将在以下条件下自动启用：

- **Pro and Enterprise plans**: current production deployment (warm if invoked in the last 14 days)

- **Pro 与 Enterprise 计划**：当前生产环境部署（若过去 14 天内被调用过，则保持热态）

- **Enterprise plans**: most recent branch deployment (kept warm up to three days)

- **Enterprise 计划**：任意分支的最新一次部署（最长保持热态达三天）

There’s no additional cost: you only pay when your app receives usage, unlike dedicated servers that run 24/7.

无需额外付费：你仅在应用实际产生用量时才计费，这与全天候运行的专用服务器（dedicated servers）截然不同。

## Fluid compute: Reuse what's warm

## 流式计算（Fluid Compute）：复用已就绪的资源

[Fluid compute](https://vercel.com/fluid) rethinks the traditional serverless model. Instead of spinning up one instance for every request, each function instance can serve many requests at the same time. In practice, functions behave more like lightweight servers, capable of handling concurrent traffic without requests interfering with one another or limiting scalability.

[流式计算（Fluid Compute）](https://vercel.com/fluid) 重新构想了传统的无服务器（serverless）模型。它不再为每个请求单独启动一个实例，而是让每个函数实例可同时服务多个请求。在实践中，函数的行为更接近轻量级服务器，能够高效处理并发流量，各请求之间互不干扰，也绝不会因单个请求而限制整体可扩展性。

![Traditional serverless vs. Fluid Compute concurrency](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_009.jpg)![Traditional serverless vs. Fluid Compute concurrency](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_010.jpg)![Traditional serverless vs. Fluid Compute concurrency](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_011.jpg)![Traditional serverless vs. Fluid Compute concurrency](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_012.jpg)Traditional serverless vs. Fluid Compute concurrency

![传统无服务器架构 vs. 流式计算并发能力](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_009.jpg)![传统无服务器架构 vs. 流式计算并发能力](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_010.jpg)![传统无服务器架构 vs. 流式计算并发能力](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_011.jpg)![传统无服务器架构 vs. 流式计算并发能力](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_012.jpg)传统无服务器架构 vs. 流式计算并发能力

### How Fluid compute eliminates cold starts

### Fluid Compute 如何消除冷启动

With traditional serverless, a burst of 100 requests might mean 100 new instances, each with the risk of a cold start. Even with predictive scaling, sudden traffic spikes out of nowhere leave no time to pre-warm, so users still hit delays. With Fluid, those same 100 requests might be served by only a handful of already-warm instances. Fluid routes new requests to existing capacity first, only provisioning new instances when absolutely necessary.

在传统 Serverless 架构中，突发的 100 个请求可能触发创建 100 个新实例，每个实例都面临冷启动风险。即使启用了预测式扩缩容（predictive scaling），毫无征兆的流量激增也来不及预先预热，用户仍会遭遇延迟。而使用 Fluid，这 100 个请求可能仅由少数几个已处于“预热”状态的实例即可响应。Fluid 优先将新请求路由至现有可用容量，仅在绝对必要时才新建实例。

### Performance and efficiency gains

### 性能与效率提升

Fewer total instances created means far fewer opportunities for cold starts. In production, single instances regularly handle dozens of requests concurrently, with peaks above 250 concurrent requests per instance. Most instances handle at least 3 concurrent requests at a time, with many processing 11 or more concurrent requests simultaneously.

创建的实例总数更少，意味着冷启动发生的概率大幅降低。在生产环境中，单个实例通常可同时处理数十个请求，峰值甚至超过每实例 250 个并发请求。大多数实例至少能同时处理 3 个并发请求，许多实例更可并行处理 11 个或更多请求。

Functions waiting on AI or database responses can process additional requests simultaneously. With [Active CPU pricing](https://vercel.com/changelog/lower-pricing-with-active-cpu-pricing-for-fluid-compute), you only pay for CPU when code is actively executing, not during those idle periods. By reusing what's already warm, Fluid compute turns cold starts into a rare edge case.

正在等待 AI 或数据库响应的函数，可同时处理其他请求。借助 [Active CPU 计费模式](https://vercel.com/changelog/lower-pricing-with-active-cpu-pricing-for-fluid-compute)，您仅在代码实际执行期间为 CPU 资源付费，空闲等待时段不计费。通过复用已预热的资源，Fluid Compute 将冷启动转变为一种罕见的边缘情况。

## Predictive scaling: Warming ahead of demand

## 预测式扩缩容：需求到来前即完成预热

[Predictive scaling](https://vercel.com/docs/functions/concurrency-scaling#automatic-concurrency-scaling) reduces cold starts by preparing instances before traffic arrives. The system observes traffic patterns and allocates capacity ahead of time, so functions are already warm when requests arrive. This avoids the delays of reactive scaling, where new instances are created only after load has increased.

[Predictive scaling（预测式扩缩容）](https://vercel.com/docs/functions/concurrency-scaling#automatic-concurrency-scaling) 通过在流量抵达前预先准备实例，显著减少冷启动。系统持续观测历史流量模式，并提前分配计算容量，确保函数在请求到达时已处于“预热”状态。这避免了响应式扩缩容（reactive scaling）带来的延迟——后者仅在负载升高后才创建新实例。

It is particularly effective for traffic that follows regular patterns, such as daily usage cycles or known event times. By pre-warming in advance, requests during those periods are served without interruption, and developers do not need to configure or schedule scaling rules.

该机制对具有规律性模式的流量尤为有效，例如每日用户活跃周期或已知时间节点的活动流量。通过提前预热，这些时段内的请求可无缝响应，开发者无需手动配置或调度扩缩容规则。

## Bytecode caching: Start faster when you must

## 字节码缓存：必须冷启动时，启动更快

When cold starts do occur, [bytecode caching](https://vercel.com/blog/introducing-bytecode-caching-for-vercel-functions) makes them significantly faster. [JavaScript must be parsed and compiled into bytecode before execution](https://vercel.com/blog/scale-to-one-how-fluid-solves-cold-starts#what-is-a-cold-start-and-why-does-it-matter). This compilation step is consistently one of the slowest parts of cold starts.

当冷启动确实发生时，[字节码缓存（bytecode caching）](https://vercel.com/blog/introducing-bytecode-caching-for-vercel-functions) 可使其显著加速。[JavaScript 在执行前必须经过解析和编译，生成字节码](https://vercel.com/blog/scale-to-one-how-fluid-solves-cold-starts#what-is-a-cold-start-and-why-does-it-matter)。而这一编译步骤，始终是冷启动过程中最耗时的环节之一。

### How bytecode caching works

### 字节码缓存的工作原理

Bytecode caching stores already-compiled bytecode after the first execution. Subsequent cold starts reuse the cached bytecode, removing the compilation penalty entirely.

字节码缓存会在首次执行后保存已编译的字节码。后续的冷启动将复用该缓存字节码，从而完全消除编译开销。

Our implementation is unique among serverless platforms. We overcome ephemeral file system limitations by intelligently merging bytecode chunks from different routes and lazy-loaded modules. As traffic hits routes like `/home` and `/blog`, separate caches merge. The optimization improves as more of your application gets used.

我们的实现在无服务器平台中独树一帜。我们通过智能合并来自不同路由及懒加载模块的字节码片段，克服了临时性文件系统的限制。当流量访问 `/home` 和 `/blog` 等路由时，各自独立的缓存会自动合并。随着您应用中更多功能被使用，该优化效果将持续增强。

### Performance improvements by application size

### 按应用规模划分的性能提升

Real-world tests with Next.js applications show substantial improvements:

在真实 Next.js 应用中的测试表明，性能获得显著提升：

![](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_013.jpg)![](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_014.jpg)![](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_015.jpg)![](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_016.jpg)

## Rolling releases: Preventing deployment-induced cold starts

## 渐进式发布：防止部署引发的冷启动

Traditional deployments create a source of cold starts that exists completely outside normal traffic patterns that other optimizations can't prevent. Even with perfect traffic-based optimizations, when you deploy to production, 100% of traffic suddenly needs new instances. Every user hits a cold start simultaneously.

传统部署方式会引入一类完全脱离常规流量模式的冷启动源，而其他优化手段对此无能为力。即使流量驱动的优化已臻完美，一旦向生产环境发布新版本，100% 的请求将瞬间需要全新实例——所有用户将同时遭遇冷启动。

![Rolling releases prevent cold start spikes during deployments](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_017.jpg)![Rolling releases prevent cold start spikes during deployments](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_018.jpg)![Rolling releases prevent cold start spikes during deployments](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_019.jpg)![Rolling releases prevent cold start spikes during deployments](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_020.jpg)Rolling releases prevent cold start spikes during deployments

![渐进式发布可防止部署期间出现冷启动峰值](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_017.jpg)![渐进式发布可防止部署期间出现冷启动峰值](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_018.jpg)![渐进式发布可防止部署期间出现冷启动峰值](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_019.jpg)![渐进式发布可防止部署期间出现冷启动峰值](images/scale-to-one-how-fluid-solves-cold-starts-vercel/img_020.jpg)渐进式发布可防止部署期间出现冷启动峰值

### How rolling releases prevent deployment spikes

### 渐进式发布如何防止部署引发的冷启动峰值

[Rolling releases](https://vercel.com/docs/rolling-releases) gradually shift traffic to new deployments instead of switching everything at once. This gradual approach gives Fluid compute time to intelligently provision new instances as demand grows.

[滚动发布](https://vercel.com/docs/rolling-releases) 会逐步将流量迁移至新部署，而非一次性全部切换。这种渐进式方式为 Fluid Compute 留出时间，使其能根据需求增长智能地预置新实例。

When a small percentage of traffic first hits the new deployment, Fluid compute routes requests to already-warm instances and begins pre-warming additional ones. As more traffic shifts over, concurrency and predictive scaling work together to expand capacity ahead of demand. By the time the rollout completes, the new deployment has a full set of warm instances ready to handle 100% of traffic with no cold start penalty.

当少量流量首次抵达新部署时，Fluid Compute 将请求路由至已处于“预热”（warm）状态的实例，并同时开始预热更多实例。随着迁移流量持续增加，并发处理能力与预测式扩缩容协同作用，在实际需求到来之前即提前扩展容量。待滚动发布完成时，新部署已拥有一整套完全预热的实例，可立即承载 100% 的流量，彻底规避冷启动延迟。

This transforms deployment from a sudden cold start crisis into a managed scaling event. Instead of every user hitting a cold start when the deployment switches, the infrastructure scales smoothly alongside the traffic migration.

这将部署过程从一场突发的冷启动危机，转变为一次受控的弹性扩缩容事件。用户不再因部署切换而集体遭遇冷启动；基础设施将随流量迁移平滑伸缩。

## Cold starts solved at every scale

## 各规模场景下的冷启动问题均已解决

Cold starts used to be the unavoidable cost of serverless. On Vercel, they’re solved in practice.

过去，冷启动曾是无服务器架构中无法回避的成本；而在 Vercel 上，它已在实践中得到切实解决。

Through scale to one, Fluid compute, predictive scaling, bytecode caching, and rolling releases, cold starts are prevented, reduced, or accelerated until they’re no longer a meaningful factor in production. At every scale, from a startup’s first users to global enterprise traffic, applications remain warm and responsive.

依托“单实例起步”（scale to one）、Fluid Compute、预测式扩缩容、字节码缓存（bytecode caching）以及滚动发布等技术，冷启动或被完全避免、或显著减少、或大幅加速——最终在生产环境中不再构成实质性影响。无论初创公司迎来首批用户，还是全球性企业承载海量流量，应用始终维持预热状态，响应迅捷如初。

Developers don’t need to choose between efficiency and performance anymore. First impressions stay fast, serverless delivers on its promise without trade-offs.

开发者从此无需再在资源效率与性能表现之间艰难取舍。首屏加载始终飞快，无服务器架构真正兑现其承诺，且毫无妥协。

[**Enable Fluid compute for your deployments**\\
\\
Stop worrying about cold starts and ensure your first impressions are always fast.\\
\\
Get started](https://vercel.com/fluid)

[**为您的部署启用 Fluid Compute**\\
\\
告别冷启动焦虑，确保每一次首屏体验都快速流畅。\\
\\
立即开始](https://vercel.com/fluid)