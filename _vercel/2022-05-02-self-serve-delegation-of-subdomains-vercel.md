---
render_with_liquid: false
title: "Self-serve delegation of subdomains - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/self-serve-delegation-of-subdomains"
date: "2022-05-02"
scraped_at: "2026-03-02T10:02:20.492203423+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

May 2, 2022

2022 年 5 月 2 日

![](images/self-serve-delegation-of-subdomains-vercel/img_001.jpg)![](images/self-serve-delegation-of-subdomains-vercel/img_002.jpg)

If you host multiple subdomains on Vercel throughout separate accounts, you are now able to verify ownership of those subdomains in a self-serve manner via the Vercel Dashboard and API.

如果您在多个独立账户下通过 Vercel 托管多个子域名，现在您即可通过 Vercel 控制台（Dashboard）和 API 自助验证这些子域名的所有权。

Adding a subdomain to a project no longer requires the apex domain. Ownership is established via a token that is generated when the subdomain is added to a project and published in the domain owner’s DNS records.

将子域名添加到项目中，不再需要先拥有该子域名所属的根域名（apex domain）。所有权通过一个令牌（token）来确立：该令牌在子域名被添加至项目时生成，并需发布在域名所有者的 DNS 记录中。

This change makes it easier to share domains for Platforms, teams, and collaborators on Vercel.

此项变更使在 Vercel 上为平台（Platforms）、团队及协作者共享域名变得更加便捷。

To learn more check out the [UI docs](https://vercel.com/docs/concepts/projects/custom-domains#verification-challenge) or REST API docs to [add a domain to a project](https://vercel.com/docs/rest-api#endpoints/projects/add-a-domain-to-a-project) and [verify that domain](https://vercel.com/docs/rest-api#endpoints/projects/verify-project-domain) if needed.

如需了解更多，请查阅 [UI 文档](https://vercel.com/docs/concepts/projects/custom-domains#verification-challenge)，或参考 REST API 文档，了解如何 [将域名添加到项目](https://vercel.com/docs/rest-api#endpoints/projects/add-a-domain-to-a-project) 以及（如有需要）如何 [验证该域名](https://vercel.com/docs/rest-api#endpoints/projects/verify-project-domain)。