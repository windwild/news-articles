---
title: "Common mistakes with the Next.js App Router and how to fix them - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/common-mistakes-with-the-next-js-app-router-and-how-to-fix-them"
date: "2024-01-08"
scraped_at: "2026-03-02T09:48:39.372324639+00:00"
language: "en-zh"
translated: true
description: "Learn how to use the Next.js App Router more effectively and understand the new model."
---

Jan 8, 2024

2024 年 1 月 8 日

After talking to hundreds of developers and looking at thousands of Next.js repositories, I've noticed ten common mistakes when building with the Next.js App Router.

在与数百名开发者交流、并审阅了数千个 Next.js 仓库后，我总结出使用 Next.js App Router 构建应用时最常见的十个错误。

This post will share why these mistakes can happen, how to fix them, and some tips to help you understand the new App Router model.

本文将分析这些错误产生的原因、提供相应的修复方法，并分享一些有助于你深入理解全新 App Router 模型的实用技巧。

## Using Route Handlers with Server Components

## 在服务端组件中使用路由处理器（Route Handlers）

Consider the following code for a Server Component:

以下是一个服务端组件（Server Component）的示例代码：

app/page.tsx

`app/page.tsx`

```tsx
export default async function Page() {

2  let res = await fetch('http://localhost:3000/api/data');

3  let data = await res.json();

4  return <h1>{JSON.stringify(data)}</h1>;
```

