---
title: "AWS Databases coming to the Vercel Marketplace - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/aws-databases-coming-to-the-vercel-marketplace"
date: "2025-12-01"
scraped_at: "2026-03-02T09:24:46.834813561+00:00"
language: "en-zh"
translated: true
description: "Vercel Marketplace adds Aurora PostgreSQL, Amazon DynamoDB, Aurora DSQL, available December 15. One-click provisioning, zero-config setup, and full v0 support."
---
{% raw %}

Dec 1, 2025

2025 年 12 月 1 日

We are expanding our partnership with AWS to make it faster for developers to build and scale with AWS infrastructure. On December 15th, Aurora PostgreSQL, Amazon DynamoDB, and Aurora DSQL will be available as native integrations in the [Vercel Marketplace](https://vercel.com/marketplace/aws).

我们正进一步深化与 AWS 的合作伙伴关系，助力开发者更快速地基于 AWS 基础设施构建和扩展应用。12 月 15 日起，Aurora PostgreSQL、Amazon DynamoDB 和 Aurora DSQL 将作为原生集成服务上线 [Vercel 商店（Marketplace）](https://vercel.com/marketplace/aws)。

These integrations bring the power and scalability of AWS databases directly into your Vercel workflow, so you can focus on shipping products, agents, and websites instead of configuring infrastructure.

这些集成将 AWS 数据库的强大性能与卓越可扩展性直接融入您的 Vercel 开发流程，让您专注于交付产品、智能体（agents）和网站，而非繁琐的基础设施配置。

## Expanding the Vercel and AWS partnership

## 拓展 Vercel 与 AWS 的合作伙伴关系

AWS databases power production applications at massive scale. With this integration, developers can provision and connect those same databases directly from your Vercel dashboard. Vercel handles credentials and environment variables automatically, so you select your database, connect it to your project, and start writing queries.

AWS 数据库为海量规模的生产级应用提供核心支撑。借助此次集成，开发者可直接通过 Vercel 控制台一键创建并连接这些数据库。Vercel 自动管理密钥凭证与环境变量——您只需选定数据库、将其关联至项目，即可立即开始编写查询语句。

v0 also fully supports these integrations, provisioning AWS databases automatically when your app needs them.

v0 同样全面支持上述集成，当您的应用需要时，可自动为您创建 AWS 数据库。

AWS has long been our preferred cloud provider. This launch extends our partnership to all developers building on Vercel.

AWS 长期以来都是我们的首选云服务提供商。本次发布将双方合作拓展至所有基于 Vercel 构建应用的开发者。

> “Our expanded partnership with AWS brings world-class database infrastructure directly into the Vercel developer experience. Together, we're helping developers build faster, with less friction, and with infrastructure that configures itself.”
>
> “我们与 AWS 深化合作，将世界级数据库基础设施直接融入 Vercel 开发者体验。双方携手，助力开发者更快构建应用、显著降低使用门槛，并实现基础设施的自动配置。”
>
> ![](images/aws-databases-coming-to-the-vercel-marketplace-vercel/img_001.jpg)
>
> **Tom Occhino,** Chief Product Officer
>
> **汤姆·奥基诺（Tom Occhino）**，首席产品官

## A faster path from idea to production

## 从创意到上线，速度再提速

With AWS databases integrated natively, you can go from concept to production in minutes.

AWS 数据库以原生方式深度集成后，您仅需数分钟即可完成从构想到上线的全过程。

- **One-click provisioning**: Choose Aurora PostgreSQL, Amazon DynamoDB, or Aurora DSQL from the Marketplace, select a region and plan, and create a database directly from your Vercel dashboard. New AWS customers can get started with a free starter plan and $100 in credits.

- **一键部署**：从 Marketplace 中选择 Aurora PostgreSQL、Amazon DynamoDB 或 Aurora DSQL，选定区域与套餐，即可直接通过 Vercel 控制台创建数据库。新 AWS 用户可免费使用入门级套餐，并获赠 100 美元额度。

- **Streamlined configuration**: Vercel automatically manages environment variables and connection details. No manual secrets or setup required.

- **简化配置流程**：Vercel 自动管理环境变量与连接信息，无需手动配置密钥或执行其他设置步骤。

- **Production-ready by default**: Each database runs on AWS infrastructure with the reliability, scalability, and security that AWS is known for.

- **开箱即用，面向生产环境**：每个数据库均运行于 AWS 基础设施之上，天然具备 AWS 所以闻名的高可靠性、可扩展性与安全性。

For when you need advanced configuration, there's also a button to open your database directly in the AWS console in a single click.

如需高级配置，还提供一键按钮，可直接在 AWS 控制台中打开您的数据库。

### v0 support on day one

### 首日即支持 v0

For [v0](https://v0.app/) users, database setup happens automatically. Describe your app, and v0 provisions the appropriate AWS database, creates the schema, and populates sample data so you can start building right away. The database shows up in your Storage tab like any other, ready to connect to additional projects or open in the AWS Console.

对于 [v0](https://v0.app/) 用户，数据库配置将自动完成。您只需描述应用需求，v0 即会为您部署合适的 AWS 数据库、创建数据表结构，并填充示例数据，助您立即投入开发。该数据库将像其他存储资源一样显示在您的“Storage（存储）”标签页中，随时可用于连接其他项目，或一键跳转至 AWS 控制台进行管理。

## Built for self-driving infrastructure

## 专为“自动驾驶式基础设施”而构建

This launch builds on our vision for [self-driving infrastructure](https://vercel.com/blog/self-driving-infrastructure): infrastructure that configures, scales, and optimizes itself based on developer intent. You express what you need, and the platform handles provisioning, securing, and optimizing everything underneath.

本次发布延续了我们对 [“自动驾驶式基础设施”](https://vercel.com/blog/self-driving-infrastructure) 的构想：一种能依据开发者意图自动完成配置、弹性伸缩与性能优化的基础设施。您只需声明所需能力，平台便会自动完成底层资源的部署、安全加固与持续优化。

By combining AWS’s proven cloud services with the Vercel developer experience, teams can move faster than ever. From first commit to global scale without manual infrastructure management.

通过融合 AWS 经过验证的云服务与 Vercel 一流的开发者体验，团队开发效率将前所未有地提升——从首次提交代码，到实现全球规模部署，全程无需人工干预基础设施管理。

## Get started

## 立即开始

AWS 数据库将于 12 月 15 日上线 [Vercel Marketplace](https://vercel.com/marketplace/aws)。上线后：

1. 访问 [**Vercel Marketplace**](https://vercel.com/marketplace/category/database) **→ AWS**

2. 选择 **Aurora PostgreSQL、Amazon DynamoDB** 或 **Aurora DSQL**

3. 选择您的区域和套餐（包括面向新 AWS 客户的免费入门套餐，含 100 美元额度）

4. 将其连接至您的项目。Vercel 将自动处理凭据与配置


如果您正在使用 [v0](https://v0.app/)，只需描述您的应用需求。v0 将自动生成前端、后端以及 AWS 数据库。
{% endraw %}
