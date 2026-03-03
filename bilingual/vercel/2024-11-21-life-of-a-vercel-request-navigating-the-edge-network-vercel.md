---
title: "Life of a Vercel request: Navigating the Edge Network - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/life-of-a-vercel-request-navigating-the-edge-network"
date: "2024-11-21"
scraped_at: "2026-03-02T09:39:19.525223408+00:00"
language: "en-zh"
translated: true
description: "Unpacking the core usage metrics of Edge Requests and Fast Data Transfer. Learn how Vercel handles network routing and data transfer—while giving you full control over performance and costs."
---

Nov 21, 2024

2024 年 11 月 21 日

Unpacking the core usage metrics of Edge Requests and Fast Data Transfer

深入解析边缘请求（Edge Requests）与快速数据传输（Fast Data Transfer）的核心使用指标

Vercel’s [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure) provisions cloud resources while providing full transparency, from the initial build to every incoming request. Developers can track how static assets are distributed globally, functions handle ISR revalidation, and resources manage routing, server-side rendering, and more.

Vercel 的[框架定义基础设施（Framework-Defined Infrastructure）](https://vercel.com/blog/framework-defined-infrastructure) 在配置云资源的同时，提供从初始构建到每一次入站请求的全程透明性。开发者可追踪静态资源如何在全球分发、函数如何处理增量静态再生（ISR）校验，以及各类资源如何协同完成路由、服务端渲染（SSR）等任务。

[As users visit your app](https://vercel.com/blog/life-of-a-vercel-request-what-happens-when-a-user-presses-enter), granular metrics reveal which resources were leveraged to serve their request. This series unpacks the Vercel Edge Network and associated resource allocation, exploring each stage of a request, and how Vercel streamlines the process.

[当用户访问您的应用时](https://vercel.com/blog/life-of-a-vercel-request-what-happens-when-a-user-presses-enter)，细粒度的指标将清晰呈现为响应此次请求而调用的具体资源。本系列文章将深入剖析 Vercel 边缘网络（Edge Network）及其关联的资源分配机制，逐阶段解析一次请求的完整生命周期，并阐释 Vercel 如何优化和简化整个流程。

With a clear understanding of these metrics and optimization strategies, you can deliver better user experiences while improving resource consumption and reducing costs.

在充分理解这些指标及对应优化策略的基础上，您将能够提升用户体验，同时优化资源利用率、降低运营成本。

[**Catch up: Read Part I**\\
\\
Life of a Vercel request: What happens when a user presses enter\\
\\
Read now](https://vercel.com/blog/life-of-a-vercel-request-what-happens-when-a-user-presses-enter)

[**回顾上篇：阅读第一部分**\\
\\
一次 Vercel 请求的生命周期：当用户按下回车键时发生了什么？\\
\\
立即阅读](https://vercel.com/blog/life-of-a-vercel-request-what-happens-when-a-user-presses-enter)

### -and-a-local-first-contact-with-vercel's-network) Points of Presence (PoPs) and a local first-contact with Vercel's network

### ——以及与 Vercel 网络的首次本地化接触）接入点（PoPs）与 Vercel 网络的首次本地化接触

In [our first post](https://vercel.com/blog/life-of-a-vercel-request-what-happens-when-a-user-presses-enter), we showed how each of Vercel's Edge Network components are pieced together to power the full request lifecycle. Now, let’s look closer at the start of that journey.

在[我们的首篇文章](https://vercel.com/blog/life-of-a-vercel-request-what-happens-when-a-user-presses-enter)中，我们展示了 Vercel 边缘网络各项组件如何协同工作，共同支撑一次请求的完整生命周期。现在，让我们聚焦旅程的起点——请求发起之初。

![](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_001.jpg)![](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_002.jpg)![](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_003.jpg)![](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_004.jpg)

The Vercel Edge Network continuously monitors the health of all networking endpoints to route connections to the most efficient destinations. Leveraging [Anycast routing](https://vercel.com/blog/behind-the-scenes-of-vercels-infrastructure)—and real-time awareness of health, speed, and user proximity—it selects the best Point of Presence (PoP) for each request.

Vercel 边缘网络持续监控所有网络端点的健康状态，从而将连接智能调度至最优目标节点。依托[任播路由（Anycast Routing）](https://vercel.com/blog/behind-the-scenes-of-vercels-infrastructure)，并结合对端点健康状况、响应速度及用户地理距离的实时感知，系统为每一次请求动态选择最合适的接入点（Point of Presence, PoP）。

After passing initial evaluation and security checks by the Vercel Firewall, the PoP links the request to one of 18 globally distributed Edge Regions. Throughout the request lifecycle, Vercel’s network dynamically adapts, rerouting traffic to redundant or failover systems when necessary to maintain uninterrupted service.

在通过 Vercel 防火墙的初步评估与安全检查后，接入点（PoP）将请求路由至全球分布的 18 个边缘区域（Edge Region）之一。在整个请求生命周期中，Vercel 网络会动态自适应，在必要时将流量重定向至冗余系统或故障转移系统，以确保服务持续可用。

![Vercel's Edge Network routes requests from the nearest PoP to the closest compute-capable Edge Region, and when necessary to a developer-designated region closer to your backend.](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_005.jpg)![Vercel's Edge Network routes requests from the nearest PoP to the closest compute-capable Edge Region, and when necessary to a developer-designated region closer to your backend.](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_006.jpg)![Vercel's Edge Network routes requests from the nearest PoP to the closest compute-capable Edge Region, and when necessary to a developer-designated region closer to your backend.](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_007.jpg)![Vercel's Edge Network routes requests from the nearest PoP to the closest compute-capable Edge Region, and when necessary to a developer-designated region closer to your backend.](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_008.jpg)Vercel's Edge Network routes requests from the nearest PoP to the closest compute-capable Edge Region, and when necessary to a developer-designated region closer to your backend.

![Vercel 的边缘网络将请求从最近的接入点（PoP）路由至计算能力最强的邻近边缘区域；必要时，还可进一步路由至开发者指定的、更靠近您后端服务的边缘区域。](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_005.jpg)![Vercel 的边缘网络将请求从最近的接入点（PoP）路由至计算能力最强的邻近边缘区域；必要时，还可进一步路由至开发者指定的、更靠近您后端服务的边缘区域。](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_006.jpg)![Vercel 的边缘网络将请求从最近的接入点（PoP）路由至计算能力最强的邻近边缘区域；必要时，还可进一步路由至开发者指定的、更靠近您后端服务的边缘区域。](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_007.jpg)![Vercel 的边缘网络将请求从最近的接入点（PoP）路由至计算能力最强的邻近边缘区域；必要时，还可进一步路由至开发者指定的、更靠近您后端服务的边缘区域。](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_008.jpg)Vercel 的边缘网络将请求从最近的接入点（PoP）路由至计算能力最强的邻近边缘区域；必要时，还可进一步路由至开发者指定的、更靠近您后端服务的边缘区域。

Let's keep zooming in, starting with the foundations of how Vercel transforms every request into [Edge Requests](https://vercel.com/docs/pricing/networking#edge-requests), optimized for rapid delivery via [Fast Data Transfer](https://vercel.com/docs/pricing/networking#fast-data-transfer).

让我们继续深入剖析——首先从基础开始：Vercel 如何将每个请求转化为 [边缘请求（Edge Requests）](https://vercel.com/docs/pricing/networking#edge-requests)，并借助 [快速数据传输（Fast Data Transfer）](https://vercel.com/docs/pricing/networking#fast-data-transfer) 实现极速交付。

## When does a request become **an Edge Request?**

## 请求何时成为 **边缘请求（Edge Request）？**

Requests to the Vercel Edge Network are filtered by platform defenses and already-active Web Application Firewall (WAF) actions before becoming "Edge Requests," optimized for ultra-low latency and high-speed delivery.

发往 Vercel 边缘网络的请求，需先经平台防御机制及已启用的 Web 应用防火墙（WAF）规则过滤，之后才被正式认定为“边缘请求”——此类请求专为超低延迟与高速交付而优化。

![A request that passes system firewall rules and existing Web Application Firewall (WAF) persistent actions becomes an Edge Request and proceeds to the WAF for evaluation.](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_009.jpg)![A request that passes system firewall rules and existing Web Application Firewall (WAF) persistent actions becomes an Edge Request and proceeds to the WAF for evaluation.](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_010.jpg)![A request that passes system firewall rules and existing Web Application Firewall (WAF) persistent actions becomes an Edge Request and proceeds to the WAF for evaluation.](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_011.jpg)![A request that passes system firewall rules and existing Web Application Firewall (WAF) persistent actions becomes an Edge Request and proceeds to the WAF for evaluation.](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_012.jpg)A request that passes system firewall rules and existing Web Application Firewall (WAF) persistent actions becomes an Edge Request and proceeds to the WAF for evaluation.

![通过系统防火墙规则及现有 Web 应用防火墙（WAF）持久化策略的请求，即被标记为边缘请求，并进入 WAF 进行进一步评估。](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_009.jpg)![通过系统防火墙规则及现有 Web 应用防火墙（WAF）持久化策略的请求，即被标记为边缘请求，并进入 WAF 进行进一步评估。](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_010.jpg)![通过系统防火墙规则及现有 Web 应用防火墙（WAF）持久化策略的请求，即被标记为边缘请求，并进入 WAF 进行进一步评估。](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_011.jpg)![通过系统防火墙规则及现有 Web 应用防火墙（WAF）持久化策略的请求，即被标记为边缘请求，并进入 WAF 进行进一步评估。](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_012.jpg)通过系统防火墙规则及现有 Web 应用防火墙（WAF）持久化策略的请求，即被标记为边缘请求，并进入 WAF 进行进一步评估。

Every Edge Request has a clear purpose—fetching data or triggering an event. Its specifics depend on the payload, route, application, deployment, and client details like cookies, user agents, or TLS fingerprints. These attributes shape how the request is processed, its bandwidth usage, and the client’s next steps after a response is delivered.

每个边缘请求均有明确目标——获取数据或触发事件。其具体行为取决于请求载荷（payload）、路由路径、应用逻辑、部署配置，以及客户端信息（如 Cookie、用户代理 User Agent 或 TLS 指纹等）。这些属性共同决定了请求的处理方式、带宽消耗，以及响应返回后客户端的后续操作。

Vercel enriches requests with contextual data—like geolocation, secure environment variables, and deployment or branch details—without adding latency. By leveraging request and application awareness, this data integrates into Edge Middleware and Vercel Functions, allowing you to make even more informed decisions in real-time.

Vercel 在不增加任何延迟的前提下，为请求注入上下文数据——例如地理位置、安全环境变量，以及部署或分支信息等。依托对请求与应用状态的深度感知，这些数据可无缝集成至边缘中间件（Edge Middleware）和 Vercel Functions，助您在毫秒级内做出更精准、更智能的实时决策。

**Usage:**

**使用场景：**

- Every Edge Request processes in real-time—from static assets, to dynamic API routes, and server-side functions  
- 所有边缘请求均实时处理——涵盖静态资源、动态 API 路由，以及服务端函数。

- 由 Vercel 防火墙或 Web 应用防火墙（WAF）[持久化操作](https://vercel.com/docs/security/vercel-waf/custom-rules#persistent-actions) 拦截的请求不计入此统计数量。

**为何这很重要：**

**为何这很重要：**  
- 跟踪边缘请求（Edge Requests）有助于深入了解应用的访问需求与用户行为。  
- 每次请求均消耗网络资源，因此优化请求频率与类型可提升性能并降低成本。

**实际查看边缘请求：**  
**Seeing Edge Requests in action:**  
- 在项目用量（Usage）标签页中，您可获得每个边缘请求的一对一精确追踪。  
- 在浏览器中使用“检查元素”（Inspect Element）功能，即可实时观察边缘请求。

**优化建议：**  
**Optimization:**  
- 页面加载时，首次请求获取 HTML，后续请求则用于获取各类资源（assets）和样式（styles）。  
- 尽管前端框架已对请求进行了优化，但某些功能仍可能导致请求频次上升。

- Edge Requests can be optimized by reducing unnecessary calls through lazy loading, adjusting polling frequency, and batching related API calls to reduce overhead  

- 通过惰性加载（lazy loading）、调整轮询频率以及批量处理相关 API 调用以减少开销，可优化 Edge Requests。

- Vercel’s analytics and developer tools can be used to monitor patterns and identify optimization opportunities  

- 可借助 Vercel 的分析工具与开发者工具监控请求模式，并识别潜在的优化机会。

Edge Requests offer flexibility, adapting to your framework and architecture. By optimizing re-renders, data-fetching, real-time features, and client-side routing, you can streamline request volume and enhance application efficiency.

Edge Requests 具备高度灵活性，可适配您的框架与架构。通过对重新渲染（re-renders）、数据获取（data-fetching）、实时功能（real-time features）及客户端路由（client-side routing）进行优化，您可精简请求量并提升应用整体效率。

## :-powering-rapid-data-movement-to-and-from-vercel) **Fast Data Transfer (FDT): Powering rapid data movement to and from Vercel**  

## :-powering-rapid-data-movement-to-and-from-vercel) **快速数据传输（FDT）：赋能 Vercel 与用户间高速数据流转**

A key element of the Vercel Edge Network, Fast Data Transfer (FDT) ensures rapid data movement between the visitor’s browser and edge regions. Supported by a vast network of PoPs and private fiber connections, Vercel bypasses typical public internet bottlenecks to deliver secure, high-speed data.

作为 Vercel 边缘网络（Edge Network）的关键组件，快速数据传输（FDT）保障了访客浏览器与边缘区域之间高效、迅捷的数据传输。依托覆盖广泛的接入点（PoP）网络与专用光纤链路，Vercel 绕过公共互联网典型瓶颈，实现安全、高速的数据交付。

![Fast Data Transfer consists of two parts: incoming requests and outgoing responses, first recognized at the same point as Edge Requests.](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_013.jpg)![Fast Data Transfer consists of two parts: incoming requests and outgoing responses, first recognized at the same point as Edge Requests.](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_014.jpg)![Fast Data Transfer consists of two parts: incoming requests and outgoing responses, first recognized at the same point as Edge Requests.](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_015.jpg)![Fast Data Transfer consists of two parts: incoming requests and outgoing responses, first recognized at the same point as Edge Requests.](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_016.jpg)Fast Data Transfer consists of two parts: incoming requests and outgoing responses, first recognized at the same point as Edge Requests.

![Fast Data Transfer consists of two parts: incoming requests and outgoing responses, first recognized at the same point as Edge Requests.](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_013.jpg)![Fast Data Transfer consists of two parts: incoming requests and outgoing responses, first recognized at the same point as Edge Requests.](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_014.jpg)![Fast Data Transfer consists of two parts: incoming requests and outgoing responses, first recognized at the same point as Edge Requests.](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_015.jpg)![Fast Data Transfer consists of two parts: incoming requests and outgoing responses, first recognized at the same point as Edge Requests.](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_016.jpg)快速数据传输（FDT）包含两个部分：入站请求（incoming requests）与出站响应（outgoing responses），二者均在与 Edge Requests 相同的初始节点被识别。

FDT refers to the low-latency movement of data between users and the Vercel Edge Network. By reducing Time to First Byte (TTFB) and Largest Contentful Paint (LCP), FDT minimizes latency and enhances the user experience.

FDT 指用户与 Vercel 边缘网络之间低延迟的数据传输。通过降低首字节时间（TTFB）与最大内容绘制（LCP），FDT 显著降低延迟，从而提升用户体验。

**Usage:**  

**使用说明：**  

- FDT is measured by the volume of data transferred during a request, covering both the inbound data (user to Vercel) and outbound data (Vercel to user)  

- FDT 的计量依据是单次请求中传输的数据总量，涵盖入站数据（用户 → Vercel）与出站数据（Vercel → 用户）两部分。  

- Higher data volumes impact both performance and usage costs  

- 数据传输量越大，对性能与用量成本的影响也越显著。

**Why it matters:**

**为什么这很重要：**

- Fast, efficient data transfer is vital for core web vitals, improving load times and user experience

- 快速、高效的数据传输对核心网页指标（Core Web Vitals）至关重要，有助于缩短页面加载时间并提升用户体验

- By sending only essential data, developers can manage both performance and costs, ensuring that users encounter minimal wait times and smoother interactions

- 仅传输必要数据，开发者便能兼顾性能与成本控制，确保用户等待时间最短、交互体验更流畅

**Seeing Fast Data Transfer in action:**

**直观感受快速数据传输（Fast Data Transfer）的实际效果：**

- Request and response headers in your browser’s devtools can show FDT in action, detailing the data transferred

- 浏览器开发者工具（DevTools）中的请求与响应头可直观呈现 FDT 的实际运行情况，并详细列出所传输的数据

**Optimization:**

**优化方式：**

- FDT can be optimized by how you handle requests and the data volume sent with each call, like API requests

- 可通过优化请求处理方式及每次调用（例如 API 请求）所发送的数据量来提升 FDT 效果

- Many frameworks support optimizations such as code-splitting, lazy loading, and tree-shaking to help reduce payload size

- 许多前端框架支持代码分割（code-splitting）、懒加载（lazy loading）和摇树优化（tree-shaking）等技术，以有效减小资源包体积

- For images, Vercel's [Image Optimization](https://vercel.com/docs/image-optimization) can significantly reduce the sizes of images served with Vercel

- 对于图片资源，Vercel 提供的 [图像优化（Image Optimization）](https://vercel.com/docs/image-optimization) 功能可大幅缩减经 Vercel 托管并分发的图片文件大小

Vercel will automatically compress assets such as images, JavaScript, and CSS, optimizing them for faster delivery. This reduces the overall data size, minimizing Fast Data Transfer, which in turn improves page load times and performance.

Vercel 会自动压缩图片、JavaScript 和 CSS 等静态资源，从而优化其传输效率。此举降低了整体数据体积，进一步减少“快速数据传输”（Fast Data Transfer）所需承载的数据量，最终提升页面加载速度与整体性能。

## Inspecting requests: A behind the scenes look

## 检查请求：幕后探秘

To see how your requests flow through the Vercel Edge Network, you can check the `x-vercel-id` header in your HTTP responses. This header reveals the edge region that handled the request and the region where any functions (Edge or serverless) were executed.

要了解您的请求如何流经 Vercel 边缘网络，您可在 HTTP 响应中检查 `x-vercel-id` 响应头。该响应头揭示了处理该请求的边缘区域，以及任何函数（Edge 函数或无服务器函数）实际执行所在的区域。

The structure of the Vercel ID acts as a globally unique identifier, useful for debugging and understanding server-side routing details, starting from the client initiating the request.

Vercel ID 的结构构成一个全局唯一标识符，有助于调试，并帮助您从客户端发起请求起，深入理解服务端路由的详细过程。

### **Practical Example**

### **实际示例**

Suppose you’re in New York City. Your request might route to the nearest edge region, `iad1` (Washington, DC), while the function executes in `sfo1` (San Francisco, CA) due to its proximity to your backend origin. The `x-vercel-id` might look like this:

假设您位于纽约市，您的请求可能被路由至最近的边缘区域 `iad1`（美国华盛顿特区），而函数则因更靠近您的后端源站而在 `sfo1`（美国加利福尼亚州旧金山）执行。此时 `x-vercel-id` 可能如下所示：

![Every Vercel request has a unique ID that shows which Edge Regions processed it.](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_017.jpg)![Every Vercel request has a unique ID that shows which Edge Regions processed it.](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_018.jpg)![Every Vercel request has a unique ID that shows which Edge Regions processed it.](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_019.jpg)![Every Vercel request has a unique ID that shows which Edge Regions processed it.](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_020.jpg)Every Vercel request has a unique ID that shows which Edge Regions processed it.

![每个 Vercel 请求都拥有一个唯一 ID，用于显示处理该请求的边缘区域。](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_017.jpg)![每个 Vercel 请求都拥有一个唯一 ID，用于显示处理该请求的边缘区域。](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_018.jpg)![每个 Vercel 请求都拥有一个唯一 ID，用于显示处理该请求的边缘区域。](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_019.jpg)![每个 Vercel 请求都拥有一个唯一 ID，用于显示处理该请求的边缘区域。](images/life-of-a-vercel-request-navigating-the-edge-network-vercel/img_020.jpg)每个 Vercel 请求都拥有一个唯一 ID，用于显示处理该请求的边缘区域。

Points of Presence (PoPs) are not included in the `x-vercel-id` header.

接入点（Points of Presence, PoPs）不会出现在 `x-vercel-id` 响应头中。

## Optimizing Vercel Edge Network usage

## 优化 Vercel 边缘网络使用

Every request to a Vercel app— [from the moment a user presses enter to the final response](https://vercel.com/blog/life-of-a-vercel-request-what-happens-when-a-user-presses-enter)—adapts to the user’s intent and your framework’s code. Whether it’s routing, rendering, or caching, every step reflects decisions shaped by user parameters and your application logic. As you push code, Vercel builds the application and allocates cloud resources, activating components exactly when needed for optimal delivery.

每个发往 Vercel 应用的请求——[从用户按下回车键到最终响应返回的全过程](https://vercel.com/blog/life-of-a-vercel-request-what-happens-when-a-user-presses-enter)——都会根据用户意图和您所用框架的代码动态调整。无论是路由、渲染还是缓存，每一步决策均由用户参数与您的应用逻辑共同决定。当您推送代码时，Vercel 会构建应用并分配云资源，仅在需要时精准激活相应组件，以实现最优交付。

Maximize your app’s performance by tracking Edge Requests and Fast Data Transfer. With resources allocated based on your framework, you have full control to ensure your application is efficient and cost-effective.

通过监控“边缘请求”（Edge Requests）与“快速数据传输”（Fast Data Transfer），最大化您应用的性能表现。由于资源分配基于您选用的框架，您可全面掌控应用行为，确保其高效运行且具备成本效益。