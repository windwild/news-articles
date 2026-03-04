---
title: "How Chatbase scaled rapidly with Vercel's developer experience and AI SDK - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-chatbase-scaled-rapidly-with-vercels-developer-experience-and-ai-sdk"
date: "2024-10-09"
scraped_at: "2026-03-02T09:40:32.588034152+00:00"
language: "en-zh"
translated: true
description: "Scaling rapidly in the AI market with Vercel, Next.js, and the AI SDK "
---
&#123;% raw %}

Oct 9, 2024

2024 年 10 月 9 日

With over 500K visitors per month, Chatbase relies on the AI SDK, caching, and streamlined workflows to stay ahead in the competitive AI market.

每月访客量超 50 万，Chatbase 依托 AI SDK、缓存机制及精简的工作流，在竞争激烈的 AI 市场中始终保持领先。

#### 500K

visitors per month

#### 50 万

每月访客量

#### $4M

ARR in 1.5 years

#### 400 万美元

1.5 年内年经常性收入（ARR）

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

[Chatbase](https://www.chatbase.co/) helps companies build chat-based AI agents that are trained on their data to chat with users and perform tasks. It handles customer support, sales, lead generation, and more.

[Chatbase](https://www.chatbase.co/) 帮助企业构建基于聊天界面的 AI 智能体——这些智能体经客户自有数据训练，可与用户对话并执行各类任务，涵盖客户服务、销售转化、潜在客户获取等场景。

From the beginning, they prioritized building a platform that could move fast in the competitive market. To achieve this, they chose Vercel and Next.js as the tech stack for their app and marketing website, along with Vercel's AI SDK, which enabled them to quickly iterate and deliver AI-driven features.

自创立之初，他们便将“快速响应市场变化”作为平台建设的核心目标。为此，他们选用 Vercel 与 Next.js 作为应用及营销网站的技术栈，并集成 Vercel 的 AI SDK，从而实现 AI 功能的快速迭代与交付。

By prioritizing iteration speed, Chatbase grew to 500K monthly visitors and $4M ARR in 1.5 years. Vercel's developer experience (DX) allows the team to focus on innovation, not infrastructure. The AI SDK enables rapid implementation of custom chats and model optimizations.

凭借对迭代速度的高度重视，Chatbase 在短短 1.5 年内即实现月访问量达 50 万、年经常性收入（ARR）达 400 万美元。Vercel 卓越的开发者体验（DX）使团队得以专注于创新，而非底层基础设施运维；而 AI SDK 则助力其高效实现定制化聊天功能与模型优化。

### The perfect tech stack for building AI apps

### 构建 AI 应用的理想技术栈

- **AI SDK:** Vercel 推出的 [AI SDK](https://sdk.vercel.ai/) 在构建 Chatbase 的 AI 沙盒（AI playground）过程中发挥了关键作用。每个聊天实例均可配置不同的模型与参数，使用户能够灵活尝试多种聊天机器人配置。这直接促成了其 **LLM 对比模式（LLM Compare Mode）** 的上线——用户可通过调整模型、温度（temperature）、系统提示（system messages）等参数，对比不同大语言模型（LLM）在 RAG 聊天机器人场景下的表现。得益于 AI SDK 快速切换模型的能力，Chatbase 用户可针对特定用例优化聊天机器人配置。

展示 Chatbase LLM 对比模式的视频。

- **渲染灵活性（Rendering flexibility）:** Chatbase 将其营销网站与 Web 应用托管在同一代码仓库中，并借助 Vercel 高效统一管理二者：静态页面经优化以实现高速加载与良好 SEO；而应用部分则结合服务端渲染（SSR）与客户端渲染（CSR），在保障个性化体验的同时不牺牲性能。最终，[Next.js 的 App Router](https://nextjs.org/docs/app) 提供了直观易用的机制，用于精细控制静态与动态渲染组件。

- **Vercel 防火墙（Vercel Firewall）:** Vercel 的安全基础设施（包括 [Firewall](https://vercel.com/docs/security/vercel-firewall)）为 Chatbase 的 AI 应用提供了关键防护能力，有效[防范代价高昂的 DDoS 攻击](https://vercel.com/blog/preventing-infrastructure-abuse-with-vercel-firewall)，同时确保服务稳定可靠。

- **版本偏移防护（Skew Protection）:** Vercel 保障服务端与客户端代码间的平滑同步，彻底消除版本偏移（version skew），从而提升开发流程效率。借助 [Skew Protection](https://vercel.com/docs/deployments/skew-protection#skew-protection)，Chatbase 可确保终端用户在生产环境中不会遭遇任何因版本不一致引发的问题。

- **Next.js 原生支持:** 凭借 Vercel 对 Next.js 的深度支持，Chatbase 充分利用其内置缓存机制与[流式响应（streaming）](https://nextjs.org/docs/app/building-your-application/routing/loading-ui-and-streaming)能力，向用户提供极速响应——这两项特性对 AI 驱动型应用而言至关重要。

### Current architecture and benefits

### 当前架构及优势

Chatbase 采用主干开发（trunk-based development）模式：拉取请求（pull request）持续合入主分支（main branch），而该分支直接关联生产环境。对于新功能开发，工程师创建独立分支，并借助 [预览部署（Preview Deployments）](https://vercel.com/docs/deployments/preview-deployments) 进行测试与协作。

当前架构与渲染策略带来了多项优势：静态内容加载迅捷，动态模块渲染流畅，整体显著提升了用户体验。

Vercel’s infrastructure also ensures stability, even during traffic spikes—crucial for an AI startup that often experiences sudden attention from feature launches or social media buzz. Features like [Instant Rollbacks](https://vercel.com/docs/deployments/instant-rollback) and the ability to disable auto-assigning production domains make the deployment process more flexible, reliable, and stress-free for the development team.

Vercel 的基础设施还能确保系统稳定性，即使在流量激增期间亦然——这对一家常因新功能发布或社交媒体热议而突然获得大量关注的 AI 初创公司而言至关重要。[即时回滚（Instant Rollbacks）](https://vercel.com/docs/deployments/instant-rollback) 等功能，以及禁用生产环境域名自动分配的能力，使部署流程对开发团队而言更加灵活、可靠且轻松无忧。

Overall, Vercel has been instrumental in helping Chatbase move quickly, innovate, and scale effectively, enabling them in maintaining rapid growth.

总体而言，Vercel 在助力 Chatbase 快速推进、持续创新并高效扩展方面发挥了关键作用，从而支撑其保持高速增长。

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
