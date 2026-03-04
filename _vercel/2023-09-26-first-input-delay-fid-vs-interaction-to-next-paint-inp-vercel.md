---
render_with_liquid: false
title: "First Input Delay (FID) vs. Interaction to Next Paint (INP) - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/first-input-delay-vs-interaction-to-next-paint"
date: "2023-09-26"
scraped_at: "2026-03-02T09:50:22.258276986+00:00"
language: "en-zh"
translated: true
description: "Learn about the differences between FID and INP and how to optimize your website's INP score."
---
render_with_liquid: false
render_with_liquid: false

Sep 26, 2023

2023 年 9 月 26 日

Learn about the differences between FID and INP and how to optimize your website's INP score.

了解 FID 与 INP 的区别，以及如何优化您网站的 INP 分数。

As of March 2024, Interaction to Next Paint (INP) will replace the First Input Delay (FID) as a new Core Web Vital.

自 2024 年 3 月起，Interaction to Next Paint（INP）将取代 First Input Delay（FID），成为一项新的核心网页指标（Core Web Vital）。

First Input Delay is a web performance metric that measures the time between a user's very first interaction with a web page and the time when the browser's main thread is able to start processing that interaction event.

First Input Delay（FID）是一项网页性能指标，用于衡量用户首次与网页交互（例如点击、触摸或按键）到浏览器主线程能够开始处理该交互事件之间的时间间隔。

When a user interacts with a web page, an event is added to a queue to be processed by the browser's main thread. However, if the main thread is already busy doing other tasks like parsing HTML, executing JavaScript, or handling other event listeners, the new event has to wait in the queue.

当用户与网页交互时，相关事件会被加入队列，等待浏览器主线程处理。然而，若此时主线程正忙于执行其他任务（例如解析 HTML、运行 JavaScript 或处理其他事件监听器），该新事件便只能在队列中等待。

The FID metric captures the duration of this waiting time, which tells us how long it takes for the browser to respond to the user's first input while the main thread is busy.

FID 指标即用于捕捉这一等待时长，反映在主线程繁忙状态下，浏览器响应用户首次输入所需的时间。

![The First Input Delay measures the time between the first user interaction (clicks, taps, key presses) until the browser can process the event](images/first-input-delay-fid-vs-interaction-to-next-paint-inp-vercel/img_001.jpg)![The First Input Delay measures the time between the first user interaction (clicks, taps, key presses) until the browser can process the event](images/first-input-delay-fid-vs-interaction-to-next-paint-inp-vercel/img_002.jpg)The First Input Delay measures the time between the first user interaction (clicks, taps, key presses) until the browser can process the event

![First Input Delay 衡量的是用户首次交互（点击、触摸、按键）到浏览器能够处理该事件之间的时间](images/first-input-delay-fid-vs-interaction-to-next-paint-inp-vercel/img_001.jpg)![First Input Delay 衡量的是用户首次交互（点击、触摸、按键）到浏览器能够处理该事件之间的时间](images/first-input-delay-fid-vs-interaction-to-next-paint-inp-vercel/img_002.jpg)First Input Delay 衡量的是用户首次交互（点击、触摸、按键）到浏览器能够处理该事件之间的时间。

However, the First Input Delay (FID) metric has some shortcomings:

然而，First Input Delay（FID）指标存在一些局限性：

- **FID only considers the delay of the** **_first_** **input event**, ignoring subsequent interactions that may also be slow or even slower.

- **FID 仅关注** **_首次_** **输入事件的延迟**，而忽略了后续可能同样缓慢、甚至更慢的交互。

- Other factors can contribute to a longer visual feedback delay between user interactions, which FID doesn't measure. This includes the time it takes to process event handlers and recalculate the layout before providing visual feedback to the user.

- 其他因素也可能导致用户交互与视觉反馈之间的延迟变长，而 FID 并未涵盖这些方面——例如：执行事件处理器、重新计算页面布局（layout recalculation）等操作所耗费的时间，这些都会影响向用户呈现视觉反馈的速度。

## ) Interaction to Next Paint (INP)

## ) 交互到下一次绘制（INP）

To address these limitations, the Interaction to Next Paint (INP) metric will replace First Input Delay.

为解决上述局限性，交互到下一次绘制（INP）指标将取代首次输入延迟（FID）。

While FID only measured the input delay, which is the time between user input and the browser starting to execute the event handler, INP measures:

虽然 FID 仅测量输入延迟（即用户输入与浏览器开始执行事件处理器之间的时间），但 INP 测量以下三部分：

- **Input Delay**: the time between user interaction and the time the browser is able to process the event, similar to FID.

- **输入延迟**：用户交互与浏览器能够处理该事件之间的时间，与 FID 类似。

