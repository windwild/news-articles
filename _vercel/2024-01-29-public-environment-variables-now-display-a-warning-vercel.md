---
title: "Public environment variables now display a warning - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/public-environment-variables-now-display-a-warning"
date: "2024-01-29"
scraped_at: "2026-03-02T09:48:19.909829518+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
&#123;% raw %}

Jan 29, 2024

2024 年 1 月 29 日

![](images/public-environment-variables-now-display-a-warning-vercel/img_001.jpg)![](images/public-environment-variables-now-display-a-warning-vercel/img_002.jpg)

When creating and editing Environment Variables on Vercel, you can now see hints to warn you of potentially leaking secret values to the public.  

在 Vercel 上创建或编辑环境变量时，您现在会看到提示信息，以警告您可能意外将敏感值泄露至公开环境。

This supports all frameworks that use a prefix to mark an environment variable as safe to use on the client like:

该功能支持所有通过特定前缀标识“可在客户端安全使用”的环境变量的框架，例如：

- Next.js  
- Create React App  
- Vue.js  
- Nuxt  
- Gridsome  
- Gatsby  
- SvelteKit

- Vite

- Vite

Learn more about [Environment Variables](https://vercel.com/docs/projects/environment-variables).

了解更多关于 [环境变量](https://vercel.com/docs/projects/environment-variables) 的信息。
&#123;% endraw %}
