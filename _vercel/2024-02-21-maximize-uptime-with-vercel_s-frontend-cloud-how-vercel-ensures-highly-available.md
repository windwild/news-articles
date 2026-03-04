---
title: "Maximize Uptime with Vercel's Frontend Cloud: How Vercel ensures highly available, globally performant dynamic applications. Even during massive traffic spikes. - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/effortless-high-availability-for-dynamic-frontends"
date: "2024-02-21"
scraped_at: "2026-03-02T09:47:31.058396226+00:00"
language: "en-zh"
translated: true
description: "Vercel's Frontend Cloud is designed with high availability at its core, to maintain uptime for dynamic applications."
---

render_with_liquid: false
Feb 21, 2024

2024 年 2 月 21 日

Vercel’s multi-layered approach to frontend resiliency.

Vercel 前端弹性的多层架构方案。

Vercel’s Frontend Cloud is designed for high availability from the ground up, with robustness against large-scale regional cloud outages at every layer of our architecture.

Vercel 前端云从底层设计之初即以高可用性为目标，其架构的每一层均具备抵御大规模区域性云服务中断的能力。

This includes making it extraordinarily easy for our customers to run the compute they deploy to Vercel in the same highly resilient architecture. Concretely speaking, this can make the difference between downtime or smooth operation during major sales events such as Black Friday.

这包括让客户能极其便捷地将部署至 Vercel 的计算资源运行于同一套高度弹性的架构之中。具体而言，在“黑色星期五”等大型促销活动期间，这一能力往往决定了系统是陷入宕机，还是持续平稳运行。

![Every layer of Vercel's infrastructure is designed for high availability.](images/maximize-uptime-with-vercel_s-frontend-cloud-how-vercel-ensures-highly-available/img_001.jpg)![Every layer of Vercel's infrastructure is designed for high availability.](images/maximize-uptime-with-vercel_s-frontend-cloud-how-vercel-ensures-highly-available/img_002.jpg)![Every layer of Vercel's infrastructure is designed for high availability.](images/maximize-uptime-with-vercel_s-frontend-cloud-how-vercel-ensures-highly-available/img_003.jpg)![Every layer of Vercel's infrastructure is designed for high availability.](images/maximize-uptime-with-vercel_s-frontend-cloud-how-vercel-ensures-highly-available/img_004.jpg)Every layer of Vercel's infrastructure is designed for high availability.

![Vercel 基础设施的每一层均专为高可用性而设计。](images/maximize-uptime-with-vercel_s-frontend-cloud-how-vercel-ensures-highly-available/img_001.jpg)![Vercel 基础设施的每一层均专为高可用性而设计。](images/maximize-uptime-with-vercel_s-frontend-cloud-how-vercel-ensures-highly-available/img_002.jpg)![Vercel 基础设施的每一层均专为高可用性而设计。](images/maximize-uptime-with-vercel_s-frontend-cloud-how-vercel-ensures-highly-available/img_003.jpg)![Vercel 基础设施的每一层均专为高可用性而设计。](images/maximize-uptime-with-vercel_s-frontend-cloud-how-vercel-ensures-highly-available/img_004.jpg)Vercel 基础设施的每一层均专为高可用性而设计。

## Initiating at edge: Optimized global routing

## 边缘启动：优化的全球路由

Every user request on a Vercel-backed site initiates with our global anycast routing system, instantly connecting users to the nearest network edge. This ensures that traffic is efficiently directed to any of Vercel’s strategically located primary regions.

所有经 Vercel 托管的网站所接收的用户请求，均首先由我们的全球任播（anycast）路由系统处理，即时将用户连接至最近的网络边缘节点。此举确保流量可被高效调度至 Vercel 全球范围内任意一个战略性部署的核心区域。

Both of these layers are designed for robustness and high availability. Even if certain network components are temporarily offline, our system seamlessly reroutes users to the nearest operational region, maintaining consistent service without disruption.

上述两层架构均以强健性与高可用性为设计目标。即便某些网络组件临时离线，系统亦能无缝地将用户重定向至最近的正常运行区域，从而在无任何中断的前提下持续提供稳定服务。

