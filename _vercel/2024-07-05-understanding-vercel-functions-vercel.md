---
title: "Understanding Vercel Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/understanding-vercel-functions"
date: "2024-07-05"
scraped_at: "2026-03-02T09:43:11.658293583+00:00"
language: "en-zh"
translated: true
description: "Learn about how Vercel Functions help you run secure, highly available, and fast compute."
---

Jul 5, 2024

2024 年 7 月 5 日

Vercel Functions run code in response to user traffic without the need to manage your own infrastructure, provision servers, or manage hardware.

Vercel Functions 可根据用户流量自动执行代码，您无需自行管理基础设施、配置服务器或维护硬件。

This can provide some advantages over traditional infrastructure, including:

相较于传统基础设施，这种方式具备以下优势：

- [Secure and always up-to-date environments](https://vercel.com/blog/understanding-vercel-functions#secure-and-always-up-to-date-environments)

- [安全且始终更新的运行环境](https://vercel.com/blog/understanding-vercel-functions#secure-and-always-up-to-date-environments)

- [Predictable performance](https://vercel.com/blog/understanding-vercel-functions#predictable-performance)

- [可预测的性能表现](https://vercel.com/blog/understanding-vercel-functions#predictable-performance)

- [High availability](https://vercel.com/blog/understanding-vercel-functions#high-availability)

- [高可用性](https://vercel.com/blog/understanding-vercel-functions#high-availability)

- [Automatic downscaling and deprovisioning](https://vercel.com/blog/understanding-vercel-functions#automatic-downscaling-and-deprovisioning)

- [自动缩容与资源释放](https://vercel.com/blog/understanding-vercel-functions#automatic-downscaling-and-deprovisioning)

- [Real-time usage and spend controls](https://vercel.com/blog/understanding-vercel-functions#real-time-usage-and-spend-controls)

- [实时用量与费用管控](https://vercel.com/blog/understanding-vercel-functions#real-time-usage-and-spend-controls)

- [Out-of-the-box observability](https://vercel.com/blog/understanding-vercel-functions#out-of-the-box-observability)

- [开箱即用的可观测性](https://vercel.com/blog/understanding-vercel-functions#out-of-the-box-observability)


## Secure and always up-to-date environments

## 安全且始终更新的运行环境

With traditional infrastructure, you need to ensure your servers are properly configured, patched, and monitored for vulnerabilities. This can be additional maintenance work (especially for small teams or individual developers) or downtime (to install updates and restart the server).

在传统基础设施中，您需要确保服务器经过正确配置、及时打补丁，并持续监控其是否存在安全漏洞。这可能带来额外的运维负担（尤其对小型团队或独立开发者而言），或导致服务中断（例如安装更新和重启服务器时）。

For example, this is similar to running and managing a WordPress instance versus using a fully managed service.

例如，这类似于自行部署并维护一个 WordPress 实例，与使用全托管服务之间的区别。

With Vercel Functions, every workload is isolated to minimize the attack surface area of a malicious actor. The underlying infrastructure like the OS, kernel, and [hypervisor](https://aws.amazon.com/what-is/hypervisor) layers are patched automatically. Node.js runtime updates are [released automatically](https://vercel.com/docs/functions/runtimes/node-js#default-and-available-versions), including critical security vulnerability patches.

借助 Vercel Functions，每个工作负载均相互隔离，从而最大限度地缩小恶意攻击者可利用的攻击面。底层基础设施（包括操作系统、内核及[虚拟机监视器（hypervisor）](https://aws.amazon.com/what-is/hypervisor)层）均由系统自动打补丁。Node.js 运行时更新也[自动发布](https://vercel.com/docs/functions/runtimes/node-js#default-and-available-versions)，其中包含针对关键安全漏洞的修复补丁。

### Vulnerability surface

### 攻击面（漏洞暴露面）

Vercel ensures your compute is always running on a [secure, up-to-date environment](https://vercel.com/security), [protected against vulnerabilities](https://vercel.com/changelog/vercel-firewall-proactively-protects-against-vulnerability-in-the-clerk-sdk).

Vercel 确保您的计算资源始终运行在[安全且保持最新状态的环境](https://vercel.com/security)中，并[受到主动防护以抵御已知漏洞](https://vercel.com/changelog/vercel-firewall-proactively-protects-against-vulnerability-in-the-clerk-sdk)。

| Layer | Vercel | Virtual Private Server (VPS) |
| --- | --- | --- |
| OS | Vercel Managed | Customer Managed |
| Runtime | Vercel Managed | Customer Managed |
| Hypervisor | Vercel Managed | VPS Managed |
| User Code | Customer Managed | Customer Managed |

| 层级 | Vercel | 虚拟专用服务器（VPS） |
| --- | --- | --- |
| 操作系统（OS） | 由 Vercel 托管 | 由客户自行管理 |
| 运行时（Runtime） | 由 Vercel 托管 | 由客户自行管理 |
| 虚拟机监视器（Hypervisor） | 由 Vercel 托管 | 由 VPS 提供商管理 |
| 用户代码（User Code） | 由客户自行管理 | 由客户自行管理 |

Learn more about our [shared responsibility model](https://vercel.com/docs/security/shared-responsibility). Enterprise customers can also purchase dedicated, isolated build and compute through [Vercel Secure Compute](https://vercel.com/docs/security/secure-compute).

进一步了解我们的[责任共担模型（Shared Responsibility Model）](https://vercel.com/docs/security/shared-responsibility)。企业客户还可通过[Vercel Secure Compute](https://vercel.com/docs/security/secure-compute)购买专用、隔离的构建与计算资源。

## Predictable performance

## 可预测的性能表现

With traditional infrastructure, you are responsible for managing and scaling resources to meet demand. [Vercel Functions](https://vercel.com/docs/functions) scale automatically based on incoming requests and don't compete for resources. This eliminates the risk of queuing on the event loop, which can affect the latency of your application.

在传统基础设施中，您需自行管理并扩展资源以满足业务需求。[Vercel Functions](https://vercel.com/docs/functions) 则可根据入站请求量自动扩缩容，且各函数实例之间互不争抢资源。此举消除了事件循环（event loop）中请求排队的风险，从而避免影响应用响应延迟。

Vercel's infrastructure scales automatically based on demand.

Vercel 的基础设施会根据实际负载需求自动伸缩。

While this scalability is beneficial, it must also be paired with [spend controls](https://vercel.com/blog/understanding-vercel-functions#real-time-usage-and-spend-controls) and [observability](https://vercel.com/blog/understanding-vercel-functions#out-of-the-box-observability) into usage.

尽管这种可扩展性具有优势，但也必须与[支出控制](https://vercel.com/blog/understanding-vercel-functions#real-time-usage-and-spend-controls)和[可观测性](https://vercel.com/blog/understanding-vercel-functions#out-of-the-box-observability)相结合，以实现对资源使用的精细化管理。

For optimal performance, Vercel Functions are [powered by Rust](https://vercel.com/blog/vercel-functions-are-now-faster-and-powered-by-rust) and have advanced [bytecode caching](https://vercel.com/blog/introducing-bytecode-caching-for-vercel-functions). This makes startup times faster and more consistently low-latency.

为实现最佳性能，Vercel Functions 由[Rust 驱动](https://vercel.com/blog/vercel-functions-are-now-faster-and-powered-by-rust)，并具备先进的[字节码缓存](https://vercel.com/blog/introducing-bytecode-caching-for-vercel-functions)能力。这显著缩短了冷启动时间，并使延迟更稳定、更低。

![Up to 80ms faster (average) and 500ms faster (p99) for larger workloads by moving logic from Node.js to the new Rust-powered core.](images/understanding-vercel-functions-vercel/img_001.jpg)![Up to 80ms faster (average) and 500ms faster (p99) for larger workloads by moving logic from Node.js to the new Rust-powered core.](images/understanding-vercel-functions-vercel/img_002.jpg)![Up to 80ms faster (average) and 500ms faster (p99) for larger workloads by moving logic from Node.js to the new Rust-powered core.](images/understanding-vercel-functions-vercel/img_003.jpg)![Up to 80ms faster (average) and 500ms faster (p99) for larger workloads by moving logic from Node.js to the new Rust-powered core.](images/understanding-vercel-functions-vercel/img_004.jpg)Up to 80ms faster (average) and 500ms faster (p99) for larger workloads by moving logic from Node.js to the new Rust-powered core.

![将逻辑从 Node.js 迁移至全新的 Rust 驱动核心后，大型工作负载的平均响应速度提升最高达 80ms，P99 延迟降低最高达 500ms。](images/understanding-vercel-functions-vercel/img_001.jpg)![将逻辑从 Node.js 迁移至全新的 Rust 驱动核心后，大型工作负载的平均响应速度提升最高达 80ms，P99 延迟降低最高达 500ms。](images/understanding-vercel-functions-vercel/img_002.jpg)![将逻辑从 Node.js 迁移至全新的 Rust 驱动核心后，大型工作负载的平均响应速度提升最高达 80ms，P99 延迟降低最高达 500ms。](images/understanding-vercel-functions-vercel/img_003.jpg)![将逻辑从 Node.js 迁移至全新的 Rust 驱动核心后，大型工作负载的平均响应速度提升最高达 80ms，P99 延迟降低最高达 500ms。](images/understanding-vercel-functions-vercel/img_004.jpg)将逻辑从 Node.js 迁移至全新的 Rust 驱动核心后，大型工作负载的平均响应速度提升最高达 80ms，P99 延迟降低最高达 500ms。

## High availability

## 高可用性

Vercel Functions provide high availability out of the box.

Vercel Functions 开箱即用，具备高可用性。

You don't need to worry about server failures or downtime, as functions scale and failover automatically across availability zones ( [and even regions](https://vercel.com/docs/functions/configuring-functions/region#node.js-runtime-failover)). Further, features like [Instant Rollback](https://vercel.com/docs/deployments/instant-rollback) and [Skew Protection](https://vercel.com/docs/deployments/skew-protection) provide more ways to ensure your site is always online.

您无需担忧服务器故障或服务中断——函数会自动在多个可用区（甚至[跨地域](https://vercel.com/docs/functions/configuring-functions/region#node.js-runtime-failover)）间弹性伸缩与故障转移。此外，[即时回滚](https://vercel.com/docs/deployments/instant-rollback)和[偏斜防护](https://vercel.com/docs/deployments/skew-protection)等功能，进一步保障您的网站始终在线。

This level of resilience requires a large investment in infrastructure and monitoring when maintaining your own infrastructure.

若需在自建基础设施中实现同等程度的韧性，将需要在基础设施与监控系统上投入大量资源。

## Automatic downscaling and deprovisioning

## 自动降级与资源释放

Vercel Function can handle extremely variable traffic patterns, scaling up to 30,000 concurrent requests (or 100,000+ on Enterprise) without any manual intervention. This makes functions a great choice for ecommerce, media sites, or startup launches that are likely to attract lots of attention.

Vercel Functions 能够从容应对极不稳定的流量模式，在无需任何人工干预的情况下，支持高达 30,000 并发请求（企业版可达 100,000+）。因此，它非常适合作为电商网站、媒体平台或初创公司产品发布等高关注度场景的首选方案。

Traditional infrastructure can provide some cost efficiencies, with dedicated servers allowing unlimited data transfer for a fixed price. This does, however, require maintenance and manual management. After reaching the limits of the current infrastructure you have provisioned, you need to purchase (or rent) larger hardware.

传统基础设施虽可在一定程度上实现成本优化——例如通过专用服务器提供固定价格下的无限数据传输——但这也意味着需要持续运维与人工管理。一旦当前已部署的基础设施达到性能瓶颈，您就必须采购（或租用）更高规格的硬件。

Running compute that scales on demand (and back down to zero) allows you to have more granular [control over your spend](https://vercel.com/blog/introducing-spend-management-realtime-usage-alerts-sms-notifications). You only pay for the resources you use during a large traffic event and then return to your baseline spend, without needing to change your underlying hardware setup.

按需自动伸缩（并可缩容至零）的计算资源，使您能更精细地[掌控支出](https://vercel.com/blog/introducing-spend-management-realtime-usage-alerts-sms-notifications)。在遭遇大流量事件时，您仅需为实际使用的资源付费；流量回落之后，您的支出将自动回归基准水平，且无需调整底层硬件配置。

Vercel creates cloud infrastructure [based on your framework code](https://vercel.com/blog/framework-defined-infrastructure). This flexibility, combined with our [infinite preview environments](https://vercel.com/products/previews), means you can quickly and easily spin up new compute infrastructure to test your next big idea.

Vercel 基于您的框架代码[自动构建云基础设施](https://vercel.com/blog/framework-defined-infrastructure)。这种灵活性，叠加我们提供的[无限预览环境](https://vercel.com/products/previews)，意味着您可以快速、轻松地启动全新的计算基础设施，用以验证下一个重大构想。

And when you're done? Don't worry about leaving compute running forever for an experiment. You can rest assured (with your site behind [Deployment Protection](https://vercel.com/docs/security/deployment-protection)) your usage (and cost) scales to zero.

实验完成后呢？无需担心计算资源会永远运行下去。您尽可放心——只要您的网站启用了[部署保护（Deployment Protection）](https://vercel.com/docs/security/deployment-protection)，其资源使用量（及相应成本）便会自动缩容至零。

## Real-time usage and spend controls

## 实时用量与支出管控

Scalability shouldn't come at the risk of "denial of wallet", which is why we provide [recursion protection](https://vercel.com/changelog/automatic-recursion-protection-for-vercel-serverless-functions), [spend controls](https://vercel.com/blog/introducing-spend-management-realtime-usage-alerts-sms-notifications), and an [advanced Firewall](https://vercel.com/changelog/block-rate-limit-and-challenge-traffic-with-the-vercel-firewall).

可扩展性绝不应以“钱包拒绝服务”（denial of wallet）为代价。正因如此，我们提供了[递归调用防护](https://vercel.com/changelog/automatic-recursion-protection-for-vercel-serverless-functions)、[支出管控功能](https://vercel.com/blog/introducing-spend-management-realtime-usage-alerts-sms-notifications)，以及一套[高级防火墙](https://vercel.com/changelog/block-rate-limit-and-challenge-traffic-with-the-vercel-firewall)。

While servers offer predictable spend, Vercel provides [tools to control costs](https://vercel.com/docs/pricing/spend-management) and avoid unexpected bills, while still enabling your business to handle unexpected traffic surges.

传统服务器虽能带来可预测的支出，但 Vercel 提供了[一系列成本管控工具](https://vercel.com/docs/pricing/spend-management)，助您规避意外账单，同时仍能从容应对突发流量高峰。

![](images/understanding-vercel-functions-vercel/img_005.jpg)![](images/understanding-vercel-functions-vercel/img_006.jpg)

You can control the [maximum duration functions run](https://vercel.com/docs/functions/configuring-functions/duration), monitor usage in real time, [block traffic patterns](https://vercel.com/changelog/block-rate-limit-and-challenge-traffic-with-the-vercel-firewall), and set both soft and hard limits based on your spend. These alerts can be sent in the Vercel dashboard, through email, or even [SMS](https://vercel.com/docs/pricing/spend-management#sms-notifications). This visibility and control allows you to optimize your usage and keep costs under control.

您可以设置函数执行的[最长运行时长](https://vercel.com/docs/functions/configuring-functions/duration)，实时监控资源用量，[拦截异常流量模式](https://vercel.com/changelog/block-rate-limit-and-challenge-traffic-with-the-vercel-firewall)，并依据预算设定支出的软性上限与硬性上限。相关告警既可通过 Vercel 控制台查看，也可通过电子邮件发送，甚至支持[短信通知（SMS）](https://vercel.com/docs/pricing/spend-management#sms-notifications)。这种高度的可见性与可控性，让您得以持续优化资源使用，并牢牢掌控成本。

## Out-of-the-box observability

## 开箱即用的可观测性

Infrastructure platforms usually require you to choose your own tools for observability.

基础设施平台通常要求您自行选择可观测性（observability）工具。

While this allows flexibility, it does require more configuration and potentially vendoring solutions to understand runtime performance, errors, and logs.

虽然这提供了灵活性，但也需要更多配置，甚至可能需引入第三方方案（vendor solutions），以理解运行时性能、错误和日志。

Vercel Functions integrate with our observability suite for [build](https://vercel.com/docs/deployments/logs) and [runtime logs](https://vercel.com/docs/observability/runtime-logs), [advanced traffic monitoring](https://vercel.com/docs/observability/monitoring), and the ability to [drain logs](https://vercel.com/docs/observability/log-drains) to external services if you prefer.

Vercel Functions 与我们的可观测性套件深度集成，支持 [构建日志](https://vercel.com/docs/deployments/logs) 和 [运行时日志](https://vercel.com/docs/observability/runtime-logs)、[高级流量监控](https://vercel.com/docs/observability/monitoring)，以及（如您需要）将日志 [导出至外部服务](https://vercel.com/docs/observability/log-drains) 的能力。

![Quickly identify the root cause of persistent errors and customer issues with Logs.](images/understanding-vercel-functions-vercel/img_007.jpg)![Quickly identify the root cause of persistent errors and customer issues with Logs.](images/understanding-vercel-functions-vercel/img_008.jpg)通过日志快速定位持续性错误及客户问题的根本原因。

We have also integrated [support for OpenTelemetry (OTEL)](https://vercel.com/docs/observability/otel-overview) tracing. When viewing runtime logs, you can view the status, duration, URL, and even metrics for outgoing requests.

我们还集成了对 [OpenTelemetry（OTEL）](https://vercel.com/docs/observability/otel-overview) 追踪的支持。在查看运行时日志时，您可直观看到请求的状态、耗时、URL，甚至发起的出站请求的各项指标。

![Screenshot of new requests metrics, showing 5 outgoing fetch requests with traces on the side](images/understanding-vercel-functions-vercel/img_009.jpg)![Screenshot of new requests metrics, showing 5 outgoing fetch requests with traces on the side](images/understanding-vercel-functions-vercel/img_010.jpg)新请求指标截图：显示 5 次出站 fetch 请求，并在侧边展示对应的追踪信息。

## Summary

## 总结

With automatic scaling, high availability, cost efficiency, and built-in security, Vercel Functions abstract away many of the operational complexities associated with managing infrastructure.

凭借自动扩缩容、高可用性、成本效益和内置安全性，Vercel Functions 抽象掉了大量与基础设施运维相关的复杂性。

This allows developers to focus on building great products without worrying about the underlying infrastructure. With Vercel's [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure), developers can automatically use our scalable compute as defined by their [frontend framework](https://vercel.com/docs/frameworks) code.

这让开发者得以专注于打造卓越的产品，而无需操心底层基础设施。借助 Vercel 的 [框架定义基础设施（Framework-Defined Infrastructure）](https://vercel.com/blog/framework-defined-infrastructure)，开发者可直接依据其 [前端框架](https://vercel.com/docs/frameworks) 代码，自动启用我们可扩展的计算资源。

Vercel Functions give you predictable CPU performance, the ability to run dynamic workloads in [multiple regions](https://vercel.com/docs/functions/configuring-functions/region), [automatic SSL and encryption](https://vercel.com/docs/security/encryption), [integrated CI/CD into your Git workflow](https://vercel.com/docs/deployments/git), [preview environments](https://vercel.com/products/dx-platform), [instant rollbacks](https://vercel.com/docs/deployments/instant-rollback), and more—and you can get started for free!

Vercel Functions 提供可预期的 CPU 性能、在 [多个区域](https://vercel.com/docs/functions/configuring-functions/region) 运行动态工作负载的能力、[自动 SSL 与加密](https://vercel.com/docs/security/encryption)、与 Git 工作流深度集成的 [CI/CD](https://vercel.com/docs/deployments/git)、[预览环境（Preview Environments）](https://vercel.com/products/dx-platform)、[即时回滚（Instant Rollbacks）](https://vercel.com/docs/deployments/instant-rollback) 等诸多功能——而且，您可完全免费开始使用！

[Learn more about Vercel Functions](https://vercel.com/docs/functions) or get started [building your first site](https://vercel.com/templates).

[进一步了解 Vercel Functions](https://vercel.com/docs/functions)，或立即 [搭建您的首个网站](https://vercel.com/templates)。