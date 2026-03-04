---
render_with_liquid: false
title: "Default Production Domain - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/default-production-domain"
date: "2019-10-31"
scraped_at: "2026-03-02T10:07:50.855952322+00:00"
language: "en-zh"
translated: true
description: "Every new project now receives a default production domain."
---
render_with_liquid: false
render_with_liquid: false

Oct 31, 2019

2019年10月31日

在创建新项目时，最关键的是：让您的新部署代码快速获得一个可共享的、可投入生产的 URL，整个过程应尽可能简洁顺畅，摩擦最小。

借助今日发布的更新，我们正切实实现这一目标。

## New Default Domain

## 新的默认域名

创建新项目后，您将在项目的“Domains（域名）”标签页中自动看到一个以 `vercel.app` 为后缀的默认域名——其前缀由您的项目名称与一个随机动物名组合而成。

例如，若您的项目名为 **"my-site"**，则默认生产环境域名可能如下所示：

![The default production domain is automatically assigned to your deployments.](images/default-production-domain-vercel/img_001.jpg)  
默认生产环境域名将自动分配给您的每次部署。

## Deploying to Production

## 部署至生产环境

要将代码部署至生产环境，您可通过我们的 [Git 集成](https://zeit.co/docs/v2/git-integration) 向默认分支推送代码，或使用我们的 [命令行工具（CLI）](https://zeit.co/download) 运行 `vercel --prod` 命令。

每个新建项目中的首次部署将自动升级为生产环境部署。

## Editing Your Domain

## 编辑您的域名

Even if you don't like your default production domain, that's not a problem. Changing your production domain is now as easy as clicking **"Edit"** and entering a new one:

即使您不喜欢默认的生产环境域名，这也不是问题。现在，修改生产环境域名只需点击 **“编辑”** 并输入一个新的域名即可：

![You can edit the default production domain or add a custom domain.](images/default-production-domain-vercel/img_002.jpg)  
![您可以编辑默认生产环境域名，或添加自定义域名。](images/default-production-domain-vercel/img_002.jpg)

You can edit the default production domain or add a custom domain.

您可以编辑默认生产环境域名，或添加自定义域名。

## API Changes

## API 变更

The endpoints for [creating a project](https://zeit.co/docs/api#endpoints/projects/create-a-project) and [ensuring a project exists](https://zeit.co/docs/api#endpoints/projects/ensure-a-project-exists) have been adjusted accordingly and will automatically provide you with a production domain.

用于[创建项目](https://zeit.co/docs/api#endpoints/projects/create-a-project)和[确保项目存在](https://zeit.co/docs/api#endpoints/projects/ensure-a-project-exists)的 API 端点已相应调整，将自动为您分配一个生产环境域名。

To opt-in to this feature, you will need to use the latest version of the project endpoints.

如需启用此功能，请使用最新版本的项目相关 API 端点。

## Conclusion

## 总结

With default production domains, you can [deploy to production](https://vercel.com/blog/default-production-domain#deploying-to-production) without having to set up a [custom domain](https://zeit.co/docs/v2/custom-domains/) first.

借助默认生产环境域名，您可直接[部署至生产环境](https://vercel.com/blog/default-production-domain#deploying-to-production)，无需预先配置[自定义域名](https://zeit.co/docs/v2/custom-domains/)。

This drastically decreases the time it takes for you to share a working version of your project.

这将极大缩短您分享项目可用版本所需的时间。

[Let us know what you think](mailto:support@vercel.com) about this change!

欢迎通过 [support@vercel.com](mailto:support@vercel.com) 告诉我们您对本次变更的看法！