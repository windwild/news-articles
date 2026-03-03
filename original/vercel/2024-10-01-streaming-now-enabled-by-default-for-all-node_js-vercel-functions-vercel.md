---
title: "Streaming now enabled by default for all Node.js Vercel Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/streaming-now-enabled-by-default-for-all-node-js-vercel-functions"
date: "2024-10-01"
scraped_at: "2026-03-02T09:41:17.091861503+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Oct 1, 2024

[Streaming](https://vercel.com/docs/functions/streaming-functions) is now enabled by default for all [Vercel Functions running on Node.js](https://vercel.com/docs/functions/runtimes/node-js#using-the-node.js-runtime-with-serverless-functions) for Pro and Enterprise teams, marking the final step in [the plan we published on July 8th, 2024](https://vercel.com/changelog/vercel-functions-to-enable-streaming-by-default). This means Vercel Functions can now send data to the client as it’s generated, instead of waiting for the entire response.

The `VERCEL_FORCE_NODEJS_STREAMING` environment variable is no longer required—streaming is now applied automatically upon deployment.

**Logging changes:** Streaming responses [will alter the format and frequency of your runtime logs](https://vercel.com/docs/functions/streaming-functions#runtime-logs). If you are using Log Drains, check that your ingestion pipeline can process the new log format and increased log frequency.

Read our [blog post](https://vercel.com/blog/vercel-functions-streaming-to-be-framework-agnostic) and [documentation](https://vercel.com/docs/functions/streaming-functions) for more information.