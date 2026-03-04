---
title: "Your guide to headless commerce - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/your-guide-to-headless-commerce"
date: "2023-02-27"
scraped_at: "2026-03-02T09:54:31.190189273+00:00"
language: "en-zh"
translated: true
description: "Curious about headless commerce? Learn all about going headless with a composable stack so you can boost developer velocity, conversions, and more."
---
&#123;% raw %}

Feb 27, 2023

2023 年 2 月 27 日

Learn how going headless enables digital experiences that convert.

了解“无头化”如何赋能高转化率的数字体验。

Adopting a headless, or composable, commerce architecture helps to ensure your digital storefront is high-performing, scalable, and increasing in conversions each year. Leading ecommerce brands are choosing to go headless to stay competitive.

采用无头（或可组合式）电商架构，有助于确保您的数字门店具备高性能、可扩展性，并实现每年转化率持续提升。领先的电子商务品牌正纷纷选择无头化，以保持市场竞争力。

Let’s get back to basics and explore what headless commerce is, how it compares to monolithic commerce, and what you should do once you've made the migration to outpace your competitors and reach your KPIs.

让我们回归基础，深入探讨什么是无头电商、它与单体式电商有何区别，以及完成迁移后，您应采取哪些举措，以超越竞争对手并达成关键绩效指标（KPI）。

