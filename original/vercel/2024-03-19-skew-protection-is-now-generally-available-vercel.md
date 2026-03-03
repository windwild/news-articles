---
title: "Skew Protection is now generally available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/skew-protection-is-now-generally-available"
date: "2024-03-19"
scraped_at: "2026-03-02T09:46:06.016173982+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Mar 19, 2024

![](images/skew-protection-is-now-generally-available-vercel/img_001.jpg)![](images/skew-protection-is-now-generally-available-vercel/img_002.jpg)

Last year, we introduced Vercel's industry-first [Skew Protection mechanism](https://vercel.com/blog/version-skew-protection) and we're happy to announce it is now generally available.

[Skew Protection](https://vercel.com/docs/deployments/skew-protection) solves two problems with frontend applications:

1. If users try to request assets (like CSS or JavaScript files) in the middle of a deployment, Skew Protection enables truly zero-downtime rollouts and ensures those requests resolve successfully.

2. Outdated clients are able to call the correct API endpoints (or React Server Actions) when new server code is published from the latest deployment.


Since the initial release of Skew Protection, we have made the following improvements:

- Skew Protection can now be managed through UI in the advanced Project Settings

- Pro customers now default to **12 hours** **of protection**

- Enterprise customers can get up to **7 days of protection**


Skew Protection is now supported in SvelteKit (`v5.2.0` of the Vercel adapter), previously supported in Next.js (stable in `v14.1.4`), and [more frameworks soon](https://vercel.com/docs/frameworks#frameworks-infrastructure-support-matrix). Framework authors can view a [reference implementation here](https://github.com/sveltejs/kit/pull/11987).

[Learn more in the documentation](https://vercel.com/docs/deployments/skew-protection) to get started with Skew Protection.