---
title: "Node.js 12 is being deprecated - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/node-js-12-is-being-deprecated"
date: "2022-05-20"
scraped_at: "2026-03-02T10:02:03.728281970+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
{% raw %}

May 20, 2022

2022 年 5 月 20 日

![](images/node_js-12-is-being-deprecated-vercel/img_001.jpg)![](images/node_js-12-is-being-deprecated-vercel/img_002.jpg)

![](images/node_js-12-is-being-deprecated-vercel/img_001.jpg)![](images/node_js-12-is-being-deprecated-vercel/img_002.jpg)

Following the [release of Node.js 16](https://vercel.com/changelog/node-js-16-lts-is-now-available) last week, Vercel is announcing the deprecation of Node.js 12, which reached its [official end of life](https://nodejs.org/en/blog/release/v12.22.12/) on April 30th 2022.

继上周发布 [Node.js 16](https://vercel.com/changelog/node-js-16-lts-is-now-available) 之后，Vercel 宣布将弃用 Node.js 12。Node.js 12 已于 2022 年 4 月 30 日正式结束生命周期（End of Life）。

On **October 3rd 2022**, Node.js 12 will be disabled in the Project Settings and existing Projects that have Node.js 12 selected will render an error whenever a new Deployment is created. The same error will show if the Node.js version was configured in the source code.

自 **2022 年 10 月 3 日**起，Node.js 12 将在项目设置（Project Settings）中被禁用；对于已选择 Node.js 12 的现有项目，每次创建新部署（Deployment）时均会报错。若在源代码中显式配置了 Node.js 版本，也将出现相同的错误提示。

While existing Deployments with Serverless Functions using the Node.js 12 runtime will not be affected, we strongly encourage upgrading to Node.js 16 to ensure you receive security updates (using either `engines` in `package.json` or the General page in the Project Settings).

尽管当前使用 Node.js 12 运行时的无服务器函数（Serverless Functions）所对应的已有部署不会受到影响，我们仍强烈建议您升级至 Node.js 16，以确保持续获得安全更新（可通过 `package.json` 中的 `engines` 字段，或项目设置中的“常规”（General）页面进行配置）。

Check out [the documentation](https://vercel.com/docs/runtimes#official-runtimes/node-js/node-js-version) as well.

也请参阅相关 [文档](https://vercel.com/docs/runtimes#official-runtimes/node-js/node-js-version)。
{% endraw %}
