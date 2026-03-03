---
title: "Improving readability with React Wrap Balancer - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/react-wrap-balancer"
date: "2023-01-19"
scraped_at: "2026-03-02T09:56:04.763274511+00:00"
language: "en"
translated: false
description: "React Wrap Balancer tidies up bad typography and matches line lengths on the fly."
---




Jan 19, 2023

A binary search algorithm to easily manage text-wrapping.

Titles and headings on websites play a crucial role in helping users understand the content and context of a webpage. Unfortunately, these elements can often be difficult to read due to typographical anti-patterns, such as a single hanging word on the last line.

To tidy up these "widows and orphans," [React Wrap Balancer](https://react-wrap-balancer.vercel.app/?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_react_wrap_balancer) reduces the content wrapper to the minimum possible width before an extra line break is required. As a result, the lines of text stay balanced and legible, especially when the content is lengthy.

## Solving the text wrapping dilemma

The idea of using text wrapping to improve the readability of titles is not a new one. Anything that impacts legibility ultimately impacts accessibility, so several organizations have made efforts to improve text clarity across the web.

In 2012, Adobe released the [balance-text](https://github.com/adobe/balance-text) project, which is based on jQuery and provides an imperative API for dealing with raw DOM elements. It's a great starting point for understand text balancing concepts, even if it's wasn't built for use with React.

A few years later, the New York Times released a similar project called [text-balancer](https://github.com/nytimes/text-balancer), which presents more advanced features and tackles some of the issues that exist with the original project. However, like the Adobe project, it doesn't prevent layout shifts, which can negatively impact the same readability we're trying to improve.

More recently, Daniel Aleksandersen wrote [an article](https://www.ctrl.blog/entry/text-wrap-balance.html) on the history of these projects and how they could be further improved. There's also a [text-wrap: balance](https://drafts.csswg.org/css-text-4/#text-wrap) proposal from the CSS Working Group, which means balanced text could be CSS-native in the future.

### The current solution

React Wrap Balancer, available for use in any React project, builds upon the above efforts with an incredible algorithm and optimizations for React and Next.js apps. The `<Balancer>` can be placed in either client-side components or [React Server Components](https://nextjs.org/docs/advanced-features/react-18/server-components?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_react_wrap_balancer), and when doing the latter, ships much less JavaScript to the browser. It's optimized for the [Next.js 13 app directory](https://beta.nextjs.org/docs/routing/fundamentals#the-app-directory?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_react_wrap_balancer) with out-of-the-box support for [Streaming SSR](https://beta.nextjs.org/docs/data-fetching/streaming-and-suspense?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_react_wrap_balancer).

Recently, we shipped the `<Balancer>` site-wide at Vercel. Take a look at the difference:

![The Vercel blog, before and after React Wrap Balancer.](images/improving-readability-with-react-wrap-balancer-vercel/img_001.jpg)![The Vercel blog, before and after React Wrap Balancer.](images/improving-readability-with-react-wrap-balancer-vercel/img_002.jpg)The Vercel blog, before and after React Wrap Balancer.

## Tech specs

At less than 1 kB when compressed, React Wrap Balancer is a lightweight and versatile tool that can be used in any project. It’s also compatible with the Next.js 13 `app` directory, React Server Components, and streaming SSR.

A demonstration of how React Wrap Balancer minimizes content wrapper width to match line lengths.

The most impressive aspect of React Wrap Balancer is its algorithm. It uses an efficient binary search algorithm: knowing that the minimum width of a title wrapper must be between zero and the full width of the wrapper, the algorithm repeatedly halves the wrapper width until its height increases. An increased height means a line break has occurred. The algorithm then goes backwards or forwards in similar halved steps until it finds exactly where that break happened. This is far more efficient than [other methods](https://vercel.com/blog/react-wrap-balancer#innovation-in-text-wrapping), and even if the title wrapper fills a 4k screen (approximately 3840px wide), the algorithm will only need to loop 12 times.

The `<Balancer>` renders each version of your text in as little as [a quarter of a millisecond](https://react-wrap-balancer.vercel.app/#:~:text=changes%20when%20resizing-,Performance%20Impact,-It%20is%20worth?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_react_wrap_balancer) when working with fewer than 100 strings.

![A tooltip on the Vercel site, before and after React Wrap Balancer.](images/improving-readability-with-react-wrap-balancer-vercel/img_003.jpg)![A tooltip on the Vercel site, before and after React Wrap Balancer.](images/improving-readability-with-react-wrap-balancer-vercel/img_004.jpg)A tooltip on the Vercel site, before and after React Wrap Balancer.

### Solving for layout shift

To avoid visual change and layout shifts, you want to immediately show the balanced version to your visitors when they see the title. That means the algorithm must execute right after the element is displayed on the screen.

For client-side rendering, React provides the [`useLayoutEffect`](https://reactjs.org/docs/hooks-reference.html#uselayouteffect) API so that you can synchronously run the `<Balancer>` when the element is rendered.

However, for server-side rendered apps, unhydrated HTML often loads in before React itself. The solution is to put an inlined `<script>` tag that runs the `<Balancer>` next to your title element. This way the `<Balancer>` is executed immediately when the title renders.

### Resizing the wrapper

When the user resizes the window or when your code dynamically updates the size of the title wrapper, the `<Balancer>` uses the [`ResizeObserver`](https://developer.mozilla.org/en-US/docs/Web/API/ResizeObserver) JavaScript API to ensure the text stays balanced.

A demonstration of text formatting dynamically with React Wrap Balancer and ResizeObserver.

### What about Svelte?

The Svelte community has [already announced a port](https://twitter.com/hamiltonulmer/status/1609285690906509312) of React Wrap Balancer. While it still needs a little finessing to properly handle SSR, you can [tinker with the source code](https://svelte.dev/repl/c89106671a304631ad069c0c595aaffb?version=3.55.0) on the Svelte REPL and implement it in your Svelte project today.

## Use React Wrap Balancer in your project

Try out React Wrap Balancer today:

1. `npx create-next-app@latest`

2. `npm i react-wrap-balancer`

3. Add this snippet anywhere in your code:


app.tsx

```tsx
import Balancer from 'react-wrap-balancer'



3// ...



function Title() {

6  return(

7    <h1>

8      <Balancer>My readability is improved by React Wrap Balancer!</Balancer>

9    </h1>

10  )

11}
```

An example of how to get started with React Wrap Balancer.

Then, resize your browser to watch your text get balanced.

If you'd like to _further_ improve performance, you can also wrap your entire app with an imported `<Provider>` component, which cleverly shares the wrapping logic between all your `<Balancer>` components.

To learn more, check out the [project's GitHub](https://github.com/shuding/react-wrap-balancer?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_react_wrap_balancer) and the [React Wrap Balancer demo](https://react-wrap-balancer.vercel.app/?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_react_wrap_balancer).