---
title: "Releasing safe and cost-efficient blue-green deployments - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/releasing-safe-and-cost-efficient-blue-green-deployments"
date: "2024-04-12"
scraped_at: "2026-03-02T09:45:48.057828667+00:00"
language: "en-zh"
translated: true
description: "Learn how Vercel's platform primitives enable safe and scalable blue-green deployments that mitigate the risks of rolling out new software versions."
---
{% raw %}

Apr 12, 2024

2024年4月12日

Blue-green deployments are a great way to mitigate the risks associated with rolling out new software versions.

蓝绿部署是降低新软件版本发布风险的一种极佳方式。

This methodology allows for incremental exposure of users to new deployments, providing an opportunity to detect and address issues early on, and to revert changes if necessary before a majority of users are affected.

该方法支持逐步将用户流量切换至新版本，从而及早发现并解决问题；若有必要，还可于大多数用户受到影响前快速回滚变更。

Traditionally, implementing blue-green deployments, especially in environments utilizing Kubernetes (K8s) clusters, introduces two primary challenges:

传统上，在使用 Kubernetes（K8s）集群的环境中实施蓝绿部署，主要面临两大挑战：

1. **Architectural gaps:** Components upstream of the K8s cluster, like the content delivery network (CDN), may not seamlessly integrate with the blue-green rollout process. This lack of awareness can lead to discrepancies in user experience and potential errors.

1. **架构断层：** 位于 K8s 集群上游的组件（例如内容分发网络 CDN）可能无法与蓝绿发布流程无缝集成。这种“感知缺失”可能导致用户体验不一致，甚至引发潜在错误。

2. **Infrastructure overhead:** Maintaining duplicate infrastructure for the sake of redundancy leads to increased infrastructure costs, which may not be justifiable or sustainable for all organizations.

2. **基础设施开销：** 为实现冗余而维护两套并行基础设施，将显著增加基础设施成本，这对许多组织而言既缺乏合理性，也难以长期维系。

Leveraging Vercel for deploying blue-green deployments offers solutions to these challenges, enhancing both the architectural cohesion and the cost efficiency of such deployment strategies.

借助 Vercel 实施蓝绿部署，可有效应对上述挑战，从而提升部署方案的整体架构一致性与成本效益。

### **What are blue-green deployments?**

### **什么是蓝绿部署？**

The blue-green deployment strategy means you serve two versions of your application: "Blue" and "Green." You serve the current version of your application (Blue), and then you can deploy a different version of your application (Green) without affecting the Blue environment.

蓝绿部署策略指同时运行应用的两个独立版本：“蓝色（Blue）”和“绿色（Green）”。当前生产环境运行的是蓝色版本；在此基础上，您可安全部署绿色版本，且完全不会影响蓝色环境的正常服务。

![Blue-green deployments incrementally expose users to a new software version.](images/releasing-safe-and-cost-efficient-blue-green-deployments-vercel/img_001.jpg)![Blue-green deployments incrementally expose users to a new software version.](images/releasing-safe-and-cost-efficient-blue-green-deployments-vercel/img_002.jpg)

Blue-green deployments incrementally expose users to a new software version.

蓝绿部署以渐进方式将用户暴露给新软件版本。

This keeps your Blue application running seamlessly for production users while you test and deploy your Green application. When you're ready to serve users your Green application, you can incrementally or fully switch to your new Green application with no perceptible change for your users.

这使得您的“蓝色”应用能持续无缝地为生产用户提供服务，同时您可对“绿色”应用进行测试与部署。当您准备向用户正式发布“绿色”应用时，即可通过渐进式或一次性切换的方式，将流量完全迁移至新的“绿色”应用——整个过程对用户而言毫无感知。

At their core, blue-green deployments facilitate the gradual exposure of new software versions to users. Ideally, if the new version operates identically to the old one, the deployment proceeds without issues. The decision to fully transition to the new version is typically informed by observability (o11y) data, which can be interpreted either manually by developers or automatically through anomaly detection systems.

