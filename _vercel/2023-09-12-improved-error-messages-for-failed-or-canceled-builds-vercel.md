---
title: "Improved error messages for failed or canceled builds - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/improved-error-messages-for-failed-or-canceled-builds"
date: "2023-09-12"
scraped_at: "2026-03-02T09:50:56.861803168+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Sep 12, 2023

2023年9月12日

![](images/improved-error-messages-for-failed-or-canceled-builds-vercel/img_001.jpg)![](images/improved-error-messages-for-failed-or-canceled-builds-vercel/img_002.jpg)

Failed or canceled builds now have better feedback clearly displayed on the Vercel dashboard in the deployment details page.

失败或已取消的构建现在会在 Vercel 控制台的“部署详情”页面中清晰显示更完善的反馈信息。

The following build failures now have more helpful error messages:

以下构建失败情形现已提供更有帮助的错误提示信息：

- An invalid `vercel.json` configuration  
- `vercel.json` 配置无效

- Canceled builds due to the `ignore build step`  
- 因启用 `ignore build step`（忽略构建步骤）而导致的构建被取消

- A newer commit in the branch triggering a more up-to-date deployment  
- 分支中存在更新的提交，从而触发了更新版本的部署


[Check out our documentation](https://vercel.com/docs/deployments/troubleshoot-a-build#build-logs-not-available) to learn more.

[查阅我们的文档](https://vercel.com/docs/deployments/troubleshoot-a-build#build-logs-not-available) 了解更多信息。