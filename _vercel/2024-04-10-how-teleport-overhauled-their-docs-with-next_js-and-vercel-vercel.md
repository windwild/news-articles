---
title: "How Teleport overhauled their docs with Next.js and Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/creating-a-robust-platform-for-documentation-with-next-js-and-vercel"
date: "2024-04-10"
scraped_at: "2026-03-02T09:45:38.990272619+00:00"
language: "en-zh"
translated: true
description: "Learn how Teleport unlocked a new customer acquisition channel by overhauling and migrating their documentation to Next.js and Vercel. "
---

Apr 10, 2024

2024年4月10日

Learn how Teleport unlocked a new customer acquisition channel by overhauling and migrating their documentation.

了解 Teleport 如何通过全面重构和迁移其文档，开辟了一条全新的客户获取渠道。

#### 3x

#### 提升至原来的 3 倍

More concurrent builds

并发构建数量提升至原来的 3 倍

#### 60%

#### 降低 60%

Decrease in build times

构建耗时降低 60%

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

[Teleport](https://goteleport.com/blog/open-core-vs-saas-intro/), an open-core platform for secure infrastructure access, sought to unify and enhance their website and documentation. They needed a framework that could support dynamic content, provide a smooth developer experience, and ultimately provide a robust and up-to-date resource for their customers.

[Teleport](https://goteleport.com/blog/open-core-vs-saas-intro/) 是一个面向安全基础设施访问的开源核心（open-core）平台，其目标是整合并提升官网与文档体验。他们需要一个能够支持动态内容、提供流畅开发者体验，并最终为客户提供稳定、实时更新资源的框架。

The team chose [Next.js](https://vercel.com/solutions/nextjs) and Vercel due to their compatibility with Teleport’s existing React-based frontend, their ease of integration, and their support for both static and dynamic rendering methods.

团队选择 [Next.js](https://vercel.com/solutions/nextjs) 和 Vercel，主要基于其与 Teleport 现有基于 React 的前端高度兼容、集成简便，以及对静态渲染与动态渲染两种方式的原生支持。

## **Migrating to serverless hosting**

## **迁移到无服务器托管**

Teleport’s documentation and website were previously split across MkDocs and Hugo, platforms that limited the team’s ability to implement dynamic components and manage documentation versions effectively. Teleport required a solution that could:

- Integrate with a CMS for easy content updates

- Support complex dynamic pages

- Automate deployments through GitHub


Teleport 的文档和网站此前分别托管在 MkDocs 和 Hugo 两个平台之上，而这两个平台限制了团队实现动态组件以及高效管理文档版本的能力。Teleport 需要一个能够满足以下需求的解决方案：

- 与内容管理系统（CMS）集成，便于内容更新  

- 支持复杂的动态页面  

- 通过 GitHub 自动化部署流程  

Each of these features were challenging to implement with their existing setup. Teleport partnered with [Evil Martians](https://evilmartians.com/), a development consultancy, and leveraged their extensive experience in open source and Next.js to assist in migrating to Next.js and hosting on Vercel.

上述每一项功能在原有技术栈下都难以实现。Teleport 与开发咨询公司 [Evil Martians](https://evilmartians.com/) 展开合作，借助其在开源项目和 Next.js 领域的深厚经验，协助完成向 Next.js 的迁移，并将网站托管于 Vercel 平台。

This migration met Teleport’s need for a serverless hosting solution that can integrate with GitHub for automated production deployments and can spin up unlimited Preview deployments on demand. At the same time, it ensured compliance with GDPR and met high [security standards](https://vercel.com/security) like SOC 2 Type II.

此次迁移满足了 Teleport 对无服务器（serverless）托管方案的核心需求：可与 GitHub 深度集成，实现生产环境的自动化部署；并能按需即时启动无限量的预览（Preview）部署。与此同时，该方案也确保了对《通用数据保护条例》（GDPR）的合规性，并符合 SOC 2 Type II 等高标准[安全规范](https://vercel.com/security)。

> “Vercel-based Teleport docs and website are a huge success. Our engineers deploy multiple times per day without thinking about it, while always having the ability to preview their work.  
>  
> Before Vercel, deployment of docs was a manual process. Our docs teams and external contributors did not have a way to preview or collaborate with engineering. Vercel unlocked all those workflows and collaboration points for us. We could not be happier.  
>  
> Vercel-based Teleport docs and website are a huge success. Our engineers deploy multiple times per day without thinking about it, while always having the ability to preview their work.  
>  
> Before Vercel, deployment of docs was a manual process. Our docs teams and external contributors did not have a way to preview or collaborate with engineering. Vercel unlocked all those workflows and collaboration points for us. We could not be happier.”  
>  
> ![](images/how-teleport-overhauled-their-docs-with-next_js-and-vercel-vercel/img_001.png)  
>  
> **CTO at Teleport**

> “基于 Vercel 构建的 Teleport 文档与网站取得了巨大成功。我们的工程师每天可多次部署，无需额外思考，且始终能即时预览自己的工作成果。  
>   
> 在接入 Vercel 之前，文档部署完全依赖人工操作；我们的文档团队及外部贡献者既无法预览变更效果，也无法与工程团队高效协作。Vercel 彻底释放了这些工作流与协作节点——我们对此再满意不过了。  
>   
> 基于 Vercel 构建的 Teleport 文档与网站取得了巨大成功。我们的工程师每天可多次部署，无需额外思考，且始终能即时预览自己的工作成果。  
>   
> 在接入 Vercel 之前，文档部署完全依赖人工操作；我们的文档团队及外部贡献者既无法预览变更效果，也无法与工程团队高效协作。Vercel 彻底释放了这些工作流与协作节点——我们对此再满意不过了。”  
>   
> ![](images/how-teleport-overhauled-their-docs-with-next_js-and-vercel-vercel/img_001.png)  
>   
> **Teleport 首席技术官（CTO）**

## The clear value of custom documentation

## 定制化文档的明确价值

The move to Next.js allowed Teleport to centralize their documentation and website under a single framework, streamlining development and ensuring brand consistency.

迁移到 Next.js 使 Teleport 能够将文档与官网统一纳入单一框架进行管理，从而简化开发流程，并保障品牌形象的一致性。

Next.js features like client routing, [server-side rendering (SSR)](https://vercel.com/docs/frameworks/nextjs#server-side-rendering-ssr), and inbuilt automatic SEO—along with `next/image` for [image optimization](https://vercel.com/docs/image-optimization)—significantly improved site performance and end user experience. Moreover, the ability to update content in real time without a full site rebuild via [CMS hooks](https://vercel.com/docs/integrations/cms) was a noted advantage in helping the team move faster.

Next.js 提供的客户端路由、[服务端渲染（SSR）](https://vercel.com/docs/frameworks/nextjs#server-side-rendering-ssr)、内置自动 SEO 优化，以及 `next/image` 组件提供的[图像优化](https://vercel.com/docs/image-optimization)能力，显著提升了网站性能与终端用户体验。此外，借助 [CMS hooks](https://vercel.com/docs/integrations/cms)，团队可在不触发全站重建的前提下实时更新内容——这一优势极大加快了迭代速度。

Teleport and Evil Martians developed a custom documentation solution to address specific needs:

Teleport 与 Evil Martians 共同开发了一套定制化文档解决方案，以满足特定需求：

- **Versioning**: Ability to build docs for different Teleport versions from Markdown files in various repository branches, simplifying the process of backporting changes and ensuring documentation remains up to date with code changes

- **版本管理**：支持从不同代码仓库分支中的 Markdown 文件构建适用于多个 Teleport 版本的文档，简化变更回溯（backporting）流程，并确保文档始终与代码更新保持同步。

- **Migration ease**: Maintaining old MkDocs syntax during migration to avoid manual transfer and editing of a vast number of documents

- **迁移便捷性**：在迁移到新平台过程中保留原有 MkDocs 语法，避免对海量文档进行人工迁移和逐条编辑。

- **Dynamic features**: Introduction of new dynamic features such as shared user variables for code snippets, automated linking between doc versions, custom code blocks, and Mermaid.js charts, enhancing the documentation's utility and user engagement

- **动态功能**：引入多项全新动态能力，例如面向代码片段的共享用户变量、文档各版本间的自动链接、自定义代码块，以及 Mermaid.js 图表支持，显著提升文档实用性与用户参与度。

## **Enhanced collaboration and security**

## **协作效率与安全性的全面提升**

Vercel significantly cut down Teleport's build queue times by **more than 60%**. It also allowed for **3x more concurrent builds**, enabling developers to work on and deploy different parts of the application without delays. This efficiency was crucial for maintaining the team’s rapid development cycle.

Vercel 将 Teleport 的构建队列等待时间**大幅缩短超过 60%**；同时支持**并发构建数量提升至原来的 3 倍**，使开发者能够并行开发与部署应用的不同模块，彻底消除等待延迟。这一效率提升对维持团队高速迭代的开发节奏至关重要。

Security enhancements were major, with Vercel's [Firewall](https://vercel.com/docs/security/vercel-firewall) and DDoS mitigation safeguarding Teleport’s digital assets. Additionally, the integration of [single sign-on (SSO)](https://vercel.com/docs/security/saml#authenticating-with-saml-sso) via Okta streamlined access management within Teleport's engineering team, ensuring that only authorized team members could make changes.

安全性方面实现重大升级：Vercel 提供的 [防火墙（Firewall）](https://vercel.com/docs/security/vercel-firewall) 与 DDoS 防护机制，全面保障 Teleport 的数字资产安全；此外，通过 Okta 集成 [单点登录（SSO）](https://vercel.com/docs/security/saml#authenticating-with-saml-sso)，显著简化了 Teleport 工程团队的访问权限管理，确保仅授权成员方可执行变更操作。

## A new customer acquisition channel

## 全新的客户获取渠道

With Vercel and Evil Martians, Teleport significantly improved their documentation portal, turning it into a key traffic and customer acquisition channel.

借助 Vercel 与 Evil Martians 的协作，Teleport 大幅优化了其文档门户，成功将其打造为关键的流量入口与客户获取渠道。

The Next.js and Vercel-powered platform streamlined Teleport’s deployment processes, allowing for multiple daily updates, easy previewing of changes, and enhanced collaboration across teams. The team has praised the move for its seamless deployment process and the collaboration and workflow benefits it enabled.

这套基于 Next.js 与 Vercel 构建的平台，极大简化了 Teleport 的部署流程，支持每日多次更新、变更内容即时预览，并强化了跨团队协作能力。团队高度评价此次升级，称其部署过程“丝滑顺畅”，并显著提升了协作效率与工作流体验。

[**Ready to get started?**  

[**准备开始了吗？**  

Our experts are here to help you explore how Vercel can safeguard your critical web applications and propel your business forward.  

我们的专家随时为您服务，助您深入了解 Vercel 如何保障您的关键 Web 应用安全，并推动您的业务向前发展。  

Contact Us](https://vercel.com/contact/sales)  

联系我们](https://vercel.com/contact/sales)