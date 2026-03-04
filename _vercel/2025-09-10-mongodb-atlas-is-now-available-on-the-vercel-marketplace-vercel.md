---
render_with_liquid: false
title: "MongoDB Atlas is now available on the Vercel Marketplace  - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/mongodb-atlas-is-now-available-on-the-vercel-marketplace"
date: "2025-09-10"
scraped_at: "2026-03-02T09:28:46.104799185+00:00"
language: "en-zh"
translated: true
description: "MongoDB Atlas is now available on the Vercel Marketplace, enabling developers to provision, manage, and scale fully managed MongoDB databases directly from the Vercel dashboard."
---
render_with_liquid: false
render_with_liquid: false

Sep 10, 2025

2025 年 9 月 10 日

[MongoDB Atlas](https://vercel.com/marketplace/mongodbatlas) 现已在 Vercel Marketplace 上线。开发者现在可直接通过 Vercel 控制台开通完全托管的 MongoDB 数据库，并将其无缝连接至您的项目，全程无需离开平台。

为项目添加数据库通常意味着需额外管理一个账户、手动配置连接参数，并在不同服务间协调账单。Vercel Marketplace 将这些工具深度整合进您现有的工作流中，让您专注于构建应用，而非繁琐的配置工作。

![](images/mongodb-atlas-is-now-available-on-the-vercel-marketplace-vercel/img_001.jpg)![](images/mongodb-atlas-is-now-available-on-the-vercel-marketplace-vercel/img_002.jpg)

## 通过统一工作流加速交付

通过 Vercel 开通 MongoDB Atlas 会自动为您配置项目的环境变量，并将账单集成至您的 Vercel 账户。数据库的部署与运维由 MongoDB Atlas 全权负责，而您则可继续沿用熟悉的 Vercel 工作流。

> “我们非常高兴与 MongoDB 展开合作，将 Atlas 引入 Vercel Marketplace。通过融合 MongoDB 灵活的数据平台与 Vercel 对开发者体验的专注，我们正为双方社区提供一条更快速的路径——在 AI Cloud 上构建并规模化智能应用。”  
>  
> ![](images/mongodb-atlas-is-now-available-on-the-vercel-marketplace-vercel/img_003.png)  
>  
> **Tom Occhino**，Vercel 首席产品官（Chief Product Officer）

**其他关键优势还包括：**

- **一键式设置**：无需单独注册 MongoDB Atlas 账户；若您尚未拥有 Atlas 账户，系统将自动为您创建并完成关联  

- **一体化管理**：Atlas 可直接通过 Vercel 控制台进行管理，涵盖账单集成与资源开通；您可在同一界面中同时监控应用与数据库状态

- **Flexible, scalable data:** MongoDB Atlas provides a document data model that works with structured or unstructured data, plus horizontal scaling with replica sets and sharding. Choose from free, pre-provisioned, or serverless deployment options  

- **灵活、可扩展的数据：** MongoDB Atlas 提供文档数据模型，可同时处理结构化与非结构化数据，并支持通过副本集（replica sets）和分片（sharding）实现水平扩展。您可自由选择免费版、预配置版或无服务器（serverless）部署方案。

- **Built-in search and AI readiness:** Atlas includes full-text search, vector search, and semantic search for AI applications, giving your Vercel apps advanced querying and AI/ML capabilities out-of-the-box  

- **内置搜索与 AI 就绪能力：** Atlas 原生集成全文搜索、向量搜索与语义搜索功能，专为 AI 应用而优化，让您基于 Vercel 构建的应用开箱即用，即可获得高级查询能力及 AI/机器学习（AI/ML）功能。

- **High performance and security:** Low-latency data access with global replicas, plus built-in security features like encryption and access controls  

- **高性能与高安全性：** 依托全球分布的副本节点实现低延迟数据访问，并内置加密、访问控制等安全机制。

> “Vercel powers many of the best experiences on the web, with an exceptional focus on developer experience from open source to their AI Cloud. We are thrilled to be launching onto the Vercel Marketplace, supercharging our joint community with the power of MongoDB's flexible document model with integrated search and vector search. Vercel powers many of the best experiences on the web, with an exceptional focus on developer experience from open source to their AI Cloud. We are thrilled to be launching onto the Vercel Marketplace, supercharging our joint community with the power of MongoDB's flexible document model with integrated search and vector search.”  
>   
> “Vercel 为 Web 上众多顶尖用户体验提供动力支持，其始终以开发者体验为核心——从开源生态到 AI Cloud，无不体现这一承诺。我们非常激动地宣布 MongoDB Atlas 正式登陆 Vercel Marketplace！此次合作将赋能双方共建社区，释放 MongoDB 灵活文档模型的强大能力，并深度融合搜索与向量搜索功能。”  
>   
> ![](images/mongodb-atlas-is-now-available-on-the-vercel-marketplace-vercel/img_004.png)  
>   
> **Andrew Davidson**, SVP Products at MongoDB  
>   
> **安德鲁·戴维森（Andrew Davidson）**，MongoDB 产品高级副总裁

This integration provides a fast, modern data layer to power web and AI applications on Vercel. Once you provision Atlas through the Marketplace, connecting to your database is straightforward:  

该集成为您提供了一套快速、现代化的数据层，专为在 Vercel 上构建 Web 应用与 AI 应用而设计。您只需通过 Marketplace 完成 Atlas 实例的创建，即可轻松连接数据库：

mongodb.ts

```tsx
import { MongoClient, MongoClientOptions } from 'mongodb';

import { attachDatabasePool } from '@vercel/functions';



const options: MongoClientOptions = {

5  appName: "devrel.vercel.integration",

5  appName: "devrel.vercel.integration",

6  maxIdleTimeMS: 5000

6  maxIdleTimeMS: 5000

7};

7};

const client = new MongoClient(process.env.MONGODB_URI, options);

const client = new MongoClient(process.env.MONGODB_URI, options);



10// Attach the client to ensure proper cleanup on function suspension

10// 将客户端挂载，以确保在函数暂停时能正确执行清理操作

attachDatabasePool(client);

attachDatabasePool(client);



13// Export a module-scoped MongoClient to ensure the client can be shared across functions.

13// 导出一个模块作用域内的 MongoClient 实例，以确保该客户端可在多个函数间共享。

export default client;

export default client;

The `MONGODB_URI` environment variable gets configured automatically when you provision Atlas through Vercel, so you can start building immediately.

当您通过 Vercel 部署 Atlas 时，`MONGODB_URI` 环境变量会自动配置，因此您可以立即开始构建。

### Get started with MongoDB Atlas on Vercel

### 在 Vercel 上快速开始使用 MongoDB Atlas

[MongoDB Atlas](https://vercel.com/marketplace/mongodbatlas) 在 Vercel 应用市场中提供，所有套餐的客户均可使用。

在 Vercel 上部署 [MongoDB Atlas 论坛模板](https://vercel.com/templates/next.js/mongodb-atlas-forum)。