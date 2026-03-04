---
title: "Log Drains now support the Vercel Firewall - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/log-drains-now-support-the-vercel-firewall"
date: "2024-07-15"
scraped_at: "2026-03-02T09:42:55.886823424+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
{% raw %}

Jul 15, 2024

2024年7月15日

![](images/log-drains-now-support-the-vercel-firewall-vercel/img_001.jpg)![](images/log-drains-now-support-the-vercel-firewall-vercel/img_002.jpg)

You can now drain [Vercel Firewall](https://vercel.com/docs/security/vercel-firewall) actions to external providers through Log Drains.

您现在可以通过 Log Drains 将 [Vercel 防火墙](https://vercel.com/docs/security/vercel-firewall) 的操作日志导出至外部服务提供商。

Requests denied by the Vercel Firewall will be drained with the `firewall` source. This includes the following events:

被 Vercel 防火墙拒绝的请求将以 `firewall` 源类型导出至 Log Drains。这包括以下事件：

- Requests blocked by a Custom Rule  
  - 被自定义规则（Custom Rule）拦截的请求

- Requests blocked by Challenge Mode  
  - 被挑战模式（Challenge Mode）拦截的请求

- Requests blocked Managed Rules (e.g. [OWASP CRS](https://vercel.com/docs/security/vercel-waf/managed-rulesets#configure-owasp-core-ruleset))  
  - 被托管规则集（Managed Rules）拦截的请求（例如：[OWASP CRS](https://vercel.com/docs/security/vercel-waf/managed-rulesets#configure-owasp-core-ruleset)）

- Requests blocked by an IP Rule  
  - 被 IP 规则（IP Rule）拦截的请求

If a rule is set to `log` or to `bypass`, requests will not be sent to Log Drains. Firewall actions are also surfaced inside of [Monitoring](https://vercel.com/docs/observability/monitoring).

若某条规则设置为 `log` 或 `bypass`，则相关请求**不会**发送至 Log Drains。此外，防火墙操作也会在 [监控（Monitoring）](https://vercel.com/docs/observability/monitoring) 中展示。

Learn more about the [Log Drains](https://vercel.com/docs/observability/log-drains).

了解更多关于 [Log Drains（日志导出）](https://vercel.com/docs/observability/log-drains) 的信息。
{% endraw %}
