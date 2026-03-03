---
title: "Vercel security roundup: Faster defenses and better visibility for your apps - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-security-roundup-faster-defenses-and-better-visibility-for-your-apps"
date: "2025-02-21"
scraped_at: "2026-03-02T09:36:32.905365197+00:00"
language: "en-zh"
translated: true
description: "Learn how Vercel's security product updates improved traffic visibility, enhanced mitigation techniques, and resulted in blocking billions of malicious attacks."
---

Feb 21, 2025

2025年2月21日

Billions of attacks blocked while strengthening defenses, improving response times, and adding visibility for developers

在持续强化防御能力、缩短响应时间、并为开发者提升安全可见性的同时，Vercel 已拦截数十亿次网络攻击。

Every second, Vercel blocks attacks before they reach your applications—keeping businesses online and developers focused on shipping, not security incidents.

每一秒，Vercel 都在攻击抵达您的应用之前将其拦截——保障业务持续在线，让开发者专注于交付产品，而非应对安全事件。

Vercel’s security capabilities combine **real-time DDoS mitigation, a powerful Web Application Firewall (WAF), and seamless SIEM integrations** to provide always-on protection without added complexity.

Vercel 的安全能力融合了**实时 DDoS 缓解、功能强大的 Web 应用防火墙（WAF）以及与 SIEM 系统的无缝集成**，在不增加复杂性的前提下，提供全天候防护。

Here’s what happened in the last quarter.

以下是上一季度的关键进展。

## **Vercel's WAF blocks 87 billion attacks**

## **Vercel WAF 拦截 870 亿次攻击**

![](images/vercel-security-roundup-faster-defenses-and-better-visibility-for-your-apps-verc/img_001.jpg)![](images/vercel-security-roundup-faster-defenses-and-better-visibility-for-your-apps-verc/img_002.jpg)![](images/vercel-security-roundup-faster-defenses-and-better-visibility-for-your-apps-verc/img_003.jpg)![](images/vercel-security-roundup-faster-defenses-and-better-visibility-for-your-apps-verc/img_004.jpg)

In the last quarter of 2024, Vercel’s WAF automatically mitigated **87 billion attacks from 19 million unique IPs**—blocking malicious traffic before it ever reached customer applications. Our platform security combines multiple layers of protection:

在 2024 年第四季度，Vercel 的 WAF 自动缓解了**来自 1900 万个唯一 IP 地址的 870 亿次攻击**——在恶意流量触及客户应用之前即完成拦截。我们的平台安全采用多层防护机制：

