---
title: "Next.js 6 and Nextjs.org - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/next6"
date: "2018-05-16"
scraped_at: "2026-03-02T10:08:08.287213304+00:00"
language: "en-zh"
translated: true
description: "Next.js 6 features zero-configuration static exports, App Component, Babel 7 and more"
---
{% raw %}

May 16, 2018

2018 年 5 月 16 日

This year, the [ZEIT Day](https://zeit.co/day) Keynote started by highlighting our Open Source projects including showing the metrics of Next.js. With over 25000 stars on [GitHub](https://github.com/zeit/next.js) and over 10000 websites are already powered by it, we're incredibly amazed at its growth and love seeing the increasing amount of projects depending on it.

今年的 [ZEIT Day](https://zeit.co/day) 主题演讲以介绍我们的开源项目拉开序幕，其中包括展示 Next.js 的各项指标数据。Next.js 在 [GitHub](https://github.com/zeit/next.js) 上已获得超过 25,000 颗星标，全球已有逾 10,000 个网站基于它构建——我们对其迅猛发展深感惊叹，也十分欣喜地看到越来越多的项目依赖于它。

We are proud today to introduce the production-ready **Next.js 6**, featuring:

我们非常自豪地宣布正式发布面向生产环境的 **Next.js 6**，其主要特性包括：

- Zero-configuration static exports. No need for `next.config.js` by default  
- 零配置静态导出：默认无需 `next.config.js` 文件

- `_app.js`, an extension point that enables page transitions, error boundaries and more  
- `_app.js`：一个扩展入口点，支持页面过渡动画、错误边界（error boundaries）等更多功能

- Babel 7 and Fragment syntax `<>` support  
- 支持 Babel 7 及 Fragment 语法 `<>`

- Extended integration test suites with a strong focus on security  
- 扩展了集成测试套件，并高度重视安全性

- Flow annotations in the core codebase  
- 核心代码库中添加了 Flow 类型注解

In addition to the 6.0 release, we're moving to feature Next.js on its very own homepage, [nextjs.org](https://nextjs.org/), featuring:

除发布 Next.js 6.0 版本外，我们还将为 Next.js 推出专属官网：[nextjs.org](https://nextjs.org/)，该网站包含：

- All the Next.js documentation in one place. No more lookups of the README file on GitHub  
- 所有 Next.js 文档集中呈现，无需再前往 GitHub 查阅 README 文件

- Merging [https://learnnextjs.com](https://learnnextjs.com/) into [https://nextjs.org/learn](https://nextjs.org/learn)  
- 将 [https://learnnextjs.com](https://learnnextjs.com/) 合并至 [https://nextjs.org/learn](https://nextjs.org/learn)

- A showcase of the most impressive websites built with Next.js  
- 使用 Next.js 构建的最令人印象深刻的网站精选展示

## Static React Applications  
## 静态 React 应用

Next.js focuses on the idea of **pre-rendering** as a means to achieve high performance. Pre-rendering comes in two forms:  
Next.js 以 **预渲染（pre-rendering）** 为核心理念，以此实现高性能。预渲染分为两种形式：

- **Server rendering** where each request triggers a render. As a result, the end-user doesn't have to wait for any JS to be downloaded to start consuming data  
- **服务端渲染（Server rendering）**：每次请求都会触发一次渲染。因此，终端用户无需等待任何 JavaScript 下载完成即可开始浏览内容。

- **Static rendering** where we output static files that can be served directly without any code execution on the server  
- **静态渲染（Static rendering）**：我们输出静态文件，这些文件可直接提供服务，无需在服务器端执行任何代码。

Until now, static exporting in Next.js was very powerful but not sufficiently easy to use. It required setting up [a manual route map](https://nextjs.org/docs#static-html-export) even when no custom routes were in use.  
此前，Next.js 的静态导出功能虽十分强大，但使用起来并不足够简便——即使未使用任何自定义路由，也仍需手动配置 [路由映射表（route map）](https://nextjs.org/docs#static-html-export)。

With Next.js 6, we automatically generate the route map for you based on the content of your `pages/` directory. If you're not using advanced custom routing, you won't have to make any modifications to `next.config.js`. Just run:  
在 Next.js 6 中，我们将根据您 `pages/` 目录下的内容自动为您生成路由映射表。若您未使用高级自定义路由，则无需对 `next.config.js` 做任何修改。只需运行：

```bash
next build

next export
```

For an example, [check out this website](https://out-khozebgbnl.now.sh/) deployed statically to Vercel. The website’s [source code](https://github.com/zeit/next.js/tree/canary/examples/basic-css) is available too.

例如，可访问 [此网站](https://out-khozebgbnl.now.sh/) 查看一个静态部署至 Vercel 的示例。该网站的 [源代码](https://github.com/zeit/next.js/tree/canary/examples/basic-css) 同样公开可用。

## App Component

## App 组件

Next.js offers an extensibility point called [`_document.js`](https://github.com/zeit/next.js#custom-document). If defined, it lets you override the very top-level document of your application, which renders the `<html>` element.

Next.js 提供了一个可扩展机制，称为 [`_document.js`](https://github.com/zeit/next.js#custom-document)。若定义了该文件，即可覆盖应用最顶层的文档结构，即渲染 `<html>` 元素的部分。

`_document.js` allows for powerful extensibility, but it has some serious limitations. For example, React is not able to render `<html>` or `<body>` directly on the client side, so `_document.js` is mostly limited to the initial pre-rendering phase.

`_document.js` 提供了强大的可扩展能力，但也存在一些严重限制。例如，React 无法在客户端直接渲染 `<html>` 或 `<body>` 元素，因此 `_document.js` 主要仅限于初始预渲染阶段使用。

To enable some other powerful use cases, we're introducing `_app.js`, which is the top-level component that wraps the outside of each page.

为支持其他一些强大用例，我们引入了 `_app.js` —— 这是一个顶层组件，用于包裹每个页面的外部结构。

![Some differences between `_document.js` and `_app.js`.](images/next_js-6-and-nextjs_org-vercel/img_001.jpg)  
![`_document.js` 与 `_app.js` 的一些区别。](images/next_js-6-and-nextjs_org-vercel/img_001.jpg)  
Some differences between `_document.js` and `_app.js`.

`_document.js` 与 `_app.js` 的一些区别。

Let's look at some use cases that defining `_app.js` enables.

下面我们来看一些通过定义 `_app.js` 所能实现的典型用例。

### Page Transitions

### 页面过渡效果

![](images/next_js-6-and-nextjs_org-vercel/img_002.jpg)  
![](images/next_js-6-and-nextjs_org-vercel/img_002.jpg)

Page transitions example: [`page-transitions-app-next.now.sh`](https://page-transitions-app-next.now.sh/) by [Xavier Cazalot](https://github.com/xavxyz) ( [Source](https://github.com/xavczen/nextjs-page-transitions))  

页面过渡效果示例：[`page-transitions-app-next.now.sh`](https://page-transitions-app-next.now.sh/)，作者 [Xavier Cazalot](https://github.com/xavxyz)（[源代码](https://github.com/xavczen/nextjs-page-transitions)）

In this example, each page can be independently accessed, pre-rendered and lazy-loaded. However, when we transition on the client side, smooth animations are possible.

在此示例中，每个页面均可独立访问、预渲染及按需懒加载。然而，在客户端进行页面切换时，即可实现流畅的动画效果。

### Better Apollo and Redux Integration

### 更完善的 Apollo 与 Redux 集成

We already had [numerous examples](https://github.com/zeit/next.js/tree/canary/examples) of integrating data and state management frameworks like Apollo and Redux.

我们此前已提供了大量将 Apollo 和 Redux 等数据与状态管理框架集成的[示例](https://github.com/zeit/next.js/tree/canary/examples)。

With `_app.js`, however, it's now even simpler to include these. Here are a few examples:

但借助 `_app.js`，现在集成这些框架变得更加简单。以下是一些示例：

- [Apollo](https://apollo-app-next.now.sh/) ( [source code](https://github.com/zeit/next.js/tree/canary/examples/with-apollo))

- [Apollo](https://apollo-app-next.now.sh/)（[源代码](https://github.com/zeit/next.js/tree/canary/examples/with-apollo)）

- [Redux](https://redux-app-next.now.sh/) ( [source code](https://github.com/zeit/next.js/tree/canary/examples/with-redux))

- [Redux](https://redux-app-next.now.sh/)（[源代码](https://github.com/zeit/next.js/tree/canary/examples/with-redux)）

### Better Error Handling

### 更完善的错误处理

React offers a component method called `componentDidCatch` which enables you to capture and handle exceptions that bubble up from nested components on the client side.

React 提供了一个名为 `componentDidCatch` 的组件方法，使你能够在客户端捕获并处理从嵌套子组件向上冒泡的异常。

In many cases, due to the unexpected nature of these exceptions, you might want to handle all of them equally at the top level.

在许多情况下，由于这些异常具有不可预见性，你可能希望在应用顶层统一处理所有异常。

`_app.js` is, therefore, a good place to define that `componentDidCatch` logic. Here's an [example](https://error-app-next.now.sh/) of error handling boundaries in action ( [source code](https://github.com/zeit/next.js/tree/canary/examples/with-componentdidcatch))

因此，`_app.js` 是定义该 `componentDidCatch` 逻辑的理想位置。此处提供一个正在运行的[错误处理边界示例](https://error-app-next.now.sh/)（[源代码](https://github.com/zeit/next.js/tree/canary/examples/with-componentdidcatch)）

## Babel 7

## Babel 7

We have upgraded Babel to its latest version: 7. With it comes some great new features and improvements.

我们已将 Babel 升级至最新版本：7。此次升级带来了诸多出色的新特性和改进。

### JSX Fragments

### JSX 片段

React 16.2 引入了 `Fragment` API，它允许你表达一组元素，而无需将它们包裹在诸如 `<div>` 这样的任意 HTML 元素中：

React 16.2 引入了 `Fragment` API，它允许你表达一组元素，而无需将它们包裹在诸如 `<div>` 这样的任意 HTML 元素中：

```javascript
render() {

2  return <React.Fragment>

3    <A />,

4    <B />

5  </React.Fragment>

6}
```

Writing this can be tedious, with Next.js 6 you can use the new JSX fragment syntax to facilitate creating fragments:

编写此类代码可能十分繁琐；在 Next.js 6 中，您可以使用全新的 JSX 片段（Fragment）语法，以更便捷地创建片段：

```javascript
render() {

2  return <>

3    <A />,

4    <B />

5  </>

6}
```

### Nested .babelrc

### 嵌套的 `.babelrc`

If you have a directory nested in your Next.js applications that require a different Babel configuration, it's now possible to include a scoped `.babelrc` file specifically in that directory.

如果您的 Next.js 应用中存在某个嵌套子目录，需要采用不同于项目根目录的 Babel 配置，那么现在您可以在该子目录中专门放置一个作用域限定的 `.babelrc` 文件。

```bash
src/
```

2    .babelrc      # General .babelrc

2    .babelrc      # 通用 .babelrc 配置文件

3  components/

3  components/

4    i18n/

4    i18n/

5      .babelrc  # This .babelrc only applies to this directory

5      .babelrc  # 此 .babelrc 文件仅对该目录生效

```

```

### First-class TypeScript Support

### 对 TypeScript 的一流支持

When we announced [Universal webpack](https://vercel.com/blog/next5), we pointed out it was possible to use TypeScript via [ts-loader](https://github.com/TypeStrong/ts-loader), as we now run webpack both on the server and the client.

在我们宣布 [Universal webpack](https://vercel.com/blog/next5) 时，我们曾指出：由于现在 webpack 同时在服务端和客户端运行，因此可通过 [ts-loader](https://github.com/TypeStrong/ts-loader) 使用 TypeScript。

Babel 7 features built-in support for TypeScript (previously only Flow was supported by Babel).

Babel 7 内置了对 TypeScript 的支持（此前 Babel 仅支持 Flow）。

To use it, just install the latest version of [@zeit/next-typescript](https://github.com/zeit/next-plugins/tree/master/packages/next-typescript/#readme) or check out [this example](https://github.com/zeit/next.js/tree/canary/examples/with-typescript).

要使用该功能，只需安装最新版本的 [@zeit/next-typescript](https://github.com/zeit/next-plugins/tree/master/packages/next-typescript/#readme)，或参考 [此示例](https://github.com/zeit/next.js/tree/canary/examples/with-typescript)。

## Nextjs.org

## nextjs.org

We are very happy to introduce the new [nextjs.org](https://nextjs.org/), built by Next.js core contributor [Jimmy Moon](https://twitter.com/ragingwind).

我们非常高兴地推出全新 [nextjs.org](https://nextjs.org/) 网站，该网站由 Next.js 核心贡献者 [Jimmy Moon](https://twitter.com/ragingwind) 构建。

To start off, we highlight a sped-up video that shows you how to create a PWA with server-rendering from scratch in 5 minutes:

首先，我们为您呈现一段加速视频，展示如何在 5 分钟内从零开始构建一个支持服务端渲染的渐进式 Web 应用（PWA）：

The opening video of \`nextjs.org\`

nextjs.org 网站的开场视频

### One place for our documentation

### 文档统一入口

When you need to look up something quickly, just head to [nextjs.org/docs](https://nextjs.org/docs):

当您需要快速查阅相关内容时，只需访问 [nextjs.org/docs](https://nextjs.org/docs)：

![The documentation will always reflect the latest stable version ](images/next_js-6-and-nextjs_org-vercel/img_003.jpg)  
文档内容将始终反映最新稳定版本

### Learn, step-by-step

### 循序渐进式学习

Previously, we would recommend beginners to head to [https://learnnextjs.com](https://learnnextjs.com/) for a step-by-step guide (with quizzes!) on how to get started with Next.js

此前，我们推荐初学者前往 [https://learnnextjs.com](https://learnnextjs.com/)，通过包含测验的分步教程学习 Next.js 入门知识。

Now we've integrated it directly into [nextjs.org/learn](https://nextjs.org/learn) to make it even easier start learning:

如今，我们已将其直接整合至 [nextjs.org/learn](https://nextjs.org/learn)，让学习过程更加轻松便捷：

![The easiest way to start learning Next.js](images/next_js-6-and-nextjs_org-vercel/img_004.jpg)  
开启 Next.js 学习之旅最简单的方式

### Get Inspired

### 获取灵感

We are now featuring a showcase of some nice-looking websites and applications built on Next.js. Head to [nextjs.org/showcase](https://nextjs.org/showcase) to get inspired, or [submit your own](https://github.com/zeit/next.js/issues/new?template=4.Nextjs.org_showcase.md)!

我们现正推出一个精选展示栏目，汇集了一批外观精美、基于 Next.js 构建的网站与应用程序。欢迎访问 [nextjs.org/showcase](https://nextjs.org/showcase) 获取灵感，或 [提交您自己的项目](https://github.com/zeit/next.js/issues/new?template=4.Nextjs.org_showcase.md)！

![Showcase of projects built with Next.js](images/next_js-6-and-nextjs_org-vercel/img_005.jpg)  
![使用 Next.js 构建的项目展示](images/next_js-6-and-nextjs_org-vercel/img_005.jpg)
{% endraw %}
