---
title: "Flags SDK now supports OpenFeature - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/flags-sdk-now-supports-openfeature"
date: "2025-03-21"
scraped_at: "2026-03-02T09:35:16.587396053+00:00"
language: "en"
translated: false
description: "The newly released @flags-sdk/openfeature Flags SDK adapter for OpenFeature allows using any Node.js OpenFeature provider with the Flags SDK. "
---




Mar 21, 2025

![](images/flags-sdk-now-supports-openfeature-vercel/img_001.jpg)![](images/flags-sdk-now-supports-openfeature-vercel/img_002.jpg)

The [Flags SDK adapter for OpenFeature](https://flags-sdk.dev/providers/openfeature) allows using any Node.js OpenFeature provider with the Flags SDK. Pick from a wide range of flag providers, while benefiting from the Flag SDK's tight integration into Next.js and SvelteKit.

flags.ts

```tsx
import { createOpenFeatureAdapter } from "@flags-sdk/openfeature";

import type { EvaluationContext } from "@openfeature/server-sdk";



OpenFeature.setProvider(new YourProviderOfChoice());

const openFeatureAdapter = createOpenFeatureAdapter(OpenFeature.getClient());



export const exampleFlag = flag<boolean, EvaluationContext>({

8  key: "example-flag",

9  adapter: openFeatureAdapter.booleanValue(),

10});
```

Declare a feature flag using the Flags SDK and OpenFeature adapter

[OpenFeature](https://openfeature.dev/) is an open specification that provides a vendor-agnostic, community-driven API for feature flagging that works with your favorite feature flag management tool or in-house solution. OpenFeature exposes various providers through a unified API.

The [Flags SDK](https://flags-sdk.dev/) sits between your application and the source of your flags, helping you follow best practices and keep your website fast. Use the Flags SDK OpenFeature adapter in your application to load feature flags from all compatible Node.js OpenFeature providers, including:

- AB Tasty

- Bucket

- Cloudbees

- Confidence by Spotify

- ConfigCat

- DevCycle

- Environment Variables Provider

- FeatBit

- flagd

- Flipt

- GO Feature Flag

- GrowthBook

- Hypertune

- Kameleoon

- LaunchDarkly

- PostHog

- Split


View the [OpenFeature adapter](https://flags-sdk.dev/providers/openfeature) or [clone the template](https://vercel.com/templates/next.js/flags-sdk-openfeature) to get started.