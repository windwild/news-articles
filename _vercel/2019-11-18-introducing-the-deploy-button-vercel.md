---
title: "Introducing the Deploy Button - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/deploy-button"
date: "2019-11-18"
scraped_at: "2026-03-02T10:07:26.367247848+00:00"
language: "en-zh"
translated: true
description: "Make your project deployable with the click of a button."
---
{% raw %}

Nov 18, 2019

2019 年 11 月 18 日

将您的自定义模板作为一键部署方案分享出去。

作为开源项目或框架的作者，您关注的重点之一，便是尽可能降低用户上手使用您作品的门槛。

借助本次功能更新，您现在可将整个部署流程简化为一次单击操作：Vercel 部署按钮（Deploy Button）。

## What's new

## 新增功能

为向用户提供一种便捷方式，使其能轻松将您的代码部署至生产环境（并在此后持续更新），您现在可以 [创建专属的部署按钮](https://vercel.com/docs/more/deploy-button)。

点击“Deploy”（部署）后，系统将提示您确认部署目标及项目名称；随后，将自动从 [Next.js 示例列表](https://github.com/zeit/next.js/tree/canary/examples/hello-world) 中选取一个 [Next.js](https://zeit.co/solutions/nextjs) 模板，将其 Fork 并完成部署。

![The interface for selecting the destination of your deployment.](images/introducing-the-deploy-button-vercel/img_001.jpg)  
选择部署目标的界面。

## Creating Git repositories

## 创建 Git 仓库

您可能还希望同时创建一个 GitHub 或 GitLab 仓库。只需在部署按钮流程中勾选“Create Git repository”（创建 Git 仓库）选项，即可轻松实现。

![The interface for creating a Git repository for your new project.](images/introducing-the-deploy-button-vercel/img_002.jpg)  
为您的新项目创建 Git 仓库的界面。

我们将在您点击“部署”（Deploy）后，自动为您创建 Git 仓库，并推送您刚刚创建的部署所对应的源文件。

## Get your own  

将该按钮用于您自己的项目，只需复制我们的默认 Markdown 代码片段，并将其中的 Git 仓库 URL 替换为您自己的即可：

```bash
1[![Deploy with Vercel](images/introducing-the-deploy-button-vercel/img_003.jpg)](https://vercel.com/new/project?template=https://github.com/zeit/now-examples/tree/master/nextjs)
```

该按钮用于部署 `zeit/now-examples` 仓库中 `nextjs` 目录下的示例项目。

如需查看 HTML 编写的示例，请参阅该功能的[官方文档](https://zeit.co/docs/v2/more/deploy-button/)。

## Conclusion  

## 总结  

我们的“部署按钮”（Deploy Button）可让用户轻松地将您的代码一键部署至 Vercel 平台。

它尤其适用于用户此前从未使用过我们平台的场景；当然，即使用户已拥有 Vercel 账户，该按钮同样高效易用。

With this release, we hope to empower open source maintainers and enable faster deployment workflows for the people enjoying their creations.

借助本次发布，我们希望赋能开源维护者，并为享受其作品的用户实现更快速的部署工作流。

[Let us know what you think](mailto:support@vercel.com) about this change!

[欢迎就这一变更告诉我们您的想法](mailto:support@vercel.com)！
{% endraw %}
