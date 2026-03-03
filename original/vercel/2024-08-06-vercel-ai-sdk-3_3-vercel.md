---
title: "Vercel AI SDK 3.3 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-ai-sdk-3-3"
date: "2024-08-06"
scraped_at: "2026-03-02T09:41:56.764835575+00:00"
language: "en"
translated: false
description: "Vercel AI SDK 3.3 introduces tracing, multi-modal attachments, JSON streaming to clients, and more."
---




Aug 6, 2024

Introducing tracing, multi-modal attachments, JSON streaming to clients, and more.

The [Vercel AI SDK](https://sdk.vercel.ai/) is a toolkit for building AI applications with JavaScript and TypeScript. Its unified API allows you to use any language model and provides powerful UI integrations into leading web frameworks such as [Next.js](https://nextjs.org/) and [Svelte](https://svelte.dev/).

Vercel AI SDK 3.3 introduces four major features:

- [**Tracing**](https://vercel.com/blog/vercel-ai-sdk-3-3#tracing) (experimental): instrument AI SDK functions using OpenTelemetry

- [**Multi-Modal File Attachments**](https://vercel.com/blog/vercel-ai-sdk-3-3#multi-modal-file-attachments) (experimental): send file attachments with `useChat`

- [**useObject hook**](https://vercel.com/blog/vercel-ai-sdk-3-3#useobject-hook) (experimental): stream structured object generation to the client

- [**Additional LLM Settings**](https://vercel.com/blog/vercel-ai-sdk-3-3#additional-llm-settings): raw JSON for tools and structured object generation, stop sequences, and sending custom headers


We have also added [AWS Bedrock](https://sdk.vercel.ai/providers/ai-sdk-providers/amazon-bedrock) and [Chrome AI (community)](https://sdk.vercel.ai/providers/community-providers/chrome-ai) model providers as well as many smaller features and additions. You can find all changes including minor features in our [changelog](https://sdk.vercel.ai/docs/troubleshooting/migration-guide/migration-guide-3-3).

Experimental features let you use the latest AI SDK functionality as soon as possible. However, they can change in patch versions. Please pin the patch version if you decide to use experimental features.

## Tracing

Given the non-deterministic nature of language models, observability is critical for understanding and developing AI applications. You need to be able to trace and understand timing, token usage, prompts, and response content for individual model calls.

The Vercel AI SDK now supports tracing with [OpenTelemetry](https://opentelemetry.io/), an open-source standard for recording telemetry information, as an experimental feature. Here is an example of how trace visualization looks with the [Vercel Datadog integration](https://vercel.com/integrations/datadog):

![Trace visualization with Datadog and the Vercel AI SDK](images/vercel-ai-sdk-3_3-vercel/img_001.jpg)![Trace visualization with Datadog and the Vercel AI SDK](images/vercel-ai-sdk-3_3-vercel/img_002.jpg)Trace visualization with Datadog and the Vercel AI SDK

You can analyze the AI SDK tracing data with Vercel observability integrations such as [Datadog](https://vercel.com/integrations/datadog), [Sentry](https://vercel.com/integrations/sentry), and [Axiom](https://vercel.com/integrations/axiom). Alternatively, you can use LLM observability providers such as [LangFuse](https://langfuse.com/docs/integrations/vercel-ai-sdk), [Braintrust](https://www.braintrust.dev/docs/guides/tracing#vercel-ai-sdk), or [LangSmith](https://docs.smith.langchain.com/how_to_guides/tracing/trace_with_vercel_ai_sdk).

To [use telemetry with the Vercel AI SDK](https://sdk.vercel.ai/docs/ai-sdk-core/telemetry#telemetry), you need to configure it for your application. We recommend using `@vercel/otel` . If you are using Next.js and deploy on Vercel, you can add `instrumentation.ts` with the following code to your project:

instrumentation.ts

```tsx
import { registerOTel } from '@vercel/otel';



export function register() {

4  registerOTel({ serviceName: 'your-project-nameapp' });

5}
```

Because the tracing feature is experimental, you need to opt-in to record information using the `experimental_telemetry` option. You can also supply function IDs to identify the call location as well as additional metadata that you want to record.

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

Enabling the feature will record tracing data for your function calls. You can find more details in the [AI SDK telemetry documentation](https://sdk.vercel.ai/docs/ai-sdk-core/telemetry#telemetry). If you want to get started, check out our [deployable AI SDK Next.js tracing template](https://vercel.com/templates/Next.js/ai-chatbot-telemetry).

## Multi-Modal File Attachments

In many AI chat applications, users need to send attachments along with their messages, such as images, PDFs, and various media files. These attachments also need to be available for preview alongside messages to be viewed by users.

As a result, we have added `experimental_attachments` to the `handleSubmit()` handler of the `useChat()` React hook.

Sending image and text attachments with useChat

Check out [this example in action](https://ai-sdk-preview-attachments.vercel.app/) and [deploy the template](https://vercel.com/templates/Next.js/multi-modal-chatbot).

There are two ways to send attachments with a message, either by providing a `FileList` object or a list of URLs to the `handleSubmit` function:

### FileList

By using `FileList`, you can send multiple files as attachments along with a message using the file input element. The `useChat` hook will automatically convert them into data URLs and send them to the AI provider.

```tsx
const { input, handleSubmit, handleInputChange } = useChat();

const [files, setFiles] = useState<FileList | undefined>(undefined);



return (

5  <form

6    onSubmit={(event) => {

7      handleSubmit(event, {

8        experimental_attachments: files,

9      });

10    }}

11  >

12    <input

13      type="file"

14      onChange={(event) => {

15        if (event.target.files) {

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

You can also send URLs as attachments along with a message. This can be useful for sending links to external resources or media content.

```tsx
const { input, handleSubmit, handleInputChange } = useChat();

const [attachments] = useState<Attachment[]>([\
\
3  {\
\
4    name: 'earth.png',\
\
5    contentType: 'image/png',\
\
6    url: 'https://example.com/earth.png',\
\
7  }\
\
8]);



return (

11  <form

12    onSubmit={event => {

13      handleSubmit(event, {

14        experimental_attachments: attachments,

15      });

16    }}

17  >

18    <input type="text" value={input} onChange={handleInputChange} />

19  </form>

20)
```

You can learn more in our [multi-modal chatbot guide](https://sdk.vercel.ai/docs/guides/multi-modal-chatbot).

## useObject hook

Structured data generation is a common requirement in AI applications, e.g. for extracting information from natural language inputs. With the new `useObject` hook, you can stream structured object generation directly to the client. This experimental feature, available today for React, allows you to create dynamic interfaces that show JSON objects as they're being streamed.

For example, imagine an application where you can enter your expenses as text for reimbursement. You can use AI to convert textual inputs into structured objects, and stream the structured expense to the user as it’s being processed:

Extracting and streaming an expense from plain text with useObject

Here's how you could implement this in a Next.js application. First, define a schema for the expenses. The schema is shared between client and server:

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

11    amount: z.number().describe('Amount of the expense in USD.'),

12    date: z

13      .string()

14      .describe('Date of the expense. Format yyyy-mmm-dd, e.g. 1952-Feb-19.'),

15    details: z.string().describe('Details of the expense.'),

16  }),

17});



export type PartialExpense = DeepPartial<typeof expenseSchema>['expense'];



export type Expense = z.infer<typeof expenseSchema>['expense'];
```

Then, you use [`streamObject`](https://sdk.vercel.ai/docs/reference/ai-sdk-core/stream-object) on the server to call the language model and stream an object:

app/api/expense/route.ts

```tsx
import { anthropic } from '@ai-sdk/anthropic';

import { streamObject } from 'ai';

import { expenseSchema } from './schema';



5// Allow streaming responses up to 30 seconds

export const maxDuration = 30;



export async function POST(req: Request) {

9  const { expense }: { expense: string } = await req.json();



11  const result = await streamObject({

12    model: anthropic('claude-3-5-sonnet-20240620'),

13    system:

14      'You categorize expenses into one of the following categories: ' +

15      'TRAVEL, MEALS, ENTERTAINMENT, OFFICE SUPPLIES, OTHER.' +



17      // provide date (including day of week) for reference:

18      'The current date is: ' +

19      new Date()

20        .toLocaleDateString('en-US', {

21          year: 'numeric',

22          month: 'short',

23          day: '2-digit',

24          weekday: 'short',

25        })

26        .replace(/(\w+), (\w+) (\d+), (\d+)/, '$4-$2-$3 ($1)') +

27      '. When no date is supplied, use the current date.',



29    prompt: `Please categorize the following expense: "${expense}"`,

30    schema: expenseSchema,

31    onFinish({ object }) {

32      // you could save the expense to a database here

33    },

34  });



36  return result.toTextStreamResponse();

37}
```

Finally, you consume the expense stream on a client page. While the expense is streaming, we preview the partial expense, and once the generation is finished, we append it to the list of expenses:

app/expense-tracker/page.tsx

```tsx
1'use client';



import { experimental_useObject as useObject } from 'ai/react';

import {

5  Expense,

6  expenseSchema,

7  PartialExpense,

8} from '../api/expense/schema';

import { useState } from 'react';



export default function Page() {

12  const [expenses, setExpenses] = useState<Expense[]>([]);



14  const { submit, isLoading, object } = useObject({

15    api: '/api/expense',

16    schema: expenseSchema,

17    onFinish({ object }) {

18      if (object != null) {

19        setExpenses(prev => [object.expense, ...prev]);

20      }

21    },

22  });



24  return (

25    <div>

26      <form onSubmit={e => {

27        e.preventDefault();

28        const input = e.currentTarget.expense as HTMLInputElement;

29        if (input.value.trim()) {

30          submit({ expense: input.value });

31          e.currentTarget.reset();

32        }

33      }}

34      >

35        <input type="text" name="expense" placeholder="Enter expense details"/>

36        <button type="submit" disabled={isLoading}>Log expense</button>

37      </form>



39      {isLoading && object?.expense && (

40        <ExpenseView expense={object.expense} />

41      )}



43      {expenses.map((expense, index) => (

44        <ExpenseView key={index} expense={expense} />

45      ))}

46    </div>

47  );

48}
```

The expenses are rendered using an ExpenseView that can handle partial objects with undefined properties with `.?` and `??` (styling is omitted for illustration purposes):

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

Check out [this example in action](https://ai-sdk-preview-use-object.labs.vercel.dev/) and [deploy the template](https://vercel.com/templates/Next.js/use-object).

You can use this approach to create generative user interfaces client-side for many different use cases. You can find more details on how to use it in our [object generation documentation](https://sdk.vercel.ai/docs/ai-sdk-ui/object-generation#object-generation).

## Additional LLM Settings

Calling language models is at the heart of the Vercel AI SDK. We have listened to your feedback and extended our functions to support the following features:

- [**JSON schema support for tools and structured object generation**](https://sdk.vercel.ai/docs/reference/ai-sdk-core/json-schema) **:** As an alternative to Zod schemas, you can now use JSON schemas directly with the `jsonSchema` function. You can supply the type annotations and an optional validation function, giving you more flexibility especially when building applications with dynamic tools and structure generation.

- [**Stop sequences**](https://sdk.vercel.ai/docs/ai-sdk-core/settings#stopsequences) **:** Text sequences that stop generations have been an important feature when working with earlier language models that used raw text prompts. They are still relevant for many use cases, allowing you more control over the end of a text generation. You can now use the `stopSequences` option to define stop sequences in `streamText` and `generateText`.

- [**Sending custom headers**](https://sdk.vercel.ai/docs/ai-sdk-core/settings#headers) **:** Custom headers are important for many use cases, like sending tracing information, enabling beta provider features, and more. You can now send custom headers using the `headers` option in most AI SDK functions.


With these additional settings, you have more control and flexibility when working with language models in the Vercel AI SDK.

## Conclusion

With new features like OpenTelemetry support, `useObject`, and support for attachments with `useChat`, it’s never been a better time to start building AI applications.

- **Start a new AI project**: Ready to build something new? Check out our [multi-modal chatbot guide](https://sdk.vercel.ai/docs/guides/multi-modal-chatbot).

- **Explore our templates**: Visit our [Template Gallery](https://vercel.com/templates?type=ai) to see the AI SDK in action and get inspired for your next project.

- **Join the community**: Let us know what you’re building with the AI SDK in our [GitHub Discussions](https://github.com/vercel/ai/discussions/1914).


We can't wait to see what you'll build next with Vercel AI SDK 3.3!

## Contributors

Vercel AI SDK 3.3 is the result of the combined work of our core team at Vercel and many community contributors.

Special thanks for contributing merged pull requests:

[gclark-eightfold](https://github.com/gclark-eightfold), [dynamicwebpaige](https://github.com/dynamicwebpaige), [Und3rf10w](https://github.com/Und3rf10w), [elitan](https://github.com/elitan), [jon-spaeth](https://github.com/jon-spaeth), [jeasonstudio](https://github.com/jeasonstudio), [InfiniteCodeMonkeys](https://github.com/InfiniteCodeMonkeys), [ruflair](https://github.com/ruflair), [MrMaina100](https://github.com/MrMaina100), [AntzyMo](https://github.com/AntzyMo), [samuelint](https://github.com/samuelint), [ian-pascoe](https://github.com/ian-pascoe), [PawelKonie99](https://github.com/PawelKonie99), [BrianHung](https://github.com/BrianHung), [Ouvill](https://github.com/Ouvill), [gmickel](https://github.com/gmickel), [developaul](https://github.com/developaul), [elguarir](https://github.com/elguarir), [Kunoacc](https://github.com/Kunoacc), [florianheysen](https://github.com/florianheysen), [rajuAhmed1705](https://github.com/rajuAhmed1705), [suemor233](https://github.com/suemor233), [eden-chan](https://github.com/eden-chan), [DraganAleksic99](https://github.com/DraganAleksic99), [karl-richter](https://github.com/karl-richter), [rishabhbizzle](https://github.com/rishabhbizzle), [vladkampov](https://github.com/vladkampov), [AaronFriel](https://github.com/AaronFriel), [theitaliandev](https://github.com/theitaliandev), [miguelvictor,](https://github.com/miguelvictor) [jferrettiboke,](https://github.com/jferrettiboke) [dhruvvbhavsar,](https://github.com/dhruvvbhavsar) [lmcgartland,](https://github.com/lmcgartland) [PikiLee](https://github.com/PikiLee)

Your feedback and contributions are invaluable as we continue to evolve the SDK.