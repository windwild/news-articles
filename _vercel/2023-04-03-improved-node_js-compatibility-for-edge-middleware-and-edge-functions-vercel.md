---
render_with_liquid: false
title: "Improved Node.js compatibility for Edge Middleware and Edge Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/improved-node-js-compatibility-for-edge-middleware-and-edge-functions"
date: "2023-04-03"
scraped_at: "2026-03-02T09:53:48.664776212+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Apr 3, 2023

2023年4月3日

![](images/improved-node_js-compatibility-for-edge-middleware-and-edge-functions-vercel/img_001.jpg)

Vercel [Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware)（边缘中间件）和 [Edge Functions](https://vercel.com/docs/concepts/functions/edge-functions/quickstart)（边缘函数）现已支持更多 Node.js 模块。您可能希望直接使用这些模块，但其中许多底层 [API](https://vercel.com/docs/concepts/functions/edge-functions/edge-runtime) 实际上是核心功能组件，其他模块正依赖于它们。为这些 API 增加支持，显著提升了现有 npm 包的兼容性。

```javascript
export default function (request: Request) {

2  const url = new URL(request.url);

3  const message = url.searchParams.get("message") ?? '';

4  return Response.json({

5    decoded: Buffer.from(message, "base64").toString(),

6    message,

7  });
```

8}



export const config = {

11  runtime: "edge",

12};
```

8}



export const config = {

11  runtime: "edge",

12};
```

Edge Function using Buffer global

使用全局 Buffer 的 Edge Function

The following APIs are now supported:

以下 API 现已支持：

- **AsyncLocalStorage:** 支持在不同异步执行上下文之间为单次调用维持数据，使您即使在函数处于热态（hot）且模块上下文被保留的情况下，也能将状态传递给上下文。

- **EventEmitter:** 一种灵活的 API，用于构建事件驱动型系统，是 I/O 控制类库与事件发生时处理数据的监听器之间通信的核心基础组件。

- **Buffer:** Node.js 中处理二进制数据最常用的方式，可作为全局对象直接使用，或通过 `buffer` 模块导入。

- **assert:** 一组断言函数，用于验证不变量（invariants）和逻辑规则，对于在 Edge Functions 中显式测试代码路径中必须成立的假设非常有用。

- **util.promisify** 和 **util.callbackify:** 一个辅助函数，用于将基于回调（callback-style）的函数签名转换为返回 `Promise` 的函数；另一个辅助函数则用于将返回 `Promise` 的函数转换为接受回调函数的版本。

- **util.types:** 一组用于验证对象是否属于指定类型的函数。

您可在下一次部署中，在 Edge Middleware 和 Edge Functions 中使用这些额外的 API。如需在 Vercel 上部署 Edge Functions，您可以从 [任意框架](https://vercel.com/docs/concepts/functions/edge-functions/quickstart) 入手，或选用我们的 [Edge Functions 模板](https://vercel.com/templates/edge-functions) 之一。