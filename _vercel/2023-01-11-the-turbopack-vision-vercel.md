---
title: "The Turbopack vision - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/the-turbopack-vision"
date: "2023-01-11"
scraped_at: "2026-03-02T09:57:02.496387020+00:00"
language: "en-zh"
translated: true
description: "Watch webpack founder Tobias Koppers talk about the vision for Turbopack at React Day Berlin."
---
&#123;% raw %}

Jan 11, 2023

2023 年 1 月 11 日

Tobias Koppers speaks on moving on from webpack.

托比亚斯·科珀斯（Tobias Koppers）就 webpack 的演进之路发表演讲。

The Turbopack team and I were excited to [announce Turbopack's alpha release at Next.js Conf](https://vercel.com/blog/turbopack) and we've been even more energized by the progress we've made since then.

Turbopack 团队与我非常激动地在 [Next.js Conf 上宣布了 Turbopack 的 Alpha 版本发布](https://vercel.com/blog/turbopack)，而自那以来我们所取得的进展，更进一步激发了我们的热情。

Last month, I had the opportunity to take the stage at React Day Berlin to share more about the future plans for Turbopack.

上个月，我有幸在 React Day Berlin 大会上登台演讲，进一步分享了 Turbopack 的未来规划。

## Moving beyond webpack

## 超越 webpack

Webpack has been downloaded over three billion times and changed the way we build for the Web. However, webpack was built 10 years ago—with the needs of 10 years ago in mind. Since then, web development has evolved in new ways such that webpack’s architecture can't easily accommodate web engineers' needs today.

webpack 下载量已超 30 亿次，彻底改变了我们构建 Web 应用的方式。然而，webpack 诞生于十年前——其架构设计初衷是满足十年前的开发需求。此后，Web 开发以全新方式持续演进，导致 webpack 当前的架构已难以灵活适配现代 Web 工程师的实际需求。

Some big changes are needed but it’s hard to make such large shifts while keeping backwards compatibility. With so many teams using and depending on webpack's core functionality today, the webpack team must be sensitive to the fact that we can't rewrite all of webpack from scratch.

亟需重大变革，但要在保持向后兼容性的前提下完成如此大规模的重构，实属不易。如今，有大量团队正在使用并高度依赖 webpack 的核心功能，因此 webpack 团队必须清醒地认识到：我们无法从零开始重写整个 webpack。

## Building something new

## 构建一个全新的工具

Today’s web developers need a tool with an architecture that will be flexible, extensible, and **fast** for the next 10 years.

当今的 Web 开发者需要一款具备灵活、可扩展且**极快**特性的构建工具——其架构设计应能支撑未来十年的发展需求。

Through recent work on Next.js, we realized that webpack could learn a lot from the optimization work going on in the Next.js ecosystem. Originally using Javascript-based tooling, Next.js developers saw dramatically reduced compile and bundle times when Rust-based SWC was [added to Next.js 12](https://nextjs.org/docs/advanced-features/compiler?utm_source=vercel_site&utm_medium=blog&utm_campaign=turbo_pack_vision).

通过近期在 Next.js 上的工作，我们意识到：webpack 可以从 Next.js 生态系统中正在进行的各类优化实践中汲取大量经验。Next.js 最初采用基于 JavaScript 的工具链；而在 [Next.js 12 中引入基于 Rust 的 SWC 编译器](https://nextjs.org/docs/advanced-features/compiler?utm_source=vercel_site&utm_medium=blog&utm_campaign=turbo_pack_vision) 后，Next.js 开发者的编译与打包耗时显著降低。

Writing in Rust, we are currently working on creating two layers of interoperability:

使用 Rust 编写，我们目前正在构建两层互操作性：

- **Turbo engine:** A core engine for common tasks like caching, invalidation, and incremental builds

- **Turbo 引擎：** 一个核心引擎，用于处理缓存、失效（invalidation）和增量构建等常见任务

- **Turbopack:** A bundler handling CSS, static assets, Wasm, images, fonts, and more leveraging SWC

- **Turbopack：** 一款打包器，借助 SWC 处理 CSS、静态资源、WebAssembly（Wasm）、图片、字体等

![Combining the learnings of Turborepo and Webpack for Turbopack.](images/the-turbopack-vision-vercel/img_001.jpg)![Combining the learnings of Turborepo and Webpack for Turbopack.](images/the-turbopack-vision-vercel/img_002.jpg)Combining the learnings of Turborepo and Webpack for Turbopack.

![结合 Turborepo 与 Webpack 的经验打造 Turbopack。](images/the-turbopack-vision-vercel/img_001.jpg)![结合 Turborepo 与 Webpack 的经验打造 Turbopack。](images/the-turbopack-vision-vercel/img_002.jpg)结合 Turborepo 与 Webpack 的经验打造 Turbopack。

We can already hot reload common code update patterns in milliseconds independent from the size of your codebase. And, through [Turborepo-like Remote Caching](https://turbo.build/repo/docs/core-concepts/remote-caching?utm_source=vercel_site&utm_medium=blog&utm_campaign=turbo_pack_vision), we believe we can rebuild some of the largest sites in the world for production in **seconds** for minor changes.

我们目前已能以毫秒级速度热重载常见的代码更新模式，且该性能完全不受代码库规模影响。此外，借助 [类似 Turborepo 的远程缓存（Remote Caching）](https://turbo.build/repo/docs/core-concepts/remote-caching?utm_source=vercel_site&utm_medium=blog&utm_campaign=turbo_pack_vision)，我们相信——针对细微变更，即可在**数秒内**完成全球一些最大型网站的生产环境重建。

For more on how the Turbo engine can cache your code all the way down to the function level, [visit the Turbopack Core Concepts documentation](https://turbo.build/pack/docs/core-concepts?utm_source=vercel_site&utm_medium=blog&utm_campaign=turbo_pack_vision).

如需进一步了解 Turbo 引擎如何将代码缓存细化至函数级别，请[参阅 Turbopack 核心概念文档](https://turbo.build/pack/docs/core-concepts?utm_source=vercel_site&utm_medium=blog&utm_campaign=turbo_pack_vision)。

## Shipping new alpha features

## 发布新的 Alpha 功能

When I gave this talk last month, we had already received plenty of great user feedback. After hearing from many of our alpha testers, we've shipped some [new features as a part of the Next.js 13.1](https://nextjs.org/blog/next-13-1#turbopack-improvements) release including support for:

上个月我发表本次演讲时，已收到来自用户大量宝贵的反馈。在听取众多 Alpha 测试者的意见后，我们已在 [Next.js 13.1 版本](https://nextjs.org/blog/next-13-1#turbopack-improvements) 中发布了一系列新功能，包括对以下特性的支持：

- PostCSS, including Tailwind CSS

- PostCSS（含 Tailwind CSS）

- next/image

- `next/image`

- next/font  
- next.config.js  
- 以及其他功能  

要立即体验其中一些功能，请使用以下命令创建一个新的 Next.js 13 项目：  

```bash
npx create-next-app --example with-turbopack
```

## Turboverse 的未来  

Turbopack 的 Alpha 版本专为优化 `next dev` 的开发者体验而打造。一旦我们实现与 Next.js 13 开发服务器的功能对等，我们将转向利用 `next build` 进行生产环境构建的开发工作。  

未来，我们将通过插件架构支持其他框架，让全球各地的开发者都能畅享 Turboverse 带来的高效体验。此外，“提升开发者洞察力”也已列入 Turbo 的路线图：例如，提供构建过程的统计摘要、通过 lint 工具指出构建优化机会，以及借助分析器提供更深入的构建洞察。  

如果您想进一步了解我们的未来规划，[请访问 Turbopack 路线图](https://turbo.build/pack/docs/roadmap?utm_source=vercel_site&utm_medium=blog&utm_campaign=turbo_pack_vision)。我们非常期待持续拓展 Turboverse 的边界，助力 Web 构建速度再上新台阶。
&#123;% endraw %}
