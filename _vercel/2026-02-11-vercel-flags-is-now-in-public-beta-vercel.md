---
title: "Vercel Flags is now in public beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-flags-is-now-in-public-beta"
date: "2026-02-11"
scraped_at: "2026-03-02T09:21:33.446482974+00:00"
language: "en-zh"
translated: true
description: "Create and manage feature flags in the Vercel Dashboard with targeting rules, user segments, and environment controls. Works seamlessly with the Flags SDK for Next.js and Svelte."
---
{% raw %}

Feb 11, 2026

2026 年 2 月 11 日

![](images/vercel-flags-is-now-in-public-beta-vercel/img_001.jpg)![](images/vercel-flags-is-now-in-public-beta-vercel/img_002.jpg)

[Vercel Flags](https://vercel.com/docs/flags/vercel-flags) 是集成于 Vercel 平台内的功能开关（Feature Flag）服务。它允许你在 Vercel 控制台中直接创建和管理功能开关，并支持目标规则（targeting rules）、用户分群（user segments）以及环境控制（environment controls）。

Flags SDK 提供了一种与框架原生兼容的方式，让你能在 Next.js 和 SvelteKit 应用中定义并使用这些开关，并与现有代码库无缝集成：

flags.ts

```typescript
import { vercelAdapter } from "@flags-sdk/vercel"

import { flag } from 'flags/next';



export const showNewFeature = flag({

5    key: 'show-new-feature',

6    decide: () => false,

6    决策函数：() => false，

7    description: 'Show the new dashboard redesign',

7    描述：'展示新设计的仪表板'，

8    adapter: vercelAdapter()

8    适配器：vercelAdapter()

9});
```

```
然后，你可以在页面中像这样使用它们：

app/page.tsx

```tsx
import { showNewFeature } from '~/flags';



export default async function Page() {

4    const isEnabled = await showNewFeature();

6    return isEnabled ? <NewDashboard /> : <OldDashboard />

6    如果已启用，则返回 `<NewDashboard />`，否则返回 `<OldDashboard />`

7;}
7;}

```

```

For teams using other frameworks or custom backends, the Vercel Flags adapter supports the [OpenFeature](https://vercel.com/docs/flags/vercel-flags/sdks/openfeature) standard, allowing you to combine feature flags across various systems and maintain consistency in your flag management approach:

对于使用其他框架或自定义后端的团队，Vercel Flags 适配器支持 [OpenFeature](https://vercel.com/docs/flags/vercel-flags/sdks/openfeature) 标准，使您能够跨多个系统整合功能标志，并在标志管理方法上保持一致性：

app.ts

app.ts

```typescript
import { OpenFeature } from '@openfeature/server-sdk';

import { VercelProvider } from '@vercel/flags-core/openfeature';



4// Set up the provider and client

4// 配置提供程序和客户端

await OpenFeature.setProviderAndWait(new VercelProvider());
await OpenFeature.setProviderAndWait(new VercelProvider());

```javascript
const client = OpenFeature.getClient();



8// Evaluate flags

const enabled = await client.getBooleanValue('show-new-feature');
```

Vercel Flags is priced at $30 per 1 million [flag requests](https://vercel.com/docs/flags/vercel-flags/limits-and-pricing#flag-requests) ($0.00003 per event), where a flag request is any request to your application that reads the underlying flags configuration. A single request evaluating multiple feature flags of the same source project still counts as one flag request.

Vercel Flags 的定价为每 100 万次[标志请求](https://vercel.com/docs/flags/vercel-flags/limits-and-pricing#flag-requests) 30 美元（即每次事件 0.00003 美元），其中一次“标志请求”指您的应用程序向底层标志配置发起的任意一次读取请求。即使单次请求中评估了同一源项目的多个功能标志，仍仅计为一次标志请求。

Vercel Flags is now in beta and available to teams on all plans.

Vercel Flags 目前处于 Beta 测试阶段，面向所有订阅计划的团队开放使用。

[Learn more about Vercel Flags](https://vercel.com/docs/flags/vercel-flags) to get started with feature flag management.

[了解更多关于 Vercel Flags 的信息](https://vercel.com/docs/flags/vercel-flags)，立即开始使用功能标志管理。
{% endraw %}
