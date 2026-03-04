---
title: "npm i flags - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/npm-i-flags"
date: "2025-02-20"
scraped_at: "2026-03-02T09:36:42.244906800+00:00"
language: "en-zh"
translated: true
description: "The Flags SDK package has been renamed from @vercel/flags to flags, signaling our commitment to open source and great developer experiences."
---
&#123;% raw %}

Feb 20, 2025

2025 年 2 月 20 日

![](images/npm-i-flags-vercel/img_001.jpg)![](images/npm-i-flags-vercel/img_002.jpg)

The [Flags SDK](https://flags-sdk.dev/)—our open source library for using feature flags in Next.js and SvelteKit applications—is now available under the new package name `flags`.

[Flags SDK](https://flags-sdk.dev/)——我们开源的、专为 Next.js 和 SvelteKit 应用设计的特性开关（feature flag）库——现已以新包名 `flags` 发布。

```tsx
import { flag } from 'flags/next';



export const exampleFlag = flag({

4  key: 'example-flag',

5  decide() {

6    // this flag will be on for 50% of visitors

7    return Math.random() > 0.5;
```

```tsx
import { flag } from 'flags/next';



export const exampleFlag = flag({

4  key: 'example-flag',

5  decide() {

6    // 此开关将对 50% 的访问者启用

7    return Math.random() > 0.5;
```

8  },

9});
```

The new name signals our commitment to open source and the independence of the package from any specific entity or platform. Our framework-first approach of the SDK aims to simplify usage, avoid client-side flag evaluation, and improve user experience by eliminating layout shifts.

新名称彰显了我们对开源的承诺，以及该软件包在任何特定实体或平台之外的独立性。SDK 采用“以框架为先”的设计理念，旨在简化使用流程、避免客户端的特性标志（feature flag）求值，并通过消除布局偏移（layout shifts）来提升用户体验。

We are working on adapters with partners like Statsig, Optimizely, and LaunchDarkly to ensure a seamless integration with the Flags SDK.

我们正与 Statsig、Optimizely 和 LaunchDarkly 等合作伙伴共同开发适配器，以确保与 Flags SDK 的无缝集成。

Until now, each provider established their own approach to using feature flags in frameworks like Next.js, which led to duplicate efforts across the industry and drift in implementations. Going forward, the Flags SDK will help all feature flag and experimentation providers benefit from its tight integration to frameworks, while retaining their unique capabilities.

在此前，各家服务商各自为 Next.js 等框架设计了不同的特性标志使用方式，导致行业范围内重复造轮子，且各实现方案逐渐偏离统一标准。未来，Flags SDK 将助力所有特性标志与实验服务提供商，借助其与主流框架的深度集成获益，同时保留各自独特的功能优势。

If you are using `@vercel/flags`, make sure you are updating to version 3.1.1 and switch your imports and package.json to `flags`.

若您正在使用 `@vercel/flags`，请务必升级至 3.1.1 版本，并将代码中的导入语句及 `package.json` 中的依赖项更新为 `flags`。

Learn more in our redesigned [documentation and examples](https://flags-sdk.dev/).

欢迎访问我们全新设计的[文档与示例](https://flags-sdk.dev/)，了解更多信息。
&#123;% endraw %}
