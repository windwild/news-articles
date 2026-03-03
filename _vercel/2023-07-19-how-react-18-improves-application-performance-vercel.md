---
title: "How React 18 Improves Application Performance - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-react-18-improves-application-performance"
date: "2023-07-19"
scraped_at: "2026-03-02T09:51:42.116307389+00:00"
language: "en-zh"
translated: true
description: "Learn how React 18's concurrent features like Transitions, Suspense, and React Server Components improve application performance."
---

Jul 19, 2023

2023年7月19日

Learn how concurrent features like Transitions, Suspense, and React Server Components improve application performance.

了解并发特性（如 Transitions、Suspense 和 React Server Components）如何提升应用性能。

React 18 has introduced concurrent features that fundamentally change the way React applications can be rendered. We'll explore how these latest features impact and improve your application's performance.

React 18 引入了并发特性，从根本上改变了 React 应用的渲染方式。我们将深入探讨这些最新特性如何影响并提升您应用的性能。

First, let's take a small step back to understand the basics of long tasks and the corresponding performance measurements.

首先，让我们稍作回顾，以理解“长任务”（long tasks）的基本概念及其对应的关键性能指标。

## Main thread and Long Tasks

## 主线程与长任务

When we run JavaScript in the browser, the JavaScript engine executes code in a single-threaded environment, which is often referred to as the main thread. Along with executing JavaScript code, the main thread is responsible for handling other tasks as well, including managing user interactions like clicks and keystrokes, processing network events, timers, updating animations, and managing browser reflows and repaints.

当我们在浏览器中运行 JavaScript 时，JavaScript 引擎在一个单线程环境中执行代码，该环境通常称为主线程（main thread）。除执行 JavaScript 代码外，主线程还需负责处理其他各类任务，包括响应用户交互（如点击和按键）、处理网络事件与定时器、更新动画，以及管理浏览器的重排（reflow）和重绘（repaint）。

![The main thread is responsible for handling tasks one by one](images/how-react-18-improves-application-performance-vercel/img_001.jpg)![The main thread is responsible for handling tasks one by one](images/how-react-18-improves-application-performance-vercel/img_002.jpg)  
![主线程负责逐个处理任务](images/how-react-18-improves-application-performance-vercel/img_001.jpg)![主线程负责逐个处理任务](images/how-react-18-improves-application-performance-vercel/img_002.jpg)  
The main thread is responsible for handling tasks one by one

主线程负责逐个处理任务

When a task is being processed, all other tasks must wait. While small tasks can be executed smoothly by browsers to provide a seamless user experience, longer tasks can be problematic as they can block other tasks from being processed.

当某项任务正在执行时，其余所有任务都必须等待。虽然浏览器可流畅执行小型任务，从而提供无缝的用户体验，但耗时较长的任务则可能引发问题——它们会阻塞其他任务的执行。

Any task that takes more than 50 milliseconds to run is considered a " [long task](https://web.dev/long-tasks-devtools/#what-are-long-tasks)".

