---
render_with_liquid: false
title: "Introducing deeper integrations for feature flags in Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/feature-flags"
date: "2024-05-23"
scraped_at: "2026-03-02T09:44:07.857422661+00:00"
language: "en-zh"
translated: true
description: "Introducing a platform-wide understanding of feature flags in Vercel, and an experimental Next.js design pattern for working with flags in code."
---
render_with_liquid: false
render_with_liquid: false

May 23, 2024

2024 年 5 月 23 日

推出全平台统一的特性开关（Feature Flags）支持，以及一种实验性的 Next.js 设计模式。

特性开关帮助团队自信地发布功能、安全地渐进式上线变更，并高效开展测试，从而提升协作效率、加速开发周期。如果您正在使用 [LaunchDarkly](https://launchdarkly.com/)、[Statsig](https://www.statsig.com/)、[Split](https://www.split.io/) 或 [Optimizely](https://www.optimizely.com/) 等工具创建特性开关，我们将竭力让这些开关与您的 Vercel 工作流无缝集成，操作尽可能简单。

我们首先从 [Edge Config](https://vercel.com/docs/storage/edge-config) 入手，让您能够自主管理特性开关，并享受更快的加载速度。通过直接从 Edge Config 引导（bootstrap）特性开关（无需经过网络请求），其加载速度至少可达直接从第三方服务商加载的两倍。

为进一步提升开发者体验，我们着力优化了特性开关的日常使用流程。过去，即便是对开关进行微小或临时的调整，也需登录外部管理控制台；如今，我们推出了全新能力：可直接通过 [Vercel Toolbar（Vercel 工具栏）](https://vercel.com/docs/workflow-collaboration/feature-flags/using-vercel-toolbar) 覆盖（override）特性开关值。这彻底免去了在浏览器标签页间切换、登录外部开关服务商的繁琐步骤——该功能目前已显著优化了 Notion 和 Leonardo.Ai 等公司的协作工作流。

今天，我们非常高兴地宣布：Vercel 开发者体验平台（Developer Experience Platform）将与特性开关实现更深层次集成；同时，我们还将推出一种实验性的 Next.js 设计模式，助您将特性开关的使用体验提升至全新高度。

## 通过 Vercel Toolbar 覆盖您的特性开关

Vercel 可调用您应用中定义的 API Route，以获取特性开关列表并读取其当前值——具体方式是扫描页面 DOM 中的 `<script>` 标签。随后，您即可在 Vercel Toolbar 中按会话（per session）覆盖任意开关值，从而缩短反馈周期，提升质量保障（QA）与测试效率。此外，所有覆盖值将被存储于一个可选加密的 Cookie 中，确保您的应用能正确识别并尊重这些设置。

使用特性开关切换 Notion 新版首页设计

Notion 等团队已率先在 Vercel 上启用该功能，通过 Vercel Toolbar 覆盖特性开关，显著优化了自身特性开关工作流。Notion 近期新版首页的灰度发布，正是依托这一能力实现的。

> “Working with our feature flags in Vercel boosts our ability to quickly and safely iterate on experiments and features in development. The best part? It just works. It feels so magical during our development process. Working with our feature flags in Vercel boosts our ability to quickly and safely iterate on experiments and features in development. The best part? It just works. It feels so magical during our development process.”

> “在 Vercel 中使用我们的功能开关（feature flags），显著提升了我们在开发过程中快速、安全地迭代实验与新功能的能力。最棒的是？它开箱即用，整个开发流程仿佛充满魔法。”

![](images/introducing-deeper-integrations-for-feature-flags-in-vercel-vercel/img_001.png)

**Tanner Godarzi,** Frontend Engineer at Notion  
**Tanner Godarzi**，Notion 前端工程师

Since this initial release, we have also added the ability to [recommend branch-based feature flag overrides](https://vercel.com/changelog/recommend-branch-based-feature-flag-overrides) in order to equip your team and quickly share work in development. The toolbar will suggest flag overrides to team members working on the branch locally or when visiting a branch Preview Deployment.

自本次初始发布以来，我们还新增了[基于分支推荐功能开关覆盖项（branch-based feature flag overrides）](https://vercel.com/changelog/recommend-branch-based-feature-flag-overrides)的能力，助力团队高效协作，并加速开发中工作的共享。当团队成员在本地开发该分支，或访问对应分支的预览部署（Preview Deployment）时，工具栏将主动推荐相应的开关覆盖配置。

As part of that change, we’ve also improved the onboarding for setting up and integrating feature flags into the toolbar.

作为此次更新的一部分，我们也优化了功能开关接入工具栏的引导流程（onboarding），使设置与集成更加顺畅直观。

## **Integration with the DX Platform**

## **与开发者体验（DX）平台集成**

Now in beta, your flags are integrated with Vercel [Web Analytics](https://vercel.com/docs/analytics) and [Runtime Logs](https://vercel.com/docs/observability/runtime-logs).

目前该功能已进入 Beta 阶段：您的功能开关现已与 Vercel [Web Analytics（网页分析）](https://vercel.com/docs/analytics) 和 [Runtime Logs（运行时日志）](https://vercel.com/docs/observability/runtime-logs) 深度集成。

You can filter and break down your site's page views and custom analytics events by feature flags, helping you gain a deeper understanding of how your flags will impact your users. This granular level of analysis in Web Analytics empowers data-driven decisions, allowing you to optimize your experiments for maximum impact, regardless of your chosen flags provider.

您可按功能开关对网站的页面浏览量及自定义分析事件进行筛选与细分，从而更深入地理解不同开关配置对用户行为的实际影响。Web Analytics 中这种细粒度的分析能力，为数据驱动的决策提供了坚实支撑——无论您选用哪家功能开关服务提供商，均可据此持续优化实验设计，实现最大业务影响。

![Flags are directly integrated with Vercel Web Analytics and Runtime Logs.](images/introducing-deeper-integrations-for-feature-flags-in-vercel-vercel/img_002.jpg)![Flags are directly integrated with Vercel Web Analytics and Runtime Logs.](images/introducing-deeper-integrations-for-feature-flags-in-vercel-vercel/img_003.jpg)

功能开关已直接集成至 Vercel Web Analytics 与 Runtime Logs。

`@vercel/flags` lets you integrate with the toolbar and platform. Check out the [example repository](https://github.com/vercel/shirt-shop).

`@vercel/flags` 可帮助您轻松完成工具栏与平台的集成。欢迎查看 [示例代码仓库](https://github.com/vercel/shirt-shop)。

```javascript
import { reportValue } from "@vercel/flags"
```

reportValue("summer-sale", true)
```

与运行时日志集成。

通过将这些信息直接呈现在您的日志中，您将获得调试和故障排查所不可或缺的上下文信息。借助对错误发生时确切条件的清晰理解，您可以更快地定位并解决问题，从而确保用户获得流畅无缝的体验。

```javascript
import { FlagValues } from '@vercel/flags/react';



3<FlagValues values={{ "summer-sale": true }} />
```

与网页分析集成。

不久之后，您还将能够在生产环境中动态切换功能开关，并即时在 Speed Insights 中实时查看其对 Web Vitals 的影响。

## 以代码形式管理功能开关

Traditional client-side feature flag implementations often lead to performance issues like loading spinners, flashing the wrong experiment, and layout shifts. This is called [jank](https://developer.mozilla.org/en-US/docs/Glossary/Jank), and it negatively impacts your user experience and SEO.

传统的客户端侧功能开关（feature flag）实现常常引发性能问题，例如加载旋转指示器（loading spinners）、错误实验内容的短暂闪现（flashing the wrong experiment），以及页面布局偏移（layout shifts）。这种现象被称为 [“卡顿”（jank）](https://developer.mozilla.org/zh-CN/docs/Glossary/Jank)，会严重损害用户体验和搜索引擎优化（SEO）效果。

We believe server-side experimentation is the better method. Companies want to do server-side experimentation but don't have the right tools today to make this easy, fast, and maintainable, which is why we’re working on a new design pattern. We've implemented this approach of working with feature flags in code for Next.js in our `@vercel/flags/next` package, and we're working on a SvelteKit implementation as well.

我们坚信服务端实验（server-side experimentation）是更优方案。企业普遍希望开展服务端实验，但当前缺乏足够易用、高效且可维护的工具——正因如此，我们正在设计一种全新的开发范式。我们已在 `@vercel/flags/next` 包中为 Next.js 实现了该范式下的功能开关编码实践；同时，我们也正在为 SvelteKit 开发对应的实现。

Your feature flag providers give you flag values, but they don't have opinions about usage. This design pattern encodes our best practices, which avoid all those pitfalls and makes it way more approachable.

您的功能开关服务提供商仅向您返回开关值（flag values），但对“如何使用”并无规范或建议。而本设计范式则内嵌了我们总结的最佳实践，可彻底规避上述各类陷阱，并显著降低上手门槛。

- `@vercel/flags/react`: Helper functions to integrate with the toolbar and platform  
- `@vercel/flags/react`: 用于与工具栏（toolbar）及平台集成的辅助函数  

- `@vercel/flags/next`: Implements our flags patterns for Next.js  
- `@vercel/flags/next`: 为 Next.js 实现我们的功能开关设计模式  

```javascript
import { unstable_flag as flag } from "@vercel/flags/next"



export const showSummerSale = flag({​​​​​‌‍​‍​‍‌‍‌​‍‌‍‍‌‌‍‌‌‍‍‌‌‍‍​‍​‍​‍‍​‍​‍‌‍​‌‍‌‍‍‌‌​‌‍‌‌‌‍‍‌‌​‌‍‌‍‌‌‌‌‍​​‍‍‌‍​‌‍‌‍‌​‍​‍​‍​​‍​‍‌‍‍​‌​‍‌‍‌‌‌‍‌‍​‍​‍​‍‍​‍​‍​‍‌‍​‌‌​​‌‍‍‌​‍‌‍​‍‌‍​‌‍‌‍‌​‍‌‍‌‌‌‍‌​‌‍‍‌‌‌​​‌‍‌‌​‌​‌‌‌‌‌‍​‌​‌‍‌​​‌​‌‌‍‌‍‍​​‌​​​‌​‌​‌‍‌‍‍​​​​​​‍‌‍‍‍‌‍‍‌‌‍‌‌‌‌‍‌​‌​‌‌‍‍​​​‍‌‍‌‌​​‌‌‍‌‌​‍​‍‌‌

4  key: 'summer-sale',​​​​‌‍​‍​‍‌‍‌​‍‌‍‍‌‌‍‌‌‍‍‌‌‍‍​‍​‍​‍‍​‍​‍‌‍​‌‍‌‍‍‌‌​‌‍‌‌‌‍‍‌‌​‌‍‌‍‌‌‌‌‍​​‍‍‌‍​‌‍‌‍‌​‍​‍​‍​​‍​‍‌‍‍​‌​‍‌‍‌‌‌‍‌‍​‍​‍​‍‍​‍​‍​‍‌‍​‌‌​​‌‍‍‌​‍‌‍​‍‌‍​‌‍‌‍‌​‍‌‍‌‌‌‍‌​‌‍‍‌‌‌​​‌‍‌‌​‌​‌‌‌‌‌‍​‌​‌‍‌​​‌​‌‌‍‌‍‍​​‌​​​‌​‌​‌‍‌‍‍​​​​​​‍‌‍‍‍‌‍‍‌‌‍‌‌‌‌‍‌​‌​‌‌‍‍​​​‍‌‍‌‌​​‌‌‍‌‌​‍​‍‌‌

5  async decide() {​​​​‌‍​‍​‍‌‍‌​‍‌‍‍‌‌‍‌‌‍‍‌‌‍‍​‍​‍​‍‍​‍​‍‌‍​‌‍‌‍‍‌‌​‌‍‌‌‌‍‍‌‌​‌‍‌‍‌‌‌‌‍​​‍‍‌‍​‌‍‌‍‌​‍​‍​‍​​‍​‍‌‍‍​‌​‍‌‍‌‌‌‍‌‍​‍​‍​‍‍​‍​‍​‍‌‍​‌‌​​‌‍‍‌​‍‌‍​‍‌‍​‌‍‌‍‌​‍‌‍‌‌‌‍‌​‌‍‍‌‌‌​​‌‍‌‌​‌​‌‌‌‌‌‍​‌​‌‍‌​​‌​‌‌‍‌‍‍​​‌​​​‌​‌​‌‍‌‍‍​​​​​​‍‌‍‍‍‌‍‍‌‌‍‌‌‌‌‍‌​‌​‌‌‍‍​​​‍‌‍‌‌​​‌‌‍‌‌​‍​‍‌‌
```

6    return false;​​​​‌‍​‍​‍‌‍‌​‍‌‍‍‌‌‍‌‌‍‍‌‌‍‍​‍​‍​‍‍​‍​‍‌‍​‌‍‌‍‍‌‌​‌‍‌‌‌‍‍‌‌​‌‍‌‍‌‌‌‌‍​​‍‍‌‍​‌‍‌‍‌​‍​‍​‍​​‍​‍‌‍‍​‌​‍‌‍‌‌‌‍‌‍​‍​‍​‍‍​‍​‍​‍‌‍​‌‌​​‌‍‍‌​‍‌‍​‍‌‍​‌‍‌‍‌​‍‌‍‌‌‌‍‌​‌‍‍‌‌‌​​‌‍‌‌​‌​‌‌‌‌‌‍​‌​‌‍‌​​‌​‌‌‍‌‍‍​​‌​​​‌​‌​‌‍‌‍‍​​​​​​‍‌‍‍‍‌‍‍‌‌‍‌‌‌‌‍‌​‌​‌‌‍‍​​​‍‌‍‌‌​​‌‌‍‌‌​‍​‍‌‌

6    返回 false；

7  },​​​​‌‍​‍​‍‌‍‌​‍‌‍‍‌‌‍‌‌‍‍‌‌‍‍​‍​‍​‍‍​‍​‍‌‍​‌‍‌‍‍‌‌​‌‍‌‌‌‍‍‌‌​‌‍‌‍‌‌‌‌‍​​‍‍‌‍​‌‍‌‍‌​‍​‍​‍​​‍​‍‌‍‍​‌​‍‌‍‌‌‌‍‌‍​‍​‍​‍‍​‍​‍​‍‌‍​‌‌​​‌‍‍‌​‍‌‍​‍‌‍​‌‍‌‍‌​‍‌‍‌‌‌‍‌​‌‍‍‌‌‌​​‌‍‌‌​‌​‌‌‌‌‌‍​‌​‌‍‌​​‌​‌‌‍‌‍‍​​‌​​​‌​‌​‌‍‌‍‍​​​​​​‍‌‍‍‍‌‍‍‌‌‍‌‌‌‌‍‌​‌​‌‌‍‍​​​‍‌‍‌‌​​‌‌‍‌‌​‍​‍‌‌

7  }，

8});‍​​​​
8});

Declaring your own feature flag.

声明您自己的功能标志（Feature Flag）。

```javascript
import { showSummerSale } from "@/flags"



export async function Banner() {

4  const summerSale = await showSummerSale()

5  return summerSale ? <SummerSaleBanner /> : <RegularBanner />;

6}
```

```javascript
import { showSummerSale } from "@/flags";

export async function Banner() {
  const summerSale = await showSummerSale();

  return summerSale ? <SummerSaleBanner /> : <RegularBanner />;
}
```

Using a feature flag.

使用一个功能标志（Feature Flag）。

In addition, we also established a new pattern that allows Middleware to decide which prerendered version of a page to show. This means you can eliminate layout shifts and jank typically caused by client-side experimentation. We refer to this approach of predetermining the feature flags' values and making routing decisions in Middleware as _precomputing flags_.

此外，我们还确立了一种新模式，允许中间件（Middleware）决定向用户展示哪个预渲染版本的页面。这意味着您可以消除通常由客户端实验所导致的布局偏移（layout shifts）和卡顿（jank）。我们将这种在中间件中预先确定功能标志取值并据此做出路由决策的方法称为 **_预计算标志（precomputing flags）_**。

This experimental pattern enables server-side experimentation, routing users to statically generated pages tailored to their specific experiment group. This approach works even when multiple feature flags and experiments are present on the same page and delivers better performance, eliminates layout shifts, and ensures accurate experimentation results. We're sharing our approach to working with flags in code early, and we look forward to your feedback.

这一实验性模式支持服务端实验：将用户路由至为其特定实验分组量身定制的静态生成页面。即使同一页面上存在多个功能标志与实验，该方案依然有效，同时可提升性能、彻底避免布局偏移，并确保实验结果的准确性。我们提前向社区分享了代码中操作功能标志的具体实践方式，诚挚期待您的反馈。

[**Check out the SDK**\\
\\
Start experimenting server-side, with better performance and less jank. \\
\\
View the docs](https://flags-sdk.dev/)

[**查看 SDK**\\
\\
立即开启服务端实验——性能更优，卡顿更少。\\
\\
查阅文档](https://flags-sdk.dev/)

We're excited to equip developers with these powerful new tools for working with feature flags. By seamlessly integrating with your existing workflows and providing deeper insights into user behavior, Vercel enables you to ship safely, experiment smarter, and build truly exceptional web experiences.

我们非常激动能为开发者提供这些功能强大的全新工具，以更高效地管理功能标志。Vercel 无缝融入您现有的工作流，并为您提供更深入的用户行为洞察，助您安全发布、更智能地开展实验，并打造真正卓越的 Web 体验。

[**Start interacting with your application’s feature flags.**\\
\\
Unlock the new workflow today: Use the Vercel Toolbar to read and set feature flag overrides for your application.\\
\\
Get started](https://vercel.com/docs/workflow-collaboration/feature-flags/using-vercel-toolbar)

[**开始与您应用的功能标志进行交互。**\\
\\
即刻启用全新工作流：使用 Vercel 工具栏（Vercel Toolbar）读取并设置您应用的功能标志覆写（overrides）。\\
\\
立即开始](https://vercel.com/docs/workflow-collaboration/feature-flags/using-vercel-toolbar)