[**Already experienced with headless?**\\
\\
Learn how to configure headless WordPress with your Next.js application.\\
\\
Read more](https://vercel.com/guides/wordpress-with-vercel)

[**已熟悉无头架构？**\\
\\
了解如何将无头 WordPress 配置到您的 Next.js 应用中。\\
\\
了解更多](https://vercel.com/guides/wordpress-with-vercel)

1. [What is a headless commerce architecture?](https://vercel.com/blog/your-guide-to-headless-commerce#what-is-a-headless-commerce-architecture)

1. [什么是无头电商架构？](https://vercel.com/blog/your-guide-to-headless-commerce#what-is-a-headless-commerce-architecture)

2. [Monolithic commerce vs. headless commerce](https://vercel.com/blog/your-guide-to-headless-commerce#monolithic-commerce-vs.-headless-commerce)

2. [单体式电商 vs. 无头电商](https://vercel.com/blog/your-guide-to-headless-commerce#monolithic-commerce-vs.-headless-commerce)

3. [What are the benefits of headless commerce?](https://vercel.com/blog/your-guide-to-headless-commerce#what-are-the-benefits-of-headless-commerce)

3. [无头电商有哪些优势？](https://vercel.com/blog/your-guide-to-headless-commerce#what-are-the-benefits-of-headless-commerce)

4. [How to adopt headless commerce](https://vercel.com/blog/your-guide-to-headless-commerce#how-to-adopt-headless-commerce-an-iterative-approach)

4. [如何采用无头电商（迭代式方法）](https://vercel.com/blog/your-guide-to-headless-commerce#how-to-adopt-headless-commerce-an-iterative-approach)

5. [Headless commerce use cases](https://vercel.com/blog/your-guide-to-headless-commerce#headless-commerce-use-cases-what-to-do-once-you%E2%80%99ve-gone-headless)

5. [无头电商应用场景：完成无头化后该做什么？](https://vercel.com/blog/your-guide-to-headless-commerce#headless-commerce-use-cases-what-to-do-once-you%E2%80%99ve-gone-headless)

## What is a headless commerce architecture?

## 什么是无头电商架构？

A headless commerce architecture is the decoupling of your backend and frontend as an ecommerce storefront. Rather than relying on a monolithic ecommerce platform with a built-in frontend, headless commerce gives you the ability to custom-build an application stack that best fits your needs.

无头电商架构是指将电商门店的后端与前端进行解耦。与依赖内置前端的单体式电商平台不同，无头电商使您能够根据自身需求，定制构建最适合的应用技术栈。

![](images/your-guide-to-headless-commerce-vercel/img_001.jpg)![](images/your-guide-to-headless-commerce-vercel/img_002.jpg)

## **How does headless commerce work?**

## **无头电商如何运作？**

A headless commerce storefront relies on an API to work. The API connects the frontend and backend—sending information between the two in real time. The backend tool sends data like products, reviews, and pricing information to the storefront’s frontend that customers see. Meanwhile, the frontend shares customer touchpoints with the backend to enrich customer profiles for deeper personalization and targeting. Due to the block-by-block nature of headless commerce, you can build your own world-class tech stack using the best solutions that fit your needs.

无头电商门店依靠 API 实现运行：该 API 连接前端与后端，并在两者之间实时传输信息。后端系统（如商品管理、评论系统、定价引擎等）将商品、用户评价、价格等数据发送至客户所见的前端门店界面；与此同时，前端也将客户交互触点（如浏览行为、点击路径、购物车操作等）回传至后端，从而丰富客户画像，实现更深层次的个性化推荐与精准营销。得益于无头电商“模块化堆叠”（block-by-block）的特性，您可以灵活选用业界最优的各类解决方案，自主构建属于自己的世界级技术栈。

## **Monolithic commerce vs. headless commerce**

## **单体式电商 vs. 无头电商**

Monolithic commerce has been the standard for years, and the monolithic applications that make it up can vary. Two of the more commonly used approaches in commerce include the _managed monolith_, encompassing popular ecommerce platforms like Shopify, BigCommerce, and Salesforce Commerce Cloud. The alternative is the _self-built monolith_: tightly coupled frontend and backend code bases, often with legacy languages.

单体式电商已沿用多年，其具体实现形式各异。当前电商领域中两种较常见的单体式方案分别是：**托管型单体平台**（_managed monolith_），例如 Shopify、BigCommerce 和 Salesforce Commerce Cloud 等主流电商平台；以及**自建型单体系统**（_self-built monolith_），即前后端代码高度耦合、常采用老旧编程语言开发的内部系统。

While both approaches have unique limitations, neither provides the front and backend flexibility required to deliver the fast, personalized, omnichannel experiences powering the growth of leading commerce brands today.

尽管这两种方式各有其适用场景与优势，但它们均无法提供当今领先电商品牌所依赖的——快速响应、高度个性化、全渠道协同的用户体验所需的前后端灵活性。

![Headless architecture allows teams to work more independently of each other, which means faster iteration.](images/your-guide-to-headless-commerce-vercel/img_003.jpg)![Headless architecture allows teams to work more independently of each other, which means faster iteration.](images/your-guide-to-headless-commerce-vercel/img_004.jpg)

无头架构使各团队能更独立地开展工作，从而实现更快的迭代速度。

[Headless commerce](https://vercel.com/resources/why-innovators-are-going-headless)  
[无头电商](https://vercel.com/resources/why-innovators-are-going-headless)

has grown in popularity in the last few years to solve for the tradeoffs that come with monolithic commerce. A composable stack’s modularity allows for more flexibility and better performance. Rather than using one provider for both the frontend and backend, companies can use one company for their backend and another for their frontend. These pieces of the architecture are then combined using an API for a seamless experience that’s been customized for the organization.  

过去几年中，无头电商（Headless Commerce）日益流行，旨在解决单体式电商架构所固有的取舍困境。可组合式技术栈（composable stack）的模块化特性，赋予企业更高的灵活性与更优的性能表现。企业无需依赖单一供应商同时提供前端与后端服务，而是可以选择一家供应商负责后端，另一家负责前端。这些架构组件随后通过 API 进行集成，从而为组织量身打造无缝、定制化的用户体验。

## The limitations of the monolith  

## 单体架构的局限性  

From vendor lock-in to a lackluster user experience, monolithic architectures come with numerous limitations that drive brands to go headless instead.  

从厂商锁定（vendor lock-in）到乏善可陈的用户体验，单体式架构存在诸多限制，正推动品牌转向无头架构。

![](images/your-guide-to-headless-commerce-vercel/img_005.png)  

![](images/your-guide-to-headless-commerce-vercel/img_005.png)

Legacy monolith applications  

传统单体应用  

Teams using legacy monolithic applications are typically locked into technology that was brought in a while ago and is hard to replace. Tooling and infrastructure often get built around this, codifying it into place and slowing down the processes behind the application (and the application itself).  

采用传统单体应用的团队，往往被锁定在多年前引入、如今却难以替换的技术栈中。相关工具链与基础设施也围绕该技术构建，使其进一步固化，最终拖慢应用背后的开发流程（乃至应用本身的运行效率）。

![](images/your-guide-to-headless-commerce-vercel/img_006.png)  

![](images/your-guide-to-headless-commerce-vercel/img_006.png)

End-to-end tools  

端到端工具  

Custom design systems are hard to implement, and third-party tooling or scripts drag down performance. They can’t swap out one piece of the puzzle for another (i.e. if Marketing wants to use a different CMS).  

自定义设计系统难以落地实施；第三方工具或脚本则会拖累整体性能。企业无法灵活地替换架构中的某一环节（例如：若市场部门希望改用另一套内容管理系统 CMS）。

![](images/your-guide-to-headless-commerce-vercel/img_007.png)  

![](images/your-guide-to-headless-commerce-vercel/img_007.png)

# Performance

# 性能

Users experience slow site performance/load times due to API performance, data transfer, and caching limitations of the legacy platform or homegrown system.

由于传统平台或自研系统的 API 性能、数据传输效率及缓存能力受限，用户常遭遇网站响应缓慢、加载时间过长等问题。

![](images/your-guide-to-headless-commerce-vercel/img_008.png)

# Availability

# 可用性

Downtime can be frequent from outages, impaired performance, and reliability issues due to tech debt, over-reliance on inconsistent platforms, or dependencies with increasingly large homegrown code bases.

因技术债务累积、过度依赖不稳定的平台，或与日益庞大的自研代码库深度耦合，系统常出现宕机、性能下降及可靠性问题，导致服务可用性频繁受损。

![](images/your-guide-to-headless-commerce-vercel/img_009.png)

# SEO

# 搜索引擎优化（SEO）

Sites were not designed for today’s modern user experience, often measured by Google Core Web Vitals, and current performance is hindering SEO rankings.

现有网站并非为当今现代化用户体验而设计——而该体验通常以 Google 核心网页指标（Core Web Vitals）为衡量标准；当前的性能表现正严重拖累 SEO 排名。

![](images/your-guide-to-headless-commerce-vercel/img_010.png)

# Developer talent and retention

# 开发者人才与留存

It can be challenging to attract and retain talented developers due to the archaic, restrictive, and cumbersome nature of developing and shipping monolithic applications.

由于单体应用开发与交付方式陈旧、受限且繁琐，吸引并留住优秀开发者颇具挑战性。

![](images/your-guide-to-headless-commerce-vercel/img_011.png)

Tech debt

技术债务

Growing tech debt leads to application outages, security vulnerabilities, and increased maintenance costs.

不断累积的技术债务将导致应用宕机、安全漏洞频发，以及维护成本持续攀升。

![](images/your-guide-to-headless-commerce-vercel/img_012.png)

Technology limitations

技术局限性

Teams are unable to use modern, best-of-breed technologies and are beholden to the capabilities and limitations of their monolith.

团队无法采用现代、业界领先的技术栈，而不得不受制于其单体架构所具备的能力与固有局限。

![](images/your-guide-to-headless-commerce-vercel/img_013.png)

Developer toil

开发者重复劳动

Great developers are spending time configuring infrastructure, fixing bugs, and making small changes that marketers could make—instead of focusing on more impactful and inspiring development work to optimize the user experience.

优秀的开发者正将大量时间耗费在基础设施配置、缺陷修复，以及本可由营销人员完成的微小调整上——而非专注于更具影响力、更富创造力的开发工作，以优化用户体验。

## **What are the benefits of headless commerce?**

## **无头电商有哪些优势？**

By adopting a headless architecture, teams can break free from the limitations of monolithic platforms and build a more modern tech stack. This allows organizations to go to market faster, cut costs, and surpass customers’ expectations—ultimately boosting sales and revenue.

采用无头架构后，团队能够摆脱单体平台的限制，构建更现代化的技术栈。这使企业能够更快地推向市场、降低成本，并超越客户的期望——最终提升销售额与营收。

**Improve developer velocity**

**提升开发者交付效率**

[**Sixty-eight percent of organizations**](https://assets.kpmg/content/dam/kpmg/be/pdf/2019/11/agile-transformation.pdf) **credit delivering products faster as one way they’re able to keep up with changing customer needs.** Headless commerce lets your frontend developers use modern languages and cloud-based tooling to expedite builds, automate tasks, and improve collaboration. Developer workflows optimized for iteration let commerce brands deliver the shopping experience customers want.

[**68% 的企业**](https://assets.kpmg/content/dam/kpmg/be/pdf/2019/11/agile-transformation.pdf) **认为，更快地交付产品是其应对客户不断变化需求的关键方式之一。** 无头电商使前端开发者能够使用现代编程语言和基于云的开发工具，加速开发流程、自动化重复任务，并提升跨团队协作效率。以快速迭代为导向的开发者工作流，助力电商品牌精准交付客户所期待的购物体验。

**Experience cost savings (operator leaner)**

**实现成本节约（运营更轻量化）**

Companies can spend up to 75% of their [total IT budget](https://www.wired.com/insights/2012/10/move-to-cloud-consider-saas/#:~:text=Resource%20costs%3A%20Gartner%20estimates%20that,run%20existing%20systems%20and%20infrastructure.) running and maintaining existing systems and infrastructure. Choosing a serverless frontend platform to deploy applications reduces DevOps overhead, increases infrastructure efficiency, and costs a fraction of most managed monolithic platform licenses.

企业可能将高达其[整体 IT 预算的 75%](https://www.wired.com/insights/2012/10/move-to-cloud-consider-saas/#:~:text=Resource%20costs%3A%20Gartner%20estimates%20that,run%20existing%20systems%20and%20infrastructure.) 用于运行和维护现有系统与基础设施。选择无服务器（serverless）前端平台部署应用，可显著降低 DevOps 运维负担、提升基础设施利用效率，且其成本仅为大多数托管式单体平台许可费用的一小部分。

**Use cutting-edge technologies**

**采用前沿技术**

[**Around 75% of consumers**](https://www.salesforce.com/form/pdf/state-of-the-connected-customer-3rd-edition/?d=7010M000000ujR9QAI&nc=7010M000000ujR4QAI) **expect brands to stay up-to-date with the technology used to create their shopping experience.** With the freedom of choice that comes through a composable stack, companies can easily adopt emerging tech like AI and machine learning to offer individualized, higher-converting shopping experiences.

[**约 75% 的消费者**](https://www.salesforce.com/form/pdf/state-of-the-connected-customer-3rd-edition/?d=7010M000000ujR9QAI&nc=7010M000000ujR4QAI) **期望品牌持续采用最新技术来打造其购物体验。** 借助可组合式技术栈（composable stack）所提供的技术选型自由度，企业可轻松集成人工智能（AI）、机器学习等新兴技术，从而提供高度个性化、转化率更高的购物体验。

**Empower collaborators**

**赋能协作者**

From updating blog posts to landing pages, developers are often responsible for making the frontend changes requested by content creators and marketers when using an all-in-one solution. These collaborators can make edits on their own with a headless solution.

在使用一体化解决方案时，从前端博客文章更新到落地页调整，开发者往往需承担内容创作者与营销人员提出的各类前端修改需求。而在无头解决方案下，这些协作者可自主完成相应编辑工作。

> “As our company grows, teams across Rippling are empowered to make the changes they need. Over 90% of site changes are deployed by stakeholders immediately, giving me the freedom to keep improving Rippling’s site performance and user experience.”  
> “随着公司不断发展，Rippling 各团队均被赋予自主实施所需变更的权限。超过 90% 的网站变更由相关方即时部署，这让我得以持续优化 Rippling 网站的性能与用户体验。”

> ![](images/your-guide-to-headless-commerce-vercel/img_014.png)

> **Web Engineer at Rippling**  
> **Rippling 公司 Web 工程师**

**Increase site performance**  
**提升网站性能**

Monolithic solutions struggle to deliver on modern, SEO-impacting performance metrics like Core Web Vitals. By choosing a headless infrastructure, ecommerce stores increase the value of every user experience—directly impacting traffic and sales.  
单体式解决方案难以满足现代性能指标（如核心网页指标 Core Web Vitals）的要求，而这些指标直接影响搜索引擎优化（SEO）。选择无头架构后，电商网站可全面提升每一次用户交互的价值——直接带动流量增长与销售额提升。

**Enable omnichannel experiences**  
**赋能全渠道体验**

**A strong omnichannel strategy yields** [**56% higher customer retention**](https://www.forbes.com/sites/forbestechcouncil/2018/06/15/omnichannel-cx-how-to-overcome-technologys-artificial-divide-and-succeed-at-being-seamless/?sh=60d9c44b3205), so retailers are focusing on connecting customer engagement across all digital channels. Headless architecture lets commerce development teams deliver high-performing omnichannel experiences without re-architecting the design for every channel.  
**强有力的全渠道战略可带来** [**56% 更高的客户留存率**](https://www.forbes.com/sites/forbestechcouncil/2018/06/15/omnichannel-cx-how-to-overcome-technologys-artificial-divide-and-succeed-at-being-seamless/?sh=60d9c44b3205)，因此零售商正着力打通所有数字渠道上的客户互动。无头架构使电商开发团队无需为每个渠道重新设计架构，即可交付高性能的全渠道体验。

## **How to adopt headless commerce: an iterative approach**  
## **如何采用无头电商：一种渐进式方法**

Despite the many benefits of headless commerce, migrating an entire application architecture can be daunting and expensive. That’s why companies typically take an incremental approach to migration, rather than moving everything all at once. This allows them to make sure they’re porting over what makes sense, and carefully deduce what is best left on their legacy platform.  
尽管无头电商优势显著，但整体迁移应用架构仍可能令人望而生畏且成本高昂。因此，企业通常采取渐进式迁移策略，而非一次性全部切换。这种方式有助于企业精准判断哪些功能应迁移至新架构，同时审慎评估哪些部分更宜保留在原有传统平台之上。

## Headless commerce use cases: what to do once you’ve gone headless  
## 无头电商应用场景：完成无头化之后，还能做些什么？

The ecommerce market share is growing fast. While only [17.8% of sales](https://www.insiderintelligence.com/content/worldwide-ecommerce-forecast-update-2022) were made online in 2020, 23% of consumers are expected to buy online by 2025. What’s driving this growth? Beyond the growing convenience of online shopping, brands are intent on delivering modern user experiences that grow sales and build loyalty. From adopting AI to creating content at scale, check out these headless commerce use cases to see how you can make the most out of your composable architecture.  
电商市场份额正快速增长。2020 年线上销售仅占总销售额的 [17.8%](https://www.insiderintelligence.com/content/worldwide-ecommerce-forecast-update-2022)，而到 2025 年，预计 23% 的消费者将通过线上渠道完成购物。推动这一增长的因素有哪些？除线上购物日益提升的便捷性外，品牌更致力于提供现代化的用户体验，以促进销售增长并增强客户忠诚度。从引入人工智能（AI）到规模化内容生产，以下这些无头电商应用场景将助您充分释放可组合式架构（composable architecture）的潜力。

### Prioritize the developer experience to create faster  
### 以开发者体验为先，加速创新落地

A headless architecture empowers developers to create at the moment of inspiration. With a managed frontend, teams can instantly introduce flexibility, simplicity, and speed into the development workflow. This is where Vercel can help.

无头架构赋能开发者在灵感迸发的瞬间即刻开发。借助托管式前端，团队能够即时为开发工作流注入灵活性、简洁性与速度。这正是 Vercel 大显身手之处。

Vercel is the platform leader, backed by a large developer community as the creators of [Next.js](https://nextjs.org/). With a fully-managed frontend like Vercel, your dev team can take advantage of git integrations, performance optimizations, and Vercel’s [Incremental Static Regeneration](https://vercel.com/docs/concepts/next.js/incremental-static-regeneration) (ISR) to create faster.

Vercel 是平台领导者，由庞大的开发者社区鼎力支持——其正是热门框架 [Next.js](https://nextjs.org/) 的缔造者。借助 Vercel 这类全托管式前端平台，您的开发团队可充分利用 Git 集成、性能优化，以及 Vercel 的[增量静态再生（Incremental Static Regeneration，ISR）](https://vercel.com/docs/concepts/next.js/incremental-static-regeneration)能力，显著加速构建过程。

![Shorter build times with ISR vs. longer builds without ISR.](images/your-guide-to-headless-commerce-vercel/img_015.jpg)![Shorter build times with ISR vs. longer builds without ISR.](images/your-guide-to-headless-commerce-vercel/img_016.jpg)Shorter build times with ISR vs. longer builds without ISR.

![采用 ISR 后构建时间更短 vs. 未采用 ISR 时构建时间更长。](images/your-guide-to-headless-commerce-vercel/img_015.jpg)![采用 ISR 后构建时间更短 vs. 未采用 ISR 时构建时间更长。](images/your-guide-to-headless-commerce-vercel/img_016.jpg)采用 ISR 后构建时间更短 vs. 未采用 ISR 时构建时间更长。

ISR improves site speed and SEO so that you can increase organic traffic with better Core Web Vitals. Now your team can balance site performance and data freshness—two key components for ecommerce sites.

ISR 提升网站加载速度与 SEO 表现，助您凭借更优的“核心网页指标（Core Web Vitals）”提升自然流量。如今，您的团队可在网站性能与数据新鲜度之间取得平衡——而这二者恰是电商网站的关键支柱。

![](images/your-guide-to-headless-commerce-vercel/img_017.png)

![](images/your-guide-to-headless-commerce-vercel/img_017.png)

[Desenio uses ISR to build faster](https://vercel.com/customers/desenio)

[Desenio 借助 ISR 实现更快构建](https://vercel.com/customers/desenio)

The world’s largest affordable art supplier [Desenio](https://vercel.com/customers/desenio) leverages ISR to shorten build times for their massive site, going from hours to minutes with Vercel.

全球最大的平价艺术用品供应商 [Desenio](https://vercel.com/customers/desenio) 利用 ISR 大幅缩短其超大规模网站的构建耗时——借助 Vercel，构建时间从数小时缩短至几分钟。

To further improve the developer experience, teams can rely on Vercel’s serverless infrastructure for hosting, scaling, and security. By using a tool for hosting and infrastructure, you can remove the obstacles that stand in your developers’ way. Built-in features like headless commerce integrations, secure previews, and built-in performance optimizations help, too—allowing you to get to market that much faster.

为进一步提升开发者体验，团队可依托 Vercel 的无服务器（serverless）基础设施实现托管、弹性伸缩与安全保障。通过统一的托管与基础设施工具，您能有效移除横亘在开发者面前的各类障碍。内置功能（如无头电商集成、安全预览环境、开箱即用的性能优化等）亦可提供有力支持——助您更快将产品推向市场。

### Personalize through experimentation

### 通过实验实现个性化

With a modern infrastructure, companies can provide the most relevant user experience without sacrificing performance. Methods like [A/B testing](https://vercel.com/templates/next.js/ab-testing-simple) and feature flags allow you to garner which products resonate most with your user through unique customer data. However, these tried-and-true methods can create latency or layout shifts—getting in the way of dynamic UX. With Vercel as part of your composable stack, you can experiment without relying on third-party scripts or client-side Javascript that hinder personalized user experiences.

依托现代化基础设施，企业可在不牺牲性能的前提下，为用户提供高度相关、高度个性化的体验。[A/B 测试](https://vercel.com/templates/next.js/ab-testing-simple) 和功能开关（feature flags）等成熟方法，可帮助您基于独特的客户数据，精准识别哪些商品最能引发用户共鸣。然而，这些久经验证的方法有时会引入延迟或布局偏移（layout shifts），反而阻碍动态用户体验的实现。当 Vercel 成为您可组合技术栈（composable stack）中的一环，您便无需依赖第三方脚本或影响性能的客户端 JavaScript，即可安全、高效地开展个性化实验。

> “We can show the control or experiment version of a page immediately instead of using third-party scripts. This results in better performance and removes the likelihood of flickering/layout shifts.”  
> “我们可以立即呈现页面的对照版本或实验版本，而无需依赖第三方脚本。这提升了性能，并彻底避免了页面闪烁或布局偏移（flickering/layout shifts）问题。”

> ![](images/your-guide-to-headless-commerce-vercel/img_018.png)  
> ![](images/your-guide-to-headless-commerce-vercel/img_018.png)

> **Software Engineer at SumUp**  
> **SumUp 公司软件工程师**

[**Explore the Edge**  
**探索边缘计算能力**  
\\  
Learn more about A/B testing and feature flags with Vercel Edge Middleware.  
深入了解如何借助 Vercel Edge Middleware 实现 A/B 测试与功能开关（feature flags）。  
\\  
Learn more  
了解更多](https://vercel.com/features/edge-functions)

### Invest in AI  
### 投资人工智能（AI）

Leading commerce brands are [taking advantage of AI](https://vercel.com/blog/deploying-ai-applications) to boost customer retention using chatbots or virtual assistants, invest in real-time analytics to better predict demand, and adopt AI-powered auto-suggest tools to present results based on search intent. And that’s just the start of what AI-adoption can unlock for digital storefronts. By adopting a headless architecture, companies can easily expand their backend to include the latest AI tools, so they can keep up with the changing landscape and beat the competition.  
领先的电商品牌正[积极应用人工智能（AI）](https://vercel.com/blog/deploying-ai-applications)：通过聊天机器人或虚拟助手提升客户留存率；投资实时分析能力以更精准地预测市场需求；采用 AI 驱动的自动推荐工具，根据用户搜索意图呈现更相关的结果。而这仅仅是 AI 赋能数字门店所释放潜力的开端。借助无头架构（headless architecture），企业可轻松扩展后端系统，无缝集成最新 AI 工具，从而紧跟技术演进趋势，在竞争中脱颖而出。

### Surpass the new performance standards  
### 超越新一代性能标准

An online store that loads in just one second achieves a conversion rate that’s [2.5x higher](https://www.portent.com/blog/analytics/research-site-speed-hurting-everyones-revenue.htm) than an ecommerce site that loads in 5 seconds. As such, companies aiming to create the most performant site possible often measure their site’s performance using [Google Core Web Vitals](https://vercel.com/blog/core-web-vitals).  
仅需 1 秒即可完成加载的在线商店，其转化率比加载耗时 5 秒的电商网站高出[2.5 倍](https://www.portent.com/blog/analytics/research-site-speed-hurting-everyones-revenue.htm)。因此，致力于打造极致性能网站的企业，通常会采用 [Google Core Web Vitals](https://vercel.com/blog/core-web-vitals) 来衡量自身网站的性能表现。

Introduced in 2021, Core Web Vitals are an array of metrics that tell Google how fast, stable, and performant your site is. Key metrics measured include LCP, CLS, and TTFB. A headless architecture allows organizations to build performant tech stacks featuring managed frontends that often have built-in analytics capabilities. Using [Vercel Analytics](https://vercel.com/analytics), developers can track key performance metrics, pinpoint bottlenecks, and identify trends to prioritize what to improve and optimize for an ideal user experience.  
Core Web Vitals（核心网页指标）于 2021 年推出，是一组用于向 Google 表明网站加载速度、稳定性及整体性能表现的关键指标，主要包括最大内容绘制（LCP）、累积布局偏移（CLS）和首字节时间（TTFB）。无头架构使企业能够构建高性能技术栈——其中托管式前端（managed frontends）往往已内置分析能力。借助 [Vercel Analytics](https://vercel.com/analytics)，开发者可追踪关键性能指标、准确定位性能瓶颈，并识别优化趋势，从而明确改进优先级，持续优化以实现理想的用户体验。

### **Create content at scale**  
### **规模化内容创作**

As your organization begins to grow, content creation becomes more important. Blog authors, stylists, merchandisers, marketers, etc. will all have their own content they’ll want to create and publish. Rather than having them rely on developers to publish content or make frontend changes, empower them with self-service headless CMS solutions. Contentful, Storyblok, and Sanity are a few solutions that, when paired with Vercel, ecommerce stores can count on.  
随着组织规模不断扩大，内容创作的重要性日益凸显。博客作者、造型师、商品企划人员、营销人员等各类角色，均需自主创建并发布专属内容。与其让这些非技术人员反复依赖开发人员来发布内容或修改前端，不如为他们配备自助式无头 CMS（Headless CMS）解决方案。Contentful、Storyblok 和 Sanity 等平台，结合 Vercel 使用后，已成为众多电商网站值得信赖的内容管理选择。

When it comes to the content that requires a developer’s help to create, like new landing pages, [Vercel’s Deployment Previews](https://vercel.com/features/previews) can make a major impact on collaboration. Instead of sharing screenshots or dealing with a complex staging process, stakeholders can see a live preview of pages. You can even test changes within the browser and run automated tests for performance and reliability with one click.  
对于仍需开发者参与创建的内容（例如全新落地页），[Vercel 的部署预览（Deployment Previews）](https://vercel.com/features/previews) 将极大提升团队协作效率。各方干系人无需再通过截图沟通，也无需应对繁琐的预发布（staging）流程，而是可直接查看页面的实时预览效果。您甚至可在浏览器内直接测试变更效果，并一键运行自动化测试，全面评估性能与可靠性。

## **Taking the next step**

## **迈出下一步**

By decoupling the frontend and backend, teams across your organization can be more independent, collaborate better, and create content quicker. To learn more about how you can create fast ecommerce sites at scale:

通过将前端与后端解耦，您组织内的各个团队可以更加独立、协作更高效，并更快地创建内容。如需深入了解如何大规模构建高性能电商网站：

- [Download our ecommerce ebook](https://vercel.com/try/ebook-ecomm) for ways to improve your storefront and bottom line

- [下载我们的电商电子书](https://vercel.com/try/ebook-ecomm)，了解提升店铺体验与盈利能力的方法

- [Read the guide](https://vercel.com/blog/using-the-latest-next-js-12-3-features-on-vercel) on how to use Deploy Hooks with Vercel and a headless CMS

- [阅读指南](https://vercel.com/blog/using-the-latest-next-js-12-3-features-on-vercel)，了解如何在 Vercel 上结合无头 CMS 使用部署钩子（Deploy Hooks）

- Learn how to [use Headless WordPress](https://vercel.com/guides/wordpress-with-vercel) with Next.js and Vercel

- 了解如何在 Next.js 和 Vercel 上[使用无头 WordPress](https://vercel.com/guides/wordpress-with-vercel)

Vercel Template

Vercel 模板

Deploy this template

部署此模板

### Builder.io starter for Headless Shopify stores.

### 面向无头 Shopify 商店的 Builder.io 入门模板

Builder.io Shopify Commerce

Builder.io Shopify 商务解决方案

Customer case study

客户案例研究

Nov 30, 2022

2022 年 11 月 30 日

### With Next.js, Vercel, and Sanity, Loom empowers every team to iterate

### 借助 Next.js、Vercel 和 Sanity，Loom 赋能每个团队快速迭代

![](images/your-guide-to-headless-commerce-vercel/img_019.jpg)

![](images/your-guide-to-headless-commerce-vercel/img_019.jpg)

Greta Workman

格蕾塔·沃克曼
&#123;% endraw %}
