---
render_with_liquid: false
title: "Node.js Vercel Functions now support fetch web handlers - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/node-js-vercel-functions-now-support-fetch-web-handlers"
date: "2025-08-19"
scraped_at: "2026-03-02T09:29:42.687160487+00:00"
language: "en-zh"
translated: true
description: "Vercel Functions running on the Node.js runtime now support fetch web handlers to enhance interoperability across runtimes and frameworks."
---
render_with_liquid: false
render_with_liquid: false

Aug 19, 2025

2025 年 8 月 19 日

在 Node.js 运行时上运行的 Vercel Functions 现在支持 `fetch` Web 处理器，从而提升了跨 JavaScript 运行时和框架的互操作性。

```tsx
export default {

2  fetch(request: Request) {

3    return new Response('Hello from Vercel!');

4  }

5};
```

如您偏好，仍可[导出独立的 HTTP 方法](https://vercel.com/docs/functions/functions-api-reference?framework=other#function-signature)。

有关 [fetch Web 处理器](https://vercel.com/docs/functions/functions-api-reference?framework=other#fetch-web-standard) 的更多信息，请参阅[文档](https://vercel.com/docs/functions/functions-api-reference?framework=other#fetch-web-standard)。