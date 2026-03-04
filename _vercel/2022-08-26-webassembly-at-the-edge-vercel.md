---
render_with_liquid: false
title: "WebAssembly at the Edge - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-support-for-webassembly-at-the-edge"
date: "2022-08-26"
scraped_at: "2026-03-02T10:00:52.821550902+00:00"
language: "en-zh"
translated: true
description: "Leverage Vercel Edge Functions with any Wasm-compatible language"
---
render_with_liquid: false
render_with_liquid: false

Aug 26, 2022

2022年8月26日

Infrastructure-native Wasm for faster performance of computationally heavy workloads

面向基础设施原生的 WebAssembly（Wasm），为计算密集型工作负载提供更优性能

We've been working to make it easier for every developer to build at the Edge, without complicated setup or changes to their workflow. Now, with support for WebAssembly in Vercel Edge Functions, we've made it possible to compile and run Vercel Edge Functions with languages like Rust, Go, C, and more.

我们一直致力于让每位开发者都能更轻松地在边缘（Edge）构建应用，无需复杂的配置，也无需更改现有开发流程。如今，随着 Vercel 边缘函数（Edge Functions）正式支持 WebAssembly（Wasm），开发者 now 可以使用 Rust、Go、C 等多种语言来编译并运行 Vercel 边缘函数。

