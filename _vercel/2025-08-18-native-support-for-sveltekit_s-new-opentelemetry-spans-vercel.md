---
render_with_liquid: false
title: "Native support for SvelteKit's new OpenTelemetry spans - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/native-support-for-sveltekits-new-opentelemetry-spans"
date: "2025-08-18"
scraped_at: "2026-03-02T09:29:44.843059786+00:00"
language: "en-zh"
translated: true
description: "SvelteKit natively supports OpenTelemetry tracing on Vercel using `registerOTel` from `@vercel/otel`. "
---
render_with_liquid: false
render_with_liquid: false

Aug 18, 2025

2025 年 8 月 18 日

Vercel now directly integrates with [SvelteKit](https://svelte.dev/docs/kit)'s new server-side OpenTelemetry spans.

Vercel 现已直接集成 [SvelteKit](https://svelte.dev/docs/kit) 全新的服务端 OpenTelemetry 跟踪（spans）。

To get started, activate experimental tracing in SvelteKit:

开始使用前，请在 SvelteKit 中启用实验性跟踪功能：

svelte.config.js

```javascript
1/** @type {import('@sveltejs/kit').Config} */

const config = {

3	kit: {

4		experimental: {

5			tracing: {

6				server: true,

7			},

8			instrumentation: {

9				server: true,

10			}

11		}

12	}

13};



export default config;
```

然后，使用 Vercel OpenTelemetry 收集器创建追踪（tracing）插桩文件：

src/instrumentation.server.ts

src/instrumentation.server.ts

```javascript
import { registerOTel } from '@vercel/otel';



registerOTel({

4	serviceName: 'my-sveltekit-app'

5});
```

```javascript
import { registerOTel } from '@vercel/otel';



registerOTel({

4	serviceName: 'my-sveltekit-app'

5});
```

Traces generated during [tracing sessions](https://vercel.com/docs/session-tracing) will now include the built-in SvelteKit spans. You can also [configure other collectors](https://vercel.com/docs/otel). See the [SvelteKit observability docs](https://svelte.dev/docs/kit/observability) for more information.

在 [跟踪会话](https://vercel.com/docs/session-tracing) 期间生成的追踪（traces）现在将包含内置的 SvelteKit 跨度（spans）。您还可以 [配置其他采集器（collectors）](https://vercel.com/docs/otel)。更多详情，请参阅 [SvelteKit 可观测性文档](https://svelte.dev/docs/kit/observability)。

![SvelteKit integrated spans (in green) shown beneath Vercel infrastructure spans. Delays added for illustration.](images/native-support-for-sveltekit_s-new-opentelemetry-spans-vercel/img_001.jpg)  
![SvelteKit 集成的跨度（绿色）显示在 Vercel 基础设施跨度下方；图中添加了延迟以作示意。](images/native-support-for-sveltekit_s-new-opentelemetry-spans-vercel/img_001.jpg)