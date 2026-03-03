---
title: "Skew Protection now supports prebuilt deployments - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/skew-protection-now-supports-prebuilt-deployments"
date: "2026-01-28"
scraped_at: "2026-03-02T10:47:53.499510021+00:00"
language: "en"
translated: false
description: "Next.js now supports a custom deploymentId in next.config.js, enabling Skew Protection for vercel deploy --prebuilt workflows. Set your own deployment ID using a git SHA or timestamp to maintain versi..."
---




Jan 28, 2026

Skew Protection can now be used with `vercel deploy --prebuilt` deployments.

For teams building locally and uploading with `--prebuilt`, you can now set a custom `deploymentId` in your `next.config.js`:

next.config.js

```javascript
module.exports = {

2  deploymentId: process.env.GIT_SHA || 'my-deployment-id',

3}
```

This ID is written to `routes-manifest.json` and used by Vercel for skew protection routing. You control the ID lifecycle, using the same ID across multiple prebuilt deployments or updating it when deploying new versions.

This feature enables Skew Protection support for the specific workflow of building applications locally and then uploading them to Vercel.

Learn more about [Skew Protection](https://vercel.com/docs/skew-protection).