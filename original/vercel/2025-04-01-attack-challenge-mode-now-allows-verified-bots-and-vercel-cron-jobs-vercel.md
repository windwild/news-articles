---
title: "Attack Challenge Mode now allows verified bots and Vercel cron jobs - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/attack-challenge-mode-now-allows-verified-bots-and-vercel-cron-jobs"
date: "2025-04-01"
scraped_at: "2026-03-02T09:35:12.229909631+00:00"
language: "en"
translated: false
description: "Vercel's Attack Challenge Mode blocks attacks while securely allowing verified webhooks, search engines, and analytics tools."
---




Apr 1, 2025

Verified webhook providers—including Stripe and PayPal—are now automatically allowed in Attack Challenge Mode, ensuring uninterrupted payment processing. Well-behaved bots from major search engines, such as Googlebot, and analytics platforms are also supported.

Vercel [Cron Jobs](https://vercel.com/docs/cron-jobs) are now exempt from challenges when running in the same account. Like other trusted internal traffic, they bypass Attack Challenge Mode automatically.

To block specific known bots, create [a custom rule](https://vercel.com/docs/vercel-waf/custom-rules) that matches their User Agent. Known bots are validated to be authentic and cannot be spoofed to bypass Attack Challenge Mode.

Learn more about [Attack Challenge Mode](https://vercel.com/docs/attack-challenge-mode) and how [Vercel maintains its directory of legitimate bots](https://vercel.com/docs/attack-challenge-mode#known-bots-support).