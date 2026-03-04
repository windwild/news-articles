---
render_with_liquid: false
title: "Node.js 14 and 16 are being deprecated - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/node-js-14-and-16-are-being-deprecated"
date: "2023-05-19"
scraped_at: "2026-03-02T09:52:27.276949299+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

May 19, 2023

2023年5月19日

![](images/node_js-14-and-16-are-being-deprecated-vercel/img_001.jpg)![](images/node_js-14-and-16-are-being-deprecated-vercel/img_002.jpg)

Vercel is announcing the deprecation of Node.js 14 and 16, which will be discontinued on **August 15th 2023** and **January 31 2025** respectively. Node.js 14 reached [official end of life](https://github.com/nodejs/Release#end-of-life-releases) on April 30th 2023. Node.js 16 reached [official end of life](https://nodejs.org/en/blog/announcements/nodejs16-eol) on September 11, 2023.

Vercel 宣布将弃用 Node.js 14 和 Node.js 16，两者分别将于 **2023 年 8 月 15 日** 和 **2025 年 1 月 31 日** 停止支持。Node.js 14 已于 2023 年 4 月 30 日正式进入[生命周期终止（EOL）阶段](https://github.com/nodejs/Release#end-of-life-releases)；Node.js 16 则于 2023 年 9 月 11 日正式进入[生命周期终止（EOL）阶段](https://nodejs.org/en/blog/announcements/nodejs16-eol)。

**On** **August 15th 2023**, Node.js 14 will be disabled in the Project Settings and existing Projects that have Node.js 14 selected will render an error whenever a new Deployment is created. The same error will show if the Node.js version was configured in the source code.

**自 2023 年 8 月 15 日起**，Node.js 14 将在项目设置（Project Settings）中被禁用；所有已选择 Node.js 14 的现有项目，在创建新部署（Deployment）时将触发错误提示。若在源代码中通过配置指定了 Node.js 版本，也将出现相同错误。

**On January 31 2025**, Node.js 16 will be disabled in the Project Settings and existing Projects that have Node.js 16 selected will render an error whenever a new Deployment is created. The same error will show if the Node.js version was configured in the source code.

**自 2025 年 1 月 31 日起**，Node.js 16 将在项目设置（Project Settings）中被禁用；所有已选择 Node.js 16 的现有项目，在创建新部署（Deployment）时将触发错误提示。若在源代码中通过配置指定了 Node.js 版本，也将出现相同错误。

While existing Deployments with Serverless Functions will not be affected, Vercel strongly encourages upgrading to [Node.js 18](https://vercel.com/changelog/node-js-18-lts-is-now-available) or [Node.js 20](https://vercel.com/changelog/node-js-v20-lts-is-now-generally-available) to ensure you receive security updates (using either `engines` in `package.json` or the [General page in the Project Settings](https://vercel.com/docs/concepts/projects/overview#general-settings)).

尽管当前使用 Serverless Functions 的已有部署不会受到影响，Vercel 强烈建议您升级至 [Node.js 18](https://vercel.com/changelog/node-js-18-lts-is-now-available) 或 [Node.js 20](https://vercel.com/changelog/node-js-v20-lts-is-now-generally-available)，以确保持续获得安全更新（可通过 `package.json` 中的 `engines` 字段，或项目设置中的[“常规”页面](https://vercel.com/docs/concepts/projects/overview#general-settings)进行配置）。

[Check out the documentation](https://vercel.com/docs/concepts/functions/serverless-functions/runtimes/node-js) as well.

[请参阅相关文档](https://vercel.com/docs/concepts/functions/serverless-functions/runtimes/node-js)。