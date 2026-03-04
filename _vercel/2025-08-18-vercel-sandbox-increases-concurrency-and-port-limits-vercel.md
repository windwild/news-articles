---
title: " Vercel Sandbox increases concurrency and port limits - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-sandbox-increases-concurrency-and-port-limits"
date: "2025-08-18"
scraped_at: "2026-03-02T09:29:49.271087465+00:00"
language: "en-zh"
translated: true
description: "Run up to 2000 sandboxes at the same time. Sandbox also now supports listening on up to 4 different ports"
---
&#123;% raw %}

Aug 18, 2025

2025 年 8 月 18 日

Pro 和 Enterprise 团队现在可同时运行最多 2,000 个 [Vercel Sandboxes](https://vercel.com/docs/vercel-sandbox)（此前上限为 150 个），且每个 Sandbox 现在最多可暴露 4 个端口以供外部访问。

这使得在处理不受信任的代码执行、批处理任务和自动化测试等工作负载时，能够更好地应对更大的流量激增；同时也支持运行更复杂的应用——例如包含多个服务或协议并行运行的应用。

```tsx
import { Sandbox } from '@vercel/sandbox';



const sandbox = await Sandbox.create({

4  ports: [3000, 3001, 3002, 3003]

5});



const urlA = sandbox.domain(3000);
```

```markdown
console.log(sandbox.routes);

console.log(sandbox.routes);

11// A sample of what the above console.log would return

11// 上述 console.log 输出内容的示例

12// [\
\
12// [\
\
13//   {\
\
13//   {\
\
14//     url: 'https://sb-p0oybyhzzl2u.vercel.run',\
\
14//     url: 'https://sb-p0oybyhzzl2u.vercel.run',\
\
15//     subdomain: 'sb-p0oybyhzzl2u',\
\
15//     subdomain: 'sb-p0oybyhzzl2u',\
\
16//     port: 3000\
\
16//     port: 3000\
\
17//   },\
\
17//   },\
\
18//   {\
\
18//   {\
\
19//     url: 'https://sb-3erkpotk6i6h.vercel.run',\
\
19//     url: 'https://sb-3erkpotk6i6h.vercel.run',\
\
20//     subdomain: 'sb-3erkpotk6i6h',\
\
20//     subdomain: 'sb-3erkpotk6i6h',\
\
21//     port: 3001\
\
21//     port: 3001\
\
22//   },\
\
22//   },\
\
23//   ...\
\
23//   ...\
\
24// ]
```

```
```

If you need a higher amount of concurrent sandboxes, you can [contact our sales team](https://vercel.com/contact/sales) to explore higher limits for your projects.

如果您需要支持更高数量的并发沙盒环境，可[联系我们的销售团队](https://vercel.com/contact/sales)，为您的项目探讨更高的配额限制。

Learn more in the [Vercel Sandbox docs](https://vercel.com/docs/vercel-sandbox).

更多详情，请参阅 [Vercel Sandbox 文档](https://vercel.com/docs/vercel-sandbox)。
&#123;% endraw %}
