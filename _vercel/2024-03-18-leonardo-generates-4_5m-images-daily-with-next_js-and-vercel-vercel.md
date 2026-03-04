---
title: "Leonardo generates 4.5M images daily with Next.js and Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/leonardo-ai-performantly-generates-4-5-million-images-daily-with-next-js-and-vercel"
date: "2024-03-18"
scraped_at: "2026-03-02T09:46:44.940289845+00:00"
language: "en-zh"
translated: true
description: "Learn how Leonardo.Ai leveraged Vercel to reduce build times, speed up page performance, and improve their developer experience."
---
&#123;% raw %}

Mar 18, 2024

2024年3月18日

Learn how Leonardo.Ai leveraged Vercel to fine-tune performance in the face of rapid scale.

了解 Leonardo.Ai 如何借助 Vercel，在业务迅猛扩张的同时优化性能。

#### 2-minute

#### 2 分钟

Build times

构建时间

#### 95%

#### 95%

Reduction in page load times

页面加载时间降低幅度

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

[**Powered by** AWS](https://vercel.com/partners/aws)

[**由** AWS **提供支持**](https://vercel.com/partners/aws)

Generating more than 4.5 million images a day, [Leonardo.ai](https://leonardo.ai/?utm_source=google&utm_medium=paidsearch&utm_campaign=bl_search_branded_us&utm_content=paid-search-rsa&utm_term=branded&gad_source=1&gclid=CjwKCAiAibeuBhAAEiwAiXBoJDRJ9yp95efrWj8goARlSEggmmV3qOFMCcwrVQa3wawlIXkIUb2BZRoCP5gQAvD_BwE) merges artificial intelligence with creativity to transform content creation across industries like gaming, marketing, and design.

Leonardo.ai 每天生成超 450 万张图像，将人工智能与创意深度融合，重塑游戏、营销、设计等行业的内容创作方式。

The platform enables users to fine-tune AI models for generating customized, style-consistent assets. Initially aimed at game developers, Leonardo.Ai has broadened its scope, empowering artists and professionals to leverage AI for streamlining workflows, and expanding the capabilities of AI in creative work.

该平台支持用户微调 AI 模型，以生成高度定制化、风格统一的数字资产。最初面向游戏开发者打造，Leonardo.ai 已逐步拓展服务范围，赋能艺术家与各领域专业人士，借助 AI 简化工作流程，并持续拓展 AI 在创意工作中的应用边界。

## **Navigating growth and technical scalability**

## **应对增长与技术可扩展性挑战**

Leonardo.Ai's rapid growth in the last year also brought significant technical challenges.

过去一年，Leonardo.Ai 的迅猛增长也带来了严峻的技术挑战。

With over 100,000 sign-ups in early 2023, and 200,000 more waiting to be onboarded, the platform faced challenges in development cycles, maintaining system stability, and delivering performance at scale with their original solution. On this setup, Leonardo.Ai experienced long outages and 60-second load times due to pages not being properly cached.

截至 2023 年初，平台注册用户已超 10 万人，另有 20 万人正排队等待接入。在原有架构下，Leonardo.Ai 面临开发周期拉长、系统稳定性难以保障、以及大规模场景下性能交付乏力等多重挑战；页面缓存机制不完善更直接导致了长时间服务中断及高达 60 秒的页面加载延迟。

With an increasing user base and the continuous introduction of new features, Leonardo.Ai needed a solution that could keep pace with their innovation while providing a seamless experience for creators using their platform.

随着用户基数持续扩大及新功能不断上线，Leonardo.Ai 急需一个既能跟上其创新节奏、又能为平台创作者提供无缝体验的技术解决方案。

> “Switching to Vercel transformed our workflow at Leonardo.Ai, cutting build times from 10 minutes to just 2 minutes. Vercel didn't just speed us up; it changed how we innovate.Switching to Vercel transformed our workflow at Leonardo.Ai, cutting build times from 10 minutes to just 2 minutes. Vercel didn't just speed us up; it changed how we innovate.”
>
> “迁移到 Vercel 彻底重塑了 Leonardo.Ai 的工作流——构建时间从 10 分钟缩短至仅 2 分钟。Vercel 不仅提升了我们的速度，更从根本上改变了我们的创新方式。”
>
> ![](images/leonardo-generates-4_5m-images-daily-with-next_js-and-vercel-vercel/img_001.jpg)
>
> **Peter Runham,** Co-Founder & CTO
>
> **彼得·伦纳姆（Peter Runham）**，联合创始人兼首席技术官

## **Reprioritizing the developer experience**

## **重新聚焦开发者体验**

After an extensive evaluation process, Leonardo.Ai’s decision to move their web app to Vercel was driven in large part by the platform's clear DX strengths over their previous solution.

经过全面评估，Leonardo.Ai 最终决定将 Web 应用迁移至 Vercel，这一决策很大程度上源于 Vercel 在开发者体验（DX）方面相较原有方案所展现出的显著优势。

Vercel’s collaborative capabilities, such as [Preview Deployments](https://vercel.com/docs/deployments/preview-deployments), have markedly improved team efficiency by streamlining the feedback loop, making it easier for stakeholders to collaborate and test new features. This has contributed to major boosts in iteration optimization.

Vercel 提供的协作能力（例如 [预览部署（Preview Deployments）](https://vercel.com/docs/deployments/preview-deployments)）显著提升了团队效率：通过简化反馈闭环，使各相关方更便捷地协同工作并测试新功能，从而大幅优化了迭代流程。

Previously struggling with **build times of more than 10 minutes**, the shift to Vercel has **reduced this to as little as 2 minutes.** This acceleration has not only sped up deployment, but also significantly reduced the overall time to market, **enabling Leonardo.Ai to iterate and launch new products in just 1–4 weeks**—a stark contrast to the months they spent previously.

此前，构建耗时常常**超过 10 分钟**；而迁移至 Vercel 后，该指标已**压缩至最短仅需 2 分钟**。这一提速不仅加快了部署节奏，更显著缩短了整体上市周期——**使 Leonardo.Ai 能够在短短 1–4 周内完成产品迭代与发布**，相较此前动辄数月的周期形成鲜明对比。

Vercel utilizes AWS Bedrock's managed foundation models to enhance their AI-powered development tools and services, delivering scalable generative AI capabilities that help developers build and deploy applications more efficiently across their platform.

Vercel 利用 AWS Bedrock 托管的基础模型，强化其 AI 驱动的开发工具与服务，提供可扩展的生成式 AI 能力，助力开发者在其平台上更高效地构建与部署应用。

Additionally, the use of [Vercel Monitoring](https://vercel.com/docs/observability/monitoring) has enhanced Leonardo.Ai's ability to swiftly identify and resolve issues in serverless functions. With real-time insights into application performance, the team can quickly address issues before they impact users.

此外，通过使用 [Vercel Monitoring](https://vercel.com/docs/observability/monitoring)，Leonardo.Ai 大幅提升了在无服务器函数中快速识别与解决问题的能力。借助对应用性能的实时洞察，团队能够在问题影响用户之前迅速响应并修复。

## **Focused creativity through performance and reliability**

## **依托卓越性能与可靠性，专注创意本身**

Since adopting Vercel, Leonardo.Ai has **reduced page load times by 95%** with superior caching functionality and an efficient content delivery network. As such, a more responsive and reliable site has directly improved user experience.

自采用 Vercel 以来，Leonardo.Ai 凭借出色的缓存功能和高效的 CDN（内容分发网络），将页面加载时间**缩短了 95%**。由此带来的更快速、更稳定的网站体验，直接提升了用户体验。

With Vercel, Leonardo.Ai successfully addressed key challenges in development, stability, and performance, enabling the team to concentrate on creating new AI technologies and workflows that transform creative processes across industries. The partnership with Vercel emphasizes Leonardo.Ai's commitment to delivering a robust, user-friendly platform that empowers creators and innovators worldwide.

借助 Vercel，Leonardo.Ai 成功应对了开发效率、系统稳定性与性能优化等关键挑战，使团队得以专注于研发新一代人工智能技术与工作流，从而重塑各行业的创意生产方式。此次与 Vercel 的合作，彰显了 Leonardo.Ai 致力于打造强大、易用平台的坚定承诺——该平台将持续赋能全球创作者与创新者。
&#123;% endraw %}
