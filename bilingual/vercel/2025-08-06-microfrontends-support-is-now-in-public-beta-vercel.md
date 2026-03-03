---
title: "Microfrontends support is now in Public Beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/microfrontends-support-is-now-in-public-beta"
date: "2025-08-06"
scraped_at: "2026-03-02T09:30:15.015733062+00:00"
language: "en-zh"
translated: true
description: "Vercel's microfrontends support is now in public beta allowing users to split large applications to develop faster."
---

Aug 6, 2025

2025 年 8 月 6 日

[Microfrontends](https://vercel.com/docs/microfrontends) support is now available in [Public Beta](https://vercel.com/docs/release-phases#public-beta). Microfrontends allow you to split large applications into smaller ones so that developers can move more quickly.

[微前端（Microfrontends）](https://vercel.com/docs/microfrontends) 支持现已进入 [公开测试阶段（Public Beta）](https://vercel.com/docs/release-phases#public-beta)。微前端技术允许您将大型应用拆分为多个更小的独立应用，从而帮助开发团队更快地迭代与交付。

This support lets teams and large apps build and test independently, while Vercel assembles and routes the app into a single experience. This reduces build times, supports parallel development, and enables gradual legacy migration.

该功能支持团队及大型应用各自独立构建与测试，而 Vercel 则负责将各微前端模块组装并路由为统一的用户体验。此举可显著缩短构建时间、支持并行开发，并助力实现渐进式遗留系统迁移。

Developers can use the [Vercel Toolbar](https://vercel.com/docs/microfrontends/managing-microfrontends/vercel-toolbar) to iterate and test their apps independently, while navigations between microfrontends benefit from [prefetching and prerendering](https://vercel.com/docs/microfrontends/managing-microfrontends#optimizing-navigations-between-microfrontends) for fast transitions between the applications.

开发者可借助 [Vercel 工具栏（Vercel Toolbar）](https://vercel.com/docs/microfrontends/managing-microfrontends/vercel-toolbar) 独立迭代和测试各自的应用；同时，微前端之间的页面跳转可利用 [预获取（prefetching）与预渲染（prerendering）](https://vercel.com/docs/microfrontends/managing-microfrontends#optimizing-navigations-between-microfrontends) 技术，实现应用间快速、流畅的切换。

To get started with microfrontends, clone [one of our examples](https://vercel.com/templates/microfrontends) or follow the [quickstart](https://vercel.com/docs/microfrontends/quickstart) guide:

如需开始使用微前端，请克隆 [我们的任一示例项目](https://vercel.com/templates/microfrontends)，或参考 [快速入门指南（quickstart）](https://vercel.com/docs/microfrontends/quickstart)：

1. In the Vercel dashboard, navigate to the [Microfrontends tab](https://vercel.com/d?to=%2F%5Bteam%5D%2F~%2Fsettings%2Fmicrofrontends&title=Try+Microfrontends) in Settings

1. 在 Vercel 控制台中，进入「设置（Settings）」→ [「微前端（Microfrontends）」标签页](https://vercel.com/d?to=%2F%5Bteam%5D%2F~%2Fsettings%2Fmicrofrontends&title=Try+Microfrontends)

2. Create a microfrontends group containing all of your microfrontend projects

2. 创建一个微前端分组，将您的所有微前端项目纳入其中

3. Add the `@vercel/microfrontends` [package](https://npmjs.org/@vercel/microfrontends) to each microfrontend application

3. 在每个微前端应用中安装 `@vercel/microfrontends` [软件包](https://npmjs.org/@vercel/microfrontends)

4. Add a `microfrontends.json` configuration file to the default app, test in Preview, and deploy to Production when ready

4. 在主（默认）应用中添加 `microfrontends.json` 配置文件，在预览（Preview）环境中测试，确认无误后部署至生产环境（Production）

`microfrontends.json`  
`microfrontends.json`

```json
1{

2  "dashboard": {},

3  "docs": {

4    "routing": [{\
\
5      "paths": ["/docs", "/docs/:path*"]\
\
6    }]

7  }],

8  "marketing": {

9    "routing": [{\
\
10      "paths": ["/home", "/pricing"]\
\
11    }]

12  }

13}
```

微前端配置文件：将路由路径分发至三个不同的应用

Learn more about microfrontends in [our docs](https://vercel.com/docs/microfrontends), or [contact Vercel](https://vercel.com/contact/sales) or your account team directly for more information.

请在[我们的文档](https://vercel.com/docs/microfrontends)中了解有关微前端的更多信息，或直接[联系 Vercel](https://vercel.com/contact/sales) 或您的客户成功团队获取更多详情。