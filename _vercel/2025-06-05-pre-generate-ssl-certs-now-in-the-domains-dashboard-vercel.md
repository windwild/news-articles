---
render_with_liquid: false
title: "Pre-generate SSL certs, now in the Domains dashboard - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/pre-generate-domain-ssl-certs-now-in-dashboard"
date: "2025-06-05"
scraped_at: "2026-03-02T09:32:43.052323949+00:00"
language: "en-zh"
translated: true
description: "The Domains Dashboard now enables zero-downtime migration by allowing SSL certificates to be pre-provisioned before migrating domains."
---
render_with_liquid: false
render_with_liquid: false

Jun 5, 2025

2025 年 6 月 5 日

You can now pre-generate SSL certificates directly from the Vercel Domains dashboard, enabling zero-downtime domain migrations without using the CLI.

现在，您可直接通过 Vercel 域名控制台预生成 SSL 证书，从而在不使用命令行工具（CLI）的情况下实现零停机时间的域名迁移。

After adding an existing domain to your project, select Pre-Generate Certificate to issue certificates before updating DNS records and initiating the remainder of your domain migration.

在将已有域名添加至项目后，选择“预生成证书”（Pre-Generate Certificate），即可在更新 DNS 记录及启动其余域名迁移流程之前，提前签发证书。

You can still import a zone file or [use Domain Connect](https://vercel.com/changelog/automated-dns-configuration-with-domain-connect-3kcmg61eR38Q5MzKc4D6P) to migrate DNS records from your previous provider.

您仍可通过导入区域文件（zone file），或[使用 Domain Connect](https://vercel.com/changelog/automated-dns-configuration-with-domain-connect-3kcmg61eR38Q5MzKc4D6P) 将 DNS 记录从原有服务商迁移过来。

[Try it out](https://vercel.com/d?to=/%5Bteam%5D/~/domains/&title=Pre-Generate+your+SSL+certificates) or learn more in [the docs](https://vercel.com/docs/domains/pre-generating-ssl-certs).

[立即试用](https://vercel.com/d?to=/%5Bteam%5D/~/domains/&title=Pre-Generate+your+SSL+certificates) 或参阅[文档](https://vercel.com/docs/domains/pre-generating-ssl-certs)了解更多信息。