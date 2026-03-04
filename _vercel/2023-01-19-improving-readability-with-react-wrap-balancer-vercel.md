---
render_with_liquid: false
title: "Improving readability with React Wrap Balancer - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/react-wrap-balancer"
date: "2023-01-19"
scraped_at: "2026-03-02T09:56:04.763274511+00:00"
language: "en-zh"
translated: true
description: "React Wrap Balancer tidies up bad typography and matches line lengths on the fly."
---
render_with_liquid: false
render_with_liquid: false

Jan 19, 2023

2023 年 1 月 19 日

A binary search algorithm to easily manage text-wrapping.

一种二分搜索算法，可轻松管理文本换行。

Titles and headings on websites play a crucial role in helping users understand the content and context of a webpage. Unfortunately, these elements can often be difficult to read due to typographical anti-patterns, such as a single hanging word on the last line.

网页上的标题与标题在帮助用户理解网页内容及上下文方面起着至关重要的作用。遗憾的是，由于排版方面的反模式（anti-patterns）——例如最后一行仅剩一个孤立单词——这些元素常常难以阅读。

To tidy up these "widows and orphans," [React Wrap Balancer](https://react-wrap-balancer.vercel.app/?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_react_wrap_balancer) reduces the content wrapper to the minimum possible width before an extra line break is required. As a result, the lines of text stay balanced and legible, especially when the content is lengthy.

为清理这类“寡行（widows）与孤行（orphans）”，[React Wrap Balancer](https://react-wrap-balancer.vercel.app/?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_react_wrap_balancer) 采用一种策略：在必须插入额外换行符之前，将内容容器的宽度缩减至最小可能值。由此，文本行得以保持均衡与易读性，尤其适用于篇幅较长的内容。

## Solving the text wrapping dilemma

## 解决文本换行困境

The idea of using text wrapping to improve the readability of titles is not a new one. Anything that impacts legibility ultimately impacts accessibility, so several organizations have made efforts to improve text clarity across the web.

利用文本换行提升标题可读性的想法并非新近出现。任何影响可读性的因素，最终都会影响可访问性（accessibility），因此多家机构已致力于提升全网范围内的文本清晰度。

In 2012, Adobe released the [balance-text](https://github.com/adobe/balance-text) project, which is based on jQuery and provides an imperative API for dealing with raw DOM elements. It's a great starting point for understand text balancing concepts, even if it's wasn't built for use with React.

2012 年，Adobe 发布了基于 jQuery 的 [balance-text](https://github.com/adobe/balance-text) 项目，它提供了一套命令式（imperative）API，用于直接操作原始 DOM 元素。尽管该项目并非专为 React 设计，但它仍是理解文本均衡（text balancing）概念的绝佳入门资源。

A few years later, the New York Times released a similar project called [text-balancer](https://github.com/nytimes/text-balancer), which presents more advanced features and tackles some of the issues that exist with the original project. However, like the Adobe project, it doesn't prevent layout shifts, which can negatively impact the same readability we're trying to improve.

几年后，《纽约时报》发布了一个类似项目——[text-balancer](https://github.com/nytimes/text-balancer)，它具备更高级的功能，并解决了初代项目中存在的一些问题。然而，与 Adobe 的项目一样，它也无法防止布局偏移（layout shifts），而这种偏移恰恰会损害我们正努力提升的可读性。

More recently, Daniel Aleksandersen wrote [an article](https://www.ctrl.blog/entry/text-wrap-balance.html) on the history of these projects and how they could be further improved. There's also a [text-wrap: balance](https://drafts.csswg.org/css-text-4/#text-wrap) proposal from the CSS Working Group, which means balanced text could be CSS-native in the future.

最近，Daniel Aleksandersen 撰写了一篇 [文章](https://www.ctrl.blog/entry/text-wrap-balance.html)，回顾了这些项目的发展历程，并探讨了其进一步优化的方向。此外，CSS 工作组还提出了一项 [text-wrap: balance](https://drafts.csswg.org/css-text-4/#text-wrap) 规范草案，这意味着未来文本均衡功能或将原生集成于 CSS 中。

### The current solution

### 当前解决方案

React Wrap Balancer, available for use in any React project, builds upon the above efforts with an incredible algorithm and optimizations for React and Next.js apps. The `<Balancer>` can be placed in either client-side components or [React Server Components](https://nextjs.org/docs/advanced-features/react-18/server-components?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_react_wrap_balancer), and when doing the latter, ships much less JavaScript to the browser. It's optimized for the [Next.js 13 app directory](https://beta.nextjs.org/docs/routing/fundamentals#the-app-directory?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_react_wrap_balancer) with out-of-the-box support for [Streaming SSR](https://beta.nextjs.org/docs/data-fetching/streaming-and-suspense?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_react_wrap_balancer).

React Wrap Balancer 可在任何 React 项目中使用，它在前述工作基础上进一步引入了卓越的算法，并针对 React 和 Next.js 应用进行了深度优化。`<Balancer>` 组件既可置于客户端组件中，也可置于 [React 服务端组件（React Server Components）](https://nextjs.org/docs/advanced-features/react-18/server-components?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_react_wrap_balancer) 中；若采用后者，则向浏览器传输的 JavaScript 代码量将显著减少。该库专为 [Next.js 13 的 `app` 目录结构](https://beta.nextjs.org/docs/routing/fundamentals#the-app-directory?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_react_wrap_balancer) 设计，并原生支持 [流式服务端渲染（Streaming SSR）](https://beta.nextjs.org/docs/data-fetching/streaming-and-suspense?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_react_wrap_balancer)。

Recently, we shipped the `<Balancer>` site-wide at Vercel. Take a look at the difference:

最近，我们在 Vercel 全站范围内部署了 `<Balancer>`。请看效果对比：

![The Vercel blog, before and after React Wrap Balancer.](images/improving-readability-with-react-wrap-balancer-vercel/img_001.jpg)![The Vercel blog, before and after React Wrap Balancer.](images/improving-readability-with-react-wrap-balancer-vercel/img_002.jpg)The Vercel blog, before and after React Wrap Balancer.

![Vercel 博客页面，启用 React Wrap Balancer 前后对比。](images/improving-readability-with-react-wrap-balancer-vercel/img_001.jpg)![Vercel 博客页面，启用 React Wrap Balancer 前后对比。](images/improving-readability-with-react-wrap-balancer-vercel/img_002.jpg)Vercel 博客页面，启用 React Wrap Balancer 前后对比。

## Tech specs

## 技术规格

At less than 1 kB when compressed, React Wrap Balancer is a lightweight and versatile tool that can be used in any project. It’s also compatible with the Next.js 13 `app` directory, React Server Components, and streaming SSR.

压缩后体积不足 1 kB，React Wrap Balancer 是一款轻量、通用的工具，适用于任意项目。它同时兼容 Next.js 13 的 `app` 目录、React 服务端组件（RSC）以及流式服务端渲染（Streaming SSR）。

A demonstration of how React Wrap Balancer minimizes content wrapper width to match line lengths.

该图演示了 React Wrap Balancer 如何动态缩小内容容器宽度，使其与每行文本长度精准匹配。

The most impressive aspect of React Wrap Balancer is its algorithm. It uses an efficient binary search algorithm: knowing that the minimum width of a title wrapper must be between zero and the full width of the wrapper, the algorithm repeatedly halves the wrapper width until its height increases. An increased height means a line break has occurred. The algorithm then goes backwards or forwards in similar halved steps until it finds exactly where that break happened. This is far more efficient than [other methods](https://vercel.com/blog/react-wrap-balancer#innovation-in-text-wrapping), and even if the title wrapper fills a 4k screen (approximately 3840px wide), the algorithm will only need to loop 12 times.

React Wrap Balancer 最令人惊叹之处在于其核心算法：它采用高效的二分搜索策略——已知标题容器的最小可行宽度介于 0 与容器原始宽度之间，算法便持续将容器宽度减半，直至其高度发生增加；高度增加即表明发生了换行。随后，算法以类似方式向前或向后进行半步试探，精确定位换行发生的临界点。该方法远比 [其他方案](https://vercel.com/blog/react-wrap-balancer#innovation-in-text-wrapping) 更高效；即便标题容器铺满 4K 屏幕（约 3840 像素宽），算法也仅需最多 12 次迭代即可完成计算。

The `<Balancer>` renders each version of your text in as little as [a quarter of a millisecond](https://react-wrap-balancer.vercel.app/#:~:text=changes%20when%20resizing-,Performance%20Impact,-It%20is%20worth?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_react_wrap_balancer) when working with fewer than 100 strings.

当处理少于 100 个字符串时，`<Balancer>` 渲染每种文本变体所需时间低至 [0.25 毫秒](https://react-wrap-balancer.vercel.app/#:~:text=changes%20when%20resizing-,Performance%20Impact,-It%20is%20worth?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_react_wrap_balancer)。

![A tooltip on the Vercel site, before and after React Wrap Balancer.](images/improving-readability-with-react-wrap-balancer-vercel/img_003.jpg)![A tooltip on the Vercel site, before and after React Wrap Balancer.](images/improving-readability-with-react-wrap-balancer-vercel/img_004.jpg)A tooltip on the Vercel site, before and after React Wrap Balancer.

![Vercel 网站上的一个提示框（tooltip），启用 React Wrap Balancer 前后对比。](images/improving-readability-with-react-wrap-balancer-vercel/img_003.jpg)![Vercel 网站上的一个提示框（tooltip），启用 React Wrap Balancer 前后对比。](images/improving-readability-with-react-wrap-balancer-vercel/img_004.jpg)Vercel 网站上的一个提示框（tooltip），启用 React Wrap Balancer 前后对比。

### Solving for layout shift

### 解决布局偏移（Layout Shift）问题

To avoid visual change and layout shifts, you want to immediately show the balanced version to your visitors when they see the title. That means the algorithm must execute right after the element is displayed on the screen.

为避免视觉变化和布局偏移，您希望在用户看到标题时立即向其展示已均衡排版的版本。这意味着算法必须在该元素显示于屏幕后立即执行。

For client-side rendering, React provides the [`useLayoutEffect`](https://reactjs.org/docs/hooks-reference.html#uselayouteffect) API so that you can synchronously run the `<Balancer>` when the element is rendered.

对于客户端渲染（CSR），React 提供了 [`useLayoutEffect`](https://reactjs.org/docs/hooks-reference.html#uselayouteffect) API，使您能在元素渲染完成时同步执行 `<Balancer>`。

However, for server-side rendered apps, unhydrated HTML often loads in before React itself. The solution is to put an inlined `<script>` tag that runs the `<Balancer>` next to your title element. This way the `<Balancer>` is executed immediately when the title renders.

然而，对于服务端渲染（SSR）应用，未激活（unhydrated）的 HTML 通常会在 React 自身加载完成前就已载入。解决方案是在标题元素旁内联一个 `<script>` 标签来运行 `<Balancer>`。这样，标题一完成渲染，`<Balancer>` 就会立即执行。

### Resizing the wrapper

### 调整包装容器尺寸

When the user resizes the window or when your code dynamically updates the size of the title wrapper, the `<Balancer>` uses the [`ResizeObserver`](https://developer.mozilla.org/en-US/docs/Web/API/ResizeObserver) JavaScript API to ensure the text stays balanced.

当用户调整窗口大小，或您的代码动态更改标题包装容器的尺寸时，`<Balancer>` 会利用 [`ResizeObserver`](https://developer.mozilla.org/en-US/docs/Web/API/ResizeObserver) JavaScript API 来确保文本始终保持均衡排版。

A demonstration of text formatting dynamically with React Wrap Balancer and ResizeObserver.

这是一个使用 React Wrap Balancer 与 ResizeObserver 动态格式化文本的演示示例。

### What about Svelte?

### 那么 Svelte 呢？

The Svelte community has [already announced a port](https://twitter.com/hamiltonulmer/status/1609285690906509312) of React Wrap Balancer. While it still needs a little finessing to properly handle SSR, you can [tinker with the source code](https://svelte.dev/repl/c89106671a304631ad069c0c595aaffb?version=3.55.0) on the Svelte REPL and implement it in your Svelte project today.

Svelte 社区已[正式宣布推出 React Wrap Balancer 的移植版本](https://twitter.com/hamiltonulmer/status/1609285690906509312)。尽管目前仍需稍作完善以更妥善地支持服务端渲染（SSR），您已可在 [Svelte REPL 上尝试修改其源码](https://svelte.dev/repl/c89106671a304631ad069c0c595aaffb?version=3.55.0)，并立即将其集成到您的 Svelte 项目中。

## Use React Wrap Balancer in your project

## 在您的项目中使用 React Wrap Balancer

Try out React Wrap Balancer today:

今天就试用 React Wrap Balancer 吧：

1. `npx create-next-app@latest`

1. `npx create-next-app@latest`

2. `npm i react-wrap-balancer`

2. `npm i react-wrap-balancer`

3. Add this snippet anywhere in your code:

3. 在代码中的任意位置添加以下代码片段：

app.tsx

app.tsx

```tsx
import Balancer from 'react-wrap-balancer'



3// ...



function Title() {

6  return(
```

7    <h1>

8      <Balancer>My readability is improved by React Wrap Balancer!</Balancer>

9    </h1>

10  )

11}
```

一个使用 React Wrap Balancer 快速上手的示例。

然后，调整浏览器窗口大小，观察文本如何自动均衡换行。

如果您希望 _进一步_ 提升性能，还可以将整个应用包裹在一个导入的 `<Provider>` 组件中；该组件会巧妙地在所有 `<Balancer>` 组件之间共享换行逻辑。

如需了解更多，请访问 [项目 GitHub 仓库](https://github.com/shuding/react-wrap-balancer?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_react_wrap_balancer) 和 [React Wrap Balancer 演示页面](https://react-wrap-balancer.vercel.app/?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_react_wrap_balancer)。