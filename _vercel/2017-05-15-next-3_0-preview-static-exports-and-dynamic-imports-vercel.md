---
render_with_liquid: false
title: "Next 3.0 Preview: Static Exports and Dynamic Imports - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/next3-preview"
date: "2017-05-15"
scraped_at: "2026-03-02T10:08:05.850461022+00:00"
language: "en-zh"
translated: true
description: "Next 3.0 features Static Exports with one command and Dynamic Imports"
---
render_with_liquid: false
render_with_liquid: false

May 15, 2017

2017 年 5 月 15 日

On the heels of our announcement of free static deployments earlier today, we are excited to introduce a beta release of the upcoming [Next.js](https://github.com/zeit/next.js) 3.0, featuring `next export`, dynamic components and various bugfixes.

继我们今天早些时候宣布免费静态部署之后，我们很高兴推出即将发布的 [Next.js](https://github.com/zeit/next.js) 3.0 的 Beta 版本，该版本新增了 `next export` 功能、动态组件支持，以及多项 Bug 修复。

Next.js allows you to write React applications with server-rendering, automatic code-splitting, built-in component CSS with one command. To get started, populate `pages/my-route.js` directory with a file that exports a component:

Next.js 让你只需一条命令，即可编写支持服务端渲染（SSR）、自动代码分割（code-splitting）以及内置组件级 CSS 的 React 应用。快速上手：在 `pages/my-route.js` 目录下创建一个导出组件的文件：

```javascript
export default () => (

2  <p>Welcome to my React App!</p>

3)
```

Install it with `npm install next react react-dom`, run `next` and navigate to `http://localhost:3000/my-route`. That's it! To learn more, read the [5-minute README](https://github.com/zeit/next.js) or check out our [2.0 announcement blogpost](https://vercel.com/blog/next2).

通过 `npm install next react react-dom` 安装，运行 `next` 命令，然后访问 `http://localhost:3000/my-route` 即可！就这么简单！如需了解更多，请阅读 [5 分钟入门 README](https://github.com/zeit/next.js)，或查看我们的 [2.0 版本发布博客文章](https://vercel.com/blog/next2)。

## Next-Export

## `next export`

Until today, you would run `next` to develop, `next build` to compile the production app and `next start` to serve it.

在此前的版本中，你需分别运行 `next` 进行开发、`next build` 编译生产环境应用、`next start` 启动服务。

We are now introducing a new subcommand: `next export`. It will seamlessly build your Next.js app as a standalone static website. This means you can deploy it without a server at all!

我们现在引入了一个全新的子命令：`next export`。它将无缝地将你的 Next.js 应用构建成一个独立的静态网站。这意味着——你完全可以无需任何服务器即可完成部署！

The exported app supports almost every feature of [Next.js](https://github.com/zeit/next.js), including dynamic URLs, prefetching, preloading and the new dynamic imports.

导出的应用支持 [Next.js](https://github.com/zeit/next.js) 的几乎所有功能，包括动态 URL、预获取（prefetching）、预加载（preloading）以及新的动态导入（dynamic imports）。

Let's walk through an example.

下面我们通过一个示例来说明。

### How to Use

### 使用方法

Simply [develop](http://learnnextjs.com/) your app as you normally do with Next.js. Then create a [custom Next.js config](https://github.com/zeit/next.js#custom-configuration) like this one:

只需像平常使用 Next.js 那样 [开发](http://learnnextjs.com/) 你的应用。然后创建一个 [自定义的 Next.js 配置](https://github.com/zeit/next.js#custom-configuration)，如下所示：

next.config.js

next.config.js

```javascript
exports.exportPathMap = () => ({

2  "/": { page: "/" },

3  "/about": { page: "/about" },

4  "/p/hello-nextjs": { page: "/post", query: { title: "hello-nextjs" } },

5  "/p/learn-nextjs": { page: "/post", query: { title: "learn-nextjs" } },
```

6  "/p/deploy-nextjs": { page: "/post", query: { title: "deploy-nextjs" } }

6  "/p/deploy-nextjs": { page: "/post", query: { title: "deploy-nextjs" } }

7})
```

7})
```

This is a simple map of paths to pages, with optional query parameters to supply to `getInitialProps`. When you are ready to go to production, simply run:

这是一个简单的路径到页面的映射，可选地附带传递给 `getInitialProps` 的查询参数。当你准备上线时，只需运行：

```bash
next build

next export
```

```bash
next build

next export
```

For that, you may need to add a script to `package.json` like this:

为此，你可能需要在 `package.json` 中添加如下脚本：

```json
1{

2  "scripts": {

3    "build": "next build && next export"

4  }
```

```json
1{
2  "scripts": {
3    "build": "next build && next export"
4  }
```

5}
```

然后立即运行以下命令：

```bash
npm run build
```

这将在 `out` 目录中生成你应用的一个静态版本。该行为也是可自定义的！运行 `next export -h` 查看所有可用选项。

现在你可以部署它了！只需 `cd` 进入 `out` 目录，然后运行以下命令，即可免费、即时地将你的应用部署到 Vercel：

```bash
vercel
```

### 已知限制

使用 `next export` 时，我们会为你应用构建一个 HTML 版本。在此过程中，系统会自动执行各页面中的 `getInitialProps` 函数，并将执行结果保存下来。

这意味着，在传递给 `getInitialProps` 的 `context` 对象中，你**仅能使用** `pathname`、`query` 和 `asPath` 这三个字段；而无法使用 `req` 或 `res` 字段，因为它们依赖于服务端运行时环境。

本质上，由于我们预先构建了 HTML 文件，因此你将**无法在服务端动态渲染内容**。如果你需要服务端动态渲染能力，则必须改用 `next start` 来运行你的应用。

## Dynamic Imports

## 动态导入

Next.js 3.0 原生支持 [TC39 动态导入提案](https://github.com/tc39/proposal-dynamic-import)。这意味着你可以在整个代码库中直接使用 `import()` 语法，以 `Promise` 的形式动态加载模块。

借助高阶组件辅助工具 `next/dynamic`，你现在可以将这些 `Promise` 转换为真正的 React 组件！

```javascript
import dynamic from 'next/dynamic'



const DynamicComponent1 = dynamic(import('@components/hello1'))

const DynamicComponent2 = dynamic(import('@components/hello2'))



export default () => (

7  <div>

8    <Header />

8    <Header />

9    <DynamicComponent />

9    <DynamicComponent />

10    <p>HOME PAGE is here!</p>

10    <p>首页在此！</p>

11  </div>

11  </div>

12)
```

12)
```

In this case, the `DynamicComponent1` or `DynamicComponent2` will not be included in the main app bundle included with the page. Instead, they will be lazily downloaded on the client side.

在这种情况下，`DynamicComponent1` 或 `DynamicComponent2` 不会包含在随页面一同加载的主应用包（main app bundle）中；相反，它们将在客户端按需懒加载（lazily downloaded）。

Since we are actually rendering `DynamicComponent1`, when you server-render or export the relevant `<script>` will be included and loaded in parallel with the rest of the scripts.

由于我们实际渲染的是 `DynamicComponent1`，因此在服务端渲染（server-render）或导出（export）时，相关的 `<script>` 标签会被自动包含，并与其他脚本并行加载。

As eloquently explained by [James Kyle](https://medium.com/@thejameskyle/react-loadable-2674c59de178), dynamic loadable components give you more granularity for code splitting.

正如 [James Kyle](https://medium.com/@thejameskyle/react-loadable-2674c59de178) 所精辟阐述的那样，动态可加载组件（dynamic loadable components）能为代码分割（code splitting）提供更精细的控制粒度。

Consider, for example, the use case of a long chat thread with different message types. If you simply rely on static `import` declarations for code splitting, you will end up loading message types on the client that are not required in many cases!

以一个包含多种消息类型的长聊天线程为例：如果你仅依赖静态 `import` 声明来实现代码分割，那么在许多情况下，客户端将不得不加载那些根本不会被用到的消息类型模块！

## Server Side Rendering

## 服务端渲染

Next.js supports server side rendering for dynamic imports. For an example, in the above example, we will load `DynamicComponent1` on the server side and render it synchronously.

Next.js 支持对动态导入（dynamic imports）进行服务端渲染。例如，在上述示例中，我们将于服务端加载 `DynamicComponent1` 并同步渲染它。

This is a unique feature of Next.js which makes Dynamic Imports incredibly powerful.

这是 Next.js 的一项独特功能，使得动态导入功能变得极为强大。

Concretely, you get all the benefits of dynamic imports, but you avoid showing the clients blank pages, flickering or loading spinners.

具体而言，你既能获得动态导入的所有优势，又可避免向用户展示空白页面、内容闪烁或加载旋转图标（loading spinner）等问题。

## Get it Now!

## 立即体验！

Next.js 3.0 is completely backwards-compatible and ready for experimentation and pre-production use. The APIs might change slightly but we don't expect to alter them in significant ways.

Next.js 3.0 完全向后兼容，已准备好供实验性使用及预发布环境部署。API 可能会有小幅调整，但我们不预期进行重大变更。

- Run `npm install next@beta`.

- 运行 `npm install next@beta`。

- Check out the up-to-date [documentation](https://github.com/vercel/next.js/tree/canary#readme).

- 查阅最新版[文档](https://github.com/vercel/next.js/tree/canary#readme)。

- Have a look at [this example app](https://github.com/vercel/next.js/tree/canary/examples/with-dynamic-import).

- 查看[此示例应用](https://github.com/vercel/next.js/tree/canary/examples/with-dynamic-import)。

- Join the Vercel Community `#next` channel to ask any questions or get in touch with us!

- 加入 Vercel 社区的 `#next` 频道，随时提问或与我们取得联系！