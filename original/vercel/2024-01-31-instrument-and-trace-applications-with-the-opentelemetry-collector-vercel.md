---
title: "Instrument and trace applications with the OpenTelemetry collector - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/instrument-and-trace-applications-with-the-opentelemetry-collector"
date: "2024-01-31"
scraped_at: "2026-03-02T09:48:17.151574499+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jan 31, 2024

Vercel and Next.js provide increased observability of your applications through OpenTelemetry.

instrumentation.ts

```tsx
import { registerOTel } from '@vercel/otel';



export function register() {

4  registerOTel({ serviceName: 'acme-co' });

5}
```

Using the Vercel OTEL package with Next.js.

[v1.0](https://www.npmjs.com/package/@vercel/otel) of `@vercel/otel` now supports:

- Support for Node.js and Edge runtimes

- Telemetry context propagation, including [W3C Trace Context](https://www.w3.org/TR/trace-context/)

- Fetch API instrumentation with context propagation

- Support and auto-configuration for the [Vercel OTEL collector](https://vercel.com/docs/observability/otel-overview/quickstart)

- Enhanced metadata reporting

- Sampling support

- Custom tracing exporter support

- Batched trace exporting


Learn more in [our documentation](https://vercel.com/docs/observability/otel-overview) or start using the package with [Next.js](https://nextjs.org/docs/app/building-your-application/optimizing/open-telemetry).