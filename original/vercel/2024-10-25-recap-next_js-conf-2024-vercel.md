---
title: "Recap: Next.js Conf 2024 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/recap-next-js-conf-2024"
date: "2024-10-25"
scraped_at: "2026-03-02T09:40:11.709967757+00:00"
language: "en"
translated: false
description: "Next.js Conf 2024"
---




Oct 25, 2024

A quick recap of the biggest highlights from Next.js Conf 2024 in San Fransisco.

Our fifth annual [Next.js Conf](https://nextjs.org/conf) finished yesterday, where we shared our research and upcoming improvements to the framework, as well as what's new in the community and Next.js ecosystem. Over 1,000 people in the Next.js community gathered in San Francisco and tens of thousands around the world watched online to see what's new with Next.js.

Since last year's conference, we’ve:

- Released **5 new versions** of Next.js

- Merged **4,000+ pull requests**

- Welcomed **570 new community contributors**

- Crossed over **7 million downloads per week**, making it the world’s most popular frontend framework according to [StackOverflow Developer Survey](https://stackoverflow.blog/2024/07/24/developers-want-more-more-more-the-2024-results-from-stack-overflow-s-annual-developer-survey/) and [State of JavaScript](https://2023.stateofjs.com/en-US/libraries/front-end-frameworks/)


![Next.js isn't possible without our community—thank you.](images/recap-next_js-conf-2024-vercel/img_001.jpg)Next.js isn't possible without our community—thank you.

We also released a new [Next.js community GitHub organization](https://github.com/nextjs), which to start contains ten different templates for deploying Next.js to your favorite providers. In the future, we hope to also include community adapters and other resources here.

As a thank you to our community, all Next.js Conf ticket proceeds have been donated back to open source projects that make Next.js possible.

## Keynote: Make it work, make it right, make it fast

This year’s keynote outlined how Next.js aligns with three simple principles:

- **Make it work:** More predictable data fetching and rendering with a refined App Router model

- **Make it right:** Turbopack for development is now stable—reduction in memory usage, faster initial compilation for large pages, improved error messages and trace stacks, and more to help you iterate with confidence

- **Make it fast:** Fewer, more powerful, and more flexible APIs for easier caching


Watch the Next.js Conf 2024 opening keynote.

### Simplifying complexity

Complexity can be a blocker. To address this, we’re changing how we present the framework through progressive disclosure of complexity. Meaning, if you’re building something simple, you won’t be overloaded with unnecessary details. And if you need advanced features, they’ll be available when you’re ready.

Based on your feedback, we've re-evaluated [Next.js App Routers caching semantics](https://nextjs.org/blog/next-15#caching-semantics). With Next.js 15, we're changing `GET` Route Handlers and the Client Router Cache from cached by default to uncached by default.

We're continuing to improve caching in Next.js. Learn more about what's next in [our journey with caching](https://nextjs.org/blog/our-journey-with-caching). This is still experimental and not ready for production. If you try it out, we'd love your feedback.

Next.js remains a powerful tool for projects of all sizes, but we’re committed to making it feel _effortless_ for every stage of development.

### Turbopack Dev is now stable

Turbopack is now stable for development. With the latest version of Turbopack, you can expect up to **90% faster code updates** versus our previous version, thanks to incremental builds and optimized caching. That means fewer interruptions and faster iterations, so you can stay in your flow.

Learn more about [Turbopack Dev reaching stability](https://nextjs.org/blog/turbopack-for-development-stable). With this milestone accomplished, we’re shifting our focus to Turbopack for builds. You can track our progress by visiting [areweturboyet.com/build](http://areweturboyet.com/build).

### Better education for self-hosting

We released a new [video tutorial](https://www.youtube.com/watch?v=sIVL4JMqRfc) showing how to configure Next.js features like improved image optimization, caching, ISR, streaming, middleware, server components, and more in a self-hosted setup.

Full walkthrough on how to self-hosting Next.js.

Additionally, in Next.js 15, you can now configure the [`expireTime`](https://nextjs.org/docs/app/api-reference/next-config-js/expireTime) value in `next.config.js`. This was previously the `experimental.swrDelta` option and updating the default value to one year, ensuring most CDNs can fully apply the `stale-while-revalidate` semantics as intended. This is important for self-hosting applications when you may need more control over `Cache-Control` directives.

### ​ **And so much more**

Next.js 15 is officially stable and ready for production. Learn more about all the latest features and improvements in our [blog post](https://nextjs.org/blog/next-15).

## Thank you Next.js community

The community's dedication to open-source contributions, innovative ideas, and constant support is what drives Next.js forward. Every line of code contributed, every issue reported, every feature request, and feedback helps us improve and evolve—we can’t wait to see where the next year takes us.

Check out the recorded sessions [here](https://nextjs.org/conf#sessions).




· [Follow](https://x.com/intent/follow?screen_name=timneutkens)

[View on Twitter](https://x.com/timneutkens/status/1849432262380499445)

A developer reached out after enabling Turbopack in Next.js 15:

"The results have been spectacular"

Initial compile: 85% faster
Opening their heaviest page: 97% faster
Fast Refresh on that page: 98% faster

"We use fairly old Windows machines, and honestly, this change for

[8:46 AM · Oct 24, 2024](https://x.com/timneutkens/status/1849432262380499445) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[392](https://x.com/intent/like?tweet_id=1849432262380499445) [Reply](https://x.com/intent/tweet?in_reply_to=1849432262380499445)


[Read 33 replies](https://x.com/timneutkens/status/1849432262380499445)