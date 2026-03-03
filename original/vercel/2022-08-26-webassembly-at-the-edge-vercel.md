---
title: "WebAssembly at the Edge - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-support-for-webassembly-at-the-edge"
date: "2022-08-26"
scraped_at: "2026-03-02T10:00:52.821550902+00:00"
language: "en"
translated: false
description: "Leverage Vercel Edge Functions with any Wasm-compatible language"
---




Aug 26, 2022

Infrastructure-native Wasm for faster performance of computationally heavy workloads

We've been working to make it easier for every developer to build at the Edge, without complicated setup or changes to their workflow. Now, with support for WebAssembly in Vercel Edge Functions, we've made it possible to compile and run Vercel Edge Functions with languages like Rust, Go, C, and more.

[WebAssembly (Wasm)](https://webassembly.org/) is a low-level language similar to Assembly. It’s commonly supported by JavaScript virtual machines like [V8](https://v8.dev/docs/wasm-compilation-pipeline), the engine behind our [open-source Edge Runtime](https://edge-runtime.vercel.app/), and acts as a compilation target for many programming languages. By supporting Wasm at the Edge, _any_ language that can compile to Wasm can now take advantage of [Vercel’s Edge Functions](https://vercel.com/features/edge-functions).

### Run more languages on the Edge

WebAssembly lets you take an existing library written in a different language — for example, libpng, which generates PNG images and is written in C, or [maybe even PHP](https://twitter.com/rauchg/status/1557036448712237056?s=20&t=mLOhbLsW2bKC8OslipO4FQ) — and use that directly in Edge Functions.

If you’re using serverless functions today because your code has a dependency on some C or Rust code, by recompiling that to Wasm, you may be able to move that to Edge Functions.

This functionality is especially helpful for things like encoding and decoding binary data, which often performs bitwise manipulations on integers. Bitshifting and XORs are fairly natural to write in a language that uses C-like semantics. Take this line of code from the [splitmix 32 PRNG](https://gee.cs.oswego.edu/dl/papers/oopsla14.pdf):

```javascript
z = (z ^ (z >> 16)) * 0x85ebca6b;
```

Line of code from the splitmix32 PRNG

Although this is also valid JavaScript code, because of the way JavaScript handles arithmetic, it has a completely different result. JavaScript requires workarounds like [Math.imul](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/imul) and the unsigned right shift operator ( [>>>](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Unsigned_right_shift)) to operate on unsigned 32 bit integers.

```javascript
z = Math.imul((z ^ (z >>> 16)), 0x85ebca6b);
```

JavaScript often requires workarounds for arithmetic

Both languages let you achieve the same results, however, you have to go out of your way to use the special JavaScript functions and operators, and _not_ using them leads to subtle bugs.

WebAssembly lets you write idiomatic code in the language of your choice and run it on the Edge.

### Faster execution with WebAssembly

Finally, using WebAssembly is often faster than the same code in JavaScript. Although our Edge Network is carefully optimized for running JavaScript, WebAssembly will still be 2-3 times faster for computationally heavy workloads. And with SIMD extensions, a compiler may be able to optimize your arithmetic even more.

![In this example, a JavaScript and C edge function (compiled in Wasm) run via brute force to solve a maze. For each solve, an SVG is created and the maze updated.](images/webassembly-at-the-edge-vercel/img_001.jpg)![In this example, a JavaScript and C edge function (compiled in Wasm) run via brute force to solve a maze. For each solve, an SVG is created and the maze updated.](images/webassembly-at-the-edge-vercel/img_002.jpg)In this example, a JavaScript and C edge function (compiled in Wasm) run via brute force to solve a maze. For each solve, an SVG is created and the maze updated.

This [example maze-solving application](https://wasm-on-the-edge.vercel.app/) creates a maze and brute forces a solution using the “right-hand rule” both in JavaScript and C compiled to WebAssembly. The WebAssembly version is more than twice as fast. This shows that for some use cases, like tight loops and computationally heavy code, WebAssembly is usually the fastest way to run in Vercel Edge Functions.

### Getting started

If you want to learn more about WebAssembly in the Vercel Edge Functions, check out the [documentation](https://vercel.com/docs/concepts/edge-network/wasm), and our [examples](https://github.com/vercel/examples/tree/main/edge-api-routes).