---
title: "Life of a request: Securing your app's traffic with Vercel - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/life-of-a-request-securing-your-apps-traffic-with-vercel"
date: "2024-12-05"
scraped_at: "2026-03-02T09:38:39.536093595+00:00"
language: "en-zh"
translated: true
description: "The Vercel Firewall automatically prevents over 1B malicious requests every week, with 5x that amount coming in over Black Friday-Cyber Monday.  Learn how Vercel protects every request so you can focu..."
---

render_with_liquid: false
Dec 5, 2024

2024 年 12 月 5 日

In any given week, Vercel Firewall blocks over one billion malicious connections—proactively safeguarding your app before the first request arrives. Defining access rules ensures your infrastructure scales only for legitimate traffic, keeping resources secure and associated costs in check.

在任意一周内，Vercel 防火墙均可拦截逾十亿次恶意连接——在首个请求抵达之前即主动保护您的应用。定义访问规则可确保您的基础设施仅针对合法流量进行弹性伸缩，从而保障资源安全，并有效控制相关成本。

With Vercel, application protection is integrated into every step of the request lifecycle. It starts with the platform-wide Vercel Firewall—active by default for all users—and extends to Deployment Protection and the Web Application Firewall (WAF) which give you granular security control and defense-in-depth.

借助 Vercel，应用防护已深度集成至请求生命周期的每一个环节：起始于面向全平台默认启用的 Vercel 防火墙；并进一步延伸至部署防护（Deployment Protection）与 Web 应用防火墙（WAF），为您提供细粒度的安全管控能力及纵深防御体系。

