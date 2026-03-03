---
title: "Improved resiliency for Vercel Functions with inter-region failover support - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/improved-resiliency-for-vercel-functions-with-failover-support"
date: "2024-01-26"
scraped_at: "2026-03-02T09:48:14.951967874+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Jan 26, 2024

2024 年 1 月 26 日

![](images/improved-resiliency-for-vercel-functions-with-inter-region-failover-support-verc/img_001.jpg)![](images/improved-resiliency-for-vercel-functions-with-inter-region-failover-support-verc/img_002.jpg)

Vercel Functions can now [automatically failover to the next healthy region](https://vercel.com/docs/functions/configuring-functions/region#automatic-failover).

Vercel Functions 现在可[自动故障转移至下一个健康区域](https://vercel.com/docs/functions/configuring-functions/region#automatic-failover)。

Vercel's Edge Network is resilient to regional outages by automatically rerouting traffic to static assets. Vercel Functions also have multiple availability zone redundancy by default. We are now enhancing this further with support for multi-region redundancy for Functions.

Vercel 边缘网络具备抵御区域性中断的能力，可通过自动将流量重定向至静态资源实现高可用性。Vercel Functions 默认即具备多可用区冗余能力。现在，我们进一步增强该能力，为 Functions 新增多区域冗余支持。

In the instance of a regional outage, traffic directed towards your Vercel Function using the Node.js runtime will be automatically re-routed to the next healthy region, ensuring continuous service delivery and uptime without manual intervention.

当发生区域性中断时，发往您使用 Node.js 运行时的 Vercel Function 的流量将自动重定向至下一个健康区域，从而在无需人工干预的前提下保障服务持续交付与正常运行时间（uptime）。

Failover regions are also supported through [Vercel Secure Compute](https://vercel.com/docs/security/secure-compute), which allows you to create private connections between your databases and other private infrastructure.

故障转移区域同样受 [Vercel Secure Compute](https://vercel.com/docs/security/secure-compute) 支持，该功能允许您在数据库与其他私有基础设施之间建立私有连接。

You can configure which regions to failover to in your `vercel.json` file. For example, you might want to fallback to many different regions, or specific regions in a country.

您可在 `vercel.json` 文件中配置故障转移的目标区域。例如，您可能希望回退至多个不同区域，或某国境内的特定区域。

vercel.json

vercel.json

```json
1{

2  "functionFailoverRegions": ["iad1", "cle1"]
```

3}
```

在配置文件中定义您的备用区域。

在项目设置中，企业版团队可以启用此功能。如果您尚未使用企业版，请[联系我们](https://vercel.com/contact/sales)以升级并启用函数故障转移功能。