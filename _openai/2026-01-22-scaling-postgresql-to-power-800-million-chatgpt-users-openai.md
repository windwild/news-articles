---
title: "Scaling PostgreSQL to power 800 million ChatGPT users | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/scaling-postgresql"
date: "2026-01-22"
scraped_at: "2026-03-02T10:08:27.680917293+00:00"
language: "en-US"
translated: true
description: "An inside look at how OpenAI scaled PostgreSQL to millions of queries per second using replicas, caching, rate limiting, and workload isolation."
tags: ["Engineering"]
---
&#123;% raw %}

January 22, 2026

2026年1月22日


# Scaling PostgreSQL to power 800 million ChatGPT users

# 扩展 PostgreSQL 以支撑 8 亿 ChatGPT 用户

By Bohan Zhang, Member of the Technical Staff

作者：Bohan Zhang，技术团队成员


For years, PostgreSQL has been one of the most critical, under-the-hood data systems powering core products like ChatGPT and OpenAI’s API. As our user base grows rapidly, the demands on our databases have increased exponentially, too. Over the past year, our PostgreSQL load has grown by more than 10x, and it continues to rise quickly.

多年来，PostgreSQL 一直是支撑 ChatGPT 和 OpenAI API 等核心产品最关键的底层数据系统之一。随着用户规模的迅猛增长，数据库所承受的压力也呈指数级上升。过去一年中，我们的 PostgreSQL 负载增长超过 10 倍，且仍在快速攀升。

