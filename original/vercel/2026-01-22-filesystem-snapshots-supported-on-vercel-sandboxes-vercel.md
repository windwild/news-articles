---
title: "Filesystem snapshots supported on Vercel Sandboxes - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/filesystem-snapshots-supported-on-vercel-sandboxes"
date: "2026-01-22"
scraped_at: "2026-03-02T09:22:33.403859632+00:00"
language: "en"
translated: false
description: "Vercel sandboxes now let you snapshot an entire filesystem, and you can restore from those snapshots for future work."
---




Jan 22, 2026

[Vercel Sandbox](https://vercel.com/sandbox) now supports filesystem snapshots to capture your state. You can capture a Sandbox's complete filesystem state as a snapshot and launch new Sandboxes from that snapshot using the Sandbox API.

This eliminates repeated setup when working with expensive operations like dependency installation, builds, or fixture creation. Create the environment once, snapshot it, then reuse that exact filesystem state across multiple isolated runs.

### How snapshots work

Snapshots capture the entire filesystem of a running Sandbox. New Sandboxes can launch from that snapshot, providing immediate access to pre-installed dependencies and configured environments.

### Key capabilities

- Create a snapshot from any running Sandbox with `sandbox.snapshot()`

- Launch new Sandboxes from snapshots via `source: { type: 'snapshot', snapshotId }`

- Reuse the same snapshot with multiple Sandboxes for parallel testing and experimentation


```typescript
import { Sandbox } from '@vercel/sandbox';



const sandbox = await Sandbox.create();

await sandbox.writeFiles([{\
\
5  path: '/vercel/sandbox/hello',\
\
6  content: Buffer.from('Hello Vercel Sandbox and Snapshots'),\
\
7}]);

const snapshot = await sandbox.snapshot();



const newSandbox = await Sandbox.create({

11  source: { type: 'snapshot', snapshotId: snapshot.snapshotId },

12});

for await (const chunk of await newSandbox.readFile({ path: '/vercel/sandbox/hello' })) {

14  process.stdout.write(chunk);

15};
```

See the [documentation](https://vercel.com/docs/vercel-sandbox/concepts/snapshots) to get started with snapshots.