For example, in the unlikely case that the data center in Frankfurt is separated from the internet through a fiber cut, traffic is redirected to Paris. And if Paris also has an issue, then traffic moves to London— [and so on.](https://vercel.com/docs/edge-network/regions#outage-resiliency)

例如，在极小概率事件下，若法兰克福数据中心因光缆中断而与互联网断连，流量将自动重定向至巴黎；倘若巴黎也发生故障，则流量进一步转移至伦敦——[依此类推。](https://vercel.com/docs/edge-network/regions#outage-resiliency)

## Highly available compute resources

## 高可用计算资源

While Vercel supports globally distributed [edge compute](https://vercel.com/docs/functions/edge-functions), it is common for Vercel customers to run their primary compute via [Vercel Functions](https://vercel.com/docs/functions/serverless-functions) in a single or a small number of regions. This makes a lot of sense when the backend such as a database, an API gateway, or a headless e-commerce platform uses that region as its primary location.

虽然 Vercel 支持全球分布式的 [边缘计算（edge compute）](https://vercel.com/docs/functions/edge-functions)，但 Vercel 客户通常选择在单个或少数几个区域中，通过 [Vercel Functions](https://vercel.com/docs/functions/serverless-functions) 运行其主要计算负载。当后端服务（例如数据库、API 网关或无头电商平台）将该区域作为其主部署位置时，这种架构设计非常合理。

## Multi-AZ and Multi-Region redundancy

## 多可用区（Multi-AZ）与多区域（Multi-Region）冗余

By default, Vercel Functions are deployed across multiple availability zones (AZs) within any given region, enhancing their availability. However, cross-AZ full-region outages can and [do very occasionally happen](https://www.thousandeyes.com/blog/aws-outage-analysis-june-13-2023). By activating [Function Failover](https://vercel.com/docs/functions/configuring-functions/region#automatic-failover) in the Vercel dashboard, customers can provision functions to be automatically deployed in a backup region. This active-passive setup ensures that function invocations are instantly redirected to the backup region during an incident, offering robust protection against full regional downtimes.

默认情况下，Vercel Functions 会在任一指定区域内跨多个可用区（Availability Zones, AZs）部署，从而提升其可用性。然而，跨可用区的全区域中断虽罕见，却确实可能发生——[例如 2023 年 6 月 13 日 AWS 的区域性中断事件](https://www.thousandeyes.com/blog/aws-outage-analysis-june-13-2023)。通过在 Vercel 控制台中启用 [函数故障转移（Function Failover）](https://vercel.com/docs/functions/configuring-functions/region#automatic-failover)，客户可配置函数自动部署至备用区域。这种主备（active-passive）架构可在发生故障时，立即将函数调用重定向至备用区域，从而为应对整个区域级宕机提供强有力的容灾保障。

Additionally, Vercel supports advanced configuration of multiple failover regions. This may be helpful if:

- Multiple primary regions are used  

- You desire precise control over the backup region.

此外，Vercel 还支持对多个故障转移区域进行高级配置。以下场景中该能力尤为有用：

- 同时使用多个主区域；  
- 您需要对备用区域实施精确控制。

Precise backup region control could be required if:

- Your backend has a backup region, and you want to pair the frontend compute with that specific region.

- To ensure compliance with data residency laws (e.g., ensure that both primary and backup regions are in the European Union).

对备用区域实施精确控制的需求可能源于：

- 您的后端已设有特定备用区域，您希望前端计算也与该区域配对部署；  
- 为满足数据驻留（data residency）合规要求（例如：确保主区域与备用区域均位于欧盟境内）。

## Simplified backend failover protection with Edge Config

## 借助 Edge Config 简化后端故障转移保护

The final key technology for highly available frontends is [Vercel’s Edge Config](https://vercel.com/docs/storage/edge-config). Edge Config allows pushing configuration updates to your global compute fleet with minimal latency and, importantly, without requiring redeployment. It’s the ideal primitive to failover your application to a backup system.

面向高可用前端的最终关键技术是 [Vercel 的 Edge Config（边缘配置）](https://vercel.com/docs/storage/edge-config)。Edge Config 可将配置更新快速推送至您的全球计算节点集群，延迟极低；更重要的是，整个过程无需重新部署。它是实现应用故障转移至备用系统的理想基础能力。

For example, if your primary database has an outage and you are failing over to a read replica, you can use Edge Config to quickly re-route your compute to use the new database address. Similarly, if your headless e-commerce or CMS vendor has a regional outage, you can re-route your compute to its backup location.

例如，当您的主数据库发生宕机、需切换至只读副本时，即可通过 Edge Config 快速重定向计算流量，使其指向新的数据库地址。同理，若您所使用的无头电商或 CMS 服务商在某一区域出现服务中断，您也可借助 Edge Config 将计算流量切换至其备用区域。

[**Learn about security at scale.**\\
\\
We'll discuss the most secure way to deploy your application.\\
\\
Contact Sales](https://vercel.com/contact/sales/security)

[**了解大规模环境下的安全实践。**\\
\\
我们将探讨部署应用最安全的方式。\\
\\
联系销售团队](https://vercel.com/contact/sales/security)

Highly available multi-region cloud infrastructure can be difficult to set up and expensive to maintain. With Vercel, this resiliency comes without additional configuration or maintenance overhead.

构建高可用的多区域云基础设施通常既复杂又昂贵。而使用 Vercel，您可零配置、零运维负担地获得同等弹性与韧性。

Vercel.com landing page

Vercel.com 官网落地页

### Fully-managed infrastructure.

### 全托管式基础设施

Vercel.com landing page

Vercel.com 官网落地页

### See for yourself

### 亲身体验