---
render_with_liquid: false
title: "Introducing the Vercel Web Application Firewall - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-the-vercel-waf"
date: "2024-05-23"
scraped_at: "2026-03-02T09:44:14.932565512+00:00"
language: "en-zh"
translated: true
description: "Introducing the Vercel Web Application Firewall: application-aware, Vercel-native protection that brings the web one step closer to being secure by default."
---
render_with_liquid: false
render_with_liquid: false

May 23, 2024

2024 年 5 月 23 日

面向应用、原生集成 Vercel 的防护能力，让 Web 向“默认安全”迈出关键一步。

在任意一周内，Vercel 均会拦截约 10 亿次可疑的 TCP 连接，部分单日恶意请求量甚至超过 70 亿次。Vercel 防火墙长期以来一直在静默缓解 DDoS 攻击及第 3/4 层（网络层/传输层）攻击，但其一直以“黑盒”形式运行，透明度十分有限。

我们坚信，安全应贯穿开发流程的每一步。正因如此，我们致力于持续完善安全套件，为您提供更强的可观测性与更精细的控制能力，助您深入理解并高效管理托管在 Vercel 上的网站。

今天，我们正式推出 **Vercel Web 应用防火墙（WAF）**——为 Vercel 平台原生新增一道防御屏障，全面抵御更广泛的 Web 威胁，让您在不牺牲速度、可扩展性与安全性的前提下，交付现代化的 Web 体验。

## **下一代安全能力，无缝深度集成**

## 下一代安全能力，无缝深度集成

Vercel 原生 WAF 在边缘节点提供第一方安全防护——显著降低延迟，并确保仅合法用户可访问您的应用。该 WAF 深度嵌入 Vercel 生态系统，开箱即用，无需额外配置路由规则、引入外部工具或执行复杂集成。

**所有套餐** 现在均支持对应用入口点进行细粒度的第 7 层（应用层）管控，以拦截非法流量；同时新增 [攻击挑战模式（Attack Challenge Mode）](https://vercel.com/docs/security/attack-challenge-mode)，并延续平台级防火墙已提供的实时 [DDoS 缓解能力（DDoS mitigation）](https://vercel.com/docs/security/ddos-mitigation)。

![The new Vercel Firewall.](images/introducing-the-vercel-web-application-firewall-vercel/img_001.jpg)![The new Vercel Firewall.](images/introducing-the-vercel-web-application-firewall-vercel/img_002.jpg)全新的 Vercel 防火墙。

## **强大功能，实现全方位防护**

## 强大功能，实现全方位防护

The Vercel WAF protects your apps from diverse threats with a powerful feature set, including:

Vercel Web 应用防火墙（WAF）凭借强大的功能集，全方位保护您的应用免受各类威胁，包括：

- **可自定义的规则引擎：** 基于路径（path）、用户代理（User Agent）、IP 地址、地理位置（geolocation）、JA4 指纹以及目标路径（target paths）等维度，定义精细化规则，精准控制流量处理方式。例如，您可以创建一条规则，屏蔽来自特定国家/地区的全部流量；根据用户角色，仅允许其访问特定路径；或仅允许来自已知浏览器列表的连接。

- **框架感知型规则（Framework-aware rules）：** 直接基于您所用框架的路由（routes）定义规则，无需手动编写正则表达式或路径前缀。

- **托管规则集（Managed rulesets）：** 企业客户可启用由 Vercel 托管的预置规则集，专门应对特定安全场景，例如防范 OWASP Top 10 所列核心风险。

- **可观测性（Observability）：** 提供关键安全指标的深度洞察，助力高效安全管理——您可实时监控 WAF 及平台级防火墙正在处理的威胁与连接，确保防护全面、运维透明。

- **速率限制（Rate limiting，Beta 版）：** 对尝试访问您应用的用户强制实施频率限制，确保即使是合法用户，也能按您预期的方式访问资源。

- **即时生效（Instant propagation）：** 防火墙配置变更将在全球范围内于 300 毫秒内同步生效。

- **即时回滚（Instant rollback）：** 可随时一键还原至此前的规则集配置，快速撤销误操作导致的规则变更。

![You can add firewall rules directly inside the Vercel dashboard.](images/introducing-the-vercel-web-application-firewall-vercel/img_003.jpg)![You can add firewall rules directly inside the Vercel dashboard.](images/introducing-the-vercel-web-application-firewall-vercel/img_004.jpg)您可直接在 Vercel 控制台中添加防火墙规则。

## **默认安全：Vercel 的安全理念**

## **Secure by default: The Vercel approach**

Security is a foundational pillar of everything we build at Vercel. Our commitment to security enables your team to focus on rapid iteration while remaining secure.

安全性是我们于 Vercel 所构建一切的基石。我们对安全性的坚定承诺，使您的团队能够在保持安全的同时，专注于快速迭代。

Our vision for Vercel security is that we empower a web that's secure by default. To achieve this vision, we're continuously investing in both new and existing security solutions. The introduction of the WAF represents an important moment in our journey towards leading security for the Frontend Cloud.

Vercel 的安全愿景是赋能一个“默认即安全”的网络。为实现这一愿景，我们持续投入资源，不断升级现有安全解决方案，并开发新的安全能力。Web 应用防火墙（WAF）的推出，标志着我们在引领前端云（Frontend Cloud）安全之路上迈出了关键一步。

This can be achieved by leveraging Vercel's unique [framework-defined infrastructure (FdI)](https://vercel.com/blog/framework-defined-infrastructure) and inherent understanding of your application. Through FdI, the Vercel WAF is able to leverage a deep understanding of your application, which paves the way for intelligent decision-making based on the context and content of every edge request.

这得益于 Vercel 独有的[框架定义基础设施（Framework-Defined Infrastructure，FdI）](https://vercel.com/blog/framework-defined-infrastructure)，以及我们对您应用的天然理解能力。借助 FdI，Vercel WAF 能够深度理解您的应用结构与行为，从而基于每个边缘请求的上下文与内容，做出更智能的安全决策。

## **Security without compromise**

## **安全，无需妥协**

The Vercel WAF empowers you to build and deploy secure applications without sacrificing performance, ease of use, or search engine optimization (SEO).

Vercel WAF 使您能够构建并部署安全的应用程序，同时不牺牲性能、易用性或搜索引擎优化（SEO）效果。

[**Ready to experience next-level security?**\\
\\
Explore the Vercel WAF documentation and start securing your applications today.\\
\\
Learn more](https://vercel.com/docs/security/vercel-waf)

[**准备好体验下一代安全防护了吗？**\\
\\
查阅 Vercel WAF 文档，立即为您的应用启用安全防护。\\
\\
了解更多](https://vercel.com/docs/security/vercel-waf)