---
title: "Node.js Vercel Functions now support fetch web handlers - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/node-js-vercel-functions-now-support-fetch-web-handlers"
date: "2025-08-19"
scraped_at: "2026-03-02T09:29:42.687160487+00:00"
language: "en"
translated: false
description: "Vercel Functions running on the Node.js runtime now support fetch web handlers to enhance interoperability across runtimes and frameworks."
---




Aug 19, 2025

Vercel Functions running on the Node.js runtime now support the `fetch` web handlers, improving interoperability across JavaScript runtimes and frameworks.

```tsx
export default {

2  fetch(request: Request) {

3    return new Response('Hello from Vercel!');

4  }

5};
```

You can still [export individual HTTP methods](https://vercel.com/docs/functions/functions-api-reference?framework=other#function-signature), if preferred.

Learn more about [fetch web handlers](https://vercel.com/docs/functions/functions-api-reference?framework=other#fetch-web-standard) [in the docs](https://vercel.com/docs/functions/functions-api-reference?framework=other#fetch-web-standard).