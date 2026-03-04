---
title: "Update regarding Vercel service disruption on October 20, 2025 - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/update-regarding-vercel-service-disruption-on-october-20-2025"
date: "2025-10-21"
scraped_at: "2026-03-02T09:26:51.104052647+00:00"
language: "en-zh"
translated: true
description: "Update regarding Vercel service disruption on October 20, 2025. Read the summary of impact, timeline, root cause, and steps we’re taking to improve reliability."
---

render_with_liquid: false
Oct 21, 2025

2025年10月21日

At Vercel, our philosophy is to _take ownership for_, not blame, our vendors. Customers use our services to gain velocity, reliability, and ship wonderful products. Whether we picked A or B as one of the components of our “circuit design” is entirely our responsibility.

在 Vercel，我们的理念是——对供应商相关问题**主动担责，而非推诿归咎**。客户使用我们的服务，是为了获得开发速度、系统可靠性，并高效交付卓越产品。无论我们在自身“电路设计”中选用组件 A 还是 B，其最终责任完全在于我们自身。

Vercel is fully accountable for this incident, even if it's [now public](https://www.cnn.com/business/live-news/amazon-tech-outage-10-20-25-intl) that it was triggered by the unexpected outage of AWS `us-east-1` (called `iad1` [region](https://vercel.com/docs/regions#region-list)). Vercel uses AWS [infrastructure primitives](https://vercel.com/blog/behind-the-scenes-of-vercels-infrastructure), is part of the [AWS marketplace](https://vercel.com/blog/vercel-and-aws-partner-on-ai-tools-and-experiences), offers [secure connectivity](https://vercel.com/changelog/vpc-peering-now-available-as-self-service-for-vercel-secure-compute) to AWS services, and shares a long history with AWS of [pioneering serverless computing](https://vercel.com/blog/aws-and-vercel-accelerating-innovation-with-serverless-computing).

