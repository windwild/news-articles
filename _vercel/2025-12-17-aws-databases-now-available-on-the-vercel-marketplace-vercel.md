---
title: "AWS databases now available on the Vercel Marketplace - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/aws-databases-now-available-on-the-vercel-marketplace"
date: "2025-12-17"
scraped_at: "2026-03-02T09:23:40.246774637+00:00"
language: "en-zh"
translated: true
description: "AWS Databases Now Available on the Vercel Marketplace with their AWS Aurora PostgreSQL, Amazon DynamoDB, and Aurora DSQL "
---

Dec 17, 2025

2025年12月17日

![](images/aws-databases-now-available-on-the-vercel-marketplace-vercel/img_001.jpg)![](images/aws-databases-now-available-on-the-vercel-marketplace-vercel/img_002.jpg)

Today we’re introducing native support for [AWS](https://vercel.com/marketplace/aws) databases including Amazon Aurora PostgreSQL, Amazon Aurora DSQL, and Amazon DynamoDB on the [Vercel Marketplace](https://vercel.com/marketplace/category/database).

今天我们正式在 [Vercel Marketplace](https://vercel.com/marketplace/category/database) 上推出对 [AWS](https://vercel.com/marketplace/aws) 数据库的原生支持，涵盖 Amazon Aurora PostgreSQL、Amazon Aurora DSQL 和 Amazon DynamoDB。

This gives developers a direct path to provision and manage scalable, production-ready AWS databases from within the Vercel dashboard with no manual setup required, and:

这为开发者提供了直接在 Vercel 控制台内配置与管理可扩展、可用于生产环境的 AWS 数据库的一站式路径，全程无需手动配置，并具备以下特性：

- **One-click support** for creating a new AWS account, provisioning new AWS databases and linking them to your Vercel projects.

- **一键式支持**：创建新的 AWS 账户、部署新的 AWS 数据库，并将其关联至您的 Vercel 项目。

- **Improved developer experience** with simplified region selection, secure credential handling, and unified monitoring of AWS database resources from Vercel.

- **更优的开发者体验**：简化区域（Region）选择流程、安全地管理凭据，并通过 Vercel 统一监控所有 AWS 数据库资源。

- **Automatic environment variable** for connection strings and credentials, securely stored within your Vercel project.

- **自动注入环境变量**：连接字符串与凭据将作为环境变量自动生成并安全存储于您的 Vercel 项目中。

- **Free starter plan** for new AWS customers, including **$100 in credits**, with deep links to manage or upgrade plans in the AWS console.

- **新用户免费入门计划**：面向首次注册 AWS 的用户，包含 **100 美元额度**，并提供深度链接，可直接跳转至 AWS 控制台进行套餐管理或升级。

- **And coming soon:** Provision databases into your existing AWS account, attach them to your projects, and access AWS databases directly inside [v0](https://v0.app/).

- **即将上线**：将数据库部署至您已有的 AWS 账户、将其绑定至您的项目，并在 [v0](https://v0.app/) 中直接访问 AWS 数据库。

lib/postgres.ts

`lib/postgres.ts`

```tsx
import { Signer } from "@aws-sdk/rds-signer";

import { awsCredentialsProvider } from "@vercel/functions/oidc";

import { attachDatabasePool } from "@vercel/functions";

import { Pool } from "pg";



const signer = new Signer({

7  hostname: process.env.PGHOST,

8  port: Number(process.env.PGPORT),

9  username: process.env.PGUSER,

10  region: process.env.AWS_REGION,
```

```tsx
import { Signer } from "@aws-sdk/rds-signer";

import { awsCredentialsProvider } from "@vercel/functions/oidc";

import { attachDatabasePool } from "@vercel/functions";

import { Pool } from "pg";



const signer = new Signer({

7  hostname: process.env.PGHOST,

8  port: Number(process.env.PGPORT),

9  username: process.env.PGUSER,

10  region: process.env.AWS_REGION,
```

```markdown
11  credentials: awsCredentialsProvider({

11  credentials: awsCredentialsProvider({

12    roleArn: process.env.AWS_ROLE_ARN,

12    roleArn: process.env.AWS_ROLE_ARN,

13    clientConfig: { region: process.env.AWS_REGION },

13    clientConfig: { region: process.env.AWS_REGION },

14  }),

14  }),

15});



15});



export const pool = new Pool({

export const pool = new Pool({

18  host: process.env.PGHOST,

18  host: process.env.PGHOST,

19  user: process.env.PGUSER,

19  user: process.env.PGUSER,

20  database: process.env.PGDATABASE || "postgres",

20  database: process.env.PGDATABASE || "postgres",
```

21  password: () => signer.getAuthToken(),

21  密码：() => signer.getAuthToken(),

22  port: Number(process.env.PGPORT),

22  端口：Number(process.env.PGPORT),

23  ssl: { rejectUnauthorized: false },

23  SSL：{ rejectUnauthorized: false },

24});

24});

attachDatabasePool(pool);

attachDatabasePool(pool);


```

```

Setup a database client

设置数据库客户端

### **Getting started**

### **入门指南**

1. Navigate to the [Vercel Marketplace](https://vercel.com/marketplace) and select [**AWS**](https://vercel.com/marketplace/aws)

1. 访问 [Vercel Marketplace](https://vercel.com/marketplace)，然后选择 [**AWS**](https://vercel.com/marketplace/aws)

2. Choose **Create new** account to provision a database

2. 选择 **Create new**（新建）账户以创建数据库

3. Select your database type, region, and plan (including a free starter plan with $100 in credits for new AWS customers) and hit create

3. 选择您的数据库类型、所在区域和套餐（包括面向新 AWS 客户的免费入门套餐，含 100 美元额度）；然后点击“创建”。

4. Connect it to your project. Vercel automatically handles credentials and configuration

4. 将其连接至您的项目。Vercel 会自动处理凭据与配置。

You can also try a working example by deploying the [Movie Fetching Database](https://vercel.com/templates/next.js/next-js-vercel-app-with-aurora-postgresql) template to see the integration end-to-end.

您还可以通过部署 [电影数据获取数据库](https://vercel.com/templates/next.js/next-js-vercel-app-with-aurora-postgresql) 模板来尝试一个可运行的示例，从而端到端地体验该集成效果。