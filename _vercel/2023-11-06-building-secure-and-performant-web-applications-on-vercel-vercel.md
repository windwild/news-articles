---
title: "Building secure and performant web applications on Vercel - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/building-secure-and-performant-web-applications-on-vercel"
date: "2023-11-06"
scraped_at: "2026-03-02T09:49:52.034985050+00:00"
language: "en-zh"
translated: true
description: "Vercel's Frontend Cloud offers support for deploying complex and dynamic web applications with managed infrastructure so you have control and flexibility without having to worry about configuration an..."
---

render_with_liquid: false
Nov 6, 2023

2023 年 11 月 6 日

Vercel's Frontend Cloud: Tools for building and scaling powerful web apps with zero infrastructure overhead.

Vercel 前端云：构建与扩展强大 Web 应用的工具集，零基础设施运维负担。

Web Apps are the ultimate dynamic use-case on the Web. As opposed to web _sites_, web _apps_ typically require or facilitate user-to-data interactions. Applications like customer-facing dashboards, support portals, internal employee apps, and much more require up-to-date, personalized information delivered in a performant and secure way.

Web 应用是 Web 上最具动态性的使用场景。与静态的 Web 网站（web _sites_）不同，Web 应用（web _apps_）通常需要或支持用户与数据之间的交互。面向客户的仪表盘、客户支持门户、企业内部员工应用等各类应用，均需以高性能、高安全性的方式，实时交付个性化信息。

Vercel's Frontend Cloud offers support for deploying complex and dynamic web applications with managed infrastructure so you have control and flexibility without having to worry about configuration and maintenance—and yes, this means _everything_ required to serve your App.

Vercel 前端云提供托管式基础设施，支持复杂且动态的 Web 应用部署，让您在无需操心配置与运维的前提下，依然保有充分的控制权与灵活性——是的，这涵盖了运行您的应用所需的 _全部_ 组件。

![Vercel's Frontend Cloud is a suite of cloud-native tools—like global infrastructure and caching, observability, and workflow tooling—designed to help companies and developers deliver the best web experience for their users. ](images/building-secure-and-performant-web-applications-on-vercel-vercel/img_001.jpg)![Vercel's Frontend Cloud is a suite of cloud-native tools—like global infrastructure and caching, observability, and workflow tooling—designed to help companies and developers deliver the best web experience for their users. ](images/building-secure-and-performant-web-applications-on-vercel-vercel/img_002.jpg)Vercel's Frontend Cloud is a suite of cloud-native tools—like global infrastructure and caching, observability, and workflow tooling—designed to help companies and developers deliver the best web experience for their users.

![Vercel 前端云是一套云原生工具集——包括全球基础设施与缓存、可观测性（observability）以及工作流（workflow）工具——旨在助力企业与开发者为其用户提供最佳的 Web 体验。](images/building-secure-and-performant-web-applications-on-vercel-vercel/img_001.jpg)![Vercel 前端云是一套云原生工具集——包括全球基础设施与缓存、可观测性（observability）以及工作流（workflow）工具——旨在助力企业与开发者为其用户提供最佳的 Web 体验。](images/building-secure-and-performant-web-applications-on-vercel-vercel/img_002.jpg)Vercel 前端云是一套云原生工具集——包括全球基础设施与缓存、可观测性（observability）以及工作流（workflow）工具——旨在助力企业与开发者为其用户提供最佳的 Web 体验。

### Vercel's workflow for collaboration and iteration

### Vercel 的协作与迭代工作流

**Remove pipeline dependencies**

**消除流水线依赖**

The deployment workflow is crucial for iterating quickly. By removing dependencies and injecting collaboration into the workflow sooner, you can get feedback, finish reviews, and ship higher-quality features faster.

部署工作流对快速迭代至关重要。通过消除依赖项，并更早地将协作机制嵌入工作流，您能更快获得反馈、完成代码评审，并更高效地上线高质量功能。

