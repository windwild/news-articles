---
title: "Vercel Sandboxes are now generally available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-sandboxes-ga"
date: "2026-01-30"
scraped_at: "2026-03-02T09:21:39.557640894+00:00"
language: "en-zh"
translated: true
description: "Vercel Sandbox is now GA, providing isolated Linux VMs for safely executing untrusted code. Run AI agent output, user uploads, and third-party code without exposing production systems."
---
{% raw %}

Jan 30, 2026

2026 年 1 月 30 日

Vercel Sandboxes 现已全面开放（Generally Available），为安全执行不受信任的代码提供了一种临时性计算原语（ephemeral compute primitive）。

它使团队能够运行由 AI 智能体生成的输出、未经验证的用户上传内容以及第三方代码，而不会暴露生产系统。

每个沙箱均在 Firecracker 微虚拟机（microVM）中运行，并与您的基础设施完全隔离；因此，在沙箱中运行的代码无法访问环境变量、数据库连接及云资源。

v0、Blackbox AI 和 RooCode 等团队已在生产环境中使用 Sandboxes。

要快速启动一个用于创建 Vercel 沙箱的简单 Node.js 应用程序，请使用以下代码：

```tsx
import { Sandbox } from '@vercel/sandbox';



const sandbox = await Sandbox.create();
```

```javascript
await sandbox.runCommand({

6  cmd: 'node',

7  args: ["-e", 'console.log("Hello from Vercel Sandbox!")'],

8  stdout: process.stdout,

9});
```

```javascript
await sandbox.runCommand({

6  cmd: 'node',

7  args: ["-e", 'console.log("Hello from Vercel Sandbox!")'],

8  stdout: process.stdout,

9});
```

Or get started with the CLI by opening an interactive shell:

或者通过打开交互式 Shell，使用 CLI 快速开始：

```bash
npx sandbox create --connect
```

```bash
npx sandbox create --connect
```

Explore the [documentation](https://vercel.com/docs/vercel-sandbox) to get started, and check out the [open-source SDK and CLI](https://www.npmjs.com/package/sandbox).

请查阅 [文档](https://vercel.com/docs/vercel-sandbox) 开始上手，并查看 [开源的 SDK 和 CLI](https://www.npmjs.com/package/sandbox)。
{% endraw %}
