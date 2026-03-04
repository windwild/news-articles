---
render_with_liquid: false
title: "Reduced build times for large projects - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/reduced-build-times-for-large-projects"
date: "2026-01-14"
scraped_at: "2026-03-02T09:22:49.560097483+00:00"
language: "en-zh"
translated: true
description: "We've shipped optimizations that reduce build overhead, particularly for projects with many input files, large node_modules, or extensive build outputs."
---
render_with_liquid: false
render_with_liquid: false

Jan 14, 2026

2026 年 1 月 14 日

We shipped build system optimizations that reduce overhead for projects with many input files, large `node_modules`, or large build outputs.

我们已上线构建系统优化，可降低包含大量输入文件、庞大的 `node_modules` 或大型构建输出的项目的开销。

Expensive disk operations (large file detection and folder size calculations) are no longer on the critical path for successful builds. These calculations now only run when a build fails, or when you enable the `VERCEL_BUILD_SYSTEM_REPORT` environment variable.

耗时的磁盘操作（如大文件检测和文件夹大小计算）不再处于成功构建的关键路径上。这些计算现在仅在构建失败时，或您启用了 `VERCEL_BUILD_SYSTEM_REPORT` 环境变量时才会执行。

Builds complete 2.8 seconds faster on average, with larger builds seeing improvements of up to 12 seconds.

构建平均提速 2.8 秒；对于大型构建，提速最高可达 12 秒。

See the [builds documentation](https://vercel.com/docs/builds) for details.

详情请参阅[构建文档](https://vercel.com/docs/builds)。