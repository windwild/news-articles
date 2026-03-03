---
title: "New build and deploy capabilities in Vercel CLI - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/new-build-and-deploy-capabilities-in-vercel-cli"
date: "2022-07-21"
scraped_at: "2026-03-02T10:01:15.582617639+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jul 21, 2022

![](images/new-build-and-deploy-capabilities-in-vercel-cli-vercel/img_001.jpg)![](images/new-build-and-deploy-capabilities-in-vercel-cli-vercel/img_002.jpg)

Vercel’s [Build Output API](https://vercel.com/docs/build-output-api/v3) is now generally available. This API allows any framework, including your own custom-built solution, to take advantage of Vercel’s infrastructure building blocks including Edge Middleware, Edge Functions, Incremental Static Regeneration, Image Optimization, and more.

This specification also allows us to introduce two new commands to Vercel CLI:

- `vercel build`: Build a project locally or in your own CI environment

- `vercel deploy --prebuilt`: Deploy a build output directly to Vercel without sending source code through Vercel's build system


Read more about the [Build Output API announcement](https://vercel.com/blog/build-output-api) on the blog. For framework authors, explore the [Build Output API examples](https://github.com/vercel/examples/tree/main/build-output-api).