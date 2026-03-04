---
title: "Declaring feature flags in code - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/declaring-feature-flags-in-code"
date: "2024-05-23"
scraped_at: "2026-03-02T09:44:41.065864232+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
{% raw %}

May 23, 2024

2024 年 5 月 23 日

We’re introducing a new approach for working with feature flags. This approach allows declaring feature flags in code and calling them as functions. Flags implemented using this pattern can automatically respect overrides set by the Vercel Toolbar, and integrate with our Developer Experience Platform features like Web Analytics and Runtime Logs.

我们正在推出一种使用功能开关（feature flags）的新方法。该方法支持在代码中声明功能开关，并将其作为函数调用。采用此模式实现的功能开关可自动遵循 Vercel 工具栏（Vercel Toolbar）所设置的覆盖规则，并与我们的开发者体验平台（Developer Experience Platform）功能（例如 Web Analytics 和 Runtime Logs）无缝集成。

```javascript
import { unstable_flag as flag } from "@vercel/flags/next"



const showSummerSale = flag({

4  key: "summer-sale",

5  decide: async () => false

6})
```

```javascript
import { unstable_flag as flag } from "@vercel/flags/next"



const showSummerSale = flag({

4  key: "summer-sale",

5  decide: async () => false

6})
```

Declaring a feature flag

声明一个功能开关

The pattern avoids common pitfalls of client-side feature flag and experimentation usage, such as flashing the wrong experiment, loading spinners, layout shift, and jank. It works with any feature flag provider and even custom setups.

该模式可避免客户端功能开关及实验功能使用中的常见问题，例如错误实验内容的闪现（flashing）、加载旋转指示器（spinners）、布局偏移（layout shift）以及界面卡顿（jank）。它兼容任意功能开关服务提供商，甚至支持自定义配置。

```javascript
export const showSummerSale = flag<boolean>({

2     key: 'summer-sale',

3      async decide() {

4           return getLaunchDarklyClient().variation(this.key, false);

5      },

6});
```

```javascript
export const showSummerSale = flag<boolean>({

2     key: 'summer-sale',

3      async decide() {

4           return getLaunchDarklyClient().variation(this.key, false);

5      },

6});
```

使用特性标志（Feature Flag）

该模式进一步支持在中间件（Middleware）中选择性地预计算某些特性标志。随后，中间件即可将访问者路由至为其特定特性标志与实验组合量身定制的静态生成页面。

即使页面上同时存在多个特性标志（此类场景通常会引发组合爆炸问题），该方案依然有效。对营销页面而言，预计算尤为适合开展 A/B 实验：它能确保页面完全静态化，实现超低的首字节时间（TTFB）、零布局偏移（no layout shift）以及零错误实验内容闪现（no flashing of the wrong experiment）。

我们已在 `@vercel/flags/next` 中为 Next.js 实现了这一新型特性标志设计模式；同时，面向 SvelteKit 的实现也即将发布。

[Check out our documentation](https://vercel.com/docs/workflow-collaboration/feature-flags/flags-pattern-nextjs) to learn more.

请参阅我们的[文档](https://vercel.com/docs/workflow-collaboration/feature-flags/flags-pattern-nextjs)以了解更多信息。
{% endraw %}
