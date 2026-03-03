---
title: "SvelteKit now supported in @vercel/flags - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/sveltekit-now-supported-in-vercel-flags"
date: "2024-07-03"
scraped_at: "2026-03-02T09:43:15.019313719+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jul 3, 2024

Vercel is extending its [newly introduced](https://vercel.com/changelog/declaring-feature-flags-in-code) approach to working with feature flags to SvelteKit, with the v2.6.0 release of `@vercel/flags`.

With `@vercel/flags/sveltekit` you can now implement feature flags in your SvelteKit application code and call them within functions. Using this pattern automatically respects overrides set by the Vercel Toolbar, and [integrates with our Developer Experience Platform](https://vercel.com/docs/workflow-collaboration/feature-flags/integrate-vercel-platform) features like Web Analytics and Runtime Logs.

```tsx
import { flag } from '@vercel/flags/sveltekit'



export const showDashboard = flag<boolean>({

4  key: 'dashboard',

5  async decide () {

6    // your feature flag logic

7    return true

8  }

9})
```

Learn more about Vercel feature flags with SvelteKit [in our documentation](https://vercel.com/docs/workflow-collaboration/feature-flags/flags-pattern-sveltekit) and deploy your own [SvelteKit app with feature flags here](https://vercel.com/templates/svelte/toolbar-feature-flags-sveltekit).