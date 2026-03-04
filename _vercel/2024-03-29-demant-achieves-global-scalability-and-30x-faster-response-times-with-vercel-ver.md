---
title: "Demant achieves global scalability and 30x faster response times with Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/demant-achieves-global-scalability-and-30x-faster-response-times-with-vercel"
date: "2024-03-29"
scraped_at: "2026-03-02T10:48:15.773105773+00:00"
language: "en-zh"
translated: true
description: "Global scalability and 30x faster response times with Vercel"
---
{% raw %}

Mar 29, 2024

2024年3月29日

Learn more about how leading healthcare businesses are using Vercel to serve a global customer base.

了解领先医疗健康企业如何借助 Vercel 服务全球客户。

#### 30x

Faster response times

#### 30 倍

响应速度提升

#### 10x

Reduction in infrastructure cost

#### 10 倍

基础设施成本降低

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

[Demant](https://www.demant.com/), a prominent hearing healthcare and technology group, has been dedicated to improving people's health and hearing since 1904.

丹麦听力保健与科技集团 [Demant](https://www.demant.com/) 自 1904 年创立以来，始终致力于改善人们的健康与听力。

With a mission to offer innovative technologies, solutions, and expertise in the field of hearing care, Demant serves a diverse range of customers around the world. Due to their global nature and ever-growing customer base, the team needed a frontend solution that could scale with them while providing a flawless end user experience.

Demant 致力于在听力保健领域提供创新技术、解决方案与专业能力，服务遍及全球的多元化客户群体。鉴于其业务的全球化特性及持续增长的用户规模，团队亟需一套可随业务同步扩展、同时保障终端用户极致体验的前端解决方案。

![](images/demant-achieves-global-scalability-and-30x-faster-response-times-with-vercel-ver/img_001.jpg)

## **The choice to migrate to Next.js and Vercel**

## **迁移到 Next.js 和 Vercel 的决策**

Before adopting Vercel, Demant faced several challenges with their existing web infrastructure. The traditional CMS setup hosted in Azure required large and complex regional data center setups to facilitate global scaling. Despite significant investments, the setup struggled to deliver satisfying response times, resulting in a poor user experience for visitors to Demant's websites.

在采用 Vercel 之前，Demant 在其现有网络基础设施方面面临诸多挑战。托管于 Azure 的传统 CMS 架构需要大规模、高复杂度的区域性数据中心部署，才能支持全球扩展。尽管投入了大量资源，该架构仍难以提供令人满意的响应速度，导致访问 Demant 网站的用户获得较差的体验。

Recognizing the need for a more scalable and performant solution, Demant embarked on a journey to adopt a headless setup, isolating their frontend from the CMS runtime. This approach aimed to mitigate scaling and performance issues while maintaining cost efficiency. Demant chose [Next.js and Vercel](https://vercel.com/solutions/nextjs) for their stability, feature completeness, and adoption within the developer community.

意识到亟需一种更具可扩展性与更高性能的解决方案，Demant 启动了向无头（headless）架构的转型，将前端与 CMS 运行时解耦。这一方案旨在缓解扩展性与性能瓶颈，同时保持成本效益。Demant 最终选择了 [Next.js 和 Vercel](https://vercel.com/solutions/nextjs)，看重其稳定性、功能完备性，以及在开发者社区中的广泛采用。

The transition to Vercel involved building an entirely new platform from the ground up. While the core web team at Demant spearheaded the initiative, individual business units also contributed to frontend development efforts. Despite the significant overhaul, the transition was smooth, with frontend developers finding the switch to Next.js intuitive and well-supported by comprehensive documentation.

迁移到 Vercel 意味着从零开始构建一个全新的平台。虽然 Demant 的核心 Web 团队主导了该项目，各业务部门也积极参与了前端开发工作。尽管此次重构规模巨大，迁移过程却十分顺利——前端开发者普遍认为转向 Next.js 直观易上手，且得益于详尽完善的官方文档支持。

## **Seeing value after migration**

## **迁移后的实际收益**

With websites running on Vercel, the team has managed to **reduce the cost of hosting a globally scaled setup by 10x** while **improving response times by more than 30x**—offering a massive increase in overall ROI.

网站迁移至 Vercel 后，团队成功将支持全球扩展的托管成本**降低了 10 倍**，同时将响应时间**提升了 30 倍以上**——整体投资回报率（ROI）实现大幅跃升。

[**See the math for yourself**\\  
\\  
Get the line-by-line breakdown in The Total Economic Impact™ of Vercel’s Frontend Cloud, a commissioned study conducted by Forrester Consulting on behalf of Vercel.\\  
\\  
Get The Study](https://vercel.com/roi)

[**亲自验证数据**\\  
\\  
参阅由 Forrester Consulting 受 Vercel 委托撰写的《Vercel 前端云的总体经济影响™》报告，其中提供了逐项明细分析。\\  
\\  
获取完整研究报告](https://vercel.com/roi)

On top of that, Demant's developer experience has drastically changed in terms of both agility and efficiency. Build times have gone from hours to minutes, and because their developers can spin up new frontend apps without spending a massive amount of time provisioning infrastructure, they've become more independent and self-reliant.

此外，Demant 开发者的开发体验在敏捷性与效率两方面均发生了根本性转变：构建时间从数小时缩短至数分钟；开发者无需耗费大量时间配置基础设施，即可快速启动新的前端应用，从而显著提升了自主性与自驱力。

Demant's new setup utilizes Sitecore as a headless CMS, integrated with a Next.js app extended with Sitecore's JSS SDK. Leveraging Vercel features like [Edge Middleware](https://vercel.com/docs/functions/edge-middleware), [Image Optimization](https://vercel.com/docs/image-optimization), and [Edge Cache](https://vercel.com/docs/edge-network/caching), Demant has achieved remarkable performance improvements, enabling a globally scaled setup at a fraction of the previous cost.

Demant 的新架构采用 Sitecore 作为无头 CMS，并通过 Sitecore 的 JSS SDK 与 Next.js 应用集成。借助 Vercel 提供的多项能力——例如 [Edge Middleware（边缘中间件）](https://vercel.com/docs/functions/edge-middleware)、[图像优化（Image Optimization）](https://vercel.com/docs/image-optimization) 和 [边缘缓存（Edge Cache）](https://vercel.com/docs/edge-network/caching)——Demant 实现了卓越的性能提升，以远低于此前的成本支撑起全球规模的部署。

The team collaborates seamlessly within Vercel, utilizing [Preview Deployments](https://vercel.com/docs/deployments/preview-deployments) to share progress with stakeholders and easily manage the QA and testing of different environments. The success of their Vercel implementation has led to adoption across multiple business units within Demant, encompassing more than 200 websites.

团队在 Vercel 平台内实现了无缝协作，借助 [预览部署（Preview Deployments）](https://vercel.com/docs/deployments/preview-deployments) 功能，可便捷地向相关方共享开发进展，并高效开展多环境的质量保障（QA）与测试工作。Vercel 实施的成功推动其在 Demant 内部多个业务单元中全面落地，目前已覆盖超过 200 个网站。

## Looking ahead

## 展望未来

By partnering with Vercel, Demant has overcome scalability and performance challenges, delivering faster, more responsive web experiences to its customers worldwide. The transition to Vercel has not only improved ROI, but also enhanced developer agility and efficiency, empowering teams to deliver high-quality web solutions at unprecedented speed.

通过与 Vercel 合作，Demant 克服了可扩展性与性能方面的挑战，为全球客户提供了更快、更灵敏的网页体验。迁移到 Vercel 不仅提升了投资回报率（ROI），还增强了开发者的敏捷性与工作效率，使团队得以以前所未有的速度交付高质量的网页解决方案。

With Vercel's support, the team continues to drive innovation in the field of hearing healthcare, fulfilling its mission to improve people's health and hearing around the globe.

在 Vercel 的支持下，该团队持续推动听力健康领域的创新，践行其“改善全球民众健康与听力”的使命。
{% endraw %}
