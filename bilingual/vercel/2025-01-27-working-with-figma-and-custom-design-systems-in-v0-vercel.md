---
title: "Working with Figma and custom design systems in v0 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/working-with-figma-and-custom-design-systems-in-v0"
date: "2025-01-27"
scraped_at: "2026-03-02T09:37:48.361955581+00:00"
language: "en-zh"
translated: true
description: "Learn best practices on importing your designs from Figma, working with shadcn/ui, and leveraging public npm packages. "
---

Jan 27, 2025

2025 年 1 月 27 日

学习如何从 Figma 导入设计、与 shadcn/ui 协同工作，以及利用公共 npm 包的最佳实践。

v0 支持导入现有 Figma 文件，使设计师与开发者得以弥合设计工具与 AI 驱动开发之间的鸿沟。该功能可从 Figma 文件中提取上下文信息，并连同任何补充性视觉素材一并传入 v0 的生成流程。

![](images/working-with-figma-and-custom-design-systems-in-v0-vercel/img_001.jpg)![](images/working-with-figma-and-custom-design-systems-in-v0-vercel/img_002.jpg)

在使用 Figma 集成时，最佳做法是将设计拆分为更小、更易管理的组件或区块——这与您将设计交付给人类开发者时所采用的方式一致。

当每个组件均置于独立的 Frame 中时，您不仅能避免潜在的尺寸与维度错误，还能确保 AI 更高效地处理每个组件。建议分离的关键元素包括：导航栏（navigation bars）、侧边栏（sidebars）、表单（forms）、具有独特交互逻辑的 UI 组件（如日期选择器 date pickers），以及落地页（landing pages）中的各个独立区块。

![图示：如何将大型设计拆分为更小的组件。](images/working-with-figma-and-custom-design-systems-in-v0-vercel/img_003.jpg)图示：如何将大型设计拆分为更小的组件。

