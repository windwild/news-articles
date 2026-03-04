---
render_with_liquid: false
title: "Flags SDK 3.0 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/flags-sdk-3-0"
date: "2025-01-16"
scraped_at: "2026-03-02T09:38:05.285508549+00:00"
language: "en-zh"
translated: true
description: "The Flags SDK has been updated to version 3.0 and open sourced. Check out the new standalone Flags SDK documentation with updated examples to learn more."
---
render_with_liquid: false
render_with_liquid: false

Jan 16, 2025

2025 年 1 月 16 日

The [Flags SDK](https://flags-sdk.dev/) is a library that gives developers tools to use feature flags in Next.js and SvelteKit applications.

[Flags SDK](https://flags-sdk.dev/) 是一个为开发者提供工具的库，用于在 Next.js 和 SvelteKit 应用中使用功能开关（feature flags）。

The Flags SDK version 3.0 adds:

Flags SDK 3.0 版本新增以下特性：

- Pages Router support so feature flags can be used in App Router and Pages Router

- 对 Pages Router 的支持，使功能开关可在 App Router 和 Pages Router 中同时使用

- New adapters architecture that allows the SDK to integrate with various data sources and feature flag providers

- 全新的适配器（adapters）架构，使 SDK 能够与多种数据源及功能开关服务提供商集成

- A new `identify` concept that allows you to establish an evaluation context for your feature flags. With this addition, you can tailor flags and experiments for individual users or groups

- 全新的 `identify` 概念，使您能够为功能开关建立评估上下文。借助该功能，您可以针对单个用户或用户群体定制功能开关和实验

```tsx
import { flag } from 'flags/next';



export const exampleFlag = flag({

4  key: 'example-flag',
```

5  decide() {

5  decide() {

6    return false;

6    返回 false;

7  },

7  },

8});
```

8});
```

Importing and evaluating flags using the Flags SDK.

使用 Flags SDK 导入和评估功能标志。

With this release, [the repository](https://github.com/vercel/flags) is now open source and under the MIT License, providing more transparency and allowing for community contributions and integrations.

本次发布中，[该代码仓库](https://github.com/vercel/flags)现已开源，并采用 MIT 许可证，从而提升了透明度，并支持社区贡献与集成。

Check out the [new Flags SDK documentation](https://www.flags-sdk.dev/) with updated examples to learn more.

欢迎查阅 [全新的 Flags SDK 文档](https://www.flags-sdk.dev/)，其中包含更新的示例，帮助您进一步了解。