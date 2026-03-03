---
title: "Deploy Hono backends with zero configuration - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/deploy-hono-backends-with-zero-configuration"
date: "2025-08-01"
scraped_at: "2026-03-02T09:30:46.285011718+00:00"
language: "en"
translated: false
description: "Vercel now detects and deploys Hono, a fast, lightweight web application framework built on web standards, with zero configuration."
---




Aug 1, 2025

![](images/deploy-hono-backends-with-zero-configuration-vercel/img_001.jpg)![](images/deploy-hono-backends-with-zero-configuration-vercel/img_002.jpg)

Vercel now natively supports [Hono](https://hono.dev/), a fast, lightweight backend framework built on web standards, with zero-configuration.

index.ts

```javascript
import { Hono } from 'hono'



const app = new Hono()



app.get('/', (c) => {

6  return c.text("Hello Hono!"))

7})



export default app
```

A "Hello world" Hono backend on Vercel

With the code above, use [Vercel CLI](https://vercel.com/docs/cli) to develop and deploy your Hono application:

Terminal

```bash
1# Develop the application locally

vc dev



4# Create a deployment

vc deploy
```

Using Vercel CLI to develop and deploy a Hono appliation

With this improved integration, Vercel's framework-defined infrastructure now recognizes and deeply understands Hono applications, ensuring they benefit from optimizations made from builds, deployments, and application delivery.

Now, new Hono applications deployed to Vercel benefit from [Fluid compute](https://vercel.com/docs/fluid-compute), with Active CPU pricing, automatic cold start optimizations, background processing, and much more.

[Deploy Hono on Vercel](https://vercel.com/new/clone?demo-description=Deploying%20an%20API%20on%20Vercel%20with%20Hono.&demo-image=%2F%2Fimages.ctfassets.net%2Fe5382hct74si%2FCYbcj30ZJhtGhg8JnR2Jm%2Fc2d3920a1878f356401b50593c1bc647%2FGeist_OG_Light.avif&demo-title=Hono%20on%20Vercel&demo-url=https%3A%2F%2Fhono.vercel.dev&from=templates&project-name=Hono%20on%20Vercel&repository-name=hono-on-vercel&repository-url=https%3A%2F%2Fgithub.com%2Fvercel%2Fexamples%2Ftree%2Fmain%2Fframework-boilerplates%2Fhono&skippable-integrations=1) or [visit Hono's Vercel documentation](https://vercel.com/docs/frameworks/backend/hono).