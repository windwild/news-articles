---
render_with_liquid: false
title: "The foundations of the Frontend Cloud - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/the-foundations-of-the-frontend-cloud"
date: "2023-11-21"
scraped_at: "2026-03-02T09:49:23.901755871+00:00"
language: "en-zh"
translated: true
description: "An introduction to the underlying infrastructure of the Frontend Cloud: Part 1 of the developer's guide to a future-proofed stack for the modern frontend."
---
render_with_liquid: false
render_with_liquid: false

Nov 21, 2023

2023 年 11 月 21 日

Part 1 of the developer's guide to a future-proofed stack.

面向未来的技术栈开发者指南 · 第一部分

Core web app decisions tend to center the backend, due to its complexity and impact over huge swaths of the business.

核心 Web 应用的决策往往围绕后端展开，这源于其固有的复杂性，以及对业务大片领域的深远影响。

However, frontends have grown far more important and complex in their own right. When not prioritized, the intricate infrastructure around them can quickly spin out of control, dragging teams into untold amounts of tech debt.

然而，前端自身的重要性与复杂性也已大幅提升。若未被充分重视，其背后错综复杂的基础设施将迅速失控，使团队深陷难以估量的技术债泥潭。

As [decoupled architecture](https://vercel.com/blog/the-foundations-of-the-frontend-cloud#why-decouple-the-frontend-from-the-backend...) becomes more common, developers are turning to the Frontend Cloud to automate away the behind-the-scenes hassles of creating and growing dynamic websites.

随着[解耦架构](https://vercel.com/blog/the-foundations-of-the-frontend-cloud#why-decouple-the-frontend-from-the-backend...)日益普及，开发者正转向“前端云”（Frontend Cloud），以自动化方式消除构建和扩展动态网站过程中那些隐于幕后的繁琐事务。

Instead of [managing infrastructure](https://vercel.com/blog/behind-the-scenes-of-vercels-infrastructure) as a separate step of the development process, the Frontend Cloud provisions global infrastructure _for you_, [based on your existing application code](https://vercel.com/blog/framework-defined-infrastructure).

不同于将[基础设施管理](https://vercel.com/blog/behind-the-scenes-of-vercels-infrastructure)作为开发流程中一个独立环节，前端云会**基于您现有的应用代码**，为您自动配置全球基础设施。

This approach to web development [massively increases developer velocity](https://vercel.com/blog/iterating-from-design-to-deploy), allowing your team to experiment safely and meet shifting market demands. Teams of all sizes can effortlessly scale global apps while maintaining the highest possible bars for performance, personalization, and security.

这种 Web 开发方式[极大提升了开发者的交付速度](https://vercel.com/blog/iterating-from-design-to-deploy)，使您的团队得以安全地开展实验，并敏捷响应不断变化的市场需求。无论团队规模大小，均可轻松扩展全球化应用，同时持续保障性能、个性化体验与安全性的最高标准。

**You can think of the backend cloud as your cost center and the Frontend Cloud as your profit center.**

**您可以将后端云视作成本中心，而将前端云视作利润中心。**

In this blog series, we'll break down why moving to the Frontend Cloud is the **last business infrastructure transformation you’d ever need to make**. We'll dig into the Frontend Cloud by way of:

在本系列博客中，我们将深入剖析：为何迁移到前端云，是您**此生所需完成的最后一次业务基础设施转型**。我们将从以下角度切入，全面解读前端云：

- Foundational concepts like framework-defined infrastructure (FdI) and serverless architecture (this article)

- 框架定义基础设施（Framework-defined Infrastructure, FdI）、无服务器架构（Serverless Architecture）等基础概念（本文）

- User experience (UX) wins through performant and personalized applications delivered at the edge  
- 通过在边缘交付高性能、个性化的应用，赢得卓越的用户体验（UX）

- Faster and more sustainable iteration through a complete Developer Experience (DX) platform  
- 借助完整的开发者体验（DX）平台，实现更快速、更可持续的迭代

- Reliability and security to power even the largest applications  
- 高可靠性与安全性，足以支撑规模最大的应用程序

[**Hoping for a higher-level overview?**  
**希望了解更高层次的概览？**

The Frontend Cloud advantage redefines web development for the modern enterprise.  
前端云（Frontend Cloud）优势正在重新定义现代企业的 Web 开发方式。

Learn More  
了解更多](https://vercel.com/resources/the-frontend-cloud-advantage)

## What is a modern frontend?  
## 什么是现代前端？

In the context of the Frontend Cloud, _Frontend_ is far more than what you see on your screen. **_Frontend_** **encompasses all components of a system that communicate directly with external** **_clients_** **to that system, whether those clients are user-facing interfaces or machine-to-machine interactions.**  
在前端云（Frontend Cloud）语境下，“前端”（_Frontend_）远不止你屏幕上所见的内容。**“前端”涵盖系统中所有直接与该系统外部“客户端”（_clients_）通信的组件——无论这些客户端是面向用户的界面，还是机器对机器（M2M）交互。**

![Frontends can be deeply embedded within your application architecture.​​​​‌﻿‍﻿​‍​‍‌‍﻿﻿‌﻿​‍‌‍‍‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍​‍​‍﻿​​‍​‍‌‍‍​‌﻿​‍‌‍‌‌‌‍‌‍​‍​‍​﻿‍‍​‍​‍​‍﻿﻿‌‍​‌‌﻿​​‌‍‍‌​‍﻿﻿‌‍​‍‌‍﻿​‌‍﻿﻿‌‍‌﻿​‍﻿﻿‌‍‌‌‌‍‌​‌‍‍‌‌﻿‌​​﻿﻿﻿‌‍‌‌​﻿﻿‌​﻿​‍‌​‍﻿​﻿​‍‌​‌‌‌​​﻿‌‍﻿‍‌​‍‌‌‍‍‍‌​​‍‌‍﻿‍‌​​‌​﻿‌‌‌‍‌‍‌​‍﻿‌​‍‌‌﻿‌﻿‌​﻿‍‌​‌﻿‌​​‌‌​‍‌‌​​‌‌‍​‍​‍‌‍‌﻿‌​​﻿﻿‌‌‍​‌​‍​‍​‍﻿​​‍​‍‌﻿‌​‌﻿‍‌‌﻿​​‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌﻿‌​‌‍‌‌‌﻿‍​‌﻿‌​​‍​‍​‍﻿​​‍​‍‌‍‌​‌‍​‌‌﻿‌​‌‍​‌​‍​‍​﻿‍‍​‍​‍‌‍‌​‌‍‌‌‌﻿​﻿‌‍​﻿‌﻿​‍‌‍‍‌‌﻿​​‌﻿‌​‌‍‍‌‌‍﻿﻿‌‍﻿‍​‍​‍‌﻿﻿‌](images/the-foundations-of-the-frontend-cloud-vercel/img_001.jpg)![Frontends can be deeply embedded within your application architecture.​​​​‌﻿‍﻿​‍​‍‌‍﻿﻿‌﻿​‍‌‍‍‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍​‍​‍﻿​​‍​‍‌‍‍​‌﻿​‍‌‍‌‌‌‍‌‍​‍​‍​﻿‍‍​‍​‍​‍﻿﻿‌‍​‌‌﻿​​‌‍‍‌​‍﻿﻿‌‍​‍‌‍﻿​‌‍﻿﻿‌‍‌﻿​‍﻿﻿‌‍‌‌‌‍‌​‌‍‍‌‌﻿‌​​﻿﻿﻿‌‍‌‌​﻿﻿‌​﻿​‍‌​‍﻿​﻿​‍‌​‌‌‌​​﻿‌‍﻿‍‌​‍‌‌‍‍‍‌​​‍‌‍﻿‍‌​​‌​﻿‌‌‌‍‌‍‌​‍﻿‌​‍‌‌﻿‌﻿‌​﻿‍‌​‌﻿‌​​‌‌​‍‌‌​​‌‌‍​‍​‍‌‍‌﻿‌​​﻿﻿‌‌‍​‌​‍​‍​‍﻿​​‍​‍‌﻿‌​‌﻿‍‌‌﻿​​‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌﻿‌​‌‍‌‌‌﻿‍​‌﻿‌​​‍​‍​‍﻿​​‍​‍‌‍‌​‌‍​‌‌﻿‌​‌‍​‌​‍​‍​﻿‍‍​‍​‍‌‍‌​‌‍‌‌‌﻿​﻿‌‍​﻿‌﻿​‍‌‍‍‌‌﻿​​‌﻿‌​‌‍‍‌‌‍﻿﻿‌‍﻿‍​‍​‍‌﻿﻿‌](images/the-foundations-of-the-frontend-cloud-vercel/img_002.jpg)![Frontends can be deeply embedded within your application architecture.​​​​‌﻿‍﻿​‍​‍‌‍﻿﻿‌﻿​‍‌‍‍‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍​‍​‍﻿​​‍​‍‌‍‍​‌﻿​‍‌‍‌‌‌‍‌‍​‍​‍​﻿‍‍​‍​‍​‍﻿﻿‌‍​‌‌﻿​​‌‍‍‌​‍﻿﻿‌‍​‍‌‍﻿​‌‍﻿﻿‌‍‌﻿​‍﻿﻿‌‍‌‌‌‍‌​‌‍‍‌‌﻿‌​​﻿﻿﻿‌‍‌‌​﻿﻿‌​﻿​‍‌​‍﻿​﻿​‍‌​‌‌‌​​﻿‌‍﻿‍‌​‍‌‌‍‍‍‌​​‍‌‍﻿‍‌​​‌​﻿‌‌‌‍‌‍‌​‍﻿‌​‍‌‌﻿‌﻿‌​﻿‍‌​‌﻿‌​​‌‌​‍‌‌​​‌‌‍​‍​‍‌‍‌﻿‌​​﻿﻿‌‌‍​‌​‍​‍​‍﻿​​‍​‍‌﻿‌​‌﻿‍‌‌﻿​​‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌﻿‌​‌‍‌‌‌﻿‍​‌﻿‌​​‍​‍​‍﻿​​‍​‍‌‍‌​‌‍​‌‌﻿‌​‌‍​‌​‍​‍​﻿‍‍​‍​‍‌‍‌​‌‍‌‌‌﻿​﻿‌‍​﻿‌﻿​‍‌‍‍‌‌﻿​​‌﻿‌​‌‍‍‌‌‍﻿﻿‌‍﻿‍​‍​‍‌﻿﻿‌](images/the-foundations-of-the-frontend-cloud-vercel/img_003.jpg)![Frontends can be deeply embedded within your application architecture.​​​​‌﻿‍﻿​‍​‍‌‍﻿﻿‌﻿​‍‌‍‍‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍​‍​‍﻿​​‍​‍‌‍‍​‌﻿​‍‌‍‌‌‌‍‌‍​‍​‍​﻿‍‍​‍​‍​‍﻿﻿‌‍​‌‌﻿​​‌‍‍‌​‍﻿﻿‌‍​‍‌‍﻿​‌‍﻿﻿‌‍‌﻿​‍﻿﻿‌‍‌‌‌‍‌​‌‍‍‌‌﻿‌​​﻿﻿﻿‌‍‌‌​﻿﻿‌​﻿​‍‌​‍﻿​﻿​‍‌​‌‌‌​​﻿‌‍﻿‍‌​‍‌‌‍‍‍‌​​‍‌‍﻿‍‌​​‌​﻿‌‌‌‍‌‍‌​‍﻿‌​‍‌‌﻿‌﻿‌​﻿‍‌​‌﻿‌​​‌‌​‍‌‌​​‌‌‍​‍​‍‌‍‌﻿‌​​﻿﻿‌‌‍​‌​‍​‍​‍﻿​​‍​‍‌﻿‌​‌﻿‍‌‌﻿​​‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌﻿‌​‌‍‌‌‌﻿‍​‌﻿‌​​‍​‍​‍﻿​​‍​‍‌‍‌​‌‍​‌‌﻿‌​‌‍​‌​‍​‍​﻿‍‍​‍​‍‌‍‌​‌‍‌‌‌﻿​﻿‌‍​﻿‌﻿​‍‌‍‍‌‌﻿​​‌﻿‌​‌‍‍‌‌‍﻿﻿‌‍﻿‍​‍​‍‌﻿﻿‌](images/the-foundations-of-the-frontend-cloud-vercel/img_004.jpg)Frontends can be deeply embedded within your application architecture.​​​​‌﻿‍﻿​‍​‍‌‍﻿﻿‌﻿​‍‌‍‍‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍​‍​‍﻿​​‍​‍‌‍‍​‌﻿​‍‌‍‌‌‌‍‌‍​‍​‍​﻿‍‍​‍​‍​‍﻿﻿‌‍​‌‌﻿​​‌‍‍‌​‍﻿﻿‌‍​‍‌‍﻿​‌‍﻿﻿‌‍‌﻿​‍﻿﻿‌‍‌‌‌‍‌​‌‍‍‌‌﻿‌​​﻿﻿﻿‌‍‌‌​﻿﻿‌​﻿​‍‌​‍﻿​﻿​‍‌​‌‌‌​​﻿‌‍﻿‍‌​‍‌‌‍‍‍‌​​‍‌‍﻿‍‌​​‌​﻿‌‌‌‍‌‍‌​‍﻿‌​‍‌‌﻿‌﻿‌​﻿‍‌​‌﻿‌​​‌‌​‍‌‌​​‌‌‍​‍​‍‌‍‌﻿‌​​﻿﻿‌‌‍​‌​‍​‍​‍﻿​​‍​‍‌﻿‌​‌﻿‍‌‌﻿​​‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌﻿‌​‌‍‌‌‌﻿‍​‌﻿‌​​‍​‍​‍﻿​​‍​‍‌‍‌​‌‍​‌‌﻿‌​‌‍​‌​‍​‍​﻿‍‍​‍​‍‌‍‌​‌‍‌‌‌﻿​﻿‌‍​﻿‌﻿​‍‌‍‍‌‌﻿​​‌﻿‌​‌‍‍‌‌‍﻿﻿‌‍﻿‍​‍​‍‌﻿﻿‌

这表示，前端包括以下类型的服务：

This means that frontends include services such as:  

- An application’s user interface, whether that application is for end users or internal only  
- 应用程序的用户界面（UI），无论该应用面向终端用户，还是仅限内部使用

- Any part of an app that runs on a user's device  
- 应用中运行于用户设备上的任意部分

- API services that respond to external clients  
- 响应外部客户端的 API 服务  

- User-facing reverse-proxies such as CDNs or ingress firewalls  
- 面向用户的反向代理，例如 CDN 或入口防火墙  

- Servers that respond to end users to perform tasks such as server-side rendering or asset distribution  
- 响应终端用户以执行服务端渲染（SSR）或静态资源分发等任务的服务器  

- Services such as [image optimization](https://vercel.com/docs/image-optimization) which are technically backend to the above but are specialized for frontend concerns  
- 诸如 [图片优化](https://vercel.com/docs/image-optimization) 之类的服务——技术上属于上述系统的后端，但专为前端需求而设计  

There are [more granular ways to distinguish between frontends and backends](https://www.industrialempathy.com/posts/frontend-backend/), but as you can see, frontends encapsulate far more infrastructure than ever before.  
业界存在 [更精细地区分前端与后端的方法](https://www.industrialempathy.com/posts/frontend-backend/)，但如你所见，如今的前端所涵盖的基础设施远超以往任何时候。

Frontends are far more than the rendered HTML, CSS, and JS you see on the page.  
前端远不止页面上所呈现的 HTML、CSS 和 JavaScript。

When we talk about the Frontend Cloud, we’re referring to the frameworks, workflows, and infrastructure that let you build and scale the web’s most demanding frontend workloads.  
当我们谈及“前端云”（Frontend Cloud）时，指的是支撑你构建并规模化运行 Web 上最严苛前端工作负载的框架、工作流与基础设施。

This isn't about reinventing the wheel. Instead, it's about collecting decades of best practices to give you the smartest possible defaults for your frontend infrastructure.  
这并非要重新发明轮子；而是汇聚数十年来沉淀的最佳实践，为你提供针对前端基础设施最明智的默认配置。

Taking advantage of this, however, first requires breaking your frontend free from the (often constraining) requirements of backend systems.  
然而，要真正受益于此，首先需将你的前端从后端系统（往往具有诸多限制性）的要求中解耦出来。

## Why decouple the frontend from the backend...  
## 为何要将前端与后端解耦……

Monolithic architecture—where backend logic and application rendering are handled in one large codebase—has long been a go-to for software devs. Monoliths are easy to set up since they can be written in a single language, but they begin to fracture when faced with rapid scaling, due to:

单体架构——即后端逻辑与应用渲染均由一个庞大的代码库统一处理——长期以来一直是软件开发者的首选方案。单体应用易于搭建，因其可全部使用同一种编程语言编写；但当面临快速扩展需求时，其架构便开始瓦解，原因包括：

- Unforeseen ripple effects with _any_ code change, regardless of where in the stack it lies.

- 任何一处代码变更（无论其位于技术栈的哪个层级）都可能引发难以预料的连锁反应。

- Longer testing cycles and slower growth.

- 测试周期更长，整体增长速度更慢。

- Tangled dependencies where teams block each others' work.

- 依赖关系错综复杂，导致各团队工作相互阻塞。

- The breadth of surface area developers are required to understand.

- 开发人员需掌握的知识面过于宽泛。

![Headless architecture allows teams to work more independently of each other, which means faster iteration.](images/the-foundations-of-the-frontend-cloud-vercel/img_005.jpg)![Headless architecture allows teams to work more independently of each other, which means faster iteration.](images/the-foundations-of-the-frontend-cloud-vercel/img_006.jpg)

![无头架构使各团队能更独立地开展工作，从而实现更快的迭代。](images/the-foundations-of-the-frontend-cloud-vercel/img_005.jpg)![无头架构使各团队能更独立地开展工作，从而实现更快的迭代。](images/the-foundations-of-the-frontend-cloud-vercel/img_006.jpg)

Headless architecture allows teams to work more independently of each other, which means faster iteration.

无头架构使各团队能更独立地开展工作，从而实现更快的迭代。

**Frontends need to scale and iterate much faster than backends**, and freeing up their ability to grow from your application’s backend offers many benefits:

**前端的扩展与迭代速度必须远超后端**；将前端从应用程序后端中解耦，使其获得自主演进能力，可带来诸多优势：

- Your frontend performance, reliability, and scale can all be independent of your backend code.

- 前端的性能、可靠性与扩展能力均可完全独立于后端代码。

- Your frontend and backend teams can work independently of one another, and [with the proper frontend architecture](https://vercel.com/blog/how-to-scale-a-large-codebase), frontend teams can also work separately from each other.

- 前端与后端团队可彼此独立工作；而借助恰当的前端架构（[参见《如何规模化管理大型代码库》](https://vercel.com/blog/how-to-scale-a-large-codebase)），各前端团队之间亦可相互解耦、并行开发。

- Your frontend code can be written in one of many frontend-optimized languages, which have vast communities of tools and plugins—as well as a larger pool of qualified developers to hire.  
- 前端代码可使用多种专为前端优化的语言编写，这些语言拥有庞大的工具与插件生态，同时也意味着更广阔的合格开发者人才池可供招聘。

- Onboarding is faster: frontend devs only need to know the frontend language and they don’t need to understand the backend architecture.  
- 入职更快：前端开发者只需掌握前端语言，无需理解后端架构。

- The points of entry to your backend, where your secure customer data resides, can be highly controlled and accessible by APIs that must play by the rules of your backend.  
- 后端（即您安全的客户数据所在之处）的接入点可实现高度管控，仅允许遵循后端规则的 API 进行访问。

- Faster frontend iteration means better developer _and_ user experiences. Releases have fewer change-sets and bugs are easier to address.  
- 更快的前端迭代意味着更优的开发者体验与用户体验。发布版本变更集更少，缺陷也更易定位与修复。

[**Why are innovators going headless?**  
**为什么创新者纷纷采用无头架构？**

Learn why headless architecture is a great fit for nimble organizations that want flexibility and speed, as well as a future-proofed technology stack.  
了解为何无头架构特别适合追求灵活性、开发速度，以及技术栈长期可持续性的敏捷型组织。

Read More  
阅读更多](https://vercel.com/resources/why-innovators-are-going-headless)

### ...and how to connect them again  
### ……以及如何重新连接它们

As far as the connection between backend and frontend goes, this can be handled with a middleware API layer—almost like a socket converter for your backend. Your frontend and backend engineers can continue to work in the ways they know, and the team managing the API layer can make sure frontend and backend connect.  
就前后端之间的连接而言，可通过中间件 API 层来实现——其作用类似于为后端配备的“接口转换器”。前端与后端工程师可继续沿用各自熟悉的开发方式，而负责 API 层的团队则确保前后端顺利对接。

![A headless frontend can be attached to your backend via a middleware layer that interprets backend data for the frontend and vice versa.​​​​‌﻿‍﻿​‍​‍‌‍﻿﻿‌﻿​‍‌‍‍‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍​‍​‍﻿​​‍​‍‌‍‍​‌﻿​‍‌‍‌‌‌‍‌‍​‍​‍​﻿‍‍​‍​‍​‍﻿﻿‌‍​‌‌﻿​​‌‍‍‌​‍﻿﻿‌‍​‍‌‍﻿​‌‍﻿﻿‌‍‌﻿​‍﻿﻿‌‍‌‌‌‍‌​‌‍‍‌‌﻿‌​​﻿﻿﻿‌‍‌‌​﻿﻿‌​﻿​﻿‌​﻿﻿‌﻿‌‌‌‍‌​‌‌​​‌​﻿‌‌‍‍​‌​﻿‌​﻿​​‌​﻿﻿‌‍​‍‌​‍﻿‌‌​​‌‍‍​‌‍‍​​﻿‌​‌‍‌‌‌​​‌‌﻿‌‍‌​​﻿‌​‍‍‌‍‌‌​‍‌‍‌﻿‌​​﻿﻿‌‌‍​‌​‍​‍​‍﻿​​‍​‍‌﻿‌​‌﻿‍‌‌﻿​​‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌﻿‌​‌‍‌‌‌﻿‍​‌﻿‌​​‍​‍​‍﻿​​‍​‍‌‍‌​‌‍​‌‌﻿‌​‌‍​‌​‍​‍​﻿‍‍​‍​‍‌‍‌​‌‍‌‌‌﻿​﻿‌‍​﻿‌﻿​‍‌‍‍‌‌﻿​​‌﻿‌​‌‍‍‌‌‍﻿﻿‌‍﻿‍​‍​‍‌﻿﻿‌](images/the-foundations-of-the-frontend-cloud-vercel/img_007.jpg)![A headless frontend can be attached to your backend via a middleware layer that interprets backend data for the frontend and vice versa.​​​​‌﻿‍﻿​‍​‍‌‍﻿﻿‌﻿​‍‌‍‍‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍​‍​‍﻿​​‍​‍‌‍‍​‌﻿​‍‌‍‌‌‌‍‌‍​‍​‍​﻿‍‍​‍​‍​‍﻿﻿‌‍​‌‌﻿​​‌‍‍‌​‍﻿﻿‌‍​‍‌‍﻿​‌‍﻿﻿‌‍‌﻿​‍﻿﻿‌‍‌‌‌‍‌​‌‍‍‌‌﻿‌​​﻿﻿﻿‌‍‌‌​﻿﻿‌​﻿​﻿‌​﻿﻿‌﻿‌‌‌‍‌​‌‌​​‌​﻿‌‌‍‍​‌​﻿‌​﻿​​‌​﻿﻿‌‍​‍‌​‍﻿‌‌​​‌‍‍​‌‍‍​​﻿‌​‌‍‌‌‌​​‌‌﻿‌‍‌​​﻿‌​‍‍‌‍‌‌​‍‌‍‌﻿‌​​﻿﻿‌‌‍​‌​‍​‍​‍﻿​​‍​‍‌﻿‌​‌﻿‍‌‌﻿​​‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌﻿‌​‌‍‌‌‌﻿‍​‌﻿‌​​‍​‍​‍﻿​​‍​‍‌‍‌​‌‍​‌‌﻿‌​‌‍​‌​‍​‍​﻿‍‍​‍​‍‌‍‌​‌‍‌‌‌﻿​﻿‌‍​﻿‌﻿​‍‌‍‍‌‌﻿​​‌﻿‌​‌‍‍‌‌‍﻿﻿‌‍﻿‍​‍​‍‌﻿﻿‌](images/the-foundations-of-the-frontend-cloud-vercel/img_008.jpg)![A headless frontend can be attached to your backend via a middleware layer that interprets backend data for the frontend and vice versa.​​​​‌﻿‍﻿​‍​‍‌‍﻿﻿‌﻿​‍‌‍‍‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍​‍​‍﻿​​‍​‍‌‍‍​‌﻿​‍‌‍‌‌‌‍‌‍​‍​‍​﻿‍‍​‍​‍​‍﻿﻿‌‍​‌‌﻿​​‌‍‍‌​‍﻿﻿‌‍​‍‌‍﻿​‌‍﻿﻿‌‍‌﻿​‍﻿﻿‌‍‌‌‌‍‌​‌‍‍‌‌﻿‌​​﻿﻿﻿‌‍‌‌​﻿﻿‌​﻿​﻿‌​﻿﻿‌﻿‌‌‌‍‌​‌‌​​‌​﻿‌‌‍‍​‌​﻿‌​﻿​​‌​﻿﻿‌‍​‍‌​‍﻿‌‌​​‌‍‍​‌‍‍​​﻿‌​‌‍‌‌‌​​‌‌﻿‌‍‌​​﻿‌​‍‍‌‍‌‌​‍‌‍‌﻿‌​​﻿﻿‌‌‍​‌​‍​‍​‍﻿​​‍​‍‌﻿‌​‌﻿‍‌‌﻿​​‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌﻿‌​‌‍‌‌‌﻿‍​‌﻿‌​​‍​‍​‍﻿​​‍​‍‌‍‌​‌‍​‌‌﻿‌​‌‍​‌​‍​‍​﻿‍‍​‍​‍‌‍‌​‌‍‌‌‌﻿​﻿‌‍​﻿‌﻿​‍‌‍‍‌‌﻿​​‌﻿‌​‌‍‍‌‌‍﻿﻿‌‍﻿‍​‍​‍‌﻿﻿‌](images/the-foundations-of-the-frontend-cloud-vercel/img_009.jpg)![A headless frontend can be attached to your backend via a middleware layer that interprets backend data for the frontend and vice versa.​​​​‌﻿‍﻿​‍​‍‌‍﻿﻿‌﻿​‍‌‍‍‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍​‍​‍﻿​​‍​‍‌‍‍​‌﻿​‍‌‍‌‌‌‍‌‍​‍​‍​﻿‍‍​‍​‍​‍﻿﻿‌‍​‌‌﻿​​‌‍‍‌​‍﻿﻿‌‍​‍‌‍﻿​‌‍﻿﻿‌‍‌﻿​‍﻿﻿‌‍‌‌‌‍‌​‌‍‍‌‌﻿‌​​﻿﻿﻿‌‍‌‌​﻿﻿‌​﻿​﻿‌​﻿﻿‌﻿‌‌‌‍‌​‌‌​​‌​﻿‌‌‍‍​‌​﻿‌​﻿​​‌​﻿﻿‌‍​‍‌​‍﻿‌‌​​‌‍‍​‌‍‍​​﻿‌​‌‍‌‌‌​​‌‌﻿‌‍‌​​﻿‌​‍‍‌‍‌‌​‍‌‍‌﻿‌​​﻿﻿‌‌‍​‌​‍​‍​‍﻿​​‍​‍‌﻿‌​‌﻿‍‌‌﻿​​‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌﻿‌​‌‍‌‌‌﻿‍​‌﻿‌​​‍​‍​‍﻿​​‍​‍‌‍‌​‌‍​‌‌﻿‌​‌‍​‌​‍​‍​﻿‍‍​‍​‍‌‍‌​‌‍‌‌‌﻿​﻿‌‍​﻿‌﻿​‍‌‍‍‌‌﻿​​‌﻿‌​‌‍‍‌‌‍﻿﻿‌‍﻿‍​‍​‍‌﻿﻿‌](images/the-foundations-of-the-frontend-cloud-vercel/img_010.jpg)A headless frontend can be attached to your backend via a middleware layer that interprets backend data for the frontend and vice versa.​​​​‌﻿‍﻿​‍​‍‌‍﻿﻿‌﻿​‍‌‍‍‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍​‍​‍﻿​​‍​‍‌‍‍​‌﻿​‍‌‍‌‌‌‍‌‍​‍​‍​﻿‍‍​‍​‍​‍﻿﻿‌‍​‌‌﻿​​‌‍‍‌​‍﻿﻿‌‍​‍‌‍﻿​‌‍﻿﻿‌‍‌﻿​‍﻿﻿‌‍‌‌‌‍‌​‌‍‍‌‌﻿‌​​﻿﻿﻿‌‍‌‌​﻿﻿‌​﻿​﻿‌​﻿﻿‌﻿‌‌‌‍‌​‌‌​​‌​﻿‌‌‍‍​‌​﻿‌​﻿​​‌​﻿﻿‌‍​‍‌​‍﻿‌‌​​‌‍‍​‌‍‍​​﻿‌​‌‍‌‌‌​​‌‌﻿‌‍‌​​﻿‌​‍‍‌‍‌‌​‍‌‍‌﻿‌​​﻿﻿‌‌‍​‌​‍​‍​‍﻿​​‍​‍‌﻿‌​‌﻿‍‌‌﻿​​‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌﻿‌​‌‍‌‌‌﻿‍​‌﻿‌​​‍​‍​‍﻿​​‍​‍‌‍‌​‌‍​‌‌﻿‌​‌‍​‌​‍​‍​﻿‍‍​‍​‍‌‍‌​‌‍‌‌‌﻿​﻿‌‍​﻿‌﻿​‍‌‍‍‌‌﻿​​‌﻿‌​‌‍‍‌‌‍﻿﻿‌‍﻿‍​‍​‍‌﻿﻿‌

然而，一旦前端与后端解耦，您便有机会将其迁移至前端框架中——这使您能够直接在前端代码中编写连接后端的 API，或以其他方式[直接访问后端数据](https://vercel.com/blog/understanding-react-server-components#improved-data-fetching-with-next.js)。

## Why fit your frontend into a framework?  
## 为何要将前端纳入框架？

After decoupling your frontend, you’ll find yourself still with thousands of options for how to build out your architecture.

前端解耦之后，你仍会面临成千上万种架构构建方案可供选择。

A framework, like [Next.js](https://nextjs.org/), [Nuxt](https://nuxt.com/), or [SvelteKit](https://kit.svelte.dev/), offers sensible defaults for your underlying code (in this case written in React, Vue, and Svelte respectively).

像 [Next.js](https://nextjs.org/)、[Nuxt](https://nuxt.com/) 或 [SvelteKit](https://kit.svelte.dev/) 这样的框架，为底层代码（此处分别基于 React、Vue 和 Svelte 编写）提供了合理且开箱即用的默认配置。

The most popular frameworks are _open-source_ and _continually updated_ by the communities surrounding them. When you use a framework, you get the latest and best optimizations from the tech community available to you to use.

目前最主流的框架均为**开源项目**，并由其背后的活跃社区持续维护与更新。当你采用某一框架时，即可直接享用技术社区所提供的最新、最优的性能优化能力。

If words like “latest optimizations” immediately send you into panic about updating your codebase all the time, we understand. That’s why the best frontend clouds also support legacy versions of your favorite frameworks, until your whole team is ready to upgrade.

若“最新优化”这类表述让你立刻联想到频繁升级代码库而心生焦虑——我们完全理解。正因如此，顶尖的前端云平台（Frontend Cloud）同样支持你所钟爱框架的旧版本，直至整个团队都已准备就绪，再平滑升级。

The [framework you choose](https://vercel.com/docs/frameworks) ideally has this mix: open-source with large and stable backing.

你所选用的[框架](https://vercel.com/docs/frameworks)理想状态下应兼具两大特质：开源属性，以及庞大而稳定的社区或组织支持。

![Vercel's Frontend Cloud supports a high variety of frameworks. Here are just a few.​​​​‌﻿‍﻿​‍​‍‌‍﻿﻿‌﻿​‍‌‍‍‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍​‍​‍﻿​​‍​‍‌‍‍​‌﻿​‍‌‍‌‌‌‍‌‍​‍​‍​﻿‍‍​‍​‍​‍﻿﻿‌‍​‌‌﻿​​‌‍‍‌​‍﻿﻿‌‍​‍‌‍﻿​‌‍﻿﻿‌‍‌﻿​‍﻿﻿‌‍‌‌‌‍‌​‌‍‍‌‌﻿‌​​﻿﻿﻿‌‍‌‌​﻿﻿‌​﻿‌‌‌‌‌​‌﻿‍‌‌‍‌‌‌‍‌‍​﻿​﻿‌‌‌‌‌‍‍‍‌﻿‍‍​﻿​‌‌​‌﻿‌‍﻿‍​﻿​﻿​﻿​​‌‌​﻿‌​‌‍‌﻿​‍‌‍‌‍‌​‌‌‌﻿​‍‌﻿​‌‌​﻿﻿​‍‌‍‌﻿‌​​﻿﻿‌‌‍​‌​‍​‍​‍﻿​​‍​‍‌﻿‌​‌﻿‍‌‌﻿​​‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌﻿‌​‌‍‌‌‌﻿‍​‌﻿‌​​‍​‍​‍﻿​​‍​‍‌‍‌​‌‍​‌‌﻿‌​‌‍​‌​‍​‍​﻿‍‍​‍​‍‌‍‌​‌‍‌‌‌﻿​﻿‌‍​﻿‌﻿​‍‌‍‍‌‌﻿​​‌﻿‌​‌‍‍‌‌‍﻿﻿‌‍﻿‍​‍​‍‌﻿﻿‌](images/the-foundations-of-the-frontend-cloud-vercel/img_011.jpg)![Vercel's Frontend Cloud supports a high variety of frameworks. Here are just a few.​​​​‌﻿‍﻿​‍​‍‌‍﻿﻿‌﻿​‍‌‍‍‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍​‍​‍﻿​​‍​‍‌‍‍​‌﻿​‍‌‍‌‌‌‍‌‍​‍​‍​﻿‍‍​‍​‍​‍﻿﻿‌‍​‌‌﻿​​‌‍‍‌​‍﻿﻿‌‍​‍‌‍﻿​‌‍﻿﻿‌‍‌﻿​‍﻿﻿‌‍‌‌‌‍‌​‌‍‍‌‌﻿‌​​﻿﻿﻿‌‍‌‌​﻿﻿‌​﻿‌‌‌‌‌​‌﻿‍‌‌‍‌‌‌‍‌‍​﻿​﻿‌‌‌‌‌‍‍‍‌﻿‍‍​﻿​‌‌​‌﻿‌‍﻿‍​﻿​﻿​﻿​​‌‌​﻿‌​‌‍‌﻿​‍‌‍‌‍‌​‌‌‌﻿​‍‌﻿​‌‌​﻿﻿​‍‌‍‌﻿‌​​﻿﻿‌‌‍​‌​‍​‍​‍﻿​​‍​‍‌﻿‌​‌﻿‍‌‌﻿​​‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌﻿‌​‌‍‌‌‌﻿‍​‌﻿‌​​‍​‍​‍﻿​​‍​‍‌‍‌​‌‍​‌‌﻿‌​‌‍​‌​‍​‍​﻿‍‍​‍​‍‌‍‌​‌‍‌‌‌﻿​﻿‌‍​﻿‌﻿​‍‌‍‍‌‌﻿​​‌﻿‌​‌‍‍‌‌‍﻿﻿‌‍﻿‍​‍​‍‌﻿﻿‌](images/the-foundations-of-the-frontend-cloud-vercel/img_012.jpg)![Vercel's Frontend Cloud supports a high variety of frameworks. Here are just a few.​​​​‌﻿‍﻿​‍​‍‌‍﻿﻿‌﻿​‍‌‍‍‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍​‍​‍﻿​​‍​‍‌‍‍​‌﻿​‍‌‍‌‌‌‍‌‍​‍​‍​﻿‍‍​‍​‍​‍﻿﻿‌‍​‌‌﻿​​‌‍‍‌​‍﻿﻿‌‍​‍‌‍﻿​‌‍﻿﻿‌‍‌﻿​‍﻿﻿‌‍‌‌‌‍‌​‌‍‍‌‌﻿‌​​﻿﻿﻿‌‍‌‌​﻿﻿‌​﻿‌‌‌‌‌​‌﻿‍‌‌‍‌‌‌‍‌‍​﻿​﻿‌‌‌‌‌‍‍‍‌﻿‍‍​﻿​‌‌​‌﻿‌‍﻿‍​﻿​﻿​﻿​​‌‌​﻿‌​‌‍‌﻿​‍‌‍‌‍‌​‌‌‌﻿​‍‌﻿​‌‌​﻿﻿​‍‌‍‌﻿‌​​﻿﻿‌‌‍​‌​‍​‍​‍﻿​​‍​‍‌﻿‌​‌﻿‍‌‌﻿​​‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌﻿‌​‌‍‌‌‌﻿‍​‌﻿‌​​‍​‍​‍﻿​​‍​‍‌‍‌​‌‍​‌‌﻿‌​‌‍​‌​‍​‍​﻿‍‍​‍​‍‌‍‌​‌‍‌‌‌﻿​﻿‌‍​﻿‌﻿​‍‌‍‍‌‌﻿​​‌﻿‌​‌‍‍‌‌‍﻿﻿‌‍﻿‍​‍​‍‌﻿﻿‌](images/the-foundations-of-the-frontend-cloud-vercel/img_013.jpg)![Vercel's Frontend Cloud supports a high variety of frameworks. Here are just a few.​​​​‌﻿‍﻿​‍​‍‌‍﻿﻿‌﻿​‍‌‍‍‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍​‍​‍﻿​​‍​‍‌‍‍​‌﻿​‍‌‍‌‌‌‍‌‍​‍​‍​﻿‍‍​‍​‍​‍﻿﻿‌‍​‌‌﻿​​‌‍‍‌​‍﻿﻿‌‍​‍‌‍﻿​‌‍﻿﻿‌‍‌﻿​‍﻿﻿‌‍‌‌‌‍‌​‌‍‍‌‌﻿‌​​﻿﻿﻿‌‍‌‌​﻿﻿‌​﻿‌‌‌‌‌​‌﻿‍‌‌‍‌‌‌‍‌‍​﻿​﻿‌‌‌‌‌‍‍‍‌﻿‍‍​﻿​‌‌​‌﻿‌‍﻿‍​﻿​﻿​﻿​​‌‌​﻿‌​‌‍‌﻿​‍‌‍‌‍‌​‌‌‌﻿​‍‌﻿​‌‌​﻿﻿​‍‌‍‌﻿‌​​﻿﻿‌‌‍​‌​‍​‍​‍﻿​​‍​‍‌﻿‌​‌﻿‍‌‌﻿​​‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌﻿‌​‌‍‌‌‌﻿‍​‌﻿‌​​‍​‍​‍﻿​​‍​‍‌‍‌​‌‍​‌‌﻿‌​‌‍​‌​‍​‍​﻿‍‍​‍​‍‌‍‌​‌‍‌‌‌﻿​﻿‌‍​﻿‌﻿​‍‌‍‍‌‌﻿​​‌﻿‌​‌‍‍‌‌‍﻿﻿‌‍﻿‍​‍​‍‌﻿﻿‌](images/the-foundations-of-the-frontend-cloud-vercel/img_014.jpg)Vercel's Frontend Cloud supports a high variety of frameworks. Here are just a few.​​​​‌﻿‍﻿​‍​‍‌‍﻿﻿‌﻿​‍‌‍‍‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍​‍​‍﻿​​‍​‍‌‍‍​‌﻿​‍‌‍‌‌‌‍‌‍​‍​‍​﻿‍‍​‍​‍​‍﻿﻿‌‍​‌‌﻿​​‌‍‍‌​‍﻿﻿‌‍​‍‌‍﻿​‌‍﻿﻿‌‍‌﻿​‍﻿﻿‌‍‌‌‌‍‌​‌‍‍‌‌﻿‌​​﻿﻿﻿‌‍‌‌​﻿﻿‌​﻿‌‌‌‌‌​‌﻿‍‌‌‍‌‌‌‍‌‍​﻿​﻿‌‌‌‌‌‍‍‍‌﻿‍‍​﻿​‌‌​‌﻿‌‍﻿‍​﻿​﻿​﻿​​‌‌​﻿‌​‌‍‌﻿​‍‌‍‌‍‌​‌‌‌﻿​‍‌﻿​‌‌​﻿﻿​‍‌‍‌﻿‌​​﻿﻿‌‌‍​‌​‍​‍​‍﻿​​‍​‍‌﻿‌​‌﻿‍‌‌﻿​​‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌﻿‌​‌‍‌‌‌﻿‍​‌﻿‌​​‍​‍​‍﻿​​‍​‍‌‍‌​‌‍​‌‌﻿‌​‌‍​‌​‍​‍​﻿‍‍​‍​‍‌‍‌​‌‍‌‌‌﻿​﻿‌‍​﻿‌﻿​‍‌‍‍‌‌﻿​​‌﻿‌​‌‍‍‌‌‍﻿﻿‌‍﻿‍​‍​‍‌﻿﻿‌

Vercel 的前端云（Frontend Cloud）支持种类繁多的框架。以下仅列举其中几例。

Frameworks help you build faster, onboard faster, and provide rules that others can be familiar with before ever joining your company. **The more standardized your codebase, the easier it is to onboard new and existing talent to build it.**

框架能助你加速开发、加速团队成员上手，并提供一套他人在加入公司前便已熟悉的规范体系。**你的代码库越标准化，就越容易让新老开发者快速上手并参与构建。**

Frameworks also come with their own ecosystems of third-party plugins (usually open-source) that work natively within the code. Conforming to standard practices benefits you in the sheer number of good tools you can choose from.

框架还自带丰富的第三方插件生态（通常为开源项目），这些插件可原生集成于框架代码中。遵循标准实践，意味着你能从海量优质工具中自由遴选，大幅提升开发效率与灵活性。

Since frontend clouds rely so heavily on open-source labor, they should ideally be invested in [upholding open-source frameworks and tools](https://vercel.com/oss).

鉴于前端云高度依赖开源协作模式，它们理应积极投入资源，致力于[维护与支持开源框架及工具](https://vercel.com/oss)。

That’s all only one part of the framework story, though. The other is this: frameworks give a _predictable build output_. In other words, no matter how different your, for example, SvelteKit project might be from another SvelteKit project, both will build into code that has identical patterns.

然而，这仅是框架价值的一个方面；另一关键优势在于：框架能生成**可预测的构建输出**。换言之，即便你的 SvelteKit 项目与另一个 SvelteKit 项目在功能、规模或实现细节上迥然不同，二者最终构建出的产物仍将遵循完全一致的代码结构与模式。

This is crucial for the Vercel Frontend Cloud’s true differentiator from other solutions: automatic infra.

这正是 Vercel 前端云（Frontend Cloud）区别于其他方案的核心优势：自动化的基础设施（automatic infra）。

## What is automatically provisioned infrastructure?

## 什么是自动配置的基础设施？

If your frontend framework can provide a predictable and standardized output, that means the infrastructure that handles deploying your frontend can _also_ be standardized. In frontend-cloud terminology, we refer to this practice as [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure) [(FdI)](https://vercel.com/blog/framework-defined-infrastructure).

如果你的前端框架能生成可预测、标准化的构建输出，那么用于部署该前端的基础设施也就能实现标准化。在前端云术语中，我们将这一实践称为[框架定义的基础设施（Framework-Defined Infrastructure, FdI）](https://vercel.com/blog/framework-defined-infrastructure)。

![Flowchart showing the process from user code to automatically inferred infrastructure.](images/the-foundations-of-the-frontend-cloud-vercel/img_015.jpg)![Flowchart showing the process from user code to automatically inferred infrastructure.](images/the-foundations-of-the-frontend-cloud-vercel/img_016.jpg)Flowchart showing the process from user code to automatically inferred infrastructure.

![展示从用户代码到自动推导出基础设施的流程图。](images/the-foundations-of-the-frontend-cloud-vercel/img_015.jpg)![展示从用户代码到自动推导出基础设施的流程图。](images/the-foundations-of-the-frontend-cloud-vercel/img_016.jpg)展示从用户代码到自动推导出基础设施的流程图。

In FdI, every time you build within your [framework of choice](https://vercel.com/docs/frameworks#list-of-supported-frameworks), the Frontend Cloud _automatically provides_ _all needed frontend infrastructure_ to successfully deliver your application to the world.

在 FdI 模式下，每次你在所选的[前端框架](https://vercel.com/docs/frameworks#list-of-supported-frameworks)中执行构建，前端云都会**自动提供运行应用所需的所有前端基础设施**，从而确保你的应用顺利交付至全球用户。

Builds in the frontend cloud are _also_ a managed process, [tied directly to your repository’s git pushes](https://vercel.com/blog/framework-defined-infrastructure#framework-defined-infrastructure-and-immutable-deployments).

前端云中的构建本身也是一种受管流程，[直接与你代码仓库的 Git 推送操作绑定](https://vercel.com/blog/framework-defined-infrastructure#framework-defined-infrastructure-and-immutable-deployments)。

This automated, managed infrastructure differentiates the Frontend Cloud from more traditional hosting services. Since infrastructure is built _according to_ the output of your code, it performs as efficiently as possible.

这种自动化且受管的基础设施，使前端云显著区别于更传统的托管服务。由于基础设施是**严格依据你的代码输出来构建的**，因此其运行效率达到最优。

Every [service the Frontend Cloud provides](https://vercel.com/docs/all-products) is therefore _native_ to your framework, and you can access its features simply by writing framework code.

因此，前端云提供的每一项[服务](https://vercel.com/docs/all-products)都原生适配你的框架——你只需编写符合框架规范的代码，即可直接使用这些功能。

If you can do it in your chosen framework, there’s automatic infra for it.

只要你的所选框架支持某项能力，前端云就为其提供对应的自动化基础设施支持。

## What is serverless architecture?

## 什么是无服务器架构（Serverless Architecture）？

FdI is powered by serverless architecture. Let's break down how.

FdI 采用无服务器（serverless）架构。下面我们来详细解析其工作原理。

_Serverless_ refers to a method of building and operating apps where developers don’t have to manage their own servers. Instead, devs focus on writing and deploying code, while cloud providers handle the allocation of resources based on that code—like servers, databases, and other in-memory storage—needed to run apps at _any_ given scale.

“无服务器”（_Serverless_）指的是一种构建和运行应用程序的方法，开发者无需自行管理服务器。相反，开发者只需专注于编写和部署代码；而云服务提供商则根据这些代码，自动分配运行应用所需的各类资源——例如服务器、数据库及其他内存存储——从而支持应用在_任意_规模下的运行。

**Serverless only provisions server resources when users are actively making requests** _**.**_ Times of no traffic cost nothing, and times of high traffic get automatically managed without your intervention.

**无服务器架构仅在用户实际发起请求时才分配服务器资源** _**。**_ 在无流量时段，不产生任何费用；而在高流量时段，则无需人工干预，系统即可自动完成扩容与资源调度。

Compare that to developers using serverful architecture, who have to update and maintain each container they deploy, including its system settings and dependencies. Scaling containers often requires using some kind of orchestration platform like Kubernetes, while serverless scaling is a fully automatic affair.

相比之下，采用传统有服务器（serverful）架构的开发者，必须手动更新和维护每一个已部署的容器，包括其系统配置和依赖项。容器的扩缩容通常还需借助 Kubernetes 等编排平台；而无服务器架构的扩缩容则是完全自动化的。

Vercel's infrastructure scales automatically based on demand.

Vercel 的基础设施可根据实际需求自动伸缩。

So, how does it work?

那么，它具体是如何运作的呢？

Instead of servers sitting separately from the application, waiting to get used, serverless code is executed as needed in response to events such as HTTP requests, changes in database state, or user activity.

与传统模式中服务器独立于应用、长期空闲待命不同，无服务器代码仅在需要时才执行——即响应各类事件，例如 HTTP 请求、数据库状态变更或用户行为等。

This means that [serverless functions](https://vercel.com/docs/functions/serverless-functions) are:

这意味着，[无服务器函数](https://vercel.com/docs/functions/serverless-functions) 具有以下特性：

- **Stateless:** They don’t store context between runs, though they _can_ retrieve persistent data from external sources.

- **无状态（Stateless）：** 函数在各次执行之间不保存上下文；但_可以_从外部数据源读取持久化数据。

- **Isolated:** Every function is defined independently to perform its intended task.

- **隔离性（Isolated）：** 每个函数均被独立定义，专用于完成其特定任务。

- **Event-driven:** They’re _only_ triggered when called. This means there is _no_ concept of a server being over- or under-provisioned.

- **事件驱动：** 它们 _仅在被调用时_ 触发。这意味着根本不存在服务器“过度配置”或“配置不足”的概念。

### Why is the Frontend Cloud serverless?

### 为何前端云（Frontend Cloud）是无服务器的？

When you run a serverless, [decoupled frontend](https://vercel.com/blog/the-foundations-of-the-frontend-cloud#why-decouple-the-frontend-from-the-backend) that doesn't need to store its own persistent data, that frontend is far more predictable and easier to unit test.

当你运行一个无服务器的、[解耦的前端](https://vercel.com/blog/the-foundations-of-the-frontend-cloud#why-decouple-the-frontend-from-the-backend)（该前端无需自行存储持久化数据）时，该前端的行为将更加可预测，也更易于进行单元测试。

Functionality doesn't have hard-to-trace side effects or mutations over time—each run of a serverless function is executed from that function's initial state.

其功能不会随时间推移产生难以追踪的副作用或状态变更——每次执行无服务器函数，都是从该函数的初始状态开始运行。

This is why serverless can scale down to zero when unused. It's also how the management of serverless functions—their deployment, execution, scaling, and termination—can be automatically orchestrated in response to external events.

这正是无服务器架构可在闲置时自动缩容至零的原因；同样，也正是基于这一特性，无服务器函数的部署、执行、扩缩容与终止等全生命周期管理，才能对外部事件做出自动响应与编排。

In the context of FdI, the Frontend Cloud provisions specific, immutable infrastructure for each run of a serverless function.

在前端即基础设施（FdI）的语境下，前端云为每一次无服务器函数的运行，提供专属且不可变的基础设施。

Because the function is self-encapsulated, the infrastructure knows exactly what needs to happen for that function to succeed, and you can code within your framework without worrying about _any_ infrastructure.

由于函数本身是自包含的，底层基础设施完全知晓该函数成功运行所需的一切条件；因此，你可以在所选框架内专注编码，而无需操心 _任何_ 基础设施细节。

This makes serverless faster to develop, easier to manage, and better for developer and user experience alike.

这使得无服务器开发更加快速、运维更加简便，同时显著提升了开发者体验与终端用户体验。

> “Frontend developers have always understood the power of the server for better end-user experiences and SEO, but so often a globally distributed edge network has been prohibitive for everyone but the largest companies. Now, with innovations like serverless data and React Server Components, we’re seeing the industry shift back to what made the web great to begin with: faster, more personalized experiences.​​​​‌‍​‍​‍‌‍Frontend developers have always understood the power of the server for better end-user experiences and SEO, but so often a globally distributed edge network has been prohibitive for everyone but the largest companies. Now, with innovations like serverless data and React Server Components, we’re seeing the industry shift back to what made the web great to begin with: faster, more personalized experiences.​​​​‌‍​‍​‍‌‍”
>
> “前端开发者始终深知服务器对于提升终端用户体验和搜索引擎优化（SEO）的强大价值；然而，过去一个全球分布式的边缘网络，往往只对极少数头部企业可行，对绝大多数团队而言成本高昂、门槛过高。如今，随着无服务器数据（serverless data）与 React 服务端组件（React Server Components）等创新技术的出现，整个行业正回归 Web 最初的伟大本质：更快、更个性化的用户体验。”
>
> ![](images/the-foundations-of-the-frontend-cloud-vercel/img_017.jpg)
>
> **Guillermo Rauch,** Vercel CEO
>
> **吉列尔莫·劳赫（Guillermo Rauch），Vercel 首席执行官**

[In the next article](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud), we'll explore how the Frontend Cloud dramatically lifts user experience and allows for performant personalization at a global scale—by bringing all infrastructure into a cohesive and secure environment, complete with a robust caching architecture.

[在下一篇文章中](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud)，我们将深入探讨前端云如何显著提升用户体验，并在全球范围内实现高性能的个性化交付——其核心在于将所有基础设施整合进一个统一、安全的环境，并配备强大而稳健的缓存架构。

[![Lee Robinson](images/the-foundations-of-the-frontend-cloud-vercel/img_018.jpg)](https://x.com/leerob/status/1707443239630835805)

[李·罗宾逊（Lee Robinson）](https://x.com/leerob/status/1707443239630835805)


· [关注](https://x.com/intent/follow?screen_name=leerob)

在 Twitter 上查看原文

frontend is easy

前端很简单

[![一张冰山梗图，共分八层，从水面之上延伸至深海之下。随着层级不断下潜，前端问题也愈发小众且令人痛苦。例如，最顶层是基础 HTML 元素；而最底层则包括为库代码编写的 TypeScript 类型，或是在 2023 年还要兼容 Internet Explorer 这类棘手场景。](images/the-foundations-of-the-frontend-cloud-vercel/img_019.jpg)](https://x.com/leerob/status/1707443239630835805)

[2023 年 9 月 28 日 下午 1:12](https://x.com/leerob/status/1707443239630835805) [Twitter 网站工具、广告信息与隐私政策](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[7.3K 次点赞](https://x.com/intent/like?tweet_id=1707443239630835805) [回复](https://x.com/intent/tweet?in_reply_to=1707443239630835805)


[阅读 208 条回复](https://x.com/leerob/status/1707443239630835805)

Vercel.com 首页

### Learn more

### 了解更多

Vercel.com landing page

Vercel.com 着陆页

### See for yourself

### 亲身体验