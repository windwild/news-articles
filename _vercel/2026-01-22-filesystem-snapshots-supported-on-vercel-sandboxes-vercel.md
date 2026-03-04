---
title: "Filesystem snapshots supported on Vercel Sandboxes - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/filesystem-snapshots-supported-on-vercel-sandboxes"
date: "2026-01-22"
scraped_at: "2026-03-02T09:22:33.403859632+00:00"
language: "en-zh"
translated: true
description: "Vercel sandboxes now let you snapshot an entire filesystem, and you can restore from those snapshots for future work."
---

render_with_liquid: false
Jan 22, 2026

2026 年 1 月 22 日

[Vercel Sandbox](https://vercel.com/sandbox) 现已支持文件系统快照（filesystem snapshots），用于捕获当前运行状态。您可将 Sandbox 的完整文件系统状态保存为快照，并通过 Sandbox API 基于该快照启动新的 Sandbox。

此举消除了在执行耗时操作（例如依赖安装、构建或测试数据（fixture）创建）时反复进行环境配置的需要。只需一次性构建好所需环境，保存为快照，即可在多次相互隔离的运行中重复使用该精确的文件系统状态。

### 快照的工作原理

快照会捕获正在运行的 Sandbox 的整个文件系统。新 Sandbox 可基于该快照启动，从而立即获得预装的依赖项和已配置好的运行环境。

### 核心功能

- 使用 `sandbox.snapshot()` 从任意正在运行的 Sandbox 创建快照  
- 通过 `source: { type: 'snapshot', snapshotId }` 选项，基于快照启动新 Sandbox  
- 可将同一快照复用于多个 Sandbox，以支持并行测试与实验  

```typescript
import { Sandbox } from '@vercel/sandbox';
```

```javascript
const sandbox = await Sandbox.create();

const sandbox = await Sandbox.create();

await sandbox.writeFiles([{
  path: '/vercel/sandbox/hello',
  content: Buffer.from('Hello Vercel Sandbox and Snapshots'),
}]);

await sandbox.writeFiles([{
  path: '/vercel/sandbox/hello',
  content: Buffer.from('Hello Vercel Sandbox and Snapshots'),
}]);

const snapshot = await sandbox.snapshot();

const snapshot = await sandbox.snapshot();

const newSandbox = await Sandbox.create({
  source: { type: 'snapshot', snapshotId: snapshot.snapshotId },
});

const newSandbox = await Sandbox.create({
  source: { type: 'snapshot', snapshotId: snapshot.snapshotId },
});

for await (const chunk of await newSandbox.readFile({ path: '/vercel/sandbox/hello' })) {
  process.stdout.write(chunk);
}

for await (const chunk of await newSandbox.readFile({ path: '/vercel/sandbox/hello' })) {
  process.stdout.write(chunk);
}
```

15};
```

See the [documentation](https://vercel.com/docs/vercel-sandbox/concepts/snapshots) to get started with snapshots.

请参阅[文档](https://vercel.com/docs/vercel-sandbox/concepts/snapshots)，了解如何开始使用快照。