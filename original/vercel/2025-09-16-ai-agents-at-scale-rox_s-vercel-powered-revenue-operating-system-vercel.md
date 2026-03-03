---
title: "AI agents at scale: Rox’s Vercel-powered revenue operating system - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/ai-agents-at-scale-roxs-vercel-powered-revenue-operating-system"
date: "2025-09-16"
scraped_at: "2026-03-02T09:28:28.326166652+00:00"
language: "en"
translated: false
description: "Learn more about how Rox runs global, AI-driven sales ops on fast, reliable infrastructure thanks to Vercel"
---




Sep 16, 2025

[Rox](https://www.rox.com/) is building the next-generation revenue operating system. By deploying intelligent AI agents that can research, prospect, and engage on behalf of sellers, Rox helps enterprises manage and grow revenue faster.

From day one, Rox has built their applications on Vercel. With Vercel's infrastructure powering their web applications, Rox ships faster, scales globally, and delivers consistently fast experiences to every customer.

## **Executing faster with Vercel**

For Rox, speed is the advantage. The team ships new features every week and needed infrastructure that wouldn’t slow them down. Vercel lets them focus on building, while reliably serving their Next.js apps at scale.

Global performance was another critical factor. With customers in the Middle East, Europe, and beyond, Rox required infrastructure that could deliver consistently fast experiences across regions. Vercel’s [edge network and CDN](https://vercel.com/docs/cdn) provided that reach without extra setup.

Just as important as the speed was the developer experience. From configuration to debugging, Vercel’s developer experience tools allowed Rox’s engineers to spend less time on infrastructure and more time building. Features like image optimization, serverless caching, and [preview environments](https://vercel.com/docs/deployments/environments) gave the team confidence to move quickly and ship with minimal overhead.

Frontend deployments now take only 3-5 minutes (fast enough to push updates right before a customer demo), and post-build hooks make it easy to run end-to-end tests on preview environments with minimal setup.

> “Vercel has a very solid reputation in the tech ecosystem. All of the highest velocity engineering teams are using it to host their web applications. Vercel has a very solid reputation in the tech ecosystem. All of the highest velocity engineering teams are using it to host their web applications. ”
>
> ![](images/ai-agents-at-scale-rox_s-vercel-powered-revenue-operating-system-vercel/img_001.png)
>
> **Jerry Zhou,** Software Engineer at Rox

## **Scaling AI workflows with serverless functions**

A core capability of Rox’s Revenue OS is instantaneous research across thousands of prospects. Rox spins up hundreds to thousands of AI agents that analyze companies in real time.

This creates a technical challenge: most browsers are constrained to executing 100 concurrent calls with HTTP/2.

![The old way of managing requests: scaled linearly to the number of entities and and requests would often stall. ](images/ai-agents-at-scale-rox_s-vercel-powered-revenue-operating-system-vercel/img_002.jpg)![The old way of managing requests: scaled linearly to the number of entities and and requests would often stall. ](images/ai-agents-at-scale-rox_s-vercel-powered-revenue-operating-system-vercel/img_003.jpg)

The old way of managing requests: scaled linearly to the number of entities and and requests would often stall.

To avoid stalled requests, Rox uses [Vercel Serverless Functions](https://vercel.com/docs/functions) to batch these calls and stream results back to the client.

The result is a faster, more consistent experience. Whether it’s a team in Dubai or an enterprise in London, Rox users receive research results in seconds, powered by Vercel’s global network and caching.

![Now: Batching requests with Vercel Serverless](images/ai-agents-at-scale-rox_s-vercel-powered-revenue-operating-system-vercel/img_004.jpg)![Now: Batching requests with Vercel Serverless](images/ai-agents-at-scale-rox_s-vercel-powered-revenue-operating-system-vercel/img_005.jpg)

Now: Batching requests with Vercel Serverless

## **Conversational AI with the Vercel AI SDK**

Rox also uses the [Vercel AI SDK](https://ai-sdk.dev/) to power Rox Command, Rox’s new chat-driven interface that lets users ask questions and take actions - such as pulling up a summary of all interactions with a prospect or generating a draft for an outreach email.

AI SDK makes it simple to stream responses from large language models, enabling Rox to deliver responsive, conversational AI experiences directly in the browser.

With Preview Deployments with comments, Rox could rapidly review new features in production-like environments. This accelerated their product feedback cycles and made it possible to ship Rox Command in weeks rather than months.

![Rox's Command tool helps perform deep research and take revenue-driving actions, built with the AI SDK.](images/ai-agents-at-scale-rox_s-vercel-powered-revenue-operating-system-vercel/img_006.jpg)![Rox's Command tool helps perform deep research and take revenue-driving actions, built with the AI SDK.](images/ai-agents-at-scale-rox_s-vercel-powered-revenue-operating-system-vercel/img_007.jpg)

Rox's Command tool helps perform deep research and take revenue-driving actions, built with the AI SDK.

By building on Vercel, Rox has improved its pace of innovation while ensuring global performance and reliability:

- 3-5 minute deploys, enabling hotfixes and features to go live even right before customer demos

- 2.5x reduction in P95 load speed

- Rox Command feature shipped in weeks, not months, thanks to Preview Deployments and daily reviews that accelerated iteration.

- Seamless multiregion performance, supporting users from Europe to the Middle East


For Rox, speed isn’t just a developer convenience, it’s a competitive edge. Their team is rapidly transforming how go-to-market organizations work with AI agents, and we’re thrilled to support their journey.

[**Ship production-grade AI applications faster with Vercel**\\
\\
Talk to our team to learn more about building AI-powered applications at your organization. \\
\\
Contact Us](https://vercel.com/contact/sales)