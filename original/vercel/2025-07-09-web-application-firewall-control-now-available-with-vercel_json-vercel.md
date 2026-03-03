---
title: "Web Application Firewall control now available with vercel.json - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/web-application-firewall-control-now-available-with-vercel-json"
date: "2025-07-09"
scraped_at: "2026-03-02T09:31:16.635427396+00:00"
language: "en"
translated: false
description: "You can now configure firewall mitigation rules through your vercel.json project configuration file. This is in addition to the existing dashboard and API support."
---




Jul 9, 2025

You can now control Vercel’s Web Application Firewall (WAF) actions directly in [`vercel.json`](https://vercel.com/docs/project-configuration), alongside existing support in the dashboard, API, and terraform.

This approach provides a structured way for both developers and agents to declaratively define and push rules to projects. Agents can use code-generating prompts to author new rules that are easily injected into the project’s `vercel.json.`

The `has` and `missing` matchers have also [been enhanced](https://vercel.com/docs/project-configuration#route-has-and-missing-object-definition) to support more expressive conditions across headers, rewrites, redirects, and routes. Matching options include:

- String equality and inequality

- Regular expressions

- Prefixes and suffixes

- Inclusion and exclusion from string arrays

- Numeric comparisons


The following example shows how to deny a request that is prefixed by a specific header:

```json
1{

2  "$schema": "https://openapi.vercel.sh/vercel.json",

3  "routes": [\
\
4    {\
\
5      "src": "/(.*)",\
\
6      "has": [\
\
7        {\
\
8          "type": "header",\
\
9          "key": {\
\
10            "pre": "x-bad-header-"\
\
11          }\
\
12        }\
\
13      ],\
\
14      "mitigate": {\
\
15        "action": "deny"\
\
16      }\
\
17    }\
\
18  ]

19}
```

Read more about [Vercel's WAF](https://vercel.com/docs/vercel-firewall/vercel-waf) and [configuring WAF rules in `vercel.json`](https://vercel.com/docs/vercel-firewall/vercel-waf/custom-rules#configuration-in-vercel.json).