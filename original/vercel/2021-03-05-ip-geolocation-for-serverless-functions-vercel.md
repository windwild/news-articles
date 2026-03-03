---
title: "IP Geolocation for Serverless Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/ip-geolocation-for-serverless-functions"
date: "2021-03-05"
scraped_at: "2026-03-02T10:05:56.173580617+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Mar 5, 2021

![with cercel → vercel](images/ip-geolocation-for-serverless-functions-vercel/img_001.jpg)

Requests received by Serverless Functions on [Pro and Enterprise Teams](https://vercel.com/pricing) are now enriched with headers containing information about the geographic location of the visitor:

- `X-Vercel-IP-Country` – The 2-letter country code of the IP sending the request.

- `X-Vercel-IP-Country-Region` – The [ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2) region code associated to the IP.

- `X-Vercel-IP-City` – The city name associated to the IP.


As an example, a request from Tokyo is now enriched with the following headers:

```text
X-Vercel-IP-Country: JP

X-Vercel-IP-Country-Region: 13

X-Vercel-IP-City: Tokyo
```

This feature is now automatically activated for all new and existing Serverless Functions on [Pro and Enterprise Teams](https://vercel.com/pricing) — no code or configuration change needed.

Check out [the documentation](http://vercel.com/docs/edge-network/headers#request-headers) as well.