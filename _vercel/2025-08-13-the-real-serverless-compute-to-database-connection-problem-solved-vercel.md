---
title: "The real serverless compute to database connection problem, solved - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/the-real-serverless-compute-to-database-connection-problem-solved"
date: "2025-08-13"
scraped_at: "2026-03-02T09:29:47.018704458+00:00"
language: "en-zh"
translated: true
description: "Serverless compute does not mean you need more database connections. The math is the same for serverful and serverless. The real difference is what happens when functions suspend. We solve this issue ..."
---

render_with_liquid: false
Aug 13, 2025

2025 年 8 月 13 日

There is a long-standing myth that serverless compute inherently requires more connections to traditional databases. The real issue is not the number of connections needed during normal operation, but that some serverless platforms can leak connections when functions are suspended.

长久以来存在一种误解：无服务器（serverless）计算本质上需要比传统架构更多的数据库连接。但真正的问题并非正常运行期间所需的连接数，而是一些无服务器平台在函数被挂起（suspended）时可能发生连接泄漏（connection leak）。

In this post, we show why this belief is incorrect, explain the actual cause of the problem, and provide a straightforward, simple-to-use solution.

本文将阐明这一观点为何错误，解释问题的真实成因，并提供一个直接、易用的解决方案。

## You can stop reading now if

## 若符合以下任一情况，您可就此止步

- Your application uses a modern, stateless protocol like HTTP for database connections (for example, DynamoDB, Fauna, or Firestore)

- 您的应用程序使用现代无状态协议（例如 HTTP）连接数据库（如 DynamoDB、Fauna 或 Firestore）

- You use a connection pooler with such a high maximum connection count that it's effectively unlimited and exhaustion is not a practical concern (for example, AWS RDS Proxy; Google Cloud SQL Auth Proxy and Azure Flexible Server offer similar capabilities, although experiences may vary)

- 您使用的连接池工具（connection pooler）设置了极高的最大连接数，使其在实践中近乎无限，连接耗尽（exhaustion）并非实际问题（例如 AWS RDS Proxy；Google Cloud SQL Auth Proxy 和 Azure Flexible Server 也提供类似能力，但具体体验可能因环境而异）

For everybody else:

对其他所有读者：

## The ground truth

## 真相所在

If your application uses a database connection pool (e.g., Postgres, MySQL, Oracle, MSSQL, Redis), the number of concurrent database connections you need is determined solely by the number of concurrent requests you process. This is true for every compute model:

如果您的应用程序使用数据库连接池（例如 PostgreSQL、MySQL、Oracle、MSSQL 或 Redis），那么您所需的同时活跃数据库连接数，**完全取决于您同时处理的请求数量**。该原则适用于所有计算模型：

- Single large server (threaded or multi-process)

- 单台大型服务器（采用线程化或多进程架构）

- Many small servers behind a load balancer  
- 负载均衡器后方的众多小型服务器  

- Serverless instances such as AWS Lambda or Vercel Fluid  
- 无服务器实例，例如 AWS Lambda 或 Vercel Fluid  

- Event loop models with non-blocking IO  
- 基于事件循环的模型（采用非阻塞 I/O）  

Without pooling, unpredictable traffic can quickly exhaust available connections in any of these. With pooling, the math works out the same across all models.  
若不使用连接池，不可预测的流量会迅速耗尽上述任一架构中可用的连接数；而使用连接池后，所有架构下的连接数计算逻辑保持一致。

For example, processing 1,000 concurrent requests requires 1,000 active pool clients:  
例如，处理 1,000 个并发请求需要 1,000 个活跃的连接池客户端：

