---
title: "Next.js 5.1: Faster Page Resolution - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/next5-1"
date: "2018-03-26"
scraped_at: "2026-03-02T10:08:03.534118441+00:00"
language: "en-zh"
translated: true
description: "Next.js 5.1 features support for environment configuration, phases, source maps, and new Next.js plugins."
---

Mar 26, 2018

2018 年 3 月 26 日

We are happy to introduce Next.js 5.1, which features support for environment configuration, phases, source maps, and new Next.js plugins.

我们很高兴地推出 Next.js 5.1，该版本新增了对环境配置、构建阶段（phases）、源码映射（source maps）以及一系列全新 Next.js 插件的支持。

Major performance improvements are introduced: resolving pages is **102x** faster, and error pages are loaded more efficiently.

性能方面实现了重大提升：页面解析速度提升了 **102 倍**，错误页面的加载也更加高效。

To upgrade or install, run:

如需升级或安装，请运行以下命令：

```bash
npm i next@latest react@latest react-dom@latest
```

```bash
npm i next@latest react@latest react-dom@latest
```

In addition to bumping Next.js, we upgrade the peer dependencies \`react\` and \`react-dom\`

除升级 Next.js 本身外，我们还将对等依赖项（peer dependencies）`react` 和 `react-dom` 一并升级。

Be sure to upgrade [next-plugins](https://github.com/zeit/next-plugins) like `@zeit/next-css`, `@zeit/next-sass`, `@zeit/next-less` or `@zeit/next-typescript` as well.

请务必同时升级 [next-plugins](https://github.com/zeit/next-plugins) 相关插件，例如 `@zeit/next-css`、`@zeit/next-sass`、`@zeit/next-less` 或 `@zeit/next-typescript`。

## Faster page resolution

## 页面解析速度大幅提升

Thanks to the architectural changes in Next.js 5.0, we were able to [simplify the logic](https://github.com/zeit/next.js/pull/3776) that resolves pages based on url path. These changes were based on [research](https://github.com/zeit/next.js/issues/3682) from [@oliviertassinari](https://github.com/oliviertassinari).

得益于 Next.js 5.0 中的架构调整，我们成功[简化了基于 URL 路径解析页面的逻辑](https://github.com/zeit/next.js/pull/3776)。这一改进基于 [@oliviertassinari](https://github.com/oliviertassinari) 所开展的[相关研究](https://github.com/zeit/next.js/issues/3682)。

Previously resolving a page took an average of **2.347ms**. With the new logic resolving the same page takes on average **0.023ms**. That's a **102x** speedup for one of the most commonly invoked methods in Next.js applications.

此前，解析一个页面平均耗时 **2.347 毫秒**；而采用新逻辑后，解析同一页面平均仅需 **0.023 毫秒**。这使得 Next.js 应用中最常调用的方法之一实现了 **102 倍**的性能提升。

![Page resolution shown per request. Left is Next.js 5.0, right is Next.js 5.1](images/next_js-5_1-faster-page-resolution-vercel/img_001.jpg)  
每次请求显示的页面解析过程。左侧为 Next.js 5.0，右侧为 Next.js 5.1。

## Environment configuration  

## 环境配置

Typical Node.js environments often depend on passing environment variables to the application, for example: `API_URL=https://api.zeit.co node index.js` and then you can use `API_URL` anywhere in your application using `process.env.API_URL`.  

典型的 Node.js 环境通常依赖于向应用传递环境变量，例如：`API_URL=https://api.zeit.co node index.js`；随后即可在应用任意位置通过 `process.env.API_URL` 使用 `API_URL`。

With universal rendering `process.env` is not available on the client side. So with Next 5.1 we're introducing a new feature: `publicRuntimeConfig` and `serverRuntimeConfig`. These can be set in `next.config.js` and will then be available using the `next/config` module.  

在同构（universal）渲染模式下，`process.env` 在客户端不可用。因此，Next.js 5.1 引入了一项新功能：`publicRuntimeConfig`（公共运行时配置）和 `serverRuntimeConfig`（服务端运行时配置）。这两者均可在 `next.config.js` 中设置，并可通过 `next/config` 模块在代码中访问。

