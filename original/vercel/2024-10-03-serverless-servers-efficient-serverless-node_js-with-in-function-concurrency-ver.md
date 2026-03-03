---
title: "Serverless servers: Efficient serverless Node.js with in-function concurrency - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/serverless-servers-node-js-with-in-function-concurrency"
date: "2024-10-03"
scraped_at: "2026-03-02T09:40:40.690743346+00:00"
language: "en"
translated: false
description: "Building a compute layer that is highly-optimized for interactive workloads, server-rendering, and APIs"
---




Oct 3, 2024

Building a compute layer that is highly-optimized for interactive workloads, server-rendering, and APIs

We’re sharing a first look at a new version of [Vercel Functions](https://vercel.com/docs/functions) with [support for **in-function concurrency**](https://vercel.com/changelog/in-function-concurrency-now-in-public-beta) that brings the best of servers to serverless functions.

We’ve been testing this new version with customers and are seeing a **20%-50% reduction in compute usage and respective cost reduction** without latency impact.

It’s a serverless product optimized specifically for interactive workloads such as server-rendering of web pages, APIs, and AI applications. Vercel Functions continue to offer native Node.js support with [accelerated cold-start performance based on V8 bytecode](https://vercel.com/blog/introducing-bytecode-caching-for-vercel-functions) and instance pre-warming for production workloads.

[**Public beta: Enable in-function concurrency today**\\
\\
In-function concurrency, now in public beta, allows a single function instance to handle multiple calls simultaneously. This optimizes efficiency by leveraging idle time, potentially cutting costs by up to 50%.\\
\\
Enable Now](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions%23in-function-concurrency&title=Go+to+Function+Settings)

## History of serverless for interactive workloads

When AWS Lambda introduced "functions as a service," it revolutionized batch workloads by mapping one function instance to one invocation.

However, this model struggles with interactive, dynamic workloads, where single user requests are tied to one function instance which sit idle when the compute is waiting for the backend to respond. These inefficiencies become even more apparent with AI models and other IO-heavy applications that can take seconds to respond.

With in-function concurrency, Vercel Functions breaks away from Lambda’s one-to-one mapping—from invocation to compute—leading to substantial efficiency wins.

## The journey to in-function concurrency

### Part 1: Establishing a streaming connection

In 2022, we [released Next.js 13](https://nextjs.org/blog/next-13) with streaming for React server-side rendering. Vercel’s serverless functions, previously a relatively _thin wrapper_ around AWS Lambda, faced limitations as Lambda didn’t support streaming, so we explored alternatives for our customers.

![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_001.jpg)![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_002.jpg)![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_003.jpg)![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_004.jpg)

Our idea was to have the function open up a secure TCP socket back to the “function invocation service” and use that socket to stream back responses, even if the actual Lambda invocation doesn’t support streaming.

Once deployed, we realized: _a bidirectional stream to all functions could enable much, much more_—like giving them additional work.

### Part 2: Rust-powered functions

With the idea in mind, we got a prototype to work, but there were a few things we needed to address first. Keeping the behavior consistent with the expectations of serverless environments was tough. To solve this, we shifted focus to the function runtime and began rewriting Vercel Functions' runtime in Rust.

[The rewrite itself unlocked several performance improvements](https://vercel.com/blog/vercel-functions-are-now-faster-and-powered-by-rust) and better debuggability of the system for users. You can essentially think of the runtime as the ultra-stable in-function [hypervisor](https://aws.amazon.com/what-is/hypervisor/) that orchestrates the workload even if a single function invocation gets into trouble.

### Part 3: Putting it together

Finally, we had all the building blocks in place to start shipping in-function concurrency for Vercel Functions (for real). The new architecture looks like this:

![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_005.jpg)![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_006.jpg)![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_007.jpg)![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_008.jpg)

As traffic reaches our data center, it's routed through a function load balancer to the function invocation service. This service manages connections ranging from a single function instance up to 100,000 instances per function.

It ensures traffic is routed to a function invocation service likely to have in-flight invocations for the desired function instances. When an invocation request arrives, the service checks for available instances, and if one exists, forwards the request to it.

## Efficiency gains

Our private beta customers have reported significant efficiency improvements, with some seeing up to a 50% reduction in compute usage. This means fewer gigabyte-hours billed for the same workload with no code changes. Results will vary depending on your backend communication and traffic volume, as the efficiency gains from concurrency apply best when a minimum number of requests is met.

Here’s how these gains are achieved: Remember, in the traditional serverless model, each invocation is tied to a single function instance.

![Traditional serverless functions require separate instances for each function call, leaving compute underutilized.](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_009.jpg)![Traditional serverless functions require separate instances for each function call, leaving compute underutilized.](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_010.jpg)![Traditional serverless functions require separate instances for each function call, leaving compute underutilized.](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_011.jpg)![Traditional serverless functions require separate instances for each function call, leaving compute underutilized.](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_012.jpg)Traditional serverless functions require separate instances for each function call, leaving compute underutilized.

Vercel’s new system, however, allows a single instance to handle multiple invocations by utilizing idle time spent waiting for backend responses.

![With in-function concurrency, a single function instance can utilize already-available compute for new function calls.](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_013.jpg)![With in-function concurrency, a single function instance can utilize already-available compute for new function calls.](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_014.jpg)![With in-function concurrency, a single function instance can utilize already-available compute for new function calls.](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_015.jpg)![With in-function concurrency, a single function instance can utilize already-available compute for new function calls.](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_016.jpg)With in-function concurrency, a single function instance can utilize already-available compute for new function calls.

For example, let’s say a request takes 100ms, with 50ms spent on computation and 50ms waiting for a backend response.

- **Old model**: Two requests would require a total of 200ms of compute time

- **New model**: Two requests could be handled by one invocation, reducing the actual compute time to ~100ms


## Fulfilling the Node.js dream on serverless

Node.js was created to handle asynchronous IO concurrently. While existing functions-as-a-service products could take advantage of this in the context of a _single_ invocation, they often don’t have the opportunity to use all the available CPU.

With in-function concurrency, Vercel Functions can take full advantage of Node.js’ concurrency capabilities. As an example, whenever a function is stalled waiting for a backend to respond, it can handle a second request with the available CPU immediately. Respectively, the compute time is utilized rather than sitting idle, leading to substantial efficiency gains.

## Trade-offs of the current implementation

During the beta phase, we’re limiting the maximum number of concurrent invocations dispatched to a single function instance. We’ll slowly increase these limits over the duration of the beta period, so we can monitor trade-offs between efficiency and latency.

While we’ve seen performance gains with all private beta customers, the mechanism may increase latency for purely CPU-bound workloads. We also expect our detection of unhelpful concurrency to substantially improve during the beta period, ensuring it's only used in the right situations.

Finally, this mechanism inherently changes that a single Node.js process handles multiple invocations concurrently. As mentioned above, this is really how Node.js is typically being run in production. Therefore, while this is technically a backward-incompatible change (and opt-in), we expect the vast majority of workloads to work under the new semantics.

## It’s still serverless

While this new architecture substantially increases the [efficiency of Vercel Functions](https://vercel.com/blog/understanding-vercel-functions), it changes absolutely nothing about their serverless nature. Vercel Functions continue to:

- Scale automatically

- Never go into maintenance mode—all maintenance is handled automatically with no impact on users or availability

- Transparently ship security updates for operating system and runtime without any downtime or work for you


### Real-world impact: Verse’s success with in-function concurrency

After [Verse](https://madeonverse.com/) launched their internet bedroom website, traffic surged from hundreds of thousands to over 10 million visitors. At its peak, 15,000 users were online concurrently, creating a flood of requests—and potential idle time. This made it an ideal candidate for this new optimization.

With early access to in-function concurrency, their Vercel Functions cut GB-hours and **reduced costs by over 50%** through automated, smarter use of compute during idle times.

> “Many of our API endpoints were lightweight and involved external requests, resulting in idle compute time. By leveraging in-function concurrency, we were able to share compute resources between requests, cutting costs by over 50% with zero code changes.Many of our API endpoints were lightweight and involved external requests, resulting in idle compute time. By leveraging in-function concurrency, we were able to share compute resources between requests, cutting costs by over 50% with zero code changes.”
>
> ![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_017.jpg)
>
> **Aydan Gooneratne,** Lead Full Stack Developer at Verse

## Try it out today

In-function concurrency is available to try today for all Pro and Enterprise customers. The service is in beta, but is in production with Vercel’s own properties and a variety of customers who participated in the private beta.

To enable it, look for the [new option in your project settings under the Functions tab](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions%23in-function-concurrency&title=Go+to+Function+Settings).

![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_018.jpg)![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_019.jpg)![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_020.jpg)![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_021.jpg)

We're also introducing better visibility into your function usage. With the new [Observability tab](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fobservability%2Fserverless-functions%2Fadvanced&title=Go+to+Advanced+Function+Metrics) in your project, you can view your function cost savings and the impact on key metrics such as latency and time to first byte:

![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_022.jpg)![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_023.jpg)![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_024.jpg)![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_025.jpg)

This is an exciting next step in the evolution of Vercel Functions. Please send us your feedback and any efficiency wins you are seeing. This is only the first step in our journey to making serverless as efficient as servers while maintaining the refined and simple DX of Vercel Functions.

## Acknowledgements

Google Cloud Run was a pioneer in concurrent fully-managed containers. Their public preview functions product has similar concurrency properties. Zooming out from Node.js, products like Deno Deploy, Cloudflare Workers, and our own Edge Functions have similarly innovated on concurrent invocations for serverless-like compute.

[**Public beta: Enable in-function concurrency today**\\
\\
In-function concurrency, now in public beta, allows a single function instance to handle multiple calls simultaneously. This optimizes efficiency by leveraging idle time, potentially cutting costs by up to 50%.\\
\\
Enable Now](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions%23in-function-concurrency&title=Go+to+Function+Settings)