---
title: "View and override feature flags from the Vercel Toolbar - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/view-and-override-feature-flags-from-the-vercel-toolbar"
date: "2024-03-06"
scraped_at: "2026-03-02T09:47:03.154651019+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Mar 6, 2024

![](images/view-and-override-feature-flags-from-the-vercel-toolbar-vercel/img_001.jpg)![](images/view-and-override-feature-flags-from-the-vercel-toolbar-vercel/img_002.jpg)

You can now view and [override your application's feature flags](https://vercel.com/blog/toolbar-feature-flags) from the Vercel Toolbar.

This means you can override flags provided by LaunchDarkly, Optimizely, Statsig, Hypertune, Split, or your custom setup without leaving your Vercel environment.

Vercel can now query an API Route defined in your application to find out about your feature flags, and will pick up their values by scanning the DOM for script tags. From there you can create overrides from the Vercel Toolbar, per session, for shorter feedback loops and improved QA and testing. Additionally, the overrides will be stored in an optionally encrypted cookie so your application can respect them.

This functionality is currently in beta and available to users on all plans.

[Check out the documentation](https://vercel.com/docs/workflow-collaboration/feature-flags) to learn more.

If you're a feature flag provider and interested in integrating with the Vercel Toolbar, [contact us](https://vercel.com/help).