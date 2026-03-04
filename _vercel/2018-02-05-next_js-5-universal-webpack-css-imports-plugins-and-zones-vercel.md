---
title: "Next.js 5: Universal Webpack, CSS Imports, Plugins and Zones - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/next5"
date: "2018-02-05"
scraped_at: "2026-03-02T10:07:55.085440919+00:00"
language: "en-zh"
translated: true
description: "Next.js 5 focuses on greater extensibility, composability for large applications and performance"
---

render_with_liquid: false
Feb 5, 2018

2018 年 2 月 5 日

We are very happy to introduce Next.js 5.0 to the world. It’s available on npm effective immediately.

我们非常高兴向全世界推出 Next.js 5.0。它已即时发布至 npm。

To upgrade, run:

升级方法如下：

```bash
1$ npm i next@latest react@latest react-dom@latest
```

In addition to bumping Next.js, we upgrade the peer dependencies \`react\` and \`react-dom\`

除升级 Next.js 本身外，我们还同步更新了对等依赖项 \`react\` 和 \`react-dom\`。

Next.js is a toolkit for universal, server-rendered (or [statically pre-rendered](https://vercel.com/blog/next3)) React.js applications. Getting started developing an application of any size is as easy as executing `next`. ( [Read more](https://vercel.com/blog/next).)

Next.js 是一个用于构建通用型（universal）、服务端渲染（或 [静态预渲染](https://vercel.com/blog/next3)）React.js 应用的工具包。无论应用规模大小，只需执行 `next` 命令即可快速启动开发。（[了解更多](https://vercel.com/blog/next)）

With every new release we are [committed](https://vercel.com/blog/oss) to retaining backwards compatibility, offering simple upgrade paths and only making API changes when absolutely necessary. Next.js 5.0 is no exception.

我们始终 [致力于](https://vercel.com/blog/oss) 在每次新版本发布时保持向后兼容性，提供简洁明了的升级路径，并仅在绝对必要时才变更 API。Next.js 5.0 同样遵循这一承诺。

Under the hood, however, Next.js has undergone a radical transformation to enable powerful new use cases and extensibility. We started by making Next.js share a universal Webpack pipeline for both server and client code.

然而，在底层实现上，Next.js 已经历一次根本性重构，以支持更强大的新应用场景与可扩展性。我们首先让 Next.js 在服务端与客户端代码之间共享一条通用的 Webpack 构建流水线。

## Universal Webpack and Next Plugins

## 通用 Webpack 与 Next 插件

Next.js leverages existing powerful tools like Webpack, Babel and Uglify, presented to the end-user as a remarkable simple interface: `next` (to develop), `next build` (to prepare for production) and `next start` (to serve) or `next export` to pre-render to static files.

Next.js 充分利用 Webpack、Babel 和 Uglify 等现有强大工具，并为终端用户呈现极为简洁的接口：`next`（用于开发）、`next build`（用于生产环境准备）、`next start`（用于启动服务），或 `next export`（用于导出为静态文件）。

One of the early decisions we made was to provide very powerful extensibility points for how these tools are configured. We didn't just want ease of use, we wanted to enable flexibility to extend the toolkit however you wanted.

我们早期做出的一项重要决策，是为这些工具的配置方式提供极为强大的可扩展性接口。我们不仅追求易用性，更希望赋予您充分的灵活性，让您能按需任意扩展该工具集。

For example, you can [extend the Next.js webpack configuration](https://github.com/zeit/next.js#customizing-webpack-config) by setting up a `webpack` property in your `next.config.js`.

例如，您可以通过在 `next.config.js` 文件中配置 `webpack` 属性，来[扩展 Next.js 的 webpack 配置](https://github.com/zeit/next.js#customizing-webpack-config)。

Because webpack executes differently for production and development, we decided at the time to make it a function that decorates our default webpack config:

由于 webpack 在生产环境和开发环境下的执行方式不同，我们当时决定将其设计为一个函数，用于修饰（decorate）我们默认的 webpack 配置：

```javascript
module.exports = {

2  webpack(config, { dev }) {

3    // modify it!

4    return config;

5  }

6}
```

```javascript
module.exports = {

2  webpack(config, { dev }) {

3    // 修改它！

4    return config;

5  }

6}
```

An example of the optional \`next.config.js\` file

一个可选的 \`next.config.js\` 文件示例

However, Webpack would only execute on the client (browser) bundles, and you would miss out on the possibility of using this great toolchain for server-rendering.

然而，Webpack 之前仅在客户端（浏览器）构建中运行，导致您无法将这一强大的工具链用于服务端渲染。

We are happy to announce that we have extensively refactored our codebase to **make Webpack work universally**.

我们很高兴地宣布：我们已对代码库进行了大规模重构，**使 Webpack 能够通用化运行（即同时支持客户端与服务端）**。

From your perspective, all that changes is that an additional `isServer` property is passed to the decorator function above. However, the new semantics mean that the broad ecosystem of Webpack loaders are now available for you to use.

从您的视角来看，唯一的变化是上述装饰器函数现在会额外接收一个 `isServer` 属性。但这一语义更新意味着：整个庞大的 Webpack loader 生态系统现已向您全面开放，可供自由使用。

### CSS, LESS, SASS, SCSS and CSS Modules

### CSS、LESS、SASS、SCSS 与 CSS Modules

One of our most highly requested features is the ability to import CSS files and take advantage of Webpack loaders:

我们收到最多、呼声最高的功能之一，便是支持直接导入 CSS 文件，并充分利用 Webpack loader 的能力：

```javascript
import './index.css'

