---
title: "OPTIONS Allowlist - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/options-allowlist"
date: "2024-05-21"
scraped_at: "2026-03-02T09:45:08.301913504+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




May 21, 2024

![](images/options-allowlist-vercel/img_001.jpg)![](images/options-allowlist-vercel/img_002.jpg)

The OPTIONS Allowlist improves the security of deployments on Vercel by limiting CORS preflight `OPTIONS` requests to specified paths.

Before the OPTIONS Allowlist, all `OPTIONS` requests to deployments bypassed Deployment Protection in compliance with [CORS specifications](https://developer.mozilla.org/docs/Web/HTTP/CORS).

The new OPTIONS Allowlist feature is available on all plans.

Learn more about the [OPTIONS Allowlist](https://vercel.com/docs/security/deployment-protection/methods-to-bypass-deployment-protection/options-allowlist).