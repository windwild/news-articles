---
title: "Behind the scenes of Vercel's infrastructure: Achieving optimal scalability and performance - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/behind-the-scenes-of-vercels-infrastructure"
date: "2023-01-27"
scraped_at: "2026-03-02T09:55:53.756430043+00:00"
language: "en-zh"
translated: true
description: "Learn how Vercel builds, deploys, and scales serverless applications with speed and global reliability"
---
&#123;% raw %}

Jan 27, 2023

2023 年 1 月 27 日

了解 Vercel 如何构建与部署无服务器应用。

Vercel 的平台提供了极致的速度、高可靠性，以及无需自行搭建和维护基础设施的便捷性。但当我们把项目部署到 Vercel 时，其背后究竟发生了什么？当你向该平台上的某个网站发起请求时，又会发生什么？

本文将深入幕后，详细解析 Vercel 如何构建与部署无服务器应用，以实现极致的可扩展性、高性能以及快速迭代能力。

## 构建与部署任意框架

部署始于您使用 Vercel 支持的 35 种以上框架之一编写的代码，或通过 [构建输出 API（Build Output API）](https://vercel.com/blog/build-output-api) 进行部署。您既可通过 Vercel CLI 创建部署，也可直接将代码推送到您的 Git 仓库。[Vercel 的 Git 集成](https://vercel.com/docs/concepts/git) 会自动监听您的提交，并触发一次新的部署。

由 CLI 触发的部署流程起始于两次 API 请求：

### 1. 上传项目文件

发起一个 `POST` 请求，其中包含待上传的项目文件，目标是发送至一个具备高可扩展性、高安全性及极高持久性的数据存储服务¹。

### 2. 创建部署

Once the files have been uploaded successfully to the storage service, another `POST` request is made to start the build and deployment process.

文件成功上传至存储服务后，系统会发起另一个 `POST` 请求，以启动构建与部署流程。

Before the deployment can be created, Vercel first authenticates the user and inspects the request to confirm its authenticity and the user's permission to create the deployment to protect against unauthorized access and loss of integrity. It also validates the Vercel configuration in the `vercel.json` file.

在创建部署之前，Vercel 首先对用户进行身份验证，并检查请求内容，以确认其真实性及用户是否具备创建该部署的权限，从而防范未授权访问和数据完整性受损。同时，Vercel 还会校验项目根目录下 `vercel.json` 文件中的配置。

![Request flow from CLI to static storage and API endpoint](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_001.jpg)![Request flow from CLI to static storage and API endpoint](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_002.jpg)![Request flow from CLI to static storage and API endpoint](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_001.jpg)![Request flow from CLI to static storage and API endpoint](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_002.jpg)Request flow from CLI to static storage and API endpoint

![CLI 到静态存储与 API 端点的请求流程图](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_001.jpg)![CLI 到静态存储与 API 端点的请求流程图](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_002.jpg)![CLI 到静态存储与 API 端点的请求流程图](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_001.jpg)![CLI 到静态存储与 API 端点的请求流程图](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_002.jpg)CLI 到静态存储与 API 端点的请求流程

If everything checks out, the deployment gets scheduled for building². Vercel's build container³ is able to start the build process immediately, provided there is sufficient build concurrency available based on the project's [billing plan](https://vercel.com/docs/concepts/deployments/concurrent-builds#). Hobby teams have 1 concurrent build, Pro teams can purchase up to 12, and Enterprise teams can purchase a custom amount of build slots for maximum concurrency.

若所有校验均通过，该部署将被安排进入构建队列²。只要项目所属的[计费方案](https://vercel.com/docs/concepts/deployments/concurrent-builds#)所允许的并发构建数仍有余量，Vercel 的构建容器³ 即可立即启动构建流程。其中，Hobby（入门）团队支持 1 个并发构建；Pro（专业）团队最多可购买 12 个；而 Enterprise（企业）团队则可根据需求定制购买任意数量的构建插槽，以实现最高并发能力。

The build step transforms the project into a Vercel deployment by executing a "builder" on the source code. The builder can be an internal one provided by Vercel, or a custom builder that requires installation from an npm registry. Vercel's build system is configured to automatically detect over 35 frontend frameworks or to recognize a prebuilt project that adheres to the [Build Output API](https://vercel.com/docs/build-output-api/v3)'s spec. This API allows you to create a build output that is compatible with Vercel's deployment platform and enables you to utilize all of the platform's features.

构建步骤通过对源代码执行一个“构建器（builder）”来将项目转换为 Vercel 部署。该构建器可以是 Vercel 内置提供的，也可以是从 npm 仓库安装的自定义构建器。Vercel 的构建系统已预设为可自动识别超过 35 种前端框架，或识别符合 [Build Output API](https://vercel.com/docs/build-output-api/v3) 规范的预构建项目。该 API 使您能够生成与 Vercel 部署平台兼容的构建产物，并全面启用平台的所有功能。

While the build container is processing the files, it pings an API endpoint that keeps track of the deployment’s status. The CLI and dashboard use this endpoint to display the correct status to the user.

在构建容器处理文件期间，它会持续轮询一个用于追踪部署状态的 API 端点。CLI 工具与控制台仪表板均通过该端点向用户实时展示准确的部署状态。

The build container creates a build output that runs on one of Vercel's [supported runtimes](https://vercel.com/docs/concepts/functions/serverless-functions/runtimes#), and provisions resources such as:

构建容器生成的构建产物将在 Vercel 所支持的[运行时环境](https://vercel.com/docs/concepts/functions/serverless-functions/runtimes#)之一上运行，并自动配置以下资源：

- [Serverless Functions](https://vercel.com/docs/concepts/functions/serverless-functions) for handling API routes and server-side rendered pages

- 用于处理 API 路由及服务端渲染页面的 [Serverless Functions（无服务器函数）](https://vercel.com/docs/concepts/functions/serverless-functions)

- [Edge Functions](https://vercel.com/docs/concepts/functions/edge-functions) for Middleware and other functions using the **`edge`** runtime

- 使用 **`edge`** 运行时的中间件（Middleware）及其他函数所需的 [Edge Functions（边缘函数）](https://vercel.com/docs/concepts/functions/edge-functions)

- [Optimized Images](https://vercel.com/docs/concepts/image-optimization)

- [优化图像服务（Optimized Images）](https://vercel.com/docs/concepts/image-optimization)

- Static output

- 静态输出


![Deployment triggers a build in the build container which provisions resources and updates the deployment's status](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_005.jpg)![Deployment triggers a build in the build container which provisions resources and updates the deployment's status](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_006.jpg)![Deployment triggers a build in the build container which provisions resources and updates the deployment's status](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_005.jpg)![Deployment triggers a build in the build container which provisions resources and updates the deployment's status](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_006.jpg)Deployment triggers a build in the build container which provisions resources and updates the deployment's status

部署会触发构建容器中的构建流程，该流程负责配置资源并更新部署状态。

Once the necessary resources have been provisioned, a Deployment database document is created and the deployment metadata is uploaded to static storage¹. This metadata is later used during the request phase to route the user to the correct location and invoke the appropriate resource based on the incoming request path.

必要资源完成配置后，系统将创建一条 Deployment 数据库文档，并将部署元数据上传至静态存储¹。这些元数据将在后续的**请求阶段**中被使用，用于将用户路由至正确的位置，并根据传入请求路径调用相应的资源。

The newly created deployment is now ready to be served via the Vercel CDN. What happens when a user requests a website hosted on Vercel is part of the **request phase**.

新创建的部署现已可通过 Vercel CDN 提供服务。当用户访问托管在 Vercel 上的网站时，所发生的一系列操作即属于**请求阶段**。

## Request phase

## 请求阶段

Before a browser can display the website of the deployment's URL, it first has to perform a DNS lookup to find the IP address. For websites hosted on Vercel, this step always resolves with an anycast IP address owned by Vercel and the `cname.vercel-dns-0.com` CNAME record.

浏览器在显示部署 URL 对应的网站前，首先需执行 DNS 查询以获取目标 IP 地址。对于托管在 Vercel 上的网站，该步骤始终解析为 Vercel 拥有的任播（anycast）IP 地址，并关联 `cname.vercel-dns-0.com` 这一 CNAME 记录。

Whereas [GeoDNS](https://en.wikipedia.org/wiki/GeoDNS) routes users to unique endpoints based on their location, Vercel uses a networking service⁴ that uses anycast routing to route traffic to the [optimal data center](https://vercel.com/docs/concepts/edge-network/regions) determined by the number of hops, round-trip time, and amount of available bandwidth. This can improve the performance of the network by routing traffic to the destination that is closest to the source, ensuring that users globally can benefit from low-latency connections.

与 [GeoDNS](https://en.wikipedia.org/wiki/GeoDNS)（基于用户地理位置将流量导向不同终端节点）不同，Vercel 采用一种网络服务⁴，利用任播路由机制，依据跳数（hops）、往返时延（RTT）及可用带宽等指标，将流量导向[最优数据中心](https://vercel.com/docs/concepts/edge-network/regions)。该机制通过将流量导向距离源端最近的目标节点，显著提升网络性能，确保全球用户均可享受低延迟连接。

![GeoDNS (upper) vs. Anycast Routing (lower)](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_009.jpg)![GeoDNS (upper) vs. Anycast Routing (lower)](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_010.jpg)![GeoDNS (upper) vs. Anycast Routing (lower)](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_009.jpg)![GeoDNS (upper) vs. Anycast Routing (lower)](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_010.jpg)GeoDNS (upper) vs. Anycast Routing (lower)

![GeoDNS（上）vs. 任播路由（下）](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_009.jpg)![GeoDNS（上）vs. 任播路由（下）](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_010.jpg)![GeoDNS（上）vs. 任播路由（下）](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_009.jpg)![GeoDNS（上）vs. 任播路由（下）](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_010.jpg)GeoDNS（上）vs. 任播路由（下）

Besides the benefits of anycast routing, the networking service⁴ also allows applications hosted on Vercel to benefit from automatic failover and DDoS protection, and provides performance-enhancing features that are designed to improve resiliency and reduce the impact of attacks.

除任播路由优势外，该网络服务⁴还使托管于 Vercel 的应用可自动实现故障转移（failover）与 DDoS 防护，并提供一系列性能增强功能，旨在提升系统韧性、减轻攻击影响。

Vercel's IP address connects the user to the nearest edge location, which acts as a gateway to the network infrastructure⁵.

Vercel 的 IP 地址将用户连接至最近的边缘节点，该节点作为网关接入底层网络基础设施⁵。

This is where the request enters Vercel's Kubernetes cluster. The request is first inspected and filtered for malicious users, then routed to a virtual machine⁶ serving as a reverse proxy. This gateway is responsible for rewriting and proxying requests.

这是请求进入 Vercel Kubernetes 集群的位置。请求首先接受恶意用户检测与过滤，随后被路由至一台作为反向代理的虚拟机⁶。该网关负责重写请求并将其代理转发。

First, it determines which version of a deployment should be served to a user based on data such as the hostname of the incoming request, and fetches the deployment’s metadata. Depending on whether the request path matches a route specified in the deployment’s metadata, the request either resolves with a status code `404`, or continues to produce a response.

首先，它根据传入请求的主机名等数据，确定应向用户提供哪个部署版本，并获取该部署的元数据。随后，依据请求路径是否匹配部署元数据中指定的路由，请求将要么返回状态码 `404`，要么继续生成响应。

Before continuing to the response phase, the request might get modified if [Vercel Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware) is enabled, in which case the request is first forwarded to a platform responsible for executing edge functions.

在进入响应阶段之前，若启用了 [Vercel 边缘中间件（Edge Middleware）](https://vercel.com/docs/concepts/functions/edge-middleware)，请求可能会被修改——此时请求将首先被转发至一个负责执行边缘函数（edge functions）的平台。

![Flow of the request from client to requested resource](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_013.jpg)![Flow of the request from client to requested resource](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_014.jpg)![Flow of the request from client to requested resource](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_013.jpg)![Flow of the request from client to requested resource](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_014.jpg)Flow of the request from client to requested resource

![请求从客户端到目标资源的流转流程图](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_013.jpg)![请求从客户端到目标资源的流转流程图](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_014.jpg)![请求从客户端到目标资源的流转流程图](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_013.jpg)![请求从客户端到目标资源的流转流程图](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_014.jpg)请求从客户端到目标资源的流转流程图

The response phase is different for different types of resources.

响应阶段因资源类型不同而异。

- For **static resources** \- such as static pages, fonts, and unoptimized images - the gateway downloads the resource from static storage¹.

- 对于**静态资源**（例如静态页面、字体文件及未经优化的图片），网关直接从静态存储¹中下载该资源。

- For **Vercel Serverless Functions** \- such as server-rendered pages or API routes - the gateway triggers a Serverless Function⁷ execution in the region to which this function was deployed.

- 对于**Vercel 无服务器函数（Serverless Functions）**（例如服务端渲染页面或 API 路由），网关将在该函数所部署的区域中触发一次无服务器函数⁷的执行。

- For **Edge Functions** \- such as a server-rendered page or API Route using the `edge` runtime - the gateway formats the request to invoke an Edge Function execution at the edge.

- 对于**边缘函数（Edge Functions）**（例如使用 `edge` 运行时的服务端渲染页面或 API 路由），网关会对请求进行格式化，以在边缘节点上触发边缘函数的执行。

- For pages using **Incremental Static Regeneration**, the gateway first checks whether this page has been rendered before, which would make its static output available in static storage¹. If that’s not the case, the gateway invokes a Serverless Function execution⁷ to dynamically (re)generate the content. Invoking this function also happens in the case of stale content, which happens when the static resource was cached previously but its time-to-live (TTL) has passed. In that case, the stale content gets served to the user while the function gets invoked in the background to regenerate the content.

- 对于启用**增量静态再生（Incremental Static Regeneration, ISR）** 的页面，网关首先检查该页面是否已被渲染过——若已渲染，则其静态输出将存在于静态存储¹中；否则，网关将触发一次无服务器函数⁷的执行，以动态（重新）生成内容。当静态资源先前已被缓存但其生存时间（TTL）已过期（即内容“陈旧”）时，同样会触发该函数执行。此时，陈旧内容将先返回给用户，同时函数在后台被调用以重新生成最新内容。

- 对于 **优化后的图像**，请求会被转发至专用服务，以实时优化图像，并在边缘节点缓存，供后续请求使用，从而减小文件体积，并采用请求客户端浏览器所支持的现代图像格式。优化后的图像将被持续提供，直至其过期；过期后，在后台重新优化图像的同时，会继续提供一份已过期（stale）的图像版本。图像的过期时间由 [配置项](https://nextjs.org/docs/api-reference/next/image#minimum-cache-ttl) 或上游图像响应中的 `Cache-Control` 头部决定。

上述所有步骤的响应均依据 [缓存头部（caching headers）](https://vercel.com/docs/concepts/edge-network/caching) 进行缓存，以加速后续请求的查找。响应阶段标志着该请求在 Vercel 平台上的生命周期结束。

## Conclusion  
## 结论  

自行搭建并维护基础设施既繁琐又耗时：你需要选择并配置合适的服务器硬件与操作系统，部署并配置网络基础设施，安装、配置及持续维护所需的软件栈，等等。

确保基础设施的安全性与可扩展性，还需进行持续的监控、维护和更新——包括实施各类安全协议与解决方案，以抵御潜在威胁与漏洞；同时确保系统能高效应对流量激增。所有这些任务不仅耗时费力、技术复杂，更需要一支经验丰富的专职工程师团队来规模化地完成。

![Complete flow of the deployment and request lifecycle](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_017.jpg)![Complete flow of the deployment and request lifecycle](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_018.jpg)![Complete flow of the deployment and request lifecycle](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_017.jpg)![Complete flow of the deployment and request lifecycle](images/behind-the-scenes-of-vercel_s-infrastructure-achieving-optimal-scalability-and-p/img_018.jpg)部署与请求生命周期的完整流程

通过将应用部署至 Vercel，你可以大幅简化并自动化整个部署流程，无需再操心自建与维护基础设施的种种难题。Vercel 的部署流程原生具备可扩展性与安全性，让你始终能够专注于项目开发本身。平台还会针对全球性能与可访问性自动优化你的部署，无论用户身处何地，都能获得最佳用户体验。

Vercel 同样显著提升了开发者体验与产品迭代速度。其自动化的 [Git 集成](https://vercel.com/docs/concepts/git) 功能，可为每一次代码提交自动生成预览部署（Preview Deployment）；只要代码发生变更并提交，更新后的产品预览便会立即可供审查。这一特性极大缩短了开发周期，也提升了团队协作效率。

为进一步优化协作与开发流程，Vercel 还提供了 [预览部署评论功能（Comments on Preview Deployments）](https://vercel.com/docs/concepts/deployments/comments)，使团队成员可在专属环境中，就每一次变更直接提供反馈与改进建议。

[立即试用 Vercel](https://vercel.com/product-tour)，亲身体验其带来的便捷性、安全性与卓越性能。

- ¹ [Amazon S3 — 云对象存储](https://aws.amazon.com/s3/)

- ¹ [Amazon S3 — 云对象存储](https://aws.amazon.com/s3/)

- ² [Amazon Simple Queue Service（Amazon SQS）](https://aws.amazon.com/sqs/)

- ² [Amazon Simple Queue Service（Amazon SQS）](https://aws.amazon.com/sqs/)

- ³ 由 [AWS Fargate](https://aws.amazon.com/fargate/) 驱动的、支持自动扩缩的 [EC2 实例](https://aws.amazon.com/ec2/) 集群

- ³ 由 [AWS Fargate](https://aws.amazon.com/fargate/) 驱动的、支持自动扩缩的 [EC2 实例](https://aws.amazon.com/ec2/) 集群

- ⁴ [Amazon Global Accelerator（Amazon 全球加速器）](https://aws.amazon.com/global-accelerator/)

- ⁴ [Amazon Global Accelerator（Amazon 全球加速器）](https://aws.amazon.com/global-accelerator/)

- ⁵ [AWS 全球网络](https://aws.amazon.com/about-aws/global-infrastructure/)

- ⁵ [AWS 全球网络](https://aws.amazon.com/about-aws/global-infrastructure/)

- ⁶ [Amazon EKS（Amazon Elastic Kubernetes Service）](https://aws.amazon.com/eks/)

- ⁶ [Amazon EKS（Amazon Elastic Kubernetes Service）](https://aws.amazon.com/eks/)

- ⁷ [AWS Lambda](https://aws.amazon.com/lambda/)

- ⁷ [AWS Lambda](https://aws.amazon.com/lambda/)
&#123;% endraw %}
