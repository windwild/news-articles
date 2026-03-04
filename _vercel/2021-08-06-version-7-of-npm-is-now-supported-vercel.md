---
title: "Version 7 of npm is now supported - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/version-7-of-npm-is-now-supported"
date: "2021-08-06"
scraped_at: "2026-03-02T10:04:13.049318913+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
{% raw %}

Aug 6, 2021

2021年8月6日

![](images/version-7-of-npm-is-now-supported-vercel/img_001.jpg)

Vercel 现在将根据项目依赖是否使用 npm CLI v7 添加（通过检测是否存在[最新版 lockfile 格式](https://docs.npmjs.com/cli/v7/configuring-npm/package-lock-json#lockfileversion)）自动识别项目所用的 npm 版本。

若检测到项目使用了 npm v7，Vercel 将在[构建步骤（Build Step）](https://vercel.com/docs/build-step)中自动切换至 npm v7 来安装项目的依赖。

这意味着，除 npm 最新版本中包含的众多错误修复外，您的部署现在还可利用以下新特性：

- [工作区（Workspaces）](https://github.com/npm/rfcs/blob/latest/implemented/0026-workspaces.md)

- [自动安装对等依赖（Automatically installing peer dependencies）](https://github.com/npm/rfcs/blob/latest/implemented/0025-install-peer-deps.md)

- [package-lock v2 及对 yarn.lock 的支持](https://blog.npmjs.org/post/621733939456933888/npm-v7-series-why-keep-package-lockjson)

您也可查阅 [完整发布说明（full release notes）](https://github.blog/2020-10-13-presenting-v7-0-0-of-the-npm-cli/) 和 [相关文档（documentation）](https://vercel.com/docs/build-step#install-command)。
{% endraw %}
