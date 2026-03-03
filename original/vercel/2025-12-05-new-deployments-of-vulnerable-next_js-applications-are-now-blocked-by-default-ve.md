---
title: "New deployments of vulnerable Next.js applications are now blocked by default - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/new-deployments-of-vulnerable-next-js-applications-are-now-blocked-by"
date: "2025-12-05"
scraped_at: "2026-03-02T09:24:18.839547220+00:00"
language: "en"
translated: false
description: "Any new deployment containing a version of Next.js that is vulnerable to CVE-2025-66478 will now automatically fail to deploy on Vercel."
---




Dec 5, 2025

Any new deployment containing a version of Next.js that is vulnerable to [CVE-2025-66478](https://github.com/vercel/next.js/security/advisories/GHSA-9qr9-h5gf-34mp) will now automatically fail to deploy on Vercel.

We strongly recommend upgrading to a patched version regardless of your hosting provider. [Learn more](https://vercel.com/blog/resources-for-protecting-against-react2shell)

This automatic protection can be disabled by setting the `DANGEROUSLY_DEPLOY_VULNERABLE_CVE_2025_66478=1` environment variable on your Vercel project. [Learn more](https://vercel.com/docs/environment-variables#creating-environment-variables)