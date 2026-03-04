---
title: "Preparing for the worst: Our core database failover test - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/preparing-for-the-worst-our-core-database-failover-test"
date: "2025-08-28"
scraped_at: "2026-03-02T09:29:06.875222503+00:00"
language: "en-zh"
translated: true
description: "On July 24, 2025, we successfully performed a full production failover of our core control-plane database from Azure West US to East US 2 with zero customer impact."
---

render_with_liquid: false
Aug 28, 2025

2025年8月28日

Many engineering teams have disaster recovery plans. But unless those plans are regularly exercised on production workloads, they don’t mean much. Real resilience comes from verifying that systems remain stable under pressure. Not just in theory, but in practice.

许多工程团队都制定了灾难恢复计划。但除非这些计划在生产工作负载上定期演练，否则它们几乎毫无意义。真正的韧性，源于对系统在压力下能否保持稳定的实际验证——而非仅停留在理论层面。

On July 24, 2025, we successfully performed a full production failover of our core control-plane database from Azure West US to East US 2 with zero customer impact.

2025年7月24日，我们成功将核心控制平面数据库从 Azure 西美区（West US）完整切换至东美区2（East US 2），整个过程对客户零影响。

This was a test across all control-plane traffic: every API request, every background job, every deployment and build operation. Preview and development traffic routing was affected, though our production CDN traffic, served by a separate globally-replicated DynamoDB architecture, remained completely isolated and unaffected across our 19 regions.

此次测试覆盖全部控制平面流量：包括每一个 API 请求、每一项后台任务、每一次部署与构建操作。预览环境（Preview）和开发环境的流量路由受到了影响；但由独立的、全球复制的 DynamoDB 架构支撑的生产 CDN 流量，在我们全部 19 个区域中始终保持完全隔离，未受任何影响。

This operation was a deliberate, high-stakes exercise. We wanted to ensure that if the primary region became unavailable, our systems could continue functioning with minimal disruption. The result: a successful failover with zero customer downtime, no degraded performance in production, and no postmortem needed.

本次操作是一次有意识、高风险的实战演练。我们的目标是确保：一旦主用区域不可用，系统仍能以最低限度的干扰持续运行。结果：故障切换圆满成功——客户零宕机、生产环境性能无下降、无需事后复盘（postmortem）。

## Our motivation

## 我们的动因

Datacenter outages aren't hypothetical. And in the face of that reality, our platform must be ready to pivot instantly to maintain uptime and continue serving production traffic.

数据中心宕机并非假设性事件。面对这一现实，我们的平台必须具备即时切换能力，以保障服务可用性，并持续承载生产流量。

Our architecture is designed for resilience. Each of our 19 cloud regions operates autonomously, with a full copy of the metadata required to serve applications independently. If a region becomes unavailable, our anycast routing layer removes it from rotation within seconds, automatically rerouting traffic with no disruption. Compute is equally resilient: we support backup regions for function execution during regional failures.

我们的架构天生面向韧性而设计。我们全部 19 个云区域均自主运行，各自完整保存服务应用所必需的元数据副本。一旦某个区域不可用，我们的任播（anycast）路由层可在数秒内将其从流量轮转中剔除，并自动重定向流量，全程无中断。计算资源同样具备高韧性：当区域发生故障时，我们支持在备用区域执行函数计算。

But architecture alone isn’t enough.

但仅靠架构本身并不足够。  

Last year, Azure’s West US region suffered two major power failures that prevented us from performing critical write operations. While a replica existed in East US 2, we had never fully rehearsed a failover. The incident revealed that although many of our internal services were ready, some were not. It exposed a gap in our operational resilience.

去年，Azure 西美区遭遇两次重大断电事故，导致我们无法执行关键写入操作。尽管东美区2（East US 2）已部署了数据副本，但我们此前从未完整演练过故障切换流程。该事件揭示：虽然众多内部服务已准备就绪，但仍有部分服务尚未达标——这暴露了我们在运维韧性方面的短板。

We committed to closing that gap. Over the following months, we worked to ensure we could fail over cleanly and reliably. And not just in principle, but in practice.

