---
render_with_liquid: false
title: "Mitigating Denial of Wallet risks with Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/mitigating-denial-of-wallet-risks-with-vercel"
date: "2025-01-24"
scraped_at: "2026-03-02T09:37:33.317946825+00:00"
language: "en-zh"
translated: true
description: "Protect against Denial of Wallet (DoW) attacks with Vercel. DoW exploits cloud scalability to inflate costs. Vercel provides solutions like budget alerts, spend limits, and anomaly detection to safegu..."
---
render_with_liquid: false
render_with_liquid: false

Jan 24, 2025

2025 年 1 月 24 日

Unlike traditional cyberattacks that target code or infrastructure vulnerabilities, Denial of Wallet (DoW) attacks focus on draining a service's operational budget.

与针对代码或基础设施漏洞的传统网络攻击不同，钱包拒绝（Denial of Wallet，DoW）攻击旨在耗尽服务的运营预算。

At Vercel, we're building controls and anomaly detection to help you defend against these threats and protect your applications.

在 Vercel，我们正在构建管控机制与异常检测能力，以帮助您抵御此类威胁，保护您的应用程序。

## -attack) What is a Denial of Wallet (DoW) attack?

## -attack) 什么是钱包拒绝（Denial of Wallet，DoW）攻击？

DoW attacks exploit cloud scalability to drive up operational costs. [Introduced by OWASP in 2017](https://owasp.org/www-project-serverless-top-10/), these attacks inflate resource consumption—such as bandwidth or compute power—to inflict financial damage. Unlike Denial of Service (DoS) attacks, which disrupt availability, DoW targets your budget, threatening profitability and long-term sustainability.

DoW 攻击利用云服务的弹性伸缩特性，推高运营成本。[该概念由 OWASP 于 2017 年首次提出](https://owasp.org/www-project-serverless-top-10/)，此类攻击通过放大资源消耗（例如带宽或计算能力），造成直接的财务损失。与以破坏服务可用性为目标的拒绝服务（Denial of Service，DoS）攻击不同，DoW 攻击直接针对您的预算，危及业务盈利能力和长期可持续性。

At its core, a DoW attack is an exhaustion of financial accounts, services, or credits on a cloud-based system. Without the proper protections, these attacks could erroneously charge organizations an uncapped amount. This is especially relevant in elastic cloud environments where costs scale with usage.

本质上，DoW 攻击是对云平台中资金账户、服务配额或信用额度的耗尽式攻击。若缺乏恰当的防护措施，此类攻击可能导致组织被无上限地错误扣费。这一点在成本随用量线性增长的弹性云环境中尤为突出。

### How DoW attacks work

### DoW 攻击如何运作

DoW attacks exploit auto-scaling applications by generating illegitimate requests while staying below rate-limiting thresholds. Attackers avoid detection by distributing their requests across multiple IP addresses and by slowing the request rate to mimic legitimate traffic. This leads to unnecessary scaling of cloud resources and inflated service costs, leaving organizations to pay for traffic that yields no business value.

DoW 攻击通过生成大量非法请求（但单个请求速率仍低于限流阈值）来利用自动伸缩应用。攻击者通过将请求分散至多个 IP 地址，并刻意降低请求频率以模拟真实用户流量，从而规避检测。这将导致云资源被不必要地扩容，服务费用随之飙升，最终使组织为毫无商业价值的流量买单。

Attackers can exploit API endpoints and trigger expensive backend operations, such as database writes, third-party API calls, or resource-intensive computations, by repeatedly sending requests to drive usage and costs.

攻击者可反复向 API 端点发送请求，借此触发高成本的后端操作，例如数据库写入、第三方 API 调用或计算密集型任务，从而人为抬高资源使用量与相关费用。

### The impact: More than just dollars and cents

### 影响：远不止金钱损失

For startups and small businesses, a DoW attack can lead to unforeseen financial strain, diverting funds away from other initiatives. Even larger organizations are not immune, as such attacks can lead to significant disruptions—especially during critical periods like product launches or [seasonal events such as Black Friday-Cyber Monday](https://vercel.com/blog/black-friday-cyber-monday-2024-recap).

对于初创公司和小型企业而言，DoW 攻击可能导致难以预料的财务压力，迫使资金从其他项目中被抽调。即便是规模更大的组织也无法完全幸免——此类攻击可能引发严重业务中断，尤其在产品发布或[黑色星期五—网络星期一等季节性活动期间](https://vercel.com/blog/black-friday-cyber-monday-2024-recap)尤为突出。

The impact spans multiple areas:

其影响波及多个层面：

- **Operational disruption:** When a company is forced to divert resources to investigate and mitigate cost-related incidents, other projects stall

- **运营中断：** 当企业被迫将资源转向调查和缓解与成本相关的安全事件时，其他项目将陷入停滞。

- **Reputation damage:** Attacks shake customer confidence, threatening the relationships and trust you've built

- **声誉损害：** 此类攻击会动摇客户信心，危及您长期建立的客户关系与信任基础。

- **Investor concerns:** Financial instability makes stakeholders wary, especially in a climate where companies must demonstrate responsible budget management

- **投资者担忧：** 财务不稳定令利益相关方心存顾虑，尤其是在当前环境下，企业必须展现出审慎、负责的预算管理能力。

## Our defensive playbook: Preparing for DoW attacks

## 我们的防御方案：为 DoW 攻击做好准备

Vercel’s [secure by default position](https://vercel.com/resources/iterating-towards-secure-by-default) governs our approach to mitigating DoW attacks. Our layered security tooling helps detect sophisticated attacks and minimize their impact on your business. The following built-in features work together to identify and block malicious traffic while maintaining optimal performance for legitimate users, limiting the economic damage of these attacks.

Vercel 坚持[“默认安全”（secure by default）原则](https://vercel.com/resources/iterating-towards-secure-by-default)，以此指导我们应对 DoW 攻击的策略。我们分层部署的安全工具可有效识别高级别攻击，并最大限度降低其对您业务的影响。以下内置功能协同运作，在精准识别并拦截恶意流量的同时，确保合法用户的访问性能始终处于最优水平，从而有效遏制此类攻击带来的经济损失。

### Rate limiting: Your first line of defense

### 速率限制：您的第一道防线

Vercel gives you granular control over [API rate limiting](https://vercel.com/guides/securing-ai-app-rate-limiting#why-do-you-need-rate-limiting), letting you set limits on incoming requests. By capping the traffic to your backend, you can protect against runaway costs caused by automated scripts or malicious actors. It’s like placing a valve on a pipeline—you decide the acceptable flow rate and Vercel enforces it.

Vercel 为您提供细粒度的[API 速率限制控制](https://vercel.com/guides/securing-ai-app-rate-limiting#why-do-you-need-rate-limiting)，使您能够灵活设定对入站请求的限制阈值。通过为后端流量设置上限，您可以有效防范由自动化脚本或恶意行为者引发的费用失控风险。这就像在管道上安装一个阀门——您决定可接受的流量速率，而 Vercel 则负责严格执行。

Rate limits can be adjusted dynamically—without the need to redeploy—to handle a new feature or an unexpected surge in traffic.

速率限制支持动态调整——无需重新部署——即可从容应对新功能上线或突发的流量激增。

### ) Vercel Web Application Firewall (WAF)

### ) Vercel 网络应用防火墙（WAF）

[Vercel's WAF](https://vercel.com/docs/security/vercel-waf) actively identifies and blocks malicious traffic. It defends against common vulnerabilities like SQL injection and XSS while adding the DoW layer of protection with [challenge-response protocols](https://vercel.com/docs/security/attack-challenge-mode) for suspicious activity. This ensures your system scales only for legitimate users.

[Vercel 的 WAF](https://vercel.com/docs/security/vercel-waf) 主动识别并拦截恶意流量，可防御 SQL 注入、跨站脚本（XSS）等常见漏洞；同时，针对可疑活动启用 [挑战-响应协议](https://vercel.com/docs/security/attack-challenge-mode)，叠加一层 DoW（Denial of Wallet，钱包拒绝）防护，确保系统资源仅向真实用户弹性扩展。

Our [ready-made firewall templates](https://vercel.com/templates?type=vercel-firewall) simplify this setup—ensuring digital efficiency while keeping your budget intact.

我们提供 [开箱即用的防火墙模板](https://vercel.com/templates?type=vercel-firewall)，大幅简化部署流程——在保障数字业务高效运行的同时，严守您的预算底线。

### Spend controls and real-time monitoring

### 费用管控与实时监控

Vercel prioritizes cost transparency and control, providing tools to proactively manage your spending:

Vercel 将成本透明度与可控性置于首位，提供一系列工具，助您主动管理支出：

- **Real-time usage monitoring**: Gain visibility into your resource consumption, so you can quickly spot anomalies. If an unexpected spike occurs, you’ll be the first to know

- **实时用量监控**：全面掌握资源使用情况，快速识别异常波动。一旦出现意外用量激增，您将第一时间获知。

- **Budget alerts and spend limits**: Define thresholds to monitor spending and enforce caps, preventing unexpected costs from escalating into financial strain

- **预算告警与支出限额**：自定义阈值以监控费用支出并强制执行上限，防止意外开支升级为财务压力。

These [spend-management controls](https://vercel.com/docs/pricing/spend-management) ensure that your spending limits protect you against unexpected costs.

这些 [费用管理控制功能](https://vercel.com/docs/pricing/spend-management) 可确保您的支出限额切实发挥防线作用，抵御不可预见的成本风险。

### Bot Protection: Keeping automated threats at bay

### 机器人防护：有效遏制自动化威胁

Automated bots are often the culprits behind DoW attacks. Vercel takes a multifaceted approach to bot protection:

自动化机器人往往是 DoW（Denial of Wallet）攻击的幕后推手。Vercel 采用多维度策略，全面强化机器人防护：

- **Behavioral analysis**: By observing request patterns, Vercel can distinguish between human users and malicious bots  
- **行为分析**：通过观察请求模式，Vercel 能够区分真实用户与恶意机器人。

- **Challenge-based verification**: Techniques like CAPTCHAs or browser-based Javascript challenges ensure that bots can’t easily inflate your costs, adding a friction layer to deter automated abuse  
- **基于挑战的验证**：采用 CAPTCHA 或基于浏览器的 JavaScript 挑战等技术，可有效防止机器人轻易推高您的费用，并通过增加交互摩擦来遏制自动化滥用。

- **Adaptive filtering**: Vercel analyses signatures of bots mimicking legitimate user behavior to stop low-quality traffic at the platform level  
- **自适应过滤**：Vercel 分析伪装成合法用户行为的机器人特征，从平台层面拦截低质量流量。

With [continuously improving detection](https://vercel.com/changelog/vercel-firewall-now-stops-ddos-attacks-up-to-40x-faster), these protective layers ensure your infrastructure is used as intended and shielded from malicious scripts.  
借助[持续优化的检测能力](https://vercel.com/changelog/vercel-firewall-now-stops-ddos-attacks-up-to-40x-faster)，这些多层防护机制确保您的基础设施按预期运行，并免受恶意脚本侵害。

## Securing your cloud costs with Vercel  
## 借助 Vercel 保障云成本安全

As the threat landscape evolves, DoW attacks pose a significant economic risk to cloud-based applications. Vercel's security approach arms you with tools that protect both your infrastructure and your budget through multiple layers of defense:  
随着威胁环境不断演变，耗尽型攻击（DoW）正对云原生应用构成重大的经济风险。Vercel 的安全策略通过多重防御机制，为您提供兼顾基础设施与预算双重保护的工具：

- Granular API rate limiting to control traffic and prevent cost escalation  
- 细粒度 API 速率限制，用于管控流量并防止费用激增  

- Vercel Web Application Firewall (WAF) that filters malicious traffic and ensures scaling only occurs for legitimate requests  
- Vercel Web 应用防火墙（WAF），可过滤恶意流量，并确保仅针对合法请求进行自动扩缩容  

- Real-time monitoring and configurable spending limits for proactive budget control  
- 实时监控与可配置的支出限额，实现主动式预算管控  

- Advanced bot protection through behavioral analysis and challenge-based verification  
- 基于行为分析与挑战式验证的高级机器人防护

With Vercel's secure by default platform, you can scale your digital presence confidently, safeguarded from the financial risks of DoW attacks. Our built-in security features keep cloud elasticity an asset, so you can focus on growing your business.

借助 Vercel 默认安全的平台，您可自信地扩展数字业务版图，免受“拒绝钱包”（DoW）攻击带来的财务风险。我们内置的安全功能确保云资源弹性成为您的优势，让您专注业务增长。

[**Security that scales with you**  
**随您业务规模同步演进的安全防护**  

Explore our comprehensive suite of security tooling to protect your application workloads.  
探索我们全面的安全工具套件，全方位保护您的应用工作负载。  

Learn more  
了解更多](https://vercel.com/security)