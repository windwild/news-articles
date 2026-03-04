---
title: "Block, rate limit, and challenge traffic with the Vercel Firewall - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/block-rate-limit-and-challenge-traffic-with-the-vercel-firewall"
date: "2024-05-23"
scraped_at: "2026-03-02T09:45:15.622730937+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
&#123;% raw %}

May 23, 2024

2024年5月23日

![](images/block-rate-limit-and-challenge-traffic-with-the-vercel-firewall-vercel/img_001.jpg)![](images/block-rate-limit-and-challenge-traffic-with-the-vercel-firewall-vercel/img_002.jpg)

The [Vercel Firewall](https://vercel.com/docs/security/vercel-firewall) now allows you to create custom rules to log, block, challenge, or rate limit (beta) traffic. The Firewall is available on all plans for free.

[ Vercel 防火墙 ](https://vercel.com/docs/security/vercel-firewall) 现已支持创建自定义规则，用于记录、拦截、质询（challenge）或限流（Beta 版本）流量。该防火墙对所有套餐用户免费开放。

You can define custom rules to handle incoming traffic:

您可定义自定义规则来处理入站流量：

- Rules can be based on 15+ fields including request path, user agent, IP address, JA4 fingerprint, geolocation, HTTP headers, and even target path.

- 规则可基于 15+ 个字段构建，包括请求路径（request path）、用户代理（user agent）、IP 地址、JA4 指纹、地理位置（geolocation）、HTTP 请求头，甚至目标路径（target path）。

- Firewall configuration changes propagate within 300ms globally. If you make a mistake, you can instantly rollback to previous rules.

- 防火墙配置变更将在全球范围内于 300 毫秒内生效。若您配置出错，可立即回滚至先前的规则。

You can now see requests automatically protected by the Firewall, as well as managed custom rules for the WAF. You can also access managed rulesets, included our first ruleset available for Enterprise to mitigate the OWASP core risks.

您现在可以查看由防火墙自动保护的请求，以及 Web 应用防火墙（WAF）所管理的自定义规则。您还可访问预置的规则集（managed rulesets），其中包括我们面向企业客户推出的首个规则集，旨在缓解 OWASP 核心安全风险。

[Learn more](https://vercel.com/docs/security/vercel-waf) about the WAF and available configuration options. [Contact us](https://vercel.com/contact/sales) if you want to try our private beta for rate limiting.

[了解更多](https://vercel.com/docs/security/vercel-waf) 关于 WAF 及其可用配置选项的信息。如需试用限流功能的私有 Beta 版本，请[联系我们](https://vercel.com/contact/sales)。
&#123;% endraw %}