- [Vercel’s firewall](https://vercel.com/docs/security/vercel-firewall) offers network-wide Layer 3 and Layer 4 protection, automatically mitigating DDoS threats and TCP-based attacks before they can reach applications. This is enabled for every customer on any plan tier

- [Vercel 防火墙](https://vercel.com/docs/security/vercel-firewall) 提供覆盖全网的第 3 层（网络层）和第 4 层（传输层）防护，可自动缓解 DDoS 威胁及基于 TCP 的攻击，确保其无法抵达应用。该功能面向所有客户、所有付费计划层级默认启用。

- [Vercel’s WAF](https://vercel.com/security/web-application-firewall) provides comprehensive Layer 7 security, identifying and mitigating threats like SQL injection, cross-site scripting (XSS), and bot-driven attacks, all without degrading performance

- [Vercel WAF](https://vercel.com/security/web-application-firewall) 提供全面的第 7 层（应用层）安全防护，可识别并缓解 SQL 注入、跨站脚本（XSS）、机器人驱动攻击等威胁，且完全不影响应用性能。

[**Understand how Vercel secures your app**  
了解 Vercel 如何保障您的应用安全  

From network protections to Layer 7 granular controls, learn how Vercel's infrastructure provides multi-layered protection for your application.  
从网络层防护到第 7 层精细化控制，了解 Vercel 基础设施如何为您的应用提供多层级安全保障。  

Learn more  
了解更多](https://vercel.com/blog/life-of-a-request-securing-your-apps-traffic-with-vercel)

### **WAF 影响力概览：**

### **WAF 影响力概览：**

- **220 亿次请求** 在美国被拦截，来源涵盖 **360 万个** 独立 IP 地址，凸显该地区自动化攻击与定向攻击的高发态势  

- **160 亿次请求** 在德国被缓解，反映出欧洲市场日益严峻的安全挑战  

- **130 亿次请求** 在新加坡被阻断，印证了全球高流量枢纽节点对安全防护需求的持续攀升  

These numbers show increasing modern cyber threats and the need for proactive defenses. Vercel’s WAF prevents attacks before causing application downtime, protecting user experiences and reducing infrastructure strain. Automated threat detection and real-time mitigation ensure security without compromising performance.  
上述数据揭示了当代网络威胁的持续升级趋势，以及主动式防御的必要性。Vercel 的 Web 应用防火墙（WAF）可在应用宕机前即刻拦截攻击，既保障终端用户体验，又减轻基础设施负载。依托自动化的威胁检测与实时缓解能力，安全防护全程不以牺牲性能为代价。

## **强化您的安全防线：更多控制权，更快响应速度**

## **强化您的安全防线：更多控制权，更快响应速度**

Over the past quarter, we’ve focused on strengthening our security defenses while giving developers more customizations, increasing visibility and granular control.  
过去一个季度，我们持续强化安全防御能力，同时为开发者提供更多自定义选项，提升可观测性与精细化管控能力。

### Enhanced threat mitigation  
### 威胁缓解能力升级

Vercel Firewall is now faster and more effective at stopping threats. By processing malicious traffic in real time and improving mitigation features, we’re neutralizing high-volume and low-and-slow attacks earlier, reducing costs, and preventing threats from reaching your application.  
Vercel Firewall 现在能更快速、更高效地阻断各类威胁。通过实时处理恶意流量并优化缓解机制，我们可更早识别并中和高频攻击及“低速慢速”（low-and-slow）攻击，从而降低成本，并确保威胁无法抵达您的应用。

- [DDoS 防护速度现已提升至原来的 40 倍](https://vercel.com/changelog/vercel-firewall-now-stops-ddos-attacks-up-to-40x-faster)，这得益于实时流式处理技术，可更早地拦截恶意流量并[缓解 DDoS 攻击](https://vercel.com/docs/security/ddos-mitigation)。

- [WAF 响应机制得到优化](https://vercel.com/changelog/clients-blocked-by-persistent-actions-now-receive-a-403-forbidden-response)：针对持续性威胁，现统一返回 `403 Forbidden` 响应，使策略执行对终端用户更加清晰明确。

### 可视化与告警能力增强

准确掌握安全事件发生的时间与位置，是快速响应和阻断威胁的关键。过去三个月中，我们已扩展监控与告警功能，助力团队更高效地做出明智决策。

- [Vercel Firewall DDoS 缓解通知](https://vercel.com/changelog/introducing-vercel-firewall-notifications)：当 Vercel Firewall 检测到并自动缓解您 Vercel 项目的 DDoS 攻击时，您将即时收到告警。此类通知有助于团队持续监控流量模式、审查攻击日志，并在必要时采取进一步应对措施。

- [项目概览（Project Overview）](https://vercel.com/changelog/preview-firewall-status-and-web-analytics-from-project-overview) 页面现已支持预览应用的 Firewall 状态及其他过去 24 小时内的关键信息。

- 更细粒度的[Firewall 数据现已开放](https://vercel.com/changelog/enhanced-firewall-data-now-available-in-monitoring)，您可在「监控（Monitoring）」或「可观测性 Plus（Observability Plus）」标签页中查看。支持按防护动作筛选被拦截请求，并可获取更多详细信息，例如 IP 所属国家/地区（IP Country）及用户代理（User Agent）。

### 合规性与访问安全增强

Vercel 新增多项功能，以提升安全可见性，并协助客户满足各类合规性要求。

- 企业版客户可为其现有的安全信息与事件管理（SIEM）工具（例如 Datadog 或 Splunk）配置[实时审计日志流（real-time audit log stream）](https://vercel.com/docs/observability/audit-log#custom-siem-log-streaming)。

- 为帮助客户满足《支付卡行业数据安全标准》（PCI DSS）的要求，[Vercel 已成功完成](https://vercel.com/changelog/upgraded-pci-dss-version-3-2-1-to-4-0) PCI DSS v4.0 下面向服务提供商的《自评估问卷合规声明》（SAQ-D AOC）。

## Building a more secure web together with the Vercel Community

## 与 Vercel 社区携手共建更安全的 Web

Learn more about Vercel's Firewall capabilities in our recent community session.

请通过我们最近举办的社区分享会，进一步了解 Vercel Firewall 的各项能力。

Our Community team recently hosted a Community Session demonstrating Vercel Firewall's capabilities and explaining how Vercel provides platform-wide protection against common web attacks—including [DDoS attacks](https://youtu.be/0ku2bedYeWU?t=451) and [malicious bots](https://youtu.be/0ku2bedYeWU?t=923).

我们的社区团队近期举办了一场社区分享会，现场演示了 Vercel Firewall 的核心能力，并详细讲解了 Vercel 如何在平台层面全面防御常见 Web 攻击——包括 [DDoS 攻击](https://youtu.be/0ku2bedYeWU?t=451) 和 [恶意机器人（bots）](https://youtu.be/0ku2bedYeWU?t=923)。

Have questions about the session? Join discussion on the [Vercel Community Forum](https://vercel.community/t/how-to-protect-your-vercel-site-from-common-attacks/4652).

对本次分享会有疑问？欢迎前往 [Vercel 社区论坛](https://vercel.community/t/how-to-protect-your-vercel-site-from-common-attacks/4652) 参与讨论。

## Looking ahead

## 展望未来

As we look across the ever-evolving security landscape, our Chief Information Security Officer Ty Sbano see three challenges the web will face in the coming year:

在持续演进的安全格局下，Vercel 首席信息安全官（CISO）Ty Sbano 指出，Web 在未来一年将面临三大挑战：

- **DDoS attacks are intensifying:** Vercel is seeing larger and more sophisticated attempts to cause app outages, increase costs, and disrupt business

- **DDoS 攻击持续加剧：** Vercel 观测到，针对应用可用性的攻击规模更大、手法更复杂，其目的包括引发应用中断、抬高运营成本及扰乱正常业务。

- **Bots are becoming more sophisticated:** With the rise of AI and agentic agents, global internet traffic has shifted and it’s making it harder to identify real users and automated bots

- **机器人（bots）日趋智能化：** 随着人工智能与智能体（agentic agents）的兴起，全球互联网流量结构已发生改变，真实用户与自动化机器人的区分正变得愈发困难。

- **Layer 8 is emerging as the Human Layer:** The traditional networking [OSI model](https://en.wikipedia.org/wiki/OSI_model) ends at the Application (Layer 7), but security tools still require human intelligence to understand and tune business logic

- **“第 8 层”正在浮现——即“人类层”（Human Layer）：** 传统网络架构中的 [OSI 模型](https://zh.wikipedia.org/wiki/OSI%E6%A8%A1%E5%9E%8B) 以应用层（第 7 层）为终点，但安全工具仍需依赖人类智慧来理解并调优业务逻辑。

To meet these emerging threats, we will continue to develop product features and internal programs that safeguard our customers and protect the end-user experience.

为应对这些新兴威胁，我们将持续开发产品功能及内部计划，以保障客户安全并维护终端用户的使用体验。

Additionally, we will be creating opportunities for customers directly connect with Vercel in the security space:

此外，我们将为客户提供直接参与 Vercel 安全生态的多种机会：

- Connect with us in April at [RSAC 2025](https://www.rsaconference.com/), where you can stop by our booth to learn and demo security products with the team.

- 今年四月，欢迎莅临 [RSAC 2025](https://www.rsaconference.com/) 大会，前往 Vercel 展台与团队面对面交流，了解并现场体验我们的安全产品。

- If you are a customer with a security story, you can [apply to speak](https://ship-2025-cfp.vercel.app/) at Vercel Ship, our flagship conference in NYC this June

- 如果您是拥有安全实践案例的客户，欢迎 [申请在 Vercel Ship 大会上发表演讲](https://ship-2025-cfp.vercel.app/) —— 这是我们今年六月在纽约举办的旗舰级技术大会。

- We’re hiring a [Security Researcher](https://vercel.com/careers/security-researcher-us-5401260004) and expanding our Edge engineering team with a [Software Engineer](https://vercel.com/careers/software-engineer-edge-amer-5179639004) and [Engineering Manager](https://vercel.com/careers/engineering-manager-edge-us-5386919004).

- 我们正在招聘一名 [安全研究员](https://vercel.com/careers/security-researcher-us-5401260004)，并面向边缘计算（Edge）工程团队扩招一名 [软件工程师](https://vercel.com/careers/software-engineer-edge-amer-5179639004) 和一名 [工程经理](https://vercel.com/careers/engineering-manager-edge-us-5386919004)。

[**Learn about security that scales with you**\\
\\
The Vercel Firewall delivers multi-layer protection against application-layer attacks, DDoS threats, and bots. Visit our security page to sign up for a demo or add firewall rules today\\
\\
Learn more](https://vercel.com/security)

[**了解随您业务规模同步演进的安全能力**\\
\\
Vercel 防火墙提供多层防护，可有效抵御应用层攻击、DDoS 威胁及恶意机器人流量。欢迎访问我们的安全页面，立即预约产品演示或配置防火墙规则\\
\\
了解更多](https://vercel.com/security)