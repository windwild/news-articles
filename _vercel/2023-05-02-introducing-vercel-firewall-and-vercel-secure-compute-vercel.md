---
title: "Introducing Vercel Firewall and Vercel Secure Compute - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-security"
date: "2023-05-02"
scraped_at: "2026-03-02T09:52:55.034078869+00:00"
language: "en-zh"
translated: true
description: "Vercel Secure Compute and Vercel Firewall for enhanced protection of your applications"
---

May 2, 2023

2023 年 5 月 2 日

We're bringing more enterprise-grade offerings for enhanced security of your applications and infrastructure.

我们正推出更多面向企业级用户的解决方案，以增强您应用与基础设施的安全性。

Finding the right balance between developer experience and robust enterprise-grade security can be challenging. Developers want tools that streamline workflows and enhance productivity, while organizations prioritize security measures to protect sensitive data and meet compliance standards. At Vercel, we believe you can have the best of both worlds—exceptional developer experience and top-tier security.

在开发者体验与强大企业级安全之间找到恰当的平衡点颇具挑战。开发者希望使用能简化工作流、提升生产力的工具；而企业则更关注安全措施，以保护敏感数据并满足合规要求。Vercel 坚信：二者兼得并非奢望——卓越的开发者体验与顶级安全防护完全可以并行不悖。

Today we're excited to announce [Vercel Secure Compute](https://vercel.com/changelog/improve-infrastructure-security-with-vercel-secure-compute) and [Vercel Firewall](https://vercel.com/docs/security/vercel-firewall), in addition to existing security features in Vercel's frontend cloud, to enhance the protection of your applications and infrastructure.

