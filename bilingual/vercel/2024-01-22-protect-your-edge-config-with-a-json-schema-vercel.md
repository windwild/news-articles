---
title: "Protect your Edge Config with a JSON schema - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/protect-your-edge-config-with-a-json-schema"
date: "2024-01-22"
scraped_at: "2026-03-02T09:48:49.672893405+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Jan 22, 2024

2024 年 1 月 22 日

![一个已附加 JSON Schema 的 Edge Config，编辑器中显示验证错误。](images/protect-your-edge-config-with-a-json-schema-vercel/img_001.jpg)![一个已附加 JSON Schema 的 Edge Config，编辑器中显示验证错误。](images/protect-your-edge-config-with-a-json-schema-vercel/img_002.jpg)

您现在可以使用 [JSON Schema](https://json-schema.org/) 来保护您的 [Edge Config](https://vercel.com/docs/storage/edge-config)。通过 Schema 保护机制，可防止意外更新，从而避免引发 Bug 或服务中断。

Edge Config 是一种低延迟数据存储服务，可通过 [Vercel Functions](https://vercel.com/docs/concepts/functions/serverless-functions) 或 [Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware) 进行访问。它非常适合存储实验类数据（例如功能开关和 A/B 测试用户分组），也适用于存储中间件路由规则所需的配置数据（例如重定向规则或黑名单）。

要为 Edge Config 添加 Schema 保护，请按以下步骤操作：

- 在控制台中选择 **Storage**（存储）标签页，然后创建或选中您的 Edge Config；  
- 点击 **Schema**（Schema）按钮以打开 Schema 编辑标签页。在编辑器中输入您的 JSON Schema，Vercel 将实时依据该 Schema 对您的数据进行验证；  
- 点击 **Save**（保存）。此操作将同时保存 Schema 和数据的变更。

请参阅[相关文档](https://vercel.com/docs/storage/edge-config/edge-config-dashboard#schema-validation)了解更多信息。