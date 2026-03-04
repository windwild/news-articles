---
title: "Vercel Remote Cache SDK is now available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-remote-cache-sdk-is-now-available"
date: "2022-09-19"
scraped_at: "2026-03-02T10:00:30.377247465+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
{% raw %}

Sep 19, 2022

2022 年 9 月 19 日

![](images/vercel-remote-cache-sdk-is-now-available-vercel/img_001.jpg)![](images/vercel-remote-cache-sdk-is-now-available-vercel/img_002.jpg)

Remote Caching is an advanced feature that build tools like [Turborepo](https://turborepo.org/) use to speed up execution by caching build artifacts and outputs in the cloud. With Remote Caching, artifacts can be shared between team members in both local, and CI environments—ensuring you never need to recompute work that has already been done.

远程缓存（Remote Caching）是一项高级功能，Turborepo 等构建工具通过该功能将构建产物与输出结果缓存在云端，从而加速执行过程。借助远程缓存，团队成员可在本地开发环境和持续集成（CI）环境中共享这些构建产物，确保已执行过的任务无需重复计算。

With the release of the [Vercel Remote Cache SDK](https://github.com/vercel/remote-cache), we're making the Vercel Remote Cache available to everyone. Through Vercel's Remote Caching API, teams can leverage this advanced primitive without worrying about hosting, infrastructure, or maintenance.

随着 [Vercel 远程缓存 SDK](https://github.com/vercel/remote-cache) 的发布，Vercel 远程缓存现已向所有开发者开放。借助 Vercel 提供的远程缓存 API，团队可直接使用这一高级能力，而无需操心托管、基础设施或运维维护等问题。

In addition to [Turborepo](https://turborepo.org/), which ships with the Vercel Remote Cache support by default, we're releasing plugins for [Nx](https://github.com/vercel/remote-cache/tree/main/packages/remote-nx?rgh-link-date=2022-09-19T23%3A37%3A04Z) and [Rush](https://github.com/vercel/remote-cache/tree/main/packages/remote-rush?rgh-link-date=2022-09-19T23%3A37%3A04Z).

除默认集成 Vercel 远程缓存支持的 [Turborepo](https://turborepo.org/) 外，我们还同步发布了对 [Nx](https://github.com/vercel/remote-cache/tree/main/packages/remote-nx?rgh-link-date=2022-09-19T23%3A37%3A04Z) 和 [Rush](https://github.com/vercel/remote-cache/tree/main/packages/remote-rush?rgh-link-date=2022-09-19T23%3A37%3A04Z) 的插件支持。

Check out our [examples](https://github.com/vercel/remote-cache/tree/main/examples?rgh-link-date=2022-09-19T23%3A37%3A04Z) to get started.

请查看我们的 [示例代码](https://github.com/vercel/remote-cache/tree/main/examples?rgh-link-date=2022-09-19T23%3A37%3A04Z)，快速上手。
{% endraw %}