export default () => (

3  <div>

4    <p>I love CSS!</p>

5  </div>
```

6)  
6)  

```
一个使用 CSS 导入（得益于 Universal Webpack）的示例页面（`pages/index.js`）

要使此功能正常工作，你可以将所需的加载器作为对等依赖（peer dependencies）引入：

```bash
1$ npm i --save css-loader style-loader postcss-loader
```

Next.js 为你提供了充分的自由度：你可以按需选择所需加载器，并随时将其升级至任意版本。

接着，通过扩展配置来设置这些加载器。在 `next.config.js` 中：

```javascript
module.exports = {

2  webpack(config, options) {

3    const { dev, isServer } = options

4    const extractCSSPlugin = new ExtractTextPlugin({

5      filename: 'static/style.css',

5      文件名: 'static/style.css',

6      disable: dev

6      禁用: dev

7    })

7    })

8    config.module.rules.push({

8    config.module.rules.push({

9      test: /\.css$/,

9      test: /\.css$/,

10      use: cssLoaderConfig(extractCSSPlugin, {

10      use: cssLoaderConfig(extractCSSPlugin, {

11        cssModules,

11        cssModules,

12        dev,

12        dev,

13        isServer

13        isServer

14      })

14      })

15    })

16    return config

16    返回配置对象

17  }

17  }

18}
```

18}
```

Extending the raw webpack config gives you great flexibility and control

扩展原始的 webpack 配置可为您提供极高的灵活性与控制力。

While our general recommendation is to use component-local styling solutions, like the [included `styled-jsx` babel plugin](https://github.com/zeit/next.js#built-in-css-support), we believe CSS loaders have many important strengths, like making it easy to re-use existing CSS codebases and vastly simplifying migrating old codebases to Next.js.

尽管我们通常建议使用组件级样式方案（例如内置的 [`styled-jsx` Babel 插件](https://github.com/zeit/next.js#built-in-css-support)），但我们认为 CSS 加载器具备诸多重要优势，例如：便于复用现有 CSS 代码库，并能极大简化将旧有代码库迁移到 Next.js 的过程。

Instead of enabling every conceivable feature and loader by default, we are introducing [Next.js plugins](https://github.com/zeit/next-plugins), which are _simple functions that decorate your configuration_. Instead of manually extending the configuration to set up the loaders like we did above, you can just do:

我们并未默认启用所有可能的功能和加载器，而是推出了 [Next.js 插件](https://github.com/zeit/next-plugins)——它们是“**用于增强配置的简单函数**”。相比上文手动扩展配置以设置加载器的方式，您现在只需执行如下操作即可：

```javascript
const withCss = require('next-css');

