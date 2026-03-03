---
title: "Preventing the stampede: Request collapsing in the Vercel CDN  - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/cdn-request-collapsing"
date: "2025-09-25"
scraped_at: "2026-03-02T09:28:03.682858534+00:00"
language: "en"
translated: false
description: "The Vercel CDN now supports request collapsing for ISR routes. For a given path, only one function invocation per region runs at once, no matter how many concurrent requests arrive."
---




Sep 25, 2025

When you deploy a Next.js app with [Incremental Static Regeneration](https://vercel.com/docs/incremental-static-regeneration) (ISR), pages get regenerated on-demand after their cache expires. ISR lets you get the performance benefits of static generation while keeping your content fresh.

But there's a problem. When many users request the same ISR route at once and the cache is expired, each request can trigger its own function invocation. This is called a "cache stampede." It wastes compute, overloads your backend, and can cause downtime.

The Vercel CDN now prevents this with [request collapsing](https://vercel.com/docs/request-collapsing). When multiple requests hit the same uncached path, only one request per region invokes a function. The rest wait and get the cached response.

Vercel automatically infers cacheability for each request through framework-defined infrastructure, configuring our globally distributed router. No manual configuration needed.

## How caching normally works

To understand why request collapsing matters, let's look at how the Vercel CDN serves requests when everything is working smoothly.

The Vercel CDN is globally distributed, starting with the [ISR cache](https://vercel.com/docs/incremental-static-regeneration/limits-and-pricing#isr-cache-region), which lives alongside your functions and stores the results of static regeneration. It's the source of truth that [replicates content](https://vercel.com/docs/edge-cache) to each region's [Vercel cache](https://vercel.com/docs/edge-cache). When a user makes a request, the nearest CDN region serves it (more specifically, a node within each region).

Each region has multiple nodes (server instances) that scale based on traffic. Each node runs multiple workers to handle concurrent requests and maintains a small in-memory cache for frequently requested content.

![Cache lookup sequence across layers in the Vercel CDN.](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_001.jpg)![Cache lookup sequence across layers in the Vercel CDN.](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_002.jpg)![Cache lookup sequence across layers in the Vercel CDN.](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_003.jpg)![Cache lookup sequence across layers in the Vercel CDN.](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_004.jpg)Cache lookup sequence across layers in the Vercel CDN.

Here's the normal flow:

- Hot content gets served immediately from the node's in-memory cache

- If not found there, the request checks the regional CDN cache, which pulls from the ISR cache

- If not found there, checks the ISR cache. If the ISR cache has a valid page, it returns without running your function


Problems start when all caches miss. Picture a page that just recently expired, or a new route getting hit for the first time. Multiple users request it simultaneously. Each request sees an empty cache and triggers a function invocation.

![Without coordination, each request triggers its own regeneration.](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_005.jpg)![Without coordination, each request triggers its own regeneration.](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_006.jpg)![Without coordination, each request triggers its own regeneration.](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_007.jpg)![Without coordination, each request triggers its own regeneration.](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_008.jpg)Without coordination, each request triggers its own regeneration.

Without coordination, each of those misses invokes the function independently. For a popular route, this can mean dozens of simultaneous invocations, all regenerating the same page. This wastes compute and hammers your backend.

This is where request collapsing comes in. By synchronizing concurrent misses, the system ensures that only one invocation per region runs, and every other request waits briefly to receive that same response once it is cached.

![One request regenerates, others wait and receive the cached result.](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_009.jpg)![One request regenerates, others wait and receive the cached result.](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_010.jpg)![One request regenerates, others wait and receive the cached result.](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_011.jpg)![One request regenerates, others wait and receive the cached result.](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_012.jpg)One request regenerates, others wait and receive the cached result.

When it works properly:

- One invocation regenerates the page

- All other requests receive the result from cache once it completes

- Cache coherency improves because only one invocation writes the response at a time


## When collapsing can be applied

Request collapsing only works when a request is known to produce a cacheable response. Requests that might return different results or aren't meant to be cached at all can't collapse requests.

Consider these scenarios:

- An ISR page that regenerates the same content for all users can be safely collapsed

- A dynamic API route that returns user-specific data cannot be collapsed

- A page with random content or timestamps should not be collapsed


The challenge is determining this automatically. Vercel solves this through framework integration. When you deploy your app, Vercel analyzes your routes and understands which ones use ISR, static generation, or dynamic rendering. This metadata gets distributed to every CDN region.

When a request arrives, the CDN already knows whether that specific route can be safely cached and collapsed. This happens without any configuration from you. The framework’s code tells Vercel how each route behaves, and Vercel applies the correct caching strategy automatically, including features like request collapsing.

## Distributed locking

Request collapsing works through a two-level distributed locking system.

At the **node level**, each CDN node maintains an in-memory lock. When multiple requests for the same uncached path arrive at that node, the lock ensures that only one proceeds. Others wait until the cache fills. This prevents a single node from firing multiple function invocations for the same path.

At the **regional level**, every region enforces its own lock across all nodes. After acquiring the node lock, a request tries to get the regional lock. Only one request per region can hold both locks simultaneously, meaning only one function invocation per region can regenerate a page.

This design makes collapsing scalable. Without the node-level grouping, hundreds of concurrent requests could all compete for the regional lock simultaneously. This would create a thundering herd problem where the lock coordination itself becomes a bottleneck.

Instead, the node lock groups requests locally first. The number of waiters at the regional level stays proportional to nodes in the region, not total requests. Within a node, waiters scale with concurrent requests hitting that specific node.

By bounding the waiters at each level, the CDN prevents the lock coordination from becoming overwhelmed. Every request is either served from cache immediately or waits briefly for a lock holder to complete.

The mechanism can be expressed in pseudocode like this:

```typescript
function createDistributedLock(cacheKey) {

2  const nodeLock = createNodeLock(cacheKey);

3  const regionalLock = createRegionalLock(cacheKey);

4  return combineLocks([nodeLock, regionalLock]);

5}



async function respond(request) {

8  const cacheKey = getCacheKey(request);

9  const cachedResponse = await cache.get(cacheKey);

10  if (cachedResponse) return cachedResponse;



12  const lock = createDistributedLock(cacheKey);

13  await lock.lock();

14  const response = await invokeFunction(request);

15  lock.unlock();



17  return response;

18}
```

Lock-based flow: check cache, acquire locks, regenerate if needed.

Every request checks the cache first, then acquires both locks before regenerating.

## Double-checked locking

Locking alone doesn't collapse requests. If every waiter invoked the function after getting the lock, work would still be duplicated.

To solve this, the CDN uses the well-known double-checked locking pattern. The idea is simple but powerful: check the cache twice.

1. **First check**: When a request arrives, check the cache. If content exists, return immediately without getting a lock

2. **Acquire lock**: If the cache is empty, acquire the node and regional locks. This guarantees only one request can proceed with regeneration

3. **Second check**: After getting the lock, check the cache again. Another request might have completed and populated the cache while this request waited for the lock. If that is the case, the current request can skip regeneration and simply return the cached value

4. **Regeneration**: Only if the cache is still empty does the request invoke the function and set the cache before releasing the lock


This ensures concurrent requests don't duplicate work. The first request regenerates the page. Others either get immediate cache hits or read the new value after waiting.

Here’s what the logic looks like:

```typescript
async function respond(request) {

2  const cacheKey = getCacheKey(request);

3  const cachedResponse = await cache.get(cacheKey);

4  if (cachedResponse) return cachedResponse;



6  const lock = createDistributedLock(cacheKey);

7  await lock.lock();

8  let cachedResponse = await cache.get(cacheKey);

9  if (cachedResponse) return cachedResponse;



11  const functionResponse = await invokeFunction(request);

12  // set cache in background so we can return response immediately

13  (async () => {

14	  await cache.set(cacheKey, functionResponse);

15	  lock.unlock();

16  })()



18  return functionResponse;

19}
```

Double-checked locking: only regenerate if the cache is still empty after lock acquisition.

Notice that the cache is written asynchronously after the function returns. This allows the response to be sent back to the user without waiting for the cache set operation to complete, reducing the time to first byte. Meanwhile, the lock is released as soon as the cache is populated, so waiters can proceed quickly.

## Handling failures

So far we have assumed the function always succeeds. But real systems fail, and request collapsing needs to handle those cases gracefully. Two failure modes are especially important:

- **Function errors:** If the function invocation throws an error, the result cannot be cached. That means the second cache lookup still returns nothing. The next request that acquires the lock must attempt regeneration again. In this case, collapsing does not help because there is no valid response to share, but the system still ensures that errors do not poison the cache

- **Function timeouts**: Timeouts are more dangerous. If the lock holder takes a long time (or never completes) the other requests waiting on the lock could be stuck indefinitely. During a traffic spike, this can mean dozens or hundreds of requests pile up behind a single slow invocation


To prevent this, locks are created with explicit timeouts. If a request cannot acquire the lock within a fixed window (for example, a few seconds), it abandons waiting and proceeds to invoke the function itself. This “hedging” ensures that slow regenerations do not block all requests for that route. Even in the worst case, users continue to get responses, though at the cost of multiple invocations.

Here is what that looks like in code:

```tsx
function createDistributedLock(cacheKey) {

2  const nodeLock = createNodeLock(cacheKey, { timeout: 3000 });

3  const regionalLock = createRegionalLock(cacheKey, { timeout: 3000 });

4  return combineLocks([nodeLock, regionalLock]);

5}
```

Lock creation with timeouts to prevent requests from waiting indefinitely.

With this configuration, each request waits at most three seconds for both the node-level and regional locks. If the locks are not acquired in time, the request moves forward independently.

This timeout policy strikes a balance. It preserves the benefits of collapsing under normal conditions, but it also avoids cascading failures when functions are slow or unstable. In effect, the system optimizes for the common case while still remaining resilient to errors and long-tail latencies.

## Production impact

The number of function calls elided by request collapsing varies a lot over time. E.g. the graph below shows request collapsed jumping from 30 per second to 120 per second for a short window.

![](images/preventing-the-stampede-request-collapsing-in-the-vercel-cdn-vercel/img_013.jpg)

In production, the Vercel CDN currently collapses over 3M requests per day on cache miss, on top of the 90M collapsed requests from background revalidations. This feature is enabled for all projects on Vercel, so any customer using ISR benefits from request collapsing automatically.