---
title: "Moving from Gatsby to Next.js - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/navigating-tradeoffs-in-large-scale-website-migrations"
date: "2023-02-09"
scraped_at: "2026-03-02T09:55:16.897683663+00:00"
language: "en-zh"
translated: true
description: "Navigating large scale migrations"
---

Feb 9, 2023

2023 年 2 月 9 日

Fullstack 机构 basement.studio 分享了他们将一个大规模基于 React 的网站从 Gatsby 迁移到 Next.js 过程中的观察与思考。

“为什么要把一个运行 perfectly 的网站迁移到一个新框架？终端用户真能从中受益，还是这仅仅是为了满足开发团队的需求？”

我们近期协助一位客户，在其整体网页体验的重构过程中，共同梳理并最终敲定了这一技术决策。

当时，客户的代码库包含 30 多个静态页面、约 600 个动态页面，并为所有这些页面提供 15 种语言的本地化支持。代码中充斥着大量插件、各类“逃生舱口（escape hatches）”，以及令人难以忍受的构建耗时。随着我们与开发团队沟通的深入，双方愈发一致地认为：作为本次重构的一部分，改善开发者体验（DX）、缩短构建时间、并提供更灵活通用的 API，将把开发者带入一个“成功之坑（pit of success）”——从而加速迭代周期，最终为终端用户提供更优质的网站体验。

## 在 Vercel 上实现更平滑的迁移

## 在 Vercel 上实现更顺畅的迁移

该客户此前已采用 Vercel 托管其网站，这不仅大幅降低了我们的迁移难度，也显著提升了客户侧的安全性。在项目启动之初，我们就明确：只需专注代码迁移本身，无需考虑基础设施变更或配置调整。我们亦有信心——一旦出现任何异常，可立即回滚至前一稳定版本。  
除 Vercel 提供的这一安全兜底机制外，还有三项关键能力助力我们加速迁移进程，并确保面向终端用户及内部利益相关方的零停机发布：

