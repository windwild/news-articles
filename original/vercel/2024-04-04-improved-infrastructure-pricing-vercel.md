---
title: "Improved infrastructure pricing - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/improved-infrastructure-pricing"
date: "2024-04-04"
scraped_at: "2026-03-03T07:10:45.632660403+00:00"
language: "en"
translated: false
description: "We're reducing pricing on Vercel fundamentals like bandwidth and functions."
---




Apr 4, 2024

Hobby remains free, Pro has reduced prices on bandwidth and functions, and more granular usage metrics for all plans.

Based on your feedback, we're updating how we measure and charge for usage of our infrastructure products.

- We're **reducing pricing** on Vercel fundamentals like **bandwidth and functions**

- For the majority of customers, monthly bills will **remain the same or decrease**

- We're introducing **new primitives** for easier optimization

- You now **pay exactly for what you use** in granular increments

- Our **Hobby tier remains free**


[These changes](https://vercel.com/pricing/coming-soon) will show up on your first bill between June 25 and July 24, 2024. Emails with next steps for your account will be sent to account owners.

## What’s changing and why

Instead of two large, combined metrics (bandwidth and functions), you will now have granular pricing which allows you to optimize each metric individually.

|  | Before | After |
| --- | --- | --- |
| Bandwidth | $0.40/GB | [**Fast Data Transfer**](https://vercel.com/docs/pricing/networking#fast-data-transfer) **:** $0.15/GB¹ **(-62%)**<br>[**Fast Origin Transfer**](https://vercel.com/docs/pricing/networking#fast-origin-transfer) **:** $0.06/GB¹ |
| Functions | $0.40/GB-hr | [**Function Invocations**](https://vercel.com/docs/pricing/serverless-functions) **:** $0.60/million<br>[**Function Duration**](https://vercel.com/docs/pricing/serverless-functions) **:** $0.18/GB-hr **(-55%)** |
| Edge Network Routing | Included in Bandwidth | [**Edge Requests**](https://vercel.com/docs/pricing/networking#edge-requests) **:** $2.00/million¹ |
| Incremental Static Regeneration | Included in Bandwidth | [**Data Cache Reads**](https://vercel.com/docs/pricing/data-cache) **:** $0.40/million<br>[**Data Cache Writes**](https://vercel.com/docs/pricing/data-cache) **: ​​** $4.00/million |

_¹ Price for most traffic, cost will_ [_vary by region_](https://vercel.com/docs/pricing#regional-pricing)

Our updated pricing is more aligned with industry standards and a better representation of the work Vercel is doing for you, rather than bundling together in bandwidth and function metrics.

In addition, over the past year we've added features to the platform to help automatically prevent runaway spend, including [hard spend limits](https://vercel.com/changelog/improved-hard-caps-for-spend-management), [recursion protection](https://vercel.com/changelog/automatic-recursion-protection-for-vercel-serverless-functions), [improved function defaults](https://vercel.com/changelog/serverless-functions-can-now-run-up-to-5-minutes), [Attack Challenge Mode](https://vercel.com/changelog/prevent-malicious-traffic-with-attack-challenge-mode-for-vercel-firewall), and more.

For our Enterprise customers, existing contracts are unaffected. Please reach out to your account team if you have any questions or want to discuss these changes.

![Visualize how our more granular infrastructure metrics are accrued. ](images/improved-infrastructure-pricing-vercel/img_001.jpg)![Visualize how our more granular infrastructure metrics are accrued. ](images/improved-infrastructure-pricing-vercel/img_002.jpg)Visualize how our more granular infrastructure metrics are accrued.

## Frequently Asked Questions

Will my monthly bill increase?

When do these changes go live?

Can you share a before and after pricing example?

Where can I learn more about the new metrics?

Is anything changing about our open source plan?

What is Vercel's commitment to the free tier?

Do cached responses affect usage?

How can I manage my spend?

What is regional pricing?