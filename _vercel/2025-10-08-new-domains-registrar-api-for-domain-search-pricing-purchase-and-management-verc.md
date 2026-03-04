---
title: "New Domains Registrar API for domain search, pricing, purchase, and management - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/new-domains-registrar-api-for-domain-search-pricing-purchase-and-management"
date: "2025-10-08"
scraped_at: "2026-03-02T09:27:32.529245348+00:00"
language: "en-zh"
translated: true
description: "Vercel Domains Registrar APIs let you search TLDs, fetch pricing, check availability, purchase or renew domains, manage nameservers, and handle transfers."
---

render_with_liquid: false
Oct 8, 2025

2025 年 10 月 8 日

You can now programmatically search, price, buy, renew, and transfer domains with Vercel’s new [Domains Registrar API](https://vercel.com/docs/domains/registrar-api), complementing the new in-product [Domains experience](https://vercel.com/changelog/vercel-domains-at-cost-pricing-and-the-fastest-on-the-web).

您现在可通过 Vercel 全新推出的 [域名注册商 API（Domains Registrar API）](https://vercel.com/docs/domains/registrar-api) 以编程方式执行域名搜索、定价、购买、续费及转移操作，该 API 与产品内全新推出的 [域名体验（Domains experience）](https://vercel.com/changelog/vercel-domains-at-cost-pricing-and-the-fastest-on-the-web) 相辅相成。

The API provides endpoints for:

该 API 提供以下功能接口：

- **Catalog & pricing:** list supported TLDs; get TLD and per-domain pricing.

- **目录与定价**：列出受支持的顶级域（TLD）；获取各 TLD 及单个域名的定价信息。

- **Availability:** check single or bulk availability.

- **可用性查询**：检查单个或批量域名的可注册状态。

- **Orders & purchases:** buy domains (including bulk) and fetch order status by ID.

- **订单与购买**：购买域名（支持批量购买），并根据订单 ID 查询订单状态。

- **Transfers:** retrieve auth codes, transfer in, and track transfer status.

- **域名转入**：获取授权码（auth code）、执行转入操作，并跟踪转入进度。

- **Management:** renew, toggle auto-renewal, update nameservers, and fetch TLD-specific contact schemas.

- **管理功能**：续费域名、开启或关闭自动续费、更新域名服务器（nameservers），以及获取特定 TLD 所需的联系人信息结构（contact schemas）。

The [Legacy Domains API](https://vercel.com/docs/domains/registrar-api#deprecations-and-migration) is now deprecated. If you use the Vercel CLI for domain purchases, pricing, or availability, upgrade to **v48.2.8**. Sunset date: **2025-11-09**.

[旧版域名 API（Legacy Domains API）](https://vercel.com/docs/domains/registrar-api#deprecations-and-migration) 现已弃用。若您通过 Vercel CLI 执行域名购买、定价查询或可用性检查，请升级至 **v48.2.8** 版本。停用日期为：**2025 年 11 月 9 日**。

Explore the [API docs](https://vercel.com/docs/domains/registrar-api).

请查阅 [API 文档](https://vercel.com/docs/domains/registrar-api)。