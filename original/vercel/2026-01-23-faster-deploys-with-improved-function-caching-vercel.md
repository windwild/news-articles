---
title: "Faster deploys with improved function caching - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/faster-deploys-with-improved-function-caching"
date: "2026-01-23"
scraped_at: "2026-03-02T09:22:13.444980515+00:00"
language: "en"
translated: false
description: "Functions are now cached more effectively during deployment, saving 400ms-5s per build. Python, Go, Ruby, Rust, and   standalone functions benefit most."
---




Jan 23, 2026

Function uploads are now skipped when code hasn't changed, reducing build times by 400-600ms on average and up to 5 seconds for larger builds.

Previously, deployment-specific environment variables like `VERCEL_DEPLOYMENT_ID` were included in the function payload, making every deployment unique even with identical code. These variables are now injected at runtime, allowing Vercel to recognize unchanged functions and skip redundant uploads.

This optimization applies to [Vercel Functions](https://vercel.com/docs/functions) without a framework, and projects using Python, Go, Ruby, and Rust. Next.js projects will receive the same improvement soon.

The optimization is applied automatically to all deployments with no configuration required.

Learn more about [functions](https://vercel.com/docs/functions) and [builds](https://vercel.com/docs/deployments/builds) in our documentation.