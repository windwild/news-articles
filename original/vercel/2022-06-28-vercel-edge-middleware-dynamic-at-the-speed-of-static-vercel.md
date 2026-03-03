---
title: "Vercel Edge Middleware: Dynamic at the speed of static - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-edge-middleware-dynamic-at-the-speed-of-static"
date: "2022-06-28"
scraped_at: "2026-03-02T10:01:40.784867001+00:00"
language: "en"
translated: false
description: "Execute custom logic at the moment of request, pushing personalization to the edge with exceptional performance."
---




Jun 28, 2022

High-performance compute for routing, experimentation, and more.

Since we announced Middleware last October, we’ve seen 80% month-over-month growth and over 30 billion requests routed through Edge Middleware on Vercel during public beta. Customers like Vox Media, Hackernoon, Datastax, and HashiCorp are using Edge Middleware to have complete control over routing requests in their Next.js applications.

With the release of [Next.js 12.2](https://nextjs.org/blog/next-12-2), Vercel Edge Middleware for Next.js is now generally available (GA) for all customers. Edge Middleware is also available for _all_ frameworks—now available in public beta along with a suite of other edge-first tools.

## **What is Vercel Edge Middleware?**

![Edge Middleware runs before the Edge Network Cache, for fast rewrites and redirects](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_001.jpg)![Edge Middleware runs before the Edge Network Cache, for fast rewrites and redirects](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_002.jpg)![Edge Middleware runs before the Edge Network Cache, for fast rewrites and redirects](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_003.jpg)![Edge Middleware runs before the Edge Network Cache, for fast rewrites and redirects](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_004.jpg)Edge Middleware runs before the Edge Network Cache, for fast rewrites and redirects

Edge Middleware helps developers escape lengthy configuration files to instead define routing rules like rewrites, redirects, and headers with code. When deployed to Vercel, Edge Middleware is automatically configured as a special set of Edge Functions.

Edge Middleware runs _before_ serving requests from the Edge Cache, giving it the ability to quickly route and rewrite requests to return pre-rendered pages. Some tasks that previously required a trip to the core data center or bulky client-side code can now be done at the edge, configured entirely by custom code.

## Why Edge Middleware?

While in beta, over 100,000 developers used Edge Middleware on Vercel, including almost half of our Enterprise customers. It’s clear that dynamic Edge Middleware at the speed of static is changing how we build for the Web.

> “We've been using Edge Middleware to drive experiments and personalization on our marketing surfaces. We keep our ability to customize our content workflows while keeping the performance that Next.js on Vercel gives us. We've been using Edge Middleware to drive experiments and personalization on our marketing surfaces. We keep our ability to customize our content workflows while keeping the performance that Next.js on Vercel gives us. ”
>
> ![](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_005.jpg)
>
> **Jon Eide Johnsen,** Growth Manager at Sanity.io

### Experiment **at the edge**

Customers like **SumUp** and **Sanity** use Edge Middleware to personalize content at the edge through custom experimentation—even for otherwise-static content.

Based on the incoming request, Edge Middleware is able to connect to tools like LaunchDarkly, ConfigCat, Koala, Optimizely, Split, and more to run A/B tests for the current visitor. If the visitor is part of the split test, they’ll be routed to one of the possible variants from the edge server.

![A/B testing and feature flags, directly in your code with Edge Middleware](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_006.jpg)![A/B testing and feature flags, directly in your code with Edge Middleware](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_007.jpg)![A/B testing and feature flags, directly in your code with Edge Middleware](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_008.jpg)![A/B testing and feature flags, directly in your code with Edge Middleware](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_009.jpg)A/B testing and feature flags, directly in your code with Edge Middleware

SumUp can bucket their users on the server side and rewrite the URL as necessary to show the appropriate page to each user immediately. Rather than needing to load heavy client-side libraries for personalization or deal with layout shift from validating whether the visitor was part of the current experiment or not, personalization at the edge helps you achieve great performance, and a great user experience.

Check out [this Middleware A/B test example](https://github.com/vercel/examples/tree/main/edge-functions/ab-testing-simple) to get started.

> “With Edge Middleware, we can show the control or experiment version of a page immediately instead of using third-party scripts. This results in better performance and removes the likelihood of flickering/layout shifts.” With Edge Middleware, we can show the control or experiment version of a page immediately instead of using third-party scripts. This results in better performance and removes the likelihood of flickering/layout shifts.” ”
>
> ![](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_010.jpg)
>
> **Jillian Anderson Slate,** Software Engineer at SumUp

### **Localize at the edge**

When it comes to localizing content at the edge for their globally distributed customer base, **HashiCorp** is excited about the possibilities of Edge Middleware. The Edge Middleware API contains a geolocation object, pre-populated with the visitor's country, region, and city based on their IP address. This information can then be used to conditionally show or restrict content based on your company's regulatory requirements.

![Personalize content based on geolocation headers with Edge Middleware](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_011.jpg)![Personalize content based on geolocation headers with Edge Middleware](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_012.jpg)![Personalize content based on geolocation headers with Edge Middleware](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_013.jpg)![Personalize content based on geolocation headers with Edge Middleware](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_014.jpg)Personalize content based on geolocation headers with Edge Middleware

Rather than needing to integrate and pay for an additional service to geolocate requests, Vercel includes this functionality for all customers.

Check out this [Middleware localization example](https://github.com/vercel/examples/tree/main/edge-functions/i18n) to get started.

> “The API for Middleware is pretty intuitive, it allows developers to build features without worrying too much about framework-specific details since it conforms to the same standard that browsers use for requests and responses.The API for Middleware is pretty intuitive, it allows developers to build features without worrying too much about framework-specific details since it conforms to the same standard that browsers use for requests and responses.”
>
> ![](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_015.jpg)
>
> **Dylan Staley,** Software Engineer at HashiCorp

### **Authenticate at the edge**

With Vercel Edge Middleware, authentication at the edge is fast and reliable. When a visitor makes a request to an application, Edge Middleware validates the incoming request to check if the visitor has access to view the content. If they don’t, Edge Middleware routes visitors to a page explaining that they’re not authorized, _even_ for CDN-cached content.

![Authenticate and authorize at the edge, before the initial page load](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_016.jpg)![Authenticate and authorize at the edge, before the initial page load](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_017.jpg)![Authenticate and authorize at the edge, before the initial page load](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_018.jpg)![Authenticate and authorize at the edge, before the initial page load](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_019.jpg)Authenticate and authorize at the edge, before the initial page load

Rather than having to wait to authorize on the client-side or authorize on the origin server, requests can be validated close to the customer at their nearest edge in the Vercel Edge Network.

Get started with this [Middleware authentication example](https://github.com/vercel/examples/tree/main/edge-functions/basic-auth-password).

## Agility for all frameworks

We're working to bring more capabilities to the edge, to give developers the ability to choose what's best for their application, without having to factor in tradeoffs in latency and performance.

### Edge API Routes

Often, moving API routes to the edge will drastically reduce latency and improve performance. With Edge Functions on Vercel, we're giving you the power to choose which runtime is the right one to use for your application _directly_ within your code.

```javascript
import { NextRequest } from 'next/server';



export default (req: NextRequest) => {

4  return Response.json({

5    name: `Hello, from ${req.url} I'm now an Edge Function!`,

6  });

7};



export const config = {

10  runtime: 'experimental-edge',

11};


```

Build API Routes at the edge, with the new Edge Runtime

Together with traditional Serverless Functions and static caching, Vercel is working to bring granular control over your end-user experience without leaving your code.

### **Edge for all frameworks**

We believe in the power of edge-first capabilities, and tools built with the edge in mind. We’re working with framework authors to give them tools to access the Vercel primitives, and build edge functionality into any framework.

With this release, we’re also bringing Edge Middleware and Edge Functions to the Vercel CLI, which allows you to build edge capabilities into your deployment no matter what framework you’re building with. Add a `middleware.js` or `.ts` file to your project, run `vercel dev`, and start building for the edge today.

```javascript
export default function middleware(request) {

2  // Construct the url

3  const url = new URL(request.url);



5  // Only run the middleware on the home route

6  if (url.pathname === '/') {

7    // Store the country where will be redirecting

8    let country = request.headers.get('x-vercel-ip-country').toLowerCase();



10    // Update url pathname

11    url.pathname = `/${country}.html`;



13    // Return a new redirect response

14    return Response.redirect(url);

15  }

16}
```

Edge Middleware can be added to any application, using any framework

We’re helping framework authors build dedicated support for the edge with tools to let them build native edge functionality for their users. Frameworks like Svelte, Nuxt, and Astro have already begun implementing support for Edge Middleware and Edge Functions.

## **How to get started**

For customers who have started using Edge Middleware while it was in beta, we’ve created an [upgrade guide](https://nextjs.org/docs/messages/middleware-upgrade-guide) to help migrate to the new API for Next.js 12.2. For users new to Edge Middleware, [check out our quickstart guides](https://vercel.com/docs/concepts/functions/edge-middleware/quickstart).

Every Vercel account has 1 million monthly Middleware invocations included for _free_; Pro and Enterprise teams can [pay for additional usage](https://vercel.com/pricing). While still in beta, Edge Functions will be free to use.

Whether you’re using Vercel Edge Middleware to authenticate, personalize, or localize at the edge, now you can provide tailor-made experiences at the speed of static. You have the power to serve the exact end-user experience you envisioned, every time.