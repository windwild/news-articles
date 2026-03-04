---
title: "Vercel WAF upgrade brings persistent actions, rate limiting, and API control - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-waf-upgrade-brings-persistent-actions-rate-limiting-and-api-control"
date: "2024-10-02"
scraped_at: "2026-03-02T09:40:58.411280471+00:00"
language: "en-zh"
translated: true
description: "New capabilities reduce effects of DDoS attacks and enhance traffic control"
---
{% raw %}

Oct 2, 2024

2024 年 10 月 2 日

新防火墙功能可减轻 DDoS 攻击影响，并增强流量管控能力

在 Vercel Ship 大会上，[我们宣布推出](https://vercel.com/blog/introducing-the-vercel-waf)全新的 [Web 应用防火墙（WAF）](https://vercel.com/docs/security/vercel-waf)，这是一款应用层防火墙，可与我们平台级防火墙协同工作。它使客户能够部署自定义规则集或托管规则集，例如针对 OWASP Top 10 安全风险的防护措施。

自发布以来，Vercel WAF 已成功拦截数十亿次恶意请求，充分验证了其在各类应用场景中的强健性与可靠性——无论是小型初创公司，还是大型企业级部署。

今天，我们正式宣布以下新功能：

- **持久化操作（Persistent actions）**：对重复违规者实施跨所有匹配请求的规则应用，持续时间可自定义。

- **速率限制（Rate limiting）**：针对特定端点设置请求频率上限，在防范 API 滥用的同时，保障合法用户的访问性能。

- **防火墙 API（Firewall API）**：通过编程方式管理 WAF 配置，实现安全工作流自动化，并与第三方工具集成。

## 为 Vercel Web 应用防火墙引入全新增强功能

这些改进进一步赋能 Vercel 客户精准放行期望流量，同时对其他一切异常或恶意流量采取主动防御措施。

Vercel’s Challenge page, originally exclusive to the Vercel WAF, verifies browsers to ensure only legitimate users access applications. This feature is now extended to the broader Vercel Firewall, enhancing automated bot management and DDoS protection across the platform.

Vercel 的挑战页面（Challenge page）最初仅为 Vercel WAF 独有，通过浏览器验证确保仅合法用户可访问应用。如今，该功能已扩展至更广泛的 Vercel 防火墙（Vercel Firewall），从而全面提升平台的自动化机器人管理能力与 DDoS 防护水平。

A key advantage of Vercel’s WAF is instant rule propagation. While traditional firewalls may take up to 20 minutes to apply updates globally, leaving applications vulnerable, Vercel’s Edge Network propagates rules worldwide in just 300 milliseconds—securing applications immediately.

Vercel WAF 的一项关键优势在于规则的即时生效（instant rule propagation）。传统防火墙在全球范围内部署更新可能耗时长达 20 分钟，导致应用在此期间暴露于风险之中；而 Vercel 边缘网络（Edge Network）可在短短 300 毫秒内将规则同步至全球——实现应用安全的即刻加固。

Why does this matter? Because attackers look for short gaps in security. The ability to enforce rules instantly cuts off their window of opportunity and ensures your security policies are always active, no matter where the request is coming from.

这为何重要？因为攻击者总在寻找安全防护中的短暂缺口。规则的即时强制执行，能迅速关闭其可乘之机，并确保您的安全策略始终处于激活状态——无论请求源自何处。

[**Block AI Bots - Firewall Rule**\\
\\
Add a custom rule to your project's Firewall to detect common AI bots.\\
\\
This rule defaults to 'Log.' Change it to 'Deny' to block these bots.\\
\\
Add Firewall Rule](https://vercel.com/templates/vercel-firewall/block-ai-bots-firewall-rule)

[**拦截 AI 机器人 — 防火墙规则**  
\\  
为项目防火墙添加一条自定义规则，用于识别常见 AI 机器人。  
\\  
该规则默认动作为“记录（Log）”；将其更改为“拒绝（Deny）”即可拦截此类机器人。  
\\  
添加防火墙规则](https://vercel.com/templates/vercel-firewall/block-ai-bots-firewall-rule)

## **Adding persistence to rule actions**

## **为规则动作增加持久性**

Previously, each request was evaluated individually, even if similar ones had been blocked moments before. Now, with [persistent actions](https://vercel.com/docs/security/vercel-waf/custom-rules#persistent-actions), rules are applied to all matching requests for a customizable duration. This enhancement allows your firewall to remember malicious behavior, blocking it earlier in the lifecycle and preventing requests from consuming Vercel Edge resources unnecessarily.

此前，每个请求均被单独评估，即便此前数秒内已有相似请求被拦截。如今，借助 [持久化动作（persistent actions）](https://vercel.com/docs/security/vercel-waf/custom-rules#persistent-actions)，匹配规则的请求将在您自定义的时间窗口内持续触发对应动作。这一增强能力使防火墙能够“记住”恶意行为，在请求生命周期更早阶段即实施拦截，避免无效请求无谓消耗 Vercel 边缘网络资源。

Persistent actions are critical in defending against repeat offenders. Instead of wasting time and resources on redundant evaluations, Vercel’s WAF blocks threats as soon as they’re identified. This keeps your application efficient and focused on delivering for real users.

持久化动作对于防御屡次作恶者（repeat offenders）至关重要。Vercel WAF 无需反复进行冗余评估，而是在威胁首次被识别时即刻拦截，从而节省时间与资源，保障您的应用高效运行，并专注于服务真实用户。

![With persistent actions enabled, edge requests are processed earlier in the lifecycle, bypassing both usage metrics and WAF evaluation entirely.](images/vercel-waf-upgrade-brings-persistent-actions-rate-limiting-and-api-control-verce/img_001.jpg)![With persistent actions enabled, edge requests are processed earlier in the lifecycle, bypassing both usage metrics and WAF evaluation entirely.](images/vercel-waf-upgrade-brings-persistent-actions-rate-limiting-and-api-control-verce/img_002.jpg)![With persistent actions enabled, edge requests are processed earlier in the lifecycle, bypassing both usage metrics and WAF evaluation entirely.](images/vercel-waf-upgrade-brings-persistent-actions-rate-limiting-and-api-control-verce/img_003.jpg)![With persistent actions enabled, edge requests are processed earlier in the lifecycle, bypassing both usage metrics and WAF evaluation entirely.](images/vercel-waf-upgrade-brings-persistent-actions-rate-limiting-and-api-control-verce/img_004.jpg)With persistent actions enabled, edge requests are processed earlier in the lifecycle, bypassing both usage metrics and WAF evaluation entirely.

![启用持久化动作后，边缘请求将在生命周期更早阶段即被处理，完全绕过用量指标统计与 WAF 评估环节。](images/vercel-waf-upgrade-brings-persistent-actions-rate-limiting-and-api-control-verce/img_001.jpg)![启用持久化动作后，边缘请求将在生命周期更早阶段即被处理，完全绕过用量指标统计与 WAF 评估环节。](images/vercel-waf-upgrade-brings-persistent-actions-rate-limiting-and-api-control-verce/img_002.jpg)![启用持久化动作后，边缘请求将在生命周期更早阶段即被处理，完全绕过用量指标统计与 WAF 评估环节。](images/vercel-waf-upgrade-brings-persistent-actions-rate-limiting-and-api-control-verce/img_003.jpg)![启用持久化动作后，边缘请求将在生命周期更早阶段即被处理，完全绕过用量指标统计与 WAF 评估环节。](images/vercel-waf-upgrade-brings-persistent-actions-rate-limiting-and-api-control-verce/img_004.jpg)启用持久化动作后，边缘请求将在生命周期更早阶段即被处理，完全绕过用量指标统计与 WAF 评估环节。

## **Rate limiting to control request frequency**

## **速率限制：管控请求频次**

With the growth of API-first architectures, controlling the flow of traffic is more important than ever. [Rate limiting](https://vercel.com/docs/security/vercel-waf/rate-limiting) is now [generally available](https://vercel.com/changelog/vercel-waf-rate-limiting-now-generally-available) in Vercel’s WAF, allowing you to set precise request limits for specific endpoints. This means you can prevent API abuse without disrupting the experience for legitimate users.

随着“API 优先”（API-first）架构的普及，对流量流向的精细化管控比以往任何时候都更为关键。[速率限制（Rate limiting）](https://vercel.com/docs/security/vercel-waf/rate-limiting) 功能现已在 Vercel WAF 中 [正式全面开放（generally available）](https://vercel.com/changelog/vercel-waf-rate-limiting-now-generally-available)，支持您为特定端点设置精确的请求频率上限。这意味着您既能有效防范 API 滥用行为，又不会影响合法用户的正常使用体验。

Persistent actions can be combined with rate limiting, allowing you to quickly block bad actors once identified, reducing resource strain efficiently.

持久化操作可与速率限制相结合，使您在识别恶意行为者后能迅速将其屏蔽，从而高效降低资源负载。

You can set up both per-endpoint and general API rules for better traffic control. For example:

您可分别配置按端点（per-endpoint）和全局（general）的 API 限流规则，以实现更精细的流量管控。例如：

- `/api/user` allows 5 requests per minute  
- `/api/user` 每分钟允许 5 次请求  

- `/api/*` allows 100 requests per minute  
- `/api/*` 每分钟允许 100 次请求  

Requests containing `/api` would first be checked against `/api/user`. If the limit is exceeded, the action (e.g., log, block, challenge, or deny) would be applied immediately. If the request passes, it would then be checked against `/api/*`, and the action would be triggered if that limit is exceeded.

所有包含 `/api` 的请求将首先匹配 `/api/user` 规则；若超出该规则设定的限额，则立即执行对应操作（例如：记录日志、屏蔽、人机验证或拒绝访问）。若请求通过 `/api/user` 检查，则继续匹配 `/api/*` 规则；若在此规则下超限，则触发相应操作。

This layered approach provides precise control over specific endpoints while enforcing broader API limits.

这种分层机制既可对特定端点实施精准控制，又能统一保障整体 API 的访问限额。

![Granular rate limiting configuration to set actions, algorithms, time windows, request limits, and tracking keys, allowing precise control of traffic flow and safeguarding your APIs.](images/vercel-waf-upgrade-brings-persistent-actions-rate-limiting-and-api-control-verce/img_005.jpg)![Granular rate limiting configuration to set actions, algorithms, time windows, request limits, and tracking keys, allowing precise control of traffic flow and safeguarding your APIs.](images/vercel-waf-upgrade-brings-persistent-actions-rate-limiting-and-api-control-verce/img_006.jpg)

![细粒度速率限制配置界面：支持设置操作类型、算法、时间窗口、请求上限及追踪键（tracking keys），实现对流量流向的精准调控，并全面保护您的 API。](images/vercel-waf-upgrade-brings-persistent-actions-rate-limiting-and-api-control-verce/img_005.jpg)![细粒度速率限制配置界面：支持设置操作类型、算法、时间窗口、请求上限及追踪键（tracking keys），实现对流量流向的精准调控，并全面保护您的 API。](images/vercel-waf-upgrade-brings-persistent-actions-rate-limiting-and-api-control-verce/img_006.jpg)

Granular rate limiting configuration to set actions, algorithms, time windows, request limits, and tracking keys, allowing precise control of traffic flow and safeguarding your APIs.

细粒度速率限制配置界面：支持设置操作类型、算法、时间窗口、请求上限及追踪键（tracking keys），实现对流量流向的精准调控，并全面保护您的 API。

## **Programmatic control with the Firewall API**

## **通过防火墙 API 实现编程式管控**

With the new [Firewall API](https://vercel.com/docs/rest-api/endpoints/security), you can now programmatically control WAF settings, automating your security workflows and integrating with third-party tools. This API lets you automatically adjust rules based on real-time traffic, helping you stay agile as conditions change.

借助全新的 [Firewall API](https://vercel.com/docs/rest-api/endpoints/security)，您现在可通过编程方式管理 Web 应用防火墙（WAF）配置，自动化安全工作流，并与第三方工具集成。该 API 支持基于实时流量数据自动调整防护规则，助您在环境变化时保持灵活响应。

For instance, if you have your own intelligence feeds or anomaly detection systems, you could programmatically create rules without any manual intervention. This level of automation is critical for teams running large-scale applications, providing flexibility and peace of mind.

例如，如果您拥有自己的威胁情报源或异常检测系统，便可完全通过编程方式创建规则，无需任何人工干预。这种程度的自动化对于运行大规模应用的团队至关重要，既提供了灵活性，也带来了安心保障。

The API covers the full range of Firewall features, so you can manage your WAF even when you’re not actively monitoring it. This is especially valuable for teams responsible for mission-critical applications that can’t afford downtime.

该 API 覆盖防火墙（Firewall）的全部功能，因此即使您未处于主动监控状态，也能随时管理您的 Web 应用防火墙（WAF）。这对于负责关键任务型应用（mission-critical applications）的团队尤为宝贵——这类应用不容许任何停机时间。

## Why Vercel’s approach is different

## 为何 Vercel 的方法与众不同

What sets Vercel apart is the seamless integration of security with development. Unlike traditional WAF solutions that slow down deployment or require complex setups, Vercel’s WAF fits naturally into your development workflow. Security shouldn’t be a burden—it should work for you, not against you.

Vercel 的独特之处在于安全能力与开发流程的无缝融合。不同于传统 WAF 解决方案（往往拖慢部署节奏或需要复杂的配置），Vercel 的 WAF 天然契合您的开发工作流。安全防护不应成为负担——它应当为您服务，而非与您作对。

Vercel’s WAF is designed for speed and flexibility. Deploy security rules instantly and manage them programmatically. This means your team can focus on what matters: building, deploying, and iterating quickly, while knowing your app is protected from threats.

Vercel 的 WAF 专为速度与灵活性而设计：安全规则可即时部署，并支持编程化管理。这意味着您的团队可以专注于真正重要的事情——快速构建、部署与迭代，同时确信您的应用已受到威胁防护。

At Vercel, our goal is a web that’s secure by default. These WAF enhancements are a key part of that vision, ensuring you have the control and protection you need to keep your application fast, secure, and focused on serving real users.

在 Vercel，我们的目标是打造“默认即安全”的网络环境。这些 WAF 增强功能正是实现该愿景的关键一环，确保您拥有所需的控制力与防护能力，让应用持续保持高速、安全，并始终聚焦于服务真实用户。

[**Rate Limit API Requests - Firewall Rule**  
**限制 API 请求频率 — 防火墙规则**

Add a custom rule to your project's Firewall to rate limit API requests.  
在您项目的防火墙中添加一条自定义规则，以限制 API 请求的调用频率。

This rule defaults to 'Log.' Change it to 'Deny' to actually block these requests.  
该规则默认动作为“记录（Log）”；将其更改为“拒绝（Deny）”，即可实际拦截这些请求。

Add Firewall Rule](https://vercel.com/templates/vercel-firewall/rate-limit-api-requests-firewall-rule)
{% endraw %}
