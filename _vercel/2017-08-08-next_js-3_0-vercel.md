---
render_with_liquid: false
title: "Next.js 3.0 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/next3"
date: "2017-08-08"
scraped_at: "2026-03-02T10:08:01.075346454+00:00"
language: "en-zh"
translated: true
description: "Next.js 3.0 comes with vastly improved HMR, dynamic imports, static exports and better serverless support!"
---
render_with_liquid: false
render_with_liquid: false

Aug 8, 2017

2017 年 8 月 8 日

We are very excited excited to announce the stable release of Next.js 3.0. Ever since our [beta announcement](https://vercel.com/blog/next3-preview), we have been using it to power [vercel.com](https://vercel.com/) and have received lots of feedback and contributions from our [community](https://zeit.chat/).

我们非常激动地宣布 Next.js 3.0 正式版发布！自我们在 [Beta 版公告](https://vercel.com/blog/next3-preview) 中首次公布以来，我们已使用它驱动 [vercel.com](https://vercel.com/) 的全部功能，并从我们的 [社区](https://zeit.chat/) 收到了大量反馈与贡献。

Let’s walk through what’s been improved and what’s altogether new, or fetch the latest version from [npm](https://www.npmjs.com/package/next)!

接下来，让我们一起了解本次版本中有哪些改进与全新特性；或者直接从 [npm](https://www.npmjs.com/package/next) 获取最新版本！

_New to Next.js?_ Next.js is a zero-configuration, single-command toolchain for React apps, with built-in server-rendering, code-splitting and more. Check out [Learn Next.js](https://learnnextjs.com/) to get started!

_初次接触 Next.js？_ Next.js 是一款开箱即用、仅需一条命令即可启动的 React 应用工具链，内置服务端渲染（SSR）、代码分割（Code Splitting）等强大功能。欢迎访问 [Learn Next.js](https://learnnextjs.com/) 开始学习！

## Static Export Support

## 静态导出支持

This was the [most request feature](https://github.com/zeit/next.js/issues/604) by the community on GitHub. And we have delivered!

这是 GitHub 上 [社区呼声最高](https://github.com/zeit/next.js/issues/604) 的功能，如今我们已如期交付！

All it takes to export your project to a directory with plain **.html** and **.css** files is to [configure your project](https://github.com/zeit/next.js#static-html-export) and run:

只需 [配置项目](https://github.com/zeit/next.js#static-html-export)，然后运行以下命令，即可将你的项目导出为一个包含纯 **.html** 和 **.css** 文件的目录：

```bash
next export
```

```bash
next export
```

The bonus? You can deploy statically to [now.sh](https://vercel.com/home) as many times as you want, for free!

额外福利？你可以免费、无限次地将静态站点部署到 [now.sh](https://vercel.com/home)！

The prolific Next.js community has already come up with some static blog generators for you to check out:

充满活力的 Next.js 社区已经开发出若干静态博客生成器，欢迎你试用体验：

- [next-blog](https://github.com/tscanlin/next-blog)

- [next-blog](https://github.com/tscanlin/next-blog)

- [next-static](https://github.com/infiniteluke/next-static)

- [next-static](https://github.com/infiniteluke/next-static)

- [nextein](https://github.com/elmasse/nextein)

- [nextein](https://github.com/elmasse/nextein)


## Dynamic Import Support

## 动态导入支持

Next.js 现已全面支持 [TC39 动态导入提案](https://github.com/tc39/proposal-dynamic-import)。

借助动态导入，我们的代码库会被拆分为一组代码块（chunks），这些代码块可在后续按需动态加载。开发者可完全自主控制代码的加载时机，例如根据用户交互行为或数据本身来决定何时加载。

使用起来非常简单：只需像下面这样，将模块作为 Promise 进行导入即可：

```javascript
const moment = import('moment')

setTimeout(function() {

3  moment.then(moment => {

4  // Do something with moment

4  // 对 moment 执行某些操作

5  })

5  })

6}, 15000)
6}, 15000)
```

```

The module will be downloaded when we starting to use it. In the above example, the `moment` module will be downloaded when the `setTimeout` callback runs (~15 secs after the page load.) This speeds up our main JavaScript bundle by loading code only when we need it.

该模块将在我们开始使用时才被下载。在上述示例中，`moment` 模块将在 `setTimeout` 回调执行时（即页面加载完成约 15 秒后）被下载。这种方式仅在需要时才加载代码，从而加快了主 JavaScript 包的加载速度。

### Dynamic React Components

### 动态 React 组件

Additionally, Next.js comes with a powerful opt-in utility called [`next/dynamic`](https://github.com/zeit/next.js#dynamic-import) which helps you to create dynamically loaded React Components easily.

此外，Next.js 提供了一个功能强大的可选工具 —— [`next/dynamic`](https://github.com/zeit/next.js#dynamic-import)，它能帮助你轻松创建动态加载的 React 组件。

Dynamic components _can_ load React code on-demand, but the most interesting feature is that if they are included in the initial rendering, server-rendering still works!

动态组件 *可以* 按需加载 React 代码，但最有趣的功能在于：即使它们被包含在初始渲染中，服务端渲染（SSR）依然能够正常工作！

Let's look at some examples!

让我们来看一些示例！

```javascript
import dynamic from 'next/dynamic'

const DynamicComponent = dynamic(import('@components/hello'))
```

```javascript
export default () => (

5  <div>

6    <Header />

7    <DynamicComponent />

8    <p>HOME PAGE is here!</p>

9  </div>

10)
```

```javascript
export default () => (

5  <div>

6    <Header />

7    <DynamicComponent />

8    <p>首页在此！</p>

9  </div>

10)
```

加载单个组件（动态方式）。

以动态方式加载单个组件。

```javascript
import dynamic from 'next/dynamic'
```

```javascript
const HelloBundle = dynamic({

4  modules: (props) => {

5    const components = {

6      Hello1: import('@components/hello1'),

7      Hello2: import('@components/hello2')

8    }

9    // you can add / remove components based on props

9    // 可根据 props 动态添加或移除组件

10    return components

10    返回 components

11  },
```

12  render: (props, { Hello1, Hello2 }) => (

12  渲染函数：(props, { Hello1, Hello2 }) => (

13    <div>

13    <div>

14      <h1>{props.title}</h1>

14      <h1>{props.title}</h1>

15      <Hello1 />

15      <Hello1 />

16      <Hello2 />

16      <Hello2 />

17    </div>

17    </div>

18  )

18  )

19})

19})



export default () => (

export default () => (

22  <HelloBundle title="Dynamic Bundle" />

22  <HelloBundle title="动态 Bundle" />

23)
```

23)
```

Loading different components based on dynamic properties!

根据动态属性加载不同的组件！

Until today, code splitting was based on routes, or the **section** of the application the user had loaded. Moving forward, you'll be able to load **code as a function of the data** the user is presented with.

在此前，代码分割（code splitting）仅基于路由（routes），或用户所加载的应用程序的**模块（section）**。而从今往后，您将能够根据用户所面对的**数据内容**来动态加载代码。

We are excited about the apps people will create with this new paradigm.

我们对开发者们将借助这一新范式所构建的应用充满期待。

## More Beautiful Errors

## 更美观的错误提示

Thanks to [Krisztian Puska](https://github.com/zeit/next.js/issues/2182), we’ve updated our error color theme to be easier on the eyes and more accessible.

感谢 [Krisztian Puska](https://github.com/zeit/next.js/issues/2182)，我们已更新错误提示的配色方案，使其更护眼、更具可访问性（accessibility）。

![The gif shows a syntax error being hot reloaded with the new¬ colors.](images/next_js-3_0-vercel/img_001.jpg)The gif shows a syntax error being hot reloaded with the new¬ colors.

![该动图展示了语法错误在启用新配色方案后进行热重载的效果。](images/next_js-3_0-vercel/img_001.jpg)该动图展示了语法错误在启用新配色方案后进行热重载的效果。

## Improved Hot Module Replacement

## 改进的热模块替换（HMR）

We have addressed a variety of scenarios that would render **HMR (** **_hot module replacement_** **)** ineffective before, in particular around error recovery.

我们已解决多种此前会导致**HMR（热模块替换，hot module replacement）** 失效的场景，尤其在错误恢复（error recovery）方面取得了显著改进。

Moving forward, when an error of any kind occurs, you will be able to make changes to your code, save and see the error change, be substituted by another error or go away altogether!

今后，当发生任何类型的错误时，您都可以修改代码、保存，并实时观察错误的变化——错误可能被另一种错误替代，也可能完全消失！

### HMR: Node.js 8.0 Support

### HMR：Node.js 8.0 支持

We have solved `ERR_INCOMPLETE_CHUNK_ENCODING` errors in the dev tools showing up when using Next.js with the new Node.js 8.x release line.

我们已修复在使用 Next.js 搭配新版 Node.js 8.x 系列时，开发工具中出现的 `ERR_INCOMPLETE_CHUNK_ENCODING` 错误。

![You won’t be seeing this one again!](images/next_js-3_0-vercel/img_002.jpg)  
您将不会再看到这个错误！

### HMR: Navigating to Errors

### HMR：导航至含错误的页面

If you navigate to a page that had any kind of error, it’ll be handled appropriately now, rendering the error message and giving you the ability to correct it in realtime.

如果您导航至一个存在任何类型错误的页面，系统现在会对其进行恰当处理：显示错误信息，并让您能够实时修正错误。

![We navigate to the index page with errors, fix them and watch¬ the page recover.](images/next_js-3_0-vercel/img_003.jpg)  
我们导航至带有错误的首页，修复错误，并实时观察页面恢复正常。

### HMR: 404 to Error to Success

### HMR：从 404 到错误再到成功

We have addressed a bug where you navigate to a missing page (correctly rendered as **404**), but you make a mistake when populating it.

我们已修复一个缺陷：当您访问一个缺失的页面（正确渲染为 **404**）后，在为其填充内容时若引入错误，系统此前无法妥善响应。

![After we create the page, we introduce an error and then¬ promptly fix it.](images/next_js-3_0-vercel/img_004.jpg)  
在创建该页面后，我们人为引入一个错误，随后立即将其修复。

### HMR: Better Bad Returns

### HMR：更优的错误返回处理

If you happen to return the wrong type, we now handle that situation smoothly.

如果你意外返回了错误的类型，我们现在能够平滑地处理该情况。

![After the right type is returned, the page recovers¬ successfully.](images/next_js-3_0-vercel/img_005.jpg)After the right type is returned, the page recovers¬ successfully.

![在返回正确的类型后，页面成功恢复。](images/next_js-3_0-vercel/img_005.jpg)在返回正确的类型后，页面成功恢复。

### HMR: Undefined Can Be a Function

### HMR：`undefined` 也可作为函数调用（错误提示更精准）

Any type of runtime error when evaluating the module is now correctly caught. Realtime debugging of `undefined is not a function` is right around the corner.

模块求值过程中发生的任何类型的运行时错误，现在均能被正确捕获。“`undefined is not a function`” 错误的实时调试功能也已近在咫尺。

![We first make a syntax error, which recovers to a runtime error,¬ which recovers to the page.](images/next_js-3_0-vercel/img_006.jpg)We first make a syntax error, which recovers to a runtime error,¬ which recovers to the page.

![我们首先引入一个语法错误，随后它恢复为运行时错误，最终恢复至页面正常状态。](images/next_js-3_0-vercel/img_006.jpg)我们首先引入一个语法错误，随后它恢复为运行时错误，最终恢复至页面正常状态。

## Faster: Serverless Ready

## 更快：原生支持无服务器架构（Serverless Ready）

Bootup time for a baseline Next.js app is now **5 times faster**, down to [about 200ms from 1000ms](https://github.com/zeit/next.js/pull/2566). Stay tuned for some exciting announcements about serverless Next.js with Now!

基准 Next.js 应用的启动时间现已**提升至原来的 5 倍**，从原先约 1000ms 缩短至约 200ms [参见 PR #2566](https://github.com/zeit/next.js/pull/2566)。敬请期待关于 Next.js 与 Now 平台深度集成的无服务器（serverless）新特性的重磅发布！

## Smaller: Optimized Core Bundles

## 更小：核心包进一步优化

We have optimized the core Next.js bundle even further and it's now [10% leaner](https://github.com/zeit/next.js/pull/2422)! Only the most crucial production code is included in your final bundles.

我们对 Next.js 的核心打包文件进行了进一步优化，体积现已**缩减 10%** [参见 PR #2422](https://github.com/zeit/next.js/pull/2422)！最终构建产物中仅包含最关键的生产环境代码。

## 4.0 and Beyond

## 4.0 及后续版本

As we have done after other major releases, we will soon be publicly sharing our roadmap for **Next.js 4.0**.

继其他重大版本发布之后，我们也将很快向公众公开 **Next.js 4.0** 的路线图。

The focus will be on an even leaner core, faster bootup time and rendering, integration with React 16 and better use of caching during development to avoid re-compilation.

其重点将放在更精简的核心、更快的启动与渲染速度、与 React 16 的集成，以及在开发过程中更高效地利用缓存以避免重复编译。

As always, we recommend you join our [Slack community](https://zeit.chat/) and [follow us on Twitter](https://twitter.com/zeithq).

一如既往，我们诚挚邀请您加入我们的 [Slack 社区](https://zeit.chat/) 并在 [Twitter 上关注我们](https://twitter.com/zeithq)。