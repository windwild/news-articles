---
render_with_liquid: false
title: "@vercel/otel 1.3.0 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-otel-1-3-0"
date: "2024-02-16"
scraped_at: "2026-03-02T09:47:55.711644882+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Feb 16, 2024

2024 年 2 月 16 日

Vercel 和 Next.js 通过 OpenTelemetry 提供了更强的应用可观测性。

instrumentation.ts

```tsx
import { registerOTel } from '@vercel/otel';



export function register() {

4  registerOTel({ serviceName: 'acme-co' });

5}
```

在 Next.js 中使用 Vercel OTEL 包。

`@vercel/otel` 的 [v1.3.0](https://www.npmjs.com/package/@vercel/otel) 版本现已为 [Datadog](https://vercel.com/integrations/datadog) 提供自定义资源名称和操作名称，以满足其基数（cardinality）要求。您可将特定 trace span 关联的 URL 路径进行分组，从而降低基数及相应的用量。

For example, `/products/hoodie` can be mapped to `/products/[name]`.

例如，`/products/hoodie` 可以映射为 `/products/[name]`。

Learn more in [our documentation](https://vercel.com/docs/observability/otel-overview) or start using the package with [Next.js](https://nextjs.org/docs/app/building-your-application/optimizing/open-telemetry).

请在[我们的文档](https://vercel.com/docs/observability/otel-overview)中了解更多信息，或通过 [Next.js](https://nextjs.org/docs/app/building-your-application/optimizing/open-telemetry) 开始使用该软件包。