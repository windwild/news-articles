---
title: "npm i flags - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/npm-i-flags"
date: "2025-02-20"
scraped_at: "2026-03-02T09:36:42.244906800+00:00"
language: "en"
translated: false
description: "The Flags SDK package has been renamed from @vercel/flags to flags, signaling our commitment to open source and great developer experiences."
---




Feb 20, 2025

![](images/npm-i-flags-vercel/img_001.jpg)![](images/npm-i-flags-vercel/img_002.jpg)

The [Flags SDK](https://flags-sdk.dev/)—our open source library for using feature flags in Next.js and SvelteKit applications—is now available under the new package name `flags`.

```tsx
import { flag } from 'flags/next';



export const exampleFlag = flag({

4  key: 'example-flag',

5  decide() {

6    // this flag will be on for 50% of visitors

7    return Math.random() > 0.5;

8  },

9});
```

The new name signals our commitment to open source and the independence of the package from any specific entity or platform. Our framework-first approach of the SDK aims to simplify usage, avoid client-side flag evaluation, and improve user experience by eliminating layout shifts.

We are working on adapters with partners like Statsig, Optimizely, and LaunchDarkly to ensure a seamless integration with the Flags SDK.

Until now, each provider established their own approach to using feature flags in frameworks like Next.js, which led to duplicate efforts across the industry and drift in implementations. Going forward, the Flags SDK will help all feature flag and experimentation providers benefit from its tight integration to frameworks, while retaining their unique capabilities.

If you are using `@vercel/flags`, make sure you are updating to version 3.1.1 and switch your imports and package.json to `flags`.

Learn more in our redesigned [documentation and examples](https://flags-sdk.dev/).