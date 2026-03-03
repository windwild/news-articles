---
title: "Next.js Layouts RFC in 5 minutes - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/next-js-layouts-rfc-in-5-minutes"
date: "2022-09-14"
scraped_at: "2026-03-02T10:00:48.454809598+00:00"
language: "en"
translated: false
description: "Learn about the upcoming routing and layouts changes to Next.js."
---




Sep 14, 2022

The Next.js team at Vercel released the [Layouts RFC](https://nextjs.org/blog/layouts-rfc) a few months ago outlining the vision for the future of routing, layouts, and data fetching in the framework. The RFC is detailed and covers both basic and advanced features.

This post will cover the most important features of the upcoming Next.js changes landing in the next major version that you should be aware of.

## Creating Routes

In the new `app` directory, folders are used to define routes. To create a route, add a `page.js` file inside a folder. For example, `app/page.js`:

app/page.js

```jsx
export default function Page() {

2  return <h1>Hello, Next.js!</h1>

3}
```

A new Page inside the app directory.

A page (with the `page.js` naming convention) is UI that is unique to a specific route segment. In this instance, the route segment is `/` (or the [root segment](https://nextjs.org/blog/layouts-rfc#route-segments)).

![Each route segment is mapped to a corresponding segment in a URL path.](images/next_js-layouts-rfc-in-5-minutes-vercel/img_001.jpg)Each route segment is mapped to a corresponding segment in a URL path.

You can incrementally adopt the `app` directory from the existing `pages` directory.

## Creating Layouts

You can create nestable layouts that are shared across pages by adding `layout.js` files.

![Creating routes using pages and layouts.](images/next_js-layouts-rfc-in-5-minutes-vercel/img_002.jpg)Creating routes using pages and layouts.

To make your first layout, you will create a new file `app/layout.js`.

app/layout.js

```jsx
export default function RootLayout({ children }) {

2  return (

3    <html>

4      <head>

5        <title>Next.js Layouts RFC in 5 Minutes</title>

6      </head>

7      <body>{children}</body>

8    </html>

9  );

10}
```

Root layout inside the app directory.

`app/page.js` above will render as a child of `app/layout.js`:

```html
1<html>

2  <head>

3    <title>Next.js Layouts RFC in 5 Minutes</title>

4  </head>

5  <body>

6    <h1>Hello, Next.js!</h1>

7  </body>

8</html>
```

The rendered HTML output from the root layout and page.

## Sharing Layouts

Layouts can be shared across different pages. Every route in `app/` shares the same root layout, defined at `app/layout.js`. For example, if we created a new route segment `app/blog/page.js`:

app/blog/page.js

```jsx
export default function BlogPage() {

2  return <h1>Blog Posts</h1>

3}
```

Blog page inside the app directory.

This page would use the same root layout. `app/blog/page.js` would render as a child of `app/layout.js`.

```html
1<html>

2  <head>

3    <title>Next.js Layouts RFC in 5 Minutes</title>

4  </head>

5  <body>

6    <h1>Blog Posts</h1>

7  </body>

8</html>
```

The rendered HTML output from the root layout and blog page.

If we wanted a custom layout for this route segment, we would create a new layout at `app/blog/layout.js`. For example, maybe our blog needs a sidebar navigation layout:

app/blog/layout.js

```jsx
export default function BlogLayout({ children }) {

2  return (

3    <>

4      <aside>

5        <nav>...</nav>

6      </aside>

7      {children}

8    </>

9  )

10}


```

Layout specific to the blog route segment.

`app/blog/page.js`would render as a child of `app/layout.js` and `app/blog/layout.js`:

```html
1<html>

2  <head>

3    <title>Next.js Layouts RFC in 5 Minutes</title>

4  </head>

5  <body>

6    <aside>

7      <nav>...</nav>

8    </aside>

9    <h1>Blog Posts</h1>

10  </body>

11</html>
```

The rendered HTML output from the root layout, blog layout, and blog page.

Similarly, if we created a nested dynamic route `app/blog/[slug]/page.js` for an individual blog post, it would also use the same layouts:

app/blog/\[slug\]/page.js

```jsx
export default function IndividualBlogPost() {

2  return (

3    <main>

4      <h1>Routing with Next.js</h1>

5      <p>Lorem ipsum dolor sit amet</p>

6    </main>

7  )

8}
```

Page for a specific blog post, using a dynamic route.

```html
1<html>

2  <head>

3    <title>Next.js Layouts RFC in 5 Minutes</title>

4  </head>

5  <body>

6    <aside>

7      <nav>...</nav>

8    </aside>

9    <main>

10      <h1>Routing with Next.js</h1>

11      <p>Lorem ipsum dolor sit amet</p>

12    </main>

13  </body>

14</html>
```

Layout for the individual blog post page with a dynamic route.

## Loading & Error Boundaries

`loading.js` automatically wraps a page or nested segment in a React Suspense Boundary. Next.js will show your loading component immediately on the first load and again when navigating between sibling routes.

You can use this to create _meaningful_ loading UI for specifics part of your UI.

![The Next.js Loading UI creates a React Suspense boundary.](images/next_js-layouts-rfc-in-5-minutes-vercel/img_003.jpg)The Next.js Loading UI creates a React Suspense boundary.

`error.js` automatically wraps a page or nested segment in a [React Error Boundary](https://reactjs.org/docs/error-boundaries.html). Next.js will show your error component whenever an error in a subtree is caught.

![The Next.js Error UI creates a React error boundary.](images/next_js-layouts-rfc-in-5-minutes-vercel/img_004.jpg)The Next.js Error UI creates a React error boundary.

Use this to isolate errors to specific parts of an app, show specific error information, and attempt to recover.

## Route Groups

Route groups can be used to:

- Organize routes without affecting the URL path

- Opt a segment out of a layout

- Create multiple root layouts for sections of an app with a completely different UI


![You can exclude routes from layouts using route groups.](images/next_js-layouts-rfc-in-5-minutes-vercel/img_005.jpg)You can exclude routes from layouts using route groups.

## Summary

An example `app` directory using some of the above concepts would look as follows:

[Read the full Layouts RFC](https://nextjs.org/blog/layouts-rfc) and stay tuned for more information from the Next.js team at Vercel.