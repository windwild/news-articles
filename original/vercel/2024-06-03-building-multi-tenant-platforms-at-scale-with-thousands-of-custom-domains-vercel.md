---
title: "Building multi-tenant platforms at scale with thousands of custom domains - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/mintlify-scaling-a-powerful-documentation-platform-with-vercel"
date: "2024-06-03"
scraped_at: "2026-03-02T09:44:07.132914917+00:00"
language: "en"
translated: false
description: "Learn how Mintlify built and scaled their multi-tenant docs platform with custom domains"
---




Jun 3, 2024

How this fast-growing startup built a documentation platform with thousands of custom domains on Vercel.

#### 2,500

Current active domains

[Talk to an Expert](https://vercel.com/contact/sales)

# Products Used

Next.js

Preview Deployments

Domains

ISR

[Mintlify](https://mintlify.com/), a platform for public documentation, is a toolkit for developers to write, maintain and host documentation. The platform offers a flexible solution that can be used out of the box or customized to fit specific needs, enabling developers to create help guides, tutorials, and API references.

### **Vercel: The foundation for scalable documentation**

Mintlify has experienced rapid growth, onboarding thousands of users and seeing widespread adoption among Y Combinator startups. To support this growth, Mintlify relies on Vercel and Next.js to power its platform. Starting out, Mintlify faced scalability challenges with a single static Next.js app that they were cloning repeatedly which also lacked multitenancy capabilities. With Vercel, Mintlify was able to serve multiple customers across different subdomains or custom domains with a single unified codebase. This allowed them to host vast amounts of documentation and seamlessly scale to accommodate their growing user base, leaving the complexities of hosting, scaling, and infrastructure management to Vercel.

### **Multi-tenancy toolkit**

With Vercel's platform, Mintlify is able to programmatically assign free unlimited custom domains, subdomains, and SSL certificates to their users without worrying about these scaling issues. Now, Mintlify's team can dedicate their time and resources to developing their core product and features. Today, Mintlify has 2,500 custom domains connected to their Vercel powered documentation platform, a key sign of customer engagement; someone adding a custom domain means they're truly invested in using Mintlify's docs.

> “Someone adding a custom domain means they're truly invested in using our docs. Vercel's ability to manage custom domains and SSL certificates has been a major time-saver for the Mintlify team.Someone adding a custom domain means they're truly invested in using our docs. Vercel's ability to manage custom domains and SSL certificates has been a major time-saver for the Mintlify team.”
>
> ![](images/building-multi-tenant-platforms-at-scale-with-thousands-of-custom-domains-vercel/img_001.jpg)
>
> **Hahnbee Lee**

### **Empower teams to build features, not infrastructure**

- **Scalability:** Mintlify serves multiple customers across thousands of [custom domains](https://vercel.com/docs/projects/domains/working-with-domains#subdomains-wildcard-domains-and-apex-domains) and terabytes of documentation on a single Vercel project.

- **Performance:** Next.js and Vercel's global edge network deliver fast and efficient performance, crucial for a smooth user experience. With [Incremental Static Regeneration](https://vercel.com/docs/incremental-static-regeneration) (ISR) documentation updates are reflected instantly.

- **Automation:** Vercel's API allows Mintlify to automate custom domain setup and streamline [SSL certificate](https://vercel.com/docs/projects/domains/working-with-ssl) issuance.


> “Mintlify would not have been able to scale as quickly as it has without Next.js and Vercel. Multi-tenancy and all the custom domains connecting to one vercel project is so epic.Mintlify would not have been able to scale as quickly as it has without Next.js and Vercel. Multi-tenancy and all the custom domains connecting to one vercel project is so epic.”
>
> ![](images/building-multi-tenant-platforms-at-scale-with-thousands-of-custom-domains-vercel/img_001.jpg)
>
> **Hahnbee Lee**

Looking ahead, Mintlify is exploring ways to further leverage Vercel's infrastructure, including migrating their dashboard for improved performance. With Vercel as their trusted partner, Mintlify can continue to innovate and provide developers with the tools they need to create world-class documentation.

[**How to build a multi-tenant app with custom domains using Next.js**\\
\\
Create a full-stack application with multi-tenancy and custom domain support using Next.js App Router, Vercel Postgres, and the Vercel Domains API.\\
\\
Read the guide](https://vercel.com/guides/nextjs-multi-tenant-application)