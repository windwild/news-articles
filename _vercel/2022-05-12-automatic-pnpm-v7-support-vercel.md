---
title: "Automatic pnpm v7 Support - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/automatic-pnpm-v7-support"
date: "2022-05-12"
scraped_at: "2026-03-02T10:02:05.265294233+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
May 12, 2022

2022 年 5 月 12 日

![](images/automatic-pnpm-v7-support-vercel/img_001.jpg)![](images/automatic-pnpm-v7-support-vercel/img_002.jpg)

Vercel now supports pnpm v7. For deployments with a `pnpm-lock.yaml` file with `version: 5.4`, Vercel will automatically use pnpm v7 for install and build commands.

Vercel 现已支持 pnpm v7。对于包含 `version: 5.4` 的 `pnpm-lock.yaml` 文件的部署，Vercel 将自动在安装（install）和构建（build）命令中使用 pnpm v7。

To upgrade your project to pnpm v7, run `pnpm install -g pnpm@7` locally and then re-run `pnpm install.`After updating, create a new deployment!

要将项目升级至 pnpm v7，请先在本地运行 `pnpm install -g pnpm@7`，然后重新执行 `pnpm install`。升级完成后，请创建一次新的部署！

[Check out the documentation](https://vercel.com/docs/concepts/deployments/build-step#install-command) as well.

也请参阅[相关文档](https://vercel.com/docs/concepts/deployments/build-step#install-command)。