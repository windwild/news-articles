---
title: "Transform rules are now available in vercel.json - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/transform-rules-are-now-available-in-vercel-json"
date: "2025-07-22"
scraped_at: "2026-03-02T09:31:12.176441751+00:00"
language: "en"
translated: false
description: "Transform rules allow you to modify request headers, response headers, and request query parameters through the vercel.json."
---




Jul 22, 2025

You can now define transform rules in [`vercel.json`](https://vercel.com/docs/project-configuration) to modify HTTP request and response headers or query parameters, without changing application code.

Unlimited transform rules are available for all customers, and let you:

- Set, append, or delete request headers, response headers, and query parameters

- Use conditional logic to apply changes based on request metadata

- Match by equality, inequality, prefixes, suffixes, inclusion in string arrays, or numeric comparisons for fine-grained control


Explore the [interactive transform rules playground](https://transforms-demo.vercel.app/) to see how this feature works.

This expands the flexibility of Vercel's CDN, which already supports routing behavior like redirects and rewrites to external origins.

For example:

vercel.json

```json
1{

2  "$schema": "https://openapi.vercel.sh/vercel.json",

3  "routes": [\
\
4    {\
\
5      "src": "/(.*)",\
\
6      "dest": "https://my-secure-proxied-dashboard.com/$1"\
\
7      "transforms": [\
\
8        {\
\
9          "type": "request.headers",\
\
10          "op": "set",\
\
11          "target": {\
\
12            "key": "x-using-vercel-cdn"\
\
13          },\
\
14          "args": "secret-value"\
\
15        }\
\
16      ]\
\
17    }\
\
18  ]

19}
```

Refer to the [transform rules documentation](https://vercel.com/docs/project-configuration#transform-object-definition) for detailed examples.