我们承诺弥合这一差距。在随后的数月里，我们持续努力，确保故障转移（failover）能够干净、可靠地执行——不仅在理论上可行，更在实践中经得起检验。

## ) Preparing to fail(over)

## ) 故障转移准备工作

Preparation revealed more problems than expected.

准备工作暴露出的问题比预期更多。

For example, some of our internal services use proprietary Cosmos DB clients which lacked failover awareness. These services needed the ability to detect when the database's primary write region changed and redirect their writes accordingly, without requiring a restart or redeploy. In other words, they had to programmatically update their write targets at runtime based on the latest metadata from Cosmos DB.

例如，我们部分内部服务使用了专有的 Cosmos DB 客户端，而这些客户端并不具备故障转移感知能力。这些服务必须能自动检测数据库主写入区域（primary write region）的变化，并据此动态重定向写入请求，且无需重启或重新部署。换言之，它们需在运行时依据 Cosmos DB 提供的最新元数据，自主更新写入目标。

We noticed some limitations during tests in staging, like hardcoding a five-minute wait before recognizing a new write region. We patched that delay down to five milliseconds and upstreamed the change to our monorepo.

我们在预发布环境（staging）测试中发现了一些限制，例如：硬编码了长达五分钟的等待时间，才开始识别新的写入区域。我们将该延迟修复为仅五毫秒，并将该变更提交至我们的单体仓库（monorepo）。

We also discovered that Cosmos DB’s failover protocol requires every database partition to recognize the new write region. During the transition, some services disagreed on where writes should go, causing elevated latencies. For larger collections, writes could stall for minutes. We worked around this.

我们还发现，Cosmos DB 的故障转移协议要求每个数据库分区都必须识别新的写入区域。在切换过程中，部分服务对写入目标区域存在分歧，导致延迟升高；对于较大的集合（collections），写入甚至可能停滞数分钟。我们通过工程手段规避了这一问题。

Across 57 staging failovers, we tested every codepath and SDK to build confidence before attempting a production failover. By the time July 24 arrived, we had a well-defined playbook.

在总计 57 次预发布环境故障转移演练中，我们遍历测试了所有代码路径和 SDK，以建立充分信心，为生产环境故障转移做好准备。截至 7 月 24 日，我们已形成一份定义清晰、可操作性强的故障转移执行手册（playbook）。

## The live exercise

## 实战演练

At 14:09 UTC, we initiated the failover from West US to East US 2. By 14:23, the switch was complete. An hour later, we reversed it.

世界协调时间（UTC）14:09，我们启动了从美国西部（West US）到美国东部 2 区（East US 2）的故障转移；至 14:23，切换完成；一小时后，我们又将其回切。

There was minor operational impact: about 500 builds were disrupted, mostly our own. One customer (ourselves) saw elevated latencies due to a particularly large database partition. Serving of preview and development traffic remained unaffected. Importantly, no customer-facing production traffic was impacted.

此次演练仅带来轻微的运维影响：约 500 次构建任务中断，其中绝大多数为我们自身触发；一位客户（即我们自己）因某个特别庞大的数据库分区而观察到延迟升高；预览（preview）与开发（development）流量的服务完全未受影响。尤为关键的是：**没有任何面向客户的生产环境（production）流量受到影响。**

The failover succeeded. All services remained operational, the correct alerts fired, and on-call teams handled all events with zero customer impact.

故障切换成功。所有服务持续正常运行，相应的告警准确触发，待命团队妥善处理了全部事件，客户未受到任何影响。

## Operational readiness

## 运营就绪性

Behind the scenes, our on-call engineers (who are on-call 24/7) were fully staffed and engaged during the failover. Every alert fired as expected, and responders followed established playbooks to validate each subsystem. Many of our alerts are paired with detailed runbooks in Notion, giving clear instructions on how to respond when specific conditions are met.

幕后，我们的待命工程师（7×24 小时轮值）在故障切换全程全员在岗、高度投入。所有告警均按预期触发，响应人员严格遵循既定的应急预案（playbook），逐一验证各子系统状态。我们许多告警在 Notion 中都配有详尽的运行手册（runbook），明确说明在特定条件满足时应如何响应。

