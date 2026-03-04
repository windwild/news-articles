---
title: "Retailer sees $10M increase in sales on Vercel - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/retailer-sees-10m-increase-in-sales-on-vercel"
date: "2024-11-27"
scraped_at: "2026-03-02T09:38:58.451952440+00:00"
language: "en-zh"
translated: true
description: "A global sportswear retailer had a record-breaking Black Friday-Cyber Monday last year, which increased sales by $10M: 33% increase in average orders per minute, 500ms reduction in Time to First Byte,..."
---

render_with_liquid: false
Nov 27, 2024

2024年11月27日

一家全球运动服饰零售商借助 Vercel 创下破纪录的假日购物周末销售佳绩

#### 订单量平均每分钟提升 33%

#### 速度比仅使用 Salesforce Commerce Cloud 快 10 倍

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

这家顶级全球零售商创立于30年前，已在运动服饰与服装行业确立了领导地位。其产品线丰富多元，涵盖专业运动装备、鞋类、配饰及休闲服饰，以对创新与品质的坚定承诺而广受赞誉。该公司在纽约证券交易所（NYSE）上市，2024年营收近60亿美元，全球员工约16,000人。尽管面临严峻的零售环境挑战，该公司在电商领域持续表现卓越：直面消费者（DTC）收入增长3%，达23亿美元；其中，电商渠道贡献占比高达41%。

## **面临的挑战**

## **挑战所在**

该零售商正处于数字化转型的关键节点，亟需提升用户体验并优化系统性能。其当前所采用的 Salesforce Commerce Cloud 平台在高峰流量时段（例如“黑色星期五”）暴露出显著瓶颈，主要挑战包括：

### **Performance issues:**

### **性能问题：**

Page load speeds and overall site performance were suboptimal, impacting user experience and potentially leading to a lower conversion rate. The site relied heavily on high-resolution hero images for personalization, creating significant performance bottlenecks. Client-side personalization caused performance regressions, requiring loading the initial hero image, then reloading a personalized version based on user data. This double-loading process negatively affected Largest Contentful Paint (LCP) metrics, creating poor user experiences.

页面加载速度和整体网站性能欠佳，影响了用户体验，并可能降低转化率。网站高度依赖高分辨率的首屏大图（hero images）实现个性化，由此引发显著的性能瓶颈。客户端个性化导致性能退化：需先加载初始首屏图，再根据用户数据重新加载个性化版本。这种双重加载过程严重拖慢了最大内容绘制（Largest Contentful Paint, LCP）指标，造成不良用户体验。

### **Organizational complexity:**

### **组织复杂性：**

Performance issues are even more complicated by team ownership being spread across different parts of the organization, making it difficult to coordinate improvements.

团队职责分散于组织内不同部门，进一步加剧了性能问题的复杂性，使得跨团队协同优化变得异常困难。

### **Scalability concerns:**

### **可扩展性问题：**

The retailer's digital infrastructure struggled to handle high traffic volumes, particularly during peak sales events like Black Friday and Cyber Monday, which saw spikes of 125,000 visitors per hour. An overwhelming amount of redirects and insufficient scalability resulted in site slowdowns and downtime, negatively impacting user experience and sales potential.

该零售商的数字基础设施难以应对高并发流量，尤其在“黑色星期五”（Black Friday）和“网络星期一”（Cyber Monday）等销售高峰期间——每小时访客量激增至12.5万人。海量重定向请求叠加系统扩展能力不足，导致网站响应迟缓甚至宕机，严重损害用户体验与销售潜力。

### **Technical debt and architectural limitations:**

### **技术债务与架构局限性：**

Salesforce Commerce Cloud's monolithic architecture restricted the retailer's ability in adopting modern, headless technologies. The platform’s rigid structure and complexity made it difficult to deploy rapid innovations and improvements, limiting their ability to deliver personalized customer experiences. Additionally, Salesforce Commerce Cloud required specific expertise from a limited talent pool of developers, resulting in high costs for hiring and retaining specialized expertise.

Salesforce Commerce Cloud 的单体式（monolithic）架构限制了零售商采用现代无头（headless）技术的能力。该平台结构僵化、复杂度高，难以快速部署创新功能与优化改进，从而制约其提供个性化客户体验的能力。此外，Salesforce Commerce Cloud 需要具备特定技能的开发人员，而这类人才储备有限，导致招聘与留用专业人才的成本居高不下。

These challenges created a perfect storm: poor performance affecting user experience, scalability issues impacting sales, and technical limitations preventing quick solutions. The retailer needed a modern, flexible platform that could handle their complex personalization needs while delivering exceptional performance at scale.

上述挑战共同酿成一场“完美风暴”：性能低下损害用户体验，可扩展性不足制约销售增长，技术局限又阻碍快速响应与解决。该零售商亟需一个现代化、高灵活性的平台，在满足其复杂个性化需求的同时，实现大规模下的卓越性能表现。

## **The solution**

## **解决方案**

Vercel's comprehensive solution offered multiple compelling advantages. Vercel Functions and Middleware capabilities enabled management of millions of visitors across multiple domains while delivering personalized user experiences. As the creators of Next.js—a critical component of the ecommerce platform—Vercel provided expert guidance throughout the implementation process:

Vercel 的综合解决方案提供了多项极具吸引力的优势。Vercel Functions 和中间件（Middleware）功能支持在多个域名下管理数百万访客，同时提供个性化的用户体验。作为电商平合关键组件 Next.js 的缔造者，Vercel 在整个实施过程中提供了专业指导：