5}
```

从服务器组件中的路由处理器（Route Handler）获取 JSON 数据。

这个 `async` 组件向一个路由处理器发起请求，以获取某些 JSON 数据：

app/api/data/route.ts

```tsx
export async function GET(request: Request) {

2  return Response.json({ data: 'Next.js' });

3}
```

一个返回静态 JSON 数据的路由处理器。

这种做法存在两个主要问题：

1. [路由处理器](https://nextjs.org/docs/app/building-your-application/routing/route-handlers) 和 [服务器组件](https://nextjs.org/docs/app/building-your-application/rendering/server-components) 均安全地运行在服务器端。你无需额外增加一次网络调用（network hop）。相反，你可以直接在服务器组件中调用原本计划放在路由处理器内的逻辑——这可能是一个外部 API，也可能是一个任意的 `Promise`。

2. 由于此代码在 Node.js 服务器端运行，我们需要为 `fetch` 提供绝对 URL，而非相对 URL。实际上，我们不应在此处硬编码 `localhost`，而应根据当前所处的运行环境（如开发、测试或生产环境）进行条件判断。但这一处理实属多余，因为我们可以直接调用相关逻辑。

相反，推荐采用以下方式：

app/page.tsx

```tsx
export default async function Page() {

2  // 直接调用你的异步函数

3  let data = await getData(); // { data: 'Next.js' }

4  // 或者直接调用外部 API

5  let data = await fetch('https://api.vercel.app/blog')

6  // ...

7}
```

Server Components are able to fetch data directly.

服务端组件可以直接获取数据。

## Static or dynamic Route Handlers

## 静态或动态路由处理器

Route Handlers are cached by default when using the `GET` method. This can often be confusing for existing Next.js developers moving from the Pages Router and API Routes.

使用 `GET` 方法时，路由处理器默认会被缓存。这对从 Pages Router 和 API Routes 迁移过来的现有 Next.js 开发者而言，常常会造成困惑。

For example, the following code will be prerendered during `next build`:

例如，以下代码将在 `next build` 期间被预渲染：

app/api/data/route.ts

```tsx
export async function GET(request: Request) {

2  return Response.json({ data: 'Next.js' });

3}
```

A Route Handler that returns static JSON data.

一个返回静态 JSON 数据的路由处理器。

This JSON data will not change until another build has completed. Why is that?

该 JSON 数据在下一次构建完成之前不会发生变化。为什么会这样？

You can consider Route Handlers the building blocks of pages. For a given request to a route, you want to handle it. Next.js has further abstractions on top of Route Handlers like pages and layouts. This is why Route Handlers are [static by default](https://nextjs.org/docs/app/building-your-application/routing/route-handlers#caching) (like pages) and share the same [route segment configuration](https://nextjs.org/docs/app/api-reference/file-conventions/route-segment-config) options.

您可以将 Route Handler 视为页面的构建模块。对于发往某个路由的请求，您需要对其进行处理。Next.js 在 Route Handler 的基础上进一步抽象出了诸如 pages（页面）和 layouts（布局）等概念。正因如此，Route Handler 默认是[静态的](https://nextjs.org/docs/app/building-your-application/routing/route-handlers#caching)（与 pages 一致），并共享相同的[路由段配置](https://nextjs.org/docs/app/api-reference/file-conventions/route-segment-config)选项。

This functionality unlocks some new features previously not possible with API Routes in the Pages Router. For example, you can have Route Handlers that produce JSON, or `txt` files, or really _any_ file, which can be computed and prerendered during the build. The statically generated file is then automatically cached, and even [periodically updated](https://nextjs.org/docs/app/building-your-application/routing/route-handlers#revalidating-cached-data) if desired.

这一功能解锁了若干此前在 Pages Router 的 API Routes 中无法实现的新特性。例如，您可以创建生成 JSON、`txt` 文件，甚至真正意义上的**任意类型文件**的 Route Handler；这些文件可在构建时完成计算与预渲染。所生成的静态文件将被自动缓存，并且（如需）还可[定期重新验证](https://nextjs.org/docs/app/building-your-application/routing/route-handlers#revalidating-cached-data)。

app/api/data/route.ts

```tsx
export async function GET(request: Request) {

2  let res = await fetch('https://api.vercel.app/blog');

3  let data = await res.json();

4  return Response.json(data);

5}
```

```tsx
export async function GET(request: Request) {

2  let res = await fetch('https://api.vercel.app/blog');

3  let data = await res.json();

4  return Response.json(data);

5}
```

Return a list of blog posts as JSON data.

以 JSON 格式返回博客文章列表。

Further, this means the Route Handlers are compatible with [Static Exports](https://nextjs.org/docs/app/building-your-application/deploying/static-exports) where you can deploy your Next.js application anywhere that supports static file hosting.

此外，这也意味着 Route Handler 与[静态导出（Static Exports）](https://nextjs.org/docs/app/building-your-application/deploying/static-exports)完全兼容——您可将 Next.js 应用部署到任何支持静态文件托管的平台。

## Route Handlers and Client Components

## 路由处理器与客户端组件

You might think you need to use Route Handlers with Client Components, since they cannot be marked `async` and fetch or mutate data. Rather than needing to write a `fetch` and create a Route Handler, you can instead call [Server Actions](https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions-and-mutations) directly from Client Components.

你可能会认为，由于客户端组件无法标记为 `async`，且不能直接获取或修改数据，因此必须配合使用路由处理器（Route Handlers）。但实际上，你无需自行编写 `fetch` 逻辑或创建路由处理器，而是可以直接从客户端组件中调用 [服务端操作（Server Actions）](https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions-and-mutations)。

app/user-form.tsx

app/user-form.tsx

```tsx
1'use client';



import { save } from './actions';



