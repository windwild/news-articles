---
title: "Build and Function Logs now render ANSI color codes nicely - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/build-and-function-logs-now-render-ansi-color-codes-nicely"
date: "2020-12-03"
scraped_at: "2026-03-02T10:06:19.164389212+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Dec 3, 2020

![](images/build-and-function-logs-now-render-ansi-color-codes-nicely-vercel/img_001.jpg)

If the logs that your source code or your framework are exposing within the Build Step or within your Serverless Functions contain ANSI color codes for providing more clarity, Vercel previously directly printed them out in the respective views on the Dashboard.

As of today, however, all of those codes are automatically parsed within the Deployment View, which contains Build Logs on the main page, but also the logs for your Serverless Functions on the "Functions" tab.

In the example above, you can see that ANSI codes are now automatically rendered as the colors they are supposed to represent, which makes the text much easier to understand.