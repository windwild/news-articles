---
title: "Next.js Layouts RFC in 5 minutes - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/next-js-layouts-rfc-in-5-minutes"
date: "2022-09-14"
scraped_at: "2026-03-02T10:00:48.454809598+00:00"
language: "en-zh"
translated: true
description: "Learn about the upcoming routing and layouts changes to Next.js."
---
{% raw %}

Sep 14, 2022

2022 年 9 月 14 日

Vercel 的 Next.js 团队几个月前发布了 [Layouts RFC](https://nextjs.org/blog/layouts-rfc)，概述了该框架在路由、布局和数据获取方面的未来发展方向。该 RFC 内容详尽，涵盖了从基础到高级的各项功能。

本文将重点介绍即将在 Next.js 下一个主要版本中落地的最重要更新，这些更新值得你重点关注。

## Creating Routes

## 创建路由

在新的 `app` 目录中，文件夹用于定义路由。要创建一个路由，只需在某个文件夹内添加一个 `page.js` 文件即可。例如，`app/page.js`：

app/page.js

```jsx
export default function Page() {

2  return <h1>Hello, Next.js!</h1>

3}
```

位于 `app` 目录中的一个新页面。

A page (with the `page.js` naming convention) is UI that is unique to a specific route segment. In this instance, the route segment is `/` (or the [root segment](https://nextjs.org/blog/layouts-rfc#route-segments)).

一个页面（遵循 `page.js` 命名约定）是专属于某一特定路由段的用户界面。本例中，该路由段为 `/`（即 [根路由段](https://nextjs.org/blog/layouts-rfc#route-segments)）。

![Each route segment is mapped to a corresponding segment in a URL path.](images/next_js-layouts-rfc-in-5-minutes-vercel/img_001.jpg)  
![每个路由段都映射到 URL 路径中的对应路径段。](images/next_js-layouts-rfc-in-5-minutes-vercel/img_001.jpg)  

Each route segment is mapped to a corresponding segment in a URL path.

每个路由段都映射到 URL 路径中的对应路径段。

You can incrementally adopt the `app` directory from the existing `pages` directory.

你可以从现有的 `pages` 目录出发，逐步迁移到新的 `app` 目录。

## Creating Layouts

## 创建布局

You can create nestable layouts that are shared across pages by adding `layout.js` files.

你可通过添加 `layout.js` 文件，创建可在多个页面间共享的、支持嵌套的布局。

![Creating routes using pages and layouts.](images/next_js-layouts-rfc-in-5-minutes-vercel/img_002.jpg)  
![使用页面和布局创建路由。](images/next_js-layouts-rfc-in-5-minutes-vercel/img_002.jpg)  

Creating routes using pages and layouts.

使用页面和布局创建路由。

To make your first layout, you will create a new file `app/layout.js`.

要创建你的第一个布局，请新建一个文件 `app/layout.js`。

app/layout.js

`app/layout.js`

```jsx
export default function RootLayout({ children }) {

2  return (

3    <html>

4      <head>

5        <title>Next.js 布局 RFC：五分钟入门</title>

6      </head>

7      <body>{children}</body>

8    </html>

9  );

10}
```

位于 `app` 目录内的根布局（Root layout）。

上述 `app/page.js` 将作为 `app/layout.js` 的子组件进行渲染。

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

根布局与页面所渲染出的 HTML 输出。

## Sharing Layouts

## 共享布局

Layouts can be shared across different pages.

布局可以在不同页面之间共享。

Every route in `app/` shares the same root layout, defined at `app/layout.js`.

`app/` 目录下的每个路由都共享同一个根布局，该布局定义在 `app/layout.js` 中。

For example, if we created a new route segment `app/blog/page.js`:

例如，如果我们创建一个新的路由段 `app/blog/page.js`：

app/blog/page.js

app/blog/page.js

```jsx
export default function BlogPage() {

2  return <h1>Blog Posts</h1>

3}
```

```jsx
export default function BlogPage() {

2  return <h1>博客文章</h1>

3}
```

Blog page inside the app directory.

位于 `app` 目录中的博客页面。

This page would use the same root layout. `app/blog/page.js` would render as a child of `app/layout.js`.

该页面将使用相同的根布局。`app/blog/page.js` 将作为 `app/layout.js` 的子组件进行渲染。

```html
1<html>

2  <head>

3    <title>Next.js Layouts RFC in 5 Minutes</title>
```

```html
1<html>

2  <head>

3    <title>五分钟了解 Next.js 布局（RFC）</title>
```

4  </head>

4  </head>

5  <body>

5  <body>

6    <h1>Blog Posts</h1>

6    <h1>博客文章</h1>

7  </body>

7  </body>

8</html>
```

8</html>
```

The rendered HTML output from the root layout and blog page.

根布局与博客页面共同渲染出的 HTML 输出。

If we wanted a custom layout for this route segment, we would create a new layout at `app/blog/layout.js`. For example, maybe our blog needs a sidebar navigation layout:

如果希望为此路由段使用自定义布局，我们需在 `app/blog/layout.js` 处新建一个布局文件。例如，我们的博客可能需要带侧边栏导航的布局：

app/blog/layout.js

app/blog/layout.js

```jsx
export default function BlogLayout({ children }) {

2  return (
```

3    <>

4      <aside>

5        <nav>...</nav>

6      </aside>

7      {children}

8    </>

9  )

10}

```

专用于博客路由片段的布局。

`app/blog/page.js` would render as a child of `app/layout.js` and `app/blog/layout.js`:

`app/blog/page.js` 将作为 `app/layout.js` 和 `app/blog/layout.js` 的子组件进行渲染：

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
```

10  </body>

10  </body>

11</html>

11</html>
```

The rendered HTML output from the root layout, blog layout, and blog page.

根布局、博客布局及博客页面所生成的 HTML 输出结果。

Similarly, if we created a nested dynamic route `app/blog/[slug]/page.js` for an individual blog post, it would also use the same layouts:

同样地，如果我们为单篇博客文章创建一个嵌套的动态路由 `app/blog/[slug]/page.js`，它也将复用相同的布局：

app/blog/\[slug\]/page.js

app/blog/\[slug\]/page.js

```jsx
export default function IndividualBlogPost() {

2  return (

3    <main>

4      <h1>Routing with Next.js</h1>

5      <p>Lorem ipsum dolor sit amet</p>

```jsx
export default function IndividualBlogPost() {

2  return (

3    <main>

4      <h1>使用 Next.js 进行路由</h1>

5      <p> Lorem ipsum dolor sit amet（此处为拉丁文占位文本）</p>

6    </main>

6    </main>

7  )

7  )

8}

8}

```

Page for a specific blog post, using a dynamic route.

```

特定博客文章的页面，使用动态路由。

```html
1<html>

1<html>

2  <head>

2  <head>

3    <title>Next.js Layouts RFC in 5 Minutes</title>

3    <title>5 分钟了解 Next.js Layouts RFC</title>

4  </head>

4  </head>

5  <body>

5  <body>

6    <aside>

6    <aside>

7      `<nav>...</nav>`

7      `<nav>...</nav>`

8    `</aside>`

8    `</aside>`

9    `<main>`

9    `<main>`

10      `<h1>Routing with Next.js</h1>`

10      `<h1>使用 Next.js 进行路由</h1>`

11      `<p>Lorem ipsum dolor sit amet</p>`

11      `<p> lorem ipsum dolor sit amet（示例文本）</p>`

12    `</main>`

12    `</main>`

13  `</body>`

13  `</body>`

14`</html>`
```

14`</html>`
```

Layout for the individual blog post page with a dynamic route.

具有动态路由的单篇博客文章页面布局。

## Loading & Error Boundaries

## 加载与错误边界

`loading.js` automatically wraps a page or nested segment in a React Suspense Boundary. Next.js will show your loading component immediately on the first load and again when navigating between sibling routes.

`loading.js` 会自动将一个页面或嵌套段包裹在 React Suspense 边界（Suspense Boundary）中。Next.js 将在首次加载时立即显示你的加载组件，并在用户于同级路由间导航时再次显示。

You can use this to create _meaningful_ loading UI for specifics part of your UI.

你可以利用此功能，为 UI 中特定部分创建**有意义的**加载界面。

![The Next.js Loading UI creates a React Suspense boundary.](images/next_js-layouts-rfc-in-5-minutes-vercel/img_003.jpg)  
![Next.js 加载界面创建了一个 React Suspense 边界。](images/next_js-layouts-rfc-in-5-minutes-vercel/img_003.jpg)  
The Next.js Loading UI creates a React Suspense boundary.  
Next.js 加载界面创建了一个 React Suspense 边界。

`error.js` automatically wraps a page or nested segment in a [React Error Boundary](https://reactjs.org/docs/error-boundaries.html). Next.js will show your error component whenever an error in a subtree is caught.

`error.js` 会自动将一个页面或嵌套段包裹在 [React 错误边界（Error Boundary）](https://reactjs.org/docs/error-boundaries.html) 中。每当子树中捕获到错误时，Next.js 就会显示你定义的错误组件。

![The Next.js Error UI creates a React error boundary.](images/next_js-layouts-rfc-in-5-minutes-vercel/img_004.jpg)  
![Next.js 错误界面创建了一个 React 错误边界。](images/next_js-layouts-rfc-in-5-minutes-vercel/img_004.jpg)  
The Next.js Error UI creates a React error boundary.  
Next.js 错误界面创建了一个 React 错误边界。

Use this to isolate errors to specific parts of an app, show specific error information, and attempt to recover.

利用此功能，你可以将错误隔离至应用的特定部分，展示有针对性的错误信息，并尝试恢复。

## Route Groups

## 路由分组（Route Groups）

Route groups can be used to:

路由分组可用于：

- Organize routes without affecting the URL path  

- 在不改变 URL 路径的前提下组织路由  

- Opt a segment out of a layout  

- 将某个段从布局中排除（即绕过该布局）

- Create multiple root layouts for sections of an app with a completely different UI

- 为应用中具有完全不同的用户界面（UI）的各个部分创建多个根布局。

![You can exclude routes from layouts using route groups.](images/next_js-layouts-rfc-in-5-minutes-vercel/img_005.jpg)  
你可以通过路由组（route groups）将某些路由从布局中排除。

## Summary

## 总结

一个使用上述部分概念的示例 `app` 目录结构如下所示：

[Read the full Layouts RFC](https://nextjs.org/blog/layouts-rfc) and stay tuned for more information from the Next.js team at Vercel.  
[阅读完整的《布局 RFC》文档](https://nextjs.org/blog/layouts-rfc)，并持续关注 Vercel 的 Next.js 团队发布的更多信息。
{% endraw %}
