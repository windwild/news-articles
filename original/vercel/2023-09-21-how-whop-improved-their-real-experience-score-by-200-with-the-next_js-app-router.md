---
title: "How Whop improved their Real Experience Score by 200% with the Next.js App Router - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-whop-improved-their-real-experience-score-by-200-with-the-next-js-app"
date: "2023-09-21"
scraped_at: "2026-03-02T09:50:31.131732654+00:00"
language: "en"
translated: false
description: "Whop improved developer experience with Vercel and Next.js"
---




Sep 21, 2023

#### 30s to high 90s

Improvement in RES

#### 13% to 47%

Improvement in Good URLs

[Talk to an Expert](https://vercel.com/contact/sales)

# Products Used

Next.js

Routing Middleware

Comments

Preview Deployments

ISR

Integrations

[Whop](https://whop.com/), an online marketplace for digital products, recognized the importance of having a seamless developer and end-user experience and aimed to transform their platform with a modern tech stack.

To achieve this, they focused on migrating from Ruby on Rails to [Next.js](https://vercel.com/solutions/nextjs), quickly followed by the incremental adoption of [App Router](https://nextjs.org/docs/app) for even better page speed and developer experience.

![](images/how-whop-improved-their-real-experience-score-by-200-with-the-next_js-app-router/img_001.jpg)

## **The initial migration to Next.js for speed, SEO, and DX**

Whop's journey with Next.js and Vercel began with a desire to accelerate their dev process while boosting SEO and performance.

Previously, they were using a full-stack Ruby on Rails application but wanted to explore React for its better developer experience (DX). After extensive research, they decided that Next.js was the ideal choice for their frontend needs, thanks to its strong focus on SEO and speed.

Next.js offers [Incremental Static Regeneration](https://vercel.com/docs/incremental-static-regeneration) (ISR), which allows updates on specific pages as needed—while maintaining page load speeds as fast as statically generated sites. This functionality would give Whop faster pages and better search engine ranking.

They split their tech stack, with Next.js powering the frontend and their existing Rails API handling the backend. This migration to Next.js took just three months of work, and the results were unveiled in a single release.

[**Want to talk to an expert?**\\
\\
Brainstorm with our team about your unique use case of Next.js.\\
\\
Send us a message](https://vercel.com/contact/sales)

## **Adopting App Router for speed and efficiency**

Whop initially started with Next.js using the Pages Router, and they continue to use it for certain parts of their application. They also incrementally migrated much of the Pages Router to App Router, which offers enhanced speed and support for [React Server Components](https://vercel.com/blog/understanding-react-server-components).

In order to incrementally migrate, they used [Edge Middleware](https://vercel.com/docs/functions/edge-middleware) to route traffic between an App Router project and their existing pages project on [whop.com](http://whop.com/). The strategic use of Edge Middleware allowed them to gradually roll out significant site changes while still supporting legacy components.

### React Server Components for a more cohesive DX

Whop's decision to move to App Router was motivated by their commitment to DX, citing solutions like React Server Components. This transition allowed them to bridge the gap between frontend and backend within a single framework.

> “At Whop, our mission is to make everyone an internet entrepreneur. To match the pace of the ever-evolving web, we are successfully leveraging the Vercel ecosystem, including Next.js and Vercel, to build software incredibly quickly, leading to rapid growth.At Whop, our mission is to make everyone an internet entrepreneur. To match the pace of the ever-evolving web, we are successfully leveraging the Vercel ecosystem, including Next.js and Vercel, to build software incredibly quickly, leading to rapid growth.”
>
> ![](https://assets.vercel.com/image/upload/contentful/image/e5382hct74si/5q21v6zMFkxFKE6SNbTSGQ/bc661778b6d143a4c7d835e8060b2104/image.png)
>
> **Tristan Pfannschmidt,** Head of Frontend

While Whop was aware of React Server Components before the migration, they were pleasantly surprised by the power they brought to their development workflow. The ability to fetch and [mutate data directly alongside JSX code](https://vercel.com/blog/understanding-react-server-components#server-actions-react%E2%80%99s-first-steps-into-mutability) means writing less overall code and having a central location for managing and rendering data.

## **The results**

The transition to App Router has transformed Whop's development process by combining frontend and backend functionalities into a unified platform with reusable patterns—making Next.js feel more like a full-stack framework than just a frontend framework—without the complexities of having to know the backend language.

This has resulted in:

- A remarkable **increase in their** [**Real Experience Score**](https://vercel.com/docs/speed-insights#real-user-monitoring-with-real-experience-score-res) **(RES), soaring from the 30s to the high 90s**. Like Lighthouse scores, Vercel's RES gives you performance insights. But unlike Lighthouse, RES is generated from real data points collected from your users' devices, resulting in an authentic evaluation of your users' actual experiences with your application.

- Whop's **percentage of** [**Good URLs**](https://support.google.com/webmasters/answer/10218333?hl=en#:~:text=Good%20URLs%3A%20Percentage%20of%20URLs,in%20the%20Mobile%20Usability%20report) **increasing from 13% to 47%**, meaning they showed good [Core Web Vitals](https://vercel.com/docs/speed-insights#core-web-vitals-explained) and contributed to an overall positive user experience.

- The team also saw **less Cumulative Layout Shift and better Core Web Vitals** overall.


Whop's journey from a monolithic Ruby on Rails application to a Next.js-powered frontend with App Router integration showcases the power of modern, open-source web development tools. Their commitment to speed, scalability, and DX has paid off with impressive performance gains and a more streamlined development process.

[**Want to add Vercel to your composable stack?**\\
\\
Talk to an expert to learn how you can improve your site’s performance and UX.\\
\\
Get in touch](https://vercel.com/contact/sales)

Vercel.com landing page

### Incrementally adopt the App Router

Vercel.com landing page

### Turn your frontend into a profit center

![](images/how-whop-improved-their-real-experience-score-by-200-with-the-next_js-app-router/img_003.svg)

Download the whitepaper