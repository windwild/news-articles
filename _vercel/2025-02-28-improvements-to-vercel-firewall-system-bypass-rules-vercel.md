---
title: "Improvements to Vercel Firewall system bypass rules - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/improvements-to-vercel-firewall-system-bypass-rules"
date: "2025-02-28"
scraped_at: "2026-03-02T09:36:00.264972322+00:00"
language: "en-zh"
translated: true
description: "The Vercel Firewall now has additional controls over system bypass rules to improve how firewall rules are deployed "
---

render_with_liquid: false
Feb 28, 2025

2025 年 2 月 28 日

[System bypass rules](https://vercel.com/docs/security/vercel-waf/system-bypass-rules) allow Pro and Enterprise customers to configure firewall rules to skip Vercel system mitigations, including [DDoS protection](https://vercel.com/docs/security/ddos-mitigation#system-bypass-rules), for specific IPs and CIDR ranges. Although we strongly recommend against disabling protections, customers—particularly ones that deploy a proxy in front of Vercel—may experience traffic issues that can be mitigated by deploying system bypass rules.

[系统绕过规则](https://vercel.com/docs/security/vercel-waf/system-bypass-rules) 允许 Pro 和 Enterprise 计划客户配置防火墙规则，针对特定 IP 地址和 CIDR 网段跳过 Vercel 的系统级防护措施（包括 [DDoS 防护](https://vercel.com/docs/security/ddos-mitigation#system-bypass-rules)）。尽管我们强烈建议不要禁用防护功能，但部分客户（尤其是将代理部署在 Vercel 前端的客户）可能会遇到流量异常问题，此时可通过部署系统绕过规则加以缓解。

Improvements to the system bypass rules give customers additional control over how the rules are deployed, including:

系统绕过规则的改进为客户提供了更精细的规则部署控制能力，具体包括：

- Expanded support beyond production domains to preview domains

- 将支持范围从生产环境域名扩展至预览环境域名

- Added support for single domain rules for preview deployment URLs and aliases

- 新增对预览部署 URL 及别名的单域名规则支持

- Expanded project-scoped bypass rules to include all domains connected to a project

- 将项目级绕过规则的适用范围扩展至与该项目关联的所有域名

- Increased limits for system bypass rules for Pro to 25 and Enterprise to 100 (from 3 and 5 respectively)

- 提高系统绕过规则数量上限：Pro 计划由 3 条提升至 25 条，Enterprise 计划由 5 条提升至 100 条

Learn more about the [Vercel Firewall](https://vercel.com/docs/security/vercel-firewall).

了解更多关于 [Vercel 防火墙](https://vercel.com/docs/security/vercel-firewall) 的信息。