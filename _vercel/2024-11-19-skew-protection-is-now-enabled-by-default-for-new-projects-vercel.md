---
title: "Skew Protection is now enabled by default for new projects - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/skew-protection-is-now-enabled-by-default-for-new-projects"
date: "2024-11-19"
scraped_at: "2026-03-02T09:39:22.161377095+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
&#123;% raw %}

Nov 19, 2024

2024 年 11 月 19 日

![](images/skew-protection-is-now-enabled-by-default-for-new-projects-vercel/img_001.jpg)![](images/skew-protection-is-now-enabled-by-default-for-new-projects-vercel/img_002.jpg)

[Skew Protection（倾斜保护）](https://vercel.com/docs/deployments/skew-protection) 消除了 Web 客户端与服务器之间的版本差异——该功能面向 Pro 和 Enterprise 计划用户开放。自今日起，所有新建项目将默认启用 Skew Protection。

现有项目不会被自动更改，但您可在项目设置中手动启用 Skew Protection。

Skew Protection 可确保客户端代码在一段时间内（或直至发生硬性页面刷新）与对应部署的服务器端代码保持一致。该机制可防止在创建新部署时出现版本不匹配错误，例如因哈希化资源包导致的文件名变更，或 Server Actions 触发的表单回传（post backs）等场景。

了解更多关于 [Skew Protection（倾斜保护）](https://vercel.com/docs/deployments/skew-protection) 的信息。
&#123;% endraw %}
