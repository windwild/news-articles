---
title: "Run untrusted code with Vercel Sandbox - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/run-untrusted-code-with-vercel-sandbox"
date: "2025-06-25"
scraped_at: "2026-03-02T09:32:22.788231304+00:00"
language: "en-zh"
translated: true
description: "Vercel Sandbox securely runs untrusted code in isolated cloud environments, like AI-generated code. Create ephemeral, isolated microVMs using the new Sandbox SDK, with up to 45m execution times. Now i..."
---
{% raw %}

Jun 25, 2025

2025 年 6 月 25 日

Vercel Sandbox 是一个由 [Fluid compute](https://vercel.com/fluid) 驱动的安全云资源。它专为运行不受信任的代码（例如由 AI 智能体生成的代码）而设计，所有代码均在隔离且临时的环境中执行。

Sandbox 是一个独立的 SDK，可从任意环境（包括非 Vercel 平台）中执行。Sandbox 工作负载通过全新的 [Sandbox SDK](https://vercel.com/docs/vercel-sandbox/sdk-reference) 在临时、隔离的微虚拟机（microVM）中运行，支持最长 45 分钟的执行时间。

```javascript
import { Sandbox } from "@vercel/sandbox";

import { generateText } from 'ai';



const result = await generateText({

5    model: "anthropic/claude-4-sonnet-20250514",

6    prompt: `Write a Node.js script that prints a Haiku poem to stdout.`,

7    system: `

8      You are a developer that responds with the content of a single Node.js script.

8      你是一名开发者，仅返回一个 Node.js 脚本的内容。

9      You must include only the code without any markdown, nothing else.

9      你必须仅包含代码，不包含任何 Markdown 格式内容，其他什么都不要。

10      Just include Javascript code and no characters before or after the code.

10      仅包含 JavaScript 代码，代码前后不得有任何字符。

11    `,

11    `,

12  });

12  });

14  const sandbox = await Sandbox.create();

14  const sandbox = await Sandbox.create();

16  await sandbox.writeFiles([\
\
16  await sandbox.writeFiles([\
\
17    { path: "script.js", stream: Buffer.from(result.text) },\
\
17    { path: "script.js", stream: Buffer.from(result.text) },\
\
18  ]);

18  ]);

```js
20  await sandbox.runCommand({

21    cmd: "node",

22    args: ["script.js"],

23    stdout: process.stdout,

24    stderr: process.stderr,

25  });
```

```js
20  await sandbox.runCommand({

21    cmd: "node",

22    args: ["script.js"],

23    stdout: process.stdout,

24    stderr: process.stderr,

25  });
```

An example of using Vercel Sandbox to run generated code.

使用 Vercel Sandbox 运行生成代码的示例。

Sandbox uses the Fluid compute model and charges based on [Fluid’s new Active CPU time](https://vercel.com/changelog/lower-pricing-with-active-cpu-pricing-for-fluid-compute), meaning you only pay for compute when actively using CPU. See [Sandbox pricing](https://vercel.com/docs/vercel-sandbox#pricing) for included allotments and pricing for Hobby and Pro teams.

Sandbox 采用 Fluid 计算模型，并依据 [Fluid 全新“活跃 CPU 时间”计费机制](https://vercel.com/changelog/lower-pricing-with-active-cpu-pricing-for-fluid-compute) 收费，即仅在 CPU 实际运行时计费。有关 Hobby 和 Pro 套餐所含额度及具体定价，请参阅 [Sandbox 定价说明](https://vercel.com/docs/vercel-sandbox#pricing)。

Now in [Beta](https://vercel.com/docs/release-phases#beta) and available to customers on all plans. Learn more about [Vercel Sandbox](https://vercel.com/docs/vercel-sandbox).

目前已进入 [Beta 测试阶段](https://vercel.com/docs/release-phases#beta)，所有付费计划的客户均可使用。了解更多关于 [Vercel Sandbox](https://vercel.com/docs/vercel-sandbox) 的信息。
{% endraw %}
