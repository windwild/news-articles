---
title: "Vercel Sandbox snapshots now allow custom retention periods - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-sandbox-snapshots-now-allow-custom-retention-periods"
date: "2026-02-17"
scraped_at: "2026-03-02T09:21:31.038133834+00:00"
language: "en"
translated: false
description: "Snapshots created with Vercel Sandbox can now have a configurable expiration policy set instead of the default 30 days allowing users to keep snapshots indefinitely."
---




Feb 17, 2026

Snapshots created with [Vercel Sandbox](https://vercel.com/docs/vercel-sandbox) now have configurable expiration, instead of the previous 7 days limit, along with higher defaults.

```typescript
import { Sandbox } from '@vercel/sandbox';

import ms from 'ms';



const sandbox = Sandbox.create();



sandbox.snapshot({ expiration: ms('1d') })
```

The expiration can be configured between [1 day to infinity.](https://vercel.com/docs/vercel-sandbox/sdk-reference#sandbox.snapshot) If not provided, the default snapshot expiration is 30 days.

You can also configure this in the [CLI](https://vercel.com/docs/vercel-sandbox/cli-reference#sandbox-snapshot).

```bash
1# Create a snapshot of a running sandbox

sandbox snapshot sb_1234567890 --stop



4# Create a snapshot that expires in 14 days

sandbox snapshot sb_1234567890 --stop --expiration 14d



7# Create a snapshot that never expires

sandbox snapshot sb_1234567890 --stop --expiration 0
```

Read the [documentation](https://vercel.com/docs/vercel-sandbox/concepts/snapshots) to learn more about snapshots.