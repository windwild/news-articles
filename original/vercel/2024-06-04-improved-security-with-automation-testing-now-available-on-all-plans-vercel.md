---
title: "Improved security with automation testing now available on all plans - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/improved-security-with-automation-testing-now-available-on-all-plans"
date: "2024-06-04"
scraped_at: "2026-03-02T09:43:50.845013233+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jun 4, 2024

You can now more easily run end-to-end tests against deployments protected by [Vercel Authentication](https://vercel.com/docs/security/deployment-protection/methods-to-protect-deployments/vercel-authentication).

All plans can now [create a secret value to bypass authentication](https://vercel.com/docs/security/deployment-protection/methods-to-bypass-deployment-protection/protection-bypass-automation), which can then be set as an HTTP header (or query parameter) named `x-vercel-protection-bypass`.

The automation bypass enables you to protect your project's deployments with [Vercel Authentication](https://vercel.com/docs/security/deployment-protection/methods-to-protect-deployments/vercel-authentication) while still providing access to external services like Checkly and Playwright for your CI/CD e2e testing.

See [how to use Protection Bypass for Automation](https://vercel.com/docs/security/deployment-protection/methods-to-bypass-deployment-protection/protection-bypass-automation#using-protection-bypass-for-automation).