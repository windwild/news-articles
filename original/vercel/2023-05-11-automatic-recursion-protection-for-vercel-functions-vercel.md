---
title: "Automatic recursion protection for Vercel Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/automatic-recursion-protection-for-vercel-serverless-functions"
date: "2023-05-11"
scraped_at: "2026-03-02T09:52:36.019491817+00:00"
language: "en"
translated: false
description: "Vercel now has automatic recursion protection for Vercel Functions. This provides safety against your code inadvertently triggering itself repeatedly, incurring unintentional usage."
---




May 11, 2023

![](images/automatic-recursion-protection-for-vercel-functions-vercel/img_001.jpg)![](images/automatic-recursion-protection-for-vercel-functions-vercel/img_002.jpg)

Vercel now has automatic recursion protection for Vercel Functions.

This provides safety against your code inadvertently triggering itself repeatedly, incurring unintentional usage. Recursion protection supports using the `http` module or `fetch` in the Node.js runtime for Serverless Functions, both for user-defined code and dependencies. Requests using the bare `Socket` constructor are not protected against recursion.

Recursion protection is available free on all plans. It does not require any code changes in your application, but does require a new deployment. Outbound requests now include the `x-vercel-id` header of the request that originated the new fetch.

We’re continuing to invest in platform improvements to help developers [understand and monitor usage](https://vercel.com/changelog/usage-notification-settings-is-now-generally-available) and avoid unintended usage on the Vercel platform.