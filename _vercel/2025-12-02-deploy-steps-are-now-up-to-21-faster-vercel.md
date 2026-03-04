---
title: "Deploy steps are now up to 21% faster - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/deploy-steps-are-now-up-to-21-faster"
date: "2025-12-02"
scraped_at: "2026-03-02T09:24:35.631048935+00:00"
language: "en-zh"
translated: true
description: "Deploy steps for projects with Functions are now up to 21% faster—nearly 2 seconds faster on average. No changes required."
---

render_with_liquid: false
Dec 2, 2025

2025 年 12 月 2 日

On average, the deploy step is now 17% faster, reducing total time to go live by 1.67 seconds. Projects with a large number of functions will see even greater improvements, with up to 2.8 seconds saved on average.

平均而言，部署（deploy）步骤现在提速了 17%，使整体上线时间缩短了 1.67 秒。函数数量较多的项目将获得更显著的性能提升，平均可节省高达 2.8 秒。

During the deploy step, Vercel uploads static assets, provisions and uploads like Vercel Functions, processes routing metadata, and prepares the deployment to receive traffic. This phase is now faster due to reduced idle time and increased concurrency across these operations.

在部署阶段，Vercel 会上传静态资源、配置并上传 Vercel Functions 等函数、处理路由元数据，并为部署就绪以接收流量做好准备。得益于各操作间空闲时间的减少以及并发度的提升，该阶段的整体执行速度现已加快。

Check out [the documentation](https://vercel.com/docs/builds) to learn more about builds.

请查阅 [相关文档](https://vercel.com/docs/builds)，进一步了解构建（builds）流程。