export function UserForm() {

6  return (

7    <form action={save}>
```

8      <input type="text" name="username" />

8      <input type="text" name="username" />

9      <button>Save</button>

9      <button>保存</button>

10    </form>

10    </form>

11  );

11  );

12}
```

12}
```

A form and input to save a name.

一个用于保存姓名的表单和输入框。

This works with both forms as well as event handlers:

该功能同时支持表单和事件处理器：

app/user-form.tsx

app/user-form.tsx

```tsx
1'use client';

1'use client';

```javascript
import { save } from './actions';



export function UserForm({ username }) {

6  async function onSave(event) {

7    event.preventDefault();

8    await save(username);

9  }



11  return <button onClick={onSave}>Save</button>;

12}
```

```javascript
导入 { save } 模块来自 './actions';



导出函数 UserForm({ username }) {

6  异步函数 onSave(event) {

7    阻止事件默认行为();

8    等待 save(username);

9  }



11  返回 <button onClick={onSave}>保存</button>;

12}
```

Server Actions can be called from event handlers.

服务器操作（Server Actions）可以从事件处理器中调用。

## Using Suspense with Server Components

## 在服务端组件中使用 Suspense

Consider the following Server Component. Where should Suspense be placed to define what fallback UI will be shown while the data is being fetched?

请考虑以下服务端组件。为定义数据获取期间要显示的回退 UI（fallback UI），Suspense 应放置在何处？

app/page.tsx

```tsx
async function BlogPosts() {

2  let data = await fetch('https://api.vercel.app/blog');

3  let posts = await data.json();

4  return (

5    <ul>

6      {posts.map((post) => (

7        <li key={post.id}>{post.title}</li>

7        <li key={post.id}>{post.title}</li>

8      ))}

8      ))}

9    </ul>

9    </ul>

10  );

10  );

11}



11}



export default function Page() {

export default function Page() {

14  return (

14  return (

15    <section>

15    <section>

16      <h1>Blog Posts</h1>

16      <h1>博客文章</h1>

17      <BlogPosts />

17      <BlogPosts />

18    </section>

18    </section>

19  );

19  );

20}
```

20}
```

A page which contains an async component with data fetching.

一个包含异步组件并执行数据获取的页面。

If you guessed inside of the `Page` component, you were correct. The `Suspense` boundary needs to be placed higher than the `async` component doing the data fetching. It will not work if the boundary is inside of the `async` component.

如果你猜测 `Suspense` 边界应置于 `Page` 组件内部，那么你的判断是正确的。`Suspense` 边界必须位于执行数据获取的 `async` 组件的**外层（更高层级）**；若将其置于 `async` 组件内部，则无法生效。

app/page.tsx

app/page.tsx

```tsx
import { Suspense } from 'react';



async function BlogPosts() {
```

4  let data = await fetch('https://api.vercel.app/blog');

4  let data = await fetch('https://api.vercel.app/blog');

5  let posts = await data.json();

5  let posts = await data.json();

6  return (

6  return (

7    <ul>

7    <ul>

8      {posts.map((post) => (

8      {posts.map((post) => (

9        <li key={post.id}>{post.title}</li>

9        <li key={post.id}>{post.title}</li>

10      ))}

10      ))}

11    </ul>

11    </ul>

12  );

12  );

13}

13}

```tsx
export default function Page() {

16  return (

17    <section>

17    <section>

18      <h1>Blog Posts</h1>

18      <h1>博客文章</h1>

19      <Suspense fallback={<p>Loading...</p>}>

19      <Suspense fallback={<p>加载中...</p>}>

20        <BlogPosts />

20        <BlogPosts />

21      </Suspense>

21      </Suspense>

22    </section>

22    </section>

23  );
```

24}
```

使用 React 服务端组件配合 Suspense。

未来，随着部分预渲染（Partial Prerendering）功能的推出，这种模式将逐渐普及，包括明确指定哪些组件应预渲染、哪些组件应按需运行。

```tsx
import { unstable_noStore as noStore } from 'next/cache';



async function BlogPosts() {

4  noStore(); // 该组件应动态执行

5  let data = await fetch('https://api.vercel.app/blog');

6  let posts = await data.json();

7  return (

8    <ul>

8    <ul>

9      {posts.map((post) => (

9      {posts.map((post) => (

10        <li key={post.id}>{post.title}</li>

10        <li key={post.id}>{post.title}</li>

11      ))}

11      ))}

12    </ul>

12    </ul>

13  );

13  );

14}
```

14}
```

Opt-into dynamic rendering inside async components.

在异步组件中选择启用动态渲染。

## Using the incoming request

## 使用传入的请求对象

Since the incoming request object [is not able to be accessed](https://nextjs.org/docs/app#how-can-i-access-the-request-object-in-a-layout) from a Server Component, it might not be obvious how to read parts of the incoming request. This could lead to using client hooks like `useSearchParams` unnecessarily.

由于传入的请求对象 [无法从服务端组件（Server Component）中访问](https://nextjs.org/docs/app#how-can-i-access-the-request-object-in-a-layout)，因此如何读取请求中的部分内容可能并不直观。这可能导致不必要地使用客户端钩子（如 `useSearchParams`）。

There are specific functions and props to the Server Component which allow you to access the incoming request. For example:

- [`cookies()`](https://nextjs.org/docs/app/api-reference/functions/cookies)

- [`headers()`](https://nextjs.org/docs/app/api-reference/functions/headers)

- [`params`](https://nextjs.org/docs/app/api-reference/file-conventions/page#params-optional)

- [`searchParams`](https://nextjs.org/docs/app/api-reference/file-conventions/page#searchparams-optional)

服务器组件提供了特定的函数和属性，用于访问传入的请求。例如：

- [`cookies()`](https://nextjs.org/docs/app/api-reference/functions/cookies)

- [`headers()`](https://nextjs.org/docs/app/api-reference/functions/headers)

- [`params`](https://nextjs.org/docs/app/api-reference/file-conventions/page#params-optional)

- [`searchParams`](https://nextjs.org/docs/app/api-reference/file-conventions/page#searchparams-optional)

app/blog/\[slug\]/page.tsx

```tsx
export default function Page({

2  params,

3  searchParams,

4}: {

5  params: { slug: string }

5  参数：{ slug: string }

6  searchParams: { [key: string]: string | string[] | undefined }

6  搜索参数：{ [key: string]: string | string[] | undefined }

7}) {

7}) {

8  return <h1>My Page</h1>

8  return <h1>我的页面</h1>

9}
```

9}
```

