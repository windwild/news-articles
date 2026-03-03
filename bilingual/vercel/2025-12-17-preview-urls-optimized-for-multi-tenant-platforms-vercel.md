---
title: "Preview URLs optimized for multi-tenant platforms - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/preview-urls-optimized-for-multi-tenant-platforms"
date: "2025-12-17"
scraped_at: "2026-03-02T09:23:42.772029215+00:00"
language: "en-zh"
translated: true
description: "Multi-tenant applications can now generate unique preview URLs for each tenant and encode metadata and routing context directly into the URL"
---

Dec 17, 2025

2025 年 12 月 17 日

Vercel 帮助您构建多租户平台，单个项目可支持数万个域名，例如 [vibe 编程平台](https://vercel.com/platforms/docs/examples/oss-coding-agent)、网站构建器、电商 storefront 等。今天我们通过推出 **动态 URL 前缀（Dynamic URL Prefixes）**，进一步简化此类应用的开发流程。

动态 URL 前缀允许您在现有部署 URL 前添加 `{data}---` 形式的前缀，例如：`tenant-123---project-name-git-branch.yourdomain.dev`。

该机制会将流量路由至 `project-name-git-branch.yourdomain.dev`，同时在 URL 中保留 `tenant-123---` 部分，您的应用可从中提取该信息，并据此进行租户识别与路由。

此前，预览 URL 的设计目标是精确匹配某一次特定的预览部署；而 Vercel 当时缺乏足够信息，无法将不同域名精准路由至对应的预览部署。

现在，您可实现以下能力：

- 为每个租户创建唯一的预览 URL  
- 直接在 URL 中编码元数据、路由上下文或自动化信号  
- 使用灵活的 URL 结构，例如：`tenant-123---project-name-git-branch.yourdomain.dev`

面向多租户平台的预览 URL 功能现已向 Pro 与 Enterprise 团队开放，且需配置 [预览部署后缀（Preview Deployment Suffix）](https://vercel.com/docs/deployments/preview-deployment-suffix)（一项 Pro 级 [附加功能](https://vercel.com/docs/pricing#dx-platform-billable-resources)）。

Try the [demo](https://multi-tenant-preview-urls-k6oodlv4w.vercel.rocks/all) or to get started, go to your [team's settings](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fsettings&title=Set+Preview+Deployment+Suffix) to set your Preview Deployment Suffix. Then, follow [our guide](https://vercel.com/platforms/docs/multi-tenant-platforms/preview-url-prefixes) on configuring multi-tenant preview URLs.

请试用 [演示版](https://multi-tenant-preview-urls-k6oodlv4w.vercel.rocks/all)，或立即开始：前往您的 [团队设置页面](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fsettings&title=Set+Preview+Deployment+Suffix) 配置预览部署后缀（Preview Deployment Suffix）。随后，请参阅 [我们的指南](https://vercel.com/platforms/docs/multi-tenant-platforms/preview-url-prefixes)，了解如何配置多租户预览 URL。