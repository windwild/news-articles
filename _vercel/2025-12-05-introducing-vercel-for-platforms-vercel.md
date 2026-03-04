---
title: "Introducing Vercel for Platforms - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/introducing-vercel-for-platforms"
date: "2025-12-05"
scraped_at: "2026-03-02T09:24:26.405705404+00:00"
language: "en-zh"
translated: true
description: "We're launching Vercel for Platforms, a comprehensive solution for building multi-customer platforms."
---

render_with_liquid: false
Dec 5, 2025

2025 年 12 月 5 日

You can now build platforms with the new [Vercel for Platforms](https://vercel.com/platforms) product announced today, making it easy to create and run customer projects on behalf of your users.

您现在可以使用今天发布的全新产品 [Vercel for Platforms](https://vercel.com/platforms) 来构建平台，从而轻松代表您的用户创建并运行客户项目。

Two platform modes are available: [**Multi-Tenant**](https://vercel.com/platforms/docs/multi-tenant-platforms/quickstart) and [**Multi-Project**](https://vercel.com/platforms/docs/multi-project-platforms/quickstart), allowing you to deploy with a single codebase or many, across any number of domains.

目前提供两种平台模式：[**多租户（Multi-Tenant）**](https://vercel.com/platforms/docs/multi-tenant-platforms/quickstart) 和 [**多项目（Multi-Project）**](https://vercel.com/platforms/docs/multi-project-platforms/quickstart)，支持您使用单一代码库或多个代码库，在任意数量的域名下完成部署。

### Multi-Tenant Platforms

### 多租户平台

Run a single codebase that serves many customers with:

通过以下能力，使用单一代码库为众多客户提供服务：

- Wildcard domains (`*.yourapp.com`) with automatic routing and SSL.

- 通配符域名（`*.yourapp.com`），支持自动路由与 SSL 证书。

- Custom domain support via SDK, including DNS verification and certificate management.

- 通过 SDK 支持自定义域名，涵盖 DNS 验证与证书管理。

- Routing Middleware for hostname parsing and customer resolution at the edge.

- 路由中间件（Routing Middleware），可在边缘节点解析主机名并识别对应客户。

- Single deployment model: deploy once, changes apply to all tenants.

- 单次部署模型：仅需部署一次，所有租户即刻生效更新。

Add custom domains to your app in seconds:

几秒钟即可为您的应用添加自定义域名：

```typescript
import {

2  addDomain,

3  getDomainStatus,

4} from "@/components/vercel-platform/src/actions/add-custom-domain";

```typescript
导入：

2  addDomain，

3  getDomainStatus，

4} 来自 "@/components/vercel-platform/src/actions/add-custom-domain";

const added = await addDomain("test.com");

const added = await addDomain("test.com");

if (added.status === "Valid Configuration") {

如果 added.status === "Valid Configuration"：

8  // do something

8  // 执行某些操作

9}

9}

const config = await getDomainStatus("test.com");

const config = await getDomainStatus("test.com");
```

config.dnsRecordsToSet; // show this in a table

config.dnsRecordsToSet；// 在表格中显示此项

### Multi-Project Platforms

### 多项目平台

Create a separate Vercel project per customer with:

为每位客户创建一个独立的 Vercel 项目，具备以下特性：

- Programmatic project creation with the Vercel SDK.

- 使用 Vercel SDK 实现项目创建的自动化。

- Isolation of builds, functions, environment variables, and settings per customer.

- 每位客户的构建、函数、环境变量及设置相互隔离。

- Support for different frameworks per project.

- 每个项目可支持不同的框架。

Deploy your customer's code into isolated projects in seconds:

几秒钟内即可将客户代码部署至相互隔离的项目中：

```typescript
import { deployFiles } from "@/components/vercel-platform/actions/deploy-files";

import { deployFiles } from "@/components/vercel-platform/actions/deploy-files";

// automatically detects the framework & build commands

// 自动识别框架及构建命令

```js
await deployFiles([], {

5  // optionally assign a custom domian

5  // （可选）指定自定义域名

6  domain: "site.myapp.com",

6  domain: "site.myapp.com",

7});
```

Today we are also introducing [Platform Elements](https://vercel.com/changelog/introducing-platform-elements), a new library to make building on platforms easier.

今天，我们还正式推出 [Platform Elements](https://vercel.com/changelog/introducing-platform-elements) —— 一个全新库，旨在简化平台类应用的开发。

Start building with our Quickstart for [Multi-Tenant](https://vercel.com/platforms/docs/multi-tenant-platforms/quickstart) or [Multi-Project](https://vercel.com/platforms/docs/multi-project-platforms/quickstart) platform.

请通过我们的快速入门指南开始构建：[多租户（Multi-Tenant）平台](https://vercel.com/platforms/docs/multi-tenant-platforms/quickstart) 或 [多项目（Multi-Project）平台](https://vercel.com/platforms/docs/multi-project-platforms/quickstart)。