Reading parts of the URL and the search parameters.

读取 URL 的部分路径及搜索参数。

## Using Context providers with App Router

## 在 App Router 中使用 Context 提供器

You might want to use [React Context](https://react.dev/reference/react/hooks#context-hooks) or are using an external dependency which relies on context. Two common mistakes I've seen are trying to use context with Server Components (unsupported) and the placement of the provider in the App Router.

你可能希望使用 [React Context](https://react.dev/reference/react/hooks#context-hooks)，或正在使用依赖 Context 的第三方库。我常看到的两个典型错误是：尝试在服务端组件（Server Component）中使用 Context（不支持），以及将 Context 提供器（Provider）错误地放置在 App Router 的结构中。

To allow for your Server and Client Components to interleave, it's important to make your provider (or multiple providers) be a separate Client Component which takes `children` as a prop and renders them. For example:

为使你的服务端组件与客户端组件能够交错渲染（interleave），关键在于将你的 Context 提供器（或多个提供器）单独封装为一个客户端组件（Client Component），该组件接收 `children` 作为 props 并渲染它们。例如：

app/theme-provider.tsx

app/theme-provider.tsx

```tsx
1'use client';



import { createContext } from 'react';



export const ThemeContext = createContext({});



export default function ThemeProvider({

8  children,

9}: {

10  children: React.ReactNode;
```

```tsx
1'使用客户端组件';



import { createContext } from 'react';



export const ThemeContext = createContext({});



export default function ThemeProvider({

8  children,

9}: {

10  children: React.ReactNode;
```

11}) {

11}) {

12  return <ThemeContext.Provider value="dark">{children}</ThemeContext.Provider>;

12  return <ThemeContext.Provider value="dark">{children}</ThemeContext.Provider>;

13}
```

```

使用 React Context 的客户端组件（Client Component）。

一个使用 React Context 的客户端组件（Client Component）。

Then, with your provider in a separate file as a Client Component, you can import and use this component inside of your layout:

接着，将您的 Provider 单独存放在一个作为客户端组件（Client Component）的文件中，您就可以在布局（layout）中导入并使用该组件：

app/layout.tsx

app/layout.tsx

```tsx
import ThemeProvider from './theme-provider';



export default function RootLayout({

4  children,

5}: {

5}: {

6  children: React.ReactNode;

6  children: React.ReactNode;

7}) {

7}) {

8  return (

8  return (

9    <html>

9    <html>

10      <body>

10      <body>

11        <ThemeProvider>{children}</ThemeProvider>

11        <ThemeProvider>{children}</ThemeProvider>

12      </body>

12      </body>

13    </html>

13    </html>

14  ); 

14  );

15}
```

一个根布局，它将客户端上下文提供器（Client Context Provider）与服务端组件子元素（Server Component children）整合在一起。

由于该提供器在根层级渲染，因此应用中所有其他客户端组件（Client Components）都将能够消费（consume）此上下文。值得注意的是，这种配置仍允许树中更深层位置存在其他服务端组件（包括 `page` 组件）。

## 服务端组件与客户端组件协同使用

许多 React 和 Next.js 开发者正在首次学习如何同时使用服务端组件（Server Components）与客户端组件（Client Components）。在此过程中出现一些错误、并借此机会深入理解这一新模型，是完全正常的！

