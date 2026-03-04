---
render_with_liquid: false
title: "Requester's public IP postal code now available in Vercel Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/requesters-public-ip-postal-code-now-available-in-vercel-functions"
date: "2025-01-09"
scraped_at: "2026-03-02T09:38:30.648756593+00:00"
language: "en-zh"
translated: true
description: "Postal codes of the requester's public IP address are now available in Vercel headers. The x-vercel-ip-postal-code header complements existing headers like x-vercel-ip-country and x-vercel-ip-city."
---
render_with_liquid: false
render_with_liquid: false

Jan 9, 2025

2025 年 1 月 9 日

The `x-vercel-ip-postal-code` header is now part of [Vercel’s geolocation capabilities](https://vercel.com/docs/edge-network/headers/request-headers), providing the postal code associated with the requester’s public IP address. This complements existing headers like `x-vercel-ip-country`, `x-vercel-ip-city`, and `x-vercel-ip-country-region`.

`x-vercel-ip-postal-code` 请求头现已纳入 [Vercel 的地理定位功能](https://vercel.com/docs/edge-network/headers/request-headers)，可提供请求者公网 IP 地址所对应的邮政编码。该功能与现有请求头（如 `x-vercel-ip-country`、`x-vercel-ip-city` 和 `x-vercel-ip-country-region`）互为补充。

This information should be used as a general reference rather than a precise locator. Due to inherent limitations and variability in IP-based geolocation, the accuracy may vary. We recommend complementing it with other data sources, such as the [Geolocation API](https://developer.mozilla.org/en-US/docs/Web/API/Geolocation_API), for critical applications.

该信息仅宜作为一般性参考，不宜用作精确定位依据。由于基于 IP 的地理定位本身存在固有局限性和结果波动性，其准确性可能因情况而异。对于关键业务场景，我们建议结合其他数据源（例如 [Geolocation API](https://developer.mozilla.org/zh-CN/docs/Web/API/Geolocation_API)）共同使用，以提升可靠性。

The `x-vercel-ip-postal-code` header is accessible in Vercel Functions, including [Edge Middleware](https://vercel.com/docs/functions/edge-middleware). Here's a TypeScript example:

`x-vercel-ip-postal-code` 请求头可在 Vercel Functions（包括 [Edge Middleware](https://vercel.com/docs/functions/edge-middleware)）中直接访问。以下是一个 TypeScript 示例：

```tsx
export function GET(request: Request) {

2  const postalCode = request.headers.get('x-vercel-ip-postal-code');

3  return new Response(`Postal Code: ${postalCode}`);

4}
```

```tsx
export function GET(request: Request) {

2  const postalCode = request.headers.get('x-vercel-ip-postal-code');

3  return new Response(`邮政编码：${postalCode}`);

4}
```

Postal codes are also available via the `@vercel/functions` package:

邮政编码亦可通过 `@vercel/functions` 包获取：  

```tsx
import { geolocation } from '@vercel/functions';
```

```ts
export function GET(request: Request) {

4  const geo = geolocation(request);

5  return new Response(`Postal Code: ${geo.postalCode}`);

6}
```

有关请求头和地理位置信息的更多信息，请参阅 [Vercel 的请求头文档](https://vercel.com/docs/edge-network/headers/request-headers)。