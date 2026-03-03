---
title: "PostHog joins the Vercel Marketplace - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/posthog-joins-the-vercel-marketplace"
date: "2026-02-10"
scraped_at: "2026-03-02T09:21:34.069245482+00:00"
language: "en-zh"
translated: true
description: "PostHog now integrates directly with Vercel to help teams manage feature rollouts and run experiments without redeploying code. This integration makes it easier for Vercel users to:"
---

Feb 10, 2026

2026 年 2 月 10 日

![](images/posthog-joins-the-vercel-marketplace-vercel/img_001.jpg)![](images/posthog-joins-the-vercel-marketplace-vercel/img_002.jpg)

[PostHog](https://vercel.com/marketplace/posthog) 现已作为功能开关（Feature Flags）、实验（Experimentation）与分析（Analytics）服务提供商，正式上线 [Vercel Marketplace](https://vercel.com/marketplace)。

借助此次集成，您现在可以：

- 使用 [Flags SDK](https://flags-sdk.dev/) 及其适配器 [@flags-sdk/posthog](https://flags-sdk.dev/providers/posthog) 在代码中声明功能开关；  
- 实时为特定用户或用户群组（cohorts）启用或禁用功能；  
- 基于百分比进行渐进式发布（percentage-based rollouts）；  
- 运行 A/B 测试，在全面发布前验证功能的实际影响。

该集成为基于 Vercel 构建应用的团队提供了更高信心的发布能力：您可在生产环境中直接测试、降低发布风险，并依托真实用户行为数据做出数据驱动型决策——所有这些均可无缝融入您现有的 Vercel 工作流中。

请创建一个 `flags.ts` 文件，其中包含一个 `identify` 函数和一个功能开关检查逻辑：

`flags.ts`

`flags.ts`

```typescript
import { postHogAdapter } from '@flags-sdk/posthog'

import { flag, dedupe } from 'flags/next'

import type { Identify } from 'flags'



export const identify = dedupe(async () => ({

6  distinctId: 'user_distinct_id'  // replace with real user ID

7})) satisfies Identify<{ distinctId: string }>



export const myFlag = flag({ 
```

```typescript
import { postHogAdapter } from '@flags-sdk/posthog'

import { flag, dedupe } from 'flags/next'

import type { Identify } from 'flags'



export const identify = dedupe(async () => ({

6  distinctId: 'user_distinct_id'  // 请替换为真实的用户 ID

7})) satisfies Identify<{ distinctId: string }>



export const myFlag = flag({ 
```

10  key: 'my-flag',

10  键：'my-flag',

11  adapter: postHogAdapter.isFeatureEnabled(),

11  适配器：postHogAdapter.isFeatureEnabled(),

12  identify,

12  identify（标识用户），

13})
```

```

Create a flags.ts file with a simple identify function and a function to check your flag

创建一个 `flags.ts` 文件，其中包含一个简单的 `identify` 函数以及一个用于检查功能标志（flag）的函数。

Check out the [PostHog template](https://vercel.com/templates/edge-middleware/posthog-with-flags-sdk-and-next-js) to learn more about this integration.

请查看 [PostHog 模板](https://vercel.com/templates/edge-middleware/posthog-with-flags-sdk-and-next-js)，深入了解该集成方案。