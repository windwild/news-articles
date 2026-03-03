---
title: "Native support for SvelteKit's new OpenTelemetry spans - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/native-support-for-sveltekits-new-opentelemetry-spans"
date: "2025-08-18"
scraped_at: "2026-03-02T09:29:44.843059786+00:00"
language: "en"
translated: false
description: "SvelteKit natively supports OpenTelemetry tracing on Vercel using `registerOTel` from `@vercel/otel`. "
---




Aug 18, 2025

Vercel now directly integrates with [SvelteKit](https://svelte.dev/docs/kit)'s new server-side OpenTelemetry spans.

To get started, activate experimental tracing in SvelteKit:

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

And create the tracing instrumentation file with the Vercel OpenTelemetry collector:

src/instrumentation.server.ts

```javascript
import { registerOTel } from '@vercel/otel';



registerOTel({

4	serviceName: 'my-sveltekit-app'

5});
```

Traces generated during [tracing sessions](https://vercel.com/docs/session-tracing) will now include the built-in SvelteKit spans. You can also [configure other collectors](https://vercel.com/docs/otel). See the [SvelteKit observability docs](https://svelte.dev/docs/kit/observability) for more information.

![SvelteKit integrated spans (in green) shown beneath Vercel infrastructure spans. Delays added for illustration.](images/native-support-for-sveltekit_s-new-opentelemetry-spans-vercel/img_001.jpg)SvelteKit integrated spans (in green) shown beneath Vercel infrastructure spans. Delays added for illustration.