---
title: "Vercel Blob is now generally available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-blob-is-now-generally-available"
date: "2025-05-21"
scraped_at: "2026-03-02T09:33:21.636561364+00:00"
language: "en"
translated: false
description: "Vercel Blob is now generally available, bringing high-performance storage integrated with the Vercel application delivery platform."
---




May 21, 2025

![](images/vercel-blob-is-now-generally-available-vercel/img_001.jpg)![](images/vercel-blob-is-now-generally-available-vercel/img_002.jpg)

Vercel Blob is now generally available, bringing high-performance, globally scalable object storage into your workflows and apps.

Blob storage’s underlying S3 infrastructure ensures 99.999999999% durability, and already stores over 400 million files while powering production apps like [v0.dev](https://v0.dev/).

Pricing is usage-based:

- **Storage**: $0.023 per GB per month

- **Simple API operations (e.g. Reads)**: $0.40 per million

- **Advanced operations (e.g. Uploads)**: $5.00 per million

- **Blob Data Transfer**: starting at $0.050 per GB


Pricing applies to:

- New Blob stores starting today

- Existing stores starting June 16, 2025


Storage and operation pricing **match S3**, and Blob Data Transfer is a new mechanism for direct object access that's up to **3x less expensive** than Fast Data Transfer and integrates directly with Vercel’s global caching layer.

Hobby users now get increased free usage: 1 GB of storage and 10 GB of Blob Data Transfer per month.

[Get started with Vercel Blob](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fstores&title=Get+started+with+Vercel+Blob) and learn more in the [documentation](https://vercel.com/docs/vercel-blob).