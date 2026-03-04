---
title: "Amazon Bedrock Provider for the Vercel AI SDK now available - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/amazon-bedrock-provider-for-the-vercel-ai-sdk-now-available"
date: "2024-06-21"
scraped_at: "2026-03-02T09:43:34.356660519+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Jun 21, 2024

2024 年 6 月 21 日

Vercel AI SDK 现已通过 [全新的官方提供商](https://sdk.vercel.ai/providers/ai-sdk-providers/amazon-bedrock) 支持 Amazon Bedrock。要使用该提供商，请安装相应的软件包：

```bash
pnpm install ai @ai-sdk/amazon-bedrock
```

随后，您即可在所有 [AI SDK Core](https://sdk.vercel.ai/docs/ai-sdk-core/overview) 方法中使用该提供商。例如，以下是如何配合 `generateText` 使用它的示例：

```javascript
import { bedrock } from '@ai-sdk/amazon-bedrock';

import { generateText } from 'ai';



const { text } = await generateText({

5  model: bedrock('meta.llama3-70b-instruct-v1:0'),

6  prompt: 'Write a vegetarian lasagna recipe for 4 people.',
```

7});
```

Using the Amazon Bedrock provider with the Vercel AI SDK

使用 Vercel AI SDK 配合 Amazon Bedrock 提供商

For more information, [please see the documentation](https://sdk.vercel.ai/providers/ai-sdk-providers/amazon-bedrock).

如需了解更多信息，请参阅[文档](https://sdk.vercel.ai/providers/ai-sdk-providers/amazon-bedrock)。

Thanks Jon Spaeth for contributing this feature!

感谢 Jon Spaeth 为本功能做出的贡献！