next.config.js  

```javascript
module.exports = {

2  serverRuntimeConfig: { // Will only be available on the server side  

3    mySecret: 'secret'  

4  },  

5  publicRuntimeConfig: { // Will be available on both server and client  
```

6    staticFolder: '/static'

6    staticFolder: '/static'

7  }

7  }

8}

8}

```

Both \`serverRuntimeConfig\` and \`publicRuntimeConfig\` are defined in \`next.config.js\`

`serverRuntimeConfig` 和 `publicRuntimeConfig` 均在 `next.config.js` 中定义。

pages/index.js

pages/index.js

```javascript
import getConfig from 'next/config'

import getConfig from 'next/config'

const {serverRuntimeConfig, publicRuntimeConfig} = getConfig()



const {serverRuntimeConfig, publicRuntimeConfig} = getConfig()



console.log(serverRuntimeConfig.mySecret) // Will only be available on the server side

console.log(serverRuntimeConfig.mySecret) // 仅在服务端可用

console.log(publicRuntimeConfig.staticFolder) // Will be available on both server and client

console.log(publicRuntimeConfig.staticFolder) // 在服务端和客户端均可用

```markdown
export default () => <div>

8  <img src='\${publicRuntimeConfig.staticFolder}/logo.png' />

9</div>
```

```markdown
`next/config` 模块中的 `getConfig` 方法用于获取配置值。

## 改进的错误处理

此前，Next.js 采用了一种特殊的错误处理机制，用于在加载页面资源包（page bundle）时检测服务端错误。所谓页面资源包，是指在客户端加载页面时所请求的 JavaScript 文件，例如 `/_next/-/page/index.js`。

如果发生错误（例如构建 ID 不匹配），该页面资源包仍会以 HTTP 200 状态返回，但响应体内容将不再是可执行的 JavaScript，而是由 Next.js 服务端生成的一个 JSON 格式错误对象。这样设计的原因在于：客户端的错误处理逻辑不仅依赖于页面是否返回 404，还需根据该 JSON 错误进行更精细的判断。这一方案原本运行良好，但当你尝试将静态资源部署到不支持 fallback（回退）机制的静态文件托管服务或 CDN 时，问题便暴露出来。

在 Next.js 5.1 中，我们已[彻底重构](https://github.com/zeit/next.js/pull/3849)了错误处理逻辑：当页面资源包返回 HTTP 404 状态时，路由系统（router）将自动识别该情况并触发整页重载（full-page reload），从而确保在 [多区域（multi-zones）](https://github.com/zeit/next.js#multi-zones) 架构下的页面导航依然可靠。

在重写该逻辑的过程中，我们[移除了 `Router.onAppUpdated` 钩子](https://github.com/zeit/next.js/blob/canary/errors/no-on-app-updated-hook.md)，该钩子此前主要用于手动触发页面重载；如今该行为已由框架自动完成。
```

In addition to this, we've added a new set of [integration tests](https://github.com/zeit/next.js/pull/3895) on error recovery in the development mode, to avoid regressions on error recovery in future releases.

