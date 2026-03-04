---
title: "How Dub grew to 3,000 active domains with Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-dub-grew-to-3000-active-domains-with-vercels-multi-tenant-saas-toolkit"
date: "2024-05-03"
scraped_at: "2026-03-02T09:45:18.394650519+00:00"
language: "en-zh"
translated: true
description: "The open-source link management platform Dub boasts over 3,000 active domains—and growing—with Vercel's multi-tenant SaaS toolkit. Learn how."
---
&#123;% raw %}

May 3, 2024

2024 年 5 月 3 日

Vercel 为 Dub 提供了可扩展的构建能力，使其应用能够面向不同域名的多个客户提供服务。

#### 3,000

当前活跃域名数量

#### 500 万

每月链接重定向次数

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

Web Analytics

网页分析

[Dub](https://dub.co/) is an open-source link management platform that helps marketing teams create marketing campaigns, link sharing features, and referral programs. Currently, Dub boasts over 3,000 active domains, growing at a remarkable 25% month-over-month rate.

[Dub](https://dub.co/) 是一个开源链接管理平台，可帮助营销团队创建营销活动、链接分享功能及推荐计划。目前，Dub 拥有超过 3,000 个活跃域名，月环比增长率高达 25%。

## **Building for scale**

## **面向规模化构建**

Since partnering with Vercel, Dub has experienced:

自与 Vercel 建立合作以来，Dub 实现了以下进展：

- 3,000 active domains, with a 25% month-over-month growth  
- 3,000 个活跃域名，月环比增长 25%  

- 5 million redirects per month, growing at a 40% month-over-month rate  
- 每月 500 万次重定向，月环比增长 40%  

- Streamlined domain addition and management processes  
- 域名添加与管理流程显著简化  

- Increased scalability, handling thousands of domains with ease  
- 可扩展性大幅提升，轻松支持数千个域名  

## **Simplifying the complexity of domain management**

## **化繁为简：简化域名管理的复杂性**

Vercel’s powerful API allowed Dub to efficiently manage custom domains from the outset. Vercel simplified the otherwise complex process of setting up reverse proxies and issuing SSL certificates, which allows Dub to easily provision new custom domains on behalf of their users via a simple API call. This ease of integration has been pivotal in Dub's ability to scale quickly and focus on innovation rather than backend complexities.

Vercel 强大的 API 使 Dub 自项目初期便能高效管理自定义域名。Vercel 简化了原本极为复杂的反向代理配置与 SSL 证书签发流程，使 Dub 仅需一次简单的 API 调用，即可代表用户快速开通新的自定义域名。这种便捷的集成方式，成为 Dub 实现快速规模化扩张、并将精力聚焦于产品创新而非后端复杂性的关键因素。

> “We needed a solution that was straightforward, and Vercel delivered just that with their API. An otherwise painful process, Vercel allows us to efficiently add or update domains on our platform and provides clear instructions for our users to configure the appropriate DNS records for those domains. We needed a solution that was straightforward, and Vercel delivered just that with their API. An otherwise painful process, Vercel allows us to efficiently add or update domains on our platform and provides clear instructions for our users to configure the appropriate DNS records for those domains.”
>
> “我们需要一个简单直接的解决方案，而 Vercel 凭借其 API 完美兑现了这一需求。原本令人头疼的流程，在 Vercel 的支持下变得高效顺畅——我们得以快速为平台添加或更新域名，并为用户提供清晰明确的操作指引，帮助他们正确配置对应域名的 DNS 记录。”

> ![](images/how-dub-grew-to-3_000-active-domains-with-vercel-vercel/img_001.jpg)
>
> **Steven Tey,** CEO at Dub
>
> **Steven Tey**，Dub 首席执行官

## **The challenge of SSL certificates and maintenance**

## **SSL 证书管理与维护的挑战**

Managing SSL certificates can be expensive and challenging, especially when dealing with different providers. Dub chose Vercel from the start, leveraging the [Vercel Domains API](https://vercel.com/docs/rest-api/endpoints/domains) to provide SSL certificates cost-effectively.

SSL 证书的管理既昂贵又充满挑战，尤其在对接多家服务商时尤为明显。Dub 自创立之初便选择 Vercel，并充分利用其 [Vercel Domains API](https://vercel.com/docs/rest-api/endpoints/domains)，以极具成本效益的方式为用户自动提供 SSL 证书。

This approach removed significant barriers typically associated with SSL management, allowing Dub to maintain high security without high costs. Users benefited from the simplified processes, resulting in quicker custom domain setups and more straightforward SSL management, contributing to higher user retention and satisfaction.

这一方案消除了 SSL 管理中常见的诸多障碍，使 Dub 在无需承担高昂成本的前提下，持续保障高安全性。用户则从中获益：自定义域名开通更迅速、SSL 管理更直观，从而显著提升了用户留存率与满意度。

[**Use Vercel's Domain API in your project to add and remove domains.**\\
\\
Learn how to programmatically add and remove domains from your platforms.\\
\\
Get Started](https://vercel.com/templates/next.js/domains-api)

[**在您的项目中使用 Vercel 的 Domain API 来添加和移除域名。**\\
\\
了解如何通过编程方式为您的平台动态添加或移除域名。\\
\\
立即开始](https://vercel.com/templates/next.js/domains-api)

## **Infrastructure designed to scale effortlessly**

## **专为无缝扩展而设计的基础设施**

The collaboration with Vercel has enabled Dub to efficiently serve and track **over 5 million link redirects per month**, with expectations to significantly increase by year-end.

得益于与 Vercel 的深度协作，Dub 已能高效地服务并追踪 **每月超 500 万次链接重定向**，且预计到今年年底该数字还将大幅增长。

This scalability is supported by Vercel’s managed infrastructure: serverless scalable compute that effortlessly handles increasing volumes of traffic and domain management tasks. Dub's continued growth underscores the transformative impact of choosing the right technology partner in Vercel.

这一可扩展性由 Vercel 托管式基础设施提供坚实支撑：其无服务器（serverless）架构具备天然弹性，可轻松应对不断攀升的流量压力与日益繁重的域名管理任务。Dub 持续稳健的增长，印证了选择 Vercel 作为关键技术合作伙伴所带来的变革性价值。

Vercel.com landing page

Vercel.com 官网落地页

### Multi-tenant SaaS

### 多租户 SaaS

Vercel Template

Vercel 模板

Deploy this template

部署此模板

### Next.js template for building multi-tenant applications with the App Router and Redis.

### 基于 App Router 和 Redis 构建多租户应用的 Next.js 模板

Platforms Starter Kit

Platforms 启动套件
&#123;% endraw %}
