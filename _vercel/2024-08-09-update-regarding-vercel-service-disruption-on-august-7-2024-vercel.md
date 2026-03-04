---
title: "Update regarding Vercel service disruption on August 7, 2024 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/update-regarding-vercel-service-disruption-on-august-7-2024"
date: "2024-08-09"
scraped_at: "2026-03-02T09:42:48.700708427+00:00"
language: "en-zh"
translated: true
description: "Understanding the service disruption and Vercel's next steps"
---
&#123;% raw %}

Aug 9, 2024

2024 年 8 月 9 日

Understanding the service disruption and Vercel's next steps

理解本次服务中断事件及 Vercel 后续应对措施

On August 7, 2024, Vercel's Edge Middleware and Edge Functions experienced a significant outage affecting many customers. We sincerely apologize for the service disruption.

2024 年 8 月 7 日，Vercel 的边缘中间件（Edge Middleware）与边缘函数（Edge Functions）遭遇严重中断，影响了大量客户。我们为此次服务中断深表歉意。

Vercel’s platform is designed to [minimize the risk of global downtime](https://vercel.com/blog/effortless-high-availability-for-dynamic-frontends). As standard practice, we use staggered rollouts for both code and configuration changes. Every aspect of our infrastructure is designed to gracefully fail over to the next available region in the event of an incident, and ensures no single point of failure across infrastructure components. However, on Wednesday, an upstream provider for a subset of our compute infrastructure went into a globally erroneous configuration state.

Vercel 平台的设计目标是[最大限度降低全球性停机风险](https://vercel.com/blog/effortless-high-availability-for-dynamic-frontends)。作为标准实践，我们对代码和配置变更均采用分阶段灰度发布（staggered rollouts）。我们的基础设施各环节均经过精心设计，确保在发生故障时能平滑地自动切换至下一个可用区域，并避免任何基础设施组件存在单点故障。然而，本周三，我们部分计算基础设施所依赖的一家上游服务商，其全局配置意外进入错误状态。

This event tested our infrastructure's resilience and how we respond to a global provider failure. Let’s break down what happened, how we responded, and the steps we’re taking to eliminate this as a possible failure mode.

此次事件检验了我们基础设施的韧性，以及我们应对全球性上游服务商故障的能力。接下来，我们将详细说明：事件经过、我们的响应过程，以及为彻底消除此类故障模式而正在采取的改进措施。

### What happened

### 事件经过

The service disruption lasted 26 minutes, from 19:13 UTC to 19:23 UTC and 19:26 UTC to 19:42 UTC. During this time, customers using our Edge Middleware and Edge Functions experienced high error rates. This event affected 61% of all invocations, significantly impacting customers. Impact varied by customer depending on their project’s usage pattern and properties of the client’s user agent.

本次服务中断持续 26 分钟，分为两个时段：协调世界时（UTC）19:13 至 19:23，以及 19:26 至 19:42。在此期间，使用 Vercel 边缘中间件与边缘函数的客户遭遇了极高的错误率。该事件波及全部调用请求的 61%，对客户造成显著影响；具体影响程度因客户项目的使用模式及其终端用户代理（User Agent）的特性而异。

These edge compute services currently rely on a specialized compute provider, distinct from other services on the Vercel Platform. This is why requests to Serverless Functions, Static Files, and ISR were unaffected when not fronted by Edge Middleware.

目前，这些边缘计算服务依赖一家专用的计算服务提供商，该提供商与 Vercel 平台上的其他服务（如无服务器函数、静态文件、增量静态再生等）相互独立。因此，当请求未经边缘中间件前置处理时，对无服务器函数（Serverless Functions）、静态文件（Static Files）及增量静态再生（ISR）的调用均未受影响。

Initial findings show this provider erroneously failed to respect our global traffic configurations, causing them to unexpectedly block most Vercel requests.

初步调查结果显示，该服务商错误地未能遵循我方设定的全局流量配置，导致其意外拦截了绝大多数 Vercel 请求。

Vercel’s monitoring systems identified the elevated errors and alerted our team who immediately opened a maximum priority internal investigation. From there:  

Vercel 的监控系统迅速识别出异常升高的错误率，并向团队发出告警；团队随即启动最高优先级的内部调查。后续进展如下：

- Vercel Engineering completed its run books and concluded no services or configurations were changed in the Vercel environment.

- Vercel 工程团队已完成运行手册核查，并确认 Vercel 环境中未发生任何服务或配置变更。

- Vercel Engineering initiated communication with the upstream infrastructure provider to continue triaging the problem.

- Vercel 工程团队已主动联系上游基础设施供应商，持续推进问题排查与分析。

- At 19:41 UTC Vercel mitigated the issue by initiating a config override that reset the vendor’s system to a state in which it did not block our traffic. This ended the active disruption in our Edge Middleware and Edge Functions services.

- 世界协调时间（UTC）19:41，Vercel 通过启用配置覆盖（config override）缓解了该问题，将供应商系统重置为不再拦截我方流量的状态。此举终结了 Edge Middleware 和 Edge Functions 服务的活跃中断。

- At 19:42 UTC the config override restored the desired state and the upstream provider implemented fail-safes for Vercel traffic that are appropriate for our traffic volume.

- 世界协调时间（UTC）19:42，配置覆盖成功恢复至预期状态；同时，上游供应商已为 Vercel 流量部署了与其实际流量规模相匹配的容错保护机制（fail-safes）。

### Lessons learned and future mitigations

### 经验总结与后续缓解措施

Our infrastructure is designed to avoid single points of failure and ensure automatic failover at every point in our system.

我们的基础设施设计旨在避免单点故障，并确保系统各环节均具备自动故障转移能力。

To address this, we are accelerating our ongoing efforts to enhance the resilience of our Edge Middleware and Edge Functions. Here are the key steps we are taking:

为此，我们正加快既有工作进度，进一步提升 Edge Middleware 和 Edge Functions 的韧性。具体关键举措如下：

1. **Configuration management:** We are working closely with this compute provider to ensure their fail-safes are correctly configured. The default traffic limits that triggered the service disruption were already adjusted to accommodate our scale.

1. **配置管理**：我们正与该计算服务提供商紧密协作，确保其容错保护机制配置正确。此前触发服务中断的默认流量限制，目前已根据我方业务规模完成调整。

2. **Additional redundancy:** We are developing a backup option for our Edge Middleware and Edge Function products. This will ensure that even if the primary system fails, we can continue operations with minimal disruption. This initiative has already been in progress, and we will use the lessons from this event to shape that continued effort.

2. **增强冗余性**：我们正在为 Edge Middleware 和 Edge Functions 产品开发备用方案。该方案可确保主系统发生故障时，仍能以最小化中断维持业务连续性。此项工作早已启动，本次事件的经验教训将指导并优化后续推进过程。

3. **Unified and simplified infrastructure:** Our long-term goal is to unify the compute subsystem used to run functions across Edge Middleware, Edge Functions, and Serverless Functions. This unified and simplified infrastructure will be highly available and resilient, reducing dependency on any single provider.

3. **统一且简化的基础设施**：我们的长期目标是整合 Edge Middleware、Edge Functions 与 Serverless Functions 所共用的函数计算子系统。这一统一、简化的基础设施将具备高可用性与强韧性，从而降低对任一单一供应商的依赖。

### Moving forward

### 展望未来

While this event was a severe disruption, it has reinforced our commitment to reliability and resilience.

尽管此次事件造成了严重中断，但也进一步坚定了我们对可靠性和韧性的承诺。

We apologize for the impact this event had on our customers and assure you that we are taking comprehensive steps to prevent similar issues in the future.

我们为此次事件给客户带来的影响深表歉意，并向您保证，我们正在采取全面措施，以防止未来发生类似问题。
&#123;% endraw %}