module.exports = withCss({ /* extra optional config */ })
```

```javascript
const withCss = require('next-css');

module.exports = withCss({ /* 额外的可选配置 */ })
```

All it takes to enable importing \`.css\` files is to bring in \`next-css\`

只需引入 \`next-css\`，即可启用对 \`.css\` 文件的导入功能。

Read more on [CSS Loaders](https://github.com/zeit/next-plugins/tree/master/packages/next-css) usage with Next.JS, or refer to some of the packages we have already created for you:

了解更多关于 Next.js 中 [CSS 加载器](https://github.com/zeit/next-plugins/tree/master/packages/next-css) 的用法，或参考我们已为您创建的部分插件：

- CSS: [next-css](https://github.com/zeit/next-plugins/tree/master/packages/next-css)

- CSS：[next-css](https://github.com/zeit/next-plugins/tree/master/packages/next-css)

- LESS: [next-less](https://github.com/zeit/next-plugins/tree/master/packages/next-less)

- LESS：[next-less](https://github.com/zeit/next-plugins/tree/master/packages/next-less)

- SASS: [next-sass](https://github.com/vercel/next-plugins/tree/master/packages/next-sass)

- SASS：[next-sass](https://github.com/vercel/next-plugins/tree/master/packages/next-sass)

Our goal is to empower the community to develop and grow an ecosystem of practical simple extensions. To that end, we are opening the [next-plugins](https://github.com/zeit/next-plugins) monorepo for the Next.js community to maintain. All PRs are welcome!

我们的目标是赋能社区，共同开发并壮大一个由实用、简洁的扩展组成的生态系统。为此，我们已将 [next-plugins](https://github.com/zeit/next-plugins) 单体仓库向 Next.js 社区开放维护。欢迎提交所有 Pull Request！

### TypeScript Support

### TypeScript 支持

One of the [fastest growing technologies](https://2017.stateofjs.com/2017/flavors/results/) in the JavaScript ecosystem is TypeScript. So much so, that it is becoming [officially supported by Babel 7](https://github.com/babel/babel/tree/master/packages/babel-preset-typescript), which means it will naturally be supported by Next.js by just [customizing your .babelrc](https://github.com/zeit/next.js#customizing-babel-config).

TypeScript 是 JavaScript 生态系统中 [增长最快的技術之一](https://2017.stateofjs.com/2017/flavors/results/)。其普及程度之高，已促使 Babel 7 将其纳入 [官方支持](https://github.com/babel/babel/tree/master/packages/babel-preset-typescript)，这意味着只需 [自定义您的 `.babelrc`](https://github.com/zeit/next.js#customizing-babel-config)，Next.js 即可原生支持 TypeScript。

In the mean time, thanks to our new Universal Webpack support, you can already get full TypeScript support _today_!

与此同时，得益于我们全新的通用 Webpack 支持，您**今天即可获得完整的 TypeScript 支持**！

You can extend your webpack config like this:

您可按如下方式扩展您的 webpack 配置：

```javascript
module.exports = {

2  webpack(config, options) {

2  webpack(config, options) {

3    const { dir, defaultLoaders } = options

3    const { dir, defaultLoaders } = options

4    config.resolve.extensions.push('.ts', '.tsx')

4    config.resolve.extensions.push('.ts', '.tsx')

5    config.module.rules.push({

5    config.module.rules.push({

6      test: /\.+(ts|tsx)$/,

6      test: /\.+(ts|tsx)$/,

7      include: [dir],

7      include: [dir],

8      exclude: /node_modules/,

8      exclude: /node_modules/,

9      use: [\
\
10        defaultLoaders.babel,\
\
11        { loader: 'ts-loader', options: { transpileOnly: true } }\
\
12      ]

9      use: [\
\
10        defaultLoaders.babel,\
\
11        { loader: 'ts-loader', options: { transpileOnly: true } }\
\
12      ]

13    })

13    })

14    return config

14    return config

15  }

15  }

16}

