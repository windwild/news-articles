---
title: "The Frontend Cloud: Resiliency for global web applications - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/the-resiliency-of-the-frontend-cloud"
date: "2024-02-29"
scraped_at: "2026-03-02T09:47:15.414877274+00:00"
language: "en-zh"
translated: true
description: "Optimize your web presence for maximum uptime, scalability, and security. Discover the power of frontend clouds for enterprise resilience."
---
&#123;% raw %}

Feb 29, 2024

2024 年 2 月 29 日

Ensure business continuity and customer trust with an unbreakable web foundation.

以坚不可摧的网页基础设施，保障业务连续性与客户信任。

Modern web apps are global, omni-channel and fast. Above all else they must be _available at all times._ Every second of website downtime translates to lost revenue and eroded customer trust.

现代网页应用具有全球化、全渠道和高性能的特点。而最重要的是，它们必须 _始终在线_。网站每中断一秒钟，就意味着收入损失与客户信任的削弱。

Leveraging Vercel's Frontend Cloud allows you to:

借助 Vercel 前端云，您可实现：

- [Effortlessly scale to meet even the highest demand](https://vercel.com/blog/the-resiliency-of-the-frontend-cloud#scale-to-infinity-(and-back-down-to-zero))

- [轻松扩展，从容应对任何峰值流量需求](https://vercel.com/blog/the-resiliency-of-the-frontend-cloud#scale-to-infinity-(and-back-down-to-zero))

- [Decrease pressure and reliance on backend providers](https://vercel.com/blog/the-resiliency-of-the-frontend-cloud#high-availability-by-default)

- [降低对后端服务提供商的压力与依赖](https://vercel.com/blog/the-resiliency-of-the-frontend-cloud#high-availability-by-default)

- [Actively and automatically defend against threats to your infrastructure](https://vercel.com/blog/the-resiliency-of-the-frontend-cloud#built-for-security-methods-of-attack-mitigation)

- [主动且自动地抵御针对您基础设施的安全威胁](https://vercel.com/blog/the-resiliency-of-the-frontend-cloud#built-for-security-methods-of-attack-mitigation)

- [Have peace of mind that any service interruption will be rapidly and responsibly resolved](https://vercel.com/blog/the-resiliency-of-the-frontend-cloud#maintaining-peace-of-mind-incident-response)

- [安心无忧：任何服务中断都将被快速、负责任地响应与解决](https://vercel.com/blog/the-resiliency-of-the-frontend-cloud#maintaining-peace-of-mind-incident-response)


[**No matter the traffic.**\\
\\
Our experts will analyze your specific use case and ensure that Vercel keeps your site available to your users in every circumstance.\\
\\
Contact Us](https://vercel.com/contact/sales)

[**无论流量多大。**\\
\\
我们的专家将深入分析您的具体使用场景，确保在任何情况下，Vercel 都能让您的网站持续向用户可用。\\
\\
联系我们](https://vercel.com/contact/sales)

## Scale to infinity (and back down to zero)

## 可无限扩展（亦可缩容至零）

We say _scale to infinity_ a lot in Vercel’s marketing materials. It’s a fun phrase, but what does it mean for your site's massive traffic spikes, such as [Black Friday](https://vercel.com/resources/how-to-prepare-your-site-for-black-friday-traffic#see-it-in-action-nzxt-scales-for-black-friday-with-no-downtime) or [a major swag drop](https://vercel.com/blog/serving-millions-of-users-on-the-new-mrbeast-storefront)?

我们在 Vercel 的营销材料中频繁提到“_无限扩展（scale to infinity）_”这一说法。这听起来很酷，但它对您的网站应对大规模流量激增（例如[黑色星期五](https://vercel.com/resources/how-to-prepare-your-site-for-black-friday-traffic#see-it-in-action-nzxt-scales-for-black-friday-with-no-downtime)或[大型周边商品发放活动](https://vercel.com/blog/serving-millions-of-users-on-the-new-mrbeast-storefront)）究竟意味着什么？

> “To keep up with our incredibly spiky traffic and the sheer amount of data streaming in, we need a solution that has the primary benefit of static sites—easy and instant scalability—with the benefit of dynamic sites—responsive to quickly-changing data—without rebuilding the whole project.To keep up with our incredibly spiky traffic and the sheer amount of data streaming in, we need a solution that has the primary benefit of static sites—easy and instant scalability—with the benefit of dynamic sites—responsive to quickly-changing data—without rebuilding the whole project.”
>
> ![](images/the-frontend-cloud-resiliency-for-global-web-applications-vercel/img_001.jpg)
>
> **Tyler Fisher,** Principal Software Engineer

> “为应对我们极其陡峭的流量峰值以及海量实时涌入的数据，我们需要一种解决方案：它兼具静态站点的核心优势——轻松、即时的可扩展性；又拥有动态站点的关键能力——对快速变化的数据做出实时响应——且无需重建整个项目。”  
>   
> ![](images/the-frontend-cloud-resiliency-for-global-web-applications-vercel/img_001.jpg)  
>   
> **泰勒·费舍尔（Tyler Fisher）**，首席软件工程师

In contrast to traditional server-based environments, where resource allocation and load balancing are manual infrastructure concerns that can limit application responsiveness and scalability, the [serverless architecture of the Frontend Cloud](https://vercel.com/blog/the-foundations-of-the-frontend-cloud#what-is-serverless-architecture) dynamically manages compute resources for each request.

与传统基于服务器的环境不同——在后者中，资源分配与负载均衡属于需人工干预的基础设施问题，往往制约着应用的响应速度与扩展能力——[前端云（Frontend Cloud）的无服务器架构](https://vercel.com/blog/the-foundations-of-the-frontend-cloud#what-is-serverless-architecture)则为每一次请求动态调配计算资源。

**This ensures that each interaction, regardless of the number of users or the intensity of demand, is processed with the same efficiency and speed.** It also means that you only pay for the traffic your site experiences. No more preallocation guessing games or load-balancing.

**这确保了每一次用户交互——无论并发用户数量多少、需求强度多高——均能以同等效率与速度完成处理。** 同时，您只需为您网站实际产生的流量付费，彻底告别资源预分配的“猜测游戏”与复杂的负载均衡配置。

Vercel's infrastructure scales automatically based on demand.

Vercel 的基础设施会根据实时需求自动伸缩。

Plus, your whole website—whether static or dynamic, gets [granularly cached on Vercel’s Edge Network](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud), which has [18 compute-capable data](https://vercel.com/docs/edge-network/regions) centers across the globe, with [over 100 points of presence (POPs)](https://vercel.com/docs/edge-network/regions#regions-and-content-delivery) to route traffic to your users with maximal efficiency.

此外，您的整个网站——无论静态还是动态——都会被[细粒度缓存在 Vercel 的边缘网络（Edge Network）](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud)上。该网络在全球范围内拥有[18 个具备计算能力的数据中心](https://vercel.com/docs/edge-network/regions)，并部署了[超过 100 个接入点（Points of Presence, POPs）](https://vercel.com/docs/edge-network/regions#regions-and-content-delivery)，可将流量以最高效率路由至您的终端用户。

**There’s no reason that millions of user requests couldn’t go through at any given time**, and thanks to serverless and intelligent caching, all end-users get the same low-latency experience. Your business can seamlessly handle traffic spikes without any manual intervention.

**在任意时刻，数百万用户请求同时涌入完全不是问题**；依托无服务器架构与智能缓存机制，所有终端用户均可获得一致的低延迟体验。您的业务可在零人工干预的前提下，从容应对任何流量高峰。

We say you can _scale_ _to infinity_ because we haven’t found a practical limit. We say you can scale to zero because your business costs should be predictable, even if traffic isn't.

我们说您可以“_无限扩展（scale to infinity）_”，是因为迄今尚未发现实际可用的性能上限；我们说您可以“_缩容至零（scale to zero）_”，是因为您的业务成本理应可预测——哪怕流量本身不可预测。

> “Vercel is the best and easiest platform for high-traffic product launches. Our site handled a 350% traffic spike flawlessly without thinking too hard on our backend infrastructure.Vercel is the best and easiest platform for high-traffic product launches. Our site handled a 350% traffic spike flawlessly without thinking too hard on our backend infrastructure.”
>
> ![](images/the-frontend-cloud-resiliency-for-global-web-applications-vercel/img_002.png)
>
> **Jason Donnette,** Co-founder

> “Vercel 是面向高流量产品发布的最佳、最易用的平台。我们的网站在后端基础设施几乎无需额外投入的情况下，完美承载了高达 350% 的流量激增。”  
>   
> ![](images/the-frontend-cloud-resiliency-for-global-web-applications-vercel/img_002.png)  
>   
> **杰森·多内特（Jason Donnette）**，联合创始人

With Vercel's serverless infrastructure and Edge Network capabilities, major clients such as Under Armour, Sonos, and NZXT have drastically increased site performance, even during peak traffic events like Black Friday and Cyber Monday. NZXT, for instance, experienced a 20% improvement in page performance at _peak_ traffic.

凭借 Vercel 的无服务器基础设施与边缘网络能力，安德玛（Under Armour）、声望（Sonos）和 NZXT 等重量级客户，在黑色星期五、网络星期一等流量峰值期间，网站性能均实现大幅跃升。以 NZXT 为例，其页面性能在_峰值流量时段_提升了 20%。

Vercel has also been the platform of choice for _The Washington Post_ during the [high-stakes election night](https://vercel.com/customers/washington-post-next.js-vercel-engineering-at-the-speed-of-breaking-news), who noted that, with Vercel, "it was the smoothest election night anyone could remember."

Vercel 也一直是《华盛顿邮报》在[高关注度的选举之夜](https://vercel.com/customers/washington-post-next.js-vercel-engineering-at-the-speed-of-breaking-news)期间的首选平台。该报指出，借助 Vercel，“这是人们记忆中最为顺畅的一次选举之夜。”

[**Scale without limits.**\\
\\
Let's discuss how Vercel handles your application's demand, freeing you to focus on building innovative applications, not managing infrastructure.\\
\\
Contact Us](https://vercel.com/contact/sales)

[**无限扩展能力。**\\
\\
让我们探讨 Vercel 如何应对您应用的流量需求，让您专注于构建创新应用，而非管理基础设施。\\
\\
联系我们](https://vercel.com/contact/sales)

## High availability by default

## 默认高可用性

Scalability is only one part of network resiliency. Just as challenging is ensuring your application stays up even if major providers go down.

可扩展性仅是网络弹性的一部分；同样具有挑战性的是：即使主要云服务提供商发生故障，您的应用仍能持续在线。

Architecting and sustaining "four nines uptime" (99.99%) multi-region cloud infrastructure is inherently complex and costly. Vercel simplifies this with [built-in high-availability features](https://vercel.com/blog/effortless-high-availability-for-dynamic-frontends) that require no additional setup or maintenance overhead.

设计并长期维持“四个九”（99.99%）可用性的多区域云基础设施，本身即极为复杂且成本高昂。Vercel 通过[内置的高可用性功能](https://vercel.com/blog/effortless-high-availability-for-dynamic-frontends)，大幅简化了这一过程——无需额外配置，亦无运维负担。

### **Regional failover**

### **区域级故障转移**

In the case of a large-scale regional cloud outage, Vercel enables applications to switch to backup regions automatically. This works both for traffic routing _and_ the execution of serverless functions.

当发生大规模区域性云服务中断时，Vercel 可自动将应用切换至备用区域。该机制同时适用于流量路由与无服务器函数（serverless functions）的执行。

For traffic, Vercel’s use of [optimized global Anycast routing](https://vercel.com/blog/effortless-high-availability-for-dynamic-frontends#initiating-at-edge-optimized-global-routing) automatically directs user requests to the nearest available network edge, in the rare event of a full-region outage.

在流量层面，Vercel 借助[优化的全球 Anycast 路由](https://vercel.com/blog/effortless-high-availability-for-dynamic-frontends#initiating-at-edge-optimized-global-routing)，可在极少数整区域完全中断的情况下，自动将用户请求导向最近的可用网络边缘节点。

With serverless functions, customers often run their primary compute in a single or small number of regions, to maintain proximity to their data. This is why Vercel allows choosing your specific [Function Failover](https://vercel.com/docs/functions/configuring-functions/region#automatic-failover) region, for as little disruption to end users as possible.

对于无服务器函数，客户通常将核心计算资源部署于单个或少数几个区域，以保障与数据源的地理邻近性。正因如此，Vercel 允许您自主指定[函数故障转移](https://vercel.com/docs/functions/configuring-functions/region#automatic-failover)的目标区域，从而将对终端用户的干扰降至最低。

![Vercel Functions can automatically failover to the next healthy region.](images/the-frontend-cloud-resiliency-for-global-web-applications-vercel/img_003.jpg)![Vercel Functions can automatically failover to the next healthy region.](images/the-frontend-cloud-resiliency-for-global-web-applications-vercel/img_004.jpg)Vercel Functions can automatically failover to the next healthy region.

![Vercel 函数可自动故障转移到下一个健康区域。](images/the-frontend-cloud-resiliency-for-global-web-applications-vercel/img_003.jpg)![Vercel 函数可自动故障转移到下一个健康区域。](images/the-frontend-cloud-resiliency-for-global-web-applications-vercel/img_004.jpg)Vercel 函数可自动故障转移到下一个健康区域。

### **Durable caching**

### **持久化缓存**

Vercel’s Edge Network [automatically and granularly caches](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud#vercel's-edge-network) your application as your users access it. For instance, with Next.js, if one piece of component-level data changes, Vercel can recache just that component, without an application redeploy.

Vercel 的边缘网络（Edge Network）会在用户访问您的应用时，**自动且细粒度地缓存**您的应用。例如，在使用 Next.js 时，若某组件层级的数据发生变更，Vercel 仅需重新缓存该组件，而无需重新部署整个应用。

This means you don't need to roundtrip to your backend for the majority of the time users see data. **Granular, durable caching greatly reduces demand on your backend infrastructure and helps prevent it from buckling under traffic spikes.**

这意味着在绝大多数用户查看数据的场景中，您无需往返请求后端。**细粒度、持久化的缓存可大幅降低后端基础设施的负载压力，并有效防止其在流量激增时崩溃。**

If, however, any of your backend providers do go down, Vercel's Edge Network will continue to serve your cached content in a `stale-if-error` state indefinitely. This ensures uninterrupted, fast-as-static read access for users. While this cached content might be temporarily out-of-date, it provides a significantly better user experience than downtime.

然而，一旦您的任一后端服务出现故障，Vercel 边缘网络将持续以 `stale-if-error`（出错时返回陈旧内容）状态无限期地提供已缓存的内容。这确保了用户始终能获得**不间断、静态资源般快速的读取体验**。尽管这些缓存内容可能暂时过时，但其用户体验仍远优于服务完全中断。

Plus, once your backend provider returns online, the Frontend Cloud will once again granularly update your data, without an application redeploy or even (with Next.js) a page reload.

此外，一旦您的后端服务恢复在线，前端云（Frontend Cloud）将再次以细粒度方式更新您的数据——**既无需重新部署应用，甚至（在 Next.js 场景下）也无需刷新页面**。

### Backend failover

### 后端故障转移

When you need to ensure high availability for backend, [Vercel’s Edge Config](https://vercel.com/docs/storage/edge-config) allows pushing configuration updates to your global compute fleet with minimal latency and _without requiring redeployment_. This makes it ideal for the failover of your application to a backup system.

当您需要保障后端服务的高可用性时，[Vercel 的 Edge Config](https://vercel.com/docs/storage/edge-config) 可让您以极低延迟、**无需重新部署**的方式，将配置更新推送到全球计算节点集群。这使其成为应用切换至备用系统的理想故障转移方案。

For instance, if your primary database has an outage, you can use Edge Config to quickly re-route your compute to use a new database address. You have extensive tooling to configure data redundancy and customize where to send your users in case of failure.

例如，若主数据库发生宕机，您可通过 Edge Config 快速重定向计算逻辑，使其连接新的数据库地址。您还可借助丰富的工具链，灵活配置数据冗余策略，并自定义故障发生时用户流量的路由目的地。

### Instant rollback

### 即时回滚

If, for any reason, a mission-critical bug makes it to your production deployment, Vercel offers the ability to instantly roll back to any previous deployment—without a rebuild.

如果因任何原因，一个关键性缺陷被发布到了您的生产环境，Vercel 提供**即时回滚至任意历史部署版本**的能力——**无需重新构建**。

There are [many ways to set up testing](https://vercel.com/blog/the-developer-experience-of-the-frontend-cloud#testing) and even [create smart Conformance rulesets](https://vercel.com/blog/the-developer-experience-of-the-frontend-cloud#conformance) to ensure pushes to prod never bring you down, but the big red button is always there if you need it.

有[多种方式来设置测试](https://vercel.com/blog/the-developer-experience-of-the-frontend-cloud#testing)，甚至可以[创建智能的合规性规则集（Conformance rulesets）](https://vercel.com/blog/the-developer-experience-of-the-frontend-cloud#conformance)，以确保向生产环境（prod）推送代码时永远不会导致服务中断；但当你真正需要时，那个醒目的红色按钮始终就在那里。

![With Instant Rollback you can quickly revert to a previous production deployment, making it easier to fix breaking changes.](images/the-frontend-cloud-resiliency-for-global-web-applications-vercel/img_005.jpg)![With Instant Rollback you can quickly revert to a previous production deployment, making it easier to fix breaking changes.](images/the-frontend-cloud-resiliency-for-global-web-applications-vercel/img_006.jpg)With Instant Rollback you can quickly revert to a previous production deployment, making it easier to fix breaking changes.

![使用 Instant Rollback，你可以快速回滚到之前的生产环境部署版本，从而更轻松地修复破坏性变更。](images/the-frontend-cloud-resiliency-for-global-web-applications-vercel/img_005.jpg)![使用 Instant Rollback，你可以快速回滚到之前的生产环境部署版本，从而更轻松地修复破坏性变更。](images/the-frontend-cloud-resiliency-for-global-web-applications-vercel/img_006.jpg)使用 Instant Rollback，你可以快速回滚到之前的生产环境部署版本，从而更轻松地修复破坏性变更。

### Resiliency testing

### 弹性测试（Resiliency Testing）

Vercel conducts [recurring resiliency testing](https://vercel.com/docs/security#resiliency-testing) for all network infrastructure. These tests, which simulate regional failures, also benchmark recovery time and alert on any disruptions.

Vercel 对全部网络基础设施开展[周期性弹性测试](https://vercel.com/docs/security#resiliency-testing)。这些测试通过模拟区域性故障，同时对恢复时间进行基准评测，并在发生任何中断时发出告警。

It’s this level of service that lets Vercel’s Frontend Cloud be trusted by so many industry leaders. Customers such as Unity, [Box.com](http://box.com/), Patreon, Notion, and [Loom](https://vercel.com/customers/loom-headless-with-nextjs) rely on Vercel for seamless service with zero downtime.

正是这种服务水平，使 Vercel 的前端云（Frontend Cloud）赢得了众多行业领军企业的信赖。Unity、[Box.com](http://box.com/)、Patreon、Notion 和 [Loom](https://vercel.com/customers/loom-headless-with-nextjs) 等客户均依赖 Vercel 提供零停机、无缝衔接的服务。

> “Last Black Friday and Cyber Monday was the first in NZXT’s 20-year history with zero downtime. That literally translates to millions of dollars.Last Black Friday and Cyber Monday was the first in NZXT’s 20-year history with zero downtime. That literally translates to millions of dollars.”
>
> ![](images/the-frontend-cloud-resiliency-for-global-web-applications-vercel/img_007.png)
>
> **Director of Engineering,** NZXT

> “上一个黑色星期五（Black Friday）和网络星期一（Cyber Monday）是 NZXT 创立 20 年以来首次实现零停机。这直接意味着数百万美元的收益。”  
>   
> ![](images/the-frontend-cloud-resiliency-for-global-web-applications-vercel/img_007.png)  
>   
> **工程总监**，NZXT

## Built for security: Methods of attack mitigation

## 为安全而构建：攻击缓解方法

But what if someone _tries_ to take your app down? With large-scale applications come high business costs for any point of failure.

但如果有人**试图**让您的应用下线呢？对于大规模应用而言，任一故障点都可能带来高昂的业务损失。

That’s why Vercel's Frontend Cloud takes a multi-faceted approach to security that includes [industry-standard compliance measures](https://vercel.com/docs/security#), [data encryption](https://vercel.com/docs/security#data-encryption), and [threat detection in its infrastructure](https://vercel.com/docs/security/vercel-waf).

因此，Vercel 前端云采用多维度安全策略，涵盖[业界标准的合规性措施](https://vercel.com/docs/security#)、[数据加密](https://vercel.com/docs/security#data-encryption)，以及其基础设施中的[威胁检测能力（Vercel WAF）](https://vercel.com/docs/security/vercel-waf)。

### **Managed infrastructure**

### **托管式基础设施**

_Managed infrastructure_ means that Vercel is [responsible for your application’s underlying infrastructure](https://vercel.com/docs/security/shared-responsibility), including its security and availability.

_托管式基础设施_ 意味着 Vercel 负责您应用程序底层基础设施的运维，包括其安全性与可用性。

**Because the Frontend Cloud has specialized teams dedicated to maintaining and protecting its infra, this weight gets lifted off your organization.**

**由于前端云（Frontend Cloud）拥有专门负责维护与保护其基础设施的团队，这一负担便从您的组织中彻底卸下。**

The security measures of the Frontend Cloud are based on years of learning, implementation, battle-testing, and compliance—and implemented in your codebase by default.

前端云的安全措施建立在多年的经验积累、实践落地、实战检验与合规验证基础之上——并默认集成至您的代码库中。

### Threat detection

### 威胁检测

Since the Frontend Cloud brings [underlying infrastructure into one cohesive environment](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud#how-does-caching-work), it can also comprehensively search that infrastructure for connected patterns of malicious behavior.

由于前端云将底层基础设施整合为一个统一、连贯的运行环境，因此它还能全面扫描该基础设施，识别出相互关联的恶意行为模式。

Vercel Firewall offers [robust Distributed Denial of Service (DDoS) mitigation](https://vercel.com/docs/security/ddos-mitigation) through continuous monitoring of traffic. DDoS mitigation blocks harmful traffic while allowing legitimate requests to pass through, and dynamically scales resources during a DDoS attack to absorb the increased traffic, preventing applications or websites from ever being overwhelmed.

Vercel 防火墙通过持续的流量监控，提供[强大的分布式拒绝服务（DDoS）防护能力](https://vercel.com/docs/security/ddos-mitigation)。DDoS 防护机制可拦截恶意流量，同时放行合法请求；并在 DDoS 攻击发生时动态扩展资源容量，以承载激增的流量，从而确保您的应用或网站永不因过载而瘫痪。

With [Attack Challenge Mode](https://vercel.com/docs/security/attack-challenge-mode), you can further protect against DDoS attacks and quickly lock down traffic by challenging requests, minimizing the chance that malicious bots get through. When temporarily enabled, all visitors to your site will see a challenge screen before they are allowed through.

借助 [攻击挑战模式（Attack Challenge Mode）](https://vercel.com/docs/security/attack-challenge-mode)，您可进一步强化对 DDoS 攻击的防御能力：通过对请求发起验证挑战，快速限制异常流量，最大限度降低恶意机器人绕过防护的风险。该模式临时启用后，所有访问您网站的用户均需先通过验证页面，方可继续访问。

![Vercel Firewall allows you to write custom IP blocking rules.](images/the-frontend-cloud-resiliency-for-global-web-applications-vercel/img_008.jpg)![Vercel Firewall allows you to write custom IP blocking rules.](images/the-frontend-cloud-resiliency-for-global-web-applications-vercel/img_009.jpg)Vercel Firewall allows you to write custom IP blocking rules.

![Vercel 防火墙支持编写自定义 IP 封禁规则。](images/the-frontend-cloud-resiliency-for-global-web-applications-vercel/img_008.jpg)![Vercel 防火墙支持编写自定义 IP 封禁规则。](images/the-frontend-cloud-resiliency-for-global-web-applications-vercel/img_009.jpg)Vercel 防火墙支持编写自定义 IP 封禁规则。

Additionally, custom firewall rules for [IP blocking](https://vercel.com/docs/security/firewall-rules#ip-blocking) allow you to restrict access to your applications or websites based on the IP addresses of incoming requests. This means you can block malicious actors via IP addresses from viewing your site, preventing unauthorized access or unwanted traffic.

此外，您还可借助 [IP 封禁类自定义防火墙规则](https://vercel.com/docs/security/firewall-rules#ip-blocking)，依据入站请求的源 IP 地址，限制对您应用或网站的访问权限。换言之，您可通过封禁恶意行为者的 IP 地址，阻止其访问您的网站，从而杜绝未授权访问及不良流量。

When possible, the Frontend Cloud also offers [proactive protection against major provider vulnerabilities](https://vercel.com/changelog/vercel-firewall-proactively-protects-against-vulnerability-in-the-clerk-sdk). Vercel works hard to ensure that [vulnerabilities are patched](https://vercel.com/changelog/vercel-has-proactively-protected-against-a-vulnerability-in-the-sentry-next) at the network level while the provider creates an official patch.

在条件允许的情况下，前端云还提供[针对主流服务商重大漏洞的主动防护能力](https://vercel.com/changelog/vercel-firewall-proactively-protects-against-vulnerability-in-the-clerk-sdk)。Vercel 致力于在相关服务商发布正式补丁前，率先在网络层面完成漏洞修复，确保您的应用安全无虞。

### Isolated systems and private connections

### 隔离系统与私有连接

Next is the idea of “ [zero trust](https://www.crowdstrike.com/cybersecurity-101/cloud-security/cloud-security-best-practices/)”—the Frontend Cloud isolates all systems by default. Each serverless function, for instance, is inherently isolated from every other function, which means attacks don't spread across systems.

接下来是“[零信任](https://www.crowdstrike.com/cybersecurity-101/cloud-security/cloud-security-best-practices/)”理念——前端云（Frontend Cloud）默认对所有系统实施隔离。例如，每个无服务器函数（serverless function）天然与其他所有函数相互隔离，这意味着攻击无法在系统间横向扩散。

This concept is stretched across all Vercel’s infrastructure, where unique systems don’t keep open access to each other, but rather reestablish conditional connections per request.

这一理念贯穿 Vercel 全部基础设施：各独立系统之间不保持持续开放的访问权限，而是按需、在每次请求时动态建立受条件约束的安全连接。

If your organization needs more assurance, Vercel's Frontend Cloud offers [isolated build infrastructure](https://vercel.com/docs/security#do-enterprise-accounts-run-on-a-different-infrastructure) and even [entire private networks](https://vercel.com/docs/security/secure-compute) for enterprise customers.

若您组织需要更高程度的安全保障，Vercel 前端云为大型企业客户提供了[隔离式构建基础设施](https://vercel.com/docs/security#do-enterprise-accounts-run-on-a-different-infrastructure)，甚至支持部署[完整的私有网络](https://vercel.com/docs/security/secure-compute)。

![With Secure Compute, you can create connections between your Vercel Serverless Functions, deployment builds, and backend cloud infrastructure to further restrict access to authorized sources.](images/the-frontend-cloud-resiliency-for-global-web-applications-vercel/img_010.jpg)![With Secure Compute, you can create connections between your Vercel Serverless Functions, deployment builds, and backend cloud infrastructure to further restrict access to authorized sources.](images/the-frontend-cloud-resiliency-for-global-web-applications-vercel/img_011.jpg)With Secure Compute, you can create connections between your Vercel Serverless Functions, deployment builds, and backend cloud infrastructure to further restrict access to authorized sources.

![使用 Secure Compute，您可在 Vercel 无服务器函数、部署构建及后端云基础设施之间建立连接，从而进一步限制仅允许授权来源访问。](images/the-frontend-cloud-resiliency-for-global-web-applications-vercel/img_010.jpg)![使用 Secure Compute，您可在 Vercel 无服务器函数、部署构建及后端云基础设施之间建立连接，从而进一步限制仅允许授权来源访问。](images/the-frontend-cloud-resiliency-for-global-web-applications-vercel/img_011.jpg)借助 Secure Compute，您可在 Vercel 无服务器函数、部署构建及后端云基础设施之间建立连接，从而进一步限制仅允许授权来源访问。

Within Vercel's Frontend Cloud, you can create private connections between Serverless Functions and your backend cloud, such as databases and other private infrastructure.‌ This also allows you to securely connect your frontend on Vercel to services like Kubernetes, Terraform, and more.

在 Vercel 前端云内，您可为无服务器函数与后端云（如数据库及其他私有基础设施）之间创建私有连接。该能力还可让您安全地将部署于 Vercel 的前端应用接入 Kubernetes、Terraform 等各类服务。

### Deployment Authentication and SAML SSO

### 部署身份认证与 SAML 单点登录（SSO）

Your deployments within the frontend cloud also benefit from zero-trust architecture and access to them is restricted by default. Vercel offers various methods of authentication for more [fine-grained control of your deployment protection](https://vercel.com/docs/security/deployment-protection).

前端云内的所有部署同样受益于零信任架构，默认受到严格访问控制。Vercel 提供多种身份认证方式，助您实现更[精细化的部署安全防护](https://vercel.com/docs/security/deployment-protection)。

One such authentication method, for enterprise users, is [Vercel’s SAML Single Sign-On (SSO) integration](https://vercel.com/docs/security/saml), which enhances security and efficiency for your entire business.

其中一种面向企业用户的认证方式，是 [Vercel 的 SAML 单点登录（SSO）集成](https://vercel.com/docs/security/saml)，它可全面提升您整个业务的安全性与运营效率。

By providing a unified login across various applications, SAML SSO reduces security risks, eliminating the need for multiple credentials and lowering the chance of phishing or other unauthorized access.

SAML SSO 通过在各类应用间提供统一登录入口，显著降低安全风险：既无需维护多套凭据，也大幅减少了钓鱼攻击或其他未授权访问发生的可能性。

SAML SSO also centralizes access management, streamlining the onboarding process, permission adjustments, and compliance adherence—all of which optimize IT resources.

SAML 单点登录（SSO）还实现了访问管理的集中化，从而简化了员工入职流程、权限调整以及合规性遵循——所有这些都有助于优化 IT 资源。

This all, in turn, improves employee productivity, reducing login interruptions in day-to-day responsibilities.

上述各项措施进而提升了员工生产力，减少了日常工作中因频繁登录而造成的中断。

[**Industry-leading security.**\\
\\
Learn more about Vercel's robust security and DDoS mitigation for your critical applications.\\
\\
Talk with an Expert](https://vercel.com/contact/sales)

[**业界领先的网络安全能力。**\\
\\
深入了解 Vercel 为您的关键应用所提供的强大安全防护与 DDoS 缓解机制。\\
\\
联系专家咨询](https://vercel.com/contact/sales)

## Maintaining peace of mind: Service interruption response

## 安心无忧：服务中断响应机制

When the unexpected occurs, Vercel's robust service interruption response process ensures timely resolution and transparent communication with customers.

当意外情况发生时，Vercel 健全的服务中断响应流程可确保问题得到及时解决，并向客户保持透明、及时的沟通。

- **Proactive monitoring and early detection:** Vercel's infrastructure is closely monitored for potential anomalies. Alerting systems signal issues early, allowing our teams to respond before they escalate into widespread incidents.

- **主动监控与早期预警：** Vercel 的基础设施持续接受严密监控，以识别潜在异常；告警系统可在问题初现端倪时即发出信号，使我们的团队能在事态升级为大规模事件前迅速响应。

- **Swift initial response:** When an incident is detected, a dedicated response team is assembled immediately. This team includes engineers, product experts, and communication specialists with deep knowledge of Vercel's infrastructure.

- **快速初始响应：** 一旦检测到事件，将立即组建一支专职响应团队。该团队由工程师、产品专家及传播专员组成，均具备对 Vercel 基础设施的深入理解。

- **Structured triage and prioritization:** Incidents are classified based on impact and severity to prioritize the most critical issues. This structured approach allows for efficient resource allocation and faster resolutions.

- **结构化分级与优先级判定：** 根据事件的影响范围与严重程度进行分类，从而优先处理最关键的问题。这一结构化方法有助于高效调配资源，并加快问题解决速度。

- **Transparent and timely updates:** On our [public status page](https://www.vercel-status.com/), we commit to providing regular and clear updates about service degradation and issues impacting the platform. This includes details on incident status, the scope of impact, and steps being taken to resolve the situation.

- **透明且及时的信息更新：** 在我们的[公开状态页](https://www.vercel-status.com/)上，我们承诺定期发布清晰明确的公告，通报服务性能下降及影响平台运行的相关问题。内容包括事件当前状态、影响范围，以及正在采取的解决措施。

- **Post-incident analysis:** We conduct a thorough root-cause analysis (RCA) to identify the underlying causes of incidents and prevent future occurrences. Lessons learned are used to continuously enhance our incident response and overall system reliability.

- **事件后复盘分析：** 我们开展全面的根因分析（RCA），以查明事件发生的根本原因，并防止同类问题再次发生。所汲取的经验教训将持续用于优化事件响应流程，并全面提升系统整体可靠性。

- **Commitment to reliability:** Vercel's uptime history demonstrates our dedication to maintaining a robust and resilient platform. You can find [historical incident reports](https://www.vercel-status.com/history) on our status page, allowing you to make informed decisions.

- **对可靠性的承诺：** Vercel 的正常运行时间历史记录彰显了我们致力于构建并维护一个稳健、高韧性的平台。您可在我们的状态页面查阅[历史事件报告](https://www.vercel-status.com/history)，从而做出更明智的决策。

Knowing that Vercel has a comprehensive incident response plan empowers you to focus on building and innovating rather than worrying about downtime. Our rapid response procedures aim to reduce the reach and duration of problems, protecting your end-users from negative experiences.

了解 Vercel 拥有全面的事件响应计划，能让您专注于开发与创新，而无需为服务中断而担忧。我们的快速响应流程旨在最大限度地缩小问题影响范围、缩短故障持续时间，从而保护终端用户免受不良体验影响。

**We understand that your business relies on Vercel. Our Incident Response Process reflects our commitment to being a steadfast steward of your critical applications.**

**我们深知您的业务高度依赖 Vercel。我们的事件响应流程，正体现了我们作为您关键应用坚定守护者的郑重承诺。**

## Why choose the Frontend Cloud?

## 为何选择前端云（Frontend Cloud）？

In this article, we discussed the Frontend Cloud’s resiliency, through the lenses of application scalability, network availability, and infrastructure security.

本文中，我们从应用可扩展性、网络可用性及基础设施安全性三个维度，探讨了前端云（Frontend Cloud）的高韧性表现。

We explored how the Frontend Cloud:

我们深入探讨了前端云（Frontend Cloud）如何实现：

- Can process millions of user requests at a given time in its globally distributed data centers.

- 借助其全球分布的数据中心，可同时处理数百万用户请求。

- Lessens the load on your backend infrastructure and keeps your application fully available, even if multiple service providers go down.

- 减轻您后端基础设施的负载，即使多个服务提供商发生宕机，仍能确保您的应用始终完全可用。

- Adopts a multi-faceted approach to security, with a zero-trust model—backed by industry-accepted compliance certifications and attestations.

- 采用多层面安全策略，以零信任（zero-trust）模型为核心，并获得业界公认的各项合规认证与合规声明支持。

- Is regularly battle-tested by huge companies conducting business around the globe without interruption.

- 已被众多全球性大型企业长期实战验证——这些企业在世界各地持续开展业务，从未中断。

- Responds efficiently and transparently to service degradation, ensuring you can focus on building your product.  
- 高效、透明地响应服务降级，确保您能专注于产品构建。

Vercel's Frontend Cloud empowers you to deliver an effortless and secure customer experience, no matter the circumstance. It's the foundation for business continuity, growth, and resilience.  
Vercel 前端云赋能您在任何情况下都能为客户提供顺畅且安全的体验。它是保障业务连续性、推动增长与增强韧性的基石。

[**Ready to get started?**\\
\\
Our experts are here to help you explore how Vercel can safeguard your critical web applications and propel your business forward.\\
\\
Contact Us](https://vercel.com/contact/sales)  
[**立即开始？**\\
\\
我们的专家随时为您服务，助您深入了解 Vercel 如何保护您的关键 Web 应用，并推动业务持续向前发展。\\
\\
联系我们](https://vercel.com/contact/sales)

Vercel.com landing page  
Vercel.com 官网落地页

### Stop configuring and start innovating.  
### 停止繁琐配置，开启创新之旅。

Vercel.com landing page  
Vercel.com 官网落地页

### Learn more about Vercel's infrastructure.  
### 进一步了解 Vercel 的基础设施。
&#123;% endraw %}
