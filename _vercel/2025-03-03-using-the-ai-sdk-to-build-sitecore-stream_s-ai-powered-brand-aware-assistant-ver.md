---
title: "Using the AI SDK to build Sitecore Stream's AI-powered brand aware assistant - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/using-the-ai-sdk-to-build-sitecore-streams-ai-powered-brand-aware-assistant"
date: "2025-03-03"
scraped_at: "2026-03-02T09:35:37.941655573+00:00"
language: "en-zh"
translated: true
description: "Sitecore Stream from Sitecore, powered by the AI SDK, empowers marketers with real-time conversational AI. "
---
&#123;% raw %}

Mar 3, 2025

2025年3月3日

How Sitecore built a new brand assistant that empowers marketers with real-time conversational creativity.

Sitecore 如何构建一款全新品牌助手，赋能营销人员实现实时对话式创意。

[Sitecore](https://www.sitecore.com/)—a leading digital experience platform—wanted to create a transformative AI tool that would help marketers connect more deeply with their brand assets, driving both consistency and creativity. Using the AI SDK, they launched [Sitecore Stream](https://www.sitecore.com/products/sitecore-stream)—a dynamic, AI-powered brand assistant that empowers marketers to interact with their brand content in visually interactive and conversational ways.

[Sitecore](https://www.sitecore.com/)——领先的数字体验平台——希望打造一款变革性的 AI 工具，帮助营销人员更深入地连接其品牌资产，从而同时提升品牌一致性与创意表现力。借助 AI SDK，他们推出了 [Sitecore Stream](https://www.sitecore.com/products/sitecore-stream)——一款动态、AI 驱动的品牌助手，赋能营销人员以视觉化、交互式及对话式的方式与其品牌内容进行互动。

![](images/using-the-ai-sdk-to-build-sitecore-stream_s-ai-powered-brand-aware-assistant-ver/img_001.jpg)

## Looking to Vercel for AI

## 借力 Vercel 构建 AI 应用

> “We began our search by evaluating various AI SDKs on the market, like LangChain, Semantic Kernel, and Prompt Flow. While these focused heavily on backend AI capabilities, they didn't emphasize the frontend experience—I like to use the term 'UI for AI.' In contrast, the AI SDK by Vercel offered a seamless integration of AI with front-end user experience. For us, this was crucial, as we wanted to prioritize both AI performance and how users interact with it.”
>
> “我们最初通过评估市场上各类 AI SDK（如 LangChain、Semantic Kernel 和 Prompt Flow）开启选型工作。这些工具高度聚焦于后端 AI 能力，却未充分重视前端用户体验——我倾向于将这一关键维度称为‘AI 的用户界面（UI for AI）’。相比之下，Vercel 推出的 AI SDK 实现了 AI 功能与前端用户体验的无缝融合。对我们而言，这一点至关重要：我们既追求 AI 自身的卓越性能，也高度重视用户与 AI 交互的实际体验。”
>
> ![](images/using-the-ai-sdk-to-build-sitecore-stream_s-ai-powered-brand-aware-assistant-ver/img_002.png)
>
> **Mo Cherif,** Senior Director Generative AI  
> **Mo Cherif**，生成式 AI 高级总监

### The power of the AI SDK

### AI SDK 的强大能力

The [AI SDK](https://sdk.vercel.ai/) helps developers build interactive, AI-driven applications, offering tools and components designed to simplify development workflows. Sitecore's brand assistant uses Python on the backend, Next.js on the frontend, and the AI SDK to bring them together, leveraging real-time streaming to deliver fast responses that feel immediate and engaging.

[AI SDK](https://sdk.vercel.ai/) 旨在帮助开发者构建交互式、AI 驱动的应用程序，提供一系列专为简化开发流程而设计的工具与组件。Sitecore 的品牌助手采用 Python 构建后端、Next.js 构建前端，并借助 AI SDK 将二者有机整合；同时利用实时流式传输技术，实现快速响应，带来即时、沉浸的交互体验。

[**Deploy a Next.js and Python template**\\
\\
Export how to use streaming chat completions from a Python endpoint (FastAPI) and display them using the useChat hook in your Next.js application.\\
\\
Try it out](https://vercel.com/templates/next.js/ai-sdk-python-streaming)

[**部署 Next.js 与 Python 模板**  
\\  
演示如何从 Python 后端接口（FastAPI）调用流式聊天补全（streaming chat completions），并在 Next.js 应用中通过 `useChat` Hook 展示结果。  
\\  
立即试用](https://vercel.com/templates/next.js/ai-sdk-python-streaming)

With the AI SDK’s pre-built elements, like the [`useChat` hook](https://sdk.vercel.ai/docs/ai-sdk-ui/chatbot) and [object generation](https://sdk.vercel.ai/docs/ai-sdk-ui/object-generation) capabilities, Sitecore’s development team could focus on crafting unique brand-driven interactions quickly:

借助 AI SDK 提供的开箱即用功能——例如 [`useChat` Hook](https://sdk.vercel.ai/docs/ai-sdk-ui/chatbot) 和 [对象生成（object generation）](https://sdk.vercel.ai/docs/ai-sdk-ui/object-generation) 能力——Sitecore 的开发团队得以迅速聚焦于打造独具品牌特色的交互体验：

- Chat AI is integrated into the design or layout with minimal effort  

- 仅需极少工作量，即可将 Chat AI 集成到设计或布局中  

- All the messages from the AI provider are streamed to the chat UI in real-time  

- AI 服务提供商发送的所有消息均实时流式传输至聊天用户界面  

- The hook manages the states for input, messages, loading, error, and more  

- 该 Hook 统一管理输入、消息、加载状态、错误及其他相关状态  

This allowed them to build a robust, full-featured application without getting bogged down by the complexities of implementing AI.  

这使他们得以构建一个功能完备、稳健可靠的程序，同时避免陷入 AI 实现的复杂细节之中。

The AI SDK was instrumental in achieving Sitecore's vision for the brand assistant by enabling visually interactive experiences. With server-side rendering and streaming, Sitecore Stream can handle high volumes of data with ease, delivering responses that provide immediate feedback—essential for a good user experience. The SDK's ability to manage complex data streaming between Azure-hosted backends and Next.js frontends allowed Sitecore to rapidly build the brand assistant, meeting both their technical and timeline requirements.  

AI SDK 在实现 Sitecore 品牌助手愿景的过程中发挥了关键作用，赋能视觉化、强交互的用户体验。依托服务端渲染（SSR）与流式响应能力，Sitecore Stream 可轻松应对海量数据处理，即时返回响应——而这正是优质用户体验不可或缺的一环。SDK 对 Azure 托管后端与 Next.js 前端之间复杂数据流的高效管理能力，助力 Sitecore 快速构建品牌助手，圆满达成其技术目标与项目时间节点要求。

### A conversational UI for brand storytelling  

### 面向品牌叙事的对话式用户界面  

The brand assistant allows marketers to ask questions, brainstorm ideas, and generate content in real-time. For example, a marketer can ask for suggestions on visual assets or content ideas aligned with the brand's tone of voice, and the assistant responds with text, images, and even content previews. It’s an interactive and conversational experience where marketers feel like they’re working with a virtual creative partner that understands their brand.  

品牌助手支持营销人员实时提问、头脑风暴并生成内容。例如，营销人员可就视觉素材或契合品牌语调的内容创意寻求建议，助手则以文字、图片乃至内容预览形式即时回应。这是一种高度互动、自然流畅的对话式体验——营销人员仿佛正与一位深谙其品牌内涵的虚拟创意伙伴协同工作。

![](images/using-the-ai-sdk-to-build-sitecore-stream_s-ai-powered-brand-aware-assistant-ver/img_003.jpg)

![](images/using-the-ai-sdk-to-build-sitecore-stream_s-ai-powered-brand-aware-assistant-ver/img_003.jpg)

This rich interactivity is powered by agent-based models, tailored to retain Sitecore’s customer's brand knowledge and tone. The friendly UI provides marketers with an environment, making AI accessible regardless of technical expertise.  

这一丰富交互体验由基于智能体（agent-based）的模型驱动，专为持续保留 Sitecore 客户的品牌知识与语调而定制。亲和友好的用户界面为营销人员营造出低门槛环境，让 AI 技术触手可及，无论其是否具备技术背景。

### Build towards a future of modular, scalable AI  

### 迈向模块化、可扩展 AI 的未来

Sitecore envisions a future where their clients can use features like brainstorming or finding visual assets, each requiring unique user experiences. For example, brainstorming and content creation with AI involve very different workflows. With the AI SDK, the team can easily render multiple interactive widgets on the server and push them to the client, to deliver custom-tailored experiences.

Sitecore 展望一个未来：其客户能够使用头脑风暴、查找视觉素材等功能，而每一项功能都需要独特且差异化的用户体验。例如，借助 AI 进行头脑风暴与内容创作所涉及的工作流截然不同。借助 AI SDK，开发团队可轻松在服务端渲染多个交互式组件，并将其推送至客户端，从而交付高度定制化的体验。

In choosing the AI SDK, Sitecore has laid the foundation for a future where AI-powered brand interaction is intuitive and deeply integrated with the unique needs of each brand. With the brand assistant, Sitecore is not only delivering an innovative product; they're setting a new standard for AI in digital marketing.

通过选择 AI SDK，Sitecore 为未来奠定了坚实基础——在这个未来中，AI 驱动的品牌互动将变得直观自然，并深度契合每个品牌的个性化需求。凭借品牌助手（Brand Assistant），Sitecore 不仅推出了一款创新产品，更重新定义了数字营销领域中人工智能的应用标准。

[**Unlock rapid AI development**\\
\\
Build AI-powered applications with the AI SDK. \\
\\
Get started with the AI SDK](https://sdk.vercel.ai/docs/introduction#vercel-ai-sdk)

[**释放 AI 快速开发潜能**\\
\\
使用 AI SDK 构建 AI 驱动的应用程序。\\
\\
立即开始使用 AI SDK](https://sdk.vercel.ai/docs/introduction#vercel-ai-sdk)
&#123;% endraw %}
