---
title: "Protectd: Evolving Vercel’s always-on denial-of-service mitigations - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/protectd-evolving-vercels-always-on-denial-of-service-mitigations"
date: "2025-04-07"
scraped_at: "2026-03-02T09:35:11.836234757+00:00"
language: "en"
translated: false
description: "Protectd is our new real-time security engine that blocks DDoS attacks faster than ever—built to detect, learn from, and stop threats before they reach your app. Now powering sub-second protection a..."
---




Apr 7, 2025

Securing web applications is core to the Vercel platform. It’s built into every request, every deployment, every layer of our infrastructure. Our always-on Denial-of-Service (DoS) mitigations have long run by default—silently blocking attacks before they ever reach your applications.

Last year, we made those always-on mitigations visible with the release of the [Vercel Firewall](https://vercel.com/security), which allows you to inspect traffic, apply custom rules, and understand how the platform defends your deployments.

Now, we’re introducing **Protectd**, our next-generation real-time security engine. Running across all deployments, Protectd reduces mitigation times for novel DoS attacks by [over tenfold](https://vercel.com/changelog/vercel-firewall-now-stops-ddos-attacks-up-to-40x-faster), delivering faster, more adaptive protection against emerging threats.

Let's take a closer look at how Protectd extends the Vercel Firewall by continuously mapping complex relationships between traffic attributes, analyzing, and learning from patterns to predict and block attacks.

## **DoS mitigation before Protectd**

A year ago, our DoS mitigation system operated across four distinct phases—each designed to inspect, shape, and secure traffic before it reaches your application.

Before a request can reach your deployment, it is first processed across multiple layers of the network stack and passed through tightly integrated security and routing components across the Vercel infrastructure.

![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_001.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_002.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_003.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_004.jpg)

### Phase 1: Point-of-presence mitigations

Every request first ingresses through points of presence (PoPs), which terminate TCP and forward traffic to the nearest Vercel region over high-speed, low-latency connections. PoPs block the most common network-layer (L3) and transport-layer (L4) attacks, like SYN floods and UDP reflection attacks.

### Phase 2: Transport layer redundancy

After passing through this first layer of filtering, traffic enters a second layer of L4 protection. By leveraging state data, we can identify and block L4 attacks that require a deeper level of inspection. This distributed approach to network-layer defense creates a more robust barrier against sophisticated attacks like connection floods and stateful TCP exhaustion.

### Phase 3: In-band application-layer mitigations

Traffic now reaches the TLS termination service (TLS terminator), which completes TLS handshakes and executes in-band application-layer (L7) mitigations by processing each request in real-time against common attack signatures. This phase of protection defends against path traversals and malformed requests.

### Phase 4: Out-of-band application-layer analysis

TLS terminator evaluates requests against signatures detected out-of-band by the dos-mitigation-controller. The dos-mitigation-controller analyzes network events (netlogs) in our global ClickHouse cluster, tracking attributes like [JA4 fingerprints](https://vercel.com/docs/vercel-firewall/firewall-concepts#ja4), User-Agent strings, IP addresses, and request patterns.

Netlogs are streamed through a [FluentBit](https://fluentbit.io/) sidecar (netlog forwarder) to a [Vector](https://vector.dev/) cluster (netlog aggregator) that enriches the data with geolocation, ASN, and hosting provider data before materializing in ClickHouse for analysis. If an attack pattern is identified, mitigation signatures are distributed via event bus to all TLS terminator instances for enforcement.

## Outgrowing global aggregation

This original system reliably filtered high volumes of traffic and successfully mitigated a wide range of DoS attacks, but faced limitations. For out-of-bound mitigations, time to mitigation (TTM) often exceeded 20 seconds in our old system. When roughly 85% of all L7 protections depend on this pipeline, each passing second carries consequences. Vercel's infrastructure easily absorbs L7 floods, but prolonged attacks risk overwhelming customer backends and generating unwanted usage.

The TTM bottleneck stemmed primarily from our data pipeline architecture. Ingesting and materializing events in ClickHouse took substantial time and computational resources. The polling-based design—our only option for retrieving updates from ClickHouse—introduced additional latency, as regions repeatedly queried for updated signatures.

The dos-mitigation-controller also resisted rapid iteration. Developing new mitigations often required writing new materializations and new queries, hampering our ability to quickly adapt defenses against emerging threats.

## Enter Protectd

To address these limitations, we developed Protectd: a stream processor optimized for vertical scaling, built on a custom event-processing library designed to detect and respond to security signals in real time. Protectd moves detection to the edge, replacing our previous polling-based design with real-time signal propagation.

This shift from global to edge aggregation is what enables Protectd to block emerging threats ten times faster.

### **Built for speed, designed for scale**

Running in all regions, Protectd ingests enriched network events as newline delimited JSON (ndjson) over persistent TCP connections from our existing FluentBit netlog forwarders. This direct, live data stream eliminates polling delays, enabling Protectd to react to evolving attack patterns in real time.

Protectd is built with Golang, which offers an efficient concurrency model, lightweight runtime, and has strong adoption across our edge and security systems. Its performance enables Protectd to process ~550K events per second globally, executing millions of defense decisions per second using only 14 CPU cores. To do this, Protectd uses a JIT and SIMD JSON serialization library, virtualizes time from the events it processes, and leverages fast, probabilistic data structures to improve throughput.

![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_005.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_006.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_007.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_008.jpg)

### **Smarter mitigation, faster enforcement**

ClickHouse still plays a critical role. It powers our long-term traffic intelligence and helps us surface complex behavioral signals. But detection needs to happen at the edge.

Protectd processes live signals as they arrive, rather than relying on periodic queries, to detect and mitigate threats in real time. It continuously maps complex relationships between traffic attributes, learning from patterns such as TLS fingerprints linked to specific User-Agent strings, ASN and IP reputation tracking, and behavioral anomalies in request flows.

When Protectd identifies a suspicious pattern, it pushes defensive signatures directly to the event bus within the same Vercel region. These signatures are quickly enforced by all TLS terminators. By keeping detection and enforcement at the edge, Protectd enables rapid TTM while building a dynamic understanding of underlying attack patterns.

[**Understand how Vercel secures your app**\\
\\
From network protections to Layer 7 granular controls, learn how Vercel's infrastructure provides multi-layered protection for your application.\\
\\
Learn more](https://vercel.com/blog/life-of-a-request-securing-your-apps-traffic-with-vercel)

## Trust but verify: shadow mode and backtesting

Protectd introduces rigorous testing validation mechanisms to ensure every new rule is effective, precise, and impact-tested.

Every new filter starts in shadow mode, where it passively flags but doesn’t block suspicious traffic. These shadow actions are logged and analyzed in our ClickHouse cluster, providing real-world insight into mitigation accuracy, impact, and false positives rates—before enforcement.

Protectd supports percentage-based rollouts, allowing rules to be deployed progressively while monitoring challenge solve rates. This controlled rollout ensures defenses evolve without unintended consequences, keeping protection sharp while minimizing false positives.

To help iterate on our defenses, Protectd records every processed event, enabling historical traffic replay. This allows us to snapshot past attacks and test new mitigations in a sandboxed environment.

## Results and impact

Since fully rolling out Protectd in January 2025, a process that began in November, every Vercel user now benefits from a significantly faster, more adaptive security infrastructure. The system consistently delivers a P99 time to mitigation of 3.5 seconds, a P50 of 2.5 seconds, and can respond to threats in as little as 0.5 seconds.

![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_009.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_010.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_011.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_012.jpg)

While you’ve been reading this, Protectd has already stopped over three million L7 events. Notably, **over 5% of these attacks have already bypassed non-Vercel upstream proxies**, exposing a critical weakness in traditional DoS defenses. Protectd’s ability to catch and neutralize novel attack patterns—even those missed by other CDNs—reinforces its role as an intelligent, next-gen security layer.

![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_013.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_014.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_015.jpg)![](images/protectd-evolving-vercel_s-always-on-denial-of-service-mitigations-vercel/img_016.jpg)

## Building for tomorrow

The DoS threat landscape is constantly evolving, and so are we. If you encounter a DoS attack that isn't fully mitigated, please [submit a ticket](https://vercel.com/docs/dashboard-features/support-center). Every attack we analyze makes our always-on mitigations stronger for everyone using Vercel.

Want to help shape the future of global-scale distributed security? We're hiring:

- [Security Researcher](https://vercel.com/careers/security-researcher-us-5401260004)

- [Software Engineer, CDN Security](https://vercel.com/careers/software-engineer-cdn-security-5473268004)


Let’s make the internet faster, safer, and more resilient—together.

[**Learn about security that scales with you**\\
\\
The Vercel Firewall delivers multi-layer protection against application-layer attacks, DDoS threats, and bots. Visit our security page to sign up for a demo or add firewall rules today\\
\\
Learn more](https://vercel.com/security)