---
title: "An Introduction to Streaming on the Web - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/an-introduction-to-streaming-on-the-web"
date: "2023-06-22"
scraped_at: "2026-03-02T09:51:46.876145060+00:00"
language: "en-zh"
translated: true
description: "Learn how web streams work, their advantages, streaming on Vercel, and tools built around web streams."
---

render_with_liquid: false
Jun 22, 2023

2023 年 6 月 22 日

数据分块（Chunking）、背压处理（backpressure）、服务端事件（server-side events）等。

数据随流式传输而实时处理的能力，一直是计算机科学中的一个基础概念。JavaScript 开发者早先可通过 `XMLHttpRequest` 实现流式传输，但直到 2015 年，才通过 Fetch API 原生支持该能力。

[Web Streams](https://streams.spec.whatwg.org/)（Web 流）提供了一种标准化方式，用于在网络连接中持续、异步地发送或接收数据。它将流式处理能力带入 Web 领域，使开发者能够以“数据块（chunks）”形式处理海量数据、应对拥塞控制（即 **背压，_backpressure_**），并构建出高性能、高响应性的应用程序。

在 Web 应用中利用 Web Streams，可显著提升用户界面（UI）的性能与响应速度。数据到达即刻处理，支持实时更新与交互，从而带来更流畅的用户体验：加载更快、信息更及时、界面更顺滑且更具交互性。

得益于其日益增长的普及度，[Web Streams API](https://developer.mozilla.org/en-US/docs/Web/API/Streams_API) 已成为众多主流 Web 平台的核心技术，包括各类 Web 浏览器、Node.js 和 Deno。本文将介绍 Web Streams 是什么、其工作原理、为网站带来的诸多优势、在 Vercel 上的流式传输实践，以及当前已围绕 Web Streams 构建并可供使用的实用工具。

![非流式与流式 HTTP 响应对比图](images/an-introduction-to-streaming-on-the-web-vercel/img_001.jpg)![非流式与流式 HTTP 响应对比图](images/an-introduction-to-streaming-on-the-web-vercel/img_002.jpg)非流式与流式 HTTP 响应对比

Web Streams 提供多项关键优势，尤其体现在 **效率（efficiency）** 与 **可控性（control）** 两方面：

1. **即时数据处理（Instant data processing）**：数据以分块形式陆续抵达，无需等待整个负载完成即可开始处理。这对大体积数据加载或网络延迟较高的场景，可显著提升用户的感知性能。

2. **细粒度控制（Fine-grained control）**：Web Streams 允许开发者精确控制数据的读取与处理方式，灵活适配各类特定需求与使用场景。

Web streams can generally be categorized into three types: `WritableStream`, `ReadableStream` and `TransformStream`. While all three types are involved in handling streaming data, they each have their own role:

网络流通常可分为三类：`WritableStream`、`ReadableStream` 和 `TransformStream`。尽管这三种类型均用于处理流式数据，但各自承担不同的职责：

- ​ **`WritableStream`**: Write data (but not read) to any destination through a "writer".

- ​ **`WritableStream`**：通过“writer”向任意目标写入数据（但不可读取）。

- **`ReadableStream`**: Asynchronously read data (but not write) through a "reader".

- **`ReadableStream`**：通过“reader”异步读取数据（但不可写入）。

- **`TransformStream`**: Manipulate or transform data as it's being transferred

- **`TransformStream`**：在数据传输过程中对其进行处理或转换。

Web streams can be piped together, creating a chain of data processing steps that enhances code readability, maintainability, and makes it easy to create complex data processing pipelines.

网络流可相互管道连接（pipe），形成一连串的数据处理步骤，从而提升代码的可读性与可维护性，并便于构建复杂的数据处理流水线。

![](images/an-introduction-to-streaming-on-the-web-vercel/img_003.jpg)![](images/an-introduction-to-streaming-on-the-web-vercel/img_004.jpg)

## Chunks

## 数据块（Chunks）

Chunks are the fundamental data units in web streams, often represented as strings (for text streams) or Uint8Arrays (for binary streams). Chunks can take many shapes and sizes influenced by certain factors, such as:

数据块（Chunks）是网络流中的基本数据单元，通常表现为字符串（用于文本流）或 Uint8Array（用于二进制流）。数据块的形态与大小受多种因素影响，例如：

1. **Data source.** If you're reading data from a file, the operating system might read the file in blocks of a certain size, which could influence the chunk size.

1. **数据源**：若从文件中读取数据，操作系统可能以特定大小的块为单位读取文件，从而影响数据块的大小。

2. **Stream implementation**. It might buffer data to send it in larger chunks or as soon as it's available, resulting in smaller chunks.

2. **流的实现方式**：其实现可能对数据进行缓冲，以更大的块发送；也可能在数据就绪后立即发送，从而产生更小的数据块。

3. **Local development environment.** In local development, chunk sizes might be more influenced by the stream implementation than network conditions, as there's no actual network transmission happening in local development.

3. **本地开发环境**。在本地开发中，分块（chunk）大小更多受流（stream）实现方式的影响，而非网络状况，因为本地开发过程中实际上并未发生网络传输。

4. **Network.** The network's [Maximum Transmission Unit](https://www.cloudflare.com/learning/network-layer/what-is-mtu/) setting can limit chunk size, especially in data transmission over a network. The physical distance between the client and server can also cause the chunks to get [fragmented](https://vercel.com/docs/concepts/functions/edge-functions/streaming#caveats).

4. **网络**。网络的[最大传输单元（MTU）](https://www.cloudflare.com/learning/network-layer/what-is-mtu/)设置可能限制分块大小，尤其在网络数据传输过程中。客户端与服务器之间的物理距离也可能导致分块被[分片（fragmented）](https://vercel.com/docs/concepts/functions/edge-functions/streaming#caveats)。

Writing your code to handle chunks of any size is important, as it's unpredictable and often beyond your control.

编写能够处理任意大小分块的代码至关重要，因为分块大小不可预测，且通常不受开发者控制。

Let’s take a look at an example.

我们来看一个示例。

```javascript
const decoder = new TextDecoder();

const encoder = new TextEncoder();



const readableStream = new ReadableStream({

5  start(controller) {

6    const text = "Stream me!";
```

7    controller.enqueue(encoder.encode(text));

7    controller.enqueue(encoder.encode(text));

8    controller.close();

8    controller.close();

9  },

9  },

10});

