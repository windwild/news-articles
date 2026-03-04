---
render_with_liquid: false
title: "What’s new in React 19 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/whats-new-in-react-19"
date: "2024-09-04"
scraped_at: "2026-03-02T09:41:18.755485741+00:00"
language: "en-zh"
translated: true
description: "React 19 is near. Here's what to expect and how you can get started deploying React 19 on Vercel."
---
render_with_liquid: false
render_with_liquid: false

Sep 4, 2024

2024 年 9 月 4 日

探索 React 19，并了解如何今天就在 Vercel 上开始使用它。

React 19 即将发布。今年 4 月，React 核心团队[宣布推出 React 19 发布候选版本（RC）](https://react.dev/blog/2024/04/25/react-19#new-feature-use)。这一主要版本带来了多项更新与新范式，旨在提升性能、易用性以及开发者体验。

其中许多功能早在 React 18 中就已作为实验性特性引入，而将在 React 19 中正式标记为稳定版。以下是对您需要了解的关键要点的概览。

## Server Components（服务端组件）

Server Components（服务端组件）是自 React 十年前首次发布以来最重大的变革之一。它们构成了 React 19 新特性的基础，可显著改善以下方面：

- **首屏加载时间。** 通过在服务端渲染组件，可减少发送至客户端的 JavaScript 体积，从而加快首屏加载速度；同时，数据查询可在页面发送至客户端**之前**就在服务端启动。

- **代码可移植性。** 服务端组件使开发者能够编写既可在服务端运行、也可在客户端运行的组件，从而减少重复代码、提升可维护性，并更轻松地在代码库中共享业务逻辑。

- **SEO（搜索引擎优化）。** 组件的服务端渲染有助于搜索引擎和大语言模型（LLM）更高效地抓取与索引内容，从而提升搜索排名。

本文不会深入探讨[服务端组件（Server Components）](https://vercel.com/blog/understanding-react-server-components-57brjqQf27QFQaFFm27gZ9)或[渲染策略（rendering strategies）](https://vercel.com/blog/how-to-choose-the-best-rendering-strategy-for-your-app)。但为了理解服务端组件的重要意义，我们先简要回顾一下 React 渲染机制的演进历程。

React started with Client-Side Rendering (CSR), which served minimal HTML to the user.

React 最初采用客户端渲染（Client-Side Rendering，CSR），仅向用户发送最简化的 HTML。

index.html

index.html

```html
1<!DOCTYPE html>

2<html>

3  <body>

4    <div id="root"></div>

5    <script src="/static/js/bundle.js"></script>

6  </body>

7</html>
```

The linked script includes everything about your application—React, third-party dependencies, and all your application code. As your application grew, so did your bundle size. The JavaScript is downloaded and parsed, and then React loads the DOM elements into the empty div. While this was happening, all the user sees is a blank page.

该链接的脚本包含了您应用的所有内容——React 自身、第三方依赖以及全部应用代码。随着应用规模扩大，打包文件（bundle）体积也随之增长。JavaScript 需先被下载并解析，随后 React 才将 DOM 元素挂载到空的 `<div>` 中。在此过程中，用户所见仅为一片空白页面。

Even when the initial UI finally shows, the page content is still missing, which is why loading skeletons gained popularity. Data is then fetched and the UI renders a second time, replacing loading skeletons with actual content.

即使初始 UI 最终显示出来，页面内容仍然缺失，这正是加载骨架（loading skeletons）流行起来的原因。随后数据被获取，UI 进行第二次渲染，用实际内容替换加载骨架。

![](images/what_s-new-in-react-19-vercel/img_001.jpg)![](images/what_s-new-in-react-19-vercel/img_002.jpg)![](images/what_s-new-in-react-19-vercel/img_003.jpg)![](images/what_s-new-in-react-19-vercel/img_004.jpg)

React improved with Server-Side Rendering (SSR), which moves the first render to the server. The HTML served to the user wasn’t empty anymore, and it improves how quickly the user saw the initial UI. However, the data still needs to be fetched to display actual content.

React 借助服务端渲染（Server-Side Rendering, SSR）得到改进，将首次渲染移至服务器端执行。发送给用户的 HTML 不再为空白，从而显著提升了用户看到初始 UI 的速度。然而，要展示真实内容，数据仍需额外获取。

![](images/what_s-new-in-react-19-vercel/img_005.jpg)![](images/what_s-new-in-react-19-vercel/img_006.jpg)![](images/what_s-new-in-react-19-vercel/img_007.jpg)![](images/what_s-new-in-react-19-vercel/img_008.jpg)

React frameworks stepped in to further improve the user experience with concepts like Static-Site Generation (SSG), which caches and renders dynamic data during the _build_, and Incremental Static Regeneration (ISR), which recaches and rerenders dynamic data on-demand.

React 框架进一步介入，通过静态站点生成（Static-Site Generation, SSG）等概念持续优化用户体验——SSG 在构建（_build_）阶段即缓存并渲染动态数据；而增量静态再生（Incremental Static Regeneration, ISR）则按需重新缓存与重新渲染动态数据。

This brings us to React Server Components (RSC). For the first time, native to React, we can fetch data _before_ the UI renders and displays to the user.

这引出了 React 服务端组件（React Server Components, RSC）。这是 React 首次原生支持在 UI 渲染并向用户展示之前，预先获取数据。

page.jsx

```tsx
export default async function Page() {

2  const res = await fetch("https://api.example.com/products");

3  const products = res.json();
```

4  return (

4  返回（

5    <>

5    <>

6      <h1>Products</h1>

6      <h1>产品</h1>

7      {products.map((product) => (

7      {products.map((product) => (

8        <div key={product.id}>

8        <div key={product.id}>

9          <h2>{product.title}</h2>

9          <h2>{product.title}</h2>

10          <p>{product.description}</p>

10          <p>{product.description}</p>

11        </div>

11        </div>

12      ))}

12      ))}

13    </>

13    </>

14  );

15}
```

HTML served to the user is fully populated with actual content on the first render, and there is no need to fetch additional data or render a second time.

用户接收到的 HTML 在首次渲染时即已完全填充真实内容，无需额外获取数据，也无需二次渲染。

![](images/what_s-new-in-react-19-vercel/img_009.jpg)![](images/what_s-new-in-react-19-vercel/img_010.jpg)![](images/what_s-new-in-react-19-vercel/img_011.jpg)![](images/what_s-new-in-react-19-vercel/img_012.jpg)

Server Components are a big step forward for speed and performance, enabling a better developer and user experience. Learn more about [React Server Components](https://19.react.dev/reference/rsc/server-components#noun-labs-1201738-(2)).

服务端组件（Server Components）在速度与性能方面迈出了一大步，显著提升了开发者与终端用户的体验。了解更多关于 [React Server Components（React 服务端组件）](https://19.react.dev/reference/rsc/server-components#noun-labs-1201738-(2)) 的信息。

_Credit to_ [_Josh W. Comeau_](https://www.joshwcomeau.com/) _for inspiration on the rendering diagrams._

图示渲染流程的设计灵感源自 [_Josh W. Comeau_](https://www.joshwcomeau.com/)。

[**Try Server Components**\\
\\
This Next.js App Router template lets you experience Server Components with just a few clicks.\\
\\
Deploy Now](https://vercel.com/templates/next.js/app-directory)

[**尝试服务端组件**\\
\\
该 Next.js App Router 模板让您只需点击几下即可体验服务端组件。\\
\\
立即部署](https://vercel.com/templates/next.js/app-directory)

## New directives

## 新增指令（Directives）

Directives are not a React 19 feature, but they are related. With the introduction of React Server Components, bundlers need to distinguish where components and functions run. To accomplish this, there are two new directives to be aware of when creating React components:

指令并非 React 19 的原生特性，但与其密切相关。随着 React Server Components 的引入，打包工具需要明确区分组件与函数的执行环境（服务端或客户端）。为此，在创建 React 组件时，需注意以下两个新增指令：

- **`'use client'`** **marks code that runs only on the client.** Since Server Components are the default, you will add `'use client'` to Client Components when using hooks for interactivity and state.

- **`'use client'`** **用于标记仅在客户端运行的代码。** 由于服务端组件是默认类型，当您在需要交互性与状态管理（例如使用 React Hooks）的组件中编写客户端逻辑时，需显式添加 `'use client'` 指令以将其声明为客户端组件。

- **`'use server'`** **用于标记可从客户端代码调用的服务端函数。**  
- **`'use server'`** **用于标记可从客户端代码调用的服务端函数。**  
  你 _无需_ 在服务端组件（Server Components）中添加 `'use server'`，仅需在服务端操作（Server Actions）中添加（下文将详细介绍）。若希望确保某段代码仅在服务端执行，[可使用 `server-only` npm 包](https://nextjs.org/docs/app/building-your-application/rendering/composition-patterns#keeping-server-only-code-out-of-the-client-environment)。

有关 [指令（Directives）](https://19.react.dev/reference/rsc/directives#noun-labs-1201738-(2)) 的更多信息，请参阅官方文档。

## Actions

## 操作（Actions）

React 19 引入了 Actions（操作）。这类函数取代了传统的事件处理器，并与 React 的过渡动画（transitions）和并发特性（concurrent features）深度集成。

Actions 可在客户端和服务端同时使用。例如，你可以定义一个客户端操作（Client Action），以替代表单原先使用的 `onSubmit` 处理逻辑。

无需再手动解析事件对象，操作函数会直接接收 `FormData` 参数。

app.tsx

```jsx
import { useState } from "react";
```

```javascript
export default function TodoApp() {

export default function TodoApp() {

4  const [items, setItems] = useState([\
4  const [items, setItems] = useState([

\
\

5    { text: "My first todo" },\
5    { text: "我的第一个待办事项" },

\
\

6  ]);

6  ]);



8  async function formAction(formData) {

8  async function formAction(formData) {

9    const newItem = formData.get("item");

9    const newItem = formData.get("item");

10    // Could make a POST request to the server to save the new item

10    // 可向服务器发起 POST 请求以保存新待办事项

11    setItems((items) => [...items, { text: newItem }]);

11    setItems((items) => [...items, { text: newItem }]);
```

14  return (

14  返回（

15    <>

15    <>

16      <h1>Todo List</h1>

16      <h1>待办事项列表</h1>

17      <form action={formAction}>

17      <form action={formAction}>

18        <input type="text" name="item" placeholder="Add todo..." />

18        <input type="text" name="item" placeholder="添加待办事项..." />

19        <button type="submit">Add</button>

19        <button type="submit">添加</button>

20      </form>

20      </form>

21      <ul>

21      <ul>

22        {items.map((item, index) => (

22        {items.map((item, index) => (

23          <li key={index}>{item.text}</li>

23          <li key={index}>{item.text}</li>

24        ))}

25      </ul>

26    </>

27  );

28}
```

### Server Actions

### 服务端操作

Going further, Server Actions allow Client Components to call async functions executed on the server. This provides additional advantages, like reading the file system or making direct database calls, removing the need for creating bespoke API endpoints for your UI.

更进一步地，服务端操作（Server Actions）允许客户端组件（Client Components）调用在服务器上执行的异步函数。这带来了额外优势，例如读取文件系统或直接调用数据库，从而无需为 UI 单独创建定制化的 API 端点。

Actions are defined with the `'use server'` directive and integrate with client-side components.

服务端操作通过 `'use server'` 指令定义，并可与客户端组件无缝集成。

To call a Server Action in a Client Component, create a new file and import it:

要在客户端组件中调用服务端操作，请新建一个文件并将其导入：

actions.ts

```tsx
1'use server'



export async function create() {

4  // Insert into database

5}
```

```tsx
1'服务器端操作'


export async function 创建() {

4  // 插入数据库

5}
```

todo-list.tsx

todo-list.tsx

```tsx
1"use client";



import { create } from "./actions";
```

```tsx
1"客户端组件";


import { create } from "./actions";
```

```javascript
export default function TodoList() {

6  return (

7    <>

8      <h1>Todo List</h1>

8      <h1>待办事项列表</h1>

9      <form action={create}>

9      <form action={create}>

10        <input type="text" name="item" placeholder="Add todo..." />

10        <input type="text" name="item" placeholder="添加待办事项..." />

11        <button type="submit">Add</button>

11        <button type="submit">添加</button>

12      </form>

12      </form>

13    </>

13    </>

14  );
```

15}
```

了解更多关于 [Server Actions](https://19.react.dev/reference/rsc/server-actions) 的信息。

## 新增 Hook

为配合 Server Actions 的使用，React 19 引入了三个新 Hook，以简化状态管理、操作状态跟踪以及视觉反馈的实现。这些 Hook 在处理表单时尤为有用，但也可用于其他元素（例如按钮）。

### `useActionState`

该 Hook 简化了表单状态及表单提交的管理。结合 Server Actions，它可自动捕获表单输入数据、处理验证逻辑及错误状态，从而减少手动编写状态管理逻辑的需要。`useActionState` 还提供一个 `pending` 状态，可在 Action 执行过程中显示加载指示器。

```tsx
1"use client";



import { useActionState } from "react";

import { createUser } from "./actions";

```javascript
const initialState = {

7  message: "",

8};

const 初始状态 = {

7  message: "",

8};

export function Signup() {

11  const [state, formAction, pending] = useActionState(createUser, initialState);

11  const [state, formAction, pending] = useActionState(createUser, 初始状态);

13  return (

13  return (

14    <form action={formAction}>

14    <form action={formAction}>
```

15      <label htmlFor="email">Email</label>

15      <label htmlFor="email">电子邮件</label>

16      <input type="text" id="email" name="email" required />

16      <input type="text" id="email" name="email" required />

17      {/* ... */}

17      {/* …… */}

18      {state?.message && <p aria-live="polite">{state.message}</p>}

18      {state?.message && <p aria-live="polite">{state.message}</p>}

19      <button aria-disabled={pending} type="submit">

19      <button aria-disabled={pending} type="submit">

20        {pending ? "Submitting..." : "Sign up"}

20        {pending ? "提交中……" : "注册"}

21      </button>

21      </button>

22    </form>

22    </form>

23  );

23  );

24}
24}

