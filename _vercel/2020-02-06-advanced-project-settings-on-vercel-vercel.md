---
render_with_liquid: false
title: "Advanced Project Settings on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/advanced-project-settings"
date: "2020-02-06"
scraped_at: "2026-03-02T10:07:18.807367234+00:00"
language: "en-zh"
translated: true
description: "Fully customize your project’s behaviour or hit the ground running using our new framework presets."
---
render_with_liquid: false
render_with_liquid: false

Feb 6, 2020

2020 年 2 月 6 日

通过改进的导入功能、项目设置以及 Vercel CLI，更高效地管理您的项目。

随着 [零配置部署（Zero Config Deployments）](https://zeit.co/blog/zero-config) 的发布，我们让项目搭建变得极为简单：只需 [导入一个 Git 仓库](https://zeit.co/docs)，即可自动为每次推送（push）和拉取请求（pull request）部署项目——全程无需任何配置。

今天，我们将这一能力扩展至非 JavaScript 项目（例如 [Hugo](https://gohugo.io/) 网站），并为您提供对项目自动生成配置的完全控制权。

## 更智能的导入（Better Import）

如果您的代码位于子目录中，您会发现：当将任一 Git 仓库接入 Vercel 时，系统会提示您指定一个 **根目录（Root Directory）**，这将非常实用。

此外，您现在还可选择不同的 **框架（Framework）**，或覆盖其默认配置：

![在导入仓库时，根据您的需求选择合适的设置。](images/advanced-project-settings-on-vercel-vercel/img_001.jpg)在导入仓库时，根据您的需求选择合适的设置。

## 更灵活的项目设置（Better Project Settings）

项目部署完成后，您可能仍需持续调整其配置，直至完全满足您的各项需求——无论这些需求多么复杂。

Because of that, you can now fully customize all of the options mentioned above right from the Project Settings:

由于这一点，您现在可以直接在项目设置（Project Settings）中完全自定义上述所有选项：

![Adjust your project's configuration at any time.](images/advanced-project-settings-on-vercel-vercel/img_002.jpg)  
![随时调整您项目的配置。](images/advanced-project-settings-on-vercel-vercel/img_002.jpg)  
Adjust your project's configuration at any time.  
随时调整您项目的配置。

All of the fields are automatically optimized for your Framework by default. Overwriting one of them, however, is as easy as turning on the `OVERRIDE` toggle.

所有字段默认均已针对您的框架（Framework）自动优化。但若您需要覆盖其中某一项配置，则只需开启 `OVERRIDE` 切换开关即可，操作极为简便。

## Better Vercel CLI

## 更强大的 Vercel CLI

After [importing your Git repository](https://zeit.co/docs/v2/git-integrations), every push and pull request gets deployed automatically. However, sometimes you might want to create a quick manual deployment from the CLI.

在[导入您的 Git 仓库](https://zeit.co/docs/v2/git-integrations)后，每次推送（push）和拉取请求（pull request）都会自动部署。但有时，您可能希望直接通过命令行界面（CLI）快速发起一次手动部署。

To make this easy, creating new projects through our [command-line interface](https://zeit.co/download) now surfaces the automatically detected configuration and lets you edit it on the fly:

为简化此流程，现通过我们的[命令行工具（CLI）](https://zeit.co/download)创建新项目时，系统将自动显示检测到的配置，并支持您即时编辑：

![Setting up a new Vercel project using Vercel CLI.](images/advanced-project-settings-on-vercel-vercel/img_003.jpg)  
![使用 Vercel CLI 设置新的 Vercel 项目。](images/advanced-project-settings-on-vercel-vercel/img_003.jpg)  
Setting up a new Vercel project using Vercel CLI.  
使用 Vercel CLI 设置新的 Vercel 项目。

For subsequent deployments, those values naturally don't have to be configured:

对于后续的部署，这些值自然无需再次配置：

![Deploying to an existing Vercel project using Vercel CLI.](images/advanced-project-settings-on-vercel-vercel/img_004.jpg)  
![使用 Vercel CLI 向现有 Vercel 项目部署。](images/advanced-project-settings-on-vercel-vercel/img_004.jpg)  
Deploying to an existing Vercel project using Vercel CLI.  
使用 Vercel CLI 向现有 Vercel 项目部署。

In order to run `vercel dev`, please make sure to first deploy using `vercel`. Additionally, `vercel --confirm` can be run to auto-confirm the prompts.

如需运行 `vercel dev`，请确保先执行 `vercel` 完成首次部署。此外，您还可运行 `vercel --confirm` 以自动确认所有交互式提示。

Aside from allowing for customizing your Framework settings, as you can see, Vercel CLI now also lets you link your local codebase to any project on Vercel – no matter its name or scope.

除了支持自定义您的 Framework 设置外，如您所见，Vercel CLI 现在还允许您将本地代码库关联到 Vercel 上的任意项目——无论其名称或作用域如何。

## Conclusion

## 总结

Thanks to the above changes, several new use cases are now possible:

得益于上述变更，现在可以实现多种全新的使用场景：

- Projects without a `package.json` file (like [Hugo](https://gohugo.io/) or [Jekyll](https://jekyllrb.com/) sites) can be deployed.

- 不含 `package.json` 文件的项目（例如 [Hugo](https://gohugo.io/) 或 [Jekyll](https://jekyllrb.com/) 网站）也可部署。

- Your project can be located in a subdirectory of your Git repository.

- 您的项目可位于 Git 仓库的子目录中。

- The Build Command, Development Command, and Output Directory can be customized.

- 构建命令（Build Command）、开发命令（Development Command）和输出目录（Output Directory）均可自定义。

The `--name` flag is now [deprecated](https://vercel.com/docs/now-cli#commands/now/unique-options/name) in Vercel CLI.

`--name` 标志在 Vercel CLI 中现已[弃用](https://vercel.com/docs/now-cli#commands/now/unique-options/name)。

With this release, we've also paved the way for several additional fields that will enable an even more extensive range of use cases in the future. [Stay tuned](https://twitter.com/vercel) [!](https://twitter.com/zeithq)

借助本次发布，我们还为若干新增字段铺平了道路，未来将支持更广泛多样的使用场景。[敬请关注](https://twitter.com/vercel) [!](https://twitter.com/zeithq)