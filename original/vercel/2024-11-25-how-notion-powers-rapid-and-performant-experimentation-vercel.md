---
title: "How Notion powers rapid and performant experimentation - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-notion-powers-rapid-and-performant-experimentation"
date: "2024-11-25"
scraped_at: "2026-03-02T09:39:22.401555720+00:00"
language: "en"
translated: false
description: "Notion runs hundreds of experiments per year with Statsig and Next.js on Vercel. Learn how they maintain Core Web Vitals on marketing pages while testing new content with users."
---




Nov 25, 2024

Using Next.js, Vercel, and Statsig to increase iteration velocity and run hundreds of experiments per year.

#### 300%

Increase in speed to deploy hotfixes

#### 0.09

Average Cumulative Layout Shift score

[Talk to an Expert](https://vercel.com/contact/sales)

[Notion](https://www.notion.so/) is a connected workspace that allows users to write, plan, and organize, all enhanced with built-in AI. With a platform as flexible as Notion, the challenge for their website team lies in communicating the vast range of use cases—from personal projects like planning trips to enterprise-level tasks like managing company documentation. That’s a huge total addressable market that attracts many millions of diverse visitors to their website every week. As these numbers continue to rapidly grow and personas expand, Notion needed a website capable of rapid iteration and experimentation to help their message resonate with more people.

## Improving iteration velocity with Vercel

With a small team focused on the marketing site, Notion required an infrastructure solution that enabled quick updates without compromising performance.

Previously, Notion deployed its marketing site using ECS. The team of engineers were web experience specialists and didn't have the resources to spend on configuring infrastructure, leading to challenges with handling traffic spikes, autoscaling issues, and long deployment times. Moving to Vercel simplified these processes by abstracting away infrastructure maintenence. As a result, the team could focus on faster iterations without worrying about complex deployment setups.

Vercel provided the perfect solution to Notion’s need for speed. With Vercel, the marketing team saw a significant boost in development velocity thanks to features like fast deploys and [Instant Rollbacks](https://vercel.com/docs/deployments/instant-rollback). **What once took an hour to deploy a hotfix now takes just 15 minutes (a 75% decrease), and rolling back changes happens in seconds.**

## Statsig and Edge Config for seamless experimentation

Notion's marketing sites are built with Next.js and integrated with [Statsig](https://www.statsig.com/) for experimentation. This integration automatically updates experiments to Vercel's Edge Config store, with [Middleware](https://vercel.com/docs/functions/edge-middleware) handling real-time experimentation at the edge. By using [Vercel Edge Config](https://vercel.com/docs/storage/edge-config) in combination with Statsig's target apps to experiment [server-side](https://vercel.com/docs/frameworks/nextjs#server-side-rendering-ssr), they minimize payload sizes and latency, ensuring no negative impacts to performance or Core Web Vitals. Notion now consistently averages **0.09 or better for** [Cumulative Layout Shift](https://web.dev/articles/cls), placing their site in the top tier for user experience.

![Middleware makes routing decisions based on Statsig. Statsig SDK is bootstrapped from Edge Config instead of fetching from the Statsig API.](images/how-notion-powers-rapid-and-performant-experimentation-vercel/img_001.jpg)![Middleware makes routing decisions based on Statsig. Statsig SDK is bootstrapped from Edge Config instead of fetching from the Statsig API.](images/how-notion-powers-rapid-and-performant-experimentation-vercel/img_002.jpg)Middleware makes routing decisions based on Statsig. Statsig SDK is bootstrapped from Edge Config instead of fetching from the Statsig API.

Feature flags are a crucial component of Notion's setup. Vercel's integrated [Toolbar](https://vercel.com/docs/workflow-collaboration/feature-flags#step-2.-managing-feature-flags-from-the-toolbar) allows both developers and non-developers to easily toggle experiments for testing and iteration, streamlining the rollout process. Notion's marketing team utilizes this integration to run tests aimed at growing their top-of-funnel metrics, specifically increasing the number of new onboarded users.

Toggling on a feature flag from a Vercel Preview Deployment to test a new version of Notion's homepage.

Notion is data-driven and has a strong broader culture of experimentation, **running hundreds of tests per year across their team**. By choosing Statsig and Vercel, the team gets seamless integration, with holistic metrics analysis that offers both top-line and detailed views of performance from feature flags.

[**Start interacting with your application’s feature flags.**\\
\\
Unlock the new workflow today: Use the Vercel Toolbar to read and set feature flag overrides for your application.\\
\\
Get started](https://vercel.com/docs/workflow-collaboration/feature-flags/using-vercel-toolbar)

In addition, Notion uses Vercel’s [monitoring](https://vercel.com/docs/observability/monitoring#monitoring) tools to track performance and resolve issues on their website overall. Weekly queries and ad-hoc dashboards help the engineering team monitor key metrics, such as page errors and caching issues, ensuring the site is always performing at its best even with experiments running.

## Get started with Vercel

Since adopting Vercel, Notion has seen substantial improvements in its development process. The implementation has reduced infrastructure concerns and decreased deployment times, allowing the team to focus on iterating quickly and ship updates that truly speak to their users.

[**Want to add Vercel to your composable stack?**\\
\\
Talk to an expert to learn how you can improve your site’s performance and UX.\\
\\
Get in touch](https://vercel.com/contact/sales)