Learn more about [`useActionState`](https://19.react.dev/reference/react/useActionState#noun-labs-1201738-(2)).

了解更多关于 [`useActionState`](https://19.react.dev/reference/react/useActionState#noun-labs-1201738-(2)) 的信息。

### `useFormStatus`

This hook manages the status of the last form submission, and it must be called from inside a component that is also inside a form.

### `useFormStatus`

该 Hook 用于管理最近一次表单提交的状态，且必须在位于某个 `<form>` 元素内部的组件中调用。

```tsx
import { useFormStatus } from "react-dom";

import action from "./actions";



function Submit() {

5  const status = useFormStatus();

6  return <button disabled={status.pending}>Submit</button>;

7}
```

```javascript
export default function App() {

10  return (

11    <form action={action}>

12      <Submit />

13    </form>

14  );

15}
```

```javascript
export default function App() {

10  返回 (

11    <form action={action}>

12      <Submit />

13    </form>

14  );

15}
```

While `useActionState` has a built-in `pending` status, `useFormStatus` is useful on its own when:

虽然 `useActionState` 内置了 `pending` 状态，但 `useFormStatus` 在以下情况下可独立使用：

- There is no form state  
- 不存在表单状态

- Creating shared form components

- 创建共享表单组件

- There are multiple forms on the same page—`useFormStatus` will only return status information for a parent form

- 同一页面上存在多个表单——`useFormStatus` 仅返回其父表单的状态信息

Learn more about [`useFormStatus`](https://19.react.dev/reference/react-dom/hooks/useFormStatus#noun-labs-1201738-(2)).

了解更多关于 [`useFormStatus`](https://19.react.dev/reference/react-dom/hooks/useFormStatus#noun-labs-1201738-(2)) 的信息。

### `useOptimistic`

### `useOptimistic`

This hook lets you optimistically update the UI before the Server Action finishes executing, rather than waiting for the response. When the async action completes, the UI updates with the final state from the server.

该 Hook 允许你在服务端操作（Server Action）执行完成前，先乐观地更新 UI，而无需等待响应。当异步操作完成后，UI 将使用服务器返回的最终状态进行更新。

The following example demonstrates optimistically adding a new message to a thread immediately, while the message is also sent to the Server Action for persistence.

以下示例展示了如何立即乐观地向会话线程中添加一条新消息，同时将该消息发送至服务端操作以实现持久化。

```tsx
1"use client";



import { useOptimistic } from "react";

import { send } from "./actions";
```

```javascript
export function Thread({ messages }) {

7  const [optimisticMessages, addOptimisticMessage] = useOptimistic(

8    messages,

9    (state, newMessage) => [...state, { message: newMessage }],

10  );



12  const formAction = async (formData) => {

13    const message = formData.get("message") as string;

14    addOptimisticMessage(message);
```

```javascript
export function Thread({ messages }) {

7  const [乐观更新的消息列表, 添加乐观更新消息] = useOptimistic(

8    messages,

9    (当前状态, 新消息) => [...当前状态, { message: 新消息 }],

10  );



12  const 表单提交处理函数 = async (formData) => {

13    const 消息内容 = formData.get("message") as string;

14    添加乐观更新消息(消息内容);
```

15    await send(message);

15    await send(message);

16  };

16  };



18  return (

18  return (

19    <div>

19    <div>

20      {optimisticMessages.map((m, i) => (

20      {optimisticMessages.map((m, i) => (

21        <div key={i}>{m.message}</div>

21        <div key={i}>{m.message}</div>

22      ))}

22      ))}

23      <form action={formAction}>

23      <form action={formAction}>

24        <input type="text" name="message" />

24        <input type="text" name="message" />

25        <button type="submit">Send</button>

25        <button type="submit">发送</button>

26      </form>

26      </form>

27    </div>

27    </div>

28  );

28  );

29}
```

29}
```

Learn more about [`useOptimistic`](https://19.react.dev/reference/react/useOptimistic#noun-labs-1201738-(2)).

了解更多关于 [`useOptimistic`](https://19.react.dev/reference/react/useOptimistic#noun-labs-1201738-(2)) 的信息。

## New API: `use`

## 新增 API：`use`

The `use` function offers first-class support for promises and context during rendering. Unlike other React Hooks, `use` can be called within loops, conditional statements, and early returns. Error handling and loading will be handled by the nearest Suspense boundary.

`use` 函数在渲染过程中为 Promise 和 Context 提供了一等支持。与其他 React Hook 不同，`use` 可在循环、条件语句以及提前返回（early return）中直接调用。错误处理和加载状态将由最近的 Suspense 边界统一接管。

The following example shows a loading message while the cart items promise resolves.

以下示例展示了在购物车商品 Promise 解析期间显示加载提示信息：

```tsx
import { use } from "react";
```

```javascript
function Cart({ cartPromise }) {

4  // `use` will suspend until the promise resolves

4  // `use` 将挂起，直到 Promise 解析完成

5  const cart = use(cartPromise);

5  const cart = use(cartPromise);

6  return cart.map((item) => <p key={item.id}>{item.title}</p>);

6  return cart.map((item) => <p key={item.id}>{item.title}</p>);

7}

7}


function Page({ cartPromise }) {

10  return (

10  return (

11    /*{ ... }*/

11    /*{ ... }*/
```

12    // When `use` suspends in Cart, this Suspense boundary will be shown

12    // 当 `use` 在 Cart 组件中触发挂起（suspend）时，将显示此 Suspense 边界

13    <Suspense fallback={<div>Loading...</div>}>

13    <Suspense fallback={<div>加载中...</div>}>

14      <Cart cartPromise={cartPromise} />

14      <Cart cartPromise={cartPromise} />

15    </Suspense>

15    </Suspense>

16  );

16  );

17}
```

17}
```

