---
title: "Improved Node.js compatibility for Edge Middleware and Edge Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/improved-node-js-compatibility-for-edge-middleware-and-edge-functions"
date: "2023-04-03"
scraped_at: "2026-03-02T09:53:48.664776212+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Apr 3, 2023

![](images/improved-node_js-compatibility-for-edge-middleware-and-edge-functions-vercel/img_001.jpg)

Vercel [Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware) and [Edge Functions](https://vercel.com/docs/concepts/functions/edge-functions/quickstart) now support more Node.js modules. You may want to make use of these modules directly, but many of these low-level [APIs](https://vercel.com/docs/concepts/functions/edge-functions/edge-runtime) are pieces of core functionality that other modules depend on. Adding support for these APIs expands the compatibility of existing npm packages.

```javascript
export default function (request: Request) {

2  const url = new URL(request.url);

3  const message = url.searchParams.get("message") ?? '';

4  return Response.json({

5    decoded: Buffer.from(message, "base64").toString(),

6    message,

7  });

8}



export const config = {

11  runtime: "edge",

12};
```

Edge Function using Buffer global

The following APIs are now supported:

- **AsyncLocalStorage:** Support for maintaining data for an invocation between different asynchronous execution contexts, which allows you to pass state to the context even when the function is hot and module context is preserved.

- **EventEmitter:** A flexibleAPI to build event-driven systems that serves as a core building block for communication between libraries that control I/O and listeners that process data when events occur.

- **Buffer:** The most common way of handling binary data in Node.js, available globally or importable from `buffer`.

- **assert:** A set of assertion functions to validate invariants and logical rules that are very useful to explicitly test assumptions in your code path that need to run in Edge Functions.

- **util.promisify** and **util.callbackify:** A helper function to convert a callback-style function signature into one that returns a `Promise`, and a helper function to convert a function that returns a `Promise` into one that accepts a callback.

- **util.types:** A set of functions to validate that objects are of a given type.


You can take advantage of these additional APIs in Edge Middleware and Edge Functions with your next deployment. To deploy Edge Functions on Vercel you can get started with [any framework](https://vercel.com/docs/concepts/functions/edge-functions/quickstart) or one of our [templates](https://vercel.com/templates/edge-functions).