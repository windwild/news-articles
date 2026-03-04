---
title: "Designing and building the Vercel Ship conference platform - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/designing-and-building-the-vercel-ship-conference-platform"
date: "2025-06-11"
scraped_at: "2026-03-02T09:32:31.722820510+00:00"
language: "en-zh"
translated: true
description: "Here's how we designed and built our Vercel Ship conference platform. We generated 15,000+ images and videos with tools like Flux, Veo 2, Runway, and Ideogram. Then, we moved to v0 for prototyping. Se..."
---
&#123;% raw %}

Jun 11, 2025

2025年6月11日

Our two conferences (Vercel Ship and Next.js Conf) are our chance to show what we've been building, how we're thinking, and cast a vision of where we're going next.

我们的两场大会（Vercel Ship 和 Next.js Conf）是我们展示自身所构建成果、分享思考方式，并勾勒未来发展方向的重要契机。

It's also a chance to push ourselves to create an experience that builds excitement and reflects the quality we strive for in our products. For Vercel Ship 2025, we wanted that experience to feel _fluid_ and _fast_.

这同样是一次自我突破的机会——打造令人振奋的参会体验，并体现我们产品一贯追求的卓越品质。对于 Vercel Ship 2025，我们希望这一体验兼具 _流畅性_ 与 _迅捷感_。

This is a look at how we made the conference platform and visuals, from ferrofluid-inspired 3D visuals and generative AI workflows, to modular component systems and more.

本文将带您一览本次大会平台与视觉设计的打造过程：从受铁磁流体启发的 3D 视觉效果、生成式 AI 工作流，到模块化组件系统等各项实践。

## Conceptual evolution

## 概念演进

