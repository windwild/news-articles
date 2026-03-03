---
title: "Pro customers can now configure up to 3 regions for Vercel Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/pro-customers-can-now-configure-up-to-3-regions-for-vercel-functions"
date: "2024-11-20"
scraped_at: "2026-03-02T09:39:53.867223225+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Nov 20, 2024

2024 年 11 月 20 日

[Pro 用户](https://vercel.com/docs/accounts/plans#pro) 现在可为其 Vercel Functions 配置最多三个区域，使计算能力更靠近分布式数据源，从而实现更快的响应速度和更优的性能。当配置了多个 Vercel Function 区域时，需要执行计算的用户请求将被自动路由至距离最近的已指定区域。

此前，Pro 用户的函数仅限于单个区域部署。将区域数量提升至三个，可带来以下优势：

- 全球范围内的低延迟访问  
- 维持高计算密度，从而提高缓存命中率并降低冷启动概率  
- 兼容标准数据库复制方案（例如 PostgreSQL 只读副本）  

此举还额外增强了冗余能力，与 Vercel Functions 内置的 [多可用区（Multi-Availability Zone）](https://vercel.com/blog/effortless-high-availability-for-dynamic-frontends) 冗余机制相辅相成。

如需配置额外的 [区域（regions）](https://vercel.com/docs/projects/project-configuration#regions)，请在 `vercel.json` 文件中添加 `regions` 属性。

```json
1{
2  "regions": ["sfo1", "lhr1", "sin1"]
```

3}
```

vercel.json file with three regions configured

配置了三个区域的 vercel.json 文件

Redeploy your project for the changes to take effect. Learn more about [configuring regions](https://vercel.com/docs/functions/configuring-functions/region#project-configuration).

请重新部署您的项目，使更改生效。了解更多关于[配置区域](https://vercel.com/docs/functions/configuring-functions/region#project-configuration)的信息。