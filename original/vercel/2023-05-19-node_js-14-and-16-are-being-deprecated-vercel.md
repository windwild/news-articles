---
title: "Node.js 14 and 16 are being deprecated - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/node-js-14-and-16-are-being-deprecated"
date: "2023-05-19"
scraped_at: "2026-03-02T09:52:27.276949299+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




May 19, 2023

![](images/node_js-14-and-16-are-being-deprecated-vercel/img_001.jpg)![](images/node_js-14-and-16-are-being-deprecated-vercel/img_002.jpg)

Vercel is announcing the deprecation of Node.js 14 and 16, which will be discontinued on **August 15th 2023** and **January 31 2025** respectively. Node.js 14 reached [official end of life](https://github.com/nodejs/Release#end-of-life-releases) on April 30th 2023. Node.js 16 reached [official end of life](https://nodejs.org/en/blog/announcements/nodejs16-eol) on September 11, 2023.

**On** **August 15th 2023**, Node.js 14 will be disabled in the Project Settings and existing Projects that have Node.js 14 selected will render an error whenever a new Deployment is created. The same error will show if the Node.js version was configured in the source code.

**On January 31 2025**, Node.js 16 will be disabled in the Project Settings and existing Projects that have Node.js 16 selected will render an error whenever a new Deployment is created. The same error will show if the Node.js version was configured in the source code.

While existing Deployments with Serverless Functions will not be affected, Vercel strongly encourages upgrading to [Node.js 18](https://vercel.com/changelog/node-js-18-lts-is-now-available) or [Node.js 20](https://vercel.com/changelog/node-js-v20-lts-is-now-generally-available) to ensure you receive security updates (using either `engines` in `package.json` or the [General page in the Project Settings](https://vercel.com/docs/concepts/projects/overview#general-settings)).

[Check out the documentation](https://vercel.com/docs/concepts/functions/serverless-functions/runtimes/node-js) as well.