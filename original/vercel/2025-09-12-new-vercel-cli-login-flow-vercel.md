---
title: "New Vercel CLI login flow - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/new-vercel-cli-login-flow"
date: "2025-09-12"
scraped_at: "2026-03-02T09:28:36.635049181+00:00"
language: "en"
translated: false
description: "Simplified Vercel CLI login with OAuth 2.0 Device Flow. Sign in securely from any browser. Email and provider-based logins deprecated Feb 1. Upgrade now."
---




Sep 12, 2025

![Authorize Device Flow](images/new-vercel-cli-login-flow-vercel/img_001.jpg)![Authorize Device Flow](images/new-vercel-cli-login-flow-vercel/img_002.jpg)

The `vercel login` command now uses the industry-standard [OAuth 2.0 Device Flow](https://datatracker.ietf.org/doc/html/rfc8628), making authentication more secure and intuitive. You can sign in from any browser-capable device.

When approving a login, be sure to verify the location, IP, and request time before granting access to your Vercel account.

Email-based login (`vercel login your@email.com`) and the flags `--github`, `--gitlab`, `--bitbucket`, `--oob`, and `team` are deprecated. These methods will no longer be supported beginning **February 26, 2026**, except for the `team` method (SAML-based login), which remains supported until **June 1, 2026**.

_Note: Support had previously been extended from the original deprecation date of February 1, 2026 to June 1, 2026. To prioritize user security, we are moving the deprecation date forward: most of these methods will be removed on February 26, 2026, with the_ _`team`_ _method following on June 1, 2026._

**Upgrade today with** **`npm i vercel@latest`**

Learn more in the [docs](https://vercel.com/docs/cli/login).