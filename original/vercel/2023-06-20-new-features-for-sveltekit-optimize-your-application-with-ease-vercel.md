---
title: "New features for SvelteKit: Optimize your application with ease - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/feature-complete-sveltekit"
date: "2023-06-20"
scraped_at: "2026-03-02T09:52:00.600534136+00:00"
language: "en"
translated: false
description: "Get the most out of your SvelteKit app with pre-route configuration, Incremental Static Regeneration, and data at the Edge."
---




Jun 20, 2023

Framework-defined infrastructure at Vercel brings previously Next.js-only features to SvelteKit.

Svelte has made a name for itself in the world of web development frameworks, thanks to its unique approach of converting components into optimized JavaScript modules. This innovative way of rendering apps eliminates the overhead found in traditional frameworks, leading to more performant and efficient applications.

With [the release of SvelteKit 1.0](https://vercel.com/blog/using-sveltekit-1-0-on-vercel), developers can leverage the power of fullstack Svelte without worrying about breaking changes. Furthermore, SvelteKit continues to evolve, offering a robust set of features and seamless integration with various deployment environments, including Vercel.

Vercel, using [framework-defined infrastructure (FDI)](https://vercel.com/blog/framework-defined-infrastructure), has embraced SvelteKit, recently adding support for [per-route configuration](https://vercel.com/docs/frameworks/sveltekit#configure-your-sveltekit-deployment) for Serverless and Edge Functions, [Incremental Static Regeneration (ISR)](https://vercel.com/docs/frameworks/sveltekit#incremental-static-regeneration-isr), and easier compatibility with a [range of Vercel products](https://vercel.com/docs/frameworks/sveltekit#web-analytics). In this article, we'll explore how to make your apps more performant, scalable, and user friendly.

## SvelteKit Adapters

First, it helps to know how [SvelteKit's adapter system](https://kit.svelte.dev/docs/adapters) works. SvelteKit apps build to platform-agnostic JavaScript, so we need to use an adapterto deploy it to the platform of our choosing.

SvelteKit's adapters aid FDI by giving information to a deployment environment about what precise needs the project has. This gives an incredible amount of flexibility from one codebase: you can swap out adapters to deploy to any number of platforms.

By default, `npm create svelte@latest` generates a SvelteKit app which includes `adapter-auto`. This is suitable for the majority of projects, as its primary function is to determine the specific adapter required for your project and fetch it during the build process.

![An example SvelteKit deployment to Vercel.](images/new-features-for-sveltekit-optimize-your-application-with-ease-vercel/img_001.jpg)![An example SvelteKit deployment to Vercel.](images/new-features-for-sveltekit-optimize-your-application-with-ease-vercel/img_002.jpg)An example SvelteKit deployment to Vercel.

However, if you know your deployment environment ahead of time, it's best to install the appropriate adapter, since this both clarifies your `package.json` and slightly improves build times.

In addition to `adapter-auto`, the Svelte team have built adapters for:

- Vercel

- [Netlify](https://vercel.com/kb/guide/vercel-vs-netlify)

- Cloudflare andCloudflare Workers

- Node

- Static site generation


The community has also built numerous adapters for other deployments, such as a standalone Deno or Bun server, an Electron desktop app, a browser extension, and even a "multi-adapter" that allows your application to automatically build to multiple deployments. For a full listing of adapters, check out the official [Svelte Society listing](https://sveltesociety.dev/components#adapters).

## Per-route data fetching and rendering

SvelteKit's new deployment configuration gives you full control over how your routes are deployed to Vercel as functions. Learn how to deploy some parts of your app as Edge functions, some as serverless functions, and some utilizing ISR.

Now that we've covered how adapters work, it’s time to zoom in on some of the benefits your SvelteKit application gains when deploying to Vercel.

Any route in your SvelteKit app (`+page.svelte`) can access data returned by a `load` function colocated in the same directory in a `+page.js` or `+page.server.js` file. The `load` function has access to dynamic parameters, such as URL, and can send them to any server- or client-side request, including HTML-native fetches.

The [`load` function](https://kit.svelte.dev/docs/load?utm_source=svelte_site&utm_medium=web&utm_campaign=improving_sveltekit_apps) can run on the client or the server, depending on if it's coming from a `+page.js` or `+page.server.js`, but your page will not render until data has been acquired. This is useful to avoid layout shift and other issues that come from loading data after page render. You can also fetch data at the Layout level, providing data for all child routes. For times you need to fetch on the client side after the component renders, you can do so within SvelteKit's `onMount()`.

While there's always been a lot of flexibility in how to fetch and render data in SvelteKit, it’s now possible to adjust your Vercel-specific settings for each individual route.

You can choose whether a route uses Serverless or Edge Functions, and whether that route dynamically renders data (SSR), pre-renders data (SSG), or uses [Incremental Static Regeneration (ISR)](https://vercel.com/docs/concepts/incremental-static-regeneration/overview) to do the best of both.

### Serverless vs. Edge Functions

Serverless and Edge Functions each have their distinct advantages. In general, Edge Functions are cheaper, faster, and feature longer timeouts (to stay active for slower data such as OpenAI's API), but you often need Serverless Functions for larger tasks like dynamic content generation or handling authentication. [Check the docs](https://vercel.com/docs/concepts/limits/overview#functions-comparison) for a full comparison.

Now that you know when to use each type of function, here's how to configure your individual routes for SvelteKit on Vercel.

The `+page.js` / `+layout.js` and `+page.server.js` / `+layout.server.js` files can export a `config` constant that determines the rendering strategy of your dynamic data.

page.server.js

```javascript
export const config = {

2  runtime: 'edge',

3};



export const load = ({ cookies }) => {

6  // Load function code here

7};
```

A SvelteKit load function running on Vercel's edge network.

To use Serverless instead of edge, `runtime` can also take `'nodejs16.x'` or `'nodejs18.x'`, depending on which node environment you're running your application. SvelteKit apps default to Serverless Functions.

To opt your entire application into the `edge` runtime, you can configure your `svelte.config.js` and then override these settings on individual routes.

svelte.config.js

```javascript
import adapter from '@sveltejs/adapter-vercel';



const config = {

4  kit: {

5    adapter: adapter({

6      runtime: 'edge',

7    }),

8  },

9};



export default config;
```

Tweaking your runtime in your application's Svelte config sets the default behavior for the entire application.

By default, Serverless Functions run from Washington, D.C., and Edge Functions run in the global position closest to your user. You can [alter this behavior](https://vercel.com/docs/frameworks/sveltekit#regions) anywhere in your application to run your functions closer to your data source. [Visit the docs](https://vercel.com/docs/frameworks/sveltekit#configure-your-sveltekit-deployment) to see a complete list of configuration options.

### Incremental Static Regeneration

Incremental Static Regeneration (ISR) is a modern web development strategy that allows developers to create and update static pages on-demand, after the initial build.

![ISR offers significant gains, both in build times (DevEx) and static generation (UX).](images/new-features-for-sveltekit-optimize-your-application-with-ease-vercel/img_003.jpg)![ISR offers significant gains, both in build times (DevEx) and static generation (UX).](images/new-features-for-sveltekit-optimize-your-application-with-ease-vercel/img_004.jpg)ISR offers significant gains, both in build times (DevEx) and static generation (UX).

This approach combines the benefits of both static site generation (SSG) and server-side rendering (SSR), offering fast load times for end-users, reduced load on servers, and the ability to update content without a full rebuild. Because of its end-user similarity to SSG, ISR also offers huge gains for [ranking in search engines](https://vercel.com/blog/nextjs-seo-playbook#rendering-and-why-it-matters).

![The result of ISR, for the end-user, feels as fast as static-site generation, served on Vercel's Edge Network.](images/new-features-for-sveltekit-optimize-your-application-with-ease-vercel/img_005.jpg)![The result of ISR, for the end-user, feels as fast as static-site generation, served on Vercel's Edge Network.](images/new-features-for-sveltekit-optimize-your-application-with-ease-vercel/img_006.jpg)The result of ISR, for the end-user, feels as fast as static-site generation, served on Vercel's Edge Network.

As of early this year, SvelteKit officially supports ISR with Vercel. To configure ISR, you need to include the `isr` property in your server-side config object (like the Serverless and Edge Functions above).

For example, you may have a blog where all the articles are pulled from a CMS:

blog/\[slug\]/+page.server.js

```javascript
export const config = {

2  isr: {

3    // Expiration time (in seconds) before the cached asset

4    // will be regenerated by invoking the Serverless Function.

5    // Setting the value to `false` means it will never expire.

6    expiration: 60,

7};
```

Setting up ISR also occurs within the config object of a \`page.server.js\` file.

You can also include a `bypassToken` to programmatically bypass or refresh the ISR cache. [Take a look at the docs](https://vercel.com/docs/frameworks/sveltekit#incremental-static-regeneration-isr) to learn more about these advanced options.

## Other Vercel gains

Vercel Developer Advocate Steph Dietz explains how to optimize web forms with Vercel KV and SvelteKit form actions.

- **Data at the edge.** Your app is only as fast as its slowest piece, so earlier this year, we introduced [Edge Config](https://vercel.com/blog/edge-config-ultra-low-latency-data-at-the-edge), a near-0ms latency data store associated with your Vercel account that enables you to read data at the edge without querying an external database. Now, we're rolling out [Vercel KV, Postgres, and Blob](https://vercel.com/blog/vercel-storage) to give you a suite of fully-integrated data products at the Edge.

- **Preview Deployments.** SvelteKit users on Vercel have always had access to immutable, per-`git commit` deployments that run live on Vercel's Edge Network. We introduced our [Figma-like commenting feature](https://vercel.com/docs/concepts/deployments/comments) last year, and now we're introducing [Visual Editing](https://vercel.com/blog/visual-editing), so you can edit CMS-generated elements of your site directly on the webpage.

- **Analytics.** Vercel Web Analytics can be integrated in your SvelteKit project with

[just three lines of code](https://vercel.com/docs/frameworks/sveltekit#web-analytics). This enables you to visualize and monitor your application's traffic over time, and when paired with [Speed Insights](https://vercel.com/docs/frameworks/sveltekit#speed-insights), gives a clear picture of your app's performance for your users.


## Bringing it all together

Deploying SvelteKit on Vercel means more flexibility, faster data fetching, and better team tools than ever. You have:

- Edge-based, native Vercel data solutions such as Vercel KV, Postgres, and Edge Config.

- Per-route fetching and rendering configuration for Edge Functions, Serverless Functions, and ISR.

- A true-to-production Preview Deployment of your application, with live editing and commenting from your whole team.

- Native analytics and reporting to monitor your application's performance.

- Many more features, such as [Cron Jobs](https://vercel.com/docs/cron-jobs) or [Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware#), that we haven't touched on in this article.


Plus, Vercel offers native integrations with a [host of popular tools](https://vercel.com/integrations) so you can compose your team's ideal workflow.

We'll be continuing to develop SvelteKit on Vercel with new and better features, so be sure to check back soon.

[**Figuring out if SvelteKit works for you?**\\
\\
Reach out to us with your team's unique needs.\\
\\
Contact Us](https://vercel.com/solutions/svelte)