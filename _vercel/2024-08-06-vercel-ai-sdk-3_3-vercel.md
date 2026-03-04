---
title: "Vercel AI SDK 3.3 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-ai-sdk-3-3"
date: "2024-08-06"
scraped_at: "2026-03-02T09:41:56.764835575+00:00"
language: "en-zh"
translated: true
description: "Vercel AI SDK 3.3 introduces tracing, multi-modal attachments, JSON streaming to clients, and more."
---
&#123;% raw %}

Aug 6, 2024

2024 年 8 月 6 日

Introducing tracing, multi-modal attachments, JSON streaming to clients, and more.

新增追踪（Tracing）、多模态文件附件、向客户端流式传输 JSON 等功能。

The [Vercel AI SDK](https://sdk.vercel.ai/) is a toolkit for building AI applications with JavaScript and TypeScript. Its unified API allows you to use any language model and provides powerful UI integrations into leading web frameworks such as [Next.js](https://nextjs.org/) and [Svelte](https://svelte.dev/).

[Vercel AI SDK](https://sdk.vercel.ai/) 是一个用于使用 JavaScript 和 TypeScript 构建 AI 应用的工具包。其统一的 API 支持接入任意语言模型，并为 Next.js、Svelte 等主流 Web 框架提供强大的 UI 集成能力。

Vercel AI SDK 3.3 introduces four major features:

Vercel AI SDK 3.3 版本引入了四项主要新特性：

- [**Tracing**](https://vercel.com/blog/vercel-ai-sdk-3-3#tracing) (experimental): instrument AI SDK functions using OpenTelemetry

- [**追踪（Tracing）**](https://vercel.com/blog/vercel-ai-sdk-3-3#tracing)（实验性功能）：使用 OpenTelemetry 对 AI SDK 函数进行性能监测与追踪

- [**Multi-Modal File Attachments**](https://vercel.com/blog/vercel-ai-sdk-3-3#multi-modal-file-attachments) (experimental): send file attachments with `useChat`

- [**多模态文件附件（Multi-Modal File Attachments）**](https://vercel.com/blog/vercel-ai-sdk-3-3#multi-modal-file-attachments)（实验性功能）：通过 `useChat` 发送文件附件

- [**useObject hook**](https://vercel.com/blog/vercel-ai-sdk-3-3#useobject-hook) (experimental): stream structured object generation to the client

- [**useObject Hook**](https://vercel.com/blog/vercel-ai-sdk-3-3#useobject-hook)（实验性功能）：向客户端流式传输结构化对象生成结果

- [**Additional LLM Settings**](https://vercel.com/blog/vercel-ai-sdk-3-3#additional-llm-settings): raw JSON for tools and structured object generation, stop sequences, and sending custom headers

- [**额外的 LLM 设置（Additional LLM Settings）**](https://vercel.com/blog/vercel-ai-sdk-3-3#additional-llm-settings)：支持工具调用与结构化对象生成的原始 JSON 输入、停止序列（stop sequences），以及自定义请求头（custom headers）

We have also added [AWS Bedrock](https://sdk.vercel.ai/providers/ai-sdk-providers/amazon-bedrock) and [Chrome AI (community)](https://sdk.vercel.ai/providers/community-providers/chrome-ai) model providers as well as many smaller features and additions. You can find all changes including minor features in our [changelog](https://sdk.vercel.ai/docs/troubleshooting/migration-guide/migration-guide-3-3).

我们还新增了 [AWS Bedrock](https://sdk.vercel.ai/providers/ai-sdk-providers/amazon-bedrock) 和 [Chrome AI（社区版）](https://sdk.vercel.ai/providers/community-providers/chrome-ai) 模型提供商，并纳入了许多其他小型功能与改进。所有变更（包括次要功能）均可在我们的 [更新日志（changelog）](https://sdk.vercel.ai/docs/troubleshooting/migration-guide/migration-guide-3-3) 中查阅。

Experimental features let you use the latest AI SDK functionality as soon as possible. However, they can change in patch versions. Please pin the patch version if you decide to use experimental features.

实验性功能可让您第一时间体验 AI SDK 的最新能力；但这些功能可能在补丁版本（patch version）中发生变更。若您决定使用实验性功能，请务必锁定具体补丁版本。

## Tracing

## 追踪（Tracing）

Given the non-deterministic nature of language models, observability is critical for understanding and developing AI applications. You need to be able to trace and understand timing, token usage, prompts, and response content for individual model calls.

鉴于语言模型具有不确定性，可观测性（observability）对于理解与开发 AI 应用至关重要。您需要能够对单次模型调用的耗时、Token 使用量、提示词（prompts）以及响应内容进行追踪与分析。

The Vercel AI SDK now supports tracing with [OpenTelemetry](https://opentelemetry.io/), an open-source standard for recording telemetry information, as an experimental feature. Here is an example of how trace visualization looks with the [Vercel Datadog integration](https://vercel.com/integrations/datadog):

Vercel AI SDK 当前已将基于 [OpenTelemetry](https://opentelemetry.io/)（一种用于采集遥测数据的开源标准）的追踪功能作为实验性特性予以支持。以下为使用 [Vercel Datadog 集成](https://vercel.com/integrations/datadog) 展示追踪可视化效果的示例：

![Trace visualization with Datadog and the Vercel AI SDK](images/vercel-ai-sdk-3_3-vercel/img_001.jpg)![Trace visualization with Datadog and the Vercel AI SDK](images/vercel-ai-sdk-3_3-vercel/img_002.jpg)Trace visualization with Datadog and the Vercel AI SDK

![Trace visualization with Datadog and the Vercel AI SDK](images/vercel-ai-sdk-3_3-vercel/img_001.jpg)![Trace visualization with Datadog and the Vercel AI SDK](images/vercel-ai-sdk-3_3-vercel/img_002.jpg)使用 Datadog 与 Vercel AI SDK 的追踪可视化效果

You can analyze the AI SDK tracing data with Vercel observability integrations such as [Datadog](https://vercel.com/integrations/datadog), [Sentry](https://vercel.com/integrations/sentry), and [Axiom](https://vercel.com/integrations/axiom). Alternatively, you can use LLM observability providers such as [LangFuse](https://langfuse.com/docs/integrations/vercel-ai-sdk), [Braintrust](https://www.braintrust.dev/docs/guides/tracing#vercel-ai-sdk), or [LangSmith](https://docs.smith.langchain.com/how_to_guides/tracing/trace_with_vercel_ai_sdk).

您可借助 Vercel 提供的可观测性集成工具（例如 [Datadog](https://vercel.com/integrations/datadog)、[Sentry](https://vercel.com/integrations/sentry) 和 [Axiom](https://vercel.com/integrations/axiom)）来分析 AI SDK 的追踪数据；亦可选用专为大语言模型设计的可观测性平台，例如 [LangFuse](https://langfuse.com/docs/integrations/vercel-ai-sdk)、[Braintrust](https://www.braintrust.dev/docs/guides/tracing#vercel-ai-sdk) 或 [LangSmith](https://docs.smith.langchain.com/how_to_guides/tracing/trace_with_vercel_ai_sdk)。

To [use telemetry with the Vercel AI SDK](https://sdk.vercel.ai/docs/ai-sdk-core/telemetry#telemetry), you need to configure it for your application. We recommend using `@vercel/otel` . If you are using Next.js and deploy on Vercel, you can add `instrumentation.ts` with the following code to your project:

如需[在 Vercel AI SDK 中启用遥测（telemetry）功能](https://sdk.vercel.ai/docs/ai-sdk-core/telemetry#telemetry)，您需为应用完成相应配置。我们推荐使用 `@vercel/otel` 包。若您正在使用 Next.js 并部署于 Vercel 平台，则可在项目中添加一个名为 `instrumentation.ts` 的文件，并填入如下代码：

instrumentation.ts

`instrumentation.ts`

```tsx
import { registerOTel } from '@vercel/otel';



export function register() {

4  registerOTel({ serviceName: 'your-project-nameapp' });

4  registerOTel({ serviceName: 'your-project-nameapp' });

5}
```

```
5}
```

Because the tracing feature is experimental, you need to opt-in to record information using the `experimental_telemetry` option. You can also supply function IDs to identify the call location as well as additional metadata that you want to record.

由于追踪功能尚处于实验阶段，您需要通过 `experimental_telemetry` 选项显式启用信息采集。您还可以提供函数 ID 以标识调用位置，并传入您希望记录的额外元数据。

```tsx
const result = await generateText({

2  model: anthropic('claude-3-5-sonnet-20240620'),

3  prompt: 'Write a short story about a cat.',

4  experimental_telemetry: {

5    isEnabled: true,

6    functionId: 'my-awesome-function',

7    metadata: {
```

```tsx
const result = await generateText({

2  model: anthropic('claude-3-5-sonnet-20240620'),

3  prompt: 'Write a short story about a cat.',

4  experimental_telemetry: {

5    isEnabled: true,

6    functionId: 'my-awesome-function',

7    metadata: {

8      something: 'custom',

9      someOtherThing: 'other-value',

10    },

11  },

12});
```

启用该功能后，系统将记录您函数调用的追踪数据（tracing data）。更多详细信息，请参阅 [AI SDK 遥测文档](https://sdk.vercel.ai/docs/ai-sdk-core/telemetry#telemetry)。如需快速上手，欢迎试用我们的 [可部署 AI SDK Next.js 追踪模板](https://vercel.com/templates/Next.js/ai-chatbot-telemetry)。

## 多模态文件附件

在许多 AI 聊天应用中，用户需要随消息一并发送附件，例如图片、PDF 及各类媒体文件。这些附件还需支持与消息并列预览，以便用户查看。

因此，我们在 `useChat()` React Hook 的 `handleSubmit()` 处理函数中新增了 `experimental_attachments` 功能。

使用 `useChat` 发送图片和文本附件

Check out [this example in action](https://ai-sdk-preview-attachments.vercel.app/) and [deploy the template](https://vercel.com/templates/Next.js/multi-modal-chatbot).

请查看 [此示例的实际运行效果](https://ai-sdk-preview-attachments.vercel.app/)，并 [部署该模板](https://vercel.com/templates/Next.js/multi-modal-chatbot)。

There are two ways to send attachments with a message, either by providing a `FileList` object or a list of URLs to the `handleSubmit` function:

向消息中添加附件有两种方式：一种是向 `handleSubmit` 函数传入一个 `FileList` 对象，另一种是传入一个 URL 列表。

### FileList

### 使用 FileList

By using `FileList`, you can send multiple files as attachments along with a message using the file input element. The `useChat` hook will automatically convert them into data URLs and send them to the AI provider.

通过使用 `FileList`，您可借助文件输入元素（`<input type="file">`）将多个文件作为附件随消息一同发送。`useChat` Hook 会自动将这些文件转换为 data URL，并提交给 AI 提供商。

```tsx
const { input, handleSubmit, handleInputChange } = useChat();

const [files, setFiles] = useState<FileList | undefined>(undefined);



return (

5  <form

6    onSubmit={(event) => {

7      handleSubmit(event, {

7      handleSubmit(event, {

8        experimental_attachments: files,

8        experimental_attachments: files,

9      });

9      });

10    }}

10    }}

11  >

11  >

12    <input

12    <input

13      type="file"

13      type="file"

14      onChange={(event) => {

14      onChange={(event) => {

15        if (event.target.files) {

15        if (event.target.files) {

16          setFiles(event.target.files);

16          setFiles(event.target.files);

17        }

18      }}

19      multiple

20    />

21    <input type="text" value={input} onChange={handleInputChange} />

22  </form>

23);
```

### URLs

### URL 地址

You can also send URLs as attachments along with a message. This can be useful for sending links to external resources or media content.

你还可以将 URL 作为附件随消息一同发送。这对于分享外部资源或媒体内容的链接非常有用。

```tsx
const { input, handleSubmit, handleInputChange } = useChat();

```typescript
const [attachments] = useState<Attachment[]>([
  {
    name: 'earth.png',
    contentType: 'image/png',
    url: 'https://example.com/earth.png',
  }
]);
```

```typescript
const [attachments] = useState<Attachment[]>([
  {
    名称: 'earth.png',
    内容类型: 'image/png',
    URL: 'https://example.com/earth.png',
  }
]);
```

```tsx
return (
  <form
    onSubmit={event => {
      handleSubmit(event, {
        experimental_attachments: attachments,
      });
    }}
  >
```

```tsx
return (
  <form
    onSubmit={event => {
      handleSubmit(event, {
        experimental_attachments: attachments,
      });
    }}
  >
```

18    <input type="text" value={input} onChange={handleInputChange} />

18    <input type="text" value={input} onChange={handleInputChange} />

19  </form>

19  </form>

20)
20)

```

You can learn more in our [multi-modal chatbot guide](https://sdk.vercel.ai/docs/guides/multi-modal-chatbot).

您可参阅我们的[多模态聊天机器人指南](https://sdk.vercel.ai/docs/guides/multi-modal-chatbot)，了解更多信息。

## useObject hook

## `useObject` 钩子

Structured data generation is a common requirement in AI applications, e.g. for extracting information from natural language inputs. With the new `useObject` hook, you can stream structured object generation directly to the client. This experimental feature, available today for React, allows you to create dynamic interfaces that show JSON objects as they're being streamed.

结构化数据生成是 AI 应用中的常见需求，例如从自然语言输入中提取信息。借助全新的 `useObject` 钩子，您可以直接向客户端流式传输结构化对象的生成过程。这一实验性功能目前已面向 React 开放，使您能够构建动态界面，在 JSON 对象生成过程中实时展示其内容。

For example, imagine an application where you can enter your expenses as text for reimbursement. You can use AI to convert textual inputs into structured objects, and stream the structured expense to the user as it’s being processed:

例如，设想一个报销应用：用户以文本形式录入自己的费用明细。您可利用 AI 将这些文本输入转换为结构化对象，并在处理过程中实时将结构化的费用数据流式传输给用户：

Extracting and streaming an expense from plain text with useObject

使用 `useObject` 从纯文本中提取并流式传输费用信息

Here's how you could implement this in a Next.js application. First, define a schema for the expenses. The schema is shared between client and server:

以下是在 Next.js 应用中实现该功能的方式。首先，定义费用数据的 Schema；该 Schema 在客户端与服务端之间共享：

app/api/expense/schema.ts

app/api/expense/schema.ts

```tsx
import { z } from 'zod';



export const expenseSchema = z.object({

4  expense: z.object({

5    category: z

6      .string()

7      .describe(

8        'Category of the expense. Allowed categories: ' +

9        'TRAVEL, MEALS, ENTERTAINMENT, OFFICE SUPPLIES, OTHER.',

10      ),
```

```tsx
import { z } from 'zod';



export const expenseSchema = z.object({

4  expense: z.object({

5    category: z

6      .string()

7      .describe(

8        '费用类别。允许的类别：' +

9        'TRAVEL（差旅）、MEALS（餐饮）、ENTERTAINMENT（娱乐）、OFFICE SUPPLIES（办公用品）、OTHER（其他）。',

10      ),
```

11    amount: z.number().describe('Amount of the expense in USD.'),

11    amount: z.number().describe('费用金额（以美元计）。'),

12    date: z

12    date: z

13      .string()

13      .string()

14      .describe('Date of the expense. Format yyyy-mmm-dd, e.g. 1952-Feb-19.'),

14      .describe('费用日期。格式为 yyyy-mmm-dd，例如 1952-Feb-19。'),

15    details: z.string().describe('Details of the expense.'),

15    details: z.string().describe('费用明细。'),

16  }),

16  }),

17});



17}};



export type PartialExpense = DeepPartial<typeof expenseSchema>['expense'];

export type PartialExpense = DeepPartial<typeof expenseSchema>['expense'];

```ts
export type Expense = z.infer<typeof expenseSchema>['expense'];
```

```ts
export type Expense = z.infer<typeof expenseSchema>['expense'];
```

Then, you use [`streamObject`](https://sdk.vercel.ai/docs/reference/ai-sdk-core/stream-object) on the server to call the language model and stream an object:

然后，您可在服务端使用 [`streamObject`](https://sdk.vercel.ai/docs/reference/ai-sdk-core/stream-object) 调用语言模型，并流式返回一个对象：

app/api/expense/route.ts

app/api/expense/route.ts

```tsx
import { anthropic } from '@ai-sdk/anthropic';

import { streamObject } from 'ai';

import { expenseSchema } from './schema';



// Allow streaming responses up to 30 seconds

// 允许流式响应最长持续 30 秒

export const maxDuration = 30;
```

```typescript
export async function POST(req: Request) {

export async function POST(req: Request) {

9  const { expense }: { expense: string } = await req.json();

9  const { expense }: { expense: string } = await req.json();

11  const result = await streamObject({

11  const result = await streamObject({

12    model: anthropic('claude-3-5-sonnet-20240620'),

12    model: anthropic('claude-3-5-sonnet-20240620'),

13    system:

13    system:

14      'You categorize expenses into one of the following categories: ' +

14      '你将费用归类为以下类别之一：' +

15      'TRAVEL, MEALS, ENTERTAINMENT, OFFICE SUPPLIES, OTHER.' +

15      '差旅（TRAVEL）、餐饮（MEALS）、娱乐（ENTERTAINMENT）、办公用品（OFFICE SUPPLIES）、其他（OTHER）。' +

17      // provide date (including day of week) for reference:

17      // 提供日期（含星期几）作为参考：
```

18      'The current date is: ' +

18      “当前日期为：” +

19      new Date()

19      new Date()

20        .toLocaleDateString('en-US', {

20        .toLocaleDateString('en-US', {

21          year: 'numeric',

21          year: 'numeric',

22          month: 'short',

22          month: 'short',

23          day: '2-digit',

23          day: '2-digit',

24          weekday: 'short',

24          weekday: 'short',

25        })

25        })

26        .replace(/(\w+), (\w+) (\d+), (\d+)/, '$4-$2-$3 ($1)') +

26        .replace(/(\w+), (\w+) (\d+), (\d+)/, '$4-$2-$3 ($1)') +

27      '. When no date is supplied, use the current date.'

27      “若未提供日期，则使用当前日期。”

29    prompt: `Please categorize the following expense: "${expense}"`,

29    提示：`请对以下支出进行分类：“${expense}”`,

30    schema: expenseSchema,

30    模式：expenseSchema,

31    onFinish({ object }) {

31    onFinish({ object }) {

32      // you could save the expense to a database here

32      // 此处可将该支出保存至数据库

33    },

33    },

34  });



34  });



36  return result.toTextStreamResponse();

36  return result.toTextStreamResponse();

37}
```

37}
```

Finally, you consume the expense stream on a client page. While the expense is streaming, we preview the partial expense, and once the generation is finished, we append it to the list of expenses:

最后，你在客户端页面消费该费用流。在费用数据流式传输过程中，我们预览部分费用信息；当生成完成后，将其追加到费用列表中：

app/expense-tracker/page.tsx

app/expense-tracker/page.tsx

```tsx
1'use client';



import { experimental_useObject as useObject } from 'ai/react';

import {

5  Expense,

6  expenseSchema,

7  PartialExpense,

8} from '../api/expense/schema';
```

```tsx
import { useState } from 'react';

import { useState } from 'react';

export default function Page() {

export default function Page() {

12  const [expenses, setExpenses] = useState<Expense[]>([]);

12  const [expenses, setExpenses] = useState<Expense[]>([]);

14  const { submit, isLoading, object } = useObject({

14  const { submit, isLoading, object } = useObject({

15    api: '/api/expense',

15    api: '/api/expense',

16    schema: expenseSchema,

16    schema: expenseSchema,

17    onFinish({ object }) {

17    onFinish({ object }) {

18      if (object != null) {

18      if (object != null) {
```

19        setExpenses(prev => [object.expense, ...prev]);

19        setExpenses(prev => [object.expense, ...prev]);

20      }

20      }

21    },

21    },

22  });

22  });

24  return (

24  return (

25    <div>

25    <div>

26      <form onSubmit={e => {

26      <form onSubmit={e => {

27        e.preventDefault();

27        e.preventDefault();

28        const input = e.currentTarget.expense as HTMLInputElement;

28        const input = e.currentTarget.expense as HTMLInputElement;

29        if (input.value.trim()) {

29        如果 input.value 去除首尾空白后非空：

30          submit({ expense: input.value });

30          调用 submit 函数，传入对象 { expense: input.value }；

31          e.currentTarget.reset();

31          调用当前表单元素的 reset() 方法重置表单；

32        }

32        }

33      }}

33      }}

34      >

34      >

35        <input type="text" name="expense" placeholder="Enter expense details"/>

35        <input type="text" name="expense" placeholder="请输入支出详情"/>

36        <button type="submit" disabled={isLoading}>Log expense</button>

36        <button type="submit" disabled={isLoading}>记录支出</button>

37      </form>

37      </form>

39      {isLoading && object?.expense && (

39      {isLoading && object?.expense && (

40        <ExpenseView expense={object.expense} />

40        <ExpenseView expense={object.expense} />

41      )}

41      )}

43      {expenses.map((expense, index) => (

43      {expenses.map((expense, index) => (

44        <ExpenseView key={index} expense={expense} />

44        <ExpenseView key={index} expense={expense} />

45      ))}

45      ))}

46    </div>

46    </div>

47  );

47  );

48}

48}

费用信息通过 `ExpenseView` 组件渲染，该组件能够处理带有未定义属性的不完整对象（使用 `?.` 和 `??` 操作符）；（为便于说明，此处省略了样式代码）：

app/expense-tracker/page.tsx

```tsx
const ExpenseView = ({ expense }: { expense: PartialExpense | Expense }) => (

2  <div>

3    <div>{expense?.date ?? ''}</div>

4    <div>${expense?.amount?.toFixed(2) ?? ''}</div>

5    <div>{expense?.category ?? ''}</p></div>

6    <div>{expense?.details ?? ''}</div>

7  </div>

8);
```

费用信息通过 `ExpenseView` 组件渲染，该组件能够处理带有未定义属性的不完整对象（使用可选链操作符 `?.` 和空值合并操作符 `??`）；（为便于说明，此处省略了样式代码）：

Check out [this example in action](https://ai-sdk-preview-use-object.labs.vercel.dev/) and [deploy the template](https://vercel.com/templates/Next.js/use-object).

请查看 [此示例的实际运行效果](https://ai-sdk-preview-use-object.labs.vercel.dev/)，并 [部署该模板](https://vercel.com/templates/Next.js/use-object)。

You can use this approach to create generative user interfaces client-side for many different use cases. You can find more details on how to use it in our [object generation documentation](https://sdk.vercel.ai/docs/ai-sdk-ui/object-generation#object-generation).

您可以采用这种方法，在客户端为多种不同应用场景构建生成式用户界面。有关如何使用它的更多详细信息，请参阅我们的 [对象生成文档](https://sdk.vercel.ai/docs/ai-sdk-ui/object-generation#object-generation)。

## Additional LLM Settings

## 额外的语言模型（LLM）设置

Calling language models is at the heart of the Vercel AI SDK. We have listened to your feedback and extended our functions to support the following features:

调用语言模型是 Vercel AI SDK 的核心功能。我们认真听取了您的反馈，并对相关函数进行了扩展，以支持以下特性：

- [**JSON schema support for tools and structured object generation**](https://sdk.vercel.ai/docs/reference/ai-sdk-core/json-schema) **:** As an alternative to Zod schemas, you can now use JSON schemas directly with the `jsonSchema` function. You can supply the type annotations and an optional validation function, giving you more flexibility especially when building applications with dynamic tools and structure generation.

- [**工具与结构化对象生成的 JSON Schema 支持**](https://sdk.vercel.ai/docs/reference/ai-sdk-core/json-schema) **：** 作为 Zod Schema 的替代方案，您现在可直接在 `jsonSchema` 函数中使用 JSON Schema。您可提供类型注解及一个可选的验证函数，从而获得更高灵活性——尤其适用于构建需动态工具和动态结构生成的应用程序。

- [**Stop sequences**](https://sdk.vercel.ai/docs/ai-sdk-core/settings#stopsequences) **:** Text sequences that stop generations have been an important feature when working with earlier language models that used raw text prompts. They are still relevant for many use cases, allowing you more control over the end of a text generation. You can now use the `stopSequences` option to define stop sequences in `streamText` and `generateText`.

- [**停止序列（Stop Sequences）**](https://sdk.vercel.ai/docs/ai-sdk-core/settings#stopsequences) **：** 在早期依赖原始文本提示词（raw text prompts）的语言模型中，“停止序列”一直是关键功能。如今它对许多应用场景依然重要，可让您更精准地控制文本生成的终止位置。您现在可在 `streamText` 和 `generateText` 中通过 `stopSequences` 选项定义停止序列。

- [**Sending custom headers**](https://sdk.vercel.ai/docs/ai-sdk-core/settings#headers) **:** Custom headers are important for many use cases, like sending tracing information, enabling beta provider features, and more. You can now send custom headers using the `headers` option in most AI SDK functions.

- [**发送自定义请求头（Custom Headers）**](https://sdk.vercel.ai/docs/ai-sdk-core/settings#headers) **：** 自定义请求头对诸多场景至关重要，例如传递追踪（tracing）信息、启用服务商的 Beta 功能等。现在，您可在大多数 AI SDK 函数中通过 `headers` 选项发送自定义请求头。

With these additional settings, you have more control and flexibility when working with language models in the Vercel AI SDK.

借助这些新增设置，您在 Vercel AI SDK 中调用语言模型时将拥有更强的控制力与更高的灵活性。

## Conclusion

## 总结

With new features like OpenTelemetry support, `useObject`, and support for attachments with `useChat`, it’s never been a better time to start building AI applications.

凭借 OpenTelemetry 支持、`useObject` 等新特性，以及 `useChat` 对附件（attachments）的支持，当下正是开启 AI 应用开发的最佳时机。

- **Start a new AI project**: Ready to build something new? Check out our [multi-modal chatbot guide](https://sdk.vercel.ai/docs/guides/multi-modal-chatbot).

- **启动一个全新的 AI 项目**：准备好构建一些新东西了吗？请查阅我们的[多模态聊天机器人指南](https://sdk.vercel.ai/docs/guides/multi-modal-chatbot)。

- **Explore our templates**: Visit our [Template Gallery](https://vercel.com/templates?type=ai) to see the AI SDK in action and get inspired for your next project.

- **探索我们的模板**：访问我们的[模板画廊](https://vercel.com/templates?type=ai)，亲身体验 AI SDK 的实际应用，并为您的下一个项目获取灵感。

- **Join the community**: Let us know what you’re building with the AI SDK in our [GitHub Discussions](https://github.com/vercel/ai/discussions/1914).

- **加入社区**：欢迎在我们的[ GitHub 讨论区](https://github.com/vercel/ai/discussions/1914)中分享您正在使用 AI SDK 构建的项目。

We can't wait to see what you'll build next with Vercel AI SDK 3.3!

我们迫不及待想看到您使用 Vercel AI SDK 3.3 构建的下一个精彩作品！

## Contributors

## 贡献者

Vercel AI SDK 3.3 is the result of the combined work of our core team at Vercel and many community contributors.

Vercel AI SDK 3.3 是 Vercel 核心团队与众多社区贡献者通力协作的成果。

Special thanks for contributing merged pull requests:

特别感谢以下贡献者提交并成功合并的 Pull Request：

[gclark-eightfold](https://github.com/gclark-eightfold), [dynamicwebpaige](https://github.com/dynamicwebpaige), [Und3rf10w](https://github.com/Und3rf10w), [elitan](https://github.com/elitan), [jon-spaeth](https://github.com/jon-spaeth), [jeasonstudio](https://github.com/jeasonstudio), [InfiniteCodeMonkeys](https://github.com/InfiniteCodeMonkeys), [ruflair](https://github.com/ruflair), [MrMaina100](https://github.com/MrMaina100), [AntzyMo](https://github.com/AntzyMo), [samuelint](https://github.com/samuelint), [ian-pascoe](https://github.com/ian-pascoe), [PawelKonie99](https://github.com/PawelKonie99), [BrianHung](https://github.com/BrianHung), [Ouvill](https://github.com/Ouvill), [gmickel](https://github.com/gmickel), [developaul](https://github.com/developaul), [elguarir](https://github.com/elguarir), [Kunoacc](https://github.com/Kunoacc), [florianheysen](https://github.com/florianheysen), [rajuAhmed1705](https://github.com/rajuAhmed1705), [suemor233](https://github.com/suemor233), [eden-chan](https://github.com/eden-chan), [DraganAleksic99](https://github.com/DraganAleksic99), [karl-richter](https://github.com/karl-richter), [rishabhbizzle](https://github.com/rishabhbizzle), [vladkampov](https://github.com/vladkampov), [AaronFriel](https://github.com/AaronFriel), [theitaliandev](https://github.com/theitaliandev), [miguelvictor,](https://github.com/miguelvictor) [jferrettiboke,](https://github.com/jferrettiboke) [dhruvvbhavsar,](https://github.com/dhruvvbhavsar) [lmcgartland,](https://github.com/lmcgartland) [PikiLee](https://github.com/PikiLee)

Your feedback and contributions are invaluable as we continue to evolve the SDK.

您宝贵的反馈与贡献，对我们持续完善 SDK 至关重要。
&#123;% endraw %}