16}

```

All we have to do is enable the `ts-loader`

```

我们只需启用 `ts-loader` 即可。

Like CSS loaders and pre-processors, TypeScript has been one of the most requested features. To make incorporating it into projects just as easily as any other loader, we now have a [`next-typescript` plugin](https://front-git-removed-remaining-local-posts.vercel.vercel.app/) you can include in your `next.config.js` file:

像 CSS 加载器（loaders）和预处理器（pre-processors）一样，TypeScript 一直是用户呼声最高的功能之一。为了使 TypeScript 能像其他加载器一样轻松集成到项目中，我们现在提供了 [`next-typescript` 插件](https://front-git-removed-remaining-local-posts.vercel.vercel.app/)，您可将其添加至 `next.config.js` 文件中：

```javascript
const withTs = require('next-typescript');

module.exports = withTs({ /* additional config*/ })
```

```javascript
const withTs = require('next-typescript');

module.exports = withTs({ /* 其他配置 */ })
```

Plugins can be trivially composed: they are just functions

插件可轻松组合：它们本质上只是函数。

### Better Support for React Altlibs & Module Overloading

### 对 React 替代库及模块重载的更好支持

Many drop-in replacement implementations of React have emerged over time. Among them, some notable ones are [`preact`](https://preactjs.com/), [`nervjs`](https://github.com/NervJS/nerv) and [`inferno`](https://github.com/infernojs/inferno).

多年来，涌现出了许多可即插即用的 React 替代实现。其中较知名的包括 [`preact`](https://preactjs.com/)、[`nervjs`](https://github.com/NervJS/nerv) 和 [`inferno`](https://github.com/infernojs/inferno)。

Other libraries focus on replacing the DOM renderer, like [`react-dom-lite`](https://github.com/jquense/react-dom-lite), which is aiming to make a smaller React build by introducing some minor tradeoffs in browser compatibility.

另一些库则专注于替换 DOM 渲染器，例如 [`react-dom-lite`](https://github.com/jquense/react-dom-lite)，它通过在浏览器兼容性方面做出一些轻微取舍，来构建更轻量的 React 版本。

Universal Webpack support makes the process of incorporating these libraries as drop-in replacements even easier.

通用 Webpack 支持使得将这些库作为即插即用（drop-in）替代方案集成的过程变得更加轻松。

In the same vein as the other plugins, this is all you have to do to use Next.js with preact:

与其它插件类似，要将 Next.js 与 Preact 配合使用，您只需完成以下步骤：

```bash
1$ npm i @zeit/next-preact preact preact-compat
```

```bash
1$ npm i @zeit/next-preact preact preact-compat
```

We install the preact plugin and necessary peer dependencies

我们安装 Preact 插件及其所需的对等依赖（peer dependencies）。

```javascript
const withPreact = require('@zeit/next-preact');

module.exports = withPreact();
```

```javascript
const withPreact = require('@zeit/next-preact');

module.exports = withPreact();
```

Our new next.config.js ready for preact

我们全新的 `next.config.js` 文件已为 Preact 准备就绪。

Check out the very simple [@zeit/next-preact](https://github.com/zeit/next-plugins/tree/master/packages/next-preact) module or create your own!

请查看非常简洁的 [@zeit/next-preact](https://github.com/zeit/next-plugins/tree/master/packages/next-preact) 模块，或自行开发！

### Optional External Sourcemaps in Production

### 生产环境中的可选外部 Source Map

Now that webpack is used by Next.js for both client and server code, enabling source-maps in production builds is just one small adjustment to its configuration.

由于 Next.js 当前已统一使用 webpack 来构建客户端与服务端代码，因此在生产环境构建中启用 source map，仅需对其配置做一处微小调整。

In development source maps are automatically enabled, so we configure it differently for production:

在开发环境中，source map 默认自动启用；因此，我们在生产环境中采用不同的配置方式。

```javascript
module.exports = {

2  webpack(config, { dev }) {

3    if(!dev) {

4      config.devtool = 'source-map'

5    }

6    return config;

7  }

8}
```

我们仅在非开发模式下对 `devtool` 选项进行不同的配置。

## Zones

## 区域（Zones）

One of the [stated goals of Next.js](https://deck.now.sh/) from the very beginning was to bring back and preserve the simplicity of the Web.

Next.js 自诞生之初就明确提出的使命之一，便是重新找回并守护 Web 的简洁性。

Server-rendering, a simple and agnostic approach to data fetching and declarative pages based on the filesystem structure are some of the features we introduced in line with this thinking.

服务端渲染（Server Rendering）、一种简单且与框架无关的数据获取方式，以及基于文件系统结构的声明式页面——这些特性均源于这一设计理念。

A frequently overlooked aspect of web services and web sites is how _naturally composable and scalable_ they are.

Web 服务与网站一个常被忽视的重要特性，便是其**天然具备的可组合性与可扩展性**。

For example, `mydomain.com/settings` and `mydomain.com/` could be two entirely different apps, deployed independently, scaled independently, even running different versions of the same software.

例如，`mydomain.com/settings` 和 `mydomain.com/` 可以是两个完全独立的应用：各自独立部署、独立扩缩容，甚至运行着同一套软件的不同版本。

All it takes to _"glue them together"_ into a uniform experience for the end-user is [some simple configuration](https://front-git-removed-remaining-local-posts.vercel.vercel.app/docs/features/path-aliases) of the backend routing layer or load balancers that expose them to the world.

只需对向外界暴露这些应用的后端路由层或负载均衡器进行**简单配置**，即可将它们“粘合”起来，为终端用户提供统一、连贯的体验。

We are very happy to now bring the ability to **compose multiple applications built with Next.js**, connected together using normal `<Link>` components. We call this feature **Zones**.

我们非常高兴地宣布：现在可以**组合多个使用 Next.js 构建的应用程序**，并通过标准的 `<Link>` 组件将它们无缝连接。我们将这一功能命名为 **Zones（区域）**。

As an example, consider these two independent Next.js applications [deployed to Vercel](https://front-git-removed-remaining-local-posts.vercel.vercel.app/now):

以下是一个示例：这两个彼此独立的 Next.js 应用均已[部署至 Vercel](https://front-git-removed-remaining-local-posts.vercel.vercel.app/now)：

- [https://front.vercel.app](https://front.vercel.app/)

- [https://vercel.com/docs](https://{product_domain}/docs)


![Both of our pages have a seamless experience, but they belong to separate apps](images/next_js-5-universal-webpack-css-imports-plugins-and-zones-vercel/img_001.jpg)  
![我们的两个页面均提供无缝体验，但它们分别属于不同的应用](images/next_js-5-universal-webpack-css-imports-plugins-and-zones-vercel/img_001.jpg)

When we [revamped](https://vercel.com/blog/better-documentation) our [docs](https://vercel.com/blog/api-2), we wanted to make accepting a community contribution as easy as possible.

当我们[全面升级](https://vercel.com/blog/better-documentation)我们的[文档](https://vercel.com/blog/api-2)时，我们的目标是让社区贡献的采纳过程尽可能简单。

We decided to split out the documentation "mini-website" into its own repository. Additionally, whenever a pull-request is submitted and a change is proposed, we deploy it automatically, in isolation:

我们决定将文档所依赖的“微型网站”拆分为一个独立的代码仓库。此外，每当提交一个 Pull Request 并提出变更时，我们都会自动、独立地部署该变更：

![Every time a change happens inside a PR our bot automatically deploys it](images/next_js-5-universal-webpack-css-imports-plugins-and-zones-vercel/img_002.jpg)每次 Pull Request 中发生变更，我们的机器人便会自动完成部署。

What we ended up is _two zones_, that are brought together into the parent domain `https://vercel.com` using our [path alias feature](https://front-git-removed-remaining-local-posts.vercel.vercel.app/docs/features/path-aliases). It looks something like this:

最终，我们构建了**两个 Zone（区域）**，并通过我们的[path 别名功能](https://front-git-removed-remaining-local-posts.vercel.vercel.app/docs/features/path-aliases)，将它们统一聚合到父级域名 `https://vercel.com` 下。其配置大致如下所示：

```json
1{

2  "rules": [\
\
3    { "pathname": "/docs", "dest": "our-docs.now.sh" },\
\
4    { "pathname": "/api", "dest": "our-docs.now.sh" },\
\
5    { "dest": "my-main-website.now.sh" }\
\
6  ]

7}
```

```json
1{

2  "rules": [\
\
3    { "pathname": "/docs", "dest": "our-docs.now.sh" },\
\
4    { "pathname": "/api", "dest": "our-docs.now.sh" },\
\
5    { "dest": "my-main-website.now.sh" }\
\
6  ]

7}
```

These simple rules allow you to compose microservices and zones together

这些简洁的规则，使您能够灵活地将微服务与不同 Zone 组合在一起。

All that's left is to invoke a `vercel alias` command:

剩下的只需执行一条 `vercel alias` 命令即可：

```bash
1$ vercel alias -r rules.json my-domain.com
```

```bash
1$ vercel alias -r rules.json my-domain.com
```

Our mission is to make deployment as universal and open as possible. To aid with local development, we [recently open sourced micro-proxy](https://vercel.com/blog/micro-proxy), a tool that works with the same configuration format seen above.

我们的使命是让部署尽可能通用化和开放化。为支持本地开发，我们近期开源了 [micro-proxy](https://vercel.com/blog/micro-proxy) 工具，它采用与上文所示相同的配置格式。

You are similarly able to join zones together with other solutions like Nginx, HAProxy or API Gateway.

您同样可以借助 Nginx、HAProxy 或 API 网关等其他方案，将多个 Zone 连接整合在一起。

## Faster Production Build Times

## 更快的生产环境构建速度

We think developer experience and user experience go hand in hand. The more efficiently changes can be written, tested and deployed, the faster new features are added, bugs are squashed and overall user experience improves.

我们认为开发者体验与用户体验密不可分。变更编写、测试与部署越高效，新功能上线越快、缺陷修复越及时，整体用户体验也就越佳。

Consequently, we remain focused on continuously iterating on the performance profile of the most basic building blocks of the system.

因此，我们持续聚焦于系统最基础构建模块的性能优化，并不断迭代改进。

With Next.js 5.0 we had an opportunity to take a look at `next build` again, the command you run prior to deploying to production or exporting your Next.js application [as a static site](https://front-git-removed-remaining-local-posts.vercel.vercel.app/docs/deployment-types/static).

借助 Next.js 5.0，我们再次深入审视了 `next build` 命令——即您在将 Next.js 应用部署至生产环境，或将其[导出为静态站点](https://front-git-removed-remaining-local-posts.vercel.vercel.app/docs/deployment-types/static)之前所执行的构建命令。

We are happy to report that for vercel.com, a React app made up of thousands of components, we have seen pretty dramatic improvements with Next.js 5.0, to the tune of **23.6% faster production build times**:

我们很高兴地报告：对于 vercel.com（一个由数千个组件构成的 React 应用），Next.js 5.0 带来了显著的性能提升，**生产环境构建速度加快了 23.6%**：

![Our main application production build now takes 38 fewer seconds to complete](images/next_js-5-universal-webpack-css-imports-plugins-and-zones-vercel/img_003.jpg)  
![我们主应用的生产环境构建现在缩短了 38 秒](images/next_js-5-universal-webpack-css-imports-plugins-and-zones-vercel/img_003.jpg)

Our main application production build now takes 38 fewer seconds to complete  

我们主应用的生产环境构建现在缩短了 38 秒。

## Improved Caching for Dynamic Imports

## 动态导入（Dynamic Imports）缓存优化

Whenever you use dynamic `import()`, this signals to WebPack that a new code-splitting entry-point exists.

每当您使用动态 `import()` 语法时，Webpack 即会识别出一个新的代码分割入口点。

At build time, this means generating a specific bundle for the corresponding subtree of modules.

在构建时，这意味着为对应的模块子树生成一个特定的代码包。

Prior to Next.js 5.0, the dynamic bundles would receive a URL that resembles the following:

在 Next.js 5.0 之前，动态代码包所使用的 URL 形如以下所示：

```bash
1/_next/1517592683901/webpack/chun@components_hello1_1345d10fc951cd6717c5676c467579a6.js
```

Now, we have turned dynamic imports into content-addressable hashes of the contents of the subtree:

现在，我们已将动态导入转换为基于模块子树内容生成的内容可寻址哈希（content-addressable hash）：

```bash
1/_next/webpack/chun@components_hello1_1345d10fc951cd6717c5676c467579a6-b7874680a9e21fb6eb89.js
```

This means that across deployments, your users and customers won’t have to needlessly re-download the code they’ve already used.

这意味着，在不同版本的部署之间，您的用户和客户无需重复下载他们已经使用过的代码。

## Fragments

## 片段（Fragments）

Next.js build a top-level `<Document>` component that gets server-rendered with each page. [Overloading this component](https://front-git-removed-remaining-local-posts.vercel.vercel.app/) puts you in complete control over your markup, enabling many [advanced use cases](https://github.com/zeit/next.js/tree/canary/examples).

Next.js 会构建一个顶层 `<Document>` 组件，该组件随每个页面一同进行服务端渲染。[重载（overload）此组件](https://front-git-removed-remaining-local-posts.vercel.vercel.app/) 可让您完全掌控 HTML 标记结构，从而支持众多 [高级使用场景](https://github.com/zeit/next.js/tree/canary/examples)。

Part of that initial markup is the list of scripts that Next.js needs to evaluate on the client side. A custom `_document` looks like this:

该初始 HTML 标记的一部分，是 Next.js 需要在客户端执行的一组脚本。一个自定义的 `_document` 文件如下所示：

```javascript
import Document, { Head, Main, NextScript } from 'next/document'
```

```javascript
export default class extends Document {

3  render() {

4    return (

5      <html>

6        <Head/>

7        <body>

8          <Main />

9          <NextScript />

10        </body>

11      </html>
```

```javascript
export default class extends Document {

3  render() {

4    return (

5      <html>

6        <Head/>

7        <body>

8          <Main />

9          <NextScript />

10        </body>

11      </html>
```

12   )

13}
```

`Document` 允许你自定义页面的整个服务端渲染输出。

`Document` 允许你自定义页面的整个服务端渲染输出。

Until recently, we were forced to wrap our scripts inside a `<div>`.

直到最近，我们还不得不将脚本包裹在 `<div>` 中。

With Next.js 5.0, we now take advantage of the new `Fragment` support, which translates into **more lightweight pages** and complete control over the styling of the page, with no extraneous markup.

借助 Next.js 5.0，我们现在充分利用了新增的 `Fragment` 支持，从而实现 **更轻量级的页面**，并完全掌控页面样式，且不引入任何冗余的 HTML 标记。

## More Accurate Errors

## 更精准的错误提示

Node.js doesn’t support source maps, errors that happen on the server side are accompanied with a stack trace pointing to the compiled code.

Node.js 原本不支持源码映射（source maps），因此服务端发生的错误所附带的堆栈跟踪信息指向的是编译后的代码。

With Next 5 we’ve improved source map support on the server side. Errors that happen when server rendering now point to the correct function and line number.

在 Next.js 5 中，我们增强了服务端的源码映射支持。服务端渲染过程中发生的错误，现在能准确指向对应的函数名和行号。

![Errors now show the correct line, file and function name](images/next_js-5-universal-webpack-css-imports-plugins-and-zones-vercel/img_004.jpg)  
错误信息现在能准确显示对应行号、文件名和函数名。

## Conclusion

## 总结

Universal Webpack solidifies the foundations of Next.js and makes it even more future proof. By and large, there is no longer an artificial separation of what plugins or loaders are applicable to Next.js and which ones aren’t.

Universal Webpack 巩固了 Next.js 的基础，使其更具面向未来的能力。总体而言，Next.js 与插件或加载器之间的适用性界限已不再人为割裂——哪些插件或加载器适用于 Next.js、哪些不适用，如今已无明确限制。

In the spirit of _zero configuration_, we are excited to introduce [Next Plugins](https://github.com/zeit/next-plugins), the community repository for recipes that automatically expand the functionality of Next.js, without having to tweak specific knobs.

秉承“零配置”（_zero configuration_）理念，我们很高兴推出 [Next Plugins](https://github.com/zeit/next-plugins)——一个由社区共建的配方仓库，其中的插件可自动扩展 Next.js 功能，无需手动调整特定配置项（knobs）。

With this, we now support the entire spectrum of CSS solutions, compile-to-js languages like TypeScript and React alternatives like [Nerve](https://github.com/NervJS/nerv), by just bringing an additional module and being explicit about its inclusion in `next.config.js`. Simplicity without obscurity.

借助这一能力，我们现已全面支持各类 CSS 解决方案、TypeScript 等编译为 JavaScript 的语言，以及 Nerve 等 React 替代框架——只需引入额外模块，并在 `next.config.js` 中显式声明其使用即可。简洁明了，毫不晦涩。

Zones allow interconnecting Next.js apps that are not rooted in the same repository or even server(s). We consider this a very important milestone in the “team scalability” category of improvements.

Zones（区域）机制支持将彼此独立、甚至不在同一代码仓库或服务器上的 Next.js 应用相互连接。我们认为，这是“团队可扩展性”（team scalability）类改进中一项极为重要的里程碑。

Next.js thus becomes a great candidate for large applications maintained by multiple teams. They can now deploy improvements concurrently, reducing error surfaces, increasing iteration speed and even trying out different technologies in addition to our core, like the [many different approaches](https://github.com/zeit/next.js/tree/canary/examples) to state management or data fetching.

因此，Next.js 成为由多个团队协同维护的大型应用的理想选择。各团队如今可并行部署改进，从而缩小出错面、提升迭代速度，甚至可在核心框架之外尝试多种不同技术方案——例如状态管理或数据获取的 [多种实现方式](https://github.com/zeit/next.js/tree/canary/examples)。

We want to take this opportunity to thank Deep Varma and the [Trulia](https://trulia.com/) engineering team for contributing key insights, code and testing that led to the design of this feature.

借此机会，我们要特别感谢 Deep Varma 及 [Trulia](https://trulia.com/) 工程团队，他们贡献了关键洞见、代码和测试工作，直接推动了本特性的设计与实现。

As always, this release wouldn't have been possible without the many open-source contributors and [our wonderful community](https://front-git-removed-remaining-local-posts.vercel.vercel.app/chat).

一如既往，若非众多开源贡献者及 [我们卓越的社区](https://front-git-removed-remaining-local-posts.vercel.vercel.app/chat)，本次发布将无从实现。