10});

const transformStream = new TransformStream({

const transformStream = new TransformStream({

13  transform(chunk, controller) {

13  transform(chunk, controller) {

14    const text = decoder.decode(chunk);

14    const text = decoder.decode(chunk);

15    controller.enqueue(encoder.encode(text.toUpperCase()));

15    controller.enqueue(encoder.encode(text.toUpperCase()));

16  },

16  },

17});



const writableStream = new WritableStream({

20  write(chunk) {

21    console.log(decoder.decode(chunk));

22  },

23});



readableStream

26   .pipeThrough(transformStream)


17});



const writableStream = new WritableStream({

20  write(chunk) {

21    console.log(decoder.decode(chunk));

22  },

23});



readableStream

26   .pipeThrough(transformStream)

27   .pipeTo(writableStream); // STREAM ME!
```

27   .pipeTo(writableStream); // STREAM ME!
```

首先，我们将字符串 `"Stream me!"` 进行编码，并将其入队（enqueue）到一个 `ReadableStream` 中。该 `ReadableStream` 实质上成为一个可供其他流消费的数据源。

为使数据能从 `ReadableStream` 流向另一条流，我们可以使用 `pipeThrough` 方法。本例中，我们使用的是 `TransformStream` —— 它接收输入数据，对其进行处理，再输出转换后的数据。我们的 `TransformStream` 接收数据块（chunks），将其解码为文本字符串，将字符串转为大写形式，再重新编码为字节序列，最后将转换后的数据块入队，供下游流消费。

最后，我们通过 `pipeTo` 方法将经过转换的数据导向一个 `WritableStream`。`WritableStream` 本质上是一个终点（endpoint），允许我们以自定义方式消费数据。在本例中，我们对传入的数据块进行解码，并将其打印到控制台。

与 Web Streams 交互的主要方式之一是通过 Fetch API。当从 fetch 请求中读取流式数据时，可调用响应体（`response.body`）上的 `getReader` 方法，从而按顺序逐块读取到达的数据，使你能够高效地处理大量数据。

```javascript
const decoder = new TextDecoder();



const response = await fetch('/api/stream');

const reader = response.body.getReader();
```

```javascript
let done = false;



while (!done) {

9  const { value, done: doneReading } = await reader.read();

10  done = doneReading;

11  const data = JSON.parse(decoder.decode(value));

12  // Do something with data

13}
```

