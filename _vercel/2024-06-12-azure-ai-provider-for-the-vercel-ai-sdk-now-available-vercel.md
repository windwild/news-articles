---
render_with_liquid: false
title: "Azure AI Provider for the Vercel AI SDK now available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/azure-ai-provider-for-the-vercel-ai-sdk-now-available"
date: "2024-06-12"
scraped_at: "2026-03-02T09:44:00.698759093+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Jun 12, 2024

2024 年 6 月 12 日

The Vercel AI SDK now supports Azure AI services through [a new official provider](https://sdk.vercel.ai/providers/ai-sdk-providers/azure). To use the provider, install the relevant package:

Vercel AI SDK 现已通过 [一个全新的官方提供商](https://sdk.vercel.ai/providers/ai-sdk-providers/azure) 支持 Azure AI 服务。如需使用该提供商，请安装相应包：

```bash
pnpm install ai @ai-sdk/azure
```

```bash
pnpm install ai @ai-sdk/azure
```

You can then use the provider with all [AI SDK Core](https://sdk.vercel.ai/docs/ai-sdk-core/overview) methods. For example, here's how you can use it with `generateText`:

随后，您即可在所有 [AI SDK Core](https://sdk.vercel.ai/docs/ai-sdk-core/overview) 方法中使用该提供商。例如，以下是如何在 `generateText` 中使用它：

```javascript
import { azure } from '@ai-sdk/azure';

import { generateText } from 'ai';



const { text } = await generateText({

5  model: azure('your-deployment-name'),

6  prompt: 'Write a vegetarian lasagna recipe for 4 people.',
```

```javascript
import { azure } from '@ai-sdk/azure';

import { generateText } from 'ai';



const { text } = await generateText({

5  model: azure('your-deployment-name'),

6  prompt: '为 4 人编写一份素食千层面食谱。',
```

7});
```

Using the Azure provider with the Vercel AI SDK

使用 Vercel AI SDK 配合 Azure 提供程序

For more information, [please see the documentation](https://sdk.vercel.ai/providers/ai-sdk-providers/azure).

如需更多信息，请参阅[文档](https://sdk.vercel.ai/providers/ai-sdk-providers/azure)。