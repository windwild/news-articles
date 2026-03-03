---
title: "Sensitive environment variables are now available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/sensitive-environment-variables-are-now-available"
date: "2024-02-01"
scraped_at: "2026-03-02T09:48:17.572413314+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Feb 1, 2024

![](images/sensitive-environment-variables-are-now-available-vercel/img_001.jpg)![](images/sensitive-environment-variables-are-now-available-vercel/img_002.jpg)

You can now add sensitive Environment Variables to your projects for added security of secret values like API keys.

While all Environment Variables are encrypted, **sensitive values can** **only be decrypted during builds**. This replaces our legacy secrets implementation [which is being sunset](https://vercel.com/changelog/legacy-environment-variable-secrets-are-being-sunset).

Get started using [Sensitive Environment Variables](https://vercel.com/docs/projects/environment-variables/sensitive-environment-variables) through the dashboard or with Vercel CLI `33.4`.