This allows you to group components together so they render only when all the components’ data is available.

这使得你可以将多个组件组合在一起，仅当所有组件所需的数据均就绪后才进行渲染。

Learn more about [`use`](https://19.react.dev/reference/react/use).

更多关于 [`use`](https://19.react.dev/reference/react/use) 的信息，请参阅官方文档。

## Preloading resources

## 预加载资源

React 19 adds several new APIs to improve page load performance and user experience by loading and preloading resources such as scripts, stylesheets, and fonts.

React 19 新增了多个 API，通过加载和预加载脚本（scripts）、样式表（stylesheets）、字体（fonts）等资源，来提升页面加载性能与用户体验。

- [`prefetchDNS`](https://19.react.dev/reference/react-dom/prefetchDNS) 预取你预期将要连接的 DNS 域名所对应的 IP 地址。

- [`prefetchDNS`](https://19.react.dev/reference/react-dom/prefetchDNS) 预取你预期将要连接的 DNS 域名所对应的 IP 地址。

- [`preconnect`](https://19.react.dev/reference/react-dom/preconnect) 与你预期将从中请求资源的服务器建立连接，即使此时尚不清楚具体将请求哪些资源。

- [`preconnect`](https://19.react.dev/reference/react-dom/preconnect) 与你预期将从中请求资源的服务器建立连接，即使此时尚不清楚具体将请求哪些资源。

- [`preload`](https://19.react.dev/reference/react-dom/preload) 获取你预期将要使用的样式表、字体、图片或外部脚本。

- [`preload`](https://19.react.dev/reference/react-dom/preload) 获取你预期将要使用的样式表、字体、图片或外部脚本。

- [`preloadModule`](https://19.react.dev/reference/react-dom/preloadModule) 获取你预期将要使用的 ESM 模块。

- [`preloadModule`](https://19.react.dev/reference/react-dom/preloadModule) 获取你预期将要使用的 ESM 模块。

- [`preinit`](https://19.react.dev/reference/react-dom/preinit) 获取并执行一个外部脚本，或获取并插入一个样式表。

- [`preinit`](https://19.react.dev/reference/react-dom/preinit) 获取并执行一个外部脚本，或获取并插入一个样式表。

- [`preinitModule`](https://19.react.dev/reference/react-dom/preinitModule) 获取并执行一个 ESM 模块。

- [`preinitModule`](https://19.react.dev/reference/react-dom/preinitModule) 获取并执行一个 ESM 模块。

例如，以下 React 代码将生成如下 HTML 输出。请注意：链接（`<link>`）和脚本（`<script>`）元素的优先级与顺序，取决于它们应加载的**时机先后**，而非其在 React 代码中被调用的先后顺序。

```tsx
1// React code

import { prefetchDNS, preconnect, preload, preinit } from "react-dom";
```

```javascript
function MyComponent() {

5  preinit("https://.../path/to/some/script.js", { as: "script" });

6  preload("https://.../path/to/some/font.woff", { as: "font" });

7  preload("https://.../path/to/some/stylesheet.css", { as: "style" });

8  prefetchDNS("https://...");

9  preconnect("https://...");

10}
```

```javascript
函数 MyComponent() {

5  preinit("https://.../path/to/some/script.js", { as: "script" });

6  preload("https://.../path/to/some/font.woff", { as: "font" });

7  preload("https://.../path/to/some/stylesheet.css", { as: "style" });

8  prefetchDNS("https://...");

9  preconnect("https://...");

10}
```

```html
1<!-- Resulting HTML -->

2<html>

3  <head>
```

```html
1<!-- 生成的 HTML -->

2<html>

3  <head>
```

4    <link rel="prefetch-dns" href="https://..." />

4    <link rel="prefetch-dns" href="https://..." />

5    <link rel="preconnect" href="https://..." />

5    <link rel="preconnect" href="https://..." />

6    <link rel="preload" as="font" href="https://.../path/to/some/font.woff" />

6    <link rel="preload" as="font" href="https://.../path/to/some/font.woff" />

7    <link

7    <link

8      rel="preload"

8      rel="preload"

9      as="style"

9      as="style"

10      href="https://.../path/to/some/stylesheet.css"

10      href="https://.../path/to/some/stylesheet.css"

11    />

11    />

12    <script async="" src="https://.../path/to/some/script.js"></script>

12    <script async="" src="https://.../path/to/some/script.js"></script>

13  </head>

13  </head>

14  <body>

14  <body>

15    <!-- ... -->

15    <!-- ... -->

16  </body>

16  </body>

17</html>
```

17</html>
```

React frameworks frequently handle resource loading like this for you, so you might not have to call these APIs yourself.

React 框架通常会为你自动处理此类资源加载，因此你可能无需自行调用这些 API。

Learn more about [Resource Preloading APIs](https://react.dev/reference/react-dom#resource-preloading-apis).

更多关于 [资源预加载 API（Resource Preloading APIs）](https://react.dev/reference/react-dom#resource-preloading-apis) 的信息。

## Other improvements

## 其他改进

### `ref` as a prop

### `ref` 作为 prop

There’s no need for `forwardRef` anymore. React will provide a codemod to make transitioning easier.

不再需要 `forwardRef`。React 将提供一个 codemod 工具，以简化迁移过程。

```tsx
function CustomInput({ placeholder, ref }) {
```

2  return <input placeholder={placeholder} ref={ref} />;

2  返回 `<input placeholder={placeholder} ref={ref} />;`

3}

3}

5// ...

5// ...

7<CustomInput ref={ref} />;
7<CustomInput ref={ref} />;

```

```

### `ref` callbacks

### `ref` 回调函数

In addition to `ref` as a prop, refs can also return a callback function for cleanup. When a component unmounts, React will call the cleanup function.

除了将 `ref` 作为 prop 使用外，refs 还可以返回一个用于清理的回调函数。当组件卸载时，React 将调用该清理函数。

```tsx
1<input

1<input

2  ref={(ref) => {  

2  ref={(ref) => {

3    // ref created  

3    // ref 已创建  

5    // Return a cleanup function to reset  

5    // 返回一个清理函数，用于在元素从 DOM 中移除时重置  

6    // ref when element is removed from DOM.  

6    // ref。  

7    return () => {  

7    return () => {  

8      // ref cleanup  

8      // ref 清理  

9    };  

9    };  

10  }}  

10  }}  

11/>;  

11/>;  

### `Context` as a provider  

### `Context` 作为提供者

There’s no need for `<Context.Provider>` anymore. You can use `<Context>` directly instead. React will provide a codemod to convert existing providers.

不再需要 `<Context.Provider>`。您可以直接使用 `<Context>`。React 将提供一个 codemod 工具，用于转换现有的 provider。

```tsx
const ThemeContext = createContext("");



function App({ children }) {

4  return <ThemeContext value="dark">{children}</ThemeContext>;

5}
```

```tsx
const ThemeContext = createContext("");



function App({ children }) {

4  return <ThemeContext value="dark">{children}</ThemeContext>;

5}
```

### `useDeferredValue` initial value

### `useDeferredValue` 的初始值选项

An `initialValue` option has been added to `useDeferredValue`. When provided, `useDeferredValue` will use the value for the initial render and schedule a re-render in the background, returning the `deferredValue`.

`useDeferredValue` 新增了 `initialValue` 选项。当指定该选项时，`useDeferredValue` 将在首次渲染时使用该初始值，并在后台调度一次重新渲染，随后返回 `deferredValue`。

```tsx
function Search({ deferredValue }) {

2  // On initial render the value is ''.

2  // 首次渲染时，该值为 ''。
```

3  // Then a re-render is scheduled with the deferredValue.

3  // 然后，将使用 deferredValue 调度一次重新渲染。

4  const value = useDeferredValue(deferredValue, "");

4  const value = useDeferredValue(deferredValue, "");

6  return <Results value={value} />;

6  return <Results value={value} />;

7}
```

7}
```

### Document metadata support

### 文档元数据支持

React 19 will natively hoist and render title, link, and meta tags, even from nested components. There’s no need for third-party solutions to manage these tags anymore.

React 19 将原生提升并渲染 `<title>`、`<link>` 和 `<meta>` 标签，即使这些标签位于嵌套组件中。从此不再需要第三方方案来管理这些标签。

```tsx
function BlogPost({ post }) {

2  return (

3    <article>
```

4      <h1>{post.title}</h1>

4      <h1>{post.title}</h1>

5      <title>{post.title}</title>

5      <title>{post.title}</title>

6      <meta name="author" content="Jane Doe" />

6      <meta name="author" content="Jane Doe" />

7      <link rel="author" href="https://x.com/janedoe" />

7      <link rel="author" href="https://x.com/janedoe" />

8      <meta name="keywords" content={post.keywords} />

8      <meta name="keywords" content={post.keywords} />

9      <p>...</p>

9      <p>……</p>

10    </article>

10    </article>

11  );

11  );

12}
```

12}
```

### Stylesheet support

### 样式表支持

React 19 allows controlling stylesheet loading order with `precedence`. This makes colocating stylesheets near components easier, and React only loads them if they are used.

React 19 允许通过 `precedence` 属性控制样式表的加载顺序。这使得将样式表与组件就近放置变得更加容易，且 React 仅在实际使用时才加载这些样式表。

There are a few points to keep in mind:

以下几点需要注意：

- If you render the same component in multiple places within your application, React will deduplicate the stylesheet and only include it once in the document.

- 如果你在应用中多处渲染同一组件，React 将对样式表进行去重处理，确保其在文档中仅被包含一次。

- When server-side rendering, React will include the stylesheet in the head. This ensures that the browser will not paint until it has loaded.

- 在服务端渲染（SSR）时，React 会将样式表插入到 `<head>` 中。这可确保浏览器在样式表加载完成前不会进行页面绘制（paint）。

- If the stylesheet is discovered after streaming has started, React will ensure that the stylesheet is inserted into the `<head>` on the client before revealing the content that depends on that stylesheet through a Suspense boundary.

- 如果样式表是在流式传输（streaming）开始后才被发现的，React 将确保该样式表在客户端被插入到 `<head>` 中，然后才通过 Suspense 边界展示依赖该样式表的内容。

- During client-side rendering, React will wait for newly rendered stylesheets to load before committing the render.

- 在客户端渲染（CSR）过程中，React 将等待新渲染出的样式表加载完成之后，再提交（commit）本次渲染。

```tsx
function ComponentOne() {

2  return (

3    <Suspense fallback="loading...">

4      <link rel="stylesheet" href="one" precedence="default" />
```

5      `<link rel="stylesheet" href="two" precedence="high" />`

5      `<link rel="stylesheet" href="two" precedence="high" />`

6      `<article>...</article>`

6      `<article>...</article>`

7    `</Suspense>`

7    `</Suspense>`

8  `);`

8  `);`

9  `}`

9  `}`

function ComponentTwo() {

function ComponentTwo() {

12  return (

12  return (

13    `<div>`

13    `<div>`

14      `<p>...</p>`

14      `<p>...</p>`

15      {/* Stylesheet "three" below will be inserted between "one" and "two" */}

15      {/* 样式表 "three" 将被插入在 "one" 和 "two" 之间 */}

16      <link rel="stylesheet" href="three" precedence="default" />

16      <link rel="stylesheet" href="three" precedence="default" />

17    </div>

17    </div>

18  );

18  );

19}
```

19}
```

### Async scripts support

### 支持异步脚本

Render async scripts in any component. This makes colocating scripts near components easier, and React only loads them if they are used.

可在任意组件中渲染异步脚本。这使得将脚本与相关组件就近放置更加容易，且 React 仅在实际使用时才加载这些脚本。

There are a few points to keep in mind:

需注意以下几点：

- If you render the same component in multiple places within your application, React will deduplicate the script and only include it once in the document.

- 如果你在应用中的多个位置渲染同一组件，React 将对脚本进行去重处理，确保其在整个文档中仅被包含一次。

- When server-side rendering, async scripts will be included in the head and prioritized behind more critical resources that block paint, such as stylesheets, fonts, and image preloads.

- 在服务端渲染（SSR）时，异步脚本将被注入到 `<head>` 中，且其加载优先级低于那些会阻塞页面绘制（paint）的关键资源（例如样式表、字体和图片预加载）。

```tsx
function Component() {

function Component() {

2  return (

2  返回 (

3    <div>

3    <div>

4      <script async={true} src="..." />

4      <script async={true} src="..." />

5      // ...

5      // ...

6    </div>

6    </div>

7  );

7  );

8}



8}



function App() {

function App() {
```

11  return (

11  返回（

12    <html>

12    <html>

13      <body>

13      <body>

14        <Component>

14        <Component>

15          // ...

15          // ...

16        </Component> // Won't duplicate script in the DOM

16        </Component> // 不会在 DOM 中重复加载脚本

17      </body>

17      </body>

18    </html>

18    </html>

19  );

19  ）；

20}
```
20}
```

### Custom Elements support

### 自定义元素支持

Custom Elements allow developers to define their own HTML elements as a part of the [Web Components](https://developer.mozilla.org/en-US/docs/Web/API/Web_components) specification. In previous versions of React, using Custom Elements has been difficult because React treats unrecognized props as attributes rather than properties.

自定义元素（Custom Elements）允许开发者将自定义的 HTML 元素作为 [Web Components](https://developer.mozilla.org/zh-CN/docs/Web/API/Web_components) 规范的一部分进行定义。在 React 早期版本中，使用自定义元素较为困难，因为 React 会将无法识别的 props 视为 HTML 属性（attributes），而非 DOM 属性（properties）。

React 19 adds full support for Custom Elements and passes all tests on [Custom Elements Everywhere](https://custom-elements-everywhere.com/).

React 19 新增了对自定义元素的完整支持，并已通过 [Custom Elements Everywhere](https://custom-elements-everywhere.com/) 的全部测试。

### Better error reporting

### 更完善的错误报告机制

Error handling improves by removing duplicate error messages.

错误处理得到改进，消除了重复的错误信息。

![Previously, React would throw the error twice. Once for the original error, then a second time after failing to automatically recover, followed by information about the error.](images/what_s-new-in-react-19-vercel/img_013.jpg)![Previously, React would throw the error twice. Once for the original error, then a second time after failing to automatically recover, followed by information about the error.](images/what_s-new-in-react-19-vercel/img_014.jpg)

![此前，React 会抛出两次错误：第一次是原始错误本身；第二次是在自动恢复失败后再次抛出，并附带错误详情。](images/what_s-new-in-react-19-vercel/img_013.jpg)![此前，React 会抛出两次错误：第一次是原始错误本身；第二次是在自动恢复失败后再次抛出，并附带错误详情。](images/what_s-new-in-react-19-vercel/img_014.jpg)

Previously, React would throw the error twice. Once for the original error, then a second time after failing to automatically recover, followed by information about the error.

此前，React 会抛出两次错误：第一次是原始错误本身；第二次是在自动恢复失败后再次抛出，并附带错误详情。

![In React 19, the error is only displayed once.](images/what_s-new-in-react-19-vercel/img_015.jpg)![In React 19, the error is only displayed once.](images/what_s-new-in-react-19-vercel/img_016.jpg)

![在 React 19 中，错误仅显示一次。](images/what_s-new-in-react-19-vercel/img_015.jpg)![在 React 19 中，错误仅显示一次。](images/what_s-new-in-react-19-vercel/img_016.jpg)

In React 19, the error is only displayed once.

在 React 19 中，错误仅显示一次。

Hydration errors improve by logging a single mismatch error instead of multiple errors. Error messages also include information on how to possibly fix the error.

水合（hydration）错误的报告也得到优化：不再报告多个不匹配错误，而是仅记录一个不匹配错误；同时，错误消息中还包含有关如何修复该问题的建议信息。

![Example of a hydration error message in React 18.](images/what_s-new-in-react-19-vercel/img_017.jpg)![Example of a hydration error message in React 18.](images/what_s-new-in-react-19-vercel/img_018.jpg)

React 18 中水合错误消息的示例。

![Example of an improved hydration error message in React 19.](images/what_s-new-in-react-19-vercel/img_019.jpg)![Example of an improved hydration error message in React 19.](images/what_s-new-in-react-19-vercel/img_020.jpg)

React 19 中改进后的水合错误消息示例。

使用第三方脚本和浏览器扩展时发生的水合错误也得到了改善。此前，由第三方脚本或浏览器扩展插入的元素会触发不匹配错误。而在 React 19 中，`<head>` 和 `<body>` 中意外出现的标签将被跳过，且不会抛出错误。

最后，React 19 在原有 `onRecoverableError` 的基础上，新增了两个 root 级选项，以更清晰地说明错误发生的原因：

- `onCaughtError`：当 React 在 Error Boundary 中捕获到错误时触发。  
- `onUncaughtError`：当错误被抛出且未被任何 Error Boundary 捕获时触发。  
- `onRecoverableError`：当错误被抛出并被自动恢复时触发。

## Getting started with React 19 on Vercel

## 在 Vercel 上开始使用 React 19

React 19 marks a significant evolution in the framework, introducing powerful new features and capabilities. These enhancements increase performance and offer a more seamless experience for developers and users alike.

React 19 标志着该框架的一次重大演进，引入了强大而新颖的功能与能力。这些增强显著提升了性能，并为开发者和终端用户带来更加流畅、自然的体验。

The following frameworks make it easy to get started with React 19 today:

以下框架可帮助您今日即刻上手 React 19：

[**Astro**\\
\\
Deploy React 19 with Astro.\\
\\
▲ Deploy](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fvercel-labs%2Freact-19-on-vercel%2Ftree%2Fmain%2Fastro&repository-name=react-19-astro) [**Next.js 15 RC**\\
\\
Deploy React 19 with Next.js 15 RC.\\
\\
▲ Deploy](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fvercel-labs%2Freact-19-on-vercel%2Ftree%2Fmain%2Fnext.js&repository-name=react-19-nextjs) [**Vite**\\
\\
Deploy React 19 with Vite.\\
\\
▲ Deploy](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fvercel-labs%2Freact-19-on-vercel%2Ftree%2Fmain%2Fvite&repository-name=react-19-vite) [**Waku**\\
\\
Deploy React 19 with Waku.\\
\\
▲ Deploy](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fvercel-labs%2Freact-19-on-vercel%2Ftree%2Fmain%2Fwaku&repository-name=react-19-waku)  
[**Astro**\\
\\
使用 Astro 部署 React 19。\\
\\
▲ 部署](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fvercel-labs%2Freact-19-on-vercel%2Ftree%2Fmain%2Fastro&repository-name=react-19-astro) [**Next.js 15 RC**\\
\\
使用 Next.js 15 RC 部署 React 19。\\
\\
▲ 部署](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fvercel-labs%2Freact-19-on-vercel%2Ftree%2Fmain%2Fnext.js&repository-name=react-19-nextjs) [**Vite**\\
\\
使用 Vite 部署 React 19。\\
\\
▲ 部署](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fvercel-labs%2Freact-19-on-vercel%2Ftree%2Fmain%2Fvite&repository-name=react-19-vite) [**Waku**\\
\\
使用 Waku 部署 React 19。\\
\\
▲ 部署](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fvercel-labs%2Freact-19-on-vercel%2Ftree%2Fmain%2Fwaku&repository-name=react-19-waku)