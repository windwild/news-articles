---
title: "Navigating Web3 dynamism: Ledger's solution to traffic spike stability with Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/ledgers-solution-to-traffic-spike-stability-with-vercel"
date: "2024-10-04"
scraped_at: "2026-03-02T09:40:38.003419215+00:00"
language: "en-zh"
translated: true
description: "Discover how Ledger, a leader in hardware wallets, transformed their online presence to handle unpredictable Web3 traffic spikes. Learn how Vercel and Next.js improved their performance, boosting rele..."
---
&#123;% raw %}

Oct 4, 2024

2024年10月4日

Ledger 如何借助 Next.js 和 Vercel 扩展 Web3 流量，实现发布次数提升 100 倍、页面加载速度加快 67%。

#### 67%

页面加载时间降低 67%

#### 每日 600–700 万次请求

依托统一的 API 基础设施提供服务

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

# Products Used

# 使用的产品

Next.js

Next.js

Preview Deployments

预览部署

In the world of crypto, market surges and unexpected events create unpredictable traffic spikes, like Gunna wearing a diamond-encrusted Ledger at the Met Gala.

在加密货币世界中，市场暴涨和突发性事件会引发难以预测的流量激增——例如冈纳（Gunna）在大都会艺术博物馆慈善晚宴（Met Gala）上佩戴镶满钻石的 Ledger 钱包所引发的关注热潮。

