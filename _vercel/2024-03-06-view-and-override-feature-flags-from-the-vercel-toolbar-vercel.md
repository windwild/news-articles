---
render_with_liquid: false
title: "View and override feature flags from the Vercel Toolbar - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/view-and-override-feature-flags-from-the-vercel-toolbar"
date: "2024-03-06"
scraped_at: "2026-03-02T09:47:03.154651019+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Mar 6, 2024

2024 年 3 月 6 日

![](images/view-and-override-feature-flags-from-the-vercel-toolbar-vercel/img_001.jpg)![](images/view-and-override-feature-flags-from-the-vercel-toolbar-vercel/img_002.jpg)

You can now view and [override your application's feature flags](https://vercel.com/blog/toolbar-feature-flags) from the Vercel Toolbar.

您现在可以通过 Vercel 工具栏查看并[覆写您应用的特性开关（feature flags）](https://vercel.com/blog/toolbar-feature-flags)。

This means you can override flags provided by LaunchDarkly, Optimizely, Statsig, Hypertune, Split, or your custom setup without leaving your Vercel environment.

这意味着，您无需离开 Vercel 环境，即可覆写由 LaunchDarkly、Optimizely、Statsig、Hypertune、Split 或您自定义方案所提供的特性开关。

Vercel can now query an API Route defined in your application to find out about your feature flags, and will pick up their values by scanning the DOM for script tags. From there you can create overrides from the Vercel Toolbar, per session, for shorter feedback loops and improved QA and testing. Additionally, the overrides will be stored in an optionally encrypted cookie so your application can respect them.

Vercel 现在可通过查询您应用中定义的 API 路由来获取特性开关信息，并通过扫描 DOM 中的 `<script>` 标签来提取其值。随后，您可在 Vercel 工具栏中按会话（per session）创建覆写规则，从而缩短反馈周期，提升质量保证（QA）与测试效率。此外，这些覆写规则将被存储于一个可选加密的 Cookie 中，以便您的应用能够识别并遵循它们。

This functionality is currently in beta and available to users on all plans.

该功能目前处于 Beta 测试阶段，所有订阅计划的用户均可使用。

[Check out the documentation](https://vercel.com/docs/workflow-collaboration/feature-flags) to learn more.

[查阅文档](https://vercel.com/docs/workflow-collaboration/feature-flags) 了解更多信息。

If you're a feature flag provider and interested in integrating with the Vercel Toolbar, [contact us](https://vercel.com/help).

如果您是特性开关服务提供商，且有意与 Vercel 工具栏集成，请[联系我们](https://vercel.com/help)。