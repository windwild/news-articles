---
title: "Sensitive environment variables are now available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/sensitive-environment-variables-are-now-available"
date: "2024-02-01"
scraped_at: "2026-03-02T09:48:17.572413314+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Feb 1, 2024

2024 年 2 月 1 日

![](images/sensitive-environment-variables-are-now-available-vercel/img_001.jpg)![](images/sensitive-environment-variables-are-now-available-vercel/img_002.jpg)

You can now add sensitive Environment Variables to your projects for added security of secret values like API keys.

您现在可以在项目中添加敏感环境变量（Sensitive Environment Variables），以增强 API 密钥等机密值的安全性。

While all Environment Variables are encrypted, **sensitive values can** **only be decrypted during builds**. This replaces our legacy secrets implementation [which is being sunset](https://vercel.com/changelog/legacy-environment-variable-secrets-are-being-sunset).

尽管所有环境变量均经过加密，但**敏感值仅可在构建过程中解密**。此举将取代我们已停用的旧版密钥（secrets）实现方案（[该方案正在逐步淘汰中](https://vercel.com/changelog/legacy-environment-variable-secrets-are-being-sunset)）。

Get started using [Sensitive Environment Variables](https://vercel.com/docs/projects/environment-variables/sensitive-environment-variables) through the dashboard or with Vercel CLI `33.4`.

您可通过控制台或 Vercel CLI `33.4` 版本开始使用[敏感环境变量](https://vercel.com/docs/projects/environment-variables/sensitive-environment-variables)。