For [Ledger](https://www.ledger.com/)—a leading provider of hardware wallets—capturing this no-notice interest becomes crucial for Ledger’s online presence, which may see traffic fluctuate from 1-5 million users monthly. Navigating the dynamism of the crypto market requires a technical infrastructure as resilient and secure as Ledger’s hardware products.

对于硬件钱包领域的领军企业 [Ledger](https://www.ledger.com/) 而言，及时捕捉此类“毫无征兆”的用户兴趣，对其线上平台至关重要——其月度访问用户量可能在 100 万至 500 万之间剧烈波动。应对加密市场的高度动态性，要求技术基础设施必须像 Ledger 的硬件产品一样具备极强的韧性与安全性。

![Gunna wearing a diamond-encrusted Ledger at the Met Gala sparks demand for Ledger wallets.](images/navigating-web3-dynamism-ledger_s-solution-to-traffic-spike-stability-with-verce/img_001.jpg)Gunna wearing a diamond-encrusted Ledger at the Met Gala sparks demand for Ledger wallets.

![冈纳在大都会艺术博物馆慈善晚宴上佩戴镶满钻石的 Ledger 钱包，引爆了用户对 Ledger 钱包的需求。](images/navigating-web3-dynamism-ledger_s-solution-to-traffic-spike-stability-with-verce/img_001.jpg)冈纳在大都会艺术博物馆慈善晚宴上佩戴镶满钻石的 Ledger 钱包，引爆了用户对 Ledger 钱包的需求。

## **Limitations of Shopify Liquid**

## **Shopify Liquid 模板引擎的局限性**

Ledger's ecommerce site was built on a heavily customized Shopify storefront, designed to overcome the limitations of Shopify's theming engine. This presented significant challenges in implementing engineering best practices such as CI/CD, testing, functional programming, code standards, and linting.

Ledger 的电商网站基于深度定制化的 Shopify 前端构建，初衷正是为了弥补 Shopify 主题引擎的固有缺陷。然而，这种架构给工程最佳实践的落地带来了巨大挑战，包括持续集成与持续交付（CI/CD）、自动化测试、函数式编程、代码规范及代码检查（linting）等均难以有效实施。

The use of Shopify's Liquid templates restricted their ability to run isomorphic code across client and server, resulting in a fragmented tech stack that prevented component reuse. The Shopify environment also made it difficult to set up isolated testing environments for pull requests, hindering confidence before releasing to production.

采用 Shopify 的 Liquid 模板限制了其在客户端与服务端运行同构代码的能力，导致技术栈高度割裂，组件复用几乎无法实现。此外，Shopify 环境也难以针对 Pull Request 搭建隔离的测试环境，严重削弱了团队在发布至生产环境前的信心。

To extend functionality beyond Shopify's native capabilities, Ledger had several supporting microservices hosted as AWS Lambda functions. These microservices managed secure interactions outside the Shopify ecosystem, including Web3 login for token gating, and served as intermediaries for third-party integrations.

为突破 Shopify 原生能力的边界，Ledger 部署了多个作为 AWS Lambda 函数运行的支撑型微服务。这些微服务负责处理 Shopify 生态之外的安全交互，例如面向代币门控（token gating）的 Web3 登录，并充当前端与第三方系统集成的中间层。

These microservices also acted as backend for frontend (BFF) layers, adapting and transforming data for better consumption by the client. This was essential for tailoring responses to the frontend’s specific needs, enhancing performance, and user experience. While these functioned well, their separation from the main codebase led to difficulties in synchronizing releases across multiple repositories.

这些微服务同时也承担了“前端专属后端”（Backend for Frontend, BFF）的角色，对数据进行适配与转换，以更高效地供前端消费。这对满足前端特定需求、提升性能与用户体验至关重要。尽管这些微服务运行良好，但因其与主代码库物理分离，导致跨多个代码仓库协调版本发布变得异常困难。

> “In Web3, two weeks is like a year. We need to be able to ship now, not later.In Web3, two weeks is like a year. We need to be able to ship now, not later.”
>
> ![](images/navigating-web3-dynamism-ledger_s-solution-to-traffic-spike-stability-with-verce/img_002.jpg)
>
> **Dominic Green,** Director of Engineering

> “在 Web3 领域，两周时间堪比一年。我们必须‘现在就上线’，而不是‘稍后再上线’。”  
> “在 Web3 领域，两周时间堪比一年。我们必须‘现在就上线’，而不是‘稍后再上线’。”
>
> ![](images/navigating-web3-dynamism-ledger_s-solution-to-traffic-spike-stability-with-verce/img_002.jpg)
>
> **多米尼克·格林（Dominic Green）**，工程总监

## **Built on Next.js and Vercel**

## **基于 Next.js 与 Vercel 构建**

Ledger chose Next.js and Vercel to power their online store and critical web applications, leveraging a serverless-first architecture to enhance performance and development speed. This combination enabled developers to own the entire production pipeline without the complexities of Terraform and GitHub Actions, allowing the team to focus on efficient feature delivery. Next.js's flexibility allows Ledger to run isomorphic code, unify their tech stack, and reuse components seamlessly. This strategic move enabled Ledger to build an ecosystem on Vercel, supporting several applications including:

Ledger 选择 Next.js 和 Vercel 来驱动其在线商店及关键 Web 应用，依托以无服务器（serverless-first）为核心的架构，显著提升了性能与开发速度。这一技术组合使开发者能够自主掌控完整的生产交付流水线，无需应对 Terraform 和 GitHub Actions 带来的复杂性，从而将团队精力聚焦于高效交付功能。Next.js 的高度灵活性使 Ledger 能够运行同构代码（isomorphic code）、统一技术栈，并无缝复用组件。这一战略性选择助力 Ledger 在 Vercel 上构建起一个应用生态，支撑了多个关键项目，包括：

- **Headless ecommerce storefront:** Ledger’s ecommerce platform operates as a headless storefront, utilizing server-side rendering (SSR) to ensure fast and efficient page loads, NextAuth.js for secure user authentication, and API routes to serve as the BFF, handling data fetching and business logic execution

- **无头电商 storefront（Headless Ecommerce Storefront）：** Ledger 的电商平台采用无头架构，通过服务端渲染（SSR）确保页面快速、高效加载；使用 NextAuth.js 实现安全的用户身份认证；并借助 API Routes 构建后端即前端（BFF），统一处理数据获取与业务逻辑执行。

- **Headless applications:** Vercel powers discrete headless applications for diverse use cases. For instance, Ledger’s decentralized applications (DApps) run directly within the discover section of their native applications. [Quest](https://quest.ledger.com/), a Web3 education project, leverages Vercel for dynamic content generation and NFT minting and has seen 76k completed quests and NFTs

- **无头应用（Headless Applications）：** Vercel 支撑一系列独立部署的无头应用，覆盖多样化使用场景。例如，Ledger 的去中心化应用（DApps）直接内嵌于其原生应用的“发现”（Discover）板块中。[Quest](https://quest.ledger.com/) 是一项面向 Web3 的教育计划，依托 Vercel 实现动态内容生成与 NFT 铸造，目前已完成逾 76,000 项任务并发放同等数量的 NFT。

- **Unified API infrastructure:** Ledger runs pure API services on Vercel to support a range of functionalities. One key service is the configuration engine for their native apps, which powers various app settings and features. These APIs are designed to be highly available and performant, powering critical app settings and features for a global user base, handling massive traffic loads, consistently serving 6-7 million daily requests

- **统一 API 基础设施（Unified API Infrastructure）：** Ledger 在 Vercel 上运行纯 API 服务，支撑多项核心功能。其中一项关键服务是为其原生应用提供支持的配置引擎（Configuration Engine），驱动各类应用设置与功能。这些 API 经过专门优化，具备高可用性与高性能，为全球用户群提供关键应用配置与功能支持，可稳定承载海量并发流量，日均请求量持续维持在 600–700 万次。

Ledger has adopted a production-first mindset since switching to Vercel. New projects start day one on Vercel. Vercel's git push takes care of deployments. The team configures deployment protection and feature flags, so new features and improvements can roll out when ready. Using Vercel has changed their entire development approach.

自迁移到 Vercel 后，Ledger 全面转向“以生产为先”（production-first）的开发理念：所有新项目从第一天起即部署于 Vercel；Vercel 的 `git push` 自动完成部署流程；团队通过配置部署保护机制与功能开关（feature flags），确保新功能与优化项可在就绪时按需灰度发布。Vercel 的引入彻底重塑了 Ledger 的整体开发范式。

![Ledger handles the unpredictable world of crypto with technical infrastructure as resilient and secure as  their hardware products.](images/navigating-web3-dynamism-ledger_s-solution-to-traffic-spike-stability-with-verce/img_003.jpg)Ledger handles the unpredictable world of crypto with technical infrastructure as resilient and secure as their hardware products.

![Ledger 以与其硬件产品同样强韧且安全的技术基础设施，从容应对加密世界中不可预测的挑战。](images/navigating-web3-dynamism-ledger_s-solution-to-traffic-spike-stability-with-verce/img_003.jpg)Ledger 以与其硬件产品同样强韧且安全的技术基础设施，从容应对加密世界中不可预测的挑战。

## The r **esults** speak for themselves

## 成果不言自明

Vercel's Next.js integration, performance enhancements, and streamlined deployment process made it the superior choice over AWS. Ledger’s evaluation showed Vercel's edge functions significantly reduced latency and improved load times. Developer feedback also strongly favored Vercel for its intuitive interface and efficient deployment process, making it more cost-effective and user-friendly than replicating the setup on AWS. The impact has been significant:

Vercel 对 Next.js 的深度集成、性能优化能力以及简化的部署流程，使其成为相较 AWS 更具优势的选择。Ledger 的评估表明，Vercel 的边缘函数（Edge Functions）显著降低了延迟、提升了页面加载速度。开发者反馈亦高度认可 Vercel——其直观的用户界面与高效的部署流程，不仅比在 AWS 上自行搭建同类系统更具成本效益，也更易于上手和使用。实际成效尤为显著：

- **100x increase in release frequency:** From 1-2 releases per 2 weeks to over 100, allowing teams to respond rapidly to market changes

- **发布频率提升 100 倍：** 由每两周发布 1–2 次，跃升至每周发布超 100 次，使团队得以敏捷响应市场变化。

- **67% reduction in load time:** Average page load times dropped from 2.6 seconds to under 0.93 seconds

- **页面加载时间降低 67%：** 平均页面加载时间从 2.6 秒缩短至不足 0.93 秒。

- **13% improvement in bounce rates:** Leading to higher customer engagement and sales  
- **跳出率降低 13%：** 从而提升客户参与度与销售额  

- **Easier collaboration:** [Preview Deployments](https://vercel.com/docs/deployments/preview-deployments) improve collaboration between teams, speeding up the development and approval process  
- **协作更便捷：** [预览部署（Preview Deployments）](https://vercel.com/docs/deployments/preview-deployments) 加强了团队间的协作，显著加快开发与审批流程  

Ultimately, Ledger gained full control over their development environment, enabling them to set up testing environments and enforce consistent code standards, significantly improving the overall developer experience.  
最终，Ledger 全面掌控其开发环境，得以灵活搭建测试环境并严格执行统一的代码规范，从而大幅提升了整体开发者体验。

## **Vercel powers Ledger's crypto resilience**  
## **Vercel 赋能 Ledger 的加密资产韧性**

To match the resilience and security of their hardware products, Ledger needed a technical infrastructure that could handle the volatile crypto market. They found their solution in Vercel's serverless-first platform. This approach, combined with Vercel's scalable and secure-by-default infrastructure, empowers Ledger to deliver a consistently smooth and reliable user experience, even amidst market fluctuations.  
为匹配其硬件产品的高韧性与高安全性，Ledger 需要一套能够从容应对加密市场剧烈波动的技术基础设施。他们最终选择了 Vercel 以无服务器（serverless）为优先的平台。这一方案，叠加 Vercel 自带可扩展性与默认安全性的基础设施，使 Ledger 能够在市场起伏中持续提供流畅、可靠的用户体验。

> “At Ledger, stability is key. Everything went smoothly thanks to our technical choices and architecture.”  
> “在 Ledger，稳定性至关重要。得益于我们的技术选型与架构设计，一切运行顺利。”  
>  
> ![](images/navigating-web3-dynamism-ledger_s-solution-to-traffic-spike-stability-with-verce/img_002.jpg)  
>  
> **Dominic Green,** Director of Engineering  
> **多米尼克·格林（Dominic Green），** 工程总监  

Vercel.com landing page  
Vercel.com 官网落地页  

### Composable commerce on Vercel  
### 基于 Vercel 的可组合式电商（Composable Commerce）

Vercel.com landing page  
Vercel.com 官网落地页  

### Watch the KidSuper interview  
### 观看 KidSuper 专访
&#123;% endraw %}
