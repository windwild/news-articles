---
title: "Grok 3 now available on Vercel Marketplace - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/grok-3-now-available-on-vercel-marketplace"
date: "2025-04-09"
scraped_at: "2026-03-02T09:34:48.047866421+00:00"
language: "en-zh"
translated: true
description: "Grok 3 is now available on the Vercel Marketplace, allowing users to access xAI's latest large language models directly from their Vercel projects"
---
{% raw %}

Apr 9, 2025

2025 年 4 月 9 日

![](images/grok-3-now-available-on-vercel-marketplace-vercel/img_001.jpg)![](images/grok-3-now-available-on-vercel-marketplace-vercel/img_002.jpg)

xAI 最新、最强大的 Grok 3 模型现已通过 Vercel Marketplace 提供，为您的 Vercel 项目带来业界领先的 AI 能力。

要开始使用，您可在项目中集成 [AI SDK xAI 提供程序](https://vercel.com/docs/ai/xai#getting-started)：

```tsx
import { xai } from "@ai-sdk/xai";

import { streamtext } from "ai";

const result = streamText({

5  model: xai("grok-3-beta"),

6  prompt: "What is the meaning of life?",
```

7});



for await (const textPart of result.textStream) {

10  process.stdout.write(textPart); // The answer is 42.

11}
```

然后，使用 Vercel CLI（或[通过控制台](https://vercel.com/marketplace/xai)）[安装 xAI 市场集成](https://vercel.com/marketplace/xai)：

```bash
vercel install xai
```

接受相关条款后，您即可在项目中直接调用 Grok 模型，无需额外配置。

为帮助您快速上手，我们还提供了一个[开箱即用的 Next.js xAI 入门模板](https://vercel.com/new/clone?project-name=Vercel+x+xAI+Chatbot&repository-name=ai-sdk-starter-xai&repository-url=https%3A%2F%2Fgithub.com%2Fvercel-labs%2Fai-sdk-starter-xai&demo-title=Vercel+x+xAI+Chatbot&demo-url=https%3A%2F%2Fai-sdk-starter-xai.labs.vercel.dev%2F&demo-description=A+simple+chatbot+application+built+with+Next.js+that+uses+xAI+via+the+AI+SDK+and+the+Vercel+Marketplace&products=[{%22type%22:%22integration%22,%22protocol%22:%22ai%22,%22productSlug%22:%22grok%22,%22integrationSlug%22:%22xai%22}])。如需进一步了解 Vercel 上的 xAI，请阅读我们的[官方公告](https://vercel.com/blog/xai-and-vercel-partner-to-bring-zero-friction-ai-to-developers)和[文档](https://vercel.com/docs/ai/xai)。
{% endraw %}
