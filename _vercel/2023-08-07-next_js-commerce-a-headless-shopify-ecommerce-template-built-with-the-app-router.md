---
title: "Next.js Commerce: A headless Shopify ecommerce template built with the App Router - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-next-js-commerce-2-0"
date: "2023-08-07"
scraped_at: "2026-03-02T09:51:19.318063725+00:00"
language: "en-zh"
translated: true
description: "A high-performance ecommerce template, including support for BigCommerce, Medusa, Saleor, Shopify, and Swell."
---

Aug 7, 2023

2023 年 8 月 7 日

Today, we’re excited to introduce Next.js Commerce 2.0.

我们很高兴地推出 Next.js Commerce 2.0。

- **原生支持 App Router：** 基于 React Server Components、Server Actions、内置布局（layouts）、元数据（metadata），以及近期发布的 App Router 所引入的所有新范式。

- **动态 storefront：** 以静态网站的速度实现动态 storefront。在不牺牲性能的前提下灵活定制内容。

- **架构大幅简化：** Next.js Commerce 现在每个仓库仅需一个 provider，显著减少代码量与抽象层级，让您的应用更轻量、更易维护。

Our new ecommerce accelerator template showcases the best patterns for building composable commerce applications, including support for BigCommerce, Medusa, Saleor, Shopify, and Swell.

我们全新推出的电商加速器模板，集中呈现了构建可组合式电商（composable commerce）应用的最佳实践，目前已支持 BigCommerce、Medusa、Saleor、Shopify 和 Swell。

