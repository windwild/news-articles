---
title: "Serverless Functions can now run up to 5 minutes - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/serverless-functions-can-now-run-up-to-5-minutes"
date: "2023-09-20"
scraped_at: "2026-03-02T09:50:39.992255909+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Sep 20, 2023

![](images/serverless-functions-can-now-run-up-to-5-minutes-vercel/img_001.jpg)![](images/serverless-functions-can-now-run-up-to-5-minutes-vercel/img_002.jpg)

Based on your feedback, we’re improving Serverless Functions as follows:

- Pro customers can now run longer functions for **up to 5 minutes.**

- Pro customers default function timeout will be reduced to 15 seconds on **October 1st.**


These changes help prevent unintentional function usage, unless [explicitly opted into](https://vercel.com/docs/functions/serverless-functions/runtimes#max-execution-duration) the longer function duration.

Beginning **October 1st**, all new projects will receive a default timeout of 15 seconds. In addition, any projects that have not had functions run for more than 15 seconds will have their default timeouts reduced to 15 seconds.

To avoid unexpected timeouts, any projects that have had functions running for longer than 15 seconds (less than 1% of traffic) **will not** have their defaults changed.

Existing defaults still apply for Hobby and Enterprise customers.

[Check out our documentation](https://vercel.com/docs/functions/serverless-functions/runtimes) to learn more.