---
title: "Vercel Functions now support graceful shutdown - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-functions-now-support-graceful-shutdown"
date: "2025-09-08"
scraped_at: "2026-03-02T09:28:57.362986929+00:00"
language: "en"
translated: false
description: "Vercel Functions running on the Node.js or Python runtimes now support graceful shutdown, allowing to run cleanup tasks for up to 500 milliseconds just before shutting down."
---




Sep 8, 2025

Vercel Functions running on Node.js and Python runtimes now support graceful shutdown, giving you up to 500 milliseconds to run cleanup tasks before termination.

When a function is terminated, such as during scale-down, the runtime receives a `SIGTERM` signal. You can now use this signal to run cleanup tasks like closing database connections or flushing external logs.

```javascript
process.on('SIGTERM', () => {

2  console.log('Cleanup goes here');

3});



export default {

6  fetch() {

7    return new Response('Hi from a Vercel Function!');

8  }

9}
```

Learn more about the [SIGTERM signal](https://vercel.com/docs/functions/functions-api-reference#sigterm-signal).