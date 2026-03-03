---
title: "PostHog joins the Vercel Marketplace - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/posthog-joins-the-vercel-marketplace"
date: "2026-02-10"
scraped_at: "2026-03-02T09:21:34.069245482+00:00"
language: "en"
translated: false
description: "PostHog now integrates directly with Vercel to help teams manage feature rollouts and run experiments without redeploying code. This integration makes it easier for Vercel users to:"
---




Feb 10, 2026

![](images/posthog-joins-the-vercel-marketplace-vercel/img_001.jpg)![](images/posthog-joins-the-vercel-marketplace-vercel/img_002.jpg)

[PostHog](https://vercel.com/marketplace/posthog) is now available in the [Vercel Marketplace](https://vercel.com/marketplace) as a feature flags, experimentation and Analytics provider.

With this integration, you can now:

- Declare flags in code using [Flags SDK](https://flags-sdk.dev/) and the [@flags-sdk/posthog](https://flags-sdk.dev/providers/posthog) adapter

- Toggle features in real time for specific users or cohorts

- Roll out changes gradually using percentage-based rollouts

- Run A/B tests to validate impact before a full release


This integration helps teams building on Vercel ship with more confidence. You can test in production, reduce release risk, and make data-driven decisions based on real user behavior, all within your existing Vercel workflows.

Create a `flags.ts` file with an identify function and a flag check:

flags.ts

```typescript
import { postHogAdapter } from '@flags-sdk/posthog'

import { flag, dedupe } from 'flags/next'

import type { Identify } from 'flags'



export const identify = dedupe(async () => ({

6  distinctId: 'user_distinct_id'  // replace with real user ID

7})) satisfies Identify<{ distinctId: string }>



export const myFlag = flag({

10  key: 'my-flag',

11  adapter: postHogAdapter.isFeatureEnabled(),

12  identify,

13})
```

Create a flags.ts file with a simple identify function and a function to check your flag

Check out the [PostHog template](https://vercel.com/templates/edge-middleware/posthog-with-flags-sdk-and-next-js) to learn more about this integration.