---
title: "Vercel Flags is now in public beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-flags-is-now-in-public-beta"
date: "2026-02-11"
scraped_at: "2026-03-02T09:21:33.446482974+00:00"
language: "en"
translated: false
description: "Create and manage feature flags in the Vercel Dashboard with targeting rules, user segments, and environment controls. Works seamlessly with the Flags SDK for Next.js and Svelte."
---




Feb 11, 2026

![](images/vercel-flags-is-now-in-public-beta-vercel/img_001.jpg)![](images/vercel-flags-is-now-in-public-beta-vercel/img_002.jpg)

[Vercel Flags](https://vercel.com/docs/flags/vercel-flags) is a feature flag provider built into the Vercel platform. It lets you create and manage feature flags with targeting rules, user segments, and environment controls directly in the Vercel Dashboard.

The Flags SDK provides a framework-native way to define and use these flags within Next.js and SvelteKit applications, integrating directly with your existing codebase:

flags.ts

```typescript
import { vercelAdapter } from "@flags-sdk/vercel"

import { flag } from 'flags/next';



export const showNewFeature = flag({

5    key: 'show-new-feature',

6    decide: () => false,

7    description: 'Show the new dashboard redesign',

8    adapter: vercelAdapter()

9});
```

And you can use them within your pages like:

app/page.tsx

```tsx
import { showNewFeature } from '~/flags';



export default async function Page() {

4    const isEnabled = await showNewFeature();



6    return isEnabled ? <NewDashboard /> : <OldDashboard />

7;}
```

For teams using other frameworks or custom backends, the Vercel Flags adapter supports the [OpenFeature](https://vercel.com/docs/flags/vercel-flags/sdks/openfeature) standard, allowing you to combine feature flags across various systems and maintain consistency in your flag management approach:

app.ts

```typescript
import { OpenFeature } from '@openfeature/server-sdk';

import { VercelProvider } from '@vercel/flags-core/openfeature';



4// Set up the provider and client

await OpenFeature.setProviderAndWait(new VercelProvider());

const client = OpenFeature.getClient();



8// Evaluate flags

const enabled = await client.getBooleanValue('show-new-feature');
```

Vercel Flags is priced at $30 per 1 million [flag requests](https://vercel.com/docs/flags/vercel-flags/limits-and-pricing#flag-requests) ($0.00003 per event), where a flag request is any request to your application that reads the underlying flags configuration. A single request evaluating multiple feature flags of the same source project still counts as one flag request.

Vercel Flags is now in beta and available to teams on all plans.

[Learn more about Vercel Flags](https://vercel.com/docs/flags/vercel-flags) to get started with feature flag management.