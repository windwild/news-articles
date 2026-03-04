---
title: "Flags SDK now supports OpenFeature - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/flags-sdk-now-supports-openfeature"
date: "2025-03-21"
scraped_at: "2026-03-02T09:35:16.587396053+00:00"
language: "en-zh"
translated: true
description: "The newly released @flags-sdk/openfeature Flags SDK adapter for OpenFeature allows using any Node.js OpenFeature provider with the Flags SDK. "
---
&#123;% raw %}

Mar 21, 2025

2025 年 3 月 21 日

![](images/flags-sdk-now-supports-openfeature-vercel/img_001.jpg)![](images/flags-sdk-now-supports-openfeature-vercel/img_002.jpg)

![](images/flags-sdk-now-supports-openfeature-vercel/img_001.jpg)![](images/flags-sdk-now-supports-openfeature-vercel/img_002.jpg)

The [Flags SDK adapter for OpenFeature](https://flags-sdk.dev/providers/openfeature) allows using any Node.js OpenFeature provider with the Flags SDK. Pick from a wide range of flag providers, while benefiting from the Flag SDK's tight integration into Next.js and SvelteKit.

[OpenFeature 适配器（Flags SDK）](https://flags-sdk.dev/providers/openfeature) 允许将任意 Node.js 版 OpenFeature Provider 与 Flags SDK 配合使用。您可从丰富的功能开关（flag）提供商中自由选择，同时享受 Flags SDK 与 Next.js 和 SvelteKit 的深度集成优势。

flags.ts

```tsx
import { createOpenFeatureAdapter } from "@flags-sdk/openfeature";

import type { EvaluationContext } from "@openfeature/server-sdk";



OpenFeature.setProvider(new YourProviderOfChoice());

const openFeatureAdapter = createOpenFeatureAdapter(OpenFeature.getClient());
```

```tsx
import { createOpenFeatureAdapter } from "@flags-sdk/openfeature";

import type { EvaluationContext } from "@openfeature/server-sdk";



OpenFeature.setProvider(new YourProviderOfChoice());

const openFeatureAdapter = createOpenFeatureAdapter(OpenFeature.getClient());
```

```ts
export const exampleFlag = flag<boolean, EvaluationContext>({

8  key: "example-flag",

9  adapter: openFeatureAdapter.booleanValue(),

10});
```

```ts
export const exampleFlag = flag<boolean, EvaluationContext>({

8  key: "example-flag",

9  adapter: openFeatureAdapter.booleanValue(),

10});
```

Declare a feature flag using the Flags SDK and OpenFeature adapter

使用 Flags SDK 和 OpenFeature 适配器声明一个功能开关（feature flag）

[OpenFeature](https://openfeature.dev/) is an open specification that provides a vendor-agnostic, community-driven API for feature flagging that works with your favorite feature flag management tool or in-house solution. OpenFeature exposes various providers through a unified API.

[OpenFeature](https://openfeature.dev/) 是一项开放规范，提供与供应商无关、由社区驱动的功能开关（feature flagging）API，可与您偏爱的功能开关管理工具或自建解决方案无缝集成。OpenFeature 通过统一的 API 暴露多种提供商（providers）。

The [Flags SDK](https://flags-sdk.dev/) sits between your application and the source of your flags, helping you follow best practices and keep your website fast. Use the Flags SDK OpenFeature adapter in your application to load feature flags from all compatible Node.js OpenFeature providers, including:

[Flags SDK](https://flags-sdk.dev/) 位于您的应用程序与功能开关数据源之间，帮助您遵循最佳实践，并确保网站保持高性能。在您的应用中使用 Flags SDK 的 OpenFeature 适配器，即可从所有兼容的 Node.js OpenFeature 提供商加载功能开关，包括：

- AB Tasty

- AB Tasty

- Bucket

- Bucket

- Cloudbees

- Cloudbees

- Confidence by Spotify  
- Spotify Confidence  

- ConfigCat  
- ConfigCat  

- DevCycle  
- DevCycle  

- Environment Variables Provider  
- 环境变量提供程序  

- FeatBit  
- FeatBit  

- flagd  
- flagd  

- Flipt  
- Flipt  

- GO Feature Flag  
- GO Feature Flag  

- GrowthBook  
- GrowthBook  

- Hypertune  
- Hypertune

- Kameleoon  
- Kameleoon  

- LaunchDarkly  
- LaunchDarkly  

- PostHog  
- PostHog  

- Split  
- Split  

View the [OpenFeature adapter](https://flags-sdk.dev/providers/openfeature) or [clone the template](https://vercel.com/templates/next.js/flags-sdk-openfeature) to get started.  
请查看 [OpenFeature 适配器](https://flags-sdk.dev/providers/openfeature)，或 [克隆该模板](https://vercel.com/templates/next.js/flags-sdk-openfeature) 以快速开始。
&#123;% endraw %}
