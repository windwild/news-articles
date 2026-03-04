---
title: "Static IPs are now available for more secure connectivity - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/static-ips-are-now-available-for-more-secure-connectivity"
date: "2025-10-02"
scraped_at: "2026-03-02T09:27:57.003607067+00:00"
language: "en-zh"
translated: true
description: "Teams on Pro and Enterprise can now access Static IPs to connect to services that require IP allowlisting. Static IPs give your projects consistent outbound IPs without needing the full networking sta..."
---
{% raw %}

Oct 2, 2025

2025 年 10 月 2 日

Pro 和 Enterprise 团队现在可以使用静态 IP（Static IPs）安全地连接至外部服务（例如需进行 IP 白名单配置的数据库）。构建（builds）和函数（functions）产生的出站流量将通过一组稳定、共享的静态 IP 地址路由。

如需启用静态 IP，您可在项目或团队设置中访问 [Connectivity > Static IPs](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fsettings%2Fconnectivity&title=Go+to+Connectivity+Settings)。

静态 IP 是在现有 [Secure Compute](https://vercel.com/docs/connectivity/secure-compute) 功能基础上新增的选项；后者仍面向需要完全专属 VPC 架构的团队提供。请注意，Secure Compute 现已迁移至项目及团队的 Connectivity 设置页面内。

此举是我们推动[更多企业级功能实现自助化](https://vercel.com/blog/new-pro-pricing-plan)战略的一部分。

请查阅 [文档](https://vercel.com/docs/connectivity/static-ips)，或[立即在此启用静态 IP](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fsettings%2Fconnectivity&title=Go+to+Connectivity+Settings)。
{% endraw %}
