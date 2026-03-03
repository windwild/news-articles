---
title: "@vercel/otel 1.3.0 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-otel-1-3-0"
date: "2024-02-16"
scraped_at: "2026-03-02T09:47:55.711644882+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Feb 16, 2024

Vercel and Next.js provide increased observability of your applications through OpenTelemetry.

instrumentation.ts

```tsx
import { registerOTel } from '@vercel/otel';



export function register() {

4  registerOTel({ serviceName: 'acme-co' });

5}
```

Using the Vercel OTEL package with Next.js.

[v1.3.0](https://www.npmjs.com/package/@vercel/otel) of `@vercel/otel` now providing custom resource and operation names for [Datadog](https://vercel.com/integrations/datadog) to satisfy their cardinality requirements. You can group related URL paths for a given span to reduce cardinality and associated usage.

For example, `/products/hoodie` can be mapped to `/products/[name]`.

Learn more in [our documentation](https://vercel.com/docs/observability/otel-overview) or start using the package with [Next.js](https://nextjs.org/docs/app/building-your-application/optimizing/open-telemetry).