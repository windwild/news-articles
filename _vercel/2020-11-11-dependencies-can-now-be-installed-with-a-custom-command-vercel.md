---
title: "Dependencies can now be installed with a custom command - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/dependencies-can-now-be-installed-with-a-custom-command"
date: "2020-11-11"
scraped_at: "2026-03-02T10:06:32.977667039+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
&#123;% raw %}

Nov 11, 2020

2020 年 11 月 11 日

![](images/dependencies-can-now-be-installed-with-a-custom-command-vercel/img_001.jpg)

By default, Vercel automatically determines the right command for installing your project's code dependencies in the [Build Step](https://vercel.com/docs/build-step) based on the [Framework Preset](https://vercel.com/docs/build-step#framework-preset) configured for your project and the presence of certain files (like `package-lock.json`) in your source code.

默认情况下，Vercel 会根据您项目所配置的 [框架预设（Framework Preset）](https://vercel.com/docs/build-step#framework-preset)，以及源代码中是否存在某些特定文件（例如 `package-lock.json`），在 [构建步骤（Build Step）](https://vercel.com/docs/build-step) 中自动确定安装项目代码依赖项所需的正确命令。

As of today, you can customize the command that Vercel will run within the Build Step for installing your code dependencies.

即日起，您可自定义 Vercel 在构建步骤中用于安装代码依赖项的命令。

In the new **Install Command** section within the Project Settings, you can now enter any command of your choice that will be run instead of having Vercel automatically determine the right one for you.

在项目设置（Project Settings）中的全新 **Install Command（安装命令）** 区域，您现在可以输入任意自定义命令，以替代 Vercel 自动为您推断的默认命令。

Check out [the documentation](https://vercel.com/docs/build-step#install-command) as well.

也欢迎查阅 [相关文档](https://vercel.com/docs/build-step#install-command)。
&#123;% endraw %}
