---
render_with_liquid: false
title: "AWS databases are now live on the Vercel Marketplace and v0 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/aws-databases-are-now-live-on-the-vercel-marketplace-and-v0"
date: "2026-01-15"
scraped_at: "2026-03-02T09:22:42.596787936+00:00"
language: "en-zh"
translated: true
description: "v0 can now provision AWS databases as it builds your app. Aurora PostgreSQL, DynamoDB, and Aurora DSQL available in the Vercel Marketplace."
---
render_with_liquid: false
render_with_liquid: false

Jan 15, 2026

2026 年 1 月 15 日

[AWS databases](https://vercel.com/marketplace/aws) are now available in the [Vercel Marketplace](https://vercel.com/marketplace) and [v0](https://v0.app/).

[AWS 数据库](https://vercel.com/marketplace/aws) 现已上线 [Vercel Marketplace](https://vercel.com/marketplace) 和 [v0](https://v0.app/)。

Starting today, developers can provision **Aurora PostgreSQL**, **Amazon DynamoDB**, and **Aurora DSQL** directly from the Vercel dashboard with a guided setup flow and automatic project configuration. v0 can also create and connect AWS accounts and databases to your project as it builds.

即日起，开发者可通过 Vercel 控制台，借助引导式配置流程与自动项目配置，直接开通 **Aurora PostgreSQL**、**Amazon DynamoDB** 和 **Aurora DSQL**。在构建过程中，v0 还可为您创建并关联 AWS 账户及数据库至您的项目。

AWS databases run some of the world's largest applications. This launch brings AWS data infrastructure into the Vercel developer experience, so you can set up a production database without manual IAM setup, credential wiring, or switching between consoles. New AWS teams can [get started with a free starter plan and $100 in credits](https://vercel.com/marketplace/aws).

AWS 数据库支撑着全球规模最大的部分应用。本次发布将 AWS 数据基础设施深度集成进 Vercel 开发者体验，让您无需手动配置 IAM 权限、无需繁琐绑定密钥凭证、也无需在多个控制台间来回切换，即可快速搭建生产级数据库。新注册的 AWS 团队可[免费试用入门套餐，并获赠 $100 信用额度](https://vercel.com/marketplace/aws)。

## Built on AWS, optimized for speed

## 基于 AWS 构建，专为极致性能优化

Vercel runs on AWS infrastructure. Your functions and your database are in the same data centers, which means latency stays low.

Vercel 运行于 AWS 基础设施之上。您的函数与数据库位于同一数据中心，从而确保极低延迟。

We tested 50 sequential database round trips across different providers:

我们针对不同服务商，测试了连续 50 次数据库往返请求（round trip）的耗时表现：

|     |     |     |
| --- | --- | --- |
| **Provider** | **50 round trips (mean)** | **Per round trip** |
| **服务商** | **50 次往返（平均耗时）** | **单次往返耗时** |
| AWS RDS (Aurora) | 64ms | ~1ms |
| AWS RDS（Aurora） | 64 毫秒 | 约 1 毫秒 |
| Provider B | 109ms | ~2ms |
| 服务商 B | 109 毫秒 | 约 2 毫秒 |
| Provider C | 150ms | ~3ms |
| 服务商 C | 150 毫秒 | 约 3 毫秒 |

Same workload, same Vercel functions. AWS RDS is the fastest by a wide margin because there's no network hop between your code and your data. Best of performance, now with the best of DX.

相同工作负载，相同 Vercel 函数。AWS RDS 凭借代码与数据之间零网络跳转的优势，以显著差距成为最快选项。卓越性能，现已融合卓越的开发者体验（DX）。

## Get started with v0 in seconds

## 数秒内快速上手 v0

Tell v0 to use AWS databases while you build, and it provisions the database, creates, or links your AWS account, and configures the connection. You go from prompt to working app with a production database in minutes.

在开发过程中，指示 v0 使用 AWS 数据库；v0 将自动配置数据库、创建或关联您的 AWS 账户，并完成连接配置。您只需输入一个提示词，几分钟内即可获得一个已接入生产级数据库的可运行应用。

To get started on v0, try this prompt to see it in action:

要在 v0 上快速上手，请尝试以下提示词，亲身体验其能力：

[Build me an internal employee dashboard for tracking contractor hours with an AWS Database](https://v0.dev/chat?q=Build+me+an+internal+employee+dashboard+for+tracking+contractor+hours+with+an+AWS+Database)

![Prompt v0 to build your app and AWS provisions the database automatically](images/aws-databases-are-now-live-on-the-vercel-marketplace-and-v0-vercel/img_001.jpg)![Prompt v0 to build your app and AWS provisions the database automatically](images/aws-databases-are-now-live-on-the-vercel-marketplace-and-v0-vercel/img_002.jpg)Prompt v0 to build your app and AWS provisions the database automatically

![提示 v0 构建您的应用，AWS 自动配置数据库](images/aws-databases-are-now-live-on-the-vercel-marketplace-and-v0-vercel/img_001.jpg)![提示 v0 构建您的应用，AWS 自动配置数据库](images/aws-databases-are-now-live-on-the-vercel-marketplace-and-v0-vercel/img_002.jpg)提示 v0 构建您的应用，AWS 自动配置数据库

This is a milestone for both platforms. AWS infrastructure is now accessible to more builders, including designers prototyping full-stack apps, founders validating ideas, and developers who want production databases without learning IAM policies. You describe what you're building, and v0 handles the AWS setup.

这是两大平台共同迎来的重要里程碑。如今，AWS 基础设施向更广泛的构建者开放——包括正在原型化全栈应用的设计师、验证产品创意的创始人，以及希望直接使用生产级数据库却无需学习 IAM 权限策略的开发者。您只需描述要构建什么，v0 即可代为完成全部 AWS 配置。

## Connect AWS databases through the Marketplace

## 通过 Marketplace 连接 AWS 数据库

For existing projects or teams that want more control over provisioning, you can add AWS databases directly from the Vercel Marketplace. There are two paths, depending on whether you have an existing AWS account.

对于已有项目或希望自主掌控资源供给流程的团队，您可直接从 Vercel Marketplace 添加 AWS 数据库。具体路径取决于您是否已拥有 AWS 账户。

![](images/aws-databases-are-now-live-on-the-vercel-marketplace-and-v0-vercel/img_003.jpg)![](images/aws-databases-are-now-live-on-the-vercel-marketplace-and-v0-vercel/img_004.jpg)

### New AWS teams: create an AWS account

### 新 AWS 团队：创建 AWS 账户

If you don't already have an AWS account or prefer a simplified setup, you can provision a database in one click from the Vercel dashboard. Choose **Aurora PostgreSQL**, **Amazon DynamoDB**, or **Aurora DSQL**, select your region and plan, and Vercel handles the rest.

若您尚未拥有 AWS 账户，或倾向采用更简化的配置方式，您可通过 Vercel 控制台一键完成数据库供给。请选择 **Aurora PostgreSQL**、**Amazon DynamoDB** 或 **Aurora DSQL**，再指定地域与套餐方案，其余工作均由 Vercel 全权处理。

This flow works well for teams that want a fully managed experience without touching the AWS console.

此流程非常适合希望获得完全托管体验、且无需接触 AWS 控制台的团队。

To get started:

开始使用：

1. Navigate to the **Vercel Marketplace →** [**AWS**](https://vercel.com/marketplace/aws)

1. 访问 **Vercel Marketplace →** [**AWS**](https://vercel.com/marketplace/aws)

2. Select **Create new** (Vercel-managed account)

2. 选择 **Create new**（由 Vercel 托管的账户）

3. Choose **Aurora PostgreSQL**, **Aurora DSQL**, or **Amazon DynamoDB**

3. 选择 **Aurora PostgreSQL**、**Aurora DSQL** 或 **Amazon DynamoDB**

4. Pick your AWS region and plan

4. 选择您的 AWS 区域和套餐方案

5. Connect the resource to your project. Vercel automatically injects environment variables and configuration

5. 将该资源连接至您的项目。Vercel 将自动注入环境变量与配置。

### Existing AWS teams: link your AWS account

### 已使用 AWS 的团队：关联您的 AWS 账户

If your team already manages AWS infrastructure, you can connect your own account using [AWS IAM temporary delegation permissions](https://aws.amazon.com/about-aws/whats-new/2025/11/streamline-integration-partner-products-iam-delegation/). This lets you create AWS resources on Vercel and connect them to your projects while keeping your existing AWS setup.

如果您的团队已在管理 AWS 基础设施，您可使用 [AWS IAM 临时委托权限](https://aws.amazon.com/about-aws/whats-new/2025/11/streamline-integration-partner-products-iam-delegation/) 关联您自己的 AWS 账户。这使您能够在 Vercel 上创建 AWS 资源，并将其连接至您的项目，同时保留现有的 AWS 配置。

**To install databases using your existing AWS account:**

**使用您现有的 AWS 账户安装数据库：**

1. 导航至 **Vercel Marketplace →** [**AWS**](https://vercel.com/marketplace/aws)

1. 导航至 **Vercel Marketplace →** [**AWS**](https://vercel.com/marketplace/aws)

2. 选择 **关联现有 AWS 账户**

2. Select **Link an existing AWS account**

3. 授予 Vercel 临时权限，然后点击 **允许访问**

3. Grant temporary permissions to Vercel and click **Allow Access**

4. 您将被重定向回 Vercel

4. You'll be redirected back to Vercel

5. 选择 **Aurora PostgreSQL**、**Aurora DSQL** 或 **Amazon DynamoDB**

5. Choose **Aurora PostgreSQL**, **Aurora DSQL**, or **Amazon DynamoDB**

6. 选择您的 AWS 区域和套餐，然后创建数据库

6. Pick your AWS region and plan, then create a database

7. 将该资源连接到您的项目。Vercel 会自动注入环境变量和配置

7. Connect the resource to your project. Vercel automatically injects environment variables and configuration


## 当前可通过 AWS 集成实现的功能

## What you can do with AWS integrations today

无论您使用 v0 还是 Marketplace，该集成均支持以下功能：

Whether you use v0 or the Marketplace, the integration allows you to:

- 在任意受支持的 AWS 区域中部署 **Aurora PostgreSQL**、**Aurora DSQL** 或 **Amazon DynamoDB**

- Provision **Aurora PostgreSQL**, **Aurora DSQL**, or **Amazon DynamoDB** in any supported AWS region

- Inject connection credentials into your Vercel project as environment variables  
- 将连接凭据作为环境变量注入您的 Vercel 项目中

- Manage resource lifecycle from Vercel, including teardown  
- 在 Vercel 中统一管理资源的生命周期（包括资源销毁）

- Open the resource in the AWS Console when deeper configuration is needed  
- 当需要更深入的配置时，在 AWS 控制台中打开该资源

- Use AWS-native scaling and durability features without manual setup  
- 无需手动配置，即可直接使用 AWS 原生的弹性伸缩与数据持久化功能

Your database shows up in the Storage tab like any other resource. This gives you a unified view of your application's data layer across providers.  
您的数据库会像其他资源一样显示在 “Storage”（存储）标签页中。这为您提供了跨云服务商的一致性视图，全面掌握应用的数据层。

Once connected, querying your database is straightforward:  
连接成功后，查询数据库非常简单：

app/api/todos/route.ts

```tsx
import { pool } from '@/lib/postgres'
```

4  return Response.json(pool.query("select * from todos"));

5}


```

Query a database

查询数据库

The database client uses Vercel's OIDC integration to assume your AWS role and generate IAM auth tokens on each connection. There are no stored database passwords:

数据库客户端利用 Vercel 的 OIDC 集成来代入您的 AWS 角色，并在每次连接时生成 IAM 认证令牌。数据库密码不会被存储：

lib/postgres.ts

```tsx
import { Signer } from "@aws-sdk/rds-signer";

import { awsCredentialsProvider } from "@vercel/functions/oidc";

import { attachDatabasePool } from "@vercel/functions";

import { Pool } from "pg";

```javascript
const signer = new Signer({

7  hostname: process.env.PGHOST,

8  port: Number(process.env.PGPORT),

9  username: process.env.PGUSER,

10  region: process.env.AWS_REGION,

11  credentials: awsCredentialsProvider({

12    roleArn: process.env.AWS_ROLE_ARN,

13    clientConfig: { region: process.env.AWS_REGION },

14  }),
```

```javascript
const signer = new Signer({

7  hostname: process.env.PGHOST,

8  端口: Number(process.env.PGPORT),

9  用户名: process.env.PGUSER,

10  区域: process.env.AWS_REGION,

11  凭据: awsCredentialsProvider({

12    角色ARN: process.env.AWS_ROLE_ARN,

13    客户端配置: { region: process.env.AWS_REGION },

14  }),
```

```javascript
15});
```

```javascript
15});
```

```javascript
export const pool = new Pool({
```

```javascript
export const pool = new Pool({
```

```javascript
18  host: process.env.PGHOST,
```

```javascript
18  host: process.env.PGHOST,
```

```javascript
19  user: process.env.PGUSER,
```

```javascript
19  user: process.env.PGUSER,
```

```javascript
20  database: process.env.PGDATABASE || "postgres",
```

```javascript
20  database: process.env.PGDATABASE || "postgres",
```

```javascript
21  password: () => signer.getAuthToken(),
```

```javascript
21  password: () => signer.getAuthToken(),
```

```javascript
22  port: Number(process.env.PGPORT),
```

```javascript
22  port: Number(process.env.PGPORT),
```

```javascript
23  ssl: { rejectUnauthorized: false },
```

```javascript
23  ssl: { rejectUnauthorized: false },
```

```javascript
24});
```

```javascript
24});
```

attachDatabasePool(pool);


```

Setup a database client

设置数据库客户端

From here, you're writing application code. Your credentials are injected, your auth tokens are handled, and your connection pool is configured for serverless. The setup that usually comes before building is already behind you.

从此，您即可开始编写应用程序代码。您的凭据将被自动注入，身份验证令牌由系统统一管理，连接池也已为无服务器（serverless）环境完成配置。通常在开发前需要完成的初始化工作，如今已全部为您预先完成。

## The foundation for self-driving infrastructure

## 自动化基础设施的基石

This launch is a meaningful step in our [broader vision for self-driving infrastructure](https://vercel.com/blog/self-driving-infrastructure). As the platform continues evolving, developers will spend less time configuring systems and more time building products.

本次发布是我们[面向自动化基础设施的更宏大愿景](https://vercel.com/blog/self-driving-infrastructure)中具有重要意义的一步。随着平台持续演进，开发者将减少在系统配置上耗费的时间，转而将更多精力投入产品构建。

By combining AWS reliability and scale with the Vercel developer experience, teams can move from idea to production faster, with fewer operational decisions to manage.

通过融合 AWS 的高可靠性与大规模扩展能力，以及 Vercel 一流的开发者体验，团队能够更快地将创意转化为生产应用，同时需管理的运维决策也显著减少。

To get started, install AWS databases from the [Vercel Marketplace](https://vercel.com/marketplace/aws), ask [v0](https://v0.app/) to build an app using AWS databases, or deploy the [Movie Fetching Database](https://vercel.com/templates/next.js/next-js-vercel-app-with-aurora-dsql) template to see the integration in action.

立即开始：请从 [Vercel Marketplace](https://vercel.com/marketplace/aws) 安装 AWS 数据库服务；或请 [v0](https://v0.app/) 基于 AWS 数据库为您生成一个应用；亦可部署 [Movie Fetching Database](https://vercel.com/templates/next.js/next-js-vercel-app-with-aurora-dsql) 模板，亲身体验该集成的实际效果。