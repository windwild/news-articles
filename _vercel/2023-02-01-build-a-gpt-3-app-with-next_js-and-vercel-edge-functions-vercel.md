---
title: "Build a GPT-3 app with Next.js and Vercel Edge Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/gpt-3-app-next-js-vercel-edge-functions"
date: "2023-02-01"
scraped_at: "2026-03-02T09:55:51.340246995+00:00"
language: "en-zh"
translated: true
description: "Learn how to build GPT-3 AI apps with OpenAI, Next.js, and Vercel Edge Functions."
---
{% raw %}

Feb 1, 2023

2023 年 2 月 1 日

一个用于快速构建 GPT-3 应用的全栈模板。

人工智能领域持续席卷全球。借助 ChatGPT、GPT-3、DALL-E 和 Stable Diffusion 等工具，文本与图像生成技术已取得巨大进展。这催生了一波令人振奋的 AI 初创公司浪潮，其中许多公司正[使用 Vercel 和 Next.js 构建](https://twitter.com/steventey/status/1610656840412696578?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_building_a_gpt3_app)。

AI 领域最激动人心的发展之一便是 GPT-3——由[OpenAI](https://vercel.com/docs/integrations/openai) 开发的前沿自然语言处理模型。凭借其理解与生成类人文本的能力，GPT-3 有望彻底改变我们完成诸多任务的方式。

在本文中，我们将详细讲解如何结合 OpenAI、Next.js 以及[Vercel Edge Functions](https://vercel.com/features/edge-functions) 构建 GPT-3 应用。具体实践将围绕构建 [twitterbio.com](https://www.twitterbio.com/) 展开：首先使用无服务器函数（serverless functions）实现，再基于 Edge Functions 重构，并引入流式响应（streaming），以充分展现其在速度与用户体验方面的优势。最终，你将能够独立开发属于自己的 GPT-3 驱动应用。

## 前端

Next.js 前端包含以下几部分：

- 一个文本框，供用户粘贴当前个人简介，或输入几句关于自身的描述；

- 一个下拉菜单，供用户选择所期望生成简介的语气风格；

- 一个提交按钮，用于触发简介生成操作；点击后将调用一个 API 路由，该路由调用 OpenAI 的 GPT-3 模型，并返回两条生成的简介。

- 两个用于显示 API 接口返回的生成结果（即新 Twitter 简介）的容器  

- 两个用于显示从 API 路由返回的生成简介的容器  

Here’s what the code for our [index page](https://github.com/Nutlope/twitterbio/blob/serverless/pages/index.tsx) looks like. We have a few pieces of state that correspond to the elements mentioned above. We’re also defining a prompt—like ChatGPT, we need to send a prompt to GPT-3 to instruct it to generate the new bios. Finally, we ask GPT-3 to generate two bios clearly labeled (so we can parse them correctly) using the user-provided bio and vibe as context.  

以下是我们的 [首页](https://github.com/Nutlope/twitterbio/blob/serverless/pages/index.tsx) 代码。其中包含若干与上述 UI 元素相对应的状态变量。我们还定义了一个提示词（prompt）——与 ChatGPT 类似，我们需要向 GPT-3 发送一条提示指令，以指导其生成新的简介。最后，我们要求 GPT-3 基于用户提供的原始简介（bio）和风格偏好（vibe）作为上下文，明确生成两条简介，并分别标注为 “1.” 和 “2.”（以便后续准确解析）。

```javascript
const prompt = `Generate 2 ${vibe} twitter bios with no hashtags and clearly labeled "1."

2 and "2.". Make sure each generated bio is at least 14 words and at max 20 words and base

3 them on this context: ${bio}`;
```

```javascript
const prompt = `请生成两条符合“${vibe}”风格的 Twitter 简介，不包含任何话题标签（hashtags），并清晰标注为“1.”和“2.”。每条生成的简介至少包含 14 个单词、最多不超过 20 个单词，并严格基于以下上下文进行创作：${bio}`;
```

The rest of our index page is comprised of the UI elements themselves: our text box, dropdown, submit button, and two containers on the bottom that we display when we get the generated bios. There's also some loading logic for the button to show a loading indicator when clicked.  

首页其余部分则由实际的 UI 元素构成：文本输入框、下拉选择框、提交按钮，以及位于页面底部的两个容器（用于在获取生成简介后展示结果）。此外，提交按钮还集成了加载状态逻辑——点击时会显示加载指示器。

GenerateBio.tsx  

GenerateBio.tsx  

```tsx
1<textarea

2  value={bio}

3  onChange={(e) => setBio(e.target.value)}
```  

```tsx
1<textarea

2  value={bio}

3  onChange={(e) => setBio(e.target.value)}
```

4  rows={4}

4  行数={4}

5  className="..."

5  className="..."

6  placeholder={"e.g. Senior Engineer @vercel. Tweeting about web dev & AI."}

6  占位符={"例如：高级工程师 @vercel，分享网页开发与人工智能相关内容。"}

7/>

7/>

8<div className="...">

8<div className="...">

9  <Image src="/2-black.png" width={30} height={30} alt="1 icon" />

9  <Image src="/2-black.png" width={30} height={30} alt="1 icon" />

10  <p className="...">Select your vibe.</p>

10  <p className="...">选择你的风格。</p>

11</div>

11</div>

12<div className="block">

12<div className="block">

13  <DropDown vibe={vibe} setVibe={(newVibe) => setVibe(newVibe)} />

13  <DropDown vibe={vibe} setVibe={(newVibe) => setVibe(newVibe)} />

14</div>

14</div>

15<button className="..." onClick={(e) => generateBio(e)}>

15<button className="..." onClick={(e) => generateBio(e)}>

16  Generate your bio &rarr;

16  生成您的个人简介 &rarr;

17</button>

17</button>

18<hr className="..." />

18<hr className="..." />

19<div className="...">

19<div className="...">

20  {generatedBios && (

20  {generatedBios && (

21    <>

21    <>

22      <div>

22      <div>

23        <h2 className="...">Your generated bios</h2>

23        <h2 className="...">您生成的个人简介</h2>

24      </div>

24      </div>

25      <div className="...">

25      <div className="...">

26        {generatedBios

26        {generatedBios

27          .substring(generatedBios.indexOf("1") + 3)

27          .substring(generatedBios.indexOf("1") + 3)

28          .split("2.")

28          .split("2.")

29          .map((generatedBio: any) => {

29          .map((generatedBio: any) => {

30            return (

30            return (

31              <div className="..." key={generatedBio}>

31              <div className="..." key={generatedBio}>

32                <p>{generatedBio}</p>

32                <p>{generatedBio}</p>

33              </div>

34            );

35          })}

36      </div>

37    </>

38  )}

39</div>
```

除了 UI 元素和加载逻辑外，我们还定义了一个 `generateBio` 函数，当用户点击提交按钮时会调用该函数。该函数向我们的 `/api/generate` API 路由发送一个 `POST` 请求，并将提示词（prompt）作为请求体（body）发送。

GenerateBio.tsx

```tsx
const generateBio = async (e: any) => {

2  e.preventDefault();

3  setGeneratedBios("");

3  设置生成的生物信息为空字符串（""）；

4  setLoading(true);

4  设置加载状态为 true；

6  const response = await fetch("/api/generate", {

6  const response = await fetch("/api/generate", {

7    method: "POST",

7    method: "POST",

8    headers: {

8    headers: {

9      "Content-Type": "application/json",

9      "Content-Type": "application/json",

10    },

10    },

11    body: JSON.stringify({

11    body: JSON.stringify({

12      prompt,  

12      prompt,

13    }),

13    }），

14  });



14  }）；

16  if (!response.ok) {

16  if (!response.ok) {

17    throw new Error(response.statusText);

17    throw new Error(response.statusText);

18  }



18  }

20  let answer = await response.json();

20  let answer = await response.json();

21  setGeneratedBios(answer.choices[0].text);

21  setGeneratedBios(answer.choices[0].text);

22  setLoading(false);

22  setLoading(false);

23};
```

我们从 API 路由获取生成的个人简介（bios），将其保存到 `generatedBios` 状态中，然后向用户展示。由于我们要求 GPT-3 以特定的编号格式（如“1.”、“2.”）返回文本，因此可以基于字符串 “2.” 进行分割，从而将两个个人简介清晰地分隔并分别渲染在独立的容器中，效果如下图所示。

![Screenshot of the site showing two generated bios.](images/build-a-gpt-3-app-with-next_js-and-vercel-edge-functions-vercel/img_001.jpg)  
网站截图：显示两个已生成的个人简介。

## 后端

使用 Next.js 的一大优势在于，我们可以在同一个应用中同时处理前端与后端逻辑。只需在 `api` 文件夹中创建一个名为 `generate.ts` 的文件，即可快速启动一条 API 路由。下面我们来看 `/api/generate` 这条 API 路由的实现。

我们从请求体（request body）中提取前端传入的 `prompt`，然后构建一个发送至 OpenAI 的请求载荷（payload）。该载荷中包含若干关键参数，例如所用模型（GPT-3）以及期望 OpenAI 返回的最大 token 数量（1 个 token 约等于 4 个字符）。此处我们限制最大 token 数，是因为 Twitter 个人简介有严格的字符长度限制。

载荷构建完成后，我们通过 `POST` 请求将其发送给 OpenAI，等待响应并获取生成的个人简介，最后以 JSON 格式将结果返回给客户端。

generate.js

```javascript
export default async function handler(req, res) {

2  const { prompt } = req.body;

4  const payload = {

4  const payload = {

5    model: "text-davinci-003",

5    model: "text-davinci-003",

6    prompt,

6    prompt,

7    temperature: 0.7,

7    temperature: 0.7,

8    top_p: 1,

8    top_p: 1,

9    frequency_penalty: 0,

9    frequency_penalty: 0,

10    presence_penalty: 0,

10    presence_penalty: 0,

11    max_tokens: 200,

11    max_tokens: 200,

12    n: 1,

12    n: 1,

13  };

13  };

15  const response = await fetch("https://api.openai.com/v1/completions", {

15  const response = await fetch("https://api.openai.com/v1/completions", {

16    headers: {

16    头部信息（headers）：{

17      "Content-Type": "application/json",

17      "Content-Type": "application/json",

18      Authorization: `Bearer ${process.env.OPENAI_API_KEY ?? ""}`,

18      Authorization: `Bearer ${process.env.OPENAI_API_KEY ?? ""}`,

19    },

19    },

20    method: "POST",

20    请求方法（method）： "POST",

21    body: JSON.stringify(payload),

21    请求体（body）： JSON.stringify(payload),

22  });

22  });

24  const json = await response.json();

24  const json = await response.json();

25  res.status(200).json(json);

25  res.status(200).json(json);

26}
```

26}
```

There we have it! We built the first version of our application. Feel free to check out the [code](https://github.com/Nutlope/twitterbio/tree/serverless) and [demo](https://twitterbio-git-serverless-randomteam.vercel.app/) for this approach.

大功告成！我们已构建出本应用的第一个版本。欢迎查看该方案的 [源代码](https://github.com/Nutlope/twitterbio/tree/serverless) 和 [演示页面](https://twitterbio-git-serverless-randomteam.vercel.app/)。

## Limitations of the serverless function approach

## 无服务器函数方案的局限性

While this serverless approach works, there are some limitations that make edge a better fit for this kind of application:

尽管这种无服务器方案可以运行，但存在若干局限性，使得边缘计算（Edge）更适合此类应用：

1. If we’re building an app where we want to await longer responses, such as generating entire blog posts, responses will likely take over 10 seconds which can lead to serverless timeout issues on Vercel’s Hobby tier. Vercel's [Pro tier](https://vercel.com/pricing) has a 60-second timeout which is usually enough for GPT-3 applications.

1. 如果我们正在构建一个需要等待较长时间响应的应用（例如生成整篇博客文章），响应时间很可能超过 10 秒，从而导致 Vercel 免费版（Hobby tier）出现无服务器函数超时问题。Vercel 的 [专业版（Pro tier）](https://vercel.com/pricing) 提供 60 秒超时限制，通常足以满足 GPT-3 类应用的需求。

2. Waiting several seconds before seeing any data isn't a good user experience. Ideally, we want to incrementally show the user data as it’s being generated—similar to how ChatGPT works.

2. 用户需等待数秒才看到任何数据，这并非良好的用户体验。理想情况下，我们希望在数据生成过程中逐步向用户呈现——正如 ChatGPT 所做的那样。

3. The responses may take even longer due to the cold start that’s present in serverless lambda functions.

3. 由于无服务器 Lambda 函数固有的“冷启动”（cold start）现象，响应时间可能进一步延长。

**Thankfully, there is a better way to build this application that addresses all three of these problems:** [**Vercel Edge Functions**](https://vercel.com/features/edge-functions) **with streaming.**  
**值得庆幸的是，有一种更优的方式可构建该应用，从而一举解决上述三个问题：**[**Vercel 边缘函数（Edge Functions）**](https://vercel.com/features/edge-functions)**配合流式响应（streaming）。**

Edge Functions may not always be the answer, especially if you're relying on specific Node.js libraries that are not edge compatible. In this case however, they will work great.  
边缘函数并非万能解法，尤其当你依赖某些不兼容边缘环境的特定 Node.js 库时。但在本例中，它们将表现得非常出色。

Let’s explore what Edge Functions are and how we can migrate our app to use them for faster generations and a better user experience.  
接下来，让我们深入探讨什么是边缘函数，以及如何将我们的应用迁移到边缘函数，以实现更快的响应生成和更佳的用户体验。

## Edge Functions vs. Serverless Functions

## 边缘函数 vs. 无服务器函数（Serverless Functions）

You can think of Edge Functions as serverless functions with a more lightweight runtime. They have a smaller code size limit, smaller memory, and don’t support all Node.js libraries. So you may be thinking—why would I want to use them?  
你可以将边缘函数理解为一种运行时更轻量化的无服务器函数。它们的代码体积限制更小、内存占用更低，且并非支持全部 Node.js 库。因此你可能会问：我为什么要选用它们？

Three answers: speed, UX, and longer timeouts.  
三个答案：速度更快、用户体验更优、超时时间更长。

1. Because Edge Functions use a smaller edge runtime and run very close to users on the edge, they’re also fast. They have virtually no cold starts and are significantly faster than serverless functions.  
1. 由于边缘函数采用更精简的边缘运行时，并在靠近用户的边缘节点上执行，因此响应极快——几乎不存在冷启动延迟，性能显著优于传统无服务器函数。

2. They allow for a great user experience, especially when paired with streaming. Streaming a response breaks it down into small chunks and progressively sends them to the client, as opposed to waiting for the entire response before sending it.  
2. 它们能带来卓越的用户体验，尤其是与流式响应结合使用时。流式响应将完整响应拆分为多个小数据块，并持续逐块发送至客户端，而非等待整个响应生成完毕后再一次性发送。

3. Edge Functions have a timeout of 25 seconds and even longer when streaming, which far exceeds the timeout limit for serverless functions on Vercel’s Hobby plan. Using these can allow you to get past timeout issues when using AI APIs that take longer to respond. As an added benefit, Edge Functions are also cheaper to run.  
3. 边缘函数默认超时时间为 25 秒；启用流式响应时，超时时间还可进一步延长——远超 Vercel 免费版（Hobby plan）中无服务器函数的超时限制。使用边缘函数可有效规避调用响应较慢的 AI API 时所遭遇的超时问题。此外，边缘函数的运行成本也更低。

_To see a demo of Serverless vs Edge Functions in action, check out the video below, specifically from 4:05 to 4:40._  
_如需观看无服务器函数与边缘函数的实际对比演示，请观看下方视频，重点关注 4:05 至 4:40 时间段。_

An explanation for how to build GPT-3 powered apps with OpenAI and Vercel Edge Functions.  
本内容讲解如何借助 OpenAI 和 Vercel 边缘函数构建基于 GPT-3 的应用程序。

## Edge Functions with streaming

## 使用流式传输的边缘函数

Now that we understand the benefits and cost-effectiveness of using Edge Functions, let’s refactor our existing code to use them. Let’s start with our backend's API route.

既然我们已经了解了使用边缘函数（Edge Functions）的优势及其成本效益，接下来让我们重构现有代码以采用边缘函数。我们从后端的 API 路由开始。

The first thing we do is define a config variable and set the runtime to `"edge"`. This is all you need to define this API route as an Edge Function. We also added an extra variable to our payload, `stream: true`, to make sure OpenAI streams in chunks back to the client.

首先，我们定义一个 `config` 变量，并将 `runtime` 设置为 `"edge"`。仅此一项配置，即可将该 API 路由声明为边缘函数。此外，我们还在请求负载（payload）中额外添加了一个字段 `stream: true`，以确保 OpenAI 以数据块（chunks）形式将响应流式传输回客户端。

Finally, the last major change to this file is to define the stream variable after specifying the payload. We used a helper function, `OpenAIStream`, to enable us to incrementally stream responses to the client as we get data from OpenAI.

最后，该文件最关键的改动是在指定请求负载之后定义 `stream` 变量。我们使用了一个辅助函数 `OpenAIStream`，以便在从 OpenAI 接收数据的同时，将响应逐步流式传输给客户端。

generate.ts

generate.ts

```tsx
import { OpenAIStream } from "../../utils/OpenAIStream";



export const config = {

4  runtime: "edge",

5};
```

```typescript
const handler = async (req: Request): Promise<Response> => {

const handler = async (req: Request): Promise<Response> => {

8  const { prompt } = (await req.json()) as {

8  const { prompt } = (await req.json()) as {

9    prompt?: string;

9    prompt?: string;

10  };

10  };



12  const payload = {

12  const payload = {

13    model: "text-davinci-003",

13    model: "text-davinci-003",

14    prompt,

14    prompt,

15    temperature: 0.7,

15    temperature: 0.7,
```

16    top_p: 1,

16    top_p：1，

17    frequency_penalty: 0,

17    频率惩罚（frequency_penalty）：0，

18    presence_penalty: 0,

18    存在惩罚（presence_penalty）：0，

19    max_tokens: 200,

19    最大 token 数（max_tokens）：200，

20    stream: true,

20    流式响应（stream）：true，

21    n: 1,

21    返回结果数量（n）：1，

22  };

22  };



24  const stream = await OpenAIStream(payload);

24  const stream = await OpenAIStream(payload);

25  return new Response(stream);

25  return new Response(stream);

26};



export default handler;
```

让我们来看看所使用的辅助函数。它向 OpenAI 发送一个 `POST` 请求，并附带请求载荷（payload），其方式与我们在无服务器（serverless）版本中所做的类似；但相似之处也仅止于此。我们创建了一个流（stream），用于持续解析从 OpenAI 接收到的数据，同时等待 `[DONE]` 标记的到达——因为该标记标志着响应流的结束。一旦收到 `[DONE]`，我们就关闭该流。

OpenAIStream.ts

```tsx
import { createParser, ParsedEvent, ReconnectInterval } from "eventsource-parser";



export async function OpenAIStream(payload) {

4  const encoder = new TextEncoder();

5  const decoder = new TextDecoder();

7  let counter = 0;

7  let counter = 0;

9  const res = await fetch("https://api.openai.com/v1/completions", {

9  const res = await fetch("https://api.openai.com/v1/completions", {

10    headers: {

10    headers: {

11      "Content-Type": "application/json",

11      "Content-Type": "application/json",

12      Authorization: `Bearer ${process.env.OPENAI_API_KEY ?? ""}`,

12      Authorization: `Bearer ${process.env.OPENAI_API_KEY ?? ""}`,

13    },

13    },

14    method: "POST",

14    method: "POST",

15    body: JSON.stringify(payload),

15    body: JSON.stringify(payload),

16  });



16  });



18  const stream = new ReadableStream({

18  const stream = new ReadableStream({



19    async start(controller) {

19    async start(controller) {



20      function onParse(event: ParsedEvent | ReconnectInterval) {

20      function onParse(event: ParsedEvent | ReconnectInterval) {



21        if (event.type === "event") {

21        如果 event.type === "event"：



22          const data = event.data;

22          const data = event.data;



23          if (data === "[DONE]") {

23          如果 data === "[DONE]"：



24            controller.close();

24            controller.close();



25            return;

25            返回；

26          }

26          }

27          try {

27          try {

28            const json = JSON.parse(data);

28            const json = JSON.parse(data);

29            const text = json.choices[0].text;

29            const text = json.choices[0].text;

30            if (counter < 2 && (text.match(/\n/) || []).length) {

30            如果 counter 小于 2，且 text 中包含换行符（即 `text.match(/\n/)` 的匹配结果非空），

31              return;

31              则直接返回。

32            }

32            }

33            const queue = encoder.encode(text);

33            const queue = encoder.encode(text);

34            controller.enqueue(queue);

34            controller.enqueue(queue);

35            counter++;

35            counter++;

36          } catch (e) {

36          } catch (e) {

37            controller.error(e);

37            controller.error(e);

38          }

38          }

39        }

39        }

40      }

40      }



42     // stream response (SSE) from OpenAI may be fragmented into multiple chunks

42     // OpenAI 返回的流式响应（SSE）可能被分割为多个数据块

43     // this ensures we properly read chunks & invoke an event for each SSE event stream

43     // 这确保我们能正确读取每个数据块，并为每一条 SSE 事件流触发相应事件

44     const parser = createParser(onParse);

44     const parser = createParser(onParse);

46      // https://web.dev/streams/#asynchronous-iteration

46      // https://web.dev/streams/#异步迭代

47      for await (const chunk of res.body as any) {

47      for await (const chunk of res.body as any) {

48        parser.feed(decoder.decode(chunk));

48        parser.feed(decoder.decode(chunk));

49      }

49      }

50    },

50    },

51  });



51  });



53  return stream;

53  return stream;

54}
```

54}
```

In our frontend, the only code that changes is our `generateBio` function. Specifically, we define a reader using the native web API, [getReader()](https://developer.mozilla.org/en-US/docs/Web/API/ReadableStream/getReader), and progressively add data to our `generatedBio` state as it’s streamed in.

在我们的前端中，唯一发生变化的代码是 `generateBio` 函数。具体而言，我们使用原生 Web API [`getReader()`](https://developer.mozilla.org/zh-CN/docs/Web/API/ReadableStream/getReader) 创建一个读取器，并随着数据流式传输逐步将数据添加到 `generatedBio` 状态中。

GenerateBio.tsx

GenerateBio.tsx

```tsx
const generateBio = async (e: any) => {

```tsx
const generateBio = async (e: any) => {

2    e.preventDefault();

2    e.preventDefault();

3    setGeneratedBios("");

3    清空已生成的简介内容（setGeneratedBios("")）；

4    setLoading(true);

4    启用加载状态（setLoading(true)）；

5    const response = await fetch("/api/generate", {

5    const response = await fetch("/api/generate", {

6      method: "POST",

6      method: "POST",

7      headers: {

7      headers: {

8        "Content-Type": "application/json",

8        "Content-Type": "application/json",

9      },

9      },

10      body: JSON.stringify({

10      body: JSON.stringify({

11        prompt,

11        prompt,

12      }),

12      }),

13    });



13    });



15    if (!response.ok) {

15    if (!response.ok) {

16      throw new Error(response.statusText);

16      throw new Error(response.statusText);

17    }



17    }



19    const data = response.body;

19    const data = response.body;

20    if (!data) {

20    如果 `data` 为空（为 `null` 或 `undefined`），则：

21      return;

21      直接返回。

22    }

22    }

23    const reader = data.getReader();

23    const reader = data.getReader();

24    const decoder = new TextDecoder();

24    const decoder = new TextDecoder();

25    let done = false;

25    let done = false;



27    while (!done) {

27    当 `done` 为 `false` 时循环执行：

28      const { value, done: doneReading } = await reader.read();

28      const { value, done: doneReading } = await reader.read();

29      done = doneReading;

29      done = doneReading;

30      const chunkValue = decoder.decode(value);

30      const chunkValue = decoder.decode(value);

31      setGeneratedBios((prev) => prev + chunkValue);

31      setGeneratedBios((prev) => prev + chunkValue);

32    }



32    }



34    setLoading(false);

34    setLoading(false);

35  };
```

35  };
```

We’ve now refactored our app to use Edge Functions with streaming, making it faster and greatly improving the user experience by incrementally displaying data as it comes in.

我们现已重构应用，使其采用支持流式传输的 Edge Functions，从而提升了响应速度，并通过随数据到达而逐步显示内容的方式，大幅改善了用户体验。

## Resources

## 资源

We hope this walkthrough helps you build incredible GPT-3 powered applications. We’ve already seen several sites built with this template such as [Rephraser](https://twitter.com/jsonjun/status/1617739994529148928), [GenzTranslator](https://twitter.com/verfasor/status/1616861894069088256), and [ChefGPT](https://twitter.com/madeinusmate/status/1616698060398264323)—some of which have thousands of users. Visit the [Twitter Bio site](https://www.twitterbio.com/) to see everything we talked about in action, check out our [other AI templates](https://vercel.com/templates/ai), or start optimizing prompts across various models with Vercel's [AI Playground](https://play.vercel.ai/).

我们希望本教程能助您构建出令人惊叹的、由 GPT-3 驱动的应用程序。目前已有多款基于该模板构建的网站上线，例如 [Rephraser](https://twitter.com/jsonjun/status/1617739994529148928)、[GenzTranslator](https://twitter.com/verfasor/status/1616861894069088256) 和 [ChefGPT](https://twitter.com/madeinusmate/status/1616698060398264323)，其中部分网站用户数已达数千人。欢迎访问 [Twitter Bio 网站](https://www.twitterbio.com/) 亲身体验本文所述全部功能；浏览我们的 [其他 AI 模板](https://vercel.com/templates/ai)；或使用 Vercel 的 [AI Playground](https://play.vercel.ai/)，在多种模型间优化您的提示词（prompts）。

Vercel Template

Vercel 模板

Deploy this template

部署此模板

### Generate your Twitter bio with OpenAI GPT-3 API (text-davinci-003) and Vercel Edge Functions with streaming.

### 使用 OpenAI GPT-3 API（text-davinci-003）和支持流式响应的 Vercel Edge Functions 生成你的 Twitter 个人简介。

AI Twitter Bio Generator

AI Twitter 个人简介生成器

Vercel Template

Vercel 模板

Deploy this template

部署此模板

### An AI Face Photo Restorer built on Next.js and Replicate.

### 一款基于 Next.js 和 Replicate 构建的 AI 人脸照片修复工具。

AI Photo Restorer

AI 照片修复器
{% endraw %}