Not all alerts are precise. Some are broad, catch-all indicators that correlate with known bad states, essentially trailing signals that something is likely wrong even if the exact cause isn't yet known. These are designed to prompt immediate investigation, even when the issue is still ambiguous. During the test, both targeted and catch-all alerts helped validate system health across services, ensuring no signal was missed and no issue went undetected.

并非所有告警都足够精准。部分告警属于宽泛的“兜底型”指标，与已知的异常状态存在强相关性——本质上是滞后性信号：即便尚无法确定具体原因，也能提示系统很可能已出现问题。这类告警的设计初衷，正是在问题尚不明确时即触发即时排查。本次测试中，定向告警与兜底型告警协同作用，全面验证了各服务的系统健康度，确保无一信号遗漏、无一问题漏检。

## Lessons and loose ends

## 经验总结与待办事项

This was a graceful failover. In a real incident, we would perform an Offline Region operation, which is more aggressive and can't be reversed for up to two business days. We've tested that scenario twice in staging and came out with a few observations that are being prioritized and helped inform our near-term roadmap.

本次故障切换过程平稳有序。而在真实故障场景下，我们将执行“区域离线”（Offline Region）操作——该操作更为激进，且最长需耗时两个工作日方可回滚。我们已在预发布环境（staging）中两次演练该场景，并获得若干关键观察结果；这些发现已被列为高优先级事项，并正推动我们近期产品路线图的制定。

We also observed inconsistencies during the failover: some clients saw the write region flip back and forth. About 2% of write traffic never fully transitioned to the new region, based on Azure metrics. These edge cases help inform our near-term roadmap.

此外，我们在故障切换过程中还观察到若干不一致现象：部分客户端感知到写入区域反复切换。根据 Azure 指标数据，约 2% 的写入流量始终未能完全切换至新区域。此类边缘案例亦为我们的近期路线图提供了重要输入。

## Built for resilience

## 为韧性而生

Exercises like this aren’t risk-free, but they’re far safer than performing your first failover in the middle of a live outage. Our platform is designed to keep serving end users even if an entire cloud region goes offline. This failover proved that our control plane can recover quickly and that our on-call teams are ready.

此类演练虽非零风险，但远比在真实线上故障中首次执行故障切换安全得多。我们的平台从设计之初便以韧性为核心目标：即使整个云区域宕机，仍可持续为终端用户提供服务。本次故障切换充分验证了控制平面的快速恢复能力，也印证了待命团队已全面就绪。

We will continue to rigorously test, refine, and ensure that Vercel remains resilient. Importantly, we prioritize this so our customers don't have to.

我们将持续开展严格测试、不断优化完善，确保 Vercel 始终保持高韧性。尤为关键的是：我们主动承担这份责任，正是为了让客户无需为此操心。

## Credit to Azure

## 致谢 Azure

We want to acknowledge our strong partnership with Azure, mentioned throughout this blog. They've been a reliable and collaborative partner, working closely with us through past incidents, during this exercise, and in the follow-up.

我们想借此机会感谢 Azure 与我们的紧密合作关系——这一点在本文中多次提及。Azure 一直是我们值得信赖、积极协作的合作伙伴，无论是在过往事件的应对过程中、本次演练期间，还是后续跟进阶段，都与我们密切配合。

Power disruptions are an industry-wide reality — not a reflection of any single provider. Exercises like this are part of responsible engineering, ensuring that both our systems and our vendor relationships are resilient and ready for real-world failure scenarios.

电力中断是整个行业的普遍现实，并非任何单一服务提供商能力不足的体现。此类演练正是负责任工程实践的重要组成部分，旨在确保我们自身的系统以及与供应商的合作关系均具备韧性，能够从容应对真实世界中的故障场景。

We're grateful for Azure’s continued support and shared focus on building reliable, scalable infrastructure.

我们衷心感谢 Azure 持续以来的支持，以及双方在构建高可靠性、可扩展基础设施方面所秉持的共同目标。