## **Handling backpressure**

## **处理背压（Backpressure）**

One of the most powerful features of web streams is their ability to handle _backpressure,_ which happens when the data producer generates data faster than the consumer can process it, for example a high-speed server sending data to a client with a slower internet connection.

Web Streams 最强大的特性之一是其处理 _背压（backpressure）_ 的能力。所谓背压，是指数据生产者生成数据的速度超过了消费者处理数据的速度，例如：高速服务器向网络连接较慢的客户端发送数据时便会出现这种情况。

When there’s a mismatch between the production and consumer processing rate, the exceeding items will be queued and wait to be processed by the consumer. If this continues for an extended period, the queue will continue to grow, potentially leading to a memory overflow if there's not enough available memory to store the queued items.

当生产端与消费端的处理速率不匹配时，超出处理能力的数据项将被加入队列，等待消费端处理。若该状况持续较长时间，队列将持续增长；若可用内存不足以容纳所有排队数据，则可能导致内存溢出。

![](images/an-introduction-to-streaming-on-the-web-vercel/img_005.jpg)![](images/an-introduction-to-streaming-on-the-web-vercel/img_006.jpg)

Handling backpressure can be challenging since it requires a good balance between **the rate at which data is produced and consumed**. Uncontrolled data production can lead to memory issues since the incoming data has to be buffered, but halting production until all data has been processed can be inefficient; the producer would remain idle while there may still be processing capacity available.

背压（backpressure）处理颇具挑战性，因为它要求在**数据生成速率与消费速率之间取得良好平衡**。若数据生成不受控，流入的数据需被缓存，可能引发内存问题；而若等到所有数据均被处理完毕才恢复生产，则效率低下——此时生产端处于空闲状态，而系统中可能仍有未充分利用的处理能力。

### Handling backpressure with web streams

### 使用 Web Streams 处理背压

Web streams handle backpressure through _**flow control.**_ When the stream is in a `"readable"` state, data can flow from the producer to the consumer. If the incoming data begins to outpace the consumer's processing capacity, the stream transitions to a `"backpressure"` state. This state sends a signal to the producer to pause data production.

Web Streams 通过**流控（flow control）**机制处理背压。当流处于 `"readable"`（可读）状态时，数据可从生产端流向消费端；若流入数据开始超过消费端的处理能力，流将转入 `"backpressure"`（背压）状态，向生产端发出暂停数据生产的信号。

When the consumer starts to catch up, the stream switches back to the `"readable"` state which resumes the data production. This automatic pause-and-resume mechanism prevents the consumer from getting overwhelmed with data and ensures that the producer doesn't remain idle unnecessarily.

当消费端逐渐追上处理进度时，流将自动切回 `"readable"` 状态，从而恢复数据生产。这一自动暂停与恢复机制既可防止消费端被数据洪流压垮，又能避免生产端无谓空转。

![](images/an-introduction-to-streaming-on-the-web-vercel/img_007.jpg)![](images/an-introduction-to-streaming-on-the-web-vercel/img_008.jpg)

In a `ReadableStream`, backpressure is applied indirectly through the reader. When a reader pulls chunks from the stream, it signals that it's ready to handle more data. If the reader doesn't pull more data, e.g. by not calling the `read` method, the stream infers that the reader is busy and shouldn't be sent more data for the time being.

在 `ReadableStream` 中，背压是通过读取器（reader）间接施加的：当读取器主动从流中拉取数据块（chunk）时，即表明其已准备好接收更多数据；若读取器不再拉取新数据（例如未调用 `read()` 方法），流便会推断该读取器当前繁忙，暂时不应再向其发送数据。

`WritableStreams` expose backpressure directly to the **writer**. The `write` method returns a promise, which only resolves when the stream is ready for more data. An accumulation of unresolved promises would indicate backpressure.

`WritableStream` 则直接将背压暴露给**写入器（writer）**：其 `write` 方法返回一个 Promise，仅当流已准备好接收更多数据时该 Promise 才会兑现（resolve）；若存在大量尚未兑现的 Promise，则表明系统正承受背压。

```javascript
const stream = new WritableStream(...)
```

```javascript
async function writeData(data) {

4    const writer = stream.getWriter();

5    for (const chunk of data) {

6        // Wait for the ready promise to resolve before writing the next chunk

7        await writer.ready;

8        writer.write(chunk);

9    }

10    writer.close();

11}
```

