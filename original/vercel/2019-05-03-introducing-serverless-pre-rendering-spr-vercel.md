---
title: "Introducing Serverless Pre-Rendering (SPR) - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/serverless-pre-rendering"
date: "2019-05-03"
scraped_at: "2026-03-02T10:07:45.459614680+00:00"
language: "en"
translated: false
description: "Introducing SPR, an industry-defining feature that allows you to get the best of both static and dynamic data rendering."
---




May 3, 2019

Static websites are **fast**. When you deploy static frontends to Vercel, we automatically serve them from every edge of our global [Smart CDN](https://vercel.com/smart-cdn) network.

But static websites are also... _static_. Static site generators create all your pages during the build process — all of them, all at once. Ever had to quickly fix a typo in a page, only to wait minutes or hours for your change to go live?

Today, we are introducing **Serverless Pre-Rendering**, an industry-defining feature of our Smart CDN network that allows you to get the best of both worlds: the speed and reliability of **static**, and the versatility of **dynamic** data rendering.

## How it works

Let's start with a demo. You’ve built a landing page. You used React, Next.js, CSS-in-JS (or your favorite modern frontend stack). All of which you pushed to [GitHub](https://vercel.com/github) or [GitLab](https://vercel.com/gitlab) for it to be automatically deployed.

![With Vercel, you run `git push` and you put spr-landing.vercel.sh online instantly.](images/introducing-serverless-pre-rendering-spr-vercel/img_001.jpg)With Vercel, you run \`git push\` and you put spr-landing.vercel.sh online instantly.

Let's say we want to edit the title of the page. At this point you have two choices:

- Send a PR, wait for the build to complete, merge, go live. This is great for **code changes**, but is it best for copy? Builds can take a few minutes at best, to hours! We can do better.

- Use a [Headless CMS](https://en.wikipedia.org/wiki/Headless_content_management_system) for its friendly interface to edit content, and query it from the frontend. You could use [Contentful](https://www.contentful.com/), [Prismic](https://prismic.io/), [Contentstack](https://www.contentstack.com/), [Sanity](https://www.sanity.io/), [Tipe](https://v1.tipe.io/), [Hygraph](https://hygraph.com/), [ButterCMS](https://buttercms.com/), [DatoCMS](https://www.datocms.com/) — virtually any API that can return dynamic data.


We don’t want to wait, so for this demo we wanted to edit the data in real-time. For the task, we picked our favorite document editing tool, Notion, and queried its API from Next.js.

![](images/introducing-serverless-pre-rendering-spr-vercel/img_002.jpg)

In this video, you can see that we make edits to the Notion page, and it makes updates to the site instantly.

Towards the end of the video, we measure the performance of this dynamic page. The **response is instant, from our CDN edge**. Using Serverless Pre-rendering, you can provide an instant experience even with dynamic content.

How does that work?

1. When an end-user accesses your website, **we always serve a static version**.

2. A Serverless Function **computes a new copy querying dynamic APIs in the background**.

3. No matter how much traffic you are serving, **only one background invocation is made at an interval you decide**.


What this means for you:

- No more hard decisions between static and dynamic. **SPR marries both paradigms**.

- If your backend is slow, **your responses are still always fast**.

- Your backend functions and datasources can go down, and **you will likely tolerate their downtime**.

- Traffic to your backend is minimized, which results in **massive cost reductions**.


As we’ll see next, the best part is that this integrates easily into your existing codebase, and takes advantage of a [HTTP standard proposal](https://www.chromestatus.com/feature/5050913014153216).

### Cache-Control: `stale-while-revalidate`

The demo above is a simple [Next.js](https://nextjs.org/) app deployed to [our platform](https://vercel.com/home) and [available on GitHub](https://github.com/vercel/spr-landing). All the above benefits and functionality are unlocked by **a single line of code**.

```javascript
res.setHeader('Cache-Control', 's-maxage=1, stale-while-revalidate');
```

Composition of a header that includes `stale-while-revalidate`.

Let’s break it down.

- `Cache-Control` — This header tells our edge proxy how to cache the result of the React page being rendered

- `s-maxage=1` — This flag tells us that [our Edge](https://vercel.com/docs/serverless-functions/edge-caching) (but not your end user) should cache it for one second

- `stale-while-revalidate` — This indicates that we should serve a **stale version, while a revalidation happens asynchronously**


In short, you can begin adding this header to any of your Vercel deployments, using whatever technology you like (Next.js, Gatsby, Node.js, Go, Rust...), without any rewrites or lock-in.

### Use-cases

Serverless Pre-Rendering (SPR) is a suitable technique for anytime you want to serve fast pages, from anywhere in the world, that are produced by dynamic datasources and computation.

Here are some popular use-cases:

- **Marketing pages**. Pages explaining a new product or service

- **E-commerce websites**. Containing lots of items, categories, user reviews, etc.

- **Blogs and Newspapers**. Where multiple users edit stories in realtime, including breaking news

- **High-traffic APIs**. Where computation is debounced in order to minimize load

- **Public dashboards**. Where lots of dynamic content is consumed by many users


### Getting Started

The example showcased above is [fully open-source](https://github.com/vercel/spr-landing) and available under the MIT License. [Deploy to Vercel](https://vercel.com/new/git/external?repository-url=https%3A%2F%2Fgithub.com%2Fvercel%2Fspr-landing&env=PAGE_ID) and update the `PAGE_ID` environment variable with your page ID – that's all it takes!

Support for SPR is generally available in production, deployed across our entire network.

What API or Headless CMS would you like us to feature next? Let us know [your feedback](https://vercel.com/feedback/spr)!