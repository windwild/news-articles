---
title: "How to build an engaging virtual product tour - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/designing-the-vercel-virtual-product-tour"
date: "2023-06-02"
scraped_at: "2026-03-02T09:52:38.811546462+00:00"
language: "en-zh"
translated: true
description: "Learn how and why we designed the Vercel virtual product tour to address some of the most prominent needs in our marketing funnel."
---

render_with_liquid: false
Jun 2, 2023

2023 年 6 月 2 日

我们如何满足用户对交互式、零承诺体验的需求——即让用户在不注册、不绑定的前提下，直观感受我们的工具包。

如果你最近尝试过一款新技术工具，以下场景或许似曾相识：你访问其官网，快速浏览首页内容，却仍难以清晰理解这款工具究竟能为你做什么。

[Vercel 虚拟产品导览](https://vercel.com/product-tour) 是面向潜在团队的关键资源，帮助他们以交互方式深入理解 Vercel 所能提供的价值。它将关于 Vercel 的海量信息进行提炼，聚焦于最相关、最核心的功能模块。

首先，我们将阐述为何采用当前的设计思路来打造这一导览；随后，针对技术背景的读者，我们将深入解析 [其中最具启发性的实现细节](https://vercel.com/blog/designing-the-vercel-virtual-product-tour#technical-details)。

[**亲身体验一下。**  
\\  
感受广受客户与开发者喜爱的前端平台。  
\\  
立即开启导览](https://vercel.com/product-tour)

## 需求背景

虚拟产品导览旨在解决我们在市场营销漏斗中遇到的若干关键挑战。其核心目标是：为用户提供一种数字化体验，使其在无需注册账号、也无需联系销售团队的前提下，即可先行交互式地体验 Vercel 产品。我们希望用户只需付出极少 effort（操作成本），就能获得仅次于实际深度使用产品的体验。

此外，该导览还需揭示一些通常隐藏于后台、容易被用户忽略的“产品魔法”——例如某些高级功能的技术实现逻辑；同时，部分付费功能也需得到恰当凸显。整个导览以自驱动教程的形式，系统性地梳理了 Vercel 的产品能力体系，从而为用户后续高效采纳产品奠定坚实基础。

最重要的是，我们期望各团队能在导览过程中自然触发那个关键的“啊哈时刻”（“aha” moment）——正是这一顿悟瞬间，将激发他们将 Vercel 真正融入自身工作流的意愿与行动。

## The design

## 设计思路

With these needs in mind, we aimed to create an interactive experience that excites users about Vercel's offerings and familiarizes them with the platform.

考虑到这些需求，我们的目标是打造一种互动式体验，激发用户对 Vercel 各项功能的兴趣，并帮助他们快速熟悉平台。

The product tour unfolds as an interactive slideshow that allows users to take their time on each slide while maintaining an overall sense of progress. The slides contain real Vercel UI/UX usually only available to logged-in users. If the user _is_ signed in, the slides are personalized, displaying their avatar and username.

产品导览以交互式幻灯片形式展开，用户可在每张幻灯片上自由停留，同时始终保有整体进度感。幻灯片中嵌入了真实的 Vercel 用户界面与交互体验（UI/UX），而这些内容通常仅对已登录用户开放。若用户**已登录**，幻灯片将实现个性化展示，呈现其头像与用户名。

The Virtual Product Tour asks users to engage more deeply with the product than a simple clickthrough experience.

“虚拟产品导览”（Virtual Product Tour）要求用户比传统单击式导览更深入地与产品互动。

A dynamic tooltip focuses the user on the most relevant information in each slide. This was crucial: Vercel has a **lot** to offer, and we needed a way to show off a huge chunk of it without information overload. The tooltip also offers more interaction than a static button, since it needs to be moved to and clicked to progress. It even lets users engage directly with parts of the product, such as [comments on Preview Deployments](https://vercel.com/docs/concepts/deployments/comments).

一个动态浮动提示框（tooltip）将用户的注意力精准聚焦于每张幻灯片中最相关的信息上。这一点至关重要：Vercel 的功能**极其丰富**，我们必须在避免信息过载的前提下，充分展现其庞大能力。该提示框相比静态按钮具备更强的交互性——用户需将其移动至指定位置并点击，才能继续前进；它甚至支持用户直接操作产品中的某些功能模块，例如 [预览部署（Preview Deployments）中的评论功能](https://vercel.com/docs/concepts/deployments/comments)。

Finally, we added a "contact sales" feature throughout the tour so users can get their questions answered easily. This lets potential buyers convert whenever they’re sold on Vercel, instead of waiting until the end of the tour.

最后，我们在整个导览流程中嵌入了“联系销售”功能，便于用户随时提出疑问并获得解答。这使得潜在买家一旦被 Vercel 所打动，即可立即转化，无需等到导览结束。

### The mobile experience

### 移动端体验

Initially, we faced a challenge on how to make our product tour mobile-friendly. We knew mobile accounted for most of our new user traffic, so we couldn’t afford to overlook it. We attempted to scale down the desktop experience, but it proved too long and inconvenient to use.

最初，我们面临如何让产品导览适配移动端的挑战。我们深知移动端贡献了绝大多数新用户流量，因此绝不能忽视这一场景。我们曾尝试将桌面端体验简单缩放适配，但结果证明其流程过长、操作不便，用户体验不佳。

We ultimately decided to emulate a social media experience: cards that users can easily tap through. This approach was familiar to users and helped them get excited about the product even on a smaller screen.

最终，我们决定借鉴社交媒体的交互范式：采用用户可轻松轻点翻阅的卡片式设计。这种模式对用户而言十分熟悉，即便在小尺寸屏幕上，也能有效激发他们对产品的兴趣。

The Virtual Product Tour, as experienced on mobile.

移动端上的“虚拟产品导览”。

Our primary goal is to provide an introduction to the full Vercel product. Building an application on Vercel generally happens on desktop, so our mobile tour needed to drive account creation and sales contacts. From there, users could fully enable themselves to create the applications they want.

我们的主要目标是全面介绍 Vercel 全系列产品。在 Vercel 上构建应用通常发生在桌面端，因此我们的移动端导览需重点推动用户完成账户注册及销售联系。在此基础上，用户即可完全自主地创建所需的应用。

### Accessibility from the outset

### 从设计之初即重视可访问性

Accessibility isn’t something you tack on to the end of your application. Especially when designing a complex experience, where there’s often no predefined [Accessible Rich Internet Applications (ARIA) standards](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA), we needed to consider how we were going to keep the experience usable for all.

可访问性（Accessibility）绝非应用开发末期才“打补丁”式添加的功能。尤其在设计复杂交互体验时，往往缺乏现成的 [无障碍富互联网应用（ARIA）标准](https://developer.mozilla.org/zh-CN/docs/Web/Accessibility/ARIA)，因此我们必须从一开始就思考：如何确保所有用户都能顺畅使用该体验。

There’s no defined aria-role for “product tour” or “demo.” Instead, we decided that the experience was most similar to a carousel. Carousels generally carry an `aria-live` attribute, which indicates that an element’s contents may change without the element itself reloading. We placed this on a hidden `div` in combination with `role="status"` to notify screen readers each time the user changes to a different slide.

HTML 中并无预定义的 `aria-role` 用于标识“产品导览”或“演示”。我们最终判定，该体验最接近轮播组件（carousel）。轮播组件通常带有 `aria-live` 属性，用以表明其内容可能动态更新，而无需重新加载整个元素本身。为此，我们在一个隐藏的 `div` 上同时设置了 `aria-live` 和 `role="status"`，确保每次用户切换至新幻灯片时，屏幕阅读器都能及时播报提示。

Keyboard navigation needed to equal the usability of a mouse. We added a “Get Started” button, so that the user isn’t thrown abruptly into Step 1 upon page navigation. We replaced the “Skip to Content” button with “Skip to Tooltip,” allowing users to directly navigate to the tooltip instead of the main content. This is particularly useful for screen readers, as most buttons were disabled and user only needs to press the tooltip dot.

键盘导航的可用性必须与鼠标操作完全一致。我们新增了“立即开始（Get Started）”按钮，避免用户在页面跳转后被突兀地直接带入“第一步”。同时，我们将原本的“跳至正文（Skip to Content）”按钮替换为“跳至提示框（Skip to Tooltip）”，使用户可直接聚焦于提示框而非主内容区域——这对屏幕阅读器尤为实用，因为多数操作按钮处于禁用状态，用户只需聚焦并点击提示框上的圆点即可。

We also solved race conditions with `lodash.delay()` to ensure that the focus remained on the tooltip as users navigated from slide to slide or up and down a single slide. We’ll address race conditions more in the animation section below.

我们还借助 `lodash.delay()` 解决了竞态条件问题，确保用户在幻灯片间切换、或在单张幻灯片内上下导航时，焦点始终稳定停留在提示框上。关于竞态条件的更多细节，我们将在下文的动画部分进一步说明。

While there’s definitely a lot more to be done to ensure an accessible experience for all, we felt this gave a solid foundation for the vast majority of use cases.

尽管要实现真正面向所有用户的无障碍体验，仍有大量工作待完成；但我们认为，当前方案已为绝大多数使用场景奠定了坚实基础。

We’re committed to building accessible designs. Please let us know if a Vercel experience needs to be more accessible for you.

我们始终致力于打造具备无障碍特性的设计方案。若您在使用 Vercel 产品过程中发现任何可访问性方面的需求或改进建议，欢迎随时告知我们。

## Technical details

## 技术实现细节

Now, we’ll jump into the details about the technical implementation. If you’d like to learn more about how Vercel can enable your own virtual experiences, feel free to [skip to the end of the article](https://vercel.com/blog/designing-the-vercel-virtual-product-tour#reimagine-your-user-experience).

接下来，我们将深入探讨本次技术实现的具体细节。如果您希望进一步了解 Vercel 如何助力您打造专属的虚拟化用户体验，欢迎直接[跳转至本文末尾](https://vercel.com/blog/designing-the-vercel-virtual-product-tour#reimagine-your-user-experience)。

### **Data**

### **数据**

A `DemoContext` serves as the single source of truth for the data in the product tour. This Context provides our Product Tour components with everything they need to handle navigation, animations, and changing content, including:

`DemoContext` 是产品导览中所有数据的唯一真实来源。该上下文为我们的产品导览组件提供处理导航、动画及内容变更所需的一切信息，包括：

- An `index` state, for tracking the current slide / tour progression  
- 一个 `index` 状态，用于追踪当前幻灯片／导览进度

- A `subIndex` state, for further tracking progression of steps within each slide  
- 一个 `subIndex` 状态，用于进一步追踪每张幻灯片内各步骤的进展

- The current `tooltipRef`, used to position the product tour tooltip  
- 当前的 `tooltipRef`，用于定位产品导览的工具提示（tooltip）

- Data and components to render for each slide  
- 每张幻灯片需渲染的数据与组件

- States for the modal and tour survey  
- 模态框（modal）及导览问卷（tour survey）的状态

### Navigation

### 导航

As the slides change, we sync the current slide `index` (zero-based) with a URL query parameter `i`. We set these URL parameters with Next.js’s `useRouter` hook, which allows us not only to update the param upon the `index` change, but also allows for direct linking to any given slide. Thus, `/product-tour?i=6` will always display the fourth slide of the tour. [Try it out](http://vercel.com/product-tour?i=6).

当幻灯片切换时，我们将当前幻灯片的 `index`（从零开始计数）与 URL 查询参数 `i` 同步。我们使用 Next.js 的 `useRouter` Hook 设置这些 URL 参数，这不仅可在 `index` 变化时自动更新该参数，还支持直接链接至任意指定幻灯片。因此，访问 `/product-tour?i=6` 将始终显示导览的第四张幻灯片。[立即尝试](http://vercel.com/product-tour?i=6)。

### The tooltip data

### 工具提示（tooltip）数据

Throughout the tour, you’re accompanied by a `Tooltip` that provides carefully positioned information about the product.

在整个导览过程中，您将始终伴随一个 `Tooltip`，它会以精心设计的位置向您提供有关产品的信息。

Each slide has its own `TooltipContent` object (show below), which gives the `Tooltip` its text, position, and styling. `TooltipContent` derives its data from a clean `tooltipContentMap`, where developers can set properties for each slide or sub-slide. `DemoContext`, meanwhile, tells the Map exactly which properties to send to the `TooltipContent`.

每张幻灯片都拥有独立的 `TooltipContent` 对象（如下所示），用于为 `Tooltip` 提供文本内容、显示位置及样式。`TooltipContent` 的数据源自结构清晰的 `tooltipContentMap`，开发者可在其中为每张幻灯片或子幻灯片配置各项属性。而 `DemoContext` 则负责告知该映射（Map）：应将哪些具体属性传递给 `TooltipContent`。

```tsx
export interface TooltipContent {

2// Data populated from tooltipContentMap, based on current DemoContext index



4// Tooltip text

5  title?: string;

6  description?: string;



8// Tooltip style and position


2// 数据源自 tooltipContentMap，依据当前 DemoContext 的索引进行填充



4// Tooltip 文本

5  title?: string;

6  description?: string;



8// Tooltip 样式与位置
```

9  color?: 'white' | 'black';

9  color?：可选值为 `'white'` 或 `'black'`；

10  dotAlignX?: 'left' | 'center' | 'right';

10  dotAlignX?：可选值为 `'left'`、`'center'` 或 `'right'`；

11  dotAlignY?: 'top' | 'center' | 'bottom';

11  dotAlignY?：可选值为 `'top'`、`'center'` 或 `'bottom'`；

12  transform?: string;

12  transform?：可选字符串类型；

13  tooltipAlign?: 'top' | 'left' | 'right' | 'bottom';

13  tooltipAlign?：可选值为 `'top'`、`'left'`、`'right'` 或 `'bottom'`；

15// Custom TS type check

15// 自定义 TypeScript 类型检查

16  type: 'TooltipContent';

16  type：`'TooltipContent'`；

17}
```

The options for the TooltipContent interface.

`TooltipContent` 接口的可选配置项。

### Repositioning the tooltip

### 重新定位提示框（Tooltip）

Since the `Tooltip` position changes by slide **and** by resizing the screen, we created a `repositionTooltip` function to handle all conditions.

由于 `Tooltip` 的位置会随幻灯片切换 **以及** 浏览器窗口缩放而变化，我们专门编写了 `repositionTooltip` 函数来统一处理所有相关场景。

With each new slide or transition within the same slide, the `tooltipRef` updates, which forces the tour to “scroll” to the new ref and reposition the `Tooltip` via the `repositionTooltip` function.

每当切换至新幻灯片，或在同一幻灯片内发生过渡动画时，`tooltipRef` 都会更新；这将强制导览流程“滚动”至新的引用节点，并通过 `repositionTooltip` 函数重新定位 `Tooltip`。

The `repositionTooltip` function also listens for window resizing, via a `ResizeObserver`. This means `repositionTooltip` gets called very frequently and needs to be throttled. Instead of invoking the function every millisecond during a user event, we used timeouts to ensure a reasonable rate of update.

`repositionTooltip` 函数还借助 `ResizeObserver` 监听窗口尺寸变化。这意味着该函数会被高频调用，因此必须进行节流（throttling）。我们并未在用户操作过程中每毫秒都触发该函数，而是采用定时器（`timeout`）机制，以确保更新频率合理可控。

On window resize, the tooltip smoothly repositions itself after a slight delay.

窗口缩放时，提示框会在短暂延迟后平滑地重新定位自身。

The function _also_ handles the `Tooltip` size to avoid overflowing the viewport. After calculating the `Tooltip` description’s size and position, we pass the dimensions to a function called `isOutofViewport` ( [credit to Chris Ferdinandi](https://vanillajstoolkit.com/helpers/isoutofviewport/)). If the `Tooltip` and its description go out of the viewport, we adjust its alignment by changing values held in

该函数 _不仅_ 处理提示框的位置，还兼顾其尺寸，防止其超出视口边界。在计算出提示框描述内容的尺寸与位置后，我们将这些维度数据传入一个名为 `isOutofViewport` 的函数（[感谢 Chris Ferdinandi 提供的实现](https://vanillajstoolkit.com/helpers/isoutofviewport/)）。若提示框及其描述内容超出视口范围，我们将通过修改以下变量值来调整其对齐方式：

This function handles more than just the tooltip’s position, but also is cognizant of the tooltip’s size so as to avoid overflowing the viewport. After calculating the estimated projection of the tooltip description’s size and position, we pass the dimensions to a function called `tooltipAlign`, `dotAlignX`, `dotAlignY` , and `transform` to bring the element fully inside bounds.

该函数所承担的任务远不止定位提示框本身——它同时关注提示框的尺寸，以避免其溢出视口。在估算出提示框描述内容的尺寸与位置后，我们将这些维度数据传入名为 `tooltipAlign`、`dotAlignX`、`dotAlignY` 和 `transform` 的函数，从而确保整个元素完全位于可视区域内。

### Animating the tooltip

### 为提示框添加动画效果

We designed our animations to retain user attention. A product tour like this one could have meant over-the-top transitions and lots of bells and whistles to keep the user engaged, but we wanted the user to focus on the Vercel experience, and not the one of the product tour.

我们设计动画的初衷是持续吸引用户注意力。类似本产品的导览流程本可以采用夸张的转场效果和大量炫目装饰来维持用户参与感；但我们更希望用户聚焦于 Vercel 自身的产品体验，而非导览流程本身的呈现效果。

Upon transition of each slide, we use CSS transitions to smoothly interpolate the tooltip from its previous to current position, as defined by the `tooltipRef`.

每当幻灯片发生切换时，我们利用 CSS 过渡（CSS transitions）实现提示框从上一位置到当前位置（由 `tooltipRef` 定义）的平滑插值动画。

The animations in the virtual product tour required strict timing and communication between various transitions.

虚拟产品导览中的动画需要严格的时间控制，以及各过渡效果之间的紧密协同。

The dot indicator/button pulses through a simple CSS keyframe animation of the element’s `scale`. If the user clicks outside the button or the current `tooltipRef` element, a click event handler on the tour window triggers a separate attention-getting animation that makes the dot pulse more intensely, guiding the user’s interactions back to the tooltip.

圆点指示器/按钮通过一个简单的 CSS 关键帧动画实现脉冲效果，该动画作用于元素的 `scale` 属性。如果用户点击了按钮以外的区域，或当前 `tooltipRef` 元素之外的区域，则导览窗口上的点击事件处理器会触发一个独立的“吸引注意力”动画，使圆点以更强烈的频率脉动，从而将用户的交互引导回提示框（tooltip）。

Building the tooltip’s actual animations wasn’t too complicated, but timing those animations required a lot more work. At first, the tooltip description would unpredictably flicker as varying race conditions with `repositionTooltip` and the dot’s moving animation resolved.

为提示框（tooltip）本身构建动画并不复杂，但精确协调这些动画的时序却耗费了大量精力。最初，由于 `repositionTooltip` 函数与圆点移动动画之间存在多种竞态条件（race conditions），提示框描述内容会不可预测地闪烁。

Ideally, we wanted only the dot to move and for the tooltip description to appear after the dot stopped moving. We solved this with a `transitionEnd` event listener (credit to [Programming Bytes](https://www.educative.io/answers/how-to-detect-the-end-of-css-transition-events-in-javascript)). By targeting the `propertyName` of the transition event, we were able to ensure that only after the `top` property of the dot was finished transitioning, the tooltip description would appear.

理想情况下，我们希望仅圆点发生位移，而提示框描述内容则在圆点完全停止移动后才出现。我们通过添加一个 `transitionEnd` 事件监听器解决了这一问题（感谢 [Programming Bytes](https://www.educative.io/answers/how-to-detect-the-end-of-css-transition-events-in-javascript) 提供的思路）。通过检查过渡事件（transition event）的 `propertyName` 属性，我们确保只有当圆点的 `top` 属性完成过渡后，提示框描述内容才会显示。

We also used `lodash.delay()` throughout the code, to dictate a sort of timeline between all animations and transitions. It’s crucial that no matter the sequence the user takes through the tour, the animations always play in the correct order.

我们还在代码中广泛使用了 `lodash.delay()`，用以明确设定所有动画与过渡效果之间的时间线。无论用户以何种顺序浏览导览流程，动画始终按正确顺序播放——这一点至关重要。

## Reimagine your user experience

## 重新构想您的用户体验

Giving the best buying experience is essential to us. We understand that purchasing software can be tedious and not everyone is ready to dive into a trial or have a conversation with sales. That's why the interactive Vercel product tour exists—to give you a comprehensive preview of the platform, minimizing the effort to see the potential results.

提供卓越的购买体验对我们而言至关重要。我们深知，软件采购过程可能枯燥乏味，并非每位用户都愿意立即开启试用，或主动联系销售团队沟通。正因如此，我们推出了交互式 Vercel 产品导览——让您全面预览平台能力，以最低门槛直观感受其潜在价值。

Through the development of the Vercel virtual product tour, we successfully addressed key challenges in our marketing funnel and enhanced our user journey. The potent combination of Next.js and Vercel deployments, which we use for all our public-facing products, enable us to transform everyday digital interfaces into impactful experiences.

在开发 Vercel 虚拟产品导览的过程中，我们成功应对了营销漏斗中的关键挑战，并显著优化了用户旅程。我们所有面向公众的产品均采用 Next.js 与 Vercel 部署的强力组合，这使我们得以将日常数字界面转化为富有影响力的真实体验。

To get a sense of what you can build with Vercel, we invite you to explore projects such as last year's [Next.js Conf landing page](https://nextjs.org/conf) and our recent [Ship Week experience](https://vercel.com/ship).

若您想了解借助 Vercel 可以构建怎样的项目，诚邀您探索以下案例：去年的 [Next.js Conf 官方落地页](https://nextjs.org/conf)，以及我们近期推出的 [Ship Week 互动体验](https://vercel.com/ship)。

We created the Vercel virtual product tour keeping you, our customers, at the heart of the process. It's all about empowering you to build the best user experience possible, whatever your project might be.

我们以您——我们的客户——为核心，打造了这款 Vercel 虚拟产品导览。一切努力，都是为了赋能您构建尽可能出色的用户体验，无论您的项目属于何种类型。

You can bring your own vision to life with one of our [200+ templates](https://vercel.com/templates), or deploy a [new repo](https://vercel.com/new) in just a few clicks.

您可以借助我们的 [200 多个模板](https://vercel.com/templates) 将自己的构想变为现实，或仅需几次点击即可部署一个 [新仓库](https://vercel.com/new)。

[**Ready to redefine your digital experiences with Vercel?**\\
\\
If you're curious about how Vercel can uplift your team's specific use case, our experts are ready for a conversation.\\
\\
Let's Talk](https://vercel.com/contact/sales)

[**准备好借助 Vercel 重新定义您的数字体验了吗？**\\
\\
如果您想了解 Vercel 如何助力您的团队实现特定用例，我们的专家已随时准备与您深入交流。\\
\\
立即沟通](https://vercel.com/contact/sales)

Blog post

博客文章

Jul 28, 2022

2022 年 7 月 28 日

### Build your own web framework

### 构建您自己的 Web 框架

![](images/how-to-build-an-engaging-virtual-product-tour-vercel/img_001.jpg)

Lydia Hallie

莉迪亚·哈利（Lydia Hallie）

Customer case study

客户案例研究

Feb 10, 2023

2023 年 2 月 10 日

### Runway enables next-generation content creation with AI and Vercel

### Runway 借助 AI 与 Vercel 实现下一代内容创作

![](images/how-to-build-an-engaging-virtual-product-tour-vercel/img_002.jpg)![](images/how-to-build-an-engaging-virtual-product-tour-vercel/img_003.jpg)

Kiana 和 Steven