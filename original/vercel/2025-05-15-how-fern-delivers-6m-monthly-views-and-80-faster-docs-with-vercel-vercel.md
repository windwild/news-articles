---
title: "How Fern delivers 6M+ monthly views and 80% faster docs with Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-fern-delivers-6m-monthly-views-and-80-faster-docs-with-vercel"
date: "2025-05-15"
scraped_at: "2026-03-02T09:33:19.645597035+00:00"
language: "en"
translated: false
description: "Fern used Vercel and Next.js to achieve efficient multi-tenancy, faster development cycles, and 50-80% faster load times"
---




May 15, 2025

Learn how this documentation provider uses Vercel and Next.js to achieve efficient multi-tenancy, faster development cycles, and 50-80% faster load times.

#### 83%

Reduction in deploy times

#### 3x

Faster time to first byte

[Talk to an Expert](https://vercel.com/contact/sales)

[Fern](https://buildwithfern.com/) is improving how teams build and host documentation. As a [multi-tenant platform](https://vercel.com/solutions/multi-tenant-saas), Fern enables companies like Webflow and ElevenLabs to create, customize, and serve API documentation from a single Next.js application—scaling seamlessly across multiple customer domains. With 6 million+ page views per month and 1 million+ unique visitors, performance and reliability are key.

By running on Vercel’s infrastructure, Fern benefits from automatic caching, optimized content delivery, and instant scalability, all while maintaining a fast iteration cycle for development. Additionally, their migration to [Next.js App Router](https://nextjs.org/docs/app) has driven a 50-80% reduction in page load times, improving navigation speed and [Lighthouse scores](https://developer.chrome.com/docs/lighthouse/performance/performance-scoring) for customers worldwide.

![Example of developer documentation built with Fern and hosted on Vercel. ](images/how-fern-delivers-6m-monthly-views-and-80-faster-docs-with-vercel-vercel/img_001.jpg)Example of developer documentation built with Fern and hosted on Vercel.

## **Building a multi-tenant platform on Vercel**

Fern’s architecture is built around a single Next.js app running on Vercel, handling multi-tenant routing across various customer domains. Instead of deploying separate instances for each customer, Fern uses [Vercel Middleware](https://vercel.com/docs/edge-middleware) to dynamically route traffic, keeping infrastructure simple and efficient.

![The architecture behind prod.ferndocs.com](images/how-fern-delivers-6m-monthly-views-and-80-faster-docs-with-vercel-vercel/img_002.jpg)![The architecture behind prod.ferndocs.com](images/how-fern-delivers-6m-monthly-views-and-80-faster-docs-with-vercel-vercel/img_003.jpg)The architecture behind prod.ferndocs.com

The team’s deployment strategy includes a main multi-tenant stack at `prod.ferndocs.com`, a performance-optimized version at `app.ferndocs.com` focused on CDN delivery, and a dedicated development environment at `dev.ferndocs.com`. With Vercel's [custom domain](https://vercel.com/docs/domains/working-with-domains/add-a-domain) support, they also give customers full control over their documentation URLs.

With Vercel's domain management tools, Fern supports both subdomains (docs.website.com) and subpaths (website.com/docs), enabling customers to bring their own domains with just a CNAME DNS record.

[**How to build a multi-tenant app with custom domains using Next.js**\\
\\
Create a full-stack application with multi-tenancy and custom domain support using Next.js App Router, Vercel Postgres, and the Vercel Domains API.\\
\\
Read the guide](https://vercel.com/guides/nextjs-multi-tenant-application)

## **Optimized deployments for rapid iteration**

Fern used to rely on AWS Fargate to run backend services, including a critical indexing script that handled reads and writes to their database and populated Algolia. But deployment through AWS CDK came with a 30-minute feedback loop, from merge to live deploy, which made iteration painfully slow.

By incrementally shifting this work to [Vercel Functions](https://vercel.com/docs/functions), Fern **cut deploy times down to five minutes** and gained the ability to test changes in preview environments before shipping to production.

Overall Vercel deployments have helped them:

- **Deploy multiple times per day** to enabe tight feedback loops and continuous iteration

- [**Manual Promote**](https://vercel.com/docs/deployments/promoting-a-deployment) allows the team to confidently push updates to production

- [**Instant Rollbacks**](https://vercel.com/docs/deployments/promoting-a-deployment#instant-rollback) help avoid the impact of bugs or regressions


By leveraging Vercel’s monorepo support for their open-source [repo](https://github.com/fern-api/fern-platform/), Fern deploys updates across all customer sites in minutes, without managing infrastructure overhead.

## **Enterprise-grade performance**

For businesses, fast-loading documentation is critical. Fern’s customers choose its platform not just for the UI, but for the speed and performance advantages it inherits from Vercel’s CDN.

Vercel delivers content globally to reduce latency, while automatic caching and [Incremental Static Regeneration](https://vercel.com/docs/incremental-static-regeneration) (ISR) ensure that documentation stays current without triggering full site rebuilds. Native video hosting adds another layer of polish to the developer experience, particularly for onboarding, by eliminating the need for third-party platforms and enabling faster, integrated playback.

## **One more thing, Next.js App Router**

Recently, Fern successfully migrated 65% of its platform from Pages Router to App Router in just 7 days, unlocking major performance gains:

- **50-80% faster load times** for documentation pages

- **3x faster time to first byte** (1.63s → 0.55s at p95)

- **React Suspense & loading.tsx** for smoother navigation


To validate these improvements, Fern stress-tested their API documentation platform with with 6,000 simultaneous GET requests, ensuring fast, stable response times across all customer sites.

## **A platform built for growth**

With 63% month-over-month growth, Fern is rapidly scaling to serve customers worldwide. Their ability to iterate quickly, handle customer-specific configurations, and optimize for performance has made them the go-to documentation platform for enterprise companies who demand speed, customization, and availability.

> “Every single day customers ask for more features. Vercel lets us focus on shipping user-facing functionality, abstracting away the infrastructure that would otherwise slow us down.Every single day customers ask for more features. Vercel lets us focus on shipping user-facing functionality, abstracting away the infrastructure that would otherwise slow us down.”
>
> ![](images/how-fern-delivers-6m-monthly-views-and-80-faster-docs-with-vercel-vercel/img_004.png)
>
> **Danny Sheridan,** Co-founder and CEO

By leveraging Vercel’s infrastructure, Next.js App Router, and edge caching, Fern delivers a high-performance, multi-tenant documentation experience without the complexity of managing traditional infrastructure.

[**Talk to a web app building expert**\\
\\
Meet with a web app expert and see how your business can build better applications for your users.\\
\\
Let's Talk](https://vercel.com/contact)