---
render_with_liquid: false
title: "Protectd: Evolving Vercel’s always-on denial-of-service mitigations - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/protectd-evolving-vercels-always-on-denial-of-service-mitigations"
date: "2025-04-07"
scraped_at: "2026-03-02T09:35:11.836234757+00:00"
language: "en-zh"
translated: true
description: "Protectd is our new real-time security engine that blocks DDoS attacks faster than ever—built to detect, learn from, and stop threats before they reach your app. Now powering sub-second protection a..."
---
render_with_liquid: false
render_with_liquid: false

Apr 7, 2025

2025年4月7日

Securing web applications is core to the Vercel platform. It’s built into every request, every deployment, every layer of our infrastructure. Our always-on Denial-of-Service (DoS) mitigations have long run by default—silently blocking attacks before they ever reach your applications.

保障 Web 应用安全是 Vercel 平台的核心能力。它已深度集成至每一次请求、每一次部署、基础设施的每一层。我们始终在线的拒绝服务（DoS）防护机制长期默认启用——在攻击抵达您的应用之前即悄然将其拦截。

Last year, we made those always-on mitigations visible with the release of the [Vercel Firewall](https://vercel.com/security), which allows you to inspect traffic, apply custom rules, and understand how the platform defends your deployments.

去年，我们通过发布 [Vercel 防火墙（Vercel Firewall）](https://vercel.com/security)，首次将这些始终在线的防护能力可视化：您可实时检视流量、配置自定义规则，并深入理解平台如何守护您的部署。

Now, we’re introducing **Protectd**, our next-generation real-time security engine. Running across all deployments, Protectd reduces mitigation times for novel DoS attacks by [over tenfold](https://vercel.com/changelog/vercel-firewall-now-stops-ddos-attacks-up-to-40x-faster), delivering faster, more adaptive protection against emerging threats.

如今，我们正式推出 **Protectd**——新一代实时安全引擎。它全面覆盖所有部署，可将针对新型 DoS 攻击的响应与缓解时间缩短 **超十倍**（[详见更新日志](https://vercel.com/changelog/vercel-firewall-now-stops-ddos-attacks-up-to-40x-faster)），为应对新兴威胁提供更快速、更智能的主动防护。

Let's take a closer look at how Protectd extends the Vercel Firewall by continuously mapping complex relationships between traffic attributes, analyzing, and learning from patterns to predict and block attacks.

接下来，我们将深入剖析 Protectd 如何扩展 Vercel 防火墙的能力：它持续构建流量属性间的复杂关联图谱，分析并学习流量模式，从而实现对攻击行为的预测与实时拦截。

## **DoS mitigation before Protectd**

## **Protectd 上线前的 DoS 防护机制**

A year ago, our DoS mitigation system operated across four distinct phases—each designed to inspect, shape, and secure traffic before it reaches your application.

一年前，我们的 DoS 防护系统由四个明确阶段构成——每个阶段均旨在于请求抵达您的应用之前，完成对流量的检测、整形与加固。

Before a request can reach your deployment, it is first processed across multiple layers of the network stack and passed through tightly integrated security and routing components across the Vercel infrastructure.

在请求抵达您的部署之前，它首先需穿越网络协议栈的多个层级，并经由 Vercel 基础设施中高度集成的安全与路由组件进行处理。

![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_001.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_002.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_003.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_004.jpg)

![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_001.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_002.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_003.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_004.jpg)

### Phase 1: Point-of-presence mitigations

### 第一阶段：边缘节点（Point-of-Presence）防护

Every request first ingresses through points of presence (PoPs), which terminate TCP and forward traffic to the nearest Vercel region over high-speed, low-latency connections. PoPs block the most common network-layer (L3) and transport-layer (L4) attacks, like SYN floods and UDP reflection attacks.

每个请求首先经由边缘节点（Points of Presence，PoPs）接入，PoPs 终止 TCP 连接，并通过高速、低延迟链路将流量转发至最近的 Vercel 区域。PoPs 可拦截最常见的网络层（L3）和传输层（L4）攻击，例如 SYN 泛洪攻击和 UDP 反射攻击。

### Phase 2: Transport layer redundancy

### 第二阶段：传输层冗余保护

After passing through this first layer of filtering, traffic enters a second layer of L4 protection. By leveraging state data, we can identify and block L4 attacks that require a deeper level of inspection. This distributed approach to network-layer defense creates a more robust barrier against sophisticated attacks like connection floods and stateful TCP exhaustion.

在通过第一层过滤后，流量进入第二层 L4 防护。借助状态数据，我们可识别并拦截需更深层次检测的 L4 攻击。这种分布式的网络层防御方式，构建起一道更坚固的屏障，有效抵御连接泛洪（connection floods）和有状态 TCP 耗尽（stateful TCP exhaustion）等高级攻击。

### Phase 3: In-band application-layer mitigations

### 第三阶段：带内应用层防护

Traffic now reaches the TLS termination service (TLS terminator), which completes TLS handshakes and executes in-band application-layer (L7) mitigations by processing each request in real-time against common attack signatures. This phase of protection defends against path traversals and malformed requests.

此时流量抵达 TLS 终止服务（TLS terminator），该服务完成 TLS 握手，并对每个请求实时比对常见攻击特征，执行带内应用层（L7）防护措施。本阶段防护可有效抵御路径遍历（path traversals）和畸形请求（malformed requests）。

### Phase 4: Out-of-band application-layer analysis

### 第四阶段：带外应用层分析

TLS terminator evaluates requests against signatures detected out-of-band by the dos-mitigation-controller. The dos-mitigation-controller analyzes network events (netlogs) in our global ClickHouse cluster, tracking attributes like [JA4 fingerprints](https://vercel.com/docs/vercel-firewall/firewall-concepts#ja4), User-Agent strings, IP addresses, and request patterns.

TLS terminator 将请求与 dos-mitigation-controller 在带外检测到的防护签名进行比对。dos-mitigation-controller 在全球 ClickHouse 集群中分析网络事件（netlogs），追踪包括 [JA4 指纹](https://vercel.com/docs/vercel-firewall/firewall-concepts#ja4)、User-Agent 字符串、IP 地址及请求模式等属性。

Netlogs are streamed through a [FluentBit](https://fluentbit.io/) sidecar (netlog forwarder) to a [Vector](https://vector.dev/) cluster (netlog aggregator) that enriches the data with geolocation, ASN, and hosting provider data before materializing in ClickHouse for analysis. If an attack pattern is identified, mitigation signatures are distributed via event bus to all TLS terminator instances for enforcement.

网络日志（netlogs）通过 [FluentBit](https://fluentbit.io/) 边车组件（netlog forwarder）流式传输至 [Vector](https://vector.dev/) 集群（netlog aggregator），后者为数据注入地理位置、ASN（自治系统号）及托管服务商等信息，再写入 ClickHouse 供分析使用。一旦识别出攻击模式，相关防护签名即通过事件总线分发至所有 TLS terminator 实例，以执行拦截。

## Outgrowing global aggregation

## 全局聚合架构的局限性

This original system reliably filtered high volumes of traffic and successfully mitigated a wide range of DoS attacks, but faced limitations. For out-of-bound mitigations, time to mitigation (TTM) often exceeded 20 seconds in our old system. When roughly 85% of all L7 protections depend on this pipeline, each passing second carries consequences. Vercel's infrastructure easily absorbs L7 floods, but prolonged attacks risk overwhelming customer backends and generating unwanted usage.

该原始系统能稳定处理高吞吐流量，并成功缓解多种 DoS 攻击，但仍存在明显局限。在带外防护场景下，旧系统的“响应时间”（Time to Mitigation，TTM）常超过 20 秒。而当前约 85% 的 L7 层防护均依赖此流水线，每一秒延迟都会带来实际影响。Vercel 基础设施本身可轻松承载 L7 泛洪流量，但若攻击持续过久，则可能压垮客户后端服务，并产生非预期的资源消耗。

The TTM bottleneck stemmed primarily from our data pipeline architecture. Ingesting and materializing events in ClickHouse took substantial time and computational resources. The polling-based design—our only option for retrieving updates from ClickHouse—introduced additional latency, as regions repeatedly queried for updated signatures.

TTM 瓶颈主要源于我们的数据管道架构。在 ClickHouse 中摄取并物化事件耗费了大量时间与计算资源。而基于轮询的设计——我们从 ClickHouse 获取更新的唯一方式——进一步引入了额外延迟，因为各区域需反复查询以获取更新的签名。

The dos-mitigation-controller also resisted rapid iteration. Developing new mitigations often required writing new materializations and new queries, hampering our ability to quickly adapt defenses against emerging threats.

dos-mitigation-controller 同样难以快速迭代。开发新的缓解措施通常需要编写新的物化逻辑和新的查询语句，严重制约了我们针对新兴威胁快速调整防御策略的能力。

## Enter Protectd

## 进入 Protectd

To address these limitations, we developed Protectd: a stream processor optimized for vertical scaling, built on a custom event-processing library designed to detect and respond to security signals in real time. Protectd moves detection to the edge, replacing our previous polling-based design with real-time signal propagation.

为应对上述局限，我们开发了 Protectd：一款专为垂直扩展优化的流处理器，构建于自研事件处理库之上，可实时检测并响应安全信号。Protectd 将检测能力下沉至边缘，以实时信号传播取代了此前基于轮询的设计。

This shift from global to edge aggregation is what enables Protectd to block emerging threats ten times faster.

正是这种从全局聚合到边缘聚合的转变，使 Protectd 能够将新兴威胁的拦截速度提升十倍。

### **Built for speed, designed for scale**

### **为速度而生，为规模而建**

Running in all regions, Protectd ingests enriched network events as newline delimited JSON (ndjson) over persistent TCP connections from our existing FluentBit netlog forwarders. This direct, live data stream eliminates polling delays, enabling Protectd to react to evolving attack patterns in real time.

Protectd 部署于所有区域，通过持久化的 TCP 连接，直接从我们现有的 FluentBit netlog 转发器接收经增强的网络事件（格式为换行符分隔的 JSON，即 ndjson）。这一直接、实时的数据流消除了轮询延迟，使 Protectd 能够实时响应不断演化的攻击模式。

Protectd is built with Golang, which offers an efficient concurrency model, lightweight runtime, and has strong adoption across our edge and security systems. Its performance enables Protectd to process ~550K events per second globally, executing millions of defense decisions per second using only 14 CPU cores. To do this, Protectd uses a JIT and SIMD JSON serialization library, virtualizes time from the events it processes, and leverages fast, probabilistic data structures to improve throughput.

Protectd 基于 Go 语言开发，具备高效的并发模型、轻量级运行时，并已在我们的边缘与安全系统中得到广泛应用。其卓越性能使 Protectd 全局每秒可处理约 55 万条事件，仅凭 14 个 CPU 核心即可每秒执行数百万次防御决策。为实现这一目标，Protectd 采用支持即时编译（JIT）与单指令多数据流（SIMD）的 JSON 序列化库，对所处理事件的时间进行虚拟化，并利用高性能的概率型数据结构以提升吞吐量。

![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_005.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_006.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_007.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_008.jpg)

### **Smarter mitigation, faster enforcement**

### **更智能的缓解，更快速的执行**

ClickHouse still plays a critical role. It powers our long-term traffic intelligence and helps us surface complex behavioral signals. But detection needs to happen at the edge.

ClickHouse 仍扮演着关键角色。它驱动我们的长期流量智能分析，并帮助我们挖掘复杂的用户行为信号。但威胁检测必须在边缘（edge）完成。

Protectd processes live signals as they arrive, rather than relying on periodic queries, to detect and mitigate threats in real time. It continuously maps complex relationships between traffic attributes, learning from patterns such as TLS fingerprints linked to specific User-Agent strings, ASN and IP reputation tracking, and behavioral anomalies in request flows.

Protectd 在流量信号到达的瞬间即进行实时处理，而非依赖周期性查询，从而实现威胁的实时检测与缓解。它持续构建并更新流量属性之间的复杂关联关系，从多种模式中自主学习——例如与特定 User-Agent 字符串关联的 TLS 指纹、ASN 与 IP 信誉追踪，以及请求流中的行为异常等。

When Protectd identifies a suspicious pattern, it pushes defensive signatures directly to the event bus within the same Vercel region. These signatures are quickly enforced by all TLS terminators. By keeping detection and enforcement at the edge, Protectd enables rapid TTM while building a dynamic understanding of underlying attack patterns.

当 Protectd 识别出可疑模式时，它会将防御签名直接推送至同一 Vercel 区域内的事件总线（event bus）。所有 TLS 终结器（TLS terminators）随即快速启用这些签名。通过将检测与执行均保留在边缘，Protectd 不仅显著缩短了从检测到响应的时间（TTM），还持续构建对底层攻击模式的动态认知。

[**Understand how Vercel secures your app**\\
\\
From network protections to Layer 7 granular controls, learn how Vercel's infrastructure provides multi-layered protection for your application.\\
\\
Learn more](https://vercel.com/blog/life-of-a-request-securing-your-apps-traffic-with-vercel)

[**了解 Vercel 如何保障您的应用安全**\\
\\
从网络层防护到第 7 层（应用层）精细化控制，深入理解 Vercel 基础设施如何为您的应用提供多层级安全防护。\\
\\
了解更多](https://vercel.com/blog/life-of-a-request-securing-your-apps-traffic-with-vercel)

## Trust but verify: shadow mode and backtesting

## 信任但需验证：影子模式与回溯测试

Protectd introduces rigorous testing validation mechanisms to ensure every new rule is effective, precise, and impact-tested.

Protectd 引入了严格的测试验证机制，确保每一条新规则均具备有效性、精准性，并经过实际影响评估。

Every new filter starts in shadow mode, where it passively flags but doesn’t block suspicious traffic. These shadow actions are logged and analyzed in our ClickHouse cluster, providing real-world insight into mitigation accuracy, impact, and false positives rates—before enforcement.

每一条新过滤器均以“影子模式”（shadow mode）启动：它被动标记可疑流量，但不实施拦截。这些影子操作被完整记录并汇入我们的 ClickHouse 集群进行分析，从而在正式启用前，真实反映该规则在缓解准确性、业务影响及误报率等方面的实测表现。

Protectd supports percentage-based rollouts, allowing rules to be deployed progressively while monitoring challenge solve rates. This controlled rollout ensures defenses evolve without unintended consequences, keeping protection sharp while minimizing false positives.

Protectd 支持基于百分比的渐进式发布（percentage-based rollouts），允许规则按比例逐步上线，同时实时监控挑战求解率（challenge solve rates）。这种受控发布方式确保防御能力持续演进，避免意外副作用，在保持防护敏锐度的同时最大限度降低误报。

To help iterate on our defenses, Protectd records every processed event, enabling historical traffic replay. This allows us to snapshot past attacks and test new mitigations in a sandboxed environment.

为助力防御策略的持续迭代，Protectd 记录每一个已处理事件，支持历史流量回放（historical traffic replay）。这使我们能够“快照”过往攻击行为，并在沙箱环境中安全地验证新型缓解措施的有效性。

## Results and impact

## 实际成效与影响

Since fully rolling out Protectd in January 2025, a process that began in November, every Vercel user now benefits from a significantly faster, more adaptive security infrastructure. The system consistently delivers a P99 time to mitigation of 3.5 seconds, a P50 of 2.5 seconds, and can respond to threats in as little as 0.5 seconds.

自2025年1月全面上线Protectd（该过程始于2024年11月）以来，每一位Vercel用户均已受益于一套显著更快、更具适应性的安全基础设施。该系统持续实现**P99缓解延迟为3.5秒**、**P50缓解延迟为2.5秒**，最快可在**仅0.5秒内响应威胁**。

![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_009.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_010.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_011.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_012.jpg)

While you’ve been reading this, Protectd has already stopped over three million L7 events. Notably, **over 5% of these attacks have already bypassed non-Vercel upstream proxies**, exposing a critical weakness in traditional DoS defenses. Protectd’s ability to catch and neutralize novel attack patterns—even those missed by other CDNs—reinforces its role as an intelligent, next-gen security layer.

就在您阅读这段文字的同时，Protectd已成功拦截超过**三百万次第7层（L7）攻击事件**。值得注意的是，**其中超过5%的攻击已成功绕过非Vercel上游代理**，暴露出传统DoS防御体系中一项关键薄弱环节。Protectd不仅能识别并阻断新型攻击模式——甚至包括其他CDN未能察觉的攻击——更进一步印证了其作为智能、下一代安全防护层的核心价值。

![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_013.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_014.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_015.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_016.jpg)

## Building for tomorrow

## 面向未来而构建

The DoS threat landscape is constantly evolving, and so are we. If you encounter a DoS attack that isn't fully mitigated, please [submit a ticket](https://vercel.com/docs/dashboard-features/support-center). Every attack we analyze makes our always-on mitigations stronger for everyone using Vercel.

DoS威胁态势正持续演进，我们亦同步进化。若您遭遇尚未被完全缓解的DoS攻击，请[提交工单](https://vercel.com/docs/dashboard-features/support-center)。我们分析的每一次攻击，都将使Vercel平台的“始终在线”缓解能力变得更强大，惠及所有用户。

Want to help shape the future of global-scale distributed security? We're hiring:

您希望参与塑造全球规模分布式安全的未来吗？我们正在招聘：

- [Security Researcher](https://vercel.com/careers/security-researcher-us-5401260004)

- [安全研究员](https://vercel.com/careers/security-researcher-us-5401260004)

- [Software Engineer, CDN Security](https://vercel.com/careers/software-engineer-cdn-security-5473268004)

- [CDN安全软件工程师](https://vercel.com/careers/software-engineer-cdn-security-5473268004)

Let’s make the internet faster, safer, and more resilient—together.

让我们携手，共建一个更快、更安全、更具韧性的互联网。

[**Learn about security that scales with you**  
**了解随您业务规模同步扩展的安全防护**  

The Vercel Firewall delivers multi-layer protection against application-layer attacks, DDoS threats, and bots. Visit our security page to sign up for a demo or add firewall rules today  
Vercel 防火墙提供多层防护，抵御应用层攻击、DDoS 威胁及恶意机器人。请访问我们的安全页面，立即预约演示或添加防火墙规则。  

[Learn more](https://vercel.com/security)  
[了解更多](https://vercel.com/security)