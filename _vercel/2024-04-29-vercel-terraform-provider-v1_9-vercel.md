---
render_with_liquid: false
title: "Vercel Terraform Provider v1.9 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-terraform-provider-v1-9"
date: "2024-04-29"
scraped_at: "2026-03-02T09:45:28.563071617+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Apr 29, 2024

2024 年 4 月 29 日

The [Vercel Terraform Provider](https://registry.terraform.io/providers/vercel/vercel/latest/docs) allows you to create, manage and update your Vercel projects, configuration, and settings through infrastructure-as-code.

[Vercel Terraform Provider](https://registry.terraform.io/providers/vercel/vercel/latest/docs) 允许你通过基础设施即代码（Infrastructure-as-Code）的方式创建、管理和更新 Vercel 项目、配置及设置。

You can now control significantly more Vercel resources through Terraform:

你现在可通过 Terraform 管控更多 Vercel 资源：

- Control whether custom production domains are automatically assigned  
- 控制是否自动分配自定义生产环境域名  

- Enable and disable [Git LFS](https://vercel.com/changelog/git-lfs-support) on a project  
- 在项目中启用或禁用 [Git LFS](https://vercel.com/changelog/git-lfs-support)  

- Configure [Automatic Function Failover](https://vercel.com/changelog/improved-resiliency-for-vercel-functions-with-failover-support)  
- 配置 [自动函数故障转移（Automatic Function Failover）](https://vercel.com/changelog/improved-resiliency-for-vercel-functions-with-failover-support)  

- Allow the [prioritization of production builds](https://vercel.com/docs/deployments/concurrent-builds#prioritize-production-builds) over preview builds  
- 允许 [优先构建生产环境部署](https://vercel.com/docs/deployments/concurrent-builds#prioritize-production-builds)，而非预览环境部署  

- Configure [Skew Protection](https://vercel.com/docs/deployments/skew-protection)  
- 配置 [偏移保护（Skew Protection）](https://vercel.com/docs/deployments/skew-protection)  

- Create and manage [Deploy Hooks](https://vercel.com/docs/deployments/deploy-hooks)  
- 创建并管理 [部署钩子（Deploy Hooks）](https://vercel.com/docs/deployments/deploy-hooks)  

- Enable and disable [Comments](https://vercel.com/docs/workflow-collaboration/comments) on preview deployments  
- 在预览部署中启用或禁用 [评论功能（Comments）](https://vercel.com/docs/workflow-collaboration/comments)

- Enable and disable [Git Comments](https://vercel.com/guides/how-to-prevent-vercel-github-comments) for a project  
- 为项目启用或禁用 [Git 评论](https://vercel.com/guides/how-to-prevent-vercel-github-comments)

- Set up and manage [Configurable Log Drains](https://vercel.com/guides/how-to-prevent-vercel-github-comments)  
- 设置和管理 [可配置的日志接收器（Log Drains）](https://vercel.com/guides/how-to-prevent-vercel-github-comments)

- Create and manage [Account Webhooks](https://vercel.com/docs/observability/webhooks-overview#account-webhooks)  
- 创建并管理 [账户级 Webhook](https://vercel.com/docs/observability/webhooks-overview#account-webhooks)

- Configure [Edge Config](https://vercel.com/docs/storage/edge-config) stores, schemas and access tokens.  
- 配置 [Edge Config](https://vercel.com/docs/storage/edge-config) 存储、模式（schemas）及访问令牌（access tokens）。

Learn how to get started with the [Terraform provider for Vercel](https://vercel.com/guides/integrating-terraform-with-vercel). If you already have Terraform set up, upgrade by running:  
了解如何开始使用 [Vercel 的 Terraform Provider](https://vercel.com/guides/integrating-terraform-with-vercel)。如果您已配置好 Terraform，请运行以下命令进行升级：

Bash  

```bash
terraform init -upgrade
```