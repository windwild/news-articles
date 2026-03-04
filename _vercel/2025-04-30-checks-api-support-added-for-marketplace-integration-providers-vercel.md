---
title: "Checks API support added for Marketplace integration providers - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/checks-api-support-added-for-marketplace-integration-providers"
date: "2025-04-30"
scraped_at: "2026-03-02T09:34:06.876589077+00:00"
language: "en-zh"
translated: true
description: "Vercel Marketplace now supports the Checks API, enabling providers to deliver automated post-deployment tests and surface results directly in the dashboard. Improve developer experience with seamless ..."
---
{% raw %}

Apr 30, 2025

2025年4月30日

![](images/checks-api-support-added-for-marketplace-integration-providers-vercel/img_001.jpg)![](images/checks-api-support-added-for-marketplace-integration-providers-vercel/img_002.jpg)

为 [Vercel Marketplace](https://vercel.com/marketplace) 构建原生集成的供应商，现在可使用 [Checks API](https://vercel.com/docs/checks)，为其用户提供更深入的功能。

借助 Vercel 的 Checks API，您可在每次部署后定义并运行自定义测试与断言，并将可操作的结果直接呈现在 Vercel 控制台中。

作为测试服务提供商，您可以实现多种检查类型，例如可靠性测试（如 API 可用性、运行时错误）、性能测试（如响应时间阈值、负载模拟）或 Web Vitals 指标（如布局偏移）。这有助于开发者在其工作流早期即发现真实场景中的问题，而您的集成正是这一能力的驱动力。

在构建集成时，请牢记以下最佳实践：

- 提供极简配置甚至零配置的解决方案，让开发者能够轻松运行检查  
- 提供从安装到首次获得结果的引导式入门体验  
- 在 Vercel 控制台中直接展示清晰、可操作的结果  
- 为高级用户撰写文档，说明如何扩展或自定义检查

Learn more in the [Checks API documentation](https://vercel.com/docs/checks).

更多详情请参阅 [Checks API 文档](https://vercel.com/docs/checks)。
{% endraw %}
