---
title: "AI SDK 4.0 - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/ai-sdk-4-0"
date: "2024-11-18"
scraped_at: "2026-03-02T09:39:26.104852899+00:00"
language: "en-zh"
translated: true
description: "Introducing PDF support, computer use, and an xAI Grok provider"
---

render_with_liquid: false
Nov 18, 2024

2024 年 11 月 18 日

Introducing PDF support, computer use, and an xAI Grok provider

推出 PDF 支持、计算机操作功能，以及 xAI Grok 模型提供商

The [AI SDK](https://sdk.vercel.ai/) is an open-source toolkit for building AI applications with JavaScript and TypeScript. Its unified provider API allows you to use any language model and enables powerful UI integrations into leading web frameworks such as [Next.js](https://nextjs.org/) and [Svelte](https://svelte.dev/).

[AI SDK](https://sdk.vercel.ai/) 是一个开源工具包，用于使用 JavaScript 和 TypeScript 构建 AI 应用。其统一的提供商（provider）API 使您能够接入任意大语言模型，并支持与 Next.js、Svelte 等主流 Web 框架进行深度 UI 集成。

Since our 3.4 release, we've seen the community build amazing products with the AI SDK:

自 3.4 版本发布以来，我们欣喜地看到社区借助 AI SDK 打造出众多令人瞩目的产品：

- Val Town's Townie is an [AI assistant that helps developers](https://blog.val.town/blog/building-a-code-writing-robot/) turn ideas into deployed TypeScript apps and APIs right from their browser

- Val Town 的 Townie 是一款 [面向开发者的 AI 助手](https://blog.val.town/blog/building-a-code-writing-robot/)，可直接在浏览器中将创意快速转化为已部署的 TypeScript 应用与 API。

- Chatbase has [scaled to 500K monthly visitors and $4M ARR](https://vercel.com/blog/how-chatbase-scaled-rapidly-with-vercels-developer-experience-and-ai-sdk), using the AI SDK to power customizable chat agents for customer support and sales

- Chatbase 已 [扩展至每月 50 万访客、年经常性收入（ARR）达 400 万美元](https://vercel.com/blog/how-chatbase-scaled-rapidly-with-vercels-developer-experience-and-ai-sdk)，依托 AI SDK 构建了面向客户支持与销售场景的高度可定制化聊天智能体。

- ChatPRD helps product managers craft Product Requirements Documents (PRDs) and roadmaps with AI, [growing to 20,000 users in just nine months](https://vercel.com/blog/leveraging-vercel-and-the-ai-sdk-to-deliver-a-seamless-ai-powered-experience)

- ChatPRD 借助 AI 协助产品经理高效撰写产品需求文档（PRD）与产品路线图，[上线仅九个月用户数即突破 2 万](https://vercel.com/blog/leveraging-vercel-and-the-ai-sdk-to-deliver-a-seamless-ai-powered-experience)。

Today, we're announcing the release of AI SDK 4.0. This version introduces several new capabilities including:

今天，我们正式发布 AI SDK 4.0。该版本新增多项关键能力，包括：

- [PDF support for Anthropic and Google Generative AI providers for document analysis](https://vercel.com/blog/ai-sdk-4-0#pdf-support)

- [Anthropic 与 Google Generative AI 提供商的 PDF 支持，赋能文档分析](https://vercel.com/blog/ai-sdk-4-0#pdf-support)

- [Computer use support with Anthropic's Claude](https://vercel.com/blog/ai-sdk-4-0#computer-use-support-(anthropic))

- [Anthropic Claude 的“计算机操作”（Computer Use）支持](https://vercel.com/blog/ai-sdk-4-0#computer-use-support-(anthropic))

- [Continuation support for long text generation](https://vercel.com/blog/ai-sdk-4-0#continuation-support)

- [长文本生成的续写支持](https://vercel.com/blog/ai-sdk-4-0#continuation-support)

- [New xAI Grok provider](https://vercel.com/blog/ai-sdk-4-0#new-xai-grok-provider)

- [新增 xAI Grok 模型提供商](https://vercel.com/blog/ai-sdk-4-0#new-xai-grok-provider)

- [Additional provider updates](https://vercel.com/blog/ai-sdk-4-0#additional-provider-updates)

- [其他提供商更新](https://vercel.com/blog/ai-sdk-4-0#additional-provider-updates)

- [Updated AI Chatbot template](https://vercel.com/blog/ai-sdk-4-0#updated-chatbot-template)

- [更新后的 AI 聊天机器人模板](https://vercel.com/blog/ai-sdk-4-0#updated-chatbot-template)


Let's explore these new features and improvements.

让我们一起探索这些新功能与改进。

## PDF support

## PDF 支持

Supporting PDF documents is essential for AI applications as this format is the standard way people share and store documents. Organizations and individuals have built up large collections of important documents in PDF format—from contracts and research papers to manuals and reports—which means AI systems need to handle PDFs well if they're going to help with analyzing documents, pulling out information, or automating workflows.

PDF 文档支持对 AI 应用至关重要，因为 PDF 是人们共享和存储文档的标准格式。各类组织与个人已积累了大量以 PDF 格式保存的重要文档——涵盖合同、学术论文、操作手册及各类报告等。这意味着，若 AI 系统希望在文档分析、信息抽取或工作流自动化等方面提供有效帮助，就必须具备良好的 PDF 处理能力。

AI SDK 4.0 introduces PDF support across multiple providers, including [Anthropic](https://sdk.vercel.ai/providers/ai-sdk-providers/anthropic#pdf-support), [Google Generative AI](https://sdk.vercel.ai/providers/ai-sdk-providers/google-generative-ai#file-inputs), and [Google Vertex AI](https://sdk.vercel.ai/providers/ai-sdk-providers/google-vertex#file-inputs). With PDF support, you can:

AI SDK 4.0 在多个模型提供商中引入了 PDF 支持，包括 [Anthropic](https://sdk.vercel.ai/providers/ai-sdk-providers/anthropic#pdf-support)、[Google Generative AI](https://sdk.vercel.ai/providers/ai-sdk-providers/google-generative-ai#file-inputs) 和 [Google Vertex AI](https://sdk.vercel.ai/providers/ai-sdk-providers/google-vertex#file-inputs)。借助 PDF 支持，您可实现：

- Extract text and information from PDF documents

- 从 PDF 文档中提取文本与结构化信息

- Analyze and summarize PDF content

- 分析并摘要 PDF 内容

- Answer questions based on PDF content  
- 基于 PDF 内容回答问题  

To send a PDF to any compatible model, you can pass PDF files as part of the message content using the `file` type. Here’s an example with Anthropic’s Claude Sonnet 3.5 model:  
要将 PDF 发送给任意兼容模型，您可通过 `file` 类型将 PDF 文件作为消息内容的一部分传递。以下是以 Anthropic 的 Claude Sonnet 3.5 模型为例的示例：

```tsx
import { generateText } from 'ai';

import { anthropic } from '@ai-sdk/anthropic';



const result = await generateText({

5  model: anthropic('claude-3-5-sonnet-20241022'),

6  messages: [\
\
7    {\
\
8      role: 'user',\
\
9      content: [\
\
10        {\
\
11          type: 'text',\
\
12          text: 'What is an embedding model according to this document?',\
\
13        },\
\
14        {\
\
15          type: 'file',\
\
16          data: fs.readFileSync('./data/ai.pdf'),\
\
17          mimeType: 'application/pdf',\
\
18        },\
\
19      ],\
\
20    },\
\
21  ],

22});
```

Thanks to the AI SDK's unified API, to use this functionality with Google or Vertex AI, all you need to change is the model string in the code above.  
得益于 AI SDK 的统一 API，若要在 Google 或 Vertex AI 中使用该功能，您只需修改上述代码中的模型字符串即可。

The code example demonstrates how PDFs integrate seamlessly into your LLM calls. They're treated as just another message content type, requiring no special handling beyond including them as part of the message.

该代码示例展示了 PDF 文件如何无缝集成到您的大语言模型（LLM）调用中。PDF 被视为一种普通的消息内容类型，只需将其作为消息的一部分传入，无需任何特殊处理。

Check out our [quiz generator template](https://ai-sdk-preview-pdf-support.vercel.app/) to see PDF support in action. Using `useObject` and Google's Gemini Pro 1.5 model, it generates an interactive multiple choice quiz based on the contents of a PDF that you upload.

欢迎试用我们的 [测验生成器模板](https://ai-sdk-preview-pdf-support.vercel.app/)，亲身体验 PDF 支持功能。该模板基于 `useObject` Hook 并调用 Google 的 Gemini Pro 1.5 模型，可根据您上传的 PDF 文件内容自动生成交互式多项选择测验。

## ) **Computer use support (Anthropic)**

## ) **计算机操作支持（Anthropic）**

Enabling AI to interact with apps and interfaces naturally, instead of using special tools, unlocks new automation and assistance opportunities.

让 AI 以自然方式与应用程序和用户界面交互（而非依赖专用工具），将开启全新的自动化与辅助能力应用场景。

AI SDK 4.0 introduces [computer use support for the latest Claude Sonnet 3.5 model](https://www.anthropic.com/news/3-5-models-and-computer-use), allowing you to build applications that can:

AI SDK 4.0 引入了对最新版 Claude Sonnet 3.5 模型的 [计算机操作支持](https://www.anthropic.com/news/3-5-models-and-computer-use)，使您能够构建具备以下能力的应用程序：

- Control mouse movements and clicks  
- 控制鼠标移动与点击  

- Input keyboard commands  
- 输入键盘指令  

- Capture and analyze screenshots  
- 截取并分析屏幕截图  

- Execute terminal commands  
- 执行终端命令  

- Manipulate text files  
- 编辑文本文件

Anthropic provides three predefined tools designed to work with the latest Claude 3.5 Sonnet model: the [Computer Tool](https://sdk.vercel.ai/providers/ai-sdk-providers/anthropic#computer-tool) for basic system control (mouse, keyboard, and screenshots), the [Text Editor Tool](https://sdk.vercel.ai/providers/ai-sdk-providers/anthropic#text-editor-tool) for file operations, and the [Bash Tool](https://sdk.vercel.ai/providers/ai-sdk-providers/anthropic#bash-tool) for terminal commands. These tools are carefully designed so that Claude knows exactly how to use them.

Anthropic 提供了三个预定义工具，专为适配最新版 Claude 3.5 Sonnet 模型而设计：[Computer Tool（计算机工具）](https://sdk.vercel.ai/providers/ai-sdk-providers/anthropic#computer-tool)，用于基础系统控制（鼠标、键盘和截图）；[Text Editor Tool（文本编辑器工具）](https://sdk.vercel.ai/providers/ai-sdk-providers/anthropic#text-editor-tool)，用于文件操作；以及 [Bash Tool（Bash 工具）](https://sdk.vercel.ai/providers/ai-sdk-providers/anthropic#bash-tool)，用于执行终端命令。这些工具经过精心设计，确保 Claude 能够精准理解并调用它们。

While Anthropic defines the tool interfaces, you'll need to implement the underlying `execute` function for each tool, defining how your application should handle actions like moving the mouse, capturing screenshots, or running terminal commands on your specific system.

尽管 Anthropic 定义了工具的接口，您仍需为每个工具实现底层的 `execute` 函数，以明确您的应用程序在特定系统上应如何处理诸如移动鼠标、捕获截图或运行终端命令等操作。

Here's an example using the computer tool with `generateText`:

以下是使用 `generateText` 调用计算机工具的一个示例：

```tsx
import { generateText } from 'ai';

import { anthropic } from '@ai-sdk/anthropic';

import { executeComputerAction, getScreenshot } from '@/lib/ai'; // user-defined



const computerTool = anthropic.tools.computer_20241022({

6  displayWidthPx: 1920,

7  displayHeightPx: 1080,
```

8  execute: async ({ action, coordinate, text }) => {

8  execute: async ({ action, coordinate, text }) => {

9    switch (action) {

9    switch (action) {

10      case 'screenshot': {

10      case 'screenshot': {

11        return {

11        return {

12          type: 'image',

12          type: 'image',

13          data: getScreenshot(),

13          data: getScreenshot(),

14        };

14        };

15      }

15      }

16      default: {

16      default: {

17        return executeComputerAction(action, coordinate, text);

17        return executeComputerAction(action, coordinate, text);

18      }

18      }

19    }

19    }

20  },

20  },

21  experimental_toToolResultContent: (result) => {

21  experimental_toToolResultContent: (result) => {

22	  return typeof result === 'string'

22	  返回 `typeof result === 'string'`

23	    ? [{ type: 'text', text: result }]

23	    ? [{ type: 'text', text: result }]

24	    : [{ type: 'image', data: result.data, mimeType: 'image/png' }];

24	    : [{ type: 'image', data: result.data, mimeType: 'image/png' }];

25  },

25  },

26});

26});

```ts
const result = await generateText({
  model: anthropic('claude-3-5-sonnet-20241022'),
  prompt: 'Move the cursor to the center of the screen and take a screenshot',
  tools: { computer: computerTool },
});
```

```ts
const result = await generateText({
  model: anthropic('claude-3-5-sonnet-20241022'),
  prompt: 'Move the cursor to the center of the screen and take a screenshot',
  tools: { computer: computerTool },
});
```

您可以将这些工具与 AI SDK 的 [`maxSteps`](https://sdk.vercel.ai/docs/ai-sdk-core/tools-and-tool-calling#multi-step-calls) 功能结合使用，以支持更复杂的自动化流程。通过设置 `maxSteps` 参数，模型可在无需用户干预的情况下连续执行多次工具调用，并持续运行直至自行判断任务已完成。这一能力对于需要按序执行多种不同操作的复杂自动化任务尤为强大：

您可以将这些工具与 AI SDK 的 [`maxSteps`](https://sdk.vercel.ai/docs/ai-sdk-core/tools-and-tool-calling#multi-step-calls) 功能结合使用，以支持更复杂的自动化流程。通过设置 `maxSteps` 参数，模型可在无需用户干预的情况下连续执行多次工具调用，并持续运行直至自行判断任务已完成。这一能力对于需要按序执行多种不同操作的复杂自动化任务尤为强大：

```tsx
const result = await generateText({
  model: anthropic('claude-3-5-sonnet-20241022'),
  prompt: 'Summarize the AI news from this week.',
  tools: { computer: computerTool, textEditor: textEditorTool, bash: bashTool },
});
```

```tsx
const result = await generateText({
  model: anthropic('claude-3-5-sonnet-20241022'),
  prompt: 'Summarize the AI news from this week.',
  tools: { computer: computerTool, textEditor: textEditorTool, bash: bashTool },
});
```

5  maxSteps: 10,

6});
```

请注意，Anthropic 计算机使用功能目前处于 Beta 阶段。在使用此功能构建应用程序时，建议[实施适当的安全措施](https://sdk.vercel.ai/docs/guides/computer-use#security-measures)，例如使用虚拟机以及限制对敏感数据的访问。如需了解更多详情，请参阅我们的[计算机使用指南](https://sdk.vercel.ai/docs/guides/computer-use)。

## 续写支持（Continuation support）

## 续写支持

许多 AI 应用——从撰写长篇内容到生成代码——都需要超出语言模型单次生成能力上限的输出结果。尽管这些模型可在其上下文窗口中理解大量内容，但其单次响应所能生成的文本长度通常受到限制。

为应对这一常见挑战，AI SDK 4.0 引入了[续写支持（continuation support）](https://sdk.vercel.ai/docs/ai-sdk-core/generating-text#generating-long-text)，该功能可检测生成是否不完整（即当 `finish_reason` 为 `"length"` 时），并在多个步骤中持续生成响应，并将各步结果合并为一个统一的最终输出。借助续写支持，您可实现：

- 生成超出标准输出长度限制的文本  
- 在多次生成过程中保持语义连贯性  
- 自动处理词边界，确保输出格式整洁  
- 跨步骤追踪并汇总 token 使用量

This feature works across all providers and can be used with both [`generateText`](https://sdk.vercel.ai/docs/ai-sdk-core/generating-text#generatetext) and [`streamText`](https://sdk.vercel.ai/docs/ai-sdk-core/generating-text#streamtext) by enabling the `experimental_continueSteps` setting.  
该功能适用于所有模型提供商，只需启用 `experimental_continueSteps` 配置项，即可在 [`generateText`](https://sdk.vercel.ai/docs/ai-sdk-core/generating-text#generatetext) 和 [`streamText`](https://sdk.vercel.ai/docs/ai-sdk-core/generating-text#streamtext) 中使用。

Here's an example of generating a long-form historical text:  
以下是一个生成长篇历史文本的示例：

```tsx
import { generateText } from 'ai';

import { openai } from '@ai-sdk/openai';



const result = await generateText({

5  model: openai('gpt-4o'),

6  maxSteps: 5,

7  experimental_continueSteps: true,

8  prompt:

9    'Write a book about Roman history, ' +
```

10    'from the founding of the city of Rome ' +

10    “从罗马城建立之时” +

11    'to the fall of the Western Roman Empire. ' +

11    “到西罗马帝国灭亡为止。” +

12    'Each chapter MUST HAVE at least 1000 words.',

12    “每一章的字数不得少于 1000 字。”,

13});
```

13});
```

When using continuation support with `streamText`, the SDK ensures clean word boundaries by only streaming complete words. Both `generateText` and `streamText` may trim trailing tokens from some calls to prevent whitespace issues.

使用 `streamText` 并启用续写（continuation）支持时，SDK 会确保单词边界的完整性，仅流式传输完整的单词。`generateText` 和 `streamText` 均可能在某些调用中裁剪末尾的 token，以避免空白字符问题。

## New xAI Grok provider

## 新增 xAI Grok 提供商

The AI SDK now supports [x.AI](https://x.ai/) through a [new official provider](https://sdk.vercel.ai/providers/ai-sdk-providers/xai). To use the provider, install the package:

AI SDK 现已通过 [全新官方提供商](https://sdk.vercel.ai/providers/ai-sdk-providers/xai) 支持 [x.AI](https://x.ai/)。如需使用该提供商，请安装对应包：

```bash
pnpm install ai @ai-sdk/xai
```

```bash
pnpm install ai @ai-sdk/xai
```

You can then use the provider with all AI SDK Core methods. For example, here's how you can use it with `generateText`:

随后，您即可在所有 AI SDK Core 方法中使用该提供商。例如，以下是如何在 `generateText` 中使用它的示例：

```tsx
import { xai } from '@ai-sdk/xai';
```

```tsx
import { xai } from '@ai-sdk/xai';
```

```ts
import { generateText } from 'ai';

const { text } = await generateText({
  model: xai('grok-beta'),
  prompt: 'Write a vegetarian lasagna recipe for 4 people.',
});
```

```ts
import { generateText } from 'ai';

const { text } = await generateText({
  model: xai('grok-beta'),
  prompt: '为 4 人编写一份素食千层面食谱。',
});
```

For more information, please see the [AI SDK xAI provider documentation](https://sdk.vercel.ai/providers/ai-sdk-providers/xai).

有关更多信息，请参阅 [AI SDK xAI 提供商文档](https://sdk.vercel.ai/providers/ai-sdk-providers/xai)。

## Additional provider updates

## 其他提供商更新

We've expanded our provider support to offer more options and improve performance across the board:

我们已扩展对各类提供商的支持，以提供更丰富的选项，并全面提升整体性能：

- [Cohere](https://sdk.vercel.ai/providers/ai-sdk-providers/cohere): v2 support and added tool calling capabilities, expanding supported functionality

- [Cohere](https://sdk.vercel.ai/providers/ai-sdk-providers/cohere)：支持 v2 版本，并新增工具调用（tool calling）功能，进一步拓展了所支持的功能范围。

- [OpenAI](https://sdk.vercel.ai/providers/ai-sdk-providers/openai): [支持预测输出（Predicted output support）](https://sdk.vercel.ai/providers/ai-sdk-providers/openai#predicted-outputs)，实现更精准、上下文感知更强的补全效果；新增[提示词缓存支持（prompt caching support）](https://sdk.vercel.ai/providers/ai-sdk-providers/openai#prompt-caching)，显著提升性能与运行效率。

- [Google Generative AI](https://sdk.vercel.ai/providers/ai-sdk-providers/google-generative-ai) 与 [Vertex AI](https://sdk.vercel.ai/providers/ai-sdk-providers/google-vertex)：支持[文件输入（file inputs）](https://sdk.vercel.ai/providers/ai-sdk-providers/google-generative-ai#file-inputs)、微调模型（fine-tuned models）、结构化 Schema、工具选择（tool choice）及频率惩罚（frequency penalty）；为 Vertex AI 新增[文本嵌入（text embedding）支持](https://sdk.vercel.ai/providers/ai-sdk-providers/google-vertex#embedding-models)。

- [Amazon Bedrock](https://sdk.vercel.ai/providers/ai-sdk-providers/amazon-bedrock)：新增对[Amazon Titan 嵌入模型（Amazon Titan embedding models）](https://sdk.vercel.ai/providers/ai-sdk-providers/amazon-bedrock#embedding-models) 的支持。

- [Groq](https://sdk.vercel.ai/providers/ai-sdk-providers/groq)：正式引入原生 Groq 第一方提供程序（first-party Groq provider），取代此前基于 OpenAI 兼容接口的旧版提供程序。

- [xAI Grok](https://sdk.vercel.ai/providers/ai-sdk-providers/xai)：正式引入原生 xAI Grok 第一方提供程序（first-party xAI Grok provider），取代此前基于 OpenAI 兼容接口的旧版提供程序。

- [LM Studio](https://sdk.vercel.ai/providers/openai-compatible-providers/lmstudio)、[Baseten](https://sdk.vercel.ai/providers/openai-compatible-providers/baseten)、[Together AI](https://sdk.vercel.ai/providers/openai-compatible-providers/togetherai)：新增多个 OpenAI 兼容型提供程序（OpenAI-compatible providers）。

## 更新后的聊天机器人模板

[Next.js AI 聊天机器人模板（Next.js AI Chatbot template）](https://chat.vercel.ai/) 已全面升级，融合了我们在构建 [v0](https://v0.dev/chat) 过程中积累的全部经验，以及最新框架演进成果。该模板基于 [Next.js 15](https://nextjs.org/blog/next-15)、React 19 和 [Auth.js 5](https://authjs.dev/) 构建，是当前面向生产环境的 AI 应用最完备的起点方案。

![](images/ai-sdk-4_0-vercel/img_001.jpg)![](images/ai-sdk-4_0-vercel/img_002.jpg)

该模板开箱即用，内置多项生产就绪功能，包括支持模型切换的全新 UI 设计、基于 PostgreSQL 的持久化存储，以及[更多特性](https://github.com/vercel/ai-chatbot?tab=readme-ov-file#features)。它展示了生成式 UI（generative UI）的先进实践，并提供了新一代聊天界面变体——例如支持交互式工作区（interactive workspaces）的界面（类似 [v0 blocks](https://v0.dev/docs#blocks)），使您能够无缝集成行业专属工作流与工具，打造人机协同的混合式 AI 体验。

[Try the AI Chatbot demo](https://chat.vercel.ai/) to see these features in action or [deploy your own instance](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fvercel%2Fai-chatbot&env=AUTH_SECRET,OPENAI_API_KEY&envDescription=Learn%20more%20about%20how%20to%20get%20the%20API%20Keys%20for%20the%20application&envLink=https%3A%2F%2Fgithub.com%2Fvercel%2Fai-chatbot%2Fblob%2Fmain%2F.env.example&demo-title=AI%20Chatbot&demo-description=An%20Open-Source%20AI%20Chatbot%20Template%20Built%20With%20Next.js%20and%20the%20AI%20SDK%20by%20Vercel.&demo-url=https%3A%2F%2Fchat.vercel.ai&stores=%5B%7B%22type%22:%22postgres%22%7D,%7B%22type%22:%22blob%22%7D%5D) to start building sophisticated AI applications with battle-tested patterns and best practices.

试用 [AI 聊天机器人演示](https://chat.vercel.ai/)，亲身体验这些功能；或 [部署您自己的实例](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fvercel%2Fai-chatbot&env=AUTH_SECRET,OPENAI_API_KEY&envDescription=Learn%20more%20about%20how%20to%20get%20the%20API%20Keys%20for%20the%20application&envLink=https%3A%2F%2Fgithub.com%2Fvercel%2Fai-chatbot%2Fblob%2Fmain%2F.env.example&demo-title=AI%20Chatbot&demo-description=An%20Open-Source%20AI%20Chatbot%20Template%20Built%20With%20Next.js%20and%20the%20AI%20SDK%20by%20Vercel.&demo-url=https%3A%2F%2Fchat.vercel.ai&stores=%5B%7B%22type%22:%22postgres%22%7D,%7B%22type%22:%22blob%22%7D%5D)，立即基于久经考验的设计模式与最佳实践构建功能强大的 AI 应用。

## Migrating to AI SDK 4.0

## 迁移至 AI SDK 4.0

AI SDK 4.0 includes breaking changes that remove deprecated APIs. We've made the migration process easier with automated migration tools. You can run our automated codemods to handle the bulk of the changes.

AI SDK 4.0 包含若干破坏性变更，移除了已弃用的 API。我们提供了自动化迁移工具，大幅简化了迁移流程。您可直接运行我们的自动化 codemod 工具，自动处理大部分变更。

For a detailed overview of all changes and manual steps that might be needed, refer to our [AI SDK 4.0 migration guide](https://sdk.vercel.ai/docs/migration-guides/migration-guide-4-0). The guide includes step-by-step instructions and examples to ensure a smooth update.

如需全面了解所有变更内容及可能需要的手动操作步骤，请参阅我们的 [AI SDK 4.0 迁移指南](https://sdk.vercel.ai/docs/migration-guides/migration-guide-4-0)。该指南提供分步说明与示例代码，助您顺利完成升级。

## **Getting started**

## **快速入门**

With new features like PDF, computer use, and the new xAI Grok provider, there's never been a better time to start building AI applications with the AI SDK.

借助 PDF 处理、计算机使用（Computer Use）以及全新的 xAI Grok 提供商等新特性，现在正是使用 AI SDK 构建 AI 应用的最佳时机。

- **Start a new AI project**: Ready to build something new? Check out our [**latest guides**](https://sdk.vercel.ai/docs/guides)

- **启动一个全新的 AI 项目**：准备开始构建新应用？请查阅我们的 [**最新开发指南**](https://sdk.vercel.ai/docs/guides)

- **Explore our templates**: Visit our [**Template Gallery**](https://sdk.vercel.ai/docs/introduction#templates) to see the AI SDK in action

- **探索我们的模板**：访问 [**模板画廊**](https://sdk.vercel.ai/docs/introduction#templates)，直观了解 AI SDK 的实际应用效果

- **Join the community**: Share what you're building in our [**GitHub Discussions**](https://github.com/vercel/ai/discussions)

- **加入社区**：在我们的 [**GitHub Discussions**](https://github.com/vercel/ai/discussions) 中分享您的项目成果

## Contributors

## 贡献者

AI SDK 4.0 is the result of the combined work of our core team at Vercel ( [Lars](https://x.com/lgrammel), [Jeremy](https://x.com/jrmyphlmn), [Walter](https://x.com/shaper), and [Nico](https://x.com/nicoalbanese10)) and many community contributors. Special thanks for contributing merged pull requests:

[minpeter](https://github.com/minpeter), [hansemannn](https://github.com/hansemannn), [HarshitChhipa](https://github.com/HarshitChhipa), [skull8888888](https://github.com/skull8888888), [nalaso](https://github.com/nalaso), [bhavya3024](https://github.com/bhavya3024), [gastonfartek](https://github.com/gastonfartek), [michaeloliverx](https://github.com/michaeloliverx), [mauhai](https://github.com/mauhai), [yoshinorisano](https://github.com/yoshinorisano), [Saran33](https://github.com/Saran33), [K-Mistele](https://github.com/K-Mistele), [MrHertal](https://github.com/MrHertal), [h4r5h4](https://github.com/h4r5h4), [tonyfarney](https://github.com/tonyfarney).

AI SDK 4.0 是 Vercel 核心团队（[Lars](https://x.com/lgrammel)、[Jeremy](https://x.com/jrmyphlmn)、[Walter](https://x.com/shaper) 和 [Nico](https://x.com/nicoalbanese10)）与众多社区贡献者通力协作的成果。特别感谢以下为本项目提交并成功合入 Pull Request 的贡献者：

[minpeter](https://github.com/minpeter)、[hansemannn](https://github.com/hansemannn)、[HarshitChhipa](https://github.com/HarshitChhipa)、[skull8888888](https://github.com/skull8888888)、[nalaso](https://github.com/nalaso)、[bhavya3024](https://github.com/bhavya3024)、[gastonfartek](https://github.com/gastonfartek)、[michaeloliverx](https://github.com/michaeloliverx)、[mauhai](https://github.com/mauhai)、[yoshinorisano](https://github.com/yoshinorisano)、[Saran33](https://github.com/Saran33)、[K-Mistele](https://github.com/K-Mistele)、[MrHertal](https://github.com/MrHertal)、[h4r5h4](https://github.com/h4r5h4)、[tonyfarney](https://github.com/tonyfarney)。

Your feedback and contributions are invaluable as we continue to evolve the AI SDK.

在 AI SDK 持续演进的过程中，您的反馈与贡献弥足珍贵。