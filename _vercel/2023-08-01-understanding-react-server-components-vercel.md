---
title: "Understanding React Server Components - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/understanding-react-server-components"
date: "2023-08-01"
scraped_at: "2026-03-02T09:51:31.220242314+00:00"
language: "en-zh"
translated: true
description: "React Server Components are changing the fundamental paradigms of React. Learn how Next.js handles the complexities and improves the performance of your applications."
---
&#123;% raw %}

Aug 1, 2023

2023 年 8 月 1 日

学习 React Server Components 的基础知识，从而更深入地理解为何（以及何时）应采用该技术。

[React Server Components](https://react.dev/blog/2020/12/21/data-fetching-with-react-server-components)（RSC）不仅将 React 从一个纯粹的渲染库拓展为支持数据获取与远程客户端-服务器通信的框架，更在根本上丰富了 React 的核心能力。

下文将为您逐步解析：RSC 为何被创建、它们最擅长解决哪些问题、以及何时应使用它们。我们还将简要介绍 Next.js 如何通过 App Router 简化并增强 [RSC 的实现细节](https://nextjs.org/docs/getting-started/react-essentials?utm_source=vercel_site&utm_medium=web&utm_campaign=understanding_rsc)。

## 为何我们需要 Server Components？

回顾 React 诞生之前的世界：在 PHP 等语言中，客户端与服务器之间存在更紧密的耦合关系。在单体架构（monolithic architecture）下，开发者可在正在构建的页面内直接向服务器发起数据调用。然而，这种架构也存在明显缺陷——例如，因跨团队依赖和高流量压力导致单体应用难以规模化扩展。

React 的设计初衷是提升组件可组合性（composability），并支持渐进式集成至现有代码库。面对当时世界对丰富交互体验的迫切需求，React 解耦了客户端与服务器的关注点，使前端具备前所未有的灵活组合能力。这对开发团队尤为关键：由不同开发者分别编写的两个 React 组件，只要运行于同一框架内，便能天然协同工作。

为实现这一目标，React 必须在既有的 Web 标准之上持续创新。在过去十年间，无论是在多页应用（MPA）与单页应用（SPA）之间演进，还是在客户端渲染（CSR）与服务端渲染（SSR）之间权衡，[其核心目标始终如一](https://github.com/reactwg/server-components/discussions/5)：快速交付数据、提供丰富的交互体验，并保障卓越的开发者体验。

### 服务端渲染（SSR）与 React Suspense 解决了什么问题？

在通往 Server Components 的演进之路上，曾有若干关键问题亟待解决。要更深刻地理解 RSC 的必要性，首先需厘清服务端渲染（SSR）与 React Suspense 所应对的核心挑战。

SSR focuses on initial page load, sending pre-rendered HTML to the client that must then be hydrated with downloaded JavaScript before it behaves as a typical React app. SSR also only happens one time: when directly navigating to a page.

SSR 专注于页面的首次加载，向客户端发送预渲染的 HTML；该 HTML 必须在通过下载的 JavaScript 进行“注水”（hydration）后，才能表现出典型 React 应用的行为。此外，SSR 仅发生一次：即用户直接导航至该页面时。

With SSR alone, the user gets HTML more quickly, but must wait on an "all-or-nothing" waterfall before being able to interact with JavaScript:

仅使用 SSR 时，用户能更快获得 HTML，但必须等待一个“全有或全无”的瀑布式流程完成，才能与 JavaScript 交互：

- All data must be fetched from the server before any of it can be shown.

- 所有数据都必须先从服务器获取完毕，之后才能展示其中任意一部分。

- All JavaScript must download from the server before the client can be hydrated with it.

- 所有 JavaScript 都必须先从服务器下载完成，客户端才能用其完成注水（hydration）。

- All hydration has to complete on the client before anything can be interacted with.

- 客户端必须完成全部注水过程，之后用户才能与页面上的任何内容进行交互。

To solve this, [React created Suspense](https://github.com/reactwg/react-18/discussions/37), which allows for server-side HTML streaming and selective hydration on the client. By wrapping a component with `<Suspense>`, you can tell the server to deprioritize that component's rendering and hydration, letting other components load in without getting blocked by the heavier ones.

为解决上述问题，[React 引入了 Suspense](https://github.com/reactwg/react-18/discussions/37)，支持服务端 HTML 流式传输（streaming）以及客户端的选择性注水（selective hydration）。通过将某个组件包裹在 `<Suspense>` 中，你可以指示服务端降低该组件的渲染与注水优先级，从而让其他组件无需受制于较重组件的阻塞而顺利加载。

When you have multiple components in `<Suspense>`, React works down the tree in the order you've written, allowing you to stream in your application optimally. However, if the user attempts to interact with a certain component, that component will be prioritized over the others.

当多个组件被包裹在 `<Suspense>` 中时，React 会按照你在代码中书写的顺序自上而下遍历组件树，从而实现应用流式加载的最优化。然而，若用户尝试与某个特定组件进行交互，则该组件将被自动提升优先级，超越其他组件。

This vastly improves the situation, but still leaves a few remaining issues:

这一方案极大改善了用户体验，但仍遗留若干问题：

- Data for the _entire page_ must be fetched from the server before any components can be shown. The only way around this is to fetch data client-side in a `useEffect()` hook, which has a longer roundtrip than server-side fetches and happens only  
_after_ the component is rendered and hydrated.

- 整个页面的 _所有数据_ 都必须先从服务端获取完毕，之后才能展示任意组件。唯一的变通方式是在客户端通过 `useEffect()` Hook 获取数据——但这种方式的网络往返延迟更长，且仅能在组件完成渲染与注水 _之后_ 才开始执行。

- All page JavaScript is eventually downloaded, even if it's streamed to the browser asynchronously. As app complexity increases, so does the amount of code the user downloads.

- 所有页面的 JavaScript 最终都会被下载，即使它是以异步方式流式传输到浏览器的。随着应用复杂度的增加，用户需要下载的代码量也随之增长。

- Despite optimizing hydration, users still cannot interact with components until the client-side JavaScript is downloaded and implemented for that component.

- 尽管已对“注水（hydration）”进行了优化，用户在对应组件所需的客户端 JavaScript 完成下载并执行之前，仍无法与该组件进行交互。

- The majority of JavaScript compute weight still ends up on the client, which could be running on any variety of devices. Why not move it to the more powerful, predictable server?

- 绝大多数 JavaScript 的计算负担仍落在客户端，而客户端设备种类繁多、性能差异巨大。为何不将这部分计算转移到更强大、更可预测的服务器端？

![In Next.js without React Server Components, data fetching requires an extra API layer. ](images/understanding-react-server-components-vercel/img_001.jpg)![In Next.js without React Server Components, data fetching requires an extra API layer. ](images/understanding-react-server-components-vercel/img_002.jpg)In Next.js without React Server Components, data fetching requires an extra API layer.

![在不使用 React Server Components 的 Next.js 中，数据获取需额外引入一层 API。](images/understanding-react-server-components-vercel/img_001.jpg)![在不使用 React Server Components 的 Next.js 中，数据获取需额外引入一层 API。](images/understanding-react-server-components-vercel/img_002.jpg)在不使用 React Server Components 的 Next.js 中，数据获取需额外引入一层 API。

As Web standards catch up to where JavaScript frameworks have pushed the boundaries, it’s time for another leap forward. There’s a better way to compose faster applications.

随着 Web 标准逐步追赶上 JavaScript 框架此前所拓展的边界，是时候迈出下一步了——我们拥有一种更优的方式，来构建更快的应用程序。

## What do React Server Components do?

## React Server Components 的作用是什么？

In order to solve the above issues, React has created Server Components. RSCs individually fetch data and render entirely on the server, and the resulting HTML is streamed into the client-side React component tree, interleaving with other Server and Client Components as necessary.

为解决上述问题，React 推出了 Server Components（服务端组件）。每个 RSC 独立地在服务端完成数据获取与完整渲染，生成的 HTML 以流式方式注入客户端的 React 组件树中，并根据需要与其它服务端组件及客户端组件交错整合。

This process eliminates the need for client-side re-rendering, thereby improving performance. For any Client Components, hydration can happen concurrently with RSCs streaming in, since the compute load is shared between client and server.

这一过程消除了客户端重新渲染的必要性，从而显著提升性能。对于任意客户端组件，其“注水（hydration）”可与 RSC 的流式传输同步进行，因为计算负载已在客户端与服务端之间合理分担。

Put another way, the server, far more powerful and physically closer to your data sources, deals with compute-intensive rendering and ships to the client just the interactive pieces of code.

换言之，服务端通常算力更强、且物理上更靠近你的数据源，它负责处理计算密集型的渲染任务，仅向客户端交付具备交互能力的代码片段。

When an RSC needs to be re-rendered, due to state change, it refreshes on the server and seamlessly merges into the existing DOM **without a hard refresh**. As a result, the client state is preserved even as parts of the view are updated from the server.

当某个 RSC 因状态变更需要重新渲染时，它会在服务端刷新，并**无需硬刷新（hard refresh）** 即可无缝合并至现有 DOM 中。因此，即便视图的部分内容由服务端更新，客户端的状态依然得以保留。

### **RSCs: Performance and bundle size**

### **RSC：性能与包体积**

RSCs can help reduce the size of the client-side JavaScript bundle and improve loading performance.

RSC（服务端组件）有助于减小客户端 JavaScript 包的体积，并提升加载性能。

Traditionally, while navigating the application, the client downloads and then executes all code and data dependencies. Without a React framework that has [code-splitting](https://nextjs.org/docs/app/building-your-application/routing/linking-and-navigating#1-code-splitting), this also means sending users extraneous code not needed for the page they're on.

传统上，在应用内导航时，客户端需下载并执行全部代码及数据依赖。若未使用支持[代码分割（code-splitting）](https://nextjs.org/docs/app/building-your-application/routing/linking-and-navigating#1-code-splitting)的 React 框架，则意味着会向用户发送当前页面完全不需要的冗余代码。

However, RSCs resolve all dependencies on the server, closer to the sources of your app's data. They also render out code only on the server, which is much faster at this task than client machines (such as mobile phones). Then, React sends only these processed results plus Client Components to the browser.

然而，RSC 在服务器端解析所有依赖，更贴近应用数据的源头；其渲染也仅在服务端完成——而服务器执行渲染任务的速度远高于客户端设备（例如手机）。随后，React 仅将这些已处理完毕的结果以及客户端组件（Client Components）发送至浏览器。

RSCs drastically reduce client-side JavaScript payload.

RSC 大幅降低了客户端 JavaScript 的有效载荷（payload）。

In other words, with Server Components, the initial page load is faster and leaner. **The base client-side runtime is cacheable and predictable in size, and does not increase as your application grows.** Additional user-facing JavaScript is primarily added as your application needs more client-side interactivity through Client Components.

换言之，借助服务端组件（Server Components），首屏加载更快、更轻量。**基础的客户端运行时（runtime）可被缓存，且体积稳定可预期——不会随应用规模扩大而增长。** 额外面向用户的 JavaScript 主要随着应用对客户端交互性（如通过 Client Components 实现）需求的增加而逐步引入。

### **RSCs: Interleaving and Suspense integration**

### **RSC：交错渲染与 Suspense 集成**

RSCs are fully interleaved with client-side code, meaning that Client Components and Server Components can render in the same React tree. By moving the majority of your application code to the server, RSCs help to prevent client-side data fetching waterfalls, quickly resolving data dependencies server-side.

RSC 可与客户端代码完全交错（interleaved）运行，即客户端组件（Client Components）与服务端组件（Server Components）可在同一 React 组件树中共同渲染。通过将大部分应用逻辑迁移至服务端，RSC 有助于避免客户端数据获取的“瀑布式请求”（waterfalls），从而快速在服务端解析数据依赖。

In traditional client-side rendering, components use React Suspense to “pause” their rendering process (and show a fallback state) while waiting for asynchronous work to be completed. With RSCs, both data fetching and rendering occur on the server, so Suspense manages the waiting period server-side, too, shortening the total roundtrip to speed up rendering the fallback and completed page.

在传统的客户端渲染中，组件借助 React Suspense 在等待异步操作完成期间“暂停”自身渲染过程（并显示回退状态 / fallback）。而在 RSC 模式下，数据获取与渲染均发生在服务端，因此 Suspense 同样在服务端管理等待期，从而缩短整体往返耗时，加快回退界面与最终完整页面的渲染速度。

It's important to note that [Client Components are still SSR'ed on initial load](https://github.com/reactwg/server-components/discussions/4). The RSC model does not replace SSR or Suspense, but rather it works alongside them to provide all parts of your application to your users as they need them.

需要特别注意的是，[客户端组件在首次加载时仍会经历服务端渲染（SSR）](https://github.com/reactwg/server-components/discussions/4)。RSC 模型并非取代 SSR 或 Suspense，而是与它们协同工作，按用户所需，将应用的各个部分精准、及时地交付给用户。

![In Next.js with React Server Components, data fetching and UI rendering can be done from the same component. Additionally, Server Actions provide a way for users to interact with server-side data before JavaScript loads on the page.](images/understanding-react-server-components-vercel/img_003.jpg)  
![在 Next.js 中使用 React Server Components 时，数据获取与 UI 渲染可在同一组件中完成。此外，Server Actions 提供了一种机制，使用户能在页面加载 JavaScript 之前与服务端数据进行交互。](images/understanding-react-server-components-vercel/img_003.jpg)  

![In Next.js with React Server Components, data fetching and UI rendering can be done from the same component. Additionally, Server Actions provide a way for users to interact with server-side data before JavaScript loads on the page.](images/understanding-react-server-components-vercel/img_004.jpg)  
![在 Next.js 中使用 React Server Components 时，数据获取与 UI 渲染可在同一组件中完成。此外，Server Actions 提供了一种机制，使用户能在页面加载 JavaScript 之前与服务端数据进行交互。](images/understanding-react-server-components-vercel/img_004.jpg)  

In Next.js with React Server Components, data fetching and UI rendering can be done from the same component. Additionally, Server Actions provide a way for users to interact with server-side data before JavaScript loads on the page.  

在 Next.js 中使用 React Server Components 时，数据获取与 UI 渲染可在同一组件中完成。此外，Server Actions 提供了一种机制，使用户能在页面加载 JavaScript 之前与服务端数据进行交互。

### **RSCs: Limitations**

### **React Server Components 的限制**

All code written for Server Components must be serializable, which means you can’t use lifecycle hooks, such as `useEffect()` or state.  

所有为 Server Component 编写的代码都必须是可序列化的，这意味着你无法使用 `useEffect()` 等生命周期钩子或状态（state）。

However, you can still interact with the server from the client through Server Actions, which we’ll get to in [just a bit](https://vercel.com/blog/understanding-react-server-components#server-actions-react%E2%80%99s-first-steps-into-mutability).  

不过，你仍可通过 Server Actions 从客户端与服务端交互——我们稍后将在[下一节](https://vercel.com/blog/understanding-react-server-components#server-actions-react%E2%80%99s-first-steps-into-mutability)中详细介绍。

Also, RSCs do not support continuous updates, such as through WebSockets. In these cases, a client-side fetching or polling approach would be necessary.  

此外，RSC 不支持持续更新（例如通过 WebSocket 实现）。在此类场景下，需采用客户端数据获取或轮询（polling）的方式。

Delba de Oliveira, Vercel Senior Developer Advocate, discusses React, Server Components, and more with Andrew Clark and Sebastian Markbåge from the React core team.  

Vercel 高级开发者布道师 Delba de Oliveira 与 React 核心团队成员 Andrew Clark 和 Sebastian Markbåge 就 React、Server Components 等话题展开深入探讨。

## How to use React Server Components

## 如何使用 React Server Components

The beauty of RSCs is that you don’t really need to know fully how they work to take advantage of them. In the App Router introduced in Next.js 13.4, which offers the most feature-complete implementation of RSCs, all components are Server Components by default.  

RSC 的美妙之处在于：你无需完全理解其底层原理，即可从中获益。Next.js 13.4 引入的 App Router 提供了目前功能最完备的 RSC 实现，其中所有组件默认均为 Server Component。

If you want to use lifecycle events such as `useEffect()` or state, you’ll need to weave in a Client Component. Opting into a Client Component is a matter of writing "use client" at the top of the component, but for more advanced advice, we recommend you [check the docs](https://nextjs.org/docs/getting-started/react-essentials#client-components).  

若需使用 `useEffect()` 等生命周期事件或状态（state），则需引入 Client Component。只需在组件顶部添加 `"use client"` 指令，即可将其标记为 Client Component；如需更深入的指导，我们建议你[查阅官方文档](https://nextjs.org/docs/getting-started/react-essentials#client-components)。

### **Balancing Server and Client Components**

### **平衡 Server Component 与 Client Component**

It's important to note that RSCs are not intended to replace Client Components. A healthy application utilizes both RSCs for dynamic data fetching and Client Components for rich interactivity. The challenge lies in determining when to use each component.

需要特别注意的是，服务端组件（RSC）并非旨在取代客户端组件（Client Components）。一个健康的 Web 应用应当同时利用 RSC 进行动态数据获取，又借助客户端组件实现丰富的交互体验。真正的挑战在于：如何恰当地决定在何时使用哪一类组件。

As a developer, consider leveraging RSCs for server-side rendering and data fetching, while relying on Client Components for locally interactive features and user experiences. By striking the right balance, you can create a high-performance, efficient, and engaging application.

作为开发者，建议将 RSC 用于服务端渲染与数据获取，而将客户端组件用于本地化交互功能和用户界面体验。通过把握二者之间的合理平衡，你便能构建出高性能、高效率且富有吸引力的应用程序。

The most important thing is that you continue to test your applications in non-standard environments: emulate slower computers, slower phones, and slower wifi, and you may be surprised to see how much better your app works with the right combination of components.

最重要的一点是：请持续在非标准环境中测试你的应用——模拟性能较弱的电脑、低端手机以及低速 Wi-Fi 网络。你可能会惊讶地发现，只要组件搭配得当，你的应用表现会显著提升。

RSCs are not the full solution to the problem of burdening users with too much client-side JavaScript, but they certainly give us the power to choose when to put the weight of compute on the user’s device.

RSC 并非解决“向用户设备加载过多客户端 JavaScript”这一问题的万能方案，但它们确实赋予我们一项关键能力：自主决定何时将计算负载转移至用户设备上。

### Improved data fetching with Next.js

### 借助 Next.js 实现更优的数据获取

RSCs fetch data on the server, which not only offers secure access to backend data but also enhances performance by reducing server-client interaction. [Coupled with Next.js enhancements](https://nextjs.org/docs/app/building-your-application/data-fetching?utm_source=vercel_site&utm_medium=web&utm_campaign=understanding_rsc), RSCs also allow for smart data caching, multiple fetches in a single roundtrip, and automatic `fetch()` request deduping—all maximizing the efficiency of sending data client side.

RSC 在服务端执行数据获取，这不仅保障了对后端数据的安全访问，还通过减少服务端与客户端之间的交互显著提升了性能。[结合 Next.js 的增强能力](https://nextjs.org/docs/app/building-your-application/data-fetching?utm_source=vercel_site&utm_medium=web&utm_campaign=understanding_rsc)，RSC 还支持智能数据缓存、单次往返内并发多次 `fetch` 请求，以及自动去重 `fetch()` 请求——所有这些特性共同极大提升了向客户端传输数据的效率。

Perhaps most importantly, fetching data on the server helps to prevent client-side data fetching waterfalls, where requests stack up against each other and have to be resolved in serial before the user can continue. Server-side fetches have a much smaller overhead, as they don't block the whole client and they resolve much more quickly.

或许最关键的是，服务端数据获取有助于避免客户端数据请求的“瀑布式阻塞”（waterfall）：即多个请求彼此依赖、必须串行执行完毕后用户才能继续操作。相较之下，服务端获取的开销要小得多——它不会阻塞整个客户端，且响应速度明显更快。

Additionally, you no longer need Next.js-specific, page-level methods like `getServerSideProps()` and `getStaticProps()`, which didn't offer granular enough control for individual components and tended to over-fetch data. (When the user navigated to the page, all data was fetched, regardless of what components they actually interacted with.)

此外，你不再需要 Next.js 特有的页面级数据获取方法（如 `getServerSideProps()` 和 `getStaticProps()`）。这些方法无法为单个组件提供足够精细的控制，且往往导致过度获取数据。（例如，用户访问某页面时，系统会一次性拉取全部数据，无论用户实际与哪些组件发生交互。）

In the Next.js App Router, all fetched data is now static by default, rendered at build time. However, this can be changed easily: Next.js extends the `fetch` options object to provide flexibility in caching and revalidating rules.

在 Next.js App Router 中，所有获取的数据默认均为静态数据，并于构建时完成渲染。不过，这一行为可轻松调整：Next.js 扩展了 `fetch` 的配置对象，以提供灵活的缓存与重新验证（revalidation）策略。

You can use the `{next: {revalidate: number}}` option to refresh static data at set intervals or when backend changes occur (Incremental Static Regeneration), while the `{cache: 'no-store'}` option can be passed in the fetch request for dynamic data (server-side rendering).

你可以使用 `{next: {revalidate: number}}` 选项，按固定时间间隔刷新静态数据，或在后端数据发生变化时触发更新（即“增量静态再生”，Incremental Static Regeneration）；而对于动态数据（服务端渲染场景），则可在 `fetch` 请求中传入 `{cache: 'no-store'}` 选项。

All this makes React Server Components within the Next.js App Router a powerful tool for efficient, secure, and dynamic data fetching, all cached by default to deliver a high-performance user experience.

所有这些使得 Next.js App Router 中的 React Server Components 成为一种强大工具，可用于高效、安全且动态的数据获取；默认即启用缓存，从而提供高性能的用户体验。

[**Looking for faster data fetching?**\\
\\
We've written up a detailed guide about the performance and DX gains for data fetching in the Next.js 13.4 App Router.\\
\\
Learn More](https://vercel.com/blog/nextjs-app-router-data-fetching)

[**希望实现更快的数据获取？**\\
\\
我们已撰写了一份详尽指南，深入解析 Next.js 13.4 App Router 在数据获取方面的性能提升与开发者体验（DX）优化。\\
\\
了解更多](https://vercel.com/blog/nextjs-app-router-data-fetching)

### Server Actions: React’s first steps into mutability

### Server Actions：React 迈向可变性的第一步

Within the context of RSCs, Server Actions are functions that you define in an RSC on the server side that you can then pass across the server/client boundary. When a user interacts with your app on the client side, they can directly call Server Actions which will be executed securely on the server side.

在 React Server Components（RSC）的语境下，Server Actions 是你在服务端 RSC 中定义的函数，可跨服务端/客户端边界传递。当用户在客户端与你的应用交互时，可直接调用 Server Actions，这些操作将在服务端安全执行。

This approach provides a seamless [Remote Procedure Call](https://en.wikipedia.org/wiki/Remote_procedure_call) (RPC) experience between the client and the server. Instead of writing a separate API route to communicate with the server, you can directly call Server Actions from your Client Components.

这一方式在客户端与服务端之间提供了无缝的 [远程过程调用（RPC）](https://zh.wikipedia.org/wiki/%E8%BF%9C%E7%A8%8B%E8%BF%87%E7%A8%8B%E8%B0%83%E7%94%A8) 体验。你无需额外编写 API 路由来与服务端通信，而是可直接从 Client Components 中调用 Server Actions。

Keep in mind, too, that the Next.js App Router is built entirely around smart data caching, revalidating, and mutating. [Server Actions in Next.js](https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions?utm_source=vercel_site&utm_medium=web&utm_campaign=understanding_rsc) mean you can both mutate the cache and update the React tree in the same roundtrip request to the server—all while maintaining client cache integrity through navigation.

还需注意，Next.js App Router 的整个架构完全围绕智能数据缓存、重新验证（revalidation）与变更（mutation）构建。[Next.js 中的 Server Actions](https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions?utm_source=vercel_site&utm_medium=web&utm_campaign=understanding_rsc) 意味着你可在一次往返服务端的请求中，同时变更缓存并更新 React 组件树——且在整个导航过程中持续保障客户端缓存的完整性。

Specifically, Server Actions are designed to handle tasks like database updates or form submissions. For example, they can progressively enhance your forms, which means that even if JavaScript hasn’t loaded yet, the user can still interact with the form, and Server Actions will handle the submission and processing of the form data.

具体而言，Server Actions 专为处理数据库更新或表单提交等任务而设计。例如，它们可对表单进行渐进式增强（progressive enhancement）：即使 JavaScript 尚未加载完成，用户仍可与表单交互，而 Server Actions 将负责表单的提交与数据处理。

The opportunities that Server Actions offer, both for progressive enhancement and eliminating development work on APIs, are great for accessibility, usability, and developer experience.

Server Actions 既支持渐进式增强，又可大幅减少 API 开发工作量，这对可访问性（accessibility）、可用性（usability）以及开发者体验（DX）均大有裨益。

### Let Next.js do the heavy lifting

### 让 Next.js 承担繁重工作

Next.js is the first framework to integrate the entire React architecture for Server Components, Server Actions, Suspense, Transitions, and all else that has changed with the release of RSCs.

Next.js 是首个全面集成 React 全新架构的框架，完整支持 Server Components、Server Actions、Suspense、Transitions，以及随 React Server Components（RSC）发布而引入的所有其他变革。

While you focus on building your product, Next.js uses strategic streaming and smart caching to make sure your application rendering stays non-blocking and serves dynamic data at top speeds.

当您专注于构建产品时，Next.js 通过策略性流式传输和智能缓存，确保应用渲染过程不被阻塞，并以最高速度提供动态数据。

Next.js strives to stay on the cutting edge of new React features without sacrificing stability, reliability, and backward compatibility. It will continue to offer smart defaults for your team to iterate quickly while maintaining flexibility and scalability for projects of any scope.

Next.js 致力于始终站在新 React 特性的前沿，同时不牺牲稳定性、可靠性与向后兼容性。它将持续为您提供智能默认配置，助力团队快速迭代，同时为任意规模的项目保留充分的灵活性与可扩展性。

## Where do you go from here?

## 接下来该怎么做？

Let’s recap: React Server Components offer a native way to interact with the server right within the component, lightening both the code and cognitive load of interacting with dynamic data. Client Components remain fully functional and fully usable just as before. Your new job is to choose when to use each one.

我们来回顾一下：React Server Components（RSC，React 服务端组件）提供了一种原生方式，让您直接在组件内部与服务端交互，从而减轻处理动态数据时的代码负担与认知负荷。Client Components（客户端组件）则完全保持原有功能与可用性，一如既往。您现在的新任务是——判断何时该使用哪一类组件。

For more guidance on this topic, feel free to visit [the Next.js docs](https://nextjs.org/docs/getting-started/react-essentials?utm_source=vercel_site&utm_medium=blog&utm_campaign=understanding_rsc). Additionally, we have an [App Router playground](https://vercel.com/templates/next.js/app-directory) you can get started with immediately to feel the differences yourself.

如需了解更多相关指导，欢迎访问 [Next.js 官方文档](https://nextjs.org/docs/getting-started/react-essentials?utm_source=vercel_site&utm_medium=blog&utm_campaign=understanding_rsc)。此外，我们还提供了 [App Router 演示环境](https://vercel.com/templates/next.js/app-directory)，您可以立即上手体验，亲身感受其中差异。

If you're interested in more articles on React Server Components, we think these are particularly insightful:

如果您希望阅读更多关于 React Server Components 的深度文章，我们认为以下几篇尤为富有洞见：

- ["We migrated 50,000 lines of code to React Server Components" \| Mux](https://www.mux.com/blog/what-are-react-server-components)  
- “我们将 5 万行代码迁移至 React Server Components” \| Mux

- ["Speeding up the dbt™ docs by 20x with React Server Components" \| Dagster](https://dagster.io/blog/dbt-docs-on-react)  
- “借助 React Server Components 将 dbt™ 文档加载速度提升 20 倍” \| Dagster

- ["Next.js App Router and Sanity CMS in action" \| Formidable](https://formidable.dev/blog/2023/powering-our-website-s-evolution-next-js-app-router-and-sanity-cms-in-action/)  
- “Next.js App Router 与 Sanity CMS 实战应用” \| Formidable

For direct assistance on migrating your team’s application to the App Router and React Server Components, feel free to [reach out to us](https://vercel.com/contact/sales).

如需获得针对贵团队应用向 App Router 和 React Server Components 迁移的专业支持，请随时 [联系我们](https://vercel.com/contact/sales)。

[![Tom Sherman](images/understanding-react-server-components-vercel/img_005.jpg)](https://x.com/tomus_sherman/status/1681355056950525963)

[汤姆·谢尔曼（Tom Sherman）](https://x.com/tomus_sherman/status/1681355056950525963)


· [关注](https://x.com/intent/follow?screen_name=tomus_sherman)

在 Twitter 上查看原文

Server components are like magic for reducing bandwidth

服务端组件就像“魔法”一样，能显著降低带宽消耗。

Data fetched from contentful: 60kb gzip

从 Contentful 获取的数据：60 KB（gzip 压缩后）

RSC payload to render that page: 8kb gzip

用于渲染该页面的 RSC 载荷：8 KB（gzip 压缩后）

🤯

[2023 年 7 月 18 日 下午 1:27](https://x.com/tomus_sherman/status/1681355056950525963) [Twitter 网站工具、广告信息与隐私政策](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[109](https://x.com/intent/like?tweet_id=1681355056950525963) [回复](https://x.com/intent/tweet?in_reply_to=1681355056950525963)

[Read 8 replies](https://x.com/tomus_sherman/status/1681355056950525963)

[阅读 8 条回复](https://x.com/tomus_sherman/status/1681355056950525963)

Vercel Template

Vercel 模板

Deploy this template

部署此模板

### Examples of many Next.js App Router features.

### 多种 Next.js App Router 功能示例

Next.js App Router Playground

Next.js App Router 交互式体验平台

Vercel.com landing page

Vercel.com 官网首页

### Incrementally adopt the App Router

### 渐进式采用 App Router
&#123;% endraw %}