```javascript
async function writeData(data) {

4    const writer = stream.getWriter();

5    for (const chunk of data) {

6        // 在写入下一个数据块之前，等待 ready Promise 完成

7        await writer.ready;

8        writer.write(chunk);

9    }

10    writer.close();

11}
```

Using the await keyword pauses the execution until the promise resolves, which indicates that the stream is ready for more data. This ensures that we don't write data faster than the writable stream can handle.

使用 `await` 关键字会暂停执行，直到 Promise 被解析（resolve），这表明流已准备好接收更多数据。此举确保我们不会以超过可写流处理能力的速度写入数据。

## **Server-Sent Events**

## **服务器发送事件（SSE）**

[Server-Sent Events (SSE)](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events) are a popular way to stream real-time updates from a server to a client. While web streams are primarily used for data processing, SSEs maintain an open connection with the server, enabling new data to be transmitted as it becomes available.

[服务器发送事件（SSE）](https://developer.mozilla.org/zh-CN/docs/Web/API/Server-sent_events) 是一种将实时更新从服务器流式传输至客户端的流行方式。尽管 Web Streams 主要用于数据处理，SSE 则通过维持与服务器的持久连接，使得新数据一旦生成即可立即发送。

![](images/an-introduction-to-streaming-on-the-web-vercel/img_009.jpg)![](images/an-introduction-to-streaming-on-the-web-vercel/img_010.jpg)

Whereas web streams close the HTTP connection once all the data has been sent, Server-Sent Events use a long-lived HTTP connection to ensure the server can send more events once they’re available. SSEs are popular for applications requiring real-time data, including AI providers such as [OpenAI](https://platform.openai.com/docs/api-reference/chat/create#chat/create-stream).

相比之下，Web Streams 在所有数据发送完毕后即关闭 HTTP 连接；而服务器发送事件（SSE）则采用长连接（long-lived HTTP connection），确保服务器可在新事件就绪时持续推送。SSE 广泛应用于需要实时数据的场景，例如 [OpenAI](https://platform.openai.com/docs/api-reference/chat/create#chat/create-stream) 等人工智能服务提供商。

To handle the SSE’s returned plain text response, we can use the [`eventsource-parser`](https://github.com/rexxars/eventsource-parser) library to parse the fragmented chunks that are passed through the `feed` function.

为处理 SSE 返回的纯文本响应，我们可以使用 [`eventsource-parser`](https://github.com/rexxars/eventsource-parser) 库，对经由 `feed` 函数传递的分片数据块进行解析。

```javascript
import { createParser } from "eventsource-parser";

export function OpenAITextStream(

3  res: Response,

4): ReadableStream {
```

5  const encoder = new TextEncoder()

5  const encoder = new TextEncoder()

6  const decoder = new TextDecoder()

6  const decoder = new TextDecoder()

8  let counter = 0

8  let counter = 0

10  const stream = new ReadableStream({

10  const stream = new ReadableStream({

11    async start(controller): Promise<void> {

11    async start(controller): Promise<void> {

12      function onParse(event: ParsedEvent | ReconnectInterval): void {

12      function onParse(event: ParsedEvent | ReconnectInterval): void {

13        if (event.type === 'event') {

13        if (event.type === 'event') {

14          const data = event.data

14          const data = event.data

15          if (data === '[DONE]') {

15          如果 data 等于 '[DONE]'：

16            controller.close()

16            controller.close()

17            return

17            返回

18          }

18          }

19          try {

19          尝试 {

20            const json = JSON.parse(data)

20            const json = JSON.parse(data)

21            const text =

21            const text =

22              json.choices[0]?.delta?.content ?? json.choices[0]?.text ?? ''

22              json.choices[0]?.delta?.content ?? json.choices[0]?.text ?? ''

24            if (counter < 2 && (text.match(/\n/) || []).length) {

24            如果 counter < 2 且 (text.match(/\n/) || []).length 成立：

25              return

25              返回

26            }

26            }

28            const queue = encoder.encode(`${JSON.stringify(text)}\n`)

28            const queue = encoder.encode(`${JSON.stringify(text)}\n`)

29            controller.enqueue(queue)

29            controller.enqueue(queue)

31            counter++

31            counter++

32          } catch (e) {

32          } catch (e) {

33            controller.error(e)

33            controller.error(e)

34          }

34          }

35        }

35        }

36      }

36      }

38      const parser = createParser(onParse)

38      const parser = createParser(onParse)

39      // [Asynchronously iterate](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/for-await...of) the response's body

39      // [异步迭代](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/for-await...of) 响应体

40      for await (const chunk of res.body as any) {

40      for await (const chunk of res.body as any) {

41        parser.feed(decoder.decode(chunk))

41        parser.feed(decoder.decode(chunk))

42      }

42      }

43    }

43    }

44  })

44  })

46  return stream

46  返回 stream

47}
```

47}
```

A complete example can be found [in this repo](https://github.com/Nutlope/twitterbio/blob/8d40e3cbbf7603f65641e5978899d30aa72fdca4/utils/OpenAIStream.ts#L39).

完整示例可参见 [该代码仓库](https://github.com/Nutlope/twitterbio/blob/8d40e3cbbf7603f65641e5978899d30aa72fdca4/utils/OpenAIStream.ts#L39)。

## Streaming on Vercel

## 在 Vercel 上实现流式传输

Vercel 支持在 Edge 和 Serverless 环境中使用 Web Streams，从而能够高效地处理实时数据。它既可将 JSON 数据流式传输回客户端，也可逐步渲染 UI 组件。

```javascript
export const config = {

2  runtime: "edge",

3};
```

```javascript
export const config = {

2  runtime: "edge",

3};
```

```javascript
const delay = (ms) => new Promise((res) => setTimeout(res, ms));

const delay = (毫秒) => new Promise((res) => setTimeout(res, 毫秒));
```


```javascript
export default async function handler() {

export default async function handler() {
```


```javascript
8  const encoder = new TextEncoder();

8  const encoder = new TextEncoder();
```


```javascript
10  const readable = new ReadableStream({

10  const readable = new ReadableStream({
```


```javascript
11    async start(controller) {

11    async start(controller) {
```


```javascript
12      controller.enqueue(encoder.encode("<html><body>"));

12      controller.enqueue(encoder.encode("<html><body>"));
```


```javascript
13      await delay(500);

13      await delay(500);
```


```javascript
14      controller.enqueue(encoder.encode("<ul><li>List Item 1</li>"));

14      controller.enqueue(encoder.encode("<ul><li>List Item 1</li>"));
```

15      await delay(500);

15      等待 500 毫秒；

16      controller.enqueue(encoder.encode("<li>List Item 2</li>"));

16      controller.enqueue(encoder.encode("<li>列表项 2</li>"));

17      await delay(500);

17      等待 500 毫秒；

18      controller.enqueue(encoder.encode("<li>List Item 3</li></ul>"));

18      controller.enqueue(encoder.encode("<li>列表项 3</li></ul>"));

19      await delay(500);

19      等待 500 毫秒；

20      controller.enqueue(encoder.encode("</body></html>"));

20      controller.enqueue(encoder.encode("</body></html>"));

21      controller.close();

21      controller.close();

22    },

22    }，

23  });

