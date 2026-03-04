---
title: "AI agents at scale: Rox’s Vercel-powered revenue operating system - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/ai-agents-at-scale-roxs-vercel-powered-revenue-operating-system"
date: "2025-09-16"
scraped_at: "2026-03-02T09:28:28.326166652+00:00"
language: "en-zh"
translated: true
description: "Learn more about how Rox runs global, AI-driven sales ops on fast, reliable infrastructure thanks to Vercel"
---
{% raw %}

Sep 16, 2025

2025 年 9 月 16 日

[Rox](https://www.rox.com/) 正在构建下一代营收操作系统。通过部署智能 AI 代理——这些代理可代表销售团队开展市场调研、客户挖掘与互动沟通——Rox 帮助企业更快速地管理并增长营收。

自创立第一天起，Rox 就将全部应用构建于 Vercel 平台之上。依托 Vercel 的基础设施支撑其 Web 应用，Rox 实现了更快的交付速度、全球范围的弹性扩展，并为每一位客户持续提供高速流畅的使用体验。

## **借助 Vercel 实现更快速执行**

## **借助 Vercel 实现更快速执行**

对 Rox 而言，速度即优势。团队每周都发布新功能，因此亟需一套不会拖慢开发节奏的基础设施。Vercel 让他们得以专注于产品构建，同时稳定、高效地规模化运行其 Next.js 应用。

全球性能表现是另一项关键考量因素。由于客户遍布中东、欧洲及更广泛地区，Rox 需要一套能确保跨地域一致高速响应的基础设施。Vercel 的[边缘网络与 CDN](https://vercel.com/docs/cdn)天然覆盖全球，无需额外配置即可满足这一需求。

与速度同等重要的是开发者体验。从环境配置到问题调试，Vercel 提供的一整套开发者体验工具，使 Rox 的工程师得以大幅减少在基础设施上的投入，转而将更多精力投入到核心功能开发中。图像优化、无服务器缓存以及[预览环境](https://vercel.com/docs/deployments/environments)等功能，赋予团队快速迭代的信心，实现低开销、高效率的发布流程。

如今，前端部署仅需 3–5 分钟（快到足以在客户演示前即时推送更新），而构建后钩子（post-build hooks）则让团队能以极简配置，在预览环境中轻松运行端到端测试。

> “Vercel 在技术生态中享有极高的声誉。所有交付速度最快的工程团队，都在使用 Vercel 托管其 Web 应用。”  
>  
> ![](images/ai-agents-at-scale-rox_s-vercel-powered-revenue-operating-system-vercel/img_001.png)  
>  
> **Jerry Zhou**，Rox 软件工程师

## **借助无服务器函数规模化运行 AI 工作流**

## **借助无服务器函数规模化运行 AI 工作流**

A core capability of Rox’s Revenue OS is instantaneous research across thousands of prospects. Rox spins up hundreds to thousands of AI agents that analyze companies in real time.

Rox Revenue OS 的一项核心能力，是对成千上万个潜在客户进行即时调研。Rox 启动数百至数千个 AI 智能体，实时分析企业信息。

This creates a technical challenge: most browsers are constrained to executing 100 concurrent calls with HTTP/2.

这带来了一个技术挑战：大多数浏览器在使用 HTTP/2 协议时，并发请求数被限制在 100 个以内。

![The old way of managing requests: scaled linearly to the number of entities and and requests would often stall. ](images/ai-agents-at-scale-rox_s-vercel-powered-revenue-operating-system-vercel/img_002.jpg)![The old way of managing requests: scaled linearly to the number of entities and and requests would often stall. ](images/ai-agents-at-scale-rox_s-vercel-powered-revenue-operating-system-vercel/img_003.jpg)

![传统请求管理方式：请求数量随实体数量线性增长，经常导致请求停滞。](images/ai-agents-at-scale-rox_s-vercel-powered-revenue-operating-system-vercel/img_002.jpg)![传统请求管理方式：请求数量随实体数量线性增长，经常导致请求停滞。](images/ai-agents-at-scale-rox_s-vercel-powered-revenue-operating-system-vercel/img_003.jpg)

The old way of managing requests: scaled linearly to the number of entities and and requests would often stall.

传统请求管理方式：请求数量随实体数量线性增长，经常导致请求停滞。

To avoid stalled requests, Rox uses [Vercel Serverless Functions](https://vercel.com/docs/functions) to batch these calls and stream results back to the client.

为避免请求停滞，Rox 利用 [Vercel 无服务器函数（Serverless Functions）](https://vercel.com/docs/functions) 对这些请求进行批量处理，并将结果流式传输回客户端。

The result is a faster, more consistent experience. Whether it’s a team in Dubai or an enterprise in London, Rox users receive research results in seconds, powered by Vercel’s global network and caching.

最终实现了更快、更稳定一致的用户体验。无论是在迪拜的团队，还是在伦敦的企业，Rox 用户均可在数秒内获得调研结果——这一切由 Vercel 的全球网络与缓存能力提供支持。

![Now: Batching requests with Vercel Serverless](images/ai-agents-at-scale-rox_s-vercel-powered-revenue-operating-system-vercel/img_004.jpg)![Now: Batching requests with Vercel Serverless](images/ai-agents-at-scale-rox_s-vercel-powered-revenue-operating-system-vercel/img_005.jpg)

![现在：借助 Vercel 无服务器函数实现请求批处理](images/ai-agents-at-scale-rox_s-vercel-powered-revenue-operating-system-vercel/img_004.jpg)![现在：借助 Vercel 无服务器函数实现请求批处理](images/ai-agents-at-scale-rox_s-vercel-powered-revenue-operating-system-vercel/img_005.jpg)

Now: Batching requests with Vercel Serverless

现在：借助 Vercel 无服务器函数实现请求批处理

## **Conversational AI with the Vercel AI SDK**

## **基于 Vercel AI SDK 的对话式 AI**

Rox also uses the [Vercel AI SDK](https://ai-sdk.dev/) to power Rox Command, Rox’s new chat-driven interface that lets users ask questions and take actions - such as pulling up a summary of all interactions with a prospect or generating a draft for an outreach email.

Rox 还采用 [Vercel AI SDK](https://ai-sdk.dev/) 来驱动 Rox Command —— Rox 全新推出的、以聊天为交互范式的界面。用户可通过该界面提问并执行各类操作，例如调取与某位潜在客户的全部互动摘要，或自动生成外联邮件初稿。

AI SDK makes it simple to stream responses from large language models, enabling Rox to deliver responsive, conversational AI experiences directly in the browser.

AI SDK 让流式传输大型语言模型的响应变得简单，使 Rox 能够直接在浏览器中提供响应迅速、自然流畅的对话式 AI 体验。

With Preview Deployments with comments, Rox could rapidly review new features in production-like environments. This accelerated their product feedback cycles and made it possible to ship Rox Command in weeks rather than months.

借助支持评论功能的预览部署（Preview Deployments），Rox 能够在类生产环境中快速评审新功能。这显著加快了产品反馈周期，并使其得以在数周而非数月内上线 Rox Command。

![Rox's Command tool helps perform deep research and take revenue-driving actions, built with the AI SDK.](images/ai-agents-at-scale-rox_s-vercel-powered-revenue-operating-system-vercel/img_006.jpg)![Rox's Command tool helps perform deep research and take revenue-driving actions, built with the AI SDK.](images/ai-agents-at-scale-rox_s-vercel-powered-revenue-operating-system-vercel/img_007.jpg)

![Rox 的 Command 工具借助 AI SDK 构建，可助力深度研究并执行驱动营收的操作。](images/ai-agents-at-scale-rox_s-vercel-powered-revenue-operating-system-vercel/img_006.jpg)![Rox 的 Command 工具借助 AI SDK 构建，可助力深度研究并执行驱动营收的操作。](images/ai-agents-at-scale-rox_s-vercel-powered-revenue-operating-system-vercel/img_007.jpg)

Rox's Command tool helps perform deep research and take revenue-driving actions, built with the AI SDK.

Rox 的 Command 工具借助 AI SDK 构建，可助力深度研究并执行驱动营收的操作。

By building on Vercel, Rox has improved its pace of innovation while ensuring global performance and reliability:

依托 Vercel 构建，Rox 在提升创新速度的同时，也保障了全球范围内的性能与可靠性：

- 3-5 minute deploys, enabling hotfixes and features to go live even right before customer demos

- 部署耗时仅需 3–5 分钟，支持热修复与新功能即时上线——甚至可在客户演示前最后一刻完成发布

- 2.5x reduction in P95 load speed

- P95 页面加载速度提升 2.5 倍

- Rox Command feature shipped in weeks, not months, thanks to Preview Deployments and daily reviews that accelerated iteration.

- 得益于预览部署与每日评审机制对迭代过程的加速，Rox Command 功能在数周内即完成交付，而非原本所需的数月时间

- Seamless multiregion performance, supporting users from Europe to the Middle East

- 无缝多区域性能表现，为从欧洲到中东的用户提供一致优质体验


For Rox, speed isn’t just a developer convenience, it’s a competitive edge. Their team is rapidly transforming how go-to-market organizations work with AI agents, and we’re thrilled to support their journey.

对 Rox 而言，“速度”绝非仅是开发者的便利工具，而是一项关键的竞争优势。其团队正快速重塑市场部门（Go-to-Market）与 AI 智能体协同工作的方式；我们非常荣幸能够支持他们这一征程。

[**Ship production-grade AI applications faster with Vercel**  
**借助 Vercel 更快地交付生产级 AI 应用**  

Talk to our team to learn more about building AI-powered applications at your organization.  
联系我们的团队，了解如何在您的组织中构建 AI 驱动的应用。

Contact Us  
联系我们](https://vercel.com/contact/sales)
{% endraw %}
