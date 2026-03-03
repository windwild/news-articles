---
title: "Faster and more reliable global propagation - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/faster-and-more-reliable-global-propagation"
date: "2022-06-14"
scraped_at: "2026-03-02T10:01:51.748369114+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jun 14, 2022

![](images/faster-and-more-reliable-global-propagation-vercel/img_001.jpg)![](images/faster-and-more-reliable-global-propagation-vercel/img_002.jpg)

We've upgraded our infrastructure resulting in significant performance and reliability improvements for all plans. Vercel's Edge infrastructure is now **70% faster at p99** for cache purges and configuration updates, serving over 25B requests per week.

Purges now **propagate globally in ~300ms,** regardless of the region the event originated from. These improvements impact all parts of the Vercel platform:

- Faster production rollouts

- Faster domain assignments (e.g. globally updating to the most recent deployment)

- Faster project settings changes (e.g. toggling [password protection](https://vercel.com/support/articles/how-do-i-add-password-protection-to-my-vercel-deployment))

- Faster [Incremental Static Regeneration](https://vercel.com/docs/concepts/next.js/incremental-static-regeneration) (ISR) propagation


[Deploy now](https://vercel.com/templates) to try our improved infrastructure.