23  });

25  return new Response(readable, {

25  返回新的 Response(readable, {

26    headers: { "Content-Type": "text/html; charset=utf-8" },

26    headers: { "Content-Type": "text/html; charset=utf-8" },

27  });

27  });

28}

28}

Progressively rendering can be used to improve perceived performance for users, especially those with slow internet connections. The same principle applies to streaming JSON data, where you might want to send parts of a large dataset as they become available.

渐进式渲染可用于提升用户感知的性能，尤其对网络连接较慢的用户效果显著。这一原理同样适用于 JSON 数据流式传输——当大型数据集的各部分陆续就绪时，即可立即发送。

### Vercel AI SDK

### Vercel AI SDK

Building UIs around LLM data has become increasingly popular with the rise of AI providers, and streaming LLM responses have introduced significant changes in app development.

随着 AI 服务提供商的兴起，围绕大语言模型（LLM）数据构建用户界面已日益流行；而 LLM 响应的流式传输则为应用开发带来了重大变革。

The decision to use streaming depends on factors such as the language model's size, response speed, and response length. Large models can generate complex responses but may slow down response times due to increased computational demands. Smaller models, while less capable, deliver quicker responses.

是否采用流式传输，取决于多种因素，例如语言模型的规模、响应速度及响应长度。大型模型虽能生成更复杂的响应，但因计算开销更大，可能导致响应延迟；小型模型能力相对有限，却可提供更快的响应速度。

