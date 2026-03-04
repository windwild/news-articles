---
title: "Demystifying INP: New tools and actionable insights - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/demystifying-inp-new-tools-and-actionable-insights"
date: "2024-06-12"
scraped_at: "2026-03-02T09:44:04.701693908+00:00"
language: "en-zh"
translated: true
description: "Deep dive into Interaction to Next Paint (INP) optimization: A technical guide exploring real-world strategies used to improve INP on nextjs.org. Learn how to tackle common challenges and enhance resp..."
---
{% raw %}

Jun 12, 2024

2024 年 6 月 12 日

一篇技术指南，深入探讨在 Vercel 网站上提升 INP（交互到下一次绘制）的实际策略。

2024 年 3 月，交互到下一次绘制（Interaction to Next Paint，INP）正式成为 Google 核心网页指标（Core Web Vitals）的一部分。这是一组基于真实用户现场数据（field data）衡量网页用户体验的指标，且[已被纳入 Google 搜索排名机制](https://vercel.com/blog/how-core-web-vitals-affect-seo)。

Next.js 等现代前端框架已针对良好的基础 INP 分数进行了深度优化；但该指标的本质在于：**你在应用中实际执行的操作，才真正决定最终的 INP 表现**。许多看似合理、符合常规的用户体验（UX）模式，实际上已将浏览器的渲染能力推至 INP 指标所允许的极限边缘。

本文聚焦于如何在这些高难度场景下优化 INP。内容源自我们优化 [nextjs.org](http://nextjs.org/) 网站 INP 过程中积累的真实经验与教训。

## INP：一项令人困惑的指标

毫不夸张地说，INP 是目前所有核心网页指标中最常被误解的一个。让我们先直面一个严酷的事实：以下用 JSX 表示的网页拥有完美的 INP 得分：

```jsx
1<button onClick={() => {}}>Click me</button>
```

显然，一个空的点击事件处理器必然执行极快；但人们对 INP 的误解远比这更微妙：**即使你并未实际修改 DOM，该交互仍会被计入 INP**。“绘制”（Paint）在此处的真实含义，仅仅是浏览器“**具备了**”进行绘制的机会——至于页面内容是否真的发生变化，对 INP 指标而言完全无关紧要。

再来看第二个例子。此处我们阻塞主线程整整一秒：

```jsx
1<button

2  onClick={async () => {

3    await sleep(100);

4    blockTheMainThreadForOneSecond();

5  }}

6>

7  Click me

8</button>;
```

```jsx
1<button

2  onClick={async () => {

3    await sleep(100);

4    blockTheMainThreadForOneSecond();

5  }}

6>

7  点击我

8</button>;
```

If you click this button once, you also get perfect INP. The `sleep(100)` gives the browser time to paint, and then it doesn’t matter that you block the main thread for a second.

如果你只点击一次该按钮，你也会获得完美的 INP（Interaction to Next Paint）。`sleep(100)` 为浏览器提供了绘制（paint）所需的时间，此后即使你阻塞主线程一秒钟，也无关紧要。

Now, you might say _“Well, why would you add the_ _`sleep(100)`_ _?”_. Of course, you would not, but this is very reasonable code:

现在，你可能会说：“嗯，你为什么要添加 `sleep(100)` 呢？”——当然，你实际上不会这么做；但这段代码逻辑非常合理：

```jsx
1<button

2  onClick={async () => {

3    const data = await fetchData();

4    blockTheMainThreadForOneSecond(data);

5  }}

6>

7  Click me

8</button>;
```

……而这段代码尽管阻塞了主线程长达 1 秒，其 INP（Interaction to Next Paint）指标却依然完美。

然而，最后一个示例的 INP 将达到 1 秒，这被视为非常差的表现。

```jsx
1<html>

2  <button

3    onClick={() => {

4      blockTheMainThreadForOneSecond();

5    }}

6  >

7    Click me

8  </button>

9</html>;
```

主要要点是：为了优化 INP（Interaction to Next Paint），我们的任务是合理安排交付给浏览器的工作，使其有机会完成绘制并响应用户操作。这**并不意味着**我们必须在 INP 规定的 200 毫秒时限内完成所有我们最终希望执行的工作。

核心要点在于：为优化 INP（交互到下一次绘制），我们的工作是合理调度交付给浏览器的任务，确保其有足够机会完成渲染并响应用户操作。这**并非要求**我们将所有预期执行的任务全部压缩在 INP 所规定的 200 毫秒时限内完成。

## Anatomy of INP

## INP 的构成解析

The time from interaction to next paint can be structured like this:

从用户交互到下一次绘制所经历的时间可划分为如下阶段：

![](images/demystifying-inp-new-tools-and-actionable-insights-vercel/img_001.jpg)![](images/demystifying-inp-new-tools-and-actionable-insights-vercel/img_002.jpg)![](images/demystifying-inp-new-tools-and-actionable-insights-vercel/img_003.jpg)![](images/demystifying-inp-new-tools-and-actionable-insights-vercel/img_004.jpg)

- It starts with the user interaction  

- 起始于用户交互

- **Other code part 1:** Your event handler running might be blocked by other stuff that happens to run on the main thread.  

- **其他代码部分 1：** 您的事件处理器执行可能被主线程上同时运行的其他任务所阻塞。

- **Event handler:** Eventually your event handler gets to run.  

- **事件处理器：** 最终，您的事件处理器得以执行。

- **Other code part 2:** After that there is another chance for unrelated code to block the main thread  

- **其他代码部分 2：** 此后，仍有其他无关代码再次阻塞主线程的机会。

- **Browser render:** Finally, if you or other code changed the DOM, the browser will re-render the DOM  

- **浏览器渲染：** 最后，若您或其他代码修改了 DOM，浏览器将重新渲染 DOM。

- And then eventually paint.  

- 随后最终完成绘制（paint）。

In order to optimize INP we need to minimize the duration of all the phases above.

为优化 INP，我们需要尽可能缩短上述所有阶段的耗时。

### INP phase: Other code

### INP 阶段：其他代码

In the web programming model, all code running in a web page defaults to sharing a single thread and event loop. That means that unrelated code may interfere with handling a user event.

在网页编程模型中，网页内运行的所有代码默认共享同一线程和事件循环。这意味着无关代码可能干扰用户事件的处理。

This can be the hardest to optimize, given that it isn’t directly related to the code that you care about at that moment.

这往往是最难优化的部分，因为它与你当前关注的核心逻辑并无直接关联。

One very common cause for such delay is **third-party JavaScript.** The one thing you can do today, if you discover that third-party JS is causing bad INP on your page, is to call your vendor and ask them to fix their stuff. In fact, I recently did this with our analytics vendor [Heap](https://www.heap.io/), and to their credit, they shipped a fix.

造成此类延迟的一个非常常见原因是**第三方 JavaScript**。如果你发现第三方 JS 正导致页面 INP 表现不佳，目前你能做的唯一有效举措就是联系对应供应商，请他们修复问题。事实上，我最近就曾就此问题联系了我们的分析工具供应商 [Heap](https://www.heap.io/)，值得肯定的是，他们迅速发布了一个修复版本。

### INP phase: Event handler

### INP 阶段：事件处理器

This is your code which is reacting to the user’s interaction. It may fetch some data, immediately change the DOM, or do anything else. If it does change the DOM, then the specific way in which way it does that will impact the time the browser needs to render the new state.

这是你编写的、用于响应用户交互的代码。它可能发起数据请求、立即修改 DOM，或执行其他任意操作。若涉及 DOM 修改，则具体修改方式将直接影响浏览器渲染新状态所需的时间。

It is this combination of DOM change and render-time that will most immediately impact the INP score of the user interaction. We have a dedicated section for how to optimize it below.

正是 DOM 修改与渲染耗时的组合，将最直接地影响该次用户交互的 INP 得分。我们将在下文专设一节介绍如何对此进行优化。

### INP phase: Browser render

### INP 阶段：浏览器渲染

In this phase, the browser takes all the changes from the previous phase and turns them into actual pixels that can be painted. As we learned in the intro of the post, nothing at all might have changed, in which case this phase takes 0ms and the subsequent paint will also be very fast since there is nothing to paint.

在此阶段，浏览器将上一阶段产生的所有变更转化为实际可绘制的像素。正如本文引言中所述，有时可能根本未发生任何变更；此时该阶段耗时为 0 毫秒，后续绘制也会极快完成（因为无需绘制任何内容）。

It’s actually very common that this phase is empty. If, for example, you need to fetch data before rendering a response, then this phase would be empty. **This can lead to an ironic outcome where you get worse INP if things are faster–e.g. because you preloaded data so that you can respond immediately.**

事实上，该阶段为空的情况极为普遍。例如，若你需要先获取数据再渲染响应内容，则此阶段即为空。**这可能导致一种颇具讽刺意味的结果：当某些环节变快时（例如因预加载数据而实现即时响应），你的 INP 反而变得更差。**

## Optimizing INP

## 优化 INP（Interaction to Next Paint）

We’ve previously written about [various techniques to optimize INP](https://vercel.com/blog/improving-interaction-to-next-paint-with-react-18-and-suspense). The key to good INP is to optimize the phases above:

我们此前已撰文介绍过[多种优化 INP 的技术](https://vercel.com/blog/improving-interaction-to-next-paint-with-react-18-and-suspense)。实现良好 INP 的关键在于优化上述各阶段：

- Minimize other JS from running  
- 尽量减少其他 JavaScript 的执行  

- Shorten the event handler phase  
- 缩短事件处理程序阶段的耗时  

- Shorten the duration of the browser render  
- 缩短浏览器渲染阶段的耗时  


In this article, we’ll focus on the latter 2 phases.

本文将重点探讨后两个阶段。

### Shorten the event handler phase

### 缩短事件处理程序阶段

Event handlers are often very fast. The primary cost attributable to this phase in modern web applications is rerendering including virtual DOM diffing upon state changes. For React, classic performance optimizations like the use of memoization and immutable context and prop values are the best mechanisms to minimize the duration of this phase.

事件处理程序本身通常执行得非常快。在现代 Web 应用中，该阶段的主要开销来源于状态变更引发的重新渲染（包括虚拟 DOM 的 Diff 过程）。对于 React 而言，采用记忆化（memoization）、保持 Context 和 props 值不可变等经典性能优化手段，是缩短该阶段耗时最有效的方式。

### Shorten the duration of the browser render

### 缩短浏览器渲染阶段的耗时

This phase, by definition, lies mostly in the scope of the browser. Also, even though browser vendors are often asking web developers to _“chunk their work more,”_ browsers themselves unfortunately are still performing this rendering phase in a monolithic fashion.

按定义，该阶段主要发生在浏览器内部。此外，尽管浏览器厂商常呼吁 Web 开发者 _“更细粒度地切分任务”_，但遗憾的是，浏览器自身目前仍以整体式（monolithic）方式执行这一渲染阶段。

The general gist of optimizing this phase is that most browser layout algorithms are `O(n)` with the size of the DOM that gets invalidated. Respectively our job is to minimize the amount of DOM that gets invalidated.

优化此阶段的核心思路是：大多数浏览器布局算法的时间复杂度为 `O(n)`，其中 `n` 是发生失效（invalidation）的 DOM 节点数量。相应地，我们的任务就是尽可能减少发生失效的 DOM 范围。

One difficult case from [nextjs.org](http://nexjs.org/) was the programming language picker which is used in the documentation section:

[nextjs.org](http://nexjs.org/) 网站中一个典型的难点案例，是文档部分所使用的编程语言选择器：

![](images/demystifying-inp-new-tools-and-actionable-insights-vercel/img_005.jpg)![](images/demystifying-inp-new-tools-and-actionable-insights-vercel/img_006.jpg)

![](images/demystifying-inp-new-tools-and-actionable-insights-vercel/img_005.jpg)![](images/demystifying-inp-new-tools-and-actionable-insights-vercel/img_006.jpg)

From an INP perspective, this is essentially the worst case. Changing the programming language changes the contents of the code, which changes the height of the box, which requires a re-layout of the page. That page may be very long (common for documentation) and so the work the browser has to do is substantial.

从 INP（Interaction to Next Paint）视角来看，这本质上属于最差情形：切换编程语言会改变代码块内容，进而改变容器高度，最终触发整页重排版（re-layout）。而这类页面往往非常长（文档类页面的常见特征），因此浏览器需执行的布局计算量相当可观。

It’s fair to say that optimizing this phase falls strictly into the “very advanced web development” category.

可以说，对此阶段的优化完全属于“高阶 Web 开发”范畴。

- You may be able to reduce the size of the DOM. Inlined SVGs are often a good candidate for removal from the DOM by replacing them with SVG-images.

- 你或许可以缩减 DOM 的规模。内联 SVG（inline SVG）通常是理想的优化目标——可将其替换为 `<img>` 标签引用的 SVG 图像，从而将其移出 DOM 树。

- If you are lucky, it may be an option to use techniques for optimizing animations such as only changing `opacity` of an element, which does not change the layout tree, and may be doable entirely on the GPU.

- 若条件允许，你还可以采用动画优化技巧，例如仅修改元素的 `opacity` 属性——该操作不触发布局树变更，且通常可完全交由 GPU 加速完成。

- [CSS containment](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_containment) is the primary tool in the toolbox to minimize the work the browser has to do in this phase. It allows the browser to restrict a layout to the area that has containment.

- [CSS 容器查询与隔离（CSS containment）](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_containment) 是此阶段优化的核心工具，它能让浏览器将布局计算限制在具有 `contain` 属性的局部区域内，从而显著降低整体开销。

- For long lists, virtualizing those lists can help, by making the actual DOM size that ever needs to be rendered independent of the actual length of the list.

- 对于超长列表，采用虚拟滚动（virtualization）技术可有效缓解问题：它确保实际渲染的 DOM 节点数量与列表总长度解耦，仅维持视口所需的部分节点。

## A shippable alternative

## 一种可交付的替代方案

But what if we cannot make things fast enough? The “language picker” case above is a good example of the type of experience that will just be slower than 200ms in rendering in current-generation browsers with a sufficiently old mobile device. Sure, one could virtualize the document, but is that really better UX? Shouldn’t browsers be good at viewing content?

但如果我们的优化无法让响应足够快呢？上文提到的“语言选择器”案例，就是一个典型示例：在当前一代浏览器中，搭配一款足够老旧的移动设备时，其渲染耗时必然超过 200 毫秒。诚然，我们可以对文档进行虚拟化（virtualization），但这真的能带来更优的用户体验吗？浏览器本身不就该擅长高效呈现内容吗？

So, what can we do in this situation?

那么，在这种情况下，我们又能做些什么呢？

It’s time to remember what INP is all about: The metric wants you to acknowledge user input within 200ms. As explained above, it does not expect you to actually draw the response within 200ms. And, again, if you’d need to fetch the data you wouldn’t be able to draw immediately anyway.

现在是时候重温 INP 的核心要义了：该指标要求你在 200 毫秒内对用户输入做出**确认响应**（acknowledgement）。如前所述，它并不要求你必须在 200 毫秒内完成响应内容的**实际绘制**（drawing）。此外，如果你需要发起数据请求，那无论如何都无法立即完成绘制。

What we can do is split up the interaction response into two phases:

我们可以将交互响应拆分为两个阶段：

1. Acknowledge user interaction  
   1. 确认用户交互

2. Actually change the page  
   2. 实际更新页面

Let’s look at this code example for the `LanguagePicker`:

下面来看 `LanguagePicker` 组件的代码示例：

```jsx
import { useState } from 'react';



export function LanguagePicker({ setLanguage }) {

4  const [selected, setSelected] = useState();

4  const [selected, setSelected] = useState();

5  return (

5  return (

6    <select

6    <select

7      className={selected ? `value-${selected}` : ''}

7      className={selected ? `value-${selected}` : ''}

8      onChange={(e) => {

8      onChange={(e) => {

9        setSelected(e.target.value);

9        setSelected(e.target.value);

10        setLanguage(e.target.value);

10        setLanguage(e.target.value);

11      }}

11      }}

12    >

12    >

13      <option value="JS">JavaScript</option>

13      <option value="JS">JavaScript</option>

14      <option value="TS">TypeScript</option>

14      <option value="TS">TypeScript</option>

15    </select>

15    </select>

16  );

16  );

17}
```

17}
```

When the user selects a new value, it adds a class to the `select` element and sets the new language. In this example, the class is set to render an acknowledgment of the user action. Remember that setting the new language may be very expensive. So, how can we separate the acknowledgment from the expensive operation, so that the user immediately knows that their action is being processed without having to wait for the expensive work to complete?

当用户选择一个新值时，代码会向 `select` 元素添加一个类，并设置新的语言。在本例中，该类用于渲染对用户操作的确认反馈。请注意：设置新语言的操作可能开销极大。那么，我们该如何将“确认反馈”与“高开销操作”解耦，从而让用户立即获知其操作已被接收并正在处理，而无需等待耗时操作完成？

### Introducing `await-interaction-response`

### 引入 `await-interaction-response`

We shipped [the new module `await-interaction-response`](https://github.com/vercel-labs/await-interaction-response). You can get started with it right away:

我们已发布 [全新模块 `await-interaction-response`](https://github.com/vercel-labs/await-interaction-response)，您可立即开始使用：

```bash
pnpm add await-interaction-response
```

```bash
pnpm add await-interaction-response
```

Here, we use the module to separate the two phases of our code:

此处，我们借助该模块将代码逻辑拆分为两个阶段：

```jsx
import { useState } from 'react';
```

```jsx
import { useState } from 'react';
```

```javascript
import interactionResponse from 'await-interaction-response';



export function LanguagePicker({ setLanguage }) {

5  const [selected, setSelected] = useState();

6  return (

7    <select

8      className={selected ? `value-${selected}` : ''}

9      onChange={async (e) => {

10        setSelected(e.target.value);

11        await interactionResponse();
```

12        setLanguage(e.target.value);

12        设置语言为 e.target.value；

13      }}

13      }}

14    >

14    >

15      <option value="JS">JavaScript</option>

15      <option value="JS">JavaScript</option>

16      <option value="TS">TypeScript</option>

16      <option value="TS">TypeScript</option>

17    </select>

17    </select>

18  );

18  );

19}
```

19}
```

This one line of code ensures that the acknowledgment of the user action can be performed immediately and with minimal INP, while performing the expensive operation right after.

这一行代码确保用户操作能被立即确认，且输入延迟（INP）最小，而开销较大的操作则在其后立即执行。

In fact, because we used a native `select` we don’t need to do anything to acknowledge the user action and can further simplify:

事实上，由于我们使用了原生的 `select` 元素，因此无需额外操作即可自动确认用户操作，从而可进一步简化代码：

```jsx
import interactionResponse from 'await-interaction-response';



export function LanguagePicker({ setLanguage }) {

4  return (

5    <select onChange={async (e) => {

6      await interactionResponse();

7      setLanguage(e.target.value);

8    }}>

9      <option value="JS">JavaScript</option>

10      <option value="TS">TypeScript</option>
```

```jsx
导入 interactionResponse 函数来自 'await-interaction-response' 模块；



导出函数 LanguagePicker（接收一个 setLanguage 回调作为 props）：

4  返回（

5    一个下拉选择框 `<select>`，其 `onChange` 事件处理器为异步函数：

6      首先等待 interactionResponse() 执行完成（用于响应用户交互，例如 Discord 的交互延迟）；

7      然后调用 setLanguage，传入用户所选选项的值；

8    ）；

9      包含一个值为 "JS"、显示文本为 "JavaScript" 的选项；

10     包含一个值为 "TS"、显示文本为 "TypeScript" 的选项；
```

11    </select>

11    </select>

12  );

12  );

13}
```

13}
```

### The implementation

### 实现方式

The implementation of `await-interaction-response` is very simple:

`await-interaction-response` 的实现非常简单：

```jsx
export function interactionResponse(): Promise<unknown> {

2  return new Promise((resolve) => {

3    setTimeout(resolve, 100); // Fallback for the case where the animation frame never fires.

4    requestAnimationFrame(() => {

5      setTimeout(resolve, 0);
```

6    });

7  });

8}
```

这段代码会等待一个动画帧（animation frame），同时还会设置一个超时（timeout）作为兜底机制。这使得浏览器有机会完成当前帧的绘制（paint），然后立即执行后续代码。而该超时机制仅在极特殊情况下起作用——例如用户恰好在动画帧触发前瞬间切换到其他标签页，导致 `requestAnimationFrame` 回调从未执行。

乍看之下，我们主动延迟任务执行似乎有悖常理；但需注意以下两点：

- 它能让用户**立刻获得操作已被接收的反馈**（例如按钮视觉状态变化），提升交互响应感；  
- 延迟时间最长仅为 **1 帧（约 16ms）**，平均约为 **8ms**，对于此类关键性操作（如表单提交、导航跳转等）而言，这一延迟远低于人类可感知的阈值。

### 使用现代 React 可进一步简化

React 引入了一个功能高度相似的 API：[`startTransition`](https://react.dev/reference/react/startTransition)，它向 React 表明：其回调函数中所触发的状态更新**无需同步执行**。如果你应用中的性能瓶颈正源于状态更新（如上文示例所示），那么你只需简单地将相关逻辑包裹在 `startTransition` 中即可。

```jsx
import { startTransition } from "react";
```

```javascript
export function LanguagePicker({ setLanguage }) {

export function 语言选择器({ setLanguage }) {

4  return (

4  return (

5    <select onChange={(e) => {

5    <select onChange={(e) => {

6      startTransition(() => {

6      startTransition(() => {

7        setLanguage(e.target.value);

7        setLanguage(e.target.value);

8      })

8      })

9    }}>

9    }}>

10      <option value="JS">JavaScript</option>

10      <option value="JS">JavaScript</option>

11      <option value="TS">TypeScript</option>

11      <option value="TS">TypeScript</option>
```

12    </select>

13  );

14}
```

## How to find out what to optimize

## 如何确定需要优化的内容

It can be challenging to reproduce INP issues on more powerful developer machines. We recently launched a few features that can help.

在性能更强的开发机上复现 INP（Interaction to Next Paint，交互到下一次绘制）问题可能颇具挑战性。我们近期推出了一些新功能，可助您一臂之力。

First, Vercel Speed Insights [identifies the specific HTML elements](https://vercel.com/changelog/html-element-attribution-in-speed-insights) impacting your Interaction to Next Paint (INP) metric. These CSS selectors tell you exactly which elements on the page had slow interactions. When optimizing INP, **go through this list by frequency prioritizing the most frequent interactions that are slow or need improvement.**

首先，Vercel Speed Insights [可识别影响您 Interaction to Next Paint（INP）指标的具体 HTML 元素](https://vercel.com/changelog/html-element-attribution-in-speed-insights)。这些 CSS 选择器能精准指出页面中哪些元素存在响应缓慢的交互行为。在优化 INP 时，**请按交互发生频率排序该列表，并优先处理那些最常发生、但响应缓慢或有待改进的交互。**

![](images/demystifying-inp-new-tools-and-actionable-insights-vercel/img_007.jpg)![](images/demystifying-inp-new-tools-and-actionable-insights-vercel/img_008.jpg)

The second is [support for INP monitoring](https://vercel.com/blog/introducing-new-developer-tools-in-the-vercel-toolbar#interaction-timing-tool) directly inside the Vercel Toolbar. This gives you the CSS selector of the impacted elements while you're actively previewing your page—in local dev, a staging environment, [or even production](https://vercel.com/blog/introducing-new-developer-tools-in-the-vercel-toolbar#using-the-toolbar-in-production)—so you can see which component to optimize.

第二项是 Vercel Toolbar 中直接集成的 [INP 监控支持](https://vercel.com/blog/introducing-new-developer-tools-in-the-vercel-toolbar#interaction-timing-tool)。当您正在本地开发环境、预发布环境，[甚至生产环境](https://vercel.com/blog/introducing-new-developer-tools-in-the-vercel-toolbar#using-the-toolbar-in-production)中实时预览页面时，该工具会即时显示受影响元素的 CSS 选择器，从而帮助您快速定位需优化的组件。

![The interaction timing tool allows you to see and optimize your website's responsiveness.](images/demystifying-inp-new-tools-and-actionable-insights-vercel/img_009.jpg)![The interaction timing tool allows you to see and optimize your website's responsiveness.](images/demystifying-inp-new-tools-and-actionable-insights-vercel/img_010.jpg)  
交互时序工具（Interaction Timing Tool）可帮助您直观了解并优化网站的响应性能。

Pairing these two tools with CPU throttling in the Chrome DevTools performance panel makes it quite easy to get results comparable to users on slower devices. One bit of caution: The CPU throttling sometimes yields extreme delays on the very first interaction. It’s safe to ignore this and just click again.

将这两项工具与 Chrome DevTools 性能面板中的 CPU 节流（CPU Throttling）功能配合使用，即可轻松获得与低性能设备用户相近的测试结果。需注意一点：CPU 节流有时会在首次交互时产生异常长的延迟；此现象可忽略，只需再次点击即可。

![](images/demystifying-inp-new-tools-and-actionable-insights-vercel/img_011.jpg)![](images/demystifying-inp-new-tools-and-actionable-insights-vercel/img_012.jpg)

## Summary

## 总结

INP is often misunderstood to require painting the full user response within 200ms, when it is really about giving the user feedback that their input is being processed within that time.

INP 常被误解为必须在 200 毫秒内完成用户操作的完整视觉响应；实际上，其核心在于确保用户输入能在该时间内得到明确反馈——即系统已开始处理该输入。

The most effective ways to improve INP are:

提升 INP 的最有效方法包括：

- Calling your third-party code vendors like analytics providers and asking them to improve their event handling code. Please do this today!

- 联系第三方代码供应商（例如数据分析服务商），要求其优化事件处理代码。请立即行动！

- Optimize JS framework rendering performance with tools like React’s `memo`.

- 利用 `React.memo` 等工具优化 JavaScript 框架的渲染性能。

- Help the browser have an easier time rendering the page with tools like CSS containment.

- 借助 CSS `containment` 等技术，减轻浏览器渲染页面的负担。

- And finally, splitting up event handling into two phases with `await-interaction-response` to ensure immediate acknowledgment of user input for truly expensive page changes.

- 最后，采用 `await-interaction-response` 将事件处理拆分为两个阶段，从而在发生开销极大的页面变更时，仍能即时确认用户输入。

Vercel.com landing page

Vercel.com 首页

### A deep dive into optimizing Core Web Vitals

### 深度解析：优化核心网页指标（Core Web Vitals）

Vercel.com landing page

Vercel.com 着陆页

### Talk with an SEO expert

### 与 SEO 专家交流
{% endraw %}
