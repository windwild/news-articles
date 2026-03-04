---
render_with_liquid: false
title: "Vercel now supports customizing platform error pages - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-now-supports-customizing-platform-error-pages"
date: "2026-01-23"
scraped_at: "2026-03-02T09:22:11.597633511+00:00"
language: "en-zh"
translated: true
description: "For Enterprise customers, Vercel now allows you to customize platform error pages with your own branded pages. This gives a consistent experience for 5xx errors, as visitors see the same design irresp..."
---
render_with_liquid: false
render_with_liquid: false

Jan 23, 2026

2026 年 1 月 23 日

You can now customize error pages for platform errors on Vercel, replacing generic error pages with your own branded experiences. Custom error pages display when Vercel encounters uncaught errors like function invocation timeouts or other [platform errors](https://vercel.com/docs/errors).

您现在可以在 Vercel 上自定义平台错误页面，以替代默认的通用错误页面，呈现您专属的品牌化体验。当 Vercel 遇到未捕获的错误（例如函数调用超时）或其他[平台错误](https://vercel.com/docs/errors)时，将显示您自定义的错误页面。

### How it works

### 工作原理

You can implement custom error pages using your framework’s conventions and Vercel will automatically locate them, for example with Next.js you can simply place a `500/page.tsx` or static `500.html` page in the `public` directory.

您可依据所用框架的约定实现自定义错误页面，Vercel 将自动识别这些页面。例如，在 Next.js 中，您只需在 `public` 目录下放置一个 `500/page.tsx` 文件，或一个静态的 `500.html` 文件即可。

To enrich error pages with request-specific context, you can use the following metadata tokens:

为在错误页面中注入与具体请求相关的信息，您可以使用以下元数据占位符：

- `::vercel:REQUEST_ID::` \- Contains the Vercel request ID  
- `::vercel:REQUEST_ID::` —— 包含 Vercel 请求 ID

- `::vercel:ERROR_CODE::` \- The specific error code e.g. `FUNCTION_INVOCATION_TIMEOUT`  
- `::vercel:ERROR_CODE::` —— 具体的错误代码，例如 `FUNCTION_INVOCATION_TIMEOUT`

500/page.tsx

`500/page.tsx`

```tsx
export default function CustomErrorPage() {

2  return (
```

3    <div className="flex min-h-screen flex-col items-center justify-center">

3    <div className="flex min-h-screen flex-col items-center justify-center">

4      <h1 className="text-4xl font-bold">500</h1>

4      <h1 className="text-4xl font-bold">500</h1>

5      <p className="mt-4 text-lg text-gray-600">Internal Server Error</p>

5      <p className="mt-4 text-lg text-gray-600">服务器内部错误</p>

6      <p className="mt-2 text-sm text-gray-500">

6      <p className="mt-2 text-sm text-gray-500">

7        Request ID: ::vercel:REQUEST_ID::

7        请求 ID：::vercel:REQUEST_ID::

8      </p>

8      </p>

9      <p className="mt-2 text-sm text-gray-500">

9      <p className="mt-2 text-sm text-gray-500">

10        Code: ::vercel:ERROR_CODE::

10        错误代码：::vercel:ERROR_CODE::

11      </p>

11      </p>

12      <p className="mt-2 text-sm text-gray-500">

12      <p className="mt-2 text-sm text-gray-500">

13        Something went wrong on our end. Please try again later.

13        我们这边出了点问题，请稍后再试。

14      </p>

14      </p>

15      <a href="/" className="mt-6 text-blue-600 hover:underline">

15      <a href="/" className="mt-6 text-blue-600 hover:underline">

16        Go back home

16        返回首页

17      </a>

17      </a>

18    </div>

18    </div>

19  );

19  );

20}
```

20}
```

We strongly recommend including the request ID and error code to aid debugging and support investigations.

我们强烈建议在排查问题和支持调查时提供请求 ID 和错误代码。

This feature is available for Enterprise teams and enabled automatically across all projects. No additional configuration required.

该功能面向 Enterprise 团队提供，并已在所有项目中自动启用，无需额外配置。

See the [documentation](http://vercel.com/docs/custom-error-pages) to get started or reference the following implementations: [Custom error pages with App Router](https://github.com/vercel/examples/tree/main/cdn/custom-error-pages-app-dir/) or [Custom error pages with public directory](https://github.com/vercel/examples/tree/main/cdn/custom-error-pages-public-dir/).

请参阅[文档](http://vercel.com/docs/custom-error-pages)开始使用，或参考以下实现示例：[使用 App Router 的自定义错误页面](https://github.com/vercel/examples/tree/main/cdn/custom-error-pages-app-dir/) 或 [使用 public 目录的自定义错误页面](https://github.com/vercel/examples/tree/main/cdn/custom-error-pages-public-dir/)。