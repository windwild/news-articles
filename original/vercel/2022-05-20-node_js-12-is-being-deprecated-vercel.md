---
title: "Node.js 12 is being deprecated - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/node-js-12-is-being-deprecated"
date: "2022-05-20"
scraped_at: "2026-03-02T10:02:03.728281970+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




May 20, 2022

![](images/node_js-12-is-being-deprecated-vercel/img_001.jpg)![](images/node_js-12-is-being-deprecated-vercel/img_002.jpg)

Following the [release of Node.js 16](https://vercel.com/changelog/node-js-16-lts-is-now-available) last week, Vercel is announcing the deprecation of Node.js 12, which reached its [official end of life](https://nodejs.org/en/blog/release/v12.22.12/) on April 30th 2022.

On **October 3rd 2022**, Node.js 12 will be disabled in the Project Settings and existing Projects that have Node.js 12 selected will render an error whenever a new Deployment is created. The same error will show if the Node.js version was configured in the source code.

While existing Deployments with Serverless Functions using the Node.js 12 runtime will not be affected, we strongly encourage upgrading to Node.js 16 to ensure you receive security updates (using either `engines` in `package.json` or the General page in the Project Settings).

Check out [the documentation](https://vercel.com/docs/runtimes#official-runtimes/node-js/node-js-version) as well.