---
title: "Just another (Black) Friday - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/just-another-black-friday"
date: "2025-10-15"
scraped_at: "2026-03-02T09:26:58.426096777+00:00"
language: "en-zh"
translated: true
description: "Vercel customers can treat Black Friday like just another day, ready to scale to billions of requests."
---

render_with_liquid: false
Oct 15, 2025

2025 年 10 月 15 日

Vercel customers can treat Black Friday like just another day, ready to scale to billions of requests.

Vercel 用户可将“黑色星期五”视作平常一日，轻松应对数十亿级请求的流量洪峰。

For teams on Vercel, Black Friday is just another Friday. The scale changes, but your storefronts and apps stay fast, reliable, and ready for spikes in traffic.

对于使用 Vercel 的团队而言，“黑色星期五”不过是又一个普通星期五。流量规模虽有剧增，但您的线上商店与应用依然保持高速、稳定，并随时应对突发的流量高峰。

Many of the optimizations required for peak traffic are already built into the platform. Rendering happens at the edge, caching works automatically, and protection layers are on by default.

平台已原生集成诸多应对峰值流量所需的优化能力：页面渲染在边缘节点执行，缓存自动生效，防护层默认启用。

What’s left for teams is refinement: confirming observability is set up, tightening security rules, and reviewing the dashboards that matter most.

团队所需做的，仅是精细化调优：确认可观测性配置就绪、加固安全策略，并重点复核关键业务仪表盘。

Last year, Vercel created a live Black Friday Cyber Monday dashboard that showcased our scale in real-time, showing the spikes. Overall, from Friday to Thursday, Vercel served **86,702,974,965** requests across its network, reaching a peak of **1,937,097** requests per second.

去年，Vercel 推出了实时“黑色星期五—网络星期一”数据看板，全程动态呈现平台承载能力与流量波峰。从周五至次周四，Vercel 全网共处理请求 **86,702,974,965** 次，峰值达每秒 **1,937,097** 次请求。

