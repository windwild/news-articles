---
title: "The Directory Listing feature will be disabled for older projects - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/the-directory-listing-feature-will-be-disabled-for-older-projects"
date: "2021-02-08"
scraped_at: "2026-03-02T10:05:38.188050778+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Feb 8, 2021

2021 年 2 月 8 日

![](images/the-directory-listing-feature-will-be-disabled-for-older-projects-vercel/img_001.jpg)

Last month, Vercel [announced](https://vercel.com/changelog/listing-the-content-of-directories-can-now-be-toggled) that the Directory Listing feature could now be toggled directly from the Project Settings and that it would be disabled for newly created Projects.

上个月，Vercel [宣布](https://vercel.com/changelog/listing-the-content-of-directories-can-now-be-toggled)，目录列表（Directory Listing）功能现已可直接在项目设置（Project Settings）中启用或禁用，并且该功能将默认对所有新创建的项目关闭。

In favor of security, and to prevent unexpected behavior for older Projects, the Directory Listing feature will be disabled for all Projects that were created before January 12th 2021, which is the release date of the respective Project Setting.

出于安全考虑，并防止旧项目出现意外行为，所有于 2021 年 1 月 12 日（即该相关项目设置功能的发布日期）之前创建的项目，其目录列表功能将被统一禁用。

The change will be applied on **March 8th 2021**.

该变更将于 **2021 年 3 月 8 日** 生效。

Because the Directory Listing feature allows for accessing the source code of a Deployment if no [index file](https://vercel.com/docs/edge-network/directory-listing#disabling-directory-listing-on-a-specific-directory) is present within it, it's safer to disable it by default. If you want, however, you can turn the feature back on right afterwards, if you're relying on it.

由于目录列表功能允许在部署（Deployment）中未包含 [索引文件（index file）](https://vercel.com/docs/edge-network/directory-listing#disabling-directory-listing-on-a-specific-directory) 的情况下访问其源代码，因此默认禁用该功能更为安全。但若您确有依赖此功能，您可在变更生效后立即重新启用它。

Check out [the documentation](https://vercel.com/docs/edge-network/directory-listing) as well.

也欢迎查阅 [相关文档](https://vercel.com/docs/edge-network/directory-listing)。