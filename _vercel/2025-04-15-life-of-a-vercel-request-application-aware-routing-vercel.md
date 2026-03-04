---
render_with_liquid: false
title: "Life of a Vercel request: Application-aware routing - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/life-of-a-request-application-aware-routing"
date: "2025-04-15"
scraped_at: "2026-03-02T09:34:59.573056569+00:00"
language: "en-zh"
translated: true
description: "Vercel's gateway leverages framework-defined infrastructure to intelligently load balance, protect, and route applications at-scale and with any architecture complexity."
---
render_with_liquid: false
render_with_liquid: false

Apr 15, 2025

2025 年 4 月 15 日

Vercel 的部署包含面向应用的请求处理能力，该能力直接源自您的框架代码。

路由是交付应用程序的基础环节，却常常被当作事后的补充——被生硬地附加到缓存层之上，并通过复杂的 YAML 配置文件或手动点击式操作（click-ops）进行配置。这种做法不仅会给团队带来使用摩擦，还会增加配置错误的风险，并拖慢部署速度，尤其当应用程序复杂度不断提升时更是如此。

Vercel 采取了截然不同的路径：路由作为平台原生能力，以“面向应用的网关”（application-aware gateway）形式深度集成，能够真正理解您的代码库。这一设计解锁了一系列关键能力——通过降低配置负担、减少延迟、支持更先进的架构，显著简化开发流程。

该网关全面掌握您部署的上下文信息，包括所用域名、部署实例及业务逻辑。它既支持标准路由与自定义规则，又远超传统反向代理的能力：可实时解析应用逻辑，从而做出更智能的决策（例如跳过不必要的计算）。

以下将介绍 Vercel 如何路由请求——以及为何这种机制让构建高性能、高复杂度的应用变得更加轻松。

