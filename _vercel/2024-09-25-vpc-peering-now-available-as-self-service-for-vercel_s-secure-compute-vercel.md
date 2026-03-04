---
title: "VPC Peering now available as self-service for Vercel’s Secure Compute - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vpc-peering-now-available-as-self-service-for-vercel-secure-compute"
date: "2024-09-25"
scraped_at: "2026-03-02T09:40:55.829663258+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
&#123;% raw %}

Sep 25, 2024

2024 年 9 月 25 日

![](images/vpc-peering-now-available-as-self-service-for-vercel_s-secure-compute-vercel/img_001.jpg)![](images/vpc-peering-now-available-as-self-service-for-vercel_s-secure-compute-vercel/img_002.jpg)

我们对 Secure Compute 进行了重大升级，现已为 Enterprise（企业版）客户推出自助式功能，并进一步提升了 Secure Compute 网络的灵活性与管控能力。

主要更新包括：

- **VPC 对等连接（VPC Peering）管理**：用户可直接从 AWS 发起 VPC 对等连接，并在 Vercel 控制台中一键接受；待审批的连接请求将在控制台中清晰列出，便于审核与批准。

- **故障转移区域（Failover Regions）配置**：现在可在控制台中配置故障转移区域。当主用区域不可用时，Vercel 将自动切换至故障转移区域中的网络。

- **网络管理界面优化**：全新“网络”页面提供更详尽的信息展示与配置能力，涵盖对等连接、IP 地址分配及关联项目等。

本次更新大幅简化了网络管理流程，同时强化了 Vercel 与 AWS 环境之间安全、自主的连接能力。欢迎查阅 [相关文档](https://vercel.com/docs/security/secure-compute#vercel-secure-compute) 了解详情。
&#123;% endraw %}