| Model | Example setup | Pool math | Total pool clients |  
| --- | --- | --- | --- |  
| Single large server (threading) | 1 server × 1,000 threads | 1 pool × 1,000 clients | 1,000 |  
| 单台大型服务器（线程模型） | 1 台服务器 × 1,000 个线程 | 1 个连接池 × 1,000 个客户端 | 1,000 |  
| Multi-process | 100 processes × 10 requests each | 100 pools × 10 clients | 1,000 |  
| 多进程模型 | 100 个进程 × 每进程 10 个请求 | 100 个连接池 × 每池 10 个客户端 | 1,000 |  
| Many small servers | 100 servers × 10 requests each | 100 pools × 10 clients | 1,000 |  
| 多台小型服务器 | 100 台服务器 × 每台 10 个请求 | 100 个连接池 × 每池 10 个客户端 | 1,000 |  
| AWS Lambda | 1,000 instances × 1 request each | 1,000 pools × 1 client | 1,000 |  
| AWS Lambda | 1,000 个实例 × 每实例 1 个请求 | 1,000 个连接池 × 每池 1 个客户端 | 1,000 |  
| Vercel Fluid | 100 instances × 10 requests each | 100 pools × 10 clients | 1,000 |  
| Vercel Fluid | 100 个实例 × 每实例 10 个请求 | 100 个连接池 × 每池 10 个客户端 | 1,000 |  

Traditional database connections are non-concurrent, so best practice is still one pool client per in-flight request. This is why the total connections are identical across compute models.  
传统数据库连接不具备并发能力，因此最佳实践仍是每个进行中的请求对应一个连接池客户端。这正是不同计算模型下所需总连接数完全相同的原因。

So, if all compute models are the same, is there actually anything special with respect to serverless and database connection pool?  
那么，既然所有计算模型在连接数层面表现一致，无服务器架构与数据库连接池之间是否真的存在什么特殊之处？

## The real problem  
## 真正的问题  

There is something unique about serverless and connection pools, but it is not about the steady-state number of connections. **The real problem comes from the lifecycle of the underlying virtual machines in a serverless system.**  
无服务器架构与连接池之间确实存在独特之处，但该特性并非体现在稳态连接数量上。**真正的问题源于无服务器系统底层虚拟机的生命周期管理。**

![A pool client idle time should fire while the function is suspended, but it never does because the function is suspended. This “leaks” the pool client.](images/the-real-serverless-compute-to-database-connection-problem-solved-vercel/img_001.jpg)  
![函数挂起期间本应触发连接池客户端的空闲超时，但因函数处于挂起状态而从未触发。这会导致连接池客户端“泄漏”。](images/the-real-serverless-compute-to-database-connection-problem-solved-vercel/img_001.jpg)

![A pool client idle time should fire while the function is suspended, but it never does because the function is suspended. This “leaks” the pool client.](images/the-real-serverless-compute-to-database-connection-problem-solved-vercel/img_002.jpg)  
![函数挂起期间本应触发连接池客户端的空闲超时，但因函数处于挂起状态而从未触发。这会导致连接池客户端“泄漏”。](images/the-real-serverless-compute-to-database-connection-problem-solved-vercel/img_002.jpg)

![A pool client idle time should fire while the function is suspended, but it never does because the function is suspended. This “leaks” the pool client.](images/the-real-serverless-compute-to-database-connection-problem-solved-vercel/img_003.jpg)  
![函数挂起期间本应触发连接池客户端的空闲超时，但因函数处于挂起状态而从未触发。这会导致连接池客户端“泄漏”。](images/the-real-serverless-compute-to-database-connection-problem-solved-vercel/img_003.jpg)

![A pool client idle time should fire while the function is suspended, but it never does because the function is suspended. This “leaks” the pool client.](images/the-real-serverless-compute-to-database-connection-problem-solved-vercel/img_004.jpg)  
![函数挂起期间本应触发连接池客户端的空闲超时，但因函数处于挂起状态而从未触发。这会导致连接池客户端“泄漏”。](images/the-real-serverless-compute-to-database-connection-problem-solved-vercel/img_004.jpg)

A pool client idle time should fire while the function is suspended, but it never does because the function is suspended. This “leaks” the pool client.