例如，考虑以下页面：

app/page.tsx

```tsx
export default function Page() {

2  return (

3    <section>

4      <h1>My Page</h1>

4      <h1>我的页面</h1>

5    </section>

5    </section>

6  );

6  );

7}
```

7}
```

A Server Component page.

一个服务端组件页面。

This is a Server Component. While that comes with new functionality like being able to [fetch data directly in the component](https://nextjs.org/docs/app/building-your-application/data-fetching/fetching-caching-and-revalidating), it also means certain client-side React [functionalities aren't available](https://nextjs.org/docs/app/building-your-application/rendering/composition-patterns).

这是一个服务端组件（Server Component）。它带来了新功能，例如可直接在组件中 [获取数据](https://nextjs.org/docs/app/building-your-application/data-fetching/fetching-caching-and-revalidating)，但也意味着某些客户端 React [功能不可用](https://nextjs.org/docs/app/building-your-application/rendering/composition-patterns)。

For example, consider creating a button that is a counter. This would need to be a new Client Component file marked with the `"use client"` directive at the top:

例如，假设要创建一个计数器按钮。这需要新建一个客户端组件文件，并在文件顶部添加 `"use client"` 指令：

app/counter.tsx

app/counter.tsx

```tsx
1'use client';

```tsx
1'use client';

```javascript
import { useState } from 'react';



export function Counter() {

6  const [count, setCount] = useState(0);

7  return (

8    <div>

9      <p>Count: {count}</p>

9      <p>计数：{count}</p>

10      <button onClick={() => setCount(count + 1)}>Increment</button>

10      <button onClick={() => setCount(count + 1)}>递增</button>

11    </div>

11    </div>

12  );
```

13}
```

一个客户端组件按钮，用于递增计数。

然后，你可以在页面中导入并使用该组件：

app/page.tsx

```tsx
import { Counter } from './counter';



export default function Page() {

4  return (

5    <section>

6      <h1>My Page</h1>

7      <Counter />

7      <Counter />

8    </section>

8    </section>

9  );

9  );

10}
```

10}
```

Using a Client Component from a Server Component.

在 Server Component 中使用 Client Component。

The page is a Server Component and the `<Counter>` is a Client Component. Great! What about components lower in the tree than the counter? Can those be Server Components? Yes, through composition:

该页面是一个 Server Component，而 `<Counter>` 是一个 Client Component。很好！那么位于计数器组件下方的子组件呢？它们能否是 Server Component？可以，通过组合（composition）方式实现：

app/page.tsx

app/page.tsx

```tsx
import { Counter } from './counter';



function Message() {
```

4  return <p>This is a Server Component</p>;

4  返回 `<p>This is a Server Component</p>`；

5}

5}

export default function Page() {

export default function Page() {

8  return (

8  返回 (

9    <section>

9    `<section>` 

10      <h1>My Page</h1>

10      `<h1>My Page</h1>` 

11      <Counter>

11      `<Counter>` 

12        <Message />

12        `<Message />` 

13      </Counter>

13      `</Counter>`

14    </section>

14    </section>

15  );

15  );

16}
```

16}
```

Children of a Client Component can be Server Components.

客户端组件的子组件可以是服务端组件。

Children of a Client Component can be a Server Component! Here's the updated counter:

客户端组件的子组件可以是服务端组件！以下是更新后的计数器：

app/counter.tsx

app/counter.tsx

```tsx
1'use client';



import { useState } from 'react';

