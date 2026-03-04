---
title: "Upgrading Ruby v2.7 to v3.2 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/upgrading-ruby-v2-7-to-v3-2"
date: "2023-11-22"
scraped_at: "2026-03-02T09:49:26.156504640+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
{% raw %}

Nov 22, 2023

2023 年 11 月 22 日

Gemfile

```javascript
source "https://rubygems.org"

ruby "~> 3.2.x"
```

Ruby v3.2 现已正式发布，成为基于 Ruby 的 [构建（Builds）](https://vercel.com/docs/deployments/builds) 和 [无服务器函数（Serverless Functions）](https://vercel.com/docs/functions/serverless-functions) 的新默认运行时版本。此外，Ruby v2.7 将于 2023 年 12 月 7 日起停止支持。

- 使用 Ruby v2.7 的现有部署 _将继续正常运行_

- 新部署将默认使用 Ruby v3.2；若 `Gemfile` 中明确定义了 `ruby "~> 3.2.x"`，也将使用该版本

- 自 2023 年 12 月 7 日起，若 `Gemfile` 中定义了 `ruby "~> 2.7.x"`，则新部署将无法构建

仅保证次要版本号（如 `3.2`）的兼容性，这意味着我们始终会在该次要版本范围内使用最新的补丁版本（patch version）。

[查阅文档](https://vercel.com/docs/functions/serverless-functions/runtimes/ruby) 了解更多信息。
{% endraw %}
