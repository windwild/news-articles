---
title: "Colocate your edge to your data on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/regional-execution-for-ultra-low-latency-rendering-at-the-edge"
date: "2022-10-20"
scraped_at: "2026-03-02T09:59:59.883702208+00:00"
language: "en"
translated: false
description: "At this year's P99 Conference, we discussed how edge computing can reduce latency for end users. See how regional Edge Functions can help."
---




Oct 20, 2022

As we work to make a faster Web, increasing speed typically looks like moving more towards the edge—but sometimes requests are served fastest when those computing resources are close to a data source.

Today, we’re introducing [regional execution of Edge Functions](https://vercel.com/docs/concepts/edge-network/regions) to address this. Regional execution of Edge Functions allow you to specify the region your [Edge Function](https://vercel.com/features/edge-functions) executes in. This capability allows you to run your functions near your data to avoid high-latency waterfalls while taking advantage of the fast cold start times of Edge Functions and ensuring your users have the best experience possible.

## **Avoiding waterfalls with regional execution of Edge Functions**

Vercel CTO Malte Ubl recently shared how to achieve ultra-low latency rendering at the edge at this year’s P99 Conference, a virtual event discussing Internet latency and performance. He outlined historic approaches to rendering sites and new challenges faced by bringing rendering to the edge.

One important consideration Malte discussed was to avoid “waterfalls” in your rendering. A waterfall occurs when a rendering function needs to make multiple queries from a database. When that database is far away from the function, the latency from each request adds up. This results in a slow page for the user. While it may sound counterintuitive, it might be faster to move the function closer to the database rather than closer to the user when using Edge Functions.

## **Moving to the cloud**

When the Web was first born in 1994, building the Web included running it on a server—not just writing code. Developers were responsible for taking care of upgrades, restarting the server when it crashed, and swapping out bad hard drives. Thankfully, we’ve since moved more of our infrastructure to the cloud. Developers first did this with virtual machines, which meant that we didn’t have to manage our own hardware anymore. They then adopted serverless functions, which freed them up to write functions without worrying about the underlying operating system and web server.

However, moving to the cloud wasn’t just an improvement for developers. It was a huge step forward for users, too. By moving sites out of small offices and into data centers with unparalleled network connectivity, users got much faster websites.

Now it’s time for the next step forward: moving computing out of the data center entirely and onto the edge.

![With edge computing, there’s a copy of the content close to everyone. ](images/colocate-your-edge-to-your-data-on-vercel-vercel/img_001.jpg)![With edge computing, there’s a copy of the content close to everyone. ](images/colocate-your-edge-to-your-data-on-vercel-vercel/img_002.jpg)With edge computing, there’s a copy of the content close to everyone.

## **The edge**

With edge computing, content is no longer centralized in one or two data centers. Instead, it’s replicated to Vercel regions across the globe so that there’s a copy of the content close to everyone. Users only need to connect to their nearby Vercel region to view the site. This provides much lower latency than traditional computing.

Edge computing provides more advantages than just geography. To run at the edge, instead of in a traditional data center, Edge Functions run in a compact environment called the [Edge Runtime](https://vercel.com/blog/introducing-the-edge-runtime). Edge Runtime specializes in executing JavaScript, TypeScript, or Wasm. This limited environment is generally less expensive and provides faster cold start times than serverless functions.

## **Data fetching**

Moving functions closer to the user results in lower latency when you’re rendering something self-contained, like [social card images](https://vercel.com/blog/introducing-vercel-og-image-generation-fast-dynamic-social-card-images). But if your function needs to query a data source in a single data center, it can actually add additional latency.

Imagine that you’ve written an Edge Function that queries a database in the US East region iad1, and this function does 3 database lookups. Now imagine that a user in Australia hits this function. If this Edge Function is deployed globally, that user will connect to their closest data center in Sydney, and the function will send 3 queries to the database—over a full second of database queries. While it would be best for the database to be distributed globally, the reality is that many databases aren’t, and won’t be for the foreseeable future.

Imagine instead that you configured your Edge Function to run in US East since it’s closest to your database. Now a request from that user's browser has to travel from Sydney to US East. Once it does, the function running in that region can talk to the database in a few milliseconds instead of hundreds. Even though you’re running the same queries against the same database, you’re only making one request from Sydney to the US, instead of three.

![Regional Edge Functions provide users with the lowest latency. ](images/colocate-your-edge-to-your-data-on-vercel-vercel/img_003.jpg)![Regional Edge Functions provide users with the lowest latency. ](images/colocate-your-edge-to-your-data-on-vercel-vercel/img_004.jpg)Regional Edge Functions provide users with the lowest latency.

Regional Edge Functions allow you to choose between running your Edge Function globally or nearest to your user—providing users with the lowest latency and the best experience on your site.

## **Setting your region**

To configure the region that your Edge Function runs in, you can edit your function’s configuration:

```javascript
export const config = {

2  runtime: 'experimental-edge',

3  regions: ['syd1']

4};
```

Configuring regions for your Edge Functions requires [Next.js v12.3.2](https://nextjs.org/docs) or newer. If you don’t configure this, your Edge Function will continue to default to running globally.

## **Getting started with Edge Functions**

To learn more about regional Edge Functions with Vercel, [check out the documentation](https://vercel.com/docs/concepts/edge-network/regions) or [explore a few examples](https://vercel.com/docs/concepts/edge-network/regions).