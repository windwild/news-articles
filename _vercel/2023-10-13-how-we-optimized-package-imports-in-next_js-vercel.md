---
title: "How we optimized package imports in Next.js - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-we-optimized-package-imports-in-next-js"
date: "2023-10-13"
scraped_at: "2026-03-02T09:50:20.104032517+00:00"
language: "en-zh"
translated: true
description: "How solving barrel files led to faster cold boots and build times."
---
{% raw %}

Oct 13, 2023

2023 年 10 月 13 日

40% faster cold boots and 28% faster builds

冷启动速度提升 40%，构建速度提升 28%

In the [latest version of Next.js](https://nextjs.org/blog/next-13-5), we've made improvements to optimize package imports, improving both local dev performance and production cold starts, when using large icon or component libraries or other dependencies that re-export hundreds or thousands of modules.

在 [Next.js 最新版本](https://nextjs.org/blog/next-13-5) 中，我们优化了包导入机制，显著提升了本地开发性能与生产环境下的冷启动速度——尤其当项目使用大型图标库、组件库，或其他会重新导出数百乃至数千个模块的依赖时。

This post explains why this change was needed, how we've iterated towards our current solution, and what performance improvements we've seen.

本文将解释为何需要这一变更、我们如何通过多次迭代达成当前方案，以及实际观测到的性能提升效果。

## What is a barrel file?

## 什么是 barrel 文件？

A **barrel file** in JavaScript is a way to group and export multiple modules from a single file. It allows for easier importing of the grouped modules by providing a centralized location to access them.

JavaScript 中的 **barrel 文件** 是一种将多个模块集中定义并导出的单文件方式。它通过提供一个统一的入口点，简化了对这些模块的导入操作。

For example, let's say we have three modules (`module1.js`, `module2.js`, `module3.js`) within a `utils/` directory. We can create a barrel file named `index.js` within the same directory:

例如，假设 `utils/` 目录下包含三个模块：`module1.js`、`module2.js` 和 `module3.js`。我们可以在同一目录下创建一个名为 `index.js` 的 barrel 文件：

index.js

`index.js`

```javascript
export { default as module1 } from './module1';

export { default as module2 } from './module2';
```

```javascript
export { default as module3 } from './module3';
```

```javascript
export { default as module3 } from './module3';
```

Now, instead of importing each module individually like this in your application:

现在，您的应用中无需再像这样分别导入每个模块：

```javascript
import module1 from './utils/module1';

import module2 from './utils/module2';

import module3 from './utils/module3';
```

```javascript
import module1 from './utils/module1';

import module2 from './utils/module2';

import module3 from './utils/module3';
```

We can import _all_ modules collectively using the barrel file, without needing to know about the internal structure:

我们可以借助 barrel 文件一次性导入 _所有_ 模块，而无需了解其内部目录结构：

```javascript
import { module1, module2, module3 } from './utils';
```

```javascript
import { module1, module2, module3 } from './utils';
```

Barrel files can improve code organization and maintainability by providing an easily accessible interface for related modules. Because of this, it’s used widely by JavaScript packages, especially icon and component libraries.

Barrel 文件通过为相关模块提供简洁易用的统一入口，有助于提升代码组织性与可维护性。正因如此，它被大量 JavaScript 包广泛采用，尤其常见于图标库和组件库。

Some popular icon and component libraries have **up to 10,000 re-exports in their entry barrel file**.

一些主流的图标库和组件库，其入口 barrel 文件中包含的重新导出（re-export）声明甚至多达 **10,000 条**。

## What's the problem with barrel files?

## Barrel 文件存在什么问题？

There's a hidden cost with JavaScript runtimes in every `require(...)` and `import '...'`. If you want to use one single export from a barrel file that imports thousands of other things, you are still paying the price of importing other unneeded modules.

JavaScript 运行时中，每次执行 `require(...)` 或 `import '...'` 都存在一项隐性开销。即使你只想从一个“桶文件”（barrel file）中使用单个导出项，而该桶文件内部又导入了成千上万个其他模块，你依然要为所有这些未被实际使用的模块承担导入开销。

For many popular React packages, **it takes 200~800ms just to import them**. In some extreme cases, it can [take a few seconds.](https://marvinh.dev/blog/speeding-up-javascript-ecosystem-part-7/)

对于许多流行的 React 包而言，**仅导入它们本身就需要 200~800 毫秒**。在某些极端情况下，这一过程甚至可能[耗时数秒](https://marvinh.dev/blog/speeding-up-javascript-ecosystem-part-7/)。

These slowdowns affect both local development and production performance, especially in a serverless environment. Every time the app is started, we’ll have to import everything again.

此类性能下降既影响本地开发体验，也拖累生产环境表现——尤其在无服务器（serverless）环境中更为明显。每次应用启动时，我们都不得不重新导入全部依赖。

## Can’t we tree-shake it?

## 难道不能做摇树优化（tree-shaking）吗？

Tree-shaking is a _bundler_ feature (Webpack, Rollup, Parcel, esbuild, etc.), not a JavaScript runtime feature. If the library is marked as `external`, it remains a black box. The bundler can't do optimizations inside that box because the dependency would be required at runtime instead.

摇树优化（tree-shaking）是**打包器**（如 Webpack、Rollup、Parcel、esbuild 等）的功能，而非 JavaScript 运行时的特性。如果某个库被标记为 `external`，它就成为一个黑盒；打包器无法对该黑盒内部进行任何优化，因为该依赖将在运行时才被动态加载。

![](images/how-we-optimized-package-imports-in-next_js-vercel/img_001.jpg)![](images/how-we-optimized-package-imports-in-next_js-vercel/img_002.jpg)

![](images/how-we-optimized-package-imports-in-next_js-vercel/img_001.jpg)![](images/how-we-optimized-package-imports-in-next_js-vercel/img_002.jpg)

If we choose to bundle the library together with the application code, tree-shaking will work if the import doesn’t have side effects (`sideEffects` in `package.json`). However, it will take more time to compile all modules, analyze the whole module graph, and then tree-shake properly. This causes substantially slower builds.

如果我们选择将该库与应用代码一同打包，那么只要导入语句不带副作用（即其所在包的 `package.json` 中正确声明了 `"sideEffects": false`），摇树优化便可生效。但此举会显著增加构建耗时：需编译全部模块、分析整个模块依赖图，再执行精确的摇树剔除——最终导致构建速度大幅下降。

![](images/how-we-optimized-package-imports-in-next_js-vercel/img_003.jpg)![](images/how-we-optimized-package-imports-in-next_js-vercel/img_004.jpg)

![](images/how-we-optimized-package-imports-in-next_js-vercel/img_003.jpg)![](images/how-we-optimized-package-imports-in-next_js-vercel/img_004.jpg)

## Our first attempt: `modularizeImports`

## 我们的首次尝试：`modularizeImports`

The first approach we tried in Next.js was called [`modularizeImports`](https://nextjs.org/docs/architecture/nextjs-compiler#modularize-imports). This option allows you to configure the mapping relationship of exported names and their original module paths behind a package’s barrel file entrypoint.

我们在 Next.js 中最早尝试的方案名为 [`modularizeImports`](https://nextjs.org/docs/architecture/nextjs-compiler#modularize-imports)。该功能允许你配置包的桶文件入口点背后，各个导出名称与其原始模块路径之间的映射关系。

For example, if the package `my-lib` has this `index.js` as the entry:

例如，如果包 `my-lib` 以如下 `index.js` 作为入口文件：

my-lib/index.js

my-lib/index.js

```javascript
export { default as module1 } from './module1';

export { default as module2 } from './module2';

export { default as module3 } from './module3';
```

```javascript
export { default as module1 } from './module1';

export { default as module2 } from './module2';

export { default as module3 } from './module3';
```

We can configure a compiler transform of `my-lib/{{member}}`, which tells Next.js to change the user's import `import { module2 } from 'my-lib'` into `import module2 from 'my-lib/module2'`. This means we can skip the barrel file and directly import from the target, preventing loading unnecessary modules.

我们可以为 `my-lib/{{member}}` 配置一个编译器转换规则，该规则指示 Next.js 将用户代码中的导入语句 `import { module2 } from 'my-lib'` 改写为 `import module2 from 'my-lib/module2'`。这意味着我们可以跳过“barrel 文件”（即聚合导出的入口文件），直接从目标模块导入，从而避免加载不必要的模块。

This change makes both the build time _and_ runtime fast:

这一改动显著提升了**构建时**和**运行时**的性能：

![](images/how-we-optimized-package-imports-in-next_js-vercel/img_005.jpg)![](images/how-we-optimized-package-imports-in-next_js-vercel/img_006.jpg)

![](images/how-we-optimized-package-imports-in-next_js-vercel/img_005.jpg)![](images/how-we-optimized-package-imports-in-next_js-vercel/img_006.jpg)

However, this configuration is based on the internal directory structure of the library, and is configured heavily by hand. There are millions of `npm` packages with different versions, and there’s no way to scale with this solution efficiently.

然而，该配置依赖于库的内部目录结构，且需大量手动维护。npm 上有数以百万计的包，每个包又包含众多版本，这种方案根本无法高效扩展。

If the bundler includes a default configuration for popular libraries without locking down the library’s version, this will make the import transformation invalid when the internal structure of that lib changes in the future. We needed a better solution.

如果打包工具为热门库内置了默认配置，但又未锁定库的具体版本，那么一旦该库未来更改其内部结构，这些导入转换规则便会失效。我们需要一个更优的解决方案。

## New solution: `optimizePackageImports`

## 新解决方案：`optimizePackageImports`

To solve the remaining difficulties of configuring the `modularizeImports` option, we’ve introduced a new `optimizePackageImports` option to do it automatically in [Next.js 13.5](https://nextjs.org/blog/next-13-5).

为解决配置 `modularizeImports` 选项所遗留的难题，我们已在 [Next.js 13.5](https://nextjs.org/blog/next-13-5) 中引入了全新的 `optimizePackageImports` 选项，以自动完成该任务。

To start, you can configure which packages to opt in:

开始使用前，您可配置希望启用该功能的包：

next.config.js

next.config.js

```json
module.exports = {

2  experimental: {

3    optimizePackageImports: ["my-lib"]

4  }

5}
```

```json
module.exports = {

2  experimental: {

3    optimizePackageImports: ["my-lib"]

4  }

5}
```

When this option is enabled, Next.js will analyze the entry file of `my-lib` and figure out if it’s a barrel file. If so, it analyzes the file on the fly and automatically maps all imports, similarly to how `modularizeImports` works.

启用该选项后，Next.js 将分析 `my-lib` 的入口文件，并判断其是否为 barrel 文件；若是，则实时分析该文件，并自动映射全部导入语句，其工作方式与 `modularizeImports` 类似。

This process is cheaper than tree-shaking, since it only scans the entry barrel files in one pass. It also recursively handles nested barrel files and wildcard exports (`export * from`), and bails out of the process when hitting a non-barrel file.

该过程比摇树优化（tree-shaking）成本更低，因为它仅需单次遍历即可扫描入口 barrel 文件。它还能递归处理嵌套的 barrel 文件以及通配符导出（`export * from`），并在遇到非 barrel 文件时自动中止该过程。

Since this new option doesn’t depend on the package's internal implementations, we [pre-configured a list of common libraries](https://github.com/vercel/next.js/blob/12e888126ccf968193e7570a68db1bc35f90d52d/packages/next/src/server/config.ts#L710-L765) that immediately benefit from this, such as `lucide-react` and `@headlessui/react.`

由于这一新选项不依赖于包的内部实现，我们已[预配置了一份常用库列表](https://github.com/vercel/next.js/blob/12e888126ccf968193e7570a68db1bc35f90d52d/packages/next/src/server/config.ts#L710-L765)，使其可立即从中受益，例如 `lucide-react` 和 `@headlessui/react`。

In the future, we’re exploring ideas to automatically tell if a package should be opted-in or not. For now, the list can keep expanding as the community and our team discover new packages to optimize.

未来，我们正在探索如何自动判断某个包是否应被纳入该优化机制。目前，随着社区和我们的团队不断发现更多可优化的新包，该列表将持续扩充。

## Measuring performance improvements

## 性能提升效果评估

We've seen improvements in local development speed, production build speed, as well as faster cold starts.

我们在本地开发速度、生产环境构建速度，以及冷启动时间方面均观察到了显著提升。

### Local development

### 本地开发

In our local benchmarking on a M2 MacBook Air, when using one of the most popular icon or component libraries, we are seeing **a 15%~70% development time boost** depending on the actual library:

在搭载 M2 芯片的 MacBook Air 上进行的本地基准测试中，当使用当前最流行的图标库或组件库之一时，我们观察到开发时间提升了 **15%～70%**，具体增幅取决于所用库：

- `@mui/material`: 7.1s (2225 modules) -> 2.9s (735 modules) (-4.2s)

- `@mui/material`：7.1 秒（2225 个模块）→ 2.9 秒（735 个模块）（缩短 4.2 秒）

- `recharts`: 5.1s (1485 modules) -> 3.9s (1317 modules) (-1.2s)

- `recharts`：5.1 秒（1485 个模块）→ 3.9 秒（1317 个模块）（缩短 1.2 秒）

- `@material-ui/core`: 6.3s (1304 modules) -> 4.4s (596 modules) (-1.9s)

- `@material-ui/core`：6.3 秒（1304 个模块）→ 4.4 秒（596 个模块）（缩短 1.9 秒）

- `react-use`: 5.3s (607 modules) → 4.4s (337 modules) （-0.9s）

- `react-use`: 5.3 秒（607 个模块）→ 4.4 秒（337 个模块）（减少 0.9 秒）

- `lucide-react`: 5.8s (1583 modules) → 3s (333 modules) (-2.8s)

- `lucide-react`: 5.8 秒（1583 个模块）→ 3 秒（333 个模块）（减少 2.8 秒）

- `@material-ui/icons`: 10.2s (11738 modules) → 2.9s (632 modules) (-7.3s)

- `@material-ui/icons`: 10.2 秒（11738 个模块）→ 2.9 秒（632 个模块）（减少 7.3 秒）

- `@tabler/icons-react`: 4.5s (4998 modules) → 3.9s (349 modules) (-0.6s)

- `@tabler/icons-react`: 4.5 秒（4998 个模块）→ 3.9 秒（349 个模块）（减少 0.6 秒）

- `rxjs`: 4.3s (770 modules) → 3.3s (359 modules) (-1.0s)

- `rxjs`: 4.3 秒（770 个模块）→ 3.3 秒（359 个模块）（减少 1.0 秒）

These time savings are for the initial boot in local dev, but they _also_ affect the speed of Hot Module Replacement (HMR), letting live local dev feel much faster. The numbers add up quickly if you are using multiple libraries with many sub-modules.

这些时间节省体现在本地开发环境的首次启动过程中，但它们 _同样_ 提升了热模块替换（HMR）的速度，使本地实时开发体验显著加快。如果你同时使用多个包含大量子模块的库，这些优化效果会迅速叠加。

### Production builds

### 生产环境构建

In a benchmark of a Next.js App Router page with `lucide-react` and `@headlessui/react`, built on a M2 MacBook Air, `next build` runs **~28% faster** because it no longer needs to do module resolution and tree-shaking.

在搭载 M2 芯片的 MacBook Air 上，对一个使用 `lucide-react` 和 `@headlessui/react` 的 Next.js App Router 页面进行基准测试，`next build` 构建速度提升约 **28%**，因为不再需要执行模块解析与摇树优化（tree-shaking）。

### Faster cold boots

### 更快的冷启动

In a local environment, we’re seeing the Node.js server start **~10% faster** when rendering a simple route that uses `lucide-react` and `@headlessui/react`.

在本地环境中，当渲染一个使用 `lucide-react` 和 `@headlessui/react` 的简单路由时，Node.js 服务的冷启动速度提升约 **10%**。

In a serverless environment like Vercel, this decreases both the deployed code size and the number of Node.js `require` calls. We’ve measured up to **40% faster cold starts** paired with other improvements included in [Next.js 13.5](https://nextjs.org/blog/next-13-5).

在像 Vercel 这样的无服务器（serverless）环境中，此举既减小了部署代码的体积，也减少了 Node.js 中 `require` 调用的次数。我们实测冷启动速度最高提升了 **40%**，并结合了 [Next.js 13.5](https://nextjs.org/blog/next-13-5) 中包含的其他多项优化。

### Recursive Barrel Files

### 递归式 Barrel 文件

[The last change](https://github.com/vercel/next.js/pull/56489) we've made handles recursive barrel files, optimizing them into a single module. To test, we created [this module](https://unpkg.com/browse/recursive-barrel@1.0.0/) with 4 levels of 10 `export *` expressions, equaling 10,000 modules in total.

我们最近完成的 [一项变更](https://github.com/vercel/next.js/pull/56489) 支持对递归式 barrel 文件进行处理，并将其优化为单个模块。为验证效果，我们构建了 [这个模块](https://unpkg.com/browse/recursive-barrel@1.0.0/)：它包含 4 层嵌套、每层含 10 个 `export *` 语句，总计导出 10,000 个模块。

Before, this recursive package would take ~30 seconds to compile. After, it's just ~7s. We've seen 90% faster reloads from some [customers](https://github.com/vercel/next.js/pull/56489#issuecomment-1751099866) with over 100,000 modules.

此前，该递归式包的编译耗时约为 30 秒；优化后仅需约 7 秒。部分拥有超过 100,000 个模块的 [客户](https://github.com/vercel/next.js/pull/56489#issuecomment-1751099866) 反馈热重载（hot reload）速度提升了 90%。

## Conclusion

## 总结

We recommend upgrading to the latest version of Next.js to see significant performance improvements in local dev performance and production cold starts. You might also consider adding [this ESLint rule](https://github.com/gajus/eslint-plugin-canonical#no-barrel-import) to prevent barrel file imports.

我们建议升级至最新版 Next.js，以显著提升本地开发体验与生产环境冷启动性能。您还可考虑启用 [这条 ESLint 规则](https://github.com/gajus/eslint-plugin-canonical#no-barrel-import)，以避免 barrel 文件导入。

[![Malte Ubl](images/how-we-optimized-package-imports-in-next_js-vercel/img_007.jpg)](https://x.com/cramforce/status/1699427661263557050)

[![马尔特·乌布](images/how-we-optimized-package-imports-in-next_js-vercel/img_007.jpg)](https://x.com/cramforce/status/1699427661263557050)

[Malte Ubl](https://x.com/cramforce/status/1699427661263557050)

[马尔特·乌布（Malte Ubl）](https://x.com/cramforce/status/1699427661263557050)


· [Follow](https://x.com/intent/follow?screen_name=cramforce)

· [关注](https://x.com/intent/follow?screen_name=cramforce)

[View on Twitter](https://x.com/cramforce/status/1699427661263557050)

[在 Twitter 上查看](https://x.com/cramforce/status/1699427661263557050)

Did some research on popular next.js dependencies and their impact on dev start/compile/cold-start times. Material UI reigns supreme at over 10K exports and just importing it on my Macbook Pro takes 3.5 seconds 🤯  
我调研了一些主流 Next.js 依赖库及其对开发启动、编译及冷启动时间的影响。Material UI 以超过 10,000 个导出项高居榜首——仅在我的 MacBook Pro 上导入它就需要 3.5 秒 🤯  

Now working with [@shuding](https://x.com/shuding) and [@feedthejim](https://x.com/feedthejim) to make sure these all  
目前正与 [@shuding](https://x.com/shuding) 和 [@feedthejim](https://x.com/feedthejim) 合作，确保所有这些（问题）都能得到妥善解决。

[10:21 AM · Sep 6, 2023](https://x.com/cramforce/status/1699427661263557050) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)  
[上午 10:21 · 2023 年 9 月 6 日](https://x.com/cramforce/status/1699427661263557050) [网站版 Twitter、广告信息与隐私政策](https://help.x.com/zh-cn/x-for-websites-ads-info-and-privacy)

[143](https://x.com/intent/like?tweet_id=1699427661263557050) [Reply](https://x.com/intent/tweet?in_reply_to=1699427661263557050)  
[143 次点赞](https://x.com/intent/like?tweet_id=1699427661263557050) [回复](https://x.com/intent/tweet?in_reply_to=1699427661263557050)

[Read 4 replies](https://x.com/cramforce/status/1699427661263557050)  
[查看 4 条回复](https://x.com/cramforce/status/1699427661263557050)

Vercel.com landing page  
Vercel.com 官网落地页

### Incrementally adopt the App Router  
### 渐进式采用 App Router

Vercel Template  
Vercel 模板

Deploy this template  
部署此模板

### Examples of many Next.js App Router features.  
### 多种 Next.js App Router 功能示例。

Next.js App Router Playground  
Next.js App Router 交互式体验环境
{% endraw %}
