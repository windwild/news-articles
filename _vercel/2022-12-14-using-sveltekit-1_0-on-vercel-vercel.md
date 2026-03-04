---
render_with_liquid: false
title: "Using SvelteKit 1.0 on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/using-sveltekit-1-0-on-vercel"
date: "2022-12-14"
scraped_at: "2026-03-02T09:57:45.404954532+00:00"
language: "en-zh"
translated: true
description: "Using SvelteKit 1.0 on Vercel"
---
render_with_liquid: false
render_with_liquid: false

Dec 14, 2022

2022 年 12 月 14 日

As of today, December 14th, 2022, SvelteKit 1.0 has officially launched.

截至今日（2022 年 12 月 14 日），SvelteKit 1.0 已正式发布。

[SvelteKit](https://kit.svelte.dev/) is a new framework for building web applications that is gaining popularity among developers for its simplicity and performance. Built on top of Svelte (like Next.js for React), SvelteKit simplifies creating and deploying web applications. Server-side rendering, routing, code-splitting, and adapters for different serverless platforms are just a few of its out-of-the-box features.

[SvelteKit](https://kit.svelte.dev/) 是一个用于构建 Web 应用的新框架，凭借其简洁性与高性能，正日益受到开发者的青睐。它基于 Svelte 构建（类似于 React 生态中的 Next.js），大幅简化了 Web 应用的开发与部署流程。服务端渲染（SSR）、路由、代码分割（code-splitting），以及针对各类无服务器（serverless）平台的适配器（adapters），仅仅是其开箱即用功能中的一小部分。

[Deploying SvelteKit 1.0 today](https://vercel.com/templates/svelte/sveltekit-boilerplate) or continue reading to learn about the improvements to the framework in the past year and the benefits of deploying SvelteKit projects on Vercel.

[立即部署 SvelteKit 1.0](https://vercel.com/templates/svelte/sveltekit-boilerplate)，或继续阅读，了解该框架在过去一年中的重要改进，以及在 Vercel 上部署 SvelteKit 项目的诸多优势。

## What is SvelteKit?

## 什么是 SvelteKit？

SvelteKit is built around the Svelte framework, a modern JavaScript compiler that allows developers to write efficient and lightweight code. Instead of using runtime frameworks to stack user interfaces on top of the DOM, Svelte compiles components at build time down to a native JavaScript bundle. This results in fast web apps with small bundle sizes.

SvelteKit 基于 Svelte 框架构建；Svelte 是一款现代 JavaScript 编译器，使开发者能够编写高效且轻量的代码。不同于依赖运行时框架将用户界面层层叠加在 DOM 之上的传统方式，Svelte 在构建阶段便将组件编译为原生 JavaScript 包。由此生成的 Web 应用不仅加载迅速，而且包体积极小。

SvelteKit solves many common issues faced by web developers by providing an intuitive experience that takes care of tedious configuration and boilerplate code. Additionally, instead of retrieving the entire application on initial load, SvelteKit makes it easy to split your code into reusable chunks that can be quickly loaded on demand, allowing for snappy user and developer experiences alike.

SvelteKit 通过提供直观易用的开发体验，自动处理繁琐的配置与样板代码，从而解决了 Web 开发者面临的诸多常见问题。此外，它不再要求在首次加载时获取整个应用，而是轻松支持将代码拆分为可复用的模块，并按需快速加载，从而同时提升终端用户的交互体验与开发者的开发效率。

SvelteKit extends Svelte by adding:

SvelteKit 在 Svelte 基础上进行了扩展，新增了以下能力：

- Server-side rendering (SSR), which can improve the performance and SEO of your application

- 服务端渲染（SSR），可显著提升应用性能与搜索引擎优化（SEO）效果

- Easy generation of static sites, which can be useful for blogs, marketing sites, and other types of content-heavy websites

- 简单便捷的静态站点生成能力，适用于博客、营销页面及其他内容密集型网站

- TypeScript support

- 支持 TypeScript

- Hot Module Replacement, allowing you to update your application in real-time without losing state or refreshing the page

- 热模块替换（Hot Module Replacement），允许你在不丢失应用状态、也不刷新页面的情况下实时更新应用。

## SvelteKit Features

## SvelteKit 的特性

SvelteKit is great for building applications of all sizes, with a fluid developer experience to match. It doesn't compromise on SEO, progressive enhancement, or the initial load experience, but unlike traditional server-rendered apps, navigation is instantaneous. SvelteKit comes with an abundance of out-of-the-box features, making it the recommended way to build Svelte applications. Let’s take a look:

SvelteKit 非常适合构建各种规模的应用，同时提供流畅的开发者体验。它在搜索引擎优化（SEO）、渐进式增强（progressive enhancement）以及首屏加载体验上均不妥协；但与传统的服务端渲染应用不同，SvelteKit 中的页面导航是瞬时完成的。SvelteKit 内置了大量开箱即用的功能，因此被推荐为构建 Svelte 应用的首选方式。下面我们来逐一了解：

- **Directory-based Router:**

- **基于目录的路由器：**

SvelteKit includes a directory-based router that updates the page contents after intercepting navigations. This means that the folder structure of the `/src/routes` folder is going to be the route structure of our application. So for example, `/src/routes/+page.svelte` creates the root route, and `/src/routes/about/+page.svelte` creates a an `/about` route. To learn more about routing in SvelteKit, checkout Vercel’s [Beginner SvelteKit](https://vercel.com/docs/beginner-sveltekit/routing) course.

SvelteKit 内置了一个基于目录的路由器，它会在拦截导航后动态更新页面内容。这意味着 `/src/routes` 目录的文件夹结构将直接映射为应用的路由结构。例如，`/src/routes/+page.svelte` 对应根路径 `/`，而 `/src/routes/about/+page.svelte` 则对应 `/about` 路由。如需深入了解 SvelteKit 的路由机制，欢迎学习 Vercel 提供的 [入门级 SvelteKit 教程](https://vercel.com/docs/beginner-sveltekit/routing)。

- **Layouts:**

- **布局（Layouts）：**

If you need an element displayed on multiple pages of an application, such as a header or a footer, you can use layouts. To create layouts in SvelteKit, add a file called `+layout.svelte` in the `/routes` folder. You can add whatever markup, styles, and behavior you want to this file, and it will be applied to all pages in the app. You can even make nested and grouped layouts to target only specific routes.

若需在应用的多个页面中复用某个元素（例如页眉或页脚），可使用布局（Layout）功能。在 SvelteKit 中创建布局，只需在 `/routes` 目录下添加一个名为 `+layout.svelte` 的文件即可。你可以在该文件中自由编写任意 HTML 标记、CSS 样式和交互逻辑，其内容将自动应用于应用中的所有页面。你甚至可以创建嵌套布局或分组布局，以精准控制其仅作用于特定路由。

- **The** **`load`** **function:**

- **`load` 函数：**

SvelteKit has a unique way of loading page data using the `load` function. All `+page.svelte` files can have a sibling `+page.js` file that exports a `load` function. The returned value of this is available to the page via the `data` prop. The load function runs on both the client and server, but you can add the extension `+page.server.js` to make it run on the server only.

SvelteKit 采用一种独特的方式——通过 `load` 函数来加载页面数据。每个 `+page.svelte` 文件均可配有一个同名的 `+page.js` 文件，其中导出一个 `load` 函数。该函数的返回值将通过 `data` 属性传递给对应的页面组件。`load` 函数默认在客户端和服务端均会执行；若仅需在服务端运行，可将文件重命名为 `+page.server.js`。

- **Layout Data:**

- **布局数据：**

All `+layout.svelte` files can also have a sibling `+layout.js` file that loads data using the `load` function. In addition to the layout it ‘belongs’ to, data returned from layout `load` functions is also available to all child `+layout` and `+page` files.

所有 `+layout.svelte` 文件还可配有一个同级的 `+layout.js` 文件，通过 `load` 函数加载数据。除所属的布局外，由布局 `load` 函数返回的数据还可被其所有子级 `+layout` 和 `+page` 文件访问。

- **Endpoints:**

- **端点（Endpoints）：**

As well as pages, you can define routes with a `+server.js` file (also referred to as an 'API route' or an 'endpoint'), which gives you full control over the response. These files export functions corresponding to HTTP verbs that that take a [Request Event](https://kit.svelte.dev/docs/types#public-types-requestevent) argument and return a [Response](https://developer.mozilla.org/en-US/docs/Web/API/Response) object.

除了页面外，你还可以通过 `+server.js` 文件（也称为“API 路由”或“端点”）定义路由，从而完全掌控响应内容。此类文件导出与 HTTP 动词相对应的函数，这些函数接收一个 [Request Event](https://kit.svelte.dev/docs/types#public-types-requestevent) 参数，并返回一个 [Response](https://developer.mozilla.org/en-US/docs/Web/API/Response) 对象。

- **Adapters:**

- **适配器（Adapters）：**

An adapter is a plugin that takes your app as input during build and generates output suitable for deployment on a specific platform. By default, projects are configured to use `@sveltejs/adapter-auto`, which detects your production environment and automatically selects the appropriate adapter for you.

适配器是一种插件，在构建阶段接收你的应用作为输入，并生成适用于特定平台部署的输出。默认情况下，项目配置为使用 `@sveltejs/adapter-auto`，该适配器可自动检测你的生产环境，并为你自动选择最合适的适配器。

To learn more about SvelteKit's features in depth, check out Vercel's free [Beginner SvelteKit](https://vercel.com/docs/beginner-sveltekit) course.

如需深入了解 SvelteKit 的各项功能，请查阅 Vercel 提供的免费课程：[SvelteKit 入门指南](https://vercel.com/docs/beginner-sveltekit)。

## What’s changed in the past 12 months

## 过去 12 个月中的主要变更

As the Svelte team, including the core team members at Vercel, have worked hard to prepare for the stable SvelteKit 1.0 release, some necessary breaking changes had to be made. If you’ve used SvelteKit in the past, it may look quite different today. Let’s go over the most notable changes made to SvelteKit in the last year.

Svelte 团队（包括 Vercel 的核心团队成员）为推进 SvelteKit 1.0 稳定版的发布付出了大量努力，过程中不可避免地引入了一些必要的破坏性变更。如果你此前曾使用过 SvelteKit，那么如今它可能已大不相同。接下来，我们梳理过去一年中 SvelteKit 最显著的几项变更。

## New Directory-based Routing

## 新的基于目录的路由系统

Changing SvelteKit’s file-based routing is by far one of the biggest updates made to SvelteKit.  
SvelteKit 的文件式路由机制的变更，无疑是 SvelteKit 历史上最重要的更新之一。

Previously, any file added to the `routes` directory would automatically create a route at that name. For example, creating the page `routes/about.svelte` would automatically create a page at `/about`, and `routes/index.svelte` would create our root page.  
此前，只要在 `routes` 目录中添加任意文件，系统便会自动为其生成同名路由。例如，创建页面 `routes/about.svelte` 会自动生成 `/about` 路由；而 `routes/index.svelte` 则会生成根路径（`/`）页面。

Now, all routes are directory based and the old `index.svelte` has been replaced by `+page.svelte`. This new convention ensures that you are deliberately creating a route, and eliminates the need of underscores in order to colocate files. With this new convention, the page at the route `/about` will be `routes/about/+page.svelte` and our root page will be `routes/+page.svelte`.  
如今，所有路由均基于目录结构，旧有的 `index.svelte` 已被 `+page.svelte` 取代。这一新约定确保了路由的创建是显式且有意为之的，同时消除了过去为实现文件共置（colocation）而依赖下划线前缀（如 `_nonPageRoute.js`）的需要。遵循此新约定，`/about` 路由对应的页面文件应为 `routes/about/+page.svelte`，而根页面则位于 `routes/+page.svelte`。

**Old File-based routing**  
**旧版文件式路由**

```json
src

2└ routes

3	├ dashboard/

4	│ ├ index.svelte

5	│ └ _nonPageRoute.js

6	├ about.svelte

7	└ index.svelte
```

**New Directory-based routing**  
**新版目录式路由**

```text
src

2└ routes

3	├ dashboard/

4	│ ├ +page.svelte

5	│ └ nonPageRoute.js

6	├ about/

7	│ └ +page.svelte

8	└ +page.svelte
```

了解更多关于 [SvelteKit 的路由机制](https://vercel.com/docs/beginner-sveltekit/routing)。

## 新的布局系统

## New Layouts System

With the new routing changes came major changes to the layouts system as well.  
随着新的路由变更，布局系统也发生了重大变化。

Instead of naming our layout files `__layout.svelte` we now name them `+layout.svelte` similar to our pages.  
过去我们命名布局文件为 `__layout.svelte`，现在则统一改为 `+layout.svelte`，与页面文件的命名方式保持一致。

Previously, we could have multiple layouts in a single directory using named layouts, such as `index@about.svelte`, which we have since said goodbye to 👋.  
此前，我们可通过“命名布局”（如 `index@about.svelte`）在单个目录中定义多个布局；如今这一功能已被正式移除 👋。

In addition to the changes, a new grouped layouts convention was added.  
除上述变更外，SvelteKit 新增了“分组布局”（grouped layouts）约定。

This allows us to share layouts within group directories, which are folders wrapped in parentheses.  
该约定允许我们在“分组目录”（即名称用圆括号括起的文件夹）内共享布局。

Group directories do not affect the pathname of nested routes, but acts as a root route for layouts.  
分组目录不会影响其内部嵌套路由的路径名，但会作为布局作用域的根路由。

To learn more about SvelteKit’s layouts checkout the Beginner SvelteKit course [here](https://vercel.com/docs/beginner-sveltekit/layouts).  
如需深入了解 SvelteKit 的布局机制，请参阅入门级 SvelteKit 课程：[此处](https://vercel.com/docs/beginner-sveltekit/layouts)。

**Old layouts system**  
**旧版布局系统**

```text
src

2└ routes

3	├ dashboard/

4	│ └ index@dashboard.svelte

5	├ about/

6	│ ├ index.svelte

7	│ └ testimonials/
```

8	│    ├ index.svelte

8	│    ├ index.svelte

9	│    └ __layout.svelte

9	│    └ __layout.svelte

10	├ __layout-dashboard.svelte

10	├ __layout-dashboard.svelte

11	└ __layout.svelte

11	└ __layout.svelte

```

**New layouts system**

```

**全新的布局系统**

```text
src

2└ routes

3  │ (app)/

4	│ ├ dashboard/

5	│ ├ item/

```text
src

2└ routes

3  │ (app)/

4	│ ├ dashboard/

5	│ ├ item/

6	│ └ +layout.svelte

6	│ └ +layout.svelte

7	│ (marketing)/

7	│ (marketing)/

8	│ ├ about/

8	│ ├ about/

9	│ ├ testimonials/

9	│ ├ testimonials/

10	│ └ +layout.svelte

10	│ └ +layout.svelte

11	├ admin/

11	├ admin/

12	└ +layout.svelte

12	└ +layout.svelte

```

Learn more about [SvelteKit's layouts](https://vercel.com/docs/beginner-sveltekit/layouts).

了解更多关于 [SvelteKit 的布局（layouts）](https://vercel.com/docs/beginner-sveltekit/layouts)。

## Loading Data

## 加载数据

Previously, the `load` function would be called in a page component’s `context="module"` script block, and the returned data would become available to the page as a prop. A page calling the load function would look something like this:

此前，`load` 函数需在页面组件的 `context="module"` 脚本块中调用，其返回的数据将作为属性（prop）提供给该页面。一个调用 `load` 函数的页面大致如下所示：

```html
1<script context="module">

1<script context="module">

2  export async function load() {

2  export async function load() {

3    const product = 'some data';

3    const product = 'some data';

4    return {

4    return {

5      props: {

5      props: {

6        product: product.data,

6        product: product.data,

7      },

7      },

8    };

8    };

9  }

9  }

10</script>

10</script>
```

12<script>

12<script>

13  export let product;

13  export let product;

14</script>
```

14</script>
```

Now, SvelteKit has completely gotten rid of the `context="module"`, and the `load` function has moved into the endpoint file. Our `+page.svelte` can automatically load the data from a `+page.js` route by exporting the strongly-typed `data` prop. Just like before, the `load` function runs on both the client and server. If you only want it to run on the server, you can add the `.server` extension (`+page.server.js`). Loading data into a page the new way looks like this:

现在，SvelteKit 已完全移除了 `context="module"`，而 `load` 函数已迁移至端点文件中。我们的 `+page.svelte` 可通过导出强类型的 `data` 属性，自动从 `+page.js` 路由加载数据。与之前一样，`load` 函数既在客户端也在服务端执行。若仅希望它在服务端运行，可添加 `.server` 后缀（即使用 `+page.server.js`）。采用新方式为页面加载数据如下所示：

+page.js

+page.js

```javascript
export const load = () => {

```javascript
export const load = () => {

2  let product = "some data"

2  let product = "some data"

3  return {

3  return {

4    product

4    product

5  }

6}
```

```html
1<!--+page.svelte-->

2<script>

3  /** @type {import('./$types').PageData} */

4  export let data; // this is typed as `{ product: string }`!

5</script>



7<h1>This is our data: {data}</h1>
```

如需了解更多关于 [SvelteKit 的数据获取](https://vercel.com/docs/beginner-sveltekit/loading) 的信息。

## ) **Server routes (Endpoints)**

## ) **服务器路由（端点）**

Previously, to create an endpoint, you would add a `.js` (or `.ts`) file somewhere into `src/routes`, and include the data type it was meant to return as part of the name of that file. For example: if you wanted to return some data as JSON at the path `/api/about.json`, you could simply add an `about.json.js` file into your routes folder like this:

之前，要创建一个端点，需在 `src/routes` 目录下的任意位置添加一个 `.js`（或 `.ts`）文件，并将该文件预期返回的数据类型作为文件名的一部分。例如：若希望在路径 `/api/about.json` 下以 JSON 格式返回某些数据，则只需在 routes 文件夹中添加一个名为 `about.json.js` 的文件，如下所示：

```text
src/

2└ routes/

3    └ about.json.js
```

```text
src/

2└ routes/

3    └ about.json.js
```

Now, instead of adding server routes directly in the routes directory, we instead add them in the `/routes/api` directory. The new way of creating an endpoint is more similar to creating a page. Instead of simply adding the file `about.json.js` within this directory, we add a `+server.js` file within an about `folder` like this:

现在，我们不再直接在 `routes` 目录下添加服务器路由，而是将其添加到 `/routes/api` 目录中。创建端点的新方式更类似于创建页面：不再是在该目录下简单地添加 `about.json.js` 文件，而是在一个名为 `about` 的子目录中添加一个 `+server.js` 文件，如下所示：

```text
src/

2└ routes/

3	└ api/

4	  └ +server.js
```

```text
src/

2└ routes/

3	└ api/

4	  └ +server.js
```

In addition to this change, server routes must now return a proper [**Response object**](https://developer.mozilla.org/en-US/docs/Web/API/Response/Response). Thankfully, SvelteKit has a `json` function available that will do this for us by simply importing it, then wrapping whatever data we return in that function call. Lastly, the HTTP verb functions accepted by a server route must now be capitalized.

除了此项变更外，服务端路由（server routes）现在**必须**返回一个标准的 [**Response 对象**](https://developer.mozilla.org/en-US/docs/Web/API/Response/Response)。值得庆幸的是，SvelteKit 提供了一个内置的 `json` 函数，只需导入该函数，并将我们希望返回的数据包裹在该函数调用中，即可自动生成符合要求的 Response 对象。最后，服务端路由所接受的 HTTP 动词函数（如 `GET`、`POST` 等）现在必须使用**大写形式**。

Migrating an old project? Checkout the [Migration Guide](https://github.com/sveltejs/kit/discussions/5774).

正在迁移旧项目？请查阅 [迁移指南](https://github.com/sveltejs/kit/discussions/5774)。

## SvelteKit on Vercel

## SvelteKit 在 Vercel 上的部署

Vercel is a cloud platform for deploying and hosting web applications. Using [Vercel in conjunction with SvelteKit](https://vercel.com/solutions/svelte) creates a dream stack, offering several improvements:

Vercel 是一个用于部署与托管 Web 应用的云平台。将 [Vercel 与 SvelteKit 结合使用](https://vercel.com/solutions/svelte) 可构建出理想的开发与部署栈，带来多项显著提升：

- Vercel provides a zero-configuration platform for deploying and hosting SvelteKit apps, making it easy to get your app up and running quickly.

- Vercel 为部署和托管 SvelteKit 应用提供了零配置平台，让您能快速启动并运行自己的应用。

- Vercel recently launched [Edge Functions](https://vercel.com/features/edge-functions), which allow you to run JavaScript code on their globally-distributed edge network. SvelteKit supports Vercel Edge Functions, meaning you can serve your users dynamically-rendered pages at the same speed you would serve static files from a CDN, drastically improving the performance and scalability of your SvelteKit app.

- Vercel 近期推出了 [Edge Functions（边缘函数）](https://vercel.com/features/edge-functions)，允许您在 Vercel 全球分布的边缘网络上运行 JavaScript 代码。SvelteKit 原生支持 Vercel Edge Functions，这意味着您可以像从 CDN 提供静态文件一样，以同等速度向用户交付动态渲染的页面，从而极大提升 SvelteKit 应用的性能与可扩展性。

- Vercel offers Vercel Analytics in the dashboard to help you understand the performance of your application based on real visitor data. With the Vercel Analytics API, you can now use Vercel Analytics with SvelteKit.

- Vercel 在控制台中提供 Vercel Analytics 功能，帮助您基于真实访客数据深入了解应用性能表现。借助 Vercel Analytics API，您现在可在 SvelteKit 项目中直接集成并使用 Vercel Analytics。

- Vercel provides built-in support for server-side rendering (SSR) and static site generation (SSG), which can improve the performance and SEO of your SvelteKit app.

- Vercel 原生支持服务端渲染（SSR）与静态站点生成（SSG），有助于提升 SvelteKit 应用的性能与搜索引擎优化（SEO）效果。

- Vercel offers seamless integrations with popular development tools and services, such as GitHub, GitLab, and Visual Studio Code, making it easy to integrate your SvelteKit app into your existing workflow.

- Vercel 与 GitHub、GitLab 和 Visual Studio Code 等主流开发工具与服务无缝集成，让您的 SvelteKit 应用轻松融入现有开发工作流。

- Vercel provides a powerful, intuitive interface for managing and monitoring your SvelteKit app, allowing you to see how your app is performing and make updates and changes as needed.

- Vercel 提供功能强大且直观的管理与监控界面，助您实时掌握 SvelteKit 应用的运行状况，并按需进行更新与调整。

Overall, Vercel can provide a number of benefits when used with SvelteKit, making it easier to deploy, host, and manage your SvelteKit app. Whether you're a small team building a simple web app or a large organization with complex, mission-critical applications, Vercel can help you get the most out of your SvelteKit app.

总体而言，将 Vercel 与 SvelteKit 结合使用可带来诸多优势，使您的 SvelteKit 应用更易于部署、托管和管理。无论您是正在构建简单 Web 应用的小型团队，还是运营着复杂且关乎业务关键性的大型组织，Vercel 都能助您充分释放 SvelteKit 应用的潜力。

## Community

## 社区

One of the key reasons for SvelteKit’s growing popularity is the inclusive community that has formed around it. Svelte Society, the community-run Svelte network, has become the home of all things related to Svelte and SvelteKit.

SvelteKit 日益流行的关键原因之一，在于其周围形成的包容性社区。由社区自主运营的 Svelte 网络——Svelte Society，已成为所有与 Svelte 和 SvelteKit 相关事务的中心。

This community encourages participation from developers of all skill levels, and there are plenty of opportunities for beginners to get involved and learn from more experienced members. In addition to Svelte Society, there is also a network for women and non-binary people interested in Svelte called [Svelte Sirens](https://twitter.com/SvelteSirens). These communities are all active on [forums](https://discord.com/channels/457912077277855764/939868205869072444) and social media, and there are regular events where SvelteKit developers can connect with each other.

该社区鼓励各技能水平的开发者积极参与，初学者也有大量机会加入其中，并向经验更丰富的成员学习。除 Svelte Society 外，还有一个专为对 Svelte 感兴趣的女性及非二元性别开发者设立的社群——[Svelte Sirens](https://twitter.com/SvelteSirens)。这些社群均活跃于 [论坛](https://discord.com/channels/457912077277855764/939868205869072444) 及社交媒体平台，且定期举办活动，供 SvelteKit 开发者彼此交流联结。

But the SvelteKit ecosystem is more than just documentation and a supportive community. There are also many tools and resources available to use while building SvelteKit applications. These include templates, starter kits, and other helpful resources that can make it even easier to get started with SvelteKit. Here are some of our favorites:

但 SvelteKit 生态系统远不止完善的文档与支持性社区。在构建 SvelteKit 应用的过程中，还有大量可用的工具与资源，例如模板、入门套件及其他实用资源，可进一步降低上手门槛。以下是我们精选的部分推荐：

- [PocketBase](https://pocketbase.io/)

- [Tailwind CSS](https://tailwindcss.com/docs/guides/sveltekit)

- [Storybook](https://storybook.js.org/)

- [Imagetools](https://github.com/JonasKruckenberg/imagetools)

The SvelteKit ecosystem is constantly growing and evolving. We’ve already got some awesome companies using SvelteKit on Vercel to do some amazing things! Check some of them out:

SvelteKit 生态系统正持续蓬勃发展、不断演进。目前已有不少优秀企业借助 Vercel 运行 SvelteKit，并创造出令人惊叹的应用成果！快来看看其中一些代表案例吧：

- [The Pudding](https://pudding.cool/)

- [The Pudding（布丁）](https://pudding.cool/)

- [Evidence](https://evidence.dev/)

- [Evidence（证据）](https://evidence.dev/)

- [Raster](https://raster.app/)

- [Raster（光栅）](https://raster.app/)

- [Monogram](https://monogram.io/)

- [Monogram（单字母组合标志）](https://monogram.io/)

- [Gitbook](https://www.gitbook.com/)

- [GitBook](https://www.gitbook.com/)

- [Fieuzal](https://fieuzal.com/en)

- [Fieuzal（菲厄扎尔）](https://fieuzal.com/en)

- [Senja](https://senja.io/)

- [Senja（森雅）](https://senja.io/)

- [Files](https://files.community/)

- [Files（文件）](https://files.community/)


## Get started with SvelteKit 1.0

## 使用 SvelteKit 1.0 快速入门

Get started with SvelteKit on Vercel by [deploying one of our SvelteKit templates](https://vercel.com/templates/svelte) in seconds, or begin learning with Vercel’s free [Beginner SvelteKit course](https://vercel.com/docs/beginner-sveltekit)!

只需几秒钟，即可通过在 Vercel 上[部署我们的任一 SvelteKit 模板](https://vercel.com/templates/svelte)快速开始使用 SvelteKit；或者，也可从 Vercel 免费提供的 [SvelteKit 新手入门课程](https://vercel.com/docs/beginner-sveltekit) 开始学习！