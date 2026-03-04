---
title: "How to improve performance with Next.js - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/upgrading-nextjs-for-instant-performance-improvements"
date: "2022-03-17"
scraped_at: "2026-03-02T10:02:27.675275223+00:00"
language: "en-zh"
translated: true
description: "Learn how Next.js provides a toolkit to improve site performance, improve the developer experience, and decrease build times with every upgrade."
---
&#123;% raw %}

Mar 17, 2022

2022年3月17日

Since the release of Next.js, we’ve worked to introduce new features and tools that drastically improve application performance, as well as overall developer experience.

自 Next.js 发布以来，我们持续推出新功能与工具，大幅提升了应用性能及整体开发者体验。

Let’s take a look at what a difference upgrading to the latest version of Next.js can make.

让我们来看看升级到最新版 Next.js 所带来的显著变化。

In 2019, our team at Vercel created a serverless demo app called [VRS (Virtual Reality Store)](https://serverless-vrs.vercel.app/) using Next.js 8, Three.js, Express, MongoDB, Mongoose, Passport.js, and Stripe Elements. Users could sign up, browse multiple 3D models, and purchase them.

2019 年，Vercel 团队使用 Next.js 8、Three.js、Express、MongoDB、Mongoose、Passport.js 和 Stripe Elements 构建了一个名为 [VRS（虚拟现实商店）](https://serverless-vrs.vercel.app/) 的无服务器演示应用。用户可注册账号、浏览多种 3D 模型，并完成购买。

Although this demo is still fully functional three years later, it lacked some of the performance improvements that were added over the years.

尽管该演示应用三年后仍完全可用，但它并未受益于这些年陆续加入的诸多性能优化特性。

![](images/how-to-improve-performance-with-next_js-vercel/img_001.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_002.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_003.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_004.jpg)

![](images/how-to-improve-performance-with-next_js-vercel/img_001.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_002.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_003.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_004.jpg)

By upgrading the demo app to Next.js 12, we were able to vastly improve our [Core Web Vitals](https://vercel.com/blog/core-web-vitals) and go from an average performance score of 32 to 99.

通过将该演示应用升级至 Next.js 12，我们大幅优化了 [核心网页指标（Core Web Vitals）](https://vercel.com/blog/core-web-vitals)，平均性能评分从 32 提升至 99。

![](images/how-to-improve-performance-with-next_js-vercel/img_005.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_006.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_005.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_006.jpg)

![](images/how-to-improve-performance-with-next_js-vercel/img_005.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_006.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_005.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_006.jpg)

Let's explore the changes we made to improve performance and streamline the developer experience using new Next.js features.

接下来，我们将探讨如何借助 Next.js 的新特性，通过一系列改造来提升性能并优化开发者体验。

## Using `getStaticProps` and `getStaticPaths`

## 使用 `getStaticProps` 和 `getStaticPaths`

The old implementation relied on a separate backend folder that contained a custom Express server, which exposed an `/api/checkout` endpoint to handle payments, `/api/get-products` to fetch data used to render all models, and the `/api/get-product/:id` endpoint to fetch the data for a specific model.

旧实现依赖一个独立的后端文件夹，其中包含一个自定义的 Express 服务器，该服务器暴露了以下 API 端点：用于处理支付的 `/api/checkout`、用于获取渲染所有商品所需数据的 `/api/get-products`，以及用于获取某个特定商品数据的 `/api/get-product/:id`。

When a user navigated from the landing page to the `/store` page, `getInitialProps` would make a request to the `/api/get-products` endpoint to retrieve data for the shown models.

当用户从首页导航至 `/store` 页面时，`getInitialProps` 会向 `/api/get-products` 端点发起请求，以获取用于渲染所展示商品的数据。

The store page was only visible to the user once the request had been resolved. This could take a while, depending on the quality of their internet connection.

该商店页面仅在请求完成并响应后才对用户可见。具体耗时取决于用户的网络连接质量，可能较长。

![](images/how-to-improve-performance-with-next_js-vercel/img_009.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_010.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_011.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_012.jpg)

![](images/how-to-improve-performance-with-next_js-vercel/img_009.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_010.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_011.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_012.jpg)

Next.js 9 introduced `getStaticProps`, which allows developers to fetch data at build time. Unlike `getInitialProps`, this function **always runs server-side**! The code written inside this function _won’t_ be included in the JavaScript bundle sent to the client, so it’s safe to write server-side code directly in `getStaticProps`.

Next.js 9 引入了 `getStaticProps`，允许开发者在构建时（build time）获取数据。与 `getInitialProps` 不同，该函数**始终在服务端执行**！写在该函数内部的代码**不会**被打包进发送给客户端的 JavaScript 包中，因此可安全地在 `getStaticProps` 中直接编写服务端逻辑。

Instead of relying on external API endpoints to fetch the data needed to render the models on the `/store` page, this data is available to us instantly when navigating to the page.

我们不再依赖外部 API 端点来获取渲染 `/store` 页面商品所需的数据；取而代之的是，这些数据在用户导航至该页面时即可立即获得。

Static Site Generation using `getStaticProps` is especially powerful when it’s used in combination with the `<Link />` component. This component prefetches pages as soon as their link appears in the viewport. When the user actually clicks on the link, no additional requests have to be made in order to render the page: Next.js will use the data that’s already been prefetched!

结合 `<Link />` 组件使用 `getStaticProps` 实现的静态站点生成（Static Site Generation）尤为强大。该组件会在链接元素进入视口（viewport）的瞬间即开始预取对应页面。当用户真正点击该链接时，无需再发起额外请求即可渲染页面——Next.js 将直接使用已预取的数据！

![](images/how-to-improve-performance-with-next_js-vercel/img_013.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_014.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_015.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_016.jpg)

![](images/how-to-improve-performance-with-next_js-vercel/img_013.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_014.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_015.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_016.jpg)

Although the user hadn’t clicked the "Store" link yet, the `store.js` and `store.json` files that are necessary to render the store page had already been prefetched. Using `getStaticProps` with the `<Link />` component drastically improves the responsiveness of the application.

尽管用户尚未点击“商店”（Store）链接，但用于渲染商店页面所需的 `store.js` 和 `store.json` 文件早已被预取完成。将 `getStaticProps` 与 `<Link />` 组件配合使用，显著提升了应用的响应速度。

You might notice that the time it takes to fetch the thumbnails has also been reduced tremendously. We were able to do this by replacing the native `<img />` tag in favor of the `<Image />` component.

您可能还会注意到，缩略图的加载时间也大幅缩短。我们通过用 Next.js 提供的 `<Image />` 组件替代原生 `<img />` 标签实现了这一优化。

## Using `next/image`

## 使用 `next/image`

The `<Image />` component was introduced in Next.js 10 and further improved in later versions, allowing developers to efficiently serve images using modern image formats without [layout shift](https://nextjs.org/learn/seo/web-performance/cls).

`<Image />` 组件于 Next.js 10 中首次引入，并在后续版本中持续优化，使开发者能够借助现代图像格式高效地提供图片，同时避免发生 [布局偏移（layout shift）](https://nextjs.org/learn/seo/web-performance/cls)。

The performance improvement is instantly noticeable when we compare the loading time of the `/store` page, which renders an image for each model thumbnail.

当我们对比 `/store` 页面的加载时间（该页面为每个模型缩略图渲染一张图片）时，性能提升立竿见影。

![Loading the /store page using Next.js 8 without next/image](images/how-to-improve-performance-with-next_js-vercel/img_017.jpg)![Loading the /store page using Next.js 8 without next/image](images/how-to-improve-performance-with-next_js-vercel/img_017.jpg)Loading the /store page using Next.js 8 without next/image

![使用 Next.js 8（未启用 next/image）加载 /store 页面](images/how-to-improve-performance-with-next_js-vercel/img_017.jpg)![使用 Next.js 8（未启用 next/image）加载 /store 页面](images/how-to-improve-performance-with-next_js-vercel/img_017.jpg)使用 Next.js 8（未启用 next/image）加载 `/store` 页面

![Loading the /store page using Next.js 12 with next/image](images/how-to-improve-performance-with-next_js-vercel/img_019.jpg)![Loading the /store page using Next.js 12 with next/image](images/how-to-improve-performance-with-next_js-vercel/img_019.jpg)Loading the /store page using Next.js 12 with next/image

![使用 Next.js 12（启用 next/image）加载 /store 页面](images/how-to-improve-performance-with-next_js-vercel/img_019.jpg)![使用 Next.js 12（启用 next/image）加载 /store 页面](images/how-to-improve-performance-with-next_js-vercel/img_019.jpg)使用 Next.js 12（启用 next/image）加载 `/store` 页面

Let’s look at the differences between using the native `<img />` tag, and using the `<Image />` component.

接下来，我们来对比原生 `<img />` 标签与 `<Image />` 组件的差异。

### Next-gen image format

### 下一代图像格式

The `<Image />` component serves the next-gen image format `webp` format. Images using this format are 25–35% smaller than JPEG files with the exact same quality index. This difference is clearly visible when comparing the sizes of the fetched images: whereas the red car model’s image used to be 1.3MB in the old implementation, we were able to reduce the size by **−98.75%** to only 16.6kB by using the `<Image />` component.

`<Image />` 组件默认提供下一代图像格式 `webp`。在画质完全相同的情况下，采用该格式的图像体积比 JPEG 小 25%–35%。这一差异在对比实际加载的图像文件大小时尤为明显：例如红色汽车模型的图片，在旧实现中体积为 1.3 MB；而启用 `<Image />` 组件后，其体积被大幅压缩至仅 16.6 kB，缩减幅度达 **−98.75%**。

### Lazy Loading

### 懒加载（Lazy Loading）

The old implementation requested the images for all models, resulting in 12 fetch requests. The `<Image />` component only fetches the image once it detects the intersection of the viewport with the image’s bounding box.

旧实现会一次性请求全部模型的图片，共触发 12 次网络请求；而 `<Image />` 组件则采用懒加载策略——仅当浏览器视口与图片的边界框发生交集时，才发起对应图片的请求。

Although no changes had to be made to the images themselves, we were able to decrease the image loading time from an average of ~3000ms down to ~270ms.

尽管图片本身无需任何修改，但我们成功将图片加载时间从平均约 3000 毫秒降低至约 270 毫秒。

## **Dynamic Routes**

## **动态路由**

When browsing through the store, users can click on each item to better view the model.

用户在浏览商店时，可点击每个商品以更清晰地查看对应 3D 模型。

The old implementation used a combination of query parameters and `getInitialProps` to render the page and fetch the needed data to render each model. Similar to what we saw on the `/store` page, the user can only see the model once the API request initiated within the `getInitialProps` function has resolved.

旧版实现采用查询参数（query parameters）与 `getInitialProps` 相结合的方式渲染页面，并获取渲染每个模型所需的数据。与我们在 `/store` 页面所见类似，用户只有在 `getInitialProps` 函数内发起的 API 请求完成之后，才能看到模型。

Next.js 9 introduced file-system-based [dynamic routes](https://nextjs.org/docs/routing/dynamic-routes). In combination with the new `getStaticPaths` function used together with `getStaticProps`, this feature makes it possible to dynamically pre-render the model pages based on their id.

Next.js 9 引入了基于文件系统的 [动态路由](https://nextjs.org/docs/routing/dynamic-routes)。结合新引入的 `getStaticPaths` 函数与 `getStaticProps`，该功能支持根据模型 ID 动态预渲染各个模型页面。

Instead of having one model page and using `getInitialProps` and query parameters to determine which data to fetch and what model to render, we can directly use a path parameter to generate pages for each model statically.

我们不再依赖单一模型页面配合 `getInitialProps` 和查询参数来决定获取哪些数据、渲染哪个模型；而是直接利用路径参数（path parameter），为每个模型静态生成独立页面。

By wrapping each model card in the grid in a `<Link />` component, we can prefetch each `/model/[id]` page once the card appears in the viewport, allowing instant navigation when a user clicks on the card.

通过将网格中的每个模型卡片包裹在 `<Link />` 组件中，当卡片进入视口（viewport）时，系统即可预取对应的 `/model/[id]` 页面，从而实现用户点击卡片时的瞬时跳转。

## API Routes

## API 路由

Next.js 9 introduced [API Routes](https://nextjs.org/docs/api-routes/introduction), making it easy to create API endpoints from within the `/pages` folder.

Next.js 9 引入了 [API 路由](https://nextjs.org/docs/api-routes/introduction)，使得开发者能够轻松地在 `/pages` 目录下创建 API 端点。

Although we could replace the `/api/get-products` and `/api/get-product/:id` endpoints by using `getStaticProps`, we still need the `/api/checkout` endpoint to handle payments on the server-side.

尽管我们可通过 `getStaticProps` 替代 `/api/get-products` 和 `/api/get-product/:id` 这两个端点，但 `/api/checkout` 端点仍不可或缺——它负责在服务端处理支付逻辑。

This endpoint cannot be replaced with the `getStaticProps` method, since it needs to be available to the client during runtime with values that are unknown during build time. When a user purchases an item, the client makes a call to this endpoint using the unique token that was generated for their card.

该端点无法被 `getStaticProps` 方法替代，因为它必须在运行时对客户端可用，且其所需值在构建时是未知的。当用户购买商品时，客户端会使用为其银行卡生成的唯一令牌，向该端点发起调用。

Instead of hosting our own server to provide this endpoint, we can recreate this endpoint as an API Route instead!

我们无需自行托管服务器来提供该端点，而是可以将其重构为一个 API 路由（API Route）！

![](images/how-to-improve-performance-with-next_js-vercel/img_021.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_022.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_021.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_022.jpg)

### NextAuth.js

### NextAuth.js

The old implementation also had user authentication using Passport.js. To more easily add authentication to our application, we can take advantage of [NextAuth.js](https://next-auth.js.org/), which simplifies this process to a few lines of code with support for 50+ providers.

旧版实现使用 Passport.js 实现用户身份认证。为了更便捷地为我们的应用添加认证功能，我们可以采用 [NextAuth.js](https://next-auth.js.org/) —— 它支持 50 多种认证提供商，并能将整个认证流程简化为几行代码。

pages/api/\[...nextauth\].ts

```javascript
import NextAuth from "next-auth";

import GithubProvider from "next-auth/providers/github";



export default NextAuth({

5   providers: [\
\
6      GithubProvider({\
\
7        clientId: process.env.GITHUB_CLIENT_ID,\
\
8        clientSecret: process.env.GITHUB_CLIENT_SECRET\
\
9      })\
\
10   ]

11})
```

使用 NextAuth.js 的代码片段

Since all endpoints have been replaced, we no longer need a separate backend folder! We can use the frontend folder as the project's root folder, simplifying the project architecture significantly.

由于所有端点均已迁移至前端，我们不再需要单独的 backend 文件夹！可直接将 frontend 文件夹作为项目的根目录，从而大幅简化项目架构。

## Import on Interaction

## 交互时按需导入（动态导入）

Some components aren’t instantly visible to the user. Instead of including them in the main JavaScript bundle, we can dynamically import these components using `next/dynamic`.

有些组件对用户而言并非立即可见。与其将它们打包进主 JavaScript 文件，不如通过 `next/dynamic` 实现动态导入。

One of these components is the `CartSidebar`. This component is imported in the `Nav` component and is only visible to the user when they click on the cart icon or add an item to the cart.

其中就包括 `CartSidebar` 组件。该组件在 `Nav` 组件中被导入，仅当用户点击购物车图标或向购物车添加商品时才会显示。

```javascript
import CartSidebar from "../components/CartSidebar"



export default function Nav() {

4  ...

5  return (

6      <div>

7         ...

8         <CartSidebar />

9      </div>

10  )

11}
```

在使用动态导入之前

Instead of statically importing this component, we can tell Next.js to create a separate JavaScript chunk for this component through code-splitting. That way, we can delay the import of this non-critical component, and only fetch it on-demand once the user actually requires it.

在使用动态导入之前

我们原本是静态导入该组件；现在，我们可以借助代码分割（code-splitting）机制，指示 Next.js 为该组件单独生成一个 JavaScript 代码块。这样一来，我们便能延迟加载这一非关键组件，仅在用户实际需要时才按需获取并加载它。

```javascript
import dynamic from "next/dynamic"

const CartSidebar = dynamic(() => import("../components/CartSidebar"));



export default function Nav() {

5  ...

6  return (

7      <div>

8         ...

9         {open && <CartSidebar />}

10      </div>
```

```javascript
import dynamic from "next/dynamic"

const CartSidebar = dynamic(() => import("../components/CartSidebar"));



export default function Nav() {

5  ...

6  返回 (

7      <div>

8         ...

9         {open && <CartSidebar />}

10      </div>
```

11  )

12}
```

由于 `CartSidebar` 组件是整个应用中唯一导入并使用第三方支付库（Stripe）的组件，因此我们还能够将这些库的导入延迟到用户实际需要时才执行（而非在初始加载时就获取未使用的代码）。

这使得发送给用户的初始 JavaScript 体积更小，从而提升了页面加载性能。

## 自动字体优化

## Automatic Font Optimization

[自动字体优化](https://nextjs.org/docs/basic-features/font-optimization) 自 Next.js 10 起可用，它会在构建时自动将字体 CSS 内联到 HTML 中，从而避免额外的一次网络请求来获取字体声明。

```javascript
1<link href="https://fonts.googleapis.com/css?family=Space+Mono" rel="stylesheet">
```

启用自动字体优化之前

```javascript
1<style data-href="https://fonts.googleapis.com/css2?family=Space+Mono&amp;display=swap">

2 @font-face{font-family:'Space Mono';font-style:normal;...

3</style>
```

After enabling automatic font optimization

启用自动字体优化后

This means that font declarations no longer have to be fetched, improving initial page load performance.

这意味着字体声明不再需要额外请求获取，从而提升了页面首次加载性能。

![Before enabling automatic font optimization](images/how-to-improve-performance-with-next_js-vercel/img_025.jpg)![Before enabling automatic font optimization](images/how-to-improve-performance-with-next_js-vercel/img_025.jpg)Before enabling automatic font optimization

![启用自动字体优化前](images/how-to-improve-performance-with-next_js-vercel/img_025.jpg)![启用自动字体优化前](images/how-to-improve-performance-with-next_js-vercel/img_025.jpg)启用自动字体优化前

![After enabling automatic font optimization ](images/how-to-improve-performance-with-next_js-vercel/img_027.jpg)![After enabling automatic font optimization ](images/how-to-improve-performance-with-next_js-vercel/img_027.jpg)After enabling automatic font optimization

![启用自动字体优化后](images/how-to-improve-performance-with-next_js-vercel/img_027.jpg)![启用自动字体优化后](images/how-to-improve-performance-with-next_js-vercel/img_027.jpg)启用自动字体优化后

We were able to reduce the number of requests needed to load the font from 4 to 2 just by upgrading to the latest version.

仅通过升级至最新版本，我们就成功将加载字体所需的请求数从 4 次减少到了 2 次。

## Developer experience

## 开发者体验

Besides performance optimizations, the developer experience has also massively improved over the years.

除了性能优化之外，开发者体验多年来也得到了显著提升。

### **Built-in TypeScript support**

### **内置 TypeScript 支持**

Whereas adding TypeScript support required quite a bit of custom configuration, Next.js 9 added support for [TypeScript out of the box](https://nextjs.org/docs/basic-features/typescript)! We no longer have to deal with our own config, but instead can start using TypeScript by adding a `tsconfig.json` file to the root of existing projects, or by running `npx create-next-app --ts` for newly created projects.

过去添加 TypeScript 支持需要大量自定义配置，而 Next.js 9 起已原生支持 [TypeScript](https://nextjs.org/docs/basic-features/typescript)！我们不再需要自行维护配置，只需在现有项目的根目录下添加一个 `tsconfig.json` 文件，或对新项目运行 `npx create-next-app --ts`，即可立即开始使用 TypeScript。

### **Faster builds through SWC**

### **通过 SWC 实现更快的构建**

Next.js 12 includes a new [Rust-based compiler](https://nextjs.org/docs/advanced-features/compiler) built on SWC that takes advantage of native compilation. We reduced our build time from `~90s` down to `~30s` just by upgrading the Next.js version.

Next.js 12 引入了一个基于 SWC 的全新 [Rust 编译器](https://nextjs.org/docs/advanced-features/compiler)，该编译器利用原生编译能力大幅提升性能。仅通过升级 Next.js 版本，我们就将构建时间从 `~90 秒` 缩短至 `~30 秒`。

### **React Fast Refresh**

### **React 快速刷新（Fast Refresh）**

[Fast Refresh](https://nextjs.org/docs/basic-features/fast-refresh) is a Next.js feature enabled in all Next.js apps on version 9.4 or newer. It provides instantaneous feedback on edits made to your React components within a second without losing component state. The introduction of SWC in Next.js 12 improved the refresh rate significantly, resulting in **3x faster refreshes** compared to prior versions.

[快速刷新（Fast Refresh）](https://nextjs.org/docs/basic-features/fast-refresh) 是 Next.js 自 9.4 版本起默认启用的一项功能，适用于所有 Next.js 应用。它能在一秒内即时反馈您对 React 组件所做的修改，且不会丢失组件状态。Next.js 12 中引入 SWC 后，刷新性能得到显著提升，相比此前版本实现了 **3 倍的刷新速度提升**。

## Conclusion

## 总结

The improvements and new features Next.js has introduced over the past couple of years have made it easy to create fast fullstack applications, all while ensuring backward compatibility and making incremental adoption to new versions possible.

过去几年中，Next.js 推出的各项改进与新特性，让开发者能够轻松构建高性能的全栈应用，同时确保向后兼容性，并支持以渐进方式升级至新版本。

By upgrading to the latest version, we were able to vastly optimize our application and developer experience with minimal effort on our end.

通过升级至最新版本，我们仅需极少的投入，便大幅优化了应用性能与开发体验。

[Try out the upgraded demo](https://serverless-vrs.vercel.app/) or [view the full PR](https://github.com/vercel/vrs/pull/50) for the upgrade. If you'd like to upgrade your Next.js app, check out our [upgrade guide](https://nextjs.org/docs/upgrading).

[试用升级后的演示版](https://serverless-vrs.vercel.app/)，或 [查看本次升级的完整 PR](https://github.com/vercel/vrs/pull/50)。如需升级您的 Next.js 应用，请参考我们的 [升级指南](https://nextjs.org/docs/upgrading)。
&#123;% endraw %}
