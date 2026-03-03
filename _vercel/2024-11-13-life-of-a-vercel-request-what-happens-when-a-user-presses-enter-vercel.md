---
title: "Life of a Vercel request: What happens when a user presses enter - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/life-of-a-vercel-request-what-happens-when-a-user-presses-enter"
date: "2024-11-13"
scraped_at: "2026-03-02T09:39:29.236659166+00:00"
language: "en-zh"
translated: true
description: "Application delivery through the lens of a web request with Vercel’s framework-defined infrastructure."
---

Nov 13, 2024

2024 年 11 月 13 日

Application delivery through the lens of a web request.

以一次 Web 请求为视角，审视应用交付过程。

When developers push code, Vercel’s [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure) analyzes the codebase and intelligently provisions cloud resources. When requests come in, Vercel’s infrastructure instantly routes them to the nearest data center over a high-speed, low-latency network, delivering a response right back to the user.

当开发者推送代码时，Vercel 的 [框架定义基础设施（Framework-Defined Infrastructure）](https://vercel.com/blog/framework-defined-infrastructure) 会分析代码库，并智能地配置云资源。当请求到达时，Vercel 基础设施通过高速、低延迟的网络，立即将其路由至地理上最近的数据中心，并将响应直接返回给用户。

Vercel handles all of this behind the scenes. But understanding how your framework code powers the infrastructure—from deployment to request handling—gives you insight into how Vercel’s components work together, and enables you to further optimize user experiences.

上述所有环节均由 Vercel 在后台自动完成。但深入理解你的框架代码如何驱动整套基础设施——从部署到请求处理——有助于你洞悉 Vercel 各组件间的协同机制，从而进一步优化终端用户体验。

Here’s how Vercel manages requests at every stage.

以下介绍 Vercel 如何在每个阶段管理请求。

## The on-ramp to high-performance application delivery

## 高性能应用交付的“入口通道”

When users access apps served by Vercel, their network requests are handled by a dedicated network—designed for speed, reliability, redundancy, and scalability.

当用户访问由 Vercel 托管的应用时，其网络请求由一套专用网络处理——该网络专为高速、高可靠性、冗余容错与弹性扩展而设计。

![Globally available, the Vercel Edge Network handles high traffic volumes with low latency, delivering fast, reliable application performance](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_001.jpg)![Globally available, the Vercel Edge Network handles high traffic volumes with low latency, delivering fast, reliable application performance](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_002.jpg)![Globally available, the Vercel Edge Network handles high traffic volumes with low latency, delivering fast, reliable application performance](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_003.jpg)![Globally available, the Vercel Edge Network handles high traffic volumes with low latency, delivering fast, reliable application performance](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_004.jpg)Globally available, the Vercel Edge Network handles high traffic volumes with low latency, delivering fast, reliable application performance

![全球可用的 Vercel 边缘网络（Vercel Edge Network）可低延迟承载高并发流量，提供快速、稳定的应用性能](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_001.jpg)![全球可用的 Vercel 边缘网络（Vercel Edge Network）可低延迟承载高并发流量，提供快速、稳定的应用性能](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_002.jpg)![全球可用的 Vercel 边缘网络（Vercel Edge Network）可低延迟承载高并发流量，提供快速、稳定的应用性能](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_003.jpg)![全球可用的 Vercel 边缘网络（Vercel Edge Network）可低延迟承载高并发流量，提供快速、稳定的应用性能](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_004.jpg)全球可用的 Vercel 边缘网络（Vercel Edge Network）可低延迟承载高并发流量，提供快速、稳定的应用性能

[Anycast routing](https://vercel.com/blog/effortless-high-availability-for-dynamic-frontends#initiating-at-edge:-optimized-global-routing) directs each request to the optimal Point of Presence (PoP) across 100+ global locations, using proximity and live network conditions to minimize latency for the user's first interaction with Vercel Infrastructure—in this case the congestion-free, fault-tolerant private fiber [**Vercel Edge Network**](https://vercel.com/docs/edge-network/overview).

[任播路由（Anycast routing）](https://vercel.com/blog/effortless-high-availability-for-dynamic-frontends#initiating-at-edge:-optimized-global-routing) 将每个请求导向全球 100 多个地理位置中最优的接入点（Point of Presence, PoP），综合考量物理距离与实时网络状况，以最小化用户首次与 Vercel 基础设施交互时的延迟——本例中即指无拥塞、具备容错能力的私有光纤网络：[**Vercel 边缘网络（Vercel Edge Network）**](https://vercel.com/docs/edge-network/overview)。

![Globally distributed Points of Presence (PoPs) provide local entry to the Vercel Edge Network, instantly routing each request to the optimal Edge Region, determined in real time.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_005.jpg)![Globally distributed Points of Presence (PoPs) provide local entry to the Vercel Edge Network, instantly routing each request to the optimal Edge Region, determined in real time.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_006.jpg)![Globally distributed Points of Presence (PoPs) provide local entry to the Vercel Edge Network, instantly routing each request to the optimal Edge Region, determined in real time.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_007.jpg)![Globally distributed Points of Presence (PoPs) provide local entry to the Vercel Edge Network, instantly routing each request to the optimal Edge Region, determined in real time.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_008.jpg)Globally distributed Points of Presence (PoPs) provide local entry to the Vercel Edge Network, instantly routing each request to the optimal Edge Region, determined in real time.

![全球分布式接入点（PoPs）为用户提供本地化入口，接入 Vercel 边缘网络，并实时动态地将每个请求即时路由至最优边缘区域（Edge Region）。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_005.jpg)![全球分布式接入点（PoPs）为用户提供本地化入口，接入 Vercel 边缘网络，并实时动态地将每个请求即时路由至最优边缘区域（Edge Region）。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_006.jpg)![全球分布式接入点（PoPs）为用户提供本地化入口，接入 Vercel 边缘网络，并实时动态地将每个请求即时路由至最优边缘区域（Edge Region）。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_007.jpg)![全球分布式接入点（PoPs）为用户提供本地化入口，接入 Vercel 边缘网络，并实时动态地将每个请求即时路由至最优边缘区域（Edge Region）。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_008.jpg)全球分布式接入点（PoPs）为用户提供本地化入口，接入 Vercel 边缘网络，并实时动态地将每个请求即时路由至最优边缘区域（Edge Region）。

## Securing your app’s entryway with Vercel Firewall

## 使用 Vercel 防火墙保障应用入口安全

As requests reach Vercel's Edge Network, still at the PoP, they encounter multiple stages of [Vercel Firewall](https://vercel.com/docs/security/vercel-firewall)’s defense-in-depth system, covering Network-layer 3, Transport-layer 4, and Application-layer 7. This firewall combines Vercel-managed global protections with your custom rules and logic.

当请求抵达 Vercel 边缘网络（仍处于接入点 PoP）时，会经过 [Vercel 防火墙](https://vercel.com/docs/security/vercel-firewall) 多层纵深防御体系的多个阶段，覆盖网络层（第 3 层）、传输层（第 4 层）和应用层（第 7 层）。该防火墙融合了 Vercel 全局托管的安全防护能力与您自定义的规则及逻辑。

The first layer analyzes traffic across all Vercel deployments, using global intelligence and awareness of all previous requests to block L3 and L4 threats—like DDoS, SYN Floods, and UDP attacks—close to the source, long before they reach your app's resources.

第一层防御面向所有 Vercel 部署的流量进行全局分析，依托全球威胁情报及对全部历史请求的感知能力，在攻击源头附近即拦截第 3 层和第 4 层威胁（如 DDoS 攻击、SYN 洪水攻击、UDP 洪水攻击），远早于其触及您的应用资源。

Allowed requests are routed in milliseconds to the nearest of Vercel’s 18 global Edge Regions. These regions introduce application-layer defenses, mitigating risks like HTTP Floods or Slowloris attacks.

获准通过的请求将在毫秒级内被路由至 Vercel 全球 18 个边缘区域中地理位置最近的一个。这些边缘区域部署了应用层防护机制，可有效缓解 HTTP 洪水攻击、Slowloris 攻击等风险。

At this point in the request lifecycle, system-level firewall protections have automatically enforced enterprise-grade attack mitigations for all customers. With over 1 billion malicious TCP connections prevented weekly, the [Vercel Firewall](https://vercel.com/docs/security/vercel-firewall) plays a critical role in [preventing harmful traffic](https://vercel.com/blog/preventing-infrastructure-abuse-with-vercel-firewall) from reaching and abusing your scalable application resources.

在此请求生命周期阶段，系统级防火墙防护已自动为所有客户启用企业级攻击缓解能力。凭借每周拦截超 10 亿次恶意 TCP 连接的成效，[Vercel 防火墙](https://vercel.com/docs/security/vercel-firewall) 在[防止有害流量抵达并滥用您的弹性应用资源](https://vercel.com/blog/preventing-infrastructure-abuse-with-vercel-firewall)方面发挥着关键作用。

Once requests in the Edge Regions pass these defenses, they become application-aware, gaining full context of your deployments, security logic, and routing decisions. This is where your application logic and framework code come to life.

当请求在边缘区域成功通过上述防护后，便具备了“应用感知”能力，全面掌握您部署的上下文、安全逻辑及路由决策。此时，您的应用逻辑与框架代码才真正开始执行。

![Vercel Firewall is a multi-layered defense system that analyzes global traffic in real-time to detect and mitigate threats across all customers.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_009.jpg)![Vercel Firewall is a multi-layered defense system that analyzes global traffic in real-time to detect and mitigate threats across all customers.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_010.jpg)![Vercel Firewall is a multi-layered defense system that analyzes global traffic in real-time to detect and mitigate threats across all customers.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_011.jpg)![Vercel Firewall is a multi-layered defense system that analyzes global traffic in real-time to detect and mitigate threats across all customers.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_012.jpg)Vercel Firewall is a multi-layered defense system that analyzes global traffic in real-time to detect and mitigate threats across all customers.

![Vercel 防火墙是一个多层防御系统，可实时分析全球流量，跨所有客户检测并缓解各类威胁。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_009.jpg)![Vercel 防火墙是一个多层防御系统，可实时分析全球流量，跨所有客户检测并缓解各类威胁。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_010.jpg)![Vercel 防火墙是一个多层防御系统，可实时分析全球流量，跨所有客户检测并缓解各类威胁。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_011.jpg)![Vercel 防火墙是一个多层防御系统，可实时分析全球流量，跨所有客户检测并缓解各类威胁。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_012.jpg)Vercel 防火墙是一个多层防御系统，可实时分析全球流量，跨所有客户检测并缓解各类威胁。

But the requests aren't through all security checkpoints yet. They then encounter the next line of Vercel Firewall's defenses: the [Web Application Firewall (WAF)](https://vercel.com/docs/security/vercel-waf).

但请求尚未通过全部安全检查点。接下来，它们将面临 Vercel 防火墙的下一道防线：[Web 应用防火墙（WAF）](https://vercel.com/docs/security/vercel-waf)。

## Customizable application protection with Vercel Web Application Firewall

## 借助 Vercel Web 应用防火墙实现可定制的应用防护

While the platform-wide Vercel Firewall provides automated defenses, the WAF offers project-level control to customize what "undesired traffic" means for your app. You can set rules like IP blocking, rate limiting, and deep inspections using Vercel’s [managed rulesets](https://vercel.com/docs/security/vercel-waf/managed-rulesets), targeting common risks like those in the [OWASP Top 10](https://owasp.org/www-project-top-ten/).

尽管全平台级的 Vercel 防火墙提供自动化防御能力，WAF 则赋予您项目级别的控制权，让您自主定义何为针对您应用的“不良流量”。您可借助 Vercel 的[托管规则集](https://vercel.com/docs/security/vercel-waf/managed-rulesets)，设置 IP 封禁、速率限制、深度检测等规则，精准应对 OWASP Top 10 等常见安全风险。

The WAF’s flexibility allows teams to tailor security through Vercel’s interface and APIs, integrating it into development and automation workflows.

WAF 的灵活性使团队能够通过 Vercel 的界面和 API 定制安全策略，并将其无缝集成到开发与自动化工作流中。

The WAF syncs with earlier defenses: If a rule with a [persistent action](https://vercel.com/docs/security/vercel-waf/custom-rules#persistent-actions) triggers, upstream stages of the Vercel Firewall intercept future requests before they reach the WAF. This blocks repeat offenders sooner, and prevents all usage and costs associated with the malicious traffic.

WAF 与前置防御机制协同联动：当一条配置了[持久化操作](https://vercel.com/docs/security/vercel-waf/custom-rules#persistent-actions)的规则被触发时，Vercel 防火墙的上游阶段将在请求抵达 WAF 之前即行拦截后续同类请求。此举可更早地封禁恶意行为反复发生者，并彻底避免因恶意流量产生的所有资源消耗与相关费用。

![Vercel Web Application Firewall enforces customizable rules, shielding each app from unwanted traffic based on defined business logic.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_013.jpg)![Vercel Web Application Firewall enforces customizable rules, shielding each app from unwanted traffic based on defined business logic.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_014.jpg)![Vercel Web Application Firewall enforces customizable rules, shielding each app from unwanted traffic based on defined business logic.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_015.jpg)![Vercel Web Application Firewall enforces customizable rules, shielding each app from unwanted traffic based on defined business logic.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_016.jpg)Vercel Web Application Firewall enforces customizable rules, shielding each app from unwanted traffic based on defined business logic.

![Vercel Web 应用防火墙（WAF）执行可自定义的规则，依据预设的业务逻辑，为每个应用屏蔽不符合要求的流量。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_013.jpg)![Vercel Web 应用防火墙（WAF）执行可自定义的规则，依据预设的业务逻辑，为每个应用屏蔽不符合要求的流量。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_014.jpg)![Vercel Web 应用防火墙（WAF）执行可自定义的规则，依据预设的业务逻辑，为每个应用屏蔽不符合要求的流量。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_015.jpg)![Vercel Web 应用防火墙（WAF）执行可自定义的规则，依据预设的业务逻辑，为每个应用屏蔽不符合要求的流量。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_016.jpg)Vercel Web 应用防火墙（WAF）执行可自定义的规则，依据预设的业务逻辑，为每个应用屏蔽不符合要求的流量。

## Advanced routing with Edge Middleware, redirects, and rewrites

## 借助边缘中间件（Edge Middleware）、重定向（redirects）与路径重写（rewrites）实现高级路由

After a request clears the WAF and meets your application’s security policies, Vercel routing takes control to handle advanced routing through redirects, rewrites, and programmatic [Edge Middleware](https://vercel.com/docs/functions/edge-middleware).

当请求成功通过 WAF 并符合应用的安全策略后，Vercel 的路由系统将接管处理，借助重定向、路径重写以及可编程的[边缘中间件（Edge Middleware）](https://vercel.com/docs/functions/edge-middleware)实现高级路由控制。

Routing tools like redirects send the browser to a new location, while rewrites adjust the request path without changing the visible URL, keeping the user experience intact.

重定向类路由工具会将浏览器引导至新地址；而路径重写则在不改变用户可见 URL 的前提下调整请求路径，从而保障一致的用户体验。

These can be pre-configured directly through framework code for known URL or path changes. For more dynamic needs, developers can use Edge Middleware to manage tasks like experimentation or geographic routing.

对于已知的 URL 或路径变更，这些路由规则可直接通过框架代码预先配置；而对于更动态的场景（例如 A/B 测试或基于地理位置的路由），开发者则可借助 Edge Middleware 进行灵活管理。

Edge Middleware also allows developers to inject business logic—such as user identity or location—and make real-time adjustments to request flow. This enables tasks like modifying headers, authenticating users, and conditional routing to filter unnecessary traffic early, optimizing resources and ensuring only relevant requests reach backend services.

Edge Middleware 还支持开发者注入业务逻辑（例如用户身份、地理位置等），并实时调整请求流转路径。由此可实现修改请求头、用户身份认证、条件化路由等功能，在请求流程早期即过滤掉无关流量，从而优化资源使用，并确保仅有相关请求最终抵达后端服务。

![Vercel routes requests using hard-coded redirects and rewrites—for tasks like URL changes and microfrontends—and programmatic middleware for dynamic decisions and personalization.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_017.jpg)![Vercel routes requests using hard-coded redirects and rewrites—for tasks like URL changes and microfrontends—and programmatic middleware for dynamic decisions and personalization.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_018.jpg)![Vercel routes requests using hard-coded redirects and rewrites—for tasks like URL changes and microfrontends—and programmatic middleware for dynamic decisions and personalization.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_019.jpg)![Vercel routes requests using hard-coded redirects and rewrites—for tasks like URL changes and microfrontends—and programmatic middleware for dynamic decisions and personalization.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_020.jpg)Vercel routes requests using hard-coded redirects and rewrites—for tasks like URL changes and microfrontends—and programmatic middleware for dynamic decisions and personalization.

![Vercel 通过硬编码的重定向与路径重写（适用于 URL 变更、微前端等场景），结合可编程的中间件，实现动态决策与个性化路由。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_017.jpg)![Vercel 通过硬编码的重定向与路径重写（适用于 URL 变更、微前端等场景），结合可编程的中间件，实现动态决策与个性化路由。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_018.jpg)![Vercel 通过硬编码的重定向与路径重写（适用于 URL 变更、微前端等场景），结合可编程的中间件，实现动态决策与个性化路由。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_019.jpg)![Vercel 通过硬编码的重定向与路径重写（适用于 URL 变更、微前端等场景），结合可编程的中间件，实现动态决策与个性化路由。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_020.jpg)Vercel 通过硬编码的重定向与路径重写（适用于 URL 变更、微前端等场景），结合可编程的中间件，实现动态决策与个性化路由。

Whether traffic is predefined through redirects and rewrites or dynamically adjusted via Middleware, Vercel routing ensures efficient routing to the appropriate destination. In complex architectures like [microfrontends](https://vercel.com/blog/how-vercel-adopted-microfrontends), routing coordinates traffic across multiple services under one domain, ensuring a smooth user experience.

无论流量是通过重定向与路径重写预先定义，还是经由中间件动态调整，Vercel 的路由系统均能确保请求高效、准确地分发至目标服务。在[微前端（microfrontends）](https://vercel.com/blog/how-vercel-adopted-microfrontends)等复杂架构中，路由机制可在单一域名下协调多个服务间的流量，从而保障流畅一致的用户体验。

## Caching at the edge to speed up responses

## 利用边缘缓存加速响应

After passing through the router, requests reach [Vercel’s Edge Cache](https://vercel.com/docs/edge-network/caching), optimized for high cache hit ratios. The cache is automatically configured and managed by Vercel, and is tightly integrated with [Vercel Functions](https://vercel.com/docs/functions) to remain fast, fresh, and globally available with minimal overhead.

请求经由路由器转发后，抵达 [Vercel 边缘缓存（Vercel’s Edge Cache）](https://vercel.com/docs/edge-network/caching)，该缓存专为实现高缓存命中率而优化。缓存由 Vercel 自动配置与管理，并与 [Vercel Functions](https://vercel.com/docs/functions) 深度集成，从而在极低开销下保障响应速度、内容时效性及全球可用性。

Developers don't directly need to manage the cache. Instead, based on how their codebase is written, the configuration is derived via Vercel's framework-defined infrastructure which helps ensure parity between local dev, preview, staging, and production environments.

开发者无需直接管理缓存。相反，Vercel 会依据代码库的编写方式，通过其框架定义的基础设施自动推导缓存配置，从而确保本地开发、预览（Preview）、预发布（Staging）和生产（Production）环境之间的一致性。

Data is kept current through updates and revalidation, based on content status—fresh, stale, or due for regeneration—and the developer's framework code.

数据的新鲜度通过更新与重新验证（revalidation）来维持，具体策略取决于内容状态（新鲜、过期或需再生）以及开发者所用框架的代码逻辑。

Static assets like images, CSS, JavaScript, and dynamic API responses are cached close to the user. With [Incremental Static Regeneration (ISR)](https://vercel.com/blog/isr-a-flexible-way-to-cache-dynamic-content), content revalidation ensures fresh content is served or regenerated when needed either on-demand or at scheduled intervals.

图片、CSS、JavaScript 等静态资源，以及动态 API 响应，均被缓存在靠近用户的位置。借助 [增量静态再生（Incremental Static Regeneration, ISR）](https://vercel.com/blog/isr-a-flexible-way-to-cache-dynamic-content)，内容可按需或按预定时间间隔进行重新验证，从而确保始终提供最新内容，或在必要时即时再生。

![Vercel Edge Cache automatically stores static assets and dynamic responses based on your framework code, removing the need for manual configuration and management.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_021.jpg)![Vercel Edge Cache automatically stores static assets and dynamic responses based on your framework code, removing the need for manual configuration and management.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_022.jpg)![Vercel Edge Cache automatically stores static assets and dynamic responses based on your framework code, removing the need for manual configuration and management.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_023.jpg)![Vercel Edge Cache automatically stores static assets and dynamic responses based on your framework code, removing the need for manual configuration and management.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_024.jpg)Vercel Edge Cache automatically stores static assets and dynamic responses based on your framework code, removing the need for manual configuration and management.

![Vercel 边缘缓存会根据您的框架代码，自动存储静态资源和动态响应，无需手动配置与管理。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_021.jpg)![Vercel 边缘缓存会根据您的框架代码，自动存储静态资源和动态响应，无需手动配置与管理。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_022.jpg)![Vercel 边缘缓存会根据您的框架代码，自动存储静态资源和动态响应，无需手动配置与管理。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_023.jpg)![Vercel 边缘缓存会根据您的框架代码，自动存储静态资源和动态响应，无需手动配置与管理。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_024.jpg)Vercel 边缘缓存会根据您的框架代码，自动存储静态资源和动态响应，无需手动配置与管理。

## Vercel Functions for scalable and dynamic compute

## 面向弹性与动态计算的 Vercel Functions

When a request needs fresh data or content revalidation, Vercel Functions step in to manage the compute. They’re automatically provisioned and routed based on your framework code, with everything set up in the background.

当请求需要获取最新数据或执行内容重新验证时，Vercel Functions 将介入处理计算任务。它们会依据您的框架代码自动完成资源配置与路由分发，全部后台自动完成，无需人工干预。

For example, in server-side rendering (SSR), functions generate and stream HTML for each request, with responses storable in the Edge Cache for faster future loads. They can also serve API routes, providing JSON data for backend tasks and integrations.

例如，在服务端渲染（SSR）场景中，函数为每个请求生成并流式传输 HTML，响应结果可缓存至边缘缓存，以加快后续访问速度；同时，它们也可承载 API 路由，为后端任务与系统集成提供 JSON 数据。

Vercel Functions scale dynamically to handle high traffic—without extra configuration. Whether running at the Edge or closer to your backend, they help reduce latency for tasks like database connections and API requests.

Vercel Functions 可动态扩缩容以应对高流量压力——全程无需额外配置。无论部署于边缘节点还是更靠近后端的位置，它们均可显著降低数据库连接、API 请求等任务的延迟。

Vercel Functions leverage optimizations like [bytecode caching](https://vercel.com/changelog/bytecode-caching-for-serverless-functions-by-default) and [pre-warming](https://vercel.com/changelog/vercel-functions-now-have-faster-and-fewer-cold-starts) to minimize cold starts and boost response times.

Vercel Functions 利用诸如 [字节码缓存（bytecode caching）](https://vercel.com/changelog/bytecode-caching-for-serverless-functions-by-default) 和 [预热（pre-warming）](https://vercel.com/changelog/vercel-functions-now-have-faster-and-fewer-cold-starts) 等优化手段，最大限度减少冷启动，并提升响应速度。

![Vercel Functions provide scalable compute for dynamic requests, including rendering, page and asset revalidation, and APIs.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_025.jpg)![Vercel Functions provide scalable compute for dynamic requests, including rendering, page and asset revalidation, and APIs.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_026.jpg)![Vercel Functions provide scalable compute for dynamic requests, including rendering, page and asset revalidation, and APIs.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_027.jpg)![Vercel Functions provide scalable compute for dynamic requests, including rendering, page and asset revalidation, and APIs.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_028.jpg)Vercel Functions provide scalable compute for dynamic requests, including rendering, page and asset revalidation, and APIs.

![Vercel Functions 提供可扩展的计算能力，用于处理动态请求，包括页面渲染、页面与资源的重新验证（revalidation），以及 API 调用。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_025.jpg)![Vercel Functions 提供可扩展的计算能力，用于处理动态请求，包括页面渲染、页面与资源的重新验证（revalidation），以及 API 调用。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_026.jpg)![Vercel Functions 提供可扩展的计算能力，用于处理动态请求，包括页面渲染、页面与资源的重新验证（revalidation），以及 API 调用。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_027.jpg)![Vercel Functions 提供可扩展的计算能力，用于处理动态请求，包括页面渲染、页面与资源的重新验证（revalidation），以及 API 调用。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_028.jpg)Vercel Functions 提供可扩展的计算能力，用于处理动态请求，包括页面渲染、页面与资源的重新验证（revalidation），以及 API 调用。

## Application delivery that makes the web feel native

## 让网页体验如原生应用般流畅的应用交付

With Vercel, your app reaches users globally with speed and security. Developers stay focused on building, while users experience your app exactly as intended.

借助 Vercel，您的应用能够以高速和高安全性触达全球用户。开发者可专注于构建，而用户则能获得完全符合预期的应用体验。

Vercel's platform powers web apps that feel as smooth as native apps. It’s more than handling requests—it’s about delivering fast, reliable web experiences that feel like they’re happening directly on your device, not over the internet.

Vercel 的平台赋能 Web 应用，使其运行如原生应用般顺滑流畅。这远不止于处理请求——更在于交付快速、可靠的 Web 体验，让用户感觉一切操作都直接发生在本地设备上，而非经由互联网远程完成。

![The Vercel Edge Network automatically deploys and coordinates optimal cloud infrastructure to deliver your applications—all based on your framework code.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_029.jpg)![The Vercel Edge Network automatically deploys and coordinates optimal cloud infrastructure to deliver your applications—all based on your framework code.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_030.jpg)![The Vercel Edge Network automatically deploys and coordinates optimal cloud infrastructure to deliver your applications—all based on your framework code.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_031.jpg)![The Vercel Edge Network automatically deploys and coordinates optimal cloud infrastructure to deliver your applications—all based on your framework code.](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_032.jpg)The Vercel Edge Network automatically deploys and coordinates optimal cloud infrastructure to deliver your applications—all based on your framework code.

![Vercel 边缘网络（Edge Network）会自动部署并协调最优云基础设施，以交付您的应用——全部基于您所使用的框架代码。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_029.jpg)![Vercel 边缘网络（Edge Network）会自动部署并协调最优云基础设施，以交付您的应用——全部基于您所使用的框架代码。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_030.jpg)![Vercel 边缘网络（Edge Network）会自动部署并协调最优云基础设施，以交付您的应用——全部基于您所使用的框架代码。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_031.jpg)![Vercel 边缘网络（Edge Network）会自动部署并协调最优云基础设施，以交付您的应用——全部基于您所使用的框架代码。](images/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-vercel/img_032.jpg)Vercel 边缘网络（Edge Network）会自动部署并协调最优云基础设施，以交付您的应用——全部基于您所使用的框架代码。

[**Scale globally from your first commit.**\\
\\
Start with Vercel to deploy and scale your app globally—right from your framework code.\\
\\
Deploy now](https://vercel.com/new)

[**从首次提交起，即实现全球规模化部署。**\\
\\
立即使用 Vercel，基于您的框架代码，一键完成应用的全球部署与弹性伸缩。\\
\\
立即部署](https://vercel.com/new)