---
title: " Vercel's Bot Protection stops malicious bots in a single click  - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/one-click-bot-protection-now-in-public-beta"
date: "2025-04-23"
scraped_at: "2026-03-02T09:34:42.445839608+00:00"
language: "en-zh"
translated: true
description: "Mitigate unwanted bot traffic by challenging requests from non-browser sources. Now available in public beta and free for all users on all plans."
---
&#123;% raw %}

Apr 23, 2025

2025 年 4 月 23 日

The [Vercel Web Application Firewall (WAF)](https://vercel.com/security/web-application-firewall) inspects billions of requests every day to block application-layer threats, such as cross-site scripting, traversal, and application DDoS attacks. While we already inspect and block malicious bot traffic, we wanted to provide better, more precise controls to fine tune your application security.

[Vercel Web 应用防火墙（WAF）](https://vercel.com/security/web-application-firewall) 每日检查数十亿次请求，以拦截应用层威胁，例如跨站脚本（XSS）、路径遍历（Traversal）以及应用层 DDoS 攻击。尽管我们已持续检测并拦截恶意机器人流量，但我们希望提供更完善、更精准的控制能力，助您精细调优应用安全策略。

Today, we're launching the [Bot Protection](https://vercel.com/docs/bot-management#bot-protection-managed-ruleset) managed ruleset, free for all users on all plans. With a single click, you can protect your application from bot attacks.

今天，我们正式推出 [Bot Protection（机器人防护）](https://vercel.com/docs/bot-management#bot-protection-managed-ruleset) 托管规则集——面向所有套餐的所有用户免费开放。只需单击一次，即可为您的应用启用机器人攻击防护。

[**Enable Bot Filter Today**\\
\\
Bot Filter protects applications from bot attacks with a single click. \\
\\
Enable Now](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Ffirewall%2Fconfigure&title=Enable%20Bot%20Filter)

[**立即启用 Bot Filter**\\
\\
Bot Filter 通过单次点击即可保护应用免受机器人攻击。\\
\\
立即启用](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Ffirewall%2Fconfigure&title=Enable%20Bot%20Filter)

## Countering the threat of bad bots

## 应对恶意机器人的威胁

Automation plays a key role in how the internet works. While some bots serve useful functions, like crawling and indexing, it’s estimated that nearly one-third of internet traffic is malicious bot activity. They’ve become some of the biggest security threats facing developers, security teams, and end-users today.

自动化在互联网运行机制中扮演着关键角色。尽管部分机器人（bots）执行有益任务（如网页爬取与索引），但据估计，近三分之一的互联网流量源自恶意机器人活动。如今，它们已成为开发者、安全团队及终端用户所面临的最严峻安全威胁之一。

To counter automation at this scale, there’s no one-sized fits all approach. Teams need a variety of tools and mitigation techniques to stop bad bots.

要在此规模下有效应对自动化攻击，并不存在“一刀切”的解决方案。各团队需要借助多种工具与缓解技术，协同阻断恶意机器人。

### Evolving our bot protections

### 持续升级我们的机器人防护能力

Vercel provides bot mitigation as part of our secure by default platform.

Vercel 将机器人缓解能力作为“默认安全”平台的重要组成部分。

- Our platform-wide [DDoS mitigations](https://vercel.com/docs/vercel-firewall/ddos-mitigation) block traffic from botnets behind DDoS traffic, HTTP floods, and malformed requests

- 我们全平台范围的 [DDoS 缓解措施](https://vercel.com/docs/vercel-firewall/ddos-mitigation) 可拦截源自僵尸网络的 DDoS 流量、HTTP 泛洪攻击及畸形请求。

- [Firewall templates](https://vercel.com/templates/vercel-firewall) let users deploy rules targeting known bad actors, from open source blocklists to common AI scrapers  
- [防火墙模板](https://vercel.com/templates/vercel-firewall) 允许用户部署规则，以拦截已知恶意行为者——从开源黑名单到常见的 AI 网络爬虫。

- [Attack Challenge mode](https://vercel.com/docs/vercel-firewall/attack-challenge-mode) can be used to challenge requests during highly-sophisticated or targeted attacks  
- [攻击挑战模式](https://vercel.com/docs/vercel-firewall/attack-challenge-mode) 可在遭遇高度复杂或定向攻击时，对可疑请求发起验证挑战。

However, as automated attacks become more advanced, teams require more targeted protections that are always on and always adapting.  
然而，随着自动化攻击日趋高级化，团队需要更精准、始终启用且持续自适应的安全防护措施。

## Introducing Bot Protection  
## 推出 Bot Protection（机器人防护）

The Bot Protection managed ruleset gives you the ability to stop unwanted bot traffic, while allowing business-critical bots through. This new security layer goes beyond our platform protections to give you greater control over the type of traffic accessing your applications.  
Bot Protection 托管规则集使您能够拦截非预期的机器人流量，同时放行对业务至关重要的合法机器人。这一全新安全层超越了平台级基础防护，赋予您对访问您应用的流量类型更强的管控能力。

![](images/vercel_s-bot-protection-stops-malicious-bots-in-a-single-click-vercel/img_001.jpg)![](images/vercel_s-bot-protection-stops-malicious-bots-in-a-single-click-vercel/img_002.jpg)![](images/vercel_s-bot-protection-stops-malicious-bots-in-a-single-click-vercel/img_003.jpg)![](images/vercel_s-bot-protection-stops-malicious-bots-in-a-single-click-vercel/img_004.jpg)

### How Bot Protection works  
### Bot Protection 的工作原理

The Bot Protection ruleset takes a proactive approach using a heuristics-based detection. It quickly distinguishes between browser-based traffic (human) or non-browser based (likely bot) traffic with zero configuration needed. When enabled:  
Bot Protection 规则集采用主动式、基于启发式的检测机制，无需任何配置即可快速区分基于浏览器的流量（人类用户）与非浏览器类流量（极可能是机器人）。启用后：

- Requests from real browsers and [verified bots](https://vercel.com/docs/bot-protection#verified-bots) are allowed through, including internal sources like project cron jobs and API calls from your functions. We publish additional information about verified bots on [bots.fyi](https://bots.fyi/).  
- 来自真实浏览器及[已验证机器人](https://vercel.com/docs/bot-protection#verified-bots) 的请求将被放行，包括项目内部来源（如定时任务 cron jobs）以及您函数发起的 API 调用。有关已验证机器人的更多信息，我们已在 [bots.fyi](https://bots.fyi/) 上公开发布。

- Requests from non-browser clients, like `curl` or unwanted scrapers, can be issued a [challenge](https://vercel.com/docs/vercel-firewall/firewall-concepts#challenge)  
- 来自非浏览器客户端（例如 `curl` 工具）或非预期网络爬虫的请求，可被触发[挑战验证](https://vercel.com/docs/vercel-firewall/firewall-concepts#challenge)。

Bot Protection ties directly into the WAF. As a managed ruleset, we maintain the list of verified bots to ensure authenticity and reduce maintenance overhead.

Bot Protection 直接集成于 Web 应用防火墙（WAF）中。作为一个托管规则集，我们持续维护经验证的机器人列表，以确保其真实性，并降低运维负担。

### When to use Bot Protection

### 何时使用 Bot Protection

Use Bot Protection to restrict access to your sites to human users and Vercel-verified bots. It’s ideal for legitimate services like AI and SEO bots, or when you expect mostly human traffic. Bot Protection continuously challenges non-browser traffic, improving app performance and optimizing resource usage for real customers.

请使用 Bot Protection 限制网站访问权限，仅允许真实人类用户及 Vercel 验证通过的机器人访问。它非常适合用于 AI、SEO 等合法自动化服务场景，或当您的站点预期以人类流量为主时。Bot Protection 会持续对非浏览器类流量发起挑战，从而提升应用性能，并为真实用户提供更优的资源使用效率。

We recommend you enable Bot Protection in Log-Only Mode first to gain visibility into your app's traffic and bot sources by showing what requests would be challenged. For legitimate automated traffic not covered by verified bots list, you can use custom WAF rules with the bypass action to ensure that this traffic reaches your app.

我们建议您首先以“仅日志模式”（Log-Only Mode）启用 Bot Protection，以便全面了解应用的流量构成与机器人来源——该模式将显示哪些请求本会被挑战，但不会实际拦截。对于未被纳入已验证机器人列表的合法自动化流量，您可创建自定义 WAF 规则并配置 `bypass` 动作，确保此类流量正常抵达您的应用。

Bot Protection is not designed to defend against sophisticated bots that mimic human and browser behavior. Should you want to issue a challenge to all traffic to block automation entirely, use Attack Challenge Mode instead.

Bot Protection 并非专为防御高度仿真的高级机器人（即刻意模拟人类行为与浏览器特征的机器人）而设计。若您希望对所有流量统一发起挑战，以彻底阻断一切自动化访问，请改用“攻击挑战模式”（Attack Challenge Mode）。

## What’s next for bot management

## 机器人管理的后续演进

### Public Beta Feedback

### 公开测试版反馈

During this [public beta](https://vercel.com/docs/release-phases/public-beta-agreement) period, we’ve set up a [thread](https://community.vercel.com/t/feedback-thread-for-bot-filter-public-beta/9174) on the Vercel Community where you can share your feedback, feature requests, and experiences with Bot Protection.

在本次 [公开测试版](https://vercel.com/docs/release-phases/public-beta-agreement) 期间，我们已在 Vercel 社区设立了一个 [专门讨论帖](https://community.vercel.com/t/feedback-thread-for-bot-filter-public-beta/9174)，欢迎您分享关于 Bot Protection 的使用体验、功能建议与反馈意见。

### Looking ahead

### 展望未来

Bot management plays a key role in strengthening our secure by default platform. AI agents and other automated tools are only increasing, and the rising volume of sophisticated bot traffic will change the way developers build, operate, and secure apps.

机器人管理在强化我们“默认安全”（secure by default）平台的战略中扮演着关键角色。AI 智能体及其他自动化工具正持续增长，而日益增多的高阶机器人流量，也将深刻改变开发者构建、运维与保护应用的方式。

Our planned bot management updates for the Vercel Firewall focus on specific attack types and better end-user experiences. Additional features include deeper observability into bot traffic, more granular control over verified and AI bots, Bot Protection SDK, and runtime bot protection capabilities. Enterprise users looking for more granular control will also get access to underlying detection signals as configurable inputs in the Firewall for more advanced control over automated traffic.

我们为 Vercel 防火墙（Firewall）规划的机器人管理更新，聚焦于特定攻击类型及更优的终端用户体验。新增功能包括：对机器人流量的更深度可观测性、对已验证机器人和 AI 机器人的更精细化管控、Bot Protection SDK，以及运行时机器人防护能力。面向企业用户的高级控制需求，我们还将开放底层检测信号作为防火墙中可配置的输入项，从而实现对自动化流量的更精细、更高级的管控。

## Enable Bot Protection today

## 立即启用机器人防护

You can enable the Bot Protection from [your Firewall's Configure dashboard](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Ffirewall%2Fconfigure&title=Bot+Protection).

您可通过 [防火墙的“配置”控制台](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Ffirewall%2Fconfigure&title=Bot+Protection) 启用机器人防护（Bot Protection）。

[**Learn about security that scales with you**\\
\\
The Vercel Firewall delivers multi-layer protection against application-layer attacks, DDoS threats, and bots. Visit our security page to sign up for a demo or add firewall rules today\\
\\
Learn more](https://vercel.com/security)

[**了解随业务增长而演进的安全能力**\\
\\
Vercel 防火墙提供多层防护，抵御应用层攻击、DDoS 威胁及恶意机器人。欢迎访问我们的安全页面，预约产品演示或立即添加防火墙规则\\
\\
了解更多](https://vercel.com/security)

If you're just getting started with Vercel Firewall, or don't yet have a clear picture of your app's traffic patterns, start in Log-Only Mode so you can refine your allowlist before switching to active enforcement.

若您刚刚开始使用 Vercel 防火墙，或尚未清晰掌握应用的流量模式，建议先以“仅记录模式”（Log-Only Mode）启动——以便在切换至主动防护模式前，逐步优化您的白名单策略。

If you are a SaaS provider and want to add your bot to our verified bots list, you can reach out to us at [https://bots.fyi/](https://bots.fyi/).

如果您是 SaaS 服务商，并希望将您的机器人加入我们的“已验证机器人”（verified bots）列表，请通过 [https://bots.fyi/](https://bots.fyi/) 与我们联系。

Learn more in the [changelog](https://vercel.com/changelog/bot-protection-is-now-in-public-beta) or read the [documentation](https://vercel.com/docs/bot-management#bot-protection-managed-ruleset).

更多详情请参阅 [更新日志](https://vercel.com/changelog/bot-protection-is-now-in-public-beta)，或查阅 [官方文档](https://vercel.com/docs/bot-management#bot-protection-managed-ruleset)。

Edit: During the beta period, we renamed the Bot Filter managed ruleset to Bot Protection

编辑说明：在公测（beta）期间，我们将原“Bot Filter”托管规则集（managed ruleset）更名为“Bot Protection”（机器人防护）。
&#123;% endraw %}
