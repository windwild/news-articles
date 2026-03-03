---
title: "Next.js 6 and Nextjs.org - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/next6"
date: "2018-05-16"
scraped_at: "2026-03-02T10:08:08.287213304+00:00"
language: "en"
translated: false
description: "Next.js 6 features zero-configuration static exports, App Component, Babel 7 and more"
---




May 16, 2018

This year, the [ZEIT Day](https://zeit.co/day) Keynote started by highlighting our Open Source projects including showing the metrics of Next.js. With over 25000 stars on [GitHub](https://github.com/zeit/next.js) and over 10000 websites are already powered by it, we're incredibly amazed at its growth and love seeing the increasing amount of projects depending on it.

We are proud today to introduce the production-ready **Next.js 6**, featuring:

- Zero-configuration static exports. No need for `next.config.js` by default

- `_app.js`, an extension point that enables page transitions, error boundaries and more

- Babel 7 and Fragment syntax `<>` support

- Extended integration test suites with a strong focus on security

- Flow annotations in the core codebase


In addition to the 6.0 release, we're moving to feature Next.js on its very own homepage, [nextjs.org](https://nextjs.org/), featuring:

- All the Next.js documentation in one place. No more lookups of the README file on GitHub

- Merging [https://learnnextjs.com](https://learnnextjs.com/) into [https://nextjs.org/learn](https://nextjs.org/learn)

- A showcase of the most impressive websites built with Next.js


## Static React Applications

Next.js focuses on the idea of **pre-rendering** as a means to achieve high performance. Pre-rendering comes in two forms:

- **Server rendering** where each request triggers a render. As a result, the end-user doesn't have to wait for any JS to be downloaded to start consuming data

- **Static rendering** where we output static files that can be served directly without any code execution on the server


Until now, static exporting in Next.js was very powerful but not sufficiently easy to use. It required setting up [a manual route map](https://nextjs.org/docs#static-html-export) even when no custom routes were in use.

With Next.js 6, we automatically generate the route map for you based on the content of your `pages/` directory. If you're not using advanced custom routing, you won't have to make any modifications to `next.config.js`. Just run:

```bash
next build

next export
```

For an example, [check out this website](https://out-khozebgbnl.now.sh/) deployed statically to Vercel. The websites [source code](https://github.com/zeit/next.js/tree/canary/examples/basic-css) is available too.

## App Component

Next.js offers an extensibility point called [`_document.js`](https://github.com/zeit/next.js#custom-document). If defined, it lets you override the very top-level document of your application, which renders the `<html>` element.

`_document.js` allows for powerful extensibility, but it has some serious limitations. For example, React is not able to render `<html>` or `<body>` directly on the client side, so `_document.js` is mostly limited to the initial pre-rendering phase.

To enable some other powerful use cases, we're introducing `_app.js`, which is the top-level component that wraps the outside of each page.

![Some differences between `_document.js` and `_app.js`.](images/next_js-6-and-nextjs_org-vercel/img_001.jpg)Some differences between \`\_document.js\` and \`\_app.js\`.

Let's look at some use cases that defining `_app.js` enables.

### Page Transitions

![](images/next_js-6-and-nextjs_org-vercel/img_002.jpg)

Page transitions example: [\`page-transitions-app-next.now.sh\`](https://page-transitions-app-next.now.sh/) by [Xavier Cazalot](https://github.com/xavxyz) ( [Source](https://github.com/xavczen/nextjs-page-transitions))

In this example, each page can be independently accessed, pre-rendered and lazy-loaded. However, when we transition on the client side, smooth animations are possible.

### Better Apollo and Redux Integration

We already had [numerous examples](https://github.com/zeit/next.js/tree/canary/examples) of integrating data and state management frameworks like Apollo and Redux.

With `_app.js`, however, it's now even simpler to include these. Here are a few examples:

- [Apollo](https://apollo-app-next.now.sh/) ( [source code](https://github.com/zeit/next.js/tree/canary/examples/with-apollo))

- [Redux](https://redux-app-next.now.sh/) ( [source code](https://github.com/zeit/next.js/tree/canary/examples/with-redux))


### Better Error Handling

React offers a component method called `componentDidCatch` which enables you to capture and handle exceptions that bubble up from nested components on the client side.

In many cases, due to the unexpected nature of these exceptions, you might want to handle all of them equally at the top level.

`_app.js` is, therefore, a good place to define that `componentDidCatch` logic. Here's an [example](https://error-app-next.now.sh/) of error handling boundaries in action ( [source code](https://github.com/zeit/next.js/tree/canary/examples/with-componentdidcatch))

## Babel 7

We have upgraded Babel to its latest version: 7. With it comes some great new features and improvements.

### JSX Fragments

React 16.2 introduced the `Fragment` API, which allows you to express a list of elements without having to wrap them in an arbitrary HTML element like `<div>`:

```javascript
render() {

2  return <React.Fragment>

3    <A />,

4    <B />

5  </React.Fragment>

6}
```

Writing this can be tedious, with Next.js 6 you can use the new JSX fragment syntax to facilitate creating fragments:

```javascript
render() {

2  return <>

3    <A />,

4    <B />

5  </>

6}
```

### Nested .babelrc

If you have a directory nested in your Next.js applications that require a different Babel configuration, it's now possible to include a scoped `.babelrc` file specifically in that directory

```bash
src/

2    .babelrc      # General .babelrc

3  components/

4    i18n/

5      .babelrc  # This .babelrc only applies to this directory
```

### First-class TypeScript Support

When we announced [Universal webpack](https://vercel.com/blog/next5), we pointed out it was possible to use TypeScript via [ts-loader](https://github.com/TypeStrong/ts-loader), as we now run webpack both on the server and the client.

Babel 7 features built-in support for TypeScript (previously only Flow was supported by Babel).

To use it, just install the latest version of [@zeit/next-typescript](https://github.com/zeit/next-plugins/tree/master/packages/next-typescript/#readme) or check out [this example](https://github.com/zeit/next.js/tree/canary/examples/with-typescript).

## Nextjs.org

We are very happy to introduce the new [nextjs.org](https://nextjs.org/), built by Next.js core contributor [Jimmy Moon](https://twitter.com/ragingwind).

To start off, we highlight a sped-up video that shows you how to create a PWA with server-rendering from scratch in 5 minutes:

The opening video of \`nextjs.org\`

### One place for our documentation

When you need to look up something quickly, just head to [nextjs.org/docs](https://nextjs.org/docs):

![The documentation will always reflect the latest stable version ](images/next_js-6-and-nextjs_org-vercel/img_003.jpg)The documentation will always reflect the latest stable version

### Learn, step-by-step

Previously, we would recommend beginners to head to [https://learnnextjs.com](https://learnnextjs.com/) for a step-by-step guide (with quizzes!) on how to get started with Next.js

Now we've integrated it directly into [nextjs.org/learn](https://nextjs.org/learn) to make it even easier start learning:

![The easiest way to start learning Next.js](images/next_js-6-and-nextjs_org-vercel/img_004.jpg)The easiest way to start learning Next.js

### Get Inspired

We are now featuring a showcase of some nice-looking websites and applications built on Next.js. Head to [nextjs.org/showcase](https://nextjs.org/showcase) to get inspired, or [submit your own](https://github.com/zeit/next.js/issues/new?template=4.Nextjs.org_showcase.md)!

![Showcase of projects built with Next.js](images/next_js-6-and-nextjs_org-vercel/img_005.jpg)Showcase of projects built with Next.js