---
title: "10 Next.js tips you might not know - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/10-next-js-tips-you-might-not-know"
date: "2021-01-26"
scraped_at: "2026-03-02T10:05:58.384677709+00:00"
language: "en-zh"
translated: true
description: "Discover 10 expert Next.js tips including redirects, rewrites, preview mode, API routes, and performance optimizations to boost your development workflow. "
---
&#123;% raw %}

Jan 26, 2021

2021年1月26日

来自 Next.js 专家的实用技巧，助您提升应用开发效率。

以下是 10 个鲜为人知但可能帮您在下一个项目中节省大量时间的 Next.js 实用技巧：

- [**Next.js 重定向（Redirects）**](https://vercel.com/blog/10-next-js-tips-you-might-not-know#tip-1-next.js-redirects)

- [**Next.js 重写规则（Rewrites）**](https://vercel.com/blog/10-next-js-tips-you-might-not-know#tip-2-next.js-rewrites)

- [**Next.js 预览模式（Preview Mode）**](https://vercel.com/blog/10-next-js-tips-you-might-not-know#tip-3-next.js-preview-mode)

- [**接入构建流程（Hooking Into the Build Process）**](https://vercel.com/blog/10-next-js-tips-you-might-not-know#tip-4-hooking-into-the-build-process)

- [**使用 Preact 替代 React 运行 Next.js**](https://vercel.com/blog/10-next-js-tips-you-might-not-know#tip-5-next.js-with-preact)

- [**绝对路径导入与模块路径别名（Absolute Imports and Module Path Aliases）**](https://vercel.com/blog/10-next-js-tips-you-might-not-know#tip-6-absolute-imports-and-module-path-aliases)

- [**CRUD 风格的 API 路由（CRUD API Routes）**](https://vercel.com/blog/10-next-js-tips-you-might-not-know#tip-7-crud-api-routes)

- [**Setting Response HTTP Caching Headers**](https://vercel.com/blog/10-next-js-tips-you-might-not-know#tip-8-setting-response-http-caching-headers)  
- [**设置响应 HTTP 缓存头**](https://vercel.com/blog/10-next-js-tips-you-might-not-know#tip-8-setting-response-http-caching-headers)

- [**Shared Component Attributes**](https://vercel.com/blog/10-next-js-tips-you-might-not-know#tip-9-shared-component-attributes)  
- [**共享组件属性**](https://vercel.com/blog/10-next-js-tips-you-might-not-know#tip-9-shared-component-attributes)

- [**Next.js Mobile Applications?**](https://vercel.com/blog/10-next-js-tips-you-might-not-know#tip-10-next.js-mobile-applications)  
- [**Next.js 能开发移动应用吗？**](https://vercel.com/blog/10-next-js-tips-you-might-not-know#tip-10-next.js-mobile-applications)


Vercel's Lee Robinson gives a quick overview on 10 little known tips on Next.js  
Vercel 公司的 Lee Robinson 简要介绍了 10 个鲜为人知的 Next.js 使用技巧。

## Tip 1: Next.js Redirects  

## 技巧 1：Next.js 重定向  

[Next.js Redirects](https://nextjs.org/docs/api-reference/next.config.js/redirects) are new to version 9.5 (released in July 2020) and give the ability to reroute an incoming request path to another destination.  
[Next.js 重定向](https://nextjs.org/docs/api-reference/next.config.js/redirects) 是自 9.5 版本（2020 年 7 月发布）起新增的功能，支持将传入请求路径重新路由至其他目标地址。

Path matching, regex path matching, and wildcard paths are all valid ways to reroute your source path. Use the `redirects` key to create an asynchronous function that will return an array of objects where each object contains the properties for a redirect in the application.  
路径匹配、正则表达式路径匹配以及通配符路径，都是合法的源路径重路由方式。请使用 `redirects` 配置项定义一个异步函数，该函数需返回一个对象数组，其中每个对象均包含应用中某条重定向规则所需的各项属性。

next.config.js  

next.config.js  

```javascript
module.exports = {

2  async redirects() {

3    return [\
\
4      {\
\
5        source: '/about',\
\
6        destination: '/',\
\
7        permanent: true,\
\
8      },\
\
9    ]

10  },

11}


```

如需更多使用示例，请参阅此 [next.config.js](https://github.com/vercel/next.js/blob/canary/examples/redirects/next.config.js) 文件。

## Tip 2: Next.js 重写（Rewrites）

[重写（Rewrites）](https://nextjs.org/docs/api-reference/next.config.js/rewrites) 同样是在 Next.js 9.5 版本中引入的功能，其工作方式与重定向（redirects）类似。区别在于：重定向会通过 301/302 状态码将页面重新路由；而重写则充当代理，对新路径进行隐藏（mask），使用户感觉并未离开当前站点位置。

重写的规则与重定向基本一致，但有一个关键限制：重写无法覆盖 `public` 目录下的静态文件，也无法覆盖由 `pages` 文件夹自动生成的路由——这些路由的优先级始终高于重写规则。

next.config.js

```javascript
module.exports = {

2  async rewrites() {

2  异步重写函数 `rewrites()` {

3    return [\
\
3    返回 [\
\
4      {\
\
4      {\
\
5        source: '/about',\
\
5        源路径：'/about',\
\
6        destination: '/',\
\
6        目标路径：'/',\
\
7      },\
\
7      },\
\
8    ]

8    ]

9  },

9  },

10}

10}

```

To take a look at how rewrites look using regex or wildcard paths, take a look at this [next.config.js](https://github.com/vercel/next.js/blob/canary/examples/rewrites/next.config.js) file.

```

如需了解如何使用正则表达式（regex）或通配符路径（wildcard paths）配置重写规则，请参阅此 [next.config.js](https://github.com/vercel/next.js/blob/canary/examples/rewrites/next.config.js) 文件。

## Tip 3: Next.js Preview Mode

## 技巧 3：Next.js 预览模式（Preview Mode）

[Preview Mode](https://vercel.com/docs/next.js/preview-mode) allows you to see a draft of your statically-generated content prior to publishing it to the web. Next.js has the ability to generate these draft pages at request time instead of build time so that developers can see what their content will look like when published.

[预览模式（Preview Mode）](https://vercel.com/docs/next.js/preview-mode) 允许你在将静态生成的内容发布到 Web 前，先行预览其草稿版本。Next.js 支持在请求时（request time）而非构建时（build time）动态生成这些草稿页面，使开发者能够直观地看到内容正式发布后的实际效果。

Take a look at the Next.js [Preview Mode documentation](https://nextjs.org/docs/advanced-features/preview-mode) for detailed information on how to build this out or test out Preview Mode before constructing it on your own with this [example Vercel application](https://next-preview.vercel.app/).

请查阅 Next.js 官方 [预览模式文档](https://nextjs.org/docs/advanced-features/preview-mode)，获取详细实现指南；你也可以先通过这个 [示例 Vercel 应用](https://next-preview.vercel.app/) 体验预览模式功能，再着手自行构建。

## Tip 4: Hooking into the Build Process

## 技巧 4：接入构建流程（Hooking into the Build Process）

With Next.js, we can use the `next.config.js` file to override defaults, configure Webpack, or inject code into the build process. By running a script during the build process to inject code, Next.js can create a [sitemap](https://leerob.io/blog/nextjs-sitemap-robots), RSS feed, or a search index with ease.

借助 Next.js，我们可以使用 `next.config.js` 文件来覆盖默认配置、配置 Webpack，或在构建过程中注入代码。通过在构建过程中运行脚本以注入代码，Next.js 可轻松生成[站点地图（sitemap）](https://leerob.io/blog/nextjs-sitemap-robots)、RSS 源（feed）或搜索索引。

## Tip 5: Next.js With Preact

## 小贴士 5：Next.js 与 Preact 结合使用

If you’re building a basic Next.js application and not using advanced React functionality, you can explore using Preact with Next.js. For more information about Preact, check our their [documentation](https://preactjs.com/).

如果你正在构建一个基础的 Next.js 应用，且未使用 React 的高级功能，可以尝试将 Preact 与 Next.js 结合使用。有关 Preact 的更多信息，请参阅其[官方文档](https://preactjs.com/)。

You can use Preact only in the client production build so you don’t miss any features of the Next.js local development experience. Use `next.config.js` to override the default Webpack configuration and use Preact.

你只需在客户端生产构建（client production build）中使用 Preact，即可确保不丢失 Next.js 本地开发体验中的任何功能。通过 `next.config.js` 覆盖默认的 Webpack 配置，从而启用 Preact。

New features in React may not be compatible with Preact (i.e. Suspense or Server Components) .

React 的新特性可能与 Preact 不兼容（例如 Suspense 或服务端组件 Server Components）。

next.config.js

next.config.js

```javascript
module.exports = {

2  webpack: (config, { dev }) => {

3    // Replace React with Preact only in client production build

4    if (!dev) {
```

5      Object.assign(config.resolve.alias, {

5      Object.assign(config.resolve.alias, {

6        react: 'preact/compat',

6        react: 'preact/compat',

7        'react-dom/test-utils': 'preact/test-utils',

7        'react-dom/test-utils': 'preact/test-utils',

8        'react-dom': 'preact/compat'

8        'react-dom': 'preact/compat'

9      });

9      });

10    }

10    }

12    return config;

12    return config;

13  }

13  }

14};

14};

## Tip 6: Absolute Imports and Module Path Aliases

## 技巧 6：绝对导入与模块路径别名

As your application grows, you might end up with deeply nested import statements. To prevent the import statements’ relative paths from becoming excessive, you can use [Absolute Imports and Module Path Aliases](https://nextjs.org/docs/advanced-features/module-path-aliases) to make them more readable.

随着应用规模扩大，你可能会遇到深度嵌套的导入语句。为避免相对路径过长、难以维护，你可以使用 [绝对导入与模块路径别名](https://nextjs.org/docs/advanced-features/module-path-aliases)，使导入语句更清晰易读。

This, for example, will turn:

例如，这可以将：

```javascript
import Button from “../../../components/button”;
```

to:

转换为：

```javascript
import Button from “@/components/button”;
```

It creates a much shorter string that is easier to read. Now instead of being an import with a relative path, it is an absolute import.

它生成了一个更简短、更易读的字符串；此时导入不再依赖相对路径，而是采用绝对导入方式。

To set this up, create a JSON file. Inside this file, create a `compilerOptions` object inside a JSON object that will contain a `baseUrl` that is a string and `paths` property that is an object.

要完成此配置，请创建一个 JSON 文件。在该文件中，定义一个 JSON 对象，其内部包含一个 `compilerOptions` 对象；该对象应具有一个字符串类型的 `baseUrl` 字段，以及一个类型为对象的 `paths` 字段。

Your configuration file for absolute imports should look something like this:

你用于配置绝对导入的文件应类似如下所示：

```json
1{

2  "compilerOptions": {

3    "baseUrl": ".",

4    "paths": {

5      "@/components/*": ["components/*"]

6    }

7  }

8}
```

`baseUrl` 属性表示绝对导入的基准路径为配置文件所在的目录。  
`paths` 对象将我们用于模块别名的字符串设为键（key）。

The value is an array that contains the relative path to the folder we are wanting to make the alias. The asterisk on the end of the key and value mean that any file or directory in the components folder can follow the same convention.

该值是一个数组，其中包含我们希望创建别名的文件夹的相对路径。键和值末尾的星号（`*`）表示 `components` 文件夹中的任意文件或子目录均可遵循相同的约定。

This structure is not necessary to create your project, but is a great way to make your import statements a little easier to read.

此结构并非创建项目所必需，但它能显著提升导入语句（`import` statements）的可读性。

## Tip 7: CRUD API Routes

## 技巧 7：CRUD API 路由

CRUD stands for **C**reate, **R**ead, **U**pdate, and **D**elete — all are common HTTP methods used in an application programming interface (API) that POST, GET, PUT, and DELETE data.

CRUD 是 **C**reate（创建）、**R**ead（读取）、**U**pdate（更新）和 **D**elete（删除）的缩写——这些是应用程序编程接口（API）中常用的 HTTP 方法，分别用于提交（POST）、获取（GET）、更新（PUT）和删除（DELETE）数据。

We have the ability to build basic CRUD endpoints using the [built-in Next.js router.](https://nextjs.org/docs/routing/introduction) Create a folder inside `pages` called `api`. Inside `api` create a file with a `.js` or `.ts` extension that will contain the handler for all of our CRUD methods.

我们可以借助 [Next.js 内置的路由系统](https://nextjs.org/docs/routing/introduction) 快速构建基础的 CRUD 接口端点。在 `pages` 目录下新建一个名为 `api` 的文件夹；再在 `api` 文件夹中创建一个扩展名为 `.js` 或 `.ts` 的文件，该文件将承载我们所有 CRUD 方法的处理逻辑。

Here’s a high-level outline of how an API might look:

以下是一个 API 接口的高层级结构示例：

pages/api/item.js

```javascript
export default async function handler(req, res) {

2  if (req.method === 'PUT') {

3    res.status(201).json({});
```

4  }


4  

6  if (req.method === 'GET') {

6  如果请求方法为 GET：

7    res.status(200).json({});

7    则返回状态码 200 并以 JSON 格式响应空对象。

8  }

8  

10  if (req.method === 'POST') {

10  如果请求方法为 POST：

11    res.status(200).json({});

11    则返回状态码 200 并以 JSON 格式响应空对象。

12  }

12

14  if (req.method === 'DELETE') {

14  如果请求方法为 'DELETE'：

15    res.status(204).json({});

15    res.status(204).json({});

16  }

16  }

17}

17}


```

The actual setup used to define these endpoints may vary depending on how the app is constructed.

```
实际用于定义这些端点的配置方式，可能因应用的具体构建方式而异。


## Tip 8: Setting Response HTTP Caching Headers

## 技巧 8：设置响应的 HTTP 缓存头（Cache-Control Headers）

For static pages, the [Vercel Edge Network](https://vercel.com/docs/edge-network/overview) will automatically [cache](https://vercel.com/docs/edge-network/caching) static assets in order to serve data as fast as possible. When there is a need to use an API Route or Server-Side Rendered page, though, you will need to set a `Cache-Control` header.

对于静态页面，[Vercel 边缘网络（Vercel Edge Network）](https://vercel.com/docs/edge-network/overview) 会自动[缓存（cache）](https://vercel.com/docs/edge-network/caching)静态资源，以尽可能快地提供数据。但当你需要使用 API 路由（API Route）或服务端渲染页面（Server-Side Rendered page）时，则必须手动设置 `Cache-Control` 响应头。

Here’s an example API Route that sends a JSON response and caches that response for one day:

以下是一个发送 JSON 响应并将其缓存一天的 API 路由示例：

pages/api/user.js

```javascript
export default function handler(req, res){

2  res.setHeader(

3    'Cache-Control',

4    's-maxage=86400'

5  );

6  res.status(200).json({name: ‘John Doe’ });

7};
```

## Tip 9: Shared Component Attributes

## 技巧 9：共享组件属性

When working with Next.js applications, sometimes there is a need to share information between pages. This is done by creating a [\_app.js](https://nextjs.org/docs/advanced-features/custom-app) file in the pages folder.

在开发 Next.js 应用时，有时需要在不同页面之间共享信息。这可通过在 `pages` 文件夹中创建一个 [`_app.js`](https://nextjs.org/docs/advanced-features/custom-app) 文件来实现。

pages/index.js

pages/index.js

```javascript
Home.title = "test"

Home.title = "测试"

Home.description = "A container for blog posts"

Home.description = "一个用于博客文章的容器"

export default function Home() {

export default function Home() {

5    return (

5    返回（

6        <Container>

6        <Container>

7            <Blogpost />

7            <Blogpost />

8        </Container>

8        </Container>

9    )

9    ）

10}
```

pages/_app.js

```javascript
import Head from 'next/head'



export default function App({ Component, pageProps }) {

4  return (

5    <>

6      <Head>

7        <title>{Component.title}</title>

8        <meta name="description" content={Component.description} />

9      </Head>
```

pages/_app.js

```javascript
import Head from 'next/head'



export default function App({ Component, pageProps }) {

4  return (

5    <>

6      <Head>

7        <title>{Component.title}</title>

8        <meta name="description" content={Component.description} />

9      </Head>
```

10      <Component {...pageProps} />

10      `<Component {...pageProps} />`

11    </>

11    `</>`

12  )

12  `)`

13}
```

13}
```

This is just one way to take advantage of the customized app. There are several different things a developer can do when creating a custom app including global CSS, shared layout, maintain state, and more.

这仅仅是利用自定义应用的一种方式。开发者在创建自定义应用时，可执行多种不同操作，例如引入全局 CSS、共享布局、状态管理等。

## Tip 10: Next.js Mobile Applications?

## 小贴士 10：Next.js 能开发移动应用吗？

You can create a mobile app with Next.js? How is that possible!?

用 Next.js 能开发移动应用？这怎么可能！

Thanks to the Ionic team, you can build mobile-like experiences using Next.js. They are the creator of CapacitorJS, a library that will give you a native-like experience on your mobile phone.

多亏了 Ionic 团队，你得以借助 Next.js 构建类原生的移动应用体验。Ionic 是 CapacitorJS 的创造者——这是一个能让你的移动设备获得接近原生体验的开源库。

![The Mobile Stack Visualized](images/10-next_js-tips-you-might-not-know-vercel/img_001.jpg)The Mobile Stack Visualized

![移动技术栈可视化示意图](images/10-next_js-tips-you-might-not-know-vercel/img_001.jpg)移动技术栈可视化示意图

Learn more about Ionic's Next.js/Tailwind CSS/Capacitor starter [here](https://capacitorjs.com/blog/mobile-apps-with-tailwind-css-nextjs-ionic-and-capacitor).

了解更多关于 Ionic 提供的 Next.js / Tailwind CSS / Capacitor 启动模板的信息，请点击[此处](https://capacitorjs.com/blog/mobile-apps-with-tailwind-css-nextjs-ionic-and-capacitor)。

## Next Steps

## 下一步

That’s it! How many of these tips are you going to implement in your next project?

就这样！您打算在下一个项目中实践其中几条建议呢？

If you have never used Next.js before, start with this tutorial on creating [your Next.js application](https://nextjs.org/learn/).

如果您此前从未使用过 Next.js，请从这篇关于[创建您的 Next.js 应用](https://nextjs.org/learn/)的教程开始。

If you have never written any React code before, start with [React’s official tutorial](https://reactjs.org/tutorial/tutorial.html). This will help you get a firm grasp on JavaScript and React prior to using Next.js.

如果您此前从未编写过任何 React 代码，请先学习 [React 官方教程](https://reactjs.org/tutorial/tutorial.html)。这将帮助您在使用 Next.js 之前扎实掌握 JavaScript 和 React。

For the easiest way to deploy a Next.js app, start with this [introduction](https://vercel.com/docs) to Vercel. Vercel, built by the same team that made Next.js, provides production-grade hosting for Next.js websites with zero configuration.

若想以最简便的方式部署 Next.js 应用，请先阅读 Vercel 的这篇[入门指南](https://vercel.com/docs)。Vercel 由开发 Next.js 的同一支团队打造，为 Next.js 网站提供开箱即用、无需配置的生产级托管服务。
&#123;% endraw %}
