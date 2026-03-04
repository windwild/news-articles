---
title: "Next.js 6.1 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/next6-1"
date: "2018-06-27"
scraped_at: "2026-03-02T10:07:58.937541034+00:00"
language: "en-zh"
translated: true
description: "Next.js 6.1 features improved reliability and consistency in development."
---
{% raw %}

Jun 27, 2018

2018 年 6 月 27 日

我们很自豪地宣布正式发布 **Next.js 6.1**，该版本已达到生产就绪（production-ready）标准，主要特性包括：

- 热重载（hot reloading）可靠性提升  
- 代码库质量改进  
- Next.js 专属的 codemod 工具  

除 Next.js 6.1 版本发布外，我们还很高兴地宣布：[nextjs.org](https://nextjs.org/) 网站现已 [开源](https://github.com/vercel/next.js/)。

## Improved hot reloading reliability

## 热重载可靠性提升

在 Next.js 6.1 之前，Next.js 替用户集成了 `react-hot-loader` 库，该库用于在热重载过程中保持 React 组件的状态。

然而，`react-hot-loader` 为 React 引入了一些非标准行为。例如，它会忽略 `shouldComponentUpdate` 生命周期方法；此外，组件的 `type` 属性最终指向的是一个代理组件（proxy component），而非原始的 React 组件本身。

为确保 Next.js 尽可能贴近标准 React 的行为，我们已将 `react-hot-loader` 从依赖项中移除。此举使开发模式与生产模式的行为更加一致。请注意：Next.js 的热重载功能 **并未被移除**——热重载能力始终由 Next.js 内部自行实现与管理。

## Hot reloading Typescript and other custom extensions

## 热重载 TypeScript 及其他自定义扩展

By default, Next.js automatically looks for any `.js` or `.jsx` file inside the `pages` directory to define routes.

默认情况下，Next.js 会自动在 `pages` 目录中查找所有 `.js` 或 `.jsx` 文件，以定义路由。

With the introduction of universal webpack in Next.js 5 came the possibility to have compile-to-js top-level pages. A good example is Typescript, which uses `.ts` and `.tsx`.

随着 Next.js 5 引入通用 Webpack，现在支持将编译为 JavaScript 的顶层页面（即“compile-to-js top-level pages”）。一个典型示例是 TypeScript，它使用 `.ts` 和 `.tsx` 扩展名。

`pageExtensions` is a configuration key in `next.config.js` aimed at allowing Next.js plugins to define extensions that should be considered pages. For example [`@zeit/next-typescript`](https://github.com/vercel/next-plugins/tree/master/packages/next-typescript) defines `.ts` and `.tsx` or [`@zeit/next-mdx`](https://github.com/vercel/next-plugins/tree/master/packages/next-mdx) which [documents](https://github.com/vercel/next-plugins/tree/master/packages/next-mdx#top-level-mdx-pages) how to have top level `.mdx` pages.

`pageExtensions` 是 `next.config.js` 中的一个配置项，旨在允许 Next.js 插件定义哪些文件扩展名应被视为页面。例如，[`@zeit/next-typescript`](https://github.com/vercel/next-plugins/tree/master/packages/next-typescript) 将 `.ts` 和 `.tsx` 视为页面扩展；而 [`@zeit/next-mdx`](https://github.com/vercel/next-plugins/tree/master/packages/next-mdx) 则[文档说明](https://github.com/vercel/next-plugins/tree/master/packages/next-mdx#top-level-mdx-pages)了如何启用顶层 `.mdx` 页面。

Previously when implementing `pageExtensions` Next.js plugins were required to implement the `hot-self-accept-loader` that is used for hot reloading. This is no longer required, when adding an extension to `pageExtensions` the `hot-self-accept-loader` is automatically applied.

此前，在实现 `pageExtensions` 时，Next.js 插件需自行实现用于热重载的 `hot-self-accept-loader`。如今这一要求已被取消：只要将扩展名加入 `pageExtensions`，`hot-self-accept-loader` 即会自动应用。

## Codebase improvements

## 代码库改进

Recently we've been paving the way for upcoming features, this involved some under the hood changes that will improve code quality in the long run.

近期，我们正为即将推出的新功能铺平道路，这包括一系列底层变更，有望长期提升代码质量。

One of these changes is that the `server/build` directory is moved to the top level `build`. This makes the webpack and babel configuration easier to find for new contributors.

其中一项变更，是将 `server/build` 目录移至顶层 `build` 目录。此举使新贡献者更易定位 Webpack 和 Babel 配置。

We have also been focusing on adding [Flow](https://flow.org/) types throughout the codebase.

我们还持续在全代码库中引入 [Flow](https://flow.org/) 类型注解。

A change we've made that is more visible to users is that `.next/dist` has been renamed to `.next/server`. The `.next` directory that holds build output. For example when you run `next build` the result will be stored in `.next`.

另一项对用户更为直观的变更，是将 `.next/dist` 重命名为 `.next/server`。`.next` 目录用于存放构建输出内容；例如，执行 `next build` 后，构建结果即存储于 `.next` 目录中。

![The pre-rendering files are now in the `server` directory.](images/next_js-6_1-vercel/img_001.jpg)  
预渲染文件现已存放在 `server` 目录中。

Occurrences of the same constants have been moved into a common file: constants.js  
相同常量的多处定义已统一移至一个公共文件：`constants.js`。

## Next.js codemods

## Next.js 代码迁移工具（codemods）

When Next.js 6.0 was released the magically injected `url` property on page components was deprecated. The reason `url` is going away is that we want to make things very predictable and explicit. Having a magical url property coming out of nowhere doesn't aid that goal.  
Next.js 6.0 发布时，页面组件上自动注入的 `url` 属性已被弃用。`url` 属性被移除的原因在于：我们希望使行为更加可预测且显式化；而一个凭空出现的“魔法” `url` 属性显然与此目标背道而驰。

The recommended way to get the same properties the `url` property had is using `withRouter`:  
推荐的替代方案是使用 `withRouter` 来获取原先 `url` 属性所包含的全部属性：

```javascript
1// old

class Page extends React.Component {

3  render() {

4    const {url} = this.props

5    return <div>{url.pathname}</div>
```

6  }

7}

export default Page
```

在 Next.js 6 之前版本中，如何通过 `url` 访问 pathname。

```javascript
1// 新方式

import { withRouter } from 'next/router'

class Page extends React.Component {

4  render() {

5    const {router} = this.props

6    return <div>{router.pathname}</div>

7  }

8}

export default withRouter(Page)
```

如何在 Next.js 6 及更高版本中通过 `withRouter` 注入的 `router` 访问 pathname。

鉴于我们致力于为 Next.js 应用提供简洁明了的升级路径，我们着手设计了一种简便方式，将旧版 `url` 的用法升级为 `withRouter`。

这一工作的成果是 [next‑codemod](https://github.com/vercel/next-codemod) —— 一个代码转换（codemod）工具库，它能将特定已弃用功能的旧用法一键升级为新用法，只需运行一条命令即可完成。

我们提供的首个 codemod 是 `url-to-withrouter`，它可自动将大量原本使用 `url` 的场景转换为 `withRouter`。

```bash
jscodeshift -t ./url-to-withrouter.js pages/**/*.js
```

该命令会将所有 `url` 的用法转换为 `withRouter`。

## 为 Next.js 贡献代码

## 为 Next.js 做出贡献

The Next.js community is growing, with more than 450 contributors that already landed at least 1 commit into the Next.js core or examples.

Next.js 社区正在不断壮大，已有超过 450 名贡献者向 Next.js 核心代码库或示例项目提交了至少一次代码提交。

There's many ways to contribute back to Next.js:

参与 Next.js 贡献的方式多种多样：

- Joining the community and giving advice in [Discussions](https://github.com/vercel/next.js/discussions)

- 加入社区，在 [Discussions（讨论区）](https://github.com/vercel/next.js/discussions) 中提供建议

- Contributing examples of common use cases: [examples directory](https://github.com/vercel/next.js/tree/canary/examples)

- 贡献常见使用场景的示例：[examples 目录](https://github.com/vercel/next.js/tree/canary/examples)

- Checking the [good first issue](https://github.com/vercel/next.js/issues?q=is%3Aissue+is%3Aopen+sort%3Aupdated-desc+label%3A%22good+first+issue%22) and [help wanted](https://github.com/vercel/next.js/issues?q=is%3Aissue+is%3Aopen+sort%3Aupdated-desc+label%3A%22help+wanted%22) labels on [GitHub](https://github.com/vercel/next.js)

- 在 [GitHub](https://github.com/vercel/next.js) 上查看标有 [good first issue（适合新手的议题）](https://github.com/vercel/next.js/issues?q=is%3Aissue+is%3Aopen+sort%3Aupdated-desc+label%3A%22good+first+issue%22) 和 [help wanted（需要帮助）](https://github.com/vercel/next.js/issues?q=is%3Aissue+is%3Aopen+sort%3Aupdated-desc+label%3A%22help+wanted%22) 的议题

![There's 30 open issues with the "good first issue" label. Giving new contributors the opportunity to contribute. ](images/next_js-6_1-vercel/img_002.jpg)  
![标有 “good first issue” 的未解决问题共有 30 个，为新贡献者提供了参与贡献的机会。](images/next_js-6_1-vercel/img_002.jpg)  
There's 30 open issues with the "good first issue" label. Giving new contributors the opportunity to contribute.

标有 “good first issue” 的未解决问题共有 30 个，为新贡献者提供了参与贡献的机会。

## nextjs.org open source

## nextjs.org 开源

We're excited to announce that [nextjs.org](https://nextjs.org/) is now [open source](https://github.com/vercel/next.js/) so that it can serve as a reference Nextjs implementation and issues/improvements can be filed directly on the project.

我们很高兴地宣布，[nextjs.org](https://nextjs.org/) 现已 [开源](https://github.com/vercel/next.js/)，以便作为 Next.js 的参考实现，并支持直接在该项目中提交问题或改进建议。

## Future

## 未来展望

We've been working on a few new features to increase reliability and performance, here are a few highlights:

我们正致力于开发若干新功能，以进一步提升系统可靠性与性能，以下是部分亮点：

### Webpack 4

### Webpack 4

Webpack 4 brings a lot of improvements: better code-splitting, less configuration is needed by default, and most importantly faster build times. In initial tests we did on an app with over 200 pages `next build` went from taking 100 seconds to 70 seconds on average. On a second run (with caches) a `next build` took 21 seconds on average.

Webpack 4 带来了诸多改进：更优的代码分割（code-splitting）、默认所需配置更少，而最重要的是构建速度显著提升。我们在一个拥有 200 多个页面的应用上进行的初步测试显示，`next build` 的平均耗时从 100 秒降低至 70 秒；而在第二次运行（利用缓存）时，`next build` 的平均耗时进一步降至 21 秒。

### Serverless Next.js

### 无服务器架构下的 Next.js（Serverless Next.js）

We are incrementally making changes to prepare to move `next start` out into its own package: `next-server`. This package will be heavily optimized for install size and bootup time. These optimizations are needed for the "serverless" use case where a new instance of the app is executed every request or every few requests. Meaning the "cold start" of an application has to be optimized to be as fast as possible.

我们正逐步推进一系列变更，为将 `next start` 拆分为独立包 `next-server` 做准备。该新包将在安装包体积和启动时间方面进行深度优化。此类优化对于“无服务器”（serverless）应用场景至关重要——在此类场景中，应用需在每次请求或每若干次请求时启动一个全新实例，因此必须尽可能优化应用的“冷启动”（cold start）性能。
{% endraw %}
