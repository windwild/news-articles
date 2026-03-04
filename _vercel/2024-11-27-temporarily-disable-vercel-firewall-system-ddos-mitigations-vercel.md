---
title: "Temporarily disable Vercel Firewall system DDoS mitigations - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/temporarily-disable-vercel-firewall-system-ddos-mitigations"
date: "2024-11-27"
scraped_at: "2026-03-02T09:38:49.613561600+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
&#123;% raw %}

Nov 27, 2024

2024 年 11 月 27 日

Pro 和 Enterprise 计划客户现在可通过 Vercel Firewall 临时禁用所有自动系统防护措施（包括 DDoS 防护）。

我们强烈建议不要禁用防护功能。然而，若您认为当前防护机制误拦了合法流量，此功能可作为紧急情况下的“破窗”选项（break-glass option）。该功能在以下场景中尤为适用：您已在 Vercel 前端部署了代理服务器，且该代理本身已提供 DDoS 防护，但可能与 Vercel 自身的防护机制产生干扰。

如需临时禁用系统防护措施，请访问 Vercel 控制台中的 [Firewall 标签页](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Ffirewall&title=Firewall+tab)，点击右上角的省略号（⋯）菜单以展开更多选项。确认您希望临时禁用全部系统防护后，您的项目所有流量将在接下来的 24 小时内绕过 Vercel Firewall 的系统级 DDoS 防护。

Vercel Firewall 的系统级防御机制默认对所有计划下的所有项目自动启用，[每周可拦截数十亿次恶意连接尝试](https://vercel.com/blog/preventing-infrastructure-abuse-with-vercel-firewall)，并防止资源滥用。客户在禁用自动化防护时须极度谨慎，因为一旦禁用，任何攻击都将无法被拦截。

**请注意：使用此功能所产生的全部费用（包括本可被拦截的非法流量所导致的费用）均由您自行承担。**

了解更多关于 [Vercel Firewall 的自动 DDoS 防护机制](https://vercel.com/docs/security/ddos-mitigation#bypass-system-level-mitigations)。
&#123;% endraw %}
