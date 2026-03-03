---
title: "Sunsetting the OAuth2 integration entrypoint - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/sunsetting-the-oauth2-integration-entrypoint"
date: "2022-06-14"
scraped_at: "2026-03-02T10:01:48.630180677+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Jun 14, 2022

2022 年 6 月 14 日

![Integration OAUTH - DARK](images/sunsetting-the-oauth2-integration-entrypoint-vercel/img_001.jpg)![Integration OAUTH - DARK](images/sunsetting-the-oauth2-integration-entrypoint-vercel/img_002.jpg)

随着 [API 权限范围（API Scopes）](https://vercel.com/changelog/enhanced-security-with-new-api-scopes-for-integrations) 的推出，OAuth2 入口（OAuth2 entrypoint）将逐步停用。使用 OAuth2 入口的集成必须在 **2022 年 12 月 31 日前** 迁移至 [外部模式（External mode）](https://vercel.com/docs/integrations/install-integration#external) 安装流程，以避免服务中断。

请查阅 [文档](https://vercel.com/docs/integrations/reference#upgrading-your-integration/use-external-flow)，获取详细迁移指南。