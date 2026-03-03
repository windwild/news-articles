---
title: "A/B Testing and Feature Flags with sub-millisecond performance - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-edge-config-is-now-generally-available"
date: "2023-04-06"
scraped_at: "2026-03-02T09:53:53.158629467+00:00"
language: "en-zh"
translated: true
description: "A globally distributed data store for low latency experimentation."
---

Apr 6, 2023

2023 年 4 月 6 日

A globally distributed data store for low latency experimentation.

面向低延迟实验的全球分布式数据存储。

Configuration data is used to control everything from A/B testing and feature flags to advanced rewrites and bespoke request-blocking rules. However, traditional solutions for managing configuration data can be slow, unreliable, and difficult to scale, which can negatively impact the user experience, latency, and overall effectiveness of your website.

配置数据用于控制从 A/B 测试、功能开关（feature flags），到高级重写规则及定制化请求拦截规则等一切功能。然而，传统配置数据管理方案往往速度慢、可靠性差且难以扩展，这会负面影响用户体验、响应延迟以及您网站的整体有效性。

Today we’re announcing the general availability of [Edge Config](https://vercel.com/docs/concepts/edge-network/edge-config), a new solution for managing configuration data in the cloud designed to be ultra-fast, reliable, and scalable, which can help improve your website's performance and efficiency.

今天我们正式宣布 [Edge Config](https://vercel.com/docs/concepts/edge-network/edge-config) 全面上线——这是一款专为云端配置数据管理而设计的新解决方案，具备超高速、高可靠与强可扩展性，可显著提升您网站的性能与运行效率。

```javascript
import { NextResponse, NextRequest } from "next/server";

import { get } from "@vercel/edge-config";



export async function middleware(request: NextRequest) {

5  if (await get("showNewDashboard")) {

6    return NextResponse.rewrite(new URL("/new-dashboard", request.url));
```

7  }

8}
```

Vercel Edge Config has a simple API to get started quickly, shown here with Edge Middleware.

Vercel Edge Config 提供简洁的 API，可助您快速上手，此处以 Edge Middleware 为例展示。

Edge Config is a globally distributed, ultra-low latency data store for configuration data. It's optimized for fast, inexpensive reads and infrequent writes, making it perfect for managing experimentation and configuration data in modern web applications. Unlike traditional solutions for managing configuration data, Edge Config enables _dynamic_ data storage alongside your functions, which means that your data is actively replicated to all of Vercel's regions before it's requested. This ensures that your data will always be available instantly, no matter where your users are located.

Edge Config 是一个全球分布式、超低延迟的配置数据存储服务。它专为高频、低成本读取与低频写入而优化，非常适合在现代 Web 应用中管理实验（A/B 测试）与配置数据。与传统的配置管理方案不同，Edge Config 支持将 _动态_ 数据与您的函数并置部署——这意味着您的数据会在被请求前，主动同步至 Vercel 全球所有边缘区域。由此确保无论用户身处何地，您的配置数据始终能即时可用。

> “LaunchDarkly and Vercel’s mutual enterprise customers now have a way to deploy feature flags and experiments at the edge with zero latency. Every company is becoming a software company and this integration will further our joint mission to empower companies to ship and iterate applications at lightning speed.LaunchDarkly and Vercel’s mutual enterprise customers now have a way to deploy feature flags and experiments at the edge with zero latency. Every company is becoming a software company and this integration will further our joint mission to empower companies to ship and iterate applications at lightning speed.”
>
> ![](images/a_b-testing-and-feature-flags-with-sub-millisecond-performance-vercel/img_001.png)
>
> **John Kodumal,** Co-Founder and CTO at LaunchDarkly

> “LaunchDarkly 与 Vercel 的共同企业客户如今拥有了在边缘部署功能开关（feature flags）与实验的能力，真正实现零延迟。每一家公司都在成为软件公司，而此次集成将进一步推动我们双方的共同使命：赋能企业以闪电般的速度发布与迭代应用。”
>
> ![](images/a_b-testing-and-feature-flags-with-sub-millisecond-performance-vercel/img_001.png)
>
> **John Kodumal**，LaunchDarkly 联合创始人兼首席技术官（CTO）

- **Make your experimentation near-zero latency:** Most lookups return in 0ms, and 99% will return in under 10ms. You get nearly the performance of static configuration with the convenience of updating it from your experimentation tool, from our API, or from our UI.

- **让您的实验接近零延迟：** 大多数查询响应时间为 0 毫秒，99% 的查询可在 10 毫秒内完成。您既能享受静态配置般的极致性能，又能通过实验平台、API 或控制台界面便捷地动态更新配置。

- **Make changes without a new deployment:** Changes to Edge Config are pushed to every region within seconds, so that you can take advantage of them without needing to deploy your entire site.

- **无需重新部署即可生效变更：** Edge Config 的任何更改均能在数秒内同步至所有边缘区域，因此您无需重新部署整个站点即可立即启用新配置。

- **Integrate with your experimentation tool:** Automatically populate the Edge Config connected to your project with the experiment’s evaluation rules. We can then fetch our [experiments](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config) in our code easily by integrating directly with [Statsig](https://vercel.com/integrations/statsig)—meaning you make changes in the Statsig interface, and you can query the values lightning-fast from Edge Config within Edge Middleware.

- **与您的实验平台无缝集成：** 自动将实验的评估规则同步至您项目所关联的 Edge Config。随后，您可通过直接集成 [Statsig](https://vercel.com/integrations/statsig)，在代码中轻松获取我们的 [实验配置](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config)——即：您在 Statsig 控制台中所做的任何变更，均可在 Edge Middleware 中以毫秒级速度从 Edge Config 查询到对应值。

> “Combining Statsig with Next.js and Vercel Edge Config unlocks a high-performance feature management and experimentation engine in a way that was just not possible before. Our customers are using the integration to control releases and automate experimentation with near zero latency. The impact is immediate when running experiments on landing pages, UX optimizations, URL redirects, and more.Combining Statsig with Next.js and Vercel Edge Config unlocks a high-performance feature management and experimentation engine in a way that was just not possible before. Our customers are using the integration to control releases and automate experimentation with near zero latency. The impact is immediate when running experiments on landing pages, UX optimizations, URL redirects, and more.”
>
> ![](images/a_b-testing-and-feature-flags-with-sub-millisecond-performance-vercel/img_002.png)
>
> **Vijaye Raji,** Founder and CEO at Statsig

> “将 Statsig 与 Next.js 及 Vercel Edge Config 结合，首次实现了高性能的功能管理与实验引擎——这在此前是无法企及的。我们的客户正借助该集成，以近乎零延迟的方式管控功能发布、自动化实验流程。当在落地页、用户体验优化、URL 重定向等场景运行实验时，其效果立竿见影。”
>
> ![](images/a_b-testing-and-feature-flags-with-sub-millisecond-performance-vercel/img_002.png)
>
> **Vijaye Raji**，Statsig 创始人兼首席执行官（CEO）

We’re continuing to work with integration partners for dynamic personalization at the edge. [Split](https://vercel.com/templates/next.js/ab-testing-split) is currently upgrading their integration to include support for Edge Config and we are happy to announce a LaunchDarkly integration will be available at the end of April.

我们正持续携手集成合作伙伴，共同推进边缘端的动态个性化能力。[Split](https://vercel.com/templates/next.js/ab-testing-split) 目前正在升级其集成方案，以全面支持 Edge Config；同时，我们很高兴地宣布：LaunchDarkly 集成将于四月底正式上线。

> “Edge Config 所提供的数据存储具备全球一致性与动态性，这使其成为 Split 功能开关 SDK 在边缘运行的理想选择，可为 Vercel 用户提供近乎零延迟的服务体验，全面支持功能开关与 A/B 实验等用例——尤其适用于采用中间件逻辑的 Vercel 用户。Edge Config 所提供的数据存储具备全球一致性与动态性，这使其成为 Split 功能开关 SDK 在边缘运行的理想选择，可为 Vercel 用户提供近乎零延迟的服务体验，全面支持功能开关与 A/B 实验等用例——尤其适用于采用中间件逻辑的 Vercel 用户。”

> “Edge Config 所提供的数据存储具备全球一致性与动态性，这使其成为 Split 功能开关 SDK 在边缘运行的理想选择，可为 Vercel 用户提供近乎零延迟的服务体验，全面支持功能开关与 A/B 实验等用例——尤其适用于采用中间件逻辑的 Vercel 用户。”

> ![](images/a_b-testing-and-feature-flags-with-sub-millisecond-performance-vercel/img_003.png)

> **Pato Echague**，Split 联合创始人兼首席技术官

## Dynamic routing with Edge Middleware

## 基于 Edge 中间件的动态路由

Combining Vercel Edge Middleware with an ultra-low latency data store opens up numerous other options to control your routing dynamically. For example, you can add blocked IPs and user-agents in Edge Config and make changes without needing to deploy your site. In your middleware you can query the entire configuration list at once then reject those in middleware with minimal overhead.

将 Vercel Edge 中间件与超低延迟数据存储相结合，可开辟大量新途径以实现动态路由控制。例如，您可在 Edge Config 中添加被屏蔽的 IP 地址与 User-Agent 列表，并在无需重新部署网站的情况下即时更新这些配置。在您的中间件中，您可一次性查询全部配置项，随后以极小开销在中间件层直接拒绝匹配的请求。

```javascript
import { getAll } from "@vercel/edge-config";



export async function middleware(request: Request) {

4  const [userAgents, ipAddresses] = await getAll(["userAgents", "ipAddresses"]);



6  if (

7    userAgents.includes(request.headers.get("user-agent")) ||

8    ipAddresses.includes(request.ip)

9  ) {

10    return new Response("Denied", { status: 403 });

11  }

12}
```

Vercel Edge Config 可用于实现高级安全规则，例如基于地理位置的访问屏蔽。

## 开始使用 Edge Config

## 开始使用 Edge Config

Edge Config 对所有 Vercel 账户开放。Hobby（免费）用户每月可执行 50,000 次读取操作；Pro 和 Enterprise（专业版与企业版）用户每月可执行 1,000,000 次读取操作，超出部分可按需额外付费。

您可在账户控制台中查看 Edge Config 的读取与写入次数统计。

如需开始使用 Vercel，请部署一个[示例项目](https://vercel.com/templates/edge-config)，或查阅我们的[文档](https://vercel.com/docs/concepts/edge-network/edge-config)。