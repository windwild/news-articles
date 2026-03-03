---
title: "Preventing infrastructure abuse with Vercel Firewall - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/preventing-infrastructure-abuse-with-vercel-firewall"
date: "2024-09-24"
scraped_at: "2026-03-02T09:41:01.733380742+00:00"
language: "en-zh"
translated: true
description: "DDoS resilience in the face of modern threats."
---

Sep 24, 2024

2024 年 9 月 24 日

DDoS resilience in the face of modern threats.

面对现代威胁的 DDoS 抗御能力。

In any given week, [Vercel Firewall](https://vercel.com/docs/security/vercel-firewall) blocks around 1 billion suspicious TCP connections, with some days seeing upwards of 7 billion malicious HTTP requests. Vercel's platform is designed to automatically [mitigate DDoS attacks](https://vercel.com/docs/security/ddos-mitigation), blocking thousands of these threats every day to keep your site secure and operational without user intervention. Vercel is built to minimize disruptions and safeguard your resources from unnecessary costs by serving only legitimate traffic.

在任意一周内，[Vercel 防火墙](https://vercel.com/docs/security/vercel-firewall) 会拦截约 10 亿次可疑的 TCP 连接；某些日期甚至拦截超过 70 亿次恶意 HTTP 请求。Vercel 平台专为自动[缓解 DDoS 攻击](https://vercel.com/docs/security/ddos-mitigation)而设计，每天可拦截数千次此类威胁，从而在无需用户干预的情况下保障您网站的安全性与正常运行。Vercel 架构旨在最大限度减少中断，并通过仅服务合法流量来保护您的资源，避免产生不必要的费用。

![Over the past 30 days, Vercel's system Firewall blocked over 4.4 billion request attempts, in addition to blocks made by each customer's Web Application Firewall.](images/preventing-infrastructure-abuse-with-vercel-firewall-vercel/img_001.jpg)![Over the past 30 days, Vercel's system Firewall blocked over 4.4 billion request attempts, in addition to blocks made by each customer's Web Application Firewall.](images/preventing-infrastructure-abuse-with-vercel-firewall-vercel/img_002.jpg)

![过去 30 天内，Vercel 系统防火墙拦截了超过 44 亿次请求尝试，此外还包含各客户 Web 应用防火墙（WAF）所执行的拦截。](images/preventing-infrastructure-abuse-with-vercel-firewall-vercel/img_001.jpg)![过去 30 天内，Vercel 系统防火墙拦截了超过 44 亿次请求尝试，此外还包含各客户 Web 应用防火墙（WAF）所执行的拦截。](images/preventing-infrastructure-abuse-with-vercel-firewall-vercel/img_002.jpg)

Over the past 30 days, Vercel's system Firewall blocked over 4.4 billion request attempts, in addition to blocks made by each customer's Web Application Firewall.

过去 30 天内，Vercel 系统防火墙拦截了超过 44 亿次请求尝试，此外还包含各客户 Web 应用防火墙（WAF）所执行的拦截。

Recently, Vercel successfully mitigated a major DDoS attack, peaking at 1.37 Tbps and over 300 million packets per second (Mpps), with no downtime, impact, or manual config. This recent attack on Vercel highlights the complexity of modern DDoS threats, which can involve overwhelming data volumes, high packet rates, or a combination of both.

近期，Vercel 成功缓解了一次大规模 DDoS 攻击，峰值达 1.37 Tbps，且每秒数据包数量（PPS）超过 3 亿（Mpps），全程零宕机、零影响、无需人工配置。此次针对 Vercel 的攻击凸显了现代 DDoS 威胁的复杂性——其可能表现为海量数据洪流、超高数据包速率，或二者兼而有之。

![Vercel quickly mitigated a DDoS attack that peaked at 1.37 Tbps within the first 2 minutes and lasted around 8 minutes.](images/preventing-infrastructure-abuse-with-vercel-firewall-vercel/img_003.jpg)![Vercel quickly mitigated a DDoS attack that peaked at 1.37 Tbps within the first 2 minutes and lasted around 8 minutes.](images/preventing-infrastructure-abuse-with-vercel-firewall-vercel/img_004.jpg)

![Vercel 在前两分钟内即快速缓解了一次峰值达 1.37 Tbps 的 DDoS 攻击，整场攻击持续约 8 分钟。](images/preventing-infrastructure-abuse-with-vercel-firewall-vercel/img_003.jpg)![Vercel 在前两分钟内即快速缓解了一次峰值达 1.37 Tbps 的 DDoS 攻击，整场攻击持续约 8 分钟。](images/preventing-infrastructure-abuse-with-vercel-firewall-vercel/img_004.jpg)

Vercel quickly mitigated a DDoS attack that peaked at 1.37 Tbps within the first 2 minutes and lasted around 8 minutes.

Vercel 在前两分钟内即快速缓解了一次峰值达 1.37 Tbps 的 DDoS 攻击，整场攻击持续约 8 分钟。

DDoS attacks are evolving rapidly, enabling faster botnet coordination and automated techniques that exploit vulnerabilities with unprecedented speed. To effectively counter these diverse attack vectors, platforms must be adaptive to automatically shield customers and maintain service availability.

DDoS 攻击正以前所未有的速度演进，使得僵尸网络协同更高效、自动化攻击技术更成熟，漏洞利用也愈发迅捷。为有效应对这些多样化的攻击向量，平台必须具备自适应能力，能够自动保护客户并持续保障服务可用性。

### The Vercel Firewall: Comprehensive, multi-layered security

### Vercel 防火墙：全面、多层防护的安全体系

Vercel Firewall is a built-in, multi-layered security solution that offers platform-wide protection and a customizable [Web Application Firewall (WAF)](https://vercel.com/docs/security/vercel-waf).  
Vercel Firewall 是一款内置的、多层安全解决方案，提供覆盖全平台的防护能力以及可自定义的 [Web 应用防火墙（WAF）](https://vercel.com/docs/security/vercel-waf)。

It provides automated defense across all user tiers, from hobbyists to enterprises.  
该方案为所有用户层级（从个人开发者到企业客户）提供自动化防御能力。

Vercel's Firewall integrates Layer 4 protections, combining industry-leading third-party services with Vercel's own defenses, alongside proprietary Layer 7 protections tailored to modern web applications.  
Vercel Firewall 集成了第 4 层（传输层）防护，融合业界领先的第三方服务与 Vercel 自研防护能力；同时配备专为现代 Web 应用设计的自有第 7 层（应用层）防护。

Leveraging application awareness through its framework-defined infrastructure, Vercel enhances threat mitigation with enriched request context, enabling precise, proactive defense for each application.  
依托其框架定义的基础设施所实现的应用感知能力，Vercel 通过增强的请求上下文信息提升威胁缓解效果，从而为每个应用提供精准、主动的安全防护。

With fast global propagation, edge protection, and intelligent routing, Vercel aims to ensure that your web applications remain secure and performant by default.  
凭借快速的全球规则分发、边缘防护及智能路由能力，Vercel 致力于让您的 Web 应用默认即具备安全性与高性能。

This commitment to being [secure by default](https://vercel.com/resources/iterating-towards-secure-by-default) allows customers to scale with legitimate traffic while focusing on innovation and growth.  
这一“默认安全”[（Secure by Default）](https://vercel.com/resources/iterating-towards-secure-by-default) 的承诺，使客户可在真实流量增长的同时，专注创新与业务拓展。

Vercel Firewall’s intelligent defenses detect and mitigate malicious traffic in real time, addressing both infrastructure-level (e.g. bots, DDoS and SYN Floods) and application-level (e.g. SQL injection and API abuse) threats to maintain service continuity across the platform.  
Vercel Firewall 的智能防护能力可实时检测并缓解恶意流量，全面应对基础设施层面（例如机器人爬虫、DDoS 攻击、SYN Flood）和应用层面（例如 SQL 注入、API 滥用）的威胁，保障平台整体服务连续性。

This approach to security helps ensure that as attacks evolve, Vercel's protections can adapt to mitigate threats before they impact your applications.  
这种安全策略确保：随着攻击手段不断演进，Vercel 的防护能力亦能随之自适应升级，在威胁影响您的应用之前即完成拦截与缓解。

With default DDoS protection and a customizable WAF, customers can scale securely while focusing on growth.  
凭借默认启用的 DDoS 防护与可自定义的 WAF，客户可在保障安全的前提下实现规模化增长，专注业务发展。

Vercel’s ongoing investments aim to make the web secure by default, minimizing downtime and blocking threats early.  
Vercel 持续投入研发，致力于让整个 Web 默认即安全——最大限度减少服务中断，并在威胁早期即予以阻断。

[**Block AI Bots - Firewall Rule**\\  
\\  
Add a custom rule to your project's Firewall to detect common AI bots.\\  
\\  
This rule defaults to 'Log.' Change it to 'Deny' to block these bots.\\  
\\  
Add Firewall Rule](https://vercel.com/templates/vercel-firewall/block-ai-bots-firewall-rule)  

[**拦截 AI 爬虫 —— 防火墙规则**\\  
\\  
为项目的 Firewall 添加一条自定义规则，用于识别常见 AI 爬虫。\\  
\\  
该规则默认动作为“记录（Log）”，您可将其更改为“拒绝（Deny）”以拦截此类爬虫。\\  
\\  
添加防火墙规则](https://vercel.com/templates/vercel-firewall/block-ai-bots-firewall-rule)