[Helly Hansen](https://vercel.com/blog/how-helly-hansen-migrated-to-vercel-and-drove-80-black-friday-growth), a major technical apparel brand, entered the weekend with this confidence. Before the event, they moved from client-heavy rendering to Vercel’s CDN and saw:

知名专业户外服饰品牌 [Helly Hansen](https://vercel.com/blog/how-helly-hansen-migrated-to-vercel-and-drove-80-black-friday-growth) 凭借这一信心迎接购物季。活动前，他们将原先重度依赖客户端渲染的架构迁移至 Vercel CDN，随即收获：

- 80% year-over-year increase in revenue  
- 营收同比增长 80%

- 2x higher conversion  
- 转化率提升 2 倍

- Zero downtime  
- 零宕机

- Core Web Vitals shift from red to green  
- 核心网页指标（Core Web Vitals）从红色转为绿色  

Their success came from deliberate performance decisions, not SREs on standby reacting to outages.  
他们的成功源于主动的性能优化决策，而非站点可靠性工程师（SRE）在故障发生后被动响应。

## Defense that adapts to traffic  
## 随流量自适应的安全防御  

At scale, security is as much about maintaining control as it is about protection. The same global network that keeps pages fast also shields them from attacks, automatically absorbing and filtering traffic before it reaches the origin.  
在大规模场景下，安全不仅关乎防护，更关乎掌控力。同一张全球网络既保障页面加载速度，也同时为页面提供攻击防护——在流量抵达源站之前，即自动吸收并过滤恶意请求。

Every request goes through a multi-layered firewall, and for Vercel customers, this means the platform firewall has already deflected the largest DDoS attempts long before they reach their apps.  
每个请求均需经过多层防火墙检查；对 Vercel 用户而言，这意味着平台级防火墙早已在攻击流量抵达其应用之前，就成功拦截了规模最大的 DDoS 尝试。

Last year, Vercel's system Firewall triggered **3,052,195,860** request blocks, while our customer-specific Web Application Firewalls blocked **519,841,270** requests.  
去年，Vercel 系统级防火墙共触发 **3,052,195,860** 次请求拦截，而面向客户的 Web 应用防火墙（WAF）则拦截了 **519,841,270** 次请求。

**Platform Firewall for DDoS**  
**面向 DDoS 防护的平台级防火墙**

Vercel’s Firewall automatically mitigates distributed denial-of-service traffic by filtering requests at the network perimeter. The system dynamically scales its defenses as load increases, so legitimate users continue to see a fast experience even during an attack.  
Vercel 防火墙通过在网络边界处过滤请求，自动缓解分布式拒绝服务（DDoS）攻击流量。系统会随负载增长动态扩展防御能力，确保真实用户即使在遭受攻击期间，依然能获得快速流畅的访问体验。

**Business logic and the Vercel Web Application Firewall**  
**业务逻辑与 Vercel Web 应用防火墙（WAF）**

The Vercel WAF gives teams granular control to apply their own logic at the edge. Instead of static rules, the WAF lets customers define protection around business-critical routes such as checkout, login, or API endpoints. This ensures security is specific to the application, not generic to the network.  
Vercel WAF 赋予团队在边缘节点实施精细化控制的能力，使其可部署自身定义的安全逻辑。不同于静态规则，WAF 允许客户围绕关键业务路径（例如结算页、登录页或 API 接口端点）定制化设置防护策略。这确保了安全机制紧密贴合具体应用需求，而非泛泛适用于整个网络。

**Keeping the experience human**

**保持体验的人性化**

Poorly configured bot defenses, or asking your customers to pay traffic light tax, can create friction when traffic spikes. BotID provides invisible CAPTCHA-level protection that automatically distinguishes real users from automated agents, without degrading UX.

配置不当的机器人防御机制，或要求用户为“交通灯税”（traffic light tax）买单，都可能在流量激增时造成用户体验摩擦。BotID 提供隐形的、达到 CAPTCHA 级别的防护能力，可自动区分真实用户与自动化代理程序，且完全不损害用户体验（UX）。

[**Understand how Vercel secures your app**  
\\  
From network protections to Layer 7 granular controls, learn how Vercel's infrastructure provides multi-layered protection for your application.  
\\  
Learn more](https://vercel.com/blog/life-of-a-request-securing-your-apps-traffic-with-vercel)

[**了解 Vercel 如何保障您的应用安全**  
\\  
从网络层防护到第 7 层（应用层）的精细化控制，深入理解 Vercel 基础设施如何为您的应用提供多层级安全保障。  
\\  
了解更多](https://vercel.com/blog/life-of-a-request-securing-your-apps-traffic-with-vercel)

## Serve instantly, update intelligently

## 即时响应，智能更新

At high traffic, the goal is not just speed but predictability and origin stability. The CDN must adapt: serve from cache when possible, refresh intelligently, and collapse redundant work. Below are key techniques Vercel uses to achieve this.

在高流量场景下，目标不仅是速度，更是可预测性与源站（origin）稳定性。CDN 必须具备自适应能力：尽可能从缓存提供服务、智能刷新内容，并合并冗余请求。以下是 Vercel 实现这一目标的关键技术。

**Revalidation that is invisible to users** Rather than forcing every user to wait for rebuilds, Vercel supports background revalidation. Pages served stale will trigger regeneration behind the scenes while users still get a fast response.

**对用户完全透明的重新验证（Revalidation）**  
Vercel 支持后台重新验证，而非强制每位用户等待重建完成。当向用户返回过期（stale）页面时，系统会在后台自动触发页面再生，用户则始终获得快速响应。

This means a page may refresh every 5 minutes, but users never see that pause.

这意味着某页面可能每 5 分钟刷新一次，但用户永远不会感知到任何停顿。

**Request collapsing to prevent stampedes** When many requests hit an uncached or expired route at once, Vercel’s CDN collapses them into a single regeneration per region. Other requests wait and receive the result. This prevents duplicate work and protects the origin under traffic surges.

**请求合并（Request Collapsing）以避免请求雪崩**  
当大量请求同时命中未缓存或已过期的路由路径时，Vercel 的 CDN 会将同一区域内的所有请求合并为单次再生操作；其余请求则排队等待并直接复用该结果。此举可避免重复工作，并在流量激增时有效保护源站。

[**Understanding Vercel's infrastructure**  
\\  
Learn how Vercel's framework-defined infrastructure automatically handles user traffic.  
\\  
Read the blog](https://vercel.com/blog/life-of-a-vercel-request-navigating-the-edge-network)

[**深入理解 Vercel 的基础设施**  
\\  
了解 Vercel 基于框架定义的基础设施如何自动应对用户流量。  
\\  
阅读博客文章](https://vercel.com/blog/life-of-a-vercel-request-navigating-the-edge-network)

## Track performance & availability in real time

## 实时追踪性能与可用性

While many companies may insist on a code freeze, Vercel customers didn't stop deploying, with **2,454,917** deployments taking place over this roughly 96 hour window.

尽管许多公司可能坚持执行代码冻结，Vercel 的客户却并未停止部署——在此约 96 小时的时间窗口内，共完成了 **2,454,917** 次部署。

To stay confident during peak traffic, you need full visibility into how your system behaves. Not after the fact, but while it’s running.

要在流量高峰期保持信心，您需要对系统运行状态拥有全方位的可观测性：不是事后复盘，而是在系统实时运行过程中持续掌握其行为。

Observability gives you that insight: you can see latency, errors, cache behavior, and resource usage across every layer. On Vercel, that means monitoring everything from network requests to function invocations and real user metrics.

可观测性（Observability）正为您提供这种洞察力：您可跨所有层级查看延迟、错误、缓存行为及资源使用情况。在 Vercel 平台上，这意味着从网络请求、函数调用，到真实用户指标，全部纳入监控范围。

**Built-in insights by layer**

**按层级内置的洞察分析**

In the Observability dashboard, you can view metrics across these layers:

在可观测性（Observability）仪表板中，您可以查看以下各层级的指标：

- Cache hit/miss rates, request count per region, traffic by path and bot category  
- 缓存命中率/未命中率、各区域请求数量、按路径及机器人类型划分的流量分布

- Vercel Function invocation counts, error rates, and latency  
- Vercel 函数调用次数、错误率与延迟

- Upstream latency and error rates to pinpoint third-party slowdowns  
- 上游延迟与错误率，精准定位第三方服务导致的性能下降

- Revalidation frequency and cache efficiency  
- 重新验证频率与缓存效率

- Real-user metrics aggregated over time to see how performance truly feels  
- 随时间聚合的真实用户指标，直观呈现性能的实际体验效果

**Custom queries and anomaly alerts**

**自定义查询与异常告警**

You can write custom queries to investigate traffic, like sustained latency above threshold, error spikes, or rising cache miss rates.

您可以编写自定义查询来深入分析流量情况，例如持续高于阈值的延迟、错误率激增或缓存未命中率上升等。

Anomaly alerts, available for Pro and Enterprise users in public beta, can notify you at the earliest signs of unusual app activity.

异常告警功能目前面向 Pro 和 Enterprise 用户开放公开测试（public beta），可在应用出现异常活动的最早迹象时即向您发出通知。

**Unified signal streams**

**统一信号流**

Vercel lets you stream logs, traces, analytics, and performance data into your existing tools via Drains. You get correlated signal: a slow function call can be tied to a trace, enriched logs, and a decline in web vitals. This unified view helps you quickly root-cause regressions.

Vercel 通过 Drains 功能，支持将日志（logs）、链路追踪（traces）、分析数据（analytics）及性能指标（performance data）实时推送至您现有的工具中。您将获得关联统一的信号：一次响应缓慢的函数调用，可同时关联到对应链路追踪、增强型日志，以及核心网页指标（Web Vitals）的下降趋势。这种统一视图有助于您快速定位性能退化（regression）的根本原因。

[**Black Friday Cyber Monday readiness with Vercel**\\  
\\  
Peak season punishes slow sites and shaky architectures. With Vercel, you can harden the critical pages in weeks. See how.\\  
\\  
Register Now](https://vercel.fyi/QNt4TbT)

[**借助 Vercel 全面备战黑色星期五与网络星期一**\\  
\\  
销售旺季将无情惩罚响应迟缓的网站与架构不稳的系统。使用 Vercel，您可在数周内加固关键页面。立即了解具体方法。\\  
\\  
立即报名](https://vercel.fyi/QNt4TbT)

## Get ready for Black Friday with Vercel

## 借助 Vercel 全力备战黑色星期五

Vercel’s global network absorbs traffic spikes, serves content from cache, and revalidates pages in the background. Built-in observability tracks performance and availability in real time so teams can monitor and adjust during peak load.

Vercel 的全球网络可自动吸收突发流量、从缓存中高效交付内容，并在后台异步重新验证页面。内置可观测性能力可实时追踪性能与可用性指标，助力团队在流量高峰期间持续监控并动态调优。

Make Black Friday just another fast, reliable day on your platform. Our team can help you validate your setup, apply the right protections, and optimize your caching strategy before traffic peaks.

让黑色星期五成为您平台又一个高速、稳定运行的普通工作日。我们的团队可协助您验证当前配置、部署恰当的防护机制，并在流量峰值到来前优化缓存策略。

[Talk to sales](https://vercel.fyi/DHnY84q) to build a tailored readiness plan, or join our [Black Friday Cyber Monday readiness webinar](https://vercel.fyi/QNt4TbT) for a full walkthrough, best practices checklist, and a free site readiness assessment tool.

[联系销售团队](https://vercel.fyi/DHnY84q)，为您量身定制备战方案；或参加我们的 [黑色星期五与网络星期一备战线上研讨会](https://vercel.fyi/QNt4TbT)，获取完整操作指南、最佳实践核对清单，以及免费的网站就绪度评估工具。