The model size and interface style choice rely on factors like required response speed and complexity. [Streaming](https://platform.openai.com/docs/api-reference/completions/create#completions/create-stream) lengthier responses can boost the perceived responsiveness, but it demands a more complex setup and management than a blocking UI.

模型规模与界面风格的选择，需综合考量所需的响应速度与功能复杂度等因素。[流式传输](https://platform.openai.com/docs/api-reference/completions/create#completions/create-stream)较长的响应内容可增强用户感知的响应灵敏度，但其配置与管理比阻塞式（blocking）UI 更为复杂。

The [Vercel AI SDK](https://sdk.vercel.ai/) helps minimize the boilerplate associated with handling streaming responses, making fetching and rendering streaming responses much easier.

[Verce AI SDK](https://sdk.vercel.ai/) 可大幅减少处理流式响应所需的模板代码，使获取与渲染流式响应变得轻松许多。

`app/api/chat/route.ts`

`app/api/chat/route.ts`

```javascript
import { OpenAIStream, StreamingTextResponse } from 'ai'



export const runtime = 'edge'



export async function POST(req: Request) {

6  const response = await openai.createChatCompletion({

7    model: 'gpt-3.5-turbo',

8    stream: true,

9    messages: [...]
```

```javascript
import { OpenAIStream, StreamingTextResponse } from 'ai'



export const runtime = 'edge'



export async function POST(req: Request) {

6  const response = await openai.createChatCompletion({

7    model: 'gpt-3.5-turbo',

8    stream: true,

9    messages: [...]
```

10  })

10  })

11  // Convert the response into a friendly text-stream

11  // 将响应转换为友好的文本流

12  const stream = OpenAIStream(response)

12  const stream = OpenAIStream(response)

13  // Respond with the stream

13  // 使用该流作为响应

14  return new StreamingTextResponse(stream)

14  return new StreamingTextResponse(stream)

15}
15}

```

This streaming response can be used by the package’s [`useChat`](https://sdk.vercel.ai/docs/api-reference) and [`useCompletion`](https://sdk.vercel.ai/docs/api-reference) [hooks](https://sdk.vercel.ai/docs/api-reference), which can be used to build a UI around the response easily.

```

此流式响应可被该软件包的 [`useChat`](https://sdk.vercel.ai/docs/api-reference) 和 [`useCompletion`](https://sdk.vercel.ai/docs/api-reference) [钩子（hooks）](https://sdk.vercel.ai/docs/api-reference) 所使用，从而轻松构建围绕该响应的用户界面。

```javascript
1'use client'



import { useChat } from 'ai'

```javascript
1'use client'



import { useChat } from 'ai'

```javascript
export default function Chat() {

6  const { messages, input, handleInputChange, handleSubmit } = useChat()



8  return ...

9}
```

```javascript
export default function Chat() {

6  const { messages, input, handleInputChange, handleSubmit } = useChat()



8  return ...

9}
```

## **Conclusion**

## **总结**

Web streams have fundamentally transformed the way we handle data in web applications. They provide a powerful, efficient, and standardized way to process large amounts of data asynchronously.

Web 流从根本上改变了我们在 Web 应用程序中处理数据的方式。它们提供了一种强大、高效且标准化的异步处理大量数据的方法。

With their capability to handle backpressure and deliver data chunk-by-chunk, they can significantly enhance the performance of applications, especially those dealing with heavy data loads or operating over slow network connections. Transforming data during transit opens up a whole new realm of possibilities for data processing and manipulation.

凭借其应对背压（backpressure）的能力以及逐块（chunk-by-chunk）传输数据的特性，Web 流可显著提升应用程序性能，尤其适用于处理高负载数据或运行在慢速网络连接环境下的应用。在数据传输过程中实时转换数据，为数据处理与操作开辟了全新的可能性。

Blog post

博客文章

Jun 22, 2023

2023年6月22日

### An Introduction to Streaming on the Web

### 网页流式传输入门

![](images/an-introduction-to-streaming-on-the-web-vercel/img_011.jpg)

Lydia Hallie

Lydia Hallie

Blog post

博客文章

Jul 28, 2022

2022年7月28日

### Build your own web framework

### 构建你自己的 Web 框架

![](images/an-introduction-to-streaming-on-the-web-vercel/img_011.jpg)

Lydia Hallie

Lydia Hallie