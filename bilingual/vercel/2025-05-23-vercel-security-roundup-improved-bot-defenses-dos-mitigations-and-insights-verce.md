---
title: "Vercel security roundup: improved bot defenses, DoS mitigations, and insights - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-security-roundup-improved-bot-defenses-dos-mitigations-and-insights"
date: "2025-05-23"
scraped_at: "2026-03-02T09:32:59.841580601+00:00"
language: "en-zh"
translated: true
description: "Since February, Vercel blocked over 148 billion attacks from 108 million IPs. This roundup highlights improvements to bot protection, DoS mitigation, and firewall tooling to help teams build securely ..."
---

May 23, 2025

2025 年 5 月 23 日

Billions of attacks blocked while cutting response time and expanding control

在大幅缩短响应时间、增强管控能力的同时，成功拦截数十亿次攻击。

Since February, Vercel blocked 148 billion malicious requests from 108 million unique IP addresses. Every deployment automatically inherits these protections, keeping your workloads **secure by default** and enabling your team to focus on shipping rather than incidents.

自 2 月以来，Vercel 已拦截来自 1.08 亿个唯一 IP 地址的 1480 亿次恶意请求。所有部署均自动继承这些防护能力，确保您的工作负载**默认安全**，使您的团队得以专注于产品交付，而非安全事件响应。

Our real-time DDoS filtering, managed Web Application Firewall (WAF), and enhanced visibility ensure consistent, proactive security.

我们实时的 DDoS 过滤、托管式 Web 应用防火墙（WAF）以及增强的安全可见性，共同保障持续、主动的安全防护。

Here's what's new since February.

以下是自 2 月以来的新进展。

## WAF performance insights

## WAF 性能洞察

