---
title: "Build your own web framework - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/build-your-own-web-framework"
date: "2022-07-28"
scraped_at: "2026-03-02T10:01:54.630876457+00:00"
language: "en-zh"
translated: true
description: "Build your own web framework that deploys to edge and serverless infrastructure."
---
{% raw %}

Jul 28, 2022

2022 年 7 月 28 日

Deploy any framework to Vercel using the Build Output API.

使用构建输出 API 将任意框架部署至 Vercel。

Have you ever wondered what it takes to build your own web framework that also deploys to edge and serverless infrastructure? What features does a modern framework need to support, and how can we ensure that these features allow us to build a scalable, performant web application?

你是否曾思考过：要构建一个既能部署到边缘网络（edge）又能部署到无服务器（serverless）基础设施的自有 Web 框架，究竟需要哪些条件？现代框架应当支持哪些关键特性？我们又该如何确保这些特性能够助力我们构建出可扩展、高性能的 Web 应用？

This post will explain how to build your own simple React-based web framework. We'll use the [Vercel Build Output API](https://vercel.com/docs/build-output-api/v3) to deploy our framework with support for the following features:

本文将介绍如何构建一个基于 React 的简易自定义 Web 框架。我们将借助 [Vercel 构建输出 API](https://vercel.com/docs/build-output-api/v3) 部署该框架，并使其支持以下功能：

- **Static Files** to statically render pages

- **静态文件（Static Files）**：用于静态渲染页面

- **Incremental Static Regeneration** to automatically revalidate and regenerate pages after a specific timeout

- **增量静态再生（Incremental Static Regeneration）**：在指定超时后自动重新验证并再生页面

- **Edge Functions** to enable edge rendering and middleware

- **边缘函数（Edge Functions）**：支持边缘端渲染与中间件

- **Automatic Image Optimization** to efficiently serve the images using the latest format, enable lazy loading, and prevent layout shift

- **自动图像优化（Automatic Image Optimization）**：以最新图像格式高效提供图片资源，支持懒加载，并防止布局偏移（layout shift）

- **Serverless Functions** to server-render dynamic pages and create data fetching endpoints

- **无服务器函数（Serverless Functions）**：用于服务端渲染动态页面，以及创建数据获取端点（data fetching endpoints）

- **Edge Caching** to quickly serve static files to users globally

- **边缘缓存（Edge Caching）**：面向全球用户快速提供静态文件

The source code for this article is available in [this GitHub Repo](https://github.com/lydiahallie/byof-demo) to see the demo implementation covered in this article.

本文示例的源代码可在 [此 GitHub 仓库](https://github.com/lydiahallie/byof-demo) 中获取，其中包含了本文所介绍的演示实现。

The implementation of this demo framework is simplified. Production frameworks usually do more to create an optimized output, such as more advanced bundling, caching, type checking, and more. This blog post demonstrates how to create a basic yet functional example and deploy it to Vercel using the Build Output API.

本演示框架的实现经过了简化。生产级框架通常会做更多工作以生成高度优化的输出，例如更高级的代码打包（bundling）、缓存策略、类型检查（type checking）等。本文将演示如何构建一个基础但功能完备的示例，并利用 Vercel 的 Build Output API 将其部署到 Vercel 平台。

### Landing Page

### 着陆页（首页）

Let's explore the requirements of each page we want to build and how to build optimizations into our web framework to help achieve excellent performance.

让我们逐一分析我们希望构建的每个页面的需求，并探讨如何将性能优化能力集成进我们的 Web 框架，从而实现卓越的页面性能。

![Demo website's landing page](images/build-your-own-web-framework-vercel/img_001.jpg)![Demo website's landing page](images/build-your-own-web-framework-vercel/img_002.jpg)Demo website's landing page

![演示网站的着陆页](images/build-your-own-web-framework-vercel/img_001.jpg)![演示网站的着陆页](images/build-your-own-web-framework-vercel/img_002.jpg)演示网站的着陆页

The landing page is a static page with a single large hero image. Although this page may seem simple, there are a few optimizations we can implement in our framework to ensure this page is fast.

着陆页是一个静态页面，仅包含一张大幅英雄图（hero image）。尽管该页面看似简单，我们仍可在框架中实现若干优化措施，以确保其加载速度极快。

**Image Optimization**

**图像优化**

We can reduce the image size without sacrificing quality by using the latest image formats (like `.webp` and `.avif`) and prevent [layout shift](https://vercel.com/blog/core-web-vitals#cumulative-layout-shift) by explicitly setting the image width and height.

我们可通过采用最新的图像格式（如 `.webp` 和 `.avif`）在不牺牲画质的前提下显著减小图像体积；同时，通过显式声明图像的 `width` 和 `height` 属性，可有效防止 [布局偏移（Layout Shift）](https://vercel.com/blog/core-web-vitals#cumulative-layout-shift)。

**Edge Caching**

**边缘缓存（Edge Caching）**

Since we want our framework to generate a static HTML file for this page, we can use a CDN to improve the Time To First Byte (TTFB) by caching the file at each region (or edge). Vercel provides this functionality out of the box with the [Edge Network](https://vercel.com/docs/concepts/edge-network/overview), so we don't need to add this ourselves.

由于我们希望框架为该页面生成静态 HTML 文件，因此可借助 CDN 将文件缓存至全球各区域（即“边缘”节点），从而显著降低首字节时间（Time To First Byte, TTFB）。Vercel 原生支持这一能力——其 [Edge Network（边缘网络）](https://vercel.com/docs/concepts/edge-network/overview) 已内置该功能，我们无需额外开发即可直接使用。

### Products Page

### 产品页面

![Demo website's product page](images/build-your-own-web-framework-vercel/img_003.jpg)![Demo website's product page](images/build-your-own-web-framework-vercel/img_004.jpg)Demo website's product page

![演示网站的产品页面](images/build-your-own-web-framework-vercel/img_003.jpg)![演示网站的产品页面](images/build-your-own-web-framework-vercel/img_004.jpg)演示网站的产品页面

The products page is a hybrid between a pre-generated static HTML page and a dynamic server-rendered page. The page renders a list of products retrieved from a data provider and should automatically update after a certain amount of time (or when new products have been added).

产品页面是预生成的静态 HTML 页面与动态服务端渲染页面的混合体。该页面从数据提供方获取并渲染产品列表，并应在一定时间后（或有新产品添加时）自动更新。

This product page can benefit from a few optimizations we want to build into our framework.

此产品页面可从我们希望集成到框架中的若干优化措施中获益。

**Image Optimization**

**图像优化**

Since we're showing many images on this page, we want to use image optimization to serve the images in the latest format and defer the loading of non-critical images for a faster [first paint](https://nextjs.org/learn/seo/web-performance/lcp).

由于本页面需展示大量图像，我们希望采用图像优化技术，以最新格式提供图像，并延迟加载非关键图像，从而加快[首次绘制（first paint）](https://nextjs.org/learn/seo/web-performance/lcp)速度。

**Incremental Static Regeneration**

**增量静态再生（ISR）**

Displayed products should update after a certain amount of time or when new products are added. This rendering pattern is also referred to as [Incremental Static Regeneration](https://vercel.com/blog/how-hashicorp-developers-iterate-faster-with-isr) behavior and gives you the benefits of Static Generation, combined with the dynamic benefits of Server-Side Rendering. When using the Build Output API, we can use Prerender Functions to enable and configure ISR on certain pages.

已展示的产品应在一定时间后（或有新产品添加时）自动更新。这种渲染模式也称为[增量静态再生（Incremental Static Regeneration, ISR）](https://vercel.com/blog/how-hashicorp-developers-iterate-faster-with-isr)，它兼具静态生成（Static Generation）的优势与服务端渲染（Server-Side Rendering）的动态能力。在使用构建输出 API（Build Output API）时，我们可通过预渲染函数（Prerender Functions）在特定页面上启用并配置 ISR。

## Popular Page

## 热门页面

![Demo website's popular page](images/build-your-own-web-framework-vercel/img_005.jpg)![Demo website's popular page](images/build-your-own-web-framework-vercel/img_006.jpg)Demo website's popular page

![演示网站的热门页面](images/build-your-own-web-framework-vercel/img_005.jpg)![演示网站的热门页面](images/build-your-own-web-framework-vercel/img_006.jpg)演示网站的热门页面

We want to display the most relevant, personalized products to our visitors. How can our web framework help enable us to add this feature?

我们希望向访客展示最相关、最个性化的商品。我们的 Web 框架如何帮助我们实现这一功能？

**Edge Functions**

**边缘函数（Edge Functions）**

To get the visitor’s location, we can use an Edge Function to determine the city based on the `x-vercel-ip-city` header. We could take two approaches to Edge Functions: either use [Edge Middleware](https://vercel.com/edge) to redirect the user to a specific page based on their location, _or_ we can server-render the page using [Edge Functions](https://vercel.com/edge). We’ll choose server-rendering for a fast, personalized page in this case.

为获取访客地理位置，我们可以使用边缘函数（Edge Function），依据请求头 `x-vercel-ip-city` 判定其所在城市。针对边缘函数，我们有两种实现路径：一是使用 [Edge Middleware](https://vercel.com/edge) 根据用户位置将其重定向至特定页面；二是使用 [Edge Functions](https://vercel.com/edge) 对页面进行服务端渲染（server-rendering）。在本例中，我们选择服务端渲染，以实现快速且个性化的页面加载。

## Building the framework

## 构建框架

We now know what features our website could benefit from to create a better user experience. Next, let’s focus on implementing our framework to ensure it supports all the features mentioned above.

我们现已明确网站可借助哪些功能来提升用户体验。接下来，我们将聚焦于框架的实现，确保其全面支持上述所有功能。

Our framework expects the pages to be located in the `pages/` folder. To keep it simple, we’ll expect that the page contains:

我们的框架约定页面文件需置于 `pages/` 目录下。为保持简洁，我们要求每个页面文件包含以下内容：

- A default `export` to export the page’s React component

- 一个默认导出（`export default`），用于导出该页面的 React 组件；

- A configuration object named `pageConfig`, which includes a `strategy` prop to define the rendering technique that should be used for this page - either `static`, `ssr`, `prerender`, or `edge`. If a page is prerendered, users can also pass an optional `expiration` time and `fallback` component to configure the regeneration.

- 一个名为 `pageConfig` 的配置对象，其中包含 `strategy` 属性，用于指定该页面应采用的渲染策略——可选值为 `static`（静态生成）、`ssr`（服务端渲染）、`prerender`（预渲染）或 `edge`（边缘渲染）。若页面采用预渲染策略，用户还可额外传入可选的 `expiration`（过期时间）和 `fallback`（回退组件），以配置缓存再生行为。

Let's see how our framework can work with these values and create a valid output Vercel can use to deploy our project.

让我们看看框架如何利用这些配置值，生成 Vercel 可识别并用于部署项目的有效输出。

## Static Rendering

## 静态渲染

When a page is statically rendered, the page’s HTML is generated during the build. Vercel's Edge Network can quickly return this pre-generated HTML file when a user visits the page, after which the browser can draw the contents to the user’s screen.

当页面被静态渲染时，页面的 HTML 会在构建阶段生成。Vercel 的边缘网络（Edge Network）可在用户访问该页面时快速返回这一预生成的 HTML 文件，随后浏览器即可将内容绘制到用户的屏幕上。

To support static pages, we first have to implement a transpilation step that turns React-based pages into static HTML. ReactDOM Server exposes a method called `renderToString`, which takes a React component and returns the corresponding HTML output. We can invoke this function to prerender the HTML for static pages during the build.

为支持静态页面，我们首先需实现一个转译步骤，将基于 React 的页面转换为静态 HTML。ReactDOM Server 提供了一个名为 `renderToString` 的方法，它接收一个 React 组件，并返回对应的 HTML 字符串。我们可在构建过程中调用该函数，对静态页面进行预渲染。

```javascript
function createStaticPage(pagePath) {

2  const { Component } = require(pagePath);

3  const pageHTML = `<div id="root">${ReactDOMServer.renderToString(Component)}</div>`;

4  ...

5}
```

```javascript
function createStaticPage(pagePath) {

2  const { Component } = require(pagePath);

3  const pageHTML = `<div id="root">${ReactDOMServer.renderToString(Component)}</div>`;

4  ...

5}
```

In most cases, however, our React components aren’t _entirely_ static. Components usually contain some interactivity, such as event handlers. To account for this, we also need to create one or multiple [JavaScript bundle(s)](https://nextjs.org/learn/foundations/how-nextjs-works/bundling) to _hydrate_ the static markup once it’s been rendered.

然而，在大多数情况下，我们的 React 组件并非完全静态。组件通常包含某些交互逻辑，例如事件处理器。为应对这一需求，我们还需创建一个或多个 [JavaScript 包（bundle）](https://nextjs.org/learn/foundations/how-nextjs-works/bundling)，以便在静态标记（markup）渲染完成后对其进行 _注水（hydrate）_。

To hydrate dynamic components, we can export a string literal that our bundler eventually uses to create a custom hydration script for the individual pages. A bundler can generate HTML and automatically inject this custom hydration script as a deferred script. The script automatically fetches the hydration bundle to add interactivity when a browser has loaded the page's HTML.

为注水动态组件，我们可以导出一个字符串字面量，供打包器（bundler）最终用于为各个页面生成自定义的注水脚本。打包器可生成 HTML，并自动将该自定义注水脚本作为 `defer` 脚本注入。该脚本会在浏览器加载完页面 HTML 后，自动获取注水所需的 bundle，从而为页面添加交互能力。

![](images/build-your-own-web-framework-vercel/img_007.jpg)![](images/build-your-own-web-framework-vercel/img_008.jpg)![](images/build-your-own-web-framework-vercel/img_009.jpg)![](images/build-your-own-web-framework-vercel/img_010.jpg)

Let’s see what this could look like in our code.

让我们看看这在我们的代码中可能是什么样子。

The example below shows a dynamic `createStaticFile` method that takes our page’s default exported component and the `filePath` where the component is located. With this information, we can create a bundle that automatically gets injected into the newly created HTML file and output it to the `.vercel/output/static` folder.

下面的示例展示了一个动态的 `createStaticFile` 方法，它接收页面默认导出的组件以及该组件所在的 `filePath`。借助这些信息，我们可以生成一个 bundle，该 bundle 会自动注入到新创建的 HTML 文件中，并输出至 `.vercel/output/static` 文件夹。

```javascript
export async function createStaticFile(Component,filePath) {

2  const pageName = getPageName(filePath);

3  const outdir = join(".vercel", "output", "static");

4  await fs.ensureDir(outdir);



6  await generateClientBundle({ filePath, outdir, pageName });



8  return fs.writeFileSync(
```

9    path.join(outdir, `${pageName}.html`),

9    path.join(outdir, `${pageName}.html`),

10    `<!DOCTYPE html>

10    `<!DOCTYPE html>

11      ...

11      ...

12      <body>

12      <body>

13        <div id="root">${ReactDOMServer.renderToString(React.createElement(Component) )}</div>

13        <div id="root">${ReactDOMServer.renderToString(React.createElement(Component) )}</div>

14        <script src="${pageName}.bundle.js" defer></script>

14        <script src="${pageName}.bundle.js" defer></script>

15      </body>`

15      </body>`

16  );

16  );

17}

17}

At build time, we end up with a `.vercel/output/static` folder that contains the static HTML and the JavaScript bundle(s) necessary for hydration.

构建时，我们会得到一个 `.vercel/output/static` 文件夹，其中包含用于注水（hydration）所需的静态 HTML 文件和 JavaScript 包（bundle）。

![Folder structure for static assets](images/build-your-own-web-framework-vercel/img_011.jpg)![Folder structure for static assets](images/build-your-own-web-framework-vercel/img_012.jpg)![Folder structure for static assets](images/build-your-own-web-framework-vercel/img_013.jpg)![Folder structure for static assets](images/build-your-own-web-framework-vercel/img_014.jpg)静态资源的文件夹结构

![Folder structure for static assets](images/build-your-own-web-framework-vercel/img_011.jpg)![Folder structure for static assets](images/build-your-own-web-framework-vercel/img_012.jpg)![Folder structure for static assets](images/build-your-own-web-framework-vercel/img_013.jpg)![Folder structure for static assets](images/build-your-own-web-framework-vercel/img_014.jpg)静态资源的文件夹结构

Any static assets, such as HTML, CSS, JavaScript, and images should be located in the `.vercel/output/static` folder so the Vercel Build Output API can convert them into infrastructure primitives.

所有静态资源（例如 HTML、CSS、JavaScript 和图片）均应存放在 `.vercel/output/static` 文件夹中，以便 Vercel 构建输出 API（Build Output API）能将其转换为基础设施原语（infrastructure primitives）。

## Incremental Static Regeneration

## 增量静态再生（ISR）

[Incremental Static Regeneration](https://vercel.com/blog/how-hashicorp-developers-iterate-faster-with-isr) is a powerful pattern that we can use for pages that contain data that frequently updates by invalidating the cache and regenerating the page after a specific interval or based on an event.

[增量静态再生（Incremental Static Regeneration，ISR）](https://vercel.com/blog/how-hashicorp-developers-iterate-faster-with-isr) 是一种强大模式，适用于包含频繁更新数据的页面——它通过使缓存失效，并在指定时间间隔后或基于特定事件触发页面的重新生成来实现。

The `/products` page can benefit from ISR, as it could regenerate after a specific interval to ensure it always shows the latest products and optional price reductions as quickly as possible.

`/products` 页面可从 ISR 中获益：它可在指定时间间隔后自动再生，从而确保始终以最快速度展示最新商品及可选的价格优惠。

![](images/build-your-own-web-framework-vercel/img_015.jpg)![](images/build-your-own-web-framework-vercel/img_016.jpg)![](images/build-your-own-web-framework-vercel/img_017.jpg)![](images/build-your-own-web-framework-vercel/img_018.jpg)

![](images/build-your-own-web-framework-vercel/img_015.jpg)![](images/build-your-own-web-framework-vercel/img_016.jpg)![](images/build-your-own-web-framework-vercel/img_017.jpg)![](images/build-your-own-web-framework-vercel/img_018.jpg)

To enable Incremental Static Regeneration, we need to create a few files.

要启用增量静态再生（ISR），我们需要创建若干文件：

- `products.func/index.js` **:** A Serverless Function containing the handler that takes care of the page’s (re)generation.

- `products.func/index.js` **：** 一个无服务器函数（Serverless Function），内含处理页面（重新）生成逻辑的处理器（handler）。

- `products.func/vc-config.js`: The configuration file used by the Serverless Function to configure its environment, such as the runtime and optional helpers.

- `products.func/vc-config.js`：该无服务器函数所用的配置文件，用于配置其运行环境（例如运行时 runtime 及可选的辅助工具）。

- `products.prerender-config.json`: The configuration file that Vercel uses to determine when and how to regenerate the page. This is necessary since this isn’t just Server-Rendering—it’s also using automatic invalidation and regeneration.

- `products.prerender-config.json`：Vercel 用于确定页面何时以及如何再生的配置文件。之所以需要该文件，是因为此处不仅涉及服务端渲染（Server-Side Rendering），还结合了自动缓存失效与页面再生机制。

- `products.prerender-fallback.html`: 当页面尚无缓存版本、且该页面正在后台生成时，所返回的（可选）备用 HTML。此举可提升用户体验，避免用户在页面生成过程中面对空白屏幕。

- `products.prerender-fallback.html`: 当页面尚无缓存版本、且该页面正在后台生成时，所返回的（可选）备用 HTML。此举可提升用户体验，避免用户在页面生成过程中面对空白屏幕。

## **Serverless Functions**

## **无服务器函数**

First, let’s see how we can create a Serverless Function that handles the HTML (re)generation.

首先，我们来看看如何创建一个无服务器函数，用以处理 HTML 的（重新）生成。

When a Serverless Function is invoked, its handler function runs. This function runs in its own environment, meaning that we have to ensure that this handler function has access to all the necessary code to generate the HTML.

当一个无服务器函数被调用时，其处理器（handler）函数便会执行。该函数运行于独立环境中，因此我们必须确保该处理器函数能够访问所有用于生成 HTML 所需的代码。

We can create a Serverless Function on Vercel by creating a `<name>.func` folder, with the name being the name of the server-rendered page. In this case, we have to create a `products.func` folder, since the page needs to get regenerated in a Serverless Function.

我们可以在 Vercel 上通过创建一个 `<name>.func` 文件夹来定义一个无服务器函数，其中 `<name>` 即为服务端渲染页面的名称。本例中，由于该页面需通过无服务器函数进行重新生成，因此我们必须创建一个名为 `products.func` 的文件夹。

To include all the necessary code and dependencies, we can create a `node_modules` folder within the function folder or bundle everything together into one single handler file.

为包含所有必需的代码与依赖项，我们可在函数文件夹内创建一个 `node_modules` 文件夹，或将全部内容打包为单个处理器文件。

![](images/build-your-own-web-framework-vercel/img_019.jpg)![](images/build-your-own-web-framework-vercel/img_020.jpg)![](images/build-your-own-web-framework-vercel/img_019.jpg)![](images/build-your-own-web-framework-vercel/img_020.jpg)

![](images/build-your-own-web-framework-vercel/img_019.jpg)![](images/build-your-own-web-framework-vercel/img_020.jpg)![](images/build-your-own-web-framework-vercel/img_019.jpg)![](images/build-your-own-web-framework-vercel/img_020.jpg)

To create the files that are necessary for a serverless function, let’s create a `createServerlessFunction` function that invokes two functions:

为生成无服务器函数所需的全部文件，我们来创建一个 `createServerlessFunction` 函数，它将调用以下两个函数：

- `generateClientBundle`, to generate a client-side bundle used to hydrate the static HTML returned from the server

- `generateClientBundle`：用于生成客户端资源包，以便对服务器返回的静态 HTML 进行“注水”（hydration）

- `generateLambdaBundle`, to bundle the necessary files into a script that’s executed in the Lambda’s handler

- `generateLambdaBundle`：将必要文件打包为一个脚本，供 Lambda 处理器（handler）执行

The method also generates a `.vc-config.json` file, which includes information that the Lambda needs to set up its execution context.

该方法还会生成一个 `.vc-config.json` 文件，其中包含 Lambda 设置其执行上下文所需的信息。

```javascript
export async function createServerlessFunction(Component, filePath) {

2  const pageName = getPageName(filePath);

3  const funcFolder = `.vercel/output/functions/${pageName}.func`;



5  await fs.ensureDir(funcFolder);



7  await Promise.allSettled([\
\
8    generateClientBundle({ filePath, pageName }),\
\
9    generateLambdaBundle({\
\
10      funcFolder,\
\
11      pageName,\
\
12      Component,\
\
13    }),\
\
14  ]);



16  return fs.writeJson(`${funcFolder}/.vc-config.json`, {

17    runtime: "nodejs16.x",

17    运行时：`"nodejs16.x"`，

18    handler: "index.js",

18    处理程序：`"index.js"`，

19    launcherType: "Nodejs",

19    启动器类型：`"Nodejs"`，

20    shouldAddHelpers: true,

20    是否添加辅助工具：`true`，

21  });

21  });

22}
```

22}
```

The handler function is responsible for server-rendering the HTML based on the page’s exported component. This approach is very similar to the static rendering we saw before. This time, however, we’re generating the HTML at _request time_ instead of at build time.

处理程序函数负责根据页面所导出的组件在服务端渲染 HTML。该方法与我们之前看到的静态渲染非常相似；但这一次，HTML 是在 _请求时_ 生成的，而非构建时。

```javascript
export async function generateLambdaBundle(Component, funcFolder, pageName,outfile) {

```javascript
export async function generateLambdaBundle(Component, funcFolder, pageName, outfile) {

2  const html = ReactDOMServer.renderToString(React.createElement(Component));

2  const html = ReactDOMServer.renderToString(React.createElement(Component));

3  const { code: contents } = await transform(getHandlerCode(html, pageName));

3  const { code: contents } = await transform(getHandlerCode(html, pageName));

5  return await build({

5  返回 await build({

6    ...

6    ...

7    stdin: { contents, resolveDir: path.join(".") },

7    stdin: { contents, resolveDir: path.join(".") },

8    outfile,

8    outfile,

9  });

9  });

10};

10};

const getHandlerCode = (html: string, pageName: string) => `

const getHandlerCode = (html: string, pageName: string) => `

13  export default (req, res) => {

13  export default (req, res) => {

14    res.setHeader('Content-type', 'text/html');

14    res.setHeader('Content-type', 'text/html');

15    res.end(\`<!DOCTYPE html>

15    res.end(\`<!DOCTYPE html>

16    <html lang="en">

16    <html lang="en">

17      ...

17      ...

18      <body>

18      <body>

19        <div id="root">${html}</div>

19        <div id="root">${html}</div>

20        <script src="${pageName}.bundle.js" defer></script>

20        <script src="${pageName}.bundle.js" defer></script>

21      </body>

21      </body>

22    </html>\`)

22    </html>\`);

23  }

23  }

24`;
```

打包完成后，`.vercel/output/functions/products.func/index.js` 处理器文件即包含用于服务端渲染组件 HTML 的功能。

除了创建一个 Serverless Function 之外，我们还需要一个 `prerender-config.json` 文件，该文件包含使用增量静态再生（Incremental Static Regeneration, ISR）时有关再生（regeneration）的配置信息。我们的框架允许用户自定义 `revalidate` 时间，因此我们可以动态生成此配置文件。

我们新增的 `createPrerender` 函数会调用此前创建的 `createServerlessFunction` 和 `createStaticFile` 函数，并生成一个 `<name>.prerender-config.json` 文件。我们创建该静态文件，是为了将其作为回退页面（fallback page）进行渲染——当页面仍在后台生成时，该页面将展示给用户。构建输出 API（Build Output API）要求此回退 HTML 文件位于 `<name>.prerender-fallback.html` 路径下，或由 `<name>.prerender-config.json` 中指定的路径决定。

```javascript
export async function createPrerender(Component, filePath, pageConfig) {

2  const pageName = getPageName(filePath);



4  const funcFolder = `.vercel/output/functions/${pageName}.func`;

5  await fs.ensureDir(funcFolder);
```

```markdown
7  await Promise.allSettled([\
\
8    createServerlessFunction(Component, filePath),\
\
9    createStaticFile(Component, filePath, {\
\
10      outdir: `.vercel/output/functions`,\
\
11      fileName: `${pageName}.prerender-fallback.html`,\
\
12      bundle: false,\
\
13    }),\
\
14  ]);

7  await Promise.allSettled([\
\
8    createServerlessFunction(Component, filePath),\
\
9    createStaticFile(Component, filePath, {\
\
10      输出目录: `.vercel/output/functions`,\
\
11      文件名: `${pageName}.prerender-fallback.html`,\
\
12      是否打包: false,\
\
13    }),\
\
14  ]);

16  return writeJson(

17    `.vercel/output/functions/${pageName}.prerender-config.json`,

18    {

19      expiration: pageConfig.revalidate,

20      group: 1,

21      fallback: `${pageName}.prerender-fallback.html`,

22    }

23  );

16  return writeJson(

17    `.vercel/output/functions/${pageName}.prerender-config.json`,

18    {

19      过期时间（秒）: pageConfig.revalidate,

20      分组编号: 1,

21      回退文件: `${pageName}.prerender-fallback.html`,

22    }

23  );
```

24}
```

Once building has been completed, we end up with a `products.func` folder containing all the code it needs to generate the HTML on the server.

一旦构建完成，我们将得到一个 `products.func` 文件夹，其中包含在服务器端生成 HTML 所需的全部代码。

![Folder structure for prerender functions](images/build-your-own-web-framework-vercel/img_023.jpg)![Folder structure for prerender functions](images/build-your-own-web-framework-vercel/img_024.jpg)![Folder structure for prerender functions](images/build-your-own-web-framework-vercel/img_025.jpg)![Folder structure for prerender functions](images/build-your-own-web-framework-vercel/img_026.jpg)Folder structure for prerender functions

![预渲染函数的文件夹结构](images/build-your-own-web-framework-vercel/img_023.jpg)![预渲染函数的文件夹结构](images/build-your-own-web-framework-vercel/img_024.jpg)![预渲染函数的文件夹结构](images/build-your-own-web-framework-vercel/img_025.jpg)![预渲染函数的文件夹结构](images/build-your-own-web-framework-vercel/img_026.jpg)预渲染函数的文件夹结构

Right now, the `createPrerender` function takes care of creating the Serverless Function, creating a static `prerender-fallback.html` fallback file by statically rendering the component at build time, and generating a `prerender-config.json` configuration file that includes the necessary information the Build Output API needs to configure the prerendering behavior, such as the `expiration` value.

目前，`createPrerender` 函数负责创建无服务器函数（Serverless Function），通过在构建时对组件进行静态渲染，生成一个静态的 `prerender-fallback.html` 回退文件，并生成一个 `prerender-config.json` 配置文件。该配置文件包含了构建输出 API（Build Output API）用以配置预渲染行为所需的必要信息，例如 `expiration`（过期时间）值。

## Edge Server-Rendering

## 边缘服务器端渲染（Edge Server-Rendering）

Since React is compatible with the [Edge Runtime](https://vercel.com/blog/introducing-the-edge-runtime) due to its isomorphic nature - it doesn’t use any Node.js libraries - it’s possible to render React _at the Edge_. Creating an [Edge Function](https://vercel.com/edge) is similar to a serverless function, with its [runtime](https://vercel.com/blog/introducing-the-edge-runtime) as the most significant difference.

由于 React 具有同构（isomorphic）特性——不依赖任何 Node.js 库——因此它天然兼容 Vercel 的 [Edge Runtime](https://vercel.com/blog/introducing-the-edge-runtime)，从而支持在边缘（Edge）处直接渲染 React。创建一个 [Edge Function](https://vercel.com/edge) 与创建无服务器函数类似，二者最显著的区别在于所使用的 [运行时（runtime）](https://vercel.com/blog/introducing-the-edge-runtime)。

![](images/build-your-own-web-framework-vercel/img_027.jpg)![](images/build-your-own-web-framework-vercel/img_028.jpg)![](images/build-your-own-web-framework-vercel/img_029.jpg)![](images/build-your-own-web-framework-vercel/img_030.jpg)

![](images/build-your-own-web-framework-vercel/img_027.jpg)![](images/build-your-own-web-framework-vercel/img_028.jpg)![](images/build-your-own-web-framework-vercel/img_029.jpg)![](images/build-your-own-web-framework-vercel/img_030.jpg)

Let’s create a `createEdgeFunction` function that takes care of generating the necessary files to enable Edge Server-Rendering. This function calls the `generateEdgeBundle` function that eventually takes care of bundling the required files, and creates a `.vc-config.json` configuration file that indicates we’re using the `edge` runtime with an `entrypoint` file instead of a handler.

下面我们来创建一个 `createEdgeFunction` 函数，用于生成启用边缘服务器端渲染（Edge Server-Rendering）所需的全部文件。该函数会调用 `generateEdgeBundle` 函数，后者最终负责打包所需文件；同时，它还会生成一个 `.vc-config.json` 配置文件，用以声明我们使用的是 `edge` 运行时，并指定 `entrypoint`（入口文件），而非传统的 `handler`（处理器）。

```javascript
export async function createEdgeFunction(Component, filePath) {

2  const pageName = getPageName(filePath);
```

3  const funcFolder = `.vercel/output/functions/${pageName}.func`;

3  const funcFolder = `.vercel/output/functions/${pageName}.func`;

4  await ensureDir(funcFolder);

4  await ensureDir(funcFolder);

6  await generateEdgeBundle({

6  await generateEdgeBundle({

7    funcFolder,

7    funcFolder,

8    filePath,

8    filePath,

9    pageName,

9    pageName,

10    Component,

10    Component,

11  });

11  });

13  return writeJson(`${funcFolder}/.vc-config.json`, {

13  return writeJson(`${funcFolder}/.vc-config.json`, {

14    runtime: "edge",

14    runtime: "edge",

15    entrypoint: "index.js",

15    entrypoint: "index.js",

16  });

16  });

17}

17}


```

Generating the bundle is similar to the serverless approach, however this time, we care about values present on the `req` object. To pass the prop down to the edge-rendered page, we can dynamically create the React element that was bundled from the original page’s file path.

```

生成 Bundle 的方式与无服务器（serverless）方式类似，但这一次，我们需要关注 `req` 对象中所包含的值。为了将属性（prop）传递给边缘渲染（edge-rendered）页面，我们可以根据原始页面的文件路径，动态创建已打包的 React 元素。


```javascript
export async function generateEdgeBundle(funcFolder, pageName, filePath) {

```javascript
export async function generateEdgeBundle(funcFolder, pageName, filePath) {

2  const { code: contents } = await transform(

2  const { code: contents } = await transform(

3    getEdgeHandlerCode(filePath),

3    getEdgeHandlerCode(filePath),

4    edgeBuildConfig

4    edgeBuildConfig

5  );

5  );

7  return await build({

7  return await build({

8    ...

8    ...

9    stdin: { contents, resolveDir: path.join(".") },

9    stdin: { contents, resolveDir: path.join(".") },

10    outfile,

10    outfile,

11  });

11  });

12}

12}

```javascript
export const getEdgeHandlerCode = (filePath) => `

15  import { createElement } from 'react';

15  导入 { createElement } 来自 'react';

16  import { renderToString } from 'react-dom/server';

16  导入 { renderToString } 来自 'react-dom/server';

17  import Component from '${filePath}';

17  导入 Component 来自 '${filePath}';



19  export default async function(req) {

19  导出默认的异步函数(req) {

20    const html = renderToString(createElement(Component, { req }));

20    const html = renderToString(createElement(Component, { req }));



22    return new Response(\`<!DOCTYPE html><div id="root">${html}</div>\`, {

22    返回新的 Response(\`<!DOCTYPE html><div id="root">${html}</div>\`, {

23      headers: { 'Content-Type': 'text/html; charset=utf-8' }

23      头部: { 'Content-Type': 'text/html; charset=utf-8' }
```

24    });

25  }

26`;
```

打包完成后，我们现在得到一个入口文件（entrypoint），它将 `req` 属性传递给边缘渲染（edge-rendered）页面，并返回一个包含生成 HTML 的新 `Response` 对象。

## Serverless Functions

## 无服务器函数

无服务器函数（Serverless Functions）可用于服务端渲染页面，也可用于创建数据获取端点（data fetching endpoints）。

在上一段中实现增量静态再生（Incremental Static Regeneration, ISR）时，我们创建了一个负责生成页面 HTML 的无服务器函数。服务端渲染（Server-Side Rendering, SSR）采用相同的技术路径——主要区别在于：**该无服务器函数被调用的时机**，以及**其缓存行为**。

要对页面执行服务端渲染，我们需要创建一个函数，在每次请求时动态生成该页面的 HTML。

![](images/build-your-own-web-framework-vercel/img_031.jpg)![](images/build-your-own-web-framework-vercel/img_032.jpg)![](images/build-your-own-web-framework-vercel/img_033.jpg)![](images/build-your-own-web-framework-vercel/img_034.jpg)

你可以看到，这段代码本质上是增量静态再生（ISR）代码的一个子集。在此例中，我们仅调用了上一段中介绍的 `createServerlessFunction` 方法，来同时生成一个 Lambda（即无服务器）包和一个客户端（client-side）包。

With ISR, this lambda only gets invoked when a user requests a page that had been cached longer than the revalidate value. Vercel then automatically regenerates the page.

使用增量静态再生（ISR）时，该 Lambda 函数仅在用户请求一个缓存时间已超过 `revalidate` 值的页面时才会被调用。此时 Vercel 会自动重新生成该页面。

With server-side rendering, however, this function is invoked on every request. Vercel won’t automatically cache responses from this function when the page is server-rendered, resulting in unique responses every time.

然而，在服务端渲染（SSR）模式下，该函数会在每次请求时都被调用。当页面以服务端渲染方式生成时，Vercel 不会自动缓存该函数的响应，因此每次请求都会返回唯一的响应。

Now that we’re supporting the rendering techniques, let’s see how to implement Image Optimization.

既然我们已支持多种渲染技术，接下来让我们看看如何实现图片优化（Image Optimization）。

## Automatic Image Optimization

## 自动图片优化

Vercel can [automatically optimize images](https://vercel.com/docs/concepts/image-optimization) by pointing the image src to `/_vercel/image?url=`  and adding the necessary configuration. For our framework, we'll add support for a `vercel.config.js` file, where the Image Optimization configuration can be defined.

Vercel 可通过将图片的 `src` 属性指向 `/_vercel/image?url=` 并添加必要的配置，[自动优化图片](https://vercel.com/docs/concepts/image-optimization)。在我们的框架中，我们将支持 `vercel.config.js` 配置文件，以便定义图片优化的相关配置。

Let’s make it easy for our users to use optimized images by exporting an `Image` component. This component ensures that the src point to the `/_vercel/image` path and adds the necessary height and width to serve the correct image size based on the viewport.

让我们通过导出一个 `Image` 组件，使用户能更便捷地使用经过优化的图片。该组件确保 `src` 指向 `/_vercel/image` 路径，并自动添加必需的 `height` 和 `width` 属性，从而根据视口尺寸提供合适尺寸的图片。

```javascript
export const Image = (props) => {

2  return  (

3    <img

4      {...props}
```

5      ref={ref}

5      ref={ref}

6      width={props.width}

6      width={props.width}

7      height={props.height}

7      height={props.height}

8      src={`/_vercel/image?url=${encodeURIComponent(props.src)}&w=${props.width}&q=75`}

8      src={`/_vercel/image?url=${encodeURIComponent(props.src)}&w=${props.width}&q=75`}

9   />

9   />

10  )

10  )

11}
```

11}
```

You can now import the `Image` component and use it like a regular `img` tag. The only part required is some configuration in the `vercel.config.js` file, such as the domain if it’s an external domain, the image size, and the modern image format we want to use. This file is used by our framework and outputs its contents to `.vercel/output/config.json`.

现在，您可以导入 `Image` 组件，并像使用普通 `img` 标签一样使用它。唯一需要的配置位于 `vercel.config.js` 文件中，例如：若图片来自外部域名，则需指定该域名；还需设置图片尺寸以及我们希望使用的现代图片格式。该文件由我们的框架读取，并将其内容输出至 `.vercel/output/config.json`。

`vercel.config.json`

`vercel.config.json`

```javascript
export default {
```

2  images: {

3    domains: [...],

4    sizes: [...],

5    minimumCacheTTL: 60,

6    formats: [\
\
7      "image/webp",\
\
8      "image/avif"\
\
9    ]

10  }

11}
```

添加此配置后，所有使用我们自定义 `Image` 组件的图片均可受益于 Vercel 提供的自动图片优化（Automatic Image Optimization）功能。

## Conclusion

## 结论

现在，我们已具备支持渲染模式及优化图片所需的各项方法，接下来便可遍历 `pages` 目录，并调用相应函数来生成所需文件。同时，我们还会将项目 `public` 文件夹中的所有静态文件（例如图片、CSS 和 JavaScript 文件）复制到 `.vercel/output/static` 文件夹中，并依据项目的 `vercel.config.js` 文件生成 `.vercel/output/config.json` 文件。

```javascript
async function buildVercelOutput() {

async function buildVercelOutput() {

2  ...

2  ...

3  await Promise.allSettled(

3  await Promise.allSettled(

4    getRoutes().map(async (filePath) => {

4    getRoutes().map(async (filePath) => {

5      const { pageConfig, default: Component } = await import(filePath);



5      const { pageConfig, default: Component } = await import(filePath);



7      switch (pageConfig.strategy) {

7      switch (pageConfig.strategy) {

8        case "static":

8        case "static":

9          return createStaticFile(Component, filePath);

9          return createStaticFile(Component, filePath);

10        case "prerender":
10        case "prerender":
```

11          return createPrerender(Component, filePath, pageConfig);

11          返回 `createPrerender(Component, filePath, pageConfig)`；

12        case "ssr":

12        情况为 `"ssr"`：

13          return createServerlessFunction(Component, filePath);

13          返回 `createServerlessFunction(Component, filePath)`；

14        case "edge":

14        情况为 `"edge"`：

15          return createEdgeFunction(Component, filePath);

15          返回 `createEdgeFunction(Component, filePath)`；

17        default:

17        默认情况：

18          return;

18          返回；

19      }

19      }

20    })

20    })

21  );

21  )；

23  await copy("public", ".vercel", "output", "static")

23  await copy("public", ".vercel", "output", "static")

25  return writeJSON(".vercel/output/config.json", {

25  return writeJSON(".vercel/output/config.json", {

26    ...(require(process.cwd() + "/vercel.config.js").default),

26    ...(require(process.cwd() + "/vercel.config.js").default),

27    ...{

27    ...{

28      version: 3,

28      version: 3，

29      routes: getTransformedRoutes({

29      routes: getTransformedRoutes({

30         cleanUrls: true

30         cleanUrls: true

31      }).routes,

31      }).routes,

32    },

32    },

33  });

33  });

34  ...

34  ...

35}
```

35}
```

When invoking this method, we can create a valid `.vercel/output` folder that allows us to deploy to Vercel, using some of the cutting-edge features that the platform provides.

调用此方法时，我们可以创建一个有效的 `.vercel/output` 文件夹，从而利用平台提供的部分前沿功能将应用部署到 Vercel。

When using modern frameworks such as [Next.js](https://vercel.com/solutions/nextjs), we luckily don’t have to worry about implementing all these steps since the optimizations are provided out of the box.

在使用 [Next.js](https://vercel.com/solutions/nextjs) 等现代框架时，幸运的是我们无需手动实现所有这些步骤，因为相关优化已开箱即用。

However, if you’re an independent developer that wants to benefit from the platform’s features or a framework author that’s looking to integrate with Vercel, the [Build Output API](https://vercel.com/docs/build-output-api) makes it easy to build any project on Vercel.

然而，如果你是一位希望充分利用平台特性的独立开发者，或是一位正计划将框架与 Vercel 集成的框架作者，那么 [构建输出 API（Build Output API）](https://vercel.com/docs/build-output-api) 将使你在 Vercel 上构建任意项目变得轻而易举。

Although it should be clear that this framework should not be used in production—it just does the bare minimum and can be optimized—it’s good to see how modern frameworks make development so much easier.

尽管显而易见，该框架不应直接用于生产环境——它仅实现了最基本的功能，且仍有大量优化空间——但看到现代框架如何极大简化开发流程，仍令人倍感欣慰。

The code is available in [this GitHub Repo](https://github.com/lydiahallie/byof-demo) to see the demo implementation covered in this article. If you’d like another example of using the Build Output API, check out [Astro](https://github.com/withastro/astro/tree/main/packages/integrations/vercel), a framework that has successfully integrated with Vercel.

本文所涵盖的演示实现代码已开源，详见 [GitHub 仓库](https://github.com/lydiahallie/byof-demo)。如需了解 Build Output API 的另一示例，可参考 [Astro](https://github.com/withastro/astro/tree/main/packages/integrations/vercel) —— 一个已成功与 Vercel 集成的框架。
{% endraw %}
