---
title: "What's new in Svelte 5 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/whats-new-in-svelte-5"
date: "2024-10-23"
scraped_at: "2026-03-02T09:40:04.859402384+00:00"
language: "en-zh"
translated: true
description: "Svelte 5 brings runes for universal reactivity, snippets for reusable markup, and compiler improvements. Get started with Svelte 5 on Vercel today."
---
{% raw %}

Oct 23, 2024

2024 年 10 月 23 日

Svelte 5 引入了用于通用响应式的 **runes**（符文）、用于可复用标记的 **snippets**（代码片段），以及编译器改进。

凭借其“编译器优先”的设计理念、细粒度的响应式机制，以及与任意 JavaScript 项目的无缝集成能力，Svelte 在众多前端框架中独树一帜。

在 Vercel，我们是 Svelte 的忠实拥趸——不仅深度投入其生态发展，更持续优化平台能力，致力于为构建与部署 Svelte 应用提供最佳体验。

[随着 Svelte 5 的正式发布](https://svelte.dev/blog/svelte-5-is-alive)，让我们一同探索本次版本更新的亮点所在。

![](images/what_s-new-in-svelte-5-vercel/img_001.jpg)![](images/what_s-new-in-svelte-5-vercel/img_002.jpg)

## Runes（符文）

## 符文（Runes）

Svelte 5 引入了 **runes**（符文）来管理响应式逻辑。这些特殊符号赋予开发者对应用状态的显式控制能力。

### `$state`、`$derived` 与 `$effect` 符文

### `$state`、`$derived` 和 `$effect` 符文

Svelte 5 全新响应式系统的核心，正是 `$state`、`$derived` 和 `$effect` 这三个符文。它们以简洁直观的方式，帮助你在组件内高效管理状态及其依赖关系。

- **`$state`**: Declares a reactive variable, replacing top-level `let` declarations from Svelte 4. Whenever a `$state` variable's value changes, Svelte automatically updates the value anywhere it's used in your component. This eliminates manual updates and simplifies state management.

- **`$state`**: 声明一个响应式变量，取代 Svelte 4 中顶层的 `let` 声明。每当 `$state` 变量的值发生变化时，Svelte 会自动更新组件中所有使用该变量的位置。这消除了手动更新的需要，简化了状态管理。

- **`$derived`**: Creates reactive values based on other `$state` or `$derived` values. When a dependency changes, Svelte marks the `$derived` value for recalculation upon its next read. This ensures consistency and simplifies complex calculations. It replaces the `$:` syntax from Svelte 4, offering more granular reactivity with fewer gotchas.

- **`$derived`**: 基于其他 `$state` 或 `$derived` 值创建响应式派生值。当某个依赖项发生变化时，Svelte 会在下次读取该 `$derived` 值时将其标记为需重新计算。这保证了数据一致性，并简化了复杂计算逻辑。它取代了 Svelte 4 中的 `$:` 语法，提供了更细粒度的响应性，且陷阱（gotchas）更少。

- **`$effect`**: Runs code in response to state changes (e.g., rendering to a `<canvas>` or interacting with an external library). While powerful, use `$effect` sparingly, as excessive side effects can make your code harder to follow. Svelte encourages declarative approaches whenever possible.

- **`$effect`**: 在状态变化时执行代码（例如向 `<canvas>` 渲染内容，或与外部库交互）。虽然功能强大，但应谨慎使用 `$effect`；过多的副作用会使代码逻辑难以追踪。Svelte 始终鼓励尽可能采用声明式的方式。

### Signals and fine-grained reactivity

### 信号（Signals）与细粒度响应性

Frameworks like [Solid](https://www.solidjs.com/) have popularized signals, which offer a responsive approach to reactivity. A signal is a container that notifies subscribers when its value changes. This lets frameworks track dependencies precisely and update only necessary parts of the application, improving performance.

像 [Solid](https://www.solidjs.com/) 这样的框架推动了“信号（signals）”的普及，它提供了一种响应式的响应性实现方式。信号是一个容器，当其值发生变化时，会主动通知所有订阅者。这使得框架能够精准追踪依赖关系，并仅更新应用程序中真正需要变更的部分，从而提升性能。

Runes like `$state` and `$derived` let you work with reactive values directly, while Svelte's compiler handles the underlying signal management.

诸如 `$state` 和 `$derived` 这类“符文（runes）”，让你能直接操作响应式值，而 Svelte 编译器则在底层负责信号的管理。

For example, writing a counter component in Svelte 5 is as straightforward as:

例如，在 Svelte 5 中编写一个计数器组件，简洁程度堪比：

Counter.svelte

Counter.svelte

```jsx
1<script>

2  let count = $state(0);
```

3  let doubled = $derived(count * 2);

3  let doubled = $derived(count * 2);

4</script>

4</script>

6<button onclick={() => count++}>

6<button onclick={() => count++}>

7  Clicks: {count}

7  点击次数：{count}

8</button>

8</button>

10<p>Click doubled: {doubled}</p>

10<p>点击次数的两倍：{doubled}</p>
```

```

### Universal reactivity with `.svelte.js` files

### 使用 `.svelte.js` 文件实现通用响应式机制

Previously, managing global state in Svelte often involved stores, which had a different API and behavior than component-level reactivity. This created a disconnect and sometimes led to inconsistencies.

此前，在 Svelte 中管理全局状态通常依赖于 store，而 store 的 API 和行为与组件级响应式机制不同。这造成了概念上的割裂，有时还会导致不一致问题。

With `.svelte.js` and `.svelte.ts` files, you define shared state and logic in a single place and access it from any component using runes. This eliminates prop drilling, simplifies complex store setups, reduces boilerplate, and improves code maintainability.

使用 `.svelte.js` 和 `.svelte.ts` 文件，您可在单一位置定义共享状态与逻辑，并通过 runes 从任意组件中访问它们。这消除了属性逐层传递（prop drilling），简化了复杂 store 的配置，减少了样板代码，并提升了代码的可维护性。

Svelte now treats reactivity as a first-class language construct, blurring the lines between components and application logic for a more cohesive and intuitive development experience. This is a shift from Svelte 3 and 4, where reactivity was primarily confined to components.

Svelte 现在将响应式（reactivity）视为一门语言的一等公民（first-class language construct），进一步模糊了组件与应用逻辑之间的界限，从而带来更统一、更直观的开发体验。这与 Svelte 3 和 Svelte 4 形成鲜明对比——在早期版本中，响应式能力主要局限于组件内部。

### Other runes

### 其他 runes

Svelte 5 introduces other runes that simplify common tasks and reduce boilerplate code. [Learn more about runes](https://svelte.dev/docs/svelte/what-are-runes).

Svelte 5 引入了其他 runes，用以简化常见任务并减少样板代码。[深入了解 runes](https://svelte.dev/docs/svelte/what-are-runes)。

## Compiler improvements

## 编译器改进

Svelte has always been compiler-first. Unlike traditional frameworks that perform calculations and virtual DOM diffing at runtime, Svelte shifts this work to compile time. It compiles your components into highly optimized vanilla JavaScript, eliminating the need for a runtime library.

Svelte 始终坚持“编译优先”（compiler-first）的设计理念。与传统框架不同——后者需在运行时执行计算和虚拟 DOM 差分（diffing）——Svelte 将这些工作移至编译阶段完成。它会将您的组件编译为高度优化的原生 JavaScript，从而完全摆脱对运行时库的依赖。

This results in smaller bundles, faster initial load times, and improved runtime performance. It also means you can use compiled Svelte components in any JavaScript project, including those that don't use Svelte.

其结果是：更小的打包体积、更快的首屏加载速度，以及更优的运行时性能。此外，您还可将编译后的 Svelte 组件直接用于任何 JavaScript 项目中，包括那些并未采用 Svelte 的项目。

Svelte 5 builds on this foundation with compiler improvements that enhance performance, reduce bundle sizes, and streamline development.

Svelte 5 在这一坚实基础上进一步优化编译器，以提升性能、减小打包体积，并使开发流程更加顺畅。

### Components as functions

### 组件即函数

In Svelte 5, components are now plain JavaScript functions. This simplifies optimization, as build tools and JavaScript engines optimize functions effectively. For example, function components can be inlined into their caller, reducing overhead.

在 Svelte 5 中，组件现在就是普通的 JavaScript 函数。这简化了优化过程，因为构建工具和 JavaScript 引擎均能高效地优化函数。例如，函数式组件可被内联（inline）到其调用方中，从而降低运行开销。

Svelte is the first major framework where components directly call each other, eliminating intermediary functions or complex component creation mechanisms. This contributes to Svelte's performance and excellent Core Web Vital scores.

Svelte 是首个主流框架，其中组件可直接相互调用，无需中介函数或复杂的组件创建机制。这有助于提升 Svelte 的运行性能，并使其核心网页指标（Core Web Vitals）得分表现优异。

### Native TypeScript support

### 原生 TypeScript 支持

Svelte 5 introduces native TypeScript support. Previous versions used a preprocessor, which added moving parts (like source maps) and slowed down builds.

Svelte 5 引入了原生 TypeScript 支持。此前的版本依赖预处理器，这会引入额外环节（例如源码映射），并拖慢构建速度。

Native TypeScript support means faster builds and the ability to use TypeScript annotations directly in your Svelte markup—for instance, inside inline event handlers.

原生 TypeScript 支持意味着更快的构建速度，以及可在 Svelte 模板中直接使用 TypeScript 类型注解的能力——例如，在内联事件处理器内部。

This, combined with the [new approach to event handling](https://svelte.dev/docs/svelte/v5-migration-guide#Event-changes) and simplified state management with runes, makes for easier development and library authoring.

再加上[全新的事件处理方式](https://svelte.dev/docs/svelte/v5-migration-guide#Event-changes)以及借助 runes 实现的简化状态管理，使得开发和库编写都更加轻松。

## Snippets

## 片段（Snippets）

Svelte 5 introduces _snippets_, which let you define reusable blocks of markup and logic within a component, which can then be rendered multiple times or passed to other components. They also replace Svelte 4’s slots.

Svelte 5 引入了 _片段（snippets）_，允许你在组件内定义可复用的标记与逻辑块，这些片段可被多次渲染，也可传递给其他组件。它们同时取代了 Svelte 4 中的插槽（slots）。

Let’s look at an example:

我们来看一个示例：

App.svelte

App.svelte

```jsx
1<script>

2  let items =  [\
\
3    { id: 1, name: 'Apple', price: 0.5 },\
\
4    { id: 2, name: 'Banana', price: 0.25 },\
\
5    { id: 3, name: 'Orange', price: 0.75 }\
\
6  ]

2  let items =  [\
\
3    { id: 1, name: 'Apple', price: 0.5 },\
\
4    { id: 2, name: 'Banana', price: 0.25 },\
\
5    { id: 3, name: 'Orange', price: 0.75 }\
\
6  ]

7</script>



7</script>



9<ul>

9<ul>



10  {#each items as item}

10  {#each items as item}



11    {@render row(item)}

11    {@render row(item)}



12  {/each}

12  {/each}



13</ul>



13</ul>



15{#snippet row(item)}

15{#snippet row(item)}

16  <li>

16  <li>

17    <span>{item.name}:</span>

17    <span>{item.name}：</span>

18    <span>${item.price.toFixed(2)}</span>

18    <span>￥{item.price.toFixed(2)}</span>

19  </li>

19  </li>

20{/snippet}
```

20{/snippet}
```

In this example, we define a `row` snippet that encapsulates the markup for each item in the list. The snippet is then rendered for each item using the `{@render}` tag within the `{#each}` block.

在此示例中，我们定义了一个名为 `row` 的代码片段（snippet），用于封装列表中每个条目的 HTML 标记。随后，在 `{#each}` 块内，通过 `{@render}` 标签为每个条目渲染该片段。

Snippets can also be passed as props to other components:

代码片段也可以作为属性（props）传递给其他组件：

App.svelte

App.svelte

```jsx
1<script>

1<script>

2  import ItemList from './ItemList.svelte';

2  import ItemList from './ItemList.svelte';

4  let items = [\
\
5    { id: 1, name: 'Apple', price: 0.5 },\
\
6    { id: 2, name: 'Banana', price: 0.25 },\
\
7    { id: 3, name: 'Orange', price: 0.75 }\
\
8  ];

4  let items = [\
\
5    { id: 1, name: '苹果', price: 0.5 },\
\
6    { id: 2, name: '香蕉', price: 0.25 },\
\
7    { id: 3, name: '橙子', price: 0.75 }\
\
8  ];

9</script>



9</script>



11<ItemList {items}>

11<ItemList {items}>

12  // Implicitly pass this snippet as a prop.

12  // 隐式地将此代码片段作为 prop 传递。

13  {#snippet row(item)}

13  {#snippet row(item)}

14    <li>

14    <li>

15      <span>{item.name}:</span>

15      <span>{item.name}：</span>

16      <span>${item.price.toFixed(2)}</span>

16      <span>¥{item.price.toFixed(2)}</span>

17    </li>

17    </li>

18  {/snippet}

18  {/snippet}

19</ItemList>
```

19</ItemList>
```

ItemList.svelte

ItemList.svelte

```jsx
1<script>

1<script>

2  let { row, items } = $props()

2  let { row, items } = $props()

3</script>



3</script>



5{#each items as item}

5{#each items as item}

6  {@render row(item)}
6  {@render row(item)}

7{/each}
```

In this case, we pass a `row` snippet from `App.svelte` to `ItemList.svelte`. This separation of concerns makes it easy to reuse the `ItemList` component with different item rendering styles without modifying its internal structure.

在此示例中，我们从 `App.svelte` 向 `ItemList.svelte` 传递一个 `row` 片段。这种关注点分离使得 `ItemList` 组件能够轻松复用于不同的条目渲染样式，而无需修改其内部结构。

[Learn more about snippets.](https://svelte.dev/docs/svelte/snippet)

[了解更多关于片段（snippets）的信息。](https://svelte.dev/docs/svelte/snippet)

## Vite benefits

## Vite 的优势

SvelteKit uses Vite, so you benefit from its [growing ecosystem](https://www.youtube.com/watch?v=EKvvptbTx6k). Any tool that works in Vite also works in SvelteKit.

SvelteKit 基于 Vite 构建，因此您可以直接享用其[日益壮大的生态系统](https://www.youtube.com/watch?v=EKvvptbTx6k)。所有在 Vite 中可用的工具，在 SvelteKit 中同样可用。

You can access a wide range of tools and plugins that enhance the development experience with minimal configuration. For example:

您可轻松接入大量工具与插件，在几乎无需额外配置的前提下显著提升开发体验。例如：

- Vitest for unit and integration testing  
- Vitest：用于单元测试与集成测试  

- Storybook for component development  
- Storybook：用于组件开发  

- `@sveltejs/enhanced-img` for static image optimization  
- `@sveltejs/enhanced-img`：用于静态图像优化  

Svelte also benefits from Vite's optimized development server and hot module replacement (HMR), which speeds up development workflows.

Svelte 同样受益于 Vite 优化的开发服务器与热模块替换（HMR）机制，从而显著加快开发流程。

## Svelte's growing community

## Svelte 日益壮大的社区

Svelte's growth and popularity are evident in industry surveys like the [2024 Stack Overflow Developer Survey](https://stackoverflow.blog/2024/07/24/developers-want-more-more-more-the-2024-results-from-stack-overflow-s-annual-developer-survey/) (itself built with Svelte), which ranks Svelte at 73% developer satisfaction, and the [State of JavaScript 2023 survey](https://2023.stateofjs.com/en-US/libraries/front-end-frameworks/), which ranks Svelte highly for positivity and retention.

Svelte 的增长与受欢迎程度，在行业调查中显而易见，例如 [2024 年 Stack Overflow 开发者调查报告](https://stackoverflow.blog/2024/07/24/developers-want-more-more-more-the-2024-results-from-stack-overflow-s-annual-developer-survey/)（该报告本身即使用 Svelte 构建），其中 Svelte 的开发者满意度高达 73%；再如 [2023 年 JavaScript 现状调查](https://2023.stateofjs.com/en-US/libraries/front-end-frameworks/)，Svelte 在“积极评价”与“用户留存率”两项指标上均名列前茅。

Many companies, large and small, use Svelte:

众多大小企业都在使用 Svelte：

- [Apple Podcasts](https://podcasts.apple.com/us/browse) 和 [Apple Music](https://music.apple.com/us/new)

- [IKEA](https://www.ikea.com/)

- [Yelp 的 Top 100 榜单](https://top100.yelp.com/)

- [GitPod](https://www.gitpod.io/)

- [Appwrite](https://appwrite.io/)


And Vercel customers like [Dbrand](https://dbrand.com/) and [Hugging Face](https://huggingface.co/).

以及 Vercel 的客户，例如 [Dbrand](https://dbrand.com/) 和 [Hugging Face](https://huggingface.co/)。

> “Svelte Svelte has allowed to us to ship quickly and with confidence, helping us keep pace with a dynamic AI ecosystem, despite a minority of the team being frontend developers. Our latest version of Gradio is also built on top of SvelteKit, bringing all of the power and performance of a best-in-class framework to around 1 million developers every month. The future is equally exciting; now that we are using SvelteKit, we can release a whole host of new features that would otherwise be costly to implement and support.Svelte has allowed to us to ship quickly and with confidence, helping us keep pace with a dynamic AI ecosystem, despite a minority of the team being frontend developers. Our latest version of Gradio is also built on top of SvelteKit, bringing all of the power and performance of a best-in-class framework to around 1 million developers every month. The future is equally exciting; now that we are using SvelteKit, we can release a whole host of new features that would otherwise be costly to implement and support.”
>
> “Svelte 让我们得以快速、自信地交付产品，即便团队中仅有少数前端开发者，也能跟上充满活力的 AI 生态系统的发展节奏。我们最新版的 Gradio 同样基于 SvelteKit 构建，每月为约 100 万开发者提供业界顶尖框架所具备的全部能力与卓越性能。未来同样令人振奋：如今我们已采用 SvelteKit，便能高效推出大量新功能——若沿用旧技术栈，这些功能的开发与维护成本将十分高昂。”

> ![](images/what_s-new-in-svelte-5-vercel/img_003.png)
>
> ![](images/what_s-new-in-svelte-5-vercel/img_003.png)

> **Peter Allen (pngwn),** Hugging Face
>
> **Peter Allen（pngwn）**，Hugging Face

[Join the Svelte community on Discord](https://discord.com/invite/svelte).

[加入 Discord 上的 Svelte 社区](https://discord.com/invite/svelte)。

## Svelte on Vercel

## Svelte 在 Vercel 上的部署

Vercel 致力于将自身平台打造为部署 Svelte 应用的最佳选择。我们与 Svelte 维护者紧密协作，Svelte 核心团队中亦有数名成员就职于 Vercel，以确保该框架拥有可持续的发展前景，并提供一流的部署体验。

[构建输出 API（Build Output API）](https://vercel.com/docs/build-output-api/v3) 使 [SvelteKit](https://svelte.dev/docs/kit/introduction)（及其他框架）能够实现 Vercel 的多项功能，例如：[增量静态再生（ISR）](https://vercel.com/docs/incremental-static-regeneration)、[流式无服务器函数响应（streaming serverless function responses）](https://vercel.com/docs/frameworks/sveltekit#streaming)、[动态图像优化（dynamic image optimization）](https://vercel.com/docs/frameworks/sveltekit#image-optimization)，以及 [偏移保护（Skew Protection）](https://vercel.com/docs/deployments/skew-protection)。Vercel 坚定承诺支持开放标准，以惠及整个 Web 开发生态。

近期 Vercel 上针对 SvelteKit 的改进包括：

- [增强的工具栏支持（Enhanced toolbar support）](https://vercel.com/changelog/easier-toolbar-setup-for-sveltekit-and-other-vite-based-frameworks)，简化调试流程；

- [改进的分析功能（Improved analytics）](https://vercel.com/docs/frameworks/sveltekit#web-analytics)，提供更深入的应用性能洞察；

- [集成化的功能标记（Integrated feature flagging）](https://vercel.com/changelog/sveltekit-now-supported-in-vercel-flags)，支持受控的功能发布；

- [速度洞察（Speed Insights）](https://vercel.com/docs/frameworks/sveltekit#speed-insights)，用于性能监控与优化（`svelte.dev` 网站即使用该功能，持续通过核心网页指标 Core Web Vitals）。

## Getting started with Svelte

## 开始使用 Svelte

Svelte 5 makes frontend development easier while staying flexible and powerful.  

Svelte 5 在保持灵活性与强大功能的同时，让前端开发变得更加轻松。

To get started, try the [interactive Svelte tutorial](https://svelte.dev/tutorial/svelte/welcome-to-svelte), deploy a [SvelteKit templates](https://vercel.com/templates/svelte), or view the official [Svelte 5 migration guide](https://svelte.dev/docs/svelte/v5-migration-guide).  

入门指南：尝试 [交互式 Svelte 教程](https://svelte.dev/tutorial/svelte/welcome-to-svelte)，部署一个 [SvelteKit 模板](https://vercel.com/templates/svelte)，或查阅官方 [Svelte 5 迁移指南](https://svelte.dev/docs/svelte/v5-migration-guide)。
{% endraw %}
