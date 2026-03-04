---
title: "System Environment Variables are now available by default - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/system-environment-variables-are-now-available-by-default"
date: "2020-11-20"
scraped_at: "2026-03-02T10:06:24.238392243+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Nov 20, 2020

2020 年 11 月 20 日

![](images/system-environment-variables-are-now-available-by-default-vercel/img_001.jpg)

Previously, consuming values provided by the Vercel platform in your Environment Variables (like the URL of your Deployment) required adding System Environment Variables using the "Environment Variables" page in the Project Settings.

此前，若要在环境变量（例如部署的 URL）中使用 Vercel 平台提供的值，需通过项目设置中的“环境变量”页面手动添加系统环境变量。

All new Projects created as of today, however, will automatically receive all System Environment Variables by default – without you having to expose them explicitly.

但从今日起，所有新建项目将默认自动获取全部系统环境变量——您无需再显式启用它们。

This setting can also be controlled from existing Projects, which means that you can easily opt into the new behavior for those as well.

该设置同样适用于现有项目，这意味着您也可以轻松为这些项目启用新行为。

Furthermore, the available System Environment Variables were revamped to have much more straightforward names and don't differentiate between Git providers anymore. For example, you can now use `VERCEL_GIT_COMMIT_REF` to retrieve the Git commit SHA for GitHub, GitLab and Bitbucket instead of having to use several different System Environment Variables for that.

此外，可用的系统环境变量已全面重构：命名更加直观，并且不再区分不同的 Git 托管平台。例如，现在您只需使用 `VERCEL_GIT_COMMIT_REF` 即可获取 GitHub、GitLab 和 Bitbucket 的 Git 提交 SHA，而无需再为不同平台分别使用多个不同的系统环境变量。

Check out [the documentation](https://vercel.com/docs/environment-variables#system-environment-variables) as well.

也欢迎查阅[相关文档](https://vercel.com/docs/environment-variables#system-environment-variables)。