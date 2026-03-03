---
title: "Bridging the gap between design and code with v0 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/bridging-the-gap-between-design-and-code-with-v0"
date: "2025-02-12"
scraped_at: "2026-03-02T09:37:20.359942898+00:00"
language: "en-zh"
translated: true
description: "Understanding how the team at Speakeasy uses v0 to ship faster with features like Figma import and custom Tailwind config. "
---

Feb 12, 2025

2025 年 2 月 12 日

How Speakeasy uses v0 to ship faster with features like Figma import and custom Tailwind config.

Speakeasy 如何利用 v0 加快功能交付速度——支持 Figma 导入与自定义 Tailwind 配置等功能。

[Speakeasy](http://speakeasy.com/?utm_source=vercel) specializes in building developer-focused SDKs—to help developers build their products.  
[Speakeasy](http://speakeasy.com/?utm_source=vercel) 专注于构建面向开发者的 SDK，助力开发者高效打造自身产品。

They adopted v0 to bridge the workflow from design to code, using it to accelerate rapid prototyping and reduce implementation time.  
他们采用 v0 来弥合设计到代码的工作流断点，借此加速快速原型开发，并显著缩短功能实现周期。

Speakeasy's product is highly technical, and their team embraces a "design as code" philosophy. Without [v0](https://v0.dev/), this approach wasn’t straightforward. While Figma is used for initial design explorations, static pixel designs weren't enough to convey new ideas or get buy-in. Design at Speakeasy focuses on movement, behavior, and interaction—how a product feels, not just how it looks. Given the need for quick iteration, meticulously designing every feature in Figma wasn’t practical.  
Speakeasy 的产品技术性极强，其团队奉行“设计即代码”（design as code）的理念。若无 [v0](https://v0.dev/)，这一理念难以落地。尽管团队使用 Figma 进行初期设计探索，但静态的像素级设计图不足以清晰传达新构想，也难以获得各方共识。Speakeasy 的设计重心在于动效、行为与交互——关注产品“用起来的感觉”，而不仅是“看上去的样子”。在亟需快速迭代的背景下，为每一项功能都精细打磨 Figma 设计稿并不现实。

![](images/bridging-the-gap-between-design-and-code-with-v0-vercel/img_001.jpg)

## Using v0 to iterate on experiences faster

## 借助 v0 更快地迭代用户体验

v0 helps the whole Speakeasy team quickly explore ideas, even if they’re not designers or engineers. v0 leverages AWS Bedrock's foundation model infrastructure to power its AI-driven code generation capabilities, enabling developers to rapidly prototype and build full-stack applications through natural language prompts.  
v0 赋能 Speakeasy 全体成员——无论是否为设计师或工程师——都能快速探索创意构想。v0 基于 AWS Bedrock 的基础模型基础设施，驱动其 AI 代码生成能力，使开发者可通过自然语言提示，迅速完成全栈应用的原型开发与构建。

![](images/bridging-the-gap-between-design-and-code-with-v0-vercel/img_002.jpg)

They use v0 as a dynamic design descriptor, a way to share interactive prototypes and demonstrate feature behavior. Some designs start in [Figma and are imported into v0](https://vercel.com/blog/working-with-figma-and-custom-design-systems-in-v0-6cZjvh5CBjx0d3ZF967jGj), but many concepts are designed directly in v0. This allows designers and engineers collaborate in real time, refining ideas without the friction of design-to-code translation.  
他们将 v0 视作一种动态的设计描述工具，用于共享可交互的原型，并直观呈现功能行为。部分设计始于 [Figma 并导入 v0](https://vercel.com/blog/working-with-figma-and-custom-design-systems-in-v0-6cZjvh5CBjx0d3ZF967jGj)，但更多概念直接在 v0 中完成设计。这使得设计师与工程师得以实时协作，在无需经历“设计→代码”转换摩擦的前提下，共同打磨和完善创意。

For instance, the **initial concept for the Terminal Preview in the Speakeasy dashboard was created in a single day using v0.** This rapid prototyping allowed the team to focus on refining interactivity and user experience rather than translating static designs into code.  
例如，**Speakeasy 控制台中“终端预览”（Terminal Preview）功能的初始概念，仅用一天便通过 v0 完成构建。** 这种快速原型开发方式，使团队得以将精力集中于优化交互逻辑与用户体验，而非耗费时间将静态设计图手动转译为代码。

The team used v0 to design the look and the feel of their Terminal Preview feature, including the polished interactions.

团队使用 v0 设计了其 Terminal Preview 功能的视觉风格与交互体验，包括精细打磨的交互细节。

> “The reason I jumped to v0, was a bias towards code. It meant less time having to redo ideas in Figma. When it comes to getting ready to ship, I was already in the right medium. I saved whatever time it would have taken me to translate Figma to code.”  
>  
> “我之所以迅速转向 v0，源于我对代码的天然偏好。这意味着我不必在 Figma 中反复重做设计构思，节省了大量时间。当产品临近发布阶段时，我早已处于最合适的媒介中——直接编写代码。我因此省去了将 Figma 设计稿手动翻译为代码所需的一切时间。”  
>  
> ![](images/bridging-the-gap-between-design-and-code-with-v0-vercel/img_003.png)  
>  
> **Faraz Khan,** Design Engineer  
>  
> **法拉兹·汗（Faraz Khan）**，设计工程师

A key element of their workflow is a custom Tailwind configuration, which v0 users use to build and style components according to their design system. For example, the font weights and colors used in their Terminal Preview feature were all defined and used within v0.

他们工作流中的一个关键环节，是定制化的 Tailwind 配置——v0 用户借此依据自身设计系统构建并样式化组件。例如，Terminal Preview 功能中所用的字重与颜色，全部在 v0 内定义并直接调用。

![Example of defining custom style preferences in the tailwind.config.js file in v0. ](images/bridging-the-gap-between-design-and-code-with-v0-vercel/img_004.jpg)![Example of defining custom style preferences in the tailwind.config.js file in v0. ](images/bridging-the-gap-between-design-and-code-with-v0-vercel/img_005.jpg)

在 v0 的 `tailwind.config.js` 文件中定义自定义样式偏好的示例。

Example of defining custom style preferences in the tailwind.config.js file in v0.

在 v0 中通过 `tailwind.config.js` 文件定义自定义样式偏好的示例。

Everyone from designers to backend developers at Speakeasy use v0. The team often shares Loom recordings of their v0 prototypes to communicate design ideas effectively. In fact, the phrase “Share a v0” has replaced lengthy Slack discussions and meetings.

Speakeasy 团队中，从设计师到后端开发者，全员都在使用 v0。团队常通过分享 v0 原型的 Loom 录屏来高效传达设计构想。事实上，“Share a v0”（分享一个 v0）这句话，已取代了冗长的 Slack 讨论和会议。

通过直接在原生代码环境中进行原型开发，Speakeasy 加速了迭代周期、提升了产品质量，并始终让设计与工程保持高度协同。对 Speakeasy 而言，v0 不仅仅是一款工具——它正是他们打造更优开发者体验的方式。

[**Try v0 for free**  
**免费试用 v0**  
\\  
Ready to experience the power of v0 in your day-to-day?  
您是否已准备好在日常工作中亲身体验 v0 的强大能力？  
\\  
Get started  
立即开始](https://v0.app/)