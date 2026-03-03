---
title: "Requester's public IP postal code now available in Vercel Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/requesters-public-ip-postal-code-now-available-in-vercel-functions"
date: "2025-01-09"
scraped_at: "2026-03-02T09:38:30.648756593+00:00"
language: "en"
translated: false
description: "Postal codes of the requester's public IP address are now available in Vercel headers. The x-vercel-ip-postal-code header complements existing headers like x-vercel-ip-country and x-vercel-ip-city."
---




Jan 9, 2025

The `x-vercel-ip-postal-code` header is now part of [Vercel’s geolocation capabilities](https://vercel.com/docs/edge-network/headers/request-headers), providing the postal code associated with the requester’s public IP address. This complements existing headers like `x-vercel-ip-country`, `x-vercel-ip-city`, and `x-vercel-ip-country-region`.

This information should be used as a general reference rather than a precise locator. Due to inherent limitations and variability in IP-based geolocation, the accuracy may vary. We recommend complementing it with other data sources, such as the [Geolocation API](https://developer.mozilla.org/en-US/docs/Web/API/Geolocation_API), for critical applications.

The `x-vercel-ip-postal-code` header is accessible in Vercel Functions, including [Edge Middleware](https://vercel.com/docs/functions/edge-middleware). Here's a TypeScript example:

```tsx
export function GET(request: Request) {

2  const postalCode = request.headers.get('x-vercel-ip-postal-code');

3  return new Response(`Postal Code: ${postalCode}`);

4}
```

Postal codes are also available via the `@vercel/functions` package:

```tsx
import { geolocation } from '@vercel/functions';



export function GET(request: Request) {

4  const geo = geolocation(request);

5  return new Response(`Postal Code: ${geo.postalCode}`);

6}
```

For more information on headers and geolocation, see [Vercel’s request header documentation.](https://vercel.com/docs/edge-network/headers/request-headers)