[v0 生成的组件](https://v0.dev/chat/figma-components-PgiDC8JXaVR) 与 Figma 原始设计高度一致；而且，在对设计进行组件化时，v0 甚至能自动推断动画效果——因为它能够构建设计中各元素之间的关联关系。

![](images/working-with-figma-and-custom-design-systems-in-v0-vercel/img_004.jpg)

多个元素可合并为一个整体设计后导入 v0，但这种方式往往导致表面积（surface area）过大、视觉上下文过于庞杂，从而令 AI 难以有效处理。若您采用这种处理较大规模设计的方法，请务必确保整个设计及其所有子组件仍被包含在同一个 Frame 内。

## Take the iterative approach

## 采用迭代式方法

When working with existing Figma components in v0, an iterative approach is highly recommended.

在 v0 中使用现有 Figma 组件时，我们强烈推荐采用迭代式方法。

- Start by focusing on individual components

- 首先聚焦于单个组件

- Test and refine each one before moving on to the next

- 在进入下一个组件前，逐一测试并优化每个组件

- Fine-tune the smaller pieces and ensure they work well within v0’s generation process

- 精调各个小部件，并确保它们能良好适配 v0 的生成流程

- Gradually build up to complete landing pages by piecing together the components, rather than attempting a lengthy single-piece generation all at once

- 通过逐步拼接组件，渐进式构建完整的落地页，而非一次性尝试生成冗长的单一整体

Build the pieces of your design first, like buttons and images, and _then_ tell v0 how to arrange them. This way, v0 can reuse those pieces, making your design more efficient.

先构建设计中的各个部件（例如按钮和图片），_再_ 告诉 v0 如何将它们排列组合。这样，v0 就能复用这些部件，使您的设计更高效。

The more you use v0 with your Figma designs, the better it gets at understanding your style preferences, like your favorite fonts and spacing. v0 is learning and adapting to your design language over time.

您越频繁地将 v0 与自己的 Figma 设计配合使用，它就越能准确理解您的风格偏好（例如偏爱的字体与间距）。v0 会持续学习并逐步适应您的设计语言。

## Working with existing design systems

## 使用现有设计系统

v0 uses the [shadcn/ui component library](https://ui.shadcn.com/) as its default design system. This library provides customizable, accessible, and well-designed components that work seamlessly with React and Next.js.

v0 默认采用 [shadcn/ui 组件库](https://ui.shadcn.com/) 作为其设计系统。该库提供可定制、具备无障碍支持且设计精良的组件，能与 React 和 Next.js 无缝协作。

Shadcn/ui is so customizable that it lets you keep the look and feel of your current design system. Some teams using v0 are already refactoring their design systems around shadcn/ui to work seamlessly with v0—cutting down the time it takes to go from design to implementation on new features by up to three times.

shadcn/ui 具有极高的可定制性，使您能够保留现有设计系统的外观与风格。一些正在使用 v0 的团队已开始围绕 shadcn/ui 重构其设计系统，以实现与 v0 的无缝协作——将新功能从设计到落地实现的耗时最多缩短至原来的三分之一。

v0 generations can also use a custom Tailwind config file. [In this example](https://v0.dev/chat/todo-list-with-gradients-GGQmdxIcCtv), there is a custom Tailwind config for a gradient button that is used in the generated component. This helps v0 adapt to custom design systems by allowing users to define and customize their styles and primitives.

v0 的生成结果还可使用自定义的 Tailwind 配置文件。[在本示例中](https://v0.dev/chat/todo-list-with-gradients-GGQmdxIcCtv)，为渐变按钮定义了一个自定义 Tailwind 配置，并应用于所生成的组件中。这使得 v0 能够适配自定义设计系统，允许用户自主定义并定制其样式与基础组件（primitives）。

![Example of defining custom style preferences in the tailwind.config.js file in v0. ](images/working-with-figma-and-custom-design-systems-in-v0-vercel/img_005.jpg)![Example of defining custom style preferences in the tailwind.config.js file in v0. ](images/working-with-figma-and-custom-design-systems-in-v0-vercel/img_006.jpg)

![在 v0 中于 tailwind.config.js 文件内定义自定义样式偏好的示例。](images/working-with-figma-and-custom-design-systems-in-v0-vercel/img_005.jpg)![在 v0 中于 tailwind.config.js 文件内定义自定义样式偏好的示例。](images/working-with-figma-and-custom-design-systems-in-v0-vercel/img_006.jpg)

Example of defining custom style preferences in the tailwind.config.js file in v0.

在 v0 中于 tailwind.config.js 文件内定义自定义样式偏好的示例。

Additionally, v0 supports working with any public npm packages. If your components are published publicly to npm, you can pull them into your v0 projects like any other library. This means you can use your libraries or libraries like [Material UI](https://mui.com/material-ui/) and [React Aria](https://react-spectrum.adobe.com/react-aria/index.html).

此外，v0 支持接入任意公开的 npm 包。若您已将组件公开发布至 npm，即可像引入其他常规库一样将其导入您的 v0 项目中。这意味着您可以直接复用您自己的组件库，或使用诸如 [Material UI](https://mui.com/material-ui/) 和 [React Aria](https://react-spectrum.adobe.com/react-aria/index.html) 等第三方库。

[`"Create a SaaS pricing table with Material UI React components."`](https://v0.dev/chat/FXQl5UbGZfY?b=b_qfx2WLwvGKC&f=0)

[`“使用 Material UI React 组件创建一个 SaaS 定价表。”`](https://v0.dev/chat/FXQl5UbGZfY?b=b_qfx2WLwvGKC&f=0)

## Get started with v0 today

## 立即开始使用 v0

v0's ability to generate high-quality UIs, leverage third-party libraries, and integrate with Figma makes it an invaluable tool for frontend iteration.

v0 具备生成高质量 UI、调用第三方库以及与 Figma 深度集成的能力，使其成为前端快速迭代过程中不可或缺的利器。

[**Try v0 for free**\\
\\
Ready to experience the power of v0 in your day-to-day? \\
\\
Get started](https://v0.app/)

[**免费试用 v0**\\
\\
准备好在日常开发中体验 v0 的强大能力了吗？\\
\\
立即开始](https://v0.app/)