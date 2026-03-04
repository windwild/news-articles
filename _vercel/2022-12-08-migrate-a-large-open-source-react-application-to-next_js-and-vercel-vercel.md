---
title: "Migrate a large, open-source React application to Next.js and Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/migrating-a-large-open-source-react-application-to-next-js-and-vercel"
date: "2022-12-08"
scraped_at: "2026-03-02T09:57:47.170781633+00:00"
language: "en-zh"
translated: true
description: "Learn how we approached migrating the BBC's large, open-source React application to Next.js and Vercel to see both developer and user experience benefits."
---
&#123;% raw %}

Dec 8, 2022

2022 年 12 月 8 日

If your company started building with React over 5 years ago, chances are you implemented your own custom solution or internal framework. Many engineers and teams want to explore technologies like Next.js and Vercel. However, some don't know where to get started because it's so far from their current reality or they don't see how supporting a custom framework is holding them back.

如果你的公司早在 5 年多以前就开始使用 React 进行开发，那么很可能你们当时构建了自定义解决方案或内部框架。许多工程师和团队希望尝试 Next.js 和 Vercel 等新技术；然而，一些团队却不知从何入手——要么因为这些技术与他们当前的技术栈相距甚远，要么尚未意识到维护一套自定义框架正在拖慢自身发展。

As a coding exercise, we wanted to show what this could look like by migrating a large, open-source React application to use Next.js.

作为一次编码实践，我们希望通过将一个大型开源 React 应用迁移到 Next.js，来直观展示这种转型可能带来的效果。

We managed to **remove 20,000+ lines of code and 30+ dependencies**, all while improving the local iteration speed of making changes from **1.3s to 131ms**. This post will share exactly how we incrementally adopted Next.js and Vercel to rebuild the BBC website.

我们成功**移除了超过 20,000 行代码和 30 多个依赖项**，同时将本地修改后的迭代速度从 **1.3 秒提升至 131 毫秒**。本文将详细分享我们如何通过渐进式方式采用 Next.js 和 Vercel，重建 BBC 网站。

## The BBC React Application

## BBC 的 React 应用

