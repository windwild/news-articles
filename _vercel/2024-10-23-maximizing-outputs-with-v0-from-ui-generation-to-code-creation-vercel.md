---
title: "Maximizing outputs with v0: From UI generation to code creation - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/maximizing-outputs-with-v0-from-ui-generation-to-code-creation"
date: "2024-10-23"
scraped_at: "2026-03-02T09:40:11.581638064+00:00"
language: "en-zh"
translated: true
description: "Learn prompt engineering best practices for working with v0's core functionality to get the best results."
---
&#123;% raw %}

Oct 23, 2024

2024年10月23日

学习提示工程（prompt engineering）的最佳实践，以充分发挥 v0 的核心功能，从而获得最佳生成效果。

[v0](https://v0.dev/) 是一款强大的工具，可用于生成高质量的用户界面（UI）和代码，同时也是一项极具价值的教育资源，助力你在 Web 上进行设计与开发。它深度集成了各类流行库及现代框架（如 Next.js 和 React）。无论你是想快速搭建新项目、获取外部数据，还是创建 [3D 图形](https://vercel.com/blog/add-3d-to-your-web-projects-with-v0-and-react-three-fiber)，v0 都旨在全面满足你的前端开发需求。

要获得最高质量的生成结果，你需要熟练编写输入提示（prompt），从而精准引导 v0 的行为。你对 v0 的引导越清晰、对其能力优势的理解越深入，所得到的响应也就越准确、越贴合实际需求。

本文将深入探讨如何最大化利用 v0 的核心功能——包括 UI 生成能力、代码生成能力，以及面向开发者的各项支持。

# 目录

01. [编写恰当的提示](https://vercel.com/blog/maximizing-outputs-with-v0-from-ui-generation-to-code-creation#writing-the-right-prompt)  
02. [理解 v0 的优势所在](https://vercel.com/blog/maximizing-outputs-with-v0-from-ui-generation-to-code-creation#understanding-where-v0-excels)  
03. [UI 生成](https://vercel.com/blog/maximizing-outputs-with-v0-from-ui-generation-to-code-creation#ui-generation)  
04. [第三方库支持](https://vercel.com/blog/maximizing-outputs-with-v0-from-ui-generation-to-code-creation#third-party-library-support)  
05. [从外部源获取数据](https://vercel.com/blog/maximizing-outputs-with-v0-from-ui-generation-to-code-creation#fetching-data-from-external-sources)  
06. [字体与样式](https://vercel.com/blog/maximizing-outputs-with-v0-from-ui-generation-to-code-creation#fonts-and-styling)  
07. [3D 图形](https://vercel.com/blog/maximizing-outputs-with-v0-from-ui-generation-to-code-creation#3d-graphics)  
08. [与 Next.js 的集成](https://vercel.com/blog/maximizing-outputs-with-v0-from-ui-generation-to-code-creation#integration-with-next.js)  
09. [技术规划](https://vercel.com/blog/maximizing-outputs-with-v0-from-ui-generation-to-code-creation#technical-planning)  
10. [前端开发支持](https://vercel.com/blog/maximizing-outputs-with-v0-from-ui-generation-to-code-creation#frontend-development-support)  
11. [立即开始使用 v0 进行提示工程](https://vercel.com/blog/maximizing-outputs-with-v0-from-ui-generation-to-code-creation#start-prompt-engineering-with-v0-today)

## 编写恰当的提示

你提供的细节越丰富，v0 就越能精准地按需定制其输出：

- 明确说明特定组件所需的各项功能

- Specify design preferences for every element

- 为每个元素指定设计偏好

- Mention any libraries or frameworks you want to use

- 提及您希望使用的任何库或框架

- Describe the context or use case for the component within the app you're working on

- 描述该组件在您正在开发的应用程序中的上下文或使用场景


Don't hesitate to ask for modifications or improvements to the generated code or UI:

- 请随时提出对生成代码或用户界面的修改或优化建议：

- Request specific changes or enhancements

- 请求具体的修改或功能增强

- Ask for alternative implementations or generations

- 询问替代实现方案或不同版本的生成结果

- Seek explanations for parts of the code you don't understand

- 就您不理解的代码部分寻求解释

- Use v0's suggestions to refine your ideas

- 借助 v0 的建议进一步完善您的想法


## Understanding where v0 excels

## 了解 v0 的优势所在

v0's comprehensive chat interface guides users through building, debugging, and shipping web applications. While it's always learning and improving, it's helpful to know where v0 excels.

v0 全面的聊天界面可引导用户完成 Web 应用的构建、调试与发布。尽管 v0 持续学习并不断改进，但了解其优势所在仍十分有益。

## UI generation

## UI 生成

One of the standout features of v0 is its ability to generate high-quality React UIs using [shadcn/ui](https://shadcn.dev/) components. But that’s just the beginning—v0 has top support for integrating with a wide range of third-party libraries to make your UI creations dynamic and versatile. v0 can also use component libraries from npm like [Material UI](https://v0.dev/chat/FXQl5UbGZfY?b=b_qfx2WLwvGKC&f=0).

v0 的一项突出功能是能够利用 [shadcn/ui](https://shadcn.dev/) 组件生成高质量的 React UI。但这仅仅是开始——v0 对接入各类第三方库提供了顶级支持，从而让您的 UI 创作更具动态性与灵活性。v0 还可直接使用来自 npm 的组件库，例如 [Material UI](https://v0.dev/chat/FXQl5UbGZfY?b=b_qfx2WLwvGKC&f=0)。

[`"Create a SaaS pricing table but use Material UI React components where possible."`](https://v0.dev/chat/FXQl5UbGZfY?b=b_qfx2WLwvGKC&f=0)

[`“创建一个 SaaS 定价表，尽可能使用 Material UI React 组件。”`](https://v0.dev/chat/FXQl5UbGZfY?b=b_qfx2WLwvGKC&f=0)

## Third-party library support

## 第三方库支持

While v0 can technically use any library, it performs best with certain well-documented libraries, including:

虽然 v0 在技术上可接入任意库，但它在以下这些文档完善、广受认可的库上表现尤为出色，包括：

- [`react-three-fiber`](https://v0.dev/chat/BQeR6T-fQMw?b=b_0CmKQnWF2Wj) for 3D graphics

- [`react-three-fiber`](https://v0.dev/chat/BQeR6T-fQMw?b=b_0CmKQnWF2Wj)（用于 3D 图形渲染）

- [`framer-motion`](https://v0.dev/chat/IrfSVKGnJ4L?b=b_XwIWdqgeSZx) for component animations

- [`framer-motion`](https://v0.dev/chat/IrfSVKGnJ4L?b=b_XwIWdqgeSZx)（用于组件动画）

- [`lodash`](https://v0.dev/chat/KFnEFNA2nRX?b=b_eC5xghO8dHR) for utility functions

- [`lodash`](https://v0.dev/chat/KFnEFNA2nRX?b=b_eC5xghO8dHR)（用于工具函数）

- [`react-confetti`](https://v0.dev/chat/xGUswrr2591?b=b_PNjJiy1B9as) for interactive elements

- [`react-confetti`](https://v0.dev/chat/xGUswrr2591?b=b_PNjJiy1B9as)（用于交互式元素，如庆祝彩纸效果）

- [`react-flow`](https://v0.dev/chat/NmXMnPW8d4V?b=b_riaFZRNoh98) for flow diagrams

- [`react-flow`](https://v0.dev/chat/NmXMnPW8d4V?b=b_riaFZRNoh98)（用于流程图）

- [`react-bootstrap`](https://v0.dev/chat/xsDK2MMRfeX) 用于 UI 基础架构

- [`react-bootstrap`](https://v0.dev/chat/xsDK2MMRfeX) 用于 UI 基础架构

如果你使用的是较为冷门的库，可能需要提供一些引导说明。大多数情况下，v0 能够很好地将 npm 包集成到你的代码生成结果中。你可以通过自然语言对话的方式指导 v0，也可以在 Projects 中添加文件作为“Source”（数据源），上传相关数据和文档，从而让 v0 更好地理解你的需求。

你可以在 Projects 中添加 PDF、TXT 文本文件、代码文件及其他形式的文档作为 Source，供 v0 学习参考，从而生成更贴合你需求的定制化结果。

## Fetching data from external sources

## 从外部数据源获取数据

v0 可以从外部 API 获取数据，但需谨慎处理敏感信息（例如 API 密钥）。例如，若将密钥通过消息发送并在生产环境中使用，该密钥将被存储在客户端，从而造成安全漏洞。因此，在生产应用中应尽量避免此类做法。

此外，v0 不仅能帮你编写实际的 ISR（Incremental Static Regeneration）代码以对接你的 CMS，还能协助你制定与后端系统（如 AWS、AEM、Salesforce 等）的技术集成方案。

## Fonts and styling

## 字体与样式

你可以在 v0 中启用自定义字体，只需告诉它“从 Google Fonts 导入 X 字体”即可。此外，你还可以指示 v0 调整 CSS 属性，对设计进行精细化调整，确保最终效果符合你的审美构想。

如果初始设计效果不符合预期，可要求 v0 修改特定的视觉属性。

`“将背景色设为黑色，为所有元素添加圆角，为卡片组件添加浅白色边框，并将所有按钮设为幽灵按钮（ghost buttons）。”`

`“将背景色设为黑色，为所有元素添加圆角，为卡片组件添加浅白色边框，并将所有按钮设为幽灵按钮（ghost buttons）。”`

Using a tool like [Coolors](https://coolors.co/) can also help generate cohesive color palettes to theme your UI generations effectively.

使用像 [Coolors](https://coolors.co/) 这样的工具，也能帮助您生成协调统一的配色方案，从而高效地为 UI 生成结果设定主题风格。

## 3D graphics

## 3D 图形

v0 is great at generating 3D graphics, particularly with `react-three-fiber`. If v0 indicates that it can’t generate in 3D, simply append “using react-three-fiber” to your query for better results. This functionality to great for designers who don’t want to code or spend hours wiring up 3D elements in traditional design tools.

v0 擅长生成 3D 图形，尤其在结合 `react-three-fiber` 时表现优异。如果 v0 提示无法生成 3D 内容，只需在您的查询末尾添加“using react-three-fiber”，即可获得更佳效果。这一功能对不想编写代码、也不愿在传统设计工具中耗费数小时手动搭建 3D 元素的设计师尤为实用。

Learn more by reading our [prompting guide for working with React Three Fiber in v0](https://vercel.com/blog/add-3d-to-your-web-projects-with-v0-and-react-three-fiber).

欲了解更多信息，请阅读我们的 [v0 中使用 React Three Fiber 的提示词指南](https://vercel.com/blog/add-3d-to-your-web-projects-with-v0-and-react-three-fiber)。

## Integration with Next.js

## 与 Next.js 集成

Not only can v0 generate UIs, but it can also install them directly into an existing [Next.js](https://nextjs.org/) project via the CLI. You can even scaffold an entirely new Next.js project if you’re starting from scratch.

v0 不仅能生成 UI，还可通过命令行工具（CLI）直接将生成结果安装到现有的 [Next.js](https://nextjs.org/) 项目中。若您从零开始，甚至可借助 v0 快速搭建一个全新的 Next.js 项目。

[`"Create a Next.js project template for a blog website using App Router."`](https://v0.dev/chat/9VmR9jQQAA2?b=b_A5jcryfPLIa)

[`“使用 App Router 创建一个博客网站的 Next.js 项目模板。”`](https://v0.dev/chat/9VmR9jQQAA2?b=b_A5jcryfPLIa)

## Technical planning

## 技术规划

v0 can provide technical planning support, to help support the ideation phase of engineering projects. For example v0 can generate [migration plans](https://v0.dev/chat/BTYi63JuTtK), helping teams transition from monolithic architectures or different frameworks. It can also generate intricate [architecture diagrams](https://v0.dev/chat/ZxW6VCFxY0K?b=b_glnozjN13An) that visualize complex systems, making it easier for teams to understand and refine their designs.

v0 可提供技术规划支持，助力工程项目的构思阶段。例如，v0 能生成[迁移方案](https://v0.dev/chat/BTYi63JuTtK)，协助团队从单体架构或不同框架完成平滑过渡；它还能生成精细的[系统架构图](https://v0.dev/chat/ZxW6VCFxY0K?b=b_glnozjN13An)，直观呈现复杂系统结构，从而帮助团队更清晰地理解并持续优化设计方案。

[`"Create an architecture plan for splitting my codebase into microfrontends."`](https://v0.dev/chat/ZxW6VCFxY0K?b=b_glnozjN13An)

[`“为我的代码库拆分为微前端制定一份架构方案。”`](https://v0.dev/chat/ZxW6VCFxY0K?b=b_glnozjN13An)

![v0 has systems design expertise that allows it to propose efficient, scalable architectures tailored to specific project requirements. ](images/maximizing-outputs-with-v0-from-ui-generation-to-code-creation-vercel/img_001.jpg)  
![v0 has systems design expertise that allows it to propose efficient, scalable architectures tailored to specific project requirements. ](images/maximizing-outputs-with-v0-from-ui-generation-to-code-creation-vercel/img_002.jpg)  
v0 具备系统设计专业能力，可针对特定项目需求提出高效、可扩展的架构方案。

## Frontend development support  
## 前端开发支持

When it comes to code generation, v0 is able to create advanced React and Next.js features. Alongside the code generations, v0 excels at breaking down complex frontend tasks into manageable steps. Whether it’s creating RSCs or working with new React and Next.js features, v0 provides thorough explanations to guide you through the process.  

在代码生成方面，v0 能够构建高级的 React 和 Next.js 功能。除生成代码外，v0 尤其擅长将复杂的前端任务拆解为清晰、可执行的步骤。无论是创建 React Server Components（RSC），还是使用 React 与 Next.js 的最新特性，v0 都会提供详尽的说明，全程引导您完成开发流程。

It also supports frameworks like [Svelte](https://v0.dev/chat/JJL6vKmYPPt?b=b_90A1TbvZTOa), Vue, and Remix, though with slightly less confidence compared to its expertise in React and Next.js.  

v0 同样支持 [Svelte](https://v0.dev/chat/JJL6vKmYPPt?b=b_90A1TbvZTOa)、Vue 和 Remix 等框架，但其在这些框架上的表现略逊于其在 React 和 Next.js 上的专业水准。

Moreover, it supports code generation for other programming languages like Python and Rust, as well as writing SQL queries. While it is more proficient with JavaScript, it still offers step-by-step breakdowns for development tasks in these languages.  

此外，v0 还支持 Python、Rust 等其他编程语言的代码生成，以及 SQL 查询编写。尽管它对 JavaScript 更为精通，但仍能为这些语言中的开发任务提供分步式解析与指导。

If you need to execute simple JavaScript snippets, v0’s Code Execution Block allows you to test code directly within the chat interface.  

若您需要运行简单的 JavaScript 片段，v0 的“代码执行区块”（Code Execution Block）支持您直接在聊天界面中测试代码。

### Start prompt engineering with v0 today  
### 今天就用 v0 开启提示工程之旅

v0's ability to generate high-quality UIs, leverage third-party libraries, and provide detailed code breakdowns makes it an invaluable tool for frontend development—and everyone else surrounding the development workflow.  

v0 在高质量 UI 生成、第三方库集成及细致入微的代码解析等方面的能力，使其成为前端开发——乃至整个开发工作流中所有相关人员——不可或缺的得力工具。

[**Get started today for free**\\  
[**立即免费开始使用**\\  
\\  
Whether you're coding, designing, or strategizing, v0 is your 24/7 companion, transforming good ideas into great web experiences.\\  
无论您是在编写代码、进行设计，还是制定策略，v0 都是您全天候的开发伙伴，助您将优秀构想转化为卓越的网页体验。\\  
\\  
Start building](https://v0.dev/)  
开始构建](https://v0.dev/)
&#123;% endraw %}