- **Processing Delay**: the time it takes the browser to process the event handlers

- **处理延迟**：浏览器处理事件处理器所花费的时间。

- **Presentational Delay**: the time it takes the browser to recalculate the layout and paint the pixels to the screen.

- **呈现延迟**：浏览器重新计算布局并将像素绘制到屏幕所需的时间。

![](images/first-input-delay-fid-vs-interaction-to-next-paint-inp-vercel/img_003.jpg)![](images/first-input-delay-fid-vs-interaction-to-next-paint-inp-vercel/img_004.jpg)

![](images/first-input-delay-fid-vs-interaction-to-next-paint-inp-vercel/img_003.jpg)![](images/first-input-delay-fid-vs-interaction-to-next-paint-inp-vercel/img_004.jpg)

Additionally, whereas FID only measured the _very first_ user interaction, the INP score is measured when the user leaves the page by aggregating _all interactions_ the user made with the page throughout the page’s lifetime and **returning the worst-measured score**.

此外，FID 仅测量用户在页面上的 _第一次_ 交互；而 INP 分数则是在用户离开页面时计算得出的——它汇总用户在整个页面生命周期内发生的 _所有交互_，并 **返回其中最差的一次测量结果**。

![Since the worst-measured score throughout the page's lifespan was 120ms, the total INP score will be 120.](images/first-input-delay-fid-vs-interaction-to-next-paint-inp-vercel/img_005.jpg)![Since the worst-measured score throughout the page's lifespan was 120ms, the total INP score will be 120.](images/first-input-delay-fid-vs-interaction-to-next-paint-inp-vercel/img_006.jpg)Since the worst-measured score throughout the page's lifespan was 120ms, the total INP score will be 120.

![由于页面整个生命周期中测得的最差分数为 120 毫秒，因此最终 INP 得分为 120。](images/first-input-delay-fid-vs-interaction-to-next-paint-inp-vercel/img_005.jpg)![由于页面整个生命周期中测得的最差分数为 120 毫秒，因此最终 INP 得分为 120。](images/first-input-delay-fid-vs-interaction-to-next-paint-inp-vercel/img_006.jpg)由于页面整个生命周期中测得的最差分数为 120 毫秒，因此最终 INP 得分为 120。

With INP, we no longer have to focus solely on optimizing event queuing times and main thread availability, as was the case with FID. Now, it is also crucial to address the entire lifecycle of a user interaction. This includes processing event handlers, recalculating layouts, and painting updates to the screen, all of which are critical components of the INP metric.

借助 INP，我们不再需要像使用 FID 那样，仅专注于优化事件排队时间与主线程可用性。如今，全面优化用户交互的整个生命周期同样至关重要——这包括事件处理器的执行、布局的重新计算，以及屏幕更新的绘制，而这些环节均为 INP 指标的关键组成部分。

## Optimizing your INP score

## 优化您的 INP 分数

For FID, the primary goal was to reduce the time between a user's initial interaction and when the browser's main thread starts processing it. This typically involved optimizing JavaScript execution times, breaking down long tasks, and ensuring the main thread remains as free as possible during user interactions.

对于 FID（首次输入延迟），主要目标是缩短用户首次交互与浏览器主线程开始处理该交互之间的时间。这通常涉及优化 JavaScript 执行时间、拆分长时间运行的任务，以及确保在用户交互期间主线程尽可能保持空闲。

However, with INP, we need to consider a broader range of performance factors.

然而，对于 INP（交互至下一个绘制时间），我们需要考虑更广泛的一系列性能影响因素。

### Processing Delay

### 处理延迟

The processing delay emphasizes the importance of not only starting the event handler quickly but also executing it efficiently. We can optimize the processing delay by:

处理延迟不仅强调事件处理器需快速启动，更强调其执行过程必须高效。我们可通过以下方式优化处理延迟：

- **Profiling code and identifying performance bottlenecks**.

- **对代码进行性能分析，识别性能瓶颈**。

- **Using techniques like** **`debounce`** **or** **`throttle`** for frequently firing event handlers.

- **对频繁触发的事件处理器，采用** **`debounce`**（防抖）**或** **`throttle`**（节流）等技术。

- **Code splitting and tree shaking** to reduce unnecessary JavaScript. Load only what is necessary, when it is necessary.

- **代码分割（code splitting）与摇树优化（tree shaking）**，以减少不必要的 JavaScript。仅在必要时、按需加载所需代码。

- **Breaking down long JavaScript tasks** into smaller chunks. The longer a task takes on the main thread, the longer it will block user interactions.

- **将长时间运行的 JavaScript 任务拆分为更小的片段**。主线程上任一任务耗时越长，对用户交互的阻塞时间也就越长。