Our efforts to advance our production infrastructure to sustain this growth revealed a new insight: PostgreSQL can be scaled to reliably support much larger read-heavy workloads than many previously thought possible. The system (initially created by a team of scientists at University of California, Berkeley) has enabled us to support massive global traffic with a single primary [Azure PostgreSQL flexible server instance⁠(opens in a new window)](https://learn.microsoft.com/en-us/azure/postgresql/overview) and nearly 50 read replicas spread over multiple regions globally. This is the story of how we’ve scaled PostgreSQL at OpenAI to support millions of queries per second for 800 million users through rigorous optimizations and solid engineering; we’ll also cover key takeaways we learned along the way.

我们在升级生产基础设施以应对这一增长的过程中，获得了一个新认知：PostgreSQL 的可扩展性远超以往普遍认知——它能够稳定支撑规模大得多的读密集型工作负载。该系统最初由加州大学伯克利分校（University of California, Berkeley）的一组科学家研发，如今已助力我们仅凭一个主节点（即单个 [Azure PostgreSQL 灵活服务器实例⁠(在新窗口中打开)](https://learn.microsoft.com/en-us/azure/postgresql/overview)），搭配分布在全球多个区域的近 50 个只读副本，便承载起海量全球流量。本文将讲述 OpenAI 如何通过严谨的性能优化与扎实的工程实践，将 PostgreSQL 扩展至每秒支撑数百万查询、服务 8 亿用户；同时，我们也将分享在此过程中积累的关键经验与教训。

## Cracks in our initial design

## 初始架构中的隐患

After the launch of ChatGPT, traffic grew at an unprecedented rate. To support it, we rapidly implemented extensive optimizations at both the application and PostgreSQL database layers, scaled up by increasing the instance size, and scaled out by adding more read replicas. This architecture has served us well for a long time. With ongoing improvements, it continues to provide ample runway for future growth.

ChatGPT 上线后，流量以前所未有的速度激增。为支撑这一增长，我们迅速在应用层和 PostgreSQL 数据库层实施了大量优化措施：一方面通过增大实例规格实现垂直扩展（scale-up），另一方面通过增加只读副本实现水平扩展（scale-out）。该架构长期运行良好；而随着持续迭代优化，它仍能为未来增长提供充足的发展空间。

It may sound surprising that a single-primary architecture can meet the demands of OpenAI’s scale; however, making this work in practice isn’t simple. We’ve seen several SEVs caused by Postgres overload, and they often follow the same pattern: an upstream issue causes a sudden spike in database load, such as widespread cache misses from a caching-layer failure, a surge of expensive multi-way joins saturating CPU, or a write storm from a new feature launch. As resource utilization climbs, query latency rises and requests begin to time out. Retries then further amplify the load, triggering a vicious cycle with the potential to degrade the entire ChatGPT and API services.

单主节点架构（single-primary architecture）竟能满足 OpenAI 这一量级的业务需求，听起来或许令人惊讶；但要在实际生产环境中稳定运行，绝非易事。我们已多次遭遇因 PostgreSQL 过载引发的严重服务中断事件（SEV），其成因往往高度相似：上游系统异常导致数据库负载骤然飙升——例如缓存层故障引发大规模缓存失效（cache miss）、高开销的多表连接查询（multi-way joins）集中爆发并耗尽 CPU 资源，或某项新功能上线引发写入风暴（write storm）。随着资源使用率持续攀升，查询延迟随之升高，请求开始超时；而客户端重试机制又进一步加剧负载，最终触发恶性循环，严重时可能导致整个 ChatGPT 和 API 服务降级。

![Scaling load diagram](images/scaling-postgresql-to-power-800-million-chatgpt-users-openai/img_001.svg)

![负载扩展示意图](images/scaling-postgresql-to-power-800-million-chatgpt-users-openai/img_001.svg)

Although PostgreSQL scales well for our read-heavy workloads, we still encounter challenges during periods of high write traffic. This is largely due to PostgreSQL’s multiversion concurrency control (MVCC) implementation, which makes it less efficient for write-heavy workloads. For example, when a query updates a tuple or even a single field, the entire row is copied to create a new version. Under heavy write loads, this results in significant write amplification. It also increases read amplification, since queries must scan through multiple tuple versions (dead tuples) to retrieve the latest one. MVCC introduces additional challenges such as table and index bloat, increased index maintenance overhead, and complex autovacuum tuning. (You can find a deep-dive on these issues in a blog I wrote with Prof. Andy Pavlo at Carnegie Mellon University called [_The Part of PostgreSQL We Hate the Most_ ⁠(opens in a new window)](https://www.cs.cmu.edu/~pavlo/blog/2023/04/the-part-of-postgresql-we-hate-the-most.html), [cited⁠(opens in a new window)](https://en.wikipedia.org/wiki/PostgreSQL#cite_note-37) in the PostgreSQL Wikipedia page.)

尽管 PostgreSQL 在读多写少的工作负载下具备良好的扩展性，但在高写入流量期间，我们仍会遇到挑战。这主要源于 PostgreSQL 的多版本并发控制（MVCC）实现机制，使其在写密集型工作负载下效率较低。例如，当查询更新一个元组（tuple），甚至仅更新单个字段时，整个行都会被复制以生成新版本。在高写入负载下，这会导致显著的写放大（write amplification）。同时，读放大（read amplification）也随之增加，因为查询必须扫描多个元组版本（包括已失效的“死元组”）才能获取最新版本。MVCC 还带来了其他挑战，例如表与索引膨胀（bloat）、索引维护开销上升，以及自动清理（autovacuum）调优复杂度提高。（关于这些问题的深入分析，可参阅我与卡内基梅隆大学 Andy Pavlo 教授合著的一篇博客：[_The Part of PostgreSQL We Hate the Most_ ⁠(在新窗口中打开)](https://www.cs.cmu.edu/~pavlo/blog/2023/04/the-part-of-postgresql-we-hate-the-most.html)，该文已被 [PostgreSQL 维基百科页面引用⁠(在新窗口中打开)](https://en.wikipedia.org/wiki/PostgreSQL#cite_note-37)。）

## Scaling PostgreSQL to millions of QPS

## 将 PostgreSQL 扩展至每秒百万级查询（QPS）

To mitigate these limitations and reduce write pressure, we’ve migrated, and continue to migrate, shardable (i.e. workloads that can be horizontally partitioned), write-heavy workloads to sharded systems such as Azure Cosmos DB, optimizing application logic to minimize unnecessary writes. We also no longer allow adding new tables to the current PostgreSQL deployment. New workloads default to the sharded systems.

为缓解上述限制并降低写入压力，我们已将可分片（即支持水平分区）的写密集型工作负载迁移至分片系统（如 Azure Cosmos DB），并持续推进此类迁移；同时优化应用逻辑，最大限度减少非必要写入。此外，我们已禁止向当前 PostgreSQL 部署中新增数据表。所有新工作负载默认采用分片系统。

Even as our infrastructure has evolved, PostgreSQL has remained unsharded, with a single primary instance serving all writes. The primary rationale is that sharding existing application workloads would be highly complex and time-consuming, requiring changes to hundreds of application endpoints and potentially taking months or even years. Since our workloads are primarily read-heavy, and we’ve implemented extensive optimizations, the current architecture still provides ample headroom to support continued traffic growth. While we’re not ruling out sharding PostgreSQL in the future, it’s not a near-term priority given the sufficient runway we have for current and future growth.

即便基础设施持续演进，PostgreSQL 仍保持非分片架构——所有写操作均由单一主实例（primary instance）处理。其主要原因在于：对现有应用工作负载实施分片将极为复杂且耗时，需修改数百个应用端点，整个过程可能持续数月甚至数年。由于我们的工作负载以读为主，且已实施大量优化措施，当前架构仍有充足余量支撑业务流量的持续增长。虽然我们并未完全排除未来对 PostgreSQL 实施分片的可能性，但鉴于当前及可预见未来的增长空间依然充裕，分片并非近期优先事项。

In the following sections, we’ll dive into the challenges we faced and the extensive optimizations we implemented to address them and prevent future outages, pushing PostgreSQL to its limits and scaling it to millions of queries per second (QPS).

在接下来的章节中，我们将深入探讨所面临的挑战，以及为应对这些挑战、预防未来服务中断而实施的大规模优化措施——这些努力将 PostgreSQL 推向性能极限，并成功将其扩展至每秒百万级查询（QPS）。

#### Reducing load on the primary

#### 降低主实例负载

_Challenge: With only one writer, a single-primary setup can’t scale writes. Heavy write spikes can quickly overload the primary and impact services like ChatGPT and our API._

_挑战：单主实例架构仅有一个写入节点，无法横向扩展写能力。突发的高写入流量极易使主实例过载，进而影响 ChatGPT 及我们 API 等关键服务。_

Solution: We minimize load on the primary as much as possible—both reads and writes—to ensure it has sufficient capacity to handle write spikes. Read traffic is offloaded to replicas wherever possible. However, some read queries must remain on the primary because they’re part of write transactions. For those, we focus on ensuring they’re efficient and avoid slow queries. For write traffic, we’ve migrated shardable, write-heavy workloads to sharded systems such as Azure CosmosDB. Workloads that are harder to shard but still generate high write volume take longer to migrate, and that process is still ongoing. We also aggressively optimized our applications to reduce write load; for example, we’ve fixed application bugs that caused redundant writes and introduced lazy writes, where appropriate, to smooth traffic spikes. In addition, when backfilling table fields, we enforce strict rate limits to prevent excessive write pressure.

解决方案：我们尽可能降低主实例的负载（包括读与写），确保其保有足够容量以应对突发写入高峰。读流量尽可能卸载至只读副本（replica）。然而，部分读查询必须保留在主实例上执行，因其属于写事务的一部分；对此类查询，我们重点保障其执行效率，杜绝慢查询。对于写流量，我们已将可分片的写密集型工作负载迁移至 Azure Cosmos DB 等分片系统。而那些难以分片但仍产生高写入量的工作负载，迁移周期更长，目前仍在持续推进中。此外，我们还大力优化应用程序以降低写入负载：例如修复了导致重复写入的应用缺陷，并在合适场景引入“懒写入”（lazy writes）机制，以平抑流量峰值；同时，在对表字段进行回填（backfill）操作时，严格执行速率限制，防止写入压力过大。

#### Query optimization

#### 查询优化

_Challenge: We identified several expensive queries in PostgreSQL. In the past, sudden volume spikes in these queries would consume large amounts of CPU, slowing both ChatGPT and API requests._

_挑战：我们在 PostgreSQL 中识别出若干高开销查询。过去，这些查询一旦出现突发性流量激增，便会大量占用 CPU 资源，拖慢 ChatGPT 和 API 请求的响应速度。_

Solution: A few expensive queries, such as those joining many tables together, can significantly degrade or even bring down the entire service. We need to continuously optimize PostgreSQL queries to ensure they’re efficient and avoid common Online Transaction Processing (OLTP) anti-patterns. For example, we once identified an extremely costly query that joined 12 tables, where spikes in this query were responsible for past high-severity SEVs. We should avoid complex multi-table joins whenever possible. If joins are necessary, we learned to consider breaking down the query and move complex join logic to the application layer instead. Many of these problematic queries are generated by Object-Relational Mapping frameworks (ORMs), so it’s important to carefully review the SQL they produce and ensure it behaves as expected. It’s also common to find long-running idle queries in PostgreSQL. Configuring timeouts like `idle_in_transaction_session_timeout` is essential to prevent them from blocking autovacuum.

解决方案：少数开销巨大的查询（例如涉及多表连接的查询）可能显著拖慢甚至完全中断整个服务。我们需要持续优化 PostgreSQL 查询，确保其高效执行，并避免常见的在线事务处理（OLTP）反模式。例如，我们曾发现一个极其昂贵的查询，它连接了 12 张表；该查询执行量的突发增长曾是过去多次高严重性事件（SEV）的直接原因。我们应尽可能避免复杂的多表连接。若确需连接，我们已学会将查询拆解，并将复杂的连接逻辑移至应用层实现。许多此类问题查询由对象关系映射框架（ORM）自动生成，因此必须仔细审查 ORM 生成的 SQL，确保其行为符合预期。此外，在 PostgreSQL 中也常出现长时间空闲的查询。配置超时参数（如 `idle_in_transaction_session_timeout`）至关重要，可防止这些空闲查询阻塞自动清理（autovacuum）进程。

#### Single point of failure mitigation

#### 单点故障缓解

_Challenge: If a read replica goes down, traffic can still be routed to other replicas. However, relying on a single writer means having a single point of failure—if it goes down, the entire service is affected._

挑战：若某个只读副本宕机，流量仍可被路由至其他副本。但若仅依赖单一写入节点（主节点），则存在单点故障风险——一旦该节点宕机，整个服务将受到影响。

Solution: Most critical requests only involve read queries. To mitigate the single point of failure in the primary, we offloaded those reads from the writer to replicas, ensuring those requests can continue serving even if the primary goes down. While write operations would still fail, the impact is reduced; it’s no longer a SEV0 since reads remain available.

解决方案：绝大多数关键请求仅包含读操作。为缓解主节点的单点故障风险，我们将这些读请求从主节点卸载至只读副本，从而确保即使主节点宕机，相关请求仍可持续提供服务。虽然写操作在此期间仍将失败，但整体影响已大幅降低——由于读服务保持可用，事件严重性不再达到 SEV0 级别。

To mitigate primary failures, we run the primary in High-Availability (HA) mode with a hot standby, a continuously synchronized replica that is always ready to take over serving traffic. If the primary goes down or needs to be taken offline for maintenance, we can quickly promote the standby to minimize downtime. The Azure PostgreSQL team has done significant work to ensure these failovers remain safe and reliable even under very high load. To handle read replica failures, we deploy multiple replicas in each region with sufficient capacity headroom, ensuring that a single replica failure doesn’t lead to a regional outage.

为应对主节点故障，我们将主节点以高可用性（HA）模式运行，并配备热备（hot standby）——即一个持续同步、随时可接管流量的副本。一旦主节点宕机或需下线维护，我们可快速将热备提升为主节点，最大限度缩短停机时间。Azure PostgreSQL 团队已开展大量工作，确保此类故障转移即使在极高负载下依然安全可靠。针对只读副本故障，我们在每个区域部署多个副本，并预留充足的容量余量，从而保证单个副本故障不会引发区域性服务中断。

#### Workload isolation

#### 工作负载隔离

_Challenge: We often encounter situations where certain requests consume a disproportionate amount of resources on PostgreSQL instances. This can lead to degraded performance for other workloads running on the same instances. For example, a new feature launch can introduce inefficient queries that heavily consume PostgreSQL CPU, slowing down requests for other critical features._

挑战：我们常遇到某些请求在 PostgreSQL 实例上占用不成比例的资源，进而导致同一实例上其他工作负载性能下降。例如，某新功能上线可能引入低效查询，大量消耗 PostgreSQL 的 CPU 资源，拖慢其他关键功能的请求响应速度。

Solution: To mitigate the “noisy neighbor” problem, we isolate workloads onto dedicated instances to ensure that sudden spikes in resource-intensive requests don’t impact other traffic. Specifically, we split requests into low-priority and high-priority tiers and route them to separate instances. This way, even if a low-priority workload becomes resource-intensive, it won’t degrade the performance of high-priority requests. We apply the same strategy across different products and services as well, so that activity from one product does not affect the performance or reliability of another.

解决方案：为缓解“嘈杂邻居”（noisy neighbor）问题，我们将不同工作负载隔离至专用实例，确保资源密集型请求的突发不会影响其他流量。具体而言，我们将请求划分为低优先级与高优先级两个层级，并分别路由至独立实例。如此一来，即便低优先级工作负载突然变得资源密集，也不会损害高优先级请求的性能。该策略同样应用于不同产品与服务之间，确保某一产品的活动不会影响其他产品的性能或可靠性。

#### Connection pooling

#### 连接池管理

_Challenge: Each instance has a maximum connection limit (5,000 in Azure PostgreSQL). It’s easy to run out of connections or accumulate too many idle ones. We’ve previously had incidents caused by connection storms that exhausted all available connections._

挑战：每个实例均有最大连接数限制（Azure PostgreSQL 中为 5,000）。实践中极易耗尽连接数，或积累过多空闲连接。我们此前曾发生过因“连接风暴”（connection storm）耗尽全部可用连接而导致的服务事件。

Solution: We deployed PgBouncer as a proxy layer to pool database connections. Running it in statement or transaction pooling mode allows us to efficiently reuse connections, greatly reducing the number of active client connections. This also cuts connection setup latency: in our benchmarks, the average connection time dropped from 50 milliseconds (ms) to 5 ms. Inter-region connections and requests can be expensive, so we co-locate the proxy, clients, and replicas in the same region to minimize network overhead and connection use time. Moreover, PgBouncer must be configured carefully. Settings like idle timeouts are critical to prevent connection exhaustion.

解决方案：我们部署 PgBouncer 作为代理层，对数据库连接进行连接池管理。将其运行在语句级（statement）或事务级（transaction）连接池模式下，可高效复用连接，大幅减少活跃客户端连接数。同时，该方案显著降低了连接建立延迟：根据我们的基准测试，平均连接时间从 50 毫秒（ms）降至 5 ms。跨地域连接与请求开销较高，因此我们将代理、客户端及只读副本统一部署在同一地域，以最小化网络开销和连接占用时长。此外，PgBouncer 必须经过审慎配置——例如空闲超时（idle timeout）等参数设置至关重要，否则可能导致连接耗尽。

![postgreSQL proxy diagram](images/scaling-postgresql-to-power-800-million-chatgpt-users-openai/img_002.svg)

![PostgreSQL 代理架构图](images/scaling-postgresql-to-power-800-million-chatgpt-users-openai/img_002.svg)

Each read replica has its own Kubernetes deployment running multiple PgBouncer pods. We run multiple Kubernetes deployments behind the same Kubernetes Service, which load-balances traffic across pods.

每个只读副本均拥有独立的 Kubernetes Deployment，运行多个 PgBouncer Pod。我们通过同一个 Kubernetes Service 聚合多个此类 Deployment，由该 Service 对流量进行跨 Pod 负载均衡。

#### Caching

#### 缓存

_Challenge: A sudden spike in cache misses can trigger a surge of reads on the PostgreSQL database, saturating CPU and slowing user requests._

挑战：缓存未命中率突然飙升，可能引发 PostgreSQL 数据库读请求激增，导致 CPU 资源饱和，进而拖慢用户请求响应速度。

Solution: To reduce read pressure on PostgreSQL, we use a caching layer to serve most of the read traffic. However, when cache hit rates drop unexpectedly, the burst of cache misses can push a large volume of requests directly to PostgreSQL. This sudden increase in database reads consumes significant resources, slowing down the service. To prevent overload during cache-miss storms, we implement a cache locking (and leasing) mechanism so that only a single reader that misses on a particular key fetches the data from PostgreSQL. When multiple requests miss on the same cache key, only one request acquires the lock and proceeds to retrieve the data and repopulate the cache. All other requests wait for the cache to be updated rather than all hitting PostgreSQL at once. This significantly reduces redundant database reads and protects the system from cascading load spikes.

解决方案：为减轻 PostgreSQL 的读负载，我们引入缓存层来承载绝大多数读请求。然而，当缓存命中率意外下降时，大量缓存未命中会瞬间将海量请求直接打向 PostgreSQL，造成数据库读资源被大量占用，服务响应变慢。为避免缓存雪崩（cache-miss storm）引发系统过载，我们实现了缓存锁（cache locking）与租约（leasing）机制：针对同一缓存键（key）的未命中请求中，仅允许一个请求获取锁并从 PostgreSQL 加载数据、回填缓存；其余请求则等待缓存更新完成，而非全部并发访问数据库。该机制显著减少了冗余数据库读取，有效防止了级联式负载尖峰对系统的冲击。

#### Scaling read replicas

#### 扩展只读副本

_Challenge: The primary streams Write Ahead Log (WAL) data to every read replica. As the number of replicas increases, the primary must ship WAL to more instances, increasing pressure on both network bandwidth and CPU. This causes higher and more unstable replica lag, which makes the system harder to scale reliably._

挑战：主节点需将预写日志（Write Ahead Log, WAL）实时流式传输至每一个只读副本。随着副本数量增加，主节点需向更多实例发送 WAL，从而加剧网络带宽与 CPU 压力。这导致副本延迟（replica lag）升高且波动加剧，使系统难以稳定、可靠地横向扩展。

Solution: We operate nearly 50 read replicas across multiple geographic regions to minimize latency. However, with the current architecture, the primary must stream WAL to every replica. Although it currently scales well with very large instance types and high-network bandwidth, we can’t keep adding replicas indefinitely without eventually overloading the primary. To address this, we’re collaborating with the Azure PostgreSQL team on [cascading replication⁠(opens in a new window)](https://www.postgresql.org/docs/current/warm-standby.html#CASCADING-REPLICATION), where intermediate replicas relay WAL to downstream replicas. This approach allows us to scale to potentially over a hundred replicas without overwhelming the primary. However, it also introduces additional operational complexity, particularly around failover management. The feature is still in testing; we’ll ensure it’s robust and can fail over safely before rolling it out to production.

解决方案：我们已在多个地理区域部署近 50 个只读副本，以最大限度降低访问延迟。但当前架构下，主节点仍需向每个副本单独流式传输 WAL。尽管借助超大规格实例与高带宽网络，该架构目前尚能良好扩展，但若持续无限制地增加副本数量，终将导致主节点不堪重负。为此，我们正与 Azure PostgreSQL 团队合作推进 [级联复制（cascading replication）⁠(在新窗口中打开)](https://www.postgresql.org/docs/current/warm-standby.html#CASCADING-REPLICATION) —— 即由中间层级的副本接收 WAL 后，再向下游副本转发。该方案有望支持副本规模扩展至百余个，而不会压垮主节点。不过，它也带来了额外的运维复杂性，尤其体现在故障转移（failover）管理方面。该功能目前仍处于测试阶段；在正式上线生产环境前，我们将确保其实现足够健壮，并能安全、可靠地完成故障转移。

![postgreSQL cascading replication diagram](images/scaling-postgresql-to-power-800-million-chatgpt-users-openai/img_003.svg)

![PostgreSQL 级联复制架构图](images/scaling-postgresql-to-power-800-million-chatgpt-users-openai/img_003.svg)

#### Rate limit

#### 限流

_Challenge: A sudden traffic spike on specific endpoints, a surge of expensive queries, or a retry storm can quickly exhaust critical resources such as CPU, I/O, and connections, which causes widespread service degradation._

_挑战：特定端点突发的流量激增、高开销查询的集中涌入，或重试风暴，都可能迅速耗尽 CPU、I/O 和连接等关键资源，从而引发大范围的服务降级。_

Solution: We implemented rate-limiting across multiple layers—application, connection pooler, proxy, and query—to prevent sudden traffic spikes from overwhelming database instances and triggering cascading failures. It’s also crucial to avoid overly short retry intervals, which can trigger retry storms. We also enhanced the ORM layer to support rate limiting and when necessary, fully block specific query digests. This targeted form of load shedding enables rapid recovery from sudden surges of expensive queries.

解决方案：我们在多个层级（应用层、连接池层、代理层和查询层）实施了限流机制，以防止突发流量压垮数据库实例并引发级联故障。同时，避免设置过短的重试间隔也至关重要，否则极易触发重试风暴。我们还增强了 ORM 层，使其支持限流功能；在必要时，可完全屏蔽特定查询指纹（query digest）。这种有针对性的负载削减策略，使系统能够快速从高开销查询的突发洪峰中恢复。

#### Schema Management

#### 表结构管理

_Challenge: Even a small schema change, such as altering a column type, can trigger_ [_a full table rewrite_ ⁠(opens in a new window)](https://www.crunchydata.com/blog/when-does-alter-table-require-a-rewrite) _. We therefore apply schema changes cautiously—limiting them to lightweight operations and avoiding any that rewrite entire tables._

_挑战：即使是最小的表结构变更（例如修改列的数据类型），也可能触发_[_整表重写_⁠(在新窗口中打开)](https://www.crunchydata.com/blog/when-does-alter-table-require-a-rewrite)_。因此，我们对表结构变更持高度谨慎态度——仅允许轻量级操作，并严格规避任何会导致整表重写的变更。_

Solution: Only lightweight schema changes are permitted, such as adding or removing certain columns that do not trigger a full table rewrite. We enforce a strict 5-second timeout on schema changes. Creating and dropping indexes concurrently is allowed. Schema changes are restricted to existing tables. If a new feature requires additional tables, they must be in alternative sharded systems such as Azure CosmosDB rather than PostgreSQL. When backfilling a table field, we apply strict rate limits to prevent write spikes. Although this process can sometimes take over a week, it ensures stability and avoids any production impact.

解决方案：仅允许轻量级的表结构变更，例如添加或删除不会触发整表重写的特定列。我们对所有表结构变更强制执行严格的 5 秒超时限制。允许并发创建和删除索引。表结构变更仅限于现有表。若新功能需引入额外数据表，则必须部署在 Azure CosmosDB 等分片式替代系统中，而非 PostgreSQL。在对表字段执行回填（backfill）操作时，我们施加严格的速率限制，以防写入流量激增。尽管该过程有时可能耗时超过一周，但它保障了系统稳定性，并彻底规避了对生产环境的影响。

## Results and the road ahead

## 成果与未来规划

This effort demonstrates that with the right design and optimizations, Azure PostgreSQL can be scaled to handle the largest production workloads. PostgreSQL handles millions of QPS for read-heavy workloads, powering OpenAI’s most critical products like ChatGPT and the API platform. We added nearly 50 read replicas, while keeping replication lag near zero, maintained low-latency reads across geo-distributed regions, and built sufficient capacity headroom to support future growth.

本次实践表明：通过合理的设计与优化，Azure PostgreSQL 完全可扩展至支撑最大规模的生产工作负载。PostgreSQL 在读密集型场景下可承载每秒数百万次查询（QPS），为 OpenAI 最关键的产品（如 ChatGPT 和 API 平台）提供核心数据库服务。我们新增了近 50 个只读副本，在将复制延迟控制在接近零的同时，实现了跨地理分布式区域的低延迟读取，并预留了充足的容量冗余，以支撑未来的持续增长。

This scaling works while still minimizing latency and improving reliability. We consistently deliver low double-digit millisecond p99 client-side latency and five-nines availability in production. And over the past 12 months, we’ve had only one SEV-0 PostgreSQL incident (it occurred during the [viral launch⁠(opens in a new window)](https://newsletter.pragmaticengineer.com/p/chatgpt-images) of ChatGPT ImageGen, when write traffic suddenly surged by more than 10x as over 100 million new users signed up within a week.)

此次扩展在显著提升吞吐能力的同时，仍有效抑制了延迟并增强了系统可靠性。我们在生产环境中持续达成客户端侧 p99 延迟稳定在两位数毫秒以内，并实现“五个九”（99.999%）的可用性。过去 12 个月内，PostgreSQL 仅发生过一次 SEV-0 级严重事故（该事故发生在 [ChatGPT 图像生成功能的病毒式发布期间⁠(在新窗口中打开)](https://newsletter.pragmaticengineer.com/p/chatgpt-images)，当时因一周内新增用户超 1 亿，写入流量骤增逾 10 倍所致）。

While we’re happy with how far PostgreSQL has taken us, we continue to push its limits to ensure we have sufficient runway for future growth. We’ve already migrated the shardable write-heavy workloads to our sharded systems like CosmosDB. The remaining write-heavy workloads are more challenging to shard—we’re actively migrating those as well to further offload writes from the PostgreSQL primary. We’re also working with Azure to enable cascading replication so we can safely scale to significantly more read replicas.

尽管我们对 PostgreSQL 目前所取得的成就深感满意，但仍将持续探索其能力边界，以确保为未来增长留足演进空间。我们已将具备分片条件的写密集型工作负载迁移至 CosmosDB 等分片式系统。而剩余的写密集型负载分片难度更高——我们正积极推进其迁移工作，以进一步减轻 PostgreSQL 主库的写入压力。此外，我们正与 Azure 团队协作，推动实现级联复制（cascading replication）功能，从而安全地扩展至数量远超当前的只读副本规模。

Looking ahead, we’ll continue to explore additional approaches to further scale, including sharded PostgreSQL or alternative distributed systems, as our infrastructure demands continue to grow.

展望未来，随着基础设施需求持续增长，我们将继续探索更多可进一步提升扩展性的方案，包括分片 PostgreSQL 或其他分布式系统。

- [2026](https://openai.com/news/?tags=2026)

- [2026](https://openai.com/news/?tags=2026)
&#123;% endraw %}
