---
title: "Faster and more reliable Managed Infrastructure - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/faster-and-more-reliable-managed-infrastructure"
date: "2023-11-29"
scraped_at: "2026-03-02T09:49:20.741247586+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Nov 29, 2023

![](images/faster-and-more-reliable-managed-infrastructure-vercel/img_001.jpg)![](images/faster-and-more-reliable-managed-infrastructure-vercel/img_002.jpg)

We've upgraded our [Managed Infrastructure](https://vercel.com/docs/infrastructure) resulting in up to **45% faster routing at p99** and reliability improvements for all plans.

When a request is made to a Vercel-managed site, traffic is routed to the nearest Edge Network region with our [Anycast routing](https://vercel.com/blog/behind-the-scenes-of-vercels-infrastructure). Vercel processes the request, identifies the deployment to serve, and instantly retrieves related metadata about the requested deployment.

Now with optimized metadata retrieval and routing, this performance enhancement benefits all workloads. Responses to static resources are then fetched from storage, or dynamic content is generated through Vercel Functions, based on the routing details from the deployment metadata.

These infrastructure improvements benefit all existing and new deployments. [Deploy now](https://vercel.com/templates) or learn more about [Vercel's Managed Infrastructure](https://vercel.com/blog/behind-the-scenes-of-vercels-infrastructure).