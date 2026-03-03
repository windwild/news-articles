---
title: "Reduced build times for large projects - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/reduced-build-times-for-large-projects"
date: "2026-01-14"
scraped_at: "2026-03-02T09:22:49.560097483+00:00"
language: "en"
translated: false
description: "We've shipped optimizations that reduce build overhead, particularly for projects with many input files, large node_modules, or extensive build outputs."
---




Jan 14, 2026

We shipped build system optimizations that reduce overhead for projects with many input files, large `node_modules`, or large build outputs.

Expensive disk operations (large file detection and folder size calculations) are no longer on the critical path for successful builds. These calculations now only run when a build fails, or when you enable the `VERCEL_BUILD_SYSTEM_REPORT` environment variable.

Builds complete 2.8 seconds faster on average, with larger builds seeing improvements of up to 12 seconds.

See the [builds documentation](https://vercel.com/docs/builds) for details.