[**Catch up: Read Part I**\\
\\
Life of a Vercel request: What happens when a user presses enter\\
\\
Read now](https://vercel.com/blog/life-of-a-vercel-request-what-happens-when-a-user-presses-enter)

[**回顾：阅读第一部分**\\
\\
Vercel 请求的生命周期：当用户按下回车键时发生了什么？\\
\\
立即阅读](https://vercel.com/blog/life-of-a-vercel-request-what-happens-when-a-user-presses-enter)

## The first line of defense: Vercel's platform-wide firewall

## 第一道防线：Vercel 全平台防火墙

When requests reach Vercel’s globally distributed Points of Presence (PoP), the Vercel Firewall immediately inspects those requests. This automated, system-wide protection is designed to block threats like Distributed Denial of Service (DDoS) attacks, malicious TCP connections, and other common infrastructure abuses before they escalate.

当请求抵达 Vercel 全球分布式接入点（Point of Presence, PoP）时，Vercel 防火墙即刻对这些请求展开检查。这一自动化、全覆盖的系统级防护机制，旨在于威胁升级前即拦截分布式拒绝服务（DDoS）攻击、恶意 TCP 连接及其他常见基础设施滥用行为。

The Firewall employs a multi-layered approach to address different types of malicious activity:

防火墙采用多层防护策略，以应对不同类型的恶意活动：

- **Network-layer protection (Layer 3):** Detects and blocks large-scale DDoS or [SYN flood](https://en.wikipedia.org/wiki/SYN_flood) attacks targeting your app

- **网络层防护（第 3 层）：** 检测并拦截针对您应用的大规模 DDoS 攻击或 [SYN Flood](https://zh.wikipedia.org/wiki/SYN洪泛攻击) 攻击

- **Transport-layer protection (Layer 4):** Prevents malicious traffic, such as [UDP floods](https://en.wikipedia.org/wiki/UDP_flood_attack), from progressing into your infrastructure

- **传输层防护（第 4 层）：** 阻止恶意流量（例如 [UDP Flood](https://zh.wikipedia.org/wiki/UDP洪泛攻击)）进入您的基础设施

- **Application-layer protection (Layer 7):** Mitigates targeted attacks, including [HTTP floods](https://en.wikipedia.org/wiki/HTTP_Flood) or [Slowloris](https://en.wikipedia.org/wiki/Slowloris_(cyber_attack)) attempts

- **应用层防护（第 7 层）：** 缓解针对性攻击，包括 [HTTP Flood](https://zh.wikipedia.org/wiki/HTTP洪泛攻击) 或 [Slowloris](https://zh.wikipedia.org/wiki/Slowloris) 等攻击尝试

### Scalable and reliable usage protections

### 可扩展且可靠的用量防护

The firewall integrates with Vercel’s globally distributed PoPs, ensuring that attacks are mitigated close to their source. This minimizes the impact on application resources and prevents unnecessary costs from malicious traffic.

防火墙与 Vercel 全球分布式边缘节点（PoP）深度集成，确保攻击在靠近其源头的位置即被缓解。此举最大限度降低了对应用资源的影响，并避免因恶意流量产生不必要的费用。

The platform-wide firewall is fully managed by Vercel and requires no configuration, offering enterprise-grade security out of the box and allowing developers to focus on building their application rather than managing infrastructure.

该平台级防火墙由 Vercel 全面托管，无需任何配置，开箱即用即可提供企业级安全防护，使开发者得以专注于应用开发，而非基础设施运维。

This first layer of defense is free to all customers, on all plans, and helps block hundreds of millions of illegitimate requests daily, saving customers time and money. When threats are blocked at the platform level—like a [recent DDoS attack that peaked at 1.37 Tbps](https://vercel.com/blog/preventing-infrastructure-abuse-with-vercel-firewall) and was mitigated without downtime or manual intervention—your app stays untouched, and no usage costs are incurred.

这一防御首层对所有客户、所有套餐均免费开放，每日可拦截数亿次非法请求，为客户节省大量时间与成本。当威胁在平台层面即被阻断——例如[近期一次峰值达 1.37 Tbps 的 DDoS 攻击](https://vercel.com/blog/preventing-infrastructure-abuse-with-vercel-firewall)，全程零宕机、零人工干预即完成缓解——您的应用完全不受影响，且不产生任何用量费用。

At this early stage in the request lifecycle, Vercel Firewall enforces blocks already activated by your WAF to stop repeat offenders (called persistent actions, more on this below). System defenses, [IP Blocks](https://vercel.com/docs/security/vercel-waf/ip-blocking), and WAF persistent actions all operate without incurring any usage costs.

在请求生命周期的这一早期阶段，Vercel 防火墙会强制执行您 Web 应用防火墙（WAF）已启用的拦截规则，以阻止屡次作恶者（此类操作称为“持久化动作”，详见下文）。系统级防护、[IP 封禁](https://vercel.com/docs/security/vercel-waf/ip-blocking)以及 WAF 持久化动作，全部运行过程均不产生任何用量费用。

![The Vercel Firewall’s initial stages block malicious traffic using system-wide protections, preset IP rules, and persistent actions to stop repeat offenders—ensuring your resources stay protected without incurring costs.](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_001.jpg)![The Vercel Firewall’s initial stages block malicious traffic using system-wide protections, preset IP rules, and persistent actions to stop repeat offenders—ensuring your resources stay protected without incurring costs.](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_002.jpg)![The Vercel Firewall’s initial stages block malicious traffic using system-wide protections, preset IP rules, and persistent actions to stop repeat offenders—ensuring your resources stay protected without incurring costs.](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_003.jpg)![The Vercel Firewall’s initial stages block malicious traffic using system-wide protections, preset IP rules, and persistent actions to stop repeat offenders—ensuring your resources stay protected without incurring costs.](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_004.jpg)The Vercel Firewall’s initial stages block malicious traffic using system-wide protections, preset IP rules, and persistent actions to stop repeat offenders—ensuring your resources stay protected without incurring costs.

![Vercel 防火墙的初始阶段通过全平台防护机制、预设 IP 规则及持久化动作来拦截恶意流量，从而阻止屡次作恶者——确保您的资源始终受保护，且不产生任何费用。](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_001.jpg)![Vercel 防火墙的初始阶段通过全平台防护机制、预设 IP 规则及持久化动作来拦截恶意流量，从而阻止屡次作恶者——确保您的资源始终受保护，且不产生任何费用。](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_002.jpg)![Vercel 防火墙的初始阶段通过全平台防护机制、预设 IP 规则及持久化动作来拦截恶意流量，从而阻止屡次作恶者——确保您的资源始终受保护，且不产生任何费用。](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_003.jpg)![Vercel 防火墙的初始阶段通过全平台防护机制、预设 IP 规则及持久化动作来拦截恶意流量，从而阻止屡次作恶者——确保您的资源始终受保护，且不产生任何费用。](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_004.jpg)Vercel 防火墙的初始阶段通过全平台防护机制、预设 IP 规则及持久化动作来拦截恶意流量，从而阻止屡次作恶者——确保您的资源始终受保护，且不产生任何费用。

### Deployment Protection: Evaluating requests before the WAF

### 部署防护：在 WAF 之前评估请求

After passing through the platform-wide Firewall, which blocks large-scale attacks and infrastructure-level threats, requests are evaluated by [Deployment Protection](https://vercel.com/docs/security/deployment-protection). This project-level security layer determines whether a request is permitted to proceed based on deployment-specific access rules.

在通过平台级防火墙（用于拦截大规模攻击及基础设施层威胁）之后，请求将交由[部署防护（Deployment Protection）](https://vercel.com/docs/security/deployment-protection)进一步评估。这一项目级安全层依据各部署特有的访问规则，判定请求是否允许继续执行。

Part of what sets Vercel apart is its framework-defined infrastructure, which enables rapid deployment of web applications. Every commit automatically provisions its own infrastructure across environments like preview, staging, and production. While these environments can be publicly accessible, Deployment Protection lets you control access—by Vercel account, password protection, or a range of trusted IPs—ensuring only authorized users can interact with your deployments.

Vercel 的差异化优势之一在于其“框架定义的基础设施”（framework-defined infrastructure），可实现 Web 应用的极速部署。每一次代码提交都会自动为预览（preview）、预发布（staging）和生产（production）等各类环境独立配置基础设施。尽管这些环境可能对外公开，但部署防护功能支持您通过 Vercel 账户、密码保护或可信 IP 地址列表等方式精细管控访问权限，确保仅授权用户方可与您的部署进行交互。

![Deployment Protection safeguards your preview and production URLs with Vercel Authentication, password security, and trusted IP controls.](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_005.jpg)![Deployment Protection safeguards your preview and production URLs with Vercel Authentication, password security, and trusted IP controls.](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_006.jpg)![Deployment Protection safeguards your preview and production URLs with Vercel Authentication, password security, and trusted IP controls.](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_007.jpg)![Deployment Protection safeguards your preview and production URLs with Vercel Authentication, password security, and trusted IP controls.](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_008.jpg)Deployment Protection safeguards your preview and production URLs with Vercel Authentication, password security, and trusted IP controls.

![部署防护通过 Vercel 认证、密码安全机制及可信 IP 控制，全面守护您的预览与生产环境 URL。](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_005.jpg)![部署防护通过 Vercel 认证、密码安全机制及可信 IP 控制，全面守护您的预览与生产环境 URL。](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_006.jpg)![部署防护通过 Vercel 认证、密码安全机制及可信 IP 控制，全面守护您的预览与生产环境 URL。](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_007.jpg)![部署防护通过 Vercel 认证、密码安全机制及可信 IP 控制，全面守护您的预览与生产环境 URL。](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_008.jpg)部署防护通过 Vercel 认证、密码安全机制及可信 IP 控制，全面守护您的预览与生产环境 URL。

## The next layer: Customizable Web Application Firewall

## 下一层：可自定义的 Web 应用防火墙（WAF）

During [this year's Black Friday–Cyber Monday weekend](https://vercel.com/blog/black-friday-cyber-monday-2024-recap), Vercel’s platform processed over 86 billion requests, blocking over 6 billion threats, or ~8% of total inbound requests. Most were stopped by system defenses, with the rest managed by customer-defined web application firewall rules.

在[今年的“黑色星期五–网络星期一”周末期间](https://vercel.com/blog/black-friday-cyber-monday-2024-recap)，Vercel 平台共处理了超过 860 亿次请求，拦截了逾 60 亿次安全威胁，约占全部入站请求的 8%。其中大部分威胁由平台级系统防御自动拦截，其余则由客户自定义的 Web 应用防火墙（WAF）规则进行处置。

While the platform-wide firewall delivers global protections, web applications often require more tailored security measures. This is where the Vercel WAF comes in—providing developers with a flexible, defense-in-depth security strategy with the flexibility to implement their own business logic to determine which traffic to serve.

尽管平台级防火墙可提供全局性防护，但 Web 应用通常需要更精细化、更具针对性的安全策略。此时，Vercel WAF 正式登场——它为开发者提供了一种灵活的纵深防御（defense-in-depth）安全方案，支持通过自定义业务逻辑，精准决定哪些流量应被放行、哪些应被拦截。

- [**Attack Challenge Mode**](https://vercel.com/docs/security/attack-challenge-mode): Activates a "Security Checkpoint" page to verify a user’s browser before granting access, with subsequent requests bypassing the checkpoint

- [**攻击挑战模式（Attack Challenge Mode）**](https://vercel.com/docs/security/attack-challenge-mode)：启用“安全检查点（Security Checkpoint）”页面，在授予用户访问权限前验证其浏览器环境；后续同一会话中的请求将跳过该检查点。

- [**Custom rules engine**](https://vercel.com/docs/security/vercel-waf/custom-rules): Enables granular traffic control by combining parameters and actions, letting developers define which traffic to allow or block

- [**自定义规则引擎（Custom Rules Engine）**](https://vercel.com/docs/security/vercel-waf/custom-rules)：通过组合多种参数与执行动作，实现细粒度流量管控，使开发者能够明确定义允许或阻止哪些流量。

### **Customizing per-request rule logic**

### **按请求定制规则逻辑**

Every request that reaches your app tells a story: where it came from, what it wants, and whether it belongs. The Web Application Firewall (WAF) lets you take charge of this narrative, giving your team the tools to act decisively at every step.

每个抵达您应用的请求都讲述着一个故事：它来自何处、意图何为、是否合法可信。Web 应用防火墙（WAF）让您掌握这一叙事的主动权，为团队提供在每一步果断响应所需的关键工具。

The WAF supports over 15 customizable parameters—including IP addresses, geolocation, user agents, and headers—so you can fine-tune defenses for your app’s unique needs. Paired with actions like logging, issuing challenges, or outright blocking, these parameters let you enforce precise security measures at scale.

WAF 支持 15 种以上可配置参数——包括 IP 地址、地理位置、用户代理（User Agent）、HTTP 请求头等——助您根据应用的独特需求精细调优安全策略。结合日志记录、发起挑战验证、直接拦截等执行动作，这些参数使您得以在海量请求规模下，实施高度精准的安全管控。

![Vercel Web Application Firewall enables precise traffic control with custom rules and actions. Apply per-request rules or set persistent actions to block repeat offenders and prevent unnecessary usage.](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_009.jpg)![Vercel Web Application Firewall enables precise traffic control with custom rules and actions. Apply per-request rules or set persistent actions to block repeat offenders and prevent unnecessary usage.](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_010.jpg)![Vercel Web Application Firewall enables precise traffic control with custom rules and actions. Apply per-request rules or set persistent actions to block repeat offenders and prevent unnecessary usage.](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_011.jpg)![Vercel Web Application Firewall enables precise traffic control with custom rules and actions. Apply per-request rules or set persistent actions to block repeat offenders and prevent unnecessary usage.](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_012.jpg)Vercel Web Application Firewall enables precise traffic control with custom rules and actions. Apply per-request rules or set persistent actions to block repeat offenders and prevent unnecessary usage.

![Vercel Web 应用防火墙通过自定义规则与动作实现精准流量控制。您可针对单个请求设置规则，也可设定持久化动作，以封禁屡次违规者并防止资源滥用。](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_009.jpg)![Vercel Web 应用防火墙通过自定义规则与动作实现精准流量控制。您可针对单个请求设置规则，也可设定持久化动作，以封禁屡次违规者并防止资源滥用。](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_010.jpg)![Vercel Web 应用防火墙通过自定义规则与动作实现精准流量控制。您可针对单个请求设置规则，也可设定持久化动作，以封禁屡次违规者并防止资源滥用。](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_011.jpg)![Vercel Web 应用防火墙通过自定义规则与动作实现精准流量控制。您可针对单个请求设置规则，也可设定持久化动作，以封禁屡次违规者并防止资源滥用。](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_012.jpg)Vercel Web 应用防火墙通过自定义规则与动作实现精准流量控制。您可针对单个请求设置规则，也可设定持久化动作，以封禁屡次违规者并防止资源滥用。

For example:  

例如：

- Block unwanted IP ranges targeting critical endpoints  
- 阻止针对关键端点的恶意 IP 地址段  

- Rate-limit high-frequency requests by region or device  
- 按地域或设备对高频请求进行速率限制  

- Apply rules to specific paths with framework-aware targeting  
- 基于框架感知能力，将规则精准应用到特定路径  

- Log rules to test logic and traffic behavior before applying actions  
- 启用规则日志功能，在实际执行动作前验证规则逻辑与流量行为  

Each rule runs in the order you define, giving you control over priority and execution. Manage configurations programmatically via the [Vercel Firewall API](https://vercel.com/docs/rest-api/endpoints/security) or [Terraform Provider](https://registry.terraform.io/providers/vercel/vercel/latest/docs/resources/firewall_config) to stay in sync with your workflows.  
每条规则均按您定义的顺序执行，从而让您完全掌控规则优先级与执行流程。您可通过 [Vercel 防火墙 API](https://vercel.com/docs/rest-api/endpoints/security) 或 [Terraform Provider](https://registry.terraform.io/providers/vercel/vercel/latest/docs/resources/firewall_config) 以编程方式管理配置，确保安全策略与开发运维工作流保持同步。

Some threats should only be acted on a per-request basis while others require immediate and ongoing intervention. [Persistent actions](https://vercel.com/docs/security/vercel-waf/custom-rules#persistent-actions) ensure malicious requests are blocked early and kept out for an extended period. These blocks stop repeat offenders at the edge, reducing resource usage by preventing further processing—and therefore not counting against edge requests, data transfer, or other usage metrics, ensuring efficient and consistent security enforcement without impacting performance.  
某些威胁仅需在单次请求层面响应，而另一些则需立即且持续干预。[持久化操作（Persistent Actions）](https://vercel.com/docs/security/vercel-waf/custom-rules#persistent-actions) 可确保恶意请求在早期即被拦截，并在较长时间内持续阻止其再次访问。此类拦截发生在边缘节点（edge），可直接阻断累犯者，避免后续处理开销——因此不计入边缘请求次数、数据传输量及其他用量指标，从而在零性能损耗的前提下实现高效、一致的安全防护。

![WAF rules are processed in order, giving them hierarchy—for example, if a BYPASS rule precedes a DENY, the request is allowed through unless the BYPASS condition isn’t met.](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_013.jpg)  
![WAF 规则按顺序执行，形成层级结构——例如，若 BYPASS 规则位于 DENY 规则之前，则请求将被放行，除非 BYPASS 条件未满足。](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_013.jpg)  
![WAF rules are processed in order, giving them hierarchy—for example, if a BYPASS rule precedes a DENY, the request is allowed through unless the BYPASS condition isn’t met.](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_014.jpg)  
![WAF 规则按顺序执行，形成层级结构——例如，若 BYPASS 规则位于 DENY 规则之前，则请求将被放行，除非 BYPASS 条件未满足。](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_014.jpg)  
![WAF rules are processed in order, giving them hierarchy—for example, if a BYPASS rule precedes a DENY, the request is allowed through unless the BYPASS condition isn’t met.](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_015.jpg)  
![WAF 规则按顺序执行，形成层级结构——例如，若 BYPASS 规则位于 DENY 规则之前，则请求将被放行，除非 BYPASS 条件未满足。](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_015.jpg)  
![WAF rules are processed in order, giving them hierarchy—for example, if a BYPASS rule precedes a DENY, the request is allowed through unless the BYPASS condition isn’t met.](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_016.jpg)  
![WAF 规则按顺序执行，形成层级结构——例如，若 BYPASS 规则位于 DENY 规则之前，则请求将被放行，除非 BYPASS 条件未满足。](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_016.jpg)  
WAF rules are processed in order, giving them hierarchy—for example, if a BYPASS rule precedes a DENY, the request is allowed through unless the BYPASS condition isn’t met.  
WAF 规则按顺序执行，形成层级结构——例如，若 BYPASS 规则位于 DENY 规则之前，则请求将被放行，除非 BYPASS 条件未满足。

Finally, once a request passes through custom WAF rules customers can activate rules that are managed by Vercel, like the OWASP Core Ruleset which helps protect against common vulnerabilities like SQL injection, cross-site scripting (XSS), and other OWASP Top 10 threats.  
最后，当请求成功通过自定义 WAF 规则后，客户还可启用由 Vercel 托管的安全规则集（如 OWASP Core Ruleset），以防御 SQL 注入、跨站脚本（XSS）及其他 OWASP Top 10 常见漏洞。

![Requests pass through layered protections—system rules, custom logic, and managed rulesets—before reaching your app. WAF evaluations with persistent actions are shifted earlier to block repeat offenders and reduce resource usage.](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_017.jpg)  
![请求需依次经过多层防护——系统规则、自定义逻辑与托管规则集——方能抵达您的应用。借助持久化操作，WAF 评估被前置执行，从而更早拦截累犯者并降低资源消耗。](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_017.jpg)  
![Requests pass through layered protections—system rules, custom logic, and managed rulesets—before reaching your app. WAF evaluations with persistent actions are shifted earlier to block repeat offenders and reduce resource usage.](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_018.jpg)  
![请求需依次经过多层防护——系统规则、自定义逻辑与托管规则集——方能抵达您的应用。借助持久化操作，WAF 评估被前置执行，从而更早拦截累犯者并降低资源消耗。](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_018.jpg)  
![Requests pass through layered protections—system rules, custom logic, and managed rulesets—before reaching your app. WAF evaluations with persistent actions are shifted earlier to block repeat offenders and reduce resource usage.](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_019.jpg)  
![请求需依次经过多层防护——系统规则、自定义逻辑与托管规则集——方能抵达您的应用。借助持久化操作，WAF 评估被前置执行，从而更早拦截累犯者并降低资源消耗。](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_019.jpg)  
![Requests pass through layered protections—system rules, custom logic, and managed rulesets—before reaching your app. WAF evaluations with persistent actions are shifted earlier to block repeat offenders and reduce resource usage.](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_020.jpg)  
![请求需依次经过多层防护——系统规则、自定义逻辑与托管规则集——方能抵达您的应用。借助持久化操作，WAF 评估被前置执行，从而更早拦截累犯者并降低资源消耗。](images/life-of-a-request-securing-your-app_s-traffic-with-vercel-vercel/img_020.jpg)  
Requests pass through layered protections—system rules, custom logic, and managed rulesets—before reaching your app. WAF evaluations with persistent actions are shifted earlier to block repeat offenders and reduce resource usage.  
请求需依次经过多层防护——系统规则、自定义逻辑与托管规则集——方能抵达您的应用。借助持久化操作，WAF 评估被前置执行，从而更早拦截累犯者并降低资源消耗。

### Building a web that's secure by default  
### 构建默认即安全的 Web

Altogether, there are many components within the early stages of a request's lifecycle that are automatically in place by Vercel and proactively set by customers to secure your app from serving undesired requests.

总体而言，在请求生命周期的早期阶段，Vercel 自动部署了大量组件，同时客户也会主动配置诸多设置，以确保您的应用免受不良请求的影响。

The Vercel Firewall, Deployment Protection, and the Web Application Firewall (WAF) are cornerstones of our vision for a secure by default web. We’re committed to continuous innovation, ensuring our defenses evolve to counter new threats while making security effortless for developers. This commitment extends to proactive investments in WAF technologies and edge infrastructure, helping developers stay ahead in a shifting threat landscape.

Vercel 防火墙（Vercel Firewall）、部署防护（Deployment Protection）以及 Web 应用防火墙（Web Application Firewall，WAF）是我们“默认安全 Web”愿景的三大基石。我们致力于持续创新，确保防御能力不断演进，以应对新兴威胁，同时让开发者享受无负担的安全体验。这一承诺还体现在我们对 WAF 技术和边缘基础设施的前瞻性投入上，助力开发者在动态变化的威胁环境中始终领先一步。