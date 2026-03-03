---
title: "SvelteKit now supported in @vercel/flags - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/sveltekit-now-supported-in-vercel-flags"
date: "2024-07-03"
scraped_at: "2026-03-02T09:43:15.019313719+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Jul 3, 2024

2024 年 7 月 3 日

Vercel 正将其[新近推出](https://vercel.com/changelog/declaring-feature-flags-in-code)的特性标志（feature flags）使用方式扩展至 SvelteKit，随 `@vercel/flags` v2.6.0 版本一同发布。

借助 `@vercel/flags/sveltekit`，您现在可在 SvelteKit 应用代码中实现特性标志，并在函数内调用它们。采用此模式可自动尊重 Vercel 工具栏（Vercel Toolbar）所设置的覆盖规则，并[与我们的开发者体验平台（Developer Experience Platform）深度集成](https://vercel.com/docs/workflow-collaboration/feature-flags/integrate-vercel-platform)，支持 Web Analytics（网页分析）和 Runtime Logs（运行时日志）等功能。

```tsx
import { flag } from '@vercel/flags/sveltekit'



export const showDashboard = flag<boolean>({

4  key: 'dashboard',

5  async decide () {

6    // your feature flag logic

7    return true
```

8  }

9})
```

Learn more about Vercel feature flags with SvelteKit [in our documentation](https://vercel.com/docs/workflow-collaboration/feature-flags/flags-pattern-sveltekit) and deploy your own [SvelteKit app with feature flags here](https://vercel.com/templates/svelte/toolbar-feature-flags-sveltekit).

有关 Vercel 与 SvelteKit 结合使用的功能标志（Feature Flags）的更多信息，请参阅[我们的文档](https://vercel.com/docs/workflow-collaboration/feature-flags/flags-pattern-sveltekit)，并在此处[部署您自己的支持功能标志的 SvelteKit 应用](https://vercel.com/templates/svelte/toolbar-feature-flags-sveltekit)。