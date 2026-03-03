---
title: "How to run A/B tests with Next.js and Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/ab-testing-with-nextjs-and-vercel"
date: "2022-09-09"
scraped_at: "2026-03-02T10:00:43.940552523+00:00"
language: "en"
translated: false
description: "Learn how to run A/B tests with Next.js and Vercel Edge Middleware."
---




Sep 9, 2022

Running A/B tests is hard.

We all know how important it is for our business–it helps us understand how users are interacting with our products in the real world.

However, a lot of the A/B testing solutions are done on the client side, which introduces [layout shift](https://vercel.com/blog/core-web-vitals#cumulative-layout-shift) as variants are dynamically injected after the initial page load. This negatively impacts your websites performance and creates a subpar user experience.

To get the best of both worlds, we built [Edge Middleware](https://vercel.com/features/edge-functions): code that runs _before_ serving requests from the edge cache. This enables developers to perform rewrites at the edge to show different variants of the same page to different users.

Today, we'll take a look at a real-world example of how we used Edge Middleware to A/B test our new Templates page.

## Redesigning the Template Marketplace

Earlier this year, we kickstarted the redesign of our [Templates page](https://vercel.com/templates).

Our old Templates page had a limited scope that focused mainly on the different [frameworks](https://github.com/vercel/vercel/tree/main/examples) that were supported on Vercel:

![Old version: limited selection of templates that focused mainly on framework starters.](images/how-to-run-a_b-tests-with-next_js-and-vercel-vercel/img_001.jpg)![Old version: limited selection of templates that focused mainly on framework starters.](images/how-to-run-a_b-tests-with-next_js-and-vercel-vercel/img_002.jpg)Old version: limited selection of templates that focused mainly on framework starters.

For the new version, we wanted to build a marketplace to showcase all the different types of applications that can be built on Vercel – blogs, e-commerce storefronts _,_ etc.

We also improved search to allow for partial matching of search terms and added category filters to make discovering new templates much easier:

![New version: wider selection of templates with fuzzy search & filters.](images/how-to-run-a_b-tests-with-next_js-and-vercel-vercel/img_003.jpg)![New version: wider selection of templates with fuzzy search & filters.](images/how-to-run-a_b-tests-with-next_js-and-vercel-vercel/img_004.jpg)New version: wider selection of templates with fuzzy search & filters.

Since this was a major change of one of our most popular pages, we decided to break down the launch into multiple release phases:

1. **Early Access**: Only 20% of visitors to `/templates` will see the new variant.

2. **Public Beta**: An equal 50:50 split between the new and old variant.

3. **General Availability**: Public launch–everyone gets the new variant.


![We used Vercel's Edge Middleware to stagger our launch into 3 phases.](images/how-to-run-a_b-tests-with-next_js-and-vercel-vercel/img_005.jpg)![We used Vercel's Edge Middleware to stagger our launch into 3 phases.](images/how-to-run-a_b-tests-with-next_js-and-vercel-vercel/img_006.jpg)We used Vercel's Edge Middleware to stagger our launch into 3 phases.

We leveraged [Edge Middleware](https://vercel.com/blog/vercel-edge-middleware-dynamic-at-the-speed-of-static) to perform the A/B test at the edge, which allowed us to gather insightful user feedback without sacrificing performance.

## Catch-all Routes & On-demand Revalidation

Since we were using Next.js, we decided to create the new templates marketplace using the following [optional catch-all route](https://nextjs.org/docs/routing/dynamic-routes#optional-catch-all-routes): `/templates/[[...slug]].tsx`.

This allowed us to programmatically generate new static pages when new templates are added using [On-Demand Incremental Static Regeneration (ISR)](https://nextjs.org/docs/basic-features/data-fetching/incremental-static-regeneration#on-demand-revalidation) and navigate between them using [shallow-routing](https://nextjs.org/docs/routing/shallow-routing).

Here are some examples:

- [/templates/next.js/nextjs-boilerplate](https://vercel.com/templates/next.js/nextjs-boilerplate): Next.js boilerplate template

- [/templates/svelte/sveltekit-boilerplate](https://vercel.com/templates/svelte/sveltekit-boilerplate): SvelteKit boilerplate template


We also generated dynamic landing pages for each filter option to capture long-tail SEO traffic:

- [/templates/next.js](https://vercel.com/templates/next.js): [Next.js](https://nextjs.org/) templates

- [/templates/blog](https://vercel.com/templates/blog): Blog templates

- [/templates/tailwind](https://vercel.com/templates/tailwind): Templates that use [Tailwind CSS](https://tailwindcss.com/)


We then moved the old templates marketplace to the `/templates-old.tsx` route.

## Experimenting at the Edge

To perform the A/B test, we created a `middleware.ts` file with the following code:

middleware.ts

```javascript
import { type NextRequest, NextResponse } from 'next/server';



3// make sure the middleware only runs when

4// the requested url starts with `/templates`

export const config = {

6  matcher: ['/templates(.*)'],

7};



const THRESHOLD = 0.2; // initial threshold for the new variant (20%)

const COOKIE_NAME = 'tm_var'; // name of the cookie to store the variant



export function middleware(req: NextRequest) {

13  // get the variant from the cookie

14  // if not found, randomly set a variant based on threshold

15  const variant =

16    req.cookies.get(COOKIE_NAME) || (Math.random() < THRESHOLD ? 'new' : 'old');



18  const url = req.nextUrl.clone();



20  // if it's the old variant, rewrite to the old templates marketplace

21  if (variant === 'old') {

22    url.pathname = '/templates-old';

23  }



25  const res = NextResponse.rewrite(url);



27  // set the variant in the cookie if not already set

28  if (!req.cookies.get(COOKIE_NAME)) {

29    res.cookies.set(COOKIE_NAME, variant);

30  }

31  return res;

32}
```

Middleware code to perform the A/B test at the edge.

Here's a step by step of what the middleware does:

1. Tags each new visitor to the `/templates` page with either the `old` or `new` variant based on the current threshold (`0.2` for the first stage)

2. If the user is part of the old variant, performs a rewrite to the `/templates-old.tsx` route

3. Saves the user's variant in the `tm_var` cookie to ensure the user gets served the same version in subsequent visits


## Avoiding layout shift with Edge Middleware

As we developed the new templates page, we ran into an interesting problem–data fetching had to be done on the client side for three reasons:

1. We were using query parameters to preserve the filter state

2. The pages were generated statically

3. You can't read query parameters inside `getStaticProps`


To avoid layout shift, we decided to use skeleton loaders to buffer the loading state before showing the templates that match the configured filters.

For instance, if you go to [vercel.com/templates?framework=svelte](https://vercel.com/templates?framework=svelte), you first receive a set of skeleton loaders while the data is fetched on the client side, and then the list of Svelte templates:

![](images/how-to-run-a_b-tests-with-next_js-and-vercel-vercel/img_007.jpg)![](images/how-to-run-a_b-tests-with-next_js-and-vercel-vercel/img_008.jpg)

However, for the dynamic landing pages for each filter option (e.g. [vercel.com/templates/svelte](https://vercel.com/templates/svelte)), we wanted to avoid skeleton loaders since we already know the set of templates that match the given filter at build time.

To get the best of both worlds, we used Edge Middleware. Since Edge Middleware is [executed _before_ a request is processed on a site](https://vercel.com/docs/concepts/functions/edge-middleware#what-is-edge-middleware), we are able to detect if there are any query parameters present right when the user requests the page.

Then, if there are query parameters present, we perform a rewrite to `/templates/skeleton`, which is a special route that shows a skeleton loader.

Here's the middleware code from earlier, with the addition of this logic:

middleware.ts

```javascript
import { type NextRequest, NextResponse } from 'next/server';



3// make sure the middleware only runs when

4// the requested url starts with `/templates`

export const config = {

6  matcher: ['/templates(.*)'],

7};



const THRESHOLD = 0.2; // initial threshold for the new variant (20%)

const COOKIE_NAME = 'tm_var'; // name of the cookie to store the variant



export function middleware(req: NextRequest) {

13  // get the variant from the cookie

14  // if not found, randomly set a variant based on threshold

15  const variant =

16    req.cookies.get(COOKIE_NAME) || (Math.random() < THRESHOLD ? 'new' : 'old');



18  const url = req.nextUrl.clone();



20  // if it's the old variant, rewrite to the old templates marketplace

21  if (variant === 'old') {

22    url.pathname = '/templates-old';

23  } else {

24    // for the new variant, we need to perform a rewrite to /template/skeleton

25    // if there are query paramters in the request URL

26    const hasQueryParams = req.nextUrl.search.length > 0;



28    if (hasQueryParams) {

29      url.pathname = `/templates/skeleton`;

30    }

31  }



33  const res = NextResponse.rewrite(url);



35  // set the variant in the cookie if not already set

36  if (!req.cookies.get(COOKIE_NAME)) {

37    res.cookies.set(COOKIE_NAME, variant);

38  }

39  return res;

40}
```

Middleware code to perform an edge rewrite to avoid layout shift.

Then, on the client side, we detect when the data is finished fetching with SWR and render the final list of cards:

templates/\[\[...slug\]\].tsx

```javascript
import useSWR from "swr"

import { useRouter } from "next/router"

import { Card, PlaceholderCard, CardProps } from '@/components/cards'



export default function Templates({ skeleton } : { skeleton: boolean }) {

6  const router = useRouter()

7  const { data } = useSWR<CardProps[]>("/api/templates")



9  // if skeleton is true and the router is still loading, show a skeleton

10  if (!data || (skeleton && !router.isReady)) {

11    return (

12      <div>

13      	{[...Array(6).keys()].map((i: number) => (

14        	<PlaceholderCard key={i}/>

15        ))}

16      </div>

17		)

18  }



20  return (

21    <div>

22    	{data.map((d: CardProps, i) => (

23       <Card key={i} data={d} />

24       ))}

25    </div>

26  )

27}



export function getStaticProps(context) {

30  const skeleton = context.params?.slug?.includes('skeleton')

31  return {

32    props: {

33      skeleton,

34    },

35  }

36}
```

Simplified version of the code that shows how we use SWR and middleware to conditionally render loader skeletons on the client side if there are query parameters present in the request URL.

## Collecting data & iterating

Throughout our **Early Access** and **Public Beta** phases, we collected a series of data points that helped us understand how our new Templates Marketplace was performing in the real world.

### Tracking conversion rates with Heap

We used [Heap](https://heap.io/) to track our conversion rates: how likely is a user to successfully deploy a template after seeing it on the new vs. old Templates pages.

Based on the data from Heap, we were able to make some tweaks to our implementation to increase conversion rates by 16% with the new variant.

### Tracking search & filter usage Stats with Algolia

Algolia's [Search Without Results](https://www.algolia.com/doc/guides/getting-analytics/search-analytics/understand-reports/#searches-without-results) feature was also instrumental for us to understand which templates users were interested in. Based on the data, we were getting >30 searches a week for WordPress templates that yielded no results.

This prompted us to add a few WordPress templates before releasing the Templates Marketplace to **General Availability**.

![](images/how-to-run-a_b-tests-with-next_js-and-vercel-vercel/img_009.jpg)

## Edge Middleware: Run A/B tests without the tradeoffs

[Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware) allowed us to streamline the release of our new Templates Marketplace by putting the new version behind a feature flag until it's fully tested and optimized.

Check out our [Templates Marketplace](https://vercel.com/templates) today to jumpstart your app development process with our pre-built solutions.