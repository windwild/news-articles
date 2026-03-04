---
title: "Next.js - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/next"
date: "2016-10-25"
scraped_at: "2026-03-02T10:08:03.294966848+00:00"
language: "en-zh"
translated: true
description: "We're very proud to open-source Next.js, a small framework for server-rendered universal JavaScript webapps."
---
&#123;% raw %}

Oct 25, 2016

2016 年 10 月 25 日

We're very proud to open-source [Next.js](https://github.com/vercel/next.js), a small framework for server-rendered universal JavaScript webapps, built on top of React, Webpack and Babel, which powers this very site!

我们非常自豪地将 [Next.js](https://github.com/vercel/next.js) 开源——这是一个轻量级框架，用于构建服务端渲染的通用 JavaScript 网页应用，基于 React、Webpack 和 Babel 构建，并驱动着本项目官网！

The "Hello World" of Next.js

Next.js 的“Hello World”

To start using it, run inside a new directory with a `package.json`:

要开始使用 Next.js，请在包含 `package.json` 的新目录中执行以下命令：

```bash
1$ npm install next --save

2$ mkdir pages
```

```bash
1$ npm install next --save

2$ mkdir pages
```

Populate `pages/index.js`:

请创建并填充 `pages/index.js` 文件：

```javascript
import React from 'react'

export default () => <div>Hello world!</div>
```

```javascript
import React from 'react'

export default () => <div>Hello world!</div>
```

Add a script to the `package.json` like this:

在 `package.json` 中添加如下脚本：

```json
1{

2  "scripts": {

3    "dev": "next"

4  }

5}
```

```json
1{

2  "脚本": {

3    "dev": "next"

4  }

5}
```

and run:

并运行：

```bash
1$ npm run dev
```

```bash
1$ npm run dev
```

This blog post will go into the philosophy and design decisions of the project.

本文将深入探讨该项目的设计理念与关键设计决策。

To learn how to use Next.js instead, please refer to the [README](https://github.com/vercel/next.js), where you can learn the entirety of the tool's capabilities in just a few minutes.

如需了解如何使用 Next.js，请参阅其 [README](https://github.com/vercel/next.js) 文档——仅需几分钟，您即可全面掌握该工具的所有功能。

First we'll dive into the [background](https://vercel.com/blog/next#background) of the project and then describe 6 basic principles:

首先，我们将深入介绍该项目的 [背景](https://vercel.com/blog/next#background)，随后阐述六大基本设计原则：

1. [Zero setup. Use the filesystem as an API](https://vercel.com/blog/next#zero-setup.-use-the-filesystem-as-an-api)

1. [零配置：将文件系统用作 API](https://vercel.com/blog/next#zero-setup.-use-the-filesystem-as-an-api)

2. [Only JavaScript. Everything is a function](https://vercel.com/blog/next#only-javascript.-everything-is-a-function)

2. [仅使用 JavaScript：一切皆函数](https://vercel.com/blog/next#only-javascript.-everything-is-a-function)

3. [Automatic server rendering and code splitting](https://vercel.com/blog/next#automatic-server-rendering-and-code-splitting)

3. [自动服务端渲染与代码分割](https://vercel.com/blog/next#automatic-server-rendering-and-code-splitting)

4. [Data fetching is up to the developer](https://vercel.com/blog/next#data-fetching-is-up-to-the-developer)

4. [数据获取由开发者自主决定](https://vercel.com/blog/next#data-fetching-is-up-to-the-developer)

5. [Anticipation is the key to performance](https://vercel.com/blog/next#anticipation-is-the-key-to-performance)

5. [预判是性能优化的关键](https://vercel.com/blog/next#anticipation-is-the-key-to-performance)

6. [Simple deployment](https://vercel.com/blog/next#simple-deployment)

6. [简易部署](https://vercel.com/blog/next#simple-deployment)


## Background

## 背景

For many years now, we have been pursuing a vision of **universal JavaScript applications**.

多年来，我们一直致力于实现 **通用 JavaScript 应用** 的愿景。

Node.js led the way, by enabling code sharing between client and server, broadening the contribution surface for many developers around the world.

Node.js 率先开辟了道路——它实现了客户端与服务端之间的代码共享，极大拓展了全球众多开发者的参与空间。

Many attempts were made to make it practical to develop apps and websites on Node. Many template languages and frameworks came along... but the technical divide between frontend and backend remained.

人们曾多次尝试让基于 Node 的应用与网站开发变得切实可行；大量模板语言和框架相继涌现……但前端与后端之间的技术鸿沟依然存在。

If you for example picked Express and Jade, some HTML would be rendered by the server and then a _different codebase_ (powered by jQuery or similar libraries) would take over.

例如，如果你选择了 Express 和 Jade，部分 HTML 将由服务器渲染，随后一个**不同的代码库**（基于 jQuery 或类似库）将接管后续交互。

That situation was really no better than, say, PHP's. In many ways, PHP was actually more suited for the "server rendering of HTML" job. Prior to async/await, it was difficult to query data services in JS. Catching and limiting errors to the scope of the request/response was also notoriously difficult.

这种状况实际上并不比 PHP 好多少；在许多方面，PHP 反而更胜任“服务器端 HTML 渲染”这项任务。在 `async/await` 出现之前，使用 JavaScript 查询数据服务十分困难；而将错误捕获并限制在单个请求/响应作用域内，也一直以难以实现而著称。

Since then, however, notable conceptual changes have allowed us to bridge this gap. The most important of which is the introduction of the pure **render function** that returns the representation of the UI based on the available data at that point in time.

然而，自那以后，若干重要的概念性变革使我们得以弥合这一鸿沟。其中最关键的一项，便是引入了纯粹的 **渲染函数（render function）**——它根据当前时刻可用的数据，返回用户界面的对应表现形式。

This model (popularized by React) is of significant importance, but that alone is not necessarily different from how most template systems work. The other critical concept is the **component lifecycle**.

这一模型（由 React 推广普及）具有重大意义，但单凭这一点，并不一定与大多数模板系统的工作方式有本质区别。另一个关键概念是 **组件生命周期（component lifecycle）**。

Lifecycle hooks allow us to handle the _continuation_ of some rendering that originated on the server. You can start with a static representation of data, subscribe to realtime updates from a server, and change it over time, for example. Or perhaps it just remains static.

生命周期钩子（lifecycle hooks）使我们能够处理那些**起始于服务器、却需延续至客户端**的渲染过程。例如，你可以从数据的静态表示开始，再订阅来自服务器的实时更新，并随时间推移动态更新该表示；当然，它也可能始终保持静态不变。

**Next.js** is our take on how to bring this vision forward.

**Next.js** 正是我们为推进这一愿景所提出的解决方案。

## Zero setup. Use the filesystem as an API

## 零配置：以文件系统作为 API

Tools make certain assumptions about your projects' structure within the filesystem.

各类工具会对你的项目在文件系统中的结构做出某些预设。

For example, we generally start a Node.js project by creating a new directory, placing a `package.json` inside, then installing modules into `./node_modules`.

例如，我们通常通过新建一个目录、在其中放置一个 `package.json` 文件，再将模块安装到 `./node_modules` 目录下，来启动一个 Node.js 项目。

Next.js extends that structure by introducing a `pages` sub-directory where your top-level components live.

Next.js 在此基础上进一步扩展了该结构，引入了一个 `pages` 子目录，用于存放你的顶层组件。

For example, you can populate `pages/index.js` which maps to the route `/` with:

例如，您可以通过以下代码填充映射到路由 `/` 的 `pages/index.js` 文件：

```javascript
import React from 'react'

export default () => <marquee>Hello world</marquee>
```

```javascript
import React from 'react'

export default () => <marquee>Hello world</marquee>
```

and then `pages/about.js` which maps to `/about` with:

然后，通过以下代码填充映射到 `/about` 的 `pages/about.js` 文件：

```javascript
import React from 'react'

export default () => <h1>About us</h1>
```

```javascript
import React from 'react'

export default () => <h1>About us</h1>
```

We believe this is a great default to get started with and allows for very quick exploration of a project. When more advanced routing is required, we'll allow developers to intercept the request and take control \[ [#25](https://github.com/zeit/next.js/issues/25)\].

我们认为这是一个极佳的默认起点，可帮助开发者快速上手并高效探索项目。当需要更高级的路由功能时，我们将允许开发者拦截请求并自主接管控制权 \[ [#25](https://github.com/zeit/next.js/issues/25)\]。

All that's needed to start working on the project is to run:

要开始开发该项目，只需运行以下命令：

```bash
1$ npm run dev
```

```bash
1$ npm run dev
```

No configuration unless it's needed. Automatic hot-code reloading, error reporting, source maps, transpilation for older browsers.

无需额外配置——除非确有需要。系统自动支持热代码重载（hot-code reloading）、错误报告、源码映射（source maps）以及针对旧版浏览器的代码转译（transpilation）。

## Only JavaScript. Everything is a function

## 仅使用 JavaScript：万物皆函数

Every route within Next.js is simply a ES6 module that exports a function or class that extends from `React.Component`.

Next.js 中的每个路由都只是一个 ES6 模块，该模块导出一个函数或一个继承自 `React.Component` 的类。

The advantages of this approach over similar models is that your entire system remains highly composable and testable. For example, a component can be rendered directly, or be imported and rendered by another top-level component.

相较于其他类似模型，这种设计的优势在于：整个系统始终保持高度可组合性与可测试性。例如，某个组件既可直接渲染，也可被导入并在另一个顶层组件中渲染。

Components can also introduce changes to the `<head>` of the page:

组件还可对页面的 `<head>` 部分进行修改：

```javascript
import React from 'react'

import Head from 'next/head'



export default () => (

5<div>

6  <Head>

7    <meta name="viewport" content="width=device-width, initial-scale=1" />

7    <meta name="viewport" content="width=device-width, initial-scale=1" />

8  </Head>

8  </Head>

9  <h1>Hi. I'm mobile-ready!</h1>

9  <h1>你好！我已适配移动设备！</h1>

10</div>

10</div>

11)
11)

```

Furthermore, no wrappers or transformations are needed to make this system fully testable. Your test suite can simply import and shallow-render your routes.

```

此外，无需任何包装器（wrapper）或转换操作，即可使该系统完全可测试。您的测试套件只需直接导入并进行浅层渲染（shallow-render）即可测试路由组件。

We've also made the decision to embrace CSS-in-JS. We use the excellent [glamor](https://github.com/threepointone/glamor) library which gives us the full unconstrained power of CSS without the need for CSS parsing and compilation:

我们还决定采用 CSS-in-JS 方案。我们使用优秀的 [glamor](https://github.com/threepointone/glamor) 库，它赋予我们 CSS 的全部、无约束的表达能力，且无需进行 CSS 解析与编译：

```javascript
import React from 'react'

import css from 'next/css'

```

```javascript
export default () => <p className={style}>Hi there!</p>
```

```javascript
export default () => <p className={style}>你好！</p>
```

```javascript
const style = css({

7  color: 'red',

8  ':hover': {

9    color: 'blue'

10  },

11  '@media (max-width: 500px)': {

12    color: 'rebeccapurple'

13  }
```

```javascript
const style = css({

7  color: '红色',

8  ':hover': {

9    color: '蓝色'

10  },

11  '@media (max-width: 500px)': {

12    color: '丽贝卡紫'

13  }
```

14})
```

We think this model offers superior performance, composability and integration with the server-rendering pipeline.

我们认为该模型在性能、可组合性以及与服务端渲染管线的集成方面均表现出色。

## Automatic server rendering and code splitting

## 自动服务端渲染与代码分割

Two tasks have so far been simultaneously very difficult and highly desirable:

目前，有两项任务既极具挑战性，又广受期待：

- Server rendering  
- Splitting your app's build into smaller bundles  

- 服务端渲染  
- 将应用构建产物拆分为更小的代码包  

With Next.js, every component inside `pages/` gets server-rendered automatically and their scripts inlined.

借助 Next.js，`pages/` 目录下的每个组件都会自动进行服务端渲染，且其脚本会被内联（inlined）。

When a component is loaded dynamically through `<Link prefetch />` or [the router](https://nextjs.org/docs/routing/introduction), we fetch a JSON based representation of the page which likewise contains its scripts.

当组件通过 `<Link prefetch />` 或 [路由系统](https://nextjs.org/docs/routing/introduction) 动态加载时，我们会获取该页面基于 JSON 的表示形式——其中同样包含其所需脚本。

This means that a certain page could have an extensive list of imports:

这意味着某个页面可能包含大量导入语句：

```javascript
import React from 'react'

```javascript
import d3 from 'd3'

import jQuery from 'jquery'
```

… that don't affect the performance of the rest of the pages.

……这些改动不会影响其余页面的性能。

This detail is particularly powerful for large teams of people that collaborate on components with very different technical and business requirements. The performance penalties incurred by a team or individual won't affect the rest of the organization's.

这一细节对于大型团队尤为有力——团队成员共同开发组件，而这些组件在技术实现和业务需求上往往差异巨大。某个团队或个人所引入的性能开销，不会波及组织内其他部分。

## Data fetching is up to the developer

## 数据获取由开发者自行决定

Server-rendering of static JSX is an important achievement, but real-world applications deal with dynamic data coming from different API calls and network requests.

服务端渲染静态 JSX 是一项重要成就，但实际应用中，数据往往是动态的，来源于各类 API 调用和网络请求。

Next.js makes a very important extension to the React's Component contract: `getInitialProps`.

Next.js 对 React 的组件契约（Component contract）做出了一项极为重要的扩展：`getInitialProps`。

A page that fetches some data would look as follows:

一个需要获取数据的页面如下所示：

```javascript
export default class extends React.Component {

5  static async getInitialProps () {

6    const res = await fetch('https://api.company.com/user/123')

7    const data = await res.json()

8    return { username: data.profile.username }

9  }

10}
```

```javascript
export default class extends React.Component {

5  static async getInitialProps () {

6    const res = await fetch('https://api.company.com/user/123')

7    const data = await res.json()

8    return { username: data.profile.username }

9  }

10}
```

Our stance of what features we transpile (like async/await) can be summed up as: we target V8's capabilities. Since our goal is code-sharing between server and client, this gives us great performance when executing the code on Node and developing on Chrome or Brave, for example.

我们对哪些特性需要转译（例如 `async/await`）所持的立场可概括为：以 V8 引擎的能力为目标。由于我们的目标是在服务端与客户端之间共享代码，因此当代码在 Node.js 上运行，或在 Chrome、Brave 等浏览器中进行开发时，这种策略能带来出色的性能表现。

As you can see, the contract is very simple and unopinionated: `getInitialProps` must return a `Promise` that resolves to a `JavaScript` object, which then populates the component's `props`.

如您所见，该约定非常简洁且不具强制性：`getInitialProps` 必须返回一个 `Promise`，该 `Promise` 将解析为一个 `JavaScript` 对象，随后该对象将用于填充组件的 `props`。

This makes Next.js play well with REST APIs, GraphQL, and even global-state management libraries Redux, an example of which you can find [on our GitHub](https://github.com/vercel/next.js/tree/canary/examples/with-redux).

这使得 Next.js 能够很好地与 REST API、GraphQL，甚至全局状态管理库 Redux 协同工作；您可以在我们的 GitHub 仓库中找到一个相关示例：[GitHub 示例链接](https://github.com/vercel/next.js/tree/canary/examples/with-redux)。

The same method allows for different data to be loaded depending on whether the component is server-rendered or dynamically rendered through client-side routing:

同样的方法可根据组件是服务端渲染还是通过客户端路由动态渲染，来加载不同的数据：

```javascript
static async getInitialProps ({ res }) {

2  return res

3    ? { userAgent: res.headers['user-agent'] }

4    : { userAgent: navigator.userAgent }

5}
```

## Anticipation is the key to performance

## 预判是性能的关键

We think that the pendulum of "fully server-rendered" swung abruptly to the extreme of "single page app" / "nothing server-rendered" thanks to the ability to [give the user immediate feedback](http://rauchg.com/2014/7-principles-of-rich-web-applications/#act-immediately-on-user-input) despite the network, provided the entire app has been loaded.

我们认为，“完全服务端渲染”的钟摆曾因网络延迟问题而骤然摆向另一极端——即“单页应用”（SPA）/“完全不进行服务端渲染”。这一转变的驱动力在于：只要整个应用已加载完成，即便存在网络延迟，也能借助技术手段 [即时响应用户操作](http://rauchg.com/2014/7-principles-of-rich-web-applications/#act-immediately-on-user-input)，从而为用户提供即时反馈。

For [www.vercel.com](https://vercel.com/) we've implemented a technique on top of Next.js that brings us the best of both worlds: every single `<Link prefetch />` tag pre-fetches the component's JSON representation on the background, via a `ServiceWorker`.

在 [www.vercel.com](https://vercel.com/) 网站中，我们在 Next.js 基础上实现了一种技术，融合了服务端渲染与客户端渲染二者的优势：每一个 `<Link prefetch />` 标签都会借助 `ServiceWorker` 在后台预先获取对应组件的 JSON 表示形式。

If you navigate around, odds are that by the time you follow a link or trigger a route transition, the component has already been fetched.

如果你在应用中四处导航，很可能在你点击链接或触发路由跳转时，相关组件早已被预取完成。

Furthermore, since the data is fetched by a dedicated method (`getInitialProps`), we can pre-fetch aggressively without triggering unnecessary server load or data fetching. This is a substantial benefit over naive web 1.0 preload strategies.

此外，由于数据是通过专用方法（`getInitialProps`）获取的，我们可以激进地进行预取，而不会引发不必要的服务器负载或重复的数据请求。这相比原始的 Web 1.0 预加载策略是一项显著优势。

## Simple deployment

## 简单部署

We created Next.js because we believe universal isomorphic applications are a big part of the future of the web.

我们创建 Next.js，是因为我们相信通用同构应用将是未来 Web 的重要组成部分。

Ahead-of-time bundling and compilation (anticipation) is a critical part of effective and performant deployment.

提前进行打包与编译（即“预判式构建”）是实现高效、高性能部署的关键环节。

All it takes to deploy a Next.js app is to run `next build` followed by `next start`.

部署一个 Next.js 应用只需运行 `next build`，然后执行 `next start`。

When using , your `package.json` looks like this:

使用时，你的 `package.json` 文件如下所示：

```json
1{

2  "name": "my-app",

3  "dependencies": {

4    "next": "*"

5  },

6  "scripts": {

7    "dev": "next",

8    "build": "next build",

9    "start": "next start"

10  }

11}
```

然后，你只需运行 `vercel` 命令即可完成部署。

然后，你只需运行 `vercel` 命令即可完成部署。

最后，这是我们针对这一非常有趣的问题所做出的贡献。我们认为它在灵活性与智能默认配置之间取得了良好的平衡；但毫无疑问，它并非适用于所有问题的万能解决方案。

最后，这是我们针对这一非常有趣的问题所做出的贡献。我们认为它在灵活性与智能默认配置之间取得了良好的平衡；但毫无疑问，它并非适用于所有问题的万能解决方案。

We look forward to, in the coming weeks, discussing and featuring other great approaches to accomplish this mission, like [Vue.JS](https://github.com/vuejs/vue-hackernews-2.0), [Gatsby](https://github.com/gatsbyjs/gatsby), [Ember+Fastboot](https://ember-fastboot.com/) and many others.

在接下来的几周里，我们期待探讨并重点介绍其他优秀的方案，以共同完成这一使命，例如 [Vue.JS](https://github.com/vuejs/vue-hackernews-2.0)、[Gatsby](https://github.com/gatsbyjs/gatsby)、[Ember+Fastboot](https://ember-fastboot.com/) 以及众多其他方案。

If you're interested in contributing, please check out our issues and explore and debate 🚲 [future directions](https://github.com/zeit/next.js/blob/1.2.3/README.md#future-directions).

如果您有兴趣参与贡献，请查阅我们的 Issues，并探索与讨论 🚲 [未来发展方向](https://github.com/zeit/next.js/blob/1.2.3/README.md#future-directions)。
&#123;% endraw %}
