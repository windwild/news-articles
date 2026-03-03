---
title: "Enhanced geolocation information for Vercel Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/enhanced-geolocation-information-available-for-vercel-functions"
date: "2022-08-03"
scraped_at: "2026-03-02T10:01:06.401538291+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Aug 3, 2022

![](images/enhanced-geolocation-information-for-vercel-functions-vercel/img_001.jpg)![](images/enhanced-geolocation-information-for-vercel-functions-vercel/img_002.jpg)

Requests received by Serverless and Edge Functions are now enriched with headers containing information about the timezone of the visitor:

As an example, a request from Tokyo is now enriched with the following headers:

```text
X-Vercel-IP-Latitude: 37.7749

X-Vercel-IP-Longitude: -122.4194

X-Vercel-IP-Timezone: Japan
```

This header is now automatically activated for all new and existing Vercel Functions for all plans — no code or configuration change needed.

Check out [the documentation](http://vercel.com/docs/edge-network/headers#request-headers) as well.