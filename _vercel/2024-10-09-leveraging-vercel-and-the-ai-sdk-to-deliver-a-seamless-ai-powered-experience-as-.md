---
title: "Leveraging Vercel and the AI SDK to deliver a seamless, AI-powered experience as a solo founder - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/leveraging-vercel-and-the-ai-sdk-to-deliver-a-seamless-ai-powered-experience"
date: "2024-10-09"
scraped_at: "2026-03-02T09:40:36.602946708+00:00"
language: "en-zh"
translated: true
description: "How ChatPRD Scaled to 20,000 users with Vercel and the AI SDK. ChatPRD is an AI co-pilot designed for product managers, enabling them to write product requirements documents, brainstorm roadmaps, and ..."
---

render_with_liquid: false
Oct 9, 2024

2024 年 10 月 9 日

Learn how ChatPRD scaled to 20,000 users in just a few months, using the Vercel stack to maintain developer velocity.

了解 ChatPRD 如何仅用数月时间便将用户规模扩展至 20,000，同时依托 Vercel 技术栈持续保障开发效率。

#### 9 months

#### 9 个月

from MVP to market

从最小可行产品（MVP）走向市场

#### 20,000

#### 20,000

active users since launch

自上线以来的活跃用户数

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

[ChatPRD](https://www.chatprd.ai/) is an AI co-pilot designed for product managers, enabling them to write product requirements documents, brainstorm roadmaps, and improve overall efficiency around product work. As a solo founder, [Claire Vo](https://x.com/clairevo) built ChatPRD from the ground up. In just nine months, the platform has garnered 20,000 users and is now focusing on expanding its features to support team collaboration.

[ChatPRD](https://www.chatprd.ai/) 是一款专为产品经理打造的 AI 协同助手，可协助撰写产品需求文档（PRD）、头脑风暴产品路线图，并全面提升产品相关工作的整体效率。作为独立创始人，[Claire Vo](https://x.com/clairevo) 从零开始构建了 ChatPRD。仅用九个月时间，该平台便已吸引 20,000 名用户，目前正着力拓展功能，以更好支持团队协作。

Central to this rapid growth and development has been the [AI SDK](https://sdk.vercel.ai/) on Vercel.

推动这一快速增长与高效开发的核心，是 Vercel 提供的 [AI SDK](https://sdk.vercel.ai/)。

![](images/leveraging-vercel-and-the-ai-sdk-to-deliver-a-seamless-ai-powered-experience-as-/img_001.jpg)

## **Challenges as a solo founder**

## **作为独立创始人的挑战**

Building a product from scratch as a solo founder presents unique challenges, especially when aiming to create a highly efficient, performant, and user-friendly application.  
作为独立创始人从零开始打造一款产品，面临诸多独特挑战——尤其是当目标是构建一款高效、高性能且用户体验友好的应用时。

For ChatPRD, one of the key hurdles was implementing advanced AI capabilities without getting bogged down in the complexities of model integration, latency issues, and the overall user experience. Claire needed a solution that would allow her to focus on building the product's core functionalities.  
对 ChatPRD 而言，关键难点之一在于实现先进的 AI 功能，同时避免陷入模型集成复杂性、延迟问题以及整体用户体验优化的泥潭。Claire 需要一个能让她专注开发产品核心功能的解决方案。

## **Vercel and the AI SDK**

## **Vercel 与 AI SDK**

Vercel is the backbone of ChatPRD's infrastructure. By leveraging Vercel, Claire was able to deploy and host ChatPRD without having to worry about infrastrcuture, allowing her to concentrate on building the product. Additionally, Vercel’s logging and high-level monitoring tools provided just enough insight to keep things running smoothly without overwhelming her with unnecessary details.  
Vercel 构成了 ChatPRD 基础设施的核心支柱。借助 Vercel，Claire 无需操心底层基础设施，即可轻松完成 ChatPRD 的部署与托管，从而将全部精力集中于产品开发本身。此外，Vercel 提供的日志记录与高层级监控工具，恰到好处地提供了运行状态洞察，既保障系统平稳运行，又不会因冗余细节而令她不堪重负。

The real productivity gains came from the AI SDK. ChatPRD's core functionality relies heavily on AI-driven assistance and tools, utilizing [GPT-4 Omni](https://sdk.vercel.ai/providers/ai-sdk-providers/openai) as its primary model. The Vercel AI SDK provided a developer-friendly wrapper that simplified the implementation of [streaming responses](https://sdk.vercel.ai/docs/foundations/streaming) and streaming UI components—key features that significantly improved the perceived user experience by reducing latency. Specifically, ChatPRD uses the streaming features of the AI SDK to let users import a PDF or document, parse it with an LLM, and output into a structured template (JSON) that can be used in other chats to generate docs.  
真正的效率提升源自 AI SDK。ChatPRD 的核心功能高度依赖 AI 驱动的辅助能力与工具，其主模型采用 [GPT-4 Omni](https://sdk.vercel.ai/providers/ai-sdk-providers/openai)。Vercel AI SDK 提供了一个面向开发者的友好封装，大幅简化了[流式响应](https://sdk.vercel.ai/docs/foundations/streaming)及流式 UI 组件的实现——这些关键特性通过降低感知延迟，显著提升了用户体验。具体而言，ChatPRD 利用 AI SDK 的流式功能，支持用户上传 PDF 或其他文档，交由大语言模型（LLM）解析，并输出为结构化模板（JSON），该模板可被复用于其他对话中，以自动生成各类文档。

[**Try for yourself**\\  
\\  
This template gives you an application that converts text inputs into structured objects and streams the expense as it’s being processed using the AI SDK by Vercel.\\  
\\  
Get started](https://vercel.com/templates/next.js/use-object)  

[**亲自体验一下**\\  
\\  
该模板提供一个应用程序：它将文本输入转换为结构化对象，并在处理过程中利用 Vercel 的 AI SDK 实时流式输出结果（例如费用明细）。\\  
\\  
立即上手](https://vercel.com/templates/next.js/use-object)

Claire highlighted that without the Vercel AI SDK, implementing these capabilities would have required building a lot of additional infrastructure to handle streaming and generative UI components. The SDK abstracted this complexity, making it easier to deploy and iterate on the product, ultimately accelerating ChatPRD’s time to market.  
Claire 特别指出：若没有 Vercel AI SDK，实现上述功能将不得不自行搭建大量额外基础设施，以支撑流式传输与生成式 UI 组件。而该 SDK 将这些复杂性进行了抽象封装，极大简化了部署与产品迭代流程，最终显著缩短了 ChatPRD 的上市周期。

> “Perceived (low) latency is one of the killer features of the chat. Once I implemented streaming with the AI SDK, user satisfaction went up as well as sign ups. It had a measurable impact on our business. Perceived (low) latency is one of the killer features of the chat. Once I implemented streaming with the AI SDK, user satisfaction went up as well as sign ups. It had a measurable impact on our business.”  
>   
> “感知（低）延迟是聊天功能的一大杀手级特性。自从我借助 AI SDK 实现流式响应后，用户满意度与注册量双双提升，对公司业务产生了可衡量的积极影响。”

> ![](images/leveraging-vercel-and-the-ai-sdk-to-deliver-a-seamless-ai-powered-experience-as-/img_002.png)  
>   
> **Claire Vo,** Founder of ChatPRD  
>   
> **Claire Vo**，ChatPRD 创始人

## **The results and next steps for ChatPRD**

## **ChatPRD 的成果与后续规划**

The combination of Vercel's platform and the Vercel AI SDK enabled Claire to build ChatPRD quickly and confidently. The product’s AI-driven features, particularly the streaming and generative UI components, have delivered a "wow" experience for users, contributing to its rapid adoption and growth.  
Vercel 平台与 Vercel AI SDK 的协同组合，使 Claire 能够快速、自信地构建出 ChatPRD。产品中由 AI 驱动的功能——尤其是流式响应与生成式 UI 组件——为用户带来了令人惊叹（“wow”）的体验，有力推动了产品的迅速普及与持续增长。

Leveraging Vercel and the Vercel AI SDK has allowed ChatPRD to scale as a modern SaaS product. For solo founders or small teams, these tools offer the efficiency, performance, and ease of use needed to focus on delivering exceptional user experiences without getting entangled in technical complexities.

借助 Vercel 和 Vercel AI SDK，ChatPRD 作为一款现代化的 SaaS 产品得以顺利扩展。对于独立创始人或小型团队而言，这些工具提供了所需的高效性、高性能与易用性，使其能够专注于打造卓越的用户体验，而无需深陷技术复杂性之中。

[**Unlock rapid AI development**  
**解锁快速 AI 开发**  

Build AI-powered applications with the AI SDK.  
使用 AI SDK 构建 AI 驱动的应用程序。  

Get started with the AI SDK](https://sdk.vercel.ai/docs/introduction#vercel-ai-sdk)  
立即开始使用 AI SDK](https://sdk.vercel.ai/docs/introduction#vercel-ai-sdk)