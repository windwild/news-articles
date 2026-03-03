---
title: "Security through design: Creating the improved Firewall experience - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/security-through-design-improved-firewall-experience"
date: "2025-11-24"
scraped_at: "2026-03-02T09:25:16.378373908+00:00"
language: "en-zh"
translated: true
description: "Vercel introduces a new Firewall UI for better surfacing of events and alerts while providing deeper information on mitigation activity"
---

Nov 24, 2025

2025 年 11 月 24 日

At Vercel, we believe security should be intuitive, not intimidating. The best security tool is the one that's actually used. It should be clear, useful, and never in the way.

在 Vercel，我们坚信：安全应当直观易用，而非令人望而生畏。最优秀的安全工具，是真正被用户采用的工具；它应当清晰明了、切实有用，且从不阻碍工作流。

But that's not always the norm. Security tooling can often feel like a tradeoff against shipping velocity. When UX is an afterthought, teams leave tools off or in "logging mode" forever, even when risks are high.

但现实中，这并非总是常态。安全工具往往让人感觉是在开发速度与安全保障之间做取舍。当用户体验（UX）沦为事后补救，团队便可能长期关闭这些工具，或仅将其置于“仅记录日志”模式——即便此时风险已然很高。

That's why we've redesigned the Vercel Firewall experience from the ground up. The new UI helps you see more, do more, and feel confident in your app's resilience to attacks.

正因如此，我们对 Vercel 防火墙（Firewall）体验进行了全面重构。全新用户界面助您更全面地掌握安全态势、更高效地执行响应操作，并对应用抵御攻击的韧性充满信心。

![](images/security-through-design-creating-the-improved-firewall-experience-vercel/img_001.jpg)![](images/security-through-design-creating-the-improved-firewall-experience-vercel/img_002.jpg)

## **Designing for every Vercel user**

## **面向每一位 Vercel 用户的设计**

The redesign started with listening. Users told us:

重构始于倾听。用户向我们反馈：

- I want to easily see active DDoS events  
- 我希望轻松查看当前活跃的 DDoS 攻击事件  

- I need more information on what the Firewall blocked  
- 我需要更详尽的信息，了解防火墙具体拦截了哪些请求  

- I need a faster way to investigate traffic alerts or spikes  
- 我需要更快捷的方式，调查流量告警或流量激增事件

Developers, SREs, and security teams all use the Firewall for maintenance and troubleshooting. They configure rules, monitor traffic, and respond to unusual activity.

开发人员、SRE（站点可靠性工程师）和安全团队均使用防火墙进行日常维护与故障排查。他们配置规则、监控流量，并对异常活动做出响应。

The new Firewall UI is designed for everyone using Vercel. It surfaces clear, actionable information, simplifies navigation, and helps teams resolve issues quickly when it matters most.

全新防火墙用户界面专为所有 Vercel 用户设计。它呈现清晰、可操作的信息，简化导航流程，并在关键时刻助力团队快速解决问题。

## **A better way to see and secure your traffic**

## **更直观、更安全的流量观测与防护方式**

The new design brings together visibility, context, and control in one view.

新设计将可观测性、上下文信息与控制能力整合于同一视图中。

- **A redesigned overview page** provides a unified, high-signal view of Firewall activity

- **重新设计的概览页面** 提供统一、高信噪比的防火墙活动总览

- **New sidebar navigation** offers one click to Overview, Traffic, Rules, and Audit Log

- **全新的侧边栏导航** 支持一键切换至“概览”、“流量”、“规则”和“审计日志”

- **Key activity and alert feeds** surface unusual patterns and potential threats

- **关键活动与告警流** 实时呈现异常模式及潜在威胁

- **Improved inspection tools** make it faster to move from alert to insight

- **增强的检查工具** 大幅缩短从告警触发到获取洞察的路径

### A new overview for all security events

### 面向全部安全事件的全新概览视图

The [Overview page](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Ffirewall&title=Firewall+tab) is your high-level control center for the Firewall. It gives you a clear, birds-eye view of your site’s security posture. The traffic chart remains at the top, and we now surface the most important information based on recent activity.

[概览页面](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Ffirewall&title=Firewall+tab) 是您管理防火墙的高层级控制中心，为您提供网站整体安全态势的清晰、全局视角。流量图表仍位于页面顶部，而我们现根据近期活动动态呈现最关键的信息。

Four tables surface key Firewall activity so you can see the current state and act quickly when needed:

四个表格呈现关键的防火墙活动，帮助您实时掌握当前状态，并在需要时迅速响应：

- Alerts shows recently mitigated DDoS attacks  
- 告警（Alerts）：显示最近已缓解的 DDoS 攻击

