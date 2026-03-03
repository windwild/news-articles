---
title: "Preventing the stampede: Request collapsing in the Vercel CDN  - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/cdn-request-collapsing"
date: "2025-09-25"
scraped_at: "2026-03-02T09:28:03.682858534+00:00"
language: "en-zh"
translated: true
description: "The Vercel CDN now supports request collapsing for ISR routes. For a given path, only one function invocation per region runs at once, no matter how many concurrent requests arrive."
---

Sep 25, 2025

2025 年 9 月 25 日

When you deploy a Next.js app with [Incremental Static Regeneration](https://vercel.com/docs/incremental-static-regeneration) (ISR), pages get regenerated on-demand after their cache expires. ISR lets you get the performance benefits of static generation while keeping your content fresh.

当您使用 [增量静态再生（ISR）](https://vercel.com/docs/incremental-static-regeneration) 部署 Next.js 应用时，页面将在其缓存过期后按需重新生成。ISR 让您既能享受静态生成的性能优势，又能确保内容始终最新。

But there's a problem. When many users request the same ISR route at once and the cache is expired, each request can trigger its own function invocation. This is called a "cache stampede." It wastes compute, overloads your backend, and can cause downtime.

但存在一个问题：当大量用户同时请求同一个已过期缓存的 ISR 路由时，每个请求都可能触发一次独立的函数调用。这种现象被称为“缓存雪崩（cache stampede）”。它会浪费计算资源、压垮您的后端服务，甚至导致服务中断。

The Vercel CDN now prevents this with [request collapsing](https://vercel.com/docs/request-collapsing). When multiple requests hit the same uncached path, only one request per region invokes a function. The rest wait and get the cached response.

Vercel CDN 现已通过 [请求合并（request collapsing）](https://vercel.com/docs/request-collapsing) 防止此类问题。当多个请求同时命中同一未缓存路径时，每个区域仅有一个请求会触发函数执行；其余请求将等待，并直接获取该函数生成的缓存响应。

Vercel automatically infers cacheability for each request through framework-defined infrastructure, configuring our globally distributed router. No manual configuration needed.

Vercel 通过框架定义的基础设施，自动推断每个请求的可缓存性，并据此配置我们全球分布的路由器。无需任何手动配置。

## How caching normally works

## 缓存通常如何工作

To understand why request collapsing matters, let's look at how the Vercel CDN serves requests when everything is working smoothly.

为理解为何请求合并至关重要，我们先来看 Vercel CDN 在一切正常运行时是如何处理请求的。

The Vercel CDN is globally distributed, starting with the [ISR cache](https://vercel.com/docs/incremental-static-regeneration/limits-and-pricing#isr-cache-region), which lives alongside your functions and stores the results of static regeneration. It's the source of truth that [replicates content](https://vercel.com/docs/edge-cache) to each region's [Vercel cache](https://vercel.com/docs/edge-cache). When a user makes a request, the nearest CDN region serves it (more specifically, a node within each region).

Vercel CDN 全球分布式部署，其缓存体系始于 [ISR 缓存](https://vercel.com/docs/incremental-static-regeneration/limits-and-pricing#isr-cache-region)——该缓存与您的函数共置，用于存储静态再生的结果。它是权威数据源，负责将内容 [复制分发](https://vercel.com/docs/edge-cache) 至各区域的 [Vercel 边缘缓存](https://vercel.com/docs/edge-cache)。当用户发起请求时，距离最近的 CDN 区域将响应此请求（更准确地说，是该区域内某个边缘节点）。

Each region has multiple nodes (server instances) that scale based on traffic. Each node runs multiple workers to handle concurrent requests and maintains a small in-memory cache for frequently requested content.

每个区域包含多个节点（即服务器实例），其数量会根据流量动态伸缩。每个节点运行多个工作线程以并发处理请求，并维护一个小型内存缓存，用于暂存高频访问的内容。

![Cache lookup sequence across layers in the Vercel CDN.](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_001.jpg)![Cache lookup sequence across layers in the Vercel CDN.](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_002.jpg)![Cache lookup sequence across layers in the Vercel CDN.](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_003.jpg)![Cache lookup sequence across layers in the Vercel CDN.](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_004.jpg)Cache lookup sequence across layers in the Vercel CDN.

![Vercel CDN 中跨多层的缓存查找流程图。](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_001.jpg)![Vercel CDN 中跨多层的缓存查找流程图。](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_002.jpg)![Vercel CDN 中跨多层的缓存查找流程图。](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_003.jpg)![Vercel CDN 中跨多层的缓存查找流程图。](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_004.jpg)Vercel CDN 中跨多层的缓存查找流程图。

Here's the normal flow:

这是正常的请求流程：

- Hot content gets served immediately from the node's in-memory cache

- 热门内容直接从节点的内存缓存中即时返回

- If not found there, the request checks the regional CDN cache, which pulls from the ISR cache

- 若内存缓存中未命中，则请求检查区域 CDN 缓存，该缓存从 ISR 缓存中拉取内容

- If not found there, checks the ISR cache. If the ISR cache has a valid page, it returns without running your function

- 若 CDN 缓存也未命中，则检查 ISR 缓存；若 ISR 缓存中存在有效页面，则直接返回，无需运行您的函数

Problems start when all caches miss. Picture a page that just recently expired, or a new route getting hit for the first time. Multiple users request it simultaneously. Each request sees an empty cache and triggers a function invocation.

问题始于所有缓存均未命中的情况。设想一个刚刚过期的页面，或一条首次被访问的新路由。多个用户同时发起请求，每个请求都发现缓存为空，从而各自触发一次函数调用。

![Without coordination, each request triggers its own regeneration.](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_005.jpg)![Without coordination, each request triggers its own regeneration.](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_006.jpg)![Without coordination, each request triggers its own regeneration.](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_007.jpg)![Without coordination, each request triggers its own regeneration.](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_008.jpg)Without coordination, each request triggers its own regeneration.

![无协调机制时，每个请求都会独立触发自身的内容再生。](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_005.jpg)![无协调机制时，每个请求都会独立触发自身的内容再生。](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_006.jpg)![无协调机制时，每个请求都会独立触发自身的内容再生。](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_007.jpg)![无协调机制时，每个请求都会独立触发自身的内容再生。](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_008.jpg)无协调机制时，每个请求都会独立触发自身的内容再生。

Without coordination, each of those misses invokes the function independently. For a popular route, this can mean dozens of simultaneous invocations, all regenerating the same page. This wastes compute and hammers your backend.

若缺乏协调机制，每次缓存未命中都将独立调用函数。对于热门路由，这可能导致数十次并发调用，全部重复生成同一页面——既浪费计算资源，又给后端造成巨大压力。

This is where request collapsing comes in. By synchronizing concurrent misses, the system ensures that only one invocation per region runs, and every other request waits briefly to receive that same response once it is cached.

此时，请求合并（request collapsing）机制便发挥作用：通过同步处理并发的缓存未命中请求，系统确保每个区域仅执行一次函数调用，其余所有请求则短暂等待，待该响应被缓存后即刻共享同一结果。

![One request regenerates, others wait and receive the cached result.](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_009.jpg)![One request regenerates, others wait and receive the cached result.](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_010.jpg)![One request regenerates, others wait and receive the cached result.](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_011.jpg)![One request regenerates, others wait and receive the cached result.](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_012.jpg)One request regenerates, others wait and receive the cached result.

![一次请求负责再生内容，其余请求等待并接收已缓存的结果。](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_009.jpg)![一次请求负责再生内容，其余请求等待并接收已缓存的结果。](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_010.jpg)![一次请求负责再生内容，其余请求等待并接收已缓存的结果。](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_011.jpg)![一次请求负责再生内容，其余请求等待并接收已缓存的结果。](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_012.jpg)一次请求负责再生内容，其余请求等待并接收已缓存的结果。

When it works properly:  

当该机制正常工作时：

- One invocation regenerates the page  
- 一次调用即可重新生成页面  

- All other requests receive the result from cache once it completes  
- 其余所有请求在该次调用完成之后，均从缓存中获取结果  

- Cache coherency improves because only one invocation writes the response at a time  
- 缓存一致性得以提升，因为同一时间仅有一个调用负责写入响应  

## When collapsing can be applied  

## 请求合并适用的场景  

Request collapsing only works when a request is known to produce a cacheable response. Requests that might return different results or aren't meant to be cached at all can't collapse requests.  
请求合并仅在系统已知某请求将产生可缓存响应时才生效。那些可能返回不同结果、或本就不应被缓存的请求，无法参与请求合并。  

Consider these scenarios:  
请考虑以下几种情形：  

- An ISR page that regenerates the same content for all users can be safely collapsed  
- 对所有用户均生成相同内容的 ISR 页面可以安全地进行请求合并  

- A dynamic API route that returns user-specific data cannot be collapsed  
- 返回用户专属数据的动态 API 路由不可进行请求合并  

- A page with random content or timestamps should not be collapsed  
- 包含随机内容或时间戳的页面不应进行请求合并  

The challenge is determining this automatically. Vercel solves this through framework integration. When you deploy your app, Vercel analyzes your routes and understands which ones use ISR, static generation, or dynamic rendering. This metadata gets distributed to every CDN region.  
自动识别这一特性是项挑战。Vercel 通过框架集成来解决该问题：部署应用时，Vercel 会分析您的路由，识别哪些路由采用 ISR、静态生成或动态渲染；这些元数据将分发至每个 CDN 区域。

When a request arrives, the CDN already knows whether that specific route can be safely cached and collapsed. This happens without any configuration from you. The framework’s code tells Vercel how each route behaves, and Vercel applies the correct caching strategy automatically, including features like request collapsing.

当请求到达时，CDN 已经知晓该特定路由是否可以安全地缓存和合并（collapse）。整个过程无需您进行任何配置。框架代码会向 Vercel 声明每个路由的行为特征，Vercel 则自动应用恰当的缓存策略，包括请求合并等功能。

## Distributed locking

## 分布式锁

Request collapsing works through a two-level distributed locking system.

请求合并通过一个两级分布式锁系统实现。

At the **node level**, each CDN node maintains an in-memory lock. When multiple requests for the same uncached path arrive at that node, the lock ensures that only one proceeds. Others wait until the cache fills. This prevents a single node from firing multiple function invocations for the same path.

在 **节点级（node level）**，每个 CDN 节点维护一个内存中的锁。当多个针对同一未缓存路径的请求同时到达该节点时，该锁确保仅有一个请求继续执行，其余请求则等待缓存填充完成。这可防止单个节点对同一路径重复触发多次函数调用。

At the **regional level**, every region enforces its own lock across all nodes. After acquiring the node lock, a request tries to get the regional lock. Only one request per region can hold both locks simultaneously, meaning only one function invocation per region can regenerate a page.

在 **区域级（regional level）**，每个区域在其所有节点上统一施加自身的锁。请求在获取节点锁后，会尝试获取区域锁；同一区域内，仅允许一个请求同时持有这两个锁，即：每个区域至多仅有一个函数调用可重新生成页面。

This design makes collapsing scalable. Without the node-level grouping, hundreds of concurrent requests could all compete for the regional lock simultaneously. This would create a thundering herd problem where the lock coordination itself becomes a bottleneck.

该设计使请求合并具备良好的可扩展性。若无节点级分组机制，数百个并发请求将同时争抢区域锁，从而引发“惊群效应”（thundering herd problem）——锁协调本身反而成为性能瓶颈。

Instead, the node lock groups requests locally first. The number of waiters at the regional level stays proportional to nodes in the region, not total requests. Within a node, waiters scale with concurrent requests hitting that specific node.

相反，节点锁首先在本地对请求进行分组。区域级等待者（waiter）的数量与该区域内的节点数成正比，而非与总请求数成正比；而在单个节点内部，等待者的数量则随抵达该节点的并发请求数线性增长。

By bounding the waiters at each level, the CDN prevents the lock coordination from becoming overwhelmed. Every request is either served from cache immediately or waits briefly for a lock holder to complete.

通过在每一层级限制等待者数量，CDN 可避免锁协调机制过载。每个请求要么立即从缓存中响应，要么仅需短暂等待持有锁的请求完成即可。

The mechanism can be expressed in pseudocode like this:

该机制可用如下伪代码表示：

```typescript
function createDistributedLock(cacheKey) {

2  const nodeLock = createNodeLock(cacheKey);

2  const nodeLock = createNodeLock(cacheKey);

3  const regionalLock = createRegionalLock(cacheKey);

3  const regionalLock = createRegionalLock(cacheKey);

4  return combineLocks([nodeLock, regionalLock]);

4  return combineLocks([nodeLock, regionalLock]);

5}

5}

async function respond(request) {

async function respond(request) {

8  const cacheKey = getCacheKey(request);

8  const cacheKey = getCacheKey(request);

9  const cachedResponse = await cache.get(cacheKey);

9  const cachedResponse = await cache.get(cacheKey);

10  if (cachedResponse) return cachedResponse;

10  if (cachedResponse) 返回 cachedResponse；

12  const lock = createDistributedLock(cacheKey);

12  const lock = createDistributedLock(cacheKey);

13  await lock.lock();

13  await lock.lock();

14  const response = await invokeFunction(request);

14  const response = await invokeFunction(request);

15  lock.unlock();

15  lock.unlock();



17  return response;

17  return response;

18}
```

18}
```

Lock-based flow: check cache, acquire locks, regenerate if needed.

基于锁的流程：先检查缓存，再获取锁，如有必要则重新生成。

Every request checks the cache first, then acquires both locks before regenerating.

每个请求首先检查缓存，然后在重新生成前同时获取两把锁。

## Double-checked locking

## 双重检查锁定

Locking alone doesn't collapse requests. If every waiter invoked the function after getting the lock, work would still be duplicated.

仅靠加锁并不能实现请求合并。如果每个等待者在获取锁后都调用该函数，工作仍会被重复执行。

To solve this, the CDN uses the well-known double-checked locking pattern. The idea is simple but powerful: check the cache twice.

为解决此问题，CDN 采用经典的双重检查锁定（double-checked locking）模式。其思想简单却十分有效：对缓存进行两次检查。

1. **First check**: When a request arrives, check the cache. If content exists, return immediately without getting a lock

1. **首次检查**：当请求到达时，先检查缓存；若内容已存在，则立即返回，无需获取锁。

2. **Acquire lock**: If the cache is empty, acquire the node and regional locks. This guarantees only one request can proceed with regeneration

2. **获取锁**：若缓存为空，则获取节点级锁和区域级锁。这确保了仅有一个请求能继续执行再生（regeneration）操作。

3. **Second check**: After getting the lock, check the cache again. Another request might have completed and populated the cache while this request waited for the lock. If that is the case, the current request can skip regeneration and simply return the cached value

3. **二次检查**：获取锁后，再次检查缓存。在此请求等待锁期间，可能已有其他请求完成并填充了缓存。若是如此，当前请求可跳过再生步骤，直接返回缓存中的值。

4. **Regeneration**: Only if the cache is still empty does the request invoke the function and set the cache before releasing the lock

4. **再生操作**：仅当缓存仍为空时，当前请求才调用函数执行再生，并在释放锁前将结果写入缓存。

This ensures concurrent requests don't duplicate work. The first request regenerates the page. Others either get immediate cache hits or read the new value after waiting.

这保证了并发请求不会重复执行工作：首个请求负责页面再生；其余请求则要么立即命中缓存，要么在等待后读取新生成的值。

Here’s what the logic looks like:

以下是该逻辑的示意代码：

```typescript
async function respond(request) {

2  const cacheKey = getCacheKey(request);
```

3  const cachedResponse = await cache.get(cacheKey);

3  const cachedResponse = await cache.get(cacheKey);

4  if (cachedResponse) return cachedResponse;

4  if (cachedResponse) return cachedResponse;



6  const lock = createDistributedLock(cacheKey);

6  const lock = createDistributedLock(cacheKey);

7  await lock.lock();

7  await lock.lock();

8  let cachedResponse = await cache.get(cacheKey);

8  let cachedResponse = await cache.get(cacheKey);

9  if (cachedResponse) return cachedResponse;

9  if (cachedResponse) return cachedResponse;



11  const functionResponse = await invokeFunction(request);

11  const functionResponse = await invokeFunction(request);

12  // set cache in background so we can return response immediately

12  // 在后台设置缓存，以便立即返回响应

13  (async () => {

13  (异步函数 () => {

14	  await cache.set(cacheKey, functionResponse);

14	  await cache.set(cacheKey, functionResponse);

15	  lock.unlock();

15	  lock.unlock();

16  })()

16  })()

18  return functionResponse;

18  return functionResponse;

19}
19}

Double-checked locking: only regenerate if the cache is still empty after lock acquisition.

双重检查锁定（Double-checked locking）：仅当获取锁后缓存仍为空时，才重新生成结果。

Notice that the cache is written asynchronously after the function returns. This allows the response to be sent back to the user without waiting for the cache set operation to complete, reducing the time to first byte. Meanwhile, the lock is released as soon as the cache is populated, so waiters can proceed quickly.

请注意，缓存写入操作是在函数返回**之后**异步执行的。这使得响应可在无需等待缓存写入完成的情况下立即返回给用户，从而缩短首字节时间（Time to First Byte, TTFB）。同时，一旦缓存被成功填充，锁即被释放，使等待中的其他请求能迅速继续执行。

## Handling failures

## 处理失败

So far we have assumed the function always succeeds. But real systems fail, and request collapsing needs to handle those cases gracefully. Two failure modes are especially important:

到目前为止，我们一直假设函数总会成功执行。但真实系统会发生故障，而请求合并（request collapsing）必须能够优雅地应对这些情况。其中，两种失败模式尤为关键：

- **Function errors:** If the function invocation throws an error, the result cannot be cached. That means the second cache lookup still returns nothing. The next request that acquires the lock must attempt regeneration again. In this case, collapsing does not help because there is no valid response to share, but the system still ensures that errors do not poison the cache

- **函数错误（Function errors）**：如果函数调用抛出异常，则该结果无法被缓存。这意味着第二次缓存查找仍将返回空值；下一个成功获取锁的请求仍需再次尝试重新生成。此时，请求合并无法发挥作用（因为没有有效的响应可供共享），但系统仍能确保错误不会污染缓存。

- **Function timeouts**: Timeouts are more dangerous. If the lock holder takes a long time (or never completes) the other requests waiting on the lock could be stuck indefinitely. During a traffic spike, this can mean dozens or hundreds of requests pile up behind a single slow invocation

- **函数超时（Function timeouts）**：超时问题更为危险。若持有锁的请求耗时过长（甚至永远无法完成），其他等待该锁的请求将被无限期阻塞。在流量激增期间，这可能导致数十乃至数百个请求堆积在一个缓慢的调用之后。

To prevent this, locks are created with explicit timeouts. If a request cannot acquire the lock within a fixed window (for example, a few seconds), it abandons waiting and proceeds to invoke the function itself. This “hedging” ensures that slow regenerations do not block all requests for that route. Even in the worst case, users continue to get responses, though at the cost of multiple invocations.

为防止此类问题，锁的创建需显式指定超时时间。若某请求在固定时间窗口内（例如几秒钟）无法获取锁，它将放弃等待，并直接调用函数自身。“对冲式调用（hedging）”机制可确保缓慢的重新生成过程不会阻塞该路由的所有请求。即使在最坏情况下，用户仍能持续获得响应，代价则是可能触发多次函数调用。

Here is what that looks like in code:

以下是在代码中的具体实现：

```tsx
function createDistributedLock(cacheKey) {

2  const nodeLock = createNodeLock(cacheKey, { timeout: 3000 });

3  const regionalLock = createRegionalLock(cacheKey, { timeout: 3000 });

4  return combineLocks([nodeLock, regionalLock]);

5}
```

Lock creation with timeouts to prevent requests from waiting indefinitely.

为防止请求无限期等待，采用带超时机制的锁创建方式。

With this configuration, each request waits at most three seconds for both the node-level and regional locks. If the locks are not acquired in time, the request moves forward independently.

在此配置下，每个请求对节点级锁和区域级锁的等待时间均不超过三秒；若超时仍未获取到锁，则该请求将独立继续执行。

This timeout policy strikes a balance. It preserves the benefits of collapsing under normal conditions, but it also avoids cascading failures when functions are slow or unstable. In effect, the system optimizes for the common case while still remaining resilient to errors and long-tail latencies.

该超时策略实现了良好平衡：在正常情况下保留了请求合并（collapsing）的优势，同时避免了因函数响应缓慢或不稳定而导致的级联故障。实际上，系统针对常见场景进行了优化，同时仍能从容应对错误及长尾延迟。

## Production impact

## 生产环境影响

The number of function calls elided by request collapsing varies a lot over time. E.g. the graph below shows request collapsed jumping from 30 per second to 120 per second for a short window.

通过请求合并所省略的函数调用数量随时间波动较大。例如，下方图表显示，在短暂的时间窗口内，每秒合并的请求数从 30 次跃升至 120 次。

![](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_013.jpg)

![](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_013.jpg)

In production, the Vercel CDN currently collapses over 3M requests per day on cache miss, on top of the 90M collapsed requests from background revalidations. This feature is enabled for all projects on Vercel, so any customer using ISR benefits from request collapsing automatically.

在生产环境中，Vercel CDN 目前每天在缓存未命中（cache miss）场景下合并超过 300 万次请求，此外还通过后台重新验证（background revalidation）合并了 9000 万次请求。该功能已默认对所有 Vercel 项目启用，因此任何使用增量静态再生（ISR）的客户均可自动受益于请求合并。