任何执行时间超过 50 毫秒的任务均被视为“[长任务](https://web.dev/long-tasks-devtools/#what-are-long-tasks)”。

![](images/how-react-18-improves-application-performance-vercel/img_003.jpg)![](images/how-react-18-improves-application-performance-vercel/img_004.jpg)  
![](images/how-react-18-improves-application-performance-vercel/img_003.jpg)![](images/how-react-18-improves-application-performance-vercel/img_004.jpg)

This 50ms benchmark is based on the fact that devices must create a new frame every 16ms (60fps) to maintain a smooth visual experience. However, devices must also perform other tasks, such as responding to user input and executing JavaScript.

这一 50 毫秒基准源于一个事实：为维持流畅的视觉体验，设备必须每 16 毫秒（即 60 帧/秒）生成一帧新画面。然而，设备还需执行其他任务，例如响应用户输入和运行 JavaScript。

The 50ms benchmark allows the device to allocate resources to both rendering frames and performing other tasks, and provides an additional ~33.33ms for the device to perform other tasks while maintaining a smooth visual experience. You can read more about the 50ms benchmark in [this blog post](https://web.dev/rail/#response-process-events-in-under-50ms) covering the RAIL model.

50 毫秒基准为设备预留了资源，使其既能渲染画面帧，又能执行其他任务；在保障视觉流畅性的前提下，额外提供了约 33.33 毫秒的时间用于处理其他任务。您可参阅 [这篇博客文章](https://web.dev/rail/#response-process-events-in-under-50ms)，进一步了解涵盖 RAIL 模型的 50 毫秒基准。

To maintain optimal performance, it is important to minimize the number of long tasks. To measure the performance of your website, there are two metrics that measure the impact of long tasks on the performance of your applications: Total Blocking Time, and Interaction to Next Paint.

为保持最佳性能，应尽量减少长任务（long task）的数量。衡量网站性能时，有两个核心指标用于评估长任务对应用性能的影响：**总阻塞时间（Total Blocking Time, TBT）** 和 **交互到下次绘制时间（Interaction to Next Paint, INP）**。

[Total Blocking Time (TBT)](https://vercel.com/docs/concepts/speed-insights#total-blocking-time-tbt) is an important metric that measures the time between the [First Contentful Paint (FCP)](https://web.dev/fcp/) and [Time to Interactive (TTI)](https://web.dev/tti/). TBT is the sum of the time it took tasks longer than 50ms to execute, which can have a significant impact on the user experience.

[总阻塞时间（TBT）](https://vercel.com/docs/concepts/speed-insights#total-blocking-time-tbt) 是一项关键指标，用于衡量从 [首次内容绘制（FCP）](https://web.dev/fcp/) 到 [可交互时间（TTI）](https://web.dev/tti/) 之间的时段。TBT 等于所有执行耗时超过 50 毫秒的任务所超出部分的累加值，该值对用户体验有显著影响。

![The TBT is 45ms, since we have two tasks that took longer than 50ms before TTI, which exceeded the 50ms threshold by 30ms and 15ms respectively. The total blocking time is the accumulation of these values: 30ms + 15ms = 45ms. ](images/how-react-18-improves-application-performance-vercel/img_005.jpg)![The TBT is 45ms, since we have two tasks that took longer than 50ms before TTI, which exceeded the 50ms threshold by 30ms and 15ms respectively. The total blocking time is the accumulation of these values: 30ms + 15ms = 45ms. ](images/how-react-18-improves-application-performance-vercel/img_006.jpg)  
![TBT 为 45 毫秒，因为在 TTI 之前存在两个耗时超过 50 毫秒的任务，其超出阈值的部分分别为 30 毫秒和 15 毫秒。总阻塞时间为这些超时值之和：30 毫秒 + 15 毫秒 = 45 毫秒。](images/how-react-18-improves-application-performance-vercel/img_005.jpg)  
![TBT 为 45 毫秒，因为在 TTI 之前存在两个耗时超过 50 毫秒的任务，其超出阈值的部分分别为 30 毫秒和 15 毫秒。总阻塞时间为这些超时值之和：30 毫秒 + 15 毫秒 = 45 毫秒。](images/how-react-18-improves-application-performance-vercel/img_006.jpg)  
The TBT is 45ms, since we have two tasks that took longer than 50ms before TTI, which exceeded the 50ms threshold by 30ms and 15ms respectively. The total blocking time is the accumulation of these values: 30ms + 15ms = 45ms.

TBT 为 45 毫秒，因为在 TTI 之前存在两个耗时超过 50 毫秒的任务，其超出阈值的部分分别为 30 毫秒和 15 毫秒。总阻塞时间为这些超时值之和：30 毫秒 + 15 毫秒 = 45 毫秒。

The [Interaction to Next Paint (INP)](https://web.dev/inp/), a new Core Web Vitals metric, measures the time from a user's first interaction with the page (e.g. clicking a button) to when this interaction is visible on-screen; the next paint. This metric is particularly important for pages with many user interactions, like e-commerce sites or social media platforms. It’s measured by accumulating all the INP measurements throughout the user’s current visit and returning the worst score.

[交互到下次绘制时间（INP）](https://web.dev/inp/) 是一项全新的核心网页指标（Core Web Vitals），用于衡量用户首次与页面交互（例如点击按钮）到该交互结果在屏幕上可见（即下次绘制）之间的时间。该指标对高频交互类页面（如电商平台或社交媒体平台）尤为重要。其测量方式是：汇总用户当前访问期间所有 INP 测量值，并返回其中最差（即最大）的得分。

![The Interaction to Next Paint is 250ms, as it's the highest measured visual delay.](images/how-react-18-improves-application-performance-vercel/img_007.jpg)![The Interaction to Next Paint is 250ms, as it's the highest measured visual delay.](images/how-react-18-improves-application-performance-vercel/img_008.jpg)  
![交互到下次绘制时间为 250 毫秒，因其为所测得的最大视觉延迟。](images/how-react-18-improves-application-performance-vercel/img_007.jpg)  
![交互到下次绘制时间为 250 毫秒，因其为所测得的最大视觉延迟。](images/how-react-18-improves-application-performance-vercel/img_008.jpg)  
The Interaction to Next Paint is 250ms, as it's the highest measured visual delay.

交互到下次绘制时间为 250 毫秒，因其为所测得的最大视觉延迟。

To understand how the new React updates optimize for these measurements and thus improve the user experience, it's important to understand how traditional React works first.

要理解新版 React 更新如何针对上述指标进行优化，从而提升用户体验，首先需了解传统 React 的工作机制。

## Traditional React Rendering

## 传统 React 渲染机制

A visual update in React is divided into two phases: the **render phase** and the **commit phase**.

React 中的视觉更新分为两个阶段：**渲染阶段（render phase）** 和 **提交阶段（commit phase）**。

The render phase in React is a pure computation phase where React elements are reconciled with (i.e. compared to) the existing DOM. This phase involves creating a new tree of React elements, also known as the "virtual DOM", which is essentially a lightweight in-memory representation of the actual DOM.

React 的渲染阶段（render phase）是一个纯计算阶段，在此阶段中，React 元素会与现有 DOM 进行协调（即比对）。该阶段包含构建一棵新的 React 元素树，也称为“虚拟 DOM”（virtual DOM），它本质上是真实 DOM 的轻量级内存表示。

During the render phase, React calculates the differences between the current DOM and the new React component tree and prepares the necessary updates.

在渲染阶段，React 会计算当前 DOM 与新的 React 组件树之间的差异，并准备好所需的更新操作。

![](images/how-react-18-improves-application-performance-vercel/img_009.jpg)![](images/how-react-18-improves-application-performance-vercel/img_010.jpg)

![](images/how-react-18-improves-application-performance-vercel/img_009.jpg)![](images/how-react-18-improves-application-performance-vercel/img_010.jpg)

Following the render phase is the commit phase. In this phase, React applies the updates calculated during the render phase to the actual DOM. This involves creating, updating, and deleting DOM nodes to mirror the new React component tree.

渲染阶段之后是提交阶段（commit phase）。在此阶段中，React 将渲染阶段所计算出的更新应用到真实 DOM 上。这包括创建、更新和删除 DOM 节点，以使真实 DOM 与新的 React 组件树保持一致。

In a traditional synchronous render, React would give the same priority to all elements within a component tree. When a component tree is rendered, either on the initial render or on a state update, React would go ahead and render the tree in a single uninterruptible task, after which it gets committed to the DOM to visually update the on-screen components.

在传统的同步渲染（synchronous render）中，React 会对组件树内的所有元素赋予相同的优先级。无论是在首次渲染还是状态更新时渲染组件树，React 都会将其作为一个不可中断的单一任务执行完毕，随后将结果提交至 DOM，从而在屏幕上实现可视化的组件更新。

![](images/how-react-18-improves-application-performance-vercel/img_011.jpg)![](images/how-react-18-improves-application-performance-vercel/img_012.jpg)

![](images/how-react-18-improves-application-performance-vercel/img_011.jpg)![](images/how-react-18-improves-application-performance-vercel/img_012.jpg)

A synchronous render is an “all-or-nothing” operation, where it’s guaranteed that a component that starts rendering will always finish. Depending on the complexity of the components, the render phase could take a while to complete. The main thread is blocked during this time, meaning that users trying to interact with the application experience an unresponsive UI until React has completed the render and committed the result to the DOM.

同步渲染是一种“全有或全无”（all-or-nothing）的操作：一旦某个组件开始渲染，就必定会完成。但根据组件的复杂程度，渲染阶段可能耗时较长；在此期间，主线程被阻塞，导致用户在与应用交互时遭遇界面无响应（unresponsive UI），直至 React 完成渲染并将结果提交至 DOM。

You can see this happen in the following demo. We have a text input field and a large list of cities that get filtered based on the current value of the text input. In a synchronous render, React will go ahead and re-render the **`CitiesList`** component on each keystroke. This is quite an expensive computation since the list consists of tens of thousands of cities, so there’s a clear visual feedback delay here between the keystroke and seeing this reflected in the text input.

您可在以下演示中观察到这一现象：我们有一个文本输入框，以及一个庞大的城市列表，该列表会根据输入框当前值进行实时过滤。在同步渲染模式下，React 会在每次按键后立即重新渲染 **`CitiesList`** 组件。由于该列表包含数万个城市，这一操作开销极大，因此在按键与输入框中内容更新之间存在明显的视觉反馈延迟。

App.jsCityList.jsindex.jsstyles.css

App.jsCityList.jsindex.jsstyles.css

To enter the code editing mode, press Enter. To exit the edit mode, press Escape

如需进入代码编辑模式，请按 Enter 键；如需退出编辑模式，请按 Escape 键。

You are editing the code. To exit the edit mode, press Escape

您正在编辑代码。要退出编辑模式，请按 Esc 键。

99

99

1

1

2

2

3

3

4

4

5

5

6

6

7

7

8

8

9

9

10

10

11

11

12

12

13

13

14

14

```javascript
import React, { useState } from "react";

import CityList from "./CityList";

export default function SearchCities() {
  const [text, setText] = useState("Am");
```

```jsx
return(
<main>
<h1>Traditional Rendering</h1>
<input type="text" onChange={(e) => setText(e.target.value)}/>
<CityList searchQuery={text}/>
</main>
);
```

```jsx
返回(
<main>
<h1>传统渲染</h1>
<input type="text" onChange={(e) => setText(e.target.value)}/>
<CityList searchQuery={text}/>
</main>
);
```

Refresh preview  
刷新预览  

Open on CodeSandbox  
在 CodeSandbox 中打开  

[Open on CodeSandbox](https://codesandbox.io/api/v1/sandboxes/define?undefined "Open in CodeSandbox")  
[在 CodeSandbox 中打开](https://codesandbox.io/api/v1/sandboxes/define?undefined "在 CodeSandbox 中打开")

If you’re on a high-end device like a Macbook, you might want to throttle your CPU 4x to simulate a lower-end device. You can see this setting in Devtools > Performance > ⚙️ > CPU.

如果你使用的是 MacBook 等高端设备，你可能希望将 CPU 限制为 4 倍节流（即性能降至 25%），以模拟低端设备。你可以在开发者工具（DevTools）> “性能”（Performance）> ⚙️（设置）> “CPU” 中找到该选项。

When we look at the performance tab, you can see that long tasks occur on every keystroke, which is suboptimal.

当我们查看“性能”（Performance）标签页时，可以看到每次按键都会触发长任务（long task），这是不理想的。

![Tasks marked with the red corner are considered “long tasks”. Note the total blocking time of 4425.40ms. ](images/how-react-18-improves-application-performance-vercel/img_013.jpg)![Tasks marked with the red corner are considered “long tasks”. Note the total blocking time of 4425.40ms. ](images/how-react-18-improves-application-performance-vercel/img_014.jpg)

![带红色角标的任务被视为“长任务”。注意总阻塞时间为 4425.40 毫秒。](images/how-react-18-improves-application-performance-vercel/img_013.jpg)![带红色角标的任务被视为“长任务”。注意总阻塞时间为 4425.40 毫秒。](images/how-react-18-improves-application-performance-vercel/img_014.jpg)

Tasks marked with the red corner are considered “long tasks”. Note the total blocking time of 4425.40ms.

带红色角标的任务被视为“长任务”。注意总阻塞时间为 4425.40 毫秒。

In such scenarios, React developers would often use third-party libraries like [`debounce`](https://www.npmjs.com/package/debounce) to defer the rendering, but there was no built-in solution.

在此类场景下，React 开发者通常会借助第三方库（例如 [`debounce`](https://www.npmjs.com/package/debounce)）来延迟渲染，但此前 React 并未提供内置解决方案。

React 18 introduces a new concurrent renderer that operates behind the scenes. This renderer exposes some ways for us to mark certain renders as non-urgent.

React 18 引入了一种全新的并发渲染器（concurrent renderer），在后台静默运行。该渲染器为我们提供了若干机制，用以将某些渲染标记为“非紧急”。

![When rendering the low-priority components (pink), React yields back to the main thread to check for more important tasks](images/how-react-18-improves-application-performance-vercel/img_015.jpg)![When rendering the low-priority components (pink), React yields back to the main thread to check for more important tasks](images/how-react-18-improves-application-performance-vercel/img_016.jpg)  
![渲染低优先级组件（粉色）时，React 会主动让出主线程，以检查是否存在更高优先级的任务](images/how-react-18-improves-application-performance-vercel/img_015.jpg)![渲染低优先级组件（粉色）时，React 会主动让出主线程，以检查是否存在更高优先级的任务](images/how-react-18-improves-application-performance-vercel/img_016.jpg)

When rendering the low-priority components (pink), React yields back to the main thread to check for more important tasks.

渲染低优先级组件（粉色）时，React 会主动让出主线程，以检查是否存在更高优先级的任务。

In that case, React will yield back to the main thread every 5 milliseconds to see if there are more important tasks to handle instead, such as user input or even rendering another React component state updates that are more important to the user experience at that moment. By continuously yielding back to the main thread, React is able to make such renders non-blocking and prioritize more important tasks.

此时，React 每隔 5 毫秒便会主动让出主线程一次，以判断是否存在更需优先处理的任务——例如用户输入，或另一组 React 组件的状态更新（这些更新对当前时刻的用户体验更为关键）。通过持续让出主线程，React 能够使此类渲染变为非阻塞式，并确保更高优先级的任务获得及时响应。

![Instead of a single non-interruptible task for every render, the concurrent renderer yields control back to the main thread at intervals of 5ms during the (re)rendering of low-priority components. ](images/how-react-18-improves-application-performance-vercel/img_017.jpg)![Instead of a single non-interruptible task for every render, the concurrent renderer yields control back to the main thread at intervals of 5ms during the (re)rendering of low-priority components. ](images/how-react-18-improves-application-performance-vercel/img_018.jpg)  
![并发渲染器不再将每次渲染作为一个不可中断的单一任务，而是在低优先级组件的（重）渲染过程中，以 5 毫秒为间隔，周期性地将控制权交还给主线程。](images/how-react-18-improves-application-performance-vercel/img_017.jpg)![并发渲染器不再将每次渲染作为一个不可中断的单一任务，而是在低优先级组件的（重）渲染过程中，以 5 毫秒为间隔，周期性地将控制权交还给主线程。](images/how-react-18-improves-application-performance-vercel/img_018.jpg)

Instead of a single non-interruptible task for every render, the concurrent renderer yields control back to the main thread at intervals of 5ms during the (re)rendering of low-priority components.

并发渲染器不再将每次渲染作为一个不可中断的单一任务，而是在低优先级组件的（重）渲染过程中，以 5 毫秒为间隔，周期性地将控制权交还给主线程。

Additionally, the concurrent renderer is able to “concurrently” render multiple versions of the component tree in the background without immediately committing the result.

此外，并发渲染器还能够在后台“并发地”渲染组件树的多个版本，且无需立即提交最终结果。

Whereas a synchronous render is an all-or-nothing computation, the concurrent renderer allows React to pause and resume the rendering of one or multiple component trees to achieve the most optimal user experience.

同步渲染是一种“全有或全无”的计算过程，而并发渲染器（concurrent renderer）则允许 React 暂停并恢复一个或多个组件树的渲染，从而实现最优的用户体验。

![React pauses the current render based on a user interaction that forces it to prioritize rendering another update](images/how-react-18-improves-application-performance-vercel/img_019.jpg)![React pauses the current render based on a user interaction that forces it to prioritize rendering another update](images/how-react-18-improves-application-performance-vercel/img_020.jpg)React pauses the current render based on a user interaction that forces it to prioritize rendering another update

![React 暂停当前渲染，原因是用户交互迫使它优先渲染另一项更新](images/how-react-18-improves-application-performance-vercel/img_019.jpg)![React 暂停当前渲染，原因是用户交互迫使它优先渲染另一项更新](images/how-react-18-improves-application-performance-vercel/img_020.jpg)React 暂停当前渲染，原因是用户交互迫使它优先渲染另一项更新。

Using concurrent features, React can pause and resume the rendering of components based on external events such as user interaction. When the user started interacting with `ComponentTwo`, React paused the current rendering, prioritized and render **`ComponentTwo`**, after which it resumed rendering `ComponentOne`. We'll talk about this more in the section on **Suspense.**

借助并发特性，React 可根据用户交互等外部事件暂停和恢复组件的渲染。当用户开始与 `ComponentTwo` 交互时，React 暂停了当前渲染，优先完成 **`ComponentTwo`** 的渲染；随后再恢复 `ComponentOne` 的渲染。我们将在 **Suspense** 小节中进一步讨论这一机制。

## Transitions

## 过渡（Transitions）

We can mark an update as non-urgent by using the **`startTransition`** function made available by the `useTransition` hook. This is a powerful new feature that allows us to mark certain state updates as “transitions”, indicating that they can lead to visual changes that could potentially disrupt user experience if they were rendered synchronously.

我们可以通过 `useTransition` Hook 提供的 **`startTransition`** 函数，将某次状态更新标记为“非紧急”。这是一个强大的新特性，使我们能够将某些状态更新定义为“过渡（transitions）”，即：这些更新可能引发视觉变化，但如果以同步方式渲染，就有可能干扰用户的操作体验。

By wrapping a state update in **`startTransition`**, we can tell React that we’re okay with deferring or interrupting the rendering to prioritize more important tasks to keep the current user interface interactive.

通过将状态更新包裹在 **`startTransition`** 中，我们向 React 表明：可以接受延迟或中断该渲染任务，以便优先处理更重要的任务，从而确保当前用户界面持续保持可交互性。

```jsx
import { useTransition } from "react";



function Button() {

4  const [isPending, startTransition] = useTransition();
```

6  return (

6  返回（

7    <button

7    <button

8      onClick={() => {

8      onClick={() => {

9        urgentUpdate();

9        urgentUpdate();

10        startTransition(() => {

10        startTransition(() => {

11          nonUrgentUpdate()

11          nonUrgentUpdate()

12        })

12        })

13      }}

13      }}

14    >...</button>

14    >...</button>

15  )

15  )

16}
```

16}
```

When a transition starts, the concurrent renderer prepares the new tree in the background. Once it’s finished rendering, it’ll keep the result in memory until the React scheduler can performantly update the DOM to reflect the new state. This moment could be when the browser is idle and a higher priority task (like user interaction) isn't pending.

当过渡（transition）启动时，并发渲染器会在后台准备新的组件树。一旦完成渲染，它会将结果保留在内存中，直到 React 调度器能够高效地更新 DOM 以反映新状态。这一时机通常出现在浏览器空闲、且没有更高优先级任务（例如用户交互）待处理的时候。

![](images/how-react-18-improves-application-performance-vercel/img_021.jpg)![](images/how-react-18-improves-application-performance-vercel/img_022.jpg)

![](images/how-react-18-improves-application-performance-vercel/img_021.jpg)![](images/how-react-18-improves-application-performance-vercel/img_022.jpg)

Using a transition would be perfect for the **`CitiesList`** demo. Instead of directly updating the value passed to the `searchQuery` param on each keystroke – which, in turn, leads to a synchronous render call on each keystroke – we can split the state into two values and wrap the `searchQuery`'s state update in a `startTransition`.

对 **`CitiesList`** 示例而言，使用 `transition` 是非常理想的方案。与其在每次按键时直接更新传入 `searchQuery` 参数的值（这会导致每次按键都触发一次同步渲染），不如将状态拆分为两个部分，并将 `searchQuery` 的状态更新包裹在 `startTransition` 中。

This tells React that the state update might lead to visual changes that could be disruptive to the user, and therefore React should attempt to keep the current UI interactive while preparing the new state in the background without committing the updates immediately.

这告诉 React：该状态更新可能引发影响用户体验的视觉变化，因此 React 应尽力保持当前 UI 的可交互性，同时在后台准备新状态，而不立即提交这些更新。

index.jsApp.jsCityList.jsstyles.css

index.jsApp.jsCityList.jsstyles.css

To enter the code editing mode, press Enter. To exit the edit mode, press Escape

要进入代码编辑模式，请按 Enter 键；要退出编辑模式，请按 Escape 键。

You are editing the code. To exit the edit mode, press Escape

您正在编辑代码。要退出编辑模式，请按 Escape 键。

99

99

1

1

2

2

3

3

4

4

5

5

6

6

7

7

8

8

9

9

10

10

11

11

12

12

13

13

14

14

15

15

16

16

17

17

18

18

19

19

20

20

21

21

22

22

23

23

24

24

```javascript
import React, { useState, useTransition } from "react";

import CityList from "./CityList";

export default function SearchCities() {
  const [text, setText] = useState("Am");
  const [searchQuery, setSearchQuery] = useState(text);
  const [isPending, startTransition] = useTransition();
```

```javascript
import React, { useState, useTransition } from "react";

import CityList from "./CityList";

export default function SearchCities() {
  const [text, setText] = useState("Am");
  const [searchQuery, setSearchQuery] = useState(text);
  const [isPending, startTransition] = useTransition();
```

return(

return(

<main>

<main>

<h1><code>startTransition</code></h1>

<h1><code>startTransition</code></h1>

<input

<input

type="text"

type="text"

value={text}

value={text}

onChange={(e)=>{

onChange={(e) => {

setText(e.target.value)

setText(e.target.value)

startTransition(()=>{

startTransition(() => {

setSearchQuery(e.target.value)

setSearchQuery(e.target.value)

})

}}/>

<CityList searchQuery={searchQuery}/>

</main>

);

};

刷新预览在 CodeSandbox 中打开

[在 CodeSandbox 中打开](https://codesandbox.io/api/v1/sandboxes/define?undefined "在 CodeSandbox 中打开")

现在，当我们向输入框中键入内容时，用户输入依然流畅，按键之间不会出现任何视觉延迟。这是因为 `text` 状态仍然以同步方式更新，而输入框正是使用该状态作为其 `value` 属性的值。

在后台，React 会在每次按键时开始渲染新的组件树。但这一过程不再是“全有或全无”的同步任务；相反，React 会在内存中逐步准备组件树的新版本，与此同时，当前 UI（显示着“旧”状态）仍能响应用户的后续输入，保持完全的交互响应性。

Looking at the performance tab, wrapping the state update in a **`startTransition`** significantly decreased the number of long tasks and the total blocking time compared to the performance graph for the implementation without the use of transitions.

查看性能标签页，将状态更新包裹在 **`startTransition`** 中后，与未使用过渡（transitions）的实现相比，长任务数量和总阻塞时间均显著减少。

![The performance tab shows that the number of long tasks and the total blocking time have reduced significantly.](images/how-react-18-improves-application-performance-vercel/img_023.jpg)  
![性能标签页显示，长任务数量和总阻塞时间均已显著减少。](images/how-react-18-improves-application-performance-vercel/img_023.jpg)  

The performance tab shows that the number of long tasks and the total blocking time have reduced significantly.

性能标签页显示，长任务数量和总阻塞时间均已显著减少。

Transitions are part of a fundamental shift in React's rendering model, enabling React to render multiple versions of the UI concurrently, and manage priorities between different tasks. This allows for a smoother and more responsive user experience, especially when dealing with high-frequency updates or CPU-intensive rendering tasks.

过渡（Transitions）是 React 渲染模型一次根本性变革的重要组成部分，它使 React 能够并发渲染多个 UI 版本，并在不同任务之间动态管理优先级。这带来了更流畅、更灵敏的用户体验，尤其适用于高频更新或 CPU 密集型渲染任务场景。

## React Server Components

## React 服务端组件

React Server Components are an **experimental feature** in React 18, but [ready for frameworks to adopt](https://react.dev/blog/2023/05/03/react-canaries). This is important to know before we delve into Next.js.

React Server Components 是 React 18 中的一项**实验性功能**，但已[具备被框架采用的条件](https://react.dev/blog/2023/05/03/react-canaries)。在深入探讨 Next.js 之前，了解这一点至关重要。

Traditionally, React offered a few primary ways to render our app. We could either render everything entirely on the client (Client-Side Rendering), or we could render the component tree to HTML on the server and send this static HTML to the client with a JavaScript bundle to hydrate the components client-side (Server-Side Rendering).

传统上，React 提供了若干主要的应用渲染方式：一种是完全在客户端进行渲染（客户端渲染，Client-Side Rendering），另一种则是在服务端将组件树渲染为 HTML，再将该静态 HTML 连同用于客户端水合（hydration）的 JavaScript 包一并发送至客户端（服务端渲染，Server-Side Rendering）。

![](images/how-react-18-improves-application-performance-vercel/img_024.jpg)![](images/how-react-18-improves-application-performance-vercel/img_025.jpg)  
![](images/how-react-18-improves-application-performance-vercel/img_024.jpg)![](images/how-react-18-improves-application-performance-vercel/img_025.jpg)  

Both approaches rely on the fact that the synchronous React renderer needs to rebuild the component tree client-side which the use of the shipped JavaScript bundle, even though this component tree was already available on the server.

这两种方式都依赖于一个事实：同步的 React 渲染器必须借助所下发的 JavaScript 包，在客户端重新构建组件树——即便该组件树早已在服务端生成完毕。

React Server Components allow React to send the actual serialized component tree to the client. The client-side React renderer understands this format and uses it to performantly reconstruct the React component tree without having to send the HTML file or JavaScript bundle.

React Server Components 使得 React 可以直接将序列化后的实际组件树发送至客户端。客户端的 React 渲染器能够理解该格式，并据此高效地重建 React 组件树，而无需传输 HTML 文件或 JavaScript 包。

![](images/how-react-18-improves-application-performance-vercel/img_026.jpg)![](images/how-react-18-improves-application-performance-vercel/img_027.jpg)  
![](images/how-react-18-improves-application-performance-vercel/img_026.jpg)![](images/how-react-18-improves-application-performance-vercel/img_027.jpg)

We can use this new rendering pattern by combining `react-server-dom-webpack/server`'s `renderToPipeableStream` method with **`react-dom/client`**'s `createRoot` method.

我们可以利用这种新的渲染模式，将 `react-server-dom-webpack/server` 的 `renderToPipeableStream` 方法与 **`react-dom/client`** 的 `createRoot` 方法结合使用。

```javascript
1// server/index.js

import App from '../src/App.js'

app.get('/rsc', async function(req, res) {

4  const {pipe} = renderToPipeableStream(React.createElement(App));

5  return pipe(res);

6});



8---

9// src/index.js
```

```javascript
import { createRoot } from 'react-dom/client';

import { createFromFetch } from 'react-server-dom-webpack/client';

export function Index() {

13  ...

14  return createFromFetch(fetch('/rsc'));

15}

const root = createRoot(document.getElementById('root'));

root.render(<Index />);
```

```javascript
import { createRoot } from 'react-dom/client';

import { createFromFetch } from 'react-server-dom-webpack/client';

export function Index() {

13  ...

14  return createFromFetch(fetch('/rsc'));

15}

const root = createRoot(document.getElementById('root'));

root.render(<Index />);
```

⚠️ This is an over-simplified (!) example of the CodeSandbox demo shown below.

⚠️ 这是下方所示 CodeSandbox 演示的一个过度简化的（！）示例。

[Click here to see the full CodeSandbox demo](https://codesandbox.io/p/sandbox/cocky-minsky-m7sgfx). In the next section, we'll cover a more elaborate example.

[点击此处查看完整的 CodeSandbox 演示](https://codesandbox.io/p/sandbox/cocky-minsky-m7sgfx)。在下一节中，我们将介绍一个更详尽的示例。

By default, React won't hydrate React Server Components. The components aren't expected to use any client-side interactivity like accessing the **`window`** object or use hooks like **`useState`** or `useEffect`.

默认情况下，React 不会对 React 服务端组件（React Server Components）执行水合（hydration）。这些组件不应依赖任何客户端交互能力，例如访问 **`window`** 对象，或使用 **`useState`**、`useEffect` 等 Hook。

To add a component and its imports to a JavaScript bundle that gets shipped to the client, thus making it interactive, you can use the ["use client" bundler directive](https://react.dev/reference/react/use-client) on the top of the file. This tells the bundler to add **this component and its imports** to the client bundle and tells React to hydrate the tree client-side to add interactivity. Such components are referred to as Client Components.

若要将某个组件及其所依赖的导入模块加入发送至客户端的 JavaScript 包（bundle），从而使其具备交互能力，你可以在文件顶部添加 [`"use client"` 打包器指令](https://react.dev/reference/react/use-client)。该指令会告知打包器：将**此组件及其所有导入模块**一并纳入客户端包；同时也会通知 React 在客户端对对应组件树执行水合操作，以启用交互功能。这类组件被称为“客户端组件”（Client Components）。

![Note: Framework implementations may differ. For example, Next.js will prerender Client Components to HTML on the server, similar to the traditional SSR approach. By default, however, Client Components are rendered similar to the CSR approach.](images/how-react-18-improves-application-performance-vercel/img_028.jpg)![Note: Framework implementations may differ. For example, Next.js will prerender Client Components to HTML on the server, similar to the traditional SSR approach. By default, however, Client Components are rendered similar to the CSR approach.](images/how-react-18-improves-application-performance-vercel/img_029.jpg)Note: Framework implementations may differ. For example, Next.js will prerender Client Components to HTML on the server, similar to the traditional SSR approach. By default, however, Client Components are rendered similar to the CSR approach.

![注意：不同框架的具体实现可能有所差异。例如，Next.js 会在服务端预先渲染客户端组件为 HTML，方式类似于传统的服务端渲染（SSR）。但默认情况下，客户端组件的渲染方式更接近客户端渲染（CSR）。](images/how-react-18-improves-application-performance-vercel/img_028.jpg)![注意：不同框架的具体实现可能有所差异。例如，Next.js 会在服务端预先渲染客户端组件为 HTML，方式类似于传统的服务端渲染（SSR）。但默认情况下，客户端组件的渲染方式更接近客户端渲染（CSR）。](images/how-react-18-improves-application-performance-vercel/img_029.jpg)注意：不同框架的具体实现可能有所差异。例如，Next.js 会在服务端预先渲染客户端组件为 HTML，方式类似于传统的服务端渲染（SSR）。但默认情况下，客户端组件的渲染方式更接近客户端渲染（CSR）。

It's up to the developer to optimize bundle size when working with Client Components. Developers can do this by:

- Ensuring that only the leaf-most node of the interactive component defines the **`"use client"`** directive. This may require some component decoupling.

- Passing component trees as props rather than importing them directly. This allows React to render the **`children`** as React Server Components without adding them to the client bundle.

如何优化客户端组件的包体积，取决于开发者自身。开发者可通过以下方式实现优化：

- 确保仅在交互式组件树中**最深层（叶子节点）的组件**中声明 **`"use client"`** 指令。这可能需要对组件进行一定程度的解耦。

- 将组件树作为 `props` 传入，而非直接 `import`。这样 React 就能将 `children` 以 React 服务端组件的方式渲染，而无需将其纳入客户端包中。

## Suspense

## Suspense（悬念）

Another important new concurrent feature is [**`Suspense`**](https://react.dev/reference/react/Suspense). Although it’s not entirely new as `Suspense` was released in React 16 for code-splitting with **`React.lazy`**, the new capabilities introduced with React 18 extend `Suspense` to data fetching.

另一项重要的新并发特性是 [**`Suspense`**](https://react.dev/reference/react/Suspense)。尽管它并非完全全新——`Suspense` 早在 React 16 中就已随 **`React.lazy`** 引入，用于代码分割（code-splitting）——但 React 18 新增的能力则进一步将 `Suspense` 的适用范围扩展到了数据获取（data fetching）领域。

Using **`Suspense`**, we can delay the rendering of a component until certain conditions are met, such as data being loaded from a remote source. In the meantime, we can render a fallback component that indicates that this component is still loading.

借助 **`Suspense`**，我们可以延迟组件的渲染，直至满足特定条件（例如：从远程源加载完所需数据）。在此期间，可渲染一个备用（fallback）组件，以提示用户该组件仍在加载中。

By declaratively defining loading states, we reduce the need for any conditional rendering logic. Using `Suspense` in combination with React Server Components allows us to directly access server-side data sources without requiring a separate API endpoint, such as databases or the file system.

通过声明式地定义加载状态，我们可大幅减少对条件渲染逻辑的依赖。将 `Suspense` 与 React 服务端组件结合使用，还能让我们**直接访问服务端数据源**（如数据库或文件系统），而无需额外构建独立的 API 接口。

```jsx
async function BlogPosts() {

async function BlogPosts() {

2  const posts = await db.posts.findAll();

2  const posts = await db.posts.findAll();

3  return '...';

3  return '...';

4}

4}

export default function Page() {

export default function Page() {

7  return (

7  return (

8    <Suspense fallback={<Skeleton />}>

8    <Suspense fallback={<Skeleton />}>

9      <BlogPosts />

9      <BlogPosts />

10    </Suspense>

10    </Suspense>
```

11  )

11  )

12}
```

12}
```

Using React Server Components works seamlessly with Suspense, which allows us to define a loading state while the component is still loading.

React Server Components 与 `Suspense` 协同工作无缝流畅，使我们能够在组件仍在加载时定义其加载状态。

The true power of **`Suspense`** comes from its deep integration with React's Concurrent features. When a component is suspended, for example because it’s still waiting for data to load, React doesn't just sit idle until the component has received the data. Instead, it pauses the rendering of the suspended component and shifts its focus to other tasks.

**`Suspense`** 的真正强大之处在于它与 React 并发（Concurrent）特性的深度集成。当某个组件被挂起（suspended）——例如，因为它仍在等待数据加载完成——React 并不会干等数据到达，而是暂停该挂起组件的渲染，并将渲染资源转向其他任务。

![](images/how-react-18-improves-application-performance-vercel/img_030.jpg)![](images/how-react-18-improves-application-performance-vercel/img_031.jpg)

![](images/how-react-18-improves-application-performance-vercel/img_030.jpg)![](images/how-react-18-improves-application-performance-vercel/img_031.jpg)

During this time, we can tell React to render a fallback UI to indicate that this component is still loading. Once the awaited data becomes available, React can seamlessly resume the rendering of the previously suspended component in an interruptible way, like we previously saw happening with transitions.

在此期间，我们可以指示 React 渲染一个备用 UI（fallback UI），以表明该组件仍在加载中。一旦所等待的数据就绪，React 即可以一种可中断的方式无缝恢复此前挂起组件的渲染——正如我们之前在过渡（transitions）中所见。

React can also reprioritize components based on user interaction. For example, when a user interacts with a suspended component that's not currently being rendered, React suspends the ongoing render and prioritizes the component that the user is interacting with.

React 还可根据用户交互动态调整组件的渲染优先级。例如，当用户与一个尚未完成渲染的挂起组件发生交互时，React 将暂停当前正在进行的渲染，并优先处理用户正在交互的那个组件。

![](images/how-react-18-improves-application-performance-vercel/img_032.jpg)![](images/how-react-18-improves-application-performance-vercel/img_033.jpg)

![](images/how-react-18-improves-application-performance-vercel/img_032.jpg)![](images/how-react-18-improves-application-performance-vercel/img_033.jpg)

Once it's ready, React commits it to the DOM, and resumes the previous render. This ensures that user interactions are prioritized and the UI remains responsive and up-to-date with user inputs.

一旦该高优先级组件准备就绪，React 就将其提交（commit）至 DOM，并继续此前被中断的渲染流程。这确保了用户交互始终被优先响应，UI 保持高度响应性，并实时反映用户的输入操作。

The combination of `Suspense` with React Server Component’s streamable format allows high-priority updates to be sent to the client as soon as they're ready, without waiting for lower-priority rendering tasks to complete. This enables the client to start processing data sooner and provides a more fluid user experience by gradually revealing content as it arrives in a non-blocking manner.

`Suspense` 与 React Server Components 的流式（streamable）格式相结合，使得高优先级的更新可在就绪后立即发送至客户端，而无需等待低优先级的渲染任务完成。这使客户端能更早开始处理数据，并通过非阻塞方式、渐进式地呈现内容，从而提供更流畅的用户体验。

This interruptible rendering mechanism combined with **`Suspense`**'s ability to handle asynchronous operations provides a much smoother and more user-centric experience, particularly in complex applications with significant data-fetching needs.

这种可中断渲染机制，结合 **`Suspense`** 处理异步操作的能力，显著提升了用户体验的流畅性与以用户为中心的程度，尤其适用于那些数据获取需求繁重的复杂应用。

## Data Fetching

## 数据获取

Besides rendering updates, React 18 also introduces a new API to fetch data and memoize the result efficiently.

除了渲染更新之外，React 18 还引入了一个全新的 API，用于高效地获取数据并缓存其结果。

React 18 now has a [cache function](https://nextjs.org/docs/app/building-your-application/data-fetching/caching#react-cache) that remembers the result of the wrapped function call. If you call the same function with the same arguments _within the same render pass_, it will use the memoized value without the need to execute the function again.

React 18 现在提供了一个 [cache 函数](https://nextjs.org/docs/app/building-your-application/data-fetching/caching#react-cache)，用于记住被包装函数调用的结果。若在**同一渲染周期内**以相同的参数再次调用该函数，它将直接返回已缓存的值，而无需重复执行函数。

```javascript
import { cache } from 'react'



export const getUser = cache(async (id) => {

4  const user = await db.user.findUnique({ id })

5  return user;

6})
```

`getUser(1)`

`getUser(1)` // 在同一渲染周期内调用：返回已缓存的结果。

```

在 `fetch` 调用中，React 18 默认启用了类似的缓存机制，无需显式使用 `cache`。这有助于减少单次渲染周期内的网络请求数量，从而提升应用性能并降低 API 调用成本。

```javascript
export const fetchPost = (id) => {

2  const res = await fetch(`https://.../posts/${id}`);

3  const data = await res.json();

4  return { post: data.post }

5}
```

fetchPost(1)

fetchPost(1) // Called within same render pass: returns memoized result.  
fetchPost(1) // 在同一渲染周期内调用：返回已记忆化的结果。

These features are helpful when working with React Server components, as they cannot access the Context API. The automatic caching behavior of both `cache` and `fetch` allows exporting a single function from a global module and reusing it throughout the application.  

这些特性在使用 React 服务端组件（Server Components）时非常有用，因为服务端组件无法访问 Context API。`cache` 和 `fetch` 的自动缓存机制，使得我们可以从一个全局模块中导出单个函数，并在整个应用中重复使用它。

![](images/how-react-18-improves-application-performance-vercel/img_034.jpg)![](images/how-react-18-improves-application-performance-vercel/img_035.jpg)

```jsx
async function fetchBlogPost(id) {

2  const res = await fetch(`/api/posts/${id}`);

3  return res.json();

4}



async function BlogPostLayout() {

7  const post = await fetchBlogPost('123');

7  const post = await fetchBlogPost('123');

8  return '...'

8  return '...'

9}

9}

async function BlogPostContent() {

async function BlogPostContent() {

11  const post = await fetchBlogPost('123'); // Returns memoized value

11  const post = await fetchBlogPost('123'); // 返回已缓存的值

12  return '...'

12  return '...'

13}

13}

export default function Page() {

export default function Page() {

16  return (  

16  return (

17    <BlogPostLayout>

17    <BlogPostLayout>

18      <BlogPostContent />

18      <BlogPostContent />

19    </BlogPostLayout>

19    </BlogPostLayout>

20  )

20  )

21}
```

21}
```

## Conclusion

## 结论

In summary, React 18's latest features improve performance in many ways.

总而言之，React 18 的最新特性从多个方面提升了应用性能。

- With **Concurrent React**, the rendering process can be paused and resumed later or even abandoned. This means the UI can respond immediately to user input even if a large rendering task is in progress.

- 借助 **Concurrent React**，渲染过程可以被暂停、稍后恢复，甚至被完全放弃。这意味着即使正在进行大规模渲染任务，用户界面仍能立即响应用户输入。

- The **Transitions API** allows for smoother transitions during data fetches or screen changes without blocking user input.

- **Transitions API** 可在数据获取或页面切换过程中实现更流畅的过渡效果，同时不会阻塞用户输入。

- **React Server Components** lets developers build components that work on both the server and client, combining the interactivity of client-side apps with the performance of traditional server rendering without the cost of hydration.

- **React Server Components** 使开发者能够构建同时适用于服务端与客户端的组件，在不付出水合（hydration）开销的前提下，兼顾客户端应用的交互性与传统服务端渲染的高性能。

- The extended **`Suspense`** functionality improves loading performance by allowing parts of the application to render before others that may take longer to fetch data.

- 扩展的 **`Suspense`** 功能通过允许应用的部分内容先于其他需要更长时间获取数据的部分进行渲染，从而提升了加载性能。

Developers using [Next.js's App Router](https://nextjs.org/docs/app/building-your-application/upgrading/app-router-migration) can start taking advantage of the features now available for frameworks, like **`cache`** and Server Components, mentioned in this blog post. In an upcoming blog post, we'll cover how the Next.js App Router leverages these performance features to enhance your application even further.

正在使用 [Next.js App Router](https://nextjs.org/docs/app/building-your-application/upgrading/app-router-migration) 的开发者，现在即可开始利用本文博客中提到的、面向框架推出的各项功能，例如 **`cache`** 和服务端组件（Server Components）。在后续的一篇博客文章中，我们将详细介绍 Next.js App Router 如何借助这些性能优化特性，进一步提升您的应用表现。

Vercel.com landing page

Vercel.com 官网首页

### See it in action

### 实际效果演示

Vercel Template

Vercel 模板

Deploy this template

部署此模板

### Examples of many Next.js App Router features.

### 多项 Next.js App Router 功能示例

Next.js App Router Playground

Next.js App Router 交互式体验 playground