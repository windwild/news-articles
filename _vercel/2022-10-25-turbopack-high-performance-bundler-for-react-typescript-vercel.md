---
render_with_liquid: false
title: "Turbopack: High-performance bundler for React & TypeScript - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/turbopack"
date: "2022-10-25"
scraped_at: "2026-03-02T10:00:02.243281724+00:00"
language: "en-zh"
translated: true
description: "Introducing Turbopack, the Rust-based successor to Webpack. A high-performance bundler for React Server Components and TypeScript codebases."
---
render_with_liquid: false
render_with_liquid: false

Oct 25, 2022

2022 年 10 月 25 日

Vercel's mission is to provide the speed and reliability innovators need to create at the moment of inspiration. Last year, we focused on speeding up the way Next.js bundles your apps.

Vercel 的使命是为创新者提供在灵感迸发的瞬间进行创作所需的极致速度与可靠性。去年，我们将重点放在加速 Next.js 打包应用的方式上。

Each time we moved from a JavaScript-based tool to a Rust-based one, we saw enormous improvements. We migrated away from Babel, which resulted in **17x faster transpilation**. We replaced Terser, which resulted in **6x faster minification** to reduce load times and bandwidth usage.

每次我们将工具从基于 JavaScript 的方案迁移至基于 Rust 的方案时，性能都实现了巨大提升：我们弃用了 Babel，使转译（transpilation）速度提升了 **17 倍**；我们替换了 Terser，使代码压缩（minification）速度提升了 **6 倍**，从而显著降低了页面加载时间和带宽消耗。

There was one hurdle left: webpack. Webpack has been downloaded over **3 billion times**. It’s become an integral part of building the web, but it's time to go faster.

但还剩下一个障碍：webpack。Webpack 的下载量已超过 **30 亿次**，它已成为构建现代 Web 应用不可或缺的一环——然而，是时候迈向更快的未来了。

