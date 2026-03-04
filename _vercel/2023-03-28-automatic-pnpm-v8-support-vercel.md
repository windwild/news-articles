---
render_with_liquid: false
title: "Automatic pnpm v8 support - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/automatic-pnpm-v8-support"
date: "2023-03-28"
scraped_at: "2026-03-02T09:54:06.019605622+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Mar 28, 2023

2023年3月28日

![](https://vercel.com/vc-ap-vercel-marketing/_next/image?url=https%3A%2F%2Fassets.vercel.com%2Fimage%2Fupload%2Fcontentful%2Fimage%2Fe5382hct74si%2F2zG9t1ad1WB5ZhthNodkm5%2F41b43c1187a02d0620c1e34c06cf61f6%2Fpnpm-v7-22-05-12-LIGHT.png&w=1920&q=75)![](images/automatic-pnpm-v8-support-vercel/img_002.jpg)

Vercel now supports pnpm v8. For deployments with a `pnpm-lock.yaml` file with `lockfileVersion: '6.0',` Vercel will automatically use pnpm v8 for install and build commands.

Vercel 现已支持 pnpm v8。对于包含 `lockfileVersion: '6.0'` 的 `pnpm-lock.yaml` 文件的部署，Vercel 将自动在安装（install）和构建（build）命令中使用 pnpm v8。

To upgrade your project to pnpm v8, run `pnpm install -g pnpm@8` locally and then re-run `pnpm install` to generate the new `pnpm-lock.yaml` file. After updating, create a new deployment for the changes to take effect.

如需将项目升级至 pnpm v8，请先在本地运行 `pnpm install -g pnpm@8`，然后再次运行 `pnpm install` 以生成新的 `pnpm-lock.yaml` 文件。更新完成后，请创建一次新部署，使更改生效。

If you want to specify an exact version of pnpm in your Vercel project, enable [Corepack](https://vercel.com/docs/concepts/deployments/configure-a-build#corepack) (experimental).

若您希望在 Vercel 项目中指定确切的 pnpm 版本，请启用 [Corepack](https://vercel.com/docs/concepts/deployments/configure-a-build#corepack)（实验性功能）。

[Check out the documentation](https://vercel.com/docs/concepts/deployments/build-step#install-command) to learn more.

[查阅文档](https://vercel.com/docs/concepts/deployments/build-step#install-command)，了解更多信息。