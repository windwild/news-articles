---
title: "Next 3.0 Preview: Static Exports and Dynamic Imports - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/next3-preview"
date: "2017-05-15"
scraped_at: "2026-03-02T10:08:05.850461022+00:00"
language: "en"
translated: false
description: "Next 3.0 features Static Exports with one command and Dynamic Imports"
---




May 15, 2017

On the heels of our announcement of free static deployments earlier today, we are excited to introduce a beta release of the upcoming [Next.js](https://github.com/zeit/next.js) 3.0, featuring `next export`, dynamic components and various bugfixes.

Next.js allows you to write React applications with server-rendering, automatic code-splitting, built-in component CSS with one command. To get started, populate `pages/my-route.js` directory with a file that exports a component:

```javascript
export default () => (

2  <p>Welcome to my React App!</p>

3)
```

Install it with `npm install next react react-dom`, run `next` and navigate to `http://localhost:3000/my-route`. That's it! To learn more, read the [5-minute README](https://github.com/zeit/next.js) or check out our [2.0 announcement blogpost](https://vercel.com/blog/next2).

## Next-Export

Until today, you would run `next` to develop, `next build` to compile the production app and `next start` to serve it.

We are now introducing a new subcommand: `next export`. It will seamlessly build your Next.js app as a standalone static website. This means you can deploy it without a server at all!

The exported app supports almost every feature of [Next.js](https://github.com/zeit/next.js), including dynamic URLs, prefetching, preloading and the new dynamic imports.

Let's walk through an example.

### How to Use

Simply [develop](http://learnnextjs.com/) your app as you normally do with Next.js. Then create a [custom Next.js config](https://github.com/zeit/next.js#custom-configuration) like this one:

next.config.js

```javascript
exports.exportPathMap = () => ({

2  "/": { page: "/" },

3  "/about": { page: "/about" },

4  "/p/hello-nextjs": { page: "/post", query: { title: "hello-nextjs" } },

5  "/p/learn-nextjs": { page: "/post", query: { title: "learn-nextjs" } },

6  "/p/deploy-nextjs": { page: "/post", query: { title: "deploy-nextjs" } }

7})
```

This is a simple map of paths to pages, with optional query parameters to supply to `getInitialProps`. When you are ready to go to production, simply run:

```bash
next build

next export
```

For that, you may need to add a script to `package.json` like this:

```json
1{

2  "scripts": {

3    "build": "next build && next export"

4  }

5}
```

And run it at once with:

```bash
npm run build
```

This will result in a static version of your app in the `out` directory. This also is customizable! Run `next export -h` to see all the available options.

Now you can deploy it! Simply `cd` to the `out` directory and run following command to deploy your app to  instantly for free.

```bash
vercel
```

### Known Limitations

With `next export`, we build an HTML version of your app. At that time, we will automatically execute the `getInitialProps` functions of your pages and store the results.

This means you can only use `pathname`, `query` and `asPath` fields of the `context` object passed to `getInitialProps`. You cannot use `req` or `res` fields, because those require a server runtime.

Basically, you will not be able to render content dynamic in the server as we prebuilt HTML files. If you need that, you need run your app with `next start`.

## Dynamic Imports

Next.js 3.0 comes with [TC39 dynamic import](https://github.com/tc39/proposal-dynamic-import) support. This means `import()` is generally available throughout your codebase to fetch modules dynamically as a `Promise`.

With a higher-order component helper `next/dynamic`, you can now take those promises and turn them into real components!

```javascript
import dynamic from 'next/dynamic'



const DynamicComponent1 = dynamic(import('@components/hello1'))

const DynamicComponent2 = dynamic(import('@components/hello2'))



export default () => (

7  <div>

8    <Header />

9    <DynamicComponent />

10    <p>HOME PAGE is here!</p>

11  </div>

12)
```

In this case, the `DynamicComponent1` or `DynamicComponent2` will not be included in the main app bundle included with the page. Instead, they will be lazily downloaded on the client side.

Since we are actually rendering `DynamicComponent1`, when you server-render or export the relevant `<script>` will be included and loaded in parallel with the rest of the scripts.

As eloquently explained by [James Kyle](https://medium.com/@thejameskyle/react-loadable-2674c59de178), dynamic loadable components give you more granularity for code splitting.

Consider, for example, the use case of a long chat thread with different message types. If you simply rely on static `import` declarations for code splitting, you will end up loading message types on the client that are not required in many cases!

## Server Side Rendering

Next.js supports server side rendering for dynamic imports. For an example, in the above example, we will load `DynamicComponent1` on the server side and render it synchronously.

This is a unique feature of Next.js which makes Dynamic Imports incredibly powerful.

Concretely, you get all the benefits of dynamic imports, but you avoid showing the clients blank pages, flickering or loading spinners.

## Get it Now!

Next.js 3.0 is completely backwards-compatible and ready for experimentation and pre-production use. The APIs might change slightly but we don't expect to alter them in significant ways.

- Run `npm install next@beta`.

- Check out the up-to-date [documentation](https://github.com/vercel/next.js/tree/canary#readme).

- Have a look at [this example app](https://github.com/vercel/next.js/tree/canary/examples/with-dynamic-import).

- Join the Vercel Community `#next` channel to ask any questions or get in touch with us!