[WebAssembly (Wasm)](https://webassembly.org/) is a low-level language similar to Assembly. It’s commonly supported by JavaScript virtual machines like [V8](https://v8.dev/docs/wasm-compilation-pipeline), the engine behind our [open-source Edge Runtime](https://edge-runtime.vercel.app/), and acts as a compilation target for many programming languages. By supporting Wasm at the Edge, _any_ language that can compile to Wasm can now take advantage of [Vercel’s Edge Functions](https://vercel.com/features/edge-functions).

[WebAssembly（Wasm）](https://webassembly.org/) 是一种类似汇编语言的底层语言。它被主流 JavaScript 虚拟机（如 [V8](https://v8.dev/docs/wasm-compilation-pipeline)）广泛支持——而 V8 正是我们 [开源边缘运行时（Edge Runtime）](https://edge-runtime.vercel.app/) 的核心引擎。Wasm 同时也是众多编程语言的通用编译目标。通过在边缘端支持 Wasm，**任何能编译为 Wasm 的语言**，现在均可充分利用 [Vercel 的边缘函数（Edge Functions）](https://vercel.com/features/edge-functions)。

### Run more languages on the Edge

### 在边缘端运行更多编程语言

WebAssembly lets you take an existing library written in a different language — for example, libpng, which generates PNG images and is written in C, or [maybe even PHP](https://twitter.com/rauchg/status/1557036448712237056?s=20&t=mLOhbLsW2bKC8OslipO4FQ) — and use that directly in Edge Functions.

借助 WebAssembly，你可以直接复用其他语言编写的现有库——例如用 C 编写的图像生成库 libpng，甚至 [可能还包括 PHP](https://twitter.com/rauchg/status/1557036448712237056?s=20&t=mLOhbLsW2bKC8OslipO4FQ)——并将它们无缝集成至边缘函数中。

If you’re using serverless functions today because your code has a dependency on some C or Rust code, by recompiling that to Wasm, you may be able to move that to Edge Functions.

如果你当前使用无服务器函数（serverless functions）的原因是代码依赖于某些 C 或 Rust 编写的模块，那么只需将这些模块重新编译为 Wasm，就有可能将其迁移至边缘函数中。

This functionality is especially helpful for things like encoding and decoding binary data, which often performs bitwise manipulations on integers. Bitshifting and XORs are fairly natural to write in a language that uses C-like semantics. Take this line of code from the [splitmix 32 PRNG](https://gee.cs.oswego.edu/dl/papers/oopsla14.pdf):

这一功能对于二进制数据的编解码等场景尤为实用——这类任务通常涉及对整数执行位运算操作。位移（bitshifting）与异或（XOR）等操作，在具备 C 类语义的语言中编写起来非常自然。以下摘自 [splitmix32 伪随机数生成器（PRNG）](https://gee.cs.oswego.edu/dl/papers/oopsla14.pdf) 的一行代码为例：

```javascript
z = (z ^ (z >> 16)) * 0x85ebca6b;
```

```javascript
z = (z ^ (z >> 16)) * 0x85ebca6b;
```

Line of code from the splitmix32 PRNG

splitmix32 伪随机数生成器中的一行代码

Although this is also valid JavaScript code, because of the way JavaScript handles arithmetic, it has a completely different result. JavaScript requires workarounds like [Math.imul](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/imul) and the unsigned right shift operator ( [>>>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Unsigned_right_shift)) to operate on unsigned 32 bit integers.

虽然这段代码在 JavaScript 中同样语法有效，但由于 JavaScript 处理算术运算的方式，其执行结果却截然不同。JavaScript 需要借助诸如 [Math.imul](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Math/imul) 和无符号右移运算符（[>>>](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/Unsigned_right_shift)）等变通方法，才能对无符号 32 位整数进行正确运算。

```javascript
z = Math.imul((z ^ (z >>> 16)), 0x85ebca6b);
```

```javascript
z = Math.imul((z ^ (z >>> 16)), 0x85ebca6b);
```

JavaScript often requires workarounds for arithmetic

JavaScript 在算术运算中常常需要此类变通方案。

Both languages let you achieve the same results, however, you have to go out of your way to use the special JavaScript functions and operators, and _not_ using them leads to subtle bugs.

两种语言都能实现相同的结果；但若想在 JavaScript 中达成目标，你必须刻意调用这些特殊函数和运算符——而一旦忽略它们，就极易引发难以察觉的 bug。

WebAssembly lets you write idiomatic code in the language of your choice and run it on the Edge.

WebAssembly 允许你以自己熟悉的语言编写符合该语言习惯的惯用代码，并直接在边缘（Edge）环境中运行。

### Faster execution with WebAssembly

### 借助 WebAssembly 实现更快执行

Finally, using WebAssembly is often faster than the same code in JavaScript. Although our Edge Network is carefully optimized for running JavaScript, WebAssembly will still be 2-3 times faster for computationally heavy workloads. And with SIMD extensions, a compiler may be able to optimize your arithmetic even more.

最后，使用 WebAssembly 通常比同等功能的 JavaScript 代码执行得更快。尽管我们的边缘网络（Edge Network）已针对 JavaScript 运行进行了精心优化，但对于计算密集型任务，WebAssembly 的性能仍可达到 JavaScript 的 2–3 倍。此外，借助 SIMD（单指令多数据）扩展，编译器甚至能进一步优化你的算术运算。

![In this example, a JavaScript and C edge function (compiled in Wasm) run via brute force to solve a maze. For each solve, an SVG is created and the maze updated.](images/webassembly-at-the-edge-vercel/img_001.jpg)![In this example, a JavaScript and C edge function (compiled in Wasm) run via brute force to solve a maze. For each solve, an SVG is created and the maze updated.](images/webassembly-at-the-edge-vercel/img_002.jpg)In this example, a JavaScript and C edge function (compiled in Wasm) run via brute force to solve a maze. For each solve, an SVG is created and the maze updated.

![本例中，一个 JavaScript 边缘函数与一个用 C 编写并编译为 Wasm 的边缘函数，均通过暴力搜索法求解迷宫。每次求解后，都会生成一张 SVG 图像并更新迷宫状态。](images/webassembly-at-the-edge-vercel/img_001.jpg)![本例中，一个 JavaScript 边缘函数与一个用 C 编写并编译为 Wasm 的边缘函数，均通过暴力搜索法求解迷宫。每次求解后，都会生成一张 SVG 图像并更新迷宫状态。](images/webassembly-at-the-edge-vercel/img_002.jpg)本例中，一个 JavaScript 边缘函数与一个用 C 编写并编译为 Wasm 的边缘函数，均通过暴力搜索法求解迷宫。每次求解后，都会生成一张 SVG 图像并更新迷宫状态。

This [example maze-solving application](https://wasm-on-the-edge.vercel.app/) creates a maze and brute forces a solution using the “right-hand rule” both in JavaScript and C compiled to WebAssembly. The WebAssembly version is more than twice as fast. This shows that for some use cases, like tight loops and computationally heavy code, WebAssembly is usually the fastest way to run in Vercel Edge Functions.

这个 [迷宫求解示例应用](https://wasm-on-the-edge.vercel.app/) 会生成一个迷宫，并分别使用 JavaScript 和编译为 WebAssembly 的 C 语言，通过“右手规则”进行暴力搜索求解。WebAssembly 版本的执行速度超过 JavaScript 版本的两倍。这表明：对于某些特定场景（例如紧密循环和计算密集型代码），WebAssembly 通常是 Vercel 边缘函数（Edge Functions）中最高效的运行方式。

### Getting started

### 快速入门

If you want to learn more about WebAssembly in the Vercel Edge Functions, check out the [documentation](https://vercel.com/docs/concepts/edge-network/wasm), and our [examples](https://github.com/vercel/examples/tree/main/edge-api-routes).

如需进一步了解 Vercel 边缘函数（Edge Functions）中的 WebAssembly，请参阅[文档](https://vercel.com/docs/concepts/edge-network/wasm)以及我们的[示例](https://github.com/vercel/examples/tree/main/edge-api-routes)。