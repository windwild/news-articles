---
title: "Skew Protection now supports prebuilt deployments - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/skew-protection-now-supports-prebuilt-deployments"
date: "2026-01-28"
scraped_at: "2026-03-02T10:47:53.499510021+00:00"
language: "en-zh"
translated: true
description: "Next.js now supports a custom deploymentId in next.config.js, enabling Skew Protection for vercel deploy --prebuilt workflows. Set your own deployment ID using a git SHA or timestamp to maintain versi..."
---
&#123;% raw %}

Jan 28, 2026

2026 年 1 月 28 日

Skew Protection 现在可与 `vercel deploy --prebuilt` 部署配合使用。

对于在本地构建应用并使用 `--prebuilt` 参数上传的团队，您现在可以在 `next.config.js` 中设置自定义的 `deploymentId`：

next.config.js

```javascript
module.exports = {

2  deploymentId: process.env.GIT_SHA || 'my-deployment-id',

3}
```

该 ID 将被写入 `routes-manifest.json`，并由 Vercel 用于 Skew Protection 的路由机制。您可以自主管理该 ID 的生命周期：可在多个预构建（prebuilt）部署中复用同一 ID，也可在部署新版本时更新该 ID。

此功能为“本地构建应用、再上传至 Vercel”这一特定工作流提供了 Skew Protection 支持。

了解更多关于 [Skew Protection](https://vercel.com/docs/skew-protection) 的信息。
&#123;% endraw %}