[Vercel Ship 2024](https://vercel.com/ship/2024)'s visual direction was magnetic particles. Then, we launched [Fluid compute](https://vercel.com/fluid) and brought motion to the particles. For Ship 2025, we wanted to push things even further.

[Vercel Ship 2024](https://vercel.com/ship/2024) 的视觉方向聚焦于“磁性微粒”；随后，我们推出 [Fluid compute](https://vercel.com/fluid)，为这些微粒赋予动态表现力。而到了 Ship 2025，我们决心更进一步。

We explored [ferrofluid](https://en.wikipedia.org/wiki/Ferrofluid), a black magnetic liquid developed by NASA. It felt like the right intersection of motion, magnetism, and something complex under the surface (but simple above).

我们深入研究了 [铁磁流体（ferrofluid）](https://en.wikipedia.org/wiki/Ferrofluid)——一种由 NASA 研发的黑色磁性液体。它完美融合了动态感、磁性特质，以及表层简洁、内里复杂的特质，正契合我们的设计理念。

![A fluid visual identity that subtly nods to our past while pushing into something new.](images/designing-and-building-the-vercel-ship-conference-platform-vercel/img_001.jpg)![A fluid visual identity that subtly nods to our past while pushing into something new.](images/designing-and-building-the-vercel-ship-conference-platform-vercel/img_002.jpg)

![一种流动感十足的视觉标识，在悄然致敬过往的同时，坚定迈向全新领域。](images/designing-and-building-the-vercel-ship-conference-platform-vercel/img_001.jpg)![一种流动感十足的视觉标识，在悄然致敬过往的同时，坚定迈向全新领域。](images/designing-and-building-the-vercel-ship-conference-platform-vercel/img_002.jpg)

A fluid visual identity that subtly nods to our past while pushing into something new.

一种流动感十足的视觉标识，在悄然致敬过往的同时，坚定迈向全新领域。

## Rapid iteration with AI

## 借助 AI 实现快速迭代

Generative AI helped us rapidly prototyped ideas and test visual directions.

生成式 AI 帮助我们快速对创意进行原型设计，并测试不同的视觉方向。

We bounced between Cinema4D, Figma, and Flux to kickstart the visual identity, spinning up quick mocks that shaped the foundation of this year’s brand.

我们在 Cinema4D、Figma 和 Flux 之间反复切换，以启动视觉识别系统，快速产出多个概念稿，为今年的品牌奠定了基础。

When we first explored ferrofluid, its structured elegance and responsiveness felt like a perfect fit. But during internal reviews, we found a major issue. The visuals were triggering symptoms of trypophobia, an aversion to clustered bumps or holes. So we decided to pivot.

最初探索铁磁流体（ferrofluid）时，其结构化的优雅感与动态响应性让我们觉得它近乎完美。但在内部评审中，我们发现了一个严重问题：相关视觉内容会诱发“恐簇症”（trypophobia）——即对密集凸起或孔洞的强烈不适感。因此，我们决定转向新方向。

We explored full-spectrum color, oil-slick vibes, and even a callback to our prism from a previous Next.js Conf. But the visuals started to drift. Too far, too shiny, and too loud.

我们尝试了全光谱色彩、油膜质感，甚至回溯到上一届 Next.js Conf 中使用的棱镜元素。但视觉风格开始偏离初衷：过于夸张、过于闪亮、也过于喧闹。

So we pulled back. We had already trained a model to output consistent lighting, form, and material. That gave us a stable base to evolve without starting over. We softened the shapes and removed the spikes. What we landed on was darker, sleeker, and more suitable. A near-metallic liquid system. Reflective and grounded.

于是我们及时收束。此前我们已训练好一个模型，可稳定输出一致的光照、形态与材质效果——这为我们提供了坚实的基础，使迭代演进无需推倒重来。我们柔化了造型轮廓，去除了尖锐突刺。最终确立的方案更显深邃、更富流线感，也更契合品牌调性：一种近似金属质感的液态系统，兼具反射性与稳重感。

![](images/designing-and-building-the-vercel-ship-conference-platform-vercel/img_003.jpg)![](images/designing-and-building-the-vercel-ship-conference-platform-vercel/img_004.jpg)![](images/designing-and-building-the-vercel-ship-conference-platform-vercel/img_005.jpg)![](images/designing-and-building-the-vercel-ship-conference-platform-vercel/img_006.jpg)

![](images/designing-and-building-the-vercel-ship-conference-platform-vercel/img_003.jpg)![](images/designing-and-building-the-vercel-ship-conference-platform-vercel/img_004.jpg)![](images/designing-and-building-the-vercel-ship-conference-platform-vercel/img_005.jpg)![](images/designing-and-building-the-vercel-ship-conference-platform-vercel/img_006.jpg)

In total, we generated **over 15,000 images and videos** during the design exploration using tools like Flux, Google Veo 2, Runway, and Ideogram. There was no waiting around for "perfect." Instead, we embraced the momentum, shared in-progress work early, and built on top of each other’s thinking.

整个设计探索过程中，我们借助 Flux、Google Veo 2、Runway 和 Ideogram 等工具，共生成了**逾 15,000 张图像与视频**。我们并未等待所谓“完美”方案的出现，而是顺势而为，及早共享阶段性成果，并在彼此思路的基础上持续共建、共同演进。

## Prototyping with v0

## 借助 v0 进行原型开发

For the site and registration flow, we turned to [v0](https://v0.dev/), which helps you quickly create your ideas through simple text prompts. Once the core structure and functionality were mapped in Figma, it made sense to move straight into code.

针对网站整体架构与注册流程，我们采用了 [v0](https://v0.dev/) 工具——它可通过简洁的文本提示，快速将构想转化为可交互原型。当核心结构与功能已在 Figma 中完成梳理后，直接进入编码阶段便成为最自然的选择。

We prompted key parts of the registration, [schedule](https://v0.dev/chat/vercel-ai-event-schedule-usYe0dLnkve), and [gallery](https://v0.dev/chat/vercel-ai-event-schedule-usYe0dLnkve) interactions directly in v0, aligning to our design system. Because we shipped live prototypes on day one, we could share, gather feedback, and iterate rapidly.

我们直接在 v0 中，以文本提示方式驱动注册流程、[日程安排](https://v0.dev/chat/vercel-ai-event-schedule-usYe0dLnkve) 与 [图库展示](https://v0.dev/chat/vercel-ai-event-schedule-usYe0dLnkve) 等关键交互模块的生成，并严格遵循我们的设计系统规范。正因我们首日即上线可运行的原型，团队得以即时分享、快速收集反馈，并高效迭代优化。

Having this kind of prototyping capability within the Design team was a huge unlock. It saved time and made handoff more efficient. Design Engineering started from real components, not mockups. By the time they stepped in, the structure, layout, and interactions were already set and ready for their final sprinkle of magic.

在设计团队内部具备此类原型制作能力，是一次重大的突破。它节省了时间，并使设计交付更加高效。设计工程团队直接基于真实组件开展工作，而非静态线框图或效果图。当他们介入时，页面结构、布局与交互逻辑早已确定，只待他们施展最后的“魔法”。

## Fluid motion and interaction

## 流畅的动效与交互

While the concept was being shaped, we started experimenting on how users would interact with it on the site. One thing was clear: we wanted some type of fluid.

在概念逐步成形的过程中，我们便开始探索用户如何在网站上与之交互。有一点非常明确：我们需要某种“流体”般的质感。

We began by translating some of the AI concepts into code, aiming to capture the same sense of motion and lighting. We used a ray-marching rendering technique to create a smooth surface without any visible polygons.

我们首先将部分 AI 概念转化为代码，力求还原其动态感与光影表现。我们采用光线行进（ray-marching）渲染技术，生成表面光滑、无可见多边形的几何体。

Try the demo → [ship-25-explorations.vercel.app/depth](https://ship-25-explorations.vercel.app/depth)

尝试演示 → [ship-25-explorations.vercel.app/depth](https://ship-25-explorations.vercel.app/depth)

We also experimented with a glass prism. Since we were using ray-marching, we could simulate how light bends through transparent materials.

我们还尝试了玻璃棱镜效果。得益于光线行进技术，我们能够精准模拟光线在透明材质中的折射行为。

Try the demo → [ship-25-explorations.vercel.app/liquid](https://ship-25-explorations.vercel.app/liquid)

尝试演示 → [ship-25-explorations.vercel.app/liquid](https://ship-25-explorations.vercel.app/liquid)

Once we had the shape and rendering process in place, we began layering in interactions.

在基本形态与渲染流程确立之后，我们开始逐层叠加交互逻辑。

Try the demo → [ship-25-explorations.vercel.app/ferro-pyramid](https://ship-25-explorations.vercel.app/ferro-pyramid?debugTarget=screen)

尝试演示 → [ship-25-explorations.vercel.app/ferro-pyramid](https://ship-25-explorations.vercel.app/ferro-pyramid?debugTarget=screen)

We explored simulating ferrofluid by displacing a subdivided mesh.

我们通过位移细分网格的方式，探索了铁磁流体（ferrofluid）的模拟效果。

Try the demo → [ship-25-explorations.vercel.app/ferro-mesh-2](https://ship-25-explorations.vercel.app/ferro-mesh-2)

尝试演示 → [ship-25-explorations.vercel.app/ferro-mesh-2](https://ship-25-explorations.vercel.app/ferro-mesh-2)

This created the effect of fluid particles acting as magnetic fields, pushing the mesh outward.

这一设计实现了流体粒子模拟磁场的效果，将网格向外推挤。

Try the demo → [ship-25-explorations.vercel.app/ferro-mesh](https://ship-25-explorations.vercel.app/ferro-mesh)

尝试演示 → [ship-25-explorations.vercel.app/ferro-mesh](https://ship-25-explorations.vercel.app/ferro-mesh)

That version didn’t quite feel right, so we shifted to simulating more realistic fluids using ray-marching. In one version, two simulations ran in parallel, one for the floor and another for the tetrahedron.

该版本观感尚不理想，因此我们转向采用光线行进（ray-marching）技术模拟更逼真的流体效果。在某一版本中，两个仿真并行运行：一个用于地面，另一个用于四面体。

Try the demo → [ship-25-explorations.vercel.app/water-2](https://ship-25-explorations.vercel.app/water-2)

尝试演示 → [ship-25-explorations.vercel.app/water-2](https://ship-25-explorations.vercel.app/water-2)

How does this work? The fluid simulation is calculated in one shader, then passed as input into a ray-marching scene. In this setup, the simulation runs on the large plane, while a smaller plane acts as a "ray-marching portal."

其原理是什么？流体仿真在一个着色器（shader）中完成计算，再作为输入传入光线行进场景。在此架构中，仿真运行于大平面之上，而一个小平面则充当“光线行进入口”（ray-marching portal）。

This means the liquid isn’t made from triangles. Instead, we simulate a light ray shooting from the camera through the portal and into the surface.

这意味着液体并非由三角形构成；相反，我们模拟一条光线——它从相机出发，穿过该入口，射向表面。

After that, we added shading and made the simulation collide with a solid prism at the center.

此后，我们添加了着色效果，并让仿真与中心处的一个实心棱柱发生碰撞。

Try the demo → [ship-25-explorations.vercel.app/water-triangle](https://ship-25-explorations.vercel.app/water-triangle)

尝试演示 → [ship-25-explorations.vercel.app/water-triangle](https://ship-25-explorations.vercel.app/water-triangle)

Once we adjusted the lighting and interaction, we had our hero.

在调整完光照与交互效果后，我们的主角作品就此诞生。

## Simplifying the stack

## 简化技术栈

Conference sites can be deceptively complex. Content needs to be editable on-demand, without deployments. Registration data needs to be queryable. Everything needs to feel fast.

会议网站表面看似简单，实则暗藏复杂性。内容需支持按需编辑，且无需重新部署；注册数据需支持灵活查询；整个体验必须流畅迅捷。

### Learning from the past

### 从过往经验中汲取教训

In past years, we supported those needs with a mix of external tools and internal caching layers. It got the job done, but maintaining that balance became increasingly difficult.

过去几年中，我们通过组合使用外部工具与内部缓存层来满足上述需求。虽然最终实现了目标，但维持这种架构平衡却变得愈发困难。

To reduce latency, we first tried introducing [Redis](https://vercel.com/marketplace/category/storage) as a fast, supplementary data layer. It helped with performance in key areas, but introduced new challenges. Duplicated data, extra update steps, limited querying, and a reliance on engineering for edits to high-priority information like promo codes or workshop capacity.

为降低延迟，我们最初尝试引入 [Redis](https://vercel.com/marketplace/category/storage) 作为快速、辅助性的数据层。它确实在关键场景下提升了性能，但也带来了新问题：数据重复、额外的更新步骤、查询能力受限，以及对工程团队的高度依赖——例如修改优惠码或工作坊容量等高优先级信息时，均需工程师介入。

### A new foundation for the future

### 面向未来的新基石

This year, we stepped back and simplified. We built the site as a [Next.js](https://nextjs.org/) app, backed by a [Postgres database](https://vercel.com/marketplace/category/storage), and powered by [Payload](https://payloadcms.com/) as the CMS. With full ownership over the API and database, we could shape the system around how we actually work.

今年，我们重新审视并大幅简化了架构：将网站构建为一个基于 [Next.js](https://nextjs.org/) 的应用，底层采用 [Postgres 数据库](https://vercel.com/marketplace/category/storage)，并以 [Payload](https://payloadcms.com/) 作为内容管理系统（CMS）。由于完全掌控 API 与数据库，我们得以围绕真实工作流来定制系统设计。

Previously, content lived in one place, registrant data in another, and engineering had their own models. Payload let us unify those concerns into a single source of truth:

过去，内容散落在一处，注册者数据存于另一处，而工程团队又维护着各自的模型。Payload 帮助我们将这些关注点统一整合，形成单一可信数据源：

- A CMS for editable landing-page content  
- 用于编辑落地页内容的内容管理系统（CMS）

- A searchable, real-time database of registrants  
- 可搜索、实时更新的注册者数据库

- A backend that engineering could build against directly, without sync logic or duplicated models  
- 一个工程团队可直接对接的后端，无需同步逻辑，也无需重复定义模型。

The result was a system where teams could move independently. The Events team could manage capacity, content, and promo codes without engineering involvement. Developers could optimize for performance without waiting on upstream APIs.  
最终形成了一套支持各团队独立运作的系统：活动（Events）团队可自主管理容量、内容和促销码，无需工程师介入；开发人员则能专注性能优化，无需等待上游 API 的响应。

### Rendering strategies and caching  
### 渲染策略与缓存

This stack gave us more control, but we still had to be deliberate about speed. We used [Incremental Static Regeneration (ISR)](https://vercel.com/blog/isr-a-flexible-way-to-cache-dynamic-content) for CMS-driven pages, with on-demand cache invalidation tied to updates. [Partial Prerendering (PPR)](https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model) let us generate most of the homepage at build time, while keeping elements like CTAs and login states dynamic.  
该技术栈赋予我们更强的控制力，但速度优化仍需审慎设计。我们对 CMS 驱动的页面采用[增量静态再生（ISR）](https://vercel.com/blog/isr-a-flexible-way-to-cache-dynamic-content)，并根据内容更新按需触发缓存失效；同时借助[部分预渲染（PPR）](https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model)，在构建时生成首页大部分内容，而将行动号召（CTA）按钮、登录状态等元素保持动态。

We used the [`use cache` directive](https://nextjs.org/docs/app/api-reference/directives/use-cache) and [cacheLife](https://nextjs.org/docs/app/api-reference/functions/cacheLife) to tune freshness by content type. For example, we kept ticket availability up to date with a short cache lifetime, while allowing lower-churn content to stay cached longer. [after()](https://nextjs.org/docs/app/api-reference/functions/after) handled post-checkout logic like sending confirmation emails and logging registrations without holding up the user flow.  
我们通过 [`use cache` 指令](https://nextjs.org/docs/app/api-reference/directives/use-cache) 和 [cacheLife](https://nextjs.org/docs/app/api-reference/functions/cacheLife) 函数，按内容类型精细化调控缓存新鲜度。例如，票务余量采用较短缓存周期以确保实时性，而低频更新的内容（如品牌文案）则可长期缓存。[after()](https://nextjs.org/docs/app/api-reference/functions/after) 函数则用于处理结账后的异步逻辑（如发送确认邮件、记录注册信息），全程不阻塞用户操作流。

### Dogfooding the Vercel platform  
### 深度使用 Vercel 平台（“自用即测试”）

The Payload admin panel lives on the same domain as the Vercel and the Ship site, which made debugging and logging more streamlined. [Sign In with Vercel](https://vercel.com/docs/integrations/sign-in-with-vercel) gives us secure, account-based access without additional setup. Our backend [lives in the monorepo](https://vercel.com/blog/how-vercel-adopted-microfrontends), so we could use shared UI assets, like logos or design tokens, directly in the CMS.  
Payload 管理后台与 Vercel 官网及 Ship 站点部署在同一域名下，大幅简化了调试与日志排查流程。[Vercel 登录（Sign In with Vercel）](https://vercel.com/docs/integrations/sign-in-with-vercel) 提供开箱即用、基于账户的安全访问能力，无需额外配置。我们的后端服务[托管于统一的单体仓库（monorepo）](https://vercel.com/blog/how-vercel-adopted-microfrontends)中，因此可直接在 CMS 中复用共享的 UI 资源，例如 Logo 或设计令牌（design tokens）。

This kept the experience consistent, simplified setup, and made collaboration easier across teams.  
此举保障了整体体验的一致性，降低了环境搭建复杂度，并显著提升了跨团队协作效率。

### Modular, shippable components  
### 模块化、可交付的组件

To support multiple events each year, we built a library of reusable, themeable components using [shadcn](https://ui.shadcn.com/), [Geist](https://vercel.com/geist/colors), and [cva](https://cva.style/docs). This gave us the flexibility to iterate quickly without sacrificing consistency across properties.  
为支撑每年多场活动的快速上线，我们基于 [shadcn](https://ui.shadcn.com/)、[Geist](https://vercel.com/geist/colors) 和 [cva](https://cva.style/docs) 构建了一套可复用、可主题化的组件库。这既赋予我们敏捷迭代的能力，又确保了不同活动站点间视觉与交互体验的高度一致性。

For transactional emails, we used [React Email](https://react.email/) and plugged it directly into our CMS. Marketing could preview and edit content live, with no engineering lift.

对于事务性邮件，我们采用了 [React Email](https://react.email/)，并将其直接集成至我们的内容管理系统（CMS）中。市场团队可实时预览和编辑邮件内容，全程无需工程师介入。

These shared systems made it easier for Brand, Engineering, and Marketing to collaborate across surfaces, and helped us move faster while keeping everything on-brand.

这些共享系统显著提升了品牌、工程与市场团队在多端场景下的协作效率，使我们得以加速推进项目，同时确保所有产出始终契合品牌调性。

### Challenges and future improvements

### 挑战与未来优化方向

Managing our own database gave us flexibility, but surfaced some limitations in our local tooling. Standing up Postgres locally, running migrations, and seeding data added overhead when working on UI changes or prototyping features. Seed scripts helped, but the local developer experience isn't where it needs to be.

自主管理数据库赋予了我们高度灵活性，但也暴露了本地开发工具链的一些局限性：在本地启动 PostgreSQL、执行迁移脚本以及填充测试数据，为 UI 调整和功能原型开发带来了额外负担。虽然种子脚本（seed scripts）提供了一定帮助，但当前的本地开发者体验仍远未达到理想水平。

We’re now focusing on automating more of that setup. Previewing real data in local environments, simplifying schema updates, and improving workflows for dynamic content like Open Graph generation and campaign previews.

目前，我们正着力于进一步自动化上述流程：实现在本地环境中预览真实数据、简化数据库 Schema 更新操作，并优化动态内容（如 Open Graph 图像生成、营销活动预览）的工作流。

On the frontend, we’re continuing to explore how to deliver more visual detail without sacrificing speed or performance. Tools like [Motion](https://motion.dev/) and [Three.js](https://threejs.org/) helped us push this year’s visuals forward.

在前端层面，我们持续探索如何在不牺牲加载速度与运行性能的前提下，呈现更丰富的视觉细节。[Motion](https://motion.dev/) 与 [Three.js](https://threejs.org/) 等工具助力我们显著提升了今年的视觉表现力。

## Scroll animation and sticky header

## 滚动动画与悬浮页头

We wanted the site to move as smoothly as it looked. One standout moment was the **What you can expect** section, built using `useTransform` from [Motion for React](https://motion.dev/). Sticky containers and full-screen sections gave us control over scroll behavior, including a custom zoom effect that took a bit of fun math to get right. v0 helped us prototype the logic quickly and dial in the feel.

我们希望网站不仅视觉上赏心悦目，动效也如丝般顺滑。其中一大亮点是 **“您可期待的内容”**（What you can expect）板块——该模块基于 [Motion for React](https://motion.dev/) 的 `useTransform` 实现。借助悬浮容器（sticky containers）与全屏区块（full-screen sections），我们精准掌控滚动行为，甚至实现了一个需经巧妙数学计算才能精准还原的自定义缩放效果。v0 工具帮助我们快速完成逻辑原型验证，并精细调校交互手感。

Another subtle touch was the sticky header. To make sure it adapted across light and dark sections, we tested several options, including [clip-paths](https://developer.mozilla.org/en-US/docs/Web/CSS/clip-path). We eventually landed on a much simpler solution using [mix-blend-mode](https://developer.mozilla.org/en-US/docs/Web/CSS/mix-blend-mode).

另一处精妙细节是悬浮页头（sticky header）。为确保其在明暗主题区块间自然适配，我们尝试了多种方案，包括 [clip-path](https://developer.mozilla.org/zh-CN/docs/Web/CSS/clip-path)。最终，我们选择了一个更为简洁优雅的解法——利用 [mix-blend-mode](https://developer.mozilla.org/zh-CN/docs/Web/CSS/mix-blend-mode) 实现自动融合。

## See you at Ship

## 期待在 Ship 大会与您相见

The registration page was just the start. It brought Brand, Engineering, and Marketing together in a way that felt fast, fluid, and collaborative from day one.

注册页面仅仅是个开始。它从第一天起就将品牌、工程与市场团队凝聚在一起，整个协作过程迅捷、流畅且富有默契。

We prototyped in code, explored quickly, made a few pivots, and pushed the system forward along the way. Not everything went as expected, but it came together into something we’re proud of.

我们以代码快速构建原型，迅速探索各种可能性，适时调整方向，并在过程中持续推动系统演进。并非所有事情都按预期发展，但最终成果却令我们倍感自豪。

And we’re just getting started. The full experience is on the way. Keynotes, IRL moments, and everything we’ve been building behind the scenes. If you haven’t already, sign up now and be part of it. We'd love to chat with you there.

而这一切，才刚刚拉开序幕。完整的体验正加速到来——主题演讲、线下精彩瞬间（IRL moments），以及我们幕后持续打磨的每一处细节。若您尚未报名，请即刻加入，成为其中一员。我们非常期待在那里与您畅聊！

And yes, we’re still iterating. Because when you ship, you learn. And when you learn, you ship again.

是的，我们仍在持续迭代。因为唯有交付，才能真正学习；而每一次学习，又将催生下一次交付。

[**Sign up for Vercel Ship 2025 today**  
**立即报名参加 Vercel Ship 2025**  

Hear the latest updates on AI, compute, and more. Join us in NYC or streaming online.  
了解 AI、算力等领域的最新动态。欢迎亲临纽约现场，或在线观看直播。  

Sign up  
立即报名](https://vercel.com/ship?utm_source=vercel_site&utm_medium=blog&utm_campaign=vercel_ship)

_Special thanks to Matias Gonzalez Fernandez and the rest of_ [_basement.studio_](https://basement.studio/) _for partnering with us to create the Vercel Ship site._  
_特别感谢 Matias Gonzalez Fernandez 及_ [_basement.studio_](https://basement.studio/) _全体成员，携手我们共同打造 Vercel Ship 官网。_
&#123;% endraw %}