今天，我们很高兴地宣布推出 [Vercel Secure Compute](https://vercel.com/changelog/improve-infrastructure-security-with-vercel-secure-compute) 和 [Vercel Firewall](https://vercel.com/docs/security/vercel-firewall)，并结合 Vercel 前端云中已有的各项安全功能，全方位强化您应用与基础设施的安全防护能力。

- Private connections with Vercel Secure Compute  
- 借助 Vercel Secure Compute 实现私有连接  

- DDoS mitigation and IP Blocking with Vercel Firewall  
- 借助 Vercel Firewall 实现 DDoS 防护与 IP 封禁  

- Seamless authentication through partnerships with leading security providers  
- 通过与主流安全厂商合作，实现无缝身份认证  

## Secure connections: HTTPS and Secure Compute

## 安全连接：HTTPS 与 Secure Compute

Secure connections are crucial when transmitting data between your application and backend infrastructure, whether you're handling user login credentials, processing payment information, or exchanging sensitive data with APIs.

当您的应用与后端基础设施之间传输数据时（例如处理用户登录凭据、处理支付信息，或与 API 交换敏感数据），建立安全连接至关重要。

We believe every application should be secure by default. That's why we encrypt data in transit and at rest with free, always-on SSL. This is a best-in-class security practice given to every customer and project on Vercel out of the box.

我们坚信：每一款应用都应默认具备安全性。因此，我们为所有数据提供免费、始终启用的 SSL 加密——无论数据处于传输中还是静态存储状态。这一业界领先的安全实践，已作为开箱即用的功能，惠及 Vercel 上的每一位客户与每一个项目。

When it comes to securing connections between Serverless Functions and backend cloud infrastructure, some customers have additional regulations that require private infrastructure.

在 Serverless 函数与后端云基础设施之间建立安全连接时，部分客户因额外合规要求，必须使用私有基础设施。

We're excited to introduce [Vercel Secure Compute](https://vercel.com/changelog/improve-infrastructure-security-with-vercel-secure-compute) for [Enterprise](https://vercel.com/enterprise) customers. By enabling Secure Compute, your deployments and builds will be placed in a private network with dedicated IP addresses and logically separated from other networks.

我们很高兴为 [Enterprise](https://vercel.com/enterprise) 客户推出 [Vercel Secure Compute](https://vercel.com/changelog/improve-infrastructure-security-with-vercel-secure-compute)。启用 Secure Compute 后，您的部署和构建将运行于一个具备专属 IP 地址的私有网络中，并在逻辑上与其他网络完全隔离。

![](images/introducing-vercel-firewall-and-vercel-secure-compute-vercel/img_001.jpg)![](images/introducing-vercel-firewall-and-vercel-secure-compute-vercel/img_002.jpg)

![](images/introducing-vercel-firewall-and-vercel-secure-compute-vercel/img_001.jpg)![](images/introducing-vercel-firewall-and-vercel-secure-compute-vercel/img_002.jpg)

With Secure Compute, you can create connections between your [Vercel Serverless Functions](https://vercel.com/docs/concepts/functions/serverless-functions), deployment builds, and backend cloud infrastructure to further restrict access to authorized sources.

借助 Secure Compute，您可在 [Vercel Serverless Functions](https://vercel.com/docs/concepts/functions/serverless-functions)、部署构建环境与后端云基础设施之间建立连接，从而进一步限制访问权限，仅允许经授权的来源接入。

[**Get started**\\
\\
For more information about IP blocking or Secure Compute on Vercel Enterprise, or if you require support for VPC peering or VPN connections, please contact our sales team.\\
\\
Contact Us](https://vercel.com/contact/sales)

[**立即开始**\\
\\
如需了解有关 Vercel Enterprise 中 IP 封禁或 Secure Compute 的更多信息，或需要 VPC 对等连接（VPC Peering）或 VPN 连接支持，请联系我们的销售团队。\\
\\
联系我们](https://vercel.com/contact/sales)

## The Vercel Firewall

## Vercel 防火墙

As your web applications become more interconnected and accessible, they also become more vulnerable to external threats. Among these threats, distributed denial-of-service (DDoS) attacks are particularly concerning, causing significant downtime, damage of user trust, and financial and reputational losses.

随着您的 Web 应用日益互联与开放，其遭受外部威胁的风险也随之上升。在各类威胁中，分布式拒绝服务（DDoS）攻击尤为令人担忧——它可能导致严重的服务中断、用户信任受损，并带来财务与声誉上的双重损失。

To help protect your applications from these threats, we're happy to introduce new capabilities to the Vercel Firewall: a security solution designed to defend your frontend cloud deployments. Vercel Firewall offers powerful DDoS mitigation capabilities to defend your applications so that they can remain available and responsive even in the face of large-scale DDoS attacks.

为帮助您抵御上述威胁，我们很高兴为 Vercel 防火墙（Vercel Firewall）新增多项功能：这是一套专为保护前端云部署而设计的安全解决方案。Vercel 防火墙提供强大的 DDoS 缓解能力，确保您的应用即使遭遇大规模 DDoS 攻击，仍能持续可用并保持响应能力。

![](images/introducing-vercel-firewall-and-vercel-secure-compute-vercel/img_003.jpg)![](images/introducing-vercel-firewall-and-vercel-secure-compute-vercel/img_004.jpg)

![](images/introducing-vercel-firewall-and-vercel-secure-compute-vercel/img_003.jpg)![](images/introducing-vercel-firewall-and-vercel-secure-compute-vercel/img_004.jpg)

Our new custom firewall rules for [IP blocking](https://vercel.com/docs/security/vercel-waf/ip-blocking) allow you to restrict access to your applications or websites based on the IP addresses of incoming requests. This means you can block malicious actors via IP addresses from viewing your site, preventing unauthorized access or unwanted traffic.

我们全新推出的自定义防火墙规则支持 [IP 封禁](https://vercel.com/docs/security/vercel-waf/ip-blocking)，使您能够根据入站请求的源 IP 地址，限制对应用或网站的访问。这意味着您可以直接通过 IP 地址屏蔽恶意行为者，阻止其访问您的站点，从而防范未授权访问及异常流量。

By using IP blocking in conjunction with our automated DDoS mitigation, Enterprise users can further strengthen security posture and maintain control over who can access your applications and websites.

通过将 IP 封禁与我们的自动化 DDoS 缓解机制相结合，企业用户可进一步强化安全态势，并持续掌控哪些用户能够访问您的应用程序和网站。

## Authentication and authorization

## 身份认证与授权

Authentication and authorization form the foundation of access control, ensuring that only trusted users can interact with your application and only perform actions within their designated permissions.

身份认证与授权构成了访问控制的基础，确保仅有受信任的用户才能与您的应用程序交互，且仅能执行其被授予权限范围内的操作。

Thanks to a new era of robust, developer-first tooling like [Auth.js](https://authjs.dev/), [Clerk](https://vercel.com/integrations/clerk), and [Auth0](https://vercel.com/templates/auth0), you can manage auth with just a few lines of code.

得益于 Auth.js、Clerk 和 Auth0 等新一代强大且以开发者为中心的工具（如 [Auth.js](https://authjs.dev/)、[Clerk](https://vercel.com/integrations/clerk) 和 [Auth0](https://vercel.com/templates/auth0)），您只需几行代码即可完成身份认证管理。

> “As a team and as a business we need to keep evolving with our customers and the threat landscape to ensure we are at the forefront of identity and security for our customers.As a team and as a business we need to keep evolving with our customers and the threat landscape to ensure we are at the forefront of identity and security for our customers.”
>
> ![](images/introducing-vercel-firewall-and-vercel-secure-compute-vercel/img_005.png)
>
> **Jameeka Green Aaron,** Chief Information Security Officer at Auth0

> “作为一支团队、也作为一家企业，我们必须持续随客户及威胁环境的演进而不断进化，以确保我们在客户的身份认证与安全领域始终处于最前沿。作为一支团队、也作为一家企业，我们必须持续随客户及威胁环境的演进而不断进化，以确保我们在客户的身份认证与安全领域始终处于最前沿。”
>
> ![](images/introducing-vercel-firewall-and-vercel-secure-compute-vercel/img_005.png)
>
> **Jameeka Green Aaron**，Auth0 首席信息安全官（CISO）

## Continuous monitoring and audits

## 持续监控与审计

While implementing robust security measures is essential for safeguarding your web applications, security is not a one-time effort—it requires continuous monitoring and vigilance.

尽管部署健全的安全措施对于保护您的 Web 应用程序至关重要，但安全并非一劳永逸的工作——它需要持续的监控与警觉。

We understand the critical role that monitoring plays in the security and performance of your frontend cloud deployments. That's why we introduced [Vercel Monitoring](https://vercel.com/docs/concepts/observability/monitoring/overview) and [Logs](https://vercel.com/docs/concepts/observability/runtime-logs), a comprehensive monitoring solution designed to provide you with actionable insights into your application's behavior, performance, and security.

我们深知监控在前端云部署的安全性与性能中所起的关键作用。正因如此，我们推出了 [Vercel 监控（Vercel Monitoring）](https://vercel.com/docs/concepts/observability/monitoring/overview) 与 [日志（Logs）](https://vercel.com/docs/concepts/observability/runtime-logs) ——一套全面的监控解决方案，旨在为您提供有关应用行为、性能与安全状况的可操作洞察。

![](images/introducing-vercel-firewall-and-vercel-secure-compute-vercel/img_006.jpg)![](images/introducing-vercel-firewall-and-vercel-secure-compute-vercel/img_007.jpg)

![](images/introducing-vercel-firewall-and-vercel-secure-compute-vercel/img_006.jpg)![](images/introducing-vercel-firewall-and-vercel-secure-compute-vercel/img_007.jpg)

With Monitoring, you can quickly identify and diagnose issues, optimize performance, and ensure a seamless user experience. Whether you're seeing increased bandwidth and web traffic spikes or performance degradation on a request path, Vercel Monitoring provides visibility into Serverless Functions, API endpoints, or static assets. This makes it easier to form data-driven decisions and continuously improve your application.

借助 Vercel 监控，您可以快速识别并诊断问题、优化性能，并保障流畅的用户体验。无论您观察到带宽激增、网页流量骤升，还是某条请求路径出现性能下降，Vercel 监控均可为您呈现 Serverless 函数、API 端点或静态资源的运行状态。这有助于您基于数据做出决策，并持续改进应用。

Security is a cornerstone of successful frontend cloud adoption, and Vercel is dedicated to providing robust solutions that empower organizations to build and deploy with confidence. As we continue to innovate and expand our offerings, we remain committed to supporting you on your development journey, helping you create secure, performant, and resilient web applications that deliver exceptional experiences to users around the world.

安全性是前端云成功落地的基石，Vercel 致力于提供强大可靠的解决方案，赋能企业自信地构建与部署应用。在我们持续创新并拓展产品能力的同时，我们始终坚定支持您的开发之旅，助您打造安全、高性能且具备韧性的 Web 应用，为全球用户交付卓越体验。

[**Take the next step**  
\\  
Reach out to an expert to learn more about security on Vercel for your Enterprise.  
\\  
Get in Touch](https://vercel.com/contact/sales)

[**迈出下一步**  
\\  
联系专家，深入了解 Vercel 企业版的安全能力。  
\\  
立即联系](https://vercel.com/contact/sales)

Vercel.com landing page

Vercel.com 首页

### See how teams ship faster with frontend cloud

### 前端云如何助力团队加速交付

Blog post

博客文章

Feb 17, 2023

2023 年 2 月 17 日

### How Indent delivers secure access with Next.js and Vercel

### Indent 如何借助 Next.js 与 Vercel 实现安全访问

![](images/introducing-vercel-firewall-and-vercel-secure-compute-vercel/img_008.png)

![](images/introducing-vercel-firewall-and-vercel-secure-compute-vercel/img_008.png)

Alli Pope

Alli Pope