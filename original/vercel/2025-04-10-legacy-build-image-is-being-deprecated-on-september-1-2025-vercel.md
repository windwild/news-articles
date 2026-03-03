---
title: "Legacy build image is being deprecated on September 1, 2025 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/legacy-build-image-is-being-deprecated"
date: "2025-04-10"
scraped_at: "2026-03-02T09:34:59.939017289+00:00"
language: "en"
translated: false
description: "The legacy build image will be deprecated on September 1, 2025, alongside the deprecation of Node.js 18."
---




Apr 10, 2025

Node.js 18 (LTS support ends April 30, 2025) and the Vercel legacy build image will be deprecated on September 1, 2025. If you are still using the legacy build image on this date, new builds will display an error.

**What changes between the legacy build image and latest build image?**

- The minimum version of Node.js is now 20.x

- The Python toolchain version is now 3.12

- The Ruby toolchain version is now 3.3.x


**How do I know if I am still using the legacy build image?**

- Projects using Node.js 18.x in [Build and Deployment Settings](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fbuild-and-deployment&title=Project+Settings) use the legacy build image

- Projects using [overrides in package.json](https://vercel.com/docs/functions/runtimes/node-js/node-js-versions#version-overrides-in-package.json) use the legacy build image


**Will my existing deployments be affected?**

Existing deployments **will not be affected.** However, the Node.js version will need to be updated on your next deployment.

**How can I see if my projects are affected?**

You can see which projects are affected by this deprecation by running the following commands:

Terminal

```bash
npm i -g vercel@latest

vercel project ls --update-required
```

View projects that require updating.

**How do I upgrade?**

To upgrade with the dashboard, [visit the Build and Deployment settings for your project](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fbuild-and-deployment%23node.js-version&title=Change+Node.js+Version) and upgrade the version.

To upgrade with code, use the `engines` field in `package.json`:

package.json

```json
1{

2  "engines": {

3    "node": "22.x"

4  }

5}
```

This date coincides with the [previously announced deprecation of Node.js 18](https://vercel.com/changelog/node-js-18-is-being-deprecated) on the Vercel platform. Learn more about [differences between build images](https://vercel.com/docs/builds/build-image/build-image).