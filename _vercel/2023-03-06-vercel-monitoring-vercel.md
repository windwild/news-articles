---
title: "Vercel Monitoring - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-monitoring"
date: "2023-03-06"
scraped_at: "2026-03-02T09:54:00.014023978+00:00"
language: "en-zh"
translated: true
description: "Vercel Monitoring"
---

Mar 6, 2023

2023 年 3 月 6 日

可视化、诊断并优化您的网站。

我们很高兴向大家介绍可观测性套件（observability suite）的几项新功能：**监控（Monitoring）**现已面向 Pro 和 Enterprise 计划用户全面开放（Generally Available），而**日志（Logs）**功能则已对所有订阅计划的用户开放。这些工具使 Vercel 上的团队能够通过聚合的网页流量与性能数据视图，快速识别并解决潜在问题，防患于未然。

## Why Vercel Monitoring?

## 为何选择 Vercel 监控？

借助 Vercel 全新的 [监控（Monitoring）](https://vercel.com/docs/concepts/observability/monitoring) 功能，您可实时获取关键洞察，迅速定位生产环境中的问题，并显著提升优化 Web 应用性能的能力。

您可在 Vercel 控制台中轻松追踪并分析网站各部分的性能表现，从而快速识别性能瓶颈，并基于数据做出决策——进一步提升 Web 应用性能、优化成本支出、降低错误率。

## Data at your fingertips

## 数据触手可及

Vercel 为您提供及您的团队详尽的应用性能洞察，并支持通过 [运行时日志（Logs）](https://vercel.com/docs/concepts/observability/runtime-logs) 进行深度下钻分析。控制台内已预置多种常用查询示例，助您快速定位以下典型问题：

- 带宽与网页流量激增  
- 某一请求路径上的性能下降

- 500 错误，由某次特定部署引发  

- 由某次特定部署引发的 500 错误  

With these metrics at your fingertips you can identify and fix issues before your customers even notice.  

借助这些指标，您可在客户甚至尚未察觉之前，便及时发现并修复问题。  

> “We were able to use the Monitoring functionality in Vercel to quickly detect which bots were causing our issues and troubleshoot from there. We were able to use the Monitoring functionality in Vercel to quickly detect which bots were causing our issues and troubleshoot from there.”  
>  
> “我们借助 Vercel 的监控（Monitoring）功能，迅速定位了导致问题的爬虫（bots），并由此展开排查与故障诊断。”  
>  
> ![](images/vercel-monitoring-vercel/img_001.png)  
>  
> **Keystone Education**  
>  
> **Keystone 教育集团**  

The new Logs allow you to drill-down into errors and issues once they’ve been identified on production or pre-production on [Preview Deployments](https://vercel.com/docs/concepts/deployments/preview-deployments). And additionally, you can see past Logs by default to understand your history without having to reproduce issues. With these tools, you can quickly identify the root cause of persistent errors and customer issues, minimizing downtime and improving the overall performance of web applications.  

全新的日志（Logs）功能，让您在生产环境或预发布环境（例如 [预览部署（Preview Deployments）](https://vercel.com/docs/concepts/deployments/preview-deployments)）中发现问题后，深入追踪错误与异常的细节。此外，默认即可查看历史日志，无需复现问题即可全面了解系统运行轨迹。借助这些工具，您能快速定位持续性错误及用户问题的根本原因，最大限度减少服务中断时间，并全面提升 Web 应用的整体性能。  

![Quickly identify the root cause of persistent errors and customer issues with Logs.](images/vercel-monitoring-vercel/img_002.jpg)  
![通过日志（Logs）快速定位持续性错误及用户问题的根本原因。](images/vercel-monitoring-vercel/img_002.jpg)  

![Quickly identify the root cause of persistent errors and customer issues with Logs.](images/vercel-monitoring-vercel/img_003.jpg)  
![通过日志（Logs）快速定位持续性错误及用户问题的根本原因。](images/vercel-monitoring-vercel/img_003.jpg)  

Quickly identify the root cause of persistent errors and customer issues with Logs.  

通过日志（Logs）快速定位持续性错误及用户问题的根本原因。  

Create custom queries to gain greater, personalized insights into your data, further allowing your team to more efficiently debug issues and get proactive about optimizing projects. Or, easily integrate Vercel's tooling with your third-party monitoring tool with our enhanced [Log Drain](https://vercel.com/docs/concepts/observability/log-drains-overview/log-drains) capabilities.  

创建自定义查询，从数据中获取更深入、更个性化的洞察，进一步助力您的团队高效调试问题，并主动优化项目。或者，借助我们增强版的 [日志导出（Log Drain）](https://vercel.com/docs/concepts/observability/log-drains-overview/log-drains) 功能，轻松将 Vercel 工具链与您现有的第三方监控工具集成。  

With this suite of tools, get detailed insights into your application performance that work for you. Learn more about pricing for [Monitoring](https://vercel.com/docs/concepts/observability/monitoring/limits-and-pricing).  

借助这一整套工具，您将获得贴合自身需求的、详尽的应用性能洞察。了解更多关于 [监控（Monitoring）](https://vercel.com/docs/concepts/observability/monitoring/limits-and-pricing) 的定价信息。  

If you’re on a [Pro or Enterprise plan](https://vercel.com/pricing) you can get started with Monitoring today in the [dashboard](https://vercel.com/dashboard/monitoring) or check out the [documentation](https://vercel.com/docs/concepts/observability/monitoring/overview).  

若您已订阅 [Pro 或 Enterprise 套餐](https://vercel.com/pricing)，即刻前往 [仪表板（dashboard）](https://vercel.com/dashboard/monitoring) 开始使用监控（Monitoring）功能，或查阅 [相关文档](https://vercel.com/docs/concepts/observability/monitoring/overview)。