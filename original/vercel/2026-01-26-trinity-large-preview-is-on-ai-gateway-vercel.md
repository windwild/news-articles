---
title: "Trinity Large Preview is on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/trinity-large-preview-is-on-ai-gateway"
date: "2026-01-26"
scraped_at: "2026-03-03T07:10:29.924617476+00:00"
language: "en"
translated: false
description: "You can now access Arcee AI's Trinity Large Preview model via AI Gateway with no other provider accounts required."
---




Jan 26, 2026

You can now access Trinity Large Preview via [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required.

Trinity Large Preview is optimized for reasoning-intensive workloads, including math, coding tasks, and complex multi-step agent workflows. It is designed to handle extended multi-turn interactions efficiently while maintaining high inference throughput.

To use this model, set model to `arcee-ai/trinity-large-preview` in the AI SDK:

```tsx
import { streamText } from 'ai'​​​​‌﻿‍﻿​‍​‍‌‍﻿﻿‌﻿​‍‌‍‍‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍​‍​‍﻿​​‍​‍‌‍‍​‌﻿​‍‌‍‌‌‌‍‌‍​‍​‍​﻿‍‍​‍​‍‌‍‍​‌﻿‌​‌﻿‌​‌﻿​​‌﻿​﻿​﻿‍‍​‍﻿﻿​‍﻿﻿‌‍​‌‌﻿​​‌﻿​​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍﻿﻿‌﻿​﻿‌﻿​​‌‍​‌‌‍​﻿‌‍‌‌‌﻿​﻿​‍﻿﻿‌‍‌‌​﻿‌‌​﻿​﻿​﻿‍​​﻿​‍‌‍‍​‌‍​﻿‌﻿‌​​﻿‌﻿​﻿‌​‌﻿​﻿‌‍‍‌​‍﻿﻿‌‍‌‌‌‍﻿‍‌﻿‌‍‌‍‍‌‌﻿​‍‌‍﻿﻿‌‍﻿‍‌‍﻿‌‌‍‌‌‌‍﻿‍‌﻿‌​‌﻿​﻿​‍﻿﻿‌‍﻿‌‌‍​‌‌﻿​﻿‌﻿‌​‌‍‌‌‌﻿​‍​‍﻿﻿‌‍‌‌‌‍﻿‍‌﻿‌​‌﻿​‍‌‍‍‌‌‍‌‌‌﻿​﻿​‍﻿﻿​﻿‌‌‌﻿​‍‌‌‌‌‌‌​‍‌​​‍‌​‌‍‌‌‍​‌‌‌﻿‌​‍‍‌﻿‌‌‌‌‌‍‌‌‍‌‌‍﻿‍​﻿​﻿‌﻿‌​‌‍‍​‌​﻿﻿‌​‌‍‌‌‍‍‌‍‌﻿‌﻿​‍‌​‌‌​‍﻿﻿​﻿﻿﻿‌‍‌‍‌‍﻿﻿‌‍​﻿‌﻿‌‌‌﻿​﻿‌‍‌‌‌‍‌​‌​‌‍‌‍‍‌‌‍‌‌‌‍﻿​‌‍‌​​﻿﻿‌‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​​‍‌‍‌‍‌‍‌‍﻿﻿‌‍​﻿‌﻿‌‌‌﻿​﻿‌‍‌‌‌‍‌​‌​﻿​‌‍﻿﻿‌‍​﻿‌‍​‌‌‍﻿​‌‍‌‌​﻿﻿‌‌‍‌‌‌‍﻿‍​‍﻿‌‌‌‌‌‌‌​﻿​‍‌‍‌﻿​﻿‌‍﻿﻿‌﻿‌‌‌﻿​‍‌‍​﻿‌‍‌‌​﻿﻿‌‌﻿‌‍‌‍‌‌‌﻿​‍‌‍​﻿‌‍‌‌‌‍﻿​​‍﻿‌‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​​‍﻿‌‌‍﻿​‌‍‍‌‌‍﻿‍‌‍‍﻿​‍​‍​‍﻿​​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍​‍​﻿‍‍‌﻿‍﻿​‍​‍‌‍‌‌‌‍‌​‌‍‍‌‌﻿‌​‌‍﻿﻿‌﻿​‍‌​‍‌‌‍﻿‍‌﻿‌​‌‍‌‌‌﻿​‍‌‍‌‍‌‍​‌‌‍​﻿‌‍‌‌​‍​‍​﻿‍‍‌﻿‍﻿​‍​‍‌﻿‌﻿‌‍‍‌‌‍‌​‌‍‌﻿‌‍‌‌‌﻿‌​‌​‍‌‌‍‌​​‍​‍​﻿‍‍​‍​‍‌﻿​‍‌‍‍‌‌‍​﻿‌‍‍​‌‌‌​‌‍‌‌‌﻿‍​‌﻿‌​‌​‌‌‌‍‌​‌‍‍‌‌﻿‌​‌‍﻿﻿‌﻿​‍​‍​‍​‍﻿​​‍​‍‌﻿‌﻿‌‍‍‌‌‍‌​‌‍‌﻿‌‍‌‌‌﻿‌​‌​﻿‍‌‍​‌‌‍﻿‌‌‍‌‌‌﻿​﻿‌﻿​​‌‍​‌‌‍​﻿‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌‍​‍‌﻿‌‌‌‍‍‌‌‍﻿​‌﻿‌​‌‍‍‌‌‍﻿‍​‍​‍‌﻿﻿‌​‍﻿​​‍​‍‌‍‌‍‌‍‍‌‌‍‌‌‌‍﻿​‌‍‌​‌‌‌​‌﻿‍‌‌﻿​​‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌‌​‍‌‍‍‌‌‍​﻿‌‍‍​‌‌‌​‌‍‌‌‌﻿‍​‌﻿‌​​‍​‍‌﻿﻿‌‌﻿﻿‌



const result = streamText({

4  model: 'arcee-ai/trinity-large-preview',

5  prompt:

6   `Implement a long-context reasoning benchmark with ingested documents,

7    multi-step analysis, and generate conclusions.`

8})​​​​‌﻿‍﻿​‍​‍‌‍﻿﻿‌﻿​‍‌‍‍‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍​‍​‍﻿​​‍​‍‌‍‍​‌﻿​‍‌‍‌‌‌‍‌‍​‍​‍​﻿‍‍​‍​‍‌‍‍​‌﻿‌​‌﻿‌​‌﻿​​‌﻿​﻿​﻿‍‍​‍﻿﻿​‍﻿﻿‌‍​‌‌﻿​​‌﻿​​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍﻿﻿‌﻿​﻿‌﻿​​‌‍​‌‌‍​﻿‌‍‌‌‌﻿​﻿​‍﻿﻿‌‍‌‌​﻿‌‌​﻿​﻿​﻿‍​​﻿​‍‌‍‍​‌‍​﻿‌﻿‌​​﻿‌﻿​﻿‌​‌﻿​﻿‌‍‍‌​‍﻿﻿‌‍‌‌‌‍﻿‍‌﻿‌‍‌‍‍‌‌﻿​‍‌‍﻿﻿‌‍﻿‍‌‍﻿‌‌‍‌‌‌‍﻿‍‌﻿‌​‌﻿​﻿​‍﻿﻿‌‍﻿‌‌‍​‌‌﻿​﻿‌﻿‌​‌‍‌‌‌﻿​‍​‍﻿﻿‌‍‌‌‌‍﻿‍‌﻿‌​‌﻿​‍‌‍‍‌‌‍‌‌‌﻿​﻿​‍﻿﻿​﻿‌‌‌﻿​‍‌‌‌‌‌‌​‍‌​​‍‌​‌‍‌‌‍​‌‌‌﻿‌​‍‍‌﻿‌‌‌‌‌‍‌‌‍‌‌‍﻿‍​﻿​﻿‌﻿‌​‌‍‍​‌​﻿﻿‌​‌‍‌‌‍‍‌‍‌﻿‌﻿​‍‌​‌‌​‍﻿﻿​﻿﻿﻿‌‍‌‍‌‍﻿﻿‌‍​﻿‌﻿‌‌‌﻿​﻿‌‍‌‌‌‍‌​‌​‌‍‌‍‍‌‌‍‌‌‌‍﻿​‌‍‌​​﻿﻿‌‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​​‍‌‍‌‍‌‍‌‍﻿﻿‌‍​﻿‌﻿‌‌‌﻿​﻿‌‍‌‌‌‍‌​‌​﻿​‌‍﻿﻿‌‍​﻿‌‍​‌‌‍﻿​‌‍‌‌​﻿﻿‌‌‍‌‌‌‍﻿‍​‍﻿‌‌‌‌‌‌‌​﻿​‍‌‍‌﻿​﻿‌‍﻿﻿‌﻿‌‌‌﻿​‍‌‍​﻿‌‍‌‌​﻿﻿‌‌﻿‌‍‌‍‌‌‌﻿​‍‌‍​﻿‌‍‌‌‌‍﻿​​‍﻿‌‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​​‍﻿‌‌‍﻿​‌‍‍‌‌‍﻿‍‌‍‍﻿​‍​‍​‍﻿​​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍​‍​﻿‍‍‌﻿‍﻿​‍​‍‌‍‌‌‌‍‌​‌‍‍‌‌﻿‌​‌‍﻿﻿‌﻿​‍‌​‍‌‌‍﻿‍‌﻿‌​‌‍‌‌‌﻿​‍‌‍‌‍‌‍​‌‌‍​﻿‌‍‌‌​‍​‍​﻿‍‍‌﻿‍﻿​‍​‍‌﻿‌﻿‌‍‍‌‌‍‌​‌‍‌﻿‌‍‌‌‌﻿‌​‌​‍‌‌‍‌​​‍​‍​﻿‍‍​‍​‍‌﻿​‍‌‍‍‌‌‍​﻿‌‍‍​‌‌‌​‌‍‌‌‌﻿‍​‌﻿‌​‌​‌‌‌‍‌​‌‍‍‌‌﻿‌​‌‍﻿﻿‌﻿​‍​‍​‍​‍﻿​​‍​‍‌﻿‌﻿‌‍‍‌‌‍‌​‌‍‌﻿‌‍‌‌‌﻿‌​‌​﻿‍‌‍​‌‌‍﻿‌‌‍‌‌‌﻿​﻿‌﻿​​‌‍​‌‌‍​﻿‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌‍​‍‌﻿‌‌‌‍‍‌‌‍﻿​‌﻿‌​‌‍‍‌‌‍﻿‍​‍​‍‌﻿﻿‌​‍﻿​​‍​‍‌‍‌‍‌‍‍‌‌‍‌‌‌‍﻿​‌‍‌​‌‌‌​‌﻿‍‌‌﻿​​‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌‌​‍‌‍‍‌‌‍​﻿‌‍‍​‌‌‌​‌‍‌‌‌﻿‍​‌﻿‌​​‍​‍‌﻿﻿‌‌﻿﻿‌
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/observability/ai-sdk-observability), [Bring Your Own Key](https://vercel.com/docs/ai-gateway#bring-your-own-key) support, and intelligent provider routing with automatic retries.

Learn more about [AI Gateway](https://vercel.com/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/trinity-large-preview).