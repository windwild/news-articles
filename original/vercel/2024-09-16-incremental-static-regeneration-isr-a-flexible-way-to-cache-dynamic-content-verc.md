---
title: "Incremental Static Regeneration (ISR): A flexible way to cache dynamic content - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/isr-a-flexible-way-to-cache-dynamic-content"
date: "2024-09-16"
scraped_at: "2026-03-02T09:42:04.419674901+00:00"
language: "en"
translated: false
description: "Explore how Incremental Static Regeneration (ISR) enhances your caching strategy. Learn its benefits, implementation across frameworks, and real-world applications. Optimize performance with this hybr..."
---




Sep 16, 2024

Effectively using ISR across industries and frameworks.

Incremental Static Regeneration (ISR) is a caching strategy that combines the perks of multiple rendering techniques to bring users dynamic content at cached speeds.

This guide explores how ISR fits into your overall caching strategy, how it can benefit your architecture, and how to implement it effectively. We'll compare ISR to traditional caching methods and provide real-world examples to illustrate its advantages.

## Benefits of caching

Caching is a technique in web development that involves storing and reusing previously fetched or computed data. It helps improve website performance by:

- **Reducing server load:** By serving cached content, fewer requests reach the server, allowing it to handle more traffic.

- **Saving bandwidth:** Serving cached content reduces the data transferred between servers and clients, which can also decrease costs.

- **Decreasing latency:** Cached responses are typically served much faster than generating new responses, resulting in quicker page loads, more responsive applications, and better user engagement.

- **Content availability:** Cached content can remain available for end users even if providers go down.


Effective caching is key to build fast, scalable web apps.

## ISR: A modern server-side caching strategy

ISR is a hybrid cache that combines the benefits of static site generation (SSG) and server-side rendering (SSR). It allows for:

- **Cached speeds with live content:** Quickly serve edge-cached static content to users while updating data in the background. (This is known as "stale-while-revalidate" in HTTP caching.)

