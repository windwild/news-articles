---
title: "Intelligent ignored builds using Turborepo - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/intelligent-ignored-builds-using-turborepo"
date: "2022-08-26"
scraped_at: "2026-03-02T10:00:50.253553141+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Aug 26, 2022

![Intelligent ignored builds using Turborepo](images/intelligent-ignored-builds-using-turborepo-vercel/img_001.jpg)![Intelligent ignored builds using Turborepo](images/intelligent-ignored-builds-using-turborepo-vercel/img_002.jpg)

When deployed on Vercel, [Turborepo](https://turborepo.org/) now supports only building affected projects via the new [`turbo-ignore`](https://www.npmjs.com/package/turbo-ignore) npm package, saving time and helping teams stay productive.

[`turbo-ignore`](https://www.npmjs.com/package/turbo-ignore) leverages the Turborepo dependency graph to automatically determine if each app, or one of its dependencies has changed and needs to be deployed.

Try it now by setting `npx turbo-ignore` as the [Ignored Build Step](https://vercel.com/docs/concepts/projects/overview#ignored-build-step) for each project within your monorepo.

[Check out the documentation](https://vercel.com/docs/concepts/monorepos/turborepo#step-4:-setup-the-ignored-build-step) to learn more.