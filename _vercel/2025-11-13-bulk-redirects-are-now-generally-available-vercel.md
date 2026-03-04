---
render_with_liquid: false
title: "Bulk redirects are now generally available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/bulk-redirects-are-now-generally-available"
date: "2025-11-13"
scraped_at: "2026-03-02T09:25:43.998017549+00:00"
language: "en-zh"
translated: true
description: "Using bulk redirects, you can import millions of redirects via csv and other formats natively with Vercel."
---
render_with_liquid: false
render_with_liquid: false

Nov 13, 2025

2025 年 11 月 13 日

Vercel 现已支持 [批量重定向（bulk redirects）](https://vercel.com/docs/redirects/bulk-redirects)，每个项目最多可配置一百万条静态 URL 重定向规则。

该功能新增了对 CSV、JSON 等格式的导入支持，使团队能够更轻松地管理大规模网站迁移、修复失效链接、处理已过期页面等场景。

要使用批量重定向功能，请在 `vercel.json` 文件中设置 `bulkRedirectsPath` 字段，将其指向包含重定向规则的文件或文件夹。这些规则将在构建时自动导入。

redirects.csv

```text
source,destination,statusCode

2/product/old,/product/new,308
```

vercel.json

```json
"bulkRedirectsPath": "redirects.csv"
```

该功能面向 Pro 和 Enterprise 计划用户开放，并提供额外容量配额（按用量计费）。

- **Pro:** 每个项目包含 1,000 条批量重定向规则

- **Enterprise:** 每个项目包含 10,000 条批量重定向规则

- **额外容量：** 起价为每月 50 美元，每增加 25,000 条重定向规则

[开始使用批量重定向](https://vercel.com/docs/redirects/bulk-redirects/getting-started)