---
title: "Claimed deployments now include third-party resources - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/claimed-deployments-now-include-third-party-resources"
date: "2025-09-23"
scraped_at: "2026-03-02T09:27:58.735340680+00:00"
language: "en-zh"
translated: true
description: "Vercel now supports transferring resources like databases between teams as part of the Claim Deployments flow. Developers building AI agents, no-code tools, and workflow apps can instantly deploy proj..."
---

render_with_liquid: false
Sep 23, 2025

2025 年 9 月 23 日

AI 平台、编程工具和工作流应用现在可在 Vercel 上创建项目，用户后续可认领这些项目，将部署所有权及所有第三方提供商提供的资源一并转移至自己名下。

其工作原理如下：

1. 即时部署：任何第三方均可通过 [Vercel API](https://vercel.com/docs/rest-api/reference/endpoints/integrations/connect-integration-resource-to-project) 创建项目、部署应用，并关联一个资源存储（例如数据库）。

1. 即时部署：任何第三方均可通过 [Vercel API](https://vercel.com/docs/rest-api/reference/endpoints/integrations/connect-integration-resource-to-project) 创建项目、部署应用，并关联一个资源存储（例如数据库）。

2. 认领与移交：当用户认领该 Vercel 部署时，所关联的资源将自动随之迁移。整个部署的完整所有权将正式移交至用户。

2. 认领与移交：当用户认领该 Vercel 部署时，所关联的资源将自动随之迁移。整个部署的完整所有权将正式移交至用户。

此项功能现已上线，首发合作伙伴为 [Prisma](https://www.prisma.io/blog/introducing-instant-app-deployments-in-partnership-with-vercel) —— 首家支持即时部署的 Vercel Marketplace 服务商。Prisma 用户如今可一键同步创建数据库与托管于 Vercel 的应用，形成一个集成、统一的技术栈。

此项功能现已上线，首发合作伙伴为 [Prisma](https://www.prisma.io/blog/introducing-instant-app-deployments-in-partnership-with-vercel) —— 首家支持即时部署的 Vercel Marketplace 服务商。Prisma 用户如今可一键同步创建数据库与托管于 Vercel 的应用，形成一个集成、统一的技术栈。

我们正将该流程拓展至更多 Marketplace 服务商，使其产品（如身份认证、可观测性及工作流服务等）能够通过“一键认领”，与 Vercel 部署无缝集成。

我们正将该流程拓展至更多 Marketplace 服务商，使其产品（如身份认证、可观测性及工作流服务等）能够通过“一键认领”，与 Vercel 部署无缝集成。

欢迎体验我们的 [认领部署实时演示](https://claim-deployments-demo-with-resource.vercel.app/)，并查阅相关[文档](https://vercel.com/docs/deployments/claim-deployments) 以了解详情。

欢迎体验我们的 [认领部署实时演示](https://claim-deployments-demo-with-resource.vercel.app/)，并查阅相关[文档](https://vercel.com/docs/deployments/claim-deployments) 以了解详情。