函数挂起期间本应触发连接池客户端的空闲超时，但因函数处于挂起状态而从未触发。这会导致连接池客户端“泄漏”。

In a serverful environment, machines and VMs typically go through three phases:

在传统服务器化（serverful）环境中，物理机或虚拟机通常经历三个阶段：

1. Provisioning (getting ready)  
1. 预配（准备就绪）

2. Serving traffic (where most time is spent)  
2. 处理流量（大部分时间处于此阶段）

3. Deprovisioning (removed from service, releasing all pool clients)  
3. 停用（退出服务，并释放所有连接池客户端）

In a traditional serverless environment, the lifecycle is different:

而在传统的无服务器（serverless）环境中，其生命周期则有所不同：

1. Provision or start up  
1. 预配或启动

2. Serve traffic  
2. 处理流量

3. Suspend when idle, remaining in memory but not executing until another request arrives  
3. 空闲时挂起：保留在内存中，但暂停执行，直至收到下一个请求

4. Eventually delete the suspended VM without a clean shutdown  
4. 最终直接销毁挂起的虚拟机，且未执行优雅关闭（clean shutdown）

Step 4 might sound like the problem, but it is not serious. When the VM is deleted, its sockets to the database pool are closed, and the pool will reclaim those connections.

第 4 步看似是个问题，但实际上并不严重。当虚拟机（VM）被删除时，它与数据库连接池之间的套接字会被关闭，连接池将回收这些连接。

Step 3 is the real issue.

第 3 步才是真正的症结所在。

### Why suspension leaks connections

### 为何挂起会导致连接泄漏

Database connections exist in two states:

数据库连接处于两种状态之一：

- **Active:** currently executing a query

- **活动态（Active）：** 当前正在执行查询

- **Idle**: available for reuse, awaiting another request

- **空闲态（Idle）：** 可供复用，等待下一个请求

When a client becomes idle, a timer in the pool should eventually close it if no new request arrives. If the function is suspended, this timer never fires. As a result, the connection remains open until either:

当客户端进入空闲状态后，连接池中的一个定时器本应在无新请求到达时最终将其关闭。但如果函数被挂起，该定时器便永远不会触发。因此，该连接将一直保持打开状态，直至以下任一情况发生：

- The instance is shut down (Step 4 above)

- 实例被关闭（即上文所述的第 4 步）

- The server-side pooler closes the connection due to its own timeout

- 服务端连接池因自身超时机制而主动关闭该连接

Both events usually take minutes. During that time, the connection is effectively leaked.

这两种情况通常都需要数分钟才会发生。在此期间，该连接实际上已处于“泄漏”状态。

## So, is this a real problem?

## 那么，这真的是一个问题吗？

You really only need to worry about this issue if you are constrained on max connections on your database pooler. This is definitely a thing in the real world. E.g. on Supabase’s free plan, the maximum number of concurrent connections to the pooler is 200. At 200, leaking, say 50 of them, can really hurt.

实际上，仅当您的数据库连接池器（database pooler）在最大连接数方面受到限制时，您才真正需要担心此问题。这在现实世界中确实存在。例如，在 Supabase 的免费计划中，连接池器允许的最大并发连接数为 200。若已达上限，再泄漏（leak）其中约 50 个连接，将造成严重影响。

And unfortunately the “leaks” can be heavily correlated. E.g. if you deploy a new version of your app, 100% of your old serverless functions will both suspend and never get traffic again. All of these functions will leak their connection pools until they time out on the pooler-side.

不幸的是，这些“泄漏”可能高度相关。例如，当您部署应用的新版本时，所有旧的无服务器函数（serverless functions）都会被挂起（suspend），且此后再也不会收到任何流量。这些函数所持有的连接池将一直泄漏，直至在连接池器端超时失效。

## Is there a solution?

## 是否有解决方案？

