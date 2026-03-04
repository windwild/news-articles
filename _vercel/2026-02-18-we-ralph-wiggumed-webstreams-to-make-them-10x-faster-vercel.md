---
title: "We Ralph Wiggumed WebStreams to make them 10x faster - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/we-ralph-wiggumed-webstreams-to-make-them-10x-faster"
date: "2026-02-18"
scraped_at: "2026-03-02T09:21:29.531872782+00:00"
language: "en-zh"
translated: true
description: "WebStreams had too much overhead on the server. We built a faster implementation. See how we achieved 10-14x gains in Next.js rendering benchmarks."
---
&#123;% raw %}

Feb 18, 2026

2026 年 2 月 18 日

When we started profiling Next.js server rendering earlier this year, one thing kept showing up in the flamegraphs: WebStreams. Not the application code running inside them, but the streams themselves. The Promise chains, the per-chunk object allocations, the microtask queue hops. After [Theo Browne's server rendering benchmarks](https://vercel.com/blog/fluid-compute-benchmark-results) highlighted how much compute time goes into framework overhead, we started looking at where that time actually goes. A lot of it was in streams.

今年早些时候，当我们开始对 Next.js 的服务端渲染（SSR）进行性能分析时，火焰图（flamegraph）中反复出现一个关键项：WebStreams。这并非指运行于其中的应用代码，而是 WebStreams 本身——包括其内部的 Promise 链、按数据块分配的对象、以及在微任务队列（microtask queue）间的多次跳转。在 [Theo Browne 的服务端渲染基准测试](https://vercel.com/blog/fluid-compute-benchmark-results) 揭示了大量计算时间实际消耗于框架开销之后，我们开始深入探究这些开销究竟流向何处。结果发现，其中很大一部分正落在 WebStreams 上。

Turns out that WebStreams have an [incredibly complete test suite](https://github.com/web-platform-tests/wpt/tree/master/streams), and that makes them a great candidate for doing an AI-based re-implementation in a purely test-driven and benchmark-driven fashion. This post is about the performance work we did, what we learned, and how this work is already making its way into Node.js itself through Matteo Collina's [upstream PR](https://github.com/nodejs/node/pull/61807).

事实证明，WebStreams 拥有 [一套极其完备的测试套件](https://github.com/web-platform-tests/wpt/tree/master/streams)，这使其成为采用 AI 辅助、纯测试驱动（test-driven）与基准驱动（benchmark-driven）方式重构的理想候选对象。本文将介绍我们所开展的性能优化工作、过程中获得的关键认知，以及这项成果如何已通过 Matteo Collina 提交的 [上游 PR](https://github.com/nodejs/node/pull/61807) 开始融入 Node.js 本体。

## The problem

## 问题所在

Node.js has two streaming APIs. The older one (`stream.Readable`, `stream.Writable`, `stream.Transform`) has been around for over a decade and is heavily optimized. Data moves through C++ internals. Backpressure is a boolean. Piping is a single function call.

Node.js 提供两套流式 API。较旧的一套（`stream.Readable`、`stream.Writable`、`stream.Transform`）已存在十余年，且经过深度优化：数据流转经由 C++ 内部实现；背压（backpressure）以布尔值形式表达；管道（piping）仅需一次函数调用即可完成。

The newer one is the WHATWG Streams API: `ReadableStream`, `WritableStream`, `TransformStream`. This is the web standard. It powers `fetch()` response bodies, `CompressionStream`, `TextDecoderStream`, and increasingly, server-side rendering in frameworks like Next.js and React.

较新的是 WHATWG Streams API：`ReadableStream`、`WritableStream` 和 `TransformStream`。这是 Web 标准规范，支撑着 `fetch()` 响应体、`CompressionStream`、`TextDecoderStream` 等功能，并日益成为 Next.js 和 React 等框架服务端渲染（SSR）的核心基础设施。

The web standard is the right API to converge on. But on the server, it is slower than it needs to be.

Web 标准无疑是未来统一 API 的正确方向。但在服务端场景下，其当前实现却远未达到应有的性能水平。

To understand why, consider what happens when you call `reader.read()` on a native WebStream in Node.js. Even if data is already sitting in the buffer:

要理解其性能瓶颈，不妨考察在 Node.js 中对原生 WebStream 调用 `reader.read()` 时的实际行为——即便数据早已存在于缓冲区中：

1. A `ReadableStreamDefaultReadRequest` object is allocated with three callback slots

1. 系统会分配一个 `ReadableStreamDefaultReadRequest` 对象，该对象包含三个回调槽（callback slots）；

2. The request is enqueued into the stream's internal queue

2. 该请求被入队至流的内部队列中。

3. 分配并返回一个新 Promise

4. 解析过程需经过微任务队列（microtask queue）


这意味着：为返回本已存在的数据，需执行四次内存分配，并经历一次微任务跳转。若将这一开销乘以渲染管线中每个变换（transform）所处理的每一个数据块（chunk），累积成本便极为可观。

再来看 `pipeTo()`：每个数据块都要遍历一整条 Promise 链——依次执行读取（read）、写入（write）、检查背压（check backpressure），然后重复。每次 `read()` 都会分配一个 `{value, done}` 结果对象；错误传播还会额外创建 Promise 分支。

以上设计并无错误。这些保障机制在浏览器环境中至关重要：流（streams）可能跨越安全边界，取消语义（cancellation semantics）必须严丝合缝，且管道（pipe）两端往往不由同一方控制。但在服务端场景下——例如，你正以 1KB 数据块为单位，将 React Server Components 经过三层变换进行传输——这些开销便会迅速累积。

我们对原生 WebStream 的 `pipeThrough` 进行了基准测试：在 1KB 数据块下吞吐量为 **630 MB/s**；而使用 Node.js 原生 `pipeline()` 并搭配相同的透传（passthrough）变换，吞吐量达 **约 7,900 MB/s**。二者相差 12 倍，差距几乎完全源于 Promise 和对象分配带来的运行时开销。

## 我们构建了什么

我们正在开发一个名为 `fast-webstreams` 的库，它在内部基于 Node.js Streams 实现了 WHATWG 标准的 `ReadableStream`、`WritableStream` 和 `TransformStream` API。该库提供完全一致的接口、相同的错误传播行为，以及严格符合规范的语义——同时，在常见使用场景下彻底消除了前述开销。

其核心思想是：根据实际执行的操作类型，动态选择不同的高性能路径（fast paths）：

### 当你在“快速流”（fast streams）之间进行管道传输（pipe）时：零 Promise

This is the biggest win. When you chain `pipeThrough` and `pipeTo` between fast streams, the library does not start piping immediately. Instead, it records upstream links:

`source → transform1 → transform2 → ...`

这是最大的优势。当你在高速流之间链式调用 `pipeThrough` 和 `pipeTo` 时，该库并不会立即开始管道传输，而是先记录上游的连接关系：

`source → transform1 → transform2 → ...`

When `pipeTo()` is called at the end of the chain, it walks upstream, collects the underlying Node.js stream objects, and issues a single `pipeline()` call. One function call. Zero Promises per chunk. Data flows through Node's optimized C++ path.

当链式调用末尾调用 `pipeTo()` 时，它会逆向遍历上游，收集底层的 Node.js 流对象，并发起一次 `pipeline()` 调用。仅一次函数调用，每个数据块零 Promise 开销。数据经由 Node.js 高度优化的 C++ 路径流动。

```javascript
const source = new ReadableStream({

2  pull(controller) {

3    controller.enqueue(generateChunk());

4  }

5});



const transform = new TransformStream({

8  transform(chunk, controller) {

8  transform(chunk, controller) {

9    controller.enqueue(process(chunk));

9    controller.enqueue(process(chunk));

10  }

10  }

11});

11});

const sink = new WritableStream({

const sink = new WritableStream({

14  write(chunk) { consume(chunk); }

14  write(chunk) { consume(chunk); }

15});

15});

17// Internally: single pipeline() call, zero promises per chunk

17// 内部实现：仅调用一次 `pipeline()`，每个数据块不产生任何 Promise

```javascript
await source.pipeThrough(transform).pipeTo(sink);
```

The result: **~6,200 MB/s**. That is ~10x faster than native WebStreams and close to raw Node.js pipeline performance.

结果：**约 6,200 MB/s**。该性能约为原生 WebStreams 的 10 倍，接近原始 Node.js 管道（pipeline）的性能。

If any stream in the chain is not a fast stream (say, a native `CompressionStream`), the library falls back to either native `pipeThrough` or a spec-compliant `pipeTo` implementation.

如果链中任一数据流不是“快速流”（例如原生的 `CompressionStream`），该库将自动回退至使用原生 `pipeThrough` 或符合规范的 `pipeTo` 实现。

### When you read chunk by chunk: synchronous resolution

### 逐块读取时：同步解析

When you call `reader.read()`, the library tries `nodeReadable.read()` synchronously. If data is there, you get `Promise.resolve({value, done})`. No event loop round-trip. No request object allocation. Only when the buffer is empty does it register a listener and return a pending Promise.

当你调用 `reader.read()` 时，该库会同步尝试执行 `nodeReadable.read()`。若缓冲区中已有数据，则立即返回 `Promise.resolve({value, done})`；无需事件循环轮询，也无需分配请求对象。仅当缓冲区为空时，才会注册监听器并返回一个处于 pending 状态的 Promise。

```javascript
const reader = stream.getReader();

while (true) {

  const { value, done } = await reader.read();

  if (done) break;

  // When data is buffered, the await resolves immediately
```

6  // via Promise.resolve() — no microtask queue hop

6  // 通过 Promise.resolve() 实现 — 无需微任务队列跳转

7  processChunk(value);

7  processChunk(value);

8}
```

8}
```

The result: **~12,400 MB/s**, or 3.7x faster than native.

结果：**约 12,400 MB/s**，比原生实现快 3.7 倍。

### The React Flight pattern: where the gap is largest

### React Flight 模式：性能差距最显著的场景

This is the one that matters most for Next.js. React Server Components use a specific byte stream pattern: create a `ReadableStream` with `type: 'bytes'`, capture the controller in `start()`, enqueue chunks externally as the render produces them.

这对 Next.js 最为关键。React Server Components 采用一种特定的字节流模式：创建一个 `type: 'bytes'` 的 `ReadableStream`，在 `start()` 中捕获控制器，并在渲染过程中将数据块（chunks）从外部逐个入队（enqueue）。

```javascript
let ctrl;

const stream = new ReadableStream({

3  type: 'bytes',

4  start(c) { ctrl = c; }
```

```javascript
let ctrl;

const stream = new ReadableStream({

3  type: 'bytes',

4  start(c) { ctrl = c; }
```

5});


7// As React renders each component:

ctrl.enqueue(new Uint8Array(payload1));

ctrl.enqueue(new Uint8Array(payload2));

ctrl.close();
```

原生 WebStreams：**约 110 MB/s**。fast-webstreams：**约 1600 MB/s**。在生产环境服务端渲染所采用的完全相同模式下，性能提升达 **14.6 倍**。

这一性能提升源自 `LiteReadable`——我们编写的轻量级、基于数组的缓冲区，用于替代 Node.js 的 `Readable` 类以处理字节流。它采用直接回调分发（而非 EventEmitter），支持基于拉取（pull-based）的流量控制和 BYOB（Bring Your Own Buffer）读取器，且每次构造开销减少约 5 微秒。当 React Flight 每次请求需创建数百个字节流时，这一微小优化便至关重要。

### Fetch 响应体：你无需自行构造的流

上述示例均以 `new ReadableStream(...)` 开始。但在服务端，大多数流并非如此创建——它们源自 `fetch()` 调用。响应体是一个由 Node.js HTTP 层托管的原生字节流，你无法将其替换或接管。

This is a common pattern in server-side rendering: fetch data from an upstream service, pipe the response through one or more transforms, and forward the result to the client.

这是服务端渲染中的一种常见模式：从上游服务获取数据，将响应流经一个或多个转换操作，然后将结果转发给客户端。

```javascript
const upstream = await fetch('<https://api.example.com/data>');



3// Pipe through transforms and forward as a new Response

3// 经由转换操作处理，并作为新的 Response 返回

const transformed = upstream.body

5  .pipeThrough(new TransformStream({ transform(chunk, ctrl) { /* ... */ ctrl.enqueue(chunk); } }))

6  .pipeThrough(new TransformStream({ transform(chunk, ctrl) { /* ... */ ctrl.enqueue(chunk); } }))

7  .pipeThrough(new TransformStream({ transform(chunk, ctrl) { /* ... */ ctrl.enqueue(chunk); } }));



return new Response(transformed);
```

With native WebStreams, each hop in this chain pays the full Promise-per-chunk cost. Three transforms means roughly 6-9 Promises per chunk. At 1KB chunks, that gets you **~260 MB/s**.

使用原生 WebStreams 时，该链路中的每个处理环节都要承担完整的“每数据块一个 Promise”的开销。三次转换意味着每个数据块需创建约 6–9 个 Promise。在 1 KB 数据块大小下，吞吐量约为 **260 MB/s**。

The library handles this through deferred resolution. When `patchGlobalWebStreams()` is active, `Response.prototype.body` returns a lightweight fast shell wrapping the native byte stream. Calling `pipeThrough()` does not start piping immediately. It just records the link. Only when `pipeTo()` or `getReader()` is called at the end does the library resolve the full chain: it creates a single bridge from the native reader into Node.js `pipeline()` for the transform hops, then serves reads from the buffered output synchronously.

该库通过延迟解析（deferred resolution）来应对这一问题。当启用 `patchGlobalWebStreams()` 后，`Response.prototype.body` 将返回一个轻量、快速的外壳（shell），包裹原生字节流。调用 `pipeThrough()` 并不会立即启动数据流转，而仅记录转换链路；只有当链路末端调用 `pipeTo()` 或 `getReader()` 时，库才真正解析整条链路：它构建一条从原生 `ReadableStream` 的 reader 到 Node.js `pipeline()` 的单一桥接通道，用于执行各转换步骤，并随后以同步方式从缓冲输出中提供读取服务。

The cost model: one Promise at the native boundary to pull data in. Zero Promises through the transform chain. Sync reads at the output.

开销模型如下：仅在原生边界处为拉取数据创建 **1 个 Promise**；整个转换链路中 **零 Promise 开销**；输出端读取为 **同步操作**。

The result: **~830 MB/s**, or **3.2x faster** than native for the three-transform fetch pattern. For simple response forwarding without transforms, it is **2.0x faster** (850 vs 430 MB/s).

最终结果：吞吐量达 **~830 MB/s**，在含三次转换的 fetch 场景下，比原生 WebStreams 快 **3.2 倍**；而在无需转换、仅简单转发响应的场景下，则快 **2.0 倍**（850 MB/s 对比 430 MB/s）。

## Benchmarks

## 基准测试

All numbers are throughput in MB/s at 1KB chunks on Node.js v22. Higher is better.

所有数据均基于 Node.js v22，在 1 KB 数据块大小下的吞吐量（单位：MB/s）。数值越高越好。

### Core operations

### 核心操作

|     |     |     |     |     |
| --- | --- | --- | --- | --- |
| Operation | Node.js streams | fast | native | fast vs native |
| 操作 | Node.js 流 | fast（本库） | 原生 WebStreams | fast 相比 native 的加速比 |
| read loop | 26,400 | **12,400** | 3,300 | **3.7x** |
| write loop | 26,500 | **5,500** | 2,300 | **2.4x** |
| pipeThrough | 7,900 | **6,200** | 630 | **9.8x** |
| pipeTo | 14,000 | **2,500** | 1,400 | **1.8x** |
| for-await-of | — | **4,100** | 3,000 | **1.4x** |

### Transform chains

### 转换链路（Transform Chains）

The Promise-per-chunk overhead compounds with chain depth:

“每数据块一个 Promise”的开销随转换链深度增加而呈复合式增长：

|     |     |     |     |
| --- | --- | --- | --- |
| Depth | fast | native | fast vs native |
| 深度 | fast | 原生 | fast 相比原生 |
| 3 transforms | **2,900** | 300 | **9.7x** |
| 3 次转换 | **2,900** | 300 | **9.7 倍** |
| 8 transforms | **1,000** | 115 | **8.7x** |
| 8 次转换 | **1,000** | 115 | **8.7 倍** |

### Byte streams

### 字节流

|     |     |     |     |
| --- | --- | --- | --- |
| Pattern | fast | native | fast vs native |
| 模式 | fast | 原生 | fast 相比原生 |
| start + enqueue (React Flight) | **1,600** | 110 | **14.6x** |
| start + enqueue（React Flight） | **1,600** | 110 | **14.6 倍** |
| byte read loop | **1,400** | 1,400 | 1.0x |
| 字节读取循环 | **1,400** | 1,400 | 1.0 倍 |
| byte tee | **1,200** | 750 | **1.6x** |
| 字节分流（byte tee） | **1,200** | 750 | **1.6 倍** |

### Response body patterns

### 响应体模式

|     |     |     |     |
| --- | --- | --- | --- |
| Pattern | fast | native | fast vs native |
| 模式 | fast | 原生 | fast 相比原生 |
| Response.text() | 900 | 910 | 1.0x |
| Response.text() | 900 | 910 | 1.0 倍 |
| Response forwarding | **850** | 430 | **2.0x** |
| 响应转发 | **850** | 430 | **2.0 倍** |
| fetch → 3 transforms | **830** | 260 | **3.2x** |
| fetch → 3 次转换 | **830** | 260 | **3.2 倍** |

### Stream construction

### 流的构建

Creating streams is also faster, which matters for short-lived streams:

流的创建速度也更快，这对生命周期较短的流尤为重要：

|     |     |     |     |
| --- | --- | --- | --- |
| Type | fast | native | fast vs native |
| 类型 | fast | 原生 | fast 相比原生 |
| ReadableStream | **2,100** | 980 | **2.1x** |
| ReadableStream | **2,100** | 980 | **2.1 倍** |
| WritableStream | **1,300** | 440 | **3.0x** |
| WritableStream | **1,300** | 440 | **3.0 倍** |
| TransformStream | **470** | 220 | **2.1x** |
| TransformStream | **470** | 220 | **2.1 倍** |

## Spec compliance

## 规范兼容性

fast-webstreams passes **1,100 out of 1,116** Web Platform Tests. Node.js's native implementation passes 1,099. The 16 failures that remain are either shared with native (like the unimplemented `type: 'owning'` transfer mode) or are architectural differences that do not affect real applications.

fast-webstreams 通过了 **1,116 项 Web 平台测试中的 1,100 项**。Node.js 的原生实现通过了 1,099 项。剩余的 16 项失败用例，要么与原生实现共有的缺陷（例如尚未实现的 `type: 'owning'` 传输模式），要么是不影响实际应用的架构层面差异。

## How we are deploying this

## 我们如何部署此功能

The library can patch the global `ReadableStream`, `WritableStream`, and `TransformStream` constructors:

该库可修补全局的 `ReadableStream`、`WritableStream` 和 `TransformStream` 构造函数：

```javascript
import { patchGlobalWebStreams } from 'fast-webstreams';



patchGlobalWebStreams();

4// globalThis.ReadableStream is now the fast implementation

5// fetch() response bodies are automatically wrapped

6// All downstream pipeThrough/pipeTo use fast paths
```

```javascript
import { patchGlobalWebStreams } from 'fast-webstreams';



patchGlobalWebStreams();

4// globalThis.ReadableStream 现在是高性能实现

5// fetch() 响应体将被自动封装

6// 所有下游的 pipeThrough()/pipeTo() 调用均走高性能路径
```

The patch also intercepts `Response.prototype.body` to wrap native fetch response bodies in fast stream shells, so `fetch()` → `pipeThrough()` → `pipeTo()` chains hit the pipeline fast path automatically.

该补丁还会拦截 `Response.prototype.body`，将原生 fetch 响应体封装进高性能流外壳中，从而使 `fetch()` → `pipeThrough()` → `pipeTo()` 链式调用自动进入流管道的高性能路径。

At Vercel, we are looking at rolling this out across our fleet. We will do so carefully and incrementally. Streaming primitives sit at the foundation of request handling, response rendering, and compression. We are starting with the patterns where the gap is largest: React Server Component streaming, response body forwarding, and multi-transform chains. We will measure in production before expanding further.

在 Vercel，我们正计划将此功能逐步推广至整个基础设施集群。我们将谨慎、渐进地推进部署。流式基础原语（streaming primitives）是请求处理、响应渲染与压缩功能的底层基石。我们优先从性能差距最显著的场景入手：React Server Component 流式传输、响应体转发，以及多级转换链（multi-transform chains）。在进一步扩大应用范围前，我们将在生产环境中进行实测评估。

## The right fix is upstream

## 正确的修复应在上游

A userland library should not be the long-term answer here. The right fix is in Node.js itself.

用户态库不应成为此处的长期解决方案。正确的修复应实现在 Node.js 本身中。

Work is already happening. After a conversation on X, Matteo Collina submitted [nodejs/node#61807](https://github.com/nodejs/node/pull/61807), "stream: add fast paths for webstreams read and pipeTo." The PR applies two ideas from this project directly to Node.js's native WebStreams:

相关工作已在进行中。在 X（原 Twitter）上的一次讨论之后，Matteo Collina 提交了 [nodejs/node#61807](https://github.com/nodejs/node/pull/61807)，标题为“stream: add fast paths for webstreams read and pipeTo”（流：为 WebStreams 的 `read()` 和 `pipeTo()` 添加快速路径）。该 PR 直接将本项目中的两项优化思路应用到了 Node.js 原生 WebStreams 实现中：

1. **`read()`** **fast path**: When data is already buffered, return a resolved Promise directly without creating a `ReadableStreamDefaultReadRequest` object. This is spec-compliant because `read()` returns a Promise either way, and resolved promises still run callbacks in the microtask queue.

1. **`read()` 的快速路径**：当数据已处于缓冲状态时，直接返回一个已兑现（resolved）的 Promise，而无需创建 `ReadableStreamDefaultReadRequest` 对象。该做法符合规范，因为无论是否缓冲，`read()` 均返回 Promise；且已兑现的 Promise 仍会在微任务队列中执行其回调函数。

2. **`pipeTo()`** **batch reads**: When data is buffered, batch multiple reads from the controller queue without creating per-chunk request objects. Backpressure is respected by checking `desiredSize` after each write.

2. **`pipeTo()` 的批量读取**：当数据已缓冲时，从控制器队列中批量读取多块数据，避免为每个数据块单独创建请求对象。每次写入后检查 `desiredSize`，以确保背压机制得到尊重。

The PR shows **~17–20% faster** buffered reads and **~11% faster** `pipeTo`. These improvements benefit every Node.js user for free. No library to install, no patching, no risk.

该 PR 展示了缓冲读取速度提升约 **17–20%**，`pipeTo` 性能提升约 **11%**。这些改进将免费惠及所有 Node.js 用户——无需安装任何库、无需打补丁、零风险。

James Snell's [Node.js performance issue #134](https://github.com/nodejs/performance/issues/134) outlines several additional opportunities: C++-level piping for internally-sourced streams, lazy buffering, eliminating double-buffering in WritableStream adapters. Each of these could close the gap further.

James Snell 在 [Node.js 性能问题 #134](https://github.com/nodejs/performance/issues/134) 中指出了若干进一步优化方向：针对内部源流（internally-sourced streams）实现 C++ 层级的管道传输、惰性缓冲（lazy buffering）、消除 WritableStream 适配器中的双重缓冲（double-buffering）。每一项都可进一步缩小性能差距。

We will keep contributing ideas upstream. The goal is not for fast-webstreams to exist forever. The goal is for WebStreams to be fast enough that it does not need to.

我们将持续向上游贡献优化思路。我们的目标并非让 `fast-webstreams` 永久存在；我们的目标是让 WebStreams 本身足够快，从而不再需要它。

## What we learned the hard way

## 我们付出代价才学到的经验

**The spec is smarter than it looks.**  
**规范比它看上去更聪明。**

We tried many shortcuts. Almost every one of them broke a Web Platform Test, and the test was usually right. The `ReadableStreamDefaultReadRequest` pattern, the Promise-per-read design, the careful error propagation: they exist because cancellation during reads, error identity through locked streams, and thenable interception are real edge cases that real code hits.  
我们尝试过许多捷径，但几乎每一条都导致某个 Web 平台测试（WPT）失败，而该测试通常是对的。`ReadableStreamDefaultReadRequest` 模式、每次读取返回一个 Promise 的设计、以及谨慎的错误传播机制——这些都源于真实代码中确实会遇到的边界情况：读取过程中的取消操作、通过锁定流保持错误身份一致性、以及对 *thenable* 对象的拦截。

**`Promise.resolve(obj)`** **always checks for thenables.**  
**`Promise.resolve(obj)` 总是检查对象是否为 thenable。**

This is a language-level behavior you cannot avoid. If the object you resolve with has a `.then` property, the Promise machinery will call it. Some WPT tests deliberately put `.then` on read results and verify that the stream handles it correctly. We had to be very careful about where `{value, done}` objects get created in hot paths.  
这是 JavaScript 语言层面的行为，无法规避。如果你传入 `Promise.resolve()` 的对象具有 `.then` 属性，Promise 内部机制就会调用它。一些 WPT 测试会刻意在读取结果上添加 `.then` 属性，并验证流能否正确处理。因此，我们必须格外谨慎地控制 `{value, done}` 对象在性能关键路径（hot paths）中的创建位置。

**Node.js** **`pipeline()`** **cannot replace WHATWG** **`pipeTo`** **.**  
**Node.js 的 `pipeline()` 无法替代 WHATWG 的 `pipeTo`。**

We hoped to use `pipeline()` for all piping. It causes 72 WPT failures. The error propagation, stream locking, and cancellation semantics are fundamentally different. `pipeline()` is only safe when we control the entire chain, which is why we collect upstream links and only use it for full fast-stream chains.  
我们曾希望将 `pipeline()` 用于所有管道操作，但它引发了 72 个 WPT 失败。其错误传播、流锁定及取消语义与 WHATWG `pipeTo` 存在根本性差异。`pipeline()` 仅在我们完全掌控整个数据链时才是安全的；正因如此，我们收集上游链接，并仅将其用于完整的 fast-stream 链路。

**`Reflect.apply`** **, not** **`.call()`** **.**  
**应使用 `Reflect.apply`，而非 `.call()`。**

The WPT suite monkey-patches `Function.prototype.call` and verifies that implementations do not use it to invoke user-provided callbacks. `Reflect.apply` is the only safe way. This is a real spec requirement.  
WPT 套件会对 `Function.prototype.call` 进行动态打补丁（monkey-patch），并验证实现是否未使用它来调用用户提供的回调函数。`Reflect.apply` 是唯一安全的方式。这是一项真实的规范要求。

## We built most of fast-webstreams with AI  
## 我们借助 AI 实现了 fast-webstreams 的大部分功能

Two things made that viable:  
两项关键因素使这一做法成为可能：

The amazing [Web Platform Tests](https://web-platform-tests.org/) gave us 1,116 tests as an immediate, machine-checkable answer to "did we break anything?" And we built a benchmark suite early on so we could measure whether each change actually moved throughput. The development loop was: implement an optimization, run the WPT suite, run benchmarks. When tests broke, we knew which spec invariant we had violated. When benchmarks did not move, we reverted.  
卓越的 [Web 平台测试（WPT）](https://web-platform-tests.org/) 为我们提供了 1,116 个测试用例，可立即、自动地回答“我们是否破坏了任何功能？”；同时，我们早期便构建了一套基准测试套件，以量化评估每一项变更是否真正提升了吞吐量。开发闭环为：实现一项优化 → 运行 WPT 套件 → 运行基准测试。当测试失败时，我们能立刻定位所违反的规范不变量；当基准测试未显示性能提升时，我们即刻回退。

The WHATWG Streams spec is long and dense. The interesting optimization opportunities sit in the gap between what the spec _requires_ and what current implementations _do_. `read()` must return a Promise, but nothing says that Promise cannot already be resolved when data is buffered. That kind of observation is straightforward when you can ask an AI to analyze algorithm steps for places where the observable behavior can be preserved with fewer allocations.  
WHATWG Streams 规范篇幅冗长、内容密集。真正有潜力的优化机会，往往存在于规范 *明确要求* 与当前实现 *实际行为* 之间的间隙之中。例如，`read()` 方法必须返回一个 Promise，但规范并未禁止该 Promise 在数据已缓冲就绪时直接处于已解决（resolved）状态。这类洞察，在你能借助 AI 分析算法步骤、识别出哪些环节可在减少内存分配的同时保持可观测行为不变时，便变得非常直观。

## Try it  
## 立即试用

fast-webstreams is [available on npm](https://www.npmjs.com/package/experimental-fast-webstreams) as `experimental-fast-webstreams`. The "experimental" prefix is intentional. We are confident in correctness, but this is an area of active development.  
fast-webstreams 已作为 [`experimental-fast-webstreams`](https://www.npmjs.com/package/experimental-fast-webstreams) 发布于 npm。其中 “experimental”（实验性）前缀是刻意为之：我们对其正确性充满信心，但该领域仍在持续演进中。

If you are building a server-side JavaScript framework or runtime and hitting WebStreams performance limits, we would love to hear from you.  

如果您正在构建服务端 JavaScript 框架或运行时，却遇到了 WebStreams 的性能瓶颈，我们非常期待听到您的反馈。

And if you are interested in improving WebStreams in Node.js itself, Matteo's [PR](https://github.com/nodejs/node/pull/61807) is a great place to start.  

如果您有兴趣改进 Node.js 自身的 WebStreams 实现，Matteo 的这个 [PR](https://github.com/nodejs/node/pull/61807) 是一个绝佳的入手点。
&#123;% endraw %}
