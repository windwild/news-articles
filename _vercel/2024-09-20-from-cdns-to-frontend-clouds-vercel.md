---
title: "From CDNs to Frontend Clouds - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/from-cdns-to-frontend-clouds"
date: "2024-09-20"
scraped_at: "2026-03-02T09:41:04.288620586+00:00"
language: "en-zh"
translated: true
description: "Content Delivery Networks (CDNs) and Infrastructure as code (IaC) evolved into the next generation of web application delivery."
---

render_with_liquid: false
Sep 20, 2024

2024 年 9 月 20 日

How UX demands and DIY infrastructure headaches shaped the next generation of web application delivery

用户体验需求与自建基础设施的种种痛点，如何塑造了下一代 Web 应用交付方式

Web apps today are judged on six core principles: **speed**, **global presence**, **scalability**, **dynamism**, **reliability**, and **security**. Users and businesses now expect excellence in all six categories, making them non-negotiable.

如今，Web 应用的表现由六大核心原则来评判：**速度**、**全球覆盖能力**、**可扩展性**、**动态性**、**可靠性** 和 **安全性**。用户与企业如今对这六个维度均抱有卓越表现的期待，使其成为不可妥协的基本要求。

As user experiences have become more engaging and dynamic, the limitations of Content Delivery Networks (CDNs) and Infrastructure as Code (IaC)—once the industry standards for application delivery—are becoming increasingly apparent.

随着用户体验日趋丰富与动态化，曾作为应用交付行业标准的内容分发网络（CDN）与基础设施即代码（IaC），其固有局限正日益凸显。

CDNs, designed for static content, fail to meet the demands of modern, interactive and real-time web applications. At the same time, while IaC enables programmatic management, its use for web applications often leads to building undifferentiated tooling and systems rather than dedicating those resources to more bespoke, complex infrastructure challenges.

CDN 原本专为静态内容而设计，难以满足现代交互式、实时 Web 应用的严苛需求。与此同时，尽管 IaC 支持基础设施的编程化管理，但将其用于 Web 应用时，往往导致团队耗费大量精力构建同质化、通用型工具与系统，而非将宝贵资源投入到更具定制性、更复杂的基础设施挑战中。