Product teams are often bogged down by the turnaround times and infrastructure overhead of staging and QA workflows. With Vercel, instead of a single staging environment for a grouped set of changes, Vercel gives _every_ PR its own, fully operational, environment in seconds. When you commit changes to your project on Vercel, you’ll automatically get an updated [Preview Deployment](https://vercel.com/docs/deployments/preview-deployments) where you and your wider team can review and leave [comments](https://vercel.com/docs/workflow-collaboration/comments) directly on UI.

产品团队常因预发布（staging）与质量保障（QA）流程中的响应延迟和基础设施开销而步履维艰。借助 Vercel，您不再需要为一组变更共用一个预发布环境；相反，Vercel 会在数秒内为 _每一个_ Pull Request 创建专属、完全可运行的环境。当您向 Vercel 项目提交变更后，系统将自动生成更新后的 [预览部署（Preview Deployment）](https://vercel.com/docs/deployments/preview-deployments)，您及整个团队均可直接在 UI 界面上进行评审，并留下 [评论（comments）](https://vercel.com/docs/workflow-collaboration/comments)。

[**Preview and review on Vercel**\\
\\
Learn how to preview changes to your app in a live deployment without merging those changes to production.\\
\\
Learn more](https://vercel.com/docs/deployments/preview-deployments)

[**在 Vercel 上预览与评审**\\
\\
了解如何在不将变更合并至生产环境的前提下，在真实部署环境中预览应用改动。\\
\\
了解更多](https://vercel.com/docs/deployments/preview-deployments)

**Allow for quick UI changes**

**支持快速的 UI 更改**

One of the strengths of an iterative workflow is the ability to ship smaller, more frequent updates. This approach is often more manageable than making large, sweeping changes, and it also reduces the risk of introducing new bugs or issues. Managing both your marketing sites and your application in the same codebase, while decoupling from backends, allows for quick and efficient updates on the frontend UI— _including_ the compute needed to run it—without waiting for or impacting backend application logic. This not only streamlines the process but also empowers your team to make changes and improvements at a faster pace, further enhancing the overall productivity.

迭代式工作流的一大优势在于能够发布更小、更频繁的更新。相比大规模、整体性的变更，这种做法通常更易管理，同时也能显著降低引入新缺陷或问题的风险。在统一代码库中同时管理营销网站与应用程序，并与后端解耦，即可实现前端 UI 的快速高效更新——包括运行 UI 所需的计算资源——而无需等待或影响后端应用逻辑。这不仅简化了开发流程，还赋能团队以更快节奏进行修改与优化，从而进一步提升整体开发效率。

**Decouple deploys from releases**

**将部署与发布解耦**

A crucial piece of an iterative workflow is the ability to decouple the release of new features from their deployment—so the team can continuously ship while holding back a public release. Capabilities like [Edge Middleware](https://vercel.com/docs/functions/edge-middleware) allow developers to roll out new features, conduct A/B testing, and make changes based on user location or other factors, all without a full redeployment. This decoupling of release from deploy provides increased flexibility, speed, and control, enabling a truly iterative workflow. Moreover, these experimentation environments remain perfectly synchronized with your production codebase, ensuring a seamless and risk-free development journey.

迭代式工作流的关键一环，是将新功能的“发布”（release）与其“部署”（deploy）解耦——使团队可持续交付变更，同时按需延迟面向公众的正式上线。诸如 [Edge Middleware](https://vercel.com/docs/functions/edge-middleware) 等能力，让开发者能够在不执行完整重新部署的前提下，渐进式上线新功能、开展 A/B 测试，并依据用户地理位置或其他条件动态调整行为。这种“发布—部署”解耦机制，显著提升了灵活性、响应速度与管控能力，真正实现了迭代式开发闭环。此外，这些实验性环境始终与生产代码库保持完全同步，确保开发过程顺畅无阻、零风险。

![](images/building-secure-and-performant-web-applications-on-vercel-vercel/img_003.jpg)![](images/building-secure-and-performant-web-applications-on-vercel-vercel/img_004.jpg)

### Seamless API and Database Integrations

### 无缝的 API 与数据库集成

When starting development, Vercel makes it easy to integrate with various APIs and databases. You’ll find support for a wide range of databases, allowing teams to stay flexible in development workflows and extend the functionality of web applications:

在启动开发时，Vercel 让集成各类 API 和数据库变得轻而易举。平台原生支持多种主流数据库，使团队可在开发流程中保持高度灵活性，并轻松扩展 Web 应用的功能：

- [MySQL](https://vercel.com/templates/next.js/admin-dashboard-tailwind-planetscale-react-nextjs)

- [MySQL](https://vercel.com/templates/next.js/admin-dashboard-tailwind-planetscale-react-nextjs)

- [Postgres](https://vercel.com/templates/next.js/platforms-starter-kit)

- [PostgreSQL](https://vercel.com/templates/next.js/platforms-starter-kit)

- [MongoDB](https://vercel.com/templates/next.js/mongo-db-starter)

- [MongoDB](https://vercel.com/templates/next.js/mongo-db-starter)

- [Redis](https://vercel.com/templates/next.js/virtual-event-starter-kit)

- [Redis](https://vercel.com/templates/next.js/virtual-event-starter-kit)

On Vercel, you can plug and play with virtually any service you need. Additionally, you can change a downstream provider as fast as changing an environment variable or API key.

在 Vercel 上，您可以即插即用地接入几乎任何所需服务。此外，您还可以像修改环境变量或 API 密钥一样快速切换下游服务提供商。

[**Data Fetching with Next.js**\\
\\
Learn how React Server Components make data fetching \*even easier\* in Next.js 14\\
\\
Learn More](https://vercel.com/blog/understanding-react-server-components)

[**使用 Next.js 进行数据获取**\\
\\
了解 React 服务端组件如何让 Next.js 14 中的数据获取变得\*更加轻松\*\\
\\
了解更多](https://vercel.com/blog/understanding-react-server-components)

### Keep application and customer data secure

### 保障应用与客户数据安全

Your web apps require security at every step. Vercel makes it easy to manage authentication and ensure that your connections stay secure and your customer data always stays private.

您的 Web 应用在每个环节都需要安全保障。Vercel 让身份认证管理变得轻而易举，确保连接安全可靠，客户数据始终私密受控。

Vercel offers a robust authentication system that allows developers to manage user authentication and access control for their web applications. You can integrate with [third-party](https://vercel.com/docs/security/saml) services, including Okta, AWS Cognito, and Google Sign-In to ensure that your team can easily integrate with popular identity providers, making it easier for end-users to access their applications.

Vercel 提供了一套健壮的身份认证系统，使开发者能够统一管理其 Web 应用的用户身份验证与访问控制。您可集成 [第三方](https://vercel.com/docs/security/saml) 服务（如 Okta、AWS Cognito 和 Google 登录），从而让团队便捷对接主流身份提供商，显著提升终端用户访问应用的体验。

[**Application Authentication on Vercel**\\
\\
Understand what's possible when adding authentication to your serverless applications. \\
\\
Learn more](https://vercel.com/guides/application-authentication-on-vercel)

[**Vercel 上的应用身份认证**\\
\\
了解为无服务器应用添加身份认证后所能实现的功能。\\
\\
了解更多](https://vercel.com/guides/application-authentication-on-vercel)

Vercel also provides an API gateway that enables developers to securely expose their APIs to external services. This gateway comes with features like rate limiting, authentication, and SSL encryption, ensuring that APIs are protected from unauthorized access.

Vercel 还提供 API 网关，助力开发者安全地将 API 暴露给外部服务。该网关内置限流、身份认证和 SSL 加密等功能，全面防范未授权访问，切实保障 API 安全。

Finally, with Secure Compute you can create private connections between [Serverless Functions](https://vercel.com/docs/functions/serverless-functions) and your backend cloud, such as databases and other private infrastructure. This let’s Enterprise customers stay secure and compliant, when you may not be permitted to publicly expose your backend cloud.

最后，借助 Secure Compute（安全计算），您可在 [无服务器函数](https://vercel.com/docs/functions/serverless-functions) 与后端云环境（例如数据库及其他私有基础设施）之间建立私有连接。当您的企业客户因合规要求无法将后端云环境公开暴露时，这一能力可助其持续满足安全与合规标准。

### Vercel’s powerful compute

### Vercel 强大的计算能力

Vercel provides best-in-class serverless architecture, allowing developers to build and deploy applications with ease. This means you don't have to worry about provisioning, scaling, or managing servers, allowing you to focus on writing code and delivering features, while Vercel handles the underlying infrastructure.

Vercel 提供业界领先的无服务器（serverless）架构，让开发者能够轻松构建和部署应用程序。这意味着您无需操心服务器的配置、扩缩容或运维管理，从而可以专注于编写代码与交付功能，而底层基础设施则由 Vercel 全权负责。

With a highly scalable compute platform that allows you to run your web applications without worrying about capacity planning or scaling. Your applications automatically scale based on traffic, ensuring that they can handle sudden spikes in traffic without downtime. Additionally, Vercel's compute platform supports a range of runtimes, including Node.js, Python, Ruby, and Java, making it easy to deploy and run web applications built with various technologies.

Vercel 拥有高度可扩展的计算平台，让您无需担忧容量规划或手动扩缩容，即可顺畅运行 Web 应用程序。您的应用会根据实际流量自动伸缩，确保在突发高流量场景下依然稳定可用、零宕机。此外，Vercel 的计算平台支持多种运行时环境，包括 Node.js、Python、Ruby 和 Java，使您能便捷地部署和运行采用不同技术栈构建的 Web 应用。

[**Compute on Vercel**\\
\\
Learn more about the essential operations needed to turn your code into a app that appears for your users. \\
\\
Learn more](https://vercel.com/docs/infrastructure/compute)

[**Vercel 上的计算服务（Compute）**\\
\\
了解将您的代码转化为用户可见应用所需的关键操作。\\
\\
了解更多](https://vercel.com/docs/infrastructure/compute)

### Monitoring on Vercel

### Vercel 上的监控（Monitoring）

Finally, when it comes to web applications, it can be difficult to figure out why certain pieces in a complex system aren’t working. This can lead to searching for issues and errors for hours across multiple tools.

最后，在 Web 应用开发中，当一个复杂系统中的某些组件出现异常时，往往难以快速定位根本原因。这可能导致您耗费数小时，在多个工具之间反复排查问题与错误。

Vercel provides built-in monitoring capabilities that enable you to track the performance and health of your web applications in real-time. With detailed analytics and insights, allowing you to identify and resolve issues quickly, you can ensure optimal performance and minimum downtime.

Vercel 提供内置的监控能力，助您实时追踪 Web 应用的性能表现与健康状态。借助详尽的分析数据与洞察信息，您可以快速识别并解决各类问题，从而保障应用始终处于最佳性能水平，并最大限度减少宕机时间。

![](images/building-secure-and-performant-web-applications-on-vercel-vercel/img_005.jpg)![](images/building-secure-and-performant-web-applications-on-vercel-vercel/img_006.jpg)

![](images/building-secure-and-performant-web-applications-on-vercel-vercel/img_005.jpg)![](images/building-secure-and-performant-web-applications-on-vercel-vercel/img_006.jpg)

Your team can monitor application CPU usage, memory usage, request and response headers, and more. This helps developers identify bottlenecks, solve issues fast, avoid downtime, and overall optimize applications for better performance.

您的团队可实时监控应用的 CPU 使用率、内存占用、请求与响应头等关键指标。这有助于开发者精准识别性能瓶颈、快速解决问题、规避宕机风险，并全面提升应用性能。

[**Monitoring on Vercel**\\
\\
Learn how to query and visualize your Vercel usage, traffic, and more with Monitoring.\\
\\
Learn more](https://vercel.com/docs/observability/monitoring)

[**Vercel 上的监控（Monitoring）**\\
\\
了解如何通过 Monitoring 查询并可视化您的 Vercel 使用量、流量等各项指标。\\
\\
了解更多](https://vercel.com/docs/observability/monitoring)

To use in tandem with Monitoring, Vercel also provides [Instant Rollbacks](https://vercel.com/docs/deployments/instant-rollback) as a way to quickly revert to a previous production deployment. This can be useful in situations that require a swift recovery from production incidents, like breaking changes or bugs.

为与 Monitoring 协同使用，Vercel 还提供 [即时回滚（Instant Rollbacks）](https://vercel.com/docs/deployments/instant-rollback) 功能，支持您快速回退至前一个生产环境部署版本。该功能在需要紧急恢复生产事故（例如破坏性变更或严重 Bug）时尤为实用。

## Move fast with a modern web application stack

## 借助现代化 Web 应用技术栈快速迭代

A secure and performant web app experience can be your competitive differentiation.

安全、高性能的 Web 应用体验，可成为您区别于竞争对手的关键优势。

With Vercel, you get peak scalability and reliability, enhanced developer productivity, and exceptional performance for web applications of all sizes and complexities. And the best part, you don’t have to migrate all at once, Vercel makes it easy to incrementally migrate when you’re ready.

借助 Vercel，您将获得极致的可扩展性与可靠性、更高的开发者生产力，以及面向各种规模与复杂度 Web 应用的卓越性能。最棒的是——您无需一次性完成全部迁移；当您准备就绪时，Vercel 可轻松支持渐进式迁移。

[**Talk to a web app building expert**  
**与 Web 应用构建专家交流**  

Meet with a web app expert and see how your business can build better applications for your users.  
与 Web 应用专家面对面交流，了解您的企业如何为用户打造更优质的 Web 应用。  

Let's Talk  
立即沟通](https://vercel.com/contact)