- **Phased migration:** Initially planning a 5-month homepage migration, they saw positive results from A/B testing against Salesforce Commerce Cloud and rapidly accelerated the entire migration. Product Detail Pages (PDPs) and Product Listing Pages (PLPs) were added within two months, ensuring everything was ready for Black Friday

- **分阶段迁移：** 最初计划用 5 个月完成首页迁移，但在与 Salesforce Commerce Cloud 进行 A/B 测试后即获得积极结果，随即大幅加快了整体迁移进度。商品详情页（PDPs）和商品列表页（PLPs）均在两个月内上线，确保所有页面在“黑色星期五”前准备就绪。

- **Enhanced performance and scalability:** Vercel's architecture provided significant performance improvements, including a 500ms reduction in Time to First Byte (TTFB). Vercel's automatic failover and function payload redundancy gave the retailer added confidence, ensuring minimal downtime during critical outages

- **性能与可扩展性提升：** Vercel 的架构带来了显著的性能优化，包括首字节时间（TTFB）缩短 500 毫秒。Vercel 自动故障转移机制及函数负载冗余设计，进一步增强了零售商的信心，确保在重大故障期间实现极低的停机时间。

![After moving from a monolithic Salesforce Commerce Cloud setup to a headless architecture, leveraging Vercel for frontend delivery, caching, and compute. ](images/retailer-sees-10m-increase-in-sales-on-vercel-vercel/img_001.jpg)![After moving from a monolithic Salesforce Commerce Cloud setup to a headless architecture, leveraging Vercel for frontend delivery, caching, and compute. ](images/retailer-sees-10m-increase-in-sales-on-vercel-vercel/img_002.jpg)After moving from a monolithic Salesforce Commerce Cloud setup to a headless architecture, leveraging Vercel for frontend delivery, caching, and compute.

![从单体式 Salesforce Commerce Cloud 架构迁移到无头架构，并利用 Vercel 实现前端交付、缓存与计算。](images/retailer-sees-10m-increase-in-sales-on-vercel-vercel/img_001.jpg)![从单体式 Salesforce Commerce Cloud 架构迁移到无头架构，并利用 Vercel 实现前端交付、缓存与计算。](images/retailer-sees-10m-increase-in-sales-on-vercel-vercel/img_002.jpg)从单体式 Salesforce Commerce Cloud 架构迁移到无头架构，并利用 Vercel 实现前端交付、缓存与计算。

## **Business impact**

## **商业影响**

The collaboration between the retailer and Vercel yielded impressive results. For the first time, the company experienced a Black Friday without any site downtime—a milestone that translated into millions of dollars in revenue. With Vercel they saw:

零售商与 Vercel 的合作取得了令人瞩目的成果。公司首次实现了“黑色星期五”期间网站零宕机——这一里程碑直接转化为数百万美元的营收增长。借助 Vercel，他们实现了：

- 2% increase in overall conversions and a 5x increase in conversion rate at their peak

- 整体转化率提升 2%，峰值时段转化率提升达 5 倍；

- 10x faster than Salesforce Commerce Cloud alone in load testing

- 负载测试性能达纯 Salesforce Commerce Cloud 的 10 倍；

- 500ms reduction in Time to First Byte

- 首字节时间（TTFB）缩短 500 毫秒；

- 33% increase in average orders per minute compared to the previous year

- 每分钟平均订单量较上年增长 33%。

The company's record-breaking holiday weekend was highlighted by a $10 million revenue increase, bringing in $48 million compared to $38 million in the prior year.

公司的破纪录假日周末表现突出：营收增长1000万美元，达4800万美元，较上年的3800万美元显著提升。

[**Ready for the future of ecommerce?**  
**已为电商的未来做好准备？**

Unlock performance and flexibility with headless commerce. Next.js and Vercel let you modernize your storefront without replacing your backend.  
借助无头电商（headless commerce）释放性能与灵活性。Next.js 与 Vercel 让您无需替换后端，即可实现 storefront 的现代化升级。

## **Approaching Black Friday with confidence**  
## **自信迎战黑色星期五**

The retailer's team experienced a significant shift in mindset. The confidence in the platform's stability allowed them to focus on proactive improvements fixing small UI bugs rather than reactive mission critical problem solving.  
该零售商团队经历了显著的心态转变：对平台稳定性的充分信心，使其得以将重心转向主动优化——例如修复细微的 UI 缺陷，而非疲于应对紧急的关键性问题。

> “We're so bored because nothing's happening—we're just watching the sales go up. We're so bored because nothing's happening—we're just watching the sales go up.”  
> “我们简直无聊透了——因为什么都没发生！我们只是眼看着销售额不断攀升。我们简直无聊透了——因为什么都没发生！我们只是眼看着销售额不断攀升。”

> ![](images/retailer-sees-10m-increase-in-sales-on-vercel-vercel/img_003.png)  
> ![](images/retailer-sees-10m-increase-in-sales-on-vercel-vercel/img_003.png)

> **Lead Developer**  
> **首席开发工程师**

This global sportswear retailer's successful migration to Vercel is a strategic partnership. As the retailer continues to innovate and enhance its digital presence, the partnership with Vercel remains a critical component of its strategy to deliver exceptional user experiences and drive business success.  
这家全球知名运动服饰零售商成功迁移到 Vercel，标志着双方达成一项战略性合作。随着该零售商持续推动创新、强化数字影响力，其与 Vercel 的合作仍将是其实现卓越用户体验、驱动业务成功的核心战略支柱。

Vercel.com landing page  
Vercel.com 着陆页

### Salesforce Commerce Cloud + Vercel  
### Salesforce Commerce Cloud + Vercel

Vercel.com landing page  
Vercel.com 着陆页

### Composable commerce on Vercel  
### 基于 Vercel 的可组合式电商（Composable Commerce）