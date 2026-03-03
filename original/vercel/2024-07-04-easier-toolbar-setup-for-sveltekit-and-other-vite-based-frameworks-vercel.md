---
title: "Easier toolbar setup for SvelteKit and other Vite-based frameworks - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/easier-toolbar-setup-for-sveltekit-and-other-vite-based-frameworks"
date: "2024-07-04"
scraped_at: "2026-03-02T09:43:04.074479275+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jul 4, 2024

Vite-based frameworks such as SvelteKit, Remix, Nuxt, or Astro can now more easily integrate with the Vercel Toolbar in both [local](https://vercel.com/docs/workflow-collaboration/vercel-toolbar/in-production-and-localhost/add-to-localhost) and [production](https://vercel.com/docs/workflow-collaboration/vercel-toolbar/in-production-and-localhost/add-to-production) environments. The Toolbar enables you to comment on deployments, toggle feature flags, view draft content from a CMS, [and more](https://vercel.com/docs/workflow-collaboration/vercel-toolbar#vercel-toolbar-features).

The updated `@vercel/toolbar` package offers a Vite plugin and client-side function for injection and configuration, and can be integrated like this:

vite.config.js

```javascript
import { vercelToolbar } from '@vercel/toolbar/plugins/vite';

import { defineConfig } from 'vite';



export default defineConfig({

5  plugins: [/* others...*/ vercelToolbar()]

6  // ...

7});
```

```javascript
1// in your framework's client entry point:

import { mountVercelToolbar } from '@vercel/toolbar/vite';



mountVercelToolbar();
```

[Check out the documentation](https://vercel.com/docs/workflow-collaboration/vercel-toolbar/in-production-and-localhost/add-to-localhost) to learn more.