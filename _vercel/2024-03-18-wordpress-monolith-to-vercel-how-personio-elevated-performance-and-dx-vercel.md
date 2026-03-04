---
title: "WordPress monolith to Vercel: How Personio elevated performance and DX - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/from-wordpress-monolith-to-vercel-personio-elevates-site-performance"
date: "2024-03-18"
scraped_at: "2026-03-02T09:46:11.597092683+00:00"
language: "en-zh"
translated: true
description: "Personio migrated from a WordPress monolith to a composable solution with Vercel and Next.js, improving performance, security, and iteration speed. "
---

render_with_liquid: false
Mar 18, 2024

2024年3月18日

Personio's transition to a headless architecture with Vercel + Next.js enhanced their website's UX.

Personio 采用 Vercel + Next.js 构建无头架构，显著提升了其网站的用户体验。

#### 99.99%

Website uptime

#### 99.99%

网站正常运行时间

#### 90% increase

Core Web Vitals scores

#### 提升 90%

核心网页指标（Core Web Vitals）得分

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

As Europe's leading all-in-one HR solution for small and midsized organizations, [Personio](https://www.personio.com/) is committed to the highest standards of both user experience and application security.

作为欧洲领先的小型及中型企业一站式人力资源（HR）解决方案提供商，[Personio](https://www.personio.com/) 始终致力于为用户提供卓越的体验与最高级别的应用安全标准。

By migrating their site from a monolithic WordPress implementation to a composable stack of Vercel, Next.js, and Contentful, they were able to significantly boost site performance while ensuring uptime and reliability.

通过将网站从单体式 WordPress 架构迁移至由 Vercel、Next.js 和 Contentful 构成的可组合技术栈，Personio 大幅提升了网站性能，同时保障了高可用性与系统可靠性。

## **From WordPress to composable**

## **从 WordPress 迁移至可组合架构**

Despite their web team's agility and quick turnaround time, limited developer resources and budget constraints impacted Personio's ability to innovate on their WordPress site for six years. The need for a more flexible stack was clear.

尽管其网页团队反应敏捷、交付迅速，但开发人员资源有限及预算紧张，致使 Personio 在其 WordPress 网站上的创新停滞长达六年。构建一套更灵活的技术栈的需求已十分明确。

Through a selective evaluation process, Personio’s ultimate decision was simple: Contentful for their flexible CMS, and Next.js and Vercel as the powerful framework and platform behind it.

经过一轮审慎的评估，Personio 最终的选择十分明确：采用 Contentful 作为其灵活的内容管理系统（CMS），并以 Next.js 和 Vercel 作为支撑该系统的强大框架与平台。

## **Increased performance and traffic gains**

## **性能提升与流量增长**

Over time, Personio accumulated massive tech debt and extra code by continuously building on and adding to their original WordPress theme. Though the team was still quick to deploy, site speed took a hit.

长期以来，Personio 在原有 WordPress 主题基础上持续叠加功能与代码，导致技术债不断累积、冗余代码大量增加。尽管团队部署依然迅速，网站加载速度却明显下降。

Mobile performance was particularly affected by persistent issues with [Cumulative Layout Shift (CLS)](https://vercel.com/docs/concepts/analytics/web-vitals#cumulative-layout-shift-cls). The switch to Vercel quickly addressed these problems and more.

移动端性能尤其受到[累积布局偏移（CLS）](https://vercel.com/docs/concepts/analytics/web-vitals#cumulative-layout-shift-cls)等长期问题的严重影响。迁移到 Vercel 后，这些问题迅速得到解决，且带来诸多额外收益。

After launching their Italian website in 2022, Personio saw a rapid increase in traffic. Their [Core Web Vitals](https://vercel.com/analytics)—and especially CLS—experienced a significant boost, **consistently seeing improvements of more than 90%**.

2022 年意大利语网站上线后，Personio 的流量迅速攀升。其[核心网页指标（Core Web Vitals）](https://vercel.com/analytics)——尤其是 CLS——显著提升，**各项指标持续改善幅度超过 90%**。

These enhancements were also observed across Personio’s five other domains. The team now benefits from real data on Core Web Vitals, offering a more effective, data-driven approach to their optimization strategy. Specifically on mobile, there was a **29% improvement in their Largest Contentful Paint (LCP) score**.

上述优化效果同样体现在 Personio 其余五个域名上。团队如今可依托真实的核心网页指标数据，制定更高效、更以数据为驱动的性能优化策略。在移动端，其最大内容绘制（Largest Contentful Paint, LCP）得分提升了 **29%**。

![](images/wordpress-monolith-to-vercel-how-personio-elevated-performance-and-dx-vercel/img_001.jpg)

Since migrating their site to Vercel, Personio has received top marks and reviews for the increased speed and improved user experience. The platform's seamless background operation allows Personio's developers to concentrate on critical projects without the burden of managing infrastructure concerns.

自网站迁移至 Vercel 后，Personio 因显著提升的访问速度与更优的用户体验而广受好评、屡获高分。Vercel 平台在后台无缝运行，使 Personio 的开发者得以专注于关键项目，无需再为基础设施运维事务分心。

> “We have full confidence in our site on Vercel. We have roughly 100% uptime, and we’ve never experienced any outages. Deployments to production are very robust, and we haven’t seen any problems. Vercel is quite invisible, which is the best case scenario. We have full confidence in our site on Vercel. We have roughly 100% uptime, and we’ve never experienced any outages. Deployments to production are very robust, and we haven’t seen any problems. Vercel is quite invisible, which is the best case scenario. ”
>
> “我们对部署在 Vercel 上的网站充满信心。网站可用性接近 100%，从未发生过任何宕机事故；生产环境部署极为稳健，也从未出现任何问题。Vercel 的存在感极低——这恰恰是最理想的状态。”
>
> ![](images/wordpress-monolith-to-vercel-how-personio-elevated-performance-and-dx-vercel/img_002.png)
>
> **Peter Rosell,** Senior Full Stack Engineer
>
> **彼得·罗塞尔（Peter Rosell）**，高级全栈工程师

## Security by default

## 默认安全机制

As an HR company, Personio adheres to stringent security protocols. By integrating Next.js, Personio has significantly elevated their site security, with capabilities such as server-side rendering and static generation reducing exposure to vulnerabilities that client-rendered sites might face.

作为一家人力资源科技公司，Personio 严格遵守高标准的安全规范。通过集成 Next.js，Personio 大幅提升了网站安全性——服务端渲染（SSR）与静态生成（SSG）等能力，有效降低了客户端渲染网站可能面临的各类安全漏洞风险。

Additionally, Vercel's hosting environment enhances Personio's security with features like automatic HTTPS, end-to-end encryption for data in transit, and [robust DDoS protection](https://vercel.com/docs/security/ddos-mitigation) via global Edge Network.

此外，Vercel 的托管环境进一步强化了 Personio 的安全防护能力，提供自动 HTTPS、传输中数据的端到端加密，以及依托全球边缘网络实现的[强大 DDoS 防护](https://vercel.com/docs/security/ddos-mitigation)。

This shift towards a more controlled and internally managed security framework allows Personio to tailor its security measures more closely to the unique requirements and risks of the HR industry. It marks a strategic move away from dependency on third-party security solutions, offering Personio increased agility in implementing and updating security protocols.

这一向更可控、更自主管理的安全架构的转变，使 Personio 能够更精准地根据人力资源行业的独特需求与风险定制安全策略。此举标志着 Personio 战略性地摆脱了对第三方安全解决方案的依赖，从而在安全协议的实施与更新方面获得更高的敏捷性。

This not only strengthens their defense against potential cybersecurity threats, but also builds trust among users and clients who rely on Personio for the safe handling of their HR processes and data.

这不仅显著增强了其抵御潜在网络安全威胁的能力，也进一步赢得了用户与客户信任——他们依赖 Personio 安全地处理人力资源流程与敏感数据。

## A better developer experience

## 更卓越的开发者体验

The transition to Vercel has also upgraded the developer experience within the team, streamlining internal processes and fostering a more collaborative environment. With [Vercel Preview Deployments](https://vercel.com/features/previews) and commenting functionality, developers can engage in real-time feedback and discussions directly in preview environments, ensuring a more integrated and efficient review process.

迁移到 Vercel 同时也全面升级了团队内部的开发者体验，优化了内部协作流程，营造出更加高效协同的工作环境。借助 [Vercel 预览部署（Preview Deployments）](https://vercel.com/features/previews) 及内建评论功能，开发者可直接在预览环境中开展实时反馈与讨论，确保代码评审流程更紧密集成、更富效率。

Furthermore, the headless architecture enabled by Vercel provides the development team with the flexibility to rapidly implement new features and updates. This move supports a more agile development strategy, allowing Personio to quickly adapt and innovate in the fast-evolving HR tech landscape, keeping their platform dynamic and on the cutting edge.

此外，Vercel 所支持的无头架构（headless architecture）赋予开发团队高度灵活性，使其能够快速上线新功能与迭代更新。这一转型有力支撑了更敏捷的开发策略，助力 Personio 在快速演进的人力资源科技领域持续敏捷响应、加速创新，始终保持平台的活力与技术前沿性。

[**Upgrade your workflow today**\\
\\
Reach out to learn more about how you can improve your frontend workflow and empower your team to ship better web experiences with Vercel.\\
\\
Contact Us](https://vercel.com/contact/sales)

[**即刻升级您的工作流**\\
\\
联系我们，深入了解如何优化您的前端工作流，并赋能您的团队借助 Vercel 构建更出色的 Web 用户体验。\\
\\
立即联系](https://vercel.com/contact/sales)