### Presentational Delay

### 呈现延迟

After processing an event, the browser may need to recalculate styles, reflow layouts, and repaint the screen. We can optimize the presentational delay by:

事件处理完成后，浏览器可能需要重新计算样式、重排布局以及重绘屏幕。我们可以通过以下方式优化呈现延迟：

- Using the **`will-change`** property judiciously to inform the browser about properties and elements likely to be animated.

- 审慎使用 **`will-change`** 属性，向浏览器明确提示哪些属性和元素很可能发生动画变化。

- Opting for **`transform`** and **`opacity`** changes for animations as they are less likely to cause layout recalculations.

- 优先选用 **`transform`** 和 **`opacity`** 属性实现动画效果，因为它们通常不会触发布局重计算（layout recalculation）。

- Using properties like **`content-visibility`** to render and update content only when necessary.

- 利用 **`content-visibility`** 等 CSS 属性，仅在必要时才渲染和更新内容。

- **Reducing forced synchronous layouts.** Avoid reading layout properties immediately after writing them, as this can trigger the browser to synchronize and recalculate styles and layouts.

- **减少强制同步布局（forced synchronous layouts）。** 避免在修改布局相关属性后立即读取其值，否则会迫使浏览器同步执行样式计算与布局重排。

- **Using web forkers for non-urgent and non-UI tasks.** By offloading these tasks to background threads, you can keep the main thread free and responsive to user interactions.

- **对非紧急且非 UI 相关的任务使用 Web Workers。** 将此类任务卸载至后台线程执行，可确保主线程保持空闲，从而快速响应用户交互。

### Event Handling

### 事件处理

Event handlers should be executed efficiently and effectively. We can do this by:

事件处理器应高效、可靠地执行。我们可通过以下方式实现：

- **Deferring non-critical events** until the main thread is less busy.

- **延迟执行非关键事件**，直至主线程负载较低时再处理。

- **Using passive event listeners for** events like **`scroll`** and **`touch`**. This informs the browser that the event listener will not prevent a scroll or touch event, allowing the browser to continue smooth scrolling without waiting for the listener.

- **为 `scroll` 和 `touch` 等事件使用被动事件监听器（passive event listeners）。** 这向浏览器表明该监听器不会调用 `preventDefault()` 来阻止滚动或触摸行为，从而使浏览器无需等待监听器执行即可维持流畅的滚动体验。

- **事件委托（Delegating events）**：不为各个子元素单独添加事件监听器，而是将监听器附加到它们的共同父元素上，并利用事件对象的属性来判断用户实际与哪个子元素发生了交互。这种方法可减少活跃事件监听器的数量，从而避免潜在的性能下降。

## Measuring your INP score  
## 测量您的 INP 分数

To maintain an optimized and responsive website, Real User Monitoring (RUM) tools can be used to regularly collect performance data from actual users, which is crucial for measuring INP.  
为了保持网站的高性能与高响应性，可借助真实用户监控（Real User Monitoring, RUM）工具，持续从真实用户端收集性能数据——这对测量 INP 至关重要。

While the metric is not yet officially stable, we can already measure INP using tools like:  
尽管该指标尚未正式定稿，我们目前已可通过以下工具测量 INP：

- [Vercel Speed Insights](https://vercel.com/docs/speed-insights)  
- [Vercel Speed Insights](https://vercel.com/docs/speed-insights)

- [PageSpeed Insights](https://pagespeed.web.dev/)  
- [PageSpeed Insights](https://pagespeed.web.dev/)

- [Lighthouse's Timespan feature](https://web.dev/lighthouse-user-flows/)  
- [Lighthouse 的 Timespan 功能](https://web.dev/lighthouse-user-flows/)

The INP metric provides a broader perspective by recognizing the significance of not just the time it takes for the browser to start processing an event, but also the total time needed to respond to the user's interactions visually.  
INP 指标提供了更全面的视角：它不仅关注浏览器开始处理事件所需的时间，更重视在视觉层面完整响应用户交互所需的总耗时。

Optimizing for INP will not only result in more responsive and seamless interactions but also greatly enhance the overall user experience.  
针对 INP 进行优化，不仅能带来更快速、更流畅的交互体验，更能显著提升整体用户体验。

If you're using Next.js, using React 18's concurrent features can also help improve your INP score. [Learn more in this blog post](https://vercel.com/blog/how-react-18-improves-application-performance).  
若您正在使用 Next.js，启用 React 18 的并发特性（concurrent features）也有助于提升您的 INP 分数。[了解更多，请参阅这篇博客文章](https://vercel.com/blog/how-react-18-improves-application-performance)。