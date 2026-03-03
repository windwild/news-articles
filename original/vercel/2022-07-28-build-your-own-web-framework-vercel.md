---
title: "Build your own web framework - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/build-your-own-web-framework"
date: "2022-07-28"
scraped_at: "2026-03-02T10:01:54.630876457+00:00"
language: "en"
translated: false
description: "Build your own web framework that deploys to edge and serverless infrastructure."
---




Jul 28, 2022

Deploy any framework to Vercel using the Build Output API.

Have you ever wondered what it takes to build your own web framework that also deploys to edge and serverless infrastructure? What features does a modern framework need to support, and how can we ensure that these features allow us to build a scalable, performant web application?

This post will explain how to build your own simple React-based web framework. We'll use the [Vercel Build Output API](https://vercel.com/docs/build-output-api/v3) to deploy our framework with support for the following features:

- **Static Files** to statically render pages

- **Incremental Static Regeneration** to automatically revalidate and regenerate pages after a specific timeout

- **Edge Functions** to enable edge rendering and middleware

- **Automatic Image Optimization** to efficiently serve the images using the latest format, enable lazy loading, and prevent layout shift

- **Serverless Functions** to server-render dynamic pages and create data fetching endpoints

- **Edge Caching** to quickly serve static files to users globally


The source code for this article is available in [this GitHub Repo](https://github.com/lydiahallie/byof-demo) to see the demo implementation covered in this article.

The implementation of this demo framework is simplified. Production frameworks usually do more to create an optimized output, such as more advanced bundling, caching, type checking, and more. This blog post demonstrates how to create a basic yet functional example and deploy it to Vercel using the Build Output API.

### Landing Page

Let's explore the requirements of each page we want to build and how to build optimizations into our web framework to help achieve excellent performance.

![Demo website's landing page](images/build-your-own-web-framework-vercel/img_001.jpg)![Demo website's landing page](images/build-your-own-web-framework-vercel/img_002.jpg)Demo website's landing page

The landing page is a static page with a single large hero image. Although this page may seem simple, there are a few optimizations we can implement in our framework to ensure this page is fast.

**Image Optimization**

We can reduce the image size without sacrificing quality by using the latest image formats (like `.webp` and `.avif`) and prevent [layout shift](https://vercel.com/blog/core-web-vitals#cumulative-layout-shift) by explicitly setting the image width and height.

**Edge Caching**

Since we want our framework to generate a static HTML file for this page, we can use a CDN to improve the Time To First Byte (TTFB) by caching the file at each region (or edge). Vercel provides this functionality out of the box with the [Edge Network](https://vercel.com/docs/concepts/edge-network/overview), so we don't need to add this ourselves.

### Products Page

![Demo website's product page](images/build-your-own-web-framework-vercel/img_003.jpg)![Demo website's product page](images/build-your-own-web-framework-vercel/img_004.jpg)Demo website's product page

The products page is a hybrid between a pre-generated static HTML page and a dynamic server-rendered page. The page renders a list of products retrieved from a data provider and should automatically update after a certain amount of time (or when new products have been added).

This product page can benefit from a few optimizations we want to build into our framework.

**Image Optimization**

Since we're showing many images on this page, we want to use image optimization to serve the images in the latest format and defer the loading of non-critical images for a faster [first paint](https://nextjs.org/learn/seo/web-performance/lcp).

**Incremental Static Regeneration**

Displayed products should update after a certain amount of time or when new products are added. This rendering pattern is also referred to as [Incremental Static Regeneration](https://vercel.com/blog/how-hashicorp-developers-iterate-faster-with-isr) behavior and gives you the benefits of Static Generation, combined with the dynamic benefits of Server-Side Rendering. When using the Build Output API, we can use Prerender Functions to enable and configure ISR on certain pages.

## Popular Page

![Demo website's popular page](images/build-your-own-web-framework-vercel/img_005.jpg)![Demo website's popular page](images/build-your-own-web-framework-vercel/img_006.jpg)Demo website's popular page

We want to display the most relevant, personalized products to our visitors. How can our web framework help enable us to add this feature?

**Edge Functions**

To get the visitor’s location, we can use an Edge Function to determine the city based on the `x-vercel-ip-city` header. We could take two approaches to Edge Functions: either use [Edge Middleware](https://vercel.com/edge) to redirect the user to a specific page based on their location, _or_ we can server-render the page using [Edge Functions](https://vercel.com/edge). We’ll choose server-rendering for a fast, personalized page in this case.

## Building the framework

We now know what features our website could benefit from to create a better user experience. Next, let’s focus on implementing our framework to ensure it supports all the features mentioned above.

Our framework expects the pages to be located in the `pages/` folder. To keep it simple, we’ll expect that the page contains:

- A default `export` to export the page’s React component

- A configuration object named `pageConfig`, which includes a `strategy` prop to define the rendering technique that should be used for this page - either `static`, `ssr`, `prerender`, or `edge` . If a page is prerendered, users can also pass an optional  `expiration`time and `fallback` component to configure the regeneration


Let's see how our framework can work with these values and create a valid output Vercel can use to deploy our project.

## Static Rendering

When a page is statically rendered, the page’s HTML is generated during the build. Vercel's Edge Network can quickly return this pre-generated HTML file when a user visits the page, after which the browser can draw the contents to the user’s screen.

To support static pages, we first have to implement a transpilation step that turns React-based pages into static HTML. ReactDOM Server exposes a method called `renderToString`, which takes a React component and returns the corresponding HTML output. We can invoke this function to prerender the HTML for static pages during the build.

```javascript
function createStaticPage(pagePath) {

2  const { Component } = require(pagePath);

3  const pageHTML = `<div id="root">${ReactDOMServer.renderToString(Component)</div>`;

4  ...

5}
```

In most cases, however, our React components aren’t _entirely_ static. Components usually contain some interactivity, such as event handlers. To account for this, we also need to create one or multiple [JavaScript bundle(s)](https://nextjs.org/learn/foundations/how-nextjs-works/bundling) to _hydrate_ the static markup once it’s been rendered.

To hydrate dynamic components, we can export a string literal that our bundler eventually uses to create a custom hydration script for the individual pages. A bundler can generate HTML and automatically inject this custom hydration script as a deferred script. The script automatically fetches the hydration bundle to add interactivity when a browser has loaded the page's HTML.

![](images/build-your-own-web-framework-vercel/img_007.jpg)![](images/build-your-own-web-framework-vercel/img_008.jpg)![](images/build-your-own-web-framework-vercel/img_009.jpg)![](images/build-your-own-web-framework-vercel/img_010.jpg)

Let’s see what this could look like in our code.

The example below shows a dynamic `createStaticFile` method that takes our page’s default exported component and the `filePath` where the component is located. With this information, we can create a bundle that automatically gets injected into the newly created HTML file and output it to the `.vercel/output/static` folder.

```javascript
export async function createStaticFile(Component,filePath) {

2  const pageName = getPageName(filePath);

3  const outdir = join(".vercel", "output", "static");

4  await fs.ensureDir(outdir);



6  await generateClientBundle({ filePath, outdir, pageName });



8  return fs.writeFileSync(

9    path.join(outdir, `${pageName}.html`),

10    `<!DOCTYPE html>

11      ...

12      <body>

13        <div id="root">${ReactDOMServer.renderToString(React.createElement(Component) )}</div>

14        <script src="${pageName}.bundle.js" defer></script>

15      </body>`

16  );

17}
```

At build time, we end up with a `.vercel/output/static` folder that contains the static HTML and the JavaScript bundle(s) necessary for hydration.

![Folder structure for static assets](images/build-your-own-web-framework-vercel/img_011.jpg)![Folder structure for static assets](images/build-your-own-web-framework-vercel/img_012.jpg)![Folder structure for static assets](images/build-your-own-web-framework-vercel/img_013.jpg)![Folder structure for static assets](images/build-your-own-web-framework-vercel/img_014.jpg)Folder structure for static assets

Any static assets, such as HTML, CSS, JavaScript, and images should be located in the `.vercel/output/static` folder so the Vercel Build Output API can convert them into infrastructure primitives.

## Incremental Static Regeneration

[Incremental Static Regeneration](https://vercel.com/blog/how-hashicorp-developers-iterate-faster-with-isr) is a powerful pattern that we can use for pages that contain data that frequently updates by invalidating the cache and regenerating the page after a specific interval or based on an event.

The `/products` page can benefit from ISR, as it could regenerate after a specific interval to ensure it always shows the latest products and optional price reductions as quickly as possible.

![](images/build-your-own-web-framework-vercel/img_015.jpg)![](images/build-your-own-web-framework-vercel/img_016.jpg)![](images/build-your-own-web-framework-vercel/img_017.jpg)![](images/build-your-own-web-framework-vercel/img_018.jpg)

To enable Incremental Static Regeneration, we need to create a few files.

- `products.func/index.js` **:** A Serverless Function containing the handler that takes care of the page’s (re)generation.

- `products.func/vc-config.js`: The configuration file used by the Serverless Function to configure its environment, such as the runtime and optional helpers.

- `products.prerender-config.json`: The configuration file that Vercel uses to determine when and how to regenerate the page. This is necessary since this isn’t just Server-Rendering—it’s also using automatic invalidation and regeneration.

- `products.prerender-fallback.html`: The (optional) fallback HTML that gets served when there’s no cached version of the page available yet and the page is being generated in the background. This creates a better user experience since users don’t have to stare at a blank screen while the page is generated.


## **Serverless Functions**

First, let’s see how we can create a Serverless Function that handles the HTML (re)generation.

When a Serverless Function is invoked, its handler function runs. This function runs in its own environment, meaning that we have to ensure that this handler function has access to all the necessary code to generate the HTML.

We can create a Serverless Function on Vercel by creating a `<name>.func` folder, with the name being the name of the server-rendered page. In this case, we have to create a `products.func` folder, since the page needs to get regenerated in a Serverless Function.

To include all the necessary code and dependencies, we can create a `node_modules` folder within the function folder or bundle everything together into one single handler file.

![](images/build-your-own-web-framework-vercel/img_019.jpg)![](images/build-your-own-web-framework-vercel/img_020.jpg)![](images/build-your-own-web-framework-vercel/img_019.jpg)![](images/build-your-own-web-framework-vercel/img_020.jpg)

To create the files that are necessary for a serverless function, let’s create a `createServerlessFunction` function that invokes two functions:

- `generateClientBundle`, to generate a client-side bundle used to hydrate the static HTML returned from the server

- `generateLambdaBundle`, to bundle the necessary files into a script that’s executed in the Lambda’s handler


The method also generates a `.vc-config.json` file, which includes information that the Lambda needs to set up its execution context.

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

18    handler: "index.js",

19    launcherType: "Nodejs",

20    shouldAddHelpers: true,

21  });

22}
```

The handler function is responsible for server-rendering the HTML based on the page’s exported component. This approach is very similar to the static rendering we saw before. This time, however, we’re generating the HTML at _request time_ instead of at build time.

```javascript
export async function generateLambdaBundle(Component, funcFolder, pageName,outfile) {

2  const html = ReactDOMServer.renderToString(React.createElement(Component));

3  const { code: contents } = await transform(getHandlerCode(html, pageName));



5  return await build({

6    ...

7    stdin: { contents, resolveDir: path.join(".") },

8    outfile,

9  });

10};



const getHandlerCode = (html: string, pageName: string) => `

13  export default (req, res) => {

14    res.setHeader('Content-type', 'text/html');

15    res.end(\`<!DOCTYPE html>

16    <html lang="en">

17      ...

18      <body>

19        <div id="root">${html}</div>

20        <script src="${pageName}.bundle.js" defer></script>

21      </body>

22    </html>\`)

23  }

24`;
```

After bundling, the `.vercel/output/functions/products.func/index.js` handler file includes the functionality to server-render the component’s HTML.

Besides creating a Serverless Function, we also need a `prerender-config.json` file that contains information about the regeneration when we’re using Incremental Static Regeneration. Our framework allows the users to set their own revalidate time, so we can dynamically create this config file.

Our new `createPrerender` function calls the `createServerlessFunction` and `createStaticFile` functions that we created before, and creates a `<name>.prerender-config.json`. We’re creating a static file to render this as a fallback page.  This page gets shown to the user when the page is still being generated in the background.  The Build Output API expects this fallback HTML to be located at `<name>.prerender-fallback.html` , or as specified in the `<name>.prerender-config.json`.

```javascript
export async function createPrerender(Component, filePath, pageConfig) {

2  const pageName = getPageName(filePath);



4  const funcFolder = `.vercel/output/functions/${pageName}.func`;

5  await fs.ensureDir(funcFolder);



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



16  return writeJson(

17    `.vercel/output/functions/${pageName}.prerender-config.json`,

18    {

19      expiration: pageConfig.revalidate,

20      group: 1,

21      fallback: `${pageName}.prerender-fallback.html`,

22    }

23  );

24}
```

Once building has been completed, we end up with a `products.func` folder containing all the code it needs to generate the HTML on the server.

![Folder structure for prerender functions](images/build-your-own-web-framework-vercel/img_023.jpg)![Folder structure for prerender functions](images/build-your-own-web-framework-vercel/img_024.jpg)![Folder structure for prerender functions](images/build-your-own-web-framework-vercel/img_025.jpg)![Folder structure for prerender functions](images/build-your-own-web-framework-vercel/img_026.jpg)Folder structure for prerender functions

Right now, the `createPrerender` function takes care of creating the Serverless Function, creating a static `prerender-fallback.html` fallback file by statically rendering the component at build time, and generating a `prerender-config.json` configuration file that includes the necessary information the Build Output API needs to configure the prerendering behavior, such as the `expiration` value.

## Edge Server-Rendering

Since React is compatible with the [Edge Runtime](https://vercel.com/blog/introducing-the-edge-runtime) due to its isomorphic nature - it doesn’t use any Node.js libraries - it’s possible to render React _at the Edge_. Creating an [Edge Function](https://vercel.com/edge) is similar to a serverless function, with its [runtime](https://vercel.com/blog/introducing-the-edge-runtime) as the most significant difference.

![](images/build-your-own-web-framework-vercel/img_027.jpg)![](images/build-your-own-web-framework-vercel/img_028.jpg)![](images/build-your-own-web-framework-vercel/img_029.jpg)![](images/build-your-own-web-framework-vercel/img_030.jpg)

Let’s create a `createEdgeFunction` function that takes care of generating the necessary files to enable Edge Server-Rendering. This function calls the `generateEdgeBundle` function that eventually takes care of bundling the required files, and creates a `.vc-config.json`configuration file that indicates we’re using the `edge` runtime with an `entrypoint` file instead of a handler.

```javascript
export async function createEdgeFunction(Component, filePath) {

2  const pageName = getPageName(filePath);

3  const funcFolder = `.vercel/output/functions/${pageName}.func`;

4  await ensureDir(funcFolder);



6  await generateEdgeBundle({

7    funcFolder,

8    filePath,

9    pageName,

10    Component,

11  });



13  return writeJson(`${funcFolder}/.vc-config.json`, {

14    runtime: "edge",

15    entrypoint: "index.js",

16  });

17}


```

Generating the bundle is similar to the serverless approach, however this time, we care about values present on the `req` object. To pass the prop down to the edge-rendered page, we can dynamically create the React element that was bundled from the original page’s file path.

```javascript
export async function generateEdgeBundle(funcFolder, pageName, filePath) {

2  const { code: contents } = await transform(

3    getEdgeHandlerCode(filePath),

4    edgeBuildConfig

5  );



7  return await build({

8    ...

9    stdin: { contents, resolveDir: path.join(".") },

10    outfile,

11  });

12}



export const getEdgeHandlerCode = (filePath) => `

15  import { createElement } from 'react';

16  import { renderToString } from 'react-dom/server';

17  import Component from '${filePath}';



19  export default async function(req) {

20    const html = renderToString(createElement(Component, { req }));



22    return new Response(\`<!DOCTYPE html><div id="root">${html}</div>\`, {

23      headers: { 'Content-Type': 'text/html; charset=utf-8' }

24    });

25  }

26`;
```

After bundling, we now end up with an entrypoint that passes the `req` prop to the edge-rendered page and returns a new `Response` object with the generated HTML.

## Serverless Functions

Serverless Functions can be used to server-render pages or to create data fetching endpoints.

When we implemented Incremental Static Regeneration in the previous paragraph, we created a Serverless Function responsible for generating the page’s HTML. Server-Side Rendering uses the same approach - with the main differences being _when_ the Serverless Function gets invoked and its caching behavior.

To server-render a page, we need to create a function that generates the page’s HTML on every request.

![](images/build-your-own-web-framework-vercel/img_031.jpg)![](images/build-your-own-web-framework-vercel/img_032.jpg)![](images/build-your-own-web-framework-vercel/img_033.jpg)![](images/build-your-own-web-framework-vercel/img_034.jpg)

You can see that it’s essentially a subset of the Incremental Static Regeneration code. In this case, we’re only calling the `createServerlessFunction` method covered in the previous paragraph to create both a lambda (serverless) bundle _and_ a client-side bundle.

With ISR, this lambda only gets invoked when a user requests a page that had been cached longer than the revalidate value. Vercel then automatically regenerates the page.

With server-side rendering, however, this function is invoked on every request. Vercel won’t automatically cache responses from this function when the page is server-rendered, resulting in unique responses every time.

Now that we’re supporting the rendering techniques, let’s see how to implement Image Optimization.

## Automatic Image Optimization

Vercel can [automatically optimize images](https://vercel.com/docs/concepts/image-optimization) by pointing the image src to `/_vercel/image?url=`  and adding the necessary configuration. For our framework, we'll add support for a `vercel.config.js` file, where the Image Optimization configuration can be defined.

Let’s make it easy for our users to use optimized images by exporting an `Image` component. This component ensures that the src point to the `/_vercel/image` path and adds the necessary height and width to serve the correct image size based on the viewport.

```javascript
export const Image = (props) => {

2  return  (

3    <img

4      {...props}

5      ref={ref}

6      width={props.width}

7      height={props.height}

8      src={`/_vercel/image?url=${encodeURIComponent(props.src)}&w=${props.width}&q=75`}

9   />

10  )

11}
```

You can now import the `Image` component and use it like a regular `img` tag. The only part required is some configuration in the `vercel.config.js` file, such as the domain if it’s an external domain, the image size, and the modern image format we want to use. This file is used by our framework and outputs its contents to `.vercel/output/config.json`.

vercel.config.json

```javascript
export default {

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

After adding this configuration, any image that uses our custom `Image` component can benefit from the Automatic Image Optimization feature Vercel provides.

## Conclusion

Now that we have the necessary methods to support the rendering patterns and optimize images, we can traverse the `pages` directory and invoke the functions to create the required files. We’re also copying all the static files - such as images, CSS, and JavaScript - from the project’s `public` folder to the `.vercel/output/static` folder and creating a `.vercel/output/config.json` file based on the project’s `vercel.config.js`.

```javascript
async function buildVercelOutput() {

2  ...

3  await Promise.allSettled(

4    getRoutes().map(async (filePath) => {

5      const { pageConfig, default: Component } = await import(filePath);



7      switch (pageConfig.strategy) {

8        case "static":

9          return createStaticFile(Component, filePath);

10        case "prerender":

11          return createPrerender(Component, filePath, pageConfig);

12        case "ssr":

13          return createServerlessFunction(Component, filePath);

14        case "edge":

15          return createEdgeFunction(Component, filePath);



17        default:

18          return;

19      }

20    })

21  );



23  await copy("public", ".vercel", "output", "static")



25  return writeJSON(".vercel/output/config.json", {

26    ...(require(process.cwd() + "/vercel.config.js").default),

27    ...{

28      version: 3,

29      routes: getTransformedRoutes({

30         cleanUrls: true

31      }).routes,

32    },

33  });

34  ...

35}
```

When invoking this method, we can create a valid `.vercel/output` folder that allows us to deploy to Vercel, using some of the cutting-edge features that the platform provides.

When using modern frameworks such as [Next.js](https://vercel.com/solutions/nextjs), we luckily don’t have to worry about implementing all these steps since the optimizations are provided out of the box.

However, if you’re an independent developer that wants to benefit from the platform’s features or a framework author that’s looking to integrate with Vercel, the [Build Output API](https://vercel.com/docs/build-output-api) makes it easy to build any project on Vercel.

Although it should be clear that this framework should not be used in production—it just does the bare minimum and can be optimized—it’s good to see how modern frameworks make development so much easier.

The code is available in [this GitHub Repo](https://github.com/lydiahallie/byof-demo) to see the demo implementation covered in this article. If you’d like another example of using the Build Output API, check out [Astro](https://github.com/withastro/astro/tree/main/packages/integrations/vercel), a framework that has successfully integrated with Vercel.