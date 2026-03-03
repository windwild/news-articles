---
title: "Python support added to in-function concurrency beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/python-support-added-to-in-function-concurrency-beta"
date: "2025-01-14"
scraped_at: "2026-03-02T09:38:22.714025909+00:00"
language: "en-zh"
translated: true
description: "Python functions can now leverage In-function concurrency, which optimizes function to handle multiple invocations simultaneously and improves resource efficiency."
---

Jan 14, 2025

2025 年 1 月 14 日

[**函数内并发（In-function concurrency）现已集成至 Fluid 计算平台**  
\\  
Fluid 计算融合了传统服务器的高效性与无服务器（serverless）架构的灵活性，可支持实时、动态的工作负载，例如 API 服务、流式处理和 AI 应用。  
\\  
了解 Fluid](https://vercel.com/changelog/vercel-functions-can-now-run-on-fluid-compute)

[Python](https://vercel.com/docs/functions/runtimes/python) 现已加入正在进行的 [函数内并发公开测试版（in-function concurrency public beta）](https://vercel.com/changelog/in-function-concurrency-now-in-public-beta)。

函数内并发通过优化函数，使其能够同时处理多个调用请求，从而提升资源利用效率。该机制复用已激活的函数实例，而非为每次调用新建实例，显著减少了空闲计算时间及相应成本。

函数内并发尤其适用于涉及外部 API 或数据库调用的工作负载（例如 AI 模型推理），这类场景中函数常因等待响应而处于空闲状态。

目前，函数内并发公开测试版面向 Pro 和 Enterprise 计划用户开放，且要求所用函数 CPU 类型为 Standard 或 Performance。您可通过 [控制台仪表板启用该功能](https://vercel.com/d?to=/%5Bteam%5D/%5Bproject%5D/settings/functions%23in-function-concurrency&title=Go+to+Function+Settings)。资源节省效果的实时监控数据可在 [可观测性（Observability）面板](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fobservability&title=Go+To+Observability) 中查看。

欲了解更多详情，请参阅我们的 [博客文章](https://vercel.com/blog/serverless-servers-node-js-with-in-function-concurrency-2MoEVmoCwraZoZC9t5HI59) 和 [官方文档](https://vercel.com/docs/functions/configuring-functions/concurrency)，或直接使用 [AI SDK Python 流式处理模板](https://vercel.com/templates/python/ai-sdk-python-streaming)，并在您的 [项目设置](https://vercel.com/d?to=/%5Bteam%5D/%5Bproject%5D/settings/functions%23in-function-concurrency&title=Go+to+Function+Settings) 中启用函数内并发功能。