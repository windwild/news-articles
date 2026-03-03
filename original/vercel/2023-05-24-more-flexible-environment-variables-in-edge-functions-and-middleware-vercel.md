---
title: "More flexible Environment Variables in Edge Functions and Middleware - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/more-flexible-environment-variables-in-edge-functions-and-middleware"
date: "2023-05-24"
scraped_at: "2026-03-02T09:52:25.011949907+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




May 24, 2023

![](images/more-flexible-environment-variables-in-edge-functions-and-middleware-vercel/img_001.jpg)![](images/more-flexible-environment-variables-in-edge-functions-and-middleware-vercel/img_002.jpg)

You now have more flexible access and improved limits for environment variables from [Edge Functions](https://vercel.com/docs/concepts/functions/edge-functions) and [Middleware](https://vercel.com/docs/concepts/functions/edge-middleware):

- The max environment variable size is now 64KB instead of 5KB, [same as Serverless Functions](https://vercel.com/docs/concepts/limits/overview#functions-comparison).

- Other than the [reserved names](https://vercel.com/docs/concepts/projects/environment-variables/reserved-environment-variables), there are no additional restrictions to name environment variables.

- Accessing `process.env` is no longer restricted to be statically analyzable. This means that, for example, you can now compute variable names such as ``process.env[`${PREFIX}_SECRET`]``.


[Check out the documentation](https://vercel.com/docs/concepts/projects/environment-variables) to learn more.