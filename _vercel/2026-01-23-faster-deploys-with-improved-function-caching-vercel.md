---
title: "Faster deploys with improved function caching - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/faster-deploys-with-improved-function-caching"
date: "2026-01-23"
scraped_at: "2026-03-02T09:22:13.444980515+00:00"
language: "en-zh"
translated: true
description: "Functions are now cached more effectively during deployment, saving 400ms-5s per build. Python, Go, Ruby, Rust, and   standalone functions benefit most."
---
&#123;% raw %}

Jan 23, 2026

2026 年 1 月 23 日

Function uploads are now skipped when code hasn't changed, reducing build times by 400–600ms on average and up to 5 seconds for larger builds.

当代码未发生变化时，函数上传现在会被自动跳过，平均可缩短构建时间 400–600 毫秒，大型构建中最多可节省 5 秒。

Previously, deployment-specific environment variables like `VERCEL_DEPLOYMENT_ID` were included in the function payload, making every deployment unique even with identical code. These variables are now injected at runtime, allowing Vercel to recognize unchanged functions and skip redundant uploads.

此前，`VERCEL_DEPLOYMENT_ID` 等与部署相关的环境变量会被包含在函数载荷（function payload）中，导致即使代码完全相同，每次部署也会被视为不同。如今这些变量改为在运行时注入，使 Vercel 能够识别出未变更的函数，从而跳过冗余上传。

This optimization applies to [Vercel Functions](https://vercel.com/docs/functions) without a framework, and projects using Python, Go, Ruby, and Rust. Next.js projects will receive the same improvement soon.

该优化适用于不依赖框架的 [Vercel Functions](https://vercel.com/docs/functions)，以及使用 Python、Go、Ruby 和 Rust 的项目。Next.js 项目也将很快获得相同改进。

The optimization is applied automatically to all deployments with no configuration required.

该优化会自动应用于所有部署，无需任何配置。

Learn more about [functions](https://vercel.com/docs/functions) and [builds](https://vercel.com/docs/deployments/builds) in our documentation.

请参阅我们的文档，进一步了解 [函数（functions）](https://vercel.com/docs/functions) 和 [构建（builds）](https://vercel.com/docs/deployments/builds)。
&#123;% endraw %}