- Rules displays top rule activity by volume  
- 规则（Rules）：按流量规模展示最活跃的规则

- Events list mitigations taken by Firewall  
- 事件（Events）：列出防火墙执行的各类缓解措施

- Denied IPs show blocked connections by client IP  
- 被拒 IP（Denied IPs）：按客户端 IP 展示被阻止的连接

![](images/security-through-design-creating-the-improved-firewall-experience-vercel/img_003.jpg)![](images/security-through-design-creating-the-improved-firewall-experience-vercel/img_004.jpg)

### Comprehensive traffic intelligence

### 全面的流量智能分析

The new Traffic page focuses entirely on understanding activity across your site. You can now drill down into the detection signals that you care about the most, and filter those signals based on specific mitigation actions on the traffic tab. These updates make it easier to spot patterns or anomalies before they become problems.

全新的“流量”（Traffic）页面专注于全面理解您网站上的全部活动。您现在可以深入查看最关注的检测信号，并在“流量”标签页中，依据具体的缓解操作对这些信号进行筛选。这些更新让您能更早识别潜在的模式或异常，防患于未然。

We now surface dedicated feeds for:

我们现在提供以下专属数据流：

- Top IPs  
- 访问量最高的 IP（Top IPs）

- Top JA4 digests  
- JA4 摘要统计 Top（最高频）

- Top AS names  
- AS 名称统计 Top（最高频）

- Top User Agents  
- 用户代理（User Agent）统计 Top（最高频）

- Top Request Paths  
- 请求路径统计 Top（最高频）

- Rules with most activity  
- 活动量最高的规则

![](images/security-through-design-creating-the-improved-firewall-experience-vercel/img_005.jpg)![](images/security-through-design-creating-the-improved-firewall-experience-vercel/img_006.jpg)

### Dedicated rules and activity  
### 专属规则与活动视图

Firewall Rules now have a dedicated tab on the sidebar. You can see and manage all of your WAF custom rules in this view, including [Bot Protection](https://vercel.com/docs/bot-management#bot-protection-managed-ruleset), [Managed Rulesets](https://vercel.com/docs/vercel-firewall/vercel-waf/managed-rulesets), [IP Blocking](https://vercel.com/docs/vercel-firewall/vercel-waf/ip-blocking), and more. We’ve also moved the Audit Log to a dedicated tab for full visibility into Firewall changes.  
防火墙规则（Firewall Rules）现已在侧边栏中拥有专属标签页。在此视图中，您可以查看并管理所有 Web 应用防火墙（WAF）自定义规则，包括 [机器人防护（Bot Protection）](https://vercel.com/docs/bot-management#bot-protection-managed-ruleset)、[托管规则集（Managed Rulesets）](https://vercel.com/docs/vercel-firewall/vercel-waf/managed-rulesets)、[IP 封禁（IP Blocking）](https://vercel.com/docs/vercel-firewall/vercel-waf/ip-blocking) 等更多功能。同时，我们已将审计日志（Audit Log）迁移至独立标签页，以便全面掌握防火墙的所有变更记录。

![](images/security-through-design-creating-the-improved-firewall-experience-vercel/img_007.jpg)![](images/security-through-design-creating-the-improved-firewall-experience-vercel/img_008.jpg)

### Faster event inspection  
### 更快的事件检查

Clicking an alert or event now opens a detailed view directly in the page. You can dive deeper into Firewall activity and investigate suspicious traffic or DDoS attacks without context switching, helping you diagnose issues faster and take action immediately.

点击警报或事件现在会直接在当前页面中打开详细视图。您可以深入分析防火墙活动，调查可疑流量或 DDoS 攻击，无需切换上下文，从而更快地诊断问题并立即采取行动。

![](images/security-through-design-creating-the-improved-firewall-experience-vercel/img_009.jpg)![](images/security-through-design-creating-the-improved-firewall-experience-vercel/img_010.jpg)

## **Security designed for you**

## **专为您设计的安全体验**

Security is usability. When tools are clear and well-designed, teams act faster and stay safer, without sacrificing shipping velocity.

安全即可用性。当工具清晰易用、设计精良时，团队能够更快响应，持续保持安全，同时不牺牲交付速度。

We'd love your feedback. Explore the new Firewall experience today in your [Vercel Dashboard](https://vercel.com/dashboard) and share your thoughts in the [Vercel Community](https://vercel.com/community).

我们非常期待您的反馈！请立即前往 [Vercel 控制台](https://vercel.com/dashboard) 体验全新的防火墙功能，并在 [Vercel 社区](https://vercel.com/community) 中分享您的想法。