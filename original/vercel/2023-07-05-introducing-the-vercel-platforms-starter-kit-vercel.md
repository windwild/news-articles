---
title: "Introducing the Vercel Platforms Starter Kit - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/platforms-starter-kit"
date: "2023-07-05"
scraped_at: "2026-03-02T09:51:49.729284876+00:00"
language: "en"
translated: false
description: "A fullstack template for building multi-tenant applications with custom domains using Next.js App Router, Vercel Postgres, and the Vercel Domains API."
---




Jul 5, 2023

A fullstack template for building multi-tenant applications with custom domains using Next.js App Router, Vercel Postgres, and the Vercel Domains API.

Today, we are excited to launch the all-new Vercel [Platforms Starter Kit](https://app.vercel.pub/) — a **full-stack Next.js template for building multi-tenant applications with custom domains,** built with [App Router](https://nextjs.org/docs/app), [Vercel Postgres](https://vercel.com/storage/postgres), and the [Vercel Domains API](https://vercel.com/docs/rest-api/endpoints#domains).

[**Platforms Starter Kit**\\
\\
Next.js template for building multi-tenant applications with custom domains using App Router, Vercel Postgres, and the Vercel Domains API.\\
\\
View Template](https://vercel.com/templates/next.js/platforms-starter-kit)

## Multi-tenant apps in days, not months

Here's an example code snippet demonstrating how to use it within Next.js:

App Router GeolocationPages Router Geolocation

app/api/geo/route.ts

```tsx
import { geolocation } from '@vercel/functions';



export function GET(request: Request) {

4  const { city } = geolocation(request);

5  return new Response(`<h1>Your location is ${city}</h1>`, {

6    headers: { 'content-type': 'text/html' },

7  });

8}
```

Reading the city from the geo IP headers in a Vercel Edge Function.

In the above example, we import the `geolocation` helper from `@vercel/edge`.

The Platforms Starter Kit comes with powerful features that lets you build multi-tenant apps in record time.

1. **Multi-tenancy:** Programmatically assign unlimited custom domains, subdomains, and SSL certificates to your users using the [Vercel Domains API](https://vercel.com/docs/rest-api/endpoints#domains)

2. **Performance**: Fast & beautiful blog posts cached via [Vercel's Edge Network](https://vercel.com/docs/concepts/edge-network/overview), with the ability to invalidate the cache on-demand (when users make changes) using [Incremental Static Regeneration](https://vercel.com/docs/concepts/next.js/incremental-static-regeneration) \+ Next.js' [`revalidateTag` API](https://nextjs.org/docs/app/api-reference/functions/revalidateTag)

3. **AI Editor**: AI-powered Markdown editor for a Notion-style writing experience powered by [Novel](https://novel.sh/)

4. **Image Uploads**: Drag & drop / copy & paste image uploads, backed by [Vercel Blob](https://vercel.com/storage/blob)

5. **Custom styles**: Custom fonts, 404 pages, favicons, sitemaps for each site via the [Next.js file-based Metadata API](https://nextjs.org/docs/app/api-reference/file-conventions/metadata)

6. **Dynamic OG Cards**: Each blog post comes with a dynamic OG image powered by [@vercel/og](https://vercel.com/docs/concepts/functions/edge-functions/og-image-generation)

7. **Dark Mode**: For a better user experience at night


![](images/introducing-the-vercel-platforms-starter-kit-vercel/img_001.jpg)![](images/introducing-the-vercel-platforms-starter-kit-vercel/img_002.jpg)

[**How to build a multi-tenant app with custom domains using Next.js**\\
\\
Create a full-stack application with multi-tenancy and custom domain support using Next.js App Router, Vercel Postgres, and the Vercel Domains API.\\
\\
Read the guide](https://vercel.com/guides/nextjs-multi-tenant-application)

## What is a multi-tenant application?

Multi-tenant applications serve multiple customers across different subdomains/custom domains with a single unified codebase.

Take our demo app as an example:

- Subdomain: [demo.vercel.pub](http://demo.vercel.pub/)

- Custom domain: [platformize.co](http://platformize.co/) (maps to [demo.vercel.pub](http://demo.vercel.pub/))

- Editing & publishing backend: [app.vercel.pub](http://app.vercel.pub/)


Another example is [Hashnode](https://vercel.com/customers/hashnode), a popular blogging platform. Each writer has their own unique **`.hashnode.dev`** subdomain for their blog:

- [eda.hashnode.dev](https://eda.hashnode.dev/)

- [katycodesstuff.hashnode.dev](https://katycodesstuff.hashnode.dev/)

- [akoskm.hashnode.dev](https://akoskm.hashnode.dev/)


Users can also map custom domains to their **`.hashnode.dev`** subdomain:

- [akoskm.com](https://akoskm.com/) → [akoskm.hashnode.dev](https://akoskm.hashnode.dev/)


With the Platforms Starter Kit on Vercel Pro, you can offer [unlimited custom domains at no extra cost](https://vercel.com/changelog/unlimited-custom-domains-for-all-pro-teams) to your customers as a premium feature, without having to worry about custom nameservers or configuring SSL certificates.

## Build for scale

A year ago, we launched the first version of this starter kit to make it easier for makers to start their own platform on Vercel.

Since then, we've seen a variety of successful platforms grow to tens of thousands of custom domains and millions of pageviews on Vercel:

![](images/introducing-the-vercel-platforms-starter-kit-vercel/img_003.jpg)


Hashnode, a blogging platform for the developer community built with Next.js, uses Vercel to manage over 35,000 custom domains for their customers. After evaluating alternative solutions, Hashnode ultimately chose Vercel because of the ability to manage custom domains at scale and the smooth and intuitive developer experience. [Read the full customer story](https://vercel.com/customers/hashnode).

![](images/introducing-the-vercel-platforms-starter-kit-vercel/img_004.png)


Super is the largest Notion-to-website builder that lets you create SEO-optimized sites using nothing but Notion. Using Next.js and Vercel allows Super to effectively serve 15,000 custom domains and 17 million monthly pageviews. “By far my favorite Vercel feature is the ability to connect as many domains as I need to a single project,” CEO & Founder Jason Werner explains in his [customer story](https://vercel.com/customers/super-serves-thousands-of-domains-on-one-project-with-next-js-and-vercel).

![](images/introducing-the-vercel-platforms-starter-kit-vercel/img_005.png)


Incident.io is a Slack-powered incident management platform, driven by automation. With the Platforms Starter Kit, they were able to ship beautiful and fast status pages (like this one for [Linear](https://linearstatus.com/)) without having to worry about SSL certificate management. [Read about their experience](https://incident.io/blog/how-we-built-status-pages).

![](images/introducing-the-vercel-platforms-starter-kit-vercel/img_006.png)

[Beyond Menu](https://www.beyondmenu.com/)

Beyond Menu is a complete ordering solution for independent restaurant owners. By using the Vercel Platforms Starter Kit, they serve 6,000 custom domains for restaurant owners all over the world with a focus on speed and performance.

![](images/introducing-the-vercel-platforms-starter-kit-vercel/img_007.svg)


Mintlify is a platform that provides beautiful documentation sites for [hundreds of API-first SaaS companies](https://mintlify.com/showcase). "Vercel Platforms is making our product the fastest and most performant docs solution on the market", says founder Han Wang.

![](images/introducing-the-vercel-platforms-starter-kit-vercel/img_008.png)


Dub is an open-source link management tool for modern marketing teams to create, share, and track short links. Thanks to the Platforms Starter Kit, they were able to grow to ~900 custom domains without having to manage SSL certificates or set up NGINX proxies. [Check out their code](https://github.com/steven-tey/dub) to learn more about their implementation.

## Build the platform of your dreams

It's been incredible to see the [amount](https://twitter.com/perryraskin/status/1618099492888391681) [of](https://twitter.com/flexdinesh/status/1620906810965360640) [love](https://twitter.com/SSardorf/status/1651602178715553792) the template has gotten since it's inception.

> “Just stumbled upon the Vercel Platform Starter Kit. Game changer for anyone who wants to quickly create a multi-tenant app that enables user custom domains. Just stumbled upon the Vercel Platform Starter Kit. Game changer for anyone who wants to quickly create a multi-tenant app that enables user custom domains. ”
>
> ![](images/introducing-the-vercel-platforms-starter-kit-vercel/img_009.jpg)
>
> **Perry Raskin,** CoverDash

With the new version – now built with the App Router – we cannot wait to see what platforms you build on Vercel!

[**How to build a multi-tenant app with custom domains using Next.js**\\
\\
Create a full-stack application with multi-tenancy and custom domain support using Next.js App Router, Vercel Postgres, and the Vercel Domains API.\\
\\
Read the guide](https://vercel.com/guides/nextjs-multi-tenant-application) [**Platforms Starter Kit**\\
\\
Next.js template for building multi-tenant applications with custom domains using App Router, Vercel Postgres, and the Vercel Domains API.\\
\\
View Template](https://vercel.com/templates/next.js/platforms-starter-kit) [**Platforms Starter Kit GitHub Repo**\\
\\
A full-stack Next.js app with multi-tenancy and custom domain support. Built with Next.js App Router and the Vercel Domains API.\\
\\
Star on GitHub](https://github.com/vercel/platforms)

Vercel Template

Deploy this template

### Next.js template for building multi-tenant applications with the App Router and Redis.

Platforms Starter Kit

Twitter post

### Introducing the new Vercel Platforms Starter Kit.  Build multi-tenant apps with custom domains using the Next.js App Router, Vercel Postgres, and the Vercel Domains API.

![Vercel's avatar](images/introducing-the-vercel-platforms-starter-kit-vercel/img_010.jpg)Vercel@vercel