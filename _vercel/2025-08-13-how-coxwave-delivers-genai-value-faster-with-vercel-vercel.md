---
title: "How Coxwave delivers GenAI value faster with Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-coxwave-delivers-genai-value-faster-with-vercel"
date: "2025-08-13"
scraped_at: "2026-03-02T09:29:57.772657472+00:00"
language: "en-zh"
translated: true
description: "Coxwave's journey to cutting deployment times by 85% and building AI-native products faster with Vercel"
---
{% raw %}

Aug 13, 2025

2025年8月13日

Read more about Coxwave's journey to cutting deployment times by 85% and building AI-native products faster with Vercel

深入了解 Coxwave 如何借助 Vercel 将部署时间缩短 85%，并加速构建 AI 原生产品。

[Coxwave](https://tryalign.ai/) helps enterprises build GenAI products that work at scale. With their consulting arm, AX, and their analytics platform, Align, they support some of the world’s most technically sophisticated companies, including Anthropic, Meta, Microsoft, and PwC.

Coxwave 帮助企业构建可大规模落地的生成式 AI（GenAI）产品。依托其咨询业务线 AX 及分析平台 Align，Coxwave 为全球技术实力最雄厚的企业提供支持，客户包括 Anthropic、Meta、Microsoft 和 PwC。

Since the company’s founding in 2021, speed has been a defining trait. But speed doesn’t just mean fast models. For Coxwave, it means fast iteration, fast validation, and fast value delivery.

自 2021 年创立以来，“速度”始终是 Coxwave 的核心特质。但此处的“速度”并不仅指模型推理快——对 Coxwave 而言，它意味着快速迭代、快速验证，以及快速交付业务价值。

To meet that bar, Coxwave reimagined their web app strategy with Next.js and Vercel.

为达到这一标准，Coxwave 以 Next.js 与 Vercel 重构了其 Web 应用战略。

![Coxwave Align, an analytics platform built specifically for GenAI conversational products, fully running on Vercel. ](images/how-coxwave-delivers-genai-value-faster-with-vercel-vercel/img_001.jpg)![Coxwave Align, an analytics platform built specifically for GenAI conversational products, fully running on Vercel. ](images/how-coxwave-delivers-genai-value-faster-with-vercel-vercel/img_002.jpg)

![专为生成式 AI 对话类产品打造的分析平台 Coxwave Align，已全面运行于 Vercel。](images/how-coxwave-delivers-genai-value-faster-with-vercel-vercel/img_001.jpg)![专为生成式 AI 对话类产品打造的分析平台 Coxwave Align，已全面运行于 Vercel。](images/how-coxwave-delivers-genai-value-faster-with-vercel-vercel/img_002.jpg)

Coxwave Align, an analytics platform built specifically for GenAI conversational products, fully running on Vercel.

Coxwave Align —— 一款专为生成式 AI 对话类产品打造的分析平台，已全面运行于 Vercel。

## From monthly releases to multiple deploys a day

## 从每月一次发布，到每日多次部署

Coxwave’s most pressing challenge is delivering value fast in a constantly shifting market. Traditional deployment cycles and infrastructure setups couldn't keep up.

Coxwave 面临的最紧迫挑战，是在持续变化的市场中快速交付价值。传统的发布周期与基础设施架构已难以跟上节奏。

By choosing the Next.js stack and deploying on Vercel, they created an environment that can keep up with the innovative pace of GenAI.

通过采用 Next.js 技术栈并在 Vercel 上部署，Coxwave 构建起一个能够匹配生成式 AI 创新节奏的开发与交付环境。

Vercel’s [Preview Deployments](https://vercel.com/docs/deployments/environments), built-in CDN, and automatic scaling allow Coxwave to ship confidently and react in real time. Feature testing happens in production-like environments without disrupting live traffic. Hotfixes can be pushed the same day and new experiments can go live within hours.

Vercel 的[预览部署（Preview Deployments）](https://vercel.com/docs/deployments/environments)、内置 CDN 及自动扩缩容能力，使 Coxwave 能够自信地交付产品，并实时响应变化。功能测试在类生产环境中进行，完全不影响线上流量；热修复（hotfix）当天即可上线，新实验功能数小时内即可发布。

The results are concrete:

成果切实可见：

- Deployment times were reduced by 85%

- 部署耗时缩短 85%

- Production deploy frequency jumped from once a week to twice per day

- 生产环境部署频率从每周一次跃升至每日两次

- Experiment-to-feedback cycles shrank dramatically

- 实验到反馈的周期大幅缩短

- 52% decrease in production recovery time with [Instant Rollback](https://vercel.com/docs/instant-rollback)

- 借助 [即时回滚（Instant Rollback）](https://vercel.com/docs/instant-rollback)，生产环境故障恢复时间减少 52%

> “In GenAI, speed and stability are non-negotiable. Vercel’s Preview Environments and rapid deploys let us test in production-like settings and ship features faster, helping us deliver real value to our analytics customers.In GenAI, speed and stability are non-negotiable. Vercel’s Preview Environments and rapid deploys let us test in production-like settings and ship features faster, helping us deliver real value to our analytics customers.”
>
> “在生成式 AI（GenAI）领域，速度与稳定性缺一不可。Vercel 的预览环境（Preview Environments）与快速部署能力，让我们得以在类生产环境中开展测试，并加速功能交付，从而为我们的数据分析客户切实创造价值。”
>
> ![](images/how-coxwave-delivers-genai-value-faster-with-vercel-vercel/img_003.png)
>
> **Yeop Lee,** Head of Product at Coxwave
>
> **Yeop Lee**，Coxwave 产品负责人

For Coxwave, these improvements weren’t just technical. They gave the team room to think, validate, and adapt faster than their competitors locked into slower infrastructure.

对 Coxwave 而言，这些改进远不止于技术层面——它们为团队腾出了更多空间，使其能够比那些受限于缓慢基础设施的竞争对手更快地思考、验证与调整。

## AI-native features, tested in real time

## 原生 AI 功能，实时测试验证

When Coxwave launched Exploration Copilot, their AI assistant for product teams, Vercel made it possible to prototype and release at full speed.

当 Coxwave 推出面向产品团队的 AI 助手——Exploration Copilot 时，Vercel 使其得以全速完成原型开发与正式发布。

![Exploration Copilot, a conversational interface inside of Align, built with the AI SDK on Vercel. ](images/how-coxwave-delivers-genai-value-faster-with-vercel-vercel/img_004.jpg)![Exploration Copilot, a conversational interface inside of Align, built with the AI SDK on Vercel. ](images/how-coxwave-delivers-genai-value-faster-with-vercel-vercel/img_005.jpg)

![Exploration Copilot，Align 内置的对话式界面，基于 Vercel 上的 AI SDK 构建。](images/how-coxwave-delivers-genai-value-faster-with-vercel-vercel/img_004.jpg)![Exploration Copilot，Align 内置的对话式界面，基于 Vercel 上的 AI SDK 构建。](images/how-coxwave-delivers-genai-value-faster-with-vercel-vercel/img_005.jpg)

Exploration Copilot, a conversational interface inside of Align, built with the AI SDK on Vercel.

Exploration Copilot，Align 内置的对话式界面，基于 Vercel 上的 AI SDK 构建。

[Preview Environments](https://vercel.com/docs/deployments/environments) let the team build and test multiple LLM-powered variations in parallel, without any risk to production.

[预览环境（Preview Environments）](https://vercel.com/docs/deployments/environments) 使团队能够并行构建和测试多种由大语言模型（LLM）驱动的版本，且完全不会影响生产环境。

In parallel, the [AI SDK](https://ai-sdk.dev/), with features like the `useChat` hook, gave the team a fast starting point for the conversational functionality, handling streaming, state, and UI updates out of the box, so they could skip boilerplate and get to user feedback faster.

与此同时，[AI SDK](https://ai-sdk.dev/)（提供诸如 `useChat` 钩子等特性）为团队提供了对话功能的快速启动基础：开箱即用地支持流式响应、状态管理与 UI 更新，从而省去大量样板代码，更快获取用户反馈。

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

These tools combined to accelerate their entire cycle: from idea, to prototype, to production-ready product.

这些工具协同作用，显著加速了其完整开发周期：从创意构想到原型验证，再到可投入生产的成熟产品。

## Building without infrastructure drag

## 摆脱基础设施拖累的开发

Before Vercel, Coxwave’s Next.js apps were deployed using CloudFront + S3. That worked for static sites but not for the dynamic, server-rendered needs of modern GenAI apps. Every environment setup required additional overhead and deploying fixes was slow and brittle.

在采用 Vercel 之前，Coxwave 的 Next.js 应用依赖 CloudFront + S3 进行部署。这种方式适用于静态网站，却难以满足现代生成式 AI（GenAI）应用所需的动态性与服务端渲染能力。每次环境搭建都需额外运维开销，而修复问题的部署过程则缓慢且脆弱。

By default, Coxwave now gets consistency between dev and production, simplified team ownership, and serverless compute without the operational load. The frontend team owns the full deployment lifecycle, and every branch gets its own environment for testing.

如今，Coxwave 默认即可获得开发与生产环境的一致性、更清晰的团队职责划分，以及无需运维负担的无服务器计算能力。前端团队全面掌控整个部署生命周期，且每个代码分支均自动拥有独立的测试环境。

### Ship like Coxwave

### 像 Coxwave 一样高效交付

Coxwave plans to continue use of the Vercel and Next.js stack across upcoming projects. The setup has proven its value not just for development velocity, but for customer experience and product confidence.

Coxwave 计划在后续项目中持续采用 Vercel 与 Next.js 技术栈。该技术架构不仅显著提升了开发效率，更切实改善了用户体验，并增强了产品信心。

[**Take the first step towards modernizing your tech stack**  
**迈出您的技术栈现代化第一步**  

Talk to an expert to learn how you can make your website faster and more reliable on Vercel.  
联系专家，了解如何借助 Vercel 让您的网站运行更快、更加可靠。  

Contact Sales](https://vercel.com/contact/sales)  
联系销售](https://vercel.com/contact/sales)
{% endraw %}
