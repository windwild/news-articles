---
title: "Checkly Integration and Checks API now generally available - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/checkly-integration-and-checks-api-now-generally-available"
date: "2022-01-18"
scraped_at: "2026-03-02T10:03:40.243345938+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Jan 18, 2022

2022 年 1 月 18 日

![Checkly Integration leveraging the Checks API](images/checkly-integration-and-checks-api-now-generally-available-vercel/img_001.jpg)

![利用 Checks API 的 Checkly 集成](images/checkly-integration-and-checks-api-now-generally-available-vercel/img_001.jpg)

With the Vercel Checkly Integration, monitor the Core Web Vitals of your site on every build before it gets deployed so that your performance never degrades.

借助 Vercel Checkly 集成，您可在每次构建完成、正式部署前，监控网站的核心网页指标（Core Web Vitals），从而确保性能永不下降。

This integration can be installed from the [Integration Marketplace](https://vercel.com/integrations/checkly) or Status view, and comes with rich functionality out-of-the-box. You can now:

该集成可通过 [集成市场（Integration Marketplace）](https://vercel.com/integrations/checkly) 或状态视图（Status view）一键安装，并开箱即用，功能丰富。您现在可以：

- Run reliability and performance checks on preview and production

- 在预览环境（preview）和生产环境（production）中运行可靠性与性能检查

- Automatically block your build when checks fail

- 当检查失败时，自动阻断构建流程

- Get deep insights such as web vitals and error logs

- 获取深度洞察，例如网页核心指标（web vitals）与错误日志（error logs）

This Checkly Integration is built using our new [Checks API](https://vercel.com/docs/concepts/deployments/checks#building-your-own-checks) which allows you to insert validation and status checks after a deployment is built but before it is released to production.

本 Checkly 集成基于我们全新的 [Checks API](https://vercel.com/docs/concepts/deployments/checks#building-your-own-checks) 构建，该 API 允许您在部署构建完成后、但尚未发布至生产环境前，插入验证逻辑与状态检查。