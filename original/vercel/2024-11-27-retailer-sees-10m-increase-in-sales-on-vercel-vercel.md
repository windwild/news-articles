---
title: "Retailer sees $10M increase in sales on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/retailer-sees-10m-increase-in-sales-on-vercel"
date: "2024-11-27"
scraped_at: "2026-03-02T09:38:58.451952440+00:00"
language: "en"
translated: false
description: "A global sportswear retailer had a record-breaking Black Friday-Cyber Monday last year, which increased sales by $10M: 33% increase in average orders per minute, 500ms reduction in Time to First Byte,..."
---




Nov 27, 2024

A global sportswear retailer's record breaking holiday weekend with Vercel

#### 33% increase

in average orders per minute

#### 10x faster

than Salesforce Commerce Cloud alone

[Talk to an Expert](https://vercel.com/contact/sales)

Founded 30 years ago, this top global retailer has established itself as a leader in the sportswear and apparel industry. With a diverse product range that includes athletic performance gear, footwear, accessories, and casual apparel, the company is renowned for its commitment to innovation and quality. Listed on the NYSE, the retailer reported a revenue of almost 6 billion in 2024 and employs approximately 16,000 people worldwide. Despite a challenging retail environment, it continues to excel in ecommerce, showcasing a 3% growth in direct-to-consumer revenue to 2.3 billion, with ecommerce accounting for 41% of this segment.

## **The challenge**

The retailer faced a critical juncture in its digital transformation, seeking to enhance user experience and optimize performance. Their existing Salesforce Commerce Cloud platform presented significant hurdles, particularly during peak traffic periods like Black Friday. Key challenges included:

### **Performance issues:**

Page load speeds and overall site performance were suboptimal, impacting user experience and potentially leading to a lower conversion rate. The site relied heavily on high-resolution hero images for personalization, creating significant performance bottlenecks. Client-side personalization caused performance regressions, requiring loading the initial hero image, then reloading a personalized version based on user data. This double-loading process negatively affected Largest Contentful Paint (LCP) metrics, creating poor user experiences

### **Organizational complexity:**

Performance issues are even more complicated by team ownership being spread across different parts of the organization, making it difficult to coordinate improvements

### **Scalability concerns:**

The retailer's digital infrastructure struggled to handle high traffic volumes, particularly during peak sales events like Black Friday and Cyber Monday, which saw spikes of 125,000 visitors per hour. An overwhelming amount of redirects and insufficient scalability resulted in site slowdowns and downtime, negatively impacting user experience and sales potential

### **Technical debt and architectural limitations:**

Salesforce Commerce Cloud's monolithic architecture restricted the retailer's ability in adopting modern, headless technologies. The platform’s rigid structure and complexity made it difficult to deploy rapid innovations and improvements, limiting their ability to deliver personalized customer experiences. Additionally, Salesforce Commerce Cloud required specific expertise from a limited talent pool of developers, resulting in high costs for hiring and retaining specialized expertise

These challenges created a perfect storm: poor performance affecting user experience, scalability issues impacting sales, and technical limitations preventing quick solutions. The retailer needed a modern, flexible platform that could handle their complex personalization needs while delivering exceptional performance at scale.

## **The solution**

Vercel's comprehensive solution offered multiple compelling advantages. Vercel Functions and Middleware capabilities enabled management of millions of visitors across multiple domains while delivering personalized user experiences. As the creators of Next.js—a critical component of the ecommerce platform—Vercel provided expert guidance throughout the implementation process:

- **Phased migration:** Initially planning a 5-month homepage migration, they saw positive results from A/B testing against Salesforce Commerce Cloud and rapidly accelerated the entire migration. Product Detail Pages (PDPs) and Product Listing Pages (PLPs) were added within two months, ensuring everything was ready for Black Friday

- **Enhanced performance and scalability:** Vercel's architecture provided significant performance improvements, including a 500ms reduction in Time to First Byte (TTFB). Vercel's automatic failover and function payload redundancy gave the retailer added confidence, ensuring minimal downtime during critical outages


![After moving from a monolithic Salesforce Commerce Cloud setup to a headless architecture, leveraging Vercel for frontend delivery, caching, and compute. ](images/retailer-sees-10m-increase-in-sales-on-vercel-vercel/img_001.jpg)![After moving from a monolithic Salesforce Commerce Cloud setup to a headless architecture, leveraging Vercel for frontend delivery, caching, and compute. ](images/retailer-sees-10m-increase-in-sales-on-vercel-vercel/img_002.jpg)After moving from a monolithic Salesforce Commerce Cloud setup to a headless architecture, leveraging Vercel for frontend delivery, caching, and compute.

## **Business impact**

The collaboration between the retailer and Vercel yielded impressive results. For the first time, the company experienced a Black Friday without any site downtime—a milestone that translated into millions of dollars in revenue. With Vercel they saw:

- 2% increase in overall conversions and a 5x increase in conversion rate at their peak

- 10x faster than Salesforce Commerce Cloud alone in load testing

- 500ms reduction in Time to First Byte

- 33% increase in average orders per minute compared to the previous year


The company's record-breaking holiday weekend was highlighted by a $10 million revenue increase, bringing in $48 million compared to $38 million in the prior year.

[**Ready for the future of ecommerce?**\\
\\
Unlock performance and flexibility with headless commerce. Next.js and Vercel let you modernize your storefront without replacing your backend.\\
\\

## **Approaching Black Friday with confidence**

The retailer's team experienced a significant shift in mindset. The confidence in the platform's stability allowed them to focus on proactive improvements fixing small UI bugs rather than reactive mission critical problem solving.

> “We're so bored because nothing's happening—we're just watching the sales go up.We're so bored because nothing's happening—we're just watching the sales go up.”
>
> ![](images/retailer-sees-10m-increase-in-sales-on-vercel-vercel/img_003.png)
>
> **Lead Developer**

This global sportswear retailer's successful migration to Vercel is a strategic partnership. As the retailer continues to innovate and enhance its digital presence, the partnership with Vercel remains a critical component of its strategy to deliver exceptional user experiences and drive business success.

Vercel.com landing page

### Salesforce Commerce Cloud + Vercel

Vercel.com landing page

### Composable commerce on Vercel