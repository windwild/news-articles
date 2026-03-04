---
title: "Vercel Sandbox snapshots now allow custom retention periods - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-sandbox-snapshots-now-allow-custom-retention-periods"
date: "2026-02-17"
scraped_at: "2026-03-02T09:21:31.038133834+00:00"
language: "en-zh"
translated: true
description: "Snapshots created with Vercel Sandbox can now have a configurable expiration policy set instead of the default 30 days allowing users to keep snapshots indefinitely."
---
{% raw %}

Feb 17, 2026

2026 年 2 月 17 日

使用 [Vercel Sandbox](https://vercel.com/docs/vercel-sandbox) 创建的快照现在支持自定义过期时间，不再受限于此前固定的 7 天期限，同时默认过期时间也已提高。

```typescript
import { Sandbox } from '@vercel/sandbox';

import ms from 'ms';



const sandbox = Sandbox.create();



sandbox.snapshot({ expiration: ms('1d') })
```

过期时间可在 [1 天至永久（infinity）之间配置。](https://vercel.com/docs/vercel-sandbox/sdk-reference#sandbox.snapshot) 若未显式指定，则快照默认过期时间为 30 天。

您也可以通过 [CLI](https://vercel.com/docs/vercel-sandbox/cli-reference#sandbox-snapshot) 配置该选项。

```bash
1# Create a snapshot of a running sandbox

1# 创建正在运行的沙盒的快照

sandbox snapshot sb_1234567890 --stop

sandbox snapshot sb_1234567890 --stop



4# Create a snapshot that expires in 14 days

4# 创建一个 14 天后过期的快照

sandbox snapshot sb_1234567890 --stop --expiration 14d

sandbox snapshot sb_1234567890 --stop --expiration 14d



7# Create a snapshot that never expires

7# 创建一个永不过期的快照

sandbox snapshot sb_1234567890 --stop --expiration 0

sandbox snapshot sb_1234567890 --stop --expiration 0
```

Read the [documentation](https://vercel.com/docs/vercel-sandbox/concepts/snapshots) to learn more about snapshots.

请阅读 [文档](https://vercel.com/docs/vercel-sandbox/concepts/snapshots)，了解有关快照的更多信息。
{% endraw %}
