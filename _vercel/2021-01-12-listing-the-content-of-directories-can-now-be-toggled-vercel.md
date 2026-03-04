---
render_with_liquid: false
title: "Listing the content of directories can now be toggled - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/listing-the-content-of-directories-can-now-be-toggled"
date: "2021-01-12"
scraped_at: "2026-03-02T10:06:00.538513564+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Jan 12, 2021

2021 年 1 月 12 日

![](images/listing-the-content-of-directories-can-now-be-toggled-vercel/img_001.jpg)

Until now, directories used to list the directory's contents whenever their path was visited (provided they didn't contain an index file).

此前，当访问某个目录路径时（前提是该目录下不包含 `index` 文件），系统会自动列出该目录下的全部内容。

In cases where this was considered a security issue, turning off the Directory Listing required configuring a rewrite rule in `vercel.json`.

在某些被视为安全风险的场景中，禁用目录列表功能需在 `vercel.json` 中手动配置重写规则。

As of today, the Directory Listing is **disabled for all newly created Projects** and can be toggled on the "Advanced" page in the Project Settings.

自今日起，**所有新创建的项目默认禁用目录列表功能**，您可在项目设置中的“高级”（Advanced）页面手动开启或关闭该功能。

Check out [the documentation](https://vercel.com/docs/edge-network/directory-listing) as well.

也欢迎查阅[相关文档](https://vercel.com/docs/edge-network/directory-listing)。