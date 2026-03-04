---
render_with_liquid: false
title: "More flexible Environment Variables in Edge Functions and Middleware - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/more-flexible-environment-variables-in-edge-functions-and-middleware"
date: "2023-05-24"
scraped_at: "2026-03-02T09:52:25.011949907+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

May 24, 2023

2023 年 5 月 24 日

![](images/more-flexible-environment-variables-in-edge-functions-and-middleware-vercel/img_001.jpg)![](images/more-flexible-environment-variables-in-edge-functions-and-middleware-vercel/img_002.jpg)

You now have more flexible access and improved limits for environment variables from [Edge Functions](https://vercel.com/docs/concepts/functions/edge-functions) and [Middleware](https://vercel.com/docs/concepts/functions/edge-middleware):

您现在可以从 [Edge Functions](https://vercel.com/docs/concepts/functions/edge-functions) 和 [Middleware](https://vercel.com/docs/concepts/functions/edge-middleware) 中更灵活地访问环境变量，并享有更高的配额限制：

- The max environment variable size is now 64KB instead of 5KB, [same as Serverless Functions](https://vercel.com/docs/concepts/limits/overview#functions-comparison).

- 环境变量的最大尺寸现已提升至 64 KB，此前为 5 KB，[与 Serverless Functions 相同](https://vercel.com/docs/concepts/limits/overview#functions-comparison)。

- Other than the [reserved names](https://vercel.com/docs/concepts/projects/environment-variables/reserved-environment-variables), there are no additional restrictions to name environment variables.

- 除 [保留名称](https://vercel.com/docs/concepts/projects/environment-variables/reserved-environment-variables) 外，环境变量的命名不再受其他额外限制。

- Accessing `process.env` is no longer restricted to be statically analyzable. This means that, for example, you can now compute variable names such as ``process.env[`${PREFIX}_SECRET`]``.

- 访问 `process.env` 不再要求必须能被静态分析。这意味着，例如，您现在可以动态计算变量名，如 ``process.env[`${PREFIX}_SECRET`]``。

[Check out the documentation](https://vercel.com/docs/concepts/projects/environment-variables) to learn more.

[查阅文档](https://vercel.com/docs/concepts/projects/environment-variables) 了解更多信息。