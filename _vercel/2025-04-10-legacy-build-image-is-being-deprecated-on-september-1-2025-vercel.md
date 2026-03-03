---
title: "Legacy build image is being deprecated on September 1, 2025 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/legacy-build-image-is-being-deprecated"
date: "2025-04-10"
scraped_at: "2026-03-02T09:34:59.939017289+00:00"
language: "en-zh"
translated: true
description: "The legacy build image will be deprecated on September 1, 2025, alongside the deprecation of Node.js 18."
---

Apr 10, 2025

2025 年 4 月 10 日

Node.js 18（LTS 支持将于 2025 年 4 月 30 日结束）及 Vercel 旧版构建镜像将于 2025 年 9 月 1 日起停用。若您在此日期后仍在使用旧版构建镜像，新构建将显示错误。

**旧版构建镜像与最新版构建镜像之间有哪些变化？**

- Node.js 的最低支持版本现已升级为 20.x

- Python 工具链版本现已升级为 3.12

- Ruby 工具链版本现已升级为 3.3.x


**我如何判断自己是否仍在使用旧版构建镜像？**

- 在 [构建与部署设置](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fbuild-and-deployment&title=Project+Settings) 中使用 Node.js 18.x 的项目，将使用旧版构建镜像

- 在 `package.json` 中使用了 [版本覆盖配置](https://vercel.com/docs/functions/runtimes/node-js/node-js-versions#version-overrides-in-package.json) 的项目，将使用旧版构建镜像


**我现有的部署会受到影响吗？**

Existing deployments **will not be affected.** However, the Node.js version will need to be updated on your next deployment.

现有部署**不会受到影响。** 但您在下一次部署时需更新 Node.js 版本。

**How can I see if my projects are affected?**

**如何查看我的项目是否受影响？**

You can see which projects are affected by this deprecation by running the following commands:

您可通过运行以下命令，查看哪些项目受到此次弃用影响：

Terminal

```bash
npm i -g vercel@latest

vercel project ls --update-required
```

View projects that require updating.

查看需要更新的项目。

**How do I upgrade?**

**如何升级？**

To upgrade with the dashboard, [visit the Build and Deployment settings for your project](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fbuild-and-deployment%23node.js-version&title=Change+Node.js+Version) and upgrade the version.

如需通过控制台升级，请[访问您项目的“构建与部署”设置页面](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fbuild-and-deployment%23node.js-version&title=Change+Node.js+Version)，然后升级 Node.js 版本。

To upgrade with code, use the `engines` field in `package.json`:

如需通过代码升级，请在 `package.json` 文件中使用 `engines` 字段：

package.json

package.json

```json
1{

2  "engines": {

3    "node": "22.x"

4  }

5}
```

```json
1{

2  "engines": {

3    "node": "22.x"

4  }

5}
```

This date coincides with the [previously announced deprecation of Node.js 18](https://vercel.com/changelog/node-js-18-is-being-deprecated) on the Vercel platform. Learn more about [differences between build images](https://vercel.com/docs/builds/build-image/build-image).

此日期与 Vercel 平台此前宣布的 [Node.js 18 弃用计划](https://vercel.com/changelog/node-js-18-is-being-deprecated) 相吻合。了解更多关于 [构建镜像差异](https://vercel.com/docs/builds/build-image/build-image) 的信息。