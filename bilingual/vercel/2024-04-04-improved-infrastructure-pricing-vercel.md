---
title: "Improved infrastructure pricing - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/improved-infrastructure-pricing"
date: "2024-04-04"
scraped_at: "2026-03-03T07:10:45.632660403+00:00"
language: "en-zh"
translated: true
description: "We're reducing pricing on Vercel fundamentals like bandwidth and functions."
---

Apr 4, 2024

2024 年 4 月 4 日

Hobby 计划继续保持免费；Pro 计划下调了带宽与函数的资费，并为所有套餐提供更精细的用量指标。

根据您的反馈，我们正在更新基础设施产品的用量计量与计费方式。

- 我们将**降低 Vercel 核心服务（如带宽和函数）的定价**

- 对绝大多数客户而言，每月账单金额将**保持不变或有所下降**

- 我们将引入**新的基础计量单元（primitives）**，以便更轻松地进行用量优化

- 您现在可**按实际使用量、以更精细的粒度精确付费**

- 我们的 **Hobby 套餐继续保持免费**

[这些变更](https://vercel.com/pricing/coming-soon) 将体现在您 2024 年 6 月 25 日至 7 月 24 日之间的首张账单中。有关账户后续操作步骤的邮件将发送给账户所有者。

## 哪些内容发生了变化？为何做出这些调整？

Instead of two large, combined metrics (bandwidth and functions), you will now have granular pricing which allows you to optimize each metric individually.

不再采用带宽与函数两大合并计费指标，您现在将享有更精细的分项计价模式，从而可针对每一项指标单独进行成本优化。

|  | Before（此前） | After（此后） |
| --- | --- | --- |
| Bandwidth（带宽） | $0.40/GB | [**Fast Data Transfer**](https://vercel.com/docs/pricing/networking#fast-data-transfer) **：** $0.15/GB¹ **（降幅 62%）**<br>[**Fast Origin Transfer**](https://vercel.com/docs/pricing/networking#fast-origin-transfer) **：** $0.06/GB¹ |
| Functions（函数） | $0.40/GB-hr | [**Function Invocations**](https://vercel.com/docs/pricing/serverless-functions) **：** $0.60/百万次调用<br>[**Function Duration**](https://vercel.com/docs/pricing/serverless-functions) **：** $0.18/GB-hr **（降幅 55%）** |
| Edge Network Routing（边缘网络路由） | Included in Bandwidth（已包含在带宽费用中） | [**Edge Requests**](https://vercel.com/docs/pricing/networking#edge-requests) **：** $2.00/百万次请求¹ |
| Incremental Static Regeneration（增量静态再生） | Included in Bandwidth（已包含在带宽费用中） | [**Data Cache Reads**](https://vercel.com/docs/pricing/data-cache) **：** $0.40/百万次读取<br>[**Data Cache Writes**](https://vercel.com/docs/pricing/data-cache) **：** $4.00/百万次写入 |

_¹ 针对大部分流量的定价；实际费用将_ [_因区域而异_](https://vercel.com/docs/pricing#regional-pricing)

Our updated pricing is more aligned with industry standards and a better representation of the work Vercel is doing for you, rather than bundling together in bandwidth and function metrics.

我们更新后的定价方案更贴近行业通用标准，也更真实地反映了 Vercel 为您所承担的实际工作量，而非简单地将各类资源消耗捆绑进“带宽”和“函数”两大笼统指标中。

In addition, over the past year we've added features to the platform to help automatically prevent runaway spend, including [hard spend limits](https://vercel.com/changelog/improved-hard-caps-for-spend-management), [recursion protection](https://vercel.com/changelog/automatic-recursion-protection-for-vercel-serverless-functions), [improved function defaults](https://vercel.com/changelog/serverless-functions-can-now-run-up-to-5-minutes), [Attack Challenge Mode](https://vercel.com/changelog/prevent-malicious-traffic-with-attack-challenge-mode-for-vercel-firewall), and more.

此外，过去一年中，我们已在平台中陆续上线多项功能，以自动防止费用失控，包括：[硬性支出上限](https://vercel.com/changelog/improved-hard-caps-for-spend-management)、[递归调用防护机制](https://vercel.com/changelog/automatic-recursion-protection-for-vercel-serverless-functions)、[优化的函数默认配置](https://vercel.com/changelog/serverless-functions-can-now-run-up-to-5-minutes)（支持最长运行 5 分钟）、[攻击挑战模式](https://vercel.com/changelog/prevent-malicious-traffic-with-attack-challenge-mode-for-vercel-firewall)（用于 Vercel 防火墙拦截恶意流量），以及更多功能。

For our Enterprise customers, existing contracts are unaffected. Please reach out to your account team if you have any questions or want to discuss these changes.

对于企业客户，现有合同条款保持不变。如您有任何疑问，或希望就本次调整展开进一步沟通，请随时联系您的客户成功团队。

![Visualize how our more granular infrastructure metrics are accrued. ](images/improved-infrastructure-pricing-vercel/img_001.jpg)![Visualize how our more granular infrastructure metrics are accrued. ](images/improved-infrastructure-pricing-vercel/img_002.jpg)可视化展示我们更精细化的基础设施计量方式是如何累积产生的。

## Frequently Asked Questions

## 常见问题解答（FAQ）

Will my monthly bill increase?

我的月度账单会增加吗？

When do these changes go live?

本次价格调整何时生效？

Can you share a before and after pricing example?

您能否提供一个调价前后的价格示例？

Where can I learn more about the new metrics?

我可以在哪里了解更多关于新指标的信息？

Is anything changing about our open source plan?

我们的开源计划是否有任何变动？

What is Vercel's commitment to the free tier?

Vercel 对免费套餐的承诺是什么？

Do cached responses affect usage?

缓存响应是否会影响用量统计？

How can I manage my spend?

我该如何管理我的支出？

What is regional pricing?

什么是区域定价？