尽管此次事件的直接诱因——AWS `us-east-1`（即 `iad1` [区域](https://vercel.com/docs/regions#region-list)）意外中断——目前已[公开披露](https://www.cnn.com/business/live-news/amazon-tech-outage-10-20-25-intl)，Vercel 仍对此事件**承担全部责任**。Vercel 深度依赖 AWS [基础设施原语](https://vercel.com/blog/behind-the-scenes-of-vercels-infrastructure)，是 [AWS Marketplace](https://vercel.com/blog/vercel-and-aws-partner-on-ai-tools-and-experiences) 的合作伙伴，提供与 AWS 服务的 [安全互联能力](https://vercel.com/changelog/vpc-peering-now-available-as-self-service-for-vercel-secure-compute)，并与 AWS 在 [引领无服务器计算发展](https://vercel.com/blog/aws-and-vercel-accelerating-innovation-with-serverless-computing) 方面拥有长期协作历史。

To our customers, Vercel is **unequivocally responsible for this outage**.

对我们的客户而言，Vercel **对此次中断负有无可争议的全部责任**。

Our goal is to [simplify](https://rauchg.com/2025/the-ai-cloud) the cloud and offer its best version. Through [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure), we help developers focus on the application layer by deploying global infrastructure resources that are highly optimized. We operate our Compute, CDN, and Firewall services across 19 AWS regions, terminating and securing traffic in 95 cities and 130+ global points of presence.

我们的目标是[简化云服务](https://rauchg.com/2025/the-ai-cloud)，并提供其最优形态。借助 [框架定义的基础设施（Framework-Defined Infrastructure）](https://vercel.com/blog/framework-defined-infrastructure)，我们通过部署高度优化的全球基础设施资源，帮助开发者专注于应用层开发。我们的计算（Compute）、内容分发网络（CDN）和防火墙（Firewall）服务运行于 19 个 AWS 区域，在全球 95 座城市及 130 多个接入点（Points of Presence）完成流量终止与安全防护。

Yesterday, we fell short of this promise. While a significant amount of traffic [was still served](https://x.com/rauchg/status/1980314641613091318), and we shielded customers from the exposure to a single global point of failure, our ambition is to **enable customers to never drop a single request,** even in the event of an outage.

昨日，我们未能兑现这一承诺。尽管仍有大量流量[持续得到服务](https://x.com/rauchg/status/1980314641613091318)，且我们成功将客户隔离于单一全局故障点之外，但我们的远大目标是：**即使在发生中断的情况下，也确保客户不丢失任何一次请求**。

## Service disruption overview

## 服务中断概览

The AWS outage caused 2 independent incidents on the Vercel side.

AWS 的中断在 Vercel 侧引发了两起相互独立的事件。

The first incident, caused by the initial loss of the `us-east-1` data center, led to temporary disruption of Vercel’s serving of customers' production traffic.

第一起事件由 `us-east-1` 数据中心初始失效引发，导致 Vercel 短暂中断了客户生产流量的响应服务。

The second incident, caused by an outage of our feature flag provider as a cascading failure of the `us-east-1` outage, had no impact on serving production traffic, but did cause a major disruption of Vercel’s control plane which impacted the Vercel dashboard, APIs, builds and log processing.

第二起事件是 `us-east-1` 中断引发的级联故障——我们的功能开关（Feature Flag）服务商随之宕机。该事件虽未影响生产流量的服务能力，却严重扰乱了 Vercel 的控制平面，波及 Vercel 控制台（Dashboard）、各类 API、构建（Builds）及日志处理（Log Processing）功能。

### Initial loss of the `us-east-1` region

### `us-east-1` 区域的初始故障

Vercel’s stack for serving production traffic is designed to survive loss of any one of our 19 regions of operation. We have demonstrated this capability many times in the past, but Monday’s incident caused an unexpected cascading failure leading to additional impact.

Vercel 用于服务生产流量的技术栈，设计上可承受其 19 个运营区域中任意一个区域的完全失效。我们过去曾多次成功验证过这一能力，但本周一的事件却意外引发了级联故障，导致了额外的影响。

![In red: Impact of primary outage on global traffic.](images/update-regarding-vercel-service-disruption-on-october-20-2025-vercel/img_001.jpg)![In red: Impact of primary outage on global traffic.](images/update-regarding-vercel-service-disruption-on-october-20-2025-vercel/img_002.jpg)![In red: Impact of primary outage on global traffic.](images/update-regarding-vercel-service-disruption-on-october-20-2025-vercel/img_003.jpg)![In red: Impact of primary outage on global traffic.](images/update-regarding-vercel-service-disruption-on-october-20-2025-vercel/img_004.jpg)In red: Impact of primary outage on global traffic.

![图中红色部分：主故障对全球流量的影响。](images/update-regarding-vercel-service-disruption-on-october-20-2025-vercel/img_001.jpg)![图中红色部分：主故障对全球流量的影响。](images/update-regarding-vercel-service-disruption-on-october-20-2025-vercel/img_002.jpg)![图中红色部分：主故障对全球流量的影响。](images/update-regarding-vercel-service-disruption-on-october-20-2025-vercel/img_003.jpg)![图中红色部分：主故障对全球流量的影响。](images/update-regarding-vercel-service-disruption-on-october-20-2025-vercel/img_004.jpg)图中红色部分：主故障对全球流量的影响。

Our team was first alerted of initial issues at 06:55 UTC. At first, we only observed minor disruption of traffic. Out of abundance of caution, the team began re-routing traffic away from `us-east-1` at 07:15 UTC, restoring serving for end users connecting directly to that region.

我们的团队于协调世界时（UTC）06:55 首次收到初始问题告警。起初，我们仅观察到流量出现轻微中断。出于高度谨慎考虑，团队于 UTC 07:15 开始将流量从 `us-east-1` 区域重新路由，恢复了直接连接该区域的终端用户的访问服务。

At 07:25 UTC we began rerouting function invocations for customers with [configured backup or secondary regions](https://vercel.com/docs/functions/configuring-functions/region), restoring their full service.

UTC 07:25，我们开始为已[配置备份或次要区域](https://vercel.com/docs/functions/configuring-functions/region)的客户重新路由函数调用，全面恢复其服务。

At 07:45 UTC a cascading failure led to a loss of a percentage of our global caching infrastructure leading to failures of static file serving peaking at about 22% of traffic. This period was the largest impact throughout the event. Service was restored at 08:18 UTC. We have already mitigated the root cause of this cascading failure.

UTC 07:45，一次级联故障导致我们部分全球缓存基础设施失效，静态文件服务失败率一度达到总流量的约 22%。这是本次事件中影响最严重的阶段。服务已于 UTC 08:18 恢复。该级联故障的根本原因目前已得到解决。

![The yellow line shows elevated errors in function invocations during the outage window.](images/update-regarding-vercel-service-disruption-on-october-20-2025-vercel/img_005.jpg)![The yellow line shows elevated errors in function invocations during the outage window.](images/update-regarding-vercel-service-disruption-on-october-20-2025-vercel/img_006.jpg)![The yellow line shows elevated errors in function invocations during the outage window.](images/update-regarding-vercel-service-disruption-on-october-20-2025-vercel/img_007.jpg)![The yellow line shows elevated errors in function invocations during the outage window.](images/update-regarding-vercel-service-disruption-on-october-20-2025-vercel/img_008.jpg)The yellow line shows elevated errors in function invocations during the outage window.

![黄色折线：故障窗口期内函数调用错误率显著升高。](images/update-regarding-vercel-service-disruption-on-october-20-2025-vercel/img_005.jpg)![黄色折线：故障窗口期内函数调用错误率显著升高。](images/update-regarding-vercel-service-disruption-on-october-20-2025-vercel/img_006.jpg)![黄色折线：故障窗口期内函数调用错误率显著升高。](images/update-regarding-vercel-service-disruption-on-october-20-2025-vercel/img_007.jpg)![黄色折线：故障窗口期内函数调用错误率显著升高。](images/update-regarding-vercel-service-disruption-on-october-20-2025-vercel/img_008.jpg)黄色折线：故障窗口期内函数调用错误率显著升高。

For customers who do not have multiple function regions configured and who use `us-east-1` as their only region, function invocations were restored at 09:21 UTC.

对于未配置多个函数区域、且仅使用 `us-east-1` 作为唯一区域的客户，其函数调用服务已于 UTC 09:21 恢复。

### Secondary disruption of Vercel’s control plane

### Vercel 控制平面的二次中断

Vercel's control plane uses `us-west-1` as its primary region and was respectively not directly impacted by the `us-east-1` outage. However, at 19:20 UTC a feature flag provider used by Vercel’s control plane had a major outage likely caused by downstream effects of the earlier `us-east-1` disruption.

Vercel 的控制平面以 `us-west-1` 作为其主区域，因此并未直接受到 `us-east-1` 故障的影响。然而，UTC 19:20，Vercel 控制平面所依赖的一个功能开关（feature flag）服务商发生了严重中断——此次中断极有可能是早前 `us-east-1` 故障引发的下游连锁反应所致。

Vercel’s control plane is used by Vercel’s dashboard, CLI, API, and services such as log forwarding. This is an entirely independent system of Vercel’s serving stack and hence this disruption had no impact on serving production traffic for our customers. However, it did lead to customers being unable to deploy, initiate rollbacks, and perform other administrative tasks.

Vercel 的控制平面被 Vercel 仪表板、CLI、API 以及日志转发等服务所使用。该控制平面与 Vercel 的服务堆栈完全独立，因此本次中断未对客户生产流量的正常服务造成任何影响。然而，它确实导致客户无法执行部署、回滚操作以及其他管理任务。

The unavailability of the feature flag provider caused an exhaustion of resources in our primary Kubernetes cluster and delayed or caused failures of processing.

功能开关（feature flag）提供方的不可用，导致我们主 Kubernetes 集群资源耗尽，进而延迟或致使相关处理任务失败。

At 19:48 UTC the team began to experiment with and then incrementally roll out a mitigation for the unavailability of the feature flag provider and the code pattern leading to resource exhaustion. Full restoration of control plane services occurred around 03:00 UTC.

协调世界时（UTC）19:48，团队开始尝试并逐步上线一项缓解措施，以应对功能开关提供方不可用及引发资源耗尽的代码模式问题。控制平面服务于 UTC 时间约 03:00 全面恢复。

For additional details and service-specific information, [see the full timeline](https://vercel.com/blog/update-regarding-vercel-service-disruption-on-october-20-2025#incident-timeline).

如需更多详情及面向具体服务的信息，请参阅[完整时间线](https://vercel.com/blog/update-regarding-vercel-service-disruption-on-october-20-2025#incident-timeline)。

## The disruption from the perspective of a request

## 从单个请求视角看本次中断

To provide additional background, in this section we explain the service disruption from the perspective of a request based on the example of a request to [`rauchg.com`](http://rauchg.com/):

为提供更深入的背景信息，本节将以对 [`rauchg.com`](http://rauchg.com/) 发起的一次请求为例，从请求生命周期的角度解释本次服务中断：

1\. **A DNS lookup is made to** **`rauchg.com`** **to resolve the** **`A`** **record**

1. 对 **`rauchg.com`** 执行 DNS 查询，以解析其 **`A`** 记录

- This domain uses Vercel DNS, which leverages anycasted, intelligent DNS and real-time steering to route to healthy endpoints, isolating regional failures for global reliability.

- 该域名使用 Vercel DNS，依托任播（anycast）、智能 DNS 及实时流量调度技术，将请求路由至健康的服务端点，从而在全局范围内隔离区域性故障，保障高可靠性。

- ✓ This worked as expected.

- ✓ 此环节运行正常。

2\. **The DNS query returns a Vercel CDN IP**

2. DNS 查询返回一个 Vercel CDN 的 IP 地址

- Vercel CDN provides global acceleration via Anycast. A single IP can globally steer traffic to the nearest healthy CDN edge region, minimizing latency, isolating faults, and sustaining reliability across continents.

- Vercel CDN 通过 Anycast 提供全球加速。单个 IP 地址即可将流量全局调度至最近的健康 CDN 边缘节点区域，从而最大限度降低延迟、隔离故障，并保障跨洲际的高可靠性。

- While providing Anycast IPs, we still make the recommendation that customers use `CNAME` records, especially when not using Vercel DNS. A `CNAME` provides Vercel’s infrastructure teams with another traffic-steering point for dynamic updates.

- 尽管我们提供 Anycast IP 地址，仍建议客户使用 `CNAME` 记录（尤其在未使用 Vercel DNS 的情况下）。“CNAME” 为 Vercel 基础设施团队提供了另一个用于动态更新的流量调度入口点。

- ✓ This worked as expected.

- ✓ 功能运行符合预期。

3\. **Our L3-L5 protections secure your traffic**

3\. **我们的第 3–5 层防护保障您的流量安全**

- The Vercel Edge Network provides always-on, managed DDoS protection with automatic detection, adaptive mitigations, and global edge defense. This includes mitigating SYN, UDP, ICMP, TCP floods, malformed and oversized packets, etc.

- Vercel 边缘网络提供持续在线、统一管理的 DDoS 防护能力，具备自动检测、自适应缓解措施及全球边缘防御机制。其防护范围涵盖 SYN 泛洪、UDP 泛洪、ICMP 泛洪、TCP 泛洪、畸形报文、超大尺寸数据包等攻击类型。

- ✓ This worked as expected.

- ✓ 功能运行符合预期。

4\. **A TLS handshake is made to** **`https://rauchg.com`**

4\. **与** **`https://rauchg.com`** **建立 TLS 握手**

- Vercel’s Edge Network contains a global component internally called “HTTPS Terminator”. On a given week, Vercel serves tens of millions of unique domains, which require a sophisticated global replication, storage, and caching system for certificates.

- Vercel 边缘网络内部包含一个名为“HTTPS Terminator”（HTTPS 终结器）的全球性组件。在任意一周内，Vercel 需为数千万个独立域名提供服务，这要求证书必须依托一套高度成熟的全球复制、存储与缓存系统。

- This system is designed to actively replicate. When a certificate is created, it’s pushed to all our CDN edge regions. When a certificate is read by HTTPS Terminator nodes, it’s cached for performance and fault tolerance reasons.

- 该系统采用主动复制机制：证书一经创建，即同步推送至全部 CDN 边缘节点区域；当 HTTPS Terminator 节点读取证书时，会将其缓存，以提升性能并增强容错能力。

- ✓ This worked as expected.

- ✓ 功能运行符合预期。

5. **Our L7 Firewall secures your traffic**

5. **我们的第 7 层防火墙保障您的流量安全**

- Vercel Firewall is a globally distributed service that can protect each region without global dependencies or single points of failure, powered by a component [internally called Protectd](https://vercel.com/blog/protectd-evolving-vercels-always-on-denial-of-service-mitigations). By minimizing its need for global coordination, it has industry-leading L7 mitigation speeds (crucial given the on-demand nature of cloud resource and AI token consumption).

- Vercel 防火墙是一项全球分布式服务，可在无需全局依赖或单点故障的前提下，为每个区域提供防护能力，其核心由一个内部代号为 **Protectd** 的组件驱动（详见：[《Protectd：演进中的 Vercel 全时在线 DDoS 缓解机制》](https://vercel.com/blog/protectd-evolving-vercels-always-on-denial-of-service-mitigations)）。通过大幅减少对全局协调的依赖，该防火墙实现了业界领先的第 7 层攻击缓解速度（这一点尤为关键——因为云资源与 AI Token 消耗均具有按需触发的特性）。

- ✓ This worked as expected.

- ✓ 功能运行符合预期。

6. **An HTTP request is made to** **`https://rauchg.com`**

6. **向 `https://rauchg.com` 发起一条 HTTP 请求**

- Vercel CDN has [globally replicated metadata infrastructure](https://x.com/rauchg/status/1979612793478533508) with no single-point-of-failure. This allows us to decode `rauchg.com` into the specific deployment destination. Unlike other services, Vercel typically acts _as both CDN and Origin_, even though each can be used independently.

- Vercel CDN 拥有[全球复制的元数据基础设施](https://x.com/rauchg/status/1979612793478533508)，不存在任何单点故障。这使得我们能将域名 `rauchg.com` 解析为对应的具体部署目标。与其他服务不同，Vercel 通常**同时承担 CDN 与源站（Origin）双重角色**——尽管二者在技术上可完全独立使用。

- The deployment metadata system is one of the most critical parts of our infrastructure, to which we’ve devoted extensive engineering, load testing, failover design.

- 部署元数据系统是我们基础设施中最关键的组件之一，为此我们投入了大量工程资源，开展了严格的负载测试与容灾切换（failover）设计。

- ◑ Global deployment metadata worked as expected globally, but if customers hit the `iad1` region directly they saw disruption until we re-routed the `iad1` region.

- ◑ 全球部署元数据在全球范围内整体运行正常；但若用户直接访问 `iad1` 区域，则遭遇服务中断，直至我们完成对该区域的流量重路由。

7. **Once the Vercel CDN obtains deployment metadata, it performs routing.**

7. **Vercel CDN 在获取部署元数据后，执行路由操作**

- Each Vercel CDN region operates a component internally named Regional Cache. It’s responsible for caching static assets and cacheable dynamic requests. This system is replicated and has strict durability and latency guarantees. The origin of Routing Metadata is `us-east-1` S3, but the system is designed to persist data globally upon first use.

- 每个 Vercel CDN 区域均运行一个内部称为 **Regional Cache（区域缓存）** 的组件，负责缓存静态资源及可缓存的动态请求。该系统采用多副本架构，并具备严格的持久性与延迟保障。路由元数据（Routing Metadata）的原始来源为 `us-east-1` 区域的 S3 存储桶，但系统设计为在首次使用时即自动将数据持久化至全球各区域。

- ✗ While metadata is actively propagated into every region, we experienced a cascading failure of the regional cache service, leading to a wider scope of disruption.

- ✗ 尽管元数据正被主动同步至所有区域，我们仍遭遇了区域缓存服务的级联故障，进而引发更大范围的服务中断。

8. **路由可以决定请求的多种命运**

8. **路由可以决定请求的多种命运**

- 路由中间件执行（Routing Middleware execution）

  - 客户可使用 Fluid Compute，在请求处理路径中运行逻辑，实现动态路由与内容管理，并充分利用 Node.js 运行时的全部能力。该功能以 Vercel Functions 形式运行，并部署至全球各 CDN 区域。

  - ◑ 初期，直接访问 `us-east-1` 区域的用户遭遇短暂中断；但由于路由中间件已实现全球部署，整体影响范围有限。

- 函数调用（Function invocation）

  - ◑ 对未将 `us-east-1` 作为唯一区域使用的客户无任何影响。对于使用 `us-east-1`（即 `iad1`）作为其函数区域的客户，若已配置备用区域，我们已执行故障转移（failover）至该备用区域。

- 提供 HTTP `Cache-Control` 内容（Serving HTTP `Cache-Control` content）

  - 若某 URL 曾被成功响应，且源站（origin）或函数返回了 `Cache-Control` 头，Vercel 将把该响应缓存在一个内部称为“响应缓存”（Response Cache）的组件中。

  - ✓ 此机制按预期正常工作。

- 提供静态内容与 ISR 内容（Serving static and ISR content）

  - 若路由将某 URL 映射至静态资源或 ISR（增量静态再生）内容，则优先从本地区域缓存提供服务；必要时回源获取。

  - ◑ 当 ISR 内容已在边缘节点缓存时，其服务表现符合预期。但若 ISR 内容的源站为 `us-east-1`，且该内容尚未在边缘节点完成缓存，则会出现短暂中断。

## Incident timeline

## 事件时间线

**Monday, October 20, 2025**

**2025年10月20日，星期一**

`06:55 UTC`: First automated alerts fire for errors across Vercel services, and incidents are automatically created. On-call engineers are paged.

`06:55 UTC`：Vercel 各项服务首次触发自动化错误告警，相关事件（incident）自动创建，待命工程师（on-call engineers）收到寻呼通知。

`06:56 UTC`: The primary on-call engineer responds and begins the investigation.

`06:56 UTC`：主待命工程师响应并启动调查。

`06:59 UTC`: The primary on-call engineer continues to be paged by additional alerts, and escalates to other on-call engineers for help triaging. An incident call is started to organize the triage.

`06:59 UTC`：主待命工程师因持续收到新增告警而反复被寻呼，遂向其他待命工程师请求协助排查；同时发起事件电话会议（incident call），以统筹协调排查工作。

`07:07 UTC`: On-call engineers determine that there is likely a major issue with AWS-managed services, and they escalate further to the “Panic Rotation”, which pages all of the most senior, experienced on-call responders at Vercel.

`07:07 UTC`：待命工程师判断问题很可能源于 AWS 托管服务的重大异常，遂进一步升级至“紧急轮值组”（Panic Rotation）——该机制会向 Vercel 全体资历最深、经验最丰富的待命响应人员发送寻呼通知。

`07:15 UTC`: Due to failures in our serving stack, we decide to re-route traffic away from `iad1` into neighboring data centers. We start incrementally re-routing traffic from `iad1` at `07:20 UTC` and the process is complete by 07:44 UTC.

`07:15 UTC`：由于服务栈（serving stack）出现故障，我们决定将流量从 `iad1` 数据中心重新路由至邻近数据中心。重路由于 `07:20 UTC` 起分阶段启动，并于 `07:44 UTC` 全面完成。

`07:35 UTC`: Due to failures provisioning new build machines in the data center, we decide to re-route builds to another region and complete the process by `07:40 UTC`. At this time, builds with dependencies on resources such as databases outside of Vercel tied to AWS `us-east-1` continue to fail.

`07:35 UTC`：由于数据中心内无法成功配置新的构建机器（build machines），我们决定将构建任务重路由至另一区域，并于 `07:40 UTC` 完成该操作。此时，依赖 AWS `us-east-1` 区域外部资源（例如非 Vercel 托管的数据库）的构建任务仍持续失败。

`08:16 UTC`: We observe increased failures loading the Vercel Dashboard, and elevated error rates in the Vercel Teams API. The root cause is determined as elevated request latency to external dependencies, which led to CPU starvation. We manually scale up the service at `08:51 UTC`.

`08:16 UTC`：我们观察到 Vercel 控制台（Dashboard）加载失败次数明显上升，Vercel Teams API 错误率亦显著升高。根本原因被定位为对外部依赖服务的请求延迟大幅增加，进而引发 CPU 资源耗尽（CPU starvation）。我们于 `08:51 UTC` 手动对该服务进行扩容。

`09:15 UTC`: The Vercel Teams API recovers, and we see no more errors loading the Vercel Dashboard.

`09:15 UTC`：Vercel Teams API 恢复正常，Vercel 控制台加载错误亦全部消失。

`09:45 UTC`: New Vercel Deployments using Routing Middleware or Vercel Functions with `iad1` as the selected region are failing due to AWS API issues in the `us-east-1` region. This includes all projects configured with Secure Compute with `iad1` as the specified region.

`09:45 UTC`：由于 `us-east-1` 区域 AWS API 出现问题，所有将 `iad1` 设为指定区域、并使用路由中间件（Routing Middleware）或 Vercel Functions 的新部署（New Vercel Deployments）均告失败。这包括所有已启用“安全计算”（Secure Compute）且明确指定区域为 `iad1` 的项目。

`10:22 UTC`: We observe health checks passing in the `iad1` builds cluster, and route Secure Compute builds to the cluster. This restores Secure Compute builds.

`10:22 UTC`：我们观察到 `iad1` 构建集群的健康检查已恢复正常，并将 Secure Compute 构建任务路由至该集群。此举恢复了 Secure Compute 的构建功能。

`11:52 UTC`: We restore service functionality for APIs that create Vercel Functions and Middleware in the `iad1` region.

`11:52 UTC`：我们恢复了在 `iad1` 区域中用于创建 Vercel Functions 和 Middleware 的 API 服务功能。

`17:19 UTC`: We observe a small increase in failures to invoke Vercel Functions in the `iad1` region, and are simultaneously paged for failures scheduling new instances of our Functions routing services.

`17:19 UTC`：我们观察到 `iad1` 区域中调用 Vercel Functions 的失败率出现小幅上升；与此同时，我们收到告警，提示 Functions 路由服务的新实例调度失败。

`17:24 UTC`: We determine the scheduling failures are caused by continued EC2 capacity issues in AWS `us-east-1`. We reduce provisioning for non-critical infrastructure in `iad1` to free capacity for our Functions routing services and observe recovery in invoking Vercel Functions.

`17:24 UTC`：我们确认调度失败源于 AWS `us-east-1` 区域持续存在的 EC2 容量问题。为此，我们降低了 `iad1` 区域中非关键基础设施的资源配额，以腾出容量供 Functions 路由服务使用，并观察到 Vercel Functions 的调用成功率随之恢复。

`17:29 UTC`: We update the configuration for our serving stack to prefer other regions when serving Vercel Functions (if available) instead of `iad1`.

`17:29 UTC`：我们更新了服务栈配置，使其在提供 Vercel Functions 服务时优先选择其他可用区域（而非 `iad1`）。

`17:35 UTC`: We observe decreased errors invoking Vercel Functions in `iad1`. Invocation errors continue at a much lower rate until recovery at `17:49 UTC`.

`17:35 UTC`：我们观察到 `iad1` 区域中 Vercel Functions 的调用错误显著减少。此后，调用错误持续以极低频率发生，直至 `17:49 UTC` 完全恢复。

`17:47 UTC`: Another degradation of AWS APIs leads to build failures caused by errors creating Vercel Functions and Middleware in `iad1`.

`17:47 UTC`：AWS API 再次出现性能下降，导致在 `iad1` 区域创建 Vercel Functions 和 Middleware 时出错，进而引发构建失败。

`18:50 UTC`: The service backing Vercel Runtime Logs begins experiencing timeouts.

`18:50 UTC`：支撑 Vercel Runtime Logs 的服务开始出现超时现象。

`19:20 UTC`: We begin to observe failures loading the Vercel Dashboard and elevated error responses from Vercel API services. Containers running Vercel Control Plane services, which power the Vercel Dashboard and APIs, begin restarting aggressively.

`19:20 UTC`：我们开始观察到 Vercel 控制台（Dashboard）加载失败，且 Vercel API 服务返回的错误响应明显增多。承载 Vercel 控制平面（Control Plane）服务的容器——即支撑 Vercel 控制台与 API 的核心服务——开始频繁、剧烈地重启。

`19:31 UTC`: Automated alerts for elevated errors in Vercel APIs page the primary on-call engineer. A separate incident is opened to triage this issue.

`19:31 UTC`：Vercel API 错误率异常升高触发自动化告警，主备岗工程师（primary on-call engineer）随即被寻呼。我们另启一个独立事件（incident）对该问题展开排查与定级。

`19:41 UTC`: We determine timeouts to Vercel’s feature flag provider are the underlying issue in Vercel API services returning 500 responses and the containers restarting.

`19:41 UTC`：我们确认，Vercel 的功能标志（feature flag）提供商响应超时是导致 Vercel API 服务返回 500 错误及容器频繁重启的根本原因。

`19:48 UTC`: We release a change to reduce timeouts and mitigate impact of failed requests to the flag provider. This reduces container restarts, but Vercel API services remain degraded.

`19:48 UTC`：我们发布一项变更，缩短超时时间，并减轻对标志提供商请求失败所造成的影响。该变更降低了容器重启频率，但 Vercel API 服务仍处于降级状态。

`21:20 UTC`: We release an experimental change to degraded services in incremental batches. After observing recovery in the first release, we roll the change to all control plane degraded services by `22:31 UTC`.

`21:20 UTC`：我们以渐进式分批方式，向已降级的服务发布一项实验性变更。在首批发布观察到服务恢复后，我们于 `22:31 UTC` 前将该变更推广至全部控制平面（control plane）中处于降级状态的服务。

**Tuesday, October 21, 2025**

**2025 年 10 月 21 日（星期二）**

`00:20 UTC`: Vercel Dashboard and API degradation resumes as the flags provider issue recurs. The experimental change from hours earlier had not landed in 100% of services.

`00:20 UTC`：由于标志提供商问题再次出现，Vercel 控制台（Dashboard）与 API 服务的降级状况重现。数小时前发布的实验性变更尚未在 100% 的服务中生效。

`00:48 UTC`: We observe missing Vercel Runtime Logs in several regions. The underlying infrastructure indicates a subset of regions have backlogs of 5–6 hours. We merge a change to increase throughput on these regions.

`00:48 UTC`：我们在多个区域观测到 Vercel 运行时日志（Runtime Logs）缺失。底层基础设施显示，其中部分区域存在长达 5–6 小时的日志处理积压。我们合并了一项变更，以提升这些区域的日志处理吞吐量。

`02:37 UTC`: All flags clients across Vercel Control Plane services are reconfigured to use the experimental fix.

`02:37 UTC`：Vercel 控制平面所有服务中的标志客户端均已重新配置，启用该实验性修复方案。

`03:01 UTC`: Another fix for the logs pipeline is released, and this one successfully unblocks log processing. The backlog age begins to decrease across affected regions.

`03:01 UTC`：日志流水线（logs pipeline）的另一项修复措施已发布，此次修复成功解除了日志处理阻塞。受影响区域的日志积压时长开始逐步下降。

`03:30 UTC`: The Vercel Dashboard and API services fully recover.

`03:30 UTC`：Vercel 控制台与 API 服务全面恢复正常。

`06:21 UTC`: Runtime Logs fully recover.

`06:21 UTC`：运行时日志（Runtime Logs）全面恢复正常。

## Future improvements

## 未来改进计划

We’re currently working on a highly detailed technical postmortem that will result in systematic mitigation of failure modes discovered by these service disruptions.

我们目前正在撰写一份极为详尽的技术复盘报告，旨在系统性地缓解此次服务中断所暴露出的各类故障模式。

Additionally, we will continue and intensify our efforts to [rehearse major regional disruptions.](https://vercel.com/blog/preparing-for-the-worst-our-core-database-failover-test)

此外，我们将持续并进一步加强针对重大区域性中断事件的演练工作。[（参见相关博客）](https://vercel.com/blog/preparing-for-the-worst-our-core-database-failover-test)