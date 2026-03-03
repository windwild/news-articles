---
title: "Deploy Remix without limits on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-remix-integration-with-edge-functions-support"
date: "2023-03-22"
scraped_at: "2026-03-02T09:53:57.751111858+00:00"
language: "en"
translated: false
description: "Vercel now has advanced Remix support, including SSR streaming with Edge Functions and multi-runtime support."
---




Mar 22, 2023

Deploy and scale Remix apps of any size and complexity.

We are excited to announce our **advanced Remix integration**, including support for:

- **Streaming SSR:** Dynamically stream content with both Node.js and Edge runtimes

- **API Routes:** Easily build your serverless API with Remix and a route `loader`

- **Advanced Caching:** Use powerful cache headers like `stale-while-revalidate`

- **Data Mutations:** Run `actions` inside Serverless or Edge Functions


## Remixing Adapters

[Remix](https://remix.run/) is a server-rendered React framework with a focus on Web fundamentals. Since the Remix request handler is built on the [Web Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API), it can be _adapted_ to work with any deployment provider.

With the new advanced Remix integration for Vercel (`@vercel/remix`), no adapter is required to get started. Vercel now supports the most lightweight, powerful Remix integration, including no `server.js` file or custom `vercel.json` configuration needed.

This integration has been designed for use in our serverless environment, including support for both the Node.js runtime (Serverless Functions) and the Edge runtime (Edge Functions).

We've abstracted away runtime-specific needs, like how to handle cookies or streaming in different environments, and made it easily consumable. To take advantage of this, instances of `@remix-run/node` can be replaced with `@vercel/remix`.

We are collaborating with the Remix team to [contribute changes back upstream](https://github.com/remix-run/remix/pulls/TooTallNate) and help make the Remix build outputs more modular.

## Server-Rendering with Edge Functions

Until today, deploying Remix applications meant choosing between **two different runtimes for the entire application**: choosing all Node.js, or all Web/Edge-oriented runtimes.

With Vercel's advanced Remix support, applications can now choose their runtime on a per-route basis. This means you get the best parts of both Node.js and Web APIs – all in one application on one platform.

For example, by adding one line of code to a route in `app/routes`, you can change the rendering runtime to use Edge Functions:

app/routes/edge.tsx

```tsx
import { json } from '@vercel/remix';



export const config = { runtime: "edge" };



5// This `loader` now runs as an Edge Function

export async function loader({ request }) {

7  // You have access to the incoming request headers

8  // including powerful geolocation headers added by Vercel

9  // e.g. request.headers.get('x-vercel-ip-city')



11  return json({ ... })​;

12}
```

You can now server-render routes using Vercel Edge Functions

## Advanced Caching

Vercel supports caching `loader` responses using our Edge Network Cache by providing `cache-control` headers to a given route. This includes support for newer [caching headers](https://vercel.com/docs/concepts/edge-network/caching) like `stale-while-revalidate` and `stale-if-error`.

For example, the following `headers` tell Vercel:

- If a request is repeated within the next second, the previously cached value is still fresh.

- If the request is repeated between 1 and 60 seconds later, the cached value will be marked as stale but still shown.

- In the background, a revalidation will be made to populate the cache with a fresh value from the `loader`.


```jsx
export function headers() {

2  return {

3    "Cache-Control": "s-maxage=1, stale-while-revalidate=59",

4  };

5}
```

Adding caching headers can help improve your Remix application SSR performance

You can add further resiliency using the `stale-if-error` header. This tells the Vercel Edge Cache to reuse a stale response if the `loader` produces an error. For example, if you are trying to fetch data from a database or CMS and there’s a period of downtime, your site would _not_ go down when the `loader` throws an error.

```javascript
export function headers() {

2  return {

3    "Cache-Control": "s-max-age=2592000, stale-while-revalidate=86400, stale-if-error=604800",

4  };

5}
```

Easily make your Remix application resilient to transient downtime in your backend or database

This `cache-control` value uses a `max-age` value of 30 days, a `stale-if-revalidate` value of 1 day, and a `stale-if-error` value of 7 days.

[Jenna Smith](https://twitter.com/jjenzz) has created a [fantastic package](https://github.com/jjenzz/pretty-cache-header) to make working with `cache-control` values easier called `pretty-cache-header`. For example, the previous example would become:

```javascript
import { cacheHeader } from 'pretty-cache-header';



export function headers() {

4  return {

5    "Cache-Control": cacheHeader({

6      sMaxAge: '30days',

7      staleWhileRevalidate: '1day',

8      staleIfError: '7days'

9    })

10  };

11}
```

Easily work with cache-control strings using this community package

## Streaming SSR on Vercel

Vercel's Remix integration has support for streaming SSR, including usage with both Edge and Node.js runtimes.

By default, the Vercel integration will automatically add `app/entry.server.tsx`, if not defined, which is configured for streaming. Existing Remix projects can also adopt the following entry file to stream isomorphically:

app/entry.server.tsx

```tsx
import { handleRequest } from '@vercel/remix';

import { RemixServer } from '@remix-run/react';

import type { EntryContext } from '@vercel/remix';



export default function (

6  request: Request,

7  responseStatusCode: number,

8  responseHeaders: Headers,

9  remixContext: EntryContext

10) {

11  const remixServer = <RemixServer context={remixContext} url={request.url} />;

12  return handleRequest(

13    request,

14    responseStatusCode,

15    responseHeaders,

16    remixServer

17  );

18}
```

Isomorphic support for streaming in both Node.js and Edge runtimes.

Powerful Remix features like `defer()` and `<Await>`, built on top of React 18 and `Suspense`, are now supported in both runtimes. For example, [in our demo](https://remix-on-the-edge.vercel.app/), we're able to simulate a throttled network by delaying our `Promise` by one second. Then, we can use the deferred result inside our React component.

```javascript
import { Suspense } from 'react';

import { Await, useLoaderData } from '@remix-run/react';



export async function loader({ request }) {

5  const version = process.versions.node;



7  return defer({

8    version: sleep(version, 1000),

9  });

10}



function sleep(val, ms) {

13  return new Promise((resolve) => setTimeout(() => resolve(val), ms));

14}



export default function App() {

17  const { version } = useLoaderData();



19  return (

20    <Suspense fallback={'Loading…'}>

21      <Await resolve={version}>

22        {(version) => <strong>{version}</strong>}

23      </Await>

24    </Suspense>

25  );

26}
```

To simulate slow network speeds, we can delay the promise to retrieve the Node.js version.

With Vercel, your Remix application is fast globally. With a cache `MISS`, we frequently see under 100ms latency for a dynamic server-rendered page.

## Try Remix on Vercel today

Remix on Vercel, now with our powerful integration containing Edge rendering support, is truly dynamic at the speed of static. With [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure), your Remix application automatically takes advantage of the best infrastructure primitives.

We're continuing to invest in further improvements to Remix on Vercel and we'd love to hear your feedback on what you want to see.

Twitter post

### Deploying @remix\_run to @vercel is now zero config thanks to collaborative efforts. Remix + Vercel = 🖤

![Kent C. Dodds's avatar](images/deploy-remix-without-limits-on-vercel-vercel/img_001.jpg)Kent C. Dodds@kentcdodds

Vercel Template

Deploy this template

### A new Remix app — the result of running \`npx create-remix\`.

Remix Boilerplate