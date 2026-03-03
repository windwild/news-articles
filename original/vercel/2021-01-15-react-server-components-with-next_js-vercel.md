---
title: "React Server Components with Next.js - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/everything-about-react-server-components"
date: "2021-01-15"
scraped_at: "2026-03-02T10:06:01.248779109+00:00"
language: "en"
translated: false
description: "Learn about React Server Components (experimental) and how they'll change how we build React applications, creating a better end-user experience."
---




Jan 15, 2021

React Server Components allow developers to build applications that span the server and client, combining the rich interactivity of client-side apps with the improved performance of traditional server rendering.

In the upcoming Next.js major release, React developers will be able to use Server Components inside the `app` directory as part of the changes outlined by the [Layouts RFC](https://nextjs.org/blog/layouts-rfc). This post will explore how Server Components will enable developers to create faster React applications.

## What are React Server Components?

React Server Components improve the user experience of your application by pairing the best parts of server-rendering with client-side interactivity.

With traditional React applications that are client-side only, developers often had to make tradeoffs between SEO and performance. Server Components enable developers to better leverage their server infrastructure and achieve great performance by default.

For example, large dependencies that previously would impact the JavaScript bundle size on the client can instead remain entirely on the server. By sending less JavaScript to the browser, the time to interactive for the page is decreased, leading to improved [Core Web Vitals](https://vercel.com/blog/core-web-vitals).

## React Server Components vs Server-Side Rendering

[Server-side Rendering](https://nextjs.org/docs/basic-features/pages#server-side-rendering) (SSR) dynamically builds your application into HTML on the server. This creates faster load times for users by offloading work from the user's device to the server, especially those with slower internet connections or older devices. However, developers still pay the cost to download, parse, and hydrate those components after the initial HTML loads.

React Server Components, combined with Next.js server-side rendering, help eliminate the tradeoff of all-or-nothing data fetching. You can progressively show updates as your data comes in.

## Using React Server Components with Next.js

The Next.js team at Vercel released the [Layouts RFC](https://nextjs.org/blog/layouts-rfc) a few months ago outlining the vision for the future of routing, layouts, and data fetching in the framework. While these changes **aren’t available yet**, we can start learning about how they will be used.

Pages and Layouts in `app` will be rendered as React Server Components by default. This improves performance by reducing the amount of JavaScript sent to the client for components that are not interactive. Client components will be able to be defined through either a file name extension or through a string literal in the file.

Both client and server components can be used inside the same route. For example:

![Both client and server components can be used together in the same route.](images/react-server-components-with-next_js-vercel/img_001.jpg)Both client and server components can be used together in the same route.

Stay tuned for more updates on React Server Components in the upcoming months.