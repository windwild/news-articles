---
title: "Improved support for Gatsby sites - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/improved-support-for-gatsby-sites"
date: "2023-01-23"
scraped_at: "2026-03-02T09:56:41.932284742+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jan 23, 2023

![](images/improved-support-for-gatsby-sites-vercel/img_001.jpg)![](images/improved-support-for-gatsby-sites-vercel/img_002.jpg)

Gatsby sites on Vercel can now take advantage of powerful new features, including:

- **Server-Side Rendering (SSR):** Render dynamic content, on-demand.

- **Deferred Static Generation (DSG):** Generate static pages in the background on new requests, using the same infrastructure as [Incremental Static Regeneration](https://vercel.com/docs/build-output-api/v3#vercel-primitives/prerender-functions).

- **Native API Routes:** Create functions inside the `api` directory to instantly scaffold new API Routes.


Gatsby `v4+` sites deployed to Vercel will automatically detect Gatsby usage and install the new `@vercel/gatsby-plugin-vercel-builder` plugin. Gatsby `v5` sites require [Node.js 18](https://vercel.com/changelog/node-js-18-lts-is-now-available), the current default version used for new Projects.

Get started using Gatsby with our [updated template](https://vercel.com/templates/gatsby/gatsbyjs-boilerplate).