---
title: "Instrument and trace applications with the OpenTelemetry collector - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/instrument-and-trace-applications-with-the-opentelemetry-collector"
date: "2024-01-31"
scraped_at: "2026-03-02T09:48:17.151574499+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Jan 31, 2024

2024 年 1 月 31 日

Vercel and Next.js provide increased observability of your applications through OpenTelemetry.

Vercel 和 Next.js 通过 OpenTelemetry 提供更强的应用可观测性。

instrumentation.ts

```tsx
import { registerOTel } from '@vercel/otel';



export function register() {

4  registerOTel({ serviceName: 'acme-co' });

5}
```

```tsx
import { registerOTel } from '@vercel/otel';



export function register() {

4  registerOTel({ serviceName: 'acme-co' });

5}
```

Using the Vercel OTEL package with Next.js.

在 Next.js 中使用 Vercel OTEL 包。

[v1.0](https://www.npmjs.com/package/@vercel/otel) of `@vercel/otel` now supports:

`@vercel/otel` [v1.0](https://www.npmjs.com/package/@vercel/otel) 版本现已支持：

- Support for Node.js and Edge runtimes

- 支持 Node.js 和 Edge 运行时

- Telemetry context propagation, including [W3C Trace Context](https://www.w3.org/TR/trace-context/)

- 遥测上下文传播，包括 [W3C Trace Context](https://www.w3.org/TR/trace-context/)

- Fetch API instrumentation with context propagation

- Fetch API 的自动插桩（instrumentation）并支持上下文传播

- Support and auto-configuration for the [Vercel OTEL collector](https://vercel.com/docs/observability/otel-overview/quickstart)

- 支持并自动配置 [Vercel OTEL collector](https://vercel.com/docs/observability/otel-overview/quickstart)

- Enhanced metadata reporting

- 增强的元数据上报能力

- Sampling support

- 采样（Sampling）支持

- Custom tracing exporter support

- 自定义追踪导出器（tracing exporter）支持

- Batched trace exporting

- 批量导出追踪数据（batched trace exporting）

Learn more in [our documentation](https://vercel.com/docs/observability/otel-overview) or start using the package with [Next.js](https://nextjs.org/docs/app/building-your-application/optimizing/open-telemetry).

如需了解更多信息，请参阅[我们的文档](https://vercel.com/docs/observability/otel-overview)，或立即在 [Next.js](https://nextjs.org/docs/app/building-your-application/optimizing/open-telemetry) 项目中开始使用该包。