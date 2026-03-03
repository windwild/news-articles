---
title: "Node.js 10 is being deprecated - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/node-js-10-is-being-deprecated"
date: "2021-02-09"
scraped_at: "2026-03-02T10:05:42.676851256+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Feb 9, 2021

![](images/node_js-10-is-being-deprecated-vercel/img_001.jpg)

Following the [release of Node.js 14](https://vercel.com/changelog/node-js-14-lts-is-now-available) last week, Vercel is announcing the deprecation of Node.js 10, which reaches its [offical end of life](https://nodejs.org/en/about/releases/) on April 30th 2021.

On **April 20th 2021**, Node.js 10 will be disabled in the Project Settings and existing Projects that have Node.js 10 selected will render an error whenever a new Deployment is created. The same error will show if the Node.js version was configured in the source code.

Serverless Functions of existing Deployments that are using Node.js 10 will be migrated to Node.js 12 on the date mentioned above.

If your Project is using Node.js 10 (which you've either defined in `engines` in `package.json` or on the General page in the Project Settings), we recommend upgrading it to the latest version (Node.js 14).

Need help migrating to Node.js 14? [Let us know](https://vercel.com/support) and we'll help you out.