Since our [last update](https://vercel.com/blog/vercel-security-roundup-faster-defenses-and-better-visibility-for-your-apps), Vercel WAF mitigated over **148 billion** malicious requests, a 70% increase quarter-over-quarter. These requests originated from over 108 million unique IP addresses, a staggering 468% increase that signals a sharp rise in distributed activity.

自我们上一次[更新](https://vercel.com/blog/vercel-security-roundup-faster-defenses-and-better-visibility-for-your-apps)以来，Vercel WAF 已成功缓解超过 **1480 亿次**恶意请求，环比增长达 70%。这些请求源自逾 1.08 亿个唯一 IP 地址，增幅高达惊人的 468%，表明分布式攻击活动正急剧加剧。

![](images/vercel-security-roundup-improved-bot-defenses-dos-mitigations-and-insights-verce/img_001.jpg)![](images/vercel-security-roundup-improved-bot-defenses-dos-mitigations-and-insights-verce/img_002.jpg)![](images/vercel-security-roundup-improved-bot-defenses-dos-mitigations-and-insights-verce/img_003.jpg)![](images/vercel-security-roundup-improved-bot-defenses-dos-mitigations-and-insights-verce/img_004.jpg)

The largest volumes of malicious traffic originated from:

恶意流量来源最多的地区包括：

- **United States**: 55 billion

- **美国**：550 亿

- **Ireland**: 29 billion  
- **爱尔兰**：290 亿  

- **Singapore**: 7 billion  
- **新加坡**：70 亿  

- **Hong Kong**: 5 billion  
- **中国香港**：50 亿  

- **Germany**: 3 billion  
- **德国**：30 亿  

This quarter's insights highlight shifting global threat trends, with notable increases in malicious activity emerging in new geographies. At the same time, other regions like Australia (previously among the top sources of malicious traffic) dropped out of the top five.  

本季度的洞察揭示了全球威胁趋势的动态变化：恶意活动正显著向新兴地理区域扩散。与此同时，澳大利亚等其他地区（此前曾位列恶意流量主要来源地前列）已跌出前五名。

Attack volumes and unique IPs have grown dramatically. This reinforces the importance of automatic global protections with Vercel to ensure your deployments remain secure by default.  

攻击总量与唯一 IP 数量均大幅攀升。这进一步凸显了借助 Vercel 实现自动化的全球防护之重要性——确保您的部署默认即具备安全性。

## Key security enhancements  

## 关键安全增强功能  

### Advanced bot protection  

### 高级机器人防护  

Our new [Bot Filter](https://vercel.com/docs/bot-protection#bot-filter-managed-ruleset) entered public beta, free for all users on all plans. Bot Filter is a managed WAF ruleset that you can activate with one click, immediately challenging non-browser bot traffic without disrupting critical automations such as verified webhook providers (Googlebot, Stripe, PayPal) and internal cron jobs.  

我们全新推出的 [Bot Filter（机器人过滤器）](https://vercel.com/docs/bot-protection#bot-filter-managed-ruleset) 已进入公开测试阶段，所有计划下的所有用户均可免费使用。Bot Filter 是一套托管式 Web 应用防火墙（WAF）规则集，您只需单击一次即可启用；它将立即对非浏览器类机器人流量发起挑战，同时不会干扰关键自动化流程——例如经验证的 Webhook 提供方（Googlebot、Stripe、PayPal）以及内部定时任务（cron jobs）。

You can preview which requests Bot Filter would block using log-only mode, improving performance by ensuring your application resources remain available for legitimate users. If you have feedback on this beta feature, leave a comment in the [Vercel Community](https://community.vercel.com/t/feedback-thread-for-bot-filter-public-beta/9174).  

您可通过“仅日志模式”（log-only mode）预览 Bot Filter 将拦截哪些请求，从而提升性能表现——确保您的应用资源始终优先服务于真实用户。若您对该测试功能有任何反馈，欢迎在 [Vercel 社区](https://community.vercel.com/t/feedback-thread-for-bot-filter-public-beta/9174) 中留言评论。

### Faster denial-of-service mitigation

### 更快的拒绝服务攻击缓解能力

We introduced [Protectd](https://vercel.com/blog/protectd-evolving-vercels-always-on-denial-of-service-mitigations), a powerful update to our denial-of-service (DoS) mitigation infrastructure. Protectd analyzes roughly 550,000 events per second globally, significantly accelerating our ability to mitigate Layer 7 attacks.

我们推出了 [Protectd](https://vercel.com/blog/protectd-evolving-vercels-always-on-denial-of-service-mitigations)，这是对我们拒绝服务攻击（DoS）缓解基础设施的一项重大升级。Protectd 全球范围内每秒可分析约 55 万个事件，大幅提升了我们应对第 7 层（应用层）攻击的能力。

The result is a median mitigation time of just 2.5 seconds and a P99 of around 3.5 seconds, blocking sophisticated attacks that traditional CDNs often miss. Protectd operates transparently and immediately benefits all deployments without any configuration required.

其结果是：中位数缓解时间为仅 2.5 秒，P99 缓解时间约为 3.5 秒，可有效拦截传统 CDN 常常无法识别的复杂攻击。Protectd 运行完全透明，所有部署均可立即受益，且无需任何配置。

## Comprehensive SDLC security guidance

## 全生命周期软件开发安全指南

Our new _Secure every step of a modern SDLC_ whitepaper, is a comprehensive resource that clearly outlines how Vercel's built-in security features apply to every phase of software development, from planning and coding to deployment and monitoring. This whitepaper aims to simplify compliance discussions and helps streamline secure application development.

我们全新发布的白皮书《_Secure every step of a modern SDLC_》（《保障现代软件开发生命周期的每一步安全》）是一份全面详实的资源，清晰阐述了 Vercel 内置安全功能如何覆盖软件开发全周期——从规划、编码，到部署与监控等各个阶段。该白皮书旨在简化合规性讨论，并助力高效开展安全应用开发。

[**Read the Secure SDLC whitepaper**\\
\\
Building, deploying, and operating secure applications on Vercel.\\
\\
Read now](https://assets.vercel.com/image/upload/v1745532177/front/security/Secured_modern_SDLC.pdf)

[**阅读《Secure SDLC》白皮书**\\
\\
在 Vercel 上构建、部署与运维安全的应用程序。\\
\\
立即阅读](https://assets.vercel.com/image/upload/v1745532177/front/security/Secured_modern_SDLC.pdf)

## Proactive vulnerability management and account security

## 主动式漏洞管理与账户安全

In recent months, Vercel proactively hardened our platform against high-severity vulnerabilities in open-source frameworks, ensuring that customer applications remained secure without requiring manual intervention. We still recommend updating to the latest patched versions of the affected packages and frameworks.

近几个月来，Vercel 主动强化平台以抵御开源框架中的高危漏洞，确保客户应用在无需人工干预的情况下持续保持安全。我们仍建议您将受影响的软件包和框架更新至最新已修复版本。

- **React Router and Remix vulnerabilities** [**CVE-2025-43864 and CVE-2025-43865**](https://vercel.com/changelog/protection-against-react-router-and-remix-vulnerabilities-cve-2025-43864) **:** Vercel proactively deployed mitigation to the Vercel Firewall, and purged any potentially impacted caches, to protect customers against CVEs that can lead to cache poisoning denial of service and stored cross-site scripting attacks

- **React Router 和 Remix 漏洞** [**CVE-2025-43864 与 CVE-2025-43865**](https://vercel.com/changelog/protection-against-react-router-and-remix-vulnerabilities-cve-2025-43864) **：** Vercel 已主动将缓解措施部署至 Vercel 防火墙，并清除了所有可能受影响的缓存，以保护客户免受可能导致缓存投毒型拒绝服务（cache poisoning DoS）及存储型跨站脚本（stored XSS）攻击的 CVE 漏洞影响。

- **React Router vulnerability** [**CVE-2025-31137**](https://vercel.com/changelog/protection-against-react-router-vulnerability-cve-2025-31137) **:** Our platform architecture prevented exposure to this CVE that allows URL manipulation

- **React Router 漏洞** [**CVE-2025-31137**](https://vercel.com/changelog/protection-against-react-router-vulnerability-cve-2025-31137) **：** 我们的平台架构天然规避了该 CVE 漏洞的影响——该漏洞允许恶意 URL 操纵。

- **SAMLStorm** [**CVE-2025-29774 和 CVE-2025-29775**](https://vercel.com/changelog/vercel-firewall-protects-against-the-samlstorm-vulnerability) **：** 我们已向 Vercel 防火墙部署一项安全更新，成功缓解了该 SAML 身份认证绕过风险。

- **Next.js 中间件漏洞 CVE-2025-29927 和 CVE-2025-30218：** 尽管 Vercel 未受 [CVE-2025-29927](https://vercel.com/changelog/vercel-firewall-proactively-protects-against-vulnerability-with-middleware) 影响，但在分析过程中，我们于边缘节点发现了一个低危问题 [CVE-2025-30218](https://vercel.com/changelog/cve-2025-30218)，并已及时修复；同时，我们已提前向基础设施提供商合作伙伴披露该漏洞。

- **多因素身份验证（MFA）：** 通过[添加第二重验证因素](https://vercel.com/changelog/mfa-is-now-available)（例如 Google Authenticator 或 Authy 等基于 TOTP 的应用），配合您当前已启用的通行密钥（Passkeys），进一步强化账户安全性。

## 防火墙可用性改进

我们已上线多项防火墙更新，旨在为团队提供更灵活的规则创建能力、在活跃威胁期间实现更精细的管控，并增强对恶意或异常流量模式的可观测性。

经验证的机器人（verified bots）和 Vercel Cron 任务现已可[绕过攻击挑战模式（Attack Challenge Mode）](https://vercel.com/changelog/attack-challenge-mode-now-allows-verified-bots-and-vercel-cron-jobs)，确保支付、数据分析等核心服务在安全事件期间不受干扰。自定义防火墙规则现[支持逻辑 `OR` 运算符](https://vercel.com/changelog/vercel-firewall-rule-builder-now-supports-or-for-rule-condition-groups)，显著降低配置复杂度——尤其适用于需更灵活地组合多个条件的使用场景。

系统旁路规则（system bypass rules）也已[进一步扩展](https://vercel.com/changelog/improvements-to-vercel-firewall-system-bypass-rules)，现支持应用于预览域名（preview domains），且配额上限提升，从而为借助外部代理进行部署的场景提供更大灵活性。最后，防火墙控制台现已新增[IP 地址信息增强功能（IP enrichment）](https://vercel.com/changelog/ip-address-details-added-in-the-vercel-firewall-dashboard)：将鼠标悬停于任意 IP 地址上，即可查看其自治系统编号（ASN）、地理位置及其他元数据。此举可帮助团队在流量调查中更快获取洞察、更高效实施管控。

## 在线研讨会：使用 Vercel 防火墙保护您的流量

深入了解如何使用 Vercel 防火墙保护您的网络流量

我们举办了一场线上研讨会——《**使用 Vercel 防火墙保护您的流量**》。欢迎观看回放，了解有关 DDoS 与机器人防护策略、高效流量管控与威胁缓解技术的实用指南，并抢先了解产品路线图的最新动态。

## Looking ahead

## 展望未来

At this year’s RSA Conference, we sat down with security teams to talk through what’s shaping web security in 2025. Conversations focused on securing the software supply chain, applying AI-driven automation inside security teams (not just in business processes) and ensuring that emerging practices such as vibe coding are built with security in mind from the start.

在今年的 RSA 大会上，我们与多家安全团队深入交流，共同探讨塑造 2025 年 Web 安全格局的关键趋势。讨论聚焦于：保障软件供应链安全、在安全团队内部（而不仅限于业务流程中）应用 AI 驱动的自动化，以及确保“氛围编程”（vibe coding）等新兴实践从设计之初就将安全性纳入考量。

These conversations continue to shape our ongoing work across the Vercel platform and in tools like v0 to ensure every deployment is secure by default.

这些对话持续影响着我们在 Vercel 平台及 v0 等工具上的研发工作，以确保每一次部署默认即安全。

### **Upcoming events**

### **即将举办的活动**

We’re continuing these conversations at [Vercel Ship](https://vercel.com/ship) on June 25th. Join us in New York City or steam online for live demos, technical discussions, and insights from customers who rely on Vercel to secure their applications.

我们将于 6 月 25 日在 [Vercel Ship](https://vercel.com/ship) 活动中延续这些对话。欢迎亲临纽约市现场，或在线观看直播——届时将呈现实时演示、深度技术研讨，并分享诸多客户如何依托 Vercel 保障其应用安全的宝贵洞见。

### Open roles

### 招聘职位

We're also expanding our team to continue enhancing the security and availability of your applications. If you're passionate about secure web infrastructure, explore our current open roles:

我们正在扩充团队，以持续提升您应用的安全性与可用性。如果您热衷于构建安全可靠的 Web 基础设施，欢迎了解我们当前开放的职位：

- [Software Engineer, CDN Security](https://vercel.com/careers/software-engineer-cdn-security-amer-5473266004) (Remote, US/Canada)

- [CDN 安全工程师](https://vercel.com/careers/software-engineer-cdn-security-amer-5473266004)（远程办公，面向美国/加拿大）

- [Software Engineer, CDN Security](https://vercel.com/careers/software-engineer-cdn-security-5473268004) (Hybrid, SF Bay Area)

- [CDN 安全工程师](https://vercel.com/careers/software-engineer-cdn-security-5473268004)（混合办公，旧金山湾区）

- [Software Engineer, Accounts](https://vercel.com/careers/software-engineer-accounts-5430088004) (Remote, Berlin/London/Netherlands)

- [账户系统工程师](https://vercel.com/careers/software-engineer-accounts-5430088004)（远程办公，面向柏林/伦敦/荷兰）

- [安全产品经理](https://vercel.com/careers/security-product-manager-us-5482193004)（美国远程办公）

- [安全运维工程师](https://vercel.com/careers/security-operations-engineer-5447126004)（混合办公，旧金山）

- [安全自动化工程师](https://vercel.com/careers/security-operations-engineer-5447126004)（混合办公，旧金山）

- [安全研究员](https://vercel.com/careers/security-researcher-us-5401260004)（美国远程办公）

[**了解随您业务规模同步扩展的安全能力**  
\\  
Vercel 防火墙提供多层防护，抵御应用层攻击、DDoS 威胁及恶意机器人。访问我们的安全页面，立即预约演示或添加防火墙规则。  
\\  
了解更多](https://vercel.com/security)