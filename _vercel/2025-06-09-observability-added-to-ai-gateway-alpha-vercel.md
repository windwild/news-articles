---
title: "Observability added to AI Gateway alpha - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/observability-added-to-ai-gateway-alpha"
date: "2025-06-09"
scraped_at: "2026-03-02T09:32:55.915979039+00:00"
language: "en-zh"
translated: true
description: "Vercel Observability now includes a dedicated AI section to surface metrics related to the AI Gateway."
---

render_with_liquid: false
2025年6月9日

2025年6月9日

![](images/observability-added-to-ai-gateway-alpha-vercel/img_001.jpg)![](images/observability-added-to-ai-gateway-alpha-vercel/img_002.jpg)

![](images/observability-added-to-ai-gateway-alpha-vercel/img_001.jpg)![](images/observability-added-to-ai-gateway-alpha-vercel/img_002.jpg)

[AI Gateway](https://vercel.com/blog/ai-gateway) 目前面向所有用户处于 Alpha 测试阶段，让您无需管理 API 密钥、速率限制或供应商账户，即可在约 100 种 AI 模型之间自由切换。

[AI Gateway](https://vercel.com/blog/ai-gateway) 目前面向所有用户处于 Alpha 测试阶段，让您无需管理 API 密钥、速率限制或供应商账户，即可在约 100 种 AI 模型之间自由切换。

[Vercel Observability](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fobservability%2Fai&title=AI+Observability) 现已新增专属的 AI 板块，用于呈现与 AI Gateway 相关的各项指标。本次更新带来以下可观测能力：

[Vercel Observability](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fobservability%2Fai&title=AI+Observability) 现已新增专属的 AI 板块，用于呈现与 AI Gateway 相关的各项指标。本次更新带来以下可观测能力：

- 按模型划分的请求量（Requests by model）  
- 首 Token 延迟（Time to first token, TTFT）  
- 请求耗时（Request duration）  
- 输入/输出 Token 数量（Input/output token count）  
- 单次请求成本（Cost per request；Alpha 阶段免费）

- 按模型划分的请求量（Requests by model）  
- 首 Token 延迟（Time to first token, TTFT）  
- 请求耗时（Request duration）  
- 输入/输出 Token 数量（Input/output token count）  
- 单次请求成本（Cost per request；Alpha 阶段免费）

您可跨所有项目查看这些指标，也可深入至单个项目或单个模型维度，从而了解哪些模型性能更优、各模型在延迟方面的表现对比，以及每次请求在生产环境中的实际成本。  

您可跨所有项目查看这些指标，也可深入至单个项目或单个模型维度，从而了解哪些模型性能更优、各模型在延迟方面的表现对比，以及每次请求在生产环境中的实际成本。

Learn more about [Observability](https://vercel.com/docs/observability).

了解更多关于 [可观测性（Observability）](https://vercel.com/docs/observability) 的信息。