此外，我们新增了一套针对开发模式下错误恢复功能的[集成测试](https://github.com/zeit/next.js/pull/3895)，以防止未来版本中错误恢复功能出现回归问题。

## Phases / config function

## 阶段（Phases）/ 配置函数（config function）

Some [next-plugins](https://github.com/zeit/next-plugins) like [`@zeit/next-css`](https://github.com/zeit/next-plugins/tree/master/packages/next-css) are only required when Next.js is in development mode or when running `next build`.

某些 [next-plugins](https://github.com/zeit/next-plugins)（例如 [`@zeit/next-css`](https://github.com/zeit/next-plugins/tree/master/packages/next-css)）仅在 Next.js 处于开发模式或执行 `next build` 命令时才需要。

You can now export a function that returns the configuration object instead of immediately exporting the object.

现在，您可导出一个返回配置对象的函数，而非直接导出配置对象本身。

```javascript
module.exports = (phase, {defaultConfig}) => config
```

```javascript
module.exports = (phase, {defaultConfig}) => config
```

\`next.config.js\` exporting a function that returns the user configuration

`next.config.js` 导出一个返回用户配置的函数

Exporting a function will give you access to the `phase` in which Next.js is running, for example development, production, building, export. This allows plugins to be loaded only when needed, but also gives access to the default configuration.

导出函数将使您能够访问 Next.js 当前所处的运行阶段（`phase`），例如开发（development）、生产（production）、构建（building）、导出（export）。这不仅支持插件按需加载，还允许您访问默认配置。

We've introduced a new module called `next/constants` holding commonly used constants, including phases.

我们引入了一个名为 `next/constants` 的新模块，其中包含常用常量，例如各运行阶段（phases）。

```javascript
const {PHASE_DEVELOPMENT_SERVER} = require('next/constants')

module.exports = (phase, {defaultConfig}) {
```

```javascript
const {PHASE_DEVELOPMENT_SERVER} = require('next/constants')

module.exports = (phase, {defaultConfig}) {
```

3  if(phase === PHASE_DEVELOPMENT_SERVER) {

3  如果 phase 等于 PHASE_DEVELOPMENT_SERVER：

4    return { /* development only config options here */ }

4    返回 { /* 此处为仅适用于开发环境的配置选项 */ }

5  }



5  }


7  return { /* config options for all phases except development here */ }

7  返回 { /* 此处为除开发环境外所有阶段共用的配置选项 */ }

8}
```

8}
```

`next.config.js` that checks for the development phase

用于检测开发阶段的 `next.config.js`

## Improved production source map generation

## 生产环境源码映射（source map）生成能力增强

With the introduction of universal webpack in [Next.js 5](https://zeit.co/blog/next5) adding source maps to your production environment became as simple as adding a few lines to `next.config.js`:

随着 [Next.js 5](https://zeit.co/blog/next5) 中通用 Webpack 的引入，为生产环境添加源码映射（source map）已简化为只需在 `next.config.js` 中添加几行代码：

2  webpack(config, {dev}) {

2  webpack(config, {dev}) {

3    if (!dev) {

3    如果不是开发模式（!dev）：

4      config.devtool = 'source-map';

4      config.devtool = 'source-map';

5      for (const plugin of config.plugins) {

5      遍历 config.plugins 中的每个插件：

6        if (plugin['constructor']['name'] === 'UglifyJsPlugin') {

6        如果该插件的构造函数名称为 'UglifyJsPlugin'：

7          plugin.options.sourceMap = true;

7          将 plugin.options.sourceMap 设为 true；

8          break;

8          跳出循环；

9        }

9        }

10      }

10      }

11    }

11    }

12    return config

12    返回 config

13  }

13  }

14}
```

14}
```

Manually enable source maps in \`next.config.js\`

在 \`next.config.js\` 中手动启用源映射（source maps）

[@zeit/next-source-maps](https://github.com/zeit/next-plugins/tree/master/packages/next-source-maps) can be added to a project to automatically enable production source maps for you, add the following to `next.config.js`:

[@zeit/next-source-maps](https://github.com/zeit/next-plugins/tree/master/packages/next-source-maps) 可被添加到项目中，以自动为生产环境启用源映射。请将以下代码添加到 `next.config.js` 中：

```javascript
const withSourceMaps = require('@zeit/next-source-maps')

module.exports = withSourceMaps()
```

```javascript
const withSourceMaps = require('@zeit/next-source-maps')

module.exports = withSourceMaps()
```

Using \`@zeit/next-source-maps\` to enable source maps in \`next.config.js\`

使用 \`@zeit/next-source-maps\` 在 \`next.config.js\` 中启用源映射

This enabled outputting of source maps for all but one file, `app.js`, the reason for this was that `app.js` consisted of multiple files (`manifest.js` and `commons.js`) combined with a webpack plugin. A side effect of this was that webpack couldn't generate source maps for the combined file.

此举使除 `app.js` 外的所有文件均能输出源映射；原因在于 `app.js` 是由多个文件（`manifest.js` 和 `commons.js`）通过一个 webpack 插件合并而成的。这一合并操作带来的副作用是：webpack 无法为该合并后的文件生成源映射。

Thanks to a [pull request](https://github.com/zeit/next.js/pull/3793) from [@ptomasroos](https://github.com/ptomasroos) the `app.js` file was replaced by `main.js`. This file will hold the code that was previously compiled to `manifest.js` and `commons.js` and webpack will generate a source map for `main.js`. Source maps will be automatically served, allowing external error tracking tools to show the actual file and line number when errors are detected.

感谢 [@ptomasroos](https://github.com/ptomasroos) 提交的 [Pull Request](https://github.com/zeit/next.js/pull/3793)，`app.js` 文件已被 `main.js` 所取代。该新文件将承载原先编译至 `manifest.js` 和 `commons.js` 的代码，且 webpack 将为 `main.js` 生成对应的源映射。源映射将被自动提供，从而使外部错误追踪工具在捕获错误时，能够准确显示实际出错的文件名与行号。

![The source code is shown in the sources panel](images/next_js-5_1-faster-page-resolution-vercel/img_002.jpg)  
源代码显示在“Sources”（源代码）面板中。

## New plugins / improvements to existing ones

## 新增插件 / 现有插件的改进

We've introduced two new official plugins. [@zeit/next-bundle-analyzer](https://github.com/zeit/next-plugins/tree/master/packages/next-bundle-analyzer) allows for easily setting up `webpack-bundle-analyzer` to analyze the server side and client side bundles separately.

我们推出了两个新的官方插件。[@zeit/next-bundle-analyzer](https://github.com/zeit/next-plugins/tree/master/packages/next-bundle-analyzer) 可帮助你轻松配置 `webpack-bundle-analyzer`，从而分别分析服务端与客户端的打包产物。

Additionally there were a lot of improvements to the official [`css`](https://github.com/zeit/next-plugins/tree/master/packages/next-css), [`less`](https://github.com/zeit/next-plugins/tree/master/packages/next-less), and [`sass`](https://github.com/zeit/next-plugins/tree/master/packages/next-sass) plugins regarding hot reloading and bundling. For example there is no longer a flash of unstyled content in development mode. And styles in subcomponents get picked up as well.

此外，官方 [`css`](https://github.com/zeit/next-plugins/tree/master/packages/next-css)、[`less`](https://github.com/zeit/next-plugins/tree/master/packages/next-less) 和 [`sass`](https://github.com/zeit/next-plugins/tree/master/packages/next-sass) 插件在热重载（hot reloading）和打包方面也进行了大量优化。例如，开发模式下不再出现未样式化内容的闪烁（FOUC）；子组件中的样式也能被正确识别并加载。

## Thank you

## 致谢

We would like to thank everyone who has contributed to Next.js for this release. Whether it's contributing to the core or expanding and improving our ever growing [examples directory](https://github.com/zeit/next.js/tree/canary/examples).

我们衷心感谢所有为本次 Next.js 版本发布做出贡献的开发者——无论您是参与核心功能开发，还是持续扩充与优化我们日益丰富的 [示例目录](https://github.com/zeit/next.js/tree/canary/examples)。

If you are looking to start contributing to Next.js you can find issues with the [good first issue](https://github.com/zeit/next.js/issues?q=is%3Aissue+is%3Aopen+sort%3Aupdated-desc+label%3A%22good+first+issue%22) or [help wanted](https://github.com/zeit/next.js/issues?q=is%3Aissue+is%3Aopen+sort%3Aupdated-desc+label%3A%22help+wanted%22) label.

如果您希望开始为 Next.js 贡献代码，欢迎查阅带有 [good first issue](https://github.com/zeit/next.js/issues?q=is%3Aissue+is%3Aopen+sort%3Aupdated-desc+label%3A%22good+first+issue%22) 或 [help wanted](https://github.com/zeit/next.js/issues?q=is%3Aissue+is%3Aopen+sort%3Aupdated-desc+label%3A%22help+wanted%22) 标签的问题。

A special thank you to Trulia for their valuable feedback related to environment configuration and the new error page handling.

特别感谢 Trulia 团队就环境配置及全新错误页面处理机制所提供的宝贵反馈。