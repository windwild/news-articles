---
title: "New deployments with vulnerable versions of the third-party package next-mdx-remote are now blocked by default - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/new-deployments-with-vulnerable-versions-of-next-mdx-remote-are-now-blocked-by-default"
date: "2026-02-12"
scraped_at: "2026-03-02T09:21:33.009390202+00:00"
language: "en"
translated: false
description: "Any new deployment containing a version of next-mdx-remote that is vulnerable to CVE-2026-0969 will now automatically fail to deploy on Vercel."
---




Feb 12, 2026

Any new deployment containing a version of the third-party package `next-mdx-remote` that is vulnerable to [CVE-2026-0969](https://www.cve.org/CVERecord?id=CVE-2026-0969) will now automatically fail to deploy on Vercel.

We strongly recommend upgrading to a patched version regardless of your hosting provider.

This automatic protection can be disabled by setting the `DANGEROUSLY_DEPLOY_VULNERABLE_CVE_2026_0969=1` environment variable on your Vercel project. [Learn more](https://vercel.com/docs/environment-variables#creating-environment-variables)