In traditional serverless environments such as AWS Lambda, there is no practical solution without trade-offs. Closing the database connection after every request would stop leaks but introduce significant latency, since every request would need to open a new connection.

在 AWS Lambda 等传统无服务器环境中，不存在无需权衡取舍的实用解决方案。每次请求后关闭数据库连接虽可阻止泄漏，但会引入显著延迟——因为每个请求都需重新建立连接。

In modern serverless platforms like [Vercel Fluid Compute](https://vercel.com/fluid), the issue of the leaked connections can be solved. Fluid supports a feature called `waitUntil`, which allows a function to remain alive just long enough to complete work after the main request finishes. This can be used to close idle connections before suspension.

而在 Vercel Fluid Compute 等现代无服务器平台中，该连接泄漏问题可以得到解决。Fluid 支持一项名为 `waitUntil` 的功能，它允许函数在主请求结束后继续保持活跃状态，持续时间恰好足以完成后续任务。该机制可用于在函数被挂起前主动关闭空闲连接。

Algorithm:

算法：

- When a client is released back to the pool, schedule a timer slightly longer than the idle timeout

- 当客户端被释放回连接池时，启动一个定时器，其超时时间略长于连接的空闲超时（idle timeout）

- Use `waitUntil` to keep the function alive until the timer fires and closes the client

- 利用 `waitUntil` 保持函数活跃，直至定时器触发并关闭该客户端

- If another client is released before the timer fires, cancel and reschedule the timer

- 若定时器触发前又有其他客户端被释放回池中，则取消当前定时器，并重新调度

With this implemented, the Fluid Compute model closes pool clients exactly the same as any serverful solution. Problem solved.

在实现此功能后，Fluid Compute 模型关闭连接池客户端的方式与任何传统服务器端（serverful）解决方案完全一致。问题得以解决。

In practice, you do not have to implement this yourself. In Fluid Compute, one line after pool configuration handles it:

在实际使用中，您无需自行实现该逻辑。在 Fluid Compute 中，仅需在连接池配置之后添加一行代码即可：

```javascript
import { Pool } from "pg";

import { attachDatabasePool } from "@vercel/functions"



const pool = new Pool({

5  connectionString: process.env.POSTGRES_URL,

6});

attachDatabasePool(pool);
```

That’s it. Connection leak issue solved.

就这样。连接泄漏问题已解决。

[Read the full documentation on database connection pool management](https://vercel.com/docs/functions/functions-api-reference/vercel-functions-package#database-connection-pool-management) to see how it works in detail.

[参阅数据库连接池管理的完整文档](https://vercel.com/docs/functions/functions-api-reference/vercel-functions-package#database-connection-pool-management)，详细了解其工作原理。

### Cost implications

### 成本影响

Keeping a function alive slightly longer has a cost, but [with Active CPU Pricing](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute) for Fluid compute, the impact is close to zero:

函数保持活跃状态的时间稍长会产生一定成本，但得益于 Fluid 计算的 [主动 CPU 计费（Active CPU Pricing）](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute)，该影响几乎为零：

- While the function is alive, it can still process new requests. Only the very last request that would have leaked a connection adds extra time

  - 函数处于活跃状态时，仍可处理新请求；仅当最后一个可能导致连接泄漏的请求执行完毕后，才会额外延长运行时间。

- Waiting for the idle timer consumes no CPU time, so you only pay the small memory reservation cost

  - 等待空闲计时器触发的过程不消耗 CPU 时间，因此您只需承担较小的内存预留成本。

## Best practices

## 最佳实践

### Configure relatively low connection idle timeouts

### 配置相对较低的连接空闲超时时间

You control the idle timeout for your database connection pool. If connections are limited, it makes sense to set this to a relatively low value, such as 5 seconds. This provides good reuse when your service is busy and ensures idle connections are released quickly when traffic is low.

您可自主配置数据库连接池的空闲超时时间。若数据库连接资源有限，则建议将该值设为相对较低的数值（例如 5 秒）。这样既可在服务负载较高时实现良好的连接复用，又能在流量较低时快速释放空闲连接。

### Define your connection pools globally

### 全局定义连接池

In every compute model, define your database connection pools in a global scope so they can be shared between requests. This is the core purpose of a connection pool and avoids creating unnecessary new connections.

在所有计算模型中，均应在全局作用域内定义数据库连接池，以便在不同请求间共享。这正是连接池的核心设计目标，可有效避免创建不必要的新连接。

### Don’t set the maximum pool size to 1

### 请勿将连接池最大大小设为 1

There is bad advice on the internet that recommends setting the maximum pool size to 1 for AWS Lambda. This does not reduce total connections, as Lambda will not make more connections anyway, and it can still leak that single connection.

互联网上存在一种错误建议，声称应将 AWS Lambda 的连接池最大大小设为 1。但此举并不能减少总连接数——因为 Lambda 本就不会建立更多连接；而且该单一连接仍可能泄漏。

While a small maximum does not harm Lambda specifically, it is harmful for Fluid Compute and serverful models because it prevents them from taking advantage of concurrent execution.

虽然较小的最大值对 Lambda 本身并无明显危害，但它会对 Fluid Compute 和传统服务器化（serverful）模型造成负面影响，因为它会阻碍这些模型利用并发执行能力。

In most cases, the minimum pool size should remain at 1, which is typically the default. Increasing this value is rarely useful except for specific workloads that are extremely "bursty", where the time between bursts is longer than your idle timeout.

在大多数情况下，连接池最小大小应保持为 1（这通常是默认值）。仅在极少数场景下才需增大该值，例如面对极度“突发性”的工作负载，且两次突发之间的间隔时间长于您的空闲超时（idle timeout）。

### Utilize rolling releases

### 利用滚动发布（Rolling Releases）

[Rolling releases](https://vercel.com/docs/rolling-releases) in Vercel gradually shift traffic from one deployment to the next. This avoids a single “thundering herd” of new services coming online and connecting to the database.

Vercel 的 [滚动发布（Rolling Releases）](https://vercel.com/docs/rolling-releases) 会逐步将流量从一个部署版本迁移至下一个版本。此举可避免大量新服务实例同时上线并集中连接数据库所引发的“惊群效应”（thundering herd）。

Deployments systems such as Kubernetes with [rolling updates](https://kubernetes.io/docs/tutorials/kubernetes-basics/update/update-intro/) provide similar features.

Kubernetes 等部署系统也提供类似的 [滚动更新（rolling updates）](https://kubernetes.io/docs/tutorials/kubernetes-basics/update/update-intro/) 功能。

If you are on Fluid Compute, also use `attachDatabasePool` as described above to ensure idle connections are closed before suspension.

若您使用的是 Fluid Compute，请同时按上文所述调用 `attachDatabasePool`，以确保在函数挂起前关闭所有空闲连接。

## Summary

## 总结

Serverless compute does not require a larger number of database pool clients during normal operation. The real problem is leaking connections when serverless functions are suspended.

无服务器计算（serverless compute）在正常运行期间并不需要更多的数据库连接池客户端。真正的问题在于：当无服务器函数被挂起时，连接发生泄漏。

In traditional serverless compute, there is no known solution for this issue that avoids significant trade-offs.

在传统无服务器计算中，尚无已知方案能在不带来显著权衡的前提下解决此问题。

Modern serverless solutions such as [Fluid Compute](https://vercel.com/docs/fluid-compute) provide lifecycle hooks that allow connections to be released properly, preventing leaks with minimal additional cost and no impact on latency.

现代无服务器解决方案（例如 [Fluid Compute](https://vercel.com/docs/fluid-compute)）提供了生命周期钩子（lifecycle hooks），可确保连接被正确释放，从而以极低的额外开销防止连接泄漏，且对延迟毫无影响。