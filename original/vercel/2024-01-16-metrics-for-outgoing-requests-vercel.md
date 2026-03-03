---
title: "Metrics for outgoing requests - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/metrics-for-outgoing-requests"
date: "2024-01-16"
scraped_at: "2026-03-02T09:48:24.711782302+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jan 16, 2024

![Screenshot of new requests metrics, showing 5 outgoing fetch requests with traces on the side](images/metrics-for-outgoing-requests-vercel/img_001.jpg)![Screenshot of new requests metrics, showing 5 outgoing fetch requests with traces on the side](images/metrics-for-outgoing-requests-vercel/img_002.jpg)

You can now see all outgoing requests for a selected log in [Runtime Logs](https://vercel.com/docs/observability/runtime-logs).

Logs now display the status, duration, URL, and a trace for each request. Request metrics work with every request on Vercel, so [all frameworks](https://vercel.com/docs/frameworks) are supported. This makes it easier to debug latency and caching inside your Vercel Functions or when calling [databases](https://vercel.com/docs/storage).

This release also includes various of quality-of-life improvements in the Logs UI.

Request metrics are **free while in beta** and only available to Pro and Enterprise customers.