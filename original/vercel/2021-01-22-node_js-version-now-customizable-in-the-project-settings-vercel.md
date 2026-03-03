---
title: "Node.js Version now customizable in the Project Settings - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/node-js-version-now-customizable-in-the-project-settings"
date: "2021-01-22"
scraped_at: "2026-03-02T10:05:50.479682372+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jan 22, 2021

![](images/node_js-version-now-customizable-in-the-project-settings-vercel/img_001.jpg)

For easy customization and in preparation for [Node.js 14 LTS](https://github.com/nodejs/node/blob/master/doc/changelogs/CHANGELOG_V14.md) landing in the future, the **General page** in the **Project Settings** now contains a section for defining the Node.js version used in the Build Step and Serverless Functions.

Previously, defining an `engines` property in the `package.json` file was required to customize the Node.js version. However, this property will take precedence over the Project Setting.

Check out [the documentation](https://vercel.com/docs/runtimes#official-runtimes/node-js/node-js-version) as well.