---
title: "How to improve performance with Next.js - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/upgrading-nextjs-for-instant-performance-improvements"
date: "2022-03-17"
scraped_at: "2026-03-02T10:02:27.675275223+00:00"
language: "en"
translated: false
description: "Learn how Next.js provides a toolkit to improve site performance, improve the developer experience, and decrease build times with every upgrade."
---




Mar 17, 2022

Since the release of Next.js, we’ve worked to introduce new features and tools that drastically improve application performance, as well as overall developer experience.

Let’s take a look at what a difference upgrading to the latest version of Next.js can make.

In 2019, our team at Vercel created a serverless demo app called [VRS (Virtual Reality Store)](https://serverless-vrs.vercel.app/) using Next.js 8, Three.js, Express, MongoDB, Mongoose, Passport.js, and Stripe Elements. Users could sign up, browse multiple 3D models, and purchase them.

Although this demo is still fully functional three years later, it lacked some of the performance improvements that were added over the years.

![](images/how-to-improve-performance-with-next_js-vercel/img_001.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_002.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_003.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_004.jpg)

By upgrading the demo app to Next.js 12, we were able to vastly improve our [Core Web Vitals](https://vercel.com/blog/core-web-vitals) and go from an average performance score of 32 to 99.

![](images/how-to-improve-performance-with-next_js-vercel/img_005.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_006.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_005.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_006.jpg)

Let's explore the changes we made to improve performance and streamline the developer experience using new Next.js features.

## Using `getStaticProps` and `getStaticPaths`

The old implementation relied on a separate backend folder that contained a custom Express server, which exposed an `/api/checkout` endpoint to handle payments, `/api/get-products` to fetch data used to render all models, and the `/api/get-product/:id` endpoint to fetch the data for a specific model.

When a user navigated from the landing page to the `/store` page, `getInitialProps` would make a request to the `/api/get-products` endpoint to retrieve data for the shown models.

The store page was only visible to the user once the request had been resolved. This could take a while, depending on the quality of their internet connection.

![](images/how-to-improve-performance-with-next_js-vercel/img_009.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_010.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_011.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_012.jpg)

Next.js 9 introduced `getStaticProps`, which allows developers to fetch data at build time. Unlike `getInitialProps`, this function **always runs server-side**! The code written inside this function _won’t_ be included in the JavaScript bundle sent to the client, so it’s safe to write server-side code directly in `getStaticProps`.

Instead of relying on external API endpoints to fetch the data needed to render the models on the `/store` page, this data is available to us instantly when navigating to the page.

Static Site Generation using `getStaticProps` is especially powerful when it’s used in combination with the `<Link />` component. This component prefetches pages as soon as their link appears in the viewport. When the user actually clicks on the link, no additional requests have to be made in order to render the page: Next.js will use the data that’s already been prefetched!

![](images/how-to-improve-performance-with-next_js-vercel/img_013.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_014.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_015.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_016.jpg)

Although the user hadn’t clicked the "Store" link yet, the `store.js` and `store.json` files that are necessary to render the store page had already been prefetched. Using `getStaticProps` with the `<Link />` component drastically improves the responsiveness of the application.

You might notice that the time it takes to fetch the thumbnails has also been reduced tremendously. We were able to do this by replacing the native `<img />` tag in favor of the `<Image />` component.

## Using `next/image`

The `<Image />` component was introduced in Next.js 10 and further improved in later versions, allowing developers to efficiently serve images using modern image formats without [layout shift](https://nextjs.org/learn/seo/web-performance/cls).

The performance improvement is instantly noticeable when we compare the loading time of the `/store` page, which renders an image for each model thumbnail.

![Loading the /store page using Next.js 8 without next/image](images/how-to-improve-performance-with-next_js-vercel/img_017.jpg)![Loading the /store page using Next.js 8 without next/image](images/how-to-improve-performance-with-next_js-vercel/img_017.jpg)Loading the /store page using Next.js 8 without next/image

![Loading the /store page using Next.js 12 with next/image](images/how-to-improve-performance-with-next_js-vercel/img_019.jpg)![Loading the /store page using Next.js 12 with next/image](images/how-to-improve-performance-with-next_js-vercel/img_019.jpg)Loading the /store page using Next.js 12 with next/image

Let’s look at the differences between using the native `<img />` tag, and using the `<Image />` component.

### Next-gen image format

The `<Image />`component serves the next-gen image format `webp`format. Images using this format are 25-35% smaller than JPEG files with the exact same quality index. This difference is clearly visible when comparing the sizes of the fetched images: whereas the red car model’s image used to be 1.3MB in the old implementation, we were able to reduce the size by **-98.75%** to only 16.6kB by using the `<Image />`component.

### Lazy Loading

The old implementation requested the images for all models, resulting in 12 fetch requests. The `<Image />` component only fetches the image once it detects the intersection of the viewport with the image’s bounding box.

Although no changes had to be made to the images themselves, we were able to decrease the image loading time from an average of ~3000ms down to ~270ms.

## **Dynamic Routes**

When browsing through the store, users can click on each item to better view the model.

The old implementation used a combination of query parameters and `getInitialProps` to render the page and fetch the needed data to render each model. Similar to what we saw on the `/store` page, the user can only see the model once the API request initiated within the `getInitialProps` function has resolved.

Next.js 9 introduced file-system-based [dynamic routes](https://nextjs.org/docs/routing/dynamic-routes). In combination with the new `getStaticPaths` function used together with `getStaticProps`, this feature makes it possible to dynamically pre-render the model pages based on their id.

Instead of having one model page and using `getInitialProps` and query parameters to determine which data to fetch and what model to render, we can directly use a path parameter to generate pages for each model statically.

By wrapping each model card in the grid in a `<Link />` component, we can prefetch each `/model/[id]` page once the card appears in the viewport, allowing instant navigation when a user clicks on the card.

## API Routes

Next.js 9 introduced [API Routes](https://nextjs.org/docs/api-routes/introduction), making it easy to create API endpoints from within the `/pages` folder.

Although we could replace the `/api/get-products` and `/api/get-product/:id` endpoints by using `getStaticProps`, we still need the `/api/checkout` endpoint to handle payments on the server-side.

This endpoint cannot be replaced with the `getStaticProps` method, since it needs to be available to the client during runtime with values that are unknown during build time. When a user purchases an item, the client makes a call to this endpoint using the unique token that was generated for their card.

Instead of hosting our own server to provide this endpoint, we can recreate this endpoint as an API Route instead!

![](images/how-to-improve-performance-with-next_js-vercel/img_021.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_022.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_021.jpg)![](images/how-to-improve-performance-with-next_js-vercel/img_022.jpg)

### NextAuth.js

The old implementation also had user authentication using Passport.js. To more easily add authentication to our application, we can take advantage of [NextAuth.js](https://next-auth.js.org/), which simplifies this process to a few lines of code with support for 50+ providers.

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

Code snippet using NextAuth.js

Since all endpoints have been replaced, we no longer need a separate backend folder! We can use the frontend folder as the project's root folder, simplifying the project architecture significantly.

## Import on Interaction

Some components aren’t instantly visible to the user. Instead of including them in the main JavaScript bundle, we can dynamically import these components using `next/dynamic`.

One of these components is the `CartSidebar`. This component is imported in the `Nav` component and is only visible to the user when they click on the cart icon or add an item to the cart.

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

Before using a dynamic import

Instead of statically importing this component, we can tell Next.js to create a separate JavaScript chunk for this component through code-splitting. That way, we can delay the import of this non-critical component, and only fetch it on-demand once the user actually requires it.

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

11  )

12}
```

Since the `CartSidebar` component is the only component in the application that imported and used third-party libraries for payments (Stripe), we were also able to defer the imports of these libraries until the moment the user actually needed them (instead of unnecessarily fetching unused code).

This resulted in sending less initial JavaScript to the user and improving page loading performance.

## Automatic Font Optimization

[Automatic Font Optimization](https://nextjs.org/docs/basic-features/font-optimization) is available since Next.js 10 and automatically inlines font CSS at build time, eliminating an extra round trip to fetch font declarations.

```javascript
1<link href="https://fonts.googleapis.com/css?family=Space+Mono" rel="stylesheet">
```

Before enabling automatic font optimization

```javascript
1<style data-href="https://fonts.googleapis.com/css2 family=Space+Mono&amp;display=swap">

2 @font-face{font-family:'Space Mono';font-style:normal;...

3</style>
```

After enabling automatic font optimization

This means that font declarations no longer have to be fetched, improving initial page load performance.

![Before enabling automatic font optimization](images/how-to-improve-performance-with-next_js-vercel/img_025.jpg)![Before enabling automatic font optimization](images/how-to-improve-performance-with-next_js-vercel/img_025.jpg)Before enabling automatic font optimization

![After enabling automatic font optimization ](images/how-to-improve-performance-with-next_js-vercel/img_027.jpg)![After enabling automatic font optimization ](images/how-to-improve-performance-with-next_js-vercel/img_027.jpg)After enabling automatic font optimization

We were able to reduce the number of requests needed to load the font from 4 to 2 just by upgrading to the latest version.

## Developer experience

Besides performance optimizations, the developer experience has also massively improved over the years.

### **Built-in TypeScript support**

Whereas adding TypeScript support required quite a bit of custom configuration, Next.js 9 added support for [TypeScript out of the box](https://nextjs.org/docs/basic-features/typescript)! We no longer have to deal with our own config, but instead can start using TypeScript by adding a `tsconfig.json` file to the root of existing projects, or by running `npx create-next-app --ts` for newly created projects.

### **Faster builds through SWC**

Next.js 12 includes a new [Rust-based compiler](https://nextjs.org/docs/advanced-features/compiler) built on SWC that takes advantage of native compilation. We reduced our build time from `~90s`down to `~30s` just by upgrading the Next.js version.

### **React Fast Refresh**

[Fast Refresh](https://nextjs.org/docs/basic-features/fast-refresh) is a Next.js feature enabled in all Next.js apps on version 9.4 or newer. It provides instantaneous feedback on edits made to your React components within a second without losing component state. The introduction of SWC in Next.js 12 improved the refresh rate significantly, resulting in **3x faster refreshes** compared to prior versions.

## Conclusion

The improvements and new features Next.js has introduced over the past couple of years have made it easy to create fast fullstack applications, all while ensuring backward compatibility and making incremental adoption to new versions possible.

By upgrading to the latest version, we were able to vastly optimize our application and developer experience with minimal effort on our end.

[Try out the upgraded demo](https://serverless-vrs.vercel.app/) or [view the full PR](https://github.com/vercel/vrs/pull/50) for the upgrade. If you'd like to upgrade your Next.js app, check out our [upgrade guide](https://nextjs.org/docs/upgrading).