[View the demo](https://demo.vercel.store/) or [deploy your own version](https://vercel.com/templates/next.js/nextjs-commerce) today.

[查看演示](https://demo.vercel.store/) 或 [立即部署您自己的版本](https://vercel.com/templates/next.js/nextjs-commerce)。

## Why is building an ecommerce site difficult?

## 为何构建电商网站如此困难？

When Google announced that [page experience would be a ranking factor in search results](https://developers.google.com/search/blog/2020/05/evaluating-page-experience) and Amazon found that just [100 milliseconds of extra load time cost them 1% in sales](https://www.forbes.com/sites/steveolenski/2016/11/10/why-brands-are-fighting-over-milliseconds/?sh=6d1165864ad3), it put a lot of pressure on ecommerce sites to raise the bar or suffer the consequences.

当 Google 宣布 [页面体验（page experience）将成为搜索结果的排名因素之一](https://developers.google.com/search/blog/2020/05/evaluating-page-experience)，而亚马逊发现 [加载时间仅增加 100 毫秒，就会导致销售额下降 1%](https://www.forbes.com/sites/steveolenski/2016/11/10/why-brands-are-fighting-over-milliseconds/?sh=6d1165864ad3) 时，电商网站便面临巨大压力——要么大幅提升性能标准，要么承担相应后果。

However, according to the Web Almanac, [ecommerce sites still struggle to achieve good performance](https://almanac.httparchive.org/en/2021/ecommerce#lighthouse).

然而，根据《Web Almanac》报告，[电商网站仍在性能优化方面举步维艰](https://almanac.httparchive.org/en/2021/ecommerce#lighthouse)。

![Web Almanac's 2021 Median Lighthouse scores for e-commerce sites on mobile](images/next_js-commerce-a-headless-shopify-ecommerce-template-built-with-the-app-router/img_001.jpg)![Web Almanac's 2021 Median Lighthouse scores for e-commerce sites on mobile](images/next_js-commerce-a-headless-shopify-ecommerce-template-built-with-the-app-router/img_002.jpg)Web Almanac's 2021 Median Lighthouse scores for e-commerce sites on mobile

《Web Almanac》2021 年统计的移动端电商网站 Lighthouse 中位数得分

电商网站表面上看似简单，实则远比看上去更复杂。究竟是哪些因素导致了这些性能指标偏低？

- **页面请求数量庞大。** 所有电商网站中位数（第 50 百分位）在移动端首页发出的请求数高达 101 次。这看起来很多，但请想想大多数首页上所展示的全部商品信息、促销活动等内容。

- **资源负载沉重。** 视频和图片不仅是被请求次数最多的两类资源（分别位列第一和第二），同时也是页面总体积（page weight）的最大和第二大贡献者。再次回想一下——仅首页上你所看到的商品图、促销图就已不计其数。

- **高度依赖个性化呈现。** 这包括基于你的购物历史、行为习惯或地理位置推荐的商品，购物车中的商品，用户个人信息等。

许多电商平台提供开箱即用的预建模板，以助你快速起步；但这些模板往往缺乏支撑规模化增长与高性能表现所需的严谨性。

例如，Shopify 的店铺主题仅要求在桌面端和移动端的「产品页」「分类页」及「首页」上，Lighthouse 性能评分的平均值不低于 [60 分](https://shopify.dev/docs/themes/store/requirements#5-lighthouse-performance-and-accessibility)。

[**Sanity Toolkit for Next.js**  
实现电商级极致速度：Sanity 全新增强版 Next.js 工具包——专为开发者打造，致力于交付卓越的用户体验。  
了解更多](https://www.sanity.io/blog/sanity-nextjs-enhancements)

Under Armour、沃尔玛（Walmart）、塔吉特（Target）、耐克（Nike）等大型零售商均选择 Next.js 构建其电商体验，以获得更优的业务成果。接下来，我们深入探讨其原因。

## Next.js Commerce v1

## Next.js Commerce v1

The first version of [Next.js Commerce](https://nextjs.org/commerce) was announced during [Next.js Conf 2020](https://nextjs.org/2020/conf) and alongside [Next.js 10](https://nextjs.org/blog/next-10#nextjs-commerce). Newer Next.js features at the time, like `next/image` with its automatic image optimization and static and dynamic rendering on a per-page basis, provided the ingredients to create a better ecommerce experience.

[Next.js Commerce](https://nextjs.org/commerce) 的首个版本在 [Next.js Conf 2020](https://nextjs.org/2020/conf) 期间发布，并与 [Next.js 10](https://nextjs.org/blog/next-10#nextjs-commerce) 同步推出。当时推出的诸多新特性——例如支持自动图像优化的 `next/image`，以及按页面粒度分别启用静态渲染（SSG）与动态渲染（SSR）的能力——为构建更优质的电商体验奠定了坚实基础。

Paired with the industry shift from monoliths to headless ecommerce, we were able raise the bar for ecommerce sites. Next.js Commerce embodied a best-in-class, highly performant, highly optimized commerce experience including excellent web core vitals, SEO optimizations, Incremental Static Regeneration, link prefetching, and more.

与此同时，整个行业正从单体式架构加速转向无头电商（headless ecommerce），这使我们得以重新定义电商网站的性能标杆。Next.js Commerce 充分体现了业界领先水准：它不仅具备卓越的性能与高度优化能力，还全面支持核心网页指标（Core Web Vitals）、SEO 优化、增量静态再生（ISR）、链接预获取（link prefetching）等关键能力。

This version of Next.js Commerce was as tremendous step forward, but there was still room for improvement for highly dynamic ecommerce sites.

这一版 Next.js Commerce 是一次巨大的飞跃，但对于高度动态化的电商网站而言，仍有进一步提升的空间。

## Next.js Commerce 2.0—dynamic storefronts at the speed of static

## Next.js Commerce 2.0 —— 静态般的速度，动态般的灵活

There are many dynamic elements in commerce to consider such as a user’s cart, search results, products being purchased and affecting availability, product recommendations, and more.

电商场景中存在大量动态要素，例如用户的购物车、搜索结果、因购买行为而实时变化的库存状态、个性化商品推荐等。

Even with advancements in Server-Side Rendering (SSR), Static Site Generation (SSG), and Incremental Static Regeneration (ISR), creating an ecommerce site was still a difficult task.

即便在服务端渲染（SSR）、静态站点生成（SSG）和增量静态再生（ISR）等技术持续演进的背景下，构建一个电商网站依然是一项极具挑战性的任务。

In order to be the most effective, we need something more granular to control the static and dynamic parts of our application. This is where Next.js and the introduction of the App Router gives you access to a deeper level of control, allowing you to create storefronts that feel static, but are completely dynamic.

为了实现最高效的开发与运行效果，我们需要一种更细粒度的机制，来分别管控应用中的静态与动态部分。正是在此背景下，Next.js 引入了全新的 App Router，赋予开发者更深层次的控制能力——让你能够构建出“观感如静态、实则全动态”的电商 storefront。

## Performance results

## 性能表现

By leveraging the Next.js App Router's latest features and Vercel’s Frontend Cloud, [Next.js Commerce 2.0 is able to achieve incredible performance](https://pagespeed.web.dev/analysis/https-demo-vercel-store/26y7enx4ag), demonstrating _dynamic at the speed of static_.

借助 Next.js App Router 的最新特性与 Vercel 前端云（Frontend Cloud），[Next.js Commerce 2.0 实现了令人惊叹的性能表现](https://pagespeed.web.dev/analysis/https-demo-vercel-store/26y7enx4ag)，真正诠释了“_动态如静态般迅捷_”这一理念。

When we shared an early preview, a few remarked that the performance of the site felt static. We had to clarify this is a dynamic, server-rendered storefront that performs at the level of a statically cached page. This is possible due to the [new caching architecture](https://nextjs.org/docs/app/building-your-application/caching) in Next.js App Router and the [Vercel Data Cache](https://vercel.com/docs/infrastructure/data-cache).

在早期预览阶段，一些用户反馈称该网站的响应速度“感觉像静态页面一样快”。我们特别说明：这是一个完全动态的服务端渲染 storefront，其性能却可媲美已缓存的静态页面。这一突破得益于 Next.js App Router 中的[全新缓存架构](https://nextjs.org/docs/app/building-your-application/caching) 以及 [Vercel 数据缓存（Data Cache）](https://vercel.com/docs/infrastructure/data-cache)。

To compliment this new release, we also did a minor redesign to give the theme a fresh, modern look.

为配合此次新版本发布，我们还对主题进行了小幅重新设计，使其呈现出清新、现代的视觉风格。

![](images/next_js-commerce-a-headless-shopify-ecommerce-template-built-with-the-app-router/img_003.jpg)![](images/next_js-commerce-a-headless-shopify-ecommerce-template-built-with-the-app-router/img_004.jpg)

Let's walkthrough some Next.js features that made this possible.

接下来，让我们一起了解一些使这一升级成为可能的 Next.js 核心特性。

### Layouts and pages

### 布局（Layouts）与页面（Pages）

App Router 引入了一种全新的基于文件名的路由约定，其中包含 [布局（layouts）和页面（pages）](https://nextjs.org/docs/app/building-your-application/routing/pages-and-layouts)。这使得开发者能够创建并复用全站级的布局与组件（例如页眉和页脚）；尤其在电商场景下，还可轻松构建一个可在网站任意位置访问的购物车。整体用户体验更加流畅迅捷。虽然此前也能实现类似效果，但如今实现起来更为简单高效。

### React Server Components, Streaming, and Suspense

### React 服务端组件（RSC）、流式传输（Streaming）与 Suspense

[React 服务端组件（RSCs）](https://nextjs.org/docs/getting-started/react-essentials#server-components) 使我们能够在服务器端完成尽可能多的工作——包括动态 API 调用——再将完全渲染好的 UI 返回给客户端。这意味着更精简的客户端 JavaScript 包体积，以及更少的客户端请求。同时，也彻底避免了布局偏移（layout shift）、加载旋转图标（loading spinners），并显著缩短了“可交互时间”（Time to Interactive）。

结合 [基于 Suspense 的流式传输（Streaming with Suspense）](https://nextjs.org/docs/app/building-your-application/routing/loading-ui-and-streaming)，我们可以按优先级分块返回 UI 内容——无需等待整页全部就绪。用户因此能更快看到内容。您的网站性能不再受限于最慢的后端接口：屏幕下方（below the fold）的内容可稍后流式加载，而用户首先看到的是上方（above the fold）更即时呈现的关键内容。

- 布局（layout）、页面（page）、页眉（header）及搜索排序筛选器（search sort filters）均在服务端完成渲染，并在首次页面加载时即刻可用。

- 购物车（cart）、搜索分类（search categories）、商品列表（products）及页脚（footer）则各自独立使用 Suspense，在其对应部分准备就绪时再异步加载。

### Data fetching and caching

### 数据获取与缓存

The biggest mental model shift in the App Router is to stop thinking which _pages_ should be static or dynamic and starting thinking about what _data_ is static or dynamic. Moving the static and dynamic decisions to data fetching gives you more control over when and where to serve static or dynamic content.

App Router 中最重大的思维模式转变，是不再思考哪些 _页面_ 应该是静态或动态的，而是转而思考哪些 _数据_ 是静态或动态的。将静态/动态决策下移到数据获取层，使你能够更精细地控制静态或动态内容的生成时机与服务位置。

Using the new data [fetching](https://nextjs.org/docs/app/building-your-application/data-fetching/fetching) and [caching](https://nextjs.org/docs/app/building-your-application/caching) paradigms, revalidation (also known as Incremental Static Regeneration) moves to individual fetching too.

借助 Next.js 新的数据 [获取](https://nextjs.org/docs/app/building-your-application/data-fetching/fetching) 和 [缓存](https://nextjs.org/docs/app/building-your-application/caching) 范式，重新验证（即“增量静态再生”，Incremental Static Regeneration）也下沉到了单次数据获取粒度。

We're using [Shopify's Storefront API](https://shopify.dev/docs/api/storefront), which utilizes GraphQL. GraphQL expects that all requests are `POST` requests. We mimic Next.js built-in functionality of caching all calls by default, except for mutations.

我们使用 [Shopify 的 Storefront API](https://shopify.dev/docs/api/storefront)，该 API 基于 GraphQL。GraphQL 要求所有请求均为 `POST` 请求。我们模拟 Next.js 的内置行为：默认对所有请求进行缓存，但突变（mutations）除外。

lib/shopify/index.ts

`lib/shopify/index.ts`

```javascript
const domain = `https://${process.env.SHOPIFY_STORE_DOMAIN!}`;

const endpoint = `${domain}${SHOPIFY_GRAPHQL_API_ENDPOINT}`;

const key = process.env.SHOPIFY_STOREFRONT_ACCESS_TOKEN!;



export async function shopifyFetch({
```

6  cache = 'force-cache',

6  缓存策略 = '强制缓存',

7  headers,

7  请求头,

8  query,

8  查询（GraphQL 查询字符串）,

9  tags,

9  标签,

10  variables

10  变量

11}) {

11}) {

12  const result = await fetch(endpoint, {

12  const result = await fetch(endpoint, {

13    method: 'POST',

13    方法: 'POST',

14    headers: {

14    请求头: {

15      'Content-Type': 'application/json',

15      'Content-Type': 'application/json',

16      'X-Shopify-Storefront-Access-Token': key,

16      'X-Shopify-Storefront-Access-Token': key,

17      ...headers

17      ...headers

18    },

18    },

19    body: JSON.stringify({

19    body: JSON.stringify({

20      ...(query && { query }),

20      ...(query && { query }),

21      ...(variables && { variables })

21      ...(variables && { variables })

22    }),

22    }),

23    cache,

23    cache,

24    ...(tags && { next: { tags } })

24    ...(tags && { next: { tags } })

25  });

25  });

27  const body = await result.json();

27  const body = await result.json();

29  if (body.errors) {

29  如果 body.errors 存在：

30    throw body.errors[0];

30    抛出 body.errors[0]；

31  }

31  }

33  return {

33  返回：

34    status: result.status,

34    status: result.status,

35    body

35    body

36  };

37}
```

36  }；

37}
```

Shopify fetch wrapper

Shopify 数据获取封装器

Since all data is cached by default, we need a way to trigger revalidation of data when needed. Let's use products as an example.

由于所有数据默认都会被缓存，因此我们需要一种机制，在必要时主动触发数据的重新验证。我们以商品（products）为例说明。

When we update a product description, inventory, etc. in Shopify, we want the site to reflect that change. We also don't want the site make unnecessary calls for this data if it's not changing. So we can cache by default, but add a revalidation tag.

当我们在 Shopify 中更新商品描述、库存等信息时，我们希望网站能及时反映这些变更；同时，若数据未发生变化，我们也不希望网站为此发起不必要的请求。因此，我们可以默认启用缓存，但额外添加一个重新验证标签（revalidation tag）。

lib/shopify/index.ts

`lib/shopify/index.ts`

```javascript
import { getProductQuery } from './queries/product';



const res = await shopifyFetch({

4  query: getProductQuery,
```

```javascript
import { getProductQuery } from './queries/product';



const res = await shopifyFetch({

4  query: getProductQuery,
```

5  tags: ['products'],

5  标签：['products']，

6  variables: {

6  变量：{

7    handle: 'acme-t-shirt'

7    handle: 'acme-t-shirt'

8  }

8  }

9});
```

9});
```

Get a Shopify product specifying a revalidation tag

通过指定重新验证标签（revalidation tag）获取 Shopify 商品

Now we can subscribe to [Shopify webhooks](https://shopify.dev/docs/api/admin-rest/2023-07/resources/webhook) to be notified when product data changes and we can revalidate the product data using [revalidateTag](https://nextjs.org/docs/app/api-reference/functions/revalidateTag).

现在，我们可以订阅 [Shopify Webhook](https://shopify.dev/docs/api/admin-rest/2023-07/resources/webhook)，在商品数据发生变化时收到通知，并使用 [revalidateTag](https://nextjs.org/docs/app/api-reference/functions/revalidateTag) 重新验证商品数据。

app/api/revalidate/route.ts

app/api/revalidate/route.ts

```javascript
import { revalidateTag } from 'next/cache';

import { revalidateTag } from 'next/cache';

import { NextRequest, NextResponse } from 'next/server';
import { NextRequest, NextResponse } from 'next/server';

```javascript
export async function POST(req) {

export async function POST(req) {

5  const productWebhooks = ['products/create', 'products/delete', 'products/update'];

5  const productWebhooks = ['products/create', 'products/delete', 'products/update'];

6  const topic = headers().get('x-shopify-topic') || 'unknown';

6  const topic = headers().get('x-shopify-topic') || 'unknown';

7  const isProductUpdate = productWebhooks.includes(topic);

7  const isProductUpdate = productWebhooks.includes(topic);



9  if (!isProductUpdate) {

9  如果 `isProductUpdate` 为假（即当前主题不属于产品相关事件）：

10    // We don't need to revalidate anything for any other topics.

10    // 对于其他任何主题，我们无需重新验证任何内容。

11    return NextResponse.json({ status: 200 });

11    return NextResponse.json({ status: 200 });

12  }

12  }
```

14  if (isProductUpdate) {

14  如果是商品更新：

15    revalidateTag('products');

15    重新验证标签 `'products'`。

16  }



18  return NextResponse.json({ status: 200, revalidated: true, now: Date.now() });

18  返回 `NextResponse.json({ status: 200, revalidated: true, now: Date.now() })`。

19}
```

19}
```

Revalidate products and collections using Shopify webhooks

使用 Shopify Webhook 重新验证商品与商品集合

### Server Actions

### 服务端操作（Server Actions）

With [Server Actions](https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions-and-mutations), we can colocate server-side data mutations with the UI that is invoking them, eliminating the need to create API routes used only by your application and reducing client-side JavaScript making the bundle size smaller.

借助 [Server Actions](https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions-and-mutations)，我们可以将服务端数据变更逻辑与触发该操作的 UI 组件放在一起，从而无需为应用单独创建仅内部使用的 API 路由，并可减少客户端 JavaScript 代码量，进而缩小打包体积。

components/cart/add-to-cart.tsx

components/cart/add-to-cart.tsx

```jsx
1'use client';



import { addItem } from 'components/cart/actions';

import { useRouter } from 'next/navigation';

import { useTransition } from 'react';



export function AddToCart({selectedVariantId}) {

8  const router = useRouter();

9  const [isPending, startTransition] = useTransition();
```

```jsx
1'使用客户端组件';



import { addItem } from 'components/cart/actions';

import { useRouter } from 'next/navigation';

import { useTransition } from 'react';



export function AddToCart({selectedVariantId}) {

8  const router = useRouter();

9  const [isPending, startTransition] = useTransition();
```

11  return (

11  返回（

12    <button

12    <button

13      aria-label="Add item to cart"

13      aria-label="将商品加入购物车"

14      disabled={isPending}

14      disabled={isPending}

15      onClick={() => {

15      onClick={() => {

16        startTransition(async () => {

16        startTransition(async () => {

17          const error = await addItem(selectedVariantId);



17          const error = await addItem(selectedVariantId);



19          if (error) { 

19          if (error) {

20            alert(error);

20            alert(error);

21            return;

21            返回；

22          }



22          }



24          router.refresh();

24          router.refresh();

25        });

25        });

26      }}

26      }}

27    >

27    >

28      'Add To Cart'

28      “加入购物车”

29    </button>

29    </button>

30  );

30  );

31}
```

31}
```

Next.js Commerce add to cart button

Next.js Commerce “加入购物车”按钮

components/cart/actions.ts

components/cart/actions.ts

```javascript
1'use server';



import { addToCart, createCart, getCart } from 'lib/shopify';

import { cookies } from 'next/headers';



export const addItem = async (variantId) => {
```

7  let cartId = cookies().get('cartId')?.value;

7  let cartId = cookies().get('cartId')?.value;

8  let cart;

8  let cart;

10  if (cartId) {

10  如果 cartId 存在：

11    cart = await getCart(cartId);

11    cart = await getCart(cartId);

12  }

12  }

14  if (!cartId || !cart) {

14  如果 cartId 不存在或 cart 为空：

15    cart = await createCart();

15    cart = await createCart();

16    cartId = cart.id;

16    cartId = cart.id;

17    cookies().set('cartId', cartId);

17    cookies().set('cartId', cartId);

18  }

18  }

20  if (!variantId) {

20  如果未提供 variantId：

21    return new Error('Missing variantId');

21    返回 new Error('缺少 variantId')；

22  }

22  }

23  try {

23  尝试：

24    await addToCart(cartId, [{ merchandiseId: variantId, quantity: 1 }]);

24    等待 addToCart(cartId, [{ merchandiseId: variantId, quantity: 1 }]) 执行完成；

25  } catch (e) {

25  } catch (e) {

26    return new Error('Error adding item', { cause: e });

26    返回 new Error('添加商品时出错', { cause: e })；

27  }

28};
```

Next.js Commerce add to cart button Server Action

Next.js Commerce “加入购物车”按钮的 Server Action

## Repository strategy

## 仓库策略

The previous architecture of Next.js Commerce `v1` was a multi-vendor, interoperable solution, including integrations with ten e-commerce providers. For `v2`, we removed roughly 145,000 lines of code making the project more straightforward, maintainable, and easier to understand while also highlighting the latest features of the Next.js App Router.

Next.js Commerce `v1` 的原有架构是一个面向多供应商、具备互操作性的解决方案，集成了十家电商平台。在 `v2` 版本中，我们移除了约 145,000 行代码，使项目结构更清晰、更易维护、更易理解，同时也更突出展示了 Next.js App Router 的最新特性。

Providers are able to fork the Next.js Commerce repository add support for their platform. We’re delighted that our partners [BigCommerce](https://github.com/bigcommerce/nextjs-commerce), [Medusa](https://github.com/medusajs/vercel-commerce), [Saleor](https://github.com/saleor/nextjs-commerce), and [Swell](https://github.com/swellstores/verswell-commerce) have embraced this new vision and already have [templates and demos](https://github.com/vercel/commerce#providers) using Next.js Commerce 2.0 ready to go. If you want to add support for your platform, follow the [instructions](https://github.com/vercel/commerce#providers) and open a pull request to add yours to the list.

各平台供应商可自行 Fork Next.js Commerce 仓库，并为其平台添加支持。我们非常高兴地看到合作伙伴 [BigCommerce](https://github.com/bigcommerce/nextjs-commerce)、[Medusa](https://github.com/medusajs/vercel-commerce)、[Saleor](https://github.com/saleor/nextjs-commerce) 和 [Swell](https://github.com/swellstores/verswell-commerce) 已积极采纳这一新愿景，并已上线基于 Next.js Commerce 2.0 的[模板与演示示例](https://github.com/vercel/commerce#providers)。如您希望为自家平台提供支持，请参阅[相关说明](https://github.com/vercel/commerce#providers)，并提交 Pull Request 将您的集成加入列表。

To get started with your own ecommerce store, you can deploy your own version of Next.js Commerce 2.0 + Shopify by [visiting the template page](https://vercel.com/templates/next.js/nextjs-commerce) and using our one click to deploy button.

如需快速搭建您自己的电商网站，只需[访问模板页面](https://vercel.com/templates/next.js/nextjs-commerce)，点击一键部署按钮，即可轻松部署 Next.js Commerce 2.0 + Shopify 版本。