```tsx
1'use client';



import { useState } from 'react';

```tsx
export function Counter({ children }: { children: React.ReactNode }) {

export function Counter({ children }: { children: React.ReactNode }) {

6  const [count, setCount] = useState(0);

6  const [count, setCount] = useState(0);

7  return (

7  return (

8    <div>

8    <div>

9      <p>Count: {count}</p>

9      <p>计数：{count}</p>

10      <button onClick={() => setCount(count + 1)}>Increment</button>

10      <button onClick={() => setCount(count + 1)}>递增</button>

11      {children}

11      {children}

12    </div>

12    </div>

13  );

13  );

14}
```

```

The counter now accepts children and displays them.

计数器现在可以接收子元素并显示它们。

## Adding `“use client”` unnecessarily

## 不必要地添加 `"use client"`

Building off the previous example, does that mean that we need to add the `"use client"` directive everywhere?

承接上一个示例，这是否意味着我们必须在每个地方都添加 `"use client"` 指令？

When the `"use client"` directive is added, you pass into the "client boundary" giving you the ability to run client-side JavaScript (i.e. using React hooks or state). Client Components are still [prerendered on the server](https://github.com/reactwg/server-components/discussions/4), similar to components in the Next.js Pages Router.

一旦添加 `"use client"` 指令，你就进入了“客户端边界”，从而能够运行客户端 JavaScript（例如使用 React Hooks 或状态）。客户端组件仍会在服务器端进行[预渲染](https://github.com/reactwg/server-components/discussions/4)，这一点与 Next.js Pages Router 中的组件类似。

Since you're already in the client boundary, siblings of the `<Counter>` would become Client Components. You don't need to add `"use client"` to every file. This might be an approach taken for [incremental adoption of the App Router](https://nextjs.org/docs/app/building-your-application/upgrading/app-router-migration), where a component high up the tree becomes a Client Component and it becomes weave child Server Components further down.

由于你已处于客户端边界，`<Counter>` 的同级组件也将成为客户端组件。你无需在每个文件中都添加 `"use client"`。这种做法可能适用于 [App Router 的渐进式迁移](https://nextjs.org/docs/app/building-your-application/upgrading/app-router-migration)：即树结构中较顶层的一个组件被设为客户端组件，而其下方更深层的子组件则仍可作为服务端组件被“编织”（weave）进来。

## Not revalidating data after mutations

## 在数据变更后未重新验证数据

The Next.js App Router includes a complete model for [fetching, caching, and revalidating data](https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions-and-mutations). As developers are still learning this new model, and we're continuing to make improvements based on their feedback, one common mistake I've seen is forgetting to revalidate data after a mutation.

Next.js App Router 提供了一套完整的 [数据获取、缓存与重新验证机制](https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions-and-mutations)。由于开发者仍在学习这一新模型，且我们也在持续根据他们的反馈优化改进，我观察到一个常见错误是：在执行数据变更（mutation）后忘记重新验证数据。

For example, consider the following Server Component. It displays a form, which uses a [Server Action](https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions-and-mutations) to handle the submission and create a new entry in a [Postgres database](https://vercel.com/docs/storage/vercel-postgres).

例如，请看以下服务端组件：它渲染一个表单，该表单通过 [服务端操作（Server Action）](https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions-and-mutations) 处理提交，并在 [PostgreSQL 数据库](https://vercel.com/docs/storage/vercel-postgres) 中创建一条新记录。

app/page.tsx

```tsx
export default function Page() {

2  async function create(formData: FormData) {

2  async function create(formData: FormData) {

3    'use server';

3    'use server';

5    let name = formData.get('name');

5    let name = formData.get('name');

6    await sql`INSERT INTO users (name) VALUES (${name})`;

6    await sql`INSERT INTO users (name) VALUES (${name})`;

7  }

7  }

9  return (

9  return (

10    <form action={create}>

10    <form action={create}>

11      <input name="name" type="text" />

11      <input name="name" type="text" />

12      <button type="submit">Create</button>

12      <button type="submit">创建</button>

13    </form>

13    </form>

14  );

14  );

15}
```

15}
```

A Server Action that inserts the name into a Postgres database.

一个将名称插入 Postgres 数据库的服务器操作（Server Action）。

After the form is submitted and the insertion happens successfully, would the data displaying the list of names automatically update? No, not unless we tell Next.js to. For example:

表单提交并成功完成插入后，显示名称列表的数据会自动更新吗？不会，除非我们明确告知 Next.js 执行更新。例如：

app/page.tsx

app/page.tsx

```tsx
import { revalidatePath } from 'next/cache';



export default async function Page() {
```

```tsx
import { revalidatePath } from 'next/cache';



export default async function Page() {
```

```markdown
4  let names = await sql`SELECT * FROM users`;

4  let names = await sql`SELECT * FROM users`;

6  async function create(formData: FormData) {

6  async function create(formData: FormData) {

7    'use server';

7    'use server';

9    let name = formData.get('name');

9    let name = formData.get('name');

10    await sql`INSERT INTO users (name) VALUES (${name})`;

10    await sql`INSERT INTO users (name) VALUES (${name})`;

12    revalidatePath('/');

12    revalidatePath('/');
```

15  return (

15  返回（

16    <section>

16    <section>

17      <form action={create}>

17      <form action={create}>

18        <input name="name" type="text" />

18        <input name="name" type="text" />

19        <button type="submit">Create</button>

19        <button type="submit">创建</button>

20      </form>

20      </form>

21      <ul>

21      <ul>

22        {names.map((name) => (

22        {names.map((name) => (

23          <li>{name}</li>

23          <li>{name}</li>

24        ))}

25      </ul>

26    </section>

27  );

28}
```

在 Server Action 内部重新验证数据。

## 在 try/catch 块中执行重定向

在运行服务端代码（例如 Server Component 或 Server Action）时，如果某个资源不可用，或在成功执行数据变更操作后，你可能希望进行 [重定向（redirect）](https://nextjs.org/docs/app/api-reference/functions/redirect)。

`redirect()` 函数无需显式使用 `return redirect()`，因为它在 TypeScript 中返回 [`never`](https://www.typescriptlang.org/docs/handbook/2/functions.html#never) 类型。此外，该函数内部会抛出一个 Next.js 特有的错误。因此，**你应该在 try/catch 块外部处理重定向逻辑**。

例如，若你在 Server Component 中尝试执行重定向，代码可能如下所示：

`app/page.tsx`

`app/page.tsx`

```tsx
import { redirect } from 'next/navigation';



async function fetchTeam(id) {

4  const res = await fetch('https://...');

5  if (!res.ok) return undefined;

6  return res.json();

7}



export default async function Profile({ params }) {
```

```tsx
import { redirect } from 'next/navigation';



async function fetchTeam(id) {

4  const res = await fetch('https://...');

5  如果响应不成功（!res.ok），则返回 undefined；

6  返回 res.json();

7}



export default async function Profile({ params }) {
```

10  const team = await fetchTeam(params.id);

10  const team = await fetchTeam(params.id);

11  if (!team) {

11  if (!team) {

12    redirect('/login');

12    redirect('/login');

13  }

13  }

15  // ...

15  // ...

16}
```

16}
```

Redirecting from a Server Component.

从服务端组件执行重定向。

Alternatively, if you're trying to redirect from a Client Component, this should happen inside of a Server Action and not in an event handler:

或者，如果您尝试从客户端组件（Client Component）执行重定向，则该操作应发生在服务端动作（Server Action）中，而非事件处理器（event handler）内：

app/client-redirect.tsx

app/client-redirect.tsx

```tsx
1'use client';



import { navigate } from './actions';



export function ClientRedirect() {

6  return (

7    <form action={navigate}>

8      <input type="text" name="id" />

9      <button>Submit</button>

10    </form>
```

```tsx
1'使用客户端组件';



import { navigate } from './actions';



export function ClientRedirect() {

6  return (

7    <form action={navigate}>

8      <input type="text" name="id" />

9      <button>提交</button>

10    </form>
```

11  );

12}
```

通过服务器操作（Server Action）在客户端组件中进行重定向。

app/actions.ts

```tsx
1'use server';



import { redirect } from 'next/navigation';



export async function navigate(data: FormData) {

6  redirect('/posts');

7}
```

一个将重定向到新路由的 Server Action。

## Conclusion

## 结论

The Next.js App Router is a new approach for building React applications and there's a handful of new concepts to learn. If you've made any of these mistakes, don't feel discouraged. I've made them as well learning how the model works.

Next.js App Router 是构建 React 应用程序的一种新方法，其中包含若干需要学习的新概念。如果你曾犯过上述任何错误，请不要气馁——我在学习该模型的工作原理时，也同样犯过这些错误。

If you want to keep learning more and apply this knowledge, check out our [Next.js Learn course](https://nextjs.org/learn) to build a real dashboard application with the App Router.

如果你想持续深入学习并实践所学知识，欢迎访问我们的 [Next.js Learn 课程](https://nextjs.org/learn)，使用 App Router 构建一个真实的仪表盘应用。