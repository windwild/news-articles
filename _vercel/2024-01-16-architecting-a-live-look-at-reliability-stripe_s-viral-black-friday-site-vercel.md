---
render_with_liquid: false
title: "Architecting a live look at reliability: Stripe's viral Black Friday site - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/architecting-reliability-stripes-black-friday-site"
date: "2024-01-16"
scraped_at: "2026-03-02T09:48:52.005135095+00:00"
language: "en-zh"
translated: true
description: "Vercel x Stripe social image"
---
render_with_liquid: false
render_with_liquid: false

Jan 16, 2024

2024 年 1 月 16 日

Stripe 如何借助 Vercel 构建并优化其首个面向核心业务的深度洞察平台。

#### 1700 万+

上线首日的边缘请求量

#### 100%

正常运行时间（Uptime）

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

2023 年，企业在 Stripe 平台上于“黑色星期五”与“网络星期一”（BFCM）期间处理的交易总额超过 186 亿美元。

今年，在“黑色星期五”仅剩 19 天之际，Stripe 提出一个问题：“如果……会怎样？”——如果向公众开放 Stripe 的核心业务指标，深度呈现其业务运营状况、系统可靠性以及产品覆盖范围，又将如何？

为此，Stripe 公司内部来自各个部门的员工通力协作，共同打造了一个实时更新、公开可访问的微型网站。该网站动态展示了 Stripe 在 BFCM 期间的系统可靠性、交易量、全球业务活动等关键数据——而整个项目全部部署在 Vercel 平台上。

![](images/architecting-a-live-look-at-reliability-stripe_s-viral-black-friday-site-vercel/img_001.jpg)

通过依托 Vercel 基于框架定义的基础设施，Stripe 团队得以将精力集中于设计、性能与可靠性，而无需在短短 19 天内从零构建一套动态缓存系统。

Stripe 在创纪录的时间内打造了一个实时体验，让观众得以首次目睹前所未有的实时交易数据。借助 Vercel 强大的基础设施，以及 Next.js、SWR 和 ISR 等前沿技术，最终实现了一个性能卓越、运行 flawless 的微型网站（microsite）。

> “如果没有 Vercel，这一切根本不可能实现——尤其不可能在短短 19 天内完成。”  
>  
> ![](images/architecting-a-live-look-at-reliability-stripe_s-viral-black-friday-site-vercel/img_002.jpg)  
>  
> **Sam McAllister，Stripe**

## 针对病毒式传播的实时微型网站所面临的独特挑战进行优化

Stripe 需要在快速的首屏加载速度、流畅的用户交互体验，以及对应用中动态组件的有效管理之间取得平衡。

最初，他们曾考虑采用“每个客户端一个 WebSocket”的方案来处理实时更新。然而，受限于极其紧张的工期和预期的高并发流量，团队最终选择了一种更务实的方案：轮询后端缓存，并高频次地对该缓存进行重新填充（rehydration）。其中，SWR 负责在客户端实现近实时的交互体验，而 ISR（增量静态再生）则确保动态内容的更新无需为每次请求都直接查询后端。

**我们进一步拆解如下：**