- **便捷的测试与质量保障（QA）**：Vercel 的 [预览部署（Preview Deployments）](https://vercel.com/docs/concepts/deployments/preview-deployments) 功能至关重要——我们需对每个迁移完成的页面逐一验证，确保无功能破坏。而 Vercel 提供的五分钟级构建速度，令我们倍感欣喜。

- **渐进式采纳（Incrementally adoptable）**：在成功验证 Next.js 迁移方案可行性后，后续工作推进得非常迅速。更重要的是，由于网站持续托管于 Vercel，我们得以按需逐步改造站点，无需一次性解决全部问题，也完全规避了基础设施迁移带来的复杂性与风险。

- **无头托管（Headless hosting）**：客户早已采用无头 CMS —— Ghost，因此天然具备无头架构的核心优势之一：基础设施灵活性。我们仅需对接其 API 层；其余基础设施管理与数据获取逻辑，均由 Vercel 持续无缝承接。

- **Performance tracking**: By keeping the site on Vercel, we were able to leverage Vercel [Analytics](https://vercel.com/docs/concepts/analytics) and [Checks](https://vercel.com/docs/integrations/checks-overview) to make sure we were only ever _improving_ site performance. Over the course of our project, the **Real Experience Score improved from 79 to 90 points**. This gave us the confidence to know that the project was a success, and helped our clients prove the concrete impact of the migration.

- **性能追踪**：通过将网站持续部署在 Vercel 上，我们得以充分利用 Vercel 的 [Analytics（分析）](https://vercel.com/docs/concepts/analytics) 和 [Checks（检查）](https://vercel.com/docs/integrations/checks-overview) 功能，确保网站性能始终处于 _持续提升_ 状态。在项目推进过程中，**真实体验评分（Real Experience Score）从 79 分提升至 90 分**。这让我们确信项目取得了成功，也帮助客户向利益相关方清晰地证明了此次迁移所带来的实际成效。

## Thinking in Next.js

## 以 Next.js 的思维模式开发

So how did our client decide to make the switch from Gatsby to Next.js? Since Vercel took away most of the external considerations, we were able to weigh the ergonomics of both frameworks. We began by looking at the codebase through the lens of both models to start “thinking in Next.js” (ode to the famous [Thinking in React](https://reactjs.org/docs/thinking-in-react.html#gatsby-focus-wrapper)).

那么，我们的客户是如何决定从 Gatsby 迁移到 Next.js 的呢？由于 Vercel 消除了绝大多数外部约束因素，我们得以专注于评估两种框架的开发体验与工程友好性。我们首先以两种框架的设计范式为视角，重新审视整个代码库，从而开启“以 Next.js 的思维模式开发”之旅（致敬广为人知的 [Thinking in React（以 React 的思维模式开发）](https://reactjs.org/docs/thinking-in-react.html#gatsby-focus-wrapper)）。

Here's the key difference: **Next.js is a fullstack framework.**

关键区别在于：**Next.js 是一个全栈框架**。

On the surface, it provides developers with APIs that unlock several rendering strategies— [Static Generation](https://vercel.com/docs/concepts/get-started/compute#static-site-generation---ssg), [Server-side](https://vercel.com/docs/concepts/next.js/overview#server-side-rendering-(ssr)), and [Incremental Static Regeneration (ISR)](https://vercel.com/docs/concepts/next.js/overview#incremental-static-regeneration). Next.js also wraps basic web primitives like images, links, scripts, and fonts with well-thought-out abstractions. Working with React and _every_ styling solution is much simpler.

表面上看，它为开发者提供了多种渲染策略的 API 支持——包括 [静态生成（Static Generation）](https://vercel.com/docs/concepts/get-started/compute#static-site-generation---ssg)、[服务端渲染（Server-Side Rendering, SSR）](https://vercel.com/docs/concepts/next.js/overview#server-side-rendering-(ssr))，以及 [增量静态再生（Incremental Static Regeneration, ISR）](https://vercel.com/docs/concepts/next.js/overview#incremental-static-regeneration)。Next.js 还对图像（`<Image>`）、链接（`<Link>`）、脚本（`<Script>`）和字体等基础 Web 原语进行了深思熟虑的封装与抽象。无论是使用 React，还是搭配 _任意_ 样式方案（如 CSS Modules、Tailwind CSS、Styled Components 等），开发体验都显著简化。

At a deeper level, Next.js seamlessly provides ways of handling different edge cases that may arise. And that leads us to one of the critical differences between Next.js and Gatsby, the client's original framework: **how they approach extensibility.**

更深层次上，Next.js 能够无缝应对各类边界场景与特殊需求。这也引出了 Next.js 与客户原有框架 Gatsby 的一项关键差异：**二者对可扩展性（extensibility）的设计哲学截然不同**。

## Extensibility

## 可扩展性

Next.js provides developers with primitives that can be adapted to any use case, whereas Gatsby—while it still offers many built-in primitives—tends to suggest a plugin for almost everything.

Next.js 向开发者提供的是高度灵活的基础构建单元（primitives），可按需适配任意业务场景；而 Gatsby——尽管同样内置了大量开箱即用的功能模块——却倾向于为几乎所有功能都推荐一个插件来实现。

This means that if you want to add a new feature to a Gatsby site, you’ll likely need to find and install a plugin that provides that feature. This can make it easier to start, but it can also make it harder to customize your site to meet specific needs. Let's explore an example.

这意味着：若要在 Gatsby 网站中新增某项功能，你通常需要先寻找并安装一个能提供该功能的插件。这种方式虽便于快速起步，但也可能限制你对网站进行深度定制以满足特定业务需求的能力。下面我们通过一个具体示例来说明。

### Image optimization

### 图像优化

Optimizing images is a critical step to take to build a lean and efficient website.

优化图像对于构建轻量、高效的网站而言是一个至关重要的步骤。

- How does Gatsby solve image optimization? You will need the `gatsby-plugin-image` plugin. To make that work, you will also need `gatsby-plugin-sharp`. Additionally, install `gatsby-source-filesystem` if you are using static images and `gatsby-transformer-sharp` in case you use dynamic ones.

- Gatsby 是如何解决图像优化问题的？你需要安装 `gatsby-plugin-image` 插件。要使其正常工作，你还需安装 `gatsby-plugin-sharp`。此外，若使用静态图像，请安装 `gatsby-source-filesystem`；若使用动态图像，则还需安装 `gatsby-transformer-sharp`。

- How does Next.js solve image optimization? Just `import Image from 'next/image'.`

- Next.js 又是如何实现图像优化的？只需一行导入语句：`import Image from 'next/image'`。

This is how you’d do image optimization for each framework:

以下是各框架中实现图像优化的方式：

That’s a big difference. **Thirty-one lines of code, plus three npm packages to accomplish what Next.js can do with just seven lines of code.**

差异非常明显。**Gatsby 需要 31 行代码外加三个 npm 包，才能完成 Next.js 仅用 7 行代码即可实现的功能。**

Additionally, Next.js’ Image component allows the developer to tweak how the image will load and look by just passing props into it. This declarative approach scales really well and makes the codebase super easy to understand. It'll also be beneficial when they're upgrading to future versions, as they won't need to worry about the compatibility of those upgrades.

此外，Next.js 的 `Image` 组件允许开发者仅通过向其传入属性（props）即可灵活调整图像的加载行为与显示效果。这种声明式方法具有极佳的可扩展性，使代码库极为清晰易懂；同时，在未来升级框架版本时也大有裨益——开发者无需担忧相关升级带来的兼容性问题。

When migrating, images were not as much work as you’d think. It was mainly deleting code and ensuring that styles didn’t break.

迁移过程中，图像处理的工作量远没有预想中那么大：主要任务不过是删除旧代码，并确保样式不被破坏。

### Fetching remote data

### 获取远程数据

Every big website, at some point, needs to get remote data from somewhere. This was certainly the case for this project, which read data from:

- Ghost to get blog posts  
- YouTube to get the latest videos  
- GitHub to get information about their repo  

每个大型网站在某个阶段都需要从远程来源获取数据。本项目正是如此，它从以下来源读取数据：

- Ghost：获取博客文章  
- YouTube：获取最新视频  
- GitHub：获取其代码仓库的相关信息  

In Gatsby, for each data source, we’d use a different plugin. For Ghost, we’d use `gatsby-source-ghost` and `gatsby-plugin-ghost-images`. For YouTube, we’d use `gatsby-source-youtube-v3`. For GitHub, we’d use `gatsby-source-custom-api`. These were four different dependencies, which needed to be understood by the developer, and consumed in different ways across the application.

在 Gatsby 中，每种数据源都需要使用不同的插件：Ghost 使用 `gatsby-source-ghost` 和 `gatsby-plugin-ghost-images`；YouTube 使用 `gatsby-source-youtube-v3`；GitHub 使用 `gatsby-source-custom-api`。这共计四个独立依赖项，开发者需分别理解其机制，并在应用各处以不同方式调用它们。

In Next.js, we simply `fetch`ed data from its source and passed the data down via `getStaticProps`. Developers now don’t need to go through different plugin documentation, explore various files, and do lots of `cmd + shift + F` (global searches), just to understand how the data gets to the UI: now they just see the data being fetched on the spot and then passed down via props (a common pattern for React developers).

而在 Next.js 中，我们只需直接 `fetch` 远程数据，并通过 `getStaticProps` 将数据向下传递。开发者不再需要查阅各类插件文档、遍历多个配置文件，或频繁执行 `cmd + shift + F`（全局搜索）来理清数据如何抵达 UI 层——现在他们只需在同一处看到数据被实时获取，再经由 props 传递下去（这正是 React 开发者所熟悉的通用模式）。

Again, let’s look at a practical code example:

再次来看一个实际的代码示例：

This is a real example, taken from our client's previous codebase (left), and Next.js (right). Again, more than the difference in terms of the number of lines of code, the most important change here is that in Gatsby, there are several layers you need to understand just to know how that `stargazers_count` reaches the UI (an npm package, `gatsby-config.js` → `gatsby-node.js` → render function). In the Next.js example, it’s all condensed into one file and two functions. Colocation is important for us, and the team's developers really enjoyed not having to deal with `gatsby-config` and `gatsby-node`.

这是从客户原有代码库（左侧）与 Next.js 实现（右侧）中截取的真实示例。与代码行数差异相比，此处最关键的改进在于：在 Gatsby 中，要弄清 `stargazers_count` 如何最终呈现在 UI 上，开发者必须理解多个抽象层级（一个 npm 包 → `gatsby-config.js` → `gatsby-node.js` → 渲染函数）；而在 Next.js 示例中，全部逻辑被浓缩于单个文件内的两个函数中。“同地协作”（Colocation）对我们至关重要，团队开发者也十分乐于摆脱 `gatsby-config.js` 和 `gatsby-node.js` 的繁琐配置。

Additionally, Gatsby forces all the data to pass through GraphQL, which gets difficult when dealing with remote APIs that do not expose a GraphQL endpoint. In Next.js, you can use GraphQL, `fetch`, or node’s `fs`—whatever you want.

此外，Gatsby 强制所有数据必须经由 GraphQL 流转，这在对接不提供 GraphQL 接口的远程 API 时会带来显著困难。而在 Next.js 中，你可以自由选择使用 GraphQL、原生 `fetch`，甚至 Node.js 的 `fs` 模块——一切随心所欲。

## Improving build times

## 缩短构建时间

One of the biggest issues our client had when running Gatsby was the long build times. **We were circling 35-minute build times.** That means, on _every_ push, the developer would need to wait half an hour (sometimes even more) just to share progress with coworkers. This made iteration cycles really slow, and therefore shipping new features was a drag.

客户在使用 Gatsby 时遇到的最大问题之一就是构建时间过长。**构建时间常常接近 35 分钟。** 这意味着，每次代码推送后，开发者都需要等待半小时（有时甚至更久），才能将进展分享给同事。这使得迭代周期变得极其缓慢，因而新功能的上线也成了一件令人头疼的事。

Let’s be fair: the site is big. At each build, we were creating close to **10k static pages** (`(static + dynamic pages) * locales`). How could we go faster than this if we were not server rendering?

我们得客观看待：这个网站规模确实很大。每次构建时，我们都会生成近 **10,000 个静态页面**（`（静态页面 + 动态页面）× 多语言版本数`）。如果不采用服务端渲染（SSR），我们还能如何进一步提速？

Luckily, Next.js is very flexible. By taking a hybrid approach, generating the most important pages at build time, while not generating less frequently visited pages and localized ones, we could make builds much leaner. But how would we ensure that every page of the site remains fast? We’d use [Incremental Static Regeneration (ISR)](https://vercel.com/docs/concepts/incremental-static-regeneration/overview): the first time a user requests a page that’s not cached, the Vercel server would:

幸运的是，Next.js 具有极高的灵活性。我们采用了混合策略：在构建时仅预先生成最关键、访问最频繁的页面，而对访问频率较低或需多语言支持的页面则延迟生成。这样一来，构建过程就轻量得多。但如何确保网站每个页面依然保持高速响应？我们启用了 [增量静态再生（Incremental Static Regeneration, ISR）](https://vercel.com/docs/concepts/incremental-static-regeneration/overview)：当用户首次请求一个尚未缓存的页面时，Vercel 服务器会：

1. Generate the page and return the HTML + CSS + JS  
2. Push the newly generated page to its content delivery network (CDN)

1. 生成该页面，并返回 HTML + CSS + JS  
2. 将新生成的页面推送到其内容分发网络（CDN）

This means, yes, the very first user would take a loading time hit by needing to go to the origin server, but subsequent users would get a fast response from the CDN. That was a tradeoff we were willing to make.

这意味着，第一位访问该页面的用户确实会因需回源服务器生成页面而承受一定的加载延迟；但后续所有用户都将直接从 CDN 快速获取响应。这一权衡，我们欣然接受。

Let’s look at how generating static pages works for both of these frameworks.

接下来，我们来看看这两种框架各自是如何生成静态页面的。

With this strategy, our build times **went down from 35 minutes to just five minutes**. Learn more about ISR [in the Next.js docs](https://nextjs.org/docs/basic-features/data-fetching/incremental-static-regeneration).

借助这一策略，我们的构建时间**从 35 分钟大幅缩短至仅 5 分钟**。有关 ISR 的更多详情，请参阅 [Next.js 官方文档](https://nextjs.org/docs/basic-features/data-fetching/incremental-static-regeneration)。

## Faster UX, better DX, zero downtime

## 更快的用户体验（UX）、更优的开发体验（DX）、零停机时间

Overall, migrating from Gatsby to Next.js was a great decision for this client. The migration of their large, dynamic website took a small team of developers just **three weeks**, and because of the flexibility and safety provided by Vercel, the site saw zero downtime and internal users were able to continue using the headless tools they were used to with no disruption.

总体而言，从 Gatsby 迁移至 Next.js 是该客户一项极为明智的决策。他们这个大型动态网站的迁移工作，仅由一支小型开发团队耗时 **三周** 即顺利完成；得益于 Vercel 提供的高度灵活性与可靠性保障，整个迁移过程实现了零停机，内部用户也得以无缝继续使用他们所熟悉的无头（headless）工具。

Overall the client was happy to see an 85% reduction in build times, a 14% increase in their Real Experience Score, and a steep reduction in lines of code.

总体而言，客户非常满意：构建时间减少了 85%，真实体验评分（Real Experience Score）提升了 14%，代码行数也大幅减少。

Vercel.com landing page

Vercel.com 官网落地页

### Talk to a migration expert

### 与迁移专家交流

Customer case study

客户案例研究

**79 -> 90** improvement to their Real Experience Score

**79 → 90**：真实体验评分大幅提升

### How Plex 6x their impressions deploying Next.js on Vercel

### Plex 如何通过在 Vercel 上部署 Next.js，将广告曝光量提升至原来的 6 倍

![](images/moving-from-gatsby-to-next_js-vercel/img_001.png)

![](images/moving-from-gatsby-to-next_js-vercel/img_001.png)

Alli Pope

Alli Pope