Today, we’re launching [**Turbopack**](https://turbo.build/) **:** a high-performance bundler for React Server Components and TypeScript codebases.

今天，我们正式发布 [**Turbopack**](https://turbo.build/)：一款面向 React Server Components 和 TypeScript 项目的高性能打包器（bundler）。

![Introducing Turbopack, the Rust-based successor to Webpack.](images/turbopack-high-performance-bundler-for-react-typescript-vercel/img_001.jpg)![Introducing Turbopack, the Rust-based successor to Webpack.](images/turbopack-high-performance-bundler-for-react-typescript-vercel/img_002.jpg)Introducing Turbopack, the Rust-based successor to Webpack.

![Turbopack 简介：基于 Rust 的下一代 Webpack 替代方案。](images/turbopack-high-performance-bundler-for-react-typescript-vercel/img_001.jpg)![Turbopack 简介：基于 Rust 的下一代 Webpack 替代方案。](images/turbopack-high-performance-bundler-for-react-typescript-vercel/img_002.jpg)Turbopack 简介：基于 Rust 的下一代 Webpack 替代方案。

Led by the creator of Webpack, Tobias Koppers, Turbopack is our next-generation bundler.

Turbopack 由 Webpack 的创始人 Tobias Koppers 主导开发，是我们打造的下一代打包器。

Try out the alpha of Turbopack in Next.js 13 today with [`next dev --turbo`](https://turbo.build/pack/docs).

即日起，您即可在 Next.js 13 中体验 Turbopack 的 Alpha 版本，只需运行命令：[`next dev --turbo`](https://turbo.build/pack/docs)。

## How fast is Turbopack?

## Turbopack 到底有多快？

Turbopack is built on a new incremental architecture for the fastest possible development experience. On large applications, it **shows updates 700x faster than Webpack**.

Turbopack 基于一种全新的增量式架构构建，旨在提供迄今为止最快的开发体验。在大型应用中，其热更新（HMR）速度比 Webpack **快达 700 倍**。

Turbopack only bundles the minimum assets required in development, so **startup time is extremely fast**. On an application with 5,000 modules, Turbopack takes 4 seconds to boot up, while Vite (with SWC) takes 16.6 seconds.

在开发阶段，Turbopack 仅打包所需的最少资源，因此 **启动速度极快**。在一个包含 5,000 个模块的应用中，Turbopack 启动仅需 4 秒，而 Vite（搭配 SWC）则需 16.6 秒。

To learn more, read the [docs](https://turbo.build/pack/docs/core-concepts) on how Turbopack bundles and view the benchmarks.

如需深入了解，请阅读关于 Turbopack 打包机制的 [文档](https://turbo.build/pack/docs/core-concepts)，并查看性能基准测试结果。

## Why is Turbopack so fast?

## 为什么 Turbopack 如此之快？

Turbopack’s architecture takes the lessons learned from tools like [Turborepo](https://turborepo.org/) and Google’s Bazel, both of which focus on using caches to **never do the same work twice**.

Turbopack 的架构汲取了 [Turborepo](https://turborepo.org/) 和 Google Bazel 等工具的经验教训——二者均强调利用缓存机制，**确保相同的工作永不重复执行**。

Turbopack is built on Turbo: an open-source, incremental memoization framework for Rust. Turbo can cache the result of any function in the program. When the program is run again, functions won't re-run unless their inputs have changed. This granular architecture enables your program to skip large amounts of work, at the level of the function.

Turbopack 基于 Turbo 构建：一个开源的、面向 Rust 的增量式记忆化（memoization）框架。Turbo 可缓存程序中任意函数的执行结果；当程序再次运行时，只要函数输入未发生变化，该函数便不会重新执行。这种细粒度的架构使你的程序能在函数级别跳过大量冗余工作。

An incremental reactive system with the speed of Rust? Turbopack is unstoppable.

一个兼具 Rust 速度的增量式响应系统？Turbopack 势不可挡。

To learn more, check out our [explainer on Turbo](https://turbo.build/pack/docs/core-concepts).

如需进一步了解，请参阅我们关于 Turbo 的 [原理说明文档](https://turbo.build/pack/docs/core-concepts)。

[**Ready to give Turbopack a try?**\\
\\
See how fast Turbopack really is—try the Web's next-generation bundler today.\\
\\
Contact sales](https://vercel.com/contact/turborepo)

[**准备好试用 Turbopack 了吗？**\\
\\
亲身体验 Turbopack 的惊人速度——即刻尝试 Web 下一代打包器。\\
\\
联系销售](https://vercel.com/contact/turborepo)

## The future of Turbo

## Turbo 的未来

To start, Turbopack will be used for the [Next.js 13](https://beta.nextjs.org/docs) development server. It will power lightning-fast HMR, and it will **support React Server Components natively**, as well as TypeScript, JSX, CSS, and more.

初期，Turbopack 将作为 [Next.js 13](https://beta.nextjs.org/docs) 开发服务器的核心引擎。它将提供闪电般的热更新（HMR）能力，并**原生支持 React Server Components**，同时全面兼容 TypeScript、JSX、CSS 等多种语言与资源类型。

Turbopack will eventually also power Next.js production builds, both locally and in the cloud. We’ll be able to **share Turbo's cache across your entire team,** using [Vercel Remote Caching](https://vercel.com/docs/concepts/monorepos/remote-caching).

Turbopack 最终也将为 Next.js 的生产环境构建（无论本地还是云端）提供支持。我们将能够借助 [Vercel 远程缓存（Remote Caching）](https://vercel.com/docs/concepts/monorepos/remote-caching)，**在您的整个团队中共享 Turbo 的缓存**。

Webpack users can also expect **an incremental migration path** into the Rust-based future with Turbopack.

Webpack 用户同样可以期待一条**渐进式迁移路径**，逐步迈入基于 Rust 的 Turbopack 未来。

We couldn’t be more excited about the future of the Turbo ecosystem, as we push to help you iterate faster and create at the moment of inspiration.

我们对 Turbo 生态系统的未来充满期待——我们将持续努力，助您更快迭代，在灵感迸发的瞬间即刻创造。

![Turbopack provides a fast and flexible development experience for apps of any size.](images/turbopack-high-performance-bundler-for-react-typescript-vercel/img_003.jpg)![Turbopack provides a fast and flexible development experience for apps of any size.](images/turbopack-high-performance-bundler-for-react-typescript-vercel/img_004.jpg)Turbopack provides a fast and flexible development experience for apps of any size.

![Turbopack 为任意规模的应用提供快速、灵活的开发体验。](images/turbopack-high-performance-bundler-for-react-typescript-vercel/img_003.jpg)![Turbopack 为任意规模的应用提供快速、灵活的开发体验。](images/turbopack-high-performance-bundler-for-react-typescript-vercel/img_004.jpg)Turbopack 为任意规模的应用提供快速、灵活的开发体验。

Explore the [Turbopack alpha](https://turbo.build/pack) in Next.js 13 today.

今天就来体验 Next.js 13 中的 [Turbopack Alpha 版本](https://turbo.build/pack)。