- [**getStaticProps（gSP）**](https://nextjs.org/docs/pages/building-your-application/data-fetching/get-static-props) **：** 在构建时（build time）获取静态数据，确保页面首次加载所需的核心数据已被预先获取并完成服务端渲染（SSR/SSG），从而显著提升首屏性能。

- [**Stale-While-Revalidate（SWR）**](https://vercel.com/docs/edge-network/headers?__vercel_draft=1#stale-while-revalidate) **：** 在 _客户端_ 管理实时数据与用户交互：一方面立即向用户展示当前缓存中的最新数据（stale），另一方面在后台自动触发数据重新验证（revalidate），以静默方式拉取更新。该机制既保障了用户体验的实时性与响应速度，又避免了对后端造成过载压力。

- [**Incremental Static Regeneration (ISR)**](https://vercel.com/docs/incremental-static-regeneration) **：** 对 `getStaticProps`（gSP）和 `SWR` 生成的静态内容进行自动化重新验证，并自动将更新后的内容分发并预热至整个 Vercel 边缘网络。

- [**增量静态再生（ISR）**](https://vercel.com/docs/incremental-static-regeneration) **：** 对由 `getStaticProps`（gSP）和 `SWR` 生成的静态内容进行自动化重新验证，并自动将更新后的内容分发并预热至整个 Vercel 边缘网络。

Stripe 采用了最大缓存时间为一秒（`max-age=1`）的缓存策略，使应用能够以极低的后端查询量交付静态页面；在用户访问静态页面的同时，后台持续更新内容，从而确保系统在流量高峰期间仍能高效处理每秒数百万级请求。

Stripe 采用了最大缓存时间为一秒（`max-age=1`）的缓存策略，使应用能够以极低的后端查询量交付静态页面；在用户访问静态页面的同时，后台持续更新内容，从而确保系统在流量高峰期间仍能高效处理每秒数百万级请求。

[**Framework-defined infrastructure**\\
\\
Understand the basis for Vercel's framework-defined infrastructure that turns your code into globally-provisioned cloud application.\\
\\
Learn more](https://vercel.com/blog/framework-defined-infrastructure)

[**框架定义的基础设施**\\
\\
了解 Vercel 框架定义基础设施（Framework-defined Infrastructure）的核心原理——它如何将您的代码自动转化为全球部署的云原生应用。\\
\\
了解更多](https://vercel.com/blog/framework-defined-infrastructure)

这一组合策略通过将流量导向 Vercel 缓存网络，并利用 ISR 在后台生成数据，显著降低了后端负载。最终实现了无缝的用户体验：计数器可实时更新，且整体性能毫不妥协。

这一组合策略通过将流量导向 Vercel 缓存网络，并利用 ISR 在后台生成数据，显著降低了后端负载。最终实现了无缝的用户体验：计数器可实时更新，且整体性能毫不妥协。

![Screenshot of part of Stripe's microsite, taken on Black Friday GMT afternoon.](images/architecting-a-live-look-at-reliability-stripe_s-viral-black-friday-site-vercel/img_003.jpg)Screenshot of part of Stripe's microsite, taken on Black Friday GMT afternoon.

![黑色星期五（GMT 时间下午）期间截取的 Stripe 微型网站部分界面截图。](images/architecting-a-live-look-at-reliability-stripe_s-viral-black-friday-site-vercel/img_003.jpg)黑色星期五（GMT 时间下午）期间截取的 Stripe 微型网站部分界面截图。

## Ensuring reliability and uncompromising safety

## 确保可靠性与绝对安全

Stripe 以其对基础设施[可靠性](https://twitter.com/dps/status/1597698676872613888)的坚定承诺而闻名。在整个“网一黑五”（BFCM）大促期间，Stripe 处理的交易峰值达每分钟 93,304 笔，同时保持 API 正常运行时间（uptime）超过 99.999%。本次营销活动不仅需彰显该级别的可靠性，更须采用最严格的安保措施，确保任何风险均无法侵入 Stripe 生态系统。

Stripe 以其对基础设施[可靠性](https://twitter.com/dps/status/1597698676872613888)的坚定承诺而闻名。在整个“网一黑五”（BFCM）大促期间，Stripe 处理的交易峰值达每分钟 93,304 笔，同时保持 API 正常运行时间（uptime）超过 99.999%。本次营销活动不仅需彰显该级别的可靠性，更须采用最严格的安保措施，确保任何风险均无法侵入 Stripe 生态系统。

**Everything isolated: API-first approach to securing the core business**

**全面隔离：以 API 为先，筑牢核心业务安全防线**

首先，团队确保微型网站的数据源与 Stripe 核心基础设施完全隔离。这种刻意设计的分离机制构成了一道关键防护屏障，确保即便出现异常状况，其影响范围也仅限于独立的终端节点，不会波及核心系统。

首先，团队确保微型网站的数据源与 Stripe 核心基础设施完全隔离。这种刻意设计的分离机制构成了一道关键防护屏障，确保即便出现异常状况，其影响范围也仅限于独立的终端节点，不会波及核心系统。

**Fallback Strategy: Navigating the Unknown**

**回退策略：从容应对未知挑战**

In the realm of real-time data streaming, where novel metrics were being presented for the first time, the team acknowledged the need for a robust fallback strategy. Should a metric fail to update or cease to provide results, meticulous planning was put in place to detect and mitigate those scenarios.

在实时数据流领域，当一系列全新指标首次亮相时，团队认识到必须制定一套稳健的备用方案。一旦某项指标停止更新或无法返回结果，团队已通过周密规划，确保能及时发现并妥善应对这些异常情况。

By teaming up with Vercel, Stripe's innovative BFCM microsite provided a unique, live insight into Stripe's operational reliability, showcasing an impressive handling of high transaction volumes while ensuring exceptional API uptime. In 19 days, the rapid and successful execution of this project not only emphasizes Stripe's role as a leader in innovation, but also establishes a new benchmark for efficiency in the fintech sector.

通过与 Vercel 合作，Stripe 推出的创新型“黑色星期五/网络星期一”（BFCM）微型网站，为公众提供了独一无二的实时窗口，直观展现 Stripe 的运营可靠性——不仅从容应对海量交易请求，更保障了极高的 API 正常运行时间。该项目仅用 19 天便高效、圆满地完成交付，不仅凸显 Stripe 作为科技创新领导者的地位，更在金融科技领域树立了效率新标杆。

[![Paul Graham](images/architecting-a-live-look-at-reliability-stripe_s-viral-black-friday-site-vercel/img_004.jpg)](https://x.com/paulg/status/1728031749723021576)

[![保罗·格雷厄姆](images/architecting-a-live-look-at-reliability-stripe_s-viral-black-friday-site-vercel/img_004.jpg)](https://x.com/paulg/status/1728031749723021576)

[Paul Graham](https://x.com/paulg/status/1728031749723021576)

[保罗·格雷厄姆](https://x.com/paulg/status/1728031749723021576)


· [Follow](https://x.com/intent/follow?screen_name=paulg)

· [关注](https://x.com/intent/follow?screen_name=paulg)

[View on Twitter](https://x.com/paulg/status/1728031749723021576)

[在 Twitter 上查看](https://x.com/paulg/status/1728031749723021576)

Everyone interested in startups should try clicking this link.

所有关注初创企业的人都不妨点击此链接一试。

所有关注初创企业的人都不妨点击此链接一试。

What a power move, when merely displaying your live stats is the most impressive marketing you can do.

仅仅展示实时运行数据，便已成为你所能做的最震撼的营销举措——这真是一招高明的制胜之策。

仅仅展示实时运行数据，便已成为你所能做的最震撼的营销举措——这真是一招高明的制胜之策。

[7:44 AM · Nov 24, 2023](https://x.com/paulg/status/1728031749723021576) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[上午 7:44 · 2023 年 11 月 24 日](https://x.com/paulg/status/1728031749723021576) [Twitter 网站工具、广告信息与隐私政策](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[2.8K](https://x.com/intent/like?tweet_id=1728031749723021576) [Reply](https://x.com/intent/tweet?in_reply_to=1728031749723021576)

[2.8K](https://x.com/intent/like?tweet_id=1728031749723021576) [回复](https://x.com/intent/tweet?in_reply_to=1728031749723021576)

[Read 48 replies](https://x.com/paulg/status/1728031749723021576)

[阅读 48 条回复](https://x.com/paulg/status/1728031749723021576)

[![Patrick Collison](images/architecting-a-live-look-at-reliability-stripe_s-viral-black-friday-site-vercel/img_005.jpg)](https://x.com/patrickc/status/1728023528757170400)

[![帕特里克·科利森](images/architecting-a-live-look-at-reliability-stripe_s-viral-black-friday-site-vercel/img_005.jpg)](https://x.com/patrickc/status/1728023528757170400)

Patrick Collison

帕特里克·科利森

@patrickc

@patrickc

Stripe, live: bfcm.stripe.dev.

Stripe 线上运行中：bfcm.stripe.dev。

Vercel.com landing page

Vercel.com 官网落地页

### Learn about the next steps.

### 了解后续步骤

Blog post

博客文章

Dec 21, 2023

2023 年 12 月 21 日

### The developer experience of the Frontend Cloud

### 前端云的开发者体验

![](images/architecting-a-live-look-at-reliability-stripe_s-viral-black-friday-site-vercel/img_006.jpg)

![](images/architecting-a-live-look-at-reliability-stripe_s-viral-black-friday-site-vercel/img_006.jpg)

Alice Alexandra Moore

爱丽丝·亚历山德拉·摩尔