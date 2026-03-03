---
title: "How to build zero-CLS A/B tests with Next.js and Vercel Edge Config - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config"
date: "2023-03-23"
scraped_at: "2026-03-02T09:53:51.218920628+00:00"
language: "en"
translated: false
description: "Create a powerful, statically-rendered experimentation engine at scale."
---




Mar 23, 2023

A recipe for powerful, statically-rendered experiments at scale.

A/B testing and experiments help you build a culture of growth. Instead of guessing what experiences will work best for your users, you can **build, iterate, and adapt** **with data-driven insights** to produce the most effective UI possible.

In this article, you'll learn how we built a high-performance experimentation engine for vercel.com using [Next.js](https://nextjs.org/?utm_source=vercel_site&utm_medium=blog&utm_campaign=edge_config_nextjs_experimentation_engine) and [Vercel Edge Config](https://vercel.com/docs/concepts/edge-network/edge-config), allowing our developers to create experiments that load instantly with zero [Cumulative Layout Shift (CLS)](https://vercel.com/docs/concepts/analytics/web-vitals#cumulative-layout-shift-cls) and a great developer experience.

[**Want to build better experiments?**\\
\\
We're happy to help.\\
\\
Get in Touch](https://vercel.com/contact/sales)

## Great experiments matter

Experiments are a way to test how distinct versions of your application perform with your users. With one deployment, you can present different experiences for different users.

While experiments can be incredibly insightful, it's historically been difficult to run great tests on the Web:

- **Client-side rendering (CSR)** your experiments will evaluate which version of your app a user will see _after_ the page has loaded. This results in poor UX since your users will have to wait for loaders while the experiment is evaluated and eventually rendered, creating layout shift.

- **Server-side rendering (SSR)** can slow page response times as experiments are evaluated on demand. Users have to wait for the experiments along a similar timeline as CSR—but stare at a blank page until all of the work is done to build and serve the page.


These strategies end up with a poor user experience and **give you bad data** about your experiments. Because you’re making your load times worse, you are negatively impacting what _should have been_ your control group.

[Milliseconds make millions](https://web.dev/milliseconds-make-millions), so using the right rendering strategies makes a big difference. Slow load times give you inaccurate results and false impressions about your experiments.

![Slow load times have direct impact on user behavior.¹](images/how-to-build-zero-cls-a_b-tests-with-next_js-and-vercel-edge-config-vercel/img_001.jpg)![Slow load times have direct impact on user behavior.¹](images/how-to-build-zero-cls-a_b-tests-with-next_js-and-vercel-edge-config-vercel/img_002.jpg)Slow load times have direct impact on user behavior.¹

## Defining the experiment engine

For our engineers who aren’t working with experimentation every day, we wanted a simple, standardized path to effective, high-performance experiments. Our requirements were:

- Zero impact on end-users

- Automatically keep users in their "experiment bucket" using our feature flag vendor

- Send events to our data warehouse when users have given consent

- Excellent "out-of-the-box" developer experience


Using the right tools, we knew we could improve both our internal developer experience _and_ end-user experience.

## Leveraging Edge Config for read speed

[Vercel Edge Config](https://vercel.com/docs/concepts/edge-network/edge-config) is a JSON data store that allows you to read dynamic data as geographically close to your users as possible. Edge Config reads complete within 15ms [at P99](https://vercel.com/docs/concepts/analytics/web-vitals#how-the-percentages-are-calculated) or as low as 0ms in some scenarios.

middleware.ts

```tsx
import { NextResponse, NextRequest } from 'next/server'

import { get } from '@vercel/edge-config'



export async function middleware(request: NextRequest) {

5  if (await get("showNewDashboard")) {

6    return NextResponse.rewrite(new URL("/new-dashboard", request.url))

7  }

8}
```

Using an Edge Config to rewrite to a new dashboard design.

We're leveraging [Statsig's Edge Config Integration](https://vercel.com/integrations/statsig) to automatically populate the Edge Config connected to our project with the experiment’s evaluation rules. We can then fetch our experiments in our code easily.

getExperiments.ts

```tsx
import { createClient } from '@vercel/edge-config'

import { EdgeConfigDataAdapter } from 'statsig-node-vercel'

import Statsig from 'statsig-node'



async function initializeStatsig() {

6  const edgeConfigClient = createClient(process.env.EDGE_CONFIG)

7  const dataAdapter = new EdgeConfigDataAdapter({

8    edgeConfigClient: edgeConfigClient,

9    edgeConfigItemKey: process.env.STATSIG_EDGE_CONFIG_ITEM_KEY,

10  })



12  await Statsig.initialize(process.env.STATSIG_SERVER_KEY, { dataAdapter })

13}



async function getExperiment(userId, experimentName) {

16  await initializeStatsig()

17  return Statsig.getExperiment({ userId }, experimentName)

18}
```

Populating our runtime with our experimentation configuration.

## Using Next.js for high-performance, flexible experiences

As a high-level overview, we are going to:

- [Create type safety for our code](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config#creating-experiments-in-code)

- [Pre-render our experiments on the server](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config#prerendering-experiment-variations)

- [Serve the correct page variations to our users using their cookies](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config#serving-experiments-to-users)

- [Automatically capture events with a React Context](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config#measuring-success)


### Creating experiments in code

To create the most predictable developer experience for ourselves and our teammates, we created a typesafe, single source of truth for our monorepo. Each experiment defines possible values for each parameter along with the paths where the experiment is active. The first value in each array is the default value for a parameter.

experiments.ts

```tsx
export const EXPERIMENTS = {

2  pricing_redesign: {

3    params: {

4      enabled: [false, true],

5      bgGradientFactor: [1, 42]

6    },

7    paths: ['/pricing']

8  },

9  skip_button: {

10    params: {

11      skip: [false, true]

12    },

13    // A client-side experiment won't need path values

14    paths: []

15  }

16} as const
```

Creating static types for our source code.

### Pre-rendering experiment variations

[Dynamic routes](https://nextjs.org/docs/routing/dynamic-routes?utm_source=vercel_site&utm_medium=blog&utm_campaign=edge_config_nextjs_experimentation_engine) allow Next.js users to create page templates that change what they render using parameters in the route. For our purposes, we encode the experiment variations into the page's pathname. We’ll supply that data through Next.js’ powerful data fetching APIs: `getStaticProps` and `getStaticPaths`.

The engine we built offers a wrapped version of `getStaticPaths` which builds the paths for all of the variations of the page. Each path is an encoded version of the hash of the experiment values for that particular path, meaning we store experiment values in the URL itself.

Each experiment parameter has multiple options because a page can have many experiments. [All possible combinations](https://en.wikipedia.org/wiki/Cartesian_product) of experiment values for each path could create long build times if a page has many experiments with many variations. To solve this, we calculate the first `n` combinations with a [generator function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/function*) and only pre-render those variations, defaulting to 100 page variations per path.

![Dynamic routes using encoded experiment values for their parameter slugs.](images/how-to-build-zero-cls-a_b-tests-with-next_js-and-vercel-edge-config-vercel/img_003.jpg)![Dynamic routes using encoded experiment values for their parameter slugs.](images/how-to-build-zero-cls-a_b-tests-with-next_js-and-vercel-edge-config-vercel/img_004.jpg)Dynamic routes using encoded experiment values for their parameter slugs.

Paths not generated at build time fall back to Next.js' Incremental Static Generation or [Incremental Static Regeneration](https://nextjs.org/docs/basic-features/data-fetching/incremental-static-regeneration#fallback-blocking?utm_source=vercel_site&utm_medium=blog&utm_campaign=edge_config_nextjs_experimentation_engine) patterns depending on if you've supplied a `revalidation` interval. Deciding how many pages you want to pre-render is a tradeoff between build time and impact of the delayed initial render for the first visitor to an incrementally static rendered page.

The engine also has a wrapper for `getStaticProps` where we decode the parameter from the URL to get the experiment values to use in our pages. We also made sure to give our wrapper the same type as `getStaticProps` so our teammates could use a familiar API.

Because these are statically generated pages, the values are available at build time. Putting together our engine's `getStaticPaths` and `getStaticProps` wrappers, our code comes out to look something like:

experiments/engine/data-fetchers.ts

```tsx
1// Your encoding implementation

import { encodeVariations, decodeVariations } from './encoders'



export function experimentGetStaticPaths(

5  path,

6  maxGeneratedPaths = 100

7) {

8  return (context) => {

9    const paths = encodeVariations(path, maxGeneratedPaths)



11    return {

12      paths,

13      fallback: 'blocking',

14    }

15  }

16}





export function experimentGetStaticProps(pageGetStaticProps) {

20  return async (context) => {

21    const { props: pageProps, revalidate } = await pageGetStaticProps(context)

22	  const encodedRoute = context.params?.experiments



24    // Read from URL or use default values

25    const experiments = decodeVariations(encodedRoute) ?? EXPERIMENT_DEFAULTS



27    return {

28      props: {

29        ...pageProps,

30        experiments

31      },

32      revalidate

33    }

34}
```

Creating data fetching utilities.

Now, when we go to implement an experiment, we can write:

pages/pricing/\[experiments\].ts

```tsx
export const getStaticPaths = experimentGetStaticPaths("/pricing")



export const getStaticProps = experimentGetStaticProps(async () => {

4  const { prices } = await fetchPricingMetadata()



6  return {

7    props: {

8      prices

9    }

10  }

11})
```

Using our engine's data fetching utilities.

### Serving experiments to users

To ensure that our users end up on the correct page variations, we leverage [rewrites in Next.js Middleware](https://nextjs.org/docs/api-reference/next/server#static-methods?utm_source=vercel_site&utm_medium=blog&utm_campaign=edge_config_nextjs_experimentation_engine).

- If a user has visited vercel.com before, the rewrite is powered by the user's existing cookie.

- If a user doesn't have a cookie, the Middleware reads from Edge Config and encodes the values, determining the route for the variation. Thanks to the speed of Edge Config, we know our user won’t have a delayed page load.


When you use a rewrite in Middleware, your user still sees `/pricing` in their browser bar even though you served `/pricing/0p0v0`, the statically pre-rendered version of the page with their experiment values.

middleware.ts

```tsx
import { NextResponse } from 'next/server'



async function getExperimentsForRequest(req) {

4  const cookie = getExperimentsCookie(req)

5  const experiments = cookie

6    ? parseExperiments(cookie)

7    : readExperimentsFromEdgeConfigAndUpdateCookie(req)



9  return experiments

10}



export async function middleware(req) {

13  const experiments = await getExperimentsForRequest(req)

14  const path = getPathForExperiment(experiments, req)



16  return NextResponse.rewrite(new URL(path, req.url))

17}



export const config = {

20  matcher: '/pricing'

21}
```

The cookie's value is the experiment parameters assigned through the [Statsig Edge Config integration](https://vercel.com/integrations/statsig) that we set up earlier. Our users will end up in "buckets" based on the values that our Statsig integration assigns them, intelligently handling which users receive which experiments.

It's possible for a client's cookie to go stale and end up out of sync with our experiment configuration. We'll get into how we keep the cookie fresh [in a moment](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config#ensuring-experiments-stay-fresh).

A user receives a page that was rendered on the server so our React components that use our engine's `useExperiment` hook will already know their values, resulting in no layout shift.

Pricing.tsx

```tsx
function Pricing({ prices }) {

2  const { enabled, bgGradientFactor } = useExperiment("pricing_redesign")



4  return (

5    <div>

6      <h1>Pricing</h1>

7      {

8        enabled ?

9          <GradientPricingTable factor={bgGradientFactor} prices={prices} />

10          : <PricingTable prices={prices} />

11      }

12      </div>

13    )

14}
```

Using a hook for a statically rendered experiment.

Now that we have the right UX, we need to collect, explore, and analyze data about our experiments to how they are performing.

### Measuring success

Using our typesafe helpers from before, we built a React context that holds the experiment values for the current page, automatically reporting an `EXPERIMENT_VIEWED` event to our data warehouse.

analyticsContext.ts

```tsx
export function trackExperiment(experimentName) {

2  analytics(EXPERIMENT_VIEWED, getTrackingMetadataForExperiment(experimentName))

3}



const Context = createContext()



export function ExperimentContext({

8  experiments,

9  path,

10  children

11}) {

12  useEffect(() => {

13    for (const experimentName of getExperimentsForPath(path)) {

14      trackExperiment(experimentName);

15    }

16  }, [])



18  return (

19    <Context.Provider experiments={experiments}>

20      {children}

21    </Context.Provider>

22  )

23}
```

Building a React Context to easily track analytics.

After we’ve collected enough data, we can visit our internal data visualization tools to evaluate the performance of our experiments and confidently decide what to ship next.

## Handling client-side experiments

Not every experiment will happen on the first page load so we still need to be able to handle client side experiments. For example, an experiment can be rendered in a modal or pop-in prompt.

In these cases, we use our client-side React hook since we don't have to worry about the initial loading experience.

components/PricingModal.ts

```tsx
function PricingModal() {

2  // Fully-typed `skip` from EXPERIMENTS constant under the hood

3  const { skip } = useClientSideExperiment("skip_button")



5  return (

6    <Modal>

7      <Modal.Title>Invite Teammates</Modal.Title>

8      <Modal.Description>Add members to your team.</Modal.Description>

9      <Modal.Button>Ok</Modal.Button>

10      {skip ? <Modal.Button>Skip</Modal.Button> : null}

11    </Modal>

12  )

13}
```

With this hook, we read directly from the cookie to find out what experimentation bucket our user belongs to and render the desired UI for that experiment. We won’t need server-side rendering, static generation, or routing for these experiments since the user is already interacting with our UI.

## Ensuring experiments stay fresh

It’s possible for a user to end up with a stale or outdated cookie in their browser while we update our experiments behind the scenes. To fix this, we keep cookies warm with a background fetcher that has an interval of 10 minutes.

![](images/how-to-build-zero-cls-a_b-tests-with-next_js-and-vercel-edge-config-vercel/img_005.jpg)![](images/how-to-build-zero-cls-a_b-tests-with-next_js-and-vercel-edge-config-vercel/img_006.jpg)

Because we are using an [Edge Function](https://vercel.com/docs/concepts/functions/edge-functions) combined with an [Edge Config](https://vercel.com/docs/concepts/edge-network/edge-config), we can trust that this background refresh executes lightning fast, avoiding cold starts and leveraging Edge Config's instant reads.

## Effective experiments, every time

With Next.js and Edge Config, we've built an experimentation engine where:

- Our users won’t experience Cumulate Layout Shift as a result of an experiment.

- We can run multiple page and component-level experiments per page and across pages.

- We can ship and iterate on experiments at Vercel more quickly and safely.

- We can collect high-value knowledge on what works best for our users without sacrificing page performance.


For the past few months, we’ve shipped many different zero-CLS experiments on [vercel.com](http://vercel.com/) and we’re excited to continue improving your experience with new insights.

[**Build better experiments**\\
\\
Get started today.\\
\\
Let's Talk](https://vercel.com/contact/sales)

¹ ["Milliseconds Make Millions" report, Deloitte Digital](https://www2.deloitte.com/content/dam/Deloitte/ie/Documents/Consulting/Milliseconds_Make_Millions_report.pdf)

Vercel Template

Deploy this template

### Reduce CLS and improve performance from client-loaded experiments at the edge with Statsig

Experimentation with Statsig

Blog post

Jan 13, 2023

### Sanity balances experimentation and performance with Vercel Edge Middleware

![](images/how-to-build-zero-cls-a_b-tests-with-next_js-and-vercel-edge-config-vercel/img_007.jpg)

Grace Madlinger