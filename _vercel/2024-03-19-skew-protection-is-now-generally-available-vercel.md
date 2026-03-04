---
title: "Skew Protection is now generally available - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/skew-protection-is-now-generally-available"
date: "2024-03-19"
scraped_at: "2026-03-02T09:46:06.016173982+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Mar 19, 2024

2024年3月19日

![](images/skew-protection-is-now-generally-available-vercel/img_001.jpg)![](images/skew-protection-is-now-generally-available-vercel/img_002.jpg)

去年，我们推出了 Vercel 行业首创的 [偏移保护机制（Skew Protection）](https://vercel.com/blog/version-skew-protection)，今天我们很高兴地宣布：该功能现已正式全面开放（Generally Available）。

[偏移保护（Skew Protection）](https://vercel.com/docs/deployments/skew-protection) 解决了前端应用中的两大关键问题：

1. 当用户在部署过程中请求资源（例如 CSS 或 JavaScript 文件）时，偏移保护可实现真正的零停机发布，并确保这些请求均能成功响应。

2. 当最新部署中发布了新的服务端代码后，旧版本客户端仍能正确调用对应的 API 端点（或 React Server Actions）。

自偏移保护功能首次发布以来，我们已进行了以下优化升级：

- 偏移保护现可通过项目高级设置（Advanced Project Settings）中的图形界面（UI）进行配置与管理；  
- Pro 计划用户默认享有 **12 小时** 的保护时长；  
- Enterprise（企业版）客户最高可获得长达 **7 天** 的保护时长。

Skew Protection is now supported in SvelteKit (`v5.2.0` of the Vercel adapter), previously supported in Next.js (stable in `v14.1.4`), and [more frameworks soon](https://vercel.com/docs/frameworks#frameworks-infrastructure-support-matrix). Framework authors can view a [reference implementation here](https://github.com/sveltejs/kit/pull/11987).

SvelteKit 现已支持 Skew Protection（Vercel 适配器 `v5.2.0` 版本），此前 Next.js 已支持该功能（自 `v14.1.4` 起稳定可用），[更多框架即将支持](https://vercel.com/docs/frameworks#frameworks-infrastructure-support-matrix)。框架作者可在此查看 [参考实现](https://github.com/sveltejs/kit/pull/11987)。

[Learn more in the documentation](https://vercel.com/docs/deployments/skew-protection) to get started with Skew Protection.

请参阅[文档](https://vercel.com/docs/deployments/skew-protection)，了解如何开始使用 Skew Protection。