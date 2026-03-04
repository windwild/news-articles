---
render_with_liquid: false
title: "Customizing the Install Command while creating Projects - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/customizing-the-install-command-while-creating-projects"
date: "2021-08-06"
scraped_at: "2026-03-02T10:04:22.077300186+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Aug 6, 2021

2021年8月6日

![](images/customizing-the-install-command-while-creating-projects-vercel/img_001.jpg)

When [importing a Git repository](https://vercel.com/new) into Vercel, your Project's dependencies used to automatically be installed using either [Yarn](https://yarnpkg.com/) or [npm](https://www.npmjs.com/), depending on your code. Selecting a different package manager such as [pnpm](https://pnpm.io/) was only possible after the Project was already deployed.

在 Vercel 中 [导入 Git 仓库](https://vercel.com/new) 时，项目依赖项过去会根据代码自动使用 [Yarn](https://yarnpkg.com/) 或 [npm](https://www.npmjs.com/) 进行安装。而选择其他包管理器（例如 [pnpm](https://pnpm.io/)）则只能在项目完成首次部署之后才可进行。

As of today, however, you can configure your custom Install Command even before the first Deployment for your new Project is created.

但从今天起，您可以在新项目的首次部署创建之前，就配置自定义的“安装命令”（Install Command）。

This also comes in handy for passing custom options to the `yarn` or `npm install` commands, since you can simply place the command of your choice in the "Install Command" field.

此外，当您需要向 `yarn` 或 `npm install` 命令传递自定义参数时，此功能也十分便捷——您只需将所需命令填入“安装命令”字段即可。

Check out [the documentation](https://vercel.com/docs/build-step#install-command) as well.

也请参阅 [相关文档](https://vercel.com/docs/build-step#install-command)。