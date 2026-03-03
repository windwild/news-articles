---
title: "Navigating Web3 dynamism: Ledger's solution to traffic spike stability with Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/ledgers-solution-to-traffic-spike-stability-with-vercel"
date: "2024-10-04"
scraped_at: "2026-03-02T09:40:38.003419215+00:00"
language: "en"
translated: false
description: "Discover how Ledger, a leader in hardware wallets, transformed their online presence to handle unpredictable Web3 traffic spikes. Learn how Vercel and Next.js improved their performance, boosting rele..."
---




Oct 4, 2024

How Ledger scaled Web3 traffic with Next.js and Vercel for 100x more releases and 67% quicker load times.

#### 67%

reduction in load times

#### 6-7 million daily requests

Served with a unified API infrastructure

[Talk to an Expert](https://vercel.com/contact/sales)

# Products Used

Next.js

Preview Deployments

In the world of crypto, market surges and unexpected events create unpredictable traffic spikes, like Gunna wearing a diamond-encrusted Ledger at the Met Gala.

For [Ledger](https://www.ledger.com/)—a leading provider of hardware wallets—capturing this no-notice interest becomes crucial for Ledger’s online presence, which may see traffic fluctuate from 1-5 million users monthly. Navigating the dynamism of the crypto market requires a technical infrastructure as resilient and secure as Ledger’s hardware products.

![Gunna wearing a diamond-encrusted Ledger at the Met Gala sparks demand for Ledger wallets.](images/navigating-web3-dynamism-ledger_s-solution-to-traffic-spike-stability-with-verce/img_001.jpg)Gunna wearing a diamond-encrusted Ledger at the Met Gala sparks demand for Ledger wallets.

## **Limitations of Shopify Liquid**

Ledger's ecommerce site was built on a heavily customized Shopify storefront, designed to overcome the limitations of Shopify's theming engine. This presented significant challenges in implementing engineering best practices such as CI/CD, testing, functional programming, code standards, and linting.

The use of Shopify's Liquid templates restricted their ability to run isomorphic code across client and server, resulting in a fragmented tech stack that prevented component reuse. The Shopify environment also made it difficult to set up isolated testing environments for pull requests, hindering confidence before releasing to production.

To extend functionality beyond Shopify's native capabilities, Ledger had several supporting microservices hosted as AWS Lambda functions. These microservices managed secure interactions outside the Shopify ecosystem, including Web3 login for token gating, and served as intermediaries for third-party integrations.

These microservices also acted as backend for frontend (BFF) layers, adapting and transforming data for better consumption by the client. This was essential for tailoring responses to the frontend’s specific needs, enhancing performance, and user experience. While these functioned well, their separation from the main codebase led to difficulties in synchronizing releases across multiple repositories.

> “In Web3, two weeks is like a year. We need to be able to ship now, not later.In Web3, two weeks is like a year. We need to be able to ship now, not later.”
>
> ![](images/navigating-web3-dynamism-ledger_s-solution-to-traffic-spike-stability-with-verce/img_002.jpg)
>
> **Dominic Green,** Director of Engineering

## **Built on Next.js and Vercel**

Ledger chose Next.js and Vercel to power their online store and critical web applications, leveraging a serverless-first architecture to enhance performance and development speed. This combination enabled developers to own the entire production pipeline without the complexities of Terraform and GitHub Actions, allowing the team to focus on efficient feature delivery. Next.js's flexibility allows Ledger to run isomorphic code, unify their tech stack, and reuse components seamlessly. This strategic move enabled Ledger to build an ecosystem on Vercel, supporting several applications including:

- **Headless ecommerce storefront:** Ledger’s ecommerce platform operates as a headless storefront, utilizing server-side rendering (SSR) to ensure fast and efficient page loads, NextAuth.js for secure user authentication, and API routes to serve as the BFF, handling data fetching and business logic execution

- **Headless applications:** Vercel powers discrete headless applications for diverse use cases. For instance, Ledger’s decentralized applications (DApps) run directly within the discover section of their native applications. [Quest](https://quest.ledger.com/), a Web3 education project, leverages Vercel for dynamic content generation and NFT minting and has seen 76k completed quests and NFTs

- **Unified API infrastructure:** Ledger runs pure API services on Vercel to support a range of functionalities. One key service is the configuration engine for their native apps, which powers various app settings and features. These APIs are designed to be highly available and performant, powering critical app settings and features for a global user base, handling massive traffic loads, consistently serving 6-7 million daily requests


Ledger has adopted a production-first mindset since switching to Vercel. New projects start day one on Vercel. Vercel's git push takes care of deployments. The team configures deployment protection and feature flags, so new features and improvements can roll out when ready. Using Vercel has changed their entire development approach.

![Ledger handles the unpredictable world of crypto with technical infrastructure as resilient and secure as  their hardware products.](images/navigating-web3-dynamism-ledger_s-solution-to-traffic-spike-stability-with-verce/img_003.jpg)Ledger handles the unpredictable world of crypto with technical infrastructure as resilient and secure as their hardware products.

## The r **esults** speak for themselves

Vercel's Next.js integration, performance enhancements, and streamlined deployment process made it the superior choice over AWS. Ledger’s evaluation showed Vercel's edge functions significantly reduced latency and improved load times. Developer feedback also strongly favored Vercel for its intuitive interface and efficient deployment process, making it more cost-effective and user-friendly than replicating the setup on AWS. The impact has been significant:

- **100x increase in release frequency:** From 1-2 releases per 2 weeks to over 100, allowing teams to respond rapidly to market changes

- **67% reduction in load time:** Average page load times dropped from 2.6 seconds to under 0.93 seconds

- **13% improvement in bounce rates:** Leading to higher customer engagement and sales

- **Easier collaboration:** [Preview Deployments](https://vercel.com/docs/deployments/preview-deployments) improve collaboration between teams, speeding up the development and approval process


Ultimately, Ledger gained full control over their development environment, enabling them to set up testing environments and enforce consistent code standards, significantly improving the overall developer experience.

## **Vercel powers Ledger's crypto resilience**

To match the resilience and security of their hardware products, Ledger needed a technical infrastructure that could handle the volatile crypto market. They found their solution in Vercel's serverless-first platform. This approach, combined with Vercel's scalable and secure-by-default infrastructure, empowers Ledger to deliver a consistently smooth and reliable user experience, even amidst market fluctuations.

> “At Ledger, stability is key. Everything went smoothly thanks to our technical choices and architecture.At Ledger, stability is key. Everything went smoothly thanks to our technical choices and architecture.”
>
> ![](images/navigating-web3-dynamism-ledger_s-solution-to-traffic-spike-stability-with-verce/img_002.jpg)
>
> **Dominic Green,** Director of Engineering

Vercel.com landing page

### Composable commerce on Vercel

Vercel.com landing page

### Watch the KidSuper interview