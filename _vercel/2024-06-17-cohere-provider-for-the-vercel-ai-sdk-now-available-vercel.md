---
title: "Cohere Provider for the Vercel AI SDK now available - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/cohere-provider-for-the-vercel-ai-sdk-now-available"
date: "2024-06-17"
scraped_at: "2026-03-02T09:43:28.053755594+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Jun 17, 2024

2024 年 6 月 17 日

Vercel AI SDK 现已通过 [全新的官方提供商](https://sdk.vercel.ai/providers/ai-sdk-providers/cohere) 支持 Cohere。如需使用该提供商，请安装对应的软件包：

```bash
pnpm install ai @ai-sdk/cohere
```

随后，您即可在所有 [AI SDK Core](https://sdk.vercel.ai/docs/ai-sdk-core/overview) 方法中使用该提供商。例如，以下是如何配合 `generateText` 使用的示例：

```javascript
import { cohere } from '@ai-sdk/cohere';

import { generateText } from 'ai';



const { text } = await generateText({

5  model: cohere('command-r-plus'),

6  prompt: 'Write a vegetarian lasagna recipe for 4 people.',
```

7});
```

Using the Cohere provider with the Vercel AI SDK

使用 Vercel AI SDK 配合 Cohere 提供商

For more information, [please see the documentation](https://sdk.vercel.ai/providers/ai-sdk-providers/cohere).

如需了解更多信息，请参阅[文档](https://sdk.vercel.ai/providers/ai-sdk-providers/cohere)。