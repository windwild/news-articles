---
title: "Llama 4 is now available on Vercel Marketplace - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/llama-4-is-now-available-on-vercel-marketplace"
date: "2025-04-05"
scraped_at: "2026-03-02T09:35:27.447305299+00:00"
language: "en-zh"
translated: true
description: "Llama 4 is now available on Vercel Marketplace via Groq to bring bring state-of-the-art AI capabilities like multimodal input to your Vercel projects. "
---

Apr 5, 2025

2025 年 4 月 5 日

Meta 最新、最强大的 [Llama 4](https://www.llama.com/docs/model-cards-and-prompt-formats/llama4_omni/) 模型现已通过 Vercel Marketplace 上的 [Groq](https://vercel.com/marketplace/groq) 提供。

如需免费开始使用，请在 Vercel 控制台中 [安装 Groq 集成](https://vercel.com/marketplace/groq)，或使用 Vercel CLI 将 Groq 添加到您现有的项目中：

```bash
vercel install groq
```

随后，您即可使用 [AI SDK 的 Groq 提供程序](https://vercel.com/docs/ai/groq#getting-started) 调用 Llama 4：

```tsx
import { groq } from '@ai-sdk/groq';

import { streamText } from 'ai';

import fs from 'fs'



const result = streamText({

6  model: groq('meta-llama/llama-4-scout-17b-16e-instruct'),

6  模型：groq('meta-llama/llama-4-scout-17b-16e-instruct'),

7  messages: [\
\
8    {\
\
9      role: 'user',\
\
10      content: [\
\
11        { type: 'text', text: 'Describe the image in detail.' },\
\
12        { type: 'image', image: fs.readFileSync('./data/llama.png') },\
\
13      ],\
\
14    },\
\
15  ],

7  消息：[\
\
8    {\
\
9      角色：'user',\
\
10      内容：[\
\
11        { 类型：'text', 文本：'请详细描述该图像。' },\
\
12        { 类型：'image', 图像：fs.readFileSync('./data/llama.png') },\
\
13      ],\
\
14    },\
\
15  ],

16});



16}）；

for await (const textPart of result.textStream) {

19  process.stdout.write(textPart);

20}
```

for await (const textPart of result.textStream) {

19  process.stdout.write(textPart);

20}
```

For a full demo, check out the [official Groq chatbot template](https://vercel.com/templates/next.js/vercel-x-groq-chatbot) (which now uses Llama 4) or compare Llama 4 against other models side-by-side on our [AI SDK Playground](https://sdk.vercel.ai/playground). To learn more, visit [our AI documentation](https://vercel.com/docs/ai/groq).

如需完整演示，请查看 [官方 Groq 聊天机器人模板](https://vercel.com/templates/next.js/vercel-x-groq-chatbot)（现已支持 Llama 4），或在我们的 [AI SDK Playground](https://sdk.vercel.ai/playground) 中将 Llama 4 与其他模型并排对比。欲了解更多信息，请访问 [我们的 AI 文档](https://vercel.com/docs/ai/groq)。