The BBC [website](https://www.bbc.com/thai) is a large, production-grade, [open-source](https://github.com/bbc/simorgh) React application. It is a completely custom React SPA (single-page application). Very few projects of this size and scope are developed in the open. We admire and applaud the work the BBC has done. This isn't about pointing fingers or calling anyone out. You'll see they have done a good job of configuring their application.

BBC 官网（[网站链接](https://www.bbc.com/thai)）是一个大型、面向生产环境的、[开源](https://github.com/bbc/simorgh) React 应用。它是一个完全自研的 React 单页应用（SPA）。如此规模与复杂度的项目，极少以开源形式对外发布。我们由衷钦佩并赞赏 BBC 团队所付出的努力。本文绝非意在指责或批评任何人——事实上，你很快就会发现，BBC 团队已出色地完成了其应用的配置工作。

This project is a perfect example of many large-scale React applications. You or your company could have a similar set up. For example, this application contains:

该项目是众多大规模 React 应用的典型代表；你或你的公司很可能也采用了类似的架构。例如，该应用包含以下技术：

- React  
- React  
- TypeScript  
- TypeScript  
- CSS-in-JS (Emotion)  
- CSS-in-JS（Emotion）

- Babel

- Babel

- Webpack

- Webpack

- ESLint

- ESLint

- Stylelint

- Stylelint

- Prettier

- Prettier

- Cypress

- Cypress

- Jest

- Jest

- Lighthouse checks

- Lighthouse 检查

- Web vitals monitoring

- Web Vitals 监控

- Optimizely (client-side experimentation)

- Optimizely（客户端实验）

- Storybook  
- Storybook（故事书）

- React Router  
- React Router（React 路由器）

- React Helmet  
- React Helmet（React 头部管理器）

- React Lazyload  
- React Lazyload（React 懒加载）

- And more...  
- 还有更多……

This architecture is very common for companies and developers building React applications in the past 5 years. However, many of these integrations and features are included in Next.js with little to no configuration. Our goal is to show switching to Next.js and Vercel can provide a demonstrative impact to your site performance and developer experience.

过去五年中，这种架构在构建 React 应用的公司和开发者中极为常见。然而，Next.js 已原生集成了上述许多集成方案与功能，且几乎无需额外配置。我们的目标是展示：迁移到 Next.js 和 Vercel，可为网站性能与开发者体验带来显著提升。

## Goals  
## 目标

Let’s use the BBC website as an example of such an application and see how we can approach incrementally moving to Next.js and Vercel.

我们以 BBC 网站为例——它正是这样一类典型应用——并探讨如何逐步迁移至 Next.js 和 Vercel。

The primary goals should be:  
主要目标应包括：

- **Reuse as much as possible.** At first glance, there is a decent amount of code that can be reused. Emotion is a good styling library, so there's no need to remove or change that right now. The React components and the [built-in component library](https://github.com/vercel-labs/simorgh/tree/9fe338c4505146ff31e17e57344263cf1bb42557/src/app/legacy/psammead) are well done and seem completely reusable. These should be leveraged and not discarded.

- **尽可能复用现有代码。** 初步来看，大量现有代码具备良好的复用性。Emotion 是一款优秀的样式库，目前无需移除或修改。React 组件以及该应用内置的[组件库](https://github.com/vercel-labs/simorgh/tree/9fe338c4505146ff31e17e57344263cf1bb42557/src/app/legacy/psammead)设计精良，完全可复用。这些资产应被充分利用，而非弃之不用。

- **Delete as much as possible.** This seems contradictory to the previous statement, but it has a different purpose. We want to remove anything from the project that is no longer necessary due to Next.js's capabilities. Let's see how much we can get rid of to reduce the overall code that needs to be maintained so developers can focus on features and delivery.

- **尽可能多地删除冗余代码。** 这看似与前一条原则相矛盾，但其目标截然不同：我们希望借助 Next.js 自身的能力，移除项目中所有已不再必需的代码。让我们看看能精简多少，从而降低整体维护成本，使开发者得以更专注于功能开发与交付。

- **Improve developer experience and performance.** Custom solutions require creating and maintaining documentation or the passing of tribal knowledge to understand the codebase and become a contributor. Projects that leverage well-known and well-documented frameworks such as Next.js allow for quicker onboarding, easier contributions, quicker adoption of new standards (like React Suspense) without having to learn them and implement them into a custom solution, and more.

- **提升开发者体验与应用性能。** 自定义解决方案往往需要编写和维护大量文档，或依赖“团队内部知识”的口耳相传，才能帮助新成员理解代码库并成为有效贡献者。而采用广为人知、文档完备的框架（如 Next.js）的项目，则能显著加快新人上手速度、简化协作流程，并更快速地采纳新兴标准（例如 React Suspense）——无需从零学习并手动集成到自定义架构中。

As a proof of concept, let's see if we can take two primary routes of the BBC website, convert them to use Next.js, and deploy them to Vercel.

作为概念验证（Proof of Concept），我们来尝试将 BBC 网站的两条核心路由迁移至 Next.js，并部署到 Vercel：

- `/news`

- `/news/articles/[slug]`


Let’s walk through how we can approach tackling an update like this.

接下来，我们将逐步梳理此类升级工作的实施路径。

## Getting Started

## 入门指南

We can start by reading through the [documentation](https://github.com/vercel-labs/simorgh/blob/9fe338c4505146ff31e17e57344263cf1bb42557/README.md) and walking the codebase, making mental notes of things that may be useful to us later.

我们可以先通读 [文档](https://github.com/vercel-labs/simorgh/blob/9fe338c4505146ff31e17e57344263cf1bb42557/README.md)，并浏览整个代码库，在脑海中标记出后续可能用得上的关键点。

Then, let's fork the [repository](https://github.com/bbc/simorgh) and make two clones:

接着，请 Fork [该仓库](https://github.com/bbc/simorgh)，并创建两份本地克隆：

- One running the application in its current, untouched state for reference and debugging.

- 一份保持原始未修改状态，用于参考与调试。

- One to run our Next.js changes.  
- 一个用于运行我们的 Next.js 更改。

This will also give us the ability to compare before and after metrics when complete. The best first step to make is to start with the smallest, simplest change, to prove a working concept and get it all the way out to production.  
完成之后，我们还将能够对比变更前后的各项指标。迈出的第一步，最好是选择最小、最简单的改动，以验证方案的可行性，并将其完整地部署到生产环境。

We can take this small change from running locally and deploy it all the way out to Vercel. I’ve found establishing this pipeline up front in a project is easier than battling deployment issues later when you think your work is done. This will also give us [Preview Deployments](https://vercel.com/docs/concepts/deployments/preview-deployments) along the way, so we can see and share our progress with others.  
我们可以将这一微小改动从本地运行开始，一路部署至 Vercel。我发现在项目初期就建立好这条部署流水线，远比在自以为开发完成之后再费力排查部署问题要轻松得多。此外，在此过程中我们还将获得 [预览部署（Preview Deployments）](https://vercel.com/docs/concepts/deployments/preview-deployments)，以便实时查看进展，并与他人共享。

For our first step, based on what we learned from the documentation and code, we decide to get Next.js running with [Emotion](https://emotion.sh/docs/introduction) by:  
作为第一步，结合我们从文档和代码中所学，我们决定通过以下方式让 Next.js 与 [Emotion](https://emotion.sh/docs/introduction) 协同工作：

- Installing Next.js.  
- 安装 Next.js。

- Removing the existing Babel config to let Next.js control as much of the configuration as possible, adding configurations later if needed.  
- 移除现有的 Babel 配置，尽可能交由 Next.js 自行管理配置；如有必要，后续再补充特定配置。

- Adding a `next.config.js` and `_app.js` to [enable Emotion](https://nextjs.org/docs/advanced-features/compiler#emotion).  
- 添加 `next.config.js` 和 `_app.js` 文件，以[启用 Emotion 支持](https://nextjs.org/docs/advanced-features/compiler#emotion)。

- Adding a simplistic `/news` page with minimal styles to prove the configuration works.  
- 添加一个极简的 `/news` 页面，并配以最少样式，用以验证配置是否生效。

- Adding the [Vercel for GitHub integration](https://vercel.com/docs/concepts/git/vercel-for-github) to the forked repository.  
- 为 Fork 的仓库添加 [Vercel for GitHub 集成](https://vercel.com/docs/concepts/git/vercel-for-github)。

This resulted in our [first commit](https://github.com/vercel-labs/simorgh/pull/1/commits/8917b5dd431089a5360fedf9842be7ebaa0a5106). There were some verification issues when building on Vercel, so we can [disable ESLint verification during builds](https://nextjs.org/docs/api-reference/next.config.js/ignoring-eslint), at least for now.  
这最终形成了我们的[首次提交](https://github.com/vercel-labs/simorgh/pull/1/commits/8917b5dd431089a5360fedf9842be7ebaa0a5106)。但在 Vercel 构建时出现了一些校验问题，因此我们可暂时[在构建过程中禁用 ESLint 校验](https://nextjs.org/docs/api-reference/next.config.js/ignoring-eslint)。

This gives us our [first preview](https://simorgh-preview-1.vercel.app/news) with some simple hover styles to prove Emotion is working as expected.

这为我们提供了首个预览版（[first preview](https://simorgh-preview-1.vercel.app/news)），其中包含一些简单的悬停样式，用以验证 Emotion 正常工作。

![Our first commit of incrementally adopting Next.js to rebuild the BBC website.](images/migrate-a-large-open-source-react-application-to-next_js-and-vercel-vercel/img_001.jpg)  
![我们首次提交：逐步采用 Next.js 重构 BBC 网站。](images/migrate-a-large-open-source-react-application-to-next_js-and-vercel-vercel/img_001.jpg)

Our first commit of incrementally adopting Next.js to rebuild the BBC website.

我们首次提交：逐步采用 Next.js 重构 BBC 网站。

With a basic foundation in place, let's see if we can try and get the front page `/news` to render.

在基础框架已搭建完成的前提下，让我们尝试让首页 `/news` 成功渲染。

## Migrating the Front Page

## 迁移首页

The documentation pointed out some key pieces of information for getting started here.

文档中指出了若干关键信息，帮助我们快速上手：

- 应用各模块均有对应的[路由及入口组件](https://github.com/vercel-labs/simorgh/blob/9fe338c4505146ff31e17e57344263cf1bb42557/src/app/routes/README.md)。

- [真实 API 的访问权限仅限于 BBC 内部团队成员](https://github.com/vercel-labs/simorgh/blob/9fe338c4505146ff31e17e57344263cf1bb42557/README.md#topic-pages)；否则，本地开发需依赖[已捕获并保存为 JSON 文件的数据响应](https://github.com/vercel-labs/simorgh/tree/9fe338c4505146ff31e17e57344263cf1bb42557/data)，这些文件已纳入代码仓库。

- 最后，对最初设定的目标稍作调整…… `/news` 路由实际上是动态的！这一点直到我们审阅已保存的数据响应时才变得清晰：它是一个基础路由，会根据该路径所指定的“服务”（例如 `/news`、`/arabic`、`/japanese` 等）提供本地化翻译与内容。

Let’s start by changing the `/news` route we added in Next.js to use the [FrontPage component](https://github.com/vercel-labs/simorgh/blob/9fe338c4505146ff31e17e57344263cf1bb42557/src/app/pages/FrontPage/FrontPage.jsx) and pass it the [corresponding data](https://github.com/vercel-labs/simorgh/blob/9fe338c4505146ff31e17e57344263cf1bb42557/data/news/frontpage/index.json). This seems logical as it has a `pageData` prop. We pass the data, but we’re getting errors.

我们先从修改 Next.js 中新增的 `/news` 路由开始，使其使用 [FrontPage 组件](https://github.com/vercel-labs/simorgh/blob/9fe338c4505146ff31e17e57344263cf1bb42557/src/app/pages/FrontPage/FrontPage.jsx)，并传入[对应的数据](https://github.com/vercel-labs/simorgh/blob/9fe338c4505146ff31e17e57344263cf1bb42557/data/news/frontpage/index.json)。这一设计看似合理——该组件确实接收一个名为 `pageData` 的 prop。然而，当我们传入数据后，却遇到了报错。

The first set of errors is due to the app using import aliases to avoid using relative imports (ie. `../..`), so we need to [let Webpack know how to reconcile them via next.config.js](https://github.com/vercel-labs/simorgh/pull/1/commits/877528583347231b35f90a74d623f2c8e22e1d77#diff-882b2c04b01b2e8b2cdcf1817c30ea503a8005f1c0d54cfff37053b6801fea85R12-R15).

第一类错误源于应用使用了导入别名（import aliases）以避免相对路径导入（如 `../..`），因此我们需要通过 [`next.config.js`](https://github.com/vercel-labs/simorgh/pull/1/commits/877528583347231b35f90a74d623f2c8e22e1d77#diff-882b2c04b01b2e8b2cdcf1817c30ea503a8005f1c0d54cfff37053b6801fea85R12-R15) 告知 Webpack 如何解析这些别名。

The next set of errors is due to an uninitialized state. The website also makes extensive use of [React hooks](https://reactjs.org/docs/hooks-intro.html) for state management.  
接下来的一组错误源于未初始化的状态。该网站还大量使用 [React Hooks](https://reactjs.org/docs/hooks-intro.html) 进行状态管理。

The documentation has a [section on page render lifecycles](https://github.com/vercel-labs/simorgh/tree/9fe338c4505146ff31e17e57344263cf1bb42557#a-page-render-lifecycle) that highlights why we’re getting errors. We need to add the [`PageWrapper component`](https://github.com/vercel-labs/simorgh/blob/9fe338c4505146ff31e17e57344263cf1bb42557/src/app/Layouts/defaultPageWrapper.jsx) and [a handful of context providers](https://github.com/vercel-labs/simorgh/blob/9fe338c4505146ff31e17e57344263cf1bb42557/src/app/legacy/containers/PageHandlers/withContexts.jsx#L33-L59) to `_app.js`. Doing so allows the page to render for the first time!  
文档中有一节专门介绍 [页面渲染生命周期](https://github.com/vercel-labs/simorgh/tree/9fe338c4505146ff31e17e57344263cf1bb42557#a-page-render-lifecycle)，解释了我们为何遇到这些错误。我们需要将 [`PageWrapper 组件`](https://github.com/vercel-labs/simorgh/blob/9fe338c4505146ff31e17e57344263cf1bb42557/src/app/Layouts/defaultPageWrapper.jsx) 及 [若干 Context Provider](https://github.com/vercel-labs/simorgh/blob/9fe338c4505146ff31e17e57344263cf1bb42557/src/app/legacy/containers/PageHandlers/withContexts.jsx#L33-L59) 添加到 `_app.js` 中。如此一来，页面便能首次成功渲染！

_**This is an important lesson to remember when transitioning apps…**_ Passing data to components and wiring up state will cause your application to “light up like a Christmas tree”. You should focus on that very early on in the conversion.  
_**这是应用迁移过程中一条至关重要的经验……**_ 向组件传递数据并建立状态绑定，会使你的应用“像圣诞树一样瞬间亮起”。你应在迁移初期就重点关注这一环节。

However, the Next.js site was showing slightly different data than the unmodified clone we made earlier. The documentation [explains how routes process data before passing it to page-level components](https://github.com/vercel-labs/simorgh/tree/9fe338c4505146ff31e17e57344263cf1bb42557#a-high-level-user-journey). There is a `route` and `getInitialData` for each page. We locate the `getInitialData` for the `/news` page and [apply the appropriate filter functions](https://github.com/vercel-labs/simorgh/blob/9fe338c4505146ff31e17e57344263cf1bb42557/src/app/routes/home/getInitialData/index.js) to the fetched data in Next.js and rendered data matches.  
然而，Next.js 站点所展示的数据与我们此前创建的未经修改的克隆版本略有差异。文档中 [说明了路由如何在将数据传递给页面级组件前对其进行处理](https://github.com/vercel-labs/simorgh/tree/9fe338c4505146ff31e17e57344263cf1bb42557#a-high-level-user-journey)。每个页面都对应一个 `route` 和一个 `getInitialData` 函数。我们定位到 `/news` 页面的 `getInitialData`，并在 Next.js 中对获取到的数据 [应用相应的过滤函数](https://github.com/vercel-labs/simorgh/blob/9fe338c4505146ff31e17e57344263cf1bb42557/src/app/routes/home/getInitialData/index.js)，从而使渲染结果与预期完全一致。

When Vercel tried to deploy these changes, it hit a new build error with timezone data from Moment that wasn’t reproducible during local development. To simulate a production deployment, we can run `npm run build` locally. This led to the discovery that our unmodified clone’s Webpack config is configured to create a `tz` folder with a smaller subset of timezone data to save on bundle size at build/run time. Once we [add the same custom Webpack plugin to our next.config.js](https://github.com/vercel-labs/simorgh/pull/1/commits/d903cb0cf0992ccf01f85d888c200847b4b381d1), Vercel builds and deploys without issue.  
当 Vercel 尝试部署这些变更时，遇到了一个由 Moment 时区数据引发的新构建错误——而该错误在本地开发环境中却无法复现。为模拟生产环境部署，我们可在本地运行 `npm run build`。此举揭示出：我们原始未修改克隆版本的 Webpack 配置被设定为生成一个 `tz` 文件夹，其中仅包含精简版的时区数据，以减小构建及运行时的包体积。一旦我们在 `next.config.js` 中 [加入相同的自定义 Webpack 插件](https://github.com/vercel-labs/simorgh/pull/1/commits/d903cb0cf0992ccf01f85d888c200847b4b381d1)，Vercel 即可顺利构建并完成部署。

To complete this route, we can change the hardcoded `/news` page to be a [dynamic page route](https://nextjs.org/docs/routing/dynamic-routes) so it can load any BBC [service](https://github.com/vercel-labs/simorgh/tree/9fe338c4505146ff31e17e57344263cf1bb42557/data) and [change the “most read” data from being an additional fetch to being fetched with the initial page data](https://github.com/vercel-labs/simorgh/pull/1/commits/165e4e35d6f6ce8971422c3516736b7c019bb6c1) to reach full page parity.  
为完善此路由，我们可以将硬编码的 `/news` 页面改为 [动态页面路由](https://nextjs.org/docs/routing/dynamic-routes)，使其能够加载任意 BBC [服务](https://github.com/vercel-labs/simorgh/tree/9fe338c4505146ff31e17e57344263cf1bb42557/data)；同时，[将“最常阅读”（most read）数据的获取方式，从额外发起一次请求，改为与初始页面数据一并获取](https://github.com/vercel-labs/simorgh/pull/1/commits/165e4e35d6f6ce8971422c3516736b7c019bb6c1)，从而实现与原页面的完全功能对等。

This gives us our [second preview](https://simorgh-preview-2.vercel.app/news) milestone!  
这标志着我们达成了 [第二个预览版里程碑](https://simorgh-preview-2.vercel.app/news)！

![Our application is starting to look more real.](images/migrate-a-large-open-source-react-application-to-next_js-and-vercel-vercel/img_002.jpg)  
![我们的应用正逐渐呈现出真实感。](images/migrate-a-large-open-source-react-application-to-next_js-and-vercel-vercel/img_002.jpg)  

Our application is starting to look more real.  
我们的应用正逐渐呈现出真实感。

We can now view any BBC service as a front page! A few examples:  
我们现在可以将任意 BBC 服务作为首页浏览！以下是一些示例：

- [https://simorgh-preview-2.vercel.app/news](https://simorgh-preview-2.vercel.app/news)  
- [https://simorgh-preview-2.vercel.app/arabic](https://simorgh-preview-2.vercel.app/arabic)

- [https://simorgh-preview-2.vercel.app/japanese](https://simorgh-preview-2.vercel.app/japanese)

- 还有更多内容：[https://github.com/vercel-labs/simorgh/tree/9fe338c4505146ff31e17e57344263cf1bb42557/data](https://github.com/vercel-labs/simorgh/tree/9fe338c4505146ff31e17e57344263cf1bb42557/data)

还有一条路由待添加！

## 添加文章页面

## 添加文章页面（Article Page）

由于大部分状态（state）和上下文（context）已填充完毕，且我们已充分理解页面路由、渲染及初始数据加载的工作机制，因此可快速完成文章页面的开发。

让我们为文章添加一条新的动态路由，[获取初始数据](https://github.com/vercel-labs/simorgh/blob/9fe338c4505146ff31e17e57344263cf1bb42557/data/news/articles/c6v11qzyv8po.json)，[对其进行筛选](https://github.com/vercel-labs/simorgh/pull/1/commits/8f5bc94d4cf1c93f22b0557a471f91dd8cd0d158)，并将其传入 `ArticlePage` 组件。

借此，我们便得到了我们的[第三个预览链接](https://simorgh-preview-3.vercel.app/news/articles/c6v11qzyv8po)，而且[仅需极少工作量](https://github.com/vercel-labs/simorgh/pull/1/commits/1b223e46f8a90f6b6014e9f5485a3ec630c2c7c3)。实现过程确实如此简单。这也再次印证了我们前文的观点：尽早聚焦于数据与状态，是项目成功的关键。

![我们的第三次迭代展示了使用 Next.js 实现的动态路由，包括数据与状态的处理。](images/migrate-a-large-open-source-react-application-to-next_js-and-vercel-vercel/img_003.jpg)  
我们的第三次迭代展示了使用 Next.js 实现的动态路由，包括数据与状态的处理。

根据[官方文档](https://github.com/vercel-labs/simorgh/tree/9fe338c4505146ff31e17e57344263cf1bb42557#local-development)，在不访问 BBC 内部 API 的前提下，仅有两条文章路由可用，因此我们只能使用这两条路由进行测试。

- [https://simorgh-preview-3.vercel.app/news/articles/c6v11qzyv8po](https://simorgh-preview-3.vercel.app/news/articles/c6v11qzyv8po)

- [https://simorgh-preview-3.vercel.app/persian/articles/c4vlle3q337o](https://simorgh-preview-3.vercel.app/persian/articles/c4vlle3q337o)

## Creating a Fake API

## 创建一个模拟 API

To better simulate data coming from a real API, let’s [create a fake API to load page data](https://github.com/vercel-labs/simorgh/pull/1/commits/0831d7f51b58f911f57a784f844cee6890010f7c), which simplifies the code in Next.js pages.

为了更真实地模拟来自真实 API 的数据，我们来[创建一个模拟 API 以加载页面数据](https://github.com/vercel-labs/simorgh/pull/1/commits/0831d7f51b58f911f57a784f844cee6890010f7c)，从而简化 Next.js 页面中的代码。

Note that we don't use Next.js's `/pages/api` convention here because we are using `getStaticProps` to pre-render the pages at build time, which means we cannot fetch data using the running app itself before the app is built. Ideally, the API would be it's own app, but this works for a proof of concept.

请注意，此处我们并未采用 Next.js 的 `/pages/api` 约定，因为我们使用 `getStaticProps` 在构建时对页面进行预渲染；这意味着在应用构建完成前，无法通过正在运行的应用本身获取数据。理想情况下，该 API 应作为独立应用部署，但当前方案已足以验证概念可行性。

We also [add `statusCode` to the initial page data](https://github.com/vercel-labs/simorgh/pull/1/commits/c8311b756fd4bb71461e9bf11dda6f7a3951b55e), which allows us to [properly render an error page](https://simorgh-preview-error-page.vercel.app/not-a-real-route) since the base Next.js page route is fully dynamic.

我们还[将 `statusCode` 添加至初始页面数据中](https://github.com/vercel-labs/simorgh/pull/1/commits/c8311b756fd4bb71461e9bf11dda6f7a3951b55e)，从而支持[正确渲染错误页面](https://simorgh-preview-error-page.vercel.app/not-a-real-route)，这是因为基础的 Next.js 页面路由是完全动态的。

## Tidying Up

## 整理优化

With both routes functional, we can fix minor console errors and [Lighthouse](https://developer.chrome.com/docs/lighthouse/overview/) issues, comparing the untouched cloned app to our Next.js app.

当两条路由均正常运行后，我们可以修复一些次要的控制台报错，并解决 [Lighthouse](https://developer.chrome.com/docs/lighthouse/overview/) 检测出的问题，同时将未经修改的克隆应用与我们的 Next.js 应用进行对比。

Some highlights include:

部分优化亮点包括：

- [Fixing `public` urls](https://github.com/vercel-labs/simorgh/pull/1/commits/5441a3822c827160df2041f56eefe6afd73967d0).

- [修复 `public` 目录下的 URL 路径](https://github.com/vercel-labs/simorgh/pull/1/commits/5441a3822c827160df2041f56eefe6afd73967d0)。

- [Prefixing all environment variables used on the client side with `NEXT_PUBLIC_`](https://github.com/vercel-labs/simorgh/pull/1/commits/5de5fb45a2818044f828f650180fd26c6f6797d1) and then [moving all the environment variables to Vercel](https://github.com/vercel-labs/simorgh/pull/1/commits/fe685bfca7b1109b20628d7b75eae5e90935fee8) for better management and security.

- [将所有在客户端使用的环境变量统一添加 `NEXT_PUBLIC_` 前缀](https://github.com/vercel-labs/simorgh/pull/1/commits/5de5fb45a2818044f828f650180fd26c6f6797d1)，随后[将全部环境变量迁移至 Vercel 平台](https://github.com/vercel-labs/simorgh/pull/1/commits/fe685bfca7b1109b20628d7b75eae5e90935fee8)，以提升管理效率与安全性。

- [将 `toggles` 数据添加到初始页面数据中](https://github.com/vercel-labs/simorgh/pull/1/commits/f418e99e78bbe4b452827745b4d444dafd209e1a)。

- [添加自定义的 `_document.js` 以动态处理 `dir` 和 `lang` HTML 属性](https://github.com/vercel-labs/simorgh/pull/1/commits/bee1f7920ced09568151a85a5b1dff1f74f63c92)。

最终结果是实现功能完全对齐（full parity）。

## 移除冗余代码

最后，我们来评估一下：借助 Next.js，究竟可以移除或替换多少原有代码。

- 彻底移除 Babel 配置及[所有相关依赖项](https://github.com/vercel-labs/simorgh/pull/1/commits/b597af40ba87ccff17796fbed9ab2627666dcb79)。

- 彻底[移除 `react-helmet`](https://github.com/vercel-labs/simorgh/pull/1/commits/52fef75bfdc20b2afb68a2b9e3210740d34dce2a)，改用 [`next/head`](https://nextjs.org/docs/api-reference/next/head)，并随后[将所有 `<script>` 标签更新为使用 `next/script`](https://github.com/vercel-labs/simorgh/pull/1/commits/6128a0340923aa276c26632c32f53c020e2904d8)。

- 彻底[移除 `react-router` 及所有相关依赖项](https://github.com/vercel-labs/simorgh/pull/1/commits/fe51f71b7547f889400e098b4fc9e8c613aa4130)。

- 彻底[移除 `express` 及所有相关依赖项](https://github.com/vercel-labs/simorgh/pull/1/commits/9edee970cc4d69355eb4f54c5d5793b89761819b)。

- 彻底[移除 `fetch` 相关依赖项](https://github.com/vercel-labs/simorgh/pull/1/commits/ba9fe1b4a5e5fc34ed0e0701178f1a7ad0711b23)，转而使用 [Next.js 内置的 `fetch` 垫片（polyfill）](https://nextjs.org/blog/next-9-1-7#new-built-in-polyfills-fetch-url-and-objectassign)。

- 完全通过 Next.js 的 [自定义 `_app.js`](https://nextjs.org/docs/advanced-features/custom-app) 和 [基于文件系统的路由机制](https://nextjs.org/docs/routing/introduction)，[移除所有自定义应用、路由、数据及服务端处理器](https://github.com/vercel-labs/simorgh/pull/1/commits/71c9f66b0594b31bf8bf59786ac85b7a474f8f61)。

- 如上所述，通过 `next.config.js` 保留我们精简的 Webpack 配置，并[移除所有其他 Webpack 依赖项](https://github.com/vercel-labs/simorgh/pull/1/commits/75b33a114489ca9f2ee6f49737dd9e68e32c05d0)。

在此过程中，我们完全复用了所有现有的数据 Schema、状态管理逻辑、组件和样式！以下是我们的最终成果：

- [https://simorgh-nextjs.vercel.app/news](https://simorgh-nextjs.vercel.app/news)（以及任意其他 [服务](https://github.com/vercel-labs/simorgh/tree/9fe338c4505146ff31e17e57344263cf1bb42557/data)）

- [https://simorgh-nextjs.vercel.app/news/articles/c6v11qzyv8po](https://simorgh-nextjs.vercel.app/news/articles/c6v11qzyv8po)

- [https://simorgh-nextjs.vercel.app/persian/articles/c4vlle3q337o](https://simorgh-nextjs.vercel.app/persian/articles/c4vlle3q337o)


![我们的最终成果——一个从自定义 React + Express.js 服务端完整迁移至 Next.js 与 Vercel 的页面。](images/migrate-a-large-open-source-react-application-to-next_js-and-vercel-vercel/img_004.jpg)  
我们的最终成果——一个从自定义 React + Express.js 服务端完整迁移至 Next.js 与 Vercel 的页面。

## 迁移前后的对比评估

现在，是时候将[我们的 Next.js 网站](https://simorgh-nextjs.vercel.app/thai)与[现有的 BBC 网站](https://www.bbc.com/thai)进行对比了。

就性能而言，BBC 工程师与贡献者值得高度赞扬——他们交付了一个高性能、高度调优的网站，其 Lighthouse 分数原本就已非常优秀。我们的 [Next.js 版本得分](https://pagespeed.web.dev/report?url=https%3A%2F%2Fsimorgh-nextjs.vercel.app%2Fthai&form_factor=mobile) 与现有 [BBC 网站得分](https://pagespeed.web.dev/report?url=https%3A%2F%2Fwww.bbc.com%2Fthai&form_factor=mobile) 基本持平；部分指标略优或略逊于对方（若您点击上述分数链接，请忽略 Next.js 站点的 SEO 分数——这是因为该站点尚无 `robots.txt` 文件，且 [Vercel 预览 URL 默认不可被搜索引擎索引](https://vercel.com/docs/concepts/deployments/preview-deployments#preview-urls)）。

However, moving to Next.js brought some notable developer and user experience benefits:

然而，迁移到 Next.js 带来了若干显著的开发者体验与用户体验提升：

- Average HMR Time improved from **1.3s to 131ms**

  - _Average of ten runs; adding and removing a_ _`<p>`_ _tag from_ _`FrontPage`_

- 热模块替换（HMR）平均耗时从 **1.3 秒缩短至 131 毫秒**

  - _基于十次运行的平均值；在_ _`FrontPage`_ _中增删一个_ _`<p>`_ _标签_

- The number of network requests was reduced from **57 to 34**

  - _Based on an incognito session, empty cache, and hard reload_

- 网络请求数量从 **57 次减少至 34 次**

  - _测试环境为无痕窗口、空缓存、强制刷新_

## Unrealized Future Potential

## 尚未释放的未来潜力

Even with all these improvements, it still feels like we're just getting started. There is still so much potential for other optimizations and enhancements we can make in future iterations.

尽管已实现上述诸多改进，我们仍感觉才刚刚起步。未来版本中仍有大量可优化与增强的空间。

- Remove the custom ESLint config and move to [Next.js's integrated ESLint capabilities](https://nextjs.org/docs/basic-features/eslint).

- 移除自定义 ESLint 配置，改用 [Next.js 内置的 ESLint 功能](https://nextjs.org/docs/basic-features/eslint)。

- Change all links to use [`next/link`](https://nextjs.org/docs/api-reference/next/link) for fast SPA-like page transitions.

- 将所有链接改为使用 [`next/link`](https://nextjs.org/docs/api-reference/next/link)，以实现类似单页应用（SPA）的快速页面跳转。

- Change all `<img>` tags to use [`next/image`](https://nextjs.org/docs/api-reference/next/image) and remove the [custom placeholder component](https://github.com/vercel-labs/simorgh/blob/9fe338c4505146ff31e17e57344263cf1bb42557/src/app/legacy/containers/ImageWithPlaceholder/index.jsx) and the `react-lazyload` dependency.

- 将所有 `<img>` 标签替换为 [`next/image`](https://nextjs.org/docs/api-reference/next/image)，并移除 [自定义占位符组件](https://github.com/vercel-labs/simorgh/blob/9fe338c4505146ff31e17e57344263cf1bb42557/src/app/legacy/containers/ImageWithPlaceholder/index.jsx) 及 `react-lazyload` 依赖。

- BBC supports [AMP](https://amp.dev/) on its [front page and article pages](https://github.com/vercel-labs/simorgh/tree/9fe338c4505146ff31e17e57344263cf1bb42557#local-development), which could be replaced with [`next/amp`](https://nextjs.org/docs/api-reference/next/amp).

- BBC 目前在其 [首页与文章页](https://github.com/vercel-labs/simorgh/tree/9fe338c4505146ff31e17e57344263cf1bb42557#local-development) 中支持 [AMP](https://amp.dev/)，该功能可被 [`next/amp`](https://nextjs.org/docs/api-reference/next/amp) 所替代。

- Investigate [Internationalized Routing](https://nextjs.org/docs/advanced-features/i18n-routing) to better handle translations, language, and language direction.

- 调研 [国际化路由（Internationalized Routing）](https://nextjs.org/docs/advanced-features/i18n-routing)，以更优地处理翻译、语言及文字书写方向（如从左到右或从右到左）。

- Create the best strategy for SSR, CSR, and ISR based on BBC's CMS, API, and business rules and goals.

- 基于 BBC 的内容管理系统（CMS）、API 以及业务规则与目标，制定最适合的服务器端渲染（SSR）、客户端渲染（CSR）和增量静态再生（ISR）策略。

## Conclusion

## 结论

If all things are nearly equal performance-wise, _then what is the point_?

如果各项方案在性能上几乎不相上下，_那么意义何在？_

_**We have managed to remove 20,000+ lines of code and 30+ dependencies**_!

_**我们成功移除了超过 20,000 行代码和 30 多个依赖项！**_

And what did we have to do to achieve nearly the same results? _**Nothing.**_

而为达成几乎同等的效果，我们又做了什么？_**什么也不用做。**_

We can't get back the time spent on learning and configuring these dependencies to create a custom framework - but we can cut down on future maintenance.

我们无法挽回此前投入在学习与配置这些依赖项、以构建自定义框架上的时间——但我们可以显著降低未来的维护成本。

By leveraging Next.js, we can let go of being experts and maintainers of this frontend tooling and leverage the community surrounding Next.js. You can benefit from new features and enhancements offered through Next.js - often with a simple, non-breaking version bump.

借助 Next.js，我们无需再充当这套前端工具链的专家与维护者，而是可依托 Next.js 庞大的开源社区生态。您能持续受益于 Next.js 推出的新功能与改进——通常只需一次简单、向后兼容的版本升级即可完成。

By leveraging Vercel Preview Deployments, we can verify our progress in isolation with the full confidence that the end result will scale to meet the BBC's traffic demands and reduce reliance on internal DevOps teams.

借助 Vercel 的预览部署（Preview Deployments）功能，我们可在完全隔离的环境中验证开发进展，并充分确信最终成果能够弹性扩展，从容应对 BBC 的海量流量需求，同时降低对内部 DevOps 团队的依赖。

Next.js and Vercel enable you and your team to do your best work, work _**only you**_ can do for your project or company, at the moment of inspiration.

Next.js 与 Vercel 赋予您及您的团队在灵感迸发的瞬间，专注完成那些_**唯有您才能为项目或公司实现的卓越工作**_。

This freedom allows you to focus on your product and customers instead of application infrastructure.

这种自由让您得以将精力聚焦于产品本身与用户需求，而非应用基础设施的繁杂细节。

We hope this has given you and your team an idea of how how to approach such a conversion of your own custom React setup. And BBC, if you’re interested in seeing this through, please [reach out and let us know](https://vercel.com/contact/sales).

我们希望本文能为您及您的团队提供一套切实可行的思路，助您顺利完成自有 React 技术栈的现代化迁移。BBC 各位同仁，若您有意推进此项工作，请随时[联系我们](https://vercel.com/contact/sales)。
&#123;% endraw %}
