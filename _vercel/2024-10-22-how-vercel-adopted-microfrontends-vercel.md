---
render_with_liquid: false
title: "How Vercel adopted microfrontends - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-vercel-adopted-microfrontends"
date: "2024-10-22"
scraped_at: "2026-03-02T09:40:07.227532294+00:00"
language: "en-zh"
translated: true
description: "Learn how Vercel cut build times and improved developer velocity while maintaining a smooth user experience with microfrontends."
---
render_with_liquid: false
render_with_liquid: false

Oct 22, 2024

2024 年 10 月 22 日

了解 Vercel 如何借助微前端（microfrontends）缩短构建时间、提升开发效率，同时保持流畅的用户体验。

Vercel 的主网站最初是一个庞大的单一 Next.js 应用，同时为网站访客和已登录的仪表板用户提供服务。但随着 Vercel 不断发展，这一架构逐渐暴露出诸多可优化空间：构建耗时持续增长、依赖管理日趋复杂、开发与 CI 工作流亟需改进。即使是微小的代码变更，也会触发全量构建，严重制约了模块化开发及 CI 流水线的效率。

变革势在必行。

我们重新思考整体架构，转向**垂直微前端（vertical microfrontends）**模式。这一转变不仅简化了开发体验，更使预览构建（preview build）时间和本地开发编译速度提升了 **40% 以上**。通过移除各微前端之间互不相关的代码，我们大幅精简了依赖关系，降低了页面体积，从而显著提升了终端用户的性能表现——包括[核心网页指标（Core Web Vitals）](https://vercel.com/blog/how-core-web-vitals-affect-seo)中的最大内容绘制（LCP）和下一次交互绘制时间（INP）等关键指标均获得明显改善。

依托 Vercel 对微前端的原生支持，此次架构重构显著提升了开发者体验（Developer Experience, DX），并揭示出更多可进一步优化的方向。通过“以己为食”（dogfooding）的方式完成大规模应用迁移，我们的实践不仅验证了平台能力，更催生出一系列面向全体用户的平台优化新思路。本文虽聚焦于 Vercel 自身的演进历程，但也坦诚指出了当前流程中仍待打磨的环节。在持续精进的过程中，我们也在同步加速单体应用的构建——在不牺牲终端用户性能的前提下，实现更卓越的开发者体验。

接下来，让我们深入探讨具体实现路径。

### 借力 Turbo

我们的第一步是聚焦于提升本地编译效率、缩短构建耗时并优化 CI 工作流。Vercel 的单体仓库（monorepo）基于 [Turborepo](https://turbo.build/repo/docs) 构建，我们借此充分利用其特性，例如 [Vercel 远程缓存（Vercel Remote Cache）](https://vercel.com/docs/monorepos/remote-caching#vercel-remote-cache) 和 [`--affected`](https://turbo.build/repo/docs/reference/run#--affected) 参数，实现了任务级精细化优化。此外，引入 [Turbopack](https://turbo.build/pack/docs) 更为本地开发带来了显著的速度跃升。

然而，在推进这些优化的过程中，我们意识到：Vercel.com 已不再需要维持单一应用（single-app）模型。应用内部天然存在的逻辑边界，使我们得以按需构建与编译，避免大量冗余工作——这进一步释放了开发者生产力，带来了更为可观的效率增益。

### Weighing a horizontal or vertical split

### 权衡水平拆分与垂直拆分

Microfrontends offer a way to break down large applications into smaller, independent units, allowing parallel development across product areas and engineering teams. While single applications are cohesive, microfrontends help address scaling issues as both applications and organizations grow. There are two main strategies:

微前端提供了一种将大型应用拆分为更小、更独立单元的方法，从而支持不同产品领域和工程团队并行开发。尽管单体应用具有高度内聚性，但随着应用规模与组织规模的扩大，微前端有助于应对可扩展性挑战。主要有两种拆分策略：

- **Vertical microfrontends:** Split by path, where each page is handled by a single app

- **垂直微前端：** 按路由路径拆分，每个页面由一个独立应用负责

- **Horizontal microfrontends:** Split by features, where multiple applications run on the same page

- **水平微前端：** 按功能特性拆分，多个应用共存于同一页面中

![Two common approaches to microfrontends: Multiple microfrontends within a single page (horizontal split) or having a single microfrontend manage an entire page (vertical split).](images/how-vercel-adopted-microfrontends-vercel/img_001.jpg)![Two common approaches to microfrontends: Multiple microfrontends within a single page (horizontal split) or having a single microfrontend manage an entire page (vertical split).](images/how-vercel-adopted-microfrontends-vercel/img_002.jpg)![Two common approaches to microfrontends: Multiple microfrontends within a single page (horizontal split) or having a single microfrontend manage an entire page (vertical split).](images/how-vercel-adopted-microfrontends-vercel/img_003.jpg)![Two common approaches to microfrontends: Multiple microfrontends within a single page (horizontal split) or having a single microfrontend manage an entire page (vertical split).](images/how-vercel-adopted-microfrontends-vercel/img_004.jpg)Two common approaches to microfrontends: Multiple microfrontends within a single page (horizontal split) or having a single microfrontend manage an entire page (vertical split).

两张图展示了微前端的两种常见模式：单页内集成多个微前端（水平拆分），或由单个微前端完整托管整页内容（垂直拆分）。

There is no right or wrong answer, and each has its trade-offs. Each approach can deliver substantial benefits depending on the use case. Luca Mezzalira's [book on microfrontends](https://www.buildingmicrofrontends.com/) is a good resource on this topic.

并不存在绝对正确或错误的选择，两种方式各有取舍；具体采用哪一种，取决于实际应用场景，并可能带来显著收益。Luca Mezzalira 所著的《[微前端架构](https://www.buildingmicrofrontends.com/)》是了解该主题的优质参考资料。

Vertical splits offer cohesion, but may cause hard navigations when switching between applications supported by different microfrontends. Techniques like prefetching and APIs like [Chromium’s Speculation Rules](https://developer.chrome.com/docs/web-platform/prerender-pages) can help, but come with limitations, such as increased resource usage and limited browser support.

垂直拆分具备良好的内聚性，但在用户切换由不同微前端支撑的应用时，可能导致“硬跳转”（hard navigation）。预加载（prefetching）等技术，以及 [Chromium 的推测规则（Speculation Rules）](https://developer.chrome.com/docs/web-platform/prerender-pages) 等 API 可以缓解该问题，但也存在局限性，例如资源消耗增加、浏览器兼容性有限等。

With horizontal splits, testing, releasing, monitoring, and debugging become more complex, as multiple microfrontends operate on the same page.

在水平拆分下，由于多个微前端共存于同一页面，测试、发布、监控与调试的复杂度显著上升。

We adopted **vertical microfrontends**—splitting the app into logical sections users rarely cross—to reduce build times and simplify dependencies, all while maintaining a unified monorepo.

我们采用了**垂直微前端**架构——将应用按用户极少跨域访问的逻辑模块进行拆分——以此缩短构建时间、简化依赖关系，同时保持统一的单体仓库（monorepo）结构。

[**Deploy microfrontends on Vercel**\\  
\\  
Vercel makes it easy to deploy vertical microfrontends. Learn whether Next.js Multi-Zones can work for you.\\  
\\  
View template](https://vercel.com/templates/next.js/microfrontends)

[**在 Vercel 上部署微前端**\\  
\\  
Vercel 让垂直微前端的部署变得轻而易举。了解 Next.js Multi-Zones 是否适用于您的场景。\\  
\\  
查看模板](https://vercel.com/templates/next.js/microfrontends)

Early tests showed this approach could halve build times and streamline ownership across both development and production, giving developers the feel of working on a single application.

早期测试表明，该方法可将构建时间缩短一半，并在开发与生产环境中统一职责归属，让开发者获得如同在单一应用中工作的体验。

### Our migration path

### 我们的迁移路径

The next step was migrating our monolithic frontend app into smaller vertical applications without disrupting development or the user experience. We broke the application down into three core areas:

下一步是将我们的单体前端应用迁移到更小的垂直应用中，同时不干扰开发流程或用户体验。我们将应用拆分为以下三个核心模块：

- marketing  
- documentation  
- logged-in dashboard  

- 营销页面（marketing）  
- 文档中心（documentation）  
- 登录后仪表盘（logged-in dashboard）

These areas were naturally distinct. Users don't frequently cross between them, and they maintain distinct user interfaces, making them ideal for separation.

这些模块天然边界清晰：用户极少在它们之间频繁跳转，且各自拥有独立的用户界面，因此非常适合解耦分离。

![Users experience soft navigations within a single microfrontend and hard navigations when moving between microfrontends.](images/how-vercel-adopted-microfrontends-vercel/img_005.jpg)![Users experience soft navigations within a single microfrontend and hard navigations when moving between microfrontends.](images/how-vercel-adopted-microfrontends-vercel/img_006.jpg)![Users experience soft navigations within a single microfrontend and hard navigations when moving between microfrontends.](images/how-vercel-adopted-microfrontends-vercel/img_007.jpg)![Users experience soft navigations within a single microfrontend and hard navigations when moving between microfrontends.](images/how-vercel-adopted-microfrontends-vercel/img_008.jpg)Users experience soft navigations within a single microfrontend and hard navigations when moving between microfrontends.

![用户在单个微前端内部进行“软导航”，而在微前端之间跳转时则触发“硬导航”。](images/how-vercel-adopted-microfrontends-vercel/img_005.jpg)![用户在单个微前端内部进行“软导航”，而在微前端之间跳转时则触发“硬导航”。](images/how-vercel-adopted-microfrontends-vercel/img_006.jpg)![用户在单个微前端内部进行“软导航”，而在微前端之间跳转时则触发“硬导航”。](images/how-vercel-adopted-microfrontends-vercel/img_007.jpg)![用户在单个微前端内部进行“软导航”，而在微前端之间跳转时则触发“硬导航”。](images/how-vercel-adopted-microfrontends-vercel/img_008.jpg)用户在单个微前端内部进行“软导航”，而在微前端之间跳转时则触发“硬导航”。

Since we use [Next.js](https://nextjs.org/), we used the [Next.js Multi-Zones](https://nextjs.org/docs/app/building-your-application/deploying/multi-zones) feature, which supports vertical microfrontends.

由于我们使用 [Next.js](https://nextjs.org/)，我们采用了其 [Multi-Zones（多区域）](https://nextjs.org/docs/app/building-your-application/deploying/multi-zones) 功能，该功能原生支持垂直型微前端架构。

Incremental migration was a priority for us. We opted to create brand new applications, instead of forking the original codebase. Forking seemed easier on the surface, but would have introduced risks. Shared components like headers, footers, and design systems would need to be duplicated and maintained across multiple repositories, leading to synchronization issues and potential inconsistencies.

渐进式迁移是我们的重要原则。我们选择从零开始构建全新的应用，而非对原有代码库进行分叉（fork）。表面上看，分叉似乎更简单，但实际会带来诸多风险：诸如页眉、页脚及设计系统等共享组件，将不得不在多个仓库中重复复制并分别维护，极易引发同步难题和潜在的不一致性问题。

By continuing with the monorepo, and centralizing code into `packages` within the monorepo, we ensured consistency of the shared components while still easily, gradually breaking out key areas. Tools like [Turborepo](https://turbo.build/repo/docs) and [Dependency Cruiser](https://github.com/sverweij/dependency-cruiser) helped simplify this process.

在继续采用单体仓库（monorepo）的同时，我们将代码集中到该 monorepo 的 `packages` 目录下，既保障了共享组件的一致性，又能够轻松、渐进地将关键模块拆分出去。[Turborepo](https://turbo.build/repo/docs) 和 [Dependency Cruiser](https://github.com/sverweij/dependency-cruiser) 等工具显著简化了这一过程。

![Vercel's monorepo is structured with independent microfrontends in the "apps" folder, while shared packages are promoted for seamless access across all apps.](images/how-vercel-adopted-microfrontends-vercel/img_009.jpg)![Vercel's monorepo is structured with independent microfrontends in the "apps" folder, while shared packages are promoted for seamless access across all apps.](images/how-vercel-adopted-microfrontends-vercel/img_010.jpg)Vercel's monorepo is structured with independent microfrontends in the "apps" folder, while shared packages are promoted for seamless access across all apps.

![Vercel 的单体仓库结构为：“apps” 文件夹中存放彼此独立的微前端应用，而共享包则被提升至更高层级，以便所有应用无缝访问。](images/how-vercel-adopted-microfrontends-vercel/img_009.jpg)![Vercel 的单体仓库结构为：“apps” 文件夹中存放彼此独立的微前端应用，而共享包则被提升至更高层级，以便所有应用无缝访问。](images/how-vercel-adopted-microfrontends-vercel/img_010.jpg)Vercel 的单体仓库结构为：“apps” 文件夹中存放彼此独立的微前端应用，而共享包则被提升至更高层级，以便所有应用无缝访问。

Using [feature flags](https://vercel.com/docs/workflow-collaboration/feature-flags), we were able to incrementally route traffic from the still-live monolithic frontend app to the new microfrontends. This allowed us to minimize risk and validate performance improvements before removing the old code. When the new page had been serving traffic for at least a week without error, we removed the code from the existing application, incrementally reducing the dependencies and build times.

借助 [功能开关（feature flags）](https://vercel.com/docs/workflow-collaboration/feature-flags)，我们得以逐步将流量从仍在运行的单体前端应用迁移至新的微前端应用。此举显著降低了风险，并可在彻底移除旧代码前充分验证性能提升效果。当新页面已稳定承接流量至少一周且未出现任何错误后，我们才将其对应代码从现有应用中移除，从而逐步减少依赖项与构建耗时。

![During incremental migration, the page exists in both the original frontend monolith and the new microfrontend. Feature flags control routing until the microfrontend version goes fully live.](images/how-vercel-adopted-microfrontends-vercel/img_011.jpg)![During incremental migration, the page exists in both the original frontend monolith and the new microfrontend. Feature flags control routing until the microfrontend version goes fully live.](images/how-vercel-adopted-microfrontends-vercel/img_012.jpg)![During incremental migration, the page exists in both the original frontend monolith and the new microfrontend. Feature flags control routing until the microfrontend version goes fully live.](images/how-vercel-adopted-microfrontends-vercel/img_013.jpg)![During incremental migration, the page exists in both the original frontend monolith and the new microfrontend. Feature flags control routing until the microfrontend version goes fully live.](images/how-vercel-adopted-microfrontends-vercel/img_014.jpg)During incremental migration, the page exists in both the original frontend monolith and the new microfrontend. Feature flags control routing until the microfrontend version goes fully live.

![在渐进式迁移过程中，该页面同时存在于原始前端单体应用和新的微前端应用中；功能开关控制路由逻辑，直至微前端版本全面上线。](images/how-vercel-adopted-microfrontends-vercel/img_011.jpg)![在渐进式迁移过程中，该页面同时存在于原始前端单体应用和新的微前端应用中；功能开关控制路由逻辑，直至微前端版本全面上线。](images/how-vercel-adopted-microfrontends-vercel/img_012.jpg)![在渐进式迁移过程中，该页面同时存在于原始前端单体应用和新的微前端应用中；功能开关控制路由逻辑，直至微前端版本全面上线。](images/how-vercel-adopted-microfrontends-vercel/img_013.jpg)![在渐进式迁移过程中，该页面同时存在于原始前端单体应用和新的微前端应用中；功能开关控制路由逻辑，直至微前端版本全面上线。](images/how-vercel-adopted-microfrontends-vercel/img_014.jpg)在渐进式迁移过程中，该页面同时存在于原始前端单体应用和新的微前端应用中；功能开关控制路由逻辑，直至微前端版本全面上线。

With this monorepo setup and vertical split approach, we felt confident and in control. We were able to move very quickly while preserving consistency, reducing build times, and keeping app development simple.

依托这一单体仓库架构与垂直切分策略，我们始终保有充分的信心与掌控力。我们不仅推进迅速，还成功维持了系统一致性、缩短了构建时间，并让应用开发保持简洁高效。

### Lessons learned and managing the trade-offs

### 经验总结与权衡取舍

After the successful adoption of microfrontends for Vercel.com, we expanded the same approach to other sites like the [2024 Next.js Conf](https://nextjs.org/conf) page, which runs as a separate application from [nextjs.org](https://nextjs.org/). With this infrastructure, we could extract distinct areas into independent applications, speeding up development cycles as the Next.js Conf team and Next.js development teams could iterate quickly and independently.

在 Vercel.com 成功落地微前端架构后，我们将同一套方法论推广至其他站点，例如 [2024 Next.js Conf](https://nextjs.org/conf) 页面——它作为一套独立于 [nextjs.org](https://nextjs.org/) 的应用运行。依托该基础设施，我们可将不同业务域抽离为彼此独立的应用，从而加速开发周期：Next.js Conf 团队与 Next.js 核心开发团队得以快速、自主地迭代各自负责的功能模块。

That said, there were challenges. We encountered some issues and worked on ensuring performance didn’t regress, specifically using tools like [Speed Insights](https://vercel.com/docs/speed-insights) to monitor real world usage and [Vercel Toolbar](https://vercel.com/docs/workflow-collaboration/vercel-toolbar) for layout shift and interaction timing alerts.

当然，这一过程也面临诸多挑战。我们曾遭遇若干问题，并持续致力于防止性能退化：例如，借助 [Speed Insights](https://vercel.com/docs/speed-insights) 监控真实用户场景下的性能表现；利用 [Vercel Toolbar](https://vercel.com/docs/workflow-collaboration/vercel-toolbar) 检测布局偏移（CLS）与交互响应延迟等关键指标。

We recognized early on that testing microfrontends locally and in previews was challenging. Features like [Draft Mode](https://vercel.com/docs/workflow-collaboration/draft-mode) didn't work correctly, and performance bottlenecks—like hard navigations—were known issues. To resolve these issues we adopted strategies likes prefetching and prerendering using Chromium’s Speculation Rules.

我们很早就意识到，在本地环境及预览环境中测试微前端存在困难：例如 [Draft Mode](https://vercel.com/docs/workflow-collaboration/draft-mode) 功能无法正常工作；而“硬跳转”（hard navigation）等导致的性能瓶颈亦属已知问题。为此，我们采用了基于 Chromium Speculation Rules 的预加载（prefetching）与预渲染（prerendering）等优化策略，以应对上述挑战。

**An example of overcoming trade-offs:**

**一个克服权衡取舍的实例：**

To reduce the impact of hard navigations, we start by downloading the initial page's resources (JavaScript and CSS) to prime the browser cache as soon as a link becomes visible. This means when a user navigates, those assets load from the cache. However, the page still requires rendering and fetching remaining assets, like HTML.

为减轻硬导航（hard navigations）的影响，我们首先在链接可见时立即下载初始页面的资源（JavaScript 和 CSS），以预热浏览器缓存。这意味着当用户执行导航操作时，这些资源将直接从缓存中加载。然而，页面仍需完成渲染，并获取其余资源（例如 HTML）。

We take it a step further by prerendering pages when the user interacts (e.g. tapping a link). This renders the page in the background, including all network requests and processing, so when the user arrives, it feels instantaneous. This approach balances performance with resource usage—only prefetching and prerendering at the right time to avoid overloading the device while still delivering the desired experience.

我们更进一步：在用户发生交互行为时（例如点击链接）对页面进行预渲染（prerendering）。该过程在后台完成整页渲染，包括所有网络请求与处理逻辑；因此当用户真正抵达该页面时，体验近乎瞬时完成。这一策略在性能与资源消耗之间取得平衡——仅在恰当时机执行预获取（prefetching）与预渲染，既避免设备过载，又确保理想的用户体验。

![Pages prerender or prefetch on user interaction, delivering smooth navigation while optimizing performance and resource use.](images/how-vercel-adopted-microfrontends-vercel/img_015.jpg)![Pages prerender or prefetch on user interaction, delivering smooth navigation while optimizing performance and resource use.](images/how-vercel-adopted-microfrontends-vercel/img_016.jpg)![Pages prerender or prefetch on user interaction, delivering smooth navigation while optimizing performance and resource use.](images/how-vercel-adopted-microfrontends-vercel/img_017.jpg)![Pages prerender or prefetch on user interaction, delivering smooth navigation while optimizing performance and resource use.](images/how-vercel-adopted-microfrontends-vercel/img_018.jpg)Pages prerender or prefetch on user interaction, delivering smooth navigation while optimizing performance and resource use.

![页面在用户交互时进行预渲染或预获取，在优化性能与资源使用的同时实现流畅导航。](images/how-vercel-adopted-microfrontends-vercel/img_015.jpg)![页面在用户交互时进行预渲染或预获取，在优化性能与资源使用的同时实现流畅导航。](images/how-vercel-adopted-microfrontends-vercel/img_016.jpg)![页面在用户交互时进行预渲染或预获取，在优化性能与资源使用的同时实现流畅导航。](images/how-vercel-adopted-microfrontends-vercel/img_017.jpg)![页面在用户交互时进行预渲染或预获取，在优化性能与资源使用的同时实现流畅导航。](images/how-vercel-adopted-microfrontends-vercel/img_018.jpg)页面在用户交互时进行预渲染或预获取，在优化性能与资源使用的同时实现流畅导航。

### Looking ahead

### 展望未来

With the improvements in iteration speed, we're doubling down on enhancing microfrontends across the platform. Our focus is on refining routing, streamlining the preview workflow, and optimizing hard navigation performance. We’re also enhancing the dashboard experience and addressing workflow challenges to improve microfrontend development from start to finish.

随着迭代速度的提升，我们正加大力度全面增强平台上的微前端能力。我们的重点包括：优化路由机制、简化预览工作流、提升硬导航性能；同时，我们也在改进控制台（dashboard）体验，并解决各类工作流挑战，从而全面提升微前端开发的端到端体验。

The shift to vertical microfrontends has greatly improved developer velocity and cut build times. Teams now work more independently while staying aligned through shared packages, creating a system that balances autonomy with unified development.

转向垂直式微前端（vertical microfrontends）显著提升了开发者效率，并大幅缩短了构建时间。各团队如今能更独立地开展工作，同时借助共享包保持协同一致，由此构建出一种兼顾自主性与统一开发体验的系统。

As we continue to refine this architecture, we’re excited about its potential. Whether you’re exploring microfrontends—or sticking with a single application—Vercel is committed to ensuring the best possible developer experience.

随着我们持续完善这一架构，我们对其潜力充满期待。无论您正在探索微前端，还是坚持采用单体应用方案，Vercel 始终致力于为您提供最佳的开发者体验。

[**Learn how microfrontends with Vercel can help your DX**\\
\\
Running into developer velocity issues scaling your application? Talk to experts who can help you understand whether microfrontends can help improve your DX.\\
\\
Contact Us](https://vercel.com/contact/sales)

[**了解 Vercel 微前端如何助力您的开发者体验（DX）**\\
\\
您的应用在规模化过程中是否遭遇开发者效率瓶颈？联系专家，深入探讨微前端是否有助于改善您的开发者体验。\\
\\
联系我们](https://vercel.com/contact/sales)