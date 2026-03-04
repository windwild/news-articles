---
title: "Node.js Version now customizable in the Project Settings - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/node-js-version-now-customizable-in-the-project-settings"
date: "2021-01-22"
scraped_at: "2026-03-02T10:05:50.479682372+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
&#123;% raw %}

Jan 22, 2021

2021 年 1 月 22 日

![](images/node_js-version-now-customizable-in-the-project-settings-vercel/img_001.jpg)

为便于自定义，并为未来 [Node.js 14 LTS](https://github.com/nodejs/node/blob/master/doc/changelogs/CHANGELOG_V14.md) 的正式发布做好准备，**项目设置（Project Settings）** 中的 **“常规（General）”页面** 现已新增一个配置项，用于指定构建步骤（Build Step）和无服务器函数（Serverless Functions）所使用的 Node.js 版本。

此前，若需自定义 Node.js 版本，必须在 `package.json` 文件中定义 `engines` 属性。但请注意：该属性的设置将优先于项目设置中的配置。

也可参阅[相关文档](https://vercel.com/docs/runtimes#official-runtimes/node-js/node-js-version)。
&#123;% endraw %}
