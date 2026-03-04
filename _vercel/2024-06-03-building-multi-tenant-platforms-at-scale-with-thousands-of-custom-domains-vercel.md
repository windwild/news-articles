---
title: "Building multi-tenant platforms at scale with thousands of custom domains - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/mintlify-scaling-a-powerful-documentation-platform-with-vercel"
date: "2024-06-03"
scraped_at: "2026-03-02T09:44:07.132914917+00:00"
language: "en-zh"
translated: true
description: "Learn how Mintlify built and scaled their multi-tenant docs platform with custom domains"
---
{% raw %}

Jun 3, 2024

2024年6月3日

这家快速增长的初创公司如何在 Vercel 上构建了一个支持数千个自定义域名的文档平台。

#### 2,500

当前活跃域名数量

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

# Products Used

# 使用的产品

Next.js

Next.js

Preview Deployments

预览部署

Domains

域名

ISR

增量静态再生（ISR）

[Mintlify](https://mintlify.com/), a platform for public documentation, is a toolkit for developers to write, maintain and host documentation. The platform offers a flexible solution that can be used out of the box or customized to fit specific needs, enabling developers to create help guides, tutorials, and API references.

[Mintlify](https://mintlify.com/) 是一个面向公开文档的平台，为开发者提供了一套用于编写、维护和托管文档的工具集。该平台具备高度灵活性，开箱即用，也可根据特定需求进行定制，助力开发者高效构建帮助指南、教程及 API 参考文档。

### **Vercel: The foundation for scalable documentation**

### **Vercel：可扩展文档的基石**

Mintlify has experienced rapid growth, onboarding thousands of users and seeing widespread adoption among Y Combinator startups. To support this growth, Mintlify relies on Vercel and Next.js to power its platform. Starting out, Mintlify faced scalability challenges with a single static Next.js app that they were cloning repeatedly which also lacked multitenancy capabilities. With Vercel, Mintlify was able to serve multiple customers across different subdomains or custom domains with a single unified codebase. This allowed them to host vast amounts of documentation and seamlessly scale to accommodate their growing user base, leaving the complexities of hosting, scaling, and infrastructure management to Vercel.

Mintlify 近年来实现了快速增长，已吸引数千名用户，并在 Y Combinator 孵化的初创企业中获得广泛应用。为支撑这一增长，Mintlify 依托 Vercel 与 Next.js 构建其平台。早期，Mintlify 仅依赖一个静态 Next.js 应用，通过反复克隆该应用来服务不同客户，但这种方式不仅难以扩展，也缺乏多租户（multitenancy）能力。借助 Vercel，Mintlify 能够基于单一统一代码库，为分布在不同子域名或自定义域名下的多个客户同时提供服务。这使其能够托管海量文档，并无缝扩展以满足日益增长的用户需求，而将托管、扩缩容及基础设施管理等复杂工作全部交由 Vercel 承担。

### **Multi-tenancy toolkit**

### **多租户工具包**

With Vercel's platform, Mintlify is able to programmatically assign free unlimited custom domains, subdomains, and SSL certificates to their users without worrying about these scaling issues. Now, Mintlify's team can dedicate their time and resources to developing their core product and features. Today, Mintlify has 2,500 custom domains connected to their Vercel powered documentation platform, a key sign of customer engagement; someone adding a custom domain means they're truly invested in using Mintlify's docs.

依托 Vercel 平台，Mintlify 可以通过编程方式，为用户免费、无限地自动分配自定义域名、子域名及 SSL 证书，完全无需操心相关扩缩容问题。如今，Mintlify 团队得以将时间与资源聚焦于核心产品与功能的开发。截至目前，已有 2,500 个自定义域名接入 Mintlify 基于 Vercel 构建的文档平台——这是客户深度参与的关键信号：当用户为其文档配置自定义域名时，意味着他们已真正认可并致力于长期使用 Mintlify 的文档服务。

> “Someone adding a custom domain means they're truly invested in using our docs. Vercel's ability to manage custom domains and SSL certificates has been a major time-saver for the Mintlify team. Someone adding a custom domain means they're truly invested in using our docs. Vercel's ability to manage custom domains and SSL certificates has been a major time-saver for the Mintlify team.”
>
> ![](images/building-multi-tenant-platforms-at-scale-with-thousands-of-custom-domains-vercel/img_001.jpg)
>
> **Hahnbee Lee**

> “用户添加自定义域名，意味着他们已真正投入并信赖我们的文档服务。Vercel 对自定义域名与 SSL 证书的自动化管理能力，为 Mintlify 团队节省了大量时间。”  
>  
> ![](images/building-multi-tenant-platforms-at-scale-with-thousands-of-custom-domains-vercel/img_001.jpg)  
>  
> **Hahnbee Lee**

### **Empower teams to build features, not infrastructure**

### **赋能团队专注功能开发，而非基础设施搭建**

- **Scalability:** Mintlify serves multiple customers across thousands of [custom domains](https://vercel.com/docs/projects/domains/working-with-domains#subdomains-wildcard-domains-and-apex-domains) and terabytes of documentation on a single Vercel project.

- **可扩展性**：Mintlify 在单个 Vercel 项目中，即可为成千上万的[自定义域名](https://vercel.com/docs/projects/domains/working-with-domains#subdomains-wildcard-domains-and-apex-domains)客户提供服务，并托管达 TB 级别的文档内容。

- **Performance:** Next.js and Vercel's global edge network deliver fast and efficient performance, crucial for a smooth user experience. With [Incremental Static Regeneration](https://vercel.com/docs/incremental-static-regeneration) (ISR) documentation updates are reflected instantly.

- **性能表现**：Next.js 与 Vercel 全球边缘网络协同，提供快速高效的响应性能，这对保障流畅的用户体验至关重要。借助[增量静态再生](https://vercel.com/docs/incremental-static-regeneration)（ISR）机制，文档更新可即时生效。

- **Automation:** Vercel's API allows Mintlify to automate custom domain setup and streamline [SSL certificate](https://vercel.com/docs/projects/domains/working-with-ssl) issuance.

- **自动化能力**：Vercel 提供的 API 使 Mintlify 能够自动化完成自定义域名配置，并简化[SSL 证书](https://vercel.com/docs/projects/domains/working-with-ssl)的签发流程。

> “Mintlify 若没有 Next.js 和 Vercel，就不可能实现如今这般快速的规模化发展。多租户架构，以及所有自定义域名统一接入同一个 Vercel 项目的能力，实在太惊艳了！Mintlify 若没有 Next.js 和 Vercel，就不可能实现如今这般快速的规模化发展。多租户架构，以及所有自定义域名统一接入同一个 Vercel 项目的能力，实在太惊艳了！”  
>  
> “如果没有 Next.js 和 Vercel，Mintlify 就无法实现如今这般快速的规模化发展。多租户架构，以及所有自定义域名统一接入同一个 Vercel 项目的能力，实在太惊艳了！”

> ![](images/building-multi-tenant-platforms-at-scale-with-thousands-of-custom-domains-vercel/img_001.jpg)  
>  
> ![](images/building-multi-tenant-platforms-at-scale-with-thousands-of-custom-domains-vercel/img_001.jpg)

> **Hahnbee Lee**  
>  
> **Hahnbee Lee**

Looking ahead, Mintlify is exploring ways to further leverage Vercel's infrastructure, including migrating their dashboard for improved performance. With Vercel as their trusted partner, Mintlify can continue to innovate and provide developers with the tools they need to create world-class documentation.  
>  
> 展望未来，Mintlify 正在探索进一步利用 Vercel 基础设施的多种方式，包括迁移其仪表板以提升性能。依托 Vercel 这一值得信赖的合作伙伴，Mintlify 能够持续创新，并为开发者提供打造世界级文档所需的工具。

[**How to build a multi-tenant app with custom domains using Next.js**  
\\  
Create a full-stack application with multi-tenancy and custom domain support using Next.js App Router, Vercel Postgres, and the Vercel Domains API.  
\\  
Read the guide](https://vercel.com/guides/nextjs-multi-tenant-application)  
[**如何使用 Next.js 构建支持自定义域名的多租户应用**  
\\  
使用 Next.js App Router、Vercel Postgres 和 Vercel Domains API，构建一个支持多租户和自定义域名的全栈应用。  
\\  
阅读指南](https://vercel.com/guides/nextjs-multi-tenant-application)
{% endraw %}
