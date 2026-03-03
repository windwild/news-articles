---
title: " Vercel Sandbox increases concurrency and port limits - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-sandbox-increases-concurrency-and-port-limits"
date: "2025-08-18"
scraped_at: "2026-03-02T09:29:49.271087465+00:00"
language: "en"
translated: false
description: "Run up to 2000 sandboxes at the same time. Sandbox also now supports listening on up to 4 different ports"
---




Aug 18, 2025

Pro and Enterprise teams can now run up to 2,000 [Vercel Sandboxes](https://vercel.com/docs/vercel-sandbox) concurrently (up from 150), with each now able to expose up to 4 ports for external access.

This enables larger traffic spikes for workloads like untrusted code execution, batch jobs, and automated testing, as well as more complex applications with multiple services or protocols running side-by-side.

```tsx
import { Sandbox } from '@vercel/sandbox';



const sandbox = await Sandbox.create({

4  ports: [3000, 3001, 3002, 3003]

5});



const urlA = sandbox.domain(3000);



console.log(sandbox.routes);



11// A sample of what the above console.log would return

12// [\
\
13//   {\
\
14//     url: 'https://sb-p0oybyhzzl2u.vercel.run',\
\
15//     subdomain: 'sb-p0oybyhzzl2u',\
\
16//     port: 3000\
\
17//   },\
\
18//   {\
\
19//     url: 'https://sb-3erkpotk6i6h.vercel.run',\
\
20//     subdomain: 'sb-3erkpotk6i6h',\
\
21//     port: 3001\
\
22//   },\
\
23//   ...\
\
24// ]
```

If you need a higher amount of concurrent sandboxes, you can [contact our sales team](https://vercel.com/contact/sales) to explore higher limits for your projects.

Learn more in the [Vercel Sandbox docs](https://vercel.com/docs/vercel-sandbox).