- **Selective regeneration:** Update specific pages without rebuilding the entire site. This can significantly reduce build times, [especially for content-heavy sites like Sonos](https://vercel.com/blog/how-sonos-amplified-their-devex).

- **On-demand invalidation:** Trigger updates for specific pages as needed, such as when new content is published.

- **Guaranteed cache durability:** Your data remains cached for the duration you specify. Only you or your team can invalidate this cache—unless it goes unaccessed for 31 days.


ISR pairs best with [hybrid rendering frameworks](https://vercel.com/blog/isr-a-flexible-way-to-cache-dynamic-content#framework-adoption), which allow you to create apps with some content prerendered (SSG) and some content served per request (SSR).

[**Too many acronyms?**\\
\\
Learn the differences between rendering strategies like SSG, SSR, CSR, ISR, and PPR—and see real-world examples of each.\\
\\
Read More](https://vercel.com/blog/how-to-choose-the-best-rendering-strategy-for-your-app)

### ISR and modern web architecture

Caching requires careful configuration to work properly. Vercel's implementation of ISR uses [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure), meaning there's no extra configuration outside your framework code.

Also, Vercel's ISR cache scales automatically with your traffic. Its asynchronous, serverless nature means it can be used without worrying about downtime. In fact, the cache can help _prevent_ downtime by [taking the load off your backend services](https://vercel.com/blog/the-resiliency-of-the-frontend-cloud#high-availability-by-default) to begin with. This can also reduce the costs of calling third-party APIs, such as AI providers.

**ISR can act as a full replacement for** [**HTTP caching**](https://developer.mozilla.org/en-US/docs/Web/HTTP/Caching) **at the edge.** Instead of thinking about how to cache your application, you can focus on which pieces of your app would benefit from caching.

A visual walkthrough of ISR.

### How ISR fits in the caching stack

Vercel enhances caching strategies with several approaches:

- **Static Assets:** [Automatically cached on Vercel's CDN](https://vercel.com/docs/edge-network/caching), persisting across deployments if unchanged.

- **ISR:** Vercel's solution for caching dynamic content not requiring real-time updates, leveraging the Edge Network for [global low latency](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud).

- **Application-level:** For specific needs like storing frequently accessed data in memory (e.g., using Redis from the [Vercel Marketplace](https://vercel.com/marketplace?category=databases)).

- **Client-side:** Recommended libraries like [SWR](https://swr.vercel.app/) optimize browser caching, minimizing network requests.


Combining these with ISR optimizes performance while maintaining up-to-date content.

[**Ready to try ISR yourself?**\\
\\
This demo of on-demand ISR in Next.js shows you the basics by revalidating displayed GitHub issues from a webhook.\\
\\
Deploy Now](https://vercel.com/templates/next.js/on-demand-incremental-static-regeneration)

### Framework adoption

Several popular frameworks currently support ISR:

- [Next.js](https://vercel.com/docs/frameworks/nextjs#incremental-static-regeneration)

- [SvelteKit](https://vercel.com/docs/frameworks/sveltekit#incremental-static-regeneration-isr)

- [Nuxt](https://vercel.com/blog/nuxt-on-vercel#static-and-isr-support-for-nuxt)

- [Astro](https://vercel.com/docs/frameworks/astro#incremental-static-regeneration)

- [Gatsby (through Deferred Static Generation)](https://vercel.com/docs/frameworks/gatsby#deferred-static-generation)

- [Remix (partial support via `Cache-Control` headers)](https://vercel.com/docs/frameworks/remix#cache-control-headers)


If you don't see ISR in your favorite framework and want it, consider creating or upvoting a GitHub issue. Framework authors can implement ISR using Vercel's [Build Output API](https://vercel.com/blog/build-your-own-web-framework).

## Real-world scenarios where ISR shines

> “We don't want to have to say to a business stakeholder, "Hey, that typo that you want fixed on the homepage? It's going to take us hours to get that out, even though everything's already approved. So, the ability to incrementally statically regenerate only certain pieces of content—particularly when you have 10,000 pages of content—is a very important driver for us when evaluating and picking out a platform.We don't want to have to say to a business stakeholder, "Hey, that typo that you want fixed on the homepage? It's going to take us hours to get that out, even though everything's already approved. So, the ability to incrementally statically regenerate only certain pieces of content—particularly when you have 10,000 pages of content—is a very important driver for us when evaluating and picking out a platform.”
>
> ![](images/incremental-static-regeneration-isr-a-flexible-way-to-cache-dynamic-content-verc/img_001.png)
>
> **Senior Software Engineer,** Johnson & Johnson

### Ecommerce

Ecommerce sites with large inventories benefit greatly from ISR. For instance, Mecum, an online retailer with millions of assets and hundreds of thousands of pages, [uses ISR to keep product information up-to-date without rebuilding the entire site](https://vercel.com/blog/managing-275-thousand-pages-and-8-million-assets-with-isr).

When product details change (e.g., price, quantity on hand), only the affected pages are regenerated and re-cached. This ensures customers always see the latest information while maintaining fast page loads.

Stripe was also able to use ISR (in combination with client-side caching and static site generation) to serve a viral Black Friday micro-site with [17 million edge requests at launch](https://vercel.com/blog/architecting-reliability-stripes-black-friday-site).

### News websites

News sites with frequently updating content are ideal candidates for ISR. News outlets like [The Washington Post use ISR](https://vercel.com/blog/washington-post-next.js-vercel-engineering-at-the-speed-of-breaking-news) to serve breaking news quickly while efficiently managing server resources.

Hydrow [uses ISR to update its blog](https://vercel.com/blog/hydrow) every time a new article is published in their headless CMS. Users and authors always see the latest content, but the site only has to request data when a post updates.

### AI-powered applications

Applications integrating AI can leverage ISR to optimize performance and costs. For example, a company using AI for product recommendations can cache the results of expensive AI computations with ISR.

The recommendations can be regenerated periodically or when the underlying data changes, ensuring users receive personalized content quickly without overloading the AI service or incurring unnecessary AI costs.

Leonardo.ai uses ISR to cache recent user-generated content, allowing visitors to see the latest content without waiting on a loading skeleton. This has also helped them [drop build times from ten minutes to two](https://vercel.com/blog/leonardo-ai-performantly-generates-4-5-million-images-daily-with-next-js-and-vercel).

## How to implement ISR

ISR uses three invalidation techniques.

### Time-based ISR

Time-based ISR regenerates pages at specified intervals. Use it when:

- On-demand regeneration would be too frequent

- Data sources lack webhook support

- Content changes follow a predictable pattern


For example, using [SvelteKit's implementation of ISR with the Vercel adapter](https://kit.svelte.dev/docs/adapter-vercel#incremental-static-regeneration), we could update a news homepage from a third-party API every 10 minutes:

src/routes/+page.server.ts

```jsx
import { error } from "@sveltejs/kit";

import type { PageServerLoad } from "./$types";



export const load: PageServerLoad = async () => {

5  try {

6    const res = await fetch("<https://api.news.com/headlines>");

7    const headlines: any = await res.json();



9    return {

10      headlines,

11      // Revalidate every 10 minutes

12      cache: { maxage: 600 },

13    };

14  } catch (err) {

15    throw error(500, "Failed to fetch headlines");

16  }

17};
```

In SvelteKit, we use a `+page.server.ts` file to handle server-side data fetching. The `load` function fetches and returns data, which will be available to the page component. The `cache` option sets the revalidation interval.

Be careful when using time-based ISR at too frequent an interval (60 seconds, for example). Although ISR can provide a needed buffer in severe traffic to help you save costs, revalidating _too_ often—writing to the cache almost as often as you're reading from it—can be cost-inefficient, and you may need to rethink your strategy.

### On-demand ISR

On-demand ISR regenerates pages in response to specific events. It's preferred to time-based because it:

- Provides the most up-to-date content

- Is more efficient, regenerating only when necessary

- Allows for immediate updates to changes


For example, using [Astro's on-demand ISR implementation](https://docs.astro.build/en/guides/integrations-guide/vercel/#isr) you can revalidate an article page when you update the corresponding content in your CMS:

First, enable ISR in your Astro `astro.config.mjs`:

astro.config.mjs

```jsx
import { defineConfig } from "astro/config";

import vercel from "@astrojs/vercel/serverless";



export default defineConfig({

5  output: "server",

6  adapter: vercel({

7    isr: {

8      // Create a secret token for revalidation

9      bypassToken: import.meta.env.VERCEL_REVALIDATE_TOKEN,

10    },

11  }),

12});
```

Then, wherever your article fetch is happening:

src/pages/posts/\[slug\].astro

```jsx
1---

2// ... your existing code ...



export const prerender = true;

5---



7{/* ... your page content ... */}
```

Now, you can trigger revalidation by sending a `GET` or `HEAD` request to the page's URL with the **`x-prerender-revalidate`** header:

```bash
curl -H "x-prerender-revalidate: <YOUR_BYPASS_TOKEN>" https://your-site.com/posts/my-article-slug
```

This will tell Vercel to revalidate the `/posts/my-article-slug` page, ensuring the next visitor sees the fresh content. You can trigger this request from a webhook in your CMS or any other part of your application.

### Tag-based ISR

Next.js supports [tag-based revalidation](https://nextjs.org/docs/app/building-your-application/data-fetching/incremental-static-regeneration#on-demand-revalidation-with-revalidatetag) for on-demand ISR. This allows you to invalidate multiple pages that share the same tag. Let's explore a real-world ecommerce example using a Server Component for a product page:

app/products/\[id\]/page.tsx

```tsx
import { revalidateTag } from "next/cache";



async function getProduct(id) {

4  // ... (fetch logic using tags: [`product-${id}`, "product-list"])

5}



export default async function ProductPage({ params: { id } }) {

8  const product = await getProduct(id);



10  async function addToCart(formData) {

11    const quantityToAdd = Number(formData.get("quantity"));

12    if (quantityToAdd > 0 && quantityToAdd <= product.quantity) {

13      await updateProductQuantity(id, product.quantity - quantityToAdd);

14      revalidateTag(`product-${id}`);

15      revalidateTag("product-list");

16      // ... (add to cart logic)

17    }

18  }



20  return (

21    <div>

22      <h1>{product.name}</h1>

23      <p>Price: ${product.price}</p>

24      {product.quantity > 0 ? (

25        <form action={addToCart}>

26          <input

27            type="number"

28            name="quantity"

29            min="1"

30            max={product.quantity}

31            defaultValue="1"

32          />

33          <button type="submit">Add to Cart</button>

34        </form>

35      ) : (

36        <p>Out of Stock</p>

37      )}

38    </div>

39  );

40}



42// Server-side function to update quantity

async function updateProductQuantity(id, newQuantity) {

44  "use server";

45  // ... (update database logic)

46}
```

This approach improves efficiency by allowing you to update related product pages simultaneously. When a product's inventory is updated:

1. The specific product page is revalidated using the `product-${id}` tag.

2. All pages listing multiple products (e.g., homepage, category pages) are revalidated using the `product-list` tag.


This ensures that inventory changes are reflected across the site for all users.

## The future of ISR

ISR has been around for a few years now, and we've made a lot of observations of how it could be improved.

One of the most significant features currently in development is [Partial Prerendering (PPR)](https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model), which allows static and dynamic content to coexist at the component level. PPR can simplify the developer experience by reducing the number of concepts and rendering modes to consider.

While [PPR is experimental](https://nextjs.org/docs/app/api-reference/next-config-js/ppr), it's an exciting step forward in building dynamic web applications.

## Takeaways

ISR is a powerful hybrid caching strategy that offers improved performance, reduced server load, and better scalability for modern web applications. By implementing ISR, you can serve static-like content with dynamic data freshness, enhancing user experience and SEO.

To get started with ISR on Vercel, check out our [ISR template](https://vercel.com/templates/next.js/on-demand-incremental-static-regeneration) for a hands-on experience.