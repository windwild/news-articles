---
render_with_liquid: false
title: "Towards Next.js 5: Introducing Canary Updates - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/next-canary"
date: "2017-11-15"
scraped_at: "2026-03-02T10:08:06.835472638+00:00"
language: "en-zh"
translated: true
description: "Featuring a new update channel for Next.js, our first canary release and the Next.js 5 Roadmap."
---
render_with_liquid: false
render_with_liquid: false

Nov 15, 2017

2017 年 11 月 15 日

继 [Hyper](https://hyper.is/)、[Now CLI](https://vercel.com/download#command-line) 和 [Now Desktop](https://vercel.com/download) 的 Canary 版本发布之后，我们很高兴地宣布：Next.js 的 Canary 渠道现已正式开放！

此外，我们也很兴奋地与大家分享当前正在推进的 Next.js 5 版本的部分目标！

## Next.js 5：面向更大规模的应用场景

## Next.js 5：面向更大规模的应用场景

Next.js 的设计初衷，是在 React 基础之上为开发者提供尽可能精简的 API 表面（API surface），从而提升应用与网站开发的效率与生产力。

因此，我们并未将重心放在新增功能或扩展 API 上，而是聚焦于**可扩展性（scalability）**。

为此，我们将 Next.js 5 的路线图划分为两大方向：

1. 提升 Next.js 在大型代码库（单仓库）下的性能表现  
2. 提升 Next.js 在大型团队（跨多个仓库）协作场景下的适用性  

## The Roadmap

## 路线图

1. **Improved Compilation Speed**

1. **编译速度提升**

   - Better startup performance (first time you run `next`)

   - 启动性能更优（首次运行 `next` 时）

   - Better lazy page building performance

   - 懒加载页面构建性能更优

2. **Improved Sourcemaps**

2. **Source Map 质量提升**

   - Accurate sourcemaps for all categories of errors

   - 所有类型错误均具备准确的 Source Map

   - Support for external sourcemaps

   - 支持外部 Source Map

3. **Multiple Next.js apps on the same domain**

3. **同一域名下运行多个 Next.js 应用**

   - Ability to designate a prefix to mount an app on

   - 可指定挂载路径前缀以部署应用

   - Interoperability for `<Link>` across app realms

   - `<Link>` 组件可在不同应用间跨域互通

4. **Simpler sharing of components on npm**

4. **在 npm 上更便捷地共享组件**

   - No need to transpile before publishing

   - 发布前无需转译

   - Easier importing of Next.js components from the registry

   - 更轻松地从 npm 仓库导入 Next.js 组件

The first two items will make you more productive in the local scope of a project. Larger codebases stand to see the most benefits (complex component hierarchies).

前两项改进将显著提升你在单个项目本地开发环境中的工作效率。大型代码库（尤其是具有复杂组件层级结构的项目）将从中获益最多。

The last two will make Next.js more productive across your entire organization, by allowing you to split more and share. Larger companies with many teams will see many workflow improvements.

最后两项改进将通过支持更细粒度的代码拆分与更便捷的资源共享，全面提升 Next.js 在整个组织内的开发效率。拥有众多团队的大型企业将从中获得大量工作流优化。

Finally, we're adding some highly requested examples (like user authentication), improved documentation for Next.js internals and smaller features and bugfixes.

最后，我们新增了一些广受期待的示例（例如用户身份认证），改进了 Next.js 内部机制的文档，并引入了若干小型功能增强与缺陷修复。

## Working on the Cutting Edge

## 站在技术前沿开发

All ongoing development will be based out of the new [canary](https://github.com/zeit/next.js) branch on Github.

所有正在进行的开发工作都将基于 GitHub 上全新的 [canary](https://github.com/zeit/next.js) 分支展开。

This branch will be released much more often than the _master_ branch. This will ensure that _canary_ is _always latest_ and _master_ is _always stable_.

该分支的发布频率将远高于 _master_ 分支，从而确保 _canary_ 分支始终代表最新特性，而 _master_ 分支则始终保持稳定可靠。

The best part? As soon as a git tag is made, a release is automatically published to [npm](https://www.npmjs.com/package/next) using Travis CI.

最棒的是？一旦创建 Git 标签，系统便会借助 Travis CI 自动将新版本发布至 [npm](https://www.npmjs.com/package/next)。

### How to Start Using Canary

### 如何开始使用 Canary 版本

We have added a new distribution tag named "canary" in our [npm package](https://www.npmjs.com/package/next). To install Next.js canary, you simply run one command:

我们已在 [npm 包](https://www.npmjs.com/package/next) 中新增了一个名为 “canary” 的分发标签。如需安装 Next.js 的 Canary 版本，只需执行一条命令：

```bash
npm install --save next@canary react react-dom
```

Obviously, there's a caveat: Some of the changes we introduce will be _experimental_. If you encounter issues, [let us know](https://github.com/zeit/next.js/issues) or just switch back to the stable channel!

当然，这里有个注意事项：我们引入的部分变更属于 _实验性功能_。若您遇到问题，请 [随时告知我们](https://github.com/zeit/next.js/issues)，或直接切换回稳定版通道！

That said, a priority of our team is to make canary releases that are drop-in, backwards compatible and as stable as possible.

话虽如此，我们团队的首要任务之一是发布即插即用、向后兼容且尽可能稳定的预发布版本（canary release）。

## Our First Canary Release

## 我们的首个预发布版本

I'm happy to share that the first canary release is already available! [4.2.0-canary.1](https://github.com/zeit/next.js/releases/tag/4.2.0-canary.1) brings substantial improvements and brings us closer to some of the goals stated above.

我很高兴地宣布，首个预发布版本现已上线！[4.2.0-canary.1](https://github.com/zeit/next.js/releases/tag/4.2.0-canary.1) 带来了大量改进，使我们更接近上述部分目标。

**Minor Changes**

**次要变更**

- Combine source maps: [#3178](https://github.com/zeit/next.js/issues/3178)

- 合并源码映射（source maps）：[#3178](https://github.com/zeit/next.js/issues/3178)

- Expose mechanism to monitor render events: [#2655](https://github.com/zeit/next.js/issues/2655)

- 暴露用于监控渲染事件的机制：[#2655](https://github.com/zeit/next.js/issues/2655)

- Support de-deduping head tags by setting key: [#3170](https://github.com/zeit/next.js/issues/3170)

- 支持通过设置 `key` 属性对 `<head>` 标签进行去重：[#3170](https://github.com/zeit/next.js/issues/3170)

- Use fs.realpath to get actual project directory: [#3243](https://github.com/zeit/next.js/issues/3243)

- 使用 `fs.realpath` 获取实际项目目录：[#3243](https://github.com/zeit/next.js/issues/3243)

- Allow overriding Content-Type: [#3242](https://github.com/zeit/next.js/issues/3242)

- 允许覆盖 `Content-Type` 响应头：[#3242](https://github.com/zeit/next.js/issues/3242)

- Make pages glob pattern overridable: [#3195](https://github.com/zeit/next.js/issues/3195)

- 使 `pages` 目录的 glob 匹配模式可被覆盖：[#3195](https://github.com/zeit/next.js/issues/3195)

- Use uglify-es for minification: [#3150](https://github.com/zeit/next.js/issues/3150)

- 使用 uglify-es 进行代码压缩：[#3150](https://github.com/zeit/next.js/issues/3150)

- Make sure NODE\_ENV is production for react-dom to optimize: [152c2c2](https://github.com/zeit/next.js/commit/152c2c2)

- 确保将 NODE\_ENV 设为 `production`，以便 react-dom 启用优化：[152c2c2](https://github.com/zeit/next.js/commit/152c2c2)

**Patches**

**补丁更新**

- Add note about NODE\_ENV being set automatically: [72827d2](https://github.com/zeit/next.js/commit/72827d2)

- 补充说明 NODE\_ENV 会自动设置：[72827d2](https://github.com/zeit/next.js/commit/72827d2)

- Output webpack build stats as webpack-stats.json: [#2828](https://github.com/zeit/next.js/issues/2828)

- 将 webpack 构建统计信息输出为 `webpack-stats.json` 文件：[#2828](https://github.com/zeit/next.js/issues/2828)

- Upgrade styled-jsx to version 2.1.2: [#3231](https://github.com/zeit/next.js/issues/3231)

- 将 styled-jsx 升级至版本 2.1.2：[#3231](https://github.com/zeit/next.js/issues/3231)

- Messages are available within initialProps: [#3252](https://github.com/zeit/next.js/issues/3252)

- 国际化消息（messages）现已可在 `initialProps` 中获取：[#3252](https://github.com/zeit/next.js/issues/3252)

- Set Cache-Control max-age to a year: [#3247](https://github.com/zeit/next.js/issues/3247)

- 将 `Cache-Control` 的 `max-age` 设置为一年：[#3247](https://github.com/zeit/next.js/issues/3247)

- Document router events the way they are used: [#3268](https://github.com/zeit/next.js/issues/3268)

- 按实际使用方式完善路由事件（router events）的文档：[#3268](https://github.com/zeit/next.js/issues/3268)

- Update withData.js - support withRouter HOC: [#3286](https://github.com/zeit/next.js/issues/3286)

- 更新 `withData.js` —— 增加对 `withRouter` 高阶组件（HOC）的支持：[#3286](https://github.com/zeit/next.js/issues/3286)

**Examples**

**示例**

- 使用 Apollo 2 的 with-apollo 示例：[#3180](https://github.com/zeit/next.js/issues/3180)

- 将 `_error.js` 示例更改为使用 `err` 属性：[#3197](https://github.com/zeit/next.js/issues/3197)

- 创建一个使用 `withRouter` 实现 `activeClassLink` 的示例：[#3188](https://github.com/zeit/next.js/issues/3188)

- 新增 Sentry 示例：[#3215](https://github.com/zeit/next.js/issues/3215)

- 在示例中弃用 `isomorphic-fetch`，改用 `isomorphic-unfetch`：[#3230](https://github.com/zeit/next.js/issues/3230)

- 仅客户端渲染外部依赖项示例（only-client-render-external-dependencies）：[#3229](https://github.com/zeit/next.js/issues/3229)

- 新增 kea 示例：[#3262](https://github.com/zeit/next.js/issues/3262)

- 使用 redux-observable 的示例（with-redux-observable）：[#3272](https://github.com/zeit/next.js/issues/3272)

- 更新 `custom-server-express` 示例，加入 `req.params` 的使用示例：[#3258](https://github.com/zeit/next.js/issues/3258)

- Update README.md for with-shallow-routing example: [#3285](https://github.com/zeit/next.js/issues/3285)

- 更新 `with-shallow-routing` 示例的 README.md 文件：[#3285](https://github.com/zeit/next.js/issues/3285)


## Want to Contribute?

## 想要参与贡献吗？

If you are looking to start contributing to Next.js, we have recently introduced a [good first issue label](https://github.com/zeit/next.js/issues?q=is%3Aopen+is%3Aissue+label%3A%22good+first+issue%22). These are small –yet very impactful– issues that are ideal for beginners to our codebase.

如果您希望开始为 Next.js 贡献代码，我们最近新增了 [“good first issue”（适合新手的入门问题）标签](https://github.com/zeit/next.js/issues?q=is%3Aopen+is%3Aissue+label%3A%22good+first+issue%22)。这些问题规模较小，但影响显著，非常适合初次接触我们代码库的新手。

If you have any questions or want some guidance on how to get started, feel free to join our public chat and ask around!

如果您有任何疑问，或希望获得如何起步的指导，欢迎加入我们的 [公开聊天室](https://nextjs.org/chat) 并随时提问！