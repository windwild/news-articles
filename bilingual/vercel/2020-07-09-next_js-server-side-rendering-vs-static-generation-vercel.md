---
title: "Next.js: Server-side Rendering vs. Static Generation - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/nextjs-server-side-rendering-vs-static-generation"
date: "2020-07-09"
scraped_at: "2026-03-02T10:06:40.569392028+00:00"
language: "en-zh"
translated: true
description: "How to use Static Generation, Incremental Static Generation, and Client-side Fetching with Next.js."
---

Jul 9, 2020

2020年7月9日

[**Next.js**](https://nextjs.org/) 是一个支持 **预渲染（pre-rendering）** 的 React 框架。它并非让浏览器从零开始渲染全部内容，而是可通过两种不同方式向浏览器提供预渲染的 HTML。

在 **服务端渲染（Server-side Rendering, SSR）** 模式下，Next.js 在每次请求时都在服务器端将页面预渲染为 HTML。[首字节时间（TTFB, Time to First Byte）](https://web.dev/time-to-first-byte/) 较长，但数据始终是最新鲜的。

在 **静态生成（Static Generation, SSG）** 模式下，Next.js 在每次请求 *之前*（例如在构建时）就在服务器端将页面预渲染为 HTML。生成的 HTML 可由 CDN 全局缓存，并实现瞬时响应。

静态生成性能更优，但由于预渲染发生在请求 *之前*，因此在请求发生时，所用数据可能已过时（stale）。

幸运的是，我们无需在数据更新时重建整个应用，即可规避这一问题。借助 Next.js，你可以在享受静态生成极致性能的同时，不牺牲服务端渲染的优势。

具体而言，你可以采用以下两种方式：

- **增量静态生成（Incremental Static Generation）**：在构建完成 *之后*，逐步新增或更新已静态预渲染的页面；

- **客户端数据获取（Client-side Fetching）**：先对页面中不依赖数据的部分进行静态生成，再于客户端发起数据请求并填充。

为便于理解，我们以一个假设的电商 Next.js 应用为例进行说明。

## E-commerce Next.js App Example

## 电商 Next.js 应用示例

An e-commerce app might have the following pages, each with different data requirements.

一个电商应用可能包含以下页面，每个页面具有不同的数据需求。

- **About Us**: This page shows the company information, which will be written directly in the app’s source code. No need to fetch data.

- **关于我们**：该页面展示公司信息，内容直接编写在应用的源代码中，无需获取数据。

- **All Products**: This page shows the list of all products. The data will be fetched from a database. This page will look the same for all users.

- **全部商品**：该页面展示所有商品的列表。数据将从数据库中获取。该页面对所有用户均呈现相同外观。

- **Individual Product**: This page shows each individual product. Like the All Products page, the data will be fetched from a database, and each page will look the same for all users.

- **单个商品**：该页面展示每个独立商品。与“全部商品”页面类似，数据同样从数据库中获取，且每个商品页面对所有用户均呈现相同外观。

- **Shopping Cart**: This page shows a user’s shopping cart. The data will be fetched from a database. This page will look different for each user.

- **购物车**：该页面展示用户的购物车。数据将从数据库中获取。该页面因用户而异，每位用户看到的内容均不相同。

### Per-page Basis

### 按页面粒度配置

One of my favorite features of Next.js is **per-page configuration** for pre-rendering. You can choose a different data fetching strategy for each page.

Next.js 最令我喜爱的功能之一是预渲染的**按页面配置**能力。您可以为每个页面选择不同的数据获取策略。

For our e-commerce app example, we’ll use the following strategy for each page. We’ll explain how they work shortly.

在本电商应用示例中，我们将为每个页面采用如下策略。稍后我们将详细说明其工作原理。

- **About Us:** Static Generation without data.

- **关于我们**：静态生成（不依赖外部数据）。

- **All Products / Individual Product:** Static Generation with data, and then improve upon it using Incremental Static Generation.  
- **所有产品 / 单个产品：** 先使用数据进行静态生成（Static Generation），再通过增量静态生成（Incremental Static Generation）持续优化。

- **Shopping Cart:** Static Generation without data, combined with Client-side Fetching.  
- **购物车：** 无数据的静态生成（Static Generation），结合客户端数据获取（Client-side Fetching）。

## About Us Page: Static Generation without Data

## 关于我们页面：无数据的静态生成

If a page does not require fetching external data, it will automatically pre-render into HTML at build time. This is the default for Next.js pages. Let’s use this for the about page, which has no data requirements.  
如果某个页面无需获取外部数据，Next.js 将在构建时自动将其预渲染为 HTML。这是 Next.js 页面的默认行为。我们可将此方式用于“关于我们”页面——该页面不依赖任何外部数据。

Create a file under the `pages` directory and export only the component.  
在 `pages` 目录下创建一个文件，并仅导出该组件。

pages/about.js  

```javascript
1// This page can can be pre-rendered without

2// external data: It will be pre-rendered

3// into a HTML file at build time.

export default function About() {
```

5  return (

5  返回（

6    <div>

6    <div>

7      <h1>About Us</h1>

7      <h1>关于我们</h1>

8      {/* ... */}

8      {/* …… */}

9    </div>

9    </div>

10  )

10  ）

11}
```

## **All Products Page:** Static Generation with Data

## **所有产品页面：** 带数据的静态生成（Static Generation）

Next, let’s create a page showing all products. We want to fetch from our database at build time, so we’ll use Static Generation.

接下来，我们来创建一个展示全部产品的页面。我们希望在构建时从数据库中获取数据，因此将采用静态生成（Static Generation）。

Create a page component that exports a `getStaticProps` function. This function will be called at build time to fetch external data, and the data will be used to pre-render the page component.

创建一个导出 `getStaticProps` 函数的页面组件。该函数将在构建时被调用，用于获取外部数据；所获取的数据将用于预渲染该页面组件。

```javascript
1// This function runs at build time on the build server

1// 此函数在构建服务器上于构建时运行

export async function getStaticProps() {

export async function getStaticProps() {

3  return {

3  返回 {

4    props: {

4    props: {

5      products: await getProductsFromDatabase()

5      products: await getProductsFromDatabase()

6    }

6    }

7  }

7  }

8}

8}



10// The page component receives products prop

10// 页面组件接收 products 属性
```

11// from getStaticProps at build time

11// 在构建时由 getStaticProps 提供

export default function Products({ products }) {

export default function Products({ products }) {

13  return (

13  return (

14    <>

14    <>

15      <h1>Products</h1>

15      <h1>产品</h1>

16      <ul>

16      <ul>

17        {products.map((product) => (

17        {products.map((product) => (

18          <li key={product.id}>{product.name}</li>

18          <li key={product.id}>{product.name}</li>

19        ))}

19        ))}

20      </ul>

20      </ul>

21    </>

22  )

23}
```

`getStaticProps` is run on our build server (Node.js environment), so the code will [not be included](https://nextjs.org/docs/basic-features/data-fetching#technical-details) in the client-side JavaScript bundle. This means you can directly query your database.

`getStaticProps` 在构建服务器（Node.js 环境）上运行，因此该代码**不会被包含在**客户端 JavaScript 包中（参见 [技术细节](https://nextjs.org/docs/basic-features/data-fetching#technical-details)）。这意味着你可以直接查询数据库。

## Individual Product Page: Static Generation with Data

## 单个商品页面：带数据的静态生成

Your e-commerce app needs a page for each product with a route based on its id (for example, `/products/[id]`).

你的电商应用需要为每个商品提供一个页面，其路由基于商品 ID（例如 `/products/[id]`）。

In Next.js, this can be done at build time using [dynamic routes](https://nextjs.org/docs/routing/dynamic-routes) and `getStaticPaths`. By creating a file called `products/[id].js` and having `getStaticPaths` return all possible ids, you can pre-render all individual product pages at build time.

在 Next.js 中，可通过 [动态路由](https://nextjs.org/docs/routing/dynamic-routes) 和 `getStaticPaths` 在构建时完成此操作。只需创建一个名为 `products/[id].js` 的文件，并让 `getStaticPaths` 返回所有可能的商品 ID，即可在构建时预先渲染全部单个商品页面。

Then, you can fetch data for the individual product from the database. We can use `getStaticProps` again by providing the `id` at build time.

随后，你可以从数据库中获取该商品的详细数据。我们可在构建时将 `id` 传入，再次使用 `getStaticProps`。

pages/products/\[id\].js

`pages/products/[id].js`

```javascript
1// In getStaticPaths(), you need to return the list of
1// 在 getStaticPaths() 中，你需要返回所有可能的 ID 列表：

2// 你希望在构建时预渲染的产品页面（/products/[id]）的 ID 列表。  
2// 你希望在构建时预渲染的产品页面（/products/[id]）的 ID 列表。  
3// 为此，你可以从数据库中获取所有产品。  
3// 为此，你可以从数据库中获取所有产品。  
4// To do so, you can fetch all products from a database.  
4// 为此，你可以从数据库中获取所有产品。  

```javascript
export async function getStaticPaths() {

  const products = await getProductsFromDatabase()

  const paths = products.map((product) => ({
    params: { id: product.id }
  }))
```

12  // fallback: false means pages that don’t have the  
12  // `fallback: false` 表示：不具有对应 ID 的页面将返回 404 错误。

13  // correct id will 404.  
13  // 正确 ID 的页面将返回 404。

14  return { paths, fallback: false }  
14  return { paths, fallback: false }

15}  
15}

17// params will contain the id for each generated page.  
17// `params` 将包含每个生成页面对应的 `id`。

export async function getStaticProps({ params }) {  
export async function getStaticProps({ params }) {

19  return {  
19  return {

20    props: {  
20    props: {

21      product: await getProductFromDatabase(params.id)  
21      product: await getProductFromDatabase(params.id)

22    }

23  }

24}



export default function Product({ product }) {

27  // Render product

28}
```

## Incremental Static Generation

## 增量静态生成（Incremental Static Generation）

Now, suppose your e-commerce app has grown significantly. Instead of 100 products, you now have 100,000. Products get updated frequently. This poses two problems:

现在，假设你的电商应用已显著扩大规模：商品数量从 100 个增长到了 100,000 个，且商品信息频繁更新。这带来了两个问题：

- Pre-rendering 100,000 pages at build time can be very slow.

- 在构建时预渲染 100,000 个页面可能非常耗时。

- When product data is updated, you’d only want to modify the affected pages. We can't have a full app rebuild every time a product is modified.

- 产品数据更新时，您只需修改受影响的页面；不能每次修改一个产品就触发整个应用的重新构建。

Both of these problems can be solved by **Incremental Static Generation**. Incremental Static Generation allows you to pre-render _a subset of pages incrementally after build time_. It can be used to add pages or update existing pre-rendered pages.

上述两个问题均可通过**增量静态生成（Incremental Static Generation）**解决。增量静态生成允许您在构建完成之后，**逐步预渲染一部分页面**。它可用于新增页面，也可用于更新已预渲染的现有页面。

This allows you to use Static Generation for maximum performance without sacrificing the benefits of Server-side Rendering.

这使您既能享受静态生成带来的极致性能，又不牺牲服务端渲染（Server-side Rendering）的优势。

### ) Adding Pages (Fallback)

### ) 新增页面（回退机制）

If you have 100,000 products and pre-rendering all pages at build time is too slow, you can lazily pre-render the pages.

如果您拥有 100,000 个商品，而在构建时一次性预渲染所有页面速度过慢，则可采用“懒加载”方式按需预渲染页面。

For example, suppose that one of those 100,000 products is called product X. Using Next.js, we can pre-render this page when a user requests the page for product X. Here’s how it works:

例如，假设这 100,000 个商品中有一个名为 “product X”。借助 Next.js，我们可在用户首次请求 product X 页面时，动态为其执行预渲染。其工作流程如下：

1. A user requests the page for product X.

1. 用户请求 product X 的页面。

2. But we haven’t pre-rendered this page yet. Instead of rendering 404, Next.js can serve a "fallback" version of this page (for example, show a loading indicator).

2. 此时该页面尚未被预渲染。Next.js 不会直接返回 404，而是先提供一个“回退版本”页面（例如，显示加载指示器）。

3. In the background, Next.js will render the product X page. When that’s done, the loading page will be swapped to the product X page.

3. Next.js 在后台异步渲染 product X 页面；渲染完成后，将自动用最终的 product X 页面替换原先的加载页面。

4. The next time someone else requests the page for product X, the pre-rendered product X page will be served instantly, just like regular static generation.

4. 此后，当其他用户再次请求 product X 页面时，系统将立即返回已预渲染完成的 product X 页面，效果与常规静态生成完全一致。

To enable this behavior, you can specify `fallback: true` in `getStaticPaths`. Then, in the page itself, you can use `router.isFallback` to see if the loading indicator should be displayed.

要启用此行为，您可以在 `getStaticPaths` 中指定 `fallback: true`。然后，在页面组件内部，您可以使用 `router.isFallback` 来判断是否应显示加载指示器。

pages/products/\[id\].js

```javascript
export async function getStaticProps({ params }) {

2  // ...

3}



export async function getStaticPaths() {

6  // ...



8  // fallback: true means that the missing pages

8  // fallback: true 表示对于缺失的页面
```

9  // 不会返回 404，而是可以渲染一个备用页面（fallback）。

10  return { paths, fallback: true }

11}



export default function Product({ product }) {

14  const router = useRouter()



16  if (router.isFallback) {

17    return <div>Loading...</div>

18  }

20  // Render product...

20  // 渲染产品...

21}
21}

We’ve created a demo of this behavior [here](https://static-tweet.now.sh/) using Twitter as the data source.

我们已使用 Twitter 作为数据源，在此地址创建了该行为的演示：[https://static-tweet.now.sh/](https://static-tweet.now.sh/)

### ) Updating Existing Pages (Incremental Static "Re"generation)

### ) 更新现有页面（增量式静态“再”生成）

When product data is updated, you don’t want to rebuild the entire app. You only want the affected pages to change.

当产品数据更新时，您不希望重新构建整个应用，而仅希望更新受影响的页面。

For example, suppose that at build time, we’ve pre-rendered the page for product Y. At some point, the data for product Y gets updated.

例如，假设在构建时，我们已预先渲染了产品 Y 的页面；之后，产品 Y 的数据发生了更新。

Using Next.js, we can pre-render this page again after some interval. Here’s how it works:

借助 Next.js，我们可以在一定时间间隔后再次对该页面执行预渲染。其工作原理如下：

1. Next.js can define a "timeout" for this page — let’s set it at 60 seconds.

1. Next.js 可以为该页面定义一个“超时”时间——我们将其设为 60 秒。

2. The data for product Y is updated.

2. 产品 Y 的数据被更新。

3. 当请求产品 Y 的页面时，用户将看到现有的（已过时的）页面。

4. 当在上一次请求之后 60 秒内收到另一请求时，用户仍将看到现有的（已过时的）页面；与此同时，Next.js 会在后台重新预渲染该页面。

5. 一旦预渲染完成，Next.js 将为产品 Y 提供更新后的页面。

这种策略被称为增量式静态**再生**（Incremental Static **Re**generation）。要启用该功能，您可在 `getStaticProps` 中指定 `revalidate: 60`。

pages/products/\[id\].js

```javascript
export async function getStaticProps({ params }) {

2  return {

3    props: {

4      product: await getProductFromDatabase(params.id)

5    },

```
6    revalidate: 60

7  }

8}
```

```
6    revalidate: 60

7  }

8}
```

Inspired by [stale-while-revalidate](https://tools.ietf.org/html/rfc5861), this ensures traffic is served statically, and new pages are pushed only after generating successfully. A small number of users may get stale content, but most will get the latest content, and every request will be fast because Next.js always serves static content.

受 [stale-while-revalidate](https://tools.ietf.org/html/rfc5861) 机制启发，该策略确保流量始终以静态方式提供，且新页面仅在成功生成后才被推送。少数用户可能收到过期内容，但大多数用户将获得最新内容；同时，每次请求都极为迅速，因为 Next.js 始终提供静态内容。

Both adding and updating pages are fully supported by both `next start` and the [Vercel Edge Network](https://vercel.com/docs/concepts/edge-network) out of the box.

无论是新增页面还是更新页面，`next start` 和 [Vercel Edge Network](https://vercel.com/docs/concepts/edge-network) 均开箱即用地全面支持。

## Shopping Cart Page: Static Generation without Data, Combined with Client-side Fetching

## 购物车页面：无数据的静态生成 + 客户端数据获取

Some pages, like the shopping cart page, can only be partially pre-rendered ahead of a request. Because the items on a shopping cart are unique to each user, you must always render them at request time.

某些页面（例如购物车页面）只能在请求前进行部分预渲染。由于购物车中的商品因用户而异，因此必须在每次请求时动态渲染。

You might think this is when you opt for Server-side Rendering, but that’s not necessarily the case. Instead, for better performance, you can do **Client-side Fetching** on top of Static Generation without data:

你可能会认为此时应选择服务端渲染（Server-side Rendering），但事实未必如此。为获得更优性能，你可以在“无数据静态生成”的基础上，叠加使用 **客户端数据获取（Client-side Fetching）**：

1. Pre-render the page without data and show a loading state. (Static Generation)

1. 在无数据状态下预渲染页面，并显示加载状态。（静态生成）

2. Then, fetch and display the data client-side. (Client-side Fetching)

2. 随后，在客户端获取并展示数据。（客户端数据获取）

For fetching data on the client-side, I recommend using the data fetching library called [SWR](https://swr.now.sh/). It handles caching, revalidation, focus tracking, and more.

在客户端获取数据时，我推荐使用名为 [SWR](https://swr.now.sh/) 的数据获取库。它支持缓存、重新验证、焦点追踪等功能。

```javascript
import useSWR from 'swr'



function ShoppingCart() {

4  // fetchAPI is the function to do data fetching

5  const { data, error } = useSWR('/api/cart', fetchAPI)



7  if (error) return <div>failed to load</div>

8  if (!data) return <div>loading...</div>

9  return <div>Items in Cart: {data.products.length}</div>
```

10}
```

## Benefits of Static

## 静态生成的优势

Using one of the Static Generation strategies we’ve discussed, you can gain the following benefits:

使用我们此前讨论过的任意一种静态生成（Static Generation）策略，您可获得以下优势：

- **Static is consistently and predictably fast.**

- **静态页面始终快速且性能稳定可预期。**

Pre-rendered HTML files can be cached and served by a global CDN.

预渲染的 HTML 文件可被缓存，并通过全球内容分发网络（CDN）直接提供服务。

- **Static is always online.**

- **静态页面永远在线。**

Even if your backend or data source (e.g. database) goes down, your existing pre-rendered page will still be available.

即使您的后端服务或数据源（例如数据库）发生故障，已预渲染的页面仍可正常访问。

- **Static minimizes backend load.**

- **静态生成极大降低后端负载。**

With Static Generation, the database or API wouldn’t need to be hit on every request. Page-rendering code wouldn’t have to run on every request.

采用静态生成时，数据库或 API 无需在每次请求时被调用；页面渲染逻辑也无需在每次请求时执行。

## Server-side Rendering

## 服务端渲染（SSR）

If you want to use Server-side Rendering (pre-render a page on the server on _every request_) with Next.js, you can. To use this feature, you can export a function called `getServerSideProps` from a page, just like `getStaticProps`. Server-side Rendering is also supported when deployed to Vercel.

如果您希望在 Next.js 中使用服务端渲染（SSR，即在 _每次请求时_ 都在服务器端预先渲染页面），这是完全可行的。要启用该功能，您只需像导出 `getStaticProps` 一样，在页面文件中导出一个名为 `getServerSideProps` 的函数即可。当部署到 Vercel 时，服务端渲染同样受支持。

However, by using Server-side Rendering, you’ll give up on the benefits of Static as mentioned above. We suggest trying Incremental Static Generation or Client-side Fetching and see if they fit your needs.

然而，采用服务端渲染意味着您将放弃上文所述的静态生成（Static Generation）所带来的各项优势。我们建议您先尝试**增量静态生成（Incremental Static Generation, ISG）** 或 **客户端数据获取（Client-side Fetching）**，看看它们是否更契合您的实际需求。

## Also: Writing Data

## 此外：写入数据

Fetching data is only half the equation. Your app might need to write data back to your data source. For our e-commerce app, adding an item to the shopping cart is a good example of this.

仅获取数据只完成了数据交互的一半；您的应用往往还需要将数据写回数据源。以我们的电商应用为例，“将商品加入购物车”就是一个典型的写入操作。

Next.js has a feature called **API Routes** for this purpose. To use this feature, you can create a file inside the `pages/api` directory, which creates an API endpoint we can use to mutate our data source. For example, we can create `pages/api/cart.js`, which accepts a `productId` query parameter and adds that item to our cart.

Next.js 提供了一项名为 **API 路由（API Routes）** 的功能来实现这一目的。要使用该功能，您只需在 `pages/api` 目录下创建一个文件，Next.js 就会自动将其映射为一个可访问的 API 端点，供您修改数据源。例如，我们可以创建 `pages/api/cart.js`，该文件接收一个名为 `productId` 的查询参数，并将对应商品添加至购物车。

Inside our [API route](https://nextjs.org/docs/api-routes/introduction), we export a request handler, which receives a request and returns a `json` response.

在我们的 [API 路由](https://nextjs.org/docs/api-routes/introduction) 中，我们导出一个请求处理器（request handler），它接收一个 HTTP 请求，并返回一个 JSON 格式的响应。

```javascript
export default async (req, res) => {

2  const response = await fetch(`https://.../cart`, {

3    body: JSON.stringify({

4      productId: req.query.productId
```

5    }),

6    headers: {

7      Authorization: `Token ${process.env.YOUR_API_KEY}`,

7      授权：`Token ${process.env.YOUR_API_KEY}`，

8      'Content-Type': 'application/json'

8      “Content-Type”：'application/json'

9    },

9    }，

10    method: 'POST'

10    方法：'POST'

11  })

11  })



13  const { products } = await response.json()

13  const { products } = await response.json()；

14  return res.status(200).json({ products })

14  return res.status(200).json({ products })

15};
```

API routes allow us to write to external data sources securely. Using [environment variables](https://nextjs.org/docs/basic-features/environment-variables), we can include secrets for authentication without exposing the values client-side.

API 路由使我们能够安全地向外部数据源写入数据。通过使用 [环境变量](https://nextjs.org/docs/basic-features/environment-variables)，我们可以在不将认证密钥暴露给客户端的情况下，将敏感信息（如密钥）纳入应用。

API routes can be deployed as [Serverless Functions](https://vercel.com/docs/v2/serverless-functions/introduction) (which is the default when you deploy to Vercel).

API 路由可部署为 [无服务器函数（Serverless Functions）](https://vercel.com/docs/v2/serverless-functions/introduction)（在部署到 Vercel 时，默认即采用此方式）。

## Conclusion

## 总结

With Next.js, you can use Static Generation for maximum performance without sacrificing the benefits of Server-side Rendering. For more information, please refer to the Next.js documentation.

借助 Next.js，您可在不牺牲服务端渲染（SSR）优势的前提下，利用静态生成（Static Generation）实现极致性能。如需了解更多，请参阅 Next.js 官方文档。

- [Learn Next.js](https://nextjs.org/learn)

- [学习 Next.js](https://nextjs.org/learn)

- [Pre-Rendering](https://nextjs.org/docs/basic-features/pages#pre-rendering)

- [预渲染（Pre-Rendering）](https://nextjs.org/docs/basic-features/pages#pre-rendering)

- [Data Fetching](https://nextjs.org/docs/basic-features/data-fetching)

- [数据获取（Data Fetching）](https://nextjs.org/docs/basic-features/data-fetching)

- [API Routes](https://nextjs.org/docs/api-routes/introduction)

- [API 路由（API Routes）](https://nextjs.org/docs/api-routes/introduction)