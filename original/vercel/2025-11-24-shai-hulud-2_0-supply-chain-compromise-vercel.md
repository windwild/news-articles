---
title: "Shai-Hulud 2.0 Supply Chain Compromise  - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/shai-hulud-2-0-supply-chain-compromise"
date: "2025-11-24"
scraped_at: "2026-03-02T09:25:22.717855803+00:00"
language: "en"
translated: false
description: "Vercel updates that no Vercel-managed systems or internal build processes were impacted by the Shai-Halud 2.0 supply chain compromise "
---




Nov 24, 2025

Multiple npm packages from various web services [were compromised](https://helixguard.ai/blog/malicious-sha1hulud-2025-11-24) through account takeover/developer compromise. A malicious actor was able to add a stealthy loader to the package.json file that locates the Bun runtime, silently installs, then executes a malicious script.

Our investigation has shown that no Vercel environment was impacted and we are notifying a small set of customers with affected builds.

### Impact to Vercel Customers

Vercel has taken immediate steps to address this for our customers. As an initial step, we reset the cache for projects that pulled in any of the vulnerable packages while we continue to investigate whether any loaders successfully ran.

- As of this publication, **no Vercel-managed systems** or internal build processes have been impacted.

- **Preliminary analysis** identified **a limited set of Vercel customer builds** referencing the compromised packages.

- Impacted customers are being contacted directly with detailed mitigation steps.


We will continue to issue updates throughout our investigation.