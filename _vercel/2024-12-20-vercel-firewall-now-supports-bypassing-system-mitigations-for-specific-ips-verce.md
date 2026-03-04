---
title: "Vercel Firewall now supports bypassing system mitigations for specific IPs - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-firewall-now-supports-bypassing-system-mitigations-for-specific-ips"
date: "2024-12-20"
scraped_at: "2026-03-02T09:38:28.124133387+00:00"
language: "en-zh"
translated: true
description: "Customers on paid plans can now configure firewall rules to bypass system mitigations, including DDoS protection, for specific IPs and CIDR ranges."
---

render_with_liquid: false
Dec 20, 2024

2024 年 12 月 20 日

Pro 和 Enterprise 客户现在可以配置防火墙规则，针对特定 IP 地址和 CIDR 网段，绕过系统级防护措施（包括 DDoS 防护）。

我们**强烈建议不要绕过防护措施**。然而，如果您认为这些防护措施误拦了合法流量，本功能可作为紧急情况下的“破窗”选项。此功能尤其适用于以下场景：您在 Vercel 前端部署了代理服务器，该代理本身已提供 DDoS 防护，但可能与 Vercel 自身的防护机制产生干扰。

配置系统绕过规则的操作步骤如下：

1. 在 Vercel 控制台中，进入 [**防火墙（Firewall）**](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Ffirewall&title=Firewall+tab) 页面  

2. 点击右上角的 **Configure（配置）** 按钮，进入配置页面  

3. 在页面底部的 **System Bypass Rules（系统绕过规则）** 区域中，指定需绕过防护措施的 IP 地址或 CIDR 网段，以应用于您的生产环境域名  

请注意：启用此功能后，您须自行承担由此产生的全部用量费用，包括原本可能被拦截的非法流量所导致的费用。

Pro 计划客户最多可配置 3 条绕过规则；Enterprise 计划客户最多可配置 5 条。

了解更多关于 [Vercel 防火墙的自动 DDoS 防护机制](https://vercel.com/docs/security/ddos-mitigation#bypass-system-level-mitigations)。