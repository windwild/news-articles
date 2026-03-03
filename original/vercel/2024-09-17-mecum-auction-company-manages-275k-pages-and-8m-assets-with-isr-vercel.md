---
title: "Mecum Auction Company manages 275K pages and 8M assets with ISR - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/managing-275-thousand-pages-and-8-million-assets-with-isr"
date: "2024-09-17"
scraped_at: "2026-03-02T09:41:32.271069147+00:00"
language: "en"
translated: false
description: "Content-heavy websites don't need to suffer from long build times. With Incremental Static Regeneration (ISR), Mecum Auction Company handles 8M digital assets and 275K pages, while improving performan..."
---




Sep 17, 2024

How digital agency Americaneagle.com helped Mecum Auctions transform their digital presence with over 120M annual page views.

#### 120M+

annual page views

#### 8M+

digital assets

[Talk to an Expert](https://vercel.com/contact/sales)

As the world’s leading in-person car auction enterprise, [Mecum Auction Company](https://www.mecum.com/) has sold some of the most famous vehicles in the world. And while their digital platform had capably evolved over the years, it was hitting its limit, hindering their ability to create listings quickly. With the help of digital agency [Americaneagle.com](https://www.americaneagle.com/), Mecum adopted a new, composable stack—giving them confidence that their website would be fast, performant, and reliable.

![](images/mecum-auction-company-manages-275k-pages-and-8m-assets-with-isr-vercel/img_001.jpg)

### **The need for scalability, speed, and more**

The Mecum ecosystem manages the auction process on a massive scale, especially during their two-day auction events held twice a year. The inventory includes 8 million assets—ranging from cars to trucks—spread across 275,000 individual listing pages or "lots", with hundreds of updates made daily, attracting over 120 million views annually.

Overall, Mecum set out to redesign their entire digital platform so that it would enable their teams to automatically generate pages, update and create content without the help of IT, and provide faster digital experiences for their end users.

### **The solutions that make up the architecture**

Americaneagle.com designed an architecture that would scale and grow with Mecum, while delivering speed and performance. Going headless allowed the team to keep the foundational layers of their system the same, while creating a composable layer that would deliver the flexibility and user experience the team required.

![](images/mecum-auction-company-manages-275k-pages-and-8m-assets-with-isr-vercel/img_002.jpg)![](images/mecum-auction-company-manages-275k-pages-and-8m-assets-with-isr-vercel/img_003.jpg)![](images/mecum-auction-company-manages-275k-pages-and-8m-assets-with-isr-vercel/img_004.jpg)![](images/mecum-auction-company-manages-275k-pages-and-8m-assets-with-isr-vercel/img_005.jpg)

**Dataflow and content management:** The architecture begins with Salesforce as the primary data source. It pushes data into both WordPress and Algolia, creating a foundation for content management and search capabilities.

- Algolia powers the search experience and provides intelligent recommendations for lots, enhancing user engagement and discovery.

- WordPress serves as the central Content Management System (CMS), handling both marketing content pages and enrichment for individual lot pages. This allows Mecum's marketing team to create and manage content efficiently without IT intervention.

- Marketing teams can independently launch new content and campaigns much quicker.

There is no need to leave the CMS environment, streamlining the content creation process and bringing flexibility to update and create content without additional support.


**Vercel and Incremental Static Regeneration (ISR):** At the heart of Mecum's content velocity strategy is Vercel's Frontend Cloud, which serves all pages and implements ISR for lot pages.

- ISR is central to Mecum's content strategy. Instead of pre-generating all 275,000 lot pages (which would be time-consuming and resource-intensive), pages are generated on-demand as users request them.

- Once a lot page is generated, it's cached and served to subsequent users without regeneration, improving performance and reducing server load.

- ISR allows for setting a revalidation period, after which the next request triggers a background regeneration of the page. This ensures that car information stays up-to-date without affecting the user experience.


The team chose WordPress as their CMS for its flexibility and content creation experience, and because WordPress [integrates well with Vercel](https://vercel.com/guides/wordpress-with-vercel). After crafting a design strategy within WordPress to efficiently use pre-structured components, their marketing team can choose from more than 50 custom components to build a variety of page layouts. Now, they can independently launch new content and campaigns much quicker without leaving the CMS.

> “Our new website represents the next step in the digital transformation for Mecum. Mecum.com is an ever growing digital platform where we craft an incredible digital experience for our users. We are incredibly excited to see our digital experience continue to develop in the coming years.Our new website represents the next step in the digital transformation for Mecum. Mecum.com is an ever growing digital platform where we craft an incredible digital experience for our users. We are incredibly excited to see our digital experience continue to develop in the coming years.”
>
> ![](images/mecum-auction-company-manages-275k-pages-and-8m-assets-with-isr-vercel/img_006.jpg)
>
> **Cade Canon,** Director of IT at Mecum Auctions

By redesigning their digital platform, Mecum has significantly improved in how they manage and deliver content. Vercel's Frontend Cloud allows their teams to create and update content without relying on IT support, allowing them to focus on making the best auction experience possible for buyers.

Mecum's new digital platform shows how strategic technology choices can drive efficiency and scalability, while prioritizing the best user experience.

[**Take the first step towards modernizing your tech stack**\\
\\
Talk to an expert to learn how you can make your website faster and more reliable on Vercel.\\
\\
Contact Sales](https://vercel.com/contact/sales)

Blog post

Feb 27, 2023

### Your guide to headless commerce

![](images/mecum-auction-company-manages-275k-pages-and-8m-assets-with-isr-vercel/img_007.jpg)![](images/mecum-auction-company-manages-275k-pages-and-8m-assets-with-isr-vercel/img_008.jpg)

Kiana and Peter

Vercel.com landing page

### The managed, global rendering layer for modern web applications