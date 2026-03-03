---
title: "10 Next.js tips you might not know - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/10-next-js-tips-you-might-not-know"
date: "2021-01-26"
scraped_at: "2026-03-02T10:05:58.384677709+00:00"
language: "en"
translated: false
description: "Discover 10 expert Next.js tips including redirects, rewrites, preview mode, API routes, and performance optimizations to boost your development workflow. "
---




Jan 26, 2021

Techniques from the Next.js experts that empower your application.

Here are 10 little known Next.js tips you might not have heard that could help you save time on your next project:

- [**Next.js Redirects**](https://vercel.com/blog/10-next-js-tips-you-might-not-know#tip-1-next.js-redirects)

- [**Next.js Rewrites**](https://vercel.com/blog/10-next-js-tips-you-might-not-know#tip-2-next.js-rewrites)

- [**Next.js Preview Mode**](https://vercel.com/blog/10-next-js-tips-you-might-not-know#tip-3-next.js-preview-mode)

- [**Hooking Into the Build Process**](https://vercel.com/blog/10-next-js-tips-you-might-not-know#tip-4-hooking-into-the-build-process)

- [**Next.js With Preact**](https://vercel.com/blog/10-next-js-tips-you-might-not-know#tip-5-next.js-with-preact)

- [**Absolute Imports and Module Path Aliases**](https://vercel.com/blog/10-next-js-tips-you-might-not-know#tip-6-absolute-imports-and-module-path-aliases)

- [**CRUD API Routes**](https://vercel.com/blog/10-next-js-tips-you-might-not-know#tip-7-crud-api-routes)

- [**Setting Response HTTP Caching Headers**](https://vercel.com/blog/10-next-js-tips-you-might-not-know#tip-8-setting-response-http-caching-headers)

- [**Shared Component Attributes**](https://vercel.com/blog/10-next-js-tips-you-might-not-know#tip-9-shared-component-attributes)

- [**Next.js Mobile Applications?**](https://vercel.com/blog/10-next-js-tips-you-might-not-know#tip-10-next.js-mobile-applications)


Vercel's Lee Robinson gives a quick overview on 10 little known tips on Next.js

## Tip 1: Next.js Redirects

[Next.js Redirects](https://nextjs.org/docs/api-reference/next.config.js/redirects) are new to version 9.5 (released in July 2020) and give the ability to reroute an incoming request path to another destination.

Path matching, regex path matching, and wildcard paths are all valid ways to reroute your source path. Use the `redirects` key to create an asynchronous function that will return an array of objects where each object contains the properties for a redirect in the application.

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

For more usage examples, take a look at this [next.config.js](https://github.com/vercel/next.js/blob/canary/examples/redirects/next.config.js) file.

## Tip 2: Next.js Rewrites

[Rewrites](https://nextjs.org/docs/api-reference/next.config.js/rewrites) were also introduced in Next.js 9.5 and work similar to redirects. Where a redirect will reroute a page with a 301/302 status code, a rewrite will act as a proxy and mask the new path. This will make it appear to the user that they have not changed where they are on the site.

The same rules apply for rewrites as they do for redirects except that rewrites are not able to overwrite public files or the routes that are automatically generated from the `pages` folder. These routes take precedence over rewrites.

next.config.js

```javascript
module.exports = {

2  async rewrites() {

3    return [\
\
4      {\
\
5        source: '/about',\
\
6        destination: '/',\
\
7      },\
\
8    ]

9  },

10}


```

To take a look at how rewrites look using regex or wildcard paths, take a look at this [next.config.js](https://github.com/vercel/next.js/blob/canary/examples/rewrites/next.config.js) file.

## Tip 3: Next.js Preview Mode

[Preview Mode](https://vercel.com/docs/next.js/preview-mode) allows you to see a draft of your statically-generated content prior to publishing it to the web. Next.js has the ability to generate these draft pages at request time instead of build time so that developers can see what their content will look like when published.

Take a look at the Next.js [Preview Mode documentation](https://nextjs.org/docs/advanced-features/preview-mode) for detailed information on how to build this out or test out Preview Mode before constructing it on your own with this [example Vercel application](https://next-preview.vercel.app/).

## Tip 4: Hooking into the Build Process

With Next.js, we can use the `next.config.js` file to override defaults, configure Webpack, or inject code into the build process. By running a script during the build process to inject code, Next.js can create a [sitemap](https://leerob.io/blog/nextjs-sitemap-robots), RSS feed, or a search index with ease.

## Tip 5: Next.js With Preact

If you’re building a basic Next.js application and not using advanced React functionality, you can explore using Preact with Next.js. For more information about Preact, check our their [documentation](https://preactjs.com/).

You can use Preact only in the client production build so you don’t miss any features of the Next.js local development experience. Use `next.config.js` to override the default Webpack configuration and use Preact.

New features in React may not be compatible with Preact (i.e. Suspense or Server Components) .

next.config.js

```javascript
module.exports = {

2  webpack: (config, { dev }) => {

3    // Replace React with Preact only in client production build

4    if (!dev) {

5      Object.assign(config.resolve.alias, {

6        react: 'preact/compat',

7        'react-dom/test-utils': 'preact/test-utils',

8        'react-dom': 'preact/compat'

9      });

10    }



12    return config;

13  }

14};


```

## Tip 6: Absolute Imports and Module Path Aliases

As your application grows, you might end up with deeply nested import statements. To prevent the import statements’ relative paths from becoming excessive, you can use [Absolute Imports and Module Path Aliases](https://nextjs.org/docs/advanced-features/module-path-aliases) to make them more readable.

This, for example, will turn:

```javascript
import Button from “../../../components/button”;
```

to:

```javascript
import Button from “@/components/button”;
```

It creates a much shorter string that is easier to read. Now instead of being an import with a relative path, it is an absolute import.

To set this up, create a JSON file. Inside this file, create a `compilerOptions` object inside a JSON object that will contain a `baseUrl` that is a string and `paths` property that is an object.

Your configuration file for absolute imports should look something like this:

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

The `baseUrl` property indicates that the base of the absolute import starts in the same directory that the configuration file is in. The `paths` object sets up the string we will use for the module alias as the key.

The value is an array that contains the relative path to the folder we are wanting to make the alias. The asterisk on the end of the key and value mean that any file or directory in the components folder can follow the same convention.

This structure is not necessary to create your project, but is a great way to make your import statements a little easier to read.

## Tip 7: CRUD API Routes

CRUD stands for **C** reate, **R** ead, **U** pdate, and **D** elete — all are common HTTP methods used in an application programming interface (API) that POST, GET, PUT, and DELETE data.

We have the ability to build basic CRUD endpoints using the [built-in Next.js router.](https://nextjs.org/docs/routing/introduction) Create a folder inside `pages` called `api`. Inside `api` create a file with a `.js` or `.ts` extension that will contain the handler for all of our CRUD methods.

Here’s a high-level outline of how an API might look:

pages/api/item.js

```javascript
export default async function handler(req, res) {

2  if (req.method === 'PUT') {

3    res.status(201).json({});

4  }



6  if (req.method === 'GET') {

7    res.status(200).json({});

8  }



10  if (req.method === 'POST') {

11    res.status(200).json({});

12  }



14  if (req.method === 'DELETE') {

15    res.status(204).json({});

16  }

17}


```

The actual setup used to define these endpoints may vary depending on how the app is constructed.

## Tip 8: Setting Response HTTP Caching Headers

For static pages, the [Vercel Edge Network](https://vercel.com/docs/edge-network/overview) will automatically [cache](https://vercel.com/docs/edge-network/caching) static assets in order to serve data as fast as possible. When there is a need to use an API Route or Server-Side Rendered page, though, you will need to set a `Cache-Control` header.

Here’s an example API Route that sends a JSON response and caches that response for one day:

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

When working with Next.js applications, sometimes there is a need to share information between pages. This is done by creating a [\_app.js](https://nextjs.org/docs/advanced-features/custom-app) file in the pages folder.

pages/index.js

```javascript
Home.title = "test"

Home.description = "A container for blog posts"



export default function Home() {

5    return (

6        <Container>

7            <Blogpost />

8        </Container>

9    )

10}
```

pages/\_app.js

```javascript
import Head from 'next/head'



export default function App({ Component, pageProps }) {

4  return (

5    <>

6      <Head>

7        <title>{Component.title}</title>

8        <meta name="description" content={Component.description} />

9      </Head>

10      <Component {...pageProps} />

11    </>

12  )

13}
```

This is just one way to take advantage of the customized app. There are several different things a developer can do when creating a custom app including global CSS, shared layout, maintain state, and more.

## Tip 10: Next.js Mobile Applications?

You can create a mobile app with Next.js? How is that possible!?

Thanks to the Ionic team, you can build mobile-like experiences using Next.js. They are the creator of CapacitorJS, a library that will give you a native-like experience on your mobile phone.

![The Mobile Stack Visualized](images/10-next_js-tips-you-might-not-know-vercel/img_001.jpg)The Mobile Stack Visualized

Learn more about Ionic's Next.js/Tailwind CSS/Capacitor starter [here](https://capacitorjs.com/blog/mobile-apps-with-tailwind-css-nextjs-ionic-and-capacitor).

## Next Steps

That’s it! How many of these tips are you going to implement in your next project?

If you have never used Next.js before, start with this tutorial on creating [your Next.js application](https://nextjs.org/learn/).

If you have never written any React code before, start with [React’s official tutorial](https://reactjs.org/tutorial/tutorial.html). This will help you get a firm grasp on JavaScript and React prior to using Next.js.

For the easiest way to deploy a Next.js app, start with this [introduction](https://vercel.com/docs) to Vercel. Vercel, built by the same team that made Next.js, provides production-grade hosting for Next.js websites with zero configuration.