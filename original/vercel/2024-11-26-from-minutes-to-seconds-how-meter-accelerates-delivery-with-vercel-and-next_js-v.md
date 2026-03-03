---
title: "From minutes to seconds: How Meter accelerates delivery with Vercel and Next.js - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/from-minutes-to-seconds-how-meter-accelerates-delivery-with-vercel-and-next"
date: "2024-11-26"
scraped_at: "2026-03-02T09:39:28.280286138+00:00"
language: "en"
translated: false
description: "Meter's updated tech stack with Vercel"
---




Nov 26, 2024

From complex deployments to streamlined workflows, learn how Meter builds with rapid innovation.

#### 98.33%

Reduction in build times

[Talk to an Expert](https://vercel.com/contact/sales)

[Meter](https://www.meter.com/) provides a full-stack networking solution that makes it easy for any business, organization, or school—of any size—to get access to the internet. They have two application layers built on top of their vertically integrated technical architecture: Meter [Command](https://www.meter.com/command), a generative UI for IT and Networking teams, and Meter [Dashboard](https://www.meter.com/dashboard), their main web interface. Meter’s adoption of Vercel has enhanced performance, simplified workflows, and empowered their team to iterate rapidly—not only across Command and Dashboard, but throughout their interconnected stack of hardware, software, and operations.

## Choosing Vercel for speed and integrations

Prior to migrating, Meter’s Dashboard product was hosted through various AWS solutions, with long build times and limited visibility into changes. When evaluating options, Meter's team prioritized fast iteration, speed of deployment, and the seamless integration that Vercel provides for both frontend and backend processes.

![Meter's web application, an intuitive dashboard for network management, hosted on Vercel.](images/from-minutes-to-seconds-how-meter-accelerates-delivery-with-vercel-and-next_js-v/img_001.jpg)Meter's web application, an intuitive dashboard for network management, hosted on Vercel.

### Monorepo management made easier

The team implemented a two-phase migration of Dashboard to Vercel, first transferring over core components and then integrating additional features. Challenges such as managing remote caching and consolidating to a monorepo were handled with Vercel’s support for React, Vite builds, and [previews for every feature branch](https://vercel.com/docs/deployments/preview-deployments).

Today, all of Meter's deployed assets live in a unified repository, enabling easier code management and collaboration across teams. Improved build times— **down from over 10 minutes to less than a minute**—and Vercel’s [flexible rollback capabilities](https://vercel.com/docs/deployments/instant-rollback#performing-an-instant-rollback-on-a-deployment) have increased the reliability and scalability of their deployments.

![Command's current tech stack and architecture.](images/from-minutes-to-seconds-how-meter-accelerates-delivery-with-vercel-and-next_js-v/img_002.jpg)![Command's current tech stack and architecture.](images/from-minutes-to-seconds-how-meter-accelerates-delivery-with-vercel-and-next_js-v/img_003.jpg)Command's current tech stack and architecture.

### Moving and shipping faster

Since the Dashboard migration, the team has noted substantial benefits in CI/CD iteration speed, which helps them quickly push and review code in a production-like environment. Vercel's integrated [git workflow](https://vercel.com/docs/deployments/git) allows for daily production pushes, enabling faster feature releases and reduced need for manual QA.

Meter built Command, on Next.js and Vercel. Command enables Meter users to get information about their networks, take action, and create custom, real-time software—all in natural language and at the speed of a web search.

Vercel and Next.js allow for rapid iteration on the frontend and easily sync with the backend data processing that powers these interactions via Next.js' [API Routes](https://nextjs.org/docs/pages/building-your-application/routing/api-routes). The engineering team can focus on refining the model architecture that powers the product’s backend without worrying about underlying infrastructure details.

The ability to push changes quickly, view updates immediately on their dev site, and iterate efficiently has been transformative for the team working on Command. Vercel ensures that Command remains performant by maintaining a clear separation between client-side and server-side logic, while still allowing seamless communication between the two.

## Get started with Vercel

Meter’s engineering team has observed a marked increase in performance, scalability, and user experience. With every feature branch previewed and reviewed before going live, the team has found a reliable process for maintaining high standards across their products.

As Meter continues to refine its vertically integrated hardware, firmware, and software stack, the streamlined workflow and increased speed on Vercel will enable them to deliver even more powerful products to their customers and partners.

[**Looking to upgrade your infrastructure?**\\
\\
Connect with a Next.js expert and learn about Vercel's best-in-class tooling for site performance and org-wide collaboration.\\
\\
Contact us](https://vercel.com/contact)