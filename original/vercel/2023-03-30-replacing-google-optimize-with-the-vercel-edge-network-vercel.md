---
title: "Replacing Google Optimize with the Vercel Edge Network - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-edge-google-optimize"
date: "2023-03-30"
scraped_at: "2026-03-02T09:53:45.236129413+00:00"
language: "en"
translated: false
description: "Power your A/B testing and personalization strategy with better data and higher performance."
---




Mar 30, 2023

Power your A/B testing and personalization strategy with data and performance.

Since 2012, Google Optimize has been helping web builders experiment with their UIs to find the most effective patterns for their applications. However, Google has [announced](https://support.google.com/optimize/answer/12979939?hl=en) that Optimize will be sunset on September 30, 2023.

Vercel is ready to help you build a platform to **continue your research with higher performance, more control, and better data** by leveraging the edge.

With Vercel, you can recreate your Optimize experiments with:

- Sub-millisecond configuration read times

- No code using your Vercel dashboard

- Your existing data ingestion solution


[**Modernize your experimentation stack**\\
\\
Start your transition today.\\
\\
Let's Talk](https://vercel.com/contact/sales)

## Google Optimize performance opportunities

In the past, it's been difficult to run experiments in ways that don't harm page performance.

- **Google Optimize's scripts** must be loaded on every page where you intend to perform an experiment, adding weight to your page size and increasing load times.

- [**Cumulative Layout Shift (CLS)**](https://vercel.com/docs/concepts/analytics/web-vitals#cumulative-layout-shift-cls) hurts your application's SEO and UX—but is often introduced accidentally when running UI experiments on the client side.

- **Server-side latency** increases when your server has to make calls to Google Optimize to figure out which experiments are currently being ran.


Instead, you can introduce [Vercel Edge Config](https://vercel.com/docs/concepts/edge-network/edge-config) and [Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware) to your experimentation framework to build a high-performance testing engine.

## What is the edge?

The [Vercel Edge Network](https://vercel.com/docs/concepts/edge-network/overview) sits between the internet and your Vercel deployments acting as a Content Delivery network (CDN) with the ability to execute functions as close to your user or data as possible.

![](images/replacing-google-optimize-with-the-vercel-edge-network-vercel/img_001.jpg)![](images/replacing-google-optimize-with-the-vercel-edge-network-vercel/img_002.jpg)

This means that the building blocks of your application will always be served from the geographically closest data center in the Edge Network, ensuring that your users experience the best performance possible.

With Vercel, you have several features that you can use together to **replicate and enhance** Google Optimize's experimenting functionality: Edge Config and Edge Middleware.

## Sub-millisecond experiments with Edge Config

Vercel Edge Config is a small data store for distributing your data to the Edge Network where it can be replicated to all of your globally available regions. Your experiments data becomes available **instantly** and can be fetched in less than 10ms on average, letting you iterate on your experiments faster.

Once you've [created your Edge Config](https://vercel.com/docs/concepts/analytics/web-vitals#how-the-percentages-are-calculated), you can fetch its data in [Serverless Functions](https://vercel.com/docs/concepts/functions/serverless-functions), [Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware), and [Edge Functions](https://vercel.com/docs/concepts/functions/edge-functions). Let's use [the Edge Config SDK](https://vercel.com/docs/concepts/edge-network/edge-config/edge-config-sdk) in an Edge Function to get the best possible performance:

middleware.ts

```tsx
import { NextResponse } from 'next/server';

import { get } from '@vercel/edge-config';



export const config = { matcher: '/welcome' };



export async function middleware() {

7  const greeting = await get('greeting');

8  return NextResponse.json(greeting);

9}




```

Edge Config SDK being used in an Edge Function.

You'll receive the JSON object that you created for your Edge Config to define experiments in your application:

```json
1{

2  // A boolean feature flag

3  "winterSale": true,

4  // An A/B test with even weight

5  "saleColor": {

6    "red": .5,

7    "green": .5

8  },

9  // A multi-variate, weighted experiment

10  "buttonColor": {

11    "red": .2,

12    "green": .3,

13    "blue": .5

14  }

15}
```

An Edge Config payload with a few experiments.

You can then use this payload in your experimentation logic to create a powerful platform for your testing needs.

## Eliminating Cumulative Layout Shift

Embracing the edge also lets us significantly reduce [Cumulative Layout Shift (CLS)](https://vercel.com/docs/concepts/analytics/web-vitals#cumulative-layout-shift-cls) by making sure that we serve statically rendered content at the speed of dynamic. Using primitives from Next.js and Vercel

With [Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware), you can read your Edge Config to serve the correct variant of your page instantly rather than computing the variant on the client after the page's initial load. Speedway Motors cut their CLS by 50% using this strategy as shown by [Vercel Analytics](https://vercel.com/docs/concepts/analytics/web-vitals).

![Cumulative Layout Shift for Speedway Motors was reduced by 50%.](images/replacing-google-optimize-with-the-vercel-edge-network-vercel/img_003.jpg)Cumulative Layout Shift for Speedway Motors was reduced by 50%.

## Track results

To analyze how your experiment is doing, you can leverage your current data solution of choice, passing in the context of your experiment as properties of your data.

CheckoutButton.tsx

```tsx
import { saveData } from'@your-data-provider/sdk';



export const CheckoutButton = () => {



5  useEffect(() => {

6    // Track how many times button was rendered

7    // and which experiments were active

8    saveData("Checkout button impression", {

9      isWinterSale: true,

10      saleColor: "red",

11      buttonColor: "blue"

12    })

13  }, [])







17  const handleClick = () => {

18    // Track when a user clicks the button

19    // and which experiments were active

20    saveData("Checkout button click", {

21      isWinterSale: true,

22      saleColor: "red",

23      buttonColor: "blue"

24    })



26    // Your checkout logic

27    console.log("Check out!")

28  }



30  return (

31    <button onClick={() => handleClick()}>

32      Checkout

33    </button>

34  )

35}
```

In the future, we're looking forward to adding more features to track your experiments.

## Experiment faster by default

We want to help you replace your experimentsand **make them even better.**

By taking your experiments to the edge, the tests that you were running with Google Optimize can be incrementally migrated to improve your page performance while still collecting the valuable experimentation data that drives your business.

[**Talk to a migration expert**\\
\\
Start building a cleaner enterprise-grade stack.\\
\\
Contact Sales](https://vercel.com/contact/sales)

Vercel.com landing page

### Personalization at the edge with Builder.io

Blog post

Jan 13, 2023

### Sanity balances experimentation and performance with Vercel Edge Middleware

![](images/replacing-google-optimize-with-the-vercel-edge-network-vercel/img_004.jpg)

Grace Madlinger