These technologies have not kept pace with the evolving web, leading to an emerging and compelling solution: [frontend clouds](https://vercel.com/blog/the-foundations-of-the-frontend-cloud) that abstract away complex infrastructure, enabling next-generation content, experiences, and application delivery. This shift allows developers to focus on what truly matters—innovating to enhance web applications, drive business value, and delight users.

这些技术未能跟上 Web 的演进步伐，由此催生出一种新兴且极具吸引力的解决方案：[前端云（frontend clouds）](https://vercel.com/blog/the-foundations-of-the-frontend-cloud)——它将复杂基础设施抽象化，赋能新一代内容、体验与应用的交付。这一范式转变使开发者得以聚焦于真正关键之事：通过创新持续提升 Web 应用能力、驱动业务价值，并为用户带来惊喜。

## **From a static to dynamic web**

## **从静态 Web 到动态 Web**

When we first started putting our businesses online, the web was a set of static brochures. We didn't have interactivity or complex routing logic, content wasn't frequently updated, and sites were controlled by a single person—the webmaster.

最初我们将业务搬上互联网时，Web 本质上是一系列静态宣传册：没有交互能力，也无复杂的路由逻辑；内容更新频率极低；整个网站由一个人——“网站管理员（webmaster）”——全权掌控。

![](images/from-cdns-to-frontend-clouds-vercel/img_001.jpg)![](images/from-cdns-to-frontend-clouds-vercel/img_002.jpg)

![](images/from-cdns-to-frontend-clouds-vercel/img_001.jpg)![](images/from-cdns-to-frontend-clouds-vercel/img_002.jpg)

With the rise of JavaScript, along with tools like jQuery to simplify it and AJAX for browser-to-backend communication, the web became more dynamic and complex, and the webmaster role split into two distinct positions: one focused on user experiences and the other on systems infrastructure.

随着 JavaScript 的兴起，以及 jQuery 等简化开发的工具、AJAX 等实现浏览器与后端通信的技术普及，Web 变得愈发动态与复杂，“网站管理员”这一角色也随之分化为两个截然不同的职能方向：一个专注于用户体验（UX），另一个则聚焦于系统基础设施。

Later, as sites became true digital storefronts and interactive marketplaces, frameworks like Django, Laravel, and Ruby on Rails streamlined development but required more understanding of server-side concepts. Once again, functionalities split. We saw the rise of _frontend_ and _backend_ specialities, and organizations had to staff these roles as well as the connective tissue between them (e.g. DevOps).

后来，随着网站演变为真正的数字门店和交互式市场，Django、Laravel 和 Ruby on Rails 等框架简化了开发流程，但也要求开发者更深入地理解服务端概念。功能再次分化：我们见证了 _前端_ 与 _后端_ 专业方向的兴起；企业不仅需要配备这两类岗位人员，还需配置连接二者的关键角色（例如 DevOps）。

The growth and efficacy of traditional CDNs, which became the industry standard for static sites and assets, leveled off as web _sites_ evolved into dynamic web _apps_. While still vital for static content, they struggled with frequently updated, real-time, and dynamic data. The tools for managing and delivering web applications lagged behind the growing demands of the frontend.

随着网页 _站点_（sites）逐步演进为动态网页 _应用_（apps），传统 CDN 的增长势头与实际效能趋于停滞——尽管它们已成为静态站点与静态资源交付的行业标准。虽然 CDN 对静态内容依然至关重要，但在应对高频更新、实时性与动态数据方面却力不从心。用于管理与交付 Web 应用的工具，远远落后于前端日益增长的需求。

For dynamic web apps using server-side rendering (SSR) and databases, developers often rely on CDNs and set high `Cache-Control TTLs` for faster delivery. However, this leads to caching entire groups of pages, requiring frequent data changes to be handled through slow and unreliable purges, leading to inconsistent content—users may see outdated information or miss their own updates. Even with advanced settings like Vary headers and surrogate keys, the cache remains too static, causing high cache misses.

对于采用服务端渲染（SSR）与数据库的动态 Web 应用，开发者常依赖 CDN，并设置较高的 `Cache-Control TTL` 值以加速内容交付。然而，这会导致整组页面被缓存；当数据频繁变更时，只能通过缓慢且不可靠的缓存清除（purge）机制来应对，从而引发内容不一致问题——用户可能看到过期信息，或无法及时看到自己刚提交的更新。即便启用 Vary 头部、代理键（surrogate keys）等高级配置，缓存本身仍过于静态，导致极高的缓存未命中率（cache misses）。

Local development with CDNs can also be challenging, as it can't be run on localhost. This makes it difficult to fully preview and test cache-control strategies, such as how assets are cached and invalidated globally. Without a staging or preview environment that mirrors real-world CDN behavior, developers can encounter the same issues described earlier—stale content, cache misses, or incorrect purging once the app is deployed. This lack of control over real-time caching strategies further complicates delivering dynamic content efficiently.

在本地开发中集成 CDN 同样颇具挑战，因其无法在 `localhost` 上运行。这使得开发者难以全面预览和测试缓存控制策略（例如资源如何在全球范围内被缓存与失效）。若缺乏能真实模拟生产环境 CDN 行为的预发布（staging）或预览（preview）环境，开发者在应用上线后，仍会遭遇前述相同问题——陈旧内容、高缓存未命中率，或错误的缓存清除操作。这种对实时缓存策略缺乏掌控的局面，进一步加剧了高效交付动态内容的难度。

Certain features—such as cache invalidation, CDN routing, or techniques like ESI (Edge Side Includes)—cannot be fully replicated locally. This limitation means that testing and previewing cache behavior must be done in a real environment (like a preview deployment), where the CDN's edge infrastructure is active. Without this, critical performance features won’t reproduce correctly in local environments. This leaves developers unable to manage or test these optimizations, which often live in the purview of another team. As a result, CDNs can feel like a form of "shipping the org chart," creating friction between development and infrastructure operations.

某些关键功能——例如缓存失效（cache invalidation）、CDN 路由，或边缘侧包含（ESI, Edge Side Includes）等技术——无法在本地环境中完整复现。这一限制意味着，缓存行为的测试与预览必须在真实环境中进行（例如预发布部署），即 CDN 的边缘基础设施处于活跃状态。缺少该环境，核心性能特性便无法在本地准确复现。这导致开发者既无法自主管理，也无法有效测试这些优化措施——而这些工作往往归属于另一支团队。结果是，CDN 的使用体验仿佛一种“按组织架构交付”（shipping the org chart），在开发与基础设施运维之间制造摩擦。

As a result, developers often turn to client-side solutions to handle personalization, real-time updates, and experimentation. By offloading these tasks to the client, the burden shifts to the user's device, which can lead to slower pages, layout shifts, and performance issues—especially on slower networks. In many cases, the server could have handled these dynamic elements more effectively, providing a faster and more consistent experience without shifting these tasks to the client.

因此，开发者常常转向客户端方案来处理个性化、实时更新与 A/B 实验等功能。将这些任务卸载至客户端，意味着负担转移至用户设备，可能导致页面加载变慢、布局偏移（layout shifts）及各类性能问题——尤其在网络条件较差时更为明显。事实上，在许多场景下，服务端本可更高效地处理这些动态元素，从而提供更快、更一致的用户体验，而无需将这些职责推给客户端。

Overall, despite aiming to create the best user experiences and deliver business value, companies often spend significant time and money on undifferentiated technology and infrastructure. Web application requirements introduced recurring challenges, including complex yet repetitive Infrastructure as Code (IaC) and associated steep learning curves, security concerns, and cost control. These issues led to duplicated efforts across the industry, leaving fewer resources to drive innovations that help businesses realize their goals and delight users.

总体而言，尽管企业致力于打造最佳用户体验并实现商业价值，却往往将大量时间与资金耗费在非差异化技术与基础设施上。Web 应用需求催生了一系列反复出现的挑战：包括复杂却高度重复的基础设施即代码（IaC）实践、陡峭的学习曲线、安全风险以及成本管控难题。这些问题导致整个行业出现大量重复建设，挤占了本可用于驱动创新的资源——而这些创新，恰恰是助力企业达成目标、取悦用户的关键所在。

### Meta-frameworks and the frontend engineer comeback

### 元框架与前端工程师的强势回归

JavaScript's (and its increasingly popular alternative, TypeScript's) capabilities continued to expand significantly—with tools like Node.js and React—giving rise to meta-frameworks like Next.js, Astro, Nuxt, SvelteKit, Remix, Vite, Gatsby and others. These advancements allow frontend developers to fully embrace full-stack development with features such as server-side rendering, static site generation, API routes, file-based routing, built-in CSS support, and more. Combined with a large community and ecosystem, these tools give developers the ability to efficiently manage both frontend and backend development, enhancing their control over the entire application stack.

JavaScript（及其日益流行的替代语言 TypeScript）的能力持续显著扩展——借助 Node.js、React 等工具，催生了 Next.js、Astro、Nuxt、SvelteKit、Remix、Vite、Gatsby 等一系列元框架（meta-frameworks）。这些进步使前端开发者得以全面拥抱全栈开发，支持服务端渲染（SSR）、静态站点生成（SSG）、API 路由、基于文件的路由、内置 CSS 支持等多种能力。加之庞大的社区与繁荣的生态系统，这些工具赋予开发者高效统筹前后端开发的能力，大幅提升其对整个应用技术栈的掌控力。

Tasks that once separated roles due to complexity became simpler, allowing frontend and backend responsibilities to merge back into a single but far more versatile frontend engineer role. These engineers, fluent in JavaScript and no longer constrained by the need to master multiple language, now managed a larger portion of the application stack without compromising quality or speed. This shift led to development teams with greater efficiency, faster iteration cycles, and more cohesive end-to-end user experiences.

过去因复杂度而割裂的职责，如今变得更为简单，促使前端与后端职责重新融合，汇聚为一个兼具广度与深度的全新角色——全能型前端工程师（frontend engineer）。这些工程师精通 JavaScript，不再受限于掌握多种编程语言的压力，因而能够承担起更大范围的应用技术栈管理工作，且不牺牲质量与交付速度。这一转变催生出效率更高、迭代周期更短、端到端用户体验更统一的开发团队。

## **The core principles of application delivery**

## **应用交付的核心原则**

One crucial piece of the puzzle remained: infrastructure.

拼图中至关重要的一块始终是基础设施。

While developers embraced modern frameworks and a full-stack approach, the infrastructure needed to support these applications often remained slow, complex, and fragmented.

尽管开发者已广泛采用现代框架和全栈开发模式，支撑这些应用的基础设施却常常依然迟缓、复杂且彼此割裂。

A silver lining through this period of intense investment in infrastructure was the development of key principles for application delivery. These principles, shaped by shared challenges and goals, were universally recognized by developers, infrastructure teams, and business leaders as essential for optimal user experiences and application delivery excellence:

在这一轮基础设施巨额投入期间，一个积极成果是应用交付核心原则的逐步形成。这些原则源于行业共同面临的挑战与目标，已被开发者、基础设施团队及业务领导者普遍认可——它们是实现卓越用户体验与应用交付成效不可或缺的基石：

- **Fast:** Applications must load quickly and respond to interactions instantaneously for globally dispersed users. This requires optimized and intelligent code, data handling, caching strategies, and distributed infrastructure.

- **快速：** 应用必须为全球分布的用户实现秒级加载，并对用户交互做出即时响应。这要求代码高度优化与智能化、数据处理高效、缓存策略精准，以及分布式基础设施的协同支撑。

- **Global**: Applications must be physically close to users worldwide to ensure minimal latency and maximum performance for all regions. This requires distributed infrastructure that leverages edge networks and nearby data centers.

- **全球化：** 应用需在物理位置上尽可能贴近全球各地用户，以确保最低延迟与各区域最高性能。这依赖于充分利用边缘网络与就近数据中心的分布式基础设施。

- **Scalable:** As user bases grow, applications must handle increased traffic without compromising performance. This means scalable infrastructure that can adapt to fluctuating demands.

- **可扩展：** 随着用户规模扩大，应用必须在不牺牲性能的前提下承载持续增长的流量。这意味着基础设施须具备弹性伸缩能力，以动态适应起伏不定的负载需求。

- **Dynamic:** Content should be fresh, engaging, and personalized for each user, whether dynamically updated or efficiently delivered as static content. This requires leveraging real-time data where applicable, implementing smart caching and revalidation strategies, and employing dynamic rendering techniques.

- **动态化：** 内容应对每位用户保持新鲜、引人入胜且高度个性化——无论通过实时动态更新，还是以高效率方式交付静态内容。这要求在适用场景下充分利用实时数据，实施智能缓存与再验证策略，并采用动态渲染技术。

- **Reliable:** Downtime is unacceptable. Users and businesses expect applications to be available and responsive 24/7. This demands robust infrastructure, fault-tolerant systems, and proactive monitoring.

- **高可靠：** 停机是不可接受的。用户与企业期望应用全天候（24/7）在线并保持响应能力。这需要构建强健的基础设施、具备容错能力的系统，以及主动式监控机制。

- **Secure:** Protecting user data and corporate IP is paramount. Applications and their underlying infrastructure must be built with comprehensive security measures to safeguard sensitive information at every level.

- **安全：** 保障用户数据与企业知识产权的安全性至关重要。应用及其底层基础设施必须从设计之初即集成全方位安全措施，确保敏感信息在每一层均得到严密防护。

Together, these core principles help organizations achieve **exceptional user experiences, unparalleled application performance, and a resilient foundation for future growth.**

上述核心原则协同作用，助力组织实现**卓越的用户体验、无与伦比的应用性能，以及面向未来增长的坚实基础。**

Despite substantial resources for each team, the complex interplay of frontend, backend, and infrastructure development made consistently achieving any or all of the six principles challenging, costly, complex, and sometimes seemingly impossible to implement.

尽管各团队均投入了大量资源，但前端、后端与基础设施开发之间错综复杂的相互影响，使得持续达成其中任一或全部六项原则变得极具挑战性、成本高昂、流程复杂，甚至在某些情况下看似无法实现。

## **Frontend clouds and framework-defined infrastructure**

## **前端云与框架定义的基础设施**

Frontend developers needed solutions to simplify deployments and manage infrastructure more easily, leading to the rise of _frontend clouds_. These platforms streamlined tooling and simplified deployment architectures, empowering developers to own end-to-end user experiences without the burdens and headaches of infrastructure.

前端开发者亟需能简化部署流程、更轻松管理基础设施的解决方案，由此催生了 _前端云（frontend clouds）_。这类平台统一了开发工具链，简化了部署架构，使开发者得以自主掌控端到端的用户体验，而无需承担基础设施带来的繁重负担与运维困扰。

Vercel's frontend cloud, for example, uses Framework Defined Infrastructure to generate and manage infrastructure outputs without any developer intervention. This abstraction frees developers from infrastructure concerns, allowing them to focus on innovation, differentiated user experiences, and **for the first time, consistently achieve all six core principles of application delivery: speed, global presence, scalability, dynamism, reliability, and security.**

以 Vercel 的前端云为例，其采用“框架定义的基础设施（Framework Defined Infrastructure）”技术，自动生成并管理基础设施输出，全程无需开发者介入。这一抽象层将开发者从基础设施的琐碎事务中解放出来，使其能够专注于创新、打造差异化的用户体验，并**首次实现对应用交付六大核心原则——速度、全球覆盖、可扩展性、动态性、可靠性与安全性——的持续、稳定达成。**

![](images/from-cdns-to-frontend-clouds-vercel/img_003.jpg)![](images/from-cdns-to-frontend-clouds-vercel/img_004.jpg)

![](images/from-cdns-to-frontend-clouds-vercel/img_003.jpg)![](images/from-cdns-to-frontend-clouds-vercel/img_004.jpg)

This desire to bridge the frontend-backend gap, fueled by JavaScript's full-stack capabilities and technologies like Vercel's [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure), requires deep integration of developer tools.

这种弥合前后端鸿沟的强烈诉求，得益于 JavaScript 全栈能力的成熟，以及 Vercel 等厂商提出的[框架定义的基础设施](https://vercel.com/blog/framework-defined-infrastructure)等前沿技术，亟需开发者工具链的深度集成。

Modern frontend frameworks integrated with frontend clouds blur the lines between development and infrastructure. Developers now indirectly define the underlying architecture by writing framework code. Code-level optimizations translate into infrastructure-level enhancements, eliminating the need for manual configuration or deep infrastructure expertise. Optimal performance becomes the new standard, achieved by default.

与前端云深度集成的现代前端框架，正日益模糊开发与基础设施之间的边界。开发者如今只需编写框架代码，即可间接定义底层系统架构；代码层面的优化将自动转化为基础设施层面的增强能力，彻底消除了手动配置的需求，也无需掌握深厚的基础设施专业知识。最优性能由此成为默认标准，开箱即得。

Frontend frameworks and their required infrastructure now evolve in lockstep, seamlessly integrating the latest innovations while simplifying developer experiences. This allows organizations to focus on what matters most: crafting exceptional user experiences and delivering unparalleled business value.

前端框架与其所需的基础设施如今同步演进，无缝融合最新技术成果，同时大幅简化开发者体验。这使得组织得以聚焦于真正关键的事项：打造卓越的用户体验，并交付无可比拟的业务价值。

Frontend clouds address the previously mentioned limitations of traditional CDNs by integrating caching strategies and performance optimizations directly into the developer’s workflow. This ensures that behaviors—such as cache invalidation, routing, and dynamic content handling—are accurately tested in both development and preview environments, overcoming the disconnect between local testing and real-world performance.

前端云通过将缓存策略与性能优化能力直接嵌入开发者工作流，有效解决了传统 CDN 之前所面临的各项局限。此举确保诸如缓存失效、路由逻辑及动态内容处理等关键行为，能在开发环境与预览环境中得到精准验证，从而彻底消除本地测试结果与真实世界性能表现之间的脱节。

By reducing the risks of inconsistent behavior and improving the developer experience (DX), frontend clouds streamline the deployment process. When issues arise, Vercel’s instant rollback ensures a smooth return to a previously known good state through atomic rollbacks, providing precise control and minimizing disruption across the deployment.

通过降低行为不一致的风险并提升开发者体验（DX），前端云简化了部署流程。当问题出现时，Vercel 的即时回滚功能可通过原子级回滚，快速、平滑地恢复至此前已知的良好状态，从而实现精准控制，并最大限度减少对整体部署的干扰。

![Over time, frontend and backend roles diverged and resources became distributed, but with frontend clouds managing infrastructure, engineers can focus on core differentiation while delivering exceptional applications.](images/from-cdns-to-frontend-clouds-vercel/img_005.jpg)![Over time, frontend and backend roles diverged and resources became distributed, but with frontend clouds managing infrastructure, engineers can focus on core differentiation while delivering exceptional applications.](images/from-cdns-to-frontend-clouds-vercel/img_006.jpg)  
![随着时间推移，前端与后端职责逐渐分化，资源也趋于分布式部署；但借助前端云对基础设施的统一管理，工程师得以专注于核心差异化建设，同时交付卓越的应用程序。](images/from-cdns-to-frontend-clouds-vercel/img_005.jpg)![随着时间推移，前端与后端职责逐渐分化，资源也趋于分布式部署；但借助前端云对基础设施的统一管理，工程师得以专注于核心差异化建设，同时交付卓越的应用程序。](images/from-cdns-to-frontend-clouds-vercel/img_006.jpg)  

Over time, frontend and backend roles diverged and resources became distributed, but with frontend clouds managing infrastructure, engineers can focus on core differentiation while delivering exceptional applications.

随着时间推移，前端与后端职责逐渐分化，资源也趋于分布式部署；但借助前端云对基础设施的统一管理，工程师得以专注于核心差异化建设，同时交付卓越的应用程序。

### **Leading the charge redefining application delivery**

### **引领应用交付范式的重塑**

For years, the six core principles of exceptional application delivery—scalability, security, performance, dynamism, global presence, and reliability—felt like a moving target. Developers understood their importance, but achieving all six simultaneously often felt like a zero-sum game. Compromises were made, sacrifices accepted, and the full potential of the web remained tantalizingly out of reach.

多年来，卓越应用交付所依赖的六大核心原则——可扩展性、安全性、性能、动态性、全球覆盖能力与可靠性——始终如同一个“移动靶标”。开发者深知其重要性，但要同时满足全部六项，往往如同一场零和博弈：必须做出取舍、接受妥协，而 Web 的全部潜力则始终若即若离、难以企及。

Frontend cloud technology is transforming businesses of all sizes, from startups to global enterprises. By building on decades of technological advancements—from CDNs to cloud infrastructure—Vercel simplifies and enhances these foundations, ensuring they are ready for the present and future.

前端云技术正在变革各类规模的企业——从初创公司到全球性企业。Vercel 基于数十年来的技术演进成果（从 CDN 到云基础设施），对这些底层能力进行了简化与增强，确保其既能满足当下需求，亦能面向未来演进。

Managing infrastructure—like serverless functions, edge caching, automatic scaling, and security measures such as Vercel Firewall—and adapting to emerging rendering strategies like Partial Pre-Rendering in Next.js and Server Islands in Astro ensures continuous evolution while upholding the core principles.

对基础设施的管理——包括无服务器函数、边缘缓存、自动扩缩容，以及 Vercel 防火墙等安全机制——并适配新兴渲染策略（如 Next.js 中的“部分预渲染”（Partial Pre-Rendering）与 Astro 中的“服务端岛”（Server Islands）），在持续演进的同时，始终坚守上述六大核心原则。

With Vercel, developers don't choose between these principles; they achieve them all, simultaneously, through the simplicity of framework code. The code that brings their frontend vision to life also dictates the infrastructure that powers it. This is how Vercel is reshaping the landscape of application delivery, enabling experiences that were once unimaginable to become the new standard.

借助 Vercel，开发者无需在这些原则之间权衡取舍；他们可通过框架代码的简洁性，同步实现全部六大目标。驱动前端构想落地的代码，本身即定义了支撑其运行的基础设施。这正是 Vercel 重塑应用交付格局的方式——让曾经无法想象的用户体验，成为全新的行业标准。