---
title: "Improving INP with React 18 and Suspense - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/improving-interaction-to-next-paint-with-react-18-and-suspense"
date: "2022-08-09"
scraped_at: "2026-03-02T10:01:12.102131535+00:00"
language: "en-zh"
translated: true
description: "Learn how to improve Interaction to Next Paint in React applications by using Suspense and selective hydration."
---
{% raw %}

Aug 9, 2022

2022年8月9日

How to optimize your application's responsiveness.

如何优化您应用的响应性。

_Updated January 18, 2024._

_更新于2024年1月18日。_

[Interaction to Next Paint (INP)](https://vercel.com/blog/demystifying-inp-new-tools-and-actionable-insights) measures your site’s responsiveness to user interactions on the page. The faster your page responds to user input, the better.

[交互到下一次绘制（Interaction to Next Paint，INP）](https://vercel.com/blog/demystifying-inp-new-tools-and-actionable-insights) 用于衡量您的网站对页面上用户交互行为的响应能力。页面对用户输入的响应越快，表现越好。

On March 12, 2024, INP will [officially replace First Input Delay (FID)](https://developers.google.com/search/blog/2023/05/introducing-inp) as the third [Core Web Vital](https://web.dev/articles/vitals).

2024年3月12日起，INP 将[正式取代首次输入延迟（First Input Delay，FID）](https://developers.google.com/search/blog/2023/05/introducing-inp)，成为第三项[核心网页指标（Core Web Vital）](https://web.dev/articles/vitals)。

This post will help you understand why INP is a better way to measure responsiveness than FID and how React and Next.js can improve INP. You'll be prepared for updates to Core Web Vitals, which impact [search rankings](https://nextjs.org/learn/seo), as INP moves from experimental to stable. We have a separate [post on understanding the metric and further optimization of INP.](https://vercel.com/blog/demystifying-inp-new-tools-and-actionable-insights)

本文将帮助您理解：为何 INP 是比 FID 更优的响应性衡量方式，以及 React 和 Next.js 如何提升 INP 表现。当 INP 从实验性指标转为稳定指标时，您将能从容应对核心网页指标（Core Web Vitals）的更新——这些更新会影响[搜索引擎排名](https://nextjs.org/learn/seo)。我们另有一篇[专门介绍该指标及其进一步优化方法的博文](https://vercel.com/blog/demystifying-inp-new-tools-and-actionable-insights)。

## ) Interaction to Next Paint (INP)

## ) 交互到下一次绘制（INP）

Delivering a great user experience is not just about the first initial load, but also about how responsive the page is to interaction. INP helps measure this responsiveness.

提供出色的用户体验，不仅关乎页面的首次加载，更在于页面对用户交互的响应能力。INP 正是用于衡量这种响应能力的指标。

A low INP means the given page was able to respond with visual feedback quickly for the majority of interactions. This is measured from the time of the first event to when the browser could show a visual update.

较低的 INP 值意味着该页面在绝大多数交互中都能迅速给出视觉反馈。其测量方式为：从首次事件发生起，至浏览器能够呈现视觉更新为止所经历的时间。

![An INP below or at 200 milliseconds means that your page has good responsiveness.](images/improving-inp-with-react-18-and-suspense-vercel/img_001.jpg)![An INP below or at 200 milliseconds means that your page has good responsiveness.](images/improving-inp-with-react-18-and-suspense-vercel/img_002.jpg)An INP below or at 200 milliseconds means that your page has good responsiveness.

![INP 低于或等于 200 毫秒，表示您的页面具备良好的响应性。](images/improving-inp-with-react-18-and-suspense-vercel/img_001.jpg)  
![INP 低于或等于 200 毫秒，表示您的页面具备良好的响应性。](images/improving-inp-with-react-18-and-suspense-vercel/img_002.jpg)  
INP 低于或等于 200 毫秒，表示您的页面具备良好的响应性。

Keep in mind that, by default, JavaScript is single-threaded. If you’re loading a large JS script, nothing else can happen on your page until the main thread is idle—even [reacting to a user’s click on a plain HTML link](https://web.dev/articles/fid#what_if_an_interaction_doesnt_have_an_event_listener).

请记住，JavaScript 默认是单线程的。如果你正在加载一个体积较大的 JS 脚本，那么在主线程空闲之前，页面上其他任何操作都无法进行——甚至包括[响应用户对普通 HTML 链接的点击](https://web.dev/articles/fid#what_if_an_interaction_doesnt_have_an_event_listener)。

Improving INP means improving how quickly this main thread can respond to user interaction.

提升 INP 指标，意味着提升主线程响应用户交互的速度。

### How does INP differ from FID?

### INP 与 FID 有何区别？

FID will soon be replaced by INP as a Core Web Vital, responsible in part for ranking your application in Google Search. Let’s break down the differences between the two:

FID 即将被 INP 取代，成为核心网页指标（Core Web Vital）之一，并在一定程度上影响你的应用在 Google 搜索结果中的排名。下面我们来详细对比这两项指标的区别：

- FID measures only the **first** input and browser response. INP considers the responsiveness of all user input for the duration of the page session.

- FID 仅测量**首次**用户输入及其浏览器响应；而 INP 则衡量整个页面会话期间所有用户输入的响应性。

- FID only measures the delay between input and the browser _starting_ to respond. INP measures the time between the input and the event completing in response.

- FID 仅测量从输入发生到浏览器**开始响应**之间的延迟；而 INP 测量的是从输入发生到响应事件**完全完成**所经历的时间。

- INP additionally groups events that occur as part of the same logical user interaction, defining the interaction’s latency as the max duration of all its events.

- INP 还进一步将属于同一逻辑用户交互的一系列事件归为一组，并将该交互的延迟定义为其中所有事件耗时的最大值。

Let’s explore some practical solutions to lower INP with React, like selective hydration with Suspense. These techniques can also improve other metrics such as FID, [Total Blocking Time (TBT)](https://web.dev/tbt), and [Time to Interactive (TTI)](https://web.dev/tti/).

接下来，我们探讨一些借助 React 降低 INP 的实用方案，例如结合 `Suspense` 的选择性水合（selective hydration）。这些技术同样有助于改善其他性能指标，例如 FID、[总阻塞时间（TBT）](https://web.dev/tbt) 和 [可交互时间（TTI）](https://web.dev/tti/)。

## React 18 and Selective Hydration

## React 18 与选择性水合

React 18 was designed to help improve interactivity with features like [selective hydration](https://github.com/reactwg/react-18/discussions/130) and [`startTransition`](https://github.com/reactwg/react-18/discussions/41). [Concurrent React](https://reactjs.org/blog/2022/03/29/react-v18.html#what-is-concurrent-react) is able to prioritize what you interact with and is interruptible if higher-priority interactions occur.

React 18 的设计目标之一便是借助 [选择性水合（selective hydration）](https://github.com/reactwg/react-18/discussions/130) 和 [`startTransition`](https://github.com/reactwg/react-18/discussions/41) 等特性来提升页面交互性。[并发 React（Concurrent React）](https://reactjs.org/blog/2022/03/29/react-v18.html#what-is-concurrent-react) 能够优先处理你正在交互的内容，并且当更高优先级的交互发生时，当前任务可被中断。

React and Next.js are able to generate HTML on the server and send it to the client. The initial rendered HTML is not interactive until the JavaScript for the page has been fetched and loaded. **Hydration** then makes your page interactive through JavaScript (e.g. attaching event handlers to a button).

React 和 Next.js 能够在服务器端生成 HTML 并将其发送至客户端。初始渲染出的 HTML 在页面所需的 JavaScript 被获取并加载完成之前是不可交互的。**水合（Hydration）** 随后通过 JavaScript 使页面具备交互能力（例如，为按钮绑定事件处理器）。

Before React (17 and lower) is able to hydrate _any_ of the components, JavaScript for the entire page needs to be fetched. During this period, the page is not interactive. For example:

在 React（17 及更低版本）能够对 _任意_ 组件执行水合操作之前，整个页面的 JavaScript 必须先被完整获取。在此期间，页面处于不可交互状态。例如：

```jsx
1// JavaScript for the entire page must be loaded

2// before the page can become interactive

export default function HomePage() {

4  return (

5    <>

6      <Header />

7      <Body />

8      <Footer />
```

9    </>

10  );

11}
```

JavaScript for the entire page must be loaded before the page can become interactive.

整页 JavaScript 必须全部加载完毕，页面才能具备交互能力。

With React 18, you can take hydration off the main thread and make it non-blocking, simply by creating a `Suspense` boundary.

在 React 18 中，你只需创建一个 `Suspense` 边界，即可将水合（hydration）过程移出主线程，使其变为非阻塞操作。

You no longer have to wait for all the JavaScript to load to start hydrating parts of the page. This means components can become interactive faster by allowing the browser to do other work at the same time as hydration, making your page more responsive and resulting in lower FID and INP.

你不再需要等待全部 JavaScript 加载完成，即可开始对页面的局部区域进行水合。这意味着组件能更快进入可交互状态——浏览器可在执行水合的同时并行处理其他任务，从而提升页面响应速度，并降低首次输入延迟（FID）与交互至下一次绘制时间（INP）。

```jsx
import { Suspense } from 'react';



3// Using a loading component as the Suspense fallback

3// 使用加载组件作为 Suspense 的回退内容

6// 使用 `Suspense` 可使水合（hydration）变为非阻塞式

export default function HomePage() {

8  return (

9    <>

10      <Header />

11      <Suspense fallback={<Loading />}>

12        <Body />

13        <Footer />

14      </Suspense>

15    </>

15    </>

16  );

16  );

17}
```

17}
```

Using Suspense makes hydration non-blocking with React 18.

使用 Suspense 可使 React 18 中的水合（hydration）过程变为非阻塞式。

These changes help improve the interactivity of all React applications.

这些改动有助于提升所有 React 应用的交互性。

## Case Study: Next.js Site

## 案例研究：Next.js 官网

We were able to reduce the [Total Blocking Time (TBT)](https://web.dev/tbt) of [nextjs.org](http://nextjs.org/) from 430ms to 80ms using selective hydration with Suspense while validating changes with Lighthouse (”lab” metrics).

我们通过结合 Suspense 实现选择性水合（selective hydration），将 [nextjs.org](http://nextjs.org/) 的[总阻塞时间（TBT）](https://web.dev/tbt) 从 430 毫秒降低至 80 毫秒；同时，我们借助 Lighthouse（“实验室”指标）对变更效果进行了验证。

```jsx
```jsx
1// Simplified version of the changes made to

1// 对 nextjs.org 首页所做改动的简化版本，旨在通过 `Suspense` 提升 INP

2// the nextjs.org landing page to improve INP with `Suspense`

2// the nextjs.org landing page to improve INP with `Suspense`

export default function Index() {
export default function Index() {

4  return (

4  返回（

5    <Page title="Next.js by Vercel - The React Framework">

5    <Page title="Vercel 推出的 Next.js —— React 框架">

6      <SkipNavContent />

6      <SkipNavContent />

7      <Banner badge="New" href="/blog/next-12-2">

7      <Banner badge="新功能" href="/blog/next-12-2">

8        {"Next.js 12.2 →"}

8        {"Next.js 12.2 →"}

9      </Banner>

9      </Banner>

10      <Hero />

10      <Hero />

11      <Suspense fallback={<Loading />}>

11      <Suspense fallback={<Loading />}>

12        <Features />

12        <Features />

13        <Customers />

13        <Customers />

14        <Learn />

14        <学习 />

15        <Newsletter />

15        <新闻通讯 />

16        <Footer />

16        <页脚 />

17      </Suspense>

17      </Suspense>

18    </Page>

18    </Page>

19  );

19  );

20}
```

20}
```

Simplified version of the changes made to the nextjs.org landing page to improve INP with Suspense.

对 nextjs.org 首页所做的简化版修改，旨在通过 `Suspense` 提升交互响应性（INP）。

You can omit the Suspense `fallback`, but proceed with caution. If any components in the subtree suspend, you risk showing a broken, empty state.

可省略 `Suspense` 的 `fallback` 属性，但需谨慎操作：若子树中任一组件触发挂起（suspend），页面可能出现损坏或空白状态。

Adding `Suspense` to group major areas of the page allows these components to be hydrated independently. Experiment with wrapping major blocks of your site with `Suspense` to achieve similar results.

在页面的主要区域添加 `Suspense`，可使这些组件独立完成水合（hydration）。建议尝试将网站中的主要区块用 `Suspense` 包裹，以获得类似效果。

After rolling out these changes to production, we saw Vitals ("field" metrics) improve to:

将这些变更部署到生产环境后，我们观察到“核心 Web 指标”（即“实地”指标）得到提升：

- **First Input Delay:** 5ms (Good)

- **First Input Delay（首次输入延迟）：** 5 毫秒（良好）

- **Interaction to Next Paint:** 48ms (Good)

- **Interaction to Next Paint（INP，交互至下一次绘制）：** 48 毫秒（良好）

![Interaction to Next Paint (INP) of nextjs.org from Vercel Analytics.](images/improving-inp-with-react-18-and-suspense-vercel/img_003.jpg)![Interaction to Next Paint (INP) of nextjs.org from Vercel Analytics.](images/improving-inp-with-react-18-and-suspense-vercel/img_004.jpg)Interaction to Next Paint (INP) of nextjs.org from Vercel Analytics.

![Vercel Analytics 显示的 nextjs.org 网站 Interaction to Next Paint（INP）指标。](images/improving-inp-with-react-18-and-suspense-vercel/img_003.jpg)![Vercel Analytics 显示的 nextjs.org 网站 Interaction to Next Paint（INP）指标。](images/improving-inp-with-react-18-and-suspense-vercel/img_004.jpg)Vercel Analytics 显示的 nextjs.org 网站 Interaction to Next Paint（INP）指标。

For Next.js developers, we're also working to add support for route transitions (using React 18's `startTransition`) with the new [layouts and routing changes](https://nextjs.org/blog/layouts-rfc). This enables navigations to be interruptable if higher priority events occur, leading to further responsiveness.

对于 Next.js 开发者，我们还在积极推进对路由过渡（使用 React 18 的 `startTransition`）的支持，该功能将随全新的 [布局与路由机制更新](https://nextjs.org/blog/layouts-rfc) 一同推出。这使得导航过程可在更高优先级事件发生时被中断，从而进一步提升应用响应性。

## Other ways to optimize INP

## 其他优化 INP 的方法

Since the main thread must be idle in order to process event handlers, you can also look into these techniques to optimize INP:

由于主线程必须处于空闲状态才能处理事件处理器，你还可以尝试以下技术来优化 INP：

- Using CSS instead of JavaScript for animations, since a separate thread handles CSS, called the browser’s compositor thread. Some CSS properties, such as transforms, can also [use the GPU for rendering](https://developer.mozilla.org/en-US/docs/Web/Performance/Fundamentals#specific_coding_tips_for_application_performance).

- 优先使用 CSS 而非 JavaScript 实现动画效果，因为 CSS 由浏览器中一个独立的线程（即合成器线程，compositor thread）处理；部分 CSS 属性（例如 `transform`）还可[利用 GPU 进行渲染](https://developer.mozilla.org/zh-CN/docs/Web/Performance/Fundamentals#application_performance_的特定编码建议)。

- [Throttling or debouncing events](https://www.freecodecamp.org/news/javascript-debounce-example/)—especially ones driven by scrolling—that may be called repeatedly by user input.

- [节流（throttling）或防抖（debouncing）事件](https://www.freecodecamp.org/news/javascript-debounce-example/)——尤其是由滚动等用户输入频繁触发的事件。

- [Reducing your DOM size](https://web.dev/articles/dom-size-and-interactivity), to avoid having the browser recalculate too many elements on each render.

- [减小 DOM 规模](https://web.dev/zh-cn/articles/dom-size-and-interactivity)，以避免浏览器在每次渲染时重新计算过多元素。

- Related to the above, inline SVGs can be especially troublesome if you have too many or if they [end up in your client-side JS bundle](https://kurtextrem.de/posts/svg-in-js) (for example, by inlining them in JSX). You may need reference them in an `<img>` tag or look into [alternate ways of rendering them](https://css-tricks.com/too-many-svgs-clogging-up-your-markup-try-use/), such as keeping them in [React Server Components](https://vercel.com/blog/understanding-react-server-components).

- 上述问题相关的是，内联 SVG 在数量过多时可能尤为棘手，尤其是当它们[最终被打包进客户端 JavaScript 代码包中](https://kurtextrem.de/posts/svg-in-js)（例如，在 JSX 中直接内联 SVG）。你可能需要改用 `<img>` 标签引用 SVG 文件，或探索[其他渲染方式](https://css-tricks.com/too-many-svgs-clogging-up-your-markup-try-use/)，例如将 SVG 放在 [React Server Components](https://vercel.com/blog/understanding-react-server-components) 中管理。

- In the case of a complex application, using web workers to [arbitrarily execute JavaScript on separate threads](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers), keeping the main thread open for user input.

- 对于复杂应用，可借助 Web Workers [在独立线程中任意执行 JavaScript](https://developer.mozilla.org/zh-CN/docs/Web/API/Web_Workers_API/Using_web_workers)，从而确保主线程始终空闲，以响应用户输入。

- Lazy loading images, fonts, or scripts, which [Next.js can automatically do for you](https://nextjs.org/docs/app/building-your-application/optimizing).

- 对图片、字体或脚本实施懒加载（lazy loading），而 [Next.js 可自动为你完成该优化](https://nextjs.org/docs/app/building-your-application/optimizing)。

You can start measuring INP today inside [Vercel Speed Insights](https://vercel.com/docs/speed-insights), which gives you real-time information from your real users about how your site is performing. This enables you to quickly debug performance issues and focus on what optimizations are working.

你现在即可在 [Vercel Speed Insights](https://vercel.com/docs/speed-insights) 中开始测量 INP（Interaction to Next Paint）。它能从真实用户处实时采集网站性能数据，助你快速定位性能问题，并聚焦于真正有效的优化措施。
{% endraw %}