本质上，蓝绿部署旨在实现新软件版本向用户的渐进式交付。理想情况下，若新版本的行为与旧版本完全一致，则部署过程将顺利无阻。是否全面切换至新版本，通常取决于可观测性（o11y）数据——这些数据既可由开发人员人工分析，也可借助异常检测系统自动识别并响应。

### Why roll with blue-green deployments?

### 为何选择蓝绿部署？

The benefits of blue-green deployments are significant, including:

蓝绿部署的优势十分显著，包括：

- **Risk reduction**: Minimizes the potential negative impacts of new software rollouts.

- **风险降低**：最大限度减少新软件上线可能带来的负面影响。

- **Limited exposure**: Any issues affect only a small subset of users.

- **有限影响范围**：任何问题仅波及一小部分用户。

- **Rapid reversion**: Problematic changes can be rolled back quickly before widespread user exposure.

- **快速回滚**：可在问题大规模影响用户前，迅速将有缺陷的变更回退。

- **Cache optimization**: Allows for the prepopulation of caches with new data, ensuring smoother performance upon broader release.

- **缓存优化**：支持预先用新数据填充缓存，从而保障后续大规模发布时更流畅的性能表现。

## Using Rolling Releases

## 使用滚动发布

[Rolling Releases](https://vercel.com/docs/rolling-releases) is a Vercel feature for creating exactly this sort of release safety. In just a few clicks, you can set up multi-stage deployments that advance automatically or manually. Additionally, you can use data from Vercel Observability or external sources to verify the new deployment's acceptability.

[滚动发布（Rolling Releases）](https://vercel.com/docs/rolling-releases) 是 Vercel 提供的一项功能，专为实现此类发布安全性而设计。仅需数次点击，您即可配置多阶段部署，这些部署可自动或手动推进。此外，您还可利用 Vercel 可观测性（Vercel Observability）数据或外部来源的数据，验证新部署是否符合预期标准。

![](images/releasing-safe-and-cost-efficient-blue-green-deployments-vercel/img_003.jpg)![](images/releasing-safe-and-cost-efficient-blue-green-deployments-vercel/img_004.jpg)

## Creating safe rollouts on Vercel

## 在 Vercel 上构建安全的渐进式发布

Vercel enhances blue-green deployments through the integration of three core platform primitives:

Vercel 通过集成三大核心平台原语，增强了蓝绿部署能力：

1. [**Skew Protection**](https://vercel.com/blog/version-skew-protection): Ensures consistent user exposure to only one software version at a time, preventing erratic behavior from version toggling.

1. [**版本偏移保护（Skew Protection）**](https://vercel.com/blog/version-skew-protection)：确保用户在同一时间仅接触单一软件版本，避免因版本切换导致行为异常。

2. [**Edge Config**](https://vercel.com/docs/storage/edge-config): Facilitates the configuration of deployments at Vercel’s edge, dictating which versions are active and their respective user traffic allocations.

2. [**边缘配置（Edge Config）**](https://vercel.com/docs/storage/edge-config)：支持在 Vercel 边缘节点上配置部署，明确指定哪些版本处于激活状态，以及各自承接的用户流量比例。

3. [**Middleware**](https://vercel.com/docs/functions/edge-middleware): Acts as a dynamic routing layer, enabling comprehensive control over deployment rollouts and selection processes.

3. [**中间件（Middleware）**](https://vercel.com/docs/functions/edge-middleware)：作为动态路由层，提供对部署发布节奏与版本选择流程的全面控制。

This system fundamentally relies on middleware to route user requests to the appropriate deployment, as determined by Edge Config, with Skew Protection guaranteeing a consistent end user experience.

该系统本质上依赖中间件，根据 Edge Config 的配置将用户请求路由至相应部署；同时，Skew Protection 确保终端用户获得一致的体验。

### **Leveraging serverless for scalable deployments**

### **借助无服务器架构实现可扩展部署**

The financial implications of maintaining multiple parallel deployments are a significant consideration for organizations looking to implement blue-green or other phased deployment strategies. Traditional architectures often require duplicating a considerable portion of the infrastructure to support these strategies, leading to increased costs in terms of both resources and management overhead.

对于计划实施蓝绿部署或其他分阶段发布策略的企业而言，维持多个并行部署所带来的财务影响是一个关键考量因素。传统架构通常需要复制大量基础设施以支撑此类策略，从而显著增加资源投入与运维管理成本。

Vercel's platform fundamentally changes this equation through its use of immutable deployments and a serverless architecture. This approach allows for the creation and management of multiple deployments simultaneously without the need to replicate the underlying infrastructure. Each deployment is treated as an immutable snapshot, which can be served to users based on the configured deployment strategy.

Vercel 平台通过采用不可变部署（immutable deployments）和无服务器架构（serverless architecture），从根本上改变了这一权衡关系。该方法支持同时创建和管理多个部署，而无需复制底层基础设施。每个部署均被视为一个不可变的快照，可根据配置的部署策略向用户提供服务。

This model has several key advantages:

该模型具备以下几项关键优势：

- **Reduced overhead**: The serverless nature of Vercel's platform eliminates the need for provisioning or managing servers, reducing administrative overhead and complexity.

- **降低运维开销**：Vercel 平台的无服务器特性消除了对服务器进行预置或管理的需求，从而显著降低了运维负担与系统复杂度。

- **Scalability**: Vercel's infrastructure automatically scales to meet demand, ensuring that deployments remain performant and responsive regardless of the number of versions being served or the volume of traffic.

- **可扩展性**：Vercel 的基础设施能够根据实际需求自动扩缩容，确保无论同时提供多少个版本的服务，抑或面对多大的流量压力，各部署始终维持高性能与高响应性。

- **Cost effectiveness**: Since resources are consumed on a per-request basis, and there's no need to maintain idle infrastructure, the costs associated with running multiple deployments are significantly reduced. This makes sophisticated deployment strategies like blue-green accessible even to smaller teams and organizations with limited budgets.

- **成本效益高**：由于资源按请求计费，且无需维护空闲基础设施，运行多个部署所产生的成本大幅降低。这使得蓝绿部署等高级部署策略，即使是预算有限的小型团队或组织也能轻松采用。

### **Even more innovative rollout strategies**

### **更富创新性的发布策略**

Vercel’s middleware not only offers granular control over deployments, but also supports innovative deployment strategies:

Vercel 的中间件不仅为部署提供了细粒度的控制能力，还支持多种创新型部署策略：

- **Multicolor deployments**: Beyond just blue and green, deployments can introduce additional "colors" or versions for specific user groups, like internal testing by employees.

- **多色部署（Multicolor deployments）**：突破传统“蓝/绿”二元划分，部署可引入更多“颜色”或版本，面向特定用户群体（例如供员工进行内部测试）。

- **Shadow rollouts**: Traffic is officially served to one deployment while being simultaneously routed to another in the background. This approach enables error detection and cache priming with minimal user impact.

- **影子发布（Shadow rollouts）**：流量正式由某一部署对外提供服务，同时在后台静默路由至另一部署。该方式可在几乎不影响用户体验的前提下，实现错误检测与缓存预热。

By harnessing Vercel’s cutting-edge technology and platform capabilities, organizations can implement more sophisticated, efficient, and secure blue-green deployment strategies, setting a new standard for software rollout methodologies.

借助 Vercel 先进的技术与平台能力，企业可实施更复杂、更高效、更安全的蓝绿部署策略，从而为软件发布方法论树立全新标杆。

[**Blue-green deployments on Vercel**  
**在 Vercel 上实现蓝绿部署**

See how Vercel's Skew Protection feature enables production-ready blue-green deployments with just a few lines of code.  
了解 Vercel 的 Skew Protection 功能如何仅需几行代码即可实现面向生产的蓝绿部署。

[Get Started Now](https://vercel.com/templates/next.js/blue-green-deployments-vercel)  
[立即开始](https://vercel.com/templates/next.js/blue-green-deployments-vercel)
{% endraw %}
