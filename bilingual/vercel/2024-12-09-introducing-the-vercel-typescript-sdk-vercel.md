---
title: "Introducing the Vercel TypeScript SDK - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/introducing-the-vercel-typescript-sdk"
date: "2024-12-09"
scraped_at: "2026-03-02T09:38:46.830802469+00:00"
language: "en-zh"
translated: true
description: "A new type-safe SDK for working with the Vercel REST API."
---

Dec 9, 2024

2024 年 12 月 9 日

We’ve published a TypeScript-native SDK for working with the Vercel API.

我们已发布一个专为 TypeScript 设计的原生 SDK，用于调用 Vercel API。

Terminal

Terminal（终端）

```bash
npm i @vercel/sdk
```

This SDK includes:

该 SDK 包含以下特性：

- Full type safety for accessing the Vercel REST API with Zod schemas  
  基于 Zod Schema 的完整类型安全，确保对 Vercel REST API 的调用具备强类型保障

- New documentation for every function, argument, and type  
  每个函数、参数及类型的全新文档说明

- Better tree-shaking support with optional standalone functions  
  更优的摇树优化（tree-shaking）支持，并提供可选的独立函数

- Intuitive error handling and detailed error messages  
  直观的错误处理机制与详尽的错误信息

- Configurable retry strategies (including backoffs)  
  可配置的重试策略（包括退避机制）

```tsx
import { Vercel } from '@vercel/sdk';



const vercel = new Vercel({

4  bearerToken: process.env.VERCEL_TOKEN,

5});



const result = await vercel.deployments.getDeployment({

8  idOrUrl: 'dpl_89qyp1cskzkLrVicDaZoDbjyHuDJ'

9});
```

该 SDK 可用于自动化 Vercel 平台的各个环节，包括：

- Deployment automation and management  
- 部署自动化与管理  

- Project creation and configuration  
- 项目创建与配置  

- Domain management  
- 域名管理  

- Team and user administration  
- 团队与用户管理  

- Environment variable management  
- 环境变量管理  

- Logs and monitoring  
- 日志与监控  

- Integration configuration  
- 集成配置  

[View the docs](https://vercel.com/docs/rest-api/sdk) or [explore the repo](https://github.com/vercel/sdk).  
[查看文档](https://vercel.com/docs/rest-api/sdk) 或 [浏览代码仓库](https://github.com/vercel/sdk)。