[**回顾前文：阅读第一部分**\\
\\
Vercel 请求的生命周期：当用户按下回车键时发生了什么？\\
\\
立即阅读](https://vercel.com/blog/life-of-a-vercel-request-what-happens-when-a-user-presses-enter)

## 具备路由感知与应用感知能力的基础设施

Vercel 利用您的[框架代码来定义基础设施](https://vercel.com/blog/framework-defined-infrastructure)，并决定运行时如何处理请求。这种深度集成使平台能全面洞察您应用的结构：包括路由（routes）、布局（layouts）、重写规则（rewrites）、中间件（middleware）、函数（functions）、静态资源（static assets）以及路由逻辑（routing logic）。

我们将此类基础设施称为**具备路由感知能力**（route-aware）与**具备应用感知能力**（application-aware）的基础设施。正是这种“感知力”，驱动平台对构建产物、请求解析、响应生成与内容分发等各个环节进行全方位优化。

![Framework-defined infrastructure turns each code snapshot into a deployment—an isolated, versioned object that acts as the blueprint for cloud resources, including environment variables, routing rules, caching behavior, and compute.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_001.jpg)  
![框架定义的基础设施将每个代码快照转化为一次部署——一个隔离的、带版本号的对象，作为云资源（包括环境变量、路由规则、缓存行为和计算资源）的蓝图。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_001.jpg)  

![Framework-defined infrastructure turns each code snapshot into a deployment—an isolated, versioned object that acts as the blueprint for cloud resources, including environment variables, routing rules, caching behavior, and compute.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_002.jpg)  
![框架定义的基础设施将每个代码快照转化为一次部署——一个隔离的、带版本号的对象，作为云资源（包括环境变量、路由规则、缓存行为和计算资源）的蓝图。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_002.jpg)  

![Framework-defined infrastructure turns each code snapshot into a deployment—an isolated, versioned object that acts as the blueprint for cloud resources, including environment variables, routing rules, caching behavior, and compute.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_003.jpg)  
![框架定义的基础设施将每个代码快照转化为一次部署——一个隔离的、带版本号的对象，作为云资源（包括环境变量、路由规则、缓存行为和计算资源）的蓝图。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_003.jpg)  

![Framework-defined infrastructure turns each code snapshot into a deployment—an isolated, versioned object that acts as the blueprint for cloud resources, including environment variables, routing rules, caching behavior, and compute.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_004.jpg)  
![框架定义的基础设施将每个代码快照转化为一次部署——一个隔离的、带版本号的对象，作为云资源（包括环境变量、路由规则、缓存行为和计算资源）的蓝图。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_004.jpg)  

Framework-defined infrastructure turns each code snapshot into a deployment—an isolated, versioned object that acts as the blueprint for cloud resources, including environment variables, routing rules, caching behavior, and compute.

框架定义的基础设施将每个代码快照转化为一次部署——一个隔离的、带版本号的对象，作为云资源（包括环境变量、路由规则、缓存行为和计算资源）的蓝图。

Unlike a traditional standalone CDN, Vercel's gateway doesn’t need to be manually wired to backends or hardcoded to interpret intent. Routing is not bolted on—it's defined by your app and built into the deployment. This allows it to resolve requests across millions of domains and deployments in real time.

与传统独立 CDN 不同，Vercel 的网关无需手动连接后端，也无需硬编码以解析用户意图。路由并非事后附加的功能——它由您的应用自身定义，并直接内置于部署之中。这使其能够实时处理跨越数百万个域名和部署的请求。

### Aliasing domains on Vercel

### 在 Vercel 上为域名设置别名

Every domain—whether it’s your [custom domain purchased through Vercel](https://vercel.com/docs/getting-started-with-vercel/buy-domain) or a third-party, or a free `*.vercel.app` domain—serves as an external entry point from the internet.

每个域名——无论是您[通过 Vercel 购买的自定义域名](https://vercel.com/docs/getting-started-with-vercel/buy-domain)，还是第三方注册的域名，抑或免费的 `*.vercel.app` 域名——均作为来自互联网的外部入口点。

Behind the scenes, these domains are _aliases_—logical mappings to a deployment within Vercel’s global routing.

在后台，这些域名均为“别名”（_aliases_）——即对 Vercel 全球路由系统中某一部署的逻辑映射。

Each _deployment_, shaped by the framework-defined build process, includes its own routing table, middleware, headers, and logic—providing full app context for request evaluation and WAF logic. When a domain is aliased to point to a deployment, Vercel automatically provisions and manages SSL/TLS certificates for HTTPS with no manual configuration, risk of expiration, or downtime.

每个 _deployment_（部署）均由框架定义的构建流程生成，自带其专属的路由表、中间件、响应头及业务逻辑——从而为请求评估与 Web 应用防火墙（WAF）逻辑提供完整的应用上下文。当某个域名被设置为指向某次部署时，Vercel 会自动为该域名配置并管理 HTTPS 所需的 SSL/TLS 证书，全程无需人工干预，亦无证书过期风险或服务中断。

![Every domain on Vercel is an alias that maps to a specific deployment in the routing layer, ensuring requests are routed to the correct version globally.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_005.jpg)  
![Vercel 上的每个域名都是一个别名，映射至路由层中的特定部署，确保请求在全球范围内被准确路由至对应版本。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_005.jpg)  

![Every domain on Vercel is an alias that maps to a specific deployment in the routing layer, ensuring requests are routed to the correct version globally.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_006.jpg)  
![Vercel 上的每个域名都是一个别名，映射至路由层中的特定部署，确保请求在全球范围内被准确路由至对应版本。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_006.jpg)  

![Every domain on Vercel is an alias that maps to a specific deployment in the routing layer, ensuring requests are routed to the correct version globally.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_007.jpg)  
![Vercel 上的每个域名都是一个别名，映射至路由层中的特定部署，确保请求在全球范围内被准确路由至对应版本。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_007.jpg)  

![Every domain on Vercel is an alias that maps to a specific deployment in the routing layer, ensuring requests are routed to the correct version globally.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_008.jpg)  
![Vercel 上的每个域名都是一个别名，映射至路由层中的特定部署，确保请求在全球范围内被准确路由至对应版本。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_008.jpg)  

Every domain on Vercel is an alias that maps to a specific deployment in the routing layer, ensuring requests are routed to the correct version globally.

Vercel 上的每个域名都是一个别名，映射至路由层中的特定部署，确保请求在全球范围内被准确路由至对应版本。

### **De-aliasing and early stages of request fulfillment**

### **去别名化与请求处理的早期阶段**

[When a request is made](https://vercel.com/blog/life-of-a-vercel-request-what-happens-when-a-user-presses-enter) to your domain, it travels via Anycast routing to the nearest Point of Presence (PoP), passes through initial DDoS mitigations, and lands in a Vercel Region for initial Web Application Firewall (WAF) inspection.

当向您的域名发起请求时，该请求将通过任播（Anycast）路由抵达最近的接入节点（Point of Presence, PoP），经初步 DDoS 防护后，进入 Vercel 区域节点（Region），接受首次 Web 应用防火墙（WAF）检查。

The request is then enriched in real-time, through _de-aliasing_—the reverse process of mapping the domain to a specific deployment.

随后，请求将通过“去别名化”（_de-aliasing_）——即反向解析域名所指向的具体部署——在实时过程中完成上下文增强。

While traditional WAFs operate blindly, evaluating requests without understanding the app they’re protecting, [Vercel’s WAF](https://vercel.com/security/web-application-firewall) is made application-aware, as it's integrated with all routing metadata associated with a deployment. That means firewall rules can target specific parts of your application, not just raw path or cumbersome regex patterns.

传统 WAF 通常“盲目”运行，在评估请求时并不理解其所保护的应用程序；而 [Vercel 的 WAF](https://vercel.com/security/web-application-firewall) 则具备应用感知能力（application-aware），因为它与部署所关联的所有路由元数据深度集成。这意味着防火墙规则可精准作用于应用程序的特定部分，而不仅限于原始路径（raw path）或繁琐的正则表达式模式。

![Requests flow end-to-end through the Vercel Network—starting at the closest Point of Presence, passing through the Vercel Firewall, CDN, and Functions—with routing decisions applied at each stage.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_009.jpg)![Requests flow end-to-end through the Vercel Network—starting at the closest Point of Presence, passing through the Vercel Firewall, CDN, and Functions—with routing decisions applied at each stage.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_010.jpg)![Requests flow end-to-end through the Vercel Network—starting at the closest Point of Presence, passing through the Vercel Firewall, CDN, and Functions—with routing decisions applied at each stage.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_011.jpg)![Requests flow end-to-end through the Vercel Network—starting at the closest Point of Presence, passing through the Vercel Firewall, CDN, and Functions—with routing decisions applied at each stage.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_012.jpg)Requests flow end-to-end through the Vercel Network—starting at the closest Point of Presence, passing through the Vercel Firewall, CDN, and Functions—with routing decisions applied at each stage.

![请求端到端流经 Vercel 网络——从地理上最近的接入点（Point of Presence）出发，依次经过 Vercel 防火墙、CDN 和 Functions，并在每个阶段应用相应的路由决策。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_009.jpg)![请求端到端流经 Vercel 网络——从地理上最近的接入点（Point of Presence）出发，依次经过 Vercel 防火墙、CDN 和 Functions，并在每个阶段应用相应的路由决策。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_010.jpg)![请求端到端流经 Vercel 网络——从地理上最近的接入点（Point of Presence）出发，依次经过 Vercel 防火墙、CDN 和 Functions，并在每个阶段应用相应的路由决策。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_011.jpg)![请求端到端流经 Vercel 网络——从地理上最近的接入点（Point of Presence）出发，依次经过 Vercel 防火墙、CDN 和 Functions，并在每个阶段应用相应的路由决策。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_012.jpg)请求端到端流经 Vercel 网络——从地理上最近的接入点（Point of Presence）出发，依次经过 Vercel 防火墙、CDN 和 Functions，并在每个阶段应用相应的路由决策。

At this point, and throughout the entire lifecycle of the request, Vercel's routing can return with an early response, serve from cache, or invoke compute. In a dynamic network, the destination isn’t fixed as the gateway decides where to send each request.

在此阶段，以及整个请求生命周期中，Vercel 的路由系统可选择立即返回响应、从缓存提供服务，或触发计算资源执行。在动态网络架构下，目标地址并非固定不变——网关会为每个请求实时决定其转发目的地。

## A platform unlocked by application-aware routing

## 应用感知型路由赋能的平台

Vercel’s gateway provides automatic deployment, routing, and rollout behavior, thanks to the deployment-based approach (quick aliasing and de-aliasing) combined with an instant global propagation pipeline.

得益于基于部署（deployment-based）的方法（支持快速别名绑定与解绑）以及即时全球分发管道（instant global propagation pipeline），Vercel 的网关可自动完成部署、路由与发布行为。

Let’s look at a few examples.

我们来看几个具体示例。

### Instant, global propagation for rollouts and rollbacks

### 发布与回滚：毫秒级全球生效

When you alias a domain to a deployment, which could be an existing deployment we're updating or a brand new one created from a PR a few seconds ago, that alias becomes the active entry point for all traffic to that domain.

当你将某个域名绑定（alias）至一个部署时——该部署可能是正在更新的既有版本，也可能是几秒钟前由 Pull Request 创建的全新部署——该别名即刻成为该域名所有流量的活跃入口点。

![Rollbacks happen instantly by updating the alias to point to a previous deployment. Because routing is handled at the software layer, changes propagate globally within milliseconds—ensuring zero downtime.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_013.jpg)![Rollbacks happen instantly by updating the alias to point to a previous deployment. Because routing is handled at the software layer, changes propagate globally within milliseconds—ensuring zero downtime.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_014.jpg)![Rollbacks happen instantly by updating the alias to point to a previous deployment. Because routing is handled at the software layer, changes propagate globally within milliseconds—ensuring zero downtime.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_015.jpg)![Rollbacks happen instantly by updating the alias to point to a previous deployment. Because routing is handled at the software layer, changes propagate globally within milliseconds—ensuring zero downtime.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_016.jpg)Rollbacks happen instantly by updating the alias to point to a previous deployment. Because routing is handled at the software layer, changes propagate globally within milliseconds—ensuring zero downtime.

![通过更新别名使其指向先前的部署，即可实现瞬时回滚。由于路由逻辑在软件层实现，变更可在毫秒级内完成全球同步——确保零停机时间。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_013.jpg)![通过更新别名使其指向先前的部署，即可实现瞬时回滚。由于路由逻辑在软件层实现，变更可在毫秒级内完成全球同步——确保零停机时间。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_014.jpg)![通过更新别名使其指向先前的部署，即可实现瞬时回滚。由于路由逻辑在软件层实现，变更可在毫秒级内完成全球同步——确保零停机时间。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_015.jpg)![通过更新别名使其指向先前的部署，即可实现瞬时回滚。由于路由逻辑在软件层实现，变更可在毫秒级内完成全球同步——确保零停机时间。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_016.jpg)通过更新别名使其指向先前的部署，即可实现瞬时回滚。由于路由逻辑在软件层实现，变更可在毫秒级内完成全球同步——确保零停机时间。

Switching that alias—mapping to an internal Vercel deployment—happens instantly. There’s no DNS propagation, no warmup time, and no manual steps. The gateway starts routing traffic to the new version immediately. This change is propagated globally so all users requesting your app will hit the latest deployment milliseconds after it goes live.

切换该别名（即将其映射至 Vercel 内部某一部署）的过程瞬时完成：无需等待 DNS 生效、无需预热（warmup）时间、亦无需任何人工干预。网关将立即开始将流量导向新版本。该变更在全球范围内即时同步，因此所有用户在新版本上线后的数毫秒内访问你的应用，即可命中最新部署。

If a deployment or PR needs to be reverted, you can just as quickly re-alias the domain to the previous deployment with [Instant Rollback](https://vercel.com/docs/instant-rollback)—which remains untouched given its immutability—and traffic instantly directs to that deployment in a known good state. Importantly, this keeps the CDN cache intact, and is all done with no rebuild, no redeploy, no scale-down event. Just a global pointer update.

如果某个部署或 Pull Request 需要回滚，您只需借助 [即时回滚（Instant Rollback）](https://vercel.com/docs/instant-rollback) 快速将域名重新指向先前的部署即可——由于部署具有不可变性（immutability），该历史部署本身保持原样未被修改；流量将立即路由至该已知稳定可靠的部署。尤为重要的是，此操作完全保留 CDN 缓存，且无需重建、无需重新部署、也无需缩容。仅需一次全局指针更新。

### Incremental rollouts

### 渐进式发布（增量式灰度发布）

This also enables incremental rollouts of new deployments, often referred to as [blue/green deployments](https://vercel.com/blog/releasing-safe-and-cost-efficient-blue-green-deployments). With all Vercel deployments, you can test a new version using [preview deployments](https://vercel.com/docs/deployments/environments#preview-environment-pre-production) to run health checks, and only promote it to production once it’s ready—all while keeping the previous version one alias change away. Because aliasing is a pointer, you can modify routes to roll out new builds in phases, where there are multiple production environments live at the same time.

这也支持新部署的渐进式发布（常被称为 [蓝绿部署（blue/green deployments）](https://vercel.com/blog/releasing-safe-and-cost-efficient-blue-green-deployments)）。在 Vercel 的所有部署中，您均可通过 [预览部署（preview deployments）](https://vercel.com/docs/deployments/environments#preview-environment-pre-production) 对新版本进行测试并执行健康检查；待其准备就绪后，再将其提升至生产环境——而旧版本始终仅需一次别名（alias）变更即可恢复。由于别名本质上是一个指针，您可通过调整路由策略，分阶段推出新构建版本，从而实现在同一时间运行多个生产环境。

![Deployment-based routing lets you incrementally split traffic between two versions of your codebase for controlled, phased rollouts. In this example, a portion of traffic is gradually shifting to Deployment B.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_017.jpg)![Deployment-based routing lets you incrementally split traffic between two versions of your codebase for controlled, phased rollouts. In this example, a portion of traffic is gradually shifting to Deployment B.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_018.jpg)![Deployment-based routing lets you incrementally split traffic between two versions of your codebase for controlled, phased rollouts. In this example, a portion of traffic is gradually shifting to Deployment B.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_019.jpg)![Deployment-based routing lets you incrementally split traffic between two versions of your codebase for controlled, phased rollouts. In this example, a portion of traffic is gradually shifting to Deployment B.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_020.jpg)Deployment-based routing lets you incrementally split traffic between two versions of your codebase for controlled, phased rollouts. In this example, a portion of traffic is gradually shifting to Deployment B.

![基于部署的路由机制使您能够对代码库的两个版本进行受控、分阶段的流量拆分。本例中，部分流量正逐步迁移至部署 B。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_017.jpg)![基于部署的路由机制使您能够对代码库的两个版本进行受控、分阶段的流量拆分。本例中，部分流量正逐步迁移至部署 B。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_018.jpg)![基于部署的路由机制使您能够对代码库的两个版本进行受控、分阶段的流量拆分。本例中，部分流量正逐步迁移至部署 B。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_019.jpg)![基于部署的路由机制使您能够对代码库的两个版本进行受控、分阶段的流量拆分。本例中，部分流量正逐步迁移至部署 B。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_020.jpg)基于部署的路由机制使您能够对代码库的两个版本进行受控、分阶段的流量拆分。本例中，部分流量正逐步迁移至部署 B。

If there are issues during the incremental rollout of green (new, meant to be fully live deployment), an instant rollback returns the percentage of traffic back to 100% to blue.

若在绿色部署（即新版本、预期全面上线的部署）的渐进式发布过程中出现问题，一次即时回滚即可将全部流量（100%）切回蓝色部署（即旧版本）。

### Skew Protection against version mismatches

### 防倾斜保护（Skew Protection）：防范前后端版本不一致

Ensuring rollouts don’t affect users who are actively using your app can be tricky to manage. Backend logic can get out of sync with frontend code running in user's browsers.

确保发布过程不影响正在使用您应用的用户，往往颇具挑战性。后端逻辑可能与用户浏览器中运行的前端代码不同步。

[Skew Protection](https://vercel.com/docs/skew-protection) helps prevent mismatches between frontends and backends by ensuring a user stays on the same deployment with aliasing pointing to specific deployments. It keeps track of which deployment every user of your app is accessing at any given point and intelligently keeps them in sync.

[防倾斜保护（Skew Protection）](https://vercel.com/docs/skew-protection) 通过确保用户始终停留在同一部署上（即别名明确指向特定部署），来防止前后端版本不匹配。它实时追踪您的应用每位用户当前所访问的部署，并智能地维持其前后端的一致性。

![Version mismatches happen when the frontend and backend come from different deployments. Skew Protection avoids this by routing all requests in a session to the same deployment—ensuring consistency across deploys.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_021.jpg)![Version mismatches happen when the frontend and backend come from different deployments. Skew Protection avoids this by routing all requests in a session to the same deployment—ensuring consistency across deploys.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_022.jpg)![Version mismatches happen when the frontend and backend come from different deployments. Skew Protection avoids this by routing all requests in a session to the same deployment—ensuring consistency across deploys.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_023.jpg)![Version mismatches happen when the frontend and backend come from different deployments. Skew Protection avoids this by routing all requests in a session to the same deployment—ensuring consistency across deploys.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_024.jpg)Version mismatches happen when the frontend and backend come from different deployments. Skew Protection avoids this by routing all requests in a session to the same deployment—ensuring consistency across deploys.

![当前端与后端来自不同部署时，便会发生版本不匹配问题。防倾斜保护通过将同一会话中的所有请求路由至相同部署，避免此类问题——从而保障各次部署间的一致性。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_021.jpg)![当前端与后端来自不同部署时，便会发生版本不匹配问题。防倾斜保护通过将同一会话中的所有请求路由至相同部署，避免此类问题——从而保障各次部署间的一致性。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_022.jpg)![当前端与后端来自不同部署时，便会发生版本不匹配问题。防倾斜保护通过将同一会话中的所有请求路由至相同部署，避免此类问题——从而保障各次部署间的一致性。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_023.jpg)![当前端与后端来自不同部署时，便会发生版本不匹配问题。防倾斜保护通过将同一会话中的所有请求路由至相同部署，避免此类问题——从而保障各次部署间的一致性。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_024.jpg)当前端与后端来自不同部署时，便会发生版本不匹配问题。防倾斜保护通过将同一会话中的所有请求路由至相同部署，避免此类问题——从而保障各次部署间的一致性。

If you deploy a new frontend that depends on changes in the backend, you want to make sure that clients using the new UI aren’t sending requests to an outdated version of the infrastructure. With Vercel’s gateway, de-aliasing solves this. A request that includes a deployment identifier, via a first-party cookie, can bypass the alias entirely and be routed to the exact deployment that originally rendered it.

若您部署了一个依赖后端变更的新版前端，就必须确保使用新版 UI 的客户端不会向过时的基础设施版本发送请求。借助 Vercel 的网关（gateway），“去别名化（de-aliasing）”可解决这一问题：包含部署标识符（通过第一方 Cookie 传递）的请求可完全绕过别名机制，直接路由至最初渲染该页面的确切部署。

Search engines often crawl versioned URLs for weeks after indexing. In most setups, those versions are deleted after new deployments—breaking links and losing traffic. Skew Protection corrects for this, routing outdated crawler requests to the correct version for up to 60 days, keeping pages accessible. [Learn how Vercel manages this for you](https://vercel.com/changelog/automatic-mitigation-of-crawler-delay-via-skew-protection).

搜索引擎通常会在索引后数周内持续抓取带版本号的 URL。在大多数部署配置中，这些旧版本会在新部署后被删除——从而导致链接失效并流失流量。偏移保护（Skew Protection）可纠正这一问题，将过时的爬虫请求路由至正确的版本，最长可达 60 天，确保页面持续可访问。[了解 Vercel 如何为您自动管理此机制](https://vercel.com/changelog/automatic-mitigation-of-crawler-delay-via-skew-protection)。

## A continuous, intelligent reverse proxy

## 持续运行、具备智能的反向代理

The gateway isn’t just deployment-aware—it’s programmable, serving as an intelligent reverse proxy in front of your apps, facilitating almost all routing. With the integrated gateway, routing doesn’t happen once. It happens continuously.

网关不仅感知部署状态，更具备可编程性，作为您应用前端的智能反向代理，支撑几乎全部的路由逻辑。借助集成式网关，路由并非一次性行为，而是持续发生的动态过程。

Throughout the request's lifecycle, the gateway ushers the request through the steps laid out by framework code from the previously mentioned aliasing and de-aliasing and WAF inspection, to programmatic middleware execution and dynamic rewrites. The ushered request is continuously re-evaluated for either continued fulfillment, an early return, or with rewrites that go on yet another path to complete its fulfillment.

在整个请求生命周期中，网关会引导请求依次执行框架代码所定义的各阶段操作：包括前述的别名映射与解映射、Web 应用防火墙（WAF）检查、可编程中间件执行，以及动态重写等。该被引导的请求将持续接受重新评估——或继续完成处理，或提前返回响应，或经由重写进入另一条路径以最终完成其处理流程。

This is all derived from code. Developers shape routing at every stage—before, during, and after inspection—with the logic they've defined and versioned with every immutable snapshot of code. This continuous evaluation isn’t just passive—different decisions can be made on the fly for every request, like with middleware.

所有这些行为均源自代码。开发者可在每个阶段——检查前、检查中与检查后——通过自己定义并随每次不可变代码快照一同版本化的逻辑，塑造路由行为。这种持续评估绝非被动响应；相反，它支持为每个请求实时做出差异化决策，例如通过中间件实现。

### Programmatic routing functions

### 可编程路由函数

[Middleware](https://vercel.com/docs/edge-middleware) runs during routing, giving you full access to the request object (headers, cookies, pathname, and more). This logic executes close to your users and can short-circuit the request, mutate the path, inject headers, or return early responses. Middleware lets you, with very low latency, inject feature flags and A/B experiments, first-line authentication checks for quick returns, geo-based redirection, application-level bot filtering, and session-aware routing.

[中间件（Middleware）](https://vercel.com/docs/edge-middleware) 在路由过程中运行，为您提供对请求对象（包括请求头、Cookie、路径名等）的完全访问权限。该逻辑在靠近用户的位置执行，可中断请求流程、修改路径、注入请求头，或直接返回早期响应。借助中间件，您能以极低延迟实现功能开关（Feature Flags）与 A/B 测试注入、首道身份认证快速拦截、基于地理位置的重定向、应用层机器人过滤，以及会话感知型路由等功能。

![Routing functions and programmable logic—such as middleware, rewrites, and redirects—enable per-request decisions to be made early in the lifecycle of a request.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_025.jpg)![Routing functions and programmable logic—such as middleware, rewrites, and redirects—enable per-request decisions to be made early in the lifecycle of a request.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_026.jpg)![Routing functions and programmable logic—such as middleware, rewrites, and redirects—enable per-request decisions to be made early in the lifecycle of a request.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_027.jpg)![Routing functions and programmable logic—such as middleware, rewrites, and redirects—enable per-request decisions to be made early in the lifecycle of a request.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_028.jpg)Routing functions and programmable logic—such as middleware, rewrites, and redirects—enable per-request decisions to be made early in the lifecycle of a request.

![路由函数与可编程逻辑——例如中间件、重写（rewrites）和重定向（redirects）——支持在请求生命周期的早期即针对每个请求做出决策。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_025.jpg)![路由函数与可编程逻辑——例如中间件、重写（rewrites）和重定向（redirects）——支持在请求生命周期的早期即针对每个请求做出决策。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_026.jpg)![路由函数与可编程逻辑——例如中间件、重写（rewrites）和重定向（redirects）——支持在请求生命周期的早期即针对每个请求做出决策。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_027.jpg)![路由函数与可编程逻辑——例如中间件、重写（rewrites）和重定向（redirects）——支持在请求生命周期的早期即针对每个请求做出决策。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_028.jpg)路由函数与可编程逻辑——例如中间件、重写（rewrites）和重定向（redirects）——支持在请求生命周期的早期即针对每个请求做出决策。

Many routes don’t require dynamic logic. They’re based on predictable patterns or static conditions like pathnames and headers. In these cases, Vercel’s routing layer supports versioned, framework-defined route maps that enable precise control without the need for runtime code execution. This is especially useful when multiple underlying apps serve different parts of the same domain.

许多路由无需动态逻辑，仅依赖可预测的模式或静态条件（如路径名、请求头等）。在此类场景下，Vercel 的路由层支持经版本化管理、由框架定义的路由映射表（route maps），从而在无需运行时代码执行的前提下实现精准控制。当多个底层应用共同服务于同一域名的不同部分时，该能力尤为实用。

### Rewrites and redirects

### 重写（Rewrites）与重定向（Redirects）

Rewrites and redirects are first-class primitives.  
重写（Rewrites）和重定向（Redirects）是一等公民式的路由原语。

Rewrites route a request to a different origin or path—internal or external—without changing the URL users see. This is critical for building systems like microfrontends, where different parts of an app may live in separate deployments.  
重写将请求路由至不同的源站或路径（可以是内部或外部），同时不改变用户浏览器地址栏中显示的 URL。这对于构建微前端（microfrontends）等系统至关重要——在这些系统中，应用的不同部分可能部署在彼此独立的服务上。

![Vercel routing enables a single application to route requests across multiple underlying applications, commonly referred to as microfrontends in web architectures.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_029.jpg)![Vercel routing enables a single application to route requests across multiple underlying applications, commonly referred to as microfrontends in web architectures.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_030.jpg)![Vercel routing enables a single application to route requests across multiple underlying applications, commonly referred to as microfrontends in web architectures.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_031.jpg)![Vercel routing enables a single application to route requests across multiple underlying applications, commonly referred to as microfrontends in web architectures.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_032.jpg)Vercel routing enables a single application to route requests across multiple underlying applications, commonly referred to as microfrontends in web architectures.  
![Vercel 路由使单个应用能够将请求分发至多个底层应用，这种架构在 Web 领域通常被称为“微前端”。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_029.jpg)![Vercel 路由使单个应用能够将请求分发至多个底层应用，这种架构在 Web 领域通常被称为“微前端”。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_030.jpg)![Vercel 路由使单个应用能够将请求分发至多个底层应用，这种架构在 Web 领域通常被称为“微前端”。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_031.jpg)![Vercel 路由使单个应用能够将请求分发至多个底层应用，这种架构在 Web 领域通常被称为“微前端”。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_032.jpg)Vercel 路由使单个应用能够将请求分发至多个底层应用，这种架构在 Web 领域通常被称为“微前端”。

For example, you can rewrite `/blog/[slug]` to a headless CMS or `/dashboard` to an internal service. The routing layer ensures the client stays unaware of these boundaries, preserving a unified app experience. Rewrites can also target fully external URLs while keeping the original route structure intact.  
例如，你可以将 `/blog/[slug]` 重写至一个无头 CMS（headless CMS），或将 `/dashboard` 重写至某个内部服务。路由层确保客户端对这些边界完全无感知，从而维持统一的应用体验。重写甚至可指向完全外部的 URL，同时保持原始路由结构不变。

This allows multi-tenant apps like [Dub](https://dub.co/) and [Mintlify](https://mintlify.com/) to use wildcard subdomains, which allow users to set custom domains easily. This points many different hosts to the same app (which may be backed by many apps and deployments) with centralized routing and minimal complexity.  
这使得 [Dub](https://dub.co/) 和 [Mintlify](https://mintlify.com/) 等多租户应用能够使用通配符子域名（wildcard subdomains），从而让用户轻松配置自定义域名。该机制将大量不同主机名统一指向同一个应用（该应用背后可能由多个子应用及多次部署共同支撑），并通过集中式路由实现极简架构与低运维复杂度。

![Rewrites route requests to different paths behind the scenes, enabling dynamic URLs and custom domains to serve content from shared application infrastructure—ideal for multi-tenant architectures.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_033.jpg)![Rewrites route requests to different paths behind the scenes, enabling dynamic URLs and custom domains to serve content from shared application infrastructure—ideal for multi-tenant architectures.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_034.jpg)![Rewrites route requests to different paths behind the scenes, enabling dynamic URLs and custom domains to serve content from shared application infrastructure—ideal for multi-tenant architectures.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_035.jpg)![Rewrites route requests to different paths behind the scenes, enabling dynamic URLs and custom domains to serve content from shared application infrastructure—ideal for multi-tenant architectures.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_036.jpg)Rewrites route requests to different paths behind the scenes, enabling dynamic URLs and custom domains to serve content from shared application infrastructure—ideal for multi-tenant architectures.  
![重写在后台将请求路由至不同路径，从而支持动态 URL 和自定义域名，使内容可从共享的应用基础设施中交付——这是多租户架构的理想方案。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_033.jpg)![重写在后台将请求路由至不同路径，从而支持动态 URL 和自定义域名，使内容可从共享的应用基础设施中交付——这是多租户架构的理想方案。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_034.jpg)![重写在后台将请求路由至不同路径，从而支持动态 URL 和自定义域名，使内容可从共享的应用基础设施中交付——这是多租户架构的理想方案。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_035.jpg)![重写在后台将请求路由至不同路径，从而支持动态 URL 和自定义域名，使内容可从共享的应用基础设施中交付——这是多租户架构的理想方案。](images/life-of-a-vercel-request-application-aware-routing-vercel/img_036.jpg)重写在后台将请求路由至不同路径，从而支持动态 URL 和自定义域名，使内容可从共享的应用基础设施中交付——这是多租户架构的理想方案。

In contrast, redirects update the browser URL and enforce client-side routing changes. They’re useful when migrating legacy paths, fixing SEO issues, or enforcing canonical URLs.  
相比之下，重定向（redirects）会更新浏览器地址栏中的 URL，并强制触发客户端路由变更。它适用于迁移旧有路径、修复 SEO 问题，或强制使用规范 URL（canonical URLs）等场景。

Both rewrites and redirects can be defined statically in your config or generated dynamically via middleware, and both are fully tied to the active deployment. There’s no global routing config that sits outside the lifecycle of your app. Everything is scoped to your code and versioned along with it.  
重写与重定向既可通过配置文件静态定义，也可通过中间件（middleware）动态生成；且二者均严格绑定于当前活跃部署（active deployment）。不存在脱离应用生命周期的全局路由配置。所有路由规则均作用于你的代码范围内，并随代码一同版本化管理。

## Framework-defined routing  
## 框架定义的路由

The Vercel gateway is an intelligent routing system with full awareness of both provisioned infrastructure and every deployment. What’s needed is shaped by your app’s code, giving users the ability to control real-time routing with programmable logic.  
Vercel 网关是一个智能路由系统，全面感知已配置的基础设施以及每一次部署状态。其所需行为完全由你的应用代码决定，使用户得以借助可编程逻辑实时控制路由行为。

As each framework handles routing differently. Vercel analyzes, infers, and then preserves the routing output of every build to ensure requests are handled according to the framework’s behavior and coded intent. It doesn’t just serve static assets or forward requests. It understands the structure and state of your app. It knows what deployment is active, how requests should be shaped, and what logic should run before a response is served. It gives you control without requiring infrastructure management, and flexibility without sacrificing predictability.  
由于各前端框架处理路由的方式各不相同，Vercel 会对每次构建产物进行分析与推断，精准保留其路由输出，确保请求始终遵循框架自身的行为逻辑与开发者编码意图来处理。它不只是简单地提供静态资源或转发请求；它真正理解你应用的结构与运行时状态：它知道当前哪个部署处于活跃状态、请求应如何被转换与修饰、以及在响应返回前应执行哪些逻辑。它赋予你强大控制力，却无需你操心底层基础设施管理；它提供高度灵活性，又不以牺牲可预测性为代价。

Routing is more than matching paths to handlers. On Vercel, it’s a dynamic process that spans deployments, domains, and logic—without drift or downtime. The gateway is where traffic is understood, where code paths are chosen, and where infrastructure becomes part of your app's runtime behavior.

路由远不止将路径匹配到处理器那么简单。在 Vercel 上，路由是一个动态过程，贯穿部署、域名和业务逻辑——全程无偏差、零停机。网关是流量被理解的地方，是代码路径被选定的地方，也是基础设施融入应用运行时行为的地方。

[**Try application-aware routing**  
**尝试应用感知型路由**

Start with Vercel to deploy and scale your app with automated, application-aware routing—right from your framework code.  
从 Vercel 开始，借助自动化、应用感知型路由来部署和扩展您的应用——直接通过您的框架代码即可实现。

Deploy now](https://vercel.com/new)  
立即部署](https://vercel.com/new)