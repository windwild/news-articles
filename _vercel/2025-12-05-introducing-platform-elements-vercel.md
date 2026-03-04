---
title: "Introducing Platform Elements - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/introducing-platform-elements"
date: "2025-12-05"
scraped_at: "2026-03-02T09:24:26.734406884+00:00"
language: "en-zh"
translated: true
description: "A new library of production-ready shadcn/ui components and actions that you can drop into your app to help accelerate your platform development. "
---

render_with_liquid: false
Dec 5, 2025

2025 年 12 月 5 日

As part of the new [Vercel for Platforms](https://vercel.com/platforms) product, you can now use a set of prebuilt UI blocks and actions to add functionality directly to your application.

作为全新 [Vercel for Platforms](https://vercel.com/platforms) 产品的一部分，您现在可直接在应用中集成一系列预构建的 UI 组件（Blocks）与操作（Actions），快速扩展功能。

[An all-new library](https://vercel.com/platforms/docs/platform-elements/blocks/custom-domain) of production-ready shadcn/ui components and actions help you launch (and upgrade) quickly.

[一套全新发布的组件库](https://vercel.com/platforms/docs/platform-elements/blocks/custom-domain)，包含开箱即用、生产就绪的 shadcn/ui 组件与操作，助您快速上线（及升级）。

**Blocks:**

**组件（Blocks）：**

- [custom-domain](https://vercel.com/platforms/docs/platform-elements/blocks/custom-domain): Domain configuration with DNS validation and real-time verification

- [custom-domain](https://vercel.com/platforms/docs/platform-elements/blocks/custom-domain)：支持 DNS 验证与实时校验的域名配置功能

- [deploy-popover](https://vercel.com/platforms/docs/platform-elements/blocks/deploy-popover): Deployment interface with status and history

- [deploy-popover](https://vercel.com/platforms/docs/platform-elements/blocks/deploy-popover)：含部署状态与历史记录的部署交互界面

- [dns-table](https://vercel.com/platforms/docs/platform-elements/blocks/dns-table): DNS records in a copyable format

- [dns-table](https://vercel.com/platforms/docs/platform-elements/blocks/dns-table)：以可一键复制格式呈现的 DNS 记录列表

- [claim-deployment](https://vercel.com/platforms/docs/platform-elements/blocks/claim-deployment): Ownership verification flow

- [claim-deployment](https://vercel.com/platforms/docs/platform-elements/blocks/claim-deployment)：资源归属权验证流程

- [report-abuse](https://vercel.com/platforms/docs/platform-elements/blocks/report-abuse): Abuse reporting form

- [report-abuse](https://vercel.com/platforms/docs/platform-elements/blocks/report-abuse)：滥用行为举报表单

**Actions:**

**操作（Actions）：**

- [add-custom-domain](https://vercel.com/platforms/docs/platform-elements/actions/add-custom-domain)：以编程方式添加并验证域名  
- [deploy-files](https://vercel.com/platforms/docs/platform-elements/actions/deploy-files)：将文件部署到任意项目  

您可以使用 Vercel Platforms CLI 安装 Platforms 组件。例如：  

```bash
npx @vercel/platforms add claim-deployment
```

使用我们的快速入门指南，开始基于 Platform Elements 构建平台：[多租户平台](https://vercel.com/platforms/docs/multi-tenant-platforms/quickstart) 或 [多项目平台](https://vercel.com/platforms/docs/multi-project-platforms/quickstart)。