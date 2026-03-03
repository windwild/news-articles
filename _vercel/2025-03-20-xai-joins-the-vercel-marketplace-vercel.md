---
title: "xAI joins the Vercel Marketplace  - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/xai-joins-the-vercel-marketplace"
date: "2025-03-20"
scraped_at: "2026-03-02T09:35:21.030908772+00:00"
language: "en-zh"
translated: true
description: "xAI joins the Vercel Marketplace to help users access Grok's large language models directly from their Vercel projects"
---

Mar 20, 2025

2025 年 3 月 20 日

![](images/xai-joins-the-vercel-marketplace-vercel/img_001.jpg)![](images/xai-joins-the-vercel-marketplace-vercel/img_002.jpg)

xAI 的 Grok 模型现已上线 [Vercel Marketplace](https://vercel.com/marketplace/xai)，让您能够轻松将对话式 AI 集成至您的 Vercel 项目中。

- 即刻启用 xAI 免费计划——无需通过 Marketplace 单独注册  
- 直接从您的 Vercel 项目调用 Grok 的大语言模型（LLM）  
- 通过自动配置的环境变量，简化身份验证与 API 密钥管理  
- 借助 Vercel 内置计费系统，按实际用量付费  

要快速开始，您可在项目中使用 [AI SDK xAI 提供程序](https://vercel.com/docs/ai/xai#getting-started)：

```tsx
import { xai } from "@ai-sdk/xai";

import { streamtext } from "ai";

```typescript
const result = streamText({

5  model: xai("grok-2-1212"),

6  prompt: "What is the meaning of life?",

7});



for await (const textPart of result.textStream) {

10  process.stdout.write(textPart); // The answer is 42.

11}
```

然后，使用 Vercel CLI（或[通过控制台](https://vercel.com/marketplace/xai)）安装 [xAI Marketplace 集成](https://vercel.com/marketplace/xai)：

```bash
vercel install xai
```

```bash
vercel install xai
```

Once you've accepted the terms, you'll be able to use Grok models from within your project, with no additional steps necessary.

接受相关条款后，您即可在项目中直接使用 Grok 模型，无需任何额外配置。

To help you get started, we've also made a [ready-to-deploy Next.js xAI starter template](https://vercel.com/new/clone?project-name=Vercel+x+xAI+Chatbot&repository-name=ai-sdk-starter-xai&repository-url=https%3A%2F%2Fgithub.com%2Fvercel-labs%2Fai-sdk-starter-xai&demo-title=Vercel+x+xAI+Chatbot&demo-url=https%3A%2F%2Fai-sdk-starter-xai.labs.vercel.dev%2F&demo-description=A+simple+chatbot+application+built+with+Next.js+that+uses+xAI+via+the+AI+SDK+and+the+Vercel+Marketplace&products=[{%22type%22:%22integration%22,%22protocol%22:%22ai%22,%22productSlug%22:%22grok%22,%22integrationSlug%22:%22xai%22}]).

为帮助您快速上手，我们还提供了 [开箱即用的 Next.js xAI 入门模板](https://vercel.com/new/clone?project-name=Vercel+x+xAI+Chatbot&repository-name=ai-sdk-starter-xai&repository-url=https%3A%2F%2Fgithub.com%2Fvercel-labs%2Fai-sdk-starter-xai&demo-title=Vercel+x+xAI+Chatbot&demo-url=https%3A%2F%2Fai-sdk-starter-xai.labs.vercel.dev%2F&demo-description=A+simple+chatbot+application+built+with+Next.js+that+uses+xAI+via+the+AI+SDK+and+the+Vercel+Marketplace&products=[{%22type%22:%22integration%22,%22protocol%22:%22ai%22,%22productSlug%22:%22grok%22,%22integrationSlug%22:%22xai%22}])。

To learn more about xAI on Vercel, read our [announcement](https://vercel.com/blog/xai-and-vercel-partner-to-bring-zero-friction-ai-to-developers) and the [documentation](https://vercel.com/docs/ai/xai).

如需了解更多关于 Vercel 上 xAI 的信息，请参阅我们的 [官方公告](https://vercel.com/blog/xai-and-vercel-partner-to-bring-zero-friction-ai-to-developers) 和 [文档](https://vercel.com/docs/ai/xai)。