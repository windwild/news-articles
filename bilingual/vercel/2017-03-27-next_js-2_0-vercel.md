---
title: "Next.js 2.0 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/next2"
date: "2017-03-27"
scraped_at: "2026-03-02T10:08:08.364397474+00:00"
language: "en-zh"
translated: true
description: "Next.js 2.0 comes packed with performance improvements and extensibility features"
---

Mar 27, 2017

2017年3月27日

More than **3.1 million developers** read our [announcement post](https://vercel.com/blog/next) of [Next.js](https://github.com/zeit/next.js).  
超过 **310 万名开发者** 阅读了我们关于 [Next.js](https://github.com/zeit/next.js) 的[发布公告](https://vercel.com/blog/next)。

More than **110 contributors** have submitted patches, examples or improved our documentation.  
已有 **110 多位贡献者** 提交了补丁、示例，或改进了我们的文档。

Over **10,000 developers** have starred us on [GitHub](https://github.com/zeit/next.js).  
在 [GitHub](https://github.com/zeit/next.js) 上，已有 **超过 10,000 名开发者** 为 Next.js 点亮了 Star。

Today, we are proud to introduce **Next 2.0** to the world. What follows is a quick summary of every new feature and improvement we have made.  
今天，我们非常自豪地向全世界推出 **Next 2.0**。下文将快速概览我们新增的每一项功能与改进。

## React Made Easy and Simple

## 让 React 变得轻松而简洁

Next.js is a very slim yet powerful framework. Place React components in a `pages` directory and running `next`, and you'll get automatic code splitting, routing, hot code reloading and universal (server-side and client-side) rendering.  
Next.js 是一个极为轻量却功能强大的框架。只需将 React 组件放入 `pages` 目录并运行 `next` 命令，即可自动获得代码分割（code splitting）、路由（routing）、热重载（hot code reloading）以及通用渲染（universal rendering，即服务端与客户端均可渲染）。

The "Hello World" of Next.js, as presented in our introductory post.  
这是我们入门文章中介绍的 Next.js “Hello World” 示例。

It's **easy** because it's one command for development (`next`), and two others (`next build` and `next start`) for a production-ready app.  
它很 **轻松** —— 开发阶段仅需一条命令（`next`），上线部署则只需另外两条命令（`next build` 和 `next start`）。

It's **simple** because it composes really well. It plays well with the rest of the React and JavaScript (npm) ecosystems.  
它很 **简洁** —— 因为其设计高度可组合（composable），能与 React 生态及整个 JavaScript（npm）生态无缝协作。

It's also very **small**. Check out the [README](https://github.com/zeit/next.js): the entire framework's documentation is a 5 minute read.  
它还极其 **轻量**。请参阅 [README](https://github.com/zeit/next.js)：整个框架的全部文档，5 分钟即可通读完毕。

**NEW!** Want to learn step-by-step, by example? Check out the [Learn Next.js](https://nextjs.org/learn) tutorial!  
**全新上线！** 想通过实例循序渐进地学习？欢迎体验 [Learn Next.js](https://nextjs.org/learn) 教程！

## Programmatic API

## 编程式 API

When we launched Next.js, there was no way to do dynamic routing or load your custom server code. We did this because we believe in shipping early and often.

最初发布 Next.js 时，尚不支持动态路由，也无法加载自定义服务器代码。我们选择如此，是因为我们坚信“尽早交付、频繁迭代”。

Now, you can run `node index.js` to boot up your own custom server and take full control of the routing and rendering pipeline. This enables powerful features like [fancy URLs](https://github.com/zeit/next.js/tree/master/examples/custom-server-express) or [custom caching schemes](https://github.com/zeit/next.js/tree/master/examples/ssr-caching).

如今，你只需运行 `node index.js` 即可启动自己的自定义服务器，并完全掌控路由与渲染流程。这使得实现诸如 [炫酷的 URL 结构](https://github.com/zeit/next.js/tree/master/examples/custom-server-express) 或 [自定义缓存策略](https://github.com/zeit/next.js/tree/master/examples/ssr-caching) 等强大功能成为可能。

```javascript
const express = require('express')

const next = require('next')



const dev = process.env.NODE_ENV !== 'production'

const app = next({ dev })

const handle = app.getRequestHandler()
```

```javascript
app.prepare().then(() => {

9  const server = express()



11  server.get('/r/:subreddit', (req, res) => {

12    return app.render(req, res, '/b', {

13      ...req.query,

14      subreddit: req.params.subreddit

15    })

16  })
```

```javascript
app.prepare().then(() => {

9  const server = express()



11  server.get('/r/:subreddit', (req, res) => {

12    return app.render(req, res, '/b', {

13      ...req.query,

14      subreddit: req.params.subreddit

15    })

16  })
```

18  server.get('*', (req, res) => {

18  server.get('*', (req, res) => {

19    handle(req, res)

19    handle(req, res)

20  })

20  })

21  server.listen(3000)

21  server.listen(3000)

22})

22})

Implementing Reddit-style fancy URLs with Express and Next.js

使用 Express 和 Next.js 实现 Reddit 风格的酷炫 URL

## Bring Your Own React

## 自带 React

To start a project, you now need to bring in `next` and two extra deps: `react` and `react-dom`.

要启动一个项目，你现在需要引入 `next` 以及另外两个依赖：`react` 和 `react-dom`。

```bash
npm install --save next react react-dom
```

```bash
npm install --save next react react-dom
```

This has tremendous benefits, at the tiny cost of two extra parameters in the initial \`install\` to set up your project:

这一改动带来了巨大的优势，代价仅仅是初始 \`install\` 命令中多出两个参数来配置你的项目：

- You can pin React to the version that you know works well on your project  
- 您可以将 React 锁定在您已知与项目兼容良好的版本上  

- It makes Next.js codebase clean and pluggable  
- 它使 Next.js 的代码库更加简洁且可插拔  

- You can update React independently of us. e.g: no waiting for a Next.js release after React gets updated  
- 您可以独立于我们更新 React。例如：React 发布新版本后，无需等待 Next.js 发布配套版本  

- You can experiment with alternative implementations of the React API. We have examples for [Inferno](https://github.com/zeit/next.js/tree/master/examples/using-inferno) and [Preact](https://github.com/zeit/next.js/tree/master/examples/using-preact)!  
- 您可以尝试 React API 的其他实现方案。我们提供了 [Inferno](https://github.com/zeit/next.js/tree/master/examples/using-inferno) 和 [Preact](https://github.com/zeit/next.js/tree/master/examples/using-preact) 的示例！  

## Component CSS Support  

## 组件级 CSS 支持  

Our mission is to make Next.js as familiar as possible to developers on the Web Platform. To that end, `next/css` is now deprecated in favor of `styled-jsx`, a Babel transformation that gives us scoped (isolated) full CSS support.  
我们的使命是让 Next.js 尽可能贴近 Web 平台开发者的使用习惯。为此，`next/css` 已被弃用，取而代之的是 `styled-jsx` —— 一个 Babel 转换工具，它为我们提供作用域（隔离）化的完整 CSS 支持。  

This is what a component with CSS that's local, conflict-free, server-rendered and injected once per instance looks like:  
以下是一个具备本地化、无样式冲突、服务端渲染且每个实例仅注入一次 CSS 的组件示例：  

```javascript
export default () => (

2  <div>

3    <p>hi there</p>
```

5    <style jsx>{`

6      p {

7        color: red;

8      }

9    `}</style>

10  </div>

11)
```

`p` 元素的样式仅作用于在当前作用域内静态定义的 JSX 标签。

您可在 [`styled-jsx`](https://github.com/zeit/styled-jsx) 的 [GitHub 仓库](https://github.com/zeit/styled-jsx) 中了解有关 `styled-jsx` 的更多信息。

## Pre-fetching

## 预获取

We implemented the `prefetch` attribute for the `<Link>` component.

我们为 `<Link>` 组件实现了 `prefetch` 属性。

```javascript
export default () => (

2  <div>

3    <Link href="/next-page" prefetch>Go to the next page</Link>

4  </div>

5)
```

```javascript
export default () => (

2  <div>

3    <Link href="/next-page" prefetch>前往下一页</Link>

4  </div>

5)
```

And just like that, you get the performance of a "SPA", without the initial download and expensive bootup penalty of big bundles. Combined with server rendering, this typically means extraordinary performance with very little effort.

就这样，您即可获得单页应用（SPA）级别的性能表现，同时避免了大型代码包在初始加载和启动阶段带来的下载开销与高昂的初始化成本。再结合服务端渲染（SSR），通常只需极少的工作量，即可实现卓越的性能表现。

## Next News

## Next 新闻

We think a better "Hello World" app than TodoMVC is actually… Hacker News!

我们认为，一个比 TodoMVC 更适合作为“Hello World”示例的应用，其实是…… Hacker News！

Our implementation, Next News, is fully server-rendered, queries the data over Firebase and updates in realtime as new votes come in. Check out the demo at [next-news.vercel.app](https://next-news.vercel.app/).

我们的实现——Next News——完全采用服务端渲染，通过 Firebase 查询数据，并在收到新投票时实时更新。请访问演示站点：[next-news.vercel.app](https://next-news.vercel.app/)。

![Navigating around Next News is snappy!](images/next_js-2_0-vercel/img_001.jpg)  
![浏览 Next News 流畅迅捷！](images/next_js-2_0-vercel/img_001.jpg)  
Navigating around Next News is snappy!  
浏览 Next News 流畅迅捷！

To show off our ability to both partially or fully server render, while having the freedom to execute arbitrary codepaths on the client (upon `componentDidMount`), notice that we show a "Loading…" message when loading an item on the client, but not when we server-render. This makes us a less strict _clone_, but it's for a good cause.

为展示我们既支持部分服务端渲染、也支持完整服务端渲染的能力，同时保留在客户端（例如在 `componentDidMount` 时）自由执行任意代码路径的灵活性，请注意：当在客户端加载某条内容时，我们会显示 “Loading…” 提示；而在服务端渲染时则不显示该提示。这使得我们并非一个严格意义上的 HN 克隆版（_clone_），但这一取舍实为良策。

We also went as far as replicating the style-less HN login page. Each top-level component (page) in Next.js defines the _entirety of the document_. There's no notion of global layouts or configuration, only composition via React's component system, which gives you great flexibility.

我们甚至复刻了 Hacker News 那个无样式的登录页面。在 Next.js 中，每个**顶层组件**（即页面）都定义了**整个 HTML 文档的内容**。系统中不存在全局布局或全局配置的概念，仅通过 React 的组件系统进行**组合（composition）**，从而赋予开发者极高的灵活性。

## More Examples

## 更多示例

We're very thankful to our community for having submitted so many examples of backends (Express, HAPI, Koa…), styling systems (cxs, glamor, styled-components…), testing systems (jest), type systems (TypeScript and Flow), data fetching (Apollo) and many others.

我们由衷感谢社区成员提交了大量示例，涵盖各类后端框架（如 Express、HAPI、Koa 等）、样式方案（如 cxs、glamor、styled-components 等）、测试工具（如 Jest）、类型系统（如 TypeScript 和 Flow）、数据获取方案（如 Apollo）等等。

You can find them all [in our GitHub repository](https://github.com/vercel/next.js/tree/master/examples).

所有这些示例均可在我们的 [GitHub 仓库](https://github.com/vercel/next.js/tree/master/examples) 中找到。

## ) Scalable HMR (Hot Module Replacement)

## ) 可扩展的 HMR（热模块替换）

Out of the box, Webpack watches and recompiles your entire project upon any change. We found that HMR was therefore not scaling well as our projects grew in number of code-splitting entry points and components.

开箱即用状态下，Webpack 会在任意文件变更时监听并重新编译整个项目。我们发现，随着项目中代码分割入口点（code-splitting entry points）和组件数量的增长，HMR 的性能表现难以良好扩展。

We deployed a new lazy compilation mechanism that only subscribes to the pages that you're actually working on (i.e.: all the component trees currently rendered).

我们已部署一种全新的懒编译（lazy compilation）机制，该机制仅监听你当前正在开发的页面（即：当前已渲染的所有组件树）。

In our tests, this has made compilation 10 to 20 times faster for large projects.

在我们的测试中，这一改进使大型项目的编译速度提升了 10 到 20 倍。

## A Smaller Build

## 更小的构建体积

We've made some important improvements to how builds work:

我们对构建流程进行了若干重要优化：

- We set up Webpack common chunks to avoid shipping repeated code across components

- 我们配置了 Webpack 的 CommonsChunkPlugin（或现代 Webpack 中的 `splitChunks`），避免在不同组件间重复打包相同代码

- We use hashes to make the initial bundle files be cached permanently on clients, making page loads faster

- 我们采用内容哈希（content hashes）机制，使初始 bundle 文件可在客户端长期缓存，从而加快页面加载速度

- We added provisions to make sure an app works correctly

- 我们新增了多项保障机制，确保应用能正确运行

The best part? Every Next.js app is now smaller and more efficient.

最棒的是？如今每个 Next.js 应用都更小、更高效。

![Data for a basic site with the Next.js and React bundled](images/next_js-2_0-vercel/img_002.jpg)  
![Next.js 与 React 打包后的基础站点数据](images/next_js-2_0-vercel/img_002.jpg)  
Data for a basic site with the Next.js and React bundled  
Next.js 与 React 打包后的基础站点数据

We are working on making Next.js much smaller and we have identified many opportunities for optimization already.

我们正致力于大幅缩减 Next.js 的体积，目前已识别出大量可优化的环节。

The React team is also working on size optimizations for React Fiber, which we will begin testing soon.

React 团队也在推进 React Fiber 的体积优化工作，我们很快将启动相关测试。

## Fully Extensible

## 完全可扩展

Many of the examples above introduce new features to the code or the build process. This is possible because Next.js gives you complete control over Babel's and Webpack's configuration.

上述许多示例向代码或构建流程中引入了新功能。之所以能够实现这一点，是因为 Next.js 赋予您对 Babel 和 Webpack 配置的完全控制权。

To extend Babel, we let you apply Next.js' settings as a preset.

要扩展 Babel，我们允许您将 Next.js 的配置作为 preset（预设）来应用。

```json
1{

2  "name": "my-next-app",

3  […]

4  "babel": {

5    "presets": ["next/babel"],

6    "plugins": [

7      ["transform-define", "./env-config.js"]

8    ]

9  }
```

11}
```

`babel-plugin-transform-define` will let you to replace any JS expression mapped in `env-config.js` at compile time

`babel-plugin-transform-define` 可让你在编译时，将 `env-config.js` 中映射的任意 JavaScript 表达式进行替换。

To extend webpack or tweak other settings, you can define a `next.config.js` file. Check out the [README](https://github.com/zeit/next.js#custom-configuration) for the complete documentation.

如需扩展 webpack 配置或调整其他设置，你可以创建一个 `next.config.js` 文件。完整文档请参阅 [README](https://github.com/zeit/next.js#custom-configuration)。

## Featured at ReactConf

## 亮相 ReactConf

Our CEO [Guillermo Rauch](https://twitter.com/rauchg) presented Next.js at ReactConf in Santa Clara a few weeks ago. Check it out!

数周前，我们的首席执行官 [Guillermo Rauch](https://twitter.com/rauchg) 在加州圣克拉拉举办的 ReactConf 上介绍了 Next.js，欢迎观看！

Next.js: Universal React Made Easy and Simple - React Conf 2017

Next.js：让通用 React 开发变得轻松而简单 —— React Conf 2017

## The Road to 3.0

## 迈向 3.0 版本之路

We attribute our success with this release to having released early, iterated frequently and listened to our community. But something extremely important as well was making our roadmap and priorities **clear and public**.

本次版本的成功，得益于我们早期发布、高频迭代，并持续倾听社区反馈。但同样至关重要的一点是：我们将产品路线图与优先事项 **清晰地、公开地** 呈现给所有人。

Here are some of the goals for the coming releases on our way to 3.0:

以下是我们迈向 3.0 版本过程中，后续各次发布所涵盖的部分目标：

### Improved HMR

### 改进热模块替换（HMR）

We are still working on a few improvements to hot module replacement. Some errors don't have accurate locations and there are a few issues with recovering from errors in certain scenarios.

我们仍在对热模块替换（Hot Module Replacement, HMR）进行若干改进。部分错误的定位尚不精确，且在某些场景下从错误中恢复时仍存在一些问题。

### Faster Dev Compilation

### 更快的开发编译速度

We are investigating ways to continue to optimize the development experience. Since both Node.js and modern browsers that developers use iterate so quickly, we can skip large portions of the compilation step for really fast reloads.

我们正在探索持续优化开发体验的方法。由于开发者所使用的 Node.js 和现代浏览器迭代速度极快，因此我们可跳过编译过程中的大量步骤，从而实现极快的页面重载。

### Seamless Support for Lazy `import()`

### 对懒加载 `import()` 的无缝支持

This will allow for server-rendered pages that expose different JS components according to the data they used, for example. In addition, once the component mounts on the client, you can load any component you want, lazily.

例如，这将支持服务端渲染（SSR）页面根据其使用的数据动态暴露不同的 JavaScript 组件。此外，当组件在客户端挂载后，你即可按需懒加载任意组件。

_Note:_ this already partially works, but we will continue to refine it an document it.

_注意：_ 此功能目前已部分可用，但我们仍将持续完善并完善相关文档。

### React Fiber

### React Fiber

We are looking forward to testing and ensuring Next.js works perfectly with the upcoming React engine: Fiber. This will potentially introduce new opportunities, like the ability to _stream HTML from the server_ as it is generated.

我们正期待对即将发布的 React 新引擎——Fiber 进行测试，并确保 Next.js 与其完美兼容。这或将带来一系列新能力，例如在服务端生成 HTML 的同时，以流式（streaming）方式将其传输至客户端。

### Static Exports

### 静态导出

You should be able to _server-render to files_ via a `next export` command. In other words, you'll be able to statically export your application to HTML files.

你将可通过 `next export` 命令实现“服务端渲染至文件”。换言之，你可以将整个应用静态导出为 HTML 文件。

## Ready for Production

## 准备就绪，可用于生产环境

Aside from this very website, we are very happy many others in the industry have adopted Next.js. Here are some that have [let us know](https://github.com/zeit/next.js/issues/1458).

除了本项目官网外，我们非常高兴地看到业界众多其他团队也已采用 Next.js。以下是一些已主动[告知我们](https://github.com/zeit/next.js/issues/1458)的团队或产品：

- [NPM](https://www.npmjs.com/search)

- [Scale](https://www.scale.com/)

- [Open Collective](https://opencollective.com/)

- [Tutor Bro](https://tutorbro.com/)

- [Upsum News](https://upsum.news/)

- [Skys Limo](https://skyslimo.com/)

- [Project R](https://project-r.construction/)

If you have shipped Next.js to production or are planning to, please let us know. We are always hanging out on the `#next` channel in our Public Slack community.

如果您已将 Next.js 部署至生产环境，或正计划部署，请务必告知我们！我们始终活跃在公共 Slack 社区的 `#next` 频道中。

We are bringing together the Next.js community at our one-day conference ZEIT Day on April 29th in San Francisco. It's a unique opportunity to meet other users and learn more about it from its creators!

我们将于 4 月 29 日在旧金山举办为期一天的会议 ZEIT Day，汇聚 Next.js 社区。这是一次难得的机会，让您结识其他用户，并直接向 Next.js 的创作者深入了解该框架！