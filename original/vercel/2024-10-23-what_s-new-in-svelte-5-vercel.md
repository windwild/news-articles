---
title: "What's new in Svelte 5 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/whats-new-in-svelte-5"
date: "2024-10-23"
scraped_at: "2026-03-02T09:40:04.859402384+00:00"
language: "en"
translated: false
description: "Svelte 5 brings runes for universal reactivity, snippets for reusable markup, and compiler improvements. Get started with Svelte 5 on Vercel today."
---




Oct 23, 2024

Svelte 5 brings runes for universal reactivity, snippets for reusable markup, and compiler improvements.

With its compiler-first approach, fine-grained reactivity, and ability to integrate with any JavaScript project, Svelte stands apart from other frameworks.

At Vercel, we're big fans of Svelte—deeply invested in its success and constantly working to make our platform the best place to build and deploy Svelte apps.

[With the arrival of Svelte 5](https://svelte.dev/blog/svelte-5-is-alive), let's explore what makes this release exciting.

![](images/what_s-new-in-svelte-5-vercel/img_001.jpg)![](images/what_s-new-in-svelte-5-vercel/img_002.jpg)

## Runes

Svelte 5 introduces _runes_ to manage reactivity. These symbols give you explicit control over application state.

### The `$state`, `$derived`, and `$effect` runes

At the heart of Svelte 5's updated reactivity system are the `$state`, `$derived`, and `$effect` runes. These provide concise ways to manage state and its dependencies within your components.

- **`$state`**: Declares a reactive variable, replacing top-level `let` declarations from Svelte 4. Whenever a `$state`variable's value changes, Svelte automatically updates the value anywhere it's used in your component. This eliminates manual updates and simplifies state management.

- **`$derived`**: Creates reactive values based on other `$state` or `$derived` values. When a dependency changes, Svelte marks the `$derived` value for recalculation upon its next read. This ensures consistency and simplifies complex calculations. It replaces the `$:` syntax from Svelte 4, offering more granular reactivity with fewer gotchas.

- **`$effect`**: Runs code in response to state changes (e.g., rendering to a `<canvas>` or interacting with an external library). While powerful, use `$effect` sparingly, as excessive side effects can make your code harder to follow. Svelte encourages declarative approaches whenever possible.


### Signals and fine-grained reactivity

Frameworks like [Solid](https://www.solidjs.com/) have popularized signals, which offer a responsive approach to reactivity. A signal is a container that notifies subscribers when its value changes. This lets frameworks track dependencies precisely and update only necessary parts of the application, improving performance.

Runes like `$state` and `$derived` let you work with reactive values directly, while Svelte's compiler handles the underlying signal management.

For example, writing a counter component in Svelte 5 is as straightforward as:

Counter.svelte

```jsx
1<script>

2  let count = $state(0);

3  let doubled = $derived(count * 2);

4</script>



6<button onclick={() => count++}>

7  Clicks: {count}

8</button>



10<p>Click doubled: {doubled}</p>
```

### Universal reactivity with `.svelte.js` files

Previously, managing global state in Svelte often involved stores, which had a different API and behavior than component-level reactivity. This created a disconnect and sometimes led to inconsistencies.

With `.svelte.js` and `.svelte.ts` files, you define shared state and logic in a single place and access it from any component using runes. This eliminates prop drilling, simplifies complex store setups, reduces boilerplate, and improves code maintainability.

Svelte now treats reactivity as a first-class language construct, blurring the lines between components and application logic for a more cohesive and intuitive development experience. This is a shift from Svelte 3 and 4, where reactivity was primarily confined to components.

### Other runes

Svelte 5 introduces other runes that simplify common tasks and reduce boilerplate code. [Learn more about runes](https://svelte.dev/docs/svelte/what-are-runes).

## Compiler improvements

Svelte has always been compiler-first. Unlike traditional frameworks that perform calculations and virtual DOM diffing at runtime, Svelte shifts this work to compile time. It compiles your components into highly optimized vanilla JavaScript, eliminating the need for a runtime library.

This results in smaller bundles, faster initial load times, and improved runtime performance. It also means you can use compiled Svelte components in any JavaScript project, including those that don't use Svelte.

Svelte 5 builds on this foundation with compiler improvements that enhance performance, reduce bundle sizes, and streamline development.

### Components as functions

In Svelte 5, components are now plain JavaScript functions. This simplifies optimization, as build tools and JavaScript engines optimize functions effectively. For example, function components can be inlined into their caller, reducing overhead.

Svelte is the first major framework where components directly call each other, eliminating intermediary functions or complex component creation mechanisms. This contributes to Svelte's performance and excellent Core Web Vital scores.

### Native TypeScript support

Svelte 5 introduces native TypeScript support. Previous versions used a preprocessor, which added moving parts (like source maps) and slowed down builds.

Native TypeScript support means faster builds and the ability to use TypeScript annotations directly in your Svelte markup—for instance, inside inline event handlers.

This, combined with the [new approach to event handling](https://svelte.dev/docs/svelte/v5-migration-guide#Event-changes) and simplified state management with runes, makes for easier development and library authoring.

## Snippets

Svelte 5 introduces _snippets_, which let you define reusable blocks of markup and logic within a component, which can then be rendered multiple times or passed to other components. They also replace Svelte 4’s slots.

Let’s look at an example:

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

7</script>



9<ul>

10  {#each items as item}

11    {@render row(item)}

12  {/each}

13</ul>



15{#snippet row(item)}

16  <li>

17    <span>{item.name}:</span>

18    <span>${item.price.toFixed(2)}</span>

19  </li>

20{/snippet}
```

In this example, we define a `row` snippet that encapsulates the markup for each item in the list. The snippet is then rendered for each item using the `{@render}` tag within the `{#each}` block.

Snippets can also be passed as props to other components:

App.svelte

```jsx
1<script>

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

9</script>



11<ItemList {items}>

12  // Implicitly pass this snippet as a prop.

13  {#snippet row(item)}

14    <li>

15      <span>{item.name}:</span>

16      <span>${item.price.toFixed(2)}</span>

17    </li>

18  {/snippet}

19</ItemList>
```

ItemList.svelte

```jsx
1<script>

2  let { row, items } = $props()

3</script>



5{#each items as item}

6  {@render row(item)}

7{/each}
```

In this case, we pass a `row` snippet from `App.svelte` to `ItemList.svelte`. This separation of concerns makes it easy to reuse the `ItemList` component with different item rendering styles without modifying its internal structure.

[Learn more about snippets.](https://svelte.dev/docs/svelte/snippet)

## Vite benefits

SvelteKit uses Vite, so you benefit from its [growing ecosystem](https://www.youtube.com/watch?v=EKvvptbTx6k). Any tool that works in Vite also works in SvelteKit.

You can access a wide range of tools and plugins that enhance the development experience with minimal configuration. For example:

- Vitest for unit and integration testing

- Storybook for component development

- `@sveltejs/enhanced-img` for static image optimization


Svelte also benefits from Vite's optimized development server and hot module replacement (HMR), which speeds up development workflows.

## Svelte's growing community

Svelte's growth and popularity are evident in industry surveys like the [2024 Stack Overflow Developer Survey](https://stackoverflow.blog/2024/07/24/developers-want-more-more-more-the-2024-results-from-stack-overflow-s-annual-developer-survey/) (itself built with Svelte), which ranks Svelte at 73% developer satisfaction, and the [State of JavaScript 2023 survey](https://2023.stateofjs.com/en-US/libraries/front-end-frameworks/), which ranks Svelte highly for positivity and retention.

Many companies, large and small, use Svelte:

- [Apple Podcasts](https://podcasts.apple.com/us/browse) and [Apple Music](https://music.apple.com/us/new)

- [IKEA](https://www.ikea.com/)

- [Yelp's Top 100 List](https://top100.yelp.com/)

- [GitPod](https://www.gitpod.io/)

- [Appwrite](https://appwrite.io/)


And Vercel customers like [Dbrand](https://dbrand.com/) and [Hugging Face](https://huggingface.co/).

> “Svelte Svelte has allowed to us to ship quickly and with confidence, helping us keep pace with a dynamic AI ecosystem, despite a minority of the team being frontend developers. Our latest version of Gradio is also built on top of SvelteKit, bringing all of the power and performance of a best-in-class framework to around 1 million developers every month. The future is equally exciting; now that we are using SvelteKit, we can release a whole host of new features that would otherwise be costly to implement and support.Svelte has allowed to us to ship quickly and with confidence, helping us keep pace with a dynamic AI ecosystem, despite a minority of the team being frontend developers. Our latest version of Gradio is also built on top of SvelteKit, bringing all of the power and performance of a best-in-class framework to around 1 million developers every month. The future is equally exciting; now that we are using SvelteKit, we can release a whole host of new features that would otherwise be costly to implement and support.”
>
> ![](images/what_s-new-in-svelte-5-vercel/img_003.png)
>
> **Peter Allen (pngwn),** Hugging Face

[Join the Svelte community on Discord](https://discord.com/invite/svelte).

## Svelte on Vercel

Vercel is invested in making our platform the best place to deploy Svelte apps. We collaborate closely with Svelte maintainers, and several members of the Svelte core team work at Vercel to ensure a sustainable future for the framework and a premier deployment experience.

The [Build Output API](https://vercel.com/docs/build-output-api/v3) enables [SvelteKit](https://svelte.dev/docs/kit/introduction) (and other frameworks) to implement Vercel features like [Incremental Static Regeneration (ISR)](https://vercel.com/docs/incremental-static-regeneration), [streaming serverless function responses](https://vercel.com/docs/frameworks/sveltekit#streaming), [dynamic image optimization](https://vercel.com/docs/frameworks/sveltekit#image-optimization), and [Skew Protection](https://vercel.com/docs/deployments/skew-protection). Vercel is committed to open standards that can benefit the entire web development ecosystem.

Recent SvelteKit improvements on Vercel include:

- [Enhanced toolbar support](https://vercel.com/changelog/easier-toolbar-setup-for-sveltekit-and-other-vite-based-frameworks) for streamlined debugging

- [Improved analytics](https://vercel.com/docs/frameworks/sveltekit#web-analytics) for deeper insights into application performance

- [Integrated feature flagging](https://vercel.com/changelog/sveltekit-now-supported-in-vercel-flags) for controlled rollouts

- [Speed Insights](https://vercel.com/docs/frameworks/sveltekit#speed-insights) for performance monitoring and optimization (used on `svelte.dev` for consistently passing Core Web Vitals).


## Getting started with Svelte

Svelte 5 makes frontend development easier while staying flexible and powerful. To get started, try the [interactive Svelte tutorial](https://svelte.dev/tutorial/svelte/welcome-to-svelte), deploy a [SvelteKit templates](https://vercel.com/templates/svelte), or view the official [Svelte 5 migration guide](https://svelte.dev/docs/svelte/v5-migration-guide).