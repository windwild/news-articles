---
title: "How Frame.io builds fluid UI for a seamless user experience - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/frameio-never-drop-the-illusion"
date: "2024-06-11"
scraped_at: "2026-03-02T09:43:39.766764961+00:00"
language: "en-zh"
translated: true
description: "Their users \"see in milliseconds,\" so every frame within their web experience matters. Frame.io commits itself to delivering web applications that feel as responsive and powerful as their desktop coun..."
---
&#123;% raw %}

Jun 11, 2024

2024 年 6 月 11 日

Frame.io 的用户“以毫秒为单位感知画面”，因此用户网页体验中的每一次交互、每一处动画、每一帧画面都至关重要。

#### 速度快 6 倍

预览构建与部署速度提升 6 倍

#### 400 万

预计 Frame.io v4 用户量

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

当好莱坞巨头与全球品牌协作制作视频时，他们对体验的流畅性与高性能有着严苛要求——而 Adobe 旗下公司 [Frame.io](https://frame.io/) 正是这一需求的可靠交付者。

其用户处理的是高质量视频内容，在感知层面处于更高维度——他们“以毫秒为单位观察画面”，并对细节精益求精。为满足这类用户的严苛需求，Frame.io 致力于打造响应迅捷、功能强大的 Web 应用，使其体验媲美桌面端应用。

这一愿景促使 Frame.io 摒弃了广为流传的“先实现功能，再优化正确性，最后追求性能”（make it work, make it right, make it fast）开发范式，转而探索真正契合自身及用户需求的技术方案。

## **Seeing in milliseconds required a new approach**

## **毫秒级响应能力要求一种全新方法**

Seeing in milliseconds highlights the understanding that even the slightest delay or dropped frame can disrupt the creative flow for video pros.

“毫秒级响应”凸显了一个关键认知：对视频专业人士而言，哪怕最微小的延迟或丢帧，都可能打断其创作流程。

This realization led Frame.io to embrace a new guiding principle: "How it feels = how it works." If the application doesn't feel good to use, it’s just as bad as when a feature isn’t functioning correctly.

这一认知促使 Frame.io 确立了一项全新的指导原则：“体验即功能”（How it feels = how it works）。如果应用使用起来不够顺滑，其问题严重性不亚于某项功能完全失效。

> “How it feels is as important as how it works. For us, performance is a feature. If it doesn’t feel good, it’s not working.How it feels is as important as how it works. For us, performance is a feature. If it doesn’t feel good, it’s not working.”
>
> “体验与功能同等重要。对我们而言，性能本身就是一项核心功能；若体验不佳，即意味着功能尚未真正生效。”
>
> ![](images/how-frame_io-builds-fluid-ui-for-a-seamless-user-experience-vercel/img_001.jpg)
>
> **Charlton Roberts,** Senior Manager of Product Engineering at Frame.io
>
> **查尔顿·罗伯茨（Charlton Roberts）**，Frame.io 产品工程高级经理

Frame.io refers to their approach to building performant UIs as "Fluid UI." Influenced by Apple’s [Designing Fluid Interfaces](https://developer.apple.com/videos/play/wwdc2018/803), Fluid UI rests on three core principles: instant, smooth, and coordinated.

Frame.io 将其高性能用户界面构建方法称为“流体界面”（Fluid UI）。该理念深受苹果公司 [《设计流体界面》（Designing Fluid Interfaces）](https://developer.apple.com/videos/play/wwdc2018/803) 启发，建立在三大核心原则之上：即时性（Instant）、流畅性（Smooth）与协同性（Coordinated）。

- **Instant:** The UI must respond to user input within 100ms, providing immediate feedback that their action has been registered. To achieve this, they leverage React features like `useState`, `useOptimistic`, and the Next.js Router Cache, while minimizing unnecessary re-renders with `useMemo` and `useCallback`

- **即时性**：界面必须在 100 毫秒内响应用户操作，即时反馈已成功接收指令。为实现这一点，团队充分利用 React 的 `useState`、`useOptimistic` 及 Next.js 路由器缓存（Router Cache）等特性，并借助 `useMemo` 和 `useCallback` 最大限度减少不必要的组件重渲染。

- **Smooth:** All animations should run at a consistent 60 fps, mimicking the fluidity of natural motion and creating a visually pleasing experience. This involves utilizing React's `useTransition` Hook, opting for CSS-only solutions whenever possible, and building stable UI components that minimize DOM manipulation

- **流畅性**：所有动画均需稳定运行于 60 帧每秒（fps），模拟自然运动的连贯感，从而营造赏心悦目的视觉体验。这包括善用 React 的 `useTransition` Hook，尽可能采用纯 CSS 方案实现动效，并构建结构稳定的 UI 组件，以最小化 DOM 操作。

- **Coordinated:** UI elements should move in sync, creating a cohesive and intuitive flow. Transitions and animations should feel like a natural extension of the user's actions. This requires carefully orchestrating animations and transitions for related UI elements, ensuring they occur in sync and contribute to a cohesive user experience

- **协同性**：界面元素的运动须协调同步，形成统一而直观的操作流。转场与动画应如用户操作的自然延伸。这要求对关联的 UI 元素进行精细编排，确保其动画与过渡严格同步，并共同服务于整体一致的用户体验。

To ensure these principles translate into a consistently smooth user experience, Frame.io adopted Next.js [App Router](https://nextjs.org/docs/app), and uses Vercel and their own platform to constantly monitor application performance.

为确保上述原则切实转化为持续流畅的用户体验，Frame.io 采用了 Next.js [App Router](https://nextjs.org/docs/app)，并结合 Vercel 平台及自身系统，对应用性能实施常态化监控。

Vercel's automatic [Preview Deployments](https://vercel.com/docs/deployments/preview-deployments) allow developers to evaluate the performance impact of code changes in a production-like environment, catching and addressing regressions early on. Previously, waiting for previews could take Frame.io up to 40 minutes. But Vercel significantly reduces this time by over 6x to around 6 minutes, enabling faster iteration cycles and quicker identification of potential issues.

Vercel 自动化的 [预览部署（Preview Deployments）](https://vercel.com/docs/deployments/preview-deployments) 功能，使开发者能在类生产环境中实时评估代码变更对性能的影响，从而尽早发现并修复性能退化问题。过去，Frame.io 等待预览环境就绪最长需耗时 40 分钟；而借助 Vercel，该等待时间大幅缩短逾 6 倍，降至约 6 分钟，显著加快了迭代周期，并加速了潜在问题的识别与响应。

[**Build, deploy, and iterate—seamlessly.**  
**构建、部署与迭代——无缝衔接。**

Traditional deployment tools weren’t built for frontend development. Get the DX Platform that has teams shipping 6x faster.  
传统的部署工具并非为前端开发而设计。采用 DX 平台，让团队交付速度提升 6 倍。

[Learn More](https://vercel.com/products/dx-platform)  
[了解更多](https://vercel.com/products/dx-platform)

The team at Frame.io believes in the power of dogfooding, so they use Frame.io to analyze and improve the performance of Frame.io itself. By uploading screen recordings and analyzing them frame by frame, they can pinpoint even the slightest performance bottlenecks and address them directly.  
Frame.io 团队坚信“自用即测试（dogfooding）”的力量，因此他们使用 Frame.io 自身来分析并优化 Frame.io 的性能。通过上传屏幕录制视频，并逐帧分析，他们能够精准定位哪怕最细微的性能瓶颈，并直接加以解决。

This constant feedback loop ensures that the team implements Fluid UI principles effectively and that the result is a truly seamless user experience.  
这一持续的反馈闭环，确保团队能高效践行 Fluid UI 原则，最终打造出真正无缝的用户体验。

## **Engineering for scale and performance**  
## **面向规模化与高性能的工程实践**

Building for Fluid UI isn't just about adhering to a set of principles; it demands a fundamental shift in mindset and a dedicated framework that permeates the entire development process.  
构建 Fluid UI 不仅意味着遵循一套设计原则，更要求思维方式的根本转变，以及一个贯穿整个开发流程的专属框架。

Frame.io approaches this challenge with a forward-thinking mentality, embodied in an "instant and infinity" philosophy: They design for scalability from day one, anticipating massive datasets and building their architecture to handle millions of items without breaking a sweat. This laser focus on user experience is further enabled by tools like Vercel, which handle critical performance optimizations out of the box.  
Frame.io 以前瞻性思维应对这一挑战，并将其凝练为“即时性与无限性（instant and infinity）”的哲学：从项目第一天起就为可扩展性而设计，前瞻性地应对海量数据集，并构建出轻松承载数百万条内容的系统架构。而 Vercel 等工具则开箱即用地完成关键性能优化，进一步强化了这种以用户体验为核心的极致专注。

> “A lot of the value we get from Vercel is things we don't have to think about. Initial load performance is just as important as interaction performance, but we spend so much less time thinking about load performance because of the optimizations Vercel offers us. A lot of the value we get from Vercel is things we don't have to think about. Initial load performance is just as important as interaction performance, but we spend so much less time thinking about load performance because of the optimizations Vercel offers us.”  
> “我们从 Vercel 获得的大量价值，恰恰在于那些我们无需操心的事情。首屏加载性能与交互响应性能同等重要；但正因 Vercel 提供的诸多优化，我们花在加载性能上的思考时间大幅减少。”

> ![](images/how-frame_io-builds-fluid-ui-for-a-seamless-user-experience-vercel/img_001.jpg)  
> ![](images/how-frame_io-builds-fluid-ui-for-a-seamless-user-experience-vercel/img_001.jpg)

> **Charlton Roberts,** Senior Manager of Product Engineering at Frame.io  
> **Charlton Roberts**，Frame.io 产品工程高级经理

Features like Vercel's global [Edge Network](https://vercel.com/docs/edge-network/overview), [static asset revalidation](https://vercel.com/docs/incremental-static-regeneration), and easy configuration of cache headers allow Frame.io's product engineers to focus on building features rather than spending weeks configuring infrastructure with the Site Reliability Engineering (SRE) team. This frees up valuable engineering resources to concentrate on delivering the best possible user experience.  
Vercel 的全球 [边缘网络（Edge Network）](https://vercel.com/docs/edge-network/overview)、[静态资源重新验证（static asset revalidation）](https://vercel.com/docs/incremental-static-regeneration)，以及便捷的缓存头（cache headers）配置等功能，使 Frame.io 的产品工程师得以专注于功能开发，而非耗费数周时间与站点可靠性工程（SRE）团队共同配置基础设施。这释放了宝贵的工程资源，使其能全力投入于打造最佳用户体验。

But it's not just about handling scale—it's also about prioritizing the right work. Frame.io understands that every task impacts the user experience, so they prioritize ruthlessly, focusing on what matters most to their users. This often means deferring noncritical tasks, ensuring that the application remains snappy and responsive even under heavy load.  
但挑战不仅在于应对规模增长，更在于对工作的精准优先级排序。Frame.io 深知每一项任务都会影响用户体验，因此他们采取极为严苛的优先级策略，始终聚焦于用户最关心的核心需求。这往往意味着将非关键任务延后处理，从而确保应用即使在高负载下依然保持迅捷与响应灵敏。

[**Focus on features, not infrastructure.**  
[**专注功能开发，而非基础设施。**  

Build performant, personalized customer experiences with scalable infrastructure and secure data handling on any device, in any location.  
借助可扩展的基础设施与安全的数据处理能力，在任意设备、任意位置构建高性能、个性化的客户体验。

[Learn More](https://vercel.com/solutions/web-apps)  
[了解更多](https://vercel.com/solutions/web-apps)

To further enhance the user experience, Frame.io embraces anticipation. They preload resources and data, ensuring a smoother, more responsive experience that feels almost instantaneous. And to keep the UI humming along smoothly, they offload tasks from the main thread whenever possible, preventing UI jank (which impacts [core web vitals](https://vercel.com/resources/how-vercel-improves-your-websites-search-engine-ranking) like Cumulative Layout Shift) and maintaining that crucial responsiveness.

为进一步提升用户体验，Frame.io 主动采用“预判式优化”（anticipation）。他们预先加载资源与数据，确保交互更流畅、响应更迅速，带来近乎瞬时的操作感受。同时，为保障 UI 持续顺畅运行，他们尽可能将任务从主线程中卸载，避免 UI 卡顿（jank）——此类卡顿会损害[核心网页指标（Core Web Vitals）](https://vercel.com/resources/how-vercel-improves-your-websites-search-engine-ranking)，例如累积布局偏移（Cumulative Layout Shift），从而始终维系至关重要的响应性。

## The job's never done: continuous improvement and minimizing downtime

## 工作永无止境：持续优化与最小化停机时间

Frame.io also recognizes the importance of continuous improvement, so they utilize [feature flags](https://vercel.com/blog/feature-flags) to control the release of new features, ensuring they meet performance standards before being unleashed upon the world, while regular audits with [Vercel Speed Insights](https://vercel.com/docs/speed-insights) or [Conformance](https://vercel.com/docs/workflow-collaboration/conformance) help identify and address regressions to ensure the application remains performant over time.

Frame.io 同样深知持续改进的重要性，因此采用[功能开关（feature flags）](https://vercel.com/blog/feature-flags)精细化管控新功能的发布节奏，确保所有功能在全面上线前均已通过严格的性能标准验证；同时，借助 [Vercel Speed Insights](https://vercel.com/docs/speed-insights) 或 [Conformance](https://vercel.com/docs/workflow-collaboration/conformance) 进行常态化性能审计，及时发现并修复性能退化问题，从而长期保障应用的高性能表现。

This commitment to continuous improvement extends to deployment practices as well. With thousands of users relying on Frame.io at any given time, zero-downtime deployments are crucial.

这一持续优化的承诺也延伸至部署实践层面。鉴于任意时刻均有数千名用户依赖 Frame.io 提供服务，实现零停机部署（zero-downtime deployments）至关重要。

Vercel's [Skew Protection](https://vercel.com/docs/deployments/skew-protection) feature helps mitigate the risks associated with deploying at scale, ensuring a seamless transition for all users and minimizing the potential for disruption. This allows Frame.io to confidently ship updates knowing that their users will experience minimal, if any, interruption.

Vercel 的 [Skew Protection（倾斜保护）](https://vercel.com/docs/deployments/skew-protection) 功能可有效缓解大规模部署带来的风险，确保所有用户平滑过渡，最大限度降低服务中断的可能性。这使得 Frame.io 能够自信地上线更新——因为他们深知，用户所感受到的干扰将微乎其微，甚至完全不可察觉。

Frame.io doesn't shy away from complex performance challenges. They allocate dedicated resources and time to tackle these head-on, knowing that conquering these challenges is essential to delivering a truly exceptional user experience.

Frame.io 从不回避复杂的性能挑战。他们专门投入人力与时间直面难题，深知唯有攻克这些挑战，方能交付真正卓越的用户体验。

## Shared expectations and dedicated resources: the keys to success

## 共同的期望与专属资源：成功的基石

Frame.io recognizes that Fluid UI is crucial for a great user experience, especially for demanding applications. They prioritize performance by tracking metrics, identifying bottlenecks, and empowering developers to create a seamless experience.

Frame.io 深知，流畅的用户界面（Fluid UI）对于打造出色的用户体验至关重要——尤其在高要求的应用场景下。他们将性能置于优先地位：通过持续追踪关键指标、精准识别性能瓶颈，并赋能开发者构建无缝体验。

This focus allows users to focus on what matters: their work. Other teams can learn from this approach, building web applications that feel as responsive and powerful as desktop software.

这一聚焦使用户得以专注于真正重要的事情：他们的工作本身。其他团队亦可借鉴此方法论，打造出响应迅捷、能力强大的 Web 应用——其体验堪比原生桌面软件。

Vercel.com landing page

Vercel.com 官网落地页

### Learn more about Vercel Preview Deployments

### 了解更多关于 Vercel 预览部署的信息

Blog post

博客文章

Dec 4, 2023

2023 年 12 月 4 日

### The user experience of the Frontend Cloud

### 前端云的用户体验

![](images/how-frame_io-builds-fluid-ui-for-a-seamless-user-experience-vercel/img_003.jpg)

Alice Alexandra Moore

爱丽丝·亚历山德拉·摩尔
&#123;% endraw %}
